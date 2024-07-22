Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD2C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkF-0004dU-1I; Sun, 21 Jul 2024 20:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkD-0004WT-1K
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkB-0005m9-5S
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzUslSpv+tevRPtwsSDiIptOoVAEmUbWgTJDTpf/8Eg=;
 b=WSA52J5cl4c3SEVM1GYjObqHkJSnaws7sIWBLUDU6Bn4VrGvCqcsp7eBmV0zFqgl9np93x
 Scj2pOrPvFmIFwzfTud0U5R8TCjA45VdFxQkHr6bTZVIEzBMk6IgyV+ByP67inmf6hwMJI
 2ei94va1XsLnGL/5RJGCOgSNx+qUfUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-8w3H2CeZPC-5ZQ1Yoc1QFg-1; Sun, 21 Jul 2024 20:17:31 -0400
X-MC-Unique: 8w3H2CeZPC-5ZQ1Yoc1QFg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4279418eb2bso25990315e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607449; x=1722212249;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzUslSpv+tevRPtwsSDiIptOoVAEmUbWgTJDTpf/8Eg=;
 b=MAytey9XOvNl9KWrNcJEUswPCy0+MtlBF4s9g1FV9iih/5oTGC1cjnIYWpiphWJ+Ah
 yA38wwP059N7yxeE3WFLs2clB4gRLzDegNsH4Z8xWTGFd7y8jdBijwdkjxx4KT05Gg3D
 FBAcuIIBysyaYJLQLsU6HJezDtuF2fPmb17EMXmfDXFX3K6yazO4U5/Fm4TPh59duHOh
 4SU5WEOMzVjfztZOGxZoSF2VvfEJYY+khiC/wREBSWkFF2COZmxlLLTADUoalexwQ7Dz
 2gwJZyDFDjfXvntbjB5qDQuXQMWx5bF1vGqFAebN5oCGU1tCB6X3xILwxDVk2cF/brH/
 rByQ==
X-Gm-Message-State: AOJu0YwyKydOKVDlP2BgjOSrJMnrA+++Dln6r66HC3Rr29E1g+wpcubN
 KUr0H7aWYfhSjdEpUkVHXOmXiUeasxKOMkw3z8H4ulw2oRhbjyngHzVQK9rnmOH3u5RBpvxEhOg
 qqRw5RMcQ9IEcP4wcdev5S33Ib29fvOxly0It7bCWPpTmWgwl5oEllndS5RAzojAiOkrfOh2eBk
 2g2bsvH4C6u4Wbm0QTY4Mx4/x4VlJ8+w==
X-Received: by 2002:a05:600c:4f45:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-427dc529c91mr30252355e9.17.1721607449479; 
 Sun, 21 Jul 2024 17:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErTcgERCTX1yip86aFVsMTM9zQ1FTRH83ANvbTXnBpQ2vdFULKucimSOqrY6Rvez7ku0S6sw==
X-Received: by 2002:a05:600c:4f45:b0:426:6f0e:a60 with SMTP id
 5b1f17b1804b1-427dc529c91mr30252185e9.17.1721607448879; 
 Sun, 21 Jul 2024 17:17:28 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6901781sm105984705e9.14.2024.07.21.17.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:28 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Minwoo Im <minwoo.im@samsung.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 18/63] intel_iommu: fix FRCD construction macro
Message-ID: <a3c8d7e38550c3d5a46e6fa94ffadfa625a4861d.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

The constant must be unsigned, otherwise the two's complement
overrides the other fields when a PASID is present.

Fixes: 1b2b12376c8a ("intel-iommu: PASID support")
Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Message-Id: <20240709142557.317271-2-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f8cf99bddf..cbc4030031 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -267,7 +267,7 @@
 /* For the low 64-bit of 128-bit */
 #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
 #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
-#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
+#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
 #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
 
 /* DMA Remapping Fault Conditions */
-- 
MST


