Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C58C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgtz-0004hT-SA; Fri, 03 Jul 2026 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgty-0004h5-NV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgtv-0007Xs-MC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:06 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIa4U511014
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CJbRyshi9CsvFZ4EyOTGbI
 RPR1nYFWylHNhq29L8jDs=; b=HQ/AnxsvOl+2DvmLQyz6gg6qPLpEbmemGT7BHy
 8peqIivB1NpOT/akxugRrc1RR4KX2i5Pow2/qVC7JwfU12NVf0indhzY9BE19vTX
 au/ZbuSoAdOKvDQmf0srhMW/eJK165hi6oZh0KHGVRSlouZsnsVkBSRyV3P7yukC
 IgcI3vkMn9krsI5+AZV05drWHREYLV9cd1TN6Yj5DpEtmNVFCsDo448IM/FxA5LI
 LvD01yHfQwyI/fClWUmdWrq+32Ws3gZPeh3pAV7qHflcyh8Ndg/3S+OwSHgKT8Wl
 bAJ2P69R7cL0bfH4FhkHAudEz+C/sop9ig2zVyAgl0L0uoVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a849k0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e623b0e95so64290085a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096680; x=1783701480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CJbRyshi9CsvFZ4EyOTGbIRPR1nYFWylHNhq29L8jDs=;
 b=K5hvltpZf0zLJ7VS6lf16AI/RaxRu6Y9zKr2U5Pb1UmjbmwDpc00Qbt06L1zg6UgjS
 Ezg711C+rWQGxDGm0zVrHWySfIEFmI3XbNKAe0BWPOPFP3kl0qg/5FGagf9EQblJQxF+
 o+nZAOhOyDhGFhwc9LWqpTXqwZTffz93dudTb2A1CUDY7fguuFlxr7R9lr+7mbOixmeD
 7E+NophSsk6afdWD5PT3GAgpFKuZk6ff2ZcJOln9FYb+eNcjIhIMh2SKgNM9X5V5JJFa
 MXlVfNAS6EIYPa6KtyFwLJrHvcIUZzRF+nGITIXyBflibcl78Ff/osQe0jLfvlrXbDd4
 z2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096680; x=1783701480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJbRyshi9CsvFZ4EyOTGbIRPR1nYFWylHNhq29L8jDs=;
 b=KdkHFllW/SodRIqD33u1SS5bbDq1P8zdxbXKWqq4UkIPt6ND8kD2IXSjyIFCmfYJGE
 RFn/8q4oGyhrbehFDUN3C7V4XFjszoYkosOyU3/k2Bz9aBsGPUDoM7U0mDSwO3UCSEgY
 7bx8ZHC6QHQl6MzuYBFiLPqQDpRZPsiTuvPHi/R44X86ij9GNNn+7cN2VLkuhQ+vUPsN
 q93jQVuqLovrdqP+57z36kR2kWvj7ZO19lic6M61ClPAsj9ww/TbW745AyJqZ/624H3v
 w3auKaKI6NSCxElh9OjCS/5i1Ww0xZ+qKgGUlLCOzQL4dHcYOLRaaDx/n2gd8VMrhgWI
 BMeQ==
X-Gm-Message-State: AOJu0YxN8AWVRZ586OJYXcTEL+CxvUteD8GqB+sAAutxgXEoKSf0JQ78
 fuK3bnt5KwoYgMMHNWXs1nlP3evqHRfEH6QXMBVULntEzc+vtPxjaJQMll4zAzDj46zCHPjKMNN
 kfU6YsrZuYR/1Ou3u3zTLHkfYVa8bPZsg3PHMa/79pXyJvzn68l7PLKdUHvJjxzF9/A==
