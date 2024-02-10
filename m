Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8DFC4829A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 10:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYkY2-00078D-F5; Sat, 10 Feb 2024 05:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkY0-00077i-Tt
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rYkXv-0002qg-Gm
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 05:25:20 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d93ddd76adso13965475ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707560717; x=1708165517;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=jb3bOhuLabfGKeF6kVh+mDl0WZv+Y2PEyDtA1TmfxlLc/kq1TZWqGjm2ZB0QGJabAj
 FJqPM7ft9DtzmzhdPgmPBwlzNfIwvE2VUTA9C9WFZnUuBYkUdPWaA12zZX8r1Ep6ZjWy
 nNxVHWXWsTxNBDLAgjhtU6gVGpIZXF7DFSLLMqztpYWlp4rHOC8hjbY8AoUU+BnoJsqL
 2BMqS1+1zKVUsHjh4oheuTsskRjaCM/RY3ntZ0vWlC9FyAJMNEWBey6h/h8hxuHuWWWJ
 r9CXGXmmdkoE5EnqnYXMNYcYrk8BriTmOObKg0oDYzcG4tXBKLWtbaZMmhnGo7cGtxeh
 nhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707560717; x=1708165517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=vKoVfUQ4/2S1+exslwV1ac7yXXHWjnnS1UcNK9o3M0Mg0GnJ7pVOFABUPLy0rSDY1A
 S4+XDtX3Jsq5moel0TeoM22IexVYOztQCyKgBsyVkTNU3/8cEmqC759XHu2CcfveGuTR
 sTO5MCYdA4+LR82xMUqPEKBf1EBLVv1Gl2DboMtn9cyDwpUy2xlJ7GsO2oq99+y8QTnn
 3OV7MwtDzciQI/Y+9/bgMklKSBIq8uHGn8Luyjf8jsHCx0C8Y4R/CcQwwonzDJ2JQ+mM
 nR5KdybS+69ngbQ08sBbn6FI+Fs0EyXXChcneO9KReLE2OimASz92O9wJ2Prfde1aN1n
 uW2A==
X-Gm-Message-State: AOJu0YxE5s5mQjf2dbkqIJFMEH7V9uxz4njE7AXqhNmuziQV+K6t7AU5
 fcZZ9Q2FoQNxA3pBpBAW8c+uMH6T/ffDiv5gzozJ9Erv4/dU+LTgpy6fOrXTVgA=
X-Google-Smtp-Source: AGHT+IFNfUEb2c0Wqf+kcJOVHVMWxuGdI4nhv0ayt94jpSM/KDEF9RoKQws+A26PZM2XIyxcRHaCcA==
X-Received: by 2002:a17:903:1cc:b0:1d9:8ac8:d79d with SMTP id
 e12-20020a17090301cc00b001d98ac8d79dmr1933607plh.19.1707560717406; 
 Sat, 10 Feb 2024 02:25:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXOwJUIFYlheqwOeaAiQJFsc8BDXryn9ieggJhHVbyj0uFPqi4sML/EB7UpoccunzM7m8UgS8/QaCdRXYxWPwv979LBKcTCdNLCuZ58zWALFuwjTH4otveBOlx/SYVEOfFDQrrOLvRxIGuxw9u/lPybTbc8fgslAnE3Ol95jrQe5LbpuLGJHzPQFTCKVofFEadoF4MYgqtZys78T5SAOqjw/qnzYCZfn55b2cKGrXDrDLDbv1mLmLKjejkdUM8fyaYPhP2OQSeoNlJkFu8H+FOOZw8KikEBrWn0BDQsU6xggHDdh/GV1AtdroqPRN+tgTlbHnh4zjHGRNerbpyxxvR0fp3LnCNyjYEp+rbgtJ/UVq5uHf+NsQyfgq8qHeS6EXEMiO7iPXpzGPk7Ig/3vsW/x6wEj4xpXwpRf/xe8Q==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 v2-20020a170903238200b001d7274cbd33sm2781554plh.121.2024.02.10.02.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 02:25:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 Feb 2024 19:24:39 +0900
Subject: [PATCH v2 4/6] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-reuse-v2-4-24ba2a502692@daynix.com>
References: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
In-Reply-To: <20240210-reuse-v2-0-24ba2a502692@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The guest may write NumVFs greater than TotalVFs and that can lead
to buffer overflow in VF implementations.

Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a1fe65f5d801..da209b7f47fd 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -176,6 +176,9 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        return;
+    }
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
 

-- 
2.43.0


