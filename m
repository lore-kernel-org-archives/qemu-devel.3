Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CF8C61DC6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzsVm-0005VN-Se; Fri, 28 Aug 2026 05:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVh-0005UE-W0; Fri, 28 Aug 2026 05:04:30 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wzsVc-0003UH-Ud; Fri, 28 Aug 2026 05:04:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgbnmWlhPXwlqzof8nYzk++g16ZCZxty5p7S1U6SX1jE78fstY/CfExv0ZHijyhR1GAkctmgplHelIPIqH0/VbEdOnnkinFQDWxIMTmqtWQs/QGGNq1dRXVjORGFraBUfdnXiMxvqPPIyUboLyoWQ1pmQSvuTGYWHcj/bNr6W+Iio4n+sD9OPlc5cJT01N6dd27JU4ibJi6/OFxwJR5KU+kgDag6pceyOxTol5MC8tWDich0n8NH4sA07pExY1Qe5zYpJ/7/lIP5YT4E8tF4F1H8ixvynTjR9Gw9hv7cxFu9zgThrvJECFRDL/VTKSJGhGDpDg6ww2hdcguapJIWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS+ebVgKn2mh+tp0Eox0T2a9h5UCsmp7DbMgFcnVX2w=;
 b=MayDFkBvM2pkN1ObaIUq3I6LTK0r6wCVuEaAKCq28SIgnaa3CE7MLFaJlZDS3Te/Ec0FYv1RUjPeAb/PQE1GXFiKpqgU1tN5Y74aApMBop1uyCmgJL8iQCWfNqjb0w9p2Lq/J2e82mRJCabBZIcKxLawNShAdV9wn0RQmcijhVKhwfq8MZgxb3kQ/Gvgx+WC6RHW0m5n36ovRxCQ08i14eKP99h7PxDgv84RHeqNeq/x57h6Z/HxE0H0On48/9pL9vkvdvl/N22viqjl2R4+9ikWSJ21E1g6hV25R8UqhgGwu574edPrT4D4SiOtnw/iZ8w1M8huMBOM14bUoz/ZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS+ebVgKn2mh+tp0Eox0T2a9h5UCsmp7DbMgFcnVX2w=;
 b=kMDAiq5KR2NwpYh3V3x8ZtRyUxKvOqa6uafI+2MyZ7J6wjCGOkh5jb76gisnDFx8ua9MMzkiGRQiOIBBZ+Xwewh27gQOyrSeJ+OvVC2DNmSWKvFP362zLFbbXSdou06han/UfWpETvxUesuimHHriyfkBu5KtgR8OnHYBBl1Vx7yTP16rtrtxZlcZJHdUKBkT5vwv6233mKTUVDCa4sKRLLPCJdfypBFBTWzTaeCmuP8VTsNeJqmsk4nTao6L9Vxy0UpgCT3S3BnArWTkRbqM/yemqbJpyggZzpYbwLMMU3JFGbpCjQtbQ5xNNX0eMLK+3IWx9WZWGGonCviLY4PoA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 09:04:20 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:04:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Thread-Topic: [PATCH v2 3/4] hw/usb/aspeed-udc: Add programmable endpoint DMA
 transfers
