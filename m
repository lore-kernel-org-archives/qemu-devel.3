Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FEBC02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74K-0003yP-CA; Fri, 14 Feb 2025 20:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tj4OT-00017X-Rx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 17:42:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tj4OR-0000jH-2F
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 17:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739572957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=og9kfRCOmDbydRkUH4+UsuoDJALXoSYCWQnHUxcgqlo=;
 b=O87orPuRI9P25xyV8dlCv1/1J9cIVqmKyR/1fRlrI8EZFLbVDk0clZR1c9kO3o62SjEUCH
 jYYWBl7sKyL34H1brhQ9al1UdzGz+b55Qt3I89uqlfh+gWaNLGSpNbhVWjjQmGIugncYyt
 15F3kQgaF8wA3aBGBCI7boCtiVycPH8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-JqhVEL2-PyC5uH7T5jRwZQ-1; Fri, 14 Feb 2025 17:42:35 -0500
X-MC-Unique: JqhVEL2-PyC5uH7T5jRwZQ-1
X-Mimecast-MFC-AGG-ID: JqhVEL2-PyC5uH7T5jRwZQ_1739572954
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e64dac8126so37438056d6.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 14:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739572954; x=1740177754;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=og9kfRCOmDbydRkUH4+UsuoDJALXoSYCWQnHUxcgqlo=;
 b=BzuRFt74HHDwReXwGLKI+SocRlsdtfaeAkuLphhzPaKp2ZH7ub54OQND66kVGTgktW
 f8y1+7yL4rfpcVTMokmNlSzcF17xX3GkJ/aQOYXcuDhpkVhmAyMax4xnLOCmEBAQKgDm
 EEORWbI4CTjf4NPkxA7I0td/66KWudcL7JZ1HCf18El8XDNS3Ps/XC2W+e/wLsueCGV/
 /dsWDBFyK7arfBgP8LxMqkk49aLrGNt+oE386BZJ0bk/6J+GniwgbUWgtMrBxf9hsTvX
 FX9RBKDTgG6QZcUD4O0uHKuxzU8PHXy9lN6uGx1/NnL47XBjiuulSxNsZrti3NRaey+M
 PyPQ==
X-Gm-Message-State: AOJu0YxZMYlgKrvIcyUpvtFwZ/P6SE9cxPXGpmM8LzxuS5/HXmITrJ2Z
 vZ+qSrIBb7Yw2QymmounMH7NzCEmjQUAxu463d+cIF7q0wH3OH31jSjE25oEDaryAV7l67LUyio
 Gy7AqbsO5BkTrHeBdbXEUG+zJdHQCCnQJ8AQMilNGy4vF49lmz65k
X-Gm-Gg: ASbGnct2SRZNy1F2X6tZ79f1kegMV5a/EKJDl2hVyODQwfwgFtTZJYAFrQf8rF29zZY
 5JrlRr/vj1JudIyW8w0sOzkf9ncMy23jOMwQESG56GB99dF91EIiBFKxA236rwG9LyZoQPPC15S
 Q9Yz9IUdTtNR8LgYy/s4DJ9t4WC2x9Wwo+V0lJ32hl4u20trtEBnJ+OMf2u/SK5dfKyd8YPSNPT
 MhizUu+lZwXNvWYjX5BP8ReRDBrMD4cOeJtwTw+qIyZ4UXbFQc5RV3zaO4=
X-Received: by 2002:a05:6214:5085:b0:6d8:ada3:26c9 with SMTP id
 6a1803df08f44-6e66cca5592mr17730206d6.10.1739572954430; 
 Fri, 14 Feb 2025 14:42:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFneiRaUO2+wpyMufKb5oiF3fm53iWpDqSSIhIiR0Q3WM24OCq6jw+l19WSQUo/YekY6gD/2w==
X-Received: by 2002:a05:6214:5085:b0:6d8:ada3:26c9 with SMTP id
 6a1803df08f44-6e66cca5592mr17730006d6.10.1739572954118; 
 Fri, 14 Feb 2025 14:42:34 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65d7793c3sm25988526d6.17.2025.02.14.14.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 14:42:33 -0800 (PST)
Date: Fri, 14 Feb 2025 17:42:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
Message-ID: <Z6_G1rF7x2Nbzpl4@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
 <Z69z6oTtaGOC287O@x1.local>
 <b6e19df6-cb38-4576-bdd0-6278997e402e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6e19df6-cb38-4576-bdd0-6278997e402e@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

On Fri, Feb 14, 2025 at 03:40:57PM -0500, Steven Sistare wrote:
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 4c82979..755eafe 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -2183,9 +2183,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
> > >   }
> > >   /* Called with rcu_read_lock held.  */
> > > -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> > > -                          ram_addr_t *ram_addr, bool *read_only,
> > > -                          bool *mr_has_discard_manager, Error **errp)
> > > +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
> > > +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp)
> > 
> > If we're going to return the MR anyway, probably we can drop
> > mr_has_discard_manager altogether..
> 
> To hoist mr_has_discard_manager to the vfio caller, I would need to return len.
> Your call.

I meant only dropping mr_has_discard_manager parameter from the function
interface, not the ram_discard_manager_is_populated() check.

> 
> > >   {
> > >       MemoryRegion *mr;
> > >       hwaddr xlat;
> > > @@ -2238,18 +2237,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> > >           return false;
> > >       }
> > > -    if (vaddr) {
> > > -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> > > -    }
> > > -
> > > -    if (ram_addr) {
> > > -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> > > -    }
> > > -
> > > -    if (read_only) {
> > > -        *read_only = !writable || mr->readonly;
> > > -    }
> > > -
> > > +    *xlat_p = xlat;
> > > +    *mr_p = mr;
> > 
> > I suppose current use on the callers are still under RCU so looks ok, but
> > that'll need to be rich-documented.
> 
> I can do that, or ...
> 
> > Better way is always taking a MR reference when the MR pointer is returned,
> > with memory_region_ref().  Then it is even valid if by accident accessed
> > after rcu_read_unlock(), and caller should unref() after use.
> 
> I can do that, but it would add cycles.  Is this considered a high performance
> path that may be called frequently?

AFAICT, any vIOMMU mapping isn't high perf path.  In this specific path,
the refcount op should be buried in any dma map operations..

Personally I slightly prefer this one because it's always safer to take a
refcount along with a pointer.. easier to follow.

-- 
Peter Xu


