Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACACC561E6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgJT-00008p-8f; Wed, 05 Aug 2026 14:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIw-0008VQ-Ll
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIs-0007fM-UV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSHsu3889901
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Fo9WcDAG0XW
 YO36L1JlqsbMEVdpKaz9zVMY7ExGggkc=; b=ao8eh9FgDGFGYs/9DW2QV5Ajvpd
 EovEcxvfFB4m9ZWfMaWLx1BmohsJVRgWFT6w3L6YqqNEJ+/5+NYEdNed/NdZLq6D
 chPAjmjv5uGbZJRmKsQRMNyt5MmyE+oQpIXjnS+5STF5LyzcqQXufZ0oJS7tTSB9
 PK4iXMoVAxQp8eSYhCmTKAT4euqTFAYCJZDi16CTr8zBWPN7x1m9XyCxjXYTCQhP
 WwZ6Y/10dUG5Gol1Yq5ku1Qu88lGRnPzH5Fm71U5O3yTQnyw7b702hBiTr5Kb8h4
 +Czf+14uugOW5ILCkdDXukfhbjNzgFcoHbWoaqDPyvSTxWdM2gLS8JfvHsw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14waxab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:25:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9309af14fd7so132844685a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954321; x=1786559121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fo9WcDAG0XWYO36L1JlqsbMEVdpKaz9zVMY7ExGggkc=;
 b=kuJ8gVZT/9xNcBIywXyFmM7CjgMejWH4w7WeO703X3MHBpEAdOkJ9kGnL+hPZ846Rk
 DX14MiZsBxPpYLSZxBWGM4ROYNTwNBlOEDf5IxGi5h195KPw7ZQKX62qZJHYkRoQvjAP
 Bi0YE9gUvSjig6fYYj2eXUY3BsiQ/rxJsF594pmcCI7iOBqA5YoghkTxuJu5hdcPiSg+
 sCMY4bazMZ4ozVsbjtG+WRD8A0qmwyB4YYUa4EfBlzSwxGU0znOcT9BcVj6XZaqSB1yu
 LqB+/QBc/Tx2agC3bIKFps/J3oluPFhf1aNg2/dlGj/J9YkcjT5US5jXkRXRtyPKNPhP
 g/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954321; x=1786559121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Fo9WcDAG0XWYO36L1JlqsbMEVdpKaz9zVMY7ExGggkc=;
 b=fIiFmrYzCnQv1rZwjnJ5dK8i3Zfbeha+o7UiIDUj9hhqgI9YdfW9/kyrVtOCEY4gpR
 DKL8HIVdgeig3cU3PmSDpbgOMQ2W9TQy6OZ2Xamjxy731REf4iiBO+tBsH18D7Cw3EWM
 BMvH42XvNROFMdZGMnMclRps/8aS3EYzKLT1ANdmLt15uUXwt8y23jleDtlYwWIUhqIP
 uqxcfHtRrh6mnqxdq01ALU8+aAX7oCBGivlbk87GFta68vk19ZJps8GVX/bNuQjqVojd
 Aa9L5K7y/Nrn004uiU9Di4+xFflpx8+Q2oTxzysz3SGlLpb7KMNlNOdvSACgTOJemt/E
 UpEQ==
X-Gm-Message-State: AOJu0Yxm4+fs1dGjmsBrDJqWxUzulXgUncpWeh7WkMYOqJMHhDRqRFhk
 A1msX0n1QsB6zSy9wfKP6XZ5I40rkNs/jhdgAvuplJQX1Eh3q2/nK/NwIe+sY9XqXL3o8je6f5E
 2SGPJ8WjKScrUhKexSLUV/+plr4Iq3BKycg2RRd0KBaWOyp7rQS4nIE31CMMajlliew==
