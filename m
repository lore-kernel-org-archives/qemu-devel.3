Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE59C5B570
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtctb-0003wA-CT; Mon, 10 Aug 2026 23:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctY-0003uZ-Jr; Mon, 10 Aug 2026 23:11:16 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctV-0004JO-Mc; Mon, 10 Aug 2026 23:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEb8P+WchkS/6xfS16mXX3wRC/sgAnj7QALmGXmuHC1H1BiEGgIY88SE/4xHjVJntGMZlBOvDgzKPrbSxUsUGq4rOpjeBVgdoGZYyRvE8tawQBNz0m3DyHwUz6Yi2/looI/R750cTNSG5BesQZuczAdTz5Q2VqdQg7vRbt+9D8ds0AmLISngA60Bj42D+S1RueAOPkj6AK4VSFnAvl8kh9VXnibG+azpAVA65rHvVeB9uLOFfVjRdHPiFKjuaofasNI0lwsyP38QixNpkMmVoYbE9vBSpJH0x7qU6JTM2dTX4QCoWgfzUopPcVn+vfflnIRPFjUsKAMw9y562llLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb90fRlcN9SUcYKr1r+eW5qyIMfSpp4KB18syXY9sKA=;
 b=d86jlkDUAyUSVOUZJaBCmseFbp8JO0Ir8/9HgFlhiJ9W/2zI90dc8c4EgVTpF3FDcr1RL5OCvKFwPQEzzAaenMpnby33bScrkeHq0gHynnUxqonSq0KgDCs4Q5xeWKIC2y/hFKjdNLICc3Cqj96Wj6ItP4/Q+GUKMqUqx09vcUcqwwfpMoAcFG3yKfh/uACDckmiVabWFSFEQU16fZgq18FfZwN7+SZQtDAE9z1rB9bKEgCoaFy7osnNVWjETgIciWj2yp4MCFndy4+GxEPCaJht2qYHuyZbn9DP+CXfEyo7hxXKZakMgigdubbc0ug1drp44dn3QB9naT8eHCOUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb90fRlcN9SUcYKr1r+eW5qyIMfSpp4KB18syXY9sKA=;
 b=Zq1VaYxSD9/g3Q50mBczjukrbpVTEbLn2fMppxh5pqbBTq+Y/fnBrZi2VBEqFReMXzxcCy/26TgcFYAuOXLQUEV18ouXV8fpoWp+aCn7G8cRtKT7b4wYLwZxlawTXFfjxu0lIk9EiVQz5KkHvxF44VJCLF0OAIsJ/7whfVzWfpZaZY19+RKKqklde24ZT5GgC2QfH/P8tRtBADqhWRurQgB2Lq166L5nk9w6VXONNMt0VSnqfU35oO3cdxKqmrd4kWyV3Ji5dIroWaKby27ONE0nocQbj302dXEAKImm9NxR6XX035NTzrMPzIAtaXwL6QZtYFa0i5qCUuglp5C7Gg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:42 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:42 +0000
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
Subject: [PATCH v3 12/16] tests/unit/test-crypto-cipher: Test AES-GCM mode
Thread-Topic: [PATCH v3 12/16] tests/unit/test-crypto-cipher: Test AES-GCM mode
Thread-Index: AQHdKT7+fbzf9HNUbkeEa/Ns1u0sCw==
Date: Tue, 11 Aug 2026 03:10:42 +0000
Message-ID: <20260811031025.2784489-13-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 09398387-e2ed-4475-466f-08def75620fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020|6133799003;
x-microsoft-antispam-message-info: 7X7ZYNhmc5mvjCYiEtJrNS694HvhGJcWOLrghelsS4OHlHFrAbmkAtRReY8Owhj1x7Gw126Twj5n6SNuG+CLTmyxiDCOe7uSKlzFGRCczQJXhME0FbGUKcg5UXQtUZOfpXExWv2Ok7qjfjeYqJouIRwHUznqIK9Afb/jDxCGmTJW5Ef1z6YUhh4znt/WU8QnIy2w5Kq0uoHDRoeoGj1xhk2jRVqgg6xyf+UUjmqSkfbNr1syXTwyNG0LrW4m1INOvPan08Jc1bw/ZVqByUosrFgoJVoHgJwKmMzxoK0Lgh1SspQiJZ5qVtCwHxBZ0tSp1eosfFL2Nb4tYZIZyW3jc+j1G8nKNecdIV3DPvVaNz752FCI8Ri61x/Lh4PbzZzn/D/mjRfGm5ZioqkhRHq81lchWg+5z81dp0jHlPY0nfD9/FWuXkvxG8j8Rwq33cOGnM6IwcPqToHC4FCe7BBhLB1rU4z+IyvES0gftmFxWTKphXi4eKZTvtOmex3VEseB9uN3ykIxyxuy6/Z18H/z/dGbUB+6VXXQQjHApSjSog0a323wPdeyJWXD106PFeGt7ZjFXz2CL4z6lj9+bnjjsRrCbqWOMqtj2Nkf3qRWkhk73XfuSGSY/cRWEUe1HiX8GEs16A7MahPCAsDgiWz91RYUd5lojQPtWJg0hHlEoGKnd53j87enj3+xlvhoQsoPha56gC5u2BuioFabXY1nTOrXBx7lagtfxecaFFd4rq0QAJogODyGrcZ45A/eYOsD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VDMmYbj2CJutwgL+DNU7ZNneKRiisX+DUuioYCh2JFCQu/Ns6IxpPfLO4g?=
 =?iso-8859-1?Q?MNUycykNmpmJb6VxQk7JCgwHTUZ8c9bIa44BCTHF2C1n2QodKV0YoCojrU?=
 =?iso-8859-1?Q?sBSXmuzTEYRLmMtfImM/OyRiGv8w2S2e68mpu1geTlaBEW664XGY4JJ7qI?=
 =?iso-8859-1?Q?cTreREJRfd1eFzggzhcWOpoYCgrkUY7C9998VTceOq3a0D3nO6pSJkWOxt?=
 =?iso-8859-1?Q?sbl+56dVXmvbLFya9Gov7hbXiEWIAHQabLR3sVpCUkjh97MBiv7M7Kza4h?=
 =?iso-8859-1?Q?P/15Qkg4CujzJynSJLCuQX/olmzDkdJ6/DkUFYf0hKYphIRLLstRywJI9q?=
 =?iso-8859-1?Q?jLBSThuFg/RyW09iyxw4dIFImyDSpdkBqNTtDw6+jRNf5qUq87fEnnRKEl?=
 =?iso-8859-1?Q?hKBEXg0Q/fPVi1VTqSpkrFqwec5g5yuMs8ASDcQSO7/+Yz+lJMc2YyxQ4N?=
 =?iso-8859-1?Q?N9+p1CUbrTynnId9Aj2GXHqnjfORthbLXIFrTklFrNTehoUqYgzNmBjDQX?=
 =?iso-8859-1?Q?02/Y1ZrgIdG4jFaknk9IXA6P5y1hH+lALV47khvihe/WujV30S8uTxus4B?=
 =?iso-8859-1?Q?F87pSu03IGCJX07seolkYht27WacljfwLHONRXtykeZtIyqLi4mF1OSnYn?=
 =?iso-8859-1?Q?KL9GaOCs+5UJMDRj/KI4W9jS0m22b3kKq3ee7+Q/tI1igcBaQiatD0Qvyp?=
 =?iso-8859-1?Q?YwhhgmsaMS3POedoJPqd+jOT3p1qntfdl7W1pjeZhd1qxpa16jylq2ZPyk?=
 =?iso-8859-1?Q?WTTkF7XrvGQ4pFvXJiXP+8p9PKsj3/sUPrr93YmamqpOVW3gN6v9395/f/?=
 =?iso-8859-1?Q?2DsLI7G27ndajQQ8sZVr/VreRl1tbsQ8nm6GIfwHkoXiKABO8QQ/atGLl5?=
 =?iso-8859-1?Q?Dnt26kg0zWerJAM2Z4Tjhb+YzQzaTvSMYCHxlAjJjbsc4uHmKoz1OTazmq?=
 =?iso-8859-1?Q?fdjTAo+9ymm84Z48cA8RIte1umrIRBLA0Gwgs6igSPj4Uiu77acznfpYrD?=
 =?iso-8859-1?Q?81KnycDT8B/C0fqcaIdSqLuyZwwdStHW0R15PoE/6TDsqhWP3bVQoyBOei?=
 =?iso-8859-1?Q?DuQOfl+LMJMAJbSs+g6kYrkyvXomIAXrK0ERkEZgxz3t0CVxZuQCrp5h1R?=
 =?iso-8859-1?Q?SM9nzd8n+jL34o5J18EH0k0fV6y9dxkizX8jCz2rwPR2lbZSk4CpbxBHeG?=
 =?iso-8859-1?Q?KDr7BhJc4w+P9y4UwrLVkedkG/hydnwRmYF+3FoquNC09Eum5nc6arnPIv?=
 =?iso-8859-1?Q?3YRxWbhgoA/A5h0K0oxRIupwvgWV5Ul9zfnaDEWeNKux0jwiQv/fgaTaGm?=
 =?iso-8859-1?Q?v78dAaDHgz8tRi3+bMr+91g051CPkW1AfyFEKyfh1Y9ubn3BL02dnT2St/?=
 =?iso-8859-1?Q?uxZ8sGCtJvI7Ya2eimqezR8Chn//5CX7FxUJ/Je9QB8FjbAPx8H/6vvKVt?=
 =?iso-8859-1?Q?Zi6GS/hbmQ8ENAUkbRbAMlNXnl11CTYbMj6aSJQZgaUYpLqln91S4a2w0K?=
 =?iso-8859-1?Q?dYBzneKppi4tkFx6NPsHkk5RetSF+fSHFO9ylM6wQL6mjtlMLfgOJQvDlL?=
 =?iso-8859-1?Q?DESxa6TeBrz81bnZKczY6ydWlf+B6670nTz57FmVnStwAUmKmA8thxPjyH?=
 =?iso-8859-1?Q?uz1CgpF8YMgbDyehGuyJkCGTmYqe9RbMFRiSnlYDsyrfopU35+YC7SQTja?=
 =?iso-8859-1?Q?s7Z41F1rZon1dXYJDzG/+zX9YJu87UEYm3DGl/iFWRWFMcuFZPJtird95l?=
 =?iso-8859-1?Q?YC38esHuLDUz84g2dNYEzuDiDhj2KME0USBWxCzIly1h3ZZ/VFjQFH9VwP?=
 =?iso-8859-1?Q?8Y8Vsn/obQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hzf5oA6VxbtsuuNjakp2csned2jV1taEBg+/bpHp3APixTwmrdExvzus6ibeF5bGCTLF4QaCBKWcR5cAaqYkIob1cFNYLV6x7G81ZLo29Qw0XWTVYEKa00xW0le0bwgOPSZ8VxckaCCBQo5OxjjMDhIjA/AhZChssPSAsTjjMyyAjuUYDmVYNS8WjSzbQtpuyfcFWKz+lZFDJM8RO6WWir7qElDsOtGQPj/V5VfAv04+XeMmpUMqiFldFqNqhAk+ZL7JqgW+3x6nMgUBz1zWccq+VSocjWOMhE9byn2DNyiLR7NBp8xLjIf4xj1ALk9hi9oDIV3KTJqqBYs7EfAbzg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09398387-e2ed-4475-466f-08def75620fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:42.4882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOb9sReMsaKyTVIGKIu7uDqInOHczgBxWWi3dVi84Uy/LkruWmo7y+d0a1yfX+DpgKz9rnuM4UZC7Yhm8kAmrFj9rYE3FDdRvvvkRtEkJ+w=
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

