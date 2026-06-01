Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA524CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjO-00036Z-Aw; Sun, 31 May 2026 22:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjL-00035J-NE; Sun, 31 May 2026 22:50:19 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjK-0002en-0I; Sun, 31 May 2026 22:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXVLJEwMO9c0jobopaeLTFiqe0OGBzcotZkAm3r39XkQWRx2eFB7urZCHOS10aZCPu3i7YlM1oln8YpWLId5Zkob4OaiPtJab8iR2YtX5W7G7DK+OwzAzDWWqqwIgw4VNJpTMlBYnFOAcg4Ay2ktYEhT4Pn+EvvEehAOMlByUPD3uJE4DEun93xvyu5spJmLJJKblB9uAkdNn5o5XDRT+lSXJH42soHiIg3zrHxZ0K2z0/Hw3jAtONA7W++XOlkL9yi83sdKFpr5zsLGVAKSxrrzCEJjDL+jrZLbmE6cteQ/3j7PsXZhRvpWwlRLW3EzsV40YgkozYZQswBAnDdgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF/y7Czf8GP/cjFO58C2qDAvNGzckOVi0xY4LOvoGIY=;
 b=BUA/7jWFvJNC14LuB44ltUnuwfGr51Gj4Z7BVRH3UEPZJiV9DQS0/vGIzpR5HHaSByA0wV7QVBSHmMGKEf7/v1WEg3aYS1+/QQ8EOgxarfwW9/rRN8sF8+PglbTYLRfIYjT4aHlFJsjztZSRyUQ9V++BEkrB1cSV5+5FDRvuMcFlMIF+3tNGxbI8853qlhqX9vb9oZk6nhoXiYt5zhZ1BCQG9GPuIjv5N0/QnUvZ2yreiJrs9XX4le2RnqM6xpku6GkCgh24nzUuJnLgz4l5UgwmzRj7XsOOqcq9EF+1vlyWPxuS8SGkRFuMlML3A13LzakcixH41np5GJc3GRa32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF/y7Czf8GP/cjFO58C2qDAvNGzckOVi0xY4LOvoGIY=;
 b=PY6nC2jZtnERjuU5NnMGQ1EvAGkVJoP25hPsFIl8LAAp9hZ2lYgUWtTFs4J1yKnr2W28pLwl5Y2w/eTeolTSJYdzbu2ffDi43Fy/LZFA6AyTF1WOPk4k0G1UdzgpBBU/zcvymSdutI988Sl26+laObmeJx/1pHZKWuYZI0MhMXT2o9PPRvByT4UI8saY7x8Leiq5jagVV4uLSspt3hb/r8twlRY7PjMAQMJjvmXcE/W5iZ+TazkWTJ4Tx/TZstGQctaYTtRRhnvi46kcosB67Ys4SKRqrCmL+mt2/+Z1F1i5DqZewRNcekHacztjahv/N2gYwC/ZKQU97bG3zKtYXw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:02 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/24] hw/misc/aspeed_hace: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 01/24] hw/misc/aspeed_hace: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFYz+b6YtJFIEygMy/FdVtidQ==
