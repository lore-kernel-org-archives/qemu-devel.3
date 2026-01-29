Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEFED61013
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlS9m-0000Xp-AX; Thu, 29 Jan 2026 08:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8p-0008ON-Sz
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8m-0002Zk-EI
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:32:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so13237305e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693570; x=1770298370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbQjc8ZYqWORXyizHA7cHB2eAOXerMSR4t/7ALRc1wY=;
 b=cO6137HLfAyKYBmGYxWTMZP84d7+K/RqSyFSeEULnOZn9ovGR0CSjYJugKfJtTcgRU
 CNBAMvOslITkYYTG+6AC8Mf4TpFn0p6KwOUof/98fL3L3KyXb21TMS+GNOWiLnfqKK/S
 wuxwzebFewp5jwibEeqMmGuRsFt8uQa/kpHB6EbJ3fOy8YTHlKkQActLiiUJgEB0Hdnp
 ep6JwfUSCL52IR7eYQfL6X8IB9h073sLPQCZHurJU2cwMzKc6qNc4Hblk79YbPutcMKT
 dV2kiglJnTOq2frBIX8a27zbYv324lCPmyxhPRITZaiJoo28hEvBqO4FYhH6OQa59jbz
 0wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693570; x=1770298370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XbQjc8ZYqWORXyizHA7cHB2eAOXerMSR4t/7ALRc1wY=;
 b=KGjz1jM+DkVSMFOGbtBpnmHT/wPT+XxBI6pns17wXa13n6G8Z8WtMqz4FPTCu1Vhhw
 46zQme/z3cFtvkIwnwvuL5O3IyjeBa3k1yfO9kMKKkllxaDMTMUNiG2zd3KwVRn0Cmst
 2WWMu3ac1EGWrVogcWAfgPapfOG+bN9HJSsOCSRaODHBhoHg22UmVtFD261AZ6E0CzNh
 Fx1p7nHawXAe0yyvSALbn1EbA4pJi+vxrWIQ5jsXY8FAwhOlaIry4yD4w4CtXUczSwxo
 nk27OiVLvqYXq2aQpnol1mO/L/WeRjRgIriZxN3E3wG+nqhp5JxBjNTFiW186gi/eIK6
 /BfQ==
X-Gm-Message-State: AOJu0Yw1xt9uYWdjYYOHTZ3rhWUJybVu7T1gjaqQnOG8L2fN2qwbGL2D
 3+1GYpV3kE39R/ageMvPwUjnCGsTLWtbsDOqOe42VlZVAOPdZURT+BRqCFxNQnh5bwXiPaHPeDc
 pfsFUGN4=
X-Gm-Gg: AZuq6aIy/E3+/co8TQbdxNTTaHBMLcEDza7D296OtPlJE/hStm9DhlcUTzL/Pf6sy5r
 ZDYGkc4tXgofX90Ni5r2VKiZzRGCV5sK7vwVlq41PZSopHLvs6XLLY/93flv3B06wuu/vrYRgTQ
 hom8mJUFQ/cuO6dHRr8kyqzmSOXA/9j/RH9WSBa7blcNaM70popN36brqKAvQXfJSL6kxLJo5e0
 w3W7W4dpSzFJI6ej4yw8Da61zFD9xY0/Q70oGP1UYzLEI5HEWEyh0rykKqxHeQfTzYPQPdO6+0Z
 WLE0KStDuZaWi2hKGmKtLUhywmFYj6CaiWhTnk/4tDmlg6rzslRLmQrPfUk7L3Z+ib67E6+PkeJ
 2reWf9n90uqrk+l1AiRM2rPE1kTV0FZcC+pI9teFw9SXlmNj/nBqy1zJOTFpBNIX36LkbinFcTy
 7Or9TDIqbrfdoduWrItLPZ2IskEPeso3UuFvvBqeqJ4mJAbetmkUIR8tZ+jg67
X-Received: by 2002:a05:600c:3505:b0:477:a289:d854 with SMTP id
 5b1f17b1804b1-4808289f9damr42646635e9.5.1769693570457; 
 Thu, 29 Jan 2026 05:32:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c37433sm179322285e9.10.2026.01.29.05.32.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:32:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 1/9] target/i386: Include missing 'svm.h' header in 'sev.h'
Date: Thu, 29 Jan 2026 14:32:33 +0100
Message-ID: <20260129133241.35990-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

"target/i386/sev.h" uses the vmcb_seg structure type, which
is defined in "target/i386/svm.h". Current builds succeed
because the files including "target/i386/sev.h" also include
"monitor/hmp-target.h", itself including "cpu.h" and finally
"target/i386/svm.h".

Include the latter, otherwise removing "cpu.h" from
"monitor/hmp-target.h" triggers:

  ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
     62 |     struct vmcb_seg es;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/sev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6b..4358df40e48 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,6 +14,8 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
+#include "target/i386/svm.h"
+
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
-- 
2.52.0


