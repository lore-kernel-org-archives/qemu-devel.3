Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4EDC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 13:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXLWF-0000lc-0n; Tue, 06 Feb 2024 08:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW7-0000Ox-II
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:39 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXLW4-0008DU-DS
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 08:29:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so3949428f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 05:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707226173; x=1707830973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xyto0qdSuakUvujUrl1EewzD93xhnNFTVZXku884bPo=;
 b=yQEuNbV9M2kDgteppxDS3TogvFmU99dlPAK1lUg9MOjNUWmmPhADqCrnvC2IXNtuBf
 OFrYbQYUEhxQe44GIeEwXs6EDgxYUvjT0hXuVmccA10dZNziqLiVj/KZ95B8461PCrQJ
 6PAI9kCFUo+AJj8zW05Y/vXOd+bYWvtn+aqfJKaIeYmkhwmKa4ax2AzvrlL6tINa450Y
 buJuMT6D26REGvyFa4iMplxnyop93FZ1lwCOGWSLqWcncSlj9QRQd1MgrxrvoR0y8oNG
 fEaffQc0G8HXSF3a4mIW8rtuXlyIFB3txT3J0ywM6OPmoa+H7y/VFRKsks/PmRG3OKQe
 E1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707226173; x=1707830973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xyto0qdSuakUvujUrl1EewzD93xhnNFTVZXku884bPo=;
 b=YqdnJPf4fs4Iv0MsM0mLanf6LROL6DgsD5pRJx+q+lih98lLwM01srpuMlh3AeXakI
 pVbDKB6NWMnI1VvazhIyoxLDwUWtyA7+p3ZuGi5qplD6ali0pGOp3ifCJ4dbSF6UKSPM
 5m5stYARixVlkAZV9247au1crTGQu5Svz7FeI4cE8ZjExo3o3dJid+F9JV2tQDcu537N
 R0ig13C8zatNP80iCB2HJfXrAdE2T9U0pPXv+f1L2x3Ri5xFg/4yL+DUrCosHt1M9Rrk
 Z8YKvi9tpJj+na0SyPxy9hZVxriVO1mcep/FigcxndMVP0ipef4ugcAKEInFOonxkS5u
 M0wA==
X-Gm-Message-State: AOJu0YzB9lmyCb9KGBqI0AnNe7IE+oNdrT1C7LN18zoWIe+7rd6HCwIi
 PheXmYzuhUsCYKxw2oixCp/NMN9pNY8yywkSvsC9pddaBsSrYZo7qEq5Je8NGFcHQ36RcYqgvST
 4
X-Google-Smtp-Source: AGHT+IF2nime84bexsJ9Epx/LDzynylJDTRvAUqysWEQ85rzmefckrrVvJ0/FqclOYrdLVSKCrn6ew==
X-Received: by 2002:adf:ce0c:0:b0:33b:312:e11b with SMTP id
 p12-20020adfce0c000000b0033b0312e11bmr1218815wrn.38.1707226173523; 
 Tue, 06 Feb 2024 05:29:33 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUEIlGuibX0oEJFSwre5Y4D0Lo8vb16efeRH4uR4uwbYCKpCNJT5mDDAdBRLjv9VBIvgsw7ShJZh+FKvWPrBWV2o18KuME=
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a056000108700b0033b470a137esm1492932wrw.79.2024.02.06.05.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 05:29:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/13] target/arm: The Cortex-R52 has a read-only CBAR
Date: Tue,  6 Feb 2024 13:29:20 +0000
Message-Id: <20240206132931.38376-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206132931.38376-1-peter.maydell@linaro.org>
References: <20240206132931.38376-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The Cortex-R52 implements the Configuration Base Address Register
(CBAR), as a read-only register.  Add ARM_FEATURE_CBAR_RO to this CPU
type, so that our implementation provides the register and the
associated qdev property.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 11253051156..311d654cdce 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -809,6 +809,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMSA);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
+    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     cpu->midr = 0x411fd133; /* r1p3 */
     cpu->revidr = 0x00000000;
     cpu->reset_fpsid = 0x41034023;
-- 
2.34.1


