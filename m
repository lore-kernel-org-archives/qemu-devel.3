Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019D8CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHrH-0000Mr-Er; Thu, 15 Oct 2026 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrE-0000Kz-J5; Thu, 15 Oct 2026 05:34:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHHrB-0006Dz-Mm; Thu, 15 Oct 2026 05:34:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIRkq3ZlG2xOajakeCn2ke4eRd8GUUN3iiWD+yRNK0m41LdAXuGFUEuJIzDhbpTLZzGMSxQ2ONTTLphX2Mlc2gHLua6MundypCEKr871mTn1uXMy2vnKrkOevUM/0kNsAMrxbL4+Sr/vuW1MOn4bpjLf+BgRp1t4nKsfmaP3ETL/YVGQ9FlzAwfsNnFjSLQRY1iqIJ9f3BkbyKP2lfvQfYxjcolxApmS5oAVSMUKG6Oe/QlS/hSopnb54iRbw7anpGux2Sz/m+sJqszOT5Nk7WKxt79cHcjTiWActpU68cUrPzAC+YG86zjyxpZ7IWp1NwN3F8RJNKSdKNulI95wVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydffor+zuMnUjEBJRUpuw56ogbs1B3Vs8iChUUylIdY=;
 b=PkcQqkLyjr1BmK9QW9WEfXD6Sh8t3y3mxS31xIDcbxB8oUmEZIPo3ggXTj2p+SNgl7WtgLYEZy5B4kVu3ivS+xbqPSnCO2eEzAFq96tLsEt/Fp4k4DoI2J7+CKjnoORwvVjbBI3fpH9yNKaQ1/4u6P6Mi/6HXTabfYHulYn+paZ+4rWdIXiv9/yQMrOoFQHfjqpticSQlUP3/yo/gbBT6CU3PXHaQi9VJ7XPuOEGHYHJNiP4OaTPuRJ5M5SMe1ogrIewbHHshz98Hf5dwH8vLoupMamPP9VlUt2C3GkXzybsMAuWF8WRxG4R0Fre7sq2g1mmn6AfI8RimQxHcX7yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydffor+zuMnUjEBJRUpuw56ogbs1B3Vs8iChUUylIdY=;
 b=lerZbmCd8pTNaxjJMGnA/aQeLsroeQp+R7qvuJNzwj9r0oQwKSkn5mQLj1lhd0BammEiJv4J4vrB0AXLFv1M5geeD0tViyDZNxEjElF3NOkCa2FANZX+9eit2//Pp0DQ/p0md2KluZNar5a3mRUT5eekWAW+qWJzFPTtEEulvTWXWUjnaaGNmXUzPlavI4bMZ1JjN54HaRj2Mrk0xX7dxzFsD6b59PHrBFnZd9fYoJ5Z3NxQZOnX5USUtcFgIEyasp4zBlkHMsgTuPlBZcyH8OjhowfF7qK6nDzRc/evo/TsxaQ4EEvScfuLSgNym4N+yxXiURTRdTdzZ8S8qps9eQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by JH0PR06MB7199.apcprd06.prod.outlook.com (2603:1096:990:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 09:34:26 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 09:34:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN endpoints
Thread-Topic: [PATCH v5 7/8] hw/usb/redirect-server: Stream interrupt IN
 endpoints
