Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F162C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegWg-0002X1-Ho; Tue, 30 Jun 2026 18:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegVy-0002S3-EE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegVv-0003UK-Bd
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDc9i2959972
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OPRtoS8bCmRfUJtgYIN+9z
 G8WE6m801BhasHkzEbwes=; b=GeZIJpSHOdeb9nH5x1z+rVGrq6IZO5fO4sMHdv
 dIF/Nm1Pi2/9uOavcFtXWmSFfRwBNqXuhScIujhQd8T/aurWHrcAQxES+vEjK1CN
 NGDC/GPTOVZknZoBZ2vPqMZ2d8g3F4lj6hql4NrqzkCNZHBQ45N9fklGTvLbneTh
 ZjHrXdq3eETUVxVh/bKi0zUZ8c4mNz5tnGXsL9Emc6z5RNdDYM/Zrt0d9M4G4D5c
 mXqf+5weGnJp10SVdgXxS1nEjhkd/qu+WN9Jys2TEfB+3mSKmvfbMlH4LLb+WN5a
 rxF6qol61UDFhCUp5ERwHinOHl7rIHbKjgqquUD3JWXSt7Bw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j9113hv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:04 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9674d6a4ca4so5112421241.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856864; x=1783461664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OPRtoS8bCmRfUJtgYIN+9zG8WE6m801BhasHkzEbwes=;
 b=DmBnmegwrS5I71YxeZfI53rOTXV4VvOOsoxsihismCbCwxkgSotFZ/SOmkbIWgURvZ
 WOoVVt8DXTZ0OHVNhBbCj29hJRoqo5UV4W04nSTEOod35AI0cUQ/3G1lhXWc5ZimtgXW
 4h87mcQM9+UwDWwpyT3XUDz39gdRlY/97xfIfsatZ9x+KJYF7CxFFSljfovwFU/LiVeJ
 NYZec9HJwqSSCW8Sv1jr0jHoNjLoPC12qGqApazYbaswjXbU59aWXEPt0y9WJYzLHGF7
 SQvPQCnbtbx4puqcZ2sCTCl7mInRSfkLT2eBgX3oQS8+A+1D3IVgJYkvduMS0wRQ7c69
 baWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856864; x=1783461664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPRtoS8bCmRfUJtgYIN+9zG8WE6m801BhasHkzEbwes=;
 b=Jb1ZO838iA2wlka3GiFr0R6Tqwg3mnDi7aW6Vg+ap3hByJQVfbrnZdic2xc6lGX0wK
 bCPB2Vz4qhqQVK1d+Zcx860bjNNxbl3p2lFHYcE4GBQSlFGV0KHve9cOpBpacwvqjlNo
 /BdulA+NfVWfwyvUQ6U5z+iTLWa8dnwgJv1aGb5NbWPM74oZrPvswyDpffyNyXz7pQS3
 qIwRW6D8g4DZ6U3lb/iquBsL7AQrvJ7csLiNGnSYZXFZtapgsvyve3TNI+Hfyl9t9Ohq
 T2+k5wC8S8LiJiO3kMpTxYCY7BJX6B1Of8JHG4qNQ2xVjjszOsm5mobPTkhsPLzwoW+d
 W6vQ==
X-Gm-Message-State: AOJu0YyK4O1bStfcDSQkZGPdf7xgIo+7w7AbAs7aj/hPzYlzJzrheknw
 rUjIbd+nPvkvVOuwsn1K1DPMT5/JjvnlsVXI4Ccykf2Iiw/H37WUfh6dbKCu0NkfbcdtvhPdKno
 954m+Ns5wChn55ybjGyVlJFYz4qi0828VBkXTszJ1ovVkDn+jDyakrYURsIr1MXy0YA==
X-Gm-Gg: AfdE7cneR1STqMgw6RzH/wfVZICjn5Y9+1WC/Awsvcgug8yE0Jx064f5Inrik2rk/fk
 QMI5EfC05BtuOFye1vJ5EQj0eTFDFwYcKQog1CC0P8H3rjrkV5CTnHO+BUZ4bcfNfyVq+Y2GaUy
 9VwoXosABgQ/qmT7gYi6ZRPlaUFdIuuZy6ZsA2pFd2J5P+BssgQ/Gq2VEnuQk94hzjciUg9EUCt
 O8FLP8ckFxFQ+ccmY8o/DqKM3VzeKsdUTxKI8F7Dng+q2OgxzdRGfXT3EMDLB/LVelRsRo9SbqF
 zZ8K5LYh5wxLw5K5m4P8XP7qnlNZOsA/vRIC5t5gIbkDZXPAGYSqw4DrthV9SVVhV7tMuqqL/KS
 1qO5PSFji/KRRr5LEWCwsIi87pQsJHwoU0/xiA1iSxMqCcfQuqhX2Bkbap3pbG19l3qqG
