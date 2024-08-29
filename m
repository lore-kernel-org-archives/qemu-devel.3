Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65BFC7EE3A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjajs-0005Vw-1N; Thu, 29 Aug 2024 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjajr-0005RV-1M
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:43 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjajo-0000AG-00
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:42:42 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3e44b4613so295576a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724920958; x=1725525758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmBCyXbDFDXZfd++HuSOGkWXjW5DHdU1ZXFrWmEMcuM=;
 b=PGR+25+81oE7wh0oAfQIpSGc83bQSebJJ4GzMxi0YSfVbe0WY+VAJm8iiz+uJm/jTt
 nUT2cLI4T+ymkrBxmrR0fmau8jZhOubxd7AQx268HFlZ4XuDtx8wd/nXKu/RcJcfN9KL
 yiTYqt4fwwEUZfZNW/NxOL1Zpkgq4U55c9q3MHdXCwQ3ZUupjLa2TSciG/kX80oOGDam
 UpqkqE7JhbY2bkQL4SmeRLanc0aqQjJLmEqUEzx3Vpbx6FHO3xhWrxcQGC6hzJbM6zE/
 c7o6LPLFnohNFyb6/gvj5UzotoIfvJVfffwAytuOP1LRSBPw3EngocsGOHIc+HdMwmcY
 esxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920958; x=1725525758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmBCyXbDFDXZfd++HuSOGkWXjW5DHdU1ZXFrWmEMcuM=;
 b=v3VtaNJO9EUaLjjKjiHFIjNibP433CFS0UGc+dKvy0dby7LkSCpaiHGb/Y2xflBu5V
 gN+alXbm2PZ9NoAfcaGhzLzzKbCGO8FLp1bDRNw17E7n38t0qrjkFuAF04Hhpl7gjo8T
 5o1s1JlteH9yYW6HV52iY5ok+4tqM7jTJCUSsKwVOx7dpmBuHgNw/Usa2FwHtBhLvrJC
 I1u0E/nKF8f6O3f8GS8uKW/VzpkBvQsLwT24dnyOMNlbXSkggbb/jLtK2YvbZV7bjUSq
 uBz+LklBDYSeHh0lDdfPPo4XV7b6bvPSBxFCFubVYKKWcIiIg2bSvCJAg0Wom2wr1cGb
 ymOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ7ePp/xUnk9ms/m3uVPbApv2u/lJp+Jtvf8bx2tK74IRUzjuHlpvXXvSiZv0G5YN4KiuLvTtnMQeS@nongnu.org
X-Gm-Message-State: AOJu0YxOXsF2UtgE97OpSB/AYTHMJHf9d00SwaRsejFA33DiGixWDIYS
 DKXZqxTBV69wG/BuvgQva9LA6NsK/R5hQCFflEkIRjIDk1wa9Jz9a8zhii0MdBk=
X-Google-Smtp-Source: AGHT+IEVxW08B5x6CS9ihG7KBestHeembd20Qu+djnaTXQbHlLgdNL4ooc0W8l2e1PYvxe+vvqYUJQ==
X-Received: by 2002:a17:90b:1909:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2d8561b15b3mr1782148a91.11.1724920958361; 
 Thu, 29 Aug 2024 01:42:38 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3897sm3431856a91.49.2024.08.29.01.42.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Aug 2024 01:42:37 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v10 01/10] block: add persistent reservation in/out api
Date: Thu, 29 Aug 2024 16:42:05 +0800
Message-Id: <20240829084214.50548-2-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240829084214.50548-1-luchangqi.123@bytedance.com>
References: <20240829084214.50548-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add persistent reservation in/out operations
at the block level. The following operations
are included:

- read_keys:        retrieves the list of registered keys.
- read_reservation: retrieves the current reservation status.
- register:         registers a new reservation key.
- reserve:          initiates a reservation for a specific key.
- release:          releases a reservation for a specific key.
- clear:            clears all existing reservations.
- preempt:          preempts a reservation held by another key.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c             | 403 ++++++++++++++++++++++++++++++
 block/io.c                        | 164 ++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 +++++++
 include/sysemu/block-backend-io.h |  24 ++
 6 files changed, 735 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index db6f9b92a3..b74aaba23f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1770,6 +1770,409 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
     return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, opaque);
 }
 