Thread-Index: AQHdNsw0r9hVsRH2k0eVooTeymBgrA==
Date: Fri, 28 Aug 2026 09:04:17 +0000
Message-ID: <20260828090412.981841-4-jamin_lin@aspeedtech.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PS1PPF2A261C07C:EE_
x-ms-office365-filtering-correlation-id: 357e8f2c-f41d-4ae8-f5e2-08df04e358b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|921020|38070700021|6133799003|3023799007|56012099006|10067099003|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: yTKk0eN264hHvMtWJealb4P/2j/dmFukk+jJwQdR0qhrSkeG/p2PnkQbTJqJUa7rCCcHhSsJ9Cy4SOspQKZGnDMhlVi8kXdYviIpFLIsl8dmVl0PBcNZtW69q6cmnLVzt0nu/9zsRY2ghSZ2LAGiinnEu7HOFGWnwWgh88t2aJDXZ+rWxnlqcI1v7Hb6MIrk9K9RgnQwTR4vxQg/Hh3NloMiEiI9jiZcHRJXfnw29tT/3DzL1vYHfHAztALCCAgmievOUvTAPEQqOfpdwrjBwYaUly9Epi312omI8viqiwolmSHLJdsSHvqU0z+B6pgwkH0XctOBRabptwgs+B75dZZzVRLAUs617zCzpNc3KvRPoVCZ1/UKxHMctm3pIk/cKfcO6E/h82EV5rtMy9oSjIbbiTYWW2DN0EpXcK7cSYWChmdXwUqCBp6w4dsAKLfTAGNUyzzaztr9VClEHaoTa4UQl/SP9mW6tCqKUujIHl0xLKXeR9o2bX5l8Ovp+f3mZOxM1kgo+9RmyfIAdL8f0u272O4MPN1dex2ZMC+4uus9mtgqpNkVwt4X8SwR45U39M85YE0UxImqqCqfHfhS+CZRZPXoa0aOG2jXz783rgMscc+KeIGUZN5myeKzNO7V5y4/JD6xEwLbpsm8AEcm5cbscQux8GZqJisWd1nGmz2Ny1P4Irp3w7ojhBzRG7ZA2HrXD3yuTKIOyYa2MtaAxLQD/s1Gi0ZVw+o1Lq/YzfMPCvUcZF0QbiAuG+qu35aB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(921020)(38070700021)(6133799003)(3023799007)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ygRVQmtcOKvCRRYop3RMixUYjVZ/RxKx+Pozh2HEpheXnXzX6PnIUfLocU?=
 =?iso-8859-1?Q?l2FDKfipuIhcBnUVTP0BusxzDISC15+X4THO6HPi6qc8C6Bq94Ef7CPbuy?=
 =?iso-8859-1?Q?PaACrDZmH7ZazLALQ/oef1ssYw55Hkv1GMNdMNUnwXQ8RL3CPxkBEtltjM?=
 =?iso-8859-1?Q?0wYHLgydKJMOj/a4XWNtpFnkHt65RLqg/tXKSmjSCfW23Ow+61Jkkk8Ath?=
 =?iso-8859-1?Q?3Nq+HV8TJUbNApJLCM7Q1aSiV9dT5skBZGkHJt7pYJAfp6+CPo1JhHD6aD?=
 =?iso-8859-1?Q?EemWxOqpMfAM9Kr/oLTsBCqF7UeAKUFoafs96QsHgmsxIJp1OLdB2ublAZ?=
 =?iso-8859-1?Q?/jILhSSvod90QOT1AOOGppE5kSdMB4R0+uM1gwVNBIu7YOGXm6ZBbgBf5O?=
 =?iso-8859-1?Q?4lC75pMFy1hDvXOA6CYKaTZo7dJRwaO/+gKRikVjiGSvQFoiGY4UWyeuOd?=
 =?iso-8859-1?Q?dsKnGSER1aRIcqUTUmcGfccQ33lwMwmA+clUcn7xdDlRiPIJec+Xs/uCkg?=
 =?iso-8859-1?Q?+DYudCD2EAlZlKGjrwugXPb/xLNkRAvuC08oJABvIyRuHYozA0+bsxpvyQ?=
 =?iso-8859-1?Q?b2Mz7LuDRJnaPyEshU7A7zFM3L2jYdJ+uxt0UZT3lVQw3rV1YOX11da2hS?=
 =?iso-8859-1?Q?vkS6KVWo1PfXxUQfNIyR+tQkqLwTgh27tfbbnOiDMQTV8e1v9Mw7NGT2HJ?=
 =?iso-8859-1?Q?xWnhyAJruxi9ZdGe7Zyo8rl26et+ULaS7NJ7OWBVGSNuxSNLtZuBsAIt4a?=
 =?iso-8859-1?Q?S8AR73sDUQ4H0BLV3pFwTEVf0xD5Fpqpn27q0tHNZZ+q9f4cdxy2JmN7RL?=
 =?iso-8859-1?Q?V0VuhB8K5/onW2IifMCED3zntR1Mb8aYZdTQ/K7hRHb5CNvnhfahN7VDTA?=
 =?iso-8859-1?Q?2UB63Jm5mFix+uDIWbFbMTAsGq+DQ7/RsNiSVr39eN8UKHPTlhzozV5vE8?=
 =?iso-8859-1?Q?5LnpDgKaD/mh8cBg9VUeylFQDOiIdBS7gsHWzTZdp92VEo+yiZ2saZpFIj?=
 =?iso-8859-1?Q?R7zxPjuWXSAzB5ikUZoU92pSNULDF+pgCOqSkMfH+vKq4Ym15G1XnWQVli?=
 =?iso-8859-1?Q?KITHAYMUg+v5iN7xSJwgleEPVO0FfyE54yDA2aRfMx9UUVoH9ENIJd7LXM?=
 =?iso-8859-1?Q?q39p1ZFesUMy6xfY+/8Sx8aCGRWxFv9o4yADAKIaxaQIm9GAT755r8B4/5?=
 =?iso-8859-1?Q?i66SF9JA5BG7t//Uq1Sty1RlK+V2zZga/Reb5ytqRokxXFi5lLgtGEa3Ek?=
 =?iso-8859-1?Q?Swm9y29vHXQ6d0qHDVwL3lk7bVe4a+AFiKN/vcukpTiYcDlonsHoCoEAAO?=
 =?iso-8859-1?Q?bkWMbultm2xIaFEsx+c1Dfzxft1lpT3xDZG3pZhEm2QhAJPi7U0VJbYubz?=
 =?iso-8859-1?Q?x+wsC6jLDbj5zoXCzDANP+HcAK+H6QRD8k7mdA6Qx94rtX/5wsXLyNW9rB?=
 =?iso-8859-1?Q?21AouTPZWwcY/sDfbyKmjBPyt7GEeVniG9ZUCi9sE/PlZQczGtk2r8s81v?=
 =?iso-8859-1?Q?lx8LVrOrsMpP0+1QFY9J8iAnFVKsp2h4U7jDUCk/vu0hWlLsfan5GhV0Dm?=
 =?iso-8859-1?Q?mHDKH3o36lNnwGjf8acrH+reMu0A0QhjED7xNCyXKlxd1gKab/meh/+6p5?=
 =?iso-8859-1?Q?6/FdhBVc3NAU3P+mLxO/yoFnmzoSNXjQ1tmm4n4fTBpxdlgeIqYXupTasE?=
 =?iso-8859-1?Q?65mqpXMRidagtOc9ynlXGNa8Ia3uktM/DQM+MLHS2QNKhhlRi/CkJ/wEXL?=
 =?iso-8859-1?Q?xGoR8a1mKsHiJACrwdO04+Ul/hj0ULl42jrpoPb7WTzYRX4SQNTNBEAHP7?=
 =?iso-8859-1?Q?L5F/0MqwRg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: snijxxr868NnLuNLHKFX/OGncQmSDmnHuvVLipOaTi00GMi2304/OVk7s8nLvPyv3XiH1XJ/V0g4FspDfhfF/hxNLTKTcQBRFncOQocMK/yuYiA4gexuNkxGo7DaP2WWLV3OLyGgwlb+exC04E4a+RRt4NYhM4SGmst6B1vt/DwtJce9oCuNaB7jkY5u2ge5qRqr7C+Phz6sdsGPSBv5OIVeG8t9gpZhxDlkxIhxrztt7FYWmbDG1hj46mzTUDdiFEMFeZXBKw8u5cl7/bP0awRB181FTjyh74PrEM7cQEGjNhiG7h902CLx+k9biaCkpXnb3ElHAHw0y1K+qxbPYQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357e8f2c-f41d-4ae8-f5e2-08df04e358b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:04:17.9147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cgZlh+13a9RgbYvGSMNBa63N2cREEJhNhakrv8+MPBtZgS/K5VUWhG0fYywAi8LBgcl78qWavQnIrwjytgYEELZnMAAGbxkuH0fUZz15Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the bulk data plane for the four programmable endpoints. The gadget=0A=
