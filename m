Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF2CE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNe-00088y-FX; Fri, 13 Dec 2024 14:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tMBMn-0006fb-Rb
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:29 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tMBMj-0004E7-WA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:25 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f32168ddd8so634222eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734118219; x=1734723019;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0OaFqmusdqWHpAPi0TSqBaTuFlj0ltahnrQSx2ly5+Q=;
 b=qMMNNhZTzRGPuAOniRQDaORYOmVpB6YKetTcvu5BSr8H/NvcDLXmrY5MRLT20Ud1ZT
 lBObMzhB+8Eo259sECpLsVzbk14I5T90bz7pRbcd53UdWAvRFgfgEFfMI/WUVShFQNM7
 rjpbqE+H+tW83hKWXnCHFrLrVxJEhCylIeNNrihqrEpB3J1S8BUJuOGRK4dmHA9SKXFn
 m/0LT2qh7YDx9NYbekwbcf69CywZ6E6wp0yfWqLmHolfAwl9LtA/Kqlvdl9OVgVHY0mf
 48uUUqc1/7Z5SNkK6McIjLHMGdAS4COsKwmyexKvOSb0KtEyoWbQAI6QcZuMUjo095Be
 cKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118219; x=1734723019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OaFqmusdqWHpAPi0TSqBaTuFlj0ltahnrQSx2ly5+Q=;
 b=cC2b4rG0TcqQM2aeo3DvBnbfZjcUpBIUfB5qIcto/5TNLXOJ4turUprFnoDh2D4wz6
 t7M5qUPj5ZAAf/xHgtyMk8b8Gt7Igz2pxs+du67+dBk50f0Xa4XRyStzeCUZ3XiJOiKk
 x891MMFGdkCE20QZv7DcqGDTDOKeM+DuiQuEuI7DxfIRYUhMyc1/VJ5JQOtFVkLMZ5zy
 7bZaPPEOaOJIRdLUKxZimW25VL1CD5lb3kZ6UbhkGh9OCHdTUvCF3IhN4Pq/DyqEY3IM
 snadTUq5VY4Ieq6iGQFTLKrd0JjOlPZMewoNYI2rX1jiz6I9w2d+AFLmoRsdE38o0EEf
 1sug==
X-Gm-Message-State: AOJu0YyeWAX0BabNY9Eg1lJd3lGeILnqAWPh1TKaUmWBUHVjC7BND92d
 D7VBndQvPvYRNhT8BmCAycwHJY6q1dkupBSBKrI0Yo8cWrz7F9qI9L4ASh/gGkrsNk9xTyPNbHg
 EpxcAHstEzeyS/y8i9qnUQiRadWXTZXaKJWq5
X-Gm-Gg: ASbGncsYN/HecOrSec0Uf2cE5IcjkFkEjwjYtJ2AcQwmxCqQXfHvMj5Pw5uiX/oqM2a
 2BkgZJL6xEkZxMT2UJ/5nOcyae/69HTwK23nugg==
X-Google-Smtp-Source: AGHT+IG/dBSKXlDS4l/qo3aENTHX+k+Cgjb88U1phLJAJl7ZayDVf7AzOSFbEj+zpKIQlkYLbYMTVC94QcbFL9ps2Fc=
X-Received: by 2002:a17:90b:4a01:b0:2ee:b26c:10a0 with SMTP id
 98e67ed59e1d1-2f2900a2bbemr6399040a91.24.1734117780035; Fri, 13 Dec 2024
 11:23:00 -0800 (PST)
MIME-Version: 1.0
References: <20241213151821.65748-1-phil@philjordan.eu>
 <20241213151821.65748-17-phil@philjordan.eu>
In-Reply-To: <20241213151821.65748-17-phil@philjordan.eu>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 13 Dec 2024 20:22:48 +0100
Message-ID: <CAGCz3vs+Df-zAaH-hOWrFvp0r4s8Ran=LLcvT5B9C8rUMX7QkQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/15] macOS PV Graphics and new vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com, 
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 gaosong@loongson.cn, jiaxun.yang@flygoat.com, chenhuacai@kernel.org, 
 kwolf@redhat.com, hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 qemu-riscv@nongnu.org, balaton@eik.bme.hu
Content-Type: multipart/alternative; boundary="000000000000473acc06292bc2a1"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::c35;
 envelope-from=lists@philjordan.eu; helo=mail-oo1-xc35.google.com
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

--000000000000473acc06292bc2a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sigh=E2=80=A6 apologies for re-sending v13 together with v14 here. Please i=
gnore
v13 of course. git send-email is not my friend=E2=80=A6

On Fri, 13 Dec 2024 at 16:24, Phil Dennis-Jordan <phil@philjordan.eu> wrote=
:

