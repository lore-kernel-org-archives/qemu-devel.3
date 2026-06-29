Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37647C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg7-00075W-Vl; Mon, 29 Jun 2026 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfK-0006pZ-Eo
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfI-0007J1-IJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so2283305f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734438; x=1783339238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zzb+ngrcMV7t/VoMg3XUGX/7GW0Bksnjz6fJmHX6u5A=;
 b=xNU9WwcUQfjKJ+/+DgsQb5sZ5OAHlU0GPVbB31+Rxf6Fvyhu21pdQyR5Mx0UVaz11n
 MNM2kmEqpnQecJ3XDdPywpjTxRFFYJmp7XgbOTkueOMt4fhK7FTSPO64HAPnywFddV20
 fHkaEZM4bKUX/b6xhNfW2VV+A8IBjiDDNa1tkjsR22GoW46QJPSB9l/McSKYbWWqheHT
 ejTYFgqxtHPAbUkuXGQxZfOqKV8drgwgimzWb3uJS32ehzsZ2F3fuIqM88Xwcs4PPGAY
 qErQFnIqvQpGVrea6FpwP9ohmVAjhJNN3OvREO75iGSE/PkgWR4GSA47HjvusebN7hBy
 arCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734438; x=1783339238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zzb+ngrcMV7t/VoMg3XUGX/7GW0Bksnjz6fJmHX6u5A=;
 b=JbLY0N04ll3r/QFuBfnjfqV3yFIU7DcBR6cUY5zK4q59yzW9ZyRwnu9JHXqyyUNs9I
 eZOvGasahqAzhprLUNdOCzaonbhJUB5qHiUUOhlk0TbVGPyx6wgC0akNN5T6N8Q1Hifz
 1l6A8tfOSv+JRvrq4PlEQdKahNix1Q+8lxIHQqeowzy/2VLB26iZFTtX9FGJIupu8b0S
 M3gD6bRyBK9ZEeM0aLlAfW1BvlT9B5pi77toMIU/Ac1UBfQ3DdDloX3QeDeWLEqHtxhL
 KqqOoqukWgPivT4oMXyVsU2xX5k3/8ux2jlUgLv8rOdclDnyozHJFdRcHc4iyCs9ycro
 5ZuA==
X-Gm-Message-State: AOJu0YwWtEcuHcQeBj1lCrXFJhhgRbgc2WeiZUsO2WZY0622QkeKuxAG
 WKaJlJ+CrTh3fnSmSh5Cx1NQaQ3YO8BWPA/w9C4IyrvowmmeuCII/uPO/uTiZPc22tSReIF7uXA
 sDljM
X-Gm-Gg: AfdE7cm3gECk7HQJllrHkoNXwyo6XyqQUx/gJXCRBs6fbZQirXsxRHa7GuzoZRzfce3
 nVAN7Gv8GlucLxLpBWmvFa9i+Q7GIDWD3s96dqd2y1Rp86Vo5ClIGCwBzzVWSXcSV33OcTHM8s5
 7fTsk4tQbu81vtGkoHskJKMJmHVMFEYDciFblr38uf7h1mrH1Q+3gnnw5xBj6nv2Kgb/PDuK3Ei
 rPYBXZjJ/r/TYB6K1PWksAiGFB0lrI1BoExUohpo31yH2kMqTAmHrztxCbq9bhpSFDq1DblxQl0
 8SeQFWutiqZb1MWpDkzFOrtR1G18viiakaFSkXIieO7BrTJmu+jhgV0TinZ3jvWSE6iJVXqU48p
 l+bT96xm4AZMULMHivJAY9n3x9yzli4izFicyVwknZtaKAzGBAEVfg+WZ+WD29QUYoAPwtA2K7J
 BqUTDRah3yCrkfey/nyDa+nvR5HO99kKET2RjqzYo3TaztSevNd4+DgAUFv14F5TcRD2u1Fy9kf
 A/A50RXQDJQ8u/Cmm+6tQ==
X-Received: by 2002:a05:6000:4701:b0:470:2fb1:3db5 with SMTP id
 ffacd0b85a97d-4702fb13deemr13679573f8f.30.1782734437842; 
 Mon, 29 Jun 2026 05:00:37 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/54] target/arm: Implement EXPAND
