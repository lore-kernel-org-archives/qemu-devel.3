Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC50EFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLa-0002PB-UB; Tue, 24 Feb 2026 01:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLN-0002HV-Es; Tue, 24 Feb 2026 01:56:29 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLL-0005Mp-4g; Tue, 24 Feb 2026 01:56:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnGu45NlCq57H959Q8cmXohyyhZwjk00KbVaw3jGuVx52UUvJRfaRZu7cCOIQMKjKtH+BC3vbzBwnnIust53zEZNoEg6dDfSXzvv9THladpz7WX4XyMp1MvE65e5taEXbEmNHUh07OSZlQTs2B2fIHyqlesW453SOIJOwfe0iEG1ytb75hE4Plkxnu7lvD1JpeAQPEYlv5vx5q0puYWw5SCCDkYDCdeNR162zKtxoci4eIJr057T5BSsRBQ7bKSJ+pk49JCk+L8MPkzdzIRTGuBdqL9ge/WC+ZsVrPjaAzlFS7SbmwkyLEWr0owQH5d8dMH0ATHO+7bLBWcTZ9MsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGTjLDrGUEamsuj6NyG4F+kZKyu2sNTKtUATGzn0C6Q=;
 b=Zem1Zd+mb7mGJ6/s8AlbLrH0Jke0fcOjsNs363t4T3/jwX0gyTEYl7cfTjPkAlfEZEcm/D8L7uIcidVpXBRrKjXmaY80c11XNEDFdHhDDOqFDegL2RvOyDvCnCVw1pI2QRpCU9Mg+/mogNcktAQn8OrmVosDjOntKxZyTxB4Oz0DFUO16HDTX4T+Ux1nVgbhKry9APF7rfKlxK313NOY3JUqY02J6dJeKRPaZG31TBnx+lLdoyMekjCCoAmssvJ3w3jDRBDQ/ausJNF4ppIHg5CxBmmBlzTHQVVci5z6YQtlymSMWNgie4u63KjTLCtCWGHeswvsKdTB3t5LgRSblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGTjLDrGUEamsuj6NyG4F+kZKyu2sNTKtUATGzn0C6Q=;
 b=NL2HrLaPNWoIArmTaqutRl/p0jtCSMmTd+fsePDM1J0golmycmYRMxxKUXEkJrDdaySW0Y2dXiuKoLVRd5D1AyCosjrX6CGixypsLWxERR4oUicraKzqGqa9/ztnPrVJ42UjMrXQcb/7HOj7U6Ek5lrm+xYWUp1YDjMOvMMR1kE/gccdgK9WfjEFApCFrS2xRVteBKz8ufPlYnCNkEHt5yGQKA3DD8ED4gE8+u0weSQTaI20teIcehxjb7LWA5lRwAvpXhG9VTKP28/YYVxfL91SlN2BPYO03kJM8GlH128Zf4zF7pSomTljG7vt2tnP6/hHq4/wH0a7QgESGIxbCw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 05/15] hw/misc/aspeed_scu: Implement SSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v3 05/15] hw/misc/aspeed_scu: Implement SSP reset and
 power-on control via SCU registers
