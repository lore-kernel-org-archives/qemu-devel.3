Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAAFCE7B06
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smY2f-0002Cr-SP; Fri, 06 Sep 2024 08:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2H-0000e8-8V; Fri, 06 Sep 2024 08:25:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1smY2F-00023T-OR; Fri, 06 Sep 2024 08:25:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-715abede256so1593260b3a.3; 
 Fri, 06 Sep 2024 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725625553; x=1726230353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JENbbTmp0ErxcaPJIt5HfkB82B17/9dJt6qjK1TiuG8=;
 b=OUbTWr0MNgceh3DF+or4WtDwE3a/25+fJczozx0RANRFTqkXeXeeANoM+e18tvlF5E
 rcSVCCju+klwvjrukpU5U3E4IMVvQy3Bpa8OdLGihra2oRgrz5tBWkEjhzt4vTxpTEul
 BWMEZVWu+JfTgxTg7Xht07MGr6yxa0SoVNgfFmoGKg9EWFWFLnSc2RufPhArumxg9YLg
 GuK9BWf/bVJxszHTJJ3vZTjoAG4oT+TAy0SFX3SndMvubZqbePdtSpwNq6vZ22i4nU+V
 Yee/2QonY9EGsTBY3BPDAU5IhlXK+o+Gy3V8Wg9w6Y04pjiA32qAce5snMesjqasbvO1
 30Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725625553; x=1726230353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JENbbTmp0ErxcaPJIt5HfkB82B17/9dJt6qjK1TiuG8=;
 b=ibDHeIIwGgqSRWje4oFy+UVoNV5S2TXeHzdwRMI3lcW0KRCNLOia41x/qNQ3pjiqLv
 BuY65YiwZJmxBbI6cB8nYehEY0aXSMSwqlaQNGQkvGgY4NwFqxKM8mRqbM3dz1k0GgPk
 05GNtM7yvCCXOob7EwvaAP3uSh9+qB/HsGOczBcM/e5T/ypnjc/99MO/HDS44NJ8sl8I
 zeA7ErtgW9/mgiaOA0fxfc6QqYdkxkGvp/WbH4RRLxLauUHRW+TGoYnq+HCvKM3Jc8dP
 v6CYc2Rq9OJGdsFd216P8UbPyLP12lcpSbP1fu+bKqLvE8kAIpFNBeprcrL6YLQlAN88
 WDYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHmyGLku/xm2ASsiMwHarlTXIt8TG7fPzN8SkhvyT0Oe7ldi3g7p4cWfOGKl1HOsYcOJFfC3nEZw==@nongnu.org
X-Gm-Message-State: AOJu0YxHWaSHw4s4cY9ZXxZvnK4ofTjwV+3IbYUZlHoPPazgH7s+wwep
 TACiT4YMuhMJFyAm6QlN5DL3lM2Trc84X69BmX2XklELYVr7V+tCnj1VyA==
X-Google-Smtp-Source: AGHT+IEhF9u5XlVD+RNYl1g4TPFb6a0LMu2htuY12ww47ACCVwiBqzuCaGuA04SRXtdOMZ1o5JgVZg==
X-Received: by 2002:a05:6a20:d98:b0:1cf:1a3a:9016 with SMTP id
 adf61e73a8af0-1cf1d1f86e1mr2314817637.47.1725625553609; 
 Fri, 06 Sep 2024 05:25:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718de738bacsm314951b3a.105.2024.09.06.05.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:25:53 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 4/8] usb/uhci: enlarge uhci memory space
Date: Fri,  6 Sep 2024 05:25:38 -0700
Message-ID: <20240906122542.3808997-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906122542.3808997-1-linux@roeck-us.net>
References: <20240906122542.3808997-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

hcd-uhci-sysbus will require more memory than hcd-uhci-pci
since registers for some hardware (specifically Aspeed) don't
map 1:1.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-uhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 68b72f8d3b..d2993a98b8 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1212,7 +1212,7 @@ void usb_uhci_init(UHCIState *s, DeviceState *dev, Error **errp)
     QTAILQ_INIT(&s->queues);
 
     memory_region_init_io(&s->mem, OBJECT(s), &uhci_ioport_ops, s,
-                          "uhci", 0x20);
+                          "uhci", 0x100);
 }
 
 void usb_uhci_exit(UHCIState *s)
-- 
2.45.2


