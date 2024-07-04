Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09760C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOVk-00008S-Q0; Thu, 04 Jul 2024 11:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sPOVi-00007u-UZ
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sPOVc-00081a-Do
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720107391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gydR/+b6UB4IoUeer5ZxX1AbfwQXc51JpObMk+z/9eY=;
 b=A7KEXzSLbYQR21umeVuDZA+x1EIxwCeyV2OBlZ+Kk7OLKr3xbRa/So3QfJDKvgXZyx1jsD
 loGm516w6dKea8BGT7DVPquaZzxWcYq1Yoxbzo0ySpblpCnyCTvZxmgPykILMZM1O26/Pk
 fNxcP1HqMqYsJf/vSzT009d0oGUFe+A=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-JWW0lgN4PdqYttXf9l-uzA-1; Thu, 04 Jul 2024 11:36:30 -0400
X-MC-Unique: JWW0lgN4PdqYttXf9l-uzA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5c22476c887so139847eaf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720107389; x=1720712189;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gydR/+b6UB4IoUeer5ZxX1AbfwQXc51JpObMk+z/9eY=;
 b=FxSJhAB1bwnuXKmCrZPGkKQOv5ehBPzbNwjW5+dYzhdfleq0nhkIAb+Dm57E+ka1wj
 FEFxjsfmnN60/+2dTgkJ/gkpggOslSuS9X+LnLGHjpEVhJ49Z0FNoWnf5PQkbSyqGPQp
 XUrQcHMvAOcfKp5JbHcoZtBRpZPpe9MYBE2UIRNQbtuFh62v62gkwJdbahKo5UYSWWlq
 NG1GtANjTJDkOtDajSOFZulI6EHXYAorLi7u8VeMf0cF3LG2kHFOYbCC/f5sPp7pPXcc
 lqPSL6i99iFbUvrNVrfq8nSrsPAqLVZNJQLKLUq77CkayyjLzZeES6Yh2cinXkeK7MY5
 3EfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5roujKuKxGleVMBHNLotppkMrHNIRxyzoTS0On9Vp0dBdt6OR/Ep9k69ldnMRaNevtcwSh2jL0MuUHN9P64c2vrasQxo=
X-Gm-Message-State: AOJu0Yzn0CLfNiXLSWyKV4nACsP62oZ8myM2INeim4ehN9bTbTrwI98Q
 hWddA5wWxVtP8F/6V4dbFWhohRhjhVLXFBP3wf/pfQp6iT0p8yuSz5kd4CGKNRjDZG0axjs17KO
 nxROk3zZs0fmue/wAxgYOSABYS97ZysN+xPOS5fLGpU2fXTlHxTfb
X-Received: by 2002:a05:6359:411e:b0:1a5:2dd1:8884 with SMTP id
 e5c5f4694b2df-1aa989ea885mr241729055d.0.1720107389199; 
 Thu, 04 Jul 2024 08:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHmbUlYjoD8qJlng519zDBnuSEx7Yda/cB7vlxBxNj4+EHsJTM2y/9A72VY5sr6ZdElI18A==
X-Received: by 2002:a05:6359:411e:b0:1a5:2dd1:8884 with SMTP id
 e5c5f4694b2df-1aa989ea885mr241726955d.0.1720107388756; 
 Thu, 04 Jul 2024 08:36:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5eac2fd01sm8055546d6.130.2024.07.04.08.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 08:36:28 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:36:25 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
Message-ID: <ZobBeWWyf5aHGROj@x1n>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
 <ZoRSA4naaje878PK@x1n>
 <PH7PR11MB5941E373F92A78EB5A7E4FCAA3DE2@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941E373F92A78EB5A7E4FCAA3DE2@PH7PR11MB5941.namprd11.prod.outlook.com>
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

