Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC7BC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 19:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOizZ-0003DW-EK; Tue, 02 Jul 2024 15:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sOizW-0003Cy-Qg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sOizQ-0000aC-VJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 15:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719947791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7uDfOeuRf+U/jUOj0gogmqvQNlkulycl0F1w1jay1s=;
 b=TQQyAN+lryG4BU0zGu2fDrnYyeabh93Ud74ZzzHDz3z9+4baitTrnMxbLPYX5YMvKEZYgq
 hj9VTGcb1K9W1MkCYb0LwlxSRPhgufQFVRITVXm0i3tdkOjEG9+laTmxHjFjgKF9OGzTFU
 6oK1ekhPF/6kYOsB2I7+ErEqpwW3Fi0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-vpr8wGSVNBWK4bzyfl7qyA-1; Tue, 02 Jul 2024 15:16:25 -0400
X-MC-Unique: vpr8wGSVNBWK4bzyfl7qyA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b5d704ead7so858196d6.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 12:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719947784; x=1720552584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7uDfOeuRf+U/jUOj0gogmqvQNlkulycl0F1w1jay1s=;
 b=Vjy/ca9erI9IUJO3j2iXRzenIP6CWxOx/k7HXJvHWRqu9/PqH+dK3o5x9UEwb/XH1C
 n0TigON20898J+60XMAB/J55UOdGg9rnxHUai7I0ps8GiyI/N/EbVBYE/psTcpJGAJaJ
 Bqm6KyccEDJU8qg8WhvT4nEh6zUkvebOEH+WaiyXPvYGPcykQLWv2/K3EZHN+jhsNOOo
 4KUsV93XbHJSUDRoH1kdAs7JBWV92624++295fzVuMMT2+wkTvdQM4HTmXnfYw5Ldf3R
 7kG05IqDs9D1sRPDjaMNdxiUbYH3ResExqNFWFx1X0sJcHpViStoK2I0IBnNtEp5GmIG
 itQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt203suWJo/CyYPvK+J2+qCIbYsUztbBfN4vo8A9ooz8IvyR5aunD6xB8vx0M9p3JlGCQvbyksWR1cw3c6azdsy7J+cGs=
X-Gm-Message-State: AOJu0YxCPCk4M/voCzPoaZj6XFWA9/OgsJP9dS+yCwE8M1L7xXg7KOfT
 f3utCjLJJhySGcCzaPHsNO18WdQSYnznby8dKcVITJdZtEwXrb/0x2QU6p15VZe8SOkKZXqotTf
 8vdm+BakGmYrZNnABL+TZOlocEg0/d8SLU/JbT5yvI4x73bTLMikQ
X-Received: by 2002:a05:620a:4952:b0:79c:11c8:785e with SMTP id
 af79cd13be357-79d7baef903mr977448785a.6.1719947783933; 
 Tue, 02 Jul 2024 12:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1qA1rbBb5V2iSw9XX5vhzxYRMLHw6/5+Y8tajdtzJXv57MFvDCmo2QDq4X455RfqPOQrAkA==
X-Received: by 2002:a05:620a:4952:b0:79c:11c8:785e with SMTP id
 af79cd13be357-79d7baef903mr977445985a.6.1719947783490; 
 Tue, 02 Jul 2024 12:16:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d692945b4sm482441785a.57.2024.07.02.12.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 12:16:22 -0700 (PDT)
Date: Tue, 2 Jul 2024 15:16:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
Message-ID: <ZoRSA4naaje878PK@x1n>
References: <20240627223445.95096-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627223445.95096-1-yichen.wang@bytedance.com>
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

