Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC21AC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNX-00039T-FN; Tue, 14 Jul 2026 23:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNL-00036d-Ux; Tue, 14 Jul 2026 23:33:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNK-0000nz-9I; Tue, 14 Jul 2026 23:33:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWtuLWOGDW/iifCwD3XNeiU0BPW9JaH2/gcGrP78Y4OljEtya7EcJjyxJkKu+18riAwhhy8bJ302pyHozISMUh0XM5gzT3YwljWoUqcwZF7aGXm3gJ47mcMkT05HGcWreAYSpmz4HitpLBeiNi4MpTDQe98FOvE5j3Ok80ZDwdQZWg2HDbQaChtMKsS6clgOZoXt3L/godjoCJSPuPFJThr+TFAw9XVJj05fQRKPFLE+kmD9glkw0atUGo+AF/CG3Rav4udVvAASmMwsyOImwSpWeCL3GDFEPkPur3ulhPuvwYOu3g60+oWJCL690NkA6FwXB19/L8yFDE4ZuOhVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz2ZrYjNFIEyR9wMLf50R86b/mc+40oBc0lbpSvtVzw=;
 b=AQt13PMuwNbhfLPrkHqt/hv43mHSqGhVhOPBWUpi1AMiz+1m05SRosXYWPcW0sCpaRXvtQKObmOivSAVBkzjo0cbwx0OwI+sGgLxSjqNSYRgnirzIxiVo4pw/LLXSJ7SxxsXesjFJjOKlBtO/hPXv5oGBjxRufuPf5P9SuBNlG6x0j/WjZhsMRogCJEwPvZIz390OHGqLqRHbb7NnEfl7rinAVZQegRO2hPSbD6Exq2qP9gNezeQI1sInV/b3M35oBxA65aM6yjQDpBVwKDnoraiewQ0Wb0o+s2ShSHfoHpblAs6ecDhreM2RJFwdS4VF6Ax18kGZFiGqeWUM9vQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz2ZrYjNFIEyR9wMLf50R86b/mc+40oBc0lbpSvtVzw=;
 b=dSxkFp/NSd3OITXNNdhHiZPq/VjBxryrAuVuJ2R0rq2halOXJKvVoOF4l6ctcTU16q718LYyOI8GJmtx9xI5Q0EyIctFs/VF5v6jySUqNKEkPLKSg0ksnHCUiRBMMGLK3KU/135j6iqvzCH843oxhB1c5/rljMcQtTKQUFRW1Ay5iRhBBVZHpk9pxHCQpSuceskCBfJEu6sYKA72xXZprnfBKa2yPkHDckViITgOrlMjZUCAgGyrDbsZ7fXdI4xtp2kyCIn5HLRmDveLeIeRxq3Atz7kpkhkZeeu5di8anjZtcHhaod5PjXS1vZV/lztUxSezfLRg+NVSs435WfPsw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:24 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 07/17] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Topic: [PATCH v2 07/17] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Index: AQHdFAqwz11SVsPWgE2glRoFBo19pQ==
