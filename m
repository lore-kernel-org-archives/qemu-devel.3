Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D4C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWa-0002Xi-V6; Mon, 07 Sep 2026 05:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWZ-0002U1-5K; Mon, 07 Sep 2026 05:20:23 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWX-0001gr-M3; Mon, 07 Sep 2026 05:20:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZT5Uj0nPB6/LJgkzavQInbJTtNosNsXK12zn6gUd1hiY52GzBy/FeamBvFpcdiJSG2Zq5ZEq5ttRg/QTt+XHdNfW+/vJnhFw3EaXRwoFQK1FVuVudDNL02bebvRSwgNrzlVbA/+lPfXmL7/BzAj2wUAaNknTedOgOGkPn5/DO0IOYj64EWlJ7lBnq8WUvn198TMEI3klRfOsg5wCjf+BLeiZVZRJyM0lX46KLbJEQ7P+x+I0qxscsKUrVGhzzd81av4+vUf141O2delYbcY4BHTtbD/Bvr1+M3ts9YEAUSYRpnD7tvrZ+8A1R8jsL5tp+u/F3Wzl2FZqjJZQYoI4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+onO7sKmQYAQW7trzkVN9bJLlOOJNFO7JMHK/IVAhA=;
 b=nIPue0KS2XqsLCw8vbmnJlrI4muJEqzK/73JJ/p6C3LS+znt8tzOTOG7Uwx8U6aqdEac6MW0RrNsB2fat5RUKnCyerJe3ve59kKzOHYLQee8oCGeL6GDzXcHhCLnbdCI8fR3Cshxr62T+vB3caPhB9x8BuXxk6RcQfoUHxP5Af54DJ/wVM+iKoMngyQlIJQ8v+nwm7j8fWR5gxPL2xdOs8YPxMzX5asqaZRGOyKQsOyNksASV5xlg4264CPbZiRt7SHy3NSE/d1dQxvrzBKSZln4vlOTaXEeK4i7sefyMZqzDAqMqsTlJJYcVioEABe+Tk07idLUKyEVJ6d/TJ8aCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+onO7sKmQYAQW7trzkVN9bJLlOOJNFO7JMHK/IVAhA=;
 b=MwjYKQZW+Z+IfBL+iDg/wqJtXYWCpSEHZ+GH3cvW5FVMjUf7N7iggJ9bDeq0vnE+IDjyQBd9TWWvhDc+TvKW3XLua4xPBvIKDJiq2Hq3P5HNEDEipmBy7SU9ZtBJ4sGSV9MWRj3TDuQu1UKTYDD+9gZec+EWtMx0PyyLJXrjy8dDbJR0RmhwQ2Cb8kc2Fcz5xdMEjAGbiU+4gpi/kXl5bByv26UseUTrielYMmKxpbIfsN2UmOJEBGiFFt3CHNslHAIDd3IFPKrFD29tibaHW683tz52pY0Ukgk9CV/Jz6WUyCtROf2ALWVcD67QHvcuSQpNQcV1RYAo3SN6li0NkA==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:08 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/7] hw/pci: Add the ASPEED VGA device id
