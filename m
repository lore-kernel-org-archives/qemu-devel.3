Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50CCC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDDl-0008SD-DU; Tue, 23 Jul 2024 06:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDf-00080M-3y
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDDd-0001zg-Bu
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+eij6Bxq47w2bciZE/Rv+DzW/akdlQrWlADFCMstsmc=;
 b=ZSeOqHK2T3nT+rfFombdVcI614Cs36Vu0twnnA8najaylT5OVrwAePWaR+sR0izsiY1Kuf
 469YKR07LPzZbuItt+ENZNEcaoA4EOmdum16sY5wwn5PuEj0fdVVn29skHoOGVqqBhI9xT
 dEoCvHfz7gC2T7dS2nDXpidp3pnaYB0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-TFyoPy-rMqKg-szauTTM2Q-1; Tue, 23 Jul 2024 06:58:07 -0400
X-MC-Unique: TFyoPy-rMqKg-szauTTM2Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a77c9c6bdadso49428666b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732285; x=1722337085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+eij6Bxq47w2bciZE/Rv+DzW/akdlQrWlADFCMstsmc=;
 b=dM1gCBTCAjBJ3FxTI19U8Q9bopR1onOH44Sqp6lwafsAKrBLE9yJxzNb3lrUObmr8g
 bGH/wl9PfS0kdYttg/H4U/sShSj8V8t3q/lqhvkIQJSDIwMtUCX5KyL13omFZtrLFsH3
 7hkHCrRmgMKOier8em8df2efHUZ+E8K5A+JkVaPfr9U2ncz887JyypfDUgb2ym29RTgW
 Dbx2FIckZYXCQOHbUNOyw7RqbCEhsyNKkZLhtIE4LE35TrZHAng7LeGXhLyf9itCYZAf
 +UIyH2yIjlzxeZOUmQeV0t7qXuh7ghMXhVbd3yc823WPLmTj+GSVoCyNk58l9ABe6gyc
 AMgg==
X-Gm-Message-State: AOJu0Yw7t/2mS8/o0eDsvUABj1rOTG4fPv3tOF+7IKeVvFD+j4iMTn9H
 cYgnC57cOzJQ6inEP1IC2J1mFfwp6iJluFnxKqw0QFEKGMLCVGzzXp1RyNvtNgQJVlWLfOj3C03
 WjQghkB/TVTXFm7L9fjFdgpRSqD5X+7k8SJxIbOT72XbR2GRW+x0g9qZG3sqtvG7wOFCFo/YJYw
 Aw2lsQc6AwlOuD228BRzavKg+WdNeQ4A==
X-Received: by 2002:a17:907:72c9:b0:a7a:9ca6:530 with SMTP id
 a640c23a62f3a-a7a9ca61448mr102186666b.15.1721732285607; 
 Tue, 23 Jul 2024 03:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAMQsJhpmY8QtPvRSK0lRctPSq9aimacbA+5UIDYnlMxAhSumexQia6lfbGizwtruv9bbKLQ==
X-Received: by 2002:a17:907:72c9:b0:a7a:9ca6:530 with SMTP id
 a640c23a62f3a-a7a9ca61448mr102184666b.15.1721732284957; 
 Tue, 23 Jul 2024 03:58:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c7b650asm524771166b.49.2024.07.23.03.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:58:04 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:57:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 31/61] pcie_sriov: Check PCI Express for SR-IOV PF
Message-ID: <47cc753e50076c25334091783738be9f716253b1.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-Id: <20240715-sriov-v5-4-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 6c79658b4c..15a4aac1f4 100644
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
         error_setg(errp, "a device cannot be both an SR-IOV PF and a VF");
         return false;
-- 
MST


