Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D1FC5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYW-0007OJ-GB; Tue, 11 Aug 2026 02:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYT-0007Lg-UL; Tue, 11 Aug 2026 02:01:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYR-0002ec-8I; Tue, 11 Aug 2026 02:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoLxPrUvo27BKkOsaghaIhJ0YnXDkG/qOrfjE4kW9XH+5AE41zMqpR2NvGdOT7JHOzgVGXa0q8McFUvAdxRUSSEEQRLkGkH55BtBe6CC2nqnnATl+qkAi39gw/Jt7oqrKYGoqkCHFbFQ5JUDYzoB8RR6BP0SiOGg2IvGN4WXWz9ZzWzChPaXV3QfVwauwL/zFqEfRHS8X1pXMsAk533P8obe02O2MNU0dtMI9N98izmGZKKpN9Q+Urcrt+4W2FYOJizgoljWtpjXLyvzhLBCZ+ubyoS5mFdLUBu5n+EJ/fEbRCCe8A8U0IrWthvPzV55PEQZDkYz2WP4KLRqaPVCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCRWVXpbqDvkmt1QnoVN0TR8TkhAdg9QWz7Htkp3Zos=;
 b=UJHVYq1/wyh4XNk3HRtR1e7ZFRD3CyP8hHnEGGb9RidkDVOk6MVn1HOTVYDU0gY4AwVs58FbFQ/UCPJ88WGT8lGnO560dEBvA+SdYdWrgoUkgg/aJvJlmIOBBksplearCsH6pGtY0kqJrf0m+1v3lYK+b0MwS5l8L5WiWE8ofYvup0zZmNeA+ZzkCJCXTK0uHOCA6s6iJeeb7i90kckb5tx1ouzwJDzttciN4Bd1Mo/nD9020fwWWZaUA935MPziY9pb0RK79OXIyUiIqn5IDSat4SeVn7141iwf8bC4m0AgTjBG0reNy5i06Hy8S6QaWW8+87hz349IzXpTxXzLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCRWVXpbqDvkmt1QnoVN0TR8TkhAdg9QWz7Htkp3Zos=;
 b=jzuVAU2SEVGSv3bPby+wb8UoHzrH3BtkTTfCIL9TQiGdKUhJY/iyUZ4VCPRPWxYRfVq984i4V+rBiL0qOKdpzHmJtsS0yvzLJWAtv1R1gOOvX7xGAmJJOypKDDAFZgGammi2VoKsCIHavMpMGh+vXkkgoh9MIa6CVFF28JDYo0lZ5GXvylTUcpF+q+QhVcufjmILtMvO49E2usWNhRghhCe4DNWGRt4wQnYWa4r8MVSAko4eFJkIQ2zysoW/G2z221x5hrHY9CWA+zcef5NU3PMSYFJbt5fa/4sJx3sEnBspkn9PCd8u1oP48hknAHqNGzZkNFRuo+xkEy+oq6N1SQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:25 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:24 +0000
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
Subject: [PATCH v4 06/16] tests/qtest/aspeed-hace: Test the crypto command on
 the AST1030
Thread-Topic: [PATCH v4 06/16] tests/qtest/aspeed-hace: Test the crypto
 command on the AST1030