driver queues IN data through the descriptor-list DMA ring and arms OUT=0A=
buffers through the single-stage DMA registers; host bulk transactions=0A=
are served from / delivered into those.=0A=
=0A=
The DMA mode is taken from EP_DMA_CTRL.DESC_OP_EN: IN endpoints use the=0A=
descriptor-list ring, OUT endpoints use single-stage buffers.=0A=
=0A=
A transfer larger than one host packet is served across several polls,=0A=
with the host packet parked (USB_RET_ASYNC) until the gadget queues (IN)=0A=
or arms (OUT) more data, then completed from the matching DMA kick.=0A=
=0A=
With this the gadget data endpoints work, e.g. a mass-storage gadget can=0A=
be enumerated and read/written end to end.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/usb/aspeed-udc.h |   8 +=0A=
 hw/usb/aspeed-udc.c         | 456 +++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events         |   4 +=0A=
 3 files changed, 463 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h=0A=
index ab9d016c61..7701c1aa34 100644=0A=
--- a/include/hw/usb/aspeed-udc.h=0A=
+++ b/include/hw/usb/aspeed-udc.h=0A=
@@ -42,6 +42,14 @@ typedef struct AspeedUDCEP {=0A=
     MemoryRegion mr;=0A=
     uint32_t regs[ASPEED_UDC_EP_NR_REGS];=0A=
     int index;=0A=
+=0A=
+    /*=0A=
+     * host packet parked until the guest gadget driver queues (IN) or=0A=
+     * arms (OUT) data=0A=
+     */=0A=
+    USBPacket *pkt;=0A=
+    /* bytes of the current IN descriptor already served */=0A=
+    uint32_t desc_off;=0A=
 } AspeedUDCEP;=0A=
 =0A=
 struct AspeedUDCGadget {=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index b944f72fdf..2f21129f10 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -76,12 +76,37 @@ REG32(EP_DMA_CTRL, 0x04)=0A=
     FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)=0A=
     FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)=0A=
 REG32(EP_DMA_BUFF, 0x08)=0A=
