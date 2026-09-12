Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C11C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5L-0002OP-94; Sat, 12 Sep 2026 06:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4x-0008UC-0Z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4t-0008M8-0A
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:26 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2dcff8f44f2so26042835ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209321; x=1789814121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AKIjnJh4OS0o2r8BfuNc3nL07d0J+MaEN1OKj1bS2iw=;
 b=Pl6dBoFf/b4UbZb9DTQuG7B073tYc6i9Uz+OV2aWhc7EfWUfs265B607EiGPuXx9i4
 QYyg76kgzyqZpNH6Gh/ZZ8WzfdlECBQnv05GkjbBZFYmcYIpye0L/8pyTAWAqehIdvDm
 TmStNpB1qnPMFPGoRPaqGreoaXurNW//U+ikPb+5QDBWiXKs53h2Kwwwf9C0KOKKjqPK
 35bAxco6ITwBZnj3fvnWLXXiHHBF4xjtRxr/ETsLAYonzYpiEwHa4vdzJDe8rcy4Fyri
 kBQYFoYzuFTBWLXh7wWjq4P8KMYOLKXDirxdiWvpvtL7rKYAGdUtlETvvV9c953fKPt4
 0CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209321; x=1789814121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AKIjnJh4OS0o2r8BfuNc3nL07d0J+MaEN1OKj1bS2iw=;
 b=kawQs1mfByVUpnYKzqp18So7b58ioiGtcNl0gU12SjgmTAoEW1V8H+paXpBvH8ueG+
 U74JDB5mzIx/c1stDbxOKMP2+8vVkEM9xlDFUlkhUnqCT1Z+klUGUjwwdsuNohoOcvDM
 l3JHvjbxH145S+vPq37ecMtdFr2AEZLRYCbskt9mVCPGJnUYuemEheoJyHtz/fsbpZ/W
 iZiRvdI7aW6FEsiejm7bvbJEfJ5R+CE3BJAR69me3UP02ujK4X6GZrk37cI0FFRnrdAF
 cp9S0jvTGe0d9V9ICHHz/lbOGsDjiUnu7qkr+qFunnbxsoNiPNySuHEO+tJ0dr32oqcN
 7qog==
X-Gm-Message-State: AFuF++nWPrhdp8WFZykxcoP6MzaLMPwDh1gAr2tkTRD/WcRo2gxrlk78
 zBH6I78p/WIFSJOEPJKVhv3zL0aNTL/1Y0iQgn6UWX1Myn8Sl/+wDsRby1eVLoq4Q76udbfjB3u
 6QVQPxy0=
X-Gm-Gg: AYBFou1OlEB4LWSPsrtQreu+Z/kmkKCchku+JkfdFakIoE/brzkUAdM/BOzu/cm8acS
 GOYf6dlCBMnF0XeDrN6PDsX/jAAnqYtfL0J6o+WAqp27HWlaEe3GTQrZyEFvxXJjpIIKSGFtR0T
 T+8HfyhJxdvf3bcLjfRCVdJokJlA6MEeoDASjP7jR3m19hKHBcr7O3sb5NUWrVDgFYJlM6TM1pN
 3s1Q2Kcie2MMdfdLsDWEpwyMN/N1UdGkA0Ots88BpOTE8P5GbrVNKowl+nQEUDh+fx1tNActA22
 k5Le6uCwXi3rgrcCzFDE69OBLy2SG+z25b3jOZm+lOs2kZ4G3NkrLxVHD/qrXDxCHvwzMPkKMlW
 FbJXVPgs4UznhQPKFTnUxz/7DpNCKPfJ9Q3rh5k0tdpks3j/5cxHteF/J7PuszWiiJg8iRUCCbi
 /LHcu2p55UX+k30GSkgEago3eCTa0F43QIaJUlU3i0Kb0ysn4d5N0tjmDlNfGSR6eAhTX9DJSuJ
 XOeZoZ02jFjsWcPGQ==
X-Received: by 2002:a17:903:2f05:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2dd2a3368f2mr147266245ad.10.1789209321344; 
 Sat, 12 Sep 2026 03:35:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/82] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Sat, 12 Sep 2026 00:30:58 -1000
Message-ID: <20260912103126.598030-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 46 ++++++++++++++---------------------
 3 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b5271751994..cdaa805c47b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 209bb57b968..0f370e4e04b 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -10,6 +10,7 @@ DEF_CRRRRR(movcond)
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RIR(subfi)
+DEF_RR(clrsb)
 DEF_RR(ctpop)
 DEF_RR(mov)
 DEF_RR(neg)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3a61cfbc3bd..549d257de8b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -451,6 +451,24 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, t, src, width - 1);
+        gen_xor(type, t, t, src);
+        gen_clzi(type, t, t, width);
+        gen_addi(type, dst, t, -1);
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -954,20 +972,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1799,20 +1803,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


