Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5F4C369A1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwj-000622-GW; Fri, 04 Apr 2025 08:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwN-0005sz-CS
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwI-0005rV-UT
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvKFkQYuyviiDeQyZBdwL+sGeoIrEhB6ebL4ypSh9sI=;
 b=EoRmm6WT/ktXyLZaW4uk13latFwhdboPIqNE4vSae6kU3eSPBe2Ko39GZg8fk81fDJr9da
 AwtdY6uEniwX+FDhHln/hnL5x7MWdsylsaI871K2+4n9UJs3JJ8pdeXc8MR8qhqgxKioqY
 pwITnXgACImqDs+B1aofsQzPFDU/FU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-8A1wnMFSMSOjoH-XYKicZA-1; Fri,
 04 Apr 2025 08:14:22 -0400
X-MC-Unique: 8A1wnMFSMSOjoH-XYKicZA-1
X-Mimecast-MFC-AGG-ID: 8A1wnMFSMSOjoH-XYKicZA_1743768861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D19A719560BB; Fri,  4 Apr 2025 12:14:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 702C61809B63; Fri,  4 Apr 2025 12:14:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E33621E65EC; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 11/11] qga/qapi-schema: Add a proper introduction
Date: Fri,  4 Apr 2025 14:14:13 +0200
Message-ID: <20250404121413.1743790-12-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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

Contents adapted from qapi/qapi-schema.json.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 35ec0e7db3..5316bfacbf 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -2,10 +2,24 @@
 # vim: filetype=python
 
 ##
-# = QEMU guest agent protocol commands and structs
+# This manual describes the commands supported by the QEMU Guest
+# Agent Protocol.
 #
-# For a concise listing of all commands, events, and types in the QEMU
-# guest agent, please consult the `qapi-qga-index`.
+# For locating  a particular item, please see the `qapi-qga-index`.
+#
+# The following notation is used in examples:
+#
+# .. qmp-example::
+#
+#   -> ... text sent by client (commands) ...
+#   <- ... text sent by server (command responses and events) ...
+#
+# Example text is formatted for readability.  However, in real
+# protocol usage, its commonly emitted as a single line.
+#
+# Please refer to the
+# :doc:`QEMU Machine Protocol Specification </interop/qmp-spec>`
+# for the general format of commands, responses, and events.
 ##
 
 { 'pragma': { 'doc-required': true } }
-- 
2.48.1


