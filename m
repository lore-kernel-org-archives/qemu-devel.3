Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6798AC3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 15:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSIN5-00068n-HX; Fri, 12 Jul 2024 11:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sSIMm-000537-Bc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sSIMa-0002U9-Tq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 11:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720798751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BShAKIQSR7HvyUMtjkZHE8fzP4hvMlZtx5L6ZVvwsW8=;
 b=dOHSUeiit7Ii2L03JxnoHRCr2s997utMYqrClX7M6WCMXpZft2+K2ICYaYM90dI4lIF56u
 CTKZYH914pmPn8veNSoo4i4D0oMQtyE7xoBL7THdSAbm9K1Ak6TWxSL7bUhPhbUqOYcfxL
 vWx0v5vsZrUfdOt8PE+jT63NjfBqNVk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Z16BM4ojPG2hJ9omqzB8Xw-1; Fri, 12 Jul 2024 11:39:10 -0400
X-MC-Unique: Z16BM4ojPG2hJ9omqzB8Xw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57cad6e94e5so2002280a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 08:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720798747; x=1721403547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BShAKIQSR7HvyUMtjkZHE8fzP4hvMlZtx5L6ZVvwsW8=;
 b=KVkVy4PPM076WJk9oDBjUk9pqryWYSaeTDjmGORbT3IuNPcpFE83k3TakyGCCrEs0n
 aOBXti6WF2rOzP3TtYzcnEtiNKuhAMl+M0lldTzOyNtbzAK1BC8pRpVU8aXnaDDc31//
 laurMLyPskRZmW1XkNVvZ9WU7NWwndjLMz4GXP+pMR4G2vNtg7m0yi+SBjmuEh6lfyI0
 fIn3ORQnOvJ0L7tnspgUzsg5zsqQzEY93ykzgMLARTaWvfzKVjIcrqojzYFNhNCXkyZv
 kk8aJ3BZEt2FEdojaaq0lpeirHd68cP6wkv0vxEVT5yrt4sUX7fLs4+xHKPAonEEnmgk
 rVcg==
X-Gm-Message-State: AOJu0YyitnESf3xJpJfeE0JkA6JxsBf5nDSOnnyEap9HB/9K/i6scX1/
 TBJk1+WMzcR3LnW/xQPWy4gxtZRSC4X64ltpXx0L6gNom7CUU+4xvurDnpIc9ShDIWY2MnRXFGV
 6OTLADtM/96/P/d0PpjeEzR9omWDR+23AzzgADlN/y6figN87TnHOgNtn3h40Lo/0fe45nrdM1L
 7rbEnl3QN08+t4+WD3M4eEn0zZaUQR7VhyzJKI
X-Received: by 2002:a05:6402:51d3:b0:582:7c35:8736 with SMTP id
 4fb4d7f45d1cf-594b9ee1106mr9954313a12.12.1720798747645; 
 Fri, 12 Jul 2024 08:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiLiUxtWPsFCtjHa6Om4HRNptbZUHpi3eE1kG5zh1+2gDv/JSVXBQt0oYAoLiLy/oI3k1uiQ==
X-Received: by 2002:a05:6402:51d3:b0:582:7c35:8736 with SMTP id
 4fb4d7f45d1cf-594b9ee1106mr9954284a12.12.1720798747000; 
 Fri, 12 Jul 2024 08:39:07 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bb960641sm4679266a12.8.2024.07.12.08.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 08:39:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>,
 Stefano Garzarella <sgarzare@redhat.com>, changpeng.liu@intel.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] contrib/vhost-user-blk: fix overflowing expression
Date: Fri, 12 Jul 2024 17:38:57 +0200
Message-ID: <20240712153857.207440-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

Coverity reported:

  >>>     CID 1549454:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
  >>>     Potentially overflowing expression
          "le32_to_cpu(desc->num_sectors) << 9" with type "uint32_t"
          (32 bits, unsigned) is evaluated using 32-bit arithmetic, and
          then used in a context that expects an expression of type
          "uint64_t" (64 bits, unsigned).
  199                               le32_to_cpu(desc->num_sectors) << 9 };

Coverity noticed this issue after commit ab04420c3 ("contrib/vhost-user-*:
use QEMU bswap helper functions"), but it was pre-existing and introduced
from the beginning by commit caa1ee4313 ("vhost-user-blk: add
discard/write zeroes features support").

Explicitly cast the 32-bit value before the shift to fix this issue.

Fixes: Coverity CID 1549454
Fixes: 5ab04420c3 ("contrib/vhost-user-*: use QEMU bswap helper functions")
Fixes: caa1ee4313 ("vhost-user-blk: add discard/write zeroes features support")
Cc: changpeng.liu@intel.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 9492146855..6cc18a1c04 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -196,7 +196,7 @@ vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
     VubDev *vdev_blk = req->vdev_blk;
     desc = buf;
     uint64_t range[2] = { le64_to_cpu(desc->sector) << 9,
-                          le32_to_cpu(desc->num_sectors) << 9 };
+                          (uint64_t)le32_to_cpu(desc->num_sectors) << 9 };
     if (type == VIRTIO_BLK_T_DISCARD) {
         if (ioctl(vdev_blk->blk_fd, BLKDISCARD, range) == 0) {
             g_free(buf);
-- 
2.45.2


