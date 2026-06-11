Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2624CCD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWxj-0004m2-Qs; Thu, 11 Jun 2026 00:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxi-0004k2-Fq
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxg-0005X4-Pp
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781151852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/8BRod6YgBNjBQ1A4fmjvtc3BSkD+yn4td3noauUX8=;
 b=EQbve51c9eGhyv5SwgovKh23qpZT6JLi4NqQ6EhPN014JQj+EQpdTEO7Vz2Qmtol/pP6ZR
 svD4RubBZWbPPsrCe8e7zO2N5ffAdQOsNVMOK/ocI/SgFRzHSU/QBDqfd7BfKZB244t3Hm
 e0G9qAGQ63DyWxyFm0O8wIpmQy6jir0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-jy2gUqlVMZ6FMmrpQ9cBEQ-1; Thu,
 11 Jun 2026 00:24:08 -0400
X-MC-Unique: jy2gUqlVMZ6FMmrpQ9cBEQ-1
X-Mimecast-MFC-AGG-ID: jy2gUqlVMZ6FMmrpQ9cBEQ_1781151847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31BC518D97D8; Thu, 11 Jun 2026 04:24:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 205F71800480; Thu, 11 Jun 2026 04:24:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, linux-edac@vger.kernel.org,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 05/13] qapi/docs: make remaining subsection members
 "private"
Date: Thu, 11 Jun 2026 00:23:24 -0400
Message-ID: <20260611042332.482979-6-jsnow@redhat.com>
In-Reply-To: <20260611042332.482979-1-jsnow@redhat.com>
References: <20260611042332.482979-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

These fields are used to provide error checking and internal logistics
and should not be used by a user of the library to directly access
documentation sections, so make them private.

The "since" field alone is left public, as the qapidoc generator does
use this field to pull that section out of the regular flow of the
document.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index dcc58170bd5..da4756a7424 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -733,17 +733,17 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
             QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
         ]
         # dicts mapping parameter/feature names to their description
-        self.args: Dict[str, QAPIDoc.ArgSection] = {}
-        self.features: Dict[str, QAPIDoc.ArgSection] = {}
+        self._args: Dict[str, QAPIDoc.ArgSection] = {}
+        self._features: Dict[str, QAPIDoc.ArgSection] = {}
         # a command's "Returns" and "Errors" section
-        self.returns: Optional[QAPIDoc.Section] = None
-        self.errors: Optional[QAPIDoc.Section] = None
+        self._returns: Optional[QAPIDoc.Section] = None
+        self._errors: Optional[QAPIDoc.Section] = None
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
 
     @property
     def has_features(self) -> bool:
-        return bool(self.features)
+        return bool(self._features)
 
     def end(self) -> None:
         for section in self.all_sections:
@@ -775,15 +775,15 @@ def new_tagged_section(
     ) -> None:
         section = self.Section(info, kind)
         if kind == QAPIDoc.Kind.RETURNS:
-            if self.returns:
+            if self._returns:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % kind)
-            self.returns = section
+            self._returns = section
         elif kind == QAPIDoc.Kind.ERRORS:
-            if self.errors:
+            if self._errors:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % kind)
-            self.errors = section
+            self._errors = section
         elif kind == QAPIDoc.Kind.SINCE:
             if self.since:
                 raise QAPISemError(
@@ -807,16 +807,16 @@ def _new_description(
         desc[name] = section
 
     def new_argument(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self.args)
+        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self._args)
 
     def new_feature(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self.features)
+        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self._features)
 
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
 
     def connect_member(self, member: 'QAPISchemaMember') -> None:
-        if member.name not in self.args:
+        if member.name not in self._args:
             assert member.info
             if self.symbol not in member.info.pragma.documentation_exceptions:
                 raise QAPISemError(member.info,
@@ -827,7 +827,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
 
             section = QAPIDoc.ArgSection(
                 self.info, QAPIDoc.Kind.MEMBER, member.name)
-            self.args[member.name] = section
+            self._args[member.name] = section
 
             # Determine where to insert stub doc - it should go at the
             # end of the members section(s), if any. Note that index 0
@@ -839,14 +839,14 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                     index += 1
             self.all_sections.insert(index, section)
 
-        self.args[member.name].connect(member)
+        self._args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
-        if feature.name not in self.features:
+        if feature.name not in self._features:
             raise QAPISemError(feature.info,
                                "feature '%s' lacks documentation"
                                % feature.name)
-        self.features[feature.name].connect(feature)
+        self._features[feature.name].connect(feature)
 
     def ensure_returns(self, info: QAPISourceInfo) -> None:
 
@@ -887,18 +887,18 @@ def _insert_near_kind(
 
     def check_expr(self, expr: QAPIExpression) -> None:
         if 'command' in expr:
-            if self.returns and 'returns' not in expr:
+            if self._returns and 'returns' not in expr:
                 raise QAPISemError(
-                    self.returns.info,
+                    self._returns.info,
                     "'Returns' section, but command doesn't return anything")
         else:
-            if self.returns:
+            if self._returns:
                 raise QAPISemError(
-                    self.returns.info,
+                    self._returns.info,
                     "'Returns' section is only valid for commands")
-            if self.errors:
+            if self._errors:
                 raise QAPISemError(
-                    self.errors.info,
+                    self._errors.info,
                     "'Errors' section is only valid for commands")
 
     def check(self) -> None:
@@ -918,5 +918,5 @@ def check_args_section(
                         "do" if len(bogus) > 1 else "does"
                     ))
 
-        check_args_section(self.args, 'member')
-        check_args_section(self.features, 'feature')
+        check_args_section(self._args, 'member')
+        check_args_section(self._features, 'feature')
-- 
2.54.0


