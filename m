Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93A1CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQo9-0004BG-K0; Tue, 02 Sep 2025 09:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQo7-00043M-Ev
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQo0-0004cO-RE
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45b873a2092so25194515e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818729; x=1757423529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Td3nvqZKIvcK1wV49niKvXWkSXIsMzUAcPCww/paHbo=;
 b=YpgeN2VVXCQ/f6G2EyLJpU3o8kZnqLq9XfGBPQEDXVTb50aAqIxmXboUONCti/do2J
 U9s3Gn9F8DksV8gL72cCYlmyAv3mCCvubWsBsLRBUAqtBAF7n8YYcHGn1x3yfPZ8Fnok
 tI/imIabtGU8vUBQ6kC3p5Xg05ZU7V0xNJ0nUDRn7K27sxpJzjYoYwhMzc7Hwgb7Crzu
 07tYjdf6DmRNthz0kz/YMWWrJYYSRgWCJzIR4/XKNeEiv8hZIJeRqVWvjLoSVpO6XIzn
 TC4u19qE+0aREPSbwe9qxNndrqVF8TAG1osF+4h86dUp8ykiDC+TeESAlR8Hu6EzfPwJ
 sVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818729; x=1757423529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Td3nvqZKIvcK1wV49niKvXWkSXIsMzUAcPCww/paHbo=;
 b=FaWwTyzdYputKmM+8qv3HAsiwBtr6BzldwUT3eZmQDNUIVMVEStJ6yY1hSJY24zyGh
 SyNhhxXmCfx5oz3a8wnn2mv1g7Z0tBmVPMdjA/tptWF/iN3wflPAmri6dNLhmOJWyycO
 HvXVg8IQLjkxF/cht9CqQL45ME1jFAoRN+5JmgiDLiHNGW8KF2f6QLSMSDdN93bwCJij
 yRqdskKzVm0Rwcnypaa/9xJW2dFBNsC52MGg3GiRd0Z1crzDgMSsYehzGH5SqCx//spW
 YG3ly3gEisDPNdQIB396ZYlc9g9eK9bmp9rnbZgPeXwarHgXgvQjH2x3iCS6pXpCVV9+
 zYzQ==
X-Gm-Message-State: AOJu0Yz2y/Zrpxe3FIwj1xnO6fkOiWonduujwLrKNszeWjToV9Suse1X
 Cu1t1TldIMRk7VvnT9D3I2YxW+jOpvc+qus5t0kqmn7oKlfh5f5Yqyeh1Qb08lBDaxXtUR/Zixi
 JkEJO
X-Gm-Gg: ASbGnctsjbqw7LpQJw7OMJJBLVzN1jbPxlubaGLPsxNlfA6vbj0YEJVf9KYt3sHe9A3
 rDFMwlp7mJB68m2jJajFHcLUo9SHO6pGbHpD3sP/itZvIUL3svtRWwASrHx5PIyPISy/AEU7lCU
 LF8Tgt3t1dwxdtTOVoE4DzqKRL8u0042PKpDBPTuNOusRr48aI2Oh0j++cnYGY7F+SVYHsvASxe
 /xKvkhLiySmIELS9B0MsXGDtOdzzlx8HDwkeUbgF+MBuNVJgqRvhh2/01bFGbCbvWDr4aQ9EbZT
 gVOntfaaStRt0nRlgmU4c3+LmdgEnuM5snN2clZ4WB5vu7m3yiuQRXura445weacgZYjeL5lMVJ
 mKyzOPjINf7U442NTac7nxUl97njpqun0mZsc7jiqIUtAY1s+cO/s9NGcl++LQz43pKlQihKdhR
 AWyjI4/Vk=
X-Google-Smtp-Source: AGHT+IEgmE6dDucwrHlEiyTLqj8rutInoVMgxlC5ubZ5AjJ+oEALsdPKf2VZBtInwe2xxOyTzcqoYQ==
X-Received: by 2002:a05:600c:1e8f:b0:45b:83fe:9cf7 with SMTP id
 5b1f17b1804b1-45b85525d75mr84750915e9.6.1756818728988; 
 Tue, 02 Sep 2025 06:12:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e68c83asm212334315e9.20.2025.09.02.06.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/39] hw/char/max78000_uart: Destroy FIFO on deinit
Date: Tue,  2 Sep 2025 15:10:01 +0200
Message-ID: <20250902131016.84968-25-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the max78000_uart we create a FIFO in the instance_init function,
but we don't destroy it on deinit, so ASAN reports a leak in the
device-introspect-test:

    #0 0x561cc92d5de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 98fdf9fc85c3beaeca8eda0be8412f1e11b9c6ad)
    #1 0x70cbf2afab09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x561ccc4c884d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
    #3 0x561cc9744ec9 in max78000_uart_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/max78000_uart.c:241:5

Add an instance_finalize method to destroy the FIFO.

Cc: qemu-stable@nongnu.org
Fixes: d447e4b70295 ("MAX78000: UART Implementation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250821154358.2417744-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/max78000_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
index 19506d52ef9..c76c0e759b6 100644
--- a/hw/char/max78000_uart.c
+++ b/hw/char/max78000_uart.c
@@ -247,6 +247,12 @@ static void max78000_uart_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
+static void max78000_uart_finalize(Object *obj)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+    fifo8_destroy(&s->rx_fifo);
+}
+
 static void max78000_uart_realize(DeviceState *dev, Error **errp)
 {
     Max78000UartState *s = MAX78000_UART(dev);
@@ -274,6 +280,7 @@ static const TypeInfo max78000_uart_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Max78000UartState),
     .instance_init = max78000_uart_init,
+    .instance_finalize = max78000_uart_finalize,
     .class_init    = max78000_uart_class_init,
 };
 
-- 
2.51.0