+    FIELD(EP_DMA_BUFF, BASE_ADDR,           0, 31)=0A=
 REG32(EP_DMA_STS, 0x0C)=0A=
     FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)=0A=
     FIELD(EP_DMA_STS, RPTR,                 8, 8)=0A=
     FIELD(EP_DMA_STS, WPTR,                 0, 8)=0A=
 =0A=
-#define ASPEED_UDC_EP0_MAXPKT      64=0A=
+#define ASPEED_UDC_EP0_MAXPKT   64=0A=
+#define ASPEED_UDC_EP_MAXPKT    1024=0A=
+=0A=
+/* DMA descriptor ring (256-stage mode) and descriptor data limits */=0A=
+#define ASPEED_UDC_DESCS_COUNT  256=0A=
+#define ASPEED_UDC_DESC_MAX_LEN 4096=0A=
+=0A=
+/* DMA processing-status idle codes */=0A=
+#define EP_DMA_CTRL_STS_RX_IDLE 0x0=0A=
+#define EP_DMA_CTRL_STS_TX_IDLE 0x8=0A=
+=0A=
+/* DMA descriptor (DES1) fields, in guest memory */=0A=
+#define ASPEED_EP_DESC1_IN_LEN(ctrl)   ((ctrl) & 0x1fff)=0A=
+/* interrupt-on-completion */=0A=
+#define ASPEED_EP_DESC1_INTR           BIT(31)=0A=
+=0A=
+/* Result of moving a host data packet through an endpoint's DMA */=0A=
+typedef enum {=0A=
+    /* whole packet transferred */=0A=
+    ASPEED_UDC_XFER_DONE,=0A=
+    /* not finished, keep parked */=0A=
+    ASPEED_UDC_XFER_MORE,=0A=
+    /* DMA failed */=0A=
+    ASPEED_UDC_XFER_ERROR,=0A=
+} AspeedUDCXferResult;=0A=
 =0A=
 static void aspeed_udc_update_irq(AspeedUDCState *s)=0A=
 {=0A=
@@ -101,6 +126,14 @@ static void aspeed_udc_raise_isr(AspeedUDCState *s, ui=
nt32_t mask)=0A=
     aspeed_udc_update_irq(s);=0A=
 }=0A=
 =0A=
+static void aspeed_udc_raise_ep_ack(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    trace_aspeed_udc_ep_ack(ep);=0A=
+    s->regs[R_UDC_EP_ACK_ISR] |=3D BIT(ep);=0A=
+    s->regs[R_UDC_ISR] |=3D R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+    aspeed_udc_update_irq(s);=0A=
+}=0A=
+=0A=
 /*=0A=
  * System bus device: MMIO register interface (guest gadget-driver facing)=
=0A=
  */=0A=
@@ -334,6 +367,287 @@ static const MemoryRegionOps aspeed_udc_ops =3D {=0A=
     },=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Copy len bytes from guest memory at addr into the IN packet, going thro=
