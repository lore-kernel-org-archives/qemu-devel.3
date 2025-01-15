Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C70CC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3ta-0005eo-ON; Wed, 15 Jan 2025 08:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tY3tS-0005dq-3u
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:57:15 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tY3tH-0000HB-QV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:57:13 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51c7b5f3b8bso2273356e0c.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736949422; x=1737554222;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gYHgQjOnb1VX8iJGy7bnzib9qxDwoS9QqXzPLQEb/6E=;
 b=mUE3/DSINIgMSuUP/zJZo9V3ukXeSRHCyET85tn/RfmouPkQn7kt6DF6KrgaEiJc6L
 9xo7Q3Rrew9DFQn0M5ZxCDL4d/bUgQxAvRdG4vzN7S9Y1VAePhke2/Iszy57+65eAxpK
 7CtMlBZisVIj78bZ+QttpDlhJwS01ocJRXjYjrZMnFe+/y6PrOl+o1qbSHWx7kYCm4GL
 Gk13SRgkKkNrhkjxvZ6KC3NtN78DSKYdrpuskOWOFBPoO1tMrokiPZBSGr4s1+hzxdCl
 7VdhdoUyBWt0RSlP1BK4Y+vcdIatwLGwDAZAhcx3GfkrlQ4dnEJq3alSlhETmv7f7vPH
 zDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949422; x=1737554222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYHgQjOnb1VX8iJGy7bnzib9qxDwoS9QqXzPLQEb/6E=;
 b=o2y7cy33u7JR/I6CxhGc5+BalftCuKUV81ZnMT1PPv3bpA5i0lbj4X4xShY/QY7Rw4
 0ojZG3BzzdEiwF8DA2a0kiIo0Tzx7PbV9PLDXZ26r8PIOdqUmvT9uGUr681TmOwQHc04
 1sHgBfJHPJQLPId+hoy9WyAPHafgyFHBXkNnyssVA57H5qoiCZwPzrbGCTBL2ypm/2T0
 hhpzobu0w8eIAe7FTX2/xtpUFA1GXAGEscZQwOGaV8x0NYqCIoSR4Fg8hC/6tPKGpYh5
 JO1oGVWVY7bsHq1ah7B5QDpHPjEeVL++K2o9Ga3fAZw9HLx38Elwyp9bODa48DXIDaSw
 WNYA==
X-Gm-Message-State: AOJu0Ywwqu9HuF2xJyLJUqpD3WcyeuIfuyTtBmw4cEUoZBpdqw3LD4Oe
 8xku2zh7/NXSc6umIJZz3wLSspDN7Ql2cZKVt64EeeRJjKDUoOqKzuWDtlRMrzgqI9Zv1fIEyx+
 hh6Kx38T4kSkPS9LCo2yXYVD+EjHKhAAUW0vN
X-Gm-Gg: ASbGncs2OV6BrEanMmFVZlAvhrQQKQXzGRPkR19pZrPV3uuhb63LmalwOG01BOYHzBO
 Z+OYoUTRLkjN2i1SaA9JxLu+lqiBM4CXi/o4czw==
X-Google-Smtp-Source: AGHT+IEJrqF5lyU7DByy+q13O7KvrBefnIQy16wyEXhpT8i0cro0qVWE0aSdg0wtcDSZkuRVjKWma+4z0uFYFNOn4JA=
X-Received: by 2002:a05:6122:4684:b0:518:8ac7:396b with SMTP id
 71dfb90a1353d-51c6c50fa85mr23367422e0c.8.1736949421852; Wed, 15 Jan 2025
 05:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20250112210056.16658-1-phil@philjordan.eu>
 <9a355e48-a173-4e82-a65e-4a67ac3331cc@tls.msk.ru>
In-Reply-To: <9a355e48-a173-4e82-a65e-4a67ac3331cc@tls.msk.ru>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 15 Jan 2025 14:56:50 +0100
X-Gm-Features: AbW1kvYlc78Jpm4Une39DEFflsAjq0yBTcoZyeFvGP7omBxMyJQQoY7R0TRnfOc
Message-ID: <CAAibmn1fGU+FKVM1hUEwbdee+ob=NRHbzmEwJHaKi_Nhrcu+kw@mail.gmail.com>
Subject: Re: [PATCH v17 00/11] New vmapple machine type and xhci fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, 
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org, 
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org, 
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000486bdc062bbf0d49"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2a.google.com
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

--000000000000486bdc062bbf0d49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2025 at 14:05, Michael Tokarev <mjt@tls.msk.ru> wrote:

> 13.01.2025 00:00, Phil Dennis-Jordan wrote:
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
>
> Hi!
>
> It looks like this patchset has a few bugfixes which aren't specific to
> vmapple.  These are already mentioned in this patchset description,
> namely:
>
>   hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
>   hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported
>
> Should these be picked up for qemu-stable?
>

They should be pretty low-risk.

At least the first one very definitely fixes a bug, albeit obscure, that
you can trigger in the wild. (Run a macOS guest and turn off MSI-X on the
XHCI controller but leave MSI enabled, and QEMU will crash with a failed
assertion.) So sure, why not apply this to stable.

I don't know if there are any extant guest OSes where the second patch is a
necessary and sufficient fix. macOS will refuse to drive an XHCI controller
with numintrs < 4 altogether. Other guest OSes I've tried never attempt to
use more than one interrupter/event ring anyway. However, the patch
implements the behaviour that is explicitly and clearly described in the
spec regarding the situation of unsupported interrupter mapping.

macOS's driver needs this behaviour of no interrupter mapping when using
pin-based interrupts even on a controller with nominally numintrs > 1, so
to fix that you additionally need patch 9 and you enable the flag
implemented in that patch. (I have to admit I'm still not convinced we need
the flag: in my opinion the spec under-defines the pin-based situation
anyway, and I struggle to imagine a sensible use case for the [current]
behaviour with the flag disabled. More detailed discussion in the original
RFC thread:
https://patchew.org/QEMU/20241201160316.96121-1-phil@philjordan.eu/ )

So the macOS compatibility fix for pin-based mode needs patches 2+9 and as
it stands that introduces a new property, which I think disqualifies it
from merging into *-stable?
I'm not sure it's worth applying patch 2 on its own to any stable branches.

I'm hoping Nick Piggin (cc'd) might post an updated and ready to merge
version of his patches to upgrade the XHCI qtest suite, as I'd really like
to build test cases for these patches on top of that.

