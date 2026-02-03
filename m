Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB51E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzf-0005x8-OP; Tue, 03 Feb 2026 10:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzb-0005Wi-Ic
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzY-0002Mp-Jq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-480706554beso62323085e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131218; x=1770736018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aOyWNIQY2zrEQlsluNmHHH92qW0jD7NTLVHRoHPN2vs=;
 b=GiZ37uEW+fwS5vLWPiwQcsNsPGPovbXdCVzKWrA/8Cy3pU4Poq2chcmEKk6dSZ6DkG
 OVtTnlZnaFEvDMcZw868c1xhGciIgVelKDMe/WuLp4fGS8XV7FV7qqIqOG0zCxGv2+9l
 6ndYi/YWUilFSyWXGz+voDiM+MZ/oYzRQS+yRn08T2aywC7StAD9RujU+ubIuzXLTgk6
 wBr0k2b/dCYy/cgyzxHTZoT59ds25GffpdDbo3InYymoqKcW9lvcPPOhXZkmJzldt4bH
 kK9I6Z846XJzpdmltvD1JEFeawuGWMQgQUyr2o6eHlIjkLjG6ZCVVBEwWRvyMhnlZF8t
 GzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131218; x=1770736018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aOyWNIQY2zrEQlsluNmHHH92qW0jD7NTLVHRoHPN2vs=;
 b=UnMuzrTydnpUFW+l5eQO+ubCNnsQ2WJr2QsYcmJUY1ea64O95jDYxCRrb/w6QxpJ4t
 St12KnRENVLEgTm3cfs9VL+4Uuv+GmjBUf/1JvW8sQTWOc0Ro292sJiAK30laTZb6VNk
 wNuA5ZSfWM5KbYam4wRt1IRALvjEC+s8qQzssVd7YJHdST2ggeoRypgcrg3aubIz0wm7
 KWkotfahzF2bprEvL5ktBuO8QI1yId6DyKPgCRf26UE0CrhVjeVj2rdrTwReTsJ7nPZg
 dpZci/yYaUxfl+qqey4Wz2DOENpo9KghO9rwHmOO6l9wUMzvNoiDQCGk3NI8xn8ekLC5
 iBew==
X-Gm-Message-State: AOJu0YxZapr93+q0PJGiozsjg5vrodbuIXAvyiHwHQtSMDATGbLvpcsR
 G6e1g8o9mMDQ821ZWf5g+9+S+531KtcnvHDM/3UFZau9S5WYaSRfmc/K5Q2CB83rM3bWwN+S0UM
 JJTUesME=
X-Gm-Gg: AZuq6aL2ZtjVGxZsXJ5rjUzQ1/PadLRilHW/A6Nh/v6xQSvviiGnbJ1wnbF3Gl15ToX
 WDbBrWQwa9GCWd1YMTRBvTfLwt9zC8Uxn/WYzh8Ny+ftzuyZNDsT0bfqP0KQuGZOrxCovvFRUoM
 yynbAbM72jeqov3pkHaSg+jsCNSXamgUNTHJRMpNDF8TlVbDtrL5hsCScq6gE5HuDQSEn5jenKg
 GyF8JzP6KqAV+8FHYti9Mvi2ASKT0mkYfmplC5Er8OVIslCWeCzwkKXSsKTO8Nf/UzpMDeL+rdz
 ZT6r+XAnDMuE3K4kijFsBaTlcupCUj1l7xUWEzqErkAC5B0f1ItMyEvHLduGkl9wtNSZcZENAfN
 DMTrF1a+d9zHaN3CrxKSCO2vJVh4l9M87LPc4VD9/zpkuIMhG03cZMc0KiQloRJXJRPbFuk9Nn0
 3eL+BUXhfhXvh0PEayVNO0kcVlWT1K9OspEg+GWhTTzDFS1KxZ0IlVNZ9FhtmW5seOciKOH2g=
X-Received: by 2002:a05:600c:530f:b0:47e:e20e:bbb2 with SMTP id
 5b1f17b1804b1-482db45dc5emr222739535e9.7.1770131218252; 
 Tue, 03 Feb 2026 07:06:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482db623407sm154182265e9.0.2026.02.03.07.06.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/30] target/alpha: Do not use target_ulong for trap arguments
Date: Tue,  3 Feb 2026 16:04:25 +0100
Message-ID: <20260203150436.71907-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
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

%mmcsr and %cause are filled with @trap_arg1 / @trap_arg2,
both declared as uint64_t in target/alpha/cpu.h:

    229     uint64_t trap_arg1;
    230     uint64_t trap_arg2;
    ...

Use uint64_t instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202234550.34156-5-philmd@linaro.org>
---
 target/alpha/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 126a53c829b..2dc52cc4465 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -129,7 +129,7 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
                               bool maperr, uintptr_t retaddr)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong mmcsr, cause;
+    uint64_t mmcsr, cause;
 
     /* Assuming !maperr, infer the missing protection. */
     switch (access_type) {
-- 
2.52.0


