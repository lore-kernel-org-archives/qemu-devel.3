Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77866F483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iWP-0001W7-C2; Mon, 23 Mar 2026 12:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWB-0001QN-VJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iWA-0000TL-FW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b7ff8fe92so223386f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284760; x=1774889560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LV22NE8aLPvFdDT+Zc6yYExLLq20+KDgYvF7kCb0uns=;
 b=im+i33rdUjgAn8hwDyy9r+ZPP5fdPCBTS7IhtAGpwhJcx24pJCzDIKDlILBmANx5Bb
 jcH33OdlqugXSfMEgMLKW+LNBnkf2JXcaW2JdcC0gNQIi3skDRDhcjr8omNd2m9k8FFh
 F4RwKBgizpSKfSBZan2u1m0O2leJkWVz5wE1cL5KCeF836+XCj9jebuU0vM1f4JQsN3S
 J9BYMUibuaMQ/WRv76kHpT0/6lO+Ukc1T657c4EySYj++JpOb501YfAqAmesuevxLNFR
 DKCyLecMmXX2CVvQ/nvG+iKHOQuGsHufbrfsv/epAzE500cYS2Pe36Ib3zMx70Ly9AbJ
 cNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284760; x=1774889560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LV22NE8aLPvFdDT+Zc6yYExLLq20+KDgYvF7kCb0uns=;
 b=iKsUrBdjzBxIcfftmEqd/rIMVzhc2W1rWmtNgxud7bjRC/Nv0x3vBGNXXAYo9UqY8t
 CSTuhkI9rXqBh5BUB+EzrKO6OZNSSpjgq0BkbvQ82wYmBQpf3xTxa6lbqM0aPamPyz7O
 jutXHTW72Zb1HcXDDKIe6M1xDSJU2/88PuBYP8qOkAdF16Y7Bod+NJuwUEjggx9B/drz
 iIfnYW7RML/SyD5f/v4V5B0t/nRgMKpgCFbhIiJ36+y1Hm8e9lLzszpWUcWlNVq9TZvE
 eUADES1l5kkCS6WW2vGN8JpbrlhmCm096iXdpdTbRp51kI4SYt0UqMKYotnKwBE0XFbO
 atgg==
X-Gm-Message-State: AOJu0Yz2CF/qVCvS1ZK1tIp65P84iZijToZnhkXmI1cSe0pnITCbeuyi
 JeFF5rBKGqXJmJBd9BR4WSZ8nQGACudUKK4uTBhpdEbBfl+2+wO6SSxO1rcgih1FeEA2hRZomUR
 Ixe5+7ao=
X-Gm-Gg: ATEYQzyJQOgKtavCqq7lrwlKFZwPCR0S7KLNH4NHiF1Nw3fBp05HxZYElz0lgXRzA+6
 xH6cT1OiPFr4wLjE3nDpAl4HCRhpz1bLYxolLwhGqBe2KBT1Fz/b3AcW3NrDcOuiPXSQyyjlJqa
 Fvr2+A9gSonuydprEjWzGcMB1va84lve+vefQsr3Fngz9s4nlVeIBoC91j+IXvPSQwi6JzuXNE3
 OHpcLxcO7wJiZHvLB9x2E3ayADgQgEiANDYujqILOKTk/HqEw5h4gb3seFbzYHTwgRIAobhVJZH
 RSs9Lw7fl9HlK6O7V/We/VvidGmXGih34UtL6+IBC0LuR1BODo026odnyTNvqKQmI/7lYxBI/iR
 lPoZzC5eWewRuv1dTjokLYQu3w7EKmoWGRkCtOvDrCywcxTQok/vvDLplMgtmQbRlYkJfjuA597
 oM2/DaX7jlJif4vzQBLtP+oj1+ZbBcT5xp5+DW54eIHeEqFSazmNHNllkLIAtG427kkHd86jBOl
 EZ/Ik4fD7E=
X-Received: by 2002:a05:6000:4024:b0:43b:3b80:6781 with SMTP id
 ffacd0b85a97d-43b6428b67fmr21003423f8f.49.1774284760452; 
 Mon, 23 Mar 2026 09:52:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703c7fsm30639153f8f.23.2026.03.23.09.52.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:52:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/27] hw/char/virtio-console: clear dangling GLib event source
 tag
Date: Mon, 23 Mar 2026 17:51:54 +0100
Message-ID: <20260323165218.96607-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Matthew Penney <matt@matthewpenney.net>

Clear dangling GLib event source tag when virtio-console is
unrealized. This prevents a stale tag from being used, and
maintains consistency with the rest of virtio-console.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260305213308.96441-1-matt@matthewpenney.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/virtio-console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 25db0f019b8..efe7cd6772e 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -257,7 +257,7 @@ static void virtconsole_unrealize(DeviceState *dev)
     VirtConsole *vcon = VIRTIO_CONSOLE(dev);
 
     if (vcon->watch) {
-        g_source_remove(vcon->watch);
+        g_clear_handle_id(&vcon->watch, g_source_remove);
     }
 }
 
-- 
2.53.0


