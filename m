Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7061EC98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKQ-0002G2-4q; Thu, 24 Sep 2026 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJh-0001tV-65
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lJf-0000FH-Hf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4gj02594260
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 38V3STL3tSJ5OL4pSTft0xjYD2BEjAFZOvKjLqQ6Ans=; b=icy27tcZrSP/vd4g
 EMXYAb6s9Kp0jZiYSzqtt6PKR18P6s9orckc/gUqT83dSihbDGf8rnQrGFV4Dg4p
 /DMF+5fY58Qj1b0hKatcwYjpokHfcODECRvEFJveVgkqiOA1N0JUriuT75FkoKr5
 4gSUAcf66B1RKYyDpmavQkU6Im+L/pn+IxZqO3py6djfaSNVg9ellkxBPqhl/Rjq
 dDpC6IsbHgzQAhiR4Dt02wkwmw+jbYWGb/sr/xHt/Ocfd6uYNiKAd8ZqEE2WiuhG
 jmIhxq1ZKBiSnrPK4y784qbMLjQiZUCRW4u5tuJnFRBCZ/mMxty9LeEiPV1I9DD8
 am/KfQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1tjh8s3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:24:52 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7ac2663eba2so1627496137.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263492; x=1790868292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=38V3STL3tSJ5OL4pSTft0xjYD2BEjAFZOvKjLqQ6Ans=;
 b=Ab1BNhMnfJ0P7gusUcZ2bnNNI9fDMJhwfbV9eN51b9pqA70M8MiDhnmrWFuNMWo0iI
 miT/WrAQv7Ufj6lY6NJw8TLx367qWY0UdxkJv+LuLkjlIOU+iVDfAKthiV/M2HCUY4Xv
 FRcGWcw+pSYGYi4n5pccDCo/B5UC+zAsLg0hvnF6QZQO2PCp5/4g4Z2h390o0EvAdMzu
 FjNwQLoCWVL5V9TzFWbVJ50gVA7ONHrwn1ygHzagI1KmTQauTwD/02v/qHrKb1g3rKke
 4VJkDQD6raiFNylcA62ClvA/oE1Wba2Y8qnvQ23BUFq4dlB3Z2Q4XyT0jTk9oq/VBOTV
 AQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263492; x=1790868292;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=38V3STL3tSJ5OL4pSTft0xjYD2BEjAFZOvKjLqQ6Ans=;
 b=N0d1I3+9+Za9+2QxFnvflOb9jvhwAsALHn/L0m//0SxJc7VnmNEqi9wWRaREo63Vwo
 9CHZ3c35XbOkcnpJ+yLMG41puxY4fOtK/nWBG9QkxHdEYlO+YFQ//7cFn+EnaQNqs3rI
 znK+L+oGbuO5zWu0cWLZzqOYGrX55TgtFhUJXJD+Sfj0ckVErk29D0bKS1a2N46CrBAn
 uN2F0iligLsEKK6MbSQUQW3uELAzbDBCvp13TPn5Z+Cv1vBxTsI3cURg89Ppuz766hr0
 Fh1Z77OZ8JLfB5ZDOegV0xfiMInMm+5NDtgKz8z81QPOUayNjwxq4DS8024miKRXtFzR
 5y1g==
X-Gm-Message-State: AFuF++kpzkEdcznDeba/udO2N2SyZo0X6KVV3phCrlKRo0XtQ04Y4hJt
 geQpy+pR9OU5kn2yL09OXSFDeXM5QSSrrsh4bv5HoYoGM/iQl5ZhFX8DM1FyEx9SOhZdWQEs7ia
 As26Ld5BxrEfQhHkHf6CJOPxqPzxcZuqiYYk8Yp2mzzQzAayampLSPuYIbphVJ9qZjw==
X-Gm-Gg: AYBFou2niIXqKuJY7RiCHfwDN1CwvOS7JFJFw1ZG/jGWk7wxgN6p6/yJGipyW7+zWaL
 /kWEwj7vYgVeg7J1CJSUqmQP8x/tdvpvJMpZLDAt3qK8O0HGwD1HaFplqRiyjQv5SsH+t06Evjy
 J3hS2VzusrneyWRCfpnDiIEg8T5W5wEtkb0wyw/T7FLWFZdOVH1bEMs/0sLChhO84Ohv43wKqHR
 Xf0spBihmpVZrw8WotOAkDkD2eTSiSAgjwnGYvJNVP3Ifb8cXY+B6KA7upQvwoANJC4Q4p8Dwsf
 ZVH4vqI+W7n3eExmaJPy2MsgyTM6YWFkz6KtDrkMk4I5sFiKuhbjr6YsDw5RiEJfCPerb3URVZI
 nJIG7tqk3ZgRJNvuyCoFI2pIIRxJ6szLU3UsZkngb
X-Received: by 2002:a05:6102:f9a:b0:7a0:3902:52d7 with SMTP id
 ada2fe7eead31-7af197379b8mr1522184137.0.1790263492308; 
 Thu, 24 Sep 2026 08:24:52 -0700 (PDT)
