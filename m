Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948FACD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyQ3-0008CA-RH; Thu, 21 May 2026 04:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPI-0007de-Qt
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPyPG-0006uM-Hd
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTsbloqHV9au7M3c9LUFhWWyticJmjLEEGeelBkYWZQ=;
 b=E1km+ISytGJDX5Qb0TzMtsEX51U/Ddhb0Z55c66b5AEt0PCK5s3uBd2l/0wgmRnMQ5y1tc
 1PrOwToPVEvFKc0wx9O1zIXH5tWcIIi8lHAqoGg8kLKFYJOxBlCgCdPpo//OHOD/OhRTq7
 YsjPdHXKUfIzu2n+hveb5pdp3idsMj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-3RPWn5s1M56LHw7nIgApuQ-1; Thu,
 21 May 2026 04:05:21 -0400
X-MC-Unique: 3RPWn5s1M56LHw7nIgApuQ-1
X-Mimecast-MFC-AGG-ID: 3RPWn5s1M56LHw7nIgApuQ_1779350720
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 654CD19560AB; Thu, 21 May 2026 08:05:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 214201956053; Thu, 21 May 2026 08:05:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15E9521E6881; Thu, 21 May 2026 10:05:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 16/39] MAINTAINERS: Drop stale F: from "sPAPR (pseries)"
Date: Thu, 21 May 2026 10:04:48 +0200
Message-ID: <20260521080511.999266-17-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-1-armbru@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We neglected to update MAINTAINERS when we deleted
include/hw/ppc/pef.h.  Update it now.

Fixes: 00a238b1a8 (ppc/pef: switch to use confidential_guest_kvm_init/reset(), 2024-02-29)
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cefd2cbb..87450a84de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,7 +1634,6 @@ F: hw/*/xics*
 F: include/hw/*/xics*
 F: include/hw/ppc/fdt.h
 F: hw/ppc/fdt.c
-F: include/hw/ppc/pef.h
 F: hw/ppc/pef.c
 F: pc-bios/slof.bin
 F: docs/system/ppc/pseries.rst
-- 
2.54.0


