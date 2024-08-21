Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E7BC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglLD-0002eJ-Hj; Wed, 21 Aug 2024 09:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sglLB-0002dX-Pu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sglL9-0002K4-1m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724246728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGQFzdm8g/CqgNTekdlqFx3FsatVd0VO6mJuDVSqnws=;
 b=KWwdZrE7vSS2s7TMVlQBobdCLOMDcd/J+7U08/yJw8KTXdzROaVGdPC4WxbavRN7ZeA6Rm
 uNz7WeeGOBiIAU0yEYPTJOjTBzMh5DIydGjkfMF4uEPY4f3/Y3LaLDbyiSgzWEEaPDUaVA
 7Ktga9JbbGrLZU45pcg3ViBVu43iTcQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-aGspKrhRN825DcOrouCN_A-1; Wed, 21 Aug 2024 09:25:27 -0400
X-MC-Unique: aGspKrhRN825DcOrouCN_A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280645e3e0so55109255e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724246721; x=1724851521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oGQFzdm8g/CqgNTekdlqFx3FsatVd0VO6mJuDVSqnws=;
 b=qHoVRteMgMLTe+t9eWghKBGEt7ZcHd+zq76B+ddRCEjhbrhC+fTON4mBa1vWnZlkQe
 vsUxqerPdHxU1zBAwAuUeuZ0KnxlxRS6TI4+I9UiNF4wMbKS/sGE7BP6XfFpa/DBt0lB
 DN8kn1tkj9Ulh/O/PtK9QBQi1WbF4PvNHbEBXkizuMPEY5wkSkgA1oZoGud6L+YfdzcB
 etUbS/FdnLzVgJUM1PkID0OGlSrGdOuj3Tp4pAckMRamN+Cu17rsWeoIaiKjMpx9JCHE
 96S20eCo+yDjcgRigYCPtX5oZ9IZ0ZUXlgXvGYhZJ6EMoX06xxkmKrKqxFkvutgVG3/V
 HX7A==
X-Gm-Message-State: AOJu0YyF/mHbN8NnMMwS0G7e+htnm1sUUSMuy3uWlgp8Yz8Conk6j4ki
 Ey1K/IcEymbzyglRaqrpEbWGLxBQSLu4DUD+ruV6QFFa2cM9Hz7ieUE7vsO6tvxw6t4vKx6uM+u
 xKF62zXu11/BcBM/hRcXNhw9tG7bH9C1uXmpzcy5gO4cRf1APb5hbdlErt1JC
X-Received: by 2002:a05:600c:4509:b0:426:58cb:8ca3 with SMTP id
 5b1f17b1804b1-42abd23c460mr17239285e9.21.1724246721308; 
 Wed, 21 Aug 2024 06:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsuNMT4DZmQIA4/NlAIN3DkZcd7C3ih6FiaI2ETkFrizx4NHwIvuV2hbOgzS/nXofu7AF2ng==
X-Received: by 2002:a05:600c:4509:b0:426:58cb:8ca3 with SMTP id
 5b1f17b1804b1-42abd23c460mr17239025e9.21.1724246720703; 
 Wed, 21 Aug 2024 06:25:20 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abee86d2csm26025545e9.16.2024.08.21.06.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:25:20 -0700 (PDT)
Date: Wed, 21 Aug 2024 15:25:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Mauro Matteo Cascella
 <mcascell@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang
 <jasowang@redhat.com>, David Hildenbrand <david@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Bandan Das <bsd@redhat.com>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Darren Kenny <darren.kenny@oracle.com>, Bin
 Meng <bin.meng@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Jon Maloy
 <jmaloy@redhat.com>, Siqi Chen <coc.cyqh@gmail.com>, Michael Tokarev
 <mjt@tls.msk.ru>
Subject: Re: [PATCH v10 1/8] memory: prevent dma-reentracy issues
Message-ID: <20240821152518.1a973a7b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230427211013.2994127-2-alxndr@bu.edu>
References: <20230427211013.2994127-1-alxndr@bu.edu>
 <20230427211013.2994127-2-alxndr@bu.edu>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
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

On Thu, 27 Apr 2023 17:10:06 -0400
Alexander Bulekov <alxndr@bu.edu> wrote:

