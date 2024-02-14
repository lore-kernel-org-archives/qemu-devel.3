Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84F0C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDq-0001S9-7q; Wed, 14 Feb 2024 06:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDo-0001CB-81
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDm-0006ry-Hu
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2FiAPUSNm6DWhdD5+bHFGCA/e/qpo+4q1OUy9Pvg0M=;
 b=g7cfhMni6oAIsl4sgok68dnByIIl4raLDiOqZLhBdQnANanvefnD7Iqf8/rEf3eb6fs4Tu
 lTywWm1FqYEHk9zyf1Ck5/VvW0Eh5OJzB2zzVuC/CBZysSwVWUGmMG8IAkGTjGChf6LJma
 M/NnahmAvTlNwQmXuzB/2OKwvV9NSLw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-g2g9orhQPMK0qgNDuo2NWg-1; Wed, 14 Feb 2024 06:14:32 -0500
X-MC-Unique: g2g9orhQPMK0qgNDuo2NWg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3d24680e06so62355066b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909271; x=1708514071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2FiAPUSNm6DWhdD5+bHFGCA/e/qpo+4q1OUy9Pvg0M=;
 b=HH7vCKtVZAU2e90XYX/tbYngw0F/jCHwsKv/KIHm/XD0imykj8A1gRxtVNuSvZoqAS
 rTy7v3eA845RoEBHoLdzhPplcqT1vhtX0ayG5rg6qG2up5HoPZmEUSPBn8jnOSGYyWcG
 g7ZiD3dTwe2b6i6/BKQNiay1fVRoA6BOjJuoS5LjOXV8CIbBR5AjVoX82ilK/qjRziEm
 4QJgbVTw16hyugAdCQEepnlNO9hDYeHLwWzmNtZ9iALlpM+G53gKFiEnWfmv4mUGS/vH
 JUtJu9m254BSRVIZR44Bj/GXm5YnoY4blEZB8eibHRCn3d9xp/piqcdUK1guKeuDF5nS
 Mpow==
X-Gm-Message-State: AOJu0YxL1SdblKK7KA6aiAh26nSZf2fWhbSjxCZdmyjzoXV2m/dUEgn0
 0eW7W2Y7QSEy+vRUx1LZelpoyF8v8ISmyiG3nMF0vbw0IpOu3v4pvvmebRyfzW8BD+y3RuAM8AC
 v0LjNG8+SjG+tBqBV3oueFd9oyvHhoQ7Zw27yrtLpSQ3BbrQsPH1UFAMkPWXROzxrmfHnFMchZt
 XSHSzqgwU7V+XvMZOSyByljBW9c3yq2Q==
X-Received: by 2002:a17:906:5a8a:b0:a3d:2222:bb81 with SMTP id
 l10-20020a1709065a8a00b00a3d2222bb81mr1603027ejq.10.1707909271097; 
 Wed, 14 Feb 2024 03:14:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElhCPqFZUH/6PTMwJj24ddmlHWdLqtHld0xgkHi/q5sMKHUSZ0Pp2cbtfRTQlKtKrH05WE/w==
X-Received: by 2002:a17:906:5a8a:b0:a3d:2222:bb81 with SMTP id
 l10-20020a1709065a8a00b00a3d2222bb81mr1603010ejq.10.1707909270816; 
 Wed, 14 Feb 2024 03:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUB2TSlLcRjQXkffGcmVQdPgRZRA31ZZlLw44cS6KcDIsuSl6XWK+R1bsAJoVbbsxolu7Hf9ILgWb2Ay9ajAaLnvJB6lhh7VarsXfGM3bAqXpYtUKZHos2PWZneTh0RJ6Z+Bxn2oef5ZAq94HJaEruoYkHntaSzGkyOhUIKnknfoAySrMLn6qCNA7dsmzeOVMKKqBjUkjGOfaH+Oal/OetaKmjP
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 gs20-20020a170906f19400b00a3d64b37a35sm90817ejb.137.2024.02.14.03.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:30 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 23/60] hw/block/fdc-sysbus: Move iomem from FDCtrl to
 FDCtrlSysBus
Message-ID: <ff453ce2819434d08fcaadca5d71b6e9a951ebdd.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

FDCtrl::iomem isn't used inside FDCtrl context but only inside FDCtrlSysBus
context, so move it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240114123911.4877-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/fdc-internal.h | 2 --
 hw/block/fdc-sysbus.c   | 6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index fef2bfbbf5..e219623dc7 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -25,7 +25,6 @@
 #ifndef HW_BLOCK_FDC_INTERNAL_H
 #define HW_BLOCK_FDC_INTERNAL_H
 
-#include "exec/memory.h"
 #include "hw/block/block.h"
 #include "hw/block/fdc.h"
 #include "qapi/qapi-types-block.h"
@@ -91,7 +90,6 @@ typedef struct FDrive {
 } FDrive;
 
 struct FDCtrl {
-    MemoryRegion iomem;
     qemu_irq irq;
     /* Controller state */
     QEMUTimer *result_timer;
diff --git a/hw/block/fdc-sysbus.c b/hw/block/fdc-sysbus.c
index 266bc4d145..035bc08975 100644
--- a/hw/block/fdc-sysbus.c
+++ b/hw/block/fdc-sysbus.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
+#include "exec/memory.h"
 #include "hw/sysbus.h"
 #include "hw/block/fdc.h"
 #include "migration/vmstate.h"
@@ -52,6 +53,7 @@ struct FDCtrlSysBus {
     /*< public >*/
 
     struct FDCtrl state;
+    MemoryRegion iomem;
 };
 
 static uint64_t fdctrl_read_mem(void *opaque, hwaddr reg, unsigned ize)
@@ -146,11 +148,11 @@ static void sysbus_fdc_common_instance_init(Object *obj)
 
     qdev_set_legacy_instance_id(dev, 0 /* io */, 2); /* FIXME */
 
-    memory_region_init_io(&fdctrl->iomem, obj,
+    memory_region_init_io(&sys->iomem, obj,
                           sbdc->use_strict_io ? &fdctrl_mem_strict_ops
                                               : &fdctrl_mem_ops,
                           fdctrl, "fdc", 0x08);
-    sysbus_init_mmio(sbd, &fdctrl->iomem);
+    sysbus_init_mmio(sbd, &sys->iomem);
 
     sysbus_init_irq(sbd, &fdctrl->irq);
     qdev_init_gpio_in(dev, fdctrl_handle_tc, 1);
-- 
MST


