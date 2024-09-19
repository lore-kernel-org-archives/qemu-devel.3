Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C152CF3971
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 21:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srOWc-0004AB-PS; Thu, 19 Sep 2024 17:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srOWb-00049a-An
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 17:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srOWZ-0000fz-FO
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 17:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726780634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x/MEFqI0T8jZgzSyJ42l8zJUWwRsvwLkGSLCrSnVkTQ=;
 b=JXyyUVZntloH89+5PbXFfxJsvSeERH2vMPRJJyayRkV9wajlUrLB8XN1SEqwolTJdtaUcb
 WFAKKAFfuCGdNrURvW2m6ujaFqPCT5FCUGMlskPAkdo6oFKZRdcoUSEpIP76TdLjSKa2NK
 4bmMK1l1aXd5D4iD/+yycMarjoUhFn4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-GRbiB5zoMGOL7qyIm6UuXQ-1; Thu, 19 Sep 2024 17:17:12 -0400
X-MC-Unique: GRbiB5zoMGOL7qyIm6UuXQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45829988555so17372451cf.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 14:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726780632; x=1727385432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/MEFqI0T8jZgzSyJ42l8zJUWwRsvwLkGSLCrSnVkTQ=;
 b=KU8mOcsus+K8U5B1F4iVsYcKo2Pnv4JuxbqFO+fvvKFMMLGzKvcZsfEpf0x0dhLI0f
 rwPgv9o65THDMoaR9Z1JfIGhNCblZIvm//P5Dx2XIKFP7AEBcOV3sFq3yF5xs84v7QND
 X5Pgs6yexGgwKJ2jI+CLQNe86AGWHAoPHjRNL5bNQbZfwLtnQ2ntCTRJRJYMyWT9eKo+
 /equZIOKHK4oIJGtTStOjK9QlsIZJG4ec+Nu8POdPkKgw9+/6TV+2KbA3zxFgEW/utJi
 zn9kc3ndo8KjvrVy3d4JpB/Efhj14HgFIWbBafwSOKF0Kn0KUdHHELKtAUmj4YVFVfRl
 9kkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiNHCZtTbJgt8A8zsr6OhpCgaErxkrwkbd+Ssee+FJZbhHQ4qNrXAP3H5WhjTgbmc7zoscAReZqBuQ@nongnu.org
X-Gm-Message-State: AOJu0Yyb7N2IHoYOu6vCO7CfZZH0k3ZJVsGDom93WBguLtK/b6VH1rlo
 UKjeUEnbS9gs2QuJLbgv7wcxefJEVlTqq7lHjFcCkbbbn8fXwg1Q6ts+ZxwLTvXCPZ8C2E4nxfJ
 rlysuQThTwklC9duglYyGm4au5WYwIihsaWxA9cUbNr3XH5xtbmGM
X-Received: by 2002:a05:6214:468d:b0:6c5:7c82:756f with SMTP id
 6a1803df08f44-6c7bd575f90mr5768686d6.39.1726780631799; 
 Thu, 19 Sep 2024 14:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE22enLNEWhPsT+wNYv25ehk6GmMjMvDFku2PXVSotD0oiUt8yc1RUd7jQUcIq/IzAKMthwXw==
X-Received: by 2002:a05:6214:468d:b0:6c5:7c82:756f with SMTP id
 6a1803df08f44-6c7bd575f90mr5768226d6.39.1726780631276; 
 Thu, 19 Sep 2024 14:17:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e586d10sm10867686d6.141.2024.09.19.14.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 14:17:10 -0700 (PDT)
Date: Thu, 19 Sep 2024 17:17:07 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer
 support - send side
Message-ID: <ZuyU00_DHsU5xita@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n>
 <13034f56-cb92-47d3-b72e-21ef28248f2d@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13034f56-cb92-47d3-b72e-21ef28248f2d@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 09:49:43PM +0200, Maciej S. Szmigiero wrote:
