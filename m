Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5793C624D2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEl-0003ko-O2; Tue, 01 Sep 2026 04:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEg-0003ji-2e; Tue, 01 Sep 2026 04:52:54 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEd-0007J9-KE; Tue, 01 Sep 2026 04:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raCofKsDG85RMl6LTxaoYPw6v0RjlHRBKJfur/a2sn7Go5CcIXp85pzzOxOebIoP/hQbMo70OzWrYsffpR3xFvO45rLCmnHE/k5N3JtT+o0i/L1LD+SU8Z+yWTUfHk3RDUOKIUhSI3iGKHIvftoUPh1QY+KO78h3gL3p21bsBPdKHuVKDjIdayVDlkSsLDfO8Yol9+pPt4xfZk6WM2B2N3070JuXvx2StHOfeYLrVotAxWKXWAi5NabXJY2KFx6DNxVEFiaGKBqeWIzGZFHs7cLSMkhRhAbZQ0M2a0s8jFGkIsO3rlC6cKy+epOu9bajpL1VbOPbQZ9SzEJvVllZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOFQW9VGzhCVe8V8/eMlMR9nbM8WGJRSgQ4Zk48s5og=;
 b=UdG880bQkvJkWNLmRvP2l36FVp6qef5Xb1CAVIQa8YbJPM8baqSHwaMCAQmL/Oy7FRd53Ba+UV8SgNYTkQXedraWEg/RXLOqCIv0i37YJdsP47SrzAWa15Iugu3i5hmoXxxVxKTS6osErHKPAFNNE+h9/o+0YTOX03TCOAxw6S+tFNq3kxhqqsqjiEMLjY5IQhgkKb8ddMC1b25fpRvjrbnUlUHWxNRQ7pmctSDUlG+1i93dYYKeIBtU1v4ioMtVpoDtOviKjfURX+O0+0OoejeoCd+1DlPeX3IbsayZaHFQ+q/XBIzCu7IAbKNFelk4zi46nmXi3iaMfwH2+W4Orw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOFQW9VGzhCVe8V8/eMlMR9nbM8WGJRSgQ4Zk48s5og=;
 b=YxNOZLjNbQlcCVBoPFCR62MCdud+q9BFg+dC/9jTCD+Xr2zcNVE8E0YOiWN6tZISLa+9CySC+xqoadFSg098QGwiEPgV2aBRk+Oioe0ILCrfWYMBLEcSYb4Gf860VgC8kteiFDArmC3oLdWDJw5B8u/hGVJDvjYEOQYcLfH8w9/npzLevQ75eMU7NQWcHVzuyNhuqFTtBiOvOHDrFneOZsQyx5nOMQBBRmLUT04wUPUqLlWtBftuUwY0KpkLwN2ycz+X7IADT/wh/LUvmZCKq5EIfIxqRk/LwTFHXEkka/7iN6GwGbNJvg0emN94JjuKEinzpavaIwqMXgf8o+afnw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF557D403C2.apcprd06.prod.outlook.com (2603:1096:d18::495)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:52:43 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:43 +0000
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
Subject: [PATCH v4 4/9] tests/crypto: Add ECDSA sign/verify tests
Thread-Topic: [PATCH v4 4/9] tests/crypto: Add ECDSA sign/verify tests
Thread-Index: AQHdOe9AyvJZch6zEEyOdbyiorxdGw==
Date: Tue, 1 Sep 2026 08:52:43 +0000
Message-ID: <20260901085238.995968-5-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: 9efd7aac-5ce7-4380-0262-08df08066342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: jwtt6h4Rlz8tpDvrfpac10zJqqtGm1ObbyrHA8wx2YRyBTJFhDTaSd53BAJPFFqGKugXC36Ca644yhpSyM9o9aQRmf4Wmwl2DvQakPUG+QW78Gc0626Qrt/0ILyfWk9ypUEHzyggBvtYWOixg7oX2dpvtv6weSfQKLa8i57plc//L4jh5mCti/7cVNegnvwoGjQ88ZT4suKEoF/lzqW9ybsYLLKxiG55C7jlLRbfTsRShMciuoQqDBn9+zwYDB1QRE2615daMLF7+BTYr4tS4L5+w7+KlyX5Q6829f6bCkwn35quIz1Nx26JTuBqKDgMoxPu98E4SSEsl566+C0JOE1nhIraQ9pMWLrTafTuVyr+2UDu35UPHPSOsOTW0oBQso7mqledzVse3tWwHe8xedT+AKwRahQVt9kckkdlhkZAaqaETnces0LNjo4GT4kB0aMLcC4573XQLCtfrQwnMZyljfqHuYnPfXnOWTIZg6RslqAUReR8drrwMTjL+qlMZwEBxbWUowfk75SxfI9koQjoor8tQBvelZG/tAKK++JbbENz/uGwxLu6W3cCQIVbFywGcEVgTvNfnas41N709ZTGGh10SRTJmTFxgGmonzW3vZR7gJfJe17iQ86I2FGdgB6/S8aeN61mHzIIaLfAZQqQYLJtMnXn3z8X2X1QkNvj1i69LqZWCtiOYQDvPW0gXj4WEZO7QqPCrBC89eU7kyR/m9ANdGG66wysT9/ma20=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cwl2YXwK6iz9gJm+bQV5K5GwU+rHI5B0LXEWA+nB2CX02E2iRhuSwsbmUp?=
 =?iso-8859-1?Q?mZ9i/ragRipHav9480QrIKzyVC6a9VWbRUjDRoELaG3lXiiQHVzHkSpPcX?=
 =?iso-8859-1?Q?37D0tPhVdG8MIABHahXgTJQPfMUOBdA/yapa/9xqawh0hVAFSonx9dVCLR?=
 =?iso-8859-1?Q?xOsUYx4MEtDJMQmkxLru48NUD/yopoLmMAvI9jEiNsvt8AU0FKL+PwylMe?=
 =?iso-8859-1?Q?PiqjodMSplLrv7os7MDL3GxFAxCat/Gb+420tLeQAMM0Kjv2U1ykN8qZ3j?=
 =?iso-8859-1?Q?ZeMlD75Sq77M/FkfQQoIwCyDlDhBaZYO5fbmfmXJSQ7JsOQ+yv18dKr9Fw?=
 =?iso-8859-1?Q?AFQxDbO1ipRsHCeVW3yMmAgsRBOIDLbBMKrEOQ8U0Kn+gFF00GGFMU7w16?=
 =?iso-8859-1?Q?7cetdxsKdjEr4hOd6gBoGy9La1rbTd/zf1Y+JovSflRBblUvZRIJEh36Wz?=
 =?iso-8859-1?Q?AH6CBzI+IRknsdmpO5rxpHqQeheLkv9GhTADf2oiFUPQdVGhIAALda6EuL?=
 =?iso-8859-1?Q?RZJ/7enVU9YUGC+XlffpIb0LaJxbf5hI0tsvim7mKuD0psJm3DNXnyJ1Mu?=
 =?iso-8859-1?Q?6pObxiR4VxldrGrsMjiqvi8CzN9emKu8UCoDx2r22XImFXrW6rweJ4Udwg?=
 =?iso-8859-1?Q?IcS5KzUg0T/MEN7fUC/cZJkAxoGct0jXYk5boBdEtn5cxt639VXDwoslOm?=
 =?iso-8859-1?Q?/9eN7abtTdLD9+loV9uykGYdFhB3AOVOCTKwy9rdIU4W8HIMwWaUGxEoTA?=
 =?iso-8859-1?Q?wb8vignIcrnsFmxrNqYF2g8r8sUXB0cq9I8b2BaEpIiRipewEgRaqd4F42?=
 =?iso-8859-1?Q?6asPSrZPI2mVaGCAcBJXzkAMRqSvuFQRc9tPYgFq5YI/Eq6AZMCzM+By+Q?=
 =?iso-8859-1?Q?t59XwmAw3mg6kd7+18fLFroo2wW/nQ1tcs5e/lgy0N966Xc2EAWowbUR+k?=
 =?iso-8859-1?Q?GPpY1Vets19Mm9PQcaDrbxqVJ6MB2f8pQG9FUp8Kd3ZOlSCnNYB+Fwpk6m?=
 =?iso-8859-1?Q?Whkxs1X0JVsGQewGkl1BEHD3x+NWZaHCwmdrQoyHiziBJve9LvPHxR0FTy?=
 =?iso-8859-1?Q?ydvrjBLXvZyAHb1DJwUZGIAmsz04++QJLaUbzMgKoXtSq0P9qU02dF1L96?=
 =?iso-8859-1?Q?1z1lAD3EdOOqlIFGUUR5xSW1nD8A7dzQ/oGKHiW5fvUqQu36Nhy3gwtL0v?=
 =?iso-8859-1?Q?YNDn4xXf8H8OLVGAp4ldGq4imZlm9UwfzmMBPVbGPy8/kgnd4uEyLIkUUo?=
 =?iso-8859-1?Q?CXk5/za/oemmHYkpZgv5FCMmZAz0NcpTUSviA4TGsY1KDbX2jfwEnSnRqj?=
 =?iso-8859-1?Q?7epO+XxSCFSvhlemH768u0KO3dhu37RysFTn4q1a3pSIQxZhKvf8O52eMv?=
 =?iso-8859-1?Q?xMpcoC9x/ForkgHiH8x4H3OEf8/iflqXkgu8IfQkh+hVFFp8jYEUzi7tZQ?=
 =?iso-8859-1?Q?/PofVdNcPMF2UEoZZ7cN/VNgQtqM/t3ynl5yZ9wKFYPxRKS+bWVST/2r+7?=
 =?iso-8859-1?Q?IFpeEXXvGdCfISoY8AFwdqu5Bha5XTZqOaAFzgDoL61HZqFsXkRe5XXY9u?=
 =?iso-8859-1?Q?fKHLNRNwqgkzumJ/LyZU5Qm4UjALS3g/RoNV9oGB5uSl5c7lTTjValibf1?=
 =?iso-8859-1?Q?vICkypsvsYWQCwmXDlWJ+cOC37sIne0TmGE7x2C9BnCbhpI++hF85fZKgb?=
 =?iso-8859-1?Q?Ie1euPXI+HgIGWf48fEhiEIq/7zTot/sgJD6Dp0yYDc9Egk3z9pF96gkfe?=
 =?iso-8859-1?Q?LlLwmdNrT7h7+i6z60BTdkpDS3kfSB8vEzZGsxjWf8S9gyVeMP4XsOq7+/?=
 =?iso-8859-1?Q?l3fcp0t9tg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fcXSASZoA6CpMUMop64NuNDDDc5nP9GRjxpng6AmQSBYqBCoJM+uisT9+OllfGnAeGEPffy8hg1+nNCedixVUuywmY5/yaLXmJVVTM/1S/FPL+6rs/Q6UKSZHAPER2Gm0JgS3NuX55TBMthRzTkYUb7gqM6w4oUbsqtyh19OumEBEm5wBsvqmHamTkwF3qjCmSTjUS/GVgHsQ1nD1TDtoNoGbAjsO4rd3zstz1fi3cuJNZ0W69dND85rcMCt8Yk5npCDx7IGInmB/ym59dnSyM0DRRGBMcRWWElCd8EPT42hvAHbHfahMueS4VK79hgLxtMTrjqbHD/larj2kk+p0A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd7aac-5ce7-4380-0262-08df08066342
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:43.7860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 005YzVoYhLR3eg69kkTBO0vCkJMOjn6cv4FWqKNyVlSnIotQxYbLApjs4Ud+40W7IbHZcVFE67Nuetsvgin+i3QupQuUOh9+41N88S+pTME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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

