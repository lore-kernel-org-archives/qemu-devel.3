Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC44ECA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDcRJ-0006cn-OO; Mon, 05 Oct 2026 02:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcRA-0006WY-OU; Mon, 05 Oct 2026 02:44:36 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xDcR8-00005B-J7; Mon, 05 Oct 2026 02:44:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzfc5HXTKQEU6+q9oadwixFkIGFF66eJnrFG0hqWe8649p2N+Lk8qVtQXNRx/5ooR79QY6Mr/9a7JjTfaYrDXaxvg6P/j+Gpv1j5W2GHtEGn7RCQ7poeBRq33NPwIINx3tM4pZ2RHvrhQRLPhXrFYISm5VbcQOuRufkU/wqFxMTsPLhIUBk6C+x6G8aKifPZjT00eaC6RmfZOwHja7WdkkqzFHLaxCckKuzE9oieRL7W46UWJjYxNuDoDi/gq/5lGFto3n380+FdwPdf3zEDd7zAq6ZeJxb2ZoAXEIh0wnn04xCp03B0MnvZ8F55i18tqkF+4Hc7imRlntdqjP/CIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp1/Z9ApX846QucGytOvy/ZE8Kh8aQjI4+902LoIxCk=;
 b=BITxsYbWZCLNkWE8/YORCQRJhJMWQTRPjzU2aaj9gyTspXThg4qL7u211wm70JayMTKWMbk7jQr1MSwAuFfuhCgS0rKtJKFRejDB2FeIP92OrCL4HhyTTJQBOOmR9C1dVU5/tq8/TTURHfJGaFNXPPOaHDoZ9yn0dlkCeurQ7lKzj6+EaDuMeY0pJXI+9nQu9DbksOF3DabiSe6VHJyS7J6YFOCausRQAlWvTMuOtgqPPvhpHi/UnY3WDI+zJV1v+Pa1mtDtPDbzLLJemUrwRoGblzAmexVqXpDI4xV40QPREi5BPdR+7wuDC0A71uhqAgCGvUb5LlGX1EhVGiCrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp1/Z9ApX846QucGytOvy/ZE8Kh8aQjI4+902LoIxCk=;
 b=lf0nwJ/8k//XBGytCNwC5aZeo+K2a2zj9/B9+xzhQqhFh/9QLYpuJC7Czck3AlpM+u7hwqP6x4M3qAW50ULmh8LMV95j4y3XmIZpsK3EiZAhIb7XhMrGgqR6dwpErd4OUIy+6QWn3KLMK8WApEBp2xbpMsNd1WXZIIfNoN4eNzAPJb9NpcF/Z1WJuAQvwKYny9NK/xOxwiDbE2yvq8c80qOk/d9LxiRGIYnGYa/w4eHvmjAqufXndbxjWtpoXZlGB+coASLXUK86G/QNYQNNaYHJwOc35UR0pwHcgMs4c2xKKUUOKThjq43GDBpMlzpVl0kOjpfKHn6zs0P58rwhrw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7166.apcprd06.prod.outlook.com (2603:1096:4:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:44:21 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:44:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 01/11] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
Thread-Topic: [PATCH v2 01/11] hw/usb/aspeed-udc: Make the SETUP buffer byte
 addressable
