Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB763C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmq4g-0005BT-J1; Wed, 20 Mar 2024 03:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmq4d-0005Ay-SA
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:09:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmq4c-000736-5a
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710918557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QewaxpjhlPhqABmE4vjjO119Hp2LR1bEu5oVOQyA9aI=;
 b=JytaDbAqBESKeOVi5aKIg5iX2h/AZvXgtek0pVre59DtyjonFLgvdzCqPakU0IMYjdo9U2
 PYdOU6ERJjbXnJAlMrFcEUD0D5qplFtLPF8LHj8RToQew8wJqqSR4AWATwjyNRD+ViYP71
 vjfajsKZjIpHaKVv/h9jxqsblz3LD7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-SyskY3eFMfm4UaeDli1pjg-1; Wed, 20 Mar 2024 03:09:13 -0400
X-MC-Unique: SyskY3eFMfm4UaeDli1pjg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0464E89F9ED;
 Wed, 20 Mar 2024 07:09:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE203C21;
 Wed, 20 Mar 2024 07:09:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8B4891800D4F; Wed, 20 Mar 2024 08:08:51 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/5] Edk2 20240320 patches
Date: Wed, 20 Mar 2024 08:08:43 +0100
Message-ID: <20240320070851.18933-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

  https://gitlab.com/kraxel/qemu.git tags/edk2-20240320-pull-request

for you to fetch changes up to 4a1babe58a1b3cd2c493ee6e0d774e70f62ad9c3:

  update edk2 binaries for arm, risc-v and x86 secure boot. (2024-03-19 16:42:10 +0100)

----------------------------------------------------------------
edk2: cleanup fix, update build config, rebuild binaries.

----------------------------------------------------------------

Gerd Hoffmann (5):
  roms/efi: clean up edk2 build config
  roms/efi: drop workaround for edk2-stable202308
  roms/efi: exclude efi shell from secure boot builds
  roms/efi: use pure 64-bit build for edk2-x86_64-secure-code.fd
  update edk2 binaries for arm, risc-v and x86 secure boot.

 pc-bios/edk2-aarch64-code.fd.bz2     | Bin 1589320 -> 1589310 bytes
 pc-bios/edk2-arm-code.fd.bz2         | Bin 1571418 -> 1571693 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2 | Bin 2130741 -> 1876986 bytes
 pc-bios/edk2-riscv-code.fd.bz2       | Bin 1345420 -> 1289160 bytes
 roms/Makefile                        |   1 +
 roms/edk2-build.config               |  13 ++++---------
 6 files changed, 5 insertions(+), 9 deletions(-)

-- 
2.44.0


