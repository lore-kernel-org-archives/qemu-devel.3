Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DCCC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtct7-0003jf-DD; Mon, 10 Aug 2026 23:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct5-0003i8-9m; Mon, 10 Aug 2026 23:10:47 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct3-0004JO-O6; Mon, 10 Aug 2026 23:10:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKBAnwJTGFzF7WMExpd3GYVPHSQkctvOOZl4QWqQ4hOuRRa8CaIykfMw6kwtFs35F4E5WhFPhNQscC1dFvlASldt0z8Wh9sFKw13DQ5cROx5jmroLo1B8M/JGf8UoPhTu+BWfgaIi4fzcfK/wEHSx4cyJzkh/8NO1SFc+EKpfvLuRurZfDJ8SAzL3c+4+oj21fKobxpYEC8pot3aQDPiQ1jugCkjdAEtKdtnWa8lwCFOqPPhMKaJ8iZ/eG9yjR6U4XCSUYEDPhatzR9vBnGDRgFf483mQ2oPZEnK34g+/htC0zRQJmxJoXZ0pEmQFydYIUIb2eFczj3FsOn8FsYfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCRWVXpbqDvkmt1QnoVN0TR8TkhAdg9QWz7Htkp3Zos=;
 b=vDIxjzWEdF38RezW2+rbJ+oPt8wL9d0S63eizDY+DJJOe02xO/pz5+QqUocdBDzGfoy1gLqtyfwqkqNFPiS5hyZQyXXQurij3nPOe5leYiJwws6tYSq8tTshvxo+wbc4MmkfIp9kVJktS96uP33HbMLm+HVOtHgyUPAC0MeHbGqqwHhDchfS5sBP7wIHD8PNb65u7xVTExMizCqt1wCiXFhdlUbSdnxA4KqvjW5IV+XDEaM2/VJ/LiEskKPOfgJUBHPt07W/i31XVFHn1qbAg31fZ2tmV2gTEzBTwvmC+IAGPnmqjdwyHz3iwvBraU6C1pol2DZ23gNRkAa5PsGC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCRWVXpbqDvkmt1QnoVN0TR8TkhAdg9QWz7Htkp3Zos=;
 b=b1lUP60Utu9EpwsL5sUNnupUbnmbz6lOUPsSlAzLrP3XJo5w4/AUtoGwWEkVii44zfDTDpqIWEFaS5rA0dDA6ixYNDQMyv1Gc4v+CUthHCOi5Fqxj6vE2TIFexByeNkxkVc8CmCsuIkHyG3UwKkwz+nZ7ieuxcdVcRihsfgjtvy1foi2uG7R3p7S/N8oSf2evzceoFaf2LiU0lovFIfnmCXboEevAqjVnG591Yh2tIvxfpCx1Okra2DospZorYVFYS84dZSrc/2cM61Xxba3cIcZgyH688uRxB5/trellOadHRMqHe6dcrgjAUiRFd6vXjoLB+Y91ghnHYq90xFLEA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:35 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:35 +0000
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
Subject: [PATCH v3 06/16] tests/qtest/aspeed-hace: Test the crypto command on
 the AST1030
Thread-Topic: [PATCH v3 06/16] tests/qtest/aspeed-hace: Test the crypto
 command on the AST1030