Thread-Index: AQHdVJTzFFjmTrlkFEKwu8+tstXWtg==
Date: Mon, 5 Oct 2026 06:44:20 +0000
Message-ID: <20261005064418.3060881-2-jamin_lin@aspeedtech.com>
References: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261005064418.3060881-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7166:EE_
x-ms-office365-filtering-correlation-id: d1b684bf-528e-434f-7c36-08df22ac15e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|10067099003|38070700021|56012099006;
x-microsoft-antispam-message-info: zv+yfr129e6tx0GDPdbD2q9mZzP8jXFar5iLikfZywGvh7IIeIDA3bvxcltzWXKdeJaL9oX0iJKEX+gpF6VKGm2+4g1Loi9b6mBy6iUOpSvAghwOxluQz4uTMD9Ppaar7OuU4em39ZS1geKa019llVI62PCcy0f+ASD1eG1HUBV2yUxAizeCuatEQa/9bBoOQmXNJSuOu4xHuCn9X7KfK7VblAj03DLVayFRr/NVY+8MwHM2PhSraT/TgcOTy4v0c5Z2GW4FnDCz+pT1taAgZiKrzi1pSwAFp6DlZ4CDe1rleq/F2xoXK4g2fDbdF70l7sPF/mqK4kWy46v0Xrk5r3hb4degrB9C9ccL0169vC9/DYvawN7yabWksLjw9CcTy5OHMMukJeHUJLTLdWognppYqDdfN1gvd2bH2GD/0hgq4UQQPBxypc3FDeECqeMoDVhgjC7BQ4Ej2WOXyULwKkaWvku5nAlzSyAZWJhQaJZc9huB2cT0JJ85/RJUAhqlIksCe6YWRF3U52yAWnMCn878xTbODEVre4xZHFC2wQ7eXjQqAzL+LjHGXNJjPEMVpaVpwjfgJnzUXyfd55m69gVlKQD8vioPwszz/Kpw85Nb2DhBsWu88/PyHwQ/94dEBt7ebspvcAP6ew/x8RoD2Vlp5m8SknsXR25n3E78V3bFk/rmkEmQ71QH7SO8X7tTi+QKm5zcM0OiC5KAULFQV6rmlDIEWWH97h7Xy1ojL24=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mfdmb5dwd+2yNJhSh2yiT2IlSqZAjAGfjmf1UgBQyJxqYPX0BpdP3rQDTs?=
 =?iso-8859-1?Q?q8koO1YzKdPFx9ZGtTje6lK/ApfwiH3bswHSxZkxPtzPeVIenzpuqyOPkX?=
 =?iso-8859-1?Q?uL2ipuDTXHJrMIZDfgHXXOOY140R248/C+C1XvMtGCUkblcqVyCqTnEivU?=
 =?iso-8859-1?Q?iESE+wGMazFfsD5zkLCHeTW4xFudJJlNYZ5Tr4DuR2V0KxvTziliyV0pm/?=
 =?iso-8859-1?Q?78fMAF7Tzkw0r2tapbjJjPvax4QVIeRzW60a2Du7snECo8JyBU5lMdRAfN?=
 =?iso-8859-1?Q?ZJgZPtQ8zFjGsR+C1SuyWgsfT0ocaTtP6WWYXO+GSP+vFe8/tXVz2kw+Bt?=
 =?iso-8859-1?Q?RNxscDNlu4Nxgj/L0nPZNFQoZGFqTUj4x89GCS5UP/rb6ys5sIUPVV5J5P?=
 =?iso-8859-1?Q?jCo6ICsJ6i1AUdTo5p9oWRDczmykqmN0hCe3vKerxE1wsXeM6hj7BzDnBH?=
 =?iso-8859-1?Q?cQwDtcbPU7zwb/2yvp8lh/Gd+dLkB3/UB11jbBx6kqoY0ylqCtWzikAcGA?=
 =?iso-8859-1?Q?mlvgwm1nCiKF4S/CqXVixOi5AFlNsL8UipLDP0wlUZHTV+8FzItCGNkaPl?=
 =?iso-8859-1?Q?4lg0QChjaTxfQGRBTkwPVtAZkSXI4bV4wlhKKBi7UOMUP3UADWxOEy1TYy?=
 =?iso-8859-1?Q?BWk7eZPejqxwTlR/qFslUA3J6/f4ZeCKPS3FTkKUz7aDb2VBhvWKk7SIXk?=
 =?iso-8859-1?Q?UgTplt7jiqYKTa/es1ucdJWUV5ecGx6A4v0oDd7dDO+/K18uTS1VdHUNOt?=
 =?iso-8859-1?Q?6JzTEtmq+s/dP9GtdS75pKL+0BDozqt5whwhc6l9Asep7EliPkteE2MRnb?=
 =?iso-8859-1?Q?bz9ntu0bihoq7uAHOdZSkavERfO+s7y7kpHtI910O3/SlDQW1Nih7gQugT?=
 =?iso-8859-1?Q?rytcYywXu0lYdrAYq7OFnR7doxdeElGxI4MWyICJ0QtdzwHql9MamLMDLr?=
 =?iso-8859-1?Q?2hPkL/4/xntEytt/uTBKVBJlaRbfJHF3DvYiDB7k6WgbjpKgw8tl0QIvZc?=
 =?iso-8859-1?Q?jd/X/MmxCzrP+SvIWBt/1pGLDNPNuqEPy+DSlbotro92FPs1NVJAqNubiJ?=
 =?iso-8859-1?Q?RaU5HAgu4iFGZeXrnL6ACxA8TFdgys8pxwpUikjwa9z9d+5rOXjOr9ZeDq?=
 =?iso-8859-1?Q?aq38ucpoq8hMBRvoQvEBaae5Bm9dFSfAtbTGGG0bmm9q8S6k36xa6rttWj?=
 =?iso-8859-1?Q?tA38S6b/JHtvAwENjAM3DhJuR60ye6nCZFKSemqV9CBv+1vW1tD2rCeUul?=
 =?iso-8859-1?Q?WokSDZ3VC3cHul8T/V6K7p2+6L2Uw/264zKNS5DIvkZdh64h/kEvRKti9x?=
 =?iso-8859-1?Q?PzY7Y/mRwLjSMhXVTwwVtKDO4BbG08v/5Nag1A+ajFN/zrdJXAcS8hZFS9?=
 =?iso-8859-1?Q?xFiX2/5usdth5eg+QX8UF9nPxfoNXKJueKhUeUumMpicodqwSNnw0TP+Mv?=
 =?iso-8859-1?Q?h/g7lYkYWftNk5WBkRj+UhdgFnQfcwXqVd7+2DtzV3NdqwFiE9l8BBeXTS?=
 =?iso-8859-1?Q?LOYcJh7SZZJsYR2r38QU2KaAIEd2EW2k6y/qYSx11/uStj4I5fE4DuPJng?=
 =?iso-8859-1?Q?8k2+9ULNtqw87RcIk/r1hKsoN/GWjobTWCk1I2xfT5bA3EHt3jqJ/wNjxD?=
 =?iso-8859-1?Q?JrHPdBnio23fBQZkbUyoqD3C5IOau32jsZ7n5w6Q3mYjtD0TuzDdfsj3Id?=
 =?iso-8859-1?Q?17tF2C1flQQ+PIrdKjG5zw1mbX9z8gpM7/NWfFOT70QXjmE4fcSruSUZvw?=
 =?iso-8859-1?Q?V1HaZhPJhwVeWwWRWDxT3bmVnGkltQwCdE16wvB8MVigb6w4OGqyQ4247O?=
 =?iso-8859-1?Q?rmXlwqX4aA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hwN8WhCEOYxb1xzhzbmVty41pHuXWL6ENssqbsI5x+7acz7HNW/4JsKVLXIZSyHHLMSOOsFC5SSg9FcptYjeEtGyYuAuHAKQ67HJ9LBzS3I2L+YDJ7DdOnOHCzV2UZUQ0umQYw2krcqFdUh9bpD8/kZZe0ETVAyElf6ACzCWfuIwNQbbaisw2cl/6r3YTNsh49baIpjRKPSG6/EzkxUxmkKxIhMaUBoBvdiQ2dfo8VJb6FNQFEbhJ7otxpV7HVOEaD4nfxRfjmC4BU0CrigiVkFXquMLgtaiDxJEKRZA4l+Nv6UF7FHTAbVvOVJ64/IvqmjHxajYh4uPT7CKXmB4FA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b684bf-528e-434f-7c36-08df22ac15e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 06:44:20.6646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSofMhJhHvvZU9ddEbEfsx6g5eYHR0A/tX86sHGZw72enwqwcYEeZQTK0qNzgthoVUZCbycuTKqPFnHYGugn1mJeCA0UKpFAicJsU0FA4nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7166
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

