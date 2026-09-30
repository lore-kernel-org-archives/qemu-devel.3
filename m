Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A55CA5FBB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBogq-0001pI-Vh; Wed, 30 Sep 2026 03:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogo-0001oK-6Q; Wed, 30 Sep 2026 03:25:18 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBogm-000289-50; Wed, 30 Sep 2026 03:25:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1/r4aIvMSng0LvFNkugTsb8cFq+JmH0j3fErhXOI50UP7NYl2mGPXZEOdkndDpe0gWKGPcODk++lJn//11UDfmYw114zV8mxUBvE8zviJ940t1mjtuXbkjS1CWkRAyPTVZ12MiqX4sX1zKo/MNB5YJ/gymUeiMZ92VodxNYSBmuw+qz8k+QY7dHRafov8YQhR8igZTOHSEywtnileT57aGYKAEm5LaShGmZqqg46DA3xSNa+qW6sj5yPT4LUVn31K7T8e+UdL6mEaZArq8D136WJBFfo4KYiwzhvQ+MLF1Xp9cdJl2hsiLsTX5zBbUKV1ovQx9AbpEcr/1uOJ8nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liAc1fFwiKS0I1QTnMtt2Y7uuFfiJCd3UWdy79v2Oeg=;
 b=ipV1Xe682036/rUlkqTQWjLbEtFFrIU+G5MSAOR/96ng8bnFQ3L1P7xfBEm3gOef6ofFLxHDWWJBWJJtOPhEJ/+cqQBR4kCwTcKKGN/zLQbENMJnWL+bB5LntoxRU82BxTFEx+/I5nKyCOD2ZdM25G5VaRwRSX29niI3QAmMZies2KrsPm5oZvN5yjnYoHpn1mljEbXZuWjsWjwwX68Kp+tPUe++E04MScgdkLBNhDX82RSMNVMib2pgpQIF6J9QW0qBkiNrngojtP/0HOmEXZpa/Zif8uA2OKt/lpDVCeIOlSt3L8hOjsJXvhSQpddaUUUOMgfbP7Aq6Ueqz470vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liAc1fFwiKS0I1QTnMtt2Y7uuFfiJCd3UWdy79v2Oeg=;
 b=L18n4nR1NN3lcMS8WBmXOq5PEAGVvabw/XRdm4f9Ni/sLV5/K/b4sbUV32/Hy3AYKJT5hjw1aTJcMA/YVz+hTuRHfwaD4oC9SirzzKBo0mBYJPw03KHyBYy6wJ0csKXtQw6MKeVazrgHaOhzbE52iyjkT8iTdF89ISUpLwuioXL0nScrt7J6uf3GtSGwylcxJ9RZfFoyxufXGy/QS6Okj3vTWijIYloJKZHo3we2bzHw60xnXBtu5YPSRMOKoyBvokMFURlpzCRQnr7QmJfP9tQppOD+DJXKpm8m+zo//tbkKjUh1+2ibILT9iq6MU4yCI6BFmpL470cEIPWr/bF8w==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6616.apcprd06.prod.outlook.com (2603:1096:101:168::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 07:25:09 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:25:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 06/11] hw/arm/aspeed: Remove unused unimplemented device
 fields
Thread-Topic: [PATCH v1 06/11] hw/arm/aspeed: Remove unused unimplemented
 device fields
Thread-Index: AQHdUKzSAovImkcL6EKhuATKgD905A==
Date: Wed, 30 Sep 2026 07:25:09 +0000
Message-ID: <20260930072501.2612119-7-jamin_lin@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6616:EE_
x-ms-office365-filtering-correlation-id: 998c301d-9f7b-4d5e-bdfd-08df1ec3f54f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: eO6Ytjccjkynsu9kZeZT9WVEtkEOj5dXG7NXCJQ/6GsgyWgLuDnx9NAdKEnbZuwardI1wwT489sVPc7Yx6E1nyWqXNQOjG+23nNf+deQX140GGJpvYIMuzdy3ahHPXZFYuiAkdxFQokaOEqtXy9CyozsDbZzdXfVyPDykvCqtb9LlsUnnCEmTCOuR75V4DaxjJFQM7R69UZEk8Akv0a7tfYTgZb5yDJkAQvFwpwNFxXG5cMPznpWmVs6BgFa25OIjcDfLzLQsMXNaauRkga2T6jzVsqR0zKcbgmnkDzJH2CPNUb6DUi4K7feA1NJeXM60qP+Z+BOSLWuxRUnZhwFe6u523I0+TkWvqWgedWzpOok4ibSRDCGdnjkcIwvamVNn1MGJOmJnKZp4DFXRkOJ8Eki1+4bWPFvTAAJp7rOGD4TsXdhnHZBZWCkk7m39VzK4bIrOkPZiWfaTguz1urCE4gAhx+q15KAwSVE3/T7zq887Tk7SHFGLKdhqLNl/WIUu9Xk+XFVW9jQBkiHfCmqzmbhI/GQ8H35IzVBY6Pg2XmMeOiNN5sD4c6vFXw7rF6BU0oD5Tbp9LO5r2eS7yGXRh9Dno72O3cE8mTu+4JrRfrD8Qg4j2fTCCxROsBmutTTl+prE3AivClvxXJSHFwqVf54dOADYEbuoENb1fDyUl3aOVzGeIj2pTMOL6wWjePsb22TOWt7nqtPpQ9fBLn2M/GK013QLjZvf3KiKDrwzVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L8KU6ChmSSQnq+tvw3YGR+wg5ythVzceTHNHSsZrPKHavTvel6K3a9fdf7?=
 =?iso-8859-1?Q?p+ZvPhmsAxf6WFNnVC6E/gfw+qjjf0eK/ipM8glVaNG9wMocvHYB4RUoxK?=
 =?iso-8859-1?Q?bu99gc6WikhLwM9lBYSVnisoEb80LRbST2XXYFYFYd3etsAhmDlgaYwTTD?=
 =?iso-8859-1?Q?oWVDdixlgOoeUp37dDSWkSjglicwJ4GjwNYBjOD4MPpGRlLryIBzPMxosu?=
 =?iso-8859-1?Q?xJJCE60YNbMWJDmQGy0l1+8Ufl9vv7JYhZdYmLqq2AODExoiKM8aAd6NpB?=
 =?iso-8859-1?Q?TrBEwPvi04XwKUC+zItKVtI8ypVaBfpvt8DnMVxkiSKnwoJUGQViS88N8b?=
 =?iso-8859-1?Q?NnIXV/uz0jgh6i686tWuntT3lRg80LBBmGE3sCqqu5eic9djQA9MQ+Lveo?=
 =?iso-8859-1?Q?7M/AS7lOgWhzf8MH1iKfO4WBwtZKZCrnQHuL4NCo6fJ8U42V1Mk6N1Mc3c?=
 =?iso-8859-1?Q?ODjADOdP9jNeDYi2hWnA1JE8kB9l6a1q/8y/JNoDrsxwUKFli9BjZkK73o?=
 =?iso-8859-1?Q?VD0PRCyofvBDTQ4F4WtWL/l82sfxsmN086tBmd+csGh3gkkJfKqiX2JTjy?=
 =?iso-8859-1?Q?RE0FdTkIXKSXvBYHL3gXOfyX/4+ZVodxBFePP4P8AaCsB75krtrYcdt0eI?=
 =?iso-8859-1?Q?zk/PFX/AAcxyH755sk/B+b9J9o4AGL6JQO0h0fJVkwxPYWAD50MZuZ7s45?=
 =?iso-8859-1?Q?3x8dIjip96+nm5UFCYVJLAuVh2oh9tmeAIc7Dzu30nzynMJxVkU9G0oMEl?=
 =?iso-8859-1?Q?8jXSwzdFUSkGjYxen+95uwFfVXnpLuf4PyjgNYXFYQ/6CxywH1mpiftbtT?=
 =?iso-8859-1?Q?JcupWz0qFqDrK5tJoXJYbvB/SnKi3CEZYhjfImk3G816L0HVeapgzxSKUv?=
 =?iso-8859-1?Q?INy3R1b+8KOeeiJOHtEh6tchRQmRWAgVb3PG62VFrpcfOAyasyOtdKpzth?=
 =?iso-8859-1?Q?xGULnk3W4fMq/IpxTyuZmqHd5OhpfTMoRrg0Oj4MtqU8XJg36/iJQtQlVm?=
 =?iso-8859-1?Q?S2R1hT8O3iEGlCyFpdvdIx5pKiFNMtGb8APBTMEPcs7cu8D5CA+OU727Yg?=
 =?iso-8859-1?Q?ubyiovlPe8xgP0rOkrtAxWoCeEUP7M8zF3eqvfI7TBmhZjT+R2HfPCLnQN?=
 =?iso-8859-1?Q?mEzOEvosp1Sn0RR5/l6apShLhXHQm7hFdKH/NpCeydy21qTCu0lDq2XRdi?=
 =?iso-8859-1?Q?l6kqJ6p++IB3XMqoARedwJffJz26QOpv9zCXVFr9yEVhfBqAno5vOL6bvk?=
 =?iso-8859-1?Q?zQYLQRGgv8jexlh1+kO4CZpPSgdxku338d+uZ+EwIumP63S4QMHnaFA07T?=
 =?iso-8859-1?Q?VJOLWGi94ZShVvDTB2IW+YgfHCnELhj1Ev7p514S93JWEfnE0mt4VAW0//?=
 =?iso-8859-1?Q?Pl06RDgASODdW1AZBFkvaFYqLhpJAK+sY70UZ5vt5uRumVtDrpX76OzDgg?=
 =?iso-8859-1?Q?zsZmU2yzyGdfOjYDTQTE9HVpDLGEI1me0TtqlRsJDxsZAO6pamRGV3HMeT?=
 =?iso-8859-1?Q?pMEHP3XK6lo3NXXRb+SSVF85375l0KYuJoHIV/NPwGrF0wBgj9W4iS3Mod?=
 =?iso-8859-1?Q?UwQNp8U1hD+tIXWbFQou9B2qLHILzZU+tIeVW5PzPvFYy78stwgw8+N+0L?=
 =?iso-8859-1?Q?2Jd9S5THqCMcJfIyp+8lRX/4vbKbNkOm4MP0/OGrcdUAeJKvYA0Fa+WIvG?=
 =?iso-8859-1?Q?Ss1jvFGYxS6MEyMQBbeW8ZRIe5SN7dTKWmyKesyugywZ6jEpTm+IPcQvKp?=
 =?iso-8859-1?Q?60ta/HqkIau/n4kXHhKhPRioYkQdf8Ms65MLNI2ar0DYwlQTT1pKJ49zJz?=
 =?iso-8859-1?Q?nUSKr80ikA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fMPWuIG7i48Bjp6Xad/fhtvKBa2QSTe37RsGKq2c3nmzdqVRETDS02N59iWO+jhQ38+HXtdGnMTAcVni3BqAe+AXTpWoRtjGzaTzY0+spLRFmTJl1lG0FJs06Y9d/6jrJd4BtO1fv7j9sQp+g1lgzDDnXSsT7gPAvM9R3w6KUR1CXlFyg8+kYNPolyjosOudeYzLNEx42rQtdczBZtsFmzAcU7Gmd4yvr1Q34UaEts5HAU9Uf7ZUiqnbvENEcA2985wQnbWTXI1yDCoxtvxKgCE/qDvfLD6Hz474L9NLprHiSu/1jrxpcoGZCmLoYablLemYq9EKJ3jFjno06acQVQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998c301d-9f7b-4d5e-bdfd-08df1ec3f54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:25:09.2930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf0lQJ2Bta+nQSeail/34CmjZyQEjBm0uUYcLuvD6HpdREvOKzaH2jssYy/Tu8uPmwaj14T9DKhRIgirTrVjCQySheu30dRu8d10Q+jMXHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6616
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

