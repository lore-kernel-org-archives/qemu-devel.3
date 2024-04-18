Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSU-0008Lf-H8; Thu, 18 Apr 2024 15:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPb-0000B0-Cj
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:15 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPZ-0007ae-9q
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:10 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5561b88bb3so130339266b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468427; x=1714073227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VHCcAuBE/LTzo7Jv3JWIaIvZFf+gAOHGRyRvAagXUpM=;
 b=JjvbdB1EI4R2c/uPHtkX0rPFYOizmp27XThfBJjjFopev2/Z+y64mfPJ9iVpt1R4wH
 KoEgA7n4Zx+wPyXZvzaXmA4kLAqrTm1RanPMuM5x865qxc+QRDdikgxO2sxxfWO8U6Nd
 j9bg2ZnlqvWGdXsvEu559nDpPw0v5dTONhXXvdrYPxG8pFQxWw55URZWcAzZcIKqc+lA
 3L5Rqu//7FjpMHFq01rPL7gWOkC61EvpDYJ6y8DzOjf6m2qhP7EJ7IGL+D+MbRsT7L32
 NpYNp9Ph2EGScz9JO1yAbtx/BjJS5/KoibjSnburEOHuX25BzQSjxEDpV9uutGmLNVvW
 a5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468427; x=1714073227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VHCcAuBE/LTzo7Jv3JWIaIvZFf+gAOHGRyRvAagXUpM=;
 b=nZwjoFjH6+TmmlVUNqdXWOeawnqvdXV4fPd93on+sVzc4HNd/0nfdT8E9lFMgEVf9B
 R0vYPeG17bpBnHoE7TiLvunWIPOzLqb0Y+SAPJRca31ad7WlfqJlYrdaDAjLe4/OvhE2
 NVJnnZFVRrJnXt2DXNDVdZ3kGUL6Z+4aVku5cLIPPu0zKpmTFDrTP+e6/RR0Pu08m1JK
 P25M50+r85EGzdaPHJNbmekfwIIwH9KHREIf5fgjTCa/wvvgOZGijmQ6dn6evuzwkImK
 xpFb5xnwylLxu3aAqol4aH2/cWSVnSDHKLj4Ju7qoBovUOcEsmaWA7MlyeSYxHTfcNMN
 XYpw==
X-Gm-Message-State: AOJu0YwU1DUeoQqMkdQo8WFjb9r4dHfaAwxj+pN8yGPNsAQKyOiTbZOd
 UmwPKk4H12hUwcFa1ipsgOp1Tp8yX5a391E8odmsO8zKDz08kcLfxGSFw2YOWbCuQsoEn0eSCEv
 B
X-Google-Smtp-Source: AGHT+IHCVKWH0+AZiuPsOyJcP3T0HcQ3oNxiRJGIC+ivVe0T0x2KkBJdxwuTUWOtC8MRPWBviUHknA==
X-Received: by 2002:a17:906:3502:b0:a52:277d:c1c9 with SMTP id
 r2-20020a170906350200b00a52277dc1c9mr53891eja.50.1713468427063; 
 Thu, 18 Apr 2024 12:27:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a170906431500b00a521e5856f6sm1256588ejm.51.2024.04.18.12.27.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:27:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Subject: [PATCH 14/24] exec: Rename 'exec/user/guest-base.h' as
 'user/guest-base.h'
Date: Thu, 18 Apr 2024 21:25:13 +0200
Message-ID: <20240418192525.97451-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

The include/user/ directory contains the user-emulation
specific headers. Move guest-base.h there too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h               | 2 +-
 include/{exec => }/user/guest-base.h | 4 ++--
 tcg/tcg.c                            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename include/{exec => }/user/guest-base.h (72%)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 78848f018c..027f19e052 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -65,7 +65,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 #include "exec/user/abitypes.h"
-#include "exec/user/guest-base.h"
+#include "user/guest-base.h"
 
 extern bool have_guest_base;
 
diff --git a/include/exec/user/guest-base.h b/include/user/guest-base.h
similarity index 72%
rename from include/exec/user/guest-base.h
rename to include/user/guest-base.h
index afe2ab7fbb..1e42bca5db 100644
--- a/include/exec/user/guest-base.h
+++ b/include/user/guest-base.h
@@ -4,8 +4,8 @@
  *  Copyright (c) 2003 Fabrice Bellard
  */
 
-#ifndef EXEC_USER_GUEST_BASE_H
-#define EXEC_USER_GUEST_BASE_H
+#ifndef USER_GUEST_BASE_H
+#define USER_GUEST_BASE_H
 
 extern uintptr_t guest_base;
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0c0bb9d169..6a32656cd4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -57,7 +57,7 @@
 #include "tcg-internal.h"
 #include "tcg/perf.h"
 #ifdef CONFIG_USER_ONLY
-#include "exec/user/guest-base.h"
+#include "user/guest-base.h"
 #endif
 
 /* Forward declarations for functions declared in tcg-target.c.inc and
-- 
2.41.0