The controller registers need a 4 byte access, but the 8 bytes at 0x80=0A=
are not registers. They are a SRAM buffer holding the EP0 SETUP packet.=0A=
A read or a write that is not 4 bytes returned the wrong data, so the=0A=
driver saw a broken SETUP packet.=0A=
=0A=
Introduce a separate SETUP MMIO region that handles 1, 2 and 4 byte=0A=
reads and writes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h | 11 ++++++--=0A=
 hw/usb/aspeed-udc.c         | 56 +++++++++++++++++++++++++++++++++----=0A=
 hw/usb/trace-events         |  2 ++=0A=
 3 files changed, 61 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index 7701c1aa34..42916c0bd6 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -24,11 +24,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)=
=0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCGadget, ASPEED_UDC_GADGET)=0A=
 =0A=
 /*=0A=
- * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte ba=
nk=0A=
- * per programmable endpoint from 0x200.=0A=
+ * Register map: root/global block at 0x000 - 0x07f, the SETUP buffer at=
=0A=
+ * 0x080 - 0x087, then one 0x10 byte bank per programmable endpoint from=
=0A=
+ * 0x200.=0A=
  */=0A=
 #define ASPEED_UDC_MEM_SIZE     0x300=0A=
-#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)=0A=
+#define ASPEED_UDC_ROOT_NR_REGS (0x80 >> 2)=0A=
+#define ASPEED_UDC_SETUP_BASE   0x80=0A=
+#define ASPEED_UDC_SETUP_SIZE   0x08=0A=
 #define ASPEED_UDC_EP_REG_BASE  0x200=0A=
 #define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)=0A=
 =0A=
