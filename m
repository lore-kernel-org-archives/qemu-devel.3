Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11512C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpZEG-000729-Ig; Wed, 27 Mar 2024 15:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpZED-00071w-9i
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpZEB-0008O6-1l
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 15:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711568785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0YC45G3dVdDlidydYa17eDZBYrA96CqDEsVmnCgz6js=;
 b=B2aHaNlgif8/3wpDabJQzjTRY6Vn83qR0IujuElpTKcuwjUWap5qkbT6BHtooKN22eqQJN
 F+K1o55imzLBKvg9k2DZV7gs2gej7HOU0/FHJn4VBi7o3loY9QLJgRNG9zvRX0y3NN1AFP
 Ru2kmMA0z7UMxIu9QdYS60RvusyWHQs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-rjHdBVwHPP6HCijd8WqumQ-1; Wed, 27 Mar 2024 15:46:23 -0400
X-MC-Unique: rjHdBVwHPP6HCijd8WqumQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7830635331bso2233885a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 12:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711568783; x=1712173583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YC45G3dVdDlidydYa17eDZBYrA96CqDEsVmnCgz6js=;
 b=FLTJb7t5da2DylEj94naHcUuoXd7OEO4eCbMpqdy7i4ohQJ2nWKjIGqRCxY/M0bzPW
 6MO3UL4VHVt/ERin9Nqs5drk4D3h3OrAVpK26u/zWWx34oFqIJDe3bbIoglufBKYN/KA
 Q2yvqzoS5nJGf9G0OG/zwIoZtG7wTIVqbvdvLBOilBGwCyQpvXuN/5DLYYz2N6Xq4Ivr
 OxdUwWCGmj1HVwxPh7QrgqeStiebhU9NRtwkvpqV3jqslgQXTSgnzt/KUmajEavZL3l7
 ozj/l7V9WVANqb74NFnk+yftZ8DNA9gL+bCNBiN0mRGeWuezVWIOMxfrYdNpIyiTdvdo
 9gcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1rgy8/x4QdqWA6YTimKL4ncl67tmvA+UAtJ508+c3NyZR0oWH03TD6nFxsoFUOvqvoEV9l0bZ5FBS0JEOd/64Y1TPBlA=
X-Gm-Message-State: AOJu0YzWiPzWc56NP3J9mJQvRtGGQIj4tRBCCcUmc4zHth7S4naoQwtb
 sscy/ypSfS5vthD6Wt6W4xFf5HDm02RkTo9VVEIoiWNzbqn38XqboR47ghOiajpZAD6jA3SeDni
 ialS7ocf6MJffq9+aFol9ro8FXM4fhIMDv6W+S3VsyqmFC99BZ2gY
X-Received: by 2002:a37:de02:0:b0:789:f0c5:9c77 with SMTP id
 h2-20020a37de02000000b00789f0c59c77mr442181qkj.6.1711568782650; 
 Wed, 27 Mar 2024 12:46:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg/wn04fBWSx8WTGEgys1pcMh8UDgb+wDsGN6PbzGx83JJBj4u2QUQSuRC1I8lLgF9mXew+g==
X-Received: by 2002:a37:de02:0:b0:789:f0c5:9c77 with SMTP id
 h2-20020a37de02000000b00789f0c59c77mr442165qkj.6.1711568782073; 
 Wed, 27 Mar 2024 12:46:22 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z24-20020ae9c118000000b0078a581bc66bsm2695207qki.17.2024.03.27.12.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 12:46:21 -0700 (PDT)
Date: Wed, 27 Mar 2024 15:46:19 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH v5 0/7] Live Migration With IAA
Message-ID: <ZgR3i5-jc3n2eQA_@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <ZgMwSO_eRIgXZ24L@x1n>
 <PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Mar 27, 2024 at 03:20:19AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, March 27, 2024 4:30 AM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: farosas@suse.de; qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> > bryan.zhang@bytedance.com; Zou, Nanhai <nanhai.zou@intel.com>
> > Subject: Re: [PATCH v5 0/7] Live Migration With IAA
> > 
> > Hi, Yuan,
> > 
> > On Wed, Mar 20, 2024 at 12:45:20AM +0800, Yuan Liu wrote:
> > > 1. QPL will be used as an independent compression method like ZLIB and
> > ZSTD,
> > >    QPL will force the use of the IAA accelerator and will not support
> > software
> > >    compression. For a summary of issues compatible with Zlib, please
> > refer to
> > >    docs/devel/migration/qpl-compression.rst
> > 
> > IIRC our previous discussion is we should provide a software fallback for
> > the new QEMU paths, right?  Why the decision changed?  Again, such
> > fallback
> > can help us to make sure qpl won't get broken easily by other changes.
> 
> Hi Peter
> 
> Previous your suggestion below
> 
> https://patchew.org/QEMU/PH7PR11MB5941019462E0ADDE231C7295A37C2@PH7PR11MB5941.namprd11.prod.outlook.com/
> Compression methods: none, zlib, zstd, qpl (describes all the algorithms
> that might be used; again, qpl enforces HW support).
> Compression accelerators: auto, none, qat (only applies when zlib/zstd
> chosen above)
> 
> Maybe I misunderstood here, what you mean is that if the IAA hardware is unavailable, 
> it will fall back to the software path. This does not need to be specified through live
> migration parameters, and it will automatically determine whether to use the software or
> hardware path during QPL initialization, is that right?

