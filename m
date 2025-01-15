Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E51C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY5PE-00029L-G3; Wed, 15 Jan 2025 10:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tY5PC-00029C-Rj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:34:06 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tY5P4-0000Pd-Tw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:34:06 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4afe1009960so1982423137.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 07:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736955237; x=1737560037;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tik+Y1bYKS7nVxm5jGrARcP7raToy7HGeUnDIXWgVEs=;
 b=Jzn6MSP3sDn4A/1rDZ+N2oAq+0smvB1cwBA9Tzz7Ri5b9U2xqeWND9EIwKuUU50LoS
 SRjON6TJ8MeCGo5V4ITapeb4Oteb0D7ndruaHymZpY/Vfd91nzWmhMpaUXosBC++hbkg
 CESP5BoK+N9+zWlzDEf83v7vDZhg/HjpTe28GaTL49xYdWRln8byGvU92dh4SXAlQ0y1
 KxdrsdypSiqq6gfcSX77I+Wvjs9xZYAzUBZFlCyO92ObwNfQalXme09iUBL6SAZ2X5Oa
 ZTCyEWbvZlZYc3LD03mprYib4mUyfbkPK1YgkvnWZ88KWXsxtATfPIDpuw+Nw1kLNXwx
 vVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955237; x=1737560037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tik+Y1bYKS7nVxm5jGrARcP7raToy7HGeUnDIXWgVEs=;
 b=cDurwv2ntPO1TLAbmp3JjNs7lBu62vY6S7bI0zEmb6ndvBGIDTfebmS8nABkQx1ieo
 PMN1qd3EQOwXK38YC9RroiFsBwfo9kl42usK6uGDb0j07VsEZO087slFzvW8Fe6lcxOG
 Du3F1In4l9f0wBWbDkwaOlT46h//WI1QNnLDbf9fsW6uEWBjFitoHcjsz9czdGQMaaYP
 D27DKxDAdoiXEVWUNizzMVq4YCcfgJGvgJuGxicR3RXb8NDMcv1uaijsx5ZrV4Vib9x8
 2M6ncL+Xlg/nrS0PCQX5QhMdvWnrjwaQ4CmfT9m/2XK/c4OsJDX/yCGnF6LG+v0FueY/
 rb3A==
X-Gm-Message-State: AOJu0YyOlb6+5NhZCLsqi/GUuc4Sx6W+vMFjIKciI8xB8IAwRv2OVlIx
 AHXcZGanEpy7d8yaOef4zlanY8F+M6mhbHia33JNHDuOLXHqunxHLE0ZLJw2SNoYvv46Oqvxk2p
 6SQtOayuKCeKr2BKFvIB9LuZKjQiZVhy9jewx
X-Gm-Gg: ASbGnctbAqMKYSWV6mZjJcR3Yes82aqV6fCI73vptstcn0BIYkM9wb4R6Y3yrzlMExm
 2TeP6EOuP8zvwG0clHR4ezKvjwI8IPzHyKRWTTA==
X-Google-Smtp-Source: AGHT+IFeRCTteE+vobEsQz/MzHpp4SW8RUF6Ea/RpJaHkmRaPj7BXcXVTmFicME7u5/9qgNcaoFPbklQpoeOhjzQ6b8=
X-Received: by 2002:a05:6122:d06:b0:518:8753:34aa with SMTP id
 71dfb90a1353d-51c6c537722mr23319851e0c.10.1736955237269; Wed, 15 Jan 2025
 07:33:57 -0800 (PST)
MIME-Version: 1.0
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250115100747-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250115100747-mutt-send-email-mst@kernel.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 15 Jan 2025 16:33:45 +0100
X-Gm-Features: AbW1kvbICk4fchSTxw0HC5FzmssD3FyeuDZTYijmiCJstFDqA-zR0MBdQBOt5SU
Message-ID: <CAAibmn2-vP1ukGwQ8cj6aswjVXMFGi0KzJV3xDPD8SKVH44emg@mail.gmail.com>
Subject: Re: [PATCH v17 00/11] New vmapple machine type and xhci fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 marcandre.lureau@redhat.com, philmd@linaro.org, eblake@redhat.com, 
 armbru@redhat.com, qemu-block@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e8ab13062bc067de"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e32;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe32.google.com
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

--000000000000e8ab13062bc067de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 16:08, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Sun, Jan 12, 2025 at 10:00:45PM +0100, Phil Dennis-Jordan wrote:
> > This patch set introduces a new ARM and macOS HVF specific machine type
> > called "vmapple". There are also some patches for fixing XHCI spec
> > compliance issues and adding a workaround to a quirk in the macOS guest=
's
> > XHCI driver.
> >
> > The vmapple machine type approximates the configuration in macOS's own
> > Virtualization.framework when running arm64 macOS guests. In addition t=
o
> > generic components such as a GICv3 and an XHCI USB controller, it
> > includes nonstandard extensions to the virtio block device, a special
> > "hardware" aes engine, a configuration device, a pvpanic variant, a
> > "backdoor" interface, and of course the apple-gfx paravirtualised displ=
ay
> > adapter.
> >
> >
> > The macOS guest initially did not work well with QEMU's XHCI controller=
,
> > which required some investigation, bug fixing, and a work-around.
> >
> > Essentially, the macOS driver attempts to use XHCI event rings 1 and 2
> > even when there is only a single pin-based interrupt available. The
> > interrupts for rings 1 and 2 are dropped, and so events are only handle=
d
> > after a timeout. The driver appears to expect the device to act as if
> > interrupter mapping was not supported - the spec only mentions that
> > interrupter mapping should be disabled if only one interrupter is
> > enabled, not one interrupt, although there is potential ambiguity in
> > the spec's wording around enabling and disabling interrupters.
> >
> > In any case, this investigation has led to 3 changes:
> >
> >  * The spec requires that modulo arithmetic be used for selecting
> >    the MSI vector to notify from the interrupter/event ring index.
> >    (Patch 1)
> >  * The spec requires that all events be directed at ring 0 if
> >    interrupter mapping is not available; the condition for this
> >    mentioned in the spec is when there is only 1 interrupter
> >    available. (Patch 2)
> >  * A property is added to the PCI XHCI controller classes to disable
> >    interrupter mapping when using pin-based interrupts. This makes
> >    the macOS guest drivers work. (Patch 9) This is enabled in the
> >    vmapple machine type, which does not offer MSI(-X) support.
> >
> > There are currently a few limitations to the vmapple machine. These
> > aren't intrinsic, just imperfect emulation of the VZF, but it's good
> > enough to be just about usable for some purposes:
> >
> >  * macOS 12 guests only. Versions 13+ currently fail during early boot.
> >  * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some difference=
s
> >    between Apple M series CPUs and TCG's aarch64 implementation? macOS
> >    hosts only because ParavirtualizedGraphics.framework is a black box
> >    implementing most of the logic behind the apple-gfx device.)
> >  * The guest OS must first be provisioned using Virtualization.framewor=
k;
> >    the disk images can subsequently be used in Qemu. (See docs.)
> >
> >
> > Previous versions of this series also included the macOS PV graphics
> > device ("apple-gfx"); those patches have already been merged, so
> > the title has been changed. Previous iteration:
> > https://patchew.org/QEMU/20241223221645.29911-1-phil@philjordan.eu/
> >
> > Furthermore, the XHCI fixes and workaround were previously submitted
> > as a separate patch set, of which a few patches have also been merged.
> > "hw/usb/hcd-xhci: Fixes, improvements and macOS workaround"
> > https://patchew.org/QEMU/20241227121336.25838-1-phil@philjordan.eu/
> >
> > Finally, I've included one of Philippe Mathieu-Daud=C3=A9's GICv3 patch=
es
> > which arose out of the discovery that the software GICv3 dependency
> > was missing when building v16 and earlier versions of this series
> > in a HVF-only configuration.
> > https://patchew.org/QEMU/20241227202435.48055-1-philmd@linaro.org/
>
>
> just to make sure, who is merging this? Me?
>

