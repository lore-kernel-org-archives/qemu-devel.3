Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9932F606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V/dT3woA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAx-0007sm-Lk; Wed, 21 Oct 2026 10:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9u-0005Er-DN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9r-0001hl-9U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:14 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso6563155e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592350; x=1793197150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jw6sQoihZOtz/xv5w1NsCDb1RL1ogrllZSAMvz8ySzc=;
 b=V/dT3woAocBNAfQJCUTO3y1snflMJ8rEKPzivjUjX+bjcvFZGaCfWaqmDCx9fCOaJZ
 isXqAwTKMcAfgH6i+7gScMyFKy/KvBFsWena2/3lc9QUFOLiOmPNXtXoSxx3ydn7VqJ7
 VSEpgBlZ8VS/5sTlmvAAM+rdvUM2F4kxMebPJs1+Zd3xbpKR3Mvt7Jo+SUIRtPFi9sej
 bCYl+zbD7/dsmuAGSCXY6bO74N7x8oaaZiKro0zg6nwb3PbPZTR88ppU+x5FqNuRBXWy
 GKqthS92LTr0QRswEujHWmtIHNDDeZY9x8mYG0FLYX/oMXkDuSeZYrd24VWgRyBBpXV/
 /n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592350; x=1793197150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jw6sQoihZOtz/xv5w1NsCDb1RL1ogrllZSAMvz8ySzc=;
 b=Eu0h7NJWUheCLVAiqJVtZZmdkrXInx/1aBmvZhm5IR6aQ3wdY0YeoACVA42iiryxc/
 2raeMSiVaDLJa7Dhj7Hmi64DvZLylxvzKgdk6AtACh/rhi3uZqzi2bBHB7ylP/GJq+Qs
 BHLWNfwwXpVCH25EG+R8GjvpyaWcaxg4APY6QgNdY1/Y/UyNsSJXBw/fEwHuV/PaCwro
 d6xPgF9OL6+tjly4yj/GU5q2uS1KpOpKczWuCG0xdi3e5pk0rSTtBtzpVW2PRqLlxHB9
 I3IxhRqZJPe0yA9ADGr6YdTpkPOG4l2g8bf4l/0QqNT+2HhfHCXqz4yQ+okNHj9CLTud
 Lrig==
X-Gm-Message-State: AFq9FYKtizkPyUS7iL3mlNQ54Mk0VttcPeRaDpbXJdwWKUQYBhrhOWxd
 /KPaIJj/u8Qqx2IVJ5zTx83JagY8pRscFsCmn0ebX8Jve5NU73qv1Iq37JU/eQ9SIcF0+EVaZez
 xB/JFD3U=
X-Gm-Gg: AYBFou2rEsD05H7BManS6aZm+TRfXePuJFCDiW/AoO1Mmibn4ylVnWcwPDsRqnIAxsc
 sezoMWHWZINRt/+Elw2xXq5JmcptB+5CQR0EG3Uj82fwYPEawGGesxO1FV0YwjNKuQX/1vDbbWj
 PtAkV1apsBwP4qetuUv49l/V94xDS4Sw0WiVkPQXhPRLpMN/L6o6YqDI8y0JZTcSRNim/1wRqNS
 st1bxONb79wUrGGpzU8MvhV9C0ITvRIXTipObc0QirX7rwaMxMuoT1JCyVIa56o2P3cy+2kIKYN
 /e8+SKPTVHAtJR+n9elVUsswzWdV/KIKEPlGDssjRoWAyunnnH5sTA0NpQu3rxh3Qmj4Q86BYwM
 /YiC/x0B9bkrkjaw31ap8YuslCZ6pZjEGum2x/E1KuS7TpxM/vJXu38a6HF7foKkZmmu9kEwKgv
 STGvlf9ZH79mKT7s0dIl/Yylkoa0ry8mDsBl/HDoBA7zyC4GQt4+0hrGYppKL9o5LmrCql8tMjX
 0v/jqvY84NTSP8EpweH6NKo4hrERqS6bpbWkn0K85Pjtd615HX0UWv5bVKlzLR0JW2RavqlH5JX
 I2I/dz/IDDav4e7jirPBKq1Icwc=
X-Received: by 2002:a05:600c:19ca:b0:4a1:7c56:d4e2 with SMTP id
 5b1f17b1804b1-4a1fdb0175emr44551195e9.16.1792592349717; 
 Wed, 21 Oct 2026 07:19:09 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:19:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 034/100] tcg: Generic expansion of tcg_gen_divu_*
Date: Wed, 21 Oct 2026 16:15:46 +0200
Message-ID: <20261021141652.363109-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++------------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index eb090984e9..9024963c06 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 50d725b72c..1b108d9f14 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
+DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e194c33eb7..1bfefb9d65 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -425,6 +425,20 @@ void tcg_gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1,
+                         tcg_constant_internal(type, 0), src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -643,20 +657,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1537,20 +1537,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


