Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B33F60A2617
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GBmuRPFJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXA1-000593-Eh; Wed, 21 Oct 2026 10:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8z-0004aX-Eq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX8x-0001ZS-M1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so5621835e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592294; x=1793197094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pqe082yqK3dwygn1oQWompPuhJ6wJwhCa34BKmjxGh8=;
 b=GBmuRPFJcnHrxa6n2l1V7VhTyznKrLCpvCM/PVxqEp5ZHHFR8r4npt7B546KX/ngJJ
 F2fHvy7QAVQIOMRvKNGslhyIjvdzwtrXwZFtkOXF5pJFKn+v92HCBQQqyJj3tgSyy8lY
 QU7JDMrlRS4tcZfMCpDioCdGaJc+CYC9V0Z6+Bf3mVqjtdFyLu4ZA9tg/vavXxGSiV0L
 D/JfGoGxp4bg5P9eTXBxZJ0tqldUwn8mtMlfixkzn3NjbPdZw2zpX9PQe1cbYvEXSUbc
 OuZIngOzJDaj0Qw0fQzhryUQWOjBNiXNH/XYZTsqo3L61F4hnlljXl6d/fxXPVOgPzOn
 xcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592294; x=1793197094;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pqe082yqK3dwygn1oQWompPuhJ6wJwhCa34BKmjxGh8=;
 b=tUyPMWcyKDzJaUXg+7UYST+wkQ4mBMxCPi017bv1rRuKf5kSBp/jUxk/OBxtUdxrzr
 APlum3RiMcE4WpSiTczQDBkK4t2hjx2hn1+2NGFoP8qGLohBTm3EVSS6vlQ79pyRM68T
 +Rp8UppO71/ObHz3ckLEYGf6PK32NmC/nyw6+l0fhecARNtCsgCt/ljR89hIomux8eW1
 +Eom8dFcrUoQXJWyY3j/ssb69Zw/3oTulAE6N8EmlJ859RNC8fcSJW2OkTUdZN9VS0bV
 nhppgfmVhLKvBp07dy5NlpH1NhV/q7GvSbC6V9OQqsO+Sy72xjRlP2ArkXmjCLMSK6x0
 iHkg==
X-Gm-Message-State: AFq9FYI0Z37wRqr7cyNZJi1BTCpvvPJIE2nCWTNnGHIVpb7iClSgSbW/
 MV8sVYwoLCUf6ztH1M6X8ysGm9QMYCZkiwExmVfhS0CPP/f18ihc+tQpIu91jbNmTwlI929LgF9
 fp1NoEQw=
X-Gm-Gg: AYBFou0kVJw0iu4N2ybTjENKC8X+UsRMGBcNOuOsNkkKr37suiKf89tsTEscd6nJEX6
 6KfAqTi1J0MRi9uvyOzoJmNRGQILegHxP6cUF2khYe6nDtwaTcWmeHHLueoZfu+bh7BDlt+idLk
 lzK0ffT+SrJlKnlBzQTLImUr1dwxYRTnl4BUyRoXP/MG5aaI7VWVCskDBLLSE2iZ3l0VdGMe1Nk
 RCOpBOO46b9V09LGeSdZYZbtVhv+Y0IWo0JmlZrZilWrSurc8rG5cwjofGaLqRp5Jsq+atDRiqm
 WVJfpIbvWGOdD5tH646v7zhTyBxTY8UPCjxNKNtgBZKHYVytB4hgJJFS+g9gGfMqQLv143OKdKE
 EijCqZkzE/hiIgJXb0qdBnILjrqnd2irtA6FsTW9aR3Kdzzfyu787tQYpQZ8Oa6bwqQm+skpyPo
 gUzvvF2jkmtCCyQUH8HKVj93+SGhecQfV9787/ew+02CtJwEFRkiC4bB/PKH22+/PqFyig3NNDx
 kpKz05SNYX+A7O3eV3hcEr1jj4w6sDP5TT0ChwEFBKbx9X6+sYasZ9Yq2A4MBMTSK/P/D6tOuXC
 OZ9qVKQJTYQQ+oV4S6OyvWxEswY=
X-Received: by 2002:a05:600c:1f95:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a1fdd109camr47295915e9.28.1792592293234; 
 Wed, 21 Oct 2026 07:18:13 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 020/100] tcg: Generic expansion of tcg_gen_shr_*
Date: Wed, 21 Oct 2026 16:15:32 +0200
Message-ID: <20261021141652.363109-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1c59b1915..96d351e634 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -313,7 +312,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3e6dd1eaf9..573a4963b4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7cbfcad24a..3c98d204d4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -414,6 +414,11 @@ void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -515,11 +520,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-- 
2.53.0


