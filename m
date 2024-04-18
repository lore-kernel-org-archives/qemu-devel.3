Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A52C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 20:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXyf-0001ol-QM; Thu, 18 Apr 2024 16:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rxXyK-0001bH-Mg
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rxXyE-0005QX-MP
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 16:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713470576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53dRql9jLlaFSxsD8Ya0HxzAp18wd1HGL/9pFfJo4Eg=;
 b=J/4of3+oAPYkqYxBbhcfxcluyBn2QTqU24sPuAFMtuf/OjM+F4XI69rhMtC16V2dvT8zj0
 BrVj77FpfhDzcpTiAw+Ws9RxJJ/swzm6ChW40gAWxw2MjYVK7oafrtLGrJL84+0qY0JP8o
 ceErl0lAOK9OyX3zYl+i0a7c1c4/cv4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-ITm5A-u5Pm2fAHPgOHMkdg-1; Thu, 18 Apr 2024 16:02:54 -0400
X-MC-Unique: ITm5A-u5Pm2fAHPgOHMkdg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0587a6bd1so1912636d6.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 13:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713470574; x=1714075374;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53dRql9jLlaFSxsD8Ya0HxzAp18wd1HGL/9pFfJo4Eg=;
 b=nHl7Y83vLemLDGSBmP/kmKiXDYHJuTTMqEOWx++2I9ZOn7J/m619Wiy2AC2Ipa+9AQ
 5uwvXGWyCpfww/J011O0824MbjVCGDNtQxMy9vKJ69EHvanEMOZqzc4EmhiOZ2WIy6TZ
 /vR1jIiPyXII4jGs6H+SycVZMSPdaH4/DUX0/ZGIbTHrtLWeGCllnA4Yl4bjPjdZ9Ny0
 wTS/hvK+JPBvOfUJu/J9DkSAA4SryKMwrEg16AjH9BceE3T1ZGA4M40f7h0cvEeny4de
 38a3HoBUgxQOYFQRkgEiFQsm61bPCs3s8Av9QZIZaPYFqCA2lTwsFkNXKwURZuL5Lo42
 C+fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcF0HfJK1jSOLpttlMpIL3wBYQNYYGl0KIA08gk/Sk0Ctwa6y3c+eoc9VUn95xApLERq2b+mnyCUVU6auF05nVu+O2FnA=
X-Gm-Message-State: AOJu0YxmASvA9NAYe0LT48a5YkQiAntUjjfNuQ1+wDlzAItoyvQ7asJ3
 2kc3GXPeTKIKp5AHMSkmlCefMSRjYhc7vNO1FdW6lUlPe9mY1g0eK3KqsuRlVZRu9iWFgrgQ+WC
 WBas3blSHtmdyw/80oU3tiznQkymm/zTV8vn+m7efYCmL5Kl/lXEc
X-Received: by 2002:a05:6214:194a:b0:69b:1833:59a7 with SMTP id
 q10-20020a056214194a00b0069b183359a7mr26179qvk.6.1713470572873; 
 Thu, 18 Apr 2024 13:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRFlxfKHgOfJNmjqy9+xpj1+yTDUO/gDlNd2TeQ1KKYyNIfGRHFWzzy/Dg17tnNaJt+3A/ag==
X-Received: by 2002:a05:6214:194a:b0:69b:1833:59a7 with SMTP id
 q10-20020a056214194a00b0069b183359a7mr26136qvk.6.1713470572207; 
 Thu, 18 Apr 2024 13:02:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 w2-20020a0cb542000000b00698f01a958asm929033qvd.77.2024.04.18.13.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 13:02:51 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:02:49 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 00/26] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <ZiF8aWVfW7kPuOtn@x1n>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
 <Zh-KF72Fe9oV6tfT@redhat.com>
 <c0b1dbb1-d353-4832-af90-96895b2129fc@maciej.szmigiero.name>
 <Zh_6W8u3H4FmGS49@redhat.com>
 <71ede5c8-857c-418b-9e37-b8d343ddfa06@maciej.szmigiero.name>
 <ZiD4aLSre6qubuHr@redhat.com>
 <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebcd78e-b8b6-44db-b2be-0bbd5acccf3f@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 18, 2024 at 08:14:15PM +0200, Maciej S. Szmigiero wrote:
> On 18.04.2024 12:39, Daniel P. Berrangé wrote:
> > On Thu, Apr 18, 2024 at 11:50:12AM +0200, Maciej S. Szmigiero wrote:
> > > On 17.04.2024 18:35, Daniel P. Berrangé wrote:
> > > > On Wed, Apr 17, 2024 at 02:11:37PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 17.04.2024 10:36, Daniel P. Berrangé wrote:
> > > > > > On Tue, Apr 16, 2024 at 04:42:39PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> (..)
> > > > > > That said, the idea of reserving channels specifically for VFIO doesn't
> > > > > > make a whole lot of sense to me either.
> > > > > > 
> > > > > > Once we've done the RAM transfer, and are in the switchover phase
> > > > > > doing device state transfer, all the multifd channels are idle.
> > > > > > We should just use all those channels to transfer the device state,
> > > > > > in parallel.  Reserving channels just guarantees many idle channels
> > > > > > during RAM transfer, and further idle channels during vmstate
> > > > > > transfer.
> > > > > > 
> > > > > > IMHO it is more flexible to just use all available multifd channel
> > > > > > resources all the time.
> > > > > 
> > > > > The reason for having dedicated device state channels is that they
> > > > > provide lower downtime in my tests.
> > > > > 
> > > > > With either 15 or 11 mixed multifd channels (no dedicated device state
> > > > > channels) I get a downtime of about 1250 msec.
> > > > > 
> > > > > Comparing that with 15 total multifd channels / 4 dedicated device
> > > > > state channels that give downtime of about 1100 ms it means that using
> > > > > dedicated channels gets about 14% downtime improvement.
> > > > 
> > > > Hmm, can you clarify. /when/ is the VFIO vmstate transfer taking
> > > > place ? Is is transferred concurrently with the RAM ? I had thought
> > > > this series still has the RAM transfer iterations running first,
> > > > and then the VFIO VMstate at the end, simply making use of multifd
> > > > channels for parallelism of the end phase. your reply though makes
> > > > me question my interpretation though.
> > > > 
> > > > Let me try to illustrate channel flow in various scenarios, time
> > > > flowing left to right:
> > > > 
> > > > 1. serialized RAM, then serialized VM state  (ie historical migration)
> > > > 
> > > >         main: | Init | RAM iter 1 | RAM iter 2 | ... | RAM iter N | VM State |
> > > > 
> > > > 
> > > > 2. parallel RAM, then serialized VM state (ie today's multifd)
> > > > 
> > > >         main: | Init |                                            | VM state |
> > > >     multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > > 
> > > > 
> > > > 3. parallel RAM, then parallel VM state
> > > > 
> > > >         main: | Init |                                            | VM state |
> > > >     multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd4:                                                     | VFIO VM state |
> > > >     multifd5:                                                     | VFIO VM state |
> > > > 
> > > > 
> > > > 4. parallel RAM and VFIO VM state, then remaining VM state
> > > > 
> > > >         main: | Init |                                            | VM state |
> > > >     multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N |
> > > >     multifd4:        | VFIO VM state                                         |
> > > >     multifd5:        | VFIO VM state                                         |
> > > > 
> > > > 
> > > > I thought this series was implementing approx (3), but are you actually
> > > > implementing (4), or something else entirely ?
> > > 
> > > You are right that this series operation is approximately implementing
> > > the schema described as numer 3 in your diagrams.
> > 
> > > However, there are some additional details worth mentioning:
> > > * There's some but relatively small amount of VFIO data being
> > > transferred from the "save_live_iterate" SaveVMHandler while the VM is
> > > still running.
> > > 
> > > This is still happening via the main migration channel.
> > > Parallelizing this transfer in the future might make sense too,
> > > although obviously this doesn't impact the downtime.
> > > 
> > > * After the VM is stopped and downtime starts the main (~ 400 MiB)
> > > VFIO device state gets transferred via multifd channels.
> > > 
> > > However, these multifd channels (if they are not dedicated to device
> > > state transfer) aren't idle during that time.
> > > Rather they seem to be transferring the residual RAM data.
> > > 
> > > That's most likely what causes the additional observed downtime
> > > when dedicated device state transfer multifd channels aren't used.
> > 
> > Ahh yes, I forgot about the residual dirty RAM, that makes sense as
> > an explanation. Allow me to work through the scenarios though, as I
> > still think my suggestion to not have separate dedicate channels is
> > better....
> > 
> > 
> > Lets say hypothetically we have an existing deployment today that
> > uses 6 multifd channels for RAM. ie:
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> > 
> > That value of 6 was chosen because that corresponds to the amount
> > of network & CPU utilization the admin wants to allow, for this
> > VM to migrate. All 6 channels are fully utilized at all times.
> > 
> > 
> > If we now want to parallelize VFIO VM state, the peak network
> > and CPU utilization the admin wants to reserve for the VM should
> > not change. Thus the admin will still wants to configure only 6
> > channels total.
> > 
> > With your proposal the admin has to reduce RAM transfer to 4 of the
> > channels, in order to then reserve 2 channels for VFIO VM state, so we
> > get a flow like:
> > 
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd5:                                                     | VFIO VM state |
> >      multifd6:                                                     | VFIO VM state |
> > 
> > This is bad, as it reduces performance of RAM transfer. VFIO VM
> > state transfer is better, but that's not a net win overall.
> > 
> > 
> > 
> > So lets say the admin was happy to increase the number of multifd
> > channels from 6 to 8.
> > 
> > This series proposes that they would leave RAM using 6 channels as
> > before, and now reserve the 2 extra ones for VFIO VM state:
> > 
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM |
> >      multifd7:                                                     | VFIO VM state |
> >      multifd8:                                                     | VFIO VM state |
> > 
> > 
> > RAM would perform as well as it did historically, and VM state would
> > improve due to the 2 parallel channels, and not competing with the
> > residual RAM transfer.
> > 
> > This is what your latency comparison numbers show as a benefit for
> > this channel reservation design.
> > 
> > I believe this comparison is inappropriate / unfair though, as it is
> > comparing a situation with 6 total channels against a situation with
> > 8 total channels.
> > 
> > If the admin was happy to increase the total channels to 8, then they
> > should allow RAM to use all 8 channels, and then VFIO VM state +
> > residual RAM to also use the very same set of 8 channels:
> > 
> >          main: | Init |                                            | VM state |
> >      multifd1:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd2:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd3:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd4:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd5:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd6:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd7:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> >      multifd8:        | RAM iter 1 | RAM iter 2 | ... | RAM iter N | Residual RAM + VFIO VM state|
> > 
> > This will speed up initial RAM iters still further & the final switch
> > over phase even more. If residual RAM is larger than VFIO VM state,
> > then it will dominate the switchover latency, so having VFIO VM state
> > compete is not a problem. If VFIO VM state is larger than residual RAM,
> > then allowing it acces to all 8 channels instead of only 2 channels
> > will be a clear win.
> 
> I re-did the measurement with increased the number of multifd channels,
> first to (total count/dedicated count) 25/0, then to 100/0.
> 
> The results did not improve:
> With 25/0 multifd mixed channels config I still get around 1250 msec
> downtime - the same as with 15/0 or 11/0 mixed configs I measured
> earlier.
> 
> But with the (pretty insane) 100/0 mixed channel config the whole setup
> gets so for into the law of diminishing returns that the results actually
> get worse: the downtime is now about 1450 msec.
> I guess that's from all the extra overhead from switching between 100
> multifd channels.

100 threads are probably too much indeed.

However I agree with Dan's question raised, and I'd like to second that.
It so far looks better if the multifd channels can be managed just like a
pool of workers without assignments to specific jobs.  It looks like this
series is already getting there, it's a pity we lose that genericity only
because some other side effects on the ram sync semantics.

> 
> I think one of the reasons for these results is that mixed (RAM + device
> state) multifd channels participate in the RAM sync process
> (MULTIFD_FLAG_SYNC) whereas device state dedicated channels don't.

Firstly, I'm wondering whether we can have better names for these new
hooks.  Currently (only comment on the async* stuff):

  - complete_precopy_async
  - complete_precopy
  - complete_precopy_async_wait

But perhaps better:

  - complete_precopy_begin
  - complete_precopy
  - complete_precopy_end

?

As I don't see why the device must do something with async in such hook.
To me it's more like you're splitting one process into multiple, then
begin/end sounds more generic.

Then, if with that in mind, IIUC we can already split ram_save_complete()
into >1 phases too. For example, I would be curious whether the performance
will go back to normal if we offloading multifd_send_sync_main() into the
complete_precopy_end(), because we really only need one shot of that, and I
am quite surprised it already greatly affects VFIO dumping its own things.

I would even ask one step further as what Dan was asking: have you thought
about dumping VFIO states via multifd even during iterations?  Would that
help even more than this series (which IIUC only helps during the blackout
phase)?

It could mean that the "async*" hooks can be done differently, and I'm not
sure whether they're needed at all, e.g. when threads are created during
save_setup but cleaned up in save_cleanup.

Thanks,

> 
> It is possible that there are other subtle performance interactions too,
> but I am not 100% sure about that.
> 
> > With regards,
> > Daniel
> 
> Best regards,
> Maciej
> 

-- 
Peter Xu


