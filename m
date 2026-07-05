Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC33C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUqH-0003qv-5o; Sun, 05 Jul 2026 17:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqG-0003qY-3G
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqE-0008IF-4B
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HwYdx2356825
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OOjf9rHH+JM9UN/KlN0AGV
 yepe49+U2eqcBiVjSDrbM=; b=TWXKQPElPZYXa2aEO+vqXSIeuDxIK6OjUG8Vvr
 e5j9REch0h+jfe7Gg4qD9APSjmDcRcwKHdKV1E4dUCyUBpMq2VW8PaLRUi9WA09D
 bh7jURq4PIr3oozgLEOYDxno+FL9UvpPllqSrkIWV+kwmN21NXCqiSJ72avyHEDK
 39fDv723DOgpuX1PWst5sqLolnGuT8BhLIQGlPMA31MUnWAuekETP95BvW2Teio2
 61bX85CXIVXZNKjO0o9unIL+PnCgs6lGm8/ctrP0jAKXOk93+NZ9qzghbAOyoMPl
 uDitSZ9XfAACHSh7noetj8FVdqz0IyK1JgK2N+yscCtNBwOw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh3k5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:57:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so261502185a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288652; x=1783893452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OOjf9rHH+JM9UN/KlN0AGVyepe49+U2eqcBiVjSDrbM=;
 b=LRS15VOxjA9Mi4H0FsiWbkb+BH+x7p3qx4lf6VwvDWn415x8ndBMSBgVUFZ0SvT2M8
 Ab7WXwL61XlW9RX9Oss1pxK6se/qUftn05yBP6yO63WT4x7Nbf6GHb8JS0rCxCAQHPPt
 J2+dl6Ipjj8x5SuNyZtBSiaStq9ScAYJwy5SvwTqz65x+IDDdWNg5tRCJly5ovUH2FX4
 ejrhCmUiVqtkvSULAsiVCACD9ZqTLXxhXA8Crxc1vbSvtHqlfeZSZ+SzpbTl9uD1vuht
 0aIE0Q7fTsLqAIzSkFcqkubbz6nWgioGxDws4XumukQ7/kkeirV/21TgXl5IBpKi5rrP
 d+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288652; x=1783893452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOjf9rHH+JM9UN/KlN0AGVyepe49+U2eqcBiVjSDrbM=;
 b=Rh5XlRVzZ13yGwaFSp6lrFU1/7mu4zBN4zxmA5grW+sxlDfcNoanTj9ajbEdqIZD+e
 FguWTQykCWSPL40JhA57fGOmpm0Pfr8ICkDMABDIIK8xQ4KZk2RtWYIaqEpHRnUC8l8z
 hMx+x90ZU2Peoz/pUZHJIyMe2ujQzaTZTB3qXgvjIKokP/vM/3BcizmqsoyhE5TGcdNR
 Worb79eev+dnwLZ2ghn+PhM23RaipELPVZxH/o98o14zS9hYluRfEV49IyxKfZx3cBIa
 ilgTqSgIN/MRZ/bBsElqkkN2j5ter9Txe/Lx7GtVCm0Zkw4I8IkCecrXRR8yJTA424Ip
 EUWQ==
X-Gm-Message-State: AOJu0YypjOWxgtkHfA/LdhTSLs+Kp1N3NSRdt2Wuo6b67a1nrgWC9Xld
 gGcdIamk0hXFHa8Dvrdyja92fMASW2ZmWym6yFNlpbH0hg5UVuys3Cj7VDWi0dS82SqrSUsSZRe
 8+p0rk1TAePV/ldncL+cBz/Z0e9J/MHXPA5l5f1qi6DriW244Vf46+ESCgMjpLyeMaw==