Date: Mon, 29 Jun 2026 12:59:41 +0100
Message-ID: <20260629120032.1645265-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260618040718.572950-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve-defs.h |  5 +++++
 target/arm/tcg/sve.decode        |  2 ++
 target/arm/tcg/sve_helper.c      | 26 ++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  7 +++++++
 4 files changed, 40 insertions(+)

diff --git a/target/arm/tcg/helper-sve-defs.h b/target/arm/tcg/helper-sve-defs.h
index de2254bb19..1d9066dcbb 100644
--- a/target/arm/tcg/helper-sve-defs.h
+++ b/target/arm/tcg/helper-sve-defs.h
@@ -3203,3 +3203,8 @@ DEF_HELPER_FLAGS_6(sve2_famin_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve2_famin_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_4(sve_expand_b, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_expand_h, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_expand_s, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_expand_d, TCG_CALL_NO_WG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2795c2ec7f..5ec1d420c2 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -742,6 +742,8 @@ SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 # SVE2 vector splice (predicated, constructive)
 SPLICE_sve2     00000101 .. 101 101 100 ... ..... .....         @rd_pg_rn
 
+EXPAND          00000101 .. 110 001 100 ... ..... .....         @rd_pg_rn
+
 ### SVE Select Vectors Group
 
 # SVE select vector elements (predicated)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a0a189eb1e..2517362189 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3671,6 +3671,32 @@ void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
     }
 }
 
+#define DO_EXPAND(NAME, TYPE, H)                                      \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)        \
+{                                                                     \
+    intptr_t oprsz = simd_oprsz(desc);                                \
+    ARMVectorReg tmp_n = *(ARMVectorReg *)vn;                         \
+    for (intptr_t i = 0, j = 0; i < oprsz; ) {                        \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
+        do {                                                          \
+            TYPE nn = 0;                                              \
+            if (pg & 1) {                                             \
+                nn = *(TYPE *)((void *)&tmp_n + H(j));                \
+                j += sizeof(TYPE);                                    \
+            }                                                         \
+            *(TYPE *)(vd + H(i)) = nn;                                \
+            i += sizeof(TYPE);                                        \
+            pg >>= sizeof(TYPE);                                      \
+        } while (i & 15);                                             \
+    }                                                                 \
+}
+
+DO_EXPAND(sve_expand_b, uint8_t, H1)
+DO_EXPAND(sve_expand_h, uint16_t, H1_2)
+DO_EXPAND(sve_expand_s, uint32_t, H1_4)
+DO_EXPAND(sve_expand_d, uint64_t, H1_8)
+
+#undef DO_EXPAND
 /* Similar to the ARM LastActiveElement pseudocode function, except the
  * result is multiplied by the element size.  This includes the not found
  * indication; e.g. not found for esz=3 is -8.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9a72e03513..57c21a13e8 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6956,6 +6956,13 @@ static gen_helper_gvec_3 * const sqneg_fns[4] = {
 TRANS_FEAT(SQNEG_m, aa64_sme_or_sve2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 0)
 TRANS_FEAT(SQNEG_z, aa64_sme2p2_or_sve2p2, gen_gvec_ool_arg_zpz, sqneg_fns[a->esz], a, 1)
 
+static gen_helper_gvec_3 * const expand_fns[4] = {
+    gen_helper_sve_expand_b, gen_helper_sve_expand_h,
+    gen_helper_sve_expand_s, gen_helper_sve_expand_d,
+};
+TRANS_FEAT_STREAMING_IF(EXPAND, aa64_sme2p2_or_sve2p2, aa64_sme2p2,
+                        gen_gvec_ool_arg_zpz, expand_fns[a->esz], a, 0)
+
 DO_ZPZZ(SQSHL, aa64_sme_or_sve2, sve2_sqshl)
 DO_ZPZZ(SQRSHL, aa64_sme_or_sve2, sve2_sqrshl)
 DO_ZPZZ(SRSHL, aa64_sme_or_sve2, sve2_srshl)
-- 
2.43.0


