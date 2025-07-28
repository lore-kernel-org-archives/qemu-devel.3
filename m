Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0566EC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugN5C-0002qG-CR; Mon, 28 Jul 2025 08:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugMO8-0003st-KC
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugMO3-00043s-W3
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753703482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+2WkFWYL4czTT2YnwH0anl6ohMQd998DSdkXU2xHpo=;
 b=iiK30T6MeQBi/1j+59nPPcF5Exila/6WcAH6jVQIipxXHTEbL0vY2p8PgDszoaWn6UYwm7
 QuRakPqFxG1d4Sj920HLMSyNWUcZP1cP5yvzXQmPRsIpXzyUXHqz5Uu4p1l8i5qNpqLScl
 j1ZhTjU5D0VVkcWNRWdseRg+/Jr6WgI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-CiLh9-ttNPu62ZAfFr7JfA-1; Mon,
 28 Jul 2025 07:51:20 -0400
X-MC-Unique: CiLh9-ttNPu62ZAfFr7JfA-1
X-Mimecast-MFC-AGG-ID: CiLh9-ttNPu62ZAfFr7JfA_1753703479
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1CC71956069
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:51:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59D9230001BE
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:51:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99B3F21E6935; Mon, 28 Jul 2025 13:51:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PULL 3/4] qga: Rephrase return docs to avoid type name
Date: Mon, 28 Jul 2025 13:51:15 +0200
Message-ID: <20250728115116.2938867-4-armbru@redhat.com>
In-Reply-To: <20250728115116.2938867-1-armbru@redhat.com>
References: <20250728115116.2938867-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250717115246.3830007-4-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
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


