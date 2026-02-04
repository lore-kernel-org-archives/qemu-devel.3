Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F86E83EF4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY8p-0002R8-ST; Wed, 04 Feb 2026 03:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8n-0002Or-MF; Wed, 04 Feb 2026 03:21:37 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnY8m-0003UH-3t; Wed, 04 Feb 2026 03:21:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+vijr3ocZJqrZ83FSHhnr2O/d943VlnS0moDQNnSundnyZI4keq1dlGBsirp+xgKSSelPTi6DmhXsY4wCOi1gLngUijzgAA87O7D0RwLMCyvmpYcXtOZsPFZN8kYL1EPeLeLo+rXLwSDu0P5Vqz3rhWkLzA4Nlh73MHui71DAjyHaDiX1va0T5d0szZvktAVWPoTljV8JUq8GkkiRgbpSQlbVwNTnGFmHHzyRQrqGqNwv5BIZF4RgJXpJ7Fqh6yDWJnnuJxyR8wKmjK1HkL+1PrA8GyOFoWBSz+5Gxgp/N1PMLKm+y2vUiqqH0YKB44Q/HGiYYvVrBoMQ6ekIu/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqVHZzjdZCw4F0K5VxpFx9ItR5cw+RDt1xLvyUs/U7g=;
 b=XJO2k6LkIEHp1ijSuB+rHi/XVPmpFtt8CAzn1GQUuAdyOxi2zbkNXbgT1mEWu0krHyzluAE0s/B6NYiiDlONoYl1NZYS7Co35Uts1jD+5SlYdcKuSmsXAeJ9TTRH4SHrLCUemnwAAKN4enJgr7hOXue6/uXoH7icyHmhDMimqdUHGwkIbbAUH3weStKJEsxITuzIg0I8sKPEtOYZ+s3knkQrmKdgzRPcX7iD/H/z/euijJ7AA488dMiGK6dfO1uA9SJnlwdC5oDbJvx9EsiaX1StjsN7JsqBC14HV9aYvvU1pXgcXGSGzYRH7Ltb35QNxazZ+GzCdExfMry7oMGmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqVHZzjdZCw4F0K5VxpFx9ItR5cw+RDt1xLvyUs/U7g=;
 b=htdgneBYWCu39+wqizSOcEA+oD3AkX0/zKnWv7kCH+KLgXn6GtIcpWYMrhTq0glrP4cVRHDj1vyUM5y/nH7BtKZ1rE6JNwI6piwadL6gAPrnpzWE8+2PqYV80rw8YsH2K9EJLFKIytMqaoN67CttDFMMi3nzvmhR2Q6DS32anaoSsTKAoNxRtR+AS/eF4eyMZK5BeJF21lM+R/42hizMqKo/21k4NltOM7EufDToZaDZ/G7j7i7MomrtKDG/0kdXEuNJaEecNX5ZMRflx5Kwwz9+yl/rDZpSp9vVKhwqJ/tBT5PNE2/4Peack+SANNRdWLgIueOaSZE3v8nq4p4x1g==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5586.apcprd06.prod.outlook.com (2603:1096:301:e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 08:21:27 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 08:21:26 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "kaneluno1@gmail.com"
 <kaneluno1@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v7 09/22] hw/arm/aspeed: Attach SRAM device to AST1700 model
Thread-Topic: [PATCH v7 09/22] hw/arm/aspeed: Attach SRAM device to AST1700
 model
