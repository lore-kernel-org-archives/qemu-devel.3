Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A19C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQ6-0003tg-85; Tue, 08 Sep 2026 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ4-0003sb-Lp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQ2-0007b7-7x
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WiZ7TZb3vfkr1iFesD5k1O2a5EjcMYTKUDmeoVZkZhE=;
 b=SuWvUHmTvLO6ZgpNFdgxnYnkvTjGLDDC53Im0K/v3fzhtapu827EnSID84afiGzLNf+Su0
 zFk1TP+nGtqjGoeqKffo6tbt/PI/WJRTk2oO8oXcVVEWJP/Ox/X5jUMywzK2+53O284sX7
 EpAiTvG8pqaA1R1xgv5/jMexIHeDdEs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-rWXl7N5CMvGqk0b-ttqtiA-1; Tue,
 08 Sep 2026 11:07:24 -0400
X-MC-Unique: rWXl7N5CMvGqk0b-ttqtiA-1
X-Mimecast-MFC-AGG-ID: rWXl7N5CMvGqk0b-ttqtiA_1788880043
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B0FD195608F; Tue,  8 Sep 2026 15:07:23 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 794137D5; Tue,  8 Sep 2026 15:07:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:50 +0400
Subject: [GIT PULL 07/15] iothread: fix poll properties typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-7-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=y5FNojlkLsAF0V5m9dch4w29DrjqN7eZD7tFamq7MSM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPD9GclDeBg8ECqPLymg68b/I/VeXxY/t6T
 sF7V03nRzOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5RznEACKYUS4gcIut6DbiQYOkO+9rMuRIg416QV//iEMK64xEGCzqK01m3j1SC/Jkaqm5lWNRJf
 iWIuxtZJw2nLkxmuNF2K83DXxirSfirMxXWL/vHkUN1aHu0Ixcmsf7jfwhRLTwUpcB+ShefHUCV
 Y6+maGe2Z7+VgJQPGKvmJtixNwtAh57jm0wTQjbnMPn8HnRtMGq9KKIhkzKXvwGhK2ZNPJ0dyKi
 8xyd8bi5wGsyEHSoq8x6/TagSSnc1vi15p6yGcbnjJ057MIx/h0PeABvX3WE4IrO3sUbmpqdewh
 gGqOSDm9AbUMxHWXlcvznUC6go6Ni0Clir7D836OYi2mxJMNL5wghsveklQchE9aF2y8MRkeFha
 TCMWojBblNGJQWC2j9FqSiB7LRw4vEI2yAE+s/DP6FgHkhFPvrS/F64M4mD9OXbvDWGjh33j4Wz
 h1KvjkakpXFw9YXLYHgwzKRsVx9IjgFKVWGv/ceschCU+dN0Uc7v9AfFK1ahw2tMjNxVORhxjUu
 +c4W9Z/te0xFkwuRur1pa9HTBRQUnCtEkbjRqFFyEHNW8l9xNh6tXohnEwY3sMnIxjWwg3+lnTC
 MuiSJJnHO8pl03F8YVW3lAzKnRxoP5/n3Gz8ilPDbrRjUUtAdHPxpGe1YjqRyo66bfRg1QNsx8h
 BsZS680hirtOYzw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The getter and setter use visit_type_int64, not visit_type_int.

Fixes: 0d9d86fb4df4 ("iothread: add polling parameters")
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 iothread.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/iothread.c b/iothread.c
index 3558535b40f5..76eea6df3861 100644
--- a/iothread.c
+++ b/iothread.c
@@ -315,19 +315,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
 
-    object_class_property_add(klass, "poll-max-ns", "int",
+    object_class_property_add(klass, "poll-max-ns", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_max_ns_info);
-    object_class_property_add(klass, "poll-grow", "int",
+    object_class_property_add(klass, "poll-grow", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_grow_info);
-    object_class_property_add(klass, "poll-shrink", "int",
+    object_class_property_add(klass, "poll-shrink", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
-    object_class_property_add(klass, "poll-weight", "int",
+    object_class_property_add(klass, "poll-weight", "int64",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_weight_info);

-- 
2.55.0.543.g5ebe2ebe4ea8


