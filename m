Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4A9CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfD-0007Vh-PT; Tue, 29 Sep 2026 06:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf8-0007Jh-RV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:15 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf6-0008DX-SN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:14 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso2493006f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676131; x=1791280931; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OkgR0nNVqI/NhoMD0P8fGxh7YRGqcS+MvpIfreUNiG8=;
 b=ayJxjvh8BurPEuh6PczFUPQYkka9f3cUc+KLNXTakV7l0aSiszDwPqNQ9wK24zUlZE
 EU8o+JYKS9ZfjQDZUiVvov0y/S1wRdccrEL/3p/Zf3q0e/WQhUNV4gX50CkjxtWlpNoD
 xxtptQ5eT9k+1+pSacSNu0IrkPy9qKEcT2ElWIYI8t1uHb5kLmFq3EazBNQb38qV4wPi
 3xy7GI0ASl0BKyx0qSrZeYOYTWkMsz9rTyWwZgwi3PnoBc00sPK8P2m9MG9XdCeR29S3
 890HknixmWQ+xnnlKPQGJCZlfbkZPqTGrpx38493NIqKJF+AIaJVoMj28HJIiFFtUbpi
 Cfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676131; x=1791280931;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OkgR0nNVqI/NhoMD0P8fGxh7YRGqcS+MvpIfreUNiG8=;
 b=UftbJe6Mp7HIjLgaEJuSnP56dnOLpiAJkEFYdPyfX8r3E9zCxmNq8FylSFLXdmg654
 XvEZvwf8ML7XTy1rvHqDeUoTgeDAmHvmaIJxxWHJxRSquB4XGATbQKjCdK662l7N+ocG
 rbJxXLvsyVseQpdxmGGXmsjTPrMggpbWmVpSQ/UPyi5clk6xMtLtGE8TyaR0IXI56JEY
 4j3m22KmS4pYYm7XZTyR67VQlVBEmb+tr5kTkxyC4rvonRFMbHcPh6wf1D6ZAyycQVpp
 80ebGroaEYFSWQCHV8zaJ7DBd/iT7YIS0B0OFN2BqHnP+eprmziluJmJ++T1X89o/Zqe
 K/hg==
X-Gm-Message-State: AFq9FYJbqLO3ztBpK/7FzU7Q+r8gBVbGWyQUrCNowMeEQRP9fBTp97XN
 CPen4kqun4MYvdFbrovyjAvn/bQzirjwV5ks113dQaRahJ49uYofOG7L5ocmjjQtBFCgb6PD5ns
 GsnTz
X-Gm-Gg: AYBFou1GeJ8QIwddz/jfJGOPFb6CIHs6mpfmEJrZSZNycEsdq2BkiOk4LP9whrjAG+H
 EcMELFTRFcI4SMzAofdNy+dGTONrV94id5zDumkKTm9krD05hYT9l4iuSAcXYzrnsrDsBeOonl4
 3OZ0KyOiEC6hT3ZUP2l5g+rnA4TaQZrq2XIsLNtRD4Wq8mCWhB4Yevi1u7JAliv3xEFg0AmZwvS
 HKuKI9irKJVJvQrgO46sles7x3/tmcdACDETkdvryYj6Gv9nELj9uFpqV4OL96imJYEtlJcJu1m
 LhP3kovplGWGH30vYEmpNMrpTFsiRRW4V1jqhUo9PXYBgCNE5hqElAnSLFplQncp0oNq43U8CPU
 haKinbxAqvprDDgJt1BpQ14kx3xJffn3Dx6uTLAHC+PPHslPtKkUPHDYqz24inciXFYnmEgXaTo
 CCXp7ZiR9XgmJg2Q3baeY3iVAyw0DaobOH3LMshrDkA5aTjWj5VL5l2sZLX5qPKBfPFGyUAP+MC
 aYhqKMDTmLe1It9rFoWKYQZ4sd6eOXDSzrvRy+nLLl/Pk3NeUnl78z5PTfskxRH4So09EQt2Jkn
 PlrT
X-Received: by 2002:a05:6000:258a:b0:487:1266:62f0 with SMTP id
 ffacd0b85a97d-4887db39bb9mr22604850f8f.40.1790676131071; 
 Tue, 29 Sep 2026 03:02:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/37] target/arm: Parenthesize tbflags arguments in TBFLAG
 macros
Date: Tue, 29 Sep 2026 11:01:17 +0100
Message-ID: <20260929100133.2598676-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 418fe78809f..4785c9c57af 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2606,21 +2606,21 @@ FIELD(TBFLAG_A64, MTX, 49, 2)
  * word either is or might be 32 bits only.
  */
 #define DP_TBFLAG_ANY(DST, WHICH, VAL) \
-    (DST.flags = FIELD_DP32(DST.flags, TBFLAG_ANY, WHICH, VAL))
+    ((DST).flags = FIELD_DP32((DST).flags, TBFLAG_ANY, WHICH, VAL))
 #define DP_TBFLAG_A64(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP64(DST.flags2, TBFLAG_A64, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP64((DST).flags2, TBFLAG_A64, WHICH, VAL))
 #define DP_TBFLAG_A32(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_A32, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP32((DST).flags2, TBFLAG_A32, WHICH, VAL))
 #define DP_TBFLAG_M32(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_M32, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP32((DST).flags2, TBFLAG_M32, WHICH, VAL))
 #define DP_TBFLAG_AM32(DST, WHICH, VAL) \
-    (DST.flags2 = FIELD_DP32(DST.flags2, TBFLAG_AM32, WHICH, VAL))
+    ((DST).flags2 = FIELD_DP32((DST).flags2, TBFLAG_AM32, WHICH, VAL))
 
-#define EX_TBFLAG_ANY(IN, WHICH)   FIELD_EX32(IN.flags, TBFLAG_ANY, WHICH)
-#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX64(IN.flags2, TBFLAG_A64, WHICH)
-#define EX_TBFLAG_A32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_A32, WHICH)
-#define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32(IN.flags2, TBFLAG_M32, WHICH)
-#define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32(IN.flags2, TBFLAG_AM32, WHICH)
+#define EX_TBFLAG_ANY(IN, WHICH)   FIELD_EX32((IN).flags, TBFLAG_ANY, WHICH)
+#define EX_TBFLAG_A64(IN, WHICH)   FIELD_EX64((IN).flags2, TBFLAG_A64, WHICH)
+#define EX_TBFLAG_A32(IN, WHICH)   FIELD_EX32((IN).flags2, TBFLAG_A32, WHICH)
+#define EX_TBFLAG_M32(IN, WHICH)   FIELD_EX32((IN).flags2, TBFLAG_M32, WHICH)
+#define EX_TBFLAG_AM32(IN, WHICH)  FIELD_EX32((IN).flags2, TBFLAG_AM32, WHICH)
 
 /**
  * sve_vq
-- 
2.43.0


