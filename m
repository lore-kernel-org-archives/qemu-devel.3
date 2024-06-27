Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D17DC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 22:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMxhh-0004Me-17; Thu, 27 Jun 2024 18:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMxhe-0004MD-Kw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:34:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sMxhc-0001hX-4g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 18:34:54 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-710437d0affso6331380a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1719527688; x=1720132488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p1T+JVQndCN5dKb6323wg5da+4Fct5AN2FP4EzSrPrQ=;
 b=ikd+J9Hwi9xN+gssWipvq7IHsgxefDtqFdAeetcMn4E4tlfQq0a0/IQGBHGtanG9hC
 MQPHE8/JTjQsrZe5VLugYGHqzAsKrqdhUQXnWmDZt/l3AGhg8GpTpv2VmLF4Y18LnSvI
 loLyoQeBrGb7oN3YIPceenql7ldFsgHYggNxnoFXEqx37hKCpRPLy5qaaPotxhHeFD10
 pW4CN8+S0MI/RFXu5G74+byV537Qq+tnzQw6nmzQYPk2QVFMkKKV81ynIVJdXX4LDa5Z
 1mTrBP9DnIFSyUyYPEcPuQn7Em6QUPEfRMHi0fBStvCS1+kabOrU0QQ0ckaGWFysYPO4
 8yfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719527688; x=1720132488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p1T+JVQndCN5dKb6323wg5da+4Fct5AN2FP4EzSrPrQ=;
 b=DXGwjmLtWyP6VyriuevM1Q1OpBPaQ5SnS08U7lkWF/UJMYr6+ilcSBjjj6qJxsyycv
 v5TG+rD8edvjuIexGxsdmTo4nU8fwV6LzoYvN/VsYOzZ/+n6w0iFSLVLVoLFs5ruXPxO
 KbVbNnjIzd2M/csI2X3hpvetaTM2ZhkCPXQCw77W0UCtM5Uw3SgY1BDUxX3T1Qx0/zhB
 K4LJ0GtLiv/ZV/V/wBCCGJ++Mr2fNe2i2BX/i7YO93cXFeh7kqt+FDUMAx1zigVilWyx
 glzAiXTwMHCMnLFLIntimT+Rbz5kjJ5Yw2TL7wn3aCTz6gXQ+5IGUlgYTH9TWG2W5sYg
 Av7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlDmKWPQmwiLC8VENTZKW659ZKoqHMgTtdOe8sddPWYHj1OUtW1gIbbVsa7bnlOxbnZHPRmuYoffaa1QGSn4aysRyrBBU=
X-Gm-Message-State: AOJu0YzQXxlF8vkAZ+J6YCeeaL0PONzkJO7TcOriqnspscmeDZXF9x76
 Wb22Wv2TLeXkw1tI3baHsGoZfzUg+CfJtQHWOCKZNWY+R/QbDhbiQMWe0+QV6S0=
X-Google-Smtp-Source: AGHT+IGYS23n4tpK0VC7aVx2O47fEZv7Bl1Vj/Z2VfbMB8Kln8ksHak+9IqW+8V2dRsalnWf75o/aw==
X-Received: by 2002:a05:6a20:3caa:b0:1bd:248d:990d with SMTP id
 adf61e73a8af0-1bd248d99cfmr9787230637.25.1719527687909; 
 Thu, 27 Jun 2024 15:34:47 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080498a02csm226900b3a.199.2024.06.27.15.34.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 15:34:47 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Yichen Wang <yichen.wang@bytedance.com>
Subject: [PATCH v3 0/4] Implement using Intel QAT to offload ZLIB
Date: Thu, 27 Jun 2024 15:34:41 -0700
Message-Id: <20240627223445.95096-1-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=yichen.wang@bytedance.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

 hw/core/qdev-properties-system.c |   6 +-
 meson.build                      |  10 +
 meson_options.txt                |   2 +
 migration/meson.build            |   1 +
 migration/migration-hmp-cmds.c   |   8 +
 migration/multifd-qatzip.c       | 382 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   1 +
 migration/options.c              |  57 +++++
 migration/options.h              |   2 +
 qapi/migration.json              |  38 +++
 scripts/meson-buildoptions.sh    |   6 +
 tests/qtest/meson.build          |   4 +
 tests/qtest/migration-test.c     |  35 +++
 13 files changed, 551 insertions(+), 1 deletion(-)
 create mode 100644 migration/multifd-qatzip.c

-- 
Yichen Wang


