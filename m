Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9EDC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddAi-0001Xp-9d; Mon, 12 Aug 2024 18:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sddAf-0001Vp-97
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1sddAc-0002OZ-B1
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723500340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g2zslLS05921Vp80l9L8TeAYrqB+9IapWBWMiK04LTg=;
 b=Y8fAqoz6js//Fn8VpJaEUBIFnFhIJwt42m7VMdlJEvti3IC2PVIp2bxyNgUhrm6Q26AHGh
 n5mTIDvVEYyLJvZ7wsD8UY8+8BnpEAMWJoAPTRaZsupBiPddRvW4xA85keXB8AQ9OlTzXL
 ZioPs0ztIisSfmnBiV0DUopu9gUQp4g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-BZO71SqTOFCAibjtuPBHTg-1; Mon, 12 Aug 2024 18:05:39 -0400
X-MC-Unique: BZO71SqTOFCAibjtuPBHTg-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-81fc0896188so566058039f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723500339; x=1724105139;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2zslLS05921Vp80l9L8TeAYrqB+9IapWBWMiK04LTg=;
 b=HxoITSRgDnPTT993wt3mOXTPoIuILV8LMY92xhkb9PeAoKrYt1jYrVSmUDb9kFkh/M
 YQtudWMkPN5KZlwe1YS+cPjq55sebjJyPdOBbgCKqWpTEH5KAa9a2Ij7M1sdTzKrgaPO
 KcMY0ZJG1pcUwprrLIuHoxnByjVIBVVoKlVELPYSwqQQW/Q4fqGPUYBG/J3ejIJP2noT
 umQMnJSzQa+i1m19p8hCsdFbdzuKsO5t8JQM85b8Xy1H7/yrW4HyZH+jev8wUDFMNOes
 F3O8XOCsEFzxS8NJWXys0gnj0hLjxnraY0tgpr7J8nQJ364CjJjudHw4jyX5fmaXQHdW
 26BA==
X-Gm-Message-State: AOJu0YwxKZBxmX16aDI4+zILqX7BxT5jYXah1HsgJ2JJSM1QZm3qFEBP
 Q4DnEa2LQrtQAfCgnYdqT0qLZQULSBoYJhDQ2112cidFwjJXPUFhUUdBkOoDYstHYeSe29i3oYn
 1xMCrNz5S1PI7ioUTYqK6B23deBObHhd6QeMoqpjNYGUYUGpCxbo6
X-Received: by 2002:a05:6602:48f:b0:817:49a2:fcf7 with SMTP id
 ca18e2360f4ac-824c9a74429mr292334039f.17.1723500338774; 
 Mon, 12 Aug 2024 15:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Jb55DkSaX8AfTrcL2G4SEfKKbolFTMS9AkUloS/AuFmClAlQwtJv6hmUgLdZEU3rlNV+4g==
X-Received: by 2002:a05:6602:48f:b0:817:49a2:fcf7 with SMTP id
 ca18e2360f4ac-824c9a74429mr292329639f.17.1723500338370; 
 Mon, 12 Aug 2024 15:05:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76a01f9dsm1833833173.89.2024.08.12.15.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 15:05:37 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:05:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Cedric
 Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, Philippe
 Mathieu-Daude <philmd@linaro.org>, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC V1 02/12] iommufd: no DMA to BARs
Message-ID: <20240812160535.7a858dde.alex.williamson@redhat.com>
In-Reply-To: <1721502937-87102-3-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
 <1721502937-87102-3-git-send-email-steven.sistare@oracle.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, 20 Jul 2024 12:15:27 -0700
Steve Sistare <steven.sistare@oracle.com> wrote:

> Do not map VFIO PCI BARs for DMA.  This stops a raft of warnings of the
> following form at QEMU start time when using -object iommufd:
> 
> qemu-kvm: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
> qemu-kvm: vfio_container_dma_map(0x555558282db0, 0x8800010000, 0x4000, 0x7ffff7ff0000) = -14 (Bad address)

NAK.  These mappings are required for P2P DMA between devices.  This is
currently a gap in IOMMUFD support that it doesn't have parity to legacy
vfio containers for these mappings.  Thanks,

Alex

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/vfio/common.c      | 3 ++-
>  hw/vfio/helpers.c     | 1 +
>  include/exec/memory.h | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index da2e0ec..403d45a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -248,7 +248,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>              * are never accessed by the CPU and beyond the address width of
>              * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
>              */
> -           section->offset_within_address_space & (1ULL << 63);
> +           section->offset_within_address_space & (1ULL << 63) ||
> +           section->mr->no_dma;
>  }
>  
>  /* Called with rcu_read_lock held.  */
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b14edd4..e4cfdd2 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -435,6 +435,7 @@ int vfio_region_mmap(VFIORegion *region)
>                                            memory_region_owner(region->mem),
>                                            name, region->mmaps[i].size,
>                                            region->mmaps[i].mmap);
> +        region->mmaps[i].mem.no_dma = true;
>          g_free(name);
>          memory_region_add_subregion(region->mem, region->mmaps[i].offset,
>                                      &region->mmaps[i].mem);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ea03ef2..850cc8c 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -794,6 +794,7 @@ struct MemoryRegion {
>      bool unmergeable;
>      uint8_t dirty_log_mask;
>      bool is_iommu;
> +    bool no_dma;
>      RAMBlock *ram_block;
>      Object *owner;
>      /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */


