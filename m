Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4EAC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS4z-0008Ae-B5; Fri, 21 Feb 2025 07:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4k-0007PL-GA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS4h-0007Ac-1a
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxfWHzt9iN+96ZxAmV4fASWczS4ot0QMavailc7mYDI=;
 b=DJgxk7Bohn9m7qvVVDwvRSuS1ZwSQRGDaiXcB5uQPGvdYRTZFWkkm8mf1bW12N9aN1LHcF
 3h7W0y6M49zBcJ0mm8oHLn90dxhxjdz+NXgxqbi4qsADzkVbXXaWU/GYhX40icGabwswym
 ixc/Xs2E9+VxFZ6fF0ohWB85cIsZ0mk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-MJjZAXcVNqK-qcN41WAz9w-1; Fri, 21 Feb 2025 07:24:08 -0500
X-MC-Unique: MJjZAXcVNqK-qcN41WAz9w-1
X-Mimecast-MFC-AGG-ID: MJjZAXcVNqK-qcN41WAz9w_1740140647
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso18741485e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140647; x=1740745447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxfWHzt9iN+96ZxAmV4fASWczS4ot0QMavailc7mYDI=;
 b=cltvu6UTGQflsOQh0bVhMCq9UOv5BIUTidmUoZjv3WyEd3Cgh3sJpBnje9vdOTB1lT
 GywPCn72XlO032takYvzrFyeN7os7EQpTou+LhrY2QNUUORL8yw9ImtFnLjtk1S+yJr6
 WQapSE4+0rzessnAkVune4ESoqu+TLA5ntrZFo/wE7PO5+tC1W+4oRtXj3aN/FGJJMI/
 i2ezG50ObICwksc24/NBnjgiOa9hYC6SSIyh1E3l6/tAbXn4/BX8qYhp1e9S/KRRNtzq
 MWhCYcr1oUD01BtJJe0f78KH/RIL704p9Lw5dQlNksJy6Dg1qaKD7J/6CN84aiCdxIHT
 wdJA==
X-Gm-Message-State: AOJu0YwEFnxQ6uxa5MXuKBZH0d0No8gfJvCQVhXU9OG4I6mSxNjWxzae
 8ggGaM4/7iUT6FXwX6DHG19Gko6HKYlbmn+1Gy0qGd3GDC9IUU+NEwrY9P4MBTE8dLfa3r0gC8X
 0zxtcTLC8sWYLe6r5a9LeELj9WOd5KaaHjxfw09Kf4SMFxyFSFST8ntaFJZh+6kb/qbZcTTl+0o
 eZWc++aOyJX1OPtJmfWoKGTle5iRRrdw==
X-Gm-Gg: ASbGncsLxeiywvQNETO9jbEFlgJuSRXaRuZSfKQPcV2CQBqkRzwPWwyutBRGIKDl/UT
 LLa538taNATk58T00cqpg1NGw0MCnf6Ul6SnKMVjHDYBzsMVtQp6+wl1aoIsFkg5QZaby1w1LM6
 YMlgcJSQ0rjs+ivZ80+M3RZFWLjv5dI3uXJFJwM+/gmi/rYjcYjm7V29+DEhcmA/KQFLrol+hBu
 Yk3KO33mM4J7MVxgZXXGTLTu+jWKHfxCm9urQRJz1JDwoe+1xX+IBFxTAdbB/FqKv9B4xgCUdhj
 bxbKoQ==
X-Received: by 2002:a05:600c:45ca:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-439ae21e36emr23933785e9.25.1740140646900; 
 Fri, 21 Feb 2025 04:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE++L12GzMimgissjFPBxz51sTR1njhnN+DcWPxHFC8BjJANAvKPaefWVIjCiSosjXHz8lRHg==
X-Received: by 2002:a05:600c:45ca:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-439ae21e36emr23933245e9.25.1740140646422; 
 Fri, 21 Feb 2025 04:24:06 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm15860915e9.3.2025.02.21.04.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:24:05 -0800 (PST)
Date: Fri, 21 Feb 2025 07:24:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 27/41] amd_iommu: Use correct bitmask to set capability BAR
Message-ID: <3684717b7407cc395dc9bf522e193dbc85293dee.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

AMD IOMMU provides the base address of control registers through
IVRS table and PCI capability. Since this base address is of 64 bit,
use 32 bits mask (instead of 16 bits) to set BAR low and high.

Fixes: d29a09ca68 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250207045354.27329-3-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 2 +-
 hw/i386/amd_iommu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e0dac4d9a9..28125130c6 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -187,7 +187,7 @@
         AMDVI_CAPAB_FLAG_HTTUNNEL |  AMDVI_CAPAB_EFR_SUP)
 
 /* AMDVI default address */
-#define AMDVI_BASE_ADDR 0xfed80000
+#define AMDVI_BASE_ADDR 0xfed80000ULL
 
 /* page management constants */
 #define AMDVI_PAGE_SHIFT 12
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 98f1209a38..044fe43256 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1593,9 +1593,9 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
     /* reset AMDVI specific capabilities, all r/o */
     pci_set_long(pdev->config + s->capab_offset, AMDVI_CAPAB_FEATURES);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_LOW,
-                 AMDVI_BASE_ADDR & ~(0xffff0000));
+                 AMDVI_BASE_ADDR & MAKE_64BIT_MASK(14, 18));
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_BAR_HIGH,
-                (AMDVI_BASE_ADDR & ~(0xffff)) >> 16);
+                AMDVI_BASE_ADDR >> 32);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_RANGE,
                  0xff000000);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
-- 
MST


