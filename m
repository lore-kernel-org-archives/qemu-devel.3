Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D123ACD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKu3T-00086f-Rf; Thu, 07 May 2026 04:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKu3S-00086O-2N
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKu3P-0002FG-L9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778142354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mMj7pbWg94xgyeLU5D1oCuH2dps3RMkdKTnfJCyvYg=;
 b=CjJL2zOm5ox2bVu5kank7jMAmro3XXo/2J/I/l5Kbe8kclNndMoP++DuDihQl5DIVUVsSV
 X52AaYRtepImbtTAZ7qWeNM9dYyH8RswibibPowcKIdDgmh/pL/tXpWHspSU99b5Pu+FPe
 dloFsNMtXUBiZBOBJ5fter33AmT6QGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-g7KOFEI9OkOTOVEmtWDehw-1; Thu,
 07 May 2026 04:25:51 -0400
X-MC-Unique: g7KOFEI9OkOTOVEmtWDehw-1
X-Mimecast-MFC-AGG-ID: g7KOFEI9OkOTOVEmtWDehw_1778142350
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E37F1800343; Thu,  7 May 2026 08:25:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15B351953947; Thu,  7 May 2026 08:25:48 +0000 (UTC)
Date: Thu, 7 May 2026 09:25:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 08/10] .agents/skills: add qemu-issue-triage agent
 skill
Message-ID: <afxMiS7Y5RIXPLUz@redhat.com>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-9-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505170105.228162-9-alex.bennee@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 05, 2026 at 06:01:03PM +0100, Alex Bennée wrote:
> While triaging the issue tracker I wondered if this would be a
> suitable job for an AI agent. Unfortunately the OSS program doesn't
> give any credits to run agents in gitlab. However I do have access to
> models from my editor and ECA so I built one and tested it on a few
> issues.
> 
> Obviously this can't apply as is because it probably encodes too much
> of my local setup (using pass for API keys) and uses the ECA as my
> preferred coding agent. I assume at some point there will be agreement
> between all the agents where skill live.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

..snip..

> diff --git a/.agents/skills/qemu-issue-triage/assets/labels.txt b/.agents/skills/qemu-issue-triage/assets/labels.txt
> new file mode 100644
> index 00000000000..d329f34183d
> --- /dev/null
> +++ b/.agents/skills/qemu-issue-triage/assets/labels.txt

Seeing our labels listed like this triggers my urge to "tidy" :-)

Don't take anything below to be a complaint / blocker about this patch.
This patch is fine in so much as it faithfully represents the mess we
have created in gitlab.

> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +ACPI                       Power Management related (ACPI / SMBIOS / HEST / GHES)
> +Audio                      Audio devices; both backend (host audio) and frontend (guest audio)

Mixing frontend and backend is a bad idea in general IMHO.

I feel like we should also have an explicit label for each backend, for
both audio and every other backend type.

> +Audit Tooling              A group for bugs and issues found via automated tooling such as fuzzing, sanitizers or AI
> +Audit Tooling::AI          For bugs found with AI assisted tools such as Mythos and other similar things
> +Audit Tooling::Fuzzer      Issues found via fuzzing. For security issues, please consult https://www.qemu.org/contribute/security-process/
> +Audit Tooling::Sanitizer   For issues found using sanitizers such as asan, lsan and tsan

Labels with "::" are mutually exculsive, which is possibly not
what we want here ?  Should the first thing be 'Audit Tooling::Other'
instead of unqualified ?

> +Bite Sized                 Candidates for first contributions; see also https://wiki.qemu.org/Contribute/BiteSizedTasks
> +Build System               configure, make, Meson, ninja, gcc, clang, ccache, etc.
> +CI                         Continuous Integration; gitlab, travis, patchew, etc.
> +CLI                        Command Line Interface
> +Chardev                    Character device backends and related issues

We should have per-backend labels

