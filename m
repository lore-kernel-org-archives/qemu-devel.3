Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B003AC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 05:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhMEX-0008RX-UX; Thu, 31 Jul 2025 01:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uhM0M-0005PT-Nc
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uhM0J-0008Rn-QE
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 01:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753940338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FC2RThKztReibi8ESu44zKPCwpuxR8vM7hXq6EN5eU=;
 b=XrbHdA8L59WGEnI79dRZh4suv2KJdYIl92owHPCBYnC1RXBFmBqEIrPp0I+e4ze9isesm7
 ESJpJYcwmW2ka8cwEA7ImIGgQlQIvYjq9w95q1ZBRmx59Yf18JVNjAlSU+L9IGBRLunIRk
 3jVJ6O/LGEK9Ajiyh5rpLqf2CPL1ux4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-o-Vk-eulO8S9L7ar1jXzfA-1; Thu,
 31 Jul 2025 01:38:54 -0400
X-MC-Unique: o-Vk-eulO8S9L7ar1jXzfA-1
X-Mimecast-MFC-AGG-ID: o-Vk-eulO8S9L7ar1jXzfA_1753940333
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE6FC1956089; Thu, 31 Jul 2025 05:38:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 609EB1800D85; Thu, 31 Jul 2025 05:38:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF43121E6935; Thu, 31 Jul 2025 07:38:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, peter.maydell@linaro.org,
 eblake@redhat.com
Subject: [PULL 3/3] docs/devel/qapi-code-gen: Update cross-reference syntax
Date: Thu, 31 Jul 2025 07:38:49 +0200
Message-ID: <20250731053849.4011538-4-armbru@redhat.com>
In-Reply-To: <20250731053849.4011538-1-armbru@redhat.com>
References: <20250731053849.4011538-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The new QAPI code generator creates a cross-reference target for each
definition documentation.  Enabled for the QEMU QMP Reference manual
in commit a377f39f38f, and for the QEMU Storage Daemon QMP Reference
Manual and the QEMU Guest Agent Protocol Reference in commit
a6af5443440.  We've put these targets to use since, but neglected to
update doc comment markup documentation.  Do that now.

Co-developed-by: John Snow <jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 11 ++++++++---
 docs/devel/qapi-domain.rst   |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 2cd51729c3..d97602f464 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -943,9 +943,14 @@ The usual ****strong****, *\*emphasized\** and ````literal```` markup
 should be used.  If you need a single literal ``*``, you will need to
 backslash-escape it.
 
-Use ``@foo`` to reference a name in the schema.  This is an rST
-extension.  It is rendered the same way as ````foo````, but carries
-additional meaning.
+Use ```foo``` to reference a definition in the schema.  This generates
+a link to the definition.  In the event that such a cross-reference is
+ambiguous, you can use `QAPI cross-reference roles
+<QAPI-domain-cross-references>` to disambiguate.
+
+Use @foo to reference a member description within the current
+definition.  This is an rST extension.  It is currently rendered the
+same way as ````foo````, but carries additional meaning.
 
 Example::
 
diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
index fe540d1e40..1924f12d42 100644
--- a/docs/devel/qapi-domain.rst
+++ b/docs/devel/qapi-domain.rst
@@ -375,6 +375,7 @@ Will allow you to add arbitrary field lists in QAPI directives::
 
       :see also: Lorem ipsum, dolor sit amet ...
 
+.. _QAPI-domain-cross-references:
 
 Cross-references
 ================
-- 
2.49.0


