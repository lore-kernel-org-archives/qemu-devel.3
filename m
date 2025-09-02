Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA68CA1009
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmq-0000Ry-Ij; Tue, 02 Sep 2025 09:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmc-0000Kb-4A
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmW-0004QY-8i
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so3667653f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818636; x=1757423436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4QpZjSL6WPJcyAyM7tOCiJYUHX0dh90dWBkQ9yGcfOc=;
 b=zuZgKjrgQcKGSyJNiL+q65ZjZXJx8gMsHrIDQQAltkXN2/zMyzDVPOLfBwKTIzNSb4
 U/YnSIozQUWRr3cN0M4dboN+gphFM/oETydO+OofYUjR8Ukse3LrH9RALPW/nblINRPc
 3dxpqkcU/XwsJJzvwpfPqm+sDer6zYbvhYJPLMSfimtPl0XsVBprCsxSkH6tZPCn52AP
 Rf0TrTWvSrX0wiBm18g/VlpSntM8e2LJiBIJKfW4A2BUfnJsZo0RFeHvBfxs2DtMCrrb
 3ejBhAgbABsmNq0xNSRyr3Aep+073XgpF0z7dyxu/rFPcQuj2nqHfLVYNmJ4DP0Mr5Tb
 Dqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818636; x=1757423436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QpZjSL6WPJcyAyM7tOCiJYUHX0dh90dWBkQ9yGcfOc=;
 b=gIFDqwW0vC80yrjR48+zYAwbwnszax0RR80jkBucnOZ71saEcXt2JAZXotXQ/9+ALB
 NE6bAHU21XEui7N7YYMjcpXlanFWKXr48VhRPV9tvkehkBOXZPcBA8WKFz1O+32kzy+L
 Ze8/gYjKpc8DDsdyLit0l5P8M+KTAcXR1hgUiTqvjWCPCHEsYVMikImKliasM9Nvv6pq
 7Krb73gcflbczT+CC6hmRMcM9uBP9B2iqXy8w27/eKH2e9XxJ7RkQ9erhPAEWdvLbNBb
 YBiE1mTrNSrVsWA8iqGHjm4mUVXmE41Sybpzk/btuyYITaCriYC0zqiHyGz2zX5bsiwC
 9MGw==
X-Gm-Message-State: AOJu0YwiIACW+vy37rM+HCbpojdupsGvQBZAxFimdu1XH5bT7dwPJDtJ
 xKsZS5fQ2h42xPiRj8Fg80RDMf95oHqKeQZdlMneF5CKkAq+ukYv4o76u5if0sGZtXgZjbvcz3n
 QTqdx
X-Gm-Gg: ASbGnctM0ka71Pe9ShP+Hq/cYAWJFKeur+vRZBsZSsnyHMQVS4Joxr5DjKk/IRh+qet
 UzmrQcX4PfXAtdNSFC9P77gOQJoOUzUZv3ob28yHs6wrx3MqHn359M2H0Tw780fWHd0ay5ueWnl
 WmBB8PJA2MqvYDPN8BjKvXFuzN03aRu88GMPnJOQ32xrsAX1wFuXslqcPKM+CY2rZ+Dsnk+hk0L
 tpJQit9Rwe4mceBx0GQqVASZo1EnRC5z1v5PN6zfRwReDSS5yMfVcnJfql3QhdnapX6vWqe8a6R
 S6AYIm31IQVRfuCc2LM49Q/u78cRzdoWLbnxn+hr87E8Th7gyxuFFQY5QRdCCLdH5eS/R/iSsYj
 R/VtToJCHVqp1nN4vR9ALpeqhB7e//gQuZUwBTd7CEx1OQN+YwZkV5x69/QML0C84bfTPXtNa
X-Google-Smtp-Source: AGHT+IEyEaV18L3elJpcwMMrHyxVDhHkAYqPgg3M31y/CLqCdO6J18EiF0YzTYYua+RlVlcHIHqdmQ==
X-Received: by 2002:a05:6000:2102:b0:3d3:8711:d934 with SMTP id
 ffacd0b85a97d-3d38711dcc7mr5124643f8f.14.1756818636432; 
 Tue, 02 Sep 2025 06:10:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a7691340sm18704464f8f.39.2025.09.02.06.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/39] hw/pci: Allow explicit function numbers in pci
Date: Tue,  2 Sep 2025 15:09:41 +0200
Message-ID: <20250902131016.84968-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Since there is no pch_gbe emulation, we could be using func other
than 0 when adding new devices to specific boards.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250901102850.1172983-13-djordje.todorovic@htecgroup.com>
[PMD: Compare with null character ('\0'), not '0']
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci/pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceebaf..297196b2421 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -984,14 +984,15 @@ static int pci_parse_devaddr(const char *addr, int *domp, int *busp,
 
     slot = val;
 
-    if (funcp != NULL) {
-        if (*e != '.')
+    if (funcp != NULL && *e != '\0') {
+        if (*e != '.') {
             return -1;
-
+        }
         p = e + 1;
         val = strtoul(p, &e, 16);
-        if (e == p)
+        if (e == p) {
             return -1;
+        }
 
         func = val;
     }
@@ -2054,13 +2055,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
     int dom, busnr, devfn;
     PCIDevice *pci_dev;
     unsigned slot;
+    unsigned func;
+
     PCIBus *bus;
 
     if (!nd) {
         return false;
     }
 
-    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0) {
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func) < 0) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, model);
         exit(1);
@@ -2071,7 +2074,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char *model,
         exit(1);
     }
 
-    devfn = PCI_DEVFN(slot, 0);
+    devfn = PCI_DEVFN(slot, func);
 
     bus = pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
-- 
2.51.0


