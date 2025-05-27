Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F058DC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJouJ-00040h-N3; Tue, 27 May 2025 03:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouH-0003zz-Iz
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJouF-0007r2-1W
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wt6x2bwY00ExKSUtMS2hukJIhefVolz83jTU+gug5Q8=;
 b=Y7s+lV/9vQW+AjFWlO4VJdmW0AnH1fleD4KsCLXmrxjjk6p/LaGnTZhvLanCCQVC0KHjRK
 6zykg664R77HvmCOLUyv65pY5C3J8tCmyEGcnY7yssluK7hG5KnD1wVbLfFINGVwr9rv7o
 kZvmdT6c895zJcw28BtEKO6AdW3N8mM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-0N5-wy37PXqUY-R5vpzcXQ-1; Tue,
 27 May 2025 03:39:24 -0400
X-MC-Unique: 0N5-wy37PXqUY-R5vpzcXQ-1
X-Mimecast-MFC-AGG-ID: 0N5-wy37PXqUY-R5vpzcXQ_1748331563
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27E161800877; Tue, 27 May 2025 07:39:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABFCE30001A1; Tue, 27 May 2025 07:39:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4455121E65EA; Tue, 27 May 2025 09:39:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, qemu-block@nongnu.org
Subject: [PATCH 09/13] qapi: Spell JSON null correctly in blockdev-reopen
 documentation
Date: Tue, 27 May 2025 09:39:12 +0200
Message-ID: <20250527073916.1243024-10-armbru@redhat.com>
In-Reply-To: <20250527073916.1243024-1-armbru@redhat.com>
References: <20250527073916.1243024-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The doc comment misspells JSON null as NULL.  Fix that.

Cc: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7b0548dc2e..f8f89ee2d7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4947,7 +4947,7 @@
 #  3) A reference to a different node: the current child is replaced
 #     with the specified one.
 #
-#  4) NULL: the current child (if any) is detached.
+#  4) null: the current child (if any) is detached.
 #
 # Options (1) and (2) are supported in all cases.  Option (3) is
 # supported for @file and @backing, and option (4) for @backing only.
-- 
2.48.1