X-Gm-Gg: AfdE7ckGzTj4U0vh4qhHhOU2oEEfcOU4HG2G98ICf/DWtDTZGE40toZRvIyvPft5uQV
 av0vZqZPOdwnj0s3I3uJYCac9rlZ1RJXibf+J8crMMpbsWzlh20G5DLA7rzTUmRk7uVZwqOmd0a
 jFJQN1Eiag12QjLc4nKYd2LFfgu0qI/WH0yHT0QiE/B4XUcCplt+na4Aubb0kIWSACW43TeC1J3
 GfobUiXLga5za6fCFvR5VTglTIJsBw41tHLvbg76pg0vud4RziTuNkTjhy3BPRvLe6lGk2dHhn+
 9Nip0ecZqsiFqF9CRhVS7yGuNR5vTmT5ScWZXjk9+eXsE+gnyl4OJS8+NFS9hlPJw28Xpm3BUyh
 JPG4BsXL81QzNO5/z0U8ltUS6VeZwttIQ2fnOSdS8NOcglqXvY6qgCSDSxyaOobeMhUI7
X-Received: by 2002:a05:620a:2916:b0:92b:c6cd:7f6c with SMTP id
 af79cd13be357-92e9a4812ebmr950399285a.34.1783288651937; 
 Sun, 05 Jul 2026 14:57:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2916:b0:92b:c6cd:7f6c with SMTP id
 af79cd13be357-92e9a4812ebmr950396385a.34.1783288651480; 
 Sun, 05 Jul 2026 14:57:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba97csm308521365e9.12.2026.07.05.14.57.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:57:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 00/32] accel: Unassorted cleanups around debugging
Date: Sun,  5 Jul 2026 23:56:56 +0200
Message-ID: <20260705215729.62196-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4ad34c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=u3oD29KnDJWlspFxzVoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX0tHVj4Zb4m6M
 5OcX1K9iD4eS4XN1cs7diml7LwT+Fk+AaXwkgPZlD/oWzTpi7TfYxMGYC7Qo3tkXZIzeoM5auef
 dZGJc+tFNfauarNa86baz2cMk6qIjrdodV7fFNLB7+3qW5QBhDuRWqNDaSnI/9TH0M/M6m3Mv7M
 zHxUmMlWITTrLvBh0GQGdnojCL4f8FN+TkvwdrQYVOVbpOh94yHY+wraOI4KzUMjPd89su+BjOn
 II/wTqCRpJGjngIIa1IzgaFtorB4Lje64Z9/xz9jb/H3PNpbrg6wA6jtp1zCApm8jiL0DLcTAk/
 sFtw4QG7s5C2b/wBwRyOFjcbEuIkElcaDthDLTXdy43WVRPrdEES6VaXsJmNp3KZ0gMqTbthwJI
 DdwHWBhY15bmiBiGsSJHldboPwlDhqvo6AsGGy1yHa05gKEKDPQxBPO8SXZAbn3rnIcGoXfzB0S
 OqWNivd+lAy53JXu7ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX3NNT0bvdG66Q
 WpMrG/7Z5qhao2OGQFpyw7NKqN9ewWID0fwFyFNPBD+lvuYxLa8KPlS+kxTznzZE9YndZrMWuB9
 is5INrmFAjceUPVEKUbXusqWut5LCcw=
X-Proofpoint-ORIG-GUID: hp1JpYxw2yzPCUJZFPw7-SWkSIGqgwyQ
X-Proofpoint-GUID: hp1JpYxw2yzPCUJZFPw7-SWkSIGqgwyQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050237
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

Missing review: 16

