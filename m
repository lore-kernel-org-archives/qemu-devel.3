Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867B3C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnb7Y-00031M-MN; Fri, 22 Mar 2024 05:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rnb7X-00030w-5d
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rnb7U-0005xe-A9
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711099402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K1CCjRVJRVf+ZFfSl/7At/4VX4N9ABNtVU5DQTchqXE=;
 b=K1Vsnt/pZFmQAGbDALHmIHzmf6p2CZaL5A6rdgiOwh0ACtbqRKUZgYOd/r4LA1yduXyXzs
 pUwT3BNx42SJL37hDws8NT/NZzcb83etpDWFvi/Li7d66ejDK4Mbg0COW8PeoVUaJFdzEI
 M4uwT7oedLVJo1wy/YB9Q7YonAWLrbk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-29ffN5q_N6ypNBLsFiZvew-1; Fri, 22 Mar 2024 05:23:19 -0400
X-MC-Unique: 29ffN5q_N6ypNBLsFiZvew-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34172041676so1348658f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099398; x=1711704198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K1CCjRVJRVf+ZFfSl/7At/4VX4N9ABNtVU5DQTchqXE=;
 b=MiosMZscs4PORzgxav+gDqa4TyLube+AM2rxT1v4YRUGH59VX/7lzroZlkeAJ7IZjM
 C4ty+R580I5y/i0td3p3QI45XkD7rY2NFxsQulasRLCzOSAxl7asavDAHCdSqwLQf96w
 CZupQmF0Cm70YNhYgt8yFmuR+dwhMf5yR0y6/C16cwOqFKwG10ZP7ldEOYPrn9C5nEjn
 hQhZS7mEtuqA0At+lhvCMfp7QmDZMQeXFuSz+9j+6/f9ICfSDxdqA/RQRWT0RWAJ8rw8
 dQ78BT2GutvIYUXsesj2B4YOtlml3P2/QJo26Cqdeq3iTBwoMUD9gydimfTIpC1WFCoO
 bWDQ==
X-Gm-Message-State: AOJu0YxBn06jlk9u7hJxJKZ43ckg4TzVffu4BlyVakulX5t57aAE+LG/
 FCmSZIG2A5pWUZVIwWN/SndsFP9ieS4jc9yh087RdJLMKP0Jd6qh2O2sqP9ePf5/mn4MzwuulgF
 /TuSCg2iKlHqBzDXpdhf6dmoTu60Y9/dMGskidPX6JHsdbJT+MWlhpyCFPK5CH8pQmi+tTtrm7o
 T5FvqCTcqXpCVhttLERPM0DwEb7GYGdoiBJ1RX
X-Received: by 2002:a05:6000:154f:b0:33e:d6cb:34c4 with SMTP id
 15-20020a056000154f00b0033ed6cb34c4mr1733259wry.4.1711099397935; 
 Fri, 22 Mar 2024 02:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLYCw7oVkNkff0+5NTe2zIXSGrkw8EQkaveGcF6UAa2cO9HHPLsLkHVQ4Jgsd1QWsvhGnFAA==
X-Received: by 2002:a05:6000:154f:b0:33e:d6cb:34c4 with SMTP id
 15-20020a056000154f00b0033ed6cb34c4mr1733227wry.4.1711099397525; 
 Fri, 22 Mar 2024 02:23:17 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 x3-20020adfcc03000000b0033e41e1ad93sm1615301wrh.57.2024.03.22.02.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:23:16 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mst@redhat.com, lulu@redhat.com, eperezma@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.0 v2] vhost-vdpa: check vhost_vdpa_set_vring_ready()
 return value
Date: Fri, 22 Mar 2024 10:23:15 +0100
Message-ID: <20240322092315.31885-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PP_MIME_FAKE_ASCII_TEXT=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vhost_vdpa_set_vring_ready() could already fail, but if Linux's
patch [1] will be merged, it may fail with more chance if
userspace does not activate virtqueues before DRIVER_OK when
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.

So better check its return value anyway.

[1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Based-on: 20240315155949.86066-1-kwolf@redhat.com

v1: https://patchew.org/QEMU/20240207092702.25242-1-sgarzare@redhat.com/
v2:
 - added acks
 - rebased on top of https://patchew.org/QEMU/20240315155949.86066-1-kwolf@redhat.com/
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
2.44.0