On Thu, Jul 04, 2024 at 03:15:51AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, July 3, 2024 3:16 AM
> > To: Wang, Yichen <yichen.wang@bytedance.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrangé
> > <berrange@redhat.com>; Eduardo Habkost <eduardo@habkost.net>; Marc-André
> > Lureau <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>;
> > Philippe Mathieu-Daudé <philmd@linaro.org>; Fabiano Rosas
> > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> > <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu-
> > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > <yuan1.liu@intel.com>; Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack)
> > Chuang <horenchuang@bytedance.com>
> > Subject: Re: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
> > 
> > On Thu, Jun 27, 2024 at 03:34:41PM -0700, Yichen Wang wrote:
> > > v3:
> > > - Rebase changes on top of master
> > > - Merge two patches per Fabiano Rosas's comment
> > > - Add versions into comments and documentations
> > >
> > > v2:
> > > - Rebase changes on top of recent multifd code changes.
> > > - Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
> > > - Remove parameter tuning and use QATzip's defaults for better
> > >   performance.
> > > - Add parameter to enable QAT software fallback.
> > >
> > > v1:
> > > https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html
> > >
> > > * Performance
> > >
> > > We present updated performance results. For circumstantial reasons, v1
> > > presented performance on a low-bandwidth (1Gbps) network.
> > >
> > > Here, we present updated results with a similar setup as before but with
> > > two main differences:
> > >
> > > 1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
> > > 2. We had a bug in our memory allocation causing us to only use ~1/2 of
> > > the VM's RAM. Now we properly allocate and fill nearly all of the VM's
> > > RAM.
> > >
> > > Thus, the test setup is as follows:
> > >
> > > We perform multifd live migration over TCP using a VM with 64GB memory.
> > > We prepare the machine's memory by powering it on, allocating a large
> > > amount of memory (60GB) as a single buffer, and filling the buffer with
> > > the repeated contents of the Silesia corpus[0]. This is in lieu of a
> > more
> > > realistic memory snapshot, which proved troublesome to acquire.
> > >
> > > We analyze CPU usage by averaging the output of 'top' every second
> > > during migration. This is admittedly imprecise, but we feel that it
> > > accurately portrays the different degrees of CPU usage of varying
> > > compression methods.
> > >
> > > We present the latency, throughput, and CPU usage results for all of the
> > > compression methods, with varying numbers of multifd threads (4, 8, and
> > > 16).
> > >
> > > [0] The Silesia corpus can be accessed here:
> > > https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia
> > >
> > > ** Results
> > >
> > > 4 multifd threads:
> > >
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |method         |time(sec)      |throughput(mbps)|send cpu%|recv
> > cpu%|
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |qatzip         | 23.13         | 8749.94        |117.50   |186.49
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |zlib           |254.35         |  771.87        |388.20   |144.40
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |zstd           | 54.52         | 3442.59        |414.59   |149.77
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |none           | 12.45         |43739.60        |159.71   |204.96
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >
> > > 8 multifd threads:
> > >
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |method         |time(sec)      |throughput(mbps)|send cpu%|recv
> > cpu%|
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |qatzip         | 16.91         |12306.52        |186.37   |391.84
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |zlib           |130.11         | 1508.89        |753.86   |289.35
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |zstd           | 27.57         | 6823.23        |786.83   |303.80
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |none           | 11.82         |46072.63        |163.74   |238.56
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >
> > > 16 multifd threads:
> > >
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |method         |time(sec)      |throughput(mbps)|send cpu%|recv
> > cpu%|
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |qatzip         |18.64          |11044.52        | 573.61  |437.65
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |zlib           |66.43          | 2955.79        |1469.68  |567.47
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |zstd           |14.17          |13290.66        |1504.08  |615.33
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >     |none           |16.82          |32363.26        | 180.74  |217.17
> > |
> > >     |---------------|---------------|----------------|---------|--------
> > -|
> > >
> > > ** Observations
> > >
> > > - In general, not using compression outperforms using compression in a
> > >   non-network-bound environment.
> > > - 'qatzip' outperforms other compression workers with 4 and 8 workers,
> > >   achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
> > > ~58% latency reduction over 'zstd' with 4 workers.
> > > - 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
> > >   showing a ~32% increase in latency. This performance difference
> > > becomes more noticeable with more workers, as CPU compression is highly
> > > parallelizable.
> > > - 'qatzip' compression uses considerably less CPU than other compression
> > >   methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
> > > compression CPU usage compared to 'zstd' and 'zlib'.
> > > - 'qatzip' decompression CPU usage is less impressive, and is even
> > >   slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.
> > 
> > Thanks for the results update.
> > 
> > It looks like the docs/migration/ file is still missing.  It'll be great
> > to
> > have it in the next version or separately.
> > 
> > So how it compares with QPL (which got merged already)?  They at least
> > look
> > like both supported on an Intel platform, so an user whoever wants to
> > compress the RAM could start to look at both.  I'm utterly confused on why
> > Intel provides these two similar compressors.  It would be great to have
> > some answer and perhaps put into the doc.

Yuan,

> 
> I would like to explain some of the reasons why we want to merge the 
> two QAT and IAA solutions into the community.

Yes, these are very helpful information.  Please consider putting them into
the cover letter if there's a repost, and perhaps also in the doc/ files.

