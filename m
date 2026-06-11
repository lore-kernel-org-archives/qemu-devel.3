Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D2CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWxw-0005Ef-OZ; Thu, 11 Jun 2026 00:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxt-0004vL-1F
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxr-0005Ya-HH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781151862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6G8ieSNPc0xcSVEK59e57gLX+A/vEMuKvzW9P7RxR8=;
 b=UWo98kl2yocHwqQOzcMFFsqOilfFZ5CrOYYVMqEAPFi16t34kkENs6Z7vd7mAQX6LPLZn4
 nSGRXx79cgetSjg+h5cy7uXnmd+TBewzCLh0lxqFwqqCzhmE2UUM+d/jhWLKPuhnwme0sU
 1RKp4ZW+Oqay+2k+y1Z4ABO4447UYvI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-77TCvxNhNAaOGXv0QGPc_g-1; Thu,
 11 Jun 2026 00:24:19 -0400
X-MC-Unique: 77TCvxNhNAaOGXv0QGPc_g-1
X-Mimecast-MFC-AGG-ID: 77TCvxNhNAaOGXv0QGPc_g_1781151857
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB107180894F; Thu, 11 Jun 2026 04:24:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2213B1800480; Thu, 11 Jun 2026 04:24:12 +0000 (UTC)
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
Subject: [PATCH v4 07/13] qapi/docs: add "Intro" section
Date: Thu, 11 Jun 2026 00:23:26 -0400
Message-ID: <20260611042332.482979-8-jsnow@redhat.com>
In-Reply-To: <20260611042332.482979-1-jsnow@redhat.com>
References: <20260611042332.482979-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This patch adds an "Intro" doc section, intended to eventually replace
the "Plain" doc section alongside a forthcoming "Details" section.

For now, this section is not actually instantiated or used, but
subsequent patches will slowly convert the leading introductory sections
of QAPIDoc documentation to use this new section.

A main motivation of this series of changes is to more explicitly
delineate the "Introductory" documentation for each QAPI definition for
the sake of the inliner. When inlining members, examples, and details
from multiple QAPIDoc sections, we will want to omit the "Introductory"
text from inlined definitions while keeping notes, caution boxes,
examples, and so on. This new section facilitates that.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 2 +-
 scripts/qapi/parser.py | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c2f09bac16c..1f7c15b7075 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -368,7 +368,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
         for i, section in enumerate(sections):
             section.text = self.reformat_arobase(section.text)
 
-            if section.kind == QAPIDoc.Kind.PLAIN:
+            if section.kind.name in ("PLAIN", "INTRO"):
                 self.visit_paragraph(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
                 assert isinstance(section, QAPIDoc.ArgSection)
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index d8068bb1bf6..97e7dacb0fd 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -681,6 +681,7 @@ class Kind(enum.Enum):
         ERRORS = 4
         SINCE = 5
         TODO = 6
+        INTRO = 7
 
         @staticmethod
         def from_string(kind: str) -> 'QAPIDoc.Kind':
@@ -748,7 +749,7 @@ def has_features(self) -> bool:
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-            if section.kind != QAPIDoc.Kind.PLAIN and section.text == '':
+            if not (section.kind.name in ("INTRO", "PLAIN") or section.text):
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.kind)
 
-- 
2.54.0


