Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC38AC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugk7t-0000ex-DQ; Tue, 29 Jul 2025 09:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7j-00009I-56
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugk7b-0001O3-C0
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753794714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67NDFhSuM7jaFnT3mAl+XQ3SgptNP+7TXvHSqfksudg=;
 b=aEc1payZwburatOQG5r5S26DVGa3vTY0tgePjHnmSAJyquJ3A6SyULPYLCmR4P4hC375+k
 kl3DvcytVO6bE/3sqLV97u7LaD6ggoAEr1Nueh7r6sgqPwmOqS1lK4BA6eT45c5S2fy9jT
 PG2ezAT6KGPHwo0kjZId/LHFWp6ywdo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-DsEFz9PFNHe41VXtP3PX-w-1; Tue,
 29 Jul 2025 09:11:52 -0400
X-MC-Unique: DsEFz9PFNHe41VXtP3PX-w-1
X-Mimecast-MFC-AGG-ID: DsEFz9PFNHe41VXtP3PX-w_1753794711
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92C07195608D
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47B0230078C3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 13:11:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 667C721E6925; Tue, 29 Jul 2025 15:11:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 2/5] qapi/accelerator: Fix markup of heading
Date: Tue, 29 Jul 2025 15:11:45 +0200
Message-ID: <20250729131148.3777401-3-armbru@redhat.com>
In-Reply-To: <20250729131148.3777401-1-armbru@redhat.com>
References: <20250729131148.3777401-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The docs generated for qapi/accelerator.json shows text "=
Accelerators" instead of a heading.  This is because the patch that
added the heading crossed with the commit that changed heading
markup (commit 6c10778826a "docs/sphinx: remove special parsing for
freeform sections").  Fix the markup.

Fixes: 18da42ee4273 (qapi/accel: Move definitions related to accelerators in their own file)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250724091742.1950167-2-armbru@redhat.com>
---
 qapi/accelerator.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 28d5ff4c49..fb28c8d920 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -4,7 +4,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 ##
-# = Accelerators
+# ************
+# Accelerators
+# ************
 ##
 
 { 'include': 'common.json' }
-- 
2.49.0