> +Closed::Duplicate          There is already another ticket that is about the same issue
> +Closed::Fixed              The issue was fixed. Yay!
> +Closed::Invalid            This issue was not really a problem
> +Closed::NotOurBug          This is a bug, but not a bug in QEMU. Please report it and/or include a link to the report.
> +Closed::NotReproducible    This issue was not reproducible
> +Closed::UnbackedFeature    Nobody was willing to work on this feature request
> +Closed::WontFix            The issue was acknowledged, but the fix would be too complex, too expensive, or would introduce other problems.
> +Cryptography
> +Documentation              Sphinx documentation, man pages, the wiki, --help output, etc.
> +GDB                        Issues relating to using GDB via the gdbstub
> +GUI                        Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
> +GUI::Cocoa                 Cocoa
> +GUI::DBus                  DBus
> +GUI::GTK
> +GUI::SDL                   SDL
> +GUI::SPICE                 SPICE

spice is duplicated later

> +GUI::VNC

I'd probably suggest "ui" as the prefix to match the dir / subsystem
name.

Also probably use ":" instead of "::" as there could be cases where
a bug affects multiple UIs.

> +Guest Agent                Issues related to the qemu-guest-agent binary. https://wiki.qemu.org/Features/GuestAgent
> +Hard
> +Launchpad                  Issues migrated from Launchpad
> +Migration

Surprised we don't want more categories here

> +Modules
> +Networking
> +Python                     Python library issues (./python/)
> +QAPI/QMP                   QEMU API / QEMU Machine Protocol, HMP and CLI, etc.
> +QOM                        QEMU Object Model
> +Regression
> +Security
> +Semihosting                Semihosting calls provide a simple ABI for early bring-up of embedded devices and provide a way to output to the console and do basic file i/o while being debugged
> +Softfloat                  QEMU's FPU emulation code (TCG only)
> +Stable::can't fix          The bug was reported on a stable branch but the fix is too invasive for backporting
> +Stable::obsolete           The bug was reported on a stable branch that is not maintained anymore
> +Stable::to backport        The bug was reported on a stable branch and needs to be backported on the next release from the branch
> +Storage                    Block subsystem, Storage devices, etc.
> +TCG plugins                Anything related to the TCG plugins feature

Perhaps accel:tcg:plugins ?

> +TestCase                   The report includes a testcase
> +Tests                      qtests, iotests, acceptance tests, VM tests, docker tests, and more.
> +USB
> +VFIO

This annoying sorting of all uppercase, then all lowercase is
present in the gitlab UI too

https://gitlab.com/qemu-project/qemu/-/labels

We should probalby be universally lowercase, so that sorting is
sensible.

> +accel: HAX                 Intel's Hardware Accelerated Execution Manager (HAXM)
> +accel: HVF                 Apple Hypervisor Framework
> +accel: KVM                 Linux Kernel-based Virtual Machine
> +accel: TCG                 QEMU Tiny Code Generator
> +accel: WHPX                Microsoft Windows Hypervisor Platform (WHPX)
> +accel: Xen                 Xen Hypervisor

We're inconsistent in whether we use a space after ":". Here we do,
below we don't.

> +block:9p                   The 9p network file system
> +block:NVMe

These two are not like the others under 'block:'. 'NVMe' is frontend device,
and 9p is a filesystem. I'd assume 'block:' applies to block/*.c

> +block:curl
> +block:nbd
> +block:nfs                  Issues related to the NFS backend
> +block:qcow2
> +block:ssh
> +block:vmdk

Probably want a "block:core" for stuff not specific to one of the listed
backends.

> +bsd-user
> +device: PCI
> +device: TPM                Trusted Platform Module (TPM) devices
> +device:graphics            Issues relating to display device emulation, or rendering in general. See also "GUI".
> +device:input               Keyboards, Mice, Touchscreens, HIDs, etc.
> +device:iommu               IOMMU and SMMU
> +device:pflash              Parallel NOR flashes emulation
> +device:sdmmc               SD or (e)MMC cards emulation
> +device:virtio              virtio-related issues. https://www.linux-kvm.org/page/Virtio
> +device:watchdog

Here we sometimes have a space after : and sometimes don't


