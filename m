Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F8FC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QVW-0003Sl-Uf; Wed, 23 Sep 2026 13:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QVC-0003OW-9k
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9QV8-0000zZ-Kj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:11:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTkcG2470212
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mpy8GfzB6U3h/VgxUJ724l
 x7Y140GhQDd9gKEjSCAzc=; b=avCVbfmYyqKtfzXDijpV31HiOl+O8GOFSaSw3m
 hL5nRHq8xmQf9Xhy4Ho7GsBSjvrJo3enXKM75sn1aTZpcp7qEziMF6cm7ndY2wyl
 Tp6lnFFH2oNz47bWL+aviwGgb4lOjt9ohtQKucBE61srJGOsnJ8Gql8FfeqaHaQY
 596My5cszqq6oSkp6hbWmtDYDprwCYsueNffT11IGST6vy4jIVcsIydIdGAGy+pG
 xwMVN0DYFJDpNHYGNUHmWYRaQQH2vOVFwjYcJM8dC/Vbcr18cTs/zFKYNC4DuJI1
 p7wV5P0aQEojxgxaD7aTxbPDBw2e+qfUHW+QqXRfVNGTO5QA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv12fv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:11:20 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9806535f8ffso56365241.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183479; x=1790788279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mpy8GfzB6U3h/VgxUJ724lx7Y140GhQDd9gKEjSCAzc=;
 b=hq8my2aALbsfyFDrL4pDZ4Y3ZUpQUhajopPJL8e6WdMFdu5M+0N5GiOWbiG5fpYQQG
 gS+JQTR5WEWaypJG7H8OZE4vDlf6s1+r4bGkYGRz5YEeDW616NndUBCol2p5J0DnblC3
 +I2bOIMCQYru5WRsgWmkHBJwE6w/791gB69mBR1hNowP7AMTz0L6NfjDg8KlNsfeU+tW
 ytkrWZpOvcCTfhW1L96PACT1e1Z2UeFdy/l9b73iWxiyVsowqNqmtCrPjH+z6CbkOex+
 vu6UIkIve0+W2YN1VpVecyW2w85ScYDsEcTBMkhaSNq7IjiqtwscDT/B4atmtw4qgasA
 yGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183479; x=1790788279;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mpy8GfzB6U3h/VgxUJ724lx7Y140GhQDd9gKEjSCAzc=;
 b=r5AMUwxpB9XuvCZmqy9v0CZSOeyylYxbecDF6kEaRmxgzHdihWqF4Jvlh3EVchpt/y
 B6PAYdW6tkUhqUnEQdPZT/ojmUGZs3BrkarXROt3fHky9yU3hjKH94T2E0E63Cndbpwh
 AFuybqksJXDSxkDQwQiIyLmHOCRXn/JumkaVdqJ1r0C6EQvmtYXt3G8kdz0qCSphFLO6
 lUzeHm8ICSj6ZWRsVZPEsizvRfsbeoSJaqn69d14ByPCP4v8xHy26sDOniu8s+79yxOK
 Fs/0wdRn7zVBk+cqJp0Uj7C6VFovSN9R8D7uYH6ENEHZAEwoQHhcbwahPGuHpj00eKSN
 P1ng==
X-Gm-Message-State: AFuF++lZYvAmGif6Oi9pB90U2eMSOVrJy1WBkBHmUc9fk0r3IVoMG1OU
 h3OBDCT34LfqVgcWJjazXXiDly56CXt4rQrSMMfWLtfes/pGSIcWDOXRRsbdZdy1xfB+hGfbFi0
 JEgo8BZ7T1CSonQwDZ5ScXYWFhRbS81McMUcGM3t/8riq1zcjWP9PAd7Y1T5giAH43OOa
X-Gm-Gg: AYBFou0mBcv910H+F5ZUIxLHUY2dli5CKbaLvjwpb0i6sxGW0RnREkqEAgELhxcZOzB
 yvrpiI0A1dNUiTfuwz4GlXAHHWdgEpbKRdML2tNQTkAlfTT7tyqIh6E/lvqDD9qCeZSEVjVFOdw
 J8eZT/jsHl9I7PZDCpu67qvWxOUryMNX81NCavRnDrQ6ZlO0g5vM0P/SoH9T4J+3rRIhv3P9Sdn
 QNF4Tcjs4w2rZO8yVb4lP6kdkdikyQeN1EqM4FLLZj/QiOckllkQ0l6yJEvUmZ1KiOAPrQfsmij
 R2t/46NdxfOU6Mfh7yV5Mi2s5WSISnbBvefNagW6yRlxp3+NbHCmoa/flxAv2iu5BiKlLcQeAQX
 CK5wbro+nJvEh0PigyxS+apum3G81H/wO8tL4rBOV
X-Received: by 2002:a67:f818:0:b0:7a1:f2b5:646c with SMTP id
 ada2fe7eead31-7aaa0f22399mr5116852137.41.1790183479305; 
 Wed, 23 Sep 2026 10:11:19 -0700 (PDT)
X-Received: by 2002:a67:f818:0:b0:7a1:f2b5:646c with SMTP id
 ada2fe7eead31-7aaa0f22399mr5116838137.41.1790183478755; 
 Wed, 23 Sep 2026 10:11:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cbd134sm687575e9.9.2026.09.23.10.11.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 10:11:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 00/21] accel/tcg: Make halt-to-exec transition explicit and
 remove cpu_exec_halt
