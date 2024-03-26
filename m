Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287D1CD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 07:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1Kh-0004n6-IQ; Tue, 26 Mar 2024 03:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1Kf-0004m4-BV
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1Kd-0005Tx-Ti
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xPN77xngO+avF+8tpML28b92qYmIhiqN96MtFZV+vY=;
 b=CLOv6NuVtGrFBjgkNOtrPKpIysTlFa7uViR0ToktUq5JRUno7+BipeE8x9V2slLV032lrg
 Im3IX36P12Pu3/Ov9QOv4tCXqLe8kW5/NVbBk+On2y4RKoS8VZw56kjc14fP8nB1gvQOol
 QE6dPBaL9soDmIQGGxtmzdY7fUVK5Ek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-ruxvVRfIPKGJ6VEPdFeJ7A-1; Tue, 26 Mar 2024 03:34:47 -0400
X-MC-Unique: ruxvVRfIPKGJ6VEPdFeJ7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B96B71865428;
 Tue, 26 Mar 2024 07:34:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 990EA40C6CB4;
 Tue, 26 Mar 2024 07:34:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B8C621E5D2D; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 07/20] qapi: Tidy up indentation of add_client's example
Date: Tue, 26 Mar 2024 08:34:07 +0100
Message-ID: <20240326073420.738016-8-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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
Message-ID: <20240322140910.328840-5-armbru@redhat.com>
[Move a stray hunk to the later patch it belongs to]
---
 qapi/misc.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 1b0c5dad88..83def5edc4 100644
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
-- 
2.44.0


