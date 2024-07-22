Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5501C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkZ-0006Wr-Og; Sun, 21 Jul 2024 20:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkV-00066r-9m
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkT-0005oX-B4
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DoP8zpcWwKhsBbn/dEN5fS4FX6tEBJxOhfXfCwMS67w=;
 b=jQt9Ee1BKVxosGHEgJgI3ok4MsXevqOQaBexdahO8dxELjeSSFMgQ6ppQUMqX3nrrtj0yY
 5XGe/EYeVM1+cowwL6sKrIF8jrcvY0yeWxNZrr9tXYGEQ2vfUeXlam7tRTDy1hpKZ2TJwX
 q3FTMpyfw/bLAIgRuEYs9lfMUjzjQDc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-FggoodaAMDmBBq5Qa4aLig-1; Sun, 21 Jul 2024 20:17:50 -0400
X-MC-Unique: FggoodaAMDmBBq5Qa4aLig-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-427df7c3a2aso8282805e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607468; x=1722212268;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DoP8zpcWwKhsBbn/dEN5fS4FX6tEBJxOhfXfCwMS67w=;
 b=MIokNB+dAWXyKXPA5ZTxgV8e/ro24xuvZH1GEJv5uh8NaTy8M2KYLgUr7B3oFyWS4M
 m4ELjofnWXXIqRyA+di2pbVf2BlRHfEr5zA8/JIr+16tD6VOKGcEka3oRhhyv2qZFEBn
 LJ3jaOicA8k+a3eTpE3RylRGhJ35iWzAZlll+od4tS/XlUXwn0dtDV5DXbWmJctsN9+f
 7iMEjKZCIS1Pk9PLrkCa+GO0jrPQ4xXPL18SaZfjkfXp2Y+yXMovYcLulLSp1nwh7LJK
 98ZLczl3B69vNG9SAQvQJ6z3kYsrLxYqWM85bcAYFSY3LWa9NhjB4leZVgnoeoU+SXBB
 YieA==
X-Gm-Message-State: AOJu0YywvGYzSaChkcdGdGJwXZHQryv82Q4saEOVe/meNUjJm6krCXYi
 Vde5oKmD26/KFjUHduLRU/RX4VN5cHtWRMztHjiiYaeI6cIJxFZ4jE5+MsOnds4c/OKtJLKzxdo
 q0RnXa+yj2LEm4k68H33pjA7+vvQLZkW6l7uBZYqufC/YBDAxO8klBtPnfeLQI36w4pi4CdL78X
 Ip7A0reWi0qb4DRVv6FbQk2Pw2iMJrhA==
X-Received: by 2002:a05:600c:45ce:b0:426:63b4:73b0 with SMTP id
 5b1f17b1804b1-427dc578924mr33154185e9.34.1721607468669; 
 Sun, 21 Jul 2024 17:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8vGqR+6paOoX3WFlbtQkcPhOJkEXiY8yAI9yDoCw0uVZxpX+/1DUpo+4dnCgTIzHW/oGFKg==
X-Received: by 2002:a05:600c:45ce:b0:426:63b4:73b0 with SMTP id
 5b1f17b1804b1-427dc578924mr33154045e9.34.1721607468119; 
 Sun, 21 Jul 2024 17:17:48 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8d930sm133904045e9.32.2024.07.21.17.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:47 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 27/63] virtio: Add VIRTIO_F_IN_ORDER property definition
Message-ID: <0b0bb34f342f04ab8255a64edb7c6aec7105dc94.1721607331.git.mst@redhat.com>
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

From: Jonah Palmer <jonah.palmer@oracle.com>

Extend the virtio device property definitions to include the
VIRTIO_F_IN_ORDER feature.

The default state of this feature is disabled, allowing it to be
explicitly enabled where it's supported.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240710125522.4168043-7-jonah.palmer@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index fdc827f82e..d2a1938757 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -373,7 +373,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("packed", _state, _field, \
                       VIRTIO_F_RING_PACKED, false), \
     DEFINE_PROP_BIT64("queue_reset", _state, _field, \
-                      VIRTIO_F_RING_RESET, true)
+                      VIRTIO_F_RING_RESET, true), \
+    DEFINE_PROP_BIT64("in_order", _state, _field, \
+                      VIRTIO_F_IN_ORDER, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
-- 
MST


