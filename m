Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D982C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9iHU-0003Ee-5M; Wed, 22 May 2024 05:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s9iHO-0003Ds-Ct
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s9iHM-0005YE-FP
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716370138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/yM0AlrgHh+pcaN0joELPRZkqoJy/3OgwmjjgTVkDg=;
 b=EOIOijjMopPtZWAinCfaLvcnGTh19u0EEQbAMZ+GJUtWXHW4pwx4j1pwbnV0S+TkkGXA9P
 FTItNe08Jpn0HYzFyLSFIkk1MIfJ/bOw57/MI8cnk/rmwHGqplN8LT5FXIYlNcvmKNcv7F
 NtSLhSc/Iub+hBMvSWriMDVSJoDXw5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-zMnyzzkVOXWCMaDTlLYxQQ-1; Wed, 22 May 2024 05:28:56 -0400
X-MC-Unique: zMnyzzkVOXWCMaDTlLYxQQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4206b3500f5so37522595e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 02:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716370135; x=1716974935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/yM0AlrgHh+pcaN0joELPRZkqoJy/3OgwmjjgTVkDg=;
 b=jQbe4oiCT83R4l7qxlD4puW1iNiWhcZ9mc6exiw0X/QbZBRBq4nxnOSbbX3D7S1OHJ
 4pXiwiwXt0PBbNzwsv3JwWayDhs0bUz3zvwS0tzdIsHo6gdvz7BZ+MCgYx+ZM05YJJaT
 wPIs82ixC8Uqt6uhZtc9+CNU5r3obFc8nSRYQW7pbdliA+lT27KTujkrMQOBtW1Q7dlG
 TFrg/nNP765GXbf2Eidy7SnGu47vrjNP+QivhuLtfb6TVSJvNt6ieoTZ3IsFlrAw62IK
 JzV9x4+iIFCrVdndC+AwPP20eZiLf037iuyLCPhLjYkSNwSW8RdEYGWqnpazQSkodbR9
 1ZOA==
X-Gm-Message-State: AOJu0YySTG7Auk5rXYZkuoUdqr9/LWwX18PJpL52G5ODN1mNkbhd5iHK
 +WKL136s+fX3YsK74rkMhmkCffbGJ5mbJCdwHLs1TsMF0YVdXAOPB9m/tsRurWQrZYJwe6AEB11
 wiBi9cVMpRNFGSu6z6fL+e+NFmr1oD+Ad2ycmZt0Q/cIEGww2fPe1
X-Received: by 2002:a05:600c:1c9d:b0:41c:23f3:65fa with SMTP id
 5b1f17b1804b1-420fd35a89cmr13129115e9.28.1716370135400; 
 Wed, 22 May 2024 02:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOWhY/QSppIKGCO0NOdHa3KLNNAWSIquAHNbOIivtg4ExN8tKbc0l2hXi/rWGZNSI0LvG6Ig==
X-Received: by 2002:a05:600c:1c9d:b0:41c:23f3:65fa with SMTP id
 5b1f17b1804b1-420fd35a89cmr13128945e9.28.1716370134773; 
 Wed, 22 May 2024 02:28:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8e3csm494653205e9.1.2024.05.22.02.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 02:28:54 -0700 (PDT)
