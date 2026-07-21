Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5C3C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bu-0005QS-4R; Tue, 21 Jul 2026 04:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bt-0005Pq-22
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bq-0005h1-J1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so14240455e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623861; x=1785228661; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e2xGdu7KC0H8+/hf7XCFT3If/VGw9Iofr2FEjydtDnU=;
 b=qjpvC5lFjSJn3/0c8Z51QY6wjrSfocw3BLQU7g7Y9KxMCKvfaHK4FJnK9sWNG2b4Oy
 QpsRtkveMMQgFMnJ2W+ksgAxqkoIuzTOJ5NVp4aIlhT7YomQGYJHJoFAM+Y8URUEXYkj
 H/g7GEpbxG2VaKneMfJ1YXPnoRnjh7cNCHRV3YQOKqgka6wWILkZkNK0MdNspPWT7hQx
 7VtzMhxTY2W5YKanNHHAIXfEZ491O9O87Rlm4pcCQpIX3M8K7PwBUeDHElIFo4YkItyc
 cWaMn4KIonUMvhbxZFm0o/F03NtXiewtfwL9yHhSRmFoi9sr0kQEHn7SIzqUSiGIjErJ
 Nwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623861; x=1785228661;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e2xGdu7KC0H8+/hf7XCFT3If/VGw9Iofr2FEjydtDnU=;
 b=UQ86QTy3HUbhVMQkabq6qDmcHgbCR6QJg07QJR3a4GnVJ6KYvMH3vCEtLo3KIJo1Pf
 YThT0gYGNaloUKOSvmMaV48GQdrSUTGflWSio0NYTISidU7/48F1yguOs6eT0l43TaY+
 Ged9FEH4Kbeezp+Occr6mdiPJLIAUiYZ/G6Tpw10XhGbA4o3+ZRvQ8TmlNyPYR6ycN0j
 hdS4092CqRMGEUzgN2Ibe5NM11yssRtFx5VyGiOho1AI4OPqBjR1cz77Rf3CCSr6eaZC
 olfJyXmouFWylPuuoBrpZnf71yJAtieF70YHsxsY+EDsm41U5WIBvZ8X72EFzzdkMKgX
 arJQ==
X-Gm-Message-State: AOJu0YzGo28FN1cpgd3zPwQQq5djdlIKXZz1a2zaOlXtvXqU+f9j+5c5
 uFelArFSo0vuvumtdRBD1T1YLkn2W5y4CYSx9mLNJmEiMmWAXdo1LaiW3y+GDpb8RTNSbEbmbbu
 9nXtJE00Mmw==
X-Gm-Gg: AfdE7cm8+8BXCme3XxCpT+w+Zin5ZUY0tXrIajphVJ4oC50y5bi+FnzQkFGE02iBEGH
 3j8d/7HEth6MPXzJl8ZBu1xtWO8OcH1GZClvE8sKpJ+zZOY1f7usfFVYueDOCjUWskHjiPZIfg0
 UIFRMe6b6vncm/w1ewLjnNw0SlEt06NvZzy8GLvBhu5KrBja/6t0/wdCakS/fXd+ucLeDi5uG2y
 1EEtyk2i/A1bQ8aKizrsn8ycu+x9jrUl9N3MZki9ErsUHKIAzkbOowFAQqI9xBhum7cEKES+si0
 HaUyahrX8I7f5yntZe6C8LgO7/WSzUBhmSaylUb1/ViCnaQM44fmDJ1Ga7q1jWV4/AwwfhSbUgW
 a5GKWW2dktV7iISsTIIJzlxUnDk7jmOBKYBEhdi0/7aM2gFCN8Ggyc+tZ/ktEfNLtHnL+QWELFx
 0KeT1YnRFatHD3KASyyhuM1744IRWRoCEmw30AfCaGjjPKctsfXFRQ3aP6gSK9844hlzyRPaTuV
 ZqOWrU71jE=
X-Received: by 2002:a05:600c:4f92:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-4954a3d0ce2mr191243805e9.6.1784623860996; 
 Tue, 21 Jul 2026 01:51:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] hw/dma/soc_dma: Remove soc_dma_port_fifo support
Date: Tue, 21 Jul 2026 09:50:41 +0100
Message-ID: <20260721085050.421257-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Our current single OMAP SoC doesn't call the soc_dma_port_add_fifo(),
soc_dma_port_add_fifo_in() or soc_dma_port_add_fifo_out() functions.
Remove them, plus the soc_dma_port_fifo handling that only those
functions needed.

