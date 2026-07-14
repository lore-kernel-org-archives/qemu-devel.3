Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A148C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXa3-0005po-KI; Tue, 14 Jul 2026 03:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa1-0005oQ-NC; Tue, 14 Jul 2026 03:29:25 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZz-0006WV-AR; Tue, 14 Jul 2026 03:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpFIm4bkvQ58SzKbuon6gDzXb3WEkNFjFUZHYPV2H6d9Ay6ZAlKF2oKwQN82qKnY2GzUWAHWm2OWo9Dtjs/XW6BLK1R+VynXE/GYCK2wdgUbsHsGzLJXscm+9ogX1nyiHzXTScki0eQnaXWKRipSgv4SyDC2bnnqUzoWVB1rBu6Wum3JNkk+uk+72JgTM4Dv3ej2y1/HU9TjQVfmcyumM5OyPAt8d6AzOzFCwIehpU0Ooo2yoGayCM5aDpz9AakIQc3v12fDKsIu+iwImr+hitNUuizNWnJqUSwFMoX8ToR+fGi8MGwswdbcSZuPg8rBtlyV4jBbSwD1XtBtWJrL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOO1wrw1k5xMcdfP69p96uoxG/xnSOXzsyvcc2dJnbQ=;
 b=p52S2HCawbar5x6XcCeaebKtHfcFcfCMTrDVSUUZ32R2UWko/jSPgVQTGvt2c74K5vcHVzbJg19/aunJI1ui5zhYKrfLgROg6ImWHwgpRbqifaz1ywIG9yV8C0VLvcxLip27a0MV5rh0dD75hpvbzPCR+9bLuGbgOcgCSDSlbDqZXkd3mL27qTn3Tx5KYtcwvIYpnE1qI6DWBw73A6T7AOWG0rRJQFbJtqMtJYLx30YB1H4DX8wVNEtovvDWC4QtoaPk4cAAuWd2ORXdyHu6qEhEGzIaa+fHwjG7GkQ2ZRSTqSdmrQVFpT159KhlLWo4Whik8LXIb5tbWtrmXQXEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOO1wrw1k5xMcdfP69p96uoxG/xnSOXzsyvcc2dJnbQ=;
 b=Jjq8BhzKQADBfVzJ4n/OxML/wtY/SUQkQngICW0b7BgKKzNJnQJchKVzqXh6sbCSPwJMc9+F0MNYjw7jkSBBJGAu3T3t7Il/fLW+qxCToxcTJqNSy5rj/jbX1GijpV2XcMMRVIVUfsJimVTTjiEuVwU5ns7yX7kDvEO4ZEiALsB8s9qtgwTp3snwF38lxihcKwGXXfhaGR8y3586oi2NZJU0YMXlD+BOdK66irZBk92HmyW0AsYMmEc0k9eWEGMyEKZOQyUn50yrj7/1bsJXSZlCgNEzh/xeHKyUS6QsHLNC4iDt14hBL6rZN7Lq7Rso0EJc5G3HJbcIjOyEV/bJcg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:09 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:09 +0000
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
Subject: [PATCH v1 05/15] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2600
Thread-Topic: [PATCH v1 05/15] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2600
Thread-Index: AQHdE2J12eWs95Mf/E2k68XuJhkrGg==
Date: Tue, 14 Jul 2026 07:29:08 +0000
Message-ID: <20260714072900.3023742-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: be98b854-5570-41de-8c9e-08dee17997fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: I826crLGOWcB+52bt9HCQ/0tlXwFICAp3iJ35sZKlaJ1MVdKlJIqNEV3EbBDp4JguRMRl9UUNmNr0gChTPsYnu8GGsD03h4YaUJXzj6FZEcovwxdVqT7kVhm1M4mq8xjaoHBHIw+4oK8yOLLu1ZQWPKdm2msBu7SyFiU52D7V3PH0bvtKH9wHVlNyxz4ZUFVnGRqi61qicmaUcFPVJVmoNu6LhskpqU/HWgp8ov+4LkOA+aCAQkeTlWDNHLXXNH4eIOpyaYrv/5p2SIO6McXL+B9RQObwGhjYZtzlzoX6d3BMolWhdHPgWknVaOph6OmYQotkvqz5Sf5CR2srG5hmZ3Q9rLEwHwxUtlmwqhGPOak+8jTaJ+yCenWggdJvV7TTG/j9U5d5glQtkB4u+OiwFiP4MvEVVTEtqmb++SzRf160jW4euOIgXF6xLyV5nP3aRs1wUHXrldMT1onVIozImWuPonNiGejnsD6F3gSnI1ORdsTV04aYi+KMtVFVpXYRO+hMgvrGRv40KbeJ2wYRbLGMrb3Nb0fZXwAPjtQwc4DPhMT6RytkaROLfRLbo2wh1jn2SRctq4sL3cmq2/zs+KW/qqxT+aOTz1D7JMbY1aNTDDjq6DeneYdC69lXwLHbrWI/n2pbhIeiezjTMq/mDyZktLDMfDcbqknr6w4KTMj6zoJhSWfSOa/ZOaOBFd+oiqyyBmKslwsW4hM6jcQdCt/iP3paVcknByQm0qpU25ftF1hhjBwSohzEIhEMgvE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XosztubZw28MdN8R1XHlGVDDAYK0HaFGK4cFPWa33CAej8iCaBtkE6Dmpe?=
 =?iso-8859-1?Q?Jjiu+nr+QjHk+x2j3eVneI4wqMPA+Y9BwtzrCPwfFU47oszW1r0EfMBkMB?=
 =?iso-8859-1?Q?FbIFwmiZ3VzLOENwJcZZi+uZt5/vMQZlDvrb44horjOlqowrZOdv0YlsYz?=
 =?iso-8859-1?Q?O762Y8SB8c7COdEOlZtZGUqhUahBv+nWq63fOlkXEFj7AxZkHPWvS9S7XF?=
 =?iso-8859-1?Q?2crauSyGjtXadNwPExzZk98NF/srDCbQQjPCuLe7gSdhkUFjyvfeXwroU4?=
 =?iso-8859-1?Q?+3E12XPiqEwm+W3b5hQrvtMod7U9Z8tvScXq8s7/QUU/zD6jxmji5VwEFE?=
 =?iso-8859-1?Q?7ugs7KlY/wxvrZQlMEVGmR2DNG31qUofCndROj7sWkPnFs/oyAxIhl2IrK?=
 =?iso-8859-1?Q?0LO3Oel38TF+HXVGAItUs353LdRFk8tL07z4TB1cU+bF6odImvwNTbpu0r?=
 =?iso-8859-1?Q?FBUXRal4KIWcEKMVjFWKxeBRsq6d7CRH/I9dH2uS33w1+pKANh631aqCgu?=
 =?iso-8859-1?Q?cpbCiYl3HKkFVeYvvaywk8XkS2adlYUZpzIb48qdnF73pf8k43TRu4v5It?=
 =?iso-8859-1?Q?FRBK4kzbV+g5CVZI0lZ6K46kiV3ZM8uKg9gEryoiKe+ehbtW1gHwRzYdWi?=
 =?iso-8859-1?Q?oFnu2s1nayaqoYCivZewSqlyxUb9DN5GHDIarDvFP7w/+usWBJpsDsbsVi?=
 =?iso-8859-1?Q?iRbdQ4QilcNFq4WpZKqL7gQN7BV0f56r/cNotbbbB/0qD2U4IGG0FL3z/J?=
 =?iso-8859-1?Q?qCFcpHH6KgRZ1yW6h5HfLeTMVk40ruz4s+OXd5POGg7oRip8ZRGCoFxkg9?=
 =?iso-8859-1?Q?5ZGsdFSfsOdGr2yHNsZy2r4JVwKug1Ad6DmQRbDVAOqagnqCb8MhrIRiaT?=
 =?iso-8859-1?Q?Dzw5eQUkc3qc0CFIokjMA8iwSF8YefdOf4HtNrgDAfJ4Iq1otZeEFouWpm?=
 =?iso-8859-1?Q?JEkYBlCLituhq0918crg/X6+RvYb9bc5Oun5HePZslVLGIQDT69RAJOHuP?=
 =?iso-8859-1?Q?J8ly5pPyxC2bBVqoufBmhRWzRVPvfCBCC2iapfs1qHuwAWu052zp8EH8aS?=
 =?iso-8859-1?Q?lJ/6Sj7f7VIrR+jf7rCpBPrua3D+NsvQjyu4K48G7QSU4Z4ewXJUEKoYf9?=
 =?iso-8859-1?Q?T7NY12B4u2j43+Uu4MzBRTaCcBwFyVtXZiViVBJyn9xYDwkPASJrtnT/kU?=
 =?iso-8859-1?Q?1UZgeMJAO3A6CxZDSDcTF8NMYjHZ/oFgaEoQm3jHk0pvSRBBOVJNvUmX1/?=
 =?iso-8859-1?Q?D/qQoB5Et/Epycs31nxQD/ADPEQAAojrOFWLC3nfwRYeoCqko5Z0PB6hTW?=
 =?iso-8859-1?Q?hbYblA/Prc8HYCMdXdJ+nNU21zRomtvCtXK/yt8RqYoR6KzXvXR7Gu9spN?=
 =?iso-8859-1?Q?Y4cdAdzyzEf+7BPFGf1qV6ucErVaNM2JCPray5bMR+m4QWa8FP0CWucVEU?=
 =?iso-8859-1?Q?r0XBvPsJzzSb8lXqHip2x5Pz15vCx/qKyb8xc6ihSaEbG49E4Uui5OFbwp?=
 =?iso-8859-1?Q?vJkhgReAOQ3bUV87smpkkwLPRb7Wi2FCITbz+TC8N3ipnfejtWVUPkC6fe?=
 =?iso-8859-1?Q?HJ7tSNUvH08HOd2pr6YWclxLdK+5lO9U7oPFBRezt+qvcT7ugNBnxA4n0t?=
 =?iso-8859-1?Q?bFkxE6aKPaRzFdqK0x0lKMs+EGqOq7TVfQbWvLU58HRM4NcXFpF2nUE9JF?=
 =?iso-8859-1?Q?mRxg06KIApddFpuVWW8r6hmFGt8vyiREAiVQzVFLnsAYoAFt0z/wFsOKiS?=
 =?iso-8859-1?Q?Cfc2njZ5DIYCZHZE7amIyO7ciwMo5w/T5fD9G7wvKNaFMrFocl/BqWnGlX?=
 =?iso-8859-1?Q?5ibmk44K3g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Jh1cqG67zdMYbf5ltiwAMy6XXRG4YciqC1Ektwuyci1dHTExfTGUOh/uAcKVZr8IChg7xi1JAw3eDhBrQu+/15B7qfzHbCroRFolsf+v4M8Bkl9EfGtUAbpkjpBFGq+A3C49s0Vg4LkLYHvpNxKjo9X2R/NNpwD/6dwhuoXoWvU3Lrm0pWiLqQwBCvQ8t6js1EmyPm0+MGMs1nHwLbqyayfzBgs0Q4ms+HRnCxhR/k3q5yKaabeFXyOi9yti1CeITGRwfff2qHwoL82dim6f4CAy5uEu5LKZoKBkXWzpzpi8X1k3NPByRx9XoVWHemU5Ioks5ygMM+ZVvJirGRGs8A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be98b854-5570-41de-8c9e-08dee17997fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:08.9610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZscKrqJ06v6ovWGV+rbw2NtdpevpN2sBOpmpPfEfUvZmAHF5rRWWtpEP5EkID8Ur6oLHlAr4uYNdAZeyLUBSJqfow50H4Jhkn1Kf+R3GorI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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
 tests/qtest/aspeed-hace-utils.c | 211 +++++++++++++++++++++++++++++++-=0A=
 tests/qtest/aspeed_hace-test.c  |   8 +-=0A=
 3 files changed, 218 insertions(+), 8 deletions(-)=0A=
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
index 4deb88dbcc..0b91a4e61a 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -664,6 +664,7 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CMD_OP_MODE_MASK    (0x7 << 4)=0A=
 #define HACE_CMD_ECB             (0x0 << 4)=0A=
 #define HACE_CMD_CBC             (0x1 << 4)=0A=
