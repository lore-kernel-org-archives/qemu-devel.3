Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73814C5B570
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYZ-0007Rf-OO; Tue, 11 Aug 2026 02:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYX-0007Pm-Ov; Tue, 11 Aug 2026 02:01:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYV-0002cm-Sk; Tue, 11 Aug 2026 02:01:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDeX55n8hW0CjzLzwlgIYiDifQYNZ0CaeJDEAkuh86Jos6q8K7gYy/zyoZ5y8h3/+gRkBKJUP3UlrXDF1KJVIOMPGDqLtYtR5eHq9uv0rV05lTOLv8XXWNSe25Kow345rrOi2Pz+C1LuqfV0rwqAmqr1OZN1t5BJQ3HCarB2elvLojsQetWcbuLe8/C3LEmHYOrc5sud2OQDiBQr573B0+U5E/ZBC7PZUVpexhxdlFMYOTWNXegdPUmi9gt7/e04Fyr5baBG7A2yLITgTp0l6/cfni9qKK3KoT+QgWKbvqyyjf3O9dJgzLNY5t+wE3HW1v5dkJWiVA6IfpbGD3VPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MExgluedEg6+JvI+ulgp6DQLZn4mSeKDSDWwe/C/N/Y=;
 b=yqW7Du/48BfL9e4BQpTnukwlC/JhVJ2S8mVwA72i4Ym7Lw7elORtGBZjNXD7t+iR808QvqC57QcsDgBCtZZ/z7nqamnEx6sXtLXkx6C/bqwNbILsbHXlrHgtHoZg3XYXNF64D4IXKTY1URucZNQ6vtkopQDQ9s2DzazaV+PsWNBxMMdSa9ijehJApNusPIMgFcM+sDWlYvPSRepuilZ1b5xd5Sv2eqb+0LX+nlqO1lhp0E3+qJutv9K1p6VefL66uxENkG3ANp1XyMmUgSa7lj6vCzhNo2Cv9RK1LnG+2eTstNZT1QTRqMHpxk5Sb4gU+CYDaLw1k2wWLBAGm74njQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MExgluedEg6+JvI+ulgp6DQLZn4mSeKDSDWwe/C/N/Y=;
 b=h0CnGVDWTZLOKzgEVzaj98Lx1bLG+HYS8/sVCpUaOF8IayaoVUbbqBfbS3JXSSQnnhGT/sTYe8DeKZpGq7tbixIfXgK81UDD8zecxXQXBaIeAvdrvrBrZzeBa8XmNxwhaR0x3cFwCLLo+v2m/hsS6lBaYoK7x8IVIWAkvezYoCLHZcNMSuRP04K1TUeHlz9n5U1e65/3DWlp+DV2J/eRm9adHLgRsSI+GhEicmztEFzsZUb5znlAg/ouNHifDXSLSa39s/pTOfcRU5dRStQnwsdxefibvU2StQJRJhyMnOzBUmGiAKzfZfIXGrxZGtpT5OgTvpdbmLlgvmjUnWnp0w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:30 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:30 +0000
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
Subject: [PATCH v4 09/16] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Topic: [PATCH v4 09/16] crypto/cipher-gcrypt: Implement AES-GCM
Thread-Index: AQHdKVbZJiHeDaPFo02mMoy1BgbH3A==
Date: Tue, 11 Aug 2026 06:01:28 +0000
Message-ID: <20260811060115.1849266-10-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF7489084AC:EE_
x-ms-office365-filtering-correlation-id: 50f2a26b-a61c-4f4a-cb13-08def76dfd31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: QI+5bByEMzS6gQt+X2/P9k++f5dNsLrfT0m6m8rrJCHdaMovQmNnU5ziAUT4MJSnsjSL5kIrnB0LhzeXBDihKKYTBY4AjI4rcfTO/mFwQSkRtuq8xkfT+yvPPvD0cLdjUZngDEbwJQ4SpUjWWCmXGkOJYn3onZg1X1LtMkuxjuTmrx4l0i8pchTMqJIXFyLoYRGRBu+Iv2jtaG9xregg+L8DtR9GmaIZebb/IlYYPBgi2NcRMOSaqKMwqlf/67Sg2MN+6uTZ5/rIH44Bw7ihm59hXveNIQrvBPrNjwxue/7S/ZPd2rHSqdannld7cdE+UktiM//H+f3eGRrspthGZvwPvmCMrm8d5Wpg948N3rzmt0oHpFLA6lUu93nQaR545JyarB0+7sLyaVZ8h3MP4gP8s2QWfs6pjHuWQYJNOAwE3R+qQaN/z5ZduROgOhXv8y5JsMAul0aJnL+LWfg9mMNhzECkVNF6bVwEo8ZvOpGskbH9xSYm1Am78tYTZztoCt0gzzeuuaDlYHLkz4uarx2ApFsfU9OyLXaHbP3J/4E9fViUahp93pLYsYx7K3o/87IuBaM8slMp/ePiy45wZqXdta58Ml0IMtLDsXIP9tQpxhnMUIjDxOQYQ2YqswispqgTnIOkKc07YjaONC9t+010hV3GPNg3l32SMNU0rVL6Q5Vawi3un2LsdDxTGZcFKQoB2te3dpGQO8CYEeSm1X9cM5kjktQtv+/7HD7waURCkfD/QTacQEvxm+468CeG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dPqteY332ugtknnx17ekeUO/CM4FK7caVC+wiUZtHUBChWOXJezvJcXQEf?=
 =?iso-8859-1?Q?jaHusz7JoY4nlwZwr3zDmtbVUzLAi2i+5VpCtg6qQBzKde7XFU6q+6pFbM?=
 =?iso-8859-1?Q?nX5yG6ld+S9tMb6pV7JxFBeO48bc+PHSo4dyiGHAI2ZvOBHNGu0Z50e3Fi?=
 =?iso-8859-1?Q?8k2fMlUy8AvHfZ0ziwNf/dS7bakafiEOBgMiLrTL4wL8rkE6Lb+afYsbez?=
 =?iso-8859-1?Q?TZXKS2ovpgxInX9H2yWLiLXEvzXbmwSpR2LIA8QZKpfJj3pE9NJ61PYuNE?=
 =?iso-8859-1?Q?5UCD5S8dJpjjwPG/sJAI4bZitclcUfmF0LfaTD+0OsbMxVt7er8PTZMZRW?=
 =?iso-8859-1?Q?kJfvs0z3LOLSM4wOQKR0kgZ/qT9poqkTx8lkEB1e2NTjUSJG73cAVlxFJg?=
 =?iso-8859-1?Q?BPt3R4VnfPMwsbCSgUjSS50JTY1Xfhb4QHGLpx5/3BsOXQ67FJGKOHxPHq?=
 =?iso-8859-1?Q?Jy/Rl6OYWvbBmIzfn5zRM0kezTLBlPvsM3JoyYqYaDJvT8dDyL0FTyQ4Wz?=
 =?iso-8859-1?Q?q9qm1ifUDtMrBtxM4sa9hDzwcKWCVdiCyQa5u6rnXyTaGkskdc9VgXKAhY?=
 =?iso-8859-1?Q?qulhztbXOy8StOIPuqrjJMDJnk7RH2O1fk8Jt53l01k4QlvlqeG51kjUFt?=
 =?iso-8859-1?Q?uuwoMLn6XOf8Yc+L3q9T/+ATw7I81EkFGv03spLnXqXlpGdNN2DKLOAhel?=
 =?iso-8859-1?Q?dxN6PEKK6N31d/VBztzxP9ytD8VHaEsK0NNGN+A9E/sPiHiA9S7pddN/A6?=
 =?iso-8859-1?Q?3cDzFE0vMRPWOd5jGJfmVppcqwS2/f8Zpe7q/oLJ863BIKlgPvh+QiO7A/?=
 =?iso-8859-1?Q?9MfpG2/aDjmC5T7mAFC8U3vZPS/C7IGKJh/qYG13lVw2Pu14HYKq21IHa2?=
 =?iso-8859-1?Q?FhtLlhhI28/hhKJTGxT9IkXxQ2S1l5gwxZiRnPkvHdpN8ZzORUzj3UZaK7?=
 =?iso-8859-1?Q?Cj8e+h/+EitF/FhzV7kL28IGJjwZwegUU3mKUXXq/OZ5mwL3+SMNIVv4cb?=
 =?iso-8859-1?Q?XC4KMLlSbJAHy/6EBn2L+RTcFR1FTWb8RL01EW52vD6LP6RdnJ7m7SMl/i?=
 =?iso-8859-1?Q?AMZ4Mw1jOgj0tm1/xEW8J5wIpS7rHRkNDnF5b18gg0D/iSA8w/S5wowNyT?=
 =?iso-8859-1?Q?aoHhJG5TmnVePh4R/RVs4rnT4KNNPKJ+8uS2E1bIK0NIbnyRbTrVLV4nX1?=
 =?iso-8859-1?Q?hJ2pHfk2Uq1xeOI1W9TwpBIR6cdhiDVv1GzfoydRFh8zCXyya56vuGV+Oi?=
 =?iso-8859-1?Q?G93v5kX+cYSTyQuTHF+77W4/t8TxP2eOqOVEXuIJmEJQfI2o9RlXwXkp0C?=
 =?iso-8859-1?Q?lPm8VOO6Po7IXcMfr2f+fZhKkRjNOywRK3XIecwwraclwYdTuCXyXuSWPC?=
 =?iso-8859-1?Q?XvBHbu5uR5742dJQrVLA45n8Igfl8gaBVfLO3UuEDWKTv/gl6rENhKniX5?=
 =?iso-8859-1?Q?dtJqVW20Nx9EDCOAFtIq1DiUJtiyi8NycLGvSccvCq9CUYz5vKueS3AzQY?=
 =?iso-8859-1?Q?xOSg3LqdbSHkoBaT82IsDlnLYqluEeJUtv0YSKyKg62D1oAlsTGn6HSBUL?=
 =?iso-8859-1?Q?fNESlfZyj8ecgkqvQm0r6dHanY0+GeM9WZkZWh+hJSYxCT16DuxPpAKEHV?=
 =?iso-8859-1?Q?R0NFgZ89ByYcfGBf03Lbv/SDs6Coxj5aHIc+VNPtwlw0pQoqPxaDoQNNYq?=
 =?iso-8859-1?Q?0h/LdyBZ20YcxIqW2E4AZ1OPq+wqAchSuXGCbt8B5RUBkQd2QkODqFD7Ko?=
 =?iso-8859-1?Q?KlJclLYZiI4l6/4xjXy0IQy96qClK5S1cgjlb29jSl+ThwG1hfWtiCvcLP?=
 =?iso-8859-1?Q?YrpCwWzKDg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iYynu/4wNreR5P8if7C2TgrvvypX3JsY+NzooOZw9DCERZNRupJOwUQo4YMVx4/EnM915w3ZCFquCmd1pekoPbYVGCjE3aIqThBJkkiGhHeVksfteN/MK0z4ke8izuV6fUe4bNgCUD+MxJFcBZ9DVK7ViZNbufF38QCfG3yHQgOr9Uxl/ulxdJ6jhr6UCt6xGn+T/czcoxSlteKt2ye/hbi9757rqOCSIls+UCMgXV3N7mTsCSDYZyc8wIevljLZmSSDsulrYe5yF1gvjx5aaM0d9VuU0YAxgD+oaAjWUr0lOXQEDUQcDTsBEsMGrDg2OyUTEhZBLabKAHPvbqXzSw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f2a26b-a61c-4f4a-cb13-08def76dfd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:28.9528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrQgrGDpm0KRncxjisHOeXBBBrUJkOqnkOy8G/1M+f2VYoaehJo4RRbwaQ8WBMSXV7hd4cSSluvTQcpSt+P2pYVCMpsTvxknbkD8SA2Mkog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Map QCRYPTO_CIPHER_MODE_GCM to GCRY_CIPHER_MODE_GCM and advertise it in=0A=
