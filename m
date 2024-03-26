Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52390C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 20:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpDQy-0007U4-KJ; Tue, 26 Mar 2024 16:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpDQw-0007TA-JJ
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rpDQt-0003AC-Rp
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 16:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711485006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NoGs2NbUaTBMQEmumIW3sUuXNWJE+4LMdmu5aepglYk=;
 b=dbD40SZNl0/14LnUzLpngh46AjXA7X/7E1Ou2bjIWZJMCSjwYJQmwyEQvx3OVgMDX7ULbc
 ER9b8mRYqo6/7i0PTTCsNZhJ4NdunN6PRClv7PyDB5LjM5PgtjtS7kgskBUNP+7hUAGzD8
 078P3UvWVNv+Ua09YMXr0f/2R1Wk544=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-oOSGI98cO4SR01u_p4Fbvw-1; Tue, 26 Mar 2024 16:30:04 -0400
X-MC-Unique: oOSGI98cO4SR01u_p4Fbvw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-60a42f7c01fso15086167b3.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 13:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711485004; x=1712089804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NoGs2NbUaTBMQEmumIW3sUuXNWJE+4LMdmu5aepglYk=;
 b=MBLAjgh9WX1KEv+oMwEg90wgcETm9l0MCmSYfN6u19ule36Fe5pm6Q+yZ2TDUzqwmA
 n3MhehmmlgEROABpdICxn/O3yZLbD/UK/oyYiQ0jLNFMk7ZIXFjcNvNlEB41A9kgJfk3
 IRAxB2x/ly6MzED7r07xqg5sje0AmamPsQVHhyKUIpo/LH96AyJX0hYBX2f4TzcaclzT
 Go9zFeTW1xFR3C/hYQzK+WguGbhTHB0V/6MjcLc93KBhAZcamcGpAz+L629mpIX7WlbA
 bDAr6AI7a3ptPzCssAmh1CgjQuElRsIdEViP1wtFEGFQlLSEGPRT+TfV5qhCBcRTLTBn
 A37A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY6iDPr8hB9lOwTKGUDoRmh8qrUSyMKqFr6JgLdKyXBKyMldJy1yQeH/yFLsi1i906m/PSYNsDn/vscEvp8fAeHGQwr0Q=
X-Gm-Message-State: AOJu0YxoPIyFRs/v4evKRZgWdMV/AJUoGJ3AXeM3uWHAD8HWifK3uHP8
 9aBLjKZU/0Lmgtbn+6ZJPI6g41xry2b4Bgiva7x3X3L5CEo/FQvgk8RCE9Ojhjj9yLU45q7YHIm
 z5XcFCuY0xl8FzuKhq17XTM1X311zWCYvq4vDtITrWRgUkG5mo9sk
X-Received: by 2002:a25:df43:0:b0:dcc:438e:cd79 with SMTP id
 w64-20020a25df43000000b00dcc438ecd79mr6502239ybg.1.1711485003450; 
 Tue, 26 Mar 2024 13:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa+3Tg2Mx0vHiSMj5Ir8+Py9fsnQBaBED+KHobwYRnyuENQxHK0IbDguACoLf1QD1ECE2KNA==
X-Received: by 2002:a25:df43:0:b0:dcc:438e:cd79 with SMTP id
 w64-20020a25df43000000b00dcc438ecd79mr6502205ybg.1.1711485002775; 
 Tue, 26 Mar 2024 13:30:02 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gs11-20020a056214226b00b00696944e3ce6sm1861056qvb.74.2024.03.26.13.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 13:30:02 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:30:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, hao.xiang@bytedance.com,
 bryan.zhang@bytedance.com, nanhai.zou@intel.com
Subject: Re: [PATCH v5 0/7] Live Migration With IAA
Message-ID: <ZgMwSO_eRIgXZ24L@x1n>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319164527.1873891-1-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Yuan,

On Wed, Mar 20, 2024 at 12:45:20AM +0800, Yuan Liu wrote:
> 1. QPL will be used as an independent compression method like ZLIB and ZSTD,
>    QPL will force the use of the IAA accelerator and will not support software
>    compression. For a summary of issues compatible with Zlib, please refer to
>    docs/devel/migration/qpl-compression.rst

IIRC our previous discussion is we should provide a software fallback for
the new QEMU paths, right?  Why the decision changed?  Again, such fallback
can help us to make sure qpl won't get broken easily by other changes.

