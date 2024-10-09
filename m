Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CDACEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYGp-0008QK-Tr; Wed, 09 Oct 2024 11:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syYGo-0008Pi-N6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:06:34 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1syYGd-0007kV-1z
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:06:34 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-84fc5aaccf8so163699241.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1728486381; x=1729091181;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yJddaaTmz6v/le1F4PiekRGqRaz9cAPYuHqbRfHlgAs=;
 b=wcmDKE4cQw1eKPqFzgDuwKrED3z4Llz9ureGn830J52qEsAsCy4dGEOOkwqsgXMKPX
 G9P8lyOOne81ZVqF+mqJwm6XkiL/2lvtSAMRp77Uy6TLKFw2uuMA7iKnGOWQ6JzjSszf
 p1UcXgdbBCmadMqaMZC6DOq7drbnVjubJYijZfU+8G/c5ShJXRrjiqjbhTej/lnPP2kw
 b+Gzw0sOT+9RLtsphXN5lXHEyH0C0n/GtPIz4sjjU43Nko4f+0mvDLrk5Q89GOOwelxs
 ChVb/DwvX71703EHs93+yrgMBY1BWgmaPGj83E+GwStOD5Npz/72P9g6ss9ZlNM8zkhN
 l0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486381; x=1729091181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJddaaTmz6v/le1F4PiekRGqRaz9cAPYuHqbRfHlgAs=;
 b=kkV4dIlU6K33GAWL4TFv1Nj8fr57tI/QdTGOvK21ewg08YHNQqeXkOohQc/HZXWz3j
 4+mpsoug+rcTAZmBN350+Kt/rThtfcSLIuqUUK50e4f7P0kmny9VD/c+0/uUTAfsabp6
 Y8YENqwB7p9omrQ9qXfacj/E3u/sewxHErdFvrR2TNeupelAJAFIUgEusRziY88hRxTu
 iorejT207SASlf28K0Zi0u4femaRLHOitltuqpf1ivOb2OW5Xi65+I5yhF26Rtwn68F0
 Ao7UJdT3hjeRwQr7zzgq8xIs2SEV6mIiU2DMBA+P1gHlcBsm8tdKx9tofis6GcWRK01s
 M/7g==
X-Gm-Message-State: AOJu0YxQmdtWEbEInYsG9n8BOTh07JXV07N+93K/rkA3HJhkKlcUi5NV
 88KXxeyT2f03ecOfdtZwnuVmEkYUozMWrD8aPB9bv2XmRGmCD0es49B8k6bVsxIakfZx2gt4d5v
 QhTWIfaC74lxF9rXH4/+jGaizejwyVfaRYs4E
X-Google-Smtp-Source: AGHT+IGwdjl8UBlsrT1sEbewazfrb1cnszPbAkNv/355iyQr6yzZgw1qoAXBk6mIe2i70RIT+Z2XIDA2u7SrTpe71mY=
X-Received: by 2002:a05:6122:3087:b0:4f5:abe4:50e2 with SMTP id
 71dfb90a1353d-50cf099feebmr1838980e0c.6.1728486381085; Wed, 09 Oct 2024
 08:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-2-phil@philjordan.eu>
 <7f3a1a60-a2f3-433c-8f2e-a2dfe0afdcb5@daynix.com>
 <CAAibmn1+Z0zcB-vQ3ZbrY0o7wtev+YtV1EOCH-4s=PfQg_Pd8A@mail.gmail.com>
 <ae0f5ef7-c714-40e1-be5a-1aa12df518c8@daynix.com>
 <CAAibmn3dmBRCpVBDF07jx+_s0A_i5SAhnSinRyKyD5-jcL134g@mail.gmail.com>
 <12f22415-4079-4211-86ab-29f048de1923@daynix.com>
In-Reply-To: <12f22415-4079-4211-86ab-29f048de1923@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 9 Oct 2024 17:06:09 +0200
Message-ID: <CAAibmn24vT1BNQrzjWparWv3qOp0CmRTZqVHr9Pd9pVCFXd+rg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000be834f06240c98cd"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::935;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x935.google.com
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

--000000000000be834f06240c98cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Oct 2024 at 10:25, Akihiko Odaki <akihiko.odaki@daynix.com> wrote=
:

>
> >     Theoretically, It should be safe to assume the callee creates
> >     autoreleasepool by themselves as needed in general. We have bunch o=
f
> >     code to call Objective-C APIs without creating autoreleasepool in t=
he
> >     caller. Practically, [PGDeviceDescriptor new] is likely to be
> >     implemented with ARC, which wraps methods in autoreleasepool as
> >     necessary.
> >
> >
> > As far as I'm aware, ARC does NOT automatically insert autorelease pool
> > blocks. The reason you rarely need to create autoreleasepool blocks in
> > "plain" Objective-C programming is that Cocoa/CFRunloop/libdispatch
> > event handlers run each event in an autoreleasepool. So you don't need
> > to create them explicitly when using dispatch_async and similar, or whe=
n
> > running code on the main thread (which runs inside NSApplicationMain/
> > CFRunloopRun/dispatch_main).
>
> My statement regarding ARC was wrong; It seems ARC just retains a value
> annoted as autoreleased.
>

Yes, the runtime maintains a sort of shadow stack of pointers to
autoreleased objects for each thread. When you enter a pool block, it
remembers the position in the shadow stack. On exiting the pool, all
objects added since entering the pool are popped from the shadow stack and
released.

Hence, if objects are added to the stack outside of ANY autorelease pool,
those are never popped and released.


> >
> > As far as I'm aware, if you don't explicitly define autoreleasepools in
> > raw threads created with the pthreads API, any autoreleased objects wil=
l
> > leak. At least I've not found any specification/documentation
> > contradicting this. And most code in Qemu runs on such raw threads, so
> > we need to play it safe with regard to autorelease semantics.
>
> I decided to dig deeper and found this documentation:
>
> https://developer.apple.com/library/archive/documentation/Cocoa/Conceptua=
l/MemoryMgmt/Articles/mmAutoreleasePools.html
>
> It says:
>  > Cocoa always expects code to be executed within an autorelease pool
>  > block, otherwise autoreleased objects do not get released and your
>  > application leaks memory.
>
> So yes, we must wrap everything in @autoreleasepool at least for Cocoa.
> It is probably a good practice to wrap all Objective-C code in
> @autoreleasepool.
>

Yes; any method or function returning an Objective-C object pointer using
autorelease semantics - either annotated or by naming convention - will use
the pool. But unless it's all your own code all the way down, you don't
know if anything inside a method whose own return value is not autoreleased
might use autorelease semantics.

(The naming convention says most methods return autoreleased, except those
named create*, new*, or similar.)

> Whether the existing Qemu Objective-C code is safe in this regard I
> > don't know for certain, but I've certainly paid attention to this aspec=
t
> > when modifying ui/cocoa.m in the past, and indeed most of that code run=
s
> > on the main thread. Note also how I wrap the apple_gfx_render_new_frame
> > call in a pool when it can't be guaranteed it's running on a dispatch
> > queue because the command buffer inside that uses autorelease semantics=
.
>
> It is more about event loop rather than thread. Resources allocated
> before [NSApp run] will leak even if they are autoreleased in the main
> thread. apple_gfx_common_realize() is one of such functions that run in
> the main thread before [NSApp run]. In ui/cocoa, cocoa_display_init()
> runs before [NSApp run]. Fortunately we already have NSAutoreleasePool
> for this function.
>

Yes. Unless it's very clear that the code will run only in a Cocoa event
handler or dispatch queue context, you need to use an autoreleasepool.


