Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A229606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QzJt/e6v;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OBY9qz6Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3UR-0007O7-P5; Wed, 28 Oct 2026 09:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM3UI-0007NJ-4w
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM3UG-0005QB-6c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793193278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fV9YsuoeSGzf09ye668Bpjy8q30f4GXYr6Pn2bVKFGg=;
 b=QzJt/e6vaLUDtNsIxpE+dyoyrb00abM9i2fCYlw0xjqj8a52/7NhMHbZ/XIcS7Kbqki+LQ
 aV6/U5+b3ip266/zDpsTGZS9M4Jd4QHeq1t28J/3kfh2WcfPURirRDPQUyz6neXfTObCPt
 nBoR2wMhZ3xQskBqLBbejMuqCGdzv4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-EVoQsjmqP2-pX2_XYdB1lg-1; Wed, 28 Oct 2026 09:14:31 -0400
X-MC-Unique: EVoQsjmqP2-pX2_XYdB1lg-1
X-Mimecast-MFC-AGG-ID: EVoQsjmqP2-pX2_XYdB1lg_1793193270
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so13750455e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793193270; x=1793798070; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fV9YsuoeSGzf09ye668Bpjy8q30f4GXYr6Pn2bVKFGg=;
 b=OBY9qz6Yfreq54OQ3zu/bPC4HspNsj2LWnNedCVAga6BJAypZgxsbZDqzXmZxCwVEG
 dzwSG/CyQ4pzzIzr8rV6LUVNZxxFQzjHZrmodORzmY99aGQWDDYir41WH9wLiFXFJpFE
 XJsKqsSuTIpkE2cVDbWQ+tqZq9LKex9K0sSAufCjdo4CTTThIZxmFra7CFo3zXb4cASK
 R44tEX0RwpBDBOocvCsXVODT268cLDImnYm+8Roi+9v2ijgodQyf1p4PN8PCl1O/LIJs
 U2ogU0TM/D6U5BMC+TPMHPGsShUKoVBsOqGGq9PcrznbzKpcDOjn2JTTBwioJ6KUWnMH
 mvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193270; x=1793798070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fV9YsuoeSGzf09ye668Bpjy8q30f4GXYr6Pn2bVKFGg=;
 b=Y+dmmPM9MFhz6giX7wL1MKan+0/Np+8zClUS082tF3Pu8630kOotV7q6qorkbZiV33
 1Ct9dXQ2M2ZS2wir8h668VyNSFZLf0rwUwEgsE+b2tZIN9W/NOFKxaVhzJPK+Cj+fYIY
 977+j1WXMVf9tDsErzQe7oK3A1dbzAuQAe9fl/4VJfKdBD5KyzLTtuCrq4ePaoR7nZ38
 CWnk+GYjadHIhBeHW9o00BlcKCP93EbxPGgaQyG7umtZY/TNBjd9LNnUvijAGvMBNzo/
 er0VcRceV7XJqxkrJva/UBrXFEqvL0eQ3mLggbGF9YU2SzkWAQoTtgOpvBmXC5JBlHe4
 oeSw==
X-Gm-Message-State: AFq9FYKY8/BksJ6b6/GsiEKVnQcNWEDzkxKutocBTC192rBEpuxgyOhU
 HWXADHQxRi1sQ07IUaySAal3jTO2VSx5m8zyzIPWhQm9W03RQMPLXO5KaQ6qdDFYYHgSzGRdOcp
 FwamF/nE2DQQnnrUaI35g6tlVInOt1LEJqEeXVojNfTpyXMJC+mfN79powZx4sdiU