@@ -62,9 +65,11 @@ struct AspeedUDCState {=0A=
 =0A=
     MemoryRegion udc_container;=0A=
     MemoryRegion root_mr;=0A=
+    MemoryRegion setup_mr;=0A=
     MemoryRegion *dram_mr;=0A=
     AddressSpace dram_as;=0A=
     uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];=0A=
+    uint8_t setup_buf[ASPEED_UDC_SETUP_SIZE];=0A=
     AspeedUDCEP ep[ASPEED_UDC_NUM_EP];=0A=
     qemu_irq irq;=0A=
 =0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 4c90b4f4c2..355512822b 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -58,9 +58,6 @@ REG32(UDC_EP0_CTRL, 0x30)=0A=
     FIELD(UDC_EP0_CTRL, STALL,              0, 1)=0A=
 REG32(UDC_EP0_DATA_BUFF, 0x34)=0A=
     FIELD(UDC_EP0_DATA_BUFF, BASE_ADDR,     0, 31)=0A=
-/* EP0 SETUP packet buffer: SETUP0 =3D bytes 0...3, SETUP1 =3D bytes 4...7=
 */=0A=
-REG32(UDC_SETUP0, 0x80)=0A=
-REG32(UDC_SETUP1, 0x84)=0A=
 =0A=
 /* Per programmable-endpoint registers (offset from the EP register base) =
*/=0A=
 REG32(EP_CONFIG, 0x00)=0A=