+#define HACE_CMD_CTR             (0x4 << 4)=0A=
 #define HACE_CMD_AES128          (0x0 << 2)=0A=
 =0A=
 /* Context buffer layout: IV (DES at +8), key at +0x10 */=0A=
@@ -749,6 +750,49 @@ static const uint8_t tdes_cbc_ptext[8] =3D {=0A=
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
     const uint8_t *ptext;=0A=
     const uint8_t *ctext;=0A=
@@ -826,12 +870,59 @@ static const CryptTest crypt_tests[] =3D {=0A=
         .ctext =3D tdes_cbc_ctext,=0A=
         .len =3D sizeof(tdes_cbc_ptext),=0A=
     },=0A=
+    {=0A=
+        .name =3D "aes128-ctr",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_CTR,=0A=
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
@@ -839,6 +930,7 @@ typedef struct AspeedCryptoTest {=0A=
     uint64_t dram;=0A=
     uint32_t base;=0A=
     int index;=0A=
+    bool sg;=0A=
 } AspeedCryptoTest;=0A=
 =0A=
 /* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_* flag. */=
=0A=
@@ -849,6 +941,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
         return CRYPT_MODE_ECB;=0A=
     case HACE_CMD_CBC:=0A=
         return CRYPT_MODE_CBC;=0A=
+    case HACE_CMD_CTR:=0A=
+        return CRYPT_MODE_CTR;=0A=
     default:=0A=
         return 0;=0A=
     }=0A=
@@ -897,7 +991,104 @@ static void crypt_run_direct(QTestState *s, uint32_t =
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
@@ -909,7 +1100,11 @@ static void aspeed_test_crypto_direct(const void *dat=
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
@@ -919,14 +1114,19 @@ static void aspeed_test_crypto_direct(const void *da=
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
@@ -945,7 +1145,8 @@ void aspeed_add_crypto_tests(const char *prefix, const=
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

