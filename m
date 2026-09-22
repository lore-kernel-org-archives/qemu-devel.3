Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED467C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93gl-0003Yx-LQ; Tue, 22 Sep 2026 12:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93ge-0003WY-Q5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:49:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93gb-0002CP-R0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:49:43 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjNC9318300
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=fnZTb+1ILyES5h9HPeC4Ea
 g0BwGQLUQ5aNf0G7SiUtU=; b=YgQp5qPbUFDuHhPaFxx2PwQ8r8M3oBUZ9NhobY
 m+/jeWTrA6etpGzr3anISOI5ccBsLPiPRnH0bCTMDVRcrTWI97BAORL+z7yiXfKJ
 ip+dXoyq8kDoPN3yuTe8R2tCLg0YhFac97TvFDZitIloSb+hTegKn3883vxXsY0b
 wPlBws06Jng7My7FC5jfnWTnGWvistXBtoztCdJsvzrlvqWrVvfN4ILx5OnEVpzg
 WGdfoHBPZl2ItstSOZ76C1lk+Ax1OuinWrLCryumiUqyKiLfo7OkZcDWI/VHyx7D
 AEc2yLQHJlLALR22Kn35gb4iL/9xp6IamGEupo1jKNFDR30A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqj7c7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:49:39 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-980882ce555so5967241.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095779; x=1790700579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fnZTb+1ILyES5h9HPeC4Eag0BwGQLUQ5aNf0G7SiUtU=;
 b=WK30ZiK3yXT6MEEVGzTjwABeQ1bB+d86sk8OT4+prlAYazZw+kAlzsbDJQfHqycV3b
 em9dGHszEsjmTTNlwlMUjvUg6eQ1BMGaouUHN4yfoDLlwF6xwUkOrjRv7Rl9PKLwQ1R3
 BycIct6RxzrjZcwVQrsUqDSnKwpWtLJaoS9AuR+X0V3q2flbUkLiJ+8EzaK2NUOi9woh
 kIH0jCMQhZap2y8eKLx6JOSy/tdevdewU8DyXfqO8PCT1CkhWGRUcl4mfgGpwGYU+96a
 gmJPhXWsgdNODx0wCRu4Pcm4Ha02a9H4XEbEKcsYFhmDpYSMLOU1dFWRa1iMOtBtEgs0
 CYqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095779; x=1790700579;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fnZTb+1ILyES5h9HPeC4Eag0BwGQLUQ5aNf0G7SiUtU=;
 b=HA61jAYprVIH/2nnwRaFomHFkU+Sx5D+E1TR7jq8eRtAry8hcVOgB7kJkIWFrvV88Z
 IRw9PCF0PqK2Wzyy7/dpugTmxbkH1sc+PfQzbsvlm5smJpixTjQTAGiEUWKd/APd5hiS
 Z83S0yH/XMa1pH+v+PG4c0OfYkB/uNt0n0MjciWCqK+Nw0T7Q+NA4IxEcHuCfmPuDJKL
 wsAI7mO7n487BOmU8lMWj3O/LR0wBvtrbuaH0eVb8P1Fw4g3EuJAqMNcbVfs/ECeBGlB
 cZwXCu0DuoGH89rNsj9sJokpKiEHGRdZ7k2w/9H7RZONQNxmPwf2T6gKXHV+dnbR1QTM
 6geQ==
X-Gm-Message-State: AFuF++nX0oWzb1je3naq7J39CCFQT43uAhhp5n9/hWi7BrW/3mifEb25
 z698BUsDYpiJ9owfJW5w86l/bHThMspoTfDVBn+EdI9CIItSHyRtU0xNT1orlYxFGfT5ETbQ6QV
 4Nhd6RWSKKzgPXY1Wu7kEz/ut3eu4VZdTSfiq3W1MloC7mFH1JWekqFCBQWCmfKFNbg==
