Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411DAC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 12:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnEv4-0006si-6W; Fri, 24 Jul 2026 08:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEv2-0006rd-L3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnEv0-0004PM-KU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 08:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784895740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=qnIJXBTGMbbI2rNFcwnSfTtqYfZe/GTPJRHgQSsayQw=;
 b=PhiEJFqZU2mkdQuKjA42uLuenuasd5XSxB25DNsCjFKYTzh15VZzhQ8w2V6nvgHkQfsK44
 j6TOPXFdfNPgMNWUVSLpReY2JVoMaM+AfyrtKtL+Mrbyvd9gcHNYFdTCrfvbt75A3p7+LQ
 VThhefzJvFqs50qJ5xC81/jX90c9+Xg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-XxcK76ZXP8--rbTBTpwQsw-1; Fri, 24 Jul 2026 08:22:18 -0400
X-MC-Unique: XxcK76ZXP8--rbTBTpwQsw-1
X-Mimecast-MFC-AGG-ID: XxcK76ZXP8--rbTBTpwQsw_1784895737
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47407691804so320652f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784895737; x=1785500537; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qnIJXBTGMbbI2rNFcwnSfTtqYfZe/GTPJRHgQSsayQw=;
 b=k7gXRWvwWlzYWX+NYpnMbEVmIpkdZWXBQujJjcc3ujD6pDfkB4v9lexfwDztdIPttP
 opiVmgLLTMMFBf4y6MQYaa6z5tNsz16NE1kH905tFyqmP0QbPTh9aJGJ0K5dJbL/w3bI
 DGrkvD24fkeg9eHoteFkzEttkpZTRmmLMQIG+ciwm2q5nKQQ7DsNRZr6QJWLQwr91HVQ
 7Ue0XMqgoGsvi3xpROfHn2rbchci+N4Yo1nRxFTQpZRPc1LCKAUCet+RxhI8Qw2nLbIT
 Hican39yx9T5a5VshX4sAmBgWTx2nBIe+ipmc5novI7Wj+LR+zhocT0zMbLZduGZN7zA
 uLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895737; x=1785500537;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qnIJXBTGMbbI2rNFcwnSfTtqYfZe/GTPJRHgQSsayQw=;
 b=opIQtcF9mKWeutdNhW7rSXzwOqS30gqoCEOB8wfLtiZ9q8Wyn0JV2jJdDyXod2EpHw
 BVtFPCOvt875Myv9Dt9clym/dggbgNTbj8Y4qild1SfHKRbtLN2eKzGb0PUtwng/2Ij9
 MOa1zrM+d8WAXGkWhaZmxhb5tNH26TyWZ0lo0IF6/Aeb4rlYkbURNlsNT+GXavZBHUNs
 qmrZFhTM/IxsKsgQGykIdnTPhClOpGMDNG3Vf/IeDslVgmaOD2ewpXBV3qIdD8kSZ+TV
 xMbR+8zYiIZ7G+caoybpzZjU5lvVCnUBaVozPRHb1EVxFNwNDUeeL48V6ujNwuPCfvtq
 k13w==
X-Gm-Message-State: AOJu0YzKFc2libbaLcZbEJeCi9SqWfEMel2fDmtNlkBf1LKsqL8IuojI
 U5XZWuyW0YMLXY3OmIsrteIFocr503qtRiSdS2A8sEdz8Nh2XtqhBXcH3mh9xZuB3a2JyoLgUEE
 WFWOmfknbS6+6y6xTbXPKIWfz0buJ4UnpoaDkT+yfvr8ZUsHbQfeMSOilzSwxskA71S6kpC51T5
 RheOJVmcB7mRoX506dFaSSGESI/ANbxtF1Og==
X-Gm-Gg: AR+sD13yXtWzkDm3gv8D1qVR2eCNrbLZ/UxWm8UgWVyymJ29tkStSdFy/7aT37pu0kF
 yxEWimeneKaHDKNkGz+PsNv1iphffFcD57TOgy64LEXubSZ5X/LDusbRCEt6vOBnbUUCht1uRMx
 JHrGTNYv8WKqvxyVTvWs+S/+LI+8ZUNBoyiOVkfcOMCbZqaLgkMuOFwbdE/A+y287XVxOIkdn35
 mMDT+ZHRrRTqc1ZUXU6f8p2GgcaaCF+g33OTj34mBr0RYBoAZn+yXACo6ecuZtLNWE87CxZ2Z6o
 9ZUw105B3nvc977q3lVS5NTUJCzo3sU0/UxtefLKFpZXK8LnQWQ2nZpwvzDEOgHGGp0L6ydWSVI
 NQxr+Wwq+BHNCvAziAh2+Fw==
X-Received: by 2002:a05:6000:2501:b0:47f:93b4:2df3 with SMTP id
 ffacd0b85a97d-47f93b42e91mr6150069f8f.60.1784895737153; 
 Fri, 24 Jul 2026 05:22:17 -0700 (PDT)
X-Received: by 2002:a05:6000:2501:b0:47f:93b4:2df3 with SMTP id
 ffacd0b85a97d-47f93b42e91mr6150014f8f.60.1784895736513; 
 Fri, 24 Jul 2026 05:22:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm24195619f8f.24.2026.07.24.05.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 05:22:16 -0700 (PDT)
Date: Fri, 24 Jul 2026 08:22:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH] virtio-net: fix short frame OOB read in receive_filter()
Message-ID: <ee5c77b96ab66b2dd518f146def8727216a5c495.1784895727.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Within virtio-net, receive_filter() reads Ethernet header fields without
any length checks.

But virtio-net sets do_not_pad in NetClientState, so backends such as
socket forward frames at the size supplied by the peer without padding
to the Ethernet minimum. A short frame thus causes an out-of-bounds
read.

Add size checks in receive_filter() and drop the truncated frames.

Fixes: CVE-2026-63320
Fixes: 3831ab2094 ("qemu:virtio-net: Enable filtering based on MAC, promisc, broadcast and allmulti (Alex Williamson)")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3626
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2761644dfd..7e0c984ec6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1744,10 +1744,21 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     if (n->promisc)
         return 1;
 
+    if (size < n->host_hdr_len + 14) {
+        /* Truncated ethernet packet */
+        return 0;
+    }
+
     ptr += n->host_hdr_len;
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
-        int vid = lduw_be_p(ptr + 14) & 0xfff;
+        int vid;
+
+        /* Truncated vlan packet */
+        if (size < n->host_hdr_len + 16) {
+            return 0;
+        }
+        vid = lduw_be_p(ptr + 14) & 0xfff;
         if (!(n->vlans[vid >> 5] & (1U << (vid & 0x1f))))
             return 0;
     }
-- 
MST


