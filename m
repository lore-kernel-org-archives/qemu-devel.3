Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD1BCFB424
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 10:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxOg7-0007t5-23; Sun, 06 Oct 2024 06:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sxOfw-0007p4-T3
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 06:39:46 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sxOfp-0002Hd-Tl
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 06:39:44 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-4a3a9f7b8f0so1149307137.2
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2024 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728211175; x=1728815975;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wNmZKYUMpoKi6FN8mCmbn6YeWKye7iZm0j1Bq/b5nmk=;
 b=VPdI7ySP8NQcKftc84CP/UweaYInFm9YYHaZNOpBfRgVYXIp4WLOp3tTIPWo9ZjBvw
 /bI754pidfW26Qly9N0vIQWjZ9Z/TP/xloo+R4XuhsggUuiPAuzje+TARcSKVBU6Hm7a
 GesQqz/9oUPuBPXqzfBJVR14wgZMCE5KM8b68wR/kq+hLp569rYbUsQ+noYQBxboymfD
 Exosj7Pddedegr7mQ4G3vXhUqpGZSybHekDgTKqPxnIRmpL6LseVAcI9DmnAC4pTKFtV
 +bTpJ34vJsY8vgbCY6xro+NoLqAXv9za3zj0zRTH22YkCsE+bAYHdmPEjNnHmFqs4g5N
 w1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728211175; x=1728815975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wNmZKYUMpoKi6FN8mCmbn6YeWKye7iZm0j1Bq/b5nmk=;
 b=tfys/48NWInLLxUWzvJMZ9tQfYrp4CMY6lSfKHagIB/S/K3sMPybIIcOoLzdRyTwjg
 HKsCxMDsk5ZcMpcmyxFWRSvIY0ktDViF+1AII8zzBuo79PxIHTmwo66QU12w36AhWFbO
 bDoGznfA2EdoO62s28/7dlszLDEqBpg+uPJgZRC3Sp51VEOy6Hwru+3EJlCMGB4a5UVw
 eHsMSQ45rXVwM+H6skOvmvWxM1bYb0HcrWaQDXxlleYxR064DhaHTwPdVuCXorBbLL/R
 ChgI47UbunriacmIJm9UpIuFDjuMBNK7NP6omEPH0lscxmRvBIn7x8kQQ+xWle3JUP1w
 0+AQ==
X-Gm-Message-State: AOJu0YxF/jfBWBHTkjdofw3r5yyHROp20jp3j9of7mCy16ivb14C6A4l
 oaiIpRe8eYSHwr8xZWazrWfT0WJ92J3N4s6vLkpacaskHTKd4Ums4uYDGUyQoigTMlNa4kXLSxi
 sTOE2SPPCgRnKpjM0sGQm9Yx9851YgBNFsamt
X-Google-Smtp-Source: AGHT+IH2XeCXfXNkJCy53x0MABWbBQc2vZp/+Q2x9efOPoD5HLPMJ13IxCkBOFuxVcg+EKcPMCBD6/O3f3joiIPlkSQ=
X-Received: by 2002:a05:6102:3595:b0:4a3:b777:3613 with SMTP id
 ada2fe7eead31-4a405905334mr5994812137.27.1728211175264; Sun, 06 Oct 2024
 03:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-2-phil@philjordan.eu>
 <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
 <CAAibmn1+Z0zcB-vQ3ZbrY0o7wtev+YtV1EOCH-4s=PfQg_Pd8A@mail.gmail.com>
 <ae0f5ef7-c714-40e1-be5a-1aa12df518c8@daynix.com>
In-Reply-To: <ae0f5ef7-c714-40e1-be5a-1aa12df518c8@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 6 Oct 2024 12:39:23 +0200
Message-ID: <CAAibmn3dmBRCpVBDF07jx+_s0A_i5SAhnSinRyKyD5-jcL134g@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] hw/display/apple-gfx: Introduce
 ParavirtualizedGraphics.Framework support
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com, 
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com, 
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, 
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="00000000000032f0df0623cc857b"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe2f.google.com
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

--00000000000032f0df0623cc857b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Oct 2024 at 09:09, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

> On 2024/10/02 22:33, Phil Dennis-Jordan wrote:
> >
> >
> >      > +#include "apple-gfx.h"
> >      > +#include "monitor/monitor.h"
> >      > +#include "hw/sysbus.h"
> >      > +#include "hw/irq.h"
> >      > +#include "trace.h"
> >      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> >      > +
> >      > +_Static_assert(__aarch64__, "");
> >
> >     I don't think this assertion is worthwhile. This assertion will
> trigger
> >     if you accidentally remove depends on AARCH64 from Kconfig, but I
> don't
> >     think such code change happens by accident, and there is no reason =
to
> >     believe that this assertion won't be removed in such a case.
> >
> >
> > As far as I'm aware the Kconfig AARCH64 dependency is for the /target/
> > architecture, not the /host/ architecture? The static assert checks for
> > the latter. The PGIOSurfaceHostDeviceDescriptor type isn't available at
> > all on non-aarch64 macOS hosts. I've not had any luck with using this
> > variant of the device on x86-64 hosts simply by disabling any surface
> > mapper code.
> >
> > Incidentally, if you know of a way to depend on a specific /host/
> > architecture in the Kconfig, that would be even better. I couldn't spot
> > a way of doing that though.
>
> I got your intention now. The correct way to do that is to check for cpu
> =3D=3D 'aarch64'. Having assertion will break qemu-system-aarch64 on Inte=
l
> Macs.
>

OK, looks Iike that needs to be done at the meson.build level not Kconfig,
but this seems to work:

if cpu =3D=3D 'aarch64'
  system_ss.add(when: 'CONFIG_MAC_PVG_MMIO',  if_true:
[files('apple-gfx-mmio.m'), pvg, metal])
endif



