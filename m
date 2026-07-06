Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5888C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjdj-0006Cc-Gm; Mon, 06 Jul 2026 09:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjdi-0006CU-1m
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:45:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjdg-00067J-6U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:45:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxDWH395293
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=tjWCqPCRt3B2+TFIQc5Eyr
 85d/qXDxlddgkp2OneDEY=; b=ZnvQEAoLWgQ6W5LIIq8MBC7x47+jNp/b3bk6e7
 HrR9e8bQtgi6+vP4Ts9BiZ/+Ho2a3DHBIk6YhIOzTxCcZJDxtXU3/GJ2EbtIPrEp
 6GlVz7vvdlXtwJERi40V9EKqWrBxVa5Y1yVyj4UuaM3dNFN95XuTYcOqzMCfAIc3
 NbkDbcwjqAVCIHI+DM6WvSXq5iOWpBUiCrptMREADVo5xQ4+mFyd9Hq6hjvXwSxX
 1HzhtOU2lNxb31c440xelHxyoabth0ru0cuIU78nC0oLN0gergJofpLO1YkKL4Q3
 moaoHkMDPYFbYFNRq1lhhO824d81XisycBCOFQ/QKpAg0RJA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qph05j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:45:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915f6ff639aso554447785a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345533; x=1783950333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tjWCqPCRt3B2+TFIQc5Eyr85d/qXDxlddgkp2OneDEY=;
 b=gZsf7CRKhgzOnaTZcIvTV3s/V5xecJuyvdHa6v0STLKvN2yRgSqfrcbhme4+C686Oc
 Mkt3tBa1eg6JRTFBnW2eFpTx9jr0O6R+/G8bvfZhV6ZS2g1Jh6ReUkhIu6hiBPcralAz
 F6tDEJQFQ+ic6Ge0yRqKLf9Y87teGoxk84MvAKcrkClK1tCaxuR6sD//Vu7Hta/VFXTH
 KSdhZqfBFo/VEoGKgpzxxCqSYNgns0TN+kMlPSPUigDwfR5BMa+y/f/XC7DCnLx3uWe3
 Es9BfcMoKN5xhehESnm3tOfnyRD7WC0Sb0gyNQJm8zsP8dxnsVcIHC4TI7JskIW/SYZR
 Pmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345533; x=1783950333;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjWCqPCRt3B2+TFIQc5Eyr85d/qXDxlddgkp2OneDEY=;
 b=cJukxpsXoUCBXqRQ/OAftd0y7tkeh65h1DvRWcNwneQ8b25xZEhAs0s0n0orXKMsb2
 8obz1mveX01j/jnRZMFdjmvFqDyDeyNe7DxoU/FqRynZkHS/efhd2TS+lwH6qhvnZR83
 dengiQaZ3GEfubLQCWRB4ydlV2Y0re7GsK6vbZgv84YyuG5ALtEI9zmPiEV6D3+UGPe0
 fRRfx29lf5Gg/tRFjQ9Nnf1/LRiq3IkW4BkIXUxbKz/Iz6yUAS8DAoCwmF6uGTYzdeHU
 xyKMs5+3EtoeYX7FGyoLbVv3wHPYwwyeN+eEV83Gp8X7RW1A9hQDW9RtCsvvSlOsdV4t
 Gf9g==
X-Gm-Message-State: AOJu0YxBg3enZ1loaeb3D9hgIkWIbmITph23gNrjh7HKT1ERygYZV15u
 w5qDKe+1A/jWd4cBxQMNLtIcx8RAR073AlB1XCsnMUwmKJaKOPYRJNYlT0AyfPQ1DWNrqgekqxN
 cJxGQ2i4xWyp72sl+OOyfVbloedY09PWUl98nLGxlB6KNpUwJHXTItv2r4inh//1JvA==
X-Gm-Gg: AfdE7cne1cNKFYmgQrEt0rd4z00gwLvJ2p5zyda2QFwb3A9vmQl/j1wnXd3dzryr5pD
 q9ZM8zREN6NGF3Ejv+BsgeYRFYPDqiO5V0dXQMRRGU5RIlYrgzIHQwRq9Ox2eTim6+gto+B84dJ
 drNIQn7tNQI5ujpq6M98CsbXZJN54D4vEjz5q18kPcrpyXOcPj3Gqa8wK/LK9LiLQmy5oQUGbGG
 v89calbab13Ndnm4jnihOWoUNleW9CzKA7OsIXxleSXx+se5BpkSZiKetZfDbkA75AUjga6s7ae
 G/a5+hm/4766gnJbVVCbaPVKhJvGlX436bBqUe6TemKLx6GgRiQiD79/WBJaGQ56b6ikze41qIP
 viVenQ7aGtf0Aj80zkXtLojxJUVrXF9uM2c1baAV1BlpEjmvRZKfdfvFNzg==