Thread-Index: AQHdXIheF+g4tx6iR0eeRzFm9OWXNw==
Date: Thu, 15 Oct 2026 09:34:25 +0000
Message-ID: <20261015093417.573063-8-jamin_lin@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|JH0PR06MB7199:EE_
x-ms-office365-filtering-correlation-id: f9099920-45a9-4010-f794-08df2a9f80fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|921020|56012099006|5023799004|261009221727099003|261009223027099003|261009223327099003|261009221227099003|261009220027099003|18002099003|10067099003|22082099003;
x-microsoft-antispam-message-info: +HmelgNotZdGYUUbssnOguhaFqRIGvgqGanVRbtq+g8m8s7MJlb7iMocbalBO46ZKOnxBYN9EvKBWgXyva/mrQWnS0Z8IQFtx1RCdal3AwALqEr+DH0qfyvLE0nr6jhQAObjIQm7o/TJ2MksiO2Vae/I0miOVDtHlW29ntJhluxUBOcwRLnfHGt8tr+fBDxEqr6lsG2qXiHtjXhp/wD1PCsZDyisv8wP6rpAxCVpcUbDssOm08pNLvv7lP4NErBA6JYazRqmpvcUb14Q4mN/SOmYICzs28bVQgqqtMoIVHjSec6P5XTyol5p1ad5leX98EOKUwNmaJqJ1TCXh/N7uwceffGlQJQQBpCJ0wT8QXWpaNPuH6Wzafb6+YpTWwfHxdu3oDhbku1yXeoRwJxwPoxwHLd0XIcuXySnqUrqNUuAuDwSZJWAn3OOqBL3uv/8svqP+cRPHeo1c877DjDfvLs2kaMTA7WhSiLZba0hjEEXkAWtjKJb9TW4idAwpI+P0nV7FjYfoXk6UeVUmdj8/ChcsRroi6q+tx38Tf98JaLRHLdabLyPSpEOxtixvZRdxvYXRu87BxfdLG6BB4wLSZI9iLTnBPYB/LKQbC/QIO2QVsgA4SRu1canlpSv6FXHEG+XUV8ZL0GG6Awb3NSYD0KRJ07aLErSsIwTsHYA6AETmyW/p/mgFAt+yUg5acqmfQpyW4YJ/M6vZ5lwvh6BANSaAzM5Cvz6L/tq2noYBfon4fFGIeyTe9W6YDtPGWbs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(921020)(56012099006)(5023799004)(261009221727099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009220027099003)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B/TM5SFXgw0r9vtcFGMdacCXtPHr/22t8NVH9g9rcrJjYy1KfoVGzEiJEM?=
 =?iso-8859-1?Q?Xdtmy1luo5mFi4/JpbnsIrHs9WnE0d0KQlBeHirUd7azhxAWxKyvV4ksfp?=
 =?iso-8859-1?Q?0pHpSK91tKV7X4Zqku8cyfYvGSC3E+JBOhg6DCMiGH2iJaoZjVKlbYYzrj?=
 =?iso-8859-1?Q?/szblb7NlnmLdAFNCV/A/flG41SL88Zbe8/I9fGH4YPgah+rYlW/uCTItf?=
 =?iso-8859-1?Q?51H7Tiqv/PnvKdEZq+DUVNhfVDAIB9jQZJ+m28rNd9fAPnxcoMMxUKy+pe?=
 =?iso-8859-1?Q?Jh80lujjnxETTDcD0Tky6nv08+6thx7w3cmSFgRZafdLZmSZLMi8upN1vb?=
 =?iso-8859-1?Q?Ke31SVVBnCxYJTTxajyIS59c/jLW/J8q685v+3+7TtsTI9X+VC7GC4Fzcy?=
 =?iso-8859-1?Q?4doounWlgBGp4k+KKcGGkVakZ5R51A9gS3nKcQeCqABbUjZu5BL3PLExvI?=
 =?iso-8859-1?Q?smXoYvd+inDHtyIo6yWJLv6XAOZWv18EO+HWcuEoKdtzPXLiZNM3giFN8i?=
 =?iso-8859-1?Q?sX8KnJZs8kASAKjjHoO+qOJRUnXPy7MReS75ALsaHgqQ6L1ri5O09NxSBW?=
 =?iso-8859-1?Q?utRnVzfbxhl4y1sJ/xyPyHUvaHHZXWkaNnTdzd5+4KojOQwBRDHBqeVm21?=
 =?iso-8859-1?Q?Wg+A0vQvufIj15n3EMYIZrgI59VpvnxQNHhf7kjqoMROloV+sOoMoVP32v?=
 =?iso-8859-1?Q?yHVGVsmZkjJobgX1KvSpoa8TkTDEjERb6O96L1xzLiLJE0I9pj+XeYEBKv?=
 =?iso-8859-1?Q?LgtkzU4sk7+du96DswkjNa4oJR6ivtMP7bWCvrxCueZRcdO9Z5xS5LLJ8R?=
 =?iso-8859-1?Q?ZTjpUNTOSa3Py8R9MoC9Ffw9mPURgoqn5n3uhmYivprzK42pAm+kDFvzUn?=
 =?iso-8859-1?Q?8VBEffBbgBdQUTusbsYv8Ki3KIcqfQJYXxPOcayAvTuD+zlhnDA6WM/KNI?=
 =?iso-8859-1?Q?AJrnYp7NDYbE4N/TS0058RfELH9+tDl9gsB3ZBKThAl0JoickGlIYW1q6J?=
 =?iso-8859-1?Q?IeWjmAbSuFZW6A0xFqhc3NFlRP/JEX6ImqxaHeOqaJFpDUGY/S7y6XNPgy?=
 =?iso-8859-1?Q?leqq7rUGU9aN2yhSJM1AXFY0cIUO957tUCMl9/gG1WxpW/BYuE84UYIPQ3?=
 =?iso-8859-1?Q?8ziQmy6rfVR29aDPhpJjB1/Rff2mX8KU99AwboBpZyd8LYlsRowNSrqTK8?=
 =?iso-8859-1?Q?8wrUrNSC2dkR3KVlkfSk4ASUpgdwgqeIk1KCfc2hpVgSptz4iAK6yDXAnS?=
 =?iso-8859-1?Q?w3HQjjFZlw+4gWsylYdtgt+5YLAXJzmaYiPTP/5djbTjGBgahwqY5kTPte?=
 =?iso-8859-1?Q?ovA2CaS2VOvCZUz2GSycx4SQtLZGThm/RHrVGhIxp+7+okCKjKpJBtjydc?=
 =?iso-8859-1?Q?0kJw5GQKHN1gYRElT8rZPfiaWvuR7pzIwpuSyIjYXo3t7PcLXkQz78Hudp?=
 =?iso-8859-1?Q?bHLBNAdr9IQHnhQrnQPpn8Q3nDIIlT84+xLCFAFzOH5ELqLRd7X5+b9DKs?=
 =?iso-8859-1?Q?ut0UoclgBZf9gRT8SdDyqcP6gvUON4994COZjEuffWoc6FVHf+m+d6Rrzf?=
 =?iso-8859-1?Q?0rZGYO7UdE3TwNgsaD1tdqw3Miia7uYQw7pbLZJpOtsMP7L3pLZSxoLxPG?=
 =?iso-8859-1?Q?Kz4Y0KGOpPYBJykr00YUZoja8V4inXib1fZAgy6VwiVFmC8HNoQF5RZAFs?=
 =?iso-8859-1?Q?Y0ldTOJvlDBHfUBgIUZELdTTA3/3fmg4iGlZ1GaQUCfvC5nL4ly6uJcu/k?=
 =?iso-8859-1?Q?Ppx1P1l/i6IsYNFa0LUJFZ9/mWvGCg40ROLsO0SgAHO8770fV6aWka5OFG?=
 =?iso-8859-1?Q?EgIjNbwf4Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CMlUrzKUuSpH+B6IjKCxUlIgproUv8ER1y14CxOd7lSfcCYYMZubT0dtOVD5gxIufx+5DoPUEURWg3Wa+Bd+m6NTR4nrlNqODswTXoOPF2/lwWob4m4UYFQxBPl+vK1yK2JagPU9gHPpAKVCrdLm6N5TURq9BDRZM5jgHtjhULrw9q8pX5QWJNhMAtDlsx3oXFdtGMr6GFCXx2O6InBSsjMntczaLy+doI64Xa8kFpV4fRm2pgePFhnlOP5/9h6Vdb7lOcBiDsufYSIccHB/qmBnL2g73JfkH/GvQg1jl1ey8Cz6bpscbD4XJzxk0sQNPU0cK447HJECA860FVaIaA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9099920-45a9-4010-f794-08df2a9f80fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 09:34:26.0789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDIrK4bpu0GWX9zXDpeaKWg2ABSv+ZO1QWOFXmmy/RHTR1oNW8zrKRN2NRK1oNMz5zGKUih3YOworcS9j6CSws1HEuRjcikRmJXfcJVtw+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7199
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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
Wait for the endpoint's bInterval before parking the next one. Some=0A=
devices answer every time. Without the wait we would ask as fast as=0A=
the main loop runs, and the guest would get no time.=0A=
=0A=
Give every endpoint its own timer and bottom half. We ask each endpoint=0A=
at its own rate.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 304 +++++++++++++++++++++++++++++++++++++++=0A=
 hw/usb/trace-events      |   4 +=0A=
 2 files changed, 308 insertions(+)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index bf5286b649..149435bf9d 100644=0A=
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
@@ -120,6 +135,13 @@ typedef struct USBRedirServerPkt {=0A=
     int type;=0A=
 } USBRedirServerPkt;=0A=
 =0A=
