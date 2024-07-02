Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC341C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCa-0000fb-K6; Tue, 02 Jul 2024 10:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCV-0000Ce-3u
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeC6-0008Kx-PQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1RnRBcwUZd5byR6UedM+mwZMcF5dchy820Keg4IB1o=;
 b=EbiJ3FTu6M8+eFTjyy0vVW2KMPwJ2s9JXO4u6G3plwgF/NAgf4t7Q7yvJkblWkU77kErrc
 /p8KG2oaxiOyHlOR39KrL44wHbcoN+AXpjC3u5fb1X+bg5++WfiRwxPk0U+Sy2JPZmhqjc
 CmKJoSbqagKcbDiN7wEopRN1NsnCsZc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-q9NP0rkMNluXhCsn1Dn_nQ-1; Tue, 02 Jul 2024 10:09:14 -0400
X-MC-Unique: q9NP0rkMNluXhCsn1Dn_nQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678fbf4aa7so48881f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929353; x=1720534153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1RnRBcwUZd5byR6UedM+mwZMcF5dchy820Keg4IB1o=;
 b=Rin2ojMa4vQsdYBqy0NgaMYJcr4SlXxIxR0UQwuq0aQ3wpK/lpztf7k1nj7uuT6fpE
 MCssSlOraTfDm9RZ1gQeCB7f+AjKyGutnNNRuaY0rfEExqiC5ovUcAEDEJqOxlZUdBM5
 YCEroqd5wYq3IPIEY6w6YaqA1KToRvvby01o0+k8mLWBt5D9hTXlngJG5q8hWTqUhTi7
 TBOzYy2putry7zgtToa2SALYysaNuIzrhY96c4zPuNKW8XYCWUzjyf0O1uVgZizpXOU6
 ZqPBuTolr7LHYW890+7fsZuQfIOmI8hGEbMS8OhxFXXllq0sMkwef/zsI/PRlhuao78D
 vwSQ==
X-Gm-Message-State: AOJu0Yx+6gLdOqdSfmV5s/d1xARe6I7QNx2x3UtuI0Ksar1gR6Mws6hD
 Roa/zQ6M4u+iZhj0SWheyme4V2w9ARqkQyTPTyUdCNVc3OVvOCWpjDWODXkDaf8TTHPga/VWhal
 dDVULop+Qw1BNdO0K0yYH0uYOXnxFe54XrHkz0ng9T+sWac2E7Exsk4OeTGYrNFZAbpUQ2cuvjW
 4AAyJh/bDxXe2IVgPij5mxbtIOKL2mdg==
X-Received: by 2002:a05:6000:1242:b0:362:8201:fa3 with SMTP id
 ffacd0b85a97d-367756bb8b5mr5773617f8f.34.1719929353020; 
 Tue, 02 Jul 2024 07:09:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNOsRMRow1mbeJN1JphwQJP7coOkL8+Xe13B1y5Ll8fccjqMayR9n0bhZDw43Gr2lcC/Rwsw==
X-Received: by 2002:a05:6000:1242:b0:362:8201:fa3 with SMTP id
 ffacd0b85a97d-367756bb8b5mr5773593f8f.34.1719929352484; 
 Tue, 02 Jul 2024 07:09:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d8ed0sm13377356f8f.28.2024.07.02.07.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:12 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PULL 43/91] virtio-iommu: add error check before assert
Message-ID: <dd06f2f46385ba31b8a9dc336f3c97b77543476b.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

A fuzzer case discovered by Zheyu Ma causes an assert failure.

Add a check before the assert, and respond with an error before moving
on to the next queue element.

To reproduce the failure:

cat << EOF | \
qemu-system-x86_64 \
-display none -machine accel=qtest -m 512M -machine q35 -nodefaults \
-device virtio-iommu -qtest stdio
outl 0xcf8 0x80000804
outw 0xcfc 0x06
outl 0xcf8 0x80000820
outl 0xcfc 0xe0004000
write 0x10000e 0x1 0x01
write 0xe0004020 0x4 0x00001000
write 0xe0004028 0x4 0x00101000
write 0xe000401c 0x1 0x01
write 0x106000 0x1 0x05
write 0x100001 0x1 0x60
write 0x100002 0x1 0x10
write 0x100009 0x1 0x04
write 0x10000c 0x1 0x01
write 0x100018 0x1 0x04
write 0x10001c 0x1 0x02
write 0x101003 0x1 0x01
write 0xe0007001 0x1 0x00
EOF

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20240613-fuzz-2359-fix-v2-manos.pitsidianakis@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b9a7ddcd14..ed7426afc7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -974,6 +974,9 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
         iov = elem->out_sg;
         sz = iov_to_buf(iov, iov_cnt, 0, &head, sizeof(head));
         if (unlikely(sz != sizeof(head))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: read %zu bytes from command head"
+                          "but expected %zu\n", __func__, sz, sizeof(head));
             tail.status = VIRTIO_IOMMU_S_DEVERR;
             goto out;
         }
@@ -1010,6 +1013,25 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
 out:
         sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
                           buf ? buf : &tail, output_size);
+        if (unlikely(sz != output_size)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: wrote %zu bytes to command response"
+                          "but response size is %zu\n",
+                          __func__, sz, output_size);
+            tail.status = VIRTIO_IOMMU_S_DEVERR;
+            /*
+             * We checked that sizeof(tail) can fit to elem->in_sg at the
+             * beginning of the loop
+             */
+            output_size = sizeof(tail);
+            g_free(buf);
+            buf = NULL;
+            sz = iov_from_buf(elem->in_sg,
+                              elem->in_num,
+                              0,
+                              &tail,
+                              output_size);
+        }
         assert(sz == output_size);
 
         virtqueue_push(vq, elem, sz);
-- 
MST