ugh=0A=
+ * a bounce buffer one buf-full at a time. Returns false on DMA failure.=
=0A=
+ */=0A=
+static bool aspeed_udc_ep_copy_to_pkt(AspeedUDCState *s, int ep, uint32_t =
addr,=0A=
+                                      uint32_t len, USBPacket *p)=0A=
+{=0A=
+    uint8_t buf[ASPEED_UDC_EP_MAXPKT];=0A=
+    uint32_t copied =3D 0;=0A=
+    uint32_t seg;=0A=
+=0A=
+    while (copied < len) {=0A=
+        seg =3D MIN(len - copied, sizeof(buf));=0A=
+        if (address_space_read(&s->dram_as, addr + copied,=0A=
+                               MEMTXATTRS_UNSPECIFIED, buf, seg) !=3D MEMT=
X_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep%d IN data DMA read failed\n", __func__, =
ep);=0A=
+            return false;=0A=
+        }=0A=
+        usb_packet_copy(p, buf, seg);=0A=
+        copied +=3D seg;=0A=
+    }=0A=
+=0A=
+    return true;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN transfer: send data to the host by filling its IN packet from the=0A=
+ * buffers the guest gadget driver queued in the descriptor ring (from the=
=0A=
+ * read pointer to the write pointer).=0A=
+ *=0A=
+ * One host packet can be bigger than one descriptor's buffer, so we copy =
from=0A=
+ * several descriptors in a row until the packet is full or the ring is em=
pty.=0A=
+ * If a descriptor is too big for the space left in the packet, we copy on=
ly=0A=
+ * part of it now and copy the rest on the next call; desc_off remembers h=
ow=0A=
+ * far we got. We move the read pointer to the next descriptor only after =
a=0A=
+ * descriptor is fully copied, so the guest gadget driver can read the poi=
nter=0A=
+ * and see how much was sent.=0A=
+ *=0A=
+ * This function raises the endpoint ACK by itself when the ring becomes e=
mpty=0A=
+ * or when a descriptor asks for an interrupt.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_in(AspeedUDCState *s, int ep=
,=0A=
+                                                 USBPacket *p)=0A=
+{=0A=
+    QEMUIOVector *pktiov =3D p->combined ? &p->combined->iov : &p->iov;=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t mps =3D FIELD_EX32(e->regs[R_EP_CONFIG], EP_CONFIG, MAX_PKT);=
=0A=
+    uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t desc_base =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t desc_addr;=0A=
+    uint32_t remaining;=0A=
+    uint32_t desc_ctrl;=0A=
+    uint32_t pkt_space;=0A=
+    /* des_0: data buffer base address, des_1: control/status */=0A=
+    uint32_t desc[2];=0A=
+    uint32_t offset;=0A=
+    uint32_t chunk;=0A=
+    uint32_t dlen;=0A=
+    bool done =3D false;=0A=
+    bool ack =3D false;=0A=
+=0A=
+    if (mps =3D=3D 0) {=0A=
+        /* a MAX_PKT field of 0 means the maximum packet size */=0A=
+        mps =3D ASPEED_UDC_EP_MAXPKT;=0A=
+    }=0A=
+=0A=
+    trace_aspeed_udc_ep_data_in(ep, rptr, wptr, pktiov->size);=0A=
+=0A=
+    /* walk the queued descriptors, filling the packet */=0A=
+    while (rptr !=3D wptr) {=0A=
+        if (address_space_read(&s->dram_as, desc_base + rptr * sizeof(desc=
),=0A=
+                               MEMTXATTRS_UNSPECIFIED, desc,=0A=
+                               sizeof(desc)) !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep%d descriptor DMA read failed\n",=0A=
+                          __func__, ep);=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+        desc_addr =3D le32_to_cpu(desc[0]) & R_EP_DMA_BUFF_BASE_ADDR_MASK;=
=0A=
+        desc_ctrl =3D le32_to_cpu(desc[1]);=0A=
+        dlen =3D ASPEED_EP_DESC1_IN_LEN(desc_ctrl);=0A=
+        offset =3D e->desc_off;=0A=
+        /* how much to copy: min(descriptor bytes left, packet space left)=
 */=0A=
+        remaining =3D dlen > offset ? dlen - offset : 0;=0A=
+        pkt_space =3D pktiov->size > (uint32_t)p->actual_length ?=0A=
+                    pktiov->size - (uint32_t)p->actual_length : 0;=0A=
+        chunk =3D MIN(remaining, pkt_space);=0A=
+=0A=
+        if (!aspeed_udc_ep_copy_to_pkt(s, ep, desc_addr + offset, chunk, p=
)) {=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+        e->desc_off +=3D chunk;=0A=
+=0A=
+        if (e->desc_off < dlen) {=0A=
+            /*=0A=
+             * The packet ran out of space in the middle of this descripto=
r,=0A=
+             * so only part of it was copied. Stop here, and leave the rea=
d=0A=
+             * pointer on this descriptor: the next call resumes copying t=
he=0A=
+             * rest (desc_off remembers how far we got).=0A=
+             */=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * This descriptor was copied in full. Advance the read pointer to=
 the=0A=
+         * next descriptor and reset desc_off so it starts from the beginn=
ing.=0A=
+         */=0A=
+        rptr =3D (rptr + 1) % ASPEED_UDC_DESCS_COUNT;=0A=
+        e->desc_off =3D 0;=0A=
+        if (desc_ctrl & ASPEED_EP_DESC1_INTR) {=0A=
+            ack =3D true;=0A=
+        }=0A=
+        /*=0A=
+         * This descriptor is shorter than the max packet size, i.e. a sho=
rt=0A=
+         * (or zero-length) packet. In USB that marks the end of the trans=
fer,=0A=
+         * so stop here.=0A=
+         */=0A=
+        if (dlen < mps) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+        /*=0A=
+         * The packet is now completely full, so the host has received all=
 the=0A=
+         * data it asked for. Stop here.=0A=
+         */=0A=
+        if ((uint32_t)p->actual_length >=3D pktiov->size) {=0A=
+            done =3D true;=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS], EP_DMA_STS=
,=0A=
+                                       RPTR, rptr);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_TX_IDLE)=
;=0A=
+    /* The guest gadget driver completes its request when the ring drains =
*/=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        ack =3D true;=0A=
+    }=0A=
+    if (ack) {=0A=
+        aspeed_udc_raise_ep_ack(s, ep);=0A=
+    }=0A=
+=0A=
+    return done ? ASPEED_UDC_XFER_DONE : ASPEED_UDC_XFER_MORE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OUT transfer: receive data from the host by copying its OUT packet into=
 the=0A=
+ * buffer the guest gadget driver set up (single-stage mode).=0A=
+ *=0A=
+ * A host packet can be bigger than one buffer, so we copy at most PKT_SIZ=
E=0A=
+ * bytes per call, continuing from where the last call stopped=0A=
+ * (p->actual_length). The caller keeps the packet parked until it is full=
y=0A=
+ * copied.=0A=
+ */=0A=
+static AspeedUDCXferResult aspeed_udc_ep_xfer_out(AspeedUDCState *s, int e=
p,=0A=
+                                                  USBPacket *p)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t chunk =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, PKT_S=
IZE);=0A=
+    uint32_t remaining =3D p->iov.size - (uint32_t)p->actual_length;=0A=
+    uint32_t data_buf_addr =3D e->regs[R_EP_DMA_BUFF];=0A=
+    uint32_t len =3D MIN(remaining, chunk);=0A=
+    uint8_t buf[ASPEED_UDC_DESC_MAX_LEN];=0A=
+=0A=
+    if (data_buf_addr && len) {=0A=
+        len =3D MIN(len, sizeof(buf));=0A=
+        usb_packet_copy(p, buf, len);=0A=
+        if (address_space_write(&s->dram_as, data_buf_addr,=0A=
+                                MEMTXATTRS_UNSPECIFIED, buf,=0A=
+                                len) !=3D MEMTX_OK) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "%s: ep%d OUT data DMA write failed\n",=0A=
+                          __func__, ep);=0A=
+            return ASPEED_UDC_XFER_ERROR;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS],=0A=
+                                       EP_DMA_STS, PKT_SIZE, len);=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(e->regs[R_EP_DMA_STS],=0A=
+                                       EP_DMA_STS, WPTR, 0);=0A=
+    e->regs[R_EP_DMA_CTRL] =3D FIELD_DP32(e->regs[R_EP_DMA_CTRL], EP_DMA_C=
TRL,=0A=
+                                        PROC_STS, EP_DMA_CTRL_STS_RX_IDLE)=
;=0A=
+    aspeed_udc_raise_ep_ack(s, ep);=0A=
+=0A=
+    if ((uint32_t)p->actual_length >=3D p->iov.size) {=0A=
+        return ASPEED_UDC_XFER_DONE;=0A=
+    }=0A=
+=0A=
+    return ASPEED_UDC_XFER_MORE;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * IN kick: the guest gadget driver wrote EP_DMA_STS to tell us it queued =
more=0A=
+ * IN data to send to the host. If a host IN request is already waiting=0A=
+ * (parked because there was no data before), send the data now and finish=
 it.=0A=
