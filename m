Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29399CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqba-0005fg-Ep; Mon, 07 Oct 2024 12:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqbX-0005eP-2j
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxqbV-0007od-Gl
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728318540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aqyGj7XKQ5Qwm5Y7ZXLkMTOwcVoaKIkBF102LtqvvHk=;
 b=ZZFVZ2/Q5dnqIIaq+CsDDqG2kuGop7MHurfqglazV6e2/OPh/CYKHSiGogS281aWlLktv+
 hWuMbfE6xBgp2EZC0BWbg+JeK47YmeGqdulZ2l42MHRfx72Bjo/GN1RdJ3oPMraiKIuJQE
 P8rSRh+L72HMvEQukKIJ0RPtKV+kP6E=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589--5ZChC35Nsu4NP17tsSdMQ-1; Mon, 07 Oct 2024 12:28:58 -0400
X-MC-Unique: -5ZChC35Nsu4NP17tsSdMQ-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a34205e146so63511245ab.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728318537; x=1728923337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqyGj7XKQ5Qwm5Y7ZXLkMTOwcVoaKIkBF102LtqvvHk=;
 b=fULk9RY+V1/oqFJuBJ8RLAIwi01SRhbfrPh5m/4t1i4Wil2osAB+2FLIEetZmpyozM
 4QrSeffYqU3BWMffGRoxbXPWEYwle1VftzJ+C1s9ExWCoPnukZQays+sjgJ/I/pDbnpP
 D3q3adufds8nSAFcxMHe1kF+aK8nOm1lZ7kOffZTli1Y9B72zQhcC97hm3MCDjrNCZ3d
 oe32e916eALaSPOe20LIFk3FIQ811b2KzKLp1m57GByeXbU1fC0nFqYjAA91+gniiH5G
 aroOIM1ojcXIWVXJiLxFfiAQlgvgO/R6n35qYYGxld/WEfGEgULINBQt7SSHifuevqck
 m0/g==
X-Gm-Message-State: AOJu0YwGCAgjNGqzEoXaW/rGhT6Yt1A1+wTMRy2b3wGD7APf4yCrUHf1
 odERnrENxN83klpOIS7X/sTvfh62mKbNNLx6QQw+bXic5nBRRQ8KLaCXHaycCLhoIOWSvNCN0eP
 s7fLU8ypebUKOolxdu+PbepIZ9ND9JgV5BBJZ1YcqGkEDx8lOOGgX
X-Received: by 2002:a92:c269:0:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a375bafe0bmr116749815ab.19.1728318537405; 
 Mon, 07 Oct 2024 09:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ubEzsD9oO/1+RTGVok4YLY53cORHUcy717UbPdM9+H0eo+UK3QNfGdyF8NpWtozzAxz1zw==
X-Received: by 2002:a92:c269:0:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a375bafe0bmr116749535ab.19.1728318536978; 
 Mon, 07 Oct 2024 09:28:56 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a7e790bsm14120955ab.10.2024.10.07.09.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 09:28:56 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:28:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 05/13] physmem: preserve ram blocks for cpr
Message-ID: <ZwQMRlSSqP0i0ITb@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-6-git-send-email-steven.sistare@oracle.com>
 <ZwQDBc-8niK2A0Vt@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZwQDBc-8niK2A0Vt@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Mon, Oct 07, 2024 at 11:49:25AM -0400, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:36PM -0700, Steve Sistare wrote:
> > Save the memfd for anonymous ramblocks in CPR state, along with a name
> > that uniquely identifies it.  The block's idstr is not yet set, so it
> > cannot be used for this purpose.  Find the saved memfd in new QEMU when
> > creating a block.  QEMU hard-codes the length of some internally-created
> > blocks, so to guard against that length changing, use lseek to get the
> > actual length of an incoming memfd.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >  system/physmem.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/system/physmem.c b/system/physmem.c
> > index 174f7e0..ddbeec9 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -72,6 +72,7 @@
> >  
> >  #include "qapi/qapi-types-migration.h"
> >  #include "migration/options.h"
> > +#include "migration/cpr.h"
> >  #include "migration/vmstate.h"
> >  
> >  #include "qemu/range.h"
> > @@ -1663,6 +1664,19 @@ void qemu_ram_unset_idstr(RAMBlock *block)
> >      }
> >  }
> >  
> > +static char *cpr_name(RAMBlock *block)
> > +{
> > +    MemoryRegion *mr = block->mr;
> > +    const char *mr_name = memory_region_name(mr);
> > +    g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
> > +
> > +    if (id) {
> > +        return g_strdup_printf("%s/%s", id, mr_name);
> > +    } else {
> > +        return g_strdup(mr_name);
> > +    }
> > +}
> > +
> >  size_t qemu_ram_pagesize(RAMBlock *rb)
> >  {
> >      return rb->page_size;
> > @@ -1858,14 +1872,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >                                          TYPE_MEMORY_BACKEND)) {
> >              size_t max_length = new_block->max_length;
> >              MemoryRegion *mr = new_block->mr;
> > -            const char *name = memory_region_name(mr);
> > +            g_autofree char *name = cpr_name(new_block);
> >  
> >              new_block->mr->align = QEMU_VMALLOC_ALIGN;
> >              new_block->flags |= RAM_SHARED;
> > +            new_block->fd = cpr_find_fd(name, 0);
> >  
> >              if (new_block->fd == -1) {
> >                  new_block->fd = qemu_memfd_create(name, max_length + mr->align,
> >                                                    0, 0, 0, errp);
> > +                cpr_save_fd(name, 0, new_block->fd);
> > +            } else {
> > +                new_block->max_length = lseek(new_block->fd, 0, SEEK_END);
> 
> So this can overwrite the max_length that the caller specified..
> 
> I remember we used to have some tricks on specifying different max_length
> for ROMs on dest QEMU (on which, qemu firmwares also upgraded on the dest
> host so the size can be bigger than src qemu's old ramblocks), so that the
> MR is always large enough to reload even the new firmwares, while migration
> only migrates the smaller size (used_length) so it's fine as we keep the
> extra sizes empty. I think that can relevant to the qemu_ram_resize() call
> of parse_ramblock().
> 
> The reload will not happen until some point, perhaps system resets.  I
> wonder whether that is an issue in this case.
> 
> +Igor +Mst for this.

PS: If this is needed by CPR-transfer only because mmap() later can fail
due to a bigger max_length, I wonder whether it can be fixed by passing
truncate=true in the upcoming file_ram_alloc(), rather than overwritting
the max_length value itself.

> 
> >              }
> >  
> >              if (new_block->fd >= 0) {
> > @@ -1875,6 +1893,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >                                                   false, 0, errp);
> >              }
> >              if (!new_block->host) {
> > +                cpr_delete_fd(name, 0);
> >                  qemu_mutex_unlock_ramlist();
> >                  return;
> >              }
> > @@ -2182,6 +2201,8 @@ static void reclaim_ramblock(RAMBlock *block)
> >  
> >  void qemu_ram_free(RAMBlock *block)
> >  {
> > +    g_autofree char *name = NULL;
> > +
> >      if (!block) {
> >          return;
> >      }
> > @@ -2192,6 +2213,8 @@ void qemu_ram_free(RAMBlock *block)
> >      }
> >  
> >      qemu_mutex_lock_ramlist();
> > +    name = cpr_name(block);
> > +    cpr_delete_fd(name, 0);
> >      QLIST_REMOVE_RCU(block, next);
> >      ram_list.mru_block = NULL;
> >      /* Write list before version */
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu


