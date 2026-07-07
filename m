Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2950BC44507
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAP2-0000yF-UL; Tue, 07 Jul 2026 14:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAN0-0007CQ-WA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:18:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAMz-0006fE-6Y
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:18:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT2Bp4073514
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:18:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CgS9XFauO3KSfOojWTo4Z4kVN7kcTgbfNw/MBbeYG2M=; b=OIyUsm1zeruHovOv
 pY4mruCV/XucRKWlu0dYg+8G2ivQtMpusRF0P+drFcysBIfM9viynnHGLjFZz8Ur
 hEORsVa4x3nopz+XPdIyveks7kCEdsKmZRlZ8k47LPqj3hSU0z+c/0J2s6fIRfmj
 2clHjk5ZO6xanB7Gpj/dTF7dUn3zO0lnGAIknJko9hRdkJfpFDonqMX5Fdvzu/Q4
 Zfk/lvaewvvlJxlSWuUIgWhhFS6yZ5x8Y4cabr5/YjBo/zVwLmpibb1Q/S9shcpz
 sX7pa/SS10t+bk1GaIsRFBvEqKwUDPvG0u1kO15m3Y7BrjLmz+Mh4m1AYQWpQn5q
 ZRU8wA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun2skw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:18:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so104320571cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448287; x=1784053087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CgS9XFauO3KSfOojWTo4Z4kVN7kcTgbfNw/MBbeYG2M=;
 b=e9J5dFXhKpYP971nFMVJp5MmcQIWR3ryGVQsaODWbCPpfKqckmMizET56ycNs7Va37
 kdCkTy8hW5Pf23HwCMagkQWFXJIw76hzY8XC/A5SOcnzVwoT7t0F3pKMbMvfsxTfuUm7
 7bGyqHOnUQX2+koxkamdg1Y7SlvvANVqlLV8dALF5PuT+7rkmljN7XNySKDtyLNCaiq2
 uFh+Zcj2CWhDlM3g9RG6KcE8VfrtZzEcg0bPfhNVPgr/5kA4DI5L/VHq1bBy6olMzera
 P2qlMFT4IZTHEIs9/2SzKXd7LjfZ5HtS0PVqLhc78wco255CYhvEp6JMNs8GHKuGIDO/
 p23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448287; x=1784053087;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CgS9XFauO3KSfOojWTo4Z4kVN7kcTgbfNw/MBbeYG2M=;
 b=cxjaEyGDzjuBYHV7/u1HMZs6khE0zgqO6Cf5OZjZjK94q2trtuGqzsiDRejm0umrfQ
 WbuosWiSe5bW2l56EkBuGaM1Yvn1gyPo7Ga1UyV0glJoGqNIz9dSQNptxc8TQoN5R//h
 5nQ75b71+3W9xaDgqLmpdS+K7VGPeguZooZIqgIUNB+FBEHWx56TmWhr0OqDZdAw+wVb
 Ai8PyHxRblekWIDd1YsO3zG4VgdtPQtgej4Qg1ji3vaApymMckd4yCNfGwGfpMuwKG/T
 /WI95Dd5wFmxXLiBoQZddssYM+fXb3jqVo8zH2xMxLBAJb5Bydt5WhjCAD04aMKZsHw5
 1C+g==
X-Gm-Message-State: AOJu0Yw3MWLkxlZYLgBO4aOfScFPOxyKdcXCSeRg3IOS6kI46aKERFcu
 kTo3+Gq/69dd9V9hlN64uO24iWNNXVd8Aq0dqq4OSntYtQ45ZvLuMRzXCx5fSwVTbb4ZL56QPsP
 o1f1h2VPfM7kactsZ+01fhiiL6Mwi1ILTC9hlqit75TMiZAzqkwe8gD/xfnmTk5bnmQ==
X-Gm-Gg: AfdE7cnnciruruDFBBZb6JnWbEoF4Pe60AW8dmZXLXcYJ70vwGVIIlyi1ZhdSympmue
 BqnUuXCrXn8gPf+XOGLtH+HStxPKEKz37akArdA4J5NG2PoqAAkw92RteDO84Ow3HZKqPeChwbg
 pXELTjv/l5ahlujNykw7C9wfAgrcJvZGS2v0/V3kcjDlKYxaZD7aaHWkTJqKtcRioFJBxtZ/mZq
 D9A47ZxamNu4dDu9OI/EataVBSiaMTI33gmUS4brNMpo+JgsQ/5moRWO/2/umCCssU1Vo3VhkQ6
 MzAdTjjDgprgE8PdfXQi0uHeZMrffsboVlpQqBW5vAG8UJEffmxj2yGfwPQxNvcmorRaygRDNK1
 MhCmGEeVqIQCiRcRhVtJ2Una7W1sb8fIqvoPbpUGFfxS0d43qD9VSLTwZtjAftwWnkut9
X-Received: by 2002:a05:622a:5817:b0:51a:8c9a:8fb4 with SMTP id
 d75a77b69052e-51c748e0ae6mr69526011cf.69.1783448286552; 
 Tue, 07 Jul 2026 11:18:06 -0700 (PDT)
