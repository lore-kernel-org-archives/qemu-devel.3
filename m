Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD40CC54764
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXOt-00042o-Cf; Tue, 20 Feb 2024 16:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gxXVZQcKCjgeigfiXcaiiafY.WigkYgo-XYpYfhihaho.ila@flex--komlodi.bounces.google.com>)
 id 1rcXOp-00041C-Id
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:35 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gxXVZQcKCjgeigfiXcaiiafY.WigkYgo-XYpYfhihaho.ila@flex--komlodi.bounces.google.com>)
 id 1rcXOo-0008QZ-2P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:35 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dcc58cddb50so9386955276.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708463491; x=1709068291; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qGn7OqTFb3X8RvO5w9/pHkj8ntGZYMZY8QEa64iaYvY=;
 b=AWv7nEmM0HmAP+85mRzHwilLNrG8+bxiR1sMjXbqQb/xDLm1VArtbQCy1nJCiwqLC5
 tZC2tE9rZkWi40tlpuKtg0vqCydVcQcfH6OZLJ3D34kjJu1EhTm3A4QbeIhptL3vxOdh
 Bd+FRyNG3WyNjxevC8+rqBgElSPjEg5XSqeUTyJjOsz43Ay/Kx+huo+HKFXVgh3Fu72o
 /qu71y6D+lX283qt9dbCPS/pyEoiYVaK9nV0ZqmHTZALKtZCsGfWkpxhLFn5fjxjNC8f
 j63b7UvD1/k7SN0RxCaOM6y7PA5GWp925O8pzziIwtNjNSBkPQNH8nVNzv2MAZMoGeix
 mlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708463491; x=1709068291;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qGn7OqTFb3X8RvO5w9/pHkj8ntGZYMZY8QEa64iaYvY=;
 b=kaNbe31KFE4bNv2qjFLePJX2liYLWix4OL4C615qPRA7I0WmapUWpkH2iWSedfYaFj
 7lWw39HMmJ0dFblKB0XUGpzvniLC719C+lpJ5Nu/k0lj3+iw94Ukpv7mRNQoQFfi1k1C
 RkdCNDIZ/dYqlUEh+NyCnAxf89+A5kkvx/eYeFOyQJYHay718jvvk408+NCdAN4DKcRr
 aaniU6ebPccv5ZnuxWFXrzs4AIDcDOf6ZgeNc+kBDq/SLRKcf4853Mh4vzVmKSm0MSkt
 5SvFX4MSbZap0eQiGopOzWcJO8kZZmQocH5OVv+2pKVW/WmHOl1pvLc4IFTZcWccFY2V
 DZYg==
X-Gm-Message-State: AOJu0Yz9fqoDPwpPwz04bzw9T1tfVyRwTTyx4dgxSJO0iInhJQXpN9Kb
 1d8EDtCzVPUx7HBWJWW+zVuLirr6RAxK4o42vFDL1PYcJUXqQyUo7F2uGj4ag8bugL14/J4QPgp
 /0rrltsJxA3TYpqd4xJ5ytGyydmPUSs4Xc5Od/xch1w+WacDh9XmryfeDdMegkkFj7xG0LfVLFY
 f4kTL3zkER8eSbjcJuiJlysjIzY6zNTCNn0p1q
X-Google-Smtp-Source: AGHT+IENlQ7IaH94cyy5alIC5kqgCw4BXz8ldkulhyGDmFEnJsN0qfgUPqPtk5Pe1zArZKnL9jkMCE4K//+N
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6902:1209:b0:dc6:e1ed:bd1a with SMTP
 id s9-20020a056902120900b00dc6e1edbd1amr4375448ybu.2.1708463491539; Tue, 20
 Feb 2024 13:11:31 -0800 (PST)
Date: Tue, 20 Feb 2024 21:11:23 +0000
In-Reply-To: <20240220211123.2664977-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240220211123.2664977-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220211123.2664977-4-komlodi@google.com>
Subject: [PATCH v4 3/3] hw/i2c: smbus_slave: Reset state on reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, venture@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3gxXVZQcKCjgeigfiXcaiiafY.WigkYgo-XYpYfhihaho.ila@flex--komlodi.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

If a reset comes while the SMBus device is not in its idle state, it's
possible for it to get confused on valid transactions post-reset.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/smbus_slave.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 9f9afc25a4..4615e8b097 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -201,10 +201,19 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
+static void smbus_device_hold_reset(Object *obj)
+{
+    SMBusDevice *dev = SMBUS_DEVICE(obj);
+    dev->mode = SMBUS_IDLE;
+    dev->data_len = 0;
+}
+
 static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = smbus_device_hold_reset;
     sc->event = smbus_i2c_event;
     sc->recv = smbus_i2c_recv;
     sc->send = smbus_i2c_send;
-- 
2.44.0.rc0.258.g7320e95886-goog


