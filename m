Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C0C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgkf-000736-6R; Sun, 21 Jul 2024 20:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgka-0006g3-I0
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgkZ-0005pE-26
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soMn3N89ArRoaYuQiMsJlwiF6/+Rw+/Rmo1xZeCfdvc=;
 b=YFHFZ9T09vM57pAxUE2WMNJ66WBNJcJoL+VV9LIoO+8AKJzsjg2dAO5kH3DRcm+dogFDOe
 dBqr1QauC+QIei6c5AH1i62306hupF6Rd9szJ3sO+tmFTiX+yt+UZIeBPZPxNl+gyoiwPF
 UcMYMVvM5s7YnvXhbh64KyWrTRVw+c4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-oWOwnOjrMjCqXNFvFaWVwQ-1; Sun, 21 Jul 2024 20:17:56 -0400
X-MC-Unique: oWOwnOjrMjCqXNFvFaWVwQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42671a6fb9dso25237095e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607474; x=1722212274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soMn3N89ArRoaYuQiMsJlwiF6/+Rw+/Rmo1xZeCfdvc=;
 b=shl9sFUHQU2Wg0CQcy60PtLd5AD2vp5Y9YcaHKnXLdXwnq7UH+w8Ac5OMMnj7nk5LS
 hMFmE4rBd6y90HCytPY984AD875CkojGq3Ngv0MzF5z2/a61i7LbNZ/3izHZ4ptQ+apP
 WLsteVVfcOaqBoWOO5pCRY39NEFkpWvhQXyEKJnZt3Vc54/N4NVGHQlCEan8vmbf7PLL
 +9a5I2QHhaqlgy20jkqJtPT3MazUDPPsl8pg6uBBL/c0n74Aw9hgsQlaIdus9X2Z244h
 S1dz25zf3+CJSe46cRViTQrB8+VWdbhJ6Y1KSuSHMDkiy1GhiY49f2OEZaWMg8K5g+8g
 k2lw==
X-Gm-Message-State: AOJu0YxamrPub8uX0xTuAbFLmfgm4VOA7TzYn5Uos2tRzDY92nmEEmiC
 Zzl0zf/IgS0jOPU9P9ovx48AnXH8uZlfVpbsIjXiZ+9XY/Zb2urph/OU07s+Rwm9z3AYVIg1aiD
 I8Q/PPILURHdvkEISjQGEp3M1y1AegzgpEY3g+noYErx1fZhSkg79VUpo1Ps73a3H5QireEf+ke
 Hr1Aj7gWBiPLUrtJuNBc1nwskvcUk++A==
X-Received: by 2002:a05:600c:314e:b0:426:5f06:5462 with SMTP id
 5b1f17b1804b1-427dc57aa7amr27894405e9.37.1721607474795; 
 Sun, 21 Jul 2024 17:17:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1iYZUnOy73eGeFVQLduVJTMa5mysV8XLVpBf34WOI6n3BPgBUvysJuvzSx9JZynd5/Q5NVQ==
X-Received: by 2002:a05:600c:314e:b0:426:5f06:5462 with SMTP id
 5b1f17b1804b1-427dc57aa7amr27894305e9.37.1721607474246; 
 Sun, 21 Jul 2024 17:17:54 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6934ec6sm106848325e9.41.2024.07.21.17.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:53 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 30/63] hw/pci: Fix SR-IOV VF number calculation
Message-ID: <a9f18342dc14c3297d802e4d06d238ac3d311706.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

pci_config_get_bar_addr() had a division by vf_stride. vf_stride needs
to be non-zero when there are multiple VFs, but the specification does
not prohibit to make it zero when there is only one VF.

Do not perform the division for the first VF to avoid division by zero.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240715-sriov-v5-2-3f5539093ffc@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index bd956637bc..dbd954f1fe 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1437,7 +1437,11 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
+        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
+
+        if (vf_num) {
+            vf_num /= vf_stride;
+        }
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);
-- 
MST


