Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06557D0E3E3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43IK-0008Kl-7E; Thu, 24 Oct 2024 15:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t43IG-0008JM-Hd
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t43IE-0003ui-SL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729797285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OhylvCJBiz975hLbNlhqRP1rEfoVuN3TxXdMlhtj4Q=;
 b=bKBTi1JTcYSDGLAV7cHneLGvIvGx03M7hJU7OCpbk8OHD4GvyC1BjdJPDEPirNWrkqG7ko
 OYEUeEdu5lrugvj6o5aAYM81Z333gq9UXakLAVbKrOPP+yUXcS7Cg1Uop5SHzO4ozL4VEl
 OrOlWIL3orFUvP/KQ8McFsDpIxfhwJk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-mDkBY_Z7NiGn3jmXCgaEpw-1; Thu,
 24 Oct 2024 15:14:41 -0400
X-MC-Unique: mDkBY_Z7NiGn3jmXCgaEpw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 422A2195608C; Thu, 24 Oct 2024 19:14:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.9])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85FDD196BB7D; Thu, 24 Oct 2024 19:14:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 1/2] MAINTAINERS: Remove myself from the PowerNV machines
Date: Thu, 24 Oct 2024 21:14:31 +0200
Message-ID: <20241024191432.1802089-2-clg@redhat.com>
In-Reply-To: <20241024191432.1802089-1-clg@redhat.com>
References: <20241024191432.1802089-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

It's been an amazing experience working on PowerNV systems all these
years. Now it's time for IBM to take the lead on the QEMU machine and
shape its future. I'm stepping back as the maintainer of PowerNV.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3bfa132fd6ecd61dd733b760a5e1ccd39613455..b157a5c17b98414e8fb179c918626d5da54e2f76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1488,7 +1488,6 @@ F: tests/functional/test_ppc64_hv.py
 F: tests/functional/test_ppc64_tuxrun.py
 
 PowerNV (Non-Virtualized)
-M: Cédric Le Goater <clg@kaod.org>
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Frédéric Barrat <fbarrat@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.47.0


