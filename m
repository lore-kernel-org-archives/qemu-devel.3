Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0163FE83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY97-0002bw-KQ; Wed, 04 Feb 2026 03:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY94-0002Zv-88; Wed, 04 Feb 2026 03:21:54 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY92-0003cB-5Z; Wed, 04 Feb 2026 03:21:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7n6n1wEKQ53Q+Iyl6/kXHKenZgL3VexFoECRmD4oEQeE7MANX3pBHRreM4l5j7qa089P6ug+KbBlYZ5ybxhhrQsGcA8fsWdqulesOVNDu4hGbYVeECsVaEJxTV/8H33i5Duo9BDig/PYGhtpFGOEn0LwkSQ6no8aQJQxeQInPZJMwEwMy3HAAErsRs5b1qb6d5RuuOJ2EFePdyXzmpC9vSdKe9TomNLR2BKsqhEFrW5zrkXenQy8pWBhC4g7N5TLGLXZTnCaj1m8B0c85QZC7hwVuv3wAADRHOog3ye5BodVZRPk1nKtO0NmCuu3WwGl6ujYxCA7l5HAnO3Pm2pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaATaDJ9RMS+40MZUsvlBfuJuN63BbZOmKJihnxTg8w=;
 b=QQn6B/+UIfauaBhEKYRbi4SBPu/k3/fMnbWFaJPxKSpS5bh0+q/Si42PfkcxSAMejdFaBnsMjLWhlsn6FU66y1gvfg56Cj2m4iF4msuR5fxo2kEp07OAgdMxDz7Chr/7tGvp+UI2mUoyntHtaswsyMsi8Em3oR4Mew1Rhc0edklTPybJyF/QvgGfB7nG4qRCkrKHvYd6vhiWEdhkJuJIlwR5Qjtr/laPr5qe5m/oQUutUIbX3PG4Qx44VmgkrU9jNwUe1MZInt3BHb1gsEzlDEy76QB6fqoEh+xrmylYvN18RMf5QqHda/ELQOEBaOMCtbgWCBmGeYnLCUoHDdLUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaATaDJ9RMS+40MZUsvlBfuJuN63BbZOmKJihnxTg8w=;
 b=gKtDuFUNrtZc70sQnbkHDGBRJl/voWdXVys2BzsSkI6gRDi47bFbUU5Uf9u2+FcL58rayLxODVMpWA0MN+nfJk8YS053qkPZmK9zLk6+NsfH48PvsRoOgpFwEM03RMD+dfOdJZXKYOYQ5+TAb3weHDr8ByKVUFRr2WT07ks5wOqtP94Ju5YLMJG1sb2gmb8TzDbRKuOx/+OpizilzeEJ+cW3P50/Y8Dq5HGL04/AkvtWmHp8YAN72ogPhpk0Qeb2DzoJz1XFHcL44wllGbhVdFoxIkXRt0ahY4rD3oQv9GjV0uw9ngpWBLgX3SRNMFLNWVjC0PSPLYvQMBmo/QqIpg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:46 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:46 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v7 22/22] tests/functional/aarch64: Add I2C test for AST1700
 IO expanders
Thread-Topic: [PATCH v7 22/22] tests/functional/aarch64: Add I2C test for
 AST1700 IO expanders
