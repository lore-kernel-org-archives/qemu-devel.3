Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4899C5DF66
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 02:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuhLu-0000vd-WE; Thu, 13 Aug 2026 22:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuhLj-0000uy-UE; Thu, 13 Aug 2026 22:08:48 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuhLh-0007wD-Gc; Thu, 13 Aug 2026 22:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGpNaAvP646ypAKgtzriYpiuTk4Em9p024ZWTUbKsR5A7P3U3rT4H4ccTy1C09zh8oZWHMnrv4SvrXI4ScXkfnPFQePfEJGqgfXOcba0EHrCKalYiokRZEY2H/Og2c2KSHEQmEL7PwfslyH2Bhr+/17jqIB1EYgpbIMi9PEZoZra/gvOTC+gkW1IyWgbY5OG9PZK0fL+ZrhlDasBXVZXVOFPufOUUeJuyIaT5wqi9PxLvfGWQ5Nk/Ny4cbDzS1m89Nw18h/dLsExfW/HIE9liSERvBtgkRtvPTZ/ywLnimXPUEZEDgpe8Q/5ebFQcTXQjDinm+kl522jdlbXVyHPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyVJmTNVdKeeopOE8KUf/Ts927qrJBpsHdd9eI+iqo4=;
 b=TaHhX6DZYfOtZRJKxCYSNfgYyYANLqPlOcMscB70bjEWxKDiarQknCifu5YYzrtnmvuAPwMixUbt0Qrcf9Az1Y9IZ0ok7VV69cP0wE4Q9dTAr1ywc2Cvmzw5AUKS9DBHRvkw4shH2/AZs7o0uIkN244gnQZ47FUpMCmpRLIj76wNC1RAH2becew4Id/cUz8ft6s1LoTpd8JR8n41YWxkeeGeUmig3zckPDO21wlOswA2TRwCZ0FjNqmdoS3cTJETD0vuCcyL7gNHL6gD1jHQkfxGq7al7ogr6DAWjdzvL27zXNB/oJlhZuO4AsIEu7X04WfTmzJNARswtqIOiMFiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyVJmTNVdKeeopOE8KUf/Ts927qrJBpsHdd9eI+iqo4=;
 b=E8OJ379UhQhfbG0n3sKPTVLsgcZ5forPEBxUEeUrFCP8RGEjYM7DAe9Qjn05Pn7Vq0Ev5PfQj8hitfjBVMrp/uI/grSq0DR3sDCV39Q8Y6zYgUzeZ3JVXHY6nM8lmOXzNh17jjCPsruGrQ8CnOp35ze0vjrtV06Cj/WvW99wGZX6GWaqBsYNCDKMmZsvpoMxWNAQRpLMgJcMN5JAaObIJ6pksOv+wFMJe+AGD7SJEFwZjc8qQ10FdEkXhtpKzhir+v4FMPIP5ITWn5ac5g+/ubgBaNDRFZ4bG7kFvBESNUgeF7mEOwZkHjf1cSw5yPyYgQAUREmK8r7pz4mgvPZZfQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE1PPF997DECE08.apcprd06.prod.outlook.com (2603:1096:108:1::421)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 02:08:37 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 02:08:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "Mikail.Sadic@ibm.com" <Mikail.Sadic@ibm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Mikail Sadic <mikail.sadic@ibm.com>
Subject: [PATCH v2] hw/i2c/aspeed_i2c: Latch received bytes for SMBus block
 reads
Thread-Topic: [PATCH v2] hw/i2c/aspeed_i2c: Latch received bytes for SMBus
 block reads
