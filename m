Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133EBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59d-0006Vu-LV; Tue, 07 Jul 2026 08:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59b-0006VR-D3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59Z-0005Ca-Oc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gGX4A9ONGwZ61jcE0aXFBssiB1fFCTjagTujIyfQdIo=;
 b=jIY7nn//8YnGzGMMLkBWJTHaVPMUinmzu0NuyDOF7gluBfHTfETEgWbr/6Q44nRrM6IKo0
 SC04eir2xfQMeOtIU57Ib1QftdHb+sQXkW+xs/BnpST68jKGSc1U9oVNPr+dvzg8/GAyz/
 AiXxbSf04TLrdDLXP+WuEhD/wlszNAI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-dHyIgM-LNAG-6_2DuKlo9w-1; Tue,
 07 Jul 2026 08:43:54 -0400
X-MC-Unique: dHyIgM-LNAG-6_2DuKlo9w-1
X-Mimecast-MFC-AGG-ID: dHyIgM-LNAG-6_2DuKlo9w_1783428233
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7CFB1954193; Tue,  7 Jul 2026 12:43:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 42A2B36925; Tue,  7 Jul 2026 12:43:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/8] aspeed queue
Date: Tue,  7 Jul 2026 14:43:41 +0200
Message-ID: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c348:

  Merge tag 'accel-20260706' of https://github.com/philmd/qemu into staging (2026-07-06 18:38:14 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260707

for you to fetch changes up to 21eac78874d3404cb26c83f261af25e0cdcb9686:

  hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions for SSP/TSP (2026-07-07 14:28:55 +0200)

----------------------------------------------------------------
aspeed queue :

* Fix stale pending interrupts in INTC for level-triggered sources
* Fix intermittent functional test timeouts on boot completion detection
* Fix off-by-one in pca9552 QOM led index validation
* Fix AST2700 FC machine hardware strap settings
* Drop noisy unhandled read logs for AST2700 SCU/SCUIO
* Add SCUIO RNG support for AST2700
* Add unimplemented Privilege Controller and OTP MMIO regions for SSP/TSP

----------------------------------------------------------------
Cédric Le Goater (1):
      tests/functional/aspeed: unify boot completion detection on 'login:' prompt

Jamin Lin (5):
      hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings
      hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700 SCU/SCUIO
      hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers
      hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO regions for SSP/TSP
      hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions for SSP/TSP

Jian Zhang (1):
      hw/intc/aspeed: Drop stale pending interrupts

yujun (1):
      hw/gpio/pca9552: fix off-by-one in QOM led index validation

 include/hw/arm/aspeed_coprocessor.h              |  2 ++
 include/hw/arm/aspeed_soc.h                      |  3 +++
 hw/arm/aspeed_ast27x0-fc.c                       |  6 +++--
 hw/arm/aspeed_ast27x0-ssp.c                      | 18 +++++++++++++
 hw/arm/aspeed_ast27x0-tsp.c                      | 18 +++++++++++++
 hw/gpio/pca9552.c                                |  8 +++---
 hw/intc/aspeed_intc.c                            | 25 ++++++++++++++++++
 hw/misc/aspeed_scu.c                             | 33 ++++++++++++++++--------
 tests/functional/arm/test_aspeed_anacapa.py      |  6 ++---
 tests/functional/arm/test_aspeed_bletchley.py    |  6 ++---
 tests/functional/arm/test_aspeed_catalina.py     |  6 ++---
 tests/functional/arm/test_aspeed_gb200nvl_bmc.py |  3 +--
 tests/functional/aspeed.py                       | 21 +++------------
 13 files changed, 110 insertions(+), 45 deletions(-)


