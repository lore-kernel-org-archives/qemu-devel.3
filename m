Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D35BC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 02:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsYPm-0006ZR-3v; Wed, 12 Mar 2025 22:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsYPj-0006XV-MH; Wed, 12 Mar 2025 22:35:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tsYPg-0004Hi-WB; Wed, 12 Mar 2025 22:35:15 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso772135a12.3; 
 Wed, 12 Mar 2025 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741833310; x=1742438110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTTn6pz4LW3EQDES7YJ07/wsir7N5L7Bh8t1U8KGmCw=;
 b=jwBlGfwAqqHXH/djsDbs05Ou3kOr1TJJ+ACenWT4RRTMTduwPJ8HCi873DWyJd91lh
 bYbnOgwIRgTRjJdHcRWrR3D9E92SiPnbYiXtJHcfwNR/0sKWjXsXPlUEkc+nCvVTc0i5
 4Iyxkhx+H8OHn9qnuoSGqWyU4s7XUFJ8tO7ezl4HjyEt9sx2Aj0saMp4APsJY8teMy95
 xcZjcqCAoiNJaGR7H0XJPaRgiVWGTKOepQ9M2tieMO6tOO6UIaNVjL58NCAy+y4kAsr0
 W+0pv4kyjW2NmBG76/BeSLcWkMVQt+5BJ2M+maZYBTZYC5l7UGYWGmGCjNWEWMl2K1sQ
 SeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741833310; x=1742438110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTTn6pz4LW3EQDES7YJ07/wsir7N5L7Bh8t1U8KGmCw=;
 b=L6SFpt7RfyTTjUcmKkwo4f0daQXqCE7wkNkwFRwWSxAV9xOyGMWXbzOv8oLAZmo7ph
 b0bloCnvgLlVwtTJMNcMHwFUSedqVBkOM/xuJqVg+DtgIqUMjgS7Iit4vhXK2OXsX5jp
 U7rGNgRIYWNymF6zAakd9qzAMhDrZBx9b6eCGbm4GWO20aKL0bPx4dAH/EvKjvp1EiJZ
 uqnnqr9qkvzCw5+Os4UNcPB+lM7/i1nKi5DljtI3lf2JEJ51tfonVzTQEgBS4ioLV8N0
 dTXHGUwE7DEDE7ebMThs6EqS7Jt39TYxggxEbDUCwEvd5oA8wvoCYNDXe7ihWdiTs0Jd
 mx9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/2WBh6C0CnRvwo5grhjC4q/lWPwcYA4NFUWpCfQtPlb01Y7DAY68wrZTGm3d0ErwCeH7vdncD/g==@nongnu.org
X-Gm-Message-State: AOJu0Yz+ZyYw79VY8ZWYw0wSY5wI1GUidcWMB+IsePfT1VBSy2ST9Gcg
 ppkywpAKRQdn+LjQq2gnJUSXX8zeoUOAqPeTSQIIG8u/CxQurcTuWyXqA53PotbX8fCPpSsHWMF
 T2LE6xA4vWCN6egt5rso5xkkwO7s=
X-Gm-Gg: ASbGncsz1LPouIPPwTccIDRkm00rR0j2l6oIAxuEq6nco+3XrwKLMt0kT0ynVa6ullD
 PUsvHz5XZy0HBGfi/ere/bq5tVpS3fkZOuhELpF+yplRBl2RPAA6GvpRJBQvfAXnsZvOA6HzKoy
 WpdRyMkZODBJeDYtToGAMvp5ITfTBArVRfR9xy
