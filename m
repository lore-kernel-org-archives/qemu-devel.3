Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADA4F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25O2-0006N5-MY; Mon, 16 Mar 2026 06:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Ny-0006Ma-Qc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nw-0003Wu-S5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7vcNiUehlXz0koWQDsopaagBIqSBm2DJ4SLIuZUUYs=;
 b=U8MunKsGwPH6R37y9vbtYRx0OyCyksu5qNb+mKS49k1AxbRm4a5/GGRkWw2MdmhFAxgat7
 Oeb+LPlyU/XijZeR8LJwrxx+h5lXQ33eMK7BERNhhYyhPNiy2mNA1qbB02/KmChPvb4Abq
 dEa6hzded30Za3AJY0pIuNDboXODBDM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-6a8v96qFMyiN4cj2VRrx1A-1; Mon,
 16 Mar 2026 06:41:16 -0400
X-MC-Unique: 6a8v96qFMyiN4cj2VRrx1A-1
X-Mimecast-MFC-AGG-ID: 6a8v96qFMyiN4cj2VRrx1A_1773657675
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56E3F1955D86; Mon, 16 Mar 2026 10:41:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EC0419560AB; Mon, 16 Mar 2026 10:41:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 10/14] MAINTAINERS: Update S390-ccw boot maintainers/reviewers
Date: Mon, 16 Mar 2026 11:40:35 +0100
Message-ID: <20260316104039.195960-11-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Christian Borntraeger is no longer active in this space.  Promote myself to
maintainer and demote Christian to reviewer.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260310142118.1120291-1-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260313113424.15583-2-thuth@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 247799c817c..27de876d040 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1862,10 +1862,10 @@ T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 S390-ccw boot
-M: Christian Borntraeger <borntraeger@linux.ibm.com>
 M: Thomas Huth <thuth@redhat.com>
-R: Jared Rossi <jrossi@linux.ibm.com>
+M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
+R: Christian Borntraeger <borntraeger@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
-- 
2.53.0


