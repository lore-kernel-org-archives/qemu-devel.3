Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B189C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXeM-0007Ui-Uj; Fri, 03 Jul 2026 02:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeL-0007Tp-Ni; Fri, 03 Jul 2026 02:45:21 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeK-0003xE-8q; Fri, 03 Jul 2026 02:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBDQPn4UTvj+9bmHsSAl4kycJN9SqowBiS2R+C6F7OC1awLr6XGB3y8wyiZLpKEbBEnT2nVHeJsApfLAbVFAPf8bLxlovMJ+skDitkndGk3R0qcCUdxTWKCFiM1Q1rvQqK0QCxTl9JjzBdLTcX/123r1Jo4GDrwKdc+YtiU/+SSQ5BVB743JIsquQ5gxxMiA9Ml9nY12VJ4hKQDw0fTVv4CJxkWZaLRINED9B3Zhdf1Ff0B8x/bRryBfGA4UDW3F5rYrEiCghb1DmZQbgGzpcGcmGyKPj/9dPuuCJhmeKfnhty4EdA/E24Stn2K1qZGMD6LqgmJ7sHQOcrTT7MXqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlOKcHNejYA6ZDWdIQRowZSq20VYHTBpir3AdeTO7cw=;
 b=q9gGHkIpibdvzO+s4+jquD+KlFvM1kYtkf7+9dr7xuS69cjsw9K55/7nnhLlSrGFHDqf3x3KFHvXg2lWSTaT9Adx5Qw7fbbMXT/ycQvTK9DJEFVtkJap54wQkrtp4a0ZNF9brUnBUBQ1wyiODcPIsXUk3lZNl79S/sWS8wtGLhakonjQc45eI9VrF/R388BI+7ZBl84xYMBy2kTHyiwS5/0WjKfhuECXBXo5Z2jcfpakO9JQsPbAgNQZoGZI13E8uLZyjxYE6De+2mfqLhNmqr8EO86uoLyTLLq/jmJWGws0Mrzu7IQj0eHhUAnNLoqadrEIeWsgvq5pM0P45XJNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlOKcHNejYA6ZDWdIQRowZSq20VYHTBpir3AdeTO7cw=;
 b=Zv8mvLfVUAnlOQQYshSyeFUgrlhr50hDJhhMGIPfUiPTVx919zom5+0sCcdjVV9mW2/6/YsQaoYWaiK5XBO7UY+JVjpwTYSo/RrbyKiJT1HbpL52sEYyvbP8N2PNsQhTk4xX/wwEPZPkNciBpKaQCyZuP7ZJ2PrZDcDPFqx3G56hREW3Q1s3MgfnyX5bYuxdia+2LaRhC5wYdpdKHunvLksiZ9ylp2M0EtYfzFCW1jU8sDSkRKevBIoojCA2l9BAxvg5upKfgd1RO2zNFCSFt012V1OM7eqYrkE/ann+rveFktnQ6YMSgVW8Q7SAA99hjSZyoTkshrm0pGOkPUYFzQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:45:08 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:45:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 1/5] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings
Thread-Topic: [PATCH v1 1/5] hw/arm/aspeed_ast27x0-fc: Fix hardware strap
 settings
