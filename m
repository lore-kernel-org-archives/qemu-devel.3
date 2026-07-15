Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03870C43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNq-0003GE-V9; Tue, 14 Jul 2026 23:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNY-0003AJ-Eb; Tue, 14 Jul 2026 23:33:49 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNW-0000rT-EO; Tue, 14 Jul 2026 23:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgI2Vldj7T5jauszqrVqX93gv6K4rEUs7J4lCFjCUIUVTTVtew8W9GwVcMghm13qtbxfMh04sTFVGgawvyS/JHhIswPCh7n9aX8704p399gCqXZaxd8a8R6g0iYsUz45Zad+tOBNSZBj7t4Ep/573D5GeLAFGlOHUpzXvxRaRLJTMpZGLW4FMBvTk/rXlkwT9Vt1E3LBZ8MbV2o7eI8EmhCcCuNCwCD4LtehXKBsotjhK0kTAn/YdeFyfaiYB4Di5WBsDvJ1nN06ssgpgvXNeTI/KQN++PvDHfZDYxcJ6v8W7WAvd//szuNNg9MnxX3FaZGan8/K6eQsCb5D0A4/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NWM1on+5vaPjjcAwVayzk7AV1Hr1Z0RpuNJ0wWA8lM=;
 b=XFw6zRbjVy+LGMrsMipf/jO+8mCIAcoRmzSqrTNB5E9zeb6dKE2tetH2xllis3J8RECC/fX61j0Bhm4Zt6Yv4sv/cs/IaDAdzbyzzDzBpbHgrDAVOLqtua6gF+IAzcS2ucbhXiPpoIoBEJcZznCiSyBVhevUFc69VyraY2j/pEcIWU7XT0S5NHrnzR+7i+WJM+mo2/IgwJGDTQ5FJAOTScZqt6+a5Wp6nDTncJqTtztjOJ/W9pxEZfFA1sO2oQDRqM5ykvVdZWUgv8TbLRHZkmat7D9pBRt8k6PpucKDxRcKpSzU1B0n2ZTfu+54ZHdzqqI4CQXYliQ2n4i+2G0URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NWM1on+5vaPjjcAwVayzk7AV1Hr1Z0RpuNJ0wWA8lM=;
 b=nJ/TDwy2mKxi1FPpXln/ZHeTEFH5qbUcPprlC84O+CEvBtsPIxmdne4m6vlB9C83WEd/XAZ6VCHEv/jC/WpfKwi3UPGkX4NVJ6QaCwcJ73UFd6dynDSRXRZ2o2xRKzdmiz+xGhbugcOhtfhMQEAvm1VfIk2Gew8G8cLn/vjwlh6LILrUbhyCDp5xHb9O4LRGBQrwPpiy/UGWEoo96Ng6fJfrEv/VKizFDDf9RJlk71ATYLJSZQMYTw2P4wB8soZ2JJDe5FuX1CauNbl1hy38cqSesfvM9FjKY/ufSN1hdbYmWzrlbNbkrOIg6DvFu8ECPAiFuDEXZ9K/Dv9ecrHGEg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8766.apcprd06.prod.outlook.com (2603:1096:405:3cd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 03:33:39 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:39 +0000
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
Subject: [PATCH v2 16/17] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2700
Thread-Topic: [PATCH v2 16/17] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2700
Thread-Index: AQHdFAq5UC/5aMDl9kqr9Waj8/hejA==
Date: Wed, 15 Jul 2026 03:33:38 +0000
Message-ID: <20260715033311.1648424-17-jamin_lin@aspeedtech.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8766:EE_
x-ms-office365-filtering-correlation-id: 39354bed-1e21-4d0e-1fae-08dee221dc46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: L2fBTHCx7StIIZNjMsPE2dxIQGlzepg5JUVpe/ppUc0GZ5gzX7P6CJ6mXitHEBxKxZp21PTwtNNMwsBpXuiMqvvtVa0vdZDeuP7zzvCbiw+K/2nmJEobW/PzpolZvN1EC4ftNDozUItVeuL1RdzUumHucOT/ypl4dBW0l6xgp/z9ssH3Ht7vswwq8hSbNKd0reAvuNayXxMFy3bpvfGrSfC4f09UOyp4wi7/KuodUP11yDoDwa6LPNfahxi+fRN62ad2i7MWP9u3ltlbRb1ptF7dANUBTSxMFxHMLfkDkPCIYfacw/5Vdz4BuDCysluUTPFeUf6f04vGprck6QtE0kFqwfLX2ibSpPSaXg9WgibKaQPk1Ys1kLzNX2IgzEOISb/sMESHbTS+Xe0pTfC8FIYQmAJoSbUJ41bexFhQ4ZTruVAjQKvfbLFCJHT0/LcoosdXuB4Sp0SjTwLvkdgyBfyX30EYolyTdtjCYoMAu3xN+JyUqzv2IgD357RObdWCFYJ9knUQDQjpz+6+1DDN+s/KTtt68gbZEE3rkMPhBAb6Y5XwQLliC4OfbqoccQXyfiUZ9j9K1kwJ1GmJT/s2pF4qfpTEAP6vcq/VwWXVTGXtB2Uwb1yNrqkbJbVssGtqsuZnazFFjKk1RZyThRtkWugFDNE/ZaspeQEVeAUe1aEHt7xDGZkr0eeHtFdmopUL6SiyrCnT10jO8DgFUxw1RS5GiAPiQmRJauppCYNfCSOX7EZfrinv6eI5F8QBfU/L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uxh0BdAv4nH6TcYXvz8Vij1z+hzi5zsaKflXv2axcnpxvkEFO3YrhE2aq4?=
 =?iso-8859-1?Q?zKugHknNsaIoYFSENI1h4WMNXTS1crxg3oG1K4L0ID+vn2N3jXgT27xZsX?=
 =?iso-8859-1?Q?zSxtGI92hmveA7ijp5rZLCoWnaz12ePV0MUZj4Bx81R4/Q4Ynhs9WLGdyF?=
 =?iso-8859-1?Q?9eSXFpzqPPK9eYUt8+AT7dXrK3C4bsPbGdkYiPGkvOaWTYY+AVMOBcxtUu?=
 =?iso-8859-1?Q?GtI2E+fWbcnRld6e95Zvuqyx1jhXFHMJixQrVkPYTL15LuWGuAy2DjzOYK?=
 =?iso-8859-1?Q?G9jRtC5nMxObVSjqXQ0RZzVB1Ye6spzUwWSXuJTX+mgpTSfu9FgZIIJlgf?=
 =?iso-8859-1?Q?aMhPfbXY++hEQ62NHaXbJvKvP8g0MYUr60ASVN4iQdGheK3qjvSVIkzubM?=
 =?iso-8859-1?Q?GaIrUd0vDUmlShXyBWarJB7nZICboQ4e5em0hf3l9bGgoG3BJsxg/2MU4p?=
 =?iso-8859-1?Q?roLa5p5XQgZqUVPWrvJGS5gZnxucLqndFT/NUCKD2CFfyce6Sm8uLHcc14?=
 =?iso-8859-1?Q?OaxSMtN0hX7ipuFG4Zw0oLTlc3bNTWw+ebJ4Du8MMfgrXJzsh+2IBRlYb/?=
 =?iso-8859-1?Q?rSbfAwMn6StU/7wcOCPAVDm2xU/USq4xvV2ry5TVMyCJxZMwva6DUGLP/e?=
 =?iso-8859-1?Q?MxLLyzM756nvt/N4EdUtxeifo9FROKw3YhOT8Hu/Q9Ph3LkrqVeWmFa8Ou?=
 =?iso-8859-1?Q?iCq5KBuWFl76F6MMJ2Tnk3kyp2shupT2p4OX3CFynQWbyq5RgMh4FN7VwC?=
 =?iso-8859-1?Q?Y70YpkH3PYcsyD198JAmM8v28/K5G8y3SvA9X4jxlLyIdVaFqNrtEkjj3T?=
 =?iso-8859-1?Q?wiFBA20fkqRIdaqQFUxNKSguhZZ5KdS2GwgNNtrLoX/liyeOL43AbyeQSY?=
 =?iso-8859-1?Q?AnfWMW0ibdW9dpkx88VPPKmg4EZV0TXZPQiLxrkME3T/bJsIqlNY5in363?=
 =?iso-8859-1?Q?XFIJLcc3iUnG2K3uqe/AvV7YWBAm6ZFCOFplZtCNTUK0xduDnNepNEBF0C?=
 =?iso-8859-1?Q?zy5mWLe5oNZW1ecYw0w29O7gDEDn8Jl7dj9ybfHKKme87p2pBXY9QdFji9?=
 =?iso-8859-1?Q?R2uaIFBhiqLGFtMBZasirbHh8RXuldcAMe0EFOjkAMWams0L8WqStthMnO?=
 =?iso-8859-1?Q?aDy5wOjyPKxSUrn4niwjWqxP4BoCjg5IjmSIoN8tHIeLYd5t5PSVnhGBls?=
 =?iso-8859-1?Q?zIfNo72WKmyaFHa+bAebFEeBKhyGawez7OtekOsPnehRNS7np/emsTKMts?=
 =?iso-8859-1?Q?to1b0dAXFsVT4xkdx8+qUlWGWtfkT2h86Wxh1vtZSMG0pVEt+eftUpisB0?=
 =?iso-8859-1?Q?b9lbJdTMDUQN1m6doieIlKS6B9UB9Q2m5d/t9yjp14Dbq36F3TjmQeePEX?=
 =?iso-8859-1?Q?gilvZHvlyBSECpiPyq2JbZwPhHGsvgrZNojxvqLlAzDPfxKOrW8zutnk8e?=
 =?iso-8859-1?Q?+QBlaLCG0OrzcQoQ44hSl4oNdUjXj1HYti9MeXRueLWKvpy95d+ZzYpgLC?=
 =?iso-8859-1?Q?TGHanFF8YTG1ZZu2tq6sVGzl0nvGJzdAcOiniAnkPTqDG12jxAWeM3pPuS?=
 =?iso-8859-1?Q?5F8cl4Xyg/R/Z6rlq+0h2QBxWKOLARxJe5lim7WC1p9F+tfxblVAenxD+2?=
 =?iso-8859-1?Q?CEUgrRoMERU8YqpmgfpiS1BobiI+VOrn280N8h8zvgpjOpcQ1VM4yHi9op?=
 =?iso-8859-1?Q?J7DEINym9i2xZCpPn+MReB3zO+Tl7+dyEgzwSpYAoQlxD/6KjqRUCoRmXT?=
 =?iso-8859-1?Q?kV48QWrjGE2YqZriCnnJYBJZFTIrYtLBlQSEQD9YWRPb1Gy4XK85HeuUH/?=
 =?iso-8859-1?Q?y5yKbmjqoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WVfBJJdU2nskQvYYhocn1oeoHc7L4eRry0TbGCtPY2Nvr5ilOlAF+Z0eJRfSLSwIzFMLdBqhi97xz4yW6/WxvmiBRgKvjLG2TOKA01b8rX1ks/HzdGZuhBtR7w+QJs6rVUxBZSjgHnO8lv8ByTchWYTRH/eM7T0y/6IPn71yzh9hHvvWnPWBlE8dKTAq+Pe8zw6EUgrm24OOB5kEMpae+mwlyRxWebG3rDT5h+tP1aK//xXXHrgN91rgbLPuhbfp/Mgd1qt0uBz3LZkzAwCM6wLZNctPowaEaqsY6Qk3iRkfOexU1/okN6bEYjXyZU9GIgGhS1xnQlh+KMzBZ/W7Bg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39354bed-1e21-4d0e-1fae-08dee221dc46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:39.0498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFX66o5tLVxgcgJfPAyjUDL3cqFgFuMZof9Mv6rIsPTW7h+BCLova4U0Aj4MsiOV71V1F6ScXj5NyIicXPnIm+JXrULdzAgt8mukCiCy1Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8766
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

Cover the AST2700 crypto engine, which drives 64-bit scatter-gather DMA=0A=
and adds AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.=
=0A=
Add AES-128 and AES-256 GCM known-answer vectors (GCM specification /=0A=
NIST SP 800-38D, no associated data) and a dedicated GCM runner that=0A=
programs the tag buffer and reads the tag back, checking it after both=0A=
encryption and decryption. Register the AST2700 with all four modes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.h |   1 +=0A=
 tests/qtest/aspeed-hace-utils.c | 163 +++++++++++++++++++++++++++++++-=0A=
 tests/qtest/ast2700-hace-test.c |   9 ++=0A=
 3 files changed, 172 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-util=
s.h=0A=
index 82b0b3f93d..a5601a3d65 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.h=0A=
+++ b/tests/qtest/aspeed-hace-utils.h=0A=
@@ -86,6 +86,7 @@ enum {=0A=
     CRYPT_MODE_ECB =3D 1 << 0,=0A=
     CRYPT_MODE_CBC =3D 1 << 1,=0A=
     CRYPT_MODE_CTR =3D 1 << 2,=0A=
+    CRYPT_MODE_GCM =3D 1 << 3,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-util=
s.c=0A=
index f582c88ef5..260eec043c 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -654,6 +654,8 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CRYPTO_CONTEXT      0x08=0A=
 #define HACE_CRYPTO_DATA_LEN     0x0c=0A=
 #define HACE_CRYPTO_CMD          0x10=0A=
+#define HACE_CRYPTO_GCM_ADD_LEN  0x14=0A=
+#define HACE_CRYPTO_GCM_TAG      0x18=0A=
 =0A=
 /* Crypto command bits */=0A=
 #define HACE_CMD_ENCRYPT         BIT(7)=0A=
@@ -666,7 +668,9 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CMD_ECB             (0x0 << 4)=0A=
 #define HACE_CMD_CBC             (0x1 << 4)=0A=
 #define HACE_CMD_CTR             (0x4 << 4)=0A=
+#define HACE_CMD_GCM             (0x5 << 4)=0A=
 #define HACE_CMD_AES128          (0x0 << 2)=0A=
+#define HACE_CMD_AES256          (0x2 << 2)=0A=
 =0A=
 /* Context buffer layout: IV (DES at +8), key at +0x10 */=0A=
 #define HACE_CTX_KEY_OFFSET      0x10=0A=
@@ -794,6 +798,59 @@ static const uint8_t tdes_ctr_ctext[8] =3D {=0A=
 static const uint8_t tdes_ctr_ivout[8] =3D {=0A=
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };=0A=
 =0A=
+/*=0A=
+ * aes_gcm_tv_template[2] (AES-128) and [9] (AES-256), from the McGrew & V=
iega=0A=
+ * GCM spec (also NIST SP 800-38D), no AAD. Both cases share this plaintex=
t/IV.=0A=
+ */=0A=
+static const uint8_t aes_gcm_ptext[64] =3D {=0A=
+    0xd9, 0x31, 0x32, 0x25, 0xf8, 0x84, 0x06, 0xe5,=0A=
+    0xa5, 0x59, 0x09, 0xc5, 0xaf, 0xf5, 0x26, 0x9a,=0A=
+    0x86, 0xa7, 0xa9, 0x53, 0x15, 0x34, 0xf7, 0xda,=0A=
+    0x2e, 0x4c, 0x30, 0x3d, 0x8a, 0x31, 0x8a, 0x72,=0A=
+    0x1c, 0x3c, 0x0c, 0x95, 0x95, 0x68, 0x09, 0x53,=0A=
+    0x2f, 0xcf, 0x0e, 0x24, 0x49, 0xa6, 0xb5, 0x25,=0A=
+    0xb1, 0x6a, 0xed, 0xf5, 0xaa, 0x0d, 0xe6, 0x57,=0A=
+    0xba, 0x63, 0x7b, 0x39, 0x1a, 0xaf, 0xd2, 0x55 };=0A=
+static const uint8_t aes_gcm_iv[12] =3D {=0A=
+    0xca, 0xfe, 0xba, 0xbe, 0xfa, 0xce, 0xdb, 0xad,=0A=
+    0xde, 0xca, 0xf8, 0x88 };=0A=
+=0A=
+/* aes_gcm_tv_template[2] (AES-128) */=0A=
+static const uint8_t aes128_gcm_key[16] =3D {=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };=0A=
+static const uint8_t aes128_gcm_ctext[64] =3D {=0A=
+    0x42, 0x83, 0x1e, 0xc2, 0x21, 0x77, 0x74, 0x24,=0A=
+    0x4b, 0x72, 0x21, 0xb7, 0x84, 0xd0, 0xd4, 0x9c,=0A=
+    0xe3, 0xaa, 0x21, 0x2f, 0x2c, 0x02, 0xa4, 0xe0,=0A=
+    0x35, 0xc1, 0x7e, 0x23, 0x29, 0xac, 0xa1, 0x2e,=0A=
+    0x21, 0xd5, 0x14, 0xb2, 0x54, 0x66, 0x93, 0x1c,=0A=
+    0x7d, 0x8f, 0x6a, 0x5a, 0xac, 0x84, 0xaa, 0x05,=0A=
+    0x1b, 0xa3, 0x0b, 0x39, 0x6a, 0x0a, 0xac, 0x97,=0A=
+    0x3d, 0x58, 0xe0, 0x91, 0x47, 0x3f, 0x59, 0x85 };=0A=
+static const uint8_t aes128_gcm_tag[16] =3D {=0A=
+    0x4d, 0x5c, 0x2a, 0xf3, 0x27, 0xcd, 0x64, 0xa6,=0A=
+    0x2c, 0xf3, 0x5a, 0xbd, 0x2b, 0xa6, 0xfa, 0xb4 };=0A=
+=0A=
+/* aes_gcm_tv_template[9] (AES-256) */=0A=
+static const uint8_t aes256_gcm_key[32] =3D {=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08,=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };=0A=
+static const uint8_t aes256_gcm_ctext[64] =3D {=0A=
+    0x52, 0x2d, 0xc1, 0xf0, 0x99, 0x56, 0x7d, 0x07,=0A=
+    0xf4, 0x7f, 0x37, 0xa3, 0x2a, 0x84, 0x42, 0x7d,=0A=
+    0x64, 0x3a, 0x8c, 0xdc, 0xbf, 0xe5, 0xc0, 0xc9,=0A=
+    0x75, 0x98, 0xa2, 0xbd, 0x25, 0x55, 0xd1, 0xaa,=0A=
+    0x8c, 0xb0, 0x8e, 0x48, 0x59, 0x0d, 0xbb, 0x3d,=0A=
+    0xa7, 0xb0, 0x8b, 0x10, 0x56, 0x82, 0x88, 0x38,=0A=
+    0xc5, 0xf6, 0x1e, 0x63, 0x93, 0xba, 0x7a, 0x0a,=0A=
+    0xbc, 0xc9, 0xf6, 0x62, 0x89, 0x80, 0x15, 0xad };=0A=
+static const uint8_t aes256_gcm_tag[16] =3D {=0A=
+    0xb0, 0x94, 0xda, 0xc5, 0xd9, 0x34, 0x71, 0xbd,=0A=
+    0xec, 0x1a, 0x50, 0x22, 0x70, 0xe3, 0xcc, 0x6c };=0A=
+=0A=
 typedef struct CryptTest {=0A=
     QCryptoCipherMode mode;=0A=
     QCryptoCipherAlgo alg;=0A=
@@ -801,10 +858,13 @@ typedef struct CryptTest {=0A=
     const uint8_t *iv_out;=0A=
     const uint8_t *ptext;=0A=
     const uint8_t *ctext;=0A=
+    /* expected GCM authentication tag, or NULL for non-AEAD modes */=0A=
+    const uint8_t *tag;=0A=
     const uint8_t *key;=0A=
     const uint8_t *iv;=0A=
     const char *name;=0A=
     size_t keylen;=0A=
+    size_t taglen;=0A=
     /* algorithm | mode | key size selection */=0A=
     uint32_t cmd;=0A=
     size_t ivlen;=0A=
@@ -927,6 +987,36 @@ static const CryptTest crypt_tests[] =3D {=0A=
         .iv_out =3D tdes_ctr_ivout,=0A=
         .len =3D sizeof(tdes_ctr_ptext),=0A=
     },=0A=
+    {=0A=
+        .name =3D "aes128-gcm",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_GCM,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_GCM,=0A=
+        .key =3D aes128_gcm_key,=0A=
+        .keylen =3D sizeof(aes128_gcm_key),=0A=
+        .iv =3D aes_gcm_iv,=0A=
+        .ivlen =3D sizeof(aes_gcm_iv),=0A=
+        .ptext =3D aes_gcm_ptext,=0A=
+        .ctext =3D aes128_gcm_ctext,=0A=
+        .tag =3D aes128_gcm_tag,=0A=
+        .taglen =3D sizeof(aes128_gcm_tag),=0A=
+        .len =3D sizeof(aes_gcm_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "aes256-gcm",=0A=
+        .cmd =3D HACE_CMD_AES256 | HACE_CMD_GCM,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_256,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_GCM,=0A=
+        .key =3D aes256_gcm_key,=0A=
+        .keylen =3D sizeof(aes256_gcm_key),=0A=
+        .iv =3D aes_gcm_iv,=0A=
+        .ivlen =3D sizeof(aes_gcm_iv),=0A=
+        .ptext =3D aes_gcm_ptext,=0A=
+        .ctext =3D aes256_gcm_ctext,=0A=
+        .tag =3D aes256_gcm_tag,=0A=
+        .taglen =3D sizeof(aes256_gcm_tag),=0A=
+        .len =3D sizeof(aes_gcm_ptext),=0A=
+    },=0A=
 };=0A=
 =0A=
 /* DRAM offsets for the crypto test source, destination and context buffer=
s. */=0A=
@@ -944,6 +1034,8 @@ static const CryptTest crypt_tests[] =3D {=0A=
  */=0A=
 #define CRYPT_SG_FRAGS         3=0A=
 #define CRYPT_SG_FRAG_STRIDE   0x1000=0A=
+/* DRAM offset for the AES-GCM authentication tag write buffer. */=0A=
+#define CRYPT_OFF_TAG          0x60000=0A=
 =0A=
 /* Describes one registered crypto test (qtest_add_data_func() data pointe=
r). */=0A=
 typedef struct AspeedCryptoTest {=0A=
@@ -964,6 +1056,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
         return CRYPT_MODE_CBC;=0A=
     case HACE_CMD_CTR:=0A=
         return CRYPT_MODE_CTR;=0A=
+    case HACE_CMD_GCM:=0A=
+        return CRYPT_MODE_GCM;=0A=
     default:=0A=
         return 0;=0A=
     }=0A=
@@ -1109,6 +1203,47 @@ static void crypt_run_sg(QTestState *s, uint32_t bas=
e, uint64_t dram,=0A=
     crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Run one AES-GCM operation in scatter-gather mode: like crypt_run_sg() b=
ut=0A=
+ * also program the tag write buffer (HACE18) with no associated data, and=
 read=0A=
+ * the authentication tag back into @out_tag.=0A=
+ */=0A=
+static void crypt_run_gcm(QTestState *s, uint32_t base, uint64_t dram,=0A=
+                          const CryptTest *t, bool encrypt, uint8_t *out,=
=0A=
+                          uint8_t *out_tag)=0A=
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
+    qtest_writel(s, base + HACE_CRYPTO_GCM_ADD_LEN, 0);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_GCM_TAG,=0A=
+                 (uint32_t)(dram + CRYPT_OFF_TAG));=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);=0A=
+=0A=
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, =3D=
=3D,=0A=
+                    HACE_CRYPTO_ISR);=0A=
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);=0A=
+=0A=
+    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
+    qtest_memread(s, dram + CRYPT_OFF_TAG, out_tag, t->taglen);=0A=
+}=0A=
+=0A=
 static void aspeed_test_crypto(const void *data)=0A=
 {=0A=
     const AspeedCryptoTest *c =3D data;=0A=
@@ -1145,6 +1280,29 @@ static void aspeed_test_crypto(const void *data)=0A=
     qtest_quit(s);=0A=
 }=0A=
 =0A=
+static void aspeed_test_crypto_gcm(const void *data)=0A=
+{=0A=
+    const AspeedCryptoTest *c =3D data;=0A=
+    const CryptTest *t =3D &crypt_tests[c->index];=0A=
+    QTestState *s =3D qtest_init(c->machine);=0A=
+    uint8_t out[64];=0A=
+    uint8_t tag[16];=0A=
+=0A=
+    g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
+=0A=
+    /* Encrypt: ptext -> ctext, then check the authentication tag. */=0A=
+    crypt_run_gcm(s, c->base, c->dram, t, true, out, tag);=0A=
+    g_assert_cmpmem(out, t->len, t->ctext, t->len);=0A=
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);=0A=
+=0A=
+    /* Decrypt: ctext -> ptext, the recomputed tag must match. */=0A=
+    crypt_run_gcm(s, c->base, c->dram, t, false, out, tag);=0A=
+    g_assert_cmpmem(out, t->len, t->ptext, t->len);=0A=
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);=0A=
+=0A=
+    qtest_quit(s);=0A=
+}=0A=
+=0A=
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
                              uint32_t base, uint64_t dram, uint32_t modes,=
