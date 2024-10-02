Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3673CF6D25
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzU5-0006sU-V6; Wed, 02 Oct 2024 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1svzTr-0006rY-Da
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:33:27 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1svzTk-0000FV-8B
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:33:25 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84e873a454fso1872979241.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727875997; x=1728480797;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vKS+16BKyV5ZJqHTeCC3k/7UCYB1jLV7k66e4pHu5z4=;
 b=o2z7zQsws+OX8sYpd/prLs7X0I10+H8zcqJZG3nJ2tgpwEaCU218qZDzbA343EsHAd
 WHHNCWpVyjNSGj2kcW6O/SX0HhisY0U8tVUYkSWtagf8ZECsTAROJf+lRDjxr02yNcFw
 Rq2ggfX3uBebeZVf3x3CCfK++tDKJWM20trI/VZifO22keQN3X01XhFR5BTc3krDo/9L
 zITdwO5TtTEmDuzHKAoxVmyDD9bikglQ18m9QZcP5e/t11wLelk3kN7UXKIg8OlZHLah
 F/M44/jj1Ez7MPM2sNx8R2U4HinPXq8oaxltZJpolK2mePVbuStYgXTdMg/u74zFeWqU
 AD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727875997; x=1728480797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKS+16BKyV5ZJqHTeCC3k/7UCYB1jLV7k66e4pHu5z4=;
 b=Hvx68fwJeTturo274OEaLG46KNJUfSvkr/e02Jywvb7q5sYKACag6C7DIeu4OYEoGx
 Uv82UZXar6yzPgJq6vHp09EebR0+z2xfM9++EkarxCKdAjv4tS/5yxc5KzS11WNKbCOv
 G0Ic9U5UlrlVPqjkinNfPtVe0Grir9SItGvGtEgdZlK5F18eWH7cU/bcDVhswDWDIYqm
 hFgEbf0S9y9eqgPooBJdHINajJxfgRr+CNTRHxkL1jiz5NsPauF6ceNtghLzWLWdqo/m
 nEdc2z5CdqN4ElTdvwc4lnbU4D6mV8xnynV+ZrOczk9ItiQ2SEquGZZ6SqEam95EdHqZ
 mkLA==
X-Gm-Message-State: AOJu0YwINT8fIRX+ZVUtA0NnxRCQxp+i/zrk19CdX49q5jAl/y13d0hR
 vEck4L28rR9yXIMWChKOFQLO64quhDEC+DGXMZAOdkTBH8qUcrQvZdtDMM+w3L5spPAtX1qnUaF
 wyzp3Zh7QeHGWxmWqNf0IKArx47zfGMUl57XR
X-Google-Smtp-Source: AGHT+IHISeThqmaBOWtbw+KQsSlyQfRhP7EYXXPhtor9Z5cQ+eUNBsCxgm6f1lpoLbXf+0k8PMjLTtmcHDaDPqyrPkI=
X-Received: by 2002:a05:6122:a17:b0:509:197b:3e2 with SMTP id
 71dfb90a1353d-50c5823c2d8mr2400353e0c.11.1727875996641; Wed, 02 Oct 2024
 06:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-2-phil@philjordan.eu>
 <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
In-Reply-To: <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 2 Oct 2024 15:33:05 +0200
Message-ID: <CAAibmn1+Z0zcB-vQ3ZbrY0o7wtev+YtV1EOCH-4s=PfQg_Pd8A@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000ff177d06237e7ac9"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92d;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92d.google.com
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

--000000000000ff177d06237e7ac9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for taking a close look at this.

There are some further comments, explanations, and also a few questions
inline below. Where I've not commented, I'll just go ahead and make the
suggested change for v4.

On Tue, 1 Oct 2024 at 11:40, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

>
> > This patch implements a QEMU device that drives PVG for the VMApple
> > variant of it.
>
> I think it is better to name it MMIO variant instead of VMApple. There
> is nothing specific to VMApple in: hw/display/apple-gfx-vmapple.m
>

I mean, I don't see it being useful for anything whatsoever outside the
vmapple machine type=E2=80=A6 But I guess there's little harm in renaming i=
t.


> > +#include "apple-gfx.h"
> > +#include "monitor/monitor.h"
> > +#include "hw/sysbus.h"
> > +#include "hw/irq.h"
> > +#include "trace.h"
> > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> > +
> > +_Static_assert(__aarch64__, "");
>
> I don't think this assertion is worthwhile. This assertion will trigger
> if you accidentally remove depends on AARCH64 from Kconfig, but I don't
> think such code change happens by accident, and there is no reason to
> believe that this assertion won't be removed in such a case.
>

As far as I'm aware the Kconfig AARCH64 dependency is for the *target*
architecture, not the *host* architecture? The static assert checks for the
latter. The PGIOSurfaceHostDeviceDescriptor type isn't available at all on
non-aarch64 macOS hosts. I've not had any luck with using this variant of
the device on x86-64 hosts simply by disabling any surface mapper code.

Incidentally, if you know of a way to depend on a specific *host*
architecture in the Kconfig, that would be even better. I couldn't spot a
way of doing that though.

> +
> > +/*
> > + * ParavirtualizedGraphics.Framework only ships header files for the P=
CI
> > + * variant which does not include IOSFC descriptors and host devices.
> We add
> > + * their definitions here so that we can also work with the ARM versio=
n.
> > + */
> > +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
> > +typedef bool(^IOSFCUnmapMemory)(
> > +    void *a, void *b, void *c, void *d, void *e, void *f);
>
> Omit dummy parameter names.
>


