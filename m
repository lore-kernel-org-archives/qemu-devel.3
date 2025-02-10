Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C2C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW3x-0008N8-Od; Mon, 10 Feb 2025 10:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW32-0007Ku-9X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:15 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW30-0004w1-9s
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:50:12 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5de6e26d4e4so3170947a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202605; x=1739807405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hU1IsAVO/zRvXWw+5IDT2Vye4Emk4sjMX3L4S35zVsM=;
 b=xmRlPSLeJLuroASEw0T0EpxEh7WmC5+KabuqTynPQy5ThnWR8cGvxR+2fOFXqKRShc
 7MWBykydOkueuJvnVQwDNBA1TQyJddJFv9kB65EW6kg6BGzoeqEWYngslxkX3UrM9mGo
 Ta6XyKOw82QgM3uPTrpObRFd6l8ycIARWJfVS6XTvWEcfw8mZsa4Q5mHE7D6QCf4Ov9C
 XcF1SRVbxmOPPlxTLMCxv3h6gRaLL5rpXueW4us+kNMV/j0mIh/maaPggzIAl+rGdGAv
 ruOeOQ4XIM0Ka4DsEgaaQVWwYaM5i3HYBm/DKJmDs/f9it1vJVyT76ZxRcf5brZW2HTd
 wpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202605; x=1739807405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hU1IsAVO/zRvXWw+5IDT2Vye4Emk4sjMX3L4S35zVsM=;
 b=FzR0s1js3HNlr30xB7LTB/kSzEDqLH7hoE8OAmUJnP4Vp90rspNU3lS+vHiH5ee+8e
 IvhAnfRnuGuqd1okVJtta2lUAWuMHpP31+Co3DaAPtTBUKoD7pV3I0w1XEDmoYrn5USz
 wa+YMML9cqFsftbGWx+3v3qglVmxB27UJqsMqm2KMShqG0HTsL+K8A7aNYaj7/e0oR7J
 mnjgQkJPez7jzGXS6bT2+wBGCw/mGbcSrr1u665+QnGfKbTVVLb3ffMHRDRirwcuOfbo
 oTSfLf6P5q889XKiYfBDlVFCi3TTKBxVk4+PUVc2RN6RI14mq6ony/+JEFjdQdsM4dQ6
 BB2Q==
X-Gm-Message-State: AOJu0YzhVsPI2xxajZHaCUvPsCYPTxcAVgcadrA2LtJdEw4cBlRkrD46
 fnn6VkKpHrCEM8uHhccj5SMAXdy0IN1rGqvJzBcC5kLBGgpepGOUVKjgQZd2ICiAbXLqw7lY7pg
 F
X-Gm-Gg: ASbGncshGthp7ZULqo8UiDG2MkjlRIR4uU/llyW516eX9/2kn+sSVNm29eli908lBtj
 rgpyaeKIaB9kPETh0M+Z3qHJJteDwetOKxtOn3OsDSsdFYUyMOzPLhosA0Ol2gw2cEntaQX6HQu
 mngRlKaHytBXtW4tQ2sFKpUWajdIDL0A8eTYhh9zIlThI37p+IcE9XiUJTA0DTncsdm1eTYmOpH
 /CkDHNYmVmnWJR9GyagItBI3Xka6WV3dySSeBU3wdd2FJG6VGLiM5vCbvHfxAlvvG0GV2l5QdlY
 yH0FpUxiQr2i/0lbsisv
X-Google-Smtp-Source: AGHT+IENINeF0K1iaaDId55mOuqLgWUY45pOkEA0UxK6PnF4aKrQGjoaKEkHiqOXPO9Kx3uy/sdOzA==
X-Received: by 2002:a05:600c:4f50:b0:436:ed50:4f8a with SMTP id
 5b1f17b1804b1-439249841b4mr128940225e9.10.1739202593573; 
 Mon, 10 Feb 2025 07:49:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] hw/cpu/arm: Alias 'num-cpu' property on
 TYPE_REALVIEW_MPCORE
Date: Mon, 10 Feb 2025 15:49:38 +0000
Message-Id: <20250210154942.3634878-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No need to duplicate and forward the 'num-cpu' property from
TYPE_ARM11MPCORE_PRIV to TYPE_REALVIEW_MPCORE, alias it with
QOM object_property_add_alias().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20250130112615.3219-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/realview_mpcore.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 4268735e3a5..7480b38d1ab 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -14,7 +14,6 @@
 #include "hw/cpu/arm11mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qom/object.h"
 
 #define TYPE_REALVIEW_MPCORE_RIRQ "realview_mpcore"
@@ -68,7 +67,6 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     int n;
     int i;
 
-    qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->priv), errp)) {
         return;
     }
@@ -100,6 +98,7 @@ static void mpcore_rirq_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "a11priv", &s->priv, TYPE_ARM11MPCORE_PRIV);
+    object_property_add_alias(obj, "num-cpu", OBJECT(&s->priv), "num-cpu");
     privbusdev = SYS_BUS_DEVICE(&s->priv);
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
@@ -108,16 +107,11 @@ static void mpcore_rirq_init(Object *obj)
     }
 }
 
-static const Property mpcore_rirq_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", mpcore_rirq_state, num_cpu, 1),
-};
-
 static void mpcore_rirq_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = realview_mpcore_realize;
-    device_class_set_props(dc, mpcore_rirq_properties);
 }
 
 static const TypeInfo mpcore_rirq_info = {
-- 
2.34.1


