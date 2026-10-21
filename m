Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65533606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sXi0WkL9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDx-0002MM-Qm; Wed, 21 Oct 2026 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD6-0001Uz-4P
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD2-000289-R8
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so546374f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592547; x=1793197347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXkrD/oTfzYJlpTyN1F4LWtua1JW46YRejepL+DSTEs=;
 b=sXi0WkL9ridiP7wKP3V3DpdapXxY7zLcxZn9v05bAEViQNA8JJV8Umur/igTxs40CW
 kjaxVYcXtkPwkWL3ACBEuZ0aJ9p3/nBshpQa5wgSNLnsXlqhgUSd36bXoCvM4lob/t4c
 T7zKSLJ1BiEsX7Iz+IlCH6/VntzjiMC84S6WFxrl6yO9Lpj6Dho2871E1/NCDaPpDxKm
 ft793hTtItB7LMh6IoDI2ddEftH1eSKmK6YN4e/6XlVaLvD6Ht2fWiGZuMQ0yPOB/98T
 esT0AHKXeYxmKx7yPu3KbRWo/wEt7RrnPfRTy5zyi0k91RXgdVKy9BHLwERQ0VbFvoTV
 K+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592547; x=1793197347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXkrD/oTfzYJlpTyN1F4LWtua1JW46YRejepL+DSTEs=;
 b=JlRfpU+AHDr3QwtG5nts3RYgeFwc9qdrm+d/awZ6dAtdbTB1FSLJJdpYw8/y9F0X+Y
 WUh7k0aOljgBHdkIohhwr3jUhAl/hhKxsH9Gr/sOxndHCs5jdlSb5sYQvTq1HYsFBq1v
 gH/5ghHOhLnG/zZvULcAnAgKpL5ON7gtoTABArzN4hWPgD+nmJw6RwFzr/thXz6H3gfz
 UAd1s7rGN5MZuOj7/GotOgsLQubs8+ybTtnW40Hxi2BGYE7el+Ynf8/vL5oRouBb3LA1
 ppBgXD9KNEOs2R4yIJRxfRZ7N1vZrsYpR+h8Tw4AHdnOtrLHUPkwm07oEwjJrd84Tk7J
 nkWQ==
X-Gm-Message-State: AFq9FYJLc7uBMaj+FBNtgDxbp58X0nbhADgWR9b4GjErFx8nJrmr/ZW/
 5RYqtlRcMKQnDPYKJ2jwIlO76uZeMqux3Set1CSWksgjWHgnO416vS9pvQf59/sCN5XyBHlYfQh
 /e0aVZb0=
X-Gm-Gg: AYBFou0Mo/Gk9eeg6ltoXO42+AbBpDlU27aarJVri9utugxYWLtae13jLHZsmK5FkpT
 4rXZxJH1I4t+vW+fl1LmPY2upEaoWkpwZwDGOvBkQOlXSXiRoEZmV2DcEswuwQGOF3rJ8PUPy8L
 rJwRGVLNWZS9ifLpxOwWF1Zx30omEX//p74vWBecP2qQm1CvSNE6NmV5ZTkkb/REUr4Y8uZTqN1
 XYTdEyaRfqBDQZLPKr8/lM7zsqp9zcbQgqvo/xAx6+E/EspJh0fQZiTyKLFS0n2A7UETvJf2Adf
 NeFjxRt21Pvxb0v1vB4bSOL62bta6P95hU1v1MBEt9d0kWbDkSbxFK1mJi9aPIwWHX/sIHkvTm6
 qn+mS8UOZhTerQ3SVdgQ2LkiMCzoc4J/e2ZQbfMjh+OnH3117sMqpU8i9FZa0EyFiUkdN/ddljF
 hpOisDr4AB5H6aqfN6jxbLknbyCQgfpWSOcBrPlRC4MimAHrouBSaLeTICnidZ4l/tA6LpVKejA
 df66JPHmWF3f7ge5aPyHmWBgdUp2cm2+V5t5tuXj78ZU9fhJt7QVym9D9laEQ/SoMfpDNe0nR58
 7voKxEAXwAS6dKt80lanVUJGYU4=
X-Received: by 2002:a05:6000:24c8:b0:48a:fd58:a7dc with SMTP id
 ffacd0b85a97d-48e264c992bmr4625213f8f.12.1792592547191; 
 Wed, 21 Oct 2026 07:22:27 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 048/100] tcg: Split out tcg_gen_ext{rl,rh,s,u}
Date: Wed, 21 Oct 2026 16:16:00 +0200
Message-ID: <20261021141652.363109-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

We'll need these for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 20 ++++++++++++++++++++
 tcg/tcg-op.c       | 12 ++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index cd5028104a..a0edf11292 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -183,4 +183,24 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF4
 #undef DEF6
 
+static inline void tcg_gen_extrh(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_extrh_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
+static inline void tcg_gen_extrl(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
+}
+
+static inline void tcg_gen_exts(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_ext_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
+static inline void tcg_gen_extu(TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 #endif /* TCG_INTERNAL_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ed7dd8c7c1..86f0c68c94 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2198,26 +2198,22 @@ void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    tcg_gen_extrl(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 {
-    tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
-                tcgv_i32_arg(ret), tcgv_i64_arg(arg));
+    tcg_gen_extrh(tcgv_i32_temp(ret), tcgv_i64_temp(arg));
 }
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    tcg_gen_extu(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    tcg_gen_exts(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
-- 
2.53.0


