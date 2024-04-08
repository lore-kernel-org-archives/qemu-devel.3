Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DC0CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtrhG-0004kB-LE; Mon, 08 Apr 2024 12:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtrhF-0004jt-2r
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rtrhC-00061C-OV
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712593089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVzYy1Ej1qn3vSwHISo7aD8KoMYZn06SwBPbNcrJsCw=;
 b=FUdXmD9p6JaYuCKQUagLcUg+W0VbQM4srK3aRihrEQ677frlglYk97LNRtxRcB9emj7zlG
 sORumAxgdtt1kVi16AHLXMj7mpxLjeBjwVT0+oDiWjjxNYwjRGjrLTbnbigEOIHtxRuoQo
 Jliyb2HVWBhNz9LaSxRYrq0slfp9RhQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-hG0Md-TmMi6-l73izK3pDg-1; Mon, 08 Apr 2024 12:18:08 -0400
X-MC-Unique: hG0Md-TmMi6-l73izK3pDg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4347df2ad8cso611321cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712593087; x=1713197887;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVzYy1Ej1qn3vSwHISo7aD8KoMYZn06SwBPbNcrJsCw=;
 b=v9YqYzVcgnL25fo/bYd8PYubd54+ZCE70//SmG3NnDb7E6wGPWXQ5sjWinK+Fhy+XI
 xRLQD8jEkgu6amwIdkW+y3cM/GY5h0YsXnHb3q+MLAwbEzyAnX86Kd280cyR2hqfbfAY
 VZL/zVddjzcjp2WldlXeSe7vl4mtDxnAlwli7d9z+MEoBifPMSPXjZRkALC+hKxwhtNe
 BNVpHKBCEp/oO851PNWSOHi1HHyCT92TMysp3PjQ7UEK3EiF4Z7TC8CTRPtlkKXIlRxK
 E3zcqtcV2e7PO/QiYqMM/cbnsbU5mi/Lamb7xTus3aRtJ+73U8Ig5CnoWPRVFFQURjpk
 mtwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ0Bm0i0dxg0K/zhoOq5XBY3I+1T0u/FhcQi0HfTlEm0UXloqNc4WhH8dsm7oQlw235PGc1St8JLWThAZGV3Ku2QDqZbw=
X-Gm-Message-State: AOJu0YxkKuZWNZTXSEzgSQwHtEbZ83Rm776AWeVsb2UniWxj7Gne1Dbb
 shMF2gAyOuxURHtuL4jx6qx54+C6aXk86CNCz0GmWbrZD+U5JFJ1BHE/hJbE9ZAm9rPtlMpWqes
 PxayJ9ys/cElcWvJRpghlTLTbTZ56I4gUW3uw16aY7EkZWNufk0iZ
X-Received: by 2002:a05:622a:1ba0:b0:434:67b8:ee7b with SMTP id
 bp32-20020a05622a1ba000b0043467b8ee7bmr9327431qtb.2.1712593086976; 
 Mon, 08 Apr 2024 09:18:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj6lGGpWfCg+gZF5+QmGNcC6mHGx7pZwQR2ANie8ptWwNUuhyp5vPUC/+M9uMuvCVtb0hwEg==
X-Received: by 2002:a05:622a:1ba0:b0:434:67b8:ee7b with SMTP id
 bp32-20020a05622a1ba000b0043467b8ee7bmr9327391qtb.2.1712593086331; 
 Mon, 08 Apr 2024 09:18:06 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 eq15-20020a05622a5e0f00b00432b5c9b9ecsm3802551qtb.14.2024.04.08.09.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 09:18:06 -0700 (PDT)
Date: Mon, 8 Apr 2024 12:18:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZhQYu3ZnsIGv2qUZ@x1n>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org> <87frwatp7n.fsf@suse.de>
 <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 08, 2024 at 04:07:20PM +0200, Jinpu Wang wrote:
> Hi Peter,

Jinpu,

Thanks for joining the discussion.

