Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBD5CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsjS-00038Q-4x; Sun, 31 May 2026 22:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjP-00036m-Hc; Sun, 31 May 2026 22:50:23 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wTsjM-0002Y8-Le; Sun, 31 May 2026 22:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsP/kUUxMgSSOyMZgKuiGqRyNHpp3bFyLkaakSV3Ef/E7z65wCxCwr8T5id2BU4NHEmuhv54SzNZ5d1Mg6lYQaa2M0ix0qqOeavYfHuA+Xa2TNo6nlJ1mOHzrr/6CXECQrYjcN4l9pm8HJ+izm2AWmlnl76sfcdKEymiib2gM2MfkqHTZS3/G+jK0nFLIUQjxswuQKfPHpqLYEF6dS5bvZfB4wml9701VoajpT565Wc+qVwiUmFB20zTs0wA+4gFSuc9nF7LZAGhoWIBmSGL31wlhJXS5I1DhySGpMEgcol5ntNFz0oWL+cO5EBz9INCSFjuhM/tmQpXQrElOAzQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsNIwz/Wi7aP/WEnTeZjG1pEmbqEVo0Uhduc6aO+7r0=;
 b=v9brKYTr8zkBXh+rZC+MyLKmqPC/4cZqHie4inGdeBzpmoNUfnWqjVwMQmMmlIIDxrVbSeOQ6G7mBVDUaVXx6ooVKHnHqup2wwH6Tc6KaPmiKXPG8cLlaDP8cJ3aLVmiHG+xoy190ffgyiIFdjkpjihJ8jUpMBolvYpx1U/etb5B02gOpYFJp1UG9b8YPta0NyHJkwlFeSpIxA7ca3xhj7gnuZpzeGwX7Op3Hl0jhIKur+MJAylo2Jn0fkFJDQjR8avR+zszDwSNRTwzklRfWGHtK1OYtwmSnI8LAR993v3hW/ggd1EqcjMckA8bjmV1+BlPs+B2mQzoEBG+m2lMtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsNIwz/Wi7aP/WEnTeZjG1pEmbqEVo0Uhduc6aO+7r0=;
 b=qPmQrKfYLg2LAmzahhydp4zXaXwGovUBsHoc3PghOQGJvti6XoDNiVv4v/drZr+Pg2IwxRFHyjqnj8xs9US2RbcbjwHM/FElTBiUYOXRW2hhxug8Y6dnuoAtxfk+lEzWqzCbEB75uxrP6fKq7yIYsTLbY13Pq94zCvNe4PFRT3qf0Jr2ZDzOPpw9wKrVTGiUvWcekxs/vSce1yExNVM7q6lV8I0bUGwrPpdi4X9F/8zBZONSUpZ+XUOtoDvox1e0jzws56AuD+ohNJO+vfvrAxgDDatl86Duk92qVX3lb7OzBjZyuo70KbHewx+Dkofve96mCOw1dLM/p9+LmQ6sEQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8361.apcprd06.prod.outlook.com (2603:1096:d10:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:50:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 02:50:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/24] hw/misc/aspeed_ltpi: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Thread-Topic: [PATCH v1 03/24] hw/misc/aspeed_ltpi: Convert to DEFINE_TYPES()
 with inlined TypeInfo
