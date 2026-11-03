Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95D606D81F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ClGaJCV3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hcXKTcBE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD2S-0003l2-L7; Tue, 03 Nov 2026 06:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2O-0003gR-Op
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xOD2L-0000Ko-D2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793706644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7QHNDyK/phJ9tU0kowrtkVbtSo8Bjfz9PyfAuxDA36k=;
 b=ClGaJCV3Ua+i26nRBd9oi/8GNh1m+xMu2WZy2/xPLBvv9LhOmMJ+AvPMCZxU7IIzeZaW3n
 Q7iQSPXORgJ23x6XudmIeYTuBLhyziqSbosKDMy3FphtO5BbweIQpyeV9NtGw+cer7Spbs
 Upy2imGoDBGXEG7z0hoDx46AOBmF8Fc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-lG6V0QNhOpCH_4zBnYcFdQ-1; Tue, 03 Nov 2026 06:50:43 -0500
X-MC-Unique: lG6V0QNhOpCH_4zBnYcFdQ-1
X-Mimecast-MFC-AGG-ID: lG6V0QNhOpCH_4zBnYcFdQ_1793706642
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso36228815e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793706642; x=1794311442; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7QHNDyK/phJ9tU0kowrtkVbtSo8Bjfz9PyfAuxDA36k=;
 b=hcXKTcBEpJP9KZvZpQd+B6yPT17tmxe+o5usAzBg3U2dyHj2SL8Dnn+JAn1PvGTfOD
 DpD6QC9haUa2oTKegp22+zkei0RFdpVCxdn79TIpzQao5c1sXiRZCuBiV9Cat4a1zgUm
 0WM5O9rXtivpkDm9TQVSEm78BCohjdIxW5qDPXJrmq+eIf9UJ2WSk56XGvLfyfM1a/4B
 3Neb2eZegb3SaXQ1gvYlXuL1F2Romp2HVpBsfNqdCByl5DB6pKEmD3yLPcmL0A9FL0tr
 oLDz5+3cJPOvEJ7Wr8NdCSZ/UuIat/AkTof6ynQekBLO0lfJ4MVz1vZ7v01ZUm64gAEz
 Mb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706642; x=1794311442;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7QHNDyK/phJ9tU0kowrtkVbtSo8Bjfz9PyfAuxDA36k=;
 b=z8NT1shn2hnaW1Cm7e2YbMDr+etuV+KznqQuy86H4Eg2bNeOwOnkqRqkiN1XRtbxyV
 VugoIi2eBJUV/4QByLw5CNAmuglxwrC8QLV1ppML1EK00MuFCIFaAdCQw1+c0lzXVrpm
 vFBESBZ8ZSpezh3sCYTGWpxsFfz9eV3ABJSSilOyQk8cGqH2/GeKoXAZBzmP2HRzCyMC
 q6/rUY3iK2AvdUrZVDn90dk8BF3/065De9HfO065CGdJJZ5ai2snfBLhebq3f930RQB2
 9jkU8oIT6hwGAxkYzA6bXJl4RIwUvslTTg3kP6luoQBLQXqjAVHFeQxwAMforAJJ9Z5d
 BA7A==
X-Gm-Message-State: APuU4Z8XdhkTaeWEYSvs69VumjyGjQuc4YBg+nkrFpHzNkyWvZwbuyiy
 VBMuSh51bxkwkawmuuSq7ew4r/AF40dTPmSOl+Zutse4704BcEMVs2cYu+2e1ueSsdqbZ3Jx9Ty
 c7VzFOJoXEFkC5rJ/PBZKFd8Z5QitmWxzeJjTvIQ9/yBxkAZrBERIMRxpGfhouoq4DZJUhj2Rlq
 PWALn2q64U0kLCA3TlWv0dgYnRwovkMwRyvw==
X-Gm-Gg: AYBFou2lJliyHeoFe1MEkEPeF0vmLCt+pxKvpxZT7zVt463Bj7pTaY2nnktI4FwRBO2
 Ou0OMSNLP8GObhdHDys1Dbz9MxjG3MTdSMWPTWaLsGwBvgv1+akEpMeVSIs5yNHDrYxLunQBphH
 Gmhsqwrgkdn7eGHniSLlenOXDXrqpmue6eWUXuR0yiJDR0xMdCme3DR3RwTbuTW4n/lGgnFlG9H
 ywbyJ3ee84ifOgOxMxdcAIm0OXiz2GI+NpTx7j0IlPvV30McBqZo/fFcBRb2h1c+p/0jnjAV/di
 OrMQJf6MsAycU2FrXIqnA5R7JKalRt6CoNWRxMYcb006u1yMOq4aHl/so8xfcgp8Ii8mhUXIA5L
 l5zW3G/YNtWYSV2Jp9BLR06j3Ps8nHiDMyN0hG3zZJg==
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4ac17d19777mr285784415e9.28.1793706641628; 
 Tue, 03 Nov 2026 03:50:41 -0800 (PST)
X-Received: by 2002:a05:600c:4454:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4ac17d19777mr285783805e9.28.1793706641020; 
 Tue, 03 Nov 2026 03:50:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm24811724f8f.42.2026.11.03.03.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:50:40 -0800 (PST)
Date: Tue, 3 Nov 2026 06:50:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org
Subject: [PULL 07/17] pcie_sriov: fix null pointer dereference when
 initializing PFs in a system with user and device created VFs
Message-ID: <e1b6779cd4c29e9cc24f88a45552a93219c68241.1793706601.git.mst@redhat.com>
References: <cover.1793706601.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793706601.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Paziyski <danielpaziyski@gmail.com>

pcie_sriov_pf_init is only used to initialize PFs for device created VFs, and
as such, it is checked that the PF has not been referenced by a user created VF
by means of the sriov-pf parameter.

This check crashes if it is performed for a PF that does not have an ID, and
there are already user created VFs in the system.

Example:

    qemu-system-x86_64 -M q35                                   \
        -device pcie-root-port,id=rp1,chassis=1,slot=1          \
        -device virtio-net-pci,sriov-pf=f,addr=0.1,bus=rp1      \
        -device virtio-net-pci,id=f,addr=0.0,bus=rp1            \
        -device pcie-root-port,id=rp2,chassis=1,slot=2          \
        -device nvme-subsys,id=subsys0                          \
        -device nvme,sriov_max_vfs=1,serial=s,sriov_vq_flexible=2,sriov_vi_flexible=1,bus=rp2,subsys=subsys0

ASAN message:

The signal is caused by a READ memory access.
Hint: address points to the zero page.
    #0 in g_str_hash (/usr/lib/libglib-2.0.so.0+0x49954)
    #1 in g_hash_table_contains (/usr/lib/libglib-2.0.so.0+0x4ad3b)
    #2 in pcie_sriov_pf_init ../hw/pci/pcie_sriov.c:161
    #3 in nvme_init_sriov ../hw/nvme/ctrl.c:9088
    #4 in nvme_init_pci ../hw/nvme/ctrl.c:9218
    #5 in nvme_realize ../hw/nvme/ctrl.c:9696

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261101162132.147838-4-danielpaziyski@gmail.com>
---
 hw/pci/pcie_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 63d19ea488..9ba14d46c4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -158,7 +158,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     BusState *bus = qdev_get_parent_bus(&dev->qdev);
     int32_t devfn = dev->devfn + vf_offset;
 
-    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+    if (pfs && dev->qdev.id && g_hash_table_contains(pfs, dev->qdev.id)) {
         error_setg(errp, "attaching user-created SR-IOV VF unsupported");
         return false;
     }
-- 
MST