> > +@end
> > +
> > +typedef struct AppleGFXVmappleState {
> > +    SysBusDevice parent_obj;
> > +
> > +    AppleGFXState common;
> > +
> > +    qemu_irq irq_gfx;
> > +    qemu_irq irq_iosfc;
> > +    MemoryRegion iomem_iosfc;
> > +    PGIOSurfaceHostDevice *pgiosfc;
> > +} AppleGFXVmappleState;
> > +
> > +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXVmappleState, APPLE_GFX_VMAPPLE)
> > +
> > +
> > +static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigned
> size)
> > +{
> > +    AppleGFXVmappleState *s =3D opaque;
> > +    uint64_t res =3D 0;
> > +
> > +    bql_unlock();
>
> It is dangerous to unlock BQL at an arbitrary place. Instead of
> unlocking, I suggest:
> - running [s->pgiosfc mmioReadAtOffset:offset] on another thread
> - using a bottom half to request operations that require BQL from the
> thread running [s->pgiosfc mmioReadAtOffset:offset]
> - calling AIO_WAIT_WHILE() to process the bottom half and to wait for
> the completion of [s->pgiosfc mmioReadAtOffset:offset]
>

OK, I think I see what you mean, I'll try to rework things around that
pattern. Any preference on how I kick off the job on the other thread? As
we necessarily need to use libdispatch in a bunch of places in this code
anyway, I guess dispatch_async() would probably be the simplest?


> > +    res =3D [s->pgiosfc mmioReadAtOffset:offset];
> > +    bql_lock();
> > +
> > +    trace_apple_iosfc_read(offset, res);
> > +
> > +    return res;
> > +}
> > +
> > +static void apple_iosfc_write(
> > +    void *opaque, hwaddr offset, uint64_t val, unsigned size)
> > +{
> > +    AppleGFXVmappleState *s =3D opaque;
> > +
> > +    trace_apple_iosfc_write(offset, val);
> > +
> > +    [s->pgiosfc mmioWriteAtOffset:offset value:val];
> > +}
> > +
> > +static const MemoryRegionOps apple_iosfc_ops =3D {
> > +    .read =3D apple_iosfc_read,
> > +    .write =3D apple_iosfc_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 8,
> > +    },
> > +};
> > +
> > +static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device(
> > +    AppleGFXVmappleState *s)
> > +{
> > +    PGIOSurfaceHostDeviceDescriptor *iosfc_desc =3D
> > +        [PGIOSurfaceHostDeviceDescriptor new];
> > +    PGIOSurfaceHostDevice *iosfc_host_dev =3D nil;
> > +
> > +    iosfc_desc.mapMemory =3D
> > +        ^(uint64_t phys, uint64_t len, bool ro, void **va, void *e,
> void *f) {
> > +            trace_apple_iosfc_map_memory(phys, len, ro, va, e, f);
> > +            MemoryRegion *tmp_mr;
> > +            *va =3D gpa2hva(&tmp_mr, phys, len, NULL);
>
> Use: dma_memory_map()
>
>
That doesn't seem to be a precisely equivalent operation. It also says in
its headerdoc,

> Use only for reads OR writes - not for read-modify-write operations.

which I don't think we can guarantee here at all.

I guess I can call it twice, once for writing and once for reading, but
given that the dma_memory_unmap operation marks the area dirty, I'm not
it's intended for what I understand the use case here to be: As far as I
can tell, the PV graphics device uses (some) of this memory to exchange
data in a cache-coherent way between host and guest, e.g. as a lock-free
ring buffer, using atomic operations as necessary. (This works because it's
a PV device: it "knows" the other end just another CPU core (or even the
same one) executing in a different hypervisor context.) This doesn't really
match "traditional" DMA patterns where there's either a read or a write
happening.

Hunting around some more for alternative APIs, there's also
memory_region_get_ram_ptr(), but I'm not sure its restrictions apply here
either.

> +            return (bool)true;
>
> Why cast?
>

Good question. Not originally my code, so I've fixed all the instances I
could find now.


> > +        };
> > +
> > +    iosfc_desc.unmapMemory =3D
> > +        ^(void *a, void *b, void *c, void *d, void *e, void *f) {
> > +            trace_apple_iosfc_unmap_memory(a, b, c, d, e, f);
> > +            return (bool)true;
> > +        };
> > +
> > +    iosfc_desc.raiseInterrupt =3D ^(uint32_t vector) {
> > +        trace_apple_iosfc_raise_irq(vector);
> > +        bool locked =3D bql_locked();
> > +        if (!locked) {
> > +            bql_lock();
> > +        }
>  > +        qemu_irq_pulse(s->irq_iosfc);> +        if (!locked) {
> > +            bql_unlock();
> > +        }
> > +        return (bool)true;
> > +    };
> > +
> > +    iosfc_host_dev =3D
> > +        [[PGIOSurfaceHostDevice alloc] initWithDescriptor:iosfc_desc];
> > +    [iosfc_desc release];
> > +    return iosfc_host_dev;
> > +}
> > +
> > +static void apple_gfx_vmapple_realize(DeviceState *dev, Error **errp)
> > +{
> > +    @autoreleasepool {
>
> This autoreleasepool is not used.
>

It is definitely used inside the apple_gfx_common_realize() call. It's also
impossible to say whether [PGDeviceDescriptor new] uses autorelease
semantics internally, so it seemed safer to wrap the whole thing in an
outer pool.

> +        AppleGFXVmappleState *s =3D APPLE_GFX_VMAPPLE(dev);
> > +
> > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> > +        desc.usingIOSurfaceMapper =3D true;
> > +        desc.raiseInterrupt =3D ^(uint32_t vector) {
> > +            bool locked;
> > +
> > +            trace_apple_gfx_raise_irq(vector);
> > +            locked =3D bql_locked();
> > +            if (!locked) {
> > +                bql_lock();
> > +            }
> > +            qemu_irq_pulse(s->irq_gfx);
> > +            if (!locked) {
> > +                bql_unlock();
> > +            }
> > +        };
> > +
> > +        s->pgiosfc =3D apple_gfx_prepare_iosurface_host_device(s);
> > +
> > +        apple_gfx_common_realize(&s->common, desc);
> > +        [desc release];
> > +        desc =3D nil;
> > +    }
> > +}
> > +
>
>

> > +++ b/hw/display/apple-gfx.h
> > @@ -0,0 +1,57 @@
> > +#ifndef QEMU_APPLE_GFX_H
> > +#define QEMU_APPLE_GFX_H
> > +
> > +#define TYPE_APPLE_GFX_VMAPPLE      "apple-gfx-vmapple"
> > +#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
> > +
> > +#include "qemu/typedefs.h"
> > +
> > +typedef struct AppleGFXState AppleGFXState;
> > +
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*
> obj_name);
> > +
> > +#ifdef __OBJC__
>
> This ifdef is unnecessary.
>

Ah indeed; at one point, vmapple.c was #including this file, but that's no
longer necessary.


