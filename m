Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BE7C43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNZ-0003AB-Ip; Tue, 14 Jul 2026 23:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNK-00036a-QS; Tue, 14 Jul 2026 23:33:36 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNI-0000oW-15; Tue, 14 Jul 2026 23:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfJxTQeSgcQVoISOnKak2Xag6J0PsYZbH8EwriiDhJbl9psYewHRDzKwlM7ol/8rzAJx9RJ3sIObCEAsytdA/0U4+eaS0BUsnOdHo8biefJPEQEnooBWMm/0vvwLhLLNOJgA3P575q6EmTpDITncOb4BYQYuoVpIs21gjsoWWlypDgodEvz54Dhp6bDUPxN/iqb+atO4k46Eytnzmyztv4/gWMiVAId83KkFgAQtPK7qpeGpZ8xNeUs2qUG+ouooNC2JupohMgqcAjPBeLl9PUlA3RPjUcFQ7xKi0p2iRM9JQGkXSHh5CIC3P3YITFxJT5G7cMIXwjR0PkWtOo4Big==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksfoOhEkBGFDuXRE1A/T/q1q0R8wl5kPb6wrZUzHmhc=;
 b=iCkGsBuGFmQ581NGP1r54+aqrgLfT3q1Boxq9ncecI9VS4Nf3CGd5wqcl/QrnvuFtHU4zrjvf9397mkbDzHVy/esa31RMWGLfqmlhqwUM/6fUWZJw2OXA55GPhtDkh2AkXr6T2kFcsJhqDxt4B8BXamK1TmikO2Vs+/yqMy2ojLzpsdXPRVE5ZSu+sluNCKSzw86u1Z70rM3megbxfJ4NKzXb55tJDxoIc8bgq/V3bF89ocErJeJSAUwkxPkXDcfclCCQhY7a7atg8nxABP+B/b/NntXXCCzIZ62RUQ2aOdHG61/G4nP89BABZyLduB8/cNtPnAlh4xY7tFLrLo8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksfoOhEkBGFDuXRE1A/T/q1q0R8wl5kPb6wrZUzHmhc=;
 b=ATHeJiDqZ7DWPcPwY3jPITbR+Q8Nhu0rvJuKE43SVsfqBu/eJtmVaSSfyX9NIsH/pfef63JB4IUOFMD3764AfcDUovrxW9R/IAYRtrIbyyp9S0lj4sXy/1uycYqu002yFPyXiskoUylj39G8BHnIJZDC08zAKUDCk0paAIDPjvh/C14M/8Vd2JvNwU5plRenMsvFyqPwlF8EHZ1hgMMAlmyVs+JlKpikgzKGNAz3tAAZgEZnD/MsVuYVfK9WJb9RXDnt7ZUcLE83o6sr66SgUOPQ2iEPgLl32Wu1wajFGJ0it1PUs8GCwFLZuytrYEHZGLUNR2tNnd6QPBB51B3E3Q==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:20 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:20 +0000
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
Subject: [PATCH v2 05/17] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2600
Thread-Topic: [PATCH v2 05/17] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2600
Thread-Index: AQHdFAquUsOItntkOESry5xaoGsA1A==
Date: Wed, 15 Jul 2026 03:33:20 +0000
Message-ID: <20260715033311.1648424-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: d30f3aa3-10f4-4ebd-b1cf-08dee221d168
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: ZpaW1CPVH7E85hvu/cD2bMUMNKKisPC05dPbKCRSetExTxbINHJmSLKDOEbMiv6QramwOlPYTxQ9OjTRpavPz0Yvzn7JZfMtZnu8iQrOowMZXzgZfJw9UqQMjtQN3OpnIGLf5juH02OIfJndL137Is6uGI7zqCtm0BHaVEwK9MG/TjWCIlCRboG9pJtNriOMKACyJofu0lTad8Mh1VarDAaIE8esj2yizZvlzNmPZtXGHb6GLRH2F4OeWY8I9sDGSe572AIRRPusOJ41gRskGT5S3SxEVXlATTESmYcs/5egAJHyFmZFEt/hafxneXJI0TFYcaMfDErVkphcBiapQho1cpreliNwVkjuVNRj0L8AaZ6xdIyBJM95bjfzm46Nyazd3PmPIws9eY6/dScMSIcnUX8p5qBCvF7tHf9xaSFwTxXbDW9h4hptFdA3YQCb5b1mNsQSFAZZ5iwPZHIeWg+uV4TJkqWPIvJGFZ0yqMYcUnhn5mtamfeqgqZpvW1/LlunBQBLvRHCVt4MSv7r5Xyun99RcYgLlkK+qm9w5HfG5774w47RnD5ZUoQ99vjaC1Rkx+KVGnJNBhthUlrGwbU6PSIt05/rsDEoMqfz+UmPm1KooemLhWeIgCa3i/qhcAF7YOteg9JJgN+8Ow5O0Y94C/oqOBsqXkykpB2DIz/nm4WAVx7N7BbA5yZwJHTN6f4kX1bcY2u/mx8M3P4PXnwKvnRdiYhMUhhRzhhDi29h/N94ppA8w6Ek+KfBzpTZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+rjudHEh2EsAcpq+s1Rnp67z3xyDBSbVbTwrBKJBAX6/S9Ll0vvIXFfVbW?=
 =?iso-8859-1?Q?DAXOJAvocOHNWubkH1+gXMuJd9F2M7/UN8dmDdJfwTnP+M0qhAleN+7Til?=
 =?iso-8859-1?Q?Q7aJlnPJWWrgDtW/aKbOn7R5uUeUojl5NJR2OftyK2fd6n6KirclmcVOVb?=
 =?iso-8859-1?Q?FFg8VLArEIPO1BwJCpX22IXkFEtDkeLcsmronB0ztqQk4K+RCH1bImnykx?=
 =?iso-8859-1?Q?MforapwVysNnqD0Os70UmXFdKmOs3wrk8rvAcdNfx3EoO7WvdWnr41o18J?=
 =?iso-8859-1?Q?hVOtKyiNlwgAW6pJh94KabIZvqwx5ndQ3dPGK3UkJEgeN5ArE1OOxZMHeg?=
 =?iso-8859-1?Q?bOrDjx1ydCaAJ2uNcCAWLEYhiEMMhnmvNgBBjWD7RpmqdbcCiukvvchoXB?=
 =?iso-8859-1?Q?G2qLVCaLSd8IqDpUM7HIVJFJGwONUimsh4d33Lq/WAATakHyMaCIDf/6Jt?=
 =?iso-8859-1?Q?DHGql3potWqVmcJYgCeZAhifdN2USl0iGqLD+fL1qFnlCZkNTKutUHrFQD?=
 =?iso-8859-1?Q?7fryLSI3mdQesAWHCEuC7SFNHpRlGk//11u9rPJCgguArlmsnI0NkjDBY1?=
 =?iso-8859-1?Q?CecnXuJwxP297+YaOnjrzrxPoL240oUCMgzQfUZNxgwOMiqe+1Lyji6B+O?=
 =?iso-8859-1?Q?TZ7s6Htz1/DLwQOlShEJ0Uc0XTS5GRH38kFlxSr76bwFzyrwCyvordenNS?=
 =?iso-8859-1?Q?LpWwGt4WzZuXMgkCisV1YJpJrKCNHFU0vGJBOQ5+qJSdufhLmy6RfW0GaN?=
 =?iso-8859-1?Q?X0OL9PU2hIHuUtG1qNJQAd68e6oL89KzUlDO1e5bgSmmtvHsz9IgNlLOTz?=
 =?iso-8859-1?Q?k+86WqiKfVw7cs4bie2l7tShTq/I9lxVMjSvHwO9se6Kl6JXxbyqiM5PrX?=
 =?iso-8859-1?Q?dbknGCa+oLKgzVu/q79tDE3qW1GyPuzJDedql+OaXdQexNjd7QLEFziwUZ?=
 =?iso-8859-1?Q?8XDyMj3c2GBo5VMVnfPgLAlPqRc68Af+G+RGf+oaKbVN6lTVcd3sUgUXrP?=
 =?iso-8859-1?Q?gfadc0TEI25uu9Zjz8DAYQscL5H/uMs0Fig5x6VItgxdk5qb88XAx9nB6L?=
 =?iso-8859-1?Q?ALpEd2+9havik0QVrwZhqlsMi9e9H/qDHR8DQAH2e4k6m4moc2P4cpBBub?=
 =?iso-8859-1?Q?NwcWvDJO8VUWvas0tq5gzb9mrakiUvjMKswPN6HlN+ARxJzGHo09WqueFE?=
 =?iso-8859-1?Q?T9aXTnvSbtgauAOaTrXRmAYgCXqejllorZ/L+usngM7QbrJ+oMMHzrBJei?=
 =?iso-8859-1?Q?rQTd552I4ShakyjZh6qL55wsmvJpQL0ZWfleqBp19ltlT66LDdhfwobVO6?=
 =?iso-8859-1?Q?t3gQQmgWhKa2g/w4BGcsTq4IocpFvzolqu/uWMciYQi/k50HTkqsW/HSoW?=
 =?iso-8859-1?Q?ArxqP3YIqh8EeooZfNo5Yw0Pc5j34ud8I51uuDwIVO6KGFIKS1A/MuF6h4?=
 =?iso-8859-1?Q?lnOAj/XqXnaLjzdM1IL8DZ/HuKLNASCD9xn+ZWx6aSQCsAoHbhOoK/ypE1?=
 =?iso-8859-1?Q?yxEIaNp7ruHZuZHEMJTbf2jyGr1k+e5oYb+NqwE2/6glKMXZBVaiKH08Kt?=
 =?iso-8859-1?Q?olD8h5fKanLuFDVefEbrpVBo6nFqbv5fENiJCZS2/++ZRwPX+35Zx+PO7T?=
 =?iso-8859-1?Q?xRvuNHjbTRXdGZ48pghOVZnsAOqSPYiYOTa+Ai0ogSuCt/05wuB8546kOS?=
 =?iso-8859-1?Q?11rlFTP64fof7wGDVrwjyQEi/BnCFozSMPPpTeDiXrngTnpPF3ZUR/1eL3?=
 =?iso-8859-1?Q?hUwcnZgeHxP8iVyaO1tXEuPm50sPPoKJGHaOWECPlBLtsE10ZeifYJeq9O?=
 =?iso-8859-1?Q?jzPxDMgMpQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oYbms2BnGsKzoMMRcGMrCqsC3JCELtQk3VedhBzOhEO4wd2ffOVhmfeRwaAjvOcUwBpTyBpD1yGHYRihM2dYo34nInhbOZ+WsVOzNuzPjbOczTpZr4tq7UFdL0eUVVb9dSQLWM2oIvLDq1JlIkfmXYX9RYOBK4mvCLMTuKOLxtqzo6vLyKgKs/RJwPFdX+dsm/dr6bIM1acpHrU6OkqJCDofsxVJb8/Szmo9qzNHX2amKP8tdHOo3mXP1pIJDGacBrd8Z039JWS6KRYECjQj6Plx94XASRxb/jOxR9PXacEAC1frKMCi/cEKrVRuEWIzRqF4eUpmEU6RQebG09p2FA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30f3aa3-10f4-4ebd-b1cf-08dee221d168
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:20.7699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssLRTk24zKIL+a9i8cq5cv4yKRmAuSFyykPLlTqyr2XmoFSJ040y13olfO7uAzuC6ntxT7K+QmD/sFc2uylKWttrc3VpN1SgCy7lH4bgEy4=
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

