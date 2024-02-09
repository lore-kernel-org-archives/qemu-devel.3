Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6515BC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 12:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYQ40-00081A-A3; Fri, 09 Feb 2024 07:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3v-0007xT-3q
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYQ3s-0001uM-PW
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 07:32:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4105f6fbdd9so6211055e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 04:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707481973; x=1708086773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iars+m6ELdOmlbrG1ApaqWkxoTlLYosuewWqu/opFsQ=;
 b=inoq6me77vw5qAZRQtT5UskNoUiUJO6C4DKkv69ve9TubZm1XAiyBtHnty1sB2utqB
 8+f4v+J/M3fAy9GV+QqSkscNO3PVgUULkFmU+B6cYOTFg7+tSTM+8mST3Ltn3cM9SZQv
 ZCltmOvZflBKFKiCVkz1yJoHcL8acCMXoLglOiyAgIY1Gm2p1mLymprXo88dyaSXOTgW
 hF2kT0dHz06YdszZA1/zvYZDTkcBZ9jPmGrSB8IE27NopdbmTe2maOratqQtiagadXa+
 +Z/cV/mf3apej1sznwNlJrcanwOx5WkskNcyGdvnHmsvBjsKBlJzRAbf4l2T6ge33JxG
 Kj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707481973; x=1708086773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iars+m6ELdOmlbrG1ApaqWkxoTlLYosuewWqu/opFsQ=;
 b=m8RDynQiBxhz9AoP7k6oerkrb/r/BKXba7BOzaW8o/88yKXbVTSWWFlznmpA3IifvU
 ghIiDL2Z5zbILvw1zp41MDVdbbkcSQpc5ajKjd53Y5UWYUMFXiW91Hmt2FFZ6BoGV1En
 TsfgLJMehND1Ikd2wO0bxGIPEjMnpj6Pe1W7NS+Bi6xAwp4Vf42u1eka9SszT6I4tMvC
 BEJTsUq0Pge25Fnqmc9C/J4l4R3WEBnRIE0OQmoCs95h4h6/LhTECqpU8gTGJDIFwt+C
 aJj2OU8/hV2dodFvLonwbMYJh7wyK19tK9ILMlhPUHgwTF65EVQjUwj9rQ55ahSRgQgm
 V62g==
X-Gm-Message-State: AOJu0Ywo/CQzcKTqlQjPiJcFSyraq9Gyt5n65eZscmN4n4aUblQu3z+p
 grRyfu/uUuF9mB8874MQqLXQKbOnmwcY6qghNxsPyl8GA1odp88Zx6W+1NnoEjxJ+KU6/S0CFod
 S
X-Google-Smtp-Source: AGHT+IFhuXlP1HQ0mk7K83K3UZl7uxsUcLNtFypgnAm8OFyLSVHRxDFx0IjjJfs+FHhl/+yBiUyepA==
X-Received: by 2002:a05:600c:3545:b0:410:5897:1d85 with SMTP id
 i5-20020a05600c354500b0041058971d85mr1062496wmq.14.1707481972821; 
 Fri, 09 Feb 2024 04:32:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUkodP0uPw5GgjrxDbnO38ZL0XQOV/5NjIwLOhSQUdCDFrIpY9pKjTPdXb42aWbI0QlLCzr5JWcrc5/M0vfkI62DUAGJThJVo3/kdz0QBkevIpi/1asmsD6DHK3pebHsTO3U1zt6X/0K3DfoYCUcPBbmmFCM8Wmruni64mw0VKzZdiKhslJhxfsCLW49VJPYanSMK7l92ybrSoHDh5rEyKHV7sTJaW5dA/I7TiRLu3bc2MDsuGaVucFMg0x2CKZOjSEX4A9PEQhE06TTAVNzpC1ukcM2LPswe3Y7/G2UMTXAYuGL9m3KtHmEOo7vJqeJX63VEYuecYzJYM=
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 bw26-20020a0560001f9a00b0033b5b6a186dsm1717121wrb.69.2024.02.09.04.32.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 04:32:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH 4/7] hw/ide/sii3112: Configure IDE bus IRQs after
 realization
Date: Fri,  9 Feb 2024 13:32:22 +0100
Message-ID: <20240209123226.32576-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209123226.32576-1-philmd@linaro.org>
References: <20240209123226.32576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We shouldn't call qdev_get_gpio_in() on unrealized devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Ideally we should rework the current IDE bus model to really
use QOM and not globals. Left for later.
---
 hw/ide/sii3112.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 63dc4a0494..8b6e931f27 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -282,6 +282,15 @@ static void sii3112_pci_realize(PCIDevice *dev, Error **errp)
     qdev_init_gpio_in(ds, sii3112_set_irq, 2);
     for (i = 0; i < 2; i++) {
         ide_bus_init(&s->bus[i], sizeof(s->bus[i]), ds, i, 1);
+    }
+}
+
+static void sii3112_pci_wire(DeviceState *dev)
+{
+    PCIIDEState *s = PCI_IDE(dev);
+    DeviceState *ds = DEVICE(dev);
+
+    for (unsigned i = 0; i < 2; i++) {
         ide_bus_init_output_irq(&s->bus[i], qdev_get_gpio_in(ds, i));
 
         bmdma_init(&s->bus[i], &s->bmdma[i], s);
@@ -299,6 +308,7 @@ static void sii3112_pci_class_init(ObjectClass *klass, void *data)
     pd->class_id = PCI_CLASS_STORAGE_RAID;
     pd->revision = 1;
     pd->realize = sii3112_pci_realize;
+    dc->wire = sii3112_pci_wire;
     dc->reset = sii3112_reset;
     dc->desc = "SiI3112A SATA controller";
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-- 
2.41.0


