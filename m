Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F18606A5BC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MsTvzqjO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDZ-0003On-BM; Mon, 02 Nov 2026 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD1-00036t-Mj
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtCz-0008OW-80
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgiXp1wEtyK41O/sVgAq7b25DbBtsZAcH5FF+s+YGB4=;
 b=MsTvzqjOYMpTt2mF7lUkU/stdy2trNGXBhQAlNDlMHjrpRNolsP6C6YegBoR0bvSy0+GNt
 kGFiHQlbWSVXsD/C3gH8rEFNfNo+cy5/QMGKN/9kgm8hxBuwuFoJatsRcorrVEh1gCEmom
 zse2jcYxAdFgi1/r9pYOdOo2mjkv62g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-pY8Z3tC8MfW2KDH_iDAeyg-1; Mon,
 02 Nov 2026 09:40:22 -0500
X-MC-Unique: pY8Z3tC8MfW2KDH_iDAeyg-1
X-Mimecast-MFC-AGG-ID: pY8Z3tC8MfW2KDH_iDAeyg_1793630421
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C51D3180AEE2; Mon,  2 Nov 2026 14:40:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B89230000E7; Mon,  2 Nov 2026 14:40:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E68BA21E6880; Mon, 02 Nov 2026 15:40:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 02/74] qga/qapi-schema: Drop "This is a read-only operation"
Date: Mon,  2 Nov 2026 15:39:06 +0100
Message-ID: <20261102144018.3212223-3-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Documentation of guest-get-vcpus and guest-get-memory-blocks has "This
is a read-only operation".  Similar commands don't.  A "get" command
that actually writes would be in surprisingly bad taste.  Delete both
instances of the sentence.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260923064212.839691-1-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
[Straightforward conflict with commit 45a70e37ff (qapi: split intros
for qga/qapi-schema.json) resolved]
---
 qga/qapi-schema.json | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 7b937713e6..a6cda5eae1 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -741,8 +741,6 @@
 # @guest-get-vcpus:
 #     Retrieve the list of the guest's logical processors.
 #
-#     This is a read-only operation.
-#
 # Returns: The list of all VCPUs the guest knows about.  Each VCPU is
 #     put on the list exactly once, but their order is unspecified.
 #
@@ -1100,8 +1098,6 @@
 # @guest-get-memory-blocks:
 #     Retrieve the list of the guest's memory blocks.
 #
-#     This is a read-only operation.
-#
 # Returns: The list of all memory blocks the guest knows about.  Each
 #     memory block is put on the list exactly once, but their order is
 #     unspecified.
-- 
2.55.0


