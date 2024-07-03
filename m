Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37212C31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lQ-0006Lt-Mg; Wed, 03 Jul 2024 18:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lP-0006Fo-89
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lN-0001yl-FV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1RnRBcwUZd5byR6UedM+mwZMcF5dchy820Keg4IB1o=;
 b=jIg29T0nQdx/vBqSySmm5NESYfBHE92i1LLfDcbb7m/lqVftofepqnqOz+Mau4pWl/FPzn
 zAiZlHw5azfFV85aU2TFwVIvYEEzRSPIl84ckpCh/0ZtjAdkdSJj9xYfMf1TqjxghZ7evE
 Rm571E2cAL5HK1b9U6HG6oiJFXAeVrQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ElRzljU7NOuDcNr_xasF0A-1; Wed, 03 Jul 2024 18:47:42 -0400
X-MC-Unique: ElRzljU7NOuDcNr_xasF0A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ce7a15a62so6360329e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046861; x=1720651661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1RnRBcwUZd5byR6UedM+mwZMcF5dchy820Keg4IB1o=;
 b=d7andKQs6seXXyD5oY1wswAboUBoyxfEI2lMRN9woGuLhu1rga2iOXfn8mqznae9f2
 t6+R63ZVcxi5hdpy9mnayMmPCXXKsqIiipYlsUruTMbKE0JTydjgBpPllxG5+5k7b3tB
 YvY1/KKVeT6QMLDMs/RSzac5CPKZfunIdqkCbf3uqBphD5NJVbkilpZhpUKk/5U39Mc3
 zXEIB+hrs8CBLTXKrCSGIqLrdk+4mRDL3t7RVLN1HOi9N6QTcj/UU+r/m17p7Df0S+LN
 agfSp71VSuNb4KakSVyqrB0rZ6RJgQZumMJ/JJ2l56HAoXurIk9gh4UuP41mrYGwqlYf
 39ww==
X-Gm-Message-State: AOJu0YzOzpFKc0jyCbYJnw6IOo9SaseAONk9LJoOxRBhpjBiNV8FPJOS
 3OPOMiTaDaujoTQ72VKMxam9mVjiQfgQYkfwemzbW4wuDvo6rNXxpnP/eYaEZZ1IpfE3elY3m1a
 ve0YXV2xi1Bye6S2ok3ak3D1V0zYyaN2MsYd1U+FJCVynazgj+PoPQszMqpK/ntarvBy1aLcJNP
 0njjjJbG0NFhQmH1JjFexf9GQkdH+gTQ==
X-Received: by 2002:a05:6512:104c:b0:52c:e133:7b2e with SMTP id
 2adb3069b0e04-52e8268b956mr8673589e87.35.1720046860963; 
 Wed, 03 Jul 2024 15:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOFyv9bE/A2/4QPauIzJPfpNAjXyFMaCGFIXPPZdL1FvIMdqSIufgqUtSGivODNvqiGZbbzg==
X-Received: by 2002:a05:6512:104c:b0:52c:e133:7b2e with SMTP id
 2adb3069b0e04-52e8268b956mr8673570e87.35.1720046860184; 
 Wed, 03 Jul 2024 15:47:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58de4581536sm469309a12.16.2024.07.03.15.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:39 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PULL v3 43/85] virtio-iommu: add error check before assert
Message-ID: <704391f94a5494f10b886ba79c157363a79b1239.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


