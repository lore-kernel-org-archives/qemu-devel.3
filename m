Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA3ACCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68WX-000536-ST; Tue, 07 Oct 2025 10:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v68Ut-00028O-Ij
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v68Un-0003Rb-7J
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759846609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPJhVEu/igzVJ4dMMXivgTnMRnxxNp2t7DwfP04fAaQ=;
 b=JJUM8brKEjQLtRiQX8/FM6MFaGGxH3pfAunyMuhKVJfwHqZ4hH3wPC32LJqnJNcsd4JR5Z
 paMxzpqRUBjf5atRo/OIyfVbldkE9r66ZDzp99jFe2yXQCmvCHU/tlTscUPWnDIXjWwAF7
 iawvM7PLkmzhg5luIu1c4QcQJ9R7Fjs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-c8tWOOzINg-mkyb4aFyeMQ-1; Tue,
 07 Oct 2025 10:16:45 -0400
X-MC-Unique: c8tWOOzINg-mkyb4aFyeMQ-1
X-Mimecast-MFC-AGG-ID: c8tWOOzINg-mkyb4aFyeMQ_1759846593
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E46F51954B24; Tue,  7 Oct 2025 14:16:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF03F19560B8; Tue,  7 Oct 2025 14:16:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Wang <wangzq.jn@gmail.com>
Subject: [PATCH 3/5] aspeed: Deprecate the fp5280g2-bmc machine
Date: Tue,  7 Oct 2025 16:16:02 +0200
Message-ID: <20251007141604.761686-4-clg@redhat.com>
In-Reply-To: <20251007141604.761686-1-clg@redhat.com>
References: <20251007141604.761686-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There are no functional tests for the 'fp5280g2-bmc' machine which
makes harder to determine when something becomes deprecated or unused.

Since the machine does not rely on any specific device models, it can
be replaced by the 'ast2500-evb' machine using the 'fmc-model' option
to specify the flash type. The I2C devices connected to the board can
be defined via the QEMU command line.

Cc: John Wang <wangzq.jn@gmail.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/arm/aspeed.c           | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f6410037ead2..98361f5832dc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -304,6 +304,14 @@ machine using the ``fmc-model`` option to specify the flash type. The
 I2C devices connected to the board can be defined via the QEMU command
 line.
 
+Arm ``fp5280g2-bmc`` machine (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
+
+The ``fp5280g2-bmc`` machine does not rely on any specific device
+models, it can be replaced by the ``ast2500-evb`` machine using the
+``fmc-model`` option to specify the flash type. The I2C devices
+connected to the board can be defined via the QEMU command line.
+
 RISC-V default machine option (since 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 0707a760fda6..e73185eeb35c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1626,6 +1626,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->desc       = "Inspur FP5280G2 BMC (ARM1176)";
+    mc->deprecation_reason = "use 'ast2500-evb' instead";
     amc->soc_name  = "ast2500-a1";
     amc->hw_strap1 = FP5280G2_BMC_HW_STRAP1;
     amc->fmc_model = "n25q512a";
-- 
2.51.0