> <meta>
> This patch series has been through months of review and
> refinement. It now has end-to-end Reviewed-by: tags and
> all code patches but one have Tested-by: tags. No significant
> issues have been found via review for some weeks.
>
> The patch set creates two new subsystems:
> hw/display/apple-gfx
> hw/vmapple
> so it doesn't fall within the responsibility of existing
> maintainers. How do we proceed to get this merged now that
> 10.0 development is open?
> </meta>
>
>
> This patch set introduces a new ARM and macOS HVF specific machine type
> called "vmapple", as well as a family of display devices based on the
> ParavirtualizedGraphics.framework in macOS. One of the display adapter
> variants, apple-gfx-mmio, is required for the new machine type, while
> apple-gfx-pci can be used to enable 3D graphics acceleration with x86-64
> macOS guest OSes.
>
> Previous versions of this patch set were submitted semi-separately:
> the original vmapple patch set by Alexander Graf included a monolithic
> implementation of apple-gfx-mmio. I subsequently reviewed and reworked
> the latter to support the PCI variant of the device as well and submitted
> the result in isolation. As requested in subsequent review, I have now
> recombined this with the original vmapple patch set, which I have updated
> and improved in a few ways as well.
>
> The vmapple machine type approximates the configuration in macOS's own
> Virtualization.framework when running arm64 macOS guests. In addition to
> generic components such as a GICv3 and an XHCI USB controller, it
> includes nonstandard extensions to the virtio block device, a special
> "hardware" aes engine, a configuration device, a pvpanic variant, a
> "backdoor" interface, and of course the apple-gfx paravirtualised display
> adapter.
>
> There are currently a few limitations to this which aren't intrinsic,
> just imperfect emulation of the VZF, but it's good enough to be just
> about usable for some purposes:
>
>  * macOS 12 guests only. Versions 13+ currently fail during early boot.
>  * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differences
>    between Apple M series CPUs and TCG's aarch64 implementation? macOS
>    hosts only because ParavirtualizedGraphics.framework is a black box
>    implementing most of the logic behind the apple-gfx device.)
>  * PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,
>    we'd need to include the GICv3 ITS, but it's unclear to me what
>    exactly needs wiring up.
>  * Due to a quirk (bug?) in the macOS XHCI driver when MSI-X is not
>    available, correct functioning of the USB controller (and thus
>    keyboard/tablet) requires a small workaround in the XHCI controller
>    device. This is part of another patch series:
>    https://patchew.org/QEMU/20241208191646.64857-1-phil@philjordan.eu/
>  * The guest OS must first be provisioned using Virtualization.framework;
>    the disk images can subsequently be used in Qemu. (See docs.)
>
> The apple-gfx device can be used independently from the vmapple machine
> type, at least in the PCI variant. It mainly targets x86-64 macOS guests
> from version 11 on, but also includes a UEFI bootrom for basic
> framebuffer mode. macOS 11 is also required on the host side, as well
> as a GPU that supports the Metal API. On the guest side, this provides
> 3D acceleration/GPGPU support with a baseline Metal feature set,
> irrespective of the host GPU's feature set. A few limitations in the
> current integration:
>
>  * Although it works fine with TCG, it does not work correctly
>    cross-architecture: x86-64 guests on arm64 hosts appear to make
>    some boot progress, but rendering is corrupted. I suspect
>    incompatible texture memory layouts; I have no idea if this is
>    fixable.
>  * ParavirtualizedGraphics.framework and the guest driver support
>    multi-headed configurations. The current Qemu integration always
>    connects precisely 1 display.
>  * State serialisation and deserialisation is currently not
>    implemented, though supported in principle by the framework.
>    Both apple-gfx variants thus set up a migration blocker.
>  * Rendering efficiency could be better. The GPU-rendered guest
>    framebuffer is copied to system memory and uses Qemu's usual
>    CPU-based drawing. For maximum efficiency, the Metal texture
>    containing the guest framebuffer could be drawn directly to
>    a Metal view in the host window, staying on the GPU. (Similar
>    to the OpenGL/virgl render path on other platforms.)
>
> Some of my part of this work has been sponsored by Sauce Labs Inc.
>
> ---
>
> v2 -> v3:
>
>  * Merged the apple-gfx and vmapple patchsets.
>  * Squashed a bunch of later apple-gfx patches into the main one.
>    (dGPU support, queried MMIO area size, host GPU picking logic.)
>  * Rebased on latest upstream, fixing any breakages due to internal
>    Qemu API changes.
>  * apple-gfx: Switched to re-entrant MMIO. This is supported by the
>    underlying framework and simplifies the MMIO forwarding code which
>    was previously different on x86-64 vs aarch64.
>  * vmapple: Fixes for minor bugs and comments from the last round of
>    review.
>  * vmapple aes, conf, apple-gfx: Switched reset methods to implement
>    the ResettableClass base's interface.
>  * vmapple: switched from virtio-hid to an XHCI USB controller and
>    USB mouse and tablet devices. macOS does not provide drivers for
>    virtio HID devices, at least not in version 12's vmapple kernel.
>    So input now sort of works (interrupt issues) rather than not
>    at all. Use network-based remote access to the guest OS as a
>    work-around.
>
> v3 -> v4:
>
>  * Complete rework of the mechanism for handling runloop/libdispatch
>    events on the main thread. PV graphics now work with the SDL UI.
>  * Renamed 'apple-gfx-vmapple' device to 'apple-gfx-mmio'
>  * hw/display/apple-gfx: threading model overhaul to be more consistent,
>    safer, and more QEMU-idiomatic.
>  * display-modes property on the apple-gfx devices now uses the
>    native array property mechanism and works on both device variants.
>  * hw/vmapple/aes: Improvements to logging and error handling.
>  * hw/vmapple/cfg: Bug fixes around device property default values.
>  * hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header code moved into
>    .c files, only a single vmapple.h now contains the #defines for the
>    vmapple machine model-specific device type names.
>  * hw/block/virtio-blk: New patch for replacing virtio_blk_free_request
>    with g_free. (Optional)
>  * Various smaller changes following comments in v3 code review in
>    apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and the vmapple
>    machine type itself. See patch-specific v4 change notes for details.
>
> v4 -> v5:
>
>  * Simplified the main thread runloop mechanism. Back to setting
>          qemu_main directly, but narrowing the scope of what it needs to
> do,
>          and it can now be NULL. (Meaning run the QEMU main event loop on
>          the main thread as is traditional.)
>  * hw/display/apple-gfx: Further improvements to the BH based job code
> bridging
>    the libdispatch & QEMU thread synchronisation impedance mismatch.
>  * hw/display/apple-gfx: Thread safety and object lifetime improvements.
>  * hw/display/apple-gfx-*: Better buffer and error handling in display mo=
de
>    property setters and getters.
>  * hw/vmapple/aes: More consistent and safer logging/tracing
>  * hw/vmapple/cfg: Better error reporting on overlong property strings.
>  * hw/vmapple/virtio-blk: Fixed theoretically-unaligned write to config
> buffer.
>  * vmapple machine type: Moved ecam region into machine state, improved
> device
>    property setting error handling, improved ECID/UUID extraction script
> and
>    docs.
>  * Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci, vmapple/aes,
>    vmapple/cfg, vmapple/virtio-blk, and vmapple machine type.
>  * Added SPDX license identifiers where they were missing.
>
> v5 -> v6:
>
>  * 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespace
>  * 02/15 (apple-gfx): Further refinement of PVG threading: reduced some
> callback
>    tasks from BHs to merely acquiring RCU read lock; replaced some
> libdispatch
>    tasks with BHs; last remaining synchronous BH now uses emphemeral
>    QemuSemaphore.
>  * 02/15 (apple-gfx): Readability improvements and other smaller tweaks
>    (see patch change notes for details)
>  * 04/15 (display modes): Replaced use of alloca() with NSMutableArray.
>
> v6 -> v7:
>
>  * 02/15 (apple-gfx): Use g_ptr_array_find() helper function, coding styl=
e
> tweak
>  * 03/15 (apple-gfx-pci): Removed an unused function parameter
>  * 04/15 (apple-gfx display mode property): Simplified error handling in
>    property parsing.
>  * 10/15 (vmapple/aes): Coding style tweaks.
>  * 12/15 (vmapple/cfg): Changed error messages for overrun of properties
> with
>    fixed-length strings to be more useful to users than developers.
>  * 15/15 (vmapple machine type): Tiny error handling fix, un-inlined
> function
>
> v7 -> v8:
>
>  * 02/15 (apple-gfx): Naming and type use improvements, fixes for a bug
> and a
>    leak.
>  * 04/15 (apple-gfx display mode property): Type use improvement
>  * 10/15 (vmapple/aes): Guest error logging tweaks.
>  * 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memory_read with
>    dma_memory_read, and a g_free call with g_autofree.
>  * 12/15 (vmapple/cfg): Macro hygiene fix: consistently enclosing
> arguments in
>    parens.
>  * 15/15 (vmapple machine type): Use less verbose pattern for defining uu=
id
>    property.
>
> v8 -> v9:
>
>  * 01/16 (ui & main loop): Set qemu_main to NULL for GTK UI as well.
>  * 02/16 (apple-gfx): Pass device pointer to graphic_console_init(),
> various
>          non-functional changes.
>  * 03/16 (apple-gfx-pci): Fixup of changed common call, whitespace and
> comment
>    formatting tweaks.
>  * 04/16 (apple-gfx display modes): Re-ordered type definitions so we can
> drop
>    a 'struct' keyword.
>  * 10/16 (vmapple/aes): Replaced a use of cpu_physical_memory_write with
>    dma_memory_write, minor style tweak.
>  * 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memory_write with
>    dma_memory_write.
>  * 13/16 (vmapple/virtio-blk): Correctly specify class_size for
>    VMAppleVirtIOBlkClass.
>  * 15/16 (vmapple machine type): Documentation improvements, fixed variab=
le
>    name and struct field used during pvpanic device creation.
>  * 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to replace type
> hierarchy
>    with a variant property. This seems cleaner and less confusing than th=
e
>    original approach to me, but I'm not sure if it warrants creation of a
> new
>    QAPI enum and property type definition.
>
> v9 -> v10:
>
>  * 01/15 (ui & main loop): Added comments to qemu_main declaration and GT=
K.
>  * 02/15 (apple-gfx): Reworked the way frame rendering code is threaded t=
o
> use
>    BHs for sections requiring BQL.
>  * 02/15 (apple-gfx): Fixed ./configure error on non-macOS platforms.
>  * 10/15 (vmapple/aes): Code style and comment improvements.
>  * 12/15 (vmapple/cfg): Slightly tidier error reporting for overlong
> property
>    values.
>  * 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into this one,
> changing
>    the device type design to provide a single device type with a variant
>          property instead of 2 different subtypes for aux and root volume=
s.
>  * 15/15 (vmapple machine type): Documentation fixup for changed virtio-b=
lk
>    device type; small improvements to shell commands in documentation;
>    improved propagation of errors during cfg device instantiation.
>
> v10 -> v11:
>
>  * 01/15 (ui & main loop): Simplified main.c, better comments & commit
> message
>  * 02/15 (apple-gfx): Give each PV display instance a unique serial numbe=
r.
>  * 02 & 03/15 (apple-gfx, -pci): Formatting/style tweaks
>  * 15/15 (vmapple machine type): Improvements to shell code in docs
>
> v11 -> v12:
>
>  * 01/15 (ui & main loop): More precise wording of code comments.
>  * 02/15 (apple-gfx): Fixed memory management regressions introduced in
> v10;
>    improved error handling; various more conmetic code adjustments
>  * 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS constant that have
> been
>    added to QEMU since this patch was originally written.
>
> v12 -> v13:
>
>  * 15/15 (vmapple machine type): Bumped the machine type version from 9.2
>    to 10.0.
>  * All patches in the series now have been positively reviewed and receiv=
ed
>    corresponding reviewed-by tags.
>
> v13 -> v14:
>
>  * 6/15 (hw/vmapple directory): Changed myself from reviewer
>    to maintainer, as that seemed appropriate at this point.
>  * 15/15 (vmapple machine type): Gate creation of XHCI and
>    USB HID devices behind if (defaults_enabled()).
>
> Alexander Graf (9):
>   hw: Add vmapple subdir
>   hw/misc/pvpanic: Add MMIO interface
>   hvf: arm: Ignore writes to CNTP_CTL_EL0
>   gpex: Allow more than 4 legacy IRQs
>   hw/vmapple/aes: Introduce aes engine
>   hw/vmapple/bdif: Introduce vmapple backdoor interface
>   hw/vmapple/cfg: Introduce vmapple cfg region
>   hw/vmapple/virtio-blk: Add support for apple virtio-blk
>   hw/vmapple/vmapple: Add vmapple machine type
>
> Phil Dennis-Jordan (6):
>   ui & main loop: Redesign of system-specific main thread event handling
>   hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
>     support
>   hw/display/apple-gfx: Adds PCI implementation
>   hw/display/apple-gfx: Adds configurable mode list
>   MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HVF
>   hw/block/virtio-blk: Replaces request free function with g_free
>
>  MAINTAINERS                         |  15 +
>  contrib/vmapple/uuid.sh             |   9 +
>  docs/system/arm/vmapple.rst         |  63 ++
>  docs/system/target-arm.rst          |   1 +
>  hw/Kconfig                          |   1 +
>  hw/arm/sbsa-ref.c                   |   2 +-
>  hw/arm/virt.c                       |   2 +-
>  hw/block/virtio-blk.c               |  58 +-
>  hw/core/qdev-properties-system.c    |   8 +
>  hw/display/Kconfig                  |  13 +
>  hw/display/apple-gfx-mmio.m         | 289 +++++++++
>  hw/display/apple-gfx-pci.m          | 157 +++++
>  hw/display/apple-gfx.h              |  77 +++
>  hw/display/apple-gfx.m              | 880 ++++++++++++++++++++++++++++
>  hw/display/meson.build              |   7 +
>  hw/display/trace-events             |  30 +
>  hw/i386/microvm.c                   |   2 +-
>  hw/loongarch/virt.c                 |  12 +-
>  hw/meson.build                      |   1 +
>  hw/mips/loongson3_virt.c            |   2 +-
>  hw/misc/Kconfig                     |   4 +
>  hw/misc/meson.build                 |   1 +
>  hw/misc/pvpanic-mmio.c              |  61 ++
>  hw/openrisc/virt.c                  |  12 +-
>  hw/pci-host/gpex.c                  |  43 +-
>  hw/riscv/virt.c                     |  12 +-
>  hw/vmapple/Kconfig                  |  32 +
>  hw/vmapple/aes.c                    | 581 ++++++++++++++++++
>  hw/vmapple/bdif.c                   | 275 +++++++++
>  hw/vmapple/cfg.c                    | 196 +++++++
>  hw/vmapple/meson.build              |   5 +
>  hw/vmapple/trace-events             |  21 +
>  hw/vmapple/trace.h                  |   1 +
>  hw/vmapple/virtio-blk.c             | 205 +++++++
>  hw/vmapple/vmapple.c                | 648 ++++++++++++++++++++
>  hw/xen/xen-pvh-common.c             |   2 +-
>  hw/xtensa/virt.c                    |   2 +-
>  include/hw/misc/pvpanic.h           |   1 +
>  include/hw/pci-host/gpex.h          |   7 +-
>  include/hw/pci/pci_ids.h            |   1 +
>  include/hw/qdev-properties-system.h |   5 +
>  include/hw/virtio/virtio-blk.h      |  11 +-
>  include/hw/vmapple/vmapple.h        |  23 +
>  include/qemu-main.h                 |  14 +-
>  include/qemu/cutils.h               |  15 +
>  meson.build                         |   5 +
>  qapi/virtio.json                    |  14 +
>  system/main.c                       |  37 +-
>  target/arm/hvf/hvf.c                |   9 +
>  ui/cocoa.m                          |  54 +-
>  ui/gtk.c                            |   4 +
>  ui/sdl2.c                           |   4 +
>  util/hexdump.c                      |  18 +
>  53 files changed, 3842 insertions(+), 110 deletions(-)
>  create mode 100755 contrib/vmapple/uuid.sh
>  create mode 100644 docs/system/arm/vmapple.rst
>  create mode 100644 hw/display/apple-gfx-mmio.m
>  create mode 100644 hw/display/apple-gfx-pci.m
>  create mode 100644 hw/display/apple-gfx.h
>  create mode 100644 hw/display/apple-gfx.m
>  create mode 100644 hw/misc/pvpanic-mmio.c
>  create mode 100644 hw/vmapple/Kconfig
>  create mode 100644 hw/vmapple/aes.c
>  create mode 100644 hw/vmapple/bdif.c
>  create mode 100644 hw/vmapple/cfg.c
>  create mode 100644 hw/vmapple/meson.build
>  create mode 100644 hw/vmapple/trace-events
>  create mode 100644 hw/vmapple/trace.h
>  create mode 100644 hw/vmapple/virtio-blk.c
>  create mode 100644 hw/vmapple/vmapple.c
>  create mode 100644 include/hw/vmapple/vmapple.h
>
> --
> 2.39.5 (Apple Git-154)
>
>
>