The motivation for this is that it removes a lot of code that is
careless about the fact that the largest possible DMA transfer is
more bits than will fit into an "int" variable, and which does direct
accesses to host memory pointers into guest backing RAM without doing
bounds checks.  Deleting this code means we don't have to audit and
update it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710105907.2570621-2-peter.maydell@linaro.org
---
 hw/dma/soc_dma.c         | 105 +--------------------------------------
 include/hw/arm/soc_dma.h |  24 ++-------
 2 files changed, 5 insertions(+), 124 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index d5c52b804f8..8ba531feea4 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -29,33 +29,6 @@ static void transfer_mem2mem(struct soc_dma_ch_s *ch)
     ch->paddr[1] += ch->bytes;
 }
 
-static void transfer_mem2fifo(struct soc_dma_ch_s *ch)
-{
-    ch->io_fn[1](ch->io_opaque[1], ch->paddr[0], ch->bytes);
-    ch->paddr[0] += ch->bytes;
-}
-
-static void transfer_fifo2mem(struct soc_dma_ch_s *ch)
-{
-    ch->io_fn[0](ch->io_opaque[0], ch->paddr[1], ch->bytes);
-    ch->paddr[1] += ch->bytes;
-}
-
-/* This is further optimisable but isn't very important because often
- * DMA peripherals forbid this kind of transfers and even when they don't,
- * oprating systems may not need to use them.  */
-static void *fifo_buf;
-static int fifo_size;
-static void transfer_fifo2fifo(struct soc_dma_ch_s *ch)
-{
-    if (ch->bytes > fifo_size)
-        fifo_buf = g_realloc(fifo_buf, fifo_size = ch->bytes);
-
-    /* Implement as transfer_fifo2linear + transfer_linear2fifo.  */
-    ch->io_fn[0](ch->io_opaque[0], fifo_buf, ch->bytes);
-    ch->io_fn[1](ch->io_opaque[1], fifo_buf, ch->bytes);
-}
-
 struct dma_s {
     struct soc_dma_s soc;
     int chnum;
@@ -67,11 +40,6 @@ struct dma_s {
         enum soc_dma_port_type type;
         hwaddr addr;
         union {
-           struct {
-               void *opaque;
-               soc_dma_io_t fn;
-               int out;
-           } fifo;
            struct {
                void *base;
                size_t size;
@@ -129,20 +97,7 @@ static inline enum soc_dma_port_type soc_dma_ch_update_type(
     struct dma_s *dma = (struct dma_s *) ch->dma;
     struct memmap_entry_s *entry = soc_dma_lookup(dma, ch->vaddr[port]);
 
-    if (entry->type == soc_dma_port_fifo) {
-        while (entry < dma->memmap + dma->memmap_size &&
-                        entry->u.fifo.out != port)
-            entry ++;
-        if (entry->addr != ch->vaddr[port] || entry->u.fifo.out != port)
-            return soc_dma_port_other;
-
-        if (ch->type[port] != soc_dma_access_const)
-            return soc_dma_port_other;
-
-        ch->io_fn[port] = entry->u.fifo.fn;
-        ch->io_opaque[port] = entry->u.fifo.opaque;
-        return soc_dma_port_fifo;
-    } else if (entry->type == soc_dma_port_mem) {
+    if (entry->type == soc_dma_port_mem) {
         if (entry->addr > ch->vaddr[port] ||
                         entry->addr + entry->u.mem.size <= ch->vaddr[port])
             return soc_dma_port_other;
@@ -173,15 +128,8 @@ void soc_dma_ch_update(struct soc_dma_ch_s *ch)
     }
     dst = soc_dma_ch_update_type(ch, 1);
 
-    /* TODO: use src and dst as array indices.  */
     if (src == soc_dma_port_mem && dst == soc_dma_port_mem)
         ch->transfer_fn = transfer_mem2mem;
-    else if (src == soc_dma_port_mem && dst == soc_dma_port_fifo)
-        ch->transfer_fn = transfer_mem2fifo;
-    else if (src == soc_dma_port_fifo && dst == soc_dma_port_mem)
-        ch->transfer_fn = transfer_fifo2mem;
-    else if (src == soc_dma_port_fifo && dst == soc_dma_port_fifo)
-        ch->transfer_fn = transfer_fifo2fifo;
     else
         ch->transfer_fn = ch->dma->transfer_fn;
 
@@ -251,61 +199,10 @@ struct soc_dma_s *soc_dma_init(int n)
     }
 
     soc_dma_reset(&s->soc);
-    fifo_size = 0;
 
     return &s->soc;
 }
 
-void soc_dma_port_add_fifo(struct soc_dma_s *soc, hwaddr virt_base,
-                soc_dma_io_t fn, void *opaque, int out)
-{
-    struct memmap_entry_s *entry;
-    struct dma_s *dma = (struct dma_s *) soc;
-
-    dma->memmap = g_realloc(dma->memmap, sizeof(*entry) *
-                    (dma->memmap_size + 1));
-    entry = soc_dma_lookup(dma, virt_base);
-
-    if (dma->memmap_size) {
-        if (entry->type == soc_dma_port_mem) {
-            if (entry->addr <= virt_base &&
-                            entry->addr + entry->u.mem.size > virt_base) {
-                error_report("%s: FIFO at %"PRIx64
-                             " collides with RAM region at %"PRIx64
-                             "-%"PRIx64, __func__,
-                             virt_base, entry->addr,
-                             (entry->addr + entry->u.mem.size));
-                exit(-1);
-            }
-
-            if (entry->addr <= virt_base)
-                entry ++;
-        } else
-            while (entry < dma->memmap + dma->memmap_size &&
-                            entry->addr <= virt_base) {
-                if (entry->addr == virt_base && entry->u.fifo.out == out) {
-                    error_report("%s: FIFO at %"PRIx64
-                                 " collides FIFO at %"PRIx64,
-                                 __func__, virt_base, entry->addr);
-                    exit(-1);
-                }
-
-                entry ++;
-            }
-
-        memmove(entry + 1, entry,
-                        (uint8_t *) (dma->memmap + dma->memmap_size ++) -
-                        (uint8_t *) entry);
-    } else
-        dma->memmap_size ++;
-
-    entry->addr          = virt_base;
-    entry->type          = soc_dma_port_fifo;
-    entry->u.fifo.fn     = fn;
-    entry->u.fifo.opaque = opaque;
-    entry->u.fifo.out    = out;
-}
-
 void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
                 hwaddr virt_base, size_t size)
 {
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index bcdb91425a5..e1d75bb3baa 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -25,12 +25,10 @@
 
 struct soc_dma_s;
 struct soc_dma_ch_s;
-typedef void (*soc_dma_io_t)(void *opaque, uint8_t *buf, int len);
 typedef void (*soc_dma_transfer_t)(struct soc_dma_ch_s *ch);
 
 enum soc_dma_port_type {
     soc_dma_port_mem,
-    soc_dma_port_fifo,
     soc_dma_port_other,
 };
 
@@ -57,8 +55,6 @@ struct soc_dma_ch_s {
     hwaddr vaddr[2];    /* Updated by .transfer_fn().  */
     /* Private */
     void *paddr[2];
-    soc_dma_io_t io_fn[2];
-    void *io_opaque[2];
 
     int running;
     soc_dma_transfer_t transfer_fn;
@@ -82,33 +78,21 @@ struct soc_dma_s {
 
 /* Call to activate or stop a DMA channel.  */
 void soc_dma_set_request(struct soc_dma_ch_s *ch, int level);
-/* Call after every write to one of the following fields and before
+/*
+ * Call after every write to one of the following fields and before
  * calling soc_dma_set_request(ch, 1):
  *   ch->type[0...1],
  *   ch->vaddr[0...1],
  *   ch->paddr[0...1],
- * or after a soc_dma_port_add_fifo() or soc_dma_port_add_mem().  */
+ * or after a soc_dma_port_add_mem().
+ */
 void soc_dma_ch_update(struct soc_dma_ch_s *ch);
 
 /* The SoC should call this when the DMA module is being reset.  */
 void soc_dma_reset(struct soc_dma_s *s);
 struct soc_dma_s *soc_dma_init(int n);
 
-void soc_dma_port_add_fifo(struct soc_dma_s *dma, hwaddr virt_base,
-                soc_dma_io_t fn, void *opaque, int out);
 void soc_dma_port_add_mem(struct soc_dma_s *dma, uint8_t *phys_base,
                 hwaddr virt_base, size_t size);
 
-static inline void soc_dma_port_add_fifo_in(struct soc_dma_s *dma,
-                hwaddr virt_base, soc_dma_io_t fn, void *opaque)
-{
-    return soc_dma_port_add_fifo(dma, virt_base, fn, opaque, 0);
-}
-
-static inline void soc_dma_port_add_fifo_out(struct soc_dma_s *dma,
-                hwaddr virt_base, soc_dma_io_t fn, void *opaque)
-{
-    return soc_dma_port_add_fifo(dma, virt_base, fn, opaque, 1);
-}
-
 #endif
-- 
2.43.0


