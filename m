Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8EEC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7sA-0006TE-LH; Wed, 15 Jan 2025 13:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qS-0007k2-CL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7qO-0006yc-Rp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yBogc88mZ2zmIgkbCaN8F6OobF+5g446az5uTIFHM24=;
 b=PS6FmKQO/U4R3oqVVSFVO0nwsTlQgU/Y1p9KvcpG/XqHXgKRDqwz1x0/+Rs3Ol+xbevs2I
 7Yl48zIZWOnF7haH/sOlbCcuuk1XULjw+jxm+Rtwoqdn/dG5Be8TtmDpKIsukd52Nqhl8C
 M/Ewz7rlxDyFpshfbCWs3BDe+fcv9/s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-NMB2QlM8OUqfBAIPKtMJNQ-1; Wed, 15 Jan 2025 13:10:17 -0500
X-MC-Unique: NMB2QlM8OUqfBAIPKtMJNQ-1
X-Mimecast-MFC-AGG-ID: NMB2QlM8OUqfBAIPKtMJNQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43582d49dacso47640205e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964615; x=1737569415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBogc88mZ2zmIgkbCaN8F6OobF+5g446az5uTIFHM24=;
 b=BEp0FMUg/qq8GqJCJeDv82aTXoyKZ4jdOqo4scSA0L5KOTnwWaGt27Cwe++6JCBb2t
 uudAu1yJXZUcJMZjQG1MTb5rfU+33JYMwQwvRSvmdBO5jQu3Nk9YUfnVwdCTJHjrAYkM
 KxM50XiuWU8CzHrEKoSBS59K8GC/IkrkXOYg935xKPQ7qv3sLj9dm2R9aFODuH/vwp68
 n+DzlqQOpIfD164PPF/Y1m/34+3XaxuzU2sK691f0LbIIh/jKvSXQPWDs3qPNySOqj+t
 4A46KlNutf/T70JO1xifrTZEfNw6kab+Lp3JCEzejAAUOLwgPP5dWQrOwCP5X5NK8Prd
 TAPg==
X-Gm-Message-State: AOJu0YzhJwQi0NqrGcj6+0marCEw/ZxQtw2DbVWqzQRvSvBw9KdtS7Dg
 RIUjHGf1GeQbfTLB10UGRGtjcr6z/TIhqH9WY12DERKoN5gXYgs55r7z60DKVd+UGAG42flkqzx
 QrBXFg7TqbuYxhggQK6xvRcOTOLbv8elRmccJp8YAHXvyz8DcTOs1iGiC6QsahWCsbVrJl530xJ
 7tA3T2X3eUl//b76dK63B73p2yz3GKiA==
X-Gm-Gg: ASbGncvrs/vVyp+asLTgP2i3gA6M97pGZWP7qijFUp5cybIvYSLjSkeXCcHX040tchh
 nbupU19S8iOVpGFxNsIsK7yvJmF2S22E44Cl9n2noridDZbnjxTSQThdUkoPX9eqF5VEw+XngDA
 N+q4Xy+ZGvdaByEXjnFkwZaDWaG/D1YPz5vTRsJEWHIRmEdZy9GHZJu571pe/+qaoU5Tyn+jEif
 48jUDQFV/b43ajSb2OOfpDTfCF/SLNw129ZDqGwL8IWYciX2ael
X-Received: by 2002:a05:600c:3152:b0:434:f9e1:5cf8 with SMTP id
 5b1f17b1804b1-436e271d3a2mr285758435e9.31.1736964615574; 
 Wed, 15 Jan 2025 10:10:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWm1BVn50OC0S8qoOqMg4lRNsnAniYWag6+4dOCwaTYJ+k0G60RC1MyLCEdpiw7oa4N0IikQ==
X-Received: by 2002:a05:600c:3152:b0:434:f9e1:5cf8 with SMTP id
 5b1f17b1804b1-436e271d3a2mr285758015e9.31.1736964615171; 
 Wed, 15 Jan 2025 10:10:15 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753cc1fsm32024325e9.39.2025.01.15.10.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:10:14 -0800 (PST)
Date: Wed, 15 Jan 2025 13:10:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL 33/48] acpi/ghes: Change the type for source_id
Message-ID: <26e0893e420b34677e6e904a06edf55331bd937c.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As described at: ACPI 6.5 spec at:
	18.3.2. ACPI Error Source

In particular at GHES/GHESv2 table:
	Table 18.10 Generic Hardware Error Source Structure

HEST source ID is actually a 16-bit value.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <0e83ba548c1aedd1299fe387b94db78986590a34.1736945236.git.mchehab+huawei@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ghes.h | 2 +-
 hw/acpi/ghes-stub.c    | 2 +-
 hw/acpi/ghes.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 50e3a25ea3..9295e46be2 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                      const char *oem_id, const char *oem_table_id);
 void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
                           GArray *hardware_errors);
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
 
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802..2b64cbd281 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/ghes.h"
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 {
     return -1;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5f67322bf0..edc74c38bf 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -383,7 +383,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     ags->present = true;
 }
 
-int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
+int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 {
     uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
     uint64_t start_addr;
-- 
MST


