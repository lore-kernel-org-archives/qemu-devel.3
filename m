Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64438CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCG-0006Oh-VX; Sun, 14 Jun 2026 15:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCF-0006EN-5O
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCD-0002Ie-1p
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bz0Hzu3fLL2IW1bug82AU7111y2zS870mTq6ckWmhqw=;
 b=ZOrHFkcVRTkHv5ZRXoGI4IR8ZWnqcNowPJLlcMtcyHjUcy3xhkLrMBkA8w0/FXW4QCTGNI
 Levnmbbhf5NxlDiWWNRvxnDHzd9eDnHQrMma2dcnP9qHWeFfKfT9O2E52/wctXTo76dD+l
 av2fSV9+aLYkZgPa70Q+q/zZkTS5d1A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-j_IcqRYbMai8SiKGzRQrBQ-1; Sun, 14 Jun 2026 15:08:34 -0400
X-MC-Unique: j_IcqRYbMai8SiKGzRQrBQ-1
X-Mimecast-MFC-AGG-ID: j_IcqRYbMai8SiKGzRQrBQ_1781464113
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4600c8cb13aso1820945f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464113; x=1782068913; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bz0Hzu3fLL2IW1bug82AU7111y2zS870mTq6ckWmhqw=;
 b=rQ1mKKaHQp0A6fNR65oT2WImhUDDg6snaK2BFn7a+/1G8o3JPFNjE2qGzNZdAFfh5R
 Ra5PC+pgjIWXslfaiU2jtAt5YIAJud/ApF9gPxQwTCp3AonwvJRe/TOOc2zBKf3hIGWk
 NMlGdvtIMEM0c4A4S7Y/pbNQwLXxaVwN9NfeU3dS7uhZODnO7pT07EosJvdA7ET5/jch
 3e88oMzODP2NVvqbwMs7AmzwXe6Viv/hnAFnaxUO4U33kvei7miLLKNDdNg5wrNgwUy2
 hVQhooc7hZqtTyMNqBVEb4FjjBowxfToFKMG91JTRWXc/XgcGUwYY3XjaeFsmMcb/o7x
 cILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464113; x=1782068913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bz0Hzu3fLL2IW1bug82AU7111y2zS870mTq6ckWmhqw=;
 b=A0gbJsL49i81WrUAf/9y+0T0S5bdTsOcXxKd0wuJcLfQr5cx8GouTXYs9XloRzxcNj
 HsxEkZ5ib1yEb/HCXiZRsetOWPuhG7QqBRBRXuhUlcC2U8zszKTZ/cXRS78NUqp9/J7j
 ttzy2ySP9X6Ewna2dyaHoyeOlqxDPebLvGQmpyTuMR8jz2jQp+kNYt97gjZ97AJIuxyQ
 ZamjkueoV/5AhllLJVHcr1BB5y6JzOPO3ROtMV6k4PzBhAlKS3qVsA2MAt3BZX+jTGAi
 bmeHN/KM/4fLoVj5hIBOViSjzhykNqJTIHpV9dbXjEuVg/DQYDbFNnCHVw9spGwjpl/e
 Wk+w==
X-Gm-Message-State: AOJu0YxOyJgY+sVuFvul2ejuUNuPp1pT3xwzJ6nTduCal2FA1wYZjVU3
 ZlANqfMDkSJ2aJZw4RA8oRiLn1AMjC3ixY43FZwbLczeYSZSSSmjj9bISVJMcVoy/03uX44vjf+
 GN+hyF9snfuYVZS81iAIO6ojY5UX2EBJbUaS6dtCG7lfnCe2hfijI2cwkStyeQag2bDqRHHm/+5
 OOJjsJyFg622vHWldiwlT9nQUSU4jznuNVqw==
X-Gm-Gg: Acq92OEURk2woOz/aqy1w0M0I3jZAr7MumYuYsSA8j2kfluvPHfm4ralNmMKIs+C+72
 j35InSRnEKw2dLxuxajY6IYjCIATPDWcQDmpteDrCxRrJVnAIAMJ7FQwQtpvLpIPNQK5dXQBmVN
 ALMDEdPR6ojkThw/vtbELeXZqdq4CwtxtT7FjON+OoDY3BgMn+pxzCBKFBz0OUy8FIaoilKdaj6
 hM1vP4o7LIZbAQswQ7jNhxUD340dJKDeMYGHsLPG1CH/DlkNpVy78+LCTFcw6tHA261O+Zj6bm8
 pwNkpJkKb62WhAZS5fy12VYoHl6VlW9ofp5C/fRLe1lzV9JzV5iWR8Ascz70gCy1ZlOmLNI296o
 HziXmUPwQgOgo1D43A7Y11r4Eyn7U6cKFadLsn9GOB2M=
X-Received: by 2002:a05:6000:43d6:10b0:44b:5398:4e85 with SMTP id
 ffacd0b85a97d-4606db9839emr11411837f8f.22.1781464112871; 
 Sun, 14 Jun 2026 12:08:32 -0700 (PDT)
X-Received: by 2002:a05:6000:43d6:10b0:44b:5398:4e85 with SMTP id
 ffacd0b85a97d-4606db9839emr11411809f8f.22.1781464112382; 
 Sun, 14 Jun 2026 12:08:32 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d28sm27643353f8f.20.2026.06.14.12.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:32 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Max Makarov <maxpain177@gmail.com>, Max Makarov <maxpain@linux.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 065/106] vhost-user-blk-server: do not advertise
 VIRTIO_BLK_F_SIZE_MAX with size_max=0
Message-ID: <e777ba135f2a1a171cdcd468cfb29e89f1b27fd5.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Max Makarov <maxpain177@gmail.com>

The QSD vhost-user-blk backend advertises VIRTIO_BLK_F_SIZE_MAX but
sets size_max=0 in config, creating a contradictory state. The feature
bit tells the guest that size_max is valid, but the value is zero.

Windows viostor trusts the feature bit, reads size_max=0, and uses it
in scatter-gather calculations producing zero-length segments that hang
I/O. The disk appears empty (no GPT, no partitions), causing
INACCESSIBLE_BOOT_DEVICE BSOD. Linux tolerates this because
blk_validate_limits() silently corrects max_segment_size=0 to
BLK_MAX_SEGMENT_SIZE (65536).

This affects any VMM using QSD as a vhost-user-blk backend (QEMU,
Cloud Hypervisor, etc.), since both pass through SIZE_MAX from the
backend to the guest via feature intersection.

Remove VIRTIO_BLK_F_SIZE_MAX from the backend feature bits. The
size_max config field remains zero but is now ignored by guests since
the feature is not negotiated.

Signed-off-by: Max Makarov <maxpain@linux.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260331152856.1802-1-maxpain@linux.com>
---
 block/export/vhost-user-blk-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 67912a3e17..46c0d303df 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -119,7 +119,7 @@ static uint64_t vu_blk_get_features(VuDev *dev)
     uint64_t features;
     VuServer *server = container_of(dev, VuServer, vu_dev);
     VuBlkExport *vexp = container_of(server, VuBlkExport, vu_server);
-    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
+    features =
                1ull << VIRTIO_BLK_F_SEG_MAX |
                1ull << VIRTIO_BLK_F_TOPOLOGY |
                1ull << VIRTIO_BLK_F_BLK_SIZE |
-- 
MST


