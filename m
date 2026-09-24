Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD5C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKa-0002ZE-3c; Thu, 24 Sep 2026 11:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lKG-0002E5-Aa
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lK5-0000H3-IG
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4dLO3134223
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6zg6YVJsmF34BPPBLbzJK8zQve2DoCG4As1F93Ln7MA=; b=Q5MomlQc8j3fdd8T
 rL13MqIoy8BV29ln5twyRd25yPiPeGScZRtn9SjvKTUH7zvHJwBQAqG+/iHT2Stf
 Izsn7RxzaEjYcj2ppvL5ZFdfR0IItq2I6Kd5Ourn8E3TSyQY793qKuXyGBQOU7Ol
 s1xh1ffqUfMSREpSuZCnQIJLp1suyzhS/EIa6IuTSBqcjtVpNL1NR6qlm9Cgvpcl
 ssx3zw4RiZ1hxxH07Drah3JLijHN1ehhTWZDHgydnNup/JrMVFzfjcceaIT3ZWWW
 wJxXCUAl/v7ACWnWuMDHsCS92aDfGzJKghrZAKufH2r7WG6zk16g8VK3AGJWo9Kw
 ZvcBXw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1rahbu4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:25:09 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9806535f8ffso855814241.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263509; x=1790868309; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6zg6YVJsmF34BPPBLbzJK8zQve2DoCG4As1F93Ln7MA=;
 b=O5pXXbzkNRagLuEYFtO//PCH12FT4al4OxTsVaV9V3vt8KgpvFZDS/ONsf5D7sLy1J
 ci3yq8ZgEt4zOzpXzyZjFJukdtMFTpINsKpdEep4mwoc6yp9maBecgcbcWVxTQD3tx7R
 K22DSY0CwPy5JjcVljDwRaI35r1Am11Yboq78rJwMNLQuPQDyPg4teryJy0h/b1jMEv+
 dpT6v6hVdhw4Dw5UxawR9XI+Pvuj1mccqp6E03JjIo6Y5a6UbWuouwTtLNDMGoIv/k+1
 EvfGBxkOxzafZXxW67P5QlHHfd5bNQ/YTAeXaEpB7IrucwutrpzB10c7p9t7W7OJvU7H
 G8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263509; x=1790868309;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6zg6YVJsmF34BPPBLbzJK8zQve2DoCG4As1F93Ln7MA=;
 b=QEtH6yC8g6nwnPN/EZ3QXoTM/FBIPnYOBww+A/T0uS4ipV09H9px3HsLG+6gcJ+bKZ
 48MRvBmSYl1Yfv4j16qxXU1uAVBhTH+FypQyRAnGLdIngrBd4EHTu0ViGlE9/KQV+2yy
 cnskfEsl1TL5aISJrQTaS9jFjTCaEA7xrIpQwZMCDyG+BOShtbbfxs+/t1YT8n1Wwj8A
 jHHUJoHxnJLpONgm0b4D09QwSMegTkX9/PLX1tLPRj6/vWAX41/iYY7EDHkY4Om/nMW3
 8qQIdKHIpNGFLuSgmS2Oj8JffRFzrZC9OXzQXzbSAYQO+6DZqeYpHfYdcK+360kaxbLD
 PlZQ==
X-Gm-Message-State: AFuF++lLbSDQSdKSztY6HNmFbDwuwSF9UjFtFJxNaxtmWwixlkW2huoI
 P4QkNCI27oioZitM2Uwp0u+AX9vIxt5nyTMZZZSrA8qSBqEP2gITQHhyGYrmbQoPTmOml5F7fM1
 I6Sr6c0q+wMkwH+P/qcK7efxzuTThZtoAl47JGzRpjGGyyWIEPjmBnaXfLm3hNJN+VA==
X-Gm-Gg: AYBFou33TVPmfk4At5Mi101FxiDctbqaPmO76vLavvo2T7HU52bdCV2P1D4TDmy+T7K
 eEhSuSIaHy6Kxm8YFh6xWQee5cZ9X8ksGw9hS0LH7jJzVCBJcLavnCVdvFV5+K1qGJvXxS0fQpk
 1tAH75mZplUBgkLSKb3tCq3FKsJKJ9XikL2l0rvPUQdvsBOOG08zP1fI0sfqDRbJ8NuOn7z+kza
 WWvyk/RlCCT40659ETvPmXhhBkzYxWoH4AFGl4VvgkR2nrUvNix9gH7JXXeTYXAWo+BiRxvAzye
 s/QEKluxvTDFbsg5X9EJXDL4hB2ElsW1pAr4TTxcttY0AugNVtH1ioYVkpr8asJ3Sslk2ayhfga
 /I9wYeGQA/hPRpumhm0GgRyGSS3ELpztR1eWd5jXt
