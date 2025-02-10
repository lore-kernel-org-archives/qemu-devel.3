Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067D7C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQzl-00017i-Fo; Mon, 10 Feb 2025 05:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzh-00013Z-6H
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzf-0001hI-78
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso46714355e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183181; x=1739787981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaWE2enR8RP6eZb5QQCWKwDbX9Xg4pAo/h8gHd03afQ=;
 b=WHtnX7TV2nhIeAMPoPfoRXK+Fu25+WC2SqtXBSrkIXGR2K2BRt5sbMtBcrcgxKAI5U
 xi8sMqx5rEKd4XRLZS2L/OY1XdN4S1CR8xLPjvOiTtuQ9GhfrPO80E6AHSKkKwvJxFVN
 6B/7gTdvOtcY7aoG+XelEGIuWbIfDCZhQPm5rgdy0WTNcmOAgr3UxlNOif7SreQlMvxR
 ZtE7SWB6b3XKC2ek3wnagglyoWKcdh/qrqPmYKrtUDjDpbhyzQFHPeQ1RqiVvj6H3Mfc
 AcPyUegWU4E6bY+0wh7Oa5d3/dXEIk7vHXPO88NYDPSircCqBZMVBwx44wnoWpOMOvZ6
 KDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183181; x=1739787981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oaWE2enR8RP6eZb5QQCWKwDbX9Xg4pAo/h8gHd03afQ=;
 b=RyhTb3ilBaC8lNzd7xcg1ltfSXeCBiuXt5HyoH1uywrDpZPw9GEcpyg/lpRcsy4XOU
 vMCmXea7L690PfokvQWzJuRmrPGWj5Ey824Fof/jynpWne6noSBMhgFZPeRjzv1d1pNm
 ru0YzgUgVOfGgn4J1pMyJ3pA9WjaLH9S+cvcGRjIHugt2ykI1iZGN3KduibkW0oka/Mf
 7NeF2SlG/FYFjgrgx6raDo6CGFS6/8xtXUgpGZIoX4ZybHZS3Du1lHrUp5kRpfkRl18b
 VaD0/yJFfZFVNYR7/xDKF2P66sV+VgN2Rwbk2SbTrMubygae7aqYlm7qUUy6AZ/+Vu0z
 VIvw==
X-Gm-Message-State: AOJu0YzyAaOToh3e+R5ZNS1xOoNrYVBkJ5OlHm8pK56IYRr3YuCM+ZJ8
 sXxtPSyWnaLLnXhGJr+BPeyR/5YRYBu8kLXHxc0g/958Tkmj2bcw0ffvMbgXK4LFoNo32O+WE87
 dk50=
X-Gm-Gg: ASbGncslnFyn5FR91LRlq6stzOZuXbXNWJ72Bv4D7UlWpHg3brQgpiyVEBQwxARKLxA
 WH1TLeDdHrqkwD+NqYScCfjQ6X1NRu3YtNolt3pQuPk4uJowddZL+/Yn+XPim8Wlqo8uKuLk5w4
 34iz4etK5pfFmKH+V7pxZpKX1K/8QnlUge5eGozH82Hzi9mXtWKXRG8CglHbmqNW00JjkJUVYhp
 qNhKmJ5bJ4qMEqUIG2ESBCE0bz0DWEV7gmqRyUXvNOHT7HD+MTNEw9fjEF/v71dbf505p4CX5rH
 M+XrKuK8AkgsUjxHmLPNwJhCJ8Y0s6ICyFs++Pe/+YRQ3KLazB56/HkVE060cYxY9hp3E+E=
X-Google-Smtp-Source: AGHT+IGRYR5sVUYDNsUpq2FbZZ0qzGRmtDciM8Es9AJa0HRq2hCcAb73CFdwvsTmFptOznMijQCkOw==
X-Received: by 2002:a05:600c:1e0d:b0:439:4827:73d with SMTP id
 5b1f17b1804b1-439482709dcmr12580945e9.18.1739183181112; 
 Mon, 10 Feb 2025 02:26:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43936bcc04fsm66245805e9.20.2025.02.10.02.26.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 02:26:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/10] target/xtensa: Finalize config in xtensa_register_core()
Date: Mon, 10 Feb 2025 11:25:57 +0100
Message-ID: <20250210102604.34284-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Only modify XtensaConfig within xtensa_register_core(),
when the class is registered, not when it is initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 2978c471c1f..c4735989714 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -173,9 +173,8 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
     XtensaCPUClass *xcc = XTENSA_CPU_CLASS(oc);
-    XtensaConfig *config = data;
+    const XtensaConfig *config = data;
 
-    xtensa_finalize_config(config);
     xcc->config = config;
 
     /*
@@ -189,12 +188,15 @@ static void xtensa_core_class_init(ObjectClass *oc, void *data)
 
 void xtensa_register_core(XtensaConfigList *node)
 {
+    XtensaConfig *config = g_memdup2(node->config, sizeof(config));
     TypeInfo type = {
         .parent = TYPE_XTENSA_CPU,
         .class_init = xtensa_core_class_init,
-        .class_data = (void *)node->config,
+        .class_data = config,
     };
 
+    xtensa_finalize_config(config);
+
     node->next = xtensa_cores;
     xtensa_cores = node;
     type.name = g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), node->config->name);
-- 
2.47.1


