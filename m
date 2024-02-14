Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F28EC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7bM-0005vn-F5; Wed, 14 Feb 2024 00:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7bL-0005vL-3s
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:31 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7bI-0007uD-K9
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:30 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d911c2103aso25836525ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887665; x=1708492465;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5zPblC140h1Ee5DUGEevPBRRbeJIXN5dk7ADyGIIOUg=;
 b=VuKf7RkYcsI0gJrOq1Lap0GeZ5kWmvoAyvREYRlmvJbJCgrXIqPJL19GV6ePwrl+aT
 4OzmAgLgkRN7rAUG5qLuZF/4z64nCIgwt0TTa9CZ5FT+podqd5XaJfaXJtBltkkoU5pR
 beqrczoo2CgPLFfKDQNkkewVKLxlrKQ7YInlZ5J5iO5iooNvJw1iHm9QiVA09+D4jlDQ
 FrvPA7KB+tlKehp8eDN6dfhi5TiRuNEL6J6qZO2MjLZ8hwa3/WiYOzvqmOb62vnrITyD
 8I0CO3kwMCL63kDS7qn76qC/j0zbIY6bzyuFl4Q3gABo2hnZ8k3EZj+N/S0nooU3ekdf
 YQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887665; x=1708492465;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zPblC140h1Ee5DUGEevPBRRbeJIXN5dk7ADyGIIOUg=;
 b=qU/5pdtg3YrryxLcKTgPLZON1QAwIvqve6u86vNz+BAnknst5F58KXKmDFWYt9jSrc
 PO9l9lDSk6jLfNwSy9XRoZxfKuhu7LFOWfR5RUda2IBqCGdMOKS5CwPbuk3NDTMOEcV7
 WLyXVlLXUG66GDVSXuAC97mTBODWjNiZJsdX7X2fJrUA2yJSKHmhFlg2x68XMr04vK0z
 x2RPYi3qBpCPCvKzv/cRMk2DX66tMCAob5xMUoBFHerOC7Xy/FECPt15o9ftaP6l+xLc
 7ZOeZMcJEShvvqOcpBdVTT/xzKYZ6X77bJHsFEaz9Y+kPDU3oeCLXfnvUGGg+54mtigA
 MqvA==
X-Gm-Message-State: AOJu0Yzq7lmEX3O+JtmZdx5QUDMfLag8Tm0G4b7PH4bh5rBS6LFR2Srl
 jexU7AJp6Mmf47MmL8Y3TkekvnE19cmS7Eek5fmtu3QKEeSnB8+wrvnGNRGnkRBwoqaD8B5CxbR
 t
X-Google-Smtp-Source: AGHT+IEwa2mo30f+EVn/lnpF0N6aSWnTiryFCxVJ+ha05OyiotKvzCnH4arzVOIyYd58G5U7tqvuZA==
X-Received: by 2002:a17:902:e74f:b0:1d9:626b:ae3d with SMTP id
 p15-20020a170902e74f00b001d9626bae3dmr2428312plf.18.1707887665104; 
 Tue, 13 Feb 2024 21:14:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YeqgYPCUI2Edy+zFrh0YR4KHoh8FWPhQZwe3FOOEGJ2BtFYrRpiFgUK/Qzj5IAJoThVCnTRvcvENqz5X/Q2gI0ndFejzLuWdT6INHG7okPgB91Kw55K99DdU2PAgDzhW6y7tkMhgFiGEyEXNFPgBNVhhEiIcYVpPTwmY48K8UdmcY9Hr48cqVt+NsybfJwJW1ce/oFyHZsEydtsLAqYPh+Vwo6pq11U1SZhvyta+Djl4WbIAy3uBwo6Znkk9wLNMpe4CLbHplLM0u8FjDd67+F84o8wACVKnx/urmV2L+DrPwEZwgo1x7PN+M+tuzMsov8DaPbkeBTk+4NkFLpphOMg71WAWq4ju7Z+vhuULFrcDHKdXKAaqr1lQXc3Uzy+Z+7YDmlchTBKgaRmfPNmz37Mni31Ts0m23yzC3V9wUs0GV3X7A7iYTM0IJn4=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 iw2-20020a170903044200b001db57e999dfsm408298plb.81.2024.02.13.21.14.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:14:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:46 +0900
Subject: [PATCH v4 8/9] pcie_sriov: Do not reset NumVFs after unregistering VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-8-89ad093a07f4@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

I couldn't find such a behavior specified.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 9d668b8d6c17..410bc090fc58 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -209,7 +209,6 @@ static void unregister_vfs(PCIDevice *dev)
         pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
     dev->exp.sriov_pf.num_vfs = 0;
-    pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,

-- 
2.43.0