Exercise the new GCM mode and the setaad/gettag helpers with the=0A=
canonical AES-GCM test vectors from the GCM specification (McGrew &=0A=
Viega, also NIST SP 800-38D): AES-128 and AES-256, with and without=0A=
associated data. Each vector is run through encrypt (checking the=0A=
ciphertext and the generated tag) and decrypt (checking the recovered=0A=
plaintext and the recomputed tag).=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>=0A=
---=0A=
 tests/unit/test-crypto-cipher.c | 240 ++++++++++++++++++++++++++++++++=0A=
 1 file changed, 240 insertions(+)=0A=
=0A=
diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-ciphe=
r.c=0A=
index 1331d558cf..420c826df9 100644=0A=
--- a/tests/unit/test-crypto-cipher.c=0A=
+++ b/tests/unit/test-crypto-cipher.c=0A=
@@ -810,6 +810,230 @@ static void test_cipher_short_plaintext(void)=0A=
     qcrypto_cipher_free(cipher);=0A=
 }=0A=
 =0A=
+typedef struct QCryptoCipherGcmTestData QCryptoCipherGcmTestData;=0A=
+struct QCryptoCipherGcmTestData {=0A=
+    const char *path;=0A=
+    QCryptoCipherAlgo alg;=0A=
+    const char *key;=0A=
+    const char *iv;=0A=
+    /* associated data, or NULL for none */=0A=
+    const char *aad;=0A=
+    const char *plaintext;=0A=
+    const char *ciphertext;=0A=
+    const char *tag;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * AES-GCM test vectors from "The Galois/Counter Mode of Operation (GCM)"=
=0A=
+ * (McGrew & Viega, also NIST SP 800-38D), with a 96-bit IV and a 128-bit=
=0A=
+ * tag. Each entry's "Test case N" label is the numbered test case from th=
at=0A=
+ * document (Appendix B / the GCM specification's test vectors).=0A=
+ */=0A=
+static QCryptoCipherGcmTestData gcm_test_data[] =3D {=0A=
+    {=0A=
+        /* Test case 2 */=0A=
+        .path =3D "/crypto/cipher/aes-gcm-128-2",=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .key =3D "00000000000000000000000000000000",=0A=
+        .iv =3D "000000000000000000000000",=0A=
+        .plaintext =3D "00000000000000000000000000000000",=0A=
+        .ciphertext =3D "0388dace60b6a392f328c2b971b2fe78",=0A=
+        .tag =3D "ab6e47d42cec13bdf53a67b21257bddf",=0A=
+    },=0A=
+    {=0A=
+        /* Test case 3 (no AAD) */=0A=
+        .path =3D "/crypto/cipher/aes-gcm-128-3",=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .key =3D "feffe9928665731c6d6a8f9467308308",=0A=
+        .iv =3D "cafebabefacedbaddecaf888",=0A=
+        .plaintext =3D=0A=
+            "d9313225f88406e5a55909c5aff5269a"=0A=
+            "86a7a9531534f7da2e4c303d8a318a72"=0A=
+            "1c3c0c95956809532fcf0e2449a6b525"=0A=
+            "b16aedf5aa0de657ba637b391aafd255",=0A=
+        .ciphertext =3D=0A=
+            "42831ec2217774244b7221b784d0d49c"=0A=
+            "e3aa212f2c02a4e035c17e2329aca12e"=0A=
+            "21d514b25466931c7d8f6a5aac84aa05"=0A=
+            "1ba30b396a0aac973d58e091473f5985",=0A=
+        .tag =3D "4d5c2af327cd64a62cf35abd2ba6fab4",=0A=
+    },=0A=
+    {=0A=
+        /* Test case 4 (with AAD) */=0A=
+        .path =3D "/crypto/cipher/aes-gcm-128-4",=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .key =3D "feffe9928665731c6d6a8f9467308308",=0A=
+        .iv =3D "cafebabefacedbaddecaf888",=0A=
+        .aad =3D "feedfacedeadbeeffeedfacedeadbeefabaddad2",=0A=
+        .plaintext =3D=0A=
+            "d9313225f88406e5a55909c5aff5269a"=0A=
+            "86a7a9531534f7da2e4c303d8a318a72"=0A=
+            "1c3c0c95956809532fcf0e2449a6b525"=0A=
+            "b16aedf5aa0de657ba637b39",=0A=
+        .ciphertext =3D=0A=
+            "42831ec2217774244b7221b784d0d49c"=0A=
+            "e3aa212f2c02a4e035c17e2329aca12e"=0A=
+            "21d514b25466931c7d8f6a5aac84aa05"=0A=
+            "1ba30b396a0aac973d58e091",=0A=
+        .tag =3D "5bc94fbc3221a5db94fae95ae7121a47",=0A=
+    },=0A=
+    {=0A=
+        /* Test case 15 (AES-256, no AAD) */=0A=
+        .path =3D "/crypto/cipher/aes-gcm-256-15",=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_256,=0A=
+        .key =3D=0A=
+            "feffe9928665731c6d6a8f9467308308"=0A=
+            "feffe9928665731c6d6a8f9467308308",=0A=
+        .iv =3D "cafebabefacedbaddecaf888",=0A=
+        .plaintext =3D=0A=
+            "d9313225f88406e5a55909c5aff5269a"=0A=
+            "86a7a9531534f7da2e4c303d8a318a72"=0A=
+            "1c3c0c95956809532fcf0e2449a6b525"=0A=
+            "b16aedf5aa0de657ba637b391aafd255",=0A=
+        .ciphertext =3D=0A=
+            "522dc1f099567d07f47f37a32a84427d"=0A=
+            "643a8cdcbfe5c0c97598a2bd2555d1aa"=0A=
+            "8cb08e48590dbb3da7b08b1056828838"=0A=
+            "c5f61e6393ba7a0abcc9f662898015ad",=0A=
+        .tag =3D "b094dac5d93471bdec1a502270e3cc6c",=0A=
+    },=0A=
+    {=0A=
+        /* Test case 16 (AES-256, with AAD) */=0A=
+        .path =3D "/crypto/cipher/aes-gcm-256-16",=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_256,=0A=
+        .key =3D=0A=
+            "feffe9928665731c6d6a8f9467308308"=0A=
+            "feffe9928665731c6d6a8f9467308308",=0A=
+        .iv =3D "cafebabefacedbaddecaf888",=0A=
+        .aad =3D "feedfacedeadbeeffeedfacedeadbeefabaddad2",=0A=
+        .plaintext =3D=0A=
+            "d9313225f88406e5a55909c5aff5269a"=0A=
+            "86a7a9531534f7da2e4c303d8a318a72"=0A=
+            "1c3c0c95956809532fcf0e2449a6b525"=0A=
+            "b16aedf5aa0de657ba637b39",=0A=
+        .ciphertext =3D=0A=
+            "522dc1f099567d07f47f37a32a84427d"=0A=
+            "643a8cdcbfe5c0c97598a2bd2555d1aa"=0A=
+            "8cb08e48590dbb3da7b08b1056828838"=0A=
+            "c5f61e6393ba7a0abcc9f662",=0A=
+        .tag =3D "76fc6ece0f4e1768cddf8853bb2d551b",=0A=
+    },=0A=
+};=0A=
+=0A=
+static void test_cipher_gcm(const void *opaque)=0A=
+{=0A=
+    const QCryptoCipherGcmTestData *data =3D opaque;=0A=
+    g_autofree uint8_t *key =3D NULL;=0A=
+    g_autofree uint8_t *iv =3D NULL;=0A=
+    g_autofree uint8_t *aad =3D NULL;=0A=
+    g_autofree uint8_t *ptext =3D NULL;=0A=
+    g_autofree uint8_t *ctext =3D NULL;=0A=
+    g_autofree uint8_t *tagexp =3D NULL;=0A=
+    g_autofree uint8_t *out =3D NULL;=0A=
+    uint8_t tag[16];=0A=
+    size_t nkey;=0A=
+    size_t niv;=0A=
+    size_t naad =3D 0;=0A=
+    size_t nptext;=0A=
+    size_t nctext;=0A=
+    size_t ntag;=0A=
+    QCryptoCipher *cipher;=0A=
+=0A=
+    nkey =3D unhex_string(data->key, &key);=0A=
+    niv =3D unhex_string(data->iv, &iv);=0A=
+    nptext =3D unhex_string(data->plaintext, &ptext);=0A=
+    nctext =3D unhex_string(data->ciphertext, &ctext);=0A=
+    ntag =3D unhex_string(data->tag, &tagexp);=0A=
+    if (data->aad) {=0A=
+        naad =3D unhex_string(data->aad, &aad);=0A=
+    }=0A=
+=0A=
+    g_assert_cmpint(nptext, =3D=3D, nctext);=0A=
+    g_assert_cmpint(ntag, =3D=3D, sizeof(tag));=0A=
+    out =3D g_new0(uint8_t, nptext);=0A=
+=0A=
+    /* Encrypt: plaintext -> ciphertext, then read back the tag. */=0A=
+    cipher =3D qcrypto_cipher_new(data->alg, QCRYPTO_CIPHER_MODE_GCM,=0A=
+                                key, nkey, &error_abort);=0A=
+    g_assert(cipher !=3D NULL);=0A=
+    g_assert(qcrypto_cipher_setiv(cipher, iv, niv, &error_abort) =3D=3D 0)=
;=0A=
+    if (naad) {=0A=
+        g_assert(qcrypto_cipher_setaad(cipher, aad, naad, &error_abort) =
=3D=3D 0);=0A=
+    }=0A=
+    g_assert(qcrypto_cipher_encrypt(cipher, ptext, out, nptext,=0A=
+                                    &error_abort) =3D=3D 0);=0A=
+    g_assert_cmpmem(out, nptext, ctext, nctext);=0A=
+    g_assert(qcrypto_cipher_gettag(cipher, tag, sizeof(tag),=0A=
+                                   &error_abort) =3D=3D 0);=0A=
+    g_assert_cmpmem(tag, sizeof(tag), tagexp, ntag);=0A=
+    qcrypto_cipher_free(cipher);=0A=
+=0A=
+    /* Decrypt: ciphertext -> plaintext, recomputed tag must match. */=0A=
+    memset(out, 0, nptext);=0A=
+    cipher =3D qcrypto_cipher_new(data->alg, QCRYPTO_CIPHER_MODE_GCM,=0A=
+                                key, nkey, &error_abort);=0A=
+    g_assert(cipher !=3D NULL);=0A=
+    g_assert(qcrypto_cipher_setiv(cipher, iv, niv, &error_abort) =3D=3D 0)=
;=0A=
+    if (naad) {=0A=
+        g_assert(qcrypto_cipher_setaad(cipher, aad, naad, &error_abort) =
=3D=3D 0);=0A=
+    }=0A=
+    g_assert(qcrypto_cipher_decrypt(cipher, ctext, out, nctext,=0A=
+                                    &error_abort) =3D=3D 0);=0A=
+    g_assert_cmpmem(out, nctext, ptext, nptext);=0A=
+    g_assert(qcrypto_cipher_gettag(cipher, tag, sizeof(tag),=0A=
+                                   &error_abort) =3D=3D 0);=0A=
+    g_assert_cmpmem(tag, sizeof(tag), tagexp, ntag);=0A=
+    qcrypto_cipher_free(cipher);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Corrupt one ciphertext byte and confirm the recomputed GCM tag no longe=
r=0A=
+ * matches: the authentication tag must detect tampering.=0A=
+ */=0A=
+static void test_cipher_gcm_tamper(const void *opaque)=0A=
+{=0A=
+    const QCryptoCipherGcmTestData *data =3D opaque;=0A=
+    g_autofree uint8_t *key =3D NULL;=0A=
+    g_autofree uint8_t *iv =3D NULL;=0A=
+    g_autofree uint8_t *aad =3D NULL;=0A=
+    g_autofree uint8_t *ctext =3D NULL;=0A=
+    g_autofree uint8_t *tagexp =3D NULL;=0A=
+    g_autofree uint8_t *out =3D NULL;=0A=
+    uint8_t tag[16];=0A=
+    size_t nkey;=0A=
+    size_t niv;=0A=
+    size_t naad =3D 0;=0A=
+    size_t nctext;=0A=
+    size_t ntag;=0A=
+    QCryptoCipher *cipher;=0A=
+=0A=
+    nkey =3D unhex_string(data->key, &key);=0A=
+    niv =3D unhex_string(data->iv, &iv);=0A=
+    nctext =3D unhex_string(data->ciphertext, &ctext);=0A=
+    ntag =3D unhex_string(data->tag, &tagexp);=0A=
+    if (data->aad) {=0A=
+        naad =3D unhex_string(data->aad, &aad);=0A=
+    }=0A=
+    out =3D g_new0(uint8_t, nctext);=0A=
+=0A=
+    /* Flip one ciphertext bit before decrypting. */=0A=
+    ctext[0] ^=3D 0x01;=0A=
+=0A=
+    cipher =3D qcrypto_cipher_new(data->alg, QCRYPTO_CIPHER_MODE_GCM,=0A=
+                                key, nkey, &error_abort);=0A=
+    g_assert(cipher !=3D NULL);=0A=
+    g_assert(qcrypto_cipher_setiv(cipher, iv, niv, &error_abort) =3D=3D 0)=
;=0A=
+    if (naad) {=0A=
+        g_assert(qcrypto_cipher_setaad(cipher, aad, naad, &error_abort) =
=3D=3D 0);=0A=
+    }=0A=
+    g_assert(qcrypto_cipher_decrypt(cipher, ctext, out, nctext,=0A=
+                                    &error_abort) =3D=3D 0);=0A=
+    g_assert(qcrypto_cipher_gettag(cipher, tag, sizeof(tag),=0A=
+                                   &error_abort) =3D=3D 0);=0A=
+    g_assert(memcmp(tag, tagexp, ntag) !=3D 0);=0A=
+    qcrypto_cipher_free(cipher);=0A=
+}=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     size_t i;=0A=
@@ -828,6 +1052,22 @@ int main(int argc, char **argv)=0A=
         }=0A=
     }=0A=
 =0A=
+    for (i =3D 0; i < G_N_ELEMENTS(gcm_test_data); i++) {=0A=
+        if (qcrypto_cipher_supports(gcm_test_data[i].alg,=0A=
+                                    QCRYPTO_CIPHER_MODE_GCM)) {=0A=
+            g_autofree char *tamper =3D g_strdup_printf("%s/tamper",=0A=
+                                                      gcm_test_data[i].pat=
h);=0A=
+=0A=
+            g_test_add_data_func(gcm_test_data[i].path, &gcm_test_data[i],=
=0A=
+                                 test_cipher_gcm);=0A=
+            g_test_add_data_func(tamper, &gcm_test_data[i],=0A=
+                                 test_cipher_gcm_tamper);=0A=
+        } else {=0A=
+            g_printerr("# skip unsupported %s:gcm\n",=0A=
+                       QCryptoCipherAlgo_str(gcm_test_data[i].alg));=0A=
+        }=0A=
+    }=0A=
+=0A=
     if (qcrypto_cipher_supports(QCRYPTO_CIPHER_ALGO_AES_256,=0A=
                                 QCRYPTO_CIPHER_MODE_CBC)) {=0A=
         g_test_add_func("/crypto/cipher/null-iv",=0A=
-- =0A=
2.43.0=0A=

