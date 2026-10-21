Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86986606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FRgMHxCR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXE3-0002kX-VB; Wed, 21 Oct 2026 10:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDU-0001kl-PU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0002CM-5D
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so5297585e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592571; x=1793197371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oMhi9eVDUK39v132tqU7f994F+QypLajLDWBn6pr3/8=;
 b=FRgMHxCR4o8iZQx5tOL/kJxzuDf50A1Y7S5tKWqOGWLRkuOqxnocpAANbLfsA/6udV
 7Qxp3wDuu8g4yZWf5wWySkr/Ui/r6ITTQmrVLqN1bkHo0k9Oj4aqBhN9lXjAMeCgxiiY
 8MRKs4Z4JBjNOoBWFdnaR0IYZaCa4pfbZZ/hCAzOI4N3JvkBYQcuBCRVLsGceqJmz8yI
 oKd6BfRrglHEyPVJtdIYP9Ub5F7YAKajfguwJHDIhe/GsCKj8MX2Y+c/VN9Isn07Qifh
 sTqrLi3sRl4LUz1D6+YRgF5AKUJ/mwvMEsN64kQK7xiPGc5vUCSShA2G83b8znIITwA4
 ulwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592571; x=1793197371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oMhi9eVDUK39v132tqU7f994F+QypLajLDWBn6pr3/8=;
 b=p3SKVGNSHcnQhFbcD6DvI+n4xplZk+tzQXPGI1BSfN9mAHEu1iah+ktFFI2eBuLY8/
 vRY64RN4gK2rja7l+y6b+1oMwswk1s1oqVQV4jvMQgFMGv6caMMr9/aRLaNH7kn3cOZ/
 NAdxyMqt6ENjF+3McB7WMzpe4HSzf+oj0maBRC720plOqs+9Y9I26WWjzQeE09upFiFV
 AzNyg354TTZ+grDpzy8X2dBQ7yOvNu7gGP+BYG68lTdHH++TP/jyf2wrGjgizyfvH1Ya
 ftBCbD6CKqs2RdMtWA31f4tAgSV7vL0AO5ut5Ei/Mngrkt88vt/Ym1hzbNNvqaB/CBzS
 FBfg==
X-Gm-Message-State: AFq9FYJU5PZYmy7wrI24hB9sQvqeyxaVO6TOtqDIZblKhbmYfHXNb0Jj
 VbTfd99ZQSZzaYGl1cwcvE7Eimr6LO+RJwJp36K0vLEEaYeLtrrtSAI7bk68/WFrBLAQxsDfkCJ
 LdzucIbU=
X-Gm-Gg: AYBFou2RpyNV+L8U/cEuYqmmW6dRn+OswF/8Mrxz5s5JNSGSkMc3M+vrojC5GLBkqoA
 R2u7H1Z2ufa7HemEmp6GC4+qKxlgBfii4WGlQeQcUPK38NY7CsYSkAE52d64R2txYIR9rkSXIar
 9r6SxLaykc2wX5LmwqbvaM/ik04Qq03YixsIVEE1xOjqa9yJ7hQ5rbsNs/v9BjU28Fh3WJl5Irs
 S5Ep5c0zmOtdDqDLKaC5rXmhB7uwnLJAb7+bDEhHqLho831I06UXACUFVVjj+dwHYjcL3BdluFA
 xKIfWAzBdUrerSvfSm0TYVst79Bs15j/mw7usDXDwqLYrGsz5LEEtHJ+Ry6mNf7WLRIDNOG4tZL
 Gn37oDjAUhbNfv0NJiL8OE0XJ6taQ39Jx+tmCuK1iSKyG+zHvYIPxtHb9YrweWsBBav2+2MSJFH
 W4v5roCZFXiOUBD8Gj0Jw++NoWXwNVpBm8zSpe/GwnqpxRTejqXltCoLCVKVstpg6Qg64Y7kN5+
 MUGbNJiGsLEhoUW0dPzYffStM0EDnDzUX1/idaRBj4KfK2A8wEOeKQ4OAISEgBF9prcRcm2HaJp
 bf52rjLXn5pUwjkyS40sUNP4tMo=
X-Received: by 2002:a05:600d:848c:10b0:49e:795e:ba89 with SMTP id
 5b1f17b1804b1-4a1f51a50e8mr100745595e9.6.1792592571559; 
 Wed, 21 Oct 2026 07:22:51 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 073/100] tcg: Generic expansion of tcg_gen_umax_*
Date: Wed, 21 Oct 2026 16:16:25 +0200
Message-ID: <20261021141652.363109-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e23f247b90..4a79e3e1f6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -186,7 +185,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d1035a8c8..3c93c20704 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -60,6 +60,7 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7a5e992557..a288c14813 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1050,6 +1050,15 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1356,15 +1365,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -1869,15 +1869,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