> 
> 2. Compression accelerator related patches are removed from this patch set and
>    will be added to the QAT patch set, we will submit separate patches to use
>    QAT to accelerate ZLIB and ZSTD.
> 
> 3. Advantages of using IAA accelerator include:
>    a. Compared with the non-compression method, it can improve downtime
>       performance without adding additional host resources (both CPU and
>       network).
>    b. Compared with using software compression methods (ZSTD/ZLIB), it can
>       provide high data compression ratio and save a lot of CPU resources
>       used for compression.
> 
> Test condition:
>   1. Host CPUs are based on Sapphire Rapids
>   2. VM type, 16 vCPU and 64G memory
>   3. The source and destination respectively use 4 IAA devices.
>   4. The workload in the VM
>     a. all vCPUs are idle state
>     b. 90% of the virtual machine's memory is used, use silesia to fill
>        the memory.
>        The introduction of silesia:
>        https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia
>   5. Set "--mem-prealloc" boot parameter on the destination, this parameter
>      can make IAA performance better and related introduction is added here.
>      docs/devel/migration/qpl-compression.rst
>   6. Source migration configuration commands
>      a. migrate_set_capability multifd on
>      b. migrate_set_parameter multifd-channels 2/4/8
>      c. migrate_set_parameter downtime-limit 300
>      f. migrate_set_parameter max-bandwidth 100G/1G
>      d. migrate_set_parameter multifd-compression none/qpl/zstd
>   7. Destination migration configuration commands
>      a. migrate_set_capability multifd on
>      b. migrate_set_parameter multifd-channels 2/4/8
>      c. migrate_set_parameter multifd-compression none/qpl/zstd
> 
> Early migration result, each result is the average of three tests
> 
>  +--------+-------------+--------+--------+---------+----------+------|
>  |        | The number  |total   |downtime|network  |pages per | CPU  |
>  | None   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
>  | Comp   |             |        |        |(mbps)   |          |      |
>  |        +-------------+-----------------+---------+----------+------+
>  |Network |            2|    8571|      69|    58391|   1896525|  256%|

Is this the average bandwidth?  I'm surprised that you can hit ~59Gbps only
with 2 channels.  My previous experience is around ~1XGbps per channel, so
no more than 30Gbps for two channels.  Is it because of a faster processor?
Indeed from the 4/8 results it doesn't look like increasing the num of
channels helped a lot, and even it got worse on the downtime.

What is the rational behind "downtime improvement" when with the QPL
compressors?  IIUC in this 100Gbps case the bandwidth is never a
limitation, then I don't understand why adding the compression phase can
make the switchover faster.  I can expect much more pages sent in a
NIC-limted env like you described below with 1Gbps, but not when NIC has
unlimited resources like here.