> Add a flag to the DeviceState, when a device is engaged in PIO/MMIO/DMA.
> This flag is set/checked prior to calling a device's MemoryRegion
> handlers, and set when device code initiates DMA.  The purpose of this
> flag is to prevent two types of DMA-based reentrancy issues:
> 
> 1.) mmio -> dma -> mmio case
> 2.) bh -> dma write -> mmio case

Alexander, with 9.0
we are getting 

   warning: Blocked re-entrant IO on MemoryRegion: acpi-cpu-hotplug at addr: 0x0

during CPU hot-unplug, to my knowledge there shouldn't be any DMA involved
there.
The only access should be either from guest kernel or firmware(this one is under SMM mode)).

Question is how this could happen on MMIO access which should be guarded by BQL?

And where to start digging to find out if it's a genuine issue,
or whether it's safe to use big hammer and disable reentrancy guard?


> These issues have led to problems such as stack-exhaustion and
> use-after-frees.
> 
> Summary of the problem from Peter Maydell:
> https://lore.kernel.org/qemu-devel/CAFEAcA_23vc7hE3iaM-JVA6W38LK4hJoWae5KcknhPRD5fPBZA@mail.gmail.com
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/62
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/540
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/541
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/556
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/557
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/827
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1282
> Resolves: CVE-2023-0330
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/exec/memory.h  |  5 +++++
>  include/hw/qdev-core.h |  7 +++++++
>  softmmu/memory.c       | 16 ++++++++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 15ade918ba..e45ce6061f 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -767,6 +767,8 @@ struct MemoryRegion {
>      bool is_iommu;
>      RAMBlock *ram_block;
>      Object *owner;
> +    /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
> +    DeviceState *dev;
>  
>      const MemoryRegionOps *ops;
>      void *opaque;
> @@ -791,6 +793,9 @@ struct MemoryRegion {
>      unsigned ioeventfd_nb;
>      MemoryRegionIoeventfd *ioeventfds;
>      RamDiscardManager *rdm; /* Only for RAM */
> +
> +    /* For devices designed to perform re-entrant IO into their own IO MRs */
> +    bool disable_reentrancy_guard;
>  };
>  
>  struct IOMMUMemoryRegion {
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index bd50ad5ee1..7623703943 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -162,6 +162,10 @@ struct NamedClockList {
>      QLIST_ENTRY(NamedClockList) node;
>  };
>  
> +typedef struct {
> +    bool engaged_in_io;
> +} MemReentrancyGuard;
> +
>  /**
>   * DeviceState:
>   * @realized: Indicates whether the device has been fully constructed.
> @@ -194,6 +198,9 @@ struct DeviceState {
>      int alias_required_for_version;
>      ResettableState reset;
>      GSList *unplug_blockers;
> +
> +    /* Is the device currently in mmio/pio/dma? Used to prevent re-entrancy */
> +    MemReentrancyGuard mem_reentrancy_guard;
>  };
>  
>  struct DeviceListener {
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index b1a6cae6f5..fe23f0e5ce 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -542,6 +542,18 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>          access_size_max = 4;
>      }
>  
> +    /* Do not allow more than one simultaneous access to a device's IO Regions */
> +    if (mr->dev && !mr->disable_reentrancy_guard &&
> +        !mr->ram_device && !mr->ram && !mr->rom_device && !mr->readonly) {
> +        if (mr->dev->mem_reentrancy_guard.engaged_in_io) {
> +            warn_report("Blocked re-entrant IO on "
> +                    "MemoryRegion: %s at addr: 0x%" HWADDR_PRIX,
> +                    memory_region_name(mr), addr);
> +            return MEMTX_ACCESS_ERROR;
> +        }
> +        mr->dev->mem_reentrancy_guard.engaged_in_io = true;
> +    }
> +
>      /* FIXME: support unaligned access? */
>      access_size = MAX(MIN(size, access_size_max), access_size_min);
>      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> @@ -556,6 +568,9 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>                          access_mask, attrs);
>          }
>      }
> +    if (mr->dev) {
> +        mr->dev->mem_reentrancy_guard.engaged_in_io = false;
> +    }
>      return r;
>  }
>  
> @@ -1170,6 +1185,7 @@ static void memory_region_do_init(MemoryRegion *mr,
>      }
>      mr->name = g_strdup(name);
>      mr->owner = owner;
> +    mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
>      mr->ram_block = NULL;
>  
>      if (name) {


