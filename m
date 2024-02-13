Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA03C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 04:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZkZi-0008V5-85; Mon, 12 Feb 2024 23:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZkZd-0008SZ-Jq
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 23:39:14 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZkZa-0005zc-F9
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 23:39:11 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d107900457so3886111fa.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 20:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707799147; x=1708403947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6pxcy83+qY+qqR1JfeBd83QWY3SHzfnMOli7CsxV1g=;
 b=hl7fXCZXi7maccqm24r5IDkfVPS5OZN0PVEKoLkD30rvSZLDxf4AKtd5oFNqs+wjEP
 5zxqrS7fQdG3KjO4FLfL0Qsn1fcpnwx55ABx/qUuHw8A/WVzF0YfnvkN066J3Fxf0RT3
 ewptUWYlfPB8Rs4VMhqk2mIrYolr5hfCC0rByUggs37qoTI7+obrjTQDlBBG85bhqFEr
 1G37k80v1J7uRezQdcE+2ErRTGhm1GSfu4Mn4oepfv6dNSs+3qVT+YGFt7HO/lXLyc5E
 7AfNm8UiMTTj4ZBslWM2ZQGL7wTbauvWc7cuPSdphW6oqjlBCx3l58At236ZtARSGlWp
 auFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707799147; x=1708403947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6pxcy83+qY+qqR1JfeBd83QWY3SHzfnMOli7CsxV1g=;
 b=kBGkgRva3yf9nGme/hcldu65fQjSICJKdB5B7fYD8NLLYnEwY4vq69U4V84wrHT9ST
 IY7tgNtJp2Z1tW7yipMBww/J7kz3d+35G9nG8Zu0CUGA5mHqz/NeayeTRZI1ZtGW47iM
 azde3zLrEzZ+h1yDhgcSooRqPPiXNUaxDH3AnEqkAlM2l7i8UJi7vge5h5VnqNJProo0
 nl23aWSbYhUfIzVUXpDp1jop7XSTt/aLKOFQXl+kACM9cxHETzCNjBxNkZmCOGWZGqQd
 eG9rh7Ha2wZHSmz5+R99CSebgq4IiRkkqEv46FxMh7fOSikmrTZfrpuODN1KnmnccDzW
 kAOw==
X-Gm-Message-State: AOJu0Yy/9wlUk91tMf8BB0wvqGopvt0ZEkfQepW/PgaM6HM520mvikkJ
 +wC5tHAKYOnZD+MGLEEW/ABcrmXZTBZZHUZboh+/7X9FqI7vN0UHM7A/xaqxZ+gW0o+wXj2uBhd
 9
X-Google-Smtp-Source: AGHT+IF1YM6VspSFl6mXJhbfidWjAJDV1Te+VtIvos2AAaj+/nyLYm4HDpvbtxFr4APXjlbXOrCXFA==
X-Received: by 2002:a05:651c:a12:b0:2d1:749:c85f with SMTP id
 k18-20020a05651c0a1200b002d10749c85fmr526820ljq.47.1707799146683; 
 Mon, 12 Feb 2024 20:39:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWelYw+K+czkwcdHJjSKFRz8AzTHcxEzN5x7MjPxiZwA4JRoNdiQl8OQR9ApRI2okuGK/u6ji/kRMcoZak3PUW57zQPM0+ZsIzpNzAhMJP2kZ7wdzk=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 em8-20020a056402364800b00561740859b3sm3096177edb.19.2024.02.12.20.39.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Feb 2024 20:39:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/usb: Style cleanup
Date: Tue, 13 Feb 2024 05:38:57 +0100
Message-ID: <20240213043859.61019-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213043859.61019-1-philmd@linaro.org>
References: <20240213043859.61019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

We are going to modify these lines, fix their style
in order to avoid checkpatch.pl warning.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci.c | 3 ++-
 hw/usb/hcd-uhci.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 870c72cb59..98a2860069 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1086,8 +1086,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,
     case CONFIGFLAG:
         val &= 0x1;
         if (val) {
-            for(i = 0; i < NB_PORTS; i++)
+            for (i = 0; i < NB_PORTS; i++) {
                 handle_port_owner_write(s, i, 0);
+            }
         }
         break;
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 7d3c026dae..b95b47f6a4 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -457,8 +457,9 @@ static void uhci_port_write(void *opaque, hwaddr addr,
             int n;
 
             n = (addr >> 1) & 7;
-            if (n >= NB_PORTS)
+            if (n >= NB_PORTS) {
                 return;
+            }
             port = &s->ports[n];
             dev = port->port.dev;
             if (dev && dev->attached) {
@@ -513,8 +514,9 @@ static uint64_t uhci_port_read(void *opaque, hwaddr addr, unsigned size)
             UHCIPort *port;
             int n;
             n = (addr >> 1) & 7;
-            if (n >= NB_PORTS)
+            if (n >= NB_PORTS) {
                 goto read_default;
+            }
             port = &s->ports[n];
             val = port->ctrl;
         }
-- 
2.41.0


