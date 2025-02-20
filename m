Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD1A6C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlFRW-0004Lq-Tr; Thu, 20 Feb 2025 17:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFRV-0004Le-7U
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlFRT-0008R8-9t
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740092089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+VVvmoiXHtWgSlmaGYq7fYfKAVNKP3/gzOwZDgLMjIY=;
 b=YTNTnpTteV8UhY+WaWUqHxQTPa/m3e8P8tGUGEKwR5qfCePiGj+bXfM2BSgWnXLuxVseSn
 zw5r9nBXEY/qywDt7tQQqjxNcaXCncU0VllbmUXVJ8aQoTO6iwHc0E1kY7qfXp25mD1UgJ
 4WYVZ/TuZrvdTjjEWOMlamTgTpdo7vU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-6Yhh0XTbPgusgeOJFOlttg-1; Thu, 20 Feb 2025 17:54:46 -0500
X-MC-Unique: 6Yhh0XTbPgusgeOJFOlttg-1
X-Mimecast-MFC-AGG-ID: 6Yhh0XTbPgusgeOJFOlttg_1740092085
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb93de227dso163213266b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 14:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740092085; x=1740696885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VVvmoiXHtWgSlmaGYq7fYfKAVNKP3/gzOwZDgLMjIY=;
 b=OBtGH0l2VtQF3Ils3agb3NBdFKW0x3kcu5BaeFiId4GYOYxTFZHJcsnnlCAsvoxzR5
 z7OfRwiv+3Q5wXMJJMsNsAGM8kK7tQWfiziWDS1UsluMHu3ZlQKxiXh9tu6KMWcQZHFL
 cjI1sZOmDWZCXB789Cv/j58XaFVza75MLP3OaSW6+JPC8KoI/NvfPhEA9dHlSSBC/t3Y
 mrYLE8xk5S5bKMA2u3moAmUM2hPSk/mGHTgwBG1IG8oE5+yK/QnKAm4pIUZJe8krg4Gi
 EcH+K/4jqBhDAWktVT1DSr2o2ZyTRdhAYz5SYOIkkDemWyXmL3xllwBT+l0YIIW9fq91
 zkvA==
X-Gm-Message-State: AOJu0YxkgrQVhurU5XjJvV0lGlYoxLhuN7PNKjwUjMYyTTYNk1uTQ85A
 RGobYLiGxrSGOUo+T3Fnz3eHKE74K7gV5lvwF2+Uos/+pTIE9ACIiLuVcybvHC5hrsBBcqpERji
 A4cjM1Jio6wcllhLFiePAlrramveQVHceEpxu6pVJqOk7BJXfPY1x
X-Gm-Gg: ASbGnctDJTSwW+n1n3fD8Ba7ctVLkQl1Dj4fpyX9klKydnUHwZWWUG2NlCEi1ur36e0
 2wB2s56ix5FU2YLKbWYbvAEUAqdn4lRT4GbanwAeX3dRuz2fbDiumChOCCpklX08aAQsPeKS1G4
 EVeBD4nX9v8SQzTQZsZ/s8LVjcuav6xA3ymrIml3xJO1L4lzZU9D6V29wi7i/lNX0WDAsWJ+e7h
 2QVT0ap8kfdQ6Hv6ERiggmwDcdCUg726+cPh0F7FxcRTw4T1X6Ea3uIeRKyJfUxVf/U2w==
X-Received: by 2002:a17:907:7ea8:b0:ab6:d575:9540 with SMTP id
 a640c23a62f3a-abc09d2de9amr100902766b.50.1740092085483; 
 Thu, 20 Feb 2025 14:54:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu7EiO8QQ8YPIQuhIjQKc5QdYq2XOoj7VQ1E/J6ry+71sv6FtvSjh9UebJPqE8DaV/jQaJqg==
X-Received: by 2002:a17:907:7ea8:b0:ab6:d575:9540 with SMTP id
 a640c23a62f3a-abc09d2de9amr100901466b.50.1740092085118; 
 Thu, 20 Feb 2025 14:54:45 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9723a559sm909561066b.96.2025.02.20.14.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 14:54:44 -0800 (PST)
Date: Thu, 20 Feb 2025 17:54:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com, eric.auger@redhat.com,
 clg@redhat.com, zhenzhong.duan@intel.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
Message-ID: <20250220175420-mutt-send-email-mst@kernel.org>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220224918.2520417-1-alex.williamson@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 20, 2025 at 03:48:53PM -0700, Alex Williamson wrote:
> Eric recently identified an issue[1] where during graceful shutdown
> of a VM in a vIOMMU configuration, the guest driver places the device
> into the D3 power state, the vIOMMU is then disabled, triggering an
> AddressSpace update.  The device BARs are still mapped into the AS,
> but the vfio host driver refuses to DMA map the MMIO space due to the
> device power state.
> 
> The proposed solution in [1] was to skip mappings based on the
> device power state.  Here we take a different approach.  The PCI spec
> defines that devices in D1/2/3 power state should respond only to
> configuration and message requests and all other requests should be
> handled as an Unsupported Request.  In other words, the memory and
> IO BARs are not accessible except when the device is in the D0 power
> state.
> 
> To emulate this behavior, we can factor the device power state into
> the mapping state of the device BARs.  Therefore the BAR is marked
> as unmapped if either the respective command register enable bit is
> clear or the device is not in the D0 power state.
> 
> In order to implement this, the PowerState field of the PMCSR
> register becomes writable, which allows the device to appear in
> lower power states.  This also therefore implements D3 support
> (insofar as the BAR behavior) for all devices implementing the PM
> capability.  The PCI spec requires D3 support.
> 
> An aspect that needs attention here is whether this change in the
> wmask and PMCSR bits becomes a problem for migration, and how we
> might solve it.  For a guest migrating old->new, the device would
> always be in the D0 power state, but the register becomes writable.
> In the opposite direction, is it possible that a device could
> migrate in a low power state and be stuck there since the bits are
> read-only in old QEMU?  Do we need an option for this behavior and a
> machine state bump, or are there alternatives?
> 
> Thanks,
> Alex
> 
> [1]https://lore.kernel.org/all/20250219175941.135390-1-eric.auger@redhat.com/


PCI bits:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge.

> Alex Williamson (5):
>   hw/pci: Basic support for PCI power management
>   pci: Use PCI PM capability initializer
>   vfio/pci: Delete local pm_cap
>   pcie, virtio: Remove redundant pm_cap
>   hw/vfio/pci: Re-order pre-reset
> 
>  hw/net/e1000e.c                 |  3 +-
>  hw/net/eepro100.c               |  4 +-
>  hw/net/igb.c                    |  3 +-
>  hw/nvme/ctrl.c                  |  3 +-
>  hw/pci-bridge/pcie_pci_bridge.c |  3 +-
>  hw/pci/pci.c                    | 83 ++++++++++++++++++++++++++++++++-
>  hw/pci/trace-events             |  2 +
>  hw/vfio/pci.c                   | 29 ++++++------
>  hw/vfio/pci.h                   |  1 -
>  hw/virtio/virtio-pci.c          | 11 ++---
>  include/hw/pci/pci.h            |  3 ++
>  include/hw/pci/pci_device.h     |  3 ++
>  include/hw/pci/pcie.h           |  2 -
>  13 files changed, 112 insertions(+), 38 deletions(-)
> 
> -- 
> 2.48.1


