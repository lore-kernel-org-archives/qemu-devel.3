Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399D2C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSMF-0005z1-Nj; Tue, 20 Aug 2024 13:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSMC-0005it-8c
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:20 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sgSM8-0007gd-SD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 13:09:19 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6bf6721aae5so28270806d6.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724173753; x=1724778553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7EjcXAOq9+3JLtxJRHDvGE7uwPOOnbw/Nc3MnxorsDY=;
 b=VcLS1kqaEhCYKN2d8UM1waS/MHQoLQTq4axJ5blWaHfd+U7y5TYDYZBAqe97xmwCtZ
 R5bvqxNd4DTlagYnDWIYISi5w4QiWq2CJ2NLLjRKRzMSlu4GQiy1dF4+P1t/jAueZKH5
 PEjZ892hwUd25hG50bfoqlkny7CYag5tD2W/CJRvBHJ9k5H4uAIDJ7VodbOi9s1rsCxz
 lqIaD78NbnBcCO1GRVg17hjo5xZN+M8J8RzHgVjCmjWM4J4vpCOAockgpFCAEs7vDDxD
 syE6do6lOPSFkFyD0zQcdZ7rbXufkNL9ZRq+QBJmmOX/8KsQMsbAHkuv0MOA9DjEQ/t3
 uYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724173753; x=1724778553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7EjcXAOq9+3JLtxJRHDvGE7uwPOOnbw/Nc3MnxorsDY=;
 b=C3/c+hm0LRPocBLYTf5izGU5DKqJollreCbaGidvrdCbdTSQvKj6gOWpX63lcHn7mJ
 W87DYh2zNO1DHr+XBnt1CBcvE06G0tCSpa2KtDPXtx2CjkCLZqUbNJvy6KnsjwXkwbcn
 JC2gIzialDAQ/7RxjXu55dEsX8QayVulO0tM91atl5memdRLaWNKB6PG35KBqS3bSLrq
 eA+rKAJIbx5rMehBVCPdBCCutEu2IdcU06DZY1BzmC9TDGI9YG1xvi6Yako+TiZHq9H8
 Jsc9gCHpcqGP4oC2BOhXzxoO+n2nMro+tW9FidW/mhP1NPJ13y1ZGD+b801qURH7Cs7I
 dn9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7UaD3WF7faBxKr1Ju1D/tppy0ntFznHPA6fah0sh3syPN2SU89HDulnZc8bRCvOR5fPNt6Mc0KWaO@nongnu.org
X-Gm-Message-State: AOJu0YwsXFH2fGTLFgDgBColKvnIiOUzuRZpkxDsc08HktaBDkjrS0gI
 crNXI5IQcJ489D15HnubhM9KVqaws/4pjLr69HKuRkZqRM388E97LmS1EPXe6rU=
X-Google-Smtp-Source: AGHT+IFOtR9O5YWGJkOb58XBHkdl8t/+uwNb5cj6NgCt2WKBQHUOdeFLdIzqorq9hdWZy+BlKqr7pQ==
X-Received: by 2002:a05:6214:3b89:b0:6bf:6b8a:40a1 with SMTP id
 6a1803df08f44-6bf7cdeda50mr150990626d6.29.1724173752448; 
 Tue, 20 Aug 2024 10:09:12 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fef2372sm53599576d6.114.2024.08.20.10.09.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Aug 2024 10:09:11 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 "Xiaoning Ding" <xiaoning.ding@bytedance.com>
Subject: [PATCH v8 0/5] Implement QATzip compression method
Date: Tue, 20 Aug 2024 10:09:02 -0700
Message-Id: <20240820170907.6788-1-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v8:
- Rebase changes on top of 2eefd4fcec4b8fe41ceee2a8f00cdec1fe81b75c;
- Fix typo and grammars in documentation and comments; 

v7:
- Rebase changes on top of 0173b97a219c63062972744682eba46c560fb7f3
- Added QAT memory requirement introduction in documentations;
- Change the configuration options detection to auto in meson;
- Enhance the auto-fallback mechanism to align with QPL behavior;

v6:
- Rebase changes on top of 4ea7e9cd882f1574c129d67431784fecc426d23b
- Address comments, typos, and styling issues
- Re-factor QAT setup()/cleanup() logic

v5:
- Rebase changes on top of 59084feb256c617063e0dbe7e64821ae8852d7cf
- Add documentations about migration with qatzip accerlation
- Remove multifd-qatzip-sw-fallback option