qcrypto_cipher_supports() for 128-bit block ciphers. Add a GCM driver=0A=
whose setiv accepts the (typically 96-bit) nonce, whose encrypt/decrypt=0A=
do not require block-aligned lengths, and which implements setaad via=0A=
gcry_cipher_authenticate() and gettag via gcry_cipher_gettag().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
Acked-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 crypto/cipher-gcrypt.c.inc | 101 +++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 101 insertions(+)=0A=
=0A=
diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc=0A=
index 12eb9ddb5a..fce09a3c77 100644=0A=
--- a/crypto/cipher-gcrypt.c.inc=0A=
+++ b/crypto/cipher-gcrypt.c.inc=0A=
@@ -65,6 +65,8 @@ static int qcrypto_cipher_mode_to_gcry_mode(QCryptoCipher=
Mode mode)=0A=
         return GCRY_CIPHER_MODE_CBC;=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return GCRY_CIPHER_MODE_CTR;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        return GCRY_CIPHER_MODE_GCM;=0A=
     default:=0A=
         return GCRY_CIPHER_MODE_NONE;=0A=
     }=0A=
@@ -104,6 +106,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,=0A=
     case QCRYPTO_CIPHER_MODE_XTS:=0A=
     case QCRYPTO_CIPHER_MODE_CTR:=0A=
         return true;=0A=
