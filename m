Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCBFCF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suuDT-0004g5-Qa; Sun, 29 Sep 2024 09:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suuDS-0004eh-G6; Sun, 29 Sep 2024 09:44:02 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1suuDQ-0008OW-Fg; Sun, 29 Sep 2024 09:44:01 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d6d0fe021so608719766b.1; 
 Sun, 29 Sep 2024 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727617438; x=1728222238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ar0Umd7lNogNSDYCVnXv2sbYzqaVB3nv1Jnbqyb2TPk=;
 b=UYD1y9KMHva6mdlsbfCo4yz+h6tH00k9yiHGKTpOPKZ00R5H4hKFrq1kvl91sqwTqJ
 fugjZDRvSB9r3t0smPYFBPsi3MpQzsckxxz8QifDuev3ye1TOz6wbSBoX6kz4FSTLwyQ
 9FOWxFvzv4L4tRB/TPbN399b+lTIXDRIUkdpPB2aa+n0Ac1E/Oos7ZAswKHELwMqxLLu
 V6uixgVscfryUaisFz4EOI0xvME9f0+iMzTOsSmI7Ks10zQvt0lRqiIMn6R2gIXUgiS5
 5d2vzZamfKhRZIXYdd7xTRTWVfcY0+rixR45eJa7GDoSEbO9lCJxSSCGMLQZaBmKtUW6
 TVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727617438; x=1728222238;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ar0Umd7lNogNSDYCVnXv2sbYzqaVB3nv1Jnbqyb2TPk=;
 b=FtMlX1td43rYj06yfQtWgNRHDVnl31TGAZLlpzc7IEzQqPiqZ2kHHBefRs6qvrh1SZ
 lSd+MzpFaFIvjtTc3N5E7ah+2dfYwTp4abFp4Mdaqzczi8RDO2804MDkurrx4mm7FyfJ
 7w2RPvtDWDQc400OI7waBiCOwU6L8/1rIv6fV2FzF9lsvGjMu545fOYcAvUNNBFFlH0c
 8iEiCtjvcs86fx5va37fXmVP3Lkv1KqfKz3key/NHMJdf47+DUS2Fe4XtnO+UZU9A5yf
 rwYuk+3GNQtmD1Y9fo5cR8OcL5JpcvzY54HNdLfIBBgwlt48ZTdYwq8C4YaGM4yOUKal
 gc2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUff43zL9rIT/uHirZA7GGbyjj1w/Yg+P9MqxcFh4ctMXm7bmhWhXsz8ZGjFg5B1rSRifnxTdxPyK8g@nongnu.org
X-Gm-Message-State: AOJu0YzHutemay35rx+zbEe4shF5OTBq/tctpah2ztQaLEjUgqEhie6i
 qogYjHwW0G/eUSVwxggnpQ7B5PJFclTaCZSWDS3XmeESRX84y89CvcGWyWcY
X-Google-Smtp-Source: AGHT+IHK+nmXoissWzF2xY5w1HOb6YseyhAFJLktVtjilfa+o77KZ6dULS1mX0684h3ggazFdLYdQQ==
X-Received: by 2002:a17:906:dac3:b0:a8b:c9d4:5cef with SMTP id
 a640c23a62f3a-a93c4946a7cmr972023166b.29.1727617437713; 
 Sun, 29 Sep 2024 06:43:57 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2775934sm377029866b.35.2024.09.29.06.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:43:57 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 hare@suse.de, Eric Blake <eblake@redhat.com>, dmitry.fomichev@wdc.com,
 dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v9 0/4] Add full zoned storage emulation to qcow2 driver
Date: Sun, 29 Sep 2024 15:43:52 +0200
Message-Id: <20240929134356.562086-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch series add a new extension - zoned format - to the
qcow2 driver thereby allowing full zoned storage emulation on
the qcow2 img file. Users can attach such a qcow2 file to the
guest as a zoned device.

Write pointer are preserved in the zoned metadata. It will be
recovered after power cycle. Meanwhile, any open (implicit or
explicit) zone will show up as closed.

Zone states are in memory. Read-only and offline states are
device-internal events, which are not considerred in qcow2
emulation for simplicity. The other zone states
(closed, empty, full) can be inferred from write poiner
values, presistent across QEMU reboots. The open states are
kept in memory using open zone lists.

To create a qcow2 file with zoned format, use command like this:

Then add it to the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=../qemu/test.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

v8->v9:
- fix compilation err after modifying types

v7->v8:
- sets default values for zoned img confurations [Markus, Damien]
- changes the type of zone_size, zone_capacity from uint32_t to uint64_t [Stefan]
- fix docs [Stefan]
- modify append writes to increase concurrency [Damien, Stefan]
- use tailqueue to track active zones [Stefan]
- fix undefined behavior of ranges_overlap()
- fix the iotest of case 2(1)

v6->v7:
- modify zone resource managemant (style) [Damien]
- fix accessing list with negative index err
- add some tests for zrm in iotests
- address review comments [Markus]

v5->v6:
- fix docs and specs [Eric, Markus, Stefan]
- add general sanity checks for zoned device configurations while creation and opening [Eric]
- fix LRU when implicitly open a zone for a long time [Stefan]

v4->v5:
- add incompatible bit for zoned format [Eric]
- fix and manage zone resources via LRU [Damien]
- renaming functions and fields, spec changes [Markus, Damien]
- add closed zone list
- make qemu iotests for zoned device consecutive [Stefan]

v3->v4:
- use QLIST for implicit, explicit open zones management [Stefan]
- keep zone states in memory and drop state bits in wp metadata structure [Damien, Stefan]
- change zone resource management and iotests accordingly
- add tracing for number of implicit zones
- address review comments [Stefan, Markus]:
  * documentation, config, style

v2->v3:
- drop zoned_profile option [Klaus]
- reformat doc comments of qcow2 [Markus]
- add input validation and checks for zoned information [Stefan]
- code style: format, comments, documentation, naming [Stefan]
- add tracing function for wp tracking [Stefan]
- reconstruct io path in check_zone_resources [Stefan]

v1->v2:
- add more tests to qemu-io zoned commands
- make zone append change state to full when wp reaches end
- add documentation to qcow2 zoned extension header
- address review comments (Stefan):
  * fix zoned_mata allocation size
  * use bitwise or than addition
  * fix wp index overflow and locking
  * cleanups: comments, naming

Sam Li (4):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/file-posix.c                       |    2 +-
 block/qcow2.c                            | 1112 +++++++++++++++++++++-
 block/qcow2.h                            |   39 +-
 block/trace-events                       |    2 +
 docs/interop/qcow2.txt                   |  107 ++-
 docs/system/qemu-block-drivers.rst.inc   |   42 +
 include/block/block_int-common.h         |   15 +-
 include/qemu/queue.h                     |    1 +
 include/qemu/range.h                     |    4 +
 qapi/block-core.json                     |   69 +-
 tests/qemu-iotests/tests/zoned-qcow2     |  148 +++
 tests/qemu-iotests/tests/zoned-qcow2.out |  173 ++++
 12 files changed, 1702 insertions(+), 12 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.34.1