+typedef struct BlkPrInCo {
+    BlockBackend *blk;
+    uint32_t *generation;
+    uint32_t num_keys;
+    BlockPrType *type;
+    uint64_t *keys;
+    int ret;
+} BlkPrInCo;
+
+typedef struct BlkPrInCB {
+    BlockAIOCB common;
+    BlkPrInCo prco;
+    bool has_returned;
+} BlkPrInCB;
+
+static const AIOCBInfo blk_pr_in_aiocb_info = {
+    .aiocb_size         = sizeof(BlkPrInCB),
+};
+
+static void blk_pr_in_complete(BlkPrInCB *acb)
+{
+    if (acb->has_returned) {
+        acb->common.cb(acb->common.opaque, acb->prco.ret);
+
+        /* This is paired with blk_inc_in_flight() in blk_aio_pr_in(). */
+        blk_dec_in_flight(acb->prco.blk);
+        qemu_aio_unref(acb);
+    }
+}
+
+static void blk_pr_in_complete_bh(void *opaque)
+{
+    BlkPrInCB *acb = opaque;
+    assert(acb->has_returned);
+    blk_pr_in_complete(acb);
+}
+
+static BlockAIOCB *blk_aio_pr_in(BlockBackend *blk, uint32_t *generation,
+                                 uint32_t num_keys, BlockPrType *type,
+                                 uint64_t *keys, CoroutineEntry co_entry,
+                                 BlockCompletionFunc *cb, void *opaque)
+{
+    BlkPrInCB *acb;
+    Coroutine *co;
+
+    /* This is paired with blk_dec_in_flight() in blk_pr_in_complete(). */
+    blk_inc_in_flight(blk);
+    acb = blk_aio_get(&blk_pr_in_aiocb_info, blk, cb, opaque);
+    acb->prco = (BlkPrInCo) {
+        .blk        = blk,
+        .generation = generation,
+        .num_keys   = num_keys,
+        .type       = type,
+        .ret        = NOT_DONE,
+        .keys       = keys,
+    };
+    acb->has_returned = false;
+
+    co = qemu_coroutine_create(co_entry, acb);
+    aio_co_enter(qemu_get_current_aio_context(), co);
+
+    acb->has_returned = true;
+    if (acb->prco.ret != NOT_DONE) {
+        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                         blk_pr_in_complete_bh, acb);
+    }
+
+    return &acb->common;
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_read_keys(BlockBackend *blk, uint32_t *generation,
+                        uint32_t num_keys, uint64_t *keys)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_read_keys(blk_bs(blk), generation, num_keys, keys);
+}
+
+static void coroutine_fn blk_aio_pr_read_keys_entry(void *opaque)
+{
+    BlkPrInCB *acb = opaque;
+    BlkPrInCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_read_keys(prco->blk, prco->generation,
+                                        prco->num_keys, prco->keys);
+    blk_pr_in_complete(acb);
+}
+
+BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t *generation,
+                                 uint32_t num_keys, uint64_t *keys,
+                                 BlockCompletionFunc *cb, void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_in(blk, generation, num_keys, NULL, keys,
+                         blk_aio_pr_read_keys_entry, cb, opaque);
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_read_reservation(BlockBackend *blk, uint32_t *generation,
+                               uint64_t *key, BlockPrType *type)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_read_reservation(blk_bs(blk), generation, key, type);
+}
+
+static void coroutine_fn blk_aio_pr_read_reservation_entry(void *opaque)
+{
+    BlkPrInCB *acb = opaque;
+    BlkPrInCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_read_reservation(prco->blk, prco->generation,
+                                               prco->keys, prco->type);
+    blk_pr_in_complete(acb);
+}
+
+BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t *generation,
+                                        uint64_t *key, BlockPrType *type,
+                                        BlockCompletionFunc *cb, void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_in(blk, generation, 0, type, key,
+                         blk_aio_pr_read_reservation_entry, cb, opaque);
+}
+
+typedef struct BlkPrOutCo {
+    BlockBackend *blk;
+    uint64_t old_key;
+    uint64_t new_key;
+    bool ptpl;
+    BlockPrType type;
+    bool ignore_key;
+    bool abort;
+    int ret;
+} BlkPrOutCo;
+
+typedef struct BlkPrOutCB {
+    BlockAIOCB common;
+    BlkPrOutCo prco;
+    bool has_returned;
+} BlkPrOutCB;
+
+static const AIOCBInfo blk_pr_out_aiocb_info = {
+    .aiocb_size         = sizeof(BlkPrOutCB),
+};
+
+static void blk_pr_out_complete(BlkPrOutCB *acb)
+{
+    if (acb->has_returned) {
+        acb->common.cb(acb->common.opaque, acb->prco.ret);
+
+        /* This is paired with blk_inc_in_flight() in blk_aio_pr_out(). */
+        blk_dec_in_flight(acb->prco.blk);
+        qemu_aio_unref(acb);
+    }
+}
+
+static void blk_pr_out_complete_bh(void *opaque)
+{
+    BlkPrOutCB *acb = opaque;
+    assert(acb->has_returned);
+    blk_pr_out_complete(acb);
+}
+
+static BlockAIOCB *blk_aio_pr_out(BlockBackend *blk, uint64_t old_key,
+                                  uint64_t new_key, bool ptpl,
+                                  BlockPrType type, bool ignore_key,
+                                  bool abort, CoroutineEntry co_entry,
+                                  BlockCompletionFunc *cb, void *opaque)
+{
+    BlkPrOutCB *acb;
+    Coroutine *co;
+
+    /* This is paired with blk_dec_in_flight() in blk_pr_out_complete(). */
+    blk_inc_in_flight(blk);
+    acb = blk_aio_get(&blk_pr_out_aiocb_info, blk, cb, opaque);
+    acb->prco = (BlkPrOutCo) {
+        .blk        = blk,
+        .old_key    = old_key,
+        .new_key    = new_key,
+        .ptpl       = ptpl,
+        .type       = type,
+        .ignore_key = ignore_key,
+        .abort      = abort,
+        .ret        = NOT_DONE,
+    };
+    acb->has_returned = false;
+
+    co = qemu_coroutine_create(co_entry, acb);
+    aio_co_enter(qemu_get_current_aio_context(), co);
+
+    acb->has_returned = true;
+    if (acb->prco.ret != NOT_DONE) {
+        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
+                                         blk_pr_out_complete_bh, acb);
+    }
+
+    return &acb->common;
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_register(BlockBackend *blk, uint64_t old_key,
+                       uint64_t new_key, BlockPrType type,
+                       bool ptpl, bool ignore_key)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_register(blk_bs(blk), old_key, new_key, type,
+                               ptpl, ignore_key);
+}
+
+static void coroutine_fn blk_aio_pr_register_entry(void *opaque)
+{
+    BlkPrOutCB *acb = opaque;
+    BlkPrOutCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_register(prco->blk, prco->old_key, prco->new_key,
+                                       prco->type, prco->ptpl,
+                                       prco->ignore_key);
+    blk_pr_out_complete(acb);
+}
+
+BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
+                                uint64_t new_key, BlockPrType type,
+                                bool ptpl, bool ignore_key,
+                                BlockCompletionFunc *cb,
+                                void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_out(blk, old_key, new_key, ptpl, type, ignore_key, false,
+                          blk_aio_pr_register_entry, cb, opaque);
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_reserve(BlockBackend *blk, uint64_t key, BlockPrType type)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_reserve(blk_bs(blk), key, type);
+}
+
+static void coroutine_fn blk_aio_pr_reserve_entry(void *opaque)
+{
+    BlkPrOutCB *acb = opaque;
+    BlkPrOutCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_reserve(prco->blk, prco->old_key,
+                                      prco->type);
+    blk_pr_out_complete(acb);
+}
+
+
+BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
+                               BlockPrType type,
+                               BlockCompletionFunc *cb,
+                               void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_out(blk, key, 0, false, type, false, false,
+                          blk_aio_pr_reserve_entry, cb, opaque);
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_release(BlockBackend *blk, uint64_t key, BlockPrType type)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_release(blk_bs(blk), key, type);
+}
+
+static void coroutine_fn blk_aio_pr_release_entry(void *opaque)
+{
+    BlkPrOutCB *acb = opaque;
+    BlkPrOutCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_release(prco->blk, prco->old_key, prco->type);
+    blk_pr_out_complete(acb);
+}
+
+
+BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
+                               BlockPrType type, BlockCompletionFunc *cb,
+                               void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_out(blk, key, 0, false, type, false, false,
+                          blk_aio_pr_release_entry, cb, opaque);
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_clear(BlockBackend *blk, uint64_t key)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_clear(blk_bs(blk), key);
+}
+
+static void coroutine_fn blk_aio_pr_clear_entry(void *opaque)
+{
+    BlkPrOutCB *acb = opaque;
+    BlkPrOutCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_clear(prco->blk, prco->old_key);
+    blk_pr_out_complete(acb);
+}
+
+
+BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
+                             BlockCompletionFunc *cb, void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_out(blk, key, 0, false, 0, false, false,
+                          blk_aio_pr_clear_entry, cb, opaque);
+}
+
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
+static int coroutine_fn
+blk_aio_pr_do_preempt(BlockBackend *blk, uint64_t cr_key,
+                      uint64_t pr_key, BlockPrType type, bool abort)
+{
+    IO_CODE();
+
+    blk_wait_while_drained(blk);
+    GRAPH_RDLOCK_GUARD();
+
+    if (!blk_co_is_available(blk)) {
+        return -ENOMEDIUM;
+    }
+
+    return bdrv_co_pr_preempt(blk_bs(blk), cr_key, pr_key, type, abort);
+}
+
+static void coroutine_fn blk_aio_pr_preempt_entry(void *opaque)
+{
+    BlkPrOutCB *acb = opaque;
+    BlkPrOutCo *prco = &acb->prco;
+
+    prco->ret = blk_aio_pr_do_preempt(prco->blk, prco->old_key,
+                                      prco->new_key, prco->type,
+                                      prco->abort);
+    blk_pr_out_complete(acb);
+}
+
+
+BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
+                               uint64_t pr_key, BlockPrType type,
+                               bool abort, BlockCompletionFunc *cb,
+                               void *opaque)
+{
+    IO_CODE();
+    return blk_aio_pr_out(blk, cr_key, pr_key, false, type, false, abort,
+                          blk_aio_pr_preempt_entry, cb, opaque);
+}
+
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
 blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
