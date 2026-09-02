Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8310C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mmU-0003G5-Kt; Wed, 02 Sep 2026 11:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmS-0003B5-J6
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:21:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1mmP-0000Ic-UK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:21:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CRPQR2002273
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h2+ZiWw8+5mpW6m21rupiFU1RDmVanI9GjdO6x6eHwo=; b=H6YrUhHjWkcvUm8S
 /qv26Ao2ZGm2l2/ig7AiSwF+J1MavGJGhzF/YmlkyBY0Od2Osj7rbOtPOU7j3fnV
 jItlemjXWAzwQtFZBaAmjw69XA/WkHVzCquXEvUBX9SKObECPr02ic0YXlJWN7aS
 OtBssKygj3A2YnAfcjL0ma8u912GytjQRFNGWtonIppDSNSQBZ60j0IhhrcES4da
 xfSgOGLfpuYHGCbFhgRx8IjeWHvtrJojvInkFBXWLMmrEvibrw2Qm/VYrmu+N7eE
 6XH7EGtqKDszqt3Z+6vChf34Z264EHdrHp1dKF/hw0nnnPUhBLmENNSMwnKtJhLz
 8+bndA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy1fej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:21:36 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso85638241.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788362496; x=1788967296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h2+ZiWw8+5mpW6m21rupiFU1RDmVanI9GjdO6x6eHwo=;
 b=Ld2qXcYYvR6hsMcosumUXSfWh73GLMIHN2qr+Ep/cWXRXpHJ42RXaGMdcQ+XnEYhOh
 z+SMA8rVA6WoBpslX5xFTX1SmDe425iZ8ACjm1G0EoMJD5CbAD2px9RHW67tcddcl196
 HeiIIwKy6UBBMW+uq8TlmZBH/VekKs/4wFXLqejzXl6ae5C7Rem5DNhTwUzIMlMBgANY
 AobBsEufXT1yjMlQ+TaGiL1BOeeBCF5HtHbJIiyaL2MxnVduIJS/rG1xpeLlTZoSFw2V
 j0XW4Tl9b787CT3R9Ds59fIn6pKEJu8jfeJ94cA1I4WyqJ9cYjXGQeQ352OxJZpAa0Hw
 aJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788362496; x=1788967296;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h2+ZiWw8+5mpW6m21rupiFU1RDmVanI9GjdO6x6eHwo=;
 b=BvJ/61wThfaAoZQwOmV8EYFLZfdulD0BbcD0suwrlWkdHvhEqR/Qo/C8y4Qzm7koD1
 HjRLOS+6yWuEPqjoPOdgrJMCknK6BU2s6QhGIs/O2RbaMlQod7c1Bg5GZPo7JxKWGhff
 8VYuZDayQ76gByWjArFEwkQjgjG6x5GqHJ0kgNj3Qt7QjdAfT+y7VgAaHaW5KoG96njM
 wVk04iTL/XKbfM0qc4GP3pds6PIZpSVY6Behre8jnV5F4dR2F/LI+cR5tJ3lVbRz8+kz
 brQ16xEigJ1Z8CfQvpMDxRl9gASdPG1zTnoE6kG0GkB3tI6MelK2K543XbDNtwB4OWWr
 Arvg==
X-Gm-Message-State: AFuF++l/rXGMHtSGEIuqEDPI1BUbFSp0Xp6l6a5cwksB8dZHzv9cU+IQ
 +0NxN7uLUODWj6eFyJ0nPyzGWOCz0wnzwSCsTiD/43Kre13qoOOD8KEcd4f+tl8+CIyNEYI9p5W
 r4VXBwU0lvmfdrNOqQgFvlrNrGszYc2V49OkFk5whlrNoTRqQeJNO+Txea/qVfHi+kA==
X-Gm-Gg: AYBFou03Fc9mwjrtNEC6RqpOwfZb72fnU8LgGJseL2VtEVYGyhDQiQ80vZRiR4zfzHt
 lc/8Pn2cbaNHF47wDla/8EGfkM2ILCTGy9xCAJApsInOlg68r0VJkKbR4tISZVpZtQrLLb5qOlb
 1/THNSTSL4GwjyWObLH1CX8YVbZwPKtO0vJCdyXZzHJV2mcEQ1lM8Qwn9rITAAAb5ytG2Q8k/bC
 Avs0Bs1EWYGUbwHhXO1y6xV4QmxVOqs5sgLmKIy+r0x6M/CcikyJsK4LWhRaAl4K/opAq6uJm9U
 9SiuGtCtpuMviuKcJddIDVFdMrXitfgvp7fC0t6sSgMe+DdPwFKgTot7j+y4IMbNSakIU6yrLqO
 Pbi46mdMhI12UV+zRzVrPnWVn0aWMgDjjc88dsqiy
X-Received: by 2002:a05:6102:14a5:b0:784:94dd:5389 with SMTP id
 ada2fe7eead31-78a1f3954bfmr1681518137.13.1788362495997; 
 Wed, 02 Sep 2026 08:21:35 -0700 (PDT)
