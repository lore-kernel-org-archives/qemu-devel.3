Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2529C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bv-0005RA-Hu; Tue, 21 Jul 2026 04:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bu-0005QW-4R
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bs-0005hS-CV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso34360755e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623863; x=1785228663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FKIxkzQI1zH0yFEHRdQ3Fup7bYf/06pJKhM3oPGWdhA=;
 b=PpIwiZBHJgRLJYiM87Vb32TC9BUZ3MbiPcyLFpDv/Xdz2yDKkFkbmMwBE1XTx75AUP
 lP1B4ZmfZ4eZ7ROrR97sRuXbJ0/nNK2OSItxJrXwgN3uUtJkEc8Do/5R4lwIu/IASZZD
 KUpDb5HMjz//C1HZwEejvc1Pe7CK+AsnX0lU1TJSNL0D5cxDoLjiVjt8OyG5va6OIASL
 iACSHMuWruQfvCh+oEhAaK7Xsmy2JFaXQdAJTZ2b7trW4lT7VXhKJhNkZUGR7wOkvFOm
 88M8mi4UcTTuTtoA5nfBGzOHYiQ/9pn64BhdYFde+nSu3GdRjt/ZfCnppdTOVJCoW9Fd
 A4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623863; x=1785228663;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FKIxkzQI1zH0yFEHRdQ3Fup7bYf/06pJKhM3oPGWdhA=;
 b=PQJbUejKl2zklNLhuP15T6ARFueRPq5FQLFy1raeDGiSgSp5gCKCg+yaFHQTPtvrUG
 +LbhR+Z4wC06ngpIdf7A9U4fRUkYhpbvS6WSe9tAGlR/EWIA2jStA3hILElFAqWEWdLs
 LyNBwwzCpOXw2CqiMsil3dm68GvkopvIs73yioIffws2s5Ow2KsMvsS+7Nvfst2nTxFy
 ql0q9t2Tmy7b2V4yMpnYBIYRBC89xdomg99fcnFZUxb8ch/PGP53EMm1//8xVMQ8ND84
 jJt0GyrJARmNYqzXJsmc9OiqX+mC/zvajoBI7nPlBcGHMACUtVYVXIoZtZpa+ex9lb2n
 4akg==
X-Gm-Message-State: AOJu0YwkSRjKJAKM5Svl5LRh5B/A2P3NKsFK/Da2yZmD3uKEFMzV0grh
 FN/Y1TPOE/kZINnGO3GaxZVbOVmw+ktbco8U6qXoqFXaguw3r5I/0hXRhIu5I7ns1cT7uGj27Hr
 ANO2XnBMcEQ==
X-Gm-Gg: AfdE7cmew1h+qif+tfz5sIOsjpj64C7uvdEL5KlY8gASW/cfGiKBxXeLer6hjRlMAQR
 gRgLgG87uHu242gLMShOtnzOBzpw4WVtPtj2bREM5MWKO7opw310EuWuYbYdTWvaOAYF5Fpt9lP
 Hg8lAZThLrrDSZWRmFd7Sm6rWpn+xnZU7tWVaS21pdRm5O/y3Sv3Pd3PtuV1nkfXx4X9R1D8cJS
 8bZVqNhb5Ei+JJr6A7MdlwJ7MhbGm2ofuxUo8IeVG7r2nwwv9WeCZQoUzukOhOQDNeqokbBbUvv
 vlnfuqDtLEKA9IU0kQEElmjMZCuJFjCDllN3HaviIpzcuqMq9pFuyiswlNCslOMAgUxvVCFJ6mB
 6/x6BckqhpqZDM6J3hpRsGVgwpVLWcJ7Nqp9yIONLNP1/bDcg2Rz5iMwbcTFlBFgH+Cj+maZXUT
 fUu35TgxMuHXp/lE7Nm0cvWe7WTzDuIt9vKlo0Uzqk9XsKZNp8nbOB34O0+4Hn6QOMzSNE9IPYy
 NDrC/zzSe8=
X-Received: by 2002:a05:600c:4f81:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-4955b4a5c0amr102105205e9.19.1784623862983; 
 Tue, 21 Jul 2026 01:51:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] hw/dma/soc_dma: Remove union from memmap_entry_s struct
Date: Tue, 21 Jul 2026 09:50:43 +0100
Message-ID: <20260721085050.421257-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

There's only one field in the union inside memmap_entry_s now that
we've removed the soc_dma_port_fifo handling.  Simplify by removing
the union.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710105907.2570621-4-peter.maydell@linaro.org
---
 hw/dma/soc_dma.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index ff513383886..bbcd2bdcd56 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -39,12 +39,10 @@ struct dma_s {
     struct memmap_entry_s {
         enum soc_dma_port_type type;
         hwaddr addr;
-        union {
-           struct {
-               void *base;
-               size_t size;
-           } mem;
-        } u;
+        struct {
+            void *base;
+            size_t size;
+        } mem;
     } *memmap;
     int memmap_size;
 
@@ -99,7 +97,7 @@ static inline enum soc_dma_port_type soc_dma_ch_update_type(
 
     if (entry->type == soc_dma_port_mem) {
         if (entry->addr > ch->vaddr[port] ||
-                        entry->addr + entry->u.mem.size <= ch->vaddr[port])
+                        entry->addr + entry->mem.size <= ch->vaddr[port])
             return soc_dma_port_other;
 
         /* TODO: support constant memory address for source port as used for
@@ -107,7 +105,7 @@ static inline enum soc_dma_port_type soc_dma_ch_update_type(
         if (ch->type[port] != soc_dma_access_const)
             return soc_dma_port_other;
 
-        ch->paddr[port] = (uint8_t *) entry->u.mem.base +
+        ch->paddr[port] = (uint8_t *) entry->mem.base +
                 (ch->vaddr[port] - entry->addr);
         /* TODO: save bytes left to the end of the mapping somewhere so we
          * can check we're not reading beyond it.  */
@@ -212,12 +210,12 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
         if (entry->type == soc_dma_port_mem) {
             if ((entry->addr >= virt_base && entry->addr < virt_base + size) ||
                             (entry->addr <= virt_base &&
-                             entry->addr + entry->u.mem.size > virt_base)) {
+                             entry->addr + entry->mem.size > virt_base)) {
                 error_report("%s: RAM at %"PRIx64 "-%"PRIx64
                              " collides with RAM region at %"PRIx64
                              "-%"PRIx64, __func__,
                              virt_base, virt_base + size,
-                             entry->addr, entry->addr + entry->u.mem.size);
+                             entry->addr, entry->addr + entry->mem.size);
                 exit(-1);
             }
 
@@ -246,8 +244,8 @@ void soc_dma_port_add_mem(struct soc_dma_s *soc, uint8_t *phys_base,
 
     entry->addr          = virt_base;
     entry->type          = soc_dma_port_mem;
-    entry->u.mem.base    = phys_base;
-    entry->u.mem.size    = size;
+    entry->mem.base    = phys_base;
+    entry->mem.size    = size;
 }
 
 /* TODO: port removal for ports like PCMCIA memory */
-- 
2.43.0


