Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67EBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXZx-0005lp-8A; Tue, 14 Jul 2026 03:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZv-0005l8-47; Tue, 14 Jul 2026 03:29:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZs-0006VZ-Kt; Tue, 14 Jul 2026 03:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7hoNGaElNRqQ+qgtlfNzkOYPQbWAYWvE2JPbwavzjK2CWL230dFajbJLRPAKc8HmZh82Mmfj+Uq7WMdsmHCcHisfEvi1jeNeDM0VOvuKVjL0KGh3HK5zBobm1Sq5Lm609qyIvULO7fE2JwQ7ZyJU+7oroXH5G7CJKfHhP6IN66y7eaF6CdbKX2AZ/dVIGIEteCfo96/etHzGIyRkaOsjyjUI/t36XzOevnyagkGlCYfjFtxARqQ51EnL8yUNnENNDqTnheQ9O0GK3YQrnwrtQCHK3tdP/KcVJA1bfLsczq0txX9uStU4iPOx7K5FjJs43wt7RPlwGUYvlCRL0luGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ9Iq3Vr/fizzkz8MTY3DU+LRWBHIcTIo6hh7Z+cTz4=;
 b=lBaPob7nLeu2lIXhScNRNI+pkNfZTprvIaTViBKja4APpejvZyz9j0/uAgX0e/t3ePcRVFucBCKr+N/fvMMezaLAg2jBYu2ECMcNe8/g0BZeMYfk5VTFRpJLVnnMvNUJ/6PkSP+mU2dky4pJvXee+Gzz1/tkqlusVvBmFs1WiiPTSvOKWEYBrFdh06DmYBUEu0gD/i39n7qv0XTReLaILM4tcp3kt2L2b3mqj+imwHiMa4ZhaYFx676TxrxR3OMH58fuSfc9XJT6AqPe27qhQHHVnNgV4xr3pN/SfDObZCLO8xVUqwpRT/uQkVARF66yh1+lPH4PZvqXNHWXYmrnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ9Iq3Vr/fizzkz8MTY3DU+LRWBHIcTIo6hh7Z+cTz4=;
 b=PYnNFJn3mWw2r8lib6xh26UhdtrAZliLP8GMb3tDCHJUDkS0ZuLl7Ff64w3Ia3zdp/Jg419wTX0OxEATp7SH7ANb64omZHhnCmVEebK4ihTkk8a5lygNElC6l6QvHZSRw/DkqzOXxURG6T5lonbA3fH1ussfDHTDXTt/9rgtNF43CQq2Y0iHXDayfAcvzlxrHcMi5cWphHdWGwUWtWo2zPCW8x8PLCIjQHA3jj6GkGmmVGmfNBVZtdv5jADd1iZK3kSmk9F0lbKd2v5eWOwZ4xd5HN19qFbSaWs89Q8CUeZFjLH56AgMBQ0OaGVA7z//WUC69PiQbeh183HXMDjHjg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:04 +0000
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
Subject: [PATCH v1 02/15] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2500
Thread-Topic: [PATCH v1 02/15] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2500
Thread-Index: AQHdE2Jyaj65+Qpto0i38zUtcmbcBw==
Date: Tue, 14 Jul 2026 07:29:04 +0000
Message-ID: <20260714072900.3023742-3-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: a7ea423c-68ae-41db-3ba7-08dee1799548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|3023799007|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: vWqPOZQmn117raeIkbCquKP5UuuvlmXqkEL2z8jartNLHZwogqVXkkefUSrCmzOUwhLFEdVR/sTEsQreJx8D1E3Ob9TAfH7lVUfV7ds85XL7PgSFr9bSqzXV1f5pn51SA1yTlUbRwpVJpDuxrvJUkK2waMgBBe4+2a4Ef50E/7cIG84fOv/QKtN1CtUVtxISwXmGeFyvJAZfY0yZTO4oMrFL11iIBNMGruct8xsvXyOZyTxd51a9YlwO+w1tQYeJ/v8ryhnYHLOIptgz5fezQ3NtBkW9yeUhggKMVebhDc9VvUIDJp/D9V2M6/UftsyQUxUEfsirs63HuqwGDeAlZKX0rU9LqSPI56sfUwLoSz7TC1gorkvUuOXBZ77LtO/9PeVzMG91RjRYWBeW3RI5nOanGrLbXgSzkT3VDsEb1cvPtM2ht1qKQaJzoabjAAkOjsy+zXy5kZyOgObYekHX6VgN5UESTkrAI0RRJrIEgHZZV4jsoBXPGkTOZDxPPG8UO2BwsqFyPvKrWFtqn7XFTxgHfVxZFMCX9rzDq2nFrkiuRKqOZkqtXYT+weBaJc4D+ZYWLSxD0xOLQXHI/Ix351IgD4ukde0O2ev+G/HpwqiuKmQcYQCfRPp5bq7mwZsfxGzEhj53qMzpoiZlhWR0ar9LyLqDD1BpmkZ25MpV9SG9Okja+qCerrILAbO1p7Am
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?u/5VIKiDC4Zmv0qws7k8wnhnMGsYJHmKfFRZxiJEC9BTiAkCaNDHyX8ArD?=
 =?iso-8859-1?Q?B3ieOKauTyvLiaP96/Tlq2aSzCdLrKuGIt8+atcnxPzZPGBlUq6owN81vA?=
 =?iso-8859-1?Q?G5Fmr3b8QqasYm425H5XFGBeN0xB6Q6Pevf2O0fHuYm3c4DI7laPJCnWpH?=
 =?iso-8859-1?Q?EN5GBjN1xUUXS/79lzMzuutiZp8omb2aqiQrwi5OpklvzERYehac2kgAyl?=
 =?iso-8859-1?Q?oQ8Dmwk2K+rZsIla1ufPCvuWvC6CXLroiU1YjHQ6mh7q/f1Qh+XGicHcXj?=
 =?iso-8859-1?Q?Gw25ETINrJ7fe3KC6S668Y9HXjIYSDQwHsoKS7j13XI7iHWdses/yY/qd1?=
 =?iso-8859-1?Q?R+9HBxWuhQSkH45njOi7U97Zv0X3KQxUFWq15vACK0DvQ/kD2g/RgollpD?=
 =?iso-8859-1?Q?cSwKAWhSIf3dTU3wWsSSADwX9k+eLsi6olTeTGLp7jd0WNd7bfIsRL4AXb?=
 =?iso-8859-1?Q?pUVy22Zjo34eqYyhzsoYd3/2GMTHLlf54bdtx3tT2EbvFhbuBgF3l+f8Ry?=
 =?iso-8859-1?Q?p/W4N+uhPRYEWjC1rBGRdpnMClcPpfRPTAsKPk3CPKdNRIK15r8UFaARra?=
 =?iso-8859-1?Q?CypLukatxwcVip9pjT1uc1KV/MN+Flo3nFZR1IqW3Fj9cwL4JXUUmjNfRB?=
 =?iso-8859-1?Q?cJFCXXXeBFPKvUs6O5dmDCBfMcL+81oKehN34hp6orPvC2DGo5IQOIh1vS?=
 =?iso-8859-1?Q?F1fhnRS8DF29pqEStIs5z6hPrYCmhtKD46IiLWDnsKgvQLLlHL9kJmVClv?=
 =?iso-8859-1?Q?fTmMSc8E3VlZo18OAL1mpZ1e5IO/xS3tCuFqMnee+GzlcWBieHl3jhBT9Y?=
 =?iso-8859-1?Q?7mhzIgE4woldOZwG9Vgtm/kRbrAGJMaBNV8PaEoDF7Zg5xFdd2S/sJxkH0?=
 =?iso-8859-1?Q?62HKKlKOWs6MJao4YD9w0xe5yy1e8X2mX0muMI2mK2rVvx3Eqhr/ST9n+J?=
 =?iso-8859-1?Q?y6Z8FQ07wf9l29EHEtt43xuyTLYKXh7VejO1+IYHb7+wVsoN9B5q4HVRR/?=
 =?iso-8859-1?Q?EraGCRtwA+oA/oQk8ns/YvCIsvyYkiBtT6wNhUyq+ZYFqjrvlCuw97+KFp?=
 =?iso-8859-1?Q?qs78CaIJDw296mE0m9s4P/EtppyZF6w0Qb6P1zwGyNqj9fFoRm8tBXceS1?=
 =?iso-8859-1?Q?5SazHmb6E8pJZ2m0dRllpSx6KrwRrJzX9MsjMukIdcMHml8zO9DjH5mGxu?=
 =?iso-8859-1?Q?k7ZQuI5PNGz+t7N0Koy7RnbdXNYgAjhQNz25cQYjEtsMvYcIpYuuAJgPC7?=
 =?iso-8859-1?Q?bdMppvbIrUELkrRL7h/kHtk42wN0lAU1kjgn8mrCMdpVtV2lsMY5EBG449?=
 =?iso-8859-1?Q?/UzvW1MXyPRFU6tfhBctFwSmoyGjhKkw0tGbKv7AESNNB0H7NvOW6Qstss?=
 =?iso-8859-1?Q?o7PGIqKx7fcAgiUxWYJzQn3frZybczCFLPFrmGuKH0TGCTmONrHYfh03+N?=
 =?iso-8859-1?Q?VserkQAZ1H7MtnKUP8fR8BiuMvZ/Y1IJNTw27RShltu54xxwMoHWZNpWIN?=
 =?iso-8859-1?Q?Hi0MoFkD3bHQUheTf9zIqTsoX86kJYVBXaats4FcSLMIldZ+ASwZofRyb5?=
 =?iso-8859-1?Q?XaBMuuPoSsz5Wivz8nklT1PXAslZectpHMOTpIT44FvYDzndUCUrfsUKYq?=
 =?iso-8859-1?Q?9Y4c+6DoDj5hSNte6cFDq9CJOgMmdmVzgQ/IxrSByRLk0kfqkSBPgo9zVw?=
 =?iso-8859-1?Q?KsAnTSo5hA3EQ2VU1ggCuGUTpp3v1szcX0boH30RnMw1VTQMNeNYzymQL5?=
 =?iso-8859-1?Q?qi3NRfP3NRzbX3RZSkjAURUR9ujFXSkydBvqvWw0oy7vzVceBpjQ72b9BV?=
 =?iso-8859-1?Q?4JpU3RTpNg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V95gGYrVziSelZiVecsSRwsG13+W8YoD7KNoOFm7Bj/HGoUr1ZLPKTtZoeckcdKaNEU82mwJYZXAPsizCZml616BqxHRR0fcXsXJ04FJLMfwdTc7Hizj7rpEye2pZRvRmPN0cMBuuUUNbobzVQq7rMPn2YqEreNszabz1UdJJeGYKxmjLwb+B+1paL7Af71gRfURtR7VtvXdkapTB5Nh7LKh4FvbTA3x2LQXX/WJNSzg2U1IBD+cMJ2vu+q/vdm0JPRgR8VQmHGrF375LLZMjg4lh8r7IReQN4c6BQnL/1Wbmn8f4wwtwNgLVXYkVblCCbNeGFq977JQPefxNf+Ydw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ea423c-68ae-41db-3ba7-08dee1799548
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:04.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xr7rUTHlrWofNfl2odexxc/2OGR61BdwtNJcBX7L/vuiWkG63hhKX6Q4QfMQTZX7JeBzbR7yWum68+GCJIrkQp3D5nFVAUUo6zawnPTi8NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

