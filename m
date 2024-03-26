Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ADDCD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72l-0000MD-2r; Tue, 26 Mar 2024 09:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72e-0000Ak-SJ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72c-0005JS-SK
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1WyM23yZC7OHPkKjODH8U9UyVky6gI6o4OQy8pzYy0=;
 b=XamxSrbcknmMXynymWXWyABJZj7TakuW5QmNvWlJqz/CavAV+ubwzBHC9HSWY2J4tNaqhO
 O6PSyUgf8Y4yZspUoxsoXMTFkVcuaXMYeSFhC4DeUjA5FsJcyOHrFSbW3P98oPSGJWv9Yd
 bVIR+u+NYOKmDxjzdJ4SAp1byyF0jQE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-8z9fqjWCM8GwDTBYOpJULQ-1; Tue, 26 Mar 2024 09:40:37 -0400
X-MC-Unique: 8z9fqjWCM8GwDTBYOpJULQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed26afd99so3028542f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460435; x=1712065235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R1WyM23yZC7OHPkKjODH8U9UyVky6gI6o4OQy8pzYy0=;
 b=f0E4enwhPh+w9beyppVAQokkr37oXyWy9lbX4xx5oWWTxC4SraNYXAsSIeYffNujVe
 eoEEUrjD4XNLh13U5JW7zUh4J/dPdEEwr9lpvIeSCEuLa5xaPvUhCbvJSkhlia/ENYKX
 bjmRCxglilQDR36Y6lGGaEQCbyI8JUEZ7bubf6MJV16SHtZjZmOg4wHe7iPNv4oiYh8M
 NNuePueOdfbeyEfTN1it2tk/koVnguY4glsrEVjqNxwqB3ldE57Ma0ci6/AlxFwaesM+
 4Iy00zi5TiVsEAusbneYaXNwr6usReJUTbffcMg9Zx/7hY9BkGN/a/Li1y1SU0cax4+K
 uprQ==
X-Gm-Message-State: AOJu0Yx63Bn4mwQMhPfJ28ergx6oOVrt/fCK5Qs8xKEfC5paIRmTqWDe
 tN/liONg1XdqA6eTdimEvvcM+1OmDXXfgdyTNWwfcb+vW+LK+ZpQMtRNIUPtEDNC0ImP0VHCPCB
 z0isr7v+WwB7H9WVra9NoiKhLi7h/dj2gj2yjX/JHryu82CfKvbxQLqOVol+1HDCHvPQ1V3/lA1
 0AWxKNJLlIRWsvd3NnzQPka6AGUzBcLCIYhMzw
X-Received: by 2002:a05:6000:183:b0:33e:9292:b194 with SMTP id
 p3-20020a056000018300b0033e9292b194mr6738439wrx.14.1711460435542; 
 Tue, 26 Mar 2024 06:40:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6mIgSTpyQ0Km2N2hF7JemQsv6sAt7ZdtszCF106i+8SR/HsHHnFwygvRT/znoxYpamVAOfg==
X-Received: by 2002:a05:6000:183:b0:33e:9292:b194 with SMTP id
 p3-20020a056000018300b0033e9292b194mr6738407wrx.14.1711460435268; 
 Tue, 26 Mar 2024 06:40:35 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 n10-20020adfe34a000000b0033de10c9efcsm12194551wrj.114.2024.03.26.06.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:40:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 11/11] tests/qtest/vhost-user-test: add a test case
 for memory-backend-shm
Date: Tue, 26 Mar 2024 14:39:36 +0100
Message-ID: <20240326133936.125332-12-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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


