Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF2CC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4yb-0002aX-7I; Tue, 12 Mar 2024 12:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rk4yT-0002Z5-Ik
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:27:34 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rk4yR-0001qY-BC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:27:33 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7c8ae30bf8fso47403939f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710260848; x=1710865648; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q55MnN0LvCb2kgiAr/MJm3d1SpDTvR8LT65JmJCoZ8s=;
 b=K5xskOm+/OADXEETKCvim+/2qC3tYqbyxq/szx9/sapIsOrP4f2GICzhPvZKDjXJp7
 bSbju5CtGYkjyx7b10sus7ozrtVzSHhsiehMfwa6xtTWiHih/p0pYJIX/dTdi/m8btFa
 8O8WSGurbtYX98mUTUL+RvmMXqAku4Nf1cNpO7Aqd2jSddc7vNI9rBJtDPDnuIMCGsKE
 c5TpERPxynnAPHpNLnBrkI+VSMUg8cl32tNw1FW7ZOezuDD397BdSfrEfPmZsvX9rN2A
 i0FeqRKo5uyyKlneszMSFIo7w56j4mQMmruJmlo5LiCtRBVrMWNQu5YCCNH6v955GPcJ
 2bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710260848; x=1710865648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q55MnN0LvCb2kgiAr/MJm3d1SpDTvR8LT65JmJCoZ8s=;
 b=lsT7OcPT11Nyr3Hl9yjD2hXO4VQwzu6qbIJZ2T7xjav1UR2szWp1XRs5q3xL8Ak8er
 d/D3uoLJImNX4NOSkCgg24i8eu79Sij94dUh7sCk3AhEcgxe4tksQ+Eqa4NcifMQ07qo
 vUjbl1kuNtKFhhqZ+uym9NJ9U/s8C12Dcy6B/sTjqSduND4t0BRq5XUdNyDVVRaxbKAz
 wQRPqJYTyRwh+0Z/x6evOscxgMkgIJuQN1rnZznB8y3TT4tnkurMqU7MuM9e8t6h8OYs
 6quYWl3nzFiGlf/WHDdvM8QhCVADpnTydM491eBq2BDAK3DnRc6l+UYPFydeQJ/N3bT5
 2rPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMz1JSZabAI7HUpXOZ9tUVlYN/wd4yKuB2op7t60u4+i7RH2kcJQLno7l+VedjvpNWWRKD8LwtJFjJfCL2Y5XC+4X+0iI=
X-Gm-Message-State: AOJu0Yyg0skBSCXc02oyMrpmh5GRJFhGHTD0h84K7Sb9dLQT5henYXMv
 QQZQ6ijVkt0gkXmlNXM+F6QOZJleVDG5YHsdsvHaaOvDUJ+VNtNh
X-Google-Smtp-Source: AGHT+IFg1zgxj0wdk8rTzy0XoCXK6YPLGLeQvgI8jQb6fEEi9suzWVyC+RtajJZm45LxWxsl8UQ1/Q==
X-Received: by 2002:a5d:8b09:0:b0:7c8:c659:b951 with SMTP id
 k9-20020a5d8b09000000b007c8c659b951mr4596389ion.7.1710260847974; 
 Tue, 12 Mar 2024 09:27:27 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 h14-20020a02cd2e000000b00474d68c24e6sm2343499jaq.120.2024.03.12.09.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:27:27 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 12 Mar 2024 09:27:05 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZfCCWboh4w3NNVe4@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-10-nifan.cxl@gmail.com>
 <20240306174811.000029fd@Huawei.com> <Zej5EuQXytgeWGfj@debian>
 <20240307124555.00001408@Huawei.com> <ZevnKbzBOy_9sjeg@debian>
 <20240312123723.0000420d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312123723.0000420d@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=nifan.cxl@gmail.com; helo=mail-io1-xd32.google.com
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