> On 10.09.2024 21:48, Peter Xu wrote:
> > On Wed, Aug 28, 2024 at 09:41:17PM -0300, Fabiano Rosas wrote:
> > > > +size_t multifd_device_state_payload_size(void)
> > > > +{
> > > > +    return sizeof(MultiFDDeviceState_t);
> > > > +}
> > > 
> > > This will not be necessary because the payload size is the same as the
> > > data type. We only need it for the special case where the MultiFDPages_t
> > > is smaller than the total ram payload size.
> > 
> > Today I was thinking maybe we should really clean this up, as the current
> > multifd_send_data_alloc() is indeed too tricky (blame me.. who requested
> > that more or less).  Knowing that VFIO can use dynamic buffers with ->idstr
> > and ->buf (I was thinking it could be buf[1M].. but I was wrong...) made
> > that feeling stronger.
> > 
> > I think we should change it now perhaps, otherwise we'll need to introduce
> > other helpers to e.g. reset the device buffers, and that's not only slow
> > but also not good looking, IMO.
> > 
> > So I went ahead with the idea in previous discussion, that I managed to
> > change the SendData union into struct; the memory consumption is not super
> > important yet, IMHO, but we should still stick with the object model where
> > multifd enqueue thread switch buffer with multifd, as it still sounds a
> > sane way to do.
> > 
> > Then when that patch is ready, I further tried to make VFIO reuse multifd
> > buffers just like what we do with MultiFDPages_t->offset[]: in RAM code we
> > don't allocate it every time we enqueue.
> > 
> > I hope it'll also work for VFIO.  VFIO has a specialty on being able to
> > dump the config space so it's more complex (and I noticed Maciej's current
> > design requires the final chunk of VFIO config data be migrated in one
> > packet.. that is also part of the complexity there).  So I allowed that
> > part to allocate a buffer but only that.  IOW, I made some API (see below)
> > that can either reuse preallocated buffer, or use a separate one only for
> > the final bulk.
> > 
> > In short, could both of you have a look at what I came up with below?  I
> > did that in patches because I think it's too much to comment, so patches
> > may work better.  No concern if any of below could be good changes to you,
> > then either Maciej can squash whatever into existing patches (and I feel
> > like some existing patches in this series can go away with below design),
> > or I can post pre-requisite patch but only if any of you prefer that.
> > 
> > Anyway, let me know, the patches apply on top of this whole series applied
> > first.
> > 
> > I also wonder whether there can be any perf difference already (I tested
> > all multifd qtest with below, but no VFIO I can run), perhaps not that
> > much, but just to mention below should avoid both buffer allocations and
> > one round of copy (so VFIO read() directly writes to the multifd buffers
> > now).
> 
> I am not against making MultiFDSendData a struct and maybe introducing
> some pre-allocated buffer.
> 
> But to be honest, that manual memory management with having to remember
> to call multifd_device_state_finish() on error paths as in your
> proposed patch 3 really invites memory leaks.
> 
> Will think about some other way to have a reusable buffer.

Sure.  That's patch 3, and I suppose then it looks like patch 1 is still
OK in one way or another.

> 
> In terms of not making idstr copy (your proposed patch 2) I am not
> 100% sure that avoiding such tiny allocation really justifies the risk
> of possible use-after-free of a dangling pointer.

Why there's risk?  Someone strdup() on the stack?  That only goes via VFIO
itself, so I thought it wasn't that complicated.  But yeah as I said this
part (patch 2) is optional.

> Not 100% against it either if you are confident that it will never happen.
> 
> By the way, I guess it makes sense to carry these changes in the main patch
> set rather than as a separate changes?

Whatever you prefer.

I wrote those patches only because I thought maybe you'd like to run some
perf test to see whether they would help at all, and when the patches are
there it'll be much easier for you, then you can decide whether it's worth
intergrating already, or leave that for later.

If not I'd say they're even lower priority, so feel free to stick with
whatever easier for you.  I'm ok there.

However it'll be always good we can still have patch 1 as I mentioned
before (as part of your series, if you won't disagree), to make the
SendData interface slightly cleaner and easier to follow.

-- 
Peter Xu