> >
> >     Functions that uses a method that returns autorelease resources
> should
> >     be wrapped with autoreleasepool instead of assuming the caller
> creates
> >     autoreleasepool for them.
> >
> >
> > I'm treating apple_gfx_common_realize as an internal API, and I don't
> > think expecting its callers to wrap it in an autoreleasepool block is
> > unreasonable. I can certainly explicitly document this in a comment.
>
> We don't have a comment for cocoa_display_init() and it's more about
> generic macOS programming so it's not necessary.
>
>  > >      >      > diff --git a/hw/display/apple-gfx.m
> b/hw/display/apple-gfx.m
> >      >      > new file mode 100644
> >      >      > index 00000000000..837300f9cd4
> >      >      > --- /dev/null
> >      >      > +++ b/hw/display/apple-gfx.m
> >      >      > @@ -0,0 +1,536 @@
> >      >      > +/*
> >      >      > + * QEMU Apple ParavirtualizedGraphics.framework device
> >      >      > + *
> >      >      > + * Copyright =C2=A9 2023 Amazon.com, Inc. or its affilia=
tes.
> All
> >      >     Rights Reserved.
> >      >      > + *
> >      >      > + * This work is licensed under the terms of the GNU GPL,
> >     version
> >      >     2 or later.
> >      >      > + * See the COPYING file in the top-level directory.
> >      >      > + *
> >      >      > + * ParavirtualizedGraphics.framework is a set of
> >     libraries that
> >      >     macOS provides
> >      >      > + * which implements 3d graphics passthrough to the host
> >     as well as a
> >      >      > + * proprietary guest communication channel to drive it.
> This
> >      >     device model
> >      >      > + * implements support to drive that library from within
> QEMU.
> >      >      > + */
> >      >      > +
> >      >      > +#include "apple-gfx.h"
> >      >      > +#include "trace.h"
> >      >      > +#include "qemu/main-loop.h"
> >      >      > +#include "ui/console.h"
> >      >      > +#include "monitor/monitor.h"
> >      >      > +#include "qapi/error.h"
> >      >      > +#include "migration/blocker.h"
> >      >      > +#include <mach/mach_vm.h>
> >      >      > +#import
> <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
> >      >      > +
> >      >      > +static const PGDisplayCoord_t apple_gfx_modes[] =3D {
> >      >      > +    { .x =3D 1440, .y =3D 1080 },
> >      >      > +    { .x =3D 1280, .y =3D 1024 },
> >      >      > +};
> >      >      > +
> >      >      > +typedef struct PGTask_s { // Name matches forward
> >     declaration in
> >      >     PG header
> >      >
> >      >     Let's name it AppleGFXTask. It is a common practice to have
> >     the same
> >      >     tag
> >      >     name and typedef in QEMU.
> >      >
> >      >
> >      > This is defining a forward-declared type from framework headers
> >     which is
> >      > opaque from the framework's point of view. We do not get to
> >     choose its
> >      > struct name. The alternative is having casts wherever these
> >     objects are
> >      > being passed between our code and the framework. (See the
> >     original v1/v2
> >      > vmapple patch series for how messy this is.)
> >
> >     I got the idea. Let's not avoid the typedef then to clarify the
> naming
> >     is not under our control.
> >
> >
> > I'm not sure what you mean by this double negative. Are you saying,
> > don't add our own typedef for struct PGTask_s at all, just use the
> > framework-supplied PGTask_t where appropriate?
>
> Yes.
>
> >
> >
> >      >
> >      >      > +static void
> >     apple_gfx_render_frame_completed(AppleGFXState *s,
> >      >     void *vram,
> >      >      > +
> >       id<MTLTexture> texture)
> >      >      > +{
> >      >      > +    --s->pending_frames;
> >      >      > +    assert(s->pending_frames >=3D 0);
> >      >      > +
> >      >      > +    if (vram !=3D s->vram) {
> >      >      > +        /* Display mode has changed, drop this old frame=
.
> */
> >      >      > +        assert(texture !=3D s->texture);
> >      >      > +        g_free(vram);
> >      >
> >      >     This management of buffers looks a bit convoluted. I suggest
> >      >     remembering
> >      >     the width and height instead of pointers and comparing them.
> >     This way
> >      >     you can free resources in set_mode().
> >      >
> >      >
> >      > Yeah, I suppose that works, I can change that around.
> >      >
> >      >      > +    } else {
> >      >      > +        copy_mtl_texture_to_surface_mem(texture, vram);
> >      >
> >      >     Writing vram outside BQL may result in tearing.
> >      >
> >      >
> >      > As far as I can tell(*), QXL does the same. I couldn't find any
> >     examples
> >      > of double-buffering in any of the existing display devices, whic=
h
> >     would
> >      > be the only way to do async updates efficiently and without
> >     tearing. In
> >      > any case, this solution is still vastly better than a regular VG=
A
> >      > device, which suffers from very visible tearing with macOS on th=
e
> >     guest
> >      > side anyway. And in an ideal world, we'd pass through the render=
ed
> >      > texture directly to the Cocoa UI code rather than copying out
> >     only for
> >      > the CPU to draw it back into a window surface which is then
> >     passed to
> >      > the GPU for host side rendering. But I felt this patch is alread=
y
> >     very,
> >      > very large, and if anyone cares, we can fix imperfections in
> >     subsequent
> >      > updates.
> >      >
> >      > (*)The rendering code in that device is also fairly complex, so =
I
> >     may be
> >      > misreading it.
> >
> >     QXL always modifies the surface with BQL. The surface is modified
> with
> >     qxl_blit(), which is called by qxl_render_update_area_unlocked().
> >     qxl_render_update_area_unlocked() is called by either of
> >     qxl_render_update() and qxl_render_update_area_bh(). Both of them a=
re
> >     called with BQL. The name includes "unlocked", but it means it is
> >     called
> >     without holding QXL-internal lock.
> >
> >     Most devices works entirely with BQL so they don't perform double
> >     buffering. apple-gfx can do the same.
> >
> >
> > I think we can safely move apple-gfx's framebuffer state management bac=
k
> > inside the BQL, yes. I just figured that copying dozens of megabytes of
> > framebuffer data on every frame while holding the lock was not going to
> > help BQL contention. Especially as PVG does not have a concept of dirty
> > areas, so we must copy the whole framebuffer every time. (Unless we wer=
e
> > to implement dirty area detection ourselves.)
> >
> > Unfortunately, implementing double-buffering would require a major
> > rework of Qemu's whole surface management, console code, and probably
> > most of the UI implementations. I'm guessing the OpenGL fast-path
> > sidesteps all of this, so replicating that with Metal would probably be
> > the easier way forward. (Although doing all this graphics stuff inside
> > the BQL generally seems like a major architectural flaw; I suppose most
> > enterprise use of Qemu does not involve the framebuffer, so it's not
> > shown up in BQL contention profiling there. It certainly does in deskto=
p
> > use, although at least on macOS hosts there are far worse culprits in
> > that regard.)
>
> We don't need double-buffering; instead we can have one thread that
> renders the UI and also
> [PGDisplay -encodeCurrentFrameToCommandBuffer:texture:region:].
> Rendering the UI in machine event loop in one thread is a bad idea in
> the first place so it will make sense to extract all UI work into a
> separate thread. This still requires a lot of work because the UI code
> assumes BQL everywhere.
>

I'm not reworking the UI layer in this patch set, so it sounds like the
best we can do is to acquire the BQL for updating the console framebuffer
and just take the lock contention hit.


> In my understanding BQL is less problematic for KVM users because QEMU
> can (sometimes) avoid locking BQL in the vCPU threads.
>

Yeah, the current hvf implementation is unfortunately still very BQL heavy.
Part of that is down to the interrupt controller: with the KVM accel, you
typically use the interrupt controller provided by the kernel. With the hvf
accel, you get a lot of VM exits for servicing interrupt controller I/O; at
least on x86, the APIC implementation only works inside the BQL. HVF on
x86-64 does technically have an in-kernel APIC implementation;
unfortunately, it has some severe bugs which prevent using it in the
general case. (EOI signalling to the IOAPIC does not work/FB14425590; the
behaviour for coalescing and retriggering of level-triggered interrupts is
also flawed/FB14425412.) On the aarch64 side, an in-kernel GIC
implementation was only just added to hvf with macOS 15.

I have submitted a patch that at least adds x2apic support to the hvf accel
and thus significantly reduces BQL pressure a few times, but the
maintainers of the x86 hvf backend don't seem to be active at the moment.


> >
> >      >
> >      >      > +        if (s->gfx_update_requested) {
> >      >      > +            s->gfx_update_requested =3D false;
> >      >      > +            dpy_gfx_update_full(s->con);
> >      >      > +            graphic_hw_update_done(s->con);
> >      >       > +            s->new_frame_ready =3D false;
> >      >
> >      >     This assignment is unnecessary as s->new_frame_ready is
> >     always false
> >      >     when s->gfx_update_requested. If you want to make sure
> >      >     s->gfx_update_requested and s->new_frame_ready are mutually
> >     exclusive,
> >      >     use one enum value instead of having two bools.
> >      >
> >      >
> >      > I'll need to refresh my memory and get back to you on this one,
> it's
> >      > been so many months since I actively worked on this code.
> >      >
> >      >      > +        } else {
> >      >      > +            s->new_frame_ready =3D true;
> >      >      > +        }
> >      >      > +    }
> >      >      > +    if (s->pending_frames > 0) {
> >      >      > +        apple_gfx_render_new_frame(s);
> >      >      > +    }
> >      >      > +}
> >      >      > +
> >      >      > +static void apple_gfx_fb_update_display(void *opaque)
> >      >      > +{
> >      >      > +    AppleGFXState *s =3D opaque;
> >      >      > +
> >      >      > +    dispatch_async(s->render_queue, ^{
> >      >      > +        if (s->pending_frames > 0) {
> >      >
> >      >     It should check for s->new_frame_ready as
> >      >     apple_gfx_render_frame_completed() doesn't check if
> >      >     s->pending_frames > 0 before calling
> >     graphic_hw_update_done(), which is
> >      >     inconsistent.
> >      >
> >      >
> >      > pending_frames is about guest-side frames that are queued to be
> >     rendered
> >      > by the host GPU.
> >      > new_frame_ready being true indicates that the contents of the Qe=
mu
> >      > console surface has been updated with new frame data since the
> last
> >      > gfx_update.
> >      > gfx_update_requested indicates that gfx_update is currently
> >     awaiting an
> >      > async completion (graphic_hw_update_done) but the surface has no=
t
> >      > received a new frame content, but the GPU is stily busy drawing
> one.
> >      >
> >      > apple_gfx_render_frame_completed is scheduled exactly once per
> >     pending
> >      > frame, so pending_frames > 0 is an invariant there. (Hence the
> >     assert.)> > I don't think there is any inconsistency here, but I'll
> >     double check.
> >      > It's possible that there's an easier way to express the state
> >     machine,
> >      > and I'll take a look at that.
> >
> >     I meant that apple_gfx_render_frame_completed() does not check if t=
he
> >     frame is the last one currently pending.
> apple_gfx_fb_update_display()
> >     ignores a new ready frame when there is a more pending frame, but
> >     apple_gfx_render_frame_completed() unconditionally fires
> >     graphic_hw_update_done() even if there is a more pending frame. And=
 I
> >     think apple_gfx_render_frame_completed() is right and
> >     apple_gfx_fb_update_display() is wrong in such a situation.
> >
> >
> > OK, got it. And yes, I agree.
> >
> >      >
> >      >     Checking if s->pending_frames > 0 both in
> >     apple_gfx_fb_update_display()
> >      >     and apple_gfx_render_frame_completed() is also problematic a=
s
> >     that can
> >      >     defer graphic_hw_update_done() indefinitely if we are gettin=
g
> new
> >      >     frames
> >      >     too fast.
> >      >
> >      >
> >      > I see what you mean about this part. I'll have to test it, but I
> >     guess
> >      > we should reverse the priority, like this:
> >      >
> >      >          if (s->new_frame_ready) {
> >      >              dpy_gfx_update_full(s->con);
> >      >              s->new_frame_ready =3D false;
> >      >              graphic_hw_update_done(s->con);
> >      >          } else if (s->pending_frames > 0) {
> >      >              s->gfx_update_requested =3D true;
> >      >          } else {
> >      >              graphic_hw_update_done(s->con);
> >      >          }
> >      >
> >      > 1. If we already have a frame, ready to be displayed, return it
> >     immediately.
> >      > 2. If the guest has reported that it's completed a frame and the
> >     GPU is
> >      > currently busy rendering it, defer graphic_hw_update_done until
> >     it's done.
> >      > 3. If the guest reports no changes to its display, indicate this
> >     back to
> >      > Qemu as a no-op display update graphic_hw_update_done() with no
> >      > dpy_gfx_update* call.
> >
> >     Yes, that looks correct.
> >
> >      >
> >      >      > +            s->gfx_update_requested =3D true;
> >      >      > +        } else {
> >      >      > +            if (s->new_frame_ready) {
> >      >      > +                dpy_gfx_update_full(s->con);
> >      >      > +                s->new_frame_ready =3D false;
> >      >      > +            }
> >      >      > +            graphic_hw_update_done(s->con);
> >      >       > +        }> +    });
> >      >      > +}
> >      >      > +
> >      >      > +static const GraphicHwOps apple_gfx_fb_ops =3D {
> >      >      > +    .gfx_update =3D apple_gfx_fb_update_display,
> >      >      > +    .gfx_update_async =3D true,
> >      >      > +};
> >      >      > +
> >      >      > +static void update_cursor(AppleGFXState *s)
> >      >      > +{
> >      >      > +    dpy_mouse_set(s->con, s->pgdisp.cursorPosition.x,
> >      >      > +                  s->pgdisp.cursorPosition.y, s-
> >      >cursor_show);
> >      >      > +}
> >      >      > +
> >      >      > +static void set_mode(AppleGFXState *s, uint32_t width,
> >     uint32_t
> >      >     height)
> >      >      > +{
> >      >      > +    void *vram =3D NULL;
> >      >      > +    DisplaySurface *surface;
> >      >      > +    MTLTextureDescriptor *textureDescriptor;
> >      >      > +    id<MTLTexture> texture =3D nil;
> >      >      > +    __block bool no_change =3D false;
> >      >      > +
> >      >      > +    dispatch_sync(s->render_queue,
> >      >
> >      >     Calling dispatch_sync() while holding BQL may result in
> deadlock.
> >      >
> >      > Only if any code executed on the same dispatch queue acquires th=
e
> >     lock
> >      > either directly or transitively. I believe I have ensure this is
> not
> >      > done on the reqnder_queue, have you found anywhere this is the
> case?
> >
> >     The documentation is not clear what threads a dispatch queue runs
> >     on. We
> >     can have a deadlock if they lock the BQL.
> >
> >
> > dispatch_sync is a synchronisation primitive (it waits for and asserts
> > exclusive access to the given queue), it doesn't actually do any thread
> > scheduling. Work scheduled asynchronously to non-main dispatch queues
> > will otherwise run on libdispatch pool threads. Running blocks on
> > dispatch queues will not preempt and schedule it on other threads which
> > may or may not be holding some locks.
>
> What if all pool threads are waiting for BQL?
>

The pool is elastic, so if threads are blocked (in syscalls) and there are
queued tasks ready to run, the runtime will create more threads as
necessary.


> >
> > So the only way this code will deadlock is if any code scheduled to
> > render_queue directly or transitively acquires the BQL. None of it does=
,
> > although updating the console while holding the BQL rather complicates
> this.
> >
> >      >
> >      >      > +        ^{
> >      >      > +            if (s->surface &&
> >      >      > +                width =3D=3D surface_width(s->surface) &=
&
> >      >      > +                height =3D=3D surface_height(s->surface)=
) {
> >      >      > +                no_change =3D true;
> >      >      > +            }
> >      >      > +        });
> >      >      > +
> >      >      > +    if (no_change) {
> >      >      > +        return;
> >      >      > +    }
> >      >      > +
> >      >      > +    vram =3D g_malloc0(width * height * 4);
> >      >      > +    surface =3D qemu_create_displaysurface_from(width,
> height,
> >      >     PIXMAN_LE_a8r8g8b8,
> >      >      > +                                              width * 4,
> >     vram);
> >      >      > +
> >      >      > +    @autoreleasepool {
> >      >      > +        textureDescriptor =3D
> >      >      > +            [MTLTextureDescriptor
> >      >      > +
> >      >     texture2DDescriptorWithPixelFormat:MTLPixelFormatBGRA8Unorm
> >      >      > +                                             width:width
> >      >      > +                                            height:heigh=
t
> >      >      > +                                         mipmapped:NO];
> >      >      > +        textureDescriptor.usage =3D s-
> >      >pgdisp.minimumTextureUsage;
> >      >      > +        texture =3D [s->mtl
> >      >     newTextureWithDescriptor:textureDescriptor];
> >      >      > +    }
> >      >      > +
> >      >      > +    s->using_managed_texture_storage =3D
> >      >      > +        (texture.storageMode =3D=3D MTLStorageModeManage=
d);
> >      >      > +
> >      >      > +    dispatch_sync(s->render_queue,
> >      >      > +        ^{
> >      >      > +            id<MTLTexture> old_texture =3D nil;
> >      >      > +            void *old_vram =3D s->vram;
> >      >      > +            s->vram =3D vram;
> >      >      > +            s->surface =3D surface;
> >      >      > +
> >      >      > +            dpy_gfx_replace_surface(s->con, surface);
> >      >      > +
> >      >      > +            old_texture =3D s->texture;
> >      >      > +            s->texture =3D texture;
> >      >      > +            [old_texture release];
> >      >
> >      >     You can just do:
> >      >     [s->texture release];
> >      >     s->texture =3D texture;
> >      >
> >      >     This will make s->texture dangling between the two
> >     statements, but that
> >      >     don't matter since s->texture is not an atomic variable that
> >     can be
> >      >     safely observed from another thread anyway.
> >      >
> >      >      > +
> >      >      > +            if (s->pending_frames =3D=3D 0) {
> >      >      > +                g_free(old_vram);
> >      >      > +            }
> >      >      > +        });
> >      >      > +}
> >      >      > +
> >      >      > +static void create_fb(AppleGFXState *s)
> >      >      > +{
> >      >      > +    s->con =3D graphic_console_init(NULL, 0,
> >     &apple_gfx_fb_ops, s);
> >      >      > +    set_mode(s, 1440, 1080);
> >      >      > +
> >      >      > +    s->cursor_show =3D true;
> >      >      > +}
> >      >      > +
> >      >      > +static size_t apple_gfx_get_default_mmio_range_size(void=
)
> >      >      > +{
> >      >      > +    size_t mmio_range_size;
> >      >      > +    @autoreleasepool {
> >      >      > +        PGDeviceDescriptor *desc =3D [PGDeviceDescriptor
> new];
> >      >      > +        mmio_range_size =3D desc.mmioLength;
> >      >      > +        [desc release];
> >      >      > +    }
> >      >      > +    return mmio_range_size;
> >      >      > +}
> >      >      > +
> >      >      > +void apple_gfx_common_init(Object *obj, AppleGFXState *s=
,
> >     const
> >      >     char* obj_name)
> >      >
> >      >     This function can be merged into apple_gfx_common_realize().
> >      >
> >      >
> >      > Probably. I'll try it.
> >
> >
> > Upon further inspection, we need to call
> > cocoa_enable_runloop_on_main_thread() during the init phase, not
> > realize(). So we can't get rid of this entirely. Is there any value in
> > moving the other init code into _realize()?
>
> Calling cocoa_enable_runloop_on_main_thread() should be avoided even in
> apple_gfx_common_init(). QEMU can plug a device at runtime instead of
> initialization time, and in such a case, apple_gfx_common_init() will
> run after calling qemu_main.
>

Good point, it looks like I forgot to mark the mmio variant of apple-gfx
devices as non-hotpluggable; I've done that now. I strongly suspect the
guest driver doesn't support hotplugging anyway.


> I had a closer look and found it has a memory_region_init_io() call,
> which should remain in apple_gfx_common_init(). This leads to the same
> conclusion that we cannot remove this function so let's only move
> migrate_add_blocker() to apple_gfx_common_realize() to report its error.
>

Sounds good.



> >
> >      >      > +{
> >      >      > +    Error *local_err =3D NULL;
> >      >      > +    int r;
> >      >      > +    size_t mmio_range_size =3D
> >      >     apple_gfx_get_default_mmio_range_size();
> >      >      > +
> >      >      > +    trace_apple_gfx_common_init(obj_name,
> mmio_range_size);
> >      >      > +    memory_region_init_io(&s->iomem_gfx, obj,
> >     &apple_gfx_ops, s,
> >      >     obj_name,
> >      >      > +                          mmio_range_size);
> >      >      > +    s->iomem_gfx.disable_reentrancy_guard =3D true;
> >      >
> >      >     Why do you disable reentrancy guard?
> >      >
> >      >
> >      > Perhaps with the proposed AIO_WAIT_WHILE based I/O scheme, this
> >     won't be
> >      > an issue anymore, but the guard would otherwise keep dropping
> MMIOs
> >      > which immediately caused the PV graphics device to stop making
> >     progress.
> >      > The MMIO APIs in the PVG framework are thread- and reentrancy-
> >     safe, so
> >      > we certainly don't need to serialise them on our side.
> >
> >     It's better to understand why such reentrancy happens. Reentrancy
> >     itself
> >     is often a sign of bug.
> >
> >      >
> >      >      > +
> >      >      > +    /* TODO: PVG framework supports serialising device
> state:
> >      >     integrate it! */
> >      >      > +    if (apple_gfx_mig_blocker =3D=3D NULL) {
> >      >      > +        error_setg(&apple_gfx_mig_blocker,
> >      >      > +                  "Migration state blocked by apple-gfx
> >     display
> >      >     device");
> >      >      > +        r =3D migrate_add_blocker(&apple_gfx_mig_blocker=
,
> >     &local_err);
> >      >      > +        if (r < 0) {
> >      >      > +            error_report_err(local_err);
> >      >
> >      >     Please report the error to the caller of
> >     apple_gfx_common_realize()
> >      >     instead.
> >      >
> >      >      > +        }
> >      >      > +    }
> >      >       > +}> +
> >      >      > +static void
> >      >     apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
> >      >      > +
> >      >       PGDeviceDescriptor *desc)
> >      >      > +{
> >      >      > +    desc.createTask =3D ^(uint64_t vmSize, void * _Nulla=
ble
> *
> >      >     _Nonnull baseAddress) {
> >      >      > +        AppleGFXTask *task =3D apple_gfx_new_task(s,
> vmSize);
> >      >      > +        *baseAddress =3D (void*)task->address;
> >      >
> >      >     nit: please write as (void *) instead of (void*).
> >      >
> >      >      > +        trace_apple_gfx_create_task(vmSize, *baseAddress=
);
> >      >      > +        return task;
> >      >      > +    };
> >      >      > +
> >      >
> >      >      > +{
> >      >      > +    PGDisplayDescriptor *disp_desc =3D [PGDisplayDescrip=
tor
> >     new];
> >      >      > +
> >      >      > + disp_desc.name <http://disp_desc.name> <http://
> >     disp_desc.name <http://disp_desc.name>> =3D @"QEMU display";
> >      >      > +    disp_desc.sizeInMillimeters =3D NSMakeSize(400.,
> >     300.); /* A
> >      >     20" display */
> >      >      > +    disp_desc.queue =3D dispatch_get_main_queue();
> >      >      > +    disp_desc.newFrameEventHandler =3D ^(void) {
> >      >      > +        trace_apple_gfx_new_frame();
> >      >      > +        dispatch_async(s->render_queue, ^{
> >      >      > +            /* Drop frames if we get too far ahead. */
> >      >      > +            if (s->pending_frames >=3D 2)
> >      >      > +                return;
> >      >      > +            ++s->pending_frames;
> >      >      > +            if (s->pending_frames > 1) {
> >      >      > +                return;
> >      >      > +            }
> >      >      > +            @autoreleasepool {
> >      >      > +                apple_gfx_render_new_frame(s);
> >      >      > +            }
> >      >      > +        });
> >      >      > +    };
> >      >      > +    disp_desc.modeChangeHandler =3D ^(PGDisplayCoord_t
> >     sizeInPixels,
> >      >      > +                                    OSType pixelFormat) =
{
> >      >      > +        trace_apple_gfx_mode_change(sizeInPixels.x,
> >     sizeInPixels.y);
> >      >      > +        set_mode(s, sizeInPixels.x, sizeInPixels.y);
> >      >      > +    };
> >      >      > +    disp_desc.cursorGlyphHandler =3D ^(NSBitmapImageRep
> *glyph,
> >      >      > +                                     PGDisplayCoord_t
> >     hotSpot) {
> >      >      > +        uint32_t bpp =3D glyph.bitsPerPixel;
> >      >      > +        size_t width =3D glyph.pixelsWide;
> >      >      > +        size_t height =3D glyph.pixelsHigh;
> >      >      > +        size_t padding_bytes_per_row =3D glyph.bytesPerR=
ow
> >     - width
> >      >     * 4;
> >      >      > +        const uint8_t* px_data =3D glyph.bitmapData;
> >      >      > +
> >      >      > +        trace_apple_gfx_cursor_set(bpp, width, height);
> >      >      > +
> >      >      > +        if (s->cursor) {
> >      >      > +            cursor_unref(s->cursor);
> >      >      > +            s->cursor =3D NULL;
> >      >      > +        }
> >      >      > +
> >      >      > +        if (bpp =3D=3D 32) { /* Shouldn't be anything el=
se,
> >     but just
> >      >     to be safe...*/
> >      >      > +            s->cursor =3D cursor_alloc(width, height);
> >      >      > +            s->cursor->hot_x =3D hotSpot.x;
> >      >      > +            s->cursor->hot_y =3D hotSpot.y;
> >      >      > +
> >      >      > +            uint32_t *dest_px =3D s->cursor->data;
> >      >      > +
> >      >      > +            for (size_t y =3D 0; y < height; ++y) {
> >      >      > +                for (size_t x =3D 0; x < width; ++x) {
> >      >      > +                    /* NSBitmapImageRep's red & blue
> channels
> >      >     are swapped
> >      >      > +                     * compared to QEMUCursor's. */
> >      >      > +                    *dest_px =3D
> >      >      > +                        (px_data[0] << 16u) |
> >      >      > +                        (px_data[1] <<  8u) |
> >      >      > +                        (px_data[2] <<  0u) |
> >      >      > +                        (px_data[3] << 24u);
> >      >      > +                    ++dest_px;
> >      >      > +                    px_data +=3D 4;
> >      >      > +                }
> >      >      > +                px_data +=3D padding_bytes_per_row;
> >      >      > +            }
> >      >      > +            dpy_cursor_define(s->con, s->cursor);
> >      >      > +            update_cursor(s);
> >      >      > +        }
> >      >      > +    };
> >      >      > +    disp_desc.cursorShowHandler =3D ^(BOOL show) {
> >      >      > +        trace_apple_gfx_cursor_show(show);
> >      >      > +        s->cursor_show =3D show;
> >      >      > +        update_cursor(s);
> >      >      > +    };
> >      >      > +    disp_desc.cursorMoveHandler =3D ^(void) {
> >      >      > +        trace_apple_gfx_cursor_move();
> >      >      > +        update_cursor(s);
> >      >      > +    };
> >      >      > +
> >      >      > +    return disp_desc;
> >      >      > +}
> >      >      > +
> >      >      > +static NSArray<PGDisplayMode*>*
> >      >     apple_gfx_prepare_display_mode_array(void)
> >      >      > +{
> >      >      > +    PGDisplayMode *modes[ARRAY_SIZE(apple_gfx_modes)];
> >      >      > +    NSArray<PGDisplayMode*>* mode_array =3D nil;
> >      >      > +    int i;
> >      >      > +
> >      >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) =
{
> >      >      > +        modes[i] =3D
> >      >      > +            [[PGDisplayMode alloc]
> >      >     initWithSizeInPixels:apple_gfx_modes[i] refreshRateInHz:60.]=
;
> >      >      > +    }
> >      >      > +
> >      >      > +    mode_array =3D [NSArray arrayWithObjects:modes
> >      >     count:ARRAY_SIZE(apple_gfx_modes)];
> >      >      > +
> >      >      > +    for (i =3D 0; i < ARRAY_SIZE(apple_gfx_modes); i++) =
{
> >      >      > +        [modes[i] release];
> >      >      > +        modes[i] =3D nil;
> >      >      > +    }
> >      >      > +
> >      >      > +    return mode_array;
> >      >      > +}
> >      >      > +
> >      >      > +static id<MTLDevice> copy_suitable_metal_device(void)
> >      >      > +{
> >      >      > +    id<MTLDevice> dev =3D nil;
> >      >      > +    NSArray<id<MTLDevice>> *devs =3D MTLCopyAllDevices()=
;
> >      >      > +
> >      >      > +    /* Prefer a unified memory GPU. Failing that, pick a
> non-
> >      >     removable GPU. */
> >      >      > +    for (size_t i =3D 0; i < devs.count; ++i) {
> >      >      > +        if (devs[i].hasUnifiedMemory) {
> >      >      > +            dev =3D devs[i];
> >      >      > +            break;
> >      >      > +        }
> >      >      > +        if (!devs[i].removable) {
> >      >      > +            dev =3D devs[i];
> >      >      > +        }
> >      >      > +    }
> >      >      > +
> >      >      > +    if (dev !=3D nil) {
> >      >      > +        [dev retain];
> >      >      > +    } else {
> >      >      > +        dev =3D MTLCreateSystemDefaultDevice();
> >      >      > +    }
> >      >      > +    [devs release];
> >      >      > +
> >      >      > +    return dev;
> >      >      > +}
> >      >      > +
> >      >      > +void apple_gfx_common_realize(AppleGFXState *s,
> >      >     PGDeviceDescriptor *desc)
> >      >      > +{
> >      >      > +    PGDisplayDescriptor *disp_desc =3D nil;
> >      >      > +
> >      >      > +    QTAILQ_INIT(&s->tasks);
> >      >      > +    s->render_queue =3D dispatch_queue_create("apple-
> >     gfx.render",
> >      >      > +
> >     DISPATCH_QUEUE_SERIAL);
> >      >      > +    s->mtl =3D copy_suitable_metal_device();
> >      >      > +    s->mtl_queue =3D [s->mtl newCommandQueue];
> >      >      > +
> >      >      > +    desc.device =3D s->mtl;
> >      >      > +
> >      >      > +    apple_gfx_register_task_mapping_handlers(s, desc);
> >      >      > +
> >      >      > +    s->pgdev =3D PGNewDeviceWithDescriptor(desc);
> >      >      > +
> >      >      > +    disp_desc =3D apple_gfx_prepare_display_handlers(s);
> >      >      > +    s->pgdisp =3D [s->pgdev
> newDisplayWithDescriptor:disp_desc
> >      >      > +                                              port:0
> >      >     serialNum:1234];
> >      >      > +    [disp_desc release];
> >      >      > +    s->pgdisp.modeList =3D
> >     apple_gfx_prepare_display_mode_array();
> >      >      > +
> >      >      > +    create_fb(s);
> >      >      > +}
> >      >      > diff --git a/hw/display/meson.build
> b/hw/display/meson.build
> >      >      > index 7db05eace97..70d855749c0 100644
> >      >      > --- a/hw/display/meson.build
> >      >      > +++ b/hw/display/meson.build
> >      >      > @@ -65,6 +65,8 @@ system_ss.add(when: 'CONFIG_ARTIST',
> >     if_true:
> >      >     files('artist.c'))
> >      >      >
> >      >      >   system_ss.add(when: 'CONFIG_ATI_VGA', if_true:
> >     [files('ati.c',
> >      >     'ati_2d.c', 'ati_dbg.c'), pixman])
> >      >      >
> >      >      > +system_ss.add(when: 'CONFIG_MAC_PVG',         if_true:
> >      >     [files('apple-gfx.m'), pvg, metal])
> >      >      > +system_ss.add(when: 'CONFIG_MAC_PVG_VMAPPLE', if_true:
> >      >     [files('apple-gfx-vmapple.m'), pvg, metal])
> >      >      >
> >      >      >   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >      >      >     virtio_gpu_ss =3D ss.source_set()
> >      >      > diff --git a/hw/display/trace-events
> b/hw/display/trace-events
> >      >      > index 781f8a33203..1809a358e36 100644
> >      >      > --- a/hw/display/trace-events
> >      >      > +++ b/hw/display/trace-events
> >      >      > @@ -191,3 +191,29 @@ dm163_bits_ppi(unsigned dest_width)
> >      >     "dest_width : %u"
> >      >      >   dm163_leds(int led, uint32_t value) "led %d: 0x%x"
> >      >      >   dm163_channels(int channel, uint8_t value) "channel %d:
> >     0x%x"
> >      >      >   dm163_refresh_rate(uint32_t rr) "refresh rate %d"
> >      >      > +
> >      >      > +# apple-gfx.m
> >      >      > +apple_gfx_read(uint64_t offset, uint64_t res)
> >      >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      >      > +apple_gfx_write(uint64_t offset, uint64_t val)
> >      >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      >      > +apple_gfx_create_task(uint32_t vm_size, void *va)
> >     "vm_size=3D0x%x
> >      >     base_addr=3D%p"
> >      >      > +apple_gfx_destroy_task(void *task) "task=3D%p"
> >      >      > +apple_gfx_map_memory(void *task, uint32_t range_count,
> >     uint64_t
> >      >     virtual_offset, uint32_t read_only) "task=3D%p range_count=
=3D0x%x
> >      >     virtual_offset=3D0x%"PRIx64" read_only=3D%d"
> >      >      > +apple_gfx_map_memory_range(uint32_t i, uint64_t phys_add=
r,
> >      >     uint64_t phys_len) "[%d] phys_addr=3D0x%"PRIx64"
> >     phys_len=3D0x%"PRIx64
> >      >      > +apple_gfx_remap(uint64_t retval, uint64_t source, uint64=
_t
> >      >     target) "retval=3D%"PRId64" source=3D0x%"PRIx64" target=3D0x=
%"PRIx64
> >      >      > +apple_gfx_unmap_memory(void *task, uint64_t
> virtual_offset,
> >      >     uint64_t length) "task=3D%p virtual_offset=3D0x%"PRIx64"
> >     length=3D0x%"PRIx64
> >      >      > +apple_gfx_read_memory(uint64_t phys_address, uint64_t
> length,
> >      >     void *dst) "phys_addr=3D0x%"PRIx64" length=3D0x%"PRIx64" des=
t=3D%p"
> >      >      > +apple_gfx_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      >      > +apple_gfx_new_frame(void) ""
> >      >      > +apple_gfx_mode_change(uint64_t x, uint64_t y) "x=3D%"PRI=
d64"
> >      >     y=3D%"PRId64
> >      >      > +apple_gfx_cursor_set(uint32_t bpp, uint64_t width,
> uint64_t
> >      >     height) "bpp=3D%d width=3D%"PRId64" height=3D0x%"PRId64
> >      >      > +apple_gfx_cursor_show(uint32_t show) "show=3D%d"
> >      >      > +apple_gfx_cursor_move(void) ""
> >      >      > +apple_gfx_common_init(const char *device_name, size_t
> >     mmio_size)
> >      >     "device: %s; MMIO size: %zu bytes"
> >      >      > +
> >      >      > +# apple-gfx-vmapple.m
> >      >      > +apple_iosfc_read(uint64_t offset, uint64_t res)
> >      >     "offset=3D0x%"PRIx64" res=3D0x%"PRIx64
> >      >      > +apple_iosfc_write(uint64_t offset, uint64_t val)
> >      >     "offset=3D0x%"PRIx64" val=3D0x%"PRIx64
> >      >      > +apple_iosfc_map_memory(uint64_t phys, uint64_t len,
> >     uint32_t ro,
> >      >     void *va, void *e, void *f) "phys=3D0x%"PRIx64" len=3D0x%"PR=
Ix64"
> >     ro=3D%d
> >      >     va=3D%p e=3D%p f=3D%p"
> >      >      > +apple_iosfc_unmap_memory(void *a, void *b, void *c, void
> *d,
> >      >     void *e, void *f) "a=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p=
"
> >      >      > +apple_iosfc_raise_irq(uint32_t vector) "vector=3D0x%x"
> >      >      > +
> >      >      > diff --git a/meson.build b/meson.build
> >      >      > index 10464466ff3..f09df3f09d5 100644
> >      >      > --- a/meson.build
> >      >      > +++ b/meson.build
> >      >      > @@ -741,6 +741,8 @@ socket =3D []
> >      >      >   version_res =3D []
> >      >      >   coref =3D []
> >      >      >   iokit =3D []
> >      >      > +pvg =3D []
> >      >      > +metal =3D []
> >      >      >   emulator_link_args =3D []
> >      >      >   midl =3D not_found
> >      >      >   widl =3D not_found
> >      >      > @@ -762,6 +764,8 @@ elif host_os =3D=3D 'darwin'
> >      >      >     coref =3D dependency('appleframeworks', modules:
> >     'CoreFoundation')
> >      >      >     iokit =3D dependency('appleframeworks', modules: 'IOK=
it',
> >      >     required: false)
> >      >      >     host_dsosuf =3D '.dylib'
> >      >      > +  pvg =3D dependency('appleframeworks', modules:
> >      >     'ParavirtualizedGraphics')
> >      >      > +  metal =3D dependency('appleframeworks', modules: 'Meta=
l')
> >      >      >   elif host_os =3D=3D 'sunos'
> >      >      >     socket =3D [cc.find_library('socket'),
> >      >      >               cc.find_library('nsl'),
> >      >
> >
>
>

--000000000000be834f06240c98cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 7 Oct 2024 at 10:25, Akihiko =
Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.odaki@daynix.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><br>
&gt;=C2=A0 =C2=A0 =C2=A0Theoretically, It should be safe to assume the call=
ee creates<br>
&gt;=C2=A0 =C2=A0 =C2=A0autoreleasepool by themselves as needed in general.=
 We have bunch of<br>
&gt;=C2=A0 =C2=A0 =C2=A0code to call Objective-C APIs without creating auto=
releasepool in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0caller. Practically, [PGDeviceDescriptor new] is li=
kely to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0implemented with ARC, which wraps methods in autore=
leasepool as<br>
&gt;=C2=A0 =C2=A0 =C2=A0necessary.<br>
&gt; <br>
&gt; <br>
&gt; As far as I&#39;m aware, ARC does NOT automatically insert autorelease=
 pool <br>
&gt; blocks. The reason you rarely need to create autoreleasepool blocks in=
 <br>
&gt; &quot;plain&quot; Objective-C programming is that Cocoa/CFRunloop/libd=
ispatch <br>
&gt; event handlers run each event in an autoreleasepool. So you don&#39;t =
need <br>
&gt; to create them explicitly when using dispatch_async and similar, or wh=
en <br>
&gt; running code on the main thread (which runs inside NSApplicationMain/ =
<br>
&gt; CFRunloopRun/dispatch_main).<br>
<br>
My statement regarding ARC was wrong; It seems ARC just retains a value <br=
>
annoted as autoreleased.<br></blockquote><div><br></div><div>Yes, the runti=
me maintains a sort of shadow stack of pointers to autoreleased objects for=
 each thread. When you enter a pool block, it remembers the position in the=
 shadow stack. On exiting the pool, all objects added since entering the po=
ol are popped from the shadow stack and released.<br></div><div><br></div><=
div>Hence, if objects are added to the stack outside of ANY autorelease poo=
l, those are never popped and released.<br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; As far as I&#39;m aware, if you don&#39;t explicitly define autoreleas=
epools in <br>
&gt; raw threads created with the pthreads API, any autoreleased objects wi=
ll <br>
&gt; leak. At least I&#39;ve not found any specification/documentation <br>
&gt; contradicting this. And most code in Qemu runs on such raw threads, so=
 <br>
&gt; we need to play it safe with regard to autorelease semantics.<br>
<br>
I decided to dig deeper and found this documentation:<br>
<a href=3D"https://developer.apple.com/library/archive/documentation/Cocoa/=
Conceptual/MemoryMgmt/Articles/mmAutoreleasePools.html" rel=3D"noreferrer" =
target=3D"_blank">https://developer.apple.com/library/archive/documentation=
/Cocoa/Conceptual/MemoryMgmt/Articles/mmAutoreleasePools.html</a><br>
<br>
It says:<br>
=C2=A0&gt; Cocoa always expects code to be executed within an autorelease p=
ool<br>
=C2=A0&gt; block, otherwise autoreleased objects do not get released and yo=
ur<br>
=C2=A0&gt; application leaks memory.<br>
<br>
So yes, we must wrap everything in @autoreleasepool at least for Cocoa. <br=
>
It is probably a good practice to wrap all Objective-C code in <br>
@autoreleasepool.<br></blockquote><div><br></div><div>Yes; any method or fu=
nction returning an Objective-C object pointer using autorelease semantics =
- either annotated or by naming convention - will use the pool. But unless =
it&#39;s all your own code all the way down, you don&#39;t know if anything=
 inside a method whose own return value is not autoreleased might use autor=
elease semantics.</div><div><br></div><div>(The naming convention says most=
 methods return autoreleased, except those named create*, new*, or similar.=
)<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt; Whether the existing Qemu Objective-C code is safe in this regard I <b=
r>
&gt; don&#39;t know for certain, but I&#39;ve certainly paid attention to t=
his aspect <br>
&gt; when modifying ui/cocoa.m in the past, and indeed most of that code ru=
ns <br>
&gt; on the main thread. Note also how I wrap the apple_gfx_render_new_fram=
e <br>
&gt; call in a pool when it can&#39;t be guaranteed it&#39;s running on a d=
ispatch <br>
&gt; queue because the command buffer inside that uses autorelease semantic=
s.<br>
<br>
It is more about event loop rather than thread. Resources allocated <br>
before [NSApp run] will leak even if they are autoreleased in the main <br>
thread. apple_gfx_common_realize() is one of such functions that run in <br=
>
the main thread before [NSApp run]. In ui/cocoa, cocoa_display_init() <br>
runs before [NSApp run]. Fortunately we already have NSAutoreleasePool <br>
for this function.<br></blockquote><div><br></div><div>Yes. Unless it&#39;s=
 very clear that the code will run only in a Cocoa event handler or dispatc=
h queue context, you need to use an autoreleasepool.<br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Functions that uses a method that returns autorelea=
se resources should<br>
&gt;=C2=A0 =C2=A0 =C2=A0be wrapped with autoreleasepool instead of assuming=
 the caller creates<br>
&gt;=C2=A0 =C2=A0 =C2=A0autoreleasepool for them.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;m treating=C2=A0apple_gfx_common_realize as an internal API, and=
 I don&#39;t <br>
&gt; think expecting its callers to wrap it in an autoreleasepool block is =
<br>
&gt; unreasonable. I can certainly explicitly document this in a comment.<b=
r>
<br>
We don&#39;t have a comment for cocoa_display_init() and it&#39;s more abou=
t <br>
generic macOS programming so it&#39;s not necessary.<br>
<br>
=C2=A0&gt; &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --gi=
t a/hw/display/apple-gfx.m <br>
b/hw/display/apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; new file mode 100644=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 00000000000..8=
37300f9cd4<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/app=
le-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -0,0 +1,536 @@<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * QEMU Apple Parav=
irtualizedGraphics.framework device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * Copyright =C2=A9=
 2023 Amazon.com, Inc. or its affiliates. All<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Rights Reserved.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * This work is lic=
ensed under the terms of the GNU GPL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0version<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A02 or later.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * See the COPYING =
file in the top-level directory.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * ParavirtualizedG=
raphics.framework is a set of<br>
&gt;=C2=A0 =C2=A0 =C2=A0libraries that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0macOS provides<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * which implements=
 3d graphics passthrough to the host<br>
&gt;=C2=A0 =C2=A0 =C2=A0as well as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * proprietary gues=
t communication channel to drive it. This<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0device model<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + * implements suppo=
rt to drive that library from within QEMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;appl=
e-gfx.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;trac=
e.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qemu=
/main-loop.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;ui/c=
onsole.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;moni=
tor/monitor.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;qapi=
/error.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &quot;migr=
ation/blocker.h&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#include &lt;mach/m=
ach_vm.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +#import &lt;Paravir=
tualizedGraphics/ParavirtualizedGraphics.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const PGDisp=
layCoord_t apple_gfx_modes[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { .x =
=3D 1440, .y =3D 1080 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 { .x =
=3D 1280, .y =3D 1024 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +typedef struct PGTa=
sk_s { // Name matches forward<br>
&gt;=C2=A0 =C2=A0 =C2=A0declaration in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0PG header<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Let&#39;s name it AppleGFX=
Task. It is a common practice to have<br>
&gt;=C2=A0 =C2=A0 =C2=A0the same<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0name and typedef in QEMU.<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This is defining a forward-declared type from=
 framework headers<br>
&gt;=C2=A0 =C2=A0 =C2=A0which is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; opaque from the framework&#39;s point of view=
. We do not get to<br>
&gt;=C2=A0 =C2=A0 =C2=A0choose its<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; struct name. The alternative is having casts =
wherever these<br>
&gt;=C2=A0 =C2=A0 =C2=A0objects are<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; being passed between our code and the framewo=
rk. (See the<br>
&gt;=C2=A0 =C2=A0 =C2=A0original v1/v2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; vmapple patch series for how messy this is.)<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I got the idea. Let&#39;s not avoid the typedef the=
n to clarify the naming<br>
&gt;=C2=A0 =C2=A0 =C2=A0is not under our control.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;m not sure what you mean by this double negative. Are you saying=
, <br>
&gt; don&#39;t add our own typedef for struct PGTask_s at all, just use the=
 <br>
&gt; framework-supplied PGTask_t where appropriate?<br>
<br>
Yes.<br>
<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_render_frame_completed(AppleGFXState *s,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0void *vram,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0id&lt;MTLTexture&gt; texture)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 --s-&=
gt;pending_frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 asser=
t(s-&gt;pending_frames &gt;=3D 0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (v=
ram !=3D s-&gt;vram) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Display mode has changed, drop this old frame. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 assert(texture !=3D s-&gt;texture);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 g_free(vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0This management of buffers=
 looks a bit convoluted. I suggest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0remembering<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0the width and height inste=
ad of pointers and comparing them.<br>
&gt;=C2=A0 =C2=A0 =C2=A0This way<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0you can free resources in =
set_mode().<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Yeah, I suppose that works, I can change that=
 around.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } els=
e {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 copy_mtl_texture_to_surface_mem(texture, vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Writing vram outside BQL m=
ay result in tearing.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; As far as I can tell(*), QXL does the same. I=
 couldn&#39;t find any<br>
&gt;=C2=A0 =C2=A0 =C2=A0examples<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; of double-buffering in any of the existing di=
splay devices, which<br>
&gt;=C2=A0 =C2=A0 =C2=A0would<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; be the only way to do async updates efficient=
ly and without<br>
&gt;=C2=A0 =C2=A0 =C2=A0tearing. In<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; any case, this solution is still vastly bette=
r than a regular VGA<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; device, which suffers from very visible teari=
ng with macOS on the<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; side anyway. And in an ideal world, we&#39;d =
pass through the rendered<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; texture directly to the Cocoa UI code rather =
than copying out<br>
&gt;=C2=A0 =C2=A0 =C2=A0only for<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the CPU to draw it back into a window surface=
 which is then<br>
&gt;=C2=A0 =C2=A0 =C2=A0passed to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; the GPU for host side rendering. But I felt t=
his patch is already<br>
&gt;=C2=A0 =C2=A0 =C2=A0very,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; very large, and if anyone cares, we can fix i=
mperfections in<br>
&gt;=C2=A0 =C2=A0 =C2=A0subsequent<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; updates.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (*)The rendering code in that device is also =
fairly complex, so I<br>
&gt;=C2=A0 =C2=A0 =C2=A0may be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; misreading it.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0QXL always modifies the surface with BQL. The surfa=
ce is modified with<br>
&gt;=C2=A0 =C2=A0 =C2=A0qxl_blit(), which is called by qxl_render_update_ar=
ea_unlocked().<br>
&gt;=C2=A0 =C2=A0 =C2=A0qxl_render_update_area_unlocked() is called by eith=
er of<br>
&gt;=C2=A0 =C2=A0 =C2=A0qxl_render_update() and qxl_render_update_area_bh()=
. Both of them are<br>
&gt;=C2=A0 =C2=A0 =C2=A0called with BQL. The name includes &quot;unlocked&q=
uot;, but it means it is<br>
&gt;=C2=A0 =C2=A0 =C2=A0called<br>
&gt;=C2=A0 =C2=A0 =C2=A0without holding QXL-internal lock.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Most devices works entirely with BQL so they don&#3=
9;t perform double<br>
&gt;=C2=A0 =C2=A0 =C2=A0buffering. apple-gfx can do the same.<br>
&gt; <br>
&gt; <br>
&gt; I think we can safely move apple-gfx&#39;s framebuffer state managemen=
t back <br>
&gt; inside the BQL, yes. I just figured that copying dozens of megabytes o=
f <br>
&gt; framebuffer data on every frame while holding the lock was not going t=
o <br>
&gt; help BQL contention. Especially as PVG does not have a concept of dirt=
y <br>
&gt; areas, so we must copy the whole framebuffer every time. (Unless we we=
re <br>
&gt; to implement dirty area detection ourselves.)<br>
&gt; <br>
&gt; Unfortunately, implementing double-buffering would require a major <br=
>
&gt; rework of Qemu&#39;s whole surface management, console code, and proba=
bly <br>
&gt; most of the UI implementations. I&#39;m guessing the OpenGL fast-path =
<br>
&gt; sidesteps all of this, so replicating that with Metal would probably b=
e <br>
&gt; the easier way forward. (Although doing all this graphics stuff inside=
 <br>
&gt; the BQL generally seems like a major architectural flaw; I suppose mos=
t <br>
&gt; enterprise use of Qemu does not involve the framebuffer, so it&#39;s n=
ot <br>
&gt; shown up in BQL contention profiling there. It certainly does in deskt=
op <br>
&gt; use, although at least on macOS hosts there are far worse culprits in =
<br>
&gt; that regard.)<br>
<br>
We don&#39;t need double-buffering; instead we can have one thread that <br=
>
renders the UI and also<br>
[PGDisplay -encodeCurrentFrameToCommandBuffer:texture:region:]. <br>
Rendering the UI in machine event loop in one thread is a bad idea in <br>
the first place so it will make sense to extract all UI work into a <br>
separate thread. This still requires a lot of work because the UI code <br>
assumes BQL everywhere.<br></blockquote><div><br></div><div>I&#39;m not rew=
orking the UI layer in this patch set, so it sounds like the best we can do=
 is to acquire the BQL for updating the console framebuffer and just take t=
he lock contention hit.</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
In my understanding BQL is less problematic for KVM users because QEMU <br>
can (sometimes) avoid locking BQL in the vCPU threads.<br></blockquote><div=
><br></div><div>Yeah, the current hvf implementation is unfortunately still=
 very BQL heavy. Part of that is down to the interrupt controller: with the=
 KVM accel, you typically use the interrupt controller provided by the kern=
el. With the hvf accel, you get a lot of VM exits for servicing interrupt c=
ontroller I/O; at least on x86, the APIC implementation only works inside t=
he BQL. HVF on x86-64 does technically have an in-kernel APIC implementatio=
n; unfortunately, it has some severe bugs which prevent using it in the gen=
eral case. (EOI signalling to the IOAPIC does not work/FB14425590; the beha=
viour for coalescing and retriggering of level-triggered interrupts is also=
 flawed/FB14425412.) On the aarch64 side, an in-kernel GIC implementation w=
as only just added to hvf with macOS 15.<br></div><div><br></div><div>I hav=
e submitted a patch that at least adds x2apic support to the hvf accel and =
thus significantly reduces BQL pressure a few times, but the  maintainers o=
f the x86 hvf backend don&#39;t seem to be active at the moment.<br></div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (s-&gt;gfx_update_requested) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0This assignment is unneces=
sary as s-&gt;new_frame_ready is<br>
&gt;=C2=A0 =C2=A0 =C2=A0always false<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0when s-&gt;gfx_update_requ=
ested. If you want to make sure<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s-&gt;gfx_update_requested=
 and s-&gt;new_frame_ready are mutually<br>
&gt;=C2=A0 =C2=A0 =C2=A0exclusive,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0use one enum value instead=
 of having two bools.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I&#39;ll need to refresh my memory and get ba=
ck to you on this one, it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; been so many months since I actively worked o=
n this code.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (s=
-&gt;pending_frames &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 apple_gfx_render_new_frame(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void apple_g=
fx_fb_update_display(void *opaque)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Apple=
GFXState *s =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispa=
tch_async(s-&gt;render_queue, ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (s-&gt;pending_frames &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0It should check for s-&gt;=
new_frame_ready as<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_render_frame_com=
pleted() doesn&#39;t check if<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s-&gt;pending_frames &gt; =
0 before calling<br>
&gt;=C2=A0 =C2=A0 =C2=A0graphic_hw_update_done(), which is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0inconsistent.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; pending_frames is about guest-side frames tha=
t are queued to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0rendered<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; by the host GPU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; new_frame_ready being true indicates that the=
 contents of the Qemu<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; console surface has been updated with new fra=
me data since the last<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; gfx_update.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; gfx_update_requested indicates that gfx_updat=
e is currently<br>
&gt;=C2=A0 =C2=A0 =C2=A0awaiting an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; async completion (graphic_hw_update_done) but=
 the surface has not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; received a new frame content, but the GPU is =
stily busy drawing one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; apple_gfx_render_frame_completed is scheduled=
 exactly once per<br>
&gt;=C2=A0 =C2=A0 =C2=A0pending<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; frame, so pending_frames &gt; 0 is an invaria=
nt there. (Hence the<br>
&gt;=C2=A0 =C2=A0 =C2=A0assert.)&gt; &gt; I don&#39;t think there is any in=
consistency here, but I&#39;ll<br>
&gt;=C2=A0 =C2=A0 =C2=A0double check.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; It&#39;s possible that there&#39;s an easier =
way to express the state<br>
&gt;=C2=A0 =C2=A0 =C2=A0machine,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; and I&#39;ll take a look at that.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I meant that apple_gfx_render_frame_completed() doe=
s not check if the<br>
&gt;=C2=A0 =C2=A0 =C2=A0frame is the last one currently pending. apple_gfx_=
fb_update_display()<br>
&gt;=C2=A0 =C2=A0 =C2=A0ignores a new ready frame when there is a more pend=
ing frame, but<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_render_frame_completed() unconditionally =
fires<br>
&gt;=C2=A0 =C2=A0 =C2=A0graphic_hw_update_done() even if there is a more pe=
nding frame. And I<br>
&gt;=C2=A0 =C2=A0 =C2=A0think apple_gfx_render_frame_completed() is right a=
nd<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_fb_update_display() is wrong in such a si=
tuation.<br>
&gt; <br>
&gt; <br>
&gt; OK, got it. And yes, I agree.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Checking if s-&gt;pending_=
frames &gt; 0 both in<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_fb_update_display()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0and apple_gfx_render_frame=
_completed() is also problematic as<br>
&gt;=C2=A0 =C2=A0 =C2=A0that can<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0defer graphic_hw_update_do=
ne() indefinitely if we are getting new<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0frames<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0too fast.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; I see what you mean about this part. I&#39;ll=
 have to test it, but I<br>
&gt;=C2=A0 =C2=A0 =C2=A0guess<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; we should reverse the priority, like this:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;n=
ew_frame_ready) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dpy_gfx_update_full(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;new_frame_ready =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (=
s-&gt;pending_frames &gt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;gfx_update_requested =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 1. If we already have a frame, ready to be di=
splayed, return it<br>
&gt;=C2=A0 =C2=A0 =C2=A0immediately.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 2. If the guest has reported that it&#39;s co=
mpleted a frame and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0GPU is<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; currently busy rendering it, defer graphic_hw=
_update_done until<br>
&gt;=C2=A0 =C2=A0 =C2=A0it&#39;s done.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; 3. If the guest reports no changes to its dis=
play, indicate this<br>
&gt;=C2=A0 =C2=A0 =C2=A0back to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Qemu as a no-op display update graphic_hw_upd=
ate_done() with no<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; dpy_gfx_update* call.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Yes, that looks correct.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;gfx_update_requested =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;new_frame_ready) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update_full(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;new_frame_ready =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 graphic_hw_update_done(s-&gt;con);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }&gt; +=C2=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static const Graphi=
cHwOps apple_gfx_fb_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .gfx_=
update =3D apple_gfx_fb_update_display,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 .gfx_=
update_async =3D true,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void update_=
cursor(AppleGFXState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dpy_m=
ouse_set(s-&gt;con, s-&gt;pgdisp.cursorPosition.x,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;pgdisp.cursorPosition.y=
, s-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;cursor_show);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void set_mod=
e(AppleGFXState *s, uint32_t width,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0height)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 void =
*vram =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Displ=
aySurface *surface;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 MTLTe=
xtureDescriptor *textureDescriptor;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt=
;MTLTexture&gt; texture =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 __blo=
ck bool no_change =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispa=
tch_sync(s-&gt;render_queue,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Calling dispatch_sync() wh=
ile holding BQL may result in deadlock.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Only if any code executed on the same dispatc=
h queue acquires the<br>
&gt;=C2=A0 =C2=A0 =C2=A0lock<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; either directly or transitively. I believe I =
have ensure this is not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; done on the reqnder_queue, have you found any=
where this is the case?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The documentation is not clear what threads a dispa=
tch queue runs<br>
&gt;=C2=A0 =C2=A0 =C2=A0on. We<br>
&gt;=C2=A0 =C2=A0 =C2=A0can have a deadlock if they lock the BQL.<br>
&gt; <br>
&gt; <br>
&gt; dispatch_sync is a synchronisation primitive (it waits for and asserts=
 <br>
&gt; exclusive access to the given queue), it doesn&#39;t actually do any t=
hread <br>
&gt; scheduling. Work scheduled asynchronously to non-main dispatch queues =
<br>
&gt; will otherwise run on libdispatch pool threads. Running blocks on <br>
&gt; dispatch queues will not preempt and schedule it on other threads whic=
h <br>
&gt; may or may not be holding some locks.<br>
<br>
What if all pool threads are waiting for BQL?<br></blockquote><div><br></di=
v><div>The pool is elastic, so if threads are blocked (in syscalls) and the=
re are queued tasks ready to run, the runtime will create more threads as n=
ecessary.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; <br>
&gt; So the only way this code will deadlock is if any code scheduled to <b=
r>
&gt; render_queue directly or transitively acquires the BQL. None of it doe=
s, <br>
&gt; although updating the console while holding the BQL rather complicates=
 this.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;surface &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width =3D=3D surface_width(s-&gt;sur=
face) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 height =3D=3D surface_height(s-&gt;s=
urface)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_change =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (n=
o_change) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 vram =
=3D g_malloc0(width * height * 4);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 surfa=
ce =3D qemu_create_displaysurface_from(width, height,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0PIXMAN_LE_a8r8g8b8,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width=
 * 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 @auto=
releasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 textureDescriptor =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [MTLTextureDescriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0texture2DDescriptorWithPix=
elFormat:MTLPixelFormatBGRA8Unorm<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width:=
width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 height:heigh=
t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mipmapped:NO];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 textureDescriptor.usage =3D s-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;pgdisp.minimumTextureUsage;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 texture =3D [s-&gt;mtl<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0newTextureWithDescriptor:t=
extureDescriptor];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;using_managed_texture_storage =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (texture.storageMode =3D=3D MTLStorageModeManaged);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 dispa=
tch_sync(s-&gt;render_queue,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 id&lt;MTLTexture&gt; old_texture =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 void *old_vram =3D s-&gt;vram;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;vram =3D vram;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;surface =3D surface;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_replace_surface(s-&gt;con, surface);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 old_texture =3D s-&gt;texture;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;texture =3D texture;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [old_texture release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0You can just do:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0[s-&gt;texture release];<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s-&gt;texture =3D texture;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0This will make s-&gt;textu=
re dangling between the two<br>
&gt;=C2=A0 =C2=A0 =C2=A0statements, but that<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0don&#39;t matter since s-&=
gt;texture is not an atomic variable that<br>
&gt;=C2=A0 =C2=A0 =C2=A0can be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0safely observed from anoth=
er thread anyway.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(old_vram);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void create_=
fb(AppleGFXState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;con =3D graphic_console_init(NULL, 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;apple_gfx_fb_ops, s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 set_m=
ode(s, 1440, 1080);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;cursor_show =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static size_t apple=
_gfx_get_default_mmio_range_size(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_=
t mmio_range_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 @auto=
releasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 PGDeviceDescriptor *desc =3D [PGDeviceDescriptor new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mmio_range_size =3D desc.mmioLength;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [desc release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 retur=
n mmio_range_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_comm=
on_init(Object *obj, AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0const<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0char* obj_name)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0This function can be merge=
d into apple_gfx_common_realize().<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Probably. I&#39;ll try it.<br>
&gt; <br>
&gt; <br>
&gt; Upon further inspection, we need to call <br>
&gt; cocoa_enable_runloop_on_main_thread() during the init phase, not <br>
&gt; realize(). So we can&#39;t get rid of this entirely. Is there any valu=
e in <br>
&gt; moving the other init code into _realize()?<br>
<br>
Calling cocoa_enable_runloop_on_main_thread() should be avoided even in <br=
>
apple_gfx_common_init(). QEMU can plug a device at runtime instead of <br>
initialization time, and in such a case, apple_gfx_common_init() will <br>
run after calling qemu_main.<br></blockquote><div><br></div><div>Good point=
, it looks like I forgot to mark the mmio variant of apple-gfx devices as n=
on-hotpluggable; I&#39;ve done that now. I strongly suspect the guest drive=
r doesn&#39;t support hotplugging anyway.<br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
I had a closer look and found it has a memory_region_init_io() call, <br>
which should remain in apple_gfx_common_init(). This leads to the same <br>
conclusion that we cannot remove this function so let&#39;s only move <br>
migrate_add_blocker() to apple_gfx_common_realize() to report its error.<br=
></blockquote><div><br></div><div>Sounds good. <br></div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 Error=
 *local_err =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int r=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 size_=
t mmio_range_size =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_get_default_mmio=
_range_size();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 trace=
_apple_gfx_common_init(obj_name, mmio_range_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 memor=
y_region_init_io(&amp;s-&gt;iomem_gfx, obj,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;apple_gfx_ops, s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0obj_name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
mio_range_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;iomem_gfx.disable_reentrancy_guard =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Why do you disable reentra=
ncy guard?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Perhaps with the proposed AIO_WAIT_WHILE base=
d I/O scheme, this<br>
&gt;=C2=A0 =C2=A0 =C2=A0won&#39;t be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; an issue anymore, but the guard would otherwi=
se keep dropping MMIOs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; which immediately caused the PV graphics devi=
ce to stop making<br>
&gt;=C2=A0 =C2=A0 =C2=A0progress.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; The MMIO APIs in the PVG framework are thread=
- and reentrancy-<br>
&gt;=C2=A0 =C2=A0 =C2=A0safe, so<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; we certainly don&#39;t need to serialise them=
 on our side.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s better to understand why such reentrancy h=
appens. Reentrancy<br>
&gt;=C2=A0 =C2=A0 =C2=A0itself<br>
&gt;=C2=A0 =C2=A0 =C2=A0is often a sign of bug.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* TO=
DO: PVG framework supports serialising device state:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0integrate it! */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (a=
pple_gfx_mig_blocker =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error_setg(&amp;apple_gfx_mig_blocker,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Migration state blocked=
 by apple-gfx<br>
&gt;=C2=A0 =C2=A0 =C2=A0display<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0device&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 r =3D migrate_add_blocker(&amp;apple_gfx_mig_blocker,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&amp;local_err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (r &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Please report the error to=
 the caller of<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_common_realize()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0instead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; +}&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static void<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_register_task_ma=
pping_handlers(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor =
*desc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.=
createTask =3D ^(uint64_t vmSize, void * _Nullable *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0_Nonnull baseAddress) {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 AppleGFXTask *task =3D apple_gfx_new_task(s, vmSize);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *baseAddress =3D (void*)task-&gt;address;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0nit: please write as (void=
 *) instead of (void*).<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace_apple_gfx_create_task(vmSize, *baseAddress);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return task;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDis=
playDescriptor *disp_desc =3D [PGDisplayDescriptor<br>
&gt;=C2=A0 =C2=A0 =C2=A0new];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; + <a href=3D"http://=
disp_desc.name" rel=3D"noreferrer" target=3D"_blank">disp_desc.name</a> &lt=
;<a href=3D"http://disp_desc.name" rel=3D"noreferrer" target=3D"_blank">htt=
p://disp_desc.name</a>&gt; &lt;http://<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://disp_desc.name" rel=3D"noreferrer=
" target=3D"_blank">disp_desc.name</a> &lt;<a href=3D"http://disp_desc.name=
" rel=3D"noreferrer" target=3D"_blank">http://disp_desc.name</a>&gt;&gt; =
=3D @&quot;QEMU display&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.sizeInMillimeters =3D NSMakeSize(400.,<br>
&gt;=C2=A0 =C2=A0 =C2=A0300.); /* A<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A020&quot; display */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.queue =3D dispatch_get_main_queue();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.newFrameEventHandler =3D ^(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace_apple_gfx_new_frame();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dispatch_async(s-&gt;render_queue, ^{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* Drop frames if we get too far ahead. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &gt;=3D 2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ++s-&gt;pending_frames;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;pending_frames &gt; 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @autoreleasepool {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 apple_gfx_render_new_frame(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 });<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.modeChangeHandler =3D ^(PGDisplayCoord_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0sizeInPixels,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OSType pixelFormat) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace_apple_gfx_mode_change(sizeInPixels.x,<br>
&gt;=C2=A0 =C2=A0 =C2=A0sizeInPixels.y);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 set_mode(s, sizeInPixels.x, sizeInPixels.y);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.cursorGlyphHandler =3D ^(NSBitmapImageRep *glyph,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PGDisplayCoord_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0hotSpot) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint32_t bpp =3D glyph.bitsPerPixel;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size_t width =3D glyph.pixelsWide;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size_t height =3D glyph.pixelsHigh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size_t padding_bytes_per_row =3D glyph.bytesPerRow<br>
&gt;=C2=A0 =C2=A0 =C2=A0- width<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0* 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const uint8_t* px_data =3D glyph.bitmapData;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace_apple_gfx_cursor_set(bpp, width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (s-&gt;cursor) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(s-&gt;cursor);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (bpp =3D=3D 32) { /* Shouldn&#39;t be anything else,<br>
&gt;=C2=A0 =C2=A0 =C2=A0but just<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0to be safe...*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor =3D cursor_alloc(width, height);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_x =3D hotSpot.x;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cursor-&gt;hot_y =3D hotSpot.y;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *dest_px =3D s-&gt;cursor-&gt;data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t y =3D 0; y &lt; height; ++y) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (size_t x =3D 0; x &lt; width; +=
+x) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* NSBitmapImageRep&#3=
9;s red &amp; blue channels<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0are swapped<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* compared to QE=
MUCursor&#39;s. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dest_px =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data=
[0] &lt;&lt; 16u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data=
[1] &lt;&lt;=C2=A0 8u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data=
[2] &lt;&lt;=C2=A0 0u) |<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (px_data=
[3] &lt;&lt; 24u);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ++dest_px;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D 4;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 px_data +=3D padding_bytes_per_row;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dpy_cursor_define(s-&gt;con, s-&gt;cursor);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 update_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.cursorShowHandler =3D ^(BOOL show) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace_apple_gfx_cursor_show(show);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 s-&gt;cursor_show =3D show;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 update_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc.cursorMoveHandler =3D ^(void) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 trace_apple_gfx_cursor_move();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 update_cursor(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 };<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 retur=
n disp_desc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static NSArray&lt;P=
GDisplayMode*&gt;*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_prepare_display_=
mode_array(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDis=
playMode *modes[ARRAY_SIZE(apple_gfx_modes)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 NSArr=
ay&lt;PGDisplayMode*&gt;* mode_array =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 int i=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (=
i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 modes[i] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 [[PGDisplayMode alloc]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0initWithSizeInPixels:apple=
_gfx_modes[i] refreshRateInHz:60.];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 mode_=
array =3D [NSArray arrayWithObjects:modes<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0count:ARRAY_SIZE(apple_gfx=
_modes)];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (=
i =3D 0; i &lt; ARRAY_SIZE(apple_gfx_modes); i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [modes[i] release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 modes[i] =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 retur=
n mode_array;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +static id&lt;MTLDev=
ice&gt; copy_suitable_metal_device(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 id&lt=
;MTLDevice&gt; dev =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 NSArr=
ay&lt;id&lt;MTLDevice&gt;&gt; *devs =3D MTLCopyAllDevices();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* Pr=
efer a unified memory GPU. Failing that, pick a non-<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0removable GPU. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 for (=
size_t i =3D 0; i &lt; devs.count; ++i) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (devs[i].hasUnifiedMemory) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!devs[i].removable) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dev =3D devs[i];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (d=
ev !=3D nil) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [dev retain];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 } els=
e {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 dev =3D MTLCreateSystemDefaultDevice();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [devs=
 release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 retur=
n dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +void apple_gfx_comm=
on_realize(AppleGFXState *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0PGDeviceDescriptor *desc)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 PGDis=
playDescriptor *disp_desc =3D nil;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 QTAIL=
Q_INIT(&amp;s-&gt;tasks);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;render_queue =3D dispatch_queue_create(&quot;apple-<br>
&gt;=C2=A0 =C2=A0 =C2=A0gfx.render&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0DISPATCH_QUEUE_SERIAL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;mtl =3D copy_suitable_metal_device();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;mtl_queue =3D [s-&gt;mtl newCommandQueue];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 desc.=
device =3D s-&gt;mtl;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 apple=
_gfx_register_task_mapping_handlers(s, desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;pgdev =3D PGNewDeviceWithDescriptor(desc);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 disp_=
desc =3D apple_gfx_prepare_display_handlers(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;pgdisp =3D [s-&gt;pgdev newDisplayWithDescriptor:disp_desc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port:=
0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0serialNum:1234];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 [disp=
_desc release];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 s-&gt=
;pgdisp.modeList =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple_gfx_prepare_display_mode_array();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 creat=
e_fb(s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/disp=
lay/meson.build b/hw/display/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 7db05eace97..7=
0d855749c0 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/mes=
on.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/mes=
on.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -65,6 +65,8 @@ sy=
stem_ss.add(when: &#39;CONFIG_ARTIST&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0files(&#39;artist.c&#39;))=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0system_s=
s.add(when: &#39;CONFIG_ATI_VGA&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;ati.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&#39;ati_2d.c&#39;, &#39;a=
ti_dbg.c&#39;), pixman])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when:=
 &#39;CONFIG_MAC_PVG&#39;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;apple-gfx.m&#3=
9;), pvg, metal])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +system_ss.add(when:=
 &#39;CONFIG_MAC_PVG_VMAPPLE&#39;, if_true:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0[files(&#39;apple-gfx-vmap=
ple.m&#39;), pvg, metal])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0if confi=
g_all_devices.has_key(&#39;CONFIG_VIRTIO_GPU&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0v=
irtio_gpu_ss =3D ss.source_set()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/disp=
lay/trace-events b/hw/display/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 781f8a33203..1=
809a358e36 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/display/tra=
ce-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/display/tra=
ce-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -191,3 +191,29 @@=
 dm163_bits_ppi(unsigned dest_width)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;dest_width : %u&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_le=
ds(int led, uint32_t value) &quot;led %d: 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_ch=
annels(int channel, uint8_t value) &quot;channel %d:<br>
&gt;=C2=A0 =C2=A0 =C2=A00x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0dm163_re=
fresh_rate(uint32_t rr) &quot;refresh rate %d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# apple-gfx.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_read(uint=
64_t offset, uint64_t res)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PR=
Ix64&quot; res=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_write(uin=
t64_t offset, uint64_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PR=
Ix64&quot; val=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_create_ta=
sk(uint32_t vm_size, void *va)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;vm_size=3D0x%x<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0base_addr=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_destroy_t=
ask(void *task) &quot;task=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_map_memor=
y(void *task, uint32_t range_count,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtual_offset, uint32_t r=
ead_only) &quot;task=3D%p range_count=3D0x%x<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0virtual_offset=3D0x%&quot;=
PRIx64&quot; read_only=3D%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_map_memor=
y_range(uint32_t i, uint64_t phys_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0uint64_t phys_len) &quot;[=
%d] phys_addr=3D0x%&quot;PRIx64&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0phys_len=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_remap(uin=
t64_t retval, uint64_t source, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0target) &quot;retval=3D%&q=
uot;PRId64&quot; source=3D0x%&quot;PRIx64&quot; target=3D0x%&quot;PRIx64<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_unmap_mem=
ory(void *task, uint64_t virtual_offset,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0uint64_t length) &quot;tas=
k=3D%p virtual_offset=3D0x%&quot;PRIx64&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0length=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_read_memo=
ry(uint64_t phys_address, uint64_t length,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0void *dst) &quot;phys_addr=
=3D0x%&quot;PRIx64&quot; length=3D0x%&quot;PRIx64&quot; dest=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_raise_irq=
(uint32_t vector) &quot;vector=3D0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_new_frame=
(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_mode_chan=
ge(uint64_t x, uint64_t y) &quot;x=3D%&quot;PRId64&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0y=3D%&quot;PRId64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_se=
t(uint32_t bpp, uint64_t width, uint64_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0height) &quot;bpp=3D%d wid=
th=3D%&quot;PRId64&quot; height=3D0x%&quot;PRId64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_sh=
ow(uint32_t show) &quot;show=3D%d&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_cursor_mo=
ve(void) &quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_gfx_common_in=
it(const char *device_name, size_t<br>
&gt;=C2=A0 =C2=A0 =C2=A0mmio_size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;device: %s; MMIO siz=
e: %zu bytes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +# apple-gfx-vmapple=
.m<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_read(ui=
nt64_t offset, uint64_t res)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PR=
Ix64&quot; res=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_write(u=
int64_t offset, uint64_t val)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&quot;offset=3D0x%&quot;PR=
Ix64&quot; val=3D0x%&quot;PRIx64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_map_mem=
ory(uint64_t phys, uint64_t len,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t ro,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0void *va, void *e, void *f=
) &quot;phys=3D0x%&quot;PRIx64&quot; len=3D0x%&quot;PRIx64&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0ro=3D%d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0va=3D%p e=3D%p f=3D%p&quot=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_unmap_m=
emory(void *a, void *b, void *c, void *d,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0void *e, void *f) &quot;a=
=3D%p b=3D%p c=3D%p d=3D%p e=3D%p f=3D%p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +apple_iosfc_raise_i=
rq(uint32_t vector) &quot;vector=3D0x%x&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/meson.b=
uild b/meson.build<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 10464466ff3..f=
09df3f09d5 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/meson.build<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/meson.build<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -741,6 +741,8 @@ =
socket =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0version_=
res =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0coref =
=3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0iokit =
=3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +pvg =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +metal =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0emulator=
_link_args =3D []<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0midl =3D=
 not_found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0widl =3D=
 not_found<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -762,6 +764,8 @@ =
elif host_os =3D=3D &#39;darwin&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0c=
oref =3D dependency(&#39;appleframeworks&#39;, modules:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;CoreFoundation&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0i=
okit =3D dependency(&#39;appleframeworks&#39;, modules: &#39;IOKit&#39;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0required: false)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0h=
ost_dsosuf =3D &#39;.dylib&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 pvg =3D depe=
ndency(&#39;appleframeworks&#39;, modules:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0&#39;ParavirtualizedGraphi=
cs&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 metal =3D de=
pendency(&#39;appleframeworks&#39;, modules: &#39;Metal&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0elif hos=
t_os =3D=3D &#39;sunos&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0s=
ocket =3D [cc.find_library(&#39;socket&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc.find_library(&#39;nsl&#39;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000be834f06240c98cd--

