Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45770CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHd41-00084N-FL; Fri, 16 Oct 2026 04:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHd40-000848-8h; Fri, 16 Oct 2026 04:13:16 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xHd3v-0006Th-EO; Fri, 16 Oct 2026 04:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792138069; bh=YkaY2bPB7qZ4iKFjQGhf5TqtqVui81Uow0xdD0bbLLg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TWipURGpl9uP1uJxW9o8RvNYoS9GBg985FVpW+P6NWnyIVhWhpfnnjOBbSlGXZsfR
 09zr5gQmtoUJ7v/5JrhgLCKWzgswX1aftUqH/ClSCzPtxXhkTi4xuU4prTfc6jNuy0
 jDjosS0PNzIlyffiYwxfw5A1FKw+1LH+vgdbWnjU=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69G87nq13825155; Fri, 16 Oct 2026 13:37:49 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int2.pune.cdac.in (Postfix) with ESMTP id B512A10014456;
 Fri, 16 Oct 2026 13:37:38 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 8300614E2700;
 Fri, 16 Oct 2026 13:37:38 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sreenadh@cdac.in, raokk@cdac.in,
 Karthika B <karthika.b@cdac.in>
Subject: [PATCH 0/7] RISC-V: Add CDAC VEGA machine support
Date: Fri, 16 Oct 2026 13:37:00 +0530
Message-ID: <20261016080709.17331-1-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <385625713.441366.1761727810206@webmail2.cdac.in>
References: <385625713.441366.1761727810206@webmail2.cdac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: B512A10014456.ACF51
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.999, required 6, ALL_TRUSTED -1.00, URIBL_BLOCKED 0.00)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds QEMU machine support for VEGA, a RISC-V SoC family
developed by C-DAC (Centre for Development of Advanced Computing,
India) as part of the DIR-V processor program.

VEGA series of microprocessors are developed as part of the
Microprocessor Development Programme, initiated and funded by MeitY
(Ministry of Electronics and Information Technology, Government of
India), with the mission objective to design and develop
indigenously a family of microprocessors, related IPs, and the
complete ecosystem to enable fully indigenous product development
catering to various requirements in the strategic, industrial, and
commercial sectors. VEGA is developed at C-DAC, Thiruvananthapuram.

Background
----------
VEGA is a series of 32-bit and 64-bit single/multi-core RISC-V
processors (Thejas32 and Thejas64) developed under the DIR-V program,
integrated with multi-level caches, an MMU, and a coherent
interconnect on real silicon. This series adds a QEMU 'vega' machine
model supporting both the Thejas32 (RV32) and Thejas64 (RV64)
variants, modelled on real silicon behaviour rather than a
synthetic/virtual platform.

More details on the VEGA processor series:
  https://vegaprocessors.in/
VEGA documentation:
  https://cdac-vega.gitlab.io/

The model has been validated against Aries boards (Thejas32) and
Thejas64 SoCs, booting:
  - bare-metal ELF payloads via -bios (no DTB, fixed UART framing),
    for both RV32 and RV64, using the VEGA SDK's example UART
    "hello world" application
  - Linux via BBL with a user-supplied -dtb describing the SoC (RV64)

What's included
----------------
 - hw/riscv/vega.c            - machine model, device creation, boot flow.
                                 Note: VEGA does not generate its device
                                 tree internally; -dtb is required for any
                                 -kernel boot (see note below)
 - hw/intc/vega_plic.c        - CDAC PLIC variant (register layout
                                 differs from the generic riscv,plic0;
                                 see patch N/N for details)
 - hw/intc/vega_aclint.c      - ACLINT MSWI/SSWI/MTIMER, with the
                                 STIMECMP handling VEGA's boot ROM /
                                 BBL relies on
 - target/riscv/cpu.c         - adds TYPE_RISCV_CPU_VEGA32 and
                                 TYPE_RISCV_CPU_VEGA64, CPU subtypes
                                 baking in VEGA's fixed baseline (IMA +
                                 S/U + Zicsr/Zifencei + SV32/SV39), so
                                 -M vega boots on either architecture
                                 without a manual -cpu string; see note
                                 below on why both are parented on
                                 sifive-u rather than the generic base
                                 CPU type
 - docs/system/riscv/vega.rst - user-facing documentation
 - tests/functional/riscv32/test_vega.py,
   tests/functional/riscv64/test_vega.py
                               - functional tests booting -M vega on
                                 both architectures (bare-metal on
                                 both; bare-metal + Linux/BBL on
                                 riscv64), fetching small test binaries
                                 from a stable, checksummed external
                                 asset repository
 - MAINTAINERS entry

