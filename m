Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F18606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A5WUvcLy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAK-0006Pw-EE; Wed, 21 Oct 2026 10:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX99-0004l3-Cb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:34 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX96-0001aM-LI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:27 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso6554625e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592301; x=1793197101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zQKu1NO+QgLktFz2RVzpoGM10WTW7fjwHAnB5y4H4VE=;
 b=A5WUvcLyJKYS11d9FbzGgd78XfukYIS5+RkvuXATs9XsLpZQGV0mSaHIp217IRa5CQ
 BLmz+0YgmXMu7NP3M4CABl5IoZEMAuNnfPcPZP9QJyELufEyZT6+Tz0ehDcXzToFZz+F
 WTV2RoFzQt5u9FiWvhcKULvedXR+IooyrWUzT/aLVerMaJP90AogYPAZ87OXocGo+8VS
 UsyFGArFE7WalNe0dOwDR9y0YCB6cYLjsHTjXD0vyScTCGVKxFS/4CMfegp4psC4j30T
 45VhZjNOBDuWygA5P3rZCOe+Y3H1R5Rik3GTzO7QtS7vMcw1TVBtIb/0ZJqfYC4wD2Ms
 Kmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592301; x=1793197101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zQKu1NO+QgLktFz2RVzpoGM10WTW7fjwHAnB5y4H4VE=;
 b=KMDNPippRKgitdVAvvyKoh+gPxofdDmNWgEDJZXFvsSUEBNnteRK0J/4ZNcO1+wB+b
 nEWhYQg7W9/LlN4rZr5pnOctUPGp99fp3/6BOUl4Nc1OD8Fv+VdGFeZawJbUD1zFUVHy
 uIu7Y0uAkFIS7b4HQkIPCgEAgbq/PcGpO5ZMu3ulebc6cAYCP2NSjJSkZ02odG63cF39
 5/yupi5p4q/BwQAcaZlygolFupg59lrtjWHpoeHB3G8TuR8DfMNKGwUSUrtoRq0416i1
 vbh72V6Tre6H5to8Kvd+8ljRwFJ2TRRXmcDVlPlfFNyYZ2rlPkbS43h4tPWIuzTiUvba
 5Tow==
X-Gm-Message-State: AFq9FYI3q4Jh0ADLMf58uT4ApELQcAXW5vkkLiVePmRdUz9vB+i6gxYd
 cG4t0rZ4DDYTpAGPhwu5tix55UFg1sAN6wKsRjDmhyeAg5StVGRiGaJynC37b1CRR5ihAS91x6+
 eoHyLJ9I=
X-Gm-Gg: AYBFou1uWT6AnjgHpJehjIsrHZ+x99eIlYc6EydZh0aWMJRDmGAU0YTFRnLN91PIvfC
 Y/fPUTkp7LsUwd99F2ot1/6ie6Axa6CJrkMfeMQszHyH5EE4a2AkXjZbxhO4a3PV/vyO/x0m8k9
 nDKObS5NgEeZK1yx4nWr2r5dnQkGKwmrr8YEkGEzcKFRQLX5iPzuDIfvChMAHv2s2yaCeue3v6P
 T/SurFHyLF30FG4kHhvDAqc/3gQ0jFKTmY5dc30oq58LSBm0gHscBA0OYdTGQ17Rbra8TSYmJcs
 faqFMgTneFMnbBzeySl4DSmpY+Q0EvO4lPnsZ7AbHCpXKj4+1Yt8hIeDt4PziLsTxhEtPdzd3dV
 epsaY2VXw1c6mjVP7XFHEKMO2bERhO89vpZtcMbrP1ZHdeNkiYhScWeIqnwGqIYCZ1+lAHL496/
 Qq9KERKaxoqrb9su8XpEM7Sg1lo0cRyWo69ryJSPAqvNcnYBGJKeUZqaCQxxNkUlu4lqZN6tLpy
 iR2al/ZYrlY7+YIdcKiPUmH4D5QBtX81fb/6meIUe1i1qAmKkNsCYbqisFhcQpTnWDTjG4k9h3H
 N58zUmUzK6ZU59EqxaCb3PshK4lr
X-Received: by 2002:a05:600c:6085:b0:4a1:d0e4:2bc7 with SMTP id
 5b1f17b1804b1-4a1fdafd610mr47035655e9.15.1792592300948; 
 Wed, 21 Oct 2026 07:18:20 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 023/100] tcg: Generic expansion of tcg_gen_shli_*
Date: Wed, 21 Oct 2026 16:15:35 +0200
Message-ID: <20261021141652.363109-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 76e67acab8..dec1bb522c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -217,7 +216,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c1273a1019..c47de1a3a4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,6 +12,7 @@ DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1e85ff545b..8fcbbef694 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -424,6 +424,16 @@ void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+void tcg_gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_bits(type));
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -520,16 +530,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


