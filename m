Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4B3C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCfE-000759-GG; Mon, 19 Aug 2024 20:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCev-0005Z0-7I
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCet-0003s6-K2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ChOcyKM7vxrJog08lbTCt4LwIxuTF65PtkjUT+QeaE=;
 b=ScEm9opQqgoGAohmmBAUVvdi8xi0LunG2k2uC1QpE4IksCLy/WBF41jx3oYFr5VpzkQjL2
 rUmtuNSlF6XniGwNf8jmTEMCQEeufMQGPO/qNAcn6tUVa7kTvQD+ZfhJlCoOohMg5mrlpE
 cjo6SVtr+RuPA8RKOjnBFKAUw2NKJFQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-KrQ78QTtNgGL6n0865yFhA-1; Mon,
 19 Aug 2024 20:23:31 -0400
X-MC-Unique: KrQ78QTtNgGL6n0865yFhA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8C611955D57; Tue, 20 Aug 2024 00:23:30 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12E0F1955F44; Tue, 20 Aug 2024 00:23:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] python/qapi: add pylint pragmas
Date: Mon, 19 Aug 2024 20:23:12 -0400
Message-ID: <20240820002318.1380276-4-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We are preparing to move the QAPI generator code into
qemu.git/python/qemu/qapi.

The qemu.git/python pylint configuration is stricter than the current
qapi generator configuration. These additional pragmas bridge the gap
without requiring us to loosen the requirements in the python directory.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/expr.py       | 1 +
 scripts/qapi/introspect.py | 1 +
 scripts/qapi/parser.py     | 4 ++++
 scripts/qapi/visit.py      | 1 +
 4 files changed, 7 insertions(+)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index cae0a083591..f60e580dd36 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -604,6 +604,7 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
     :raise QAPISemError: When any expression fails validation.
     :return: The same list of expressions (now modified).
     """
+    # pylint: disable=too-many-branches
     for expr in exprs:
         info = expr.info
         doc = expr.doc
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index ac14b20f308..9d499f90b7c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -106,6 +106,7 @@ def _tree_to_qlit(obj: JSONValue,
     :param dict_value: True when the value being processed belongs to a
                        dict key; which suppresses the output indent.
     """
+    # pylint: disable=too-many-branches
 
     def indent(level: int) -> str:
         return level * 4 * ' '
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9a42b119131..9bb039fe8d3 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -118,6 +118,8 @@ def _parse(self) -> None:
 
         :return: None.  Results are stored in ``.exprs`` and ``.docs``.
         """
+        # pylint: disable=too-many-branches
+
         cur_doc = None
 
         # May raise OSError; allow the caller to handle it.
@@ -290,6 +292,7 @@ def accept(self, skip_comment: bool = True) -> None:
 
             ``.tok`` and ``.val`` will both be None at EOF.
         """
+        # pylint: disable=too-many-branches
         while True:
             self.tok = self.src[self.cursor]
             self.pos = self.cursor
@@ -478,6 +481,7 @@ def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
             doc.append_line(line)
 
     def get_doc(self) -> 'QAPIDoc':
+        # pylint: disable=too-many-statements,too-many-branches
         if self.val != '##':
             raise QAPIParseError(
                 self, "junk after '##' at start of documentation comment")
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 12f92e429f6..20ce6be9978 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -65,6 +65,7 @@ def gen_visit_object_members(name: str,
                              base: Optional[QAPISchemaObjectType],
                              members: List[QAPISchemaObjectTypeMember],
                              branches: Optional[QAPISchemaBranches]) -> str:
+    # pylint: disable=too-many-branches
     ret = mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
-- 
2.45.0


