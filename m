Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E43CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJIZ-0002V8-KS; Tue, 21 Oct 2025 16:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIK-00026Z-Pm
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJIG-0001Ee-KI
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47117e75258so28945865e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079757; x=1761684557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dEqUJ6VzdguNYBQGctiSO6TrLInk/uHfft6teX8fIpI=;
 b=WVwmriWhKaxQlrTSyrcs+x2YGp1XNFZ1qrie7OzLGGyCBqlk2RyS8UvQDtMOkjlHT0
 GxFitszArlmAjaJuQV/BXVukFUSkjYWQDQZKwY1ti8/nzBfDfXf0DO8R6jDwOtnsqN4w
 lpQOFAA385x1FqLxsIqqHxlRA44WJPgCKPg+NHxPRrLTNIPFuEWUyBCXDrLbG/oPngju
 bL+MkzmYhXLgDMe/9EnJeZQ9m0Xru5gJ8QPK7149c7KoJfIWF5D7d5uSrc0L/A4fgm1b
 dLN3G/Xcv9YJ8DE80zoI+zMXfup+IkepOsASHv8JEYxjH6QniW5CK5or/w5rtIqOqxYO
 d14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079757; x=1761684557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEqUJ6VzdguNYBQGctiSO6TrLInk/uHfft6teX8fIpI=;
 b=CyxiOitrOmpp7fM8A/6qC9WofELWAtan7cj+jBVBBgu3bBI0Om4TRkX8qBMu7VMIxF
 GjbGhL0HIjQgJ55hf9+6zmlBw/zVHHzo+Eum6IH/xvEP3h5AeYO1/Yo6aCYXHtENatPj
 NutLqHwN7RCkz5ssVcsilFA+LjOTQXw8KV2YOa1LxLpzJCguwDLPtqP9uf5EXGJd+21A
 k7iTMG3IBmYk6TRa4kXiBxSl+Hh4ZS2FhxzlgDL+E9GOcijQTTIVbOSRu1WwjJH9LObO
 i9GsbcgIPH06J34ixggbAEXXjYypfShu5m5HJBrEcZY7TGz2Cj5/Zgk5yoB20LVrCB4u
 mpLA==
X-Gm-Message-State: AOJu0Ywzg80XQi4xOaJRk9uUzx1zy3NhblBJ1YEjI/S2/eUEgc1VjTCG
 DiTZbUXMdwE21B6USfJQ+rizBOfhT1DNkioBVXFbTXKuLdsr5jjmDBJFI//PZ+TEPT9iRzITTzq
 zwpHK8es=
X-Gm-Gg: ASbGnctFtVm2ATdyNY68e9eofW3tS8YjDSZsPS+2LulIYjiDNhIoS0zbKJyNbOPCyBy
 iBpWyoOwmf8DtAC6IG54BKnLSaHEYxlpjXi4ndyygQPOsRh20UXoVIbqjrksbXu7uKis6JYZKuR
 Kwx0gStTf2/1Gs+GXU4G5ZfkTnBMLTIisGBz0Vi1HFfDXqieKS7WrJQ811cYvdeXoRxKdv+R4lF
 P5KpplOD73xKK+8jE/HpVSmKBYypiDvbXAMdWl1XP3yb2wk/8juOeBu5lwIR3fgDavPem8hBkRr
 UQ5ByLQux9oxpvdFmTJ2zN1TMcTDoiJQfQGwRx2Ju7b0xNVRLAmp6AvreVtBA2vQvD+Gz5uzkpj
 l5n8uIQ1H4ib9yTTa0GdS/wav9z3J6m9D1zUuN7xvS/BUKOh5MkJyVE6Zv7plyVozPHaqD66iN4
 MdXLn0ilB/jAqJSXeB2WA7z4a8sHPcC+CzI08LxWHyauQFkL64mQ==
X-Google-Smtp-Source: AGHT+IEDldZ9dOy+9juFawfW5DFsoS8TXzInBbT4Yecn1ZTmaKB3zUCSJ7QIcF8kWfCSiEZaEPMtcg==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-4711791c88bmr135935055e9.29.1761079757172; 
 Tue, 21 Oct 2025 13:49:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42d9524sm9241145e9.18.2025.10.21.13.49.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:49:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/45] hw/ide/ide-internal: Move dma_buf_commit() into ide
 "namespace"
