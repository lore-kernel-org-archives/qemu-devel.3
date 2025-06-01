Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FABC5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYu-00022v-AV; Sun, 01 Jun 2025 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYi-0001sz-J0
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYa-0004Oh-Sp
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae+KwjiAG0ycwIGxgYOXtWkgDz9Lvz7odZpaInVMJP4=;
 b=Ls8yQJYthO7pZSxAmG3DxfZjcsIidDibJn4iGJL2HL4dzjWunOaZw/8hCKRNdEHRZ2ujwR
 gFMCTWTEbAtH0K01IMSOcID1+9Jt/rFRya8jTRvipbA+D7kCTTaYEIgUtLZYeu/g17Cct+
 7GW96Dd/7Sunb7TrhiivGDRMvSv+TIc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-nP7J-zssMv6P2sK2Lmh6CA-1; Sun, 01 Jun 2025 11:24:57 -0400
X-MC-Unique: nP7J-zssMv6P2sK2Lmh6CA-1
X-Mimecast-MFC-AGG-ID: nP7J-zssMv6P2sK2Lmh6CA_1748791495
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f4f2so1312269f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791495; x=1749396295;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ae+KwjiAG0ycwIGxgYOXtWkgDz9Lvz7odZpaInVMJP4=;
 b=kAvlUE+QEokUrP0rxwMtqsgBq/clFTzmEBhYpW8qaXRU6FFN/humtPylWiQs9Oh9pe
 PZ2FKQcqujQu87gSRjPxC4My5xykT/WaP3If3yr4b321TwcG654OWME7m+LjBVBCn81V
 ZiitphitwU7AMV4MLX3iUT3fmirmr9tlUVEYyt33hiQA/ePGcXOk7BeYI6zk3wXIkvuo
 KbCxsy10dAksgZ4IV9UMgLor3/Mz+nu3MQTHKq6frRtF8U+mat84oD64Ok0adVnfFwCW
 bWW0NO9d2XCWG7U4TylRrNBILsFjGDBTJE7KqzBnkXRX6pven67GQtEBjLMTMWSpRuKP
 hYUw==
X-Gm-Message-State: AOJu0Yx1VGHtrEp+vPUorwP6SUBCRmDpVbDjOHVzB4P9GEcSvAk3VP4g
 vALf/ZzJiNA+l52/YmKw8ctA6sLP7yWg7lhtQCf8o9qrngvhrzCw3fuok4UzswxjLIrjmk0GMI2
 hqcOC8Y5fPYmSxSOnqS+Aiy2trtF0Ic5fbK7gC/cuK8cwOeaR9KavMk8xpu4u2P7kiOSdRzYd4r
 dAWZQjFTH31fQK4TJRH3J3WB62aJf5kQJhWg==
X-Gm-Gg: ASbGncshBqnwh8foFu++E6Axgv/iLakmgFqwnq7LjZs+vzYiyruEOGIl/MsJU9U3db4
 WP7aWBXN5K/OGIrReuvHJG//MQsu/9FDkGAgG9lGFdqxRUlexmmlJuVswBO05rPor0R3FTNU4n1
 RYPPLdIum6wsGvXuA3e3v65SXrjZlJIjhcNFjC1pOrPo1icV2ExnB7G5F7LI5lhV2VWWb8Esuni
 F5q3dX6ieyfWg+6dRRkccnIlyZFb1+RD9yzM3NAW6cNPBx6A7EDf2TdIeHTbRIXXS3wsq5heZ0W
 6SNfXg==
X-Received: by 2002:a05:6000:22c6:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3a4f89a7eb0mr6344866f8f.10.1748791494998; 
 Sun, 01 Jun 2025 08:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYs5M9CNTTnil6qdeTRlarfVIfVdJ+8sk+4Yu+I5oNukMVcdME1fc855fhEtx0h5Jl7pEjWg==
X-Received: by 2002:a05:6000:22c6:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3a4f89a7eb0mr6344842f8f.10.1748791494552; 
 Sun, 01 Jun 2025 08:24:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009fb0bsm11545616f8f.87.2025.06.01.08.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:24:52 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 03/31] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
Message-ID: <0f178860df3489a9d3c19a5f7f024e6aa6c26515.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vasant Hegde <vasant.hegde@amd.com>

If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
But if vCPUs <= 255 then the common code won't calls kvm_enable_x2apic().

This is because commit 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM
checks on XTSup feature") removed the call to kvm_enable_x2apic when xtsup
is "on", which break things when guest is booted with x2apic mode and
there are <= 255 vCPUs.

Fix this by adding back kvm_enable_x2apic() call when xtsup=on.

Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Message-Id: <20250516100535.4980-3-sarunkod@amd.com>
Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 17379db52a..963aa2450c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1715,6 +1715,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         exit(EXIT_FAILURE);
     }
 
+    if (s->xtsup) {
+        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
+            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
+                          "the KVM side");
+            exit(EXIT_FAILURE);
+        }
+    }
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
MST


