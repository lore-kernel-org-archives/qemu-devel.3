Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F5BC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8kq-0003Sn-TD; Wed, 03 Jul 2024 18:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8kn-0003GL-VP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8km-0001Xk-1t
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGhmwqguo7pIYQaZC7WOHDuKcF1Cau7swIzTfVk8co4=;
 b=Yjc3IJw9i2fXiCoBQ7+FveUd8sPhFCS29V14aIylc3mQoqFlau387mSvZSwVmqRLL7iysS
 0H7O7WIW2yqBpaUOSgdrhS7wT27gjgcffV6hlenTsOQ8o3wQj0h4r20hvYqKQx0MIXDBnr
 MgAop+8+aLgsGM8maja9om7N+YDOqxQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Z4JkYvqLOA-zuY2XZI772A-1; Wed, 03 Jul 2024 18:47:06 -0400
X-MC-Unique: Z4JkYvqLOA-zuY2XZI772A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57cd2950eefso6616a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046825; x=1720651625;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qGhmwqguo7pIYQaZC7WOHDuKcF1Cau7swIzTfVk8co4=;
 b=bw3G2cvE5v/UO9S50mDVUDMi5vICLl5tllh3iA9H+s4opq2XSMsMP6cB+5IdjbUfXA
 p+5FDbBKfWxG/JTNTf5nmhCegCtQNivRaEg1xHW8cuJ68/se2qezL7VZkhXrnseD4aJC
 JNOuvc4rswF4y5ATA07E4TE56cS3TpXJLMDaw20Y7t6vWlxZ6xvhh+atvVb7Uz6P0MqP
 Sji43aBCP/aZKViVLYRQT7tuYSXDZddBKWldtWITu26pJrJKj/yZb4l9jkbKDzVR5kFK
 6d+d6Mr0YpcAYo5CoyjqymSrCoeWraV+tqS6g+9M9MpwhRtYa/xptALyFTR/hFCwb2gO
 IbfA==
X-Gm-Message-State: AOJu0YxLtOnpaZTUcT+FaGOJx2XuFxe2bdb6o7eCQmtuARQzAugTQvCb
 wgnUc/dl+45YxzjNgYVi1iiusUWex2xS0WhzFbDupy6xxMXsWuwTlAHpcqI+RneOJL/0rSVMb99
 B7C9kheoWZdX/VLjqPBYy133Ho2HYkwmWrl0qgQwtUfslGEqYihWpGtISAk45/7T246Sr7Xgd4o
 WHeMxw8MQlnNs4924iX8pH3rcZQPb29w==
X-Received: by 2002:a17:906:36c6:b0:a6f:b75f:3d46 with SMTP id
 a640c23a62f3a-a7514475c22mr878954566b.43.1720046824755; 
 Wed, 03 Jul 2024 15:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPlxWsC2gdMHau1HWYY/a/6YQtTGMUy5LcCafRaKt91Mv1Drlv/1Msod3dn5FnoXKlACj6og==
X-Received: by 2002:a17:906:36c6:b0:a6f:b75f:3d46 with SMTP id
 a640c23a62f3a-a7514475c22mr878952266b.43.1720046823699; 
 Wed, 03 Jul 2024 15:47:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf18b15sm551162766b.19.2024.07.03.15.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:03 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:46:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 35/85] tests/qtest/pvpanic: add tests for pvshutdown event
Message-ID: <b279c3c88da3e8a301e4436fcdf233c0838ed4bc.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


