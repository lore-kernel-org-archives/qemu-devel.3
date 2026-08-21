Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDEFC5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 03:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFoI-0000zI-DZ; Thu, 20 Aug 2026 23:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoH-0000ya-2q; Thu, 20 Aug 2026 23:20:49 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wxFoE-0004BX-LL; Thu, 20 Aug 2026 23:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQ9envn32hlmSaiWbiVT3chq2yUyEbtM/6UJ+we2Uoyfsvj1lp8HG3kefZY31U52bN8OvceCo4hEYsJsYU7PucfiREzZYCJbNkorcwsk6lIP1XlvSGYvFA8DaOSjDYC9Av2GP2Q7+SJnIhRALM+UMBH2WYbhpO+YrdoBn9hQT6LH2FCVKZntncEoJqcy2KX3pTjP2Tpw5AMM3yrnbeERJ4L/ybobDyXP+QLkKGSRIfDHDtNr+XvzvKFUjegkNFEqQ4KVshgHNUpdoiL3Z6qP+WB1S9t3hTkRRGYN0y4x1GWfqNt5kL8omvL15r8jyzMKpWbvA4w0Vexq2NIvs0vgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcByvnrGLP92P0qbtGMT2jHiQaWvA8EyI4SGOW3tTQ8=;
 b=ewv1LUwmdPwenoN8OM0LbN8htp0+ApKQ3rQUpA8N6YcztgB41BHSroOrEqGKKsMc2aYp5brZ6WwvsGEQzOtgUUv7x32XI2D4S6CZkdog5kJYpNUKKUifStZdpIcDLpVwlcB+VuudRIog8zZnQe/FEhLKiUbsrtYbSxtPmCJUyEVH4H2Pv3HjzVKPZhlPuXVt28wOXTr6qOU86RUGCIbF5LiMuHFlFc4FIsWrkcNw4jb2BZptMmOrUa3PS+Kas5IeIqH+QSHCVkXXBMCn+sxOL2enkU/EsRZVP6yCBHnTJhtevV/tzAx7tAxehnbhL+B9PnGSYqAYWQZqdfgONUCYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcByvnrGLP92P0qbtGMT2jHiQaWvA8EyI4SGOW3tTQ8=;
 b=V1YZGMUgMoFHv2QXyJFR6DW3/B4ASt1bS7ZMR1ZS/K99wNs0TeglGnF7PTK9t2y1smO6v7GBpWwXhbtQ2r5Sg+po+k2mJJrq2Aqt+6kYBA437JCWYrVUbXbYib76YkT5RJQitKT5LebNfQIQiW8E9lAJIY/zEtqmTIaGpNjkCBnrazEl9+T9bs+0tlXyz+sAxBMdl+foKfmdWDVwXkFfM+J4ZHRNkdyKCLBVL+5hPnvv86P8SN2aChohfdFY3MdWFsp3y1lFI+ygU1KDhC8PTUW092soUO/sqHJTikCc66c8q0vwpiM6/wP0WzJPI3FTzpI4Ep9hAt77vITY53h4QA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5146.apcprd06.prod.outlook.com (2603:1096:400:1c2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 03:20:40 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:20:40 +0000
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
Subject: [PATCH v2 2/9] crypto/akcipher: Support ECDSA sign/verify with gcrypt
Thread-Topic: [PATCH v2 2/9] crypto/akcipher: Support ECDSA sign/verify with
 gcrypt
Thread-Index: AQHdMRwK0hYKHMZ/6EKm6vnSstd4qQ==
Date: Fri, 21 Aug 2026 03:20:39 +0000
Message-ID: <20260821032036.1829294-3-jamin_lin@aspeedtech.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5146:EE_
x-ms-office365-filtering-correlation-id: b916ba39-9228-42a0-3bc8-08deff332d32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|38070700021|921020|3023799007|56012099006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: JWjahUMytM1Vm2piYcw1dHZgCbyaF4U1W4CqFGAVF7KAFMqyJ7pTn6Hz6lvRezDz+UBeJW8A5VKjy79dY0N14nFQIo/C1TjZzvff5lOn2nud4g4YgXHuM5gLL+vxMbFJSjD7GXDhF0Nvq8ueVlmBXkthfTVHS6xnGDskJwmx1mDG6+VlUqnF9xFzN0Lu5qvH5c+szbiMp2ki/FIaJ9u5pJKGAUBhdMw/rlMO22HKjFD/+TXpBInDMCESvG9Qzm8cXB63Td3aQZ8VdLKqBx+191eAcwfvTC9kEcX+PZN2v0S0IqS+3FMAyXAivYwDL4wc8U2UFHFOi8/CZisODQlXeURq8twkYStG4gFHFaa8HOjLTe2v2rYc+I+18+1/BpPtg/kW893jPKSDPOUilJSIzrUa40MijE6FRohMZ80LuTFsbedPUwDpjpf+ByFcrTvru2T2n3M9u4XtSF9l854rXxBl7k7YCCy/kjHlvUjOeNGFrN7+gqJqma3UoeDdsz5DBYQuQgs2ZEF1xvlf6UtznINvG+VTohjxfheHDVE8f20MF8NizLVUCP+74UINvX/6OTKVWPyOSKWMyD6YoHbIvU7DpKnrk54jfT9G1lQhm5RMfZV8mUAGQn/J/tKbXQDN5RZAOnZ5l6lPHb29ceW7ff719H0qha4lNrZxugKgBrEUx3c3xKNwqIGcax+P9/9Dk9Q3vWdB/IBfqlr5h+O10+vcgaGlcwzsQ1OU7qPUxrYXrOIr8Rr+Z2ulIG0MRN0f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(38070700021)(921020)(3023799007)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/9kA9jqJ2zsPKtEgq1ll2hOPCAIA2eXqJDE8tny3y7IaIwzGIR3wKac+BL?=
 =?iso-8859-1?Q?W24jHQW7W95X3acht9U7ma3g3pPQ01BvEx8ldjewvHX7jbM6OhaZ/fXhcl?=
 =?iso-8859-1?Q?Ne1pP1dqFEoRhvErUQJM+6hVq4+/feM9CnexBzdpRULY4qvproKa5cOz5t?=
 =?iso-8859-1?Q?QUGFr7baMgF67NtIGLoSKyB1Zv8qQyP9xNB/TGbU+pT1KFHln9qYOueUk+?=
 =?iso-8859-1?Q?xvk1T9DFLr6NhNff8ANepkrroLJcFhg1DCd4kxkyHDLRM93e6o17o+N0rh?=
 =?iso-8859-1?Q?00EDJGePpyQLbqkMH4hr4HzgS1NVaaRGj9BmJvf03COVPYbKXUpcbxI85t?=
 =?iso-8859-1?Q?Zuww+8UnEuY6ZyyZfXwbc4DnCA8+VLW0PE3tnkBwEiaiRoFXD7/NtcsMnf?=
 =?iso-8859-1?Q?VjXVfmSD0FCN2pHhfpmGYMrJpLvoluuwngTEYeHZ2L9DXnjCwdSeGaR3C2?=
 =?iso-8859-1?Q?fbRxx4pfvwdBjgaHhxqgjVP0Pv5Va9LQQ1QzDfvvidy4ZLiGHOq9nfiLTt?=
 =?iso-8859-1?Q?TcVZtP48oZwdTMm7zPIhIOgBO5Ak5ir2gtYGtVCrbhvCiBF8vjphS+VT1s?=
 =?iso-8859-1?Q?vuL3XkLDuZZdR+eu7CqFFp0i9yrm2i1xWJFqYJIPm7IZhUf+lYgcXLE8F4?=
 =?iso-8859-1?Q?ygemm3kmnVfBonqtHd+LPvGUgkncQS+fusOtPeT+pUpup1l5xunvBSzOGv?=
 =?iso-8859-1?Q?+TW1GjXbXGH38hmpPV6LC5EtlefPtKWNHZf55kPvzpkomNyQNeZZKybb8t?=
 =?iso-8859-1?Q?oXdtv+JldCDaGZaE8xnSyucyLIw5Dw4EzwPSw1+0m75vr6e4dHdvSOPa4F?=
 =?iso-8859-1?Q?t+KRYuCOFkCSZfIt5H/9tiqD4gnj4uIHrrydtV6Ua28qA90byjArYSoVOq?=
 =?iso-8859-1?Q?GiBkylihzya2HVJR5VTMY6BM0Uoll/ibExH3cYjfPV1ovq9VhuSv9Yu1I5?=
 =?iso-8859-1?Q?fnNdEdYrI59iJueyhXUMT7Q5KEeTheVdgIkVVBsTyKKfvjhRbxuNmBzu5F?=
 =?iso-8859-1?Q?mDcD7zGj4qiEN0MVfLuP1wViAw2ncwseX7KCUCAIKTebKOjbpHiedvY7NB?=
 =?iso-8859-1?Q?I/lHYKEOlm+9u88kyK5vo5tSzbG6CKhpvDYNfwqtDnfUfKvQqyOx16Umpk?=
 =?iso-8859-1?Q?9xlb8DPguTck+4KjAqD0xNNvhqA4vvetk8YjM+YZ4u6SzaGpo8rrC8BOU0?=
 =?iso-8859-1?Q?wMB7a9X4tlL9Pl3pj+YNIbPY4ElwtQwqyd4fAqtxlogtrVCpBRBsVSOSx0?=
 =?iso-8859-1?Q?maeFPSsx4Vu1yDEuVCGmch+f53hvtANOAGQLdPEdvEFa0aMVqfsSWAJSEa?=
 =?iso-8859-1?Q?OASDiZ+lTM/iBFiEJoRIvYMshbFxnpI+Hms4L5ElhVAgjx/M+DePSdwQ4s?=
 =?iso-8859-1?Q?nspkEB4qBzr4FRJM/zYIYSGyt6hpxqaA/PFLRd8YErapZJmJPXTs2d9Nuy?=
 =?iso-8859-1?Q?8yGyIvUL9G4oxJWV1mV/x7JYMCWA/KRhwFu3/zRLobXMf77vQykpXyKII5?=
 =?iso-8859-1?Q?aoG5jmqEgE1JemY7mZrJMYHNwuAekoqnaP/tjIW1+R9NHuFPCpm5MFBhS7?=
 =?iso-8859-1?Q?Ecsqqwu8ReWJ1gsK/E+SDc6VprQz9A5Gns5sPn2pWBVUsY77CEnCWrZEPQ?=
 =?iso-8859-1?Q?LYaKkR9kdm8YhQIGevyfZvuvHompXlz9+jPBLPrKsND0X3dtp80sqDfbx6?=
 =?iso-8859-1?Q?Md0n3gwyEcF042XMRkoDWQSO2zp4hzHk7Jns9LqT/t21VO8/oJUntW1pRF?=
 =?iso-8859-1?Q?baItUri380zP0NqXgIS+HKJggEKvAx3/2+bGfJpzbbtew8Vq+nrq6urX2F?=
 =?iso-8859-1?Q?GAOyNgv5Cg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WsP9uKiZV6UZqHE3oXJVN4dIA/iov9mps+hJwDz22fbqwUfeSxhDKohzXV/TfpIJ5psC6lQMHD3jirE+BV4gfH63KzrKSlRXLPD9podqZSMwmF3NcxbHSo+fJ5H9H84/zLc/sB3mkFdLMHc2d2XgvUOhd3ejflhtk/hrKO5DkurFn3Jr7PcYlE9EmZCscDyAdAAYMqwgV8jDiDQRFQkc7ZcdLgGvyqLyjhBJ+VTvu4R5wpvRK9/93vgFnZ/llmbndTQelaAsT8mSyme6uG/Sdd2ebqg8x05PIXlo/WXUjX/4zBFePM/1sSd/HdS6QJEkXpR7D8lp4vJNS2Oo0dlTeA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b916ba39-9228-42a0-3bc8-08deff332d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 03:20:39.9427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLGKv6YFmacE63tIDi+Elolf3VkZCHxxaMOOdc+RZYQNzOBv+BrquwxS9sNgm8WcyrmIp17+PK8kwphJbYxi7LewumOCjo0q8AYTawnPVis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5146
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

Implement ECDSA signing and verification for the gcrypt backend, for the=0A=
prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves. The=0A=
encrypt/decrypt driver ops return an error, as ECDSA is a signature=0A=
algorithm. The public key is provided as the raw affine coordinates=0A=
Qx || Qy, the private key as the raw scalar d, and the signature as the=0A=
raw pair r || s (each half the curve size, big-endian); the input to=0A=
sign/verify is a pre-computed message digest.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 crypto/akcipher-gcrypt.c.inc | 328 ++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 327 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc=0A=
index bcf030fdec..ad8aeb7e74 100644=0A=
--- a/crypto/akcipher-gcrypt.c.inc=0A=
+++ b/crypto/akcipher-gcrypt.c.inc=0A=
@@ -36,6 +36,12 @@ typedef struct QCryptoGcryptRSA {=0A=
     QCryptoHashAlgo hash_alg;=0A=
 } QCryptoGcryptRSA;=0A=
 =0A=
+typedef struct QCryptoGcryptECDSA {=0A=
+    QCryptoAkCipher akcipher;=0A=
+    gcry_sexp_t key;=0A=
+    QCryptoCurveID curve_id;=0A=
+} QCryptoGcryptECDSA;=0A=
+=0A=
 static void qcrypto_gcrypt_rsa_free(QCryptoAkCipher *akcipher)=0A=
 {=0A=
     QCryptoGcryptRSA *rsa =3D (QCryptoGcryptRSA *)akcipher;=0A=
@@ -53,6 +59,12 @@ static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(=0A=
     const uint8_t *key,  size_t keylen,=0A=
     Error **errp);=0A=
 =0A=
+static QCryptoGcryptECDSA *qcrypto_gcrypt_ecdsa_new(=0A=
+    const QCryptoAkCipherOptionsECDSA *opt,=0A=
+    QCryptoAkCipherKeyType type,=0A=
+    const uint8_t *key,  size_t keylen,=0A=
+    Error **errp);=0A=
+=0A=
 QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,=
=0A=
                                       QCryptoAkCipherKeyType type,=0A=
                                       const uint8_t *key, size_t keylen,=
=0A=
@@ -63,6 +75,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCip=
herOptions *opts,=0A=
         return (QCryptoAkCipher *)qcrypto_gcrypt_rsa_new(=0A=
             &opts->u.rsa, type, key, keylen, errp);=0A=
 =0A=
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:=0A=
+        return (QCryptoAkCipher *)qcrypto_gcrypt_ecdsa_new(=0A=
+            &opts->u.ecdsa, type, key, keylen, errp);=0A=
+=0A=
     default:=0A=
         error_setg(errp, "Unsupported algorithm: %u", opts->alg);=0A=
         return NULL;=0A=
@@ -565,6 +581,306 @@ error:=0A=
 }=0A=
 =0A=
 =0A=
+/*=0A=
+ * ECDSA support (sign and verify)=0A=
+ *=0A=
+ * Keys and signatures use raw big-endian formats:=0A=
+ *   - public key: Qx || Qy, each 'coord_len' bytes=0A=
+ *   - private key: the scalar d, 'coord_len' bytes=0A=
+ *   - signature: r || s, each 'coord_len' bytes=0A=
+ *   - the input to sign/verify is a raw message digest=0A=
+ */=0A=
+static const char *qcrypto_gcrypt_ecdsa_curve_name(QCryptoCurveID curve_id=
)=0A=
+{=0A=
+    switch (curve_id) {=0A=
+    case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        return "NIST P-256";=0A=
+=0A=
+    case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+        return "NIST P-384";=0A=
+=0A=
+    default:=0A=
+        return NULL;=0A=
+    }=0A=
+}=0A=
+=0A=
+static size_t qcrypto_gcrypt_ecdsa_coord_len(QCryptoCurveID curve_id)=0A=
+{=0A=
+    switch (curve_id) {=0A=
+    case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        return 32;=0A=
+=0A=
+    case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+        return 48;=0A=
+=0A=
+    default:=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void qcrypto_gcrypt_ecdsa_free(QCryptoAkCipher *akcipher)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa =3D (QCryptoGcryptECDSA *)akcipher;=0A=
+    if (!ecdsa) {=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    gcry_sexp_release(ecdsa->key);=0A=
+    g_free(ecdsa);=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_encrypt(QCryptoAkCipher *akcipher,=0A=
+                                        const void *in, size_t in_len,=0A=
+                                        void *out, size_t out_len,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    error_setg(errp, "ECDSA does not support encryption");=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_decrypt(QCryptoAkCipher *akcipher,=0A=
+                                        const void *in, size_t in_len,=0A=
+                                        void *out, size_t out_len,=0A=
+                                        Error **errp)=0A=
+{=0A=
+    error_setg(errp, "ECDSA does not support decryption");=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Write an MPI into a fixed-length, big-endian, left-zero-padded buffer.=
=0A=
+ *=0A=
+ * gcry_mpi_print(GCRYMPI_FMT_USG) emits only the minimal number of bytes =
(it=0A=
+ * drops leading zeros), but an ECDSA r/s component must occupy exactly th=
e=0A=
+ * curve size. Zero-fill the leading bytes and right-align the value, so a=
=0A=
+ * component whose most significant byte is zero still lands at the correc=
t=0A=
+ * offset in the r || s output.=0A=
+ *=0A=
+ * Returns -1 if the value does not fit in 'len' bytes.=0A=
+ */=0A=
+static int qcrypto_gcrypt_mpi_to_buf(gcry_mpi_t mpi, uint8_t *buf, size_t =
len)=0A=
+{=0A=
+    size_t nbytes =3D (gcry_mpi_get_nbits(mpi) + 7) / 8;=0A=
+=0A=
+    if (nbytes > len) {=0A=
+        return -1;=0A=
+    }=0A=
+    memset(buf, 0, len - nbytes);=0A=
+    gcry_mpi_print(GCRYMPI_FMT_USG, buf + (len - nbytes), nbytes, NULL, mp=
i);=0A=
+    return 0;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_sign(QCryptoAkCipher *akcipher,=0A=
+                                     const void *in, size_t in_len,=0A=
+                                     void *out, size_t out_len,=0A=
+                                     Error **errp)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa =3D (QCryptoGcryptECDSA *)akcipher;=0A=
+    size_t coord_len =3D qcrypto_gcrypt_ecdsa_coord_len(ecdsa->curve_id);=
=0A=
+    gcry_sexp_t dgst_sexp =3D NULL;=0A=
+    gcry_sexp_t sig_sexp =3D NULL;=0A=
+    gcry_sexp_t r_sexp =3D NULL;=0A=
+    gcry_sexp_t s_sexp =3D NULL;=0A=
+    gcry_mpi_t r_mpi =3D NULL;=0A=
+    gcry_mpi_t s_mpi =3D NULL;=0A=
+    gcry_error_t err;=0A=
+    int ret =3D -1;=0A=
+=0A=
+    if (in_len =3D=3D 0 || in_len > akcipher->max_dgst_len) {=0A=
+        error_setg(errp, "Invalid digest length %zu", in_len);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    if (out_len < coord_len * 2) {=0A=
+        error_setg(errp, "Signature buffer length %zu is less than %zu",=
=0A=
+                   out_len, coord_len * 2);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_sexp_build(&dgst_sexp, NULL,=0A=
+                          "(data (flags raw) (value %b))",=0A=
+                          (int)in_len, in);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build digest: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_pk_sign(&sig_sexp, dgst_sexp, ecdsa->key);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to make signature: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    /* S-expression of signature: (sig-val (ecdsa (r r-mpi) (s s-mpi))) */=
=0A=
+    r_sexp =3D gcry_sexp_find_token(sig_sexp, "r", 0);=0A=
+    s_sexp =3D gcry_sexp_find_token(sig_sexp, "s", 0);=0A=
+    if (!r_sexp || !s_sexp) {=0A=
+        error_setg(errp, "Invalid signature result");=0A=
+        goto cleanup;=0A=
+    }=0A=
+    r_mpi =3D gcry_sexp_nth_mpi(r_sexp, 1, GCRYMPI_FMT_USG);=0A=
+    s_mpi =3D gcry_sexp_nth_mpi(s_sexp, 1, GCRYMPI_FMT_USG);=0A=
+    if (!r_mpi || !s_mpi) {=0A=
+        error_setg(errp, "Invalid signature result");=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    /* output is r || s, each zero-padded to the curve size */=0A=
+    if (qcrypto_gcrypt_mpi_to_buf(r_mpi, out, coord_len) < 0 ||=0A=
+        qcrypto_gcrypt_mpi_to_buf(s_mpi, (uint8_t *)out + coord_len,=0A=
+                                  coord_len) < 0) {=0A=
+        error_setg(errp, "Signature component is too large");=0A=
+        goto cleanup;=0A=
+    }=0A=
+    ret =3D coord_len * 2;=0A=
+=0A=
+cleanup:=0A=
+    gcry_sexp_release(dgst_sexp);=0A=
+    gcry_sexp_release(sig_sexp);=0A=
+    gcry_sexp_release(r_sexp);=0A=
+    gcry_sexp_release(s_sexp);=0A=
+    gcry_mpi_release(r_mpi);=0A=
+    gcry_mpi_release(s_mpi);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+static int qcrypto_gcrypt_ecdsa_verify(QCryptoAkCipher *akcipher,=0A=
+                                       const void *in, size_t in_len,=0A=
+                                       const void *in2, size_t in2_len,=0A=
+                                       Error **errp)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa =3D (QCryptoGcryptECDSA *)akcipher;=0A=
+    size_t coord_len =3D qcrypto_gcrypt_ecdsa_coord_len(ecdsa->curve_id);=
=0A=
+    gcry_sexp_t sig_sexp =3D NULL;=0A=
+    gcry_sexp_t dgst_sexp =3D NULL;=0A=
+    gcry_error_t err;=0A=
+    int ret =3D -1;=0A=
+=0A=
+    /* signature is r || s */=0A=
+    if (in_len !=3D coord_len * 2) {=0A=
+        error_setg(errp, "Signature length %zu is not %zu",=0A=
+                   in_len, coord_len * 2);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    if (in2_len =3D=3D 0 || in2_len > akcipher->max_dgst_len) {=0A=
+        error_setg(errp, "Invalid digest length %zu", in2_len);=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_sexp_build(&sig_sexp, NULL,=0A=
+                          "(sig-val (ecdsa (r %b) (s %b)))",=0A=
+                          (int)coord_len, in,=0A=
+                          (int)coord_len, (const uint8_t *)in + coord_len)=
;=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build signature: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_sexp_build(&dgst_sexp, NULL,=0A=
+                          "(data (flags raw) (value %b))",=0A=
+                          (int)in2_len, in2);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build digest: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+=0A=
+    err =3D gcry_pk_verify(sig_sexp, dgst_sexp, ecdsa->key);=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to verify signature: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto cleanup;=0A=
+    }=0A=
+    ret =3D 0;=0A=
+=0A=
+cleanup:=0A=
+    gcry_sexp_release(sig_sexp);=0A=
+    gcry_sexp_release(dgst_sexp);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+QCryptoAkCipherDriver gcrypt_ecdsa =3D {=0A=
+    .encrypt =3D qcrypto_gcrypt_ecdsa_encrypt,=0A=
+    .decrypt =3D qcrypto_gcrypt_ecdsa_decrypt,=0A=
+    .sign =3D qcrypto_gcrypt_ecdsa_sign,=0A=
+    .verify =3D qcrypto_gcrypt_ecdsa_verify,=0A=
+    .free =3D qcrypto_gcrypt_ecdsa_free,=0A=
+};=0A=
+=0A=
+static QCryptoGcryptECDSA *qcrypto_gcrypt_ecdsa_new(=0A=
+    const QCryptoAkCipherOptionsECDSA *opt,=0A=
+    QCryptoAkCipherKeyType type,=0A=
+    const uint8_t *key, size_t keylen,=0A=
+    Error **errp)=0A=
+{=0A=
+    QCryptoGcryptECDSA *ecdsa;=0A=
+    const char *curve_name =3D qcrypto_gcrypt_ecdsa_curve_name(opt->curve_=
id);=0A=
+    size_t coord_len =3D qcrypto_gcrypt_ecdsa_coord_len(opt->curve_id);=0A=
+    g_autofree uint8_t *point =3D NULL;=0A=
+    gcry_error_t err;=0A=
+=0A=
+    if (!curve_name || coord_len =3D=3D 0) {=0A=
+        error_setg(errp, "Unsupported curve id: %u", opt->curve_id);=0A=
+        return NULL;=0A=
+    }=0A=
+=0A=
+    ecdsa =3D g_new0(QCryptoGcryptECDSA, 1);=0A=
+    ecdsa->akcipher.driver =3D &gcrypt_ecdsa;=0A=
+    ecdsa->curve_id =3D opt->curve_id;=0A=
+    ecdsa->akcipher.max_dgst_len =3D coord_len;=0A=
+    ecdsa->akcipher.max_signature_len =3D coord_len * 2;=0A=
+=0A=
+    switch (type) {=0A=
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:=0A=
+        /* public key: Qx || Qy */=0A=
+        if (keylen !=3D coord_len * 2) {=0A=
+            error_setg(errp, "Public key length %zu is not %zu",=0A=
+                       keylen, coord_len * 2);=0A=
+            goto error;=0A=
+        }=0A=
+        /* build uncompressed EC point: 0x04 || Qx || Qy */=0A=
+        point =3D g_malloc(1 + keylen);=0A=
+        point[0] =3D 0x04;=0A=
+        memcpy(point + 1, key, keylen);=0A=
+        err =3D gcry_sexp_build(&ecdsa->key, NULL,=0A=
+                              "(public-key (ecc (curve %s) (q %b)))",=0A=
+                              curve_name, (int)(1 + keylen), point);=0A=
+        break;=0A=
+=0A=
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:=0A=
+        /* private key: the scalar d */=0A=
+        if (keylen !=3D coord_len) {=0A=
+            error_setg(errp, "Private key length %zu is not %zu",=0A=
+                       keylen, coord_len);=0A=
+            goto error;=0A=
+        }=0A=
+        err =3D gcry_sexp_build(&ecdsa->key, NULL,=0A=
+                              "(private-key (ecc (curve %s) (d %b)))",=0A=
+                              curve_name, (int)keylen, key);=0A=
+        break;=0A=
+=0A=
+    default:=0A=
+        error_setg(errp, "Unknown akcipher key type %d", type);=0A=
+        goto error;=0A=
+    }=0A=
+=0A=
+    if (gcry_err_code(err) !=3D 0) {=0A=
+        error_setg(errp, "Failed to build ECDSA key: %s/%s",=0A=
+                   gcry_strsource(err), gcry_strerror(err));=0A=
+        goto error;=0A=
+    }=0A=
+=0A=
+    return ecdsa;=0A=
+=0A=
+error:=0A=
+    qcrypto_gcrypt_ecdsa_free((QCryptoAkCipher *)ecdsa);=0A=
+    return NULL;=0A=
+}=0A=
+=0A=
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)=0A=
 {=0A=
     switch (opts->alg) {=0A=
@@ -589,7 +905,17 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions =
*opts)=0A=
             return false;=0A=
         }=0A=
 =0A=
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:=0A=
+        switch (opts->u.ecdsa.curve_id) {=0A=
+        case QCRYPTO_CURVE_ID_PRIME256V1:=0A=
+        case QCRYPTO_CURVE_ID_SECP384R1:=0A=
+            return true;=0A=
+=0A=
+        default:=0A=
+            return false;=0A=
+        }=0A=
+=0A=
     default:=0A=
-        return true;=0A=
+        return false;=0A=
     }=0A=
 }=0A=
-- =0A=
2.53.0=0A=

