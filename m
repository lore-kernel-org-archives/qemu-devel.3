Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4E606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TRrithrY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NmQpJE+a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzFQ-0003yS-JC; Fri, 13 Nov 2026 16:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRzFO-0003vg-Fa
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:55:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRzFM-00018v-Iw
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:55:50 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADKK24k4059285
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 21:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PWquKx4n9N3yI25R4USSLMqtuZq0Hm/GwWI
 5ZFcmaR4=; b=TRrithrYUaSVoWFOs8GxwZbzNhOWAZrstL4YDsatR8YS7djmLCx
 B3+JR86Oa/lG2p5ICGppSQnHivgjOgT00BwDbkr/tgvXVkMJ+SG78exGGzpdGLW+
 FkvS+vHvNBO1yhVoBQtut0cOFHbB+wqEXw37sp0RWKmucnHLTL7mj9YWzXVKZg8O
 IcOPhDKiDqSXcNB0RUuVWodQ8g2YRu+QV+V03CxY997hMuDsBb4EZ11YFaEgQ2Uc
 hZs4zWOjiM6/0t5soYB6TiLAdt0ZK293m0O7MqjBZ+mbl8HsZixoTDf+UNBz4Kd+
 XGAkf544/bzfSBlupf8tl/TONF+hDrg1eww==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6ucpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 21:55:44 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-544019b1831so28535391cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 13:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794606944; x=1795211744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PWquKx4n9N3yI25R4USSLMqtuZq0Hm/GwWI5ZFcmaR4=;
 b=NmQpJE+aX8L4s3p8ytNmTyaqXkXTcufZ5/0G3esl2b/CjJhgT0BbmzrE/DF0N0VB9/
 NQs9cbAaKflTdl0DaiOR08TI7Y4ZB2epHnNlgZDYdccLcTYq+vG8ebsz/+O+UvwMbQxb
 cxtmzJt+puNrjZAqN1ZWnn8VGDZ+fIKIe+64p5F3fYtOG77FdjA14k1fjyPhtr/qzD0p
 /FIXQ128HnZH1Asu2UT7gV6qI6u3tAPwEZLgM472d7WFd9YmNsFN0lVv0dIrXriTZIPT
 sppL0jjKla6gOA/GMlBt2KrqCEIpw8CODXpAoPPsUHB/gUMDsEy8pWvHil5iegYy8TXW
 UPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794606944; x=1795211744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PWquKx4n9N3yI25R4USSLMqtuZq0Hm/GwWI5ZFcmaR4=;
 b=bQDaCp0w4qN1QMtmMHymbQBtYWPwjJhXbgzr4Cvb3b6f3EgPbn7tY+7tW73avxb2yh
 eIqsPJOCSG/wOll6HAJ4+cGqh3vunhm3sfB0elt56EsEe6k9ELxMVIO3hcKpEdxbHWkK
 iDmw/Imv+FO43stHRC5ApoR/sXIz5FhEmf8Rt1xQgKvRb1ExrY93GOQe1njGdsLI5T/g
 18RIwUuw9QAjhD09FGXzY5BN0rXlljgGdUCBJcPu29Ka4eyGNmX05SwY9QcFJssLfexQ
 drY683edI6ifKIY/fo4othlYePyhaou00ervo9Z9vDAoK+/zLcx1P+H9DPvA70z4jOdW
 ziCA==
X-Gm-Message-State: APuU4Z92XVPMyOh1FjLPyv027PslEfjnOel24PDVsFm0DNJNJr4vkHkh
 gj2Z0KQaWFgDnik+LEfouTa5EHnCNQT5BQmLUy9z82rFftqUFCAtMcc5H+/cn1GPfWSX7HQPQq/
 /5TJDvnD1aClC2YOW5SkVPbDwB3Fkp92F8hq/5vDtDSs2gH1spjZTtt3JqAYSW+CCUA==