> 
> 1. Although Intel Xeon Sapphire Rapids supports both QAT and IAA, different 
>    SKUs support different numbers of QAT and IAA, so some users do not have 
>    both QAT and IAA at the same time.
> 
> 2. QAT products include PCIe cards, which are compatible with older Xeon
>    products and other non-Xeon products. And some users have already used QAT
>    cards to accelerate live migration.

Ah, this makes some sense to me.

So a previous question always haunted me, where I wondered why an user who
bought all these fancy and expensive processors with QAT, would still like
to not invest on a better network of 50G or more, but stick with 10Gs
ancient NICs and switches.

So what you're saying is logically in some old clusters with old chips and
old network solutions, it's possible that user buys these PCIe cards
separately so it may help with that old infra migrate VMs faster.  Is that
the case?

If so, we may still want some numbers showing how this performs in a
network-limited environment, and how that helps users to migrate.  Sorry if
there's some back-and-forth requirement asking for these numbers, but I
think these are still important information when an user would like to
decide whether to use these features.  Again, put that into docs/ if proper
would be nice too.

> 
> 3. In addition to compression, QAT and IAA also support various other features 
>    to better serve different workloads. Here is an introduction to the accelerators,
>    including usage scenarios of QAT and IAA.
>    https://www.intel.com/content/dam/www/central-libraries/us/en/documents/2022-12/storage-engines-4th-gen-xeon-brief.pdf

Thanks for the link.

However this doesn't look like a reason to support it in migration?  It
needs to help migration in some form or another, no matter how many
features it provides.. since migration may not consume them.

Two major (but pure..) questions:

  1) Why high cpu usage?

     I raised this question below [1] too but I didn't yet get an answer.
     Ror 8-chan multifd, it's ~390% (QAT) v.s. ~240% (nocomp), even if
     46Gbps bw for the latter... so when throttled it will be even lower?

     The paper you provided above has this upfront:

        When a CPU can offload storage functions to built-in accelerators,
        it frees up cores for business-critical workloads...

     Isn't that a major feature to be able to "offload" things?  Why cpu
     isn't freed even if the offload happened?

  2) TLS?

     I think I asked before, I apologize if any of you've already answered
     and if I forgot.. but have any of you looked into offload TLS (instead
     of compression) with the QATs?

Thanks,

> 
> For users who have both QAT and IAA, we recommend the following for choosing a 
> live migration solution:
> 
> 1. If the number of QAT devices is equal to or greater than the number of IAA devices 
>    and network bandwidth is limited, it is recommended to use the QATZip(QAT) solution.
> 
> 2. In other scenarios, the QPL (IAA) solution can be used first.
> 
> > I am honestly curious too on whether are you planning to use it in
> > production.  It looks like if the network resources are rich, no-comp is
> > mostly always better than qatzip, no matter on total migration time or cpu
> > consumption.  I'm pretty surprised that it'll take that much resources
> > even
> > if the work should have been offloaded to the QAT chips iiuc.

[1]

> > 
> > I think it may not be a problem to merge this series even if it performs
> > slower at some criterias.. but I think we may still want to know when this
> > should be used, or the good reason this should be merged (if it's not
> > about
> > it outperforms others).
> > 
> > Thanks,
> > 
> > >
> > >
> > > Bryan Zhang (4):
> > >   meson: Introduce 'qatzip' feature to the build system
> > >   migration: Add migration parameters for QATzip
> > >   migration: Introduce 'qatzip' compression method
> > >   tests/migration: Add integration test for 'qatzip' compression method
> > >
> > >  hw/core/qdev-properties-system.c |   6 +-
> > >  meson.build                      |  10 +
> > >  meson_options.txt                |   2 +
> > >  migration/meson.build            |   1 +
> > >  migration/migration-hmp-cmds.c   |   8 +
> > >  migration/multifd-qatzip.c       | 382 +++++++++++++++++++++++++++++++
> > >  migration/multifd.h              |   1 +
> > >  migration/options.c              |  57 +++++
> > >  migration/options.h              |   2 +
> > >  qapi/migration.json              |  38 +++
> > >  scripts/meson-buildoptions.sh    |   6 +
> > >  tests/qtest/meson.build          |   4 +
> > >  tests/qtest/migration-test.c     |  35 +++
> > >  13 files changed, 551 insertions(+), 1 deletion(-)
> > >  create mode 100644 migration/multifd-qatzip.c
> > >
> > > --
> > > Yichen Wang
> > >
> > 
> > --
> > Peter Xu
> 

-- 
Peter Xu


