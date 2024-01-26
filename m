Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40241C48286
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 00:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTAVe-0003hy-Hr; Thu, 25 Jan 2024 19:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FAOzZQcKChsBFDCF497FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--komlodi.bounces.google.com>)
 id 1rTAVc-0003ho-SU
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:52 -0500
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FAOzZQcKChsBFDCF497FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--komlodi.bounces.google.com>)
 id 1rTAVb-0004pl-DB
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 19:55:52 -0500
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-6ddc0c00548so159489b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 16:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706230549; x=1706835349; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=74cunFynwvkzRUDx4X5VXCWmCK7vcZabzytdkgQtYvo=;
 b=NPNAaasGnDZ8/DY2dz+/xmE40CemdJnV7itr4Q7cSgJze4drLm604dc6+DfIGHPRdd
 /lqHLLGNTKagdBndTxVmnk2l8jSaDV+zjX4pYlKz96j8qmsk/U4Toaerl3hSV4zL+iEt
 a2diTqd2mxRNK5bl9q6f4NF3PTQm310+yaIzLsZDDn4Zaq+yE8PAxvR7fISHKg7L5ehU
 2TU89SaiyfMiuuiTrMv8WbgY3VgTwXCSkcZVWAZaSysXegWna1wV8eu639We278sTbf6
 +HgHhVKp5aiK8jyfqL43F9h8sxqreyY4EAMGGCa9tQjD7/TtF3kOppwBCOp9/3nY5fAa
 4xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706230549; x=1706835349;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=74cunFynwvkzRUDx4X5VXCWmCK7vcZabzytdkgQtYvo=;
 b=qFz8f6zIsZ3fawl9Qn5jbIjQQSnA5hrIp0J4FBvxATNZ7vr8oqLgkiGSjbTxC+xgBc
 VI3mdt+vT9hYpsgrJpc1QgJqKKzruZdrLzALCKAYJi90EQMeB9b5ugoC6T1ajhBBo630
 FBQ7yaYgRXj6htECWxtNHpEZKkfrC8uXEwKb9XZvOsTEuSPTlsWqDFve23yiBzW0lGH8
 vMVWX7gEECAOX7epvc5RgjIISfNF+aQtoBoO2mnFiGkMYNEzzfl/Zp65/4m0Tw9+XP1S
 kvWVJOOPnPkDiz17SSu7WJ11B345rq6+4rbJsyLQdRJP/4BmLp3YvKtgRnUQ3sA4z057
 T7jg==
X-Gm-Message-State: AOJu0Yxw0gIG3wJ1qrEytmxvatxds2jkm+PTlbROs4L1+tBHP2u8dGvh
 r2yOqL2dK05NdWPAs26hNT074wpMTuCVGWPL6y2WSdZz5fsxxcVgSrTVzQpvirkpibaEDtnNz75
 KVNOcSEtbSLpCHKqvvPt32oH1hdePl+Ncnb6kVxzHEhOZ7PIqnjSyITCtpbiOH5v8jyFqs/f8+2
 u4HcKgB/1ryVD/p82vQCKtj7Qrh5iMby3Oe1T+
X-Google-Smtp-Source: AGHT+IHlMHQVNiwO0UYRhkGOogcQ/4SY1Iwl/nyYcmhhyrslGLgMnBKquAsKJXIPm3My34V29/IRdym6SSFe
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6a00:f8e:b0:6d9:d506:3afb with SMTP id
 ct14-20020a056a000f8e00b006d9d5063afbmr106660pfb.0.1706230548743; Thu, 25 Jan
 2024 16:55:48 -0800 (PST)
Date: Fri, 26 Jan 2024 00:55:41 +0000
In-Reply-To: <20240126005541.1839038-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240126005541.1839038-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126005541.1839038-4-komlodi@google.com>
Subject: [PATCH v2 3/3] hw/i2c: smbus_slave: Reset state on reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3FAOzZQcKChsBFDCF497FF7C5.3FDH5DL-45M5CEFE7EL.FI7@flex--komlodi.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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
---
 hw/i2c/smbus_slave.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index e24a1ef472..58abde29de 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -201,10 +201,19 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
+static void smbus_device_enter_reset(Object *obj, ResetType type)
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
 
+    rc->phases.enter = smbus_device_enter_reset;
     sc->event = smbus_i2c_event;
     sc->recv = smbus_i2c_recv;
     sc->send = smbus_i2c_send;
-- 
2.43.0.429.g432eaa2c6b-goog