Extend the crypto known-answer tests to cover the AST2600 crypto engine,=0A=
which drives the source and destination through scatter-gather lists and=0A=
adds CTR mode on top of the ECB/CBC modes shared with the AST2500.=0A=
=0A=
Add a scatter-gather runner that describes each buffer with three=0A=
non-adjacent fragments to exercise the gather/scatter path, add=0A=
AES/DES/3DES CTR vectors (verifying the counter written back to the=0A=
context buffer), and give aspeed_add_crypto_tests() a mode mask and a=0A=
scatter-gather flag so each SoC registers exactly the modes and transfer=0A=
method it supports. Register the AST2600 with ECB/CBC/CTR in=0A=
scatter-gather mode.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.h |   7 +-=0A=
 tests/qtest/aspeed-hace-utils.c | 217 +++++++++++++++++++++++++++++++-=0A=
 tests/qtest/aspeed_hace-test.c  |   8 +-=0A=
 3 files changed, 224 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-util=
s.h=0A=
index 13feaa61e4..82b0b3f93d 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.h=0A=
+++ b/tests/qtest/aspeed-hace-utils.h=0A=
@@ -85,15 +85,18 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 enum {=0A=
     CRYPT_MODE_ECB =3D 1 << 0,=0A=
     CRYPT_MODE_CBC =3D 1 << 1,=0A=
+    CRYPT_MODE_CTR =3D 1 << 2,=0A=
 };=0A=
 =0A=
 /*=0A=
  * Register the crypto known-answer tests that @modes selects (a mask of=
=0A=
  * CRYPT_MODE_*) for the given machine. Each test is named=0A=
- * "<prefix>/hace/crypto/<mode>".=0A=
+ * "<prefix>/hace/crypto/<mode>". @sg selects scatter-gather mode (used by=
 the=0A=
+ * AST2600 and later) instead of the AST2500 direct access mode.=0A=
  */=0A=
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
-                             uint32_t base, uint64_t dram, uint32_t modes)=
;=0A=
+                             uint32_t base, uint64_t dram, uint32_t modes,=
=0A=
+                             bool sg);=0A=
 =0A=
 #endif /* TESTS_ASPEED_HACE_UTILS_H */=0A=
 =0A=
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-util=
s.c=0A=
index 0355dd47af..f582c88ef5 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -665,6 +665,7 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CMD_OP_MODE_MASK    (0x7 << 4)=0A=
 #define HACE_CMD_ECB             (0x0 << 4)=0A=
 #define HACE_CMD_CBC             (0x1 << 4)=0A=
