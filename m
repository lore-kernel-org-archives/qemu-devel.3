Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E318BC02196
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfeeM-0006AJ-Re; Wed, 05 Feb 2025 07:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfedZ-0005aP-VJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tfedY-0001mt-2I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738758969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DSYY2gFgYtw9XYdCp9MgWVF5uogh+pkSDxK7b/beffg=;
 b=PUlvtA1s65c6NReO4oYDidT6op+rw6VwGlv9qLgA7yqjGuGM+dSWatZ+2ipNTGdHk3skHW
 LPCIbVu0jHMOmHit7n0i7KjNUyB3l0ymhXKbbuj9qqWnLmkskiqPTWlrEvU8f5clwSpj/I
 HWPu7lT3CuEBzD6xQgM7UVFYL6t1WcQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-rZpC34UEP5-ApYXsQOJGiA-1; Wed,
 05 Feb 2025 07:36:05 -0500
X-MC-Unique: rZpC34UEP5-ApYXsQOJGiA-1
X-Mimecast-MFC-AGG-ID: rZpC34UEP5-ApYXsQOJGiA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBCB01800264; Wed,  5 Feb 2025 12:36:03 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5141A1956051; Wed,  5 Feb 2025 12:36:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 3/4] qapi: rename 'special_features' to 'features'
Date: Wed,  5 Feb 2025 12:35:49 +0000
Message-ID: <20250205123550.2754387-4-berrange@redhat.com>
In-Reply-To: <20250205123550.2754387-1-berrange@redhat.com>
References: <20250205123550.2754387-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This updates the QAPI code generation to refer to 'features' instead
of 'special_features', in preparation for generalizing their exposure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/commands.py |  4 ++--
 scripts/qapi/gen.py      |  8 ++++----
 scripts/qapi/types.py    | 10 +++++-----
 scripts/qapi/visit.py    | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79951a841f..d629d2d97e 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -25,7 +25,7 @@
     QAPIGenC,
     QAPISchemaModularCVisitor,
     build_params,
-    gen_special_features,
+    gen_features,
     ifcontext,
 )
 from .schema import (
@@ -298,7 +298,7 @@ def gen_register_command(name: str,
 ''',
                 name=name, c_name=c_name(name),
                 opts=' | '.join(options) or 0,
-                feats=gen_special_features(features))
+                feats=gen_features(features))
     return ret
 
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index c53ca72950..b51f8d955e 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -41,10 +41,10 @@
 from .source import QAPISourceInfo
 
 
-def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
-    special_features = [f"1u << {c_enum_const('qapi', feat.name)}"
-                        for feat in features if feat.is_special()]
-    return ' | '.join(special_features) or '0'
+def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
+    featenum = [f"1u << {c_enum_const('qapi', feat.name)}"
+                for feat in features if feat.is_special()]
+    return ' | '.join(featenum) or '0'
 
 
 class QAPIGen:
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 7bc3f8241f..ade6b7a3d7 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -18,7 +18,7 @@
 from .common import c_enum_const, c_name, mcgen
 from .gen import (
     QAPISchemaModularCVisitor,
-    gen_special_features,
+    gen_features,
     ifcontext,
 )
 from .schema import (
@@ -61,12 +61,12 @@ def gen_enum_lookup(name: str,
                      index=index, name=memb.name)
         ret += memb.ifcond.gen_endif()
 
-        special_features = gen_special_features(memb.features)
-        if special_features != '0':
+        features = gen_features(memb.features)
+        if features != '0':
             feats += mcgen('''
-        [%(index)s] = %(special_features)s,
+        [%(index)s] = %(features)s,
 ''',
-                           index=index, special_features=special_features)
+                           index=index, features=features)
 
     if feats:
         ret += mcgen('''
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 12f92e429f..8dbf4ef1c3 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -23,7 +23,7 @@
 )
 from .gen import (
     QAPISchemaModularCVisitor,
-    gen_special_features,
+    gen_features,
     ifcontext,
 )
 from .schema import (
@@ -103,15 +103,15 @@ def gen_visit_object_members(name: str,
 ''',
                          name=memb.name, has=has)
             indent.increase()
-        special_features = gen_special_features(memb.features)
-        if special_features != '0':
+        features = gen_features(memb.features)
+        if features != '0':
             ret += mcgen('''
-    if (visit_policy_reject(v, "%(name)s", %(special_features)s, errp)) {
+    if (visit_policy_reject(v, "%(name)s", %(features)s, errp)) {
         return false;
     }
-    if (!visit_policy_skip(v, "%(name)s", %(special_features)s)) {
+    if (!visit_policy_skip(v, "%(name)s", %(features)s)) {
 ''',
-                         name=memb.name, special_features=special_features)
+                         name=memb.name, features=features)
             indent.increase()
         ret += mcgen('''
     if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
@@ -120,7 +120,7 @@ def gen_visit_object_members(name: str,
 ''',
                      c_type=memb.type.c_name(), name=memb.name,
                      c_name=c_name(memb.name))
-        if special_features != '0':
+        if features != '0':
             indent.decrease()
             ret += mcgen('''
     }
-- 
2.47.1


