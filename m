Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2A2C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHQr-0006Hy-Fk; Tue, 09 Apr 2024 15:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruHQj-0006HR-U0
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ruHQg-00061D-Lp
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712692008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pCmpq7F25fVAdjrIlp49DOFlgKmYu5RVtNWGVwGR/9c=;
 b=eMiwJTbmvH5WhOIoIIU9+A7F1tJ2Sm5B9rrVh4OrA/oCE9uuEW6XRBfv4IKMXKDDvH3TTJ
 UWqkP4HlPgxAz+M/X5361TfIKJyUpBSQGOBamYY7dQtTizbK13V6STS7+5pkmJhj/k8IZI
 JpuXX2UoxhtngkN7lSW2CmUU15XV3k4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-vQK2WET5Mwufxi4SrOVMoA-1; Tue, 09 Apr 2024 15:46:46 -0400
X-MC-Unique: vQK2WET5Mwufxi4SrOVMoA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43470772549so13115381cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712692006; x=1713296806;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pCmpq7F25fVAdjrIlp49DOFlgKmYu5RVtNWGVwGR/9c=;
 b=ntNTRjXJIL0jiDF3pSB7g3t6FQBQ5KiGXPhJah1lc1lLm9/Am3YtaOAZ/jn8y6DurX
 PrkL3LHuDEu6wrzRwIfGeNj/oMbjbOkLImZLQ1pBNNl4XaE7p3AhYH66uKhGGw8a2N2e
 mrtyxT+thMRefTTISFkGN3YRboJ0Fpoa62bjmtEFxYTFe8R7T+q+GGBDXe/i+C1oflwG
 fjXKaZn2q42Qf1jZOxVYMDF/QW/NqcrXRWe5vKVPXqPU9KSYTDvMYRNj1NBZxmYxashl
 0IwhHbcIp/UaYDS70HnQXXLkC/klaV/HfevuhrcC9rrdLq/+STmF/iYRVuEVJwwsaYY0
 DtXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6rd3IWacJx0BXsA2YxU/DyxE0lZTl33J4wSBEAMGcJELoWMg1zeA/NZ7x8YR5ORY7cH7cC5Oqi++RjaJAtq1NQem3JWw=
X-Gm-Message-State: AOJu0YzlaR2+fnUIQp8ieD/S5aaU4D+6fqtzRzURtAur++woVqEmwbBF
 p8zAwJ/DwW6I6/viLsSO8g2ZTHKZae3oNhhX1v4psJaijh+8ag2YeK+o3Rof3n9uwURorsPBNnr
 izNOl4Mywl3/PShH4gNen/+udpVn0SKw2phqBsGe5QawiUN5uGM/k
X-Received: by 2002:a05:620a:470e:b0:78c:858b:e30a with SMTP id
 bs14-20020a05620a470e00b0078c858be30amr651414qkb.6.1712692005908; 
 Tue, 09 Apr 2024 12:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMZPtCtWpyn7x7J+KepuSRBswNHH1T05Lkpd1pLkWxB4+hVLitL4d+vAsnnZAr+aF+1jRc0w==
X-Received: by 2002:a05:620a:470e:b0:78c:858b:e30a with SMTP id
 bs14-20020a05620a470e00b0078c858be30amr651389qkb.6.1712692005141; 
 Tue, 09 Apr 2024 12:46:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 q27-20020a05620a0c9b00b0078d60595ff8sm2916374qki.59.2024.04.09.12.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:46:44 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:46:42 -0400
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
Message-ID: <ZhWa0YeAb9ySVKD1@x1n>
References: <87frwatp7n.fsf@suse.de> <ZgWGMmUTq0jqSUvr@x1n>
 <7a510fbe-1c27-4f67-93b8-0d9cf01c1c74@fujitsu.com>
 <ef160e75-d4a4-4be0-81f3-77d8b0e76178@linaro.org>
 <9d082daf-acf0-27c5-1758-5a3f2af7ee0f@fujitsu.com>
 <CAHEcVy50AtvDyCjwPa9Hu+x1wiUF6xf5McGOTHL+wdt3WN3pgA@mail.gmail.com>
 <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