diff --git a/block/io.c b/block/io.c
index 7217cf811b..105161930e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -146,6 +146,7 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
                                  src->min_mem_alignment);
     dst->max_iov = MIN_NON_ZERO(dst->max_iov, src->max_iov);
     dst->max_hw_iov = MIN_NON_ZERO(dst->max_hw_iov, src->max_hw_iov);
+    dst->pr_cap |= src->pr_cap;
 }
 
 typedef struct BdrvRefreshLimitsState {
@@ -3220,6 +3221,169 @@ out:
     return co.ret;
 }
 
+int coroutine_fn bdrv_co_pr_read_keys(BlockDriverState *bs,
+                 uint32_t *generation, uint32_t num_keys,
+                 uint64_t *keys)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_read_keys) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_read_keys(bs, generation, num_keys, keys);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
+int coroutine_fn bdrv_co_pr_read_reservation(BlockDriverState *bs,
+                 uint32_t *generation, uint64_t *key, BlockPrType *type)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_read_reservation) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_read_reservation(bs, generation, key, type);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
+int coroutine_fn bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                 uint64_t new_key, BlockPrType type, bool ptpl,
+                 bool ignore_key)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_register) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_register(bs, old_key, new_key, type,
+    ptpl, ignore_key);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
+int coroutine_fn bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key,
+                                    BlockPrType type)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_reserve) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_reserve(bs, key, type);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
+int coroutine_fn bdrv_co_pr_release(BlockDriverState *bs, uint64_t key,
+                                    BlockPrType type)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_release) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_release(bs, key, type);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
+int coroutine_fn bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_clear) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_clear(bs, key);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
+int coroutine_fn bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_key,
+                 uint64_t pr_key, BlockPrType type, bool abort)
+{
+    BlockDriver *drv = bs->drv;
+    CoroutineIOCompletion co = {
+        .coroutine = qemu_coroutine_self(),
+    };
+
+    IO_CODE();
+    assert_bdrv_graph_readable();
+
+    bdrv_inc_in_flight(bs);
+    if (!drv || !drv->bdrv_co_pr_preempt) {
+        co.ret = -ENOTSUP;
+        goto out;
+    }
+
+    co.ret = drv->bdrv_co_pr_preempt(bs, cr_key, pr_key, type, abort);
+out:
+    bdrv_dec_in_flight(bs);
+    return co.ret;
+}
+
 int coroutine_fn bdrv_co_zone_report(BlockDriverState *bs, int64_t offset,
                         unsigned int *nr_zones,
                         BlockZoneDescriptor *zones)
