Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95EEC43458
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjqNT-00038G-My; Tue, 14 Jul 2026 23:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNJ-00035q-FK; Tue, 14 Jul 2026 23:33:34 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjqNH-0000nz-VL; Tue, 14 Jul 2026 23:33:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuz+HB/NDBkgx8wjT1TAXilWVh6bhJOq6vQ7DTQMkRN6loOQ34wG1jQY58igpzFpOAIFGk+EYfE/BoDD4xaMEmyLKsgVWG9CFB5XvNrg8wVPVkX2tQ5UILG2zhUnS4uA7QrGioLaYcTiuC5ypRpewKZPTAs+eGw3lYAPrx5FbGAwVW4SdYZk+yTbSgWtzrkYWthf7VvcB8GcXOLcxZ+O4WiJ/vQ/lQCBEZ25EelF+O1AyyMXC/48yY0PRMkTVOG1Y9RDNwxKti27vwUk0QfeUlVjVjw25T0dM0dWsXaaA2sT0fSsNse7h7Er56FD3NFNlJrhSW+mU0SRfdxioAqd3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vYymTcfbT4ZnzdcQ6MVVHEzqJaTpni97oWsQ5UIO/Q=;
 b=e6S8Q25B6mWOwNGrcKRLLmaZOXnMb4ORCjyUppKkPh2eu3xPsnALwAqLMh8E2VJV7BwnpjmAcIhbnTajwPWkL0yHUIb65UNolh8M2Ah98gyXzozio4ANhOoj2qOLt622J1GPK7SnC0iyAZWBxztuTyJ4s+VGY7HVuiI8wgLEDx4/7onrK9q10QrT+zyPOPDgu+4OKU6SWCfUiT/jCLzQX2Lea3enLNzy2u/QQPiqebYbuh5regRs6gIyxqaP/OTU9y1G6zsHvvJzZzdepUPU9j64e3qdvh1GzKcrL1FOPjaHyzJMBZEDRb6o0GGi4GMsnfXcPwIna5YRAI/wJh5QCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vYymTcfbT4ZnzdcQ6MVVHEzqJaTpni97oWsQ5UIO/Q=;
 b=UcbD7O86Sy866kd0KJ0qTLiBAojBexBVnmW+KDrAkCkCOMCTgIJa9cEmXnD/Xxt1kGH6tzvNcSyRbjGdQqHLPadQSlNzSFZbfd34R3m0hDcdZSCxXgKKGO/2qViPHI9AqcACjgt+CQeYm7MXrGyRITNJ5k+rnw8+yZhArJ/Lv+FnQJvxzGZtDZHiWd6F3tDCxb2AneH9oamM+T5GBsbcw199f4reEose80uyGZ8v43JQpcIMbmcbs1SkjP4Z8RkRFTA/6YqPf2b5dXzum2DYU+OMnyfWKJkqtaPTvs6at0U0sSLVijr3oUzzHg5cMNd1O/1MIgVALCAc22RUD1xWWQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 03:33:22 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 03:33:22 +0000
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
Subject: [PATCH v2 06/17] tests/qtest/aspeed-hace: Test the crypto command on
 the AST1030
Thread-Topic: [PATCH v2 06/17] tests/qtest/aspeed-hace: Test the crypto
 command on the AST1030
