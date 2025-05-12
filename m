Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9011C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 19:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEYTq-0006bn-5B; Mon, 12 May 2025 15:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTU-0005ac-Ha
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEYTQ-0007Wb-K3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 15:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747076759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqI66moqQ1bOEvmuqDSAwlfJVoQnlMwJQqpqwMxFzQ0=;
 b=UYne+xavuMFS+4eePZwclxtpz6kSODpYMv6Y4rtwZ9tJsm4k8bUO/lgQYny3RNkLgEnOMr
 ikpcsaHbm+3vTW1hMhcAIohNkiICerhT0/0EX4LSvFCTduf8rftwEIBQazPrcXVhsSPj1+
 paJbwiyUpdBCwyaim6o+eyEWET9QzPg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-5WZ2qRplOWSL6kvJOQXHGg-1; Mon, 12 May 2025 15:05:58 -0400
X-MC-Unique: 5WZ2qRplOWSL6kvJOQXHGg-1
X-Mimecast-MFC-AGG-ID: 5WZ2qRplOWSL6kvJOQXHGg_1747076757
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso378939166b.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 12:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747076756; x=1747681556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqI66moqQ1bOEvmuqDSAwlfJVoQnlMwJQqpqwMxFzQ0=;
 b=dim6QgeERV/GIcuwx7DprZAQR5KbQAoawyFlsezhdZFvUGBgEyACOGp3hxu2pIHWAI
 AVCRgO3eBUNFUWdVz7D/8yL1tKHbtEJYGvFAtMET3VRVlxsCWa1Ijzgai64Ono0UfEdo
 1fvDQqtDbdxBXl9lWy/EEWogwvMNgkZtXlgk5Gr3ymOi8hdQibuV8XB7E0/qypiUqq8G
 +kD6GZgxXSGddYUvehGl1xfQpnKg8+A+1JZzGVYa9ngAydDWrse+GYRU4iqSgDvTjzIv
 gkdT6Nw3lLav3k8yheqI5xkZkLTB8bDA1Rb0T9ilisBf4b6tMKA3PLT3WXOVkzLQc0r5
 Y8IQ==
X-Gm-Message-State: AOJu0YyhmYBV8InBiNx6jBppnsg+BjK7J6OGeOWqA7/1IbAJPIjzYTyg
 rNN2t4IhzyBkmR5pQI6N303M2LL8Kg4HQaIuyAyf72MtaE1iN2mocHCNj5ACpNQR25vBPeO2s66
 haOdV/6ZD+Gp25aJk/IPwkbHiLrl+JCCTSe12byFKql2Lbew2bkBxQlw5jXDgMVIgLAi+eRlQEB
 T7fyglDD19TWaBj/KW3NPw9wK6lzpOHE4ZXnYd
X-Gm-Gg: ASbGnctwsimmDszsMgxIKjplfBjah6+S9DEF+sWqVTQIDu5YxRDf9veyILXKLGT003p
 C8bcBg7oiD8DFToyioQhKnA11OzLLDiUUnija+6WexmPc+yJky9L9s4ToxtRgwaCakInHxWfps4
 TOP+V9OdG8/5EbXtHMMNOhlCqx5oT1AV4YRFLCrwKLUHuKrCNAesFdfqtxF9O8hxObggYcOGMyk
 tanzPk4p+Pjg4uiAW5yVC43t4N635N5eJOPgt0MT1o9Kiozi7im7FiJ0ND70XgLVuLk4ZsBJ7dG
 zzomO5AjXOQfjII=
X-Received: by 2002:a17:907:1b03:b0:ace:c2d4:bf85 with SMTP id
 a640c23a62f3a-ad21927cc55mr1483835966b.43.1747076756063; 
 Mon, 12 May 2025 12:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+bAIGe8W5YGTjpiSsd7f5fIvUKHGN/WaHIFHmOmCnJKu76Ul/Rcx8GW4umIAjlYqdUWrMGg==
X-Received: by 2002:a05:600c:a410:b0:442:dc6f:4a07 with SMTP id
 5b1f17b1804b1-442dc6f4b16mr71098745e9.4.1747076744886; 
 Mon, 12 May 2025 12:05:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd32f1eesm181240255e9.9.2025.05.12.12.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 12:05:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/16] rust: pl011: Really use RX FIFO depth
Date: Mon, 12 May 2025 21:05:14 +0200
Message-ID: <20250512190524.179419-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512190524.179419-1-pbonzini@redhat.com>
References: <20250512190524.179419-1-pbonzini@redhat.com>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