diff --git a/include/block/block-common.h b/include/block/block-common.h
index 338fe5ff7a..725b6174c2 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -526,6 +526,46 @@ typedef enum {
     BDRV_FIX_ERRORS   = 2,
 } BdrvCheckMode;
 
+/**
+ *  According SCSI protocol(chapter 5.9 of SCSI Primary Commands - 4)
+ *  and NVMe protocol(chapter 7.2 of NVMe Base Specification 2.0),
+ *  the persistent reservation types and persistent capabilities of
+ *  the public layer block are abstracted.
+ */
+typedef enum {
+    BLK_PR_WRITE_EXCLUSIVE              = 0x1,
+    BLK_PR_EXCLUSIVE_ACCESS             = 0x2,
+    BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY    = 0x3,
+    BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY   = 0x4,
+    BLK_PR_WRITE_EXCLUSIVE_ALL_REGS     = 0x5,
+    BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS    = 0x6,
+} BlockPrType;
+
+typedef enum BLKPrCap {
+    /* Persist Through Power Loss */
+    BLK_PR_CAP_PTPL = 1 << 0,
+    /* Write Exclusive reservation type */
+    BLK_PR_CAP_WR_EX = 1 << 1,
+    /* Exclusive Access reservation type */
+    BLK_PR_CAP_EX_AC = 1 << 2,
+    /* Write Exclusive Registrants Only reservation type */
+    BLK_PR_CAP_WR_EX_RO = 1 << 3,
+    /* Exclusive Access Registrants Only reservation type */
+    BLK_PR_CAP_EX_AC_RO = 1 << 4,
+    /* Write Exclusive All Registrants reservation type */
+    BLK_PR_CAP_WR_EX_AR = 1 << 5,
+    /* Exclusive Access All Registrants reservation type */
+    BLK_PR_CAP_EX_AC_AR = 1 << 6,
+
+    BLK_PR_CAP_ALL = (BLK_PR_CAP_PTPL |
+                     BLK_PR_CAP_WR_EX |
+                     BLK_PR_CAP_EX_AC |
+                     BLK_PR_CAP_WR_EX_RO |
+                     BLK_PR_CAP_EX_AC_RO |
+                     BLK_PR_CAP_WR_EX_AR |
+                     BLK_PR_CAP_EX_AC_AR),
+} BLKPrCap;
+
 typedef struct BlockSizes {
     uint32_t phys;
     uint32_t log;
diff --git a/include/block/block-io.h b/include/block/block-io.h
index b49e0537dd..908361862b 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -106,6 +106,26 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
+                     uint32_t num_keys, uint64_t *keys);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
+                            uint64_t *key, BlockPrType *type);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                    uint64_t new_key, BlockPrType type,
+                    bool ptpl, bool ignore_key);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key);
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_key, uint64_t pr_key,
+                   BlockPrType type, bool abort);
+
 /* Ensure contents are flushed to disk.  */
 int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 761276127e..6e628069e9 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -766,6 +766,87 @@ struct BlockDriver {
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_ioctl)(
         BlockDriverState *bs, unsigned long int req, void *buf);
 