Thread-Index: AQHcla9BnXa5/Abck0KIbiak18NVfQ==
Date: Wed, 4 Feb 2026 08:21:26 +0000
Message-ID: <20260204082113.3955407-10-kane_chen@aspeedtech.com>
References: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204082113.3955407-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5586:EE_
x-ms-office365-filtering-correlation-id: 4f0449dd-7699-45d7-765d-08de63c66437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?15LunoY5Hu9fZoHci+87Y34+Y0MovmTcfjSk8VzEm/dlasCVrHjcwVLYNJ?=
 =?iso-8859-1?Q?W7cKQSGy6tnJIi8DiqcXzeATat6BchBLWEJCw/5YsOjLRUuYi2sHL/fHbS?=
 =?iso-8859-1?Q?blPfttsZl7Vos17RLmKgWImNabhEcAyvOyTpyahB1r1GfUual2mC1/CANV?=
 =?iso-8859-1?Q?FnsnLreY+DcyXCqbLI2PmuLe/912o7aUBT/D1WV+M0OwCFSi00jhiKAtVZ?=
 =?iso-8859-1?Q?44hLMfBFInEaAbeq7PDICXtDXHScBXT0zpvjwTvYKiuVfWUgBV5TvEOBKR?=
 =?iso-8859-1?Q?sqr2z36no0HwPIhIzi8X8hfsJu7tm0e6mO3oLtEn3uf9wp346idf5kknc6?=
 =?iso-8859-1?Q?S8cnEf8I43CTOc2ee7ijYHsZ3cL+OgEp3TkgWVKFkohpnp5YKBpRwPvm9u?=
 =?iso-8859-1?Q?FPr8BvBv2Ymtw5d/7goc1HQqlTXegl5WE9MPt6V3EgwPyS5gA8E58qHV0j?=
 =?iso-8859-1?Q?Fo70Ix2FFY8TAvnRgj1RzjqUDqTKoy8oJTGZYiCafDCZp37tf02LsH9PM2?=
 =?iso-8859-1?Q?9SI6K/Hw3hokfM0GH4li94DwUTJyzpu/R/68ds6DZV093bbxIzOKsMUEBe?=
 =?iso-8859-1?Q?k5NdxFuZhFWeC9GBETdxB/oP8rEmgpg7EJZv9n1P9GeCnGUEDsA5YCi/HY?=
 =?iso-8859-1?Q?LPd4Hq5EUuuleKAfIZfyHsJLaDlupfvbjYtByGqO0NMUggL2VhvAckSDQ+?=
 =?iso-8859-1?Q?REqR2S+7vK27jFMpcUezQzajHDF7ymn/wdUrVYhd6xnrOc87mpAGXPYSP/?=
 =?iso-8859-1?Q?ZrIGXxP8N3bufLJfwE2HmTwc9EmVkvIGgO515p3dS24zq0ZRT4ySxw1ZAn?=
 =?iso-8859-1?Q?E3kMoJRo4PiaQ/Y240R9SVF4j6HEXhD/ngAf1N/bEaoRL1MkdnnWy7PwzH?=
 =?iso-8859-1?Q?13Qr2IRVcbl+qUKxeMZ8Au2UoCqLZoz8QG0VVI41dFw57rIF4yCVS7NZJY?=
 =?iso-8859-1?Q?XoJIGBS3JzsdZ/mblhQUOnj1EozCNwSu2IMcxxaiET5AcU8ENftUZZSrUv?=
 =?iso-8859-1?Q?0so5GTZ73UP7Xm3ShJMRlZqFscFIgx5FZ63VVhw3Nw26K01laOrEkeVkxJ?=
 =?iso-8859-1?Q?RxyUHUOUnmyP1IG+5ubqCFkiI3m1s8Vdx8mVIosCGLudknGi1FxJZ3QnHO?=
 =?iso-8859-1?Q?dhR51cKnHZ6UsbIo1R7ur64WsmtIqHjtvs+KioNW57cDG70gOOHJyhdL4g?=
 =?iso-8859-1?Q?R0cdGGdNb7+EQq7R8uF2ALJoPyEbXAT8bldQ2L5t0lESn8Sb1+dnoFaz0S?=
 =?iso-8859-1?Q?vCrNbiefMSXX9W54p9b4QSvrmKQqyja3CARjr73MZ3aUjSs/p9FD4HRIYt?=
 =?iso-8859-1?Q?qLX3pwFVb1YrWCYkvmhw25MPJIa1ij8ZP5HkKlCg78b4O3hmvUROEb0Dtf?=
 =?iso-8859-1?Q?D3F1XFXMdupGzKtWyywtwR1XTAAHUn+RaVSk7Jd8eDIO1QaTCFQJS2iOWk?=
 =?iso-8859-1?Q?z6HhU6RQ37oGm3z/jafaQYZraVISHz0HbMMq4DHMuPwbX8ozNyooqAxpyG?=
 =?iso-8859-1?Q?4KyRNNlVBtFhtxRCvlv0GPt/diFje/VcwH9AeHn1wXxNN4xvp+kSdT4N0n?=
 =?iso-8859-1?Q?7FvX2wrLQIDJNasfpT8rnNhuCTVgQ1Zjsbvu6vEbljZgtTtuyHKb5yGB06?=
 =?iso-8859-1?Q?SOg0cOrmqeYq8KzoZZ/eV4/5rkvwlVu2gIHgIHgd8ifcf0p/wcYzQ/5GF0?=
 =?iso-8859-1?Q?tL2htTQiCqAw21eMujg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7zA/8HLKItT9W5wGi94OBdWPxz3dfjJCcMGHSVezexHXh3njfl9xJ4SL0K?=
 =?iso-8859-1?Q?dBnOxoMuTq0m8tyCtMRXrnd+CTwr5N+72K5V+I8WkjGOALIv9hYD+xtAn0?=
 =?iso-8859-1?Q?8RBEXqSVuFCluKlFh2CUb7e8n+UJsBXEg+4SeYO4Rn1B9JLbK7++o1z5B9?=
 =?iso-8859-1?Q?UoGBqJCKvJ4rp/VWjERU8FMnIGBc92wLEJ1vVrblmjS/7qdjSdKOr+bqYe?=
 =?iso-8859-1?Q?/R4KRYMRJ1I4nFKFjLvaVtBbB2/sFzAK2fjGxjhOu/FC/X47c9RXHnfFYf?=
 =?iso-8859-1?Q?3/GmLo5uAYjRmWwoSsgL/pHf6ECB3t558oyqtT/O0OvDrdqBsRLyNfyB6Q?=
 =?iso-8859-1?Q?KpWx2AJHkoeWbVIzoELdkRgiwIXYbV2bNCg94a7O0lrXROcW/nAQxQVpGJ?=
 =?iso-8859-1?Q?5A5R2eNUVp7fmwhSUrQyGzh1kUSZ+TmLnc++LxCQZd/JtQ5PejLgiwWHy3?=
 =?iso-8859-1?Q?uxnUhCK6arRupqvZudIaUln78KosXtehia7DL7x++EBmBLyTVd3Qzeigmp?=
 =?iso-8859-1?Q?GzahuL8IjaFuswhKcYeJjSWv5SBZI6o2k0zJw349ehc4u7XdTyA1Me58VG?=
 =?iso-8859-1?Q?s2/sr66GC1/dje5rhc2ePHaHav5gWhFSxV/9gcm5Vcv9rjFFauQZfA0zSK?=
 =?iso-8859-1?Q?+AO/EDMJ4JNkK6UaT/EEO/mKbML9SJoyop7yhSXMYNlbx6jtcNGh+oNhXn?=
 =?iso-8859-1?Q?zQdy2aeK2BOwK2/GITx6gEObf5qm3kvGPZmbDiV1QUig4iLepoKW+9Uk2h?=
 =?iso-8859-1?Q?UZEfYL7R94/6oF2DDcn+QjxWxGD4BclwA0jU1Sxm4mxQjdP53i9FznIFfU?=
 =?iso-8859-1?Q?hCopyfq0dNZomprfl+UnA8DuV1fsHbD2G9m0sBX24f9Ma9pdtYKLULPvuj?=
 =?iso-8859-1?Q?4br9fLntLz9g3hWFGBODbSZZOdebu7fzbtyv7qp0pjDgzEUm+xiEealtEW?=
 =?iso-8859-1?Q?wFgdDyKTLOCfS+w5xM6BXD7tvpd++OkKGoD2LIUst93ATgPmu1SjCIXXRb?=
 =?iso-8859-1?Q?wzmHsqpajx1grhvRjCKmwa/+x163DptzfpY1URVPzzzmPUdekx21QgbmWv?=
 =?iso-8859-1?Q?34HoRQwRAM6v+9zdLlB/5QEgEtMN3I9qqaXztOaHu29WdnUZ4GcotBK7St?=
 =?iso-8859-1?Q?BV4g0pRwfFITSSlY3Cd/S/6HSy589BUs0FQWWH3kxn8yloNr+lsMWeENlA?=
 =?iso-8859-1?Q?nd5I7Eg4gPPWJWW+6ow1E/E/uTf72sOYpW7AydqTFf9bM7hNw3msk/DCbd?=
 =?iso-8859-1?Q?57crKXNyYKLy/dv56+IuneAwri2ehOOSn9YJlUGCO5Xd2j2WBXCRlfDuwt?=
 =?iso-8859-1?Q?sAi9Buix96uRJ97nXXdOPOaUWe7U+bLLz3rnFOjghlteSgH4ul/AmkN6qp?=
 =?iso-8859-1?Q?byAASlcfPXkTIKJVot6lKIxCE1W2lAzlGpyaBlPr/BXZc+kF+EcEZX4TnN?=
 =?iso-8859-1?Q?oyjs6LcAWogi6sFi4180tTJhSdWNpUnSke4NN5HWuelEhWKBNCUKtWdsiC?=
 =?iso-8859-1?Q?ZweWlf4zzKQS0TXcwt+TIkESDoOo3ePbNx915owrEOaEsOu7tat30Z3Hto?=
 =?iso-8859-1?Q?YkAvpICAnmKxSYgMgMi6IeRJ80Lo9H+gHEJ3A5H5i6zhH4BJHQKU2MeYJO?=
 =?iso-8859-1?Q?WJQsoZElaK+7v0UutVfhEVe9mVZPW4+7I5r4Vl8DJN2Cr9dkvm4d+rvbCc?=
 =?iso-8859-1?Q?OdEUbDxpS2DBQcvzogvOWZnHWtve0D95P0/PF8OCpk9XajNJyivUw1Ye7q?=
 =?iso-8859-1?Q?CgOeyTUTHrvYOHiGb1mhseILTNT9JCJ1iyv9+v93XOTLvMHn12hvI5BSgt?=
 =?iso-8859-1?Q?cZfyJP6L7A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0449dd-7699-45d7-765d-08de63c66437
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 08:21:26.8632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKueaqx8Itz96f+W8ATMcqMR18Bu1MNELfCU/JkAlVIx5L1WDPKCXcWXzIg0LT+W+dwU3NfSuCm6qqH5B4YeoFfwiVjAsp3LBNMP+/OEMK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5586
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Map the SRAM device to AST1700 model=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Nabih Estefan <nabihestefan@google.com>=0A=
Tested-by: Nabih Estefan <nabihestefan@google.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h |  2 ++=0A=
 hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++=0A=
 hw/arm/aspeed_ast27x0.c         |  1 +=0A=
 3 files changed, 20 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index b15b13aedd..a981bff3b2 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -20,9 +20,11 @@ struct AspeedAST1700SoCState {=0A=
     SysBusDevice parent_obj;=0A=
 =0A=
     MemoryRegion iomem;=0A=
+    uint8_t board_idx;=0A=
 =0A=
     AspeedLTPIState ltpi;=0A=
     SerialMM uart;=0A=
+    MemoryRegion sram;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_AST1700_H */=0A=
diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c=0A=
index f610f25932..fd5db3268e 100644=0A=
--- a/hw/arm/aspeed_ast1700.c=0A=
+++ b/hw/arm/aspeed_ast1700.c=0A=
@@ -13,13 +13,16 @@=0A=
 #include "hw/arm/aspeed_ast1700.h"=0A=
 =0A=
 #define AST2700_SOC_LTPI_SIZE        0x01000000=0A=
+#define AST1700_SOC_SRAM_SIZE        0x00040000=0A=
 =0A=
 enum {=0A=
+    ASPEED_AST1700_DEV_SRAM,=0A=
     ASPEED_AST1700_DEV_UART12,=0A=
     ASPEED_AST1700_DEV_LTPI_CTRL,=0A=
 };=0A=
 =0A=
 static const hwaddr aspeed_ast1700_io_memmap[] =3D {=0A=
+    [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,=0A=
     [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,=0A=
     [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,=0A=
 };=0A=
@@ -28,12 +31,21 @@ static void aspeed_ast1700_realize(DeviceState *dev, Er=
ror **errp)=0A=
 {=0A=
     AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);=0A=
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+    char dev_name[32];=0A=
 =0A=
     /* Occupy memory space for all controllers in AST1700 */=0A=
     memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,=0A=
                        AST2700_SOC_LTPI_SIZE);=0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
 =0A=
+    /* SRAM */=0A=
+    snprintf(dev_name, sizeof(dev_name), "aspeed.ioexp-sram.%d", s->board_=
idx);=0A=
+    memory_region_init_ram(&s->sram, OBJECT(s), dev_name,=0A=
+                           AST1700_SOC_SRAM_SIZE, errp);=0A=
+    memory_region_add_subregion(&s->iomem,=0A=
+                            aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SR=
AM],=0A=
+                            &s->sram);=0A=
+=0A=
     /* UART */=0A=
     qdev_prop_set_uint8(DEVICE(&s->uart), "regshift", 2);=0A=
     qdev_prop_set_uint32(DEVICE(&s->uart), "baudbase", 38400);=0A=
@@ -69,11 +81,16 @@ static void aspeed_ast1700_instance_init(Object *obj)=
=0A=
     return;=0A=
 }=0A=
 =0A=
+static const Property aspeed_ast1700_props[] =3D {=0A=
+    DEFINE_PROP_UINT8("board-idx", AspeedAST1700SoCState, board_idx, 0),=
=0A=
+};=0A=
+=0A=
 static void aspeed_ast1700_class_init(ObjectClass *klass, const void *data=
)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_ast1700_realize;=0A=
+    device_class_set_props(dc, aspeed_ast1700_props);=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_ast1700_info =3D {=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index d9866c2c3b..6a144742ea 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1023,6 +1023,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
 =0A=
     /* IO Expander */=0A=
     for (i =3D 0; i < sc->ioexp_num; i++) {=0A=
+        qdev_prop_set_uint8(DEVICE(&s->ioexp[i]), "board-idx", i);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

