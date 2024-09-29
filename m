Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEBECF649E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 13:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sutYT-0002NA-Oh; Sun, 29 Sep 2024 09:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYS-0002LK-8q; Sun, 29 Sep 2024 09:01:40 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1sutYQ-000432-Hg; Sun, 29 Sep 2024 09:01:40 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so523998866b.3; 
 Sun, 29 Sep 2024 06:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727614895; x=1728219695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vO6Ms/MvQ9zrI0vB36Z6IdtNwf5dJw6JZ06s/zorvA8=;
 b=BMXDoX0hUPJSJlDmdNV1rADr1FSJ4XjwRjRbtwlCOncKu8FavyYTwmsqODs7MLHS9U
 LyBs1yaYkzrPLYFTujV7GmbYM+UipK/SVe+ECflxx3dyQuDIW3TZZClmK0oMDqvc62ro
 QL/G67NKg4UnN2vOyzokfy8eafQOThdoktz0x51cmVvH9n9/5KbeOg/R7E7c21Al+q8r
 8Pz7zK/ECEWNGS9gnuhFtnKqqnWN2aGr+RpfVDiCbsXSGld9Io1rIGWUgKRxcuz7o92F
 bBvxKdk4aPCoBUHFC06JZUeqYvU7fNmJ1FswUW4d49mIzuM3cTc0ePZIuwSAKxW0f3Iq
 bInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727614895; x=1728219695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vO6Ms/MvQ9zrI0vB36Z6IdtNwf5dJw6JZ06s/zorvA8=;
 b=wg+YaJSHfYqXpQn2fRxU5eIBLBqG11E4tRsh5JzbJyth/hi7Hw2dO/lnIsev5ixtx0
 wT6MYlf1rI/0LlXLaglbRpeuVS4HhvcIIih1NS3zxSE652j2TVqGdepypK9HeRwhjTXm
 bMnooK1Mw94I7L9nspIZGSYWKs8t2lfBX1O1oauacDm9LJ0RVcfwGy7nDVuCAemZgEZN
 WCYXNcQYBti6BHa2NpsYuRgNTTCSyo9FS39YJXcHrwlYDtbcqpjM/CoZnBhpMg0ENYXS
 iGNiFukbbU27kKI6eknEQu8rx77R0j3pFm0UKxiA3hkfTyINn0tfygERXmaqyA3RP5rl
 nfgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtBPItRM+nBVkGoRSLcOMG2OkXpe8dVWTxgJPa9nqbFSPbSNn0/9dgtM1zqk6U9LFFGb77w+qNIUB8@nongnu.org
X-Gm-Message-State: AOJu0YwW9oTkSkBCi/RdsaHAnus1hHe2wKQe0Ue0Ng9bhZneh21AuwKo
 QnRV78kawtDDThtKF2pUN7165g/vGIm9h2o1p4dV4Uhy4mWqHyJZTLtNhw8a
X-Google-Smtp-Source: AGHT+IFuRF8ltTXqSbRb5JGzvq0VWQCK7VdPNFRkJnjE+2w5fEyI9AbMjR9VF3aUP6jdhdAMoN2Kyw==
X-Received: by 2002:a17:907:74b:b0:a86:7e7f:69ab with SMTP id
 a640c23a62f3a-a93c49087f3mr936128066b.15.1727614894775; 
 Sun, 29 Sep 2024 06:01:34 -0700 (PDT)
Received: from groves.fkb.profitbricks.net
 (ip5f5af605.dynamic.kabel-deutschland.de. [95.90.246.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c27776cesm373146966b.40.2024.09.29.06.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 06:01:34 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
X-Google-Original-From: Sam Li <jia.li@ionos.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>,
 dlemoal@kernel.org, qemu-block@nongnu.org, hare@suse.de,
 Sam Li <jia.li@ionos.com>
Subject: [PATCH v8 0/4] Add full zoned storage emulation to qcow2 driver
Date: Sun, 29 Sep 2024 15:01:29 +0200
Message-Id: <20240929130133.535568-1-jia.li@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=faithilikerun@gmail.com; helo=mail-ej1-x634.google.com
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
 11 files changed, 1701 insertions(+), 11 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.34.1


