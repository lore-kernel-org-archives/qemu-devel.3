Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A94C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTi7-0006l2-C0; Tue, 17 Sep 2024 04:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqTi5-0006eA-L3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqTi3-0006Ci-Sp
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726562237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d27+m9HxI54mJv1SlKPh8x4FZEg5UbPMejlobzjxZno=;
 b=EQgNOVRusJdqH2gvS3hOJZ0oro0mOxxZwLVND2HB/gAc6W0lRGdwIqc+Hh9tcX6bL1M83m
 x/PFSJ2PFzgCHXBrpa9OHCtyRVTKJ6PkKhgGF+dyus8O4/d3+En67NvOqTB6BaSDMhq4oa
 3/3uAQtZOhx6COqOaqe/JLwuV5/MXd4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-Dp3CC_TxOxqpyMKY-de5sQ-1; Tue,
 17 Sep 2024 04:37:14 -0400
X-MC-Unique: Dp3CC_TxOxqpyMKY-de5sQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33BE31955F41; Tue, 17 Sep 2024 08:37:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A460330001A1; Tue, 17 Sep 2024 08:37:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6CC0818000A6; Tue, 17 Sep 2024 10:37:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/7] Edk2 stable202408 20240917 patches
Date: Tue, 17 Sep 2024 10:36:54 +0200
Message-ID: <20240917083709.571436-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a:

  Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into staging (2024-09-15 18:27:40 +0100)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/edk2-stable202408-20240917-pull-request

for you to fetch changes up to 265c40becab72485caa1f4b1911ce96a98657f84:

  tests/acpi: disallow acpi test data updates (2024-09-17 10:26:27 +0200)

----------------------------------------------------------------
edk2: update to 2024-08 stable tag.
acpi: update test data (address changed due to firmware size change).

----------------------------------------------------------------

Gerd Hoffmann (6):
  tests/acpi: allow acpi test data updates
  update submodule and version file to edk2-stable202408
  update binaries to edk2-stable202408
  add loongarch binaries for edk2-stable202408
  tests/acpi: update aarch64/virt/SSDT.memhp
  tests/acpi: disallow acpi test data updates

Xianglai Li (1):
  roms: Support compile the efi bios for loongarch

 docs/system/loongarch/virt.rst               |   2 +-
 meson.build                                  |   2 +-
 pc-bios/descriptors/60-edk2-loongarch64.json |  31 +++++++++++++++++++
 pc-bios/descriptors/meson.build              |   3 +-
 pc-bios/edk2-aarch64-code.fd.bz2             | Bin 1588976 -> 1565763 bytes
 pc-bios/edk2-arm-code.fd.bz2                 | Bin 1571639 -> 1570311 bytes
 pc-bios/edk2-i386-code.fd.bz2                | Bin 1775230 -> 1780004 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2         | Bin 1877268 -> 1858666 bytes
 pc-bios/edk2-loongarch64-code.fd.bz2         | Bin 0 -> 1148383 bytes
 pc-bios/edk2-loongarch64-vars.fd.bz2         | Bin 0 -> 233 bytes
 pc-bios/edk2-riscv-code.fd.bz2               | Bin 1289337 -> 1296526 bytes
 pc-bios/edk2-x86_64-code.fd.bz2              | Bin 1892766 -> 1907255 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2           | Bin 1785290 -> 1787244 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2       | Bin 1969096 -> 1962992 bytes
 pc-bios/meson.build                          |   2 ++
 roms/edk2                                    |   2 +-
 roms/edk2-build.config                       |  13 ++++++++
 roms/edk2-version                            |   4 +--
 tests/data/acpi/aarch64/virt/SSDT.memhp      | Bin 1817 -> 1817 bytes
 19 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 pc-bios/descriptors/60-edk2-loongarch64.json
 create mode 100644 pc-bios/edk2-loongarch64-code.fd.bz2
 create mode 100644 pc-bios/edk2-loongarch64-vars.fd.bz2

-- 
2.46.0