+ * If the request needs more data than was queued, keep it parked and wait=
 for=0A=
+ * the next kick.=0A=
+ */=0A=
+static void aspeed_udc_ep_in_kick(AspeedUDCState *s, int ep, uint32_t val)=
=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t cur_rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RP=
TR);=0A=
+    uint32_t new_rptr =3D FIELD_EX32(val, EP_DMA_STS, RPTR);=0A=
+    uint32_t new_wptr =3D FIELD_EX32(val, EP_DMA_STS, WPTR);=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /*=0A=
+     * A normal kick only sets the write pointer and leaves the read-point=
er=0A=
+     * field 0 (the read pointer is ours to advance). The guest resets the=
 ring=0A=
+     * by writing a read pointer that is non-zero and equal to the write=
=0A=
+     * pointer.=0A=
+     *=0A=
+     * We check non-zero as well as equal: on a normal kick whose write po=
inter=0A=
+     * just wrapped back to 0, both fields would be 0, so an "equal" test =
alone=0A=
+     * would look like a reset by mistake.=0A=
+     */=0A=
+    if (new_rptr !=3D 0 && new_rptr =3D=3D new_wptr) {=0A=
+        cur_rptr =3D new_rptr;=0A=
+        e->desc_off =3D 0;=0A=
+    }=0A=
+    /* store the guest's write, but keep our own read pointer */=0A=
+    e->regs[R_EP_DMA_STS] =3D FIELD_DP32(val, EP_DMA_STS, RPTR, cur_rptr);=
=0A=
+=0A=
+    /* nothing to do unless an IN packet is waiting and the ring has data =
*/=0A=
+    if (!p || cur_rptr =3D=3D new_wptr) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * OUT kick: the guest gadget driver wrote EP_DMA_STS to give us a buffer =
for=0A=
+ * OUT data. If an OUT packet is already waiting (parked because there was=
 no=0A=
+ * buffer before), copy its data into the buffer now and finish it. If the=
=0A=
+ * packet has more data than fits, keep it parked and wait for the next bu=
ffer.=0A=
+ */=0A=
+static void aspeed_udc_ep_out_kick(AspeedUDCState *s, int ep)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    USBPacket *p =3D e->pkt;=0A=
+=0A=
+    /* nothing to do unless an OUT packet is waiting and a buffer is ready=
 */=0A=