X-Received: by 2002:a05:6102:94c:b0:6c5:d55d:c096 with SMTP id
 ada2fe7eead31-73a3813288amr3218111137.16.1782856863647; 
 Tue, 30 Jun 2026 15:01:03 -0700 (PDT)
X-Received: by 2002:a05:6102:94c:b0:6c5:d55d:c096 with SMTP id
 ada2fe7eead31-73a3813288amr3218048137.16.1782856862931; 
 Tue, 30 Jun 2026 15:01:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfc32992sm8921235e9.11.2026.06.30.15.01.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 00/33] accel: Unassorted cleanups around debugging
Date: Wed,  1 Jul 2026 00:00:27 +0200
Message-ID: <20260630220100.1289-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R4TVeG_kheA8scg8PB_l7XSOJPsDpQCf
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a443ca1 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=WQsqrIFglPMf3GDb8uYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: R4TVeG_kheA8scg8PB_l7XSOJPsDpQCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX6ezpYbFrrNdo
 4BtquFowNuW+NQaNnVOppC1Z9k7hzUGgSuBE6PxXM7otTCYjT93c9aDYuw0OO2TL8wUrtZJkMrx
 1GlO89uUN/NwKMyDS7MOKVRcqemGsfmXQo7vziHr2+MhusdhTqf6g2B18gi+E1xA/LxDfreX0Kz
 g8m6pi9uEpxavkKPB7Pw+IxWM+2PGQ4cjWdosMxabJ5w5OJOuFuzUE43cHE47GaRbZy+oWvxZbI
 u4OPJyn4OdX8CFw6/VMhuGIDyKaX+RWuVtin6B7AcJYtR87Nl7s7KFxUcwQUON7Wv3G0Nf34YDL
 NU9uzPk3mkhTKPeWFsFOnU43l+IC/wBxCiO8D1f4Qpc9OjvxqIKqlRUHDEHFrxg4DAjK/EDQHFu
 OhBZxVfTJ6O1Cbp/L/zRJPYksorrOBlQavp/ZkCIDmFYI1xH086hsU/hplXKOZZuBovnX/VXWZz
 o1m/4XnrUOvDI2un0xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX0KnXDw6UvJ/f
 Hkx26S8QZe3aGSlOAWhbPdYeWab7fXJJ3/WemI0XTQ87es9OdQkQXivMW5lr3ldVRxHvaskFhan
 +xnsG6Vhan+wgQZMIAIa47Ux/CQEJ/Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Refreshing the `split-accel' preparatory work; this series follows
"accel: Preparatory cleanups for split-accel" from last year:
https://lore.kernel.org/qemu-devel/20250703173248.44995-1-philmd@linaro.org/

Nothing really noteworthy here, generic code refactoring with the
objective to strengthen the various APIs, introducing few enums or
headers.

Philippe Mathieu-Daudé (33):
  cpu: Constify CPUState::cc (cached CPUClass pointer)
  target/i386: Remove duplicate tlb_flush() call in cpu_post_load()
  accel/tcg: Restrict tlb_protect/unprotect_code() to TCG
  accel/hvf: Remove left-over comment
  accel/mshv: Replace @dirty field by generic CPUState::vcpu_dirty field
  gdbstub: Add trace event for STEP packet handler
  gdbstub: Only return E22 when reverse GDB is not supported
  accel/kvm: Always define AccelOpsClass::supports_guest_debug
  accel/kvm: Simplify kvm_init() w.r.t. TARGET_KVM_HAVE_GUEST_DEBUG
  accel: Change gdbstub_supported_sstep_flags() -> get_gdbstub_config()
  gdbstub: Store @can_reverse in GDBState
  gdbstub: Make default replay_mode value explicit in stubs
  accel: Have get_gdbstub_config() return @can_reverse value
  accel: Move supports_guest_debug() declaration to AccelClass
  accel/kvm: Hold have_guest_supported in KVMState
  accel/kvm: Hold gdbstub_sstep_flags in KVMState
  cpu: Move BREAKPOINT definitions to 'exec/breakpoint.h'
  cpu: Define BreakpointFlags type
  accel: Remove unnecessary 'inline' qualifier in remove_all_breakpoints
  gdbstub/user: Directly call gdb_breakpoint_remove_all() in user mode
  gdbstub: Reduce @type variable scope
  gdbstub: Introduce GdbBreakpointType enumerator
  accel: Use GdbBreakpointType enum
  target/arm: Inline check_watchpoints() in arm_debug_check_watchpoint()
  target/arm: Factor arm_check_watchpoint_hit() out
  target/xtensa: Move watchpoints handling to check_hw_watchpoints()
  target/ppc: Ensure TCG is used in ppc_update_daw()
  accel/tcg: Improve docstrings around TCGCPUOps::*watchpoint* handlers
  cpu: Move CPUWatchpoint definition to 'exec/watchpoint.h'
  cpu: Better name cpu_single_step() trace event
  cpu: Introduce cpu_single_stepping() helper
  cpu: Rename CPUState @singlestep_enabled -> @singlestep_flags
  cpu: Only check SSTEP_ENABLE flag in cpu_single_stepping()

 accel/kvm/kvm-cpus.h               | 12 +++--
 accel/tcg/system-page-protection.h | 17 +++++++
 gdbstub/internals.h                | 10 ++--
 include/accel/accel-cpu-ops.h      | 10 ++--
 include/accel/accel-ops.h          |  4 +-
 include/accel/tcg/cpu-ops.h        | 12 +++--
 include/exec/breakpoint.h          | 26 ++++++----
 include/exec/cputlb.h              |  8 +--
 include/exec/watchpoint.h          | 20 ++++++--
 include/gdbstub/enums.h            | 12 +++--
 include/hw/core/cpu.h              | 42 ++++++++--------
 include/qemu/accel.h               | 10 ++--
 include/system/hvf_int.h           | 11 ++--
 include/system/kvm.h               |  9 ++--
 include/system/kvm_int.h           |  2 +
 include/system/mshv_int.h          |  1 -
 include/system/whpx-all.h          |  4 +-
 target/arm/internals.h             |  6 ++-
 accel/accel-common.c               | 22 ++++++--
 accel/hvf/hvf-accel-ops.c          | 23 ++++-----
 accel/hvf/hvf-all.c                |  9 ++--
 accel/kvm/kvm-accel-ops.c          |  7 ++-
 accel/kvm/kvm-all.c                | 55 +++++++++++---------
 accel/mshv/mshv-all.c              | 18 +++----
 accel/tcg/cpu-exec-common.c        |  2 +-
 accel/tcg/cpu-exec.c               | 12 ++---
 accel/tcg/cputlb.c                 | 15 +++---
 accel/tcg/tb-maint.c               |  1 +
 accel/tcg/tcg-accel-ops-rr.c       |  2 +-
 accel/tcg/tcg-accel-ops.c          | 31 ++++++------
 accel/tcg/tcg-all.c                | 16 ++++--
 accel/tcg/translate-all.c          |  3 +-
 accel/tcg/user-exec-stub.c         | 11 ++--
 accel/tcg/watchpoint.c             |  9 ++--
 accel/whpx/whpx-accel-ops.c        |  7 ---
 accel/whpx/whpx-common.c           |  1 +
 cpu-common.c                       |  8 +--
 cpu-target.c                       | 10 ++--
 gdbstub/gdbstub.c                  | 11 ++--
 gdbstub/system.c                   | 39 ++++++--------
 gdbstub/user.c                     | 20 ++------
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 stubs/replay-mode.c                |  2 +-
 system/cpus.c                      |  2 +-
 system/watchpoint.c                |  8 +--
 target/arm/hvf/hvf.c               | 24 +++++----
 target/arm/hyp_gdbstub.c           |  9 ++--
 target/arm/kvm.c                   | 14 +++---
 target/arm/tcg/debug.c             | 81 +++++++++++++++---------------
 target/arm/tcg/mte_helper.c        |  3 +-
 target/arm/whpx/whpx-all.c         |  2 +-
 target/i386/hvf/hvf.c              | 10 ++--
 target/i386/kvm/kvm.c              | 15 +++---
 target/i386/machine.c              |  1 -
 target/i386/mshv/mshv-cpu.c        |  6 +--
 target/i386/whpx/whpx-all.c        |  8 +--
 target/loongarch/kvm/kvm.c         | 10 ++--
 target/microblaze/translate.c      |  2 +-
 target/ppc/cpu.c                   |  4 +-
 target/ppc/kvm.c                   | 20 +++++---
 target/ppc/translate.c             | 16 +++---
 target/riscv/cpu_helper.c          |  2 +-
 target/riscv/debug.c               | 12 ++---
 target/riscv/kvm/kvm-cpu.c         |  8 +--
 target/s390x/kvm/kvm.c             | 11 ++--
 target/s390x/tcg/debug.c           |  3 +-
 target/xtensa/dbg_helper.c         |  2 +-
 target/xtensa/helper.c             | 36 ++++++-------
 trace-events                       |  2 +-
 70 files changed, 477 insertions(+), 388 deletions(-)
 create mode 100644 accel/tcg/system-page-protection.h

-- 
2.53.0


