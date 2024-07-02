Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57A3C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxm-0005Rb-FD; Tue, 02 Jul 2024 16:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxD-0004vw-AC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjx6-00009O-Jv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1RnRBcwUZd5byR6UedM+mwZMcF5dchy820Keg4IB1o=;
 b=NZbd7SqawERfebLBMISruxZ5wd59iltHmxefHXdZdGxZUUl00LC/Vu07WqjERV6+xtFXCx
 g9gUaaEyGlDyw0xHj+ni1AQzRWVe5gTzi5nLUn5dbABMfdLHj2XeHkiQ3CYts4JMV4As67
 TDjuVMqGYYS7Vsm1p+O/akc7GJ1C8K0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-4MTUiZ5vPgqFrMYNgHdy_A-1; Tue, 02 Jul 2024 16:18:07 -0400
X-MC-Unique: 4MTUiZ5vPgqFrMYNgHdy_A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36536118656so2810047f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951486; x=1720556286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1RnRBcwUZd5byR6UedM+mwZMcF5dchy820Keg4IB1o=;
 b=qZKHbZdpIsd+YxHYmtU6G7wzBvqGtY4SPpm3KJrEI0DsJgeAfvf3GPsDU4iZ4Cy0rO
 PTyUmIcPAXwdM1pUZeZs/VCX1GMd88obHJc626mLTCpW1C0MMvv4sErffXsa2yjvz/X4
 YGQrr5bSaqGsb5TsKcEcLVJsrm0z0wjw/u2JmqdqL6SwBvu2iLRFodhUC2zURmC2pdCl
 g7J7sdCvlrt4k+GkX3jHRsX5OHrZ4BohPXd0WLZZH2OPCKdH7dK5j6Ktv9bTMDSB3o64
 GtESBQTj4/Gvf/pNndLpMyQKDRAziRueBHPiQ959kShXwsZckLNSIrmzujI9htlJt0c+
 3DLw==
X-Gm-Message-State: AOJu0YzvYfmVUcsLFkYx8ncQ8KIKS8YBceN6NLisNWVpXea7xDUK/Uds
 YjS1jhkKaIhEWOerSW84feiEoTOywGzM8yHRdUUuuS9PbsobfgnnMdx2TkTqliP0CZ5z7KzL96I
 X/bASyY+tC24oOVTLxqKKAD5TCVwKFpyLMQA8IS5zUk1jtRdFA8qMERX36SErBYfPR6ivytBCpS
 k+cWDd05lhiq9NI+lYs/G12EFpEI2DkQ==
X-Received: by 2002:a05:6000:400c:b0:365:980c:d281 with SMTP id
 ffacd0b85a97d-367757248e5mr7054670f8f.45.1719951486279; 
 Tue, 02 Jul 2024 13:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvd2Idy4of70ouO4d6eH8Mi6rxppJQ5Cj5hfRlSe+RchdSCJaQr1PPu2/dsX/x2+T5r3meGA==
X-Received: by 2002:a05:6000:400c:b0:365:980c:d281 with SMTP id
 ffacd0b85a97d-367757248e5mr7054645f8f.45.1719951485741; 
 Tue, 02 Jul 2024 13:18:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd687sm14181089f8f.14.2024.07.02.13.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:04 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PULL v2 43/88] virtio-iommu: add error check before assert
Message-ID: <704391f94a5494f10b886ba79c157363a79b1239.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