+typedef struct USBRedirServerIntrStream {=0A=
+    QEMUTimer *timer;=0A=
+    bool started;=0A=
+    QEMUBH *bh;=0A=
+    uint8_t nr;=0A=
+} USBRedirServerIntrStream;=0A=
+=0A=
 struct USBRedirServer {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
@@ -140,6 +162,15 @@ struct USBRedirServer {=0A=
     bool host_connected;=0A=
     bool device_announced;=0A=
 =0A=
+    /*=0A=
+     * Interrupt IN streaming, indexed by endpoint number. Every endpoint=
=0A=
+     * has its own timer and bottom half, because every one wants to be=0A=
+     * asked at its own rate. The timer asks the device again, after the=
=0A=
+     * endpoint's interval or after a NAK. The bottom half asks at once=0A=
+     * when the device says it has data.=0A=
+     */=0A=
+    USBRedirServerIntrStream intr_stream[USBREDIR_SERVER_MAX_EP_NR];=0A=
+=0A=
     /* In-flight packet tracking */=0A=
     QTAILQ_HEAD(, USBRedirServerPkt) inflight;=0A=
     uint64_t next_id;=0A=
@@ -580,6 +611,86 @@ static void usbredir_server_intr_complete(USBRedirServ=
er *s,=0A=
     usbredirparser_do_write(s->parser);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * How long to wait before asking the device again. bInterval means=0A=
+ * different things at different speeds: a number of frames at low and=0A=
+ * full speed, an exponent at high speed.=0A=
+ */=0A=
+static int64_t usbredir_server_intr_period_ns(USBRedirServer *s, int ep_nr=
)=0A=
+{=0A=
+    uint8_t interval =3D s->ep_interval[ep_nr + USBREDIR_SERVER_EP_IN_BASE=
];=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+=0A=
+    if (interval =3D=3D 0) {=0A=
+        interval =3D 1;=0A=
+    }=0A=
+=0A=
+    if (device && device->speed =3D=3D USB_SPEED_HIGH) {=0A=
+        interval =3D MIN(interval, 16);=0A=
+        return (1LL << (interval - 1)) * 125 * SCALE_US;=0A=
+    }=0A=
+=0A=
+    return (int64_t)interval * SCALE_MS;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The device answered a parked request. Send the answer to the host, then=
=0A=
+ * ask again, because the host still wants more. Do not ask from here: the=
=0A=
+ * device may answer at once, and this function would call itself over and=
=0A=
+ * over. Arm the timer instead. It also waits for the endpoint's bInterval=
.=0A=
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
+    int64_t delay_ns;=0A=
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
+        s->intr_stream[ep_nr].started =3D false;=0A=
+        break;=0A=
+    }=0A=
+=0A=
+    if (s->intr_stream[ep_nr].started) {=0A=
+        if (retry) {=0A=
+            delay_ns =3D (int64_t)USBREDIR_SERVER_INTR_RETRY_MS * SCALE_MS=
;=0A=
+        } else {=0A=
+            delay_ns =3D usbredir_server_intr_period_ns(s, ep_nr);=0A=
+        }=0A=
+        timer_mod(s->intr_stream[ep_nr].timer,=0A=
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);=0A=
+    }=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -658,6 +769,9 @@ static void usbredir_server_packet_complete(USBPort *po=
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
@@ -675,7 +789,25 @@ static USBPortOps usbredir_server_port_ops =3D {=0A=
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
+        s->intr_stream[ep_nr].started) {=0A=
+        qemu_bh_schedule(s->intr_stream[ep_nr].bh);=0A=
+    }=0A=
+}=0A=
+=0A=
 static USBBusOps usbredir_server_bus_ops =3D {=0A=
+    .wakeup_endpoint =3D usbredir_server_wakeup_ep,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -726,6 +858,89 @@ static void usbredir_server_drop_pkt(USBRedirServer *s=
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
+    if (!s->intr_stream[ep_nr].started ||=0A=
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
+/* BH and timer callback: ask again on one streaming endpoint. */=0A=
+static void usbredir_server_intr_kick(void *opaque)=0A=
+{=0A=
+    USBRedirServerIntrStream *st =3D opaque;=0A=
+    USBRedirServer *s =3D container_of(st - st->nr, USBRedirServer,=0A=
+                                     intr_stream[0]);=0A=
+=0A=
+    usbredir_server_intr_park(s, st->nr);=0A=
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
@@ -1156,6 +1371,58 @@ static void usbredir_server_interface_info(void *pri=
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
+        s->intr_stream[ep_nr].started =3D true;=0A=
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
+    s->intr_stream[ep_nr].started =3D false;=0A=
+    usbredir_server_intr_cancel(s, ep_nr);=0A=
+}=0A=
+=0A=
 static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
     struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
 {=0A=
@@ -1259,6 +1526,17 @@ static void usbredir_server_send_cancelled(USBRedirS=
erver *s,=0A=
 static void usbredir_server_stop_transfers(USBRedirServer *s)=0A=
 {=0A=
     USBRedirServerPkt *rp;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        s->intr_stream[i].started =3D false;=0A=
+        if (s->intr_stream[i].bh) {=0A=
+            qemu_bh_cancel(s->intr_stream[i].bh);=0A=
+        }=0A=
+        if (s->intr_stream[i].timer) {=0A=
+            timer_del(s->intr_stream[i].timer);=0A=
+        }=0A=
+    }=0A=
 =0A=
     /*=0A=
      * No "cancelled" response here. This runs on a bus reset, a detach or=
=0A=
@@ -1305,6 +1583,10 @@ static void usbredir_server_create_parser(USBRedirSe=
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
@@ -1425,6 +1707,8 @@ static void usbredir_server_chardev_event(void *opaqu=
e,=0A=
 static void usbredir_server_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+    USBRedirServerIntrStream *st;=0A=
+    int i;=0A=
 =0A=
     if (!qemu_chr_fe_backend_connected(&s->cs)) {=0A=
         error_setg(errp,=0A=
@@ -1444,6 +1728,14 @@ static void usbredir_server_realize(DeviceState *dev=
, Error **errp)=0A=
                       USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |=0A=
                       USB_SPEED_MASK_HIGH);=0A=
 =0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        st =3D &s->intr_stream[i];=0A=
+        st->nr =3D i;=0A=
+        st->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,=0A=
+                                 usbredir_server_intr_kick, st);=0A=
+        st->bh =3D qemu_bh_new_guarded(usbredir_server_intr_kick, st,=0A=
+                                     &dev->mem_reentrancy_guard);=0A=
+    }=0A=
     s->chardev_close_bh =3D qemu_bh_new_guarded(usbredir_server_chardev_cl=
ose_bh,=0A=
                                               s, &dev->mem_reentrancy_guar=
d);=0A=
 =0A=
@@ -1457,12 +1749,24 @@ static void usbredir_server_realize(DeviceState *de=
v, Error **errp)=0A=
 static void usbredir_server_unrealize(DeviceState *dev)=0A=
 {=0A=
     USBRedirServer *s =3D USB_REDIR_SERVER(dev);=0A=
+    int i;=0A=
 =0A=
     qemu_chr_fe_deinit(&s->cs, true);=0A=
     usbredir_server_destroy_parser(s);=0A=
 =0A=
     g_clear_pointer(&s->config_descs, g_hash_table_destroy);=0A=
 =0A=
+    for (i =3D 0; i < USBREDIR_SERVER_MAX_EP_NR; i++) {=0A=
+        if (s->intr_stream[i].timer) {=0A=
+            timer_free(s->intr_stream[i].timer);=0A=
+            s->intr_stream[i].timer =3D NULL;=0A=
+        }=0A=
+        if (s->intr_stream[i].bh) {=0A=
+            qemu_bh_delete(s->intr_stream[i].bh);=0A=
+            s->intr_stream[i].bh =3D NULL;=0A=
+        }=0A=
+    }=0A=
+=0A=
     if (s->chardev_close_bh) {=0A=
         qemu_bh_delete(s->chardev_close_bh);=0A=
         s->chardev_close_bh =3D NULL;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d74860ad4b..96f46c5fe0 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -420,3 +420,7 @@ usbredir_server_bulk_complete(uint64_t id, uint8_t ep, =
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
2.43.0=0A=