X-Gm-Gg: AR+sD10aSV15vTMcnBSMHSENQlRq2vxNCxcCaLXLW0PknD0j0skBwfO2ZhdlPKlC5aD
 QcGnfG1vqBsd6Q+p3L0SQi8zhxiZrG0sfcBLk1Jl3Qf3GOYC8TujEMWUupHRMg+ejiHrqgc88kr
 NGCIYOCJSm1CYIr/3zHJoO++powmKoHQCE7XkyLzicFDO3dLeIk3OhRTBF2laLwKPXbbom7FVz5
 mZK/UJb+wsp+jsp+3loHwYKUzCaVqY2nWy0I+/fHQqU3GiwWoHCVJiJodWMnEy4v2BW8GCT6Rud
 2rYt5qLiAma11ELRUxdJoRTbARBpDieh/rijxzFV5Wn+SzlsZMvCZTu+AOHZXloZCkt+xWvfiie
 AuqzeZpnh1+7mz1KmwuxJtAxSEWq7/3fnKQE3mw==
X-Received: by 2002:a05:620a:260a:b0:934:9a26:eae9 with SMTP id
 af79cd13be357-9364910ad88mr902662585a.17.1785954321324; 
 Wed, 05 Aug 2026 11:25:21 -0700 (PDT)
X-Received: by 2002:a05:620a:260a:b0:934:9a26:eae9 with SMTP id
 af79cd13be357-9364910ad88mr902657285a.17.1785954320860; 
 Wed, 05 Aug 2026 11:25:20 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a3fc901sm209387885a.6.2026.08.05.11.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:25:20 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/5] target/riscv/tcg/debug: adjust 'timing' bit for Debug 1.0
Date: Wed,  5 Aug 2026 15:25:04 -0300
Message-ID: <20260805182506.2943757-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX2A1LjiIRXRV/
 9E6MOsSrPOo8/uVeCC+cJs7nUOlm999aPGIYfZTxuH5TMDpygB+EKFrcTHuJLKRInYt0uIlyfGL
 02ecvZ3SQ0AoYnYfikj4ViKuApPg53k=
X-Proofpoint-ORIG-GUID: OORPBCGb3cNjoWUQPk1ySfHyqbA7VLE2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfXxxtEd3wro7je
 tvdvZqGYksCf1hKEOC3RWNz/oT3mDXC6G7n0bJhemqnHnJXNAYYij0LDbSB6bMYwCfXP36wuQIE
 vqso11A7w/Y6GNCerFhLCbnlqnD1cqCj4cM1UQqFywXdOeieOYoaX2a+gYRLyeB0y0P+aVsuz8l
 v6sLCL4dzhDAdCjNogs09LdjaDLWS8iYAuorRU1cUZw6iZUuerNx1S23JZlTerx/iV3H5UuXjSZ
 cdfWo3a3YC7tu4OP3/tr56sYGHvwXL1mZqB8E1ZyDqm8VFxD+Jx05ljm8fgaoL04vGkg0J9VtJ8
 +9E+HaOY5ycHIncA5UZPMQXHEEWJS+iHvCvrLOBUDCwB5AF1Mv8CQQr1GvtGwfwTu2FheZKlVOb
 HAS45ioWplrzM05sY8UsQ1eoTFjY5ULbhYt+is213Gb/8oz45/iuJBSfH4KRAtb4z4k2UQbZ9IU
 idbUvWrtRotil+HQOBA==
X-Proofpoint-GUID: OORPBCGb3cNjoWUQPk1ySfHyqbA7VLE2
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a738011 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=hcgX7uFSkN2IqaP9zZIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050151
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Version 1.0 changed the 'timing' bit.  It is now bit 18.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 7 ++++++-
 target/riscv/tcg/debug.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 2191928761..8b23c8d045 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -584,10 +584,15 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
     warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
     warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
-    warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
 
+    if (debug_trigger_version_1_0(env)) {
+        warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
+    } else {
+        warn_always_zero_bit(ctrl, TYPE6_TIMING_0_13, "timing");
+    }
+
     /* validate size encoding */
     size = extract32(ctrl, 16, 4);
     if (access_size[size] == -1) {
diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index a25d099b37..eb635bc277 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -98,7 +98,8 @@ typedef enum {
 #define TYPE6_CHAIN     BIT(11)
 #define TYPE6_ACTION    (0xf << 12)
 #define TYPE6_SIZE      (0xf << 16)
-#define TYPE6_TIMING    BIT(20)
+#define TYPE6_TIMING       BIT(18)
+#define TYPE6_TIMING_0_13  BIT(20)
 #define TYPE6_SELECT    BIT(21)
 #define TYPE6_HIT       BIT(22)
 #define TYPE6_VU        BIT(23)
-- 
2.43.0


