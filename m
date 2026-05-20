Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC52CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjgM-0006Sm-OV; Wed, 20 May 2026 12:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjgG-0006Jm-4k
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:22:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjgE-0000Dk-AN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdmJ5Ki2koJsf/Baeh9JW90e9+yppTSyY+hiY8+gc1g=;
 b=hcAT1AzPOSwag3YK4BZ6vQtEomQmUZ/A37BstfhhzRhmeyR7Gmv3ktL17cFgG661nibyej
 ssLdUpup8UyFlkMNLPH7ODGj0NXVT1yE7aO+yOmkIoCyAO+gvbnNue2l1zTe7lop4NbRKl
 oa/Iq786xietjSx3H+m77pHTINYE0Qs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-jBvdIf0iOOSRwcZhngJuow-1; Wed,
 20 May 2026 12:21:46 -0400
X-MC-Unique: jBvdIf0iOOSRwcZhngJuow-1
X-Mimecast-MFC-AGG-ID: jBvdIf0iOOSRwcZhngJuow_1779294105
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40D171800367; Wed, 20 May 2026 16:21:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3231B19560A2; Wed, 20 May 2026 16:21:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/11] scripts/update-linux-headers: Add typelimits.h
Date: Wed, 20 May 2026 18:21:15 +0200
Message-ID: <20260520162115.1613601-12-clg@redhat.com>
In-Reply-To: <20260520162115.1613601-1-clg@redhat.com>
References: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

Upstream Linux added include/uapi/linux/typelimits.h and includes it
from ethtool.h [1][2].

Teach update-linux-headers.sh to install that header into
standard-headers to be able to update kernel headers to versions that
include the above changes.

[1] ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
[2] a8a11e5237ae ("ethtool: uapi: Use UAPI definition of INT_MAX")

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260505081423.28326-2-avihaih@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 scripts/update-linux-headers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 0dea7c9551d2eb1e84aef90e82be92a872318706..3c3a0e9394d277766e613dd5ef4e9c7407ec0033 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -60,6 +60,7 @@ cp_portable() {
                                      -e 'drm.h' \
                                      -e 'limits' \
                                      -e 'linux/const' \
+                                     -e 'linux/typelimits' \
                                      -e 'linux/kernel' \
                                      -e 'linux/sysinfo' \
                                      -e 'asm/setup_data.h' \
@@ -251,6 +252,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
          "$hdrdir/include/linux/pci_regs.h" \
          "$hdrdir/include/linux/ethtool.h" \
          "$hdrdir/include/linux/const.h" \
+         "$hdrdir/include/linux/typelimits.h" \
          "$hdrdir/include/linux/kernel.h" \
          "$hdrdir/include/linux/kvm_para.h" \
          "$hdrdir/include/linux/vhost_types.h" \
-- 
2.54.0


