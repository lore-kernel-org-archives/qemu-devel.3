Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E97606A33B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tWlLMrWL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDd-0001qg-0M; Wed, 21 Oct 2026 10:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD6-0001V0-4D
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD3-00028S-Ta
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-487049569b6so548129f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592548; x=1793197348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IjSaCTvqb6dQZALcoVAL/4hMYAAGMEbBuzq5yQHhTvk=;
 b=tWlLMrWLyhfJZ+JUoKFVP5j5DmFLJqH3FK2cWhXd8x5Rp6LzJkxuhHKSOKS/wcU7Ge
 TfYQ/ekLoAZj8AcNc0mIX78sRDDojUANWnKg9/pk7pip4Hli3wc9f6BR1p/xLja+NmqZ
 PEa7Qhh9RJEH820Zvj4ZeIW5UKvQ32Jzpgi22c9LWaPCYR7xId9oIGgZYWiiS9IVG2mu
 HQOurXSAyvG4y0K8mbMQvPCJ7+Od9OTPIiR8l9QIIioMeVmTHiWA5DfNFXpN4HMfvT40
 cxSJRdPBA5/x9uTtQziAo7JxsCYz6RyWvVaKflot04DFfw5lPNu748K3uYygl9KHri7X
 zVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592548; x=1793197348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IjSaCTvqb6dQZALcoVAL/4hMYAAGMEbBuzq5yQHhTvk=;
 b=v3Ui+nSRp9wnYeqg+A2lWqULI8rMlNhfFXI3bVjH2EtYXYDqTRY81eZDyX+0SNie6i
 CHcQcNBevClgeWd+ZP4au1/vY1yxUlamvNHYCEhJx4/dZqESm8tsWw1va4s+OOteoE2U
 471N5UQX/WGuqFwTf2dllzIOqshmi6qCqwnMstPOg1L+PlkM6qXy2qGl32o/Op9ecNCK
 pwUC3aLupZWTB8DC1LL95tsRe8fCLQjijS4ghZSDtWwlp1pOrYywW0T7Hw/FEcYq50Uv
 LnWq9XQ0XA5rU82DnfAUwuQ8J61B5QdCgdbzyurX8FtDZUyaGtlqk/Z2wPZOaxD1+3xt
 zU9w==
X-Gm-Message-State: AFq9FYIhMwT+Ks5r2AAYYF7Omr7zxiIZ4ya6EV75EZT0J+OMHzhoWt4P
 lLWLNHUA3p9HoD4dUtvrDAvELl/D0ReGXXAEeUxihKuUKIcUpcdQnieZ9oSNmbvzR64hJYTgZFP
 EY+QJO+o=
X-Gm-Gg: AYBFou0wwSxdog+xMcPT8U2/YzK7GuqKVU2hJbFZV2GFTYv0xcYdkVz76QWyT+2Qbdv
 DQpokXyTJsR66fiwOKm8sZpBymkg1aa45CMf7GERKE0jxHVawjqipnxG242kCy5v6nGKvH+tnX1
 SGkfZ6DR5ffZJGe8HSZiyUGanXJoDvzx4eUyNiOBfaKpsWv9yyJDbWDpJSKryDbfRdWQQZbBTPh
 wW9s8kVHj/Q8SohRXCb2WSd2Yf7ghxtNgguxQcTv9ldv0LjClBp4tGjak7uIxVFAu8kMqqdGOtU
 AjtO89PZZ5A0avbyb+mhRVZynt78OdJZopH+g8PEnacBS3zWIn/Nd5g+91xRZe0URNew5q9eXyk
 i4AiJR5+8tleM461IgH+znMtMyUs8GFl6GtVYjnevHsD77ysC86jTxO4U+L3CoCt6zMzuuYBzcs
 6jaXTiMui484ez4gCeE3DgdU7o29eU8vw0H301Qcm+5xvG4v+vg3sm3mODzDHJfWH8DWL0oCDa1
 FfBF0hi+TrunuNQzSFixcuz9jbNGZx1Pj7T5sERmA9ip20EPcHMPEWWEeObPL/Yi7ZCM5n8AivM
 tWgAg6MQ7wZLkD0vBW4aItJaGg4=
X-Received: by 2002:a05:6000:230b:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e264b6937mr4239261f8f.22.1792592548371; 
 Wed, 21 Oct 2026 07:22:28 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 049/100] tcg: Convert ext/trunc from TCGv_ptr to the new
 interfaces
Date: Wed, 21 Oct 2026 16:16:01 +0200
Message-ID: <20261021141652.363109-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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


