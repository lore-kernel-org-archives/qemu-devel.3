Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070ACCEE34E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQx9-0008G4-Ok; Tue, 18 Nov 2025 14:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQx1-00087h-2Z
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:15 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQwz-00060G-AX
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so26327085e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492471; x=1764097271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=15FuB0x0LbOCNKczxF9rqixWt/dxqH7hptCfHdg0sEo=;
 b=P9UPb1mHMBgueIiDm5Vr2FlAOIfWHwGDWC8mzqv95vGOxdPgKRJyS6SX3N+eOHkJFh
 oplWrje/oqdNlzm5PH7U1mhcMjqndui3wDgctoS+WGM/HlqPSWKqQY/QOEpv5oyejMLs
 mJ4lrPo0EwLLf2fOIQM+ow8ClGiqnSfyYBSUZ4jw6NA27WK2aiABVy3oAm5KmaLfzxrG
 J6UMOOLFXWElrE25eq1jPRScPSsfDif5nfp0Jg0o+o6YY/mEytiT+Y85su9y56Y8iDvm
 M6qb5GLl0V5pV5zxyXEz3+DPhSk218JewHbzlRcnYncpu5VtA6AdgLQ9J1OTeey7OzEF
 IdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492471; x=1764097271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=15FuB0x0LbOCNKczxF9rqixWt/dxqH7hptCfHdg0sEo=;
 b=GkKDcaiQ1FC5fEBv5Bcy4Qz0RQG1RII2us4TEMXdhYUVT2IhblJtG12b0Bnkrouj2A
 DyuyGz6BgKTylmLYi2Qs6l74RmiSaD7e9TCcV9+1LhTKFMQUeEiJaSb2L1bIqbG+PWmE
 nui+Oq6eAk/RfEEnIgO5hnP0HlRn8LZk86XOqqmmSRB434UmUQG9Xd+3FS32zuzPv04V
 OjVbti4EFKuq4iKiqLnaky+VVcYgCw0rESkCDIfJ/rCg5iquf8vaPl7DW98Spo53bA+B
 LQ+3S67dK01h7GKUwmlmHhAlR3sHk2qGLp+GDx8vNqpAeXsWK9jhPO0cz1hpcFf5vPFQ
 pyRQ==
X-Gm-Message-State: AOJu0YxCv1ssiPu2ITFHVOpR+m8tcMM4qMqNGgMzgZW8n52W1OvCCcpP
 X072dxocbogcIbDSyTZmDHNg+E0c704j/gGWwHB78gqI/Y2bilHY2QVq9aq931YYn4Rb7i3mkSe
 BnQzC4xeqpw==
X-Gm-Gg: ASbGncvYsqE2kWIJHJM8REXLa8KEYl10gxwscSSuU6Kg6iKTXSdytp5rAjFmrP+JB/r
 1xRX8Dc7WrCeBanevvrpHf0CODrIMMs7dHY1HpFzfvNfP1m5w1nKSny9Q7NtD4d1tn8gz3cwACk
 Y0v/EQPtf55kBSVdCKhprppJXZkC3wq1rHaOFut+ya4cd7hu3K8jVr1nfpCipjni1nZJWKsnscM
 9XR5Q+qkp79yLqtDKfik8jsCWwDjKSXhkXDWQJtCZ7KVqGtfQTghzx1+zHnAbOEAmMjRkYuwCJ7
 ZI9RY5IO0cAPSZE24PKA7QmRcVlR5tcYimZgLpL4ksjBrxiEFfXceZB2zEqdioc1/uo33Rq0sJ9
 49TkkiOt+7j1qE3ZPL33jNvmD6hjIqimHyNX+0+QIaivCPZPFgl4yhLR7DLLAPlkJDQj+28TKbW
 9GQnoadRy2xH/Xl1RZVQxIswJSWTE0LXUlde1IF16Salbjqh9gJ+D54kxALSML
X-Google-Smtp-Source: AGHT+IGnbFcSanW9e8GF9c4LoQKYxUiPuW3JCwcGPuarszhlxpTQd+buN56D7ZXkIz0XXhcSeIBMxA==
X-Received: by 2002:a05:600c:4505:b0:477:7a87:48d1 with SMTP id
 5b1f17b1804b1-4778fea8810mr185910905e9.30.1763492471100; 
 Tue, 18 Nov 2025 11:01:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm33284633f8f.9.2025.11.18.11.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] hw/intc/ioapic: Fix ACCEL_KERNEL_GSI_IRQFD_POSSIBLE typo
Date: Tue, 18 Nov 2025 20:00:37 +0100
Message-ID: <20251118190053.39015-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Commit 638ac1c78457 introduced a regression in interrupt remapping
when running a VM configured with an intel-iommu device and an
assigned PCI VF. During boot, Linux reports repeated messages :

 [   15.416794] __common_interrupt: 2.37 No irq handler for vector
 [   15.417266] __common_interrupt: 2.37 No irq handler for vector
 [   15.417733] __common_interrupt: 2.37 No irq handler for vector
 [   15.418202] __common_interrupt: 2.37 No irq handler for vector
 [   15.418670] __common_interrupt: 2.37 No irq handler for vector

and may eventually hang.

The issue is caused by the incorrect use of the macro
ACCEL_KERNEL_GSI_IRQFD_POSSIBLE, which should instead be
ACCEL_GSI_IRQFD_POSSIBLE.

Fixes: 638ac1c78457 ("hw/intc: Generalize APIC helper names from kvm_* to accel_*")
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251106105148.737093-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/ioapic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index e431d003117..38e43846486 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -216,7 +216,7 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
 #endif
 }
 
-#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
 static void ioapic_iec_notifier(void *private, bool global,
                                 uint32_t index, uint32_t mask)
 {
@@ -434,7 +434,7 @@ static const MemoryRegionOps ioapic_io_ops = {
 
 static void ioapic_machine_done_notify(Notifier *notifier, void *data)
 {
-#ifdef ACCEL_KERNEL_GSI_IRQFD_POSSIBLE
+#ifdef ACCEL_GSI_IRQFD_POSSIBLE
     IOAPICCommonState *s = container_of(notifier, IOAPICCommonState,
                                         machine_done);
 
-- 
2.51.0


