Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD14CE83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY93-0002Zb-KM; Wed, 04 Feb 2026 03:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY91-0002Xa-9q; Wed, 04 Feb 2026 03:21:51 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8z-0003cB-Fi; Wed, 04 Feb 2026 03:21:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOkW5P9aPYSijhiKCA9BWOrJPk7MSPSOzuNBmeOUuJnUlDGYVxndAvMBxutaW66es/bxCXOR8MUhAtozs79Jq8uBQgHrebl5GelxBk0DC8G6UQtltdGWc8Ps0GSyI0pG8VgUNfSqGUHeQ2SIFl+4mhq4rPE7A5WfmKEn3dxxQOl1QEeIU+GQEnnOvF6th0AqCfIqG4uudWqMujA+zfbUGNyIwG5/7GjvJvJ1humM9H6Z4QE7hax58h+B6/k/ue+wm3IfIThVVCCiod+RujG5ALsGjs/26nM1bAhc1TwtTny3LtxGuMhRS6Xk597QhYye4qNA34eEqqRdqzxaKVMRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIuwCK1HXHZx95Mi1wIQN3VIKpB5MlSRl9HQFO6wVyo=;
 b=I4zjQNSg+XxoOfkTfTIiAr3xplTrjaCVsBuoZvQniJMvXR1J/yNGWDXutUbup8et/H1EkloPMYaLZDj9O/vfJSsfe+LXJ67wiBCb7ZgvgiCFUdAEbUSG8SFlb0MT7bi38jrBcyE+0ESMpL9Uft0W9MTTTPxCXKi6OGp9uUiQh2aIkR36SKqGHiiJui1OODVHz+bK95UoniHqO2opK5rCw4ac6lAXIIaJYAAv8judEhmAk6fCqibnayWdGU4l2lIhhRwOqnkdVe68sYXN9MQfr9cPu0VF4lsyIrbIl3rJLU7kBSPpUQxJi6lMFWTYpib0cEgyhxBW93IGWBfxafZjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIuwCK1HXHZx95Mi1wIQN3VIKpB5MlSRl9HQFO6wVyo=;
 b=LgD89bnBKPQScvb0rG3Os3DJzmYv+8R7TqH6fkUBq9XbPOCJFukAzw9N3z92w7OLszVHxzKV6XV4V9jyNqMUk1GYG65AKDAC6XMhYz5itx54C5791a2z2vA5JsRCp8i37iSi0YCc6Om+tTEE9G2ZDjqNr4SsuubZoV2yYD1Ii8m9IARMKbuzgdAWVHJQFlXDekUX9tz5fvE1jrBmrNpDfaC2EFsCTROscxvc6jSd3814MGM9aa4qgtXdQO0HabTlel53OE7g+Ff1YDHQAkgHkC1XF9mjYrQZCkdTyekslA/wNiKLPXo7P0jrVS7s7crf7ZmKK4+QiAxJTopH0TlpqQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:44 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:44 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 21/22] tests/functional/aarch64: Parameterize PCIe2
 initialization in AST2700
Thread-Topic: [PATCH v7 21/22] tests/functional/aarch64: Parameterize PCIe2
 initialization in AST2700