Thread-Index: AQHcla9NbR1wb4blnEaMyuZ6qtXC8g==
Date: Wed, 4 Feb 2026 08:21:46 +0000
Message-ID: <20260204082113.3955407-23-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 29c9ccbc-ea91-48e8-155e-08de63c66fa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?icnU5VMh7fEpO6LdupE50mn0kYQtUNH4DaIILU199ev+eyqMGDSwZRd+BU?=
 =?iso-8859-1?Q?4mjL3EsUSiHaxM9C2Aa5e1CeZKOYiQiqXLA5as5QDvBtv2ktY30KW9OBYg?=
 =?iso-8859-1?Q?6EDP4JrEZwi/gvh3PHVo2on10NUrPiin0bITITJNi8faOYa9PPlopbPnmz?=
 =?iso-8859-1?Q?jwgCu4bZ7/5G9HmPjuxNLNPN7FSRT213xxEh6t0SZcnE1n8iBSjepQM8bl?=
 =?iso-8859-1?Q?tjdy87EPeZH0qUCltzJsJhFKPDB0XD0mCSI3T+aloSt1QBv+2H5MMaL6tw?=
 =?iso-8859-1?Q?LJHpnM/vIKeJ905odOYxN+HvK/5ovq1b5okkXsFlwqG9e7MI4jUjVtF08Q?=
 =?iso-8859-1?Q?6Qqof6oVtAwKuwmGhFpnBTO09PSiR//W4p7MvjjP6zIzajLZK+RCcBPQl4?=
 =?iso-8859-1?Q?L6k/uhFDXDDBwm3V64CjsmXhAzBliz3fmBcQJUV9J9Ly74mndMrq1ZBOC5?=
 =?iso-8859-1?Q?UhCB2bgI8uQr+4DSEie2QVUV2XpzgoBKYPv1srHSCvigsXdxT54IMAOxV8?=
 =?iso-8859-1?Q?ntUWy4VV8tFcHyK20NhnRqUlRjSDF+b7iTn9VPBi8AM/J3GuTmnw5F2dDE?=
 =?iso-8859-1?Q?DfaoX7F161/HGriQb5VSUn9gCDw1s2TUaoii+WLPJB1PLWlWXCgH49IqVk?=
 =?iso-8859-1?Q?X8FfkixX8KcrbFlkVKKWUeyFmx83SOURYyt5KlB7ZujWAY7WjGcIOv0twQ?=
 =?iso-8859-1?Q?I39vo43WgCH4229A+RO3jPT67NNdBUd0VKeZIm5viX8AHL3zV8GeQ4fbop?=
 =?iso-8859-1?Q?jNtwnCIaMqytLyj6n4kHmGvVE8Xc4M+QSDF/FjnUNMZqrlKTCaewlx8T0H?=
 =?iso-8859-1?Q?hefDWcmfDTumsRuHRWmAdkGPnPTq8tJsgT3jgug69bgTmEoPLRxrMWSaC+?=
 =?iso-8859-1?Q?AxcmA8zyoQj1LCnTejK33439plhEiAUP1/FdHoo9/koHwAVYgaojGYsGSC?=
 =?iso-8859-1?Q?wjRuv5mW4A03E/dcEWEVXXpogGnv7DwlYuNFrRFKIfei4bkC5QPD3RxkHB?=
 =?iso-8859-1?Q?3X9ie6NCZV3hOoxK0Nz0dbxh0tON5a0oSp0he8fPciQTPfHPMxy2L+4qrq?=
 =?iso-8859-1?Q?ORfty5uDM+0JICJ22jd977WVhxs3+0TyrToO+GJeiVM+wyihec+5ZleVmI?=
 =?iso-8859-1?Q?Rq3fHO/8w2xdeltl0MGNfaqOfMF2viZfon+OoBXwAr/0RNN5eWoeOJFeNd?=
 =?iso-8859-1?Q?193DXjvC2z8IIIqB952ZJr/re75MhLqwWs2XTaFJr+chBg5GxOnKj6/VWT?=
 =?iso-8859-1?Q?4Wo+mDc6sdpb1mCiD2sz6dc8RcsbI5ppKh5DlXDZxbVDAwCar//7pKc2oH?=
 =?iso-8859-1?Q?qEnKe9FmDosoEUT6QcVduuFUfep+rthxVo3J+CrtqpxlMxruYBzL7ywo4j?=
 =?iso-8859-1?Q?d6L1EW1u38ZR5L7EXVhXGnfSo/w22l/Q9tjUEEcKXFMO7KcKQkGHEs25EO?=
 =?iso-8859-1?Q?Qh6ftqe4B/XINQn3oHmv11zcbEqJ0gObERT05XLK1BCG9VQXmDCHLc87b9?=
 =?iso-8859-1?Q?0uLc30eO/+EjhcFBmF6gT+0aWS9nocGY5egtBp29xXXpd2+Pgqh9o3Yw4t?=
 =?iso-8859-1?Q?CrLUjXYHR6QWMlo1k9C6pAAG0zftMRiP3P/eYVpzOAdSqLqOugTBfr523T?=
 =?iso-8859-1?Q?b8hFAwHMv/Irb+c/1q1apH82dJwez/6Thy?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aRbffW4Tzwcf/w1QWYxsL3XRY+nCustYgwq3M76Vx64cprVN+JGFm40c1h?=
 =?iso-8859-1?Q?Tf7RUr05umyM7rcUNcgqW9ZlRpITpUDr52TlpbuBxQ23C3/toCrPCFMd9y?=
 =?iso-8859-1?Q?VnEkBEE/emD5bFrQ+JmeslFCmyt18q8bWgZXoaIPLbmznmwVlp3lkM2ovB?=
 =?iso-8859-1?Q?K6PSZi2yoc3wn0sY/lKuYjUw9q0Yx9C2VH2ZC6KmTONl6g2yPKlc3v5PSw?=
 =?iso-8859-1?Q?BoWyf3YyGFEwrhknlY0njoGUpgDpdLtnqGo9Ex7feWqv4YONU2zxUbzLg2?=
 =?iso-8859-1?Q?A9aZYkst7NkIY/aZzEfleaXFPccQwKUVISRZJl/IDoPQEc1xf7WPJ3yCMG?=
 =?iso-8859-1?Q?a036CK/ak96igK3p5WKR5j8nLQ8+qWxT+JdyIcHLDFb8dIybQBZjmxM8yP?=
 =?iso-8859-1?Q?qr3SkjIT56N57cGieYeykG1BywyLJwJNdWp3MhL+S/d3Z4l1wI4Fk8xWrH?=
 =?iso-8859-1?Q?a5Of14ZZmsjrimiNc+9WOSrJ21tPf8z5EBs/PBvI87pItr90+stK/cBcsL?=
 =?iso-8859-1?Q?m59YJz4fYgLawMAScO/m8foOee13aoUhIVZSj9W/YU2s/oTTj62ClL5Qww?=
 =?iso-8859-1?Q?6p3OHkRwt/GNXGrSYorgXw3M4IHWRzQdCDUpIxpcXXF4mCMH+DcpEDWNvn?=
 =?iso-8859-1?Q?GvK5pc1BBMTvULvSNMONiGcixPuTM8O6CFpmoNWYdgJh7vz2SApLRLG3GE?=
 =?iso-8859-1?Q?2tPt/5abkz1cWtJLVMg1/F2qgflGlPNLTH0VlVd33lcfEjVQUxNghZuwrJ?=
 =?iso-8859-1?Q?MdMibhaaAtiinTphyQ2yS630Pg4bFIdR/PzojDam2X1PS7bB49RnrHV57m?=
 =?iso-8859-1?Q?8YxHZ20B7Hn780zFD3hQrDS0K5tfOM3O/UaCju7c18KHPJEa24/HtvCLyq?=
 =?iso-8859-1?Q?+aQYWz+YKrXMrvArjavBjJSWN4a/SIKjUMXRR45dTDoMAFOfAxq6OHXG8y?=
 =?iso-8859-1?Q?g5QbcCptpdKZGTvpraZkFLju0rclp1EurLKu2gOwikxWjmwYL1XYXMs8u6?=
 =?iso-8859-1?Q?uk+xV+x1NCY8yRdHMj/we9IHbtwT/do5n1vcDey1NEVJYVQ7SFHYO8jVW6?=
 =?iso-8859-1?Q?6hOs5J6mvhWj4z0YX+nWOD1bJ9SFCM+L/trVt4riCKhFlnxBe4RPiMdagh?=
 =?iso-8859-1?Q?ibPjp48j7NBkcvdWrSpMLSu7xuPa8ESgkZ9waeXysm3AcFHzJQJCP7O/cb?=
 =?iso-8859-1?Q?oMy4pPRR4+q+CGy4XHUJOUMDGgTrjNd+PuGfKRVuORxFAkAQZige3jYUex?=
 =?iso-8859-1?Q?et1P710CP6qP8IYhqdeJEt4PElr9ptVLJdf2bZFBS60Awg0ZQOajHcFzwT?=
 =?iso-8859-1?Q?B1pFQr7GgLOoAz9weTPcPWdEQ0Tufnx5PPRwjgTcy2w8O726RpQwAvnVaF?=
 =?iso-8859-1?Q?DYdO1XdTEENNpuoMRitghjly3U1QZgKw9xZSvAarX0i5mq3Vo8u/acAetF?=
 =?iso-8859-1?Q?X+VovI8uRuh8jgslM2r/MwufcuHHNDOIsZY20k5kCmNshgZtiA0Fr/bWTU?=
 =?iso-8859-1?Q?BAf9/VcWEnqlAinEiuA0fAt8PS2D3ROKdQCjybzDZ+oGtVeT7ILJm3mRd0?=
 =?iso-8859-1?Q?857L8NTxRmncqzD7TGB15Zby/Yvkl7BSV0GW5k53hF1XQ+/qxnnJCBTQt+?=
 =?iso-8859-1?Q?//rEenfv5eEWwZNjx4mDuXVWGs2SIt73+h3gGprdFZsPOyOwcErurXiKbk?=
 =?iso-8859-1?Q?mdDOABz+B3zerhtSzo0VaJODDCIhqMURIUV8Pp55n7D0a4C44hwi0bwiT+?=
 =?iso-8859-1?Q?UKMRCyAeMPEeBtlR9tUHjornIhdK8EKL+Qe8h+NszMqGrUpKY6x0YH/2Xp?=
 =?iso-8859-1?Q?D7cgjg0FVg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c9ccbc-ea91-48e8-155e-08de63c66fa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:46.0694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pjwc8DHedjXrDDQtatArbsduPmBIufuDY43SLnWr58OcFH7/RQE+8yLhirtjnuLxwUuW74ejGKRXeuIj+3jT8Js0/NYz3pag2ImVeKZpRYA=
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

