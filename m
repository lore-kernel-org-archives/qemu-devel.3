Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F699EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMjX-0003Uw-H3; Sun, 08 Mar 2026 18:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjW-0003UO-4a
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMjU-0003OV-KA
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:36:21 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso111175485e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009379; x=1773614179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1zHa6CCTrFYbjN6RjQR3YC8ud8RTRle2qGhoFe0WxOA=;
 b=i9XonAAa/1nA+w933wwoNaW1BcK70WY1zt1nSgvvvCpI4psgLBojtQV2GOGmUneljc
 U3vjjfSG7kdKxN+x4YER6q8MlTfegmu+OTz0t2/tQktGppq3iVgRJsgOPvZOggJVR1EP
 tw4QAmsUdCdqoTT0bzDHokG+s4YjfNXGD7H5UVyydeI6ieGip2LC2jKO7N2BA8T5r/R/
 t8Ja/vhhaa1nrptl1b8xgrhPZWw9nqkzUAylwRRS4ITKvcm9Sv8WAMawnzlSxSAf8MHG
 PIO5LAHkVqRI3ua/Y5EzoY+lRDTFWsJ+K7f7gRrsmLtEBXthWu/ZPbVVwBONvoojIZc5
 hlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009379; x=1773614179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1zHa6CCTrFYbjN6RjQR3YC8ud8RTRle2qGhoFe0WxOA=;
 b=ZEc0i/jXi0Bxecz+1tJB2NXcYQybzZHoo5Tawl0UhIZmNAqYloHhgWhibJGw8/c1+n
 FscVAbQ5hxmJpJ21h/l0SOY58tjwt34VSF9IE6Q2lVmtdefvB5dx3x4ZjJfc6HuTnESc
 RZOCfP41WfHsNJBTfSK7JWhAb5bbqBAZlDv+FeEKZtn+hsnqTYORJNpA7PXdicHVC8S4
 j+3l8MJ11yllj4aswVnReAg6KuGU8SO+T9Yzg4Ug7LS7tzp8kuqqy4jl0ESKs6d61uWR
 7bFwze0UAKe2CtK+7nDHkCeB8LnPnIAZ04oVDEddP2NHhOQjBT6G6i0NJWaMptPIFSSy
 uSPw==
X-Gm-Message-State: AOJu0Yzd6qwluRPeTrf1Eek+OMnsxDLQ1d5QMDLmyZ8Vbw2Zvu8C5W6Z
 W0MY6UT0jBV0Jw+D7F+0RVVxQOZn2oHxLDzcY+f/87I0i9gKGCi+97kSKxYsMmO8I6KqId0GDY8
 Q0VJrL4U=
X-Gm-Gg: ATEYQzzJawLZpXYHXMF8rOOh5GeG2AUX8v6kJMPhrEEbURroo9zwZnD7Oi8BUmGO3jh
 uNTDwxqc58fcV6lbDE8epatxL11zzmmv/SsREUG8Eo+wuavI47frTbRNe3WjYxxqpjVyCdUhr2T
 xE0IE0ZwK20Ub5lq650gYVxK/LuHwOSV/31YKj08GuWHV4GWVWz+G6+hLyOG2LdtetuUyHKfquo
 bGOX/DrQiuLhN/vbG8CCSnyaVb+IUsx1dpdyg5/GnKi9Xpu9yWBJGnrkOmHWPKQ+tPuRJ1ZF/mo
 a8Z2yywVNKw9/E9xTqmFGgmv+ucjx34r8d2J6Ith0c6eKPDXbNolBnCaH3iRvidfG6hbKg/QElp
 watqJkfCQjZcREuw+9J4+MNSp68Gg9tKrqaRgGxl7i6Q3JyumCcKina6a1nFPZYmPPlQ+7bCYnN
 YMr1gKJSDvbNQJosRK/mGSnevT6ViZARPNEgdejMEo0PVv95dGZJVytM4oExZnXIbgWcCM1u4Ii
 nQ65g==
X-Received: by 2002:a05:600c:1c1a:b0:485:38f1:5cec with SMTP id
 5b1f17b1804b1-48538f15df6mr45316565e9.7.1773009378841; 
 Sun, 08 Mar 2026 15:36:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm212856695e9.5.2026.03.08.15.36.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:36:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/49] hw/misc/ivshmem-pci: Handle error from
 kvm_irqchip_add_irqfd_notifier_gsi()
Date: Sun,  8 Mar 2026 23:33:59 +0100
Message-ID: <20260308223433.25503-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: David Hamilton <dahamilt0@gmail.com>

The return value of kvm_irqchip_add_irqfd_notifier_gsi() was being
ignored. Propagate the error to the caller via errp.

Also change setup_interrupt() to return bool to follow QEMU error
handling conventions, making error checks at call sites simpler.

Resolves the TODO comment at the call site.

Signed-off-by: David Hamilton <dahamilt0@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260225121323.5395-2-dahamilt0@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/ivshmem-pci.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index a3a43f53bd1..c987eebb983 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -442,13 +442,14 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
     s->msi_vectors[vector].pdev = pdev;
 }
 
-static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
+static bool setup_interrupt(IVShmemState *s, int vector, Error **errp)
 {
     EventNotifier *n = &s->peers[s->vm_id].eventfds[vector];
     bool with_irqfd = kvm_msi_via_irqfd_enabled() &&
         ivshmem_has_feature(s, IVSHMEM_MSI);
     PCIDevice *pdev = PCI_DEVICE(s);
     Error *err = NULL;
+    int ret;
 
     IVSHMEM_DPRINTF("setting up interrupt for vector: %d\n", vector);
 
@@ -460,18 +461,22 @@ static void setup_interrupt(IVShmemState *s, int vector, Error **errp)
         ivshmem_add_kvm_msi_virq(s, vector, &err);
         if (err) {
             error_propagate(errp, err);
-            return;
+            return false;
         }
 
         if (!msix_is_masked(pdev, vector)) {
-            kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
+            ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL,
                                                s->msi_vectors[vector].virq);
-            /* TODO handle error */
+            if (ret < 0) {
+                error_setg(errp, "Failed to configure irqfd notifier");
+                return false;
+            }
         }
     } else {
         /* it will be delayed until msix is enabled, in write_config */
         IVSHMEM_DPRINTF("with irqfd, delayed until msix enabled\n");
     }
+    return true;
 }
 
 static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
-- 
2.53.0


