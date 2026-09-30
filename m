Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE8CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrih-0001Im-T3; Wed, 30 Sep 2026 06:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0001GH-7Y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBric-0006iG-7G
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBcJejhsMJPBW6EmQCrkml6BxhR5NoGmj86C1nAjNbk=;
 b=C/78gzUCcDkmcuHjgQPE5tIqiGcL4WYgzUhmO+w7HTUBPE04ONBaTSUY7wBcDDuRGNChJT
 Iza+Z7xlfmU+nUO858PFBadE6BaB49C+CcekKNxX+i+3TMFMDc0H5ZWpCS3Hl0b16tEmip
 Qyt0+k2fTNRdOSki4TyBFAL2O0N0HgU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-qfm9pdjpMyuiAVTTptfWxA-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: qfm9pdjpMyuiAVTTptfWxA-1
X-Mimecast-MFC-AGG-ID: qfm9pdjpMyuiAVTTptfWxA_1790764759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20FE6180131E; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D305218004D2; Wed, 30 Sep 2026 10:39:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 019ED21E689E; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 026/105] qapi: convert trivial intro sections for
 introspect.json
Date: Wed, 30 Sep 2026 12:37:51 +0200
Message-ID: <20260930103910.3934848-27-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-27-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/introspect.json | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8..172ed38999 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -112,8 +112,7 @@
 
 ##
 # @SchemaInfoBuiltin:
-#
-# Additional `SchemaInfo` members for meta-type 'builtin'.
+#     Additional `SchemaInfo` members for meta-type 'builtin'.
 #
 # @json-type: the JSON type used for this type on the wire.
 #
@@ -124,10 +123,9 @@
 
 ##
 # @JSONType:
-#
-# The four primitive and two structured types according to RFC 8259
-# section 1, plus 'int' (split off 'number'), plus the obvious top
-# type 'value'.
+#     The four primitive and two structured types according to RFC
+#     8259 section 1, plus 'int' (split off 'number'), plus the
+#     obvious top type 'value'.
 #
 # @string: JSON string
 #
@@ -153,8 +151,7 @@
 
 ##
 # @SchemaInfoEnum:
-#
-# Additional `SchemaInfo` members for meta-type 'enum'.
+#     Additional `SchemaInfo` members for meta-type 'enum'.
 #
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
@@ -178,8 +175,7 @@
 
 ##
 # @SchemaInfoEnumMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -193,8 +189,7 @@
 
 ##
 # @SchemaInfoArray:
-#
-# Additional `SchemaInfo` members for meta-type 'array'.
+#     Additional `SchemaInfo` members for meta-type 'array'.
 #
 # @element-type: the array type's element type.
 #
@@ -207,8 +202,7 @@
 
 ##
 # @SchemaInfoObject:
-#
-# Additional `SchemaInfo` members for meta-type 'object'.
+#     Additional `SchemaInfo` members for meta-type 'object'.
 #
 # @members: the object type's (non-variant) members, in no particular
 #     order.
@@ -232,8 +226,7 @@
 
 ##
 # @SchemaInfoObjectMember:
-#
-# An object member.
+#     An object member.
 #
 # @name: the member's name, as defined in the QAPI schema.
 #
@@ -257,8 +250,7 @@
 
 ##
 # @SchemaInfoObjectVariant:
-#
-# The variant members for a value of the type tag.
+#     The variant members for a value of the type tag.
 #
 # @case: a value of the type tag.
 #
@@ -272,8 +264,7 @@
 
 ##
 # @SchemaInfoAlternate:
-#
-# Additional `SchemaInfo` members for meta-type 'alternate'.
+#     Additional `SchemaInfo` members for meta-type 'alternate'.
 #
 # @members: the alternate type's members, in no particular order.  The
 #     members' wire encoding is distinct, see
@@ -288,8 +279,7 @@
 
 ##
 # @SchemaInfoAlternateMember:
-#
-# An alternate member.
+#     An alternate member.
 #
 # @type: the name of the member's type.
 #
@@ -300,8 +290,7 @@
 
 ##
 # @SchemaInfoCommand:
-#
-# Additional `SchemaInfo` members for meta-type 'command'.
+#     Additional `SchemaInfo` members for meta-type 'command'.
 #
 # @arg-type: the name of the object type that provides the command's
 #     parameters.
@@ -322,8 +311,7 @@
 
 ##
 # @SchemaInfoEvent:
-#
-# Additional `SchemaInfo` members for meta-type 'event'.
+#     Additional `SchemaInfo` members for meta-type 'event'.
 #
 # @arg-type: the name of the object type that provides the event's
 #     parameters.
-- 
2.55.0


