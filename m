Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4D2C5B573
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYV-0007N0-Jz; Tue, 11 Aug 2026 02:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYS-0007Kv-NZ; Tue, 11 Aug 2026 02:01:40 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYQ-0002gH-MS; Tue, 11 Aug 2026 02:01:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmolRMbF0qHszrIiypniCn6cfgVzHeSolj2rNsqVGSr9gC57wT5nSHwzM3oNsVsg3Maz7cMMSS7ib2psWZfB9wiNwA6XkhmPyNfG+bo371e/amGCrDdpwu8Dnhaf+52hIvcrVU7OzWONj0O/VUW7geUsXwQFxdAe5pv3qpLugxVOHw+/qsQAmiiAqnziFRNLpDxRg6FD8ZGhqVu6OSkl5pelKBG5o1hX410c1ehTr2hoqvBVTbGoL9ewBfwgph4s49MYBLf4kt0f0KieosXv+VAxnzu77OoDWlOwK6KYCnRWx9Ghsg4qwAd6KZqp1P9d9oorG3f3I51WeZ3PTY8IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb90fRlcN9SUcYKr1r+eW5qyIMfSpp4KB18syXY9sKA=;
 b=xpNdgQKSJPTdIwrR8qvY0zDXRFg9JsVnpy8GstTpoL6X134L30pXIzDvt1AUNkqMGDoNnelUNo3lt93X71LPtVXxg4dx2nlGZ392SB9eSRuyUstP+uww5s9j9VZ8PdKuPehRb2vYdlZRagM9QR9LFKjqvk5pucslZp2wckSkkHDBU8Tc+7fY4eWsSlrkWGDDGKTDueTqHsIESl5lvJKU5EsdA+B9j+kzKsJTw90Wy2ATkdDKaWSESj4BloHi2ek/0gOW441DA5NBebIQKYVjTL7arPQD7r1aAR5PP1xaTUFFdgda0BdFZ5zavLYDAhWO5Igv3doxcUJfzRCSYlya6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb90fRlcN9SUcYKr1r+eW5qyIMfSpp4KB18syXY9sKA=;
 b=KIvLDF/gB9K06uClRc/bf0weRc/SIgkKEMH1CYA8KefmrmGZiKn9Q6dnt+ZusFG/u3+c1vO64Gg7Lpe5aBTTE5ib7s9+rDIEmuzECHBf6TOhlaRrbcIybU5ev8DPU+3YEtlgnr/RTCAFbDnMz90rCFw4IFo3bCHS9lDlqjg8wYz+5bTzbWRgngd1XLRtyGzvrWFfrcVb7e8dQodiBtGFGDPiMt5/GyOayMvVBe+mLcvECwlBKQgt0Fhh4QGeoAIgTZ/PWIt82F1VDfBvJ/lqe3Shfj2QpXFDaTL/EAkw64xa2kIrDhr3OB2Y0mIGT7CUVqS8qtG2ZuGZD1KgLiLt4w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5419.apcprd06.prod.outlook.com (2603:1096:400:201::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:32 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:32 +0000
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
Subject: [PATCH v4 12/16] tests/unit/test-crypto-cipher: Test AES-GCM mode
Thread-Topic: [PATCH v4 12/16] tests/unit/test-crypto-cipher: Test AES-GCM mode
Thread-Index: AQHdKVbcm0OQj53pv0W/hefl2TNMGA==
Date: Tue, 11 Aug 2026 06:01:32 +0000
Message-ID: <20260811060115.1849266-13-jamin_lin@aspeedtech.com>
References: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5419:EE_
x-ms-office365-filtering-correlation-id: 54c08f18-84e5-43a1-50e9-08def76dfe94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|38070700021|6133799003|22082099003|18002099003|921020;
x-microsoft-antispam-message-info: Ug+pco80vjCvZLbFaObPMF9KHqcAsITEex0CkT6sPSiyI5C6bOp0+iM06po496s4t8wwqOicBxz8A8lEYng5Kxy7vllBO4JVMrcb36CO7YMWEZGzdacWtfFQ0JfIhtgx7Ge0YL9qUjlOnuVQZueIN7CMyLNYMFunYsq9IIxlZk3Z8IGREiJzSWAInW14LSPXwcDD5vwMvxznWagps30eu9hGEBkxRbomgbK6ne/nR5DPe+TTHKV/MJxSfIy5LS1rzq3dtfqZjbPCkZhmWDhKQVnyv+GE1fa3HDtOm3SqTNmfmFPxiCEy/CCunAa9Y61fxiDUEU+7VwQaM/0t9nqUry5n5Uey7gMJ+JIEAaHvhQkv5lConGlKSv0phL7NDEQ0qyUjhdEuWSIzYjACNA4HxaFvoIEoYLVeFjL7WYWz9rnybipRUCRvQ14hpfcyCVQy2A+ZTyfc3T9jdfGjORRt6gTiFuE/0zbyZa+I9ewk4ms+RRKMMFaFzW08TODZpEhflsAU2sU7RPcRgPU49UAVT+13e0wq0cUM32qp1yvFJXqa2o14nnzMPY3YCXlDCgx5qzMr88QLFauFW2VFwrIHEk/R24xuZXl3DeY/qF0i0O66j3vV92pDqppjujBtpzacKuZqKlHB7BHo1P3KEOyOpxyMolkLbu1awz8LQR7N9LRZ7qWc41/ZuJgGYkKmqgAaAp2crCd87TvFKGKmeMgWyLO2wLrkINtozyX/EJ/jKcTpmRBIjIk6SRkNrbgkpu3J
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Szgxq/hsXXI4AfZ/iMEGRNHr1s7oGuPLdSmICWzgu0IZ9ZM89FlWbzP7Q8?=
 =?iso-8859-1?Q?ZCeLqSRjvd0bffgdGcgbA3QojceAcgErs/RrH9GdRP4R7poAMZNlmFwuGo?=
 =?iso-8859-1?Q?dfJvD3wzUw5dAQPJBlgHmxY00GeEugLdHJ6e7AleyTXB+CLSPBGz0PKUbs?=
 =?iso-8859-1?Q?a/BcK3kaP9xfA8wGp4CLd+9hwlnoHXCtjN0oQGqbziZBJ4fuqtjNIsTana?=
 =?iso-8859-1?Q?XOmwbpfGDbLd9TSbsOg6W648Z5CyoeSkeYSPhQQzMWYhHV95jtiCLWv1vW?=
 =?iso-8859-1?Q?08PlNxZANdIhdu/sma4BkXMi5dMKRLd//LrZAeL8Y8Wxo432MZ77MSeXRE?=
 =?iso-8859-1?Q?Gpcxu8eTpfTij3QKeeZqT0darfGtHqKNCp1P/bl255Lk2OGOHmYMqnB/2I?=
 =?iso-8859-1?Q?e5J1sdH+NhoXCMP4GZ0RrRA3q226CFFH3YjgcsOKeelM+o2iOMNjTMgLU2?=
 =?iso-8859-1?Q?qalCkfRWqdaKLhzjnqACTjjfEwE6UGvp/JJLmjCV/ZFNJuuwmo+NE1aYzQ?=
 =?iso-8859-1?Q?v+PjUdRq4c2qPgZvYDNT3rAflgPbjdoTBIV6tX1ACggB/1n91UMJg1x0RE?=
 =?iso-8859-1?Q?XZOemGtpggYncVzqGGCCVYEr8V8ewk3RxXEa2K5BnPfXnj9ivb/8FGVqND?=
 =?iso-8859-1?Q?rqBlwYVqB2aesaC5KBNIHm20CodXVR4cVzdwvQS8ZyIq1qErNXHa7fcPyf?=
 =?iso-8859-1?Q?AYyXCluDQygYYxuLz6zdRsBs2rz689uOA51+TmzEhjKZTbPGVxeHh+s6RT?=
 =?iso-8859-1?Q?vyHVdXuLHBqrcNu0f5uhjWozI0cLlelsC7fY1bDIxZvjmTiBBshjOSu3MK?=
 =?iso-8859-1?Q?/Qqr6IDwuZ0zBj38E1dWYUM//H9SSUCWqssf6Ajw+pjgE+FN5nrZffDtD5?=
 =?iso-8859-1?Q?AMCRMDQtLbUjZcbOO2bzP3wcPasdgZADZbWzMgdwyqn7Y8jJjzRla7un0o?=
 =?iso-8859-1?Q?SD/xIEiJOBBbYDfnzcom+0nEHXgyM3R4Pt41Ir1sUNpXPpWHie1fGNT1lu?=
 =?iso-8859-1?Q?1EdpJzhrkGoBRz0xyAphkznym+dtir4RqB6d8pUVSl5uX0fcAC3L9oOPhY?=
 =?iso-8859-1?Q?m6kItEl/6lTu3EnCAy6do2Yoh+f9lUCUQZLrcYdHuy96FKB0TA5Kc7CPfR?=
 =?iso-8859-1?Q?ksfyUG/mGb2/qbLQyi5SweS5xsS7UsfIUvG94Qz9Ug3FGJ6INX6aQsNc7d?=
 =?iso-8859-1?Q?Dr3om40ElOJuR+hWEyMpeKvWRl8NJBjWYSSzVpp4STEBgC33th9kHhgR8e?=
 =?iso-8859-1?Q?MZci/hrWSQ7dUXj0NQrrz2F+gZkrWCxWGiWITVSICvlNAVc3y/WUQGmQm1?=
 =?iso-8859-1?Q?SuQTCO67u88tVUjWw6EEirWiEuN24HZKjKkrmtmLpgqZssi2Fd5W5aXsLZ?=
 =?iso-8859-1?Q?TaVKM0YX5iCgqVmjolimsCejLxOYQRP6Rqh0gkzO0da+QvMS0LyW4XRA9D?=
 =?iso-8859-1?Q?d84jTxk+D41bEj4uzZHv0Qo84qZ57ZCc/pK7m69ITHKQ0jAPw/GFJDb7C5?=
 =?iso-8859-1?Q?bFKWgsD/RipQNrm8YJrU3ArcA2LRkPnu1++pXbd/AFYfKanq/jxeZKN570?=
 =?iso-8859-1?Q?3ioLd2l5HilFmOSof7bfpvswRYVUofNe6mIEnd+dTinj6h8DG3gOIuj0pA?=
 =?iso-8859-1?Q?7gb1EMZieEgi15wXhm2dufQmAjbZtA3jXYtSHfbRdnc2NHrrQIuKJDVwsW?=
 =?iso-8859-1?Q?E948AEX0PljFx+gYGrPMDSjTzielQ3kTCH6VuwCXd159sH1Jd8+nqy/0je?=
 =?iso-8859-1?Q?cHt14obe0wfJPjD7WQh6WCu4fID9fPOXbw5uwby1FQuF9phAQ/T752Nm9e?=
 =?iso-8859-1?Q?1XIHjG5GsA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kXDWJbIreJZOFrNDvrYulOkYtUn9hHmt7xvGOJudU1DzWG3fbaTGlInRwcQ3a4mimQt92ZgzAn4EqVFXy/S5FDchiO3Ca/YQBuW9+uGVWhDFDGAfrHfvCl6HuXF8A3i9L7FKpqdTFp2RYda/RH0OarWsDebIoygY1Qf7xY6FaYG9mkRQ+rmNHF+C8W3VawqMzEtc4Y4Rm51TapJQvI4ET7+2SzvDIUo2yMvvb9HEa1vyvXO/jOBCc89xnQsg9lLiv8Ha5Amg63jrPkO54MblvFhRA3nCZVuWeF4TcFF8YJqXaHF0W/wIozJURaN3E69/7j+Nf2uzu49Jql2NjN85fg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c08f18-84e5-43a1-50e9-08def76dfe94
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:32.7633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6iouBvjTz5qOrGtuzG0sqPT0LE8JcsNTD7rTHLWpAc1TyCVgKF+7ndcAZxCzT6hHGWuESMYgRPub8GxOs6Z0ShG31sB2FVTcALw6nUjcOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5419
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

