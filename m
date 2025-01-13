Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362D5E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8cq-0004OC-83; Sun, 12 Jan 2025 19:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8ch-0004L5-Eq
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:10 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cf-0000hv-UB
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so25920165e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729284; x=1737334084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTM7kJDrHWUpg1IPISR4zuSM03kjMUv0Xm2Dmwxq0M8=;
 b=I94hz7W/6SE8qe1rkv1PNARVbvtvpPD0sYWfZNtv+ITBepGr4FfrQkc2QGC+wiy1Tr
 3SAo5XE3SlCcO2D7d/Pln1BI/YEGO+zU/1LdltcLOZvb6zXB9eZa3kIdhxxe8XK1HpYw
 rGyidsKkbOAv9K8Wl7TBb83gDfbbXrvbQq8yZl1fGhrkkU/b6k22Gt+J/y2TUSxNv2eO
 G/q8tN0WDdvl3j0xPABcVTOaY7G0hODDtYJtQ6EKxLl24MYx6DZffYMKtG2bySCOnNCG
 FHUAtn66CvcQO+o6PZFI0gLRKp5D3Q1NLxA8yEQPshfx4j5gXnoK1LOK5lzpKDeGlnVJ
 pP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729284; x=1737334084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTM7kJDrHWUpg1IPISR4zuSM03kjMUv0Xm2Dmwxq0M8=;
 b=hp5gXJRcYHEdU0qwuHGmHJHGaS9GtShpkblhLdWJOjIY2l6Ym9TIKbAGAwGQkbYI1J
 kn7sEcnsmlVzY1EemTaK68MfSo9DnoTix+qDZKk6Lhk2VeSsanvh1cFeaD0tNP+wemNr
 qI7h8bygddib6RHsZo/QV2MTJnh9C2A1xPUYA1tnEyA/G6dTT7EzH25HLCOhdjIJRJCI
 h9cXgiIafZD+8x2IdpYZOiXQ7WVhAWP+aZIxbWWtlY1FeHktcaYyxEJtmkF9mCqqeDad
 z9BlmnNEmIrC4m3XC69Fw/sNLw9xmLws1v/jBikimbti+u6K4XECU7eYO3VE33+qeL02
 HzNA==
X-Gm-Message-State: AOJu0YxPYbbmvgC/JUwB1FQW3bntQAnTvFE8+tBUeXlEhsk5iOER6JU3
 UE/HsLcPNj7m4X3QeFTuvRR25KkaDbjoF11xoztOONZxlbMNGJIbe+OZAbp3ht7w0O47zCcI9yO
 0Kf0=
X-Gm-Gg: ASbGncu9P6+d9KfZ9SOVExF0VEep/4V46wL8LwUjzu8h4WjmONLRD4f+Kfe5WiyE50K
 EI7vTts74V5tFW61df5gAzESrG9AUiUfHhRGWoMbLElLZJgF9YebIOG8Rq5KkoyJLWAuCrW3oI2
 4sBJ23X+g8pIGr0NZJ1zK7JgIG5yBu/9rErSpBNhqPA3JE34UrCftbqHsEOcQ1SqqxGl9+Cdz7I
 2G9BqdfEfU1JX6k6TfUDe8rVtzGCVRTdChhIhBRfXaZXDV6iMZmM/anlhX+aKZYwcizFkHiCXpJ
 SgawtEPeXD728PAJFINrD9QyAoqqQIY=
X-Google-Smtp-Source: AGHT+IGPNvghNoLav/7tULeW9u8/ZyY6giLCCwLq1fA4kzsHI7DEgNyNdVkiE7W7UvQlMqZ0uv/ubw==
X-Received: by 2002:a05:600c:4455:b0:434:fbcd:1382 with SMTP id
 5b1f17b1804b1-436e26a80b6mr184763845e9.11.1736729284133; 
 Sun, 12 Jan 2025 16:48:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8bea5sm160710605e9.31.2025.01.12.16.48.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 02/23] hw/mips/malta: Check CPU index instead of using
 &first_cpu
Date: Mon, 13 Jan 2025 01:47:27 +0100
Message-ID: <20250113004748.41658-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Since create_cpu_without_cps() creates the vCPUs iterating
up to the machine SMP count, it knows the first CPU is
created upon the first iteration, at index #0 :)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4e9cccaa347..37be2330eda 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1042,12 +1042,13 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
         cpu_mips_irq_init_cpu(cpu);
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
-    }
 
-    cpu = MIPS_CPU(first_cpu);
-    env = &cpu->env;
-    *i8259_irq = env->irq[2];
-    *cbus_irq = env->irq[4];
+        if (i == 0) {
+            env = &cpu->env;
+            *i8259_irq = env->irq[2];
+            *cbus_irq = env->irq[4];
+        }
+    }
 }
 
 static void create_cps(MachineState *ms, MaltaState *s,
-- 
2.47.1