ICYMI, Phil M-D has already pulled patches 1 & 2, and Stefan has merged
them into staging & master.

As I understand it, Phil M-D was also in the process of merging the rest of
v16 of this series before discovering the GICv3 dependency/Kconfig issue:

https://lore.kernel.org/qemu-devel/8554330d-fd9b-4fa5-b37c-161f70b71f7d@lin=
aro.org/

I don't really mind either way who merges this, but he might have some more
thoughts on the matter - there might be a specific reason he's so far only
picked up those two patches. :-)

> ---
> >
> > v2 -> v3:
> >
> >  * Merged the apple-gfx and vmapple patchsets.
> >  * Squashed a bunch of later apple-gfx patches into the main one.
> >    (dGPU support, queried MMIO area size, host GPU picking logic.)
> >  * Rebased on latest upstream, fixing any breakages due to internal
> >    Qemu API changes.
> >  * apple-gfx: Switched to re-entrant MMIO. This is supported by the
> >    underlying framework and simplifies the MMIO forwarding code which
> >    was previously different on x86-64 vs aarch64.
> >  * vmapple: Fixes for minor bugs and comments from the last round of
> >    review.
> >  * vmapple aes, conf, apple-gfx: Switched reset methods to implement
> >    the ResettableClass base's interface.
> >  * vmapple: switched from virtio-hid to an XHCI USB controller and
> >    USB mouse and tablet devices. macOS does not provide drivers for
> >    virtio HID devices, at least not in version 12's vmapple kernel.
> >    So input now sort of works (interrupt issues) rather than not
> >    at all. Use network-based remote access to the guest OS as a
> >    work-around.
> >
> > v3 -> v4:
> >
> >  * Complete rework of the mechanism for handling runloop/libdispatch
> >    events on the main thread. PV graphics now work with the SDL UI.
> >  * Renamed 'apple-gfx-vmapple' device to 'apple-gfx-mmio'
> >  * hw/display/apple-gfx: threading model overhaul to be more consistent=
,
> >    safer, and more QEMU-idiomatic.
> >  * display-modes property on the apple-gfx devices now uses the
> >    native array property mechanism and works on both device variants.
> >  * hw/vmapple/aes: Improvements to logging and error handling.
> >  * hw/vmapple/cfg: Bug fixes around device property default values.
> >  * hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header code moved into
> >    .c files, only a single vmapple.h now contains the #defines for the
> >    vmapple machine model-specific device type names.
> >  * hw/block/virtio-blk: New patch for replacing virtio_blk_free_request
> >    with g_free. (Optional)
> >  * Various smaller changes following comments in v3 code review in
> >    apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and the vmapple
> >    machine type itself. See patch-specific v4 change notes for details.
> >
> > v4 -> v5:
> >
> >  * Simplified the main thread runloop mechanism. Back to setting
> >        qemu_main directly, but narrowing the scope of what it needs to
> do,
> >        and it can now be NULL. (Meaning run the QEMU main event loop on
> >        the main thread as is traditional.)
> >  * hw/display/apple-gfx: Further improvements to the BH based job code
> bridging
> >    the libdispatch & QEMU thread synchronisation impedance mismatch.
> >  * hw/display/apple-gfx: Thread safety and object lifetime improvements=
.
> >  * hw/display/apple-gfx-*: Better buffer and error handling in display
> mode
> >    property setters and getters.
> >  * hw/vmapple/aes: More consistent and safer logging/tracing
> >  * hw/vmapple/cfg: Better error reporting on overlong property strings.
> >  * hw/vmapple/virtio-blk: Fixed theoretically-unaligned write to config
> buffer.
> >  * vmapple machine type: Moved ecam region into machine state, improved
> device
> >    property setting error handling, improved ECID/UUID extraction scrip=
t
> and
> >    docs.
> >  * Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci, vmapple/aes=
,
> >    vmapple/cfg, vmapple/virtio-blk, and vmapple machine type.
> >  * Added SPDX license identifiers where they were missing.
> >
> > v5 -> v6:
> >
> >  * 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespace
> >  * 02/15 (apple-gfx): Further refinement of PVG threading: reduced some
> callback
> >    tasks from BHs to merely acquiring RCU read lock; replaced some
> libdispatch
> >    tasks with BHs; last remaining synchronous BH now uses emphemeral
> >    QemuSemaphore.
> >  * 02/15 (apple-gfx): Readability improvements and other smaller tweaks
> >    (see patch change notes for details)
> >  * 04/15 (display modes): Replaced use of alloca() with NSMutableArray.
> >
> > v6 -> v7:
> >
> >  * 02/15 (apple-gfx): Use g_ptr_array_find() helper function, coding
> style tweak
> >  * 03/15 (apple-gfx-pci): Removed an unused function parameter
> >  * 04/15 (apple-gfx display mode property): Simplified error handling i=
n
> >    property parsing.
> >  * 10/15 (vmapple/aes): Coding style tweaks.
> >  * 12/15 (vmapple/cfg): Changed error messages for overrun of propertie=
s
> with
> >    fixed-length strings to be more useful to users than developers.
> >  * 15/15 (vmapple machine type): Tiny error handling fix, un-inlined
> function
> >
> > v7 -> v8:
> >
> >  * 02/15 (apple-gfx): Naming and type use improvements, fixes for a bug
> and a
> >    leak.
> >  * 04/15 (apple-gfx display mode property): Type use improvement
> >  * 10/15 (vmapple/aes): Guest error logging tweaks.
> >  * 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memory_read with
> >    dma_memory_read, and a g_free call with g_autofree.
> >  * 12/15 (vmapple/cfg): Macro hygiene fix: consistently enclosing
> arguments in
> >    parens.
> >  * 15/15 (vmapple machine type): Use less verbose pattern for defining
> uuid
> >    property.
> >
> > v8 -> v9:
> >
> >  * 01/16 (ui & main loop): Set qemu_main to NULL for GTK UI as well.
> >  * 02/16 (apple-gfx): Pass device pointer to graphic_console_init(),
> various
> >        non-functional changes.
> >  * 03/16 (apple-gfx-pci): Fixup of changed common call, whitespace and
> comment
> >    formatting tweaks.
> >  * 04/16 (apple-gfx display modes): Re-ordered type definitions so we
> can drop
> >    a 'struct' keyword.
> >  * 10/16 (vmapple/aes): Replaced a use of cpu_physical_memory_write wit=
h
> >    dma_memory_write, minor style tweak.
> >  * 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memory_write wit=
h
> >    dma_memory_write.
> >  * 13/16 (vmapple/virtio-blk): Correctly specify class_size for
> >    VMAppleVirtIOBlkClass.
> >  * 15/16 (vmapple machine type): Documentation improvements, fixed
> variable
> >    name and struct field used during pvpanic device creation.
> >  * 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to replace type
> hierarchy
> >    with a variant property. This seems cleaner and less confusing than
> the
> >    original approach to me, but I'm not sure if it warrants creation of
> a new
> >    QAPI enum and property type definition.
> >
> > v9 -> v10:
> >
> >  * 01/15 (ui & main loop): Added comments to qemu_main declaration and
> GTK.
> >  * 02/15 (apple-gfx): Reworked the way frame rendering code is threaded
> to use
> >    BHs for sections requiring BQL.
> >  * 02/15 (apple-gfx): Fixed ./configure error on non-macOS platforms.
> >  * 10/15 (vmapple/aes): Code style and comment improvements.
> >  * 12/15 (vmapple/cfg): Slightly tidier error reporting for overlong
> property
> >    values.
> >  * 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into this one,
> changing
> >    the device type design to provide a single device type with a varian=
t
> >        property instead of 2 different subtypes for aux and root volume=
s.
> >  * 15/15 (vmapple machine type): Documentation fixup for changed
> virtio-blk
> >    device type; small improvements to shell commands in documentation;
> >    improved propagation of errors during cfg device instantiation.
> >
> > v10 -> v11:
> >
> >  * 01/15 (ui & main loop): Simplified main.c, better comments & commit
> message
> >  * 02/15 (apple-gfx): Give each PV display instance a unique serial
> number.
> >  * 02 & 03/15 (apple-gfx, -pci): Formatting/style tweaks
> >  * 15/15 (vmapple machine type): Improvements to shell code in docs
> >
> > v11 -> v12:
> >
> >  * 01/15 (ui & main loop): More precise wording of code comments.
> >  * 02/15 (apple-gfx): Fixed memory management regressions introduced in
> v10;
> >    improved error handling; various more conmetic code adjustments
> >  * 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS constant that have
> been
> >    added to QEMU since this patch was originally written.
> >
> > v12 -> v13:
> >
> >  * 15/15 (vmapple machine type): Bumped the machine type version from 9=
.2
> >    to 10.0.
> >  * All patches in the series now have been positively reviewed and
> received
> >    corresponding reviewed-by tags.
> >
> > v13 -> v14:
> >
> >  * 6/15 (hw/vmapple directory): Changed myself from reviewer
> >    to maintainer, as that seemed appropriate at this point.
> >  * 15/15 (vmapple machine type): Gate creation of XHCI and
> >    USB HID devices behind if (defaults_enabled()).
> >
> > v14 -> v15
> >
> >  * Constified property tables to match Richard Henderson's recent
> project-
> >    wide convention change. (patches 4/15, 7/15, 11/15, 12/15, & 13/15)
> >
> > v15 -> v16
> >
> >  * 14 patches now, as patch 8 has already been pulled. (Thanks Philippe=
!)
> >  * Fixed a bunch of conflicts with upstream code motion:
> >     - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gfx mode list, 7/14=
 -
