Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA62CD98F9
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBrI-0007tx-4T; Thu, 18 Jun 2026 08:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrG-0007tn-SK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrE-0007UY-7s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:28:34 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArt2b1536469
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2zLLbblEn0ynOdyIMz5Q57
 MBBGGrGwEkDzirZ71dPiU=; b=Ssbz1X5ko9g9OHbEJv3LpJms22qJYpZ4CNmnSy
 H/giVfTa/NR0j6eRvnZdvtXbmZ6LmZG0mHoGnRMpmDyI3NTZkGV+foXi3b9WcZ25
 JsTDIWY5BmaiMvL4dzDb2nvKwNyVvMS6kHawtJkgRJurDHst/tPZnxRl02pxdoMB
 3oAPXcNeHnc91canDGBmbcB6fRmYUDQ6vNb37nLI28M5l9H/+HKAu0ui5vp/rBq9
 fqX6RgwU1uGeHgexJCZPkN6GpI8ZxrVi12CgNYE2NK0mfHDo1rZ1m8HI+NcDPSv9
 GZ2wlju8AlWHXUDAlS+PPl2OS6i/9MwCvVFZmLShVJhkixrg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kkcp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915b3587972so100808985a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785709; x=1782390509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2zLLbblEn0ynOdyIMz5Q57MBBGGrGwEkDzirZ71dPiU=;
 b=FyrgUuZVWmwk/DNZEhK9WEcoHhM/86zxwOL6h/M1uNPxQYUzocmvA7fuFoiKNJ5p+V
 PCR14lUs7sm74wpY5n2K6pqINNnzH43Veylj+mDgxXA+PMDB4MCTViMhbFgdkD9Wj9BU
 iZBWHYgX9bRV/FSUzBKYSl+ihpYCwH1Qf8G/HmUnIaiFF8ilyhDEkAKCdbMiIG4ot9kj
 x8iv6rWDDrfxWSafHIylWQzjMJpkLutk496YYzn6AdScy7L/EqpjVx2lmK9zKqy/xVjY
 8YdgPU+hyKfHu/aoNOKcJCheFfTsSNX8y/IbYixjYmbJ38uG2U1s9a/i4gy2mRTqj7vw
 10wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785709; x=1782390509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2zLLbblEn0ynOdyIMz5Q57MBBGGrGwEkDzirZ71dPiU=;
 b=Mi6TIV2IzKAbskDcXY9Cg9izpEZOUxhWKq7m9NAfgdzjLAfn5psCQL8FsDYuoMjQMC
 yHgRvtIMnyQdI5g0kfVvcEqhW7P6B3KeXkChNZ1OIR+PHCVLh4LK708KoaRCgxpXokrC
 uqies1eYBKuZyCxqs5VledMfv2E+TqNM+7hpFWD0quNhVlIIKReK4mA007eFew9jG/h5
 SlCjMxO4k6b/Sr9AoZg861JeGP5f20tcxELjPlmxIhsWXheu0LzJWB/P2cdc5AdDN04p
 6p6rc6JiQqu/RYPaUsELEQM8fK0g2kW53FCJ3+mWehTwiqJOWUmPjD6LNco8Fi2ojA/q
 L62Q==
X-Gm-Message-State: AOJu0YwgebQdgy9dxjh2sNyBqsPVIyOs2H+E5Jnn38BvMzHTK/40Xu8x
 dyIgIJPZYcdfw4CstlfTcUTsis+S/wvtJpXDwiu8Jio3hEU6tNzM92rbULg6b95Qw5Rcyq1cW/u
 hb/Y8CWCCy21/VaOUj+VGDXMKuFCOluOYqVgLxuYOKa7mUqb369YVEPE4LeYDOmGCrQ==
X-Gm-Gg: AfdE7cnG82W35qOLkF0ySn2d99e0I5t3fdJOBTFmTWbCXBAGMtRrItdtRURsTY0etF9
 /E8ZSvjKPbyG5mqIP3A7RZXx6tOXmMtZBidZ7zyTsBcPKWh+eur3EDDmjc7pO6EqsyLCQTxNSA3
 vFU7hhWamd41JHoIm8QH2xvr+Gc/vKmL0bCBSC4yyKipxkTO7LlGddEW/1YioHTTUTEQxNyUF3P
 yuhV6y5VpJUVheNJXyEG/ZqBeLV7FwPbnkPiInJmGdbbHj3MBBZHa/HrVukWG0ThDJgtNsgo3nS
 mI3GeAvZS10iwIolGXdX+DBD61pvOnG1I7ebHMx7fwxulz5h7An+G/GnZUu9Yott9w7B2cNbgcb
 MoU4e6UHFvimRdQpftjWZ0XDr8hQBb5cIEazstghhdT5It1pPAz9xrbzc6nntdpn49QSe
