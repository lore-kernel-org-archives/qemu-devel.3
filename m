Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A60AC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAdJ-0005ar-Vo; Tue, 12 Mar 2024 18:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAcI-0002ry-4a
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAc8-0004c7-F8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SkLCskZADtvicMPgS7N3Shz0FKc1G4wcmgr3/rSi1jg=;
 b=aJb7n1frFuC7gbxlWndEONrwaC7rAPJRrSOo1HPkuSTPXqTdEYI0vzlXD4NTAHr48k51G/
 06BUYh9rvCICJilWoQHqkhmeQqt+h7UXktgLntwSqmYd0fbzm+x2vyCkGk/ColzK0oXQt6
 vBFnC89ejBfzriMvEnGHr88/rujShBE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-RRueLvNdPhGBjT357YJz8g-1; Tue, 12 Mar 2024 18:28:50 -0400
X-MC-Unique: RRueLvNdPhGBjT357YJz8g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-568728e521bso1094767a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282529; x=1710887329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SkLCskZADtvicMPgS7N3Shz0FKc1G4wcmgr3/rSi1jg=;
 b=TOPU6zyM57/il/m8aK8pqPlj1s/t1qXUddUKQ7dFdbL5bCGObqMyroDYDqSHXyFoS7
 HWxduP+ofB11bRMHdCqw7cBuH0fgyP4BiYAgJPVUGfL92Ys0qy+XPPHT19uJcYTBHBkC
 xnBdPFKGNuDHiG1BfsKolfP4+5gg1KEwLj9j2PRGcUkErhkFfhW6ZowfK8V7+xeVUrjB
 eAVbR813bye7Xyycd+1F93tEumJiJ2+wzlD+yj4Su9dixlztiACK+kau2WeohQUp4gIH
 7zYycKgGfmfzgcfED0/9zchZ4OkmQLq0tfZSwQsVioHiun59gMtrpXfyEZIU18gV6lTU
 Wijw==
X-Gm-Message-State: AOJu0YwpxsCLQMZ2Xdq+jAnhbufLfpZBpDjTnzfXeDJ1VKkOVrD/Ww2a
 dmNu1vPkx56YknBMNx5/go9Hmk6OKGLcM/FUh6/IqiHNuhBtmCMq9pOY21EmLJBRcsVr0Q8jGGz
 pZgPFD/xJAmsJuIFxrJ/fCcNhkPEfmgkxELBW1BtQKBGJyWbHEgoLa8CfpMjPBeT1V4nVJrR35j
 FWlnJSHkv3H8dXPnjkkV9iwJeKuyLOCa73
X-Received: by 2002:a50:f696:0:b0:567:3bbd:cefb with SMTP id
 d22-20020a50f696000000b005673bbdcefbmr2561979edn.35.1710282528788; 
 Tue, 12 Mar 2024 15:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDO+cV22/TTgsh2a4S0j3ck470gwU1x6D2mZTQmKgd2I2B7B7BebfU5zaGEa6MERtj9rfCRQ==
X-Received: by 2002:a50:f696:0:b0:567:3bbd:cefb with SMTP id
 d22-20020a50f696000000b005673bbdcefbmr2561963edn.35.1710282528377; 
 Tue, 12 Mar 2024 15:28:48 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 v22-20020aa7d816000000b005687e041608sm440346edq.37.2024.03.12.15.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:28:48 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:28:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 60/68] virtio-iommu: Trace domain range limits as unsigned int
Message-ID: <fdda908f945bcd985be4ebd2a06d00719bc15e93.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Use %u format to trace domain_range limits.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240307134445.92296-6-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 9df24864a2..13b6991179 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -112,7 +112,7 @@ virtio_iommu_device_reset(void) "reset!"
 virtio_iommu_system_reset(void) "system reset!"
 virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
-virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_start, uint32_t domain_end, uint32_t probe_size, uint8_t bypass) "page_size_mask=0x%"PRIx64" input range start=0x%"PRIx64" input range end=0x%"PRIx64" domain range start=%d domain range end=%d probe_size=0x%x bypass=0x%x"
+virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_start, uint32_t domain_end, uint32_t probe_size, uint8_t bypass) "page_size_mask=0x%"PRIx64" input range start=0x%"PRIx64" input range end=0x%"PRIx64" domain range start=%u domain range end=%u probe_size=0x%x bypass=0x%x"
 virtio_iommu_set_config(uint8_t bypass) "bypass=0x%x"
 virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
 virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
-- 
MST