--000000000000473acc06292bc2a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sigh=E2=80=A6 apologies for re-sending v13 together with v=
14 here. Please ignore v13 of course. git send-email is not my friend=E2=80=
=A6<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, 13 Dec 2024 at 16:24, Phil Dennis-Jor=
dan &lt;<a href=3D"mailto:phil@philjordan.eu">phil@philjordan.eu</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&lt;meta&gt=
;<br>
This patch series has been through months of review and<br>
refinement. It now has end-to-end Reviewed-by: tags and<br>
all code patches but one have Tested-by: tags. No significant<br>
issues have been found via review for some weeks.<br>
<br>
The patch set creates two new subsystems:<br>
hw/display/apple-gfx<br>
hw/vmapple<br>
so it doesn&#39;t fall within the responsibility of existing<br>
maintainers. How do we proceed to get this merged now that<br>
10.0 development is open?<br>
&lt;/meta&gt;<br>
<br>
<br>
This patch set introduces a new ARM and macOS HVF specific machine type<br>
called &quot;vmapple&quot;, as well as a family of display devices based on=
 the<br>
ParavirtualizedGraphics.framework in macOS. One of the display adapter<br>
variants, apple-gfx-mmio, is required for the new machine type, while<br>
apple-gfx-pci can be used to enable 3D graphics acceleration with x86-64<br=
>
macOS guest OSes.<br>
<br>
Previous versions of this patch set were submitted semi-separately:<br>
the original vmapple patch set by Alexander Graf included a monolithic<br>
implementation of apple-gfx-mmio. I subsequently reviewed and reworked<br>
the latter to support the PCI variant of the device as well and submitted<b=
r>
the result in isolation. As requested in subsequent review, I have now<br>
recombined this with the original vmapple patch set, which I have updated<b=
r>
and improved in a few ways as well.<br>
<br>
The vmapple machine type approximates the configuration in macOS&#39;s own<=
br>
Virtualization.framework when running arm64 macOS guests. In addition to<br=
>
generic components such as a GICv3 and an XHCI USB controller, it<br>
includes nonstandard extensions to the virtio block device, a special<br>
&quot;hardware&quot; aes engine, a configuration device, a pvpanic variant,=
 a<br>