Thread-Index: AQHcpVqkF6NtmSi/9kOSBx/V8YSe5w==
Date: Tue, 24 Feb 2026 06:56:04 +0000
Message-ID: <20260224065556.3847942-6-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: 24d46b21-ba6d-4127-dce5-08de7371c794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?n6v2v4PhlCJx7QnRWh29HUeB1qX4q7y7DRFCQ3wK5tAm/frmYhgcf+vLo4?=
 =?iso-8859-1?Q?DD5dk+XoAp0O2TM1tthCb09PYyWHIJ1y/EOxSAFNu2xljA+CiJXT4oE1vT?=
 =?iso-8859-1?Q?oyPtOzkyziO0aCn5KjzWCtg5HYoV716ZZBthH+RZsRlYi0BA8yHDuRDFzM?=
 =?iso-8859-1?Q?FgEitrKQ/vqAr1jC7nOrUHUyq3JvSZq00Wkz3KBiPNexz2FA/LTIN5wOfW?=
 =?iso-8859-1?Q?ppO8vzkmdcY9dLORUtTwI4KEdGyxGXZTeRdnaU2ia/YMh/obU5LHe5w5WO?=
 =?iso-8859-1?Q?HM+1o+WZHzfs8CKB87jN28TnII8vk3/nWkv1pGi/NmHLqNP7+TKuI0z3Wp?=
 =?iso-8859-1?Q?bYFfzIJlwuc8NXD37mWyPlT0XzSQz1WM4S/l5B6O1feTJSw+C+NoSXhXj7?=
 =?iso-8859-1?Q?O30s0ZKRy5X7fvYLYSJpTbiPywrpS0BdcPuL4afH8dv5jifHZKZjOWOkm0?=
 =?iso-8859-1?Q?pM9joEn9jhBAm/ZAg0wmGtL497SMcO8LRQGGunsA8VPRjjJnEeOa21P7xV?=
 =?iso-8859-1?Q?c+4H27cOAHUXewqy6U5Uh5GPwhaqVzSAbOibNRfISrVzSCug1YZnGhGFrs?=
 =?iso-8859-1?Q?dcsTknoeo+xzf7UZBwAXHmUPgyRk+XaBj/2zKYDWOHku11gtA/Tzs93xn6?=
 =?iso-8859-1?Q?UlYdHITKDe4yEj5SUQkS0F7bKq5iICcaa59qWfNhnbgZQOWqSOxAaSbQOz?=
 =?iso-8859-1?Q?eIWmokSwszPIQzfBZ4XmR2A60MXD0cndzvEvwlZsGtDLgwNP8iUfFXCD5j?=
 =?iso-8859-1?Q?4xaeI6apYNPrdsqt7kN8mAq8LCyrluInUT7TwRM3x7lShN3LRxhql7xOwX?=
 =?iso-8859-1?Q?cLoyvjMZPB0iKvcfE/xewYuOkfrKBasMyJiVds8aEbNVBB5rm1Zu8Gq7gK?=
 =?iso-8859-1?Q?CqbD82GmiZo/NzVw1ueyrQFKwOGZ8rw2dGSDLlKe1YVxhlcGYodZNNCxSs?=
 =?iso-8859-1?Q?uuCqOEqtUhBb/LVyKM7UXLiwlXTERsheHD5lFhSn4NJHT2wdtHQnxukhM2?=
 =?iso-8859-1?Q?623i+nbaMF6QADQU8NOH5XwapnbHRtpi0t7y9KospUQSt6kwd3nHbBy/1a?=
 =?iso-8859-1?Q?Nn7qu8A3GyEclvq2GmdswQJlp4LytdRvv6EZbzTHxhRIHM4o6CeJ2Bg/ia?=
 =?iso-8859-1?Q?dyAVhqgePoJz5Qob67lis2R6ihHCj+ZQQQooNZZlYOcmHvccuossV7gC/Y?=
 =?iso-8859-1?Q?D0u5DsCCo3BAFQrBePtjD987YBso5zOuNlk5KrMoVPCicn12sZ3YZYCdrV?=
 =?iso-8859-1?Q?WtelOiIZMwLcVoiYBv8RUaSMvG3Jvky9hmQpeE01KY78+z4fQDj22QaZ+m?=
 =?iso-8859-1?Q?D0uwEuSR7selX4Gjnas5DpJwb5l7PwbC6O6ucZCmPi39AAkv/tG6u8exkf?=
 =?iso-8859-1?Q?TURCd6rkocPOyt7XkV3b7uXYIyMg0dnzEKTISvfKLKc1CMoPPfvXITK97h?=
 =?iso-8859-1?Q?qEY/wo4siotAWjqQ/9w1SK79wZ29RGyVRpZCgbMtTGSxj0DyJT6T2e3gwH?=
 =?iso-8859-1?Q?r+WkYhErYnnEWPKqucKbtPJpV1FU99TvPztbp21KHY8cHLiGsrICkXSQrJ?=
 =?iso-8859-1?Q?78NrZHdKf4YENDBm/3+2CK4GNNbx3UB4Ihyu+lTqIQy50xGksY0ysYQ2U6?=
 =?iso-8859-1?Q?6x/ZhmZKavZl2jFjQNkiVabBWJouJFWb/d+ec6XGhIt5tH7Gs4MTt/5ynU?=
 =?iso-8859-1?Q?4IZELOBPz5r4x6LR/jIg2oKpZM/7aL9DlI5+za82?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ayz5X0RKaDBFe4yG955RmuHk8YcrsPsRpXeu1huXTUXtWL8vf1RY+89CSk?=
 =?iso-8859-1?Q?qIZV2yPdfP2Rpd7gugcnQLEmqfOFiM3zvO5GYTxl24FW18zRlkzAO19XC3?=
 =?iso-8859-1?Q?F3ocH/CCS/39qNJZSdRNJnNB66e6+XG4RsdS6NnsJLHz+w/1vIhvUz4/D1?=
 =?iso-8859-1?Q?bSejRiZlQU4y99+LtIc0twvOzGNoiYy0wvolIFJ9yaFLegv9l2Rml7FkHa?=
 =?iso-8859-1?Q?x6YTmywV6jYlXJwKZyuO0HejPG69e7qpzZJXjXgHHCdlbxyK/9McFHrrPT?=
 =?iso-8859-1?Q?qaZ1pL0aI3mNCkR/2UmyouAGQHBXFiSDu7TEFl9cff9+BLZbLU2DVIgXp+?=
 =?iso-8859-1?Q?69xDkqU6XBh++ayiiMcCGBy9z49FxtxP40D4beHN8Iu91QldakcM8Zp7BM?=
 =?iso-8859-1?Q?fgJdsK40ORIIOCGomLPgL6qOP9rjWaQSkSNJf59bA9QSy7Dh3dDVknMAIS?=
 =?iso-8859-1?Q?vaVxazDFUf4Q5wTKsAE2XBPMx47wWCVJLK98gKBLf/70XoVtUmDWh4dXUc?=
 =?iso-8859-1?Q?J6/iiDodhHlN/V14tU9r1GYfZjv4jUowFd//2sOWuuGbnb7Ehm4WEGsiZM?=
 =?iso-8859-1?Q?e7iO+ZlPYWmAdxak8Dl0u+6O1mBFVgRxNvutjAJobxfAMnbWfQMmcRBW+p?=
 =?iso-8859-1?Q?Sd3hXgapUOnXT9yjDuCujOqVqBOie11G+ucQMwx8n2ViXzHVg/OSh1pKqD?=
 =?iso-8859-1?Q?er7jQolKUaGWqCp4YD7kETjiEwBkXosOE/f9i3vKPwqrSWnq7m9brVKtga?=
 =?iso-8859-1?Q?nJqxEZdVtaVh2RsI/FvwP0dlEtlMxvAt2Bc5K4Zzzx2adnVS7hB+Xk13db?=
 =?iso-8859-1?Q?zoANyeGiG8C3+/Nl/7dqUcoP5WkGRGlYgH08XNUlzFYtQaHYWiE4kY7LDp?=
 =?iso-8859-1?Q?oQKq6ztZQv3IBLyDfQ9rVk3hWLG6Bw1A8qhlL4v8+m4mGK8cEUKfXA2E9Y?=
 =?iso-8859-1?Q?00bsJL2lZWdTEHk7CydcM7zcMDEV421/pOAP2fXpbr73gshpmR13qtKXGh?=
 =?iso-8859-1?Q?oksM74oGizcMIn1kHDhHEteE0XdcZKROUICwmJe7rpJxrCRX0vIxkc2Ef4?=
 =?iso-8859-1?Q?ezI+AjhXCuCSd0PaNqal+SiLyq+tGl7ifq+PYyKkKLS1PWSgh7WVwyyDEj?=
 =?iso-8859-1?Q?0I8S7h89kHThmoVh7PZZYHUqG1GM7PKTgJqVdByh9KwBF4SYRTmTmmUuBH?=
 =?iso-8859-1?Q?a9h1JL6nPe4LEyW/hwxi1F+0dQsfOlsIjdDdxeJQjAHyKQcQccQvxd2Qsw?=
 =?iso-8859-1?Q?VpeCJzkGJAp4mx5kKD0NoSv6B7DbFlf9leD7HKpTltJ7XIHBwdNJg7TIRf?=
 =?iso-8859-1?Q?sANNLuhjAuSOe1YBjgEWWWqT2yWizHk4QThO7uiyHq6NPIgjlTkWAR0+ny?=
 =?iso-8859-1?Q?sBieF5R+qp+f8ZlLN7Y3rtIAfb9snz/jrNADBgITqUlBgFYil0DPSyVJcW?=
 =?iso-8859-1?Q?PVeWxGERCfXU+ObIA7zImBC0CykUt/qLZnRJcYJxfCwkwlFa30IwQKpXo2?=
 =?iso-8859-1?Q?yiWfwj+5e9OS2F8Y1nH+WNvbZ7AJU6ijpTt/BJ7UFbPc7V+ds8rpSfqpKK?=
 =?iso-8859-1?Q?LKt75u/Xk5C0PU62CiB9YvE2W9wIEBP48wDL/thtwD81SZdk06rKxX6gr3?=
 =?iso-8859-1?Q?QQj4Ktyp5miT7qT8aLVMC7MxlxHcEdqQiOgp8XGHJVBYhJDxVUPhEgDJla?=
 =?iso-8859-1?Q?lE9xKgIBmy59M2/xoxAnZsj9xvphttspmFuT7JRvZFFLN3vwhL9MBWDpDk?=
 =?iso-8859-1?Q?0ccM41EQswcuvXkt98XzwjJDolR1uIKap8um2QiYDhNjyeJlYumbThoZGs?=
 =?iso-8859-1?Q?wpADinOWEQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d46b21-ba6d-4127-dce5-08de7371c794
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:04.3741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzLJocFwlCyCIIff2nuVZDSQe/gtNTo0Azqi6mzoeQKhnCl2tccvYX+FWx2ZTUFpxVZejQ3zExV5KJbtTBx8U0GfzdcKTKHDGHGR57Exemo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

