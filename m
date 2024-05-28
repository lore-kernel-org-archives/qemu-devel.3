Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210A5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:39:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuEM-0002OH-46; Tue, 28 May 2024 06:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuEA-00022f-OB
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuE9-0000HD-7Z
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jj9DMa1a2kLFeW0PYaRyvpcvlG+v7dmvNjlskp42Xlw=;
 b=BZtvUoh4s0MIUez37Hj5hRszqZwasOMoN5RPXBaGK30Xj6z1x3FDv9czwCnjlsG/Gpwk3n
 MYbFFK/WudPxF00uYwQGm37NRYukcx9up4aWWL6Uhm58zW8B6Cn/ToRnZMEKnNPg1DGiZ0
 DHiwbsQyjLjWmPOLO97a4vFgL9fOGvI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-YbgfjFMrNwKCr8VX_rviow-1; Tue, 28 May 2024 06:38:43 -0400
X-MC-Unique: YbgfjFMrNwKCr8VX_rviow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35858762c31so751630f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892720; x=1717497520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jj9DMa1a2kLFeW0PYaRyvpcvlG+v7dmvNjlskp42Xlw=;
 b=jPMzGrXMmnbSWTUGocUwiL1qiJ/cnEkKAsIbRO3FG6tW+ZJiCGtvCYpxobKp2RpF87
 6NfHm6ZaKmRXoL50yoXiHNmM2PPP1OPXmKLYWmqasxMlBUU5H1PqiMl/ULj1IJ2I/Bdq
 a/t2HMr+W99cxERKObyaU2GNrI+aHUEuYI9YVchvz7mp9oaIpj8Mx1VDZW//Wc0VPvG4
 zN+fPXa9jVsQHxBzAtwPSao6O+XIaoAiVk4uY3wGrWiWK5GcnRvRBqpltHW9O0U6Qnjh
 j4x/MbhXUIfNYgZzQeVlGkw++mpWQge2d4+lPfyYZ3yBqzxVSd7cdP/VE/xU5JMNaWuk
 7MtA==
X-Gm-Message-State: AOJu0YxgJ7Xo++EgQKGtGxgsp8o4nawjjtRYBiGOewCioFZDDfseij1m
 4KIG3aaVMugz4q6oUE2nrFEMSIKCeGsv6kRnSyp9VsOVW68Opiv0b+j0tnqzhVSG8BFv1jdtD5z
 y2az1EG9fPvmp8rZe3EaFv1HMNnXuuCzZ25BRZLH0q8Dlm6rD0oBAF0548JIQF7e06zcTW2VXL8
 xao5HnPoAfLMMvSQ4/ajTIbqlmKa+lhasn8IpD
X-Received: by 2002:a05:600c:3b1c:b0:418:2981:c70f with SMTP id
 5b1f17b1804b1-421015fdc48mr125139265e9.19.1716892720589; 
 Tue, 28 May 2024 03:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoa8bQibVSTUxgeoVSf0SEBhZZsLfkpa2WaY0Kwu75I2QpO8URjF4XBQ1gLGsfAcQ4Heshdg==
X-Received: by 2002:a05:600c:3b1c:b0:418:2981:c70f with SMTP id
 5b1f17b1804b1-421015fdc48mr125138875e9.19.1716892720282; 
 Tue, 28 May 2024 03:38:40 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089cd6f7sm137281485e9.46.2024.05.28.03.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:38:38 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, gmaglione@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Laurent Vivier <lvivier@redhat.com>, Brad Smith <brad@comstyle.com>,
 slp@redhat.com, stefanha@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 12/12] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
Date: Tue, 28 May 2024 12:38:36 +0200
Message-ID: <20240528103836.146338-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

`memory-backend-shm` can be used with vhost-user devices, so let's
add a new test case for it.

Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/qtest/vhost-user-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..8c1d903b2a 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -44,6 +44,8 @@
                         "mem-path=%s,share=on -numa node,memdev=mem"
 #define QEMU_CMD_MEMFD  " -m %d -object memory-backend-memfd,id=mem,size=%dM," \
                         " -numa node,memdev=mem"
+#define QEMU_CMD_SHM    " -m %d -object memory-backend-shm,id=mem,size=%dM," \
+                        " -numa node,memdev=mem"
 #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
 #define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce=on"
 
@@ -195,6 +197,7 @@ enum test_memfd {
     TEST_MEMFD_AUTO,
     TEST_MEMFD_YES,
     TEST_MEMFD_NO,
+    TEST_MEMFD_SHM,
 };
 
 static void append_vhost_net_opts(TestServer *s, GString *cmd_line,
@@ -228,6 +231,8 @@ static void append_mem_opts(TestServer *server, GString *cmd_line,
 
     if (memfd == TEST_MEMFD_YES) {
         g_string_append_printf(cmd_line, QEMU_CMD_MEMFD, size, size);
+    } else if (memfd == TEST_MEMFD_SHM) {
+        g_string_append_printf(cmd_line, QEMU_CMD_SHM, size, size);
     } else {
         const char *root = init_hugepagefs() ? : server->tmpfs;
 
@@ -788,6 +793,19 @@ static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
     return server;
 }
 
+static void *vhost_user_test_setup_shm(GString *cmd_line, void *arg)
+{
+    TestServer *server = test_server_new("vhost-user-test", arg);
+    test_server_listen(server);
+
+    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_SHM);
+    server->vu_ops->append_opts(server, cmd_line, "");
+
+    g_test_queue_destroy(vhost_user_test_cleanup, server);
+
+    return server;
+}
+
 static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *server = arg;
@@ -1081,6 +1099,11 @@ static void register_vhost_user_test(void)
                  "virtio-net",
                  test_read_guest_mem, &opts);
 
+    opts.before = vhost_user_test_setup_shm;
+    qos_add_test("vhost-user/read-guest-mem/shm",
+                 "virtio-net",
+                 test_read_guest_mem, &opts);
+
     if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
         opts.before = vhost_user_test_setup_memfd;
         qos_add_test("vhost-user/read-guest-mem/memfd",
-- 
2.45.1