Since v2:
- Fixed gdb_can_reverse (patch #16)
- & -> mask, == -> flags (patch #20)
- Dropped patch #29 (Move CPUWatchpoint def)

Since v1:
- Introduce AccelGdbConfig structure (Alex)
- Dropped target-specific Breakpoint/Watchpoint changes
  (Richard working on it)

Refreshing the `split-accel' preparatory work; this series follows
"accel: Preparatory cleanups for split-accel" from last year:
https://lore.kernel.org/qemu-devel/20250703173248.44995-1-philmd@linaro.org/

Nothing really noteworthy here, generic code refactoring with the
objective to strengthen the various APIs, introducing few enums or
headers.

I'm quite pleased with the total diff-stat.

Philippe Mathieu-Daudé (31):
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
  cpu: Define BreakpointFlags type
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
 include/accel/tcg/cpu-ops.h        | 11 ++++---
 include/exec/breakpoint.h          | 19 +++++++++--
 include/exec/cputlb.h              |  8 ++---
 include/exec/watchpoint.h          |  6 ++--
 include/gdbstub/enums.h            | 12 ++++---
 include/hw/core/cpu.h              | 53 ++++++++++--------------------
 include/qemu/accel.h               | 13 +++++---
 include/system/hvf_int.h           | 14 ++++----
 include/system/kvm.h               |  9 +++--
 include/system/mshv_int.h          |  1 -
 include/system/whpx-all.h          |  3 --
 target/arm/internals.h             |  5 +--
 accel/accel-common.c               | 15 +++------
 accel/hvf/hvf-accel-ops.c          | 23 +++++++------
 accel/hvf/hvf-all.c                |  8 ++---
 accel/kvm/kvm-accel-ops.c          |  7 ++--
 accel/kvm/kvm-all.c                | 52 ++++++++---------------------
 accel/mshv/mshv-all.c              | 18 +++++-----
 accel/tcg/cpu-exec-common.c        |  2 +-
 accel/tcg/cpu-exec.c               | 12 +++----
 accel/tcg/cputlb.c                 | 15 +++++----
 accel/tcg/tb-maint.c               |  1 +
 accel/tcg/tcg-accel-ops-rr.c       |  2 +-
 accel/tcg/tcg-accel-ops.c          | 31 ++++++++---------
 accel/tcg/tcg-all.c                | 30 ++++++++---------
 accel/tcg/translate-all.c          |  3 +-
 accel/tcg/user-exec-stub.c         |  9 ++---
 accel/tcg/watchpoint.c             |  9 ++---
 accel/whpx/whpx-accel-ops.c        |  6 ----
 cpu-common.c                       | 19 +++++++++--
 cpu-target.c                       | 10 +++---
 gdbstub/gdbstub.c                  | 18 +++++-----
 gdbstub/system.c                   | 37 ++++++++-------------
 gdbstub/user.c                     | 20 +++--------
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 stubs/replay-mode.c                |  2 +-
 system/cpus.c                      |  2 +-
 system/watchpoint.c                |  4 +--
 target/arm/hvf/hvf.c               | 27 +++++++--------
 target/arm/hyp_gdbstub.c           |  8 ++---
 target/arm/kvm.c                   | 14 ++++----
 target/arm/tcg/debug.c             | 44 +++++++++++--------------
 target/arm/tcg/mte_helper.c        |  3 +-
 target/arm/whpx/whpx-all.c         |  5 ---
 target/i386/hvf/hvf.c              | 13 +++-----
 target/i386/kvm/kvm.c              | 14 ++++----
 target/i386/machine.c              |  1 -
 target/i386/mshv/mshv-cpu.c        |  6 ++--
 target/i386/whpx/whpx-all.c        | 13 +++-----
 target/loongarch/kvm/kvm.c         | 10 +++---
 target/microblaze/translate.c      |  2 +-
 target/ppc/cpu.c                   |  4 ++-
 target/ppc/kvm.c                   | 19 ++++++-----
 target/ppc/translate.c             | 16 ++++-----
 target/riscv/cpu_helper.c          |  2 +-
 target/riscv/debug.c               | 12 +++----
 target/riscv/kvm/kvm-cpu.c         |  8 +++--
 target/s390x/kvm/kvm.c             | 10 +++---
 target/s390x/tcg/debug.c           |  3 +-
 target/xtensa/dbg_helper.c         |  2 +-
 trace-events                       |  2 +-
 68 files changed, 392 insertions(+), 417 deletions(-)
 create mode 100644 accel/tcg/system-page-protection.h

-- 
2.53.0


