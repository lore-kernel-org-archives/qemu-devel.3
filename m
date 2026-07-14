Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E346C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXa2-0005oh-4h; Tue, 14 Jul 2026 03:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXa0-0005oC-NJ; Tue, 14 Jul 2026 03:29:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXZz-0006VZ-AS; Tue, 14 Jul 2026 03:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HM1qm4FY4ZTo3W2zQUhcvTheUxt00pUAg+Aj9e69EEuIrGc6xlYq9mW+r0GCUf9YmZW8PiPHk7y6oDcrncPKAOzNIpQMVqmWL+uDWcFjJ9EMAVDh0nQtrBmthLPWXieqZfD4uynOa1vYB7OXc36FHrE/GO+apgXMAgOJBBK9VDf5dU4teIsHcy+0lco0nDOUEup/ZuVjo72JsrlUpEjfXWaSgmW2Kp3jN+XtcUo5t+jfHAxZff1Rn3G3eH3hX3TYE+DfVcFBEG/MYWat+o9eh68QCDRrx0eWW+FF7Wewu0prPejgHiCMBaxPZeDWNS8FyoiVbBInjcMPVqr4iHY/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vYymTcfbT4ZnzdcQ6MVVHEzqJaTpni97oWsQ5UIO/Q=;
 b=HdOd4XYryonXSzdSlxTDNLzyuUIdImpEsbNjx4w043FUaReAlAOVjrslswbsx6gTGrnIN06rRViDlCFmGrWpVwSSP78r0nIsh50ENAVhwhZjqs7D/e3ZXIjvBh9Om3iAwPKLsldFwvNAqAJXJ+Jwr09SYXHfZ+vPqgtJN0DXExVzicJFRUXs2KTI1HgN0T7T5qY4lqNZA6pSSM3X8LWorkwHsBzoekI0KGZYQGoQ2OFy5SqHWbEoL87rLSHcqS7z1theAchg3mI27vngP4gSssQ5bOG0GQL6YmFDv+Qaxkx8Srdrvr8Dccw/XTgkz8f3b/K5TUrA+auM0NM62hd6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vYymTcfbT4ZnzdcQ6MVVHEzqJaTpni97oWsQ5UIO/Q=;
 b=rGLAILtA9l3WNB3dEVtRQqdX8eisoGkHQdPYzcTMtJXcRBiGE4pWQ/FyJv77mM+x9zmyN1B1bn1/kZ4AqsdenOT/DRCILEsm/Ol2nSO7s0vYlsmBmg1XCfi6YaW+xaRV0wmEwXoUajWRkQa8Sk8eFN+l4sMMPfEyaF+qWa+tTMRzCJu79eoPQ+2p0hFBF+gzGuDl+h3j3bfIaJrPIXcrDg93Qqy/YomGXWEfUEtojUy5odatafobQuGE+nvQfoj7dnMEjR7FyFTRI7yR/rZ1NHGDGPMA8EJlUsJStaRSPuvUqf/SWzjl834Yxyuyn/CO6pVS9YEHFwH5S7JqHpJNdg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:10 +0000
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
Subject: [PATCH v1 06/15] tests/qtest/aspeed-hace: Test the crypto command on
 the AST1030
Thread-Topic: [PATCH v1 06/15] tests/qtest/aspeed-hace: Test the crypto
 command on the AST1030
