Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC1FCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfQD-0004xw-Ea; Mon, 23 Sep 2024 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPy-0003u0-0a; Mon, 23 Sep 2024 05:31:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPv-00072J-GQ; Mon, 23 Sep 2024 05:31:40 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d43657255so661922666b.0; 
 Mon, 23 Sep 2024 02:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083895; x=1727688695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9bzZ/GFOvwUoR1zPglVl2k74UkcypgW81AHz/hJj94=;
 b=YhpoN0gpgd04lWaJCP03YjJUjm0acLgrUfcfj8ZVSg9YLclSFiEwAM4cpcFwSdUgtF
 pTKPl3DmnXN94f7KBCIQ7xdhjTbD0zJQyYZDZV4Knyfz4N109SujFjyisLVtxViSXcgd
 hhb19ngo93FuTykH6g3XfPibeY8medFQDnErBwp1afVF+btNcQ9VZUSg8ui9CjJGjpCj
 hrnEp9qFjNnPhdALIw2g3gJP7tT5lQzPmMaupU3CDnA4jqzvmWU7iL5R/28yOPISBIvK
 Md2wAxC36dFGc62pqwPjscmBzSuxph4kqGpAmuajzjsGZDQkK9KzBh4OdKirbc3mLA7w
 y3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083895; x=1727688695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9bzZ/GFOvwUoR1zPglVl2k74UkcypgW81AHz/hJj94=;
 b=PvNfMiBYMiHx/zJN+K+63DBMdNbwPULptCwL/Xk1truVguErYKe3XRA2KM148XkwCe
 /GS8errOhrSjJ8Ci177PJB2IPcVkE8Tu5thhpBvpA+rtIKs/zRJ4zrxPF5lSAahdV+iV
 3zPW/+Sq6hp3ZfH35lXoHs3o9h4g6DmLAtEwixcbAtMgcyteyp5kYq5YlNbTCDyc+OI1
 beXNE+GI1ami2f1VAhi4asMV/VXLRnp1Ne9Xn1+8DbH/uCl4rGyiAcbt9i4EoRP3Gikx
 SFjBFzvsdp1XE7uhuuP+OHfzarWzpu4w2J+uOs76HpOTO1Gl9z4ajLkpwINzJtisTqpH
 AXJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULcOnd/hXa8QvJwKbCyIewAMYFPBSCRpXfstBHxDXwSJFgMP8QWsjLHpI3ciCj/ZSbBCiDLZd/KY8=@nongnu.org,
 AJvYcCUkV3ztk4eB5MkL6dLkkKO+n9/uY+rqBObspaB9uNcmaqqzhnK89++Dq2jb0VM0ekafalqR9nv22iJW@nongnu.org
X-Gm-Message-State: AOJu0YwuzTx9prqLhrsz6rR+VKiF4WzV0StYb91C1yTkFzQLMFIgJcVx
 bSybKK9KzwxrqPAX7pXaUUimWdBQfwGT/6XOqK1QJJcUAlWy9e6kiD2oyg==
X-Google-Smtp-Source: AGHT+IElN7sgu8F6nrOsHxOV3IX+3sDJSzhAOAJB09zFAe31ce4ait1ch6jgYpJyOrr3muBTSzdnag==
X-Received: by 2002:a17:907:3f25:b0:a8a:ead3:8515 with SMTP id
 a640c23a62f3a-a90d514a83fmr1115869666b.65.1727083895462; 
 Mon, 23 Sep 2024 02:31:35 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 21/23] hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:14 +0200
Message-ID: <20240923093016.66437-22-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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

---
 hw/rtc/ds1338.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index a5fe221418..6de13caf99 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -14,7 +14,6 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 #include "sysemu/rtc.h"
 
@@ -227,16 +226,13 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_ds1338;
 }
 
-static const TypeInfo ds1338_info = {
-    .name          = TYPE_DS1338,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(DS1338State),
-    .class_init    = ds1338_class_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_DS1338,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(DS1338State),
+        .class_init    = ds1338_class_init,
+    },
 };
 
-static void ds1338_register_types(void)
-{
-    type_register_static(&ds1338_info);
-}
-
-type_init(ds1338_register_types)
+DEFINE_TYPES(types)
-- 
2.46.1


