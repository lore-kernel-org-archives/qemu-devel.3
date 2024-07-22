Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C076C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmS-00086E-Gb; Sun, 21 Jul 2024 20:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglH-0001wB-AO
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglD-0005vV-1l
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+taPMy5Q8060TvpZgWRsF1ltpcOrUHjqjPNdMJkSVmk=;
 b=gFpd/CdEWpUd9ZnTkA11bE7FQ6IVDPgUL4LS+Va2QQyDlVFCxyQdN/gdltnVpQIC2i6S9K
 88sX1e4C00pxy6Y4QjPkNNlwXsSkFW4h8+oM1wKF0z8Z8c4RAYywzpY1J7ua31pbe914Ko
 nt0ETxhuGHxjyRG0ZfDT+GT8c46nuEo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-O57d3f1rP2CAAYU1ceKrFQ-1; Sun, 21 Jul 2024 20:18:36 -0400
X-MC-Unique: O57d3f1rP2CAAYU1ceKrFQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so15455105e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607515; x=1722212315;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+taPMy5Q8060TvpZgWRsF1ltpcOrUHjqjPNdMJkSVmk=;
 b=BanaRycDWQVRWakkRBnh/dK3TVDqvy2XzAwQ4rUh+YOOzP7RO/HVq6Gt4VuwJY3qfl
 JwX+1OOZ/gr3kqmgFqmb2BgB0PaHQ/YqSGeE9xgvFJ+1wdevtX9UP0bXgnRgK5QZtyDw
 sjcWhRz8tNkHmo5LXJVrrsUU1TsAPa6C/ViLT3Bu2r+2t+5+j5zYX3+iokF8IwUL/fIt
 72Hj8dUT6e/rDzt2cJYrPDXLE6lmrnCt9JR4KTpOke3DAZDyaJB4iiWjRQFo2ANpJYp5
 R9waE5NNeFYqD33Eh5JTVXMtip9+GbqGvFX2sQxtGR+7RaenRyr2w+gl2ZRec8o72snu
 V6Hg==
X-Gm-Message-State: AOJu0Yzuhv/Ls+bEpZtXJrGf4yCHb8KnT4v+qqJ35w/OPewRyXMQMMsw
 tGyht1keJTqoyzP+s2YvyickCAJFmVXx6KI/u3O9n1KwwzWVlkVLVVpMahbs1PzRHs0zZ6rots+
 0+GDMX4jDO8sjOf4zM6wFrQu2sjV1e3SGgzI9GxGm4qaz2g+YImRPq+7Imwc+3Rm4QPR+bOFfo1
 SSwGpXteWFd7UHKq7oSaa7YHqVlv1PYw==
X-Received: by 2002:a05:600c:46ce:b0:426:686f:7ad with SMTP id
 5b1f17b1804b1-427da805e46mr39659245e9.10.1721607514825; 
 Sun, 21 Jul 2024 17:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG7QDE/bNhHpHK6AcOFPRi1M4tg3TKYoiAu3jzyNrFF935IgyTnkTQoC5GBKu0yx+sdRc56w==
X-Received: by 2002:a05:600c:46ce:b0:426:686f:7ad with SMTP id
 5b1f17b1804b1-427da805e46mr39659125e9.10.1721607514320; 
 Sun, 21 Jul 2024 17:18:34 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm107416355e9.10.2024.07.21.17.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:33 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: [PULL 48/63] virtio-iommu: Remove the end point on detach
Message-ID: <4dc8ff564fbefd6f8542ef3367b839d1319a5de6.1721607331.git.mst@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

We currently miss the removal of the endpoint in case of detach.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-5-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2de41ab412..440dfa6e92 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -786,6 +786,7 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
     if (QLIST_EMPTY(&domain->endpoint_list)) {
         g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
     }
+    g_tree_remove(s->endpoints, GUINT_TO_POINTER(ep_id));
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
MST