Add a crypto known-answer test harness and exercise the AST2500, which=0A=
uses the crypto engine's direct access mode. Each mode (AES/DES/3DES in=0A=
ECB and CBC) is a separate test that checks the ciphertext, the=0A=
plaintext round-trip and, for CBC, the chaining IV written back to the=0A=
context buffer.=0A=
=0A=
The key/IV/plaintext/ciphertext values are taken verbatim from the Linux=0A=
kernel crypto self-test templates in crypto/testmgr.h.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.h |  16 ++=0A=
 tests/qtest/aspeed-hace-utils.c | 304 ++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed_hace-test.c  |   6 +=0A=
 3 files changed, 326 insertions(+)=0A=
=0A=
diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-util=
s.h=0A=
index 27ab2bb975..13feaa61e4 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.h=0A=
+++ b/tests/qtest/aspeed-hace-utils.h=0A=
@@ -79,5 +79,21 @@ void aspeed_test_sha512_accum(const char *machine, const=
 uint32_t base,=0A=
 void aspeed_test_addresses(const char *machine, const uint32_t base,=0A=
                            const struct AspeedMasks *expected);=0A=
 =0A=
+/*=0A=
+ * Cipher modes a SoC's crypto engine supports, for aspeed_add_crypto_test=
s().=0A=
+ */=0A=
+enum {=0A=
+    CRYPT_MODE_ECB =3D 1 << 0,=0A=
+    CRYPT_MODE_CBC =3D 1 << 1,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Register the crypto known-answer tests that @modes selects (a mask of=
=0A=
+ * CRYPT_MODE_*) for the given machine. Each test is named=0A=
+ * "<prefix>/hace/crypto/<mode>".=0A=
+ */=0A=
+void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
+                             uint32_t base, uint64_t dram, uint32_t modes)=
;=0A=
+=0A=
 #endif /* TESTS_ASPEED_HACE_UTILS_H */=0A=
 =0A=
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-util=
s.c=0A=
index 25450a296b..4deb88dbcc 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -645,3 +645,307 @@ void aspeed_test_addresses(const char *machine, const=
 uint32_t base,=0A=
     qtest_quit(s);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Crypto engine register layout (offsets from the HACE base).=0A=
+ */=0A=
+#define HACE_CRYPTO_SRC          0x00=0A=
+#define HACE_CRYPTO_DEST         0x04=0A=
+#define HACE_CRYPTO_CONTEXT      0x08=0A=
+#define HACE_CRYPTO_DATA_LEN     0x0c=0A=
+#define HACE_CRYPTO_CMD          0x10=0A=
+=0A=
+/* Crypto command bits */=0A=
+#define HACE_CMD_ENCRYPT         BIT(7)=0A=
+#define HACE_CMD_ISR_EN          BIT(12)=0A=
+#define HACE_CMD_DES_SELECT      BIT(16)=0A=
+#define HACE_CMD_TRIPLE_DES      BIT(17)=0A=
+#define HACE_CMD_SRC_SG_CTRL     BIT(18)=0A=
+#define HACE_CMD_DST_SG_CTRL     BIT(19)=0A=
+#define HACE_CMD_OP_MODE_MASK    (0x7 << 4)=0A=
+#define HACE_CMD_ECB             (0x0 << 4)=0A=
+#define HACE_CMD_CBC             (0x1 << 4)=0A=
+#define HACE_CMD_AES128          (0x0 << 2)=0A=
+=0A=
+/* Context buffer layout: IV (DES at +8), key at +0x10 */=0A=
+#define HACE_CTX_KEY_OFFSET      0x10=0A=
+#define HACE_CTX_SIZE            0x30=0A=
+=0A=
+/*=0A=
+ * Crypto known-answer test vectors, taken verbatim from the Linux kernel=
=0A=
+ * crypto self-test templates in crypto/testmgr.h:=0A=
+ *=0A=
+ *   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/crypto/testmgr.h?h=3Dv6.18=0A=
+ *=0A=
+ * The originating template is noted above each block. CTR and the longer =
CBC=0A=
+ * vectors are truncated to a single block (still a valid known-answer tes=
t as=0A=
+ * the first block only depends on the IV).=0A=
+ */=0A=
+=0A=
+/* aes_tv_template[0] (FIPS-197) */=0A=
+static const uint8_t aes128_ecb_key[16] =3D {=0A=
+    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,=0A=
+    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };=0A=
+static const uint8_t aes128_ecb_ptext[16] =3D {=0A=
+    0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,=0A=
+    0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };=0A=
+static const uint8_t aes128_ecb_ctext[16] =3D {=0A=
+    0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30,=0A=
+    0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a };=0A=
+=0A=
+/* aes_cbc_tv_template[0] (RFC 3602) */=0A=
+static const uint8_t aes128_cbc_key[16] =3D {=0A=
+    0x06, 0xa9, 0x21, 0x40, 0x36, 0xb8, 0xa1, 0x5b,=0A=
+    0x51, 0x2e, 0x03, 0xd5, 0x34, 0x12, 0x00, 0x06 };=0A=
+static const uint8_t aes128_cbc_iv[16] =3D {=0A=
+    0x3d, 0xaf, 0xba, 0x42, 0x9d, 0x9e, 0xb4, 0x30,=0A=
+    0xb4, 0x22, 0xda, 0x80, 0x2c, 0x9f, 0xac, 0x41 };=0A=
+static const uint8_t aes128_cbc_ptext[16] =3D {=0A=
+    0x53, 0x69, 0x6e, 0x67, 0x6c, 0x65, 0x20, 0x62,=0A=
+    0x6c, 0x6f, 0x63, 0x6b, 0x20, 0x6d, 0x73, 0x67 };=0A=
+static const uint8_t aes128_cbc_ctext[16] =3D {=0A=
+    0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,=0A=
+    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a };=0A=
+static const uint8_t aes128_cbc_ivout[16] =3D {=0A=
+    0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,=0A=
+    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a };=0A=
+=0A=
+/* des_tv_template[0] (Applied Cryptography) */=0A=
+static const uint8_t des_ecb_key[8] =3D {=0A=
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };=0A=
+static const uint8_t des_ecb_ptext[8] =3D {=0A=
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xe7 };=0A=
+static const uint8_t des_ecb_ctext[8] =3D {=0A=
+    0xc9, 0x57, 0x44, 0x25, 0x6a, 0x5e, 0xd3, 0x1d };=0A=
+=0A=
+/* des_cbc_tv_template[0] (OpenSSL), first block */=0A=
+static const uint8_t des_cbc_key[8] =3D {=0A=
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };=0A=
+static const uint8_t des_cbc_iv[8] =3D {=0A=
+    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 };=0A=
+static const uint8_t des_cbc_ptext[8] =3D {=0A=
+    0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x20 };=0A=
+static const uint8_t des_cbc_ctext[8] =3D {=0A=
+    0xcc, 0xd1, 0x73, 0xff, 0xab, 0x20, 0x39, 0xf4 };=0A=
+=0A=
+/* des3_ede_tv_template[0] (OpenSSL) */=0A=
+static const uint8_t tdes_ecb_key[24] =3D {=0A=
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,=0A=
+    0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,=0A=
+    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 };=0A=
+static const uint8_t tdes_ecb_ptext[8] =3D {=0A=
+    0x73, 0x6f, 0x6d, 0x65, 0x64, 0x61, 0x74, 0x61 };=0A=
+static const uint8_t tdes_ecb_ctext[8] =3D {=0A=
+    0x18, 0xd7, 0x48, 0xe5, 0x63, 0x62, 0x05, 0x72 };=0A=
+=0A=
+/* des3_ede_cbc_tv_template[0] (OpenSSL), first block */=0A=
+static const uint8_t tdes_cbc_key[24] =3D {=0A=
+    0xe9, 0xc0, 0xff, 0x2e, 0x76, 0x0b, 0x64, 0x24,=0A=
+    0x44, 0x4d, 0x99, 0x5a, 0x12, 0xd6, 0x40, 0xc0,=0A=
+    0xea, 0xc2, 0x84, 0xe8, 0x14, 0x95, 0xdb, 0xe8 };=0A=
+static const uint8_t tdes_cbc_iv[8] =3D {=0A=
+    0x7d, 0x33, 0x88, 0x93, 0x0f, 0x93, 0xb2, 0x42 };=0A=
+static const uint8_t tdes_cbc_ptext[8] =3D {=0A=
+    0x6f, 0x54, 0x20, 0x6f, 0x61, 0x4d, 0x79, 0x6e };=0A=
+static const uint8_t tdes_cbc_ctext[8] =3D {=0A=
+    0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };=0A=
+=0A=
+typedef struct CryptTest {=0A=
+    const uint8_t *ptext;=0A=
+    const uint8_t *ctext;=0A=
+    /* expected context IV after encrypt, or NULL */=0A=
+    const uint8_t *iv_out;=0A=
+    const uint8_t *key;=0A=
+    const uint8_t *iv;=0A=
+    const char *name;=0A=
+    /* algorithm | mode | key size selection */=0A=
+    uint32_t cmd;=0A=
+    size_t keylen;=0A=
+    size_t ivlen;=0A=
+    size_t len;=0A=
+} CryptTest;=0A=
+=0A=
+static const CryptTest crypt_tests[] =3D {=0A=
+    {=0A=
+        .name =3D "aes128-ecb",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_ECB,=0A=
+        .key =3D aes128_ecb_key,=0A=
+        .keylen =3D sizeof(aes128_ecb_key),=0A=
+        .ptext =3D aes128_ecb_ptext,=0A=
+        .ctext =3D aes128_ecb_ctext,=0A=
+        .len =3D sizeof(aes128_ecb_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "aes128-cbc",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_CBC,=0A=
+        .key =3D aes128_cbc_key,=0A=
+        .keylen =3D sizeof(aes128_cbc_key),=0A=
+        .iv =3D aes128_cbc_iv,=0A=
+        .ivlen =3D sizeof(aes128_cbc_iv),=0A=
+        .ptext =3D aes128_cbc_ptext,=0A=
+        .ctext =3D aes128_cbc_ctext,=0A=
+        .iv_out =3D aes128_cbc_ivout,=0A=
+        .len =3D sizeof(aes128_cbc_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des-ecb",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_ECB,=0A=
+        .key =3D des_ecb_key,=0A=
+        .keylen =3D sizeof(des_ecb_key),=0A=
+        .ptext =3D des_ecb_ptext,=0A=
+        .ctext =3D des_ecb_ctext,=0A=
+        .len =3D sizeof(des_ecb_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des-cbc",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_CBC,=0A=
+        .key =3D des_cbc_key,=0A=
+        .keylen =3D sizeof(des_cbc_key),=0A=
+        .iv =3D des_cbc_iv,=0A=
+        .ivlen =3D sizeof(des_cbc_iv),=0A=
+        .ptext =3D des_cbc_ptext,=0A=
+        .ctext =3D des_cbc_ctext,=0A=
+        .len =3D sizeof(des_cbc_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des3_ede-ecb",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_ECB,=
=0A=
+        .key =3D tdes_ecb_key,=0A=
+        .keylen =3D sizeof(tdes_ecb_key),=0A=
+        .ptext =3D tdes_ecb_ptext,=0A=
+        .ctext =3D tdes_ecb_ctext,=0A=
+        .len =3D sizeof(tdes_ecb_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des3_ede-cbc",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_CBC,=
=0A=
+        .key =3D tdes_cbc_key,=0A=
+        .keylen =3D sizeof(tdes_cbc_key),=0A=
+        .iv =3D tdes_cbc_iv,=0A=
+        .ivlen =3D sizeof(tdes_cbc_iv),=0A=
+        .ptext =3D tdes_cbc_ptext,=0A=
+        .ctext =3D tdes_cbc_ctext,=0A=
+        .len =3D sizeof(tdes_cbc_ptext),=0A=
+    },=0A=
+};=0A=
+=0A=
+/* DRAM offsets for the crypto test source, destination and context buffer=
s. */=0A=
+#define CRYPT_OFF_SRC   0x10000=0A=
+#define CRYPT_OFF_DST   0x20000=0A=
+#define CRYPT_OFF_CTX   0x30000=0A=
+=0A=
+/* Describes one registered crypto test (qtest_add_data_func() data pointe=
r). */=0A=
+typedef struct AspeedCryptoTest {=0A=
+    const char *machine;=0A=
+    uint64_t dram;=0A=
+    uint32_t base;=0A=
+    int index;=0A=
+} AspeedCryptoTest;=0A=
+=0A=
+/* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_* flag. */=
=0A=
+static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
+{=0A=
+    switch (cmd & HACE_CMD_OP_MODE_MASK) {=0A=
+    case HACE_CMD_ECB:=0A=
+        return CRYPT_MODE_ECB;=0A=
+    case HACE_CMD_CBC:=0A=
+        return CRYPT_MODE_CBC;=0A=
+    default:=0A=
+        return 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+static void crypt_write_ctx(QTestState *s, uint64_t ctx_addr,=0A=
+                            const CryptTest *t)=0A=
+{=0A=
+    size_t iv_off =3D (t->cmd & HACE_CMD_DES_SELECT) ? 8 : 0;=0A=
+    uint8_t ctx[HACE_CTX_SIZE] =3D { 0 };=0A=
+=0A=
+    if (t->iv) {=0A=
+        memcpy(ctx + iv_off, t->iv, t->ivlen);=0A=
+    }=0A=
+    memcpy(ctx + HACE_CTX_KEY_OFFSET, t->key, t->keylen);=0A=
+    qtest_memwrite(s, ctx_addr, ctx, sizeof(ctx));=0A=
+}=0A=
+=0A=
+/* Run one crypto operation in direct access mode and read back the result=
. */=0A=
+static void crypt_run_direct(QTestState *s, uint32_t base, uint64_t dram,=
=0A=
+                             const CryptTest *t, bool encrypt, uint8_t *ou=
t)=0A=
+{=0A=
+    const uint8_t *in =3D encrypt ? t->ptext : t->ctext;=0A=
+    uint32_t cmd =3D t->cmd | HACE_CMD_ISR_EN;=0A=
+    uint64_t src =3D dram + CRYPT_OFF_SRC;=0A=
+    uint64_t dst =3D dram + CRYPT_OFF_DST;=0A=
+    uint64_t ctx =3D dram + CRYPT_OFF_CTX;=0A=
+=0A=
+    if (encrypt) {=0A=
+        cmd |=3D HACE_CMD_ENCRYPT;=0A=
+    }=0A=
+=0A=
+    crypt_write_ctx(s, ctx, t);=0A=
+    qtest_memwrite(s, src, in, t->len);=0A=
+=0A=
+    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);=0A=
+=0A=
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, =3D=
=3D,=0A=
+                    HACE_CRYPTO_ISR);=0A=
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);=0A=
+=0A=
+    qtest_memread(s, dst, out, t->len);=0A=
+}=0A=
+=0A=
+static void aspeed_test_crypto_direct(const void *data)=0A=
+{=0A=
+    const AspeedCryptoTest *c =3D data;=0A=
+    const CryptTest *t =3D &crypt_tests[c->index];=0A=
+    QTestState *s =3D qtest_init(c->machine);=0A=
+    uint8_t out[64];=0A=
+    uint8_t iv[16];=0A=
+    size_t iv_off;=0A=
+=0A=
+    g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
+=0A=
+    /* Encrypt: ptext -> ctext */=0A=
+    crypt_run_direct(s, c->base, c->dram, t, true, out);=0A=
+    g_assert_cmpmem(out, t->len, t->ctext, t->len);=0A=
+=0A=
+    if (t->iv_out) {=0A=
+        iv_off =3D (t->cmd & HACE_CMD_DES_SELECT) ? 8 : 0;=0A=
+        qtest_memread(s, c->dram + CRYPT_OFF_CTX + iv_off, iv, t->ivlen);=
=0A=
+        g_assert_cmpmem(iv, t->ivlen, t->iv_out, t->ivlen);=0A=
+    }=0A=
+=0A=
+    /* Decrypt: ctext -> ptext */=0A=
+    crypt_run_direct(s, c->base, c->dram, t, false, out);=0A=
+    g_assert_cmpmem(out, t->len, t->ptext, t->len);=0A=
+=0A=
+    qtest_quit(s);=0A=
+}=0A=
+=0A=
+void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
+                             uint32_t base, uint64_t dram, uint32_t modes)=
=0A=
+{=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {=0A=
+        g_autofree char *path =3D NULL;=0A=
+        AspeedCryptoTest *t;=0A=
+=0A=
+        if (!(modes & crypt_mode_flag(crypt_tests[i].cmd))) {=0A=
+            continue;=0A=
+        }=0A=
+=0A=
+        path =3D g_strdup_printf("%s/hace/crypto/%s", prefix,=0A=
+                               crypt_tests[i].name);=0A=
+        t =3D g_new0(AspeedCryptoTest, 1);=0A=
+        t->machine =3D machine;=0A=
+        t->base =3D base;=0A=
+        t->dram =3D dram;=0A=
+        t->index =3D i;=0A=
+        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct, g_fre=
e);=0A=
+    }=0A=
+}=0A=
+=0A=
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.=
c=0A=
index 38777020ca..4cb4c475e9 100644=0A=
--- a/tests/qtest/aspeed_hace-test.c=0A=
+++ b/tests/qtest/aspeed_hace-test.c=0A=
@@ -229,6 +229,12 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500);=0A=
     qtest_add_func("ast2500/hace/md5", test_md5_ast2500);=0A=
 =0A=
+    /*=0A=
+     * The AST2500 crypto engine uses direct access mode and supports ECB/=
CBC.=0A=
+     */=0A=
+    aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb", 0x1e6e3000,=
=0A=
+                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC);=
=0A=
+=0A=
     qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);=0A=
     qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);=0A=
     qtest_add_func("ast2400/hace/sha256", test_sha256_ast2400);=0A=
-- =0A=
2.43.0=0A=

