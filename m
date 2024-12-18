Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BA5E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrky-0001sG-6B; Wed, 18 Dec 2024 05:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNrkv-0001ca-ET
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNrkp-0000CH-Dv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQnkA9wurQNI2ERFpWeQxW3K9XFEWmubu/lIfSrW7OA=;
 b=SjbnoB+6pFJQeMhHZ6xjN/OoEQ+wAZdcXyf+ZobZgcrjHpVLsuyM29rQNdqOaSBsBJ43Jn
 NsLig+AiRs1jf+nO3+8gax4am7GQ62xSvW76ma8PwtR6F0XzY/fudDtE4SUBk+2Xb9j4rO
 HWqMJ8fexlqJDmRstoumKciY4PUMljI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-S0igBtF-MgSEV-8RbJozTg-1; Wed,
 18 Dec 2024 05:58:06 -0500
X-MC-Unique: S0igBtF-MgSEV-8RbJozTg-1
X-Mimecast-MFC-AGG-ID: S0igBtF-MgSEV-8RbJozTg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 796E0195607D; Wed, 18 Dec 2024 10:58:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F15921956053; Wed, 18 Dec 2024 10:58:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D82021E6827; Wed, 18 Dec 2024 11:58:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 04/23] qapi: expand tags to all doc sections
In-Reply-To: <20241213021827.2956769-5-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:07 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-5-jsnow@redhat.com>
Date: Wed, 18 Dec 2024 11:58:01 +0100
Message-ID: <87y10dtg06.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> This patch adds an explicit section tag to all QAPIDoc
> sections. Members/Features are now explicitly tagged as such, with the
> name now being stored in a dedicated "name" field (which qapidoc.py was
> not actually using anyway.)
>
> WIP: Yeah, the difference between "tagged" and "untagged" sections is
> now pretty poorly named, and explicitly giving "untagged" sections an
> "UNTAGGED" tag is ... well, worse. but mechanically, this accomplishes
> what I need for the series.
>
> Please suggest better naming conventions, keeping in mind that I
> currently have plans for a future patch that splits the "UNTAGGED" tag
> into "INTRO" and "DETAILS" tags. But, we still need a meta-name for the
> category of sections that are "formerly known as untagged" but cannot be
> called "freeform" because that name is used for the category of
> docblocks that are not attached to an entity (but happens to be
> comprised entirely of "formerly known as untagged" sections.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Doesn't pass 'make check' for me.  Diff appended.  It shows the error
messages get worse.


diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-schema/doc-duplicated-return.err
index 503b916b25..c0036fe8aa 100644
--- a/tests/qapi-schema/doc-duplicated-return.err
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -1 +1 @@
-doc-duplicated-return.json:8: duplicated 'Returns' section
+doc-duplicated-return.json:8: duplicated 'Tag.RETURNS' section
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-schema/doc-duplicated-since.err
index a9b60c0c3d..1066040560 100644
--- a/tests/qapi-schema/doc-duplicated-since.err
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -1 +1 @@
-doc-duplicated-since.json:8: duplicated 'Since' section
+doc-duplicated-since.json:8: duplicated 'Tag.SINCE' section
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/doc-empty-section.err
index 711a0d629c..3eae1b93c9 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-doc-empty-section.json:6: text required after 'Errors:'
+doc-empty-section.json:6: text required after 'Tag.ERRORS:'
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index ec277be91e..87d2f074cf 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -110,7 +110,7 @@ The _one_ {and only}, description on the same line
 Also _one_ {and only}
     feature=enum-member-feat
 a member feature
-    section=None
+    section=Tag.UNTAGGED
 @two is undocumented
 doc symbol=Base
     body=
@@ -168,15 +168,15 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=None
+    section=Tag.UNTAGGED
 .. note:: @arg3 is undocumented
-    section=Returns
+    section=Tag.RETURNS
 @Object
-    section=Errors
+    section=Tag.ERRORS
 some
-    section=TODO
+    section=Tag.TODO
 frobnicate
-    section=None
+    section=Tag.UNTAGGED
 .. admonition:: Notes
 
  - Lorem ipsum dolor sit amet
@@ -200,7 +200,7 @@ Examples::
 
 Note::
     Ceci n'est pas une note
-    section=Since
+    section=Tag.SINCE
 2.10
 doc symbol=cmd-boxed
     body=
@@ -209,7 +209,7 @@ If you're bored enough to read this, go see a video of boxed cats
 a feature
     feature=cmd-feat2
 another feature
-    section=None
+    section=Tag.UNTAGGED
 .. qmp-example::
 
    -> "this example"


