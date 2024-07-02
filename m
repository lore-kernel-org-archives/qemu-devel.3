Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AE0C31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwk-0002VE-QU; Tue, 02 Jul 2024 16:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwV-0000lH-PW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwP-0008TK-90
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+zh1wfaSmmaGh+SRQcFGybC5BaSt211Udvwvhl5h14=;
 b=NFrazuHP0/eetm8D+q4hajCk17F97CvmQ/Q5+sqhnZJRr6U5LNhkeN99mnVYI8NOwh/+gS
 fyDL2qvWqE23HMeY3fmbFwUJ333pfIl5NIlmd6ayCrPEzNErJ2v4EA3pOYn3y9I4/1XXNe
 vVIp7twhjGwNBn3cXNO3Nkb7XM+byho=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-yFD8Y88jMCKZ3wSWDIET9g-1; Tue, 02 Jul 2024 16:17:26 -0400
X-MC-Unique: yFD8Y88jMCKZ3wSWDIET9g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso19103805e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951444; x=1720556244;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+zh1wfaSmmaGh+SRQcFGybC5BaSt211Udvwvhl5h14=;
 b=qf7nGrv/OrKVOvb+o2TYTVNcvo5+S0BzhE5FhlYvqRlvdRK+LrHlJxUc4NgvMBR/h8
 6yGl6fIj/Xj6uTzYoHISNiy1tqOsLSHX3rULyo40euUe6ha6y+UkzJgK/0Ds6rD9yVWE
 f1CzxdKIr3xabYMxrM4ePigOEGvQZadPCICL883fkYvrfyqAKVBCgcIaSOdqiVbYHP54
 ao3eLxQwhdKLAYlhZu7NhFPriT7oXYOrEQnrNiNWMyicWdJ8S0bPzkaA0EZmFXtgGaxY
 rGo9pOfhao7PqqtoDeW/vLnIECj/qTrTpwNx+dzNyU+9nFCH9HYsTXQHkcMnvn9pdAdS
 pXxQ==
X-Gm-Message-State: AOJu0YwXd/PDjItwK0haS+33rkJ2YnjXrJncXIVDYq/iYN9m6M/5xFtg
 MXQe3L0YhXUtQA67n+DLLFL1DZaF9WdtUCVS3Ei6Bjnu7/Aqcua9CDEPAHygm5MLKrATtCCxwL+
 cH8FTrQdMlQ7fWcxI35UraLqwP9EbaPt6yoY4/g0VY6mKUWxzxeK3mDmjL9b4Yvz3AeZohYr1Sf
 XO0wk2GFOaznXAnqFqvlwo8vp33aLWLw==
X-Received: by 2002:a05:6000:2cc:b0:366:eb45:6d55 with SMTP id
 ffacd0b85a97d-367757215a5mr7851451f8f.49.1719951444138; 
 Tue, 02 Jul 2024 13:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiAVbUZ4OJ1tcHm8eM5E8z4ooB3+zuUlsqnLX7t9SwQ5/bIKYG/9ByZRrzUcl+F78j9XlmpQ==
X-Received: by 2002:a05:6000:2cc:b0:366:eb45:6d55 with SMTP id
 ffacd0b85a97d-367757215a5mr7851426f8f.49.1719951443419; 
 Tue, 02 Jul 2024 13:17:23 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1046f2sm14033151f8f.112.2024.07.02.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:22 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 32/88] tests/qtest/pvpanic: use centralized definition of
 supported events
Message-ID: <462dc749c110fe8e41ae0fb554b9bc2f2671e973.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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


