Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC4C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmesD-0000Ts-V2; Mon, 24 Feb 2025 15:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmesA-0000Re-Ph
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tmes8-0005EJ-Bq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740428169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5N8n+tR3ig3k6Dc8iNPIFi0w/z+a9OxLNbCtrJHwDOo=;
 b=bNO3CZXOvp8A5zU1niDqGsDraDjOMcSsSG4IjsX++ShEoidEEsmDJaV6BgMnNDGD189iiA
 ko2yhUclBekqsIe+DOIiny4/biOGYS3+mhHyMneq40vcjNr+8AnXrLaHWgk6xX+NS/gL5d
 4ikj5pKQBH2mm9GbIMkj5sCClXsdPMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396--HW1GX9dMA2wL4XvPb_fVw-1; Mon, 24 Feb 2025 15:16:08 -0500
X-MC-Unique: -HW1GX9dMA2wL4XvPb_fVw-1
X-Mimecast-MFC-AGG-ID: -HW1GX9dMA2wL4XvPb_fVw_1740428167
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f27acb979so4713446f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740428167; x=1741032967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5N8n+tR3ig3k6Dc8iNPIFi0w/z+a9OxLNbCtrJHwDOo=;
 b=cN5SW2nHwD0Zb2p8TdDxQnNjuxM1dmEiHDGD2oLz51nxtQIHf423thPkznZxdLoUox
 5Ze17JzpfGK2+zd/hHsTCign4n55idbjDC1QmrBpM3AYJdwMpxUTspjmpRiKEvcccxYH
 Z891omB9808CEI0J2/7p8Nh8biB4ODuFsPUSfehrmjU2ItArXCPkf+3BSuyq6HZzGtIu
 TIlRkxnQpPNJa7AXsKjEhKH9Xn/rDtj3vnsKJBzENghqZ2pG0G0LGo/UmVbqt40i1AAT
 +a/wNC+BHu7MvVUjrbwrSCj2ptppaBdxZU3BSnszwVAPv+ZzkLxGQF+7UfPI31Twxd62
 39KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsW5bzev1pSB3MUs1R2FmJ6Z8Q4b+WirVP/CvXFM4aga0Qz9zimyMRIB2RCov1AQ4BENtz2F3MtBm1@nongnu.org
X-Gm-Message-State: AOJu0YxgQStb0p8RwtjaGT4GNxA13aaQlJcVLzPAS0/E3J62ZPylmIag
 m0H4mkKjAgVFCs1cm1JsQOi8pMRYh73yXCk8Y48RuW0wiNQDfX2MO1JTnP84x7VTjfQXhBzi5nU
 37/NAnUQ9wdpdLlxNVoqMtYUk3bsRlq85OD0ZW5f+Z0UirkOw4mi9
X-Gm-Gg: ASbGncsdNUnDVzb+KW6z/ewLg+Q4CtfXTKhIjG4eO0FMWNaQj88H/F2ss+jjGBtJ/S1
 35jUNjFCG49IgTvz/WOPXZhk6bLccdfc67VP+1uOt/awb/1wxOWBVknOSVH8n9eAavo6UKpqsmV
 Snh9dTVZ2TLXeAHVJV0v/lbKKYH0yW6fcOUgwoBfLMaJ7CyZzb56/KRU3f3KndH/gnemheIh66X
 BNtQclq0HIDOmRLaqSg1WfRxsLt/nQax3BaDMx2g/JODRBstVnE4gwZpUjIAcnwP4VG4zQeH9F0
 kfJ8N7BTrhVWDZfK2uPvcwHw5ZyrgbYIq7FQedgwFkDJ2/s3e3L8jSo2RZXeJzc=
X-Received: by 2002:a5d:6d8f:0:b0:38f:2111:f5ac with SMTP id
 ffacd0b85a97d-38f707b0941mr12293116f8f.31.1740428166940; 
 Mon, 24 Feb 2025 12:16:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl5qf7BSQlp8a6EytNWok0mb1I61LO2+JPG4Qa79ml9b/VNgLlL9fuIDiayzcNb/UHxiFajQ==
X-Received: by 2002:a5d:6d8f:0:b0:38f:2111:f5ac with SMTP id
 ffacd0b85a97d-38f707b0941mr12293098f8f.31.1740428166584; 
 Mon, 24 Feb 2025 12:16:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86cc6asm27396f8f.35.2025.02.24.12.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 12:16:04 -0800 (PST)
Message-ID: <241a5dbe-1c22-4369-84af-8127a9ed9328@redhat.com>
Date: Mon, 24 Feb 2025 21:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/vfio/pci: Re-order pre-reset
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: eric.auger.pro@gmail.com, clg@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-6-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250220224918.2520417-6-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 2/20/25 11:48 PM, Alex Williamson wrote:
> We want the device in the D0 power state going into reset, but the
> config write can enable the BARs in the address space, which are
> then removed from the address space once we clear the memory enable
> bit in the command register.  Re-order to clear the command bit
> first, so the power state change doesn't enable the BARs.
>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/pci.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ba4ef65b16fa..fcc5f118bf90 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2405,6 +2405,15 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>  
>      vfio_disable_interrupts(vdev);
>  
> +    /*
> +     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
> +     * Also put INTx Disable in known state.
> +     */
> +    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
> +    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> +             PCI_COMMAND_INTX_DISABLE);
> +    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
> +
>      /* Make sure the device is in D0 */
>      if (pdev->pm_cap) {
>          uint16_t pmcsr;
> @@ -2424,15 +2433,6 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>              }
>          }
>      }
> -
> -    /*
> -     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
> -     * Also put INTx Disable in known state.
> -     */
> -    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
> -    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> -             PCI_COMMAND_INTX_DISABLE);
> -    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
>  }
>  
>  void vfio_pci_post_reset(VFIOPCIDevice *vdev)


