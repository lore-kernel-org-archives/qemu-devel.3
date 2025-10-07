Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51126CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68VJ-0002VB-Ub; Tue, 07 Oct 2025 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v68Uf-000249-Gv
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v68Ua-0003PN-KP
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759846598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3quiFgIla2njN+Wx4krX3jwOSMURvXmNv4PTCmYN6E=;
 b=Jo3bGBHNsvSzIhNI9wniEd7wiQBP52xnlBDVF9quZNoQOMockEwOlrHYlDYm+W+Rev/dIN
 7mOevdtTKbquPz0LY04tVC6tYkj5AJczo69JgcuWP3w14y7nSvOGehQEsngRdlTB/sDP1z
 oZl5oRZyVnG9rjZpnM8UZnHZKz4NHmE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-9oI0KsKQMHC0ZdDHT8IQfg-1; Tue,
 07 Oct 2025 10:16:27 -0400
X-MC-Unique: 9oI0KsKQMHC0ZdDHT8IQfg-1
X-Mimecast-MFC-AGG-ID: 9oI0KsKQMHC0ZdDHT8IQfg_1759846577
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A001800583; Tue,  7 Oct 2025 14:16:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EA9419560B1; Tue,  7 Oct 2025 14:16:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Patrick Williams <patrick@stwcx.xyz>
Subject: [PATCH 1/5] aspeed: Deprecate the sonorapass-bmc machine
Date: Tue,  7 Oct 2025 16:16:00 +0200
Message-ID: <20251007141604.761686-2-clg@redhat.com>
In-Reply-To: <20251007141604.761686-1-clg@redhat.com>
References: <20251007141604.761686-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The 'sonorapass-bmc' machine represents a lab server that never
entered production. There are no functional tests for this machine
which makes harder to determine when something becomes deprecated or
unused.

Since the machine does not rely on any specific device models, it can
be replaced by the 'ast2500-evb' machine using the 'fmc-model' option
to specify the flash type. The I2C devices connected to the board can
be defined via the QEMU command line.

Cc: Patrick Williams <patrick@stwcx.xyz>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 hw/arm/aspeed.c           | 1 +
 2 files changed, 10 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 67e527740c0e..ce8fe9ac1be7 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -285,6 +285,15 @@ and serves as the initial engineering sample rather than a production version.
 A newer revision, A1, is now supported, and the ``ast2700a1-evb`` should
 replace the older A0 version.
 
+Arm ``sonorapass-bmc`` machine (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
+
+The ``sonorapass-bmc`` machine represents a lab server that never
+entered production. Since it does not rely on any specific device
+models, it can be replaced by the ``ast2500-evb`` machine using the
+``fmc-model`` option to specify the flash type. The I2C devices
+connected to the board can be defined via the QEMU command line.
+
 RISC-V default machine option (since 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 58cfbc713794..d3a0c81f454f 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1552,6 +1552,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->desc       = "OCP SonoraPass BMC (ARM1176)";
+    mc->deprecation_reason = "use 'ast2500-evb' instead";
     amc->soc_name  = "ast2500-a1";
     amc->hw_strap1 = SONORAPASS_BMC_HW_STRAP1;
     amc->fmc_model = "mx66l1g45g";
-- 
2.51.0


