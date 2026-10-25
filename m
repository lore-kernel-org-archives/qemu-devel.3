Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DD606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=htA+oMxm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaa-0000r7-5i; Sun, 25 Oct 2026 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZX-0006Mw-AK
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZU-000458-UZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so960875e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912990; x=1793517790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eu5Zfk2Ai4cBtOs8m7ff/026LCycTm9zQct9/PQjuM8=;
 b=htA+oMxm4nbhVmiReAzigcZRqlmO9tZWLELIsPfOz5JsdVx8t4TXN6G1sjmlt29pzt
 fVTUEza7V/+DmHOX2aoIRIwW8ZbsOelflN5khIZNKJtDN2xdme1mBQqJ6l1AwtBhZOwS
 CmJUB4kYBsCrOV5PeuSdQjyz1e9MWwyI6fripYPKw4qdZiXjmI6ohDYKwHLf8qHg2bxB
 cqWQNXG8qTfb6CstwVeEsaPy4HGh1VZqE//5GqC6gQ2cgJCKBAmlhhvedBoD9LCp+S5Q
 TCHDdS/GViM4hUJM74rAD5NeX1uN47N2G+n1cwrzPseHR//e9WTlWKv/3wMBYn9cKVO6
 nA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912990; x=1793517790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Eu5Zfk2Ai4cBtOs8m7ff/026LCycTm9zQct9/PQjuM8=;
 b=P7aboHCtbvQ5wnS+2XPinh08OoLS6TZD/Hk1oO2rVK03nk8reEPmUyBhgutXF+G1LL
 bT7yk4LzhaiLqfyj9ZGlUg1K+eACNuXQfjajCQ9Lt5Ok9QB+KMFSJK3lQfqd+Rkc5sRh
 PyZolOcNe+HypT5JqwMGmtnqXh28W9DHL25SJdto+bSTIxs+DRCHxpRDdCEh64ZPNfBt
 QiN/w0BfpiIOvbkf0KM6gR8xVijIFYtc6Y0sF5PrKpveF/9O4EkhwPb8viy2tJEn4nLQ
 7e8QJeh3HHNUA65vD217JkKhXtcaSoRd/EF9c9hHdcEHuHerB6UxVtKbDQ0zBIPd9ccA
 eQhg==
X-Gm-Message-State: AFq9FYK19SHNn0kgAk7jkWYiQGOcysWj1ZHoa7HZAFCJCUfXlaykh7ZV
 eyFQtR6xG6+1OYDmoUENSgp6tb/ee6lUv6IhrRU6n8jfio8GoYsFrKa1P4jiKxBdYi9Z5i701Zc
 fHf2EKT0=
X-Gm-Gg: AYBFou23mOakY3e7IZckx/TPzsKAPRoF2XGp3vsfYJzPIRdvsrM+ZXvj7qKnHln3DNt
 +Rq/Fgn2Kxbmak8lCwC4ucwmvjNj8yyp6+ShZgKLc7pQ6fn3xRJhQlBijlkv2X988qyT8OQYpBl
 MkLngpAD+V25iOFuOt1MB0lVLJEvHJwAEEmKj5PldyTRqCYQaelO2gZVLx4g70ALEUF8UZdlW5x
 8tPv28kepJq8mroJ+UjNSwCqxSnWtBVYko+vQKbM4lE6fF9sjzfgMKY59GMPkLaNFAE6vb706lB
 XC4YlD9Qb+mwY3BTTzU4+KQc+5w5emyaz7p4R4VF2i024qwrTz1BN5EtUYaI7O678bZZ5gYWQq3
 7lvaKIE6X5QuxTW05Pcg8ZiRb/Bt0HWaguoddyDOZGxH7UesBOccTN3gmAHbblc62sbbLQRpSZN
 kvGVeXJfV5FSBxsyjxzk9H58hBF2voAS/YuZfgEumpSNqYYaViXNs04zTTNy/A40g+CKGJ9aAUQ
 OljsWlhoMjA23lmmafxzLCMa0jDNTMO+KIVNBFKNSWMNem71AKIHTXw/ss=
X-Received: by 2002:a05:600c:83c7:b0:4a1:fae2:a8ab with SMTP id
 5b1f17b1804b1-4a35ac39cedmr58263455e9.3.1792912990196; 
 Sun, 25 Oct 2026 00:23:10 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 049/100] tcg: Convert ext/trunc from TCGv_ptr to the new
 interfaces
Date: Sun, 25 Oct 2026 08:18:24 +0100
Message-ID: <20261025071915.1123867-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

Drop the casting and ifdefs, relying on the host being 64-bit.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 40 ++++---------------------------------
 tcg/tcg-op.c                | 20 +++++++++++++++++++
 2 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9988e9f66b..0ad0301e17 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -470,42 +470,10 @@ QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
 QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
 QEMU_ARG_NONNULL void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
                                           intptr_t b, TCGLabel *label);
-
-static inline void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_mov_i32((NAT)r, a);
-#else
-    tcg_gen_ext_i32_i64((NAT)r, a);
-#endif
-}
-
-static inline void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_extrl_i64_i32((NAT)r, a);
-#else
-    tcg_gen_mov_i64((NAT)r, a);
-#endif
-}
-
-static inline void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_extu_i32_i64(r, (NAT)a);
-#else
-    tcg_gen_mov_i64(r, (NAT)a);
-#endif
-}
-
-static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_mov_i32(r, (NAT)a);
-#else
-    tcg_gen_extrl_i64_i32(r, (NAT)a);
-#endif
-}
+QEMU_ARG_NONNULL void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
+QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
+QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
 #undef PTR
 #undef NAT
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 86f0c68c94..75bc8a6a91 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2391,6 +2391,16 @@ void tcg_gen_discard_ptr(TCGv_ptr s)
     tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
 }
 
+void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
+{
+    tcg_gen_exts(tcgv_ptr_temp(r), tcgv_i32_temp(a));
+}
+
+void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a)
+{
+    tcg_gen_mov(TCG_TYPE_I64, tcgv_i64_temp(r), tcgv_ptr_temp(a));
+}
+
 void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(d), tcgv_ptr_temp(s));
@@ -2400,3 +2410,13 @@ void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
 {
     tcg_gen_movi(TCG_TYPE_PTR, tcgv_ptr_temp(d), s);
 }
+
+void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
+{
+    tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_i64_temp(a));
+}
+
+void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
+{
+    tcg_gen_extrl(tcgv_i32_temp(r), tcgv_ptr_temp(a));
+}
-- 
2.53.0


