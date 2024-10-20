Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29CDD3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG8-0003Yy-BA; Sun, 20 Oct 2024 11:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFv-0003Og-5U
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFt-0005RP-IY
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Y3jIf+hNsv83+CZvNpXB3wyuIaNSzogNsVqhzqQ8Ds=;
 b=AukYdtJNuQ9iuhYSG8bmWVWGJ+pvsik8iJoV9F6S8etEUF7r9XJjsNF6wFFjdXxQTuweer
 OHCbojvzoEvuokeM1SJyfA+PCdLaoFWbVrRFAzWI1tdGhIfOST+c6m7vl9rQg11fanAkwY
 9GEufwV/R1pjO1z3UaYzCthUua92xyE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616--qU1qUC3M02z0-1p_ANPfQ-1; Sun, 20 Oct 2024 11:54:06 -0400
X-MC-Unique: -qU1qUC3M02z0-1p_ANPfQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso24168815e9.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439644; x=1730044444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Y3jIf+hNsv83+CZvNpXB3wyuIaNSzogNsVqhzqQ8Ds=;
 b=qwx2KIHHocpjFFGlMHhCk05isY29dsp6TM1wIetYHQCav9jAfCdMj0azuyVAtHFmtU
 /dsIM3hx0YQGeFEIkolZFzXVDG0rJSrZkQOm0ZLXAGWmQ/7SOm6xrRC2K6CgDeLuZ3Xu
 cuRSRC0OxGzm1/3QQJG0EVqNJEutwhgRU/GAHoy2l+RhdP61Bmnlc9ySkzHWCA691LtT
 KaTNeB5NWBz5vI4kphUxEWUO6EBvxPM3kAhShAJB9XjhrjTqcWUItj+AQBiGhHeKoPbj
 SUOt5bt0IR4LvWquySDCmaKdUp9hYKOPJViFB2NOHlNWBdd8J0VMdvH0wW73vLKTQzvN
 AqYQ==
X-Gm-Message-State: AOJu0YwUg5qS0sAdVwZr0DA83A6d6Gc37lMcKnjXrh9+jPeoUet0OXer
 gwGpwWQ3izNJQSLHwMEFybNh98hqgBWXc+1mkfiUvaXCnrX2j7Ut240hzNQwYiaIc1vVsG/3Pn/
 k3UcoDxfEeE24ln3RFzaWwZaku7Urnz3X7k0ABKMkBEb8ztcR4m7swn9ET76pi4oZXKnoco2Gx2
 MHpN9C1ruYwrWna86i6gff93mVEbFAi4HSU0a1FPE=
X-Received: by 2002:a05:600c:3515:b0:431:52cc:877e with SMTP id
 5b1f17b1804b1-43161669459mr62972175e9.20.1729439644128; 
 Sun, 20 Oct 2024 08:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl9HP4jF8dlq2watXhhYZPnTthlZUbKePtZPVtbKHquGlD65AVe8wG7zlMUWxyMcL8PxISuA==
X-Received: by 2002:a05:600c:3515:b0:431:52cc:877e with SMTP id
 5b1f17b1804b1-43161669459mr62972045e9.20.1729439643658; 
 Sun, 20 Oct 2024 08:54:03 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f570f7esm27171185e9.10.2024.10.20.08.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:54:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 11/14] target/i386: make flag variables unsigned
Date: Sun, 20 Oct 2024 17:53:21 +0200
Message-ID: <20241020155324.35273-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This makes it easier for the compiler to understand the bits that are set,
and removes "cltq" instructions to canonicalize the output value as 32-bit
signed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 46 ++++++++++++------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index c5425e57cfb..4cbbc73c3cd 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -39,9 +39,9 @@
 
 /* dynamic flags computation */
 
-static int glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2 = dst - src1;
 
     cf = dst < src1;
@@ -58,10 +58,10 @@ static int glue(compute_c_add, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return dst < src1;
 }
 
-static int glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
+static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                          DATA_TYPE src3)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2 = dst - src1 - src3;
 
     cf = (src3 ? dst <= src1 : dst < src1);
@@ -79,9 +79,9 @@ static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
     return src3 ? dst <= src1 : dst < src1;
 }
 
-static int glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
+static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2;
 
     cf = src1 < src2;
@@ -100,10 +100,10 @@ static int glue(compute_c_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
     return src1 < src2;
 }
 
-static int glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
+static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                          DATA_TYPE src3)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src1 = dst + src2 + src3;
 
     cf = (src3 ? src1 <= src2 : src1 < src2);
@@ -123,9 +123,9 @@ static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
     return (src3 ? src1 <= src2 : src1 < src2);
 }
 
-static int glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = 0;
     pf = parity_table[(uint8_t)dst];
@@ -136,9 +136,9 @@ static int glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2;
 
     cf = src1;
@@ -152,9 +152,9 @@ static int glue(compute_all_inc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
     DATA_TYPE src2;
 
     cf = src1;
@@ -168,9 +168,9 @@ static int glue(compute_all_dec, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 >> (DATA_BITS - 1)) & CC_C;
     pf = parity_table[(uint8_t)dst];
@@ -187,9 +187,9 @@ static int glue(compute_c_shl, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return (src1 >> (DATA_BITS - 1)) & CC_C;
 }
 
-static int glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = src1 & 1;
     pf = parity_table[(uint8_t)dst];
@@ -204,9 +204,9 @@ static int glue(compute_all_sar, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 /* NOTE: we compute the flags like the P4. On olders CPUs, only OF and
    CF are modified and it is slower to do that.  Note as well that we
    don't truncate SRC1 for computing carry to DATA_TYPE.  */
-static int glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
+static uint32_t glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
     pf = parity_table[(uint8_t)dst];
@@ -217,9 +217,9 @@ static int glue(compute_all_mul, SUFFIX)(DATA_TYPE dst, target_long src1)
     return cf | pf | af | zf | sf | of;
 }
 
-static int glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+static uint32_t glue(compute_all_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 == 0);
     pf = 0; /* undefined */
@@ -237,7 +237,7 @@ static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 
 static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 {
-    int cf, pf, af, zf, sf, of;
+    uint32_t cf, pf, af, zf, sf, of;
 
     cf = (src1 != 0);
     pf = 0; /* undefined */
-- 
2.46.2


