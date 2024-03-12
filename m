Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4121C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAZQ-0004Rh-11; Tue, 12 Mar 2024 18:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ9-0004Ox-KH
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAZ7-0004CY-1p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWHeCTwjwE1j/gB8xg8GGFC+NRd4QASP7jVSN89iyRY=;
 b=ezJYepoeUIhBNjRcvybbxlfeZJj1aW9+wEpvdwOoW9//G0SND8lIy8vTkl+6/+7D1H8Q1E
 TOKiSiWp7Z6SCquEzOzEFNd9KgCHPBAQJQfEYyxU6ml22rcfoxLcQcU5Lvc1y8i0xTurCd
 pAFeI8Z1JW/QMagIVFLgLL2pgFaWQ70=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-qmvZRCV-N5mpVwQA-Tj-Ag-1; Tue, 12 Mar 2024 18:25:41 -0400
X-MC-Unique: qmvZRCV-N5mpVwQA-Tj-Ag-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d449d2db37so16052141fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282339; x=1710887139;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oWHeCTwjwE1j/gB8xg8GGFC+NRd4QASP7jVSN89iyRY=;
 b=P9+OPPFglA/N/TrdaAV9GY32Tph7B+xrAQAugiQM3IQp1PJbFh17r6NCem+iokM9WE
 TbxSs+pTXZETfwP6JCv0MctXtSUAnaKzWKrt3rwKuG6gPD1agkS7FUGtUTzCShrwIypB
 O03mb96KMAx7PXkMC6im138Vf7FXMtIl89nn9LSK923cm6dMo+b/I9cuSX7y/gASS7F6
 z9hQBfM1E+OjdpRztnRDkB8353G/Ny1qomD3tnniP4e5QwZ+0lUwqomG2AM26hnjGdC7
 nDNvLEWeioX/tfw248wb9yYbHlPpI6wwn52pGd4Rbatjs4Tmb9f88hCaT7A9HG1W4eu0
 A/UQ==
X-Gm-Message-State: AOJu0YxqKroCiczm8nfOk0AgWEEH/CcfSrn+8tOrOXjQ7CX4w09Duzxl
 iHFllfxQxGY0M5DFonohi/w8t4+rKfYkAwBTQMPvdM0IMcwL0U1+Z97t6nuTGunpG4T6fPRIDW8
 31irNLsA//QBDuQMidiDwndHsRucQqWP13CuXGYGVIm+VVBwbp7BH/PBUKbwVPj54qQLA02Er3Z
 aZtqR9OgOvueHTshvyxx9dNXbJ9QTvP8gy
X-Received: by 2002:a05:651c:222c:b0:2d4:64fc:65bb with SMTP id
 y44-20020a05651c222c00b002d464fc65bbmr1673380ljq.48.1710282339312; 
 Tue, 12 Mar 2024 15:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnR0lKcptk0t7HrPsNHLjXPb0w+I5sMcXvf3J5hlqPyVi0JBLSHVVENXtLZlb25IjGtJ5HwQ==
X-Received: by 2002:a05:651c:222c:b0:2d4:64fc:65bb with SMTP id
 y44-20020a05651c222c00b002d464fc65bbmr1673363ljq.48.1710282338667; 
 Tue, 12 Mar 2024 15:25:38 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 e12-20020a056402104c00b005686037bc12sm2248238edu.29.2024.03.12.15.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:25:38 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:25:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/68] vdpa: factor out vhost_vdpa_last_dev
Message-ID: <c812b0655f8ccd1def48f14b89cec07e8fb68d83.1710282274.git.mst@redhat.com>
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

From: Si-Wei Liu <si-wei.liu@oracle.com>

Generalize duplicated condition check for the last vq of vdpa
device to a common function.

Message-Id: <1707910082-10243-4-git-send-email-si-wei.liu@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ddae494ca8..8bd62e8dd2 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -555,6 +555,11 @@ static bool vhost_vdpa_first_dev(struct vhost_dev *dev)
     return v->index == 0;
 }
 
+static bool vhost_vdpa_last_dev(struct vhost_dev *dev)
+{
+    return dev->vq_index + dev->nvqs == dev->vq_index_end;
+}
+
 static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
                                        uint64_t *features)
 {
@@ -1315,7 +1320,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
         vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
     }
 
-    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+    if (!vhost_vdpa_last_dev(dev)) {
         return 0;
     }
 
@@ -1337,7 +1342,7 @@ static void vhost_vdpa_reset_status(struct vhost_dev *dev)
 {
     struct vhost_vdpa *v = dev->opaque;
 
-    if (dev->vq_index + dev->nvqs != dev->vq_index_end) {
+    if (!vhost_vdpa_last_dev(dev)) {
         return;
     }
 
-- 
MST


