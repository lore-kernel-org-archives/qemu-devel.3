Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A886EC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjwv-0003fn-5G; Tue, 02 Jul 2024 16:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwf-0001zo-CF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjwc-0008Up-8T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGhmwqguo7pIYQaZC7WOHDuKcF1Cau7swIzTfVk8co4=;
 b=G0MaQSVaCzuYuUIwaHsYK/LERI39cZQmIv5/mp4NJTgzpNtOzzRC2ipCXAQSjGnBEbH9cs
 gkL8AV2ELHNL+KfCms9hV5zV40NZ4kUeJhfxn5hIaqAS+hRXPu1IO7CobX3gAWJ4Z3BonL
 xb6qbLI/XzyE3yCWIQtbM9QwWnpdkyI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-xOYXzdfoMEK7vvxffET_uQ-1; Tue, 02 Jul 2024 16:17:39 -0400
X-MC-Unique: xOYXzdfoMEK7vvxffET_uQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4255e9f5897so31717285e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951457; x=1720556257;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qGhmwqguo7pIYQaZC7WOHDuKcF1Cau7swIzTfVk8co4=;
 b=RvWq6/s/wh2bg+Cnj8R7u/8FHhMzLOpsaWcqArKBqegk1/zErQcmb4MS6FHABUnr5Z
 U2hCHfsWuoCJOmWbka6eb8ztR+pqoZTfaQwulcTiVbQP/6FIhZk+9Q4RaxAswjMc297O
 WYdZjePGbT4H98k6qO0Rl2JtjsqbLGHDli0zCsLy5dB3kHpedGwcmj0U5mKJ2mbnOnyD
 Zp6nX6PUJ8kNVNSEB5OtTpSOu4ardRVeTTJPY+UK54d7wiohM6njgy4iIhnUO3JWl1Sq
 C2Fm0Cq5i+luvd9jf/IfaNt91sX55Swb6qUwSt9N2FzvLbsSSYfqUg48pVPggISEYZfS
 opKA==
X-Gm-Message-State: AOJu0YxduCg2HD38yzDRpzjcHG9+Esfv5r6XZ36uUD3WtWmG23SQSws+
 2OmjknpC3iZnESGNkkatoKmsjOAbl9nOVLWMbtPJXgnfUpL/PmySWYA3a1/xFMSeCWPjGHz8cJ3
 s75QkuU7bDs+SqmCrZO8UlbmPxt4X5EBrePou9SnXZu3hP9IUxV1hpmvxpZd60CgdpXtDemONv2
 h7YkkCdh3GtTfXv0XVHmFwuPRghdeaSQ==
X-Received: by 2002:a7b:c4cd:0:b0:425:6385:83bc with SMTP id
 5b1f17b1804b1-4257a034fa2mr82745765e9.15.1719951457623; 
 Tue, 02 Jul 2024 13:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhg3pY6OGOhjyun6zpCOqX4x7qxb/5e9tY9xcW/1qRrzjlhRB3Ou+F0q/qVQZPNCoYDFjJBA==
X-Received: by 2002:a7b:c4cd:0:b0:425:6385:83bc with SMTP id
 5b1f17b1804b1-4257a034fa2mr82745495e9.15.1719951456916; 
 Tue, 02 Jul 2024 13:17:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c2afsm213909535e9.2.2024.07.02.13.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:17:36 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:17:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 35/88] tests/qtest/pvpanic: add tests for pvshutdown event
Message-ID: <b279c3c88da3e8a301e4436fcdf233c0838ed4bc.1719951168.git.mst@redhat.com>
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

Validate that a shutdown via the pvpanic device emits the correct
QMP events.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240527-pvpanic-shutdown-v8-7-5a28ec02558b@t-8ch.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/pvpanic-pci-test.c | 39 ++++++++++++++++++++++++++++++++++
 tests/qtest/pvpanic-test.c     | 29 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/tests/qtest/pvpanic-pci-test.c b/tests/qtest/pvpanic-pci-test.c
index b372caf41d..dc021c2fdf 100644
--- a/tests/qtest/pvpanic-pci-test.c
+++ b/tests/qtest/pvpanic-pci-test.c
@@ -85,11 +85,50 @@ static void test_panic(void)
     qtest_quit(qts);
 }
 
+static void test_pvshutdown(void)
+{
+    uint8_t val;
+    QDict *response, *data;
+    QTestState *qts;
+    QPCIBus *pcibus;
+    QPCIDevice *dev;
+    QPCIBar bar;
+
+    qts = qtest_init("-device pvpanic-pci,addr=04.0");
+    pcibus = qpci_new_pc(qts, NULL);
+    dev = qpci_device_find(pcibus, QPCI_DEVFN(0x4, 0x0));
+    qpci_device_enable(dev);
+    bar = qpci_iomap(dev, 0, NULL);
+
+    qpci_memread(dev, bar, 0, &val, sizeof(val));
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
+
+    val = PVPANIC_SHUTDOWN;
+    qpci_memwrite(dev, bar, 0, &val, sizeof(val));
+
+    response = qtest_qmp_eventwait_ref(qts, "GUEST_PVSHUTDOWN");
+    qobject_unref(response);
+
+    response = qtest_qmp_eventwait_ref(qts, "SHUTDOWN");
+    g_assert(qdict_haskey(response, "data"));
+    data = qdict_get_qdict(response, "data");
+    g_assert(qdict_haskey(data, "guest"));
+    g_assert(qdict_get_bool(data, "guest"));
+    g_assert(qdict_haskey(data, "reason"));
+    g_assert_cmpstr(qdict_get_str(data, "reason"), ==, "guest-shutdown");
+    qobject_unref(response);
+
+    g_free(dev);
+    qpci_free_pc(pcibus);
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic-pci/panic", test_panic);
     qtest_add_func("/pvpanic-pci/panic-nopause", test_panic_nopause);
+    qtest_add_func("/pvpanic-pci/pvshutdown", test_pvshutdown);
 
     return g_test_run();
 }
diff --git a/tests/qtest/pvpanic-test.c b/tests/qtest/pvpanic-test.c
index ccc603472f..d49d2ba931 100644
--- a/tests/qtest/pvpanic-test.c
+++ b/tests/qtest/pvpanic-test.c
@@ -58,11 +58,40 @@ static void test_panic(void)
     qtest_quit(qts);
 }
 
+static void test_pvshutdown(void)
+{
+    uint8_t val;
+    QDict *response, *data;
+    QTestState *qts;
+
+    qts = qtest_init("-device pvpanic");
+
+    val = qtest_inb(qts, 0x505);
+    g_assert_cmpuint(val, ==, PVPANIC_EVENTS);
+
+    qtest_outb(qts, 0x505, PVPANIC_SHUTDOWN);
+
+    response = qtest_qmp_eventwait_ref(qts, "GUEST_PVSHUTDOWN");
+    qobject_unref(response);
+
+    response = qtest_qmp_eventwait_ref(qts, "SHUTDOWN");
+    g_assert(qdict_haskey(response, "data"));
+    data = qdict_get_qdict(response, "data");
+    g_assert(qdict_haskey(data, "guest"));
+    g_assert(qdict_get_bool(data, "guest"));
+    g_assert(qdict_haskey(data, "reason"));
+    g_assert_cmpstr(qdict_get_str(data, "reason"), ==, "guest-shutdown");
+    qobject_unref(response);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/pvpanic/panic", test_panic);
     qtest_add_func("/pvpanic/panic-nopause", test_panic_nopause);
+    qtest_add_func("/pvpanic/pvshutdown", test_pvshutdown);
 
     return g_test_run();
 }
-- 
MST