> >       pvpanic-mmio, 10/14 - bdif, 11/14 - cfg device, and
> >       12/14 - vmapple-virtio-blk)
> >     - sysemu->system move/rename: (1/14 - ui/qemu-main, 2/14 - apple-gf=
x,
> >       9/14 - aes, 10/14 - bdif, 14/14 - vmapple machine type)
> >  * 14/14 (vmapple machine type):
> >     - Moved compatibility setting for removing legacy mode from
> virtio-pci
> >       to proper global property table rather than (ab)using sugar
> property.
> >     - Removed a few superfluous #includes during sysemu rename cleanup.
> >     - Removed machine type versioning as it's not necessary (yet?)
> >     - Made memory map array const
> >
> > XHCI RFC -> v1:
> >
> >  * Gated conditional interrupter mapping support behind a property,
> enabled
> >    that property in the VMApple machine type.
> >  * Added patch to fix the MSI vector assertion failure.
> >  * Moved msi and msix properties from NEC XHCI controller to generic
> xhci-pci
> >    superclass as that also seems useful.
> >  * Broke the workaround up into 2 patches, one for mapping disabling
> required
> >    by the standard, and one for the conditional disabling workaround.
> >
> > XHCI v1 -> v2:
> >
> >  * 1/6: Switch to modulo arithmetic for MSI vector number, as per spec.
> >  * 6/6: Set the "conditional-intr-mapping" property via compat_props.
> >  * Commit message tweaks
> >
> > XHCI v2 -> v3:
> >
> >  * 2/6: In line with recent upstream changes, the property table is now
> >    const and no longer carries an end-of-list marker.
> >  * The indentation fix (previously 5/6) has already been merged, so is =
no
> >    longer included.
> >  * Added patch fixing up logging of certain unhandled MMIO cases. (4/6)
> >  * 6/6: Moved the compat global property table into vmapple patch set
> -v16;
> >    we now just add the conditional-intr-mapping property to it in this
> >    patch. We also set the property on any device implementing the
> abstract
> >    TYPE_XHCI_PCI rather than only the TYPE_QEMU_XHCI device specificall=
y.
> >
> > v16 -> v17
> >
> >  * Rebased on latest upstream (with minor conflict fixes)
> >  * apple-gfx, GPEX, and ui/cocoa patches dropped as they have been
> merged.
> >  * Unmerged patches from xhci series v3 combined into this series.
> >  * vmapple machine type: Explicitly depend on software GICv3.
> >  * vmapple machine type: Enable the new XHCI PCI conditional-intr-mappi=
ng
> >    property via the machine type's global compat property table.
> >  * Integrated Philippe's patch on renaming the GICv3's confusing config
> name,
> >    and removing its TCG dependency. (It's needed with HVF too.)
> >  * vmapple machine type: Dropped Tested-by tag because of above changes
> >
> >
> > Alexander Graf (7):
> >   hw: Add vmapple subdir
> >   hw/misc/pvpanic: Add MMIO interface
> >   hw/vmapple/aes: Introduce aes engine
> >   hw/vmapple/bdif: Introduce vmapple backdoor interface
> >   hw/vmapple/cfg: Introduce vmapple cfg region
> >   hw/vmapple/virtio-blk: Add support for apple virtio-blk
> >   hw/vmapple/vmapple: Add vmapple machine type
> >
> > Phil Dennis-Jordan (3):
> >   hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
> >   hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported
> >   hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode
> >
> > Philippe Mathieu-Daud=C3=A9 (1):
> >   hw/intc: Remove TCG dependency on ARM_GICV3
> >
> >  MAINTAINERS                         |   8 +
> >  contrib/vmapple/uuid.sh             |   9 +
> >  docs/system/arm/vmapple.rst         |  63 +++
> >  docs/system/target-arm.rst          |   1 +
> >  hw/Kconfig                          |   1 +
> >  hw/block/virtio-blk.c               |  19 +-
> >  hw/core/qdev-properties-system.c    |   8 +
> >  hw/intc/Kconfig                     |   6 +-
> >  hw/intc/meson.build                 |   4 +-
> >  hw/meson.build                      |   1 +
> >  hw/misc/Kconfig                     |   4 +
> >  hw/misc/meson.build                 |   1 +
> >  hw/misc/pvpanic-mmio.c              |  60 +++
> >  hw/usb/hcd-xhci-pci.c               |  25 ++
> >  hw/usb/hcd-xhci-pci.h               |   1 +
> >  hw/usb/hcd-xhci.c                   |   5 +
> >  hw/usb/hcd-xhci.h                   |   5 +
> >  hw/vmapple/Kconfig                  |  32 ++
> >  hw/vmapple/aes.c                    | 581 ++++++++++++++++++++++++++
> >  hw/vmapple/bdif.c                   | 274 ++++++++++++
> >  hw/vmapple/cfg.c                    | 195 +++++++++
> >  hw/vmapple/meson.build              |   5 +
> >  hw/vmapple/trace-events             |  21 +
> >  hw/vmapple/trace.h                  |   1 +
> >  hw/vmapple/virtio-blk.c             | 204 +++++++++
> >  hw/vmapple/vmapple.c                | 618 ++++++++++++++++++++++++++++
> >  include/hw/misc/pvpanic.h           |   1 +
> >  include/hw/pci/pci_ids.h            |   1 +
> >  include/hw/qdev-properties-system.h |   5 +
> >  include/hw/virtio/virtio-blk.h      |  11 +-
> >  include/hw/vmapple/vmapple.h        |  23 ++
> >  include/qemu/cutils.h               |  15 +
> >  meson.build                         |   1 +
> >  qapi/virtio.json                    |  14 +
> >  util/hexdump.c                      |  18 +
> >  35 files changed, 2231 insertions(+), 10 deletions(-)
> >  create mode 100755 contrib/vmapple/uuid.sh
> >  create mode 100644 docs/system/arm/vmapple.rst
> >  create mode 100644 hw/misc/pvpanic-mmio.c
> >  create mode 100644 hw/vmapple/Kconfig
> >  create mode 100644 hw/vmapple/aes.c
> >  create mode 100644 hw/vmapple/bdif.c
> >  create mode 100644 hw/vmapple/cfg.c
> >  create mode 100644 hw/vmapple/meson.build
> >  create mode 100644 hw/vmapple/trace-events
> >  create mode 100644 hw/vmapple/trace.h
> >  create mode 100644 hw/vmapple/virtio-blk.c
> >  create mode 100644 hw/vmapple/vmapple.c
> >  create mode 100644 include/hw/vmapple/vmapple.h
> >
> > --
> > 2.39.5 (Apple Git-154)
>
>

--000000000000e8ab13062bc067de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 15 Jan =
2025 at 16:08, Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Sun, Jan 12, 2025 at 10:00:45PM +0100, Phil Dennis-Jordan wro=
te:<br>
&gt; This patch set introduces a new ARM and macOS HVF specific machine typ=
e<br>
&gt; called &quot;vmapple&quot;. There are also some patches for fixing XHC=
I spec<br>
&gt; compliance issues and adding a workaround to a quirk in the macOS gues=
t&#39;s<br>
&gt; XHCI driver.<br>
&gt; <br>
&gt; The vmapple machine type approximates the configuration in macOS&#39;s=
 own<br>
&gt; Virtualization.framework when running arm64 macOS guests. In addition =
to<br>
&gt; generic components such as a GICv3 and an XHCI USB controller, it<br>
&gt; includes nonstandard extensions to the virtio block device, a special<=
br>
&gt; &quot;hardware&quot; aes engine, a configuration device, a pvpanic var=
iant, a<br>
&gt; &quot;backdoor&quot; interface, and of course the apple-gfx paravirtua=
lised display<br>
&gt; adapter.<br>
&gt; <br>
&gt; <br>
&gt; The macOS guest initially did not work well with QEMU&#39;s XHCI contr=
oller,<br>
&gt; which required some investigation, bug fixing, and a work-around.<br>
&gt; <br>
&gt; Essentially, the macOS driver attempts to use XHCI event rings 1 and 2=
<br>
&gt; even when there is only a single pin-based interrupt available. The<br=
>
&gt; interrupts for rings 1 and 2 are dropped, and so events are only handl=
ed<br>
&gt; after a timeout. The driver appears to expect the device to act as if<=
br>
&gt; interrupter mapping was not supported - the spec only mentions that<br=
>
&gt; interrupter mapping should be disabled if only one interrupter is<br>
&gt; enabled, not one interrupt, although there is potential ambiguity in<b=
r>
&gt; the spec&#39;s wording around enabling and disabling interrupters.<br>
&gt; <br>
&gt; In any case, this investigation has led to 3 changes:<br>
&gt; <br>
&gt;=C2=A0 * The spec requires that modulo arithmetic be used for selecting=
<br>
&gt;=C2=A0 =C2=A0 the MSI vector to notify from the interrupter/event ring =
index.<br>
&gt;=C2=A0 =C2=A0 (Patch 1)<br>
&gt;=C2=A0 * The spec requires that all events be directed at ring 0 if<br>
&gt;=C2=A0 =C2=A0 interrupter mapping is not available; the condition for t=
his<br>
&gt;=C2=A0 =C2=A0 mentioned in the spec is when there is only 1 interrupter=
<br>
&gt;=C2=A0 =C2=A0 available. (Patch 2)<br>
&gt;=C2=A0 * A property is added to the PCI XHCI controller classes to disa=
ble<br>
&gt;=C2=A0 =C2=A0 interrupter mapping when using pin-based interrupts. This=
 makes<br>
&gt;=C2=A0 =C2=A0 the macOS guest drivers work. (Patch 9) This is enabled i=
n the<br>
&gt;=C2=A0 =C2=A0 vmapple machine type, which does not offer MSI(-X) suppor=
t.<br>
&gt; <br>
&gt; There are currently a few limitations to the vmapple machine. These<br=
>
&gt; aren&#39;t intrinsic, just imperfect emulation of the VZF, but it&#39;=
s good<br>
&gt; enough to be just about usable for some purposes:<br>
&gt; <br>
&gt;=C2=A0 * macOS 12 guests only. Versions 13+ currently fail during early=
 boot.<br>
&gt;=C2=A0 * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some diff=
erences<br>
&gt;=C2=A0 =C2=A0 between Apple M series CPUs and TCG&#39;s aarch64 impleme=
ntation? macOS<br>
&gt;=C2=A0 =C2=A0 hosts only because ParavirtualizedGraphics.framework is a=
 black box<br>
&gt;=C2=A0 =C2=A0 implementing most of the logic behind the apple-gfx devic=
e.)<br>
&gt;=C2=A0 * The guest OS must first be provisioned using Virtualization.fr=
amework;<br>
&gt;=C2=A0 =C2=A0 the disk images can subsequently be used in Qemu. (See do=
cs.)<br>
&gt; <br>
&gt; <br>
&gt; Previous versions of this series also included the macOS PV graphics<b=
r>
&gt; device (&quot;apple-gfx&quot;); those patches have already been merged=
, so<br>
&gt; the title has been changed. Previous iteration:<br>
&gt; <a href=3D"https://patchew.org/QEMU/20241223221645.29911-1-phil@philjo=
rdan.eu/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/202=
41223221645.29911-1-phil@philjordan.eu/</a><br>
&gt; <br>
&gt; Furthermore, the XHCI fixes and workaround were previously submitted<b=
r>
&gt; as a separate patch set, of which a few patches have also been merged.=
<br>
&gt; &quot;hw/usb/hcd-xhci: Fixes, improvements and macOS workaround&quot;<=
br>
&gt; <a href=3D"https://patchew.org/QEMU/20241227121336.25838-1-phil@philjo=
rdan.eu/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/202=
41227121336.25838-1-phil@philjordan.eu/</a><br>
&gt; <br>
&gt; Finally, I&#39;ve included one of Philippe Mathieu-Daud=C3=A9&#39;s GI=
Cv3 patches<br>
&gt; which arose out of the discovery that the software GICv3 dependency<br=
>
&gt; was missing when building v16 and earlier versions of this series<br>
&gt; in a HVF-only configuration.<br>
&gt; <a href=3D"https://patchew.org/QEMU/20241227202435.48055-1-philmd@lina=
ro.org/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/2024=
1227202435.48055-1-philmd@linaro.org/</a><br>
<br>
<br>
just to make sure, who is merging this? Me?<br></blockquote><div><br></div>=
<div>ICYMI, Phil M-D has already pulled patches 1 &amp; 2, and Stefan has m=
erged them into staging &amp; master.=C2=A0</div><div><br></div><div>As I u=
nderstand it, Phil M-D was also in the process of merging the rest of v16 o=
f this series before discovering the GICv3 dependency/Kconfig issue:<br></d=
iv><div><br></div><div><a href=3D"https://lore.kernel.org/qemu-devel/855433=
0d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org/">https://lore.kernel.org/qemu-de=
vel/8554330d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org/</a></div><div><br></di=
v><div>I don&#39;t really mind either way who merges this, but he might hav=
e some more thoughts on the matter - there might be a specific reason he&#3=
9;s so far only picked up those two patches. :-)</div><br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt; <br>
&gt; v2 -&gt; v3:<br>
&gt; <br>
&gt;=C2=A0 * Merged the apple-gfx and vmapple patchsets.<br>
&gt;=C2=A0 * Squashed a bunch of later apple-gfx patches into the main one.=
<br>
&gt;=C2=A0 =C2=A0 (dGPU support, queried MMIO area size, host GPU picking l=
ogic.)<br>
&gt;=C2=A0 * Rebased on latest upstream, fixing any breakages due to intern=
al<br>
&gt;=C2=A0 =C2=A0 Qemu API changes.<br>
&gt;=C2=A0 * apple-gfx: Switched to re-entrant MMIO. This is supported by t=
he<br>
&gt;=C2=A0 =C2=A0 underlying framework and simplifies the MMIO forwarding c=
ode which<br>
&gt;=C2=A0 =C2=A0 was previously different on x86-64 vs aarch64.<br>
&gt;=C2=A0 * vmapple: Fixes for minor bugs and comments from the last round=
 of<br>