Date: Wed, 15 Jul 2026 03:33:23 +0000
Message-ID: <20260715033311.1648424-8-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TY0PR06MB5258:EE_
x-ms-office365-filtering-correlation-id: 97874cf7-7cf2-4346-5d67-08dee221d3b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: 8Y5Q5r/6ewTdOU7z3U53YM8Y+PErYxy5GFKVyoycNUUi8aLgB4kcyOrMK7NQRrQpl/+xAdQ4Em62dXpK2O0YXNes0mG++MrYQtk+C6xCjFnZL15XtnfrPExKXVVEtPunVjJe+EJ43rJqD/dhPliQOi3KjZA/N1tYeCepjVGIjavYvpjTOSZ71bdOtVm1pubIAYo7hhsFUcCSwxbrOLjtb4oYhAnG8Wnp6oeG9jtHJv7KgrCo569UVEyrkbcUa4lVcgEFCVxvlOSJidgNKJkysAD48JlVXUtXKwOkU/66jMuDMKz7+9gB3a+6UixeuH83qINvYUS8/I6KnCXB6LwghvDVnt9IMquNM0F6FnwEXCuwXLyZgn795PW/qkziLTBvFnzoHYdvroeGvTDSsSyf4HVu0VynKqn1MwF3wV2PlR/Y+MohkgDxHUgpSjzzafTlhvx4YibfYf59R5AOUFoyqznW0PTI5cVbVLKm+DgQxWP+ADR/aica7ptPpTQv9g/ikIDuE4Y9TKcV3/RWun7u+Kl0T9UXXOJ9Einq3GmVPDqSC3m9Ddo/zQ3OfSJASFqgV/u4H2y0UZZ/OFw1zENPd5N/6qtW6UEsEr19jB2yAiuD2b0WJV88oHbWe34qj1fa4h+cZPnUI7ZjyPWAHwUr6RV66IXxZQFkiOTEDQHDRi7EBuEXOeSVkzTM2B1SFOj1fmqR4nOIc0dbwOEw5/uOBJXZbohgF94j9LX0zfyTOgUdgJkQt2KFRVjDCmfGHriO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TAPeKsomIMHiyBeTdH6i+pp+j9rxmlMjjAcg6G2eMD25Up3Ngxoh7VOGA+?=
 =?iso-8859-1?Q?/XTM3Co7ohC7s7hFHC6LtD2t4saRoVJxcqTos060DOYUsAyFy6LoQ/Ec0E?=
 =?iso-8859-1?Q?/JTEQGEZNeDySE/YCO9oMYj5atSM1BfW9RPzhv60mV5z7mnIzaQHS0Ie4+?=
 =?iso-8859-1?Q?Qv4RoABY8AYuiDHAhMQ2NNxETpWqf0U6a8i9+GNXL9gXTdSsolKyu8YPbP?=
 =?iso-8859-1?Q?OksGf9NdWBZHgKUw6dK+vjleOtcvDu310VLzktH8iF/tTG9NnnIoUChRme?=
 =?iso-8859-1?Q?zCyswr3+kEBbeTldSMpIBYVNBmuF/+1Jxl6+gYIx4rmtWncEaMYHGdSMkh?=
 =?iso-8859-1?Q?jbo5zo1E0vFYSakY3Gfe3gtjORyXnP5cimV/SbifHG4rXPBuZrng2doslT?=
 =?iso-8859-1?Q?Z2b/5YlcVD9sMxCpgFiapakopzH0oZV7gZPk9XNOSVxoxXUAfAmEzNUV5E?=
 =?iso-8859-1?Q?rfGNuYLGIEXfOfgsILOqa1MOsJpVOC2ebL+uIcMb4dEBONLWuf3pAzA6QI?=
 =?iso-8859-1?Q?mEue9JdMDv2PLTynpu0PFdYLrfF0m5prRUAYjl4/cPH+xL2v/0kUN6du/q?=
 =?iso-8859-1?Q?y6dcfvauB0L1gg/mpwL3JF/2ilMBgpSmffETRxXZd31u6H1RHKv7P6o5+d?=
 =?iso-8859-1?Q?CvWP+NTFovxtc5jEqPgj9C9XufdigmxfeUTgWKyL5moNLjljYBqSwqqvhu?=
 =?iso-8859-1?Q?ZF7K/aP5a4lW/b5fRb3BZ3cgPMHx6UwPbZJ//+ItW4UIJje08+oY05YRxj?=
 =?iso-8859-1?Q?EcyAxIUp5gYm2z1aJ9swuUjf8o78QdeOyLAolFItIEQCoohUIOj8pqZCe4?=
 =?iso-8859-1?Q?f5CKdXOURwKpjPbE0maJ05QkkLeKXQGhMfeK1BsM1dW/MElyaFmNJbOrOY?=
 =?iso-8859-1?Q?xQ9LNLBC0HbkYG1wfNkxL16lM/b9mm70E5TxChXQudPmXivAFeR8Gw0vFn?=
 =?iso-8859-1?Q?tzC+8YkK/cUJY2LEGXAsKGM8r2x2SuAEFveSaVPvsxwvT6NR3427u0W4Li?=
 =?iso-8859-1?Q?eN/ScNbV9sS6aKX5TRdt7URjIV0myvjwNQK1FfcQv9tmk1WC+SDusMEVkf?=
 =?iso-8859-1?Q?g5dmcDYXLGEDdW4ksQ5Kn6+At+izO0uGb4fc2GCWRbEoY/pG+OkcYcP5Rv?=
 =?iso-8859-1?Q?s9A0GKgcL0rTLxy4zuCx1nT7TW4IQe5urLUfK9VOuT8KbyAa2Zz82n5cNj?=
 =?iso-8859-1?Q?P309kvR/YHYAT3oi5HSGQY99wPkq+p6VjgAaq0AM5bBs/lLklVYWPonFdO?=
 =?iso-8859-1?Q?5Sg69Y4hRKL3tccrAAPxDqYebBbjV/f9U14vntsNb1CI0CSCHJQ98A/KKJ?=
 =?iso-8859-1?Q?DqV3iFYMRr9HSGkRsM/BLhyjwRHZa5AGCCzJn+K/ut6lxv457wRuX/DK87?=
 =?iso-8859-1?Q?MV2o0ZIoGqq53cw1zUvgEKQuCTMBK9NCPvE6D9cvL4W6She+4TfNAcm8aD?=
 =?iso-8859-1?Q?B+7nLIH3Vj1sUmJWmPyb80Nm478hXeV1jkI6SDChE9c+b7cJ2jzkQPlGpT?=
 =?iso-8859-1?Q?j7NGoqwdZ8FaJgj3zuENBqQDG+GM1k+LhvVyOEcq5x8FeRTU2kXjC69Lfl?=
 =?iso-8859-1?Q?U+WpA4ukr0yhLCQfo/Ctflluv9h1nLWD2PvTAUNczurYVeLMgFv4JNtySg?=
 =?iso-8859-1?Q?UyqN7nGVFnYfDqQ/Xffhi9HiBSWd2SeYQftICVenGvXjknRifa2bHMmWYU?=
 =?iso-8859-1?Q?+fvn3mQvIGa4KFSSFetoxzMZ1BFcuSs8ppZZE3AKvmHXznR5KFaicLvVc+?=
 =?iso-8859-1?Q?/NzW2gJFCEcOAYAVb/If8PmUXMRdpDC+gCzMXKkzxs8osl/nOy4DRfedSB?=
 =?iso-8859-1?Q?kDuL5yITfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mohHogenYOaCp7tR8pYm7Hp1Oe9YM/WuFsi5jAs0hF6Fnn8GT34g/RWv72KBsM4x2S27fbNWyGVvT0NkeMqnY2Gm9Doe5631k5o4xPpBbmTaJ4t2fp6BYMwUpqgQTIlxMRtzoDBkBorzlJ0jbyMY+UoWRn+dyV5WtKH2gjFNeped6xkE1vaefyNGCp1YZ8xjB4S3OGyDzb9SeGFyb6JRYpRexGnV6WBmFcS9pUgCvHKf2NogJGn8dVBjswT7PjR+/P3VeeZDYywwLozlz2rFk128E+Vn7LvFF7OgWtTV38AUpA9g12La2d5Bwp/GOG0G0UhVujHOfK4s7gwuKaTWCw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97874cf7-7cf2-4346-5d67-08dee221d3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:23.7266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iyC33GCEMvcZIUSIaSNKgKItbP0WF7SscctOgAS8GVOV3swuxOjaBX1g2HwrwEqLyJaGJ8YHeZo/2bvJtfE2gvox+IAwUoSb2TKEyLhK8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
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