On Tue, Apr 09, 2024 at 09:32:46AM +0200, Jinpu Wang wrote:
> Hi Peter,
> 
> On Mon, Apr 8, 2024 at 6:18 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Apr 08, 2024 at 04:07:20PM +0200, Jinpu Wang wrote:
> > > Hi Peter,
> >
> > Jinpu,
> >
> > Thanks for joining the discussion.
> >
> > >
> > > On Tue, Apr 2, 2024 at 11:24 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Mon, Apr 01, 2024 at 11:26:25PM +0200, Yu Zhang wrote:
> > > > > Hello Peter und Zhjian,
> > > > >
> > > > > Thank you so much for letting me know about this. I'm also a bit surprised at
> > > > > the plan for deprecating the RDMA migration subsystem.
> > > >
> > > > It's not too late, since it looks like we do have users not yet notified
> > > > from this, we'll redo the deprecation procedure even if it'll be the final
> > > > plan, and it'll be 2 releases after this.
> > > >
> > > > >
> > > > > > IMHO it's more important to know whether there are still users and whether
> > > > > > they would still like to see it around.
> > > > >
> > > > > > I admit RDMA migration was lack of testing(unit/CI test), which led to the a few
> > > > > > obvious bugs being noticed too late.
> > > > >
> > > > > Yes, we are a user of this subsystem. I was unaware of the lack of test coverage
> > > > > for this part. As soon as 8.2 was released, I saw that many of the
> > > > > migration test
> > > > > cases failed and came to realize that there might be a bug between 8.1
> > > > > and 8.2, but
> > > > > was unable to confirm and report it quickly to you.
> > > > >
> > > > > The maintenance of this part could be too costly or difficult from
> > > > > your point of view.
> > > >
> > > > It may or may not be too costly, it's just that we need real users of RDMA
> > > > taking some care of it.  Having it broken easily for >1 releases definitely
> > > > is a sign of lack of users.  It is an implication to the community that we
> > > > should consider dropping some features so that we can get the best use of
> > > > the community resources for the things that may have a broader audience.
> > > >
> > > > One thing majorly missing is a RDMA tester to guard all the merges to not
> > > > break RDMA paths, hopefully in CI.  That should not rely on RDMA hardwares
> > > > but just to sanity check the migration+rdma code running all fine.  RDMA
> > > > taught us the lesson so we're requesting CI coverage for all other new
> > > > features that will be merged at least for migration subsystem, so that we
> > > > plan to not merge anything that is not covered by CI unless extremely
> > > > necessary in the future.
> > > >
> > > > For sure CI is not the only missing part, but I'd say we should start with
> > > > it, then someone should also take care of the code even if only in
> > > > maintenance mode (no new feature to add on top).
> > > >
> > > > >
> > > > > My concern is, this plan will forces a few QEMU users (not sure how
> > > > > many) like us
> > > > > either to stick to the RDMA migration by using an increasingly older
> > > > > version of QEMU,
> > > > > or to abandon the currently used RDMA migration.
> > > >
> > > > RDMA doesn't get new features anyway, if there's specific use case for RDMA
> > > > migrations, would it work if such a scenario uses the old binary?  Is it
> > > > possible to switch to the TCP protocol with some good NICs?
> > > We have used rdma migration with HCA from Nvidia for years, our
> > > experience is RDMA migration works better than tcp (over ipoib).
> >
> > Please bare with me, as I know little on rdma stuff.
> >
> > I'm actually pretty confused (and since a long time ago..) on why we need
> > to operation with rdma contexts when ipoib seems to provide all the tcp
> > layers.  I meant, can it work with the current "tcp:" protocol with ipoib
> > even if there's rdma/ib hardwares underneath?  Is it because of performance
> > improvements so that we must use a separate path comparing to generic
> > "tcp:" protocol here?
> using rdma protocol with ib verbs , we can leverage the full benefit of RDMA by
> talking directly to NIC which bypasses the kernel overhead, less cpu
> utilization and better performance.
> 
> While IPoIB is more for compatibility to  applications using tcp, but
> can't get full benefit of RDMA.  When you have mix generation of IB
> devices, there are performance issue on IPoIB, we've seen 40G HCA can
> only reach 2 Gb/s on IPoIB, but with raw RDMA can reach full line
> speed.
> 
> I just run a simple iperf3 test via ipoib and ib_send_bw on same hosts:
> 
> iperf 3.9
> Linux ps404a-3 5.15.137-pserver #5.15.137-6~deb11 SMP Thu Jan 4
> 07:19:34 UTC 2024 x86_64
> -----------------------------------------------------------
> Server listening on 5201
> -----------------------------------------------------------
> Time: Tue, 09 Apr 2024 06:55:02 GMT
> Accepted connection from 2a02:247f:401:4:2:0:b:3, port 41130
>       Cookie: cer2hexlldrowclq6izh7gbg5toviffqbcwt
>       TCP MSS: 0 (default)
> [  5] local 2a02:247f:401:4:2:0:a:3 port 5201 connected to
> 2a02:247f:401:4:2:0:b:3 port 41136
> Starting Test: protocol: TCP, 1 streams, 131072 byte blocks, omitting
> 0 seconds, 10 second test, tos 0
> [ ID] Interval           Transfer     Bitrate
> [  5]   0.00-1.00   sec  1.80 GBytes  15.5 Gbits/sec
> [  5]   1.00-2.00   sec  1.85 GBytes  15.9 Gbits/sec
> [  5]   2.00-3.00   sec  1.88 GBytes  16.2 Gbits/sec
> [  5]   3.00-4.00   sec  1.87 GBytes  16.1 Gbits/sec
> [  5]   4.00-5.00   sec  1.88 GBytes  16.2 Gbits/sec
> [  5]   5.00-6.00   sec  1.93 GBytes  16.6 Gbits/sec
> [  5]   6.00-7.00   sec  2.00 GBytes  17.2 Gbits/sec
> [  5]   7.00-8.00   sec  1.93 GBytes  16.6 Gbits/sec
> [  5]   8.00-9.00   sec  1.86 GBytes  16.0 Gbits/sec
> [  5]   9.00-10.00  sec  1.95 GBytes  16.8 Gbits/sec
> [  5]  10.00-10.04  sec  85.2 MBytes  17.3 Gbits/sec
> - - - - - - - - - - - - - - - - - - - - - - - - -
> Test Complete. Summary Results:
> [ ID] Interval           Transfer     Bitrate
> [  5] (sender statistics not available)
> [  5]   0.00-10.04  sec  19.0 GBytes  16.3 Gbits/sec                  receiver
> rcv_tcp_congestion cubic
> iperf 3.9
> Linux ps404a-3 5.15.137-pserver #5.15.137-6~deb11 SMP Thu Jan 4
> 07:19:34 UTC 2024 x86_64
> -----------------------------------------------------------
> Server listening on 5201
> -----------------------------------------------------------
> ^Ciperf3: interrupt - the server has terminated
> 1 jwang@ps404a-3.stg:~$ sudo ib_send_bw -F -a
> 
> ************************************
> * Waiting for client to connect... *
> ************************************
> ---------------------------------------------------------------------------------------
>                     Send BW Test
>  Dual-port       : OFF Device         : mlx5_0
>  Number of qps   : 1 Transport type : IB
>  Connection type : RC Using SRQ      : OFF
>  PCIe relax order: ON
>  ibv_wr* API     : ON
>  RX depth        : 512
>  CQ Moderation   : 100
>  Mtu             : 4096[B]
>  Link type       : IB
>  Max inline data : 0[B]
>  rdma_cm QPs : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0x24 QPN 0x0174 PSN 0x300138
>  remote address: LID 0x17 QPN 0x004a PSN 0xc54d6f
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]   MsgRate[Mpps]
>  2          1000             0.00               6.46       3.385977
>  4          1000             0.00               10.38     2.721894
>  8          1000             0.00               25.69     3.367830
>  16         1000             0.00               41.46     2.716859
>  32         1000             0.00               102.98    3.374577
>  64         1000             0.00               206.12    3.377053
>  128        1000             0.00               405.03    3.318007
>  256        1000             0.00               821.52    3.364939
>  512        1000             0.00               2150.78    4.404803
>  1024       1000             0.00               4288.13    4.391044
>  2048       1000             0.00               8518.25    4.361346
>  4096       1000             0.00               11440.77    2.928836
>  8192       1000             0.00               11526.45    1.475385
>  16384      1000             0.00               11526.06    0.737668
>  32768      1000             0.00               11524.86    0.368795
>  65536      1000             0.00               11331.84    0.181309
>  131072     1000             0.00               11524.75    0.092198
>  262144     1000             0.00               11525.82    0.046103
>  524288     1000             0.00               11524.70    0.023049
>  1048576    1000             0.00               11510.84    0.011511
>  2097152    1000             0.00               11524.58    0.005762
>  4194304    1000             0.00               11514.26    0.002879
>  8388608    1000             0.00               11511.01    0.001439
> ---------------------------------------------------------------------------------------
> 
> you can see with ipoib, it reaches 16 Gb/s using TCP, 1 streams,
> 131072 byte blocks
> with RDMA at 4k+ message size it reaches 100 Gb/s

