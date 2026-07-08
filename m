Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6BAC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whaZ7-0008DU-3A; Wed, 08 Jul 2026 18:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZ5-0008DC-V1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1whaZ3-0004Fk-Uz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:16:23 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso402163a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783548980; x=1784153780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wZfdlQkyAzH5VIPkLrLtKXOwB8nuoV5TdESUAbz0YPY=;
 b=X3JZcPVV8C0L9GCChDMgvr17Cne1HlXoOOwyfERCeZV5zRlriWeIsJlkhWp/oF9azP
 yoZs4SaYxq1TGsrugY2qEDklLQBicXi+yWQ2wvCsvaVpvxQ8zXxETga9TZDiQQ6xNBJL
 7S+h9wbjwCvvMucMzuhWR35ZRsNeDaxI9weV3MDUzU04vWt1Qmesaf7vMJ1PxVLPKAoC
 qvsHjX4Vxb5EteHXDAkF31VLSzfN7w7v8E2OlIkJk1sw8we+CM4VYDoURhCGH6MmvBW7
 yNtYZ34CPCFweYxLr/fJPoa5vdPpPkqjcCeyXimPTW0y8KVNlcviPJLs/znGYQd8Xiwx
 L4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783548980; x=1784153780;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wZfdlQkyAzH5VIPkLrLtKXOwB8nuoV5TdESUAbz0YPY=;
 b=jBfALxyWCMX4hQZq51PLovk9qvWx25lxHFn+b4Sz7C7EFWlm6aM4YAjpfG6IlQV/tX
 eOloZANmpkGrgnFN7c6deSzN1WAZ6VpmEusZG7iK/stH/DFqI8umshHg4fiPvGQHgzQm
 A1remfwtPUYdNt3BiZGW9VF25gXI9c3ushsAi2Y50BVHjHnYuEyLo9IWgnnp+d7g82wK
 91GVwW7g0MmT04XOTePuLLRlTMpPw7Ayy9RjP+IOYh+s9bv6ji2PWNgomCzkuFfeTLVn
 Gwkri6zLNfVRFNf/bIIpxPVwt/6Y61gXHfAaJxektCMog2VMp3ZPDcSllnXfhL5HmNj/
 y4xg==
X-Gm-Message-State: AOJu0YyyOBLYBGHBpB7Ajs3mEd2lAK7pTT8ubvruu+nu1Rg8rGPHs3Xb
 sqRIc8jCvrGfJ8bN+oIt8+OgsXXGsGbAjYqmLRHxnhlSupilMjKKJKuuTql2xFoZHYA=
X-Gm-Gg: AfdE7cmwjJn65brdFxdbEXWOcyxqMJt/TWOxZdNorQnrN02qeqTgbVaztPre5g3YN6K
 33I4nzX2xjHKne1Chm3HTdz6hHgT+X575FMlRN/ymAiiuQc5GegCZqIRNJjXiaUZufHyCsEcQun
 u/MZwddoTGbjMCXwSLBk/oHZwEfdlpDc5CZYUYl1GnhxeoQUY+A4/XPQfImEMgdV1+ouA0Wnjjz
 UcdfGuff5DshKH3R2DZOkihcdKZsD8pqqEa+mjADWoGgdINDjcsVP+VRPpThJ2279hoROfr5KkQ
 kxrYMyHL+mkPopHuYgMOc35VvqqqVBKdyeq47GL7AFtC+oNatHWocVoRPZjXrA7uW6oDBaNh/zw
 xMpHi77E/VMUkrF48FGC8xFWs2fp0ySilVD/3ZU+TzqKippdCEzbk+yszVtSV+fQhi/Hy98S/Qb
 y+L3mrYVwj5LZx7zAMLP81u7Qdx5HSsAPQNq/UZ7tJITwe+A==
X-Received: by 2002:a05:6402:3883:b0:698:3b7c:7e41 with SMTP id
 4fb4d7f45d1cf-69ab44ae903mr1924000a12.33.1783548980159; 
 Wed, 08 Jul 2026 15:16:20 -0700 (PDT)