&quot;backdoor&quot; interface, and of course the apple-gfx paravirtualised=
 display<br>
adapter.<br>
<br>
There are currently a few limitations to this which aren&#39;t intrinsic,<b=
r>
just imperfect emulation of the VZF, but it&#39;s good enough to be just<br=
>
about usable for some purposes:<br>
<br>
=C2=A0* macOS 12 guests only. Versions 13+ currently fail during early boot=
.<br>
=C2=A0* macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differenc=
es<br>
=C2=A0 =C2=A0between Apple M series CPUs and TCG&#39;s aarch64 implementati=
on? macOS<br>
=C2=A0 =C2=A0hosts only because ParavirtualizedGraphics.framework is a blac=
k box<br>
=C2=A0 =C2=A0implementing most of the logic behind the apple-gfx device.)<b=
r>
=C2=A0* PCI devices use legacy IRQs, not MSI/MSI-X. As far as I can tell,<b=
r>
=C2=A0 =C2=A0we&#39;d need to include the GICv3 ITS, but it&#39;s unclear t=
o me what<br>
=C2=A0 =C2=A0exactly needs wiring up.<br>
=C2=A0* Due to a quirk (bug?) in the macOS XHCI driver when MSI-X is not<br=
>
=C2=A0 =C2=A0available, correct functioning of the USB controller (and thus=
<br>
=C2=A0 =C2=A0keyboard/tablet) requires a small workaround in the XHCI contr=
oller<br>
=C2=A0 =C2=A0device. This is part of another patch series:<br>
=C2=A0 =C2=A0<a href=3D"https://patchew.org/QEMU/20241208191646.64857-1-phi=
l@philjordan.eu/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/=
QEMU/20241208191646.64857-1-phil@philjordan.eu/</a><br>
=C2=A0* The guest OS must first be provisioned using Virtualization.framewo=
rk;<br>
=C2=A0 =C2=A0the disk images can subsequently be used in Qemu. (See docs.)<=
br>
<br>
The apple-gfx device can be used independently from the vmapple machine<br>
type, at least in the PCI variant. It mainly targets x86-64 macOS guests<br=
>
from version 11 on, but also includes a UEFI bootrom for basic<br>
framebuffer mode. macOS 11 is also required on the host side, as well<br>
as a GPU that supports the Metal API. On the guest side, this provides<br>
3D acceleration/GPGPU support with a baseline Metal feature set,<br>
irrespective of the host GPU&#39;s feature set. A few limitations in the<br=
>
current integration:<br>
<br>
=C2=A0* Although it works fine with TCG, it does not work correctly<br>
=C2=A0 =C2=A0cross-architecture: x86-64 guests on arm64 hosts appear to mak=
e<br>
=C2=A0 =C2=A0some boot progress, but rendering is corrupted. I suspect<br>
=C2=A0 =C2=A0incompatible texture memory layouts; I have no idea if this is=
<br>
=C2=A0 =C2=A0fixable.<br>
=C2=A0* ParavirtualizedGraphics.framework and the guest driver support<br>
=C2=A0 =C2=A0multi-headed configurations. The current Qemu integration alwa=
ys<br>
=C2=A0 =C2=A0connects precisely 1 display.<br>
=C2=A0* State serialisation and deserialisation is currently not<br>
=C2=A0 =C2=A0implemented, though supported in principle by the framework.<b=
r>
=C2=A0 =C2=A0Both apple-gfx variants thus set up a migration blocker.<br>
=C2=A0* Rendering efficiency could be better. The GPU-rendered guest<br>
=C2=A0 =C2=A0framebuffer is copied to system memory and uses Qemu&#39;s usu=
al<br>
=C2=A0 =C2=A0CPU-based drawing. For maximum efficiency, the Metal texture<b=
r>
=C2=A0 =C2=A0containing the guest framebuffer could be drawn directly to<br=
>
=C2=A0 =C2=A0a Metal view in the host window, staying on the GPU. (Similar<=
br>
=C2=A0 =C2=A0to the OpenGL/virgl render path on other platforms.)<br>
<br>
Some of my part of this work has been sponsored by Sauce Labs Inc.<br>
<br>
---<br>
<br>
v2 -&gt; v3:<br>
<br>
=C2=A0* Merged the apple-gfx and vmapple patchsets.<br>
=C2=A0* Squashed a bunch of later apple-gfx patches into the main one.<br>
=C2=A0 =C2=A0(dGPU support, queried MMIO area size, host GPU picking logic.=
)<br>
=C2=A0* Rebased on latest upstream, fixing any breakages due to internal<br=
>
=C2=A0 =C2=A0Qemu API changes.<br>
=C2=A0* apple-gfx: Switched to re-entrant MMIO. This is supported by the<br=
>
=C2=A0 =C2=A0underlying framework and simplifies the MMIO forwarding code w=
hich<br>
=C2=A0 =C2=A0was previously different on x86-64 vs aarch64.<br>
=C2=A0* vmapple: Fixes for minor bugs and comments from the last round of<b=
r>
=C2=A0 =C2=A0review.<br>
=C2=A0* vmapple aes, conf, apple-gfx: Switched reset methods to implement<b=
r>
=C2=A0 =C2=A0the ResettableClass base&#39;s interface.<br>
=C2=A0* vmapple: switched from virtio-hid to an XHCI USB controller and<br>
=C2=A0 =C2=A0USB mouse and tablet devices. macOS does not provide drivers f=
or<br>
=C2=A0 =C2=A0virtio HID devices, at least not in version 12&#39;s vmapple k=
ernel.<br>
=C2=A0 =C2=A0So input now sort of works (interrupt issues) rather than not<=
br>
=C2=A0 =C2=A0at all. Use network-based remote access to the guest OS as a<b=
r>
=C2=A0 =C2=A0work-around.<br>
<br>
v3 -&gt; v4:<br>
<br>
=C2=A0* Complete rework of the mechanism for handling runloop/libdispatch<b=
r>
=C2=A0 =C2=A0events on the main thread. PV graphics now work with the SDL U=
I.<br>
=C2=A0* Renamed &#39;apple-gfx-vmapple&#39; device to &#39;apple-gfx-mmio&#=
39;<br>
=C2=A0* hw/display/apple-gfx: threading model overhaul to be more consisten=
t,<br>
=C2=A0 =C2=A0safer, and more QEMU-idiomatic.<br>
=C2=A0* display-modes property on the apple-gfx devices now uses the<br>
=C2=A0 =C2=A0native array property mechanism and works on both device varia=
nts.<br>
=C2=A0* hw/vmapple/aes: Improvements to logging and error handling.<br>
=C2=A0* hw/vmapple/cfg: Bug fixes around device property default values.<br=
>
=C2=A0* hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header code moved int=
o<br>
=C2=A0 =C2=A0.c files, only a single vmapple.h now contains the #defines fo=
r the<br>
=C2=A0 =C2=A0vmapple machine model-specific device type names.<br>
=C2=A0* hw/block/virtio-blk: New patch for replacing virtio_blk_free_reques=
t<br>
=C2=A0 =C2=A0with g_free. (Optional)<br>
=C2=A0* Various smaller changes following comments in v3 code review in<br>
=C2=A0 =C2=A0apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and the vmapple=
<br>
=C2=A0 =C2=A0machine type itself. See patch-specific v4 change notes for de=
tails.<br>
<br>
v4 -&gt; v5:<br>
<br>
=C2=A0* Simplified the main thread runloop mechanism. Back to setting<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_main directly, but narrowing the sco=
pe of what it needs to do,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and it can now be NULL. (Meaning run the =
QEMU main event loop on<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the main thread as is traditional.)<br>
=C2=A0* hw/display/apple-gfx: Further improvements to the BH based job code=
 bridging<br>
