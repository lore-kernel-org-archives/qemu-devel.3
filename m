Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201FDC98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKU-0002M2-RR; Thu, 24 Sep 2026 11:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJY-0001nH-IV
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJW-0000Eo-Cm
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OF8nNR2032527
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GOW72uFGUBB6MPEX7SpsSjVfsnBYgSzUVnB63yf2WNM=; b=dZ6VThP6vO+zJXxm
 U2HOVx9YrJtuPY31qsNTFm91P0bEWUOFXfN7Lxd1m8cJR6u7EoGfn7NaNPzgDfaL
 NYYpJtWC4sinho+n57DQTbbAlsUKn6g6FUe5opetRAIdWozAT6guBWIMPdOyQyYC
 7JgWmUvdQ5pvnYma/Xdw583zcr3OT9O/tQxJldArM6juP+s+I7NXsmD4TywfG20Y
 Xf6EYNS6Lb7X2Z30Q7MTgko73IxSrZclgi8PFBNnNPBQcv44EsEaoS4O8kDz362o
 8k3oKrxs/++dZ/dkRupTCbcqgLGSymO0iRiIa8AG5dK/wK/C5g3Bx7GEUz2alm77
 lU2cHQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e03n2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:44 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c8337b12d0so819950e0c.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263484; x=1790868284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GOW72uFGUBB6MPEX7SpsSjVfsnBYgSzUVnB63yf2WNM=;
 b=iJOSkcq48HECdH3GEbfcIBKXWBWgJot/IK5BQP9FQQIaAPK45qVRokKP/WzLM+KyOr
 x+EMk7pdb4Bh5kIklkJv0jwLoJBew0D8+m5a3sVCogUSF98CHKpGsLdQtfdTwpOELwpS
 oLR4Wh01B+Vpi4AFjMRL3fbUCgvb94TVGBTb4Em5OVnirq4FKyxV7o0seNHDG4TNUjcz
 GBIbloykpIE/IPAhbRYDvgwR8Vsk5suy7v19/Qt9y6MDqbyvBS+xIEP0NtxkrhNi3zN0
 9wAoAVUXXhdh3/Jt6OYgLhXUeSdkHwrb3VykdNYLhRy0kmiWQi8mYJCW/yRuKp6E9Ae8
 tb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263484; x=1790868284;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GOW72uFGUBB6MPEX7SpsSjVfsnBYgSzUVnB63yf2WNM=;
 b=cAQHEJA+q+gz66NfIqti+tEoSkhSp3uS08KnGuZvEQuTTTOraIQ+Zs3a0iIhUnG69T
 rzcZNtURs47RDEPLD3qwJUOwavmsatYybkdLDbdeht5Cxrn8Bn+WAGVzEvdk7h0GAoqW
 BClyl5pOqTKoR5hGfLdii+yndNjFpJO2iSPrH/yJb78FcGkeZaJzlGfhxAGoCMfhqgXw
 kME3+4ml0w1hjDJ90+PliULg5sMMilhYJZShDUShIxnxPoT7Wt5p70BrxxMrkjmfBGXG
 EgdGUDuRj2K6KNKo4u6ozAi1HhU6LhRSAsp4Emimn7yQpRZCX9t+djVqxAic+ovPheZM
 DXsQ==
X-Gm-Message-State: AFuF++npVSk1t5MVJgRkQLpzVMhyjAs8OR3SMdXWOjB3/UKeo9NNhBOw
 imP8vZgCAkdd7haLev7vR3zXPFSxaCre/k9hXNQ+3Ef2wxUr7q9bHkS4bBixL5mz4XTIbt2m2PG
 8/qdbMhMzzZeOnB1WLvayD0sQm3NhpPgBJpYrJsYtMa8wELt62OmRMt97o6yGsUp2bA==
X-Gm-Gg: AYBFou2HVFhM4oQ3/ZQwu9V8O+UplRKQoDuogfngTU5UPvieBz3O4X+gxxqLG68VYl4
 qLzpFDl4cu07gI8dHEFZ/eVsxBL4A4lJnOH5va+3M2tEDvG/FPlXjXAeA3simPM1HvLauhXmS7N
 BB5qbaF6ToPGTr8esPANpE9raibRIkuiwnZVCIMxWI+fmg/12GCnzPLL+21lKHEiLnt4TfEqKZJ
 u2B5sKjT7esZhy91t3rJmM8cziI/uwxn+kRxUNtH7hgLV/58FVGRpc7q8Pk5YjFjTS63Fj9hPW7
 GQsapA9zZgeYiZyl+eQDuv/yipxdFKC9uZAM7OXg0TlG+pVlft6cPvhQjLq01vDgZNbpffrjU6c
 ev1DGITnPHIXAoczReCv0NcTdoO0i9OCEfcUZhGGF
X-Received: by 2002:a05:6102:e0c:b0:7a7:a382:6bd7 with SMTP id
 ada2fe7eead31-7af1dadc05bmr1298003137.27.1790263483612; 
 Thu, 24 Sep 2026 08:24:43 -0700 (PDT)
