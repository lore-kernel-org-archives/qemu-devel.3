Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759E5C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJfp-0000JX-Ur; Mon, 29 Jun 2026 17:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfl-00007q-7c
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfj-0004G0-TF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzH2vgYPGUBsrs5ZG94GuwI9S4cjR/KWflAG6TZKmQs=;
 b=BbPzWFx9MkLKey6EpRHLhWJGdGA36M6TFLPxeQNPFjug+jSyo0WUtDCt8uapZxVad5NO4D
 HnixqzNYOdRJMQncL79HPuBC51iZYcNsWKSYHl9DCyyNMEqFwRmNw70Zso7//FSwOMK9sP
 5+xQE+gCIgNGmQAkstf2TmIrUkXHum8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-fP9UPKqXM4ChvpyBI9jOxA-1; Mon,
 29 Jun 2026 17:37:39 -0400
X-MC-Unique: fP9UPKqXM4ChvpyBI9jOxA-1
X-Mimecast-MFC-AGG-ID: fP9UPKqXM4ChvpyBI9jOxA_1782769057
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9523B1978CAA; Mon, 29 Jun 2026 21:37:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC9631956096; Mon, 29 Jun 2026 21:37:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 12/14] qapi: convert intro sections for authz.json
Date: Mon, 29 Jun 2026 17:36:22 -0400
Message-ID: <20260629213624.936258-13-jsnow@redhat.com>
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/authz.json | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/qapi/authz.json b/qapi/authz.json
index bc1123cc053..b76c39c53af 100644
--- a/qapi/authz.json
+++ b/qapi/authz.json
@@ -9,8 +9,7 @@
 
 ##
 # @QAuthZListPolicy:
-#
-# The authorization policy result
+#     The authorization policy result
 #
 # @deny: deny access
 #
@@ -24,8 +23,7 @@
 
 ##
 # @QAuthZListFormat:
-#
-# The authorization policy match format
+#     The authorization policy match format
 #
 # @exact: an exact string match
 #
@@ -39,8 +37,7 @@
 
 ##
 # @QAuthZListRule:
-#
-# A single authorization rule.
+#     A single authorization rule.
 #
 # @match: a string or glob to match against a user identity
 #
@@ -57,8 +54,7 @@
 
 ##
 # @AuthZListProperties:
-#
-# Properties for authz-list objects.
+#     Properties for authz-list objects.
 #
 # @policy: Default policy to apply when no rule matches (default:
 #     deny)
@@ -73,8 +69,7 @@
 
 ##
 # @AuthZListFileProperties:
-#
-# Properties for authz-listfile objects.
+#     Properties for authz-listfile objects.
 #
 # @filename: File name to load the configuration from.  The file must
 #     contain valid JSON for `AuthZListProperties`.
@@ -93,8 +88,7 @@
 
 ##
 # @AuthZPAMProperties:
-#
-# Properties for authz-pam objects.
+#     Properties for authz-pam objects.
 #
 # @service: PAM service name to use for authorization
 #
@@ -105,8 +99,7 @@
 
 ##
 # @AuthZSimpleProperties:
-#
-# Properties for authz-simple objects.
+#     Properties for authz-simple objects.
 #
 # @identity: Identifies the allowed user.  Its format depends on the
 #     network service that authorization object is associated with.
-- 
2.54.0


