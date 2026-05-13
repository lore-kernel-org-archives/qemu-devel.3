Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EC3CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDkf-0005TS-6G; Wed, 13 May 2026 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDke-0005Sr-4z
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDkc-0002o3-GA
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778694725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQPdJCYMP04iC/+9IzqZArArbH+iZ855zkPwPvUgdjI=;
 b=M6aYS2AEt12i4JULMmQGDbe1qU2NJ3Cwq+xb6/kWdh2UphQDov6W8LNm40OIkdSOMdru4w
 4zaOmxS1KFyIhIPikFK5/3xsscd0jbsXREs3WnQeTaurcR+C86C4h1Rf5TlfP1cTxa3Ti7
 Rcftyl4CCsctT1Rzbev6SG2b3eil8RI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-bQ7BH5iAMt-t1jPMKpSOvg-1; Wed,
 13 May 2026 13:52:04 -0400
X-MC-Unique: bQ7BH5iAMt-t1jPMKpSOvg-1
X-Mimecast-MFC-AGG-ID: bQ7BH5iAMt-t1jPMKpSOvg_1778694723
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D45319560A2; Wed, 13 May 2026 17:52:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 007AB19560A2; Wed, 13 May 2026 17:52:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD99421E6A08; Wed, 13 May 2026 19:51:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Peter Xu <peterx@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 5/6] MAINTAINERS: Update RDMA migration entry with M:
Date: Wed, 13 May 2026 19:51:56 +0200
Message-ID: <20260513175157.3765935-6-armbru@redhat.com>
In-Reply-To: <20260513175157.3765935-1-armbru@redhat.com>
References: <20260513175157.3765935-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

We wanted to remove RDMA migration once but that didn't go further.  In
reality, with the help of Zhijian it's in Odd Fixes stage, even if we just
merged one new parameter for it, for performance improvements.

Markus pointed out we'd better have at least one M: for it to match
anything that is not orphaned.

Remove the X: for Migration entry for RDMA files, then it'll start to cover
RDMA migration again. Keep the separate entry so Zhijian can keep getting
copied, and copy the M:s over to say someone is collecting patches.
Logically these M:s aren't needed after removing X:, but make it clearer.

Link: https://lore.kernel.org/r/5326b854-fcea-4af6-a479-792888a94a4d@fujitsu.com
Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20260511143026.1296485-1-peterx@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6748c03928..0d9c7146da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3769,11 +3769,11 @@ F: docs/devel/migration/
 F: qapi/migration.json
 F: tests/migration-stress/
 F: util/userfaultfd.c
-X: migration/rdma*
 
 RDMA Migration
+M: Peter Xu <peterx@redhat.com>
+M: Fabiano Rosas <farosas@suse.de>
 R: Li Zhijian <lizhijian@fujitsu.com>
-R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
 F: scripts/rdma-migration-helper.sh
-- 
2.54.0