@@ -363,6 +360,45 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+static uint64_t aspeed_udc_setup_read(void *opaque, hwaddr offset,=0A=
+                                      unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    uint64_t value =3D 0;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        value |=3D (uint64_t)s->setup_buf[offset + i] << (8 * i);=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_setup_read(offset, size, value);=0A=
+=0A=
+    return value;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_setup_write(void *opaque, hwaddr offset,=0A=
+                                   uint64_t value, unsigned size)=0A=
+{=0A=
+    AspeedUDCState *s =3D ASPEED_UDC(opaque);=0A=
+    int i;=0A=
+=0A=
+    trace_aspeed_udc_setup_write(offset, size, value);=0A=
+=0A=
+    for (i =3D 0; i < size; i++) {=0A=
+        s->setup_buf[offset + i] =3D value >> (8 * i);=0A=
+    }=0A=
+}=0A=
+=0A=
+static const MemoryRegionOps aspeed_udc_setup_ops =3D {=0A=
+    .read =3D aspeed_udc_setup_read,=0A=
+    .write =3D aspeed_udc_setup_write,=0A=
+    .endianness =3D DEVICE_LITTLE_ENDIAN,=0A=
+    .valid =3D {=0A=
+        .min_access_size =3D 1,=0A=
+        .max_access_size =3D 4,=0A=
+    },=0A=
+};=0A=
+=0A=
 /*=0A=
  * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
  * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
@@ -708,6 +744,7 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
     int i;=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
+    memset(s->setup_buf, 0, sizeof(s->setup_buf));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
         s->ep[i].pkt =3D NULL;=0A=
@@ -754,6 +791,12 @@ static void aspeed_udc_realize(DeviceState *dev, Error=
 **errp)=0A=
                           ASPEED_UDC_ROOT_NR_REGS << 2);=0A=
     memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);=0A=
 =0A=
+    memory_region_init_io(&s->setup_mr, OBJECT(s), &aspeed_udc_setup_ops,=
=0A=
+                          s, TYPE_ASPEED_UDC ".setup",=0A=
+                          ASPEED_UDC_SETUP_SIZE);=0A=
+    memory_region_add_subregion(&s->udc_container,=0A=
+                                ASPEED_UDC_SETUP_BASE, &s->setup_mr);=0A=
+=0A=
     /* Each programmable endpoint has its own register bank */=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         g_autofree char *name =3D g_strdup_printf(TYPE_ASPEED_UDC ".ep%d",=
 i);=0A=
@@ -918,8 +961,11 @@ static void aspeed_udc_gadget_handle_control(USBDevice=
 *udev, USBPacket *p,=0A=
      * Reconstruct the 8-byte SETUP packet into the SETUP data buffer wher=
e=0A=
      * the guest gadget driver reads it from.=0A=
      */=0A=
-    s->regs[R_UDC_SETUP0] =3D type | (req << 8) | ((value & 0xffff) << 16)=
;=0A=
-    s->regs[R_UDC_SETUP1] =3D (index & 0xffff) | ((length & 0xffff) << 16)=
;=0A=
+    s->setup_buf[0] =3D type;=0A=
+    s->setup_buf[1] =3D req;=0A=
+    stw_le_p(&s->setup_buf[2], value);=0A=
+    stw_le_p(&s->setup_buf[4], index);=0A=
+    stw_le_p(&s->setup_buf[6], length);=0A=
 =0A=
     /* A new SETUP clears the EP0 STALL condition */=0A=
     s->regs[R_UDC_EP0_CTRL] &=3D ~R_UDC_EP0_CTRL_STALL_MASK;=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 80ead23358..aa260dacad 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -381,6 +381,8 @@ canokey_unrealize(void)=0A=
 # aspeed-udc.c=0A=
 aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " val=
ue 0x%x"=0A=
 aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " va=
lue 0x%x"=0A=
+aspeed_udc_setup_read(uint64_t offset, unsigned size, uint64_t value) "off=
set 0x%" PRIx64 " size %u value 0x%" PRIx64=0A=
+aspeed_udc_setup_write(uint64_t offset, unsigned size, uint64_t value) "of=
fset 0x%" PRIx64 " size %u value 0x%" PRIx64=0A=
 aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset=
 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offse=
t 0x%" PRIx64 " value 0x%x"=0A=
 aspeed_udc_pullup(int on, int attached) "on %d, attached %d"=0A=
-- =0A=
2.43.0=0A=

