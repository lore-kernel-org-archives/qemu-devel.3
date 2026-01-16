Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280FFD47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghrU-0008SF-2e; Fri, 16 Jan 2026 06:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrL-0008AV-B2
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghrJ-0005w2-Tn
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:19:19 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so10381085e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562356; x=1769167156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hEhb2xY72TYGDW2JqPRPheEDMAo9iQtg1TbE6R1DYGk=;
 b=JBvdmiMKLE6shxX3bwSzTLx3f92b6iCktbqfpytFDSqTJ8t7OT+FjdGIxpB6ldt8wD
 KoWWLhp6uFYhwTR+s52Fkmiuo9YAgPFrIkggNeuIAilzJlOHWb4JM6UkWadFYfEDUNtz
 Mzby/dKOEP6RtO3mOFKwVDngkXavBJsSDQzExN1IFEldCoNk5xX5m5TQHb4RK0fVdJVP
 /W3dCNH7qsYplfEY9cgBWYHNmYcj7WzPxDb2AEYKatxHrlgIOV1HtIv3BtSrfKHhRl4q
 9yQvV/4eO5X9h3FDkGZNiSFzoC/J4ZhGUxUqXuLI8TLp7EJ3hfmtI8uHrFLQApS5QZA3
 3mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562356; x=1769167156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hEhb2xY72TYGDW2JqPRPheEDMAo9iQtg1TbE6R1DYGk=;
 b=ZOKVnEi+M6MUd/eCc1jFXZ6UsyiKTJP4EuhfdWSvfYItT9dHND/HiPwMtxesHcv8V4
 mejiW+cGJcFA+L4mPYg27juJH103+OV6Ht7JYiz2TWaqO6FaZcW6d3yNFoT2/7Lf/2fo
 +jiwev5oTzlNRJ1b3mKqpZ6lHR6QU7ho4gVTFsw7TuQHf5rTJjwb448Emf2n0Zr5Lqdn
 aH/r4bCfI7EhVhBKYxorCkOnXo1L7kuZKZw9JFtQ5Ayf2Qgu8f6tkz/PgzsFRMcz5BMt
 vy6keJF2AX4C7Z2cpOObYRKEacMztt1Vmy4kiJE+Yg4OyVrPs1db35hZxQxsSaihVQxY
 beYw==
X-Gm-Message-State: AOJu0Yzdc8wFjZ/CfwlDaZF/L5a6HYtXdvWambs0Jgxqvxs/IlO++4EI
 ssHok3bNNzlQmq5s/S4k3AJ3s2ZlT2NgW5uSeWXM276qHxVOP3Nz9n6rbuHAe8YOIxqW2YRhGSs
 bW1Kov0k=
X-Gm-Gg: AY/fxX6E+PfI6b5+x+HChwGi2m05Kd+9Xadsh/6uULxMLYEQzgtcC33Dw6qyG5eUgBr
 DtVfZHhrb4vHpLgc/e8vNYoAOkgdIN5kZHygYbKCMmz9DtcD6XXYTVxIvNmq+EUo2ZTZk1ZVZpG
 9Mz7WwVrFlkL74BiPcreQuZCTqFRlRqKp9jgw/Lq+rfqAEmYyXSnnvInvMSDiGtJwrGv0Mdg1lr
 eE0cFFM3VuxBG0ST2zRlrShbrM0EagV5IoinI6rDHzmBzKZMuoNEeAjpLjkx6p+xwzvqsJynBfH
 dS6DE+zgptuTE15Ps3FGfW1wmc08XrmwIhkNDfW1crIL/HhfrffZ/86QleOI7U1CInP3vQ9wLYc
 4+kj6MV+KAjwCHStJ7fUL9P4Q/xIEDzHZRbEC0TxkMnRFiE/oOGNfay2tSMPWvqOVxSzBBWVqDH
 0yD1xWcegGY1l3gPVfAbV/8N5HQOkT1dcQZgdl7gKyYizkn8usr76XIJiU9yav
X-Received: by 2002:a05:600c:4584:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-4801e350af0mr29014635e9.33.1768562355929; 
 Fri, 16 Jan 2026 03:19:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921da2sm4663646f8f.1.2026.01.16.03.19.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:19:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/30] accel/hvf: Enforce host alignment in hv_vm_protect()
Date: Fri, 16 Jan 2026 12:17:47 +0100
Message-ID: <20260116111807.36053-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

hv_vm_protect() arguments must be aligned to host page.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260112103034.65310-4-philmd@linaro.org>
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


