Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE0C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6Ct-0001TX-RE; Wed, 29 Jul 2026 11:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Cs-0001TA-0N
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:28:30 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1wp6Cq-00082J-6J
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:28:29 -0400
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49557167508so9538645e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338907; x=1785943707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3wENbpzNy+/7ZpZ2nV5lBBRvhyhYJ6tzgYJmt0GLaJo=;
 b=Ob0cbtJ+IGhYRHbJ9gjrIq30VjRFDDORT5eexmG2+rXaU2OM+Ydg+KsW+EKch8dYQ/
 BeDs1zjSiXM2JUqIamIobpzwWu56zQzCLpOhj41pW7GEMGJn6vrl2LGuyiGkfLRw611k
 a3SpZn1nwYVNSiB65QOV5eOGLau1B9XqiI80ofgNnn8yfSFy7OOZk5r9gx7ltWxmKwHk
 tP5YBDaGn+16pX5nhYqH8xFHMbex4lnILYfE4Y4GZNRTrKzrZVkA555Ti/vXqxQxwYRn
 rOZETFTpoFJkNPIeKLo7VJOwXlX3G8Pn7rs07qEVIdknZS9Bc8tUXVw1QFQevPTQPavn
 uP1g==
X-Gm-Message-State: AOJu0Yy7z++2VgiMrzRriueg7ggLRkR+CmMUKGjwGOexQpA3eY9dgv/b
 hXilEiQm9FwnaGTiJI6tJOBa1gNFZ9FCuP0kVN5I8tepqq8A+E22QWPD79avmFGh
X-Gm-Gg: AR+sD13NblcXdnDIiJigcaQL3DelmvVjBGdTg1ys+cgB4j1Z56Obzc8Mk0Inmyr3vu3
 +igRFG3FgMPSF0ePdQAt+S0/NtpYaOX+frdcl9bQ9DF2RI2IX+/oD9FtUw3VgI2nKH6gzTcL6O8
 qvHvSFp0Vnc3ScsWXNwl7aRscJoxeltsgldWDp+hlHQag0/M36zl75HWHEBO/6jH2LqxaqjrTT8
 Uowi52mA6wcm8wiyI+tUusi7dYfa8wZBhHvCFJ51R9iJSwLHyzfvf1e5wThKs6+FUScmtFKdviF
 65GnjiraAs5/v5DvzCf2t4yn7zdYdmIDuTnKQQd8rxZkRcSKas9JOjcm0A0DofPO6qVYMgY1QqN
 xInZPC4b0aOHt/oBxrv5qVq17dZZaro43omqKMqgyQ+wXE+HP9cC9wAUVfHSqlIMcAQepD+QzZt
 DnIqPj0Lb+ZVicuujbQ34YjFCbMKWV7oH/K3MxrH/IGA1U+teeiMR+0msclHEqxYuEnkVmGBLuJ
 5IT2QSI3zmTf0LY4+XLASFRX9ePjf1UzMzEApoWVraEWVE=
X-Received: by 2002:a05:600c:4714:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-496c642c8d1mr89151645e9.12.1785338906579; 
 Wed, 29 Jul 2026 08:28:26 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496fa88552bsm47835435e9.3.2026.07.29.08.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:28:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 17:12:39 +0200
Subject: [PATCH 03/25] hw/sensor: tmp105: implement Resettable reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sanmiguel-bmc-locator-v1-3-c8f9a8d101f6@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785337963; l=1784;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=lLLQDRXOnOUwL5qjxtcvmlFJBgBQ1Ly1Z6iI78mZFws=;
 b=wmpAoOb1vlCAo4gw1g3e1nycH1UDUEQCPa2rN2iZNatrvc/BYEHslfL0nBj9iv5JnlHiHWGDy
 WD2Vz50Xe17Bd7GIAeg/wy1qWSviyhqm0WICs7CQRIf9UFPtrywVeD4
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=209.85.128.46; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm1-f46.google.com
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

Previously the device reset routine was invoked once from realize() and
never registered with the reset subsystem, so a system or bus reset left
the TMP105 registers untouched. Convert tmp105_reset() into a proper
Resettable hold phase (tmp105_reset_hold) registered through
ResettableClass::phases.hold, and drop the manual call from realize() as
the reset framework now drives it. This matches the scheme used by the
other hw/sensor I2C devices.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/sensor/tmp105.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index aabeb34f08..f7d0c738ca 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -314,9 +314,9 @@ static const VMStateDescription vmstate_tmp105 = {
     }
 };
 
-static void tmp105_reset(I2CSlave *i2c)
+static void tmp105_reset_hold(Object *obj, ResetType type)
 {
-    TMP105State *s = TMP105(i2c);
+    TMP105State *s = TMP105(obj);
 
     s->temperature = 0;
     s->pointer = 0;
@@ -337,8 +337,6 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
     TMP105State *s = TMP105(i2c);
 
     qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
-
-    tmp105_reset(&s->parent_obj);
 }
 
 static void tmp105_initfn(Object *obj)
@@ -352,11 +350,13 @@ static void tmp105_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = tmp105_realize;
     k->event = tmp105_event;
     k->recv = tmp105_rx;
     k->send = tmp105_tx;
+    rc->phases.hold = tmp105_reset_hold;
     dc->vmsd = &vmstate_tmp105;
 }
 

-- 
2.50.1