X-Gm-Gg: AYBFou3xPX1zN7XvVfZoq0cr32/1/BihDkTsiRNjoFvfaPrlJRpv/Sc0MPQrNaOZAAd
 2MB34eg3HV8LTmco7JtP0plhsrIz7ApCSdcm2PYZH/zPUfmlsvOgLXynLpzgZI/ey4eUNvvAOVI
 hd4HVX8sqrbn4iTphUqRbYauEwUbn9cHrDvJC/AzWnwh/qw8mdAlnc9VlaMuNvDtbiz8baIXE3W
 Mk/yxNHif7+UW0dLHF6x19Z4ps9MONqDfXns9YSDiqO0e477kwgJJCBnHY6yYo76d83iQyjlGfH
 7moGsQURfsRWXrsDfJqUH9U56Jih9vziRio9yyLsuAK/KuuAEIFQJBZQEOpjqsfuEIpk5IJQmt3
 bQYl+gJvy+8nCGeGLxlFnSpg0t1+fCRp60CbQXeC7
X-Received: by 2002:a05:600c:8114:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a997cf5091mr42972485e9.17.1793193269917; 
 Wed, 28 Oct 2026 06:14:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8114:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a997cf5091mr42971765e9.17.1793193269323; 
 Wed, 28 Oct 2026 06:14:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92de010bcsm44198845e9.0.2026.10.28.06.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:14:28 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:14:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Cl=E9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] pcie_sriov: Avoid capability structure overflow in PF
 reset
Message-ID: <20261028091349-mutt-send-email-mst@kernel.org>
References: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921055917.715685-1-clement.mathieu--drif@bull.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Sep 21, 2026 at 05:59:23AM +0000, Clément MATHIEU--DRIF wrote:
> The SR-IOV PCIe capability exposes 6 regions (no ROM), each with a
> dedicated 32-bit configuration field. Fix the reset loop to write
> 32 bits instead of 64 bits and stop after PCI_SRIOV_NUM_BARS iterations.
> 
> As a side effect of this change, update PCIESriovPF::vf_bar_type
> to match the number of regions exposed by SR-IOV and rework the
> associated assert statements.
> 
> Fixes: c8bc4db403e1 ("pcie_sriov: Reset SR-IOV extended capability")
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

I queued another patch fixing this, yours will become a cleanup.
Once my pull is merged, pls rebase and report.

Thanks!

> ---
>  hw/pci/pcie_sriov.c         | 9 +++++----
>  include/hw/pci/pcie_sriov.h | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index c41ac95bee..df61f281ea 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -229,8 +229,7 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
>  
>      assert(sriov_cap > 0);
>      assert(region_num >= 0);
> -    assert(region_num < PCI_NUM_REGIONS);
> -    assert(region_num != PCI_ROM_SLOT);
> +    assert(region_num < PCI_SRIOV_NUM_BARS);
>  
>      wmask = ~(size - 1);
>      addr = sriov_cap + PCI_SRIOV_BAR + region_num * 4;
> @@ -344,6 +343,8 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
>      dev->exp.sriov_pf.vf = vfs;
>      dev->exp.sriov_pf.vf_user_created = true;
>  
> +    assert(vfs[0]->io_regions[PCI_ROM_SLOT].size == 0);
> +
>      for (i = 0; i < PCI_NUM_REGIONS; i++) {
>          PCIIORegion *region = &vfs[0]->io_regions[i];
>  
> @@ -463,8 +464,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
>       */
>      pci_set_word(dev->config + sriov_cap + PCI_SRIOV_SYS_PGSIZE, 0x1);
>  
> -    for (uint16_t i = 0; i < PCI_NUM_REGIONS; i++) {
> -        pci_set_quad(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
> +    for (uint16_t i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> +        pci_set_long(dev->config + sriov_cap + PCI_SRIOV_BAR + i * 4,
>                       dev->exp.sriov_pf.vf_bar_type[i]);
>      }
>  }
> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
> index b0ea6a62c7..5f81e3b1bb 100644
> --- a/include/hw/pci/pcie_sriov.h
> +++ b/include/hw/pci/pcie_sriov.h
> @@ -16,7 +16,7 @@
>  #include "hw/pci/pci.h"
>  
>  typedef struct PCIESriovPF {
> -    uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
> +    uint8_t vf_bar_type[PCI_SRIOV_NUM_BARS];   /* Store type for each VF bar */
>      PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>      bool vf_user_created; /* If VFs are created by user */
>  } PCIESriovPF;
> -- 
> 2.55.0


