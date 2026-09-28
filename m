Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65800CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB9i0-0000VI-L8; Mon, 28 Sep 2026 07:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9hx-0000Ux-Cy
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:39:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB9hv-0002as-KB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 07:39:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBAZFA558813
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=6zVNozNz8iJp1i5wyVDWRo
 ZW/sPZnSiCc/ft7uWvadA=; b=NFAmsWBNQZTFAJ1lTVcqYEZq+0TQxOSO49HYU1
 vV0GyiPMeRKydZcuZRGZiY2Rfw4olPAKCeIhAh14hjKFEwfunTai/rCUCQz76KqT
 W05cfGowXDaW0Xw0PPLs4/NS2/fb4Ztj72k3TAxa0nGLmLcG9kp/k0TxlzRrYo+J
 W3l4vg5UmiPBn2tSCBSpu312tTRMQZBC/HOywC6BA54dLrSiGUBTADoc07Vark7Y
 IQyAjykl4+6WxuBtzTUB+7jAxWWBl5aDWO/A0/V1VHcrKxQVzTVgy3XapzOozZjh
 0fhDZi3KZ19Le6seFPvf2rm/OUJkSDr6yTXrmOA7yXIadmmw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1x8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:39:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0312937eso393728785a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790595580; x=1791200380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6zVNozNz8iJp1i5wyVDWRoZW/sPZnSiCc/ft7uWvadA=;
 b=fxi3ItCDeJHhIC7sinHf3S7Aincofj8IfBv0I6KMVG0tbT5jvykdKZwDBbSetRpb0F
 qSMTnQcx/M+ETfJp3/GoLooSmAnZKzU1XrU+PERgilwZHx13IYYAKIyovKlXZVqhy49b
 Li8gx1HpqUN8nqt3Df4+q720cV36dlk7wWncUJs/Pm/Dtks9o6bbavAkd8OpBfnLKhde
 6/G+foZlB36VM6huv1hawrRBQtCPK7w5U5nQF0KLXsAUr35DYff5Oe2aszSGqm13otUJ
 13Kns4wXw2tp+bbFgQXPyhcOpsEtievVGtSqngKzb04PazNwDNsE+XwEVcx76YSOSX+m
 du+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790595580; x=1791200380;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6zVNozNz8iJp1i5wyVDWRoZW/sPZnSiCc/ft7uWvadA=;
 b=Uo2VCkJBFTFOk1ACuhgtotZ2/e7EMx67+MIdEbeOnQM1sJAg9AorgSk2wm4IUMUngh
 EUgSmtRFI1kegZA31ePR+dfN6+AsIFrfLRmSOTQtRFs2OJLlQR5s7vG6M5L9hOGZrtQx
 YYTBeTHNfalWqqPzpUbfYlGoMqu83m/4qmlPNyPdaKlbo9gmhSai+LDzaiYboMjgKeDX
 Mhg69cP1Jc25PMWzaazwOpbShU++P/Tlkmt6FW8OkqropkTz6Xs7DDLf1ThvzJBCRnot
 3N0sdq/sKnEkpDx1KsmxS1T7MVZwcRPtd5ogjEAjxRakaGyo/Gpr2mvrJDuA9gEJcBtx
 6MtQ==
X-Gm-Message-State: AFuF++m+05B8T3hwKz/JseQy16Qa18xuSi4H4XP2QYk4TSPV/StvKCE4
 bmaCdk/z7ieNP7S6sZ6T9r41En+vRgLvbchISEvbFyuGSF6RPRPqGTO5H9cl7YX0FfmPycmx6C9
 N06bgfj2O5DT+dcq8WwyQQGdsGOWN17/q36+AT5jm3vfxTydn6ZPHAts1gyLNr1ALbg==
X-Gm-Gg: AYBFou0s/P70FIyRIk6+9NQ9OS/U9MQU1uBPzx0wGlgyhqZBUC/vBQQz+LxYwu09lBJ
 QMTc5pHbXYi2fKhKjvs9+b2SJTUNSw5NOiGVEvKlnHJ0COHmCVpodBZ7eobOIYJxmJGG7v2FBef
 hsX4lXG7uX0A46dMvJzitv8z8G61Dz+hBdOIUwkrWzxVQjGe4vd09bymGuRsX9hkvQzU74D8yQp
 9t+3U7WHn7bqIlmZ8xlU1D1g4ED6nj/QRSFisHXAtpbqZ5g26XzmttB/rQlam4yCHlhUfth7jS3
 oZF0kwRXvlNetfR1+jyizeVKCUS7PN8K6Ic7maG1Zp1t6hB6z+XQwMoXnl6AofBFnH46OjVJ5Hg
 jwvr6LrMJDWMiYGENlPfizlHahY+i5qZMT9Uu++9y