This patch implements SSP reset and power control logic in the SCU for AST2=
700.=0A=
It introduces support for the following behavior:=0A=
=0A=
1. SSP Reset Trigger (via SCU 0x200):=0A=
   - SSP reset is triggered by writing 1 to bit 30 (RW1S) of SYS_RESET_CTRL=
_1.=0A=
=0A=
2. SSP Reset State and Source Hold (via SCU 0x120):=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the SSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding SSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the SSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
   - If RST_HOLD_RB is clear (0), SSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to SSP_C=
TRL_0 to release=0A=
     the hold and power on SSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x204):=0A=
   - The reset status can be cleared by writing 1 to bit 30 (RW1C) of SYS_R=
ST_CLR_1,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. SSP Power Control Logic:=0A=
   - `handle_ssp_tsp_on()` clears RST_SRC_RB and RST_RB (if not held), and =
invokes=0A=
     `arm_set_cpu_on_and_reset(cpuid)` to power on the SSP core (CPUID 4).=
=0A=
   - `handle_ssp_tsp_off()` sets RST_RB and RST_SRC_RB; if RST is active, a=
lso asserts=0A=
     RST_HOLD_RB and invokes `arm_set_cpu_off(cpuid)`.=0A=
=0A=
6. Register Initialization and Definitions:=0A=
   - Adds SCU register definitions for SSP_CTRL_0 (0x120), SYS_RST_CTRL_1 (=
0x200),=0A=
     and SYS_RST_CLR_1 (0x204).=0A=
   - Updates the reset values for these registers during SCU initialization=