=C2=A0 =C2=A0the libdispatch &amp; QEMU thread synchronisation impedance mi=
smatch.<br>
=C2=A0* hw/display/apple-gfx: Thread safety and object lifetime improvement=
s.<br>
=C2=A0* hw/display/apple-gfx-*: Better buffer and error handling in display=
 mode<br>
=C2=A0 =C2=A0property setters and getters.<br>
=C2=A0* hw/vmapple/aes: More consistent and safer logging/tracing<br>
=C2=A0* hw/vmapple/cfg: Better error reporting on overlong property strings=
.<br>
=C2=A0* hw/vmapple/virtio-blk: Fixed theoretically-unaligned write to confi=
g buffer.<br>
=C2=A0* vmapple machine type: Moved ecam region into machine state, improve=
d device<br>
=C2=A0 =C2=A0property setting error handling, improved ECID/UUID extraction=
 script and<br>
=C2=A0 =C2=A0docs.<br>
=C2=A0* Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci, vmapple/ae=
s,<br>
=C2=A0 =C2=A0vmapple/cfg, vmapple/virtio-blk, and vmapple machine type.<br>
=C2=A0* Added SPDX license identifiers where they were missing.<br>
<br>
v5 -&gt; v6:<br>
<br>
=C2=A0* 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespace<br=
>
=C2=A0* 02/15 (apple-gfx): Further refinement of PVG threading: reduced som=
e callback<br>
=C2=A0 =C2=A0tasks from BHs to merely acquiring RCU read lock; replaced som=
e libdispatch<br>
=C2=A0 =C2=A0tasks with BHs; last remaining synchronous BH now uses empheme=
ral<br>
=C2=A0 =C2=A0QemuSemaphore.<br>
=C2=A0* 02/15 (apple-gfx): Readability improvements and other smaller tweak=
s<br>
=C2=A0 =C2=A0(see patch change notes for details)<br>
=C2=A0* 04/15 (display modes): Replaced use of alloca()=C2=A0with NSMutable=
Array.<br>
<br>
v6 -&gt; v7:<br>
<br>
=C2=A0* 02/15 (apple-gfx): Use g_ptr_array_find() helper function, coding s=
tyle tweak<br>
=C2=A0* 03/15 (apple-gfx-pci): Removed an unused function parameter<br>
=C2=A0* 04/15 (apple-gfx display mode property): Simplified error handling =
in<br>
=C2=A0 =C2=A0property parsing.<br>
=C2=A0* 10/15 (vmapple/aes): Coding style tweaks.<br>
=C2=A0* 12/15 (vmapple/cfg): Changed error messages for overrun of properti=
es with<br>
=C2=A0 =C2=A0fixed-length strings to be more useful to users than developer=
s.<br>
=C2=A0* 15/15 (vmapple machine type): Tiny error handling fix, un-inlined f=
unction<br>
<br>
v7 -&gt; v8:<br>
<br>
=C2=A0* 02/15 (apple-gfx): Naming and type use improvements, fixes for a bu=
g and a<br>
=C2=A0 =C2=A0leak.<br>
=C2=A0* 04/15 (apple-gfx display mode property): Type use improvement<br>
=C2=A0* 10/15 (vmapple/aes): Guest error logging tweaks.<br>
=C2=A0* 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memory_read wit=
h<br>
=C2=A0 =C2=A0dma_memory_read, and a g_free call with g_autofree.<br>
=C2=A0* 12/15 (vmapple/cfg): Macro hygiene fix: consistently enclosing argu=
ments in<br>
=C2=A0 =C2=A0parens.<br>
=C2=A0* 15/15 (vmapple machine type): Use less verbose pattern for defining=
 uuid<br>