X-Received: by 2002:a05:620a:1b90:b0:92b:6805:91b9 with SMTP id
 af79cd13be357-92ebb5b24b7mr86413785a.65.1783345533254; 
 Mon, 06 Jul 2026 06:45:33 -0700 (PDT)
X-Received: by 2002:a05:620a:1b90:b0:92b:6805:91b9 with SMTP id
 af79cd13be357-92ebb5b24b7mr86406485a.65.1783345532506; 
 Mon, 06 Jul 2026 06:45:32 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm25462259f8f.13.2026.07.06.06.45.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:45:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] Accelerator patches for 2026-07-06
Date: Mon,  6 Jul 2026 15:44:55 +0200
Message-ID: <20260706134527.84808-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bb17e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=neJOs5DFhiM64i1DWw0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 2UK2fm6DW5nW32npjFOcEl8ndGfSxYbO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfXzqUSVGcLuuW6
 vBMyW8AUm5I61pMqF6sW4hUCXC7GQapm3i2CtpdJjfnb+s1HuE6iBuD6MA6D4/ClwwUv7NoHpCP
 QmmUn4/Lay7zlOBO4Xi3IevxXMVpR9aqtcQXtoh+VhUIRzA/a1FuAB2c0qhcfYRm9Hss4hpK/Dr
 Ch+FN0jdFkAhBQF7FgnrsMHHNuhk0ex/+x+qdArCKBZ1AXRqwpj3DXzoYJEZwlvuK4TW81BoFds
 6vDOHcUEW50Ao1MgTomfKLh2nthzFhf5nJSu1Y0tDjU55ozbzOyBnfw2Eaygy9+wgVRjzYnUuLd
 KcvZJaBxZNLuCpdzdlGR1ORmlCfUzD73tLll73+/QznduG+sC8jVmwYF4yqMGilMC0t63glOj/6
 xf9LJQ74gDOp7r11w6WMu1HT9iS/Z9x+uuMx2CmGMORMP066fFVE5m9et7AVUOummINyHWaNAr8
 KL83dEKPn5uQiqDDwCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX8mVfznTMFF+k
 PNeJ9H0XpTB4FGcjCcYMq620QlHcUBu/a9Eb/Os9UDRjJDV6SLN6nI7R8USfNerseS+E+RAhyiV
 pPktK3HeyYMImXXPtIRtqd7qjl5LxJw=
X-Proofpoint-GUID: 2UK2fm6DW5nW32npjFOcEl8ndGfSxYbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

The following changes since commit 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf:

  Merge tag 'firmware-20260704-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-07-05 08:42:47 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-20260706

for you to fetch changes up to c0df53752c86e5f51e12e7b99501b6f4d2e52c01:

  cpu: Only check SSTEP_ENABLE flag in cpu_single_stepping() (2026-07-06 15:42:18 +0200)

Ignoring following checkpatch.pl warnings:

  WARNING: Saw acceptable license 'LGPL-2.1-or-later' ... Please explain the license
  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    accel/tcg/system-page-protection.h
  WARNING: line over 80 characters
  #71: FILE: gdbstub/gdbstub.c:75:
  +    gdbserver_state.accel_config.sstep_flags = accel_supported_gdbstub_sstep_flags();
  WARNING: line over 80 characters
  #582: FILE: target/i386/kvm/kvm.c:6167:
  +static int find_hw_breakpoint(target_ulong addr, int len, GdbBreakpointType type)

----------------------------------------------------------------
Accelerators patches queue

- Various cleanups around debugging APIs
- Correctly check singlestep flag enabled in CPUState
- Fix possible memory corruption with MSHV (CID 1660876)
----------------------------------------------------------------

Magnus Kulke (1):
  accel/mshv: Fix pointer to proc feature bitfield

