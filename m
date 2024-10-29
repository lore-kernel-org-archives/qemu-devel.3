Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402ACD3A697
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 19:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5s8b-0002FH-7O; Tue, 29 Oct 2024 15:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t5s8a-0002F4-7P
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t5s8V-0006Dn-Cm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 15:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730231050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gy4tQ2I8oxLM85aa9GC6rLL9nM743by8anO9/wrzkNM=;
 b=bn5rWlxRd63iAdZxUv3WRJs9N2DAWuITRhP95y9UgLGtcGPWKucjptmBEceoqNprUKncMu
 kzQdu0D6hPVsZENTml2Jgupj2jEkGGXWGAibgeilFkbNOonxW5usWlW5gd+HISHhezMkBV
 jBNU2pehlZ/bU6YTOMB1AQry1LKv4Qg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-H3gJQ5LwO52zFSpqzejwyA-1; Tue, 29 Oct 2024 15:44:08 -0400
X-MC-Unique: H3gJQ5LwO52zFSpqzejwyA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5ca5bfc8so2975949f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 12:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730231047; x=1730835847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gy4tQ2I8oxLM85aa9GC6rLL9nM743by8anO9/wrzkNM=;
 b=mj/MHCgo4wLeC2fg+uXGM6STGBHVgRJKCD2Nz719mItgBcu5VRgDxaLvsczSCDB95A
 S674m9RNUthl6c/OJCeyNnd7C8JRhiue3YqDFNOqYnvFNSSPu9Z/+1Ha24xG6+8imDiT
 XlgIX7+eUUTXF46V4j0A8TULrkiGgmBZlEAi+0iPF9DXyczE1VdrSW6tYc5lXGKC2APi
 lhzsb0ukqADWwt7NoLNlKEejJTOwwS7OMerBobmlv3c04aQcEwSt3nXQY/Isz6/Pbitf
 YyD8/vyGlNI8cSHVZWONkSXQ88BTkraFIGZYFzX/keqD43mstR3n45mcAu78FBlhBFac
 ilDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwfzkRtDhsETDeNriXkUAYcTuoN3ai7la+8ZFv/wWXNAsWKuSW+qs0DAJSe5Px2op5FWZotYxeWqPf@nongnu.org
X-Gm-Message-State: AOJu0Yx1ACsJtFlhCrsRhf58YpHyrHApo3SYavlH+xW0kN6S4v0+zwm1
 0ymjmsaMC/z33anm87kXartBMCvqPe65l3Q8lGkQIHLZLSL/dVSiVcJ3QTJXjJFkKrMRclEObEe
 aSTXAx7vr/Ejy7YAvQA3yUmlx6winaCzuqOPGGpzotgqmXXXhL1Ub
X-Received: by 2002:adf:fe50:0:b0:37d:4517:acdb with SMTP id
 ffacd0b85a97d-38061137af8mr9219591f8f.20.1730231046748; 
 Tue, 29 Oct 2024 12:44:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBGRCigo98U0I56X64LL6joj85sveEmZsQy4JWVyzintzPfiByUkfgOwf/RjgvudC6F2lsbQ==
X-Received: by 2002:adf:fe50:0:b0:37d:4517:acdb with SMTP id
 ffacd0b85a97d-38061137af8mr9219575f8f.20.1730231046318; 
 Tue, 29 Oct 2024 12:44:06 -0700 (PDT)
