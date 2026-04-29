Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE80CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAZZ-0007QY-Ii; Wed, 29 Apr 2026 15:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYi-0006bN-MD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYg-0007sA-Hk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777490807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KyCe0YgaCTl5zAFMYZ3oDlDsNQVtLgOU9+i6C3wwjc=;
 b=fMEEm7B8Zc6aCoTKQswrJAoioWTJT3kDYdEVHCmzqjcuq8fX6zWcOsuEzbVfGdQJTcKEAV
 Cx03/GAND7hdRuBdaIVK3byzdu9u6SoaWFAivCn9nzRxy9RyCtthps/yFVF+/DSR1S/f9t
 ibDUppjr9LGe4Rn/8mInEq4ErUWX7m4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-QNkvp3pYMRWAkE3WlFEuYA-1; Wed,
 29 Apr 2026 15:26:44 -0400
X-MC-Unique: QNkvp3pYMRWAkE3WlFEuYA-1
X-Mimecast-MFC-AGG-ID: QNkvp3pYMRWAkE3WlFEuYA_1777490803
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3F8519560A6; Wed, 29 Apr 2026 19:26:42 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C68451800446; Wed, 29 Apr 2026 19:26:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 06/13] qapi/docs: remove implicit Plain section
Date: Wed, 29 Apr 2026 15:26:04 -0400
Message-ID: <20260429192611.1581223-7-jsnow@redhat.com>
In-Reply-To: <20260429192611.1581223-1-jsnow@redhat.com>
References: <20260429192611.1581223-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prior to this patch, we always instantiate an empty Plain
section. Removing this allows us to gradually phase out the "Plain"
section in favor of "Intro" and "Details" sections while keeping "Plain"
around for the interim churn during the series - meaning that we don't
actually know at __init__ time which type of section we'll have first.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py         |  4 +---
 tests/qapi-schema/doc-good.out | 14 --------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index b21796b3e80..6612f471bb8 100644
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
index e2be6f96bbf..6fcc8175cfe 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -106,8 +106,6 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
-    section=Plain
-
     arg=one
 The _one_ {and only}, description on the same line
     arg=two
@@ -119,8 +117,6 @@ a member feature
     section=Plain
 @two is undocumented
 doc symbol=Base
-    section=Plain
-
     arg=base1
  description starts on a new line,
  minimally indented
@@ -138,16 +134,10 @@ a feature
     feature=member-feat
 a member feature
 doc symbol=Variant2
-    section=Plain
-
 doc symbol=Object
-    section=Plain
-
     feature=union-feat1
 a feature
 doc symbol=Alternate
-    section=Plain
-
     arg=i
 description starts on the same line
     remainder indented the same
@@ -161,8 +151,6 @@ doc freeform
 Another subsection
 ==================
 doc symbol=cmd
-    section=Plain
-
     arg=arg1
     description starts on a new line,
     indented
@@ -223,7 +211,5 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
-    section=Plain
-
     feature=feat3
 a feature
-- 
2.54.0


