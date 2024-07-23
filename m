Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE3FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMKN-00013h-7Z; Tue, 23 Jul 2024 16:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMKC-0000Rs-QJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMK9-0004Wp-T0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:32 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso44709865e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767288; x=1722372088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gprouXpFTSkljW0fNmBZHXNIbVMVrEajPZ/PMlUZpW4=;
 b=DCgCY4lFJqyW2/j+2R4OUJBPWvR1NqqDVmNPwC1SKWeBMOnA5nGevD7f4GVpOS5V4K
 c6LQG9YDq/k4sw5rKSZuUTTNENresb8REaehnrYMsZTP06eYjxEuwRz5/4lajj1ru0ws
 EUm2P2e+KaSXMe9fgTp73Yid42qtvvTVG4fA8aCU7uuju5dkSTcod6mm7olXI2zkb8fv
 EqscqKVneYAqCCEujEawZpoVrPOJbP8Rb/nNJ7C6K5eHPdStkiYc0+7jWjxV1l72rlpH
 x+pZpuZFB2QQM0ixHZvHOMy9BybIQQ4SKZ3JXVXTneTCH4cKuYHTpwB7oxlBvkKh03FZ
 b0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767288; x=1722372088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gprouXpFTSkljW0fNmBZHXNIbVMVrEajPZ/PMlUZpW4=;
 b=wvoq1NFBrPaxxcSaIHwQL49bNbcgHHTcNPY3KzPgbIENna/D00ggQluf52whSPdMTn
 r7mjyqnE6PeIWIHJ8rOdxxmCJehwcm1SjQ6YtenFJOTShaX0d0GUIRBaX2ZbsCFYzetL
 VnPKqg2aV5Lt++f/xxZoerZqssObUleL9cOlpgmBoK1v6G4l1QoG9RuAcW2lsnJnB/LQ
 N5ODEnZQ5dpYeYwmSovsYJaV+Le2FBZIKnEmUgC+9vR1zilHt4IPoDS5JEE+U8jrENIL
 mj0UnZrf1yJV0pgVby8m9AyKOYBQp0kyOc5jNCF8T3Z3nFznQCkWgvWRm9EBPG0rA7bT
 X+Qg==
X-Gm-Message-State: AOJu0YwLYsFAe+q7A1/3oliN2oHIPN8nOOzau6O8OmMWqY1UzVJSNScw
 uQmYgB0W+3sNL5PCOCeWWrpHIYRMg5GQ9rGAM5gH33C46gkwMNjPXGExC7DeVuluSyqx9aticA6
 MqGE=
X-Google-Smtp-Source: AGHT+IGiDgdAWIg4VrTnbBjRYQpLqUvmrwzZjhT+ICZaYsC66LkIktXdT3qObDI0GSnwAUR167wqwQ==
X-Received: by 2002:a05:600c:3acd:b0:426:6f1e:ce93 with SMTP id
 5b1f17b1804b1-427f95b36e9mr22755e9.33.1721767288063; 
 Tue, 23 Jul 2024 13:41:28 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f935dc1bsm601145e9.6.2024.07.23.13.41.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 27/28] MAINTAINERS: Cover guest-agent in QAPI schema
Date: Tue, 23 Jul 2024 22:38:54 +0200
Message-ID: <20240723203855.65033-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240717140025.66397-1-philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5ff6c2498e..8c048782a6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3218,6 +3218,7 @@ M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qapi/*.json
+F: qga/qapi-schema.json
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QObject
-- 
2.41.0