>
> > diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
> > new file mode 100644
> > index 00000000000..837300f9cd4
> > --- /dev/null
> > +++ b/hw/display/apple-gfx.m
> > @@ -0,0 +1,536 @@
> > +/*
> > + * QEMU Apple ParavirtualizedGraphics.framework device
> > + *
> > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Right=
s
> Reserved.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + * ParavirtualizedGraphics.framework is a set of libraries that macOS
> provides
> > + * which implements 3d graphics passthrough to the host as well as a
> > + * proprietary guest communication channel to drive it. This device
> model
> > + * implements support to drive that library from within QEMU.
> > + */
> > +
> > +#include "apple-gfx.h"
> > +#include "trace.h"
> > +#include "qemu/main-loop.h"
> > +#include "ui/console.h"
> > +#include "monitor/monitor.h"
> > +#include "qapi/error.h"
> > +#include "migration/blocker.h"
> > +#include <mach/mach_vm.h>
> > +#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> > +
> > +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> > +    { .x =3D 1440, .y =3D 1080 },
> > +    { .x =3D 1280, .y =3D 1024 },
> > +};
> > +
> > +typedef struct PGTask_s { // Name matches forward declaration in PG
> header
>
> Let's name it AppleGFXTask. It is a common practice to have the same tag
> name and typedef in QEMU.
>

This is defining a forward-declared type from framework headers which is
opaque from the framework's point of view. We do not get to choose its
struct name. The alternative is having casts wherever these objects are
being passed between our code and the framework. (See the original v1/v2
vmapple patch series for how messy this is.)


> > +static void apple_gfx_render_new_frame(AppleGFXState *s)
> > +{
> > +    BOOL r;
> > +    void *vram =3D s->vram;
> > +    uint32_t width =3D surface_width(s->surface);
> > +    uint32_t height =3D surface_height(s->surface);
> > +    MTLRegion region =3D MTLRegionMake2D(0, 0, width, height);
> > +    id<MTLCommandBuffer> command_buffer =3D [s->mtl_queue commandBuffe=
r];
> > +    id<MTLTexture> texture =3D s->texture;
> > +    r =3D [s->pgdisp encodeCurrentFrameToCommandBuffer:command_buffer
> > +                                             texture:texture
> > +                                              region:region];
> > +    if (!r) {
> > +        return;
> > +    }
> > +    [texture retain];
> > +    if (s->using_managed_texture_storage) {
> > +        /* "Managed" textures exist in both VRAM and RAM and must be
> synced. */
> > +        id<MTLBlitCommandEncoder> blit =3D [command_buffer
> blitCommandEncoder];
> > +        [blit synchronizeResource:texture];
> > +        [blit endEncoding];
> > +    }
> > +    [command_buffer retain];
>
> I don't think this call of retain is necessary. The completion handler
> gets the command buffer via parameter, which implies the command buffer
> is automatically retained until the completion handler finishes.
>

I couldn't find any hard guarantees for this documented anywhere, hence
erring on the side of caution. I think the harm of an additional
retain/release pair here is quite minor.


> > +static void apple_gfx_render_frame_completed(AppleGFXState *s, void
> *vram,
> > +                                             id<MTLTexture> texture)
> > +{
> > +    --s->pending_frames;
> > +    assert(s->pending_frames >=3D 0);
> > +
> > +    if (vram !=3D s->vram) {
> > +        /* Display mode has changed, drop this old frame. */
> > +        assert(texture !=3D s->texture);
> > +        g_free(vram);
>
> This management of buffers looks a bit convoluted. I suggest remembering
> the width and height instead of pointers and comparing them. This way
> you can free resources in set_mode().
>

Yeah, I suppose that works, I can change that around.

> +    } else {
> > +        copy_mtl_texture_to_surface_mem(texture, vram);
>
> Writing vram outside BQL may result in tearing.
>

As far as I can tell(*), QXL does the same. I couldn't find any examples of
double-buffering in any of the existing display devices, which would be the
only way to do async updates efficiently and without tearing. In any case,
this solution is still vastly better than a regular VGA device, which
suffers from very visible tearing with macOS on the guest side anyway. And
in an ideal world, we'd pass through the rendered texture directly to the
Cocoa UI code rather than copying out only for the CPU to draw it back into
a window surface which is then passed to the GPU for host side rendering.
But I felt this patch is already very, very large, and if anyone cares, we
can fix imperfections in subsequent updates.

(*)The rendering code in that device is also fairly complex, so I may be
misreading it.


> > +        if (s->gfx_update_requested) {
> > +            s->gfx_update_requested =3D false;
> > +            dpy_gfx_update_full(s->con);
> > +            graphic_hw_update_done(s->con);
>  > +            s->new_frame_ready =3D false;
>
> This assignment is unnecessary as s->new_frame_ready is always false
> when s->gfx_update_requested. If you want to make sure
> s->gfx_update_requested and s->new_frame_ready are mutually exclusive,
> use one enum value instead of having two bools.
>

I'll need to refresh my memory and get back to you on this one, it's been
so many months since I actively worked on this code.


> > +        } else {
> > +            s->new_frame_ready =3D true;
> > +        }
> > +    }
> > +    if (s->pending_frames > 0) {
> > +        apple_gfx_render_new_frame(s);
> > +    }
> > +}
> > +
> > +static void apple_gfx_fb_update_display(void *opaque)
> > +{
> > +    AppleGFXState *s =3D opaque;
> > +
> > +    dispatch_async(s->render_queue, ^{
> > +        if (s->pending_frames > 0) {
>
> It should check for s->new_frame_ready as
> apple_gfx_render_frame_completed() doesn't check if
> s->pending_frames > 0 before calling graphic_hw_update_done(), which is
> inconsistent.
>

pending_frames is about guest-side frames that are queued to be rendered by
the host GPU.
new_frame_ready being true indicates that the contents of the Qemu console
surface has been updated with new frame data since the last gfx_update.
gfx_update_requested indicates that gfx_update is currently awaiting an
async completion (graphic_hw_update_done) but the surface has not received
a new frame content, but the GPU is stily busy drawing one.

apple_gfx_render_frame_completed is scheduled exactly once per pending
frame, so pending_frames > 0 is an invariant there. (Hence the assert.)

I don't think there is any inconsistency here, but I'll double check. It's
possible that there's an easier way to express the state machine, and I'll
take a look at that.



> Checking if s->pending_frames > 0 both in apple_gfx_fb_update_display()
> and apple_gfx_render_frame_completed() is also problematic as that can
> defer graphic_hw_update_done() indefinitely if we are getting new frames
> too fast.
>

I see what you mean about this part. I'll have to test it, but I guess we
should reverse the priority, like this:

        if (s->new_frame_ready) {
            dpy_gfx_update_full(s->con);
            s->new_frame_ready =3D false;
            graphic_hw_update_done(s->con);
        } else if (s->pending_frames > 0) {
            s->gfx_update_requested =3D true;
        } else {
            graphic_hw_update_done(s->con);
        }

1. If we already have a frame, ready to be displayed, return it immediately=
.
2. If the guest has reported that it's completed a frame and the GPU is
currently busy rendering it, defer graphic_hw_update_done until it's done.
3. If the guest reports no changes to its display, indicate this back to
Qemu as a no-op display update graphic_hw_update_done() with no
dpy_gfx_update* call.



> > +            s->gfx_update_requested =3D true;
> > +        } else {
> > +            if (s->new_frame_ready) {
> > +                dpy_gfx_update_full(s->con);
> > +                s->new_frame_ready =3D false;
> > +            }
> > +            graphic_hw_update_done(s->con);
>  > +        }> +    });
> > +}
> > +
> > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> > +    .gfx_update =3D apple_gfx_fb_update_display,
> > +    .gfx_update_async =3D true,
> > +};
> > +
> > +static void update_cursor(AppleGFXState *s)
> > +{
> > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> > +                  s->pgdisp.cursorPosition.y, s->cursor_show);
> > +}
> > +
> > +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t height=
)
> > +{
> > +    void *vram =3D NULL;
> > +    DisplaySurface *surface;
> > +    MTLTextureDescriptor *textureDescriptor;
> > +    id<MTLTexture> texture =3D nil;
> > +    __block bool no_change =3D false;
> > +
> > +    dispatch_sync(s->render_queue,
>
> Calling dispatch_sync() while holding BQL may result in deadlock.
>

Only if any code executed on the same dispatch queue acquires the lock
either directly or transitively. I believe I have ensure this is not done
on the reqnder_queue, have you found anywhere this is the case?


> > +        ^{
> > +            if (s->surface &&
> > +                width =3D=3D surface_width(s->surface) &&
> > +                height =3D=3D surface_height(s->surface)) {
> > +                no_change =3D true;
> > +            }
> > +        });
> > +
> > +    if (no_change) {
> > +        return;
> > +    }
> > +
> > +    vram =3D g_malloc0(width * height * 4);
> > +    surface =3D qemu_create_displaysurface_from(width, height,
> PIXMAN_LE_a8r8g8b8,
> > +                                              width * 4, vram);
> > +
> > +    @autoreleasepool {
> > +        textureDescriptor =3D
> > +            [MTLTextureDescriptor
> > +
> texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> > +                                             width:width
> > +                                            height:height
> > +                                         mipmapped:NO];
> > +        textureDescriptor.usage =3D s->pgdisp.minimumTextureUsage;
> > +        texture =3D [s->mtl newTextureWithDescriptor:textureDescriptor=
];
> > +    }
> > +
> > +    s->using_managed_texture_storage =3D
> > +        (texture.storageMode =3D=3D MTLStorageModeManaged);
> > +
> > +    dispatch_sync(s->render_queue,
> > +        ^{
> > +            id<MTLTexture> old_texture =3D nil;
> > +            void *old_vram =3D s->vram;
> > +            s->vram =3D vram;
> > +            s->surface =3D surface;
> > +
> > +            dpy_gfx_replace_surface(s->con, surface);
> > +
> > +            old_texture =3D s->texture;
> > +            s->texture =3D texture;
> > +            [old_texture release];
>
> You can just do:
> [s->texture release];
> s->texture =3D texture;
>
> This will make s->texture dangling between the two statements, but that
> don't matter since s->texture is not an atomic variable that can be
> safely observed from another thread anyway.
>
> > +
> > +            if (s->pending_frames =3D=3D 0) {
> > +                g_free(old_vram);
> > +            }
> > +        });
> > +}
> > +
> > +static void create_fb(AppleGFXState *s)
> > +{
> > +    s->con =3D graphic_console_init(NULL, 0, &apple_gfx_fb_ops, s);
> > +    set_mode(s, 1440, 1080);
> > +
> > +    s->cursor_show =3D true;
> > +}
> > +
> > +static size_t apple_gfx_get_default_mmio_range_size(void)
> > +{
> > +    size_t mmio_range_size;
> > +    @autoreleasepool {
> > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];
> > +        mmio_range_size =3D desc.mmioLength;
> > +        [desc release];
> > +    }
> > +    return mmio_range_size;
> > +}
> > +
> > +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*
> obj_name)
>
> This function can be merged into apple_gfx_common_realize().
>

Probably. I'll try it.


> > +{
> > +    Error *local_err =3D NULL;
> > +    int r;
> > +    size_t mmio_range_size =3D apple_gfx_get_default_mmio_range_size()=
;
> > +
> > +    trace_apple_gfx_common_init(obj_name, mmio_range_size);
> > +    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s,
> obj_name,
> > +                          mmio_range_size);
> > +    s->iomem_gfx.disable_reentrancy_guard =3D true;
>
> Why do you disable reentrancy guard?
>

Perhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this won't be an
issue anymore, but the guard would otherwise keep dropping MMIOs which
immediately caused the PV graphics device to stop making progress. The MMIO
APIs in the PVG framework are thread- and reentrancy-safe, so we certainly
don't need to serialise them on our side.


