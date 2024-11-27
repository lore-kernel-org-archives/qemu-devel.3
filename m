Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E233D609CC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 10:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGF5Y-0007ne-Og; Wed, 27 Nov 2024 05:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGF5V-0007mx-7F
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:16:01 -0500
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGF5S-0000nq-RN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 05:16:00 -0500
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-85715f21c82so1642168241.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 02:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732702557; x=1733307357;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a+hUjgE0CAKr3uN/Dtmw/JvDmx8Fmd9e/oWNu/3aw0I=;
 b=quRKOzs9L6miRvXx0Boj5u22U/w7X4vUtTvtJ9xafc1uy0jL/x/km4y6JTDi4AJQbe
 9tN8C16+U3eys+tby5/elhoIAnfLpc2kSNVl9+PIUSMt9umv9s/3cwFgtbFDLWhFVKnS
 3irkOXQwBUaWxc0wQSGW2wrS9G1MK/Xi/Mfjj2Lb67j4qvqL7eyOPt7HU1IiGyjD8tWZ
 MIPXFsVAVEeD/d8P2D6cX3IltbQGISnaHFrjbjHCRTJnVWqBrqlAcUB7N2uOx2nvhVpr
 CrBI7ojKfN4h+0ZKT67ZIvnSjIDrmysrM3MbdjI0AyASc0lYVOos71AcY3ODgD3X6JCz
 HV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732702557; x=1733307357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+hUjgE0CAKr3uN/Dtmw/JvDmx8Fmd9e/oWNu/3aw0I=;
 b=sqKCVArgYwZl09TjTJsny0hnLIc6NwwPfpyjmGa0QYNWYS8W2irckKgYxa3kkv1atM
 1VpL9TGM32sHsa6NplqSwHJl5Q/QrKBklEIE0TcdOxU+h9JCHkhoSNQGsPVGQRWbvKrW
 7CCOPEjedi0NmgNIxMJzUE2MhC1s8muITPbCpqMbDgOUXW2x2yrGE0uFHr+AkdQIG9pi
 uXIgmNhKyw7h+zkGL3MBKtptX3z0ZPpaS/2BegrGqrFEwCtvH1xuP5Rdfub6qWWaYyvD
 c8ph9zoyufQX8ZO7d9ALJ6EwGWt6Ak6npnPJUYDWp1w7xjoMbpTT295WtJHYC1kpO+NE
 qamw==
X-Gm-Message-State: AOJu0YzNpNfsnEkvBU8d5nRB+XA19qC6bWakmAZjiszYVNWD1APZjZgQ
 1/KXKWfmcCofS65LvMazlGn+GC2GFNBWdK8/rxpznqbbBMIujOYF1WZdqVg9f2eSs0zWcDC7vpe
 df2j3+7h1hzjHB6EJlZbNUmnBC+mEMBq1YNaV
X-Gm-Gg: ASbGncvyhwoCn8ur+uL5nCA9gdMrcmNjyPKpnpAJszOPROH02SGIuqdXzijYYVtganc
 KpeByS0Fs1RlfFnr7de+ZARecU4O33CM=
X-Google-Smtp-Source: AGHT+IFgjY36JnK09rmFyiajWqpeOxB3eDmi9qLbqNMN/yVrN5bnGljZh7MYQHi7pWDUtQnghy8METpiIcYnbCxfcsE=
X-Received: by 2002:a05:6102:1899:b0:4af:469b:d3b8 with SMTP id
 ada2fe7eead31-4af469bd4d8mr1776569137.25.1732702556966; Wed, 27 Nov 2024
 02:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20241113142343.40832-1-phil@philjordan.eu>
 <20241113142343.40832-3-phil@philjordan.eu>
 <c2fed303-b79b-4a1b-b360-914522125650@daynix.com>
In-Reply-To: <c2fed303-b79b-4a1b-b360-914522125650@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 27 Nov 2024 11:15:46 +0100
Message-ID: <CAAibmn0PR=om9pEgbnp6iJsnP56ro10M+YZkEhv-5T92y6QcKA@mail.gmail.com>
Subject: Re: [PATCH v10 02/15] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000068e8c00627e24015"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92b;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000068e8c00627e24015
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 07:45, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> > +    s->pgdev = PGNewDeviceWithDescriptor(desc);
> > +
> > +    disp_desc = apple_gfx_prepare_display_descriptor(s);
> > +    s->pgdisp = [s->pgdev newDisplayWithDescriptor:disp_desc
> > +                                              port:0 serialNum:1234];
>
> port has a fixed number, but I don't think there is anything that
> prevents plugging multiple apple-gfx devices.
>

