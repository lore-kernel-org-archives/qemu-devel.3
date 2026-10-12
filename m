Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6EBCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 02:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG5bN-0006Zq-Hd; Sun, 11 Oct 2026 22:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5b5-0006TG-2f; Sun, 11 Oct 2026 22:17:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG5b1-0004ly-T7; Sun, 11 Oct 2026 22:17:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovD859L4t3vgEt5VayujS37hiNn9cN0HqiaGKYdxdzkYfDREyHfnLQm6MmLAFyGe3aOAEOiTF/Sxg80x1jrUdgfQyICLH4uQLiF//sWQg32zfILHf+eKPX8VoAa0yZhHfoYVlEOTtd09/VAmBkL0BXArKFo6hXCv+ZDqaXy5MZd4a47SJ0EzpV5GknabzEcMtViT7iXxd3LqGDk/F5oxIoNfREJ1P2zrkZ3fhdGH6VdopRPqQJ7C6fquf0isOc6uDV2u/r56j+uaIijAb0Xd9amN6MVeBl6p76pbod4cPeOdxvaBxAUto8V/GlK8XNcZ3X1tk8gAlHJIu0Gzj8E/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd+qp7fxXx9i4/NlaezT7Q0wfGBVFnEKAKghY0xXUW0=;
 b=YrVGdjZbWfjGHWe8tW4q1sBwavNR8H7Y2GyvD6ERW2apurbZ3w6NALUXFXYxJuPDv+Mz5r+fVMH2KsbjHNIX0v74IYCoVHjh/Z4oDiNICq4bNvVy7swHUBMqqVqxzZuNPcWNHIoNcQHiKCXkN79a127FBjSRzAwSezcdHHBp9UCpwZJ7/fyo4Ad4XpylBlGM8qnJcU3pTvyefT5r3uy+xw6s1hWpIkpwZM71eDsO1+T6AWiO0Ky5gF4GdJAL31eKa00Z5nMsiQR9l7n4xNOO6kllGauTI57r5n6aIaSUCQ3RtIbXuF01UMssXGt/jrtDtj7cPQYKOPN+V0WO3uwu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd+qp7fxXx9i4/NlaezT7Q0wfGBVFnEKAKghY0xXUW0=;
 b=NFRUBptqMhGiDf3AhKvhM1+wIiN28KVbfUqB0ipZRqlQlmPcSzCH8gArR/cCCMlyMuUb+yAcsZhzW7cTf3vQvAHkEjcQfMtMP+OFC6Hvgy8iTQFihKJUVclCkbHt4kUQxNiX4dFH35xiWQGLaJiw6qid1w4RTPeACBjFHTxWopHu7/pppx3ymaFeBrpVCRAAivBamIl1HXNamOqi9pV1PbJGz8oU5EHD05qp9D1gAV89D1OmWPKgVMhOmDRfW7VQTPm4ydPfvPurFnlD9ElWcwB1q2wrMngVZjCKUjQQx7iwiZrYIc/dTMTF5PrSyriEIBA59xZ2W2lNzh8EwjUIAg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5398.apcprd06.prod.outlook.com (2603:1096:101:8f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Mon, 12 Oct
 2026 02:16:44 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:16:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 7/8] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v3 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdWe+5EGkkOkU+ukmsPaIkaRs6pQ==