Add unit tests for ECDSA prime256v1 and secp384r1, using the=0A=
RFC 6979 (Deterministic ECDSA) "sample" known-answer vectors. The same=0A=
key pair drives the verify test (against the RFC's known signature) and=0A=
the sign test, which signs the digest with the private key and checks=0A=
that the result verifies with the public key. Each test skips=0A=
(g_test_skip) when the crypto backend does not support ECDSA, via=0A=
qcrypto_akcipher_supports().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 tests/unit/test-crypto-akcipher.c | 236 ++++++++++++++++++++++++++++++=0A=
 1 file changed, 236 insertions(+)=0A=
=0A=
diff --git a/tests/unit/test-crypto-akcipher.c b/tests/unit/test-crypto-akc=
ipher.c=0A=
index 53c2211ba8..fb1a6163e9 100644=0A=
--- a/tests/unit/test-crypto-akcipher.c=0A=
+++ b/tests/unit/test-crypto-akcipher.c=0A=
@@ -658,6 +658,117 @@ static const uint8_t rsa_public_key_extra_elem[] =3D =
{=0A=
     0x02, 0x06, 0xe1, 0x22, 0xdb, 0xe1, 0x22, 0xdb,=0A=
 };=0A=
 =0A=
+/*=0A=
+ * ECDSA known-answer vectors from RFC 6979 (Deterministic ECDSA), message=
=0A=
+ * "sample", decoded into raw big-endian form. The same key pair drives bo=
th=0A=
+ * the verify test (against the RFC's known signature) and the sign round-=
trip=0A=
+ * test:=0A=
+ *   - private key: the scalar d (curve size)=0A=
+ *   - public key: Qx || Qy (2 * curve size)=0A=
+ *   - dgst: the message digest (curve size)=0A=
+ *   - signature: r || s (2 * curve size)=0A=
+ *=0A=
+ * prime256v1 / SHA-256 (RFC 6979 A.2.5):=0A=
+ */=0A=
+static const uint8_t ecdsa_p256_privkey[32] =3D {=0A=
+    0xc9, 0xaf, 0xa9, 0xd8, 0x45, 0xba, 0x75, 0x16,=0A=
+    0x6b, 0x5c, 0x21, 0x57, 0x67, 0xb1, 0xd6, 0x93,=0A=
+    0x4e, 0x50, 0xc3, 0xdb, 0x36, 0xe8, 0x9b, 0x12,=0A=
+    0x7b, 0x8a, 0x62, 0x2b, 0x12, 0x0f, 0x67, 0x21,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p256_pubkey[64] =3D {=0A=
+    0x60, 0xfe, 0xd4, 0xba, 0x25, 0x5a, 0x9d, 0x31,=0A=
+    0xc9, 0x61, 0xeb, 0x74, 0xc6, 0x35, 0x6d, 0x68,=0A=
+    0xc0, 0x49, 0xb8, 0x92, 0x3b, 0x61, 0xfa, 0x6c,=0A=
+    0xe6, 0x69, 0x62, 0x2e, 0x60, 0xf2, 0x9f, 0xb6,=0A=
+    0x79, 0x03, 0xfe, 0x10, 0x08, 0xb8, 0xbc, 0x99,=0A=
+    0xa4, 0x1a, 0xe9, 0xe9, 0x56, 0x28, 0xbc, 0x64,=0A=
+    0xf2, 0xf1, 0xb2, 0x0c, 0x2d, 0x7e, 0x9f, 0x51,=0A=
+    0x77, 0xa3, 0xc2, 0x94, 0xd4, 0x46, 0x22, 0x99,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p256_dgst[32] =3D {=0A=
+    0xaf, 0x2b, 0xdb, 0xe1, 0xaa, 0x9b, 0x6e, 0xc1,=0A=
+    0xe2, 0xad, 0xe1, 0xd6, 0x94, 0xf4, 0x1f, 0xc7,=0A=
+    0x1a, 0x83, 0x1d, 0x02, 0x68, 0xe9, 0x89, 0x15,=0A=
+    0x62, 0x11, 0x3d, 0x8a, 0x62, 0xad, 0xd1, 0xbf,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p256_signature[64] =3D {=0A=
+    0xef, 0xd4, 0x8b, 0x2a, 0xac, 0xb6, 0xa8, 0xfd,=0A=
+    0x11, 0x40, 0xdd, 0x9c, 0xd4, 0x5e, 0x81, 0xd6,=0A=
+    0x9d, 0x2c, 0x87, 0x7b, 0x56, 0xaa, 0xf9, 0x91,=0A=
+    0xc3, 0x4d, 0x0e, 0xa8, 0x4e, 0xaf, 0x37, 0x16,=0A=
+    0xf7, 0xcb, 0x1c, 0x94, 0x2d, 0x65, 0x7c, 0x41,=0A=
+    0xd4, 0x36, 0xc7, 0xa1, 0xb6, 0xe2, 0x9f, 0x65,=0A=
+    0xf3, 0xe9, 0x00, 0xdb, 0xb9, 0xaf, 0xf4, 0x06,=0A=
+    0x4d, 0xc4, 0xab, 0x2f, 0x84, 0x3a, 0xcd, 0xa8,=0A=
+};=0A=
+=0A=
+/* secp384r1 / SHA-384 (RFC 6979 A.2.6): */=0A=
+static const uint8_t ecdsa_p384_privkey[48] =3D {=0A=
+    0x6b, 0x9d, 0x3d, 0xad, 0x2e, 0x1b, 0x8c, 0x1c,=0A=
+    0x05, 0xb1, 0x98, 0x75, 0xb6, 0x65, 0x9f, 0x4d,=0A=
+    0xe2, 0x3c, 0x3b, 0x66, 0x7b, 0xf2, 0x97, 0xba,=0A=
+    0x9a, 0xa4, 0x77, 0x40, 0x78, 0x71, 0x37, 0xd8,=0A=
+    0x96, 0xd5, 0x72, 0x4e, 0x4c, 0x70, 0xa8, 0x25,=0A=
+    0xf8, 0x72, 0xc9, 0xea, 0x60, 0xd2, 0xed, 0xf5,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_pubkey[96] =3D {=0A=
+    0xec, 0x3a, 0x4e, 0x41, 0x5b, 0x4e, 0x19, 0xa4,=0A=
+    0x56, 0x86, 0x18, 0x02, 0x9f, 0x42, 0x7f, 0xa5,=0A=
+    0xda, 0x9a, 0x8b, 0xc4, 0xae, 0x92, 0xe0, 0x2e,=0A=
+    0x06, 0xaa, 0xe5, 0x28, 0x6b, 0x30, 0x0c, 0x64,=0A=
+    0xde, 0xf8, 0xf0, 0xea, 0x90, 0x55, 0x86, 0x60,=0A=
+    0x64, 0xa2, 0x54, 0x51, 0x54, 0x80, 0xbc, 0x13,=0A=
+    0x80, 0x15, 0xd9, 0xb7, 0x2d, 0x7d, 0x57, 0x24,=0A=
+    0x4e, 0xa8, 0xef, 0x9a, 0xc0, 0xc6, 0x21, 0x89,=0A=
+    0x67, 0x08, 0xa5, 0x93, 0x67, 0xf9, 0xdf, 0xb9,=0A=
+    0xf5, 0x4c, 0xa8, 0x4b, 0x3f, 0x1c, 0x9d, 0xb1,=0A=
+    0x28, 0x8b, 0x23, 0x1c, 0x3a, 0xe0, 0xd4, 0xfe,=0A=
+    0x73, 0x44, 0xfd, 0x25, 0x33, 0x26, 0x47, 0x20,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_dgst[48] =3D {=0A=
+    0x9a, 0x90, 0x83, 0x50, 0x5b, 0xc9, 0x22, 0x76,=0A=
+    0xae, 0xc4, 0xbe, 0x31, 0x26, 0x96, 0xef, 0x7b,=0A=
+    0xf3, 0xbf, 0x60, 0x3f, 0x4b, 0xbd, 0x38, 0x11,=0A=
+    0x96, 0xa0, 0x29, 0xf3, 0x40, 0x58, 0x53, 0x12,=0A=
+    0x31, 0x3b, 0xca, 0x4a, 0x9b, 0x5b, 0x89, 0x0e,=0A=
+    0xfe, 0xe4, 0x2c, 0x77, 0xb1, 0xee, 0x25, 0xfe,=0A=
+};=0A=
+=0A=
+static const uint8_t ecdsa_p384_signature[96] =3D {=0A=
+    0x94, 0xed, 0xbb, 0x92, 0xa5, 0xec, 0xb8, 0xaa,=0A=
+    0xd4, 0x73, 0x6e, 0x56, 0xc6, 0x91, 0x91, 0x6b,=0A=
+    0x3f, 0x88, 0x14, 0x06, 0x66, 0xce, 0x9f, 0xa7,=0A=
+    0x3d, 0x64, 0xc4, 0xea, 0x95, 0xad, 0x13, 0x3c,=0A=
+    0x81, 0xa6, 0x48, 0x15, 0x2e, 0x44, 0xac, 0xf9,=0A=
+    0x6e, 0x36, 0xdd, 0x1e, 0x80, 0xfa, 0xbe, 0x46,=0A=
+    0x99, 0xef, 0x4a, 0xeb, 0x15, 0xf1, 0x78, 0xce,=0A=
+    0xa1, 0xfe, 0x40, 0xdb, 0x26, 0x03, 0x13, 0x8f,=0A=
+    0x13, 0x0e, 0x74, 0x0a, 0x19, 0x62, 0x45, 0x26,=0A=
+    0x20, 0x3b, 0x63, 0x51, 0xd0, 0xa3, 0xa9, 0x4f,=0A=
+    0xa3, 0x29, 0xc1, 0x45, 0x78, 0x6e, 0x67, 0x9e,=0A=
+    0x7b, 0x82, 0xc7, 0x1a, 0x38, 0x62, 0x8a, 0xc8,=0A=
+};=0A=
+=0A=
+typedef struct QCryptoECDSATestData QCryptoECDSATestData;=0A=
+struct QCryptoECDSATestData {=0A=
+    const char *path;=0A=
+    QCryptoCurveID curve_id;=0A=
+    const uint8_t *priv_key;=0A=
+    size_t priv_key_len;=0A=
+    const uint8_t *pub_key;=0A=
+    size_t pub_key_len;=0A=
+    const uint8_t *dgst;=0A=
+    size_t dlen;=0A=
+    const uint8_t *signature;=0A=
+    size_t slen;=0A=
+};=0A=
+=0A=
 typedef struct QCryptoRSAKeyTestData QCryptoRSAKeyTestData;=0A=
 struct QCryptoRSAKeyTestData {=0A=
     const char *path;=0A=
@@ -969,6 +1080,120 @@ static void test_rsakey(const void *opaque)=0A=
     g_assert(qcrypto_akcipher_max_dgst_len(key) =3D=3D data->exp_key_len);=
=0A=
 }=0A=
 =0A=
+static QCryptoECDSATestData ecdsa_test_data[] =3D {=0A=
+    {=0A=
+        .path =3D "/crypto/akcipher/ecdsa-prime256v1",=0A=
+        .curve_id =3D QCRYPTO_CURVE_ID_PRIME256V1,=0A=
+        .priv_key =3D ecdsa_p256_privkey,=0A=
+        .priv_key_len =3D sizeof(ecdsa_p256_privkey),=0A=
+        .pub_key =3D ecdsa_p256_pubkey,=0A=
+        .pub_key_len =3D sizeof(ecdsa_p256_pubkey),=0A=
+        .dgst =3D ecdsa_p256_dgst,=0A=
+        .dlen =3D sizeof(ecdsa_p256_dgst),=0A=
+        .signature =3D ecdsa_p256_signature,=0A=
+        .slen =3D sizeof(ecdsa_p256_signature),=0A=
+    },=0A=
+    {=0A=
+        .path =3D "/crypto/akcipher/ecdsa-secp384r1",=0A=
+        .curve_id =3D QCRYPTO_CURVE_ID_SECP384R1,=0A=
+        .priv_key =3D ecdsa_p384_privkey,=0A=
+        .priv_key_len =3D sizeof(ecdsa_p384_privkey),=0A=
+        .pub_key =3D ecdsa_p384_pubkey,=0A=
+        .pub_key_len =3D sizeof(ecdsa_p384_pubkey),=0A=
+        .dgst =3D ecdsa_p384_dgst,=0A=
+        .dlen =3D sizeof(ecdsa_p384_dgst),=0A=
+        .signature =3D ecdsa_p384_signature,=0A=
+        .slen =3D sizeof(ecdsa_p384_signature),=0A=
+    },=0A=
+    /* Add more curves here as they gain backend support. */=0A=
+};=0A=
+=0A=
+static void test_ecdsa_verify(const void *opaque)=0A=
+{=0A=
+    const QCryptoECDSATestData *data =3D opaque;=0A=
+    QCryptoAkCipherOptions opt =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa =3D {=0A=
+            .curve_id =3D data->curve_id,=0A=
+        },=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) pub_key =3D NULL;=0A=
+    g_autofree uint8_t *signature =3D NULL;=0A=
+    g_autofree uint8_t *dgst =3D NULL;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opt)) {=0A=
+        g_test_skip("ECDSA is not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    pub_key =3D qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                   data->pub_key, data->pub_key_len,=0A=
+                                   &error_abort);=0A=
+    g_assert(pub_key !=3D NULL);=0A=
+    g_assert(qcrypto_akcipher_max_signature_len(pub_key) =3D=3D data->slen=
);=0A=
+    g_assert(qcrypto_akcipher_max_dgst_len(pub_key) =3D=3D data->dlen);=0A=
+=0A=
+    /* A valid signature must verify. */=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, data->signature, data->slen,=
=0A=
+                                     data->dgst, data->dlen,=0A=
+                                     &error_abort) =3D=3D 0);=0A=
+=0A=
+    /* A tampered signature must fail (error is expected, so ignore it). *=
/=0A=
+    signature =3D g_memdup2(data->signature, data->slen);=0A=
+    signature[0]++;=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, signature, data->slen,=0A=
+                                     data->dgst, data->dlen, NULL) !=3D 0)=
;=0A=
+=0A=
+    /* A tampered digest must also fail. */=0A=
+    dgst =3D g_memdup2(data->dgst, data->dlen);=0A=
+    dgst[0]++;=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, data->signature, data->slen,=
=0A=
+                                     dgst, data->dlen, NULL) !=3D 0);=0A=
+}=0A=
+=0A=
+static void test_ecdsa_sign(const void *opaque)=0A=
+{=0A=
+    const QCryptoECDSATestData *data =3D opaque;=0A=
+    QCryptoAkCipherOptions opt =3D {=0A=
+        .alg =3D QCRYPTO_AK_CIPHER_ALGO_ECDSA,=0A=
+        .u.ecdsa =3D {=0A=
+            .curve_id =3D data->curve_id,=0A=
+        },=0A=
+    };=0A=
+    g_autoptr(QCryptoAkCipher) priv_key =3D NULL;=0A=
+    g_autoptr(QCryptoAkCipher) pub_key =3D NULL;=0A=
+    g_autofree uint8_t *signature =3D NULL;=0A=
+    int slen;=0A=
+=0A=
+    if (!qcrypto_akcipher_supports(&opt)) {=0A=
+        g_test_skip("ECDSA is not supported by the crypto backend");=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    priv_key =3D qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PRI=
VATE,=0A=
+                                    data->priv_key, data->priv_key_len,=0A=
+                                    &error_abort);=0A=
+    g_assert(priv_key !=3D NULL);=0A=
+=0A=
+    /*=0A=
+     * Sign the digest.=0A=
+     * ECDSA signatures are randomized so only length is fixed.=0A=
+     */=0A=
+    slen =3D qcrypto_akcipher_max_signature_len(priv_key);=0A=
+    signature =3D g_new0(uint8_t, slen);=0A=
+    g_assert(qcrypto_akcipher_sign(priv_key, data->dgst, data->dlen,=0A=
+                                   signature, slen, &error_abort) =3D=3D s=
len);=0A=
+=0A=
+    /* The freshly produced signature must verify with the public key. */=
=0A=
+    pub_key =3D qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBL=
IC,=0A=
+                                   data->pub_key, data->pub_key_len,=0A=
+                                   &error_abort);=0A=
+    g_assert(pub_key !=3D NULL);=0A=
+    g_assert(qcrypto_akcipher_verify(pub_key, signature, slen,=0A=
+                                     data->dgst, data->dlen,=0A=
+                                     &error_abort) =3D=3D 0);=0A=
+}=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     size_t i;=0A=
@@ -985,6 +1210,17 @@ int main(int argc, char **argv)=0A=
                              &rsakey_test_data[i],=0A=
                              test_rsakey);=0A=
     }=0A=
+    for (i =3D 0; i < G_N_ELEMENTS(ecdsa_test_data); i++) {=0A=
+        g_autofree char *verify_path =3D=0A=
+            g_strdup_printf("%s-verify", ecdsa_test_data[i].path);=0A=
+        g_autofree char *sign_path =3D=0A=
+            g_strdup_printf("%s-sign", ecdsa_test_data[i].path);=0A=
+=0A=
+        g_test_add_data_func(verify_path, &ecdsa_test_data[i],=0A=
+                             test_ecdsa_verify);=0A=
+        g_test_add_data_func(sign_path, &ecdsa_test_data[i],=0A=
+                             test_ecdsa_sign);=0A=
+    }=0A=
 =0A=
     return g_test_run();=0A=
 }=0A=
-- =0A=
2.53.0=0A=