+    if (!p || !FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR)) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        e->pkt =3D NULL;=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        usb_packet_complete(USB_DEVICE(s->usbgadget), p);=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned s=
ize)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
@@ -350,10 +664,31 @@ static void aspeed_udc_ep_write(void *opaque, hwaddr =
offset, uint64_t data,=0A=
                                 unsigned size)=0A=
 {=0A=
     AspeedUDCEP *e =3D opaque;=0A=
+    AspeedUDCState *s =3D container_of(e - e->index, AspeedUDCState, ep[0]=
);=0A=
     uint32_t reg =3D offset >> 2;=0A=
+    uint32_t val =3D data;=0A=
 =0A=
-    trace_aspeed_udc_ep_write(e->index, offset, data);=0A=
-    e->regs[reg] =3D data;=0A=
+    trace_aspeed_udc_ep_write(e->index, offset, val);=0A=
+=0A=
+    switch (reg) {=0A=
+    case R_EP_DMA_BUFF:=0A=
+        e->regs[reg] =3D val & R_EP_DMA_BUFF_BASE_ADDR_MASK;=0A=
+        break;=0A=
+    case R_EP_DMA_STS:=0A=
+        val &=3D 0x77ffffff;=0A=
+        if (FIELD_EX32(e->regs[R_EP_DMA_CTRL], EP_DMA_CTRL, DESC_OP_EN)) {=
=0A=
+            /* IN, descriptor-list mode */=0A=
+            aspeed_udc_ep_in_kick(s, e->index, val);=0A=
+        } else {=0A=
+            /* OUT, single-stage mode */=0A=
+            e->regs[reg] =3D val;=0A=
+            aspeed_udc_ep_out_kick(s, e->index);=0A=
+        }=0A=
+        break;=0A=
+    default:=0A=
+        e->regs[reg] =3D val;=0A=
+        break;=0A=
+    }=0A=
 }=0A=
 =0A=
 static const MemoryRegionOps aspeed_udc_ep_ops =3D {=0A=
@@ -379,6 +714,8 @@ static void aspeed_udc_reset_hold(Object *obj, ResetTyp=
e type)=0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
     for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
         memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));=0A=
+        s->ep[i].pkt =3D NULL;=0A=
+        s->ep[i].desc_off =3D 0;=0A=
     }=0A=
 =0A=
     /* Device-reset default: root, DMA and EP-pool soft-reset bits set */=
=0A=
@@ -463,6 +800,95 @@ static void aspeed_udc_class_init(ObjectClass *klass, =
const void *data)=0A=
  * through the MMIO register interface above.=0A=
  */=0A=
 =0A=
