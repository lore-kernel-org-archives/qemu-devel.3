Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28789D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al9-0006ZU-3t; Sun, 03 Nov 2024 08:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al3-0006T9-O2; Sun, 03 Nov 2024 08:35:10 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al2-0001UC-8F; Sun, 03 Nov 2024 08:35:09 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso192814466b.1; 
 Sun, 03 Nov 2024 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640906; x=1731245706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PJZHCBpLf+Ed1Y0PojeiRWpqZynqPn/D87ewATJ+qo=;
 b=RnyLBvPmxX+pdSP8zVeG3MJzVduF+W6eOqNn9dhd5fs4GBKS3M3W8aeeUxppeHXrND
 haxNgrfCSn5lhD4dv/DUgcDs0SpyWcdIYRlmJRc0UXBvY1ghGI6hOMgxlFExUZM+CPEL
 5usTXKoTXKWzJZNo446t+pP5VCPTKmBOIg77Or9O0HGisA/Yz38npX9A8yIChJlp2Vh5
 mJDPNkKtBbRZdZCz+A9xD+gS1wJjmsWsv2uH3aQMDpYNrwHol1a3uZDjXVn5pIfEiieI
 DRaUpV0RUR92TPjLxFZo0ewQO2SIaXLUZgsTW8zqJpSnzI6dqbwbrfkfBv7JVmkNW6tV
 7AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640906; x=1731245706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PJZHCBpLf+Ed1Y0PojeiRWpqZynqPn/D87ewATJ+qo=;
 b=QTiq8HynetDDDz5TG67qTgj5GmyFIononfnMoYGgFmVOQd/5xCzEDzFpATgRcZ1IQ8
 mN4irgaatUr6rnBp5F2jub1VkfMk/JzuJ5rw9uI2WJTmJPWsDEonN0e2Vvp0i+sZHgPT
 JFQEk0e3fz6LxIJLjlUXcURcTgWoPlhnJiGtemRfoZVQ9nmLWNd93UAjt9picHJS43M9
 twZt8xakCG7LWfHp0Xk833+e2Kk20xLkuxah4CFV0rQqSHzy3yXoZMseaKfqe+zCwzl3
 jlpWLPftfPAshdlPUNhUVqheW8buyml/8jv362OI9KHh6a2QpmIatvY0SnASP2aWlUgx
 vyrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLFS7gFsylDR/ubAi5fGLFL5DqApWc+qdUKzmL8sD5Ke+63hce6V31kxxDIlEMHbC3ebmN42zvMhr3@nongnu.org,
 AJvYcCXKsSs+bcnsIVhX9sNv0qOqt3TAhqsnCPfxPJ42AZkQSduoIWAScTg/lMaiMiO/yVXcaYkK1+UyFLs=@nongnu.org
X-Gm-Message-State: AOJu0YwU2arnRFZ57hFTEB8ZoZvht2os22opcmEfPeR11hHiMEc1f5JH
 AwWsV3lvRagr237NlJAVH4c/Sxan/pb1H7H3VxB6ASe6+lK9j27IgBA0Jw==
X-Google-Smtp-Source: AGHT+IGtOLKgCt1GasDdGC2u2sCykJLirj/8W1heSBaSiaAYbStoa7SZh26WnkebgprhCvPOiEFYtw==
X-Received: by 2002:a17:907:3f20:b0:a9a:33c:f6e1 with SMTP id
 a640c23a62f3a-a9e6553c10amr937310766b.5.1730640905543; 
 Sun, 03 Nov 2024 05:35:05 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:04 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 17/26] hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:03 +0100
Message-ID: <20241103133412.73536-18-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/mpc8xxx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 63b7a5c881..a3c1d2fbf4 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -23,7 +23,6 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 
 #define TYPE_MPC8XXX_GPIO "mpc8xxx_gpio"
@@ -208,17 +207,14 @@ static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
     device_class_set_legacy_reset(dc, mpc8xxx_gpio_reset);
 }
 
-static const TypeInfo mpc8xxx_gpio_info = {
-    .name          = TYPE_MPC8XXX_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MPC8XXXGPIOState),
-    .instance_init = mpc8xxx_gpio_initfn,
-    .class_init    = mpc8xxx_gpio_class_init,
+static const TypeInfo mpc8xxx_gpio_types[] = {
+    {
+        .name          = TYPE_MPC8XXX_GPIO,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(MPC8XXXGPIOState),
+        .instance_init = mpc8xxx_gpio_initfn,
+        .class_init    = mpc8xxx_gpio_class_init,
+    },
 };
 
-static void mpc8xxx_gpio_register_types(void)
-{
-    type_register_static(&mpc8xxx_gpio_info);
-}
-
-type_init(mpc8xxx_gpio_register_types)
+DEFINE_TYPES(mpc8xxx_gpio_types)
-- 
2.47.0


