Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789B0C531D0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 01:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnnfz-0003l3-7g; Sat, 25 Jul 2026 21:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wnnfv-0003ka-4G
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 21:29:07 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wnnft-0002zo-KC
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 21:29:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so1280633a91.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 18:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785029344; x=1785634144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WF3W8UKvcVhATzzm0eWYHT+Eir5x6mRm7JUu5U2gmNQ=;
 b=HczfAqOIkS/GjTVnQBIvHT1b5mLpF7Gvwd7kgQg3/UKHiMlJcGaI/zTrlo4+Rsc3RJ
 I0JIaLTYYEywu5WG1oWb6XiG6Y2dWORkWKZXN/cj38fyfdgN8iy7iVgyqYZIVnQLbUCg
 6cpt/+bVDtVSEkwOX58p9X+U4/0epBem/WjE5igi81PHwZEUyn0UMi8JNegd+Ezde4k1
 3tjYz6HbIbSCHB63FgVZ1us3evnsgfRGjiRrDr9HIj9fHT7jpJQj2lHj6srmz2CPh43d
 q23y3Eyt02MtxMnohq2F5RPW44HKmnEUe0FlIJbokeQVuGwxRIAa1B/teH0pAhw4MEZA
 RLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785029344; x=1785634144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WF3W8UKvcVhATzzm0eWYHT+Eir5x6mRm7JUu5U2gmNQ=;
 b=rKCM4yY8FDQ7380HaMNJjlnuh1DqbbF2d2KOCbQDEohgzMvOLjxcSk45MxarFiduGP
 g4GtUnQOWtfNjlGTjCEyaFLEbWHqwu/XM1B/iGFIZW0lq8tW9peqCH96Qsz7DUZhJEtf
 zHskgY/xBRkm13iB3/xu/beOHaSN6ejBxjjE7UoZEK98wA3kgOjIAPNlaXkFESdeYiq0
 tdV8SyEH9zRA3vwnUBBKI1IkRfbvaPRszAqrWfzRicB7p9bfp/gU8oIWD26Uco6eW2O2
 ntmrfmz29A5Zim2FqYo/AW7+MvJxhDaZxCZu6FTQ8ObpSnIEfs5IVo8IKMnvNogw4rpX
 gToA==
X-Gm-Message-State: AOJu0Ywk34vjsC7gVTQ4PCCMdemQtlS6WePOOWkzappWDM6cc66cgDdK
 i0Sp909RKHAGb5CFbpLXr7P/hmBgGsd7dlOclRi4tu2O+/rxw2ba0RE9GK0EA0CjN2o=
X-Gm-Gg: AR+sD10CZdJ68Ot/X/UQ2R18x9FtWmmzTQC7+U+042RX4GBudnygpqzLbv0kvIXcmQe
 RwAPxgUeVXTRDlLwE2g5GaLkLWaJ0gvS3tZAcInOeUfWvHZBE8D4Ae4JtoP4xkSBXR9sv0KjvXf
 /R0sdga8aHdXcYGrDrDEmkHLTfMDSPYW11RBz2BkifwScdCbD813uS08KTlxEAJNKU8VyOPhdVr
 2b6u6QmGdz7sSCLWI7p0rXukzA6nlpSv8IviUEtj5KQzdnAEr/c9+OXzWnUOazLUG/jPp8b4YvA
 YF/q8kzcAq2CpoPhfdqzKMRgW1UJoA3FrBeeMcwK95+hOXnGpvsr6SKPSf2ielV2Pz3Jfvhaz45
 Gt9PE/qhVXsXL+ufQPI2A8pWcJ0/DtnJv0Cy9KqQoxau/4v9X2LZrc8+9xUEcQAY5XhoIXS5QI3
 pmsg==
X-Received: by 2002:a17:90a:d64d:b0:36b:de66:92c3 with SMTP id
 98e67ed59e1d1-38f1eea8b7fmr5836659a91.10.1785029343755; 
 Sat, 25 Jul 2026 18:29:03 -0700 (PDT)
Received: from gmail.com ([188.253.12.32]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc419e3asm15159559eec.11.2026.07.25.18.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 18:29:03 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@kernel.org
Subject: [PATCH v3] virtio: reduce code duplication for split ring
Date: Sun, 26 Jul 2026 09:28:57 +0800
Message-Id: <20260726012857.1580646-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260725112924-mutt-send-email-mst@kernel.org>
References: <20260725112924-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=physicalmtea@gmail.com; helo=mail-pj1-x102b.google.com
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

virtio_queue_empty_rcu duplicates virtqueue_num_heads
for no good reason, let's not do it. As a nice side effect,
we gain better handling for misbehaving guests.

The virtio_device_disabled() check in virtio_queue_empty_rcu
is redundant because virtqueue_split_pop() is only called through
virtqueue_pop(), which already performs the check.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v3:
- Rework the commit message to describe split-ring code deduplication.
- Explain why the virtio_device_disabled() check is removed.
- Drop the issue link because this patch addresses the generic split-ring
  path rather than the virtio-iommu command-processing path.

 hw/virtio/virtio.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f4d86a3655..68ec3f0751 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -716,26 +716,6 @@ static inline bool is_desc_avail(uint16_t flags, bool wrap_counter)
     return (avail != used) && (avail == wrap_counter);
 }
 
-/* Fetch avail_idx from VQ memory only when we really need to know if
- * guest has added some buffers.
- * Called within rcu_read_lock().  */
-static int virtio_queue_empty_rcu(VirtQueue *vq)
-{
-    if (virtio_device_disabled(vq->vdev)) {
-        return 1;
-    }
-
-    if (unlikely(!vq->vring.avail)) {
-        return 1;
-    }
-
-    if (vq->shadow_avail_idx != vq->last_avail_idx) {
-        return 0;
-    }
-
-    return vring_avail_idx(vq) == vq->last_avail_idx;
-}
-
 static int virtio_queue_split_empty(VirtQueue *vq)
 {
     bool empty;
@@ -1748,12 +1728,14 @@ static void *virtqueue_split_pop(VirtQueue *vq, size_t sz)
     address_space_cache_init_empty(&indirect_desc_cache);
 
     RCU_READ_LOCK_GUARD();
-    if (virtio_queue_empty_rcu(vq)) {
+    if (unlikely(!vq->vring.avail)) {
+        goto done;
+    }
+
+    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
+    if (rc <= 0) {
         goto done;
     }
-    /* Needed after virtio_queue_empty(), see comment in
-     * virtqueue_num_heads(). */
-    smp_rmb();
 
     /* When we start there are none of either input nor output. */
     out_num = in_num = elem_entries = 0;

