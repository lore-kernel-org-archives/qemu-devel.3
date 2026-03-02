Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8E2D58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEw-0000Ta-H2; Mon, 02 Mar 2026 04:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEl-0000Km-2K; Mon, 02 Mar 2026 04:06:48 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEh-0005WZ-DO; Mon, 02 Mar 2026 04:06:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBZZFgHN5lofc9maD27xLsOMaZBOqmC+SUfjnkld4qIt7u+cF01TlOngqRRfHSXyOLnzSFrS2b6gfyqK6PEVqGXi3SbPYtLcefCtn5FYLQx9381Ksa5i7r+dKhp1m6VnkXHsHc9LSrr15i66sfjitS+sa4qwEkvXvVsdvWfJh/buhykNbHtbqFapCDUnfMDrrgQ0ewFy61p2ERN5NgZ+wT75NSIc2DEabQ2nGnaGvwJ2jr7uOuyra2OaRFnPp3RsYBjSat/0QNS3t6zQr5hzl9kKP7h3m9Uu9UCuG0aTLnyd55xax5J4XKufxzReGsaqw8/JrWq994Vc/4iwQHq6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRI/XT8FZrA5MJI7t65LmRK3Dq8hVqgl6cqOtf3tc3I=;
 b=HnUAe7D/+7dcT4Mt2Jm4sagGIEGTR9CirwQh8GT6ffndLYCPZHM/Nzyc54+CNDY3+wXthwaZOyHp2tbok/90DwpV3oc85ifd6U9JlI5LGeqLalFH4yS6HorcWn9+9glj3HIzEAFY5YXaarJf3rMw/mFo9rLgd61CRCha+M0bgFefZ+WPEsbQiUid0S13F4zhT4bPo5T1Jc32yMB8HTectsAV6Aqt/zjzfqnxru3S05uE3MiKCk17eWCqO0ekV17oBwnK/WqFcpkY/aYWtCoiQfJqQRad5Ak4WDxAFMn7hEWQ+ecYOhZsJcQyh5YiHBh0/Ux2NYjFyP9oQ7VaUqPYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRI/XT8FZrA5MJI7t65LmRK3Dq8hVqgl6cqOtf3tc3I=;
 b=GrsC22mDlckpVdwYP6n5L0ghp0kzLOdyfjcRFbb5NSzpnz0h2Yf2xPbd8XZ0HTygzqulKxtq3/b0Pz6W3jHjSg2n+G3KzrECB3/jGRLCdvuZHAHdGgkyCnejMlqpvtYYeTjcxEuHVkgW9eLNWUoGx0j2aICT4577eG3xW7wuyFCAPxUbihMfcHipptYPoM4RczPaEW1G9+apup707V2fhCGVRjny7HBLpAk/hmn7UblQDknMXWrKwcZIQ+JDow0Zh0BoHKlOdWAgvn4wCqdV6xts6j+oWryMkEup1L9vSWVBtP2MU7Hy0oKNekFK9Udok26rC/5yOfq1chTITO1sog==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 04/10] tests/functional/arm/test_aspeed_ast2500_sdk_515:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 04/10]
 tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED OpenBMC
 SDK v11.01
