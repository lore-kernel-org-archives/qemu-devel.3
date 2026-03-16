Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9F3F53D9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2FWL-0002Hn-IW; Mon, 16 Mar 2026 17:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2FWG-0002HC-9C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2FW0-00060H-9q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 17:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773696617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wjanJPaUfNKXYojGtBWEd1W0f7mzCTARJHVc5p4ME+I=;
 b=AryzYGFLbwXhDeM0mJvWZdy+85KLpuK0c7OXC8PS/U4xgsqcGGNMW0MTx90+gSPpJrXdxh
 wow221I81yzwiCNoQwdwECXlSXuVC5yiJMyoA31IvUz5hzvkSPQuOOincz+a1ySmS2Z1Xg
 V8SH6ifI4RxKijgX209izvws/dhFzUU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-rZcjGXrSOQ6wYK4rmRK3fA-1; Mon, 16 Mar 2026 17:30:16 -0400
X-MC-Unique: rZcjGXrSOQ6wYK4rmRK3fA-1
X-Mimecast-MFC-AGG-ID: rZcjGXrSOQ6wYK4rmRK3fA_1773696616
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89a0a2afc55so29018506d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 14:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773696616; x=1774301416; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wjanJPaUfNKXYojGtBWEd1W0f7mzCTARJHVc5p4ME+I=;
 b=QkELI0J8HWLVgGl9Pead3pJFPqfmVbxyCQtTwjKNY6Wfx5auLotMM/nm+JVZeJJIU9
 7rfbNRUWfTU9A/Fwia4hOClRTMLOMSL6vMd059bjAS79V7zlijl2z1/NJJWjdsKZBR8Q
 72kQGNd+smlTWQVhI2N6NMzciAQrEnK3OyYV48wygBCaH2xht/pyckIZAdkpLpFaiReF
 Xb6cP+Thdv3bJO7X3CxlpWBfXwFE13cNJqcvSznLDgRuABjHmCVwDRtj+o1NMJ/Qd5jy
 imeO/G9v1Bea2hD+XOplVFwflAPqiywlnhACQSEiNBL1EnAcoVDeMcqyN6gCpZ3SxYoW
 kgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773696616; x=1774301416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjanJPaUfNKXYojGtBWEd1W0f7mzCTARJHVc5p4ME+I=;
 b=dZRgoz4RGBJg3afwfjo0Y003FdcitvpeGT+oMSg1kcbYCeU0lUgGthejPVVpW1JzUo
 YkERLvtGvV/zGG0/1P6Hk707VzjBqYZvq9GJWuls24qNeEsF+s6a4/SvuxiDjzLW6aTj
 bbsmRqwTrbo+ZwhddbafFgLb1+IAPk8P+5uUvk7Kn+AA0Yyq4tzEezapsg3tFejAxLHi
 bNSXwWBfUor9ixNZUrs8FGvjBbqljJCxAP//CSIsltE6JMX1s9Y8XF2RM1Ac+YiH4n2F
 /3N6uuw/6FmmVzN9XFRjkIJOZsL1GPMGhdWk4qxot0P1ZC88ImhpQATpCUGVfpPcQhjE
 erpg==
X-Gm-Message-State: AOJu0YwmkDGk5FrtumlB0QMtjDMQyYnABU+KO1Qqts/5rUKxkvUZbfMI
 P1HaZgsmwufpkPpk7BFNALD9CrPgmSfkVqXUuBYsHwPwtqxyCtMd6MkEjxca83bQYe3vvKgTOK7
 Bbnd1rVsxEpAWXdeWsQ1OVj7MfXiVxoxl8xzB/phxxd4a5BL/X1RS1tlp1Zr6nX2n
X-Gm-Gg: ATEYQzw+6ug5zZNrX3E/3tSwUGx8MkCehn1xhNrK6YMdbOH2cU7wtFBwDh0HNoHoaju
 OoBsqF6ehYZxVsF0p3LCEhOnrtext7895ILySIt7w31UG+kV1wzwxvEYtwrwsEEi1TGGlLpjMGb
 D3DhDGhw7zKD3dNB0lHM0AQEfGiJxWzYyorTs2EnIYWroPAXqU9aVUfBRGI7P3cVKdt2Z5K2PcF
 dQZ/F+wcE6jdfdZKlV/ckE9EYdYiy5CvcnCiMcIp0utovqPfAUKQqgt/W0pBj6eBo4Eq9XqH1CJ
 FUGYO17wQt4/h6OyepR7vWwDfzxaM+p2mUvr2KL0lQQ/OYZAcV5ugSPCMqllAmOgcjmO8An+rqs
 XvAI48/Sn93QcrA==