Thread-Index: AQHcla9Mw3W0OKMSlU6znAVB9De8tg==
Date: Wed, 4 Feb 2026 08:21:44 +0000
Message-ID: <20260204082113.3955407-22-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB6055:EE_
x-ms-office365-filtering-correlation-id: 2de494cb-c381-4516-a32d-08de63c66ee1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hVO8PgwbZwb4wGLaT6+0eeGzhp/YZpsW6gtyWtKoi592lD/kYzRyCDxDAF?=
 =?iso-8859-1?Q?2JxXRvGreJvWh/t5BQia9LvRcRiUj2ptIFNYPtcZSrVbdaP6twEAZkganH?=
 =?iso-8859-1?Q?uuqeih+OQ4YjrV7jdYw8ONwT2wKMsJzzUfIEk7Sc9x3ThCXt4NtiPqcKII?=
 =?iso-8859-1?Q?xqH+ONx4ZdstS+rOCnyQclJnQzgeK2YKqLx6CF6nvxgMJ30tcN5AYgCC9c?=
 =?iso-8859-1?Q?X0Uef7Dn6oQoFk3HVVaCJU9ibX0GlSjHjj1TkmsMB4cY4uTZkRrqYfrEoL?=
 =?iso-8859-1?Q?OniNx+c9jP7uPtJM9IBZfnFwT+s2bePSEISDfZfFGuuROzgSmLYGI5tZ7c?=
 =?iso-8859-1?Q?WKo3ZLE3+cWo1lRcz7hbN5D6ft2WdHy2HwEgO+e/fxJewy/J1xbMNJxdN3?=
 =?iso-8859-1?Q?GUxWbh0HcKj3RVd0XxeQLM43WxIJbvElPgDZYV4y6yBsTmVxnrWPpW2SjA?=
 =?iso-8859-1?Q?wBYfMovK9vTMwmbnHtVb68CF9s8VBWHIpjpPE3BKc3uduw43QC/cDPFLXr?=
 =?iso-8859-1?Q?taNiSLnJuMqbSEStIIy5kO6sbEURrWzOEj1xCh0wr1tBNnKYj/I+F2xwXS?=
 =?iso-8859-1?Q?zLri0mZTQ+Jd5A/IKYtsX6+ft66iD7wlsaUXOFlK1PwIcNl/oW+tByUEbk?=
 =?iso-8859-1?Q?6gFvY6zIWFhIwHqgh/our3iLu/XzlFvzmnkhF6WANZ35lAu2Tie5Ql2Fai?=
 =?iso-8859-1?Q?VlziXMtvxgOTLZf+u0DEt0uVfJD4xlVVmuY5/BqWcVrnCK9HH1KFmowd1n?=
 =?iso-8859-1?Q?s1OesuM+yQr5P9s572bqE/o7WHyZ2RRiVZKRPTfqIn2vJANqIEljuiAIyR?=
 =?iso-8859-1?Q?mJK30aAUnYYdeZ+XaWHxTnH3MyHqVy94s4PN5ik8pkgaB3hqzXYmb0kTJP?=
 =?iso-8859-1?Q?kY6YdU49WQ5KDiXglKhNzxStcW3sDmyMt92WmRq3TFSuDlPaSLswzCurst?=
 =?iso-8859-1?Q?koDEnwatpm5l2OfV3YWrTkMdq8mc3hhPgVgJOr+/9Pe4Z8kAXJzx6BtL0e?=
 =?iso-8859-1?Q?rFoKNSqHl6isGs2efODqcf+ObpDXXVNG1IbLxtzpr94xMcP+y624i8Mo/w?=
 =?iso-8859-1?Q?2SU6X1Q7WZ2EHD38mvB4uobWwNvIqr3pM4U8tpa3lb0aI7cBWiFbukmkbl?=
 =?iso-8859-1?Q?j0wiLsI/zhTTokj50Hb7BNSLtG3PG81ONPTn0ME9aI+ugI30bwDU56Jl1v?=
 =?iso-8859-1?Q?3T3lGNW77UaAjmsSuG0xY4DPp1gY4UO3K/NdIeGtklij1sCNzkb6gvE4iy?=
 =?iso-8859-1?Q?k+yr4BPLYksc0XQaLRcS6K/NeOEYcRuahyZQx14oI+8F+y7ya7orptAFQh?=
 =?iso-8859-1?Q?jQISD6AWOGUwxu+aY7H3GaX0NTsb8zv75sGtTGBiKb/2zJGTWg6P2DxpA9?=
 =?iso-8859-1?Q?l7impGVH2/OKECQw6ILeVYerO54Go2SWsE0wKIBSXGMoDfP26Au3NYFGfK?=
 =?iso-8859-1?Q?BjVdaNF/ZTJ+K2zJ2GClvzGEkLPTPyjQBShJK47t/ZN5f+jPXI7dwcDG/y?=
 =?iso-8859-1?Q?qvMuZqirBIENg6hb+hRerLbyzcTkjB1bcGdKgfOvg5GNGz2VbLX8cqC3AL?=
 =?iso-8859-1?Q?rpvhDefFQQEmd07HPFLbZ0r56zj0fOEeieqAMlyTz6DP+xMAcZfB+LV3ro?=
 =?iso-8859-1?Q?JJV8o4oaj/KWKxz5zp4MfKRM+VOb/i9/mwAUlCXKRUYUITHnd9nE55zpOU?=
 =?iso-8859-1?Q?1l5s32ZLtiKWNe7+fvo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?my83d+tILA04kL6NgLT9P2Cc9lzu6wwB6Ht3tZpqybpJ9XQFjzBlnTpaJ1?=
 =?iso-8859-1?Q?h0JdduHEK+w2R7OaEo6UYjAV0NP3B6DZhI0YQ7cxQHrisjtKHpidEv50tt?=
 =?iso-8859-1?Q?oC3qEVpy5wB0fIEgWBds7ugpykQFNm0IT1I8X8d75dq3Vf0sxPCXsBFyDY?=
 =?iso-8859-1?Q?bukkmaOC4kqG8fqc/udTf7FxTmY8uT5za/6BamyFvKoqLlRX1Yaju7i2ZB?=
 =?iso-8859-1?Q?GtRkk0zr8UYcQy56ntjmZf6m+IGxVce7yosZb7ZKlgH6FFJqYaBJU8zinB?=
 =?iso-8859-1?Q?chPlEdXDzVGN1p9Uw49vQeBB8wy0cg0p7KKPSbMgcUgZ5P8V+Ft5vbDMzO?=
 =?iso-8859-1?Q?UNGJQ2wTm62453aPQU+lVU8sz1rIMUMSmStRFGMLOqjrvQCglDc98F/w69?=
 =?iso-8859-1?Q?7kNE0rWbR/6lNe0BoLCUMXtNexq4gTYmiB6y6ACcRenfcUdZB2db/AS7D1?=
 =?iso-8859-1?Q?OIWMEI0GAs0CRIGi7Rz68w4HEpwP+/rED45HsdO/FzrOasREynJ9iXyZNT?=
 =?iso-8859-1?Q?x8DCfbzIe18g+cdbfv+6+GJRf0B+3yghT0PQ/W3C+R1afcR029Fjk/KiXH?=
 =?iso-8859-1?Q?/OmXQj7jd7jCBUJH6jHTK2cVQfygI9z/1BK3yIRPnMk5Rj6u2sr9rG7t8T?=
 =?iso-8859-1?Q?/MfkTnotlgHyB0gBKpc8vJbNUJ3v+lgvCTydJglUumXv+WdcUr9mA+LmEj?=
 =?iso-8859-1?Q?bp3f3KXTO1CzuVVHj6KQPbB4Ib7ff7n6nKG6obzbIIy19MwybkItkhVuCS?=
 =?iso-8859-1?Q?fB449chHwOt1tDOXydShxQiceiKhbK1aV1TdDkcrILyX5KdnHkRPgvAO/9?=
 =?iso-8859-1?Q?5ZQvbnpGBQc2oOfnsXBz36qeeuM13UiQdguAH5E3M3RL3TQJ5g+ie2H113?=
 =?iso-8859-1?Q?Rl+UbZxhGlXGH07RoqlRWANF9o5DmLsjck8weKUA7JgGZvCVP+pJkLlOu0?=
 =?iso-8859-1?Q?vIX5KV8aldDgZd8NCr66dNed1l6JV+iY97qYYHOgMxcPApfOrV6vzUMxy5?=
 =?iso-8859-1?Q?O7S1MTfDt2TiAQrgITd90dVOP/xSHBVTBPfc9E338WiJryICfRgW7ibMU7?=
 =?iso-8859-1?Q?dCS2jAaaPw57382ofvEmL1+5DGh3M8VneR/n5rc/4XQXTjl8m8nhXuYvwJ?=
 =?iso-8859-1?Q?DHMMoVASVtSIqHjV5rBraVm2d/leKNknKGx2RBQr8R1Gdg4AxD1u+4Dp9g?=
 =?iso-8859-1?Q?/ScTR2j6oPui2B+3DtS5qglGscPduCMILHaa68ELwwu8NeGnPJMmnBeM39?=
 =?iso-8859-1?Q?Fn/cBijZv+sr6J33BEk8B8bbj/a3pdb4HsxJR4Zgdj38YTL5a7zfNTSu7Q?=
 =?iso-8859-1?Q?02HTpYYX/xhAMF0gD2pyUhfatuWN0CfOFM8lraaFoGOGOiOgfSZQ3g68ae?=
 =?iso-8859-1?Q?ySwsZUSICyiV54JHdxpFtbM/tFAjpAhB1Zkc8cdV1l+B6tRBPsvb6o8lU6?=
 =?iso-8859-1?Q?Y4Snp6dQ9EvGTaBnkUpgssgZelRnhTMAn1Ef/GniyiHSkQmLbgLf8UmDGO?=
 =?iso-8859-1?Q?0b7Gd3ArYxCx+yDN78mUeC+XQRIiyQ0+vy1BSkKxY6Vq4J+B5V8uYLAk3Z?=
 =?iso-8859-1?Q?rY/8IdC9jepr2yQ0TlLrKkS5hTVG+H8Woc2SUpX5DwaPwyT3MJkA9wRKCB?=
 =?iso-8859-1?Q?ND+h7RTVH2F6gFbHVmtHcbz9VuwCiA9Ax751MOqi6qjB+sz5tzwBt7DOKr?=
 =?iso-8859-1?Q?Ns04UikZAESsSM+V21pBiS0PtDSJZpEVEJTBAnaRNERbxEeC7Oci/njW2W?=
 =?iso-8859-1?Q?g6kPpVCb86zTXpXe6i6wCpkRfNB2Etq0MwvlSUoB6htR8vnYc5lDz/+eXW?=
 =?iso-8859-1?Q?VBABdeK+5w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de494cb-c381-4516-a32d-08de63c66ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:44.7771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gDTLl43Enx/QP3gqdTMjUXBtw/TKCYcWaow/cL/OC/CgUKfwQcLy+lt5ZjnPjEg+QtIq5NlYtcuOko18z+PNJ00p6aFfkWoZdetUFClgCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The current AST2700 functional test forces PCIe2 enablement by manually=0A=
