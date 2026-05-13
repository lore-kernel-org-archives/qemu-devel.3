Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EDDCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDki-0005VC-2R; Wed, 13 May 2026 13:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDke-0005Sg-0Y
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wNDkc-0002nm-GD
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778694725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmSdUWIr+b6CJ5tj7/DVYCfqvPza/y+BUbY3Bmv7cAk=;
 b=Q7IDEeVApPxRF4enDRc/FavQF2yrhb2NQKqs8RcV1eC6VtH8d54Fh731JU0myFIAxZfWfh
 ous1eEbSA6L5EzXmEVJCWUJIOHxLnzy/Q2+EBzlbsR8KTjvdl4vNQNPnZbeZ8GqYnkF0jR
 +/XvEjpiJAr6O485CFN+3r+CzAnK26Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-rTTGXIS3NJSeH7OMWTSaXA-1; Wed,
 13 May 2026 13:52:01 -0400
X-MC-Unique: rTTGXIS3NJSeH7OMWTSaXA-1
X-Mimecast-MFC-AGG-ID: rTTGXIS3NJSeH7OMWTSaXA_1778694720
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71E501800451; Wed, 13 May 2026 17:52:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 101E11953947; Wed, 13 May 2026 17:52:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD6B121E6A02; Wed, 13 May 2026 19:51:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 1/6] MAINTAINERS: add self as reviewer for PowerNV and PPC TCG
Date: Wed, 13 May 2026 19:51:52 +0200
Message-ID: <20260513175157.3765935-2-armbru@redhat.com>
In-Reply-To: <20260513175157.3765935-1-armbru@redhat.com>
References: <20260513175157.3765935-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Also remove the redundant entry for pseries.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20260501144558.24491-1-harshpb@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a1e4e482..2a39a53067 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -327,6 +327,7 @@ PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
+R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
@@ -1634,7 +1635,6 @@ F: tests/functional/ppc/test_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
-R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/*/spapr*
@@ -1660,6 +1660,7 @@ PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
+R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: docs/system/ppc/powernv.rst
-- 
2.54.0


