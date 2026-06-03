Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FD1CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcC2-0000t5-Uc; Tue, 02 Jun 2026 23:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcC1-0000mz-0q
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wUcBz-0002T1-Fn
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780456974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcOyyMvF31+cUE24n3jEGHkdEH2/+jIBhFBTj92e3UY=;
 b=C72/bIZceT4DbfbCLYhBlWVtzSZ4UeaKjAwiWU1WogUGa1BDGbdPCBgLFYbL+fqAgwLI8a
 BVslLOOLi/bmrtZUbou6rHf97rJbwaohJ6LRvuA8cIM4F71YFusyPznu8LdwfXwaX5r97B
 YPJY6WbqyNDePYXsJdfGNcjp7uhYByY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-Kq0itHC5OQWClD1o2AoIRQ-1; Tue,
 02 Jun 2026 23:22:51 -0400
X-MC-Unique: Kq0itHC5OQWClD1o2AoIRQ-1
X-Mimecast-MFC-AGG-ID: Kq0itHC5OQWClD1o2AoIRQ_1780456970
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E90F1800635; Wed,  3 Jun 2026 03:22:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A103C30001A1; Wed,  3 Jun 2026 03:22:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 10/16] qapi/docs: remove implicit Plain section
Date: Tue,  2 Jun 2026 23:21:55 -0400
Message-ID: <20260603032201.993015-11-jsnow@redhat.com>
In-Reply-To: <20260603032201.993015-1-jsnow@redhat.com>
References: <20260603032201.993015-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prior to this patch, we always create an empty Plain section. Removing
this allows us to gradually phase out the "Plain" section in favor of
"Intro" and "Details" sections while keeping "Plain" around for the
interim churn during the series - meaning that we don't actually know
at __init__ time which type of section we'll have first.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py         |  4 +---
 tests/qapi-schema/doc-good.out | 14 --------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 406edf6aa9d..4beec4f9eda 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -730,9 +730,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = [
-            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
-        ]
+        self.all_sections: List[QAPIDoc.Section] = []
         # dicts mapping parameter/feature names to their description
         self._args: Dict[str, QAPIDoc.ArgSection] = {}
         self._features: Dict[str, QAPIDoc.ArgSection] = {}
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index b9829e2f841..16f44221771 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -106,8 +106,6 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
-    Plain
-
     Member=one
 The _one_ {and only}, description on the same line
     Member=two
@@ -119,8 +117,6 @@ a member feature
     Plain
 @two is undocumented
 doc symbol=Base
-    Plain
-
     Member=base1
  description starts on a new line,
  minimally indented
@@ -138,16 +134,10 @@ a feature
     Feature=member-feat
 a member feature
 doc symbol=Variant2
-    Plain
-
 doc symbol=Object
-    Plain
-
     Feature=union-feat1
 a feature
 doc symbol=Alternate
-    Plain
-
     Member=i
 description starts on the same line
     remainder indented the same
@@ -161,8 +151,6 @@ doc freeform
 Another subsection
 ==================
 doc symbol=cmd
-    Plain
-
     Member=arg1
     description starts on a new line,
     indented
@@ -223,7 +211,5 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
-    Plain
-
     Feature=feat3
 a feature
-- 
2.54.0


