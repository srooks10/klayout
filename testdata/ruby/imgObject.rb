
$:.push(File::dirname($0))

load("test_prologue.rb")

class IMG_TestClass < TestBase

  def test_1

    dm = RBA::ImageDataMapping.new 
    dm.gamma = 0.5
    assert_equal(dm.gamma, 0.5)
    dm.brightness = 0.25
    assert_equal(dm.brightness, 0.25)
    dm.contrast = -0.125
    assert_equal(dm.contrast, -0.125)
    dm.red_gain = 1.25
    assert_equal(dm.red_gain, 1.25)
    dm.green_gain = 1.125
    assert_equal(dm.green_gain, 1.125)
    dm.blue_gain = 0.125
    assert_equal(dm.blue_gain, 0.125)

    assert_equal(dm.num_colormap_entries, 2)
    assert_equal(dm.colormap_color(0) & 0xffffff, 0x000000)
    assert_equal(dm.colormap_color(1) & 0xffffff, 0xffffff)

    dm.clear_colormap
    assert_equal(dm.num_colormap_entries, 0)
    dm.add_colormap_entry(0, 0x123456);
    dm.add_colormap_entry(0.5, 0xff0000);
    dm.add_colormap_entry(1.0, 0x00ff00);
    assert_equal(dm.num_colormap_entries, 3)
    assert_equal(dm.colormap_color(0) & 0xffffff, 0x123456)
    assert_equal(dm.colormap_value(0), 0.0)
    assert_equal(dm.colormap_color(1) & 0xffffff, 0xff0000)
    assert_equal(dm.colormap_value(1), 0.5)
    assert_equal(dm.colormap_color(2) & 0xffffff, 0x00ff00)
    assert_equal(dm.colormap_value(2), 1.0)

  end

  def test_2

    image = RBA::Image.new 
    assert_equal(image.to_s, "empty:")
    assert_equal(image.is_empty?, true)

    image = RBA::Image.new(2, 3, [])
    assert_equal(image.to_s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")

    image = RBA::Image.new(2, 3, [], [], [])
    assert_equal(image.to_s, "color:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;]")

    data = [0.0, 0.5, 1.5, 2.5, 10, 20]
    image = RBA::Image.new(2, 3, data)
    assert_equal(image.to_s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0.5;1.5;2.5;10;20;]")

    data2 = [1.0, 1.5, 2.5, 3.5]
    image = RBA::Image.new(2, 3, data, data2, [])
    assert_equal(image.to_s, "color:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;20,0,0;]")

    t = RBA::DCplxTrans.new(2.5, 90, false, RBA::DPoint.new(1, 5))

    image = RBA::Image.new(2, 3, t, [])
    assert_equal(image.to_s, "mono:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")

    image = RBA::Image.new(2, 3, t, [], [], [])
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;]")

    data = [0.0, 0.5, 1.5, 2.5, 10, 20]
    data2 = [1.0, 1.5, 2.5, 3.5]

    image = RBA::Image.new(2, 3, t, data)
    assert_equal(image.to_s, "mono:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0.5;1.5;2.5;10;20;]")
    assert_equal(image.is_empty?, false)
    assert_equal(image.is_color?, false)

    ii = image.dup
    assert_equal(ii.to_s, "mono:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0.5;1.5;2.5;10;20;]")
    assert_equal(ii.mask(1, 2), true)
    assert_equal(ii.to_s, "mono:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0.5;1.5;2.5;10;20;]")
    image.set_mask(1, 2, false)
    assert_equal(ii.to_s, "mono:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1;0.5,1;1.5,1;2.5,1;10,1;20,0;]")
    assert_equal(ii.mask(1, 2), false)
    image.set_mask(1, 2, true)
    assert_equal(ii.mask(1, 2), true)

    image.set_data(2, 3, data, data2, [])
    copy1 = image.dup
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;20,0,0;]")

    image = RBA::Image.new(2, 3, t, data, data2, [])
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;20,0,0;]")
    assert_equal(image.is_empty?, false)
    assert_equal(image.is_color?, true)

    image.set_pixel(1, 2, 100, 200, 300)
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;100,200,300;]")
    assert_equal(image.get_pixel(1, 2, 0), 100)
    assert_equal(image.get_pixel(1, 2, 1), 200)
    assert_equal(image.get_pixel(1, 2, 2), 300)

    image.set_data(2, 3, data)
    assert_equal(image.to_s, "mono:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0.5;1.5;2.5;10;20;]")

    assert_equal(image.width, 2);
    assert_equal(image.height, 3);
    assert_equal(image.box.to_s, "(-6.5,5;1,10)")
    image.pixel_width = 1
    image.pixel_height = 1
    image.trans = RBA::DCplxTrans.new
    assert_equal(image.box.to_s, "(0,0;2,3)")
    image.pixel_width = 4
    image.pixel_height = 5
    image.trans = RBA::DCplxTrans.new
    assert_equal(image.box.to_s, "(0,0;8,15)")
    assert_equal(image.pixel_width, 4)
    assert_equal(image.pixel_height, 5)

    image = image.transformed_cplx(RBA::DCplxTrans.new(1, 0, false, RBA::DPoint.new(1, 2))) 
    assert_equal(image.box.to_s, "(1,2;9,17)")
    assert_equal(image.trans.to_s, "r0 *1 1,2")
    assert_equal(image.matrix.to_s, "(4,0,5) (0,5,9.5) (0,0,1)")

    assert_equal(image.filename, "")

    if false 
      image = RBA::Image.new("/home/matthias/a.png")
      assert_equal(image.trans.to_s, "r0 *1 0,0")
      assert_equal(image.width, 728)
      assert_equal(image.height, 762)
      assert_equal(image.filename, "/home/matthias/a.png")
      
      image = RBA::Image.new("/home/matthias/a.png", t)
      assert_equal(image.trans.to_s, "r90 *2.5 1,5")
      assert_equal(image.width, 728)
      assert_equal(image.height, 762)
    end
    
    image.min_value = -12.5
    assert_equal(image.min_value, -12.5)
    image.max_value = 12.5
    assert_equal(image.max_value, 12.5)
    assert_equal(image.id != 0, true)

    image = copy1
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;20,0,0;]")

    dm = image.data_mapping.dup
    dm.brightness=0.5
    image.data_mapping = dm
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0.5;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;20,0,0;]")

    assert_equal(image.is_visible?, true)
    image.visible = false
    assert_equal(image.is_visible?, false)
    assert_equal(image.to_s, "color:matrix=(0,-2.5,-2.75) (2.5,0,7.5) (0,0,1);min_value=0;max_value=1;is_visible=false;z_position=0;brightness=0.5;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0,1,0;0.5,1.5,0;1.5,2.5,0;2.5,3.5,0;10,0,0;20,0,0;]")

  end

  def test_3

    # compatibility with 0.21
    d = []
    20000.times { d.push(0.0) }
    image = RBA::Image.new(100, 200, d)
    image.pixel_width = 1
    image.pixel_height = 2
    image.trans = RBA::DCplxTrans::new(1.5, 90, true, RBA::DPoint::new(-50, -100))
    assert_equal(image.box.to_s, "(-50,-100;550,50)")
    assert_equal(image.pixel_width.to_s, "1.5")
    assert_equal(image.pixel_height.to_s, "3.0")
    assert_equal(image.trans.to_s, "m45 *1 -50,-100")

  end

  def test_4

    mw = RBA::Application.instance.main_window
    mw.close_all
    mw.create_layout(0)
    view = mw.current_view

    iac = 0
    ic = [] 
    isc = 0
    view.on_images_changed { iac += 1 }
    view.on_image_changed { |id| ic << id }
    view.on_image_selection_changed { isc += 1 }

    image = RBA::Image.new(2, 3, [])
    assert_equal(image.is_valid?, false)
    assert_equal(image.to_s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")

    count = 0
    view.each_image { |i| count += 1 }
    assert_equal(count, 0)

    view.insert_image(image)
    assert_equal(iac, 1)
    assert_equal(ic, [])
    assert_equal(isc, 0 )
    assert_equal(image.is_valid?, true)
    assert_equal(view.image(-1).is_valid?, false )
    assert_equal(view.image(image.id).is_valid?, true )
    assert_equal(view.image(image.id).to_s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")

    s = ""
    count = 0
    view.each_image { |i| count += 1; s += i.to_s }
    assert_equal(count, 1)
    assert_equal(s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")

    image.z_position = 1
    assert_equal(image.z_position, 1)
    s = ""
    view.each_image { |i| s += i.to_s }
    assert_equal(s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=0;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")
    # view updates are deferred - hence this:
    RBA::Application::instance.process_events
    s = ""
    view.each_image { |i| s += i.to_s }
    assert_equal(s, "mono:matrix=(1,0,0) (0,1,0) (0,0,1);min_value=0;max_value=1;is_visible=true;z_position=1;brightness=0;contrast=0;gamma=1;red_gain=1;green_gain=1;blue_gain=1;color_mapping=[0,'#000000';1,'#ffffff';];width=2;height=3;data=[0;0;0;0;0;0;]")

    # NOTE: the on_images_changed event is not intended, but a side effect of the change currently
    assert_equal(iac, 2)
    assert_equal(ic, [ image.id ])
    # NOTE: the on_image_selection_changed event is not intended, but a side effect of the change currently
    assert_equal(isc, 1 )

    view.clear_images
    count = 0
    view.each_image { |i| count += 1 }
    assert_equal(count, 0)

    image = RBA::Image.new(2, 3, [])
    image2 = RBA::Image.new(20, 30, [])

    view.insert_image(image)
    view.insert_image(image2)

    wsum = 0
    hsum = 0
    view.each_image { |i| wsum += i.width; hsum += i.height }
    assert_equal(wsum, 22)
    assert_equal(hsum, 33)

    view.erase_image(image.id)

    wsum = 0
    hsum = 0
    view.each_image { |i| wsum += i.width; hsum += i.height }
    assert_equal(wsum, 20)
    assert_equal(hsum, 30)

    new_image2 = RBA::Image.new(12, 13, [])
    view.replace_image(image2.id, new_image2)

    wsum = 0
    hsum = 0
    view.each_image { |i| wsum += i.width; hsum += i.height }
    assert_equal(wsum, 12)
    assert_equal(hsum, 13)

    visible = 0
    total = 0
    view.each_image { |i| visible += 1 if i.is_visible?; total += 1 }
    assert_equal(visible, 1)
    assert_equal(total, 1)

    view.show_image(new_image2.id, false)

    visible = 0
    total = 0
    view.each_image { |i| visible += 1 if i.is_visible?; total += 1 }
    assert_equal(visible, 0)
    assert_equal(total, 1)

    image2 = RBA::Image.new(1, 4, [])
    view.insert_image(image2)

    visible = 0
    total = 0
    view.each_image { |i| visible += 1 if i.is_visible?; total += 1 }
    assert_equal(visible, 1)
    assert_equal(total, 2)

    image2.visible = false

    visible = 0
    total = 0
    view.each_image { |i| visible += 1 if i.is_visible?; total += 1 }
    assert_equal(visible, 1)
    assert_equal(total, 2)

    # view updates are deferred - hence this:
    RBA::Application::instance.process_events

    visible = 0
    total = 0
    view.each_image { |i| visible += 1 if i.is_visible?; total += 1 }
    assert_equal(visible, 0)
    assert_equal(total, 2)

    view.each_image { |i| i.delete }

    visible = 0
    total = 0
    view.each_image { |i| visible += 1 if i.is_visible?; total += 1 }
    assert_equal(visible, 0)
    assert_equal(total, 0)

    mw.close_all

  end

end

load("test_epilogue.rb")
