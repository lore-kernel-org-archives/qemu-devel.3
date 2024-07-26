Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4960C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXHik-0005US-TI; Fri, 26 Jul 2024 05:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHii-0005Tt-Qi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:58:40 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXHih-0006KB-10
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:58:40 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-793a3a79a83so540440a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721987917; x=1722592717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5wS2iNZLKHzS/d2RSYSd4vdOsuDlJE2eZy/z2u8PnlA=;
 b=aPW+MsFp4wtAnGnvpoTz3DVX4V13r1+8oSCo78FfRXi4BNWv5cwzUmKjS/cOE7jxZm
 hSbJ9z37pvnGRc3GTReMVAObE/qA72r8EmAVQ3sP9WZOXEBZ/pJIEFr08DJ35eNmPb/g
 RJj6XsEgzhyJ3LMHN/lP+5qsU8L3/qSQaQc9TO4U47CrcxY276TWHYiBHGxA44hjfa/v
 PUMTxaFhlI+IzSwy2TONW1cTHutjWxzGp+Z2xXETuxxNqXr+5r8HkjgNNZtO1zOWu9js
 yJdd0r2gvQH671QuUiNKTGfmrHTunhYl1fMuiA1bDHIihsmj0hLziKnCTu9TJ3QJ+J65
 V6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721987917; x=1722592717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5wS2iNZLKHzS/d2RSYSd4vdOsuDlJE2eZy/z2u8PnlA=;
 b=pvkjNZX8PcaSvE7xqrBc/BZ1CSgNvT5u/3YmTRD8zKef0kAAgHDTIWFVRbrTcE8sWv
 6moWgiAtdZ0oMM3AIXFht0iypxBx8spQFnUlKaFh+zotb2pbL/iTPg7cZsywfxd4WiBT
 XLrJxRV2/E30P9f+3J4aNJTWLT8Jn5MYWxwsNrZFPhEXeMPD/umCaXjaaXTd1/dTxWYZ
 kj3EqBMAZcJUnoKZwI7MfuUObMn5OgxdK58bEvCaeGgElvgZi5JCxIBAtLAZnBVUtO5K
 yFY082XD+li0fW+KeqoHFmwi+N1OoDHvmIN037AjYfiPRoogtdRVEBiNkE+PseOECfp7
 UjFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcLE7yDrU1ScW6zpIM4f56AUNQJD02UuiBnZtGa5P9VDnXAOpPIdP13BnOfik/sP8F9pMZd0bW06VKPReM1oyPbsNfw9k=
X-Gm-Message-State: AOJu0YyjY/VCJ6rA8r/ae/n2IG2tt4cVkhS5IsGRyCEtjtn1t1ev5qM5
 9P1fp+mNJWeo9xBxuxknnF9q/WSRFYBEIr9ILYsVnIHB/vG8VVXB
X-Google-Smtp-Source: AGHT+IF+U/VriXetyvxky7TvBCNYINCNakf/mljAMBm6BgPgT3CZluC8K4zpN4HzLbOei5rse7XycA==
X-Received: by 2002:a05:6a21:9984:b0:1c2:8c22:500b with SMTP id
 adf61e73a8af0-1c47285e43dmr7549723637.13.1721987917065; 
 Fri, 26 Jul 2024 02:58:37 -0700 (PDT)
Received: from valdaarhun.. ([223.233.82.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fcd252sm28201655ad.285.2024.07.26.02.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 02:58:36 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v2 0/3] Add packed virtqueue to shadow virtqueue
Date: Fri, 26 Jul 2024 15:28:19 +0530
Message-ID: <20240726095822.104017-1-sahilcdq@proton.me>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=icegambit91@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

I have made some progress in this project and thought I would
send these changes first before continuing. I split patch v1 [1]
into two commits (#1 and #2) to make it easy to review. There are
very few changes in the first commit. The second commit has not
changes.

There are a few things that I am not entirely sure of in commit #3.

Q1.
In virtio_ring.h [2], new aliases with memory alignment enforcement
such as "vring_desc_t" have been created. I am not sure if this
is required for the packed vq descriptor ring (vring_packed_desc)
as well. I don't see a type alias that enforces memory alignment
for "vring_packed_desc" in the linux kernel. I haven't used any
alias either.

Q2.
I see that parts of the "vhost-vdpa" implementation is based on
the assumption that SVQ uses the split vq format. For example,
"vhost_vdpa_svq_map_rings" [3], calls "vhost_svq_device_area_size"
which is specific to split vqs. The "vhost_vring_addr" [4] struct
is also specific to split vqs.

My idea is to have a generic "vhost_vring_addr" structure that
wraps around split and packed vq specific structures, rather
than using them directly in if-else conditions wherever the
vhost-vdpa functions require their usage. However, this will
involve checking their impact in several other places where this
struct is currently being used (eg.: "vhost-user", "vhost-backend",
"libvhost-user").

Is this approach alright or is there a better alternative? I would
like to get your thoughts on this before working on this portion of
the project.

Thanks,
Sahil

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg03417.html
[2] https://gitlab.com/qemu-project/qemu/-/blob/master/include/standard-headers/linux/virtio_ring.h#L149
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vdpa.c#L1178
[4] https://gitlab.com/qemu-project/qemu/-/blob/master/include/standard-headers/linux/vhost_types.h#L30

Changes v1 -> v2:
* Split commit from RFC v1 into two commits.
* vhost-shadow-virtqueue.c
  (vhost_svq_add_packed):
  - Merge with "vhost_svq_vring_write_descs_packed()"
  - Remove "num == 0" check
  (vhost_svq_add): Use "is_packed" to check vq format.
  (vhost_svq_get_vring_addr): Rename function.
  (vhost_svq_get_vring_addr_packed): New function but is yet to be implemented.
  (vhost_svq_memory_packed): New function.
  (vhost_svq_start): Support packed vq format.
* vhost-shadow-virtqueue.h
  (struct VhostShadowVirtqueue): New member "is_packed"
  (vhost_svq_get_vring_addr): Renamed function.
  (vhost_svq_get_vring_addr_packed): New function.
  (vhost_svq_memory_packed): Likewise.
* vhost-vdpa.c
  (vhost_svq_get_vring_addr): Rename function.

Sahil Siddiq (3):
  vhost: Introduce packed vq and add buffer elements
  vhost: Data structure changes to support packed vqs
  vhost: Allocate memory for packed vring.

 hw/virtio/vhost-shadow-virtqueue.c | 161 ++++++++++++++++++++++++++---
 hw/virtio/vhost-shadow-virtqueue.h |  76 +++++++++-----
 hw/virtio/vhost-vdpa.c             |   4 +-
 3 files changed, 198 insertions(+), 43 deletions(-)

-- 
2.45.2


