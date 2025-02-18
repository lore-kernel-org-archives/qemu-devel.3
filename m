Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3061C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkVyw-0001k7-Ep; Tue, 18 Feb 2025 17:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Fgi1ZwoKCj8tmpohgjfmehpphmf.dpnrfnv-efwfmopohov.psh@flex--slongfield.bounces.google.com>)
 id 1tkVyu-0001jk-60
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:22:20 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Fgi1ZwoKCj8tmpohgjfmehpphmf.dpnrfnv-efwfmopohov.psh@flex--slongfield.bounces.google.com>)
 id 1tkVys-0001jB-DI
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:22:19 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2fc45101191so6428012a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1739917334; x=1740522134; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YzyMiiwDnQ6S+QqMo6hPoD3cO7L/FwWaN/5gyzhjYLI=;
 b=cvple46eI5iib2qTHaeGmqg4yGDjzG1/vTH1lsJ+Q/8hObMypkFbFyhrNct2kZKd6N
 ODZwD0SZtVLdGqE3bZ0kQYeqaD0jTT6hdCG+dPZ0sU1IY7dt5yExYU5pTyHGlJfkejfJ
 PYu/vwkLRgRQj1gYHlU52GNMHPVxMPbkxxTM7s+mb4h1xSR1s1pvm4Q9TNocu9l8JYXy
 Bmlg+O2dwhUceLwF+lf3a4V9sCKO7okv8ea5V+xK2vDGgpyWxn4mqDMPnAUwSbrlURoA
 xZTT3lNgSJUwRy+GlsNbhdKf//okSH0Sx8JLnOiANmzuWw4Vlf/6E3shM2Qa5CMZEiSv
 6DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917334; x=1740522134;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YzyMiiwDnQ6S+QqMo6hPoD3cO7L/FwWaN/5gyzhjYLI=;
 b=WUi0JuRXIkaR+gB5lxAZ7uTdBrFGpINR8/V/eJLk/6LTQP0lmObtGbViXqfZPAucYk
 dIt42J2m6n3qvrauB/PaO3gFktuERVLWk0c5bRvhdB6m8WWSAYEF5Qzpyp060pp8OyFH
 yZMehT1Zgz7nxTf571/8DPuQaeWAOHNB6AmywAtl2V9oToqHg+mmhbHDrcwihcBaknKw
 PiasedNQ9mv7l1g5VJK4/CoPtlZlXesIpTPxc8tbIS3GpviOmTOeXNjwexwB4m4t3YA4
 r3SNY55JpvVGgciwdmNz0Qz18chH/phskFJSHo0UPctKdhYl/9rpoE0a1Us8iIdMCR63
 u1dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpD2gL5pgcroAv04CpFVJsB8mbOvGo1UWKAwp9Rqk4F5t1/wPx4F0sjcqj5Z5Le/jA7cfqQI9sr1Vi@nongnu.org
X-Gm-Message-State: AOJu0YwiqFBQDJaQ2SE251znJuveG/Hxy/Ny+d9lRz+YAyoCGVaOrLp9
 YN38XE7o69FahToNV5JPlfHA4jK3xSYtGPj+yufZHKYvOn0+mIpD09nCI+LbjV2+KSaNJ37l2qp
 +pL2mzpej4unfo5FviA==
X-Google-Smtp-Source: AGHT+IE6RoASeGyBGoxHyBc2r/Ybr84jJkNlR79hb9KaXG5msjUFVadq89LuxM5rBeeuNKf5nM6Dj7nAgKQafgs3
X-Received: from pjbrs15.prod.google.com ([2002:a17:90b:2b8f:b0:2f2:e97a:e77f])
 (user=slongfield job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b4d:b0:2fa:226e:8491 with SMTP id
 98e67ed59e1d1-2fc40f1027cmr23084628a91.9.1739917334128; 
 Tue, 18 Feb 2025 14:22:14 -0800 (PST)
Date: Tue, 18 Feb 2025 22:22:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218222211.1092072-1-slongfield@google.com>
Subject: [PATCH] target/arm: Fix signed integer overflow undefined behavior.
From: Stephen Longfield <slongfield@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, slongfield@google.com, 
 roqueh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3Fgi1ZwoKCj8tmpohgjfmehpphmf.dpnrfnv-efwfmopohov.psh@flex--slongfield.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The problem is internal to t32_expandimm_imm, the imm intermediate
immediate value. This value is sourced from x, which always comes from
the return of a deposit32 call, which returns uint32_t already.

It's extracted via: int imm = extract32(x, 0, 8);, so the value will be
between 0-255

It is then multiplied by one of 1, 0x00010001, 0x01000100, 0x01010101,
or 0x80.

Values between 128-255 multiplied by 0x01000100 or 0x01010101 will cause
the upper bit to get set, which is a signed integer overflow. From
Chapter 6.5, paragraph 5 of the C11 spec:
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf this is
undefined behavior.

Though this is a minor undefined behavior, I'd like to see this fixed,
since the error is showing up when I enable clang's sanitizers while
looking for other issues.

Signed-off-by: Stephen Longfield <slongfield@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 68ac393415..8770f0ce1c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3508,9 +3508,9 @@ static int t32_expandimm_rot(DisasContext *s, int x)
 }

 /* Return the unrotated immediate from T32ExpandImm.  */
-static int t32_expandimm_imm(DisasContext *s, int x)
+static uint32_t t32_expandimm_imm(DisasContext *s, uint32_t x)
 {
-    int imm = extract32(x, 0, 8);
+    uint32_t imm = extract32(x, 0, 8);

     switch (extract32(x, 8, 4)) {
     case 0: /* XY */
--
2.48.1.601.g30ceb7b040-goog