Thread-Index: AQHdFAqvRYlqaOyO6UKBfdJR8BjxJg==
Date: Wed, 15 Jul 2026 03:33:22 +0000
Message-ID: <20260715033311.1648424-7-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8508ff3b-5101-4dd0-b506-08dee221d246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: FH1dIWvVAypJZZOhaw9JnRHf6t8aJexEvwh4yDWg0ZNTFoF6Ebrv7roYKUVknSI530PrJMdXNQWfX018BG/2Aq35/3sZbZEhwz5MliOf7mIJJkTCbyJK0/0JpNkCsGlTAbXv84GtF+ULC44Jq8YwBOHlnNMaptUC62IEz9QglkexsG5eXda24I668PECPaQxAfQ97lCgKePODiwVQEmaJt6B6PuEb7l3vguaFsUzRhQ8xkQ03hKvz+te6sPStqChyq3yj3BoFFXdgcnXBmbNBt9/4lW66JAw5tcDIOMFhLSrqHhJJEUlPHM4BR3WHqehfEYSmHMaKLwNsf2ko0E7Jbl02oq3IZm963QQ0YlyH2oQrS7NuuMkrugHp531tOxbYX7kL7or/T2MsoY+G+PxX6EQN/Zc4PssleNp1JP1hh6bw2/n+uCq4cqg0g931VdVqO2BV2OpfZNu/u3PlRolkwreZZc6AHsJqM6HyA7psB5yjW6xvezvmFk0EsPptZF+cZYZ8YpYeY8Y86Tg008dkqe/vYyDKSqTgJGm66VeVQS5mW3wMx8M8mexFuE7HBoaT/+4JeQBB1F/a0PzQ2b5mAdu0JiK8Dj2VXpy+T/oSh7PtnXn1wpAWKKVhGrRwVTNnaPPQuBM5k4yh+cjtYDC/57IYIMyW9Bluxjemks3s8MRanFGgZ+/9b9DCActYdafm0VdffiPwX2HlJ2Zxai8aJJQZlvXXjm9q11FK38Dq04QdVxBBw64GvSXjrrZ/kp/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oLGSeI+26Izq8ZV6kxsxVGooBBNG/0pqmRmNJcVAQXFqIZmxr2D7Hefq9S?=
 =?iso-8859-1?Q?4EF3tK2UGza9gmhL6xPKwjgKnm5DmvaCmBcdt0u9jcSLrjis4sq9Wdxr9m?=
 =?iso-8859-1?Q?toe78djQohi1i7SGJKkSzFI14wA80Dxv5QI4WWCixn6lHbvVffXFNo1GD5?=
 =?iso-8859-1?Q?K5IBThBE9WpdfRtswRVxlLinLlJvbo/Ohvxa1G6NLBbAt/mpF2vTHeQ4Aq?=
 =?iso-8859-1?Q?MVaLUiKZtiwr4xhWYwMXvg/DaCRX0Vk5YpCo04zHJEh3u0YMD3W+I1gcig?=
 =?iso-8859-1?Q?IFPNarcmzYvgAde7F2q73F6eO37kJfaci5QN1trjWrNa5+PnMdBaUhF7nd?=
 =?iso-8859-1?Q?zLK5+QKgiXkhCJN4JkySAcSFg+PgbTnPBzoWGUCrOdiBiEV0dCJoiG0lKO?=
 =?iso-8859-1?Q?V9LzO2H+s2tD6v2dk6Zs4SMbO1F1fUUKjiRh8pBkkxVf8qGl8orV3NDMJZ?=
 =?iso-8859-1?Q?yhMIeiwiBPuLppkRoXvHn6wPoRwmPWIMhUM/Fu1Jhy7t8NzOcrblBPVpir?=
 =?iso-8859-1?Q?jjBJfc1ph7Oz1Jg4YRfO2FCmcz6v/vvz9PfUF0aiEXngrFyPGQ4isKh4b5?=
 =?iso-8859-1?Q?76OjavF8CAuOVVTRLe0Q3BGnc+8+4SU/Vi6C0HF5J6v1PWt+jmtE61oAtP?=
 =?iso-8859-1?Q?Q0hV0r2Qc05ui2XkKRkKofsSNdNy/VBqi1cjxepUbFzVRFY6gG+XPb7JYl?=
 =?iso-8859-1?Q?aK2gEsiwNi0ITlOzSJvlSBcXLKWVJtpnlf2AXD9UcnBXNt75rtirwiPFHq?=
 =?iso-8859-1?Q?uGrpEx8pbz9zl0gbhX5lOAqcHGNCwVuRtIUsmpUiChDQhdeJ4E3RxPATEV?=
 =?iso-8859-1?Q?fmjjc4p+BZG08gorp/dsQt1dXyvPOV+1xC6Q5bLMbUcufoTuan8b7K//kd?=
 =?iso-8859-1?Q?o6uJE2zEqreYw83TJrLo0O+4JbTzCpRSt1GJUAJyTOOksT5I0uYsczTcNl?=
 =?iso-8859-1?Q?UrxI6cAwD9Ad9S4uK65NqZSp0xaxKm/A7xfTc30fGL2NGx9rPQamjzmBxP?=
 =?iso-8859-1?Q?x4ZpLUusFXztTsRTskJjb738NRGBSO0nFi0mjI6vO1zAKZwwEoyztl7mH3?=
 =?iso-8859-1?Q?yxqDKOliZfW/u91uIbtuRWCn60TctrESpTEoZ8cQfVy7CMIXzsfpCNRlGC?=
 =?iso-8859-1?Q?/tCKmkLHg3RZK112kkqNIA3oKa+fN1mDDvP4iWG6hHO52vTZY5ftC8MWQS?=
 =?iso-8859-1?Q?QLDVlSBslo2kY7vqc/cRTFkk+5b1NDRkVk8oky4I1oDzs2Z8Oab+tk+l5A?=
 =?iso-8859-1?Q?hf3VfQqY7rpl39eRVAloutmkvPaizwhpo31bUskhwh2C451nD7cMuDv7BU?=
 =?iso-8859-1?Q?UMrXG37VbgvNm/KIb1Q7TE6lKaLItxg/5f+OtQh2waMMkPRKbz7oIczE1g?=
 =?iso-8859-1?Q?xB0TX2UjeVw1KdtcXrMe6e1sITcGNk6wskg2HPU/tBsPNcF4af54JAkOY7?=
 =?iso-8859-1?Q?KkTN5g5uEisER3vDevpxICdjSvjMjGsvkfcnG/zzh1SF3JAn4aZ5JDhv8G?=
 =?iso-8859-1?Q?t7j94Wi2pjFft1wfME/9ueP00UdoVcQDpzudV4doVh4W4m+QH/W1fHnv8u?=
 =?iso-8859-1?Q?Cp/FyrBxaTDdGORaujCvG1rgk/pIdLmnmrefGBa9eSaZRusYsx18erIWKX?=
 =?iso-8859-1?Q?ISIXbaEdfjelWC4ACw2mRjqZIRnXr0P7eaZqLKV9UrhtfCSxA4NX83zsoK?=
 =?iso-8859-1?Q?9AWlrFwnism5XoO7oVii+5s7Oxvejel8O2NBudADpgW4VaiFGd18jMB/1w?=
 =?iso-8859-1?Q?53+PALMZLoLw4UotrKVdjfLbmJtZOXcRXVlVY6ATiEHRo7+9EsnyH0JtIW?=
 =?iso-8859-1?Q?fU+uzpXpBw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J41MMtTc0s8quAkuku0rc7mYr+BPpSyvBB3rnR07vY8+sE36VKDDiALv/BRmBopZHq43gJJLOm2yjd7Hm6DFMKfJVol/3WDetijcLqcJ+1C2ZVw2p39qSZorxg9pWV7DU10lPH+z4ieAV6+vD/CUkIymWolUCMau+R/UxLuk1CgqMbId4uemorEvVcHtmKvQqB9VLbjmr00FtJyVPO/ABP/SaIFKPjFMxSLSiexLJUch6ikHIUyOA6JwL7eb+xI0LC4qaDzs3qND+OUmASTMB7V4E+f6qkP9AyoOdp3EUU345IpIVXMwLGqUwZq3UvJ4nZ2R6JBOLFt1X5Nj/luDLA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8508ff3b-5101-4dd0-b506-08dee221d246
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 03:33:22.1836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9nYNu0K+31I/YTEUDzOz258RXtaCTGu3nSUfDgzZ8Rh4j/Xu5W8fwqJQps7Ab3j2gOhbxEI6JJIIxOaFxFepmwzEAvyc65GOUMOBgofbeo=
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

