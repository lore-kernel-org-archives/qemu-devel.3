Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AD1C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuRKP-0007xW-GT; Thu, 13 Aug 2026 05:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuRKM-0007x1-BO; Thu, 13 Aug 2026 05:02:18 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuRKJ-0006QQ-LE; Thu, 13 Aug 2026 05:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXz/K5OrN9/5a9pInCaRKhX69/foeogHv0Ld5k2E2EfSpfooWQxX/kYFj7DJUp6jb5sZ8sq40HSxxEj3Ls4zlZd47OdKahS0KClA10yfZAcKpmjcEy0DOzHOnoRUnFy3JOy6DGVDCb8+BNO3Xg2hFCaipruMArYq8LbFD5qw/tN483pp08inHpyaiMX7D4P5nfM1zM/KQXApLy6KZRPG2klYnNfL7Ig6E7xfHstKV/zCOhxOTtZjBfUk8hAudobpXGQst5zgRA70Uuy4ZaC1RdNCh6KbGcl/0Rf9eR7qUuCf05AynHE5PHKnuVm37UYCBYDt1BBKOFxTdMXJfBoe/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WWkyfSmh9p4QIstj2PDyr/aKoHWjYLbS6YLLUBGsYA=;
 b=OPoEB4j+Y5MtO1wIrKd7OWccoAac6p758ieF+NQzGuNb9/ZVXnKrBVrajTyatqwuTltg6AMc/7P5vgTDDhZ0grwe/Yz5GRthdswzdQm6S6/a/I1BDuEN8+KWN9dlrIXm2PsYXSCaKpW9ZdJHl2Dlx7cMwdaBAQ+L26W6Mqg/cnpX02hFFAffwhZ6jAVYU6Stxlbytq80dmDzc0rsah4YwOJmXIl0sGYHsQ23Pqdc3a7ZM7ABW7AIEg9JSTqFOrzjBi8OeHAWeVsum4feRLprW/kM/+sJaLIHLvCAi5IZEREqrrEC/TH1ayz++XFWFpwkjBwVcfOFwikaSrcgZuFEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WWkyfSmh9p4QIstj2PDyr/aKoHWjYLbS6YLLUBGsYA=;
 b=aFYoZmqJsGLiG66vUPxYa78Upp8i2HeEKlMggUoMBNQpiwBTr/QdRgNWGXPebwgqRCb1S4OpaClP3eT+BY2KyZN6ZMVJjk3nzlBn6MC0FPKBcAoWIAWNSeq756RSM/nbWRvTu4FqVGoo8UnJZRCflR9rH3Vqk6pHlw1QUuYYE0iy6NAj9ganY0khWAhGxd/WJNJj2F+PXyqU4+Yy66Q/JMFP7+1lQUfnLJ8G/AwFNkyIVRV8ngohxFnESUcPsGw9NRTMH+6HeRSleyEL94G3XqzbBAnThscAmKN3hrWYyltIa4/EJImVWdTolitOmmE5BjYs8PR79trDvR+EvHjwUQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY8PR06MB9077.apcprd06.prod.outlook.com (2603:1096:405:3b0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 09:02:06 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 09:02:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "Mikail.Sadic@ibm.com" <Mikail.Sadic@ibm.com>
Subject: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for SMBus
 block reads
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Latch first received byte for
 SMBus block reads
Thread-Index: AQHdKwJqkWkcyoBADkCDJjjo6H+EgQ==
Date: Thu, 13 Aug 2026 09:02:06 +0000
Message-ID: <20260813090205.853307-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY8PR06MB9077:EE_
x-ms-office365-filtering-correlation-id: 94453a7a-9e01-4877-c4b8-08def9198cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: Ax4+9qQN5sft+BETskaStNomttXLTIWnQkrGdrgrcdKJGRoTlum5GxU4jzFCUYRFDo3boBJRnpHMdS2n4Q79Ku7VPdAZxvxXeY3ZqogvewdLX3sAEevEQ6R0OSMUfN1vD6M5xD8r+eKF/uji4ZTiyS2glYDbUbo8RwL0WL+OIjp+dRdXYrwsZLGlKXCcw2TEFA/8R44wr11C3b6k25kZO7NGm+VXDkIX9gb/66Axm6MQzow354w2A+R8SgnhLYgShZtbkguW/W2/qAsxqwM9WjysBT8eF0Iih+ui+5U/e7sLfHt50DLi/nFOPYWnmqZd6aX9SFe4n4Crf6racWYNz1IpbJvVGZopgeGPA+3ajQ9Qp4mKvRo6pGDddfYnGRP6mmF9P7A5egxWEnzaIvhIpMfxy1YyZ1ViQyEQnh43ZmkI69cqwJMKs3He0idrhgOG5iLnZVaLGu4qN4psaYzsarnyB3y02hzIb4fDomiz0+Dcd2j25Zd04VMd6PwPuyVmswcQUcZSat6fADNgheGnF5TAe5IcbBKhkOEUQxSD906+oTOWXyxooluCnu/P6w5hwDWlCAODbbo8w6sMCNEwRHQJbgzdsoM8fYmuBX+fRUkQFJC+femtZ4QW1WFg+JPbGQXQdvEKxanecwiD/o/NuZYGlLj6IDWH5NjCns0Q3qZ1tg7giwU/14keQ5GIrPY7vnnjDuNbusJRL9+80IIFRjJjkcfJjsq4fuEpEAhH7/s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ff2CNKcOpcf4Nz/3qNbs/BU5xyqmuRk3X54pcEXvTS6BIaBRFC+UCQ5yDL?=
 =?iso-8859-1?Q?nvjvL1K8xJIqVZ31yxT1h8WvHmRNlZ8OHQJt2iD26XIXBGzapdCJTsicXP?=
 =?iso-8859-1?Q?/NBU8me32Q5QpxH1SEreN8V3o8zKxbHZly26UFtvObKpBxVtoIWSAFVWME?=
 =?iso-8859-1?Q?zIOqquw/h+GgbRPTkUGgaz4GeOiLUWvB04wHK9UmtfXtN4Rwow4rGVyPtE?=
 =?iso-8859-1?Q?kuZPWpNyZv1JMcb9gKbkQtb2tx64HDgf+i5/LSbqsaTD+jAp5DLO+c4XQi?=
 =?iso-8859-1?Q?0vQsoj8jFbiFdtEma6HVW1JMpFu37smopq4vTWAZzUy5VH5GrqdJazfMQL?=
 =?iso-8859-1?Q?tVWBpRnqDErdCxyTEqklqkbJ7Dp2V0UlOOBZ2wBq7SuXom096ryeortiog?=
 =?iso-8859-1?Q?lx8Goo4xweAHOPfIZoKNwImOuvT8+Qv4ywWWK5aPiglMRMTr9fX5TQYcHc?=
 =?iso-8859-1?Q?ev/aJc8INwLdMcl0ywk7xW4GMVOJZCgHG0ZxhxpoFOIWj4LGCC1/vOSLpV?=
 =?iso-8859-1?Q?VZD46gQBAbcEXhyEUhbScqbzKKFictq99rfrT52wyX8QJgWXk91dPQ471W?=
 =?iso-8859-1?Q?srpyYizofwReH8DJ0LysEFSD4wIepbqEQ4aDKKtanGR2F0vTdXVyICTUMQ?=
 =?iso-8859-1?Q?B7JEgKSgqFNzVqFHYbhJcpQqci/VL1SwSzw7aJo5++9oPMeQo6fy/TR2AC?=
 =?iso-8859-1?Q?SNiBp/s0E9aT7z36PNRn+mbaScmgXumeIUExh9X5xDYqnpz8dfhEBU6Y0I?=
 =?iso-8859-1?Q?jlzalxxUa4FFyI+/Fd09oROII1uI7iWDgo4TCV3qyZ3RZCuvBQfjVZSd8a?=
 =?iso-8859-1?Q?oJZZGT/jkkKC2Y+lml8MZ7ZZcIaVoqi7ixCFhqk9zpDcyLEFNt2ky900gO?=
 =?iso-8859-1?Q?QLtDJdKQo3+TKt/CVb91jjNCi9emcqDys8kuxr74i2694Fdeu0kTgglhpc?=
 =?iso-8859-1?Q?QtkY0orlyz5f9OtXTXjuXElV4qPwHwcF2gDGpZzZMO1FQlpDAiCmfsVE6C?=
 =?iso-8859-1?Q?T4hwQSGDyFtgSJhAu1gDH3uVlrXEdq61nsPArIwL+dRcyJocXZJUHVvcpo?=
 =?iso-8859-1?Q?ugVfXRiJkh5Bzfwy8UA73EERZb+2mavdFs+1ZlYdhdbTZ/zwPvszc7l2vz?=
 =?iso-8859-1?Q?kbEESbgJ9vjqPOw7WsjDXgGCGbL5jQUITMP/rpVh+LrYkLzbetysY8hbyF?=
 =?iso-8859-1?Q?MLLrbCMgB1zKnHS4GGhmy/A15Bl5Jjq2X3eSdGGCdcS+xHLXqwuEqO09yz?=
 =?iso-8859-1?Q?tgSRBuI4UnhdHztCRJweKzoYd+UOKAj7mDbttDTTPo8cgrOv5mtbdEvYe7?=
 =?iso-8859-1?Q?QZZ3uV4okP6bNp52z7pdHHRdjpFDfGk+ZKtQJy1LVporNBOXhn+ceowBv4?=
 =?iso-8859-1?Q?9fIj+7cMxMqjKsRV6b1hdmNsHpiwvh1zMr3/t8AKodWS4bTdTxnuhTeDPn?=
 =?iso-8859-1?Q?c/4Cj0uQ6qfriv5+9j2Dg8VTyAsM8gKY27tbwmHrxEKjiif9v3okMcQotx?=
 =?iso-8859-1?Q?VXDt/HF/sFrUh9LDXhCa/xeqK8gQdsgCUDJ0Xa1aXcwvl/qv0J1glLx7mA?=
 =?iso-8859-1?Q?dREaC+9l2DlGZAGplOaNEks8YWtcC+z1RzYdAwiHmG1kX74kXU8enbQq8A?=
 =?iso-8859-1?Q?FJB7x7Xz0dv1iQnwElQsE4dN1Pugu7+A3k65QeqeQ91fZK1HkX7xLJFMdL?=
 =?iso-8859-1?Q?ePIWs+pByQGXcUCst6EXTDqpbZTfr1xKMlkZQvVfcmhCf0L8845aHr3eA3?=
 =?iso-8859-1?Q?orySHTFcObebWqCX+gPUDukGPinODlhiUP/pugY+mUGqMiT4900vrsgwXH?=
 =?iso-8859-1?Q?IWy+JqoE+A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nI4uCio6bJBr6pwHIHv3FQLzA45lHJZOD8nXf+hO86+b9enp/A+oMWGXvhiESRwf5Tyb2Jmmbrt2K5NdyYmlqtE5aPf5ZkTEjQpy3gwLSO0ptl/W7Yr9y0rastu645buZne5OuzviXEWZSgNXS8DVya/nyZ+A0CEXmSE9p/friP01DfvZzP9qtmAxW3ZiFItdccfXvl5wOs32t/3VJFcU1dM4eABWwq3y9WSwwqBm54FSmMj/zn+Zf5HUHp/QAPJqb5G/ZTuRZJxs3ANFcLfJP8Q5vMyiPx20GeYdka5kYwsJUBjDfWEmKlcm+w1jdUbHVtWkzOE08HNZnsyprMoww==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94453a7a-9e01-4877-c4b8-08def9198cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 09:02:06.4814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XS+53Rf6H4DreYSpDijfwkeUBj/Juj+V9a4vkS5fw6jyEyuZqs1rGzeijHaNjnKeTh6BKwBMQEYnr/f9jl28gRs+6bQW3k54rZKoSYk2FA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9077
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Add I2CC_BYTE_DATA_LOG at 0x84. Latch the first received byte from the=0A=
three receive paths: the pool buffer path, the DMA-to-pool path and the=0A=
DMA-to-DRAM path. Each latch updates the byte data log, and updates the=0A=
receive byte buffer as well while the DMA buffer is not enabled. The byte=
=0A=
data log is outside the register window of the earlier SoCs, so it is only=
=0A=
visible on AST2700/AST1040.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c         | 31 ++++++++++++++++++++++++++++++-=0A=
 include/hw/i2c/aspeed_i2c.h |  2 ++=0A=
 2 files changed, 32 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 68bdcd0e25..e6d0eee816 100644=0A=
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
@@ -334,6 +335,24 @@ static int aspeed_i2c_bus_send_dma_pool(AspeedI2CBus *=
bus)=0A=
     return ret;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Latch the first received byte, which firmware reads back as the SMBus b=
lock=0A=
+ * length. AST2600 reads it from the receive byte buffer, only valid while=
 the=0A=
+ * DMA buffer is disabled; AST2700 reads it from the byte data log, a regi=
ster=0A=
+ * the earlier SoCs do not expose.=0A=
+ */=0A=
+static void aspeed_i2c_bus_latch_rx_len(AspeedI2CBus *bus, bool dma_buf_en=
,=0A=
+                                        uint8_t data)=0A=
+{=0A=
+    uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_buf_offset(bus);=0A=
+=0A=
+    ARRAY_FIELD_DP32(bus->regs, I2CC_BYTE_DATA_LOG, RX_BUF, data);=0A=
+=0A=
+    if (!dma_buf_en) {=0A=
+        SHARED_ARRAY_FIELD_DP32(bus->regs, reg_byte_buf, RX_BUF, data);=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)=0A=
 {=0A=
     AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(bus->controller);=0A=
@@ -349,6 +368,9 @@ static void aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *=
bus)=0A=
         pool_base[offset + i] =3D i2c_recv(bus->bus);=0A=
         trace_aspeed_i2c_bus_recv("BUFF", i + 1, bus->regs[reg_dma_len],=
=0A=
                                   pool_base[offset + i]);=0A=
+        if (i =3D=3D 0) {=0A=
+            aspeed_i2c_bus_latch_rx_len(bus, true, pool_base[offset]);=0A=
+        }=0A=
         bus->regs[reg_dma_len]--;=0A=
         ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, i + 1);=0A=
     }=0A=