Thread-Index: AQHdKVbX11c4E05aWEyPVUeUJ7KnZg==
Date: Tue, 11 Aug 2026 06:01:24 +0000
Message-ID: <20260811060115.1849266-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: a4522781-8f52-47f6-7970-08def76df9e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info: SKAPIG+5UTJ870cwhdatTddJvH53U9UAIZGWPhBFxOqV+p/Nw5qiK1HmioTqsrXOzTPbAaJ251G4TTXqw0SPmlIg9b0QJqDHQzABVXT7KDTtzXSYswpH0ro+2QQa8FMKQ8T8IGKiR3wT5o+mAb913m6pPWUOfQG/df1nhJFB6MLZLilelvy1Oc364KbEmkM2OUoaqfM4z2PrZXolFjRhpGx3MAatjwE6RLi+2ZvGH6g4+uhgn5Nfn3Sr2Tih5jyQ0jcKysmchUBoNW1w9rtG528kuCGxNanB8V2djAfxWILr4rWz99ub1HIoJKtKboPGJZXzk89MbFrQfRxSQuqYmYRBdKb3aMhNRKaWVZI9z+ey28sutCkoe6Czjd/PR8MvDOKUSrhUI43A+4mBflgPpoFBLJoQ/cMt7W2fQLPo9Z6SYbnyjbQPwMVhUla86bqHDWAjFn8HTwt963lMNndmyXMovFGNsjilGNAGT3F6uasKymeXSua4QmmqCzbw4nxpPucUO2fusOCAvMqNrsy4aPsfI8tbXUR0M2E37xQPkmt5gGLUhEq7GKfQzl71kgFxCE/+PkB5l4pIzEGauHx2XzcFtHF6wjzdZLUbzJ6ZTsL04K36u97HYWrZTzfnroHbgR3/uAIjrDnvSCdD07RkGsFOClSi0f9TwK7GfMWnd0RW7LLkT90DWDm8avoniHHKuDh17G8J2of28240M+jwVBq1w1KsAq+xWjiaUonb2pW8iptComrIT2okF0KupHBA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nIlm4bHQP9/mqDndBkT+cO2rvOWaZsVZ4xlfnmJEGuqN2OLJWfUI5gJiRT?=
 =?iso-8859-1?Q?wxHm5dGh/8+WICJUrbf1R4zj9JFmn1ilGyvU/n5E5ZD7ZdZJXA2J9Nwz6m?=
 =?iso-8859-1?Q?tN4ioaKtEDkesCy0ZYU9tbPVN8WObSTQMnwMjPcUkiVxi0hkNP2R/qvS2V?=
 =?iso-8859-1?Q?zD51cQql1V+XCD21Ucjjm+sCM1E6aB3CFFgnre4oD6SBC02jidYn1jE0X1?=
 =?iso-8859-1?Q?kIwM0tQ3FGC8IWqy77i8MXMSuDYFG361fxW2H/mnCPClRw/aDuXvQHjTMW?=
 =?iso-8859-1?Q?ccwyEOCvdQe1O/BAFUjM9RzgHSdSgIpTBGFZe8/iTXe6+2UKMZomJv6hrD?=
 =?iso-8859-1?Q?nn3ZvqmrVpdCjvFK/j0XFuq7kFsx3Yk4QjN76VJ7+AJkouzGi4iS0ifdwG?=
 =?iso-8859-1?Q?osgUuN6rC+oUO617Nz8WjDT/FKafIVyngy5CjFVNSbRliQ2O9sCnqbYxm3?=
 =?iso-8859-1?Q?Tj75epRlH/+9z34VN+EwGjbAFe8B8BeKabJwk59RS6RpHyv+QghX5YvbA7?=
 =?iso-8859-1?Q?Zi4OVYNki9mRICsYhqMuhulsKNJT1mqMkRFxmXiwNh3AXXtIEhBhqoln+P?=
 =?iso-8859-1?Q?FkXral4UcWalOM8hCmSgiZDlvOvph3rQca6aBNdMnqV9g4N7/AMbFvS4hf?=
 =?iso-8859-1?Q?6Wz++cgkeo9lFiK96z7QMFCkkA7lPiXfUGvIelWOTrDH05M4m1oi6xYE1G?=
 =?iso-8859-1?Q?IHjvEPaMZv4jdhj2LRIIvPz0qRoeOig6qoILHOVEnsUTKpp2MyPTiA5ELZ?=
 =?iso-8859-1?Q?Cl8BCDpwg6eXJnfJAB7f1AY8WjU3hBZEEkzWbDILHyfqUoLavFnLaP3Eqk?=
 =?iso-8859-1?Q?nrhTOlmK6bAYVgZa49d+P8MC1bEllEgJGL0UHeFYHLetx/q3Xd8r+MeYnU?=
 =?iso-8859-1?Q?wO6qoZWK4GG8YSL8Or9MSmss2+zhxEjyK4qP9Ix7RL10FkBk1xPHtmRWE2?=
 =?iso-8859-1?Q?blkftUxh/bNWJZz+X+pzwzvglgQUM5D6Qd7NQq1J9f0MLudD9AhDCYoSnY?=
 =?iso-8859-1?Q?WrF+Vld/vAF0bNHQ5kU+3w+kVrRODdPvpH5Q9flXBfFVOhhKBp8UrdCWuS?=
 =?iso-8859-1?Q?W531EjKB2Xcaagf4g8rn0vR43T/aYN+XR6L7CzEPIAPOg58M4RK3Zxt1AA?=
 =?iso-8859-1?Q?5H03tvtT7oyWTfXLWJtCAw5fsVGBDrRNwcjO9t5QHfxZqnjf3Yc5FHmsyF?=
 =?iso-8859-1?Q?ui30tbaqPL5/UdctKXTbGOihuKH9cC9xhcK0MtspM/pX+8T2yMY/f/5R/I?=
 =?iso-8859-1?Q?BcQGdekGGigXJWCDYfzr2VVNJRQKHc+EcMEuXvPPPpBfWSLEHqYmAZWteR?=
 =?iso-8859-1?Q?Z5gmUUvdIw6tEnmeh5eQ4Z3vN9LVUEzfaqvzYLAV1DYXfB5TJjd3dkZJBH?=
 =?iso-8859-1?Q?BBdpVKEKpu7MT3ee5+RkKSM1yiO/lTmFbTIhCHpH/StIxeAKyb3uz8uAJL?=
 =?iso-8859-1?Q?DvHBJONTKbsr0diIp2q/WfX/vhvP/eFmjc0p6q1fODWUPLsFdJg+o332WM?=
 =?iso-8859-1?Q?VJjBewrtBiVbt8kgjDli26WDvEbsBPp+8kNCOgUbTfsXv5CltfutkwzCOT?=
 =?iso-8859-1?Q?X7ak61QUt/HZN4DqC29VXo245fO9TDy1cOzuv0+k7YLnAQ5P5ctF5mYHJz?=
 =?iso-8859-1?Q?wkeF4IvNZ6eM4SwZ6RdG8R2F1mPVqU80eB34qx7uamfgKgA7Wi4Fv6Yzr4?=
 =?iso-8859-1?Q?LfB7tSQe/2xO1I5VzA/u6BpKcIRxwyl6j6ySBPUGer7X7AKnL+Z7VeM5kQ?=
 =?iso-8859-1?Q?NJbRvdmSiNuqZxiS0Yo+wPLKjy8KEwH1ARpXbWSSsYTPqYgNClthyClBdH?=
 =?iso-8859-1?Q?L/zrdSy/dA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pJDcIdylxobkY381U+uklVgnK/elriaSbaDAM8EDh+KiLLgX5Uq34AYsH80KamcouuLnQYvPpF44E6EvlHb52H3CjYlnFEcuFJij2qB9A/1ies0fd51VY4Jau2y/y9mibJ5JuOGLme2TaTDJ9wNaBXwcJJjvnP5qbZ74LNevSdGjZDgw4KV+I2KbGuO5K4vgOviWTwE53oFy8ndaBd+VZrFOsc19M8FA6mat4RWfz6fQraz9h+C6moJBwM/hQ2KoC26nI2/dAZl66zSZNSO2lwizBdxgSi7/Iw2+oVvds5SeEWjG6nm+SRMOIhjKq/s0wcuHOiSj00XGXkrIq2sodg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4522781-8f52-47f6-7970-08def76df9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:24.8757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhAlT6jJHgM/PAAVeXwI/EX0TQM5cmSSSTih5V/a6dl3DpdXmgQT4DRRamCL7bzug7B8Y0XUFiWfoG/7FeZV4bwekF1uuaFhIfr4Z3nrpoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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

The AST1030 reuses the AST2600 crypto engine, so it drives the same=0A=
scatter-gather transfers and supports the same ECB/CBC/CTR modes. Reuse=0A=
the crypto known-answer tests to cover it, registering the AST1030 with=0A=
the same modes and scatter-gather flag as the AST2600.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
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

