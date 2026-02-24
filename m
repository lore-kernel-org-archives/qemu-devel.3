Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D8AEFB811
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumz8-0002AF-Sr; Tue, 24 Feb 2026 02:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumyu-00029c-P7; Tue, 24 Feb 2026 02:37:23 -0500
Received: from mail-japanwestazon11022084.outbound.protection.outlook.com
 ([40.107.75.84] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumyr-00054H-9Z; Tue, 24 Feb 2026 02:37:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxN/b5zDZPwVx9NS4Kvxy+o1XLbS5rIdWmz6USnZIqd2sXHTTmnlUJFibpyL45Q9j92ASfd0Fyi3g97dx5rECJz8walE6yVGcOzFca+hk22tbhLho5EBs9zMlrxnXOVBrkJnk71ZM71jk6Vqa/qu0EvK2kUFjTevRaWghKCFuTc6TblGnYoF6bom2WlklV4L+1gTapEYqkaj9z+kqlar6feBCW1BunOSEYvZ0mTDEr+JU1kUoJn/ts4AqjaNWOn7UnjU6Un7dGV1KXJHwbN/6SC2K3OfhmCcMWsZe9U569WaWNHbIJSxzIsShTuWoqo1PZz7G0jTnstZLbnDdJT42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye5dgOrlamF1YP13KyxebLisxmVjs5eoUoR90bKRkeM=;
 b=s3hZRQPqMYO/M+/49Pk5bXYf2qY/XCwmgeIxb2Vp6IQisTe0gkx1kQog1Bx1iz46FjfhBFAWlAZ1brlUCy+F4X8OMgYg1/2MG5kx+Ft/8MOTnbA/jzgLwmbySx7W2N10B38g5RHRKtijLN0c8AzWbtKtkYeAEjeedilld3GCI5xgy1DtUUknK6WXjNslw4YRankvBarOofdYvCvq052w2Zk5WE5kOx5ea8tKCi7V2oFMcNjBFg9i20/tkJqfJOcMzvNx5GBHURSq0zPYLxVRpZGniYDpNO/S5UIbej+eZZvG4jZKOZwKN24kw0k5F4m8dVRU35yANXfed8W6UZ0j7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye5dgOrlamF1YP13KyxebLisxmVjs5eoUoR90bKRkeM=;
 b=RBcBSvgdUY5FiVr6+ssliHiI7LyGnHwvKm2VvcuX9jhSSfYD0T33kbte7GVeqeuuOKJ95t6AxSBP/6jVzTfuiq3jYyKV1ByD9eU0HpaGpuOSnGGMtkLoSJQpnGPwnEh+36o9CNwkHqTd4Cx63l6P8F5LrI7YvX9737+E9eVm1iPRvHDA41scU8FVT5fJzkeemFp3qUP2dJIhKVB2IVfUiGuBpCxeX5EP2rlbPZ9wA9vPumgGAXDzSgNEk0lZXX0GkStkgiMlYqo3MsFmZeVBNgcg90QYqjWRoN3RzuwZtbgBeZRDkbNQVJHZfggJgSBhO3AtFHpFcOY5+eLfvjDHgA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPF2BE5BD2CD.apcprd06.prod.outlook.com (2603:1096:108:1::7ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Tue, 24 Feb
 2026 07:32:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:32:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1] hw/i2c/aspeed_i2c: Fix DMA64 address handling
Thread-Topic: [PATCH v1] hw/i2c/aspeed_i2c: Fix DMA64 address handling
Thread-Index: AQHcpV+vxH9fN/w7TkCKdAJqmFsUUA==
Date: Tue, 24 Feb 2026 07:32:09 +0000
Message-ID: <20260224073207.985162-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPF2BE5BD2CD:EE_
x-ms-office365-filtering-correlation-id: bf97f616-2930-4dd4-10a8-08de7376d181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ARe078LMWRAPYsoJs72KqmNFobE7ebhrRf6nZh+hLs/xFoVTdcsBW4yn0m?=
 =?iso-8859-1?Q?BdQgCEXXnPm1whVB9lLxrCXxOXk5+Buf05Wg2KLDZXQGy1fvvCyuVA6LEH?=
 =?iso-8859-1?Q?wXaYnYgahrjhHlkSX/NSE57rpwkwZtPsP6AGgPZGvAy4pK35HpwL98D2Zh?=
 =?iso-8859-1?Q?3cpCY9CBtuFfxMwy5zlphnFPsI6AgNSbiq++KUcYyknxAB1TReJJ8x2YF3?=
 =?iso-8859-1?Q?H3KZNKlAf1o4FCnz4Br6yHlf7S0KkcrE8JffOHXHam2hZISX8bGcoiVGyk?=
 =?iso-8859-1?Q?g1cCmBFXOkLmRcm2c2oRQcuvnyWA6sN0X9fyVzLSPqLiC6MUj12g0vNIrh?=
 =?iso-8859-1?Q?8KCBKjSEoaGXCKyRO0qjda3NMCLFM6e2BhiHwvKQzs4uZ4Z/i81JSXT3xh?=
 =?iso-8859-1?Q?cpL6zkuOiRKfCxc49f5VEEPW1l3Q8NKbg6/lM9XM9geabgDSeXyNcP/vCx?=
 =?iso-8859-1?Q?DEWbMXZNkdnF5xt51CUb3wjXgkh0FSKY+j/OIZD5yFDq4gFOBJ5BxqPRqu?=
 =?iso-8859-1?Q?2yw9FyLnFpVRCKF9lc1jb1MGCo04vdXsfEXVJflhC+0FPyLRfBPjUxLshO?=
 =?iso-8859-1?Q?r++DW2kXscCPi831i7ZlcoJzoIlK95zBUQjND1cp+UvpyAqRf5Ynq7gA07?=
 =?iso-8859-1?Q?fzkP7xgWd2RWqB0dc6XL1X1cggRo5dvfngLT9B1ysGUk9r4Fr/HHdislth?=
 =?iso-8859-1?Q?tmh508y+Jpk8KOxV/FeJu9RSRVAPmLeBZqvii9Oc4XaebZnnjJ5E6ekBog?=
 =?iso-8859-1?Q?BEug5EPu5NZY6ym0iwHDD1DWKILHR3UFt97JvyttzxWRaYx9i3TgpcF736?=
 =?iso-8859-1?Q?gJO8ngmgPZJkl7xMVK0TQSGl1SpUCke7FtNYohNrc2HPxWIAgNn90KeS8O?=
 =?iso-8859-1?Q?kpkaLuhBTQdY7FYZlXf52pCDcvGkClDyQugiwNbf81+08oHiTcEdVYpRAo?=
 =?iso-8859-1?Q?NrTri2t3Y/6yfuXURdL2DerE/C7PZcdp0d7SGAepOsQBNZDosX6um/B37z?=
 =?iso-8859-1?Q?Ol237ENQPhcvi+MtfNEjRSpLfUQSNq6kWVWXdu+5aoafGrtz0QTQOaLHHm?=
 =?iso-8859-1?Q?R8+CXYfiOb8pwM/YWnrMjyXzTcPSBaW2UGoEvqa+lWNMfg75fm8uQ0+WIn?=
 =?iso-8859-1?Q?PjFIbXctltIszcPas/AliFvDZyjwyNie38zjwPn4JQh9KyMDNtNdeXJV1x?=
 =?iso-8859-1?Q?1fovqYdNVFuzi5VXHYtW59KGdh6PG+DjzjzS6co6dTpANmWGU4Enh2cEoI?=
 =?iso-8859-1?Q?drBNJvsfK5+tppCEaQkm/F29naUtgYuhaDfkqHpf2Y5hIPWAfQjVCZ5aX7?=
 =?iso-8859-1?Q?nr9SiVw2ceK4260+CH8DuzKKmh7Uq5ZOuTyEnKszLP5g/0S7RnUUZ0/j7W?=
 =?iso-8859-1?Q?0/DpoLWg9/zUjhlpRP5stdYlLkCBK6hmDSsPDLLOIrFugP6auKwNJ+816N?=
 =?iso-8859-1?Q?8CYOHBcGEO7TZ+S2df2IqlDyjnFVcPos4i5XLDe/dtTci344gl3iZVYDTf?=
 =?iso-8859-1?Q?hpMHg/KS5qyl71xQd6u0y31T0zreB/f0dU+k60eWSZBA6p3c1JQzUa9F6z?=
 =?iso-8859-1?Q?a6zDoj0ChLQCEpCWY677TUuqqOO0OstReIROxPZFkuJAj/OFjckki/T3R3?=
 =?iso-8859-1?Q?Y8VJhMsjUc7d3pZ4yyU/9k0wscXJPnrPryuRuTXIrc/xOriHe05XhW71QY?=
 =?iso-8859-1?Q?kaVOi/TObEL824Qb/9g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JPDlouEMvCOUDNzfTWt5Qo8wrEe0fzj1pFaeUwcJMFUqo4V9BcHuTcj5lV?=
 =?iso-8859-1?Q?SYajKsuNVrM2yklvjMxYzbxfQBXft1sbV1oQGAEudz1e14mpJH/SNbDeOl?=
 =?iso-8859-1?Q?TMbHqBdztMafAaY++OtoqYl3snQDZCd4o55xxEkwoil4uyYHY2noeDjjqI?=
 =?iso-8859-1?Q?WNNTZAHzVTbb7G/EXlQV4VEYjt341oZk9XR7D4BzfktNDF3yQzBUO8BxaX?=
 =?iso-8859-1?Q?qxgbhPPUGxFdRJJ26WgnH6iaYgIvKE5TfCrZCoGJfDDs7n1+hzMYGJCkpF?=
 =?iso-8859-1?Q?5zEff9ZQPmoKwRxvEn4/g84+zo6GI/YO5reiGkBMIh6k3aAiuceAZzoOwm?=
 =?iso-8859-1?Q?3rtT70Dhtth4EZpiq2LIrhGnKJXI+vDwPYU4LVZMPeMyXIO/TLM5z8fwAZ?=
 =?iso-8859-1?Q?KcVT3HfVtXdSWsV4NOK6nIaT5Fp1+Yty542ms7+qZoJxzFPoNw47dawCv4?=
 =?iso-8859-1?Q?VBF/4lSH0YQACTXj/rWPEXvK8UYdSHjYoewSIx65WsjoOao4vHZPxE6RpS?=
 =?iso-8859-1?Q?AEDqr194SVIfKD8dzM7gIrm6wJAD0QhcGe+UzUlX15w2gvxq+TtA1PZZh7?=
 =?iso-8859-1?Q?jzhAzmRPaUW7WpQpZqfZVwV1tKJ2a5Oh0eobD/d81pgWWcYlsdfzzyX3jJ?=
 =?iso-8859-1?Q?Vpys9sbJYGuqVwQ5FEB907OvnnoZX+WjH2lyeyl+rTI37P2bXFGIAea41q?=
 =?iso-8859-1?Q?YraOguNHj+/Rb56yv+0HtDm+0Um0Oik5ou0vxpxMt/Ocs27nu79UOZuScQ?=
 =?iso-8859-1?Q?OE696tG6FbXNzD4VBh182n3t7PWSKYF/9EE4J4jSKSwD4qY3LEZWlAyXM/?=
 =?iso-8859-1?Q?wT1oCFxWXZARHWuGZJyzeZ4C43/xR4UvjJcXh3pCx48/05+lkkHX/n7OY8?=
 =?iso-8859-1?Q?cJdzgl8kpgKhOiQaPR+b16LVKF4vUK6kbFUgn8yE7NF/cfIcu9ZY5xrJzL?=
 =?iso-8859-1?Q?XozPmBbIKPI80tOeeT/rfe89HH6uTzyJoVw3sRel5RqmJwRjQTGXJshwMa?=
 =?iso-8859-1?Q?W3HTeqC6hRIu2r92lsqqsoOLfUnmpj8amhffHru9ODVHTQzYM2kXvQ4xhz?=
 =?iso-8859-1?Q?7I+SWct5h6dSu63mpoQacSTMO0HSm3f/G83qR4xbBHWz3P5rCthf9sbWt7?=
 =?iso-8859-1?Q?VpomfE6XkLlPqEKl1hbXk24KjsLue8o60PgbGfl7Pum/sL5crldjF1qOKq?=
 =?iso-8859-1?Q?gveHaWZy4+ipj+cTWWsyI62uNbmeT+jWOsT14KyM0Da8DdeGE6OHm7eLlz?=
 =?iso-8859-1?Q?kQmelR2O8Tp3l1SHMShSEbPf1mWvutlgt05WF4ns6WndJamfMEjrITj5Lw?=
 =?iso-8859-1?Q?UPG13xGH+T8x4z/PbJdCVVtNlx9aK8MFmrttcCF/43V3N8LMvHzpfLMd5G?=
 =?iso-8859-1?Q?eXhhW3Yjn56Cqcavsa2MLX5GL28ZVK2eOuK8Ex++Tn8fi4GFsja89N5fgG?=
 =?iso-8859-1?Q?BkcZcf0yY8fEPs4pvUdqkqyC/JK6kuyk97bmNKQ4lya5CUxO9WJh4gGwYB?=
 =?iso-8859-1?Q?O19ppJBQOkHb+1qsTgLvXOYHfurb3vJ3NyFz5foFmotO1+ScQCwywSY6gI?=
 =?iso-8859-1?Q?pe4EBzGb++NG12X3xPN14EfeaPujdExoCKHlNMyXtEsOG7MpQE/gV+J+7l?=
 =?iso-8859-1?Q?Vvx9uJOsDYy095cfnK8eBJH47XgTh5JSmGGaYLg8LeVO33dbA93SkRe0tY?=
 =?iso-8859-1?Q?K0rU/d6eJYPJf5JoWtb2qwN9t5chohvrNduHHJOmg9mOB/GSYavKg7J8hm?=
 =?iso-8859-1?Q?bfrWmGTZfSoNQ4GztoBGpfUqO36P0R8J6+ej7IFmaKC/AUxQpjafA1Q3gr?=
 =?iso-8859-1?Q?+j4HDU3FMw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf97f616-2930-4dd4-10a8-08de7376d181
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 07:32:09.1150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h222LTyumgASDRRIOllbrNYIbCDTphNIgcr8rLlDpei3udX45wP8PeqaUUVXyVYLSiOa5UlU1W+Fi7xvLKbWa23zTEt3eSo+42RBetf1rms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF2BE5BD2CD
Received-SPF: pass client-ip=40.107.75.84;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The current code updates the upper 32 bits of dma_dram_offset only when=0A=
aic->has_dma64 is false, which is incorrect.=0A=
=0A=
If aic->has_dma64 is true, the controller supports 64-bit DMA addressing=0A=
and the upper 32-bit DMA address register must be used to update the=0A=
dma_dram_offset accordingly.=0A=
=0A=
Fix the condition so that the upper 32 bits are updated only when=0A=
64-bit DMA is supported.=0A=
=0A=
Fixes: efea7ddb4689a1ac4bce63a9ddb32887c7f3ac50 ("hw/i2c/aspeed_i2c: Fix DM=
A moving data into incorrect address")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i2c/aspeed_i2c.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 122bfdd63d..8022938f34 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -237,7 +237,7 @@ static void aspeed_i2c_set_tx_dma_dram_offset(AspeedI2C=
Bus *bus)=0A=
         bus->dma_dram_offset =3D=0A=
             deposit64(bus->dma_dram_offset, 0, 32,=0A=
                       FIELD_EX32(value, I2CM_DMA_TX_ADDR, ADDR));=0A=
-        if (!aic->has_dma64) {=0A=
+        if (aic->has_dma64) {=0A=
             value =3D bus->regs[R_I2CM_DMA_TX_ADDR_HI];=0A=
             bus->dma_dram_offset =3D=0A=
                 deposit64(bus->dma_dram_offset, 32, 32,=0A=
@@ -262,7 +262,7 @@ static void aspeed_i2c_set_rx_dma_dram_offset(AspeedI2C=
Bus *bus)=0A=
         bus->dma_dram_offset =3D=0A=
             deposit64(bus->dma_dram_offset, 0, 32,=0A=
                       FIELD_EX32(value, I2CM_DMA_RX_ADDR, ADDR));=0A=
-        if (!aic->has_dma64) {=0A=
+        if (aic->has_dma64) {=0A=
             value =3D bus->regs[R_I2CM_DMA_RX_ADDR_HI];=0A=
             bus->dma_dram_offset =3D=0A=
                 deposit64(bus->dma_dram_offset, 32, 32,=0A=
-- =0A=
2.43.0=0A=

