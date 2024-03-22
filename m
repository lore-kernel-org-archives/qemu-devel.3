Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76CC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnfaF-0002wa-W9; Fri, 22 Mar 2024 10:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaE-0002vc-Be
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnfaC-0003Y4-Uz
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711116560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjn8QpKX4fe/hTlb9r3XI72HaUYlTbI+EynHoKLCJ8o=;
 b=iUWCjcuI+rBKJLL7cqDJ4NnC3APMe6DMPO4RJK77yrkL56kGPVfWI2Ie8yRUPSOBE2YIwF
 DzGdl7ARTV3RWr6ScPskUcQ4tgQGo/RV3YPJv+xboJUfw+q39HqnZM8+0BRHZAJ8wJaMVa
 JbYUN4VBRxrO9inAtMbB5cjCLET2EXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-asGjacgHMWGPjklsvJkujA-1; Fri, 22 Mar 2024 10:09:16 -0400
X-MC-Unique: asGjacgHMWGPjklsvJkujA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF8A9101A586;
 Fri, 22 Mar 2024 14:09:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C03FB1C060A4;
 Fri, 22 Mar 2024 14:09:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C9DA521E5D2A; Fri, 22 Mar 2024 15:09:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	michael.roth@amd.com,
	kkostiuk@redhat.com
Subject: [PATCH 04/12] qapi: Tidy up indentation of add_client's example
Date: Fri, 22 Mar 2024 15:09:02 +0100
Message-ID: <20240322140910.328840-5-armbru@redhat.com>
In-Reply-To: <20240322140910.328840-1-armbru@redhat.com>
References: <20240322140910.328840-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

Commit d23055b8db8 (qapi: Require descriptions and tagged sections to
be indented) indented add_client's example too much.  Revert that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 1b0c5dad88..ec30e5c570 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -32,9 +32,9 @@
 #
 # Example:
 #
-#         -> { "execute": "add_client", "arguments": { "protocol": "vnc",
-#                                                      "fdname": "myclient" } }
-#         <- { "return": {} }
+#     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
+#                                                  "fdname": "myclient" } }
+#     <- { "return": {} }
 ##
 { 'command': 'add_client',
   'data': { 'protocol': 'str', 'fdname': 'str', '*skipauth': 'bool',
@@ -142,7 +142,7 @@
 #     option was passed on the command line.
 #
 #     In the "suspended" state, it will completely stop the VM and
-#     cause a transition to the "paused" state. (Since 9.0)
+#     cause a transition to the "paused" state.  (Since 9.0)
 #
 # Example:
 #
-- 
2.44.0


