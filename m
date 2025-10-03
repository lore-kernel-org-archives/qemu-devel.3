Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A31CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jH3-0001bz-Lb; Fri, 03 Oct 2025 13:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGy-0001ZK-N5
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:48 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGR-0006Em-Fh
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:48 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so1740317a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511286; x=1760116086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0SrUCjw9dFeMVD8Ylmqi8TNkfgQzS+PP2xkc3/Os+U=;
 b=PsD5L1et9GIebQwTZ2wq4hJZEL1CT4wJ7yClZMiTU8gzPxB0Qz9zd6pJsS8likgdUS
 mBKsBFoGl1YQuPqkbEdyUwsmJsfrY2neXxpQDDzyjHbznnEN4jOrBKydNH3KAXy+s0mF
 33hYR9ktlo0olR8X+0EfhMtzNZzpSXDBdoFM4oMipuCpvScrBL6EQj14nAoKSU4Y39Xg
 GvWxmp2eI9FediZ9ikr+fh7mkaWiqNnROJ5JQImLb4BzH1cKqXtjUbYb8JL7WOw8Ytd5
 wLcFI9ZTYGjW2ba/YG6EWOFV6yl//44XN7GM+4ldn4Q9F6RxPuNZRzHG6TcjLRh7qX5g
 ojtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511286; x=1760116086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0SrUCjw9dFeMVD8Ylmqi8TNkfgQzS+PP2xkc3/Os+U=;
 b=nzjTYaMIsphmt5azLsLXjVvV4biiQolWgpkzGVIEnAyQGjZBcy8VvHW0/iv6lfzQ6a
 2E0cMLwRq5B1KkRxBFXSPktQMgYvdHvkn7scB6cZXQ1RGG43xx4xCw7IEAQTgesgf18d
 nivK1sr0RotzxrGf544lbpixUWBYWfEOrmVAyKXzFZSRyy+5cBFyWXb0PgNPmcR4a6S7
 0LGHXPUYFqbkJJhyz9erwaXjQt+tTddfT5kfOQZmXAPcGT05sn75alS1evrtp2vfy08M
 HN1L6x20Znk3q5LeeDpIlc/yOZFGNyS0hxvEL4kzi0yWdTltj7DFgZc5Vhing8Oidmyo
 st+w==
X-Gm-Message-State: AOJu0YyL+ZI8AOxUBnzJ+dCEbvKEqVjXks76QBX9JmwOW0ZUoh2AlFIJ
 +QTeKL6SLbKfYvW0N4vrXf/LrRKmOSRkXYY1j1PlD2mMcX+8P5inwML4lR6CFXq8Y0utsdpmMYx
 cRb1h6ks=
X-Gm-Gg: ASbGncsqvrGLR7h33uRmMWF2L8II3urp9b1YbGcb9Gp1/ZRm6UvrzUbK376uByJjkbr
 y3fBmXvnqowWhavSGv6egjVyogq+l5VfxRYw/rLlDgNMSRD44Hax+PYumues9uwSu3TK7yh3aBX
 04Ey2GVBjhvBPspzsldOBp6QdZeTfNPYntrkP+clIIQKwCp7AH+dmaQlGtOxX55qfUfM8+qPkri
 e05BFSZCvWKC71+CzpHkXLKzOpxpj+/bno74YbkZtrP6rsmhM4tN9T4nIqzaBakxPbyD3xzMLbL
 fGxfuMhHhprOgV3bV1FGhqun7UYVBR/qzeKraPXo8yxvHFjmJp8CGP3rHPRiHmrsa3wtUWoUl+J
 lK54uuNUxYbMEvcAsWV1dhvUKjqlx80QgSl6njZqAoCvJ18rYL6hYSG8Q
X-Google-Smtp-Source: AGHT+IEaUPCjei8D0fOhCRR7a+RvkFRVzIQnTQVa1TTW0ymu+OYdSLHLHhuvc+ZI/oTyLQEg69PhDw==
X-Received: by 2002:a17:903:3c66:b0:268:cc5:5e4e with SMTP id
 d9443c01a7336-28e9a543aa4mr49672135ad.1.1759511286508; 
 Fri, 03 Oct 2025 10:08:06 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 05/73] target/arm: Force HPD for stage2 translations
Date: Fri,  3 Oct 2025 10:06:52 -0700
Message-ID: <20251003170800.997167-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Stage2 translations do not have hierarchial permissions.
Setting HPD means we can eliminate an extra check against
regime_is_stage2.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c |  7 +++++--
 target/arm/ptw.c    | 24 +++++++++++++-----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c9a8012880..c19345dec8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9391,8 +9391,11 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         tsz = extract32(tcr, 0, 6);
         gran = tg0_to_gran_size(extract32(tcr, 14, 2));
         if (stage2) {
-            /* VTCR_EL2 */
-            hpd = false;
+            /*
+             * Stage2 does not have hierarchical permissions.
+             * Thus disabling them makes things easier during ptw.
+             */
+            hpd = true;
         } else {
             hpd = extract32(tcr, 24, 1);
         }
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6344971fa6..ebb260d54d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1471,8 +1471,12 @@ static ARMVAParameters aa32_va_parameters(CPUARMState *env, uint32_t va,
         }
         tsz = sextract32(tcr, 0, 4) + 8;
         select = 0;
-        hpd = false;
         epd = false;
+        /*
+         * Stage2 does not have hierarchical permissions.
+         * Thus disabling them makes things easier during ptw.
+         */
+        hpd = true;
     } else if (el == 2) {
         /* HTCR */
         tsz = extract32(tcr, 0, 3);
@@ -1978,16 +1982,14 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * except NSTable (which we have already handled).
      */
     attrs = new_descriptor & (MAKE_64BIT_MASK(2, 10) | MAKE_64BIT_MASK(50, 14));
-    if (!regime_is_stage2(mmu_idx)) {
-        if (!param.hpd) {
-            attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
-            /*
-             * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
-             * means "force PL1 access only", which means forcing AP[1] to 0.
-             */
-            attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
-            attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
-        }
+    if (!param.hpd) {
+        attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
+        /*
+         * The sense of AP[1] vs APTable[0] is reversed, as APTable[0] == 1
+         * means "force PL1 access only", which means forcing AP[1] to 0.
+         */
+        attrs &= ~(extract64(tableattrs, 2, 1) << 6); /* !APT[0] => AP[1] */
+        attrs |= extract32(tableattrs, 3, 1) << 7;    /* APT[1] => AP[2] */
     }
 
     ap = extract32(attrs, 6, 2);
-- 
2.43.0


