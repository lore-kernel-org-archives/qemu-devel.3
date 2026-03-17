Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2181FEDA03
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Z2O-000125-H2; Tue, 17 Mar 2026 14:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2M-00011U-5F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:03 -0400
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1w2Z2K-0002rs-OZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:21:01 -0400
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2c0e3a2605fso718443eec.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773771659; x=1774376459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=530Uj1XxFv4n0VaFgxJ0F6ngR3XyAeVR0aKHfSOSPFg=;
 b=FQyL3MBqNoalH2fAD5oCrNYYkKc4L0XheWxeKepoq/fJ+vyHagBe/8cXbymqA37zcQ
 OJRUdufwG6MPZTvSX46Seq/YeKoMhAKeOiyShrSQKr6qUqXM8jSDMMLd14xfMFOHl4yq
 QHjGm6XpvB6ocTRmNNVRss50moVuKWHqpBnr9liQe1yWB7pm6VvfQEwY5Hwsira406hF
 UyNW1OHmwUHmMigfxDqdZjdXful/1rKco7b5+HqM83HVw8hww1yty0W3ZNKv6b7vpmTP
 L5rv8/3VsWlhUSvIjXGzW6MshU5JdAX0aQ8cerw1eqPFUv4HjG4jJIFmUgXBTOcJkFoS
 gi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773771659; x=1774376459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=530Uj1XxFv4n0VaFgxJ0F6ngR3XyAeVR0aKHfSOSPFg=;
 b=LgIDe0yxN70b5k4GGxKlK3mlj18Qzh1yzQWDbGlFxo0v6welWRrpvnFVDpdoF2w3R9
 RaVjDtTMoQB98X4Aetmj0udXVab01JuKLiiHh8YI2sz1UatBGJk1b7KWNcPfnszMOt2/
 wtT7zDUfeydRw/3eITLGOEORFhVEnKLbP1AcC+8cGsDPhE0Uk4VO2lRmCBGPNbR8fYXq
 zm+9RLu0lFO8TJDvTvmYJDrJ0R8CMT8oCIRn2zJe04GqEru8BQBb+0ZPF9i5bAp28nC9
 P1oi6DWPFrfJElhQc659RjHn7s5pa3T/5/PdJBjl6RRveXFTZM/kOTdVjNuoNeCtCX+r
 ZLhg==
X-Gm-Message-State: AOJu0YwNxlyEGbFM2GsBHoXLfgV3Nszg4be6TR76rBOJ9nV96ViJ/25K
 BWeIJPYWhlFpWyMEJNb9FC+zVtRSuftUJCYP2efPjARWZ4lEEMIXcDS3BHrRo3Pu
X-Gm-Gg: ATEYQzxKD9eBXYdlaH543xI97MMI1xtEIMI+9itJrk2daotA1BkBihhBVmuK0Qu82J6
 T/ykkqRKcPctHWHP3JpbHxRLBn+9j4+8dJJbO0aX5YnUvUmKXItwUiALpimbEEBrUAFOR/acvnI
 RuAFeIXRTBoYv0o/sqj/I74pyT+Q12SBefsNtbwDMBw5MKq7bG90H31luRGmUpmO/B7HgJWOGar
 r77W01YY3IceO3PmqpihOURuyUKXR72NCrFm2OqyFlCb/1TmmFlGAdNaHyDVBTOcLQXso+OLoZJ
 O7ombCy4WXnGI+cQvF5Wc+4rIsLbD6TmUAneJqmwpy7xBG53245kZh7U3veadT0oAsMdAhXGVWa
 CROsTNY3mXxfwnugVYQFVz5fJ53GaB4dppgptJjTfNw/aq2g7aiAF7BhwBZVJB8AuD9+oyYWgak
 sE36bm34ODD9qZE9F/FkGN2ptds9/ZeEZ5M9qQvpZ8wPCYQixbI8EGUM0dYmuFIpU=
X-Received: by 2002:a05:7301:1699:b0:2b8:30b8:58cf with SMTP id
 5a478bee46e88-2c0e5010124mr237601eec.8.1773771659097; 
 Tue, 17 Mar 2026 11:20:59 -0700 (PDT)
Received: from localhost.localdomain ([143.54.78.51])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c0e55a53fcsm457367eec.24.2026.03.17.11.20.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 11:20:58 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, dmitry.osipenko@collabora.com,
 marcandre.lureau@redhat.com, visitorckw@gmail.com,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [PATCH v5 1/4] ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
Date: Tue, 17 Mar 2026 15:20:46 -0300
Message-ID: <20260317182049.33848-2-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317182049.33848-1-lucaaamaral@gmail.com>
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132b;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x132b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define GRAPHIC_FLAGS_VK (bit 2) in the console flags for future
Vulkan scanout support.  The compatibility check currently returns
an error indicating the feature is not yet implemented.

This prepares the display framework for direct Vulkan scanout
alongside the existing GL and DMABUF paths.

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 include/ui/console.h | 2 ++
 ui/console.c         | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3677a9d3..19ac06e0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -361,6 +361,8 @@ enum {
     GRAPHIC_FLAGS_GL       = 1 << 0,
     /* require a console/display with DMABUF import */
     GRAPHIC_FLAGS_DMABUF   = 1 << 1,
+    /* TODO: require a console/display with Vulkan scanout */
+    GRAPHIC_FLAGS_VK       = 1 << 2,
 };
 
 typedef struct GraphicHwOps {
diff --git a/ui/console.c b/ui/console.c
index f445db11..424ee195 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -594,6 +594,13 @@ static bool console_compatible_with(QemuConsole *con,
         return false;
     }
 
+    if (flags & GRAPHIC_FLAGS_VK) {
+        /* TODO: check for Vulkan scanout support in display backend */
+        error_setg(errp,
+                   "Vulkan scanout not yet implemented");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.52.0


