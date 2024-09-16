Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C042C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 17:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqFyY-0001bb-Jn; Mon, 16 Sep 2024 13:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqFyR-0001ZZ-PF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:57:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqFyP-0005f8-D6
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 13:57:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2059112f0a7so31504865ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726509435; x=1727114235;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=khWbRHf/w6ZgTjAFl1isctwCLBqX+u8Oe7duW5w2IKY=;
 b=LL9Zjj/xH+12BLtY7CUDS7IqsTUkONM8h84/B3I8238fUTDLw8qCIg0V2qg4ElsdAF
 6GvniAvFSTuMgVAW5xgh8072RS9vdoE9fuNM00iafPHEoOzPx36v/ajkQiT9MEpE4VX7
 5PBxotUOgaAkZCl3Hxl7Z/Jte10ElQ94/iE206jegFCvtE1UznwxSLYs7GvuNI29P42F
 Se2r/p0wJddMt0FxPznabAaIfUCeq7VaE1socdJki81IqPQNgLwwo4QfZqVaNmvIqULV
 6x8F5yevFfZDt95AGsgKs8L1EtRw4N7CUkkcIXxKvCyCfYrj8+695tPqtrz6vYEiYHCA
 IQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726509435; x=1727114235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=khWbRHf/w6ZgTjAFl1isctwCLBqX+u8Oe7duW5w2IKY=;
 b=r7BKau3OEYRtyVfer8tbBr0Nsq+NXZB8nZobSnz+Nu71PWCE0efF43kxZ/PNF9J27O
 DTYWx0RusDY2mspg5cjfEE3F3L0W39Jpi1IZ2elrtBfVY8dq3TiBE4MGiZv2TzmlSBkC
 fGty5VkTosvF8yfBP4CxeH373/PDTUQEd4taBbj3HtoGXgazA0gEnt6s9lWxJtx5StKy
 sSHRLxtAEfZwTwoIWYGn9Mz4CgrYuyG7y88dpKfOF2xTZq3E5ro8gYDKWDD7gBY6LpLx
 eMykKA2kKyvCPH8QpL81dzD0hAf1BdASGo01tphUoiFdBzsxC9rBACicSMd/d2PKyrwQ
 mrvw==
X-Gm-Message-State: AOJu0YzYpQbZPQhwgovrMs74GMjUxXDEXg7ruSJkn6xE8Ma6JyaAjlKI
 e9bI1MYKc+ebuU+XfL8yQ75ruYwJxF2CXMo+bAkdMXKhTJ2YVfgBtqpqkIoisOEF1FmIvz37GaL
 o
X-Google-Smtp-Source: AGHT+IGrVOvQLLAsHuQTkLLCZaoE8BvCgerK2MDqLj4f+hTE/rnGwoNBS7LW7yy8zJUhjhJuYdGTgg==
X-Received: by 2002:a17:903:22c4:b0:205:73d9:9ce9 with SMTP id
 d9443c01a7336-2078193f82emr189224955ad.0.1726509435261; 
 Mon, 16 Sep 2024 10:57:15 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079474000asm38549055ad.293.2024.09.16.10.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 10:57:14 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH] mac_dbdma: Remove leftover `dma_memory_unmap` calls
Date: Mon, 16 Sep 2024 10:57:08 -0700
Message-Id: <20240916175708.1829059-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These were passing a NULL buffer pointer unconditionally, which happens
to behave in a mostly benign way (except for the chance of an excess
memory region unref and a bounce buffer leak). Per the function comment,
this was never meant to be accepted though, and triggers an assertion
with the "softmmu: Support concurrent bounce buffers" change.

Given that the code in question never sets up any mappings, just remove
the unnecessary dma_memory_unmap calls along with the DBDMA_io struct
fields that are now entirely unused.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/ide/macio.c             | 6 ------
 include/hw/ppc/mac_dbdma.h | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index bec2e866d7..99477a3d13 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void *opaque, int ret)
     return;
 
 done:
-    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
-                     io->dir, io->dma_len);
-
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->blk), &s->acct);
     } else {
@@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int ret)
     return;
 
 done:
-    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
-                     io->dir, io->dma_len);
-
     if (s->dma_cmd == IDE_DMA_READ || s->dma_cmd == IDE_DMA_WRITE) {
         if (ret < 0) {
             block_acct_failed(blk_get_stats(s->blk), &s->acct);
diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
index 4a3f644516..c774f6bf84 100644
--- a/include/hw/ppc/mac_dbdma.h
+++ b/include/hw/ppc/mac_dbdma.h
@@ -44,10 +44,6 @@ struct DBDMA_io {
     DBDMA_end dma_end;
     /* DMA is in progress, don't start another one */
     bool processing;
-    /* DMA request */
-    void *dma_mem;
-    dma_addr_t dma_len;
-    DMADirection dir;
 };
 
 /*
-- 
2.34.1


