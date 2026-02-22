Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134CFC6369F
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASK-000892-1c; Sun, 22 Feb 2026 09:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARk-0007yg-99
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARh-0006fL-Us
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Vc1eHralXDftsudwcbcWVLtbmhHYnqnn64R5UkrMqM=;
 b=AhrQ6SyZl1wRSjnBrWCCpDPOOlWV0L8a1q/yAY8N/ksX431LQcmXPdSza0Zy1oBs7EqgE0
 Q7EzIcW7KtmfbS9ZZp7MtH6YjhaNcr4rITfeht33SYiRv9Z/tNqrEPwM/o0oFlkrB0gEK+
 /qDf0GlLCl8RoGaE1IDOuq7uf0TBcdE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-EQA39TiLOmOY8upekkxMTA-1; Sun, 22 Feb 2026 09:28:26 -0500
X-MC-Unique: EQA39TiLOmOY8upekkxMTA-1
X-Mimecast-MFC-AGG-ID: EQA39TiLOmOY8upekkxMTA_1771770505
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837246211bso38982345e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770505; x=1772375305; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6Vc1eHralXDftsudwcbcWVLtbmhHYnqnn64R5UkrMqM=;
 b=E/Sk0EePaC9gsRtgP5tHrgK+DoaiWhFPnDuKEU1Nv0aIqf0AK0uE7BBzSdOkD9+8vj
 0qcIFDOJutYqxoecNEjzW+To7EJhusGXMd/luJW5Fr/NKbmn5rxzlwDtBPiqE408yDye
 3V6VgC8xAB1Zc7KHmPL9x5BuGJr6FjploigbFcCVOXf3ne5DTYOu0W0dVd6Bmcb1s97i
 9ePEpDgoPM8JxH4BKex/n4IVE+nLmQ50fImRwccu0OQd4xpa0RQr0ji7Yp0USXkDija5
 u19xYOAXvWy5ZypVPXek4uS/6egt0TEaXuwDE2jJW8+RxUFKMGm5lxpY4pink8OIyB8i
 p2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770505; x=1772375305;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vc1eHralXDftsudwcbcWVLtbmhHYnqnn64R5UkrMqM=;
 b=sYpfZUEfQiHEL6LxKKaP8OHV2qvHbMjtDim2x+2lpcsh0LBGQZ/b9uibzQqdzYJPVT
 CdQuwB5H1Job19II9iDJbblxJeGFkymjGBWMuzX3F87Nud229Y8i1UNHUvJTiPTc5Vzt
 QTo3czfVhL1Z+im6mEe7U6bizu3kmJNJPrRrIz2IbSjOZ7Aq3kE36TV5FEKp4CL8h0hj
 tBs2AHWp9pJlm0DGswn66Y5bm9wBy9Ps0DZAv/LaoEGJa/Bnb0qDwwo53SZgBw/06kv/
 IXLSNN2JwZYOqjYO5nR0xIYbwcqNmm+7LgqM9jfBcJ0AQ/2X6CiOSYeqJwP0RaZrElBO
 372Q==
X-Gm-Message-State: AOJu0Yyl6bG8dviyEvbM6SdybdVqKee0DQ6SAcl41exB4BjtUmoYg/MC
 98OTYDJqUSixCfx86SBTZIP+lOYok++gEHQvJy9wlqregvacrQP3WwD6WP59XoVre/XBIVbJGbz
 NdaSyequti/EZ0878uZoNsVPumQViBlQWbBf/yMoZls+dAm4FH5v2Foliuppj0yV/zCAF8Yfrci
 RQh+beizzWDQKGZ/lwubh41i2Q1Nz3aPbojQ==
X-Gm-Gg: AZuq6aLn0W+e3D/1gp26Hg0jE+Qtuzh+ZSsQuZvCHsvUNQiokNJXmdsN8rDbC7UIS4S
 WyGhbe1pyr7d6mssDcus/4Ex2IAalomeI+r8oWQjdF1dKTI8xO9IA4LSkl8JZNDXrXEq1ZGjzvQ
 P8nwwkS6dEQQ3+rZaTWakOwm2OD+c0bm9tmfoC853tciUmTra4z1k7FHZDRZrDP8cqsEcu/ufyI
 Sn7kuf4EQ2/WscGQU2tMppTB3RVQ59KedTjyQdNy3Dsbjb1bKOkjdcr684UGFaNtp3udMA9ir1/
 xGMEMi0BX/9jSkZfCn5jXcklo2wx24+8+XF1ATVZWqWQj5lEy9QmzJUkUSU76tMwvVktQXJYDD1
 9cYHEdP/20WPJVXwQj0qG0cfmCnxVtrNcxDIeGQC+mHmLtA==
X-Received: by 2002:a05:600c:4e8a:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-483a962e37emr87501395e9.19.1771770504485; 
 Sun, 22 Feb 2026 06:28:24 -0800 (PST)
X-Received: by 2002:a05:600c:4e8a:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-483a962e37emr87500985e9.19.1771770503900; 
 Sun, 22 Feb 2026 06:28:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b75b4dsm194818005e9.4.2026.02.22.06.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:23 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 03/33] contrib/vhost-user-bridge: Add UDP receive hexdump
Message-ID: <fa33e6815ee3926b485a12a6b654c7edbac8b373.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

vhost-user-bridge debug prints UDP TX hexdumps in its transmit handler,
but does not for receives, even though they are beneficial for testing.
Add an RX hexdump in the receive callback.

To delineate between transmits and receives, also add a debug print
indicating that the program is in the transmit handler.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260129133049.119829-4-yodel.eldar@yodel.dev>
---
 contrib/vhost-user-bridge/vhost-user-bridge.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c b/contrib/vhost-user-bridge/vhost-user-bridge.c
index ce4c3426d3..3f0fd0fa49 100644
--- a/contrib/vhost-user-bridge/vhost-user-bridge.c
+++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
@@ -179,6 +179,9 @@ vubr_handle_tx(VuDev *dev, int qidx)
 
     assert(qidx % 2);
 
+    DPRINT("\n\n   ***   IN UDP TRANSMIT HANDLER    ***\n\n");
+    DPRINT("    hdrlen = %d\n", hdrlen);
+
     for (;;) {
         ssize_t ret;
         unsigned int out_num;
@@ -333,6 +336,10 @@ vubr_backend_recv_cb(int sock, void *ctx)
         };
         ret = RETRY_ON_EINTR(recvmsg(vubr->backend_udp_sock, &msg, 0));
 
+        if (ret > 0 && VHOST_USER_BRIDGE_DEBUG) {
+            iov_hexdump(sg, num, stderr, "RX:", ret);
+        }
+
         if (i == 0) {
             iov_restore_front(elem->in_sg, sg, hdrlen);
         }
-- 
MST