X-Gm-Gg: AfdE7cnYx8ailw/VgK83bM4V3HaEPwCZKbn9gwH3lBzE3oX7Ww7T8DwKURnExkLgQdY
 mDskqwmP4Bl6+bnHv7DUNOfAAA7uKSI+dGWlYaOvssBJs6pmWTcXU58Nv/bdZ5Cfd5ubKIlQIkA
 m3rybTvvlWc92dm3ZcPi8KEWQCiCTl1sPzIfP8AZUHWyhh/gp3iLQuRYsRuY0rqQVHywZi6Lf64
 45bA4mJvMLLlLkrb6FfbY7xuk1qiktD12cDgQ/kJ1gLxKtsENBm51PRi97QXSf/tKAIL/uYJzq7
 hT1yp1pzkLp4bnKf+hCPE4IzaPzGbqpBPZyos6LeMkkBHpGbKt96xWH9JuQmuJcpZ8hZ/2I09/V
 hJOwojNbr3F4ZqFgtqkNdX3GW+SeWw3R8q82ipYxxpR1l4QKJMsssZyDTRZdWfzkO57mE
X-Received: by 2002:a05:620a:6186:b0:915:a894:1b43 with SMTP id
 af79cd13be357-92e9a3b6736mr27813785a.28.1783096680394; 
 Fri, 03 Jul 2026 09:38:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6186:b0:915:a894:1b43 with SMTP id
 af79cd13be357-92e9a3b6736mr27807985a.28.1783096679859; 
 Fri, 03 Jul 2026 09:37:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6381e4fsm168378615e9.8.2026.07.03.09.37.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:37:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 00/33] accel: Unassorted cleanups around debugging
Date: Fri,  3 Jul 2026 18:37:23 +0200
Message-ID: <20260703163757.55500-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BeIKIXQ-3JSJSvzkzhjjgsN1aC5-ML1p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX0nE+8wCmrVZy
 A4bDkLev/tbm5HcUbkfPccs3Sp30JC2E7uCNvOobUgxVcbQu7bNxMMHLXp0CJsE+SVWt1hJj0r3
 D3fC6+QYkIk1v52Geq7UKj+ZZ3T2Bkw=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a47e569 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=u3oD29KnDJWlspFxzVoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX1m4K9nRZTL/n
 3Rj1Qjlb21jew/vdsY9WA7yzhhqA+Y3otPNgT6pJOnZ9uncCyfwgAfebCk30D7B9gsXp4pNk58e
 efSWdVUJZze7zPp7imaIR0XzgJwH7pnyBZ+dxuALVgWv8rojUxBpV8GK1t5SvdV2v7Ru9Bllmvi
 606iLkmvL70wVGfeKUpk9fOTR6j+fXLdthFCAvu5dlSdX+dBSAN4x+XGvZySUJFHOn7ZfbnbHBV
 U8VDARlh6A0vElcIQ+P0s25LgkpiOr9kTCBRsR1HjFrK7IV+dDljDViSVXMmfPrzMBNln5Tuy89
 ZkfCQ8IwEYp8cA3aFZMQF/B8Ae/0+Kiy0ppYALz5jiaAB7j1gACmuM75Z+b9OaXZymM8uohVKiE
 IO9Bu62IcTqeWiVa+pRyR4IBr8N+3P7CnJUzNhcR4YHFZ8we4RZ47FmqX3Wykw3D5aRXTa4ng55
 w5JZ4vnfGhqhSOOzVoA==
X-Proofpoint-ORIG-GUID: BeIKIXQ-3JSJSvzkzhjjgsN1aC5-ML1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

Missing review: 12-17 (AccelGdbConfig rework)

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

Philippe Mathieu-Daudé (32):
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
  gdbstub: Inline gdb_supports_guest_debug()
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
  cpu: Move CPUWatchpoint definition to 'exec/watchpoint.h'
  cpu: Better name cpu_single_step() trace event
  cpu: Introduce cpu_single_stepping() helper
  cpu: Rename CPUState @singlestep_enabled -> @singlestep_flags
  cpu: Only check SSTEP_ENABLE flag in cpu_single_stepping()

