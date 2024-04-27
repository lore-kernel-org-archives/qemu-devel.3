Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE76C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kRZ-0003Qa-2B; Sat, 27 Apr 2024 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRW-0003Eq-Pw
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kRV-0005ai-46
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:58:26 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41b2119da94so25313365e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233503; x=1714838303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHvD9/OzQTcoYpYvmX9pCrDnTY/ZLkEX4YizKfP7T1c=;
 b=RRbsoW0YFPXj5CdGRDVoesW58dMXUSoBCW1lu0FoTtAmcq/rtMeR2rG3Nswz9xCHY0
 OuNGvGlOYe8qkE3mb5gHEbAagMxaKdu6JuSaoaQ1zkP6t+FJe401TQDOlMaTJir60xwC
 /mm6w9myOFFMUB74XQ4RMMcGKA3Y+mGj2bpimUW/4X/eTgD/nfdQfvrHb35+qlH4F+er
 fBN+lCHheOJsmw1YpvwvJPdicjL7Rf6daiYAIYfZE3tVBlbfXb4uqI6Z3JiAeCeZxzTJ
 dEYfQgpRayuvE9e0yhPV0Nn4Y4EUzmyQg5cTInqvwZmfZlrThwIUKq1ayLjc3oKWyQIi
 ZbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233503; x=1714838303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHvD9/OzQTcoYpYvmX9pCrDnTY/ZLkEX4YizKfP7T1c=;
 b=pdaGoK20Xxfg7j6VJ7V6E/PCe3yXV2pyzNKWFQ8/5jhV/vbRvCeYCloMZ/zdCn5ee3
 PP5FknmeRK5KjGCE5KqMI/u/tvAOiED+jYh9L64rPfea7RiTUh1v0mYLWLENwnp6GXpq
 ND99uUjbhJnqmSZAiFRDeYq64hAt7gJjGsF5WCooc5FfwvbAhj71/LxFEIMHhLi5/2q6
 SPLirYL8TccSz1cYQPX3g/Lcir8VZVpPcJmRHcDOBKKXfQTZJVByPQYS/VCNRZW2TNwK
 l+VPFaiX+wiOd+Iz+tM1xL8HJ3FDlLVDt/B0J7PyNQiNpspS/crEDlfQmiTSnFnMjue/
 S8Xw==
X-Gm-Message-State: AOJu0Yy3TAs4bh4d6H7nNEYqrwCLmuG6BIUkKQhK03E3JtVKD3UKX1ox
 Un5v/uGxw706daffLTsFDOEyau4V7uTBwjVV1u70OHO5kzGlDR1RY/fhy5rpA5v6SAcs7W3Tv8V
 tqP4=
X-Google-Smtp-Source: AGHT+IH2USQxoSZcRcaeV/uYICWGQjeN4SgPbr6+sScpFER3ji95pUuM7lIzeYw1gWjOAGz5pyI6ew==
X-Received: by 2002:a05:600c:4e54:b0:41b:d08d:dce4 with SMTP id
 e20-20020a05600c4e5400b0041bd08ddce4mr1541110wmq.5.1714233502932; 
 Sat, 27 Apr 2024 08:58:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c458a00b0041bf512f85bsm1143245wmo.14.2024.04.27.08.58.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/14] accel/tcg: Remove pointless initialization of
 cflags_next_tb
Date: Sat, 27 Apr 2024 17:57:12 +0200
Message-ID: <20240427155714.53669-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

cflags_next_tb is always re-initialized in the CPU Reset()
handler in cpu_common_reset_hold(), no need to initialize
it in cpu_common_initfn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index a72d48d9e1..c4175cc4b9 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -255,7 +255,6 @@ static void cpu_common_initfn(Object *obj)
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
-    cpu->cflags_next_tb = -1;
 
     qemu_mutex_init(&cpu->work_mutex);
     qemu_lockcnt_init(&cpu->in_ioctl_lock);
-- 
2.41.0


