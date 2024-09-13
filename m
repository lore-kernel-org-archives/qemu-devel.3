Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5183DFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp803-0001fD-OB; Fri, 13 Sep 2024 11:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp801-0001e1-GP
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7zz-0007lA-Gj
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cae102702so9678775e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240453; x=1726845253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BiUIYlJOdOGKvvXaIvZ9uAJPTRW7M3bm0eR3W2ujliw=;
 b=hOicrIs5m3ghyGZnijH2VDtDnlxYPpZwCVd51tgw4odZuwoXp+6fAdJ+emhjGJwChN
 fIUEPVwebyQVzLj64zrNch0LZeb1uJMJIHi2xhhfsSu48FbVsFdCPNLD0bOJFmKIPYLl
 CaKkDvXnzU+nKmHb3Rl0SCTdDsFNLTi54buszZ1H5Jiyjq8h3teUWZ3QTkoHu1bLtVOb
 bLqTru7Wb1ehi0fDh8VMV/UFbzCvUiYLPF20r0b4pVKtpAvLd9cXx16FBR1boZ2wmaxM
 M5e8WxFIT9/W4e+ud4haMuWkfxfsYkvwSxNfERSWOl3JKM03J5ng61LBjrYmUXFEMtlv
 tr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240453; x=1726845253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiUIYlJOdOGKvvXaIvZ9uAJPTRW7M3bm0eR3W2ujliw=;
 b=OafsXddzsRDQoCroG3iDoWldAkoYpG3MDL1wIZGUAsJjgbvGHDG8BlIxdiPmdXVsDj
 mOsIXMvKjThBBbNzoKkE49FXVLBqJPdMo2W8/MdgzK41z9WO/PeuM+txqf+3uLeYydez
 cSs51R9g1fXJpFEJGz/C9tSuIeGLijPI4cUkROrm1Jsk1cKjy2WhQBDmkeYUgOVNpYMj
 S5mafeBoi3J2rLoBtTHQYQjTGSmKqUK93tOotGHbQXWnGiIV5RFuSQsgcUzUT2QtInM1
 7Z+eBURQFHzyJ52BqeDag2+Sr/HPyur4gfXn4a39aVuLeZHDsy88BjXJ2v/uG6BAoB8B
 qIQw==
X-Gm-Message-State: AOJu0YyEVqNJMUQbzmZXtg9qlr2U9IIQ2zLDQBhg7kdrMcKFoGa+m6Zt
 moiVnRwo4oMvguTbYc5sNQhKkIQ0dWy0/wqgxG2XV7IdAvCVbCxRqOfBgOicIAFlFY+qPN9G9+K
 4
X-Google-Smtp-Source: AGHT+IEzUbv8NYajuQbjkAfeWs7UOsBKCWay1JuW/tPEcSl9badXloLJ03utnsMSs77iERWKU5/R6Q==
X-Received: by 2002:a05:600c:63d3:b0:426:6a53:e54f with SMTP id
 5b1f17b1804b1-42d964e10b0mr21125425e9.33.1726240453398; 
 Fri, 13 Sep 2024 08:14:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/27] hw/s390/ccw-device: Convert to three-phase reset
Date: Fri, 13 Sep 2024 16:13:45 +0100
Message-Id: <20240913151411.2167922-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Convert the TYPE_CCW_DEVICE to three-phase reset. This is a
device class which is subclassed, so it needs to be three-phase
before we can convert the subclass.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-id: 20240830145812.1967042-2-peter.maydell@linaro.org
---
 hw/s390x/ccw-device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index a7d682e5af9..14c24e38904 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -44,9 +44,9 @@ static Property ccw_device_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void ccw_device_reset(DeviceState *d)
+static void ccw_device_reset_hold(Object *obj, ResetType type)
 {
-    CcwDevice *ccw_dev = CCW_DEVICE(d);
+    CcwDevice *ccw_dev = CCW_DEVICE(obj);
 
     css_reset_sch(ccw_dev->sch);
 }
@@ -55,11 +55,12 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     device_class_set_props(dc, ccw_device_properties);
-    dc->reset = ccw_device_reset;
+    rc->phases.hold = ccw_device_reset_hold;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
 }
 
-- 
2.34.1


