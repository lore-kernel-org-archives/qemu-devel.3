Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B5BCD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXz-0000M3-P3; Wed, 10 Jun 2026 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXs-00088y-DW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXq-0005ah-AG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso5456945f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107965; x=1781712765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2x25ZWjIELcsSEd0ptqxdzALncLgcmwdwaJarOGjONw=;
 b=IWYY2AR9VDAHwAiEke2hZhy61p2N19D4rwR39g5y7cqVjr9pc8z8RwCtMEvEKbLcxf
 3Y4OC/WSGoihVo1s+oKoJp9N04NgabkDasLO1ipz+cA4FD82QLKXGx66DS85cFDuyccA
 rXqeR4gXNqaehpnF9NQ7HmhaCFWrw9GToqzfDvFIX1F0FWf9A+AOywbfUL5BcJQI++Rd
 /g1LfleY9X5Ys0tnFrsO/0UUw2/uT5gE5/LrT2Rj8ZhIFxL8FOOqOUiAK3oO0P0Jo0W4
 YDMnShM66wpLEFknw4/AUoT2fUzzHrPj/0J0IQjddWCjUYNSFs2oKzYWD7LXVGmlHqyH
 DNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107965; x=1781712765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2x25ZWjIELcsSEd0ptqxdzALncLgcmwdwaJarOGjONw=;
 b=nVqSTLe0bRoRdV7MmRjLc2YZ4TXnoiDnp7BapccTApz13KGNDkWzhT69z9Duw4YKfn
 FYHKmkO5S9TBcr+EzHb6nzQe3rgF5BQrJKIrD7vlMeYp8XNpoa5l7g04JMr9VvK+ddhU
 fiPEwGG6wCVEdVAc0EAgMfbIu6+60J9qSaRCeN/FsuL+dms8sPkC1n9eT01pmLx+bWmt
 2oBGDmo6bvjsdgtnDfrEmRWVNR/a20NgGWHdzcMGG7J8vPswpzspNG0dnV/4SEnps7Fn
 eoWsRXa4JBWVYw482vAEsgikYb/8javx0khgTn21BIX1xQsTwC4jJQk2w/bHyuJqyDjh
 fwhA==
X-Gm-Message-State: AOJu0YwV1OGgV7seC8vpKPtX3tnXvBlLEUadrTeivDiyg6yvnM26X4QO
 U9Z0CCUUqfSRuUPtknc0bHZczjdFmAG9HiStG/2/tYK6vMTnSzhhZvpm3utCF5kceVNxbUEzlLe
 AULTc
X-Gm-Gg: Acq92OFoBCCOmUzbUIx++uc5FxcFXhLoGPQDOAUoxHUH4iW8q3clVtaxptyl3u3unQJ
 R1strkS8xsI9ubEQi6Rw37gYDedbuGYRnFrQfopYL/BzMKUBIf5sUi9hD4ScxF7cOhJvLetRt93
 ZeLOw4JuP4bjObprUEe/WuRv81Gel2CNrTQztW9cf1V1lCAkH7fhVunnXdkrl7NRapot1hYPTgR
 Sc4u0HcArnJDgMzZvkC8zfZYYfcf7UvO0YBH5FJVIwNfMmn03aghGjombF7JRww4YLL6tOsFR1e
 RWl9iTL+5bpbJrR5PPKZgKYmq6fS5SdI0LbehX4zFz1nRF2JIS9taNfKaOJ2ArLvkB+8RfGb7lF
 jr3VqcNF+aHEvsqZnuBZLdgeowpf5Y4+umNw3t+xZqbiqriIEzbxH+v+bulgtHke9l5+yc0kV3V
 9xVtV5TUtlzplBSCGd+/ziAlDXiAmerE76m1Zwv8i3d0lFAq7/4+PVjUjOQsspHYmYvqMHnlCuf
 zYBuzozwvfy9MnmgLsOvXAe6t8drQ+AQvP/ttQx9QE=
X-Received: by 2002:adf:e906:0:b0:44f:da08:18f2 with SMTP id
 ffacd0b85a97d-46030507507mr29862131f8f.12.1781107964875; 
 Wed, 10 Jun 2026 09:12:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/71] target/arm: Generalize TRANS_FEAT_STREAMING_SME2
Date: Wed, 10 Jun 2026 17:11:21 +0100
Message-ID: <20260610161202.2235298-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename to TRANS_FEAT_STREAMING_IF and add a new parameter.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 12 ++++++------
 target/arm/tcg/translate.h     |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index fb9d379184..997d6b0451 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4261,9 +4261,9 @@ static gen_helper_gvec_4_ptr * const sve2_famax_zpzz_fns[4] = {
     gen_helper_sve2_famax_s,
     gen_helper_sve2_famax_d
 };
-TRANS_FEAT_STREAMING_SME2(FAMAX, aa64_sme2_or_sve2_faminmax,
-                          gen_gvec_fpst_arg_zpzz,
-                          sve2_famax_zpzz_fns[a->esz], a)
+TRANS_FEAT_STREAMING_IF(FAMAX, aa64_sme2_or_sve2_faminmax, aa64_sme2,
+                        gen_gvec_fpst_arg_zpzz,
+                        sve2_famax_zpzz_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve2_famin_zpzz_fns[4] = {
     NULL,
@@ -4271,9 +4271,9 @@ static gen_helper_gvec_4_ptr * const sve2_famin_zpzz_fns[4] = {
     gen_helper_sve2_famin_s,
     gen_helper_sve2_famin_d
 };
-TRANS_FEAT_STREAMING_SME2(FAMIN, aa64_sme2_or_sve2_faminmax,
-                          gen_gvec_fpst_arg_zpzz,
-                          sve2_famin_zpzz_fns[a->esz], a)
+TRANS_FEAT_STREAMING_IF(FAMIN, aa64_sme2_or_sve2_faminmax, aa64_sme2,
+                        gen_gvec_fpst_arg_zpzz,
+                        sve2_famin_zpzz_fns[a->esz], a)
 
 typedef void gen_helper_sve_fp2scalar(TCGv_ptr, TCGv_ptr, TCGv_ptr,
                                       TCGv_i64, TCGv_ptr, TCGv_i32);
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 37a7268b32..ae3897b456 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -880,12 +880,12 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
 
 /*
  * For SVE insns which are only valid in Streaming SVE mode when
- * SME2 is implemented
+ * FEAT_STREAM is implemented.
  */
-#define TRANS_FEAT_STREAMING_SME2(NAME, FEAT, FUNC, ...)          \
+#define TRANS_FEAT_STREAMING_IF(NAME, FEAT, FEAT_STREAM, FUNC, ...) \
     static bool trans_##NAME(DisasContext *s, arg_##NAME *a)      \
     {                                                             \
-        s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);      \
+        s->is_nonstreaming = !dc_isar_feature(FEAT_STREAM, s);    \
         return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
     }
 
-- 
2.43.0