X-Gm-Gg: AYBFou033bXdMI9zfNOr1Ahnn9OMF2SniJ8KgL2Qo+Z0NsftUO9OLcJKyHXVfv2E7u+
 8vxtckLP+nGQs4J2gZ6TJZGy8vrbjmRssdgtIiNmHneb4IaDwGw/NK9e+wMwm3/ztvMZIh2E7yn
 hA7mRJomAd6luDb5mFMhvai2G3+rdAWSnED0Zgrz7PoFxVWzGjqGXWrOmB5hMKXhSl/ty67yFs+
 K3WqQadIsxVlr0bky1xEUd6ECTxCtaNvlUFM7p3vX/NmowsADzt3cY1eUl0xGiEzr3psdxXpEH4
 YfL+AVFP9ptK1rNhvNsQAyesn4lUn8q22te6KtPclco6zzQ54o5x5y7kcmxVHnodpf7cgC66dFP
 qzIWVQ6lc51fk/8FZP6JmPnWO6/HlVmerQYfyvJ0e3FQ4NjjSv/AuKXJgkiMUGyzqx0zeqzXYck
 1n5lG+wOjE2A==
X-Received: by 2002:a05:622a:a945:20b0:55b:f621:e7cf with SMTP id
 d75a77b69052e-55bf63136b6mr23638961cf.18.1794606943604; 
 Fri, 13 Nov 2026 13:55:43 -0800 (PST)
X-Received: by 2002:a05:622a:a945:20b0:55b:f621:e7cf with SMTP id
 d75a77b69052e-55bf63136b6mr23638591cf.18.1794606942982; 
 Fri, 13 Nov 2026 13:55:42 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.237.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55c42b6f3desm4310011cf.27.2026.11.13.13.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 13:55:41 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: make pmpcfg R=0|W=1 bit combo reserved [GL4820]
Date: Fri, 13 Nov 2026 18:55:36 -0300
Message-ID: <20261113215537.158118-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NyBTYWx0ZWRfX48dv2vkux2c0
 WzPUtbzqpW5cvyMO2Q8ou5X5SJkN8ZDgDmx7kdi3IMN4M/8x9tcPp6uEBRitDp9x+n7b60fOlwq
 SaqWd/8rv8+I4oeWL9qtzJYKzkjD+jHeHRv/0xnyeudMQ4xx+wuSa602cV5KyGqgpBz/y6E/qCP
 DdS13QA4ElgLGBW2pkun72jMm3IX+Tj0ORBsqtgxpzMfDB2iSDAstYKrzDiXtCEeNAn+n+8EdNx
 vKrq/8iDP6O2dQPEmh1YglQ0sWwkYDQCbv5iEqP8PZ+PnjDCYyQaaYUtWm6iAx679v6Mzm2Xjav
 FQ9tKrwXFOnlDt8m6bLm1IJ/ujev4KPiDuw9PNeHxP6ov3xr74C9yx3sdwG6Q04Iz6Lm0aUAVGN
 5BXgjLsD1kLWcnyk/Qfo6q0n0WdpBUrNoCCexmjJh4YfbQ87MQ7noXXPXe1n4J/7I55oFcmmEq4
 Yi9MigpIJua2m6ASCWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4NyBTYWx0ZWRfX850IopF+lB3L
 QyG1hmAgb90qPQPn2jtTq8KLUXLisO+os4b+uOiYFZj1QH3TLc3DTMrZgizNxsooG2hIOV/vNPW
 9Hb7QXvncgScBlO5qK3JBf+0zBwSGJk=
X-Proofpoint-GUID: H28zqA2ZcfXOfn-WqSegEBPEQpU5FKv9
X-Proofpoint-ORIG-GUID: H28zqA2ZcfXOfn-WqSegEBPEQpU5FKv9
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af78760 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=iNxvZbmf7GYCzVQazAudjg==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=y6ANz33TIkojjrIGTV4A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Priv spec says in the Physical Memory Protection CSRs section, w.r.t the
PMP configuration register:

