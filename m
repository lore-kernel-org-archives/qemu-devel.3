Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDD6109B469
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ZRY-00066b-1y; Tue, 31 Mar 2026 09:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7ZRI-0005XI-8R
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:47:28 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxpain177@gmail.com>)
 id 1w7ZRG-0001Ae-DU
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:47:27 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a2ad56dbb2so3762367e87.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774964843; x=1775569643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mGWzXS8O6bMcd3O5FYHqt6YPOxXLQBaPdBZlp2AaDN4=;
 b=FZBK1OfLQ9eey+mXRhQDXFNhUvIlfY/xx/YLDWqIb1/RzB0tyuIagyZ9BbhIzVwKrG
 taLEcYloxt3LqW003sW0zDAydSyV0v4u5Sr/1qzTUgMADRyd/fFVn9otbPN9CsQjuXU/
 IYpokottVVPK/APvWN+BlWPclho+8AQGRT5GQzQgu7uSsDYj9TFwtbm9206/tvYmnoh7
 yh1oN2dpo+RJeIIBxFuqdGZm/wV6EbmOY2NYaXmMnVWKa2PbpbjSMxuu3KZYkyd17e/x
 m9nkqiJshCfKPAUybjdK+Juk701ObIOszkJNjRuewegDdG1kaYMNlMypeN4p+x00L/Ug
 k2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774964843; x=1775569643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGWzXS8O6bMcd3O5FYHqt6YPOxXLQBaPdBZlp2AaDN4=;
 b=bAt2+O3oNUglMPak790DCFURzK2P4boXq3p9KPm75O/3SCraHGaIJZmPplDXwdujca
 ZD4yiPvQ/1X2NLVVLZxiUJwlGmIBNZ8qNAvjejE/rJWB3ahby1QCbIB7TDN9Bb0ouijc
 iDoNhf1fwIgYioJfQ71gM2CfZYaNXG2x4TTBhJms+ZGG0BOY16J20bOKeKyBm/DGYL/u
 rS6I0BSOwKKfi+6HMHd1v7NpRTOZ6I9YvV/O8FMwlxw1mw/NvHTZOGLx1oYvzr47mqPQ
 elEeEQqptjx8sYVfkgPqKyXBqjS9A52yTgP4a6q87Rpoyp2fZe2rCfdFHmG8qWDjnzse
 4IFQ==
X-Gm-Message-State: AOJu0Yyl1n69+T6BSCHuEnV1cVhC5UaGjUrQtUeqtYrld/By8TkBPfzq
 2A2pXNaAwpMGp8/A9CMbTfbKbiN89DCmgkFG7gxA2Zmbx6Kxbj768xIYVgQ0FmQi
X-Gm-Gg: ATEYQzzYHiFRcurbuS2cm6FLVD7GQ1buC8J4SZROTWpuM/JnkcpPtwvYPkrQ/N6LzCm
 6V8g1gUMLyB2BAwXzM1V/UJzazjH8XPxMBh43NmyDiJkhq4a/pz0spe0nxiOQ8k04chhiQsgqzK
 TTQniymn9PehAOj7a7QmjWv8axnew8TajU53CFYY/iXAL8RvFdlKXfTJ/lO3nMGyU0xC411C7Zb
 kYv/nfOG7djEtSCR5SVQlOC/md+xqUpIRSZ0S6eDLrtMGduRO2yYuMif5vxV+Z1eLeD/GBR04lz
 e8mhJEmMGXCyZIT0FlL4Jsp5IoE7+uiHkM6Q8T4FZg3ZBlVokqIXpmIs28m36xbKEiXobHcSKyu
 bH6OjoNu3+Aew0P4s+wNLFhtPGhAHLgNITkBLvdJAlpQpwZtju1sTnjeeQGgtv6PoakR2Qz/jXy
 XPcmSjvkcOZG83mLISAESMyxdWUp4mqbEqwj+MV229HoOL6A==
X-Received: by 2002:a05:6512:3c96:b0:5a2:bac6:c924 with SMTP id
 2adb3069b0e04-5a2bac6c998mr1455859e87.15.1774964843159; 
 Tue, 31 Mar 2026 06:47:23 -0700 (PDT)
Received: from localhost.localdomain ([89.21.130.68])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838e02c5sm21611701fa.36.2026.03.31.06.47.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:47:22 -0700 (PDT)
From: Max Makarov <maxpain177@gmail.com>
X-Google-Original-From: Max Makarov <maxpain@linux.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Max Makarov <maxpain@linux.com>
Subject: [PATCH v2] vhost-user-blk: do not force VIRTIO_BLK_F_SIZE_MAX
Date: Tue, 31 Mar 2026 16:47:21 +0300
Message-ID: <20260331134721.96047-1-maxpain@linux.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=maxpain177@gmail.com; helo=mail-lf1-x12f.google.com
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

vhost_user_blk_get_features() unconditionally advertises
VIRTIO_BLK_F_SIZE_MAX regardless of what the backend reports in
its config. The built-in QSD vhost-user-blk backend sets
size_max=0, creating a contradictory state where the feature bit
tells the guest that size_max is valid but the value is zero.

The in-process virtio-blk device does not advertise
VIRTIO_BLK_F_SIZE_MAX (it also sets size_max=0 in config), so
guests never see this contradiction with native virtio-blk.

Linux tolerates size_max=0 because blk_validate_limits() silently
corrects max_segment_size=0 to BLK_MAX_SEGMENT_SIZE (65536).
Windows viostor, however, trusts the feature bit and uses the raw
size_max=0 in its scatter-gather calculations, producing
zero-length segments that hang I/O. The disk appears empty to
Windows (no GPT, no partitions), causing INACCESSIBLE_BOOT_DEVICE.

Stop force-adding VIRTIO_BLK_F_SIZE_MAX in the frontend. The
feature remains in user_feature_bits[], so backends that properly
advertise it with a valid config value will still work.

Signed-off-by: Max Makarov <maxpain@linux.com>
---
v2:
 - Remove the VIRTIO_BLK_F_SIZE_MAX feature bit from the frontend
   instead of setting size_max=4096 in the backend config [Kevin Wolf]
 - Fix incorrect claim about Linux PAGE_SIZE fallback
 - Drop unrelated Buglink tags
---
 hw/block/vhost-user-blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c151e83..7ba6562 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -273,7 +273,6 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
 
     /* Turn on pre-defined features */
-    virtio_add_feature(&features, VIRTIO_BLK_F_SIZE_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
-- 
2.53.0

