Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C07EC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqApC-00042G-44; Mon, 16 Sep 2024 08:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqApA-00041m-6a
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sqAp7-0001eg-Mf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726489640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3i1dd6ktvYYkevcdNHmMula/5Q0lLSc5YDGl3U8/7gA=;
 b=Y0Ry6u5LAGt7GxFA4tm7JX0W1g7cAsOxkEqOBjuDibo0TEdlHabCMg2nYuu1Ln0/JNKF83
 CfcivDyxQSHNP39F5z20Q13xNM5oOqkMqQxNvkBjIFslCm18iQ4yq3h2Tk4KHl+9YN1r9W
 gOmGdP1/FeDFpPWJp2jWE0npKIpagYQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-DLl33aPiMLy34xmWPd_dlw-1; Mon,
 16 Sep 2024 08:26:08 -0400
X-MC-Unique: DLl33aPiMLy34xmWPd_dlw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D8FD19560A3; Mon, 16 Sep 2024 12:26:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEFB230001AB; Mon, 16 Sep 2024 12:26:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 977991801022; Mon, 16 Sep 2024 14:26:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 0/4] Edk2 stable202408 20240916 patches
Date: Mon, 16 Sep 2024 14:25:51 +0200
Message-ID: <20240916122603.71615-1-kraxel@redhat.com>
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

  https://gitlab.com/kraxel/qemu.git tags/edk2-stable202408-20240916-pull-request

for you to fetch changes up to 2b759fbc9a70258a244f98da3415947dccc2702e:

  add loongarch binaries for edk2-stable202408 (2024-09-16 14:21:34 +0200)

----------------------------------------------------------------
edk2: update to 2024-08 stable tag

----------------------------------------------------------------

Gerd Hoffmann (3):
  update submodule and version file to edk2-stable202408
  update binaries to edk2-stable202408
  add loongarch binaries for edk2-stable202408

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
 18 files changed, 53 insertions(+), 6 deletions(-)
 create mode 100644 pc-bios/descriptors/60-edk2-loongarch64.json
 create mode 100644 pc-bios/edk2-loongarch64-code.fd.bz2
 create mode 100644 pc-bios/edk2-loongarch64-vars.fd.bz2

-- 
2.46.0


