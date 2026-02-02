Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E48D172CE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHj-0005yN-7q; Mon, 02 Feb 2026 01:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHg-0005wf-Fw; Mon, 02 Feb 2026 01:19:40 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHe-0003N7-Vn; Mon, 02 Feb 2026 01:19:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDg13I89K1UFM7x43ihPHGk95lLDWPWPLOzjLoqcLaDVJ9ScbFZSjoPkYkU4lqPbNqdBohTOuDXM/Dfw8qUwbCUEgsAivJIkr2zKtWHDjU6TROepGnMVTxEO2m/ik3UDjz2V82Smn9U7MZ+qtGU0zsnlhf7/OWBxpOmTvUGIZUdro/7GONB1nNhs7ak0UOfRlupQBwbHrGXb51AX9kMCeFeVi4JPbYSuSmFrNz3Froj9G30R3GHusF/CbdrwsGCIhWl3qyNoVM4I//KZ8PZlm+D4BkbrZMzHgMr/590OG0f4Ky/U6Feu3fPVh20yXXQG40znDYrY7wnpunb+0UDr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMuE1ew+9lvWsuLvgP9ujlL+8ZAok+NQ4YRrTk6SKkA=;
 b=QIK0iifJ05f0bJ5snDrUXOtF7ZhiQ3rHHEDLknDVU5MggZxFiPsiHC4YK41vba22wUDAAqb+S3h/xaYYejb850mTVt5rTw45899Wj6bVS3iVUNbicmJ14TYuiXVTEb3PI+Hkh+OIXOJSy13h6OkQLikNmyepIm6f3FvyyueeHXDnokHspaDSFqz5JWP9kLBzVgk/jBbjFAtVxPMPqaAvjVo1O/HC+hItPZQ/5gewu6K8JqkCKyUuuMBCaQ77N0hWBe9+NZbd47NR6tF8j0apkmh78TNwkJStjwlgXxwdcvFKWU2h/85anglsNvn8p9BaHlFK2TlACMv4uZCPiN4vUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMuE1ew+9lvWsuLvgP9ujlL+8ZAok+NQ4YRrTk6SKkA=;
 b=c6xdCIzzpnD7me3BQjQKvD4Fbg2/kQ9vldwfB3hBnT29WGE85cDXqYmzum0I1z5hcCZlBR88QVLc0g0kbsfmjlNP+pyvyUGukNnv39OoiNm1vlb939T9O+/nIEVnuVTkgYhCDZ25GVYhusNn9SDmvfHukUysYd8rCMalTzxsVimhTyG1PQDwZYsG0o5nl8GshZTSopaAKX0GNqnG6EaGWTtpeJBeZ66TbTNkAgRMSgygPVLBu3PMd8ghf0lY4yswa6fgOr1mWgfIIc79cnyb93MWmKQJRPfwk9gis/1PQPf00kKmE0TIq+5qnQcTXuGVa9CbpTqBsE7nEGA8HXNf0w==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:28 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 3/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
