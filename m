Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B483C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 08:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLev3-0001Mw-Ju; Mon, 24 Jun 2024 04:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sLev1-0001MP-VJ; Mon, 24 Jun 2024 04:19:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1sLeuy-0002Lm-0Z; Mon, 24 Jun 2024 04:19:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70661cd46d2so1615585b3a.3; 
 Mon, 24 Jun 2024 01:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719217152; x=1719821952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xa9gOQbch3GyDxH5J1WodcDLw0cPlXyyzJDGEorcivA=;
 b=cQxlJCTFhacTEU3kuAhr8nkm/m1BkmYDs0CqrqO2X4hA9dTqXYF7l6x5eMVVhfxlow
 Uuz2mkUkOqV3SvulviQ67L83nBUUqA6+Axr5JEG3EkLAd5oPVbWvUBZNn0F59ErCnCl3
 9tvmlEtsmIC3O6cnPdmULPuHNqCRKUM68eAS9DCNuvSJLYkkQJRuSTTvawpxmoVmCcH9
 HqiuA42eR0s8XDHd+4r3WcfYoEmEdoiMQrysURowqRMrogJs7FNZ5wlwf+54GhX1xBZN
 Vra6olge9kYMrHSkH4CgT+xcMKFm2U8x8Wu4JyKZSXdmKyr/z+UjEbRM7uknPQmzuBUF
 XfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719217152; x=1719821952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xa9gOQbch3GyDxH5J1WodcDLw0cPlXyyzJDGEorcivA=;
 b=fiIXATVTk9imDPQzczGlrTbhEThJFP2zKamtVvI7Jvw94cLG9KTlS6Jne+rRbG/fp9
 P8ki0riPx0qTgfUK/tu2q0tuWhdAQDJu2Vm0VP3eLVbd0rAvQ/Tu+F+XesgEc/69GScU
 rXX4Nl9C0EnvDLgh7yP8nDyGgZTjyxHqUOVklijrAdS4/dsImlEqsvu9KSQ2jv5rxIeK
 7AFRp7NXm/B+XP2k8uvI26ObFSkCo+rhNe7ClHeFRoLadJ+w3pzJ4eIlT2NOwB/0lEP6
 v1MiFmGYhw+O7556uj+s2td+OihIK7GkVlf8I0HsYDotR3GvC7L2RSfHmmgLFAosEHrh
 5lDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3+jR1iaykRgZcFq+HV2iFAnirrrucDprST5bzbFVfb9rPO1w4p8pZ6l8moXtVkm7LtrexjrS7HyVC2z4LS6X/qs05Al9Z
X-Gm-Message-State: AOJu0YxtSZgUGeqQp7ybeC9DSeljBzx7kvR3uzTkFvR6Ttyzg5EMyGfK
 jt+pwqcpZL06Xh5GLx5Vt9BA/f5jASAmVUQfdWfKjPbwOfaD3d4NVUO+9mu0
X-Google-Smtp-Source: AGHT+IGwwy60iw4qEDDSJjzejELGhtlC9srfKyXPk5Eg2lWSjapI3pdrwqMIXmo9X9VYVMuiGTwTzw==
X-Received: by 2002:a05:6a20:2981:b0:1b8:4619:eba1 with SMTP id
 adf61e73a8af0-1bcf4645c52mr3160806637.59.1719217152449; 
 Mon, 24 Jun 2024 01:19:12 -0700 (PDT)
Received: from localhost.localdomain ([118.242.3.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3d4ba8sm56800245ad.196.2024.06.24.01.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 01:19:11 -0700 (PDT)
From: thomas <east.moutain.yang@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, qemu-stable@nongnu.org,
 thomas <east.moutain.yang@gmail.com>
Subject: [PATCH v3] vritio-net: Notify the guest with the latest available idx
Date: Mon, 24 Jun 2024 16:19:01 +0800
Message-Id: <20240624081901.38956-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-pf1-x435.google.com
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
the action taken by the host after the first check.

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


