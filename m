Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061EDC4450A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNr-0003Go-Pe; Tue, 14 Jul 2026 23:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNn-0003Fj-I9; Tue, 14 Jul 2026 23:34:04 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNl-0000oW-6d; Tue, 14 Jul 2026 23:34:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYri5MKM+TYmxFd5W6icGP+wzORWfm0AzWhIY0AUXCSTJgARwM09fIM2FTVdSGnOlwxHd8SEqSUPpDk69hEt/qrRSgdpfxsQKiCUmeQknnojql9OSVjI/9vnZocYE2HRMTs6VlIY4WmKaHtu64EUZapxXxdEoSwwU8sfHcJW+x8Sfp8Cx+fssWpQ5Nhb/cR4rHsNiQwjl6JWHhsBouYQ9Jp2mOH7GcW3Yt0ixSCwo1aGlaGmTq9GdeNA8F9/wHpkzI9+GWI9ZW9sOo03Fnzbfi9oZBp3/GFMYdlm4uTMX6jZMx9elB+//ocEjhMTwuKXgf7KEATDaCErSzNHW9sZ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLa7B88/O3Nts9mjHgvAJq568WN9KAWAdUCL9flLojM=;
 b=duKJgoGJko7Ce7AUwbw4rYezkZBJ5D+d/mkRh2hNVKvsTaTs1t/3t6OvxztBQXdwi80pbtl2EJVmUam6lKPR0FKEwmHBm7y1p5lTiksDkucteo1ZjGZ0bZw4HZFKGAwvYFKVeD9Nad6gX7wn2Xosfg/NA0vzh4sT8EmLdrbMCnYMFCfVmLZoDzrJS+P4DihRsEomiyYommaMHqBR3fypJPJm7DzA+bV9sXXbTkCDQKy3PUtlYm9iEPFfMst0t6WHASJjlaBijARWh96tKTaw36JmZpHDgk717Bbly+Zf6mGJGEb52Pz+3f+YrCkS0p0XTesJEDgBTCRvGEWKhxb1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLa7B88/O3Nts9mjHgvAJq568WN9KAWAdUCL9flLojM=;
 b=O/gVY2FPckV/b52/MakSGcQhAfFS/pe9ORPZYWpt9Wenf+wdcbwDIjWveLJRqUAoZCP1wq4nI8mbJHW1Rxn+u0r+tSZi0d4+TjaYK8TMKDMH1pCxQJZK30bV5x/gCAixlZJ66prOv4QaxoUBJttEaUKSMi3nFRGHA3DvHXHk41H5P7o5gFCkqg/MZ95yz3h3wzCyCoD2ebUtyxDyTL8qg3xSGx97iKEtdhxJhl0CuKtqewnLbZyX/EyVBKgRzDDEswwy0c+uo0e2cbnwnaqvZVdW2MhZNrqgEBgGk3vymuRwxOhmro8g4Id5KpcY7rgEDoYkKs2ifShos6ngRStW1A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:33 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:33 +0000
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
Subject: [PATCH v2 12/17] tests/unit/test-crypto-cipher: Test AES-GCM mode
Thread-Topic: [PATCH v2 12/17] tests/unit/test-crypto-cipher: Test AES-GCM mode
Thread-Index: AQHdFAq2GURAIf9gqUuVLHKzpb9lXQ==
Date: Wed, 15 Jul 2026 03:33:32 +0000
Message-ID: <20260715033311.1648424-13-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 9c933c46-30eb-457b-96f7-08dee221d8aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|6133799003|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: jTC2FTGYVKd2aoA0XZTjE3XsqKjHUqN3dHYeltpfK17QukxIFCtSpWTj1ra7p4d8nel5siK8/JA9xpRpOPTyN0UiYATj7dZtuwSmwxp0py2TndH5iaWOBkxEoQ5ZUrxPPlc68zSrAxJBAn5+E/qeEu1BoMDzItCn4tdOV8slBxcVQ8mbDvMWANuNU6Tnru/U8xiWinqr8w2YEbj5aFAPDFfTqvMDyTjDOO0monIV//9m90BtWq5UFlM754PXPLmKmcyIIMft0AaNiW4tOsc3mmHX/PoEGQvUlEwL03/6Do+azBx68Gp2LbKrdGYBsx7Fketk6Ae+lJiQ/8GXSsuGoOfaAULBGsOnZmBE3q+WI5VZ2jX5liBFESzYvjSaif1364sigf2r6BR2rlbfVBQkyQgDzWHj4mGBLq7V4l1BLkAA+w3Pk2rB0JFojxv4dt/Fg54/C3xegK5yYRAmra7K+G9zQZonzalsFJzYIdb7R6p61kMxHsx4YG6by0TrgcPqhYVp281n7vcp8zN8VZ1VoHqFkix3btc+oV47y4stbMGoBHwdOOi7/XuOZGqToPSogc6kS0DCpwquG/01ojwjBiQWsHYUph4J8DcoV1BxgsYgNQ9IMWWKpQStCZ8oPvVFEG8QElJWEpGQJ3v8RM3tEgkId/pKA1pYrw8juTNu2DTpyy16tWFuGdxzaJMSobu9nHKJeHTMmcv1jlA4Iz5OlL6XWoE6CDsJ0F5zwMz3GPvVXO3TbGjdCPOkPUTkVv4x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fEYULTtymFRsM6nccDtanIs0U0IumtqSdcz37m/r5QClKnIyKbJyUVIqNB?=
 =?iso-8859-1?Q?N21F6+Z4IC3M2+dj1pi31AXu4ncTDrrZeT5PxFNcpX0N4iuqadMMgjuAlr?=
 =?iso-8859-1?Q?xo1I2Rc9b0aYVQ3uJU7zTWNLU6E/3N5Cr63M4Z9u1P/sZggxe5eU4a4oiJ?=
 =?iso-8859-1?Q?K5aQRx04aERphdBQ77Ii485MrEairqkJtjLbPyXTZaUmiGilsSyZ8edxcs?=
 =?iso-8859-1?Q?caBlGUuMdN3vr3ojG3QCCwQHA5DirqAVsCbSpn2ht4tRPeusBVLQTRnlQg?=
 =?iso-8859-1?Q?0iRArHGZ5JpTEwZob4KQ/tQBswPrJbQU7IrcQgiIzWHvYtK80k/GYZIlHw?=
 =?iso-8859-1?Q?HJ7Y8HTK+eyN6OFEJ1UAyg94nBezXkOc+9srQypqHhdCjokJ7vaKoTGEfD?=
 =?iso-8859-1?Q?tci5xZpzEcQNK+q+bvwspnUmLep+fKoJ5V2hh+kyMNvuskzDkToUK9oOZf?=
 =?iso-8859-1?Q?POKv/sX+8FD4YKRsFl6CCW6Ftcq83YIXZo4Xi6vuRZWxqRI9819LrtYQyB?=
 =?iso-8859-1?Q?hVsw6rUHLoH6fSvvvEQYP/9Aiqt2qKSfrkUenUsiVp5WwN2ZYIh4wij84p?=
 =?iso-8859-1?Q?4hUgSwIoVsGuHOSQKBfzHowSl7BeG+nzlUk34uQ6XfwcvA3TQBylVfiHdq?=
 =?iso-8859-1?Q?sFHrs3II3DAhm7lsN2Z9hH5ti7IYve1iuZitZDBF3GLJI8JVJC191gCJlm?=
 =?iso-8859-1?Q?ZaKHXMKk0jattJSKJ0lmQXphCWx/Bel8pvlUNZDfwxW6bm/IJzRKqeEWG/?=
 =?iso-8859-1?Q?51uglyOEeFoHgm3KNS+CHQ1NLLiipwsUANAg191xqOrlKha882rNnyiV2R?=
 =?iso-8859-1?Q?7FkryU5LJDACqxgss1YEPqEPM75dgqyTidj3N4xdv/xUdNGoaUZ3mL+26E?=
 =?iso-8859-1?Q?mykg7j7jzXAOnk9BHFWexkkUA7XzfXA6OcazYv5iKsbvy243LXBbF+ahsA?=
 =?iso-8859-1?Q?olkkTAWDusIg2r9LuyaRK5UGMiV5DMdoJXruIsocCUUNeKiusUmE9YhR0Q?=
 =?iso-8859-1?Q?YXE9CVwR7vTnCejAEzJsJ29P9wwzEWzyQSVulZ+ma0XhwsQKt7sn2jAOMR?=
 =?iso-8859-1?Q?UlEP+aiatBN13CoaFUJxe4HLFltUQaNI8P/YV7rkMukEkZCGipyTAqx6Eg?=
 =?iso-8859-1?Q?O5zjkC00NYrVGbccqGXlS6BBtnjyI47mDu0U2/XVWeV7UmearpjhpIxlJ0?=
 =?iso-8859-1?Q?R82fLJQILbvnCDSM2bm3ik7tL3da6O5sHLpJXLjeak75aG4GNZ4vMvp0Vv?=
 =?iso-8859-1?Q?xD726vaVQFsJ9UT1Ncx5K1r0Rw7iF3/BWIoMfqtDonNJx31d8YJuJD4lmg?=
 =?iso-8859-1?Q?v36UQ0EoMpVkz57BYPCIvrZ+EBRMEqPbCNnVoEoKLwSxWKLzUSWgtGa2JO?=
 =?iso-8859-1?Q?9dKWsQw/bcx+mls5HAvlBjLc+qrrcaPZC6OGK3ONaJ+aePSn7I9/UwRVZ3?=
 =?iso-8859-1?Q?NYnndt6OsVVbNDdlIaCtouHuExfD22MCXvyqRmWUciQtXgRjfp9evOzFFO?=
 =?iso-8859-1?Q?/TjmlDsRZJvQyk43jmnDszPvf4q+6+g4TzPQmik5Z5KgxTycNsozsXvzLs?=
 =?iso-8859-1?Q?6kEORadaGESolxtTSN3z5glVrA++umi4zs0I3cna3O6Fv9ADLghaQvpjPX?=
 =?iso-8859-1?Q?ji09PO4jfbVoJoOj5gl1FdXEfsRrJWqHlDLRqFgP5vqZ3rVNC4vAy7YiR2?=
 =?iso-8859-1?Q?/k+9ZF/OCT6I7TjGPU+FmZTgqqQtgocqvXy/QVSa5BIwSVdBZviA44+b/7?=
 =?iso-8859-1?Q?qmP0DQ4uhAa0cEyWFjcQ/ykyESRj1vTrqZdppFkycjlAdmKrHgtd5D+Rvb?=
 =?iso-8859-1?Q?MXTMh+dXew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YVrhgf7kUqlJwQ7vxP1Sh4YE3H1WJUgPAEszZjgjUgM10LSSMhBR2JVD7AmSRhboZWPUQHfDHZ7Q2Eam+c7xk2p4Jk+wvhCArCgRdqrYpgKy0u1rlZLQGbLPKol4cJ9PnpuH06Q1Z2rzBxCsbjVD3RaLkyYShNISdlpce0xf/urIqEpvRds6fFHq7BM+vl5uCI3YmlyjRWhpnrh0QpWV30LkFMwvUTXDCjq8rketk23keiQif8gOS5m+BJVKONkBjeaincj4cDUjre6gnTk3kxMp2zcVqiBQBB4X/ddkFU+j4D44JynbbgutcywMocnPGgIQpVNxYgYWx3uMJ5TcPA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c933c46-30eb-457b-96f7-08dee221d8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:32.9842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QYqKmx9BjGIY8Q5l4OJOh6y2q5fbLefDUEk2wZF9gYTlqtj9DFPD3PcyaYA8enzKAEbGoHlfnKtLSRvwAiUScntgaZPRufk0XtkUvG/BTQ=
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

Exercise the new GCM mode and the setaad/gettag helpers with the=0A=
canonical AES-GCM test vectors from the GCM specification (McGrew &=0A=
Viega, also NIST SP 800-38D): AES-128 and AES-256, with and without=0A=
associated data. Each vector is run through encrypt (checking the=0A=
ciphertext and the generated tag) and decrypt (checking the recovered=0A=
plaintext and the recomputed tag).=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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