All Aspeed SoCs now use the "unimp" array and the AspeedUnimpDevice=0A=
table for their unimplemented devices. Remove the old fields in=0A=
AspeedSoCState and the ASPEED_JTAG_NUM define, which are not used=0A=
anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 10 ----------=0A=
 1 file changed, 10 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index a9ef4b3550..0ef45561e0 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -59,7 +59,6 @@=0A=
 #define ASPEED_CPUS_NUM  4=0A=
 #define ASPEED_MACS_NUM  4=0A=
 #define ASPEED_UARTS_NUM 13=0A=
-#define ASPEED_JTAG_NUM  2=0A=
 #define ASPEED_PCIE_NUM  3=0A=
 #define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
@@ -118,15 +117,6 @@ struct AspeedSoCState {=0A=
     AspeedPECIState peci;=0A=
     SerialMM uart[ASPEED_UARTS_NUM];=0A=
     Clock *sysclk;=0A=
-    UnimplementedDeviceState iomem;=0A=
-    UnimplementedDeviceState iomem0;=0A=
-    UnimplementedDeviceState iomem1;=0A=
-    UnimplementedDeviceState video;=0A=
-    UnimplementedDeviceState emmc_boot_controller;=0A=
-    UnimplementedDeviceState dpmcu;=0A=
-    UnimplementedDeviceState espi;=0A=
-    UnimplementedDeviceState udc;=0A=
-    UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];=0A=
     UnimplementedDeviceState unimp[ASPEED_UNIMP_NUM];=0A=
     AspeedAPB2OPBState fsi[2];=0A=
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];=0A=
-- =0A=
2.53.0=0A=

