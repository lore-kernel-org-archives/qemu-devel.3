Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F443C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 21:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scB6y-0004BA-HV; Thu, 08 Aug 2024 17:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6s-0003xF-W6
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1scB6r-0004bK-IR
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 17:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723154149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2ZgsHnuLZ3fUW5pA+0JehB0U5OYkV06erXk0AGwWwQ=;
 b=QSBvxpvlGzge1ZZVdc1eYkGGCASBULjHeZMJbkypAWysOh0R+3+hMRH6wueVzYxu7DELCj
 LqF/oajrE3rJ44KQS08f0Rjo8xLYxNUgCEZ1KtYrbt8wZMF4qjbQPKtZwx1yRSP0m3UTcO
 sd/JvX/I1uok1mDQMQfySwhuY0Ne4aU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-XLAkhspgPzCK2vKokMHiJg-1; Thu,
 08 Aug 2024 17:55:44 -0400
X-MC-Unique: XLAkhspgPzCK2vKokMHiJg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16491944A8E; Thu,  8 Aug 2024 21:55:41 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5215519560A3; Thu,  8 Aug 2024 21:55:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 1/5] nbd: Minor style and typo fixes
Date: Thu,  8 Aug 2024 16:53:39 -0500
Message-ID: <20240808215529.1065336-8-eblake@redhat.com>
In-Reply-To: <20240808215529.1065336-7-eblake@redhat.com>
References: <20240808215529.1065336-7-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Touch up a comment with the wrong type name, and an over-long line,
both noticed while working on upcoming patches.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240807174943.771624-10-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 nbd/server.c | 2 +-
 qemu-nbd.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 892797bb111..ecd9366ba64 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1972,7 +1972,7 @@ static void nbd_export_request_shutdown(BlockExport *blk_exp)

     blk_exp_ref(&exp->common);
     /*
-     * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a
+     * TODO: Should we expand QMP BlockExportRemoveMode enum to allow a
      * close mode that stops advertising the export to new clients but
      * still permits existing clients to run to completion? Because of
      * that possibility, nbd_export_close() can be called more than
diff --git a/qemu-nbd.c b/qemu-nbd.c
index d7b3ccab21c..8e104ef22c3 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -588,7 +588,8 @@ int main(int argc, char **argv)
     pthread_t client_thread;
     const char *fmt = NULL;
     Error *local_err = NULL;
-    BlockdevDetectZeroesOptions detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
+    BlockdevDetectZeroesOptions detect_zeroes =
+        BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
     QDict *options = NULL;
     const char *export_name = NULL; /* defaults to "" later for server mode */
     const char *export_description = NULL;
-- 
2.46.0