X-Received: by 2002:a05:620a:2546:b0:939:fc18:4233 with SMTP id
 af79cd13be357-93c43bcb3camr1862389585a.20.1790595580484; 
 Mon, 28 Sep 2026 04:39:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2546:b0:939:fc18:4233 with SMTP id
 af79cd13be357-93c43bcb3camr1862385785a.20.1790595580029; 
 Mon, 28 Sep 2026 04:39:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a3625ccsm28683101f8f.22.2026.09.28.04.39.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:39:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] tcg: Introduce tcg_type_bits() helper
Date: Mon, 28 Sep 2026 13:39:38 +0200
Message-ID: <20260928113938.3157-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hX5fJxdDO4AABfm1WHEVB5suwLReoObX
X-Proofpoint-GUID: hX5fJxdDO4AABfm1WHEVB5suwLReoObX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX122HLwUojtQn
 uAcDxScXZCBVNH0ahsvxMHgot7mNBafzMkV4lWqNIgdo24xj4h39aQ1w88vg9kXDJJHnyBRurXp
 7IBMUK/qV0NTlqyBDK3OSD2slDMUQsQ=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba51fd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KBNY4ihKIwJDS_tnwfcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX2skbPUlu4f63
 05XypnBZxbehCr8RqvrEOqThqWdcYv7isopWzEJ1IXlvLsQNUg2b5ecsXkbLA1mVDLCBy97yo1q
 73bX30kdP5jjGy4CYtNrlE2S87R8Aidh/oc8YJhXkfC1UIvXLGR3T9aY66UKA55MdDQ1Gms866L
 vr6LoLPQXA7+zpRPZnJAEoWA59KgAuydARmQDV5HVFgO/s+mMqJnElbgDvq6CViwhdi3SA6eyRH
 INV2IlJXLGMlKkfWLDVNeN2PEBO+eziCSqz61rqC0bfBkBhW4kA/FfnJnKHISNZXB3RuRUblq1Z
 r3hyzq2HYCi8zeJiGluQO2CrgHETNVWxCP0r/9qFyOdMKD7EM3XEHea7yFm0gNUNXYDNi09JGWu
 AyPGFWYYozMbKeD3j0hT+9jDhPJk58OFLFJ2gLRFQk+aUEbqvWFpnD5QI2I/G4WU3l72Eqcjkz9
 wLmbP1qw2Sv2VVPc0MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046
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

Add a helper function for computing the width (in bits)
of a type. Use when appropriate.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/tcg/tcg.h | 11 +++++++++++
 tcg/optimize.c    |  4 ++--
 tcg/tcg.c         |  4 ++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 7669dc1c2db..2e005189344 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -164,6 +164,17 @@ static inline int tcg_type_size(TCGType t)
     return 4 << i;
 }
 
+/**
+ * tcg_type_bits
+ * @t: type
+ *
+ * Return the size of the type in bits.
+ */
+static inline int tcg_type_bits(TCGType t)
+{
+    return 8 * tcg_type_size(t);
+}
+
 typedef tcg_target_ulong TCGArg;
 
 /* Define type and accessor macros for TCG variables.
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1e4d2a0a425..22e3c62ddf4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1704,7 +1704,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
                                           ti_const_val(t2)));
     }
 
-    width = 8 * tcg_type_size(ctx->type);
+    width = tcg_type_bits(ctx->type);
     type_mask = MAKE_64BIT_MASK(0, width);
     len_mask = MAKE_64BIT_MASK(0, len);
 
@@ -2279,7 +2279,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
                 op->args[0] = rh;
                 op->args[1] = rl;
                 op->args[2] =
-                    arg_new_constant(ctx, tcg_type_size(ctx->type) * 8 - 1);
+                    arg_new_constant(ctx, tcg_type_bits(ctx->type) - 1);
                 return fold_shift(ctx, op);
             default:
                 break;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ecc1f54c1bf..65d3190a8ed 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2883,11 +2883,11 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             if (def->flags & TCG_OPF_INT) {
                 col += ne_fprintf(f, " %s_i%d ",
                                   def->name,
-                                  8 * tcg_type_size(TCGOP_TYPE(op)));
+                                  tcg_type_bits(TCGOP_TYPE(op)));
             } else if (def->flags & TCG_OPF_VECTOR) {
                 col += ne_fprintf(f, "%s v%d,e%d,",
                                   def->name,
-                                  8 * tcg_type_size(TCGOP_TYPE(op)),
+                                  tcg_type_bits(TCGOP_TYPE(op)),
                                   8 << TCGOP_VECE(op));
             } else {
                 col += ne_fprintf(f, " %s ", def->name);
-- 
2.53.0