Thanks,
>
> /mjt
>
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
> >   * The spec requires that modulo arithmetic be used for selecting
> >     the MSI vector to notify from the interrupter/event ring index.
> >     (Patch 1)
> >   * The spec requires that all events be directed at ring 0 if
> >     interrupter mapping is not available; the condition for this
> >     mentioned in the spec is when there is only 1 interrupter
> >     available. (Patch 2)
> >   * A property is added to the PCI XHCI controller classes to disable
> >     interrupter mapping when using pin-based interrupts. This makes
> >     the macOS guest drivers work. (Patch 9) This is enabled in the
> >     vmapple machine type, which does not offer MSI(-X) support.
> >
> > There are currently a few limitations to the vmapple machine. These
> > aren't intrinsic, just imperfect emulation of the VZF, but it's good
> > enough to be just about usable for some purposes:
> >
> >   * macOS 12 guests only. Versions 13+ currently fail during early boot=
.
> >   * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differenc=
es
> >     between Apple M series CPUs and TCG's aarch64 implementation? macOS
> >     hosts only because ParavirtualizedGraphics.framework is a black box
> >     implementing most of the logic behind the apple-gfx device.)
> >   * The guest OS must first be provisioned using
> Virtualization.framework;
> >     the disk images can subsequently be used in Qemu. (See docs.)
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
> >
> > ---
> >
> > v2 -> v3:
> >
> >   * Merged the apple-gfx and vmapple patchsets.
> >   * Squashed a bunch of later apple-gfx patches into the main one.
> >     (dGPU support, queried MMIO area size, host GPU picking logic.)
> >   * Rebased on latest upstream, fixing any breakages due to internal
> >     Qemu API changes.
> >   * apple-gfx: Switched to re-entrant MMIO. This is supported by the
> >     underlying framework and simplifies the MMIO forwarding code which
> >     was previously different on x86-64 vs aarch64.
> >   * vmapple: Fixes for minor bugs and comments from the last round of
> >     review.
> >   * vmapple aes, conf, apple-gfx: Switched reset methods to implement
> >     the ResettableClass base's interface.
> >   * vmapple: switched from virtio-hid to an XHCI USB controller and
> >     USB mouse and tablet devices. macOS does not provide drivers for
> >     virtio HID devices, at least not in version 12's vmapple kernel.
> >     So input now sort of works (interrupt issues) rather than not
> >     at all. Use network-based remote access to the guest OS as a
> >     work-around.
> >
> > v3 -> v4:
> >
> >   * Complete rework of the mechanism for handling runloop/libdispatch
> >     events on the main thread. PV graphics now work with the SDL UI.
> >   * Renamed 'apple-gfx-vmapple' device to 'apple-gfx-mmio'
> >   * hw/display/apple-gfx: threading model overhaul to be more consisten=
t,
> >     safer, and more QEMU-idiomatic.
> >   * display-modes property on the apple-gfx devices now uses the
> >     native array property mechanism and works on both device variants.
> >   * hw/vmapple/aes: Improvements to logging and error handling.
> >   * hw/vmapple/cfg: Bug fixes around device property default values.
> >   * hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header code moved int=
o
> >     .c files, only a single vmapple.h now contains the #defines for the
> >     vmapple machine model-specific device type names.
> >   * hw/block/virtio-blk: New patch for replacing virtio_blk_free_reques=
t
> >     with g_free. (Optional)
> >   * Various smaller changes following comments in v3 code review in
> >     apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and the vmapple
> >     machine type itself. See patch-specific v4 change notes for details=
.
> >
> > v4 -> v5:
> >
> >   * Simplified the main thread runloop mechanism. Back to setting
> >        qemu_main directly, but narrowing the scope of what it needs to
> do,
> >        and it can now be NULL. (Meaning run the QEMU main event loop on
> >        the main thread as is traditional.)
> >   * hw/display/apple-gfx: Further improvements to the BH based job code
> bridging
> >     the libdispatch & QEMU thread synchronisation impedance mismatch.
> >   * hw/display/apple-gfx: Thread safety and object lifetime improvement=
s.
> >   * hw/display/apple-gfx-*: Better buffer and error handling in display
> mode
> >     property setters and getters.
> >   * hw/vmapple/aes: More consistent and safer logging/tracing
> >   * hw/vmapple/cfg: Better error reporting on overlong property strings=
.
> >   * hw/vmapple/virtio-blk: Fixed theoretically-unaligned write to confi=
g
> buffer.
> >   * vmapple machine type: Moved ecam region into machine state, improve=
d
> device
> >     property setting error handling, improved ECID/UUID extraction
> script and
> >     docs.
> >   * Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci, vmapple/ae=
s,
> >     vmapple/cfg, vmapple/virtio-blk, and vmapple machine type.
> >   * Added SPDX license identifiers where they were missing.
> >
> > v5 -> v6:
> >
> >   * 01/15 (main/Cocoa/runloop): Combined functions, fixed whitespace
> >   * 02/15 (apple-gfx): Further refinement of PVG threading: reduced som=
e
> callback
> >     tasks from BHs to merely acquiring RCU read lock; replaced some
> libdispatch
> >     tasks with BHs; last remaining synchronous BH now uses emphemeral
> >     QemuSemaphore.
> >   * 02/15 (apple-gfx): Readability improvements and other smaller tweak=
s
> >     (see patch change notes for details)
> >   * 04/15 (display modes): Replaced use of alloca() with NSMutableArray=
.
> >
> > v6 -> v7:
> >
> >   * 02/15 (apple-gfx): Use g_ptr_array_find() helper function, coding
> style tweak
> >   * 03/15 (apple-gfx-pci): Removed an unused function parameter
> >   * 04/15 (apple-gfx display mode property): Simplified error handling =
in
> >     property parsing.
> >   * 10/15 (vmapple/aes): Coding style tweaks.
> >   * 12/15 (vmapple/cfg): Changed error messages for overrun of
> properties with
> >     fixed-length strings to be more useful to users than developers.
> >   * 15/15 (vmapple machine type): Tiny error handling fix, un-inlined
> function
> >
> > v7 -> v8:
> >
> >   * 02/15 (apple-gfx): Naming and type use improvements, fixes for a bu=
g
> and a
> >     leak.
> >   * 04/15 (apple-gfx display mode property): Type use improvement
> >   * 10/15 (vmapple/aes): Guest error logging tweaks.
> >   * 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memory_read wit=
h
> >     dma_memory_read, and a g_free call with g_autofree.
> >   * 12/15 (vmapple/cfg): Macro hygiene fix: consistently enclosing
> arguments in
> >     parens.
> >   * 15/15 (vmapple machine type): Use less verbose pattern for defining
> uuid
> >     property.
> >
> > v8 -> v9:
> >
> >   * 01/16 (ui & main loop): Set qemu_main to NULL for GTK UI as well.
> >   * 02/16 (apple-gfx): Pass device pointer to graphic_console_init(),
> various
> >        non-functional changes.
> >   * 03/16 (apple-gfx-pci): Fixup of changed common call, whitespace and
> comment
> >     formatting tweaks.
> >   * 04/16 (apple-gfx display modes): Re-ordered type definitions so we
> can drop
> >     a 'struct' keyword.
> >   * 10/16 (vmapple/aes): Replaced a use of cpu_physical_memory_write wi=
th
> >     dma_memory_write, minor style tweak.
> >   * 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memory_write wi=
th
> >     dma_memory_write.
> >   * 13/16 (vmapple/virtio-blk): Correctly specify class_size for
> >     VMAppleVirtIOBlkClass.
> >   * 15/16 (vmapple machine type): Documentation improvements, fixed
> variable
> >     name and struct field used during pvpanic device creation.
> >   * 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to replace type
> hierarchy
> >     with a variant property. This seems cleaner and less confusing than
> the
> >     original approach to me, but I'm not sure if it warrants creation o=
f
> a new
> >     QAPI enum and property type definition.
> >
> > v9 -> v10:
> >
> >   * 01/15 (ui & main loop): Added comments to qemu_main declaration and
> GTK.
> >   * 02/15 (apple-gfx): Reworked the way frame rendering code is threade=
d
> to use
> >     BHs for sections requiring BQL.
> >   * 02/15 (apple-gfx): Fixed ./configure error on non-macOS platforms.
> >   * 10/15 (vmapple/aes): Code style and comment improvements.
> >   * 12/15 (vmapple/cfg): Slightly tidier error reporting for overlong
> property
> >     values.
> >   * 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into this one,
> changing
> >     the device type design to provide a single device type with a varia=
nt
> >        property instead of 2 different subtypes for aux and root volume=
s.
> >   * 15/15 (vmapple machine type): Documentation fixup for changed
> virtio-blk
> >     device type; small improvements to shell commands in documentation;
> >     improved propagation of errors during cfg device instantiation.
> >
> > v10 -> v11:
> >
> >   * 01/15 (ui & main loop): Simplified main.c, better comments & commit
> message
> >   * 02/15 (apple-gfx): Give each PV display instance a unique serial
> number.
> >   * 02 & 03/15 (apple-gfx, -pci): Formatting/style tweaks
> >   * 15/15 (vmapple machine type): Improvements to shell code in docs
> >
> > v11 -> v12:
> >
> >   * 01/15 (ui & main loop): More precise wording of code comments.
> >   * 02/15 (apple-gfx): Fixed memory management regressions introduced i=
n
> v10;
> >     improved error handling; various more conmetic code adjustments
> >   * 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS constant that hav=
e
> been
> >     added to QEMU since this patch was originally written.
> >
> > v12 -> v13:
> >
> >   * 15/15 (vmapple machine type): Bumped the machine type version from
> 9.2
> >     to 10.0.
> >   * All patches in the series now have been positively reviewed and
> received
> >     corresponding reviewed-by tags.
> >
> > v13 -> v14:
> >
> >   * 6/15 (hw/vmapple directory): Changed myself from reviewer
> >     to maintainer, as that seemed appropriate at this point.
> >   * 15/15 (vmapple machine type): Gate creation of XHCI and
> >     USB HID devices behind if (defaults_enabled()).
> >
> > v14 -> v15
> >
> >   * Constified property tables to match Richard Henderson's recent
> project-
> >     wide convention change. (patches 4/15, 7/15, 11/15, 12/15, & 13/15)
> >
> > v15 -> v16
> >
> >   * 14 patches now, as patch 8 has already been pulled. (Thanks
> Philippe!)
> >   * Fixed a bunch of conflicts with upstream code motion:
> >      - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gfx mode list, 7/1=
4
> -
> >        pvpanic-mmio, 10/14 - bdif, 11/14 - cfg device, and
> >        12/14 - vmapple-virtio-blk)
> >      - sysemu->system move/rename: (1/14 - ui/qemu-main, 2/14 -
> apple-gfx,
> >        9/14 - aes, 10/14 - bdif, 14/14 - vmapple machine type)
> >   * 14/14 (vmapple machine type):
> >      - Moved compatibility setting for removing legacy mode from
> virtio-pci
> >        to proper global property table rather than (ab)using sugar
> property.
> >      - Removed a few superfluous #includes during sysemu rename cleanup=
.
> >      - Removed machine type versioning as it's not necessary (yet?)
> >      - Made memory map array const
> >
> > XHCI RFC -> v1:
> >
> >   * Gated conditional interrupter mapping support behind a property,
> enabled
> >     that property in the VMApple machine type.
> >   * Added patch to fix the MSI vector assertion failure.
> >   * Moved msi and msix properties from NEC XHCI controller to generic
> xhci-pci
> >     superclass as that also seems useful.
> >   * Broke the workaround up into 2 patches, one for mapping disabling
> required
> >     by the standard, and one for the conditional disabling workaround.
> >
> > XHCI v1 -> v2:
> >
> >   * 1/6: Switch to modulo arithmetic for MSI vector number, as per spec=
.
> >   * 6/6: Set the "conditional-intr-mapping" property via compat_props.
> >   * Commit message tweaks
> >
> > XHCI v2 -> v3:
> >
> >   * 2/6: In line with recent upstream changes, the property table is no=
w
> >     const and no longer carries an end-of-list marker.
> >   * The indentation fix (previously 5/6) has already been merged, so is
> no
> >     longer included.
> >   * Added patch fixing up logging of certain unhandled MMIO cases. (4/6=
)
> >   * 6/6: Moved the compat global property table into vmapple patch set
> -v16;
> >     we now just add the conditional-intr-mapping property to it in this
> >     patch. We also set the property on any device implementing the
> abstract
> >     TYPE_XHCI_PCI rather than only the TYPE_QEMU_XHCI device
> specifically.
> >
> > v16 -> v17
> >
> >   * Rebased on latest upstream (with minor conflict fixes)
> >   * apple-gfx, GPEX, and ui/cocoa patches dropped as they have been
> merged.
> >   * Unmerged patches from xhci series v3 combined into this series.
> >   * vmapple machine type: Explicitly depend on software GICv3.
> >   * vmapple machine type: Enable the new XHCI PCI
> conditional-intr-mapping
> >     property via the machine type's global compat property table.
> >   * Integrated Philippe's patch on renaming the GICv3's confusing confi=
g
> name,
> >     and removing its TCG dependency. (It's needed with HVF too.)
> >   * vmapple machine type: Dropped Tested-by tag because of above change=
s
> >
> >
> > Alexander Graf (7):
> >    hw: Add vmapple subdir
> >    hw/misc/pvpanic: Add MMIO interface
> >    hw/vmapple/aes: Introduce aes engine
> >    hw/vmapple/bdif: Introduce vmapple backdoor interface
> >    hw/vmapple/cfg: Introduce vmapple cfg region
> >    hw/vmapple/virtio-blk: Add support for apple virtio-blk
> >    hw/vmapple/vmapple: Add vmapple machine type
> >
> > Phil Dennis-Jordan (3):
> >    hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec
> >    hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported
> >    hw/usb/hcd-xhci-pci: Adds property for disabling mapping in IRQ mode
> >
> > Philippe Mathieu-Daud=C3=A9 (1):
> >    hw/intc: Remove TCG dependency on ARM_GICV3
> >
> >   MAINTAINERS                         |   8 +
> >   contrib/vmapple/uuid.sh             |   9 +
> >   docs/system/arm/vmapple.rst         |  63 +++
> >   docs/system/target-arm.rst          |   1 +
> >   hw/Kconfig                          |   1 +
> >   hw/block/virtio-blk.c               |  19 +-
> >   hw/core/qdev-properties-system.c    |   8 +
> >   hw/intc/Kconfig                     |   6 +-
> >   hw/intc/meson.build                 |   4 +-
> >   hw/meson.build                      |   1 +
> >   hw/misc/Kconfig                     |   4 +
> >   hw/misc/meson.build                 |   1 +
> >   hw/misc/pvpanic-mmio.c              |  60 +++
> >   hw/usb/hcd-xhci-pci.c               |  25 ++
> >   hw/usb/hcd-xhci-pci.h               |   1 +
> >   hw/usb/hcd-xhci.c                   |   5 +
> >   hw/usb/hcd-xhci.h                   |   5 +
> >   hw/vmapple/Kconfig                  |  32 ++
> >   hw/vmapple/aes.c                    | 581 ++++++++++++++++++++++++++
> >   hw/vmapple/bdif.c                   | 274 ++++++++++++
> >   hw/vmapple/cfg.c                    | 195 +++++++++
> >   hw/vmapple/meson.build              |   5 +
> >   hw/vmapple/trace-events             |  21 +
> >   hw/vmapple/trace.h                  |   1 +
> >   hw/vmapple/virtio-blk.c             | 204 +++++++++
> >   hw/vmapple/vmapple.c                | 618 +++++++++++++++++++++++++++=
+
> >   include/hw/misc/pvpanic.h           |   1 +
> >   include/hw/pci/pci_ids.h            |   1 +
> >   include/hw/qdev-properties-system.h |   5 +
> >   include/hw/virtio/virtio-blk.h      |  11 +-
> >   include/hw/vmapple/vmapple.h        |  23 ++
> >   include/qemu/cutils.h               |  15 +
> >   meson.build                         |   1 +
> >   qapi/virtio.json                    |  14 +
> >   util/hexdump.c                      |  18 +
> >   35 files changed, 2231 insertions(+), 10 deletions(-)
> >   create mode 100755 contrib/vmapple/uuid.sh
> >   create mode 100644 docs/system/arm/vmapple.rst
> >   create mode 100644 hw/misc/pvpanic-mmio.c
> >   create mode 100644 hw/vmapple/Kconfig
> >   create mode 100644 hw/vmapple/aes.c
> >   create mode 100644 hw/vmapple/bdif.c
> >   create mode 100644 hw/vmapple/cfg.c
> >   create mode 100644 hw/vmapple/meson.build
> >   create mode 100644 hw/vmapple/trace-events
> >   create mode 100644 hw/vmapple/trace.h
> >   create mode 100644 hw/vmapple/virtio-blk.c
> >   create mode 100644 hw/vmapple/vmapple.c
> >   create mode 100644 include/hw/vmapple/vmapple.h
> >
>
>

--000000000000486bdc062bbf0d49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 15 Jan =
2025 at 14:05, Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tl=
s.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">13.01.2025 00:00, Phil Dennis-Jordan wrote:<br>
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
<br>
Hi!<br>
<br>
It looks like this patchset has a few bugfixes which aren&#39;t specific to=
<br>
vmapple.=C2=A0 These are already mentioned in this patchset description,<br=
>
namely:<br>
<br>
=C2=A0 hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as per spec<br>
=C2=A0 hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsupported<br>
<br>
Should these be picked up for qemu-stable?<br></blockquote><div><br></div><=
div>They should be pretty low-risk.</div><div><br></div><div>At least the f=
irst one very definitely fixes a bug, albeit obscure, that you can trigger =
in the wild. (Run a macOS guest and turn off MSI-X on the XHCI controller b=
ut leave MSI enabled, and QEMU will crash with a failed assertion.) So sure=
, why not apply this to stable.<br></div><div><br></div><div>I don&#39;t kn=
ow if there are any extant guest OSes where the second patch is a necessary=
 and sufficient fix. macOS will refuse to drive an XHCI controller with num=
intrs &lt; 4 altogether. Other guest OSes I&#39;ve tried never attempt to u=
se more than one interrupter/event ring anyway. However, the patch implemen=
ts the behaviour that is explicitly and clearly described in the spec regar=
ding the situation of unsupported interrupter mapping.</div><div><br></div>=
<div>macOS&#39;s driver needs this behaviour of no interrupter mapping when=
 using pin-based interrupts even on a controller with nominally numintrs &g=
t; 1, so to fix that you additionally need patch 9 and you enable the flag =
implemented in that patch. (I have to admit I&#39;m still not convinced we =
need the flag: in my opinion the spec under-defines the pin-based situation=
 anyway, and I struggle to imagine a sensible use case for the [current] be=
haviour with the flag disabled. More detailed discussion in the original RF=
C thread: <a href=3D"https://patchew.org/QEMU/20241201160316.96121-1-phil@p=
hiljordan.eu/">https://patchew.org/QEMU/20241201160316.96121-1-phil@philjor=
dan.eu/</a> )<div><br></div></div><div>So the macOS compatibility fix for p=
in-based mode needs patches 2+9 and as it stands that introduces a new prop=
erty, which I think disqualifies it from merging into *-stable?<br></div><d=
iv>I&#39;m not sure it&#39;s worth applying patch 2 on its own to any stabl=
e branches.</div><div><br></div><div><div><div>I&#39;m hoping Nick Piggin (=
cc&#39;d) might post an updated and ready to merge version of his=20
patches to upgrade the XHCI qtest suite, as I&#39;d really like to build=20
test cases for these patches on top of that.</div></div></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
<br>
/mjt<br>
<br>
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
&gt;=C2=A0 =C2=A0* The spec requires that modulo arithmetic be used for sel=
ecting<br>
&gt;=C2=A0 =C2=A0 =C2=A0the MSI vector to notify from the interrupter/event=
 ring index.<br>
&gt;=C2=A0 =C2=A0 =C2=A0(Patch 1)<br>
&gt;=C2=A0 =C2=A0* The spec requires that all events be directed at ring 0 =
if<br>
&gt;=C2=A0 =C2=A0 =C2=A0interrupter mapping is not available; the condition=
 for this<br>
&gt;=C2=A0 =C2=A0 =C2=A0mentioned in the spec is when there is only 1 inter=
rupter<br>
&gt;=C2=A0 =C2=A0 =C2=A0available. (Patch 2)<br>
&gt;=C2=A0 =C2=A0* A property is added to the PCI XHCI controller classes t=
o disable<br>
&gt;=C2=A0 =C2=A0 =C2=A0interrupter mapping when using pin-based interrupts=
. This makes<br>
&gt;=C2=A0 =C2=A0 =C2=A0the macOS guest drivers work. (Patch 9) This is ena=
bled in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple machine type, which does not offer MSI(-X) =
support.<br>
&gt; <br>
&gt; There are currently a few limitations to the vmapple machine. These<br=
>
&gt; aren&#39;t intrinsic, just imperfect emulation of the VZF, but it&#39;=
s good<br>
&gt; enough to be just about usable for some purposes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* macOS 12 guests only. Versions 13+ currently fail during=
 early boot.<br>
&gt;=C2=A0 =C2=A0* macOS 11+ arm64 hosts only, with hvf accel. (Perhaps som=
e differences<br>
&gt;=C2=A0 =C2=A0 =C2=A0between Apple M series CPUs and TCG&#39;s aarch64 i=
mplementation? macOS<br>
&gt;=C2=A0 =C2=A0 =C2=A0hosts only because ParavirtualizedGraphics.framewor=
k is a black box<br>
&gt;=C2=A0 =C2=A0 =C2=A0implementing most of the logic behind the apple-gfx=
 device.)<br>
&gt;=C2=A0 =C2=A0* The guest OS must first be provisioned using Virtualizat=
ion.framework;<br>
&gt;=C2=A0 =C2=A0 =C2=A0the disk images can subsequently be used in Qemu. (=
See docs.)<br>
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
&gt; <br>
&gt; ---<br>
&gt; <br>
&gt; v2 -&gt; v3:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Merged the apple-gfx and vmapple patchsets.<br>
&gt;=C2=A0 =C2=A0* Squashed a bunch of later apple-gfx patches into the mai=
n one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0(dGPU support, queried MMIO area size, host GPU pic=
king logic.)<br>
&gt;=C2=A0 =C2=A0* Rebased on latest upstream, fixing any breakages due to =
internal<br>
&gt;=C2=A0 =C2=A0 =C2=A0Qemu API changes.<br>
&gt;=C2=A0 =C2=A0* apple-gfx: Switched to re-entrant MMIO. This is supporte=
d by the<br>
&gt;=C2=A0 =C2=A0 =C2=A0underlying framework and simplifies the MMIO forwar=
ding code which<br>
&gt;=C2=A0 =C2=A0 =C2=A0was previously different on x86-64 vs aarch64.<br>
&gt;=C2=A0 =C2=A0* vmapple: Fixes for minor bugs and comments from the last=
 round of<br>
&gt;=C2=A0 =C2=A0 =C2=A0review.<br>
&gt;=C2=A0 =C2=A0* vmapple aes, conf, apple-gfx: Switched reset methods to =
implement<br>
&gt;=C2=A0 =C2=A0 =C2=A0the ResettableClass base&#39;s interface.<br>
&gt;=C2=A0 =C2=A0* vmapple: switched from virtio-hid to an XHCI USB control=
ler and<br>
&gt;=C2=A0 =C2=A0 =C2=A0USB mouse and tablet devices. macOS does not provid=
e drivers for<br>
&gt;=C2=A0 =C2=A0 =C2=A0virtio HID devices, at least not in version 12&#39;=
s vmapple kernel.<br>
&gt;=C2=A0 =C2=A0 =C2=A0So input now sort of works (interrupt issues) rathe=
r than not<br>
&gt;=C2=A0 =C2=A0 =C2=A0at all. Use network-based remote access to the gues=
t OS as a<br>
&gt;=C2=A0 =C2=A0 =C2=A0work-around.<br>
&gt; <br>
&gt; v3 -&gt; v4:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Complete rework of the mechanism for handling runloop/li=
bdispatch<br>
&gt;=C2=A0 =C2=A0 =C2=A0events on the main thread. PV graphics now work wit=
h the SDL UI.<br>
&gt;=C2=A0 =C2=A0* Renamed &#39;apple-gfx-vmapple&#39; device to &#39;apple=
-gfx-mmio&#39;<br>
&gt;=C2=A0 =C2=A0* hw/display/apple-gfx: threading model overhaul to be mor=
e consistent,<br>
&gt;=C2=A0 =C2=A0 =C2=A0safer, and more QEMU-idiomatic.<br>
&gt;=C2=A0 =C2=A0* display-modes property on the apple-gfx devices now uses=
 the<br>
&gt;=C2=A0 =C2=A0 =C2=A0native array property mechanism and works on both d=
evice variants.<br>
&gt;=C2=A0 =C2=A0* hw/vmapple/aes: Improvements to logging and error handli=
ng.<br>
&gt;=C2=A0 =C2=A0* hw/vmapple/cfg: Bug fixes around device property default=
 values.<br>
&gt;=C2=A0 =C2=A0* hw/vmapple/{aes,cfg,virtio-blk/vmapple}: Most header cod=
e moved into<br>
&gt;=C2=A0 =C2=A0 =C2=A0.c files, only a single vmapple.h now contains the =
#defines for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple machine model-specific device type names.<b=
r>
&gt;=C2=A0 =C2=A0* hw/block/virtio-blk: New patch for replacing virtio_blk_=
free_request<br>
&gt;=C2=A0 =C2=A0 =C2=A0with g_free. (Optional)<br>
&gt;=C2=A0 =C2=A0* Various smaller changes following comments in v3 code re=
view in<br>
&gt;=C2=A0 =C2=A0 =C2=A0apple-gfx, aes, cfg, bdif, virtio-blk-vmapple, and =
the vmapple<br>
&gt;=C2=A0 =C2=A0 =C2=A0machine type itself. See patch-specific v4 change n=
otes for details.<br>
&gt; <br>
&gt; v4 -&gt; v5:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Simplified the main thread runloop mechanism. Back to se=
tting<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_main directly, but narrowing the scope=
 of what it needs to do,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 and it can now be NULL. (Meaning run the QE=
MU main event loop on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 the main thread as is traditional.)<br>
&gt;=C2=A0 =C2=A0* hw/display/apple-gfx: Further improvements to the BH bas=
ed job code bridging<br>
&gt;=C2=A0 =C2=A0 =C2=A0the libdispatch &amp; QEMU thread synchronisation i=
mpedance mismatch.<br>
&gt;=C2=A0 =C2=A0* hw/display/apple-gfx: Thread safety and object lifetime =
improvements.<br>
&gt;=C2=A0 =C2=A0* hw/display/apple-gfx-*: Better buffer and error handling=
 in display mode<br>
&gt;=C2=A0 =C2=A0 =C2=A0property setters and getters.<br>
&gt;=C2=A0 =C2=A0* hw/vmapple/aes: More consistent and safer logging/tracin=
g<br>
&gt;=C2=A0 =C2=A0* hw/vmapple/cfg: Better error reporting on overlong prope=
rty strings.<br>
&gt;=C2=A0 =C2=A0* hw/vmapple/virtio-blk: Fixed theoretically-unaligned wri=
te to config buffer.<br>
&gt;=C2=A0 =C2=A0* vmapple machine type: Moved ecam region into machine sta=
te, improved device<br>
&gt;=C2=A0 =C2=A0 =C2=A0property setting error handling, improved ECID/UUID=
 extraction script and<br>
&gt;=C2=A0 =C2=A0 =C2=A0docs.<br>
&gt;=C2=A0 =C2=A0* Various smaller fixes in apple-gfx/-mmio, apple-gfx-pci,=
 vmapple/aes,<br>
&gt;=C2=A0 =C2=A0 =C2=A0vmapple/cfg, vmapple/virtio-blk, and vmapple machin=
e type.<br>
&gt;=C2=A0 =C2=A0* Added SPDX license identifiers where they were missing.<=
br>
&gt; <br>
&gt; v5 -&gt; v6:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 01/15 (main/Cocoa/runloop): Combined functions, fixed wh=
itespace<br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Further refinement of PVG threading: =
reduced some callback<br>
&gt;=C2=A0 =C2=A0 =C2=A0tasks from BHs to merely acquiring RCU read lock; r=
eplaced some libdispatch<br>
&gt;=C2=A0 =C2=A0 =C2=A0tasks with BHs; last remaining synchronous BH now u=
ses emphemeral<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuSemaphore.<br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Readability improvements and other sm=
aller tweaks<br>
&gt;=C2=A0 =C2=A0 =C2=A0(see patch change notes for details)<br>
&gt;=C2=A0 =C2=A0* 04/15 (display modes): Replaced use of alloca()=C2=A0wit=
h NSMutableArray.<br>
&gt; <br>
&gt; v6 -&gt; v7:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Use g_ptr_array_find() helper functio=
n, coding style tweak<br>
&gt;=C2=A0 =C2=A0* 03/15 (apple-gfx-pci): Removed an unused function parame=
ter<br>
&gt;=C2=A0 =C2=A0* 04/15 (apple-gfx display mode property): Simplified erro=
r handling in<br>
&gt;=C2=A0 =C2=A0 =C2=A0property parsing.<br>
&gt;=C2=A0 =C2=A0* 10/15 (vmapple/aes): Coding style tweaks.<br>
&gt;=C2=A0 =C2=A0* 12/15 (vmapple/cfg): Changed error messages for overrun =
of properties with<br>
&gt;=C2=A0 =C2=A0 =C2=A0fixed-length strings to be more useful to users tha=
n developers.<br>
&gt;=C2=A0 =C2=A0* 15/15 (vmapple machine type): Tiny error handling fix, u=
n-inlined function<br>
&gt; <br>
&gt; v7 -&gt; v8:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Naming and type use improvements, fix=
es for a bug and a<br>
&gt;=C2=A0 =C2=A0 =C2=A0leak.<br>
&gt;=C2=A0 =C2=A0* 04/15 (apple-gfx display mode property): Type use improv=
ement<br>
&gt;=C2=A0 =C2=A0* 10/15 (vmapple/aes): Guest error logging tweaks.<br>
&gt;=C2=A0 =C2=A0* 11/15 (vmapple/bdif): Replaced uses of cpu_physical_memo=
ry_read with<br>
&gt;=C2=A0 =C2=A0 =C2=A0dma_memory_read, and a g_free call with g_autofree.=
<br>
&gt;=C2=A0 =C2=A0* 12/15 (vmapple/cfg): Macro hygiene fix: consistently enc=
losing arguments in<br>
&gt;=C2=A0 =C2=A0 =C2=A0parens.<br>
&gt;=C2=A0 =C2=A0* 15/15 (vmapple machine type): Use less verbose pattern f=
or defining uuid<br>
&gt;=C2=A0 =C2=A0 =C2=A0property.<br>
&gt; <br>
&gt; v8 -&gt; v9:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 01/16 (ui &amp; main loop): Set qemu_main to NULL for GT=
K UI as well.<br>
&gt;=C2=A0 =C2=A0* 02/16 (apple-gfx): Pass device pointer to graphic_consol=
e_init(), various<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 non-functional changes.<br>
&gt;=C2=A0 =C2=A0* 03/16 (apple-gfx-pci): Fixup of changed common call, whi=
tespace and comment<br>
&gt;=C2=A0 =C2=A0 =C2=A0formatting tweaks.<br>
&gt;=C2=A0 =C2=A0* 04/16 (apple-gfx display modes): Re-ordered type definit=
ions so we can drop<br>
&gt;=C2=A0 =C2=A0 =C2=A0a &#39;struct&#39; keyword.<br>
&gt;=C2=A0 =C2=A0* 10/16 (vmapple/aes): Replaced a use of cpu_physical_memo=
ry_write with<br>
&gt;=C2=A0 =C2=A0 =C2=A0dma_memory_write, minor style tweak.<br>
&gt;=C2=A0 =C2=A0* 11/16 (vmapple/bdif): Replaced uses of cpu_physical_memo=
ry_write with<br>
&gt;=C2=A0 =C2=A0 =C2=A0dma_memory_write.<br>
&gt;=C2=A0 =C2=A0* 13/16 (vmapple/virtio-blk): Correctly specify class_size=
 for<br>
&gt;=C2=A0 =C2=A0 =C2=A0VMAppleVirtIOBlkClass.<br>
&gt;=C2=A0 =C2=A0* 15/16 (vmapple machine type): Documentation improvements=
, fixed variable<br>
&gt;=C2=A0 =C2=A0 =C2=A0name and struct field used during pvpanic device cr=
eation.<br>
&gt;=C2=A0 =C2=A0* 16/16 (NEW/RFC vmapple/virtio-blk): Proposed change to r=
eplace type hierarchy<br>
&gt;=C2=A0 =C2=A0 =C2=A0with a variant property. This seems cleaner and les=
s confusing than the<br>
&gt;=C2=A0 =C2=A0 =C2=A0original approach to me, but I&#39;m not sure if it=
 warrants creation of a new<br>
&gt;=C2=A0 =C2=A0 =C2=A0QAPI enum and property type definition.<br>
&gt; <br>
&gt; v9 -&gt; v10:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 01/15 (ui &amp; main loop): Added comments to qemu_main =
declaration and GTK.<br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Reworked the way frame rendering code=
 is threaded to use<br>
&gt;=C2=A0 =C2=A0 =C2=A0BHs for sections requiring BQL.<br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Fixed ./configure error on non-macOS =
platforms.<br>
&gt;=C2=A0 =C2=A0* 10/15 (vmapple/aes): Code style and comment improvements=
.<br>
&gt;=C2=A0 =C2=A0* 12/15 (vmapple/cfg): Slightly tidier error reporting for=
 overlong property<br>
&gt;=C2=A0 =C2=A0 =C2=A0values.<br>
&gt;=C2=A0 =C2=A0* 13/15 (vmapple/virtio-blk): Folded v9 patch 16/16 into t=
his one, changing<br>
&gt;=C2=A0 =C2=A0 =C2=A0the device type design to provide a single device t=
ype with a variant<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 property instead of 2 different subtypes fo=
r aux and root volumes.<br>
&gt;=C2=A0 =C2=A0* 15/15 (vmapple machine type): Documentation fixup for ch=
anged virtio-blk<br>
&gt;=C2=A0 =C2=A0 =C2=A0device type; small improvements to shell commands i=
n documentation;<br>
&gt;=C2=A0 =C2=A0 =C2=A0improved propagation of errors during cfg device in=
stantiation.<br>
&gt; <br>
&gt; v10 -&gt; v11:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 01/15 (ui &amp; main loop): Simplified main.c, better co=
mments &amp; commit message<br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Give each PV display instance a uniqu=
e serial number.<br>
&gt;=C2=A0 =C2=A0* 02 &amp; 03/15 (apple-gfx, -pci): Formatting/style tweak=
s<br>
&gt;=C2=A0 =C2=A0* 15/15 (vmapple machine type): Improvements to shell code=
 in docs<br>
&gt; <br>
&gt; v11 -&gt; v12:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 01/15 (ui &amp; main loop): More precise wording of code=
 comments.<br>
&gt;=C2=A0 =C2=A0* 02/15 (apple-gfx): Fixed memory management regressions i=
ntroduced in v10;<br>
&gt;=C2=A0 =C2=A0 =C2=A0improved error handling; various more conmetic code=
 adjustments<br>
&gt;=C2=A0 =C2=A0* 09/15 (GPEX): Fixed uses of deleted GPEX_NUM_IRQS consta=
nt that have been<br>
&gt;=C2=A0 =C2=A0 =C2=A0added to QEMU since this patch was originally writt=
en.<br>
&gt; <br>
&gt; v12 -&gt; v13:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 15/15 (vmapple machine type): Bumped the machine type ve=
rsion from 9.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0to 10.0.<br>
&gt;=C2=A0 =C2=A0* All patches in the series now have been positively revie=
wed and received<br>
&gt;=C2=A0 =C2=A0 =C2=A0corresponding reviewed-by tags.<br>
&gt; <br>
&gt; v13 -&gt; v14:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 6/15 (hw/vmapple directory): Changed myself from reviewe=
r<br>
&gt;=C2=A0 =C2=A0 =C2=A0to maintainer, as that seemed appropriate at this p=
oint.<br>
&gt;=C2=A0 =C2=A0* 15/15 (vmapple machine type): Gate creation of XHCI and<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0USB HID devices behind if (defaults_enabled()).<br>
&gt; <br>
&gt; v14 -&gt; v15<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Constified property tables to match Richard Henderson&#3=
9;s recent project-<br>
&gt;=C2=A0 =C2=A0 =C2=A0wide convention change. (patches 4/15, 7/15, 11/15,=
 12/15, &amp; 13/15)<br>
&gt; <br>
&gt; v15 -&gt; v16<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 14 patches now, as patch 8 has already been pulled. (Tha=
nks Philippe!)<br>
&gt;=C2=A0 =C2=A0* Fixed a bunch of conflicts with upstream code motion:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 - DEFINE_PROP_END_OF_LIST removal (4/14 - apple-gf=
x mode list, 7/14 -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 pvpanic-mmio, 10/14 - bdif, 11/14 - cfg dev=
ice, and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 12/14 - vmapple-virtio-blk)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - sysemu-&gt;system move/rename: (1/14 - ui/qemu-m=
ain, 2/14 - apple-gfx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 9/14 - aes, 10/14 - bdif, 14/14 - vmapple m=
achine type)<br>
&gt;=C2=A0 =C2=A0* 14/14 (vmapple machine type):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Moved compatibility setting for removing legacy =
mode from virtio-pci<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 to proper global property table rather than=
 (ab)using sugar property.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed a few superfluous #includes during sysem=
u rename cleanup.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Removed machine type versioning as it&#39;s not =
necessary (yet?)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Made memory map array const<br>
&gt; <br>
&gt; XHCI RFC -&gt; v1:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Gated conditional interrupter mapping support behind a p=
roperty, enabled<br>
&gt;=C2=A0 =C2=A0 =C2=A0that property in the VMApple machine type.<br>
&gt;=C2=A0 =C2=A0* Added patch to fix the MSI vector assertion failure.<br>
&gt;=C2=A0 =C2=A0* Moved msi and msix properties from NEC XHCI controller t=
o generic xhci-pci<br>
&gt;=C2=A0 =C2=A0 =C2=A0superclass as that also seems useful.<br>
&gt;=C2=A0 =C2=A0* Broke the workaround up into 2 patches, one for mapping =
disabling required<br>
&gt;=C2=A0 =C2=A0 =C2=A0by the standard, and one for the conditional disabl=
ing workaround.<br>
&gt; <br>
&gt; XHCI v1 -&gt; v2:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 1/6: Switch to modulo arithmetic for MSI vector number, =
as per spec.<br>
&gt;=C2=A0 =C2=A0* 6/6: Set the &quot;conditional-intr-mapping&quot; proper=
ty via compat_props.<br>
&gt;=C2=A0 =C2=A0* Commit message tweaks<br>
&gt; <br>
&gt; XHCI v2 -&gt; v3:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* 2/6: In line with recent upstream changes, the property =
table is now<br>
&gt;=C2=A0 =C2=A0 =C2=A0const and no longer carries an end-of-list marker.<=
br>
&gt;=C2=A0 =C2=A0* The indentation fix (previously 5/6) has already been me=
rged, so is no<br>
&gt;=C2=A0 =C2=A0 =C2=A0longer included.<br>
&gt;=C2=A0 =C2=A0* Added patch fixing up logging of certain unhandled MMIO =
cases. (4/6)<br>
&gt;=C2=A0 =C2=A0* 6/6: Moved the compat global property table into vmapple=
 patch set -v16;<br>
&gt;=C2=A0 =C2=A0 =C2=A0we now just add the conditional-intr-mapping proper=
ty to it in this<br>
&gt;=C2=A0 =C2=A0 =C2=A0patch. We also set the property on any device imple=
menting the abstract<br>
&gt;=C2=A0 =C2=A0 =C2=A0TYPE_XHCI_PCI rather than only the TYPE_QEMU_XHCI d=
evice specifically.<br>
&gt; <br>
&gt; v16 -&gt; v17<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Rebased on latest upstream (with minor conflict fixes)<b=
r>
&gt;=C2=A0 =C2=A0* apple-gfx, GPEX, and ui/cocoa patches dropped as they ha=
ve been merged.<br>
&gt;=C2=A0 =C2=A0* Unmerged patches from xhci series v3 combined into this =
series.<br>
&gt;=C2=A0 =C2=A0* vmapple machine type: Explicitly depend on software GICv=
3.<br>
&gt;=C2=A0 =C2=A0* vmapple machine type: Enable the new XHCI PCI conditiona=
l-intr-mapping<br>
&gt;=C2=A0 =C2=A0 =C2=A0property via the machine type&#39;s global compat p=
roperty table.<br>
&gt;=C2=A0 =C2=A0* Integrated Philippe&#39;s patch on renaming the GICv3&#3=
9;s confusing config name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0and removing its TCG dependency. (It&#39;s needed w=
ith HVF too.)<br>
&gt;=C2=A0 =C2=A0* vmapple machine type: Dropped Tested-by tag because of a=
bove changes<br>
&gt; <br>
&gt; <br>
&gt; Alexander Graf (7):<br>
&gt;=C2=A0 =C2=A0 hw: Add vmapple subdir<br>
&gt;=C2=A0 =C2=A0 hw/misc/pvpanic: Add MMIO interface<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/aes: Introduce aes engine<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/bdif: Introduce vmapple backdoor interface<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/cfg: Introduce vmapple cfg region<br>
&gt;=C2=A0 =C2=A0 hw/vmapple/virtio-blk: Add support for apple virtio-blk<b=
r>
&gt;=C2=A0 =C2=A0 hw/vmapple/vmapple: Add vmapple machine type<br>
&gt; <br>
&gt; Phil Dennis-Jordan (3):<br>
&gt;=C2=A0 =C2=A0 hw/usb/hcd-xhci-pci: Use modulo to select MSI vector as p=
er spec<br>
&gt;=C2=A0 =C2=A0 hw/usb/hcd-xhci-pci: Use event ring 0 if mapping unsuppor=
ted<br>
&gt;=C2=A0 =C2=A0 hw/usb/hcd-xhci-pci: Adds property for disabling mapping =
in IRQ mode<br>
&gt; <br>
&gt; Philippe Mathieu-Daud=C3=A9 (1):<br>
&gt;=C2=A0 =C2=A0 hw/intc: Remove TCG dependency on ARM_GICV3<br>
&gt; <br>
&gt;=C2=A0 =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 =C2=A0contrib/vmapple/uuid.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A09 +<br>
&gt;=C2=A0 =C2=A0docs/system/arm/vmapple.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 63 +++<br>
&gt;=C2=A0 =C2=A0docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/block/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 19 +-<br>
&gt;=C2=A0 =C2=A0hw/core/qdev-properties-system.c=C2=A0 =C2=A0 |=C2=A0 =C2=
=A08 +<br>
&gt;=C2=A0 =C2=A0hw/intc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 =C2=A0hw/intc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0hw/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 =C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/misc/pvpanic-mmio.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 60 +++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 25 ++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci-pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-xhci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 32 ++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/aes.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 581 ++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/bdif.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 274 ++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/cfg.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 195 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 21 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/vmapple/virtio-blk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 204 +++++++++<br>
&gt;=C2=A0 =C2=A0hw/vmapple/vmapple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 618 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/misc/pvpanic.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/pci/pci_ids.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0include/hw/qdev-properties-system.h |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0include/hw/virtio/virtio-blk.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 11 +-<br>
&gt;=C2=A0 =C2=A0include/hw/vmapple/vmapple.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 23 ++<br>
&gt;=C2=A0 =C2=A0include/qemu/cutils.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 15 +<br>
&gt;=C2=A0 =C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0qapi/virtio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
&gt;=C2=A0 =C2=A0util/hexdump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
&gt;=C2=A0 =C2=A035 files changed, 2231 insertions(+), 10 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100755 contrib/vmapple/uuid.sh<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/system/arm/vmapple.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/misc/pvpanic-mmio.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/Kconfig<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/aes.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/bdif.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/cfg.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/meson.build<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/trace-events<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/trace.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/virtio-blk.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/vmapple/vmapple.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/vmapple/vmapple.h<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000486bdc062bbf0d49--

