Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EAC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG9-0006tE-Vc; Thu, 06 Mar 2025 11:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFy-0006ko-Ct
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEFw-0004YV-JY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so7735865e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279171; x=1741883971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=boqObD7bZDYwU3C5F1au5ERTDSOIX+SOptk6jDi4Ufo=;
 b=fL+74agP4CVT0+0G2UPh9w42QU3JEIY03MZmV2lNRvUDt01JXlt7k4obS6XHijRtpv
 yvYUlYBJS+5k4UVz0rOJskTf0kScWTVA22pAWATx16Bdm0NTgldeFkL4RUm2wp0MnAyw
 2o9ITAGGIZpLbuMswcxNEMkQFrXpMnNbM/Ef7BkjOn9Rnonmng006Ky7kzPuIsRajCXU
 LqpuWNCKkt9Ueo6BoOq0vjv5BriYVRqMI2Zwaz3714aJ3jtXASE3yakrWTtAjOcB69b7
 luNrbygeXJMwZfbI2Q8sIX86oIxjJbiHYKWaN/7Tz2aPTN/gzFGsX+jfOywgq0EqM5Ud
 Cpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279171; x=1741883971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boqObD7bZDYwU3C5F1au5ERTDSOIX+SOptk6jDi4Ufo=;
 b=V51VTkrPDjk9VmClLYRYZsMV+gNQGK2eYF1h4i8rqVdtMY1Z3XIIcNbJvu5nlv7ikz
 niM1ktxGMGTybUMIXFtkvKROmX1I3NI2lb0TKq+oeBZggEPVbdyY9YXUFnPYHq7b9vAH
 k5AbyyJ8ZgRxvdiQyaFiZkjyXZqHYVm2rXbDhOBAJ/obDWJQ0+xrdJLLXSHmhMip20Vn
 CyIjS8IXEY0R2OTHzIB9z2a5logFw/QJgnktQfUcnyqjkxQdV9puPivubm+0ceb5FkrO
 Qox16oL6F1+XPSA5OdyhtxgGhxmiNPMgx64f+QufePI4rjfh11kCTZx91yEmW7TIDj2N
 jHiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6dBRiybtWgjS1G8KFVxqdNjth2pw8AkRn4ccKf6r7JxOKBper1GtIl/ai1GUh+051vvcEr6ATZznr@nongnu.org
X-Gm-Message-State: AOJu0YyvP6miTMmIQDicrrxr8aZRlcp3Y/cmTrE1ews9JnHM41Hjwa8g
 Y8t+wd2T0zJG1bogY02GVoO6f4sbxX9q6XwEyN7R8GqRVi2GsdLU/VK8sZ5lgX+yaegP1p0JXCT
 M
X-Gm-Gg: ASbGncvtefOyAFNECoZ/j4UAJoZT/8AMga3DifAY+kZb1k1logYANrMG0APr0wlmJMZ
 Sk7TlBmVSP7z8FG366Q/+fB0wkbAFCD1pb5SJcn2xzHL5KVWaQ3v7FgeMW8js6OdRW28acrbwLI
 aG5OJGJgW3KnQ9LkLhI0z83ls+3J7BTs7IDUmhzn2L6sv6iUyQfo0jWemsP4XhH3Q7ookNRqhsC
 iirRltxd+an4OaZnGZNLRSwUBLIWd0tNGoT/WPacYy+XjcyEq+fGB+9o3B9/1AflElh1CxDcw57
 hMkrByfdjeiawZmW1yO04I06yW/vlWzwdFkkTHxqsUKw3WgXSdc=
X-Google-Smtp-Source: AGHT+IG1PNUxXNGINkUBQxi+3PrXQFd0frdXkvvnJrgnK8f4S/Qxmx4HPsQ9yyGBF6InPs5ABQm8pQ==
X-Received: by 2002:a05:600c:4e91:b0:43b:cbe2:ec03 with SMTP id
 5b1f17b1804b1-43c602210c8mr1054785e9.27.1741279171068; 
 Thu, 06 Mar 2025 08:39:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/10] linux-user/arm: Remove unused get_put_user macros
Date: Thu,  6 Mar 2025 16:39:18 +0000
Message-ID: <20250306163925.2940297-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In linux-user/arm/cpu_loop.c we define a full set of get/put
macros for both code and data (since the endianness handling
is different between the two). However the only one we actually
use is get_user_code_u32(). Remove the rest.

We leave a comment noting how data-side accesses should be handled
for big-endian, because that's a subtle point and we just removed the
macros that were effectively documenting it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/arm/cpu_loop.c | 43 ++++-----------------------------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 10d8561f9b9..7416e3216ea 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -36,45 +36,10 @@
         __r;                                            \
     })
 
-#define get_user_code_u16(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u16((x), (gaddr));       \
-        if (!__r && bswap_code(arm_sctlr_b(env))) {     \
-            (x) = bswap16(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define get_user_data_u32(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u32((x), (gaddr));       \
-        if (!__r && arm_cpu_bswap_data(env)) {          \
-            (x) = bswap32(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define get_user_data_u16(x, gaddr, env)                \
-    ({ abi_long __r = get_user_u16((x), (gaddr));       \
-        if (!__r && arm_cpu_bswap_data(env)) {          \
-            (x) = bswap16(x);                           \
-        }                                               \
-        __r;                                            \
-    })
-
-#define put_user_data_u32(x, gaddr, env)                \
-    ({ typeof(x) __x = (x);                             \
-        if (arm_cpu_bswap_data(env)) {                  \
-            __x = bswap32(__x);                         \
-        }                                               \
-        put_user_u32(__x, (gaddr));                     \
-    })
-
-#define put_user_data_u16(x, gaddr, env)                \
-    ({ typeof(x) __x = (x);                             \
-        if (arm_cpu_bswap_data(env)) {                  \
-            __x = bswap16(__x);                         \
-        }                                               \
-        put_user_u16(__x, (gaddr));                     \
-    })
+/*
+ * Note that if we need to do data accesses here, they should do a
+ * bswap if arm_cpu_bswap_data() returns true.
+ */
 
 /*
  * Similar to code in accel/tcg/user-exec.c, but outside the execution loop.
-- 
2.43.0