> > +
> > +    /* TODO: PVG framework supports serialising device state: integrat=
e
> it! */
> > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> > +        error_setg(&apple_gfx_mig_blocker,
> > +                  "Migration state blocked by apple-gfx display
> device");
> > +        r =3D migrate_add_blocker(&apple_gfx_mig_blocker, &local_err);
> > +        if (r < 0) {
> > +            error_report_err(local_err);
>
> Please report the error to the caller of apple_gfx_common_realize()
> instead.
>
> > +        }
> > +    }
>  > +}> +
> > +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> > +                                                     PGDeviceDescripto=
r
> *desc)
> > +{
> > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nullable * _Nonnull
> baseAddress) {
> > +        AppleGFXTask *task =3D apple_gfx_new_task(s, vmSize);
> > +        *baseAddress =3D (void*)task->address;
>
> nit: please write as (void *) instead of (void*).
>
> > +        trace_apple_gfx_create_task(vmSize, *baseAddress);
> > +        return task;
> > +    };
> > +
>
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor new];
> > +
> > +    disp_desc.name =3D @"QEMU display";
> > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.); /* A 20"
> display */
> > +    disp_desc.queue =3D dispatch_get_main_queue();
> > +    disp_desc.newFrameEventHandler =3D ^(void) {
> > +        trace_apple_gfx_new_frame();
> > +        dispatch_async(s->render_queue, ^{
> > +            /* Drop frames if we get too far ahead. */
> > +            if (s->pending_frames >=3D 2)
> > +                return;
> > +            ++s->pending_frames;
> > +            if (s->pending_frames > 1) {
> > +                return;
> > +            }
> > +            @autoreleasepool {
> > +                apple_gfx_render_new_frame(s);
> > +            }
> > +        });
> > +    };
> > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t sizeInPixels,
> > +                                    OSType pixelFormat) {
> > +        trace_apple_gfx_mode_change(sizeInPixels.x, sizeInPixels.y);
> > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> > +    };
> > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,
> > +                                     PGDisplayCoord_t hotSpot) {
> > +        uint32_t bpp =3D glyph.bitsPerPixel;
> > +        size_t width =3D glyph.pixelsWide;
> > +        size_t height =3D glyph.pixelsHigh;
> > +        size_t padding_bytes_per_row =3D glyph.bytesPerRow - width * 4=
;
> > +        const uint8_t* px_data =3D glyph.bitmapData;
> > +
> > +        trace_apple_gfx_cursor_set(bpp, width, height);
> > +
> > +        if (s->cursor) {
> > +            cursor_unref(s->cursor);
> > +            s->cursor =3D NULL;
> > +        }
> > +
> > +        if (bpp =3D=3D 32) { /* Shouldn't be anything else, but just t=
o be
> safe...*/
> > +            s->cursor =3D cursor_alloc(width, height);
> > +            s->cursor->hot_x =3D hotSpot.x;
> > +            s->cursor->hot_y =3D hotSpot.y;
> > +
> > +            uint32_t *dest_px =3D s->cursor->data;
> > +
> > +            for (size_t y =3D 0; y < height; ++y) {
> > +                for (size_t x =3D 0; x < width; ++x) {
> > +                    /* NSBitmapImageRep's red & blue channels are
> swapped
> > +                     * compared to QEMUCursor's. */
> > +                    *dest_px =3D
> > +                        (px_data[0] << 16u) |
> > +                        (px_data[1] <<  8u) |
> > +                        (px_data[2] <<  0u) |
> > +                        (px_data[3] << 24u);
> > +                    ++dest_px;
> > +                    px_data +=3D 4;
> > +                }
> > +                px_data +=3D padding_bytes_per_row;
> > +            }
> > +            dpy_cursor_define(s->con, s->cursor);
> > +            update_cursor(s);
> > +        }
> > +    };
> > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> > +        trace_apple_gfx_cursor_show(show);
> > +        s->cursor_show =3D show;
> > +        update_cursor(s);
> > +    };
> > +    disp_desc.cursorMoveHandler =3D ^(void) {
> > +        trace_apple_gfx_cursor_move();
> > +        update_cursor(s);
> > +    };
> > +
> > +    return disp_desc;
> > +}
> > +
> > +static NSArray<PGDisplayMode*>*
> apple_gfx_prepare_display_mode_array(void)
> > +{
> > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        modes[i] =3D
> > +            [[PGDisplayMode alloc]
> initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];
> > +    }
> > +
> > +    mode_array =3D [NSArray arrayWithObjects:modes
> count:ARRAY_SIZE(apple_gfx_modes)];
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) {
> > +        [modes[i] release];
> > +        modes[i] =3D nil;
> > +    }
> > +
> > +    return mode_array;
> > +}
> > +
> > +static id<MTLDevice> copy_suitable_metal_device(void)
> > +{
> > +    id<MTLDevice> dev =3D nil;
> > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices();
> > +
> > +    /* Prefer a unified memory GPU. Failing that, pick a non-removable
> GPU. */
> > +    for (size_t i =3D 0; i < devs.count; ++i) {
> > +        if (devs[i].hasUnifiedMemory) {
> > +            dev =3D devs[i];
> > +            break;
> > +        }
> > +        if (!devs[i].removable) {
> > +            dev =3D devs[i];
> > +        }
> > +    }
> > +
> > +    if (dev !=3D nil) {
> > +        [dev retain];
> > +    } else {
> > +        dev =3D MTLCreateSystemDefaultDevice();
> > +    }
> > +    [devs release];
> > +
> > +    return dev;
> > +}
> > +
> > +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor
> *desc)
> > +{
> > +    PGDisplayDescriptor *disp_desc =3D nil;
> > +
> > +    QTAILQ_INIT(&s->tasks);
> > +    s->render_queue =3D dispatch_queue_create("apple-gfx.render",
> > +                                            DISPATCH_QUEUE_SERIAL);
> > +    s->mtl =3D copy_suitable_metal_device();
> > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> > +
> > +    desc.device =3D s->mtl;
> > +
> > +    apple_gfx_register_task_mapping_handlers(s, desc);
> > +
> > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> > +
> > +    disp_desc =3D apple_gfx_prepare_display_handlers(s);
> > +    s->pgdisp =3D [s->pgdev newDisplayWithDescriptor:disp_desc
> > +                                              port:0 serialNum:1234];
> > +    [disp_desc release];
> > +    s->pgdisp.modeList =3D apple_gfx_prepare_display_mode_array();
> > +
> > +    create_fb(s);
> > +}
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 7db05eace97..70d855749c0 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -65,6 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true:
> files('artist.c'))
> >
> >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c',
> 'ati_2d.c', 'ati_dbg.c'), pixman])
> >
> > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> [files('apple-gfx.m'), pvg, metal])
> > +system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true:
> [files('apple-gfx-vmapple.m'), pvg, metal])
> >
> >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >     virtio_gpu_ss =3D ss.source_set()
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index 781f8a33203..1809a358e36 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width) "dest_width :
> %u"
> >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >   dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
> >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> > +
> > +# apple-gfx.m
> > +apple_gfx_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64"
> res=3D0x%"PRIx64
> > +apple_gfx_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> > +apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=3D0x%x
> base_addr=3D%p"
> > +apple_gfx_destroy_task(void *task) "task=3D%p"
> > +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t
> virtual_offset, uint32_t read_only) "task=3D%p range_count=3D0x%x
> virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t
> phys_len) "[%d] phys_addr=3D0x%"PRIx64" phys_len=3D0x%"PRIx64
> > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target)
> "retval=3D%"PRId64" source=3D0x%"PRIx64" target=3D0x%"PRIx64
> > +apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t
> length) "task=3D%p virtual_offset=3D0x%"PRIx64" length=3D0x%"PRIx64
> > +apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void
> *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" dest=3D%p"
> > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +apple_gfx_new_frame(void) ""
> > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRId64" y=3D%"PRI=
d64
> > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height)
> "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> > +apple_gfx_cursor_move(void) ""
> > +apple_gfx_common_init(const char *device_name, size_t mmio_size)
> "device: %s; MMIO size: %zu bytes"
> > +
> > +# apple-gfx-vmapple.m
> > +apple_iosfc_read(uint64_t offset, uint64_t res) "offset=3D0x%"PRIx64"
> res=3D0x%"PRIx64
> > +apple_iosfc_write(uint64_t offset, uint64_t val) "offset=3D0x%"PRIx64"
> val=3D0x%"PRIx64
> > +apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void
> *va, void *e, void *f) "phys=3D0x%"PRIx64" len=3D0x%"PRIx64" ro=3D%d va=
=3D%p e=3D%p
> f=3D%p"
> > +apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e,
> void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p"
> > +apple_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> > +
> > diff --git a/meson.build b/meson.build
> > index 10464466ff3..f09df3f09d5 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -741,6 +741,8 @@ socket =3D []
> >   version_res =3D []
> >   coref =3D []
> >   iokit =3D []
> > +pvg =3D []
> > +metal =3D []
> >   emulator_link_args =3D []
> >   midl =3D not_found
> >   widl =3D not_found
> > @@ -762,6 +764,8 @@ elif host_os =3D=3D 'darwin'
> >     coref =3D dependency('appleframeworks', modules: 'CoreFoundation')
> >     iokit =3D dependency('appleframeworks', modules: 'IOKit', required:
> false)
> >     host_dsosuf =3D '.dylib'
> > +  pvg =3D dependency('appleframeworks', modules:
> 'ParavirtualizedGraphics')
> > +  metal =3D dependency('appleframeworks', modules: 'Metal')
> >   elif host_os =3D=3D 'sunos'
> >     socket =3D [cc.find_library('socket'),
> >               cc.find_library('nsl'),
>
>

--000000000000ff177d06237e7ac9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Thanks for taking a clos=
e look at this.</div><div><br></div><div>There are some further comments, e=
xplanations, and also a few questions inline below. Where I&#39;ve not comm=
ented, I&#39;ll just go ahead and make the suggested change for v4.<br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On T=
ue, 1 Oct 2024 at 11:40, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@=
daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><br>
&gt; This patch implements a QEMU device that drives PVG for the VMApple<br=
>
&gt; variant of it.<br>
<br>
I think it is better to name it MMIO variant instead of VMApple. There <br>
is nothing specific to VMApple in: hw/display/apple-gfx-vmapple.m<br></bloc=
kquote><div><br></div><div>I mean, I don&#39;t see it being useful for anyt=
hing whatsoever outside the vmapple machine type=E2=80=A6 But I guess there=
&#39;s little harm in renaming it. <br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
&gt; +#include &quot;apple-gfx.h&quot;<br>
&gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
&gt; +<br>
&gt; +_Static_assert(__aarch64__, &quot;&quot;);<br>
<br>
I don&#39;t think this assertion is worthwhile. This assertion will trigger=
 <br>
if you accidentally remove depends on AARCH64 from Kconfig, but I don&#39;t=
 <br>
think such code change happens by accident, and there is no reason to <br>
believe that this assertion won&#39;t be removed in such a case.<br></block=
quote><div><br></div><div>As far as I&#39;m aware the Kconfig AARCH64 depen=
dency is for the <i>target</i> architecture, not the <i>host</i> architectu=
re? The static assert checks for the latter. The PGIOSurfaceHostDeviceDescr=
iptor type isn&#39;t available at all on non-aarch64 macOS hosts. I&#39;ve =
not had any luck with using this variant of the device on x86-64 hosts simp=
ly by disabling any surface mapper code.</div><div><br></div><div>Incidenta=
lly, if you know of a way to depend on a specific <i>host</i> architecture =
in the Kconfig, that would be even better. I couldn&#39;t spot a way of doi=
ng that though.<br></div><div><br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; +<br>
&gt; +/*<br>
&gt; + * ParavirtualizedGraphics.Framework only ships header files for the =
PCI<br>
&gt; + * variant which does not include IOSFC descriptors and host devices.=
 We add<br>
&gt; + * their definitions here so that we can also work with the ARM versi=
on.<br>
&gt; + */<br>
&gt; +typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);<br>
&gt; +typedef bool(^IOSFCUnmapMemory)(<br>
&gt; +=C2=A0 =C2=A0 void *a, void *b, void *c, void *d, void *e, void *f);<=
br>
<br>
Omit dummy parameter names.<br></blockquote><div>=C2=A0<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt; +@end<br>
&gt; +<br>
&gt; +typedef struct AppleGFXVmappleState {<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState common;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq_gfx;<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq_iosfc;<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem_iosfc;<br>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDevice *pgiosfc;<br>
&gt; +} AppleGFXVmappleState;<br>
&gt; +<br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXVmappleState, APPLE_GFX_VMAPPLE)<b=
r>
&gt; +<br>
&gt; +<br>
&gt; +static uint64_t apple_iosfc_read(void *opaque, hwaddr offset, unsigne=
d size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXVmappleState *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint64_t res =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bql_unlock();<br>
<br>
It is dangerous to unlock BQL at an arbitrary place. Instead of <br>
unlocking, I suggest:<br>
- running [s-&gt;pgiosfc mmioReadAtOffset:offset] on another thread<br>
- using a bottom half to request operations that require BQL from the <br>
thread running [s-&gt;pgiosfc mmioReadAtOffset:offset]<br>
- calling AIO_WAIT_WHILE() to process the bottom half and to wait for <br>
the completion of [s-&gt;pgiosfc mmioReadAtOffset:offset]<br></blockquote><=
div><br></div>OK, I think I see what you mean, I&#39;ll try to rework thing=
s around that pattern. Any preference on how I kick off the job on the othe=
r thread? As we necessarily need to use libdispatch in a bunch of places in=
 this code anyway, I guess dispatch_async() would probably be the simplest?=
<br></div><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 res =3D [s-&gt;pgiosfc mmioReadAtOffset:offset];<br>
&gt; +=C2=A0 =C2=A0 bql_lock();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_iosfc_read(offset, res);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return res;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_iosfc_write(<br>
&gt; +=C2=A0 =C2=A0 void *opaque, hwaddr offset, uint64_t val, unsigned siz=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXVmappleState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_iosfc_write(offset, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 [s-&gt;pgiosfc mmioWriteAtOffset:offset value:val];<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps apple_iosfc_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D apple_iosfc_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D apple_iosfc_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 8,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static PGIOSurfaceHostDevice *apple_gfx_prepare_iosurface_host_device=
(<br>
&gt; +=C2=A0 =C2=A0 AppleGFXVmappleState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDeviceDescriptor *iosfc_desc =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [PGIOSurfaceHostDeviceDescriptor new];<br=
>
&gt; +=C2=A0 =C2=A0 PGIOSurfaceHostDevice *iosfc_host_dev =3D nil;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.mapMemory =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(uint64_t phys, uint64_t len, bool ro, v=
oid **va, void *e, void *f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_iosfc_map_memor=
y(phys, len, ro, va, e, f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MemoryRegion *tmp_mr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *va =3D gpa2hva(&amp;tmp_mr=
, phys, len, NULL);<br>
<br>
Use: dma_memory_map()<br>
<br></blockquote><div><br></div><div>That doesn&#39;t seem to be a precisel=
y equivalent operation. It also says in its headerdoc,</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Use only for reads OR writes - not for r=
ead-modify-write operations.</blockquote><div>which I don&#39;t think we ca=
n guarantee here at all.</div><div><br></div><div>I guess I can call it twi=
ce, once for writing and once for reading, but given that the dma_memory_un=
map operation marks the area dirty, I&#39;m not it&#39;s intended for what =
I understand the use case here to be: As far as I can tell, the PV graphics=
 device uses (some) of this memory to exchange data in a cache-coherent way=
 between host and guest, e.g. as a lock-free ring buffer, using atomic oper=
ations as necessary. (This works because it&#39;s a PV device: it &quot;kno=
ws&quot; the other end just another CPU core (or even the same one) executi=
ng in a different hypervisor context.) This doesn&#39;t really match &quot;=
traditional&quot; DMA patterns where there&#39;s either a read or a write h=
appening.<br></div><div><br></div><div>Hunting around some more for alterna=
tive APIs, there&#39;s also memory_region_get_ram_ptr(), but I&#39;m not su=
re its restrictions apply here either.<br></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (bool)true;<br>
<br>
Why cast?<br></blockquote><div><br></div><div>Good question. Not originally=
 my code, so I&#39;ve fixed all the instances I could find now. <br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.unmapMemory =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^(void *a, void *b, void *c, void *d, voi=
d *e, void *f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_iosfc_unmap_mem=
ory(a, b, c, d, e, f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (bool)true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_desc.raiseInterrupt =3D ^(uint32_t vector) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_iosfc_raise_irq(vector);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool locked =3D bql_locked();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!locked) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_pulse(s-&gt;irq_iosfc);&gt=
; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!locked) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (bool)true;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iosfc_host_dev =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGIOSurfaceHostDevice alloc] initWithDe=
scriptor:iosfc_desc];<br>
&gt; +=C2=A0 =C2=A0 [iosfc_desc release];<br>
&gt; +=C2=A0 =C2=A0 return iosfc_host_dev;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_vmapple_realize(DeviceState *dev, Error **errp)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
<br>
This autoreleasepool is not used.<br></blockquote><div><br></div><div>It is=
 definitely used inside the apple_gfx_common_realize() call. It&#39;s also =
impossible to say whether [PGDeviceDescriptor new] uses autorelease semanti=
cs internally, so it seemed safer to wrap the whole thing in an outer pool.=
<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXVmappleState *s =3D APPLE_GFX_VMA=
PPLE(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDes=
criptor new];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.usingIOSurfaceMapper =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc.raiseInterrupt =3D ^(uint32_t vector=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool locked;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_raise_irq(v=
ector);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 locked =3D bql_locked();<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!locked) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_lock();<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_pulse(s-&gt;irq_gf=
x);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!locked) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pgiosfc =3D apple_gfx_prepare_iosur=
face_host_device(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_common_realize(&amp;s-&gt;commo=
n, desc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc =3D nil;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; +++ b/hw/display/apple-gfx.h<br>
&gt; @@ -0,0 +1,57 @@<br>
&gt; +#ifndef QEMU_APPLE_GFX_H<br>
&gt; +#define QEMU_APPLE_GFX_H<br>
&gt; +<br>
&gt; +#define TYPE_APPLE_GFX_VMAPPLE=C2=A0 =C2=A0 =C2=A0 &quot;apple-gfx-vm=
apple&quot;<br>
&gt; +#define TYPE_APPLE_GFX_PCI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ap=
ple-gfx-pci&quot;<br>
&gt; +<br>
&gt; +#include &quot;qemu/typedefs.h&quot;<br>
&gt; +<br>
&gt; +typedef struct AppleGFXState AppleGFXState;<br>
&gt; +<br>
&gt; +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*=
 obj_name);<br>
&gt; +<br>
&gt; +#ifdef __OBJC__<br>
<br>
This ifdef is unnecessary.<br></blockquote><div>=C2=A0</div><div>Ah indeed;=
 at one point, vmapple.c was #including this file, but that&#39;s no longer=
 necessary.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><br>
&gt; diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..837300f9cd4<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/apple-gfx.m<br>
&gt; @@ -0,0 +1,536 @@<br>
&gt; +/*<br>
&gt; + * QEMU Apple ParavirtualizedGraphics.framework device<br>
&gt; + *<br>
&gt; + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affiliates. All Righ=
ts Reserved.<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + *<br>
&gt; + * ParavirtualizedGraphics.framework is a set of libraries that macOS=
 provides<br>
&gt; + * which implements 3d graphics passthrough to the host as well as a<=
br>
&gt; + * proprietary guest communication channel to drive it. This device m=
odel<br>
&gt; + * implements support to drive that library from within QEMU.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;apple-gfx.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; +#include &quot;ui/console.h&quot;<br>
&gt; +#include &quot;monitor/monitor.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;migration/blocker.h&quot;<br>
&gt; +#include &lt;mach/mach_vm.h&gt;<br>
&gt; +#import &lt;ParavirtualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
&gt; +<br>
&gt; +static const PGDisplayCoord_t apple_gfx_modes[] =3D {<br>
&gt; +=C2=A0 =C2=A0 { .x =3D 1440, .y =3D 1080 },<br>
&gt; +=C2=A0 =C2=A0 { .x =3D 1280, .y =3D 1024 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +typedef struct PGTask_s { // Name matches forward declaration in PG h=
eader<br>
<br>
Let&#39;s name it AppleGFXTask. It is a common practice to have the same ta=
g <br>
name and typedef in QEMU.<br></blockquote><div><br></div><div>This is defin=
ing a forward-declared type from framework headers which is opaque from the=
 framework&#39;s point of view. We do not get to choose its struct name. Th=
e alternative is having casts wherever these objects are being passed betwe=
en our code and the framework. (See the original v1/v2 vmapple patch series=
 for how messy this is.)<br></div><div>=C2=A0<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
&gt; +static void apple_gfx_render_new_frame(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 BOOL r;<br>
&gt; +=C2=A0 =C2=A0 void *vram =3D s-&gt;vram;<br>
&gt; +=C2=A0 =C2=A0 uint32_t width =3D surface_width(s-&gt;surface);<br>
&gt; +=C2=A0 =C2=A0 uint32_t height =3D surface_height(s-&gt;surface);<br>
&gt; +=C2=A0 =C2=A0 MTLRegion region =3D MTLRegionMake2D(0, 0, width, heigh=
t);<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLCommandBuffer&gt; command_buffer =3D [s-&gt;mt=
l_queue commandBuffer];<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture =3D s-&gt;texture;<br>
&gt; +=C2=A0 =C2=A0 r =3D [s-&gt;pgdisp encodeCurrentFrameToCommandBuffer:c=
ommand_buffer<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0texture:texture<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 region:region];<br>
&gt; +=C2=A0 =C2=A0 if (!r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [texture retain];<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;using_managed_texture_storage) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* &quot;Managed&quot; textures exist in =
both VRAM and RAM and must be synced. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 id&lt;MTLBlitCommandEncoder&gt; blit =3D =
[command_buffer blitCommandEncoder];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit synchronizeResource:texture];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [blit endEncoding];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [command_buffer retain];<br>
<br>
I don&#39;t think this call of retain is necessary. The completion handler =
<br>
gets the command buffer via parameter, which implies the command buffer <br=
>
is automatically retained until the completion handler finishes.<br></block=
quote><div><br></div><div>I couldn&#39;t find any hard guarantees for this =
documented anywhere, hence erring on the side of caution. I think the harm =
of an additional retain/release pair here is quite minor.<br></div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt; +static void apple_gfx_render_frame_completed(AppleGFXState *s, void *=
vram,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0id&lt;MTLTexture&gt; texture)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 --s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 assert(s-&gt;pending_frames &gt;=3D 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vram !=3D s-&gt;vram) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Display mode has changed, drop this ol=
d frame. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(texture !=3D s-&gt;texture);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vram);<br>
<br>
This management of buffers looks a bit convoluted. I suggest remembering <b=
r>
the width and height instead of pointers and comparing them. This way <br>
you can free resources in set_mode().<br></blockquote><div><br></div><div>Y=
eah, I suppose that works, I can change that around.<br></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_mtl_texture_to_surface_mem(texture, =
vram);<br>
<br>
Writing vram outside BQL may result in tearing.<br></blockquote><div><br></=
div><div>As far as I can tell(*), QXL does the same. I couldn&#39;t find an=
y examples of double-buffering in any of the existing display devices, whic=
h would be the only way to do async updates efficiently and without tearing=
. In any case, this solution is still vastly better than a regular VGA devi=
ce, which suffers from very visible tearing with macOS on the guest side an=
yway. And in an ideal world, we&#39;d pass through the rendered texture dir=
ectly to the Cocoa UI code rather than copying out only for the CPU to draw=
 it back into a window surface which is then passed to the GPU for host sid=
e rendering. But I felt this patch is already very, very large, and if anyo=
ne cares, we can fix imperfections in subsequent updates.<br></div><div><br=
></div><div>(*)The rendering code in that device is also fairly complex, so=
 I may be misreading it.<br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;gfx_update_requested) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =
=3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;c=
on);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&g=
t;con);<br>
=C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready=
 =3D false;<br>
<br>
This assignment is unnecessary as s-&gt;new_frame_ready is always false <br=
>
when s-&gt;gfx_update_requested. If you want to make sure <br>
s-&gt;gfx_update_requested and s-&gt;new_frame_ready are mutually exclusive=
, <br>
use one enum value instead of having two bools.<br></blockquote><div><br></=
div><div>I&#39;ll need to refresh my memory and get back to you on this one=
, it&#39;s been so many months since I actively worked on this code.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D t=
rue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_render_new_frame(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void apple_gfx_fb_update_display(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AppleGFXState *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_async(s-&gt;render_queue, ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; 0) {<br>
<br>
It should check for s-&gt;new_frame_ready as <br>
apple_gfx_render_frame_completed() doesn&#39;t check if<br>
s-&gt;pending_frames &gt; 0 before calling graphic_hw_update_done(), which =
is <br>
inconsistent.<br></blockquote><div><br></div><div>pending_frames is about g=
uest-side frames that are queued to be rendered by the host GPU.</div><div>=
new_frame_ready being true indicates that the contents of the Qemu console =
surface has been updated with new frame data since the last gfx_update.</di=
v><div>gfx_update_requested indicates that gfx_update is currently awaiting=
 an async completion (graphic_hw_update_done) but the surface has not recei=
ved a new frame content, but the GPU is stily busy drawing one.<br></div><d=
iv><br></div><div>apple_gfx_render_frame_completed is scheduled exactly onc=
e per pending frame, so pending_frames &gt; 0 is an invariant there. (Hence=
 the assert.)</div></div><div class=3D"gmail_quote"><br></div><div class=3D=
"gmail_quote">I don&#39;t think there is any inconsistency here, but I&#39;=
ll double check. It&#39;s possible that there&#39;s an easier way to expres=
s the state machine, and I&#39;ll take a look at that.<br></div><div class=
=3D"gmail_quote"><br><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
Checking if s-&gt;pending_frames &gt; 0 both in apple_gfx_fb_update_display=
() <br>
and apple_gfx_render_frame_completed() is also problematic as that can <br>
defer graphic_hw_update_done() indefinitely if we are getting new frames <b=
r>
too fast.<br></blockquote><div><br></div><div>I see what you mean about thi=
s part. I&#39;ll have to test it, but I guess we should reverse the priorit=
y, like this:</div><div><br></div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;new=
_frame_ready) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update=
_full(s-&gt;con);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_fr=
ame_ready =3D false;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_h=
w_update_done(s-&gt;con);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;p=
ending_frames &gt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;=
gfx_update_requested =3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><div><br></div><div>1. If we already =
have a frame, ready to be displayed, return it immediately.</div><div>2. If=
 the guest has reported that it&#39;s completed a frame and the GPU is curr=
ently busy rendering it, defer graphic_hw_update_done until it&#39;s done.<=
/div><div>3. If the guest reports no changes to its display, indicate this =
back to Qemu as a no-op display update graphic_hw_update_done() with no dpy=
_gfx_update* call.<br></div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =
=3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;new_frame_ready) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_updat=
e_full(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_fra=
me_ready =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&g=
t;con);<br>
=C2=A0&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }&gt; +=C2=A0 =C2=A0 });<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const GraphicHwOps apple_gfx_fb_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .gfx_update =3D apple_gfx_fb_update_display,<br>
&gt; +=C2=A0 =C2=A0 .gfx_update_async =3D true,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void update_cursor(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 dpy_mouse_set(s-&gt;con, s-&gt;pgdisp.cursorPosition.x,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;=
pgdisp.cursorPosition.y, s-&gt;cursor_show);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void set_mode(AppleGFXState *s, uint32_t width, uint32_t heigh=
t)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 void *vram =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt; +=C2=A0 =C2=A0 MTLTextureDescriptor *textureDescriptor;<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLTexture&gt; texture =3D nil;<br>
&gt; +=C2=A0 =C2=A0 __block bool no_change =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_sync(s-&gt;render_queue,<br>
<br>
Calling dispatch_sync() while holding BQL may result in deadlock.<br></bloc=
kquote><div>=C2=A0</div><div>Only if any code executed on the same dispatch=
 queue acquires the lock either directly or transitively. I believe I have =
ensure this is not done on the reqnder_queue,  have you found anywhere this=
 is the case?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;surface &amp;&amp=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D=3D =
surface_width(s-&gt;surface) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D=
 surface_height(s-&gt;surface)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_change =3D=
 true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (no_change) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vram =3D g_malloc0(width * height * 4);<br>
&gt; +=C2=A0 =C2=A0 surface =3D qemu_create_displaysurface_from(width, heig=
ht, PIXMAN_LE_a8r8g8b8,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 width * 4, vram);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescriptor =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [MTLTextureDescriptor<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 texture2DDesc=
riptorWithPixelFormat:MTLPixelFormatBGRA8Unorm<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0width:width<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 height:height<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mipmapped:NO];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 textureDescriptor.usage =3D s-&gt;pgdisp.=
minimumTextureUsage;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 texture =3D [s-&gt;mtl newTextureWithDesc=
riptor:textureDescriptor];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;using_managed_texture_storage =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (texture.storageMode =3D=3D MTLStorageMod=
eManaged);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 dispatch_sync(s-&gt;render_queue,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 id&lt;MTLTexture&gt; old_te=
xture =3D nil;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *old_vram =3D s-&gt;vr=
am;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;vram =3D vram;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;surface =3D surface;<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_replace_surface(s-&=
gt;con, surface);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_texture =3D s-&gt;textu=
re;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;texture =3D texture;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [old_texture release];<br>
<br>
You can just do:<br>
[s-&gt;texture release];<br>
s-&gt;texture =3D texture;<br>
<br>
This will make s-&gt;texture dangling between the two statements, but that =
<br>
don&#39;t matter since s-&gt;texture is not an atomic variable that can be =
<br>
safely observed from another thread anyway.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames =
=3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(old_vr=
am);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void create_fb(AppleGFXState *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_init(NULL, 0, &amp;apple_=
gfx_fb_ops, s);<br>
&gt; +=C2=A0 =C2=A0 set_mode(s, 1440, 1080);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;cursor_show =3D true;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static size_t apple_gfx_get_default_mmio_range_size(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t mmio_range_size;<br>
&gt; +=C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDes=
criptor new];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mmio_range_size =3D desc.mmioLength;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [desc release];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return mmio_range_size;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char*=
 obj_name)<br>
<br>
This function can be merged into apple_gfx_common_realize().<br></blockquot=
e><div><br></div><div>Probably. I&#39;ll try it.<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int r;<br>
&gt; +=C2=A0 =C2=A0 size_t mmio_range_size =3D apple_gfx_get_default_mmio_r=
ange_size();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_apple_gfx_common_init(obj_name, mmio_range_size);=
<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem_gfx, obj, &amp;a=
pple_gfx_ops, s, obj_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 mmio_range_size);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;iomem_gfx.disable_reentrancy_guard =3D true;<br>
<br>
Why do you disable reentrancy guard?<br></blockquote><div><br></div><div>Pe=
rhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this won&#39;t be =
an issue anymore, but the guard would otherwise keep dropping MMIOs which i=
mmediately caused the PV graphics device to stop making progress. The MMIO =
APIs in the PVG framework are thread- and reentrancy-safe, so we certainly =
don&#39;t need to serialise them on our side.<br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* TODO: PVG framework supports serialising device stat=
e: integrate it! */<br>
&gt; +=C2=A0 =C2=A0 if (apple_gfx_mig_blocker =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;apple_gfx_mig_blocker,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=
Migration state blocked by apple-gfx display device&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D migrate_add_blocker(&amp;apple_gfx_=
mig_blocker, &amp;local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err)=
;<br>
<br>
Please report the error to the caller of apple_gfx_common_realize() instead=
.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
=C2=A0&gt; +}&gt; +<br>
&gt; +static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 desc.createTask =3D ^(uint64_t vmSize, void * _Nullable=
 * _Nonnull baseAddress) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 AppleGFXTask *task =3D apple_gfx_new_task=
(s, vmSize);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *baseAddress =3D (void*)task-&gt;address;=
<br>
<br>
nit: please write as (void *) instead of (void*).<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_create_task(vmSize, *base=
Address);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return task;<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br><br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc =3D [PGDisplayDescriptor=
 new];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://disp_desc.name" rel=3D"noreferrer" ta=
rget=3D"_blank">disp_desc.name</a> =3D @&quot;QEMU display&quot;;<br>
&gt; +=C2=A0 =C2=A0 disp_desc.sizeInMillimeters =3D NSMakeSize(400., 300.);=
 /* A 20&quot; display */<br>
&gt; +=C2=A0 =C2=A0 disp_desc.queue =3D dispatch_get_main_queue();<br>
&gt; +=C2=A0 =C2=A0 disp_desc.newFrameEventHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_new_frame();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dispatch_async(s-&gt;render_queue, ^{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Drop frames if we get to=
o far ahead. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &g=
t;=3D 2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++s-&gt;pending_frames;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &g=
t; 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 @autoreleasepool {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_ren=
der_new_frame(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t size=
InPixels,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSType pixelFormat=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_mode_change(sizeInPixels.=
x, sizeInPixels.y);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_mode(s, sizeInPixels.x, sizeInPixels.=
y);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *gl=
yph,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDisplayCoo=
rd_t hotSpot) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t bpp =3D glyph.bitsPerPixel;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t width =3D glyph.pixelsWide;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t height =3D glyph.pixelsHigh;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t padding_bytes_per_row =3D glyph.by=
tesPerRow - width * 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t* px_data =3D glyph.bitmapDa=
ta;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_set(bpp, width, he=
ight);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;cursor) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(s-&gt;cursor);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bpp =3D=3D 32) { /* Shouldn&#39;t be =
anything else, but just to be safe...*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D cursor_all=
oc(width, height);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_x =3D =
hotSpot.x;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_y =3D =
hotSpot.y;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *dest_px =3D s-&gt=
;cursor-&gt;data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t y =3D 0; y &lt;=
 height; ++y) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t x=
 =3D 0; x &lt; width; ++x) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* NSBitmapImageRep&#39;s red &amp; blue channels are swapped<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* compared to QEMUCursor&#39;s. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 *dest_px =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (px_data[0] &lt;&lt; 16u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (px_data[1] &lt;&lt;=C2=A0 8u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (px_data[2] &lt;&lt;=C2=A0 0u) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 (px_data[3] &lt;&lt; 24u);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ++dest_px;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 px_data +=3D 4;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D =
padding_bytes_per_row;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_cursor_define(s-&gt;con=
, s-&gt;cursor);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorShowHandler =3D ^(BOOL show) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_show(show);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor_show =3D show;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 disp_desc.cursorMoveHandler =3D ^(void) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_apple_gfx_cursor_move();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return disp_desc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static NSArray&lt;PGDisplayMode*&gt;* apple_gfx_prepare_display_mode_=
array(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];<br>
&gt; +=C2=A0 =C2=A0 NSArray&lt;PGDisplayMode*&gt;* mode_array =3D nil;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [[PGDisplayMode alloc] init=
WithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.];<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mode_array =3D [NSArray arrayWithObjects:modes count:AR=
RAY_SIZE(apple_gfx_modes)];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [modes[i] release];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 modes[i] =3D nil;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return mode_array;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static id&lt;MTLDevice&gt; copy_suitable_metal_device(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 id&lt;MTLDevice&gt; dev =3D nil;<br>
&gt; +=C2=A0 =C2=A0 NSArray&lt;id&lt;MTLDevice&gt;&gt; *devs =3D MTLCopyAll=
Devices();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Prefer a unified memory GPU. Failing that, pick a no=
n-removable GPU. */<br>
&gt; +=C2=A0 =C2=A0 for (size_t i =3D 0; i &lt; devs.count; ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (devs[i].hasUnifiedMemory) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!devs[i].removable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (dev !=3D nil) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [dev retain];<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D MTLCreateSystemDefaultDevice();<b=
r>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 [devs release];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return dev;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *d=
esc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 PGDisplayDescriptor *disp_desc =3D nil;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;s-&gt;tasks);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;render_queue =3D dispatch_queue_create(&quot;appl=
e-gfx.render&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 DISPATCH_QUEUE_SERIAL);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mtl =3D copy_suitable_metal_device();<br>
&gt; +=C2=A0 =C2=A0 s-&gt;mtl_queue =3D [s-&gt;mtl newCommandQueue];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 desc.device =3D s-&gt;mtl;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 apple_gfx_register_task_mapping_handlers(s, desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdev =3D PGNewDeviceWithDescriptor(desc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 disp_desc =3D apple_gfx_prepare_display_handlers(s);<br=
>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp =3D [s-&gt;pgdev newDisplayWithDescriptor:=
disp_desc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 port:0 serialNum:1234];<br>
&gt; +=C2=A0 =C2=A0 [disp_desc release];<br>
&gt; +=C2=A0 =C2=A0 s-&gt;pgdisp.modeList =3D apple_gfx_prepare_display_mod=
e_array();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 create_fb(s);<br>
&gt; +}<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index 7db05eace97..70d855749c0 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -65,6 +65,8 @@ system_ss.add(when: &#39;CONFIG_ARTIST&#39;, if_true=
: files(&#39;artist.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ATI_VGA&#39;, if_true: [fi=
les(&#39;ati.c&#39;, &#39;ati_2d.c&#39;, &#39;ati_dbg.c&#39;), pixman])<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG&#39;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if_true: [files(&#39;apple-gfx.m&#39;), pvg, metal])<br>
&gt; +system_ss.add(when: &#39;CONFIG_MAC_PVG_VMAPPLE&#39;, if_true: [files=
(&#39;apple-gfx-vmapple.m&#39;), pvg, metal])<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if config_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio_gpu_ss =3D ss.source_set()<br>
&gt; diff --git a/hw/display/trace-events b/hw/display/trace-events<br>
&gt; index 781f8a33203..1809a358e36 100644<br>
&gt; --- a/hw/display/trace-events<br>
&gt; +++ b/hw/display/trace-events<br>
&gt; @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width) &quot;dest_wi=
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
&gt; +apple_gfx_destroy_task(void *task) &quot;task=3D%p&quot;<br>
&gt; +apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtu=
al_offset, uint32_t read_only) &quot;task=3D%p range_count=3D0x%x virtual_o=
ffset=3D0x%&quot;PRIx64&quot; read_only=3D%d&quot;<br>
&gt; +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t p=
hys_len) &quot;[%d] phys_addr=3D0x%&quot;PRIx64&quot; phys_len=3D0x%&quot;P=
RIx64<br>
&gt; +apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target) &q=
uot;retval=3D%&quot;PRId64&quot; source=3D0x%&quot;PRIx64&quot; target=3D0x=
%&quot;PRIx64<br>
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
&gt; +# apple-gfx-vmapple.m<br>
&gt; +apple_iosfc_read(uint64_t offset, uint64_t res) &quot;offset=3D0x%&qu=
ot;PRIx64&quot; res=3D0x%&quot;PRIx64<br>
&gt; +apple_iosfc_write(uint64_t offset, uint64_t val) &quot;offset=3D0x%&q=
uot;PRIx64&quot; val=3D0x%&quot;PRIx64<br>
&gt; +apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void=
 *va, void *e, void *f) &quot;phys=3D0x%&quot;PRIx64&quot; len=3D0x%&quot;P=
RIx64&quot; ro=3D%d va=3D%p e=3D%p f=3D%p&quot;<br>
&gt; +apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e,=
 void *f) &quot;a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p&quot;<br>
&gt; +apple_iosfc_raise_irq(uint32_t vector) &quot;vector=3D0x%x&quot;<br>
&gt; +<br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 10464466ff3..f09df3f09d5 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -741,6 +741,8 @@ socket =3D []<br>
&gt;=C2=A0 =C2=A0version_res =3D []<br>
&gt;=C2=A0 =C2=A0coref =3D []<br>
&gt;=C2=A0 =C2=A0iokit =3D []<br>
&gt; +pvg =3D []<br>
&gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0emulator_link_args =3D []<br>
&gt;=C2=A0 =C2=A0midl =3D not_found<br>
&gt;=C2=A0 =C2=A0widl =3D not_found<br>
&gt; @@ -762,6 +764,8 @@ elif host_os =3D=3D &#39;darwin&#39;<br>
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

--000000000000ff177d06237e7ac9--

