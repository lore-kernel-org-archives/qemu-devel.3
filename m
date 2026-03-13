Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85789105F79C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10n2-00060D-MT; Fri, 13 Mar 2026 07:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w10n0-0005zA-86
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w10my-0003Tv-AC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773401683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzkTPyIQAi7PtJzWQxtpaE+Q38+4z2bwKzyAbvqnQuQ=;
 b=CsoTTSOz1SHTxR2e2WRU4o7U+h43/SD2aSLSx1MhjGGImAGBiJlwVHMN541JdK48z7p32n
 KrApYNwJqJ0s8CLnij1CsxsDdhttbceMk7tjSg1Yxn7QG862XPBWWoHg62GDGKUD0aezeq
 3XS964U6QkwJGiPzIsaGehJ91yWiQqY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-ykSsEvlaOVWK2AMIhX1BrQ-1; Fri,
 13 Mar 2026 07:34:40 -0400
X-MC-Unique: ykSsEvlaOVWK2AMIhX1BrQ-1
X-Mimecast-MFC-AGG-ID: ykSsEvlaOVWK2AMIhX1BrQ_1773401679
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 485A81800610; Fri, 13 Mar 2026 11:34:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.234])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA84819560B7; Fri, 13 Mar 2026 11:34:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
Subject: [PATCH 2/4] MAINTAINERS: Update the s390x maintainers
Date: Fri, 13 Mar 2026 12:34:20 +0100
Message-ID: <20260313113424.15583-3-thuth@redhat.com>
In-Reply-To: <20260313113424.15583-1-thuth@redhat.com>
References: <20260313113424.15583-1-thuth@redhat.com>
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49e9b7dccbb..9a859e4133a 100644
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


