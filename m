Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D7C5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoJ-0000zs-TG; Thu, 20 Aug 2026 23:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoH-0000yv-D4; Thu, 20 Aug 2026 23:20:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoF-0004BJ-Ri; Thu, 20 Aug 2026 23:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOUeBpzhEwZzz+H+T0+W00Vfa30vbZRUCAdl1gHrGGuwW4tjX7PHm90chQj4ewb3uDU8bLFRLmh6QS9nAqVwGwzlyOZFAbWIOB20lmnIaWBpLsymas36vq/tmLR3XIAXmGSfHG9rQ2xSRmxf4PbVQnwskcIUwlnjnaGGqjrqebbPphzwUCo+jo37OtRQQK+XN/qUUYob3wJBHnCM6kSlqUAttNdJrAEzxQdWIEDTZp5N47bdNeg2SJ0wFW4h+1s5uE6hwt0vYPMhtDUI8evGyk7sX561js0jaV/KIMPMAOeyA7qL6zZX0Y37SrA/p2xNLJ9TB0gxMYva8YapnqEHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XT8uv1IXeVHpY6PJ3jG4pTzqyXPhLWRujUbSIHCQ0A=;
 b=CeMA3H29VvjTgQqCeYy2cBSU8cuE6u8qgSsvrCGYU3wFOhFIT9c2aiI3XiXuPxVRvAGekgtM+62rTHkIKzsgBiBLFPLPLyCVFCDTqYkGtIN1YL1dmhspg+r9HklLzCdKmHA/BT+zILfTl/Q5HFHGb+LFi8920GD9MdjSWjOLSJOZmP6BLPu8zxwt5hC5MjFKNHjgOxnkZPT36DC+mDusIJcjIHgE5o301dw70P1QIn2ndLJm7motDrQc3d4NkL93oDmDHD9n/LQMpbitIc8AQBpv2LgTh/zRvFWeKch5It6IwCf6g7O+K+a7WRIYONtFp9AhngBBCzI1OHz3b1FQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XT8uv1IXeVHpY6PJ3jG4pTzqyXPhLWRujUbSIHCQ0A=;
 b=hME4etRO0QvL93ERK+Xn2rSkYzndqdAcwsdJH9otk8IANd/hmttlYmRU14F8iwNObQ527Mlsw3YnLHVjZUJ1fCD3tnsSkhjQg7H8iEvVukx/36P9DdZf9GrohtVpNYAn/fOWEwS+3ffHARR4CvNYdAJ/8Y33KoY/aFsG90hSMbzv+wWt5TflLfBj5tqOtfhrZBaFeUAO0nQ+JliswzTxgGinB9CCdCmFEJVOOUpaXmmzrduxClDKwPXs6E99l3+jzEAw4xzYI+7edLPGuAQpSQcrTLV/i35tt5FCjn1T9P6BzCytKZsEf6JAQuBtkK5ye4oigfzp4pPvxCcImHq4FQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB5467.apcprd06.prod.outlook.com (2603:1096:101:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 03:20:38 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:38 +0000
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
Subject: [PATCH v2 1/9] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Topic: [PATCH v2 1/9] qapi/crypto: Add ECDSA algorithm and curve id
Thread-Index: AQHdMRwJ5OJXewnbwkSaadP4CKbs5g==
Date: Fri, 21 Aug 2026 03:20:38 +0000
Message-ID: <20260821032036.1829294-2-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB5467:EE_
x-ms-office365-filtering-correlation-id: b76d5428-c9e3-4738-9a91-08deff332c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|921020|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: A8YlTa2htTNgvSRxY/fCJ84d+YUIO+cYcGPr8XhhZaXekg9bA9tgKB2UF2hLjT5OjRvbPqVt/vkAW8s1ZUofX9GPBaAR7t16gB4K69kK/oBnPvPe9g6jWPjhBkuD4GGPuXxkaOvWabwtDNr+U9Yd7na8Vm85ksjSZRVNhqh5Kx+Ee6dsqnBuy0VPfb7+D00CQdq+W0zJ136fPD8vuNmovAyCojhipTobyReK0WQVtRZN/Dz8TV9VezawyOTFStE2XIF47mkWzUE7Rje7hqkP1rRTxAPARqlPlbAopPAM1uJzcPVzTsdpbQov6gYdFqF0wkD6wqcRL9BLek/sf0PzwSptqtcaP3q1rzWoCdOQnHpn0xJbhYHToZ2/XIKpBPmzCkBHzggfAkOE5m4kTKCvPGevCxP2YyPXuclba62G0lWMrsXWmvOhqAmrNAI55pvHjLlXMZUn6SEAe5FsoQI8Rbusv3NLTz8WJRqiRL+8uEielgsMwB9ovSlRcGqDaswDYjjWu7Krf1RcvX20PBo99g8icd6/U5wxEgDuDLM0gBrtcI1223k3ShCWB+L8an5xAJsX075ceN81/nJKIJDsdN2auuhLleXw3LENwww5fimX8H9PTgkX4yutdzFsS2N3nYL8zBwSa6Y/4gaAX38I0TRh3XwmPGcxQXpUJmTZr6FgbOBKAxqzR8ySL/+nC80Oacl7xyWwiYDI/sPVTQF8gUYURtqL5N1+XifprtEU+4m8oJRPjhospYngMvOHpVRa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(921020)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+6DQ0+n4pevD8P0iaLNg2owzvmbIJdIclDirWZFBSeiDhbMsiTGTutva6K?=
 =?iso-8859-1?Q?YqW8ZfFjg64w2xyHMHzLnwij+++7WqnCPiqAmAokF23UuarCbHYF3yzPEm?=
 =?iso-8859-1?Q?mNQfCFGcqPCV5GLECpBBRs9ecm6EP4L0KOQ3PAH2b+WJNDLpZixkGElSCH?=
 =?iso-8859-1?Q?fPfSW1bP3RfwxZ0htpX6eduPgeLDcn2Bf3SB+VKL/JLppw3/3ECgAmca4E?=
 =?iso-8859-1?Q?9ivfBw7KlbOPuyGXnV46TWyuxPrepoCreQxDzfzotM3+pEo3Q2EzbEZkwP?=
 =?iso-8859-1?Q?MCIhu9l0LsBKJg2L7tu9VW/lu7qdDtjCy/jWT8/GLybJSRdVNIe0KxiFdr?=
 =?iso-8859-1?Q?Kyr35hXf2Fwd5MKFdsPy1ocxVO4y5CDXFKlSTbDYlr5EYDSoIDpGBsBUkw?=
 =?iso-8859-1?Q?de12vhbyJoxZMO0p1ghfDgL726qAqbGgTOUln9Fqzi19gzHmqnjiE1cSj3?=
 =?iso-8859-1?Q?i9EDQuNH5lcFaa021TfsBD5LCeDTbZt/+vcyYMub1RfcLfBLfmGyuB3Qsx?=
 =?iso-8859-1?Q?6PACpKkoRjwHcoSeCp4MKW0tTpPm3/jD0vwv6OTt//nEHGLUWxZL/EcFgj?=
 =?iso-8859-1?Q?GBMJjb4YoC2Oo12o7dTF4y+NCA2PRuWXX9+/OytoRvfA3Zqd+ygcK+F88O?=
 =?iso-8859-1?Q?Z6QoDMrDohxElfYjxuMy3jbZQCSAR420JfWgAXzRiPczsPmYEopqUJd78K?=
 =?iso-8859-1?Q?NbFLEZXBr03vjluNrn6r4Hsd72lNRUDCzD5qtzk1ivOdADFUjMjXT4X7mm?=
 =?iso-8859-1?Q?I14+bUk6abiHBsypTRqmwJN824123JV2TJWyfAz06qQJb1IRD35ePnXP9u?=
 =?iso-8859-1?Q?7IeVGlBXhsHyU3e9OI/bH58hInl/KYCnEG+HRuNXJLEOilsYyuvt99MX2T?=
 =?iso-8859-1?Q?Ir2LnuuDXnE13tJ1JYsz51LWtfd/wMP9wsC/koXgOrsKmCV/WolGOkfg0I?=
 =?iso-8859-1?Q?5fNHnezYSbDAlovCxGDIN//ddGpjgHDvLrrcW7Shdztq8IsZBnJLNnivVl?=
 =?iso-8859-1?Q?jPpFyY59xIkdOgGTaTkTJRGkgh2lhL6RfMZpZgLiCIPxtY7cZ937ht7tVB?=
 =?iso-8859-1?Q?fwMzp706CTFwenbScluPwR4BP+40UrFqUYqkeWlgKZJ7u0N92Lm9SG2aRp?=
 =?iso-8859-1?Q?26AFz/jt3vGEdfFe3dwL9KgMKcBhquv1I6j8CHr93gbtHCdmMAboi8AmCE?=
 =?iso-8859-1?Q?o6Wc10Z9OlNJlRGjV/faZ5s0oANyZwi+4ckh43Bm4ovHU412+xeJZnLiMW?=
 =?iso-8859-1?Q?LmA4r5FyFZNX3O/WmkSgtLU6jiG9tx1ao4gdiYHp9+Xr7KDDf2rDLoGMlA?=
 =?iso-8859-1?Q?BGM6ljkrfUVCpdUH5RUpey79CirAloNzjvF88otiZNfp76sIT6l0aMod6P?=
 =?iso-8859-1?Q?PCt9lPfyJx9GGXkJ6ouhh94271A3s9Q7Kjdtpsy0hFp+evAGqQG+XXjaqQ?=
 =?iso-8859-1?Q?kvq7Y1G/zV2/KEuT5TmbLHc5ZZgh/BrTtVOx9GbCaz105uHD5r1Dl17YJ0?=
 =?iso-8859-1?Q?tsuWV+VoW+dGEBNxxeoNBRtpliJ/+NbLgpZkfkp+E11xpav4umgtLAUupW?=
 =?iso-8859-1?Q?sCiR43y11xVHCCJo+SqVXk+8AZMT9MlLQVgOMnfrByBzaOx9sJixvosvx4?=
 =?iso-8859-1?Q?arAFtnr9bMSM2ggseduVNXqe1DDsx9QRajdm0zjEYO0XNISbt7KMS8rrFm?=
 =?iso-8859-1?Q?nndOK9lgljxKq1gE7AfnDzwmQ1LKPyFY+ZSuzMGCPSRABGHu5cM/bBp/z2?=
 =?iso-8859-1?Q?k2XpAZOxJD94o7JYNx5E1O9AQFfq0pBDzX0DQcHpxkZBR7IItFbkEx2C9E?=
 =?iso-8859-1?Q?HChYlcPjZg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o8I72pUm0mr94BMTSjyAGqqsxW5dHbpu7eYZe3Gu+n1zWxF6ptLVxjHs19h/VBewp/EuyHAoLjcK3PDW5xxyImaXOH7KxmEFUj/oyli2SViBrybEaxkT1GHtea5JZl3/ewcxZ7gupFubsvVgIyI1fASMhyDIgKLrzyz5GNX9fi9gruS+Du4ApOzSEtPXN4vdivUnAwKB1cl3KcFTlHlAZ1nt3rxRmY2wA3te2sr96eCmoCHQ6n9+9W4kZec5q0jdqfAWYyQeClIcO06loibM5S5beBP4V5GuXxG1eC6197yxSo67Zv71KdAAe6D8XlJcvZV8Y/w57q+cW4ElJURziw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76d5428-c9e3-4738-9a91-08deff332c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:38.6123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nX28V4JnVFz5CMLaVH2cVmPZXL7VEyC018P5dei2jt7kdGNIIxNuUmBmbgplYs9dXowO6j7L8T1omHm12fwpVeGZ1uGtFPLLn+HjYT/JCVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5467
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

The ASPEED AST10x0 Secure Boot Controller has a hardware ECDSA engine=0A=
that guest firmware uses to verify secp384r1 signatures. Emulating it=0A=
requires ECDSA support in the crypto akcipher framework, which today=0A=
only implements RSA.=0A=
=0A=
Introduce a new asymmetric cipher algorithm, ECDSA, a curve identifier=0A=
enum (prime256v1 / NIST P-256 and secp384r1 / NIST P-384) and the=0A=
per-algorithm ECDSA options. This is the QAPI groundwork consumed by the=0A=
crypto akcipher backends in the following patches.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Acked-by: Markus Armbruster <armbru@redhat.com>=0A=
---=0A=
 qapi/crypto.json | 33 +++++++++++++++++++++++++++++++--=0A=
 1 file changed, 31 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/qapi/crypto.json b/qapi/crypto.json=0A=
index 6e3a98ff68..cae2c678cb 100644=0A=
--- a/qapi/crypto.json=0A=
+++ b/qapi/crypto.json=0A=
@@ -557,10 +557,26 @@=0A=
 #=0A=
 # @rsa: RSA algorithm=0A=
 #=0A=
+# @ecdsa: ECDSA algorithm (Since 11.2)=0A=
+#=0A=
 # Since: 7.1=0A=
 ##=0A=
 { 'enum': 'QCryptoAkCipherAlgo',=0A=
-  'data': ['rsa']}=0A=
+  'data': ['rsa', 'ecdsa']}=0A=
+=0A=
+##=0A=
+# @QCryptoCurveID:=0A=
+#=0A=
+# The supported elliptic curves.=0A=
+#=0A=
+# @prime256v1: NIST P-256 curve (prime256v1)=0A=
+#=0A=
+# @secp384r1: NIST P-384 curve (secp384r1)=0A=
+#=0A=
+# Since: 11.2=0A=
+##=0A=
+{ 'enum': 'QCryptoCurveID',=0A=
+  'data': ['prime256v1', 'secp384r1']}=0A=
 =0A=
 ##=0A=
 # @QCryptoAkCipherKeyType:=0A=
