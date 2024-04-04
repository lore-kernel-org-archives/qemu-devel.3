Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE415CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsT4b-0006ZZ-TD; Thu, 04 Apr 2024 15:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4a-0006Z9-2l
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsT4Y-0000NC-I3
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:48:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-343dc588c86so107202f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712260109; x=1712864909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKv08uQvIwv4CwaxEI6a9mBVsBiKx/3Avu57+y233jE=;
 b=nBTXWU+lNHnQhbi1YvOHsVUtslROe4BkznU2x1aPg6FHbUNOCcaFfkNgzyfAvR9mkr
 WjUlQAUPgiHvNRHlaukNVJh1gOiFd+pF7Bz3UUrEu3JMmPeUSV9ggUlpiNo3OirYiJa3
 suO9+sR9Xkd6Ahlwezv7bsk0C8z09Xl0sCAwFKFeIg8KSDKTGucfX2TzTalqUltez3HQ
 pF4HjAViktDhHBOOwtazAmzH9BcScI7F/WAnT7QQyZ6InTInd/weTo6g/CHz0rtN+W9c
 GtNBRISayy92MKvJl1ysnHwZ743aW4vzZCA05LBHNtjC3LXruY8uspO4W+MVL3PGayLm
 /9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712260109; x=1712864909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hKv08uQvIwv4CwaxEI6a9mBVsBiKx/3Avu57+y233jE=;
 b=c3q1+gwD/gtvnU/g2UNOHx2i0rYTFilQYwWf0HCObVLbYS/RjX5m4arEvnXfX50cux
 FIKlZC8JZx5rFe8SBXmDFq7vgtiFKuf9ligYqI3T5SMjQxOnZjm5ZovZPooilwXAWlz6
 l1t7ajQoMa8GEufgYU608b3ixhaKKxAKEfLp4oBQe9k4oKUJV5IoaVCYIDZ/rIaMxICk
 stxCouNfAlTshD03IF9em325EXR+/P4vvctm+J71Q5+S1BtNOAfFtZesZRniStuxLf7l
 cettSULH4cL6ccnqf6Ej0EVenGdEbAbZMEUmn7flDrmMFFG2CmWiJhaP8zze2ADFxX3i
 +o2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBtcLw1IMOJWcU0vAh+asqXIxypP1KNNyQbX1Ia43H414j6CXQCCQsba+ie+oLjMwLAlbb5Yrq/4Xdwnz1dhlXtc5h2pw=
X-Gm-Message-State: AOJu0YxjqGC+wi7/+XTaFgMXm9fgt4xJha7x2WNkWTfiRUpZVLdTi27i
 zmybcHLgRxhXD5WWfWxr9wVL2S6udGOb7+KrJqrlYrg/eVAgP5N4/m5AYBIgY28=
X-Google-Smtp-Source: AGHT+IGCgOeUIbSaoHmxFbnGP7lqyUDw4wkXpOdiBQH7SbHHONM+fBziqFND6ytRFnSr26QUnsEqIQ==
X-Received: by 2002:a5d:4589:0:b0:343:6ca4:97e8 with SMTP id
 p9-20020a5d4589000000b003436ca497e8mr2590444wrq.45.1712260109059; 
 Thu, 04 Apr 2024 12:48:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 r18-20020adfce92000000b00343d1d09550sm159871wrn.60.2024.04.04.12.48.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:48:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 5/7] hw/core: Restrict reset handlers API to system
 emulation
Date: Thu,  4 Apr 2024 21:47:55 +0200
Message-ID: <20240404194757.9343-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404194757.9343-1-philmd@linaro.org>
References: <20240404194757.9343-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Headers in include/sysemu/ are specific to system
emulation and should not be used in user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/reset.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/reset.c b/hw/core/reset.c
index d50da7e304..167c8bf1a9 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -24,7 +24,9 @@
  */
 
 #include "qemu/osdep.h"
+#ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
+#endif
 #include "hw/resettable.h"
 #include "hw/core/resetcontainer.h"
 
@@ -43,6 +45,7 @@ static ResettableContainer *get_root_reset_container(void)
     return root_reset_container;
 }
 
+#ifndef CONFIG_USER_ONLY
 /*
  * Reason why the currently in-progress qemu_devices_reset() was called.
  * If we made at least SHUTDOWN_CAUSE_SNAPSHOT_LOAD have a corresponding
@@ -185,3 +188,4 @@ void qemu_devices_reset(ShutdownCause reason)
     /* Reset the simulation */
     resettable_reset(OBJECT(get_root_reset_container()), RESET_TYPE_COLD);
 }
+#endif
-- 
2.41.0


