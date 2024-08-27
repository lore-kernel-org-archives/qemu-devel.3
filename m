Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8359FC5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyRc-0003Ev-HY; Tue, 27 Aug 2024 11:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1siyRb-0003ER-J1
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1siyRY-0004lU-Pi
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724773755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uZLS+nHyEu0AR/ByQ+KyOzaFTvMKJxe82qSdsi30T8=;
 b=cDbqsJwq1JBAarUWLRVhsvUGwKHb7SnDEPdg1RF7monI4Hce7ra/6XR8CcLkQCLCF3VqcZ
 srmLWOsVB5U2WVhUofEmXII/K9kM1tbMmYwfvrVGd9HkrZ4QZ7vBnEfcIvZ84EIAuHAA0Z
 gAcYf5Ez+gpDAr5axE8jZ7Kw/sut7oM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-kcYMUDexM6uvKJEuRLO9rw-1; Tue, 27 Aug 2024 11:49:13 -0400
X-MC-Unique: kcYMUDexM6uvKJEuRLO9rw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42820af1106so47845175e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724773748; x=1725378548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7uZLS+nHyEu0AR/ByQ+KyOzaFTvMKJxe82qSdsi30T8=;
 b=mpURZueQDtqLTZfEGE3cQJheexNI3Pwc0LXzY2nglHB1Z8yYCeR4gV5OMgeM/MHzOb
 mPKGdpIIWlmovCmCKWGjujLxezJob2thYMjuNMc+tozkrsjFqlTg10/QmnhvAoczmabe
 4F05fnUHPBvnisYGJS9IoqjQhZZKguXvEwUiM5N2+hwbPaL/PtjXSghWsdEq3dh15ruD
 ipsJGRwrVp6hWq48ssxUnXpoXXnYL2V425XA7keXoxy53VCKPaSGZTrlzOM3QdXZjucQ
 GOHZ35SABMuE/CFovCeucQQNuekxlgi9UebKjqPmpmBjcYD2v158eEp4ChIuVyK+qGVQ
 4yiw==
X-Gm-Message-State: AOJu0YxDTqGjF6SVzb47eNONC9lYp2/abA2tHSYQCTgoXJgm6TGbL1EQ
 OiCAyqavkTm514cJUj1LFxA5yRmQHhSBqrIH/TXAfviIJsfbABemgdHWiIOawpg2mOi3ugC5Aum
 fqyBsMke5sxwZZjU0gGa3NrlB3sslqhs3ErTzkV8aUn2H+xE5A2ka
X-Received: by 2002:a05:600c:3b0e:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-42acd5403a2mr87240875e9.2.1724773747549; 
 Tue, 27 Aug 2024 08:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkwbrhItRqvLk3mLRmRM9xOEl0/DOsSED50yfmoA4hI2nBxfOSe1Xm/NelowP92d932HrGtg==
X-Received: by 2002:a05:600c:3b0e:b0:426:62c5:4741 with SMTP id
 5b1f17b1804b1-42acd5403a2mr87240495e9.2.1724773746885; 
 Tue, 27 Aug 2024 08:49:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308160586sm13493794f8f.58.2024.08.27.08.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:49:06 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:49:04 +0200
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
 <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v10 1/8] memory: prevent dma-reentracy issues
Message-ID: <20240827174904.28215e26@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240821152518.1a973a7b@imammedo.users.ipa.redhat.com>
References: <20230427211013.2994127-1-alxndr@bu.edu>
 <20230427211013.2994127-2-alxndr@bu.edu>
 <20240821152518.1a973a7b@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 21 Aug 2024 15:25:18 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 27 Apr 2023 17:10:06 -0400
> Alexander Bulekov <alxndr@bu.edu> wrote:
> 
> > Add a flag to the DeviceState, when a device is engaged in PIO/MMIO/DMA.
> > This flag is set/checked prior to calling a device's MemoryRegion
> > handlers, and set when device code initiates DMA.  The purpose of this
> > flag is to prevent two types of DMA-based reentrancy issues:
> > 
> > 1.) mmio -> dma -> mmio case
> > 2.) bh -> dma write -> mmio case  
> 
> Alexander, with 9.0
> we are getting 
> 
>    warning: Blocked re-entrant IO on MemoryRegion: acpi-cpu-hotplug at addr: 0x0
> 
> during CPU hot-unplug, to my knowledge there shouldn't be any DMA involved
> there.
> The only access should be either from guest kernel or firmware(this one is under SMM mode)).
> 
> Question is how this could happen on MMIO access which should be guarded by BQL?

