Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JkLJesvn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGO-0005iX-Mq; Wed, 21 Oct 2026 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDU-0001iZ-Fc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDQ-0002CA-5q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso8020085e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592571; x=1793197371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w5Q90+aBY3ox7yEdVq6EvvJIm99D/EJUYNJKb1nEfhY=;
 b=JkLJesvnecYSDTIEslfkwQwm3X481EXIb5OgKxBUQr7QM6tqAQsQ/+I5ty5eRHE6xm
 hZGYe77WK5Ep+XjzESXXuxF+oub5IspSwsmcJXfijaMW0mvHkhBby69GLATsRFPVyw0U
 QCahoxIUcrrDrta9W/s9ePy572OBkdz5gOfscKTJ1d3R7CFEE87rwhyvt2swwl6C2Ub4
 CBp+1TVr1M8CQok1UN/0z2w7hsGEkiyKRVUv3pIaoWmnGp/1suMUJqQfe7pk9gVGp6kb
 EnaTjNUi3mZe8Gs0Fxln2gelOYJ1h1Bt4cObgyKDjT5aP8d8kcTqoCoDErtS0XFbeMx/
 mdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592571; x=1793197371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w5Q90+aBY3ox7yEdVq6EvvJIm99D/EJUYNJKb1nEfhY=;
 b=vnsEa0DgD6jXLshaUB2an0XqFgxCoJEBKWbgabBBmQtwrlHnMFJ0JycwrEOBrBx7ia
 ZI9GGGAThXMXgKR28/YRCun5CbTQ3ua5juFmJ8+Lqj/d9yf5kl7xWH9H5+CWE+ViHj37
 PETSfFnKukK6N59h+diwHhOVArBnUdUbSXkvtNsK+riYdk4dz21BO0TRa9gm5JWgWa5o
 NP9N4CKFYOmgCYAaVeANcdqkjfWC9Og6Be4neFIQrH4brhlJ1QKdnz+SoVjN32iQv7oy
 0cL5WMZ7if+aJn8TvZ2jNi0Wq2AGwMiJXguTSxiXFb2uCGZem8mjpg0bQVb43xktIiQ5
 vNog==
X-Gm-Message-State: AFq9FYKDcNCXTrh+xlqIXwKxZqVGeXcgPXCOtGjIke53iMeYMV2oUrWF
 bkPS1efU7xe9k0rySjLkC3y8Z48k/ZEdIZMjGaCL//nwrLA3O+DQUDHLSuaOwHqX13It5HqkKwC
 6UCiFqVY=
X-Gm-Gg: AYBFou3Vde+L7jw/eNhmfysDXOVKqS/g05Q9NjNeo5iwW1ZNs8hT7cwo7MiIDHvEiDE
 bjas2P9GQ2QFh70VwkNU4xxLwvcXwxBp6+RjKJitKuNSAdndJK1va4yMf1yvWvizoCnv0DqKWLV
 m+u5zzPDQ+LWgO6RW2U+05YVubzfs/aN49O9oyyBaP/Y4e0RyMvSbayXQSUwQpkH6uidh4COGpE
 hJQZjciJ98zpaHnawx4x+bOIqEM1XA2RQMBGLFM7IHZW/9UkLU536gpXWMKK2oGLiZ6eSv2cmBw
 gHHdKe6vCgBXaWwg/82HPpd4tgoCj4Ggw3r9YEdFAHfMoSLKoxFQZD02TqDfMkoR9MRF0eLF02d
 +9wUCYfi6xPg55EEzKVspL8IKrR2RosCmnoJD8qULgBSUVdwjeuTbUk3Ph1u758aGFpJGEPqQcn
 +H0Vevq3j2q3avyY4LCNnnCm0uhoJDO9oBNZkLIt/jTp/350OixaYHkJu6fINr+OptnWEuza5Hw
 oNEU/N+prvIbmwMb9cMt/1PYpK4RUoE+PKrUgg0IGCbjA5QHn3cXtZzMZd8EIDcUkc6CBmFo42X
 00j52hTC8Xm9d/tx4OaxrgMci4mG
X-Received: by 2002:a05:600c:4e44:b0:4a1:d7c3:d3d with SMTP id
 5b1f17b1804b1-4a1fdb1ac65mr45567625e9.10.1792592570586; 
 Wed, 21 Oct 2026 07:22:50 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 072/100] tcg: Generic expansion of tcg_gen_umin_*
Date: Wed, 21 Oct 2026 16:16:24 +0200
Message-ID: <20261021141652.363109-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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
index 7214846b81..e23f247b90 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
@@ -187,7 +186,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index de3feeabdb..7d1035a8c8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -60,5 +60,6 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c97b0ad64a..7a5e992557 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1050,6 +1050,15 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umin, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_umin, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1347,15 +1356,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1869,15 +1869,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