X-Received: by 2002:a05:620a:1a01:b0:8cd:988e:c939 with SMTP id
 af79cd13be357-8cdb5a0c53fmr2013312485a.2.1773696615488; 
 Mon, 16 Mar 2026 14:30:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1a01:b0:8cd:988e:c939 with SMTP id
 af79cd13be357-8cdb5a0c53fmr2013305685a.2.1773696614903; 
 Mon, 16 Mar 2026 14:30:14 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cdaac435dbsm1145366385a.16.2026.03.16.14.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 14:30:14 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:30:13 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/display/tcx: Init memory regions in realize
Message-ID: <abh2ZdpzQNepUTIy@x1.local>
References: <20260316130651.5C8735968DE@zero.eik.bme.hu>
 <abgqjKVFHKxuKupP@x1.local>
 <812f2a8d-f6bb-f127-a3f9-4629de5a03e5@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <812f2a8d-f6bb-f127-a3f9-4629de5a03e5@eik.bme.hu>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 16, 2026 at 07:10:05PM +0100, BALATON Zoltan wrote:
> On Mon, 16 Mar 2026, Peter Xu wrote:
> > On Mon, Mar 16, 2026 at 02:06:51PM +0100, BALATON Zoltan wrote:
> > > Due to aux-ram-share property qemu_ram_alloc_internal dereferences
> > > current_machine which is not set during init when inspecting the
> > > device. This causes the qtest/device-introspect-test to fail since a
> > 
> > Does it has anything to do with aux-ram-share?  I thought it's because the
> > qom introspect test will create yet another sun-tcx device, causing double
> > registration?
> 
> I could reproduce it like this:

I would treat this one a separate bug, because it doesn't look special to
sparc systems.

