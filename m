Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675D3C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sby9q-0008Dd-Bf; Thu, 08 Aug 2024 04:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sby9p-0008Cq-1G
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sby9k-0001HW-Qi
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723104352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NJQ9wEhXTtcEv+urqrf3Td9TtD9S7IBK5VxBmKau9jM=;
 b=GBo2ZvS/dIT/wCidxXD6BIomQ8TpqC/qU4VIP9EsqXA8x7Ka+oz1pBDLfifLzU94ODfdBU
 Qc+xPiSIfSmyHSFbZBfHDyROBdjlk3iLFvWvejic0GgGzx32xd/cxOv8iQ9uwL0veHsQhF
 jzH1kD7EHkjfDh4Enk+HRoJwTJhOKxU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-cedi-sRKPgmiUeKUr2TT2A-1; Thu, 08 Aug 2024 04:05:50 -0400
X-MC-Unique: cedi-sRKPgmiUeKUr2TT2A-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-66619cb2d3eso17365807b3.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723104350; x=1723709150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJQ9wEhXTtcEv+urqrf3Td9TtD9S7IBK5VxBmKau9jM=;
 b=lI0rM4ccsJ6pl7d1W4hRtCxaAZTOQ0chtXTf5Qj05dINiJmUt+stFOk8iqYSG0tyeO
 hc3BRWGER2ivfGEvpuJVFnEwY4iL5l6xmUV3UNKBxnvIRv/UxcLaXRhu2vyJdD1B58L0
 Z+dGuFHOVxink1VrXHZkaKP7AuTGx/ZjQY833CjOdR/+MoRKOtVxLrdCGztfL2I0LaBg
 W38ZuwINrz7llg+dQNuazzTC/fzYs9bRKq/oed/vmCpNsjrNjoJ8wpQD1m8v69xXmUGK
 6GjMkzIuu+dxkWj0Sj6CFx7cjOh51cdQkhpyn+vzS/ztrOZqDq9dQFgwUisC+OlUUOFP
 OfWA==
X-Gm-Message-State: AOJu0YxjbAmUQj1pNibCpCOEyn/dfdOxek/yCz1GllmEgsaMnJFu3nSP
 ttXeQaR3OfADNRdKIJC16VqYdZu8zsXeBtLGwlvAUbWODuwnRRcDZ9TaGGTzLIddLOzIJ+6Kv91
 PG47P/OYct3yF5HJrk4dqVZAPPXCwZ80J5J+QiSR9pW8jvY2K3wi1Asr1N96pUz9KBONe8VDpnB
 Joacxf8sasMwsWOAvuNG1Ev42jdkt8pdhvoqM0
X-Received: by 2002:a05:690c:2e87:b0:64b:44b4:e13 with SMTP id
 00721157ae682-69bfb5f906bmr9711727b3.28.1723104350038; 
 Thu, 08 Aug 2024 01:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOf8K+Oe4apAzhC8azNOZUJXSXkkx+Jkwc72FWMLOF2CCHkLzu6Lh+9dw0Hx2woYO8e70erQ==
X-Received: by 2002:a05:690c:2e87:b0:64b:44b4:e13 with SMTP id
 00721157ae682-69bfb5f906bmr9711417b3.28.1723104349592; 
 Thu, 08 Aug 2024 01:05:49 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-248.retail.telecomitalia.it.
 [87.11.6.248]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a378690d0dsm133898785a.93.2024.08.08.01.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 01:05:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] block/blkio: use FUA flag on write zeroes only if supported
Date: Thu,  8 Aug 2024 10:05:45 +0200
Message-ID: <20240808080545.40744-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

libblkio supports BLKIO_REQ_FUA with write zeros requests only since
version 1.4.0, so let's inform the block layer that the blkio driver
supports it only in this case. Otherwise we can have runtime errors
as reported in https://issues.redhat.com/browse/RHEL-32878

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-32878
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 meson.build   | 2 ++
 block/blkio.c | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c2a050b844..81ecd4bae7 100644
--- a/meson.build
+++ b/meson.build
@@ -2305,6 +2305,8 @@ config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
   config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
                        blkio.version().version_compare('>=1.3.0'))
+  config_host_data.set('CONFIG_BLKIO_WRITE_ZEROS_FUA',
+                       blkio.version().version_compare('>=1.4.0'))
 endif
 config_host_data.set('CONFIG_CURL', curl.found())
 config_host_data.set('CONFIG_CURSES', curses.found())
diff --git a/block/blkio.c b/block/blkio.c
index 3d9a2e764c..e0e765af63 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -899,8 +899,10 @@ static int blkio_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bs->supported_write_flags = BDRV_REQ_FUA | BDRV_REQ_REGISTERED_BUF;
-    bs->supported_zero_flags = BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP |
-                               BDRV_REQ_NO_FALLBACK;
+    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK;
+#ifdef CONFIG_BLKIO_WRITE_ZEROS_FUA
+    bs->supported_zero_flags |= BDRV_REQ_FUA;
+#endif
 
     qemu_mutex_init(&s->blkio_lock);
     qemu_co_mutex_init(&s->bounce_lock);
-- 
2.45.2