> +efi                        EFI firmware related issues
> +flaky-ci                   For test cases that are flaky when run under our CI
> +gitlab

So should we be using "CI" or "gitlab" for CI issues :)

Probably we should have:

  ci:gitlab
  ci:flaky

> +guest: AIX
> +guest: BSD                 Guest OS is BSD (NetBSD/FreeBSD/OpenBSD/etc)
> +guest: Linux               Guest OS is Linux/Linux-based
> +guest: Windows             Microsoft Windows guest
> +guest: macOS               Apple macOS / Darwin as  guest OS
> +guest: os2
> +host: aarch64              Bugs reproducible on AArch64 hosts
> +host: arm                  Bugs reproducible on ARM hosts
> +host: loongarch64          Bugs reproducible on LoongArch64 hosts.
> +host: mips                 Bugs reproducible on MIPS hosts
> +host: ppc                  Bugs reproducible on Power hosts
> +host: riscv                Bugs reproducible on RISC-V hosts
> +host: s390                 Bugs reproducible on s390 hosts
> +host: sparc64              Bugs specific to Sparc64 hosts
> +host: x86                  Bugs reproducible on x86 hosts
> +host:32bit                 These are mostly TCG related bugs where we sometimes struggle with emulating larger guests, especially atomic and address space issues.

More space inconsistency

> +hostos: BSD                FreeBSD, OpenBSD, NetBSD, and derivatives as host OSes
> +hostos: Linux              Linux-based host operating systems (Fedora, RHEL/CentOS, Debian, Ubuntu, openSuSE et al)
> +hostos: Windows            Microsoft Windows host OS
> +hostos: macOS              Apple macOS / Darwin as a host OS
> +icount                     issues relating to icount, deterministic execution and record/replay functionality

Perhaps accel:tcg:icount  ?

> +kind: Not user visible

What's this for, and why : instead of :: ? 

> +kind::Bug                  Bug or defect in functionality.
> +kind::Feature Request      Feature request or new functionality.
> +kind::Task                 Research, investigations, and miscellaneous issues.
> +libvfio-user
> +linux-user
> +qemu-img

Should we have a "tools:qemu-img", and "tools:...." for everything
else too ?

> +spice

Redundant with 'GUI::SPICE"

> +sysadmin

Any idea what this is supposed to refer to ?

> +target: alpha              DEC Alpha [alpha]
> +target: arm                Arm AArch32 or AArch64 [arm, aarch64]
> +target: avr                Atmel AVR [avr]
> +target: hexagon            Qualcomm Hexagon [hexagon]
> +target: hppa               Hewlett-Packard Precision Architecture; HP/HP, PA-RISC [hppa]
> +target: i386               Intel/AMD x86 [i386, x86_64]
> +target: loongarch          loongarch64 target architecture
> +target: m68k               Motorola 68000 [m68k]
> +target: microblaze         Xilinx MicroBlaze [microblaze, microblazeel]
> +target: mips               MIPS [mips, mipsel, mips64, mips64el]
> +target: nios2              Altera Nios II [nios2]
> +target: openrisc           OpenRISC [or1k]
> +target: ppc                IBM Power Architecture, PowerPC [ppc, ppc64, ppc64le]
> +target: riscv              RISC-V [riscv32, riscv64]
> +target: rx                 Renesas RX [rx]
> +target: s390x              IBM Z, SystemZ, zSeries [s390x]
> +target: sh4                Renesas SuperH [sh4, sh4eb]
> +target: sparc              Sun Microsystems SPARC [sparc, sparc64]
> +target: tricore            Infineon TriCore [tricore]
> +target: xtensa             Tensilica Xtensa [xtensa, xtensaeb]
> +workflow::Confirmed        Bugs that have been confirmed and reproduced.
> +workflow::In Progress      Someone is working on this issue.
> +workflow::Needs Info       Issue has insufficient information to verify.
> +workflow::Patch available  A patch is available
> +workflow::Triaged          Issue has been triaged and given a topic label.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


