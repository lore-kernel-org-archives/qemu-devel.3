Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A42FCD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9A-0001wN-FT; Mon, 25 May 2026 00:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8m-0001ku-Kv; Mon, 25 May 2026 00:42:13 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8k-0001Gh-ML; Mon, 25 May 2026 00:42:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwX8fvnf07a7C7wCc78XO8nAWGICcL8rIWND8RfjkXb+cZTsV8Y6txCCZxm2a7rX6ArTJmc16AKWZG4xy0cpJaTQNDrub8sBgNTtJI9P//8YYmkeFD33gQV2jo8G0TxaKwBkDMszt3uu/5DESvPith2P0IKHYzA/OB83mwyT1tyx6yPvjdDS3vZqNoew+0eAMnU7YTLPxzr6Ucmnba9AW6CMFF4Jj36KIJIT7vHtFe7gvW/aGqbZIOsc67TNzcooVAn59h0ZvDb74yH9VcxelAy0moVlqOSbg9WHKePs9kpvA3sGFDNzCYi8s+Ihm43mSUF7nDUqEW5vdBsUUeUAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8hfyEcuArDpCPcpc31TinmRj5JEl2zpOK3+UwyPl58=;
 b=YA+XztDNpCIKH4koctOrT52WLfSWv06TmuE16jbbLjL9dnG9+WrPfOJ6gtCmx/eo8fAlfLZU98EfKHV47TiZ2or2vb2LQbNpER22pTwMs8Mxq4rqI/KlA985/hy2eFud8+539/WVLFI4+0TNMz1O9hmc0QQoisEiVxXw62KMV/AzDnv9ZA/aW/KcBwsvNZs43brEIjHc9lLTLzjNEY+fpguubhT53ctJ1RXZnhSjHPP6NAcnFL88UcMSUXvRE/KT6dTQ0UMJWGzfO598HXkdG5J8ieEjLTuj6QV3iN6COQk9t2kgYvPedoJl0pRxnzs+cvnyd4e+CDg7jPQPne+LEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8hfyEcuArDpCPcpc31TinmRj5JEl2zpOK3+UwyPl58=;
 b=Q8ngT1u+0eFpUoZnnd+LnqlgLFdjQRZrl2O/A13Awuw1JAFKuhYkMgDY2ew7H3kyvs4oZSgSqAkKA4mrORctPxPbE57PSmFueh3x56EDrrn426LhuM6/XMQm0sxut7kh36ERbzLUB/GS8YYrIgKEnfZvx58x0x8P+GK8dRr7K58LH6wiSlCqE4D5ra+JRGrUxbgnNz5P1+FwUw9RhsaX5KyYpm6ZhlPCTDXOFRqIpPI/HF+WN5lpBrraSVLsiuNXqJrvnEWJ93J9nGwQA40VEHW4h9p7T20mt7cagpzn2zmY7TXE6KKfFVL9X7NWp5o0F0ANOtMQg+qN0ZFOonaVEg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6593.apcprd06.prod.outlook.com (2603:1096:400:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:54 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:54 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 16/23] hw/intc/aspeed_intc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 16/23] hw/intc/aspeed_intc: convert to use Resettable
 interface
