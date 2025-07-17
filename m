Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37327C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJsS-0005c3-7V; Thu, 17 Jul 2025 04:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrv-0005Co-0C
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucJrq-0000wl-Qu
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752740485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3wiLVeJG6eRNKooWYvuQr49qjdJy/RkIv0LfEcMu2s=;
 b=PuDkGR8Lq+tvP8b8YB0N4Q2BjLZbmHfbhUpnZzR9JDodnUtxQ4bQ7epUcPgwBVTZNksmdc
 klBTlTsx4yL+16aStphm4FgAjwRL9als5Yt1iIbjjA4Oxeg0jwmucjLyoMVxbE3RLz9SUT
 RuC42UlIuO+a2sbYaPil4M35I8QSMbw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-HuBOc1kMMSmAEPzixxjn_A-1; Thu,
 17 Jul 2025 04:21:21 -0400
X-MC-Unique: HuBOc1kMMSmAEPzixxjn_A-1
X-Mimecast-MFC-AGG-ID: HuBOc1kMMSmAEPzixxjn_A_1752740481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE77F19560B4; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EF3A195608D; Thu, 17 Jul 2025 08:21:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B83D321E6935; Thu, 17 Jul 2025 10:21:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 jsnow@redhat.com
Subject: [PATCH 3/4] qga: Rephrase return docs to avoid type name
Date: Thu, 17 Jul 2025 10:21:16 +0200
Message-ID: <20250717082117.3767754-4-armbru@redhat.com>
In-Reply-To: <20250717082117.3767754-1-armbru@redhat.com>
References: <20250717082117.3767754-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Returns: <description>" is rendered like

    Return: <Type> – <description>

Mentioning the type in the description again is commonly redundant.
There is just one such description.  Rephrase it not to mention the
type.

We did this for qapi/ in commit f7296f8de5c (qapi: rephrase return
docs to avoid type name).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a9cc9150dc..6c26ace3c9 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -534,8 +534,7 @@
 #     discarded.  The default value is zero, meaning "discard every
 #     free block".
 #
-# Returns: A @GuestFilesystemTrimResponse which contains the status of
-#     all trimmed paths.  (since 2.4)
+# Returns: status of all trimmed paths.  (since 2.4)
 #
 # Since: 1.2
 ##
-- 
2.49.0


