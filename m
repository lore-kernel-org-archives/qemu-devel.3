Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75212606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NfR95WqV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsam-0002RZ-MK; Sun, 25 Oct 2026 03:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZv-0006kF-0w
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZt-0004A2-91
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so19425905e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913015; x=1793517815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T64jPXhZIzuKzc2nyQ+hujquzazr2qdRtZ0NYFO0aV0=;
 b=NfR95WqVRZbonualLN2LHyU6WkRPCwwFHXytWX6Ml1q6LUb1BZ8LcbS7MfDqbz2g7E
 XmEpvoEdX+RWFecBqmz0N3arPznE4BTxT4/onTNPBour4v90fheOs5UcZY0eoEp7YLfz
 SvNw8upvqsYARYcZdazY2SegNcOc5qLbZ0KT9Bi86xBNDStsvC5rdwcj4hf5LE8MeRz/
 7z6+tdJoEkKvs6yq/zk2wIvTaH1UyN9Z1XHDpRUguVAQDAk+EwTygWmWLW0TtFfC+sy7
 QE3oeG3Ehr92/mWFJ5Sh/WjUkWzE0Iqy7NTHoo5VNY1trmPRbSN4lH2j7IkRydytwIKK
 pWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913015; x=1793517815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T64jPXhZIzuKzc2nyQ+hujquzazr2qdRtZ0NYFO0aV0=;
 b=wHHhTMf8pbonXtZgVRTrcX1yj9GmuCZNPe1bVQGEoGiB0etTg3z6Jh46lF1X48W/cO
 O8EEnVdnLlb0Kq4daC+ZF1nd6FxrnT+41xGs6CHA3hkVbc12cUV+nFgMq8c4/qFn/3YL
 zsRPOt9pEqDmUU14icdsU2/TthzPYwQHzPMcoN0Y8EaYCNNxbZFOYMSTLHxG+sUg2erG
 4hHDMVWMk2WUI7h07BWdvZQrti/EnQtpMitetNxLR0XLJ5h0dOUQotS//HqBnh7tzYar
 FuvCAvZb/mcXWdQ27j9k0PAwF9MD50qcgfAYSgS+R27kz9uZjYydjnHZwbJOIwZDIT4l
 8hSA==
X-Gm-Message-State: AFq9FYIiPnT+hcHmdFNW2ctTxKtGiwVRTCkZkna44LkrhWdhEo70wo69
 UiYQWyOZwv2vMrEqfavf9C3bUYpI1pE6AQoqN/IYa05dnuHyKyK49mUhS2cVsRFhznSjTYHHsxt
 +ic6IklA=
X-Gm-Gg: AYBFou2vt+FdDAS1DzFisS2FYut/s75c60wW0BPj+G3KBul2gWaZhXNvVTiLN9utQxq
 KlIRRNHAJMQ1S/zSZoBxARoQWU8YAJlSvDwN3rGjwvDolaTPf4ia/XwYvCxVbY2fe2Uw5e/VtjX
 M0t5BaDYDe79yA8dsLfU9T8HoZtVQDtaOqhNXcxvEJuejh+fSWiP/RG9srcT+i1wxxkcan1gyzn
 eySQEz0kgR2kMPzAuPNbvsu+z+S42/TTPQAsjr88hiOcMfYfDYjGI4Lrfd+MPMqRswC0UNpH2sN
 ddOkxeDR0RqE6qmSbJkedf/mnkGWpqws2GDMJ7+VlQ0oigAL69s/5XIccFFHtGtmVbDKFYztEyX
 do0Jj1ALosivBGmodf2sT3nuWZFGA+4Z5fYAI3r92EfknonyHEpNNyEpvv79is72wE/IiElcdJ2
 /s5ZjBXxKUhx6SCKBDpXGiSrzlAKRnOy1/48xBJTt36VKVNFd3VM+vVr+MOEoffRe7Y2hFojrPW
 t+ebcW+bDw27xknoLjy5anUBBhCw8W3e3tGecJWaWJ2aDQKeo66e/ChlWY=
X-Received: by 2002:a05:600c:3e10:b0:4a1:e01e:1927 with SMTP id
 5b1f17b1804b1-4a35ac8d939mr56396845e9.5.1792913015514; 
 Sun, 25 Oct 2026 00:23:35 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 075/100] tcg: Generic expansion of tcg_gen_ussub_*
Date: Sun, 25 Oct 2026 08:18:50 +0100
Message-ID: <20261025071915.1123867-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9491879685..6942012787 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -184,7 +183,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 19c6347fa7..82dfc90009 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -63,5 +63,6 @@ DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
+DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c1ce4172ef..c5329a8d95 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1082,6 +1082,15 @@ void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    tcg_gen_sub(type, tmp, src1, src2);
+    tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                    tcg_constant_internal(type, 0), tmp);
+}
+
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1379,16 +1388,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-    TCGv_i32 z = tcg_constant_i32(0);
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1873,16 +1872,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-    TCGv_i64 z = tcg_constant_i64(0);
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


