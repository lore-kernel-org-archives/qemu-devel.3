Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03779CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqgI-0006l1-E7; Tue, 12 May 2026 13:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgG-0006kY-EI
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wMqgE-0000Uf-CB
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778606040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IXZl4+el3U45wzoniBy4Y0PcB6SM7D39/gBXfaMLYs8=;
 b=XKSdVLnJTYBoC361/lVwESbhLqWSaaskUqbfsceClJ9HXEfWDDI0oOvnMUy0K6VcxM911H
 CKCsRpBzFg1HyoBQBpPKkILl7sEK12mVoAwlPADVELQp3J9Q0dDQaONmFwHFhtioCM3J5h
 ODob+1DgQWyq/YI9pKvzzQOhzOphgS0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-QNogF-NsMWq1f5FQacf9gg-1; Tue,
 12 May 2026 13:13:59 -0400
X-MC-Unique: QNogF-NsMWq1f5FQacf9gg-1
X-Mimecast-MFC-AGG-ID: QNogF-NsMWq1f5FQacf9gg_1778606038
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32E5F19560BB; Tue, 12 May 2026 17:13:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC83B1955D84; Tue, 12 May 2026 17:13:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/9] aspeed queue
Date: Tue, 12 May 2026 19:13:45 +0200
Message-ID: <20260512171354.4183887-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260512

for you to fetch changes up to 04d249d1efbbecc74eb82d26558c78d5a3b43630:

  hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly during ENTDAA (2026-05-12 09:36:23 +0200)

----------------------------------------------------------------
aspeed queue:

* Security fixes for HACE hash engine and SBC OTP controller
* Bug fix of the I3C controller
* Removal of BMC machines (fby35, fp5280g2-bmc, qcom-*, sonorapass-bmc)
  deprecated in QEMU 10.2

----------------------------------------------------------------
Ashish Anand (1):
      hw/i3c/dw-i3c: Fix BCR/DCR extraction and PID assembly during ENTDAA

Cédric Le Goater (6):
      aspeed/hace: Fix out-of-bounds read in has_padding()
      aspeed/hace: Prevent total_req_len overflow
      hw/arm: Remove sonorapass-bmc machine
      hw/arm: Remove qcom-dc-scm-v1-bmc and qcom-firework-bmc machines
      hw/arm: Remove fp5280g2-bmc machine
      hw/arm: Remove fby35 machine

Kane Chen (2):
      hw/misc/aspeed_sbc: Add bounds checking for OTP write operations
      aspeed/hace: Fix mapped address may not be unmapped issue

 MAINTAINERS                            |   2 -
 docs/about/deprecated.rst              |  37 ------
 docs/about/removed-features.rst        |  38 +++++-
 docs/system/arm/aspeed.rst             |   8 +-
 docs/system/arm/fby35.rst              |  52 ---------
 docs/system/target-arm.rst             |   1 -
 include/hw/i3c/i3c.h                   |   7 ++
 hw/arm/aspeed_ast2500_fp5280g2.c       |  88 --------------
 hw/arm/aspeed_ast2500_sonorapass.c     | 102 -----------------
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c |  55 ---------
 hw/arm/aspeed_ast2600_qcom-firework.c  |  91 ---------------
 hw/arm/fby35.c                         | 203 ---------------------------------
 hw/i3c/dw-i3c.c                        |  16 ++-
 hw/misc/aspeed_hace.c                  |  90 ++++++++++++---
 hw/misc/aspeed_sbc.c                   |  12 +-
 hw/nvram/aspeed_otp.c                  |  13 +--
 hw/arm/meson.build                     |   7 +-
 17 files changed, 141 insertions(+), 681 deletions(-)
 delete mode 100644 docs/system/arm/fby35.rst
 delete mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
 delete mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
 delete mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
 delete mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
 delete mode 100644 hw/arm/fby35.c