&gt;=C2=A0 =C2=A0 review.<br>
&gt;=C2=A0 * vmapple aes, conf, apple-gfx: Switched reset methods to implem=
ent<br>
&gt;=C2=A0 =C2=A0 the ResettableClass base&#39;s interface.<br>
&gt;=C2=A0 * vmapple: switched from virtio-hid to an XHCI USB controller an=
d<br>
&gt;=C2=A0 =C2=A0 USB mouse and tablet devices. macOS does not provide driv=
ers for<br>
&gt;=C2=A0 =C2=A0 virtio HID devices, at least not in version 12&#39;s vmap=
ple kernel.<br>
&gt;=C2=A0 =C2=A0 So input now sort of works (interrupt issues) rather than=
 not<br>
&gt;=C2=A0 =C2=A0 at all. Use network-based remote access to the guest OS a=
s a<br>
&gt;=C2=A0 =C2=A0 work-around.<br>
&gt; <br>
&gt; v3 -&gt; v4:<br>
&gt; <br>
&gt;=C2=A0 * Complete rework of the mechanism for handling runloop/libdispa=
tch<br>
&gt;=C2=A0 =C2=A0 events on the main thread. PV graphics now work with the =
SDL UI.<br>
&gt;=C2=A0 * Renamed &#39;apple-gfx-vmapple&#39; device to &#39;apple-gfx-m=
mio&#39;<br>
&gt;=C2=A0 * hw/display/apple-gfx: threading model overhaul to be more cons=
istent,<br>
&gt;=C2=A0 =C2=A0 safer, and more QEMU-idiomatic.<br>
&gt;=C2=A0 * display-modes property on the apple-gfx devices now uses the<b=
r>
&gt;=C2=A0 =C2=A0 native array property mechanism and works on both device =
variants.<br>
&gt;=C2=A0 * hw/vmapple/aes: Improvements to logging and error handling.<br=
>
&gt;=C2=A0 * hw/vmapple/cfg: Bug fixes around device property default value=
s.<br>
&gt;=C2=A0 * hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header code move=
d into<br>
&gt;=C2=A0 =C2=A0 .c files, only a single vmapple.h now contains the #defin=
es for the<br>
&gt;=C2=A0 =C2=A0 vmapple machine model-specific device type names.<br>
&gt;=C2=A0 * hw/block/virtio-blk: New patch for replacing virtio_blk_free_r=
equest<br>
&gt;=C2=A0 =C2=A0 with g_free. (Optional)<br>
&gt;=C2=A0 * Various smaller changes following comments in v3 code review i=
n<br>
&gt;=C2=A0 =C2=A0 apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and the vm=
apple<br>
&gt;=C2=A0 =C2=A0 machine type itself. See patch-specific v4 change notes f=
or details.<br>
&gt; <br>
&gt; v4 -&gt; v5:<br>
&gt; <br>
&gt;=C2=A0 * Simplified the main thread runloop mechanism. Back to setting<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_main directly, but narrowing the scope=
 of what it needs to do,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 and it can now be NULL. (Meaning run the QE=
MU main event loop on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 the main thread as is traditional.)<br>
&gt;=C2=A0 * hw/display/apple-gfx: Further improvements to the BH based job=
 code bridging<br>
