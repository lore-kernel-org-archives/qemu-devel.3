Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E794C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 04:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rioRR-0001Hf-Pk; Fri, 08 Mar 2024 23:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rioRQ-0001HI-8B
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 23:36:12 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rioRO-0005u2-H8
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 23:36:12 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e63e9abf6aso1229624b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 20:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709958968; x=1710563768; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=17QTZ3ChO1eXgGrWivTxrsCH7FEhKd/2ieF4d0cg6FY=;
 b=aad/5qw8YQDwcrsXqxgJxsgTJftCkaj6fpXZHPkgGj1gERNBTGA7jxWSMUovK+FHH8
 yRQaJUs7lamVWP/39jZ9It7NRSDuknsxXrrazV0t3yoMpKs+8L76M39gNAdYXamsmeAl
 lIZd0QHFZ8mDHMxy/L5Svdm2Q1UMJ0ud87Alvm8Qt8TIDH6bqf1J5kyTYuqQZOUtbdYH
 O3rKypo4Kg17GCTpDkPzWp/4PqdlpbasDK9RMEj3mXwyQvA9dVOwqNV0mrH4n9EC17hC
 ZmbIF4gGdg6O09EHA+O0/pf5QHY8n8Rc9vpFNsm3ogHVz7Gw1lWeL4bFX5G1H2xrmLzK
 mtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709958968; x=1710563768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17QTZ3ChO1eXgGrWivTxrsCH7FEhKd/2ieF4d0cg6FY=;
 b=lbST50+5GtaAJOLwiGWFOrS5u7+/NzKgO+y2SFKBKrGw4JJX7twT30KRriUJWzayl4
 gc8UaqCKklRmstdVxQ4DYKTMplYU+xgSr17MeyYFgr8ZtEfSS49xGoPalmP1CjyrsWW+
 z2r7BFhFTpR2zHvCisOiIedNNDAx5Z2BnjtFksfjrOaVa1N/CquK7A7a1I9bGycye3Uw
 d6FjtXRWSU067XP5NvrqMHn/xEZs/yTmrxKNg3UGjf9DrEpfx+T+Zy6Knr4HskZHu2J1
 U5zWeMh7lAux+bGMfYVhItHaHzjGfecC/miBZLyE8yfl43zykLtOMJj+CnY5rHAvJ0kh
 iAFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKbHSvH2h7J24EQJdASLA6z1+oqFEyUPp7IBE5js4Q6T5XcrLHf5JE/eYryXVMtyKgHWDx9JWrtF+Kb5tr4A8xT/0acRI=
X-Gm-Message-State: AOJu0YyKE+Ao6+8PhplSIyOVNf/MLTE9QrvMJEScnalAoqwSNqISSTcX
 qpojOd3drjhcIskxwv1sZj++lybrLT/9gjU+HeGFScu5JFVJuYLkr81IZch2
X-Google-Smtp-Source: AGHT+IHqj1J7G7icMdcHF4VYXAM3cdtUJCEEsu6y22G16ihZCps0aV4hEpKjtF3l03Gi5sqh8IdTDw==
X-Received: by 2002:a17:902:b494:b0:1dc:ad86:8f41 with SMTP id
 y20-20020a170902b49400b001dcad868f41mr663573plr.28.1709958968499; 
 Fri, 08 Mar 2024 20:36:08 -0800 (PST)
Received: from debian ([2601:641:300:14de:68d6:5df5:5646:a413])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a170902ea0500b001dbc3f2e7e8sm452336plg.98.2024.03.08.20.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 20:36:08 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 8 Mar 2024 20:35:53 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZevnKbzBOy_9sjeg@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com> <Zej5EuQXytgeWGfj@debian>
 <20240307124555.00001408@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307124555.00001408@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 07, 2024 at 12:45:55PM +0000, Jonathan Cameron wrote:
> ...
> 
> > > > +    list = records;
> > > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > > +    while (list) {
> > > > +        CXLDCExtent *ent;
> > > > +        bool skip_extent = false;
> > > > +
> > > > +        offset = list->value->offset;
> > > > +        len = list->value->len;
> > > > +
> > > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > > +        extents[i].len = len;
> > > > +        memset(extents[i].tag, 0, 0x10);
> > > > +        extents[i].shared_seq = 0;
> > > > +
> > > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > > +            /*
> > > > +             *  if the extent is still pending to be added to the host,  
> > > 
> > > Odd spacing.
> > >   
> > > > +             * remove it from the pending extent list, so later when the add
> > > > +             * response for the extent arrives, the device can reject the
> > > > +             * extent as it is not in the pending list.
> > > > +             */
> > > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > > +                        &extents[i]);
> > > > +            if (ent) {
> > > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > > +                g_free(ent);
> > > > +                skip_extent = true;
> > > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > > +                /* If the exact extent is not in the accepted list, skip */
> > > > +                skip_extent = true;
> > > > +            }  
> > > I think we need to reject case of some extents skipped and others not.
> > > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > > to do two passes so we know this has happened early (or perhaps this is a later
> > > patch in which case a todo here would help).  
> > 
> > Skip here does not mean the extent is invalid, it just means the extent
> > is still pending to add, so remove them from pending list would be
> > enough to reject the extent, no need to release further. That is based
> > on your feedback on v4.
> 
> Ah. I'd missunderstood.

Hi Jonathan,

I think we should not allow to release extents that are still pending to
add. 
If we allow it, there is a case that will not work.
Let's see the following case (time order):
1. Send request to add extent A to host; (A --> pending list)
2. Send request to release A from the host; (Delete A from pending list,
hoping the following add response for A will fail as there is not a matched
extent in the pending list).
3. Host send response to the device for the add request, however, for
some reason, it does not accept any of it, so updated list is empty,
spec allows it. Based on the spec, we need to drop the extent at the
head of the event log. Now we have problem. Since extent A is already
dropped from the list, we either cannot drop as the list is empty, which
is not the worst. If we have more extents in the list, we may drop the
one following A, which is for another request. If this happens, all the
following extents will be acked incorrectly as the order has been
shifted.
 
Does the above reasoning make sense to you?

Fan

> 
> > 
> > The loop here is only to collect the extents to sent to the event log. 
> > But as you said, we need one pass before updating pending list.
> > Actually if we do not allow the above case where extents to release is
> > still in the pending to add list, we can just return here with error, no
> > extra dry run needed. 
> > 
> > What do you think?
> 
> I think we need a way to back out extents from the pending to add list
> so we can create the race where they are offered to the OS and it takes
> forever to accept and by the time it does we've removed them.
> 
> > 
> > >   
> > > > +        
> > > > +
> > > > +        /* No duplicate or overlapped extents are allowed */
> > > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > > +                              len / block_size)) {
> > > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > > +            return;
> > > > +        }
> > > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > > +
> > > > +        list = list->next;
> > > > +        if (!skip_extent) {
> > > > +            i++;  
> > > Problem is if we skip one in the middle the records will be wrong below.  
> > 
> > Why? Only extents passed the check will be stored in variable extents and
> > processed further and i be updated. 
> > For skipped ones, since i is not updated, they will be
> > overwritten by following valid ones.
> Ah. I'd missed the fact you store into the extent without a check on validity
> but only move the index on if they were valid. Then rely on not passing a trailing
> entry at the end.
> If would be more readable I think if local variables were used for the parameters
> until we've decided not to skip and the this ended with
> 
>         if (!skip_extent) {
>             extents[i] = (DCXLDCExtentRaw) {
>                 .start_dpa = ...
> 	        ...
>             };
>             i++
>         }
> We have local len already so probably just need
> uint64_t start_dpa = offset + dcd->dc.regions[rid].base;
> 
> Also maybe skip_extent_evlog or something like that to explain we are only
> skipping that part. 
> Helps people like me who read it completely wrong!
> 
> Jonathan
> 
>  
> 

