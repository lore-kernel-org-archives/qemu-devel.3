Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3551CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 17:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xByRG-0001NM-JK; Wed, 30 Sep 2026 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRF-0001MJ-18
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:49:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xByRC-0001I6-Sb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 13:49:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UHekEL3463937
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2VMj1JVwFAs6N4Fu4O6qf7
 jOa/0EQUdj47OIiZixAyo=; b=JfxS+Vlmal/R+FbrH4t87PnuoYp9y2gcOK2e3o
 KO7TrSrlKkbMP4CIomhm/2LmUmi8c5YtFZz67IvUCZR8/XXmuLDCeHxYgaDilJRH
 0xEl5W9CzIfPImU3NRbTgqYuVBvsXqeNtu8oKU9CLSw5Z5YpFnSVY1E0wv4kzCUR
 ElwLbvxan0bmyyioixg46oY/XzXOu1wdIrpksIKdx3Cs5ZKkzptXgA/23lTJdXFj
 DsHNXK/dFJjW+sho5GEk/E19Ye5lOtGG9LLxTyXfcvJV65qaEZ8QEwGbAg+I8Wq9
 luch0bxT8xECxBf+Upb9FSz2nlNO07o3Jo65zBPk2wb0zN8g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h16wcr2p5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 17:49:49 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7bf21ebcc4aso447654137.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790790589; x=1791395389; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2VMj1JVwFAs6N4Fu4O6qf7jOa/0EQUdj47OIiZixAyo=;
 b=XHZol/OvD13lrD/fPhd34Ez0b3Kf79pBCWAt1sWsiB+89//ZefRJibrM9BK7ur9rge
 FzxBi6QcRhA2YJwPTEhtVoiQ9qmKq4n+JETDCoG8S4Zc+meo11hdGtXPiScpmYgAlHCP
 TQ+yWMm6aEPfxg5DD2MmTuILVKSuvV1is2TCpx8kNNtyLSgKCleCuXtKOa7d9FtXJNKP
 55/QDOemqLLGIxBnkgXMYZrw3CirJyNCqit59P5x1G6lzVjswy+2i+bUheDOtMea6203
 X2fpt0VRtTPlK0oQI4Pd+xHpMkBJ/ztcU3V1f3ytaEnFzSfF6DNXry4NaSeJJfPseBpS
 4vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790790589; x=1791395389;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2VMj1JVwFAs6N4Fu4O6qf7jOa/0EQUdj47OIiZixAyo=;
 b=BoZdnsC44RNP7c37z/85ei3F6HpV7M2x7zXHTU1VgxGT0Ip5azhJkD1Z75WDBrkOI6
 dN75+bcpSKtrWzz8RoKq1siqcwGakZOByqDcFseSESYWqSm4gKwdTrA3vXpLlY7rfGmK
 hdRkRWZBTjAGe+HSouUPgamT9l2QnMZoe9jT1a9hHz4IHAI+RCl57ElIFIutaIQB43SW
 SmWB2rQ49LhEM2ipq/tK/qKEWI7ldN+Z1sjm2M0XFl1/DgEgp2Q8tR35XI0mVAXxSx/+
 mOXsngX/9xNWEV7eo06aP4GJE2/vOe9Ro0XsmbBu/4rQkNEYHPxfusblMxTQtkJBHnXZ
 g2aw==
X-Gm-Message-State: AFq9FYJyOJPdn1hh+3feE1P09127uGUSeJfK3Bj1S8nTNkP1XgAV5yUs
 AGPLhl0zghD3zaM6O8Wc00qEViCC/b8+AKPX64PI/g4pSCkuvn+cEpuS1Rx4EvF46rMoxDDYo6m
 GuP/TGPksm9PPcHwxRhB3I0Jp/nkJx/jFDDjXGfVhb43Ug7KkwxuyMPjJX9aKEEqMng==
X-Gm-Gg: AYBFou2N/TYUXdrxwK7oidik0wliyoN5dzDAHU6/pggG3N8Peg78OThZBCeiGDuHLoM
 VSkUzEqIg2ylTVu8ImOIj9fVd48dvRWrcLp+T623qivPe3DkHMldRb65YoNlszyyMkwog+ietXy
 EmJoDYo+npWtIKqlXguz+niyLFOSnfloxmD4f5oM9khQ6Aw1a9lo+39/j0UXseI+HQ4rh9AhRFF
 vz7dyBQ1qtCg5iRsvjcN5i//UUzfZoexWgeL0MVnWP8ZZ1yYDZbvw1Zbg0f/FOAT8644N1dOg7m
 G9nr0tOz3/iZgkZy2Id4y6vzo/KF+bwnjQeARcX2T2nBjgUJ0oVTOqqAJoCSa8vj4nE9+0JNRB/
 z/Qy2Gg7P84F++erg/VGYlLrdpKWVMeCttK2ZZY2j
