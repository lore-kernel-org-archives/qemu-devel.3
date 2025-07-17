Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B8C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 11:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucNCK-0004Tj-FI; Thu, 17 Jul 2025 07:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucNAY-0003dH-Vl
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ucNAT-0001ha-Ie
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752753171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UslO/P3Yfc/J/zmYOqnhbUNc0+w8yMxfuAXf3YXvLVE=;
 b=XQQ1k1nR4qKBlA6oRB9NIG7yzHAy8aXeBCXBoFGda2Y67UomW1AM2Ad/cS8NSmF7SNecgR
 JH7bDLiwRPsLNrEDHG/1RAwHwq5lVelxgBmGz1AzKR5qpmpGKwuEyMOsgErIn7y7cMMNi3
 VpKWfeoxaLE0qiBOR0bQr0yVayLdOBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-ebTSA-iZOT6w86BUwDVwew-1; Thu,
 17 Jul 2025 07:52:50 -0400
X-MC-Unique: ebTSA-iZOT6w86BUwDVwew-1
X-Mimecast-MFC-AGG-ID: ebTSA-iZOT6w86BUwDVwew_1752753169
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B44119560B5; Thu, 17 Jul 2025 11:52:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED543195608D; Thu, 17 Jul 2025 11:52:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3BC3721E6935; Thu, 17 Jul 2025 13:52:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 jsnow@redhat.com, berrange@redhat.com
Subject: [PATCH v2 3/4] qga: Rephrase return docs to avoid type name
Date: Thu, 17 Jul 2025 13:52:45 +0200
Message-ID: <20250717115246.3830007-4-armbru@redhat.com>
In-Reply-To: <20250717115246.3830007-1-armbru@redhat.com>
References: <20250717115246.3830007-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


