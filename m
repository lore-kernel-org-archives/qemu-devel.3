Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2456ED10F21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 10:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOChY-0000bW-5w; Wed, 26 Nov 2025 05:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOChV-0000Uh-Vi
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vOChT-0007Q3-Rm
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 05:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764152677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8TFHfLxt0l7Mis2RL6FA0GuV7ceROu408690ZvcjgRw=;
 b=fAJsu8rM5+hgt1GOq+Lb8tMu9OzH9U5RBwzBrnkZkTg6v0XUBSr8xi0oiuvtWTGOnCwTGY
 xhEQAbQQttElpI/TvyncPAb7rMEcJl3JYuE3nylYKXQ0WFT9y0c5XhJIO7uOGMXDdB13H/
 aue71+56lB2zn/cGu9WR60GN8eU1dlw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-5f2dAjnMMx67kV2UPKWvJg-1; Wed,
 26 Nov 2025 05:24:34 -0500
X-MC-Unique: 5f2dAjnMMx67kV2UPKWvJg-1
X-Mimecast-MFC-AGG-ID: 5f2dAjnMMx67kV2UPKWvJg_1764152673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ECB31954B0B; Wed, 26 Nov 2025 10:24:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.214])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFA7219560A2; Wed, 26 Nov 2025 10:24:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Delevoryas <peter@pjd.dev>
Subject: [PATCH] aspeed: Deprecate the fby35 machine
Date: Wed, 26 Nov 2025 11:24:24 +0100
Message-ID: <20251126102424.927527-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

There are no functional tests for the 'fby35' machine which makes
harder to determine when something becomes deprecated or unused.

The 'fby35' machine was originally added as an example of a multi-SoC
system, with the expectation the models would evolve over time in an
heterogeneous system. This hasn't happened and no public firmware is
available to boot it. It can be replaced by the 'ast2700fc', another
multi-SoC machine based on the newer AST2700 SoCs which are excepted
to receive better support in the future.

Cc: Peter Delevoryas <peter@pjd.dev>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 13 ++++++++++++-
 hw/arm/fby35.c            |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 9386cffba26d..ac31a2bce427 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -308,13 +308,24 @@ I2C devices connected to the board can be defined via the QEMU command
 line.
 
 Arm ``fp5280g2-bmc`` machine (since 10.2)
-'''''''''''''''''''''''''''''''''''''''''''
+'''''''''''''''''''''''''''''''''''''''''
 
 The ``fp5280g2-bmc`` machine does not rely on any specific device
 models, it can be replaced by the ``ast2500-evb`` machine using the
 ``fmc-model`` option to specify the flash type. The I2C devices
 connected to the board can be defined via the QEMU command line.
 
+Arm ``fby35`` machine (since 10.2)
+''''''''''''''''''''''''''''''''''
+
+The ``fby35`` machine was originally added as an example of a
+multi-SoC system, with the expectation the models would evolve over
+time in an heterogeneous system. This hasn't happened and no public
+firmware is available to boot it. It can be replaced by the
+``ast2700fc``, another multi-SoC machine based on the newer AST2700
+SoCs which are excepted to receive better support in the future.
+
+
 RISC-V default machine option (since 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 70d3a99d79e8..e61a6438fefa 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -175,6 +175,7 @@ static void fby35_class_init(ObjectClass *oc, const void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Meta Platforms fby35";
+    mc->deprecation_reason = "For a multi-soc machine, use 'ast2700fc' instead";
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-- 
2.51.1


