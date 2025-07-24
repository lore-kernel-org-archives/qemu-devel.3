Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EE3C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uew3T-0001qv-FV; Thu, 24 Jul 2025 09:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uew3L-0001lJ-2m
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:32:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uew3G-0003Rc-Mh
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753363911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+8r+qI72qB+N1o8eOKNznCrtZkbV1fpwjhvvtoVASo=;
 b=TkwnDZoVA9yA5aD/VHMxUSNQXqjyyO4NgIYxo+eiY6wj0sdDnDFi4aTtzPYom6QGFiUbEY
 hARZmuQbmY6aLxYyyltX+ktsX+MUL+wOFglLaOLlLBw5Wa3K1Hzgm3Io3MgiPOMt9Y4HyB
 QKt8zshnTnfi8e3DV8iMgGKg9zKUwzM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-fE7iosEjMDWcwR_Qxic-_w-1; Thu,
 24 Jul 2025 09:31:49 -0400
X-MC-Unique: fE7iosEjMDWcwR_Qxic-_w-1
X-Mimecast-MFC-AGG-ID: fE7iosEjMDWcwR_Qxic-_w_1753363908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1A1119560AA; Thu, 24 Jul 2025 13:31:48 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22F571800D82; Thu, 24 Jul 2025 13:31:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 7/7] MAINTAINERS: remove myself as ppc maintainer/reviewer
Date: Thu, 24 Jul 2025 15:31:26 +0200
Message-ID: <20250724133126.1695824-8-clg@redhat.com>
In-Reply-To: <20250724133126.1695824-1-clg@redhat.com>
References: <20250724133126.1695824-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

From: Daniel Henrique Barboza <danielhb413@gmail.com>

It has been awhile since I actively did anything for qemu-ppc aside from
reading the qemu-ppc inbox a couple of times each month. It's not enough
to justify a reviewer role, let alone being a maintainer.

Given that we're doing qemu-ppc maintainership changes across the board
I'll take the opportunity and remove myself from the premises too. Feel
free to reach out with questions about code I did in the past, but at
this moment I'm no longer able to keep up with qemu-ppc activities.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250724123416.3115941-1-danielhb413@gmail.com
[ clg: Adjusted context ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9481a21c8018..f1bd69c3db72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -295,7 +295,6 @@ F: tests/tcg/openrisc/
 
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
-M: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Chinmay Rath <rathc@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -453,7 +452,6 @@ F: target/mips/system/
 
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
@@ -1553,7 +1551,6 @@ F: tests/functional/test_ppc_40p.py
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
-R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
-- 
2.50.1


