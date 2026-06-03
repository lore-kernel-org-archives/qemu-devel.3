Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A67CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfF4-00009J-FC; Wed, 03 Jun 2026 02:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfF3-00008K-0b; Wed, 03 Jun 2026 02:38:17 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wUfF0-0008HM-9z; Wed, 03 Jun 2026 02:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpco4KNHZ9LazJHxjrbTsxg8n+oywHV467hhLsZPiiscQxGu205tMWE+u4C8n1jw+nJMc3opdCnIFgSJ2NIxiKVu3Mru/qVJAuIlEcNEfKRMvQxoi1AVJkxSF6LK0Ny4LPQk03cNdGPJvfOyF51ILqf6q18Ad8Fu0Yfu7cPDNtAAiJHb+4lt+UAuEFt9Fkhwa9RQ3dNB2HxtZJfeqsLL4nkfYzW4psajmUzrPvo0rW92PJu2fqd1Lf3t2L+c+QcK8hK5V/fhYmnWIEdR5/GFMvBId72f2v1otdPFBOML74kZoEonh5AnHzG2lM51l4eamId3VWJzmxc+kM3lffSIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfmzFh+8mkKZMhd9TBqC7CdNLesi+xSQeqfY2iSj32U=;
 b=Og5eLRatwTcO7dAYxcm54r54FAj0O/r3rgbW5lgRmrr95cNlvTPugjFJ6LKBytDzqho6wJT1PwWllK5cbTEk3STqSBmnSRSEXOZIxXhKu8cSMfh+rP9eSCWVK4prS4XGbGrLQuQA1d13TWN8nTvG5TrQ2rQFiCDSRr7WetigrjbRFQPZ+BsRQZDiuxgFA3MxCmO4vdqhOZIQuErNLgUQjXoqFi2BexQMzySGgXOhDyQTJXUsfwMRUgJWw35/s/bcmFFAt42JfkmHhynDaYfY5xO12kQMivfJWffU50IRiaLOChwdilNFUtH/3TbGyo982w7fdT+nJQAExghg8oPpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfmzFh+8mkKZMhd9TBqC7CdNLesi+xSQeqfY2iSj32U=;
 b=V2DvNUeDNIDp9veAtbMg9gT1Oo0pUKtdRSg9xBuy6r5xKZ8kdahkfuKF2aihA63jfJDISzyFyVpqAUJ2LAW2jZKUIVBbYqOVSLgKVKLlW3jHbrq2VBtHfnHlx0SIpn45S1IBQY94+cAXXpAGDMDVrKQQm4qKdA2Z8EvurNXdYCuxR2nxFMPJPGxnsTfExQBuyxfRUdlHwrRvPUq9i9cmbEMNTNTM5Bh8Cc+WxXDOTgl3yRCI5W4z46G/f1GZNwgfD4cMoyy0Y+iYOdqvhQRVqoZPW1X9z/NSfJNhWUkBodxbRjLBsLb85UG5z3a1r/kC/86d9ZhU1VmxaiJLx0oZgA==
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com (2603:1096:400:129::9)
 by SEYPR06MB5859.apcprd06.prod.outlook.com (2603:1096:101:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:38:01 +0000
Received: from TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995]) by TYZPR06MB4746.apcprd06.prod.outlook.com
 ([fe80::b6d5:b318:c4a6:d995%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:38:00 +0000
From: Steven Lee <steven_lee@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "longzl2@lenovo.com"
 <longzl2@lenovo.com>, Yunlin Tang <yunlin.tang@aspeedtech.com>
Subject: [RESEND PATCH 2/6] hw/misc: Add ASPEED Caliptra mailbox frontend
Thread-Topic: [RESEND PATCH 2/6] hw/misc: Add ASPEED Caliptra mailbox frontend
Thread-Index: AQHc8yOF8h7ze7L5ZkuRlaiJfE4lSA==
Date: Wed, 3 Jun 2026 06:38:00 +0000
Message-ID: <20260603063756.1481524-3-steven_lee@aspeedtech.com>
References: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
In-Reply-To: <20260603063756.1481524-1-steven_lee@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4746:EE_|SEYPR06MB5859:EE_
x-ms-office365-filtering-correlation-id: 0ea39cc6-47a8-4c2f-935b-08dec13aa847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|6133799003|3023799007|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: hGrO4pdCIL4ZZok/9nsJtPiHdxT85ogEyanbn9SOc42IXpYQAR+dl2dbduJgXbXDuoNEbyVi1lBDoeZ2A8LRZNtYRKSL+qnIEhZn2sWAUQb0r6d2aiv3GlfsmbojLwI5rvKcy5yZHLPyQcpcUClH4Oa8swqZ3uYqBniXsfYQOE498fx8eeY/HZB1DSImt8iu3EjHD3P+xDdmThTw3pqENmC/3Ky+POKlFkbM/MsK1Sqm+LdLJVUAXWleH5ARPGiP9vG5t41L0CMDMN+KjpA86pRDASNKC+2v9+IUr3R0PuDNddGt9p4lew19GDQMGqQpZEvp43MAwwZxloiePCHTq8yO8vaHWOHvBlHwz+Q3kLv9DHK9TDPLNyHZp/bl59EvJXswuWkUQOKcEeM15GnfDeGojsPNPxH/WhVv7oT776h6V5kpLdJCpeDiTL4JOgH/ZGKw54sd2NcnelfZh5JY0AQ9vQ2mh//KvgxlhpeQGvQKQzanszJNqpc2cA8SLraio0UDEZr4En0kTauV4ipW1UkyQbNwWGUhmIhdNVocgiuuYe78tSbFs6fc4SD/AZmIoTot2e/LFunispVPfQKtMn0vCUS2H/QnR5QRhdfyZ1EtOeL/R2Wa9AKdYPNNUybIRPXaMjGXOTmoHcklSYuDH5A/K+6Ng+tfnBcbo8RzYAAqGKUhxtJ3kQU6zrxhRi1PaTHiQ42wyQABAAzpG5rVpp1QMHJVxWwXOcQjCPQAKfGIrMmFD+BhXIZ/K3A4mxVchcETGv5LmFNLdwSXLAEn9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4746.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0unYaqkrALPSGd9xLHUHVKr05Aw0XFM7B2Kj4CL2vL1lo1f3z/ygGBhMzu?=
 =?iso-8859-1?Q?vJiMLa5S/pwpFTvgqC2UJBLAw1V67YrtvRhPSP142PxBZOFVTfTb8H2/vL?=
 =?iso-8859-1?Q?EU9ereE1D0g9HtB+Xce+XwMLhrs525KphNOFsGEAmNW0TSXDKHasPOxgK/?=
 =?iso-8859-1?Q?GN26oqLg8kFySSkH8VUc3j1FMZnyukeuMjRUsc1dnP/d9X4TVfYy9hhcHk?=
 =?iso-8859-1?Q?GyovTFjQPsLXVLWlAveqW0PGyjnd1cFHx8X4fkpc67wrBo4nelPBB7/kd+?=
 =?iso-8859-1?Q?IQ7E0kRwLj9evMnnO3JQr5sp4MayQYQHxgcD82GOB4Ih8jorFBe4RFl2r8?=
 =?iso-8859-1?Q?xbCdDz/eLl+EClkQkVreYtYbl1U8UUND5ys7n/RXgdU/TvWZVICJnyB1RT?=
 =?iso-8859-1?Q?XJjYk9zhu/onMYgz3maWKhPSFTND1QIW8EuFBVljK6oB19jaszvsE6GTr3?=
 =?iso-8859-1?Q?ofAVJI6cHV8m0nWxsTLj3N1dWmR3N7hKCWIqsY1e0dz5T0meig/gO7uU9M?=
 =?iso-8859-1?Q?TTVfNhwHfG5J/d13IST6PkMR2wdgolK4rj2quK6KqZGhO6wbxHyVinytaF?=
 =?iso-8859-1?Q?9EABcuI2WIpLINNKKbCSwxUMVkYuEJriN8R4/lMF4aOy4+ouN7h44yOwpe?=
 =?iso-8859-1?Q?eV5YiuHkzGcugMkq4nwcbom1ydLwmeFj/F9eUpMQiHI0WZpf0hBYhYB6Rx?=
 =?iso-8859-1?Q?Sa6lw3dnqYK3WIvFfIh1Ko8qgx530Zj+QOztim3e/YmJI8FyJr4qto4xJ3?=
 =?iso-8859-1?Q?bfiG1mfwV/bWroQ9tjr9xu8f3dME8DnEe1bgiT+7sPLXhfwpUjflvHT7wu?=
 =?iso-8859-1?Q?w4Uhi/1t9blxGGUX+mSugq1DmnQTTUgU8C7XXAlA2bIiSGYej2BUU1fU7h?=
 =?iso-8859-1?Q?Icb4cL6EWUGe02RRr5ETb0tIff3IlLEiUSVAiOfc7mpyH/XpgnFhQQUTZD?=
 =?iso-8859-1?Q?iVLRVo5L8wYM3ghker4YYNkkQElFNMk7ZC1HEykv6mWdmnEfsy7T732m4n?=
 =?iso-8859-1?Q?dfZiCvHNOcGriygdILi3OCmq8heND+JIwbxSGT3p3SQIPfzajoijx7/Bzn?=
 =?iso-8859-1?Q?oI+qUyF31IfzYXp2L8fRPZuD5AVlU4ugya3VQUeTpKxk5PXLrZtzzAAGXH?=
 =?iso-8859-1?Q?vXVFsxXMsbcsMDrxaEEGDRq8QLZp8/nSB8185wcNHI4VqUWNdCPGO1KQZS?=
 =?iso-8859-1?Q?1tQsuuwzNGOaQDY2ChSZb8e1NUoNjcAO5eqB1KPTxuHw41sI7v0RY9MIB4?=
 =?iso-8859-1?Q?Xl+E9kdUIFu8/7toilrv9yO1iZyYc+qitShm1O6xpaY6DKrmb1NlYsctND?=
 =?iso-8859-1?Q?4X6B1aoa7ODuWv1tmdIXEQvv+q05Py7XufpDvjEK8qpDIlPjI6pOTGhRra?=
 =?iso-8859-1?Q?wkzdKwCrpUsuI92+qt+YP1Cirs/s6Q76hPnX0HQRkNDV6BaYJUPLz92e1z?=
 =?iso-8859-1?Q?ghcn5Cj5rII9kq4pQTLfM3KDnjkXiCp/E9eXqZGhBH4mP8QS24nJNG1s2H?=
 =?iso-8859-1?Q?ZThcWrOANhsg0pxB34vzmHm7OBFzfvvXzCabRnTghmXPVP/qdhSu1UsU1S?=
 =?iso-8859-1?Q?SXiIn6Tvqoic9Ckber64gg+pLHiBS0Hbhez3YUloZmMkz8aI2AsjRQD1wc?=
 =?iso-8859-1?Q?HieGydcAdtjD+m6ECqT3vmiFwN+OZbIuxLZiz8+5mLGGS5ju+X9GTVmWLr?=
 =?iso-8859-1?Q?hjP5zPvOL0A0JntZppPLG2gnnjkSO972xYIer0HY+FOnY1urjD7oem/jAC?=
 =?iso-8859-1?Q?ibjcr4IHB2Rxx84t07OST31oBpH15aV+NSFrWAdzq2/63sGTp0DbrbO4pi?=
 =?iso-8859-1?Q?8RkkNNtG9g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TowlAB3U+TnkahWrh7Zx+jWKz1XUtBTSYsXXGg4GrFIMTp8Oabhz4YI9dcEDWQmsWmSy3vrGIfxM2+aL91JpJ6W7dmYi7xuu1+VFZFiqLctMKs1Jobo9LVfJd0u1/cP/8m6efc0DVxFkjs60QRj4rxYRWZ0hKTK+RQSH5swkLVeEhHkgYRx2zjODUhd2vgKh7LvBV5js/ZdizRGRZnhcAsQ6N8pY21jqB89gZpmKrXKKVyLxdtfRsVG33wLOyPcRjJVarPGK4znWjDONYBsweCTuR7qgSXpBePx7kAJRFa+HGHzrQeBAKzyu/VqBq0oQRGuju0js7l9Nf9hvS1q3rA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4746.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea39cc6-47a8-4c2f-935b-08dec13aa847
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:38:00.8215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bt+XB0Dzqc1kh3jP3PLm2526MkS9O0drcBMFDiR4OByApeg9IEVqnSfFJ7JwI1HC7o3qRjtyYwtgdQ0ehmmBFsjheyJss57YWCLYa+pvXVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5859
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=steven_lee@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a Caliptra mailbox frontend device with SRAM and CSR regions for the AS=
T1040 MCI mailbox window.=0A=
=0A=
Model the mailbox lock, command registers, execute flow and completion path=
 through a pluggable peer interface so backends can service commands synchr=
onously or asynchronously.=0A=
=0A=
Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_cptra_mbox.h | 133 ++++++++++=0A=
 hw/misc/aspeed_cptra_mbox.c         | 380 ++++++++++++++++++++++++++++=0A=
 hw/misc/meson.build                 |   1 +=0A=
 hw/misc/trace-events                |   4 +=0A=
 4 files changed, 518 insertions(+)=0A=
 create mode 100644 include/hw/misc/aspeed_cptra_mbox.h=0A=
 create mode 100644 hw/misc/aspeed_cptra_mbox.c=0A=
=0A=
diff --git a/include/hw/misc/aspeed_cptra_mbox.h b/include/hw/misc/aspeed_c=
ptra_mbox.h=0A=
new file mode 100644=0A=
index 0000000000..470e91597f=0A=
--- /dev/null=0A=
+++ b/include/hw/misc/aspeed_cptra_mbox.h=0A=
@@ -0,0 +1,133 @@=0A=
+/*=0A=
+ * ASPEED Caliptra mailbox model (Caliptra 2.x subsystem mode)=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#ifndef HW_MISC_ASPEED_CPTRA_MBOX_H=0A=
+#define HW_MISC_ASPEED_CPTRA_MBOX_H=0A=
+=0A=
+#include "qom/object.h"=0A=
+#include "hw/core/sysbus.h"=0A=
+=0A=
+typedef struct Error Error;=0A=
+=0A=
+/* SRAM size: 2 MiB (matches MCU_MAILBOX0_SRAM_SIZE in caliptra-mcu-sw) */=
=0A=
+#define CPTRA_MBOX0_SRAM_SIZE    (2u * 1024u * 1024u)=0A=
+#define CPTRA_MBOX0_SRAM_WORDS   (CPTRA_MBOX0_SRAM_SIZE / 4)=0A=
+=0A=
+/* CSR window: 4 KiB (covers all defined registers) */=0A=
+#define CPTRA_MBOX0_CSR_SIZE     0x1000u=0A=
+=0A=
+/* CSR register offsets (relative to CSR BAR) */=0A=
+#define CPTRA_MBOX0_LOCK_OFF            0x000=0A=
+#define CPTRA_MBOX0_USER_OFF            0x004=0A=
+#define CPTRA_MBOX0_TARGET_USER_OFF     0x008=0A=
+#define CPTRA_MBOX0_TARGET_USER_VAL_OFF 0x00C=0A=
+#define CPTRA_MBOX0_CMD_OFF             0x010=0A=
+#define CPTRA_MBOX0_DLEN_OFF            0x014=0A=
+#define CPTRA_MBOX0_EXECUTE_OFF         0x018=0A=
+#define CPTRA_MBOX0_TARGET_STATUS_OFF   0x01C=0A=
+#define CPTRA_MBOX0_CMD_STATUS_OFF      0x020=0A=
+#define CPTRA_MBOX0_HW_STATUS_OFF       0x024=0A=
+=0A=
+/* CMD_STATUS values */=0A=
+#define CPTRA_MBOX0_STATUS_BUSY        0=0A=
+#define CPTRA_MBOX0_STATUS_DATA_READY  1=0A=
+#define CPTRA_MBOX0_STATUS_COMPLETE    2=0A=
+#define CPTRA_MBOX0_STATUS_CMD_FAILURE 3=0A=
+=0A=
+/* SoC agent ID reported in the USER register when the lock is acquired */=
=0A=
+#define CPTRA_MBOX0_SOC_USER_ID    1u=0A=
+=0A=
+/*=0A=
+ * Caliptra mailbox interface (frontend), implemented as a QOM interface s=
o=0A=
+ * that backends can deliver an asynchronous response without depending on=
 the=0A=
+ * concrete frontend device type.=0A=
+ */=0A=
+#define TYPE_CPTRA_MBOX_IF "cptra-mbox-if"=0A=
+typedef struct CptraMboxIfClass CptraMboxIfClass;=0A=
+DECLARE_CLASS_CHECKERS(CptraMboxIfClass, CPTRA_MBOX_IF, TYPE_CPTRA_MBOX_IF=
)=0A=
+typedef struct CptraMboxIf CptraMboxIf;=0A=
+#define CPTRA_MBOX_IF(obj) \=0A=
+    INTERFACE_CHECK(CptraMboxIf, (obj), TYPE_CPTRA_MBOX_IF)=0A=
+=0A=
+struct CptraMboxIfClass {=0A=
+    InterfaceClass parent;=0A=
+=0A=
+    /*=0A=
+     * Called by the peer when a command submitted via handle_execute() ha=
s=0A=
+     * completed. @status is a CPTRA_MBOX0_STATUS_* value; @data/@len carr=
y the=0A=
+     * response payload to be written back into the mailbox SRAM (@len byt=
es,=0A=
+     * @dlen is the reported DLEN).=0A=
+     */=0A=
+    void (*complete)(CptraMboxIf *s, uint32_t status, uint32_t dlen,=0A=
+                     const uint8_t *data, uint32_t len);=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Caliptra mailbox peer (backend) base class.=0A=
+ */=0A=
+#define TYPE_CPTRA_MBOX_PEER "cptra-mbox-peer"=0A=
+OBJECT_DECLARE_TYPE(CptraMboxPeer, CptraMboxPeerClass, CPTRA_MBOX_PEER)=0A=
+=0A=
+struct CptraMboxPeer {=0A=
+    DeviceState parent;=0A=
+=0A=
+    /* Set by the frontend when this peer is linked to it. */=0A=
+    CptraMboxIf *intf;=0A=
+};=0A=
+=0A=
+struct CptraMboxPeerClass {=0A=
+    DeviceClass parent;=0A=
+=0A=
+    /*=0A=
+     * Process a command. @data/@len is a copy of the request payload from=
 the=0A=
+     * mailbox SRAM. The peer must eventually report completion by calling=
 the=0A=
+     * interface's complete() method (synchronously or asynchronously).=0A=
+     */=0A=
+    void (*handle_execute)(CptraMboxPeer *p, uint32_t cmd, uint32_t dlen,=
=0A=
+                           const uint8_t *data, uint32_t len);=0A=
+=0A=
+    /* Optional: notify the peer of a mailbox reset. */=0A=
+    void (*handle_reset)(CptraMboxPeer *p);=0A=
+};=0A=
+=0A=
+/* Concrete frontend device type. */=0A=
+#define TYPE_ASPEED_CPTRA_MBOX "aspeed-cptra-mbox"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedCptraMboxState, ASPEED_CPTRA_MBOX)=0A=
+=0A=
+struct AspeedCptraMboxState {=0A=
+    SysBusDevice parent_obj;=0A=
+=0A=
+    /* Linked backend; NULL means no Caliptra peer is present. */=0A=
+    CptraMboxPeer *peer;=0A=
+=0A=
+    bool locked;=0A=
+    bool command_pending;=0A=
+    bool release_pending;=0A=
+    uint32_t user;=0A=
+    uint32_t target_user;=0A=
+    uint32_t target_user_valid;=0A=
+    uint32_t cmd;=0A=
+    uint32_t dlen;=0A=
+    uint32_t execute;=0A=
+    uint32_t target_status;=0A=
+    uint32_t cmd_status;=0A=
+    uint32_t hw_status;=0A=
+=0A=
+    uint32_t sram[CPTRA_MBOX0_SRAM_WORDS];=0A=
+=0A=
+    MemoryRegion sram_mr;=0A=
+    MemoryRegion csr_mr;=0A=
+};=0A=
+=0A=
+bool aspeed_cptra_mbox_set_peer(AspeedCptraMboxState *s, CptraMboxPeer *pe=
er,=0A=
+                                Error **errp);=0A=
+=0A=
+/* Concrete external (chardev) peer type. */=0A=
+#define TYPE_CPTRA_MBOX_PEER_EXTERN "cptra-mbox-peer-extern"=0A=
+=0A=
+#endif /* HW_MISC_ASPEED_CPTRA_MBOX_H */=0A=
diff --git a/hw/misc/aspeed_cptra_mbox.c b/hw/misc/aspeed_cptra_mbox.c=0A=
new file mode 100644=0A=
index 0000000000..8c1faf69df=0A=
--- /dev/null=0A=
+++ b/hw/misc/aspeed_cptra_mbox.c=0A=
@@ -0,0 +1,380 @@=0A=
+/*=0A=
+ * ASPEED Caliptra mailbox host interface (frontend) and peer base class.=
=0A=
+ *=0A=
+ * Copyright (C) 2026 ASPEED Technology Inc.=0A=
+ *=0A=
+ * SPDX-License-Identifier: GPL-2.0-or-later=0A=
+ */=0A=
+=0A=
+#include "qemu/osdep.h"=0A=
+#include "hw/misc/aspeed_cptra_mbox.h"=0A=
+#include "hw/core/qdev-properties.h"=0A=
+#include "migration/vmstate.h"=0A=
+#include "qapi/error.h"=0A=
+#include "qemu/error-report.h"=0A=
+#include "qemu/log.h"=0A=
+#include "system/memory.h"=0A=
+#include "trace.h"=0A=
+=0A=
+static size_t cptra_mbox_padded_len(uint32_t dlen)=0A=
+{=0A=
+    return (size_t)((dlen + 3) / 4) * 4;=0A=
+}=0A=
+=0A=
+static void cptra_mbox_clear(AspeedCptraMboxState *s)=0A=
+{=0A=
+    s->locked =3D false;=0A=
+    s->release_pending =3D false;=0A=
+    s->user =3D 0;=0A=
+    s->target_user =3D 0;=0A=
+    s->target_user_valid =3D 0;=0A=
+    s->cmd =3D 0;=0A=
+    s->dlen =3D 0;=0A=
+    s->execute =3D 0;=0A=
+    s->target_status =3D 0;=0A=
+    s->cmd_status =3D 0;=0A=
+    s->hw_status =3D 0;=0A=
+    memset(s->sram, 0, sizeof(s->sram));=0A=
+}=0A=
+=0A=
+static void cptra_mbox_submit(AspeedCptraMboxState *s)=0A=
+{=0A=
+    CptraMboxPeerClass *pc;=0A=
+    g_autofree uint8_t *data =3D NULL;=0A=
+    size_t len;=0A=
+=0A=
+    if (s->dlen > CPTRA_MBOX0_SRAM_SIZE) {=0A=
+        s->cmd_status =3D CPTRA_MBOX0_STATUS_CMD_FAILURE;=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "%s: DLEN 0x%x exceeds SRAM size\n", __func__, s->dl=
en);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (!s->peer) {=0A=
+        /* No Caliptra peer present: the command cannot be serviced. */=0A=
+        s->cmd_status =3D CPTRA_MBOX0_STATUS_CMD_FAILURE;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    len =3D cptra_mbox_padded_len(s->dlen);=0A=
+    if (len) {=0A=
+        data =3D g_malloc(len);=0A=
+        for (size_t i =3D 0; i < len / 4; i++) {=0A=
+            stl_le_p(data + i * 4, s->sram[i]);=0A=
+        }=0A=
+    }=0A=
+=0A=
+    s->command_pending =3D true;=0A=
+    s->release_pending =3D false;=0A=
+    trace_cptra_mbox_execute(s->cmd, s->dlen);=0A=
+=0A=
+    pc =3D CPTRA_MBOX_PEER_GET_CLASS(s->peer);=0A=
+    pc->handle_execute(s->peer, s->cmd, s->dlen, data, len);=0A=
+}=0A=
+=0A=
+/* CptraMboxIf::complete - called by the peer when a command finishes. */=
=0A=
+static void cptra_mbox_complete(CptraMboxIf *iface, uint32_t status,=0A=
+                                uint32_t dlen, const uint8_t *data,=0A=
+                                uint32_t len)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D ASPEED_CPTRA_MBOX(iface);=0A=
+=0A=
+    s->command_pending =3D false;=0A=
+    trace_cptra_mbox_complete(status, dlen);=0A=
+=0A=
+    if (s->release_pending) {=0A=
+        cptra_mbox_clear(s);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /*=0A=
+     * Report the peer's status verbatim and write back whatever response=
=0A=
+     * payload it returned. The peer signals a transport/command failure w=
ith=0A=
+     * CPTRA_MBOX0_STATUS_CMD_FAILURE and no data.=0A=
+     */=0A=
+    s->cmd_status =3D status;=0A=
+    s->dlen =3D dlen;=0A=
+    if (data && len) {=0A=
+        size_t words =3D MIN(len, CPTRA_MBOX0_SRAM_SIZE) / 4;=0A=
+=0A=
+        for (size_t i =3D 0; i < words; i++) {=0A=
+            s->sram[i] =3D ldl_le_p(data + i * 4);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static uint64_t cptra_mbox_sram_read(void *opaque, hwaddr offset, unsigned=
 size)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D opaque;=0A=
+    uint32_t idx =3D offset / 4;=0A=
+=0A=
+    if (idx >=3D CPTRA_MBOX0_SRAM_WORDS) {=0A=
+        return 0;=0A=
+    }=0A=
+    return s->sram[idx];=0A=
+}=0A=
+=0A=
+static void cptra_mbox_sram_write(void *opaque, hwaddr offset,=0A=
+                                  uint64_t value, unsigned size)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D opaque;=0A=
+    uint32_t idx =3D offset / 4;=0A=
+=0A=
+    if (idx < CPTRA_MBOX0_SRAM_WORDS) {=0A=
+        s->sram[idx] =3D (uint32_t)value;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps cptra_mbox_sram_ops =3D {=0A=
+    .read =3D cptra_mbox_sram_read,=0A=
+    .write =3D cptra_mbox_sram_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid.min_access_size =3D 4,=0A=
+    .valid.max_access_size =3D 4,=0A=
+};=0A=
+=0A=
+static uint64_t cptra_mbox_csr_read(void *opaque, hwaddr offset, unsigned =
size)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D opaque;=0A=
+=0A=
+    switch (offset) {=0A=
+    case CPTRA_MBOX0_LOCK_OFF:=0A=
+        if (!s->locked) {=0A=
+            s->locked =3D true;=0A=
+            s->user =3D CPTRA_MBOX0_SOC_USER_ID;=0A=
+            return 0;=0A=
+        }=0A=
+        return 1;=0A=
+    case CPTRA_MBOX0_USER_OFF:=0A=
+        return s->user;=0A=
+    case CPTRA_MBOX0_TARGET_USER_OFF:=0A=
+        return s->target_user;=0A=
+    case CPTRA_MBOX0_TARGET_USER_VAL_OFF:=0A=
+        return s->target_user_valid;=0A=
+    case CPTRA_MBOX0_CMD_OFF:=0A=
+        return s->cmd;=0A=
+    case CPTRA_MBOX0_DLEN_OFF:=0A=
+        return s->dlen;=0A=
+    case CPTRA_MBOX0_EXECUTE_OFF:=0A=
+        return s->execute;=0A=
+    case CPTRA_MBOX0_TARGET_STATUS_OFF:=0A=
+        return s->target_status;=0A=
+    case CPTRA_MBOX0_CMD_STATUS_OFF:=0A=
+        return s->cmd_status;=0A=
+    case CPTRA_MBOX0_HW_STATUS_OFF:=0A=
+        return s->hw_status;=0A=
+    default:=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void cptra_mbox_csr_write(void *opaque, hwaddr offset,=0A=
+                                 uint64_t value, unsigned size)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D opaque;=0A=
+    uint32_t val =3D (uint32_t)value;=0A=
+=0A=
+    switch (offset) {=0A=
+    case CPTRA_MBOX0_LOCK_OFF:=0A=
+    case CPTRA_MBOX0_USER_OFF:=0A=
+    case CPTRA_MBOX0_HW_STATUS_OFF:=0A=
+        break;=0A=
+    case CPTRA_MBOX0_TARGET_USER_OFF:=0A=
+        s->target_user =3D val;=0A=
+        break;=0A=
+    case CPTRA_MBOX0_TARGET_USER_VAL_OFF:=0A=
+        s->target_user_valid =3D val;=0A=
+        break;=0A=
+    case CPTRA_MBOX0_CMD_OFF:=0A=
+        s->cmd =3D val;=0A=
+        break;=0A=
+    case CPTRA_MBOX0_DLEN_OFF:=0A=
+        if (val > CPTRA_MBOX0_SRAM_SIZE) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: DLEN 0x%x exceeds SRAM size, clamped\n",=0A=
+                          __func__, val);=0A=
+            val =3D CPTRA_MBOX0_SRAM_SIZE;=0A=
+        }=0A=
+        s->dlen =3D val;=0A=
+        break;=0A=
+    case CPTRA_MBOX0_EXECUTE_OFF:=0A=
+        if (val =3D=3D 1 && s->execute !=3D 1 && !s->command_pending) {=0A=
+            s->execute =3D 1;=0A=
+            s->cmd_status =3D CPTRA_MBOX0_STATUS_BUSY;=0A=
+            cptra_mbox_submit(s);=0A=
+        } else if (val =3D=3D 0 && s->execute !=3D 0) {=0A=
+            if (s->command_pending) {=0A=
+                s->release_pending =3D true;=0A=
+            } else {=0A=
+                cptra_mbox_clear(s);=0A=
+            }=0A=
+        }=0A=
+        break;=0A=
+    case CPTRA_MBOX0_TARGET_STATUS_OFF:=0A=
+        s->target_status =3D val;=0A=
+        break;=0A=
+    case CPTRA_MBOX0_CMD_STATUS_OFF:=0A=
+        s->cmd_status =3D val;=0A=
+        break;=0A=
+    default:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps cptra_mbox_csr_ops =3D {=0A=
+    .read =3D cptra_mbox_csr_read,=0A=
+    .write =3D cptra_mbox_csr_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid.min_access_size =3D 4,=0A=
+    .valid.max_access_size =3D 4,=0A=
+};=0A=
+=0A=
+static void cptra_mbox_reset_hold(Object *obj, ResetType type)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D ASPEED_CPTRA_MBOX(obj);=0A=
+=0A=
+    if (s->command_pending) {=0A=
+        /* Defer the clear until the in-flight command completes. */=0A=
+        s->release_pending =3D true;=0A=
+        return;=0A=
+    }=0A=
+    cptra_mbox_clear(s);=0A=
+=0A=
+    if (s->peer) {=0A=
+        CptraMboxPeerClass *pc =3D CPTRA_MBOX_PEER_GET_CLASS(s->peer);=0A=
+        if (pc->handle_reset) {=0A=
+            pc->handle_reset(s->peer);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
+static void cptra_mbox_peer_check(const Object *obj, const char *name,=0A=
+                                  Object *val, Error **errp)=0A=
+{=0A=
+    CptraMboxPeer *peer;=0A=
+=0A=
+    if (!val) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    peer =3D CPTRA_MBOX_PEER(val);=0A=
+    if (peer->intf) {=0A=
+        error_setg(errp, "Caliptra mailbox peer is already in use");=0A=
+    }=0A=
+}=0A=
+=0A=
+bool aspeed_cptra_mbox_set_peer(AspeedCptraMboxState *s, CptraMboxPeer *pe=
er,=0A=
+                                Error **errp)=0A=
+{=0A=
+    CptraMboxPeer *old_peer =3D s->peer;=0A=
+=0A=
+    if (old_peer =3D=3D peer) {=0A=
+        if (s->peer) {=0A=
+            s->peer->intf =3D CPTRA_MBOX_IF(s);=0A=
+        }=0A=
+        return true;=0A=
+    }=0A=
+    if (!object_property_set_link(OBJECT(s), "peer",=0A=
+                                  peer ? OBJECT(peer) : NULL, errp)) {=0A=
+        return false;=0A=
+    }=0A=
+    if (old_peer) {=0A=
+        old_peer->intf =3D NULL;=0A=
+    }=0A=
+    if (s->peer) {=0A=
+        s->peer->intf =3D CPTRA_MBOX_IF(s);=0A=
+    }=0A=
+    return true;=0A=
+}=0A=
+=0A=
+static void cptra_mbox_init(Object *obj)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D ASPEED_CPTRA_MBOX(obj);=0A=
+=0A=
+    object_property_add_link(obj, "peer", TYPE_CPTRA_MBOX_PEER,=0A=
+                             (Object **)&s->peer, cptra_mbox_peer_check,=
=0A=
+                             OBJ_PROP_LINK_STRONG);=0A=
+}=0A=
+=0A=
+static void cptra_mbox_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    AspeedCptraMboxState *s =3D ASPEED_CPTRA_MBOX(dev);=0A=
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+=0A=
+    if (s->peer) {=0A=
+        if (!aspeed_cptra_mbox_set_peer(s, s->peer, errp)) {=0A=
+            return;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    memory_region_init_io(&s->sram_mr, OBJECT(s), &cptra_mbox_sram_ops, s,=
=0A=
+                          "cptra-mbox.sram", CPTRA_MBOX0_SRAM_SIZE);=0A=
+    sysbus_init_mmio(sbd, &s->sram_mr);=0A=
+=0A=
+    memory_region_init_io(&s->csr_mr, OBJECT(s), &cptra_mbox_csr_ops, s,=
=0A=
+                          "cptra-mbox.csr", CPTRA_MBOX0_CSR_SIZE);=0A=
+    sysbus_init_mmio(sbd, &s->csr_mr);=0A=
+}=0A=
+=0A=
+static const VMStateDescription vmstate_cptra_mbox =3D {=0A=
+    .name =3D TYPE_ASPEED_CPTRA_MBOX,=0A=
+    .version_id =3D 1,=0A=
+    .minimum_version_id =3D 1,=0A=
+    .fields =3D (const VMStateField[]) {=0A=
+        VMSTATE_BOOL(locked, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(user, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(target_user, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(target_user_valid, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(cmd, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(dlen, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(execute, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(target_status, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(cmd_status, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32(hw_status, AspeedCptraMboxState),=0A=
+        VMSTATE_UINT32_ARRAY(sram, AspeedCptraMboxState,=0A=
+                             CPTRA_MBOX0_SRAM_WORDS),=0A=
+        VMSTATE_END_OF_LIST()=0A=
+    },=0A=
+};=0A=
+=0A=
+static void cptra_mbox_class_init(ObjectClass *oc, const void *data)=0A=
+{=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(oc);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(oc);=0A=
+    CptraMboxIfClass *ic =3D CPTRA_MBOX_IF_CLASS(oc);=0A=
+=0A=
+    dc->desc =3D "Caliptra mailbox host interface";=0A=
+    dc->realize =3D cptra_mbox_realize;=0A=
+    dc->vmsd =3D &vmstate_cptra_mbox;=0A=
+    rc->phases.hold =3D cptra_mbox_reset_hold;=0A=
+    ic->complete =3D cptra_mbox_complete;=0A=
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);=0A=
+}=0A=
+=0A=
+static const TypeInfo cptra_mbox_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_CPTRA_MBOX_IF,=0A=
+        .parent        =3D TYPE_INTERFACE,=0A=
+        .class_size    =3D sizeof(CptraMboxIfClass),=0A=
+    },=0A=
+    {=0A=
+        .name          =3D TYPE_CPTRA_MBOX_PEER,=0A=
+        .parent        =3D TYPE_DEVICE,=0A=
+        .instance_size =3D sizeof(CptraMboxPeer),=0A=
+        .class_size    =3D sizeof(CptraMboxPeerClass),=0A=
+        .abstract      =3D true,=0A=
+    },=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_CPTRA_MBOX,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedCptraMboxState),=0A=
+        .instance_init =3D cptra_mbox_init,=0A=
+        .class_init    =3D cptra_mbox_class_init,=0A=
+        .interfaces    =3D (const InterfaceInfo[]) {=0A=
+            { TYPE_CPTRA_MBOX_IF },=0A=
+            { }=0A=
+        },=0A=
+    },=0A=
+};=0A=
+=0A=
+DEFINE_TYPES(cptra_mbox_types)=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index fa6a961ac9..d23045c4b5 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -135,6 +135,7 @@ system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: file=
s('pvpanic-pci.c'))=0A=
 system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'=
))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
+  'aspeed_cptra_mbox.c',=0A=
   'aspeed_hace.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index 82ddbf4d15..9fe2d27fef 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -106,6 +106,10 @@ aspeed_ast2700_scuio_read(uint64_t offset, unsigned si=
ze, uint32_t data) "To 0x%=0A=
 aspeed_ast1040_scu_write(uint64_t offset, unsigned size, uint32_t data) "T=
o 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
 aspeed_ast1040_scu_read(uint64_t offset, unsigned size, uint32_t data) "To=
 0x%" PRIx64 " of size %u: 0x%" PRIx32=0A=
 =0A=
+# aspeed_cptra_mbox.c=0A=
+cptra_mbox_execute(uint32_t cmd, uint32_t dlen) "EXECUTE cmd 0x%" PRIx32 "=
 dlen 0x%" PRIx32=0A=
+cptra_mbox_complete(uint32_t status, uint32_t dlen) "complete status %u dl=
en 0x%" PRIx32=0A=
+=0A=
 # mps2-scc.c=0A=
 mps2_scc_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC rea=
d: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"=0A=
 mps2_scc_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 SCC wr=
ite: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"=0A=
-- =0A=
2.43.0=

