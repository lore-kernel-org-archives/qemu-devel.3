Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A42C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDIh-0002sX-2F; Wed, 14 Feb 2024 06:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDIe-0002Pz-W9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:19:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDId-00085T-CK
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6LsM8D7u878nz29/5qgyEFYwVL8xOaz5pqW5FXboxXM=;
 b=Ktrqfe9qZZGdnLc7kgnSN1tnzRD25A38Ap0obYCrNAUAGv2wjJ5sF8FyHaFhYY7+ccr+qL
 yswwbtwC+Iybuzbmj8MWSp1ocNnANLDfRbDo0TVHmkY1Nshdh/LRsgiHPOcdtvJiF+QUXn
 yOpoeQTusaFvpqPAp0j91bKcGD4obf0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-CHzqgG5BM_yWN2RUguzeUA-1; Wed, 14 Feb 2024 06:19:32 -0500
X-MC-Unique: CHzqgG5BM_yWN2RUguzeUA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a27eddc1c27so115450866b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909268; x=1708514068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LsM8D7u878nz29/5qgyEFYwVL8xOaz5pqW5FXboxXM=;
 b=N1oMK2bA6io++JJ7nI7RPzkxFS4mYWfHHxzRYDMua7V4sFxIa+xkwQ/1SuT20uwVhz
 X4S9ev//dG4o2Dx6TKGyS9Tg8JQTAaH253QPLpkecuxYeatu+8VW+xXs9XueyTmlB2C2
 2JTymCaK/fa8rHOHufaRHLzGu9bfBrmNdyXZ18HrBKYqcYBa/q3wK9dy5Z0fiKxb1+QL
 PgnXhSxhPg5JS7UPxLhtRB8FM+PSVKh3FOP5PkHtazKtZH7J2tkW5B6fnvHyMASWrvUk
 d1T4wgpHRbW3RWlrHrBtnO15ldZbiKk20WrudcgJqSib9lR/h2TAFbYgSi53jGTt8GbC
 e6wQ==
X-Gm-Message-State: AOJu0Yw9ie260NojFyk4+1yoccSD9S7qcE0stmuXqYh3dVKaqZ57tBwe
 ZQIN6U3iS8Jwc7FYa3u3wEa8CMnUUFlBUSN/ffYOprPdHfCGh3b7e1zFctpelDMIjhpU8G/xBnE
 /rgGwNEV5RZfnDu0RXRk7gjyj+Z8E4/X8fZEVyvvR/oGL9bSl7omCdSnMqHotefjuoc7W/vPksc
 SFrKiiUGVsqqmDfDBUfhZkFyUVaTAZ2A==
X-Received: by 2002:a17:906:ae09:b0:a3b:7216:3091 with SMTP id
 le9-20020a170906ae0900b00a3b72163091mr1424060ejb.20.1707909267917; 
 Wed, 14 Feb 2024 03:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWzxIveWeX6h8076CJoQaqcXY6Vt6chTMkNlDW/mtgaWKVryZy/PnFAp7sNQVQZC1bJl8P9w==
X-Received: by 2002:a17:906:ae09:b0:a3b:7216:3091 with SMTP id
 le9-20020a170906ae0900b00a3b72163091mr1424040ejb.20.1707909267642; 
 Wed, 14 Feb 2024 03:14:27 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXtEz5+bFRwbiGs+0QLbtvQTBsbhklKzO1xNKGN7UMWJxnu5MP3hesH/CjRva1FiwCeHCk/T/W47DP8y0ZMZSvHAD+tBEccLEEZDF7wxQtzw6DLbP83zQ3CRq/XDQvP75eVYmJhWngdo/NOgJPxxxnmCQyukhpArgrWfGPUX9pVchX/qjKYpm1+TE5BFRRm9MS1I0QOacWTCy0wNVBCdLApdDXR
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 mm19-20020a1709077a9300b00a3d4d78a769sm404454ejc.1.2024.02.14.03.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:27 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 22/60] hw/block/fdc-isa: Move portio_list from FDCtrl to
 FDCtrlISABus
Message-ID: <271c5bb3780773008a936f424cccf181a11b592c.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

FDCtrl::portio_list isn't used inside FDCtrl context but only inside
FDCtrlISABus context, so move it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240114123911.4877-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/block/fdc-internal.h | 2 --
 hw/block/fdc-isa.c      | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/fdc-internal.h b/hw/block/fdc-internal.h
index 036392e9fc..fef2bfbbf5 100644
--- a/hw/block/fdc-internal.h
+++ b/hw/block/fdc-internal.h
@@ -26,7 +26,6 @@
 #define HW_BLOCK_FDC_INTERNAL_H
 
 #include "exec/memory.h"
-#include "exec/ioport.h"
 #include "hw/block/block.h"
 #include "hw/block/fdc.h"
 #include "qapi/qapi-types-block.h"
@@ -140,7 +139,6 @@ struct FDCtrl {
     /* Timers state */
     uint8_t timer0;
     uint8_t timer1;
-    PortioList portio_list;
 };
 
 extern const FDFormat fd_formats[];
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index ad0921c7d3..2d8a98ce7d 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -42,6 +42,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
+#include "exec/ioport.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -60,6 +61,7 @@ struct FDCtrlISABus {
     uint32_t irq;
     uint32_t dma;
     struct FDCtrl state;
+    PortioList portio_list;
     int32_t bootindexA;
     int32_t bootindexB;
 };
@@ -91,7 +93,7 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
     FDCtrl *fdctrl = &isa->state;
     Error *err = NULL;
 
-    isa_register_portio_list(isadev, &fdctrl->portio_list,
+    isa_register_portio_list(isadev, &isa->portio_list,
                              isa->iobase, fdc_portio_list, fdctrl,
                              "fdc");
 
-- 
MST