+static int aspeed_udc_find_ep(AspeedUDCState *s, int ep_nr, bool is_out)=
=0A=
+{=0A=
+    uint32_t cfg;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        cfg =3D s->ep[i].regs[R_EP_CONFIG];=0A=
+=0A=
+        if (!FIELD_EX32(cfg, EP_CONFIG, ENABLE) ||=0A=
+            FIELD_EX32(cfg, EP_CONFIG, EP_NUM) !=3D ep_nr) {=0A=
+            continue;=0A=
+        }=0A=
+        if (FIELD_EX32(cfg, EP_CONFIG, DIR_OUT) =3D=3D is_out) {=0A=
+            return i;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_in(AspeedUDCState *s, int ep, USBPacket *p)=
=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t rptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, RPTR);=
=0A=
+    uint32_t wptr =3D FIELD_EX32(e->regs[R_EP_DMA_STS], EP_DMA_STS, WPTR);=
=0A=
+=0A=
+    if (rptr =3D=3D wptr) {=0A=
+        /*=0A=
+         * No IN data is queued yet. Save the packet and return ASYNC=0A=
+         * instead of NAK. A NAK would make the host retry slowly.=0A=
+         * aspeed_udc_ep_in_kick() serves and completes this packet later,=
=0A=
+         * once the guest gadget driver queues descriptors.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_in(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        /* not fully sent yet: save the packet, wait for more descriptors =
*/=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void aspeed_udc_ep_data_out(AspeedUDCState *s, int ep, USBPacket *p=
)=0A=
+{=0A=
+    AspeedUDCEP *e =3D &s->ep[ep];=0A=
+    uint32_t sts =3D e->regs[R_EP_DMA_STS];=0A=
+=0A=
+    trace_aspeed_udc_ep_data_out(ep, FIELD_EX32(sts, EP_DMA_STS, WPTR),=0A=
+                                 FIELD_EX32(sts, EP_DMA_STS, PKT_SIZE),=0A=
+                                 p->iov.size);=0A=
+    if (!FIELD_EX32(sts, EP_DMA_STS, WPTR)) {=0A=
+        /*=0A=
+         * No OUT buffer is ready yet. Save the packet and return ASYNC=0A=
+         * instead of NAK. Writing now could use an old buffer address and=
=0A=
+         * lose the data (for example a mass-storage CBW). A NAK would mak=
e=0A=
+         * the host retry slowly. aspeed_udc_ep_out_kick() delivers this=
=0A=
+         * packet later, once the guest gadget driver sets up a buffer.=0A=
+         */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    switch (aspeed_udc_ep_xfer_out(s, ep, p)) {=0A=
+    case ASPEED_UDC_XFER_DONE:=0A=
+        p->status =3D USB_RET_SUCCESS;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_MORE:=0A=
+        /* not fully received yet: save the packet, wait for the next buff=
er */=0A=
+        e->pkt =3D p;=0A=
+        p->status =3D USB_RET_ASYNC;=0A=
+        break;=0A=
+    case ASPEED_UDC_XFER_ERROR:=0A=
+        p->status =3D USB_RET_IOERROR;=0A=
+        break;=0A=
+    }=0A=
+}=0A=
+=0A=
 static void aspeed_udc_gadget_handle_reset(USBDevice *udev)=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
@@ -526,17 +952,37 @@ static void aspeed_udc_gadget_handle_control(USBDevic=
e *udev, USBPacket *p,=0A=
 =0A=
 static void aspeed_udc_gadget_handle_data(USBDevice *udev, USBPacket *p)=
=0A=
 {=0A=
-    /* Programmable endpoint (bulk) transfers are added in a later patch. =
*/=0A=
-    p->status =3D USB_RET_STALL;=0A=
+    AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    bool is_out =3D (p->pid =3D=3D USB_TOKEN_OUT);=0A=
+    int ep =3D aspeed_udc_find_ep(s, p->ep->nr, is_out);=0A=
+=0A=
+    trace_aspeed_udc_handle_data(p->ep->nr, is_out ? "OUT" : "IN",=0A=
+                                 p->iov.size, ep);=0A=
+    if (ep < 0) {=0A=
+        p->status =3D USB_RET_STALL;=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    if (is_out) {=0A=
+        aspeed_udc_ep_data_out(s, ep, p);=0A=
+    } else {=0A=
+        aspeed_udc_ep_data_in(s, ep, p);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_gadget_cancel_packet(USBDevice *udev, USBPacket *p)=
=0A=
 {=0A=
     AspeedUDCState *s =3D ASPEED_UDC_GADGET(udev)->udc;=0A=
+    int i;=0A=
 =0A=
     if (s->ep0_packet =3D=3D p) {=0A=
         s->ep0_packet =3D NULL;=0A=
     }=0A=
+    for (i =3D 0; i < ASPEED_UDC_NUM_EP; i++) {=0A=
+        if (s->ep[i].pkt =3D=3D p) {=0A=
+            s->ep[i].pkt =3D NULL;=0A=
+        }=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_udc_gadget_realize(USBDevice *udev, Error **errp)=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 098c3d6179..80ead23358 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -389,3 +389,7 @@ aspeed_udc_reset(uint32_t ier) "bus reset, ier 0x%x"=0A=
 aspeed_udc_ep0_setup(uint8_t type, uint8_t req, uint16_t value, uint16_t i=
ndex, uint16_t length, int dir_in, int addr) "bmRequestType 0x%02x, bReques=
t 0x%02x, wValue 0x%04x, wIndex 0x%04x, wLength %d, dir_in %d, addr %d"=0A=
 aspeed_udc_ep0_ctrl_write(uint32_t val, int dir_in, uint32_t offset) "val =
0x%x, dir_in %d, off %u"=0A=
 aspeed_udc_ep0_complete(int dir_in, int actual) "dir_in %d, actual %d"=0A=
+aspeed_udc_handle_data(int ep_nr, const char *dir, uint32_t iov, int ep_id=
x) "ep_nr %d, %s, iov %u, ep_idx %d"=0A=
+aspeed_udc_ep_data_in(unsigned ep, uint32_t rptr, uint32_t wptr, uint32_t =
iov) "ep %u, rptr %u, wptr %u, iov %u"=0A=
+aspeed_udc_ep_data_out(unsigned ep, uint32_t wptr, uint32_t avail, uint32_=
t iov) "ep %u, wptr %u, avail %u, iov %u"=0A=
+aspeed_udc_ep_ack(unsigned ep) "ep %u"=0A=
-- =0A=
2.53.0=0A=

