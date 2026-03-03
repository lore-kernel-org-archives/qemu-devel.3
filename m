Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F23E67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQF-00051b-Oq; Tue, 03 Mar 2026 01:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ9-0004yy-ML; Tue, 03 Mar 2026 01:39:53 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ7-0005rC-30; Tue, 03 Mar 2026 01:39:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgUqB9pFvhcSshI3FQVMunTDABNJzlcXg35NrMal1BdzgV5ZsI69/1wmMkcJwKJYrmAroCmVSXq6FVEZxZDiZaBVo7+TPyGJT1mpzY6Uc1joWKgH0ahUINPDy81rQPkVHkI1RAACdTbh0g3fLgh+O+XiIkJF8gvwgvxlCzuDVeaE386sY0+nQuhzjvBVYDjd0fTIP1b4/UaM/g24OIZYj3elZCK3xgAK/m5tT/nwTTJVOcGMdQief4ksLqf9jpQEEFt+hx99c41oQFug/yMvDkWPI79VvtyAx603CdYCoS//J8VWTOqdlmSd+019SkJIckx5QZ8q31jgMwEvqp5ZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sJ98qPDgnXXwYJ0z/VrAZM/qZtkBxNadGJvnJodStI=;
 b=uw17KDQgde96qkinqQvPNPzZvlNPazskXghKwjN2YcnPZQZMgkpvLbu1GfIcGIbY/YZwNL9nrctDrueK/d+9Pwhp3Oi9B0XU7ksVTTh/RlqP/CRPfuhM0LJ5za/pVIvgJnMYRomwW9pn7KJjqWTkHZoA/IdhiPqwAT8mhGTJe2oqHlQp+ZvPhd5Qec9sS91QKug4n/5tgj1NjUSArQVwgTxbkOSkmW87sGVg1JUuc1uyzPwPbv/MXur+C7iKOYabnYBQ5mRGPkbDIyv2ZCgGXgDwPgqKPDZbmhysB985UKyxCG1m/rBgRRWkm7GDDlu9Yz1iogizSv774UIkxCeJUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sJ98qPDgnXXwYJ0z/VrAZM/qZtkBxNadGJvnJodStI=;
 b=sDbMpgCzw3QGrVCnW7Zt+8DZCh1fJZV/TKKpQJ2rYpnghtl6xwwjACEy1e9odc/cY1QTHgCz0KDpqDt/91gselyDCZf4HSevhxf9yYke+E3ZQ8saXDEvjL2HQLOWTbmE8aAW7JKV3ZUgySVJUhrxg1sfqMYaeDp6jRB+RvSDZugB22lNNzEy2qFUsaeijHG5E12ZJWbiTtOLH4pohyPym73OCph30g6328a2O97+Ye/1jrHkvKmhIPHG48HT2NRpGrHJv5vIrqOc2HqckTK5vFuNW7LtWI0WTHqhUC5u8W2V7gHW2YYFEOeqWO7xTk6Df7BPPCaUEn6nGtQGrsAUmg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:42 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:42 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 06/10] tests/functional/arm/test_aspeed_ast2600_sdk_otp:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 06/10]
 tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED OpenBMC
 SDK v11.01
