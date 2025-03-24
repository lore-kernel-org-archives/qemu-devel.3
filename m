Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E0CC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiOG-0008Hb-1w; Mon, 24 Mar 2025 10:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLx-0006zn-13
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1twiLv-0004MZ-3w
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:00:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223a7065ff8so7856035ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824830; x=1743429630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiWVq15fSavNuaKQm+AIHprYBwqyY4jhII+q8wn+eAU=;
 b=RrfqVpx3AWYyut/pMIXoAYwSKssjwu2FotfhhudvLMiG8Q9zLUxWLwjYwcXdM1huJB
 v8IxnCxHc9UMLAmtgUg1UDrU9fj2WKKkXa/sze/HDlOaHAqHlWTpy3zoRJU7xw6Eg236
 FVYZOgLAxJ92cMG2idtnGBQI/bIK+bhFrkvPDJ1iVEHBaNlx7NCaXAFoZdJ2V/4cGfpk
 DF49HZT6mTqzLqWmhZrMR1D8wxKgm0+04sePQ0D5Nl8upOIprzJpfPBpGZvUXBOam8K3
 y52Nzxg/mWeO5AJZYFdfvKBq3CfEO9662BoJ2G+0SsSsXmJrwh++Fnr4odpUiOfVmul5
 x9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824830; x=1743429630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiWVq15fSavNuaKQm+AIHprYBwqyY4jhII+q8wn+eAU=;
 b=lqM7NLZ2Uw1dZ3X4diAAuRhs+T84oU7JC8s3yDXv5zTSYDvp8PkWgYwBAgqwfY/MLb
 PB7HDMjMi3Y7XlqFifkGpK4MByqTh4FTbBNe2SNOkJXPVYoIjaZ+nWfZjXRxLxCGmZcP
 nuUx+LC3QWKPPmcfaduYynKshZZiFAer5xBjGvXUMfDwZEavWRLQ0pwBvqu1STkNIUwE
 UwhmCTHXIN4kdRoSahjQ/vl7CXXetsXzc1cJJN+dnEr4/1uERX2xB5vwwiAVtu0rdWfR
 nU3HQoETZWwPmnK4vBhWimsmenHIvTDNZvjmvCL7hQqPUPB6nmxBLRcEH11+vZz8G6gN
 8NPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg7AwZrDreIe3otgaZWDf858i4dcd3MZ7p9vz+hGUqVmegkCOv1GwNMMfMIPtbQUVXqGmXDEJ+gV95@nongnu.org
X-Gm-Message-State: AOJu0Yws3DBNdMX6pH+95zeg/faWuEyAbWiwGf9Yo9z0Zzo6YNwcqBnd
 s0wZVPPHnfc5w1ihwUd8rhZr95aIaEVqwajmQo6U1uBZX0AF7q8K
X-Gm-Gg: ASbGnctNk/+PrUjHez9KggDHlgmWQ1U/ERPMNBoY7byNOeUjXpdPUojLse0G/FrXnBR
 CtKkYrk+WGNQVVk1SamX/DSxii0DZQ+2BK2QwFLnGdn470nj+5ZlWyfZRhv41h6pJwptVK6lTc4
 MZLzrjbKDGmJwsb8IO0lmdu+sYET3EoE3wf0usmoozLwsOIRqsi8njGpojwQdvI3Z/JfKuPdWNS
 YZt20Ky/TdbCSGuCPNrY2DnuwTH35omYPaybGigaSwP6eIbjiS2bnlSxD7Y59VAZnA2NG+48The
 llVfXa/XF9D2kWuCXYzbmR6WP13qn+Z/88Y9ZUY=
X-Google-Smtp-Source: AGHT+IEaTgOsnqV3CAmI68l4AO/n4qWsmnLdT3lPSos4DXAiq//Iyz16AaIvn16+M42TctvhCiO2Zg==
X-Received: by 2002:a05:6a00:b4a:b0:736:4cde:5c0e with SMTP id
 d2e1a72fcca58-7390597496cmr18979713b3a.10.1742824826328; 
 Mon, 24 Mar 2025 07:00:26 -0700 (PDT)
Received: from valdaarhun.. ([2401:4900:1c7e:7fd6:5c7b:30a9:c6b6:f81d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390614afb5sm7870544b3a.121.2025.03.24.07.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 07:00:25 -0700 (PDT)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	sahilcdq@proton.me
Subject: [RFC v5 7/7] vdpa: Support setting vring_base for packed SVQ
Date: Mon, 24 Mar 2025 19:29:21 +0530
Message-ID: <20250324135929.74945-8-sahilcdq@proton.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324135929.74945-1-sahilcdq@proton.me>
References: <20250324135929.74945-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit is the first in a series to add support for packed
virtqueues in vhost_shadow_virtqueue.

Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial
state after reset") enabled the vp_vdpa driver to set the vq state to
the device's initial state. This works differently for split and packed
vqs.

With shadow virtqueues enabled, vhost-vdpa sets the vring base using
the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
differs for split and packed vqs. The implementation in QEMU currently
uses the payload required for split vqs (i.e., the num field of
vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
payload is used with packed vqs.

This patch sets the num field in the payload appropriately so vhost-vdpa
(with the vp_vdpa driver) can use packed SVQs.

Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
Link: 1225c216d954 ("vp_vdpa: allow set vq state to initial state after reset")
Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
Changes from v4 -> v5:
- Initially commit #5 in v4.
- Fix coding style of commit block as stated by checkpatch.pl.

 hw/virtio/vhost-vdpa.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 58c8931d89..0625e349b3 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1265,6 +1265,21 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
     };
     int r;
 
+    /*
+     * In Linux, the upper 16 bits of s.num is encoded as
+     * the last used idx while the lower 16 bits is encoded
+     * as the last avail idx when using packed vqs. The most
+     * significant bit for each idx represents the counter
+     * and should be set in both cases while the remaining
+     * bits are cleared.
+     */
+    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
+        uint32_t last_avail_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+        uint32_t last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+
+        s.num = (last_used_idx << 16) | last_avail_idx;
+    }
+
     r = vhost_vdpa_set_dev_vring_base(dev, &s);
     if (unlikely(r)) {
         error_setg_errno(errp, -r, "Cannot set vring base");
-- 
2.48.1


