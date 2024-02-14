Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E50C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDEl-0004I9-Mb; Wed, 14 Feb 2024 06:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDET-000424-FX
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDEN-0007BF-T2
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V4zjwwSJtTmpywd9ngatCTbsjan0GSdeS1bW++CNE5c=;
 b=Ten86G9uQyJJWl+qSWsgZly9mUOSMTRpjaPw0uih5D7T6e2SPryK22VcClCGWzoJdWuS8O
 v4b4hv/Zu73riE2wiM9XfXgh3/QpOha+VQJg6r8TIZYER4u3DSoiZQ3wc9pUpRZarWLLFg
 MYBKbSYNAqdW7IHIAa8L4P+00hexrdU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-aMhTW5HAMz-c5XFm5mradA-1; Wed, 14 Feb 2024 06:15:09 -0500
X-MC-Unique: aMhTW5HAMz-c5XFm5mradA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2f71c9f5d2so388493466b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909307; x=1708514107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4zjwwSJtTmpywd9ngatCTbsjan0GSdeS1bW++CNE5c=;
 b=FQVVC873SrCNR+lVLyz4x381AiAbG/sByY2UbrdFFk8yiKy61WAtxOBREp7ALH7dsM
 loLRGg03gFXrEQCIdKBAItG9iMp28MC8zjG1P/69qWN41IpkEpXmIiUNgk53pT9FCDY9
 N+Y89QXykbmoOHCuHY41KRfhGLLjgZDa3oo5rwgDyCc65DSZreJVVzVvOxKULN19scio
 89b6DHs71Zb/Oqe9lN45jI6cwdB4i6P3tOXRjemIOXdeiJHPuPMiQgHCwS7ngGbElHRk
 qLJVNyGqwJWpwxNuNawgL1eoTev6StRthrabajNc3VaIcf/7j3PzM4L4ODhpU3uWJiCi
 Srxg==
X-Gm-Message-State: AOJu0YweGL5PRm6yH9kKpd563+VNOBS0Is9k/3ZTwEN20stWQrdibE/O
 aJVEH5o0FunCExETBzIILgQVP34dGX2+7TxkucuCrebw90y6/H6pgQI7zo17CwPSj2WHqSc6Jfn
 A1I5kR/hx8Twuv/NOTxasHjiPpDdedc/bMyoIAs4mpwWoTmhpy4IWB+m+gbL5ZukZaJxIaqXNeG
 ERAt13gig9orYOIUV5aOT2gX5q+39Saw==
X-Received: by 2002:a17:906:b7c4:b0:a3d:1df3:4a55 with SMTP id
 fy4-20020a170906b7c400b00a3d1df34a55mr1657573ejb.9.1707909307364; 
 Wed, 14 Feb 2024 03:15:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdajZjxZDO0KZl9LnRp/+jR0soc2A0a+dtsNhxSadlg4yfXqj9h4e62j+ydLWisJYUmQQ7Eg==
X-Received: by 2002:a17:906:b7c4:b0:a3d:1df3:4a55 with SMTP id
 fy4-20020a170906b7c400b00a3d1df34a55mr1657553ejb.9.1707909307029; 
 Wed, 14 Feb 2024 03:15:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUfGDiMmsd17kQpRV0SD6bRTu6Qn49KjQQNRIIcnAaRvVZI8OOw7RY911ySteoYLh8TNnIU3pE+l/UjUfvO/ieh8mFqMgVG6+ycH2R4Htyozt40OzcPCkW5GGLmPSTUAg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 s8-20020a1709066c8800b00a3be8b717dasm2199419ejr.58.2024.02.14.03.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:15:06 -0800 (PST)
Date: Wed, 14 Feb 2024 06:15:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 35/60] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Message-ID: <9a457383ce9d309d4679b079fafb51f0a2d949aa.1707909001.git.mst@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

s->iommu_pcibus_by_bus_num is a IOMMUPciBus pointer cache indexed
by bus number, bus number may not always be a fixed value,
i.e., guest reboot to different kernel which set bus number with
different algorithm.

This could lead to endpoint binding to wrong iommu MR in
virtio_iommu_get_endpoint(), then vfio device setup wrong
mapping from other device.

Remove the memset in virtio_iommu_device_realize() to avoid
redundancy with memset in system reset.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20240125073706.339369-2-zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 8a4bd933c6..86623d55a5 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1264,6 +1264,8 @@ static void virtio_iommu_system_reset(void *opaque)
 
     trace_virtio_iommu_system_reset();
 
+    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
+
     /*
      * config.bypass is sticky across device reset, but should be restored on
      * system reset
@@ -1302,8 +1304,6 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 
     virtio_init(vdev, VIRTIO_ID_IOMMU, sizeof(struct virtio_iommu_config));
 
-    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
-
     s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
                              virtio_iommu_handle_command);
     s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
-- 
MST


