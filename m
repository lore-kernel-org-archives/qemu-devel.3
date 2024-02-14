Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF22C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDFL-0005YI-Ob; Wed, 14 Feb 2024 06:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFF-0005Le-5x
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDFD-0007NM-Ea
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mVxvuEjSCC48+PeMNO+t/y9XPe1f/wxKbS6YfzXmdhM=;
 b=SwMW7SAgiPjNJUCCKZCUsFKdsOIFEt9dVb3QoknHTUAp1avUI1ps/crcP6JY/aj3ALlUgD
 bHrISJs8GsQWd6F95JrZv4n1mQ0VCjhzdyMIbsEKBhDrZIV8DZwc8FxXUpELrmVU22I1k4
 qv1MPwPWAPl1+RUi8beXHVXmBennr54=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-h1TZkV9JP5-N4nslXvJPQg-1; Wed, 14 Feb 2024 06:16:01 -0500
X-MC-Unique: h1TZkV9JP5-N4nslXvJPQg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a26f2da3c7bso283534666b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909359; x=1708514159;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVxvuEjSCC48+PeMNO+t/y9XPe1f/wxKbS6YfzXmdhM=;
 b=eEdY+SvCbXF1dVE8Oli7XbIUXYykXZUZV31PFSjIJucReDhs0IgDZEWO0vgJOpKiBI
 QQyGwQgDJ65blETL0HeOArf9fE1qy1fpAeyXnmNmFbdvFIs/6yaWpxjvXyB3DozeTahW
 ddlW3cylBBHaKIDbgFZ8kfvMP38LZAJadLD/+olDeuwT9kPpTjC0P0oKVX8p0fHpDzWB
 /RUcg0tMczzYZtctFrFLPKyhYFs9xbaL2KkfLo9yqRu80GJFtuNs20QoNKLXN5xNZMFy
 gex8IKu9YsSpn9gK1URNYey48yIICW1Wy8By2GXV/2YOwRENVIey60/yvPu1oZ4p39oS
 3S5g==
X-Gm-Message-State: AOJu0YxpI0Vc8TeNOBnwTJkmDtAX1H9RDDqf45sDVuQFh3G/eQsTkcRz
 p8yuixGeh4LSCFizM3vVk0bGqXfgDz/XVe6dRHf1M7QD3EQyuszmwjfLEIVzgWP0KGhBCP2iWCt
 YRR7vkHND+TRLl4mxRPuWG/cKZb88YCbeMEbkQKLQTC8gb8tHahUcbQXb1vHS1VRGaPZuNl7eKB
 QEIzuSLkHvsdreZDeweEgljhrxgcGodw==
X-Received: by 2002:a05:6402:74b:b0:561:f04:17c1 with SMTP id
 p11-20020a056402074b00b005610f0417c1mr1683759edy.28.1707909359205; 
 Wed, 14 Feb 2024 03:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEHkeiY4F+ZnhN03AxsvQX/3ukVFXdjjOeeqgCGlqQUPnrlNAgGdNVeEQvRhcmUhrC7Gnz+A==
X-Received: by 2002:a05:6402:74b:b0:561:f04:17c1 with SMTP id
 p11-20020a056402074b00b005610f0417c1mr1683723edy.28.1707909357987; 
 Wed, 14 Feb 2024 03:15:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWYerUJw18bp9ng4f9fk+kjEuxaWmcx7CaQRr+7IOZIufrDGsh94cVvBRS/ewL2vTYBjMxGiLNvJzR4TKjs002RQ9DLU2ADqoAf6sxSx9v9ArWRhImeuS8slRDDOPZRHw==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 h2-20020a0564020e8200b00560c6ff443esm4518808eda.66.2024.02.14.03.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:57 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 51/60] hw/cxl: Update RAS Capability Definitions for version 3.
Message-ID: <a185ff05fed2aa445f81d16a472e809d2cbea91b.1707909001.git.mst@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Part of bringing all of CXL emulation inline with CXL r3.1.
No functional changes.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240126121636.24611-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h | 5 ++++-
 hw/cxl/cxl-component-utils.c   | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 2c7631bd1e..b5da72b789 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -60,8 +60,9 @@ CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
  * implements. Some of these are specific to certain types of components, but
  * this implementation leaves enough space regardless.
  */
-/* 8.2.5.9 - CXL RAS Capability Structure */
 
+/* CXL r3.1 Section 8.2.4.17: CXL RAS Capability Structure */
+#define CXL_RAS_CAPABILITY_VERSION 3
 /* Give ample space for caps before this */
 #define CXL_RAS_REGISTERS_OFFSET 0x80
 #define CXL_RAS_REGISTERS_SIZE   0x58
@@ -95,6 +96,8 @@ REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
 REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
 REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
     FIELD(CXL_RAS_ERR_CAP_CTRL, FIRST_ERROR_POINTER, 0, 6)
+    FIELD(CXL_RAS_ERR_CAP_CTRL, MULTIPLE_HEADER_RECORDING_CAP, 9, 1)
+    FIELD(CXL_RAS_ERR_POISON_ENABLED, POISON_ENABLED, 13, 1)
 REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
 #define CXL_RAS_ERR_HEADER_NUM 32
 /* Offset 0x18 - 0x58 reserved for RAS logs */
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index a55cf5a036..848bfa20f1 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -325,7 +325,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
-    init_cap_reg(RAS, 2, 2);
+    init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
     ras_init_common(reg_state, write_msk);
 
     init_cap_reg(LINK, 4, 2);
-- 
MST