>  |BW:100G +-------------+--------+--------+---------+----------+------+
>  |        |            4|    7180|      92|    69736|   1865640|  300%|
>  |        +-------------+--------+--------+---------+----------+------+
>  |        |            8|    7090|     121|    70562|   2174060|  307%|
>  +--------+-------------+--------+--------+---------+----------+------+
> 
>  +--------+-------------+--------+--------+---------+----------+------|
>  |        | The number  |total   |downtime|network  |pages per | CPU  |
>  | QPL    | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
>  | Comp   |             |        |        |(mbps)   |          |      |
>  |        +-------------+-----------------+---------+----------+------+
>  |Network |            2|    8413|      34|    30067|   1732411|  230%|
>  |BW:100G +-------------+--------+--------+---------+----------+------+
>  |        |            4|    6559|      32|    38804|   1689954|  450%|
>  |        +-------------+--------+--------+---------+----------+------+
>  |        |            8|    6623|      37|    38745|   1566507|  790%|
>  +--------+-------------+--------+--------+---------+----------+------+
> 
>  +--------+-------------+--------+--------+---------+----------+------|
>  |        | The number  |total   |downtime|network  |pages per | CPU  |
>  | ZSTD   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
>  | Comp   |             |        |        |(mbps)   |          |      |
>  |        +-------------+-----------------+---------+----------+------+
>  |Network |            2|   95846|      24|     1800|    521829|  203%|
>  |BW:100G +-------------+--------+--------+---------+----------+------+
>  |        |            4|   49004|      24|     3529|    890532|  403%|
>  |        +-------------+--------+--------+---------+----------+------+
>  |        |            8|   25574|      32|     6782|   1762222|  800%|
>  +--------+-------------+--------+--------+---------+----------+------+
> 
> When network bandwidth resource is sufficient, QPL can improve downtime
> by 2x compared to no compression. In this scenario, with 4 channels, the
> IAA hardware resources are fully used, so adding more channels will not
> gain more benefits.
> 
>  
>  +--------+-------------+--------+--------+---------+----------+------|
>  |        | The number  |total   |downtime|network  |pages per | CPU  |
>  | None   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
>  | Comp   |             |        |        |(mbps)   |          |      |
>  |        +-------------+-----------------+---------+----------+------+
>  |Network |            2|   57758|      66|     8643|    264617|   34%|
>  |BW:  1G +-------------+--------+--------+---------+----------+------+
>  |        |            4|   57216|      58|     8726|    266773|   34%|
>  |        +-------------+--------+--------+---------+----------+------+
>  |        |            8|   56708|      53|     8804|    270223|   33%|
>  +--------+-------------+--------+--------+---------+----------+------+
> 
>  +--------+-------------+--------+--------+---------+----------+------|
>  |        | The number  |total   |downtime|network  |pages per | CPU  |
>  | QPL    | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
>  | Comp   |             |        |        |(mbps)   |          |      |
>  |        +-------------+-----------------+---------+----------+------+
>  |Network |            2|   30129|      34|     8345|   2224761|   54%|
>  |BW:  1G +-------------+--------+--------+---------+----------+------+
>  |        |            4|   30317|      39|     8300|   2025220|   73%|
>  |        +-------------+--------+--------+---------+----------+------+
>  |        |            8|   29615|      35|     8514|   2250122|  131%|
>  +--------+-------------+--------+--------+---------+----------+------+
> 
>  +--------+-------------+--------+--------+---------+----------+------|
>  |        | The number  |total   |downtime|network  |pages per | CPU  |
>  | ZSTD   | of channels |time(ms)|(ms)    |bandwidth|second    | Util |
>  | Comp   |             |        |        |(mbps)   |          |      |
>  |        +-------------+-----------------+---------+----------+------+
>  |Network |            2|   95750|      24|     1802|    477236|  202%|
>  |BW:  1G +-------------+--------+--------+---------+----------+------+
>  |        |            4|   48907|      24|     3536|   1002142|  404%|
>  |        +-------------+--------+--------+---------+----------+------+
>  |        |            8|   25568|      32|     6783|   1696437|  800%|
>  +--------+-------------+--------+--------+---------+----------+------+
> 
> When network bandwidth resource is limited, the "page perf second" metric
> decreases for none compression, the success rate of migration will reduce.
> Comparison of QPL and ZSTD compression methods, QPL can save a lot of CPU
> resources used for compression.
> 
> v2:
>   - add support for multifd compression accelerator
>   - add support for the QPL accelerator in the multifd
>     compression accelerator
>   - fixed the issue that QPL was compiled into the migration
>     module by default
> 
> v3:
>   - use Meson instead of pkg-config to resolve QPL build
>     dependency issue
>   - fix coding style
>   - fix a CI issue for get_multifd_ops function in multifd.c file
> 
> v4:
>   - patch based on commit: da96ad4a6a Merge tag 'hw-misc-20240215' of
>     https://github.com/philmd/qemu into staging
>   - remove the compression accelerator implementation patches, the patches
>     will be placed in the QAT accelerator implementation.
>   - introduce QPL as a new compression method
>   - add QPL compression documentation
>   - add QPL compression migration test
>   - fix zlib/zstd compression level issue
> 
> v5:
>   - patch based on v9.0.0-rc0 (c62d54d0a8)
>   - use pkgconfig to check libaccel-config, libaccel-config is already
>     in many distributions.
>   - initialize the IOV of the sender by the specific compression method
>   - refine the coding style
>   - remove the zlib/zstd compression level not working patch, the issue
>     has been solved
> 
> Yuan Liu (7):
>   docs/migration: add qpl compression feature
>   migration/multifd: put IOV initialization into compression method
>   configure: add --enable-qpl build option
>   migration/multifd: add qpl compression method
>   migration/multifd: implement initialization of qpl compression
>   migration/multifd: implement qpl compression and decompression
>   tests/migration-test: add qpl compression test
> 
>  docs/devel/migration/features.rst        |   1 +
>  docs/devel/migration/qpl-compression.rst | 231 +++++++++++
>  hw/core/qdev-properties-system.c         |   2 +-
>  meson.build                              |  16 +
>  meson_options.txt                        |   2 +
>  migration/meson.build                    |   1 +
>  migration/multifd-qpl.c                  | 482 +++++++++++++++++++++++
>  migration/multifd-zlib.c                 |   4 +
>  migration/multifd-zstd.c                 |   6 +-
>  migration/multifd.c                      |   8 +-
>  migration/multifd.h                      |   1 +
>  qapi/migration.json                      |   7 +-
>  scripts/meson-buildoptions.sh            |   3 +
>  tests/qtest/migration-test.c             |  24 ++
>  14 files changed, 782 insertions(+), 6 deletions(-)
>  create mode 100644 docs/devel/migration/qpl-compression.rst
>  create mode 100644 migration/multifd-qpl.c
> 
> -- 
> 2.39.3
> 

-- 
Peter Xu