I think there are two questions.

Firstly, we definitely want the qpl compressor to be able to run without
any hardware support.  As I mentioned above, I think that's the only way
that qpl code can always get covered by the CI as CI hosts should normally
don't have those modern hardwares.

I think it also means in the last test patch, instead of detecting /dev/iax
we should unconditionally run the qpl test as long as compiled in, because
it should just fallback to the software path then when HW not valid?

The second question is whether we'll want a new "compression accelerator",
fundamentally the only use case of that is to enforce software fallback
even if hardware existed.  I don't remember whether others have any opinion
before, but to me I think it's good to have, however no strong opinion.
It's less important comparing to the other question on CI coverage.

> 
> > > 2. Compression accelerator related patches are removed from this patch
> > set and
> > >    will be added to the QAT patch set, we will submit separate patches
> > to use
> > >    QAT to accelerate ZLIB and ZSTD.
> > >
> > > 3. Advantages of using IAA accelerator include:
> > >    a. Compared with the non-compression method, it can improve downtime
> > >       performance without adding additional host resources (both CPU and
> > >       network).
> > >    b. Compared with using software compression methods (ZSTD/ZLIB), it
> > can
> > >       provide high data compression ratio and save a lot of CPU
> > resources
> > >       used for compression.
> > >
> > > Test condition:
> > >   1. Host CPUs are based on Sapphire Rapids
> > >   2. VM type, 16 vCPU and 64G memory
> > >   3. The source and destination respectively use 4 IAA devices.
> > >   4. The workload in the VM
> > >     a. all vCPUs are idle state
> > >     b. 90% of the virtual machine's memory is used, use silesia to fill
> > >        the memory.
> > >        The introduction of silesia:
> > >        https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia
> > >   5. Set "--mem-prealloc" boot parameter on the destination, this
> > parameter
> > >      can make IAA performance better and related introduction is added
> > here.
> > >      docs/devel/migration/qpl-compression.rst
> > >   6. Source migration configuration commands
> > >      a. migrate_set_capability multifd on
> > >      b. migrate_set_parameter multifd-channels 2/4/8
> > >      c. migrate_set_parameter downtime-limit 300
> > >      f. migrate_set_parameter max-bandwidth 100G/1G
> > >      d. migrate_set_parameter multifd-compression none/qpl/zstd
> > >   7. Destination migration configuration commands
> > >      a. migrate_set_capability multifd on
> > >      b. migrate_set_parameter multifd-channels 2/4/8
> > >      c. migrate_set_parameter multifd-compression none/qpl/zstd
> > >
> > > Early migration result, each result is the average of three tests
> > >
> > >  +--------+-------------+--------+--------+---------+----------+------|
> > >  |        | The number  |total   |downtime|network  |pages per | CPU  |
> > >  | None   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
> > >  | Comp   |             |        |        |(mbps)   |          |      |
> > >  |        +-------------+-----------------+---------+----------+------+
> > >  |Network |            2|    8571|      69|    58391|   1896525|  256%|
> > 
> > Is this the average bandwidth?  I'm surprised that you can hit ~59Gbps
> > only
> > with 2 channels.  My previous experience is around ~1XGbps per channel, so
> > no more than 30Gbps for two channels.  Is it because of a faster
> > processor?
> > Indeed from the 4/8 results it doesn't look like increasing the num of
> > channels helped a lot, and even it got worse on the downtime.
> 
> Yes, I use iperf3 to check the bandwidth for one core, the bandwith is 60Gbps.
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  7.00 GBytes  60.1 Gbits/sec    0   2.87 MBytes
> [  5]   1.00-2.00   sec  7.05 GBytes  60.6 Gbits/sec    0   2.87 Mbytes
> 
> And in the live migration test, a multifd thread's CPU utilization is almost 100%

This 60Gpbs per-channel is definitely impressive..

Have you tried migration without multifd on your system? Would that also
perform similarly v.s. 2 channels multifd?

The whole point of multifd is to scale on bandwidth.  If single thread can
already achieve 60Gbps (where in my previous memory of tests, multifd can
only reach ~70Gbps before..), then either multifd will be less useful with
the new hardwares (especially when with a most generic socket nocomp
setup), or we need to start working on bottlenecks of multifd to make it
scale better.  Otherwise multifd will become a pool for compressor loads
only.

> 
> > What is the rational behind "downtime improvement" when with the QPL
> > compressors?  IIUC in this 100Gbps case the bandwidth is never a
> > limitation, then I don't understand why adding the compression phase can
> > make the switchover faster.  I can expect much more pages sent in a
> > NIC-limted env like you described below with 1Gbps, but not when NIC has
> > unlimited resources like here.
> 
> The compression can improve the network stack overhead(not improve the RDMA 
> solution), the less data, the smaller the overhead in the 
> network protocol stack. If compression has no overhead, and network bandwidth
> is not limited, the last memory copy is faster with compression
> 
> The migration hotspot focuses on the _sys_sendmsg
> _sys_sendmsg
>   |- tcp_sendmsg
>     |- copy_user_enhanced_fast_string
>     |- tcp_push_one

Makes sense.  I assume that's logical indeed when the compression ratio is
high enough, meanwhile if the compression work is fast enough to be much
lower than sending extra data when without it.

Thanks,

-- 
Peter Xu