X-Received: by 2002:a67:eecf:0:b0:7ab:d498:aa69 with SMTP id
 ada2fe7eead31-7af1eae9c50mr904326137.23.1790263508597; 
 Thu, 24 Sep 2026 08:25:08 -0700 (PDT)
X-Received: by 2002:a67:eecf:0:b0:7ab:d498:aa69 with SMTP id
 ada2fe7eead31-7af1eae9c50mr904318137.23.1790263508161; 
 Thu, 24 Sep 2026 08:25:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688856f0sm15251030f8f.30.2026.09.24.08.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:25:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/18] target/mips: Use gen_mxu_logic for gen_mxu_S32CPS
Date: Thu, 24 Sep 2026 17:23:41 +0200
Message-ID: <20260924152353.36209-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfXwEECCC41VqJj
 ZGubhbTsMY3zt55VA33IenlROeUoElKZACkeighEQVTHPZZFWbGbiWpHm7rMxmgSfGU30AL7NK0
 8q5S6SvezJzBQr2Mkm7tHHtf+6VvoJAr8bi5uqQuTp1YPJMq9qkbSDPvCdoyeHLE2pguzKPlmlo
 w5g9aStWSSnTF0BJeTMoi4jxPnGUgGdAldnKbF4MoaVusMB1AuM72Thc2321sG+JmXw3+EElmH2
 zidBKPEF7ovs9fOHLk7Hes6d83HFhk3HZZMuC+VbJLuvYnJFZ/zBiR7g/hg5GeYYD1bPE6DBgQg
 SJ2Np8LIx9KN3li9lBNuJ5pu9kFVQ4flSPdbSb6zRTp9f3tvKVSZZD5kzVsURD9AbMtuErhdX04
 JtledSzrWYydps7/bOoVhGakp4rqc5qEjN4Ygp66klMBjgXBelPoarllcsDyrA3B5hweYiSGRho
 hSFOTzfF4GfiZpJOGrw==
X-Proofpoint-ORIG-GUID: KXiLjX4a-BmHBK_k59ZIcXL_CGLC1n7O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX/SzmPvEbIuvZ
 3eiL9Hkc6+CaKniF6QV2v0mU2zhFbaz7Ywix8wCmx+7qPVwTWHBagGjJS/Tg1NqODU1u7zN7sw/
 IvTXuiWj8n+d+RbshXdqMROWi3bXGXQ=
X-Authority-Analysis: v=2.4 cv=fvpJ914f c=1 sm=1 tr=0 ts=6ab540d5 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XNZCjgkWDX52U-mK3XcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: KXiLjX4a-BmHBK_k59ZIcXL_CGLC1n7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Use movcond instead of a pair of branches to perform
the computation, packed in a new gen_cps_i32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914230901.1781309-7-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c | 42 +++++++++------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 293eeb46c23..a38f4da12ba 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2640,39 +2640,19 @@ static void gen_mxu_s32movzn(DisasContext *ctx, TCGCond cond)
  *    Update XRa if XRc < 0 by value of 0 - XRb
  *    else XRa = XRb
  */
+
+static void gen_cps_i32(TCGv_i32 a, TCGv_i32 b, TCGv_i32 c)
+{
+    TCGv_i32 n = tcg_temp_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_neg_i32(n, b);
+    tcg_gen_movcond_i32(TCG_COND_LT, a, c, z, n, b);
+}
+
 static void gen_mxu_S32CPS(DisasContext *ctx)
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
-    } else if (unlikely(XRb == 0)) {
-        /* XRc make no sense 0 - 0 = 0 -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRc == 0)) {
-        /* condition always false -> just move XRb to XRa */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        TCGLabel *l_not_less = gen_new_label();
-        TCGLabel *l_done = gen_new_label();
-
-        tcg_gen_brcondi_i32(TCG_COND_GE, mxu_gpr[XRc - 1], 0, l_not_less);
-        tcg_gen_neg_i32(t0, mxu_gpr[XRb - 1]);
-        tcg_gen_br(l_done);
-        gen_set_label(l_not_less);
-        gen_load_mxu_gpr(t0, XRb);
-        gen_set_label(l_done);
-        gen_store_mxu_gpr(t0, XRa);
-    }
+    gen_mxu_logic(ctx, gen_cps_i32);
 }
 
 /*
-- 
2.53.0


