Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA048606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cmnEkr+K;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=J8m2SiOF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7HJ-0002cG-44; Wed, 28 Oct 2026 13:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ge-0001Ii-Bl
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Gc-0003xY-TE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7IzpZNCvE05gBxwtsLM4vYyfEwFTReI2p7R3GhhlDNE=;
 b=cmnEkr+K93cJPOmzTM+8B2vz+QXeAGxAf9Z60ntxjoMInal/m/FWjHy97SrHnxJ9KRq8jj
 PK39me29lsoi+Z6R/HEchV1Po8NsRnjDgNsqVtXYPzgVqNqGW7b+sKzPsGKLiLmDQOS87v
 00CQUkoDDivEtppzrtRtRXlEbPKviDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-V57zDU62Ohyndgg3wDIIQQ-1; Wed, 28 Oct 2026 13:16:48 -0400
X-MC-Unique: V57zDU62Ohyndgg3wDIIQQ-1
X-Mimecast-MFC-AGG-ID: V57zDU62Ohyndgg3wDIIQQ_1793207808
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48c7fe9736eso1034325f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207807; x=1793812607; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7IzpZNCvE05gBxwtsLM4vYyfEwFTReI2p7R3GhhlDNE=;
 b=J8m2SiOFRKkosN53OB6pNBfLHoKL2/elVsIfvYnFNTJowS27VMlIRWvWB2Rob0cZeG
 fhW/pLCgnw+KbLI+SflIl0USYXHYlFZZ+I8FAJ4yZs51jHg9ilGObskdEFpl9KaIi6Mb
 U5pTSFdX/J+4jrxUTd6o4sMl0NaZMCT/aZJucgNHgJ1sqJFOZFmFqCyFLPYQZe/v67Zc
 5aOQJvyA+OpIOFXqVCk2/kHbb5JTHIt7wEh0WgI4valB45HlivTG7ktc3kBWOBcTZvMr
 KOKko6+ZXqCZ1nmgtFUWT+7/baHOgRj1igdM9mOr3BNujmw5ZYZ1lWB3tp0xRCSH8Pmv
 8Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207807; x=1793812607;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7IzpZNCvE05gBxwtsLM4vYyfEwFTReI2p7R3GhhlDNE=;
 b=Yc+T7THJxBoVwgCC1mUq+YSBxRRG3XIVq0RZbtXE52E1cFKFbBhPLKP0ObN+UBC5om
 xH6hBPZj6xBvxiGfRF9NmDylcHYPe2YwF+5oz78n87kgaqy8MhTvXRiuWsODjg71JJW5
 LMrEQibYPD02YXkZPbie3coXsqLgW4ojRPE6naavCLMGIke6NpL+Zimzbwoupybms6JM
 De7de0D7temK32npXxqypLRknVzPhtGvejVxYw7OWSSc14B+biMNzZ6urSqZ8aC7LayL
 nSUKUNgoK3FKtVQrkLVZeORbbs4XUgv4Sj3/TXVJHn7+dOfcNOcCceD84NCxtzVmf1+q
 6exQ==
X-Gm-Message-State: AFq9FYK3AjfnktN6ZlvY5L//EX5pC3kMUX2zJytmxPbcQDQ0haBpCpI9
 f2oGe7I6cqmdf9YF/vZT1dvUQX7oHY1rdOwUEntAbNdcafAWHttZ7SeuxYHGhbr+7hb8YI9F4Yn
 q/cQhxo+3waVgADg9r70j5lZARAC95BsatTfC5J5op6FzphpveYx+Z8PgKFC63nAg/jj+cJjNUZ
 J1+dXaen+ekXoIsdnS+pKhGc9eFRqLXP8kmw==
X-Gm-Gg: AYBFou10Wm8XJgLLDtmp6nwvp+KIZr1hgddBpcPhG9zVsmmFT5Y+qiT/bWpWnumm9D/
 6rHuXrzXBzfuU1t7J+csr9ETfoD6y1kj9FskJdj53XQ88x3WpoUeglTmUa8JSUXnpZO1Y/SB96o
 i9Xb7RUM2H63YQRIt9j398X5gkCh6nViIhghZ6+/LaH5MMXyJOwXY5s/3Kt4drMAWTB9eQXNf7i
 PmON4UZ+0MlZd9fjAioLy6y4yiOtgrLenfeQ4RTO8VkLEeDbN0V+Y1Ef1qarkQE5FNwUyWZ/fR1
 4XVF2vQ+pcmSWHy5ARSnIOXa5l30QxPWKiN+PN/2H84jGELIp15v5BUzoNaMoMblQ8oxTyE75JJ
 SSKb8+PdzCiYYxobJRoBvG09UWVNMZCzjrPOI3PPY
X-Received: by 2002:a05:6000:46d3:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-48e5d3184a7mr5470252f8f.57.1793207807426; 
 Wed, 28 Oct 2026 10:16:47 -0700 (PDT)
X-Received: by 2002:a05:6000:46d3:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-48e5d3184a7mr5470194f8f.57.1793207806867; 
 Wed, 28 Oct 2026 10:16:46 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd47basm32221498f8f.32.2026.10.28.10.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:16:46 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:16:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 63/78] amd_iommu: Add support for get_x86_iommu callback
Message-ID: <a854025985c5ba82e61104904cb4efefd23efb0c.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Return X86IOMMUState during get_x86_iommu callback.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261014053433.24564-4-sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 817320c51c..b2df0e9533 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2472,8 +2472,16 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &amdvi_dev_as->as;
 }
 
+static int amdvi_get_x86_iommu(void *opaque, void **x86_iommu)
+{
+    AMDVIState *s = opaque;
+    *x86_iommu = X86_IOMMU_DEVICE(s);
+    return 0;
+}
+
 static const PCIIOMMUOps amdvi_iommu_ops = {
     .get_address_space = amdvi_host_dma_iommu,
+    .get_x86_iommu = amdvi_get_x86_iommu,
 };
 
 static const MemoryRegionOps mmio_mem_ops = {
-- 
MST