&gt;=C2=A0 =C2=A0 the libdispatch &amp; QEMU thread synchronisation impedan=
ce mismatch.<br>
&gt;=C2=A0 * hw/display/apple-gfx: Thread safety and object lifetime improv=
ements.<br>
&gt;=C2=A0 * hw/display/apple-gfx-*: Better buffer and error handling in di=
splay mode<br>
&gt;=C2=A0 =C2=A0 property setters and getters.<br>
&gt;=C2=A0 * hw/vmapple/aes: More consistent and safer logging/tracing<br>
&gt;=C2=A0 * hw/vmapple/cfg: Better error reporting on overlong property st=
rings.<br>
&gt;=C2=A0 * hw/vmapple/virtio-blk: Fixed theoretically-unaligned write to =
config buffer.<br>
&gt;=C2=A0 * vmapple machine type: Moved ecam region into machine state, im=
proved device<br>
&gt;=C2=A0 =C2=A0 property setting error handling, improved ECID/UUID extra=
ction script and<br>
&gt;=C2=A0 =C2=A0 docs.<br>
&gt;=C2=A0 * Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci, vmapp=
le/aes,<br>
&gt;=C2=A0 =C2=A0 vmapple/cfg, vmapple/virtio-blk, and vmapple machine type=
.<br>
&gt;=C2=A0 * Added SPDX license identifiers where they were missing.<br>
&gt; <br>
&gt; v5 -&gt; v6:<br>
&gt; <br>
&gt;=C2=A0 * 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespa=
ce<br>
&gt;=C2=A0 * 02/15 (apple-gfx): Further refinement of PVG threading: reduce=
d some callback<br>
&gt;=C2=A0 =C2=A0 tasks from BHs to merely acquiring RCU read lock; replace=
d some libdispatch<br>
&gt;=C2=A0 =C2=A0 tasks with BHs; last remaining synchronous BH now uses em=
phemeral<br>
&gt;=C2=A0 =C2=A0 QemuSemaphore.<br>
&gt;=C2=A0 * 02/15 (apple-gfx): Readability improvements and other smaller =
tweaks<br>
&gt;=C2=A0 =C2=A0 (see patch change notes for details)<br>
&gt;=C2=A0 * 04/15 (display modes): Replaced use of alloca()=C2=A0with NSMu=
tableArray.<br>
&gt; <br>
&gt; v6 -&gt; v7:<br>
&gt; <br>
&gt;=C2=A0 * 02/15 (apple-gfx): Use g_ptr_array_find() helper function, cod=
ing style tweak<br>
&gt;=C2=A0 * 03/15 (apple-gfx-pci): Removed an unused function parameter<br=
>
&gt;=C2=A0 * 04/15 (apple-gfx display mode property): Simplified error hand=
ling in<br>
&gt;=C2=A0 =C2=A0 property parsing.<br>
&gt;=C2=A0 * 10/15 (vmapple/aes): Coding style tweaks.<br>
&gt;=C2=A0 * 12/15 (vmapple/cfg): Changed error messages for overrun of pro=
perties with<br>
&gt;=C2=A0 =C2=A0 fixed-length strings to be more useful to users than deve=
lopers.<br>
&gt;=C2=A0 * 15/15 (vmapple machine type): Tiny error handling fix, un-inli=
ned function<br>
&gt; <br>
&gt; v7 -&gt; v8:<br>
&gt; <br>
&gt;=C2=A0 * 02/15 (apple-gfx): Naming and type use improvements, fixes for=
 a bug and a<br>
