Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEAEC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kf-00026e-KL; Wed, 03 Jul 2024 18:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kc-0001qh-G4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ka-0001W8-NF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+zh1wfaSmmaGh+SRQcFGybC5BaSt211Udvwvhl5h14=;
 b=XFY5RH29j8/GjOKIHHlxN4hhmp/glUGOfWj0h1GySreuVF1UIVE36dKN0W21rh7Rw8ZUNr
 iFuUCG7CnxvpxzGre9U6A0V793UHz8KMP1SWxbAtsitX5E6vfBF1NYz/ieHtLDf2u8l3lm
 2cbVXipx33Z5hsAJ3tYNMjwg5zMZ8Lc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-cBJFv0OxM9isbwyIZoNIYw-1; Wed, 03 Jul 2024 18:46:52 -0400
X-MC-Unique: cBJFv0OxM9isbwyIZoNIYw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a751eb024abso1108666b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046811; x=1720651611;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+zh1wfaSmmaGh+SRQcFGybC5BaSt211Udvwvhl5h14=;
 b=NkiloIDK1R99VC7Ww/LzDvhgD0GbH7ZshFFY65x1JLOnTSIjVhrkMRVCnLwdxiKk1x
 lcIY3FALvej3M7SFHGkbXlExVUua0zvbYU2RR0Q5ssRQRTv5pnG4OTqIDwyXcYpBYI0G
 eVxATnOq50AtztcRr8mO+BI2GF4OMExTDOukKLpX+ZSm6BZAQZwY5rx7+OHWC9vK55DL
 dpuMHHCBZdNP5JPoN2shdaBG7yrEbZYDdKhdwrpbGAFqeRM+2HR749CLMA9xqxT/wTPJ
 d6mjbbIrTEJTCqlhhUZK/7BgzAUzQm+7WVLHkQdaOMOxQDuqMC3GEhv1K1V/isu32F50
 hjwA==
X-Gm-Message-State: AOJu0YyW6/ixha/RLW27FofS8If2xnSk0MCxKj/q1BcMhN4TERUgbXMk
 rzKlihzTSqFjjGl4QQxGRmCgZotGz+CqDF5vvAuTefo7yv5gfDDKAWscX1GkRQLCMrMDk1aiUsr
 U1WzFayirJska3g1Mr/VekJ8jqhTmkFzW4ME2bf5mnOJ18tV2K/wx5NPOOlP2oiI1CqkF0PEdfa
 02DcVvb464aFkCau3ohMgVNZ27dpdmFQ==
X-Received: by 2002:a05:6402:1ec1:b0:57c:5d4a:4122 with SMTP id
 4fb4d7f45d1cf-5879ede26f9mr12876717a12.9.1720046810889; 
 Wed, 03 Jul 2024 15:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPExu6usZD/kMUaYFt8GRmAvEeGxM0F4buZe1an1sEqDRFzlEgbRy/ouE7urzM2Edl0+WHxw==
X-Received: by 2002:a05:6402:1ec1:b0:57c:5d4a:4122 with SMTP id
 4fb4d7f45d1cf-5879ede26f9mr12876687a12.9.1720046809853; 
 Wed, 03 Jul 2024 15:46:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c838casm7684286a12.4.2024.07.03.15.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:46:49 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:46:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 32/85] tests/qtest/pvpanic: use centralized definition of
 supported events
Message-ID: <462dc749c110fe8e41ae0fb554b9bc2f2671e973.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Avoid the necessity to update all tests when new events are added
to the device.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240527-pvpanic-shutdown-v8-4-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/pvpanic-pci-test.c | 5 +++--
 tests/qtest/pvpanic-test.c     | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index 2c05b376ba..b372caf41d 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -16,6 +16,7 @@
 #include "qapi/qmp/qdict.h"
 #include "libqos/pci.h"
 #include "libqos/pci-pc.h"
+#include "hw/misc/pvpanic.h"
 #include "hw/pci/pci_regs.h"
 
 static void test_panic_nopause(void)
@@ -34,7 +35,7 @@ static void test_panic_nopause(void)
     bar = qpci_iomap(dev, 0, NULL);
 
     qpci_memread(dev, bar, 0, &val, sizeof(val));
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     val = 1;
     qpci_memwrite(dev, bar, 0, &val, sizeof(val));
@@ -67,7 +68,7 @@ static void test_panic(void)
     bar = qpci_iomap(dev, 0, NULL);
 
     qpci_memread(dev, bar, 0, &val, sizeof(val));
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     val = 1;
     qpci_memwrite(dev, bar, 0, &val, sizeof(val));
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index 78f1cf8186..ccc603472f 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
+#include "hw/misc/pvpanic.h"
 
 static void test_panic_nopause(void)
 {
@@ -20,7 +21,7 @@ static void test_panic_nopause(void)
     qts = qtest_init("-device pvpanic -action panic=none");
 
     val = qtest_inb(qts, 0x505);
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     qtest_outb(qts, 0x505, 0x1);
 
@@ -43,7 +44,7 @@ static void test_panic(void)
     qts = qtest_init("-device pvpanic -action panic=pause");
 
     val = qtest_inb(qts, 0x505);
-    g_assert_cmpuint(val, ==, 3);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
 
     qtest_outb(qts, 0x505, 0x1);
 
-- 
MST