Notable hardware characteristics reviewers should know up front
-----------------------------------------------------------------
 - The PLIC and CLINT/ACLINT are co-located at the same base address
   on real VEGA silicon (0x20010000). This is not a QEMU modelling
   error; it reflects the actual SoC memory map.
 - The PLIC aperture is 0x400 bytes, sized for the current maximum
   hart count on this SoC family; it is not the generic upstream PLIC
   aperture size.
 - UART register framing differs between boot modes: bare-metal always
   uses shift=2/io-width=4 (fixed 32-bit stride), while Linux boot
   reads reg-shift from the DTB serial node, since the two boot paths
   exercise the hardware through different firmware layers.
 - TYPE_RISCV_CPU_VEGA32/VEGA64 are parented on TYPE_RISCV_CPU_SIFIVE_U
   rather than TYPE_RISCV_CPU_BASE or TYPE_RISCV_BARE_CPU.
   TYPE_RISCV_CPU_BASE's default misa_ext includes RVH, and the
   class-level misa_ext merge is OR-only (a subtype cannot clear a bit
   its parent already set), so RVH could not be disabled from a
   TYPE_RISCV_CPU_BASE-derived subtype. TYPE_RISCV_BARE_CPU avoids
   that, but unconditionally forces max_satp_mode to 'bare' for any
   CPU in its lineage regardless of what the subtype configures, which
   breaks paging. TYPE_RISCV_CPU_SIFIVE_U has neither issue, but
   silently sets priv_spec to PRIV_VERSION_1_10_0 (an older RISC-V
   privileged spec version) rather than the current one. This surfaced
   as a real boot hang against production BBL/DTB pairs (BBL's
   delegate_traps() mideleg assertion failed) that was not visible in
   simpler test boots, since the hang depends on firmware built
   against a newer priv spec than 1.10.0. Both VEGA CPU subtypes
   explicitly override priv_spec back to PRIV_VERSION_LATEST to fix
   this; anyone deriving a new CPU subtype from a SiFive-family parent
   should be aware this default does not propagate the way ISA
   extension bits might be assumed to.
 - VEGA does not generate a device tree internally. -dtb is required
   for any -kernel (Linux/BBL) boot; the machine errors out clearly if
   a kernel is given without -dtb and without -bios firmware. A bare
   "-M vega" with no boot arguments at all (e.g. qtest's generic
   smoke tests) is a valid, inert state and does not error. This keeps
   the initial series scoped to what has been directly tested;
   internal FDT generation may follow as a later series.
 - PLIC and CLINT compatible strings are "cdac,plic-1.0.0" and
   "riscv,clint0" respectively. CDAC's own Buildroot-based BBL/Linux
   builds use a CDAC-specific PLIC driver matched against the former,
   and use the generic CLINT compatible string directly (no
   CDAC-specific CLINT driver exists in any current VEGA firmware
   variant). A DTB intended to boot stock, unmodified riscv-pk/BBL
   (which only recognises "riscv,plic0" verbatim) will need to
   additionally advertise that generic string for the PLIC node.

