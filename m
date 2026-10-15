Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23CFCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKU1-0006nl-8l; Thu, 15 Oct 2026 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTe-0006H6-MF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTc-0005e2-Mw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxlJtqmlJvIWo994dWX3nFn/piew3FHGHM33tiIRTdI=;
 b=Y0yb/+zAe9XlPpmkz0aElOLWVhQ/Cq38joojjO0Fz8PgmWH4kH1YccWM5iYcsix1EV7zrV
 +gDMTuxy2cTE+Ivj8Om5VJQTNW954i4N8vZsXmRI0YQkZsNjfuZLdh+xAN8ZtpBIE9dD1g
 5gPd0tZ0dxVb/6Zwr8Byq3OzwDOxzQg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661--0Jaii1oPcuvzwXwqu9wug-1; Thu,
 15 Oct 2026 12:22:26 +0000
X-MC-Unique: -0Jaii1oPcuvzwXwqu9wug-1
X-Mimecast-MFC-AGG-ID: -0Jaii1oPcuvzwXwqu9wug_1792066945
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 898E61955F78; Thu, 15 Oct 2026 12:22:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2B8A7D5; Thu, 15 Oct 2026 12:22:23 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 15/21] hw/arm/aspeed: Remove unused unimplemented device fields
Date: Thu, 15 Oct 2026 14:21:45 +0200
Message-ID: <20261015122151.889017-16-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

All Aspeed SoCs now use the unimp_devs table and
create_unimplemented_devices() for their unimplemented devices. Remove
the old fields in AspeedSoCState and the ASPEED_JTAG_NUM define, which
are not used anymore.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 82e394f08539..b47ac5aa05b5 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -59,7 +59,6 @@
 #define ASPEED_CPUS_NUM  4
 #define ASPEED_MACS_NUM  4
 #define ASPEED_UARTS_NUM 13
-#define ASPEED_JTAG_NUM  2
 #define ASPEED_PCIE_NUM  3
 #define ASPEED_INTC_NUM  2
 #define ASPEED_IOEXP_NUM 2
@@ -110,15 +109,6 @@ struct AspeedSoCState {
     AspeedPECIState peci;
     SerialMM uart[ASPEED_UARTS_NUM];
     Clock *sysclk;
-    UnimplementedDeviceState iomem;
-    UnimplementedDeviceState iomem0;
-    UnimplementedDeviceState iomem1;
-    UnimplementedDeviceState video;
-    UnimplementedDeviceState emmc_boot_controller;
-    UnimplementedDeviceState dpmcu;
-    UnimplementedDeviceState espi;
-    UnimplementedDeviceState udc;
-    UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
     AspeedAPB2OPBState fsi[2];
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
     AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
-- 
2.56.0