Date: Wed, 22 May 2024 05:28:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aaron Lu <aaron.lu@intel.com>
Cc: qemu-devel@nongnu.org, Juro Bystricky <juro.bystricky@intel.com>
Subject: Re: [RFC PATCH] docs: Enhance documentation for iommu bypass
Message-ID: <20240522051403-mutt-send-email-mst@kernel.org>
References: <20240522074008.GA171222@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522074008.GA171222@ziqianlu-desk2>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 22, 2024 at 03:40:08PM +0800, Aaron Lu wrote:
> When Intel vIOMMU is used and irq remapping is enabled, using
> bypass_iommu will cause following two callstacks dumped during kernel
> boot and all PCI devices attached to root bridge lose their MSI
> capabilities and fall back to using IOAPIC:
> 
> [    0.960262] ------------[ cut here ]------------
> [    0.961245] WARNING: CPU: 3 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x27/0x40
> [    0.963070] Modules linked in:
> [    0.963695] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc7-00056-g45db3ab70092 #1
> [    0.965225] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    0.967382] RIP: 0010:pci_msi_setup_msi_irqs+0x27/0x40
> [    0.968378] Code: 90 90 90 0f 1f 44 00 00 48 8b 87 30 03 00 00 89 f2 48 85 c0 74 14 f6 40 28 01 74 0e 48 81 c7 c0 00 00 00 31 f6 e9 29 42 9e ff <0f> 0b b8 ed ff ff ff c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
> [    0.971756] RSP: 0000:ffffc90000017988 EFLAGS: 00010246
> [    0.972669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [    0.973901] RDX: 0000000000000005 RSI: 0000000000000005 RDI: ffff888100ee1000
> [    0.975391] RBP: 0000000000000005 R08: ffff888101f44d90 R09: 0000000000000228
> [    0.976629] R10: 0000000000000001 R11: 0000000000008d3f R12: ffffc90000017b80
> [    0.977864] R13: ffff888102312000 R14: ffff888100ee1000 R15: 0000000000000005
> [    0.979092] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
> [    0.980473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.981464] CR2: 0000000000000000 CR3: 000000000302e001 CR4: 0000000000770ef0
> [    0.982687] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    0.983919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    0.985143] PKRU: 55555554
> [    0.985625] Call Trace:
> [    0.986056]  <TASK>
> [    0.986440]  ? __warn+0x80/0x130
> [    0.987014]  ? pci_msi_setup_msi_irqs+0x27/0x40
> [    0.987810]  ? report_bug+0x18d/0x1c0
> [    0.988443]  ? handle_bug+0x3a/0x70
> [    0.989026]  ? exc_invalid_op+0x13/0x60
> [    0.989672]  ? asm_exc_invalid_op+0x16/0x20
> [    0.990374]  ? pci_msi_setup_msi_irqs+0x27/0x40
> [    0.991118]  __pci_enable_msix_range+0x325/0x5b0
> [    0.991883]  pci_alloc_irq_vectors_affinity+0xa9/0x110
> [    0.992698]  vp_find_vqs_msix+0x1a8/0x4c0
> [    0.993332]  vp_find_vqs+0x3a/0x1a0
> [    0.993893]  vp_modern_find_vqs+0x17/0x70
> [    0.994531]  init_vq+0x3ad/0x410
> [    0.995051]  ? __pfx_default_calc_sets+0x10/0x10
> [    0.995789]  virtblk_probe+0xeb/0xbc0
> [    0.996362]  ? up_write+0x74/0x160
> [    0.996900]  ? down_write+0x4d/0x80
> [    0.997450]  virtio_dev_probe+0x1bc/0x270
> [    0.998059]  really_probe+0xc1/0x390
> [    0.998626]  ? __pfx___driver_attach+0x10/0x10
> [    0.999288]  __driver_probe_device+0x78/0x150
> [    0.999924]  driver_probe_device+0x1f/0x90
> [    1.000506]  __driver_attach+0xce/0x1c0
> [    1.001073]  bus_for_each_dev+0x70/0xc0
> [    1.001638]  bus_add_driver+0x112/0x210
> [    1.002191]  driver_register+0x55/0x100
> [    1.002760]  virtio_blk_init+0x4c/0x90
> [    1.003332]  ? __pfx_virtio_blk_init+0x10/0x10
> [    1.003974]  do_one_initcall+0x41/0x240
> [    1.004510]  ? kernel_init_freeable+0x240/0x4a0
> [    1.005142]  kernel_init_freeable+0x321/0x4a0
> [    1.005749]  ? __pfx_kernel_init+0x10/0x10
> [    1.006311]  kernel_init+0x16/0x1c0
> [    1.006798]  ret_from_fork+0x2d/0x50
> [    1.007303]  ? __pfx_kernel_init+0x10/0x10
> [    1.007883]  ret_from_fork_asm+0x1a/0x30
> [    1.008431]  </TASK>
> [    1.008748] ---[ end trace 0000000000000000 ]---
> 
> Another callstack happens at pci_msi_teardown_msi_irqs().
> 
> Actually every PCI device will trigger these two paths. There are only
> two callstack dumps because the two places use WARN_ON_ONCE().
> 
> What happened is: when irq remapping is enabled, kernel expects all PCI
> device(or its parent bridges) appear in some DMA Remapping Hardware unit
> Definition(DRHD)'s device scope list and if not, this device's irq domain
> will become NULL and that would make this device's MSI functionality
> enabling fail.
> 
> Per my understanding, only virtualized system can have such a setup: irq
> remapping enabled while not all PCI/PCIe devices appear in a DRHD's
> device scope.
> 
> Enhance the document by mentioning what could happen when bypass_iommu
> is used.
> 
> For detailed qemu cmdline and guest kernel dmesg, please see:
> https://lore.kernel.org/qemu-devel/20240510072519.GA39314@ziqianlu-desk2/
> 
> Reported-by: Juro Bystricky <juro.bystricky@intel.com>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Is this issue specific to Linux?

> ---
>  docs/bypass-iommu.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
> index e6677bddd3..8226f79104 100644
> --- a/docs/bypass-iommu.txt
> +++ b/docs/bypass-iommu.txt
> @@ -68,6 +68,11 @@ devices might send malicious dma request to virtual machine if there is no
>  iommu isolation. So it would be necessary to only bypass iommu for trusted
>  device.
>  
> +When Intel IOMMU is virtualized, if irq remapping is enabled, PCI and PCIe
> +devices that bypassed vIOMMU will have their MSI/MSI-x functionalities disabled

functionality

> +and fall back to IOAPIC. If this is not desired, disable irq remapping:
> +qemu -device intel-iommu,intremap=off
> +
>  Implementation
>  ==============
>  The bypass iommu feature includes:
> -- 
> 2.45.0