X-Received: by 2002:a05:622a:5817:b0:51a:8c9a:8fb4 with SMTP id
 d75a77b69052e-51c748e0ae6mr69525111cf.69.1783448285410; 
 Tue, 07 Jul 2026 11:18:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f4ef53sm81903205e9.8.2026.07.07.11.18.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:18:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/23] target/sh4: fixup tcg for sh4 fipr/ftrv instructions
Date: Tue,  7 Jul 2026 20:15:27 +0200
Message-ID: <20260707181529.60191-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX90rWiKtp8yaP
 nSZO++GNiiv7SFNyKOe5ymomr9vu6JZ/jWmC7ZtIHOoezMSzGVocBMULHONWMPnn41aiLgS3U8f
 0v38P4RSXlSDge9YhbdkC8hDbGHkBAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE4MCBTYWx0ZWRfX+9u06M/wVdbB
 i28UxIKoQbRp+I1Zea8hVa5J9tHMMvLP2Q2J6YiiQevuLI3vUYVR5A6TTDtZXXmcZwXthRSczjm
 45MaghzKJmFgsiXG30ieUgSUQEEz/iAU5ZGqp/FXUvi6yrSLyvDKPtIPl959U7+jablXelDbRuc
 z0XsuLvkFZuuDTj8ClXUnUnhpz3DsK1IUpg3N/ruweoj5MD+kYPx9nm2/RCKl6qCRgV03OTBPuf
 h6/I4BrP1cFOWH5HAAsNDsjoYTqjFrNa60THYroYsbO160ZzxhbwYqB7qnBPZlSm+9L8yMQLWUy
 D46MTNKZte+Ec91QiVPILQJoifHwgciyR1u3PelyJoThWPlyT+P3/nAzehmCBSoqHyx1jJJ6Vk3
 aQtAp+iZpdYXTXDAgwSRYEjVo62T0Cqjmy1ALUKly7rlbzWh/N27oNeLXzcjznmcX3BYBiklSlK
 0LwiV5Q2CQOfTtAkEFA==
X-Proofpoint-GUID: 11OM9Jlr_L0FLe149YTGxdcGWh9fgRrC
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4d42df cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=YEB5RgzmAAAA:8 a=EUspDBNiAAAA:8 a=QUFLcnT3Zhn122vlBIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 11OM9Jlr_L0FLe149YTGxdcGWh9fgRrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070180
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Randy Schifflin <randy.schifflin@gmail.com>

Fixes TCG generation for sh4 `fipr` and `ftrv` instructions.
Updates the current logic for these instructions to check the
FPSCR register appropriately (according to the sh4 cpu manual, `fipr`
and `ftrv` are only defined when the FPSCR register PR flag is 0).
Also fixes the mth/nth-vector operands by multiplying by 4 to convert
to the correct floating point register offset.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
Reviewed-by: Yoshinori Sato <yoshinori.sato@nifty.com>
Message-ID: <20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-2-4356b305f971@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sh4/op_helper.c |  2 +-
 target/sh4/translate.c | 15 +++++----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 90c065b217b..777380f8e40 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -488,7 +488,7 @@ void helper_ftrv(CPUSH4State *env, uint32_t n)
     float32 p;
 
     bank_matrix = (env->sr & FPSCR_FR) ? 0 : 16;
-    bank_vector = (env->sr & FPSCR_FR) ? 16 : 0;
+    bank_vector = (env->sr & FPSCR_FR) ? 16 + n : n;
     set_float_exception_flags(0, &env->fp_status);
     for (i = 0 ; i < 4 ; i++) {
         r[i] = float32_zero;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d38a6bd352f..373950fd662 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -377,11 +377,6 @@ static inline void gen_store_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
         goto do_illegal;                    \
     }
 
-#define CHECK_FPSCR_PR_1 \
-    if (!(ctx->tbflags & FPSCR_PR)) {       \
-        goto do_illegal;                    \
-    }
-
 #define CHECK_SH4A \
     if (!(ctx->features & SH_FEATURE_SH4A)) { \
         goto do_illegal;                      \
@@ -1740,22 +1735,22 @@ static void _decode_opc(DisasContext * ctx)
         return;
     case 0xf0ed: /* fipr FVm,FVn */
         CHECK_FPU_ENABLED
-        CHECK_FPSCR_PR_1
+        CHECK_FPSCR_PR_0
         {
-            TCGv m = tcg_constant_i32((ctx->opcode >> 8) & 3);
-            TCGv n = tcg_constant_i32((ctx->opcode >> 10) & 3);
+            TCGv m = tcg_constant_i32(((ctx->opcode >> 8) & 3) << 2);
+            TCGv n = tcg_constant_i32(((ctx->opcode >> 10) & 3) << 2);
             gen_helper_fipr(tcg_env, m, n);
             return;
         }
         break;
     case 0xf0fd: /* ftrv XMTRX,FVn */
         CHECK_FPU_ENABLED
-        CHECK_FPSCR_PR_1
+        CHECK_FPSCR_PR_0
         {
             if ((ctx->opcode & 0x0300) != 0x0100) {
                 goto do_illegal;
             }
-            TCGv n = tcg_constant_i32((ctx->opcode >> 10) & 3);
+            TCGv n = tcg_constant_i32(((ctx->opcode >> 10) & 3) << 2);
             gen_helper_ftrv(tcg_env, n);
             return;
         }
-- 
2.53.0


