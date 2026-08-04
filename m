Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF285C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrANy-0004uZ-Sk; Tue, 04 Aug 2026 04:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANk-0004qb-RF; Tue, 04 Aug 2026 04:20:17 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wrANj-0007YS-8l; Tue, 04 Aug 2026 04:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCNbe99gmMdt5QetRDX/i6zYUIhQa2BS8CyC8EOpqDQyOzVxq8O+3l8M9u3dkMOdkOJ5zWuqLuuvMOq0joVycRYxLTXXHTAdEfvXAdzOxvkXtvZW/A49G1fgJHLLgeqtUDuY3vJQXqLYKJPcO3biIU6MSObZt83ijlRcxZ39wjIdaJqmYeU7vLfkAnaJwRQQ7SJrSECkfhKHANQ1AfgAEaR4FjeC04Pcf7KXTlA7JC1Te9F6zcNhrqU2KvEfTXpQLVCwrYzXf+9Twt7D6UTbR0RB7ssrjhUnQuU9ZV+Mzwp0MKOtN/UWxHby+0xwk++Du+P3NM3ZtvCTKKQ7gw8uUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM6EqRc5iAw9TXpVSZ1yyJzu1/dlmZUcC6UyPdxABUI=;
 b=xToSDys06rItj9vkRFXLN578BbRowISrJ8g9M3ciqG7mzAH5Gxg3L1Ox6e+fDwH6ZZ8hfOLxq8CXqUgL5mov7U7yued7HmKEfxMoRs+oeTLDcCwPSMpHYK4+6mBN6L/ud4RSf6bKaIJDcGZu8A01jnkTyfbIRahjQJ9/2CkKOhTF0WEoEUp22efJic1fO3CodMhk2h82RaXP8jUcT/Rx9eKJh+NWad+dFFnb7viIA4QFRKOiONjLx9clvYIvJrfE/PzM7cwMpitBanfQji88GXTIwqMHXeNFoxu7qQY0j1M5UWvDrD8oRBA6yktNxt0cwt5hN+MhjwpqXIJOPborSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM6EqRc5iAw9TXpVSZ1yyJzu1/dlmZUcC6UyPdxABUI=;
 b=UlsR1V73mAIbuGOgGZAIx5UlpkJaSR8T1eD5pQY/mujJyw2lZ31Ljq45Xbyol2LHRFa57tW+gqX77SFQgITB6MejhDgfK5xo8R1pQY4cBm7ADpVHv0bPCAEjMXuaVU2UnjI1NjILQy3cMRGiKeRtLVoVrlYTy8T91o+CsyMEddzzvtkLjWHqCMW16rWrY4tBO6PylGNG5W89FeKJpT00tvbh2ZxbE33gDmjH2bT7XdDKUShlXAIDRcYqgqBxEbruN/WopjPFSvKbHcL2CK6ojJqYAowes5HmYIAK+POptoEeaT86Y4oPMbszGznRSDx2X2erc4u6X1ZVJK+taV6zZw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by JH0PR06MB7014.apcprd06.prod.outlook.com (2603:1096:990:71::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 08:20:04 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:20:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 6/8] tests/functional/arm/test_aspeed_ast2500_sdk: Update
 ASPEED SDK v11.03
Thread-Topic: [PATCH v1 6/8] tests/functional/arm/test_aspeed_ast2500_sdk:
 Update ASPEED SDK v11.03
