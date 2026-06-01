Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEF7CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAQg-0002WM-CH; Mon, 01 Jun 2026 17:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUAQe-0002Vm-IX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:44:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUAQc-0001mk-Sf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:44:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ebafde87cso7034321f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 14:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780350249; x=1780955049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z8n70Sy4CJ1FIPBfOrTJVgIMJGkB3v8thuzrdqlBMFM=;
 b=StNYFn8mpZT5ozBIkeMh66baLTJNmPd6I/4hrZZDQ1BZEaK7N+0GaAN/ya//ippEUz
 aIJuX3hy1mpbsjvBAhHWUNCc89hXWIh41EJetwxpNbc0itCWpa/PI98W7rLcjXg0e/Xw
 nwR2N6wMeqkSMMP2Esit++YY0wTdFxlrKFlzCHkAqlWBasibcw6NOFKpn6ZusBtpGrsq
 X0lkPWfNjbx4BWR5331ZfrEGsh5pLeRNFovhrKnuyojPkRIbKk5rZRl6IsIGcdBQUWAA
 /9uac0ONrYAmD4yEQ8ReYY8xZ5U6GHcGH9cgJREUYiaSSfMYAVPhfIyvRapLa78km/5z
 +zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780350249; x=1780955049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8n70Sy4CJ1FIPBfOrTJVgIMJGkB3v8thuzrdqlBMFM=;
 b=OlePXNcmWYpy90uDQsLnyWjJPHcf9HASLbApVSrI7PCFnRpXk9aUwYZ52RA8J80QSj
 PGyI+3T0l8DOJGeU9DzCwJG3WSFfH2ZtFKsCDnpU9Jv0udIHSxvgomXHeysjnmJoPkN0
 /wjWRJZSWSiEX9h6NPvqwLKCNFPHN1xvxgq1bL+zOPxQYQAO+Ph50HCPdpyMC04XGUtN
 +eWF52w9/zUaJc5YICTbQtPAlILkhlnbk/2reO9yPZc0NdLZRTrDkx2uDdae+L5WWY4G
 rZa+FrDHHXpRSVTo88tFtIxx7Vum4L4yc3lCZJ6fbCBqu1qajhfl2yzWJpCtZn5JMD9B
 qeQQ==
X-Gm-Message-State: AOJu0YzEQ/r7MdLC5cmmfpCyTHQVlpAAr/TGvkpiyACxcbkMVPMx3Av8
 MiccUU9wabfxjv6oBDbgRoj9ioB5dB3yLzR5nzac6Gr9DCZoBKwRoCD9DghcJqzvEi0=
X-Gm-Gg: Acq92OHyVlpx/JiMElHHJP4MMG+vz9m3nvu4Nwe0vztKmN/5unL5/XP/96oRfTIHPBP
 TDzatdU0CQNQ2zi95eYevX55u7Lv4rZyhyBjJbGL1MCiF3axYn8cWXCk0g67JhaALfFnjwwWXoJ
 kBjWOdqO/aEEsfY73ia21VnQXMljx/qQ3jtKWTiDzMQf/NPR51cbmt/czWiV1Tr3FD1bZxvgRTC
 sZGckFOFHatCZq4iXUB8SBMWxIMoMLBetSi2DLSzn0Lun9yx/WANOGw6GR+z8i+2BB3mtVwuYsG
 piM0WNEzbLv0sNriKB+a5Z/sF/yOv98Z0RuX9yvsNFcKzVmpseP7uRvBq4EjmkSRcI26mSfXPMx
 EBGCg3pnFtKmZBvQ4Grj/Rn872nK8xg1FOqBceMp8o3YbmgN6CaKtjB+Ewznt8lCRcn7fnp/lOz
 2NTFwAQz69ZMZXA3tEqhp9Vta4ZmhakaHUuax446XgIXgcYvm/kKgcEC19zHz6sS0PYg==
X-Received: by 2002:a5d:6049:0:b0:45e:655d:6f7 with SMTP id
 ffacd0b85a97d-45ef6b6b9damr17143465f8f.24.1780350248504; 
 Mon, 01 Jun 2026 14:44:08 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:595:8cac:dffc:932f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356b129sm35423496f8f.32.2026.06.01.14.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:44:08 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>, hare@suse.de,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v11 0/5] Add full zoned storage emulation to the qcow2 driver
Date: Mon,  1 Jun 2026 23:44:00 +0200
Message-ID: <20260601214405.252818-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
qcow2 driver, allowing full zoned storage emulation on a qcow2
image file. A user can attach such an image to a guest and have
it appear as a host-managed zoned block device.

The zoned format is opt-in through a new qcow2 header extension
that pins the zone geometry. Behind the extension is a dedicated
zoned metadata region that stores one 8-byte write pointer (WP)
per zone. The extension is gated by an incompatible bit, so an
older qcow2 implementation cannot accidentally open the image.

Each write pointer is routed through the write pointer cache,
a Qcow2Cache object. The write pointer cache is written to disk
after the qcow2 metadata is written, thus guaranteeing that
the write pointer is updated after the corresponding data is
written.

Zone states are in memory. Read-only and offline states are
device-internal events, which are not modelled in qcow2
emulation for simplicity. The other zone states
(closed, empty, full) can be inferred from write poiner
values, presistent across QEMU reboots. The open states are
kept in memory using open zone lists.

To create a qcow2 file with the zoned format:

    qemu-img create -f qcow2 zbc.qcow2 \
        -o size=768M \
        -o zone.size=64M \
        -o zone.capacity=64M \
        -o zone.conventional_zones=0 \
        -o zone.max_append_bytes=4096 \
        -o zone.max_open_zones=6 \
        -o zone.max_active_zones=8 \
        -o zone.mode=host-managed

Then attach it to a guest via the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,\
              file.driver=file,file.filename=zbc.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

v10->v11:
- add write ordering through write pointer cache [Stefan]
- add new test cases to iotests for zone append write
- add zoned image info to qemu-img --info
- move virtio-blk cross-zone-boundary merge fix into its own patch [Stefan]
- fix specs and docs:
    * document bit 59 conventional-zone marker in qcow2.rst [Stefan]
    * spell out write ordering for crash consistency [Stefan]
    * QAPI: rephrase comments, bump version [Markus]
- fix review comments [Stefan]

v9->v10:
- add cross-boundary constraint for merging writes on zoned devices
- extract call from assert() to fix image creation crash

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

Sam Li (5):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  virtio-blk: do not merge writes across a zone boundary
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/file-posix.c                       |    2 +-
 block/qcow2-cache.c                      |    8 +
 block/qcow2-refcount.c                   |    7 +
 block/qcow2.c                            | 1464 +++++++++++++++++++++-
 block/qcow2.h                            |   83 +-
 block/trace-events                       |    2 +
 docs/interop/qcow2.rst                   |  117 +-
 docs/system/qemu-block-drivers.rst.inc   |   47 +
 hw/block/virtio-blk.c                    |   22 +-
 include/block/block_int-common.h         |   15 +-
 qapi/block-core.json                     |   91 +-
 tests/qemu-iotests/tests/zoned-qcow2     |  209 +++
 tests/qemu-iotests/tests/zoned-qcow2.out |  191 +++
 13 files changed, 2244 insertions(+), 14 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.53.0


