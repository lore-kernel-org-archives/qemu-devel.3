Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EADC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOT8-0008GD-PQ; Thu, 20 Mar 2025 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOQ5-0002pn-42
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPR-0007DL-8h
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225b5448519so25995175ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509838; x=1743114638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3u7WNnidYvKn4+ZIVZ2UCzTlyZ6yVz/ThCJ+k4BRWTw=;
 b=AYckVZx3EakXCcW6uT0Zf+vZOjuwQI110B0LHw5DWL/z4WsqEPj9zLPtEHycolh/PD
 upVqXNHJj2x+qZvrSMjXkSNLH0aFvjfdo3s1ylkMxSjjX8tE/71+fvc16ETinUYkIrmy
 WssYDDanFppJ94q/ubRZgwedphXY7m/JA1i/TsX4EfMd+UX6QMbtq0mrGq86L6YnJDsO
 p96noNB/OsfQti7/VRgYknv2hpcXpTLt0pLLXFslUAQWj8XCiDqffMB+XBgOVpEq9wkK
 XOQf0nZdu6zfZJE8hnDOopu6viPq7mCXe5bmDKY0WFQptepGVYxwadrY931gCildrHU1
 +n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509838; x=1743114638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3u7WNnidYvKn4+ZIVZ2UCzTlyZ6yVz/ThCJ+k4BRWTw=;
 b=S5TJEuTkMIN/BxaY/wHzkXNbB6g/CB8xORNem+tcLoN/P0hbKDelqFVut1Hv7P7FS+
 5wPI47IwrzZOOCW7RDQb5IaG8aE5SUw9Io+sfM9CT1neSTUJKY+/k5zNGZHB7QqcHyy8
 NN91feRUQJO75DjlPHxzwSwXkhF8hl4kkY+/OYv7M5JESLn7gS6IzGvDGpYg9lqx7nNk
 8o7FlppaeN3atKQWlkZV8X1y8DW92Ig6hw5nPcYb6Ks9a8Jr/QhdfyUJhSQt46nI5NLH
 9W2EWaD88APRgTR0eGGf3sqllEQRjCZ5PmbNckICD1r1xeJFY7DtrPZO96QxoqN5nDig
 Rivg==
X-Gm-Message-State: AOJu0YxpTgRHFimEQhiBHrTie76hp7Ua2eWI9WOQzy4VykLFMNFvIiPg
 2cogEZWdd/oWLP+ZBjI2zek6zIAgutW6hVxu9xBGbRgGuciExUND0C4ioifgpSkDSK9YXRRLz5D
 X
X-Gm-Gg: ASbGncuUjO8DnLJjBsXQR0nMJehcx3fTjztMQpHP/I0/lGHB9USbKTlBSFa9B+XwUZh
 k5j8NwZx7zb63k7y0kSlPLjl4B6Fu4R0TU4q5bZK3bG7A1iA4eWgXLj4VjYsQ3lFh/bbjccRxgd
 BbbYVHs3gtxa2h3TfRbLK7UuIuEEoJhdOcfjw0M8v2tdrWhN/dhZkJnsecJp/6dxzlT3Qe/kMEq
 Sqey4/HbBqxY9u3DVvkJliRw8NleLB5tMWqllAhJmBvfp9ailJbYc/RDQCWQJ8UALBkuJLP05Nz
 3sDo6UAvlf92kp38Ghd0JWZGGFs+YhP4UsnY0x9waGwS
X-Google-Smtp-Source: AGHT+IGuUar1bydPBfvUd3+IX5uuws7MRKeT3al1KpzBmkZ8QvPpHkZpK7kYl35m+krx05UHzx9n+A==
X-Received: by 2002:a17:902:ea07:b0:220:ca08:8986 with SMTP id
 d9443c01a7336-22780d828c4mr18233965ad.22.1742509838031; 
 Thu, 20 Mar 2025 15:30:38 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 27/30] hw/arm/digic_boards: prepare compilation unit to be
 common
Date: Thu, 20 Mar 2025 15:29:59 -0700
Message-Id: <20250320223002.2915728-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/digic_boards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 2492fafeb85..466b8b84c0e 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -80,7 +80,7 @@ static void digic4_board_init(MachineState *machine, DigicBoard *board)
 static void digic_load_rom(DigicState *s, hwaddr addr,
                            hwaddr max_size, const char *filename)
 {
-    target_long rom_size;
+    ssize_t rom_size;
 
     if (qtest_enabled()) {
         /* qtest runs no code so don't attempt a ROM load which
-- 
2.39.5