Received: from redhat.com ([2.52.26.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5430edsm185262605e9.2.2024.10.29.12.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:44:05 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, zuoboqun@baidu.com,
 david@redhat.com, qemu-devel@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>, wangliang44@baidu.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-pci: fix memory_region_find for
 VirtIOPCIRegion's MR
Message-ID: <20241029154315-mutt-send-email-mst@kernel.org>
References: <20241009095827.67393-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009095827.67393-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 09, 2024 at 05:58:27PM +0800, Gao Shiyuan wrote:
> As shown below, if a virtio PCI device is attached under a pci-bridge, the MR
> of VirtIOPCIRegion does not belong to any address space. So memory_region_find
> cannot be used to search for this MR.
> 
> Introduce the virtio-pci and pci_bridge address spaces to solve this problem.
> 
> Before:
> memory-region: pci_bridge_pci
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>       00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>       00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>     0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>       0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>       0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>       0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>       0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> After:
> address-space: virtio-pci-cfg-mem-as
>   0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>     0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>     0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>     0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>     0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> address-space: pci_bridge_pci_mem
>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>     00000000fe840000-00000000fe840fff (prio 1, i/o): virtio-net-pci-msix
>       00000000fe840000-00000000fe84003f (prio 0, i/o): msix-table
>       00000000fe840800-00000000fe840807 (prio 0, i/o): msix-pba
>     0000380000000000-0000380000003fff (prio 1, i/o): virtio-pci
>       0000380000000000-0000380000000fff (prio 0, i/o): virtio-pci-common-virtio-net
>       0000380000001000-0000380000001fff (prio 0, i/o): virtio-pci-isr-virtio-net
>       0000380000002000-0000380000002fff (prio 0, i/o): virtio-pci-device-virtio-net
>       0000380000003000-0000380000003fff (prio 0, i/o): virtio-pci-notify-virtio-net
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2576
> Fixes: ffa8a3e3b2e6 ("virtio-pci: Add lookup subregion of VirtIOPCIRegion MR")
>

no empty lines between headers pls.
 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Wang Liang <wangliang44@baidu.com>


Daniel can you pls confirm it fixes the bug you reported with bsd?

> ---
>  hw/pci/pci_bridge.c            | 4 ++++
>  hw/virtio/virtio-pci.c         | 5 +++++
>  include/hw/pci/pci_bridge.h    | 2 ++
>  include/hw/virtio/virtio-pci.h | 3 +++
>  4 files changed, 14 insertions(+)
> 
> v1 -> v2:
> * modify commit message
> * add address space for port I/O notification config region
> 
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 6a4e38856d..099ea9e24e 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -380,9 +380,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
>      sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
>      sec_bus->address_space_mem = &br->address_space_mem;
>      memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
> +    address_space_init(&br->as_mem, &br->address_space_mem, "pci_bridge_pci_mem");
>      sec_bus->address_space_io = &br->address_space_io;
>      memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
>                         4 * GiB);
> +    address_space_init(&br->as_io, &br->address_space_io, "pci_bridge_pci_io");
>      pci_bridge_region_init(br);
>      QLIST_INIT(&sec_bus->child);
>      QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
> @@ -399,6 +401,8 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
>      PCIBridge *s = PCI_BRIDGE(pci_dev);
>      assert(QLIST_EMPTY(&s->sec_bus.child));
>      QLIST_REMOVE(&s->sec_bus, sibling);
> +    address_space_destroy(&s->as_mem);
> +    address_space_destroy(&s->as_io);
>      pci_bridge_region_del(s, &s->windows);
>      pci_bridge_region_cleanup(s, &s->windows);
>      /* object_unparent() is called automatically during device deletion */
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 4d832fe845..1e862dd0df 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2057,6 +2057,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>          if (modern_pio) {
>              memory_region_init(&proxy->io_bar, OBJECT(proxy),
>                                 "virtio-pci-io", 0x4);
> +            address_space_init(&proxy->modern_cfg_io_as, &proxy->io_bar, "virtio-pci-cfg-io-as");
>  
>              pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
>                               PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
> @@ -2180,6 +2181,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>                         /* PCI BAR regions must be powers of 2 */
>                         pow2ceil(proxy->notify.offset + proxy->notify.size));
>  
> +    address_space_init(&proxy->modern_cfg_mem_as, &proxy->modern_bar, "virtio-pci-cfg-mem-as");
> +
>      if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
>          proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
> @@ -2275,6 +2278,8 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
>          pci_is_express(pci_dev)) {
>          pcie_aer_exit(pci_dev);
>      }
> +    address_space_destroy(&proxy->modern_cfg_mem_as);
> +    address_space_destroy(&proxy->modern_cfg_io_as);
>  }
>  
>  static void virtio_pci_reset(DeviceState *qdev)
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..bd12fbe4ef 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -72,6 +72,8 @@ struct PCIBridge {
>       */
>      MemoryRegion address_space_mem;
>      MemoryRegion address_space_io;
> +    AddressSpace as_mem;
> +    AddressSpace as_io;
>  
>      PCIBridgeWindows windows;
>  
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 9e67ba38c7..971c5fabd4 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -147,6 +147,9 @@ struct VirtIOPCIProxy {
>      };
>      MemoryRegion modern_bar;
>      MemoryRegion io_bar;
> +    /* address space for VirtIOPCIRegions */
> +    AddressSpace modern_cfg_mem_as;
> +    AddressSpace modern_cfg_io_as;
>      uint32_t legacy_io_bar_idx;
>      uint32_t msix_bar_idx;
>      uint32_t modern_io_bar_idx;
> -- 
> 2.34.1