For prosperity, reproducer (RHEL9.4 Haswell host + upstream QEMU/edk https://issues.redhat.com/browse/RHEL-56154):

./qemu-system-x86_64 --enable-kvm -smp 2,maxcpus=24,cores=12,threads=1,dies=1,sockets=2 \
    -cpu host \
    -blockdev '{"node-name": "file_ovmf_code", "driver": "file", "filename": "/tmp/qemu_build/pc-bios/edk2-x86_64-secure-code.fd", "auto-read-only": true, "discard": "unmap"}' \
    -blockdev '{"node-name": "drive_ovmf_code", "driver": "raw", "read-only": true, "file": "file_ovmf_code"}'  \
    -blockdev '{"node-name": "file_ovmf_vars", "driver": "file", "filename": "/tmp/edk_VARS.raw", "auto-read-only": true, "discard": "unmap"}'   \
    -blockdev '{"node-name": "drive_ovmf_vars", "driver": "raw", "read-only": false, "file": "file_ovmf_vars"}'  \
    -M q35,pflash0=drive_ovmf_code,pflash1=drive_ovmf_vars \
    -m 4G \
    -monitor stdio \
    rhel9.5.raw

once booted 

(qemu) device_add host-x86_64-cpu,id=vcpu1,socket-id=1,core-id=10,die-id=0,thread-id=0
(qemu) device_add host-x86_64-cpu,id=vcpu2,socket-id=1,core-id=11,die-id=0,thread-id=0
(qemu) device_del vcpu1
(qemu) qemu-system-x86_64: warning: Blocked re-entrant IO on MemoryRegion: acpi-cpu-hotplug at addr: 0x0
 
> And where to start digging to find out if it's a genuine issue,
> or whether it's safe to use big hammer and disable reentrancy guard?
I'm hesitant to use hammer so far (though it would make problem nop).
What happens is that cpu_remove_sync() temporarily releases BQL
which lets conflicting access to happen.

But I think unexpected access shouldn't be there in the 1st place,
so guard looks pretty legit at this point.
Lets see what Gerd finds out from edk2 point of view.

> 
> 
> > These issues have led to problems such as stack-exhaustion and
> > use-after-frees.
> > 
> > Summary of the problem from Peter Maydell:
> > https://lore.kernel.org/qemu-devel/CAFEAcA_23vc7hE3iaM-JVA6W38LK4hJoWae5KcknhPRD5fPBZA@mail.gmail.com
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/62
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/540
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/541
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/556
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/557
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/827
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1282
> > Resolves: CVE-2023-0330
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  include/exec/memory.h  |  5 +++++
> >  include/hw/qdev-core.h |  7 +++++++
> >  softmmu/memory.c       | 16 ++++++++++++++++
> >  3 files changed, 28 insertions(+)
> > 
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 15ade918ba..e45ce6061f 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -767,6 +767,8 @@ struct MemoryRegion {
> >      bool is_iommu;
> >      RAMBlock *ram_block;
> >      Object *owner;
> > +    /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
> > +    DeviceState *dev;
> >  
> >      const MemoryRegionOps *ops;
> >      void *opaque;
> > @@ -791,6 +793,9 @@ struct MemoryRegion {
> >      unsigned ioeventfd_nb;
> >      MemoryRegionIoeventfd *ioeventfds;
> >      RamDiscardManager *rdm; /* Only for RAM */
> > +
> > +    /* For devices designed to perform re-entrant IO into their own IO MRs */
> > +    bool disable_reentrancy_guard;
> >  };
> >  
> >  struct IOMMUMemoryRegion {
> > diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> > index bd50ad5ee1..7623703943 100644
> > --- a/include/hw/qdev-core.h
> > +++ b/include/hw/qdev-core.h
> > @@ -162,6 +162,10 @@ struct NamedClockList {
> >      QLIST_ENTRY(NamedClockList) node;
> >  };
> >  
> > +typedef struct {
> > +    bool engaged_in_io;
> > +} MemReentrancyGuard;
> > +
> >  /**
> >   * DeviceState:
> >   * @realized: Indicates whether the device has been fully constructed.
> > @@ -194,6 +198,9 @@ struct DeviceState {
> >      int alias_required_for_version;
> >      ResettableState reset;
> >      GSList *unplug_blockers;
> > +
> > +    /* Is the device currently in mmio/pio/dma? Used to prevent re-entrancy */
> > +    MemReentrancyGuard mem_reentrancy_guard;
> >  };
> >  
> >  struct DeviceListener {
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index b1a6cae6f5..fe23f0e5ce 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -542,6 +542,18 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
> >          access_size_max = 4;
> >      }
> >  
> > +    /* Do not allow more than one simultaneous access to a device's IO Regions */
> > +    if (mr->dev && !mr->disable_reentrancy_guard &&
> > +        !mr->ram_device && !mr->ram && !mr->rom_device && !mr->readonly) {
> > +        if (mr->dev->mem_reentrancy_guard.engaged_in_io) {
> > +            warn_report("Blocked re-entrant IO on "
> > +                    "MemoryRegion: %s at addr: 0x%" HWADDR_PRIX,
> > +                    memory_region_name(mr), addr);
> > +            return MEMTX_ACCESS_ERROR;
> > +        }
> > +        mr->dev->mem_reentrancy_guard.engaged_in_io = true;
> > +    }
> > +
> >      /* FIXME: support unaligned access? */
> >      access_size = MAX(MIN(size, access_size_max), access_size_min);
> >      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> > @@ -556,6 +568,9 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
> >                          access_mask, attrs);
> >          }
> >      }
> > +    if (mr->dev) {
> > +        mr->dev->mem_reentrancy_guard.engaged_in_io = false;
> > +    }
> >      return r;
> >  }
> >  
> > @@ -1170,6 +1185,7 @@ static void memory_region_do_init(MemoryRegion *mr,
> >      }
> >      mr->name = g_strdup(name);
> >      mr->owner = owner;
> > +    mr->dev = (DeviceState *) object_dynamic_cast(mr->owner, TYPE_DEVICE);
> >      mr->ram_block = NULL;
> >  
> >      if (name) {  
> 


