Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531DECD11DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 02:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpIfR-0005ZD-Eo; Tue, 26 Mar 2024 22:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIfO-0005Z4-S9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:05:26 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpIfM-0001x7-Sd
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 22:05:26 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c3ca3c3bbaso1730082b6e.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711505123; x=1712109923;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LE24uluRQ9KTcauWcR//b64EcOukqLmAzNLJotmbG6Q=;
 b=lh8XUV7Z5DRW+yU7pleOTLykBYsxcq6utK/sqdSJtcf59deDd+SblCVpeDwuTudJIm
 q9xuwxFgmDiJzXMj8r8OjGd8lAqJ2B7L8z6bIFoYQl85A+t0n4QUAGK01zaXJeaYNMRM
 FrtAp8ULHuN200XeuBmMG1wD9nHmCAcCGXpShmLYKBKDcwL+3I+qfWBVmW2RHKV9h0Hh
 RZMe9YosJEeIl0UZvFowMtSS1VxYSQWLABOVG2foHKXsSpVBeBKLh4bZa8fQqcjNkUsJ
 OFpsEVqQDC7BNRjYHZpqYxQA7Kp+z1V16ykeDSAxsLuEc5xm4s/EyNM79mQ96YdNHXIp
 JZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711505123; x=1712109923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LE24uluRQ9KTcauWcR//b64EcOukqLmAzNLJotmbG6Q=;
 b=MasjoQhLLypkn/0XHtxhbe/teC6mA/tUz6B3sGLDjf6aegOhG4/69y7YwMRVpwEsBa
 pDvd2SMedO88HOzGFu/+koihGVO0KnVtnSpArqTrBPL0ANbepeqlVVEnjCaO8f6kLjS5
 +7hcp8LcS74E3r/gGgdLFX652pvBjFUDtiTZMnvzU8gKAiQ/OTu+yipUuWn154xnOd+4
 HofT/8vQWCoFRMkvQKmv/6SSMWdFVvFig3SGjo9zdtA/J4JD9RYFx80YjMHngdSl4Mn0
 VyTp0Vf+eMucygkAsVCvT97v6UatB1wJKwIhMuWKOYbUacpe0759PaU2bTaL1MCBTti1
 72ng==
X-Gm-Message-State: AOJu0Yz8apaF4zH7RLJPDuyZhgrmnS5Y2qYutviJkCJFWzyKsd4f7FgV
 xTdv/hmcczzigq3pAoV3YCuXgN5K9+36VTc8QTGyiLE1xfhTytZ6RcEFqXCARSs=
X-Google-Smtp-Source: AGHT+IFG16LQfwYTABGS0s/eSMQmi+7vqNaD+T1Ya9RxKbitHLeYlaQIGaXzdjifG/VQpqvV/yiDlQ==
X-Received: by 2002:a05:6808:23c6:b0:3c3:d1f1:dcc9 with SMTP id
 bq6-20020a05680823c600b003c3d1f1dcc9mr7795567oib.18.1711505123731; 
 Tue, 26 Mar 2024 19:05:23 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 q27-20020a63751b000000b005bd980cca56sm8205732pgc.29.2024.03.26.19.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 19:05:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 27 Mar 2024 11:05:09 +0900
Subject: [PATCH v2 1/2] virtio-net: Fix vhost virtqueue notifiers for RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-vhost-v2-1-0a89aa21b54b@daynix.com>
References: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
In-Reply-To: <20240327-vhost-v2-0-0a89aa21b54b@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

virtio_net_guest_notifier_pending() and virtio_net_guest_notifier_mask()
checked VIRTIO_NET_F_MQ to know there are multiple queues, but
VIRTIO_NET_F_RSS also enables multiple queues. Refer to n->multiqueue,
which is set to true either of VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is
enabled.

Fixes: 68b0a6395f36 ("virtio-net: align ctrl_vq index for non-mq guest for vhost_vdpa")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9959f1932b1b..a6ff000cd9d3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3426,7 +3426,7 @@ static bool virtio_net_guest_notifier_pending(VirtIODevice *vdev, int idx)
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc;
     assert(n->vhost_started);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
+    if (!n->multiqueue && idx == 2) {
         /* Must guard against invalid features and bogus queue index
          * from being set by malicious guest, or penetrated through
          * buggy migration stream.
@@ -3458,7 +3458,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc;
     assert(n->vhost_started);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ) && idx == 2) {
+    if (!n->multiqueue && idx == 2) {
         /* Must guard against invalid features and bogus queue index
          * from being set by malicious guest, or penetrated through
          * buggy migration stream.

-- 
2.44.0


