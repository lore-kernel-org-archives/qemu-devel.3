Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE46CA101B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 23:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skB28-0002EP-Vu; Fri, 30 Aug 2024 19:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB22-000230-EE
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:54 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1skB1y-0001q0-Vi
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 19:27:54 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4567f2cbdb9so13461771cf.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 16:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725060464; x=1725665264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BINU/ARis0AuSd5ZJrh4bWStO6kK4xakkKq+jvX8P9U=;
 b=E0o3z2iCkCSHDt2ubnoiOCPhtnTYn6g9Fx50CshCgav9FsXGqp2qjnegw0YAZJg/+S
 WTIwjKeMJxDbmdqCk7bJ6QPKUCcaC0Hw09Bw0y1XG+lLl33Fk6toUmnxtSpOKLG5gaLf
 fHjQz0xsfYy5pam/PNBhfAo+idB+tw18Q7Z2v5V+AugOaShtGWa1LRHLvD9d7vCYUooN
 3AoK76ag69FnfR9XlawUnGWRFLcjQUZ4wyVsAe1g2wzoFySM0ebc14Zx2PIKlWskGIf7
 eL6OjUz8agQ3f/7YNlmuyIl+eQOxzdHWvtYtG+0UU7PIIpsu3X7W0odRkRpDAOEPFzUm
 FBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060464; x=1725665264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BINU/ARis0AuSd5ZJrh4bWStO6kK4xakkKq+jvX8P9U=;
 b=FGleDCIGij0QqSenxoLRCUwbTixRMMn1dlFCN0TVo7fc+EZg8DuVsp9HTEzMXs2zm6
 plwoD65n5D3mYbc8NRvlG5xVQywec0y1wVLZ+Z9k6/n2lTRHzv0CaYGWjIwk2hrzKcf3
 O1bAF98sY/sYaJvc9zpc9PejGPfst3WYGr5lMwQLkAwHTOx9YaFq63O4kXb8CoPDjnN3
 ewmpF6xp6JOy5QwISI+PMnTwKYzMuZwwjTDifqMcsCj0NvZFGPLsPWKLLvqktYSnNC4H
 zQ51aoldaGAd3cePqX7wDDv6ft7bcCzLUs162Bl3kvT+EgAhZ1PlhuUZhOdxzZFMnqY5
 LK6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyhRm8gIbdHeNPzRNd2thoR5Fw7DkxjdWKojqIPaH/Wf51/7AVvKpYCGMRqoXoPc09RdNe4Apk+4FW@nongnu.org
X-Gm-Message-State: AOJu0YxYanNkw8dM0NVlqFtLv90vglYNdr0kBEJ2Wv/cBSArzQwhkV0M
 E/qAbYTy/hJU9ds6i8arO+VO5rEdgLyXTCv8o2pavTVuE5U2hbW2XIy6XSQBmjs=
X-Google-Smtp-Source: AGHT+IGvu+k38IN+pFXiR2YrtX96epchO6bHf/ieZSHlI8JhZT+X7+l/xul3orr8yPQ5seBTGj2FiQ==
X-Received: by 2002:a05:6214:450d:b0:6c3:5472:946e with SMTP id
 6a1803df08f44-6c3547296c3mr17887946d6.16.1725060464150; 
 Fri, 30 Aug 2024 16:27:44 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca689asm19129176d6.109.2024.08.30.16.27.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Aug 2024 16:27:43 -0700 (PDT)
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
Subject: [PATCH v9 0/5] Implement QATzip compression method
Date: Fri, 30 Aug 2024 16:27:17 -0700
Message-Id: <20240830232722.58272-1-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qt1-x835.google.com
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

v9:
- Rebase changes on top of cec99171931ea79215c79661d33423ac84e63b6e;
- Address comments and add Review-by in commit messages; 

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


