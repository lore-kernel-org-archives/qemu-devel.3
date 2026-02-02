Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98072D172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHt-00062Q-2T; Mon, 02 Feb 2026 01:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHl-0005zQ-Tm; Mon, 02 Feb 2026 01:19:46 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHj-0003NC-OZ; Mon, 02 Feb 2026 01:19:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akreXtkUvfu94IM/GpPXoWU0ktGeYrhwBnDLZdsk4WIq9lpRgujFE1yOpOfEmQMLNWTdUT+kUy9oO1CouLMu3UrhpPrn/wzuRn/Ix6Ui+FMGo/rgPSGPewe7hgUFuSsZeu8VMLgugjls5kAWee6oiorfSxiIqaKOAy2IEekGLpHHzy0iJ4ee67J1SSds7dHY/aTuTzycIQaA6d9nN/Ppj2OnKWavX0ZsND14TZ7OHyXMpasVLsAwkVBcmd2FIIi+ROjm02weq9b4d45FJo0ecY3/B/VechNtzK+DeO8ZD50r0IeccwcPajNqHGACZe3ktSmtYGWUEB18OZIk8OSR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn06WMrHanP42yfTdwv9bduS51Vulyh+pWewlW5etfU=;
 b=Wn+2TAmKQazHDqkPQiqH1wNutDWR0Z4h/flOZnT3AWRklQWeuv+xX/jgPSAgyU+8sdHKUtlM/rof+uFIWmxPlFla74/ZbZU5hrqWhGhBxdNMcYycqqxL3WiCzBj2I6xlBwJlostAAw6oawUQAmMRZhIy1Hdphd/dYiFzmN7uZDA8bD1nwqy2zGSBtRTwqW6tDb6KdCxVtnA5tI+t4E4sz9o8l2kIHotV/YyLsjyfQ7e2eAKDwdKZOh/p6lSPJIpmMpVggHOI9ffZMGPi8a6jkGbg02SULpsZ8uziY+FsRMHJ8Z5Sryqn0/Z+XxfevEmIY/eDWCo0MZxX/Gl3rUUV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn06WMrHanP42yfTdwv9bduS51Vulyh+pWewlW5etfU=;
 b=eRnBW7GXG29c7wuVoj7+HSNzHZd4T1vULcC0O+sF3dmd+jByBY9cC9KCEKAjqxmJfBFtJ3d5hmqteO5+JmxKpGPfA0e/O6TJH77KEo8Q2p+bqKA3vTc6ZyYaMHTSJT74jXsg6oPsDhIaAtFm9sX9uvdPSBKhe5qobsNYFEFp8UKWDBHfUzS1Wno5YWrcbVcRxdL0PxEnOthn/oSQNTSpKOveyuYeiXHyWgQFtKBUq2sqlNpe71370ejkc9B/mMKEqtI4KQZE75EA2P7M4E2BJw8S10VG31G0rv1H6Z6OX5KaVrg/nZEcF2QYkQm2j5Sk0B3AhslHJcyXPf0/1Ol74g==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:29 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:29 +0000
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
Subject: [PATCH v1 7/8] tests/functional/aarch64/test_aspeed_ast2700fc: Update
 test ASPEED SDK v11.00 for A1
Thread-Topic: [PATCH v1 7/8] tests/functional/aarch64/test_aspeed_ast2700fc:
 Update test ASPEED SDK v11.00 for A1
