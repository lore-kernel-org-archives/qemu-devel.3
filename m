Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED93C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBp-0000PY-Cu; Mon, 12 May 2025 11:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEVAC-0005n9-87
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEVAA-0006p7-Ja
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747064033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znEBQxzlAL8gu1qD1XOCfyAh4AmHH10qm/I+OrDLQQs=;
 b=hqg0oweWKvkHMMQFGwOnsyz1XzzE1v7sRwYLsO8TYVzoiXtQzdHFRaJqqr+AjhrqGvFIA8
 L2F4HHrzeaqb+BaGYv3hfOOAxDNAhKtnopEOD1gk9tZEOJvD0MITIvHOPsfsX8KbR9wkAk
 TxJ1Cj2HII7UIWJt/KepR7X1Kj7HuUw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-eId11g9QOR-YcldxvX7Zmg-1; Mon, 12 May 2025 11:33:52 -0400
X-MC-Unique: eId11g9QOR-YcldxvX7Zmg-1
X-Mimecast-MFC-AGG-ID: eId11g9QOR-YcldxvX7Zmg_1747064031
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a0b7c8b3e2so2899855f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747064029; x=1747668829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=znEBQxzlAL8gu1qD1XOCfyAh4AmHH10qm/I+OrDLQQs=;
 b=gRgBz9UPxpJQKTDFehfCaK8Oh4niAJED1+3AtqgPmNGIMqHpz7jX3tZ4xT76hW8l0y
 SXm6S0HW+GLQWxy6ZtwZICVEDnGcCt7YY9ik6QnonufmnefWOvzkCyGUiC+8MMyTPRoZ
 IJyaNupdWP+Kq20hZGJdOCBl0f16k8wfm4iFeI9meNhiRmDR5HHGNo7Gz6Kx5fbzeS+Y
 Ew482m6a6ZXqsVVoZO6wGgO0W60BB+gxaovKf2icUavhofz7SzHhQoytw9a+sX7wDydE
 VJVYX3qehwntxPBYuJLn11D78kVfX6xH8kN2J/YuF64WMUy1YSgrmNZ/0z35xEsnUPwY
 jYlw==
X-Gm-Message-State: AOJu0YwqamY4H9T6nEEtI3yoSpuxsm/TewStJJJYBujmkBs6EvrI1XYw
 h1YDV48/ozx8RuYYrqhOCGo7j8Pxyol/xJg600EltLZPWVJOB/T4K4Dmz1NNQDKvPPEX6AD+Ei6
 HRDYSiyLdKp1Kv77CAbIygR09AaB0bq+70b4OhpRGsfRDVC9zMwLRapOHVQrJOwbgDJfcBzq96b
 HRV45uMitJP+rJcnVkt48tcnBfDbo+0pKMaA0P
X-Gm-Gg: ASbGncvOGDnQ8/SeEl1bPm2fxquZJuLn1PzOCNTAH5Lai8dIBDCFVMBTwtF2dbXaddC
 SkvN8ii0cWwySuAhcCrs7ZrhCLgn5PrR5pW+CRtRFJmnH7GFxsGDau27anBxexslXOYSj4TF/jy
 odSd+8DkjVxcnwmqQGn9aiv/flF34x4oQUmvrAPjPXJLQtqZ0UcCIDKtClSEt4lCQ20ug6SyP/M
 Tjhvk+UFOeKFgt9DxZzyYfv9ac2nSuKhf16qX+ZcuNF1Jx1XdpYFmAzWJSVBmlg75D90EjJ2CMC
 46nNSnRUXRFBi6k=
X-Received: by 2002:a5d:64af:0:b0:3a0:8598:8e7c with SMTP id
 ffacd0b85a97d-3a1f6427c6cmr11206223f8f.6.1747064029293; 
 Mon, 12 May 2025 08:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqR7PpJXl6Mbf03GwHIgfV7+3n4CS7oNWv0vk+O1RK730cmUbRJY8v8ky3k8LZVpcljYxoKw==
X-Received: by 2002:a5d:64af:0:b0:3a0:8598:8e7c with SMTP id
 ffacd0b85a97d-3a1f6427c6cmr11206195f8f.6.1747064028861; 
 Mon, 12 May 2025 08:33:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeccdsm169975945e9.32.2025.05.12.08.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 08:33:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH 2/2] rust: pl011: Really use RX FIFO depth
Date: Mon, 12 May 2025 17:33:37 +0200
Message-ID: <20250512153337.153954-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512153337.153954-1-pbonzini@redhat.com>
References: <20250512153337.153954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While we model a 16-elements RX FIFO since the PL011 model was
introduced in commit cdbdb648b7c ("ARM Versatile Platform Baseboard
emulation"), we only read 1 char at a time!

Have can_receive() return how many elements are available, and use that
in receive().

This is the Rust version of commit 3e0f118f825 ("hw/char/pl011: Really
use RX FIFO depth"); but it also adds back a comment that is present
in commit f576e0733cc ("hw/char/pl011: Add support for loopback") and
absent in the Rust code.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst              |  2 +-
 rust/hw/char/pl011/src/device.rs | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 4de86375021..171d908e0b0 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -119,7 +119,7 @@ QEMU includes four crates:
   for the ``hw/char/pl011.c`` and ``hw/timer/hpet.c`` files.
 
 .. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
-   as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
+   as of commit 3e0f118f82.  The ``hpet`` crate is synchronized as of
    commit 1433e38cc8.  Both are lacking tracing functionality.
 
 This section explains how to work with them.
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 94b31659849..bde3be65c5b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -580,19 +580,26 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
         // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        u32::from(regs.read_count < regs.fifo_depth())
+        regs.fifo_depth() - regs.read_count
     }
 
     fn receive(&self, buf: &[u8]) {
-        if buf.is_empty() {
+        let mut regs = self.regs.borrow_mut();
+        if regs.loopback_enabled() {
+            // In loopback mode, the RX input signal is internally disconnected
+            // from the entire receiving logics; thus, all inputs are ignored,
+            // and BREAK detection on RX input signal is also not performed.
             return;
         }
-        let mut regs = self.regs.borrow_mut();
-        let c: u32 = buf[0].into();
-        let update_irq = !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
+
+        let mut update_irq = false;
+        for &c in buf {
+            let c: u32 = c.into();
+            update_irq |= regs.fifo_rx_put(c.into());
+        }
+
         // Release the BqlRefCell before calling self.update()
         drop(regs);
-
         if update_irq {
             self.update();
         }
-- 
2.49.0


