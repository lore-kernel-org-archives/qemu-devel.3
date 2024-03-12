Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8131DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAaf-0006Sr-66; Tue, 12 Mar 2024 18:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaU-0005FT-01
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaP-0004LL-SF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fp9mS7QfM+i2wlqzdpjfyEOvEAobNn6YKxIWUVqj07Y=;
 b=f2nDNgNCLqkpLr1JCfwC/b3KEjUIu32fdTYNzLc6A1+pjylvinp6VmOckFOgAnFj3uopI1
 r2BuHlttTEiFZ3WjKAz3YrFgQHwEFL622tF80fXyE2TX2xUlSeJECcEUMstvu9CgmLuWk6
 DgZ9IgXCUQoXsbNOw7/BX/tDWtPj7Yk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-UX_qX2bnNyqpzBH8LA0_gA-1; Tue, 12 Mar 2024 18:27:04 -0400
X-MC-Unique: UX_qX2bnNyqpzBH8LA0_gA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4488afb812so23111366b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282423; x=1710887223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fp9mS7QfM+i2wlqzdpjfyEOvEAobNn6YKxIWUVqj07Y=;
 b=Kaj4R5oW0XZxVWsbnWKTdj6WJqcrvJLJrOEA/eeYkwmTf8R3vFJvVjEHT+hOyKBzLZ
 zVczOMRwTZiJDT1AMblJVzseniHo6V/brNEP6XjxumHN5zv2QHH8WOcGUH52zh/qW1UC
 Xs18PPr2lixW28zOK9Cmv3dOrsCWukF91gCa3jHaLH38SoO0qG/qbuDbSgImfIdYyXCq
 +oNP5sSqfrHjjMBuxtWyq9l0jgS+g1HECxsJCFhpqVn2Q5+2V39kwEXX9WOVSVp/d30m
 pXtqPZOfcmfZkr9im2kB1Y5Ey29BmKUu/X0dxPVZtALVzF3NOIHy6tNWZ389kwvcSltd
 +sAg==
X-Gm-Message-State: AOJu0YxQhX1sNFKOVB2Q+c0r8t7CmdjAyEi1Daza+gaVEM7FX2XAAq6V
 3OYpb8vLhDwfyMwKrpCcY5vqRPZmHm/oQPm8leHEIGCepCNMd8PAqNXUL0NLDGwJZWr1yFDbjzT
 G7bSjOmB02pV4JHe3JAoGZyriDb4d3jtPAr2UpP7ZqYg04Tx/FKRTCzpKrOiJ+ty3YE0zmHrF+G
 /Uj+KEpn+uasMO30EVlgOKDT6b/IQhjBmt
X-Received: by 2002:a17:906:6b97:b0:a46:5277:79b0 with SMTP id
 l23-20020a1709066b9700b00a46527779b0mr358970ejr.21.1710282422667; 
 Tue, 12 Mar 2024 15:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMxoGdSAd7PH+l40CgdNm6iIezqlbzyxoxMV/n5yoxszf5Y1pTfDtct88ikFByTxy+KBcZ1Q==
X-Received: by 2002:a17:906:6b97:b0:a46:5277:79b0 with SMTP id
 l23-20020a1709066b9700b00a46527779b0mr358954ejr.21.1710282422088; 
 Tue, 12 Mar 2024 15:27:02 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 o23-20020a1709062e9700b00a44cf710cc3sm4213832eji.182.2024.03.12.15.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:01 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 29/68] hw/pci-bridge/pxb-cxl: Drop RAS capability from host
 bridge.
Message-ID: <3a95f572112ab4c789d66af666644adcdb2b45a6.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

This CXL component isn't allowed to have a RAS capability.
Whilst this should be harmless as software is not expected to look
here, good to clean it up.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_component.h      |  1 +
 hw/cxl/cxl-component-utils.c        | 21 +++++++++++++++++----
 hw/pci-bridge/pci_expander_bridge.c |  2 +-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 0e5d35c263..5012fab6f7 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -25,6 +25,7 @@ enum reg_type {
     CXL2_TYPE3_DEVICE,
     CXL2_LOGICAL_DEVICE,
     CXL2_ROOT_PORT,
+    CXL2_RC,
     CXL2_UPSTREAM_PORT,
     CXL2_DOWNSTREAM_PORT,
     CXL3_SWITCH_MAILBOX_CCI,
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 84ab503325..cd116c0401 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -297,6 +297,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         caps = 3;
         break;
     case CXL2_ROOT_PORT:
+    case CXL2_RC:
         /* + Extended Security, + Snoop */
         caps = 5;
         break;
@@ -326,8 +327,19 @@ void cxl_component_register_init_common(uint32_t *reg_state,
                        CXL_##reg##_REGISTERS_OFFSET);                         \
     } while (0)
 
+    switch (type) {
+    case CXL2_DEVICE:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+    case CXL2_ROOT_PORT:
+    case CXL2_UPSTREAM_PORT:
+    case CXL2_DOWNSTREAM_PORT:
     init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
-    ras_init_common(reg_state, write_msk);
+        ras_init_common(reg_state, write_msk);
+        break;
+    default:
+        break;
+    }
 
     init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
 
@@ -335,9 +347,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
         return;
     }
 
-    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
-    hdm_init_common(reg_state, write_msk, type);
-
+    if (type != CXL2_ROOT_PORT) {
+        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
+        hdm_init_common(reg_state, write_msk, type);
+    }
     if (caps < 5) {
         return;
     }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 535889f7c2..0411ad31ea 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -290,7 +290,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
     uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
     int dsp_count = 0;
 
-    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
+    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
     /*
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
-- 
MST