v4:
- Rebase changes on top of 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768
- Move the IOV initialization to qatzip implementation
- Only use qatzip to compress normal pages

v3:
- Rebase changes on top of master
- Merge two patches per Fabiano Rosas's comment
- Add versions into comments and documentations

v2:
- Rebase changes on top of recent multifd code changes.
- Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
- Remove parameter tuning and use QATzip's defaults for better
  performance.
- Add parameter to enable QAT software fallback.

v1:
https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html

* Performance

We present updated performance results. For circumstantial reasons, v1
presented performance on a low-bandwidth (1Gbps) network.

Here, we present updated results with a similar setup as before but with
two main differences:

1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
2. We had a bug in our memory allocation causing us to only use ~1/2 of
the VM's RAM. Now we properly allocate and fill nearly all of the VM's
RAM.

Thus, the test setup is as follows:

We perform multifd live migration over TCP using a VM with 64GB memory.
We prepare the machine's memory by powering it on, allocating a large
amount of memory (60GB) as a single buffer, and filling the buffer with
the repeated contents of the Silesia corpus[0]. This is in lieu of a more
realistic memory snapshot, which proved troublesome to acquire.

We analyze CPU usage by averaging the output of 'top' every second
during migration. This is admittedly imprecise, but we feel that it
accurately portrays the different degrees of CPU usage of varying
compression methods.

We present the latency, throughput, and CPU usage results for all of the
compression methods, with varying numbers of multifd threads (4, 8, and
16).

[0] The Silesia corpus can be accessed here:
https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia

** Results

4 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         | 23.13         | 8749.94        |117.50   |186.49   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |254.35         |  771.87        |388.20   |144.40   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           | 54.52         | 3442.59        |414.59   |149.77   |
    |---------------|---------------|----------------|---------|---------|
    |none           | 12.45         |43739.60        |159.71   |204.96   |
    |---------------|---------------|----------------|---------|---------|

8 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         | 16.91         |12306.52        |186.37   |391.84   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |130.11         | 1508.89        |753.86   |289.35   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           | 27.57         | 6823.23        |786.83   |303.80   |
    |---------------|---------------|----------------|---------|---------|
    |none           | 11.82         |46072.63        |163.74   |238.56   |
    |---------------|---------------|----------------|---------|---------|

16 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         |18.64          |11044.52        | 573.61  |437.65   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |66.43          | 2955.79        |1469.68  |567.47   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           |14.17          |13290.66        |1504.08  |615.33   |
    |---------------|---------------|----------------|---------|---------|
    |none           |16.82          |32363.26        | 180.74  |217.17   |
    |---------------|---------------|----------------|---------|---------|

** Observations

- In general, not using compression outperforms using compression in a
  non-network-bound environment.
- 'qatzip' outperforms other compression workers with 4 and 8 workers,
  achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
~58% latency reduction over 'zstd' with 4 workers.
- 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
  showing a ~32% increase in latency. This performance difference
becomes more noticeable with more workers, as CPU compression is highly
parallelizable.
- 'qatzip' compression uses considerably less CPU than other compression
  methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
compression CPU usage compared to 'zstd' and 'zlib'.
- 'qatzip' decompression CPU usage is less impressive, and is even
  slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.


Bryan Zhang (4):
  meson: Introduce 'qatzip' feature to the build system
  migration: Add migration parameters for QATzip
  migration: Introduce 'qatzip' compression method
  tests/migration: Add integration test for 'qatzip' compression method

Yuan Liu (1):
  docs/migration: add qatzip compression feature

 docs/devel/migration/features.rst           |   1 +
 docs/devel/migration/qatzip-compression.rst | 165 ++++++++
 hw/core/qdev-properties-system.c            |   2 +-
 meson.build                                 |  10 +
 meson_options.txt                           |   2 +
 migration/meson.build                       |   1 +
 migration/migration-hmp-cmds.c              |   4 +
 migration/multifd-qatzip.c                  | 394 ++++++++++++++++++++
 migration/multifd.h                         |   5 +-
 migration/options.c                         |  34 ++
 migration/options.h                         |   1 +
 qapi/migration.json                         |  21 ++
 scripts/meson-buildoptions.sh               |   3 +
 tests/qtest/migration-test.c                |  27 ++
 14 files changed, 667 insertions(+), 3 deletions(-)
 create mode 100644 docs/devel/migration/qatzip-compression.rst
 create mode 100644 migration/multifd-qatzip.c

-- 
Yichen Wang


