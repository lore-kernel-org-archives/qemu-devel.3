Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766FCC3271F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyG-0000B0-A7; Tue, 02 Jul 2024 16:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjy6-0007PM-9C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjy4-0001E5-3L
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QybIKg16iYqXdH14Jxyn469nV1P/mwHXBmUUNkfpRqo=;
 b=HDP73mNVdx1wxzhYNdIv8KpBqaGtObXd8M3wPFuVrQ4+kLP0ZSs3e83lfi134RRe9/ZwcP
 EmfjGhThgnI8bzmYer5I1Btx1J80mzqmphHPqd4TUCJO6veRae9z4xbA8/he61g/t/6F4Y
 njLJrdUSYmGj+K9UnhIV/YUcvtE4vXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-qRverhCUNu27AP12k1pJmQ-1; Tue, 02 Jul 2024 16:19:09 -0400
X-MC-Unique: qRverhCUNu27AP12k1pJmQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-421179fd82bso32252925e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951547; x=1720556347;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QybIKg16iYqXdH14Jxyn469nV1P/mwHXBmUUNkfpRqo=;
 b=X2KZE9GUaOAGL7sgKU9nIJEZNyJhJvJ0cjIhHDvAdDR1jOhzJXcKqyjaBcztUwbHPQ
 lKpKgyYkhUtPXNMsJrPtt/IQmxO3YCJw7WS81AtcrMiZI5tb28KWWcYA33WiTKvLQNRf
 VX0Qk5ggcp+ZeZxNG5CGkuUBWmvbsUu2rYNDgCTXMg+mwncoXmsfM7YNjrmO4JJQ5kgi
 oUJPSizX9H9XAIbZe8x3Fr9WqtSSIuISSA9MrJxGlhcRqOiB2p0uSwde8UNG5nRdbwgC
 ewYO0o7d6Wah3wIZrqBndi+XbBBVtd07xofpmNf2ptA/MqWSuqwADyxB6/Tmr18js4P/
 LVNA==
X-Gm-Message-State: AOJu0YzoC/aDToLN03x5zHCYVcKfYXZ8Tjkowt6jYRJ+3J2qWZHU65e8
 GXPbkIkCBEL2zyml9hqtFYEqMVydGh8/Aa6Pb3JiEdcSm0ROrfTWZjS+y8ZLKGlS7uDYxjkT41w
 lgNInci0aYqlR8vqS+ZqG+jtRYFjjcSGuXwhqLwXNkMhr1lvd+09RJs9FtwwiK/OkOoZEEaWa6r
 i8RmlWxgPGhSorGuNvy8/2Kp45BQsZAg==
X-Received: by 2002:a05:600c:4f93:b0:424:a7f1:bac with SMTP id
 5b1f17b1804b1-4257a02ce59mr71732565e9.26.1719951546874; 
 Tue, 02 Jul 2024 13:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc4k00HOxvGeHqh6EtyOwhksFkH4z0Jns2W6iqwtkMPs9965M5bTmdIKK+th1/v6X692GUog==
X-Received: by 2002:a05:600c:4f93:b0:424:a7f1:bac with SMTP id
 5b1f17b1804b1-4257a02ce59mr71732365e9.26.1719951546315; 
 Tue, 02 Jul 2024 13:19:06 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fb4fabdsm117991205e9.46.2024.07.02.13.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:05 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 58/88] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
Message-ID: <15bf0857c36fc0308717430d90a63a0477aaf67b.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
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

From: Stefano Garzarella <sgarzare@redhat.com>

`memory-backend-shm` can be used with vhost-user devices, so let's
add a new test case for it.

Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100534.145917-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 255bde54ab..0fa8951c9f 100644
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
 
@@ -791,6 +796,19 @@ static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
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
@@ -1084,6 +1102,11 @@ static void register_vhost_user_test(void)
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
MST