Thread-Index: AQHdKT75TCUTpWBRFUmhTHK6DoFzNw==
Date: Tue, 11 Aug 2026 03:10:34 +0000
Message-ID: <20260811031025.2784489-7-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: 82a1321c-8ff4-41e2-f510-08def7561c72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: gLrgrixFrXnqTDtlsZBLR3BFjnSK4L+Hz7skbXOV9ig1LWNDMFSqE3oCf5g5C4xC7GPMzsG+qjpKWXOoP5lmAj1uJ+rsMcm7+iJE8rfTA4XK2m5Zf1APmLNaZO4L/1np794LPVHDNhBRS0LTPMywILPv5z1xOLb6wiCuq99aZaY5LVZT3UJpR1B1IJRUbKvN7HNX0hLOI9xSwmx6ean4+btzMsK0TeD0tRlP4f9q/AtxcuY+HouDoXaWYdWHxBerM/Uic+dQxua8bVM+x8i9yMn3wCnO3a24ROEuVKULigr7aFeJLIKdqZvr8TLbp/KgfTjJhsq+3/7Ku79TklF5tpS8o0f1HIU72q6K4kvyLjFWu671MsExiuOWe8KjncyGE/+uNRagfqML4QYhEeQuCRQR4Er9Z7ts1vEG/wrj4zrirCy4FdwvrZRBL3KYoyMfBl3+0uhPDQtkHr2Vx40IVmWXx9nUV8ruvMOlJo9Tmwg04gZygTR5qED8Oc8TdXG6oW11ZgnyfdGLNJZipU+0lowiIrlyfvRe27q8o8gBslPvzIe6zk9RYXPpqFywVK5mK8vvh8t4FgxsaC6zlKhgkYtEFJTuQiL1n4BigRBESVwSyjZ/bwNfzZ8t5ew3kuzyb24nNBuc1EC9inxP+Ik9+FGL+F5pdOF5qaqO8gJp+Gn9TcPtcurHiUV57g+OVTSJLllMIrGKpOUqwzyXI4xCS41rS61R/v0gPnu2YVCwwS5A11V9CMFYqOG2PO4zxQik
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JFGKFyWq/v37qcplzTu39AVNtTOoy0XrY/HfdLe3LK0QKc5GvH/j2IKAeS?=
 =?iso-8859-1?Q?QETEoMJ9IeyGeJIgHSCSDsUgZ37L4VJp+O1CPMtEsqrECnVDZAvJbSPNrI?=
 =?iso-8859-1?Q?gaCQJ9OuJtUjW81suZfW0etTD7R8NEwXTg1Bp+iDJXwDKPL+9CkeOnb4Uw?=
 =?iso-8859-1?Q?8obyAmJe0XbPvvRPINqFKVoj6g0mRMjDukAIFFE+pN2HLi8uds4kHAimJH?=
 =?iso-8859-1?Q?7IaHLh22TNmGx5w+HWj76z/excdReZTJ7CplHq7brHS5/msSMRPJlsrzbP?=
 =?iso-8859-1?Q?JULe4uY3TtuziL2qwo+dTkW26YD1Mf1iCp0GpRQneMemfpFlIrRJKdLvQ1?=
 =?iso-8859-1?Q?7MBIqM7E9sEivXslBgkkVOl7kULVMeMRIdEKyadjxuM0Pl/CWUTrNpa/3I?=
 =?iso-8859-1?Q?4JrXMc/k9E+h/xIU8F6HGyPiQEQPA4YJgcZf9IJFjcD1fiqzASGo+qEkTf?=
 =?iso-8859-1?Q?XNuvsm5+n5AoF38kFVf2LRIOMzsTiSx6ejJwkMU91uKeVqoCdLMtigNASY?=
 =?iso-8859-1?Q?DpY4eo791aBRavdR3WrWf9HTIQiFNbolY5sIt5O2RpyS3IZf6U+Sk8VK1x?=
 =?iso-8859-1?Q?ldXW4X+uhS/9LldZWDgVK9ELbCt/D8XKoDCLvNRpYT36f2I8GKY3gW5TYz?=
 =?iso-8859-1?Q?nI45ncJYiNhV6Vh5eR7LToxNYfOPSwooGGpoUedB0PLc8cLRKq85vK2Vej?=
 =?iso-8859-1?Q?trlrMwQ3g1VC7de3M8n6GTbsDVOq97Vz3IR0yf1fnn/8luUBCFSlQmgYrA?=
 =?iso-8859-1?Q?O5dgwQD8FJ1xkvjIz5qlN6qgFgCWyAxIzz7+ilDntpoSF1FCwN9uTR9XGF?=
 =?iso-8859-1?Q?OG/giGe9IY4RiqE+bwB5sXmwLoQwvFOHI++bBR/BcjXBXi0+pi4gSINHnK?=
 =?iso-8859-1?Q?pHsocZXHe0YLtDwyINEsyzkqmXgWlkX7dtjXHEiv6VpcROs9RC29A4kW72?=
 =?iso-8859-1?Q?Pw4xJaBWdDQeX8gCLVHNMHfFBhuS4NANxSOB+vENi+5gdTSpDx1yBFe2sd?=
 =?iso-8859-1?Q?Wf/OqYuxN9L/fqy6pyTAbZD4EwvwvXZ6QhTBqw7ozh1o2Ewq9JtYGfj24N?=
 =?iso-8859-1?Q?KhZ/tS+PTCt0q70eazSPll60pVEUEZulyltmvSgrjpp/WUt7rOvT/+rwQ1?=
 =?iso-8859-1?Q?pf98AZ72bwlw+SunZO1DBiZnpFklDQLeLeKGzgb70JIItG7gMG1GEPqepu?=
 =?iso-8859-1?Q?p2dMmLzbjA7pXjKYvDNBrSDQal9QyAqDCBaESJFGBgfROE5rCXanNd0dr+?=
 =?iso-8859-1?Q?Rms/6fquvoEqg8t+N+is1aaNEhYgsz4YzDLX97FDghLwByBJq6AHzvmeJy?=
 =?iso-8859-1?Q?7drGQ3XZQ+JXcEnNIm2kqoRaM6ruukyZGSMgc8tpYY/objCCrEVdJcwiA6?=
 =?iso-8859-1?Q?G8OpISdm4vPHUzarqaQzhQt1IUts43niFPnJqAPmuXtedBUmdAEhIRX86V?=
 =?iso-8859-1?Q?zUY8tQt7Ic1bOmk8CS6Vrt9TDGNfxSGvA9XR6mboZrFBQFJ5QrSaVywfrr?=
 =?iso-8859-1?Q?+eoDNBiOUPi+PLRIJ5i7IXEOTWohzoo9B4dCbVEX/2ZPCKTCXzZbfgyw0n?=
 =?iso-8859-1?Q?xpWQjWJ8MSLmiU4VW4ogAxU+IDE+727dp7uk6fKmWyYEdJdHFbXT3aoaHD?=
 =?iso-8859-1?Q?Ixh9vkEVgtvIGkv011Y0uLrJqXhz6+iRwi59jLd0Fy2VXriokMxKtGrYSp?=
 =?iso-8859-1?Q?xdw+9xIcwd8JB5Md/lXR8+uvgUCCQypfCOwDFx3FQrf2avL1hl/5LmJV8Z?=
 =?iso-8859-1?Q?He1QjMjgmpdGDAVeW8jN/TVwnTDpxZiiXxY+oQWRH4z8WTOXGQfJ3jY9Fc?=
 =?iso-8859-1?Q?97f3RpxVnQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PFz649JDx1beYFfnwEYBSMhnosenVgS+50dl7+/XQXEJ+HsTQfqxBq8QH0twNqX19fEHglx6hGjBZrnf4xlq2oQq0MYcJtUwCE4ysFXr/j4BXiJwufyO+8Bv+T03bBYgxdNM5zuCwePNpywNrM4nG9UOXsJ9wwiYPJf7tZJDcNHsTIkCoMUlhe5lPv21PfLLr+O0T5RkOOX9GTqU+Kwtfw32JbGqoKlwmmoqrUH7z3FnYKxZpmpi5gm1nyGYxH4cJL+xASDj37wcbDx59gB8YQC8pJjUKJiPIs81o8lfKCk746p7LSdtNP2mOhkc4FGY5Tb+retkcPXr2WFawokOHQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a1321c-8ff4-41e2-f510-08def7561c72
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:34.8658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBBRQi1Uq0vOP2e0aua8/KJonKivrmWWS95N7q3emT7F+JwhtlrNWI6YJjjSVxCeLjf/aoiCUEeomFtOENSU09augDXLaNH1WnCJ5Ez01WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

