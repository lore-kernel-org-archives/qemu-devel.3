Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46363C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWM8-00063I-2l; Fri, 06 Jun 2025 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJO-0003qT-ND
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJL-00061U-2i
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrcwJxyFvjJ8kIq5UYIgWeREzkk5jO+by21HvIVwTtM=;
 b=hdE5GyQB3U66rAEYXse0da4YkoYSeiQbl4gn9oTJ1QPHSO3SnLmfATanXz40603fbjwGL+
 n5zAIuTNL/Odno+gZLd4o+OyDDTtxwcXV+KuZnTV9dw+xC2I8mmqJm1Q8+rGmxgYqmN+US
 53NFFB9AvtiS2l3VdV/sD0VEf5mK+20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-gRytHlH6ND-WcFN1RucwlQ-1; Fri, 06 Jun 2025 08:36:35 -0400
X-MC-Unique: gRytHlH6ND-WcFN1RucwlQ-1
X-Mimecast-MFC-AGG-ID: gRytHlH6ND-WcFN1RucwlQ_1749213393
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so12344825e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213392; x=1749818192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrcwJxyFvjJ8kIq5UYIgWeREzkk5jO+by21HvIVwTtM=;
 b=e1yxD19P2ePCqBLpJfZVvlbs06UnvpP1fynQwCsZvHHYPvYXO5XmYz8KtKepSEISp/
 JYuxl4KC0wdkqQeUP9rj6Ss7uLa2NFH+tO+M4Sd4tRx1blUqK6OcdAtFWKu02a0YiYGX
 fwci/wnjd5y6c/jHCf/7hnB9B4T8Sl7ZO63x7e7DzFjw07h7PN4xrPg6B8J6OF0zoZH3
 +r0DyHPU3b8MJbEaR1ktcRr2QmDNkMQ9AkJdB29UU6EaPCKrsowj7gWPQSBXAdmY36J+
 yUs5xgx3/+gwFXMI64dUX+9emWOlXkAbi9uAowxnlp5NWt2iU+Ntwg5orTp7dYv5qqEp
 ROEg==
X-Gm-Message-State: AOJu0YywIjd2P8Aszi5uHvl6nBM1WoBnKw+8/Hxj9SLDIeookCoUQV7J
 pVyiMhDviBGu7KgsgL/z6kEcPQaQt0+FNBMmZ0b+quJpff8hIl1WAr/oQGriPaCS4CxL3THX1U0
 WMp/P1ONMm3ZrnlNoK68s+6nGA3PZVOy45+glPkb+hRGhU8IvKRnIvrpgLv783ur9HMbR4v4kG/
 5U/3gLUjBX07NW6Ez97H28lEljhYA46CJN+1OsPt8v
X-Gm-Gg: ASbGncsk+HOVQnHmAwsiPUgs3z0S8q284vRsjbN9QMTNiLfeUQ/2J64vaytqOroTXhU
 7NDDAoEYsWP8dE10690FxJlPWkftwzvqic+x3pk5A+6/9XAT16tZB0GPM3x2zjpKUUG7aX6yPd7
 zJRLhW+plLN6zfa5T95pBPe5Oh2cw+sQRhwHQM54Jt1uVE90NvM2dK6b+AlbrR5OPHjZmvJNuAN
 u2rPGXXWxGf7JVtRfoYjPNCJEP/kM7ElK9ZhT04hfQVviPereHcKDnBbi3kkaiqrH1+I1mj76VF
 a9J/7EX+DLICK0KvuS6J56vL
X-Received: by 2002:a05:600c:3b10:b0:450:cd25:e69c with SMTP id
 5b1f17b1804b1-452013d1f6bmr31345665e9.21.1749213392101; 
 Fri, 06 Jun 2025 05:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfbZihIa9Rh3GABVmBSKBEfUJZ1x5TXRHRY/BgNF90pG55/pNnUc/4JiikKeF2sItBhv59hg==
X-Received: by 2002:a05:600c:3b10:b0:450:cd25:e69c with SMTP id
 5b1f17b1804b1-452013d1f6bmr31345405e9.21.1749213391615; 
 Fri, 06 Jun 2025 05:36:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521370936esm22684215e9.20.2025.06.06.05.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/31] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
Date: Fri,  6 Jun 2025 14:34:44 +0200
Message-ID: <20250606123447.538131-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The x86 DE bit in the FPU and MXCSR status is supposed to be set
when an input denormal is consumed. We didn't previously report
this from softfloat, so the x86 code either simply didn't set
the DE bit or else incorrectly wired it up to denormal_flushed,
depending on which register you looked at.

Now we have input_denormal_used we can wire up these DE bits
with the semantics they are supposed to have.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20250519145114.2786534-4-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/fpu_helper.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4732b718129..b3b23823fda 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -215,7 +215,7 @@ static void merge_exception_flags(CPUX86State *env, int old_flags)
                        (new_flags & float_flag_overflow ? FPUS_OE : 0) |
                        (new_flags & float_flag_underflow ? FPUS_UE : 0) |
                        (new_flags & float_flag_inexact ? FPUS_PE : 0) |
-                       (new_flags & float_flag_input_denormal_flushed ? FPUS_DE : 0)));
+                       (new_flags & float_flag_input_denormal_used ? FPUS_DE : 0)));
 }
 
 static inline floatx80 helper_fdiv(CPUX86State *env, floatx80 a, floatx80 b)
@@ -3254,6 +3254,7 @@ void update_mxcsr_status(CPUX86State *env)
 
     /* Set exception flags.  */
     set_float_exception_flags((mxcsr & FPUS_IE ? float_flag_invalid : 0) |
+                              (mxcsr & FPUS_DE ? float_flag_input_denormal_used : 0) |
                               (mxcsr & FPUS_ZE ? float_flag_divbyzero : 0) |
                               (mxcsr & FPUS_OE ? float_flag_overflow : 0) |
                               (mxcsr & FPUS_UE ? float_flag_underflow : 0) |
@@ -3270,14 +3271,8 @@ void update_mxcsr_status(CPUX86State *env)
 void update_mxcsr_from_sse_status(CPUX86State *env)
 {
     int flags = get_float_exception_flags(&env->sse_status);
-    /*
-     * The MXCSR denormal flag has opposite semantics to
-     * float_flag_input_denormal_flushed (the softfloat code sets that flag
-     * only when flushing input denormals to zero, but SSE sets it
-     * only when not flushing them to zero), so is not converted
-     * here.
-     */
     env->mxcsr |= ((flags & float_flag_invalid ? FPUS_IE : 0) |
+                   (flags & float_flag_input_denormal_used ? FPUS_DE : 0) |
                    (flags & float_flag_divbyzero ? FPUS_ZE : 0) |
                    (flags & float_flag_overflow ? FPUS_OE : 0) |
                    (flags & float_flag_underflow ? FPUS_UE : 0) |
-- 
2.49.0


