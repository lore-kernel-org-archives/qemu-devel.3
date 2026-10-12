Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B27CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 15:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHYp-00041i-Hr; Mon, 12 Oct 2026 11:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHY2-0003w4-N5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:02:45 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xGHY0-0006MI-KJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 11:02:42 -0400
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso15795695e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 08:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791817359; x=1792422159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uBN2fajLUkSLR6UGUjgMftgFKf7I37iwakER3PeDYqk=;
 b=yWozq4H2RUsVHojGTW030Vh2qgvGRelQ9wIHOVubud9l9tBeL/t9vwBNh8Vu1Q0Coi
 Q5WGqCSWXyzTg2utefL6YYhrHPOG7tZf1HPow+ZSGpasSFowT+wD9m4cq//jczHDqQMP
 P0vRUHN2rtTVduazMXRSa00Kh9XGLSkWjDes9+fzz8dJvFVmmrcNzQPmVD4TYAD2BKwe
 ivMKH4hKRiMEU1BYXIjm0v8lkZHPlGtOBsZJEn9UtTvZ2cKA1kYmuMEIqWNPa/3478N5
 UcGAVNSiAFn6UIyoCZAR+HEdZe49nomJA3hftaz/dwQa0PP6lVRRPJxDQuAKFnNIMQ66
 78Gg==
X-Gm-Message-State: AFq9FYJr58wls+uJkRV1AZMfklx1eyW0R3b5X3Q9JWtcA9mBomyw/F8y
 5oxdW/XRVb9ccROdkXLQf7/FnqgQYDlqQ/x4bkFfn0xHRFyz5VqeQIYNdkStCnbz
X-Gm-Gg: AYBFou2UlY8eh1kn4HsalJqAQcif0ikSqW6imXdyLJRe28uSaZXhVNZfExZ/KddlwWx
 rtisoHU7GcCo0Nm/o8ZZgk6/ctg3Do8s/ZuftoXUA7z4nvf6OU2jVyCaK+4usqdrdSPfkiwqhpa
 dgmDyF4CEepAEsi/vCAZN+TWY0h6IQgInpRB9AvK9tgkmkdnpZBQHpeE93B0bFqBs8dD5duJzjt
 nt9Vq0n+fZvtjnNiM8QpQrcIpKHpc2QUmfSxtj6WKmNW5zvXdZsq/dsL0YH85tux3088yEvlWNQ
 zTDPGdl1Cwf1cbHiVNn3Gi2XOzzrGGjvXiTB6prki/HSrieGK/ElwAr8keYI6doH1jD/yZuiJn0
 p8/RyJ8xxUNmqqCF7bxDelo/1wH+ItXUFk1oxdtum2guV+ruPfgBcgwzy2Iezpx3aug8QNzdB0D
 9LVL//FiA7rJEpVNGYMAZnqkPu4SrCb5RJs5hThsGdp0HMQpt+CPkoz4qlHAvhDPxejooMci00g
 CvSYdQ8JJgDL0Vo5eUX8gYF4Uyq4dQn2HQn0F9MhMdw2A==
X-Received: by 2002:a05:600c:4fd5:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a18e49a7e3mr194637505e9.21.1791817358991; 
 Mon, 12 Oct 2026 08:02:38 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ade914sm18383206f8f.54.2026.10.12.08.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 08:02:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:32:03 +0200
Subject: [PATCH v2 10/50] hw/rtc: ds1338: implement Resettable reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-bmc-minerva-v2-10-4c3dff084ec9@free.fr>
References: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
In-Reply-To: <20261012-bmc-minerva-v2-0-4c3dff084ec9@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791815520; l=1334;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=dw30TFJwCbFZiHnP+oufY0O0rlo9ULUgYxm9lxU/N6I=;
 b=gCj4ACC5dNO3AG53vFPudYQeLeg3WDZQQKwWNjs6v/cZ3h3uPGFGDM6JuLIwVPG18NEYST65k
 roUdGP4FuHQDD2mdnsTdMIHoe4q50k256ps4gb1YjL9Bhdbb5OBf1qA
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.47; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f47.google.com
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

The device relied on device_class_set_legacy_reset(), a compatibility
shim around the legacy DeviceState reset hook. Convert ds1338_reset()
into a proper Resettable hold phase, dropping the legacy shim.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index f8b3340bf0..74aee6c746 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -208,9 +208,9 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void ds1338_reset(DeviceState *dev)
+static void ds1338_reset_hold(Object *obj, ResetType type)
 {
-    DS1338State *s = DS1338(dev);
+    DS1338State *s = DS1338(obj);
 
     /* The clock is running and synchronized with the host */
     s->offset = 0;
@@ -224,11 +224,12 @@ static void ds1338_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->event = ds1338_event;
     k->recv = ds1338_recv;
     k->send = ds1338_send;
-    device_class_set_legacy_reset(dc, ds1338_reset);
+    rc->phases.hold = ds1338_reset_hold;
     dc->vmsd = &vmstate_ds1338;
 }
 

-- 
2.50.1