I get it now, thank you!

> 
> 
> >
> > >
> > > Switching back to TCP will lead us to the old problems which was
> > > solved by RDMA migration.
> >
> > Can you elaborate the problems, and why tcp won't work in this case?  They
> > may not be directly relevant to the issue we're discussing, but I'm happy
> > to learn more.
> >
> > What is the NICs you were testing before?  Did the test carry out with
> > things like modern ones (50Gbps-200Gbps NICs), or the test was done when
> > these hardwares are not common?
> We use Mellanox/NVidia IB HCA from 40 Gb/s to 200 Gb/s mixed
> generation across globe.
> >
> > Per my recent knowledge on the new Intel hardwares, at least the ones that
> > support QPL, it's easy to achieve single core 50Gbps+.
> In good case, I've also seen 50 Gbps + on Mellanox HCA.

I see. Have you compared the HCAs v.s. the modern NICs?  Now NICs can
achieve similar performance from their spec as I said; I am not sure how
they perform in real life, but maybe worth trying.  I only tried 100G nic
and I rem I can hit 70+Gbps with multifd migrations at peak bandwidth.
Have you tried that before?

Note that here I didn't want to compare the performance between the two and
find a winner.  The issue we're facing now is we have the RDMA migration
now mostly having its own path all over the place, while the rest protocols
(socket, fd, file, etc.) all share the rest.