manipulating U-Boot env and FDT via the console. This sequence=0A=
interferes with test cases that rely on the default boot flow of the=0A=
image.=0A=
=0A=
Introduce a 'enable_pcie' parameter (defaulting to True) to both=0A=
'verify_openbmc_boot_start' and 'verify_openbmc_boot_and_login' methods.=0A=
This allow test cases to toggle the PCIe2 initialization sequence based=0A=
on their specific requirements without breaking standard boot tests.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700.py | 9 +++++----=0A=
 1 file changed, 5 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index d7eeab9c23..cb1aafeb99 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -65,13 +65,14 @@ def enable_ast2700_pcie2(self):=0A=
             'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
         exec_command(self, 'bootm go')=0A=
 =0A=
-    def verify_openbmc_boot_start(self):=0A=
+    def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
-        self.enable_ast2700_pcie2()=0A=
+        if enable_pcie:=0A=
+            self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Linux version ')=0A=
 =0A=
-    def verify_openbmc_boot_and_login(self, name):=0A=
-        self.verify_openbmc_boot_start()=0A=
+    def verify_openbmc_boot_and_login(self, name, enable_pcie=3DTrue):=0A=
+        self.verify_openbmc_boot_start(enable_pcie)=0A=
 =0A=
         wait_for_console_pattern(self, f'{name} login:')=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
-- =0A=
2.43.0=0A=