Thread-Index: AQHdE2J2mS7tMOuEIkC/BrlDuj8+bw==
Date: Tue, 14 Jul 2026 07:29:10 +0000
Message-ID: <20260714072900.3023742-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: f9a5e4d0-2e42-48bd-4832-08dee17998cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: RCpOUm2PjItTBH49xnNpnLKpzoihiNikGnl7r7mlquHNbMRxgpQXKr754X1FXeLVYzT1hO5ahKfzGuMFrBqOu20k0rS4IVuuAOM11ksvt+JlhkHv/uwKhvXTqFgZqx7D5vLsqTQ943pzR8Q3wZ5n3YMSgG/RMJNGD2lS3dmUVfZaC+4xY+vcehg8d1qyHU3fkPvm2EsUR2CHD7YWtesT2fplBX6S5IpajOLfCBvNF/xlEw8nISdbCitn6EnXXqJxvs8PAnhAQ1cc92AZWxr0rbBfAo+GbC6nF9RENorWbeYTJV99/rGc9t2DT5WuKJJmemh1CR8iW+OmVH6veiphPCEnjFHryYkHm96FDRKHZqj9B00e9mGK3JjIx2GAClmJKwttGvA9xtjwr1TBzo+jgiPi5PV/NRydVdqH8RF7Mh6bv72kWKFUygudZMYVCuUB6h6iX5w8z718bER9eH+QB/hSIvOZS6f6dUm8XKdQty7AoZCfBuHpcxrjiXGDgjZ1DbAlrGY+p7NyCOVIywbDmeQbBmA1EBdoss3onwD81ijethqcQ1FoBFYGr+HW8RqI/xIkTmaABsk9N/Q3N0LWpj8FwBq+zFRmtjE6zmuEB2wSHHce/qURNojJsdsOS+yFHUPMcDhtUSmFVKapAi/1mMPeKa7pbODvuh0iSy74WpWkvGWnC0gatcr1QctQwxToFRtPKuBCxn68YTHXOsbChGkOLMTczxwAbAO0XfCblGnPVxnovoSy3U1et4HFx4gy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R+EhHgtpxbskT7slYWgZiJjH9YzrTzkfMNZP2U/ImdU5mf5lxyVQzPnHyT?=
 =?iso-8859-1?Q?SJJiKrRenwAIH3qvuZYaPyViWqTo+p1/a2U3lvVXRxaYDC2K4+o6JLaY5i?=
 =?iso-8859-1?Q?XjGxalN6wriXaOtdQdlHujAdUgHbRn7JCK98MF+BwFQl+FfzD0alRb51fe?=
 =?iso-8859-1?Q?PUpLmHzNOg4XJ1qMfxzy84z9F9y6cYaa3vhPqF8LgDc4MeRHAWhYxgIPHf?=
 =?iso-8859-1?Q?WxEB3NZ4J+d/6rgoVTZuLW+QoEkzWRnAyDd5IibEIylPiFHEJjKbEZZzzy?=
 =?iso-8859-1?Q?A921PBtWQNKfVm1TsZKvI5fHPKE1HHKYZBXHS1713WnWfNZlxx5ZiIWaNX?=
 =?iso-8859-1?Q?VdVXah3syf4CcRvDw0mTeyfkaeNVCYqQSpBFvnxDtkC3luBH0L5JR9hXcj?=
 =?iso-8859-1?Q?DmppZpDhB6+xGDRV3ol2s3vj3K9vmxrPu7zoi5V2p/cSGpOa1oJdZDxjRw?=
 =?iso-8859-1?Q?72+kA2hDCGCOmfP75AMuXGpX2qboGnmExZKUlwZuZvvv/G2x0Mp3tSR5zk?=
 =?iso-8859-1?Q?9TozopKIcbTOvQCmQ3e2YegOYF09c1DvsniNbd/G53r9AQnVfkxweNjYoE?=
 =?iso-8859-1?Q?dwNVvz//K2+l3anVxM674PaSL3ca5j/aEKFTSSzsIYTjL0NDqSjZf5VQWv?=
 =?iso-8859-1?Q?du9EZckYPV0gUC7pzkROvxBpatIxh3l1Wv1lk2nNqunRZsP/IZDe8VoX76?=
 =?iso-8859-1?Q?COmiKeNpbtzUZTZ5UW36fpFdjFmzBxLdTAydBW7knilO7J+DZ0YLVBwzxB?=
 =?iso-8859-1?Q?pBS2eYayQL3qIon4oKQO3ORZYtQdZBqUwWu1RaouAZXh2OFY+IgPhnzEot?=
 =?iso-8859-1?Q?ytPpjIz5k+7qSfZXYej1EekaoFP4R0GD2+abr95gVyR3SxcHBnFAA01ccj?=
 =?iso-8859-1?Q?0OzCX+bkydd5g8HtOfLoKK6cazcYYr1TxDwwATrta29WTekQoXl8RQtee8?=
 =?iso-8859-1?Q?a6HBXrBPQcLwq5lgR1+XCWz3Vngz4ZSW2mZjHre0wMc06LB9D5tu1Sbp+f?=
 =?iso-8859-1?Q?MpYIXRzWZtzmJ8puOL5G5GcfKSnoEtZQfepurJeUflRfTyh972WImPWRTP?=
 =?iso-8859-1?Q?EoEz5qDSGnyUBnwwdxQz+xNV5TizQ9PxOp7BkCIySCKF5hGjGyH7LK9/PW?=
 =?iso-8859-1?Q?VN4jbkRD5j+0ctiTSmFr9rrNhrLIRzQUGMSECxGoJzsLN6xztMWZj/WUxG?=
 =?iso-8859-1?Q?pw9H5kJA/vTBBFOIax+e+ctyy6JOzxc9Jodt5wC7XXKAs0dUSbYCa/HP/b?=
 =?iso-8859-1?Q?j7rEMF+5PPWGRl6trwesC5MHdDs97xca3jeOl2znTVXFwFwGUGxwuKwbh1?=
 =?iso-8859-1?Q?XJXI4KO4quX7ci3MaNMjnbt6nbq17dmd8aLyKHIqNB+G9VgQtlkWaUCScL?=
 =?iso-8859-1?Q?1I6AfRnUkZzQMMMEul4ZYYf9rx93vpoYlhC41XPZlIPDKF7gEbVqkXFmrS?=
 =?iso-8859-1?Q?449JxefQgep29+7zTlqL9QYvoR9RjTtHk4hmJcQs9bir5iiaiRCB0zaiHC?=
 =?iso-8859-1?Q?ysfZX/8f0D3JkTKhqvoBG0YXU4qKWu+digD2U38505B8xsflnfzovZQSSo?=
 =?iso-8859-1?Q?wPhOymXcGnlBFtyFcjXbbqDhYrp+XgnUko1St6XriII2UMm2KJel9HniEk?=
 =?iso-8859-1?Q?oWNYyU6uy/tJ8/moVzaQcKSY1foXxD8Y/YACQbijjMCM/LA3Uj3cfiiBv8?=
 =?iso-8859-1?Q?7vsXXHFOsbLisEb6J9n/7CwA7T5ZaFutnWHJxrN8BNkufLApjhK/5yKKnn?=
 =?iso-8859-1?Q?YaXZ8l1/fZ7qr1YT3bNnhayvOcOX3SfuxE7fIlYtRcVAg4x/aIeJo03lal?=
 =?iso-8859-1?Q?m6FEdePNcw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mpR5M+tRyuBjKTFvJKk8I6A27YEzUBXG6NiSdwuSUczD/zvJvHIm+XR72HXCy0av4AVQ84nZwxCYkqHr/SWFkslkYyKfgjFPwz2FxCHBcMiAK2Hj+JWaR7iA5705Q1Zp9DEOsnGZmRbNdoYKwPRhnOxotZ45F/KSkDCU6Zag+TTBW5QTgtA5zngQDlNCKIZSqbWHZJsxztYQKWwoDRnYZdvAXYzEFg23GjNQAMBEFFG37eEVNBHq+IZYy+IYiVeUksGnK7kYaBPBlDzBqsY2QUODtRFaFeCl+TixnsnSzbJIZ00T+ND+YNxnENeiIgsxCrBiTBTTj7/qL6BUNQqKfQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a5e4d0-2e42-48bd-4832-08dee17998cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:10.3573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZReixSxjHByS98K8zeWwliXBqPD654huAMM/VTky0kYtcLtmieOJcBzagj2dSnrZi7pC9tejGzb3/rKcpR69iKy1eYoVjDfAxgpuB7RRck0=
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