=C2=A0 =C2=A0property.<br>
<br>
v8 -&gt; v9:<br>
<br>
=C2=A0* 01/16 (ui &amp; main loop): Set qemu_main to NULL for GTK UI as wel=
l.<br>
=C2=A0* 02/16 (apple-gfx): Pass device pointer to graphic_console_init(), v=
arious<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0non-functional changes.<br>
=C2=A0* 03/16 (apple-gfx-pci): Fixup of changed common call, whitespace and=
 comment<br>
=C2=A0 =C2=A0formatting tweaks.<br>
=C2=A0* 04/16 (apple-gfx display modes): Re-ordered type definitions so we =
can drop<br>
=C2=A0 =C2=A0a &#39;struct&#39; keyword.<br>
=C2=A0* 10/16 (vmapple/aes): Replaced a use of cpu_physical_memory_write wi=
th<br>
=C2=A0 =C2=A0dma_memory_write, minor style tweak.<br>
=C2=A0* 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memory_write wi=
th<br>
=C2=A0 =C2=A0dma_memory_write.<br>
=C2=A0* 13/16 (vmapple/virtio-blk): Correctly specify class_size for<br>
=C2=A0 =C2=A0VMAppleVirtIOBlkClass.<br>
=C2=A0* 15/16 (vmapple machine type): Documentation improvements, fixed var=
iable<br>
=C2=A0 =C2=A0name and struct field used during pvpanic device creation.<br>
=C2=A0* 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to replace type=
 hierarchy<br>