Thread-Index: AQHdK5HRkJd3Xmgm+k+UKKVBfqUr1w==
Date: Fri, 14 Aug 2026 02:08:37 +0000
Message-ID: <20260814020836.3119613-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE1PPF997DECE08:EE_
x-ms-office365-filtering-correlation-id: 4812e988-aa8b-4803-306a-08def9a8f3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|6133799003|921020|18002099003|38070700021;
x-microsoft-antispam-message-info: VUz3IK10Uboqu8UIfoAxyhtVI0SA/ASNH+ziTqCLJ8PAw7uRTW/vvRi9/ZxssttFJwq57johKzoSLcf0/fccR2E4tZHPuBINM/mf8+3Epa9hKLLw/x5tcMibo/iHJaHwBbkhLyjb8utqdXC8HA3xplkenCylKZNxNZKc2yQa/GmBFkUc8sZc+QINy15rWPt4FcGPEgxkGqPZBTFzLNAPODN7GzpPiMYTwtxwMX1cNMLmUIV2xVPztVu/w6O4w93sStaxLcjBBwh1nZ0IljZuE/z3AcUYxJYjdL8kC1oE3PbH43lZsvQ/9fnIIQUy0E6OkaZLJHZbO0Luqlnoo8GTFqzoS3uASMs6qlT8p6aur55Ni3mMrnFNSv5Je0Kva4kv8E4Vda+0cs9yVzpRUiyJMmYd12IauIcQuqGdlu6NsTOS2imGVlnES61tRha04tr4lO6uiWNvQYxTF2GwS772bWNIkILiAJoCm8l5+dfuw4D/ZP1zvAT4qrtnlwdL/6WQt4FMKuxzDqYmfrQwfL2o5ogOlNVzP+fNCiFtCllbGAM5PEFL5MkQbBMPgIgh6//PbfGyJTrWUYIXijrmqC4TUG9kSMUwW/420MH3LsHPYJCXCmvYnlf1ihAO/Yf8ksHVRYtGJPNb+k0JlGMbpsgOSlrDYM+am2ETY8cPRhE36n3dqAS7b1q7BItMNLACRJiHvv6D1WN1DTX6sDxlXKDVhYc7cIlX+CHaZxOWK5WmqCeA4/KC8FG27Jlpuu0dn7/t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(921020)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wq96VtwQzl+IO8E5TaqzquUz7g1K6/C53w/kQaMv6mlXwnO7DnBepBCJa5?=
 =?iso-8859-1?Q?jvUwTBIT6aeeZC0S+IjlCenvhpDeIS7WjHvz7nX0wbNp5Cn5YRKnU9MPw2?=
 =?iso-8859-1?Q?jE9FhpvbzJX0kdmTKNJZ+UwtaA1pUEB0YuOiJYbOdVk6JZ/dojz7ZLEGRX?=
 =?iso-8859-1?Q?3cbREZEqTKi92GzS7EPanq5CGOvoSConCEgJ8mW+6tQ6N/N9cu3JfrUx3Z?=
 =?iso-8859-1?Q?LuIdfO5+sxKb6ti7M7ngXhKWaFc7zSYXd/3kZf8QUlvQacC03FpvAhYgzt?=
 =?iso-8859-1?Q?fZTTA3blQyunQiPDGhh/CCeb2T8d3iFD+1QHZina2R/jOqe1cF47wiBDx/?=
 =?iso-8859-1?Q?0W388C6SbE9DMjH9qCSDvnzGIdf3AAAI8vta+vw77Q4QXqUP/qKAfCJYBL?=
 =?iso-8859-1?Q?9JaVe0RmJnfDnYSs2RoVU3yJD+Rvko5CKCa6/t7RLzg7bBBAPsTeGhuEfC?=
 =?iso-8859-1?Q?hvMBloIbXGPXUK8Gcaj29gmk33uiripCZ8IXxkHNl3gzlljLNJB3b6tKj4?=
 =?iso-8859-1?Q?hjfHHlz6puID89C5e7LE7qTPrIFtf6IAqHrXwBUBQbpjzun3nIFw/r7NB5?=
 =?iso-8859-1?Q?XJXXOARPkD+Zyb4XlmhFPlHwhAduiH7ifoLxEwyHFuaDqz8jAXd5WzV+g9?=
 =?iso-8859-1?Q?MFGNAwnbCBmITLpIUBw/mkpIy5zWwDttQHoud6jiK5SWfk9MJUEEE/URU3?=
 =?iso-8859-1?Q?ejNtj++/nSPmmPnRcJ5J0nceomXs4Bo2A3gZ9u8ltJ6KZVT0bCqymcEsZx?=
 =?iso-8859-1?Q?06MaJf68/JcBv5XtvNPsq0GZ/k0HsvRGd9KIEc9wDVKCURn8I/zHeqTMJS?=
 =?iso-8859-1?Q?J8W19zNghGN8Z8zA7lgu+1fdSInkMW1SLD+yqFppltw6bsN0Xuw9QG49t/?=
 =?iso-8859-1?Q?on6PGcdH2iru20WOwi9XviXx9TPk00D0LIu7sRKst/6DMxHbfH7PxrH97X?=
 =?iso-8859-1?Q?8mnUFy110TXai5S+jUz3NSF6x+qucTazpHVIpZlZ0dCP9McSDYa0FKVm9O?=
 =?iso-8859-1?Q?LPkpcOdaX9g8AQ31E+eoXIqsUIz5uIsD+t/jnLu32M1d21vYYMXNwQ7rE+?=
 =?iso-8859-1?Q?es98jG+NoT+jCfuR6f4S4ak5TEeTklL0wdAZZJi1cjIdpSnUWOfrmznEaI?=
 =?iso-8859-1?Q?TJfNbDS5lb1L9YU3y57gNPqHQXyyzHvwPwUjgQ+VA7NUfmDCxwLcvHUtMt?=
 =?iso-8859-1?Q?NhTlDoDPUavL96zaNysIDo2oXT+n1mmm5h3B+rwWBcIkdOx37ZzSqxtuRQ?=
 =?iso-8859-1?Q?NOB79sYmAhLJNcu7AGv+o+sGTdfegjAXTolch80AtftbYpjTaaB7CHNo/v?=
 =?iso-8859-1?Q?TAefq9XqP3O+AJ4z1ZtAXqm7uiJpUv9sAQ8zzfJjNHb18ALZIz6PXFKG0S?=
 =?iso-8859-1?Q?6YNirMm3FYOFICVVjxmCBpeaxq1lTf44j7iAwqOXRGy63FTZVGW6VjYgGA?=
 =?iso-8859-1?Q?MdFCzEitncxDgCZaIuxCXTigJva6ogDLKCuVomAHftEu7asOZ08ns/axvo?=
 =?iso-8859-1?Q?YM+qv+EVkvnIW+nHvj61wxrCme5G9qhr6odwgmLhdCAgqE38mnMPICjEJo?=
 =?iso-8859-1?Q?IWNRIKUjEAZ/Cvy90h1hz7teBlBWHsCK+UJCc4P2lN7LRzOZZuq+jjnID2?=
 =?iso-8859-1?Q?TPxkE6o/l2rBsj+X/J+5YevpiYdfUoSpK7iplP0TdU6gXWpaEUFtWE7Axm?=
 =?iso-8859-1?Q?EHKy2znCY7/E4LTz7LfzR0qdjGuhwsy8OX5RPATXd7Q/pUwV44aUKYEZBb?=
 =?iso-8859-1?Q?dpndCEDgT7oL/WKPzJ5z8acUeokSYBArNoncKEa7WsdJnAG8HLeQAkLV1P?=
 =?iso-8859-1?Q?Ajs3Sw0Z5w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n/nc947jelgg+Ejbh8r62vU9UlOe9uo7OrE/Tg/aJpfmQbBFSAqnN/9TCW5OEbNKoIpMA/UXfDEUUxJqwL0tP13xzbmTut5HfxH+X47e1TvOsxQ7xlMzDTdfwGczn0gSSp4DKvoA86hqqUdLlAkgRO/g+V0MD7Cj+lxYWaY6i9G0NcKozKIRBHpQrYGwgyzgeqhgRqKTBlCdDDc6zpycuqBZlxx6VEhLkUDPnQZcVfku4XdpQTFZmYxDAecTnTRJF75uq5sReWvf/5xvL1lp3ywr6nCxikbqV/I+cjuM1tE6f+eZ1/dr9PX0Wc9Q443M30xCUQXiZ7qRAxCuwwK0QQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4812e988-aa8b-4803-306a-08def9a8f3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 02:08:37.1072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +x/bJ0lZXZKi+vjunOblZ98lE9aWSHiSOWB8HA75CWAfju1kp0lVKRLhQwPqYOztr9o41XXni84KubMRYrrYF9AfVTsjKAcw1qwVraLv+FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF997DECE08
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

