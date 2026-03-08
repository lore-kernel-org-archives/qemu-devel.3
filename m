Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA75AEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMn8-0000Uc-Gk; Sun, 08 Mar 2026 18:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMn7-0000QD-GO
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:40:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMn5-0003pU-Mk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:40:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso102169915e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009602; x=1773614402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8DwSG/tB/iXvNNLgKPuBzabsRMX6X8tCIczGBV0fYKM=;
 b=XM32t1Ooqh9qfty3JO9aQi6pifT1dmjnxvnUpXcsHNhcZF/O9nYvs++njfpS4KXQAh
 O9b/fHWFIBks70uiqjgh2tn8FgabpxcRH+frTLDaIJii20xik3HME3g64yuf7ipiUd+j
 u8sotr9tls3Y82fhNBRAyI9QgRjY6QbDZ8SSLsBUI9XS+C5PU38653t5JcKKkmvl08h4
 LYZdZBIW/ajUo/5Ovnau1IiK4yYYdZHvmbcFhEsQaRKE7d04oUmtJrp/Upl7qfE82V2u
 ZdFjtay3W7+EfzBtldsQgeqY9MgKpEtl8X2AFKJjHXsI31oFNAM8mNjAsXM2A3ohxN4Q
 Czlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009602; x=1773614402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8DwSG/tB/iXvNNLgKPuBzabsRMX6X8tCIczGBV0fYKM=;
 b=i5zYEPIWzzS9rIfALNf7oOjGfUY/k99j81XXTpeOdx25tF7z2xS5Qp63IzmdT72eUo
 oab0YdlJ8hBrZS+RzdHJUSpZxo9ZurIpGjWNB3KnL85blXA3hfCPY0NQPHti6/bWw1dk
 s/92UUD2u2TNnWUZrdiaFYaNwBLaS8ApxpTBxvxhUesmDu0Z5cYSMGJKbtMzJQnw5nsU
 gm8GD31qaN+aZLffYj6FIziipdxGu13TSnikWhrrcrrGPCiDMumWHMc7lO4w1VGC6r/s
 Ulsn/7mZ6+XJRtOlCavg9xjgKC+X3v1qY0eJppSo0MYVKwS1GDJ/3yIFkE/eEBE68KN3
 XRgQ==
X-Gm-Message-State: AOJu0YxMFwbiaZa33opwvikp2lem3rHc+YoDIXZeHPvkpCtnJmbGR4Eh
 Lt5hZrRIHWDdG8u6qjxUEqiio1rLMmV/iNHKfzpCOYKiz8NgF76SkYrti5Q99dcDLWJQh2Ct1pg
 leSA3wWY=
X-Gm-Gg: ATEYQzyvC+8jCjsJ7965Rj5wDkfIUHsGBrkZ7H4vNAwlMNE6Cj0sf3J0RLuQonh/9Cg
 UUDZJKwhA2LWbcjmRkbEmEb1c7oNGz3sObMS5EcNTlrvxyiNHyrDMsHVOdAkJi9OB2cAX2ygG9R
 4rJwu8++gpFnigPqaYbkxlur2TMHU8juxPNkVtaWvHq4qHmF8M8hczDpqEbU36GOexPXPiLWzoU
 rQnIhCKufXgKiueDNXhJiLHeM8Ra7qrNBdiX7cqzzd+mqNv61/8cc/3v9mEtK5ksbwYknfPGbHi
 XQxs/TMt+xiU8tS9CVVSKgTM1Et5tE+rZefNrBKe36jhAaDAlnB1MNWVjN2J3DG4b6iqKfVN8Oa
 ovIJ8snsmxGfo5Cxkcj+3Hc02VF3mJhDNd2zGsQSOr4fX2lCgnqIGZxGlES6TIgq0s9emVhQl7p
 NmLmMom5pcy8/5bHFwJv8Y136RwTZxOsqhmMBERhxGHgbCgKdmuJSqNKt/WW7xYgMrnuR5YZMAp
 YUATQ==
X-Received: by 2002:a05:600c:5288:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-4853af58154mr29535285e9.19.1773009601840; 
 Sun, 08 Mar 2026 15:40:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae483desm19937614f8f.34.2026.03.08.15.40.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:40:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/49] hw/hppa: Avoid leaking a diva-gsp device
Date: Sun,  8 Mar 2026 23:34:32 +0100
Message-ID: <20260308223433.25503-49-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Helge Deller <deller@gmx.de>

Create a Diva-gsp unconditionally on all 64-bit PCI machines.
The A400 usually comes with a Diva card. The C3700 has a built-in
SUPERIO chip, which we haven't implemented yet, so running with an
emulated Diva is the best we can do for now.

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260307195243.8813-2-deller@kernel.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 6b69a304c2a..ec63dc12979 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -382,18 +382,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
-        dev = qdev_new("diva-gsp");
-        if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
-            pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
-            if (!lasi_dev) {
-                /* bind default keyboard/serial to Diva card */
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
-                qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
-            }
-            pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
+        if (!lasi_dev) {
+            /* bind default keyboard/serial to Diva card */
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
+            qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
         }
+        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
-- 
2.53.0


