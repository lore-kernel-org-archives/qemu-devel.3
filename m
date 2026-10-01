Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472BDCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUp-00008i-44; Thu, 01 Oct 2026 13:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUl-00007W-P1
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUk-0006xY-2Q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M0Lu4w3v5ROvHuqVnhBBxqGW5dfKhCSgiG5K8prljbs=;
 b=NexOYrH1yqZ/2lCeU5VISQgPNNvMIUmNQK+ZSVUp05oOjAkr5V7HwfkMnoTpiM3f6GJFqQ
 vNR6t44cFXHWyC4dxAyucPl5l0NepltFDp0NBk8imjHwSRACs48WJUPYMTnDE9gCxNmHYx
 eIeH8kBcWvolLuJjXcp7bT4EWWokal8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580---vaCPJxPBqx3KCE1zpiuA-1; Thu,
 01 Oct 2026 13:22:53 -0400
X-MC-Unique: --vaCPJxPBqx3KCE1zpiuA-1
X-Mimecast-MFC-AGG-ID: --vaCPJxPBqx3KCE1zpiuA_1790875373
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E54AF186BB05; Thu,  1 Oct 2026 17:22:52 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1462F180056E; Thu,  1 Oct 2026 17:22:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 10/11] docs/qapi-code-gen: add "Intro" subsection
Date: Thu,  1 Oct 2026 13:22:37 -0400
Message-ID: <20261001172239.2825745-11-jsnow@redhat.com>
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

Give the introductory section its own small treatment.

Without going into details about the as-yet-unmerged inliner, I
struggle to describe precisely how the intro should be used and what
types of documentation are better suited for Details. This is my
attempt.

I find PEP 257 https://peps.python.org/pep-0257/#one-line-docstrings
to have very good advice on what should appear in a doc summary line,
but did not want to reference it directly in our specification.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index febe8af49f9..4932dd35b64 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -985,13 +985,30 @@ When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
 Definition documentation starts with a description naming the
-definition with an optional indented overview, :ref:`descriptions
-<doc-descrip>` of each argument (for commands and events), member (for
-structs and unions), branch (for alternates), or value (for enums),
-:ref:`feature descriptions <doc-feat>` of each feature (if any), and
-finally optional tagged sections.
+definition with an optional indented overview (the :ref:`doc-intro`),
+:ref:`descriptions <doc-descrip>` of each argument (for commands and
+events), member (for structs and unions), branch (for alternates), or
+value (for enums), :ref:`feature descriptions <doc-feat>` of each
+feature (if any), and finally optional tagged sections.
 
 
+.. _doc-intro:
+
+Intro
+^^^^^
+
+The Intro section names the symbol being defined and is optionally
+followed by an indented brief summary or overview of the definition.
+
+The intro section *may* consist of multiple indented paragraphs, but
+is ideally a single summary line that does not repeat type
+information or reference individual arguments/members/et al::
+
+  ##
+  # @query-block-jobs:
+  #     Return information about long-running block device operations.
+  #
+
 
 .. _doc-descrip:
 
-- 
2.55.0


