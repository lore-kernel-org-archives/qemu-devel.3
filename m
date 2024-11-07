Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A37D5D687
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 19:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t98b3-0001cJ-VA; Thu, 07 Nov 2024 14:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FBstZwYKCj8ujuvtshpphmf.dpnrfnv-efwfmopohov.psh@flex--titusr.bounces.google.com>)
 id 1t98ax-0001VD-18
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:07 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FBstZwYKCj8ujuvtshpphmf.dpnrfnv-efwfmopohov.psh@flex--titusr.bounces.google.com>)
 id 1t98at-0003Kg-RC
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 14:55:06 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e29205f6063so2268550276.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731009301; x=1731614101; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=sxbPXV2KES210ccGj2mQ/00ciXsa28hw8J0Q0KYSQDc=;
 b=T3NR1zQWeSRQFYRTQ1lEpwHC9/9dEwXDc1eZ2z1VeB0tCL+w0qLQgPFV6wSYmQXsZU
 bmhjT8IhxROI6YcLhGFcFtH1qGiStaD0OWANYIu7zoLI+4w08oAi2kdhI8UEexfAvkl/
 nPeNDoRycOyiu3G+Gm400WyoiG1hW8OXxOiIu2HycUmCae3YmbYSdllsyFz7FXzjvLGF
 1SYXLmRIaIR4xiyF0xQ4O7xUGY2UPCndkyH3pkGHmV50rgQonAMaP2jJnq60l+CdNcm+
 rIq1N50WHCe2MhMD/WLxK/0T8ciBHBe8dErm8WKgC8TmTr+wVTTHErIAvApRXxLDILXk
 jvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731009301; x=1731614101;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sxbPXV2KES210ccGj2mQ/00ciXsa28hw8J0Q0KYSQDc=;
 b=BWtyApSHWh98lXLvyJez/LFZf46iJWr6u6SAlV8ZwhIE8PaYF2kqnlWelMiXR8UqS2
 4tDGxsPk+C/oqypqL8xQYHxcypPCQQhGzFzmGUTVK5YhgboWUXhU2Zq9SVHQCpPEZ0EJ
 6sSDxHS+Z9YYpJsmAKHatvpdSneRW3z5PE8b3GRRR7aU23JltlQAf8DREn3FzKkt7ZtB
 jW0BqO7ua/3bfChKFPk9KbQ0mq3cu1srK1EhQKWgen4PMrakdKPyGZuMSdRGdxoHU4SY
 /rGFLUHruFJIz+YSyQHGy9L1U64L2ommYAMD2k90C38D6dlAq81wl/PGW6qzsSFA+V2o
 4A+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdf0mmoNl+CFiTrnbNzDBInvAO5pykv4wyJg81ivo/la8jvZHKoRaY9vnb/ae/3ZDxiCj3oI06mPla@nongnu.org
X-Gm-Message-State: AOJu0YxIVddHZw/Q8uhmzOpFtBjdoPsMi8iF1j+TMzz01+ANIE1LH/tj
 p+xqKBuKJOQv+N71kjQ2/RIGX1NRyVm7mr3JYBbH+aRAhvCX5IHzQf+R0y73KISkMDKskZobYk6
 ZPw==
X-Google-Smtp-Source: AGHT+IE0q0PWUlih+47eGnqEzahF8cZwQc7/3aNVVz9lbHyqNxLtk29OTlyDgxo8JxJapjnvXSbpbZulJAY=
X-Received: from titusr.c.googlers.com ([fda3:e722:ac3:cc00:dc:567e:c0a8:e14])
 (user=titusr job=sendgmr) by 2002:a25:acd3:0:b0:e30:da65:7240 with
 SMTP id
 3f1490d57ef6-e337f85bbf5mr577276.3.1731009300823; Thu, 07 Nov 2024 11:55:00
 -0800 (PST)
Date: Thu,  7 Nov 2024 19:54:50 +0000
In-Reply-To: <20241107195453.2684138-1-titusr@google.com>
Mime-Version: 1.0
References: <20241107195453.2684138-1-titusr@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107195453.2684138-4-titusr@google.com>
Subject: [PATCH 3/6] hw/gpio: add PCA9536 i2c gpio expander
From: Titus Rwantare <titusr@google.com>
To: peter.maydell@linaro.org, minyard@acm.org, clg@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 venture@google.com, wuhaotsh@google.com, milesg@linux.vnet.ibm.com, 
 Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3FBstZwYKCj8ujuvtshpphmf.dpnrfnv-efwfmopohov.psh@flex--titusr.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

This device has the same register layout as the pca9538, but 4 fewer
gpio pins. This commit lowers the number of pins initialised, and reuses
the pca9538 logic.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Titus Rwantare <titusr@google.com>
---
 hw/gpio/pca_i2c_gpio.c         | 18 ++++++++++++++++++
 include/hw/gpio/pca_i2c_gpio.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/hw/gpio/pca_i2c_gpio.c b/hw/gpio/pca_i2c_gpio.c
index 2486c620e3..b911187e34 100644
--- a/hw/gpio/pca_i2c_gpio.c
+++ b/hw/gpio/pca_i2c_gpio.c
@@ -336,6 +336,19 @@ static void pca9538_gpio_class_init(ObjectClass *klass=
, void *data)
     k->send =3D pca953x_send;
 }
=20
+static void pca9536_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
+    PCAGPIOClass *pc =3D PCA_I2C_GPIO_CLASS(klass);
+
+    dc->desc =3D "PCA9536 4-bit I/O expander";
+    pc->num_pins =3D PCA9536_NUM_PINS;
+
+    k->recv =3D pca953x_recv;
+    k->send =3D pca953x_send;
+}
+
 static void pca_i2c_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -386,6 +399,11 @@ static const TypeInfo pca_gpio_types[] =3D {
     .parent =3D TYPE_PCA_I2C_GPIO,
     .class_init =3D pca9538_gpio_class_init,
     },
+    {
+        .name =3D TYPE_PCA9536_GPIO,
+        .parent =3D TYPE_PCA_I2C_GPIO,
+        .class_init =3D pca9536_gpio_class_init,
+    },
 };
=20
 DEFINE_TYPES(pca_gpio_types);
diff --git a/include/hw/gpio/pca_i2c_gpio.h b/include/hw/gpio/pca_i2c_gpio.=
h
index 61e5853c24..f325563dc7 100644
--- a/include/hw/gpio/pca_i2c_gpio.h
+++ b/include/hw/gpio/pca_i2c_gpio.h
@@ -21,6 +21,7 @@
 #define PCA_I2C_MAX_PINS                     16
 #define PCA6416_NUM_PINS                     16
 #define PCA9538_NUM_PINS                     8
+#define PCA9536_NUM_PINS                     4
=20
 typedef struct PCAGPIOClass {
     I2CSlaveClass parent;
@@ -64,5 +65,6 @@ OBJECT_DECLARE_TYPE(PCAGPIOState, PCAGPIOClass, PCA_I2C_G=
PIO)
=20
 #define TYPE_PCA6416_GPIO "pca6416"
 #define TYPE_PCA9538_GPIO "pca9538"
+#define TYPE_PCA9536_GPIO "pca9536"
=20
 #endif
--=20
2.47.0.277.g8800431eea-goog