X-Received: by 2002:a05:6102:c4e:b0:7b3:4199:2dd4 with SMTP id
 ada2fe7eead31-7be73795a33mr713472137.20.1790790588787; 
 Wed, 30 Sep 2026 10:49:48 -0700 (PDT)
X-Received: by 2002:a05:6102:c4e:b0:7b3:4199:2dd4 with SMTP id
 ada2fe7eead31-7be73795a33mr713456137.20.1790790588223; 
 Wed, 30 Sep 2026 10:49:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb60804sm12222585e9.1.2026.09.30.10.49.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Sep 2026 10:49:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 0/9] accel/tcg: Make halt-to-exec transition explicit and
 remove cpu_exec_halt
Date: Wed, 30 Sep 2026 19:49:36 +0200
Message-ID: <20260930174946.82195-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfXzWIjoaBf+tB6
 DusiFgMkmJvuZ/BKp4z+3VtGOw45TZjOhnKLw+wAFMoupMzzOPvZSBOeTcCVu9fB80NUhcTAu6i
 oqxVA+am5QsshaIvsDWjgrR21cypHEhpNydszqH2z8sOZCAVOKgjmXcpphNMX17fVuus7637VoR
 4OIhiU6lOSkkGqSQ0rQ0LqZo9RSyav+BSHpD6K3OUx6UFOGxFK4ikEz0ICwmVV0EfVEz3Wsokvo
 iLdbvQjbaEDjyfkT+Cxg+yK9S8j5y5UuPYoReoPlcsuPbreaU9FKfqoPTW8EUK6qBVY8IAY3cLN
 djqi6e8zZ9t9neGc4xvAvV4glNkU4oadXNMPa19acag0KxA6taRLNnxkNUE3ROHRCG8Z3cpVJra
 j8jdDtdmNGd37sWscQ1khBkDzB2Exi+5F/t5SndziAX9NWvmV5P0thMXfwlXLWRdukQtTNiJG9r
 SOBZ84XadN9sy2nz+tg==
X-Proofpoint-GUID: b8gLGjeUYnDGVHz9MBOUmwl0NtHiLoI7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MSBTYWx0ZWRfX/5SYr66bJ58p
 X1aJBqfznkQb1CD5Fgh9POiY5yTqYuKmE4g2E2qHF1Fr0lfYZnqLL6nJW42nlcE9Thd/y5/1Gx7
 2SPNTl3IQWN8sBNWVIowBl9bRTkFX+I=
X-Authority-Analysis: v=2.4 cv=S51MU4sP c=1 sm=1 tr=0 ts=6abd4bbd cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=NrQd3uPfcZAIwh0YapMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: b8gLGjeUYnDGVHz9MBOUmwl0NtHiLoI7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300071
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

Missing review: 9

Since v3:
- Rebased (s390x, x86 and some ARM patches merged)
- RISC-V posted separately as [1]
- Better describe ARM PSCI power-state update issue

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

This series was inspired by a previous thread on the list [2].

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

Testing: Usual CI.

Based-on: <20260930174508.81497-1-philmd@oss.qualcomm.com>

[1] https://lore.kernel.org/qemu-devel/20260930174508.81497-1-philmd@oss.qualcomm.com/
[2] https://lore.kernel.org/qemu-devel/CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com/

Philippe Mathieu-Daudé (9):
  accel/tcg: Refactor poll-while-halted flow in cpu_exec()
  accel/tcg: Introduce poll_during_halt() and leaving_halt()
  target/arm: Split leaving-halt handling from arm_cpu_exec_halt()
  target/arm: Convert cpu_exec_halt() to leaving_halt()
  target/i386: Split APIC polling from x86_cpu_exec_halt()
  target/i386: Split leaving-halt handling from x86_cpu_exec_halt()
  target/i386: Use generic halt transition handlers
  accel/tcg: Remove the redundant cpu_exec_halt() hook
  target/arm: Kick vCPU after updating PSCI power state

 include/accel/tcg/cpu-ops.h         | 36 ++++++++++++++++-------------
 target/arm/internals.h              |  3 ---
 target/i386/tcg/helper-tcg.h        |  3 ++-
 target/loongarch/internals.h        |  1 -
 target/riscv/internals.h            |  5 ----
 target/s390x/s390x-internal.h       |  1 -
 accel/tcg/cpu-exec.c                | 20 ++++++++++------
 target/alpha/cpu.c                  |  1 -
 target/arm/arm-powerctl.c           |  5 ++++
 target/arm/cpu.c                    | 20 +++++++---------
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
 target/s390x/cpu-system.c           |  2 +-
 target/s390x/cpu.c                  |  1 -
 target/sh4/cpu.c                    |  1 -
 target/sparc/cpu.c                  |  1 -
 target/tricore/cpu.c                |  1 -
 target/xtensa/cpu.c                 |  1 -
 32 files changed, 64 insertions(+), 74 deletions(-)

-- 
2.55.0


