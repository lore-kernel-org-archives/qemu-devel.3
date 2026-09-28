Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D56CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB86b-0000VG-4g; Mon, 28 Sep 2026 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB86Y-0000T4-Pt
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xB86X-00009L-86
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790589420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tVuCFNF/H30yzbtZqEPG9Njc0+ZOaYVy5PjtguTs70=;
 b=T8PCsyP6XBS0AgvOpxEUGaWOhk+2jhJn/SuABzRoXjz0Kvkc1XWwuIb8vtxSOjBzeX2dUw
 ghDjmZl3smxZ+tpFVtpOFCEWo6ZDr3nA/C+IRFTA+CJy2xzYuijV9WjRvs4lGiL2ZBdwI0
 ysrn/dOB373SolIhBTz9zwOBB5/BB3I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-pqnv6E6YONKDnLyjTcF4Xg-1; Mon,
 28 Sep 2026 05:56:56 -0400
X-MC-Unique: pqnv6E6YONKDnLyjTcF4Xg-1
X-Mimecast-MFC-AGG-ID: pqnv6E6YONKDnLyjTcF4Xg_1790589414
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8836419352EF; Mon, 28 Sep 2026 09:56:54 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECE681956089; Mon, 28 Sep 2026 09:56:51 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/2] hw/arm: remove pci-bridge/pci_expander_bridge.h from
 virt.c
Date: Mon, 28 Sep 2026 10:56:45 +0100
Message-ID: <20260928095646.3555447-2-berrange@redhat.com>
In-Reply-To: <20260928095646.3555447-1-berrange@redhat.com>
References: <20260928095646.3555447-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

This include is redundant as the function is declares is not
referenced.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3eecf094bcc..a570832fc0e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -58,7 +58,6 @@
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
-#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/core/platform-bus.h"
-- 
2.55.0


