Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84E3606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HeeRKQ61;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=A8wiHs3W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Hp-0004yH-Tb; Wed, 28 Oct 2026 13:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GM-0000z4-Ms
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GI-0003ts-JL
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+GuvKRsV+a6+GbEa+CNhmAoLlvqUeipOH4q8uieDCU=;
 b=HeeRKQ61aZhh3/0x5/YZvm8dSkMnWRewhsyoPRcNcrsPCkBCjkAB2NaiK7g8XFG9ml3WeC
 dtb+xn/diXieSGfTuMZJkx5127CCse23r6igVQqEIqRWcJd8168ABT/mRyF7VSzmQRhbGK
 L3smRoni6ZfzyhoqRtfcXdkZK/O0aR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-xSmWH1zEP3iJrGMDM6YKRg-1; Wed, 28 Oct 2026 13:16:27 -0400
X-MC-Unique: xSmWH1zEP3iJrGMDM6YKRg-1
X-Mimecast-MFC-AGG-ID: xSmWH1zEP3iJrGMDM6YKRg_1793207786
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so1008692f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207786; x=1793812586; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l+GuvKRsV+a6+GbEa+CNhmAoLlvqUeipOH4q8uieDCU=;
 b=A8wiHs3W+xCnH6eT0BNtce1CM9UDc3uPluDglHfn39iebGUXoQvLH0vPflMlRj4XxD
 Zc7a63utiEohjxlSOjBn0TuLgz67Q58wjQ60ZZ3gwpmTPk1PeOXaZtj2Leg5dJgwjp+8
 sTK5EV2+mLBZO/Lsgobae2ZZ7s2Q/kG6K1oNucxy1POydSRrTRc+e6ZEafAJefmXa2JN
 wUsUdfT0STPgezlRG6l7m4zMVIlAfTddljnjgqpq16MjXiZKNwAELTBHykJ3yILPf9fN
 1oiuB0qjLWHmR65gZM62HNeymp4lj4mfK+H/7JjsajZKT6KqtfwCpygWsdwL958G6CUN
 41eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207786; x=1793812586;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l+GuvKRsV+a6+GbEa+CNhmAoLlvqUeipOH4q8uieDCU=;
 b=nk6+VNk4Im2IBTOxmzYkkAXml2aKlUDcdLvAT4DSGICygpgVaiI03zXdSRAKTgEhwf
 7xCbgLWRMNuxHchcw3hR8tjhqL4T9QTaHACr6lq+hbspGcNHBcxVaKDBXBknVjrdbANs
 G45ocTAVPvkth360OBM0qOnm88R2YEAAbeASqvMqMeCAzvJDCVa6Pjkf9/bLGNYI9nTN
 2cP/Hej2D9kdMxOAXTDUFeVS6W00SpUZoV9qYB9i+SjcdGlMwylcUVR1G7zCspAognU6
 M0fL82HU7B7df+2W6+CzFNo9QUekIU9G9WR/53Z4GS1S9/YEXpUnNPfElMzFpf0V4HvG
 W5Kg==
X-Gm-Message-State: AFq9FYJrvtHkrZ8ikCXG/+FjjGWwN/ZaHobC6pgDT4yxePL0o67Nt8By
 E4AK95q83Zb5jTY0qMLhkHyMVAsbwGyL3CeOoMqU4rYSaYeuDTaOJs7XxgpF30WFIfmVoD94Pp+
 GHdaIaExt+UzNZ6Bzpv9nCsnGlKCsNCaXbmg18TmCDIO0908CSl/kyAlmQydAJivYs4pKlhnt4i
 OBkfJUlg/9tqLPDE2jG/8+DeliEP6hhTzexQ==
X-Gm-Gg: AYBFou1RnCFiUypqk5khY7Xd20QItktG9AexWYWbGGF/fBByoSOtSXUC0/hnsxig1BL
 Paih+5qFqAsMMvDXBDvE1NEjR31zA9qP/WzUrw5URvPJL/2o2+4cvtYYNqSCIviU6iVulCcseZJ
 wT/IYMdiV46hP35AmMN+ctP11MeGAWQ3M6rO8b7Qcny2rWxQHILvGspzQKG1c3DYDL31Jke3XP7
 3QmRXZmBBMAoWu6CtUDltpzgkgI5aL3spQeMG4vsqG91Xrfqk48A7OwFnaGL3iwSwFE63ZrbCHa
 8ZSnQbK6Q150iDZQ/TxSvwX+jB8X8OioG+1XZoQ3o1Qg/YxDWwB1g5WgT+1MYPngQff+Y/62OIh
 WbF16Og6lelh14h54GqlCvX8PjE+l8vj739C10Xef
X-Received: by 2002:a5d:5f85:0:b0:48e:bf0:35c with SMTP id
 ffacd0b85a97d-48e5d2e749cmr8031927f8f.13.1793207785543; 
 Wed, 28 Oct 2026 10:16:25 -0700 (PDT)
X-Received: by 2002:a5d:5f85:0:b0:48e:bf0:35c with SMTP id
 ffacd0b85a97d-48e5d2e749cmr8031790f8f.13.1793207784676; 
 Wed, 28 Oct 2026 10:16:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb99esm28759276f8f.23.2026.10.28.10.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org
Subject: [PULL 55/78] hw/arm: remove pci-bridge/pci_expander_bridge.h from
 virt.c
Message-ID: <2011fb7a587da19e6e9f64e39ce0647698985f64.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

This include is redundant as the function is declares is not
referenced.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260928095646.3555447-2-berrange@redhat.com>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d56197dac..3ab3ad8c3b 100644
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
MST