Thread-Index: AQHc8XFaVeCmLSp36EaNYjmxZMJjfg==
Date: Mon, 1 Jun 2026 02:50:05 +0000
Message-ID: <20260601024959.2347639-4-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 2ffe634a-67f0-419d-f2d3-08debf887c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|38070700021|921020|56012099006;
x-microsoft-antispam-message-info: ra9p2CKm1Cvyj/4gqjA5K1iei/DgVoq+QJomhVSiA/bb6NPT35+xi4eLAcAS0iYSkl6T9esa+L/8DYLubpAXiQYkH3A/xKQo/LqGAD3J1mO+ZHpY12IEK68baMPzJYef1ek1wbMCjNeV9hIpKa5K509aCHZf3gAlnuFSBmPe/iyU+M79GL8WVmbFPbyDWAoKGRw3N7HNQgtW7bifeSkhhaK0p385zBQeHwHiHoKAuw29OV/Sw22aklxZC/7JBarI+GU4raKoPgnqvdxsQO+08M9WbciCF5iPtJMnvzb2XttIvklj2EE8g6uBbsa8WfD/Q3f4vGrOPznBYb6rXyO+G2EgWKH1Zc2KFZWRmy7X7/V21oWPPsV1cpjxNq/Z6ymhh1ZH3dteQ0RCkJVsm55kf/ZyCvRAFrLzJ0ROTo98q6OTL8xXvW9CIfdQenIb+IpURWFWnRVxBPWFCnKz7jRWzYN2joLsj/uWUd6PQ/vxBXN3GicUEy/gldm5NJcv13MLS/3qLeXHqaegH23er/0nw4E4p9E3G4hV1ZMKND4RoxB0luQXLK4NqcpQ/SCwACLBrlkbJJQZQ6XJuLTCbi9OuIDQyItmlQH+uunDzptiUtcP4N3xnFtnQ1cThf/U964rtjbce6tdU0z65tKUKuahsVASKW2EwxDkbI0cqUlHVzC/+BaTb4i+0PCrs29+0FpyPnrD51dWrZgYfQ1AReF/2ZFqdw9q8Yc7X6N0pEgF2DrMjrKQ8yJThSZUFNkYuB/7oB4iPb7aKKQ+1yXHmRCdSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SqgqsvrInDayMbE75U2Gu/jaf2rIi+wCKJF4csA4v866knJdeKMrApNE6/?=
 =?iso-8859-1?Q?6SJndGcGS5P4qAgf3PNjwSSx90qs0SP/mNEdgG0IUiS1XLn0gl/vom0LRI?=
 =?iso-8859-1?Q?MJdLdLgI1YDypO/GtD+J/VezhM3nhqm4dF3VXGZz3/U5z2YsgX9LozBnpi?=
 =?iso-8859-1?Q?DQwa0ZtGQyPUUjuVw98XkilxYe61HJTEBvIZUuvR7NmJMoBjGJ/r3wL+ON?=
 =?iso-8859-1?Q?xS43e2P3qhJI9ksQRtk0HOhfoN64PsGvARUBfT/vZs37hS90c0Ws7lDOt/?=
 =?iso-8859-1?Q?2Pe3fLLDONfeMAOJ0QOOfLodZBqDErH7w9ACI/vBlUkc/RqyMtyz02K1hD?=
 =?iso-8859-1?Q?FGHwyv8NZezgB7VF8bj++T7peyTfHfY2fvD5TJEnRu9zekpzHguofqnue2?=
 =?iso-8859-1?Q?5VJaLDomqllmiA0KMMWZn9TAxSeFoPQBOpsJ+IX7HHDVyCD8cJIGfTe+ep?=
 =?iso-8859-1?Q?GwEpK6l6EqLU3SctHt3VL9NuIZRRgTyiMKy1Z5LBT4u3VLjmrOYOhfxLUh?=
 =?iso-8859-1?Q?Q24taYCrEmiSOdq2dmlgtOBK/L0TJzgzw/jwALJGMSR1Ix2D3cz9HRCbG/?=
 =?iso-8859-1?Q?B2kzkAMry5MBWKD3fdVdvi8q+emJb5uAimdOtHiBxmCd1uXofPKn17lLCw?=
 =?iso-8859-1?Q?4a/UXKrr3cbu/r2yXhTH0RDJiWLHpkgny0qHW71ZgwEDCxiuBeX8oGamsI?=
 =?iso-8859-1?Q?5hCx9OCMGuCl1xdNtayohCuL6R+u8xcq/JkNnNR1bagAV9qjnHAZf9uci5?=
 =?iso-8859-1?Q?7Ho056+BUusAxTWT0EDYd9V5/YECm7iCsk+ymN0F/Xjq0T8+vIedUjnrVO?=
 =?iso-8859-1?Q?fqpEOzOzrivZsIaZkefRy56fKNXHTDrmM3Z0hzuvQy78CBIGKquPaz5BNL?=
 =?iso-8859-1?Q?YSe7wvQdxKVF6GnksiXhFKZAfJeJ99D4YWow9g0l3eY3j2RjfB8qLpS1aI?=
 =?iso-8859-1?Q?G7iNdZahJW6XqKvLnhpP7DeTalRw3/S8h25gmG9E7WoBxemSo1LtzIfW1o?=
 =?iso-8859-1?Q?a2Zlg/KKYopQaS4nR3Bl2OFStq08S2Jqaz+qcPUGaVCEkDehtBPR66jISR?=
 =?iso-8859-1?Q?4qMmrltCLn2+79aa98vrpnsYyrnXgDZINAfACInyX/klcjzUEOmH+eR/ZA?=
 =?iso-8859-1?Q?sZcsQPV+4GwhDYo0OJAeHPFq3nX4O1Zv/XdCE8VcsZDUhrzgXHar+pBeD5?=
 =?iso-8859-1?Q?p7c0xiJJ3IkvRSeb8e8a6mApECj7wqUFs4otcjcm9JhgFxetTAcueXt8wp?=
 =?iso-8859-1?Q?rt/Q4fUJsGkPSbeDS0po+mV986fxKTIE+bA45lvGE+sBgBqBCUW4J6jXc2?=
 =?iso-8859-1?Q?yAZGvpL+8a5ArT9F5lsoFATor70GEwx3O2dbsk7ojG2AxrBcsa8nqoHHEz?=
 =?iso-8859-1?Q?ZPGasSEwLZscmG/5y0nxg59+NKFOpviox974etpNIQ89wq8xZg0Zb+8nTe?=
 =?iso-8859-1?Q?GQ9cCGM9W6HLWxLma+xUr3bCnECsS6Mz86AFKG9HTPJPdoxh11GEAf/jEZ?=
 =?iso-8859-1?Q?j1JzuEz1F0Wqgar/8auaP1Xas/kjR/WouSxFOzFN2azmpJsh6Yc+JtfyCb?=
 =?iso-8859-1?Q?x6TD/97GUa2CRoeRUVzIcv0cobzpKNkcvuQsmpTk4iXWPl9Qb4DTCROrYY?=
 =?iso-8859-1?Q?ZqW1+CcsSt8uI/M1Fdb9ParY+oEH2YeCaoXTHueTQ9w+2BsnkmbJmfNELq?=
 =?iso-8859-1?Q?rzyRBV0cwEHarzfdPLgqHoYsirzrczKGUeS4JvLGlorOND9CeQnErfIq70?=
 =?iso-8859-1?Q?Mnb8tIJ39B/ODcByNFVtNMB+3loTncHsC/6b2+xUkWj36zd1CohARBaQJ/?=
 =?iso-8859-1?Q?MGM6lCnhyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZfrPoicURu3w7Msa4T+2IM67kywT/v4RQloorvCHFx7OP/u1oAZBsJPHKF7ygCNN2+XhEYDM1LmN/uPpANxMnr9ozZRa20illDq58rPN5UH57zt9iOQ2daHiBKg4hk+VRhHiJNHXGeGyfifj6neY9t73QqfntiwTthqIpFbCng+6kDcB5MIdXD2mH5lMgyX33xdatv+63J/AiwaAC21clI7e/IPC/YTJrrclJ1jMnCF9J5UDO9cvJ9IE6bzO0DCxiEsS3RLcJAcZVQ0qSNPMGJm9lrPWp+RjKPlSdzn7SC6d0zwb8cKDU5PKhE9Yy93GIyeZsc/9gtw4dyL4Ryb68w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffe634a-67f0-419d-f2d3-08debf887c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 02:50:05.8531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8oRcweiv11N3clXeKLQpZjEodlZAjZCH+zkE5Qiy3AXrTUQC+pOtlKdxDZKCtrZN/3CCmGXLdNI3ViFZi1OkOMG/beYiW4uONxS45XXo0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8361
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

