Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A4BCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8z-0001Gf-VD; Thu, 04 Apr 2024 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8y-0001Fg-3y
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8w-00015w-F2
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1WyM23yZC7OHPkKjODH8U9UyVky6gI6o4OQy8pzYy0=;
 b=iREpW8L0GFxSEQdJRF3Lisww0lntf/SvLhNwk2f2KefbAOm6LdONkKjaNVhYcyBgY+iQN0
 OE4alz9ruHfsbT5Q2bMYMgnrEug+bF9pNS65WMmxq70iR+VB/zHSuKFqG1xEWXx0sRTGfH
 UMWyzdXqox2YJOU6PPirN0qlzgOj95g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-_qWBfNcHNg-TsLXoT53JpA-1; Thu, 04 Apr 2024 08:24:32 -0400
X-MC-Unique: _qWBfNcHNg-TsLXoT53JpA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a474ac232e9so58362566b.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233471; x=1712838271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1WyM23yZC7OHPkKjODH8U9UyVky6gI6o4OQy8pzYy0=;
 b=klwaBXHM4pgmA8vuJ4+6Sqcc/RhJCUP8VQqswS9/OJZzLDFMzQg0FS9SNWZS6ejGMv
 Fkuqz2YyPtlfm/pPWB4nKek5fagGg2/hD4Fxfyu9tAC5L7Hz2flqycxJyyWzINnUrMKY
 k94X2WxpQF0zGarhpBPIKPvRbU/ul3//8ZANW/IbplZBGSoe3zb6VLhiJ//7GJKtsb4Y
 0LUcVUvBvISj5cURrllxFajlGMs4iziSlTFEPz/oCsNAznuCh6IEBVufvmz9oHgAfO+s
 G+eQ7rCX28x6msFY3LW58CFgIy5nNB7jaxW59ZeOV7IatBnFHf3McFEBQe1D7kjjrBM5
 Py8w==
X-Gm-Message-State: AOJu0YyI1C/7Up1XspBlKhkVLXioTblj5/sCdLbhcwycAmYPD7XcmNwK
 oJxmj8lzbNdgtmT0G8yPWJLHv1HoQqfHnv0lQeIolFjtskFQkxE6KgzKfEP5sjEH2YNT30QPP3E
 RcR+V8QfMXHTukuDPi8ZD4luP80QC4qP/4wPOb+3JrkE3Cdb0fq8EzILQ8epIqwE3X/xpnCSWYp
 x6mLOpcrFaVW3byJ0bnksmEKtCiBAvlxLwCRto
X-Received: by 2002:a17:907:9850:b0:a4e:42f3:3c87 with SMTP id
 jj16-20020a170907985000b00a4e42f33c87mr1681997ejc.60.1712233471121; 
 Thu, 04 Apr 2024 05:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa8HqwHIVn74d+5TwQ5e6856Cb33d8mpM5HS9fZrWrlSJxx+U719JVBIlsdtx7HxGm0w+qMg==
X-Received: by 2002:a17:907:9850:b0:a4e:42f3:3c87 with SMTP id
 jj16-20020a170907985000b00a4e42f33c87mr1681966ejc.60.1712233470790; 
 Thu, 04 Apr 2024 05:24:30 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170906309100b00a4710e7817esm8940046ejv.135.2024.04.04.05.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 11/11] tests/qtest/vhost-user-test: add a test case
 for memory-backend-shm
Date: Thu,  4 Apr 2024 14:23:30 +0200
Message-ID: <20240404122330.92710-12-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

`memory-backend-shm` can be used with vhost-user devices, so let's
add a new test case for it.

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
2.44.0


