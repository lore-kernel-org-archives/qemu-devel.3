Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C6FF46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25NX-00068L-Te; Mon, 16 Mar 2026 06:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25NT-00067x-R0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w25NQ-0003O5-NV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773657647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4rDGMOd7CYN61Ozt/m2b4vzeiVOzhAz9GiFTaB0LBjc=;
 b=FGYSx++75w3lOHxtPnMNvtb0uOxh0OeRd5OZC9on8AvM9u2NqoXz1ueIGM1R9gZOQ5jCFp
 8RrtKwR7RzY/z0wNKL2n78DSHAzT3hr0RGaXTDzempSqGl1BqKQU46EldIdvYfk3ZXhLOe
 NfedB47gP1rolg3+ops4YZYoap+kkzA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-rd_XLaXeMc-Dan3EiOHfFQ-1; Mon,
 16 Mar 2026 06:40:44 -0400
X-MC-Unique: rd_XLaXeMc-Dan3EiOHfFQ-1
X-Mimecast-MFC-AGG-ID: rd_XLaXeMc-Dan3EiOHfFQ_1773657643
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 174E4180035C; Mon, 16 Mar 2026 10:40:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E9D119560AB; Mon, 16 Mar 2026 10:40:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/14] Fixes for "-device xyz,help" and updates to MAINTAINERS
Date: Mon, 16 Mar 2026 11:40:25 +0100
Message-ID: <20260316104039.195960-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-16

for you to fetch changes up to bc4ee6025a71290eb47d86c2c77eb1f40fbb6305:

  MAINTAINERS: Add another reviewer to s390x boot (2026-03-16 11:36:32 +0100)

----------------------------------------------------------------
* Fix various crashes that can occur when starting QEMU with -device xyz,help
* Update various sections in the MAINTAINERS file

----------------------------------------------------------------
Alistair Francis (7):
      hw/riscv: sifive_e: Don't call qdev_get_machine in soc init
      hw/riscv: microchip_pfsoc: Don't call qdev_get_machine in soc init
      hw/arm: xlnx-zynqmp: Don't call qdev_get_machine in soc init
      hw/arm: fsl-imx7: Don't call qdev_get_machine in soc init
      hw/arm: fsl-imx8mp: Don't call qdev_get_machine in soc init
      hw/arm: fsl-imx6: Don't call qdev_get_machine in soc init
      hw/acpi: generic_event_device: Don't call qdev_get_machine in initfn

Eric Farman (1):
      MAINTAINERS: Add another reviewer to s390x boot

Jared Rossi (1):
      MAINTAINERS: Update S390-ccw boot maintainers/reviewers

Thomas Huth (5):
      target/xtensa/cpu: Move initialization of memory region to realize function
      target/mips/cpu: Move initialization of memory region to realize function
      MAINTAINERS: Update the s390x maintainers
      MAINTAINERS: Remove myself from various sections
      MAINTAINERS: Downgrade the functional testing section to "Odd Fixes"

 MAINTAINERS                    | 17 ++++++++---------
 hw/acpi/generic_event_device.c |  5 +++--
 hw/arm/fsl-imx6.c              | 14 +++++++-------
 hw/arm/fsl-imx7.c              | 19 +++++++++----------
 hw/arm/fsl-imx8mp.c            | 13 ++++++-------
 hw/arm/xlnx-zynqmp.c           | 42 ++++++++++++++++++------------------------
 hw/riscv/microchip_pfsoc.c     |  7 +++++--
 hw/riscv/sifive_e.c            |  9 ++++++---
 target/mips/cpu.c              | 16 ++++++++--------
 target/xtensa/cpu.c            | 14 ++++++++------
 10 files changed, 78 insertions(+), 78 deletions(-)