+    case QCRYPTO_CIPHER_MODE_GCM:=0A=
+        /* GCM requires a 128-bit block cipher. */=0A=
+        return gcry_cipher_get_algo_blklen(=0A=
+                   qcrypto_cipher_alg_to_gcry_alg(alg)) =3D=3D 16;=0A=
     default:=0A=
         return false;=0A=
     }=0A=
@@ -228,6 +234,99 @@ static const struct QCryptoCipherDriver qcrypto_gcrypt=
_ctr_driver =3D {=0A=
     .cipher_free =3D qcrypto_gcrypt_ctx_free,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * GCM is an AEAD stream mode: the IV/nonce need not match the block size,=
=0A=
+ * the message length need not be a multiple of the block size, associated=
=0A=
+ * data is fed with gcry_cipher_authenticate() and the authentication tag =
is=0A=
+ * read back with gcry_cipher_gettag().=0A=
+ */=0A=
+static int qcrypto_gcrypt_gcm_setiv(QCryptoCipher *cipher,=0A=
+                                    const uint8_t *iv, size_t niv,=0A=
+                                    Error **errp)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    gcry_cipher_reset(ctx->handle);=0A=
+    err =3D gcry_cipher_setiv(ctx->handle, iv, niv);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_setaad(QCryptoCipher *cipher,=0A=
+                                     const uint8_t *aad, size_t len,=0A=
+                                     Error **errp)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_authenticate(ctx->handle, aad, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot set AAD: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_encrypt(QCryptoCipher *cipher, const void *i=
n,=0A=
+                                      void *out, size_t len, Error **errp)=
=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_encrypt(ctx->handle, out, len, in, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_decrypt(QCryptoCipher *cipher, const void *i=
n,=0A=
+                                      void *out, size_t len, Error **errp)=
=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_decrypt(ctx->handle, out, len, in, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot decrypt data: %s", gcry_strerror(err));=
=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_gcm_gettag(QCryptoCipher *cipher,=0A=
+                                     uint8_t *tag, size_t len, Error **err=
p)=0A=
+{=0A=
+    QCryptoCipherGcrypt *ctx =3D container_of(cipher, QCryptoCipherGcrypt,=
 base);=0A=
+    gcry_error_t err;=0A=
+=0A=
+    err =3D gcry_cipher_gettag(ctx->handle, tag, len);=0A=
+    if (err !=3D 0) {=0A=
+        error_setg(errp, "Cannot get tag: %s", gcry_strerror(err));=0A=
+        return -1;=0A=
+    }=0A=
+=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static const struct QCryptoCipherDriver qcrypto_gcrypt_gcm_driver =3D {=0A=
+    .cipher_encrypt =3D qcrypto_gcrypt_gcm_encrypt,=0A=
+    .cipher_decrypt =3D qcrypto_gcrypt_gcm_decrypt,=0A=
+    .cipher_setiv =3D qcrypto_gcrypt_gcm_setiv,=0A=
+    .cipher_setaad =3D qcrypto_gcrypt_gcm_setaad,=0A=
+    .cipher_gettag =3D qcrypto_gcrypt_gcm_gettag,=0A=
+    .cipher_free =3D qcrypto_gcrypt_ctx_free,=0A=
+};=0A=
+=0A=
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,=0A=
                                              QCryptoCipherMode mode,=0A=
                                              const uint8_t *key,=0A=
@@ -259,6 +358,8 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCip=
herAlgo alg,=0A=
 =0A=
     if (mode =3D=3D QCRYPTO_CIPHER_MODE_CTR) {=0A=
         drv =3D &qcrypto_gcrypt_ctr_driver;=0A=
+    } else if (mode =3D=3D QCRYPTO_CIPHER_MODE_GCM) {=0A=
+        drv =3D &qcrypto_gcrypt_gcm_driver;=0A=
     } else {=0A=
         drv =3D &qcrypto_gcrypt_driver;=0A=
     }=0A=
-- =0A=
2.43.0=0A=

