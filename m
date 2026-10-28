Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F15606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ss3q5Qik;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AA3rVNlh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7ER-0004wb-Bc; Wed, 28 Oct 2026 13:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7E1-0004ot-Hu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Dz-0003Qx-Vd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vR4fcP3CxlO/lhI0sB5mPceLXuoA+S8qHPJWP61EE1U=;
 b=Ss3q5Qik2u5xJjI6ZIzmhlHOP7kLPwfIWcMztszZOmIUYUzLJeS456fOpM2qJlgYFQRrKm
 wk1z7MKX1fqFXlIFyR3AWiOiaKSH3yohOb77SzeSMe6ODhvCNtnUvmd3wV/0wt4YKu7T0F
 QjyW9B+klHAX4FlO4Bj3yA9D8emUWhs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-syFLrw8oPIi-uSSvRzKLgA-1; Wed, 28 Oct 2026 13:14:05 -0400
X-MC-Unique: syFLrw8oPIi-uSSvRzKLgA-1
X-Mimecast-MFC-AGG-ID: syFLrw8oPIi-uSSvRzKLgA_1793207644
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c415561aaso744304f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207644; x=1793812444; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vR4fcP3CxlO/lhI0sB5mPceLXuoA+S8qHPJWP61EE1U=;
 b=AA3rVNlhmRG/s2NEBN9CJngGZ555Ov/k5CKnPxwKqs47itXs3l56mqQBCd2+C+gTus
 OgoSTUHgfA4Jtz5mqoXkFOWViggm8sIB3bq71sNvCCH+CuAHRRas3ZuAa/ls7YIhyLjw
 1JFjKna5n6RX2CQFVWfGu5GyDDsYhT6LDXNqS8nMnDZt5kXkP3jW23yElftSSYwxC7RL
 zpuRFpa5TvXYNX5OuF/ir/iRGhbTOmIjNMKNyNGM1DLUSwayNj3q969agq794OgenIRj
 S/Z8Rl3HqkpTg4Wa+MZApT/n1Y0wS5i/Q/KmN5FhAH/mkcNM5qtTAPWngxRJ6EFgNTOT
 uKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207644; x=1793812444;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vR4fcP3CxlO/lhI0sB5mPceLXuoA+S8qHPJWP61EE1U=;
 b=JmqM8w3THZIX/H1qV3tr5qhoA6XLP0bnZYl/MRhOfmI+KBJD4JzJPHQ42kM6pcXGNL
 LI06xo/jH7ary5Z24QmqWuo/HICfwXM8tWyaA4nKF7nnqnsKUbAj6J0Mqq3fsaPudlRX
 Qjg5D5DJJw+pgLcENQ/HXNMxLMpA1ggw77rUjdX07c7+C3VIZJo/1ENVa9ByQ8jD5i1W
 5uQTMUZ3Ik5YALpAqSRro1/caLdyRJkEKZwV7d3NTq4TdSbMS+Rtyn3CCV2sSJ8sNZ2n
 /UvRKAxSY2VuIHRMGRSLC5YJFQ0QGkRR9Pz2OJMVuYrCNrkIX+lcnTdOsMA5R3g6xL1i
 JdTQ==
X-Gm-Message-State: AFq9FYL7RMxFquROTpj8z6r6VOw1mhQUi7jeGXzXaaWiBrD37wWtF8iK
 m68rBTABzbo39IJDNvyzM6wx4rsw79BfEeUF8VHJHBkZ2bc4680Nxhjz1r/JJj+3GBTm5m/qNHZ
 mq0dg+OWMapm2ssFI4KrpWAA3Fwe1dYbzqT4fywECk+w9842Dh+WAAsNx4Xm4CBHRjmJYgbvqyV
 pis3HUSJ7RIlnSQxl24CDxmzevJCujhsz4KA==
X-Gm-Gg: AYBFou02EAP/0qsBlgLxAMnyQWvWyvoByKztLpZtBHQMKnkYECctLDrxN8iUP6MNLEf
 ihSIgz99zRvWV1tFN/q9bzEeLVdgCWTFT46Qcj6ARYNGKDja9NJb1JilxGEmHL/JREZwtMRHngd
 RHzJ5ASMclOEgW+mn6huO2vLqM2eA5s8Prj5oqOTUWZ8qlaFlx+gUCDuwHHQSeVUu6op9WcTc1i
 wFodfhPwaFi9ikgv/TOdridhZGqiOBcrbSjuG75eC6XH4StMuPAJSGFfje3vr+oRf9wFyhxKRZ6
 FfI5NNHvYWfZaB+x36piwcx8nie6P17CxMz6Aylc9gq5IBuYwvtZA1jx9nX/L+QD0QeIft2TL1k
 FFuUHeWh1yE8608vwSbmM+rHTIOBk31n83vcyAXf4
X-Received: by 2002:a05:6000:29cf:b0:487:1575:ebef with SMTP id
 ffacd0b85a97d-48e5d311eb9mr4996586f8f.47.1793207643789; 
 Wed, 28 Oct 2026 10:14:03 -0700 (PDT)
X-Received: by 2002:a05:6000:29cf:b0:487:1575:ebef with SMTP id
 ffacd0b85a97d-48e5d311eb9mr4996527f8f.47.1793207643166; 
 Wed, 28 Oct 2026 10:14:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e412cc164sm27865838f8f.7.2026.10.28.10.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Connor Kite <connorkite@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 03/78] hw/virtio/vhost-shadow-virtqueue: fix range boundary in
 SVQ translation
Message-ID: <b80a3c287c50357198f125581dffa5bef93ade37.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Connor Kite <connorkite@gmail.com>

iova-tree expects inclusive range sizing when maps are allocated or searched.
Currently, svqs use exclusive sizing when searching their
vhost-iova-tree for a match to the region to be translated.  This could
lead to errors if the region to be translated is at the edge of an iova
region.

Fix this by reducing `needle.size` by 1 in
vhost_svq_translate_addr to bring it in line with DMAMap and iova-tree
convention.

The only current user of svq->iova_tree is hw/virtio/vhost-vdpa.c, which
also treats size as inclusive when using the tree API.  In progress work
on vhost-user isolation mode in hw/virtio/vhost-user.c also uses
inclusive sizing when interacting with the tree.

This patch is an updated version of one from the patch series "vhost-user:
isolated memory".  The patch has been isolated from the series as it
is not tightly coupled with the rest of the series.

Signed-off-by: Connor Kite <connorkite@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 34e3c94edaef ("vdpa: Add custom IOTLB translations to SVQ")
Message-ID: <20260817233147.2867623-1-connorkite@gmail.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index bcb7f2ffc7..c8831d52be 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -99,19 +99,25 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
         const DMAMap *map;
         DMAMap needle;
 
+        if (unlikely(iovec[i].iov_len == 0)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Zero-sized buffer made available by guest");
+            return false;
+        }
+
         /* Check if the descriptor is backed by guest memory  */
         if (gpas) {
             /* Search the GPA->IOVA tree */
             needle = (DMAMap) {
                 .translated_addr = gpas[i],
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1,  /* Inclusive */
             };
             map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
         } else {
             /* Search the IOVA->HVA tree */
             needle = (DMAMap) {
                 .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
-                .size = iovec[i].iov_len,
+                .size = iovec[i].iov_len - 1, /* Inclusive */
             };
             map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
         }
-- 
MST


