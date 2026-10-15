Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F2CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIeP-0001Ko-Sk; Thu, 15 Oct 2026 06:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIeF-0001AI-Bc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:22 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1xHIeC-0003g2-8w
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:25:18 -0400
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so32034615e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059914; x=1792664714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FE9EBUZhqaKkcddPc+39V0rw7VbXhB6SBbD4e6broq8=;
 b=F328paOJ/gqlluDhOLd9juZeHcjsajhkNzfsMAOrccP+u3577OJPVSurEDATendED4
 IhMDdmn7GXFGV7Mcl4lSxipSJupA0hXhFBe8JbXamq7RvsAF0PyHoroDS4ZB9nOy6SxT
 JAp1yF3U2Wjzo0g1fQGRP6PODgN5kWvZK8PpM0/pN+cw/NEWOczSnFo+VlOl2HOajjF0
 4PtJJ2O9iYFKoDYtc6kBx/cKgRBhEhI2kuGnGpvRMzTJaOiMI5XLT7HcDI/6SbJqhmyr
 6zQw43rbFkwm9HnPFx5oKF6WSli+20mE8PGqDA3QFTlGZJgrWwLBSVPGwF9FKrUaZcwB
 WeJw==
X-Gm-Message-State: AFq9FYJXNWmFGifjNgk5QBgkHDJtpi9B5MHjKQoDXGmdUzu4itPkA6Ys
 7gTlbtuUG04NAiGPgvaxvhOoKW6tIr3LQ8K0d1LGZa7OJT/ZnSE2C5YYPoM4P1vk
X-Gm-Gg: AYBFou0wYjxu+vpfauBkYttL9/n1bON/lXfojwlVWt7OPHIio9wVLRzLOOXmnpmfQ6h
 +n8+6RZr6LFyO+8w3tFQE9ciZ4Nom9Auz0c1yJtUatcpYqHZp20oKn+aGONyDmXfLtPS806fO4u
 iRSH5D+A0dgHURFufEDcNiEd5FoBsNUbiS3ivEyPE6bQ89Q/3Cye2yUNUgGlPqqMGWqQHtdeSEg
 ujvQtqGKX9+OOkQchsCMuqcSCi4aGxU7YhDVU2A9RToAISqo4GLtJC7Fa1kG/utVDlzRnRGn1RV
 X2hBoLMHTmRRN1BANFFkK8fKfS7HQRGob5BxphyAD3VkASyjUxiDLzUokMvGIRC6WROavnDcGVy
 kaxHduOU0HX4aPMbkU/b7N5FK4j0cqe69LjxH2lNS72rte1g3ozTvDQGEYyry6Qck7agUVDbOx1
 BCKCFHD22cdYOmervVUvZDJanBnmj0Gp6UpPEgp9l6oleNUftMLQHKKlI0gctO8Ybkt0l1qs2Ck
 Ws5KR71p+Dsk2d+x+JOKlvZ78+7jnErVBb8H2z1gd6K6g==
X-Received: by 2002:a05:600c:8b01:b0:4a1:c4d3:2fc0 with SMTP id
 5b1f17b1804b1-4a1c4d32fe7mr12605005e9.6.1792059914206; 
 Thu, 15 Oct 2026 03:25:14 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96fed4sm61331865e9.2.2026.10.15.03.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:25:13 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:27:57 +0200
Subject: [PATCH v3 10/50] hw/rtc: ds1338: implement Resettable reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-bmc-minerva-v3-10-7d50c8a108e5@free.fr>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
In-Reply-To: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
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
 Emmanuel Blot <emmanuel.blot@free.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056475; l=1388;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=Yb1Zh34x6jrS484Xx/w7PuZZxma8LedPKe6tazap2S0=;
 b=SnOmwT7Zf8wEjEhQ9q5+5OYXjUkHVzgPRC4uRFLHLhKjBjCeOBnlqp61QxMFGSrZzocihtQvF
 QjyJPKbe9BpBHu3ThZUodPNKfvRzjtg8s0FevwM230g0L9sKfFjLkCY
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.50; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f50.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
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
2.53.0-Meta


