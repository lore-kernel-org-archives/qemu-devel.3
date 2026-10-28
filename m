Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F9606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=erE8mAYl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4pZ-0000yN-QH; Wed, 28 Oct 2026 10:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM4pR-0000vR-Th
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM4pP-00058B-6B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793198434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRDtkjNfE5N5j17FDaFYlRnwCsv9dZpE5MhC5of/yDw=;
 b=erE8mAYl4pNSMl1XfCc4eRk1XaIZU1FO+HtjZVnt+nRtcgLeUPISyvY8Bmz4tUBiv/j3Ew
 6p/ZSj6r19TLbZuPDoeZZPyfkYNMUesFu26i6stCiPzUqr2kwvrgaacinc9JzwpDXvwXoS
 NTMk2KjD+EaSPxXWfdUZhtCrgVTZrDE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-jNutMNypOweOSwhpGkWqTA-1; Wed,
 28 Oct 2026 10:40:32 -0400
X-MC-Unique: jNutMNypOweOSwhpGkWqTA-1
X-Mimecast-MFC-AGG-ID: jNutMNypOweOSwhpGkWqTA_1793198431
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94CB11954AF7
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:40:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 537F41956086
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:40:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D7B2B21E692D; Wed, 28 Oct 2026 15:40:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	berrange@redhat.com
Subject: [PATCH 1/4] qapi/acpi-hest: Fix markup of heading
Date: Wed, 28 Oct 2026 15:40:20 +0100
Message-ID: <20261028144028.771869-2-armbru@redhat.com>
In-Reply-To: <20261028144028.771869-1-armbru@redhat.com>
References: <20261028144028.771869-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The docs generated for qapi/acpi-hest.json shows text "== GHESv2 CPER
Error Injection" instead of a heading.  This is because the patch that
added the heading crossed with the commit that changed heading
markup (commit 6c10778826a "docs/sphinx: remove special parsing for
freeform sections").  Fix the markup.

Fixes: ddd8f3baa27d ("qapi/acpi-hest: add an interface to do generic CPER error injection")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/acpi-hest.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
index 8db804df19..505f68e053 100644
--- a/qapi/acpi-hest.json
+++ b/qapi/acpi-hest.json
@@ -3,7 +3,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 ##
-# == GHESv2 CPER Error Injection
+# GHESv2 CPER Error Injection
+# ===========================
 #
 # Defined since ACPI Specification 6.1, section 18.3.2.8 Generic
 # Hardware Error Source version 2.  See:
-- 
2.55.0


