Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EA8C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 17:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkRNv-0006ol-BO; Tue, 18 Feb 2025 12:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkRNt-0006oX-DJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkRNr-0000os-Kb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 12:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739899666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9vYu7T5rQmHVgd58y6jxv6rRz9rlPjCC2EcTJBViSQ=;
 b=IrR8PcqTlk5XMwRRFnzzIvB8tuCu//ZSQRX0dLTndPUq6R7VTk3Yh0bSPGDnipoRVyTobB
 2byXgWkZzYwfcf7/VYdvGUrKI0YDhLuzEQmHKs9PI9+rBgrkyPDB2JCEUVh6wisqqMH36S
 2sGMV4Lw1ZOaUVCNVkon+6VEWjcrHjs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-NPTFZsiLNeGRpNIxDZ5Biw-1; Tue, 18 Feb 2025 12:27:44 -0500
X-MC-Unique: NPTFZsiLNeGRpNIxDZ5Biw-1
X-Mimecast-MFC-AGG-ID: NPTFZsiLNeGRpNIxDZ5Biw_1739899663
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5fce04707a2so629278eaf.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 09:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739899663; x=1740504463;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p9vYu7T5rQmHVgd58y6jxv6rRz9rlPjCC2EcTJBViSQ=;
 b=sXaaSMTHnigZaUQz6QnCKeGq2nYRNAgDz4cIvmcWQEX3uGrehgHWna51cv/Vocay1L
 OMt2EfMd2q8CxnNTtohApCd9mlKlCqU0tYjRSGRiQcQspZ2Eb5wMCRS2Odk6z+ef3P9X
 AKxCQeRf69Ufb92qJIUGvLdR0hZYPnGA32jqYzxEik2O4sPyBkOrWDMgaOQQycP1+5j3
 kyJMEvOPEr4BGNPG64Boml409NhZOg/vlcZWTSNBMHhXhm/2AZHf9oUt5uhTf9l9Txa0
 B3YAy0dCjMtFUldgFxfBgAuUQX8sifi9E19nffkEPnFwu2bmPUVulc/35GpQcvIutlnX
 vXAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh4Q1j7AflFhnKNyA0ZWxYPZ8ZDGimVJF2YBR5aKJsBlyQu+h2L2JVuVOdHQi5ec3JbO7q0Zoys/zB@nongnu.org
X-Gm-Message-State: AOJu0YwvyPlJw++fGZmyUyIGeVW6rJlr8pd4eQEWO9Sw8t4RS+vfloUe
 yZK8x5T8GKppeHvBfQvHGGIW2hJl/nne+LLeQLgQsTplG10au707sn/qBxy3k3+3Y6DYTfIeuhZ
 LeN8Kg7hUgkkepGjHSLlSckUwlf8jYIVzIEptn6CSMuj49fVNkNKa
X-Gm-Gg: ASbGnctDELuuvMw+n2r89bm1+kgWRTMqQSWlP4QYp4dJsLOzMeFVPCoqHHXJUxChhbh
 7i9wPWtgHzQo60tw3DzXUj4BSEMybBbAscoX2vUi80213RXuy+Cb1OtlRVMziD6LUW9hd4Om1e8
 VUpFj773GgioTxpiGm8Y9YIbECgPbU2+BrIqZ8b919kgtf+MUQY4c0q3RlWKl2FKGgNH7YKeYjJ
 yznHFqkLY3oKawgx9z8RUmqNPZjIuzmrwsZrGM76wI4MqLRnZkEynj8Ppw=
X-Received: by 2002:a05:6820:50d:b0:5fc:a389:7395 with SMTP id
 006d021491bc7-5fcc56b9a98mr8587622eaf.4.1739899663418; 
 Tue, 18 Feb 2025 09:27:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0+QfhnJRm+Jp6qU1Gw6d9Dv73FOuD6FhNrgnOpXoQ8e97/KRUolOIt7ZK9hHb+wmjdXX4+g==
X-Received: by 2002:a05:6820:50d:b0:5fc:a389:7395 with SMTP id
 006d021491bc7-5fcc56b9a98mr8587607eaf.4.1739899663116; 
 Tue, 18 Feb 2025 09:27:43 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fcb167c763sm3567217eaf.6.2025.02.18.09.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:27:42 -0800 (PST)
