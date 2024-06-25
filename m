Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D586C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2nU-0007jb-Pz; Tue, 25 Jun 2024 05:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sM2nT-0007iq-B3; Tue, 25 Jun 2024 05:49:07 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sM2nR-0003Fe-I2; Tue, 25 Jun 2024 05:49:07 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c2177bf7a8so102088eaf.2; 
 Tue, 25 Jun 2024 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719308943; x=1719913743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ScpTwYEgj3XP1Q2imqxoItyBRdYB3AJf+gJpu+LZmxg=;
 b=McK/1NZt4R+SctpChBrf/NBWTcSESz5xcnbOzd7wE7CNDyYJr7zp65rj5oL5o0CqIe
 Fjul8d7lsL4j7jxrSNI37k72AnxvSiSCHZ1O3+v91c/rvyHC4Ck9P/Kh39f4nk2i/opK
 plbpNMHBxO1vSRORHAZ1IZwn8X3r7KDHJiVShDkvw0gc+VIhdr/e+kFm6fRcKbTo1MTr
 eKCl1h+qbX37o6yPP4L0z/TEND7bmTda82JsNkSuCeYg1KwpyuuIDDrvphNAXvuEkuS/
 Nwwhfsr+Wc6LmENM/XpkSJXVov8Yo9ix6H2mBRPV7Qg2MuwkMDItO2JAImtjl+tsdt7z
 Yocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719308943; x=1719913743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ScpTwYEgj3XP1Q2imqxoItyBRdYB3AJf+gJpu+LZmxg=;
 b=xTiuegUzQqYJs+X1g/+yYmFZfiahvCgmC5fQprfMGbRcVwspuaYKq9FeFaH1fJOtkF
 tdwb8sbtRnY88IrbrjAtdSmj5gGy2h/Yz84crKM0BrLmaDqElDx9DVoRgJFrF8i9bWk6
 tVTa5OFDZdhAHth5vPZZzAz1b7Ehh87WQmQw2AzsifUqZVt8sAXoeZ1EHSXCD52ZSsMH
 /0atd+P33FZANQ8I+7dt4vp0GjpSG8+Q1vB379vUbdPr6ZW0BgtBDnCB2+k1dJW88Ldl
 Lb9BVM29hdnjqFH1RTA3BH6zMESJDJme9atFfw6GbEUFuaKNLJ2AAAQA03Os0aKipnGg
 OAZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNS/6zxYv9gw5e6ShJqadspu/j0rXMQXfB0qICfyPW9XktVln8O6YCylpHgwwlcZZFIknGLWl9CpF+iOS1ncFqwW6iiXBT
X-Gm-Message-State: AOJu0YwX+82Wd7Yug60nPUN8dMfIvbJnslGl8zUdd5dOx2H2J92QxFd4
 62Dd/YeDqi1oTgV82ydOOslMc7GWzR4ukpewQWwvJEyI196fHwsXgpRtgwVP4+o=
X-Google-Smtp-Source: AGHT+IG+NAHBxlhvrocSQH+QlSRJ/ve3AiLibaLODN+W/a9pusNx8K2d+xmAeWAyX7N5mSMeJgyLkw==
X-Received: by 2002:a05:6870:1602:b0:259:8c82:999 with SMTP id
 586e51a60fabf-25d06cd3dc7mr8321740fac.25.1719308942746; 
 Tue, 25 Jun 2024 02:49:02 -0700 (PDT)
