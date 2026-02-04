Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB02E95392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnc0T-0006sk-3r; Wed, 04 Feb 2026 07:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnc0S-0006sc-15
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:29:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnc0Q-0003Yj-Co
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770208152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ts9b+/VIdyZMaegYoHYgDLwl+dwNKgWbyuwW4Ye5JA4=;
 b=VG6O8YEh6ISMvs4POdeZW2TJrPHUexofhsW5ZL7Hpt8BvU5uw+bmdPjWASIknrYrW0h84p
 sajc7fZHC0u9gxtNlgJTjGGi4I/GX1jiM2W22heb/FTVaUEsRryLyrMYJNSgI+VgVPYzBJ
 7DXXbOTzyp7lIAX09/+WExSrt0aXPyA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-V_riiPxrPeWBb8F-xszy3g-1; Wed, 04 Feb 2026 07:29:11 -0500
X-MC-Unique: V_riiPxrPeWBb8F-xszy3g-1
X-Mimecast-MFC-AGG-ID: V_riiPxrPeWBb8F-xszy3g_1770208150
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-435af2d3144so4520407f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 04:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770208150; x=1770812950; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ts9b+/VIdyZMaegYoHYgDLwl+dwNKgWbyuwW4Ye5JA4=;
 b=hUmu2QmAXbzXzThsn8YW2kU6soR1tzwg/oonuIOSDE7JGbnM9p6nxTRSI7/EEJ3L7P
 ccEe4/S8lDfha1cfKYN7bpYen1BCp3T7XEGwtEGNVh9Z6kRTneonbXTNw49Ci1+gUnUb
 f919rvNpYvWhk0XMweL5Jmi/iXCXewBEmSn69iiA/UTJshujlHHS27+4gQY7kzIsUBvZ
 r5KiV8xCILcfiIo6im7fTiB6YvgZ/W7EC2NGhYodFZ3cKXjYme3zhq7xn/mhrjmchr0m
 L85CnfhCMWAAYmF2tMl/IeacRvjIezCFzvwhmuFtKXez1+REZ/OrVgzaIWjqZhxXuamY
 4tTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770208150; x=1770812950;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ts9b+/VIdyZMaegYoHYgDLwl+dwNKgWbyuwW4Ye5JA4=;
 b=vhMi8ffoK+8Lkg8NeMZkPvjB48YIj9uqAYhBCwttaX7FhQXeH2r/azPhsj8Z3pYfEU
 +mPFgITH7a1RdDaqsb/jfOBXQqSx79Y9Iky6+QCmvNed4LSK/Hap+jV5y79IiybVxrfT
 x5y8ABGn3wn/S2hZQlFY+JEp12O/Vb6c1yLtXbwTmCVZHuEoBZmu9Ec1yMmT/uo6YRCz
 0xN904NWZb6s4NGc6oXyunsPkZON7idSKxVxSGw9+vDZqtLpHlhEuSP+5Hbi+T/Kzn9Q
 tHi2SF/WGcrB/FLSAcHlJjBXOpccGdRAJym5DMeAWtPdq6OxVkSsj+IA50pfCSvPYWlj
 ikAw==
X-Gm-Message-State: AOJu0YzNKwXaecotS/6fMaJO5cKMj/NNW/6uuwsyfexSA8ZXcQIlmPPB
 M3Jze1p2d/JXsfuRFZXgi9tl5OYJoz7Hg5KER6tfhPPH4AsefCFpdQylv2z4c5x/KQqD/Ffxg2o
 sqhQ4hJCzJb68c4aE+SwY5YO01pneDZr9APFdticxteXj83pHTJ48OI88
X-Gm-Gg: AZuq6aLABcQfWlnAUZPiicw8k8rnF/aDcUjvhdqZqbYR3jITCJxtlqZFtbdoJkhxzbE
 IRzkmCuJaBSspC3ehF01+RrzFpPvpUuCE9xk+UBN86r5/ZLCkm1TG1uo6596ppmiHPVJ+uho4IB
 2hDNVQBSagLmq1lExSsKQZle70aELPmMxyT9OqOjGWKRTywr10ta0iYm851fsNbYJkraFHBPq06
 Vh7Z8jJtURSzToMA4OvOGIhXGBT46I9ZLXW2Musd4lxmj+jrdTSHmsUz1ixHha4Ou94vwuvyjU9
 Qe9Ik4/K8NY6Im00ciT6JiNYVQ1F51dNgTVuWDhSEsaiSFkbYYBfantZeSxdzlQmzPB1lGXi6uJ
 29Ve/3COVfItfVMypqeMtG145kaWW9M0MEw==
X-Received: by 2002:a05:6000:1888:b0:435:a9ad:d21a with SMTP id
 ffacd0b85a97d-43618053a21mr3819004f8f.40.1770208149821; 
 Wed, 04 Feb 2026 04:29:09 -0800 (PST)
X-Received: by 2002:a05:6000:1888:b0:435:a9ad:d21a with SMTP id
 ffacd0b85a97d-43618053a21mr3818993f8f.40.1770208149161; 
 Wed, 04 Feb 2026 04:29:09 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f93sm5990903f8f.24.2026.02.04.04.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 04:29:08 -0800 (PST)
Date: Wed, 4 Feb 2026 07:29:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/pci: Use correct bus aperture for device container size
Message-ID: <20260204071045-mutt-send-email-mst@kernel.org>
References: <20251124114754.79831-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124114754.79831-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 24, 2025 at 12:47:54PM +0100, Philippe Mathieu-Daudé wrote:
> Before commit 3716d5902d7 ("pci: introduce a bus master container")
> device view of the bus address space was correctly sized to the
> bus aperture, but then it always used a 64-bit aperture. Restore
> the previous behavior, so devices on 32-bit PCI only see 32-bit
> address space.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Wait I am confused. Is there a problem this is trying to fix?


> ---
>  hw/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b1eba348e06..64f33b9de04 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1375,7 +1375,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
>  
>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
> -                       "bus master container", UINT64_MAX);
> +                       "bus master container",
> +                       memory_region_size(bus->address_space_mem));

as far as I can tell this does more than it says it does.


Look at raven.c:
                                                                                                                                         
  h->bus = pci_register_root_bus(d, NULL, raven_set_irq, raven_map_irq,                                                                  
                                 s, &s->pci_memory, &s->pci_io, 0, 4,                                                                    
                                 TYPE_PCI_BUS);                                                                                          
                                                                                                                                         
  The bus is created with &s->pci_memory (1G) as the address space.                                                  
                                                                                                                                         
  But the actual bus master space (&s->bm at line 285) is 4 G.                                                                         
                                                                                                                                         
  Your patch limits DMA to 1G. No?

failures here (definitely the ppc one)

https://gitlab.com/mstredhat/qemu/-/jobs/12984084992

reverting fixed it:

https://gitlab.com/mstredhat/qemu/-/jobs/12984187692



                                                                                                                                         
>      address_space_init(&pci_dev->bus_master_as,
>                         &pci_dev->bus_master_container_region, pci_dev->name);
>      pci_dev->bus_master_as.max_bounce_buffer_size =
> -- 
> 2.51.0