X-Gm-Gg: AYBFou0WPqoLch4WiIySxbVYQ7sYaxIMwG59lpKPXNj0ssCkBJ5Jh2oEAHvtKUfnrUA
 q2JvnfEy1EjR36ZzqSD2bSy6CpzYrTASC4H/nCBskCTdQ68SneJCUAr3nMjN3SVTYrFx52kKweK
 8hurRvTVl61osHo+Z8vmimOq5WxBGFpeyPsJoiUNANLFN7N9MKe1PZGHuB6H0b49zAvXhqXt5jo
 Qo5nzOxKXio4GXwZKS7Wjji1qqeJd1ynBWVmwyRnPq1nGKjFzZdqo0HrsC1JZvgNCRrFhqevfmg
 rfMCTAaW+lL++lWqMA/jfvPRyljcjvzojr0LNNaXyOwz3tT9mJIUwQmdXcFOUiV+o8kGgnnJJ/L
 EMkkXqcjfPLiaVxY/sFY+r1oerEvqc0hEaAEGoO2m
X-Received: by 2002:a05:6102:a47:b0:7a6:e302:e24f with SMTP id
 ada2fe7eead31-7a6e31243femr6675137137.24.1790095779272; 
 Tue, 22 Sep 2026 09:49:39 -0700 (PDT)
X-Received: by 2002:a05:6102:a47:b0:7a6:e302:e24f with SMTP id
 ada2fe7eead31-7a6e31243femr6675069137.24.1790095778766; 
 Tue, 22 Sep 2026 09:49:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1ccccfsm3169625e9.7.2026.09.22.09.49.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:49:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 00/17] accel/tcg: Make halt-to-exec transition explicit and
 remove cpu_exec_halt
Date: Tue, 22 Sep 2026 18:49:18 +0200
Message-ID: <20260922164936.15189-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX8YHvLoILpeCB
 cO0EtM2qqTmd4HuepGdO6mrTNXYYYH+hnURUBRVSJzbjFIm/D9156+AUQbZz9Y9svwg/jmFcESv
 3N/KQwuD4kagojsqxSf1T/qngl3vR0bYhaGlpDhvWO9g2X01LAOYZ98cKX/+6E6z4NNFNqlI07J
 aG6eDmErV3l5b/r8VX+QY2xisIpcVq85ivJBtFR6eogtwzChTePPlFc6Ac8qC1z27A9Oj0KTrBv
 dEEa3rSRDXNJp0OJtXCKxwlUuaq1f5Ec/VBK980f54lVqsbvcQmLetTWfitTYNcSselWS9BWYNW
 xbMEXUddgosbaOqlfEk5PLRp8eQ33Zx9+niO04uLAXZWYI93TEyuTOR1kXvg+3iae59N9cs2dSS
 5PlHZdgqV6uSdV+phYP3t2oVuDvm+j+FA6v5kdrCH/SzO2r6LBQF0ai+FhQ0SK48+HR2RjLAOY4
 XP08dhl6dRknQdtf3iw==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2b1a3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=IL0c7CRWWM0nRW6uXqsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: FuWjDDlThL5CbmyQd2dlADLyuuUtRr2V
X-Proofpoint-GUID: FuWjDDlThL5CbmyQd2dlADLyuuUtRr2V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX9WM8XVO3FMuE
 AS09i7uyLFsp8VrtEYuRwDJjzaS0hS27mqratBx8hByD27ptz0bZM+tQFNvEbcMTqVRNFXWlik9
 SrdkUIu41rNjLOJ2hbam5nezDF5tHaE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Since v1:
- Collected Richard R-b tags (sometimes commit description updated).
- Documented the BQL and synchronization requirements of has_work().
- Renamed the callbacks to poll_during_halt() and leaving_halt().
- Addressed Peter's comments by removing racy halt-work assertions,
  documenting the BQL contract, and explaining why x86 #DB delivery
  through do_interrupt_all() is safe without the BQL.
- Addressed Paolo's comments by making ARM PSCI state updates atomic,
  kicking remote vCPUs after power-state changes, and ensuring x86
  APIC polling runs before cpu_has_work() with the BQL held only
  around APIC access.
- Sanitized s390_cpu_get_state() for atomic accesses without BQL.

This series was inspired by a previous thread on the list [*].

Refactor the CPU halt-to-execution transition logic in TCG as
something more explicit and composable.

Core problem: TCGCPUOps::cpu_exec_halt callback mixed concerns,
it checked for work, processed async events, and handled state
transitions all in one place.