@@ -443,6 +465,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
             pool_base[i] =3D i2c_recv(bus->bus);=0A=
             trace_aspeed_i2c_bus_recv("BUF", i + 1, pool_rx_count,=0A=
                                       pool_base[i]);=0A=
+            if (i =3D=3D 0) {=0A=
+                aspeed_i2c_bus_latch_rx_len(bus, false, pool_base[0]);=0A=
+            }=0A=
         }=0A=
 =0A=
         /* Update RX count */=0A=
@@ -460,7 +485,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
         }=0A=
 =0A=
         aspeed_i2c_set_rx_dma_dram_offset(bus);=0A=
-        while (bus->regs[reg_dma_len]) {=0A=
+        for (i =3D 0; bus->regs[reg_dma_len]; i++) {=0A=
             MemTxResult result;=0A=
 =0A=
             data =3D i2c_recv(bus->bus);=0A=
@@ -476,6 +501,10 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)=0A=
                 return;=0A=
             }=0A=
 =0A=
+            if (i =3D=3D 0) {=0A=
+                aspeed_i2c_bus_latch_rx_len(bus, true, data);=0A=
+            }=0A=
+=0A=
             bus->dma_dram_offset++;=0A=
             bus->regs[reg_dma_len]--;=0A=
             /* In new mode, keep track of how many bytes we RXed */=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 05937a7a0b..c8e6ea54ad 100644=0A=
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
-- =0A=
2.53.0=0A=