Date: Mon, 1 Jun 2026 02:50:02 +0000
Message-ID: <20260601024959.2347639-2-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8361:EE_
x-ms-office365-filtering-correlation-id: 4daa4b2f-fe9e-4e3f-96af-08debf887a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: WFpcZKvZuzP2rQuFR6lhoFhZtj5975EyoF0Wazys9yldZRtLcrMTILER/vwmURoBoSjYA2+U7+DRtDmDGBx70GEmaR6UH3gg2qGEOwFxfPZmvFkbW6csTs5cqXPWvxX9ZDN42aUp4qfz9shcADWNTzUc+sM2XnZxwVGXHhF9tapxr5qbz5KUbC/SQIVmNDbelty5bsQKaiPsE2Pk/UDvjwHZEr84u4YwhmnR2nYP5Z1f2IQiWbmxNyMzLwskWnXLQEhliWv61jtu8Vj665xrxjiAqI8wBVhAjgNK6nxeqdCbMOtoKYrJnqz5Cg7IueR7/KQ4ItLz6Jw552ONF2Su7KFKIjlz/MTLUfErxvyIJmFgHe8etfC1ubYUsr8rMf3SsWjTEIEHfAeKS+NW5bNchayTsShyARv6pUJ9AT52lSwdkU+1+zzaBiodT14AlWik1shGHdO2nCAvgojAxbOzuzsDk6WcmrObATpMm/cemqE8DGpSjsigrqCQW9yaSJsArZyn6VuDdJFoPYf6QlpjjBJY+8Nr+eDHATyZ22FGF+DpNOqFDqGL9ogKoYzz3PEG5dWK6bn0s+XE4hWm3Abzc42gPrjIJmluQDij5OxIVts2WEVgRAR24bKOdGijcyQiEOxJl9PtpnSTrvGByQqsp+65k1wCsR+I+nIfipyOSqNuGS45HuwPxetLG8zVQGZgq1qTXX2Aj+NL9xxwso0mkdjGnlYaSKi4hgwLxt2eajEQgt/YXOKqzS2CSd19LzbLQ8i5m/8kj7PvAJgOFWzY/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ckz2LVPpexS4ZJoCBJnffcyE17CY2ip4t+Bz5PyADfZuFCixHsIR0ScQSq?=
 =?iso-8859-1?Q?gg+Zd1yj2rZQNV6KNdVjEWs14bxcicHRyRb6j3qwFcEIGXVJUvIoy1LSNG?=
 =?iso-8859-1?Q?rIFfDgOLzKgE1P6/KpqKTtmZktsM8L5GE4xSlrGh8nfjQYJVrv36/pJZQk?=
 =?iso-8859-1?Q?6K4BXi0hs4RLPFqb5u2WY8cBWB/9luTtpENSKThfNeo0x38Bq/HPQwEM4d?=
 =?iso-8859-1?Q?BZlK1sL3xn59sRyoo1KyWhxPHwCbY6HbPFNbpLsgQ6uNKBgVERo9cwqrw5?=
 =?iso-8859-1?Q?Kd1tljOj2JAvMSjNetf4QDKcVnwqZs/vBH/9uX4jwGlZJOthO9na4otn9J?=
 =?iso-8859-1?Q?/fvvcesWeB4SFCxBhwOLleiDXROX37H6+2RM0/p/7EMORSm3Rw9Meu6AVV?=
 =?iso-8859-1?Q?wK6oanq3PWYrt3PYX88qhTOa/MKVr9LuHUMfoCcUHLPk5ChFl0vIdXk0Ai?=
 =?iso-8859-1?Q?BFHZ+B7slqjUtom2gUL6egQxGzsdOmpWyaQQtve9es0WpgQrmbnQ1fRJpp?=
 =?iso-8859-1?Q?uFuTmb6yoBbU0avtHiYMqI82NYSwi9JLy5FsPREzqRpM/7kwKloDtyvuN0?=
 =?iso-8859-1?Q?UVyNDBmTKRqZyUn6IJ54PgtO5w6dSRq7eAPlMvkomftMshyypnVaQllYIU?=
 =?iso-8859-1?Q?pCBHylS7NTWMkAXs0sEQOIWH2F8Kv1Q2KAPZwsIr0GA1bxV5ElJdyqLaqh?=
 =?iso-8859-1?Q?l3f9lp1aKv7hCW0FlUQB/o/mSqt6fknBf/h+4pcuZCUOQcJzS8zWO5IMBi?=
 =?iso-8859-1?Q?Dq6DVWK8yGM8/HKYyMlwTBfhifXUcR6zvN4RFqOYzlIz1oiZcfvjz/6p4p?=
 =?iso-8859-1?Q?3WgMvoly3ZDzuhcyMJtDq84skOQWz846uTfdY9Peh2INYSdgphaijFaZ1W?=
 =?iso-8859-1?Q?OcbmWYJ/Nm5LkSlJohhmIzPBEgT0iV9gfJBMN6L43QtA9kLCFfTuc/zD7P?=
 =?iso-8859-1?Q?o7RpiS3D90U6k6+TbL5IDRTIMapKP2fTt+uoJ9bEniVSlLlR4R1RYlx38X?=
 =?iso-8859-1?Q?0n2h3MN8hi/H2E1kDXetq6lYmFPqRiR3zLNWysS5DptLYYJc9suW6tdwbO?=
 =?iso-8859-1?Q?Bkp/VxpLAx9KLHD426cGZVA0BuELJ7K6XJT3rP5p/Q2nHxyi2BXLPSLUkV?=
 =?iso-8859-1?Q?B4roUW2/VQtWio2r9K32iAeQV9rUGK3FmfdqWQkQJrwEI3VBa2Nft0QIsv?=
 =?iso-8859-1?Q?ms4i4F0y80uGsa6x6/9jFQ2tLzfy1aVAyRexziv2e2p/HhXSmc/lmePjNi?=
 =?iso-8859-1?Q?i3w9jV+lUTEtTDaJoCqzkZmt2hRtFRmOYbpLBzRvDhAOYkPMnDOrgE/jvG?=
 =?iso-8859-1?Q?XQtAeWg4F1V4v8mUTDUBYn/5y/IS72XdWMQ/y0JF1bK09D0NhV3PDAGLyc?=
 =?iso-8859-1?Q?Hk6t+ix5qoxhpwmtDUC2MpP5wEEPXdn2BgBVMurUlzIjxFaAOHCwyxhpj8?=
 =?iso-8859-1?Q?DYCNr7MOfGL4TwydvaOLI4XePGnlGxEIo3moCwmfDpubTMuwzYJ8YiKCX2?=
 =?iso-8859-1?Q?C/psSIR6fDVKhwqfuTEdWAdNaF3dVYkRJKSUbTiwHl/YPjPOQUHl9twx9r?=
 =?iso-8859-1?Q?EVx7yY2XNojeHI0Pwt3ky2gTkvKtf6amfwERlqLQsM+eRnRGQa/A7pcJai?=
 =?iso-8859-1?Q?+qfH5f495BnRY5QfwQOiSRVxk1YXYZ+JT021DG1ud8HdNw3qzBbEw5FnIq?=
 =?iso-8859-1?Q?38VKwy/nns8xp5LNys7NMUcLbYexc3vehHLjiEzSkqy1koB+SDYfwBlZjO?=
 =?iso-8859-1?Q?PG077/2hytXn5vBsbYsKNdNAFnrHssLHxoK6NtFHnMk9mUmhC8ZFGWEraW?=
 =?iso-8859-1?Q?Oya7PkFEbA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qnLD+J4KVkVgHWnMxRKbN77t2FW/0rxfrZpsLBvBDAmiZlPNFyTfGxQGyXDPWD8Z4w6TzYtibKzQ7jMKgX9J2VtRHaI3MjDr+o9mmOotV8rLK+NxwJbVmij4XJZiAVVab3JFf1Uq7mytE/XkkuFecsr8UwPAN3/EdJAPEGr+/ThY5/fmX2H8Bz+QeO2x79WHQai+dRp3TACg+hMtJAk6nlkPs7TgBu8KBsifKtguHP6zzpNzVDWY1KBSiaRTP2ccX1oNhIbC0VbPbufCHUJ3NXbkutq3PT3M/Cnx1iBl/nOvg4N2P0XHZ8kkB73Ppw1UjJA54c50+GatU4H/2n1mZA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daa4b2f-fe9e-4e3f-96af-08debf887a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:02.4656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhZZW0lH9mRbJdpiN6GKUVhIlvvQneRxM5tHO1/Dszyeno7qw5VYmZZUiwgy//X0ahK99H9nS78DzJe/o/LVAHJHcPn7MD3KX6Q0gN01Y34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline 6 standalone TypeInfo variables (aspeed_hace_info as abstract=0A=