.=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
This patch enables proper modeling of SSP lifecycle management across reset=
,=0A=
hold, and power-on states for the AST2700 SoC.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 107 +++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 107 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 9bfe132840..56f7e214b9 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -21,6 +21,7 @@=0A=
 #include "qemu/module.h"=0A=
 #include "trace.h"=0A=
 #include "qemu/units.h"=0A=
+#include "target/arm/arm-powerctl.h"=0A=
 =0A=
 #define TO_REG(offset) ((offset) >> 2)=0A=
 =0A=
@@ -144,6 +145,17 @@=0A=
 #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)=0A=
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)=0A=
 =0A=
+/* SSP TSP */=0A=
+#define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
+#define AST2700_SSP_TSP_RST             BIT(1)=0A=
+#define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
+#define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
+#define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
+#define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
+#define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+=0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
 #define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)=0A=
@@ -915,6 +927,35 @@ static void aspeed_2700_scu_dram_remap_alias_init(Aspe=
edSCUState *s,=0A=
     }=0A=
 }=0A=
 =0A=
+static void handle_2700_ssp_tsp_on(struct AspeedSCUState *s, int cpuid,=0A=
+                                   int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val &=3D ~AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (!(val & AST2700_SSP_TSP_RST_HOLD_RB)) {=0A=
+        val &=3D ~AST2700_SSP_TSP_RST_RB;=0A=
+        arm_set_cpu_on_and_reset(cpuid);=0A=
+    }=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
+static void handle_2700_ssp_tsp_off(struct AspeedSCUState *s, int cpuid,=
=0A=
+                                    int reg)=0A=
+{=0A=
+    uint32_t val =3D s->regs[reg];=0A=
+=0A=
+    val |=3D AST2700_SSP_TSP_RST_RB;=0A=
+    val |=3D AST2700_SSP_TSP_RST_SRC_RB;=0A=
+    if (val & AST2700_SSP_TSP_RST) {=0A=
+        val |=3D AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+    }=0A=
+    arm_set_cpu_off(cpuid);=0A=
+=0A=
+    s->regs[reg] =3D val;=0A=
+}=0A=
+=0A=
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,=0A=
                                         unsigned size)=0A=
 {=0A=
@@ -946,6 +987,9 @@ static void aspeed_ast2700_scu_write(void *opaque, hwad=
dr offset,=0A=
     int reg =3D TO_REG(offset);=0A=
     /* Truncate here so bitwise operations below behave as expected */=0A=
     uint32_t data =3D data64;=0A=
+    uint32_t active;=0A=
+    uint32_t oldval;=0A=
+    int cpuid;=0A=
 =0A=
     if (reg >=3D ASPEED_AST2700_SCU_NR_REGS) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -957,6 +1001,63 @@ static void aspeed_ast2700_scu_write(void *opaque, hw=
addr offset,=0A=
     trace_aspeed_ast2700_scu_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCU_SSP_CTRL_0:=0A=
+        cpuid =3D s->ssp_cpuid;=0A=
+        if (cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[reg];=0A=
+        data &=3D 0xff;=0A=
+        active =3D oldval ^ data;=0A=
+=0A=
+        /*=0A=
+         * If reset bit is being released (1 -> 0) and no other reset sour=
ce=0A=
+         * is active, clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_RST) && !(data & AST2700_SSP_TSP_RST=
)) {=0A=
+            s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+            if ((oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+                !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+            }=0A=
+        }=0A=
+=0A=
+        /*=0A=
+         * If ENABLE bit is newly set and reset state is ready,=0A=
+         * clear HOLD_RB and power on the corresponding CPU.=0A=
+         */=0A=
+        if ((active & AST2700_SSP_TSP_ENABLE) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_RB) &&=0A=
+            (oldval & AST2700_SSP_TSP_RST_HOLD_RB) &&=0A=
+            !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {=0A=
+                s->regs[reg] &=3D ~AST2700_SSP_TSP_RST_HOLD_RB;=0A=
+                handle_2700_ssp_tsp_on(s, cpuid, reg);=0A=
+        }=0A=
+=0A=
+        /* Auto-clear the ENABLE bit (one-shot behavior) */=0A=
+        data &=3D ~AST2700_SSP_TSP_ENABLE;=0A=
+        s->regs[reg] =3D (s->regs[reg] & ~0xff) | (data & 0xff);=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_1:=0A=
+        if (s->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        if (data & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_off(s, s->ssp_cpuid, AST2700_SCU_SSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_1:=0A=
+        if (s->ssp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_1];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_SSP) {=0A=
+            handle_2700_ssp_tsp_on(s, s->ssp_cpuid, AST2700_SCU_SSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -984,6 +1085,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700=
_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC1]        =3D 0x000000FF,=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
+    [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -1009,6 +1112,10 @@ static void aspeed_ast2700_scu_reset(DeviceState *de=
v)=0A=
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);=0A=
     s->regs[AST2700_SILICON_REV] =3D s->silicon_rev;=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
+=0A=
+    if (s->ssp_cpuid > 0) {=0A=
+        arm_set_cpu_off(s->ssp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
-- =0A=
2.43.0=0A=