On Thu, Jun 27, 2024 at 03:34:41PM -0700, Yichen Wang wrote:
> v3:
> - Rebase changes on top of master
> - Merge two patches per Fabiano Rosas's comment
> - Add versions into comments and documentations
> 
> v2:
> - Rebase changes on top of recent multifd code changes.
> - Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
> - Remove parameter tuning and use QATzip's defaults for better
>   performance.
> - Add parameter to enable QAT software fallback.
> 
> v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html
> 
> * Performance
> 
> We present updated performance results. For circumstantial reasons, v1
> presented performance on a low-bandwidth (1Gbps) network.
> 
> Here, we present updated results with a similar setup as before but with
> two main differences:
> 
> 1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
> 2. We had a bug in our memory allocation causing us to only use ~1/2 of
> the VM's RAM. Now we properly allocate and fill nearly all of the VM's
> RAM.
> 
> Thus, the test setup is as follows:
> 
> We perform multifd live migration over TCP using a VM with 64GB memory.
> We prepare the machine's memory by powering it on, allocating a large
> amount of memory (60GB) as a single buffer, and filling the buffer with
> the repeated contents of the Silesia corpus[0]. This is in lieu of a more
> realistic memory snapshot, which proved troublesome to acquire.
> 
> We analyze CPU usage by averaging the output of 'top' every second
> during migration. This is admittedly imprecise, but we feel that it
> accurately portrays the different degrees of CPU usage of varying
> compression methods.
> 
> We present the latency, throughput, and CPU usage results for all of the
> compression methods, with varying numbers of multifd threads (4, 8, and
> 16).
> 
> [0] The Silesia corpus can be accessed here:
> https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia
> 
> ** Results
> 
> 4 multifd threads:
> 
>     |---------------|---------------|----------------|---------|---------|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
>     |---------------|---------------|----------------|---------|---------|
>     |qatzip         | 23.13         | 8749.94        |117.50   |186.49   |
>     |---------------|---------------|----------------|---------|---------|
>     |zlib           |254.35         |  771.87        |388.20   |144.40   |
>     |---------------|---------------|----------------|---------|---------|
>     |zstd           | 54.52         | 3442.59        |414.59   |149.77   |
>     |---------------|---------------|----------------|---------|---------|
>     |none           | 12.45         |43739.60        |159.71   |204.96   |
>     |---------------|---------------|----------------|---------|---------|
> 
> 8 multifd threads:
> 
>     |---------------|---------------|----------------|---------|---------|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
>     |---------------|---------------|----------------|---------|---------|
>     |qatzip         | 16.91         |12306.52        |186.37   |391.84   |
>     |---------------|---------------|----------------|---------|---------|
>     |zlib           |130.11         | 1508.89        |753.86   |289.35   |
>     |---------------|---------------|----------------|---------|---------|
>     |zstd           | 27.57         | 6823.23        |786.83   |303.80   |
>     |---------------|---------------|----------------|---------|---------|
>     |none           | 11.82         |46072.63        |163.74   |238.56   |
>     |---------------|---------------|----------------|---------|---------|
> 
> 16 multifd threads:
> 
>     |---------------|---------------|----------------|---------|---------|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
>     |---------------|---------------|----------------|---------|---------|
>     |qatzip         |18.64          |11044.52        | 573.61  |437.65   |
>     |---------------|---------------|----------------|---------|---------|
>     |zlib           |66.43          | 2955.79        |1469.68  |567.47   |
>     |---------------|---------------|----------------|---------|---------|
>     |zstd           |14.17          |13290.66        |1504.08  |615.33   |
>     |---------------|---------------|----------------|---------|---------|
>     |none           |16.82          |32363.26        | 180.74  |217.17   |
>     |---------------|---------------|----------------|---------|---------|
> 
> ** Observations
> 
> - In general, not using compression outperforms using compression in a
>   non-network-bound environment.
> - 'qatzip' outperforms other compression workers with 4 and 8 workers,
>   achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
> ~58% latency reduction over 'zstd' with 4 workers.
> - 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
>   showing a ~32% increase in latency. This performance difference
> becomes more noticeable with more workers, as CPU compression is highly
> parallelizable.
> - 'qatzip' compression uses considerably less CPU than other compression
>   methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
> compression CPU usage compared to 'zstd' and 'zlib'.
> - 'qatzip' decompression CPU usage is less impressive, and is even
>   slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.

Thanks for the results update.

It looks like the docs/migration/ file is still missing.  It'll be great to
have it in the next version or separately.

So how it compares with QPL (which got merged already)?  They at least look
like both supported on an Intel platform, so an user whoever wants to
compress the RAM could start to look at both.  I'm utterly confused on why
Intel provides these two similar compressors.  It would be great to have
some answer and perhaps put into the doc.

I am honestly curious too on whether are you planning to use it in
production.  It looks like if the network resources are rich, no-comp is
mostly always better than qatzip, no matter on total migration time or cpu
consumption.  I'm pretty surprised that it'll take that much resources even
if the work should have been offloaded to the QAT chips iiuc.

I think it may not be a problem to merge this series even if it performs
slower at some criterias.. but I think we may still want to know when this
should be used, or the good reason this should be merged (if it's not about
it outperforms others).

Thanks,

> 
> 
> Bryan Zhang (4):
>   meson: Introduce 'qatzip' feature to the build system
>   migration: Add migration parameters for QATzip
>   migration: Introduce 'qatzip' compression method
>   tests/migration: Add integration test for 'qatzip' compression method
> 
>  hw/core/qdev-properties-system.c |   6 +-
>  meson.build                      |  10 +
>  meson_options.txt                |   2 +
>  migration/meson.build            |   1 +
>  migration/migration-hmp-cmds.c   |   8 +
>  migration/multifd-qatzip.c       | 382 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   1 +
>  migration/options.c              |  57 +++++
>  migration/options.h              |   2 +
>  qapi/migration.json              |  38 +++
>  scripts/meson-buildoptions.sh    |   6 +
>  tests/qtest/meson.build          |   4 +
>  tests/qtest/migration-test.c     |  35 +++
>  13 files changed, 551 insertions(+), 1 deletion(-)
>  create mode 100644 migration/multifd-qatzip.c
> 
> -- 
> Yichen Wang
> 

-- 
Peter Xu


