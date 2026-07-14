Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D7AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXaK-0005vf-8r; Tue, 14 Jul 2026 03:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXaE-0005tM-Df; Tue, 14 Jul 2026 03:29:38 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXaB-0006VZ-O1; Tue, 14 Jul 2026 03:29:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAwsAJXaYgIwV9KVsfvxIbg0VXDWjyswhes5XY6/66Dqfy2ujvw8ddDKypOEtnqqO2eCvkQkAbZeNCh0fqe8gyQaMBMXll1lAc7lv9sdvS7nVHbROdoY1oEWZpA/d6ZbYHefbzokUldVxKkepdkM0eVbt8mDhqYaslhvGpuZVIyTF/eezEpE0oyuPpQKCx++0B3zghhVMhHK8j9sfNZzzukYOe0Tiz77aFKJe3uiDiTxCwpbFscgN+P090x39le1HH9I6NUsBBXf1hcRCrhWv3OXod32Jehts3NaHu3MjN53r6PziVC86hEdYpTp3NFFPchFsEUTqJggIClydC5wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abJh6ZdBY+8TyaSPYD7MLbAu28bDHtJm7+byCr9ka2M=;
 b=NHIgmpQ8wIRdcNZC1gv/3/io2CgoIhcEvtfhP9gFGxgvaavvm4JWqQy+fQzwTYnPLj5gZkkjJczZN9SqKqsSwtBvDPF7JCYnHSdMS7hSuWlTEvyOb3MzSXeLnsKfhv3sNBpv9Uss6B/ULi8hlahkEakCqMIh1z5sAR7dwhz5lbiwilwD2+e1XltRmeSA8cI0WB2Wtzi9e1TlDU83ie/Ci7F0Mo25fAQu2zpy8xq9TVj3JJAlsfrOitii8iN/FQ667saJJ2x3UyuRNaUuiGBzqsEfVlZV+1ge4sNcU2J6DleInuZQlgmeV7etabwFdNK2y0GZz6V/fxUj2Ci0ktH7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abJh6ZdBY+8TyaSPYD7MLbAu28bDHtJm7+byCr9ka2M=;
 b=S4nhiyBg5oVeytjO9sHCqE+J2ds2OYsGtzk0dkC3xG85oLMA2iDtLSqXKDVl1wdsTaqMjhVEcD5j2AtFaRcF6m86GZfKJrPCx0o/JtDRw56WxehbWkhDkP7ph7hp7lsBPWLmRQp5wArS3fn61VBlu+Rs6ANA5l2bZjw+6rUzHYmuoTZXXsV6QIPeINNp0Czaz+iEt92G/VqTF60vdFUYVH9wVQnJEGwwFL2y3nh5bPV2SZ9jNiQH7EgOR62ITR5HLyiIw0dq6qlYeO9HuPF3jIK5IV0jA3XrSakShBQn/EAM/+JFEIv2Dhktopmh6Ew9GGx+jlw3dpb/ec1NcgZNLA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:22 +0000
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
Subject: [PATCH v1 14/15] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2700
Thread-Topic: [PATCH v1 14/15] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2700
Thread-Index: AQHdE2J9D/xFNqeAaEmI80q2mlJkLg==
Date: Tue, 14 Jul 2026 07:29:22 +0000
Message-ID: <20260714072900.3023742-15-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: b2e381dc-74bc-409d-81aa-08dee179a009
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: gLpUYKoei7C0l37RGuEecd8aFFduOQ9FVOOgPDhWTcl40eG254fRxENeqegFyvniwBgJYLXf5eENVEkqss6it0RUwxB/pZou7vkpciutwwgK7/emSlTWH83K80hxd+nrcuUphFRlmKcbMgZIL+4OMgzzQ8Vt4xB0fs5d9B9Wt5rlBduJOQ7BNHqtICyuAg2IkuWn73F8X2KDmci29nF9gHi8rG2R5CxNdcRKXOJ9lsqSArkxiefLjNi9O9o0UV1BqaDgk0nYhg8HKe52ushlj7uHjwNC8BZMkDgXM5DChf7/G/3fA7SQcHyHEcXUBENetC1LFzrL80zo1ZBH8bM0zgCBzuzo07ORw7MbNy9Qa15VWoFj/KUoYZSBc4tqkZ+Vc6f0JeN+9e/ShPxMbgN/942lY9En1mbKfLot1r7IB2Rx38QVyrE2A19EIlWKjlscH3UcJkleASi+CJw7SAoyBLSJHtbWAdoL5e56jNdmp8+OtlBTRr56WSEy9C3x2YWlPGANd7EBMaZafgWNe8Bn0CiWdfRq7onLtTy/KJskj0wX3+EezCfx6YtcPt3ZE/oCFiwBwqvn43A+4vm2QdEmV9D/6WT1gf8Mqjae7852tZi6+uyF2NyJ71pihFBK5J1KNRmivfFVEPTPTgI9CMqIDUJnjkS7TszGkCl9i88+t56ErsidDT9daiEahlPkX6pOTLxncHspd3BuGcwcBJNZLyIapy1AjlAWmC99U5e1cz0aM7fDgduVCmOzNuJhnYRK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aXc4pdhpcl3/l9SBKXLMikzdLNWPtJ03PQILQzqBSblA8vUR7Ajqwo3Rc7?=
 =?iso-8859-1?Q?jcRW6kYZGgKolgCYD7EtIoFHbbPzKgu7OYfyD/uceYOBImNSNkkAAe24IZ?=
 =?iso-8859-1?Q?RLbjVDMe2PzFfYx2SKO8f9xPny4LL5m1HiTB9+HHCtiPgCfiedssdvpzoy?=
 =?iso-8859-1?Q?9jV3NSpL0rPZtJTwkvUjvkXuBbE7ddZ2VWeO+jm2RrE/rhTd6cXIGumoeG?=
 =?iso-8859-1?Q?psN01KNnO13xGN5+QABwIa5L/dfdx8XpTvPrFSAda16aEElJzOvBJK5w2V?=
 =?iso-8859-1?Q?prn3nUd5+k6KuZYT0LTMKVfhw96HF6IzPdWIcArIs2wpNCDprI5EPdRPAd?=
 =?iso-8859-1?Q?cE0DWY/VS1e0vKOPG9NGvcTQtarCgdmn+0a51iSqxNlFQNH235R18rBM6y?=
 =?iso-8859-1?Q?xJ/rB+efZ2fmEJrk6d25HqvzkyDfzoN9Mx3EtFBR60nnQDnLa7U6RJEuD0?=
 =?iso-8859-1?Q?bd1BU7y+1NpEk0wXrd4mittPwnA1CM9Eg4OCfp0VTtngsZCADJp2q6Zcfy?=
 =?iso-8859-1?Q?lx40l8ikf04qMyZmHdUEa7A+PUE5euzMq+RrKYSQNdgPo8JvhzTsnvVSC5?=
 =?iso-8859-1?Q?XUn+vRpoz3UGdqsxApiXqRDGmX1u4ZZTCarFCqbQ2rh+BMIXBp/3Orf3nQ?=
 =?iso-8859-1?Q?lzN+NwQI9KtyjroQAzlXq2IrpI8bRJw7nsQhibSEOE75kKtDplW/Nk6wyS?=
 =?iso-8859-1?Q?x8GdyptzmarOyml7sewX59r0ckUafFHPQdtLjK2YyewyyN4wk6nO6t/4uA?=
 =?iso-8859-1?Q?Fvd5kZA8z3xLIhLO4j34R8jhr1X7KW2Qj7ZKOsUgyYO0QL+KdC8RSp4KHe?=
 =?iso-8859-1?Q?As7reiUffDixEB+6dkvxfV4hflYkvrmIrt9QvORIsyTDnmkyR7tj60neKB?=
 =?iso-8859-1?Q?XtHfX915dTkMbIV1lu5Bv4TJ36A0FPR9p+1fo33oOcBz8IuFmoug2C6Klt?=
 =?iso-8859-1?Q?qw2cL3Xk3QlDtF85HljO4pzZPTvV3CSdRIFnIR71FfgkkLeI2IeQSVMhBq?=
 =?iso-8859-1?Q?3VYEOJyph0CgFlVGfmRy4jiCOYY2T4kgPFOMCbNYMy2j7t3BIQl5rdlYcW?=
 =?iso-8859-1?Q?zST1Za1873ySZ1H4YhbUBiQXAjSE2LB9K/ynGdBNTRmin0M7HfxIj+flDd?=
 =?iso-8859-1?Q?sXlaY7inhtXCw5a1xoh7PO2CUAhz5v+UocCPVAY1Y9bH0CjzhqySwM+eV/?=
 =?iso-8859-1?Q?etzjYoxJV8by4tJVr1eTONgS4NC8XPEsRISnxtftBllF+S6vlAmLGe7W+/?=
 =?iso-8859-1?Q?rY+uX9hF27/2eC2IlIrVBjp4IosEoBipPm6BtJ4tP708kzRKRl62uBRihq?=
 =?iso-8859-1?Q?m72Q+9e8F8xfLuhGVNBwOFHKYKU65/3wpGYT6ACOrOXVyv/+zRePITlcol?=
 =?iso-8859-1?Q?/5ykZV8wMug0vRwMjoh1wuBKcj2IjLoAxYTzcX+lSYgGBhDPd+p9K6LTXm?=
 =?iso-8859-1?Q?VCQvW+aSkbKRMcZnvSTdReGSCzBn0QpmQwa3vD1EQL/nAajglgzZKS3DUv?=
 =?iso-8859-1?Q?AHOkSmawlU4cd6dZ74Xw6SRK1HjLrOFx6y1KBWSwieBqGLtqlDytLMxXuP?=
 =?iso-8859-1?Q?FaYwV1VxrW150pgX18Tzs20NnYHm2XfmiYuPnmEKWZsy75CnoZ2bs3OAFK?=
 =?iso-8859-1?Q?HZb83bW6+bKLwFQxkTf0Ti9K8GVDkcUr04u3E3AKq58sR1RZKFXo+jro3U?=
 =?iso-8859-1?Q?JzFgtCQ0IB1YMUMM11DUivJ/QnMMS7G9JkLTxkbdieYZTx3af8ZQed5i8A?=
 =?iso-8859-1?Q?VTaFMtss2jjGk4vcCD2HMi5+IRQhIVtZ3EzpfaAp8eTYbhZgPlfAjHiP9V?=
 =?iso-8859-1?Q?fZVz7BHjUA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fMEDDhM3BtkO61uaFLQbHwifoR1a8bSvlqF4Lgv0ZOgB0uwPlkaQP7rmVJhk3XPCNrU2tXKCbdiy4fTnM5yvPuuDzGGf96k1e8X+FfOKZ6kO2uFbTDNLY7q0llRtBnuVdmiG5O7JMuqNC2iTGxh9+h2OF7mig9O78tX5cjwlniFiL8srRJMiynrwXzKMJ9zVvUICKcDCZNGpleqA1omLGG9uSLE7T6k/gqK/vJg4dl5tFJCmRK1HWSzorl6SSoAvl2PF21ORhFx1Of4yT2CxICLI9lasRoWNUrjGV0ovQp+QsplrvO7LOyWNz8gjLMW81pkL6XIBF/Z8mdBnkKRD+w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e381dc-74bc-409d-81aa-08dee179a009
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:22.5159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W9Bxz0kFauK/KhLMNt2OnAUbE/qj4+feY780aSxpDE5zTgBJuqouZxCJVXQjYxYva7uZHGzG1wyMWAiF7Qo6hS3zCm0I+ADr/jEU/S6WZ+I=
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
 tests/qtest/aspeed-hace-utils.c | 159 +++++++++++++++++++++++++++++++-=0A=
 tests/qtest/ast2700-hace-test.c |   9 ++=0A=
 3 files changed, 168 insertions(+), 1 deletion(-)=0A=
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
index 0b91a4e61a..b421221c79 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -653,6 +653,8 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CRYPTO_CONTEXT      0x08=0A=
 #define HACE_CRYPTO_DATA_LEN     0x0c=0A=
 #define HACE_CRYPTO_CMD          0x10=0A=