=0A=
                              bool sg)=0A=
@@ -1152,6 +1310,7 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
     int i;=0A=
 =0A=
     for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {=0A=
+        bool is_gcm =3D crypt_tests[i].mode =3D=3D QCRYPTO_CIPHER_MODE_GCM=
;=0A=
         g_autofree char *path =3D NULL;=0A=
         AspeedCryptoTest *t;=0A=
 =0A=
@@ -1173,7 +1332,9 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
         t->dram =3D dram;=0A=
         t->index =3D i;=0A=
         t->sg =3D sg;=0A=
-        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);=0A=
+        qtest_add_data_func_full(path, t,=0A=
+                                 is_gcm ? aspeed_test_crypto_gcm :=0A=
+                                 aspeed_test_crypto, g_free);=0A=
     }=0A=
 }=0A=
 =0A=
diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-tes=
t.c=0A=
index 508a34dd6c..3f0217d635 100644=0A=
--- a/tests/qtest/ast2700-hace-test.c=0A=
+++ b/tests/qtest/ast2700-hace-test.c=0A=
@@ -94,5 +94,14 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("ast2700/hace/sha384_accum", test_sha384_accum_ast2700)=
;=0A=
     qtest_add_func("ast2700/hace/sha256_accum", test_sha256_accum_ast2700)=
;=0A=
 =0A=
+    /*=0A=
+     * The AST2700 crypto engine uses scatter-gather with 64-bit DMA and a=
dds=0A=
+     * AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.=0A=
+     */=0A=
+    aspeed_add_crypto_tests("ast2700", "-machine ast2700-evb", 0x12070000,=
=0A=
+                            0x400000000,=0A=
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_C=
TR |=0A=
+                            CRYPT_MODE_GCM, true);=0A=
+=0A=
     return g_test_run();=0A=
 }=0A=
-- =0A=
2.43.0=0A=

