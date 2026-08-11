Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BEBC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYN-0007IL-VQ; Tue, 11 Aug 2026 02:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYM-0007Hy-VR; Tue, 11 Aug 2026 02:01:34 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYK-0002cm-Jy; Tue, 11 Aug 2026 02:01:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diO17T+ue2NgusLJwNPM0tTqysGjIh6XG2ldOrLOReVwdBkdLpQ6kgZeSuZoaSOxqIru6WiveBwWhF3lDOXA09lNVElDCnkHika0U6pYHwarmYJ9oaI8IljZhqLpbL9BodzXpRzrWUhvR+6PrHNUOvOTj0z3lchY4RWkUq5Szpk7+cGbsM3Aw/bcLMC2jcND/jphbF8u+owAumVhzFbJbhNyn2dzelseJ9A+jBBenSV2UgDPoOXtokJRTgdAZvlKDvRq2qf3OYEjczFZ66Seh6KHZGI3o7BDs/c8fZ269wMV7PKK8bHWZPx7BQCl2nkWjEZ7opIA76qaShjiNF8ozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMxPJiQcgRBwZ0D2megD1sDC2vpMh6FD8MTM8XCj/5Y=;
 b=cSZlS/P8pjJNhc/SwTQ5T5lFuAoIpYhpTjaKveBdgV8lIK1MUTw00JdhvcTlOvT9b8RxmywUGgjvqXUMTEJSwi8nvaN+pCTLyR3/X1It9gFVN4ASf/A92lg71ohtEYJO90hRp1qbb4KNHb/ejXeWd3bTrUFdCv69vVOSkr7qCkNReKZ7xKiHjtQWRsN6HMevmDV2jrUqMeK2dvEzTTyZ8zan8KRyf8d3QDXs5wV5Vjjm65PLqHHm/m6b3lM/ierrKHvPm8nme8V8tt08D3sJX0T0/yyAeUSl/Wj3APQxrvCxtMCmzdSe+V/P/+gQ5m4ocTmSdQTr1L9sdOl5x9lTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMxPJiQcgRBwZ0D2megD1sDC2vpMh6FD8MTM8XCj/5Y=;
 b=omfnsqpCR9ebgZIIHKiw3WSbXjAVXm/OkMM9P9E85/ER0vZ30q9T75XYa9gvuX4nkH9F7oemoJIqzrw7ldIDdRni44P7h/FDn7lLZA60EASr0is5mru+ycEeHaj5Rokg0plQWuvM8JIjoqYuom+eV6xLHd+ZIQ9XknOkXB/QK7f5b8f+NffXoSBQeW6noJqjPmHPp5cILq/U85E4RzDRJo6Hv8zv21ZgoxEfWt+K1bZ0Ii7oqX9k9lSUB4ZuzbKEabdfsVLa2uBB8pCm+zhJwKyo/cx2wAUWkNcKuSy5o6r/zSOZzujQFKFF9sRkMsxC1Hbbi1uf07iQFu25ZVBk5w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:19 +0000
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
Subject: [PATCH v4 02/16] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2500
Thread-Topic: [PATCH v4 02/16] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2500
Thread-Index: AQHdKVbUaBFpKEQ4sEamqEsuU9lqHg==
Date: Tue, 11 Aug 2026 06:01:19 +0000
Message-ID: <20260811060115.1849266-3-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6be46d0d-9b3b-44dd-aa63-08def76df6d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info: CFa99q+7nphuKUR8jvBxCpLptOhlp4fdOCitbX+ir5SYU6/Poqz0IZwWLl0xPC7rGWokmv+DKFWsS1nVX8Qu3uyAL7SxWz1djWUEgY6aHBOk6SV+JModmlAxSFk8lB7KrYGUsxGyKehamQPvyA5WKdek3l5wk15JB4VaJqNo4bSev+p1YoIrU9CJ5yrvHVAqLWCLBeQcke8A0uBrUlzFEH+58Veqb8j1+WkMnjuX3y+dkoEyJxOsYAzPIIdCwa14k/rEvTRpA3n8ZCnAopBKutdym07CaMKgG+2qFPooi5EPf1VNVoT+7t7G5iii6AThmz3MnMzSB0mjaKbRvOasTAqlCys+coYymysp2oygB4c9XqjkLLzd7ng58jfgY9dKaBF+hOEr6ODlKC/hnARJnca+1cyeGgcl8RytrWCCCyaFIwbHESsXrBO9ZFNufSRP+KVBv7JQ7JFXibeFZqoh3hlybA02kL2benCwPFrGQDJyWpvFOMOq4c0661YvA6c5jN3hh6yZlolfVfYVFa6+0aKv1aYNACZklznf2zqKnEWSBtjfCFIn0jOJnIm9aw+ye98eFgMuVKZ9927GbsqHiAQvYFpfne83vhVwW3YiNdPGdYCgF+8RsNgecAwMvHOgQ+Gbw0yEuDLWbbwx6ChXP7OfGif4gfPGfT9zkHdb30kB8dV9HwX3sDtrUgqKTdulhlZnf+Zjj+Ixtqgw7ZwFg7RM6Uv3RHf8gABnq84JWkyLloNZ2s9We5pWG5KOJiB0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8kbLrNuW0zQrWoe+mDYeYSswn46+imMCBHd+jb7SaC//8FwEpKFEK/rTkA?=
 =?iso-8859-1?Q?LXDl6wI9QBYgavQ2IFOGMpWjybT1tKLqy1wnmIDLBM88Rq4yCjHXJFqyqs?=
 =?iso-8859-1?Q?PirWtwwXmkDE4gMtTDfpUVeseQ6BkPJKKohEPZA3kWcUAI1U94JskX+bz6?=
 =?iso-8859-1?Q?MTJF8y7B5WjLzULpzKe/+6I4M36xq1wGV5TxIjrflx8915A7co9HXxWr7a?=
 =?iso-8859-1?Q?iWQwCyPazknGAvovOhMD50NlGdCJERscgyVuoBzS9x+7Bc2EgszCy/TxPb?=
 =?iso-8859-1?Q?i99U8niMgVx0r5vTEP2xSCZxQWmPZEBK85UwTrY4XbsxnxqHNSxGfzViNL?=
 =?iso-8859-1?Q?8M/D6gxQ0LZ0OOTqphG8L86c6mU9Ay+76iJcOHJqOoNIiNWwXbIEmb+T9W?=
 =?iso-8859-1?Q?eTx8ouSDjEAE1DmNIEho6G7cZZ2x7UBux1lXden7xKF6IkuaiZ+azbOb+2?=
 =?iso-8859-1?Q?v65r8JQLiwRN0UJDBLmSMb184V9ct+MI7yiTyDS/Bk2OXeaSFJ8+Mtqdw2?=
 =?iso-8859-1?Q?KDcu6cO/G+rx/YGMCGxemwmduBkWV9v0lWdcnJBtABOM8Q9omrcGOUusV+?=
 =?iso-8859-1?Q?0UfnOsQHMSMWFXMJOMwd8qXBYAMJ5mx/BrF/HlkRCBntiUUe4wj4zm7TCk?=
 =?iso-8859-1?Q?mDtmpZwbhlc6N+e3fkXLm+k9UuS0CrOAgtD6zdvRxzCPawsE/Jsy2WfiMa?=
 =?iso-8859-1?Q?5ob7/B0n45Q2S0dyvV5HvmL0jB5GzhvEosA9OnEpQfhOnvmjL6C9VsOVei?=
 =?iso-8859-1?Q?84OAjRluM9Wh80oL+gI98S8XzZbovGhOuJhJ62r9DTPRyivoaonb+Gsl6F?=
 =?iso-8859-1?Q?EsP4dFiGgeXlLVfifYhXKgd1c5daVLRex0JBuX5mhcZHl/F4ElVw+9zPhv?=
 =?iso-8859-1?Q?//zei4mtGFxsw1F9lf06h1Cf4aN4grbCuh29nzXEzTm6R/7HHnZlzi0QL7?=
 =?iso-8859-1?Q?uRoniEMgzy7WbWB5YPOV15FEGlqWVwYCa3ELWf8x3S2u6Q+oUFQOuretu7?=
 =?iso-8859-1?Q?em/1m+lONgxdJl1pKhmwrIRlrX0lEtXR2vaeXG72CFJRoPtZS8eCupiham?=
 =?iso-8859-1?Q?dSLT2ZSIh2L8n3pwxZOglbfcA4Ku31QiDOxeXlbVCBXT+RDuQAfZRYdfKr?=
 =?iso-8859-1?Q?IrHqEzOyzDy0BTUWNnNfwm3qP4IrIr6nys9diciKY0Y7ReiSfgZ3SikKCh?=
 =?iso-8859-1?Q?sRKGg7oJnFJWTmqrj7rEMeeiV8UfxpL8z9V5Se7ZyQz3l1OKvDiuTpECut?=
 =?iso-8859-1?Q?nS6pmJvlaFcroDeAsciv//3HibreZ1lnTVyqbmi+No6bXT7pJiRd0r6Pqx?=
 =?iso-8859-1?Q?SAU0CtQpWf40LUuX2BF5gD4WnnT1IvxNwXAlYMkSHRJysqS9YcMIEAfCXr?=
 =?iso-8859-1?Q?ghcR9EAx+WEtUSobLU94quNXsUfusUPB10tAK9DZp8mohJBc52hI6AvR0j?=
 =?iso-8859-1?Q?BdVI37fqKmScmNFm/1Ku+EMhQBPbaKgqvg0hOtgDq0OcwidUP62blCla73?=
 =?iso-8859-1?Q?YrU9wkpm5mQXEPMURkLigRb22nOmogGdJFJiK0UEfSC26X9CXpW48jRmJu?=
 =?iso-8859-1?Q?D8xH4Al8wun9YpWvC/1HuPM+Z5OB49b2UHrC6TSKtVz87CA7swamxtlbY+?=
 =?iso-8859-1?Q?d6XW8VMoutMrUyHb/phtxAz0/QLtMEsvIPYSA7pnZpIzGLHOTEvAiG+mJy?=
 =?iso-8859-1?Q?cAas8O762dgvg0wuawrQSpdKRixPr0KfZPolF0nmuza0s7wk4Aygz06nEU?=
 =?iso-8859-1?Q?Xc7g0ZNzwgpEF11ESrJ075nmVMu6nUYMBGkRf0Cuml3/+OssaUmEiijZW7?=
 =?iso-8859-1?Q?GolxQGdNlw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SFC4q96Ma7rsw+gpjpMEqLZwCPLD5burvMVrnb1p/nHPk0e6GfL1Og21/5t2Y/sFM659rDaWBbGqfxF+lRVc312kelPK+T+Xynt0wbMXmyfSX0aikza09SAucZFUUcZO9LX6FcpNUGiYdKZnO9bEo4F5EHtt10x6OdaulP7zoD2WDr3MmjpU2BfFdI3waeQX4USm6s4gLaT9u9dqeNYobdW1gHaHR5blWM30w2cr788I7T2sZqv7zOl65uuFg1kDGAeEybwvzAOVp04vcxjqvhlOdzkoiTb+0ahwl41DP1H01OPcsOmktSBHTOab6ezR4dvDdvLUmjOSkfzK2d+8Zg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be46d0d-9b3b-44dd-aa63-08def76df6d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:19.7181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9R6/DoqejlvHCTKSAVc2+n6CqpCExjSW/AHKajN/uqNlp7ryb1VqAPQqjo+nm+qybxOcI5rIvUtfYWh6/8d62r0bWAao0mEswxlWmGrcCP8=
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
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.h |  16 ++=0A=
 tests/qtest/aspeed-hace-utils.c | 325 ++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed_hace-test.c  |   6 +=0A=
 tests/qtest/meson.build         |   6 +-=0A=
 4 files changed, 351 insertions(+), 2 deletions(-)=0A=
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
index 25450a296b..0355dd47af 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -9,6 +9,7 @@=0A=
 #include "libqtest.h"=0A=
 #include "qemu/bitops.h"=0A=
 #include "qemu/bswap.h"=0A=