Replace the legacy type_register_static()/type_init() registration=0A=
pattern with the modern DEFINE_TYPES() macro.=0A=
=0A=
Inline the standalone 'aspeed_ltpi_info' TypeInfo variable directly=0A=
into the 'aspeed_ltpi_types[]' array, removing the need for a separate=0A=
declaration.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_ltpi.c | 19 ++++++++-----------=0A=
 1 file changed, 8 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c=0A=
index 956e91d143..2e413550b9 100644=0A=
--- a/hw/misc/aspeed_ltpi.c=0A=
+++ b/hw/misc/aspeed_ltpi.c=0A=
@@ -179,16 +179,13 @@ static void aspeed_ltpi_class_init(ObjectClass *klass=
, const void *data)=0A=
     rc->phases.hold =3D aspeed_ltpi_reset_hold;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_ltpi_info =3D {=0A=
-    .name          =3D TYPE_ASPEED_LTPI,=0A=
-    .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedLTPIState),=0A=
-    .class_init    =3D aspeed_ltpi_class_init,=0A=
+static const TypeInfo aspeed_ltpi_types[] =3D {=0A=
+    {=0A=
+        .name          =3D TYPE_ASPEED_LTPI,=0A=
+        .parent        =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedLTPIState),=0A=
+        .class_init    =3D aspeed_ltpi_class_init,=0A=
+    }=0A=
 };=0A=
 =0A=
-static void aspeed_ltpi_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_ltpi_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_ltpi_register_types);=0A=
+DEFINE_TYPES(aspeed_ltpi_types)=0A=
-- =0A=
2.43.0=0A=