base, aspeed_2400_hace_info, aspeed_2500_hace_info,=0A=
aspeed_2600_hace_info, aspeed_1030_hace_info, aspeed_2700_hace_info)=0A=
directly into the 'aspeed_hace_types[]' array, removing the need for=0A=
separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 81 ++++++++++++++++++-------------------------=0A=
 1 file changed, 34 insertions(+), 47 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 4c9e913f6c..c61efe50c4 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -696,14 +696,6 @@ static void aspeed_hace_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_hace;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_hace_info =3D {=0A=
-    .name =3D TYPE_ASPEED_HACE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedHACEState),=0A=
-    .class_init =3D aspeed_hace_class_init,=0A=
-    .class_size =3D sizeof(AspeedHACEClass)=0A=
-};=0A=
-=0A=
 static void aspeed_ast2400_hace_class_init(ObjectClass *klass, const void =
*data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -718,12 +710,6 @@ static void aspeed_ast2400_hace_class_init(ObjectClass=
 *klass, const void *data)=0A=
     ahc->hash_mask =3D 0x000003ff; /* No SG or SHA512 modes */=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast2400_hace_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST2400_HACE,=0A=
-    .parent =3D TYPE_ASPEED_HACE,=0A=
-    .class_init =3D aspeed_ast2400_hace_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_ast2500_hace_class_init(ObjectClass *klass, const void =
*data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -738,12 +724,6 @@ static void aspeed_ast2500_hace_class_init(ObjectClass=
 *klass, const void *data)=0A=
     ahc->hash_mask =3D 0x000003ff; /* No SG or SHA512 modes */=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast2500_hace_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST2500_HACE,=0A=
-    .parent =3D TYPE_ASPEED_HACE,=0A=
-    .class_init =3D aspeed_ast2500_hace_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_ast2600_hace_class_init(ObjectClass *klass, const void =
*data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -758,12 +738,6 @@ static void aspeed_ast2600_hace_class_init(ObjectClass=
 *klass, const void *data)=0A=
     ahc->hash_mask =3D 0x00147FFF;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast2600_hace_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST2600_HACE,=0A=
-    .parent =3D TYPE_ASPEED_HACE,=0A=
-    .class_init =3D aspeed_ast2600_hace_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_ast1030_hace_class_init(ObjectClass *klass, const void =
*data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -778,12 +752,6 @@ static void aspeed_ast1030_hace_class_init(ObjectClass=
 *klass, const void *data)=0A=
     ahc->hash_mask =3D 0x00147FFF;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast1030_hace_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST1030_HACE,=0A=
-    .parent =3D TYPE_ASPEED_HACE,=0A=
-    .class_init =3D aspeed_ast1030_hace_class_init,=0A=
-};=0A=
-=0A=
 static void aspeed_ast2700_hace_class_init(ObjectClass *klass, const void =
*data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -823,20 +791,39 @@ static void aspeed_ast2700_hace_class_init(ObjectClas=
s *klass, const void *data)=0A=
     ahc->has_dma64 =3D true;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ast2700_hace_info =3D {=0A=
-    .name =3D TYPE_ASPEED_AST2700_HACE,=0A=
-    .parent =3D TYPE_ASPEED_HACE,=0A=
-    .class_init =3D aspeed_ast2700_hace_class_init,=0A=
+static const TypeInfo aspeed_hace_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_HACE,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedHACEState),=0A=
+        .class_init =3D aspeed_hace_class_init,=0A=
+        .class_size =3D sizeof(AspeedHACEClass),=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST1030_HACE,=0A=
+        .parent =3D TYPE_ASPEED_HACE,=0A=
+        .class_init =3D aspeed_ast1030_hace_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST2400_HACE,=0A=
+        .parent =3D TYPE_ASPEED_HACE,=0A=
+        .class_init =3D aspeed_ast2400_hace_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST2500_HACE,=0A=
+        .parent =3D TYPE_ASPEED_HACE,=0A=
+        .class_init =3D aspeed_ast2500_hace_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST2600_HACE,=0A=
+        .parent =3D TYPE_ASPEED_HACE,=0A=
+        .class_init =3D aspeed_ast2600_hace_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_AST2700_HACE,=0A=
+        .parent =3D TYPE_ASPEED_HACE,=0A=
+        .class_init =3D aspeed_ast2700_hace_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_hace_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_ast2400_hace_info);=0A=
-    type_register_static(&aspeed_ast2500_hace_info);=0A=
-    type_register_static(&aspeed_ast2600_hace_info);=0A=
-    type_register_static(&aspeed_ast1030_hace_info);=0A=
-    type_register_static(&aspeed_ast2700_hace_info);=0A=
-    type_register_static(&aspeed_hace_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_hace_register_types);=0A=
+DEFINE_TYPES(aspeed_hace_types)=0A=
-- =0A=
2.43.0=0A=

