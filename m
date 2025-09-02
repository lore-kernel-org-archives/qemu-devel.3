Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADC1CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoT-0004kh-5X; Tue, 02 Sep 2025 09:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoH-0004Pu-0f
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQo9-0004d3-VO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45b7ebe667cso34868275e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818738; x=1757423538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HNvR7jwHMpClwLTVx8eKGilXdBxkd6upV9yfio29tNQ=;
 b=Q2kDIoJz9vQrTKOSWWOxdvciTlDIyCxBNNyEfLd6AH4jyPUoXH2WJh+cbxuECcAouj
 lYXLkQE2FJ1JDBQJvHF6dJG+4RJG4FLVP/N2YFjGNZMzf725gCoFuXHHGUg33zMHH864
 /81NqNGcQIwyM+E8Mi4trBJEv7+N9Vy7GLGYs1aWitRHqVki6E2V0zxrcZ+gAA5wafpo
 iOYHfXh9IzJpmu4L9eRTMMV6sCIl/M7/tToA07fXEylGOp3KrPZyXkyJee+8aQrWAMR2
 2OpeVIUORqqbGrhhPQ0KUk9ev5SWxSIUFjnd/j55xtNJ8S8l9jZSDZTxNwO3eYC1XwfS
 GUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818738; x=1757423538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNvR7jwHMpClwLTVx8eKGilXdBxkd6upV9yfio29tNQ=;
 b=Ynxq9xN3lASchm8p7yPMmMii9Hv0jLfcNnDZ49NOLniJj46BBoSw2yJK5+9l7N3God
 Wiue5V5TfvvMndnfNOOwsmIu9Kip+9IFX9hYoxWAPRyElEy1/qU75uLNGfsgLXSWuA2G
 n9XT2UD7Vfg1C9J8xVvse5igAw5aYaDT+HPiSpvPrszMsqogsUEhDUwAWRPF3goJcYDV
 FZRp3yARxVVvnnR6y3jOD5OJUsZizv2pSCV/5k5+/LOLbTTF05NygZpBmR8oKdWRteR6
 l5mdH/T7L0RFrKbwaF7kW5h+Z+7cgqo+kU4/ddfu4cPm3kbBBuMTkk+2uASRrEbzwyLD
 USFA==
X-Gm-Message-State: AOJu0YyeM48N+Z91lxVD66LLVgIEtBEHSRPG8fvHi3sEWB0AMjb+fHiP
 i8Ayw5R6HEo2XfFPKVZYRogAgCdKT1xZSSw7tYRiFiZYoxth8mv+mtzexKevOkI2Y93wjw1j9tK
 +bpqL
X-Gm-Gg: ASbGncsWi5fe0yps4vc7Ywlqcoi/pSRpSl1Yel6qBRzvSkdXrOR34y6/CBQI9FeHhZ/
 82nGk9fiwepfzTQWTrbLBP9EnB+Q8/Dprz1bIr2D1L46LmC823Jwn2nhPq3htHtRqvWGsYPcz82
 1Aq50rFPzXzQqdynuyiZDJMLLOfZHpvev86x89UWp5Rc8fsOcQGGOj7+jHR1wS+o0MFvlHxwYDm
 5ao2l/Hl1sB5EPrVyBXl516q2om6SPBW7EuF69acTYkjgn9F50AI9hXCIzxo1N3DkMaJ8IqAF6l
 UarwuWq0kS2F5Sr6rKXMI9t4dzlEZKPm0JzkqCeOQKaD7+g8o/reSUhVeAfkbNO0xIHFcOoUegs
 ruBkYH7FDzuRp+568o//80bQ3N2ZpUi5Ra1JaKmaE0E46gLRys+s9K4FRsjW1qSQP+5uhyPsVp2
 el7KctLeVfNHQcjV1Eqg==
X-Google-Smtp-Source: AGHT+IF8wMesRKewRxGrR6eb54Mygy8xl0C9O2O/4/+6G0ZCTCCc+mkG8VtitZ0iLT34gqJqzsPZNg==
X-Received: by 2002:a05:600c:5486:b0:45b:8d2a:cd09 with SMTP id
 5b1f17b1804b1-45b9bd607a7mr10863185e9.13.1756818738225; 
 Tue, 02 Sep 2025 06:12:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm65223255e9.19.2025.09.02.06.12.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/39] hw/display/xlnx_dp: Don't leak dpcd and edid objects
Date: Tue,  2 Sep 2025 15:10:03 +0200
Message-ID: <20250902131016.84968-27-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In the xnlx_dp_init() function we create the s->dpcd and
s->edid objects with qdev_new(); then in xlnx_dp_realize()
we realize the dpcd with qdev_realize() and the edid with
qdev_realize_and_unref().

This is inconsistent, and both ways result in a memory
leak for the instance_init -> deinit lifecycle tested
by device-introspect-test:

Indirect leak of 1968 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
3fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
    #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
    #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
    #5 0x5aded54458be in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1272:20

Direct leak of 344 byte(s) in 1 object(s) allocated from:
    #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
    #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5aded7b9211c in object_new_with_type /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:767:15
    #3 0x5aded7b92240 in object_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:789:12
    #4 0x5aded7b773e4 in qdev_new /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/core/qdev.c:149:19
    #5 0x5aded5445a56 in xlnx_dp_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/display/xlnx_dp.c:1275:22

Instead, explicitly object_unref() after we have added the objects as
child properties of the device.  This means they will automatically
be freed when this device is deinited.  When we do this,
qdev_realize() is the correct way to realize them in
xlnx_dp_realize().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20250826174956.3010274-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/xlnx_dp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 7c980ee6423..ef73e1815fc 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1267,14 +1267,18 @@ static void xlnx_dp_init(Object *obj)
     s->aux_bus = aux_bus_init(DEVICE(obj), "aux");
 
     /*
-     * Initialize DPCD and EDID..
+     * Initialize DPCD and EDID. Once we have added the objects as
+     * child properties of this device, we can drop the reference we
+     * hold to them, leaving the child-property as the only reference.
      */
     s->dpcd = DPCD(qdev_new("dpcd"));
     object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
+    object_unref(s->dpcd);
 
     s->edid = I2CDDC(qdev_new("i2c-ddc"));
     i2c_slave_set_address(I2C_SLAVE(s->edid), 0x50);
     object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
+    object_unref(s->edid);
 
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
@@ -1311,8 +1315,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(s->dpcd), BUS(s->aux_bus), &error_fatal);
     aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
 
-    qdev_realize_and_unref(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
-                           &error_fatal);
+    qdev_realize(DEVICE(s->edid), BUS(aux_get_i2c_bus(s->aux_bus)),
+                 &error_fatal);
 
     s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
     surface = qemu_console_surface(s->console);
-- 
2.51.0