Richard Henderson (1):
  cpu: Move cpu_breakpoint_test out of line

 docs/system/gdb.rst                |  2 +-
 accel/kvm/kvm-cpus.h               | 12 ++++---
 accel/tcg/system-page-protection.h | 17 +++++++++
 gdbstub/internals.h                | 12 ++++---
 include/accel/accel-cpu-ops.h      | 10 +++---
 include/accel/accel-ops.h          |  5 ++-
 include/accel/tcg/cpu-ops.h        | 12 ++++---
 include/exec/breakpoint.h          | 26 ++++++++------
 include/exec/cputlb.h              |  8 ++---
 include/exec/watchpoint.h          | 20 +++++++++--
 include/gdbstub/enums.h            | 12 ++++---
 include/hw/core/cpu.h              | 57 +++++++++++-------------------
 include/qemu/accel.h               | 13 ++++---
 include/system/hvf_int.h           | 14 ++++----
 include/system/kvm.h               |  9 +++--
 include/system/mshv_int.h          |  1 -
 include/system/whpx-all.h          |  3 --
 target/arm/internals.h             |  6 ++--
 accel/accel-common.c               | 15 +++-----
 accel/hvf/hvf-accel-ops.c          | 23 ++++++------
 accel/hvf/hvf-all.c                |  8 ++---
 accel/kvm/kvm-accel-ops.c          |  7 ++--
 accel/kvm/kvm-all.c                | 52 ++++++++-------------------
 accel/mshv/mshv-all.c              | 18 +++++-----
 accel/tcg/cpu-exec-common.c        |  2 +-
 accel/tcg/cpu-exec.c               | 12 +++----
 accel/tcg/cputlb.c                 | 15 ++++----
 accel/tcg/tb-maint.c               |  1 +
 accel/tcg/tcg-accel-ops-rr.c       |  2 +-
 accel/tcg/tcg-accel-ops.c          | 31 ++++++++--------
 accel/tcg/tcg-all.c                | 28 +++++++--------
 accel/tcg/translate-all.c          |  3 +-
 accel/tcg/user-exec-stub.c         | 11 +++---
 accel/tcg/watchpoint.c             |  9 ++---
 accel/whpx/whpx-accel-ops.c        |  6 ----
 cpu-common.c                       | 23 +++++++++---
 cpu-target.c                       | 10 +++---
 gdbstub/gdbstub.c                  | 18 +++++-----
 gdbstub/system.c                   | 38 ++++++++------------
 gdbstub/user.c                     | 20 +++--------
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 stubs/replay-mode.c                |  2 +-
 system/cpus.c                      |  2 +-
 system/watchpoint.c                |  8 ++---
 target/arm/hvf/hvf.c               | 27 +++++++-------
 target/arm/hyp_gdbstub.c           |  9 ++---
 target/arm/kvm.c                   | 14 ++++----
 target/arm/tcg/debug.c             | 44 ++++++++++-------------
 target/arm/tcg/mte_helper.c        |  3 +-
 target/arm/whpx/whpx-all.c         |  5 ---
 target/i386/hvf/hvf.c              | 13 +++----
 target/i386/kvm/kvm.c              | 15 ++++----
 target/i386/machine.c              |  1 -
 target/i386/mshv/mshv-cpu.c        |  6 ++--
 target/i386/whpx/whpx-all.c        | 13 +++----
 target/loongarch/kvm/kvm.c         | 10 +++---
 target/microblaze/translate.c      |  2 +-
 target/ppc/cpu.c                   |  4 ++-
 target/ppc/kvm.c                   | 20 ++++++-----
 target/ppc/translate.c             | 16 ++++-----
 target/riscv/cpu_helper.c          |  2 +-
 target/riscv/debug.c               | 12 +++----
 target/riscv/kvm/kvm-cpu.c         |  8 +++--
 target/s390x/kvm/kvm.c             | 11 +++---
 target/s390x/tcg/debug.c           |  3 +-
 target/xtensa/dbg_helper.c         |  2 +-
 target/xtensa/helper.c             |  1 +
 trace-events                       |  2 +-
 69 files changed, 417 insertions(+), 433 deletions(-)
 create mode 100644 accel/tcg/system-page-protection.h

-- 
2.53.0


