Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75E3CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfHt-0003pu-EA; Wed, 03 Jun 2026 02:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHa-0003Rd-GT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHU-0000rV-8b
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780468847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VF2wJBlZ5LtcB4s/LmhgHk/9BRVRRXfG0d0sesttKtE=;
 b=aIvT+/aGWN4v4/fFL/PYop6Dg//ZDu6Mzr47WcCGASvTPVKC2FWH/x+TPt0TQi8CBc2s26
 mVL1bFSbNZfYR+bzGTxvFmp40MmlZA617/wmu7dOhwIwfW1zu3FDtodAE9bdvojgYnPiJX
 IoVNdO1vN5N3xIK3JEMv+3hQn7RjOhw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-yb8yzL27PImQMYbyR0VF9A-1; Wed,
 03 Jun 2026 02:40:42 -0400
X-MC-Unique: yb8yzL27PImQMYbyR0VF9A-1
X-Mimecast-MFC-AGG-ID: yb8yzL27PImQMYbyR0VF9A_1780468841
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E90195608B; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6162D1800348; Wed,  3 Jun 2026 06:40:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8D8421E64A0; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 29/38] MAINTAINERS: Fix F: in "QDev"
Date: Wed,  3 Jun 2026 08:40:23 +0200
Message-ID: <20260603064032.3733394-30-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We neglected to update MAINTAINERS when we moved qdev headers from
include/hw/ to include/hw/core/.  Update it now.

Fixes: 3775d19906 (include: move hw/qdev-clock.h to hw/core/, 2025-11-27)
Fixes: d1000ecae2 (include: move hw/qdev-core.h to hw/core/, rename, 2025-11-27)
Fixes: f7889f86bd (include: move hw/qdev-dma.h to hw/core/, 2025-11-27)
Fixes: 78d45220b4 (include: move hw/qdev-properties.h to hw/core/, 2025-11-27)
Fixes: e1e9a72500 (include: move hw/qdev-properties-system.h to hw/core/, 2025-11-27)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d7f7196bc..d87426c255 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3571,7 +3571,7 @@ F: docs/qdev-device-use.txt
 F: hw/core/qdev*
 F: hw/core/bus.c
 F: hw/core/sysbus.c
-F: include/hw/qdev*
+F: include/hw/core/qdev*
 F: include/monitor/qdev.h
 F: qapi/qdev.json
 F: system/qdev-monitor.c
-- 
2.54.0