Thread-Index: AQHdI+oNObr8wPrkVEuRg0qh/U486A==
Date: Tue, 4 Aug 2026 08:20:03 +0000
Message-ID: <20260804081955.1563537-7-jamin_lin@aspeedtech.com>
References: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260804081955.1563537-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|JH0PR06MB7014:EE_
x-ms-office365-filtering-correlation-id: 0b5a166a-7573-4d79-2b77-08def2012f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ch7S8RLkcToYClzODOwN7moC7880CeClEpM7QyzaIjIGUrx4+g7Pgez+zFJfipqxgHgIXD/v6JeV56XeGezc9T6ET0GzcYZ2177OnzIO1ATtDPXSlkDxNFOSpfq8NJrBxCTqrW4fViLO3Iv+rkVvGbKr6cTD3jLIlLiOnCtvsZTUDDKTFVa0xrWFa1cSEiIZRSGXNUQBL4n6bLLm8lsIE17wKp6UXl07sGDHGXSwMAMLUkgSWNTgZ784xOlQkcEfJku/p9DpVM618wpM2JkprlkXgLB2Kt6EdkwpVFUI9qpxJdxLP0T4YorlvqyLNizjpteCYZxz+9Mcmw/PMQkiuUZzD88pOL952iGfVQePAprro7lmUpkeVCAfVjax1+Q08q/Qbtl6aCnWPtsiK+gDAVJXe0vjxht8ShNaaCA5wCkYLZfJmFIzaeHW2GnimK14iZVp2wOiyjZ5ha+3WoQu8f4VJjPt2wc5JB003HCDLxXHV2nA4o8ugDqF3HTKl7ycxYxF0zxOWczBoSUdO2RUPq/51WC9eCs5FISZRTg/OGDwjk6PteQ1b523Yoq22pqJeaHiuG/VBHCAkaDu/jn/6Cm9LB0GUENMAOmAF57z1xvPkkrTuSvS1r2dbyYxVc3QRtqUkon91SPr5NdUaVEEToi1g4kz1uSHP7JbhmuKYlk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z+cUFx4C5vq4P/UXF991J2xVyn+apQYF8qUUWIazJe/90W00DDtwwirFXV?=
 =?iso-8859-1?Q?QUhHX/bxq67dOukKiFW7ZMNdCneD2zlxAuo0CquYNCKeBha38Az0EOifng?=
 =?iso-8859-1?Q?GcmUCvMC4O+fehsMUzo8fn2UusMQuw46MDJZExRnbVCBm87I4gFerNP9gy?=
 =?iso-8859-1?Q?+e273Mgt7CKfXHetnZP90qkse0+u2niznPJGHmZszybjJbl/SMFSa4rZTX?=
 =?iso-8859-1?Q?ciw+bhpJkCeQvpu2lflu8iha1JJqf7CvaM/rtGCADxOyyrt+/3LkRBCHHh?=
 =?iso-8859-1?Q?1MlZOTt/Y8IumAhSDgCY5vaQ3If0VIxfwo28unGgxxGcC8iGp56XC0PoNX?=
 =?iso-8859-1?Q?0qjLC7XwYZMwb5YAEufvGk622/IBcJB3Ib3t3oqM0B8l1UMlW/MVAhql2h?=
 =?iso-8859-1?Q?z2g0sKKPaEr9qG78aDtoUEXQjD15xRRP4zQxtQUAiXIauRUj6Zchq2Zxlg?=
 =?iso-8859-1?Q?+hWGlnStQsUZL4lk1MgHje/NtORT8XS73WWSYVp/7Fq/441g1j3MvdRhW8?=
 =?iso-8859-1?Q?lMZaij52r/83hYuZ2hsEaBRyFJa6DB5IZwYz0o9BZo0gSkxoFBNWVL8DIQ?=
 =?iso-8859-1?Q?QgJZB/tiJ9thEZHdGbkjSI6aXH3tsTekeE0xrpUuw771/OEqvmZNyymoIA?=
 =?iso-8859-1?Q?HU4lC9PmRRylj8XctFrQhr1gq7VVoyvLDL7bdFgyj02Dv6aqzVWrM5kSH8?=
 =?iso-8859-1?Q?CNE7LJYjhWITyIKSRBg6Agi5GIMT5pyOob18kWc0JF9ftyv3hYiGQeTdGA?=
 =?iso-8859-1?Q?w0JhXCBPIsaspjRpB1Nbom254SyCCzIGtqB6CtAH9AApTbGbhEgWSp6BEC?=
 =?iso-8859-1?Q?0LBeVNQc9F23mnWzsjBLEeVKr4RB/o6WovWZZSBoB6KJRCbjisxKnLwzfN?=
 =?iso-8859-1?Q?BwTH/xB39lsye11gdET6R5ty5x2EAcU34dOxbaIXhidQaRJ+VKRhzVKMUn?=
 =?iso-8859-1?Q?EKVCM+L96AqT7M8Fp6mnieF2L4QZe4M7Y+Mz4nacPZH1Qs+51qEAUPE25I?=
 =?iso-8859-1?Q?nt/umCD7Oysb7blS/xRTjo51yOnfIAF3uy87QHGO+StZPJX8yXZ5As+eYk?=
 =?iso-8859-1?Q?NshPMgkrBfBz++/9fvRHGLHk7AISvzsCj4HQilY7ct4TIanbauY4ULipUu?=
 =?iso-8859-1?Q?oW1KI7MS5AWUF/jrke0EGA5SI+5erelOp0cKlRfgRqTG9Jt7uEhVy/tjKi?=
 =?iso-8859-1?Q?6HM7h0Ga9fbbgvNcxXyBEs4m9xlSPqFInt0cDvzqCQfbuW9+ccq29qo6ty?=
 =?iso-8859-1?Q?OfRAnuB5nseKNJKM/Z9ILHC8tCpHr7iIhYw/hEsYLwfT0FcTkiLfKHiy5H?=
 =?iso-8859-1?Q?lggG+y36NR8ThkwRwqhuk6vkNTmNj/LQ9enlPqrJYAnoEbpGHhehpdoe20?=
 =?iso-8859-1?Q?pyXdLs+eY8u2rmKgLZXoQRpXAhfNrKMkeAn5D+0BhFOC4HY6+dUmw6lOPP?=
 =?iso-8859-1?Q?WnlKvOLhBF233/hN15N71mIE9gpYlxySwZC0tK1IlTBgFs4hvq6kyVHOaS?=
 =?iso-8859-1?Q?wt35noCieNf92nUxc5opB23LO6LCShC/+qLVAP7ZdJ5/33SMxOjbjdByOz?=
 =?iso-8859-1?Q?xUYoyrxoKcDUSL25nUzFsr+/UgOs2vaq8idTB/dK3ZWiFJe8UhOZAvfqF1?=
 =?iso-8859-1?Q?t1TVvbJqpNMhPecZaoFcPBC163I9buXdi/5SReyiV8lMG3gOuZACZB0OYk?=
 =?iso-8859-1?Q?DbTOOW0oFjVrpH6cpVGhGPC/S9HS7YJyEUb/uIRK0s9NETqtilJnIS7VgB?=
 =?iso-8859-1?Q?gYAqXTb7jKap8+eU8WjhfelGgK1X/MJB8GwT7eP7R3X+wjE66UhSz6NYfn?=
 =?iso-8859-1?Q?KKor4BQAgg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A/BPiPMI0QWTZsNjMQ/sJHu/2FWk8UaQe+kUMiBWQmdSzhMpSmYelUgpqFL0mvYGYJNa/t8nWLvB5MUOtkP5OG9T+nCRCAuYKKTv85cM/PBGnnDpwsq24UyCXBXgqh31l+lMBHsXdJmS0O7uuDbhmzFDZU9pz6/VTeC3sz24NfTJNC2grtUUfEOhEQF9KEhf09B5av3CT7HCT2AT++Ieo9wwiasKfEifTDuYm8p6ofMGnpQXMIETbG077AzKFth7j454UnmNdszR16hiP0+Y8Uz0NlqLT13zQy8qlXssU5iQv+qaUZ2dFmUhnum2ldktxcxF/khZnOwfBSD71osX0g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5a166a-7573-4d79-2b77-08def2012f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 08:20:03.9716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PsCZ4FWE4/oEOCQeYQaoU3vrbr7UKr4ptFcp2JQaXh2L0YyMaC8g1SOvFatn2TiHbQRVv2KaQrvelNns+EYC0T+BmrtYjIPaCPjHQklzeI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7014
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2500_sdk.py     | 8 ++++----=0A=
 tests/functional/arm/test_aspeed_ast2500_sdk_515.py | 8 ++++----=0A=
 2 files changed, 8 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2500_sdk.py=0A=