Thread-Topic: [PATCH v1 3/7] hw/pci: Add the ASPEED VGA device id
Thread-Index: AQHdPqoTgbUnj+hjRE+CSudBXkxE6g==
Date: Mon, 7 Sep 2026 09:20:08 +0000
Message-ID: <20260907092004.2590015-4-jamin_lin@aspeedtech.com>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|SEYPR06MB5301:EE_
x-ms-office365-filtering-correlation-id: c51eb373-a065-4e6e-03ac-08df0cc13631
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: zmu+ZoqktFUyD57yy3xNL7thKgWIQF3H/s86IrF3XDh4drV7GDAoMFPbaP1XzGobdzAQxVZpGoufjj7UZcQtb14ckJdzHz9wdecJVJgrYyo7Lq5dUqy0ayo/eN7V3ghZckzjtT+F6I6xdIYCQlpFRoodP59ps3DYpge1SmOF08m8cp/wuTihy8AzQWTffG7pO5XyAyzUh5E7pn9HzAe+AiD9WNEvaMSHGSk5SPs5Krh8QDnzY1JZrAGyiTiXvW3GvR91gC6m9tLMiDK4QT9dOt0XVc+WzTQhS4zX/AhJzxSA7ec9JuKSpvMfmccSUy+irHzF2dHFuZ6G2KjT4XtDvYNXjWp7J01J2/j4XJFh4gIqph7K1ANNFCyIZL6TPalokIpgZ3Kg1gAlfYQlSG0kDLogQ/3et92lyeBwx9s16+EPh2VSvJsS2jZcYULKnf8CMV3sslCeISmTN9kZlQTvq8rH0nnbeYKHgaiMlUvl8X1BiydACmrLCrTPCWhcioe+PYYDyu+KBkonVfkSIFAqUdSraEZjhd9GXJ4O25cIX/KDypSmPSTRW0VjhfeUP1XajV9rf8y5xx3Q3gbQkP/DJnIivISSMvE2A4Xifz3Glvjti5B4bnZEWsan6ek7A2QyCvORohy53Io0BhzwYYIpDU/KQgs3NwMqteU9Na3pIR3mIGEj3DNUU+V3b4yndR8JdD5pbMHv9Jr9pPBOZROPdUly2HTtzHE67OIjDOJhKPFR4pqfNRnWFRQRI4AF58ns
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OeUHngcbqKOENUHjmqmkLjNulYcTlbPIhBRepH4lYe7QL8j5ZyJSLdT+B8?=
 =?iso-8859-1?Q?PHTr8COYRN5ZAOD09Wf87l320sQwaj8G5GfMwJeM+UZaEDAUm6IxSDdIVJ?=
 =?iso-8859-1?Q?R7j42vbULMbBzDLf+c9KWKBTVgzKXiTw4Z073oV3IawV8Z0pYZtZE+1kD3?=
 =?iso-8859-1?Q?aiIjM2QKydDiBfOatMeUGGzsSkt6LIuVJmFO8GnCzgZW/TptgtwD27efgR?=
 =?iso-8859-1?Q?iAjM8JsXVYgyu3zK2WN7zQaHhEOWGq5peHwa7RslLrqQ7fNmXbsMFsjyiF?=
 =?iso-8859-1?Q?Jj4Ms9aC7T8l/ihgOsWnArxywLFmGmVA5Vg1QG8oFhNsTA+FAeqnKMiiSz?=
 =?iso-8859-1?Q?0HTGqIgmuRPMCTfMCZc10uJYzGOvnwi+QVBTH17KKzyZRNJ9YdQA3NKHvP?=
 =?iso-8859-1?Q?TfIWgVxsHALhtOynWWvLkoDFbM8Z33QwcIcyh0CxtEQYlJQ8EDhSZFeOTp?=
 =?iso-8859-1?Q?NZSOzQrSaFYEJVSK9ybMNks19zGvRMqMuQXn3qE9L2MGax5yhBhHqbshc8?=
 =?iso-8859-1?Q?ymyCn/kLtymzC9LhU6/7c6w6oIGOT9EBZ/Fepar7oYxFyXl531JhGsmBf2?=
 =?iso-8859-1?Q?5AgKgL2Oh6DeE9ynRKjh+SFt/4oPAwOiuSaJgGcFAZDtImRRJjFWjz/OMu?=
 =?iso-8859-1?Q?vWHJ05Iv6dWXbgWBGNUVhMYyNJ+gjrVNHPMffOoSGq1eXpyxVstrP/mQ/3?=
 =?iso-8859-1?Q?+F0G1c7U3l7Cy9CGtmfHNsWGqtHlgEWFI7WNtv8Rmi/gg6v+E9P9xn0B5x?=
 =?iso-8859-1?Q?lufAKJJ88ztLKRF0kfOfoRoZl8nYemK1e1zIsQRc5M6zyynuK09D+Q2OAH?=
 =?iso-8859-1?Q?g+eM50GcDm82EbYO5E6YGjm5wcrFARo7dGpyA6n0S8eQ7VsaYb6yPKKUO+?=
 =?iso-8859-1?Q?8sIStz46yR7faLiJvAhHbLn5EiRARmD+Jl26zz1f8IqA59tn2lsg0IGn5m?=
 =?iso-8859-1?Q?ZpW5ixovVF7mNxIQwIfftW9xN+j4fPfi2WPQELexANeiYi4g3xYR+lUokp?=
 =?iso-8859-1?Q?Gkjc8QKxCjIcM0XNi8mrPxJ3C4c1xrpWPOe+kNsTs46q6CdcbgGjvYW/H8?=
 =?iso-8859-1?Q?xh0JZ3G3KDvEfr1G+tWfGxRpY402AEYBtLsWQQYadFx9uqcoAncAZdA4nB?=
 =?iso-8859-1?Q?vX+6KSEIQnm5vTRpaAK7rxcDJ5zgVSIB2dSSU0aTLqwrMopA5hsCE9VTh+?=
 =?iso-8859-1?Q?To00vphrhwP2oIG///vC3ZUTV/jo14ghcwIx/FiQJVKBAdRc1JdBhwR08I?=
 =?iso-8859-1?Q?av1917g1gqa3Ypi03n7hSydxBu9GnGW93XNVup6o9n17rnUFf3C3/sDK4h?=
 =?iso-8859-1?Q?LpxbPJM/MYhtl62GwTEqArB+pHHFKzoAO8PAvHbOajgTo6NOuesWRJKEjD?=
 =?iso-8859-1?Q?qX/mUHqQdQcY1uFwFv6bmEP7zef7LPzN0u52hKBrRUToaLpEGO+lZVKlr8?=
 =?iso-8859-1?Q?8xh8gxugWD+qzYDaamNMll0/q5AjKhCARlHMppIXAHLe7xiEnGdUQlBDBo?=
 =?iso-8859-1?Q?ZDy6abMA/CKPtvIr/9d9TbX/cIWwCzziA/dDKNGHNyFcXnR9Abv0pGHbiO?=
 =?iso-8859-1?Q?HQUu62kh/EsdSqYDuK6RcsDGEMfnKknK+GC5seujRd2ETCiNrunQkqRcVY?=
 =?iso-8859-1?Q?8VGd6jFPm+a/4TdtyPlkNtWGZklIdggY5gZ0vIRfKLmM/QtWoBQiQJGGTF?=
 =?iso-8859-1?Q?5ejun5de81jnYVMmQH2q4vLPTNO0wqJvMe729fhOvkIbrsJG3L7Jiqlzjp?=
 =?iso-8859-1?Q?NrBAFqUAs4y8Ox4h+ytkvDttdV2imOZb37rKQwC0AJeMYxoEqXae/Qaa4Y?=
 =?iso-8859-1?Q?VhMo/QVg4g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FjK8TDTbMKdKKzvZSDix2qAoRGfl0NjjKmZwWY7Veh8RqFecENigz3TwtLmUFiB9BwSalCKKGmXtIZySi22mgMZUoJmpH05sQ0CQ9sb+9NdZyl7DzFqfk2H1svbEkpFzsZEPufexfDofbHoN9kGPNeGiZdqVHMAcrqGJMl0JZ8ZPPMg8SIg9nsIFo5BEph4buOFBR8n04o6WKO8FC7d63uETCpipByvbXWMCM1wW30lHkZDzdOHcbvIa5z+V/mAp1BDtPdqb5D1ivn7K7EbEVacQ33tk+SA+DHUcwjy/Il/vpSY7yfqA+5ht2zNxqIn83LsO8Gf92K8mCSVMirxTZg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51eb373-a065-4e6e-03ac-08df0cc13631
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:08.6813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TivSQyhtn7uc9zsFqXetRf3MMsTZD7gV3/EibUoa4snnNjGbO0h/laH7s2CuWmMu2DAeqNj0ARC6zcMaaFuzuuHHVg8nuzGXVyFyvhaLLkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

The ASPEED vendor id is already listed. Add 0x2000, the device id the=0A=
display controller of the ASPEED BMC SoCs reports, so that the model=0A=
added by the next patch can use it.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/pci/pci_ids.h | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h=0A=
index 16034aaa2c..e16d93dd13 100644=0A=
--- a/include/hw/pci/pci_ids.h=0A=
+++ b/include/hw/pci/pci_ids.h=0A=
@@ -292,5 +292,6 @@=0A=
 #define PCI_VENDOR_ID_NVIDIA             0x10de=0A=
 =0A=
 #define PCI_VENDOR_ID_ASPEED             0x1A03=0A=
+#define PCI_DEVICE_ID_ASPEED_VGA         0x2000=0A=
 =0A=
 #endif=0A=
-- =0A=
2.53.0=0A=