> 
> On Tue, Apr 2, 2024 at 11:24 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Apr 01, 2024 at 11:26:25PM +0200, Yu Zhang wrote:
> > > Hello Peter und Zhjian,
> > >
> > > Thank you so much for letting me know about this. I'm also a bit surprised at
> > > the plan for deprecating the RDMA migration subsystem.
> >
> > It's not too late, since it looks like we do have users not yet notified
> > from this, we'll redo the deprecation procedure even if it'll be the final
> > plan, and it'll be 2 releases after this.
> >
> > >
> > > > IMHO it's more important to know whether there are still users and whether
> > > > they would still like to see it around.
> > >
> > > > I admit RDMA migration was lack of testing(unit/CI test), which led to the a few
> > > > obvious bugs being noticed too late.
> > >
> > > Yes, we are a user of this subsystem. I was unaware of the lack of test coverage
> > > for this part. As soon as 8.2 was released, I saw that many of the
> > > migration test
> > > cases failed and came to realize that there might be a bug between 8.1
> > > and 8.2, but
> > > was unable to confirm and report it quickly to you.
> > >
> > > The maintenance of this part could be too costly or difficult from
> > > your point of view.
> >
> > It may or may not be too costly, it's just that we need real users of RDMA
> > taking some care of it.  Having it broken easily for >1 releases definitely
> > is a sign of lack of users.  It is an implication to the community that we
> > should consider dropping some features so that we can get the best use of
> > the community resources for the things that may have a broader audience.
> >
> > One thing majorly missing is a RDMA tester to guard all the merges to not
> > break RDMA paths, hopefully in CI.  That should not rely on RDMA hardwares
> > but just to sanity check the migration+rdma code running all fine.  RDMA
> > taught us the lesson so we're requesting CI coverage for all other new
> > features that will be merged at least for migration subsystem, so that we
> > plan to not merge anything that is not covered by CI unless extremely
> > necessary in the future.
> >
> > For sure CI is not the only missing part, but I'd say we should start with
> > it, then someone should also take care of the code even if only in
> > maintenance mode (no new feature to add on top).
> >
> > >
> > > My concern is, this plan will forces a few QEMU users (not sure how
> > > many) like us
> > > either to stick to the RDMA migration by using an increasingly older
> > > version of QEMU,
> > > or to abandon the currently used RDMA migration.
> >
> > RDMA doesn't get new features anyway, if there's specific use case for RDMA
> > migrations, would it work if such a scenario uses the old binary?  Is it
> > possible to switch to the TCP protocol with some good NICs?
> We have used rdma migration with HCA from Nvidia for years, our
> experience is RDMA migration works better than tcp (over ipoib).

Please bare with me, as I know little on rdma stuff.

I'm actually pretty confused (and since a long time ago..) on why we need
to operation with rdma contexts when ipoib seems to provide all the tcp
layers.  I meant, can it work with the current "tcp:" protocol with ipoib
even if there's rdma/ib hardwares underneath?  Is it because of performance
improvements so that we must use a separate path comparing to generic
"tcp:" protocol here?

> 
> Switching back to TCP will lead us to the old problems which was
> solved by RDMA migration.

Can you elaborate the problems, and why tcp won't work in this case?  They
may not be directly relevant to the issue we're discussing, but I'm happy
to learn more.

What is the NICs you were testing before?  Did the test carry out with
things like modern ones (50Gbps-200Gbps NICs), or the test was done when
these hardwares are not common?

Per my recent knowledge on the new Intel hardwares, at least the ones that
support QPL, it's easy to achieve single core 50Gbps+.

https://lore.kernel.org/r/PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7PR11MB5941.namprd11.prod.outlook.com

Quote from Yuan:

  Yes, I use iperf3 to check the bandwidth for one core, the bandwith is 60Gbps.
  [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
  [  5]   0.00-1.00   sec  7.00 GBytes  60.1 Gbits/sec    0   2.87 MBytes
  [  5]   1.00-2.00   sec  7.05 GBytes  60.6 Gbits/sec    0   2.87 Mbytes

  And in the live migration test, a multifd thread's CPU utilization is almost 100%

It boils down to what old problems were there with tcp first, though.

> 
> >
> > Per our best knowledge, RDMA users are rare, and please let anyone know if
> > you are aware of such users.  IIUC the major reason why RDMA stopped being
> > the trend is because the network is not like ten years ago; I don't think I
> > have good knowledge in RDMA at all nor network, but my understanding is
> > it's pretty easy to fetch modern NIC to outperform RDMAs, then it may make
> > little sense to maintain multiple protocols, considering RDMA migration
> > code is so special so that it has the most custom code comparing to other
> > protocols.
> +cc some guys from Huawei.
> 
> I'm surprised RDMA users are rare,  I guess maybe many are just
> working with different code base.

Yes, please cc whoever might be interested (or surprised.. :) to know this,
and let's be open to all possibilities.

I don't think it makes sense if there're a lot of users of a feature then
we deprecate that without a good reason.  However there's always the
resource limitation issue we're facing, so it could still have the
possibility that this gets deprecated if nobody is working on our upstream
branch. Say, if people use private branches anyway to support rdma without
collaborating upstream, keeping such feature upstream then may not make
much sense either, unless there's some way to collaborate.  We'll see.

It seems there can still be people joining this discussion.  I'll hold off
a bit on merging this patch to provide enough window for anyone to chim in.

Thanks,

> >
> > Thanks,
> >
> > --
> > Peter Xu
> 
> Thx!
> Jinpu Wang
> >
> 

-- 
Peter Xu


