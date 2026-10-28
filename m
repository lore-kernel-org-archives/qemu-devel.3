Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZCc33s1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Xp+Wgk+o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HL-0002uK-DI; Wed, 28 Oct 2026 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GZ-0001Be-1A
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7GS-0003ux-A1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOOjb2+T7Uz3dqto95pa8UMd7Sn0XzzF+CFE3iv5nxI=;
 b=UZCc33s1je6Smk6XEXaEpH5Ob37xQzTRJLJnXCmqoPSROnNEUPLW1bRAhKZXi3lIsWf6EM
 iuf2VEuNzT43bRHOCuaNjbpPDK+fgWbFNOwpZ+VNVJbQ96ruzBKtHsjL5SL1XzuPiTBar1
 vDYwei7sczWnAfSwiOlsbFbZLBEwlS4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-XXCrA4jcN9mFToHT416KTQ-1; Wed, 28 Oct 2026 13:16:34 -0400
X-MC-Unique: XXCrA4jcN9mFToHT416KTQ-1
X-Mimecast-MFC-AGG-ID: XXCrA4jcN9mFToHT416KTQ_1793207793
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so712741f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207793; x=1793812593; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AOOjb2+T7Uz3dqto95pa8UMd7Sn0XzzF+CFE3iv5nxI=;
 b=Xp+Wgk+otIsuqvnZ9faiTOHDdVqtokV4W11WccV4bnpDAZ/oTefArdWmJMIooMpgjR
 83UUaurR6Jf8hiXUzXf2lMH4PJWu4QsBUnmU5+bvSzSy1URcUWU5drou9isk0PjN0UQu
 pK6vKm8pKZnndd65Fk6K42pF4qL0S72nUcraDRAugmtvhzfCGgcQqicqfbQ0XSG5oawx
 xT2ppjaRHw4vFMf3MD2whp2TYsT11DKuFndGWDmcx4UE18nL15m/vjc5pFKMR6iisZd3
 sM7p4aHcuwgCW9oA7yxbAEhK9GcglsZRmCglOQ6KRzI+wPmONXw3lwfLv60nDa9sEfAU
 W9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207793; x=1793812593;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AOOjb2+T7Uz3dqto95pa8UMd7Sn0XzzF+CFE3iv5nxI=;
 b=BBWauHDtquTTsysLlxxpQXbbKkt44U1v6BJXINwl/j8XVDmotL/uv8rWY/ZbaWjog3
 m0ulAUdpqdth3pL/j8iRCU9MEENde77uWuguJ/btygx5o6eLs6OAV/Owd2foJ3SHn1QI
 YDFWC6l09iqNYXS076JfBo1grJR8ytbLaeUqLLf/cQDR4+sRR1ATDiANEF7nDng9kiOJ
 SPpirzVblvwnRhPp8vraKodMt/A4B6P8FLnWP+LLpDoVgm2e31Ztb4U6hSY5P5Ub3odF
 RpWuK6uqy9EKhvGaO4hznOEQtOGDAswx7F5dGRYu3av19zASODjUinOVvChBdJnarWDd
 FIXw==
X-Gm-Message-State: AFq9FYLWTxWsfQ27tEKUrNKi3vI6SFplqEifXm+3KJIa5bnKkE5f7hyY
 xiwKyYzQbsIq4Z/bCZz2MwJs6gXRUxcTZnuKMiJPU8dmQ2gj6KGYgyKVjBBvHwUS0LLjmXfnY9q
 y/eAdSBApUdPHkP+qSj7hICxmxsSht6fMJroQhvRtjhcKrNMDDGhUBmtnuYAgkdX3fxWDIQ13sI
 f3XbiQxnTq7rxofGPy29lzOGJ1iivWVL0xVw==
X-Gm-Gg: AYBFou0+CHmQAs/0I0uijAC3iAIe6bDRGNfgpEXLsYfxENVqmWlO8ZSZ8U9ME6QhWkj
 1eQhOBJJAv40TQxhRimlGT9KwQrhmeTMsx6UOQAktOutrluDP6B/IBCdN8laf/Ze+ycVLIxOwd3
 zxuKAt/TLciQYuqCpFWYJY8Uv98lrVo6QCHctINB74Qcs4GchL2Rk6NGdRTrWSVyUCZrEkaiFhR
 spL0+tAWvyOT1U5GIC1llT1OQn0xuR7LCdcHuttioiJvdkboyF6AAUwAujKM83FojmwyLEyok9m
 anvZX79F27HwbmmHR1tjP2jsPkygvdRgo07FZIpc89xDE3jAABG//7bSMkZGUobQK9IsmlgZfB7
 HzRjiN8Z/mzN/5jr+CSpFYynfDoKWIgXwZJbWxbwm
X-Received: by 2002:a05:6000:178b:b0:48b:5e2:52dd with SMTP id
 ffacd0b85a97d-48e5d5c3874mr8409619f8f.11.1793207793051; 
 Wed, 28 Oct 2026 10:16:33 -0700 (PDT)
X-Received: by 2002:a05:6000:178b:b0:48b:5e2:52dd with SMTP id
 ffacd0b85a97d-48e5d5c3874mr8409524f8f.11.1793207792283; 
 Wed, 28 Oct 2026 10:16:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm23942614f8f.40.2026.10.28.10.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:31 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 =?utf-8?Q?Cl=C3=A9ment?= Chigot <chigot@adacore.com>,
 Stefano Garzarella <sgarzare@redhat.com>, vhost-user@lists.linux.dev
Subject: [PULL 58/78] vhost: move skip-drain feature check to vhost-user
Message-ID: <1272a3d91519108ebcb9e5a8f5f1b838ea2ecb24.1793207602.git.mst@redhat.com>
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Currently, do_vhost_virtqueue_stop() calls
vhost_user_has_protocol_feature(), causing a link failure with
--disable-vhost-user when other vhost backends are enabled.

Move the assertion to vhost_user_get_vring_base_skip_drain(), keeping
the protocol feature check in the vhost-user backend and removing
the dependency from the common vhost code.

Reported-by: Clément Chigot <chigot@adacore.com>
Fixes: 5eb2347867ee ("vhost-user: add skip_drain param to do_vhost_virtqueue_stop")
Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260929122223.2164612-1-dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 4 +---
 hw/virtio/vhost.c      | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3402accc6f..402d9603c0 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1463,9 +1463,7 @@ static int vhost_user_get_vring_base_skip_drain(struct vhost_dev *dev,
     bool skip_drain_supported = vhost_user_has_protocol_feature(dev,
                                VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN);
 
-    if (!skip_drain_supported) {
-        return 0;
-    }
+    assert(skip_drain_supported);
 
     return get_vring_base(dev, ring, true);
 }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index cbf6e82afb..b25919c5c7 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -23,7 +23,6 @@
 #include "qemu/log.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
@@ -1554,10 +1553,6 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
                                    unsigned idx, bool force,
                                    bool skip_drain)
 {
-    if (skip_drain) {
-        assert(vhost_user_has_protocol_feature(dev,
-               VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN));
-    }
     int vhost_vq_index = dev->vhost_ops->vhost_get_vq_index(dev, idx);
     struct vhost_vring_state state = {
         .index = vhost_vq_index,
-- 
MST


