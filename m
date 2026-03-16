Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50F5F46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25Od-0006m2-BM; Mon, 16 Mar 2026 06:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25O0-0006Mu-Se
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25Nz-0003X6-Ey
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YETUMS9xKT6NMAQtYxP+YITSN4H4JAuNQYhT+rK6jCs=;
 b=Ux3QXMdDXYm7O+xiRCF6bsoicEtYyN6/IKmwBfG2Xi57XNHOVDITmXb4IPEXyy9CQpxFwl
 Mtr23s3QYziGTIhO+d1Jlda2JMlB/VHPy9l7WQya4NHm/QIuLxSbaGbz3QI12gjsRS80y9
 1GHnFaEkQSESfnPeeGKG0prT9HlzBuI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-9XNSrF0kPBWIliv0hmSa2w-1; Mon,
 16 Mar 2026 06:41:19 -0400
X-MC-Unique: 9XNSrF0kPBWIliv0hmSa2w-1
X-Mimecast-MFC-AGG-ID: 9XNSrF0kPBWIliv0hmSa2w_1773657678
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67BC1180047F; Mon, 16 Mar 2026 10:41:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1280319560AB; Mon, 16 Mar 2026 10:41:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PULL 11/14] MAINTAINERS: Update the s390x maintainers
Date: Mon, 16 Mar 2026 11:40:36 +0100
Message-ID: <20260316104039.195960-12-thuth@redhat.com>
In-Reply-To: <20260316104039.195960-1-thuth@redhat.com>
References: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

I'm going to move to another project next month, so I will not have
enough time to take care of s390x patches anymore. Fortunately,
Cornelia volunteered to take over the job of collecting s390x patches,
and Eric and Matthew offered help to back her up, so we can keep
the "S390 general architecture support" section in the "supported"
state. Thanks for your help, Cornelia, Eric and Matthew!

Message-ID: <20260313113424.15583-3-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27de876d040..4daa49cb912 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -102,7 +102,9 @@ T: git https://github.com/vivier/qemu.git trivial-patches
 Architecture support
 --------------------
 S390 general architecture support
-M: Thomas Huth <thuth@redhat.com>
+M: Cornelia Huck <cohuck@redhat.com>
+M: Eric Farman <farman@linux.ibm.com>
+M: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
 F: configs/devices/s390x-softmmu/default.mak
 F: configs/targets/s390x-softmmu.mak
@@ -1862,7 +1864,6 @@ T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 S390-ccw boot
-M: Thomas Huth <thuth@redhat.com>
 M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
 R: Christian Borntraeger <borntraeger@linux.ibm.com>
-- 
2.53.0