X-Received: by 2002:a05:6102:14a5:b0:784:94dd:5389 with SMTP id
 ada2fe7eead31-78a1f3954bfmr1681490137.13.1788362495303; 
 Wed, 02 Sep 2026 08:21:35 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce0b456sm178993705e9.2.2026.09.02.08.21.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:21:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 06/11] accel/tcg: Rename do_interrupt() to
 do_interrupt_locked()
Date: Wed,  2 Sep 2026 17:20:37 +0200
Message-ID: <20260902152044.31291-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902152044.31291-1-philmd@oss.qualcomm.com>
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a983f00 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=2r7OHPqeXRgJTkdu1hoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: c2wxrWx-yodyeQTD4ogns5q3mkGVJ310
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX5VCm2W8xca3g
 z7pcqyQOs3w4fcVhgsoSubDgNcMJ4XbeLIIP1/DD1GHXk5DjnuwOd8ynZlV+LdTz8YbarJCh6AA
 /aTndGHqy7ApB6aK3/lrfOth/lb8sg4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX6c2tBdMhHFjf
 ijpPeb8niYkYfw339U9qcrLHVrBL22AsQNDtLQcB+Sbjqt6nYMqmZoFlKDtZyIBumDE+aC/EU3z
 kGhZ9VaK7pOV3HqmNYuuFX10qIc/adKieHbf7gswORbvrB+VYNK5NPOKsAnvVqP/mMMMvSlTwi4
 OhPCJOVAM56qxFMHDedj0Zmbhd2WZW12WpenI2H/UyPWglkl2itL3hxOdgsbWtHIAYNhHq2BrvC
 AXig08SW0pqIJioLKO+wJXezgnSUnrR999vrfDNLYIFRoESA0uF6OmSI34CaWYe1ktseuSbAlLi
 qBTsI+uhENYDb+ShLKWG8cjj9+xnL2Sn0/4g9OLW6QwXwNZEjpC6OoJdHkRmwidD/cf9B0C2nxO
 15NIRA2QswHN/G/InmQO5LFp+0uPW2BJ/F7PbXC5hYVO87OneOS9umzGBYztNeBCIIgsLwXMnEC
 0mjBnoHHtq7eVF1Ap2Q==
X-Proofpoint-ORIG-GUID: c2wxrWx-yodyeQTD4ogns5q3mkGVJ310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020136
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

From: Robert Foley <robert.foley@linaro.org>