The AST1030 reuses the AST2600 crypto engine, so it drives the same=0A=
scatter-gather transfers and supports the same ECB/CBC/CTR modes. Reuse=0A=
the crypto known-answer tests to cover it, registering the AST1030 with=0A=
the same modes and scatter-gather flag as the AST2600.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed_hace-test.c | 6 ++++++=0A=
 1 file changed, 6 insertions(+)=0A=
=0A=
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.=
c=0A=
index 61a3e3feb5..42130df1e2 100644=0A=
--- a/tests/qtest/aspeed_hace-test.c=0A=
+++ b/tests/qtest/aspeed_hace-test.c=0A=
@@ -210,6 +210,12 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("ast1030/hace/sha384_accum", test_sha384_accum_ast1030)=
;=0A=
     qtest_add_func("ast1030/hace/sha256_accum", test_sha256_accum_ast1030)=
;=0A=
 =0A=
+    /* The AST1030 reuses the AST2600 crypto engine (scatter-gather, CTR).=
 */=0A=
+    aspeed_add_crypto_tests("ast1030", "-machine ast1030-evb", 0x7e6d0000,=
=0A=
+                            0x00000000,=0A=
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_C=
TR,=0A=
+                            true);=0A=
+=0A=
     qtest_add_func("ast2600/hace/addresses", test_addresses_ast2600);=0A=
     qtest_add_func("ast2600/hace/sha512", test_sha512_ast2600);=0A=
     qtest_add_func("ast2600/hace/sha384", test_sha384_ast2600);=0A=
-- =0A=
2.43.0=0A=