Thread-Index: AQHcqtiD2wGsDif1n06UkQLV4ajAgA==
Date: Tue, 3 Mar 2026 06:39:41 +0000
Message-ID: <20260303063930.2878300-7-jamin_lin@aspeedtech.com>
References: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303063930.2878300-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY0PR06MB5459:EE_
x-ms-office365-filtering-correlation-id: 5941aa66-21b8-4b4d-d4b4-08de78efa6ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: Hh6xNtzJIR6aB16BMmKq7hNbqqd8wbQndeNCJj+CzpeYzdD8zses5U6+hgbE5wtWjQfL4d4ZIXSmkWcP9O3nT4IqHlx/05TExgu1j1L4b1LX7htfD1MjHvIL2DAo34no3haEAcvoRMsMrnjKw5GTal6+cU7SmFq3nkO9hzYteUT8xlT71+BesyEdS9jKn1uL2QcW6WThYmGWtMuvtOT/HMwNKv43y+i7gttnQSbsWzbpZd+oJncfAhZeYOneyawiSFlsBHlUXXReuVdvoT/gFWUySfk00i6CRIIwa4saM+se4eIb+LmWuQiBsDktZG/xkdIMvVmLxT4EzVTwbTrGs0D//M2ET3SgOTm7SgxIr3+cpSmozpLh1JaS4YQFFFVkebaeA4gdlrvtowYQoKHbPiohvY8zpZYk075mNfHQrCQZHU18E6rd1FKrOV+8MnIg4fv1hFdjS0T3lcgTInWuBEsesbB/K+vH1pgU6/g091F2v+s2XgOaJavicKodN1IcsAcKCSzMrUDIM4creXYUFsZpRVAWmOGMvJdK31X2xKByskWedIyseX4uejeLEioAUvf9eLPjrDHvdjhBn01gSnne7n5dz+ddxDoAefoY3W5Ig7o3fArkgPn6dTl0zLGvIHjto5PmnncKEzB1s8kw7ALXfdPdSxTLIE5GAe2I2PFka2bIGMNpfYWDeJZbSTvcj22PSPWEuaz5YFoZYXglaBPyy5oU50DarIzQ7S+IMU8vBLWnPNJ/CKRmIJwJUz/Y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7EnfqKroS6/RfkFlWn1jNxWmSnuAZFovXS3jwoyCLOKkPArCRyIhbTYHqF?=
 =?iso-8859-1?Q?afUejgwRt1+BrB2VBVZ1olF8cPTiwg9RrZBQTyMuU0cs8hL/4tP8fujzE8?=
 =?iso-8859-1?Q?pHcJr15I35rwujt24/2Xu9Jj0MDEBRWwo8yCIiWAMTX3NNNoZArKTtDlPZ?=
 =?iso-8859-1?Q?AMHl1hgCOlZvMV64rLpO92TA3E6cJVCxRghq422Y1dVN920qpqbNsq2shn?=
 =?iso-8859-1?Q?tCS62fWpQ8So/6QD/l00twkjH0bL4Vtd0+6Gi2bznNMAOcVWUP9axc/M96?=
 =?iso-8859-1?Q?Ig3hO3XhcuXr8u7o+/Rx9PSUUTAx3I/pOG3+6yS0SerLQXIvQUoq/AlclA?=
 =?iso-8859-1?Q?LmDKybps01jJKgSSv385XUZ+VSwQnCfv2WiY2xj5/VFlmkxZHUN3mFMwzx?=
 =?iso-8859-1?Q?DNH+c2Pz854Ack/8Fy61MoEEnA142nfRvmRLVEXjS6BEpIC6ZLW1QZAroN?=
 =?iso-8859-1?Q?MVKshdkekrI/Gp082K7viXICLjskq/+lOlev5FNeWEr782EaDk8KlxaQ/q?=
 =?iso-8859-1?Q?aR+cl7FChvEJvnNn+vJ2hIy6acAb+zPGMpQ5XsRoatsiMZOzON/GAUNZhg?=
 =?iso-8859-1?Q?kPh407riyVEhRFyuCX4dybh/K6JVMMwhlIOTxAtqs8InYVjo6iauTnLzD8?=
 =?iso-8859-1?Q?7aNmj/TlvG/NLUNN+s6PwectAQX574ifTujiE4Vm7QyBE48aFpzys0ydD7?=
 =?iso-8859-1?Q?nSe79+rNPWaNr6ojQ3CWMdsnBep1tMtetuesi3g5bn2QuZpYR9JcUrVSTi?=
 =?iso-8859-1?Q?2vkiT9D3tVsqpDXVOGiW/DBQ9g/VSohahG3qeW5lC0JmijwzFyBnX1+Awa?=
 =?iso-8859-1?Q?btDmVoiDlThz13OHnovVrOzf9LhUcBhwH3pmYAci6nHCaExwEVACS5lh4l?=
 =?iso-8859-1?Q?Ec4TwRBMhaXbMC6m+G3mrLwhO6I6SfNglhGBYLujosAU+jic0qiuFXrVgR?=
 =?iso-8859-1?Q?qhPNBSY5T6tYFtNrjWw1OX/NQtxWJ/R0DzqeOtOh2NuHy6nAtDDfZacG4d?=
 =?iso-8859-1?Q?lXu4E7cUcfZZfaG8yDcGXcTome3je+r+fbWoi4I4SPJbcwihkwHGc8vO3h?=
 =?iso-8859-1?Q?ObMsAEinKKna5jwG6ez7R32novu2mZfNoDwMWuyYgvNK8EmtlXaSxTsQ4T?=
 =?iso-8859-1?Q?bTRl7CgmdT6cBqNzsHQMsJhyyWWlLpj65eCRiRYxKasO3+uAAFjjdjUVKA?=
 =?iso-8859-1?Q?NviQ95FJCAdGeOLdXxbgU9PP0xv+k9bVNA52tw7pwm0aNgjZ2nPYog4uVw?=
 =?iso-8859-1?Q?ZQpz1EjGV8Iv/TvAdQB7oGQFPp08ndEFXHJCSCi8Hmmu/dA33P7EabbeSA?=
 =?iso-8859-1?Q?R9KvOFAbvCXNT0Kxdw72meIw7Sz8ONfUdUOJrHXS/zN1bwvlazj7k0LcR5?=
 =?iso-8859-1?Q?zkcaJTFI1WN5HPDrP5rQZIINUqfEJEv/qRnYB+q8nyAWefMEvBiYAq1wRg?=
 =?iso-8859-1?Q?R4JrHX2OSoGg5Dz71dPnwMEycvS8ZOhPcCsFi644ypl2qE9PRtiTZf7IuK?=
 =?iso-8859-1?Q?xY2r4kE8pdQ+bNi+hmgNLTve8IkgiHWicUuB3c5V3PFQwSkxn1ZHDdc7gz?=
 =?iso-8859-1?Q?VBRhC/y4ZVpB+DJBLu9FZtsa4lJlspJ0og8Vc65/zsyDTPOqOHYWoUBGn3?=
 =?iso-8859-1?Q?gV106VnR/muPa16sdqtx5kGYe1BRcXU3i/eWWk4aqU4dsfAz5yMzm6dBBI?=
 =?iso-8859-1?Q?xQiaAklY6owclVQKDnCaz3y5a50N74hFXGW4kWEXLLR7mG9OC6ey4+2AUy?=
 =?iso-8859-1?Q?vCKUpO2sallOuagtcxAj+Nmx1AI9dtztM/Kd8tDRVD0p7mfCJx7LgJ+F5b?=
 =?iso-8859-1?Q?hdE5zjXwNQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5941aa66-21b8-4b4d-d4b4-08de78efa6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:41.0712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3y/dK2fgW+7E2tfZ7HOFoD7X0GDoqfzIweigjNc5G8vKhlxjl5DU7JKDc+LKGDApzBHSPkcQX+a8uyXNrzVYrqRSbn2AAuuKwBShZXCHoxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py b/tests/fu=