Date: Mon, 12 Oct 2026 02:16:43 +0000
Message-ID: <20261012021634.2006424-8-jamin_lin@aspeedtech.com>
References: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012021634.2006424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5398:EE_
x-ms-office365-filtering-correlation-id: a0738ab2-2337-413f-2736-08df2806dc65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|261009223027099003|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: Qo5TTb/hrEdzKn3K961K/d1NK5qiHDW/6dHL627QlF1gXgpJ/S8ZpPAkM6SkyeK5ccNKR3jCMDGVW4BINKgDtIdopdupC36fZzgdBPOIezalh3W7wnjKmZ6JnnliFqsFJaVKhiCD/7mQJd7TcR5VvjcDCdsfpEE2efHBb4dLTDSjXXzSw0rqibMLDI8gwQENovWNS2TXx7ub4XeIurUXFa0XE6wDZsTmBL0LvGrY6eIGv/akefn0DzTrM574XKaqR6tmqODlTXyEdw1H5VxsGY7RAPbJOEzdYNIGd6iyLO9k2iP/VJSqS5FYdo40g2Te35dPUeG0GfhJ2JnaxfeVjuJ7blTkemaPJ3mgZy5ympTuesDQJl9cdJ2zORA0/+KGJ50ddvvj7S70uB55+sioLfRgazLnSktF9ZvxPdY3Kwpr6R+xiS2irbm/nWBWf+egMUnXSrCdgIYi9HJVhgONGK/gpWS7N38XY/W6j7ao/DsPbeRUX4uF6oiWUyd1663Vhi5oqGw8xXQ+N9M65CizZz5la+XVQKnJiQcC/A9K34CLMgCqOr93iJdJx6x9tb7Xzx4knKcZr6KAQ95uypqUOI/eYUhAfTHIyQG8zej6KwHZ6pJgrCDTsVf1EdQkAG2njsdV6iwY1YJbn8CkjPnP9W0CtXC0QVOpVPEgFB1KFav7mINgf2FfvDaYPk8yxCjWeV3p/Oot2Ujy3Rgkv8H9LXj1f0HYqhffrcU3rpqijkI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(261009223027099003)(5023799004)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3aEiBLuozg162f4w7Ix6YS+Q5drwWQD1EOSeCa7ZJ+OBo9KVK9exSgMs2O?=
 =?iso-8859-1?Q?wEd2M5/yMKYxz/YEorrMWUSHlUdVAoVfuxDZxfVqJYzRu6GDkhbttj1Dol?=
 =?iso-8859-1?Q?SUdQlDPbRBObhOqE2qRn5VlQN+DbOQsnZAvx37zRX0uUR333v3RFkjE6D0?=
 =?iso-8859-1?Q?kgemtHPh66VfC+jqYykLGBVI1ZgdaNShX1Nbyj06hbOah8IjoI3Xch8WPp?=
 =?iso-8859-1?Q?rFWugN753WoHAnNs/5Ex7M7sK04CilnXU889dhh8C57cGTRqHkORj+dcxb?=
 =?iso-8859-1?Q?z2vLtE/Rbjcvp4MExNiL+LLAYi+PKLkj/Od5nN7x1rbq5MNzWEInYpwqnY?=
 =?iso-8859-1?Q?t0nenSPJgZrPMtCkjdn7068BBobvSw5RIAMHMRWx5KK5dhyiE6IUPA+hFI?=
 =?iso-8859-1?Q?bRn2woGpIy6p/KMwVbqRTHFVgSpSlhuuB7FkhCcExv37xAqVjQm4z2J3Zk?=
 =?iso-8859-1?Q?TLh4UzUG3soBuRlX64niz4qNOERLLwf7tb0Tf5C6n/ej4fTCJ8QeKI5zIO?=
 =?iso-8859-1?Q?30hGvxch0uHJDb0MGS6hzi01D7bx8Ju57StV8+2E8XKb2KuxHcH65T0ibZ?=
 =?iso-8859-1?Q?UdtQ0UDOjxQkhD++9xa+reHwoY3B2bJkzcYc+13KCFyfNuMrO1MdF9mq8O?=
 =?iso-8859-1?Q?zSs8l2fVKDF1IyzB3hogz44MhXrM2O0tqst2jj8hhuvv+MZI0mZDkjyx7/?=
 =?iso-8859-1?Q?eTXqdhgJ/Tgr2MLoOZRx8rcv+uqVt4ISXm4VyTdAMAq8s8GbxS6ryuUs+x?=
 =?iso-8859-1?Q?rS8GG7QdjcwUKpr2qbLsnX8kLJleXBipCktAQKq+UkQwrZTqeFkyT0r6GN?=
 =?iso-8859-1?Q?YCpKOrl5nZNqz9jGbVhaIvTYajiBneLPFIW0gV7hEjCy+Q+SN1NAcV2V+3?=
 =?iso-8859-1?Q?zr/fU5KVFayRLGWwyV1Qm9XadCfr+FnVIetvMy8MG20meELEHECxCga6w/?=
 =?iso-8859-1?Q?w1anSq2rbM/RaOJ/0n50eQ+Rysa9NIpkKEMPHWorR0ZEqw98EvngYT1Wmo?=
 =?iso-8859-1?Q?qpQhD0iTR2YiSzD695S2J9vbVL2Yt8q1wu+ngWru8RgxWvnZuXPcx12Zsf?=
 =?iso-8859-1?Q?4n+hfosed7N6T8yyq5JPJAGoW63bxfTkxxRaXBcIUX9B+eaIicjTGC/FNz?=
 =?iso-8859-1?Q?/+La0sZG2fu1S7YKo9HUBbIoglO62bJm9uex3oCw7E8T9L9jqzb06CIC16?=
 =?iso-8859-1?Q?UT4iCsU0wjVPphil6kmvVF4yykfLZbybmepquX0cJo4L7BGKniwsNPqoEV?=
 =?iso-8859-1?Q?Bc6M9LULoLIUan8XXqa3fiBMioJi5vy60Zp+975GVzvNacnkujo4tkEtKn?=
 =?iso-8859-1?Q?fyFwj4pyyNrY+uf1h/hFHE03wVkPI/V1m30Xy9N7urQKPuDKzk2WjtBeFN?=
 =?iso-8859-1?Q?PZWhVqR7sNMSV0BEgB8nobMneKGg/Zc8KQPF44FtD6CiAJ083dqn+NG65X?=
 =?iso-8859-1?Q?tF8zZSdOfBvBWNabVCpDD6CyPYR+wLSykVHcwX5t/xvmAJLHbluTsFJxLK?=
 =?iso-8859-1?Q?tr5+HuB3EQrgzs/nTxhvHwi3PRT64/Y2daHa1fVqPVJNPPUaQMO7LNR2DB?=
 =?iso-8859-1?Q?YX1r54pyUG6HbrMjpGoIr2MBR3/AfWjbVdMGjDPrAgrSCoGEgGgchc5hWO?=
 =?iso-8859-1?Q?GlVgFTmbOTRVN/ZUIvdeSGPV3HmLRtBlMfZPyCZ0XqgHYH+nOG4YbAjxYp?=
 =?iso-8859-1?Q?cHLSQM7rfIXeYZoGaS1hubUXqofc+oFCf0q6bfM6GZs8lvOWdWH7GXhQGF?=
 =?iso-8859-1?Q?2TzQ1RbbGrCaxpJiLgFtfSSPHbQYT0DXbrnTjs5/e+rql+ZgFYBOzR4tQ7?=
 =?iso-8859-1?Q?Qu/jKX7PrQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n1fY95OqZsgZ56IRrxp5+X3uTOSgNs8+oAn3LySLJ2SVlFLA1adqU488Kj3XphD1emX3GyVzSd2uYmTzCVp5Vmx/9pFjoa7lBFX6zy6JT+hyn0cf0KkaCB7k54kAuTpQdIDX8aAV7a/cqbYADrnUMyfImtJq9Q1qSR5FuZYC1tZ6mLEKF/N0fij7toYMhUKe/woVaSztcOZu8Csg46oKXQRy/cAgUrFQ1d54ueARZO1C3iwgUvHL135ht9ZSPRSEW4D23pvv+3jUOjWtHt+rBeHyIysYaC2VFNxxWKXOevS32POgT2WJm+nrw7+aqBtk5+ypU1mdJ5Rh6uapz2CZ0g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0738ab2-2337-413f-2736-08df2806dc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:16:44.1728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fK12lfsxmN2KK3v14H/nYhMUz+we2nzzTd1mbB/pDjFnQmoWmVOHK4FphHYhUfCyPXPjnW/9OVHj079d8nrv424KPtQcVSIuy0LDwO9U/a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5398
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Interrupt IN is not a request and an answer in usbredir. The host asks=0A=
once with start_interrupt_receiving. After that it expects a packet=0A=
every time the device has data.=0A=
=0A=
Park one IN packet on the device for each streaming endpoint. A device=0A=
that answers USB_RET_ASYNC holds the packet and completes it when it=0A=
has data. A device that answers USB_RET_NAK gives the packet back at=0A=
once, so park a new one when the bus reports a wakeup on that endpoint.=0A=
A slow timer parks one too, for a device that does not report a wakeup.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 264 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 268 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index a46d7aec43..86365bc168 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -56,6 +56,7 @@=0A=
 #include "qemu/main-loop.h"=0A=
 #include "qemu/module.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "qemu/timer.h"=0A=
 #include "qemu/cutils.h"=0A=
 #include "hw/core/sysbus.h"=0A=
 #include "hw/usb/usb.h"=0A=
