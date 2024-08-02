Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A01C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 01:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZhPY-0000p2-8k; Thu, 01 Aug 2024 21:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPW-0000jR-8c
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sZhPU-0001xu-P7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 21:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722563328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+ocFGmg17RpHpMuCKxkl0vQ5+ZuyZySzGSS1ZlXAEk=;
 b=YdgkARPPIBvZqxW9C2k5Vclg4muDY2B0BmxZYbuV5czzs0WLVTnS6k0QXzi3bXofnTGwuS
 OBwdwGuC7SCxBiW8fBLHwW6weHkVfynVj6BGduDRuOrPMfpj7MRpvbEX3wZMTFl55YGFSr
 tDsSe5QqWne336D3RorQdquf12vXC/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-WMtS9pGePhGtwsjZdxflOA-1; Thu,
 01 Aug 2024 21:48:45 -0400
X-MC-Unique: WMtS9pGePhGtwsjZdxflOA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 610F91956064; Fri,  2 Aug 2024 01:48:42 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.72])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA397195605A; Fri,  2 Aug 2024 01:48:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PATCH v2 3/3] nbd: Minor style fixes
Date: Thu,  1 Aug 2024 20:32:08 -0500
Message-ID: <20240802014824.1906798-8-eblake@redhat.com>
In-Reply-To: <20240802014824.1906798-5-eblake@redhat.com>
References: <20240802014824.1906798-5-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Touch up a comment with the wrong type name, and an over-long line,
both noticed while working on the previous patches.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 2 +-
 qemu-nbd.c   | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 7c37d9753f0..3debc416dd0 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1973,7 +1973,7 @@ static void nbd_export_request_shutdown(BlockExport *blk_exp)

     blk_exp_ref(&exp->common);
     /*
-     * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a
+     * TODO: Should we expand QMP BlockExportRemoveMode enum to allow a
      * close mode that stops advertising the export to new clients but
      * still permits existing clients to run to completion? Because of
      * that possibility, nbd_export_close() can be called more than
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 3ad50eec18e..c0bd16217cd 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -589,7 +589,8 @@ int main(int argc, char **argv)
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
2.45.2


