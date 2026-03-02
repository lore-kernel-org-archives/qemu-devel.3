Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86762C624C6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEp-0000NU-L2; Mon, 02 Mar 2026 04:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEg-0000J7-EX; Mon, 02 Mar 2026 04:06:44 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEe-0005WZ-QK; Mon, 02 Mar 2026 04:06:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlSMJXAQ+TSm9qve5antOUZBisHpNpiTMhmj3zifhlIBWKUlZMSX/RwRrw5Q8UqgDIG9PZq0Za3PIkmnPyuNoXOGxoDAK6yld/syZfT42PV8Mvlflzirn9HCQhP/Br/7TjD1O0VWk34VSfeZztZoE93eG/OzOQlVXVUyPiQCbDZ/P32mh0GAIhZGiOp8E/DS6xRbDFqGoMDrzNra7WmpaY5nq08Kd0+aHMBp05G8jiMAU2KKjfVGYus3r14cn992ON1uFYUcW90M2W54PpyAYMCzgeNWwJzJ/Ijh8OaIQeIRGZFjpIUJ/RaXJHDyNhCB7mzbixYoweoVzT6cBc697A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTJvJ+wOxOBqUQ9X6N40AJPmKD3JWmKlvDU9E14Yr84=;
 b=vatWh+rmo714gqEWOZu7HO+DV/heRdbakba1dLne+HuBhEtq2SiLDl6A8H9dx8oj9Re/MEWqjphsQys6JnvSBMHnzOxJBCP9svCraaFHLv3rtG41M0B+xsqErv0fQjmBmg50Tptt0KVPbVlsc6rujL2icSo2EGcujlPwYSM4oTDDxXP8NdPZBa3NgatqVUewysKd/hnXng3gYjpRfn1fiTMbiPF+WBtBneCFbB1Rx8cpiHRiMsZl1KWyraE5duzTKSvqUheKGraA0XjQkYITvoIf19Cfn/+C8NarAHjnNnwmGex7LCde80/jg9poKfhYOZQr/3xAHncrVxqZUw6WEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTJvJ+wOxOBqUQ9X6N40AJPmKD3JWmKlvDU9E14Yr84=;
 b=dC0odOXHTZ2qgQT1YEipFz4c3SiwpKNOvAC8anNj7GxzlB3s9aP/KHIbxsxO0wjhvd0EPmlbwAkTSdH5Z66J0t9f7708PFBPl5OHxpWGtP4oraG+XMeiEcwIIE1DChWnepNqkeb41JW0iyNmHXB/IHZ3xQUnFXYsYIJqlpTj0YKjav5caq8vpKuP1l4Ptwtge8cQElE1CGpPvdCJrcuhj0/9ay1VVx5nQLhzazJJIr7qUcaJs3eQkoBssZz4rTiIuZospuGKp2VwuHShxEw3AWcRbhW9h4L3jOrsh7+2oaqJ3UlMenJWFOnei0ZhvY3LbJYyQTR+nVz++gAki4nY8g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 03/10] tests/functional/arm/test_aspeed_ast2500_sdk: Update
 test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 03/10] tests/functional/arm/test_aspeed_ast2500_sdk:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPb/nKcrKa+ukyRIlJEar2y6g==