An SMBus block read takes the block length from the first byte of the=0A=
transfer, and firmware reads that byte back from a register rather than=0A=
from the transfer buffer. The receive paths never updated those=0A=
registers, so block reads reported a bogus length.=0A=
=0A=
On AST2600 the driver reads the length from the receive byte buffer,=0A=
I2CC_MS_TXRX_BYTE_BUF[15:8]. The datasheet documents that field as valid=0A=
while the DMA buffer is not enabled. The byte mode receive path already=0A=
updated it, but the pool buffer path did not, and the driver selects=0A=
buffer mode by default.=0A=
=0A=
On AST2700 the driver reads the length from offset 0x84 instead.=0A=
=0A=
Add I2CC_BYTE_DATA_LOG at 0x84 and latch received bytes into it. The pool=
=0A=
buffer, DMA-to-pool and DMA-to-DRAM paths latch their first byte, the byte=
=0A=
mode path latches every byte. Each latch also updates the receive byte=0A=
buffer unless RX_DMA_EN is set, which is the datasheet condition and does=
=0A=
not depend on FUNC_CFG_DMA_EN. The byte data log only exists on AST2700=0A=
and AST1040, so it is gated on a class flag.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Mikail Sadic <mikail.sadic@ibm.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c         | 38 +++++++++++++++++++++++++++++++++++--=0A=
 include/hw/i2c/aspeed_i2c.h |  3 +++=0A=
 2 files changed, 39 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 68bdcd0e25..0bc4bb6fbe 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -159,6 +159,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *b=