@@ -605,6 +621,18 @@=0A=
   'data': { 'hash-alg':'QCryptoHashAlgo',=0A=
             'padding-alg': 'QCryptoRSAPaddingAlgo'}}=0A=
 =0A=
+##=0A=
+# @QCryptoAkCipherOptionsECDSA:=0A=
+#=0A=
+# Specific parameters for the ECDSA algorithm.=0A=
+#=0A=
+# @curve-id: the elliptic curve to use=0A=
+#=0A=
+# Since: 11.2=0A=
+##=0A=
+{ 'struct': 'QCryptoAkCipherOptionsECDSA',=0A=
+  'data': { 'curve-id': 'QCryptoCurveID' }}=0A=
+=0A=
 ##=0A=
 # @QCryptoAkCipherOptions:=0A=
 #=0A=
@@ -618,4 +646,5 @@=0A=
 { 'union': 'QCryptoAkCipherOptions',=0A=
   'base': { 'alg': 'QCryptoAkCipherAlgo' },=0A=
   'discriminator': 'alg',=0A=
-  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}=0A=
+  'data': { 'rsa': 'QCryptoAkCipherOptionsRSA',=0A=
+            'ecdsa': 'QCryptoAkCipherOptionsECDSA' }}=0A=
-- =0A=
2.53.0=0A=