Date: Mon, 2 Mar 2026 09:06:29 +0000
Message-ID: <20260302090624.987922-4-jamin_lin@aspeedtech.com>
References: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260302090624.987922-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6134:EE_
x-ms-office365-filtering-correlation-id: c66c76cd-b4de-49ab-0ec6-08de783afe2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: b3nB5g5gjOzvoFtRpKkROjJcD8XtetKLBnd0AHuymVX8i1Qk6hNwFeYFEsy7wsISZ6UN07LqJf0tixwdHtWupRmRv4RKGUxXMcF6SxvwBrnQ8GvxwfRh5p7oQCRFccp0COCvbpEAsm31CCxiMN1sD8GcmYeWE3vkut0Ai8ThmfGo6sZ07Z8gfFOlZX15Da0qDrT42bqW238JfS6DaLDb+Hoybol1pFJOnXchdNQClf1ckTcK/LbMnrlfqW7jcnI4/6fzRCHbtRJizi0f785FGEWg/nWVUTMgYmQLuC6u200OqVyFcFZvEJyLPKAb1op0Z0Uy6B4EufvyCF+7mnO0ME5xvNbXEHEjxa8XvgS1SSe25yLBm30EMeUu9M1YyU1vJPMiUShrmzVKHynwGoeNmjXisnmRLlaOx57AtccqoITTzToHqiWKr1BpnQxUcO7mZch0A8ZzGcCqvmweZwae6a4EazJ0G9jcclDHdUVog+umX9OAjFBydMTsfPsqVNoqkZJtCMAogbs33WC5zGc+UZszAGY+nOJBPdfdIsmnFKWdHj26ebdsaMWO5mhuw0Dxbtp3hU928qDvT7n98xrzYKAn5dvPNKS82LNN8UNvX/IvBtctnKoMFuYWhv1O/MlIISYJJbVjAh+19J2A/XRDHJrJaeY8MuNrIX6JSQW2AAghcx+tXKBPhJMppkXYFgBIClpq1jF7kskPOTjOMFUXne4eqhS3xuT75fXM0JRZAjyuFK/6A9pyEkTSY+EMcpmz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Oagu6bI5FE7XeiozC1la81Rlxep6t96YkKVQLURv/f+UvklTRwioZdXUMb?=
 =?iso-8859-1?Q?9/GQGc92sa2kN+RuAsSHqUKgROR83Bgr7o3dyDCKCXqksaMcAVYCeKWKWr?=
 =?iso-8859-1?Q?MyUPEzjIP6TXqarXALJSljF6mlSiHj9xUkv0m+n5f0D4G58GBRSJF9+fb2?=
 =?iso-8859-1?Q?fEHkPm2Fn+2AWKw08sRb47gCfqNic0FGAouHM6gvOr4Uq0EhM43OjdRoLg?=
 =?iso-8859-1?Q?KYgr7NNfIis2C5FDyBWYNWC5WOWembXkOtA9RHCg/6Dnhl1xuAir+6mLuF?=
 =?iso-8859-1?Q?xCb+ort5kyKU73gQ0zd73bt5V8p/Gnj/HT9q3t89uSQpbpy+YnpEHRTejS?=
 =?iso-8859-1?Q?4DIdmutoVhjP819codTG/MU4Y990pFZ8746V8+CBQZlBNxPvvXaKh23vkT?=
 =?iso-8859-1?Q?C8i6EnGG7keziMp6cjPxktKy8hHPTolqaRZTeEZzzVi5jNsMwl1RbYdgXk?=
 =?iso-8859-1?Q?4YYzXJdGDmkX8U5XySZ5FDOlTdnkZPww5MAc41fCAfhvg9KWWwEy0iUnHx?=
 =?iso-8859-1?Q?M78WFy5ZPoITRlkouCgAKuTQ7Hxeaa52bO61khc8XW37rTmj5klR6sT4O9?=
 =?iso-8859-1?Q?Hbf3Ij7CJS6K2wAxvB7jL8IJRaRiS2izYI4vYF7yeZlb/rj0L35JpGVEXj?=
 =?iso-8859-1?Q?+uB7f59o6yUw6+X/QEc5SXu7ZuZZAH8n/9AbQ/P8fSEbPOShoZOinQH8ue?=
 =?iso-8859-1?Q?oEucy4BwN1KhObFtDoiLIoN9V5Fknc4vd6/2tcSLRn6OjKMOquzyZJfm+s?=
 =?iso-8859-1?Q?s5fE5Ws33/lOhhJeNiBhkPVcTTKhmDH+nwOYMorEraysM8TRxYO/khczTT?=
 =?iso-8859-1?Q?2pO39mchQepnGkQUm8Aid8XyuewCNR3SUw0KsA/IGgEfZ4T2pnBHFkOyGx?=
 =?iso-8859-1?Q?T8Rqqfqar24UsMjsFQ4KWhQBY3QDXjlkX3y+5YIw9DgEvydynYI0tihPR7?=
 =?iso-8859-1?Q?+pC4pLVOuj6L/tK7GB2VPbiEOxJ+f3wjnN9oEvTVRagDInb3ELZlni35M7?=
 =?iso-8859-1?Q?10mBLuCY201HhzisHTVOVd2Faed4RLMMihgzBhWlqCG++wHvLUSwFcMsNL?=
 =?iso-8859-1?Q?/OD5JVnIHGK+nKpbaI/j1u/JMEnf0YcP3c951KV5zc6b9IC4vN4ctOqbpR?=
 =?iso-8859-1?Q?Y+Pv0O34cjSLraTBaSz15wKi/pY7eJ1mFrns02aXPgaEuXeAKaw+sQwIab?=
 =?iso-8859-1?Q?2oUgxg692wh0QvfVdO/O7noM95h+MVgJkcXeLvpxHtE5Rk0KJhdxnI72By?=
 =?iso-8859-1?Q?1YvbXPuJKwN3Y7dBbQn25Yo9VBC2fZn+ZPEleCedv5f5eHwGGPxPETYwtO?=
 =?iso-8859-1?Q?nv23KgdocV6EpS79oLK/20VoFXyg0LLJsH2yF8abetJyrVbI/0g+G/rmVO?=
 =?iso-8859-1?Q?193S4SXUa5GMBJvMZEAxX1+QX2Wj14v4vUaGhp8RWPnJA0Bo2VhvEZ09b/?=
 =?iso-8859-1?Q?F4zNRI2+lrnZktIJ9yjrcHVWpSzZO3/edtCn/dXBQaVi7a6A1OjPzSGbOb?=
 =?iso-8859-1?Q?1oqkpALOoZbUaYic9uqfkE0lNEu/lqZeLIxo0J66fvC5hscIBC+KJJgPyp?=
 =?iso-8859-1?Q?Dkj++LbqNMfOG7Ah3t45erLffr1OPTIMv6UQuXCb9+26rAzmnqhs9Coxlt?=
 =?iso-8859-1?Q?gBAAYyo80FaQTtTN/SqHBsKrf7G3HJ09yPQqGn8wrkKdYpOWoYhZ02Vw+M?=
 =?iso-8859-1?Q?fA9NDKvN1Iao3xHjD4KCwsLIkCRFWqtIbpxh7CSwrglXfEwqi8QOeY2X0Z?=
 =?iso-8859-1?Q?c8hBW/vfaJotheTHhoUXghcHmibDgKMLyzvm13nQSAeSv/9t/5Brk+bQeU?=
 =?iso-8859-1?Q?NczsTZtZ3Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66c76cd-b4de-49ab-0ec6-08de783afe2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:29.9851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqnqHeMu9Pva0NeQSYdrhcqIfnv3JWqIEPsQn29EYPhC+2y5niYEDEBDy8xbMpGV9K4aTodDt8pS8cyJNT4Ceat4HqpZNuAYF0nTdubVz1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2500_sdk.py | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2500_sdk.py=0A=
index 2c9211aedd..5ab36b99ab 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2500_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk.py=0A=
@@ -10,14 +10,14 @@=0A=
 =0A=
 class AST2500Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1000_AST2500 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v10.0=
0/ast2500-default-obmc.tar.gz',=0A=
-        '7d71a3f71d5f4d9f3451f59a73bf9baf8fd9f6a24107eb504a3216151a8b2b5b'=
)=0A=
+    ASSET_SDK_V1101_AST2500 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2500-default-obmc.tar.gz',=0A=
+        '3faa1188198da2216837be4b53861c483a58c3ad63784089720bf8421e157da1'=
)=0A=
 =0A=
     def test_arm_ast2500_evb_sdk(self):=0A=
         self.set_machine('ast2500-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1000_AST2500)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2500)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2500-default", "image-bmc"))=0A=
-- =0A=
2.43.0=0A=

