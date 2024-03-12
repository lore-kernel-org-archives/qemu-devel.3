Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C115C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAah-0006qZ-G7; Tue, 12 Mar 2024 18:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaP-0005Cr-2x
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaN-0004L9-Kr
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AurzQqFpLzlXuBxIL8RZRvJLoJVHujck2MunJ5OHm/A=;
 b=TkEGZAAC023Wk4Od/24M7nYvAE7e8Bt12uAHsKH6TxhZmMoKqBdvRe0n/Bcyfw7MoUHmav
 /2HAi73PPVLpL78hl/4NBdVbGBfLidJmVxzapMbUmeNFsBpO9T0peEBEszSd1exWjeMozk
 ZSEOczvxod9B8YGDzyI+MB4qHhElxdU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-iVtBERrFOf-8rWQyqUohXA-1; Tue, 12 Mar 2024 18:27:01 -0400
X-MC-Unique: iVtBERrFOf-8rWQyqUohXA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4651c22fd2so13431966b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282419; x=1710887219;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AurzQqFpLzlXuBxIL8RZRvJLoJVHujck2MunJ5OHm/A=;
 b=wmLqc7GSw0oX7T3boca5yBolys1qVN84wPq+SccF9RLOfinX50XJYIL6Xsb0r7jrL2
 Y76A/GgY/j02tH66Ol6isttPGEc1t2x7FkR+iXqSg7p8BRhO+vSCig+sYNCuh69ZmTkY
 8QoivkGcIMvbze6ynXt/edJqfG/u/7cZ1Ntm+RHIid9ZPy4HPp8sHTMxIn8n/g6vvXOT
 fgb2t+XicwkLtBTqZMnx8uiCeng+n/0qw4WoclXS1k84pk8EMYzHCyMqZ93wPwwVke8m
 1q+bcCqJ2U0Cpsn+yEGNZLWrQGb33ebS6T1GuEK1WWloQyEtfuPJ54E+I14AmKS69Xwn
 OT1Q==
X-Gm-Message-State: AOJu0Yz9GwDd3POXxpRpTiqur4wKnELcPkwZwHtIRlu7d7V50UKIKwZZ
 tKOwRc8kmlBKubvRzPKKS/WxFCDarV5PiNhJTzonDiuTWKYmVNc7WPMTpnBH0fl/PgEq4c9NXeY
 deTW4G1HKVGkLFvS1xIsBFE81A/BV9cvu8U1f/DgZggK70iMZ7jZwnhAEZH96HXR72lGD/HYUPk
 RC5U9/QHRwIMAcdDZX8wLORt6Wn9I4pJ+g
X-Received: by 2002:a17:906:3984:b0:a44:1f3:e474 with SMTP id
 h4-20020a170906398400b00a4401f3e474mr6422436eje.23.1710282419582; 
 Tue, 12 Mar 2024 15:26:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYD/1NG1Sa14VJz3wbarGz8hPiW7rFJxlXu8xjn1LlPtMm9umoofuX94IQIgERRJIL/ZRTIw==
X-Received: by 2002:a17:906:3984:b0:a44:1f3:e474 with SMTP id
 h4-20020a170906398400b00a4401f3e474mr6422425eje.23.1710282419137; 
 Tue, 12 Mar 2024 15:26:59 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 lt9-20020a170906fa8900b00a45c4d3ee11sm4224960ejb.123.2024.03.12.15.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:58 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 28/68] vdpa: trace skipped memory sections
Message-ID: <a8516e5c9719cf45fd81d6790bc9ffdcf753376b.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Eugenio Pérez <eperezma@redhat.com>

Sometimes, certain parts are not being skipped in
vhost_vdpa_listener_region_del, but they are skipped in
vhost_vdpa_listener_region_add, or vice versa.  The vhost-vdpa code
expects all parts to maintain their properties, so we're adding a trace
to help with debugging when any part is skipped.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20240215103616.330518-3-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 3 +++
 hw/virtio/trace-events | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 5559d4f89c..3bcd05cc22 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -55,6 +55,9 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
     bool is_ram_device = memory_region_is_ram_device(section->mr);
 
     if ((!is_ram && !is_iommu) || is_protected || is_ram_device) {
+        trace_vhost_vdpa_skipped_memory_section(is_ram, is_iommu, is_protected,
+                                                is_ram_device, iova_min,
+                                                iova_max, page_mask);
         return true;
     }
 
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 20577aa584..9df24864a2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -30,6 +30,7 @@ vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
 vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
+vhost_vdpa_skipped_memory_section(int is_ram, int is_iommu, int is_protected, int is_ram_device, uint64_t first, uint64_t last, int page_mask) "is_ram=%d, is_iommu=%d, is_protected=%d, is_ram_device=%d iova_min=0x%"PRIx64" iova_last=0x%"PRIx64" page_mask=0x%x"
 vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
 vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
 vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
-- 
MST


