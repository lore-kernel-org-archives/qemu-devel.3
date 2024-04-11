Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCECCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurue-0002vD-4F; Thu, 11 Apr 2024 06:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruruc-0002t4-PJ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:44:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurua-0004Ip-3i
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:44:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41551639550so53105795e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832246; x=1713437046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zSTvPGfcRjEBEVqiYMcCOTilCqnhe5Ojdjg6D66FBk=;
 b=g/IYJVI4TbLIZNWEaOtyNXFOaUJQriPR0NuDWqHXF562W7r8h4uT0kewQ7GjUp2IpN
 CmwWDW7PcUt+mtLAC7j2Q8gDGXZhqEPq1h9rIL6i2To4e/if2r6MeRhDg9RRXK35NPyi
 xRuDCX7F/YKJN/pfv+7vKnNpK2ux6Y8tuFqkicRazqn5uK28h5BdYhBZyXP6rZY3r8N5
 ZrUx3BBHF9DkkVh9Gm67H+AuPHXtQSROCq1rfLtLuiyTyCF1YUBBePMlbWBYyPfP/fza
 KTcs1+TPCi+PVEzso55hM0FKUFSgtDXAex9C9tHhKyam7HTr5DlFDMWLaPybq0enJ1tN
 51MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832246; x=1713437046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zSTvPGfcRjEBEVqiYMcCOTilCqnhe5Ojdjg6D66FBk=;
 b=tLuuupQfKcDVXPj8y148us6exhJTVjM6Z247toRkD8YRctsg/NykilankRHzeKXnm5
 F8Ci8YXQLcLGg4ITbSja/ckXzsrHEj34A+4nJ3fhp2z8WklqDxMQH2gkPayv2T7GJLXi
 AOkMJREWDaDJjMQfCr1txAsl0KBdOXW6w+dn0K1tMBplXH7yJ5cXjls9yizueurTSjWO
 AzAVNPHrqw29oLbl02naRA28hiCREJ+Ugj7XJX9Ozeu4usX/ugRwfdGh7S0RA9c5iiPV
 jDAh69gzfI9xkozTeiNKBuk21b9Ykr+OUyq3Xp+CEL1T4DLIgY7tQWHXCkhqZU9VwYSE
 eBcw==
X-Gm-Message-State: AOJu0YyGn1+Ct4x/o560830v1/5SjX2zFFUnjqL9EPO6nh8oYyqTkMvH
 Y3LMwrxkCsljGRscswuizGzNQwW8glFJitBjM1J9//cvYSgPJcbfEauE8ldVaVrShUIVt6LDAXm
 W2P8=
X-Google-Smtp-Source: AGHT+IHxWCKV8vYBX67vSm5fYCoJpyfz69U+mU6osVHyQ5gWbl898Jyb5aDRd9nQg5wgrHKpy7krBg==
X-Received: by 2002:a05:600c:3154:b0:416:b7c0:23bc with SMTP id
 h20-20020a05600c315400b00416b7c023bcmr4403843wmo.10.1712832246485; 
 Thu, 11 Apr 2024 03:44:06 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b004171f151a5csm1914852wmo.16.2024.04.11.03.44.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:44:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 4/9] linux-user/flatload: Replace sprintf() by snprintf()
Date: Thu, 11 Apr 2024 12:43:35 +0200
Message-ID: <20240411104340.6617-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411104340.6617-1-philmd@linaro.org>
References: <20240411104340.6617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/flatload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 5b62aa0a2b..b0f04af4b6 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -692,7 +692,7 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	char buf[16];
 
 	/* Create the file name */
-	sprintf(buf, "/lib/lib%d.so", id);
+    snprintf(buf, sizeofbuf), "/lib/lib%d.so", id);
 
 	/* Open the file up */
 	bprm.filename = buf;
-- 
2.41.0


