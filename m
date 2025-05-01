Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34386C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLl-0000z8-Fx; Thu, 01 May 2025 17:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLf-0000ru-3a
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:39 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLd-0001Wn-5Q
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:38 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so1427836a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134495; x=1746739295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEe9bxPY78rzldhxeSl0yGcr1LEt/gfI/ABj5JQK6lg=;
 b=v+euWi3ZrxYOrpni3BZDUjJv6pk3I4SIUWrrRElvqUf5DK38MoWXlIh9VQwL9mSNWi
 ua7g7I/vC4GQIWmqSir70xsIYCLJsnD1YVztPTpVCZLvkgHH7OQ0p8rWsBToMj6fAykg
 sHV0SFD8OENWtb+2B0rrlCommZuXtMFiTBv8/TRlrWgQMaPVk2g17Ci15QXTAnGadBoU
 pI4nadu22zdIijUQwMBF9u/C0mYfKP91LyNZTMUV1KKQerwLWF0099Jx4njl0XbqQgJJ
 Dv6svrAgzvOAwEk5Epcl3ZRwD3kV7uShHGGd1/fl5poTUixQ9eiwV5hqtEm3FJ+eBHCc
 hQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134495; x=1746739295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEe9bxPY78rzldhxeSl0yGcr1LEt/gfI/ABj5JQK6lg=;
 b=cNrAYNNqY8DRjMq6GnUJzEBIFcMelskl6Dd38djUNtVe4Pc/bdHqX31GH80VcA9puv
 /Um/ybfoYT9TaeqCuOemPnXuBb7kHIKb/BDzAyQnu+P+cphqvGHWDzFsT/+647KFd2To
 jTEhO0f63fUQ2MK2WrLM/3HUGkEe53k+H7rHq8XAkevLh0FhiWzoBjkp6W4//6UVvw3z
 3XwjjK+HJrKBhZzxq8Tiehn1SUqlGBKIJZBRxBcv8uksivrwQyfaWyG5dnerMnjKyC9u
 2ffhAEYpEYifb06UNqs/gzHWr8X1n9SXdoJADLoeVh2nAX9NE2gtYRgesQLzQb8lsK90
 MpZg==
X-Gm-Message-State: AOJu0YxmQdlLu4YULHpzHlYliXiTvPuXPH/uo0XEwAswKii+IGSwqhQu
 CQUKjOrjBrFVeEWkBmKEZUDrFjRRrJVziAh2fYYv9BZAbMgrsxNkQatgG5MTRn8ngiqdEeHbNFm
 u
X-Gm-Gg: ASbGncspXiQw9xvke48Oe3Imu6zckzhPtWKkmimhnAP8VR71zCx5kwhMyHM0StBQmSv
 AWZk/15PG6xA6PBO8xP5Y12GIToqcepxRl+Xh6HPWebqqVMOcUjmdC7J48TTuHUgikHfOWpuSJA
 9Vj7qpj1pSLXFTDj3TFnygAGY8CGq2H0TZ5hVInqbtU49GRs0VMPUCbhv40W9uhddE0VYAXA7YK
 BXiZQuV1bqsvGHfwIsbIL8Ej0HBEOX2RfS1kPb2g9XUPiFUTI4tsvH82HNOLffM2kHoJRnOv1Rf
 pc2A4Xd0FxjxC93tcKiygXNaYE2R9QsjJi7WtwZsK7+qqI9rbwDa5ltI7oZy3bxihUaWL+04Y+s
 =
X-Google-Smtp-Source: AGHT+IHAopIn5+8ItdZXk/VxBHbxag8ev8c1fz0ijh6faLJmFQBIIZDRGaMIh0uQP0onjke6xZ0QHQ==
X-Received: by 2002:a17:90b:514b:b0:2ff:6f88:b04a with SMTP id
 98e67ed59e1d1-30a4e5c5ec1mr870218a91.15.1746134495367; 
 Thu, 01 May 2025 14:21:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/59] accel/tcg: Generalize fake_user_interrupt test
Date: Thu,  1 May 2025 14:20:38 -0700
Message-ID: <20250501212113.2961531-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Test for the hook being present instead of ifdef TARGET_I386.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 279df5fae7..8ff4a34509 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -732,10 +732,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
      * If user mode only, we simulate a fake exception which will be
      * handled outside the cpu execution loop.
      */
-#if defined(TARGET_I386)
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    tcg_ops->fake_user_interrupt(cpu);
-#endif /* TARGET_I386 */
+    if (tcg_ops->fake_user_interrupt) {
+        tcg_ops->fake_user_interrupt(cpu);
+    }
     *ret = cpu->exception_index;
     cpu->exception_index = -1;
     return true;
-- 
2.43.0