+#define HACE_CRYPTO_GCM_ADD_LEN  0x14=0A=
+#define HACE_CRYPTO_GCM_TAG      0x18=0A=
 =0A=
 /* Crypto command bits */=0A=
 #define HACE_CMD_ENCRYPT         BIT(7)=0A=
@@ -665,7 +667,9 @@ void aspeed_test_addresses(const char *machine, const u=
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
@@ -793,11 +797,66 @@ static const uint8_t tdes_ctr_ctext[8] =3D {=0A=
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
     const uint8_t *ptext;=0A=
     const uint8_t *ctext;=0A=
     /* expected context IV after encrypt, or NULL */=0A=
     const uint8_t *iv_out;=0A=
+    /* expected GCM authentication tag, or NULL for non-AEAD modes */=0A=
+    const uint8_t *tag;=0A=
     const uint8_t *key;=0A=
     const uint8_t *iv;=0A=
     const char *name;=0A=
@@ -805,6 +864,7 @@ typedef struct CryptTest {=0A=
     uint32_t cmd;=0A=
     size_t keylen;=0A=
     size_t ivlen;=0A=
+    size_t taglen;=0A=
     size_t len;=0A=
 } CryptTest;=0A=
 =0A=
@@ -906,6 +966,32 @@ static const CryptTest crypt_tests[] =3D {=0A=
         .iv_out =3D tdes_ctr_ivout,=0A=
         .len =3D sizeof(tdes_ctr_ptext),=0A=
     },=0A=
+    {=0A=
+        .name =3D "aes128-gcm",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_GCM,=0A=
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
@@ -923,6 +1009,8 @@ static const CryptTest crypt_tests[] =3D {=0A=
  */=0A=
 #define CRYPT_SG_FRAGS         3=0A=
 #define CRYPT_SG_FRAG_STRIDE   0x1000=0A=
+/* DRAM offset for the AES-GCM authentication tag write buffer. */=0A=
+#define CRYPT_OFF_TAG          0x60000=0A=
 =0A=
 /* Describes one registered crypto test (qtest_add_data_func() data pointe=
r). */=0A=
 typedef struct AspeedCryptoTest {=0A=
@@ -943,6 +1031,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
         return CRYPT_MODE_CBC;=0A=
     case HACE_CMD_CTR:=0A=
         return CRYPT_MODE_CTR;=0A=
+    case HACE_CMD_GCM:=0A=
+        return CRYPT_MODE_GCM;=0A=
     default:=0A=
         return 0;=0A=
     }=0A=
@@ -1088,6 +1178,47 @@ static void crypt_run_sg(QTestState *s, uint32_t bas=
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
@@ -1124,6 +1255,29 @@ static void aspeed_test_crypto(const void *data)=0A=
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
@@ -1131,6 +1285,7 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
     int i;=0A=
 =0A=
     for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {=0A=
+        bool is_gcm =3D crypt_mode_flag(crypt_tests[i].cmd) =3D=3D CRYPT_M=
ODE_GCM;=0A=
         g_autofree char *path =3D NULL;=0A=
         AspeedCryptoTest *t;=0A=
 =0A=
@@ -1146,7 +1301,9 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
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

