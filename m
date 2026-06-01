Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B09CD6E60
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjj-0003LG-AJ; Sun, 31 May 2026 22:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjh-0003K1-Le; Sun, 31 May 2026 22:50:41 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjg-0002lH-4v; Sun, 31 May 2026 22:50:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad/1VcaVKI5dx+eIxY/1InOmoEYrlonIBiNfJ2+3FKDJitkjgesIMNyYtRRLNaTPtrlmBhRU6HWY7eWXDoTSXlOzeKyrQw0MYLT3v9FcCh6X2+NG7iQHk8eKAxXEOIitZHom4rO+2H5sm9sXt+f+B9YRbwy1PF0izUnYAEjDt4zZ9mZyUO6o9Z5n2TdqiNEUVsvsqiEwTI7vS1W+Q9iitmxbVfDz1IZcNnAe5HGQxK8oPQDBahNejiHAcssCdhGQsy72Lw0X+y895jWoSyghEQ/bT9vZHvMQreYczDXmCbwh1IQeaIcaXW9hbBdsyX1w9MKraHLlKeR5nLcysKgCNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUOjr1PRPrJ1kA3ZOsbFeNf9N2oGmngCYcowWDDNkjA=;
 b=OK36Y4dNIXZw1gr+PO6eEON/fUzdavUmF2nGua+h79yTVWVDOY1uSSPwSJidk2YsPsKdQBDT9ybiYrdLBfIIdOAK70wMFdkDI/30lDGfX4F7kk1gQ7fXnyIdInNJEV/EyUPgbT7KZcQp1EtABPbe/y9KownijA4RYK2OI+B8UkTDe0MVI9S/Qdpdh8qlxWX54wMbbLLMscbD24Wc45bMaxlvPir9pLOZH35ssqnVuPnmMm8Xlpuco3po2c7TRLfZyWcIYu0pBJMkTpicWRy+IMrPwmrjYlGa8RmWQsX5TMvs0ZC4WiCnfxiy/ZE0BpNCwFifMOFss1QmJPjzYsukhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUOjr1PRPrJ1kA3ZOsbFeNf9N2oGmngCYcowWDDNkjA=;
 b=MCyBiuEsykTkbkbsEHzYIAedacP7eZlsQcPdJs+90AKxLnju25CBx3DOrNFihXz2PH8xgYNPze37EhQM1bwCsXnAyZodw9akb0TnI42v22r32D4QFsnk4bBPtNtZRru7/YYgOdHL5TROiE06k0cGBllyK3ODhNnTn3ug3hN9eF9p8Ru3J62sbIFZSefLMtGN6x25BQGgNg4faXkwwbsfX6MRuvySUEIF2jhIaOs48dMDHIWr62z+Dpn3X93MfWbOtQXp40QO1258oGtHjPJkasx/mrahomMqwMgnlsmEv44KZ22/pIcNReDKdBQMB2Xj7QH0qsXBYF3aLcXsy0e/OA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 02:50:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 20/24] hw/fsi/aspeed_apb2opb: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Topic: [PATCH v1 20/24] hw/fsi/aspeed_apb2opb: Convert to
 DEFINE_TYPES() with inlined TypeInfo
