Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57E9CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyPk-0007uK-Ez; Thu, 21 May 2026 04:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPG-0007cI-Ld
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPD-0006sc-Op
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCGrFwKum6nk1p9GTKJAmV29zH9HImugoZEty/Qxb8Q=;
 b=hul2xuEKx0gOU6zMIH6qLSio5oz94+8F1Xy2evCgN1Xj6yWFmktW7gQ8xbunTvqwC0KPnD
 x+xbKEu6OOJpMHufclcS5Li8FKuIvv+N40cd8i9Poxwe/8Wbn43e5sJPmMeq2hxTrLGKiv
 7fslnWLRrEt2j0knKR+NuK6Vdxml/7c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-XDMV3mVONQq4TtigOWKXCw-1; Thu,
 21 May 2026 04:05:19 -0400
X-MC-Unique: XDMV3mVONQq4TtigOWKXCw-1
X-Mimecast-MFC-AGG-ID: XDMV3mVONQq4TtigOWKXCw_1779350718
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9FFC18005BB; Thu, 21 May 2026 08:05:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97ECA1956053; Thu, 21 May 2026 08:05:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0998521E6A37; Thu, 21 May 2026 10:05:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH 13/39] MAINTAINERS: Fix F: in "Raspberry Pi"
Date: Thu, 21 May 2026 10:04:45 +0200
Message-ID: <20260521080511.999266-14-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-1-armbru@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Cover hw/arm/raspi4b.c.  Drop hw/arm/raspi_platform.h, it's in
include/hw/arm/, and covered there.

Fixes: 95a5db3ae5 (MAINTAINERS: Add entries for missing ARM boards, 2018-11-19)
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 839e5036f9..a346728415 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1015,8 +1015,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-F: hw/arm/raspi.c
-F: hw/arm/raspi_platform.h
+F: hw/arm/raspi*.c
 F: hw/*/bcm283*
 F: include/hw/arm/rasp*
 F: include/hw/*/bcm283*
-- 
2.54.0


