Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EE5C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 07:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOBpm-00071g-Mi; Mon, 01 Jul 2024 03:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sOBpk-00070N-DF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sOBpi-0002bN-MO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719820336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=C6KjqZo2dGPXK3fwibmQdJffp9L7VdqU4H/Eg13+QyU=;
 b=OQh4mAovZ1Pl95weBTHNcIX202nhZb8pvPkFWndBvGwB81e5TMSAzgvlpEEcvq++x44hOI
 2t9urJiO5FcHkkcPiVwnP6oGk9fF4uNwH6BVcSDSYqPD6SrYZ4h9bvO6Zjyymp3Wdd3BkU
 GPlkMNyxpAhx0iuJgSn4DrVnv6EBMMA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-5cZIT_jMO7u4A0PSiYijfw-1; Mon, 01 Jul 2024 03:52:14 -0400
X-MC-Unique: 5cZIT_jMO7u4A0PSiYijfw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec507c1b59so32723061fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 00:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719820332; x=1720425132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C6KjqZo2dGPXK3fwibmQdJffp9L7VdqU4H/Eg13+QyU=;
 b=bAZ3AXhsExPUNUl2Hc3C/D9N0ZO7JQYNQGI2JENMTK2Y2OabfSyI4lkDuowEVDzXBh
 3eWMK/PP4/TZB76x43SHOeZMDqPTBslvr2nMJdssurvLgam6IyVVoyZijSwBiRUofOfi
 qs1r9Xwm3MLO/sqx52ChWoY4W+T60odSSbC9i1lSgo11CZD3jJbAcMH46RnwwTST+x8t
 A/dKpw4pVq+fGrfVfMEKlD583dAuTlB3gNtb384pU92W65IQyFrLm90Q4dLHo5qTyhrN
 To4ROWQXvU9dfo4x+E7kN02pClGINrxqXR5cmFbzklbp08amp+XB7YO8vhq5OeDTMDzS
 pr1A==
X-Gm-Message-State: AOJu0YxqETe7EPBPR4TWJPx/JQx8RMuoSk/70lMep5Vc3NX+p2wuYTC5
 MUbdyv3mrIYgE+9jWGBBC72iRRk23x1mn36gr1y6gM3Q096P8ofCdJu+dcgjSaqwCaZi64I43tM
 4Wvn7gxYFlKph+U/qy7VNJqrlmdjO4Xe3Y0wx37UyBw0vAvTYqja01g3OvZhZTaF0q5CLS+kyTh
 kO5gZvxQmE+1V/Nz43D4q7ztrtWWI5h/x+w8af6Go=
X-Received: by 2002:a2e:3018:0:b0:2ec:5f85:61c0 with SMTP id
 38308e7fff4ca-2ee5e707c21mr38515371fa.48.1719820332696; 
 Mon, 01 Jul 2024 00:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtNkMHM41IGfok5s9q9V4/7ncNpNf6FDJAjyVaxGyMpSBrgG8xqWauc8SM4x1LwhxAlN7YXA==
X-Received: by 2002:a2e:3018:0:b0:2ec:5f85:61c0 with SMTP id
 38308e7fff4ca-2ee5e707c21mr38515041fa.48.1719820331932; 
 Mon, 01 Jul 2024 00:52:11 -0700 (PDT)
Received: from step1.redhat.com ([193.207.222.121])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd778sm9423789f8f.5.2024.07.01.00.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 00:52:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eugenio Perez Martin <eperezma@redhat.com>, jasowang@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Xoykie <xoykie@gmail.com>
Subject: [PATCH] virtio: remove virtio_tswap16s() call in
 vring_packed_event_read()
Date: Mon,  1 Jul 2024 09:52:08 +0200
Message-ID: <20240701075208.19634-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Commit d152cdd6f6 ("virtio: use virtio accessor to access packed event")
switched using of address_space_read_cached() to virito_lduw_phys_cached()
to access packed descriptor event.

When we used address_space_read_cached(), we needed to call
virtio_tswap16s() to handle the endianess of the field, but
virito_lduw_phys_cached() already handles it internally, so we no longer
need to call virtio_tswap16s() (as the commit had done for `off_wrap`,
but forgot for `flags`).

Fixes: d152cdd6f6 ("virtio: use virtio accessor to access packed event")
Cc: jasowang@redhat.com
Cc: qemu-stable@nongnu.org
Reported-by: Xoykie <xoykie@gmail.com>
Link: https://lore.kernel.org/qemu-devel/CAFU8RB_pjr77zMLsM0Unf9xPNxfr_--Tjr49F_eX32ZBc5o2zQ@mail.gmail.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/virtio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 893a072c9d..2e5e67bdb9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -323,7 +323,6 @@ static void vring_packed_event_read(VirtIODevice *vdev,
     /* Make sure flags is seen before off_wrap */
     smp_rmb();
     e->off_wrap = virtio_lduw_phys_cached(vdev, cache, off_off);
-    virtio_tswap16s(vdev, &e->flags);
 }
 
 static void vring_packed_off_wrap_write(VirtIODevice *vdev,
-- 
2.45.2


