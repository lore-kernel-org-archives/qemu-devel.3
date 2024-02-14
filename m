Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA98C4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 05:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra7bT-0005zi-Fq; Wed, 14 Feb 2024 00:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7bR-0005wp-UV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:37 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1ra7bM-0007ur-7i
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 00:14:36 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so4337790a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 21:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707887670; x=1708492470;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fiPAxXFh2UsNlgKv2vLTmbdWvoiU4X8Pblc6jhDb2eQ=;
 b=hXNddgfLES/0bkIc/MnOCGtVNxWgTiT/paxfC3a9TzL0zccZuMMNSq96GxDbmCF/IH
 fxK1UVMwrPW0EjfPscdw6yH+gVm+RdrPkC5LF40zBL6OttWWkHXiI7t8RcUmqTo6NJ91
 6Lhv/Z6yU+2hmyihFZuIz88S0IJApup3Bbs24Kt9G0BiweOcVTiWkOGVE9WglZ9TCczq
 AC4E4fqrRV5a0fyLzPhGwWRUanOyEZhOGoKkq75hdBk7WuwUVSMa5YatLEVfiFvCaox7
 ziZdv9fj5U8oIy9v8Xrmwv74HaAQNi9c1XZQoO4waUp805Iqxr4RTZW2JWzZqYcaHLbh
 ttBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707887670; x=1708492470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiPAxXFh2UsNlgKv2vLTmbdWvoiU4X8Pblc6jhDb2eQ=;
 b=RMEH8ORvBftJG6Np6YuYtK3ZNhYEVZJbVVo05S4v8s5geDyZuP4ZAv/CPHXPJTgtSC
 KreMaMPzsHSbrfJ0G8pCLFVeANdYffV83Tlk0J61oQDPOMh/IgTmCpUH7rRrK7nN/zzH
 Dn+SKr4NwkGX1rs3n9BNLJ2Mc1Wa82lL1PXn/8R3rAl2c/wEcfSY1Cj2a9+j51tkRlg7
 6bTEblQkgO4lVgzusMABInFQ48RS5S62PCTXTNaoS3dXqqBaElcPp7MMEnTPKqfwex9f
 Z4G39CrSGP5O6gxLBFpKMfl6eez2havRaY1g/eYpidv/K1ZieiWqPlMmo5opE6bWE4iW
 8JYg==
X-Gm-Message-State: AOJu0YxAzdbfiJzp+plYuOEFQ55eStgIO3kxD6luopRNb0cxlRxG9vXm
 MlPpY7gIZL+5rCi8XnVnY3HbcMGix0pc3PEEb3+pZtYyqKLTlFOF6sF6C+3gFM4=
X-Google-Smtp-Source: AGHT+IHrTcZfLNyMj7tKRCffiwizk1wVp7ZvKL2PYKDrfE8wSyPqQTCWoa83ae7RUMoj3bvlNggpPQ==
X-Received: by 2002:a17:90a:348d:b0:298:b0e3:b3fc with SMTP id
 p13-20020a17090a348d00b00298b0e3b3fcmr1553586pjb.26.1707887670312; 
 Tue, 13 Feb 2024 21:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXgvc0WFvJ27f7zxQ5xkFdxLppnQz6AzbJ8KXi51DBsVJqvXllz7ukEvNZK9Km9/awIM4F3+u83eRDFGQFtTxWOJ5LDPwCt6Hc/Y79tRgAnedA8uLloLmjddETk0rKEgBuT4eUjOluaZoZ33YnQK/OOgXvH9zytQfs21NTr/viEAKBU3CCfkcGWOXMvggXKos+Fqk3p3eXIfvlDwscFMgkQAWtHAnzOEX3/RRhuBBp4MzR7+ID39W+G+QbCdrpT80lGHdRqA6sMiQEv49BXtKZ0HkU0fFe2ZAdgPcnuN+NRpcDdIQ+yQu/L/CHPQzcxxP7yRCbO/7Y8upXpxTV2IM1d75UyJEWHWgDFNsFu6kQlPzhI6R8o58/oSrOgNFGzTEutfrKeVIqmZ+mNqttU23hYXi2faeSTXHbFtAECfIXpDM8w6dfCCoMSFirWZiQ=
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 ns1-20020a17090b250100b002970994278csm443432pjb.8.2024.02.13.21.14.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 21:14:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 14 Feb 2024 14:13:47 +0900
Subject: [PATCH v4 9/9] hw/nvme: Refer to dev->exp.sriov_pf.num_vfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-reuse-v4-9-89ad093a07f4@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

NumVFs may not equal to the current effective number of VFs because VF
Enable is cleared, NumVFs is set after VF Enable is set, or NumVFs is
greater than TotalVFs.

Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/nvme/ctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f8df622fe590..daedda5d326f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8481,7 +8481,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
     NvmeSecCtrlEntry *sctrl;
     uint16_t sriov_cap = dev->exp.sriov_cap;
     uint32_t off = address - sriov_cap;
-    int i, num_vfs;
+    int i;
 
     if (!sriov_cap) {
         return;
@@ -8489,8 +8489,7 @@ static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
 
     if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
         if (!(val & PCI_SRIOV_CTRL_VFE)) {
-            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-            for (i = 0; i < num_vfs; i++) {
+            for (i = 0; i < dev->exp.sriov_pf.num_vfs; i++) {
                 sctrl = &n->sec_ctrl_list.sec[i];
                 nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
             }

-- 
2.43.0


