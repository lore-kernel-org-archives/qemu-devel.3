Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD732C53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6ac-0003Zf-0H; Wed, 29 Jul 2026 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6aY-0003Ya-Np
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:52:58 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6aX-0003qN-9b
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:52:58 -0400
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so15105e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340376; x=1785945176;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AD/ctxxaJ0c1UGixC9zPix/cWBFWLdoXJO6RiTcZO2E=;
 b=anCEyy7BwWfVW7HjAhknLwNQ0OE/uC1q/bRVh/tBCbX+ndC5XXztnJqnuSZbsbpFw4
 6195UCGrnGSRHCMt5yK07VogXxrJWiC5KTJQ6NsMoPay1bCCCnQllTxIOgF878iEkNZB
 73kFPpaqYtwXIPNQGsRcqk6TQxk0HPGar1pY/UPWFJS+KJZmBWMsWDI7HB39hq7YZguD
 /H0fS9o62xDg3PtJFOEIWvgo7980FRPGZ04KK2FyFbGgA2fbQWw5O8O/eBxj6e5mWlfR
 uvSkwZFVS4WAlBxMaw8cA02xlIf2pinHZ6i3vU77G2oCqwZu22N8mLqsId67Hi7NV3Hy
 TknA==
X-Gm-Message-State: AOJu0YyvXdgw1LdXbXONtY1vegPbqp100liIO3xLL8yWxg7mXiHHOARu
 xFbnSTNDhKDkQ08VyrCFv4AGRoe4QgIXFCbi7TQtoDr/kv8CdRu7zXtAo5lFuD+9
X-Gm-Gg: AR+sD12BHBBGXeY2V9hVbpOYuCoFluEyQHws04mBJDNS8Qx22x3DQCNd/mhE5CWgjPA
 244PReLqo4D4lAg3QJVeKlyLZRQfLmWiM7IcT2c6vroWSoZpW9ubX+WaaZvFwDrFEdfmBaQG7kx
 ZOacdXt94ZurscocXWyScXUalxug2HlFkXfDxin6sjy3pWexXjvtiVN+CXXGGSQ8ph2WKHl0wtU
 ln9HZF0NSIq4AyknDjBAETRwtvroSy9S65D3IEvvOcxXSBuYOEOR2/wkQ6tNoR/IN7HzA49sZMI
 SgdI6E6qBQeey2S9wC3G1iKdWytJGXyy6v4Q8x/E3pzSWh1hcRFxGFoRlytNxefB7jTWezFJM2s
 vCNomt10HvSHhR3gp7Y86v9wrb/8wdOuUghMRltJDmg+AjcsNxgYnYQ1DH6sRGghsRVMAdhLeN8
 Fi+HvmAFS/pG7Z8BpzI9859G2KxzA5IRQSeuEgnLNk5c0yFSdRO2Lpq588LS8iHhXR0sq7Cvr7D
 kVZiW4ml+2F4Iy6JnPsCdjI3JEZzsKLLgMl
X-Received: by 2002:a05:600c:3b1f:b0:495:6022:5a23 with SMTP id
 5b1f17b1804b1-497fd321f45mr31393405e9.19.1785340375806; 
 Wed, 29 Jul 2026 08:52:55 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d72d9asm69319645e9.3.2026.07.29.08.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:52:55 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:13:01 +0200
Subject: [PATCH 25/25] tests/functional/arm: catalina: test PCA9554 IO
 expander via QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-25-c8f9a8d101f6@free.fr>
References: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
In-Reply-To: <20260729-sanmiguel-bmc-locator-v1-0-c8f9a8d101f6@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Emmanuel Blot <eblot@meta.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337965; l=2183;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=8aTFJBX4+2Zfb9dvqeKFk8XY5h03hnbOmzH0dpRmEzQ=;
 b=BAjG5Wy4c7yHMBsCnKjOPpH/zt7w96VxJuztwuKqrjhTP0l1eFGjVbe1BXKIpiznBUsVdhfAt
 niP4X1dJuweDLofPmVHlZJqYA2rzeYkuy5VXcUbOnMLNeKCX/ZL5b4G
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.52; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f52.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cover io_expander5 (pca9554@27, behind pca9548@70 channel 6 on i2c1), an
8-bit expander reached through the pca9548 mux.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_catalina.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index 5624774891..f9ee62260b 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -33,6 +33,11 @@ class CatalinaMachine(AspeedTest):
     # io_expander0: pca9555@20 on i2c2, a 16-bit expander directly on the bus.
     IOEXP0_LOCATOR = "/machine/soc::aspeed.i2c-ast2600[0]~i2c[2]~pca9555@0x20"
     IOEXP0_GPIODETECT = r"\[2-0020\]"
+    # io_expander5: pca9554@27 behind pca9548@70 channel 6 on i2c1, an 8-bit
+    # expander reached through the mux; gpiodetect confirms its 8 lines.
+    IOEXP5_LOCATOR = ("/machine/soc::aspeed.i2c-ast2600[0]"
+                      "~i2c[1]~pca9548@0x70~i2c[6]~pca9554@0x27")
+    IOEXP5_GPIODETECT = r"-0027] \(8 lines\)"
 
     def test_arm_ast2600_catalina_openbmc(self):
         image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
@@ -54,6 +59,7 @@ def test_arm_ast2600_catalina_openbmc(self):
         locator = DeviceLocator(self.vm.cmd)
         tmp75 = locator.resolve(self.TMP75_LOCATOR, "tmp75")
         ioexp0 = locator.resolve(self.IOEXP0_LOCATOR, "pca9555")
+        ioexp5 = locator.resolve(self.IOEXP5_LOCATOR, "pca9554")
 
         # temp1_input reports the temperature in millidegrees Celsius. Drive it
         # through QOM (units of 0.001 C) and check the kernel hwmon interface
@@ -65,6 +71,8 @@ def test_arm_ast2600_catalina_openbmc(self):
 
         # pca9555@20 spans two 8-bit ports (pins 0-7 and 8-15).
         self.check_ioexp(ioexp0, self.IOEXP0_GPIODETECT, (0, 7, 8, 15))
+        # pca9554@27 is a single 8-bit port.
+        self.check_ioexp(ioexp5, self.IOEXP5_GPIODETECT, (0, 3, 7))
 
     def check_ioexp(self, qom, gpiodetect, pins):
         # The guest drives these lines as inputs: set_pin injects an external

-- 
2.50.1


