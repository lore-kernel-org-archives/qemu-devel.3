Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ADAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5m8-0008LV-Ia; Fri, 10 Jul 2026 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wi5m6-0008Jz-By
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:35:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wi5m4-0007OX-Ph
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:35:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c6b67d5fa1so10539705ad.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783668951; x=1784273751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tu1jPSlG9trs9p1666Fvux8qmMlQo+f+tnnrgszfoJM=;
 b=SbyRR00eIBzW3G3UDQ6uPWMN9jKukaJyslDCuE4MiFuqmATvAFy81mpTaaC162AdFY
 zjYSPT47vAEip56eYkoEq3CaLa+WPSPumK/HCxUjH9GlWsKTdDVx9nsAeMh76cu2l9Uq
 SJ4tbJQjXzHK7y31xllx6VOgTiqXDd7+0Uw5BZfgcJX71+w6Nd9BhWoLs4UGcCKpQGPi
 vTYg3YqJWm0q+gkMSCTnxkdIqiKVOD5iDddgK2jbqK0/lQIWcQPSEsn0oFVUFxdqVoxh
 Ybmfnl5mXASw5a+bLRJFOzEfXHfJoW41qSdbw0MbTqB+1cdz5THb8I+7QAckx6ChHTT4
 WN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783668951; x=1784273751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tu1jPSlG9trs9p1666Fvux8qmMlQo+f+tnnrgszfoJM=;
 b=Dewhsqi8dY6p76LAHyG6q0Gr5dt/VD/qhXRGuno66fU7ugBtPWENjfHMbkl0XdGfFl
 8b9TEKEccmEF5mhoDhTbw1YRH0BncCQ6sglVGZyVx611Nt+Q0AEaK3W5eqii5thiYc0d
 pXF/D0NGYBzAFXXCjW7MGpkHi6cgKEfiA1QZxX+FQ1iOWzpVM4QJUxYGgpBz9HLiyFa2
 hdjed6K4RLn2uA/4gdWx0YCFY+RkXI8mxoOyJUMiD4OA1taVTsTc83+eDDsM27eZizwz
 LfX2+ABrya3524wfJKeUQCoGas8DyI1SO0kOzihNq4tDiEm34bZd7SvAS79Xo8iqauE/
 EAvQ==
X-Gm-Message-State: AOJu0YxcI48VVrUqKM+usDFRJTnfdIzJZ+nCYAQg8mXItZ/sC+qmlSP+
 OQFbo5VzKl42wW0LaLZxroVOrxqPgt+SxUw8aUQPoAY/JIsOvJfvLq/T8vVjMb3h
X-Gm-Gg: AfdE7cmu9M+rCpIIDTGLhdyywWOQk+xffwYlgEKlb02VvpaBbhLrNdiwYD4uM235Am+
 Wv7lvq4T5BsGMvdrdFGkehdadgwgs67Vu7vmvVVW9MaNky870VrZIq7KxITsd5IYtHgA1I0rxJy
 2d1k5eu7gLsu6srk1wToV7ckQvqURST3ob2+FRK214dBJNG8kIZRnY/xq00/bOX3E0A+DyWqabx
 WhJVGY5kNFJU78CoqO3Or1Z3vHQi94qlO/00HYHB8FV96gnC7Nb47NqxnTWbXm6NE83XF7G6zrL
 s43M6Xd6RnlNu+KHuNTK4CvqTo+cDetKrWc/SluYB5BlRXeM487ZhIXrkPtqSeqiWdehxlpRVy6
 XBnnbFiRKSzF6sQro2MrzN7P2rQAdMHfkFPk/BLlGDUFC0Q/OHf10Oald3Xagc//6wdd0SOnMD+
 BjjkZXta+baYjTIA==
X-Received: by 2002:a17:902:ef08:b0:2ca:d151:383a with SMTP id
 d9443c01a7336-2ccea3ca6bdmr109782415ad.20.1783668950661; 
 Fri, 10 Jul 2026 00:35:50 -0700 (PDT)
Received: from gmail.com ([114.249.134.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e40sm55461315ad.75.2026.07.10.00.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 00:35:50 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
Subject: [PATCH v2] virtio: validate split queue head count before popping
Date: Fri, 10 Jul 2026 15:35:17 +0800
Message-Id: <20260710073517.13472-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710022025-mutt-send-email-mst@kernel.org>
References: <20260710022025-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=physicalmtea@gmail.com; helo=mail-pl1-x62c.google.com
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

virtqueue_split_pop() reads the next split avail ring entry after
checking that the ring is configured. Call virtqueue_num_heads() before
consuming that entry, so an avail index distance larger than the queue
size is rejected.

virtqueue_num_heads() also reports an empty queue and keeps the read
barrier needed before the avail ring entry is read. Drop the now unused
virtio_queue_empty_rcu() helper.

This prevents an invalid split queue state from being expanded into
repeated device command processing.

Link: https://gitlab.com/qemu-project/qemu/-/issues/3930
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v2:
- Drop virtio_queue_empty_rcu() from the split pop path.
- Keep only the existing !vq->vring.avail early exit before
  virtqueue_num_heads().
- Remove the now unused virtio_queue_empty_rcu() helper.

Tested with qemu-system-x86_64 11.0.50, built from origin/master
f893c46c3931 plus this patch, configured with:
  --target-list=x86_64-softmmu --enable-kvm --disable-tcg

The original virtio-iommu live-vring qtest reproducer used for the
report completed successfully on the patched build without host OOM,
confirming that this reproducer is fixed by the patch.

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
-- 
2.34.1

