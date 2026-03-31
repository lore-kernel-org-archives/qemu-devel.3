Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE88109B489
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7b1k-0005LT-W5; Tue, 31 Mar 2026 11:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7b1d-0005L2-59
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:29:05 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7b1b-0005zA-E6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 11:29:04 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5a13e1cfa45so6906953e87.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774970940; x=1775575740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h/7C9+j19HQDVS88E4uv1HnDwUwgQjjHhGa9Y+fBRTI=;
 b=NsW0YTzsgAEVCUOVYZqZ+0lUnR6foPn32vrgWoQTSrDE5QqSd3pnSETtPeUBs9Owm1
 czuNyIcHQ3qRDN34eL3yd/KCaZtfFdmDC+wIEZaHQ4UwHJZlNeelHjZ+NbheKANxYQCy
 i8R1YlOv5QyCS/QItUUo1tLus+m/21pw61uiPs8hRtoQgktoxtaKRYB6fn4o/xCuqDPU
 8cMZVorhhQi2rN1vaAMr93NdD84ZL6456tJme/tm0Ht8tH6dQmwOuY/8kokNBg9nS9K1
 SM0FSFYtIUSwlCgMBeRmQD6KMRTdXVnXpCPNATs+/nKTbinqBo9FS3GHLinQL6HoU25S
 1H4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774970940; x=1775575740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/7C9+j19HQDVS88E4uv1HnDwUwgQjjHhGa9Y+fBRTI=;
 b=hCYUZ6ti+eoP8nwXIrl1EmYLt9cpM9SuRvlbba5uN3ESYUQ0JF984XVrX0CkUkeR9t
 54yJ753Kszc5IF/5nX866t7ybpZGEDbIXg1WjrpYsvZ/7ZZcAh+uICdi75X7nmR83iuy
 Xc14bfjK7veEZJ/aLte8H6AlA9yS/Jyz9UIIEZzdM9D3eqyGwRjuMSbhfgsihZp68F3L
 M2jXScJ1/adR282nYvP5crpQQi0Nravtx8TbGbe4g9I9Etfzk88ZqpYX9PwRErm6Nb0a
 AAobRyLyyaUVpEufMRmXmV4MmRV1WQYg2rDM0ptZMmyeDbUqKi1dTtrhTiY7z5A0N1nq
 vEqA==
X-Gm-Message-State: AOJu0YwKLiZZdCr+HL5OMA/iZVzqXlusFFbJbcZWtv1SO8FVjeaWiGrx
 wrXEQ514ZQprYk3vaNE2uZGAscO7Q3saodK3/cnVdTGOGGjO4qQQQjH/MtLomveq
X-Gm-Gg: ATEYQzxKk5vxkvZ9XmTmuBwOMXc3A2B+fMljaCKoIKiPgrjTQvEQ3PoYHyHDBP6taph
 1SMo6Vt0OsgE4qPaRmKzN4SUd9zbWsJwID0RqNQrWWFWCrYKSWEsOr4gy6xDSytoiQlNPPA0V5T
 JgragkiycmJuOv/ZqKj6w7RF3AtMN/MZvVsUMhQHhZYaXCZh7Lrs3cm9cWRmuceR59sndp2/3Vr
 84r4hfFmn6L6i0bGXOjvEM9e3289IG+JfVjUXnoT1t9TmXGNXwx2TR5JqgNft3lPIMJ39v7V3ou
 nUtUI31XK2YT7qzbcByMVTc5T1nw5v7s2bkBmZl6xueXTVua5xHbstE0OdiorVDkc8F9otVs4zU
 g9e4eR83r8nPsMG9CEn0d09oJ8nMUCyvp16P25MU9cHcRPUWpFNsDX00u1lABt4+1tFU5rezEtv
 +C3Qyd6qutwAaPOXb7WpR1Z2R+0WN4eToDeDA+U48b2osMfZwikoAt+7fQ
X-Received: by 2002:a05:6512:3d17:b0:5a2:a073:50f8 with SMTP id
 2adb3069b0e04-5a2ab927610mr6022938e87.24.1774970939685; 
 Tue, 31 Mar 2026 08:28:59 -0700 (PDT)
Received: from localhost.localdomain ([89.21.130.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2bd66239asm563050e87.51.2026.03.31.08.28.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 08:28:58 -0700 (PDT)
From: Max Makarov <maxpain177@gmail.com>
X-Google-Original-From: Max Makarov <maxpain@linux.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Max Makarov <maxpain@linux.com>
Subject: [PATCH] vhost-user-blk-server: do not advertise VIRTIO_BLK_F_SIZE_MAX
 with size_max=0
Date: Tue, 31 Mar 2026 18:28:56 +0300
Message-ID: <20260331152856.1802-1-maxpain@linux.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=maxpain177@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/export/vhost-user-blk-server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index e89422b..b6b03b0 100644
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
2.50.1 (Apple Git-155)