The port number is PGDevice instance specific, so 0 is safe here. I've
actually now tested with 2 apple-gfx-pci devices, and it's technically
possible and the guest picks them both up. But it's actually the serial
number that ends up being a problem, because macOS ignores "duplicate"
displays with identical vendor/product/serial number tuples.

So I suggest a static integer variable for the display serial number that
we initialise to 1 and increment every time an apple-gfx device is realized.


> > +    [disp_desc release];
> > +    s->pgdisp.modeList = apple_gfx_prepare_display_mode_array();
> > +
> > +    s->con = graphic_console_init(dev, 0, &apple_gfx_fb_ops, s);
> > +    return true;
> > +}
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 20a94973fa2..cf9e6dd35d2 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -61,6 +61,12 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
> files('artist.c'))
> >
> >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> 'ati_2d.c', 'ati_dbg.c'), pixman])
> >
> > +if host_os == 'darwin'
> > +  system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> [files('apple-gfx.m'), pvg, metal])
> > +  if cpu == 'aarch64'
> > +    system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
> [files('apple-gfx-mmio.m'), pvg, metal])
> > +  endif
> > +endif
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >     virtio_gpu_ss = ss.source_set()
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index d26d663f963..a50e4eea0c0 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) "dest_width :
> %u"
> >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> > +
> > +# apple-gfx.m
> > +apple_gfx_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64"
> res=0x%"PRIx64
> > +apple_gfx_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64"
> val=0x%"PRIx64
> > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x
> base_addr=%p"
> > +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions)
> "task=%p, task->mapped_regions->len=%u"
> > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
> virtual_offset, uint32_t read_only) "task=%p range_count=0x%x
> virtual_offset=0x%"PRIx64" read_only=%d"
> > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t
> phys_len) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64
> > +apple_gfx_remap(uint64_t retval, void *source_ptr, uint64_t target)
> "retval=%"PRId64" source=%p target=0x%"PRIx64
> > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t
> length) "task=%p virtual_offset=0x%"PRIx64" length=0x%"PRIx64
> > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void
> *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
> > +apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
> > +apple_gfx_new_frame(void) ""
> > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64" y=%"PRId64
> > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height)
> "bpp=%d width=%"PRId64" height=0x%"PRId64
> > +apple_gfx_cursor_show(uint32_t show) "show=%d"
> > +apple_gfx_cursor_move(void) ""
> > +apple_gfx_common_init(const char *device_name, size_t mmio_size)
> "device: %s; MMIO size: %zu bytes"
> > +
> > +# apple-gfx-mmio.m
> > +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res)
> "offset=0x%"PRIx64" res=0x%"PRIx64
> > +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val)
> "offset=0x%"PRIx64" val=0x%"PRIx64
> > +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro,
> void *va, void *e, void *f, void* va_result) "phys=0x%"PRIx64"
> len=0x%"PRIx64" ro=%d va=%p e=%p f=%p -> *va=%p"
> > +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_t
> start, uint64_t end) "index=%zu, region=%p, 0x%"PRIx64"-0x%"PRIx64
> > +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void
> *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
> > +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) "unmapping
> @ %p from memory region %p"
> > +apple_gfx_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
> > +
> > diff --git a/meson.build b/meson.build
> > index e0b880e4e13..3c61238bc77 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -794,6 +794,8 @@ socket = []
> >   version_res = []
> >   coref = []
> >   iokit = []
> > +pvg = not_found
> > +metal = []
> >   emulator_link_args = []
> >   midl = not_found
> >   widl = not_found
> > @@ -815,6 +817,8 @@ elif host_os == 'darwin'
> >     coref = dependency('appleframeworks', modules: 'CoreFoundation')
> >     iokit = dependency('appleframeworks', modules: 'IOKit', required:
> false)
> >     host_dsosuf = '.dylib'
> > +  pvg = dependency('appleframeworks', modules:
> 'ParavirtualizedGraphics')
> > +  metal = dependency('appleframeworks', modules: 'Metal')
> >   elif host_os == 'sunos'
> >     socket = [cc.find_library('socket'),
> >               cc.find_library('nsl'),
>
>

--00000000000068e8c00627e24015
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, 27 Nov 2024 at 07:45, Akihiko Odaki &lt;<a href=3D"mailt=
o:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 s-&gt;pgdev =3D PGNewDeviceWithDescriptor(desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 disp_desc =3D apple_gfx_prepare_display_descriptor(s);<=
br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp =3D [s-&gt;pgdev newDisplayWithDescriptor:=
disp_desc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 port:0 serialNum:1234];<br>
<br>
port has a fixed number, but I don&#39;t think there is anything that <br>
prevents plugging multiple apple-gfx devices.<br></blockquote><div><br></di=
v><div>The port number is PGDevice instance specific, so 0 is safe here. I&=
#39;ve actually now tested with 2 apple-gfx-pci devices, and it&#39;s techn=
ically possible and the guest picks them both up. But it&#39;s actually the=
 serial number that ends up being a problem, because macOS ignores &quot;du=
plicate&quot; displays with identical vendor/product/serial number tuples.<=
/div><div><br></div><div>So I suggest a static integer variable for the dis=
play serial number that we initialise to 1 and increment every time an appl=
e-gfx device is realized.<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 [disp_desc release];<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D apple_gfx_prepare_display_mod=
e_array();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_init(dev, 0, &amp;apple_g=
fx_fb_ops, s);<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index 20a94973fa2..cf9e6dd35d2 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -61,6 +61,12 @@ system_ss.add(when: &#39;CONFIG_ARTIST&#39;, if_tru=
e: files(&#39;artist.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ATI_VGA&#39;, if_true: [fi=
les(&#39;ati.c&#39;, &#39;ati_2d.c&#39;, &#39;ati_dbg.c&#39;), pixman])<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +if host_os =3D=3D &#39;darwin&#39;<br>
&gt; +=C2=A0 system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if_true: [files(&#39;apple-gfx.m&#39;), pvg, metal])<br>
&gt; +=C2=A0 if cpu =3D=3D &#39;aarch64&#39;<br>
&gt; +=C2=A0 =C2=A0 system_ss.add(when: &#39;CONFIG_MAC_PVG_MMIO&#39;,=C2=
=A0 if_true: [files(&#39;apple-gfx-mmio.m&#39;), pvg, metal])<br>
&gt; +=C2=A0 endif<br>
&gt; +endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.source_set()<br>
&gt; diff --git a/hw/display/trace-events b/hw/display/trace-events<br>
&gt; index d26d663f963..a50e4eea0c0 100644<br>
&gt; --- a/hw/display/trace-events<br>
&gt; +++ b/hw/display/trace-events<br>
&gt; @@ -194,3 +194,31 @@ dm163_bits_ppi(unsigned dest_width) &quot;dest_wi=
dth : %u&quot;<br>
&gt;=C2=A0 =C2=A0dm163_leds(int led, uint32_t value) &quot;led %d: 0x%x&quo=
t;<br>
&gt;=C2=A0 =C2=A0dm163_channels(int channel, uint8_t value) &quot;channel %=
d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0dm163_refresh_rate(uint32_t rr) &quot;refresh rate %d&quot=
;<br>
&gt; +<br>
&gt; +# apple-gfx.m<br>
&gt; +apple_gfx_read(uint64_t offset, uint64_t res) &quot;offset=3D0x%&quot=
;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_write(uint64_t offset, uint64_t val) &quot;offset=3D0x%&quo=
t;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_create_task(uint32_t vm_size, void *va) &quot;vm_size=3D0x%=
x base_addr=3D%p&quot;<br>
&gt; +apple_gfx_destroy_task(void *task, unsigned int num_mapped_regions) &=
quot;task=3D%p, task-&gt;mapped_regions-&gt;len=3D%u&quot;<br>
&gt; +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtu=
al_offset, uint32_t read_only) &quot;task=3D%p range_count=3D0x%x virtual_o=
ffset=3D0x%&quot;PRIx64&quot; read_only=3D%d&quot;<br>
&gt; +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t p=
hys_len) &quot;[%d] phys_addr=3D0x%&quot;PRIx64&quot; phys_len=3D0x%&quot;P=
RIx64<br>
&gt; +apple_gfx_remap(uint64_t retval, void *source_ptr, uint64_t target) &=
quot;retval=3D%&quot;PRId64&quot; source=3D%p target=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t =
length) &quot;task=3D%p virtual_offset=3D0x%&quot;PRIx64&quot; length=3D0x%=
&quot;PRIx64<br>
&gt; +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *d=
st) &quot;phys_addr=3D0x%&quot;PRIx64&quot; length=3D0x%&quot;PRIx64&quot; =
dest=3D%p&quot;<br>
&gt; +apple_gfx_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<br>
&gt; +apple_gfx_new_frame(void) &quot;&quot;<br>
&gt; +apple_gfx_mode_change(uint64_t x, uint64_t y) &quot;x=3D%&quot;PRId64=
&quot; y=3D%&quot;PRId64<br>
&gt; +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) &=
quot;bpp=3D%d width=3D%&quot;PRId64&quot; height=3D0x%&quot;PRId64<br>
&gt; +apple_gfx_cursor_show(uint32_t show) &quot;show=3D%d&quot;<br>
&gt; +apple_gfx_cursor_move(void) &quot;&quot;<br>
&gt; +apple_gfx_common_init(const char *device_name, size_t mmio_size) &quo=
t;device: %s; MMIO size: %zu bytes&quot;<br>
&gt; +<br>
&gt; +# apple-gfx-mmio.m<br>
&gt; +apple_gfx_mmio_iosfc_read(uint64_t offset, uint64_t res) &quot;offset=
=3D0x%&quot;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_mmio_iosfc_write(uint64_t offset, uint64_t val) &quot;offse=
t=3D0x%&quot;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, =
void *va, void *e, void *f, void* va_result) &quot;phys=3D0x%&quot;PRIx64&q=
uot; len=3D0x%&quot;PRIx64&quot; ro=3D%d va=3D%p e=3D%p f=3D%p -&gt; *va=3D=
%p&quot;<br>
&gt; +apple_gfx_iosfc_map_memory_new_region(size_t i, void *region, uint64_=
t start, uint64_t end) &quot;index=3D%zu, region=3D%p, 0x%&quot;PRIx64&quot=
;-0x%&quot;PRIx64<br>
&gt; +apple_gfx_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void=
 *e, void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p&quot;<br>
&gt; +apple_gfx_iosfc_unmap_memory_region(void* mem, void *region) &quot;un=
mapping @ %p from memory region %p&quot;<br>
&gt; +apple_gfx_iosfc_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<=
br>
&gt; +<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index e0b880e4e13..3c61238bc77 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -794,6 +794,8 @@ socket =3D []<br>
&gt;=C2=A0 =C2=A0version_res =3D []<br>
&gt;=C2=A0 =C2=A0coref =3D []<br>
&gt;=C2=A0 =C2=A0iokit =3D []<br>
&gt; +pvg =3D not_found<br>
&gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0emulator_link_args =3D []<br>
&gt;=C2=A0 =C2=A0midl =3D not_found<br>
&gt;=C2=A0 =C2=A0widl =3D not_found<br>
&gt; @@ -815,6 +817,8 @@ elif host_os =3D=3D &#39;darwin&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0coref =3D dependency(&#39;appleframeworks&#39;, mod=
ules: &#39;CoreFoundation&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0iokit =3D dependency(&#39;appleframeworks&#39;, mod=
ules: &#39;IOKit&#39;, required: false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0host_dsosuf =3D &#39;.dylib&#39;<br>
&gt; +=C2=A0 pvg =3D dependency(&#39;appleframeworks&#39;, modules: &#39;Pa=
ravirtualizedGraphics&#39;)<br>
&gt; +=C2=A0 metal =3D dependency(&#39;appleframeworks&#39;, modules: &#39;=
Metal&#39;)<br>
&gt;=C2=A0 =C2=A0elif host_os =3D=3D &#39;sunos&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0socket =3D [cc.find_library(&#39;socket&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.find_library(=
&#39;nsl&#39;),<br>
<br>
</blockquote></div></div>

--00000000000068e8c00627e24015--

