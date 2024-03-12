Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E529BC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAaa-0005hc-MF; Tue, 12 Mar 2024 18:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaM-0005CY-C8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAaK-0004Ks-SW
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wh6YuVoxx+DYLxPaX83mzfkVZkTHaR33Y90YpXonUkk=;
 b=Kfk0QgKzsJS4GswQ0AxDnSjUz2tVEkbpNVmeBmocB41Giq0Hk6xhHZwE2Q0fy7YVs6T7Aa
 9p74TjHQOifjYWhNTK3/UK6uioFoxvimcs/WG8/VTfsGYZsmX2bwwBzxC7SvVA/0yFHu4M
 t3Ru6fgCJTePpA9mUsv2/J8M+fLBw8Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-Lho1bPFlNP6Pm3q_YxlnUA-1; Tue, 12 Mar 2024 18:26:59 -0400
X-MC-Unique: Lho1bPFlNP6Pm3q_YxlnUA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a44143c8908so27848466b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282417; x=1710887217;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wh6YuVoxx+DYLxPaX83mzfkVZkTHaR33Y90YpXonUkk=;
 b=ZvwlLb40IaDsJzi1FXvl6iWtisDtcv3wuzTQbXfhwIZsImsv57HzW2Qx1foUhZh/dd
 6eXayy4qu6o5Oin6E58WTSWp12eCtfhrYZ7HdaN8iK+NOgnQaZTuq26fBPg3WF72a9v9
 V/z6BF2+9txan/zXL9j66LDepMvBR6mUCGGimeU2FR2h8u/iuRQv9iB0AY6qu/GbMTB9
 RNZK/W98WMU5Di/QoGrmmrITtll8Fj6xLmCp2gBLj4X+jLCHS3m/9hBlUlVkNIlsWTKk
 85BlWHx+9lEvduEijMfYx10SyyhdcU9Kw4idCI4XRNP0H7/DTAr3zg7maT+wWu617yTb
 qAew==
X-Gm-Message-State: AOJu0YwSq9O93I4viCONsQSFO5vYmvCwamNl03a6JXYD8ly3prkSlRS5
 GCoPhojtblEF+YxuZvz0fbLV33L8t2p5+bOp6v8bfZ28vLqJVrPIDHfvodkR3YveIkSqWyS3GRf
 GfQTGw7fm0TfdgV9lTtFVi5WiAc0lumu8jk2PvaNZRdcSUBPGSVL4O5llLq7/2fFJxUJXZxYp5g
 UfouKa/CPxn7DyomPsUApLM+cHDftymIP2
X-Received: by 2002:a17:906:3511:b0:a46:371b:c4d5 with SMTP id
 r17-20020a170906351100b00a46371bc4d5mr815102eja.22.1710282417132; 
 Tue, 12 Mar 2024 15:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBwZQhv8wXOSlf5kWVr6MCyK/Jh40PObLKzbVq92mpJ+119Eo9rJiLpnqS4I8QG/+u+duFAw==
X-Received: by 2002:a17:906:3511:b0:a46:371b:c4d5 with SMTP id
 r17-20020a170906351100b00a46371bc4d5mr815084eja.22.1710282416607; 
 Tue, 12 Mar 2024 15:26:56 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 bx4-20020a170906a1c400b00a4528658771sm4212653ejb.31.2024.03.12.15.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:26:56 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:26:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 27/68] vdpa: stash memory region properties in vars
Message-ID: <a55834579aa65f27519f948275d5efd9e2173bef.1710282274.git.mst@redhat.com>
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

Next changes uses this variables, so avoid call repeatedly to memory
region functions. No functional change intended.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20240215103616.330518-2-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index c968278e70..5559d4f89c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -47,12 +47,14 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
                                                 int page_mask)
 {
     Int128 llend;
+    bool is_ram = memory_region_is_ram(section->mr);
+    bool is_iommu = memory_region_is_iommu(section->mr);
+    bool is_protected = memory_region_is_protected(section->mr);
 
-    if ((!memory_region_is_ram(section->mr) &&
-         !memory_region_is_iommu(section->mr)) ||
-        memory_region_is_protected(section->mr) ||
-        /* vhost-vDPA doesn't allow MMIO to be mapped  */
-        memory_region_is_ram_device(section->mr)) {
+    /* vhost-vDPA doesn't allow MMIO to be mapped  */
+    bool is_ram_device = memory_region_is_ram_device(section->mr);
+
+    if ((!is_ram && !is_iommu) || is_protected || is_ram_device) {
         return true;
     }
 
@@ -69,7 +71,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
      * size that maps to the kernel
      */
 
-    if (!memory_region_is_iommu(section->mr)) {
+    if (!is_iommu) {
         llend = vhost_vdpa_section_end(section, page_mask);
         if (int128_gt(llend, int128_make64(iova_max))) {
             error_report("RAM section out of device range (max=0x%" PRIx64
-- 
MST


