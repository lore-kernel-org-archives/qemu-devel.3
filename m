Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1985C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0J8-00088V-GV; Thu, 20 Aug 2026 06:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0J7-00087w-BF
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:47:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0J5-0005fQ-Nj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:47:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8jdNQ2529506
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yOfrwN7XZTm7KWpYEY0Hp9
 MRR/g+kSAHFmxWgdqlD5s=; b=DmFfoDKDeokIwoVdSLlZebUoJxmlJxuQmshR8n
 n+6SzGdBK2oXXl8aRvADIDAtKHr4AZ/kxGEZ+aIM02guYcArO505xRN+ljgisSS5
 cckfAq8szshuYruIxCmZ0+j2UlUlkOT/nwAn0A0N3ItoiUbJfP2in+B+4lyRDsmx
 tWezfCylkII51uRK8UgTbXVUQqP7RAyp+9rPKjY985ZXHAkfGo+t/0OuJ9Mhie19
 eTaopn4mJFxgreNL6OAYvoozhhUM3j2DrjJEb2gS5udZofHLna5kPUTdWpYkqP5C
 A5kKwyY5MjENCj8rU/PEDxMOtjMO6QJHz4f4pqSObK8ZAGHw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv8fgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:47:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936d067836eso248938985a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222853; x=1787827653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yOfrwN7XZTm7KWpYEY0Hp9MRR/g+kSAHFmxWgdqlD5s=;
 b=TwwMmsDDBiCB5/wE3BDBFmL/RzEjPV7cwUMzEGwAvfzh8WYjWSRvP3upNxb5Q8itRD
 GK1rbnwU5tWcYasfSxOpfG0V9sDDgNtju9XiWLWD74Vs9DeFq4mjMEIxCvMzTPBcjDdG
 XO19twwWS1qm5qGhw44aLugTwWujEYxbns4qohPzlbci52o61/xWhM5Dew3RL2dXHTFx
 yLzdtHTMjDtC4yWDbt2lHBaiIlE977rkVfxJh+xYmsM6NHwkqgObAa+pckosKIPqj7WI
 BBfVISQl/eVQL47laLyghB8bGaHYD72xI4NgqxbnUwl+7vNxXt2pxgFNVcCzGIqUMwfX
 YIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222853; x=1787827653;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yOfrwN7XZTm7KWpYEY0Hp9MRR/g+kSAHFmxWgdqlD5s=;
 b=RKTXU2O34Zpb6ffs9wiLYdTL+RSltVxDX/fT9bcu7HkwANUe48mD+dpcFW5sKn1Ba7
 xCdnQEyuIx1yGmFn5mqs2KR5rLJR1N5A2OkspkTX0SSTTmg2gZe8GwevjF2X5SxvIGb4
 Gjipx0nZxYDFeFrO9oxFr71gAor9SeH5a4PTmh6XlBqBJ9PJirwFfgLbK2WSPCXVvfal
 ZSsaJoelD5xR7Agq2d/bYqHOYNGRNtf5yVBEFpCRioM+ifemUG8Xow6pdjeAA57TfF/O
 uNQjpT1827+xRnvwv+cjjI7kTLSIpwQsZwwO7DokVF43N+MwVMaJkqET4BJOWX4ZA4iP
 gTkw==
X-Gm-Message-State: AOJu0Yxm6XdSTYJ3ICOq8rhQAV+jY3dTr453Jx+gb9zVT2zvtz8PFa/6
 HgfiITzq651uZPGCPc2b/04JmP/9yVO9Uj/WbbiOIXSYJKkA5uptYyGjtE2f5nsprp5GLlVB0jE
 9S1/K29+HbAD7yVsOQUNfUBko17hjiLRl96EuZH124g/1K7NR1fJ0jed54aLfWbvGmPHf
X-Gm-Gg: AR+sD10Qy14suZFMWJ8KZdYIiNq7lI1FOG19UY/jUU+/0avNMbHauw7qqAzIVMf4iC+
 zwnnfKo6OxrL6WH5Rtf+i9xGzhHABX7yFP9f4eNaY/9tl3jh4HljQiy0ByJM//mZ5iQ5hSZB5qi
 StjhpFVLhsQKYYJt/L+6AS67qWWKUMwFOcARHHY3t5/GN5/0ImSbmDr5TzLambLRE9dK4wgdD0S
 3AjrnD8EoBO2PHtpUUjlwj02REraxRSFI+Io6FPG0AZ1f6Dhpkr9qNDJv3Hgv/qHugT8x9lxHBG
 zP+MoBhqd4SBmgwDEPnHEz7nFoCX8SFEPwwMEtyPV0RBJkNlltbBlcklu7QDSzswKvVcdCHFCE5
 MQC2ZZYMMc20ZIbt/cnpCygRnF2wO14Al5EBWabX5AQ==
X-Received: by 2002:a05:620a:8006:b0:92e:eff7:34a4 with SMTP id
 af79cd13be357-9371e6b7d27mr1034892085a.43.1787222853401; 
 Thu, 20 Aug 2026 03:47:33 -0700 (PDT)
X-Received: by 2002:a05:620a:8006:b0:92e:eff7:34a4 with SMTP id
 af79cd13be357-9371e6b7d27mr1034888285a.43.1787222852965; 
 Thu, 20 Aug 2026 03:47:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b7d3asm11787735f8f.23.2026.08.20.03.47.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:47:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/13] cpus: Constify @cpu in SysemuCPUOps::has_work() handler
