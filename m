Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332EEC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 22:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfm5-0006EJ-Up; Thu, 01 Feb 2024 17:43:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVfm0-0006Cz-PD
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflt-0006bV-0F
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsECITj15TACBp2Fp9ZkIZ9wo/qVpoauC9bxdheuxzQ=;
 b=AmqaOEqPu5HGnNeJJYIxxFfr3k+5ltwlDC/U6G02M8mp8MOTSXDuVS8Tr2LXTqog829yz9
 uLtz9xGvcQdnhraB3rKlAPrVqkw5TJjN0o4xxzVhMuHm/Ts8aAqDaAJ3VrauhIgjzlv9Lg
 blDCiq9pfoX54+jgTVYvPzBsZfzrI/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-WMz44NUjNmmruqRVOPa9eA-1; Thu, 01 Feb 2024 17:42:55 -0500
X-MC-Unique: WMz44NUjNmmruqRVOPa9eA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B79588D581;
 Thu,  1 Feb 2024 22:42:55 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2C702166B33;
 Thu,  1 Feb 2024 22:42:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 20/20] qapi/schema: remove unnecessary asserts
Date: Thu,  1 Feb 2024 17:42:46 -0500
Message-ID: <20240201224246.39480-21-jsnow@redhat.com>
In-Reply-To: <20240201224246.39480-1-jsnow@redhat.com>
References: <20240201224246.39480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

With strict typing enabled, these runtime statements aren't necessary
anymore; we can prove them statically.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 319c8475d21..fb0c5d6e2c6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -126,10 +126,8 @@ def __init__(
         ifcond: Optional[QAPISchemaIfCond] = None,
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
-        assert isinstance(name, str)
         super().__init__(info)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.name = name
         self.doc = doc
@@ -171,7 +169,6 @@ def is_implicit(self) -> bool:
         return not self.info
 
     def describe(self) -> str:
-        assert self.meta
         return "%s '%s'" % (self.meta, self.name)
 
 
@@ -385,7 +382,6 @@ def check(self, schema: QAPISchema) -> None:
                     f"feature '{feat.name}' is not supported for types")
 
     def describe(self) -> str:
-        assert self.meta
         return "%s type '%s'" % (self.meta, self.name)
 
 
@@ -394,7 +390,6 @@ class QAPISchemaBuiltinType(QAPISchemaType):
 
     def __init__(self, name: str, json_type: str, c_type: str):
         super().__init__(name, None, None)
-        assert not c_type or isinstance(c_type, str)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
                              'value')
         self._json_type_name = json_type
@@ -437,9 +432,7 @@ def __init__(
     ):
         super().__init__(name, info, doc, ifcond, features)
         for m in members:
-            assert isinstance(m, QAPISchemaEnumMember)
             m.set_defined_in(name)
-        assert prefix is None or isinstance(prefix, str)
         self.members = members
         self.prefix = prefix
 
@@ -482,7 +475,6 @@ def __init__(
         self, name: str, info: Optional[QAPISourceInfo], element_type: str
     ):
         super().__init__(name, info, None)
-        assert isinstance(element_type, str)
         self._element_type_name = element_type
         self.element_type: QAPISchemaType
 
@@ -527,7 +519,6 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
                                  self.element_type)
 
     def describe(self) -> str:
-        assert self.meta
         return "%s type ['%s']" % (self.meta, self._element_type_name)
 
 
@@ -547,12 +538,9 @@ def __init__(
         # union has base, variants, and no local_members
         super().__init__(name, info, doc, ifcond, features)
         self.meta = 'union' if variants else 'struct'
-        assert base is None or isinstance(base, str)
         for m in local_members:
-            assert isinstance(m, QAPISchemaObjectTypeMember)
             m.set_defined_in(name)
         if variants is not None:
-            assert isinstance(variants, QAPISchemaVariants)
             variants.set_defined_in(name)
         self._base_name = base
         self.base = None
@@ -674,7 +662,6 @@ def __init__(
         variants: QAPISchemaVariants,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert isinstance(variants, QAPISchemaVariants)
         assert variants.tag_member
         variants.set_defined_in(name)
         variants.tag_member.set_defined_in(self.name)
@@ -750,8 +737,6 @@ def __init__(
         assert bool(tag_member) != bool(tag_name)
         assert (isinstance(tag_name, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
-        for v in variants:
-            assert isinstance(v, QAPISchemaVariant)
         self._tag_name = tag_name
         self.info = info
         self._tag_member = tag_member
@@ -865,7 +850,6 @@ def __init__(
         info: Optional[QAPISourceInfo],
         ifcond: Optional[QAPISchemaIfCond] = None,
     ):
-        assert isinstance(name, str)
         self.name = name
         self.info = info
         self.ifcond = ifcond or QAPISchemaIfCond()
@@ -933,7 +917,6 @@ def __init__(
     ):
         super().__init__(name, info, ifcond)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.features = features or []
 
@@ -962,10 +945,7 @@ def __init__(
         features: Optional[List[QAPISchemaFeature]] = None,
     ):
         super().__init__(name, info, ifcond)
-        assert isinstance(typ, str)
-        assert isinstance(optional, bool)
         for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self._type_name = typ
         self.type: QAPISchemaType  # set during check()
@@ -973,7 +953,6 @@ def __init__(
         self.features = features or []
 
     def need_has(self) -> bool:
-        assert self.type
         return self.optional and self.type.need_has_if_optional()
 
     def check(self, schema: QAPISchema) -> None:
@@ -1024,8 +1003,6 @@ def __init__(
         coroutine: bool,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert not arg_type or isinstance(arg_type, str)
-        assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name = arg_type
         self.arg_type: Optional[QAPISchemaObjectType] = None
         self._ret_type_name = ret_type
@@ -1065,7 +1042,6 @@ def check(self, schema: QAPISchema) -> None:
             if self.name not in self.info.pragma.command_returns_exceptions:
                 typ = self.ret_type
                 if isinstance(typ, QAPISchemaArrayType):
-                    assert typ
                     typ = typ.element_type
                 if not isinstance(typ, QAPISchemaObjectType):
                     raise QAPISemError(
@@ -1103,7 +1079,6 @@ def __init__(
         boxed: bool,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
         self.arg_type: Optional[QAPISchemaObjectType] = None
         self.boxed = boxed
-- 
2.43.0


