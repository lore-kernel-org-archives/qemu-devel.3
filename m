Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E297EC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCEZ-0004JB-RV; Wed, 17 Jul 2024 17:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUCEX-0004I7-Tn
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:30:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUCEV-0007CT-IP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721251841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4imxbUPJTwmCMkqcExUL6xaebJCXGn7gY+b3MVnqO4c=;
 b=ZoGiB/H+FRLScpXEhA+qc0yjHa7sPv35+xZsUNhhpkEsNT7Xgx5nYYz5vUCbkGZT4mXlL6
 fqEAK11gKBq+r8a0Xal0aWuvspS0H+549hDamrXwZKEDxkp+rFx0yedEc5n/wk8B901hVQ
 sfo6ErK4q5qa4kWVbfbYMx1k5Q+dN0I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-3t9p9IxrNqW5mrNaMrqMww-1; Wed, 17 Jul 2024 17:30:39 -0400
X-MC-Unique: 3t9p9IxrNqW5mrNaMrqMww-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b7973ab9cbso350746d6.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721251839; x=1721856639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4imxbUPJTwmCMkqcExUL6xaebJCXGn7gY+b3MVnqO4c=;
 b=FzYFIIMsXiEOYecCHIBNK1jHCe/0K+5i5G6Lb1IMZxE1+OaDbhlMlRzjcZTeZ4lrMK
 hhiDwLzv31Ipnbt/KdSXhJXQsKZAIMYhrm9M5dGCc7h/27rNaoYKq6oXivFH45c+fDC9
 UXvqne3zi4YUho2MFeTWYTiDWHw33Mln6pQzvG/mdNgafHUCz2gKOihT33wFiNJVkUUF
 IUWWVq9QnuEFVs8Dtf3SWPGBmPP/GN2px083QakurfuW2QxkNsVb84c2qRgyuWg2GNMx
 kqwKGnkYNozNkA5MoyTni2R0LtyQ+YqRBMsiunkI4iIQu4cDznR5PMEahW/tTWdalkqi
 Nzaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCdIoccqZm7m14QeEtl7hl5/OgTOnaBA71pe4ZYGa62UwB2LodOyqAmJxBLGErG430s8+iDeq7U+Iwj4r8hbFVz2avvDg=
X-Gm-Message-State: AOJu0Yz9ZWjlRvFnMvDcWraG/JfKE7ZWQKtetMoFR/laH+psHwnpxzcv
 KFpFjKny25BSfj8OWF4BqjQ6rWPcsa0sYB33JlaBeGN2HPfkJiIaaJyWz5AjvpG96+Iepu7yVam
 n7Jx7YqPV+fGXQX1SD4ZkxFa37UnZCD2o2F05LP1YOR1qjiEecx/8
X-Received: by 2002:ac8:7fd3:0:b0:446:5b0a:e778 with SMTP id
 d75a77b69052e-44f8603e286mr20693421cf.0.1721251838761; 
 Wed, 17 Jul 2024 14:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhe7LXTvgqTxC82c4W69Rp60NYco2fj41aIziE28I/h2bPAjwztcac70QHsNWFbXHg8yfX/g==
X-Received: by 2002:ac8:7fd3:0:b0:446:5b0a:e778 with SMTP id
 d75a77b69052e-44f8603e286mr20693261cf.0.1721251838241; 
 Wed, 17 Jul 2024 14:30:38 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7f8f02sm52545091cf.52.2024.07.17.14.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 14:30:37 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:30:35 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, "Wang, Lei" <lei4.wang@intel.com>,
 qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <Zpg3-6ywAzSlcg69@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <53d0ddf0-07f7-430e-a424-b4fcc38a16d0@maciej.szmigiero.name>
 <ZpgUvsiCB4oP3RLT@x1n>
 <9fd06f90-2957-4a4b-b652-c5f768bca4cb@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fd06f90-2957-4a4b-b652-c5f768bca4cb@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 11:07:17PM +0200, Maciej S. Szmigiero wrote:
> On 17.07.2024 21:00, Peter Xu wrote:
> > On Tue, Jul 16, 2024 at 10:10:25PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > The comment I removed is slightly misleading to me too, because right now
> > > > > > > active_slot contains the data hasn't yet been delivered to multifd, so
> > > > > > > we're "putting it back to free list" not because of it's free, but because
> > > > > > > we know it won't get used until the multifd send thread consumes it
> > > > > > > (because before that the thread will be busy, and we won't use the buffer
> > > > > > > if so in upcoming send()s).
> > > > > > > 
> > > > > > > And then when I'm looking at this again, I think maybe it's a slight
> > > > > > > overkill, and maybe we can still keep the "opaque data" managed by multifd.
> > > > > > > One reason might be that I don't expect the "opaque data" payload keep
> > > > > > > growing at all: it should really be either RAM or device state as I
> > > > > > > commented elsewhere in a relevant thread, after all it's a thread model
> > > > > > > only for migration purpose to move vmstates..
> > > > > > 
> > > > > > Some amount of flexibility needs to be baked in. For instance, what
> > > > > > about the handshake procedure? Don't we want to use multifd threads to
> > > > > > put some information on the wire for that as well?
> > > > > 
> > > > > Is this an orthogonal question?
> > > > 
> > > > I don't think so. You say the payload data should be either RAM or
> > > > device state. I'm asking what other types of data do we want the multifd
> > > > channel to transmit and suggesting we need to allow room for the
> > > > addition of that, whatever it is. One thing that comes to mind that is
> > > > neither RAM or device state is some form of handshake or capabilities
> > > > negotiation.
> > > 
> > > The RFC version of my multifd device state transfer patch set introduced
> > > a new migration channel header (by Avihai) for clean and extensible
> > > migration channel handshaking but people didn't like so it was removed in v1.
> > 
> > Hmm, I'm not sure this is relevant to the context of discussion here, but I
> > confess I didn't notice the per-channel header thing in the previous RFC
> > series.  Link is here:
> > 
> > https://lore.kernel.org/r/636cec92eb801f13ba893de79d4872f5d8342097.1713269378.git.maciej.szmigiero@oracle.com
> 
> The channel header patches were dropped because Daniel didn't like them:
> https://lore.kernel.org/qemu-devel/Zh-KF72Fe9oV6tfT@redhat.com/
> https://lore.kernel.org/qemu-devel/Zh_6W8u3H4FmGS49@redhat.com/

Ah I missed that too when I quickly went over the old series, sorry.

I think what Dan meant was that we'd better do that with the handshake
work, which should cover more than this.  I've no problem with that.

It's just that sooner or later, we should provide something more solid than
commit 6720c2b327 ("migration: check magic value for deciding the mapping
of channels").

> 
> > Maciej, if you want, you can split that out of the seriess. So far it looks
> > like a good thing with/without how VFIO tackles it.
> 
> Unfortunately, these Avihai's channel header patches obviously impact wire
> protocol and are a bit of intermingled with the rest of the device state
> transfer patch set so it would be good to know upfront whether there is
> some consensus to (re)introduce this new channel header (CCed Daniel, too).

When I mentioned posting it separately, it'll still not be relevant to the
VFIO series. IOW, I think below is definitely not needed (and I think we're
on the same page now to reuse multifd threads as generic channels, so
there's no issue now):

https://lore.kernel.org/qemu-devel/027695db92ace07d2d6ee66da05f8e85959fd46a.1713269378.git.maciej.szmigiero@oracle.com/

So I assume we should leave that for later for whoever refactors the
handshake process.

Thanks,

-- 
Peter Xu


