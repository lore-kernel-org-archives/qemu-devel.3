Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547FCC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nNT-0008KF-34; Thu, 10 Sep 2026 18:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lPl-0004M3-94
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lPQ-0001Ss-1N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QDA3XcyEbs9mnsHi7voqYp+3OWZBRTr16GtYX9av+z8=;
 b=eIfhW9+GLRVqsO8sVb/zzP/6pyqHJTTAiONlAg3XxFCRz30n8TRvKVpIReUP2R3BRLKwAw
 y21vtvROSm1G1cyojIKvwrMQvZdkgnbmIyQ1jy6Dn/IBTpop+/nY/OxZuminTzYAv9VcUH
 Q6MXwSGbhim0t6uvMLqxobRvzCzSHlA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-wnu9MhCzMgW8G9Y3W-wwVQ-1; Thu, 10 Sep 2026 16:13:06 -0400
X-MC-Unique: wnu9MhCzMgW8G9Y3W-wwVQ-1
X-Mimecast-MFC-AGG-ID: wnu9MhCzMgW8G9Y3W-wwVQ_1789071185
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cd55ee2f7so1861305e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071185; x=1789675985; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QDA3XcyEbs9mnsHi7voqYp+3OWZBRTr16GtYX9av+z8=;
 b=nQno72uTLf9v6QuljDmHApTH7NhW0sco2idFTUlkc1aRxxoTb6ifPRQUfvL0tM2GUl
 Beqav+mun/+2xh/h664hYbfUEV6dbuQneVe4RjJTk/wfmjRs2SnY4V/noZ1RW4jmboo/
 F1tQqPXm4lJdfjHT3+mBMM2DqNyfHBhjdaB7nfiJABuvnn/KXb/Dnz5z0duhf7vhu5jO
 KBre6aYdy6bBB43SiXJ8YUlJFGjsvL8nmjGTmPPHH1aRM0bBYT4ADpnGwOyZbKwQcb9g
 Fm4OJ7O4+g4YPfdudMclEGBK/d4AvPIxb38VTP9jk7o87AR6o3fa6my+6TICTTByj8w0
 2a9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071185; x=1789675985;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QDA3XcyEbs9mnsHi7voqYp+3OWZBRTr16GtYX9av+z8=;
 b=FXDODqwhJWUMxXJRJlyOCGw5JZfOGQpWMFjXNuWxnoy7S2ap1OetVrpWx9cPrYYJJZ
 4llqykzWTGVADwIX6efEn22JbuibGwIz8RE7woMIsY5OMmiITf7xyspcJoMrHUZFep5P
 6/RBo+Mra46wfBYefo90uFcwo1DOnRpjbkDzNd9ludf4iaHcM++10DxTMJxTcKTETsQO
 RFB3nzeTjnz+BJEyJjFODloNLUMpGfOGVooLb2XegspTeBcjZMgTa034hBPNTFTKdKTZ
 bb8I6QH92ruxETlH+Dkn10Bo+yppJzTXaOjTPiPzxGOMqn0Gz7la1qzMtwTCpERz6nhi
 p5EA==
X-Gm-Message-State: AFuF++lqF6W0wBeZaATqZnli8cTJ89asBiYWXNpd2Z1KPl0jQv6GAkku
 PvFz0jC5DPk+RTY+YdxfPTkLnJ2qHj+X+QtMSUM1WdWQFuVDYfumx7vHfCV/ieXMOFSCT3p+AZp
 jJdtZD7NFDTqyt3cXnlZLpM22KF8E2S9QUn3CQijW2WkTGFZbsRIAN5mS+kIQbiccEHuq+as2WT
 rLyYl57DOhHAyo6rg0mZ7GnoHA1TzdCsde8w==
X-Gm-Gg: AYBFou25WTH6EsQWecymsdUJdJKI0d/Em4hHerw99IAv2nloKW3TpIh7BYa+M1PxLFU
 gH1CEPs7KgC/f00oX9rs2beWHBUBRH/Q8+ZDFH3cr8OD+zUrvipvvGZpOmf8vTzel0cBNlmT1ey
 kdx2k70MrD0pv7xrXOBJkkMEoO1ntT2AWSjBb+xicX/3GAFkNrxdeqPXPizr7h8+gHb5Kn8xIfP
 kgUI1cR4uaP68cQBSp3j35dDmbSJKjzqX/qy/77ti3k0AH+rxlIO7UZB5nMZXSyH8oWHctCO+n3
 RDaCOsksn5ny9qCriCxsznaWk2t3bo61uKaPe8E+f7WH42phzGA3Wv7LfccVRl74B/pGVE9i5Fc
 P7cwwi8lWG7uOLLiphCPmXs8=
X-Received: by 2002:a05:600c:3acb:b0:49c:fa21:1c8c with SMTP id
 5b1f17b1804b1-49e619e0e6amr6770965e9.33.1789071184697; 
 Thu, 10 Sep 2026 13:13:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3acb:b0:49c:fa21:1c8c with SMTP id
 5b1f17b1804b1-49e619e0e6amr6770635e9.33.1789071184201; 
 Thu, 10 Sep 2026 13:13:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm100907585e9.1.2026.09.10.13.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Matej Hrica <mhrica@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorinda Bassey <dbassey@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 38/90] vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT
 flags
Message-ID: <327c91ef1d0c82421da6ac4cdcef097b77b046e7.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Matej Hrica <mhrica@redhat.com>

Forward VIRTIO_GPU_F_RESOURCE_BLOB and VIRTIO_GPU_F_CONTEXT_INIT
received from a vhost backend to expose it to the guest.

Use vhost_dev_has_feature() to query the backend features, matching
the existing pattern for RESOURCE_UUID.

This allows the guest to negotiate blob resource support and context
initialization when the backend (e.g., vhost-device-gpu with Venus)
advertises these capabilities.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Matej Hrica <mhrica@redhat.com>
Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260717134920.265128-4-dbassey@redhat.com>
---
 hw/display/vhost-user-gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 80ab6b773e..a5b4df2c46 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -681,6 +681,12 @@ vhost_user_gpu_device_realize(DeviceState *qdev, Error **errp)
     if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_UUID)) {
         g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_RESOURCE_UUID_ENABLED;
     }
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_BLOB_ENABLED;
+    }
+    if (vhost_dev_has_feature(&g->vhost->dev, VIRTIO_GPU_F_CONTEXT_INIT)) {
+        g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
+    }
 
     if (!virtio_gpu_base_device_realize(qdev, NULL, NULL, errp)) {
         return;
-- 
MST