What is NOT included / deliberately left out
---------------------------------------------
 - No AIA/APLIC/IMSIC support: current VEGA silicon does not implement
   AIA, so that code path (present in earlier internal revisions) has
   been removed rather than left as dead code.
 - No internal device-tree generation: see note above; -dtb is
   required for -kernel boots in this series.
 - No SDHCI, SPI, I2C functional models yet: exposed as
   unimplemented-device stubs matching the real address ranges, so
   guest software can probe them safely; functional models may follow
   in later series.
 - No RV32 Linux boot test yet: the functional test suite covers
   bare-metal on both architectures and a full Linux/BBL boot on
   riscv64 only, since an RV32 (Thejas32) Linux/BBL boot has not yet
   been verified; this may follow in a later series once available.

Testing
-------
 - riscv32-softmmu and riscv64-softmmu builds, `make check` clean on
   both
 - checkpatch.pl clean across the series
 - Functional tests added under tests/functional/riscv32/test_vega.py
   and tests/functional/riscv64/test_vega.py, passing via both direct
   invocation and `meson test` on both architectures:
     - bare-metal "hello world" boot (RV32 and RV64)
     - full Linux boot via BBL to a login prompt (RV64)
 - Manual testing additionally covered: virtio-net networking, and an
   extended stress-ng run (CPU, matrix, VM, filesystem, device-access
   stressors) under Linux on -M vega

We previously posted an early version of VEGA machine support
(Message-ID: <385625713.441366.1761727810206@webmail2.cdac.in>)
without a proper cover letter, MAINTAINERS entry, documentation, or
tests, and sent via a webmail client rather than git send-email,
which likely affected formatting. This series is a corrected
resubmission addressing all of that: it is sent via git send-email,
and adds the documentation, MAINTAINERS entry, and functional tests
that were missing before. We've since read and followed
docs/devel/submitting-a-patch.rst in full. Feedback on process as
well as code is very welcome.

Karthika B (7):
  hw/intc: Add CDAC VEGA PLIC device model
  hw/intc: Add CDAC VEGA ACLINT device model
  target/riscv: Add VEGA32 and VEGA64 CPU types
  hw/riscv: Add CDAC VEGA machine model
  docs/system/riscv: Add VEGA machine documentation
  tests/functional: Add VEGA machine functional tests
  MAINTAINERS: Add entry for VEGA machine

 MAINTAINERS                                 |  14 +
 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/vega.rst                  | 219 +++++++
 docs/system/target-riscv.rst                |   1 +
 hw/intc/Kconfig                             |   7 +
 hw/intc/meson.build                         |   2 +
 hw/intc/vega_aclint.c                       | 668 ++++++++++++++++++++
 hw/intc/vega_plic.c                         | 517 +++++++++++++++
 hw/riscv/Kconfig                            |  11 +
 hw/riscv/meson.build                        |   1 +
 hw/riscv/vega.c                             | 502 +++++++++++++++
 include/hw/intc/vega_aclint.h               |  84 +++
 include/hw/intc/vega_plic.h                 |  87 +++
 include/hw/riscv/vega.h                     | 136 ++++
 target/riscv/cpu-qom.h                      |   2 +
 target/riscv/cpu.c                          |  25 +
 tests/functional/riscv32/meson.build        |   1 +
 tests/functional/riscv32/test_vega.py       |  32 +
 tests/functional/riscv64/meson.build        |   1 +
 tests/functional/riscv64/test_vega.py       |  63 ++
 20 files changed, 2374 insertions(+)
 create mode 100644 docs/system/riscv/vega.rst
 create mode 100644 hw/intc/vega_aclint.c
 create mode 100644 hw/intc/vega_plic.c
 create mode 100644 hw/riscv/vega.c
 create mode 100644 include/hw/intc/vega_aclint.h
 create mode 100644 include/hw/intc/vega_plic.h
 create mode 100644 include/hw/riscv/vega.h
 create mode 100644 tests/functional/riscv32/test_vega.py
 create mode 100644 tests/functional/riscv64/test_vega.py

-- 
2.43.0

------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