Introduce the GCM cipher mode so authenticated encryption can be built=0A=
on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so=0A=
register it in mode_need_iv. No backend advertises it yet, so it stays=0A=
unsupported until a backend and the AAD/tag helpers are added in the=0A=
following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 qapi/crypto.json | 4 +++-=0A=
 crypto/cipher.c  | 1 +=0A=
 2 files changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/qapi/crypto.json b/qapi/crypto.json=0A=
index 2b55befef9..6e3a98ff68 100644=0A=
--- a/qapi/crypto.json=0A=
+++ b/qapi/crypto.json=0A=
@@ -121,10 +121,12 @@=0A=
 #=0A=
 # @ctr: Counter (Since 2.8)=0A=
 #=0A=
+# @gcm: Galois/Counter Mode (Since 11.2)=0A=
+#=0A=
 # Since: 2.6=0A=
 ##=0A=
 { 'enum': 'QCryptoCipherMode',=0A=
-  'data': ['ecb', 'cbc', 'xts', 'ctr']}=0A=
+  'data': ['ecb', 'cbc', 'xts', 'ctr', 'gcm']}=0A=
 =0A=
 ##=0A=
 # @QCryptoIVGenAlgo:=0A=
diff --git a/crypto/cipher.c b/crypto/cipher.c=0A=
index 515165e0dc..52d071a90c 100644=0A=
--- a/crypto/cipher.c=0A=
+++ b/crypto/cipher.c=0A=
@@ -66,6 +66,7 @@ static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] =
=3D {=0A=
     [QCRYPTO_CIPHER_MODE_CBC] =3D true,=0A=
     [QCRYPTO_CIPHER_MODE_XTS] =3D true,=0A=
     [QCRYPTO_CIPHER_MODE_CTR] =3D true,=0A=
+    [QCRYPTO_CIPHER_MODE_GCM] =3D true,=0A=
 };=0A=
 =0A=
 =0A=
-- =0A=
2.43.0=0A=

