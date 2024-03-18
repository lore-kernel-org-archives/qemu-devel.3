Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3A6C54E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeP-000733-QT; Mon, 18 Mar 2024 12:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeC-00071A-8G
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeA-0004UP-HD
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=00h93f70ec4XHII5CBafc0py/HlgrIQOPPmoAXMXwQs=;
 b=JiSDThbY2q0t7Ul3ty1XlUUX1TSYNlMCT4C1jwBTRckungEM8l0BtzG/21KaTo4AIlXFIa
 w0BSdFrDgJJHfbUmCQ5yyrXzm9GJAokGjHRJ2Rlp1hsFQF4qBNg5W50BdmwFOFARqU8ecn
 KofhWVzB89gckT8rRY5gZbulqqAyx7g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-TeztwhREOZKQBIYgpInJlA-1; Mon, 18 Mar 2024 12:15:31 -0400
X-MC-Unique: TeztwhREOZKQBIYgpInJlA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41413c99712so3682055e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778530; x=1711383330;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00h93f70ec4XHII5CBafc0py/HlgrIQOPPmoAXMXwQs=;
 b=vSXeG5oy7vYoA2A07+8iFMaLUVdFGYST1gITMi2Qmc0m/2ZTFnPnVnIgz25erGQOqV
 8tSmuboh2RNhrhNKayO2ozSHHtppabFZ5Up9/kdJ7AnmQo48GcDk0syOUzt7vw/9Q5qp
 eIDmpqdb4WzvgDSQBcHevkfxgXM7NT5sHY8H7Zk4n6Hcxz2six+r8Egu4mJ7gTrssadS
 nQ51Bzl+lNBnrzBCwBqcgggycmHN0pz2hAIcIIvL1W5+raXssjegYjjdiW8ppEvfyBJl
 kEba20BMKJo/ml5iE5jVXS/UAEGBQXs+G3STJ5QiyOzmCTpznPvR4LCjClq8NmWNsfSc
 9pAA==
X-Gm-Message-State: AOJu0Yybe2Zv/sXPxHaPw9T5WoGmspQTB8UJQ3CFuYod5PAeDh8YXbiu
 J9A6dE8YaLziDB4Uoe6NKoM2ooDCwVJcj7y24wQSPBagbX4yCKsuiQKXpmTr2F296+JJzEJFqZS
 B8TFnb2UibSwsMO84NfcroAFFFKHk5tMOmgvcGrGL6chwsNLM3Ale8dTsW/GUR/2CYXnObg3H8D
 pK/Bxd5PCZ5tAJnLrP2ZyRJicblSRNWw==
X-Received: by 2002:a05:600c:4f06:b0:414:1363:53a6 with SMTP id
 l6-20020a05600c4f0600b00414136353a6mr1390947wmq.35.1710778530178; 
 Mon, 18 Mar 2024 09:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcEktHYiUK+GxHuMPm5md59CwWzyRFk6Xof143WvkBN1zWNNLewchUOyqTeL84MrUteBMnaQ==
X-Received: by 2002:a05:600c:4f06:b0:414:1363:53a6 with SMTP id
 l6-20020a05600c4f0600b00414136353a6mr1390928wmq.35.1710778529583; 
 Mon, 18 Mar 2024 09:15:29 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 g14-20020a5d540e000000b0033e95bf4796sm10119527wrv.27.2024.03.18.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:28 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/24] virtio,pc,pci: bugfixes
Message-ID: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit ba49d760eb04630e7b15f423ebecf6c871b8f77b:

  Merge tag 'pull-maintainer-final-130324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-13 15:12:14 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to bb949df637bdb6136a9acca55a2371fe1721e109:

  smbios: add extra comments to smbios_get_table_legacy() (2024-03-18 08:42:46 -0400)

----------------------------------------------------------------
virtio,pc,pci: bugfixes

Some minor fixes plus a big patchset from Igor fixing
a regression with windows.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Mammedov (21):
      tests: smbios: make it possible to write SMBIOS only test
      tests: smbios: add test for -smbios type=11 option
      tests: smbios: add test for legacy mode CLI options
      smbios: cleanup smbios_get_tables() from legacy handling
      smbios: get rid of smbios_smp_sockets global
      smbios: get rid of smbios_legacy global
      smbios: avoid mangling user provided tables
      smbios: don't check type4 structures in legacy mode
      smbios: add smbios_add_usr_blob_size() helper
      smbios: rename/expose structures/bitmaps used by both legacy and modern code
      smbios: build legacy mode code only for 'pc' machine
      smbios: handle errors consistently
      smbios: get rid of global smbios_ep_type
      smbios: clear smbios_type4_count before building tables
      smbios: extend smbios-entry-point-type with 'auto' value
      smbios: in case of entry point is 'auto' try to build v2 tables 1st
      smbios: error out when building type 4 table is not possible
      tests: acpi/smbios: whitelist expected blobs
      pc/q35: set SMBIOS entry point type to 'auto' by default
      tests: acpi: update expected SSDT.dimmpxm blob
      smbios: add extra comments to smbios_get_table_legacy()

Michael S. Tsirkin (2):
      SMBIOS: fix long lines
      qapi: document PCIe Gen5/Gen6 speeds since 9.0

Thomas Weißschuh (1):
      docs/specs/pvpanic: mark shutdown event as not implemented

 qapi/common.json                     |   4 +-
 qapi/machine.json                    |   5 +-
 hw/i386/fw_cfg.h                     |   3 +-
 include/hw/firmware/smbios.h         |  28 +-
 hw/arm/virt.c                        |   6 +-
 hw/i386/fw_cfg.c                     |  14 +-
 hw/i386/pc.c                         |   4 +-
 hw/i386/pc_piix.c                    |   4 +
 hw/i386/pc_q35.c                     |   3 +
 hw/loongarch/virt.c                  |   7 +-
 hw/riscv/virt.c                      |   6 +-
 hw/smbios/smbios.c                   | 508 +++++++++++++++--------------------
 hw/smbios/smbios_legacy.c            | 192 +++++++++++++
 hw/smbios/smbios_legacy_stub.c       |  15 ++
 tests/qtest/bios-tables-test.c       |  81 +++++-
 docs/specs/pvpanic.rst               |   2 +-
 hw/i386/Kconfig                      |   1 +
 hw/smbios/Kconfig                    |   2 +
 hw/smbios/meson.build                |   4 +
 tests/data/acpi/q35/SSDT.dimmpxm     | Bin 1815 -> 1815 bytes
 tests/data/smbios/type11_blob        | Bin 0 -> 11 bytes
 tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
 22 files changed, 558 insertions(+), 331 deletions(-)
 create mode 100644 hw/smbios/smbios_legacy.c
 create mode 100644 hw/smbios/smbios_legacy_stub.c
 create mode 100644 tests/data/smbios/type11_blob
 create mode 100644 tests/data/smbios/type11_blob.legacy