> 
> $ gdb --args ./qemu-system-sparc -M none -device sun-tcx,help
> (gdb) r
> Thread 1 "qemu-system-spa" received signal SIGSEGV, Segmentation fault.
> 0x00005555557ad7ef in qemu_ram_alloc_internal (size=size@entry=65536, max_size=max_size@entry=65536, resized=resized@entry=0x0, host=host@entry=0x0, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=0x555555daee30 <error_fatal>) at ../../mnt/balaton/src/qemu/system/physmem.c:2487
> 2487	        if (!share_flags && current_machine->aux_ram_share) {
> (gdb) bt
> #0  0x00005555557ad7ef in qemu_ram_alloc_internal
>     (size=size@entry=65536, max_size=max_size@entry=65536, resized=resized@entry=0x0, host=host@entry=0x0, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=0x555555daee30 <error_fatal>)
>     at ../../mnt/balaton/src/qemu/system/physmem.c:2487
> #1  0x00005555557adc23 in qemu_ram_alloc
>     (size=size@entry=65536, ram_flags=ram_flags@entry=0, mr=mr@entry=0x555555e15db0, errp=errp@entry=0x555555daee30 <error_fatal>)
>     at ../../mnt/balaton/src/qemu/system/physmem.c:2565
> #2  0x00005555557a741d in memory_region_init_ram_flags_nomigrate
>     (errp=0x555555daee30 <error_fatal>, ram_flags=0, size=65536, name=0x555555ab1999 "tcx.prom", owner=0x555555e15a50, mr=0x555555e15db0)
>     at ../../mnt/balaton/src/qemu/system/memory.c:1600
> #3  memory_region_init_rom
>     (mr=mr@entry=0x555555e15db0, owner=owner@entry=0x555555e15a50, name=name@entry=0x555555ab1999 "tcx.prom", size=size@entry=65536, errp=0x555555daee30 <error_fatal>)
>     at ../../mnt/balaton/src/qemu/system/memory.c:3687
> #4  0x0000555555764cde in tcx_initfn (obj=0x555555e15a50)
>     at ../../mnt/balaton/src/qemu/hw/display/tcx.c:759
> #5  0x0000555555893596 in object_init_with_type
>     (ti=0x555555dffda0, obj=0x555555e15a50)
>     at ../../mnt/balaton/src/qemu/qom/object.c:428
> #6  object_initialize_with_type
>     (obj=0x555555e15a50, size=<optimized out>, type=0x555555dffda0)
>     at ../../mnt/balaton/src/qemu/qom/object.c:570
> #7  0x0000555555893777 in object_new_with_type (type=0x555555dffda0)
>     at ../../mnt/balaton/src/qemu/qom/object.c:774
> #8  0x00005555558937f8 in object_new_with_class    (klass=klass@entry=0x555555e13920)
>     at ../../mnt/balaton/src/qemu/qom/object.c:782
> #9  0x0000555555975210 in qmp_device_list_properties
>     (typename=typename@entry=0x555555de98b0 "sun-tcx", errp=errp@entry=0x7fffffffdc50) at ../../mnt/balaton/src/qemu/qom/qom-qmp-cmds.c:206
> #10 0x00005555557b22fc in qdev_device_help (opts=<optimized out>)
>     at ../../mnt/balaton/src/qemu/system/qdev-monitor.c:313
> #11 0x0000555555a2cda1 in qemu_opts_foreach
>     (list=<optimized out>, func=func@entry=0x55555578fed0 <device_help_func>, opaque=opaque@entry=0x0, errp=errp@entry=0x0)
>     at ../../mnt/balaton/src/qemu/util/qemu-option.c:1135
> #12 0x0000555555793b3f in qemu_process_help_options ()
>     at ../../mnt/balaton/src/qemu/system/vl.c:2641
> #13 qemu_init (argc=<optimized out>, argv=0x7fffffffdfa8)
>     at ../../mnt/balaton/src/qemu/system/vl.c:3741
> #14 0x00005555556cc8d9 in main (argc=<optimized out>, argv=<optimized out>)
>     at ../../mnt/balaton/src/qemu/system/main.c:71
> 
> where
> 
> $ ./qemu-system-sparc -M none -monitor stdio
> QEMU 10.2.50 monitor - type 'help' for more information
> (qemu) info qtree -b
> bus: main-system-bus
>   type System
> 
> So there seems to be no other instance but it fails due to dereferencing
> current_machine to check aux_ram_share but that fails at this point.

I don't see a major reason we should forbid qemu to alloc ram even without
machines.

One way to do this is to fallback and ignore aux-ram-share property when
current_machine isn't available, because it's a machine property after
all..

IMHO it'll make more sense in the commit log to describe the issue that
Thomas hit, which was specific to the sparc machine.

I'm not sure if we need to fix the current_machine reference one here with
a separate patch. If we don't have a solid reproducer elsewhere then we
don't need to.  But if you like to send a patch it looks ok too.

Thanks,

> 
> > > recent change to use memory_region_init_rom instead of global vmstate.
> > > Fix it by removing the init method and move memory region creation in
> > > realize.
> > > 
> > > Fixes: 653c4fa5b0 hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate
> > > Reported by: Thomas Huth <thuth@redhat.com>
> > 
> > Missing "-" in the tag.
> > 
> > I can queue it for rc1 with above fixed, BALATON please help confirm.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> 
> Regards,
> BALATON Zoltan
> 
> > PS: Mark, please feel free to comment or if you want to take it.
> > 
> > Thanks,
> > 
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >  hw/display/tcx.c | 24 +++++++++---------------
> > >  1 file changed, 9 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> > > index c8a4ac21ca..ea92a48400 100644
> > > --- a/hw/display/tcx.c
> > > +++ b/hw/display/tcx.c
> > > @@ -751,10 +751,15 @@ static const GraphicHwOps tcx24_ops = {
> > >      .gfx_update = tcx24_update_display,
> > >  };
> > > 
> > > -static void tcx_initfn(Object *obj)
> > > +static void tcx_realize(DeviceState *dev, Error **errp)
> > >  {
> > > -    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> > > -    TCXState *s = TCX(obj);
> > > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > > +    TCXState *s = TCX(dev);
> > > +    Object *obj = OBJECT(dev);
> > > +    ram_addr_t vram_offset = 0;
> > > +    int size, ret;
> > > +    uint8_t *vram_base;
> > > +    char *fcode_filename;
> > > 
> > >      memory_region_init_rom(&s->rom, obj, "tcx.prom", FCODE_MAX_ROM_SIZE,
> > >                             &error_fatal);
> > > @@ -804,16 +809,6 @@ static void tcx_initfn(Object *obj)
> > >      memory_region_init_io(&s->alt, obj, &tcx_dummy_ops, s, "tcx.alt",
> > >                            TCX_ALT_NREGS);
> > >      sysbus_init_mmio(sbd, &s->alt);
> > > -}
> > > -
> > > -static void tcx_realizefn(DeviceState *dev, Error **errp)
> > > -{
> > > -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > > -    TCXState *s = TCX(dev);
> > > -    ram_addr_t vram_offset = 0;
> > > -    int size, ret;
> > > -    uint8_t *vram_base;
> > > -    char *fcode_filename;
> > > 
> > >      memory_region_init_ram(&s->vram_mem, OBJECT(s), "tcx.vram",
> > >                             s->vram_size * (1 + 4 + 4), &error_fatal);
> > > @@ -887,7 +882,7 @@ static void tcx_class_init(ObjectClass *klass, const void *data)
> > >  {
> > >      DeviceClass *dc = DEVICE_CLASS(klass);
> > > 
> > > -    dc->realize = tcx_realizefn;
> > > +    dc->realize = tcx_realize;
> > >      device_class_set_legacy_reset(dc, tcx_reset);
> > >      dc->vmsd = &vmstate_tcx;
> > >      device_class_set_props(dc, tcx_properties);
> > > @@ -897,7 +892,6 @@ static const TypeInfo tcx_info = {
> > >      .name          = TYPE_TCX,
> > >      .parent        = TYPE_SYS_BUS_DEVICE,
> > >      .instance_size = sizeof(TCXState),
> > > -    .instance_init = tcx_initfn,
> > >      .class_init    = tcx_class_init,
> > >  };
> > > 
> > > --
> > > 2.41.3
> > > 
> > 
> > 
> 

-- 
Peter Xu