Thread-Index: AQHc8XFpwzaHtsuNBkqhMuWK9qOSdw==
Date: Mon, 1 Jun 2026 02:50:31 +0000
Message-ID: <20260601024959.2347639-21-jamin_lin@aspeedtech.com>
References: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260601024959.2347639-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 76980d2b-e809-49ac-9c81-08debf888b87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021|6133799003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: 8foMr2hVA9M2g+gU0xMy8PmgUgFWeNOUBXZeT5MakaVIxnp4qxpLTOdFL91qDhr5IVA3l3OAKwsVYnbTa36x0ljs4tECUL6vYPVzFt6ssVz+666/UGmFSq2lnK48maTv0ie+rC76q6jft/3/RB2oNJfCEi/ivijjWsEeXGHAQUGk8MQJK5QeTLmUUZJPNnCMuY1Pbnu7DwQNjYGQ+8GBpQsETdwKXaS0OkaRLKkvPE7rKSVJ9cK7+99fQhCExvrpkGbCfkNrH87xbBDrgfFaiu3RVwyGDp4xl6TVIRJ8PMH2SNV+88EwVtF6luQ6vuYD9/siocRbtZDxoPpkmiJ7pV6lsEI2+YPHuqI8ONqhtB7guoUT02AD6Ec43crOK+HZYroY/tsbkpMV+H84MLNhmbUkcY3GZkHI2d3F1iMFLsiCDMHeK/ZAlxsOsHHZGwowpC4jlWYB0H6kNsPoO62nYgJ6oSc+JndwORcNdYYQMZ/4PpXuBEuYI9udAGNo1EHbuM/XFpwRkTwK+1hbg3BERgiNqDGtE2o745bN9IdTwXDDsJoYFCr4Iz212Nkc37JYW5g82jZBdk37DjJrIM1ASCVzzdDmi72qwRU+I2v5ey2ThFMjE/OLwnhnN3m4KXh71UPNKOyUNmO9WkpiDx2/zv3e7uUzy7vVnDwOD/3dj+WDeSvbVnwZi8L/q2+BAkWittR4gsUaX9N2kyfAjcby1/bDIwK4aQTZgvflk+2U+4dQi+btcCRxpi4CYsNMWWuXduKiZWmmBW4uLza5CJ3ghA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jj5A4FxSB7P2T5qkWS6HNT0RjU9jiZJLQ4Sbl9f54bu/0ByT2JihF3lRee?=
 =?iso-8859-1?Q?2aD4e/mx/hMmP4S1BMNeo93TVyEOuB8GO5lkj37HXV5j0Z+Ybbp8ex1e7Y?=
 =?iso-8859-1?Q?B+UT2MQORY9U5QX+y/daOlCIMVKznfmO2+49qEHonHclaBzpNLyb/SfLif?=
 =?iso-8859-1?Q?7/c6n+YfdOIDPosXhg61kBnlKPe8seJrDs0CyX+lci3kmFYRIV5tZ7kNRx?=
 =?iso-8859-1?Q?Jlj2A4AV0iDNX9ctQhA1BcCsgxM38tWg7/AldbtuXkWjP8E1tMY3lxBWXn?=
 =?iso-8859-1?Q?Q8ttv+BfmFMcjOXcHFCGhxJ8uOUTCvh3G+6ctvozR9yo3OL6P5brcoNONV?=
 =?iso-8859-1?Q?mAizps6Oyotxz724Zs1zk4a3xSBv7U+BAq6cvLvBzQqwdrTF5qBd/p4Lqz?=
 =?iso-8859-1?Q?icPvHVy2djCcjsUR7PuDTJ4cmtbWDJpaPIPR65Ye/DIK2N2+08FCtKOblr?=
 =?iso-8859-1?Q?98Lo1bnNL4oCz48gHDjWYOiPoCjIeoOqvSr6JGMnwBOvtZWS+M5bE8cs3O?=
 =?iso-8859-1?Q?bldJ1vmNnBDPhXiSgxGBVDNjpRwDJL/jL0BZL7g9GLeUmPoniz022odZGe?=
 =?iso-8859-1?Q?HryJ6/jxmhK8YLW05myuq56TW0YlGHbUT7wPvsrbZfUF7SnfGjv7w9jWEM?=
 =?iso-8859-1?Q?HcsF3RDB59/OwLzRpkhCZ+qwJx04qz7gaAN1/zoiIe4XBBik9fBC/M0iz7?=
 =?iso-8859-1?Q?nBAiXRd/qhq1k2y9vUgmjrMmIjkXfdvB7v92AfXdZGB+tIirlMA8BB7XCF?=
 =?iso-8859-1?Q?HzNUew8flGynwOIt1LJgJ4SeVRsodTbmeRmU3VWczFK6nLwqb/Eb98lbwV?=
 =?iso-8859-1?Q?XdAURL+u6aOFgkYBQJ8A2I/H1yBgzFI8f4D/TS/u/7eGnJwSxDB9ahotEt?=
 =?iso-8859-1?Q?V0bylorfYsaElF25M/OSXwHWIgSTeD05EI38ZV1LckaxA/fhscaDo8gcQX?=
 =?iso-8859-1?Q?ili/ifJQgrUrnSEiMjHw+KhuQnAx/23MiOK0Bcmxit4QdfXyJa7dP9oQ/5?=
 =?iso-8859-1?Q?dcGrj0bPJC+TNZWFG/7IOdB0M5WtB0kVum/LgXoOHqAbhy3CB7jVOQ86Um?=
 =?iso-8859-1?Q?/BsZgqaaoU1amg97OkvbACMxkapV6/4jSFZzMFmmUejCvyV87jMLFh1Wpy?=
 =?iso-8859-1?Q?RbdSJk1Bc0F9aR1BB7DjIO48tvxYX2f8IFupQwfFv6XYBO7kDLWIshkJq0?=
 =?iso-8859-1?Q?ZW7rDm850pJHfR+yvyLA5nSQtCXsDVRT/sFFHQi1HohMwfPfp/qHWQpvTH?=
 =?iso-8859-1?Q?u+AMwRrw7kBTEtpmG20s82QNiyqz873Wye+r1srU6pIIx0vGuEX1ZHVgCa?=
 =?iso-8859-1?Q?H1l86+nZMMzLIH8HC94E/VROY6IHG6GAcnApmkB95Pf6FLkP1CqraWDRUy?=
 =?iso-8859-1?Q?RpJUajGIrGrm/WHRIQ5M4C49XBHRO4lxCKQDcsOnHwJMO9w+uX3PkA+H1Y?=
 =?iso-8859-1?Q?f5fnMCKbIwbdyJnBJR9zXC7ISJZ9arAs4NzIcVENeIA6vYC2i67vikBF+d?=
 =?iso-8859-1?Q?hDfCBN3q1rzFzQsFO7XAVjpuo1IJLDIxEdbirFt+7PBZUrqh54Aef7Q0oS?=
 =?iso-8859-1?Q?RG7J3GvwU6rtiEdPQPylNUX38nBXVNR32CtCzvqvtM9LojuwWZtNiS3wFb?=
 =?iso-8859-1?Q?rEUCPCy88Xs7qyoBYSPLrlQamCbyXkYamgjFJ40y+odxr//N4mYA6+ja0d?=
 =?iso-8859-1?Q?6PE4gCccQPvIAbVPJwTfOLgDbNkRVMgwnyUK1PEtQXKaS3txU94jN1oxv9?=
 =?iso-8859-1?Q?NV9j8qR/nJ1OE1UWlFOLPT8qEYOjuM1jXGL9TAotIavQDu4tWEy+NRA/Je?=
 =?iso-8859-1?Q?cCntnUtDSQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NPrtUFfkVu+6DiFZZ6tg5pCGcXnqH8+ZYUPiGhC5vmkTAzoNHAiJ7WY9+m6BKb9WsLSk3EXFSaXiWGoz0atreJ8Y3Nz4Bqi38YRTLKsfe8ZCmRaMfsXgDdPJt7DrBpgoyFPjAtu/MUvXpvRaTiGUTwBvD8nxlhRosqUDQXJxHvoHFw05dQH0qN07rnzyiui2yO+d1lSZtKOmEBX6Y6FxR2S3ryAf32HZUIzUzZKxTSrD+GOGVnQc4R6cmuWZeR7RDzDgMPDI5U14T2ABdWZfL744Xpc3ITp68quK359aXpZPA3yCf6xtRwlyz3Skx/aup01C7B6rpOW2envn+EdWJw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76980d2b-e809-49ac-9c81-08debf888b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:31.0329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQqn3DKWo+jsjRjE6c40qsbDKGPO4hBw8qwmMLjXwF0Z7U773HAIn7zanVFunQuTceO0jHv12gH+1VR2R/f2iVpzkKhuVsMSoo36+CaM3SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
