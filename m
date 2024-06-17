Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1F6C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 05:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ5Bv-0001eU-9F; Mon, 17 Jun 2024 01:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sJ5Bt-0001di-CY; Mon, 17 Jun 2024 01:46:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sJ5Br-0004ty-Uq; Mon, 17 Jun 2024 01:46:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso32936905ad.2; 
 Sun, 16 Jun 2024 22:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718603160; x=1719207960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u1YMUclD7K+Lvt+g4sfxbER6myR58HfuHWxJNWm2Fds=;
 b=jyzFJFCyvZ3FmwMr4ErEw+d+W/qBnWKcDjKstH1V9kTx2s4Ch7sO0WULp7DF1wSpva
 6KeD4thgLLZXEKnmf13vqey2JlidQCphdEwVfX3pGoP+BVEvVoJaBhZFlsgGMLpeDtnc
 A7T8uoqTHFuvVERcExGzhT1oMyLtgLeHCTMD2xhD/48K6rhyEAnuKwmQNwT1DX+TzhLj
 547KVmV8BovLtxXNiyBFP9KHNflqF5VcaXKOsbXqWpZBaVSVxjh35KgAKAgDV+dTCnXX
 156uIsT3EjGR740PXOWBJA1KMRiWsdYp/JyZbfqAf3BCILektJZRORqmhf8t0H1/RkUZ
 P3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718603160; x=1719207960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u1YMUclD7K+Lvt+g4sfxbER6myR58HfuHWxJNWm2Fds=;
 b=jD6rsU5PKGJLbUXrrB3IdODBxxe5gYC7E8w9AUBlRePDsIlP6JIXmd0IBdOqbzbSKe
 FPaR3eKRfGjR6bb79Ibe4VQHPAmw51diVnW3ZvMXbkigb7/yYFysN2/DcV5PKQC6GPd2
 wyYcR24BkVM0ukZ2pQ5+fsOSKFOaIAwpbwsYENW+TPvXiyYsFHj/uArSjHyVdnrGbXit
 eViPrJZDayoxoDTs15Fi21oVPMq9V3PiNcp+uMkLnbZBNSCLOW+3zdFlCH3GF39/gDUl
 Iq4ZikecQPFfo8mWXmXJIkDYttHzI80LLACUdr/gqC/R05iQMO2DkqceTmuGSXJHoz0w
 TzJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWE22tYVFCB+Y1XXzR/FzZyEBwDgUJzExnegnoSir/Mf923VbRbLiX+JfyXdMQlW9cdbnBjTlcZTJtgX1Xexr74tl+A8To
X-Gm-Message-State: AOJu0YzXtcD0VL/90JOghh1u19B5V8aqTylXC+bwwNp7+or4p4htShCi
 e3pLVMO+S7u1MkEl9MOYvx+CsgrpA7IJdI2wq+UhLtmNmaFrhqnuohIM6U14
X-Google-Smtp-Source: AGHT+IFsQMzliLmaItUQqhx8S1HlVkC+HnBNxxSPPYOnOcaXl5hss/NUVi/pNV4VgMvqKqRzxJ4UWQ==
X-Received: by 2002:a17:902:7c07:b0:1f7:2a95:f2d7 with SMTP id
 d9443c01a7336-1f862b1b2bfmr70735085ad.59.1718603159923; 
 Sun, 16 Jun 2024 22:45:59 -0700 (PDT)
Received: from localhost.localdomain ([118.242.3.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855eeaa07sm72667935ad.157.2024.06.16.22.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Jun 2024 22:45:59 -0700 (PDT)
From: thomas <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, qemu-stable@nongnu.org,
 thomas <east.moutain.yang@gmail.com>
Subject: [PATCH v2] Update event idx if guest has made extra buffers during
 double check
Date: Mon, 17 Jun 2024 13:45:51 +0800
Message-Id: <20240617054551.20524-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If guest has made some buffers available during double check,
but the total buffer size available is lower than @bufsize,
notify the guest with the latest available idx(event idx)
seen by the host.

Fixes: 06b12970174 ("virtio-net: fix network stall under load")
Signed-off-by: wencheng Yang <east.moutain.yang@gmail.com>
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


