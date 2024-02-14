Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E6BC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7b4-0005sz-A2; Wed, 14 Feb 2024 00:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7b2-0005sH-Or
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:12 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7b1-0007sJ-Dt
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:12 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c02adddb8eso3062406b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887650; x=1708492450;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=jR4I5L1eOPJD0C50DTzk7y9UYVagOerNrEEqeGk9BGIaGVkVHiUCxcAV1XXOYe0vZi
 Sfk3S+/7aLiCR1SlgD3ynBt9XtB90qS75lHcohKTU5IHxDoEtt0+7mC+vlCK5ONLkAi2
 f7pzFHt4mIVT3Z9OCS7/jV/K5FkMIvaNe+Y/XfAcV7fxooxPRQtyQl8KRNr4+4Z+yYiT
 YCNOaJ/Qpzsc3Ykthw7M4rOxz2ioItD9tnOIxtWSIVzHJpSFf2p5/fmJMZwBbf/td1zr
 PrL7Lo0YQG3Wn4Ef5qzOsUVxk9wVCTY6L1JpfNgkyV735Z2oLfaLSApve/VvtOKGheJj
 Hevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887650; x=1708492450;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sVsDDgcIpEBlmcq1EWawWovzpkmUUsK5fa5lmtMzwhw=;
 b=fkErmi9ZK0zghR4yvpt11tK6eBlHDQCks+J6mBYkPMneU8/qsH9H6YibWfPVsb48SX
 E8kpMc9358WuDsqp6ILhakhihqI9Z+gcJ6v+++yRwRfUTwyQ5YYiQbbGkPszTeL3ixVD
 QLujdw6N8+Hp4V9VYq4YkZgWhdfCU7z3S0dyRPfQ7+/fTwOLawzxhShpeXZiXbD1nUBd
 PjggE/knN61TwcVnL6JsGuk1wVMLBFwwvrU+58pBVohEgkpmfOOOrw7OfXXkDKPNcgbE
 FnRhMAa/1CaiMSrGkErMAzGI/5FqgAbpW48X7eBytmL81nJAVQbLmjywEpBnilv6QaJ/
 T35w==
X-Gm-Message-State: AOJu0YziBSLG5h9C4KQqV9C3PPXeD7iWdBmLmjzdKE8VQWqNlXsOAYeb
 os1/8AHzM002pvsdyMF92UBuE6GVIKj1kZYrNSuSlNHn4pmdDHud83nzDz5SiJU=
X-Google-Smtp-Source: AGHT+IFQ+QZu3dNiTd7YAMs6Qfg5c7w1+yTOtPcN2oHwUWIhrGAcX+U6M2805pVA5Cc0mQZmysDThg==
X-Received: by 2002:aca:f06:0:b0:3c0:48aa:1bd9 with SMTP id
 6-20020aca0f06000000b003c048aa1bd9mr1572762oip.21.1707887650412; 
 Tue, 13 Feb 2024 21:14:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUIakWlVCQZYSpZlMrbN9Q+n9UrKcVpXJeJdP1ZmR5Kqab4FY/qOVy7JwM7pgUEmo3m/uRfq8L9Pt4Y5rCXYNgs5D4AoKOyc7ZGBMO4S6b1q0vE/7S/Td6nCk3GQvx6+W/oXGL47ZOtHBd/1ikin8GwCrKu07jrsTeHnHBwaj+vxp3VHeEblZjtRwYGX5e7xCRaAljNUtEz5M1u0jIrH9+C8cJ/rmyD68vkd+h6gVBSfa4UWNGznneT7rF2b7GHyAiegHSlgu7zghpGZ3Q37TkDxHF53dh8zmMdAF5eHjoGlhbkOWsGP28o9Y88mhz7bPVKF2WZBwYQbB46JlorgWlay6Tg/y8vgZ1bNhMI9//hSQYFee2rYJOe0Y7bLo3M5nWPiJt22tDWzbC1/9bFdAzhNyi6DSCXJiTAak+hdjVKDNKyPvO+234Pu4oT4tI=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 h28-20020a056a00001c00b006dbe4452741sm8366599pfk.72.2024.02.13.21.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:14:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:43 +0900
Subject: [PATCH v4 5/9] pcie_sriov: Validate NumVFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-5-89ad093a07f4@daynix.com>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
In-Reply-To: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
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
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x234.google.com
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