X-Received: by 2002:a05:620a:4056:b0:915:675d:a2d with SMTP id
 af79cd13be357-91d8deae9f0mr1453609785a.51.1781785708875; 
 Thu, 18 Jun 2026 05:28:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4056:b0:915:675d:a2d with SMTP id
 af79cd13be357-91d8deae9f0mr1453599885a.51.1781785708126; 
 Thu, 18 Jun 2026 05:28:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-461eaa0d275sm19066905f8f.2.2026.06.18.05.28.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:28:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/48] Accel patches for 2026-06-18
Date: Thu, 18 Jun 2026 14:27:37 +0200
Message-ID: <20260618122825.90331-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX0Ak08rlE+2eS
 qB3XEXcs4aq4q0x/B/eI3VM3HQvWKTx9Z8rooRQiqvn8jWTPnyPdm590nqDWXWxtDBS4u9XY/pE
 lkweRAeuBGwxYzT6VGEIa+0VZxhJYKuA1wX3HCVBtx+jWDMAqhPH3yuhD1Vkg38xwPDaf7mac7m
 celpO7zEGyakiPOMnhLAOe5DmtVRlpq3vg4Hyl06QM24Ztmotf62XipQ77mVwUC0LLkMtjHHc9N
 C5hGP1TuYrkvcKkcTWTVgWuYK+jqt8fZV1t2j+fX6qijZFtDzqb00rQd1gIeiuzslb1ECr/aTnP
 fn3NvjvsEUomX2QHS+CVI0jIpP9UUtutuboR9sKxYka4AGToIR6LVoyf4MLexC8qVB4KSnCHgSd
 t+sCMZ5vlYtI1rhqfc1Mhn8oaVt06+HqD39eV+Le6ithLJmiMIOjUZEitRA0Vz8+pB1vhBXaBaL
 K43yhn/k3IagVFp/CeQ==
X-Proofpoint-GUID: CpE7c92J1nYXcQX8ZyKHh6398xaanqj9
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33e46d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=i8uBmrCkF7p27xy_faIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: CpE7c92J1nYXcQX8ZyKHh6398xaanqj9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX2d64XZ6D9eh2
 pntth7xv2sCaEqH7oKSQQiwEnWvqjAN+Z+D47n41xbbGPfVF4wUPEsjm6VI4RF+owF6G/08N5d1
 oqcOXu2wJPJ+KArLY5SZtuI0g7zlw/U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The following changes since commit c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff:

  Merge tag 'firmware-20260617-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-06-17 10:17:29 -0400)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20260618

for you to fetch changes up to 1eaae985d4dec2aa0b187e362db50be46968d117:

  accel/tcg: Restrict headers being TCG specific (2026-06-18 14:27:21 +0200)

----------------------------------------------------------------
Accelerators patches queue

- Avoid double hv_vcpu_destroy() call during teardown on HVF ARM
- Constify various AddressSpace/MemoryRegionCache arguments
- Clarify physical_memory_*() API in "system/physmem.h"
- Extract "accel/tcg/cpu-loop.h" out of "exec/cpu-common.h"
- Restrict few TCG-specific code
- Remove pre-C11 check
- Various header cleanups
----------------------------------------------------------------

Akihiko Odaki (1):
  ui/cocoa: Use qemu_input_map_osx_to_linux

Bin Guo (1):
  util/cutils: drop qemu_strnlen() in favor of strnlen()

Emmanuel Blot (1):
  meson: build macOS signed binary as part of the default target

Matheus Tavares Bernardino (1):
  accel/hvf: fix double hv_vcpu_destroy() causing teardown error on ARM

Matt Jacobson (1):
  configure: honor --extra-ldflags when forced to use objc_LINKER

Osama Abdelkader (1):
  accel/tcg: remove duplicate include