Received: from localhost.localdomain ([118.242.3.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70672e24d7asm4784363b3a.114.2024.06.25.02.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 02:49:02 -0700 (PDT)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, qemu-stable@nongnu.org,
 thomas <east.moutain.yang@gmail.com>
Subject: [PATCH v4] virtio-net: Notify the guest with the latest available idx
Date: Tue, 25 Jun 2024 17:48:51 +0800
Message-Id: <20240625094851.5252-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: thomas <east.moutain.yang@gmail.com>

Patch 06b12970174 ("virtio-net: fix network stall under load")
added double-check to test whether the available buffer size
can satisfy the request or not, in case the guest has added
some buffers to the avail ring simultaneously after the first
check.

It will be lucky if the available buffer size becomes okay
after the double-check, then the host can send the packet to
the guest. If the buffer size still can't satisfy the request,
even if the guest has added some buffers, notify the guest
with the latest available idx seen by the host, similiar to
the action taken by the host after the first check, else
viritio-net would stall at the host side forever.

The case below can reproduce the stall.

                                       Guest 0
                                     +--------+
                                     | iperf  |
                    ---------------> | server |
         Host       |                +--------+
       +--------+   |                    ...
       | iperf  |----
       | client |----                  Guest n
       +--------+   |                +--------+
                    |                | iperf  |
                    ---------------> | server |
                                     +--------+

Boot many guests from qemu with virtio network:
 qemu ... -netdev tap,id=net_x \
    -device virtio-net-pci-non-transitional,\
    iommu_platform=on,mac=xx:xx:xx:xx:xx:xx,netdev=net_x

Each guest acts as iperf server with commands below:
 iperf3 -s -D -i 10 -p 8001
 iperf3 -s -D -i 10 -p 8002

The host as iperf client:
 iperf3 -c guest_IP -p 8001 -i 30 -w 256k -P 20 -t 40000
 iperf3 -c guest_IP -p 8002 -i 30 -w 256k -P 20 -t 40000

After some time, the host loses connection to the guest,
the guest can send packet to the host, but can't receive
packet from host.

It's more likely to happen if SWIOTLB is enabled in the guest,
allocating and freeing bounce buffer takes some CPU ticks,
copying from/to bounce buffer takes more CPU ticks, compared
with that there is no bounce buffer in the guest.
Once the rate of producing packets from the host approximates
the rate of receiveing packets in the guest, the guest would
loop in NAPI.

         receive packets    ---
               |             |
               v             |
           free buf      virtnet_poll
               |             |
               v             |
     add buf to avail ring  ---
               |
               |  need kick the host?
               |  NAPI continues
               v
         receive packets    ---
               |             |
               v             |
           free buf      virtnet_poll
               |             |
               v             |
     add buf to avail ring  ---
               |
               v
              ...           ...

On the other hand, the host fetches free buf from avail
ring, if the buf in the avail ring is not enough, the
host notifies the guest the event by writing the avail
idx read from avail ring to the event idx of used ring,
then the host goes to sleep, waiting for the kick signal
from the guest.

Once the guest finds the host is waiting for kick singal
(in virtqueue_kick_prepare_split()), it kicks the host.

The host may stall forever at the sequences below:

         Host                        Guest
     ------------                 -----------
 fetch buf, send packet           receive packet ---
         ...                          ...         |
 fetch buf, send packet             add buf       |
         ...                        add buf   virtnet_poll
    buf not enough      avail idx-> add buf       |
    read avail idx                  add buf       |
                                    add buf      ---
                                  receive packet ---
    write event idx                   ...         |
    waiting for kick                 add buf   virtnet_poll
                                      ...         |
                                                 ---
                                 no more packet, exit NAPI

In the first loop of NAPI above, indicated in the range of
virtnet_poll above, the host is sending packets while the
guest is receiving packets and adding buf.
 step 1: The buf is not enough, for example, a big packet
         needs 5 buf, but the available buf count is 3.
         The host read current avail idx.
 step 2: The guest adds some buf, then checks whether the
         host is waiting for kick signal, not at this time.
         The used ring is not empty, the guest continues
         the second loop of NAPI.
 step 3: The host write the avail idx readed from avail
         ring to used ring as event idx via
         virtio_queue_set_notification(q->rx_vq, 1).
 step 4: At the end of the second loop of NAPI, recheck
         whether kick is needed, as the event idx in the
         used ring written by the host is beyound the
         range of kick condition, the guest will not
         send kick signal to the host.

The patch notifies the guest with the latest avail idx seen
by the host in the double-check, which increases the
probability of hitting kick condition, but logically
speaking, it can't resolve the issue. It's kind of
optimization agianst patch 06b12970174.

Changelog:
v4:
- Correct spelling mistake in the subject
- Describe the issue that virtio-net is blocked at host side

v3:
- Add virtio-net tag in the subject
- Refine commit log

v2:
- Add SOB tag at the end of the commit message
- Place Fixes tag at the end of the commit message

v1:
- Initial patch

Fixes: 06b12970174 ("virtio-net: fix network stall under load")
Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9c7e85caea..23c6c8c898 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1654,6 +1654,7 @@ static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
         if (virtio_queue_empty(q->rx_vq) ||
             (n->mergeable_rx_bufs &&
              !virtqueue_avail_bytes(q->rx_vq, bufsize, 0))) {
+            virtio_queue_set_notification(q->rx_vq, 1);
             return 0;
         }
     }
-- 
2.39.0


