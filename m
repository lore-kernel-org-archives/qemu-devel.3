Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D61C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5Q-0001ZJ-48; Thu, 01 Aug 2024 13:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5N-0001XR-C6
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5K-0005uB-V2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUkIIosbBETnEy5HXrShiEtjaYOvur2tbXwmwlKnd4Y=;
 b=T9I4gxT6k8s77bOAT44WtU+1z6RA7PswVKNpmS0Ig9rt228DZspRDxQlGEvslaABCZI7EX
 IKMl437Q/td9kPNi79t0ELFYf1znhEB32AnOcOgeVMTKqTakKQYD5SzF+Qkf+UDjPeBj+s
 adGqJBfLkqPQy7L17bciNBx/GDUfnsY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-zW22CGDKNCirwD5jdFcW7w-1; Thu,
 01 Aug 2024 13:59:25 -0400
X-MC-Unique: zW22CGDKNCirwD5jdFcW7w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5868D1955F06; Thu,  1 Aug 2024 17:59:24 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 497D019560AA; Thu,  1 Aug 2024 17:59:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/6] scripts/qapi: rename 'special_features' to 'features'
Date: Thu,  1 Aug 2024 18:59:09 +0100
Message-ID: <20240801175913.669013-3-berrange@redhat.com>
In-Reply-To: <20240801175913.669013-1-berrange@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 6a8abe0041..e6c80cce23 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -40,10 +40,10 @@
 from .source import QAPISourceInfo
 
 
-def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
-    special_features = [f"1u << QAPI_{feat.name.upper()}"
-                        for feat in features if feat.is_special()]
-    return ' | '.join(special_features) or '0'
+def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
+    features = [f"1u << QAPI_{feat.name.upper()}"
+                for feat in features if feat.is_special()]
+    return ' | '.join(features) or '0'
 
 
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
2.45.2