&gt;=C2=A0 =C2=A0 leak.<br>
&gt;=C2=A0 * 04/15 (apple-gfx display mode property): Type use improvement<=
br>
&gt;=C2=A0 * 10/15 (vmapple/aes): Guest error logging tweaks.<br>
&gt;=C2=A0 * 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memory_rea=
d with<br>
&gt;=C2=A0 =C2=A0 dma_memory_read, and a g_free call with g_autofree.<br>
&gt;=C2=A0 * 12/15 (vmapple/cfg): Macro hygiene fix: consistently enclosing=
 arguments in<br>
&gt;=C2=A0 =C2=A0 parens.<br>
&gt;=C2=A0 * 15/15 (vmapple machine type): Use less verbose pattern for def=
ining uuid<br>
&gt;=C2=A0 =C2=A0 property.<br>
&gt; <br>
&gt; v8 -&gt; v9:<br>
&gt; <br>
&gt;=C2=A0 * 01/16 (ui &amp; main loop): Set qemu_main to NULL for GTK UI a=
s well.<br>
&gt;=C2=A0 * 02/16 (apple-gfx): Pass device pointer to graphic_console_init=
(), various<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 non-functional changes.<br>
&gt;=C2=A0 * 03/16 (apple-gfx-pci): Fixup of changed common call, whitespac=
e and comment<br>
&gt;=C2=A0 =C2=A0 formatting tweaks.<br>
&gt;=C2=A0 * 04/16 (apple-gfx display modes): Re-ordered type definitions s=
o we can drop<br>
&gt;=C2=A0 =C2=A0 a &#39;struct&#39; keyword.<br>
&gt;=C2=A0 * 10/16 (vmapple/aes): Replaced a use of cpu_physical_memory_wri=
te with<br>
&gt;=C2=A0 =C2=A0 dma_memory_write, minor style tweak.<br>
&gt;=C2=A0 * 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memory_wri=
te with<br>
&gt;=C2=A0 =C2=A0 dma_memory_write.<br>
&gt;=C2=A0 * 13/16 (vmapple/virtio-blk): Correctly specify class_size for<b=
r>
&gt;=C2=A0 =C2=A0 VMAppleVirtIOBlkClass.<br>
&gt;=C2=A0 * 15/16 (vmapple machine type): Documentation improvements, fixe=
d variable<br>
&gt;=C2=A0 =C2=A0 name and struct field used during pvpanic device creation=
.<br>
&gt;=C2=A0 * 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to replace=
 type hierarchy<br>
