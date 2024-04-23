Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A913C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOn2-0001p5-Ub; Tue, 23 Apr 2024 18:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmd-0001Tl-2H
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzOmV-00066E-E1
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713911909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hoQF8Lm1N8ikMeyUE2X894zmdVYzoeljUo5Ba3jFtkA=;
 b=Ybi3PZ5bT2fUq8SFFsFxOUCFBXrjLabL2AVi/zDhGjLEACFQ/k1gYZV6rln60yHi5EYqqU
 i710vVSvzg8BAAhnx+n60xpQCdQnC9xVo3f0WpK6uo4ftGnOEiFWU6DbH4i39MJ7GlP1KV
 +O3zpRwe7Q6CmU+H9BwE2jcfzbuzpy8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-KUMj5EY4OZuuW2PdyRZZuw-1; Tue, 23 Apr 2024 18:38:28 -0400
X-MC-Unique: KUMj5EY4OZuuW2PdyRZZuw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-437618fda71so19373361cf.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713911907; x=1714516707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoQF8Lm1N8ikMeyUE2X894zmdVYzoeljUo5Ba3jFtkA=;
 b=LVXgznawslKXi8N2S2MYDakT2/lx1Y3HgZRcBOueCGKJ6P9/p1koCvrOhGLNy1lOaZ
 w5ryNKMKTvHUOPNzHCvOnb5BWLXcuT5IMZy5Xb/RR11q75AbHZKISlH+1dKt9TCbT7Bb
 dbrdtdZrgnAF79N1foFqbnaw4i3S6MoRAdUS1n6d8gO6dMBL/IZ3wQPNF5JEkA9RXULZ
 hDOFz4Nq86SQrSlgOBz0tWJHY+GCBQQAPLiCoGHriuP2IFLS5Jc6I/afHMqkm/6LS7nn
 s8Yz76RpdyRWYT9uGMJQYB7owOf0wUTBfJF1NNnkVWNykkepRMZb1sSFu+k/rbh1NSGB
 gz0g==
X-Gm-Message-State: AOJu0Yzg2px7j2y1f4ZzM436F0t18H6VxleuBl4C5kX5fQdBybresEQm
 hxHYyv3nl9fLObIH8Nwo+et7bDnT4QGBnyu2rfcpQTJBQkRXayvk7Vo2ytuzmnuidcZ9OUUTm7i
 p5EidasUm8+otfMbLoY2xgTuC+WrjJ91f1++3nB53lUzLjd8fFzJg+gWRx5rLikvtcy4B8fX2s6
 W3Zceu8TkDzNNFqzO/TmDnCPncrDDEDcRbxA==
X-Received: by 2002:a05:620a:4010:b0:790:731d:f6c9 with SMTP id
 h16-20020a05620a401000b00790731df6c9mr898450qko.6.1713911907156; 
 Tue, 23 Apr 2024 15:38:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqAUfEJDjvQO+9sHzKXXrYpqkJ9KmXpwHvsI5LsJFOMCCEOW0DEkKj3zhY0sMgyM262fmaQA==
X-Received: by 2002:a05:620a:4010:b0:790:731d:f6c9 with SMTP id
 h16-20020a05620a401000b00790731df6c9mr898418qko.6.1713911906467; 
 Tue, 23 Apr 2024 15:38:26 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a11b500b0078d67886632sm5647726qkk.37.2024.04.23.15.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 15:38:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>
Subject: [PULL 07/26] tests/qtest/migration: Add multifd_tcp_plain test using
 list of channels instead of uri
Date: Tue, 23 Apr 2024 18:37:54 -0400
Message-ID: <20240423223813.3237060-8-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423223813.3237060-1-peterx@redhat.com>
References: <20240423223813.3237060-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Het Gala <het.gala@nutanix.com>

Add a positive test to check multifd live migration but this time
using list of channels (restricted to 1) as the starting point
instead of simple uri string.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240312202634.63349-8-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index af5e7dc6d6..be67a92536 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -655,6 +655,13 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: JSON-formatted list of src QEMU URIs. If a port is
+     * defined as '0' in any QDict key a value of '0' will be
+     * automatically converted to the correct destination port.
+     */
+    const char *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -1721,7 +1728,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -2721,7 +2728,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2766,6 +2773,21 @@ static void test_multifd_tcp_no_zero_page(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_channels_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .live = true,
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3669,8 +3691,10 @@ int main(int argc, char **argv)
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/plain/none",
-                       test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+                       test_multifd_tcp_uri_none);
+    migration_test_add("/migration/multifd/tcp/channels/plain/none",
+                       test_multifd_tcp_channels_none);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
-- 
2.44.0