Prepare for pushing BQL locking down to per-target implementations.
The old do_interrupt() name will later be reused for a wrapper that
acquires BQL and calls do_interrupt_locked(), enabling targets to
eventually remove BQL from the cpu_handle_interrupt/exception paths.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
[PMD: Rebased and reworded description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h    | 4 ++--
 accel/tcg/cpu-exec.c           | 4 ++--
 target/alpha/cpu.c             | 2 +-
 target/arm/cpu.c               | 2 +-
 target/arm/tcg/cpu-v7m.c       | 2 +-
 target/avr/cpu.c               | 2 +-
 target/hexagon/cpu.c           | 2 +-
 target/hppa/cpu.c              | 2 +-
 target/i386/tcg/tcg-cpu.c      | 2 +-
 target/loongarch/tcg/tcg_cpu.c | 2 +-
 target/m68k/cpu.c              | 2 +-
 target/microblaze/cpu.c        | 2 +-
 target/mips/cpu.c              | 2 +-
 target/or1k/cpu.c              | 2 +-
 target/ppc/cpu_init.c          | 2 +-
 target/riscv/tcg/tcg-cpu.c     | 2 +-
 target/rx/cpu.c                | 2 +-
 target/s390x/cpu.c             | 2 +-
 target/sh4/cpu.c               | 2 +-
 target/sparc/cpu.c             | 2 +-
 target/xtensa/cpu.c            | 2 +-
 21 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 13df70eaa9f..2e97f79a373 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -170,7 +170,7 @@ struct TCGCPUOps {
     vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
 #else
     /**
-     * @do_interrupt: Deliver a pending exception/interrupt to the CPU
+     * @do_interrupt_locked: Deliver a pending exception/interrupt to the CPU
      * @cpu: cpu context
      *
      * Called when cs->exception_index contains an exception code to deliver.
@@ -179,7 +179,7 @@ struct TCGCPUOps {
      *
      * Called from cpu_handle_exception() with BQL held.
      */
-    void (*do_interrupt)(CPUState *cpu);
+    void (*do_interrupt_locked)(CPUState *cpu);
 
     /**
      * @cpu_exec_interrupt: Callback for processing target-specific interrupts
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2fae2c024b8..8d9c203f222 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -728,7 +728,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
         bql_lock();
-        tcg_ops->do_interrupt(cpu);
+        tcg_ops->do_interrupt_locked(cpu);
         bql_unlock();
         cpu->exception_index = -1;
 
@@ -1059,7 +1059,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
-        assert(tcg_ops->do_interrupt);
+        assert(tcg_ops->do_interrupt_locked);
         assert(tcg_ops->pointer_wrap);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 12e86021663..aca9e82bfb2 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -267,7 +267,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .cpu_exec_halt = alpha_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = alpha_cpu_do_interrupt,
+    .do_interrupt_locked = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
     .do_unaligned_access = alpha_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e2..0d0555b7ad4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2606,7 +2606,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = arm_cpu_do_interrupt,
+    .do_interrupt_locked = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
     .adjust_watchpoint_address = arm_adjust_watchpoint_address,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 502998dbd1c..1f698b70283 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -304,7 +304,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = arm_v7m_cpu_do_interrupt,
+    .do_interrupt_locked = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
     .adjust_watchpoint_address = arm_adjust_watchpoint_address,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f8409f32ab9..bc7639031b8 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -249,7 +249,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_halt = avr_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
-    .do_interrupt = avr_cpu_do_interrupt,
+    .do_interrupt_locked = avr_cpu_do_interrupt,
     /*
      * TODO: code and data wrapping are different, but for the most part
      * AVR only references bytes or aligned code fetches.  But we use
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 7067e5b70f7..b5dcbfc99db 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -769,7 +769,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .tlb_fill = hexagon_tlb_fill,
     .do_unaligned_access = hexagon_cpu_do_unaligned_access,
     .cpu_exec_halt = hexagon_cpu_has_work,
-    .do_interrupt = hexagon_cpu_do_interrupt,
+    .do_interrupt_locked = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 07b49e51326..c6d915d314f 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -272,7 +272,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = hppa_cpu_do_interrupt,
+    .do_interrupt_locked = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
     .do_transaction_failed = hppa_cpu_do_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 7a4d73e7fee..ff65641654d 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -179,7 +179,7 @@ const TCGCPUOps x86_tcg_ops = {
 #else
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
-    .do_interrupt = x86_cpu_do_interrupt,
+    .do_interrupt_locked = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .cpu_exec_reset = x86_cpu_exec_reset,
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a1644..6455ae0c99a 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -329,7 +329,7 @@ const TCGCPUOps loongarch_tcg_ops = {
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .cpu_exec_halt = loongarch_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = loongarch_cpu_do_interrupt,
+    .do_interrupt_locked = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
 #endif
 };
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc23..85496deff67 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -712,7 +712,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .cpu_exec_halt = m68k_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = m68k_cpu_do_interrupt,
+    .do_interrupt_locked = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..649bcebf703 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -450,7 +450,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .cpu_exec_halt = mb_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = mb_cpu_do_interrupt,
+    .do_interrupt_locked = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
     .do_unaligned_access = mb_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..073e466b713 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -718,7 +718,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = mips_cpu_do_interrupt,
+    .do_interrupt_locked = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
     .do_unaligned_access = mips_cpu_do_unaligned_access,
     .io_recompile_replay_branch = mips_io_recompile_replay_branch,
diff --git a/target/or1k/cpu.c b/target/or1k/cpu.c
index 66c00c0930c..83dc071c180 100644
--- a/target/or1k/cpu.c
+++ b/target/or1k/cpu.c
@@ -268,7 +268,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .cpu_exec_halt = openrisc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = openrisc_cpu_do_interrupt,
+    .do_interrupt_locked = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 6c626843c93..2676562b2f1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7498,7 +7498,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
   .cpu_exec_reset = cpu_reset,
-  .do_interrupt = ppc_cpu_do_interrupt,
+  .do_interrupt_locked = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
   .do_unaligned_access = ppc_cpu_do_unaligned_access,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 9e3cc87f8a3..ea3189ab3d2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -289,7 +289,7 @@ const TCGCPUOps riscv_tcg_ops = {
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = riscv_cpu_do_interrupt,
+    .do_interrupt_locked = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
     .do_unaligned_access = riscv_cpu_do_unaligned_access,
     .debug_excp_handler = riscv_cpu_debug_excp_handler,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71cf..ea58a804154 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -229,7 +229,7 @@ static const TCGCPUOps rx_tcg_ops = {
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = rx_cpu_do_interrupt,
+    .do_interrupt_locked = rx_cpu_do_interrupt,
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, const void *data)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 7c725b8a4a4..053eafaa842 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -386,7 +386,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = s390_cpu_do_interrupt,
+    .do_interrupt_locked = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3bbdee301d5..fdab5106b27 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -314,7 +314,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .cpu_exec_halt = superh_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = superh_cpu_do_interrupt,
+    .do_interrupt_locked = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
     .io_recompile_replay_branch = superh_io_recompile_replay_branch,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df8..23fd0a5e3fe 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1076,7 +1076,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = sparc_cpu_do_interrupt,
+    .do_interrupt_locked = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7c25b9ab707..e980a13eadd 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -327,7 +327,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
     .cpu_exec_reset = cpu_reset,
-    .do_interrupt = xtensa_cpu_do_interrupt,
+    .do_interrupt_locked = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
     .debug_check_breakpoint = xtensa_debug_check_breakpoint,
-- 
2.53.0


