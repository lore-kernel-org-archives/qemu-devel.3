Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F22CA5FDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKUo-000089-8m; Thu, 01 Oct 2026 13:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUh-00005N-6c
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xCKUf-0006wV-LG
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790875373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UA9NJUGZGQHtACdSce224KO4nypWuzIASCtwqNttVwg=;
 b=FGHRh0eBkFYRMr2+IF+/lEY54PZytR1+mYv5RxcFgU2HVBBKaFZKoMcNzC8UoyXiM1CPGF
 A8cnhCcHW99H6dTaH4i4XsQ1+5ujKiYvQSAAPMegRH9KgCePbqObuAJmkluwwq+Z3DqcsY
 C58Nf21YjQOaHT3j47BAlx6S21tlyvA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-6ofdOkHBOTSVyRGgOsAFjw-1; Thu,
 01 Oct 2026 13:22:51 -0400
X-MC-Unique: 6ofdOkHBOTSVyRGgOsAFjw-1
X-Mimecast-MFC-AGG-ID: 6ofdOkHBOTSVyRGgOsAFjw_1790875370
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC3321802143; Thu,  1 Oct 2026 17:22:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFF591800348; Thu,  1 Oct 2026 17:22:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 08/11] docs/qapi-code-gen: add "Descriptions" subsection
Date: Thu,  1 Oct 2026 13:22:35 -0400
Message-ID: <20261001172239.2825745-9-jsnow@redhat.com>
In-Reply-To: <20261001172239.2825745-1-jsnow@redhat.com>
References: <20261001172239.2825745-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Section off the part of the spec that describes descriptions.

Similarly to "Tagged sections", the concept of naming "Descriptions"
as a proper noun might also be something we'd like to sunset, but for
now I have retained the section. I believe the documentation itself is
entirely valid and useful, but we may want to come up with a term for
"arguments, members, branches, or values" as a group of concepts
instead - excising only "Features" as something that is different.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 1897cde39cf..7e7b11d01df 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -985,13 +985,23 @@ When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
 Definition documentation starts with a description naming the
-definition with an optional indented overview, a description of each
-argument (for commands and events), member (for structs and unions),
-branch (for alternates), or value (for enums), a description of each
-feature (if any), and finally optional tagged sections.
+definition with an optional indented overview, :ref:`descriptions
+<doc-descrip>` of each argument (for commands and events), member (for
+structs and unions), branch (for alternates), or value (for enums), a
+description of each feature (if any), and finally optional tagged
+sections.
 
-Descriptions start with '\@name:'.  The description text must be
-indented like this::
+
+.. _doc-descrip:
+
+Descriptions
+^^^^^^^^^^^^
+
+Descriptions start with '\@name:'.  These are used to document
+arguments (for commands and events), members (for structs and unions),
+branches (for alternates), or values (for enums).
+
+The description text must be indented like this::
 
  # @name: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed
  #     do eiusmod tempor incididunt ut labore et dolore magna aliqua.
-- 
2.55.0