Date: Tue, 18 Feb 2025 12:27:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V2] migration: ram block cpr blockers
Message-ID: <Z7TDCmRSI1DBODLn@x1.local>
References: <1739563953-227207-1-git-send-email-steven.sistare@oracle.com>
 <7e781592-ea91-4a3a-9855-8e5479e0b61e@redhat.com>
 <49c83982-46bf-4ab3-a683-776d4c342b27@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49c83982-46bf-4ab3-a683-776d4c342b27@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Feb 14, 2025 at 04:44:40PM -0500, Steven Sistare wrote:
> On 2/14/2025 4:21 PM, David Hildenbrand wrote:
> > On 14.02.25 21:12, Steve Sistare wrote:
> > > Unlike cpr-reboot mode, cpr-transfer mode cannot save volatile ram blocks
> > > in the migration stream file and recreate them later, because the physical
> > > memory for the blocks is pinned and registered for vfio.  Add a blocker
> > > for volatile ram blocks.
> > > 
> > > Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
> > > sufficient for CPR, but it has not been tested yet.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > ---
> > >   include/exec/memory.h   |  3 +++
> > >   include/exec/ramblock.h |  1 +
> > >   migration/savevm.c      |  2 ++
> > >   system/physmem.c        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 74 insertions(+)
> > > 
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index 9f73b59..ea5d33a 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -3184,6 +3184,9 @@ bool ram_block_discard_is_disabled(void);
> > >    */
> > >   bool ram_block_discard_is_required(void);
> > > +void ram_block_add_cpr_blocker(RAMBlock *rb, Error **errp);
> > > +void ram_block_del_cpr_blocker(RAMBlock *rb);
> > > +
> > >   #endif
> > >   #endif
> > > diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> > > index 0babd10..64484cd 100644
> > > --- a/include/exec/ramblock.h
> > > +++ b/include/exec/ramblock.h
> > > @@ -39,6 +39,7 @@ struct RAMBlock {
> > >       /* RCU-enabled, writes protected by the ramlist lock */
> > >       QLIST_ENTRY(RAMBlock) next;
> > >       QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> > > +    Error *cpr_blocker;
> > >       int fd;
> > >       uint64_t fd_offset;
> > >       int guest_memfd;
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index bc375db..85a3559 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -3315,12 +3315,14 @@ void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> > >       qemu_ram_set_idstr(mr->ram_block,
> > >                          memory_region_name(mr), dev);
> > >       qemu_ram_set_migratable(mr->ram_block);
> > > +    ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
> > >   }
> > >   void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
> > >   {
> > >       qemu_ram_unset_idstr(mr->ram_block);
> > >       qemu_ram_unset_migratable(mr->ram_block);
> > > +    ram_block_del_cpr_blocker(mr->ram_block);
> > >   }
> > >   void vmstate_register_ram_global(MemoryRegion *mr)
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 67c9db9..c416068 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -70,7 +70,10 @@
> > >   #include "qemu/pmem.h"
> > > +#include "qapi/qapi-types-migration.h"
> > > +#include "migration/blocker.h"
> > >   #include "migration/cpr.h"
> > > +#include "migration/options.h"
> > >   #include "migration/vmstate.h"
> > >   #include "qemu/range.h"
> > > @@ -1899,6 +1902,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> > >               qemu_mutex_unlock_ramlist();
> > >               goto out_free;
> > >           }
> > > +
> > > +        error_setg(&new_block->cpr_blocker,
> > > +                   "Memory region %s uses guest_memfd, "
> > > +                   "which is not supported with CPR.",
> > > +                   memory_region_name(new_block->mr));
> > > +        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
> > > +                                  MIG_MODE_CPR_TRANSFER,
> > > +                                  -1);
> > >       }
> > >       ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
> > > @@ -4059,3 +4070,60 @@ bool ram_block_discard_is_required(void)
> > >       return qatomic_read(&ram_block_discard_required_cnt) ||
> > >              qatomic_read(&ram_block_coordinated_discard_required_cnt);
> > >   }
> > > +
> > > +/*
> > > + * Return true if ram contents would be lost during CPR.  Do not exclude rom,
> > > + * because the rom file could change in new QEMU.
> > > + */
> > > +static bool ram_is_volatile(RAMBlock *rb)
> > 
> > Can we call this
> > 
> > ram_is_cpr_compatible() / ram_is_cpr_incompatible() or sth. instead?
> > 
> > Talking about RAM and "volatile" is misleading, and the function is specific to CPR already (e.g., comment :) ).
> 
> Will do, thanks - steve

With that, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


