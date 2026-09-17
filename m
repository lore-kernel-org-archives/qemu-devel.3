Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5C1C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qv-0003hf-QU; Thu, 17 Sep 2026 00:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qo-0003I0-Ih
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:58 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qm-0007vK-LV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:58 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so345113a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619755; x=1790224555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I2ZPCLfkHtElcRmELbIyv4yFp8iiCx0qQXQzu2SEUDg=;
 b=vBy3qYaC4YgqGtpnDXF3FBv1GWeKYag9Ix1VwtxS8+BOb47YhV7jJ/DpoBwgU4t7c3
 ZPZeBlhbH8MvibT+lhXpTS40ekD09IOtB7+jeYXRAgbPesSRcnpaOu8TV76k3Nw0fwkZ
 0rAgeJgnSYSkDzz/mOewx0ukAg+7v6JJLpcnXvir5WeSOWHHDj8n803SWcHZE7xKXam7
 GFKYotG5siw2z6hi5s2XcPcg10doeKnXD2ECs4bLV4km1zd4LldDK9wLeFbOZf97geeA
 PZV78NMKDjMI9lJ6XXZp1yv0Ufqrq6r1p6zKZ2LWUTrMmPKvq7CFG2H0wViDDFymaZYd
 KLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619755; x=1790224555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I2ZPCLfkHtElcRmELbIyv4yFp8iiCx0qQXQzu2SEUDg=;
 b=cU5n2YDUcFF04MV09lliZE+az8uOmoFWRkKVuqMjNdw8xsF0MBOkgdi6BvsVn+N1BM
 qxoR5wcDFNIR7A+JjeVZplVpqEoNeTtI2eQgH7BNKPMpsDW7Bd/hp/HzPMeGYe+Ud3ov
 avb+PPoy/ZivzxvbNFmEXgZBn+hFGAU6y07x/lb11CDVZMv9HPyE32dmoIO2OxQx/uuj
 6No269DKUtucCaLW8vLQnN930woe8mw7eF9jlb4EXUW0BrW8JsLdVr9GKjnbCPtqQ//T
 d2pYRM+Cidd1Ul+ChqmwYPSwomPwpFoFPlhq2L49bfB9V/aVSd1BZJ2wPMs/O8R4KZGj
 Y1qg==
X-Gm-Message-State: AFuF++l2iUmJjbAOjEqRdsDkjhdY+7HSqRwmylfIuXDYcAkfdMo7Medt
 exz+rkTQoOLViIQpaK9CHfbuOohCWucf2YX0TxIDcs0CKQO7fx3flZqwdbAG4tA16SgC46VCGOI
 e5hiB
X-Gm-Gg: AYBFou3K4QipX/zBcxaDVW/u64EoZK1kFtgYbLuYRA2UINXR/DaQHUgQ+DzyLXVv/Se
 v3zk9sUzNOy8JfFqHitXYioaHKlncgQG789dylid9A7cSAoMsmgu1wTldU5H/qQ+nFPMCxDQWit
 LXzDCcVGPjFvDtv8p92pzy8Yr/m2fxetaeknnUOecnxJObS2SF+Etu6lJ0fRfUiQhuLK4xTr+wY
 PbAwr9DojIyRSCX9aJaRjPEYzup8yQ2McAR62x+81k+Mgat9wEZxU90A+LWeyptedDCRRDfLldY
 x3eT+COR21XQSuaJKLwZHewVkOKymttNQ0jNqjgwTZMtJNTDKo8q1+caDO6ulSnOMpugbgUQtDs
 hlhSbq/QbNegpZyISDVZJUI8lUiZKKKEHQs3PZWyKfCKOtYwkMnzukSaelpDXUR91fO0o8+vf93
 YoGWqNva6J7WLyqnT30zmyhGYmgkAo7FRjLCo3Cut36voFKtMjpKFWszaB/lml7FqqyMmxdu5C7
 hWEWW+R
X-Received: by 2002:a17:90b:1e0c:b0:39d:fd21:75cf with SMTP id
 98e67ed59e1d1-39e3615cb5amr3347305a91.26.1789619754901; 
 Wed, 16 Sep 2026 21:35:54 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 084/101] tcg: Generic expansion of tcg_gen_sub2_*
Date: Wed, 16 Sep 2026 18:28:06 -1000
Message-ID: <20260917042823.542588-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d6e185580c5..1e5282af98d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -158,8 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f42aeb7d8f5..5a472a910c6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -62,6 +62,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aa8c3f4b0d2..4559af91358 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1206,6 +1206,25 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
+static void gen_sub2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_subbi, type, 0)) {
+        gen_op_ttt(INDEX_op_subbo, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_subbi, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        gen_sub(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, al, bl);
+        gen_sub(type, rh, ah, bh);
+        gen_sub(type, rh, rh, t1);
+    }
+    gen_mov(type, rl, t0);
+}
+
 static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
     if (src1 == 0) {
@@ -1270,28 +1289,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_sub_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i32(rh, ah, bh);
-        tcg_gen_sub_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
@@ -1799,29 +1796,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_sub_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i64(rh, ah, bh);
-        tcg_gen_sub_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


