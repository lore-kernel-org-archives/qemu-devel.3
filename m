Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F595C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJVix-0005la-3X; Tue, 18 Jun 2024 06:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVim-0005Kw-4N
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVij-0001Uf-UJ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNfNqVgiPACxEos23z/KKmFGM3slQs8eIq4L2oKEPI8=;
 b=cd3RyXMyJ+NcJMerv+34TQXZda/McuoNmvV1gA4XyTP1yXki6bDuZZ8uy6++qd3+7Dd8GX
 jxTqWSGbNIt+voJTnBcCa93CZ2Sb/buj/xaiP4zt9OYORiLaubu7QK1RtPMqpETE7JsHJp
 hZuGiI+EYfbMYvWHhaGyGW3Dx02pAN4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-uHrNavzQOuGYbVQTqORrNw-1; Tue, 18 Jun 2024 06:05:41 -0400
X-MC-Unique: uHrNavzQOuGYbVQTqORrNw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4247047e74aso6859285e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705140; x=1719309940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNfNqVgiPACxEos23z/KKmFGM3slQs8eIq4L2oKEPI8=;
 b=cuXTbII6O1cSUE4wW9Zt/hwJcNPlcRQ6koiiNwB3xcpCdKGxQoNuvArYI9d3ACeoZ9
 o6DuJE0UJIzr/+lchkzHdC5ZmQxseIJsie2vs7iDWpAmkuV7Y9GVpcQ6x/WiElZrR6pp
 Xdz4zcQCwCmdaZmq3F9C5I2JUiRQ8xgiXyQeI8CnOPFAaBdzgHyxGwTDUaljkMQi6EfR
 aTusid3/2C0C0LE6lwt40I8Kp18cCfM/uc8SSbs8VTQGFIBxuxvRBU+uFduJ4YpnWz7z
 jnfsirsxPM3NmqMa1QawncjSlKXu2Sd6GjPp7utrpYkYUPIBsqycUWmKAO0w0ZyTZDll
 bUnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlQryz/LRlniSyi/ux8diD2J161nyDPpQhlH7zyQtX/Q6l89chUQjVopYqNd65jASJ1ifpmtOsHS3Vt0NYP0rdMBdiMes=
X-Gm-Message-State: AOJu0Yw1zHnbOtP4WhNCE2N5cHdF5QWsNmAKWISAQlDTytag5P1D+es6
 YR0oIu9Wa81OIR6xeJ+coFWAgdU8L8WmUGgzcHx1gwbFacMD60vpUgNnAtbiRO7gpeDHMcEN7gn
 djdIBscDjRC3EJIzAo4zSyvTbMZzBrkafDzR5UYlcY8yy3QtWIXNq
X-Received: by 2002:a05:600c:3c9a:b0:41c:2313:da8d with SMTP id
 5b1f17b1804b1-4230483252bmr136566445e9.0.1718705140589; 
 Tue, 18 Jun 2024 03:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE52dnZ/72DVn6ipXjceblA0qx4BqRMRW1Er6XSnVUrJfTjDv7BA6onSXJon+w5K1J+dltbbg==
X-Received: by 2002:a05:600c:3c9a:b0:41c:2313:da8d with SMTP id
 5b1f17b1804b1-4230483252bmr136566125e9.0.1718705140186; 
 Tue, 18 Jun 2024 03:05:40 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320c70sm183610035e9.30.2024.06.18.03.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:05:37 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 13/13] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
Date: Tue, 18 Jun 2024 12:05:34 +0200
Message-ID: <20240618100534.145917-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.45.2