Philippe Mathieu-Daudé (42):
  system/cpu: Reset vCPU %exception_index before resuming it
  system/memory: Constify various AddressSpace arguments (checks)
  system/memory: Constify various AddressSpace arguments (flat-range)
  system/memory: Constify various AddressSpace arguments (notify)
  system/memory: Constify various AddressSpace arguments (cache)
  system/memory: Constify various AddressSpace arguments (access)
  system/memory: Constify various MemoryRegionCache arguments
  system: Document cpu_physical_memory_*() declarations
  accel/kvm: Replace legacy cpu_physical_memory_write() call
  gdbstub/system: Replace legacy cpu_physical_memory_read/write() calls
  target/s390x: Factor common s390_ipl_read/write() helpers
  target/s390x: Replace legacy cpu_physical_memory_read/write() calls
  system: Move cpu_physical_memory_*() declarations to
    'system/physmem.h'
  hw/xen/interface: Remove pre-C99 checks
  qom/object: Remove pre-C11 check
  tcg: Include missing 'qemu/bitops.h' header in tcg-gvec-desc.h
  target/i386: Report TPR accesses to HVF
  target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
  target/arm: Remove vcpu_dirty=true assigments in
    hvf_handle_exception()
  target/arm: Better describe PMU depends on TCG or HVF
  target/arm/ptw: Restrict PMSAv8 code to TCG
  target/arm: Restrict TCG specific headers
  target/ppc: Restrict TCGTBCPUState to TCG
  target/loongarch: Remove unused 'accel/accel-cpu-target.h' header
  target/sparc: Include missing 'accel/tcg/cpu-ops.h' header in cpu.c
  accel/hvf: Reduce hvf_kernel_irqchip_override scope
  accel/tcg: Restrict IOMMU declarations
  exec/cpu-common.h: Include missing 'qemu/thread.h' header
  exec/cpu-common.h: Avoid including unused 'exec/vaddr.h' header
  exec/cpu-common.h: Avoid including unused 'tcg/debug-assert.h' header
  exec/cpu-common.h: Avoid including unused exec/page-protection.h
    header
  system/memory: Remove unnecessary CONFIG_USER_ONLY guards
  system/memory: Rename cpu_exec_init_all() -> machine_memory_init()
  hw/s390x/ipl: Remove TCG dependency in handle_diag_308()
  accel/tcg: Remove cpu_loop_exit() stub
  accel/tcg: Move cpu_exec() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_exec_step_atomic() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_unwind_state_data() out of 'exec/cpu-common.h'
  accel/tcg: Move cpu_restore_state() out of 'exec/cpu-common.h'
  accel/tcg: Have cpu_loop_exit_requested() take const @cpu argument
  accel/tcg: Move cpu_loop_exit_*() out of 'exec/cpu-common.h'
  accel/tcg: Restrict headers being TCG specific

 docs/devel/loads-stores.rst             |  18 ++--
 docs/devel/style.rst                    |   1 -
 configure                               |   1 +
 meson.build                             |   1 +
 scripts/coccinelle/exec_rw_const.cocci  |  16 +--
 bsd-user/freebsd/os-proc.h              |   1 +
 hw/xtensa/bootparam.h                   |   6 +-
 include/accel/tcg/cpu-loop.h            |  76 ++++++++++++++
 include/accel/tcg/cpu-mmu-index.h       |   4 +
 include/accel/tcg/cpu-ops.h             |   4 +
 include/accel/tcg/getpc.h               |   4 +
 include/accel/tcg/helper-retaddr.h      |   4 +
 include/accel/tcg/iommu.h               |   7 ++
 include/accel/tcg/probe.h               |   4 +
 include/accel/tcg/tb-cpu-state.h        |   4 +
 include/exec/cpu-common.h               |  54 +---------
 include/hw/xen/interface/physdev.h      |   2 +-
 include/hw/xen/interface/version.h      |   5 +-
 include/hw/xen/interface/xen-compat.h   |   2 -
 include/hw/xen/interface/xen.h          |  14 ---
 include/qemu/cutils.h                   |  17 +--
 include/system/hvf_int.h                |   1 -
 include/system/memory.h                 |  18 ++--
 include/system/memory_cached.h          |  20 ++--
 include/system/physmem.h                |  50 +++++++++
 include/tcg/tcg-gvec-desc.h             |   2 +
 include/user/cpu_loop.h                 |   2 +-
 linux-user/qemu.h                       |   1 +
 system/memory-internal.h                |   4 +-
 target/arm/internals.h                  |   4 +-
 target/ppc/internal.h                   |   5 +-
 target/ppc/mmu-hash32.h                 |   1 +
 target/s390x/s390x-internal.h           |   3 +-
 include/system/memory_ldst_cached.h.inc |  15 +--
 accel/hvf/hvf-all.c                     |   2 +-
 accel/kvm/kvm-all.c                     |  12 +--
 accel/stubs/tcg-stub.c                  |  19 ----
 accel/tcg/cpu-exec-common.c             |   1 +
 accel/tcg/cpu-exec.c                    |   5 +-
 accel/tcg/cputlb.c                      |   2 +-
 accel/tcg/tb-maint.c                    |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c         |   1 +
 accel/tcg/tcg-accel-ops-rr.c            |   1 +
 accel/tcg/tcg-accel-ops.c               |   1 +
 accel/tcg/tcg-runtime.c                 |   1 +
 accel/tcg/translate-all.c               |   2 +-
 accel/tcg/user-exec.c                   |   1 +
 accel/tcg/watchpoint.c                  |   1 +
 bsd-user/main.c                         |   1 +
 bsd-user/uaccess.c                      |   4 +-
 dump/dump.c                             |   3 +-
 dump/win_dump-x86.c                     |   5 +-
 gdbstub/system.c                        |  11 +-
 hw/acpi/ghes.c                          |  24 ++---
 hw/acpi/nvdimm.c                        |  13 +--
 hw/acpi/vmgenid.c                       |   3 +-
 hw/audio/marvell_88w8618.c              |   3 +-
 hw/char/riscv_htif.c                    |   5 +-
 hw/display/exynos4210_fimd.c            |   7 +-
 hw/display/omap_lcdc.c                  |   5 +-
 hw/display/ramfb.c                      |   7 +-
 hw/dma/i8257.c                          |   9 +-
 hw/dma/omap_dma.c                       |   6 +-
 hw/dma/rc4030.c                         |   3 +-
 hw/dma/sifive_pdma.c                    |   9 +-
 hw/hyperv/hyperv.c                      |  25 ++---
 hw/hyperv/syndbg.c                      |  13 +--
 hw/hyperv/vmbus.c                       |   9 +-
 hw/i386/kvm/clock.c                     |   3 +-
 hw/i386/vapic.c                         |  21 ++--
 hw/intc/apic.c                          |   3 +-
 hw/intc/xive2.c                         |   3 +-
 hw/m68k/next-cube.c                     |   3 +-
 hw/microblaze/boot.c                    |   3 +-
 hw/misc/mips_itu.c                      |   1 +
 hw/misc/pc-testdev.c                    |   5 +-
 hw/net/fsl_etsec/rings.c                |  13 +--
 hw/net/mcf_fec.c                        |  11 +-
 hw/net/opencores_eth.c                  |   9 +-
 hw/nvram/spapr_nvram.c                  |   9 +-
 hw/ppc/amigaone.c                       |   5 +-
 hw/ppc/e500.c                           |   3 +-
 hw/ppc/pegasos.c                        |  11 +-
 hw/ppc/pnv.c                            |   5 +-
 hw/ppc/ppc440_uc.c                      |   9 +-
 hw/ppc/ppc_booke.c                      |   1 +
 hw/ppc/spapr.c                          |   3 +-
 hw/ppc/spapr_drc.c                      |   3 +-
 hw/ppc/spapr_events.c                   |   9 +-
 hw/ppc/spapr_hcall.c                    |  17 +--
 hw/ppc/spapr_rtas.c                     |   5 +-
 hw/ppc/spapr_tpm_proxy.c                |   5 +-
 hw/ppc/virtex_ml507.c                   |   3 +-
 hw/s390x/css.c                          |   5 +-
 hw/s390x/ipl.c                          |  14 +--
 hw/s390x/s390-pci-bus.c                 |   5 +-
 hw/s390x/virtio-ccw.c                   |   5 +-
 hw/scsi/vmw_pvscsi.c                    |  12 +--
 hw/xen/xen_pt_graphics.c                |   4 +-
 hw/xtensa/xtfpga.c                      |   5 +-
 linux-user/arm/elfload.c                |   1 +
 linux-user/hppa/elfload.c               |   1 +
 linux-user/uaccess.c                    |   2 +-
 linux-user/x86_64/elfload.c             |   1 +
 plugins/api.c                           |   1 +
 qom/object.c                            |  14 +--
 semihosting/console.c                   |   1 +
 system/cpus.c                           |   4 +-
 system/memory.c                         |  16 +--
 system/physmem.c                        |  44 ++++----
 system/vl.c                             |   3 +-
 target/alpha/helper.c                   |   1 +
 target/alpha/mem_helper.c               |   1 +
 target/arm/cpu-irq.c                    |   3 +-
 target/arm/cpu.c                        |   2 +-
 target/arm/helper.c                     |   2 +-
 target/arm/hvf/hvf.c                    |  11 +-
 target/arm/machine.c                    |  10 +-
 target/arm/ptw.c                        |  20 +++-
 target/arm/tcg/cpregs-at.c              |   1 +
 target/arm/tcg/helper-a64.c             |   1 +
 target/arm/tcg/op_helper.c              |   1 +
 target/arm/tcg/tlb_helper.c             |   1 +
 target/avr/helper.c                     |   1 +
 target/hexagon/op_helper.c              |   1 +
 target/hppa/cpu.c                       |   1 +
 target/hppa/mem_helper.c                |   1 +
 target/hppa/op_helper.c                 |   1 +
 target/i386/helper.c                    |   3 +-
 target/i386/tcg/excp_helper.c           |   1 +
 target/i386/tcg/misc_helper.c           |   1 +
 target/i386/tcg/system/bpt_helper.c     |   1 +
 target/i386/tcg/system/misc_helper.c    |   1 +
 target/i386/tcg/system/svm_helper.c     |   1 +
 target/i386/tcg/user/excp_helper.c      |   1 +
 target/i386/tcg/user/seg_helper.c       |   1 +
 target/loongarch/cpu_helper.c           |   1 +
 target/loongarch/tcg/tcg_cpu.c          |   3 +-
 target/loongarch/tcg/tlb_helper.c       |   1 +
 target/m68k/helper.c                    |   1 +
 target/m68k/op_helper.c                 |   1 +
 target/microblaze/helper.c              |   1 +
 target/microblaze/op_helper.c           |   1 +
 target/mips/tcg/exception.c             |   1 +
 target/mips/tcg/system/tlb_helper.c     |   1 +
 target/or1k/exception.c                 |   1 +
 target/or1k/exception_helper.c          |   1 +
 target/or1k/fpu_helper.c                |   1 +
 target/or1k/mmu.c                       |   1 +
 target/or1k/sys_helper.c                |   1 +
 target/ppc/cpu_init.c                   |   1 +
 target/ppc/helper_regs.c                |   3 +-
 target/ppc/tcg-excp_helper.c            |   1 +
 target/ppc/user_only_helper.c           |   1 +
 target/riscv/cpu_helper.c               |   1 +
 target/riscv/csr.c                      |   1 +
 target/riscv/op_helper.c                |   1 +
 target/rx/op_helper.c                   |   1 +
 target/s390x/diag.c                     |  75 ++++++++------
 target/s390x/mmu_helper.c               |   3 +
 target/s390x/tcg/cc_helper.c            |   1 +
 target/s390x/tcg/debug.c                |   1 +
 target/s390x/tcg/excp_helper.c          |   1 +
 target/s390x/tcg/mem_helper.c           |   1 +
 target/s390x/tcg/misc_helper.c          |   6 +-
 target/sh4/helper.c                     |   1 +
 target/sh4/op_helper.c                  |   1 +
 target/sparc/cpu.c                      |   1 +
 target/sparc/helper.c                   |   1 +
 target/sparc/mmu_helper.c               |   1 +
 target/tricore/helper.c                 |   1 +
 target/tricore/op_helper.c              |   1 +
 target/xtensa/exc_helper.c              |   1 +
 target/xtensa/helper.c                  |   1 +
 util/cutils.c                           |  15 +--
 accel/stubs/meson.build                 |   1 -
 ui/cocoa.m                              | 131 +-----------------------
 177 files changed, 644 insertions(+), 583 deletions(-)
 create mode 100644 include/accel/tcg/cpu-loop.h
 delete mode 100644 accel/stubs/tcg-stub.c

-- 
2.53.0