&gt;=C2=A0 =C2=A0 with a variant property. This seems cleaner and less conf=
using than the<br>
&gt;=C2=A0 =C2=A0 original approach to me, but I&#39;m not sure if it warra=
nts creation of a new<br>
&gt;=C2=A0 =C2=A0 QAPI enum and property type definition.<br>
&gt; <br>
&gt; v9 -&gt; v10:<br>
&gt; <br>
&gt;=C2=A0 * 01/15 (ui &amp; main loop): Added comments to qemu_main declar=
ation and GTK.<br>
&gt;=C2=A0 * 02/15 (apple-gfx): Reworked the way frame rendering code is th=
readed to use<br>
&gt;=C2=A0 =C2=A0 BHs for sections requiring BQL.<br>
&gt;=C2=A0 * 02/15 (apple-gfx): Fixed ./configure error on non-macOS platfo=
rms.<br>
&gt;=C2=A0 * 10/15 (vmapple/aes): Code style and comment improvements.<br>
&gt;=C2=A0 * 12/15 (vmapple/cfg): Slightly tidier error reporting for overl=
ong property<br>
&gt;=C2=A0 =C2=A0 values.<br>
&gt;=C2=A0 * 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into this on=
e, changing<br>
&gt;=C2=A0 =C2=A0 the device type design to provide a single device type wi=
th a variant<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 property instead of 2 different subtypes fo=
r aux and root volumes.<br>
&gt;=C2=A0 * 15/15 (vmapple machine type): Documentation fixup for changed =
virtio-blk<br>
&gt;=C2=A0 =C2=A0 device type; small improvements to shell commands in docu=
mentation;<br>
&gt;=C2=A0 =C2=A0 improved propagation of errors during cfg device instanti=
ation.<br>
&gt; <br>
&gt; v10 -&gt; v11:<br>
&gt; <br>
&gt;=C2=A0 * 01/15 (ui &amp; main loop): Simplified main.c, better comments=
 &amp; commit message<br>
&gt;=C2=A0 * 02/15 (apple-gfx): Give each PV display instance a unique seri=
al number.<br>
&gt;=C2=A0 * 02 &amp; 03/15 (apple-gfx, -pci): Formatting/style tweaks<br>
&gt;=C2=A0 * 15/15 (vmapple machine type): Improvements to shell code in do=
cs<br>
&gt; <br>
&gt; v11 -&gt; v12:<br>
&gt; <br>
&gt;=C2=A0 * 01/15 (ui &amp; main loop): More precise wording of code comme=
nts.<br>
&gt;=C2=A0 * 02/15 (apple-gfx): Fixed memory management regressions introdu=
ced in v10;<br>
&gt;=C2=A0 =C2=A0 improved error handling; various more conmetic code adjus=
tments<br>
&gt;=C2=A0 * 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS constant tha=
t have been<br>
&gt;=C2=A0 =C2=A0 added to QEMU since this patch was originally written.<br=
>
&gt; <br>
&gt; v12 -&gt; v13:<br>
&gt; <br>
&gt;=C2=A0 * 15/15 (vmapple machine type): Bumped the machine type version =
from 9.2<br>
&gt;=C2=A0 =C2=A0 to 10.0.<br>
&gt;=C2=A0 * All patches in the series now have been positively reviewed an=
d received<br>
&gt;=C2=A0 =C2=A0 corresponding reviewed-by tags.<br>
&gt; <br>
&gt; v13 -&gt; v14:<br>
&gt; <br>
&gt;=C2=A0 * 6/15 (hw/vmapple directory): Changed myself from reviewer<br>
&gt;=C2=A0 =C2=A0 to maintainer, as that seemed appropriate at this point.<=
br>
&gt;=C2=A0 * 15/15 (vmapple machine type): Gate creation of XHCI and<br>
&gt;=C2=A0 =C2=A0 USB HID devices behind if (defaults_enabled()).<br>
&gt; <br>
&gt; v14 -&gt; v15<br>
&gt; <br>
&gt;=C2=A0 * Constified property tables to match Richard Henderson&#39;s re=
cent project-<br>
&gt;=C2=A0 =C2=A0 wide convention change. (patches 4/15, 7/15, 11/15, 12/15=
, &amp; 13/15)<br>
&gt; <br>
&gt; v15 -&gt; v16<br>
&gt; <br>
&gt;=C2=A0 * 14 patches now, as patch 8 has already been pulled. (Thanks Ph=
ilippe!)<br>
&gt;=C2=A0 * Fixed a bunch of conflicts with upstream code motion:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gfx=
 mode list, 7/14 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pvpanic-mmio, 10/14 - bdif, 11/14 - cfg devi=
ce, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A012/14 - vmapple-virtio-blk)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- sysemu-&gt;system move/rename: (1/14 - ui/qemu-ma=
in, 2/14 - apple-gfx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A09/14 - aes, 10/14 - bdif, 14/14 - vmapple ma=
chine type)<br>
&gt;=C2=A0 * 14/14 (vmapple machine type):<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Moved compatibility setting for removing legacy m=
ode from virtio-pci<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0to proper global property table rather than =
(ab)using sugar property.<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Removed a few superfluous #includes during sysemu=
 rename cleanup.<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Removed machine type versioning as it&#39;s not n=
