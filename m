Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87093C9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFCZ-0000qO-3W; Mon, 12 Jan 2026 05:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCO-0000ST-00
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:31:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfFCM-0001fG-Kr
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:30:59 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso49517905e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768213857; x=1768818657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3X0GR+B2otc1rW8rlwOeUFhaPiJB8m0oagpWA1qY28=;
 b=xFocQHkmoYj9qKUB3tOpTqVBr2JmtI8ZagcKw07BoF286ZeWdjzqNApkRyi1yGhsKM
 yqWZ11Ti+f7BmXHIL82eyKyzltAfoujdMbhQvE1WPHxqcPFy8cgh3+9233uKxAN8QoKe
 Lhu4D4SKD1K4t8PeZk6e3KEBZT4CB362Z1NDW/AG69TKwu7Mz9g32QHNdo+m4IkefDwo
 GJ5dWEdvXzS2HoMuqPLx7QryeH9ZfJOs2T0LJy8STqxDjf6gC5HHw6yqebrga/1RzPtl
 r3WmrxaQlQZxgPw8dsYBQBpiXSFoGHfOLpifYblH9b9oshrOui5YimxsqUZWnp4xJJMH
 6hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768213857; x=1768818657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H3X0GR+B2otc1rW8rlwOeUFhaPiJB8m0oagpWA1qY28=;
 b=RsKoh9dOLc8Iysncdjl6qb5kPIHK2UC+Abx7DZzc94F1KaPbMprLWo+5R6hqpdF+Fl
 EJurf79gwrmDTCjTM3/WIa2DakCqkQ6Dvx9vdFJONKqxg9QdwjfljnkD4pvTK76OlKDS
 TNn+u6NFOZg7J//DgQ/CqdMzBmv+c7h1TEb3Cg+p6t+iY8HBqjvWbgBep6YqEz2aVBnS
 FEOot71e54WYofyd0GDrCSdlaDWAJ6w7SQ5yrZX/Q7m2SSRoLusjPeq3MEHL3hmjO7bo
 yCpETl2fY0j3jVrg+LvXUmfsEXc1xuNJPIDWStfVNXQgpzOmjZ2Lm4B/u77qYwwX1x1k
 IlTQ==
X-Gm-Message-State: AOJu0YxTAKtBNOIdZSzwyrhNxQtIgAGk470LvzkzDjEQNzTTcqcmHTXM
 5ATfSkH90ZTESFWURvCjLzCbuUn0gxTR2QP1/vEqjd714Wbari6V+ZLlA0iwuIKCHAkv6aSuYvs
 6RTwx0/Y=
X-Gm-Gg: AY/fxX4ByjmO4Ny7hxGO5y1M3l0vzmkSkvHWcAAjtOPbONT0Edz7g69tFjViqyK02rh
 agvqQtG6pYPmUMq1TFP0ddU/9FiJIJS3Xh0KNg4qHYZOUixCCdBergmwcMsDEsfiCJz0qxRQbkz
 YgSNe0j8JnKLdEN54rXdHkBdnxghh3WI9D3V60abUZGnZYcVAU32xYlIsTW0nSVxIcxXb5Q0dIE
 1XFl+oR00CftFjVvunPDQg0fiRGeDOxLgEk9ZLgZn8qG1DqMeCTXT0ZEdLgc8Vvq6+jJLo3nH9l
 8sY3kzRqkTOdwF9atPMs8YTtS9yuT2XdBUsDODv/Wsk1NlH2VI1jXLv9T2bKEEuV7H4rqSuS2GU
 rUtOJJZlwiXKF45uj7WonCxj4RcQRaiOAsyKq9d7ZTmyaS3YiRROWCD/KI8Nuh39CyQXmZG79Nj
 L4Uskyg7IwyPDoh6brxkoJQewcAb1vw3Ud+PvRiMUP0EFvtqrCu9gXWfxi6U85
X-Google-Smtp-Source: AGHT+IFbKbnEf2NM+CS2WX0qs3UxMFPG5JVd637/0T5NzdVh6xT8T/RclQ5ZvnsYnVPhfhSpHnC/Jg==
X-Received: by 2002:a05:600c:470c:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47d84b39d1cmr183517455e9.25.1768213856716; 
 Mon, 12 Jan 2026 02:30:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f390a69sm344395805e9.0.2026.01.12.02.30.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 02:30:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Joelle van Dyne <j@getutm.app>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Nguyen Dinh Phi <phind.uet@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 03/19] accel/hvf: Enforce host alignment in hv_vm_protect()
Date: Mon, 12 Jan 2026 11:30:17 +0100
Message-ID: <20260112103034.65310-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103034.65310-1-philmd@linaro.org>
References: <20260112103034.65310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

hv_vm_protect() arguments must be aligned to host page.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 accel/hvf/hvf-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 741b4bdc4fb..96ed79108a6 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "accel/accel-ops.h"
+#include "exec/cpu-common.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "system/hvf.h"
@@ -61,12 +62,15 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 static void do_hv_vm_protect(hwaddr start, size_t size,
                              hv_memory_flags_t flags)
 {
+    intptr_t page_mask = qemu_real_host_page_mask();
     hv_return_t ret;
 
     trace_hvf_vm_protect(start, size, flags,
                          flags & HV_MEMORY_READ  ? 'R' : '-',
                          flags & HV_MEMORY_WRITE ? 'W' : '-',
                          flags & HV_MEMORY_EXEC  ? 'X' : '-');
+    g_assert(!((uintptr_t)start & ~page_mask));
+    g_assert(!(size & ~page_mask));
 
     ret = hv_vm_protect(start, size, flags);
     assert_hvf_ok(ret);
-- 
2.52.0


