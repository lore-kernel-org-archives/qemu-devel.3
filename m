Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C369CC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1Q-0007WB-4q; Fri, 19 Apr 2024 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1D-0007Sz-Hi
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1B-0004CR-Nl
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZb3TsU5dn/OiwuiJ8Lgb86sXV43UMJ+Lx/puhmv714=;
 b=RtI/GNvFODtGxKMqTEGXfboGlhEwv/kpZSPS1kNE81sawl1943vnJOPFIppJVBkwsmroiG
 8bRcgJAT42OwlvsetJiMm/CVIbjFgEhvWoteSEqGO35HzfBwg4ag1sydeYKHaLKjgAuTks
 3yKLkj07IvhHld76SrPU8KVkq3lI2/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-J7BqDJWKNNuBO3mjP7zT3w-1; Fri, 19 Apr 2024 00:38:31 -0400
X-MC-Unique: J7BqDJWKNNuBO3mjP7zT3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BF3280021A;
 Fri, 19 Apr 2024 04:38:31 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC03407F3D5;
 Fri, 19 Apr 2024 04:38:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 13/27] docs/qapi-domain: add qapi:enum directive
Date: Fri, 19 Apr 2024 00:38:01 -0400
Message-ID: <20240419043820.178731-14-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

Add the .. qapi:enum:: directive, object, and :qapi:enum:`name`
cross-reference role.

Add the :value name: field list for documenting Enum values.

Of note, also introduce a new "type" role that is intended to be used by
other QAPI object directives to cross-reference arbitrary QAPI type
names, but will exclude commands, events, and modules from
consideration.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        | 14 ++++++++++++++
 docs/sphinx/qapi-domain.py | 24 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 39fe4dd2dae..cf794e6e739 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -113,3 +113,17 @@ Explicit cross-referencing syntax for QAPI modules is available with
    At the moment, the order of grouped sections is based on the order in
    which each group was encountered. This example will render Arguments
    first, and then Features; but the order can be any that you choose.
+
+.. qapi:enum:: BitmapSyncMode
+   :since: 4.2
+
+   An enumeration of possible behaviors for the synchronization of a
+   bitmap when used for data copy operations.
+
+   :value on-success: The bitmap is only synced when the operation is
+      successful. This is the behavior always used for
+      ``INCREMENTAL`` backups.
+   :value never: The bitmap is never synchronized with the operation, and
+      is treated solely as a read-only manifest of blocks to copy.
+   :value always: The bitmap is always synchronized with the operation,
+      regardless of whether or not the operation was successful.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 5d44dba6cd3..6759c39290d 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -289,6 +289,22 @@ class QAPICommand(QAPIObject):
     )
 
 
+class QAPIEnum(QAPIObject):
+    """Description of a QAPI Enum."""
+
+    doc_field_types = QAPIObject.doc_field_types.copy()
+    doc_field_types.extend(
+        [
+            GroupedField(
+                "value",
+                label=_("Values"),
+                names=("value",),
+                can_collapse=True,
+            )
+        ]
+    )
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -434,9 +450,14 @@ class QAPIDomain(Domain):
     # This table associates cross-reference object types (key) with an
     # ObjType instance, which defines the valid cross-reference roles
     # for each object type.
+    #
+    # e.g., the :qapi:type: cross-reference role can refer to enum,
+    # struct, union, or alternate objects; but :qapi:obj: can refer to
+    # anything. Each object also gets its own targeted cross-reference role.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "obj"),
         "command": ObjType(_("command"), "cmd", "obj"),
+        "enum": ObjType(_("enum"), "enum", "obj", "type"),
     }
 
     # Each of these provides a ReST directive,
@@ -444,6 +465,7 @@ class QAPIDomain(Domain):
     directives = {
         "module": QAPIModule,
         "command": QAPICommand,
+        "enum": QAPIEnum,
     }
 
     # These are all cross-reference roles; e.g.
@@ -452,6 +474,8 @@ class QAPIDomain(Domain):
     roles = {
         "mod": QAPIXRefRole(),
         "cmd": QAPIXRefRole(),
+        "enum": QAPIXRefRole(),
+        "type": QAPIXRefRole(),  # reference any data type (excludes modules, commands, events)
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.44.0


