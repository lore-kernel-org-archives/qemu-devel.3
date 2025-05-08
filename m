Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7DAC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwdu-0001VW-M7; Thu, 08 May 2025 04:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCwdg-0001Pb-F5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCwde-0008Dg-Hn
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746692993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Arws0fupnvpT9ra6STFPdnILDLwQqiyeyVN0kS90Bxk=;
 b=Uztr1l9q4VgbOleewVpDNcZzz3Tj3CSKdduQ7qnnxQzbJdU+MZ08z1Dm49t+Qzi1UAyY0U
 y/XzgtjX3zKAjNXQSG3TuVs8wyNTgBq21Y5wtGNbIJxu3p4nRKrsrUULuAFGkQ76hYGZ0H
 N0zeVv4sUNKiA1yOv0BXWZe8cLuyK6E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-AzIgSaO4MYu4zJXNnWiKsw-1; Thu, 08 May 2025 04:29:52 -0400
X-MC-Unique: AzIgSaO4MYu4zJXNnWiKsw-1
X-Mimecast-MFC-AGG-ID: AzIgSaO4MYu4zJXNnWiKsw_1746692991
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43e9a3d2977so4585505e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 01:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746692989; x=1747297789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Arws0fupnvpT9ra6STFPdnILDLwQqiyeyVN0kS90Bxk=;
 b=L8fNMkG9rZ8ds6HGktXLP6DaMoBfic+A7ldjJZRfzsVUMxF/QYivTQXC5Jpeoxjx43
 Ulf5rvY+vatd99iHDJt9OZcoQm1xXXJ+CrY9uuv/0ZdLwqGyMhMuGAc8tpPMpFhBmCYE
 4Dp8Gh4jG6c7+eBL0JPtZIwi2A3vI6E5EmpwhYGtJUOvbpzm4DKvG9eyrxEq9juwYQLt
 pN+9yl0yvcqKKWvhombktWFs5hUIdCjk7cVdT93JuHvYsz9/D8V1mm5mQeeEfjLXQgT9
 hNJ/L9AEy6kTn/7tn63H0LQgiRQv5ECpyNeExpOeJqBq8KCmANR+X7uM0N+70m10L9tV
 zHhQ==
X-Gm-Message-State: AOJu0YxvPqudmu7mBvkQnMOLxM1ZpZVSbmXXGLErygJLt1tIm07+LIVV
 7Bh0Ewz96hlBDkNo5eFmNXU2kRUV5klUy1PCnUYNYU0XtjSEdtc6WrOgdyoUZFZNg2ljhjpe0Z0
 uk4TIM8d7mlzh3ffGgmCvvwJ9U7xvY1nNn+tRFm9OrDCO4I73pAKZZy7T0P7hjCWZGGPv982xmh
 7PBUPDqhgumQd27bqzjEK/pccrm+3jgzn0PDpP
X-Gm-Gg: ASbGncuchf4eNXETomJqTNn7QLuTrXtuBTHWvYZvQF4jOmsZvdVwBqYgMT1NjcM/jGf
 hf9ILStGIkpMP7ufq5NpltdVTVEIZtIT5Eatiirh8ntn70vC87+wrw+KKt+QY6bx7EM2zOMsWdW
 2nxf9tAMUCNSA//9Tpx0TuZkRqV+ui+hUoJi12b16L13boPkss0mdv9WQj6FwRUWiORz2pVdwO6
 pHXy417SKq8o9UF3iEpZ8684WGT3bINRslR/B8MRICBBHaJsTUGSsXADVta5TtWf1S/MmB8Exkq
 WP+tEuK9FeWTDe8=
X-Received: by 2002:a05:600c:468d:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-442d033f8f1mr18688755e9.20.1746692989380; 
 Thu, 08 May 2025 01:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJGUaeYQbDT45Q+YBpuJadet5VjGqpPHTEngRar6ztAE1LhfIRPmdqsY+40x13jwQRMvUAmw==
X-Received: by 2002:a05:600c:468d:b0:441:ac58:eb31 with SMTP id
 5b1f17b1804b1-442d033f8f1mr18688535e9.20.1746692988988; 
 Thu, 08 May 2025 01:29:48 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d1266624sm46176935e9.2.2025.05.08.01.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 01:29:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/2] rust: pl011: Really use RX FIFO depth
Date: Thu,  8 May 2025 10:29:43 +0200
Message-ID: <20250508082943.446512-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508082943.446512-1-pbonzini@redhat.com>
References: <20250508082943.446512-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Have the IOCanReadHandler handler return how many elements are
available, and use that in the IOReadHandler handler.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst              |  2 +-
 rust/hw/char/pl011/src/device.rs | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

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
index 94b31659849..7f28bb25a9b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -580,19 +580,19 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
         // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        u32::from(regs.read_count < regs.fifo_depth())
+        regs.fifo_depth() - regs.read_count
     }
 
     fn receive(&self, buf: &[u8]) {
-        if buf.is_empty() {
-            return;
-        }
         let mut regs = self.regs.borrow_mut();
-        let c: u32 = buf[0].into();
-        let update_irq = !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
+        let mut update_irq = false;
+        for &c in buf {
+            let c: u32 = c.into();
+            update_irq |= !regs.loopback_enabled() && regs.fifo_rx_put(c.into());
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