us, hwaddr offset,=0A=
     case A_I2CS_INTR_CTRL:=0A=
     case A_I2CS_DMA_LEN_STS:=0A=
     case A_I2CS_INTR_STS:=0A=
+    case A_I2CC_BYTE_DATA_LOG:=0A=
     case A_I2CC_VERSION_CTRL:=0A=
         value =3D bus->regs[offset / sizeof(*bus->regs)];=0A=
         break;=0A=
@@ -334,6 +335,27 @@ static int aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *=
bus)=0A=
     return ret;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Latch a received byte where firmware reads it back from: the receive by=
te=0A=
+ * buffer, only valid while the DMA buffer is disabled, and the byte data =
log,=0A=
+ * which AST2700 uses instead. Buffer and DMA transfers latch only the fir=
st=0A=
+ * byte, read back as the SMBus block length.=0A=
+ */=0A=
+static void aspeed_i2c_bus_latch_rx_byte(AspeedI2CBus *bus, uint8_t data)=
=0A=
+{=0A=
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
+    uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_buf_offset(bus);=0A=
+    uint32_t reg_cmd =3D aspeed_i2c_bus_cmd_offset(bus);=0A=
+=0A=
+    if (aic->has_byte_data_log) {=0A=
+        ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);=0A=
+    }=0A=
+=0A=
+    if (!SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {=0A=
+        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)=0A=
 {=0A=
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
@@ -349,6 +371,9 @@ static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *=
bus)=0A=
         pool_base[offset + i] =3D i2c_recv(bus->bus);=0A=
         trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],=