Thread-Index: AQHdCrd9Bjjldl+kkUqyffCrvFW7qQ==
Date: Fri, 3 Jul 2026 06:45:08 +0000
Message-ID: <20260703064506.937904-2-jamin_lin@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: c20ad692-923e-4b5a-de97-08ded8ce9f9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|6133799003|56012099006;
x-microsoft-antispam-message-info: yFGl8eXtGVMe7NiH+3hDmphovpgqPHtx4oOrx59JIlSdciQSam94jPZNA2r6u1GCkkZzflPsvCxO6SFxYfDQ9c4GXzyUuU5BwN74r9XLr3TTR9rYd6C5UcEmbzyQiCgi8PxYNSf2e1Meh6IMxUsQJqgNK/UkqbwCDGapKnDuoCANnCAaX5jpLeMo/p0VZ3YdQGuyvZjPL5AgOWuwLBhLH8wQfhFJxz4ZZAGjzviHs7tgRtVwdq9fHGKZT92IyCUap7YKjZXzHOnp/rgEk/xOAjIFswx+6Kla8AI+Oj3Slfe7SmmnojLqzWwhtEU2kRnPRYNhRhYoZM3sqq9qxw9mrsRxTHPuEhcStWqI35Sn2HTNwOOSQ0e/6htuY8Wz1iJFjKVY3lkWLzz8TRCObGRF/qL3FMV+ti5wNoGM+DNTkfvVINTst6+2qN1eNlUJ8RUc57nrS6yR+hCsM+6h/zzGM7wLmV0StEfqgGtkQBw7vtks85lQT32+4Au8ow9Ko0wHKGZlOTtVMeuVAcuR2FfQJlY0JV2RRk7tFWiK+h/wGK6wENTjEfy3QDu0cRsmFCKqxDh1GnZEnfVjYaKLH59a0gt74+q58xzOjw+u5mTWyuUAfcBaKgLKCJJlw6Ahxq6Eoa99j82BJFI3h2wFBqO8w1LycEdCNa6/UAEYR81kYui4P6v6VEcLFe/AQtpONcCBmr3rvg1YecdV0plCQ+jqbAkuCpkgXqOtNqLVbl0oOuk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qG7jEJHy7fdwfKoj85r0wcnrE4n+czj1vj9ZVYVIRsDwlOkWSe8abpeeab?=
 =?iso-8859-1?Q?olZ3sCUqdWyHNTqVIEkqtKVr6O66ZjMHxlJ5SNbHzSavcFH3tgLuYCXJoY?=
 =?iso-8859-1?Q?lbuY6+MEcxFhrMz0uqh0XlrFdijKLGfxHeYJNeW9GGoe6E1+g4lalc+iQ6?=
 =?iso-8859-1?Q?JC0FaYPutymeXOlnqCRB7gMJoBvUDBPIV+x0BY8NRj7ZHJmC49fiLxNyvU?=
 =?iso-8859-1?Q?wtFIRYrD9t7oDPUQU1YiN0LoT5wWcCWF6Z1SN3o8UNDPA3VrnDBpTj17C5?=
 =?iso-8859-1?Q?ZHXpMbPSXpZlOssg19tKKf46i0oSDiLty1JUd11/CWG7+gBVnstj2ex6Oq?=
 =?iso-8859-1?Q?Czf6OMcF69z3T8apnCSX0kAaqBG8eVBeJFLRnmAoEfIDFgRTTZAbDfTe7S?=
 =?iso-8859-1?Q?xAw/DFvLJa5iBRkHqO6T2q7qOZWTCeR9U1xQdd6wM3h/dai8o65XCG31QA?=
 =?iso-8859-1?Q?Fz9o8HIFwnUsjY/o2EI/0a8h8ugYTMXDjCcDMXqqcYF7JJ9vpF1t82viCP?=
 =?iso-8859-1?Q?rIjeauOnJhrLTZL5dl3J6SKEMokMEZGT1fLv8eovMw9YMPTQX5PRhs4HO1?=
 =?iso-8859-1?Q?YCds+V8dwMVBxXMkB2LVY1NR6sbcTk4DHfS4qsI74Sx44XeJUSnluTxG6o?=
 =?iso-8859-1?Q?0FwcZcKnBqgc8l8PtFfSVODRgovXYjjKawV6+MrJwn0FUcjBqy6wZOMga5?=
 =?iso-8859-1?Q?5WBxbLn9kp0nI8bA0ddd1NohQD7riLb07TOONBURrVDBXjBc/KtvSKZ+ch?=
 =?iso-8859-1?Q?z5UoZyJ8Ljwjod+IyKX0G9NLUU4wQ9AWTKrp6ldWj/EVix1Ki9tyJUTT3U?=
 =?iso-8859-1?Q?/P2+GB73JRQKolipsFzaC+gB1bmNb9uCjk4c97KKGbIacCZCPWrvAXS9v8?=
 =?iso-8859-1?Q?rUNuIyG3bHxTBG6rf93q705cEICuMtQJ1lShT5kSUHqMwfkON+h9YNkA/k?=
 =?iso-8859-1?Q?1wawOOIqD/m5OZjCUCnXok0WVBRLQ4e2B2A/ufaEN5DAYbTTm1cSUUVQoE?=
 =?iso-8859-1?Q?ajH3Ijk2Ft+cZaQguMqXigRNTILFP/XoHFQCJSPnTAgc6y3yUaLi+YgTvM?=
 =?iso-8859-1?Q?ull0QRrrTCNdnptzgmjLudKE1+qHInvQTGaAR3Qttn+OS0ZDofq7wm0yZb?=
 =?iso-8859-1?Q?LKDGwEfp5Qw/3C8YMzKKLrbR22U+FDfDeXrDvHRV8AezwiPgSaAtIU/XWd?=
 =?iso-8859-1?Q?hAUb4YnSyHNfXdXxBHI+04MgbLIHDSvRx4RszcC7Vs3x3S0KwVmOnWO1tG?=
 =?iso-8859-1?Q?yRJTbgGEyKXZ/rkPJXl80gFRRlTELTIq6VkQcf9/3HjlbD5iBvOiIlX5wj?=
 =?iso-8859-1?Q?n5Vc8tKpRikWuRpXxI9AwczQIEiAlYroE5zmAfSDrNG6do9/xuq1JcrnRm?=
 =?iso-8859-1?Q?T9u3iNfDKRaeUoacy6b4jOiWAk6q/hlqg0ADKenfCMY/ZBVraHsa+h89aH?=
 =?iso-8859-1?Q?UlkxTeCUpHL9qJ+IFY1dLEkKCoobXPjIOGwguTWjtdBzlV7pzHaLqUeH44?=
 =?iso-8859-1?Q?ypZAB9EhZIAokUJ3VQgOsVxbx500y0WFqxAAXTh/hvpiceYbsih+I9G2i7?=
 =?iso-8859-1?Q?u5Jus6LQOwLvaoEdGgMjss3okovxD7lHLGv2Dl+/4Z3ur1shQLxD0fEoQb?=
 =?iso-8859-1?Q?iG63oAvbobc1DzQi+zlddL4G2t/XqsAmj9N/I2pYFpz/PdoxBLaSlEyn69?=
 =?iso-8859-1?Q?6GPksCynIXLLv3xaEy751yXuphkgPa5fQdBHrBcrRLauhq4QvesrChmgzr?=
 =?iso-8859-1?Q?ukp6DJfrfPmhjagfbP/a4Qnkz/QebGcRImVU3NTfONO7FqlyuCND+GTRak?=
 =?iso-8859-1?Q?ur6lQ2o5NQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jm7pOOrlyIofzhIhKj0xjBuzTdkWQ3HuxpdG26RPsyPjO9sE+RA3JbWZj5bpinlbx46mGcRtyakDj865lu3tf3gyUyAPBNcWs3k1tBN59euhi+PfJ0SFiqYbZ3kltm1cwJHwSkh+0U4hry4kN5VZBW1F6NAFgis4fQtaQdqBaxCM3sBCjdh05/GC+DcTonpY7q7hwT9by9L24sBGNQ53CZf2yRWztqkVvjQfiNJ1IRFLn7RMWWX90pTQxwiDz2+90D321oXILkaCTIyKh2g1GskBRoMJLYhcs1TZaKfApVy/3r3qFhMYB3KCPImjwGL/Mn3tYQt2kApN9LyJ0+hE6A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ad692-923e-4b5a-de97-08ded8ce9f9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:45:08.5193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k12p5TZUKPQUA5byX1Lcbqv5nu7Cs3qsPKEiPRPbkgprryaqCaDQKp6QjByc2moRgVVS6x1MFDwxeahEb4kugB+T1jaXmAKXEfUMyaz5Xa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

The hardware strap settings in the AST2700 FC machine model were incorrect.=
=0A=
=0A=
Update HW_STRAP1 and HW_STRAP2 to match the values observed from the=0A=
real EVB dump. These values are also consistent with the current=0A=
aspeed_ast27x0_evb.c machine setup.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-fc.c | 6 ++++--=0A=
 1 file changed, 4 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 5eb6680da9..7d9fade68d 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -50,8 +50,10 @@ struct Ast2700FCState {=0A=
 =0A=
 #define AST2700FC_BMC_RAM_SIZE (2 * GiB)=0A=
 =0A=
-#define AST2700FC_HW_STRAP1 0x000000C0=0A=
-#define AST2700FC_HW_STRAP2 0x00000003=0A=
+/* SCU HW Strap1 */=0A=
+#define AST2700FC_HW_STRAP1 0x00000800=0A=
+/* SCUIO HW Strap1 */=0A=
+#define AST2700FC_HW_STRAP2 0x00000700=0A=
 #define AST2700FC_FMC_MODEL "w25q01jvq"=0A=
 #define AST2700FC_SPI_MODEL "w25q512jv"=0A=
 =0A=
-- =0A=
2.43.0=0A=

