Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1239CA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUk-00006t-Qj; Thu, 01 Oct 2026 13:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUi-00005l-M4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUg-0006ws-TF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d/bO0aLAO4a0bEivHsgpJrmpIIJcq9RNM8+5qXbbFkQ=;
 b=UIlYBdsUE6RiJfxsbqCQzPtVRzU1qzqvjimgCl21u2cCEeREGPIPCZlQ3HYKZq9gfWqsKA
 78L+sULfsw4vr4xk/DC/T/51VfBuU+IT79QG8S9odhwtfeukrKJErCX4dmCVM7JvV4Fmik
 RVFb318y/ypR/v3J80MaPW752m99l2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-efQfHoxGMMioTrFYA0Fz7w-1; Thu,
 01 Oct 2026 13:22:52 -0400
X-MC-Unique: efQfHoxGMMioTrFYA0Fz7w-1
X-Mimecast-MFC-AGG-ID: efQfHoxGMMioTrFYA0Fz7w_1790875371
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D22191977528; Thu,  1 Oct 2026 17:22:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F37E5180056E; Thu,  1 Oct 2026 17:22:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 09/11] docs/qapi-code-gen: add "Feature descriptions"
 subsection
Date: Thu,  1 Oct 2026 13:22:36 -0400
Message-ID: <20261001172239.2825745-10-jsnow@redhat.com>
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com>
References: <20261001172239.2825745-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move the features text down to where it would appear in-order in a
QAPI documentation block, and expand it into its own subsection
separate from member/arg/etc descriptions.

This draft refers back to the "Descriptions" section to make it clear
that they are syntactically related, but has otherwise broken the
section out into its own discrete thing to make it clear that it is an
entirely separate section (group of sections).

The key element here is that Descriptions and Feature Descriptions
have been split apart so that they can each occupy their correct
relative position in the docs that mirrors their appearance in actual
documentation.

(i.e. members - returns - errors - features, in that order.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 7e7b11d01df..febe8af49f9 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -987,9 +987,10 @@ definition must have documentation.
 Definition documentation starts with a description naming the
 definition with an optional indented overview, :ref:`descriptions
 <doc-descrip>` of each argument (for commands and events), member (for
-structs and unions), branch (for alternates), or value (for enums), a
-description of each feature (if any), and finally optional tagged
-sections.
+structs and unions), branch (for alternates), or value (for enums),
+:ref:`feature descriptions <doc-feat>` of each feature (if any), and
+finally optional tagged sections.
+
 
 
 .. _doc-descrip:
@@ -1013,14 +1014,6 @@ The description text must be indented like this::
 Extensions added after the definition was first released carry a
 "(since x.y)" comment.
 
-The feature descriptions must be preceded by a blank line and then a
-line "Features:", like this::
-
-  #
-  # Features:
-  #
-  # @feature: Description text
-
 
 .. _doc-tagged:
 
@@ -1074,6 +1067,23 @@ detailing a relevant error condition.  For example::
  #     - Any other error returns a GenericError.
 
 
+.. _doc-feat:
+
+Feature Descriptions
+^^^^^^^^^^^^^^^^^^^^
+
+Feature descriptions are a :ref:`doc-descrip` section that document features
+that apply to this definition.
+
+The feature descriptions must be preceded by a blank line and then a
+line "Features:", like this::
+
+  #
+  # Features:
+  #
+  # @feature: Description text
+
+
 Details
 ^^^^^^^
 
-- 
2.55.0