Then, _if_ modern NICs can work similarly v.s. rdma, I don't yet see a good
reason to keep it.  It could be that technology just improved so we can use
less code to do as good.  It's a good news to help QEMU evolve by dropping
unused code.

For some details there on the rdma complications for migration:

  (1) RDMA is the only protocol that doesn't yet support QIOChannel, while
      migration uses QIOChannels mostly everywhere now.. e.g. in multifd,
      it means it won't easily support any new things using QIOChannels.

  (2) RDMA is the only protocol that mostly hard-coded everywhere in the
      RAM migrations, polluting the core logic with much more code
      internally to support this protocol.

For (1), see migrate_fd_connect() from rdma_start_outgoing_migration().
While the rest protocols all go via migration_channel_connect().

For (2), see all the "rdma_*" functions in migration/ram.c, where I don't
think it's common to a protocol - most of the rest protocols don't need
those hard-coded stuff.  migration/rdma.c has 4000+ LOC for these stuff,
while to do a not-so-fair comparison, migration/fd.c only has <100 LOC.

Then, we found we don't even know who's using it.

I hope I explained why people started this idea, and also why I think that
makes sense at least to me.

> >
> > https://lore.kernel.org/r/PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7PR11MB5941.namprd11.prod.outlook.com
> >
> > Quote from Yuan:
> >
> >   Yes, I use iperf3 to check the bandwidth for one core, the bandwith is 60Gbps.
> >   [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> >   [  5]   0.00-1.00   sec  7.00 GBytes  60.1 Gbits/sec    0   2.87 MBytes
> >   [  5]   1.00-2.00   sec  7.05 GBytes  60.6 Gbits/sec    0   2.87 Mbytes
> >
> >   And in the live migration test, a multifd thread's CPU utilization is almost 100%
> >
> > It boils down to what old problems were there with tcp first, though.
> Yeah, this is the key reason we use RDMA. (low cpu ulitization and
> better performance)
> >
> > >
> > > >
> > > > Per our best knowledge, RDMA users are rare, and please let anyone know if
> > > > you are aware of such users.  IIUC the major reason why RDMA stopped being
> > > > the trend is because the network is not like ten years ago; I don't think I
> > > > have good knowledge in RDMA at all nor network, but my understanding is
> > > > it's pretty easy to fetch modern NIC to outperform RDMAs, then it may make
> > > > little sense to maintain multiple protocols, considering RDMA migration
> > > > code is so special so that it has the most custom code comparing to other
> > > > protocols.
> > > +cc some guys from Huawei.
> > >
> > > I'm surprised RDMA users are rare,  I guess maybe many are just
> > > working with different code base.
> >
> > Yes, please cc whoever might be interested (or surprised.. :) to know this,
> > and let's be open to all possibilities.
> >
> > I don't think it makes sense if there're a lot of users of a feature then
> > we deprecate that without a good reason.  However there's always the
> > resource limitation issue we're facing, so it could still have the
> > possibility that this gets deprecated if nobody is working on our upstream
> > branch. Say, if people use private branches anyway to support rdma without
> > collaborating upstream, keeping such feature upstream then may not make
> > much sense either, unless there's some way to collaborate.  We'll see.
> 
> Is there document/link about the unittest/CI for migration tests, Why
> are those tests missing?
> Is it hard or very special to set up an environment for that? maybe we
> can help in this regards.

See tests/qtest/migration-test.c.  We put most of our migration tests
there and that's covered in CI.

I think one major issue is CI systems don't normally have rdma devices.
Can rdma migration test be carried out without a real hardware?

> >
> > It seems there can still be people joining this discussion.  I'll hold off
> > a bit on merging this patch to provide enough window for anyone to chim in.
> 
> Thx for discussion and understanding.

Thanks for all these inputs so far.  These can help us make a wiser and
clearer step no matter which way we choose.

-- 
Peter Xu