nctional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
index 31a1c3bed6..f24dea1e8f 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk_otp.py=0A=
@@ -12,15 +12,15 @@=0A=
 =0A=
 class AST2600Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1100_AST2600 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
0/ast2600-default-obmc.tar.gz',=0A=
-        '64d8926a7d01b649168be96c986603b5690f06391286c438a3a772c8c7039e93'=
)=0A=
+    ASSET_SDK_V1101_AST2600 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2600-default-image.tar.gz',=0A=
+        '3c5b4d4ccf27b0d208a073f98426db54cd751b96143180cd15df1a83978f832c'=
)=0A=
 =0A=
     def test_arm_ast2600_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast2600-evb")=0A=
         self.require_netdev('user')=0A=
 =0A=
-        image_path =3D self.archive_extract(self.ASSET_SDK_V1100_AST2600)=
=0A=
+        image_path =3D self.archive_extract(self.ASSET_SDK_V1101_AST2600)=
=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
         self.vm.set_console()=0A=
@@ -29,7 +29,7 @@ def test_arm_ast2600_otp_blockdev_device(self):=0A=
             "-global", "aspeed-otp.drive=3Dotp",=0A=
         )=0A=
         self.vm.add_args('-drive', 'file=3D' +=0A=
-                self.scratch_file("ast2600-default", "image-bmc") +=0A=
+                self.scratch_file("ast2600-default-image", "image-bmc") +=
=0A=
                 ',if=3Dmtd,format=3Draw',=0A=
                 '-net', 'nic', '-net', 'user', '-snapshot')=0A=
         self.vm.launch()=0A=
-- =0A=
2.43.0=0A=

