Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AFBC31D97
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjt1-0001SW-KO; Tue, 02 Jul 2024 16:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjt0-0001NQ-4x
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjsy-0007SO-FC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=P+05cnoGSNSTARSPjMMHmXrOg/d0JMLS+qIL3VzR1lqI+qznoDUlryW5+PbgTfTxqXrNXr
 eewzxkMA9xX9C+3+TRhanrbOcNulUJE7iNYlHaj7wb9twMOBgj+HFW3WAhivrCvZufxX+O
 8D/f9WhLkNSZE5osX2CBilNc+P0rM8E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-0Worh_smPzKmyfjfKkwM_Q-1; Tue, 02 Jul 2024 16:13:51 -0400
X-MC-Unique: 0Worh_smPzKmyfjfKkwM_Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-425657ac234so31645925e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951230; x=1720556030;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMYpex8C2s46cF0GfMcoGvUcCxmqXFvGY/Nt+8TTLHo=;
 b=YiVUhlmIz6UwKZzugiaVW+iGXSKTSg4c9fKJiPQL/dWj5UdRd9LPsrIFr16TYF6kxD
 lrVHbrJEVrdp2pw1wjZgCohjMJbqx2LMv1nC8w5eqW5tT0lL+5gBZTKUlmZRs1xmWJIV
 pieaHB7BYba7P33KXcxI18grgP/WMn+2bkO9w39X09YotinR64fcVjLZn33byhSHFpBO
 I5lFvx9U937KhgAtZRi9C5QteP+h+clgxfLbEnE0NEIuZj8K5tumyIgbQR/S8AjW6KOx
 Zb38NJI/l/GuG6FyFsoZcsthhVShLt7WNCg1wRPZXNV59oPIGMKS4FbZHe43NMcie7Li
 HwcA==
X-Gm-Message-State: AOJu0YyzilNVswSLu5BGa3B4v3B6zjIl0V48LInZoQQsfYGmQJfbSiGw
 zuk/m/72a4tqvcl/hM2eAYKk7TW9fgoliBrhFppR9ue+kBFVWiIDwSVbtQafMZ5Bu/rr6ie8j1f
 gE+S3aKrsOgR7wbG586YYpfZnkKaBsMA9FIoTNKQkOR07NrV22kvMFt8zs3mQneGNxxI6NNfbox
 BEWki5b5tk+nLAgQxxMkafBxE6qG0Nnw==
X-Received: by 2002:a5d:47ac:0:b0:366:eab1:6732 with SMTP id
 ffacd0b85a97d-367756a3828mr9124364f8f.9.1719951230392; 
 Tue, 02 Jul 2024 13:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1x+/ly54QZSyRdqQ54Dg4/T4BJn2meRArs5HD05DYKvPH281kQkeyy07rNdFRlNrcgsq1ig==
X-Received: by 2002:a5d:47ac:0:b0:366:eab1:6732 with SMTP id
 ffacd0b85a97d-367756a3828mr9124339f8f.9.1719951229863; 
 Tue, 02 Jul 2024 13:13:49 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6b4sm14052505f8f.17.2024.07.02.13.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:13:49 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:13:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 03/91] vhost-vdpa: check vhost_vdpa_set_vring_ready()
 return value
Message-ID: <9d5a807c4cb56837f11be9a9250f854fab951290.1719951026.git.mst@redhat.com>
References: <cover.1719951026.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951026.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

vhost_vdpa_set_vring_ready() could already fail, but if Linux's
patch [1] will be merged, it may fail with more chance if
userspace does not activate virtqueues before DRIVER_OK when
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

So better check its return value anyway.

[1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240322092315.31885-1-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 85e73dd6a7..eda714d1a4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -399,7 +399,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->nvqs; ++i) {
-        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
+        if (ret < 0) {
+            return ret;
+        }
     }
     return 0;
 }
@@ -1238,7 +1241,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
-    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
+    if (unlikely(r < 0)) {
+        return r;
+    }
 
     if (v->shadow_vqs_enabled) {
         n = VIRTIO_NET(v->dev->vdev);
@@ -1277,7 +1283,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
     }
 
     for (int i = 0; i < v->dev->vq_index; ++i) {
-        vhost_vdpa_set_vring_ready(v, i);
+        r = vhost_vdpa_set_vring_ready(v, i);
+        if (unlikely(r < 0)) {
+            return r;
+        }
     }
 
     return 0;
-- 
MST


