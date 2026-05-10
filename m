Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9862ECD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM7T4-0007fr-AB; Sun, 10 May 2026 12:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM7T2-0007cm-5b
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM7Sz-0008HM-Ds
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778432240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NnLuL9JQMjwa2QSUjdu7GpfrvD6fQZoa5KDplwl97Ys=;
 b=fz8OXv7dvGT3DQovwmUXase1wazjE8lGdsCfNz0OcYS6PkpKgWGSZciKP989oxKrRGcCvA
 YD6cXKvAZeJokaplz8y5XhDh1lL+91KdBjjrl8JVYrMoZc/mbg0rs1afnYwHkS2oVl3HtX
 t7GLo37FqeefvSoU2L/VKJ0ycR4imos=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-eWp5oCh1PfuDiZaJw7TG7w-1; Sun,
 10 May 2026 12:57:16 -0400
X-MC-Unique: eWp5oCh1PfuDiZaJw7TG7w-1
X-Mimecast-MFC-AGG-ID: eWp5oCh1PfuDiZaJw7TG7w_1778432234
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66B701800344; Sun, 10 May 2026 16:57:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.49.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3B6E180034E; Sun, 10 May 2026 16:57:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 pierrick.bouvier@oss.qualcomm.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/4] hw/arm: Remove deprecated Aspeed machines
Date: Sun, 10 May 2026 18:57:00 +0200
Message-ID: <20260510165704.2935316-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

Four Aspeed machines were deprecated in QEMU 10.2. This series
schedules their removal in the QEMU 11.1 cycle.

 - fby35: Multi-SoC machine replaced by ast2700fc
 - fp5280g2-bmc: Inspur FP5280G2, no specific dependencies
 - qcom-dc-scm-v1-bmc/qcom-firework-bmc: Qualcomm lab servers
 - sonorapass-bmc: OCP SonoraPass lab server

Thanks,

C. 

Cédric Le Goater (4):
  hw/arm: Remove sonorapass-bmc machine
  hw/arm: Remove qcom-dc-scm-v1-bmc and qcom-firework-bmc machines
  hw/arm: Remove fp5280g2-bmc machine
  hw/arm: Remove fby35 machine

 MAINTAINERS                            |   2 -
 docs/about/deprecated.rst              |  37 -----
 docs/about/removed-features.rst        |  38 ++++-
 docs/system/arm/aspeed.rst             |   8 +-
 docs/system/arm/fby35.rst              |  52 -------
 docs/system/target-arm.rst             |   1 -
 hw/arm/aspeed_ast2500_fp5280g2.c       |  88 -----------
 hw/arm/aspeed_ast2500_sonorapass.c     | 102 -------------
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c |  55 -------
 hw/arm/aspeed_ast2600_qcom-firework.c  |  91 -----------
 hw/arm/fby35.c                         | 203 -------------------------
 hw/arm/meson.build                     |   7 +-
 12 files changed, 40 insertions(+), 644 deletions(-)
 delete mode 100644 docs/system/arm/fby35.rst
 delete mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
 delete mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
 delete mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
 delete mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
 delete mode 100644 hw/arm/fby35.c

-- 
2.54.0