+    /*
+     * Persistent reservation series api.
+     * Please refer to chapter 5.9 of SCSI Primary Commands - 4 or
+     * chapter 7 of NVMe Base Specification 2.0.
+     *
+     * The block layer driver should implement all the following APIs
+     * or none at all, including: bdrv_co_pr_read_keys,
+     * bdrv_co_pr_read_reservation, bdrv_co_pr_register,
+     * bdrv_co_pr_reserve, bdrv_co_pr_release,
+     * bdrv_co_pr_clear and bdrv_co_pr_preempt.
+     *
+     * Read the registered keys and return them in the @keys.
+     * @generation: The generation of the reservation key.
+     * @num_keys:   The maximum number of keys that can be transmitted.
+     * @keys:       Registered keys array.
+     *
+     * On success, store generation in @generation and store keys @keys
+     * and return the number of @keys.
+     * On failure return -errno.
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_keys)(
+        BlockDriverState *bs, uint32_t *generation,
+        uint32_t num_keys, uint64_t *keys);
+    /*
+     * Read the reservation key and store it in the @key.
+     * @generation: The generation of the reservation key.
+     * @key:        The reservation key.
+     * @type:       Type of the reservation key.
+     *
+     * On success, store generation in @generation, store the
+     * reservation key in @key and return the number of @key
+     * which used to determine whether the reservation key exists.
+     * On failure return -errno.
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_reservation)(
+        BlockDriverState *bs, uint32_t *generation,
+        uint64_t *key, BlockPrType *type);
+    /*
+     * Register, unregister, or replace a reservation key.
+     * @old_key:    The current reservation key associated with the host.
+     * @new_key:    The new reservation Key.
+     * @type:       Type of the reservation key.
+     * @ignore_key: Ignore or not @old_key.
+     * @ptpl:       Whether to support Persist Through Power Loss(PTPL).
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_register)(
+        BlockDriverState *bs, uint64_t old_key,
+        uint64_t new_key, BlockPrType type,
+        bool ptpl, bool ignore_key);
+    /*
+     * Acquire a reservation on a host.
+     * @key:  The current reservation key associated with the host.
+     * @type: Type of the reservation key.
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_reserve)(
+        BlockDriverState *bs, uint64_t key, BlockPrType type);
+    /*
+     * Release a reservation on a host.
+     * @key:  The current reservation key associated with the host.
+     * @type: Type of the reservation key.
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_release)(
+        BlockDriverState *bs, uint64_t key, BlockPrType type);
+    /**
+     * Clear reservations on a host.
+     * @key: The current reservation key associated with the host.
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_clear)(
+        BlockDriverState *bs, uint64_t key);
+    /*
+     * Preempt a reservation held on a host.
+     * @cr_key: The current reservation key associated with the host.
+     * @pr_key: The preempt reservation Key which to be
+     *          unregistered from the namespace.
+     * @type:   Type of the reservation key.
+     * @abort:  Whether to abort a reservation held on a host.
+     */
+    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_preempt)(
+        BlockDriverState *bs, uint64_t cr_key,
+        uint64_t pr_key, BlockPrType type, bool abort);
+
     /*
      * Returns 0 for completed check, -errno for internal errors.
      * The check results are stored in result.
@@ -899,6 +980,9 @@ typedef struct BlockLimits {
     uint32_t max_active_zones;
 
     uint32_t write_granularity;
+
+   /* Persistent reservation capacities. */
+    uint8_t pr_cap;
 } BlockLimits;
 
 typedef struct BdrvOpBlocker BdrvOpBlocker;
diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
index d174275a5c..b3d49a3c6f 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -62,6 +62,30 @@ void blk_aio_cancel_async(BlockAIOCB *acb);
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
                           BlockCompletionFunc *cb, void *opaque);
 
+BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t *generation,
+                                 uint32_t num_keys, uint64_t *keys,
+                                 BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t *generation,
+                                        uint64_t *key, BlockPrType *type,
+                                        BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
+                                uint64_t new_key, BlockPrType type,
+                                bool ptpl, bool ignore_key,
+                                BlockCompletionFunc *cb,
+                                void *opaque);
+BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
+                               BlockPrType type,
+                               BlockCompletionFunc *cb,
+                               void *opaque);
+BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
+                               BlockPrType type, BlockCompletionFunc *cb,
+                               void *opaque);
+BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
+                             BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
+                               uint64_t pr_key, BlockPrType type, bool abort,
+                               BlockCompletionFunc *cb, void *opaque);
+
 void blk_inc_in_flight(BlockBackend *blk);
 void blk_dec_in_flight(BlockBackend *blk);
 
-- 
2.20.1