@@ -82,16 +83,30 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SE=
RVER)=0A=
 #define USBREDIR_SERVER_MAX_EP 32=0A=
 #define USBREDIR_SERVER_EP_IN_BASE 16=0A=
 =0A=
+/* An endpoint number is 4 bits, so 0 to 15. */=0A=
+#define USBREDIR_SERVER_MAX_EP_NR 16=0A=
+=0A=
 /*=0A=
  * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
  * This is the largest transfer accepted.=0A=
  */=0A=
 #define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
 =0A=
+/* Buffer size for an interrupt IN endpoint before its descriptor is seen.=
 */=0A=
+#define USBREDIR_SERVER_INTR_DEFAULT_LEN 64=0A=
+=0A=
+/*=0A=
+ * Ask again this often after an endpoint answered NAK. Most devices wake=
=0A=
+ * the bus when data arrives, and then the next ask happens at once. This=
=0A=
+ * timer is for the devices that do not wake the bus.=0A=
+ */=0A=
+#define USBREDIR_SERVER_INTR_RETRY_MS 1000=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL_SETUP 0=0A=
 #define USBREDIR_SERVER_CTRL_STATUS 1=0A=
 #define USBREDIR_SERVER_BULK 2=0A=
 #define USBREDIR_SERVER_INTR 3=0A=