Date: Thu, 20 Aug 2026 12:47:16 +0200
Message-ID: <20260820104730.25462-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a86db45 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=AAaQe5pYXAwOW-7l4ZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX/H8yNrkWexTS
 452m0fxGCWbrYpzid7CR154OL5bslWyw6IOZYrIjgcmQH0t5wqL+EpOQiLDdWszeEDBF694nZWu
 l+ZBCDVmEPACnMdMUIMSwCegUFl8vVBjVV8WkNbdyaej0BtcTgZlpCpVgL8BS4pLnEUMzSZMiam
 luATTur239piNCPzKx+nqRtrE8iedIKlRGowG4zShPzAI/7eC+mPqHJIA6xlwd+NONeLgywp8VD
 vUwhAVTzd3TPsH0QELWXREfJpo4eprWqL1TtDwlvc33cu8wVraB4qwZVjLuYGrqcijofL+qahDH
 XbY1sZ1bh249Pe5sA0Z8F0PPEI/0PzJSqyw5Rmgul77vwDl07mp3txy79KJHF1DAFbPh0uRXged
 XtZGVQw5crB3fAyX+OqGV9+mpuAZ3rfkENJJQWkeNzriA10DRiSZxHLYS0h8b68WCCSz+AeaGQZ
 zZId2qY9jKDy3bZ++6g==
X-Proofpoint-GUID: bwBx_ismoWkhyJbBcwm7yqRxjMu0M962
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX66PucPjBvH/E
 rIDUGkvVlkZL67H6cA8z9SgDiA/P2GIdLShBtOa7XYFoklH4a+fip5bRF1ofxY1Ybrl1mYH/yEl
 sHTymDdPpPaANqpjoSRFPefmGqUmU+M=
X-Proofpoint-ORIG-GUID: bwBx_ismoWkhyJbBcwm7yqRxjMu0M962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

- Patches 1-8 trivially add const qualifier for various
  cpu_is/has() getters
- Patch 9 adds const-qualified variants of cpu_env() and
  env_archcpu(). Not sure if this is a good idea so marked
  as RFC.
- Patches 10-12 complete the cpu_is/has() getters const
  conversion using the new env_archcpu_const() variant
- Patch 13 finally convert the SysemuCPUOps::has_work
  hook and all target implementations.

No functional change; purely const-correctness improvment
to enforce has_work() callees don't mutate CPUState.

Build-tested.

Based-on: <20260819145649.23439-1-philmd@oss.qualcomm.com>
  "Make halt-to-exec transition explicit and remove cpu_exec_halt"

Philippe Mathieu-Daudé (13):
  target/avr: Constify CPUAVRState for some cpu_*() getters
  target/i386: Constify CPU*State for cpu_*_interrupt() getters
  target/loongarch: Constify CPULoongArchState for various cpu_*()
    getters
  target/mips: Constify CPUMIPSState for various cpu_*() getters
  target/s390x: Constify S390CPU for cpu_has_*() getters
  target/riscv: Constify @iprio argument in riscv_cpu_pending_to_irq()
  target/riscv: Constify CPURISCVState for various cpu_*() getters
  target/sparc: Constify CPUSPARCState for various cpu_*() getters
  cpus: Add const-qualified CPU environment accessors
  target/riscv: Constify CPURISCVState for various cpu_*() getters
  target/hexagon: Constify CPUHexagonState in
    hexagon_thread_is_enabled()
  target/mips: Constify CPUMIPSState in mips_vpe_active()
  cpus: Constify @cpu in SysemuCPUOps::has_work() handler

 include/exec/cpu-common.h        | 11 +++++++++++
 include/hw/core/cpu.h            |  6 ++++++
 include/hw/core/sysemu-cpu-ops.h |  4 ++--
 target/avr/cpu.h                 |  6 +++---
 target/hexagon/cpu.h             |  2 +-
 target/i386/cpu.h                |  4 ++--
 target/loongarch/cpu.h           |  6 +++---
 target/loongarch/internals.h     |  4 ++--
 target/mips/cpu.h                |  6 +++---
 target/mips/internal.h           | 10 +++++-----
 target/riscv/cpu.h               | 31 ++++++++++++++++---------------
 target/riscv/internals.h         |  2 +-
 target/s390x/cpu.h               |  2 +-
 target/s390x/s390x-internal.h    | 14 +++++++-------
 target/sparc/cpu.h               | 12 ++++++------
 target/alpha/cpu.c               |  2 +-
 target/arm/cpu.c                 |  4 ++--
 target/avr/cpu.c                 |  5 +++--
 target/hexagon/cpu.c             |  8 ++++----
 target/hppa/cpu.c                |  2 +-
 target/i386/cpu.c                |  8 ++++----
 target/loongarch/cpu.c           |  6 +++---
 target/m68k/cpu.c                |  2 +-
 target/microblaze/cpu.c          |  2 +-
 target/mips/cpu.c                |  4 ++--
 target/or1k/cpu.c                |  2 +-
 target/ppc/cpu_init.c            |  2 +-
 target/riscv/cpu.c               | 14 +++++++-------
 target/rx/cpu.c                  |  2 +-
 target/s390x/cpu-system.c        |  2 +-
 target/s390x/interrupt.c         | 22 +++++++++++-----------
 target/sh4/cpu.c                 |  2 +-
 target/sparc/cpu.c               |  4 ++--
 target/tricore/cpu.c             |  4 ++--
 target/xtensa/cpu.c              |  4 ++--
 35 files changed, 120 insertions(+), 101 deletions(-)

-- 
2.53.0


