Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A398AC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Jom-00030J-OX; Tue, 01 Sep 2026 04:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Jol-0002zC-6s
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Joj-0003Fe-8i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788251164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qzHE3D6XQ6SCSh9ozolShDKZ/CohA1jaTZya2Ly1zm4=;
 b=Agba9cjD2SdYi+SeqWpdCrHAD+4KJfI1O5pR3elSw9UUz8YvHYyP5kO3nJjg3URJRgc7DZ
 3VdNsvSurRYrew5xQ/54qnnrNg2Lt6cCS5eqT9Dxka0E6E7j6VBNjDI5ibeZARPkcTyajJ
 OX72LwUPjzgQlWg1YErskb6vL50xX6k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-8EkT1uVgOpe6bDmF0muYkg-1; Tue,
 01 Sept 2026 04:25:58 -0400
X-MC-Unique: 8EkT1uVgOpe6bDmF0muYkg-1
X-Mimecast-MFC-AGG-ID: 8EkT1uVgOpe6bDmF0muYkg_1788251157
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 012A718011C8; Tue,  1 Sep 2026 08:25:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E3D91955F7C; Tue,  1 Sep 2026 08:25:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 14DFD1800620; Tue, 01 Sep 2026 10:25:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 00/13] Firmware 20260901 patches
Date: Tue,  1 Sep 2026 10:25:33 +0200
Message-ID: <20260901082554.804169-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998b475:

  Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/qemu into staging (2026-08-28 15:17:04 -0700)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260901-pull-request

for you to fetch changes up to 5ce32f7fdb786014255d4cfff749de307cdfdbfa:

  hw/misc/vmlaunchupdate: do not clear control bits upon fw-cfg select op (2026-09-01 09:25:53 +0200)

----------------------------------------------------------------
- edk2: update to 2026-08 stable tag
- edk2: remove 32-bit platforms (following upstream removal)
- acpi: test updates for the new edk2 firmware
- igvm/vmlaunchupdate: fix control bit handling

----------------------------------------------------------------

Ani Sinha (1):
  hw/misc/vmlaunchupdate: do not clear control bits upon fw-cfg select
    op

Gerd Hoffmann (12):
  tests/acpi: enable updates
  edk2: update build script
  edk2: update submodule to edk2-stable202608
  edk2: drop 32-bit build config (ia32 and arm), update aarch64 vars
  edk2: drop 32-bit binaries (ia32 and arm)
  edk2: rename risc-v firmware builds
  edk2: update binaries to edk2-stable202608
  tests/acpi: log the name of the table checked
  tests/acpi: skip FPDT oem field test
  tests/acpi: update expected data files
  tests/acpi: add FPDT table data for loongarch
  tests/acpi: disable updates

 roms/edk2-build.py                            |  21 +++++--
 tests/functional/aarch64/test_virt_vbsa.py    |   2 +-
 hw/misc/vmlaunchupdate.c                      |   1 -
 tests/qtest/bios-tables-test.c                |  54 ++++++++++--------
 pc-bios/descriptors/50-edk2-i386-secure.json  |  34 -----------
 pc-bios/descriptors/60-edk2-aarch64.json      |   2 +-
 pc-bios/descriptors/60-edk2-arm.json          |  31 ----------
 pc-bios/descriptors/60-edk2-i386.json         |  33 -----------
 pc-bios/descriptors/60-edk2-riscv64.json      |   4 +-
 pc-bios/descriptors/meson.build               |   3 -
 pc-bios/edk2-aarch64-code.fd.bz2              | Bin 1565763 -> 1703355 bytes
 ...m-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} | Bin
 pc-bios/edk2-arm-code.fd.bz2                  | Bin 1570311 -> 0 bytes
 pc-bios/edk2-i386-code.fd.bz2                 | Bin 1780004 -> 0 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2          | Bin 1858666 -> 0 bytes
 pc-bios/edk2-i386-vars.fd.bz2                 | Bin 190 -> 0 bytes
 pc-bios/edk2-loongarch64-code.fd.bz2          | Bin 1148383 -> 1315494 bytes
 pc-bios/edk2-riscv-code.fd.bz2                | Bin 1296526 -> 0 bytes
 pc-bios/edk2-riscv64-code.fd.bz2              | Bin 0 -> 1270019 bytes
 ...v-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
 pc-bios/edk2-x86_64-code.fd.bz2               | Bin 1907255 -> 2191408 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2            | Bin 1787244 -> 2040860 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2        | Bin 1962992 -> 2366778 bytes
 pc-bios/meson.build                           |  10 +---
 roms/edk2                                     |   2 +-
 roms/edk2-build.config                        |  52 +++--------------
 roms/edk2-version                             |   4 +-
 tests/data/acpi/aarch64/virt/HEST             | Bin 224 -> 224 bytes
 tests/data/acpi/aarch64/virt/SSDT.memhp       | Bin 1817 -> 1817 bytes
 tests/data/acpi/loongarch64/virt/FPDT         | Bin 0 -> 68 bytes
 tests/data/acpi/loongarch64/virt/FPDT.numamem | Bin 0 -> 68 bytes
 31 files changed, 65 insertions(+), 188 deletions(-)
 delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
 delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
 delete mode 100644 pc-bios/descriptors/60-edk2-i386.json
 rename pc-bios/{edk2-arm-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} (100%)
 delete mode 100644 pc-bios/edk2-arm-code.fd.bz2
 delete mode 100644 pc-bios/edk2-i386-code.fd.bz2
 delete mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
 delete mode 100644 pc-bios/edk2-i386-vars.fd.bz2
 delete mode 100644 pc-bios/edk2-riscv-code.fd.bz2
 create mode 100644 pc-bios/edk2-riscv64-code.fd.bz2
 rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)
 create mode 100644 tests/data/acpi/loongarch64/virt/FPDT
 create mode 100644 tests/data/acpi/loongarch64/virt/FPDT.numamem

-- 
2.55.0