ecessary (yet?)<br>
&gt;=C2=A0 =C2=A0 =C2=A0- Made memory map array const<br>
&gt; <br>
&gt; XHCI RFC -&gt; v1:<br>
&gt; <br>
&gt;=C2=A0 * Gated conditional interrupter mapping support behind a propert=
y, enabled<br>
&gt;=C2=A0 =C2=A0 that property in the VMApple machine type.<br>
&gt;=C2=A0 * Added patch to fix the MSI vector assertion failure.<br>
&gt;=C2=A0 * Moved msi and msix properties from NEC XHCI controller to gene=
ric xhci-pci<br>
&gt;=C2=A0 =C2=A0 superclass as that also seems useful.<br>
&gt;=C2=A0 * Broke the workaround up into 2 patches, one for mapping disabl=
ing required<br>
&gt;=C2=A0 =C2=A0 by the standard, and one for the conditional disabling wo=
rkaround.<br>
&gt; <br>
&gt; XHCI v1 -&gt; v2:<br>
&gt; <br>
&gt;=C2=A0 * 1/6: Switch to modulo arithmetic for MSI vector number, as per=
 spec.<br>
&gt;=C2=A0 * 6/6: Set the &quot;conditional-intr-mapping&quot; property via=
 compat_props.<br>
&gt;=C2=A0 * Commit message tweaks<br>
&gt; <br>
&gt; XHCI v2 -&gt; v3:<br>
&gt; <br>
&gt;=C2=A0 * 2/6: In line with recent upstream changes, the property table =
is now<br>
&gt;=C2=A0 =C2=A0 const and no longer carries an end-of-list marker.<br>
&gt;=C2=A0 * The indentation fix (previously 5/6) has already been merged, =
so is no<br>
&gt;=C2=A0 =C2=A0 longer included.<br>
&gt;=C2=A0 * Added patch fixing up logging of certain unhandled MMIO cases.=
 (4/6)<br>
&gt;=C2=A0 * 6/6: Moved the compat global property table into vmapple patch=
 set -v16;<br>
&gt;=C2=A0 =C2=A0 we now just add the conditional-intr-mapping property to =
it in this<br>
&gt;=C2=A0 =C2=A0 patch. We also set the property on any device implementin=
g the abstract<br>
&gt;=C2=A0 =C2=A0 TYPE_XHCI_PCI rather than only the TYPE_QEMU_XHCI device =
specifically.<br>
&gt; <br>
&gt; v16 -&gt; v17<br>
&gt; <br>
&gt;=C2=A0 * Rebased on latest upstream (with minor conflict fixes)<br>
&gt;=C2=A0 * apple-gfx, GPEX, and ui/cocoa patches dropped as they have bee=
n merged.<br>
&gt;=C2=A0 * Unmerged patches from xhci series v3 combined into this series=
.<br>
&gt;=C2=A0 * vmapple machine type: Explicitly depend on software GICv3.<br>
&gt;=C2=A0 * vmapple machine type: Enable the new XHCI PCI conditional-intr=
-mapping<br>
&gt;=C2=A0 =C2=A0 property via the machine type&#39;s global compat propert=
y table.<br>
&gt;=C2=A0 * Integrated Philippe&#39;s patch on renaming the GICv3&#39;s co=
nfusing config name,<br>
&gt;=C2=A0 =C2=A0 and removing its TCG dependency. (It&#39;s needed with HV=
F too.)<br>
&gt;=C2=A0 * vmapple machine type: Dropped Tested-by tag because of above c=
hanges<br>
&gt; <br>
&gt; <br>
&gt; Alexander Graf (7):<br>
&gt;=C2=A0 =C2=A0hw: Add vmapple subdir<br>
&gt;=C2=A0 =C2=A0hw/misc/pvpanic: Add MMIO interface<br>
&gt;=C2=A0 =C2=A0hw/vmapple/aes: Introduce aes engine<br>
&gt;=C2=A0 =C2=A0hw/vmapple/bdif: Introduce vmapple backdoor interface<br>
&gt;=C2=A0 =C2=A0hw/vmapple/cfg: Introduce vmapple cfg region<br>
&gt;=C2=A0 =C2=A0hw/vmapple/virtio-blk: Add support for apple virtio-blk<br=
>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple: Add vmapple machine type<br>
&gt; <br>
&gt; Phil Dennis-Jordan (3):<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as pe=
r spec<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupport=
ed<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci: Adds property for disabling mapping i=
n IRQ mode<br>
&gt; <br>
&gt; Philippe Mathieu-Daud=C3=A9 (1):<br>
&gt;=C2=A0 =C2=A0hw/intc: Remove TCG dependency on ARM_GICV3<br>
&gt; <br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 contrib/vmapple/uuid.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 docs/system/arm/vmapple.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 63 +++<br>
&gt;=C2=A0 docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 19 +-<br>
&gt;=C2=A0 hw/core/qdev-properties-system.c=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<=
br>
&gt;=C2=A0 hw/intc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 hw/intc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/misc/pvpanic-mmio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 60 +++<br>
&gt;=C2=A0 hw/usb/hcd-xhci-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 25 ++<br>
&gt;=C2=A0 hw/usb/hcd-xhci-pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/usb/hcd-xhci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 hw/usb/hcd-xhci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 32 ++<br>
&gt;=C2=A0 hw/vmapple/aes.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 581 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 hw/vmapple/bdif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 274 ++++++++++++<br>
&gt;=C2=A0 hw/vmapple/cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 195 +++++++++<br>
&gt;=C2=A0 hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 hw/vmapple/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 21 +<br>
&gt;=C2=A0 hw/vmapple/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 hw/vmapple/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 204 +++++++++<br>
&gt;=C2=A0 hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 618 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/misc/pvpanic.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 include/hw/pci/pci_ids.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 include/hw/qdev-properties-system.h |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 include/hw/virtio/virtio-blk.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-=
<br>
&gt;=C2=A0 include/hw/vmapple/vmapple.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
23 ++<br>
&gt;=C2=A0 include/qemu/cutils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 15 +<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
&gt;=C2=A0 util/hexdump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
&gt;=C2=A0 35 files changed, 2231 insertions(+), 10 deletions(-)<br>
&gt;=C2=A0 create mode 100755 contrib/vmapple/uuid.sh<br>
&gt;=C2=A0 create mode 100644 docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 create mode 100644 hw/misc/pvpanic-mmio.c<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/Kconfig<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/aes.c<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/bdif.c<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/cfg.c<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/meson.build<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/trace-events<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/trace.h<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/virtio-blk.c<br>
&gt;=C2=A0 create mode 100644 hw/vmapple/vmapple.c<br>
&gt;=C2=A0 create mode 100644 include/hw/vmapple/vmapple.h<br>
&gt; <br>
&gt; -- <br>
&gt; 2.39.5 (Apple Git-154)<br>
<br>
</blockquote></div></div>

--000000000000e8ab13062bc067de--