Received: from dobby ([2a02:8109:a394:4800:2200:181c:eef9:4c12])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d786e7sm9059237a12.16.2026.07.08.15.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:16:18 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 cassel@kernel.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v14 0/6] Add full zoned storage emulation to the qcow2 driver
Date: Thu,  9 Jul 2026 00:16:09 +0200
Message-ID: <20260708221615.346155-1-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v13->v14:
- fix review comments [Stefan]
    * store the on-disk write pointers big-endian
    * move the conventional-zone flag to bit 63 to follow block layer's wp encoding
    * add QEMU_BUILD_BUG_ON check on conv bit
    * make zone_append beyond the device capacity return -ENOSPC
    * cap nr_zones to avoid DoS
    * zone reset and finish yield until in-flight writes to the target zone drain
    * fix wps memory leak on zonedmeta refresh failure
    * fix overflow on condition checks
    * improve err handling for write pointers
- refresh qcow2 checks output
- add reviewed-by tags [Niklas]

v12->v13:
- split the zone_size widening to a separate commit [Niklas]
- relocate the qcow2_check_zone_options reorder and
  max_active/open/append-zones wording [Niklas]
- modify the comment for request merge constraints [Niklas]

v11->v12:
- validate the zoned header extension before allocating any zoned metadata
- fix the zoned locking discipline: hold the qcow2 state lock (s->lock)
  across all zone-state list updates [Stefan]
- reject, instead of aborting on an assertion, a write that reaches the
  open-zone limit while every open zone is explicitly open
- fix reduced-capacity (zone_capacity < zone_size) handling:
    * transition a zone to FULL when the write pointer reaches the zone
      capacity
    * report the zone capacity, not the zone size, in zone_report
- return -EIO rather than -EINVAL for zone write-rule violations
- use int64_t for the zoned-metadata cluster offset and zone_size to
  avoid truncation on large images
- simplify qcow2_cache_set_dependency() [Stefan]
- virtio-blk: read the zone size through a new blk_get_zone_size() [Stefan]
- docs/QAPI: clarify the max_open_zones / max_active_zones /
  max_append_bytes descriptions; use warn_report() for recoverable zoned
  configuration values in qcow2_check_zone_options() [Niklas, Stefan]
- iotests: add qcow2 check updates (303, qcow2-encryption) [Stefan]
- coding style: function opening braces, DEBUG_EXT format specifier

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

Sam Li (6):
  docs/qcow2: add the zoned format feature
  block: widen BlockLimits.zone_size to uint64_t
  qcow2: add configurations for zoned format extension
  virtio-blk: do not merge writes across a zone boundary
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 block/block-backend.c                         |   11 +
 block/file-posix.c                            |    2 +-
 block/qcow2-cache.c                           |   11 +-
 block/qcow2-refcount.c                        |    7 +
 block/qcow2.c                                 | 1617 ++++++++++++++++-
 block/qcow2.h                                 |   88 +-
 block/trace-events                            |    2 +
 docs/interop/qcow2.rst                        |  118 +-
 docs/system/qemu-block-drivers.rst.inc        |   51 +
 hw/block/virtio-blk.c                         |   22 +-
 include/block/block_int-common.h              |   15 +-
 include/system/block-backend-io.h             |    1 +
 qapi/block-core.json                          |   91 +-
 tests/qemu-iotests/031.out                    |    8 +-
 tests/qemu-iotests/036.out                    |    4 +-
 tests/qemu-iotests/082.out                    |  126 ++
 tests/qemu-iotests/303.out                    |    4 +-
 tests/qemu-iotests/tests/qcow2-encryption.out |    4 +-
 tests/qemu-iotests/tests/zoned-qcow2          |  209 +++
 tests/qemu-iotests/tests/zoned-qcow2.out      |  191 ++
 20 files changed, 2539 insertions(+), 43 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.53.0