> >
> >     It is dangerous to unlock BQL at an arbitrary place. Instead of
> >     unlocking, I suggest:
> >     - running [s->pgiosfc mmioReadAtOffset:offset] on another thread
> >     - using a bottom half to request operations that require BQL from t=
he
> >     thread running [s->pgiosfc mmioReadAtOffset:offset]
> >     - calling AIO_WAIT_WHILE() to process the bottom half and to wait f=
or
> >     the completion of [s->pgiosfc mmioReadAtOffset:offset]
> >
> >
> > OK, I think I see what you mean, I'll try to rework things around that
> > pattern. Any preference on how I kick off the job on the other thread?
> > As we necessarily need to use libdispatch in a bunch of places in this
> > code anyway, I guess dispatch_async() would probably be the simplest?
>
> Perhaps so. The QEMU way is to use a bottom half with AioContext, but
> you can't simultaneously run a dispatch queue and AioContext in one
> thread so you have to use the dispatch queue if you need one.
>
> >
> >      > +    res =3D [s->pgiosfc mmioReadAtOffset:offset];
> >      > +    bql_lock();
> >      > +
> >      > +    trace_apple_iosfc_read(offset, res);
> >      > +
> >      > +    return res;
> >      > +}
> >      > +
> >      > +static void apple_iosfc_write(
> >      > +    void *opaque, hwaddr offset, uint64_t val, unsigned size)
> >      > +{
> >      > +    AppleGFXVmappleState *s =3D opaque;
> >      > +
> >      > +    trace_apple_iosfc_write(offset, val);
> >      > +
> >      > +    [s->pgiosfc mmioWriteAtOffset:offset value:val];
> >      > +}
> >      > +
> >      > +static const MemoryRegionOps apple_iosfc_ops =3D {
> >      > +    .read =3D apple_iosfc_read,
> >      > +    .write =3D apple_iosfc_write,
> >      > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> >      > +    .valid =3D {
> >      > +        .min_access_size =3D 4,
> >      > +        .max_access_size =3D 8,
> >      > +    },
> >      > +    .impl =3D {
> >      > +        .min_access_size =3D 4,
> >      > +        .max_access_size =3D 8,
> >      > +    },
> >      > +};
> >      > +
> >      > +static PGIOSurfaceHostDevice
> >     *apple_gfx_prepare_iosurface_host_device(
> >      > +    AppleGFXVmappleState *s)
> >      > +{
> >      > +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =3D
> >      > +        [PGIOSurfaceHostDeviceDescriptor new];
> >      > +    PGIOSurfaceHostDevice *iosfc_host_dev =3D nil;
> >      > +
> >      > +    iosfc_desc.mapMemory =3D
> >      > +        ^(uint64_t phys, uint64_t len, bool ro, void **va, void
> >     *e, void *f) {
> >      > +            trace_apple_iosfc_map_memory(phys, len, ro, va, e,
> f);
> >      > +            MemoryRegion *tmp_mr;
> >      > +            *va =3D gpa2hva(&tmp_mr, phys, len, NULL);
> >
> >     Use: dma_memory_map()
> >
> >
> > That doesn't seem to be a precisely equivalent operation. It also says
> > in its headerdoc,
> >
> >     Use only for reads OR writes - not for read-modify-write operations=
.
> >
> > which I don't think we can guarantee here at all.
> >
> > I guess I can call it twice, once for writing and once for reading, but
> > given that the dma_memory_unmap operation marks the area dirty, I'm not
> > it's intended for what I understand the use case here to be: As far as =
I
> > can tell, the PV graphics device uses (some) of this memory to exchange
> > data in a cache-coherent way between host and guest, e.g. as a lock-fre=
e
> > ring buffer, using atomic operations as necessary. (This works because
> > it's a PV device: it "knows" the other end just another CPU core (or
> > even the same one) executing in a different hypervisor context.) This
> > doesn't really match "traditional" DMA patterns where there's either a
> > read or a write happening.
>
> I think the story is a bit different for this VMApple variant. Probably
> the CPU and GPU in Apple Silicon is cache-coherent so you can map normal
> memory for GPU without any kind of cache maintenance.
>
> Cache conherency of CPU and GPU in Apple Silicon is implied with Apple's
> documentation; it says you don't need to synchronize resources for
> MTLStorageModeShared, which is the default for Apple Silicon.
>
> https://developer.apple.com/documentation/metal/resource_fundamentals/syn=
chronizing_a_managed_resource_in_macos
>
> The name "IOSurface" also implies it is used not only for e.g., ring
> buffer but also for real data.
>

Note that the PGTask map/unmap callbacks appear to have equivalent
semantics, so it's not just the surface mapping.


> >
> > Hunting around some more for alternative APIs, there's also
> > memory_region_get_ram_ptr(), but I'm not sure its restrictions apply
> > here either.
>
> I think you can call memory_access_is_direct() to check if the
> requirement is satisfied.
>
> It will still break dirty page tracking implemented by
> dma_memory_unmap() and others, but it's broken for hvf, which does not
> implement dirty page tracking either.
>



>
> >      > +            return (bool)true;
> >
> >     Why cast?
> >
> >
> > Good question. Not originally my code, so I've fixed all the instances =
I
> > could find now.
>

OK, it turns out the reason for this is that C treats 'true' as an int,
which then becomes the block's inferred return type - and the callbacks are
expecting bool-returning blocks.

I've fixed it by explicitly specifying the block return type and removing
the cast in the return statement:

iosfc_desc.unmapMemory =3D
       ^bool(=E2=80=A6) {
           =E2=80=A6
           return true;
       };


> >      > +
> >      > +    iosfc_desc.unmapMemory =3D
> >      > +        ^(void *a, void *b, void *c, void *d, void *e, void *f)=
 {
> >      > +            trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
> >      > +            return (bool)true;
> >      > +        };
> >      > +
> >      > +    iosfc_desc.raiseInterrupt =3D ^(uint32_t vector) {
> >      > +        trace_apple_iosfc_raise_irq(vector);
> >      > +        bool locked =3D bql_locked();
> >      > +        if (!locked) {
> >      > +            bql_lock();
> >      > +        }
> >       > +        qemu_irq_pulse(s->irq_iosfc);> +        if (!locked) {
> >      > +            bql_unlock();
> >      > +        }
> >      > +        return (bool)true;
> >      > +    };
> >      > +
> >      > +    iosfc_host_dev =3D
> >      > +        [[PGIOSurfaceHostDevice alloc]
> >     initWithDescriptor:iosfc_desc];
> >      > +    [iosfc_desc release];
> >      > +    return iosfc_host_dev;
> >      > +}
> >      > +
> >      > +static void apple_gfx_vmapple_realize(DeviceState *dev, Error
> >     **errp)
> >      > +{
> >      > +    @autoreleasepool {
> >
> >     This autoreleasepool is not used.
> >
> >
> > It is definitely used inside the apple_gfx_common_realize() call. It's
> > also impossible to say whether [PGDeviceDescriptor new] uses autoreleas=
e
> > semantics internally, so it seemed safer to wrap the whole thing in an
> > outer pool.
>
> Theoretically, It should be safe to assume the callee creates
> autoreleasepool by themselves as needed in general. We have bunch of
> code to call Objective-C APIs without creating autoreleasepool in the
> caller. Practically, [PGDeviceDescriptor new] is likely to be
> implemented with ARC, which wraps methods in autoreleasepool as necessary=
.
>

As far as I'm aware, ARC does NOT automatically insert autorelease pool
blocks. The reason you rarely need to create autoreleasepool blocks in
"plain" Objective-C programming is that Cocoa/CFRunloop/libdispatch event
handlers run each event in an autoreleasepool. So you don't need to create
them explicitly when using dispatch_async and similar, or when running code
on the main thread (which runs inside
NSApplicationMain/CFRunloopRun/dispatch_main).

As far as I'm aware, if you don't explicitly define autoreleasepools in raw
threads created with the pthreads API, any autoreleased objects will leak.
At least I've not found any specification/documentation contradicting this.
And most code in Qemu runs on such raw threads, so we need to play it safe
with regard to autorelease semantics.

Whether the existing Qemu Objective-C code is safe in this regard I don't
know for certain, but I've certainly paid attention to this aspect when
modifying ui/cocoa.m in the past, and indeed most of that code runs on the
main thread. Note also how I wrap the apple_gfx_render_new_frame call in a
pool when it can't be guaranteed it's running on a dispatch queue because
the command buffer inside that uses autorelease semantics.

Functions that uses a method that returns autorelease resources should
> be wrapped with autoreleasepool instead of assuming the caller creates
> autoreleasepool for them.
>

I'm treating apple_gfx_common_realize as an internal API, and I don't think
expecting its callers to wrap it in an autoreleasepool block is
unreasonable. I can certainly explicitly document this in a comment.



> >      > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> >      > new file mode 100644
> >      > index 00000000000..837300f9cd4
> >      > --- /dev/null
> >      > +++ b/hw/display/apple-gfx.m
> >      > @@ -0,0 +1,536 @@
> >      > +/*
> >      > + * QEMU Apple ParavirtualizedGraphics.framework device
> >      > + *
> >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. Al=
l
> >     Rights Reserved.
> >      > + *
> >      > + * This work is licensed under the terms of the GNU GPL, versio=
n
> >     2 or later.
> >      > + * See the COPYING file in the top-level directory.
> >      > + *
> >      > + * ParavirtualizedGraphics.framework is a set of libraries that
> >     macOS provides
> >      > + * which implements 3d graphics passthrough to the host as well
> as a
> >      > + * proprietary guest communication channel to drive it. This
> >     device model
> >      > + * implements support to drive that library from within QEMU.
> >      > + */
> >      > +
> >      > +#include "apple-gfx.h"
> >      > +#include "trace.h"
> >      > +#include "qemu/main-loop.h"
> >      > +#include "ui/console.h"
> >      > +#include "monitor/monitor.h"
> >      > +#include "qapi/error.h"
> >      > +#include "migration/blocker.h"
> >      > +#include <mach/mach_vm.h>
> >      > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> >      > +
> >      > +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> >      > +    { .x =3D 1440, .y =3D 1080 },
> >      > +    { .x =3D 1280, .y =3D 1024 },
> >      > +};
> >      > +
> >      > +typedef struct PGTask_s { // Name matches forward declaration i=
n
> >     PG header
> >
> >     Let's name it AppleGFXTask. It is a common practice to have the sam=
e
> >     tag
> >     name and typedef in QEMU.
> >
> >
> > This is defining a forward-declared type from framework headers which i=
s
> > opaque from the framework's point of view. We do not get to choose its
> > struct name. The alternative is having casts wherever these objects are
> > being passed between our code and the framework. (See the original v1/v=
2
> > vmapple patch series for how messy this is.)
>
> I got the idea. Let's not avoid the typedef then to clarify the naming
> is not under our control.
>

I'm not sure what you mean by this double negative. Are you saying, don't
add our own typedef for struct PGTask_s at all, just use the
framework-supplied PGTask_t where appropriate?


>
> >
> >      > +static void apple_gfx_render_frame_completed(AppleGFXState *s,
> >     void *vram,
> >      > +                                             id<MTLTexture>
> texture)
> >      > +{
> >      > +    --s->pending_frames;
> >      > +    assert(s->pending_frames >=3D 0);
> >      > +
> >      > +    if (vram !=3D s->vram) {
> >      > +        /* Display mode has changed, drop this old frame. */
> >      > +        assert(texture !=3D s->texture);
> >      > +        g_free(vram);
> >
> >     This management of buffers looks a bit convoluted. I suggest
> >     remembering
> >     the width and height instead of pointers and comparing them. This w=
ay
> >     you can free resources in set_mode().
> >
> >
> > Yeah, I suppose that works, I can change that around.
> >
> >      > +    } else {
> >      > +        copy_mtl_texture_to_surface_mem(texture, vram);
> >
> >     Writing vram outside BQL may result in tearing.
> >
> >
> > As far as I can tell(*), QXL does the same. I couldn't find any example=
s
> > of double-buffering in any of the existing display devices, which would
> > be the only way to do async updates efficiently and without tearing. In
> > any case, this solution is still vastly better than a regular VGA
> > device, which suffers from very visible tearing with macOS on the guest
> > side anyway. And in an ideal world, we'd pass through the rendered
> > texture directly to the Cocoa UI code rather than copying out only for
> > the CPU to draw it back into a window surface which is then passed to
> > the GPU for host side rendering. But I felt this patch is already very,
> > very large, and if anyone cares, we can fix imperfections in subsequent
> > updates.
> >
> > (*)The rendering code in that device is also fairly complex, so I may b=
e
> > misreading it.
>
> QXL always modifies the surface with BQL. The surface is modified with
> qxl_blit(), which is called by qxl_render_update_area_unlocked().
> qxl_render_update_area_unlocked() is called by either of
> qxl_render_update() and qxl_render_update_area_bh(). Both of them are
> called with BQL. The name includes "unlocked", but it means it is called
> without holding QXL-internal lock.
>
> Most devices works entirely with BQL so they don't perform double
> buffering. apple-gfx can do the same.
>

I think we can safely move apple-gfx's framebuffer state management back
inside the BQL, yes. I just figured that copying dozens of megabytes of
framebuffer data on every frame while holding the lock was not going to
help BQL contention. Especially as PVG does not have a concept of dirty
areas, so we must copy the whole framebuffer every time. (Unless we were to
implement dirty area detection ourselves.)

Unfortunately, implementing double-buffering would require a major rework
of Qemu's whole surface management, console code, and probably most of the
UI implementations. I'm guessing the OpenGL fast-path sidesteps all of
this, so replicating that with Metal would probably be the easier way
forward. (Although doing all this graphics stuff inside the BQL generally
seems like a major architectural flaw; I suppose most enterprise use of
Qemu does not involve the framebuffer, so it's not shown up in BQL
contention profiling there. It certainly does in desktop use, although at
least on macOS hosts there are far worse culprits in that regard.)

>
> >      > +        if (s->gfx_update_requested) {
> >      > +            s->gfx_update_requested =3D false;
> >      > +            dpy_gfx_update_full(s->con);
> >      > +            graphic_hw_update_done(s->con);
> >       > +            s->new_frame_ready =3D false;
> >
> >     This assignment is unnecessary as s->new_frame_ready is always fals=
e
> >     when s->gfx_update_requested. If you want to make sure
> >     s->gfx_update_requested and s->new_frame_ready are mutually
> exclusive,
> >     use one enum value instead of having two bools.
> >
> >
> > I'll need to refresh my memory and get back to you on this one, it's
> > been so many months since I actively worked on this code.
> >
> >      > +        } else {
> >      > +            s->new_frame_ready =3D true;
> >      > +        }
> >      > +    }
> >      > +    if (s->pending_frames > 0) {
> >      > +        apple_gfx_render_new_frame(s);
> >      > +    }
> >      > +}
> >      > +
> >      > +static void apple_gfx_fb_update_display(void *opaque)
> >      > +{
> >      > +    AppleGFXState *s =3D opaque;
> >      > +
> >      > +    dispatch_async(s->render_queue, ^{
> >      > +        if (s->pending_frames > 0) {
> >
> >     It should check for s->new_frame_ready as
> >     apple_gfx_render_frame_completed() doesn't check if
> >     s->pending_frames > 0 before calling graphic_hw_update_done(), whic=
h
> is
> >     inconsistent.
> >
> >
> > pending_frames is about guest-side frames that are queued to be rendere=
d
> > by the host GPU.
> > new_frame_ready being true indicates that the contents of the Qemu
> > console surface has been updated with new frame data since the last
> > gfx_update.
> > gfx_update_requested indicates that gfx_update is currently awaiting an
> > async completion (graphic_hw_update_done) but the surface has not
> > received a new frame content, but the GPU is stily busy drawing one.
> >
> > apple_gfx_render_frame_completed is scheduled exactly once per pending
> > frame, so pending_frames > 0 is an invariant there. (Hence the assert.)=
>
> > I don't think there is any inconsistency here, but I'll double check.
> > It's possible that there's an easier way to express the state machine,
> > and I'll take a look at that.
>
> I meant that apple_gfx_render_frame_completed() does not check if the
> frame is the last one currently pending. apple_gfx_fb_update_display()
> ignores a new ready frame when there is a more pending frame, but
> apple_gfx_render_frame_completed() unconditionally fires
> graphic_hw_update_done() even if there is a more pending frame. And I
> think apple_gfx_render_frame_completed() is right and
> apple_gfx_fb_update_display() is wrong in such a situation.
>
>
OK, got it. And yes, I agree.


> >
> >     Checking if s->pending_frames > 0 both in
> apple_gfx_fb_update_display()
> >     and apple_gfx_render_frame_completed() is also problematic as that
> can
> >     defer graphic_hw_update_done() indefinitely if we are getting new
> >     frames
> >     too fast.
> >
> >
> > I see what you mean about this part. I'll have to test it, but I guess
> > we should reverse the priority, like this:
> >
> >          if (s->new_frame_ready) {
> >              dpy_gfx_update_full(s->con);
> >              s->new_frame_ready =3D false;
> >              graphic_hw_update_done(s->con);
> >          } else if (s->pending_frames > 0) {
> >              s->gfx_update_requested =3D true;
> >          } else {
> >              graphic_hw_update_done(s->con);
> >          }
> >
> > 1. If we already have a frame, ready to be displayed, return it
> immediately.
> > 2. If the guest has reported that it's completed a frame and the GPU is
> > currently busy rendering it, defer graphic_hw_update_done until it's
> done.
> > 3. If the guest reports no changes to its display, indicate this back t=
o
> > Qemu as a no-op display update graphic_hw_update_done() with no
> > dpy_gfx_update* call.
>
> Yes, that looks correct.
>
> >
> >      > +            s->gfx_update_requested =3D true;
> >      > +        } else {
> >      > +            if (s->new_frame_ready) {
> >      > +                dpy_gfx_update_full(s->con);
> >      > +                s->new_frame_ready =3D false;
> >      > +            }
> >      > +            graphic_hw_update_done(s->con);
> >       > +        }> +    });
> >      > +}
> >      > +
> >      > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> >      > +    .gfx_update =3D apple_gfx_fb_update_display,
> >      > +    .gfx_update_async =3D true,
> >      > +};
> >      > +
> >      > +static void update_cursor(AppleGFXState *s)
> >      > +{
> >      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> >      > +                  s->pgdisp.cursorPosition.y, s->cursor_show);
> >      > +}
> >      > +
> >      > +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t
> >     height)
> >      > +{
> >      > +    void *vram =3D NULL;
> >      > +    DisplaySurface *surface;
> >      > +    MTLTextureDescriptor *textureDescriptor;
> >      > +    id<MTLTexture> texture =3D nil;
> >      > +    __block bool no_change =3D false;
> >      > +
> >      > +    dispatch_sync(s->render_queue,
> >
> >     Calling dispatch_sync() while holding BQL may result in deadlock.
> >
> > Only if any code executed on the same dispatch queue acquires the lock
> > either directly or transitively. I believe I have ensure this is not
> > done on the reqnder_queue, have you found anywhere this is the case?
>
> The documentation is not clear what threads a dispatch queue runs on. We
> can have a deadlock if they lock the BQL.
>

dispatch_sync is a synchronisation primitive (it waits for and asserts
exclusive access to the given queue), it doesn't actually do any thread
scheduling. Work scheduled asynchronously to non-main dispatch queues will
otherwise run on libdispatch pool threads. Running blocks on dispatch
queues will not preempt and schedule it on other threads which may or may
not be holding some locks.

So the only way this code will deadlock is if any code scheduled to
render_queue directly or transitively acquires the BQL. None of it does,
although updating the console while holding the BQL rather complicates this=
.


> >
> >      > +        ^{
> >      > +            if (s->surface &&
> >      > +                width =3D=3D surface_width(s->surface) &&
> >      > +                height =3D=3D surface_height(s->surface)) {
> >      > +                no_change =3D true;
> >      > +            }
> >      > +        });
> >      > +
> >      > +    if (no_change) {
> >      > +        return;
> >      > +    }
> >      > +
> >      > +    vram =3D g_malloc0(width * height * 4);
> >      > +    surface =3D qemu_create_displaysurface_from(width, height,
> >     PIXMAN_LE_a8r8g8b8,
> >      > +                                              width * 4, vram);
> >      > +
> >      > +    @autoreleasepool {
> >      > +        textureDescriptor =3D
> >      > +            [MTLTextureDescriptor
> >      > +
> >     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> >      > +                                             width:width
> >      > +                                            height:height
> >      > +                                         mipmapped:NO];
> >      > +        textureDescriptor.usage =3D s->pgdisp.minimumTextureUsa=
ge;
> >      > +        texture =3D [s->mtl
> >     newTextureWithDescriptor:textureDescriptor];
> >      > +    }
> >      > +
> >      > +    s->using_managed_texture_storage =3D
> >      > +        (texture.storageMode =3D=3D MTLStorageModeManaged);
> >      > +
> >      > +    dispatch_sync(s->render_queue,
> >      > +        ^{
> >      > +            id<MTLTexture> old_texture =3D nil;
> >      > +            void *old_vram =3D s->vram;
> >      > +            s->vram =3D vram;
> >      > +            s->surface =3D surface;
> >      > +
> >      > +            dpy_gfx_replace_surface(s->con, surface);
> >      > +
> >      > +            old_texture =3D s->texture;
> >      > +            s->texture =3D texture;
> >      > +            [old_texture release];
> >
> >     You can just do:
> >     [s->texture release];
> >     s->texture =3D texture;
> >
> >     This will make s->texture dangling between the two statements, but
> that
> >     don't matter since s->texture is not an atomic variable that can be
> >     safely observed from another thread anyway.
> >
> >      > +
> >      > +            if (s->pending_frames =3D=3D 0) {
> >      > +                g_free(old_vram);
> >      > +            }
> >      > +        });
> >      > +}
> >      > +
> >      > +static void create_fb(AppleGFXState *s)
> >      > +{
> >      > +    s->con =3D graphic_console_init(NULL, 0, &apple_gfx_fb_ops,=
 s);
> >      > +    set_mode(s, 1440, 1080);
> >      > +
> >      > +    s->cursor_show =3D true;
> >      > +}
> >      > +
> >      > +static size_t apple_gfx_get_default_mmio_range_size(void)
> >      > +{
> >      > +    size_t mmio_range_size;
> >      > +    @autoreleasepool {
> >      > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> >      > +        mmio_range_size =3D desc.mmioLength;
> >      > +        [desc release];
> >      > +    }
> >      > +    return mmio_range_size;
> >      > +}
> >      > +
> >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const
> >     char* obj_name)
> >
> >     This function can be merged into apple_gfx_common_realize().
> >
> >
> > Probably. I'll try it.
>