X-Google-Smtp-Source: AGHT+IFki0RzdFEbrtZimlwZFPGtisRPpek+N/7MSrK6Oupgq4I13pPPgP2mnwIroFQByAtm4gYLfe+qzfvl+Dy6zzg=
X-Received: by 2002:a05:6402:42c4:b0:5e4:d192:2373 with SMTP id
 4fb4d7f45d1cf-5e5e22bf631mr28193641a12.10.1741833309786; Wed, 12 Mar 2025
 19:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250311125815.903177-1-npiggin@gmail.com>
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Mar 2025 10:34:57 +0800
X-Gm-Features: AQ5f1JoxoNzIBW_jpGbGj3lYjJvIwqizPiGdaOaCK-LyOSVJva-iDrVVxlYwRfw
Message-ID: <CAJSP0QWLW+YwsLeJ1496Q8uT92E3wUDsOiVyzVFwrOFid3FUWA@mail.gmail.com>
Subject: Re: [PULL 00/72] ppc-for-10.0-1 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 11, 2025 at 8:59=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da=
32:
>
>   Merge tag 'migration-20250310-pull-request' of https://gitlab.com/faros=
as/qemu into staging (2025-03-11 09:32:07 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-10.0-1-20250311
>
> for you to fetch changes up to 0f17ae24b53eaab4bbe9cfab267c536e2f7fdbd7:
>
>   docs/system/ppc/amigang.rst: Update for NVRAM emulation (2025-03-11 22:=
43:32 +1000)
>
> ----------------------------------------------------------------
> * amigaone enhancements, NVRAM and kernel/initrd support
> * Next round of XIVE group/crowd changes
> * SPI updates for powernv
> * Power10 2nd DAWR support for powernv and spapr
> * powernv HOMER/OCC fixes and improvements for power management
> * powernv PNOR support
> * Big cleanup to move TCG code under ifdef or into its own file
> * Update SLOF and skiboot ROMs
> * Remove 405 boards and deprecate 405 CPU
> * Add support for nested KVM "hostwide state" data.

I fixed a CI failure on FreeBSD 14 hosts because of the __packed macro
redefinition in hw/ppc/pnv_occ.c:
https://gitlab.com/qemu-project/qemu/-/jobs/9388495246#L5857

Here is my fix in the merge commit, if you prefer a different fix,
please send a follow-up commit:
diff --git i/hw/ppc/pnv_occ.c w/hw/ppc/pnv_occ.c
index d9ce35a4d6..bda6b23ad3 100644
--- i/hw/ppc/pnv_occ.c
+++ w/hw/ppc/pnv_occ.c
@@ -394,7 +394,9 @@ type_init(pnv_occ_register_types);
 #define s64 int64_t
 #define __be16 uint16_t
 #define __be32 uint32_t
+#ifndef __packed
 #define __packed QEMU_PACKED
+#endif /* !__packed */

 /**
  * OCC-OPAL Shared Memory Region

Stefan

>
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>
> BALATON Zoltan (6):
>       ppc/amigaone: Simplify replacement dummy_fw
>       ppc/amigaone: Implement NVRAM emulation
>       ppc/amigaone: Add default environment
>       ppc/amigaone: Add kernel and initrd support
>       ppc/amigaone: Add #defines for memory map constants
>       docs/system/ppc/amigang.rst: Update for NVRAM emulation
>
> Chalapathi V (4):
>       hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
>       hw/ssi/pnv_spi: Use local var seq_index instead of get_seq_index().
>       hw/ssi/pnv_spi: Make bus names distinct for each controllers of a s=
ocket
>       hw/ssi/pnv_spi: Put a limit to RDR match failures
>
> C=C3=A9dric Le Goater (3):
>       ppc/ppc405: Remove tests
>       ppc/ppc405: Remove boards
>       hw/ppc: Deprecate 405 CPUs
>
> Frederic Barrat (10):
>       ppc/xive2: Update NVP save/restore for group attributes
>       ppc/xive2: Add grouping level to notification
>       ppc/xive2: Support group-matching when looking for target
>       ppc/xive2: Add undelivered group interrupt to backlog
>       ppc/xive2: Process group backlog when pushing an OS context
>       ppc/xive2: Process group backlog when updating the CPPR
>       qtest/xive: Add group-interrupt test
>       ppc/xive2: Add support for MMIO operations on the NVPG/NVC BAR
>       ppc/xive2: Support crowd-matching when looking for target
>       ppc/xive2: Check crowd backlog when scanning group backlog
>
> Glenn Miles (3):
>       pnv/xive2: Rename nvp_ to nvx_ if they can refer to NVP or NVGC
>       qtest/xive: Change printf to g_test_message
>       qtest/xive: Add test of pool interrupts
>
> Michael Kowal (1):
>       ppc/xive: Rename ipb_to_pipr() to xive_ipb_to_pipr()
>
> Nicholas Piggin (22):
>       ppc/pnv: Update skiboot to 7.1-106
>       ppc/pnv/phb4: Add pervasive chiplet support to PHB4/5
>       ppc/pnv/homer: Fix OCC registers
>       ppc/pnv/homer: Make dummy reads return 0
>       ppc/pnv/occ: Fix common area sensor offsets
>       ppc/pnv/homer: class-based base and size
>       ppc/pnv/occ: Better document OCCMISC bits
>       ppc/pnv: Make HOMER memory a RAM region
>       ppc/pnv/occ: Update pstate frequency tables
>       ppc/pnv/occ: Add POWER10 OCC-OPAL data format
>       ppc/pnv/occ: Implement a basic dynamic OCC model
>       target/ppc: Add Power9/10 power management SPRs
>       ppc/pnv: Support LPC host controller irqs other than serirqs
>       ppc/pnv: raise no-response errors if an LPC transaction fails
>       ppc/pnv: Implement LPC FW address space IDSEL
>       ppc/pnv: Move PNOR to offset 0 in the ISA FW space
>       ppc/pnv: Add a PNOR address and size sanity checks
>       ppc/pnv: Add a default formatted PNOR image
>       target/ppc: fix timebase register reset state
>       target/ppc: Wire up BookE ATB registers for e500 family
>       target/ppc: Avoid warning message for zero process table entries
>       spapr: Generate random HASHPKEYR for spapr machines
>
> Philippe Mathieu-Daud=C3=A9 (18):
>       hw/ppc/spapr: Restrict CONFER hypercall to TCG
>       target/ppc: Make ppc_ldl_code() declaration public
>       target/ppc: Move TCG specific exception handlers to tcg-excp_helper=
.c
>       target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
>       target/ppc: Ensure powerpc_mcheck_checkstop() is only called under =
TCG
>       target/ppc: Restrict powerpc_checkstop() to TCG
>       target/ppc: Remove raise_exception_ra()
>       target/ppc: Restrict exception helpers to TCG
>       target/ppc: Restrict various common helpers to TCG
>       target/ppc: Fix style in excp_helper.c
>       target/ppc: Make powerpc_excp() prototype public
>       target/ppc: Restrict ATTN / SCV / PMINSN helpers to TCG
>       hw/ppc/spapr: Convert HPTE() macro as hpte_get_ptr() method
>       hw/ppc/spapr: Convert HPTE_VALID() macro as hpte_is_valid() method
>       hw/ppc/spapr: Convert HPTE_DIRTY() macro as hpte_is_dirty() method
>       hw/ppc/spapr: Convert CLEAN_HPTE() macro as hpte_set_clean() method
>       hw/ppc/spapr: Convert DIRTY_HPTE() macro as hpte_set_dirty() method
>       hw/ppc/epapr: Do not swap ePAPR magic value
>
> Shivaprasad G Bhat (2):
>       ppc: Enable 2nd DAWR support on Power10 PowerNV machine
>       ppc: spapr: Enable 2nd DAWR on Power10 pSeries machine
>
> Vaibhav Jain (1):
>       spapr: nested: Add support for reporting Hostwide state counter
>
> dan tan (1):
>       ppc/pnv: Add new PowerPC Special Purpose Registers (RWMR)
>
>  MAINTAINERS                        |    7 +-
>  docs/about/deprecated.rst          |   17 +-
>  docs/about/removed-features.rst    |    7 +
>  docs/system/ppc/amigang.rst        |   17 +-
>  docs/system/ppc/embedded.rst       |    1 -
>  docs/system/ppc/powernv.rst        |    7 +
>  hw/intc/pnv_xive.c                 |   10 +-
>  hw/intc/pnv_xive2.c                |  166 ++++-
>  hw/intc/spapr_xive.c               |    8 +-
>  hw/intc/trace-events               |    6 +-
>  hw/intc/xive.c                     |  205 +++---
>  hw/intc/xive2.c                    |  690 +++++++++++++++++---
>  hw/pci-host/pnv_phb4_pec.c         |   55 +-
>  hw/ppc/Kconfig                     |    9 -
>  hw/ppc/amigaone.c                  |  284 ++++++++-
>  hw/ppc/meson.build                 |    3 -
>  hw/ppc/pnv.c                       |  150 +++--
>  hw/ppc/pnv_bmc.c                   |   28 +
>  hw/ppc/pnv_homer.c                 |  230 ++-----
>  hw/ppc/pnv_lpc.c                   |   89 +--
>  hw/ppc/pnv_occ.c                   |  670 +++++++++++++++++++-
>  hw/ppc/ppc.c                       |   11 +-
>  hw/ppc/ppc405.h                    |  186 ------
>  hw/ppc/ppc405_boards.c             |  520 ---------------
>  hw/ppc/ppc405_uc.c                 | 1216 ------------------------------=
------
>  hw/ppc/sam460ex.c                  |    2 +-
>  hw/ppc/spapr.c                     |   80 ++-
>  hw/ppc/spapr_caps.c                |   43 ++
>  hw/ppc/spapr_cpu_core.c            |    2 +
>  hw/ppc/spapr_hcall.c               |   29 +-
>  hw/ppc/spapr_nested.c              |  119 +++-
>  hw/ppc/virtex_ml507.c              |    2 +-
>  hw/ssi/pnv_spi.c                   |  366 +++++------
>  include/hw/pci-host/pnv_phb4.h     |    5 +
>  include/hw/ppc/pnv.h               |    6 +-
>  include/hw/ppc/pnv_homer.h         |   12 +-
>  include/hw/ppc/pnv_occ.h           |    9 +
>  include/hw/ppc/pnv_pnor.h          |    6 +-
>  include/hw/ppc/pnv_xscom.h         |    4 +
>  include/hw/ppc/spapr.h             |    7 +-
>  include/hw/ppc/spapr_nested.h      |   67 +-
>  include/hw/ppc/xive.h              |   41 +-
>  include/hw/ppc/xive2.h             |   24 +-
>  include/hw/ppc/xive2_regs.h        |   17 +-
>  include/hw/ppc/xive_regs.h         |   25 +-
>  include/hw/ssi/pnv_spi.h           |    7 +-
>  pc-bios/README                     |   17 +-
>  pc-bios/meson.build                |    1 +
>  pc-bios/pnv-pnor.bin               |  Bin 0 -> 139264 bytes
>  pc-bios/skiboot.lid                |  Bin 2527328 -> 2592960 bytes
>  pc-bios/slof.bin                   |  Bin 995000 -> 996184 bytes
>  roms/skiboot                       |    2 +-
>  target/ppc/cpu.c                   |   45 +-
>  target/ppc/cpu.h                   |   14 +-
>  target/ppc/cpu_init.c              |   48 ++
>  target/ppc/excp_helper.c           |  842 +------------------------
>  target/ppc/helper.h                |    4 +
>  target/ppc/internal.h              |    8 +-
>  target/ppc/kvm.c                   |   12 +
>  target/ppc/kvm_ppc.h               |   12 +
>  target/ppc/machine.c               |    3 +-
>  target/ppc/meson.build             |    1 +
>  target/ppc/misc_helper.c           |   63 ++
>  target/ppc/mmu-radix64.c           |   14 +
>  target/ppc/spr_common.h            |    4 +
>  target/ppc/tcg-excp_helper.c       |  851 +++++++++++++++++++++++++
>  target/ppc/translate.c             |   28 +
>  tests/functional/meson.build       |    1 -
>  tests/functional/test_ppc_405.py   |   37 --
>  tests/qtest/m48t59-test.c          |    5 -
>  tests/qtest/meson.build            |    4 +-
>  tests/qtest/pnv-spi-seeprom-test.c |    2 +-
>  tests/qtest/pnv-xive2-common.h     |    1 +
>  tests/qtest/pnv-xive2-flush-sync.c |    6 +-
>  tests/qtest/pnv-xive2-nvpg_bar.c   |  152 +++++
>  tests/qtest/pnv-xive2-test.c       |  249 +++++++-
>  76 files changed, 4201 insertions(+), 3690 deletions(-)
>  delete mode 100644 hw/ppc/ppc405.h
>  delete mode 100644 hw/ppc/ppc405_boards.c
>  delete mode 100644 hw/ppc/ppc405_uc.c
>  create mode 100644 pc-bios/pnv-pnor.bin
>  create mode 100644 target/ppc/tcg-excp_helper.c
>  delete mode 100755 tests/functional/test_ppc_405.py
>  create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c
>