This file contains two independent subsystems (aspeed_apb2opb and=0A=
fsi_opb), each with its own type_init() call. Both are converted to=0A=
separate DEFINE_TYPES() blocks to preserve the original registration=0A=
boundary.=0A=
=0A=
Inline the standalone 'aspeed_apb2opb_info' and 'fsi_opb_info'=0A=
TypeInfo variables directly into their respective types arrays,=0A=
removing the need for separate declarations.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/fsi/aspeed_apb2opb.c | 42 ++++++++++++++++++-----------------------=0A=
 1 file changed, 18 insertions(+), 24 deletions(-)=0A=
=0A=
diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c=0A=
index f2d9a9669a..7a37770a43 100644=0A=
--- a/hw/fsi/aspeed_apb2opb.c=0A=
+++ b/hw/fsi/aspeed_apb2opb.c=0A=
@@ -319,20 +319,17 @@ static void fsi_aspeed_apb2opb_class_init(ObjectClass=
 *klass, const void *data)=0A=
     rc->phases.hold =3D fsi_aspeed_apb2opb_reset_hold;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_apb2opb_info =3D {=0A=
-    .name =3D TYPE_ASPEED_APB2OPB,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D fsi_aspeed_apb2opb_init,=0A=
-    .instance_size =3D sizeof(AspeedAPB2OPBState),=0A=
-    .class_init =3D fsi_aspeed_apb2opb_class_init,=0A=
+static const TypeInfo aspeed_apb2opb_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_APB2OPB,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D fsi_aspeed_apb2opb_init,=0A=
+        .instance_size =3D sizeof(AspeedAPB2OPBState),=0A=
+        .class_init =3D fsi_aspeed_apb2opb_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_apb2opb_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_apb2opb_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_apb2opb_register_types);=0A=
+DEFINE_TYPES(aspeed_apb2opb_types)=0A=
 =0A=
 static void fsi_opb_init(Object *o)=0A=
 {=0A=
@@ -363,17 +360,14 @@ static void fsi_opb_class_init(ObjectClass *klass, co=
nst void *data)=0A=
     bc->unrealize =3D fsi_opb_unrealize;=0A=
 }=0A=
 =0A=
-static const TypeInfo opb_info =3D {=0A=
-    .name =3D TYPE_OP_BUS,=0A=
-    .parent =3D TYPE_BUS,=0A=
-    .instance_init =3D fsi_opb_init,=0A=
-    .instance_size =3D sizeof(OPBus),=0A=
-    .class_init =3D fsi_opb_class_init,=0A=
+static const TypeInfo fsi_opb_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_OP_BUS,=0A=
+        .parent =3D TYPE_BUS,=0A=
+        .instance_init =3D fsi_opb_init,=0A=
+        .instance_size =3D sizeof(OPBus),=0A=
+        .class_init =3D fsi_opb_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void fsi_opb_register_types(void)=0A=
-{=0A=
-    type_register_static(&opb_info);=0A=
-}=0A=
-=0A=
-type_init(fsi_opb_register_types);=0A=
+DEFINE_TYPES(fsi_opb_types)=0A=
-- =0A=
2.43.0=0A=

