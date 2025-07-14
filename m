Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E388C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKJ-0007Kc-9n; Mon, 14 Jul 2025 19:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIX-0003un-IJ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIV-0005rj-U1
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=abIfIiNx1s306ZzyGHCdWRc0FqHz4inGvPBZMZGML7I=;
 b=cGD6TNGvLjHx1umhj8rtphMG9YFxL1v4Gwq8vqV5mcZs2m8IpXLMaDhcHcS06hYni/DMHJ
 hfV6oDOuqL4jylZ62R1Fecnebg/irVtqseSu9MTFDG1rPIHep8qAfr53RIqeJnOtJGZLiF
 8GgGdXXyO7GB5Bg/b67SYPPgerur1lw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-pDe2bfncMXGAf1C4gtkZrQ-1; Mon, 14 Jul 2025 19:09:21 -0400
X-MC-Unique: pDe2bfncMXGAf1C4gtkZrQ-1
X-Mimecast-MFC-AGG-ID: pDe2bfncMXGAf1C4gtkZrQ_1752534560
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso30883115e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534559; x=1753139359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abIfIiNx1s306ZzyGHCdWRc0FqHz4inGvPBZMZGML7I=;
 b=X0jtWKSsv85pvwn6bID+kv7ZwzgOgPbMJ5G32cjBpisM+N93fTcpstTinDyJ283Ncl
 1/wL7WoxiEMxSV+TBNptlGaMNiqa51Xpq/dQ7byhGhV7urhQTOuJ2VjJOTXf8m2W0Q5G
 vspxqg4mIYhqEJR90913qNaD35BnVszWqDINUueUEMfQZ0HFP5OrJQGdB3xQqOap/ik0
 Xx+0/UOKTuCZsrFuexovWfDmDZrzfKOSrx/wGv1GiAyowOtGcjYXtp+L6IOZ70WbBh6U
 /C0+sEW9Uridqq4N11XgdzkGhQTsVX0b0G9qwEFr7DgFek5PT1Z+gobUth9hr59+00oW
 eqmg==
X-Gm-Message-State: AOJu0YxymPWVPkewPIKK2Jkx6PogDeU7jfgc3GIvm8YdI8Az1rEvw8Yp
 x/rI0ITajOu70R0stCm/PnVTyhVOKTgEIkRjjwhwT6KrqzaB/OceljiFZbwvZrRfQAP3NW9NUkX
 c/rlAaryh0k0l4jHcMyIpB7z5rLKSLJ62RrEyoT6NtWHQCwjhOS+7Zc3yYNqy9fTm578oTHll0U
 HDQiWGKO72MEDsJ8RZe3NOMJ+nQh9AyYqFAw==
X-Gm-Gg: ASbGncve2ppLZCW5XkDXVyEdbs69rUlNxa4oMm25/93rUlCSWtdwRps34RiQkY0HWqF
 IFDlb7+IcLbJ0f8jPPd4CJIma905CO8XRjVkQGmCaDv4bqKhGgu0UeWyVKdUxWe/9Ptc1T0sri8
 cJpK6NiIW+TLfbsU7li520lmttijwGdja0LYVp129Hen2dRuEVkBVfUu3QEyI2VlCpMspLsyAis
 AV2h3qYRrJUV1l4oIZJB5V8OMKfdPe36M6qTXshMzX5lFiYhEJo64O0AhBrPidt5YT7JlQnxCwJ
 W16QXZg9fzrYw64iNK8ieTLUTBCxfbdu
X-Received: by 2002:a05:600c:3d89:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-455f30bfc7dmr130563755e9.0.1752534559462; 
 Mon, 14 Jul 2025 16:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIFbkMAPSgyKo4pac+uDc6SV8ZtgSYpPq6yKxRgX1NUPh6ez12s8bhpaYBSJbKDWdgQG109g==
X-Received: by 2002:a05:600c:3d89:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-455f30bfc7dmr130563565e9.0.1752534559043; 
 Mon, 14 Jul 2025 16:09:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d719sm13690284f8f.54.2025.07.14.16.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:18 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 70/97] hw/acpi/ged: Add a bus link property
Message-ID: <4b37deb11bd7e03238ae0bfc1fd6abdea1eb9a18.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

This property will be set by the machine code on the object
creation. It will be used by acpi pcihp hotplug code.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-Id: <20250714080639.2525563-25-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/generic_event_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 7831db412b..ef1c1ec51f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/generic_event_device.h"
+#include "hw/pci/pci.h"
 #include "hw/irq.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
@@ -320,6 +321,8 @@ static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
     DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, AcpiGedState,
                      pcihp_state.use_acpi_hotplug_bridge, 0),
+    DEFINE_PROP_LINK("bus", AcpiGedState, pcihp_state.root,
+                     TYPE_PCI_BUS, PCIBus *),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
-- 
MST