Thread-Topic: [PATCH v1 3/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
Thread-Index: AQHclAvg8k5KSOVzQU2YNpnzlXTD1w==
Date: Mon, 2 Feb 2026 06:19:24 +0000
Message-ID: <SE3PR06MB819906A48EA635CEB8DAAE7BFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: ce40233e-17e4-42c8-8867-08de62230546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VO+IxU7SlleIICnaPJTTfHX1NrswMNm6GwQIdThVu+73SPSHxuR6gqfCGY3m?=
 =?us-ascii?Q?/JNNQeFPJYeyp2w00cOZENV4dIvxdH0dQHHcQ0BxzzXyGC39tNKxO9/jqaZA?=
 =?us-ascii?Q?EsBxfUi37NHUtHI1Rk3lg8+Y7kNupGEApqQOThaORv6KdINvu5pH+5nxF8kv?=
 =?us-ascii?Q?OnQN5EnBOGnUN4/nrWLj+joK0Am54RsHQx5GXX+PScso/+hucwyLVdiS90QF?=
 =?us-ascii?Q?9wGAVXaVutd8pQQST497YsfbkVb0YfUVbYE/n0/o+m6E0jx3e4cBqBzaRDvU?=
 =?us-ascii?Q?fBajN4T2+dkJ/U6WnQyJ8etC3R+bmRcD61ea9HywUZTlaLiRwkz60l7Fu17Y?=
 =?us-ascii?Q?evgcX3RxLwg6FP8ADcsW0YbzGZmTEt8YGbM5AFdabI+3LLZkWEwocvhYv7TU?=
 =?us-ascii?Q?QgdZAsNWIZAdvL+pqzjjMBO5ZQcUYvsvCR1vrzaBFSeWa9k1BBUJMZPGZhM7?=
 =?us-ascii?Q?AK/vAJUgrcYAQv2zmuQqNkdYM0lvQzbRTBpWSpqZWmHOgaQUhoemetK1uQ0Y?=
 =?us-ascii?Q?ndP89079i/TIpgMazd85T7pDdh+jG1ETp61aYtHdEj/oiYdccXAl3PnN2Q92?=
 =?us-ascii?Q?CKFDD/a491tU7nKaHzBiYWHJ4mQwnkhGUr8AP014VzyFM0pW1YaF6ARnvqFl?=
 =?us-ascii?Q?ZoHPQ72hjPrZXzgH7ScBgfDldcUesLvqS0y70uiQ5c9MQJROVRS4DbLTXOCJ?=
 =?us-ascii?Q?/gqqZH2LWeOj7ie881FoMbGedRQ3aOVQd5eYbNjfkN3TS6RndGJmK10XIM0S?=
 =?us-ascii?Q?4PXEITZ8/ZvJHb8r8UR1Eo6Gp1zDSms8uw6G8dZE21P91Q8xY91dB0we4Ejz?=
 =?us-ascii?Q?RUON2SiHsToA/WmuS4g8+1eKczUAl1L2HMc7LgxcFprCc91/zoJhs1J25QPS?=
 =?us-ascii?Q?+9Jc3bhylgtUjsxRhOEgeg84KkoAwa0pO2DsJu/rkZ5Jm1EaNAzoejvSqk0W?=
 =?us-ascii?Q?nu+tXpsWgklcgkvVAl+Gs4hmx+9TBmvw1FA/ZCYjzYQ8/xaNATan7MV1+V8W?=
 =?us-ascii?Q?E44tE1dy47o4F3/+LdQZBcUA1u13MSVuHbwc/qpTd+Ss5cKpK2rEPPLJA/KM?=
 =?us-ascii?Q?FJaZNaOe7MQFEvoUEjbi3g6patQvhQFhwa6IfP7tBHWvFAWQhRthelkSHFwN?=
 =?us-ascii?Q?sKm+0EfPVfJpPbhWwJ/QL+Vmotqy1+vuqwwHRIeEXj72clvcWoDi+XtXwvwl?=
 =?us-ascii?Q?MUCiwLmcGeIEPqa0wE0Qgo93Ncg4IDr0JhXZZeiVCXuK46XDXyw8HYEdm3DM?=
 =?us-ascii?Q?L9eV0uyieIRsbH91GckOQAoS6iBHzhwJs7qnlkbk7bNXm9Z0245U5vaWqwkS?=
 =?us-ascii?Q?eU7YuRwQsgO1Ez5Ey/nOPsOHaTHFpkS39r888vR/wCTsiMPH8EeSLsGCKWii?=
 =?us-ascii?Q?mKbnWDQQ/nchIGLaP1tgMC7BM0xyGu8WTbKIyWhChiRJnFMmWAT0j1jibZXS?=
 =?us-ascii?Q?VxoIOdy6wi+hAxAzSR8KXE5wh+63ZPdEAMlg+Gr/TtbLe3tLbouQXapculKJ?=
 =?us-ascii?Q?9EDZLL6o36+t0DL8PQ0O432jPqhyfUsoXuO0/yiAm8iOyoQoxGsR3m5bpQ5O?=
 =?us-ascii?Q?fNX1qvBoDxfcW0wqhz4+49FrMfEYOdChlqfvOgHQQsmihwrR2PTxua0yX/Xs?=
 =?us-ascii?Q?Ld6LL6GZ1Ne9N/GZHcdJuErechVsDVCMIM/13B9pAzOk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JfobSKZWyGQlOUVPBJmA3+/xyFdRBmY1Qz9a7nJI+0fYr9vTodJcsdXrM4R+?=
 =?us-ascii?Q?fgArC2ZnaJxmR1zV8UJaB77yeD/KuemSiQkd7ajeQdOzVQPC61NDA7W1ylfh?=
 =?us-ascii?Q?+cn6yGpDqnhwZ34HmiDo8OvuAtijr7QJ6zqCS46lvVeCicHYCGYCjmMFL35f?=
 =?us-ascii?Q?LC9LkvaUWseuiVYBpRk4wjdevrDt94j5N4UZsA1OBQT4nsvehWLom/bN/tfO?=
 =?us-ascii?Q?4Pg4ALw7LTizy6seg/OgnkWrZXsPkEsCkWaA5yCtHQWrxuOoeeYNrB5Lp2Hh?=
 =?us-ascii?Q?CHB9T42gUL3mQBefm2qg2NGHTFRowA509A/KnK5sA9ItHzBkOBg5s3vOzfxg?=
 =?us-ascii?Q?mxhgrhUsLWAqsSoY7j3lD6UFTV9SUduIpq4Vtq892hOSq0qGGOCcUnbmy6FQ?=
 =?us-ascii?Q?PiTgzYYqD5jeckPBf7Bc/04T8dJft27ydWxie9MhXQZ2V5WOIQx3+Dw4ENxU?=
 =?us-ascii?Q?ST6gLPh5SrA0WXJk5H50FXZegnDA+eo5ydu2Zuy7v794+M/RMVief6APcQNj?=
 =?us-ascii?Q?yzBr640WRnVdjLB1dZ0gsoXRWFOlEIlXLb14KWmq0VccmQoKRJWNVIucc24j?=
 =?us-ascii?Q?om/AM6ucWSKhG2LzS/OSRXLMadoxNDY3gN3fu+C4fZZjKeKav/ymQ/X7+6VR?=
 =?us-ascii?Q?eI4gPgWRBFAYAwGbMKI0Xyn5BF7ScskGTtbhdWNQ3oL5lf7EJGAb+vVKwEqU?=
 =?us-ascii?Q?67SdFnhqzywbyCsuPev4zRNWILG+9y7zSle/8/96ncx1Jeo0L7IhFxLG/MKr?=
 =?us-ascii?Q?smzAmiIypsAtIl4ZUZtW0aq8bZ1Ft+mFGRRUpZlsUrgM1HAyPel1d9bFQXyN?=
 =?us-ascii?Q?kPi8zz+tQSnRPlu9b/YfczcJ5vaiSx042M36wMDOCKWqTgoWRhGxjkrZ4tZ7?=
 =?us-ascii?Q?w31nPTbtcwQ8FrSQmZXgWjduWRNg//tx1Gs9vW4Jup0pW95yn5A2FUYg5Y3M?=
 =?us-ascii?Q?VXFs5uYPSz6UntG88iVqckEBdiyvTIhwDI34fCBi6/cYDZoi0M/rXDE8xMJt?=
 =?us-ascii?Q?++b+NVLbRP0z1Z2WaAbSC38x8IfbOh7IeemSDj84s+fMjOM2jMZTGBB0MH5I?=
 =?us-ascii?Q?hwpqWdusxVFkEWso+cdHPOKlJZP2AKkdMdzqv4taNX2MqFLyHz04Nz8g07zz?=
 =?us-ascii?Q?7GHH2UX2V9RhxWC+OCEqLo0YEi8ntnhWhFzrpVEmEoagqaIcNUic0eH4Qd5V?=
 =?us-ascii?Q?H9CYlzXd+++VjuCW+Md4XufOT83JGbTAfFsuALxCk9J8YDlrBD7IdYEft7Uv?=
 =?us-ascii?Q?uuaI2ppvqHDWvmJNaVu/fUD+t1vhTlAfgpXw5WZLfXEVF3B8eXqwIRK+8zhB?=
 =?us-ascii?Q?rIBKloVvjJYMsouVTQspkuP1Rqm/jB6ZswgOpXjzPT6a77NbEfS2Ni18z+Sc?=
 =?us-ascii?Q?uM4FvXZ0Gxfvqvjk0eOiFH5yz5AzUv/dwpy67D0iGwdxtfULvFK0QDsFu4t2?=
 =?us-ascii?Q?qt0mnzwpc3+V7QcX5diPdhUs/pajnwGw9kujVuMjeGv9uSsgBKokyzl+1RWO?=
 =?us-ascii?Q?a4TPUCyfAmx7WagbH3SxpZ68o4m2mHxBbRcjl4p2Dy1q8xsiSMwAq5U3Ay39?=
 =?us-ascii?Q?0596RZxdxmnAIPq/X/ulujl8CqPT4ep2p6xNewUi+nmDw9mBx4DOafyUbUw7?=
 =?us-ascii?Q?EVAw8T0rIF+hGORUEHDQSguAQw2o4hR8R2aOdbLCyX3yLg0SycEhpIEopcV7?=
 =?us-ascii?Q?WlQRVQJpLmeb2zLwPKIlO1/iU1tGMzH2FjtkUcvuIKD7TgkDTe3Z2dNYCuba?=
 =?us-ascii?Q?8vZVt90DdQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce40233e-17e4-42c8-8867-08de62230546
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:25.0043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOm5m4Q1r4oDM/NNz1YpfmIeofuZC0den1fjUcFRSmA+wDqcqcp53Fm95u5FAyIJP9f0PoWYJVvBNEansYSU0mcsdcjFxFpWjDrgmVDejv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
Sort the SSP and TSP IRQ map tables to improve readability and make the=0A=
definitions easier to maintain.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 4 ++--=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 4 ++--=0A=
 2 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index e4bcf0fa2a..9b12ba6743 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D =
{=0A=
 };=0A=
 =0A=
 static const int aspeed_soc_ast27x0ssp_irqmap[] =3D {=0A=
+    [ASPEED_DEV_UART4]     =3D 8,=0A=
     [ASPEED_DEV_SCU]       =3D 12,=0A=
+    [ASPEED_DEV_TIMER1]    =3D 16,=0A=
     [ASPEED_DEV_UART0]     =3D 164,=0A=
     [ASPEED_DEV_UART1]     =3D 164,=0A=
     [ASPEED_DEV_UART2]     =3D 164,=0A=
     [ASPEED_DEV_UART3]     =3D 164,=0A=
-    [ASPEED_DEV_UART4]     =3D 8,=0A=
     [ASPEED_DEV_UART5]     =3D 164,=0A=
     [ASPEED_DEV_UART6]     =3D 164,=0A=
     [ASPEED_DEV_UART7]     =3D 164,=0A=
@@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] =3D {=0A=
     [ASPEED_DEV_UART10]    =3D 164,=0A=
     [ASPEED_DEV_UART11]    =3D 164,=0A=
     [ASPEED_DEV_UART12]    =3D 164,=0A=
-    [ASPEED_DEV_TIMER1]    =3D 16,=0A=
 };=0A=
 =0A=
 /* SSPINT 164 */=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 68683a15d8..e39d1dc171 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D =
{=0A=
 };=0A=
 =0A=
 static const int aspeed_soc_ast27x0tsp_irqmap[] =3D {=0A=
+    [ASPEED_DEV_UART4]     =3D 8,=0A=
     [ASPEED_DEV_SCU]       =3D 12,=0A=
+    [ASPEED_DEV_TIMER1]    =3D 16,=0A=
     [ASPEED_DEV_UART0]     =3D 164,=0A=
     [ASPEED_DEV_UART1]     =3D 164,=0A=
     [ASPEED_DEV_UART2]     =3D 164,=0A=
     [ASPEED_DEV_UART3]     =3D 164,=0A=
-    [ASPEED_DEV_UART4]     =3D 8,=0A=
     [ASPEED_DEV_UART5]     =3D 164,=0A=
     [ASPEED_DEV_UART6]     =3D 164,=0A=
     [ASPEED_DEV_UART7]     =3D 164,=0A=
@@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0tsp_irqmap[] =3D {=0A=
     [ASPEED_DEV_UART10]    =3D 164,=0A=
     [ASPEED_DEV_UART11]    =3D 164,=0A=
     [ASPEED_DEV_UART12]    =3D 164,=0A=
-    [ASPEED_DEV_TIMER1]    =3D 16,=0A=
 };=0A=
 =0A=
 /* TSPINT 164 */=0A=
-- =0A=
2.43.0=0A=
=0A=