Extend the AST2700 test suite to verify I2C connectivity on AST1700=0A=
IO expanders using the DCSCM image. This validates the new bus-label=0A=
naming scheme by testing communication on both primary and=0A=
expander-attached I2C buses.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700.py | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index cb1aafeb99..61373ffe5b 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -82,6 +82,10 @@ def verify_openbmc_boot_and_login(self, name, enable_pci=
e=3DTrue):=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-obmc.tar.gz',=0A=
             'd5ceed511cd0dfefbb102fff2d731159e0472948a28066dc0d90bcd54be76=
525')=0A=
 =0A=
+    ASSET_SDK_V1100_AST2700A1_DCSCM =3D Asset(=0A=
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.00/ast2700-a1-dcscm-obmc.tar.gz',=0A=
+            '4f8778be176ece1b57d33c4aee13bb989be114c3e4703150eaeb6f996bd55=
87f')=0A=
+=0A=
     def do_ast2700_i2c_test(self, bus_id):=0A=
         bus_str =3D str(bus_id)=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -166,5 +170,18 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_00(sel=
f):=0A=
         self.verify_vbootrom_firmware_flow()=0A=
         self.verify_openbmc_boot_start()=0A=
 =0A=
+    def test_aarch64_ast2700a1_evb_ioexp_v11_00(self):=0A=
+        self.set_machine('ast2700a1-evb')=0A=
+        self.require_netdev('user')=0A=
+=0A=
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A1_DCSCM)=0A=
+        self.vm.set_machine('ast2700a1-evb,fmc-model=3Dw25q512jv')=0A=
+        self.vm.add_args('-device',=0A=
+                         'tmp105,bus=3Dioexp0.0,address=3D0x4d,id=3Dtmp-te=
st-16')=0A=
+        self.start_ast2700_test('ast2700-a1-dcscm', 8)=0A=
+        self.verify_openbmc_boot_and_login('ast2700-a1-dcscm', False)=0A=
+        self.do_ast2700_i2c_test(8)=0A=
+        self.do_ast2700_i2c_test(16)=0A=
+=0A=
 if __name__ =3D=3D '__main__':=0A=
     QemuSystemTest.main()=0A=
-- =0A=
2.43.0=0A=