Thread-Index: AQHcqiPcWLztM0fGk0avQgCEhmvCYw==
Date: Mon, 2 Mar 2026 09:06:31 +0000
Message-ID: <20260302090624.987922-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 1ac6efac-9a72-4029-2458-08de783afee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: Q2oqyisFhQ+9lIO2eD9QOfeg1WxUinx4WfjrTUywiYBH0Psj/xRhhXsYSEeYJ2GaxCSlFthKteAj4/2AjfEQeeEVs6aAmfFfKkx6smA40Un6Uy1Pl/NtZLg9AaNWn+nk1qpnsXppQX/yqz/ki2m5yketT7Lix4fT64gJuraEkMsYK9BLUduPHLBrhKu1TOgvo2i52im05Tnzy2p748LYVRJWaJtRx36CQCgJ5rdZPjNApsfr4S798leS93ExhJ7hi3rpNvTs2Kwj3LnNO7zfUpW3FTWp1k0O8S5QgH1EZ9RwSQegYp60SVeNhrNtCxGRUMmY8TV6hEywU46CIwLZXoraCuZCrEhfKjRWvNXrNzdxwTUP9pAE9p+ZNp17kaTyQS08XXmyBKTzkwc6TKeLd5qood6aZYEnEPG0LAc52b7TD5EaUfYAeVPJOZnNaikAN2f+asPovicenDZLWB2hHlP4eg0Kub+UjSuTWxNTEHi4JdGL3EFF9JRoFUZP5eCcc0nsKAcGtpm8LJyrxkLe5LCSj/JB+j7TxoyPe+AXB13OX5rbi8lat8/Ckno0Hy2fKOPw5PMxDfQoPICrSb7oyGiEtHZ38s+X5WGaKYo4yFYGbChL5M+eezRYO/sbFZvQI7/CwoYZ2vzANi1P7n/1yQ6lia3QSme0iNaN4cRKEoRgXCXyh91enB6WNpcekARmogyXCNJxwRfDs3nu4CC0s4VG+rfd41d5tdttgwpYv3Sn9UVZBJLVY+GVJNorqb0H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xZUQrGQrJILIOcD7m1SwCBlSJxvtbzmXMeWuynF+sERLvmtjF2zfavKxRZ?=
 =?iso-8859-1?Q?fb0PaXBuwiz18YkW35YyBhGo/Re2uzy8oKaWf00485HDWFp7UGuKPrV903?=
 =?iso-8859-1?Q?XoRIIPnecCg0K5FlPnsx2D3K3qBJfRzsfu5sRYIxqjA3VzO+Owt4q5LnjF?=
 =?iso-8859-1?Q?oXu230cDU764YnKwNusOQHORM199ebIMkzeijguIwQiTpicRJdTgLsCdQq?=
 =?iso-8859-1?Q?wfSLHlkWuR9Qi0NmoQ6lVCITY7VqGBcg7cfjKYNDNcZh/wOlwdErDAmPnK?=
 =?iso-8859-1?Q?YInCaqdGFIlYzbuvRE6ezFrBuEjS6ij/Fpc+QgS4cwPwzWU0CjrV5r4Ahx?=
 =?iso-8859-1?Q?ddVQj1RuEkbwAQxhoDtRikE89Bkko6hgfTxTof6bCmfbNbKHklaZr5HGmS?=
 =?iso-8859-1?Q?tLyyUuoONRKUFloNIt2IjVqgDTO01YkuW2ntEpkAZqD/Pv+YPfaAmMwzCQ?=
 =?iso-8859-1?Q?2tLLRlw8A5n+VKMdxsVDr1W345hdz7YSIACKwtc+n0kHVSZlTgfUpC0Rs5?=
 =?iso-8859-1?Q?AE46vR8Zn92mrC0seZhb6jm+5tpHdL6oVnGO4sr72YOlEBlWoNDUFt/JOo?=
 =?iso-8859-1?Q?0xaVqlVatewgPqusuSb4jLepyjkdflxGz5E2SNPWz05vvLidG9KcyyYHpe?=
 =?iso-8859-1?Q?Nu5Cchi0/h6oDGwd369LiTWJNwGGoynBjoFbSd3HbrqmHQ42yBC4HZCVAW?=
 =?iso-8859-1?Q?+wuCtbNINbgeOGmGoCPeJ2cGUuD/QpXDWxYrsUjBbzYRMToXpOq4c9RvB4?=
 =?iso-8859-1?Q?Ry9dlX+QMAMtodkNe9jBWq6JmfAggxiQEiltRDco51I+09zdeOIj56xjO4?=
 =?iso-8859-1?Q?CseTCZXS3Jamd083zEXruG52e9PHTUFkd0rUayMatSbyjdargvFSPViKqc?=
 =?iso-8859-1?Q?UoYX5rolxr7XW2joOojjOEmTgzkS2Jf9v6IPZ7aTSTz5rlI3UCKJytjCXh?=
 =?iso-8859-1?Q?lrorRIauCj3RKYCCSuyIPMedP15ymSVURcwvufFZJARHlOLG5XknKBqTRr?=
 =?iso-8859-1?Q?qYjuBuCIbZ07fljuflslWPtrBl4630AahTNK18+kWEoYAo6fCcNwOt7hCl?=
 =?iso-8859-1?Q?4kLHKSEN6bdLpEPcric7tDM7e15BgioPZ3R0iVJlvAIauMXRyjb+IN9xFe?=
 =?iso-8859-1?Q?6mNqNVZP2KbQdVOjVVnF89vJ+AEHH5aCi8Pd8ESyYllFO1w0JPFrd7Po5l?=
 =?iso-8859-1?Q?BHOawRkplCmxt9Sl2AE6wcQkCCONWSejBM+0ApAfvo2heJWLyyEMRcds6i?=
 =?iso-8859-1?Q?e9Gwdny3Ql+chTDtekhbQBCFxkR5Pdcl2aqbgwmmuuu0EnDEtkfCLh3fOO?=
 =?iso-8859-1?Q?VI7GJDRkXO3MVPxYcEisMPp3h0Vr9GiSX7V36ibw0eTOkbPhqUv/jp3KDZ?=
 =?iso-8859-1?Q?1D2HpYKSWKD+xfJrdlMySsIH0JzlVv4IJQgSyZwOGiOIn6MTxlfWn5XP5/?=
 =?iso-8859-1?Q?wme987bdNpVed3LGcdBwI5BlwmBgsmF17uuOyaZVHIHXbv76f4qOKpwCo7?=
 =?iso-8859-1?Q?uGGk42tJLgl5t/sIr39VTX6XZGGyl2AdksYkvwplphd3sHJRCKXqjEHm3B?=
 =?iso-8859-1?Q?iuhZojjQEdhbSuL1VVHDvEuiW6yPt9eLFtYYM2vcVnXlQkjptTFzkzFY2b?=
 =?iso-8859-1?Q?dKhS+dmUo2A9hEY+VypjGMKdqg7aQJL4SX9YSCacTOVc8VLDr3y9TDWhVr?=
 =?iso-8859-1?Q?4llBz1cLmAEKwm2s3WJ//zFLufORS1ayle5oeJuSIIyyWAR6gGENQlvSuZ?=
 =?iso-8859-1?Q?ZS69efHoL/KenHwuRxMvSzhjGBiXnS5IwnapNHJ15q64dP58HA3la+PtbW?=
 =?iso-8859-1?Q?oJRHDoGyUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac6efac-9a72-4029-2458-08de783afee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:31.2398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APL/UKK//Ltf0hOUoaJ2ZUaG3viNE1S77n6UMenTirMyta+CB0TrUoXDiXKQ6ypxgh7E1leA/72IVI+WyMu1rNWmueUqHEycLlPi/pgsqjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
 tests/functional/arm/test_aspeed_ast2500_sdk_515.py | 8 ++++----=0A=
 1 file changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py b/tests/fu=
nctional/arm/test_aspeed_ast2500_sdk_515.py=0A=
index 464a4e4396..2b257986f6 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2500_sdk_515.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2500_sdk_515.py=0A=
@@ -10,14 +10,14 @@=0A=
 =0A=
 class AST2500Machine(AspeedTest):=0A=
 =0A=
-    ASSET_SDK_V1100_AST2500_515 =3D Asset(=0A=
-        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
0/ast2500-default-515-obmc.tar.gz',=0A=
-        '5732255d4617d98b76bbbc116d331d6ac89906fa212969eb8213fdc4aea86451'=
)=0A=
+    ASSET_SDK_V1101_AST2500_515 =3D Asset(=0A=
+        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.0=
1/ast2500-default-515-obmc.tar.gz',=0A=
+        'b848ff620d2e9c83e2fb4736b4d1c39b82fdb041058cd42be42c3b177bf38eb9'=
)=0A=
 =0A=
     def test_arm_ast2500_evb_sdk_515(self):=0A=
         self.set_machine('ast2500-evb')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2500_515)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2500_515)=0A=
 =0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2500-default-515", "image-bmc"))=0A=
-- =0A=
2.43.0=0A=