index 6ab498b3ff..95df32b84f 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2500_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk.py=0A=
@@ -10,14 +10,14 @@=0A=
 =0A=
 class AST2500Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1101_AST2500 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2500-default-obmc.tar.gz',=0A=
-        '3faa1188198da2216837be4b53861c483a58c3ad63784089720bf8421e157da1'=
)=0A=
+    ASSET_SDK_V1103_AST2500 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2500-default-obmc.tar.gz',=0A=
+        '8e20cafddca04d73b799918d6f35b08c83c9f024e223a317b0ad71b97b84842f'=
)=0A=
 =0A=
     def test_arm_ast2500_evb_sdk(self):=0A=
         self.set_machine('ast2500-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2500)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2500)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2500-default", "image-bmc"))=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py b/tests/fu=
nctional/arm/test_aspeed_ast2500_sdk_515.py=0A=
index 8d39dc65da..516e96e52d 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py=0A=
@@ -10,14 +10,14 @@=0A=
 =0A=
 class AST2500Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1101_AST2500_515 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2500-default-515-obmc.tar.gz',=0A=
-        'b848ff620d2e9c83e2fb4736b4d1c39b82fdb041058cd42be42c3b177bf38eb9'=
)=0A=
+    ASSET_SDK_V1103_AST2500_515 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
3/ast2500-default-515-obmc.tar.gz',=0A=
+        'f17d3b0a5157bcf73c21c4981f838ea0b76c6406cc4a6409267d57d61758ebb6'=
)=0A=
 =0A=
     def test_arm_ast2500_evb_sdk_515(self):=0A=
         self.set_machine('ast2500-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1101_AST2500_515)=0A=
+        self.archive_extract(self.ASSET_SDK_V1103_AST2500_515)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2500-default-515", "image-bmc"))=0A=
-- =0A=
2.43.0=0A=

