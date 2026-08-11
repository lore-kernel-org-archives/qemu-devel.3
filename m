Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A260C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtct8-0003kF-LV; Mon, 10 Aug 2026 23:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct7-0003jc-9t; Mon, 10 Aug 2026 23:10:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct5-0004L5-Ow; Mon, 10 Aug 2026 23:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgVVnNXPRYzpsHF0OkprfxhSQISUffIZX2IcLBYYwS/Iq4VApL8SdClccyi3LbAee83TU6RHYoPc/ODySdOPb8fVYfpdwqClk807zhHzKJSsmKs6pjQzKOuiwRCvl8acL2Cil1iOfN7OfFZaVBxfIurebUy3ndaNsG6RL93uX6a5xkLlyo/mTYS5OwvXqjhcSNlhlqanmYLWc8lAyDfDZvFDv8ryyX3gDZvBlDe+sijQ6gwJdLRzefuEf756R8W9XsfGVzw9REf3FkFfYHXBw/dMGhCQg7heUqDYqMnsW9vth/O42lIZw9QMzehPNVTwWS2dgKlM/o3nAqCN01ojTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7MKGiOv6przKsAtCaIX+547piZmqccGb15nbMZw+84=;
 b=qoudQij22jmlO1X/yydTWsYvcQlqEH+/X+CQQwC8Q7wQSIimQuw3L3ppt5nZtLOhM7yoxI7a0rCK8mvuKw7EyRgxW6Dc51nVSAebVpge4b6mWh78Nr3ptQjm0XNVtNQZ3A47fnoRORfJBbNbaeoa2GamgIj8stwh0yMWoZAB8TRFglt/mRJJq/KE8ZOBm+fZCTcav4I+GBEGyhZM715dh7ZzVFd7K8C5SuvISA+pnDwKAPmIKQCTq9kj9l8S+pPVAP8MJ0ojX1ufX7EZcj4CKpZ5Uz3WQl5GtGuIjx4fEw8qB8vlbTCxQyylUnN7kfUF9JGRJ/eK1nunSAo3LyYguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7MKGiOv6przKsAtCaIX+547piZmqccGb15nbMZw+84=;
 b=H4zapgettNth1y0tKAkdlLcEGHWghvxMxi0TCVMOzOAOqNdGiIY/G/9pS6lY87MJEWVL78QZ34U1qgymWVigCJEHvGfrTqWUbYbnO0lArgp19X1zghGZC5oNUugXBLbhchPuqxs9wKvF1s3n702ZDuOlJ6EwjPsKFStvPZuSrSnHNAfProuj5KlY/wuO4tKs4ZAmDmk6OieU+6/G5YR0i6Vh/GWSEKCVc5vJMqhEXuQgMQHfJLOsrtUiPc1xP5pQlyWBsnX2ChYDgHEB8rAdxuNRm1gBS2GCKk0O09pi5rS6jrHU913a4yyss+EzScZpknlSuPIcAQjbaU0yB8JYpg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:36 +0000
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
Subject: [PATCH v3 07/16] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Topic: [PATCH v3 07/16] crypto/cipher: Add GCM to QCryptoCipherMode
Thread-Index: AQHdKT76L79KHky4Rk6FQMc4ZuD3aA==
Date: Tue, 11 Aug 2026 03:10:36 +0000
Message-ID: <20260811031025.2784489-8-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: 5900cee6-ef80-4112-d365-08def7561d25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: /9yUkFpDd8DkMqOQ+g5JFcUWSCnQbUrxWalpD42RY7vMFkKnaL2bDNY0felxlu0rEdD1NDNDxpQUeXl0nGjzYauGJxbf68QnQdqYWumZqk1RdzuPxiLyOTrW/XVQWD7TCSXROIalV/Fd8CaHhr5LJXAn3NFeEq7EGePoSslb7xRNiUteyRqnCyxiFeGkj7gCNcyGfe/nwIYFzioqgKuOQ1//fJhG+x0w9FBnw/SkSMxEp6tqgxTVdlzw0QonQd0qpZXKmaGeP+NIr4RsUgEKfuJH76BbSiBK8gINKWTHbFMpmwerAprQK5a/R3LZbaJF89aLM+oKBANl3fYq33OIlO1MPlvrmrgJ/ECZrQJTulVTxTS+yDUy1L05dpTCK0Y/10DQRvFp8Xeab0ds6NY2ZWcXNbxtWvTfLaQG66Wek/y2zoF6Gnw7KUSwxO32P0FiIHlJ2dyKPmzeCBJhs/Ots3exepBKZqzp2k3xNxQRWCbgQyqL5sUKii8NBpJUG36KK/d7Bwr3VSt2Isy+FS0ttrHxyHpJ8u4kVkFxZTJ2NJmha2hxonIZTJLQlJ8o9mk/pUnehgeQO5NVJFMY25bgoTAoDAwINRBQ1a8ZxaHVqhIjyo8RZoKhe40ImWyaUoSMLSEqjZg5FN1nu3icE3n8vpjjV43Zody3u47vy7S++UkOjbdr9aTF/huAkagzwPXszLcZrY9Nq58FJt/5/vkgSZhY+nKCxUv4qYXv21XyRxiQBxyHX2W2DCUQbhNlbc6G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sA3bICy8ftd8cMCF8Yn888NbNMYmxR+rvSHJRfovYlg1lEQ+U14GxOLWVH?=
 =?iso-8859-1?Q?lYXaIbVgOBXMzr94Tql4rs4L3LbTHXnbhdETUAsoZfuwcCrUZ+5fA6U4fE?=
 =?iso-8859-1?Q?OrnY0j/SETVhy3xj6J3Z4ew+g8PNLcOa+lEzM0GgelIc8yjWZh68BPNFci?=
 =?iso-8859-1?Q?NULo58LySB5CKyc2gCfmMl9JLz9odI1SkhKNOOS3qRfLiS+fY9/L8CodQo?=
 =?iso-8859-1?Q?QbkMyrSflW0Ri/59Mj8RSwPuGMv5TnXnKVAddjBHNMHIXGHEvkpkHDrM9b?=
 =?iso-8859-1?Q?XvTHWNmuWJ3k8hCck1s8H+fkoFQzV3dfvGMJBVaue+QYeYRTQ5Af28sk2W?=
 =?iso-8859-1?Q?U3Ej4J+yk0JAd09pY0G1IBbIe2l5ymb5Omtj8Kb22qPO5dUDmhI2/c1jAB?=
 =?iso-8859-1?Q?MH1TmX/W+uUDSDMX3FD1owFeCAbzpTqsylEOh4HCoTMzR8hxeAMjPsRllS?=
 =?iso-8859-1?Q?e/AQPeny13cDVhi9MNasK/0EI+8uUi/fUriELDEqSspZurYq1mXXxABawa?=
 =?iso-8859-1?Q?RMy336ruEF4IYl4w8vm4RPXSEMYBkBX84MGDEepk0+2fK0OAY9a1+JhmFa?=
 =?iso-8859-1?Q?fpJlZ5nSChTa/0jVawOC7eKtVFvjq7UY2Gxe2p11O13dzm8H79GTaqlNhc?=
 =?iso-8859-1?Q?kiYTyvPCKZ4bAO75CfQz5Uf9JcoctFkbxdABuaz4ftytqIF4ixbvJFGa9l?=
 =?iso-8859-1?Q?TlVSj0dDKoNc8QkP9uL7Q3bk5nHj8Wuhhv0GDWTDpxj73NTxupYHXkr/7x?=
 =?iso-8859-1?Q?ED7Sh3GK7zPTlheTZrBmVB+c1o281cEl3sypu4o9Vwh6Op/fzf+xCKAal4?=
 =?iso-8859-1?Q?F+cl10otsa+V6wMvfz5r+ItbSnp4L24I/QZvUeomGlQfZE9ZNxIoSlB5rm?=
 =?iso-8859-1?Q?PlF4aeFF0+1Z/3OKyfEEUBGyaInAv3ImoNfDkHTWvosAYMqtT/soKcheLf?=
 =?iso-8859-1?Q?s+nmr9vvhF7x/7h4ekR/8LZVwji+uJlCCq6SveiIQKAs+zLiYWX5DOjEfl?=
 =?iso-8859-1?Q?GmeFhsoStodMB3csqkipQVoUrNPrSoh+9MEmF8GPiQJOzEk2QzXGvioYgY?=
 =?iso-8859-1?Q?HsUSY3Z4m6ykf+ZOyCPink0MuxtseyewOxdJK/Wkzee4sXe2mWILrZ+yNO?=
 =?iso-8859-1?Q?SAWJHgBFw/BIzdUvfyB0gz5b2omiftOKTFq7F+5Ed/Yo74iNPnuTpCSIaY?=
 =?iso-8859-1?Q?vtjWZr1d6Xuko4bagM3ZRC8r+uNPdCMUu6S0jxf0L7vQLSfU9+FhdR+HGZ?=
 =?iso-8859-1?Q?2I+ePIDoQ9CKSLsuN4oICE6mAkMXhheyQh3zV+2nAjbeDlW7UIT+xGLdLT?=
 =?iso-8859-1?Q?dIsOwdxMXjwDLJfzYraz+fC0He69sY9a+z5mQJ1ZyS/3An8lrONV+QOOoK?=
 =?iso-8859-1?Q?nLXx40okuqEq7idZuu0EEqYwm0wgOnahxCRXT4mnjxyNcWGxTosNhKpQYk?=
 =?iso-8859-1?Q?dC3QAq80XgJ4k/Tdgrdd4A6vKjtRnU+GnpyjtPPac6WAO42EuCpDzqPnd4?=
 =?iso-8859-1?Q?x4vD4NHnC1aT6wuERhsJy1HbqD957eF1bArtBkx+Wn4K+37VcaI3C3Z7rI?=
 =?iso-8859-1?Q?kNTBLGAGqqr/tq7YwZ162MT2uGeVgzpbt07LGsAjzwiVWA/mCtvxC4H/TL?=
 =?iso-8859-1?Q?6qWvV9WXT23f8mXyNMSjkpf6bwCrkMgvhPtGgX57T/LVyDIuWiO30Jv2y0?=
 =?iso-8859-1?Q?qNnuPotKhU+6z/fPzLiyhoz00btvEZflQmZ4kikjHdBffcL2vdgu27VpQK?=
 =?iso-8859-1?Q?EJxS8jvCxQDbFQIieL/Ksagj56V/x6TJZDzCKWU6KpbXpwiCM/v/Uv+9rs?=
 =?iso-8859-1?Q?AnY60J45Yg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YOb3qe+Ho7aY81WefifEYwh8xQ4f+E/Q84HhJ5NHJ/jPXBADg5MYsdu8maubtHMeAnyHYifBqmpyjXeHzY/6TtvauH/pSAuYiaitoSMdZSY8+c3ZvMWOjlO9X5RRi54KXoS0fkokufdzatJpoz8OHcM09Cs5aCLhGATi2MSN1ixYwMnVUtS6xMXncm20BwEuC81wbSFPyTAN2jY6kODTRtHE3wXtbRgy3QS0QmEt4p+1MUHVHhqC/kMzrAkOmx3ngoc7eKSf4J8y2/D51pqo5CYAqAqoOIN+JFEpLDu+sJhCJ3GBPqYBt6H1MYSDtlXHbieW2+7CdmdNjniT1YYwOg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5900cee6-ef80-4112-d365-08def7561d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:36.0845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9oyUMXXR6AKT4wTM08N62fW2sPNkQhbi3le+tCldWGMrxfE/pLbDxYrACPQhWg1edPcuKb6Z5+FbXDxJ1BuYWutaZfuksA+A5impbyIan4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

Introduce the GCM cipher mode so authenticated encryption can be built=0A=
on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so=0A=
register it in mode_need_iv. No backend advertises it yet, so it stays=0A=
unsupported until a backend and the AAD/tag helpers are added in the=0A=
following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
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
index 229710f76b..64c2339d17 100644=0A=
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

