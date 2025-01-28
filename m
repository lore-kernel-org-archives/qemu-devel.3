Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A64C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxh-00025h-PR; Tue, 28 Jan 2025 15:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxg-00025L-42
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxe-0001ZQ-EN
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso64495535e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095205; x=1738700005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KrludJeelw8t7WfACCxjoGW3Sdcn7j7Tu3Qi7W2JqPY=;
 b=k+EtdDZ2pNhRaN1dk6c2IR5NovvueQ11ZFTDv6nbtb3qM7Vle2VHebOoiblvYRAR4Z
 9QwwLpQ0ynac0eu/Bx7kKSES6nXWmHYa+54Bhk6Ad5AR/VzO0DzuFyGVYcTe8cxusana
 IK+oFlJemSgkcYUsT0H2M9rrRoZEw3q8YvELgsnGHthPQxlqyA3n+NHESNxJBYTgRk/m
 oXdLvdr1SeKKnZD8Goont9VEdY+1Sopuy89U21pT7JF8TD38k3Q9fKGHxVl/uEySKWYk
 YV9RzQlkgC8B3uqeAt1AQjVD5sZNHaNS6DQ/YCUli7K8U5OFcmk6HeMQEZjLG2/nk2ck
 Ukgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095205; x=1738700005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KrludJeelw8t7WfACCxjoGW3Sdcn7j7Tu3Qi7W2JqPY=;
 b=qyJHyzfFq9LeambyC7qZBTjO84QqcQ58wZmVn/M/1Wyxm2KD3OGWHNT7smbn2M8Mc3
 /mRa+HzMkOd5DuNGSKQC7VSd26g4ct4MfZ8QiNNfNObFX7t+lepuAEBR3Tw0sR17NOzF
 OXdrOu6vJyg/EWxfdkUImIvS9dQd+OVoOxbABfy4rMTA7F7xLLk20QSIMyWkBRy0mbmx
 Eznxpmp6v/5I6YdVqWzS+wPJaEHzV2xz+oe+f5rJKotELG3QEJWPj490e7c8jUrFg4dL
 Ve/0Iatd3MVAn/sTcai4Qi9zEUjWa9OUNGc6f2aQervHST89i9Xhxby7UOpywCHYAw87
 tRzA==
X-Gm-Message-State: AOJu0YxhjUHKpmEecDPfL+f1r//dKWD6PxtF/FzlNoj1EiiDeVKsEvFD
 1eOHOb4QETyDa9DXy9EH2a9iD83/WmXO8oeQkKvhnv85FSWM1S0ctDE58Y/wZ6KPVWpXLTEJ2kE
 f
X-Gm-Gg: ASbGncvFJ0pVrdXdaU+yN4owmDudr5oPo5aqQ2pj9maM6lWoRhelCrqYH9tfMx/zCAp
 FTadtdm1lsGsS976L0EXpNTMIegt0G/VUEMD42jAh0N5CaGoA9Zpy1uHhluwIv369YG1Yeixzxg
 6S8aBpZ0WUkVen3L0yPeIokVDZpH3GY0XD0l5UyZFM3ZogrvXjHkB+A1DCBgzmQj7cabkWu1Aru
 N8Fo8I26me/DddjvZ4KDe9rJt2+2j0oDUMlreZIuVUj0YP+AR4CP8JNdzF4TMlhQ7Fj0jwqjIaj
 KwI0/BQBuQfR99hAmSus0g==
X-Google-Smtp-Source: AGHT+IHUqD/RIuKD9UFbg6vV23vlWkuycHk8mSje4Fctqz/Whb0EgJwOj47CNZRJV3mnLsKyzGzh5A==
X-Received: by 2002:a05:600c:19d2:b0:435:330d:de86 with SMTP id
 5b1f17b1804b1-438dc34b37bmr3005425e9.0.1738095204870; 
 Tue, 28 Jan 2025 12:13:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] hw/arm/stellaris: Constify read-only arrays
Date: Tue, 28 Jan 2025 20:12:46 +0000
Message-Id: <20250128201314.44038-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250110160204.74997-3-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 3f525d2dcf6..42498cc1e53 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -101,7 +101,7 @@ static void ssys_update(ssys_state *s)
   qemu_set_irq(s->irq, (s->int_status & s->int_mask) != 0);
 }
 
-static uint32_t pllcfg_sandstorm[16] = {
+static const uint32_t pllcfg_sandstorm[16] = {
     0x31c0, /* 1 Mhz */
     0x1ae0, /* 1.8432 Mhz */
     0x18c0, /* 2 Mhz */
@@ -120,7 +120,7 @@ static uint32_t pllcfg_sandstorm[16] = {
     0x585b /* 8.192 Mhz */
 };
 
-static uint32_t pllcfg_fury[16] = {
+static const uint32_t pllcfg_fury[16] = {
     0x3200, /* 1 Mhz */
     0x1b20, /* 1.8432 Mhz */
     0x1900, /* 2 Mhz */
@@ -964,7 +964,7 @@ static void stellaris_adc_init(Object *obj)
 }
 
 /* Board init.  */
-static stellaris_board_info stellaris_boards[] = {
+static const stellaris_board_info stellaris_boards[] = {
   { "LM3S811EVB",
     0,
     0x0032000e,
-- 
2.34.1


