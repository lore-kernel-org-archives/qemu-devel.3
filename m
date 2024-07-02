Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11A5C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeD2-0003ID-3t; Tue, 02 Jul 2024 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCr-0002ao-P1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCp-0008WM-VW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QybIKg16iYqXdH14Jxyn469nV1P/mwHXBmUUNkfpRqo=;
 b=dN8AFhR4kpaVxVvIBxNIdYeD4O6ayMSdwkCCAyZ4DAEDDdlJDdMXALGl1gTmRrS+mvrggA
 tbDBgkQBvOe9JyI1E5K0qJRX6cL0n2+zah7UMstenfRIGzWDXZFxP8owJQoDnJAVesA4mw
 SLiu1LeFY9rfarL1WobAB3bT/OTLzUc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-IzU3b0dGNTSMrW5A3mAHLA-1; Tue, 02 Jul 2024 10:10:02 -0400
X-MC-Unique: IzU3b0dGNTSMrW5A3mAHLA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-425739141c2so27419685e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929400; x=1720534200;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QybIKg16iYqXdH14Jxyn469nV1P/mwHXBmUUNkfpRqo=;
 b=dgMag1O+L9zfSuyR3ef/qa6fcegdFa2A7g+JGLTdlH0zVYfGBh0jMJ/9yIIhcwlzYq
 rGEHMVFzsZmUPE14wb3QIAel3I+A1kVL2wmwkWniDj7uIGY1VX7pXBQ3MLXRcUMIl8Xp
 H+LGhhxbwgmHuo1md8YzdqLQQLyNSfLY4kjWyxbRR1RYK9JMHgJtVt7tSmIwFk44wfkw
 LT4RAuNdy6EG7fN0nUmg+/RpX2Q6hoOHl3VvED9Ru3hJGket1+ICa84/GKfilJ5i4nZa
 3o3fXJlCdapAQz6qLhRHiI1ZQKiMQ08IXLwRUgz3kcb7DHROUXZBNobHTLfpOX1pVKjD
 HiwA==
X-Gm-Message-State: AOJu0YxJOfNviLfKNVM9/QMig7Z4J44z6v5IXhUbhcR4uH1a7mbNlq/n
 mbj9ZzMxcW82YJL38SyWqNdYUK9mr+ldLSPj1c9ntZGtPv+Eq8e2kBTiKTCOy5Gh5Kdwsh2ClJB
 zPpNyeHvf3g82cm409Idak1bwHX1rHbIM9jgTDvKdiwRcDITWGCr72pWxWIjuxWo+3u/dcBuXk3
 cm2Bq9jMww5xkv0P6Zs1bAN/PBOJxgzg==
X-Received: by 2002:a05:600c:12c6:b0:424:ada1:6d9 with SMTP id
 5b1f17b1804b1-4257a088e18mr77320925e9.34.1719929400501; 
 Tue, 02 Jul 2024 07:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl9FmzUp/EUK4GA1u0LQgSGoi2TW/FrnRT0JL5BVAGCmriZME0X4VREmN1CxYhw9ApWTydYA==
X-Received: by 2002:a05:600c:12c6:b0:424:ada1:6d9 with SMTP id
 5b1f17b1804b1-4257a088e18mr77320605e9.34.1719929399897; 
 Tue, 02 Jul 2024 07:09:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09890dsm200112335e9.36.2024.07.02.07.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:59 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 58/91] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
Message-ID: <e9db90230233a5f6844ed727902ace71de5620ee.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