X-Received: by 2002:a05:6102:f9a:b0:7a0:3902:52d7 with SMTP id
 ada2fe7eead31-7af197379b8mr1522169137.0.1790263491578; 
 Thu, 24 Sep 2026 08:24:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4271sm114985825e9.5.2026.09.24.08.24.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] target/mips: Use gen_mxu_logic for gen_mxu_S32MAX_S32MIN
Date: Thu, 24 Sep 2026 17:23:39 +0200
Message-ID: <20260924152353.36209-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -upKQelahWpiLYbADJaFoL2t_iGkmRQg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX3Y5qUE0DLwmQ
 ZW+96TutKhWiOYXb4bMhYgemlyTx8LFq28A6LWnSWWcP8dMZ6nsVPgsL0CCSn/aN9CtMrkzoMUa
 fHATBhzg3xQlUgpj0WucW2gEKbg9jjCgZKX9pxuJT5/EcVAwxK4LjMSeO+EH3S+uVthSEway5b3
 2I7yWvsp2kQ1sHSd0H2e0NsT0B6BjFS96+3a0+hxxotjK4lPxrF6mGsL8vJCGBALwafvPAWELTc
 2AWzG9sj/Vko6hwVB3d4IuC8sVEOC9MuelFOpEEpMhA4DBeYr0ZvAuhy+m2nRPOonlCEPA49J6X
 28VXyjGKmsoRDQVKjKLVXAfP7FxxFMQzAVn9ity+KKoaIFSbGry+6G9WCviwZKYwM+Er6cL5wN7
 q0tNk9quY1sx4FLSmfHk9d+FAcXIurzupoKkiGDIAb7iDG944lziVKuBJuOlHCyUzQftAgZZaKw
 TDjWJ134Zwp34dkDT3g==
X-Authority-Analysis: v=2.4 cv=cK11IVeN c=1 sm=1 tr=0 ts=6ab540c4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Aj8ARz31FktZ6VJZM80A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -upKQelahWpiLYbADJaFoL2t_iGkmRQg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX9Gb7TInHrIUY
 5sQqHzgQwKH0+grpZWxvI4kHDAf1wgn+eQDagBQNlLz6W/QnoEOVgYXUVcKxpHIPF01V0EMO9NC
 VzMDJ9ZPPAOVaSkOIQvgEVL/PL4yAP4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

From: Richard Henderson <richard.henderson@linaro.org>

Split S32MAX, S32MIN to separate functions.
Fixes a bug in that "0" was passed in one of the zero reg cases,
aka NULL, instead of a proper zero constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260914230901.1781309-5-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/mxu_translate.c | 47 +++++++--------------------------
 1 file changed, 9 insertions(+), 38 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 3f8acfcdb8f..4b2c264f031 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2045,45 +2045,14 @@ static void gen_mxu_q16sxxv(DisasContext *ctx, bool right, bool arithmetic)
  *    Update XRa with the minimum of signed 32-bit integers contained
  *    in XRb and XRc.
  */
-static void gen_mxu_S32MAX_S32MIN(DisasContext *ctx)
+static void gen_mxu_S32MAX(DisasContext *ctx)
 {
-    uint32_t pad, opc, XRc, XRb, XRa;
+    gen_mxu_logic(ctx, tcg_gen_smax_i32);
+}
 
-    pad = extract32(ctx->opcode, 21, 5);
-    opc = extract32(ctx->opcode, 18, 3);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely((XRb == 0) || (XRc == 0))) {
-        /* exactly one operand is zero register - find which one is not...*/
-        uint32_t XRx = XRb ? XRb : XRc;
-        /* ...and do max/min operation with one operand 0 */
-        if (opc == OPC_MXU_S32MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
-        } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRx - 1], 0);
-        }
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same -> just set destination to one of them */
-        tcg_gen_mov_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1]);
-    } else {
-        /* the most general case */
-        if (opc == OPC_MXU_S32MAX) {
-            tcg_gen_smax_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
-                                               mxu_gpr[XRc - 1]);
-        } else {
-            tcg_gen_smin_i32(mxu_gpr[XRa - 1], mxu_gpr[XRb - 1],
-                                               mxu_gpr[XRc - 1]);
-        }
-    }
+static void gen_mxu_S32MIN(DisasContext *ctx)
+{
+    gen_mxu_logic(ctx, tcg_gen_smin_i32);
 }
 
 /*
@@ -4328,8 +4297,10 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
 
     switch (opcode) {
     case OPC_MXU_S32MAX:
+        gen_mxu_S32MAX(ctx);
+        break;
     case OPC_MXU_S32MIN:
-        gen_mxu_S32MAX_S32MIN(ctx);
+        gen_mxu_S32MIN(ctx);
         break;
     case OPC_MXU_D16MAX:
     case OPC_MXU_D16MIN:
-- 
2.53.0


