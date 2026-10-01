Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AFBCA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUp-00008j-4I; Thu, 01 Oct 2026 13:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUl-00006y-29
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUj-0006xP-2n
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYsb7NTC8Z9e9Rqh6I1hYSOLFUYlcVN77Z36/edbuYc=;
 b=D8NV693EcAprLDjXgk7uxiwqnj5r/TBjnxPfmK0H/8cLmZmLFP+diYW+C4VMWadNMalkU+
 1GkwtmKm4QEZeZEUGO+sxwETZgBJ/nIAS32+ni220EW5yGxJqFMoiOrZCnQDdjJEuT+g6+
 eBTQKLq4YLQwDqRCC5iLfjsuK3gMqkI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-QXG6CBpcM4eLjJl_w955VQ-1; Thu,
 01 Oct 2026 13:22:55 -0400
X-MC-Unique: QXG6CBpcM4eLjJl_w955VQ-1
X-Mimecast-MFC-AGG-ID: QXG6CBpcM4eLjJl_w955VQ_1790875374
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0487D182A107; Thu,  1 Oct 2026 17:22:54 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2819C18002B7; Thu,  1 Oct 2026 17:22:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/11] docs/qapi-code-gen: add "Tagged sections"
 cross-references
Date: Thu,  1 Oct 2026 13:22:38 -0400
Message-ID: <20261001172239.2825745-12-jsnow@redhat.com>
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com>
References: <20261001172239.2825745-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

Add some XRef markup that links to the "tagged section" subsection. I
don't know if we want to keep that section, so these cross-reference
additions are isolated here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 4932dd35b64..ff7663a2666 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -989,7 +989,8 @@ definition with an optional indented overview (the :ref:`doc-intro`),
 :ref:`descriptions <doc-descrip>` of each argument (for commands and
 events), member (for structs and unions), branch (for alternates), or
 value (for enums), :ref:`feature descriptions <doc-feat>` of each
-feature (if any), and finally optional tagged sections.
+feature (if any), and finally optional :ref:`tagged sections
+<doc-tagged>`.
 
 
 .. _doc-intro:
@@ -1054,7 +1055,7 @@ like this::
 Returns
 ^^^^^^^
 
-"Returns" sections are only valid for commands.  They document the
+"Returns" :ref:`doc-tagged` are only valid for commands.  They document the
 success response of the command. If there is some nuance to capture
 with the return value, it may be documented as::
 
@@ -1073,8 +1074,8 @@ this section may be omitted.
 Errors
 ^^^^^^
 
-"Errors" sections are only valid for commands.  They document
-the error response(s) for a command.
+"Errors" :ref:`doc-tagged` are only valid for commands.  They document
+the error responses.
 
 "Errors" sections should be formatted as an rST list, each entry
 detailing a relevant error condition.  For example::
@@ -1162,7 +1163,7 @@ achieved by omitting the language argument.
 Since
 ^^^^^
 
-A "Since: x.y" section lists the release that introduced the
+A "Since: x.y" :ref:`doc-tagged` lists the release that introduced the
 definition::
 
   #
-- 
2.55.0