X-Received: by 2002:a05:6102:e0c:b0:7a7:a382:6bd7 with SMTP id
 ada2fe7eead31-7af1dadc05bmr1297992137.27.1790263483022; 
 Thu, 24 Sep 2026 08:24:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682673bdsm15356445f8f.2.2026.09.24.08.24.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:24:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] target/mips: Split out gen_mxu_logic
Date: Thu, 24 Sep 2026 17:23:38 +0200
Message-ID: <20260924152353.36209-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX6/Fa8FwQvSAW
 tkDxqzfxujla1qKMMeEsIulFbTbJPm+bXTRyn1+8wW93JUJi6BsnyOAfh1ypohVKX3z4Dp+RB+D
 JJM98bpDNb1ytOQVfukvu+oRCak1SSFjslKBRQwY7eSVqnS50RPygp+0YmccDXgw1wligTtWG7v
 jIQWhfujd0MmOEADPItaq35AUaHfZzo9/aQfkhj3LxaTnAL9wWD54keDwZvtfW2ulJjNWnhsI+D
 LFYHy7w1PvSgJfIEYpHgFT6dqsX26xHQaW6M+5xf5m0GOe7JHUCTl76at4p8Wy63MYMLqf+l4r7
 P0qQOn32J4ZKRL+bDGLCMGT5cXa+h0PH+FwHfSHVKms1hvjcTkelT3RIJkZoLCYbPYz11dTfKnk
 YomfzUyTCgqhQBGLNhQ8PrZfl8SKD6KlOiyu1Kcf0Kpl4djGfqTNuRVpdj9/ai/ehRm5pjb1Gm0
 WJ9+z24hCrEyP+HM0IA==
X-Proofpoint-GUID: rdRqLxh22Uc2V7PTKNqALbmFzsdU-NAe
X-Proofpoint-ORIG-GUID: rdRqLxh22Uc2V7PTKNqALbmFzsdU-NAe
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab540bc cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1JvdxygaRBgx84FT6-kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXx2QxSRQrWlRo
 n7Xucwj8nSPM3LsgwZoB0z+gFzcyoI71sEMEp0Se+llQZxCNxM85a6oA9p8oLL92czlhXQdpQWx
 waAQKDT4I45Mdp9yLVuagBVujJpNzmQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

From: Richard Henderson <richard.henderson@linaro.org>

Split out a helper for common expansion of a 3-operand insns.
Drop all the special cases for 0 and let the optimizer handle them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914230901.1781309-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c | 122 +++++++-------------------------
 1 file changed, 24 insertions(+), 98 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index f30883f976f..3f8acfcdb8f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -1685,14 +1685,11 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
  *               S32NOR    S32AND    S32OR    S32XOR
  */
 
-/*
- *  S32NOR XRa, XRb, XRc
- *    Update XRa with the result of logical bitwise 'nor' operation
- *    applied to the content of XRb and XRc.
- */
-static void gen_mxu_S32NOR(DisasContext *ctx)
+static void gen_mxu_logic(DisasContext *ctx,
+                          void (*gen)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     uint32_t pad, XRc, XRb, XRa;
+    TCGv_i32 t0, t1;
 
     pad = extract32(ctx->opcode, 21, 5);
     XRc = extract32(ctx->opcode, 14, 4);
@@ -1701,24 +1698,25 @@ static void gen_mxu_S32NOR(DisasContext *ctx)
 
     if (unlikely(pad != 0)) {
         /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 1s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0xFFFFFFFF);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the negation of XRc */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRa zero register -> just set destination to the negation of XRb */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to the negation of XRb */
-        tcg_gen_not_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_nor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+        return;
     }
+
+    t0 = tcg_temp_new_i32();
+    t1 = tcg_temp_new_i32();
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+    gen(t0, t0, t1);
+    gen_store_mxu_gpr(t0, XRa);
+}
+
+/*
+ *  S32NOR XRa, XRb, XRc
+ *    Update XRa with the result of logical bitwise 'nor' operation
+ *    applied to the content of XRb and XRc.
+ */
+static void gen_mxu_S32NOR(DisasContext *ctx)
+{
+    gen_mxu_logic(ctx, tcg_gen_nor_i32);
 }
 
 /*
@@ -1728,27 +1726,7 @@ static void gen_mxu_S32NOR(DisasContext *ctx)
  */
 static void gen_mxu_S32AND(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) || (XRc == 0))) {
-        /* one of operands zero register -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_and_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_and_i32);
 }
 
 /*
@@ -1758,33 +1736,7 @@ static void gen_mxu_S32AND(DisasContext *ctx)
  */
 static void gen_mxu_S32OR(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the content of XRc */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRc zero register -> just set destination to the content of XRb */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        tcg_gen_or_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_or_i32);
 }
 
 /*
@@ -1794,33 +1746,7 @@ static void gen_mxu_S32OR(DisasContext *ctx)
  */
 static void gen_mxu_S32XOR(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == 0)) {
-        /* XRb zero register -> just set destination to the content of XRc */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRc - 1]);
-    } else if (unlikely(XRc == 0)) {
-        /* XRc zero register -> just set destination to the content of XRb */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to all 0s */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else {
-        /* the most general case */
-        tcg_gen_xor_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
-    }
+    gen_mxu_logic(ctx, tcg_gen_xor_i32);
 }
 
 /*
-- 
2.53.0


