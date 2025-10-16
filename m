Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E690CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Sui-0000eR-R7; Thu, 16 Oct 2025 14:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9Suh-0000ci-6f
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9SuX-0001eq-PH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760640063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRMvn+ABZ9bFjaIYXbewsW5Pzi87xtPeJm5LoeCuXtQ=;
 b=AyJpQ9mFhK3So50Fl0Uvf0Wcw89DwLb2b9FlsPCXVZVZg5GWST6vXkxAwE1Qt0iZP+vUgc
 ff7zQ0lmOyk/vjRbGGaH4HmbSJCeZWgUTAQN2XALJ9cmAAGITGgOUn2a+YmOGeWx1YdaTH
 DvASOWjA3hZJoSqwMgiaoRGcJQOxjWk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-1L6_Eaj5OxStlaQfhuQlCQ-1; Thu, 16 Oct 2025 14:41:02 -0400
X-MC-Unique: 1L6_Eaj5OxStlaQfhuQlCQ-1
X-Mimecast-MFC-AGG-ID: 1L6_Eaj5OxStlaQfhuQlCQ_1760640062
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8544316ef6aso590801385a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 11:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760640062; x=1761244862;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bRMvn+ABZ9bFjaIYXbewsW5Pzi87xtPeJm5LoeCuXtQ=;
 b=eiS4nVWYAPBkzjej18iP+oiljDbzA6SW9WjnX0Di7yPzNDKmX5VzZ75/ZcKNZySW8x
 gHttA9jgtfZX3PKgNsOC6r2iizu6rWjvKU2AJsdZmUlTrnaaQ3EH2LLC4dpENKM2DYv3
 bAOX4jqlH4nxOeznv4QxoWAOldvcIBlX15iaEDPxE4XyGHetAjEJNb8hGnTkMquMqjBY
 CzouciUgRL3dzCWGFDtJQ9kteZbbD0YySx0cGVb/IogTNgF7m2fYnwZeqXKv04Fm5wAa
 WxZ8+Up4D3MJN+aUY5FSCLgAZUTR+WvFInZ6OLITVEObx1Fms6JndnXlq5Q6MjuEzwRu
 1Tkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGoR8i56Ih6WRH9UCgsdPNVjS67IMdTVcxMPNKsbMNh1NgOeZIm4/xDcaVRZo9Ds6nsb5tgXuVMqD3@nongnu.org
X-Gm-Message-State: AOJu0YxYrz4x8/Q6o5RNgHl79NW4fetX8xBka/mpBGHbR9JD/5nFy3pA
 V5560UbUAovXDV9z7ksisBtK1IssbPiy8cWQ5AwOFC6jpI6DCkbmKxuL0nf6bIumU7JV6g9ok4d
 fIPZh/HtiNzPPkKulZxv8Qf1PpfgVLLuGSuVcgF5ibFX/o8oDojK7vaT7
X-Gm-Gg: ASbGncu7dcthwYLiHJ4iNUzNl9+nt8J/ArT01V4fpnxgYw5FK7Fmf9tJWCEmfd3cBqq
 9Qw34KSElSuVAKOTq6L3iWlsbSK4i6Vp1x2Qu8/+QRyNmIzB7IvCF9PZ3ECzRQOLoMPbZlvL/KO
 FJWSdCVf9T0EgslGwqEfQ9aTPhKXRR9cxayo3U93lX7BVIWW6+TkUz4ALzdN7I4R/eHpIq6QVuI
 KP5+ze/G+7l5fAqlNsgPN5kx80qsKH7THMYi51RJOYHphd+5HseRLybXptkJ7OZ5+hq3iVErkDk
 viH8BpvaNexnb3nQnc38uVbMF5rZe6kQwypmzTsH08Fu7v7n0Ug87o8RJdQcqQnfhmo=