+#define USBREDIR_SERVER_INTR_STREAM 4=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -140,6 +155,14 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming, indexed by endpoint number. intr_bh asks th=
e=0A=
+     * device again; intr_retry does the same after a delay on NAK.=0A=
+     */=0A=
+    bool intr_in_started[USBREDIR_SERVER_MAX_EP_NR];=0A=
+    QEMUBH *intr_bh;=0A=
+    QEMUTimer *intr_retry;=0A=
+=0A=
     /* In-flight packet tracking */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
@@ -484,6 +507,63 @@ static void usbredir_server_intr_complete(USBRedirServ=
er *s,=0A=
     usbredirparser_do_write(s->parser);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The device answered a parked request. Send the answer to the host, then=
=0A=
+ * ask again, because the host still wants more. Do not ask from here: the=
=0A=
+ * device may answer at once, and this function would call itself over and=
=0A=
+ * over. Let the BH ask, or the retry timer after a NAK.=0A=
+ */=0A=
+static void usbredir_server_intr_stream_complete(USBRedirServer *s,=0A=
+                                                 USBRedirServerPkt *rp)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D rp->intr_hdr;=0A=
+    struct usb_redir_interrupt_receiving_status_header st;=0A=
+    int ep_nr =3D resp.endpoint & 0x0f;=0A=
+    USBPacket *p =3D &rp->pkt;=0A=
+    int actual =3D p->actual_length;=0A=
+    bool retry =3D false;=0A=
+=0A=
+    trace_usbredir_server_intr_stream_complete(ep_nr, p->status, actual);=
=0A=
+=0A=
+    switch (p->status) {=0A=
+    case USB_RET_SUCCESS:=0A=
+        resp.status =3D usb_redir_success;=0A=
+        resp.length =3D actual;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, 0, &resp,=0A=
+                                             actual ? rp->data : NULL,=0A=
+                                             actual);=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        break;=0A=
+    case USB_RET_NAK:=0A=
+        /* nothing to report yet; ask again shortly */=0A=
+        retry =3D true;=0A=
+        break;=0A=
+    default:=0A=
+        /*=0A=
+         * The endpoint stalled or failed. There is no data to send, so=0A=
+         * send a status message. The host keeps that status and gives it=
=0A=
+         * to its guest. On a stall the host also ends the stream, so end=
=0A=
+         * it here too. A later request from the guest starts a new one.=
=0A=
+         */=0A=
+        st.endpoint =3D resp.endpoint;=0A=
+        st.status =3D usbredir_server_status(p->status);=0A=
+        usbredirparser_send_interrupt_receiving_status(s->parser, 0, &st);=
=0A=
+        usbredirparser_do_write(s->parser);=0A=
+        s->intr_in_started[ep_nr] =3D false;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (s->intr_in_started[ep_nr]) {=0A=
+        if (retry) {=0A=
+            timer_mod(s->intr_retry,=0A=
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +=0A=
+                      (int64_t)USBREDIR_SERVER_INTR_RETRY_MS * SCALE_MS);=
=0A=
+        } else {=0A=
+            qemu_bh_schedule(s->intr_bh);=0A=
+        }=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -559,6 +639,9 @@ static void usbredir_server_packet_complete(USBPort *po=
rt, USBPacket *p)=0A=
     case USBREDIR_SERVER_INTR:=0A=
         usbredir_server_intr_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_INTR_STREAM:=0A=
+        usbredir_server_intr_stream_complete(s, rp);=0A=
+        break;=0A=
     }=0A=
 =0A=
     usbredir_server_pkt_free(rp);=0A=
@@ -576,7 +659,25 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
  * USB bus ops=0A=
  */=0A=
 =0A=
+static void usbredir_server_wakeup_ep(USBBus *bus, USBEndpoint *ep,=0A=
+                                      unsigned int stream)=0A=
+{=0A=
+    USBRedirServer *s =3D container_of(bus, USBRedirServer, bus);=0A=
+    int ep_nr =3D ep->nr;=0A=
+=0A=
+    /*=0A=
+     * The device has data. A streaming interrupt IN endpoint may have=0A=
+     * answered NAK. Ask now instead of waiting for the retry timer.=0A=
+     * Every other transfer already has its request on the device.=0A=
+     */=0A=
+    if (ep->pid =3D=3D USB_TOKEN_IN && ep_nr < USBREDIR_SERVER_MAX_EP_NR &=
&=0A=
+        s->intr_in_started[ep_nr]) {=0A=
+        qemu_bh_schedule(s->intr_bh);=0A=
+    }=0A=
+}=0A=
+=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
+    .wakeup_endpoint =3D usbredir_server_wakeup_ep,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -627,6 +728,91 @@ static void usbredir_server_drop_pkt(USBRedirServer *s=
,=0A=
     usbredir_server_pkt_free(rp);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Interrupt IN streaming=0A=
+ */=0A=
+=0A=
+static bool usbredir_server_intr_inflight(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH(rp, &s->inflight, next) {=0A=
+        if (rp->type =3D=3D USBREDIR_SERVER_INTR_STREAM &&=0A=
+            (rp->intr_hdr.endpoint & 0x0f) =3D=3D ep_nr) {=0A=
+            return true;=0A=
+        }=0A=
+    }=0A=
+    return false;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Ask the device for data on @ep_nr and leave the request waiting. A devi=
ce=0A=
+ * sends data only when asked. Do nothing if a request on @ep_nr is still=
=0A=
+ * unanswered.=0A=
+ */=0A=
+static void usbredir_server_intr_park(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    int len;=0A=
+=0A=
+    /* No device to ask. */=0A=
+    if (!device || !device->attached) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* The host did not ask for this endpoint, or a request is unanswered.=
 */=0A=
+    if (!s->intr_in_started[ep_nr] ||=0A=
+        usbredir_server_intr_inflight(s, ep_nr)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    len =3D s->ep_max_packet[ep_nr + USBREDIR_SERVER_EP_IN_BASE];=0A=
+    if (len =3D=3D 0) {=0A=
+        len =3D USBREDIR_SERVER_INTR_DEFAULT_LEN;=0A=
+    }=0A=
+    ep =3D usb_ep_get(device, USB_TOKEN_IN, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len);=0A=
+    rp->type =3D USBREDIR_SERVER_INTR_STREAM;=0A=
+    /* streamed data carries no host id */=0A=
+    rp->redir_id =3D 0;=0A=
+    rp->intr_hdr.endpoint =3D ep_nr | USB_DIR_IN;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, USB_TOKEN_IN, ep, 0, s->next_id++,=0A=
+                     false, false);=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_intr_park(ep_nr, len);=0A=
+    usbredir_server_submit_to_device(s, rp);=0A=
+}=0A=
+=0A=
+/* BH and timer callback: ask again on every streaming endpoint. */=0A=
+static void usbredir_server_intr_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServer *s =3D opaque;=0A=
+    int i;=0A=
+=0A=
+    /* Endpoint 0 is the control endpoint. It never streams. */=0A=
+    for (i =3D 1; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        usbredir_server_intr_park(s, i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_intr_cancel(USBRedirServer *s, int ep_nr)=0A=
+{=0A=
+    USBRedirServerPkt *tmp;=0A=
+    USBRedirServerPkt *rp;=0A=
+=0A=
+    QTAILQ_FOREACH_SAFE(rp, &s->inflight, next, tmp) {=0A=
+        if (rp->type !=3D USBREDIR_SERVER_INTR_STREAM ||=0A=
+            (rp->intr_hdr.endpoint & 0x0f) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        usbredir_server_drop_pkt(s, rp);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * usbredirparser I/O and logging callbacks=0A=
  */=0A=
@@ -1057,6 +1243,58 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+/*=0A=
+ * The host asks to stream an interrupt IN endpoint. Send the receiving=0A=
+ * status first. Without that status the host throws the interrupt=0A=
+ * packet away. Then ask the device once.=0A=
+ */=0A=
+static void usbredir_server_start_interrupt_receiving(void *priv,=0A=
+    uint64_t id, struct usb_redir_start_interrupt_receiving_header *hdr)=
=0A=
+{=0A=
+    struct usb_redir_interrupt_receiving_status_header st =3D {=0A=
+        .endpoint =3D hdr->endpoint,=0A=
+        .status =3D usb_redir_success,=0A=
+    };=0A=
+    USBRedirServer *s =3D priv;=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+=0A=
+    /*=0A=
+     * Endpoint 0 is control and an OUT endpoint never streams. There also=
=0A=
+     * has to be a host to send to and a device to ask.=0A=
+     */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN) ||=0A=
+        !s->host_connected || !device || !device->attached) {=0A=
+        st.status =3D usb_redir_ioerror;=0A=
+    } else {=0A=
+        s->intr_in_started[ep_nr] =3D true;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_start(hdr->endpoint, st.status);=0A=
+    usbredirparser_send_interrupt_receiving_status(s->parser, id, &st);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+=0A=
+    if (st.status =3D=3D usb_redir_success) {=0A=
+        usbredir_server_intr_park(s, ep_nr);=0A=
+    }=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_interrupt_receiving(void *priv, uint64_t =
id,=0A=
+    struct usb_redir_stop_interrupt_receiving_header *hdr)=0A=
+{=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServer *s =3D priv;=0A=
+=0A=
+    /* Endpoint 0 is control, and an OUT endpoint never streams. */=0A=
+    if (ep_nr =3D=3D 0 || !(hdr->endpoint & USB_DIR_IN)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    trace_usbredir_server_intr_stop(hdr->endpoint);=0A=
+    s->intr_in_started[ep_nr] =3D false;=0A=
+    usbredir_server_intr_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1161,6 +1399,14 @@ static void usbredir_server_stop_transfers(USBRedirS=
erver *s)=0A=
 {=0A=
     USBRedirServerPkt *rp;=0A=
 =0A=
+    memset(s->intr_in_started, 0, sizeof(s->intr_in_started));=0A=
+    if (s->intr_bh) {=0A=
+        qemu_bh_cancel(s->intr_bh);=0A=
+    }=0A=
+    if (s->intr_retry) {=0A=
+        timer_del(s->intr_retry);=0A=
+    }=0A=
+=0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
      * a closed chardev, and the host has dropped its own queues already.=
=0A=
@@ -1206,6 +1452,10 @@ static void usbredir_server_create_parser(USBRedirSe=
rver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->start_interrupt_receiving_func =3D=0A=
+        usbredir_server_start_interrupt_receiving;=0A=
+    s->parser->stop_interrupt_receiving_func =3D=0A=
+        usbredir_server_stop_interrupt_receiving;=0A=
     s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
     s->parser->start_bulk_receiving_func =3D=0A=
@@ -1343,6 +1593,10 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
 =0A=
+    s->intr_retry =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                 usbredir_server_intr_kick, s);=0A=
+    s->intr_bh =3D qemu_bh_new_guarded(usbredir_server_intr_kick, s,=0A=
+                                     &dev->mem_reentrancy_guard);=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -1360,6 +1614,16 @@ static void usbredir_server_unrealize(DeviceState *d=
ev)=0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
+    if (s->intr_retry) {=0A=
+        timer_free(s->intr_retry);=0A=
+        s->intr_retry =3D NULL;=0A=
+    }=0A=
+=0A=
+    if (s->intr_bh) {=0A=
+        qemu_bh_delete(s->intr_bh);=0A=
+        s->intr_bh =3D NULL;=0A=
+    }=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index c9ab80c6ba..931996e8cd 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -416,3 +416,7 @@ usbredir_server_bulk_complete(uint64_t id, uint8_t ep, =
int status, int actual) "=0A=
 usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
 usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
 usbredir_server_intr_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_intr_start(uint8_t ep, int status) "start_interrupt_receiv=
ing ep 0x%02x -> status %d"=0A=
+usbredir_server_intr_stop(uint8_t ep) "stop_interrupt_receiving ep 0x%02x"=
=0A=
+usbredir_server_intr_park(unsigned ep_nr, int len) "parked IN packet ep %u=
 len %d"=0A=
+usbredir_server_intr_stream_complete(unsigned ep_nr, int status, int actua=
l) "ep %u status %d actual %d"=0A=
-- =0A=
2.53.0=0A=