Upon further inspection, we need to call
cocoa_enable_runloop_on_main_thread() during the init phase, not realize().
So we can't get rid of this entirely. Is there any value in moving the
other init code into _realize()?


> >      > +{
> >      > +    Error *local_err =3D NULL;
> >      > +    int r;
> >      > +    size_t mmio_range_size =3D
> >     apple_gfx_get_default_mmio_range_size();
> >      > +
> >      > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> >      > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s=
,
> >     obj_name,
> >      > +                          mmio_range_size);
> >      > +    s->iomem_gfx.disable_reentrancy_guard =3D true;
> >
> >     Why do you disable reentrancy guard?
> >
> >
> > Perhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this won't b=
e
> > an issue anymore, but the guard would otherwise keep dropping MMIOs
> > which immediately caused the PV graphics device to stop making progress=
.
> > The MMIO APIs in the PVG framework are thread- and reentrancy-safe, so
> > we certainly don't need to serialise them on our side.
>
> It's better to understand why such reentrancy happens. Reentrancy itself
> is often a sign of bug.
>
> >
> >      > +
> >      > +    /* TODO: PVG framework supports serialising device state:
> >     integrate it! */
> >      > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> >      > +        error_setg(&apple_gfx_mig_blocker,
> >      > +                  "Migration state blocked by apple-gfx display
> >     device");
> >      > +        r =3D migrate_add_blocker(&apple_gfx_mig_blocker,
> &local_err);
> >      > +        if (r < 0) {
> >      > +            error_report_err(local_err);
> >
> >     Please report the error to the caller of apple_gfx_common_realize()
> >     instead.
> >
> >      > +        }
> >      > +    }
> >       > +}> +
> >      > +static void
> >     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> >      > +
> >       PGDeviceDescriptor *desc)
> >      > +{
> >      > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable *
> >     _Nonnull baseAddress) {
> >      > +        AppleGFXTask *task =3D apple_gfx_new_task(s, vmSize);
> >      > +        *baseAddress =3D (void*)task->address;
> >
> >     nit: please write as (void *) instead of (void*).
> >
> >      > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> >      > +        return task;
> >      > +    };
> >      > +
> >
> >      > +{
> >      > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new=
];
> >      > +
> >      > + disp_desc.name <http://disp_desc.name> =3D @"QEMU display";
> >      > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* =
A
> >     20" display */
> >      > +    disp_desc.queue =3D dispatch_get_main_queue();
> >      > +    disp_desc.newFrameEventHandler =3D ^(void) {
> >      > +        trace_apple_gfx_new_frame();
> >      > +        dispatch_async(s->render_queue, ^{
> >      > +            /* Drop frames if we get too far ahead. */
> >      > +            if (s->pending_frames >=3D 2)
> >      > +                return;
> >      > +            ++s->pending_frames;
> >      > +            if (s->pending_frames > 1) {
> >      > +                return;
> >      > +            }
> >      > +            @autoreleasepool {
> >      > +                apple_gfx_render_new_frame(s);
> >      > +            }
> >      > +        });
> >      > +    };
> >      > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t
> sizeInPixels,
> >      > +                                    OSType pixelFormat) {
> >      > +        trace_apple_gfx_mode_change(sizeInPixels.x,
> sizeInPixels.y);
> >      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> >      > +    };
> >      > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
> >      > +                                     PGDisplayCoord_t hotSpot) =
{
> >      > +        uint32_t bpp =3D glyph.bitsPerPixel;
> >      > +        size_t width =3D glyph.pixelsWide;
> >      > +        size_t height =3D glyph.pixelsHigh;
> >      > +        size_t padding_bytes_per_row =3D glyph.bytesPerRow - wi=
dth
> >     * 4;
> >      > +        const uint8_t* px_data =3D glyph.bitmapData;
> >      > +
> >      > +        trace_apple_gfx_cursor_set(bpp, width, height);
> >      > +
> >      > +        if (s->cursor) {
> >      > +            cursor_unref(s->cursor);
> >      > +            s->cursor =3D NULL;
> >      > +        }
> >      > +
> >      > +        if (bpp =3D=3D 32) { /* Shouldn't be anything else, but=
 just
> >     to be safe...*/
> >      > +            s->cursor =3D cursor_alloc(width, height);
> >      > +            s->cursor->hot_x =3D hotSpot.x;
> >      > +            s->cursor->hot_y =3D hotSpot.y;
> >      > +
> >      > +            uint32_t *dest_px =3D s->cursor->data;
> >      > +
> >      > +            for (size_t y =3D 0; y < height; ++y) {
> >      > +                for (size_t x =3D 0; x < width; ++x) {
> >      > +                    /* NSBitmapImageRep's red & blue channels
> >     are swapped
> >      > +                     * compared to QEMUCursor's. */
> >      > +                    *dest_px =3D
> >      > +                        (px_data[0] << 16u) |
> >      > +                        (px_data[1] <<  8u) |
> >      > +                        (px_data[2] <<  0u) |
> >      > +                        (px_data[3] << 24u);
> >      > +                    ++dest_px;
> >      > +                    px_data +=3D 4;
> >      > +                }
> >      > +                px_data +=3D padding_bytes_per_row;
> >      > +            }
> >      > +            dpy_cursor_define(s->con, s->cursor);
> >      > +            update_cursor(s);
> >      > +        }
> >      > +    };
> >      > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> >      > +        trace_apple_gfx_cursor_show(show);
> >      > +        s->cursor_show =3D show;
> >      > +        update_cursor(s);
> >      > +    };
> >      > +    disp_desc.cursorMoveHandler =3D ^(void) {
> >      > +        trace_apple_gfx_cursor_move();
> >      > +        update_cursor(s);
> >      > +    };
> >      > +
> >      > +    return disp_desc;
> >      > +}
> >      > +
> >      > +static NSArray<PGDisplayMode*>*
> >     apple_gfx_prepare_display_mode_array(void)
> >      > +{
> >      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> >      > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> >      > +    int i;
> >      > +
> >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> >      > +        modes[i] =3D
> >      > +            [[PGDisplayMode alloc]
> >     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> >      > +    }
> >      > +
> >      > +    mode_array =3D [NSArray arrayWithObjects:modes
> >     count:ARRAY_SIZE(apple_gfx_modes)];
> >      > +
> >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> >      > +        [modes[i] release];
> >      > +        modes[i] =3D nil;
> >      > +    }
> >      > +
> >      > +    return mode_array;
> >      > +}
> >      > +
> >      > +static id<MTLDevice> copy_suitable_metal_device(void)
> >      > +{
> >      > +    id<MTLDevice> dev =3D nil;
> >      > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices();
> >      > +
> >      > +    /* Prefer a unified memory GPU. Failing that, pick a non-
> >     removable GPU. */
> >      > +    for (size_t i =3D 0; i < devs.count; ++i) {
> >      > +        if (devs[i].hasUnifiedMemory) {
> >      > +            dev =3D devs[i];
> >      > +            break;
> >      > +        }
> >      > +        if (!devs[i].removable) {
> >      > +            dev =3D devs[i];
> >      > +        }
> >      > +    }
> >      > +
> >      > +    if (dev !=3D nil) {
> >      > +        [dev retain];
> >      > +    } else {
> >      > +        dev =3D MTLCreateSystemDefaultDevice();
> >      > +    }
> >      > +    [devs release];
> >      > +
> >      > +    return dev;
> >      > +}
> >      > +
> >      > +void apple_gfx_common_realize(AppleGFXState *s,
> >     PGDeviceDescriptor *desc)
> >      > +{
> >      > +    PGDisplayDescriptor *disp_desc =3D nil;
> >      > +
> >      > +    QTAILQ_INIT(&s->tasks);
> >      > +    s->render_queue =3D dispatch_queue_create("apple-gfx.render=
",
> >      > +
> DISPATCH_QUEUE_SERIAL);
> >      > +    s->mtl =3D copy_suitable_metal_device();
> >      > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> >      > +
> >      > +    desc.device =3D s->mtl;
> >      > +
> >      > +    apple_gfx_register_task_mapping_handlers(s, desc);
> >      > +
> >      > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> >      > +
> >      > +    disp_desc =3D apple_gfx_prepare_display_handlers(s);
> >      > +    s->pgdisp =3D [s->pgdev newDisplayWithDescriptor:disp_desc
> >      > +                                              port:0
> >     serialNum:1234];
> >      > +    [disp_desc release];
> >      > +    s->pgdisp.modeList =3D apple_gfx_prepare_display_mode_array=
();
> >      > +
> >      > +    create_fb(s);
> >      > +}
> >      > diff --git a/hw/display/meson.build b/hw/display/meson.build
> >      > index 7db05eace97..70d855749c0 100644
> >      > --- a/hw/display/meson.build
> >      > +++ b/hw/display/meson.build
> >      > @@ -65,6 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
> >     files('artist.c'))
> >      >
> >      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> >     'ati_2d.c', 'ati_dbg.c'), pixman])
> >      >
> >      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> >     [files('apple-gfx.m'), pvg, metal])
> >      > +system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true:
> >     [files('apple-gfx-vmapple.m'), pvg, metal])
> >      >
> >      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >      >     virtio_gpu_ss =3D ss.source_set()
> >      > diff --git a/hw/display/trace-events b/hw/display/trace-events
> >      > index 781f8a33203..1809a358e36 100644
> >      > --- a/hw/display/trace-events
> >      > +++ b/hw/display/trace-events
> >      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
> >     "dest_width : %u"
> >      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >      >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> >      > +
> >      > +# apple-gfx.m
> >      > +apple_gfx_read(uint64_t offset, uint64_t res)
> >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      > +apple_gfx_write(uint64_t offset, uint64_t val)
> >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=3D0x=
%x
> >     base_addr=3D%p"
> >      > +apple_gfx_destroy_task(void *task) "task=3D%p"
> >      > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
> >     virtual_offset, uint32_t read_only) "task=3D%p range_count=3D0x%x
> >     virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> >      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr,
> >     uint64_t phys_len) "[%d] phys_addr=3D0x%"PRIx64" phys_len=3D0x%"PRI=
x64
> >      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t
> >     target) "retval=3D%"PRId64" source=3D0x%"PRIx64" target=3D0x%"PRIx6=
4
> >      > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset,
> >     uint64_t length) "task=3D%p virtual_offset=3D0x%"PRIx64"
> length=3D0x%"PRIx64
> >      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length,
> >     void *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" dest=3D%p"
> >      > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      > +apple_gfx_new_frame(void) ""
> >      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRId64"
> >     y=3D%"PRId64
> >      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t
> >     height) "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> >      > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> >      > +apple_gfx_cursor_move(void) ""
> >      > +apple_gfx_common_init(const char *device_name, size_t mmio_size=
)
> >     "device: %s; MMIO size: %zu bytes"
> >      > +
> >      > +# apple-gfx-vmapple.m
> >      > +apple_iosfc_read(uint64_t offset, uint64_t res)
> >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      > +apple_iosfc_write(uint64_t offset, uint64_t val)
> >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      > +apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro=
,
> >     void *va, void *e, void *f) "phys=3D0x%"PRIx64" len=3D0x%"PRIx64" r=
o=3D%d
> >     va=3D%p e=3D%p f=3D%p"
> >      > +apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d,
> >     void *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> >      > +apple_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      > +
> >      > diff --git a/meson.build b/meson.build
> >      > index 10464466ff3..f09df3f09d5 100644
> >      > --- a/meson.build
> >      > +++ b/meson.build
> >      > @@ -741,6 +741,8 @@ socket =3D []
> >      >   version_res =3D []
> >      >   coref =3D []
> >      >   iokit =3D []
> >      > +pvg =3D []
> >      > +metal =3D []
> >      >   emulator_link_args =3D []
> >      >   midl =3D not_found
> >      >   widl =3D not_found
> >      > @@ -762,6 +764,8 @@ elif host_os =3D=3D 'darwin'
> >      >     coref =3D dependency('appleframeworks', modules:
> 'CoreFoundation')
> >      >     iokit =3D dependency('appleframeworks', modules: 'IOKit',
> >     required: false)
> >      >     host_dsosuf =3D '.dylib'
> >      > +  pvg =3D dependency('appleframeworks', modules:
> >     'ParavirtualizedGraphics')
> >      > +  metal =3D dependency('appleframeworks', modules: 'Metal')
> >      >   elif host_os =3D=3D 'sunos'
> >      >     socket =3D [cc.find_library('socket'),
> >      >               cc.find_library('nsl'),
> >
>
>

--00000000000032f0df0623cc857b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, 3 Oct 2024 at 09:09, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On 2024/10/02 22:33, Phil Dennis-Jordan wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;apple-gfx.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;hw/irq.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;trace.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#import &lt;ParavirtualizedGraphics/Paravirt=
ualizedGraphics.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +_Static_assert(__aarch64__, &quot;&quot;);<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t think this assertion is worthwhile. Thi=
s assertion will trigger<br>
&gt;=C2=A0 =C2=A0 =C2=A0if you accidentally remove depends on AARCH64 from =
Kconfig, but I don&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0think such code change happens by accident, and the=
re is no reason to<br>
&gt;=C2=A0 =C2=A0 =C2=A0believe that this assertion won&#39;t be removed in=
 such a case.<br>
&gt; <br>
&gt; <br>
&gt; As far as I&#39;m aware the Kconfig AARCH64 dependency is for the /tar=
get/ <br>
&gt; architecture, not the /host/ architecture? The static assert checks fo=
r <br>
&gt; the latter. The PGIOSurfaceHostDeviceDescriptor type isn&#39;t availab=
le at <br>
&gt; all on non-aarch64 macOS hosts. I&#39;ve not had any luck with using t=
his <br>
&gt; variant of the device on x86-64 hosts simply by disabling any surface =
<br>
&gt; mapper code.<br>
&gt; <br>
&gt; Incidentally, if you know of a way to depend on a specific /host/ <br>
&gt; architecture in the Kconfig, that would be even better. I couldn&#39;t=
 spot <br>
&gt; a way of doing that though.<br>
<br>
I got your intention now. The correct way to do that is to check for cpu <b=
r>
=3D=3D &#39;aarch64&#39;. Having assertion will break qemu-system-aarch64 o=
n Intel Macs.<br></blockquote><div><br></div><div>OK, looks Iike that needs=
 to be done at the meson.build level not Kconfig, but this seems to work:</=
div><div><br></div><div>if cpu =3D=3D &#39;aarch64&#39;<br>=C2=A0 system_ss=
.add(when: &#39;CONFIG_MAC_PVG_MMIO&#39;, =C2=A0if_true: [files(&#39;apple-=
gfx-mmio.m&#39;), pvg, metal])<br></div><div>endif<br></div><div><br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It is dangerous to unlock BQL at an arbitrary place=
. Instead of<br>
&gt;=C2=A0 =C2=A0 =C2=A0unlocking, I suggest:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- running [s-&gt;pgiosfc mmioReadAtOffset:offset] o=
n another thread<br>
&gt;=C2=A0 =C2=A0 =C2=A0- using a bottom half to request operations that re=
quire BQL from the<br>
&gt;=C2=A0 =C2=A0 =C2=A0thread running [s-&gt;pgiosfc mmioReadAtOffset:offs=
et]<br>
&gt;=C2=A0 =C2=A0 =C2=A0- calling AIO_WAIT_WHILE() to process the bottom ha=
lf and to wait for<br>
&gt;=C2=A0 =C2=A0 =C2=A0the completion of [s-&gt;pgiosfc mmioReadAtOffset:o=
ffset]<br>
&gt; <br>
&gt; <br>
&gt; OK, I think I see what you mean, I&#39;ll try to rework things around =
that <br>
&gt; pattern. Any preference on how I kick off the job on the other thread?=
 <br>
&gt; As we necessarily need to use libdispatch in a bunch of places in this=
 <br>
&gt; code anyway, I guess dispatch_async() would probably be the simplest?<=
br>
<br>
Perhaps so. The QEMU way is to use a bottom half with AioContext, but <br>
you can&#39;t simultaneously run a dispatch queue and AioContext in one <br=
>
thread so you have to use the dispatch queue if you need one.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 res =3D [s-&gt;pgiosfc mmioRea=
dAtOffset:offset];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_iosfc_read(offset,=
 res);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_iosfc_write(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 void *opaque, hwaddr offset, u=
int64_t val, unsigned size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXVmappleState *s =3D op=
aque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_iosfc_write(offset=
, val);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [s-&gt;pgiosfc mmioWriteAtOffs=
et:offset value:val];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const MemoryRegionOps apple_iosfc_ops=
 =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .read =3D apple_iosfc_read,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .write =3D apple_iosfc_write,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_=
ENDIAN,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size=
 =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size=
 =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size=
 =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size=
 =3D 8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static PGIOSurfaceHostDevice<br>
&gt;=C2=A0 =C2=A0 =C2=A0*apple_gfx_prepare_iosurface_host_device(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXVmappleState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDeviceDescripto=
r *iosfc_desc =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [PGIOSurfaceHost=
DeviceDescriptor new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDevice *iosfc_h=
ost_dev =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 iosfc_desc.mapMemory =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(uint64_t phys,=
 uint64_t len, bool ro, void **va, void<br>
&gt;=C2=A0 =C2=A0 =C2=A0*e, void *f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr=
ace_apple_iosfc_map_memory(phys, len, ro, va, e, f);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Me=
moryRegion *tmp_mr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *v=
a =3D gpa2hva(&amp;tmp_mr, phys, len, NULL);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use: dma_memory_map()<br>
&gt; <br>
&gt; <br>
&gt; That doesn&#39;t seem to be a precisely equivalent operation. It also =
says <br>
&gt; in its headerdoc,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Use only for reads OR writes - not for read-modify-=
write operations.<br>
&gt; <br>
&gt; which I don&#39;t think we can guarantee here at all.<br>
&gt; <br>
&gt; I guess I can call it twice, once for writing and once for reading, bu=
t <br>
&gt; given that the dma_memory_unmap operation marks the area dirty, I&#39;=
m not <br>
&gt; it&#39;s intended for what I understand the use case here to be: As fa=
r as I <br>
&gt; can tell, the PV graphics device uses (some) of this memory to exchang=
e <br>
&gt; data in a cache-coherent way between host and guest, e.g. as a lock-fr=
ee <br>
&gt; ring buffer, using atomic operations as necessary. (This works because=
 <br>
&gt; it&#39;s a PV device: it &quot;knows&quot; the other end just another =
CPU core (or <br>
&gt; even the same one) executing in a different hypervisor context.) This =
<br>
&gt; doesn&#39;t really match &quot;traditional&quot; DMA patterns where th=
ere&#39;s either a <br>
&gt; read or a write happening.<br>
<br>
I think the story is a bit different for this VMApple variant. Probably <br=
>
the CPU and GPU in Apple Silicon is cache-coherent so you can map normal <b=
r>
memory for GPU without any kind of cache maintenance.<br>
<br>
Cache conherency of CPU and GPU in Apple Silicon is implied with Apple&#39;=
s <br>
documentation; it says you don&#39;t need to synchronize resources for <br>
MTLStorageModeShared, which is the default for Apple Silicon.<br>
<a href=3D"https://developer.apple.com/documentation/metal/resource_fundame=
ntals/synchronizing_a_managed_resource_in_macos" rel=3D"noreferrer" target=
=3D"_blank">https://developer.apple.com/documentation/metal/resource_fundam=
entals/synchronizing_a_managed_resource_in_macos</a><br>
<br>
The name &quot;IOSurface&quot; also implies it is used not only for e.g., r=
ing <br>
buffer but also for real data.<br></blockquote><div>=C2=A0</div><div>Note t=
hat the PGTask map/unmap callbacks appear to have equivalent semantics, so =
it&#39;s not just the surface mapping.<br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Hunting around some more for alternative APIs, there&#39;s also <br>
&gt; memory_region_get_ram_ptr(), but I&#39;m not sure its restrictions app=
ly <br>
&gt; here either.<br>
<br>
I think you can call memory_access_is_direct() to check if the <br>
requirement is satisfied.<br>
<br>
It will still break dirty page tracking implemented by <br>
dma_memory_unmap() and others, but it&#39;s broken for hvf, which does not =
<br>
implement dirty page tracking either.<br></blockquote><div><br></div><div><=
br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn (bool)true;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why cast?<br>
&gt; <br>
&gt; <br>
&gt; Good question. Not originally my code, so I&#39;ve fixed all the insta=
nces I <br>
&gt; could find now.<br>
</blockquote><div><br></div><div>OK, it turns out the reason for this is th=
at C treats &#39;true&#39; as an int, which then becomes the block&#39;s in=
ferred return type - and the callbacks are expecting bool-returning blocks.=
</div><div><br></div><div>I&#39;ve fixed it by explicitly specifying the bl=
ock return type and removing the cast in the return statement:<br></div><di=
v><br></div><div>iosfc_desc.unmapMemory =3D<br></div><div>=C2=A0 =C2=A0 =C2=
=A0=C2=A0 ^bool(=E2=80=A6) {</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =E2=80=A6</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;</div><div>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 };<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 iosfc_desc.unmapMemory =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(void *a, void =
*b, void *c, void *d, void *e, void *f) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tr=
ace_apple_iosfc_unmap_memory(a, b, c, d, e, f);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn (bool)true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 iosfc_desc.raiseInterrupt =3D =
^(uint32_t vector) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_iosf=
c_raise_irq(vector);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool locked =3D =
bql_locked();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!locked) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bq=
l_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_p=
ulse(s-&gt;irq_iosfc);&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!locked) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bq=
l_unlock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (bool)tru=
e;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 iosfc_host_dev =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGIOSurfaceHos=
tDevice alloc]<br>
&gt;=C2=A0 =C2=A0 =C2=A0initWithDescriptor:iosfc_desc];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [iosfc_desc release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return iosfc_host_dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_vmapple_realize(Device=
State *dev, Error<br>
&gt;=C2=A0 =C2=A0 =C2=A0**errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This autoreleasepool is not used.<br>
&gt; <br>
&gt; <br>
&gt; It is definitely used inside the apple_gfx_common_realize() call. It&#=
39;s <br>
&gt; also impossible to say whether [PGDeviceDescriptor new] uses autorelea=
se <br>
&gt; semantics internally, so it seemed safer to wrap the whole thing in an=
 <br>
&gt; outer pool.<br>
<br>
Theoretically, It should be safe to assume the callee creates <br>
autoreleasepool by themselves as needed in general. We have bunch of <br>
code to call Objective-C APIs without creating autoreleasepool in the <br>
caller. Practically, [PGDeviceDescriptor new] is likely to be <br>
implemented with ARC, which wraps methods in autoreleasepool as necessary.<=
br></blockquote><div><br></div><div>As far as I&#39;m aware, ARC does NOT a=
utomatically insert autorelease pool blocks. The reason you rarely need to =
create autoreleasepool blocks in &quot;plain&quot; Objective-C programming =
is that Cocoa/CFRunloop/libdispatch event handlers run each event in an aut=
oreleasepool. So you don&#39;t need to create them explicitly when using di=
spatch_async and similar, or when running code on the main thread (which ru=
ns inside NSApplicationMain/CFRunloopRun/dispatch_main).</div><div><br></di=
v><div>As far as I&#39;m aware, if you don&#39;t explicitly define autorele=
asepools in raw threads created with the pthreads API, any autoreleased obj=
ects will leak. At least I&#39;ve not found any specification/documentation=
 contradicting this. And most code in Qemu runs on such raw threads, so we =
need to play it safe with regard to autorelease semantics.<br></div><div><b=
r></div><div>Whether the existing Qemu Objective-C code is safe in this reg=
ard I don&#39;t know for certain,  but I&#39;ve certainly paid attention to=
 this aspect when modifying ui/cocoa.m in the past, and indeed most of that=
 code runs on the main thread. Note also how I wrap the apple_gfx_render_ne=
w_frame call in a pool when it can&#39;t be guaranteed it&#39;s running on =
a dispatch queue because the command buffer inside that uses autorelease se=
mantics.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
Functions that uses a method that returns autorelease resources should <br>
be wrapped with autoreleasepool instead of assuming the caller creates <br>
autoreleasepool for them.<br></blockquote><div><br></div><div>I&#39;m treat=
ing=C2=A0apple_gfx_common_realize as an internal API, and I don&#39;t think=
 expecting its callers to wrap it in an autoreleasepool block is unreasonab=
le. I can certainly explicitly document this in a comment.<br></div><div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/apple-gfx.m b/hw/disp=
lay/apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..837300f9cd4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,536 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * QEMU Apple ParavirtualizedGraphics.framew=
ork device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or=
 its affiliates. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0Rights Reserved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is licensed under the terms of =
the GNU GPL, version<br>
&gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING file in the top-level dir=
ectory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ParavirtualizedGraphics.framework is a se=
t of libraries that<br>
&gt;=C2=A0 =C2=A0 =C2=A0macOS provides<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * which implements 3d graphics passthrough =
to the host as well as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * proprietary guest communication channel t=
o drive it. This<br>
&gt;=C2=A0 =C2=A0 =C2=A0device model<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * implements support to drive that library =
from within QEMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;apple-gfx.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;trace.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;ui/console.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;migration/blocker.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &lt;mach/mach_vm.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#import &lt;ParavirtualizedGraphics/Paravirt=
ualizedGraphics.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const PGDisplayCoord_t apple_gfx_mode=
s[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { .x =3D 1440, .y =3D 1080 },<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { .x =3D 1280, .y =3D 1024 },<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct PGTask_s { // Name matches fo=
rward declaration in<br>
&gt;=C2=A0 =C2=A0 =C2=A0PG header<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Let&#39;s name it AppleGFXTask. It is a common prac=
tice to have the same<br>
&gt;=C2=A0 =C2=A0 =C2=A0tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0name and typedef in QEMU.<br>
&gt; <br>
&gt; <br>
&gt; This is defining a forward-declared type from framework headers which =
is <br>
&gt; opaque from the framework&#39;s point of view. We do not get to choose=
 its <br>
&gt; struct name. The alternative is having casts wherever these objects ar=
e <br>
&gt; being passed between our code and the framework. (See the original v1/=
v2 <br>
&gt; vmapple patch series for how messy this is.)<br>
<br>
I got the idea. Let&#39;s not avoid the typedef then to clarify the naming =
<br>
is not under our control.<br></blockquote><div><br></div><div>I&#39;m not s=
ure what you mean by this double negative. Are you saying, don&#39;t add ou=
r own typedef for struct PGTask_s at all, just use the framework-supplied P=
GTask_t where appropriate?<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_render_frame_completed=
(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *vram,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0id&lt;MTLTexture&gt; texture)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 assert(s-&gt;pending_frames &g=
t;=3D 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (vram !=3D s-&gt;vram) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Display mode =
has changed, drop this old frame. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(texture !=
=3D s-&gt;texture);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vram);<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This management of buffers looks a bit convoluted. =
I suggest<br>
&gt;=C2=A0 =C2=A0 =C2=A0remembering<br>
&gt;=C2=A0 =C2=A0 =C2=A0the width and height instead of pointers and compar=
ing them. This way<br>
&gt;=C2=A0 =C2=A0 =C2=A0you can free resources in set_mode().<br>
&gt; <br>
&gt; <br>
&gt; Yeah, I suppose that works, I can change that around.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_mtl_texture=
_to_surface_mem(texture, vram);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Writing vram outside BQL may result in tearing.<br>
&gt; <br>
&gt; <br>
&gt; As far as I can tell(*), QXL does the same. I couldn&#39;t find any ex=
amples <br>
&gt; of double-buffering in any of the existing display devices, which woul=
d <br>
&gt; be the only way to do async updates efficiently and without tearing. I=
n <br>
&gt; any case, this solution is still vastly better than a regular VGA <br>
&gt; device, which suffers from very visible tearing with macOS on the gues=
t <br>
&gt; side anyway. And in an ideal world, we&#39;d pass through the rendered=
 <br>
&gt; texture directly to the Cocoa UI code rather than copying out only for=
 <br>
&gt; the CPU to draw it back into a window surface which is then passed to =
<br>
&gt; the GPU for host side rendering. But I felt this patch is already very=
, <br>
&gt; very large, and if anyone cares, we can fix imperfections in subsequen=
t <br>
&gt; updates.<br>
&gt; <br>
&gt; (*)The rendering code in that device is also fairly complex, so I may =
be <br>
&gt; misreading it.<br>
<br>
QXL always modifies the surface with BQL. The surface is modified with <br>
qxl_blit(), which is called by qxl_render_update_area_unlocked(). <br>
qxl_render_update_area_unlocked() is called by either of <br>
qxl_render_update() and qxl_render_update_area_bh(). Both of them are <br>
called with BQL. The name includes &quot;unlocked&quot;, but it means it is=
 called <br>
without holding QXL-internal lock.<br>
<br>
Most devices works entirely with BQL so they don&#39;t perform double <br>
buffering. apple-gfx can do the same.<br></blockquote><div><br></div><div>I=
 think we can safely move apple-gfx&#39;s framebuffer state management back=
 inside the BQL, yes. I just figured that copying dozens of megabytes of fr=
amebuffer data on every frame while holding the lock was not going to help =
BQL contention. Especially as PVG does not have a concept of dirty areas, s=
o we must copy the whole framebuffer every time. (Unless we were to impleme=
nt dirty area detection ourselves.)</div><div><br></div><div>Unfortunately,=
 implementing double-buffering would require a major rework of Qemu&#39;s w=
hole surface management, console code, and probably most of the UI implemen=
tations. I&#39;m guessing the OpenGL fast-path sidesteps all of this, so re=
plicating that with Metal would probably be the easier way forward. (Althou=
gh doing all this graphics stuff inside the BQL generally seems like a majo=
r architectural flaw; I suppose most enterprise use of Qemu does not involv=
e the framebuffer, so it&#39;s not shown up in BQL contention profiling the=
re. It certainly does in desktop use, although at least on macOS hosts ther=
e are far worse culprits in that regard.)<br></div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;gfx_up=
date_requested) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;gfx_update_requested =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dp=
y_gfx_update_full(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gr=
aphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;new_frame_ready =3D false;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This assignment is unnecessary as s-&gt;new_frame_r=
eady is always false<br>
&gt;=C2=A0 =C2=A0 =C2=A0when s-&gt;gfx_update_requested. If you want to mak=
e sure<br>
&gt;=C2=A0 =C2=A0 =C2=A0s-&gt;gfx_update_requested and s-&gt;new_frame_read=
y are mutually exclusive,<br>
&gt;=C2=A0 =C2=A0 =C2=A0use one enum value instead of having two bools.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;ll need to refresh my memory and get back to you on this one, it=
&#39;s <br>
&gt; been so many months since I actively worked on this code.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;new_frame_ready =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; =
0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_render=
_new_frame(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_gfx_fb_update_display(void=
 *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_async(s-&gt;render_qu=
eue, ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pendin=
g_frames &gt; 0) {<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It should check for s-&gt;new_frame_ready as<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_render_frame_completed() doesn&#39;t chec=
k if<br>
&gt;=C2=A0 =C2=A0 =C2=A0s-&gt;pending_frames &gt; 0 before calling graphic_=
hw_update_done(), which is<br>
&gt;=C2=A0 =C2=A0 =C2=A0inconsistent.<br>
&gt; <br>
&gt; <br>
&gt; pending_frames is about guest-side frames that are queued to be render=
ed <br>
&gt; by the host GPU.<br>
&gt; new_frame_ready being true indicates that the contents of the Qemu <br=
>
&gt; console surface has been updated with new frame data since the last <b=
r>
&gt; gfx_update.<br>
&gt; gfx_update_requested indicates that gfx_update is currently awaiting a=
n <br>
&gt; async completion (graphic_hw_update_done) but the surface has not <br>
&gt; received a new frame content, but the GPU is stily busy drawing one.<b=
r>
&gt; <br>
&gt; apple_gfx_render_frame_completed is scheduled exactly once per pending=
 <br>
&gt; frame, so pending_frames &gt; 0 is an invariant there. (Hence the asse=
rt.)&gt; &gt; I don&#39;t think there is any inconsistency here, but I&#39;=
ll double check.<br>
&gt; It&#39;s possible that there&#39;s an easier way to express the state =
machine, <br>
&gt; and I&#39;ll take a look at that.<br>
<br>
I meant that apple_gfx_render_frame_completed() does not check if the <br>
frame is the last one currently pending. apple_gfx_fb_update_display() <br>
ignores a new ready frame when there is a more pending frame, but <br>
apple_gfx_render_frame_completed() unconditionally fires <br>
graphic_hw_update_done() even if there is a more pending frame. And I <br>
think apple_gfx_render_frame_completed() is right and <br>
apple_gfx_fb_update_display() is wrong in such a situation.<br>
<br></blockquote><div><br></div><div>OK, got it. And yes, I agree.<br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Checking if s-&gt;pending_frames &gt; 0 both in app=
le_gfx_fb_update_display()<br>
&gt;=C2=A0 =C2=A0 =C2=A0and apple_gfx_render_frame_completed() is also prob=
lematic as that can<br>
&gt;=C2=A0 =C2=A0 =C2=A0defer graphic_hw_update_done() indefinitely if we a=
re getting new<br>
&gt;=C2=A0 =C2=A0 =C2=A0frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0too fast.<br>
&gt; <br>
&gt; <br>
&gt; I see what you mean about this part. I&#39;ll have to test it, but I g=
uess <br>
&gt; we should reverse the priority, like this:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;new_frame_ready) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-=
&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =
=3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done=
(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;pending_frames &gt;=
 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_reque=
sted =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done=
(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; 1. If we already have a frame, ready to be displayed, return it immedi=
ately.<br>
&gt; 2. If the guest has reported that it&#39;s completed a frame and the G=
PU is <br>
&gt; currently busy rendering it, defer graphic_hw_update_done until it&#39=
;s done.<br>
&gt; 3. If the guest reports no changes to its display, indicate this back =
to <br>
&gt; Qemu as a no-op display update graphic_hw_update_done() with no <br>
&gt; dpy_gfx_update* call.<br>
<br>
Yes, that looks correct.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;gfx_update_requested =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;new_frame_ready) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s-&gt;new_frame_ready =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gr=
aphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }&gt; +=C2=
=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const GraphicHwOps apple_gfx_fb_ops =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .gfx_update =3D apple_gfx_fb_u=
pdate_display,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .gfx_update_async =3D true,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void update_cursor(AppleGFXState *s)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, s-&gt=
;pgdisp.cursorPosition.x,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 s-&gt;pgdisp.cursorPosition.y, s-&gt;cursor_show);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void set_mode(AppleGFXState *s, uint3=
2_t width, uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0height)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 void *vram =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MTLTextureDescriptor *textureD=
escriptor;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture =
=3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 __block bool no_change =3D fal=
se;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_sync(s-&gt;render_que=
ue,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Calling dispatch_sync() while holding BQL may resul=
t in deadlock.<br>
&gt; <br>
&gt; Only if any code executed on the same dispatch queue acquires the lock=
 <br>
&gt; either directly or transitively. I believe I have ensure this is not <=
br>
&gt; done on the reqnder_queue, have you found anywhere this is the case?<b=
r>
<br>
The documentation is not clear what threads a dispatch queue runs on. We <b=
r>
can have a deadlock if they lock the BQL.<br></blockquote><div><br></div><d=
iv>dispatch_sync is a synchronisation primitive (it waits for and asserts e=
xclusive access to the given queue), it doesn&#39;t actually do any thread =
scheduling. Work scheduled asynchronously to non-main dispatch queues will =
otherwise run on libdispatch pool threads. Running blocks on dispatch queue=
s will not preempt and schedule it on other threads which may or may not be=
 holding some locks.</div><div><br></div><div>So the only way this code wil=
l deadlock is if any code scheduled to render_queue directly or transitivel=
y acquires the BQL. None of it does, although updating the console while ho=
lding the BQL rather complicates this.<br></div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;surface &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 width =3D=3D surface_width(s-&gt;surface) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 height =3D=3D surface_height(s-&gt;surface)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 no_change =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (no_change) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vram =3D g_malloc0(width * hei=
ght * 4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 surface =3D qemu_create_displa=
ysurface_from(width, height,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PIXMAN_LE_a8r8g8b8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width * 4, vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescripto=
r =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [M=
TLTextureDescriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0texture2DDescriptorWithPixelFormat:MTLPixelFormatBG=
RA8Unorm<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width:width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 height:height<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mipmapped:NO];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescripto=
r.usage =3D s-&gt;pgdisp.minimumTextureUsage;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 texture =3D [s-&=
gt;mtl<br>
&gt;=C2=A0 =C2=A0 =C2=A0newTextureWithDescriptor:textureDescriptor];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;using_managed_texture_st=
orage =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (texture.storage=
Mode =3D=3D MTLStorageModeManaged);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispatch_sync(s-&gt;render_que=
ue,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id=
&lt;MTLTexture&gt; old_texture =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vo=
id *old_vram =3D s-&gt;vram;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;vram =3D vram;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;surface =3D surface;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dp=
y_gfx_replace_surface(s-&gt;con, surface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ol=
d_texture =3D s-&gt;texture;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;texture =3D texture;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [o=
ld_texture release];<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0You can just do:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[s-&gt;texture release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0s-&gt;texture =3D texture;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This will make s-&gt;texture dangling between the t=
wo statements, but that<br>
&gt;=C2=A0 =C2=A0 =C2=A0don&#39;t matter since s-&gt;texture is not an atom=
ic variable that can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0safely observed from another thread anyway.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;pending_frames =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 g_free(old_vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_fb(AppleGFXState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_=
init(NULL, 0, &amp;apple_gfx_fb_ops, s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 set_mode(s, 1440, 1080);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;cursor_show =3D true;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static size_t apple_gfx_get_default_mmio_ran=
ge_size(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_t mmio_range_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescript=
or *desc =3D [PGDeviceDescriptor new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size =
=3D desc.mmioLength;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return mmio_range_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_common_init(Object *obj, Appl=
eGFXState *s, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0char* obj_name)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This function can be merged into apple_gfx_common_r=
ealize().<br>
&gt; <br>
&gt; <br>
&gt; Probably. I&#39;ll try it.<br></blockquote><div><br></div><div>Upon fu=
rther inspection, we need to call cocoa_enable_runloop_on_main_thread() dur=
ing the init phase, not realize(). So we can&#39;t get rid of this entirely=
. Is there any value in moving the other init code into _realize()?<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_t mmio_range_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_get_default_mmio_range_size();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace_apple_gfx_common_init(ob=
j_name, mmio_range_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&=
gt;iomem_gfx, obj, &amp;apple_gfx_ops, s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0obj_name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;iomem_gfx.disable_reentr=
ancy_guard =3D true;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why do you disable reentrancy guard?<br>
&gt; <br>
&gt; <br>
&gt; Perhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this won&#3=
9;t be <br>
&gt; an issue anymore, but the guard would otherwise keep dropping MMIOs <b=
r>
&gt; which immediately caused the PV graphics device to stop making progres=
s. <br>
&gt; The MMIO APIs in the PVG framework are thread- and reentrancy-safe, so=
 <br>
&gt; we certainly don&#39;t need to serialise them on our side.<br>
<br>
It&#39;s better to understand why such reentrancy happens. Reentrancy itsel=
f <br>
is often a sign of bug.<br>
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* TODO: PVG framework support=
s serialising device state:<br>
&gt;=C2=A0 =C2=A0 =C2=A0integrate it! */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (apple_gfx_mig_blocker =3D=
=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;=
apple_gfx_mig_blocker,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;Migration state blocked by apple-gfx display<br>
&gt;=C2=A0 =C2=A0 =C2=A0device&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D migrate_ad=
d_blocker(&amp;apple_gfx_mig_blocker, &amp;local_err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r &lt; 0) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 er=
ror_report_err(local_err);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please report the error to the caller of apple_gfx_=
common_realize()<br>
&gt;=C2=A0 =C2=A0 =C2=A0instead.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +}&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_register_task_mapping_handlers(AppleGFXSt=
ate *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.createTask =3D ^(uint64_t=
 vmSize, void * _Nullable *<br>
&gt;=C2=A0 =C2=A0 =C2=A0_Nonnull baseAddress) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXTask *ta=
sk =3D apple_gfx_new_task(s, vmSize);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *baseAddress =3D=
 (void*)task-&gt;address;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0nit: please write as (void *) instead of (void*).<b=
r>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
create_task(vmSize, *baseAddress);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc=
 =3D [PGDisplayDescriptor new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; + <a href=3D"http://disp_desc.name" rel=3D"no=
referrer" target=3D"_blank">disp_desc.name</a> &lt;<a href=3D"http://disp_d=
esc.name" rel=3D"noreferrer" target=3D"_blank">http://disp_desc.name</a>&gt=
; =3D @&quot;QEMU display&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.sizeInMillimeters =
=3D NSMakeSize(400., 300.); /* A<br>
&gt;=C2=A0 =C2=A0 =C2=A020&quot; display */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.queue =3D dispatch_g=
et_main_queue();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.newFrameEventHandler=
 =3D ^(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
new_frame();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(s=
-&gt;render_queue, ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 Drop frames if we get too far ahead. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;pending_frames &gt;=3D 2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++=
s-&gt;pending_frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (s-&gt;pending_frames &gt; 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @a=
utoreleasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 apple_gfx_render_new_frame(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.modeChangeHandler =
=3D ^(PGDisplayCoord_t sizeInPixels,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 OSType pixelFormat) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
mode_change(sizeInPixels.x, sizeInPixels.y);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mode(s, size=
InPixels.x, sizeInPixels.y);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.cursorGlyphHandler =
=3D ^(NSBitmapImageRep *glyph,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PGDisplayCoord_t hotSpot) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t bpp =3D=
 glyph.bitsPerPixel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t width =3D=
 glyph.pixelsWide;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t height =
=3D glyph.pixelsHigh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t padding_b=
ytes_per_row =3D glyph.bytesPerRow - width<br>
&gt;=C2=A0 =C2=A0 =C2=A0* 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t* p=
x_data =3D glyph.bitmapData;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
cursor_set(bpp, width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;cursor=
) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cu=
rsor_unref(s-&gt;cursor);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;cursor =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bpp =3D=3D 3=
2) { /* Shouldn&#39;t be anything else, but just<br>
&gt;=C2=A0 =C2=A0 =C2=A0to be safe...*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;cursor =3D cursor_alloc(width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;cursor-&gt;hot_x =3D hotSpot.x;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-=
&gt;cursor-&gt;hot_y =3D hotSpot.y;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ui=
nt32_t *dest_px =3D s-&gt;cursor-&gt;data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fo=
r (size_t y =3D 0; y &lt; height; ++y) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 for (size_t x =3D 0; x &lt; width; ++x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* NSBitmapImageRep&#39;s red &amp; blue channe=
ls<br>
&gt;=C2=A0 =C2=A0 =C2=A0are swapped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* compared to QEMUCursor&#39;s. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *dest_px =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[0] &lt;&lt; 16u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[1] &lt;&lt;=C2=A0 8u) |<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[2] &lt;&lt;=C2=A0 0u) |<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data[3] &lt;&lt; 24u);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++dest_px;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 px_data +=3D padding_bytes_per_row;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dp=
y_cursor_define(s-&gt;con, s-&gt;cursor);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 up=
date_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.cursorShowHandler =
=3D ^(BOOL show) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
cursor_show(show);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor_sho=
w =3D show;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc.cursorMoveHandler =
=3D ^(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_=
cursor_move();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return disp_desc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static NSArray&lt;PGDisplayMode*&gt;*<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_prepare_display_mode_array(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDisplayMode *modes[ARRAY_SIZ=
E(apple_gfx_modes)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 NSArray&lt;PGDisplayMode*&gt;*=
 mode_array =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZ=
E(apple_gfx_modes); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[=
PGDisplayMode alloc]<br>
&gt;=C2=A0 =C2=A0 =C2=A0initWithSizeInPixels:apple_gfx_modes[i] refreshRate=
InHz:60.];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mode_array =3D [NSArray arrayW=
ithObjects:modes<br>
&gt;=C2=A0 =C2=A0 =C2=A0count:ARRAY_SIZE(apple_gfx_modes)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZ=
E(apple_gfx_modes); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [modes[i] releas=
e];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D nil=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return mode_array;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static id&lt;MTLDevice&gt; copy_suitable_met=
al_device(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt;MTLDevice&gt; dev =3D ni=
l;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 NSArray&lt;id&lt;MTLDevice&gt;=
&gt; *devs =3D MTLCopyAllDevices();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Prefer a unified memory GPU=
. Failing that, pick a non-<br>
&gt;=C2=A0 =C2=A0 =C2=A0removable GPU. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; de=
vs.count; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devs[i].hasU=
nifiedMemory) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v =3D devs[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 br=
eak;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!devs[i].rem=
ovable) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 de=
v =3D devs[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (dev !=3D nil) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dev retain];<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D MTLCreat=
eSystemDefaultDevice();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [devs release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 return dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_common_realize(AppleGFXState =
*s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc=
 =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;s-&gt;tasks);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;render_queue =3D dispatc=
h_queue_create(&quot;apple-gfx.render&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DISPATCH_QUEUE_SERIAL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;mtl =3D copy_suitable_me=
tal_device();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;mtl_queue =3D [s-&gt;mtl=
 newCommandQueue];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.device =3D s-&gt;mtl;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 apple_gfx_register_task_mappin=
g_handlers(s, desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;pgdev =3D PGNewDeviceWit=
hDescriptor(desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_desc =3D apple_gfx_prepar=
e_display_handlers(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;pgdisp =3D [s-&gt;pgdev =
newDisplayWithDescriptor:disp_desc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:0<br>
&gt;=C2=A0 =C2=A0 =C2=A0serialNum:1234];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [disp_desc release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D appl=
e_gfx_prepare_display_mode_array();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 create_fb(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/meson.build b/hw/disp=
lay/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 7db05eace97..70d855749c0 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -65,6 +65,8 @@ system_ss.add(when: &#39;CO=
NFIG_ARTIST&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0files(&#39;artist.c&#39;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_A=
TI_VGA&#39;, if_true: [files(&#39;ati.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;ati_2d.c&#39;, &#39;ati_dbg.c&#39;), pixman])<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;apple-gfx.m&#39;), pvg, metal])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG_VMAP=
PLE&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;apple-gfx-vmapple.m&#39;), pvg, metal])=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#3=
9;CONFIG_VIRTIO_GPU&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.sourc=
e_set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/display/trace-events b/hw/dis=
play/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 781f8a33203..1809a358e36 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned =
dest_width)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;dest_width : %u&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_leds(int led, uint32_t valu=
e) &quot;led %d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_channels(int channel, uint8=
_t value) &quot;channel %d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_refresh_rate(uint32_t rr) &=
quot;refresh rate %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_read(uint64_t offset, uint64_t res=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; res=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_write(uint64_t offset, uint64_t va=
l)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; val=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_create_task(uint32_t vm_size, void=
 *va) &quot;vm_size=3D0x%x<br>
&gt;=C2=A0 =C2=A0 =C2=A0base_addr=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_destroy_task(void *task) &quot;tas=
k=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_map_memory(void *task, uint32_t ra=
nge_count, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtual_offset, uint32_t read_only) &quot;task=3D%p=
 range_count=3D0x%x<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtual_offset=3D0x%&quot;PRIx64&quot; read_only=3D=
%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_map_memory_range(uint32_t i, uint6=
4_t phys_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t phys_len) &quot;[%d] phys_addr=3D0x%&quot;=
PRIx64&quot; phys_len=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_remap(uint64_t retval, uint64_t so=
urce, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0target) &quot;retval=3D%&quot;PRId64&quot; source=
=3D0x%&quot;PRIx64&quot; target=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_unmap_memory(void *task, uint64_t =
virtual_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t length) &quot;task=3D%p virtual_offset=3D0=
x%&quot;PRIx64&quot; length=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_read_memory(uint64_t phys_address,=
 uint64_t length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *dst) &quot;phys_addr=3D0x%&quot;PRIx64&quot; =
length=3D0x%&quot;PRIx64&quot; dest=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_raise_irq(uint32_t vector) &quot;v=
ector=3D0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_new_frame(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_mode_change(uint64_t x, uint64_t y=
) &quot;x=3D%&quot;PRId64&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0y=3D%&quot;PRId64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_set(uint32_t bpp, uint64_t =
width, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0height) &quot;bpp=3D%d width=3D%&quot;PRId64&quot; =
height=3D0x%&quot;PRId64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_show(uint32_t show) &quot;s=
how=3D%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_move(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_common_init(const char *device_nam=
e, size_t mmio_size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;device: %s; MMIO size: %zu bytes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# apple-gfx-vmapple.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_read(uint64_t offset, uint64_t r=
es)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; res=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_write(uint64_t offset, uint64_t =
val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PRIx64&quot; val=3D0x%&quot=
;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_map_memory(uint64_t phys, uint64=
_t len, uint32_t ro,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *va, void *e, void *f) &quot;phys=3D0x%&quot;P=
RIx64&quot; len=3D0x%&quot;PRIx64&quot; ro=3D%d<br>
&gt;=C2=A0 =C2=A0 =C2=A0va=3D%p e=3D%p f=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_unmap_memory(void *a, void *b, v=
oid *c, void *d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0void *e, void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p=
 e=3D%p f=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_raise_irq(uint32_t vector) &quot=
;vector=3D0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/meson.build b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 10464466ff3..f09df3f09d5 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -741,6 +741,8 @@ socket =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0version_res =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0coref =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0iokit =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +pvg =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0emulator_link_args =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0midl =3D not_found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0widl =3D not_found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -762,6 +764,8 @@ elif host_os =3D=3D &#39;=
darwin&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0coref =3D dependency(&#39;=
appleframeworks&#39;, modules: &#39;CoreFoundation&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0iokit =3D dependency(&#39;=
appleframeworks&#39;, modules: &#39;IOKit&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0required: false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0host_dsosuf =3D &#39;.dyli=
b&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 pvg =3D dependency(&#39;appleframewor=
ks&#39;, modules:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;ParavirtualizedGraphics&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 metal =3D dependency(&#39;appleframew=
orks&#39;, modules: &#39;Metal&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0elif host_os =3D=3D &#39;sunos&#3=
9;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0socket =3D [cc.find_librar=
y(&#39;socket&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0cc.find_library(&#39;nsl&#39;),<br>
&gt; <br>
<br>
</blockquote></div></div>

--00000000000032f0df0623cc857b--