Date: Tue, 21 Oct 2025 22:46:43 +0200
Message-ID: <20251021204700.56072-30-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The identifier suggests that it is a generic DMA function while it is tied
to IDE. Fix this by adding an "ide_" prefix.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-7-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ide-internal.h |  2 +-
 hw/ide/ahci.c         |  8 ++++----
 hw/ide/core.c         | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ide/ide-internal.h b/hw/ide/ide-internal.h
index 0d64805da20..281d07c9d58 100644
--- a/hw/ide/ide-internal.h
+++ b/hw/ide/ide-internal.h
@@ -398,7 +398,7 @@ int64_t ide_get_sector(IDEState *s);
 void ide_set_sector(IDEState *s, int64_t sector_num);
 
 void ide_start_dma(IDEState *s, BlockCompletionFunc *cb);
-void dma_buf_commit(IDEState *s, uint32_t tx_bytes);
+void ide_dma_buf_commit(IDEState *s, uint32_t tx_bytes);
 void ide_dma_error(IDEState *s);
 void ide_abort_command(IDEState *s);
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1303c21cb70..14bc66fb7fa 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1417,7 +1417,7 @@ static void ahci_pio_transfer(const IDEDMA *dma)
     }
 
     /* Update number of transferred bytes, destroy sglist */
-    dma_buf_commit(s, size);
+    ide_dma_buf_commit(s, size);
 
 out:
     /* declare that we processed everything */
@@ -1482,8 +1482,8 @@ static int32_t ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit)
 
 /**
  * Updates the command header with a bytes-read value.
- * Called via dma_buf_commit, for both DMA and PIO paths.
- * sglist destruction is handled within dma_buf_commit.
+ * Called via ide_dma_buf_commit, for both DMA and PIO paths.
+ * sglist destruction is handled within ide_dma_buf_commit.
  */
 static void ahci_commit_buf(const IDEDMA *dma, uint32_t tx_bytes)
 {
@@ -1511,7 +1511,7 @@ static int ahci_dma_rw_buf(const IDEDMA *dma, bool is_write)
     }
 
     /* free sglist, update byte count */
-    dma_buf_commit(s, l);
+    ide_dma_buf_commit(s, l);
     s->io_buffer_index += l;
 
     trace_ahci_dma_rw_buf(ad->hba, ad->port_no, l);
diff --git a/hw/ide/core.c b/hw/ide/core.c
index b14983ec54f..8c380abf7c1 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -827,7 +827,7 @@ static void ide_sector_read(IDEState *s)
                                       ide_sector_read_cb, s);
 }
 
-void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
+void ide_dma_buf_commit(IDEState *s, uint32_t tx_bytes)
 {
     if (s->bus->dma->ops->commit_buf) {
         s->bus->dma->ops->commit_buf(s->bus->dma, tx_bytes);
@@ -848,7 +848,7 @@ void ide_set_inactive(IDEState *s, bool more)
 
 void ide_dma_error(IDEState *s)
 {
-    dma_buf_commit(s, 0);
+    ide_dma_buf_commit(s, 0);
     ide_abort_command(s);
     ide_set_inactive(s, false);
     ide_bus_set_irq(s->bus);
@@ -893,7 +893,7 @@ static void ide_dma_cb(void *opaque, int ret)
     if (ret < 0) {
         if (ide_handle_rw_error(s, -ret, ide_dma_cmd_to_retry(s->dma_cmd))) {
             s->bus->dma->aiocb = NULL;
-            dma_buf_commit(s, 0);
+            ide_dma_buf_commit(s, 0);
             return;
         }
     }
@@ -912,7 +912,7 @@ static void ide_dma_cb(void *opaque, int ret)
     sector_num = ide_get_sector(s);
     if (n > 0) {
         assert(n * 512 == s->sg.size);
-        dma_buf_commit(s, s->sg.size);
+        ide_dma_buf_commit(s, s->sg.size);
         sector_num += n;
         ide_set_sector(s, sector_num);
         s->nsector -= n;
@@ -944,7 +944,7 @@ static void ide_dma_cb(void *opaque, int ret)
          * Reset the Active bit and don't raise the interrupt.
          */
         s->status = READY_STAT | SEEK_STAT;
-        dma_buf_commit(s, 0);
+        ide_dma_buf_commit(s, 0);
         goto eot;
     }
 
-- 
2.51.0


