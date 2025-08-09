Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5E0CA0EC0
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 05:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukcTX-0001tz-TX; Sat, 09 Aug 2025 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTW-0001tA-1m
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ukcTS-0002Hd-Nq
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 01:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754718633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBh4s9w4E0rzgSovMPgUd6Go9+lWP90O+HqnEfxoKb0=;
 b=C6UOj+t7j/Q+VEm69rKFSxFvwIT5SBTjfOdbN3QCAK2IdBwnCwczCSHE4NESxl9rt0TvVi
 i907NH0LyJkVUz90kZ1q9jHhPPzDpLM6jIfm5cVfBo3uiJTZcYvDS7E7VoLgOnJoS/DnCB
 cJyyCtRdPcNUtfF1l11h/TzYWtfWzUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-W8pNU6FBOIuyvwp-Me1trw-1; Sat,
 09 Aug 2025 01:50:30 -0400
X-MC-Unique: W8pNU6FBOIuyvwp-Me1trw-1
X-Mimecast-MFC-AGG-ID: W8pNU6FBOIuyvwp-Me1trw_1754718630
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3914D1800342
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8B2019560AD
 for <qemu-devel@nongnu.org>; Sat,  9 Aug 2025 05:50:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1EAA21E6935; Sat, 09 Aug 2025 07:50:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 3/3] docs/devel/qapi-code-gen: Update cross-reference syntax
Date: Sat,  9 Aug 2025 07:50:26 +0200
Message-ID: <20250809055026.2944835-4-armbru@redhat.com>
In-Reply-To: <20250809055026.2944835-1-armbru@redhat.com>
References: <20250809055026.2944835-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20250731054044.4011789-4-armbru@redhat.com>
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