X-Received: by 2002:a05:620a:489b:b0:852:9e8:4a02 with SMTP id
 af79cd13be357-8906e6b7435mr164429785a.19.1760640061698; 
 Thu, 16 Oct 2025 11:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7AkGZkiwa7XlmyNSrRPuJs1/vyvncJ1sYa3tua97ghmiFixV6YbW8/dXvr47rUeqKRg2Ug==
X-Received: by 2002:a05:620a:489b:b0:852:9e8:4a02 with SMTP id
 af79cd13be357-8906e6b7435mr164424785a.19.1760640061258; 
 Thu, 16 Oct 2025 11:41:01 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f37e4b953sm254672185a.29.2025.10.16.11.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 11:41:00 -0700 (PDT)
Date: Thu, 16 Oct 2025 14:40:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPE8Oo5D3oesB7sV@x1.local>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
 <20251015132136.1083972-17-vsementsov@yandex-team.ru>
 <aO_ll4Lf0bq6vgdm@x1.local>
 <3b9f1da4-6264-45d4-ade1-a6273cc6fa1e@yandex-team.ru>
 <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 12:23:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 16.10.25 11:32, Daniel P. Berrangé wrote:
> > On Thu, Oct 16, 2025 at 12:02:45AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 15.10.25 23:07, Peter Xu wrote:
> > > > On Wed, Oct 15, 2025 at 10:02:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > On 15.10.25 21:19, Peter Xu wrote:
> > > > > > On Wed, Oct 15, 2025 at 04:21:32PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > This parameter enables backend-transfer feature: all devices
> > > > > > > which support it will migrate their backends (for example a TAP
> > > > > > > device, by passing open file descriptor to migration channel).
> > > > > > > 
> > > > > > > Currently no such devices, so the new parameter is a noop.
> > > > > > > 
> > > > > > > Next commit will add support for virtio-net, to migrate its
> > > > > > > TAP backend.
> > > > > > > 
> > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > > > ---
> > > > > 
> > > > > [..]
> > > > > 
> > > > > > > --- a/qapi/migration.json
> > > > > > > +++ b/qapi/migration.json
> > > > > > > @@ -951,9 +951,16 @@
> > > > > > >     #     is @cpr-exec.  The first list element is the program's filename,
> > > > > > >     #     the remainder its arguments.  (Since 10.2)
> > > > > > >     #
> > > > > > > +# @backend-transfer: Enable backend-transfer feature for devices that
> > > > > > > +#     supports it. In general that means that backend state and its
> > > > > > > +#     file descriptors are passed to the destination in the migraton
> > > > > > > +#     channel (which must be a UNIX socket). Individual devices
> > > > > > > +#     declare the support for backend-transfer by per-device
> > > > > > > +#     backend-transfer option. (Since 10.2)
> > > > > > 
> > > > > > Thanks.
> > > > > > 
> > > > > > I still prefer the name "fd-passing" or anything more explicit than
> > > > > > "backend-transfer". Maybe the current name is fine for TAP, only because
> > > > > > TAP doesn't have its own VMSD to transfer?
> > > > > > 
> > > > > > Consider a device that would be a backend that supports VMSDs already to be
> > > > > > migrated, then if it starts to allow fd-passing, this name will stop being
> > > > > > suitable there, because it used to "transfer backend" already, now it's
> > > > > > just started to "fd-passing".
> > > > > > 
> > > > > > Meanwhile, consider another example - what if a device is not a backend at
> > > > > > all (e.g. vfio?), has its own VMSD, then want to do fd-passing?
> > > > > 
> > > > > Reasonable.
> > > > > 
> > > > > But consider also the discussion with Fabiano in v5, where he argues against fds
> > > > > (reasonable too):
> > > > > 
> > > > > https://lore.kernel.org/qemu-devel/87y0qatqoa.fsf@suse.de/
> > > > > 
> > > > > (still, they were against my "fds" name for the parameter, which is
> > > > > really too generic, fd-passing is not)
> > > > > 
> > > > > and the arguments for backend-transfer (to read similar with cpr-transfer)
> > > > > 
> > > > > https://lore.kernel.org/qemu-devel/87ms6qtlgf.fsf@suse.de/
> > > > > 
> > > > > 
> > > > > > 
> > > > > > In general, I think "fd" is really a core concept of this whole thing.
> > > > > 
> > > > > I think, we can call "backend" any external object, linked by the fd.
> > > > > 
> > > > > Still, backend/frontend terminology is so misleading, when applied to
> > > > > complex systems (for me, at least), that I don't really like "-backend"
> > > > > word here.
> > > > > 
> > > > > fd-passing is OK for me, I can resend with it, if arguments by Fabiano
> > > > > not change your mind.
> > > > 
> > > > Ah, I didn't notice the name has been discussed.
> > > > 
> > > > I think it means you can vote for your own preference now because we have
> > > > one vote for each. :) Let's also see whether Fabiano will come up with
> > > > something better than both.
> > > > 
> > > > You mentioned explicitly the file descriptors in the qapi doc, that's what
> > > > I would strongly request for.  The other thing is the unix socket check, it
> > > > looks all good below now with it, thanks.  No strong feelings on the names.
> > > > 
> > > 
> > > After a bit more thinking, I leaning towards keeping backend-transfer. I think
> > > it's more meaningful for the user:
> > > 
> > > If we call it "fd-passing", user may ask:
> > > 
> > > Ok, what is it? Allow QEMU to pass some fds through migration stream, if it
> > > supports fds? Which fds? Why to pass them? Finally, why QEMU can't just check
> > > is it unix socket or not, and pass any fds it wants if it is?
> > > 
> > > Logical question is, why not just drop the global capability, and check only
> > > is it unix socket or not? (OK, relying only on socket type is wrong anyway,
> > > as it may be some complex tunneling, which includes unix sockets, but still
> > > can't pass fds, but I think now about feature naming)
> > > 
> > > But we really want an explicit switch for the feature. As qemu-update is
> > > not the only case of local migration. The another case is changing the
> > > backend. So for the user's choice is:
> > > 
> > > 1. Remote migration: we can't reuse backends (files, sockets, host devices), as
> > > we are moving to another host. So, we don't enable "backend-transfer". We don't
> > > transfer the backend, we have to initialize new backend on another host.
> > > 
> > > 2. Local migration to update QEMU, with minimal freeze-time and minimal
> > > extra actions: use "backend-transfer", exactly to keep the backends
> > > (vhost-user-server, TAP device in kernel, in-kernel vfio device state, etc)
> > > as is.
> > > 
> > > 3. Local migration, but we want to reconfigure some backend, or switch
> > > to another backend. We disable "backend-transfer" for one device.
> > 
> > This implies that you're changing 'backend-transfer' against the
> > device at time of each migration.
> > 
> > This takes us back to the situation we've had historically where the
> > behaviour of migration depends on global properties the mgmt app has
> > set prior to the 'migrate' command being run. We've just tried to get
> > away from that model by passing everything as parameters to the
> > migrate command, so I'm loathe to see us invent a new way to have
> > global state properties changing migration behaviour.
> > 
> > This 'backend-transfer' device property is not really a device property,
> > it is an indirect parameter to the 'migrate' command.

I was not seeing it like that.

I was treating per-device parameter to be a flag showing whether the device
is capable of passing over FDs, which is more like a device attribute.

Those things (after set by machine type) should never change, and the only
thing to be changed is the global "backend-transfer" boolean that can be
set in the "migrate" QMP command, and should be decided by the admin when
one wants to initiate the migration process.

> > 
> > Ergo, if we need the ability to selectively migrate the backend state
> > of individal devices, then instead of a property on the device, we
> > should pass a list of device IDs as a parameter to the migrate
> > command in QMP.

I doubt whether we would really need that in reality.

Likely the admin should only worry about whether setting the global
"backend-transfer", the admin may not even need to know which device, and
how many devices, will be beneficial to this feature enabled.

It just says, "we're doing local migration and via unix sockets, so
whatever devices can try to reuse their backends if possible".

Thanks,

-- 
Peter Xu


