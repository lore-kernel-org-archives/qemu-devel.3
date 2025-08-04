Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53BAC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uit9h-00014E-4o; Mon, 04 Aug 2025 07:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uiswT-0007Jj-1T
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uiswR-0008B5-7F
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754305276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=24BsnI92sCzfNsXmcE8BvZejdTYjGjp+NB17P28miPE=;
 b=YFUrlZwrTmUFWklH58DWZLff42uKm6yQufvOWGVwMnwwTS2Q7++vArCDazeBJlQWA58GBb
 zei8XhkHX3pnFh+lhJ/ctNx7KOv49V4KMWxQK/OjwSnrCXlQnbseWeR1L9CjgmlQRVVyEB
 JL3xnMv56/Kb+0XZ9PL0yP7vYxFpgQY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-NuIZ-nu6MESsOAGSGGG7ag-1; Mon,
 04 Aug 2025 07:01:14 -0400
X-MC-Unique: NuIZ-nu6MESsOAGSGGG7ag-1
X-Mimecast-MFC-AGG-ID: NuIZ-nu6MESsOAGSGGG7ag_1754305273
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C20B180010A; Mon,  4 Aug 2025 11:01:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.225])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFD6E1800359; Mon,  4 Aug 2025 11:01:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/4] aspeed queue
Date: Mon,  4 Aug 2025 13:01:04 +0200
Message-ID: <20250804110108.2414355-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit e5859141b9b6aec9e0a14dacedc9f02fe2f15844:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-08-01 10:46:00 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250804

for you to fetch changes up to 13ed972b4ce57198914a37217251d30fbec20e41:

  hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1030 (2025-08-04 09:07:38 +0200)

----------------------------------------------------------------
aspeed queue:

* Fixed vbootrom build under roms/
* Updated vbootrom image to 183c9ff805
* Fixed SMC model of AST1030 SoC

----------------------------------------------------------------
Cédric Le Goater (1):
      pc-bios: Update vbootrom image to commit 183c9ff8056b

Jamin Lin (1):
      hw/ssi/aspeed_smc: Fix incorrect FMC_WDT2 register read on AST1030

Michael Tokarev (2):
      roms/vbootrom: update to 7b1eb5f7fe6a
      roms/Makefile: build ast27x0_bootrom

 hw/ssi/aspeed_smc.c         |   3 ++-
 pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
 pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 672 bytes
 pc-bios/npcm8xx_bootrom.bin | Bin 608 -> 672 bytes
 roms/Makefile               |   5 +++++
 roms/vbootrom               |   2 +-
 6 files changed, 8 insertions(+), 2 deletions(-)