=C2=A0 =C2=A0with a variant property. This seems cleaner and less confusing=
 than the<br>
=C2=A0 =C2=A0original approach to me, but I&#39;m not sure if it warrants c=
reation of a new<br>
=C2=A0 =C2=A0QAPI enum and property type definition.<br>
<br>
v9 -&gt; v10:<br>
<br>
=C2=A0* 01/15 (ui &amp; main loop): Added comments to qemu_main declaration=
 and GTK.<br>
=C2=A0* 02/15 (apple-gfx): Reworked the way frame rendering code is threade=
d to use<br>
=C2=A0 =C2=A0BHs for sections requiring BQL.<br>
=C2=A0* 02/15 (apple-gfx): Fixed ./configure error on non-macOS platforms.<=
br>
=C2=A0* 10/15 (vmapple/aes): Code style and comment improvements.<br>
=C2=A0* 12/15 (vmapple/cfg): Slightly tidier error reporting for overlong p=
roperty<br>
=C2=A0 =C2=A0values.<br>
=C2=A0* 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into this one, ch=
anging<br>
=C2=A0 =C2=A0the device type design to provide a single device type with a =
variant<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0property instead of 2 different subtypes =
for aux and root volumes.<br>
=C2=A0* 15/15 (vmapple machine type): Documentation fixup for changed virti=
o-blk<br>
=C2=A0 =C2=A0device type; small improvements to shell commands in documenta=
tion;<br>
=C2=A0 =C2=A0improved propagation of errors during cfg device instantiation=
.<br>
<br>
v10 -&gt; v11:<br>
<br>
=C2=A0* 01/15 (ui &amp; main loop): Simplified main.c, better comments &amp=
; commit message<br>
=C2=A0* 02/15 (apple-gfx): Give each PV display instance a unique serial nu=
mber.<br>
=C2=A0* 02 &amp; 03/15 (apple-gfx, -pci): Formatting/style tweaks<br>
=C2=A0* 15/15 (vmapple machine type): Improvements to shell code in docs<br=
>
<br>
v11 -&gt; v12:<br>
<br>
=C2=A0* 01/15 (ui &amp; main loop): More precise wording of code comments.<=
br>
=C2=A0* 02/15 (apple-gfx): Fixed memory management regressions introduced i=
n v10;<br>
=C2=A0 =C2=A0improved error handling; various more conmetic code adjustment=
s<br>
=C2=A0* 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS constant that hav=
e been<br>
=C2=A0 =C2=A0added to QEMU since this patch was originally written.<br>
<br>
v12 -&gt; v13:<br>
<br>
=C2=A0* 15/15 (vmapple machine type): Bumped the machine type version from =
9.2<br>
=C2=A0 =C2=A0to 10.0.<br>
=C2=A0* All patches in the series now have been positively reviewed and rec=
eived<br>
=C2=A0 =C2=A0corresponding reviewed-by tags.<br>
<br>
v13 -&gt; v14:<br>
<br>
=C2=A0* 6/15 (hw/vmapple directory): Changed myself from reviewer<br>
=C2=A0 =C2=A0to maintainer, as that seemed appropriate at this point.<br>
=C2=A0* 15/15 (vmapple machine type): Gate creation of XHCI and<br>
=C2=A0 =C2=A0USB HID devices behind if (defaults_enabled()).<br>
<br>
Alexander Graf (9):<br>
=C2=A0 hw: Add vmapple subdir<br>
=C2=A0 hw/misc/pvpanic: Add MMIO interface<br>
=C2=A0 hvf: arm: Ignore writes to CNTP_CTL_EL0<br>
=C2=A0 gpex: Allow more than 4 legacy IRQs<br>
=C2=A0 hw/vmapple/aes: Introduce aes engine<br>
=C2=A0 hw/vmapple/bdif: Introduce vmapple backdoor interface<br>
=C2=A0 hw/vmapple/cfg: Introduce vmapple cfg region<br>
=C2=A0 hw/vmapple/virtio-blk: Add support for apple virtio-blk<br>
=C2=A0 hw/vmapple/vmapple: Add vmapple machine type<br>
<br>
Phil Dennis-Jordan (6):<br>
=C2=A0 ui &amp; main loop: Redesign of system-specific main thread event ha=
ndling<br>
=C2=A0 hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework<br=
>
=C2=A0 =C2=A0 support<br>
=C2=A0 hw/display/apple-gfx: Adds PCI implementation<br>
=C2=A0 hw/display/apple-gfx: Adds configurable mode list<br>
=C2=A0 MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer for HV=
F<br>
=C2=A0 hw/block/virtio-blk: Replaces request free function with g_free<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +<br>
=C2=A0contrib/vmapple/uuid.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A09 +<br>
=C2=A0docs/system/arm/vmapple.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
63 ++<br>
=C2=A0docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
=C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/arm/sbsa-ref.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 58 +-<br>
=C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<br>
=C2=A0hw/display/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 13 +<br>
=C2=A0hw/display/apple-gfx-mmio.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 289 ++=
+++++++<br>
=C2=A0hw/display/apple-gfx-pci.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 157 ++=
+++<br>
=C2=A0hw/display/apple-gfx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 77 +++<br>
=C2=A0hw/display/apple-gfx.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 880 ++++++++++++++++++++++++++++<br>
=C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A07 +<br>
=C2=A0hw/display/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 30 +<br>
=C2=A0hw/i386/microvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/loongarch/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 12 +-<br>
=C2=A0hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/mips/loongson3_virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A02 +-<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0hw/misc/pvpanic-mmio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 61 ++<br>
=C2=A0hw/openrisc/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 12 +-<br>
=C2=A0hw/pci-host/gpex.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 43 +-<br>
=C2=A0hw/riscv/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +-<br>
=C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 32 +<br>
=C2=A0hw/vmapple/aes.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 581 ++++++++++++++++++<br>
=C2=A0hw/vmapple/bdif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 275 +++++++++<br>
=C2=A0hw/vmapple/cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 196 +++++++<br>
=C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A05 +<br>
=C2=A0hw/vmapple/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 21 +<br>
=C2=A0hw/vmapple/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/vmapple/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 205 +++++++<br>
=C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 648 ++++++++++++++++++++<br>
=C2=A0hw/xen/xen-pvh-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0hw/xtensa/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0include/hw/misc/pvpanic.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/pci-host/gpex.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A07 +-<br>
=C2=A0include/hw/pci/pci_ids.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/qdev-properties-system.h |=C2=A0 =C2=A05 +<br>
=C2=A0include/hw/virtio/virtio-blk.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A0include/hw/vmapple/vmapple.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 +<=
br>
=C2=A0include/qemu-main.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 14 +-<br>
=C2=A0include/qemu/cutils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 15 +<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
=C2=A0qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
=C2=A0system/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 37 +-<br>
=C2=A0target/arm/hvf/hvf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0ui/cocoa.m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 54 +-<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
=C2=A0ui/sdl2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
=C2=A0util/hexdump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
=C2=A053 files changed, 3842 insertions(+), 110 deletions(-)<br>
=C2=A0create mode 100755 contrib/vmapple/uuid.sh<br>
=C2=A0create mode 100644 docs/system/arm/vmapple.rst<br>
=C2=A0create mode 100644 hw/display/apple-gfx-mmio.m<br>
=C2=A0create mode 100644 hw/display/apple-gfx-pci.m<br>
=C2=A0create mode 100644 hw/display/apple-gfx.h<br>
=C2=A0create mode 100644 hw/display/apple-gfx.m<br>
=C2=A0create mode 100644 hw/misc/pvpanic-mmio.c<br>
=C2=A0create mode 100644 hw/vmapple/Kconfig<br>
=C2=A0create mode 100644 hw/vmapple/aes.c<br>
=C2=A0create mode 100644 hw/vmapple/bdif.c<br>
=C2=A0create mode 100644 hw/vmapple/cfg.c<br>
=C2=A0create mode 100644 hw/vmapple/meson.build<br>
=C2=A0create mode 100644 hw/vmapple/trace-events<br>
=C2=A0create mode 100644 hw/vmapple/trace.h<br>
=C2=A0create mode 100644 hw/vmapple/virtio-blk.c<br>
=C2=A0create mode 100644 hw/vmapple/vmapple.c<br>
=C2=A0create mode 100644 include/hw/vmapple/vmapple.h<br>
<br>
-- <br>
2.39.5 (Apple Git-154)<br>
<br>
<br>
</blockquote></div>

--000000000000473acc06292bc2a1--

