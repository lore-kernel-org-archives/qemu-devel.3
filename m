Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B11C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2J-0001l0-Pv; Tue, 18 Aug 2026 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2H-0001kC-Vj; Tue, 18 Aug 2026 05:23:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2G-0001Yk-0m; Tue, 18 Aug 2026 05:23:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt3ldkRCfYFBNiXdDMKcw+D68khtvNnG5R+bUFh5MW7IzRNoGtKoQ3LkxlkptudCaCBhelja5XvJ36EheZaELotXHdnyPAeWnRCVHAOf8/Ho7ely463/PKnQ2K3Pvvo5pw0rk/ffdSn9Wk8wgXvpnfA1UDfR+ok+VyENv8jAuk6WH8QTfsT9rjzVND+OkZI4gP/KxKcOlj1Waj+VjG0gyO19TChdU9I5xZCtWx+c/OunP4xs04tyYtcQkSmDCGozuqQ3uy8gAd/H/oSSnk/eUFfwEiuf78tqZVuPKPtlmIkjcM+gKd230ejSrkurwoVgs2ZL7Im28xWibARaXPXt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QonB1JmhBa3RVWRyk425VwXCGhlKLZFnG0wESPHul3s=;
 b=Ht+aUKjZLHCCQ0n9Af+NVmlDuHZilczKDX9LV9v/Ob+Bo+pEq0vqRcm8g/7pqTAZU4JsDkvNvzZFfdAONcT21YPTAmlbqMwcIUYfZbzocbWYzdygDflJj1bPcPnUujnS0nwakhmx3MTUE1p4yuLm6pFVFiRzhlTnYlmw0He5G4MzF6EZgpwAtXzcJ56W+TrHT96SayCyWmfoU2lIK33wN93nN0TAwG1opbeyGudil3umgqQN2kwZMhz5IYa3z5Zv1oEyeGpJc/3y5PehMj5lO5kkNHlQMJSRru8Kc9+gTPUYqD32hxacjSKxghm/yBHueJgqb9uU6V/SdL3KpMT84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QonB1JmhBa3RVWRyk425VwXCGhlKLZFnG0wESPHul3s=;
 b=Bi7Ruh0q1IsG+kudHVaPnrSU4abYAmmwt7hDaT9HuUp9PqXLnChnG8ShhcNuu2ndousSvwSVjUehswHpp77ZUtiRbMbrPsl4wZg164DHrp/ZJCgBasnsup5lLgJASDrfOOrCuO3EWgfR6PlMhirGMI7vkmpq9ZznUWRBuFr6UlJlSNvlFJa3V+yMNx/QWgSu/d0uYwuQ7kZdGo3rfQcuGW2s+y8xbUJlFZZKn4Y2tlQcle4oDtBYPsLj/sdbdqQPD/Tj/bGFHJJ1g2/CIlObN0wEOV+fQWeMbiRBWhOQsbxBj70OaxzqaXvrvJsWtSG2Xx3it/f7wmrr0hs85Q4U0g==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:22:58 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:22:58 +0000
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
Subject: [PATCH v1 4/8] tests/crypto: Add ECDSA sign/verify tests
Thread-Topic: [PATCH v1 4/8] tests/crypto: Add ECDSA sign/verify tests
Thread-Index: AQHdLvMoaDqmulCNHkCRUpHkSpc9QA==
Date: Tue, 18 Aug 2026 09:22:58 +0000
Message-ID: <20260818092249.602137-5-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: 3b42bc08-6741-49b5-373e-08defd0a4afc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: 54oEwWQSKEaZFrglRGluhTvab3ZFSn/mQZfpDPcp7fB2FLzlHktj+hP7iHn4uzeGpl+Zu6rwFqplJ1Fci2/Ip0q36W33EO8KJlaK1ymjURUwcefjJ9huSfcn3BTKWGfa4jKaonbHUDEhFoloFc3Je12Mmc02yTEuz9KyBkzVFUCEYG04khDlHsJ1dRQ1vebrq488Qccqni+BmDKiQOrrsHcilW8/iTyfh+1W5mCcIpYUYT5eOIFpWvCwAKdDgJ83v7om7g9ryeTmSRsExgq0QIuVq4aC8JfEwaHuLlr8ALSHIp7+GcADAfwHtz6hj8a+2OfsZcOvbdqe8v0f61F+ZqtK+X9d4PSTxcG250YvtKlbIZWDVnfE1DrrTlHlDFqegdWJZ//rgkAppM1v5DJkX56yrcukfdoNfeZzwzIsIMtZK2XOgWWrE8++2fWqCdWaH7PVrIgUK2KJK+DjHJb1JCW+V3uJI55Z9XUwFVzHkxcfJhjwWAeiu3YDTHubCKGGpU4DbKTl6xr9gHaQttg9IALiQ2tR1357FJZJ+kgPbZlUdg9GDd2SIF0kep/Rbas7YhYekjNmVelUJpmtVGzQUrBX3dKeWPC+vf3G5E1MwVSaVUBofr+Z0XshwpfQZkgryPHxpEcJ83KP6bCLLXW6F7eq30W5WMK/hsepBcfd+NevaKWdZk2K5LZ8DDqEoc/76rFrUcz82GRUDSy3f7FxFJc6dL9aRmqQ2QxSx3Lsnac=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JCMLT5PAE+Z4wwHRTZEdJaq44/kEBlIuTGlLQ1eXVyhOC48LW1GlVtuUlv?=
 =?iso-8859-1?Q?SU+uhFbZDcr9NnwDAsHQ870h8b+07/QDrLfC9LIpUsrIkXNGl5AL0+wLvB?=
 =?iso-8859-1?Q?gpdHq1FoiMfCTAgq66SO3f4Up4srX3oGAt6SxDvS/WYzhyd64NQP9BS/4Q?=
 =?iso-8859-1?Q?Iko7UvNoSjgRnsKlm3mJhFsBBVzu0D9AN6cTc4Z6ey7i3KefqKW3XG30tm?=
 =?iso-8859-1?Q?YloAzybv/mFu4TYs1M4KaaULzlp3TzTbLUqJqpJR3w7WLoBvz70XGpIBk+?=
 =?iso-8859-1?Q?q4P7etY3UY5mkGC3BAWKVjHd+ARiSHVci73/Ha/PHun3eeMM3LdnVkxzd8?=
 =?iso-8859-1?Q?L6S4IIYl1gz7iDAbdcnge0E8Mqz4v/GmSMxCkTR/6BQhMnPW9n4bWLrjke?=
 =?iso-8859-1?Q?ZYH/k5QExojDbFipEQtmbc3Ouo8LCUgGHL+hjg4u3HoqQ2XKUoRvN99C4J?=
 =?iso-8859-1?Q?s6Ns5PYnzD0/NFi/ozfqoH4TmIWUv0YnExO0QvOGgZFaA1QO4IJg91bJQy?=
 =?iso-8859-1?Q?6pm/Qjls8GdlNCzqOOXP8lrBJib7TLNHyHm5g7hpkoNvS+hUobctlNAUtJ?=
 =?iso-8859-1?Q?6SPdl5qn6v65rqtnAHHDWcaWlbq+W9RrHzBObgivdeusBqOgrxsYB5k7Ha?=
 =?iso-8859-1?Q?IXryyOZR//RraIDcC5qK5NL3VP7Oh9AzBcF4rR7QpU5MGB5Bcz5fuNWEPG?=
 =?iso-8859-1?Q?/gVpa4Jxw4aT0vOAJI3H3Kh+rwDsl4ufJJIE9+MqdOD4bEwW1iGm4Ry77L?=
 =?iso-8859-1?Q?BhsWenP27gBIVzhtWi9Xw/JtNRpmw3RfG1lNJIskUQLeA/1viFUEnq/BBJ?=
 =?iso-8859-1?Q?hmQ3UhbiDx/sqe0Kig/aGXR27QX0C1V4D88pCqqbuf95H1UaAr3tH1vclC?=
 =?iso-8859-1?Q?Z1xzUfyIk6X1SENQFHUGGWK4mJqeX4+BSVHw7yH3/IQ1szXtL4kKmBdHN1?=
 =?iso-8859-1?Q?+xuyyefjsF36RIP24OHUv5becHtXQO/Dj4uSMdm+Sb3oZlVj1wKp0CM/Ku?=
 =?iso-8859-1?Q?8xOfeFJ4bvbY0U1vISGLUzS9NsfGnrkwvkQN5ZtX/00v8B6BNw7dY7r3vU?=
 =?iso-8859-1?Q?od/yrx95d22v4oiseU4wy5isSmDjBjSUK8b/PbChKarW/iXM/nHCrzpvcu?=
 =?iso-8859-1?Q?qTHPP+iJM4xdxrrKlh+H2BqWM1kBNRZPNwgZyRJDw8OcoJiyWA03zDhup/?=
 =?iso-8859-1?Q?rLQFzA4Q7YNOzbCWKtvKcD/YYv8wubcTn+vq7w27tBVzFJC9RkNmB7QKTF?=
 =?iso-8859-1?Q?MXABz4ixt64LRHK+XPd7yL3LrmhK79BcSOoAKxfAfZp034oFoxHToEX6LL?=
 =?iso-8859-1?Q?sjocGZ3GPoQaAV6slcje24PaAzqu6DPlvN9HKupPGqsqc06o9wldCMZs64?=
 =?iso-8859-1?Q?bEbzJzQeWfSpDG7nSbcclKQp5Vv5b89jK+0Ujga8cMXwmSeKcLgldgY4nt?=
 =?iso-8859-1?Q?w8W5A00cRwajNTt+kzwi0ctoNyFxQKyyjywKv4K1W6Dmc9kz1BRI9aCaEj?=
 =?iso-8859-1?Q?nALVL3WjL1FZ2kE3tPnb18SWl+rJ3yMaEAhjdwLUUpP5zFZrJo/RYdkCjy?=
 =?iso-8859-1?Q?U0zIdOWk5evicGnJS4hWfEOmyG5hUv3Fy9c91VGsy2TSJ7PZ5+wQkBW7bO?=
 =?iso-8859-1?Q?oUyN1pypmmvhYX4fFJbEn87yWnwol/ye/+O558nJ0k9714vXuG3lTBPZab?=
 =?iso-8859-1?Q?iu/pGSGF7uYsbsymZ2A0mHFzcCQa0cQQP91jkt1vBtW8FaccQplo+yPMEt?=
 =?iso-8859-1?Q?JDXQBPbh5d9fCwJZvaz4S5k6QQGnOm+yKLOqUJUf0Lb3wx81r+SdY6KSYg?=
 =?iso-8859-1?Q?MRCVB8tddA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NnawJgGzpYNx5AfuYZwrCOblkx0x13TH/cgWIf0crlp6CSXX8iwBhCTB9YRrm1F+G4FMN1MWtbUumdk0C6l2jI9oMaIslnTmv1ZeI0nb4aXsUHhRMbK3Uv9JfvGjBzA0PJvxA722Hy7n2um6PRIFT7SDvOR14b9ebxfZNSLN362U7MjzkWgikNhHpjFlX3hZF6V8Qxa2RH211Juy8FoG89VfSIYLnBlsZq6G0worLGqd2x00HroZN1/LHOrr1CvDQF+GmRxKiDsG0lbKLIwb3WfQe8ROumBRYPgAs9oCZMBLBnltZZddFVDVzsUKpaS/UcckhbOh/TUcZwJVtotRRg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b42bc08-6741-49b5-373e-08defd0a4afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:22:58.2509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bdkrDZdf6GOiJwatMLvfWwFJcWBDJyOI01WRQI3ODkTpA8cvddQqA2KFMwOeddfbixgnNg9Iut9j3sfjtSjObyJAJgOWo6xnUVsW8R6n6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

Add unit tests for ECDSA prime256v1 and secp384r1, using the=0A=
RFC 6979 (Deterministic ECDSA) "sample" known-answer vectors. The same=0A=
key pair drives the verify test (against the RFC's known signature) and=0A=
the sign test, which signs the digest with the private key and checks=0A=
that the result verifies with the public key. Each test skips=0A=
(g_test_skip) when the crypto backend does not support ECDSA, via=0A=
qcrypto_akcipher_supports().=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
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

