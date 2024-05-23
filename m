Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67920C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9tX-0005Zj-Pw; Thu, 23 May 2024 10:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sp-0004UQ-36
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sm-00047X-1a
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qTvP6lxIhuzEFJYH1iq7oEMz1Xbgzhb1MVJySeq+gQ=;
 b=Qtdq3f8MYy1K2TxgNiATrCqAm1J1YvjyCgtwudKi4vMJ4pTLCgGKMbpwCKU5SV1GEVuGWd
 ZysACbjf7bure5iv/djae2hG40mcisctfLJaK16FpqEYE46j5AhH4zwJIcjyP5YH0wCmDN
 /VherCTeXCYYD5ChT3VVhXPcMxEXsQM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-pHZsB537NzyHQUcHcbFddg-1; Thu, 23 May 2024 10:57:26 -0400
X-MC-Unique: pHZsB537NzyHQUcHcbFddg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792bd1dc658so35998585a.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476244; x=1717081044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4qTvP6lxIhuzEFJYH1iq7oEMz1Xbgzhb1MVJySeq+gQ=;
 b=jIEoKZrlEynE6fSspqLo9QaPBdpCshvLjZHu0bQcDYHzAM/eqn6K7D/Q1jQEKVOFXT
 ypyabMwMfRR5A15dLH4jBMK2fHgvoRPaWQKVQAOEGf1JXP65vB0RZHLHc/XIDhyG0qho
 Cm/fusx4e9tegKPvRFWsHP4fAp02I25WtRfijpbuhz+mxXoxaEevPZQK6CA0dG6idKGS
 6EFfHDJsLMSsQqaKtvGegUY+zJnPIIrkI1RIzxWOgLXYoKa8drIZOXdSf9mvMjK6QjUB
 7RPLqZmR6e7sIKM8bhKmBsRLaLDe99OFattARPMeWAT1Cfsv1yYSmNqj81gtMP/sPRCZ
 zU5w==
X-Gm-Message-State: AOJu0YwJrL35O7trIU5TNJihF7eu05QXRsrF7IUxDTapmzByIcwiXAh+
 wLDnez83HYCxOalC6FbbIQaoKkJiTQKmmQ3DdJxynNqgCI6CHSLYRwc5poQbwvQYJYPOexkfLPI
 pRl0YO/Ow+0ZJFLWHW871/46e481GGl5SBHgNkDU0C2hOpZaYlfI4+M9j28J8YitbeZjEm8CH0o
 yPx+sE9EPNWA+FS9kePXGnY+g2hLBZXRHBH5m+
X-Received: by 2002:a05:620a:2443:b0:794:9a59:351e with SMTP id
 af79cd13be357-794a0a424b1mr439564085a.38.1716476244169; 
 Thu, 23 May 2024 07:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp1yk4jpZXBC7fK6rr6gmRwWPbVRC83ZwhgPHVBlqcc9fA+mWGWGswNg8LMwlL6pRnDDgiXA==
X-Received: by 2002:a05:620a:2443:b0:794:9a59:351e with SMTP id
 af79cd13be357-794a0a424b1mr439558585a.38.1716476243673; 
 Thu, 23 May 2024 07:57:23 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792db4083c1sm1185772885a.76.2024.05.23.07.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:57:21 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 13/13] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
Date: Thu, 23 May 2024 16:55:22 +0200
Message-ID: <20240523145522.313012-14-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


