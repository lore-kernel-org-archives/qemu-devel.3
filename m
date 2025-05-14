Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EC3C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdX-0005uk-0Z; Wed, 14 May 2025 07:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdT-0005uY-Nv
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAdR-0006An-Cg
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eXEi+ZXhQRm8J6CUw9m455HBJJCx9rS1588hLPX09Vw=;
 b=gVEqvS9mF7v5pk2QzIMiek3OWKfUYI7nqsJww/I1/tM/ijA1Pgr2Lyuvf/NrhivVlAi4U5
 GGF5VLjakoEh3kZb/KI4JFSW0gVsFShBWs5TbIlbNdm+6v9Q8YItFBKzwJtPsXsGew1WjH
 kYZ28AxHbQ0/6Av07/5QRGLAU2PzBR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-vMOGQ0FjMZSiMStKBi6mTA-1; Wed, 14 May 2025 07:50:47 -0400
X-MC-Unique: vMOGQ0FjMZSiMStKBi6mTA-1
X-Mimecast-MFC-AGG-ID: vMOGQ0FjMZSiMStKBi6mTA_1747223446
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso34303235e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223446; x=1747828246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXEi+ZXhQRm8J6CUw9m455HBJJCx9rS1588hLPX09Vw=;
 b=bPCHkx6f9yo9GtQNmscAz8j8oMVOL3HBs8sfrIF+vqSCa8ckJI0ocf1lMCg3687ASO
 0OjwdSc20m4XpRjmnLiasDuRKeOB9lcShRCp9rOBSQxO6yNA1ZpNCssfwaT6ozPeWlGh
 ecVRDCDQDj6XpzPzH3MXW2vaGn2FPYnn2iS5EXCXOr8ToFQSSIdA9aZwAXXC9JFeOOL7
 HNgWUA0SQCrIL4xKbN4h1/KezzCzr272An24tt759Bc+pTIasbPzxclAhjGZIRfjWACz
 8CSRi2LkI8JquVQhBua8Rswry/icgsSSfT1i2SQlpwG+Uv9/o9NYuJl+wMxCTH0VBj9v
 v/gg==
X-Gm-Message-State: AOJu0YyAEBeADuvWBaGoN1/PIrT7nLzIbNe0mo3rsvcKa5mGOpB7rQMm
 xxLBGOp6BHNELJd1kA6886SYb78YEGY8yeW+V4QW+oqdNc48sqVckco6fQRixWQX2VLfHSAsBrq
 lPNgV+/utL80Bye30DnkAH/E4L6VcRFDGlIS5zIUm/FxGHrxgOuVWg6C2N9bSO7wqdTONbt1AKE
 1ujUf54keK2x/izxCIiiclAV3NnI5v8A==
X-Gm-Gg: ASbGncsBIOvk5CNgeC/yMi5LW3AAnxaRqLh7owYzOFipbuRXut2Jrbi06Hl6qAR6iR2
 T99US/DvZFUH4YV51w1zuGkPA4gX5TKsV6ItKVAMxOsqFZF+UZOwz5m0/zclQBbE9YN37w+JGHv
 kYDrGSCIjmLKz0VzkC3Nl3Xy2rvoCa+YEgiFvMSZzBaapKH5fSlMd3kiTWttEooPSucJq9SsHta
 6WqHDetwLc52ayalmdXOBXfVQo9c7ClYJja9UzUXT3rfIj3cJqkzEY8S7AsldL3mgxUcnJsRG2N
 uuk16A==
X-Received: by 2002:a05:600c:870a:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-442f20d6d7amr27483015e9.11.1747223445723; 
 Wed, 14 May 2025 04:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlS9jeWElE4FTTUUj1PM2YyRvbk8jqihcCPk1s1t3nKIlHdiQ1HT2pkDqb2xh6nTA1mSScdA==
X-Received: by 2002:a05:600c:870a:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-442f20d6d7amr27482795e9.11.1747223445315; 
 Wed, 14 May 2025 04:50:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c052sm27867335e9.29.2025.05.14.04.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:50:43 -0700 (PDT)
Date: Wed, 14 May 2025 07:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Yui Washizu <yui.washidu@gmail.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 11/27] pcie_sriov: Check PCI Express for SR-IOV PF
Message-ID: <d2f5bb7849e463646173564fdadf40e32a32bf6e.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

SR-IOV requires PCI Express.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250314-sriov-v9-4-57dae8ae3ab5@daynix.com>
Tested-by: Yui Washizu <yui.washidu@gmail.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 109b2ebccc..a5b546abe8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -42,6 +42,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (!pci_is_express(dev)) {
+        error_setg(errp, "PCI Express is required for SR-IOV PF");
+        return false;
+    }
+
     if (pci_is_vf(dev)) {
         error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
         return false;
-- 
MST


