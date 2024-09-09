Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82761ECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkk9-0000vm-37; Mon, 09 Sep 2024 16:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk7-0000qU-OQ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkk5-00053m-RI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22RXMR5DYkLZTisVq+tQn5/56hW2wP8HWKKqqEW05PY=;
 b=KyvoPDdA9byNFNd03uMEeaDKIqTwgdX0sVZHJQZKoOmEYqQyHnG0KdqbnB8pppspAuRHDs
 Wpuc+r10sreALWxg7Dtcitq8mkgVNhpin/7f5GTNVF8ZrsSG2LY065LjDn4obpiFWr15nB
 iDoE4hsXPTyh+Bc2CdR9LYHqQLfHOFM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-sL8NK-VOMXagUV75VWrK8Q-1; Mon, 09 Sep 2024 16:12:08 -0400
X-MC-Unique: sL8NK-VOMXagUV75VWrK8Q-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4581efb73d3so45295861cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912727; x=1726517527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22RXMR5DYkLZTisVq+tQn5/56hW2wP8HWKKqqEW05PY=;
 b=tZcuGapDq5waxJjN9BYZpHB6tYUVr3mi99YCFxmFg4+UF6ZmAH/KbvU+MvkUq65igB
 KDUjg01beE4AnCjDH84tXy9GDetLZWvxVF93nXn7ks3MJ4MRYXNJi9cz8jhQsAEj4m17
 y4f2ZKZSz9OLU/GevifMRW4m5RXvcZXLY8vOQjNexr2pMmTpWY57hpyB+F80KPnSdZkl
 J881que5P7Oq7O5IISYOBJWRfFAcqDr5ZezThTEB4djLPEs82XfmM2UDPUZYYaWwwXII
 GCpp9+X3JkY4aOPp9e6HnIsOizarf34E6g/xqRLBqWcBNMZ+5/jMMjEaV5zDbpiEVGP7
 KVgQ==
X-Gm-Message-State: AOJu0YySLctxZGuQGPkDLeYkjHFYbSwONeecWom/oMIqI5Ludt/fYuWO
 f2rMfcbs51WjD2dxZ7MnVoj4KIAbf414nY/ubUgfqfCSCnpuBewy9H9ot5dnu6XeprE+3cBSmkl
 hQSmghvoKhfRiFRfLIGvRHCZQIsXbN+7Ql7Azgjm2rK6cHLG3PJZuYrWmbvstuIvq2a2QuPRBwe
 w1igMQWbBk0oRdpmx5xXI7THL9MvFkdAr/vQ==
X-Received: by 2002:a05:622a:11c5:b0:457:c7b7:a26a with SMTP id
 d75a77b69052e-4580c67e50dmr156436451cf.8.1725912727176; 
 Mon, 09 Sep 2024 13:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBNpc8PcW4Yu0Lh/xWDwHoJDT+rJRljxeQdI++FcsHcIXY5TJY3pvkGUpq48Lnpx+I4HXX/Q==
X-Received: by 2002:a05:622a:11c5:b0:457:c7b7:a26a with SMTP id
 d75a77b69052e-4580c67e50dmr156436021cf.8.1725912726766; 
 Mon, 09 Sep 2024 13:12:06 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:12:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Hao Xiang <hao.xiang@linux.dev>, Yichen Wang <yichen.wang@bytedance.com>
Subject: [PULL 8/9] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Mon,  9 Sep 2024 16:11:46 -0400
Message-ID: <20240909201147.3761639-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds an integration test for 'qatzip'.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Link: https://lore.kernel.org/r/20240830232722.58272-6-yichen.wang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9d08101643..d6768d5d71 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2920,6 +2920,18 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QATZIP
+static void *
+test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                              QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
+    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
@@ -3017,6 +3029,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QATZIP
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void test_multifd_tcp_qpl(void)
 {
@@ -3922,6 +3945,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QATZIP
+    migration_test_add("/migration/multifd/tcp/plain/qatzip",
+                test_multifd_tcp_qatzip);
+#endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
                        test_multifd_tcp_qpl);
-- 
2.45.0