Philippe Mathieu-Daudé (30):
  cpu: Constify CPUState::cc (cached CPUClass pointer)
  target/i386: Remove duplicate tlb_flush() call in cpu_post_load()
  accel/tcg: Restrict tlb_protect/unprotect_code() to TCG
  accel/hvf: Remove left-over comment
  accel/mshv: Replace @dirty field by generic CPUState::vcpu_dirty field
  gdbstub: Add trace event for STEP packet handler
  gdbstub: Only return E22 when reverse GDB is not supported
  accel/whpx: Implement missing
    AccelClass::gdbstub_supported_sstep_flags
  accel/kvm: Always define AccelOpsClass::supports_guest_debug
  accel/kvm: Simplify kvm_init() w.r.t. TARGET_KVM_HAVE_GUEST_DEBUG
  accel/kvm: Hold have_guest_debug in KVMState
  gdbstub: Reduce gdb_supports_guest_debug() scope
  gdbstub: Move supported_sstep_flags in AccelGdbConfig structure
  accel: Have each implementation return their AccelGdbConfig
  gdbstub: Make default replay_mode value explicit in stubs
  accel: Hold @can_reverse information in AccelGdbConfig
  accel: Remove AccelOpsClass::supports_guest_debug
  cpu: Move BREAKPOINT definitions to 'exec/breakpoint.h'
  accel: Remove unnecessary 'inline' qualifier in remove_all_breakpoints
  gdbstub/user: Directly call gdb_breakpoint_remove_all() in user mode
  gdbstub: Reduce @type variable scope
  gdbstub: Introduce GdbBreakpointType enumerator
  accel: Use GdbBreakpointType enum
  target/arm: Inline check_watchpoints() in arm_debug_check_watchpoint()
  target/ppc: Ensure TCG is used in ppc_update_daw()
  accel/tcg: Improve docstrings around TCGCPUOps::*watchpoint* handlers
  cpu: Better name cpu_single_step() trace event
  cpu: Introduce cpu_single_stepping() helper
  cpu: Rename CPUState @singlestep_enabled -> @singlestep_flags
  cpu: Only check SSTEP_ENABLE flag in cpu_single_stepping()

Richard Henderson (1):
  cpu: Move cpu_breakpoint_test out of line

 docs/system/gdb.rst                |  2 +-
 accel/kvm/kvm-cpus.h               | 12 ++++---
 accel/tcg/system-page-protection.h | 17 ++++++++++
 gdbstub/internals.h                | 12 ++++---
 include/accel/accel-cpu-ops.h      | 10 +++---
 include/accel/accel-ops.h          |  5 ++-
 include/accel/tcg/cpu-ops.h        |  5 ++-
 include/exec/breakpoint.h          | 14 ++++++++
 include/exec/cputlb.h              |  8 ++---
 include/gdbstub/enums.h            | 12 ++++---
 include/hw/core/cpu.h              | 49 +++++++++-------------------
 include/qemu/accel.h               | 13 +++++---
 include/system/hvf_int.h           | 14 ++++----
 include/system/kvm.h               |  9 ++++--
 include/system/mshv_int.h          |  1 -
 include/system/whpx-all.h          |  3 --
 target/arm/internals.h             |  5 +--
 accel/accel-common.c               | 15 +++------
 accel/hvf/hvf-accel-ops.c          | 23 +++++++------
 accel/hvf/hvf-all.c                |  8 ++---
 accel/kvm/kvm-accel-ops.c          |  7 ++--
 accel/kvm/kvm-all.c                | 52 ++++++++----------------------
 accel/mshv/mshv-all.c              | 22 ++++++-------
 accel/tcg/cpu-exec-common.c        |  2 +-
 accel/tcg/cpu-exec.c               | 12 +++----
 accel/tcg/cputlb.c                 |  3 +-
 accel/tcg/tb-maint.c               |  1 +
 accel/tcg/tcg-accel-ops-rr.c       |  2 +-
 accel/tcg/tcg-accel-ops.c          | 22 ++++++-------
 accel/tcg/tcg-all.c                | 30 ++++++++---------
 accel/tcg/translate-all.c          |  3 +-
 accel/whpx/whpx-accel-ops.c        |  6 ----
 cpu-common.c                       | 15 +++++++++
 cpu-target.c                       | 10 +++---
 gdbstub/gdbstub.c                  | 18 ++++++-----
 gdbstub/system.c                   | 37 ++++++++-------------
 gdbstub/user.c                     | 20 +++---------
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 stubs/replay-mode.c                |  2 +-
 system/cpus.c                      |  2 +-
 target/arm/hvf/hvf.c               | 27 +++++++---------
 target/arm/hyp_gdbstub.c           |  8 ++---
 target/arm/kvm.c                   | 14 ++++----
 target/arm/tcg/debug.c             | 40 ++++++++++-------------
 target/arm/whpx/whpx-all.c         |  5 ---
 target/i386/hvf/hvf.c              | 13 +++-----
 target/i386/kvm/kvm.c              | 14 ++++----
 target/i386/machine.c              |  1 -
 target/i386/mshv/mshv-cpu.c        |  6 ++--
 target/i386/whpx/whpx-all.c        | 13 +++-----
 target/loongarch/kvm/kvm.c         | 10 +++---
 target/microblaze/translate.c      |  2 +-
 target/ppc/cpu.c                   |  2 ++
 target/ppc/kvm.c                   | 14 ++++----
 target/ppc/translate.c             | 16 ++++-----
 target/riscv/kvm/kvm-cpu.c         |  8 +++--
 target/s390x/kvm/kvm.c             | 10 +++---
 trace-events                       |  2 +-
 59 files changed, 338 insertions(+), 374 deletions(-)
 create mode 100644 accel/tcg/system-page-protection.h

-- 
2.53.0


