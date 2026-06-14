Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6265DCD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCK-0006Xx-Or; Sun, 14 Jun 2026 15:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCG-0006Mf-Dn
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCE-0002Iy-Sy
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hgZCAxYFmsfw6kD1fGPLDLIDbzOgcLGMPPIQ9rhuoMw=;
 b=ZQa7FiazSFuFMlUWi/qEk9JgAMtIOS6afZUAq4tMJFF0usAI2wTeG7XnFghvIxCaejz1du
 xweSOUnm5QeboCWaoZ+ckQOamQiAwQ5M+yKHzvw70KLlN0D1jOAOIkLPs0p24U10jyeSoZ
 J2IUm6NKcrM3fRkQnihO+7f1HaxdLjM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-fvTsw8dtNZ26P-otDYkr_g-1; Sun, 14 Jun 2026 15:08:36 -0400
X-MC-Unique: fvTsw8dtNZ26P-otDYkr_g-1
X-Mimecast-MFC-AGG-ID: fvTsw8dtNZ26P-otDYkr_g_1781464116
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ef5e38a18so1174864f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464115; x=1782068915; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hgZCAxYFmsfw6kD1fGPLDLIDbzOgcLGMPPIQ9rhuoMw=;
 b=FmBF2BXqzzd/aO4Ub6aqZPZr5M28Y9jIAgp3gcZFbHo9mrjNQjuuHGmPtrOpfW8kvQ
 ey+Rq/+g5zMgCc5VTPOMwEhr9GNXY3Qc+DOFF2Sw4RWL/I0ZEvg6DoyKhRmm+tkhVfQy
 9Jmeuuz8eolV1MZifJUO/yiTrHVTZsMME3+SIyATwpD3MB01yb+txhWPT2J9mfBynvap
 RL/KiejlrwKeZETEcRP9C9OXrnvScf8rrPJ1Fvy5QesMtM9LuHJcYobHHYMM74QHgJjd
 yjosgtNn9OQmDgFJo/Vfxjtai2hpl78ArlahQlRZWegL6lFgI2Ams946a/H6ieS+yG+E
 Z0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464115; x=1782068915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgZCAxYFmsfw6kD1fGPLDLIDbzOgcLGMPPIQ9rhuoMw=;
 b=qZ+m8P4Kco+lW3PQt9RJDTYWxvBJTJ0+/AqrEz6hjWqMYN1VXN0o4W4DE/VeLWdRWB
 taQUgNl1GORGqw9j/nbjq0v7kjp3ZXW0tZTnx370r1HQTVxc5V5I21ivSZfcqQsFmHSh
 tPvLpLr0bhO89kz55Vmj7V+XVV7wPuIXH/lh+EUU9tAi+DvK3i4kf6RR1n7eNUhKqB/O
 yCjac/jqZMjkbz4Vj6zKJ9x7nR9vmKmkjOl8gRKn0EViCbWHyUzBa2hGYj5nEnioir1B
 WW3zWthOTSx87B8zWh/+pPJ27wmat0kFFbhd6IwbD3wGoRuPRKuRHHknKxocHP5u/kMc
 T30w==
X-Gm-Message-State: AOJu0YwxR07QvttqrMU5tLbfkV15B50MQrJ0DlU56skYdiuxMzRB5AEo
 lpWrW4OIwGbTCAETb10YDnKwyRRbgz2MB07ZA7ntT7ntEAlVBAeaOfUTFm8SSQGHx7jMj1BoU07
 RIIIuPHMpfcOWJwc+VXKuk67yyB0J3j6csi9F6TqQZqFRcX9VHk47Xhws7ktpll3ZKzpNUeDsss
 YuEEgITigClr1auEJ9GP0l3IY4J2S94KjzMA==
X-Gm-Gg: Acq92OG4ds3k7ww5yC7KJ0PTDT5raf3sczOI5hJjsjMbqs0jHRpj4xR8H8xnfPkgnJV
 j9gXn7w2nQz7ki8cvlcVo9dGQolvTH+ipWpvA8f3+sNbJKD3NWoLr33Ax59+u62ojqLaE9RT9dE
 nI4lfWgpoT0LLxtjSW9GzjSkZtG286FK9Fps9u+FBFF1MWBxh9cylzTmA0rctPgvFoV7v4CIICY
 dimDyLjRYy7ahdVIz8qYTerXrg2eHeA03mE4jcV6AvDcqLvE3k0BrNLWklkW/xwwSJcXdwnFwow
 r3sOb2d4Wma59N6DinZtf8VOjlGHN7FVQhO5Ao94YtAO32MgHMMefQ8Voui5JgBcYnka0hDLMsi
 OUEvb0QijoFmm4bJKf0lJv6hRzyUmUlu1cwXrfcrY8/4=
X-Received: by 2002:a05:600c:6214:b0:490:8fd1:72a with SMTP id
 5b1f17b1804b1-49220086792mr86911155e9.3.1781464115415; 
 Sun, 14 Jun 2026 12:08:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6214:b0:490:8fd1:72a with SMTP id
 5b1f17b1804b1-49220086792mr86910895e9.3.1781464114889; 
 Sun, 14 Jun 2026 12:08:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202edf89sm197256955e9.1.2026.06.14.12.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:34 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Max Makarov <maxpain177@gmail.com>, Max Makarov <maxpain@linux.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 066/106] vhost-user-blk: do not force VIRTIO_BLK_F_SIZE_MAX
Message-ID: <639dcd58707951cb88a0dddcb5027780c53d49dd.1781463125.git.mst@redhat.com>
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260331134721.96047-1-maxpain@linux.com>
---
 hw/block/vhost-user-blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 530f44ab52..5c73a58ee0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -283,7 +283,6 @@ static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
 
     /* Turn on pre-defined features */
-    virtio_add_feature(&features, VIRTIO_BLK_F_SIZE_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_SEG_MAX);
     virtio_add_feature(&features, VIRTIO_BLK_F_GEOMETRY);
     virtio_add_feature(&features, VIRTIO_BLK_F_TOPOLOGY);
-- 
MST