+#include "crypto/cipher.h"=0A=
 #include "aspeed-hace-utils.h"=0A=
 =0A=
 /*=0A=
@@ -645,3 +646,327 @@ void aspeed_test_addresses(const char *machine, const=
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
+    QCryptoCipherMode mode;=0A=
+    QCryptoCipherAlgo alg;=0A=
+    /* expected context IV after encrypt, or NULL */=0A=
+    const uint8_t *iv_out;=0A=
+    const uint8_t *ptext;=0A=
+    const uint8_t *ctext;=0A=
+    const uint8_t *key;=0A=
+    const uint8_t *iv;=0A=
+    const char *name;=0A=
+    size_t keylen;=0A=
+    /* algorithm | mode | key size selection */=0A=
+    uint32_t cmd;=0A=
+    size_t ivlen;=0A=
+    size_t len;=0A=
+} CryptTest;=0A=
+=0A=
+static const CryptTest crypt_tests[] =3D {=0A=
+    {=0A=
+        .name =3D "aes128-ecb",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_ECB,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_ECB,=0A=
+        .key =3D aes128_ecb_key,=0A=
+        .keylen =3D sizeof(aes128_ecb_key),=0A=
+        .ptext =3D aes128_ecb_ptext,=0A=
+        .ctext =3D aes128_ecb_ctext,=0A=
+        .len =3D sizeof(aes128_ecb_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "aes128-cbc",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_CBC,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_CBC,=0A=
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
+        .alg =3D QCRYPTO_CIPHER_ALGO_DES,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_ECB,=0A=
+        .key =3D des_ecb_key,=0A=
+        .keylen =3D sizeof(des_ecb_key),=0A=
+        .ptext =3D des_ecb_ptext,=0A=
+        .ctext =3D des_ecb_ctext,=0A=
+        .len =3D sizeof(des_ecb_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des-cbc",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_CBC,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_DES,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_CBC,=0A=
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
+        .alg =3D QCRYPTO_CIPHER_ALGO_3DES,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_ECB,=0A=
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
+        .alg =3D QCRYPTO_CIPHER_ALGO_3DES,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_CBC,=0A=
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
+        if (!qcrypto_cipher_supports(crypt_tests[i].alg,=0A=
+                                     crypt_tests[i].mode)) {=0A=
+            g_printerr("# skip unsupported %s\n", crypt_tests[i].name);=0A=
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build=0A=
index 56ff860e21..d5bde77689 100644=0A=
--- a/tests/qtest/meson.build=0A=
+++ b/tests/qtest/meson.build=0A=
@@ -389,9 +389,11 @@ if get_option('replication').allowed()=0A=
 endif=0A=
 =0A=
 qtests =3D {=0A=
-  'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),=
=0A=
+  'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),=
=0A=
+                       crypto],=0A=
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),=0A=
-  'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace-test.c')=
,=0A=
+  'ast2700-hace-test': [files('aspeed-hace-utils.c', 'ast2700-hace-test.c'=
),=0A=
+                        crypto],=0A=
   'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),=
=0A=
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],=
=0A=
   'cdrom-test': files('boot-sector.c'),=0A=
-- =0A=
2.43.0=0A=