Thread-Index: AQHc7ADPE5G+mwhOqEmOg5H0z3gJPg==
Date: Mon, 25 May 2026 04:41:54 +0000
Message-ID: <20260525044129.3133916-17-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6593:EE_
x-ms-office365-filtering-correlation-id: 2dd369c6-73b3-4059-e479-08deba17f214
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: txNcmrAlp+R1agYzcj8vTKFYh7oVsdjaix7uuFE1j4qJjNtWFFfPuaIyP+iEwCVTzWbeqAHLAqsTsNbrnsX6kgoANMHGNcD4I5MDK836QJKyZoPWNAPZIIj5zh3wAD6zniUyOfZ7kLcUefHZXsSbabPS/fPHPokDd9eQttoJPuKc7k8FIXlYbERu99sYk5Yt0Rq/wUo5Thsc4myloKIogxCCxG2zOcC3FWZGM/ECWIBG++FFd3GXdSKuvi8g2xZz3GAh5CFLeebpIJ/+jfnbBjk6GT03He66FOe78FWhrI7S4NhBsKDRuvmz+iD8jsSL+toikLtDGIsbM8iAEPiSMFILRMHt79lNJ2dwYZhRlS0MRsl5DLed0ID7fh4nAIYp5ZrkapQtp6n6tNW+mvS7I2fyOQCCksnsIIEOu02HGYINuns+PKGQQGZbQwYwmNiI4nHdmTbTNdy+HojPJTBFzNZVc8DOSACHghIN2XoNYKqQxxRhfS1pHBk0ZM1WqjBYrchDPRlVggojnYZG5X6dHYXfsZ8Yt8WJ3AS/9g8iNkgrFGR7mxNXTAAbT+O8OmO2wftD8PRE5sOZ8r94GRFIXeceRyMUiWD2oO0Oc7tomv9NoJAOvQGuVxuxA5g+wC9bpZFnqLVzICSHyZkCL+dWkaoD71UgATt//gumk8N9a/RZ8GOZmZOX1Fj9DGFWHj03HVbl9SZW0KwxknnSCswf7Jtp8NDX4Puzzvld9hSFWg7xZdUYpfptjpCiO1mPSENfBmTxpfsZJW5a9sBWANbOUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?68JtD9HGlWvA8qTWOaEpuYLfnyQ1niQncdgbIyBjFoxbxmZpKzPbF2gzBo?=
 =?iso-8859-1?Q?BeaHWkPsznnOpRGC8gZwEuWXxhF4nKjeB/SSbSZQutdHCmS0WfyxNku4i+?=
 =?iso-8859-1?Q?7qIb8GA/1PM3OugDHHkq+Y757GNY5wO01tu2jXq3YIvoZwwegcCG9f9Sgn?=
 =?iso-8859-1?Q?2lRq8Y+mDnBnHOF45dxyXlqkbs9mE9vzijtv83E1iIo/KCsXXLJ3qzt1xL?=
 =?iso-8859-1?Q?NQz/eHfKmrHlM6g7AUQd0ZGDCJBCwohdi4DO2elNIaYEI220VqU/t73kWl?=
 =?iso-8859-1?Q?O0OnAXqDA+ASdYh1dzfC6cQVafyq2ncE2+vZ0o+UX13+erptykZcfhzepv?=
 =?iso-8859-1?Q?eM0OfVfodauDQmlylVT/2n7Nqmdz7h7LU39KEsvuYB/Y23Gky5eMSX/zzd?=
 =?iso-8859-1?Q?SnL7M3LqjZRywV6jwcSgbzSe+R1kzDZzxpvVspP89vxryNwGsZCDr249C7?=
 =?iso-8859-1?Q?loqmB3OMGi9TxAC4EUbKbiPZ3lV8vIsDCVTikt2IU47pabRHwUUuYvh9gz?=
 =?iso-8859-1?Q?t9cMAe342QeB8nTReV7yLVmmD+uFbqWafwSJnZjIzrAJW2nTuiz7wK9xyy?=
 =?iso-8859-1?Q?p7L3xl+I+W9m3lfFJkcNevL5qGT6JDxlTqa3onHLFQIuyQCL9MfdatB3Le?=
 =?iso-8859-1?Q?yJxmTWN+Xg2vlkWnEAwZC5pWPz4FlcgaBJKvee/8GY0RknmjynpjwAOewd?=
 =?iso-8859-1?Q?dHmWEKzGX1P2HEEh87DHhwjYRO7dxg7b+YKpFGnoO9xMbD+pufb/dZSgN3?=
 =?iso-8859-1?Q?EJAPrAVrrTJXdQ2wGRGzoVYvyQNL/o+ULgAlApRiRTAZMrUm1BBJWRsqDs?=
 =?iso-8859-1?Q?jntlUkbbZaxVZkcxBxJl6TXP4RNYZAziN0zPtdVIXpSfFmT7tCqk+mtp+p?=
 =?iso-8859-1?Q?RNN7UzwBguaFLfht6Z6UFXdFcFsCOPz7RmyIDblMp7N5okIxa4Pzdy7bEc?=
 =?iso-8859-1?Q?HBXezveWvcTeaTYWeDNzwqXCQv+YqdByGGcUtKr9LpO9vMXzxXmJysq7+k?=
 =?iso-8859-1?Q?lPSZ7gbjf13I2nCtxGpkEzC1q8vQUhHawTt2YdfASeJqgV9Lg36GxoiPk1?=
 =?iso-8859-1?Q?2PMCbohXSgCAchK6FLrKvsvanP+4C0BNVgtgxKvsrmJ7GageQwihw9j324?=
 =?iso-8859-1?Q?s+0dwtWsMgVtyI/6RDC4BT2jjECVBO3zLfqbeQy56S29DYNRm2p9+AZ9Q5?=
 =?iso-8859-1?Q?vhTICixT2tHecQyrHHiimq8Ir3LquRZS9Fq/hghXFvjsxOuTOwnBI0uowM?=
 =?iso-8859-1?Q?E6vH+Ygvnvl7DkeWwiufv4PQ95fRetdCr6seudoqDX5reMXId88fPRDA0y?=
 =?iso-8859-1?Q?VSQVTGJmnQZzcXi3m9ZpNL55xVSzNycezlxyfO9kJOrFVDR0Ghf5DCe9E3?=
 =?iso-8859-1?Q?MfQnlzH067elvrIHpqjiKX42+w/BMA7DXBrQS10A7UqMZdmpaUK4Ddig35?=
 =?iso-8859-1?Q?gCKLJP+SFIHR/rnu8nWjKx27bOxn4ewPlby7ihKIlKDDp+iIZrRKVM9I6g?=
 =?iso-8859-1?Q?lrhV3u2zNdwc4Eko6u2gPXLOX/7U+d72yGSAe2BSh0GeTqiGQ4Uu356+zo?=
 =?iso-8859-1?Q?Xw+LOie1KjxYQYBeDktX2kRPMgwQOnuPDkJPyXl8u9YMbse8hdPnCR1czM?=
 =?iso-8859-1?Q?8maWuMWS4MINY3aD9x5laOyTM8Plv2uJWx2mm8WoCzAq85znCBal2B8d9H?=
 =?iso-8859-1?Q?2f1OJe3ChmqjMs0ESBzsdlVeAnjLVwvorCgyh7jEMsrJuucIt/2Z9jQesN?=
 =?iso-8859-1?Q?qH6C1lirfgK25R7iHTvVUiQLx1dKBZFsu9R+nKzvpF1hGXvFXW1w5RE+0p?=
 =?iso-8859-1?Q?8OKReLQJKA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qs6Se4oPDF1wefmVkJ+9Wd08fYRy//tfy4HeQsPeiKZfkKsGXoNh6m4qizefyxIjLFIKNOKgFrQpUdQyXgwbbmbEnxFQL9oeIVhslQm+vnknCxiYBDSmOP6eFK5x55sNL1ZZgJk0sit0eO+vwnm/ZqG1W/l50Ep2LAEzeJWlhp5HvQ82cFWW6f53EZWKfW+gb2AHaMCDpBK0R4ZYng20pmmDeMSIUb3fo+WMfRgp/d7exqtWDcTkcvEKPsRDo81n4yUKNdsOFOp5XSUuDy6wx5LHZfMj4/Pm0Rs15PuAgitnr2pQz4zuWTYyzOmc/EVAxYwJnyg3+QeUs9vAWlm0/w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd369c6-73b3-4059-e479-08deba17f214
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:54.1332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1ndY3j4gzGo+QcXPnXkU0D6HYDsCtPXo1X9XncM9aj0WaYpCth60HPnd1nlGom9xaWAqGYK5q/tI/1SQ2sJEfhU7sDANLulzu0TvqMegUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6593
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/intc/aspeed_intc.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c=0A=
index 52f2f946d5..3892809430 100644=0A=
--- a/hw/intc/aspeed_intc.c=0A=
+++ b/hw/intc/aspeed_intc.c=0A=
@@ -692,9 +692,9 @@ static void aspeed_intc_instance_init(Object *obj)=0A=
     }=0A=
 }=0A=
 =0A=
-static void aspeed_intc_reset(DeviceState *dev)=0A=
+static void aspeed_intc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedINTCState *s =3D ASPEED_INTC(dev);=0A=
+    AspeedINTCState *s =3D ASPEED_INTC(obj);=0A=
     AspeedINTCClass *aic =3D ASPEED_INTC_GET_CLASS(s);=0A=
 =0A=
     memset(s->regs, 0, aic->nr_regs << 2);=0A=
@@ -746,12 +746,13 @@ static void aspeed_intc_unrealize(DeviceState *dev)=
=0A=
 static void aspeed_intc_class_init(ObjectClass *klass, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED INTC Controller";=0A=
     dc->realize =3D aspeed_intc_realize;=0A=
     dc->unrealize =3D aspeed_intc_unrealize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_intc_reset);=0A=
+    rc->phases.hold =3D aspeed_intc_reset_hold;=0A=
     dc->vmsd =3D NULL;=0A=
 =0A=
     aic->reg_ops =3D &aspeed_intc_ops;=0A=
-- =0A=
2.43.0=0A=