Date: Wed, 23 Sep 2026 19:10:54 +0200
Message-ID: <20260923171116.31276-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX4m75HFc3lWcT
 Iif1ajeL0TV7XZ6+InH4vOeMZj7he2tg0KdFNztMt8sfNA/1lWp1Sy9ZxEC5oDKj9tuZU071AaY
 7TmPxRRSk8YYe9kvuXOzLrnH1kplsd7ciXAJAXVuyJ9KRLWZ+62J9Hb9VJBpnFzaoRr9nDTUBJk
 Tn5Tg87DmvRumCfRyBI1VkdDTyGd/rwoVzrOkT0povFwVMkhhtcFg7nVIGqPtLrE5GlNh4+dLw1
 iW0Vpmw55KwSkIiUAcuq8s11aZaVcK/ekMDvsWrkRyeqokOTEUJ5xYecvb+fSv2g33z9MYvD8ZZ
 7XVYodRjmjdcza/pCcJvjtqGG7+lq+5j3odWGkluTnRdxpAlqrMvFNSqQ5izXTI9/rgFAT+JWxj
 bUP8MKODv8gLUruo5S1p4g1Enm+p38fN4WyryVCVeDv+qfIRRq4xaWeJhPQqev4KEXVU8I9ZhT8
 06/sh/zxqWlX2Pt17WQ==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab40838 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=lXy-g8FGwViYJ1dSwUkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 6ha3UT3wQuYz0s9gKeI_hvxJ2Ud910UF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfXw7PdUVD/GeAQ
 Rn6yJ8zP1YyoqD5SYPLs0NH/G+jY7h9FpLIUxK5KI70cd4abOBw18zts3yFA3zjoNZrisPybbN+
 J77Vxf2X8sjAxdaMWmynWWMjqUIA3J8=
X-Proofpoint-ORIG-GUID: 6ha3UT3wQuYz0s9gKeI_hvxJ2Ud910UF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230068
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

Missing review: 4, 7, 9-12, 17

Since v2:
- Make all ARM halt_reason accesses atomic, including WFI/WFE helpers
  and halt-exit handling, and read event_register atomically.
- Keep the RISC-V changes focused on MIP: skip empty updates, add a
  shared accessor, and convert existing MIP reads to use it.

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

Philippe Mathieu-Daudé (21):
  system: Document has_work() synchronization requirements
  target/s390x: Use s390_cpu_get_state() consistently
  target/s390x: Make s390_cpu_set_state() return void
  target/s390x: Use S390CpuState for CPU state APIs
  target/s390x: Access S390CpuState atomically
  target/arm: Un-inline arm_set_cpu_power_state()
  target/arm: Kick vCPU after updating PSCI power state
  target/arm: Access PSCI state atomically
  target/arm: Access halt state atomically
  target/riscv: Skip empty MIP updates
  target/riscv: Add riscv_cpu_get_mip()
  target/riscv: Access MIP atomically
  accel/tcg: Refactor poll-while-halted flow in cpu_exec()
  accel/tcg: Introduce poll_during_halt() and leaving_halt()
  target/arm: Split leaving-halt handling from arm_cpu_exec_halt()
  target/arm: Convert cpu_exec_halt() to leaving_halt()
  target/i386: Use an acquire load for interrupt_request
  target/i386: Split APIC polling from x86_cpu_exec_halt()
  target/i386: Split leaving-halt handling from x86_cpu_exec_halt()
  target/i386: Use generic halt transition handlers
  accel/tcg: Remove the redundant cpu_exec_halt() hook

 include/accel/tcg/cpu-ops.h         | 36 ++++++++++++++++-------------
 include/hw/core/sysemu-cpu-ops.h    |  6 +++--
 target/arm/internals.h              | 11 +--------
 target/i386/tcg/helper-tcg.h        |  3 ++-
 target/loongarch/internals.h        |  1 -
 target/riscv/cpu.h                  |  1 +
 target/riscv/internals.h            |  5 ----
 target/s390x/cpu.h                  |  9 ++++----
 target/s390x/kvm/kvm_s390x.h        |  2 +-
 target/s390x/s390x-internal.h       |  1 -
 accel/tcg/cpu-exec.c                | 20 ++++++++++------
 hw/intc/riscv_aclint.c              |  2 +-
 hw/intc/s390_flic.c                 |  7 ++++--
 target/alpha/cpu.c                  |  1 -
 target/arm/arm-powerctl.c           | 13 +++++++++++
 target/arm/cpu.c                    | 31 +++++++++++--------------
 target/arm/tcg/cpu-v7m.c            |  1 -
 target/arm/tcg/op_helper.c          |  8 +++----
 target/avr/cpu.c                    |  1 -
 target/hexagon/cpu.c                |  1 -
 target/hppa/cpu.c                   |  1 -
 target/i386/cpu.c                   |  5 +++-
 target/i386/tcg/system/seg_helper.c | 17 +++++++++-----
 target/i386/tcg/tcg-cpu.c           |  3 ++-
 target/loongarch/cpu.c              |  2 +-
 target/loongarch/tcg/tcg_cpu.c      |  1 -
 target/m68k/cpu.c                   |  1 -
 target/microblaze/cpu.c             |  1 -
 target/mips/cpu.c                   |  1 -
 target/or1k/cpu.c                   |  1 -
 target/ppc/cpu_init.c               |  1 -
 target/riscv/cpu.c                  |  5 ++--
 target/riscv/tcg/cpu_helper.c       | 20 ++++++++++++----
 target/riscv/tcg/csr.c              |  6 +++--
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
 46 files changed, 150 insertions(+), 127 deletions(-)

-- 
2.53.0


