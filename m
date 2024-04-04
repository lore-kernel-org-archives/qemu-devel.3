Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C86CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsLmj-0004ow-BH; Thu, 04 Apr 2024 08:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rsLmd-0004kn-KF; Thu, 04 Apr 2024 08:01:32 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rsLmb-00063z-J3; Thu, 04 Apr 2024 08:01:31 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56dc9955091so966743a12.1; 
 Thu, 04 Apr 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712232084; x=1712836884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GO0ls1hQiObcHd1DBdp8MP2QOtBJ7Bpa+kAIWvDYvC4=;
 b=H/ngHO41KQmCVhGvGkzoFk7L4lk+f9SNxwZ26AecKYflRs1kCoXqLLG2CGogza1HCP
 4h9pcmbg1M9XLALiEsNTKf7NKTiuG+LT/9LhrLnjaUfrsd1ghir0Qhs4fBLGjBangvaa
 jBMzebubTI2TSZ1G5A1ulOfdvfiXOX1aXD6j1mQuPCHA1Tj5SXLLGZ6V+XZ0OgBZ14+i
 +gDbtyeeFj3isKz0u0bbEp21muX5B93NzXAh+4DP5xOt/VSI/fsgIzv0HrC/AIMRUSmr
 oQBNy/KBLzbYLnz5MR0tJ7EjkvL+9gd15QxwS3m8pzBnRzj+q7RIUBmjqHy2/oDkBK72
 bURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712232084; x=1712836884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GO0ls1hQiObcHd1DBdp8MP2QOtBJ7Bpa+kAIWvDYvC4=;
 b=F7n3hI0yBfEOzYU1cZl3I796GVgOlrnkpmjxMC3wxHq/b9TmYDn6WPdus+gcSOCe0A
 SdIm6FV+N9f1qisVXvnKKMtwduITuC0YYVGFHNf7yS6U3KQWh9eFbXUeJIUjGhpfbTRq
 w7AtldRNGcI6LtCmAe+1wDWHpfssQIJhdmJM+g7OBO1v8miGwhYPwhmAlncOtR0yHIrw
 rzcZN/OLClrlG3NR3ovO4LxqPVOXpxQXPvFBPRxt+jAgpKobXjvDP19jLCOleTZMEpUT
 Ag3gT7VmHo9NnQxqdfPrrzi0d2P1/2EMYspzpg0hWpd7WY03Qa9EXum3EQxNzbDvr2r/
 W5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbKbmSdBwbNM8P08f7xG8Rr9jDEMaHxil7p1ZGfCQSOf7wsD4JPqu4JcazAxaKTsnYxAe2GSEMlWqH1cgscSdrIQR8vdwfZRscrMULR9OBV74tpO297YwREFxN7Q==
X-Gm-Message-State: AOJu0YzSOdv/DFwP7/U7qYIey4VXRCf10zuQRbEB/vlj8AycP2Em1Rkm
 UTi40sa0/Y6q+A+227skKrN566VjH3oh2eiFgDf/GkE7cKhgj4I=
X-Google-Smtp-Source: AGHT+IH9qSK6veOtOWJPKIpSLCR7CLJytg6ApvMHK1xEf0NisgiLxIiqxyJHzZrA9bvXHHCd+UN7Fw==
X-Received: by 2002:a50:a6d4:0:b0:567:45e2:c4db with SMTP id
 f20-20020a50a6d4000000b0056745e2c4dbmr1761556edc.39.1712232083691; 
 Thu, 04 Apr 2024 05:01:23 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 cf2-20020a0564020b8200b0056b0af78d80sm9268325edb.34.2024.04.04.05.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:01:23 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] block/virtio-blk: Fix memory leak from virtio_blk_zone_report
Date: Thu,  4 Apr 2024 14:00:40 +0200
Message-Id: <20240404120040.1951466-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This modification ensures that in scenarios where the buffer size is
insufficient for a zone report, the function will now properly set an
error status and proceed to a cleanup label, instead of merely
returning.

The following ASAN log reveals it:

==1767400==ERROR: LeakSanitizer: detected memory leaks
Direct leak of 312 byte(s) in 1 object(s) allocated from:
    #0 0x64ac7b3280cd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x735b02fb9738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x64ac7d23be96 in virtqueue_split_pop hw/virtio/virtio.c:1612:12
    #3 0x64ac7d23728a in virtqueue_pop hw/virtio/virtio.c:1783:16
    #4 0x64ac7cfcaacd in virtio_blk_get_request hw/block/virtio-blk.c:228:27
    #5 0x64ac7cfca7c7 in virtio_blk_handle_vq hw/block/virtio-blk.c:1123:23
    #6 0x64ac7cfecb95 in virtio_blk_handle_output hw/block/virtio-blk.c:1157:5

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/block/virtio-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 92de315f17..bb86e65f65 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -768,7 +768,8 @@ static void virtio_blk_handle_zone_report(VirtIOBlockReq *req,
             sizeof(struct virtio_blk_zone_report) +
             sizeof(struct virtio_blk_zone_descriptor)) {
         virtio_error(vdev, "in buffer too small for zone report");
-        return;
+        err_status = VIRTIO_BLK_S_ZONE_INVALID_CMD;
+        goto out;
     }
 
     /* start byte offset of the zone report */
-- 
2.34.1