=0A=
                                   pool_base[offset + i]);=0A=
+        if (i =3D=3D 0) {=0A=
+            aspeed_i2c_bus_latch_rx_byte(bus, pool_base[offset]);=0A=
+        }=0A=
         bus->regs[reg_dma_len]--;=0A=
         ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i + 1);=0A=
     }=0A=
@@ -443,6 +468,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
             pool_base[i] =3D i2c_recv(bus->bus);=0A=
             trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,=0A=
                                       pool_base[i]);=0A=
+            if (i =3D=3D 0) {=0A=
+                aspeed_i2c_bus_latch_rx_byte(bus, pool_base[0]);=0A=
+            }=0A=
         }=0A=
 =0A=
         /* Update RX count */=0A=
@@ -460,7 +488,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
         }=0A=
 =0A=
         aspeed_i2c_set_rx_dma_dram_offset(bus);=0A=
-        while (bus->regs[reg_dma_len]) {=0A=
+        for (i =3D 0; bus->regs[reg_dma_len]; i++) {=0A=
             MemTxResult result;=0A=
 =0A=
             data =3D i2c_recv(bus->bus);=0A=
@@ -476,6 +504,10 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
                 return;=0A=
             }=0A=
 =0A=
+            if (i =3D=3D 0) {=0A=
+                aspeed_i2c_bus_latch_rx_byte(bus, data);=0A=
+            }=0A=
+=0A=
             bus->dma_dram_offset++;=0A=
             bus->regs[reg_dma_len]--;=0A=
             /* In new mode, keep track of how many bytes we RXed */=0A=
@@ -489,7 +521,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
     } else {=0A=
         data =3D i2c_recv(bus->bus);=0A=
         trace_aspeed_i2c_bus_recv("BYTE", 1, 1, bus->regs[reg_byte_buf]);=
=0A=
-        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);=0A=
+        aspeed_i2c_bus_latch_rx_byte(bus, data);=0A=
     }=0A=
 }=0A=
 =0A=
@@ -1758,6 +1790,7 @@ static void aspeed_1040_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x2000;=0A=
     aic->has_dma64 =3D true;=0A=
+    aic->has_byte_data_log =3D true;=0A=
     aic->dma_addr_lo_mask =3D 0x00ffffff;=0A=
 }=0A=
 =0A=
@@ -1780,6 +1813,7 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x2000;=0A=
     aic->has_dma64 =3D true;=0A=
+    aic->has_byte_data_log =3D true;=0A=
     aic->dma_addr_lo_mask =3D 0xffffffff;=0A=
 }=0A=
 =0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 05937a7a0b..480c6418fe 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -231,6 +231,8 @@ REG32(I2CS_DMA_TX_ADDR_HI, 0x68)=0A=
     FIELD(I2CS_DMA_TX_ADDR_HI, ADDR_HI, 0, 7)=0A=
 REG32(I2CS_DMA_RX_ADDR_HI, 0x6c)=0A=
     FIELD(I2CS_DMA_RX_ADDR_HI, ADDR_HI, 0, 7)=0A=
+REG32(I2CC_BYTE_DATA_LOG, 0x84)=0A=
+    FIELD(I2CC_BYTE_DATA_LOG, RX_BUF, 0, 8)=0A=
 REG32(I2CC_VERSION_CTRL, 0x94)=0A=
     FIELD(I2CC_VERSION_CTRL, FUNC_CFG_DMA_EN, 2, 1)=0A=
 =0A=
@@ -302,6 +304,7 @@ struct AspeedI2CClass {=0A=
     bool has_share_pool;=0A=
     uint64_t mem_size;=0A=
     bool has_dma64;=0A=
+    bool has_byte_data_log;=0A=
     uint32_t dma_addr_lo_mask;=0A=
 };=0A=
 =0A=
-- =0A=
2.53.0=0A=