On Tue, Mar 12, 2024 at 12:37:23PM +0000, Jonathan Cameron wrote:
> On Fri, 8 Mar 2024 20:35:53 -0800
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Thu, Mar 07, 2024 at 12:45:55PM +0000, Jonathan Cameron wrote:
> > > ...
> > >   
> > > > > > +    list = records;
> > > > > > +    extents = g_new0(CXLDCExtentRaw, num_extents);
> > > > > > +    while (list) {
> > > > > > +        CXLDCExtent *ent;
> > > > > > +        bool skip_extent = false;
> > > > > > +
> > > > > > +        offset = list->value->offset;
> > > > > > +        len = list->value->len;
> > > > > > +
> > > > > > +        extents[i].start_dpa = offset + dcd->dc.regions[rid].base;
> > > > > > +        extents[i].len = len;
> > > > > > +        memset(extents[i].tag, 0, 0x10);
> > > > > > +        extents[i].shared_seq = 0;
> > > > > > +
> > > > > > +        if (type == DC_EVENT_RELEASE_CAPACITY ||
> > > > > > +            type == DC_EVENT_FORCED_RELEASE_CAPACITY) {
> > > > > > +            /*
> > > > > > +             *  if the extent is still pending to be added to the host,    
> > > > > 
> > > > > Odd spacing.
> > > > >     
> > > > > > +             * remove it from the pending extent list, so later when the add
> > > > > > +             * response for the extent arrives, the device can reject the
> > > > > > +             * extent as it is not in the pending list.
> > > > > > +             */
> > > > > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > > > > +                        &extents[i]);
> > > > > > +            if (ent) {
> > > > > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > > > > +                g_free(ent);
> > > > > > +                skip_extent = true;
> > > > > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > > > > +                /* If the exact extent is not in the accepted list, skip */
> > > > > > +                skip_extent = true;
> > > > > > +            }    
> > > > > I think we need to reject case of some extents skipped and others not.
> > > > > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > > > > to do two passes so we know this has happened early (or perhaps this is a later
> > > > > patch in which case a todo here would help).    
> > > > 
> > > > Skip here does not mean the extent is invalid, it just means the extent
> > > > is still pending to add, so remove them from pending list would be
> > > > enough to reject the extent, no need to release further. That is based
> > > > on your feedback on v4.  
> > > 
> > > Ah. I'd missunderstood.  
> > 
> > Hi Jonathan,
> > 
> > I think we should not allow to release extents that are still pending to
> > add. 
> > If we allow it, there is a case that will not work.
> > Let's see the following case (time order):
> > 1. Send request to add extent A to host; (A --> pending list)
> > 2. Send request to release A from the host; (Delete A from pending list,
> > hoping the following add response for A will fail as there is not a matched
> > extent in the pending list).
> 
> Definitely not allow the host to release something it hasn't accepted.
> Should allow QMP to release such entrees though (and same for fmapi when
> we get there). Any such requested from host should be treated as whatever
> it says to do if you release an extent that you don't have.

Not sure how it works here. If we allow QMP to release such extents and
clear the pending list entrees accordingly, later if the host response with
empty extent list, how can the device figure out which request the response is
for. The spec assumes the response comes in order, so the head of the
pending list should be removed from the pending list, however, if QMP
process already removed it.

The key problem here is for empty updated extent list, we do not have a way to
figure out the corresponding request as there is no DPA info to look
into.

> 
> > 3. Host send response to the device for the add request, however, for
> > some reason, it does not accept any of it, so updated list is empty,
> > spec allows it. Based on the spec, we need to drop the extent at the
> > head of the event log. Now we have problem. Since extent A is already
> > dropped from the list, we either cannot drop as the list is empty, which
> > is not the worst. If we have more extents in the list, we may drop the
> > one following A, which is for another request. If this happens, all the
> > following extents will be acked incorrectly as the order has been
> > shifted.
> >  
> > Does the above reasoning make sense to you?
> Absolutely.  I got confused here on who was doing release.
> Host definitely can't release stuff it hasn't successfully accepted.
> 
> Jonathan
> 

The assumption here is FM first initiates the request to add some
extents to the hosts, and later FM initiates to release the extents
while the extents has not been accepted by the host yet. 

Fan
> > 
> > Fan
> > 
> > >   
> > > > 
> > > > The loop here is only to collect the extents to sent to the event log. 
> > > > But as you said, we need one pass before updating pending list.
> > > > Actually if we do not allow the above case where extents to release is
> > > > still in the pending to add list, we can just return here with error, no
> > > > extra dry run needed. 
> > > > 
> > > > What do you think?  
> > > 
> > > I think we need a way to back out extents from the pending to add list
> > > so we can create the race where they are offered to the OS and it takes
> > > forever to accept and by the time it does we've removed them.
> > >   
> > > >   
> > > > >     
> > > > > > +        
> > > > > > +
> > > > > > +        /* No duplicate or overlapped extents are allowed */
> > > > > > +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> > > > > > +                              len / block_size)) {
> > > > > > +            error_setg(errp, "duplicate or overlapped extents are detected");
> > > > > > +            return;
> > > > > > +        }
> > > > > > +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> > > > > > +
> > > > > > +        list = list->next;
> > > > > > +        if (!skip_extent) {
> > > > > > +            i++;    
> > > > > Problem is if we skip one in the middle the records will be wrong below.    
> > > > 
> > > > Why? Only extents passed the check will be stored in variable extents and
> > > > processed further and i be updated. 
> > > > For skipped ones, since i is not updated, they will be
> > > > overwritten by following valid ones.  
> > > Ah. I'd missed the fact you store into the extent without a check on validity
> > > but only move the index on if they were valid. Then rely on not passing a trailing
> > > entry at the end.
> > > If would be more readable I think if local variables were used for the parameters
> > > until we've decided not to skip and the this ended with
> > > 
> > >         if (!skip_extent) {
> > >             extents[i] = (DCXLDCExtentRaw) {
> > >                 .start_dpa = ...
> > > 	        ...
> > >             };
> > >             i++
> > >         }
> > > We have local len already so probably just need
> > > uint64_t start_dpa = offset + dcd->dc.regions[rid].base;
> > > 
> > > Also maybe skip_extent_evlog or something like that to explain we are only
> > > skipping that part. 
> > > Helps people like me who read it completely wrong!
> > > 
> > > Jonathan
> > > 
> > >  
> > >   
> 

