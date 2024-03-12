Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D92EC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 22:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkAbS-00010Q-Rr; Tue, 12 Mar 2024 18:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbB-0000Io-P1
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rkAbA-0004TW-72
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 18:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710282471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ZUqhBABaLKjAmH/al3SU44QSVSzRDb6r3qc1ttxIM8=;
 b=AWKVya8xCOvu1wpQ/e0N8Dfo4h1yJpQW5HQALux+2XT33u1uBCDcq09+mtva/jG26Ue+o5
 N2uisTtrKiYCycP8mgLWSwL1SGDUNkecG5a+VC9lrBDJ7+r4eVGiLBcljzFzg/7Q/pQQ0F
 qhNP70PaXpzMpOdbkrtDL/nlH7VxumI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-8I-Z5UTkPoS3tK-wYlD00g-1; Tue, 12 Mar 2024 18:27:50 -0400
X-MC-Unique: 8I-Z5UTkPoS3tK-wYlD00g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a4488afb812so23139966b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 15:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710282469; x=1710887269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZUqhBABaLKjAmH/al3SU44QSVSzRDb6r3qc1ttxIM8=;
 b=R4bGbcUT6ab772edHu09Sj+Z0YU+cLp4TL5fQc2vjHA5gs3mdnVEOeoihMr2uDCxKG
 +FOB1S6W5eUQO8um3jGalTNMzWx9T+zn7NKtYKWLDbZXU1A1Gcgum1EZhEiqBqxTH+LE
 DUt15k07jZ8EvPv/7A2gETUX9TmolBHSXH2CaMo3VndQtXT1bCvc6urF85IpkrfDAIfl
 Gjp6ya+QQ1WoBPUmgDeF1t74UdQOsXMezGSjVKE0XKADK8W3afvs56eXfKOHBLSc1j0q
 IhUj88AVaKkTlfzE0KelRjIRUjrwZg7XuRjM6rPwRqW0ESEt23VT+vhIikG1LPbZ4Cyo
 8rnw==
X-Gm-Message-State: AOJu0YwLUAeYOl8t/+39Tg2wdU7QIWMN8dZulgdBLjzFTiA/oQV+aSTs
 hzvy20GfRlCcrCqU5bNyyNTGhhHWlRR8oS+gAgJPxOZRutWQCPt4RWTZLH4Rp/1g8vDHDpRQhCC
 q29qYJ3kwde7XNI4L0uKbl9QAN2895DnYPRvHNG6+biy8G5YBxfAytQUrARpFKp+GkbtdWMWO3Q
 s8rGTgDg8R64Q0rYFwZKo+LLFRvshsSaj8
X-Received: by 2002:a17:907:d406:b0:a44:8fa9:d36f with SMTP id
 vi6-20020a170907d40600b00a448fa9d36fmr1092528ejc.41.1710282468762; 
 Tue, 12 Mar 2024 15:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5pw7kRt7c+5TfJrv0kbEABOl2QpB/bkvikW4SIAjo2uhx5MPcRI8ySm4lXR6t6FSz0JPy9g==
X-Received: by 2002:a17:907:d406:b0:a44:8fa9:d36f with SMTP id
 vi6-20020a170907d40600b00a448fa9d36fmr1092513ejc.41.1710282468144; 
 Tue, 12 Mar 2024 15:27:48 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 be10-20020a1709070a4a00b00a461d2a3374sm2893740ejc.47.2024.03.12.15.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 15:27:47 -0700 (PDT)
Date: Tue, 12 Mar 2024 18:27:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-stable@nongnu.org,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 43/68] pcie_sriov: Validate NumVFs
Message-ID: <6081b4243cd64dff1b2cf5b0c215c71e9d7e753b.1710282274.git.mst@redhat.com>
References: <cover.1710282274.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710282274.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The guest may write NumVFs greater than TotalVFs and that can lead
to buffer overflow in VF implementations.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2024-26327
Fixes: 7c0fa8dff811 ("pcie: Add support for Single Root I/O Virtualization (SR/IOV)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240228-reuse-v8-2-282660281e60@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 hw/pci/pcie_sriov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index a1fe65f5d8..da209b7f47 100644
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
MST