"The R, W, and X fields form a collective WARL field for which the
combinations with R=0 and W=1 are reserved."

Smepmp changed the logic a bit: this bit combo is now reserved if there
is no smepmp or if mseccfg.MML is cleared.

Add this check in pmp_is_invalid_smepmp_cfg().

Fixes: 19cf1a7d9e59 ("target/riscv: pmp: fix checks on writes to pmpcfg in Smepmp MML mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4820
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/pmp.c                      |  8 ++
 tests/tcg/riscv64/system/meson.build        |  7 ++
 tests/tcg/riscv64/test-pmpcfg-rw-reserved.S | 96 +++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-pmpcfg-rw-reserved.S

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 04df53c234..021ec978b5 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -77,6 +77,14 @@ static int pmp_is_readonly(CPURISCVState *env, uint32_t pmp_index)
  */
 static int pmp_is_invalid_smepmp_cfg(CPURISCVState *env, uint8_t val)
 {
+    bool r_w_bits_reserved = !riscv_cpu_cfg(env)->ext_smepmp
+                             || !MSECCFG_MML_ISSET(env);
+
+    if (r_w_bits_reserved
+        && (val & (PMP_WRITE | PMP_READ)) == 0b10) {
+        return 1;
+    }
+
     /* No check if mseccfg.MML is not set or if mseccfg.RLB is set */
     if (!MSECCFG_MML_ISSET(env) || MSECCFG_RLB_ISSET(env)) {
         return 0;
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..4b905a0774 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-pmpcfg-rw-reserved.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-pmpcfg-rw-reserved.S b/tests/tcg/riscv64/test-pmpcfg-rw-reserved.S
new file mode 100644
index 0000000000..94a0d6f02f
--- /dev/null
+++ b/tests/tcg/riscv64/test-pmpcfg-rw-reserved.S
@@ -0,0 +1,96 @@
+/*
+ * Test reserved pmpcfg bits R and W.  Code derived from
+ * the Gitlab 4820 testcase.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+.option norvc
+	.text
+	.global _start
+
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	/*
+	 * Write 0x2 (R=0, W=1) in pmp7cfg (last byte of pmpcfg0,
+	 * i.e. a 56 shift).  Store the result in s0.
+	 */
+	li	t0, 0xff
+	slli	t0, t0, 56
+	csrc	pmpcfg0, t0
+	li	t0, 0x02
+	slli	t0, t0, 56
+	csrs	pmpcfg0, t0	// pmp7cfg = 0x02
+	csrr	s0, pmpcfg0
+
+	/*
+	 * Likewise, now writing 0x6 (R=0, W=1, X=1) in pmp7cfg and
+	 * storing the result in s1.
+	 */
+	li	t0, 0xff
+	slli	t0, t0, 56
+	csrc	pmpcfg0, t0
+	li	t0, 0x06
+	slli	t0, t0, 56
+	csrs	pmpcfg0, t0	// pmp7cfg = 0x06
+	csrr	s1, pmpcfg0
+
+	li	t0, 0xff
+	slli	t0, t0, 56
+	csrc	pmpcfg0, t0
+
+	/*
+	 * rshift s0 to get to pmp7cfg and compare the first 2
+	 * bits (R and W) with 0x2.  They must be clear.
+	 */
+	srli t1, s0, 56
+	andi t1, t1, 3
+	li   t2, 2
+	beq  t1, t2, _fail
+
+	/* Do the same with s1 - R and W should be clear.  */
+	srli t1, s1, 56
+	andi t1, t1, 3
+	beq  t1, t2, _fail
+
+	li	a0, 0
+	j	_exit
+
+_fail:
+	li	a0, 1
+	j	_exit
+
+trap:
+	# Any trap is a fail code 1
+	li	a0, 1
+
+# Exit code in a0
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+
+	.balign	64
+cbo_step:
+	.word 0
+buffer:
+	.fill 64, 1, 0xa5
+
+	.balign	16
+semiargs:
+	.space	16
+
-- 
2.43.0