+#define HACE_CMD_CTR             (0x4 << 4)=0A=
 #define HACE_CMD_AES128          (0x0 << 2)=0A=
 =0A=
 /* Context buffer layout: IV (DES at +8), key at +0x10 */=0A=
@@ -750,6 +751,49 @@ static const uint8_t tdes_cbc_ptext[8] =3D {=0A=
 static const uint8_t tdes_cbc_ctext[8] =3D {=0A=
     0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };=0A=
 =0A=
+/* aes_ctr_tv_template[0] (NIST SP800-38A F.5.1), first block */=0A=
+static const uint8_t aes128_ctr_key[16] =3D {=0A=
+    0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,=0A=
+    0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };=0A=
+static const uint8_t aes128_ctr_iv[16] =3D {=0A=
+    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,=0A=
+    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };=0A=
+static const uint8_t aes128_ctr_ptext[16] =3D {=0A=
+    0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,=0A=
+    0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a };=0A=
+static const uint8_t aes128_ctr_ctext[16] =3D {=0A=
+    0x87, 0x4d, 0x61, 0x91, 0xb6, 0x20, 0xe3, 0x26,=0A=
+    0x1b, 0xef, 0x68, 0x64, 0x99, 0x0d, 0xb6, 0xce };=0A=
+static const uint8_t aes128_ctr_ivout[16] =3D {=0A=
+    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,=0A=
+    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xff, 0x00 };=0A=
+=0A=
+/* des_ctr_tv_template[0] (Crypto++), first block */=0A=
+static const uint8_t des_ctr_key[8] =3D {=0A=
+    0xc9, 0x83, 0xa6, 0xc9, 0xec, 0x0f, 0x32, 0x55 };=0A=
+static const uint8_t des_ctr_iv[8] =3D {=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd };=0A=
+static const uint8_t des_ctr_ptext[8] =3D {=0A=
+    0x50, 0xb9, 0x22, 0xae, 0x17, 0x80, 0x0c, 0x75 };=0A=
+static const uint8_t des_ctr_ctext[8] =3D {=0A=
+    0x2f, 0x96, 0x06, 0x0f, 0x50, 0xc9, 0x68, 0x03 };=0A=
+static const uint8_t des_ctr_ivout[8] =3D {=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe };=0A=
+=0A=
+/* des3_ede_ctr_tv_template[0] (Crypto++), first block */=0A=
+static const uint8_t tdes_ctr_key[24] =3D {=0A=
+    0x9c, 0xd6, 0xf3, 0x9c, 0xb9, 0x5a, 0x67, 0x00,=0A=
+    0x5a, 0x67, 0x00, 0x2d, 0xce, 0xeb, 0x2d, 0xce,=0A=
+    0xeb, 0xb4, 0x51, 0x72, 0xb4, 0x51, 0x72, 0x1f };=0A=
+static const uint8_t tdes_ctr_iv[8] =3D {=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };=0A=
+static const uint8_t tdes_ctr_ptext[8] =3D {=0A=
+    0x05, 0xec, 0x77, 0xfb, 0x42, 0xd5, 0x59, 0x20 };=0A=
+static const uint8_t tdes_ctr_ctext[8] =3D {=0A=
+    0x07, 0xc2, 0x08, 0x20, 0x72, 0x1f, 0x49, 0xef };=0A=
+static const uint8_t tdes_ctr_ivout[8] =3D {=0A=
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };=0A=
+=0A=
 typedef struct CryptTest {=0A=
     QCryptoCipherMode mode;=0A=
     QCryptoCipherAlgo alg;=0A=
@@ -841,12 +885,65 @@ static const CryptTest crypt_tests[] =3D {=0A=
         .ctext =3D tdes_cbc_ctext,=0A=
         .len =3D sizeof(tdes_cbc_ptext),=0A=
     },=0A=
+    {=0A=
+        .name =3D "aes128-ctr",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_CTR,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_CTR,=0A=
+        .key =3D aes128_ctr_key,=0A=
+        .keylen =3D sizeof(aes128_ctr_key),=0A=
+        .iv =3D aes128_ctr_iv,=0A=
+        .ivlen =3D sizeof(aes128_ctr_iv),=0A=
+        .ptext =3D aes128_ctr_ptext,=0A=
+        .ctext =3D aes128_ctr_ctext,=0A=
+        .iv_out =3D aes128_ctr_ivout,=0A=
+        .len =3D sizeof(aes128_ctr_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des-ctr",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_CTR,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_DES,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_CTR,=0A=
+        .key =3D des_ctr_key,=0A=
+        .keylen =3D sizeof(des_ctr_key),=0A=
+        .iv =3D des_ctr_iv,=0A=
+        .ivlen =3D sizeof(des_ctr_iv),=0A=
+        .ptext =3D des_ctr_ptext,=0A=
+        .ctext =3D des_ctr_ctext,=0A=
+        .iv_out =3D des_ctr_ivout,=0A=
+        .len =3D sizeof(des_ctr_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "des3_ede-ctr",=0A=
+        .cmd =3D HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_CTR,=
=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_3DES,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_CTR,=0A=
+        .key =3D tdes_ctr_key,=0A=
+        .keylen =3D sizeof(tdes_ctr_key),=0A=
+        .iv =3D tdes_ctr_iv,=0A=
+        .ivlen =3D sizeof(tdes_ctr_iv),=0A=
+        .ptext =3D tdes_ctr_ptext,=0A=
+        .ctext =3D tdes_ctr_ctext,=0A=
+        .iv_out =3D tdes_ctr_ivout,=0A=
+        .len =3D sizeof(tdes_ctr_ptext),=0A=
+    },=0A=
 };=0A=
 =0A=
 /* DRAM offsets for the crypto test source, destination and context buffer=
s. */=0A=
 #define CRYPT_OFF_SRC   0x10000=0A=
 #define CRYPT_OFF_DST   0x20000=0A=
 #define CRYPT_OFF_CTX   0x30000=0A=
+/* Scatter-gather list offsets (each list has CRYPT_SG_FRAGS entries). */=
=0A=
+#define CRYPT_OFF_SRC_SG  0x40000=0A=
+#define CRYPT_OFF_DST_SG  0x50000=0A=
+/*=0A=
+ * The scatter-gather tests split each buffer into CRYPT_SG_FRAGS fragment=
s,=0A=
+ * each placed CRYPT_SG_FRAG_STRIDE apart so the fragments never abut. The=
 gaps=0A=
+ * make the test fail if the engine ignores the list and reads one contigu=
ous=0A=
+ * block.=0A=
+ */=0A=
+#define CRYPT_SG_FRAGS         3=0A=
+#define CRYPT_SG_FRAG_STRIDE   0x1000=0A=
 =0A=
 /* Describes one registered crypto test (qtest_add_data_func() data pointe=
r). */=0A=
 typedef struct AspeedCryptoTest {=0A=
@@ -854,6 +951,7 @@ typedef struct AspeedCryptoTest {=0A=
     uint64_t dram;=0A=
     uint32_t base;=0A=
     int index;=0A=
+    bool sg;=0A=
 } AspeedCryptoTest;=0A=
 =0A=
 /* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_* flag. */=
=0A=
@@ -864,6 +962,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
         return CRYPT_MODE_ECB;=0A=
     case HACE_CMD_CBC:=0A=
         return CRYPT_MODE_CBC;=0A=
+    case HACE_CMD_CTR:=0A=
+        return CRYPT_MODE_CTR;=0A=
     default:=0A=
         return 0;=0A=
     }=0A=
@@ -912,7 +1012,104 @@ static void crypt_run_direct(QTestState *s, uint32_t=
 base, uint64_t dram,=0A=
     qtest_memread(s, dst, out, t->len);=0A=
 }=0A=
 =0A=
-static void aspeed_test_crypto_direct(const void *data)=0A=
+/*=0A=
+ * Byte range [*frag_off, *frag_off + *frag_len) of fragment @index when a=
n=0A=
+ * @len-byte buffer is split into CRYPT_SG_FRAGS pieces; the last piece ta=
kes=0A=
+ * the remainder of an uneven split.=0A=
+ */=0A=
+static void crypt_frag_range(uint32_t len, int index,=0A=
+                             uint32_t *frag_off, uint32_t *frag_len)=0A=
+{=0A=
+    uint32_t base =3D len / CRYPT_SG_FRAGS;=0A=
+=0A=
+    *frag_off =3D base * index;=0A=
+    *frag_len =3D (index =3D=3D CRYPT_SG_FRAGS - 1) ? len - *frag_off : ba=
se;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Scatter [in, len) across CRYPT_SG_FRAGS buffers based at @base_off and =
spaced=0A=
+ * CRYPT_SG_FRAG_STRIDE apart, then build the SG list describing them at @=
list.=0A=
+ * When @in is NULL only the list is built (used for the destination, whic=
h the=0A=
+ * engine fills in).=0A=
+ */=0A=
+static void crypt_make_sg(QTestState *s, uint64_t dram, uint32_t base_off,=
=0A=
+                          uint64_t list, const uint8_t *in, uint32_t len)=
=0A=
+{=0A=
+    struct AspeedSgList sg[CRYPT_SG_FRAGS];=0A=
+    uint32_t frag_off;=0A=
+    uint32_t frag_len;=0A=
+    uint64_t buf;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < CRYPT_SG_FRAGS; i++) {=0A=
+        crypt_frag_range(len, i, &frag_off, &frag_len);=0A=
+        buf =3D dram + base_off + i * CRYPT_SG_FRAG_STRIDE;=0A=
+=0A=
+        if (in) {=0A=
+            qtest_memwrite(s, buf, in + frag_off, frag_len);=0A=
+        }=0A=
+        sg[i].len =3D cpu_to_le32(frag_len | (i =3D=3D CRYPT_SG_FRAGS - 1 =
?=0A=
+                                            SG_LIST_LEN_LAST : 0));=0A=
+        sg[i].addr =3D cpu_to_le32((uint32_t)buf);=0A=
+    }=0A=
+=0A=
+    qtest_memwrite(s, list, sg, sizeof(sg));=0A=
+}=0A=
+=0A=
+/* Gather a scatter-gathered result back from the CRYPT_SG_FRAGS buffers. =
*/=0A=
+static void crypt_gather_sg(QTestState *s, uint64_t dram, uint32_t base_of=
f,=0A=
+                            uint8_t *out, uint32_t len)=0A=
+{=0A=
+    uint32_t frag_off;=0A=
+    uint32_t frag_len;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < CRYPT_SG_FRAGS; i++) {=0A=
+        crypt_frag_range(len, i, &frag_off, &frag_len);=0A=
+        qtest_memread(s, dram + base_off + i * CRYPT_SG_FRAG_STRIDE,=0A=
+                      out + frag_off, frag_len);=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Run one block-cipher (ECB/CBC/CTR) operation in scatter-gather mode and=
 read=0A=
+ * back the result. The source and destination are each split across=0A=
+ * CRYPT_SG_FRAGS non-adjacent DRAM buffers described by an SG list; the g=
aps=0A=
+ * ensure the test fails if the engine ignores the list and reads one=0A=
+ * contiguous block.=0A=
+ */=0A=
+static void crypt_run_sg(QTestState *s, uint32_t base, uint64_t dram,=0A=
+                         const CryptTest *t, bool encrypt, uint8_t *out)=
=0A=
+{=0A=
+    const uint8_t *in =3D encrypt ? t->ptext : t->ctext;=0A=
+    uint64_t src_sg =3D dram + CRYPT_OFF_SRC_SG;=0A=
+    uint64_t dst_sg =3D dram + CRYPT_OFF_DST_SG;=0A=
+    uint64_t ctx =3D dram + CRYPT_OFF_CTX;=0A=
+    uint32_t cmd =3D t->cmd | HACE_CMD_ISR_EN | HACE_CMD_SRC_SG_CTRL |=0A=
+                   HACE_CMD_DST_SG_CTRL;=0A=
+=0A=
+    if (encrypt) {=0A=
+        cmd |=3D HACE_CMD_ENCRYPT;=0A=
+    }=0A=
+=0A=
+    crypt_write_ctx(s, ctx, t);=0A=
+    crypt_make_sg(s, dram, CRYPT_OFF_SRC, src_sg, in, t->len);=0A=
+    crypt_make_sg(s, dram, CRYPT_OFF_DST, dst_sg, NULL, t->len);=0A=
+=0A=
+    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src_sg);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst_sg);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);=0A=
+=0A=
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, =3D=
=3D,=0A=
+                    HACE_CRYPTO_ISR);=0A=
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);=0A=
+=0A=
+    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
+}=0A=
+=0A=
+static void aspeed_test_crypto(const void *data)=0A=
 {=0A=
     const AspeedCryptoTest *c =3D data;=0A=
     const CryptTest *t =3D &crypt_tests[c->index];=0A=
@@ -924,7 +1121,11 @@ static void aspeed_test_crypto_direct(const void *dat=
a)=0A=
     g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
 =0A=
     /* Encrypt: ptext -> ctext */=0A=
-    crypt_run_direct(s, c->base, c->dram, t, true, out);=0A=
+    if (c->sg) {=0A=
+        crypt_run_sg(s, c->base, c->dram, t, true, out);=0A=
+    } else {=0A=
+        crypt_run_direct(s, c->base, c->dram, t, true, out);=0A=
+    }=0A=
     g_assert_cmpmem(out, t->len, t->ctext, t->len);=0A=
 =0A=
     if (t->iv_out) {=0A=
@@ -934,14 +1135,19 @@ static void aspeed_test_crypto_direct(const void *da=
ta)=0A=
     }=0A=
 =0A=
     /* Decrypt: ctext -> ptext */=0A=
-    crypt_run_direct(s, c->base, c->dram, t, false, out);=0A=
+    if (c->sg) {=0A=
+        crypt_run_sg(s, c->base, c->dram, t, false, out);=0A=
+    } else {=0A=
+        crypt_run_direct(s, c->base, c->dram, t, false, out);=0A=
+    }=0A=
     g_assert_cmpmem(out, t->len, t->ptext, t->len);=0A=
 =0A=
     qtest_quit(s);=0A=
 }=0A=
 =0A=
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
-                             uint32_t base, uint64_t dram, uint32_t modes)=
=0A=
+                             uint32_t base, uint64_t dram, uint32_t modes,=
=0A=
+                             bool sg)=0A=
 {=0A=
     int i;=0A=
 =0A=
@@ -966,7 +1172,8 @@ void aspeed_add_crypto_tests(const char *prefix, const=
 char *machine,=0A=
         t->base =3D base;=0A=
         t->dram =3D dram;=0A=
         t->index =3D i;=0A=
-        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct, g_fre=
e);=0A=
+        t->sg =3D sg;=0A=
+        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);=0A=
     }=0A=
 }=0A=
 =0A=
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.=
c=0A=
index 4cb4c475e9..61a3e3feb5 100644=0A=
--- a/tests/qtest/aspeed_hace-test.c=0A=
+++ b/tests/qtest/aspeed_hace-test.c=0A=
@@ -224,6 +224,12 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("ast2600/hace/sha384_accum", test_sha384_accum_ast2600)=
;=0A=
     qtest_add_func("ast2600/hace/sha256_accum", test_sha256_accum_ast2600)=
;=0A=
 =0A=
+    /* The AST2600 crypto engine uses scatter-gather mode and adds CTR. */=
=0A=
+    aspeed_add_crypto_tests("ast2600", "-machine ast2600-evb", 0x1e6d0000,=
=0A=
+                            0x80000000,=0A=
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_C=
TR,=0A=
+                            true);=0A=
+=0A=
     qtest_add_func("ast2500/hace/addresses", test_addresses_ast2500);=0A=
     qtest_add_func("ast2500/hace/sha512", test_sha512_ast2500);=0A=
     qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500);=0A=
@@ -233,7 +239,7 @@ int main(int argc, char **argv)=0A=
      * The AST2500 crypto engine uses direct access mode and supports ECB/=
CBC.=0A=
      */=0A=
     aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb", 0x1e6e3000,=
=0A=
-                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC);=
=0A=
+                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC, f=
alse);=0A=
 =0A=
     qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);=0A=
     qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);=0A=
-- =0A=
2.43.0=0A=