Thread-Index: AQHclAvjMYA2NjAA5UOMCBZRemY++g==
Date: Mon, 2 Feb 2026 06:19:29 +0000
Message-ID: <SE3PR06MB81990C9702B0ECA69D27F394FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: 7c0ac662-5148-4f29-8349-08de622305eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?c8ijMGjRFZLUtDQpGIdgGeXbzZtJeRl4lsMqpbV7Pp4nFc0qjm+lH2b/+xNT?=
 =?us-ascii?Q?x/FezWstTA8/9QTrDtwbrxvLVdiB48aWwpa381lG6OTNoKmPjp1E0HyjU/Oq?=
 =?us-ascii?Q?CQ8XTLDawp2scrvkR7Q1bhWqW8QBQ/Kublo1z91O/0CTPQ4H3H+dmy49kTyT?=
 =?us-ascii?Q?1dpI9FyTmANgIMgY2JZ3vNvAdrun7e7inHVB/UkYvu8j2t+3a6OKeu1XkeJ4?=
 =?us-ascii?Q?RpIqRroAGxEMBQ7Zigfj9cbwnodYr3qqgcHZHFVVID74S4H5ZVnmLsfx/vxH?=
 =?us-ascii?Q?+pEJvVlir46VtihTDQ2cWfLnUC52tIN8kAgg033fa72Cpgbq8CgtHVykEmDk?=
 =?us-ascii?Q?/tGi7sWCcJ64LMnfBzion5IhZWMk/fMRpTEXBM1J7tylMhHGqxozecmyfCtK?=
 =?us-ascii?Q?IwiMYpJ1/3dBiHX+E4stwrclF7QyNwlG8LT77Ynhpeh5MexE9JbjXAE+8Mxl?=
 =?us-ascii?Q?5uprhNcpifwuDplBZAsJuLbriAFSaCtxapG6gTVGv60jzwa+Rlp3ksrIaU8l?=
 =?us-ascii?Q?Zfx/Djabj91nspRUfEdHKgjFKH40Coz9g7DLk2Yj2m974FGWatlTh0cYsE7D?=
 =?us-ascii?Q?hkme12Zxd53hreNHaDc6C7e/G7YfcUYvYalSyDLix+QGMsqGc0hFpM33Yiap?=
 =?us-ascii?Q?8CpIE2xaVAYvHqldL6sdnXgNIxQhIdjUW4SZFMpMRt2JtwsIQoQCR3jtbe0f?=
 =?us-ascii?Q?OG99gSjif/2/LEx3Q3XNKXsxJQleZ2HKu0vOOhz8oD5azEodB+d3m5462bXy?=
 =?us-ascii?Q?Emk18x9yB87kXGKWVe5D71KZri5I/K6/FzJzEqUjSEnMtLsz6qJiIoz3ZhVK?=
 =?us-ascii?Q?MyEOq4rTNSuKxlANz+0Pxdi+2y2mZsNQutvtlObBdOZokcDh/TFsFBmt0Apk?=
 =?us-ascii?Q?Os3LUqKLW5qnopeF5vOIubE8m9KgCENm/ha5tvNHhl+opH81YVQuNW3OusAB?=
 =?us-ascii?Q?lgxkSnLFL0lVI2+t1L48irlIBtEtb5NzRAZG6i/NBpYeD1IeU5/T+cAJRKji?=
 =?us-ascii?Q?beOmO8TiXw9/hH5DyzSowEsCPWQ/E5NYLCaguPdIZQhatRpjBl56Uve9uJrq?=
 =?us-ascii?Q?Er3kXUfZfePSYwQLDuPHykBRVqBG2lIc6nFdIcFmgVQrudktGLuI88S0Jdo8?=
 =?us-ascii?Q?dmaXozjr07/8hTnf37ngApA4bl+0/t2jGK5bzxzaGpdEdshTTU7ZNOs/H4rX?=
 =?us-ascii?Q?dFAnLiOAc0W4IjcAmsQMKsocuLNCQ40oRyE52VoxLdPaarlE3QnyZACsk8TM?=
 =?us-ascii?Q?HwA/XBNKbDGhZTGenf09szKrkI0NkUIMg6U+q7jTchRQGzySlHa8DWu3MfAN?=
 =?us-ascii?Q?xqwg2Gg70nWpKYSIDMRrKwAHWbI5UvIanevD17osBeaynDbxn0OxpA8OY3yW?=
 =?us-ascii?Q?pVL2XZ6UehsMFUMEZgaYwSvHtVH1M3IYaNjDO3Wp2e6xKdPztKWeoM/25/sJ?=
 =?us-ascii?Q?bGY9PweZx73Gdugk6kOPSG5qyyDZ7SzcALiOq0vE+j2Hq13ldmTtOM+TIHrG?=
 =?us-ascii?Q?U536zRHQCe9U+cS6vVuusDjP2Y7mf9ByNA1CQ5ui04qcbOMq9uVkR0Pms8de?=
 =?us-ascii?Q?uBwxkFiPE2wjc2dRtmnpLgfsn4Q6XN99Sk8kuet7IUsaHLpmen0O/iEM8AYs?=
 =?us-ascii?Q?5A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4NH5DVmY6hjo5e994aRW0oVKCJ3eyk5IWl5W8UyteeI/0og+Q9WHCGr7FT40?=
 =?us-ascii?Q?06KgfemDr+/AIbjU1z7pnblzf9hsKoj1Y/dLMFNCczF4x6cHkLgERafXD3LT?=
 =?us-ascii?Q?yyRDTEokrbzgfKzrgGn1VO1ymEa+z7zYz6jsP+ChYG4UoBaM9Zv5Q5EBWUyi?=
 =?us-ascii?Q?nR6Iq/AC8xnBl89P5g3nL2sR1ZdmnSSWwx6dSQioRGlvGp8ZwP6zdGrbgAzf?=
 =?us-ascii?Q?TMOhBDP/nIdpmZX3rsK4IZi+/DMisK49rd7QRsYwgbW5/pOoxMLi9jLFSZ8w?=
 =?us-ascii?Q?wml+fqoWScTa/6g/TXMIMgHN3aOvCatsoKP7zrnm7OF85Ozjf6g6mabTQG2l?=
 =?us-ascii?Q?WNycTVhvXWEQQvHcs9eRv7oT7c24ONGtNuPpxkKyT7p+vAyMIUWdIEueogp+?=
 =?us-ascii?Q?4UD7Tho6wR7AWKTjEnRFO9fs7h3HC/MoN0HOZ9ckrbQV3ao1UIWCQXmlaKa+?=
 =?us-ascii?Q?Wu/EZ+G4iruw3EATJkrK6Wwgkg0PazaVmRsbhywLoKUVu+kjBxbBsLPwl+dk?=
 =?us-ascii?Q?uzNLFDn0e66knvVAnei/wArD7mMLF5Zdnh0UjO83USEiD8MueQlBLgmYgf66?=
 =?us-ascii?Q?JQORxGY+8rqCizuY8oUpn7nxuBZABdts+dt17G5v1CUlvYqGhpYjeXuihQz+?=
 =?us-ascii?Q?xYguSYwQgvUzhs9hC8NWY7oGVoXZM6Q+f/WAGr3ZMKtAz9iK5k1tXXMO0Fnj?=
 =?us-ascii?Q?PRsduyi5ca/BEI/9pZmiY30m+y94y6PLZgrqsXUk7LGd4DUU3GVq4KV+fbDQ?=
 =?us-ascii?Q?IXL0HrucVLY546I8JMGkUBgPdfMhWRE90s4K4OWSh3x4fQMS9oBXAilTlLke?=
 =?us-ascii?Q?Nt+GXdGkMGKn272V/M/jfrzLxLKW4FdPd+dUM45KXt3hosZ18la5JBhDkjBS?=
 =?us-ascii?Q?pgean5fb+BP+FN27jDeeuBsFVXJTRNnjVLtnUdXeaAoa/wsWqJEN+R8k/LQZ?=
 =?us-ascii?Q?0HfPnZGzqLqxbxMZBQvJ0iFAN59z/nwKeXhBqYIc2y8MgeH3T3YyvPE++NdS?=
 =?us-ascii?Q?z79rTYChJL1bSIwU0Uwu/y8kxckwLDf3S82PFv16pFMeKkEa3GA7rkueJ/+z?=
 =?us-ascii?Q?S1r2W/zKPhZeH+lrIUOkW9RoIzIcnDSIzygZLZ6nBZWLHKUWQpbiF/ctdnvD?=
 =?us-ascii?Q?Q6A4pWtC9i0rdnnLvZh9PsrhPUqRIkQRkLunu3X/9IY/BIGPqnZOAxtOqvZu?=
 =?us-ascii?Q?SibYcBOFYoUzC1f1DgGJuCm+9G/9OXpVwQXNiO0SQTph4Mwj459ztBBK0aJ3?=
 =?us-ascii?Q?r+h3ynTbxQYMYaWlS1qwt/YN9/SBpjbhYQfzFaISqRHye3isrWz40uCwYoD+?=
 =?us-ascii?Q?Ov4Qu4nbx5NvhumOZa1oUWNpFVCRMNkheBL8Msgc7R6LQ4lWJVwHgNf+BQAF?=
 =?us-ascii?Q?BVdXF90I4yarboijrpezP2F3cC3c5Ky2WqnxZciNjrUoi8qLCrlRc1lpEwMf?=
 =?us-ascii?Q?dZ1WBMshgq7r0EpI1V/VNNuNtDZt4wKi/amZj8ZB4C6VZplupRBzpcSwvqcr?=
 =?us-ascii?Q?AEGcZiu+7nTdz1qodVObpMUjH335TT0xODuzBg3x5JK3d1ELrimKZocs5nCV?=
 =?us-ascii?Q?NIVQDlVY7YqINNnj6o7yCQow4tEvBSyBYmmgveS3NPBUotcnQ/ABDHmar31T?=
 =?us-ascii?Q?pAnpaLW2Vb0EEobpjpNj0wpFplHupuwdOtIecnbF8zq9AZuY4er8AX7NUWdo?=
 =?us-ascii?Q?jQGvqVfonNzSLTh+7VTIWDdvH93QuWgWIWWJGOSo0VIgU+MB3fLhIMK+zGDz?=
 =?us-ascii?Q?vGhdOex/SQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0ac662-5148-4f29-8349-08de622305eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:29.5308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEGlkj/4kxpP6hW34pN0Aogd+rsFMVIJyDZwiBE2z3a7Pa9b3DC5kjIZy6lWn12Uufoj58VMb+X0C60BfWOg2EhI8TmMMN48UuAhavikH34=
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
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 36 +++++++------------=0A=
 1 file changed, 13 insertions(+), 23 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index a1d8046f58..47e56dcfc5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -61,9 +61,9 @@ def load_ast2700fc_coprocessor(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
-    ASSET_SDK_V908_AST2700 =3D Asset(=0A=
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
09.08/ast2700-default-obmc.tar.gz',=0A=
-            'eac3dc409b7ea3cd4b03d4792d3cebd469792ad893cb51e1d15f0fc20bd1e=
2cd')=0A=
+    ASSET_SDK_V1100_AST2700 =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
+            'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
     def do_ast2700_i2c_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -113,19 +113,10 @@ def do_ast2700fc_tsp_test(self):=0A=
 =0A=
     def start_ast2700fc_test(self, name):=0A=
         ca35_core =3D 4=0A=
-        uboot_size =3D os.path.getsize(self.scratch_file(name,=0A=
-                                                       'u-boot-nodtb.bin')=
)=0A=
-        uboot_dtb_load_addr =3D hex(0x400000000 + uboot_size)=0A=
-=0A=
         load_images_list =3D [=0A=
             {=0A=
                 'addr': '0x400000000',=0A=
-                'file': self.scratch_file(name,=0A=
-                                          'u-boot-nodtb.bin')=0A=
-            },=0A=
-            {=0A=
-                'addr': str(uboot_dtb_load_addr),=0A=
-                'file': self.scratch_file(name, 'u-boot.dtb')=0A=
+                'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
@@ -133,8 +124,7 @@ def start_ast2700fc_test(self, name):=0A=
             },=0A=
             {=0A=
                 'addr': '0x430080000',=0A=
-                'file': self.scratch_file(name, 'optee',=0A=
-                                          'tee-raw.bin')=0A=
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')=0A=
             }=0A=
         ]=0A=
 =0A=
@@ -158,24 +148,24 @@ def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_v09_08(self):=0A=
+    def test_aarch64_ast2700fc_sdk_v11_00(self):=0A=
         self.set_machine('ast2700fc')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700)=0A=
-        self.start_ast2700fc_test('ast2700-default')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
+        self.start_ast2700fc_test('ast2700-a1')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test()=0A=
         self.do_ast2700_pcie_test()=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-    def test_aarch64_ast2700fc_sdk_vbootrom_v09_08(self):=0A=
+    def test_aarch64_ast2700fc_sdk_vbootrom_v11_00(self):=0A=
         self.set_machine('ast2700fc')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V908_AST2700)=0A=
-        self.start_ast2700fc_test_vbootrom('ast2700-default')=0A=
-        self.verify_openbmc_boot_and_login('ast2700-default')=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700)=0A=
+        self.start_ast2700fc_test_vbootrom('ast2700-a1')=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700fc_ssp_test()=0A=
         self.do_ast2700fc_tsp_test()=0A=
 =0A=
-- =0A=
2.43.0=0A=
=0A=