Solution: introduces two dedicated callbacks:

  * poll_during_halt(): Process target-specific async events
    before checking for work. Called early in cpu_exec().

  * leaving_halt(): Perform target-specific state updates
    when transitioning from halt to execution.

This separation allows the generic cpu_exec() code to orchestrate
the flow cleanly (process events, check for work, transition state).

Only 2 targets need to be migrated (x86 and ARM) then we can remove
the redundant cpu_exec_halt() hook.

The changes are expected to be purely refactoring with no functional
impact.

[*] https://lore.kernel.org/qemu-devel/CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com/

Philippe Mathieu-Daudé (17):
  system: Document has_work() synchronization requirements
  target/s390x: Use s390_cpu_get_state() consistently
  target/s390x: Make s390_cpu_set_state() return void
  target/s390x: Use S390CpuState for CPU state APIs
  target/s390x: Access S390CpuState atomically
  target/arm: Un-inline arm_set_cpu_power_state()
  target/arm: Kick vCPU after updating PSCI power state
  target/arm: Access PSCI state atomically
  target/arm: Read halt state atomically in arm_cpu_has_work()
  accel/tcg: Refactor poll-while-halted flow in cpu_exec()
  accel/tcg: Introduce poll_during_halt() and leaving_halt()
  target/arm: Split leaving-halt handling from arm_cpu_exec_halt()
  target/arm: Convert cpu_exec_halt() to leaving_halt()
  target/i386: Split APIC polling from x86_cpu_exec_halt()
  target/i386: Split leaving-halt handling from x86_cpu_exec_halt()
  target/i386: Use generic halt transition handlers
  accel/tcg: Remove the redundant cpu_exec_halt() hook

 include/accel/tcg/cpu-ops.h         | 36 ++++++++++++++++-------------
 include/hw/core/sysemu-cpu-ops.h    |  6 +++--
 target/arm/internals.h              | 11 +--------
 target/i386/tcg/helper-tcg.h        |  3 ++-
 target/loongarch/internals.h        |  1 -
 target/riscv/internals.h            |  5 ----
 target/s390x/cpu.h                  |  9 ++++----
 target/s390x/kvm/kvm_s390x.h        |  2 +-
 target/s390x/s390x-internal.h       |  1 -
 accel/tcg/cpu-exec.c                | 20 ++++++++++------
 hw/intc/s390_flic.c                 |  7 ++++--
 target/alpha/cpu.c                  |  1 -
 target/arm/arm-powerctl.c           | 13 +++++++++++
 target/arm/cpu.c                    | 31 +++++++++++--------------
 target/arm/tcg/cpu-v7m.c            |  1 -
 target/avr/cpu.c                    |  1 -
 target/hexagon/cpu.c                |  1 -
 target/hppa/cpu.c                   |  1 -
 target/i386/tcg/system/seg_helper.c | 17 +++++++++-----
 target/i386/tcg/tcg-cpu.c           |  3 ++-
 target/loongarch/cpu.c              |  2 +-
 target/loongarch/tcg/tcg_cpu.c      |  1 -
 target/m68k/cpu.c                   |  1 -
 target/microblaze/cpu.c             |  1 -
 target/mips/cpu.c                   |  1 -
 target/or1k/cpu.c                   |  1 -
 target/ppc/cpu_init.c               |  1 -
 target/riscv/cpu.c                  |  2 +-
 target/riscv/tcg/tcg-cpu.c          |  1 -
 target/rx/cpu.c                     |  1 -
 target/s390x/cpu-system.c           | 26 ++++++++++++---------
 target/s390x/cpu.c                  |  3 +--
 target/s390x/kvm/kvm.c              |  4 ++--
 target/s390x/kvm/stubs.c            |  2 +-
 target/s390x/machine.c              |  2 +-
 target/s390x/sigp.c                 |  9 ++++++--
 target/sh4/cpu.c                    |  1 -
 target/sparc/cpu.c                  |  1 -
 target/tricore/cpu.c                |  1 -
 target/xtensa/cpu.c                 |  1 -
 40 files changed, 119 insertions(+), 113 deletions(-)

-- 
2.53.0


