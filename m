Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D577CE67A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQB-0004zT-66; Tue, 03 Mar 2026 01:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ6-0004wm-4t; Tue, 03 Mar 2026 01:39:50 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ4-0005qP-1o; Tue, 03 Mar 2026 01:39:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq//k++aq+KflGWUpE2WbYQlIVqaFzxJNF2aPcWth8inZb7HaBqZcinfcHzYVT5V6OW+5BFnMdsO5MH87vb4MhYyGP9isjBh88L84tLSXQfhrVOKCI1jQLORtNPu3YtElC+WhyDPYosAYr9eUFACkgmNJaAEb41gnQuzrhZOHuDevxVoUtkKd+VM8FdNby2tJdCmWZdiRY5Y071oir3L+sq0DNWnbO+waNHEcW3ToJFpdn2RNfywZ3B4ps5+XQfe6lBCHoC/bscjQGeyxlKv8GVhpQDr4K3wKaBR+dBnm9ie50yXldNh5nlDg3FVSzIYbpN8G/U1K8ZiL/tWeg6hIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRI/XT8FZrA5MJI7t65LmRK3Dq8hVqgl6cqOtf3tc3I=;
 b=GeX1NxcksURXUKv2kgnKWwE1LB4Jil+glzmpAzLkp4gr1cNMrcGpEDIids7EG1EM9FNPBIlEhKQmoNHQEwpW/FmDxCOfuCOgRmG75D07Xa3n8nIOP2VVICRfp3s0DYJgmeh01/wqAZvOqBr1UuUIhvMZN13dKI6EtpVPi4JrVzHjfJp4zwfBRu25VsGbpjTpDlqigtC0Gsa3N9ggZ+AyjxMibha9CD9O02SZXG6gIzdJMrAAhvm3GnXI3ck8ZxhCubXzD/H/78kkiVqdJTI31gIqeY3yFkPHnS369JjIFVPH0eDbH1pOFR4JJ7uniY7qX84waDfDtmDSX26C2dp3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRI/XT8FZrA5MJI7t65LmRK3Dq8hVqgl6cqOtf3tc3I=;
 b=aNOVFuVwkVvnnqVNpMcJtsy53IP8deh8+lNQCWsHDnK1hSmRda9sSW504oXXYAMAnNQIifK2qS5hDcEyluwSA1suT6tUHnFnH3UaqYQDER3tuqpPNNr9qJav3tSQmWwKB1+nrboRNHpw8O+FKUOiSrJDpZnfJApxbgbN7/jCUjepVQVlLYJbnqmWZcCRFHIxEWoFXDtpyLuf26KuN19M4wo7N/6wUCctJjJz9pY4UlWUSKzbVkd9oTlJnKXmQYIZ0EcyLbssZK4nVOzAUBmmSDtQMClfjFt//NYmRYHmmGPFhlVyh5KQmzCLNckB4QtQ/ry1l7P1021IgcLNf20yNw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 04/10] tests/functional/arm/test_aspeed_ast2500_sdk_515:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v2 04/10]
 tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED OpenBMC
 SDK v11.01
Thread-Index: AQHcqtiBBvb05yFY7U25T2Yl3/jJLQ==
Date: Tue, 3 Mar 2026 06:39:38 +0000
Message-ID: <20260303063930.2878300-5-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 16bd5645-b634-4ca9-a097-08de78efa467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: Dy83GaihdD9EKo6Is+0AaTlqXBls9HUYuBPlxx/12GXJPsHwFYdv3nyYW/CJr/x2p1Ag3OLEMCJ2I1ij/dwDnZEOMLVOlSh4F0i1O2rK990U/5kZbhZ82v/vpj6XtVpzaA+uGXH7AakZpyxA5X0/Xg4WY22jS/qtcDOjgXwtjQT/4ZesGTygjHQIkirNm8UlZBe2hN/zPSH5PNglKT0Ur3jfzLW69eMMJFSFa4X8ydERMwGehdg1DdG45kWPq9ozRsxFmx1weY6L6taGMRoaZ+OSLrVvdGttMClLqLk39sgq+6bcGJ8s2hC1R4l1Ve24wQAD71YLwswOr/xBxFuGW0lYSjL2Q/yeeqN2DXztM29MWaXzNHsReQikbtDrsFy2gZPB8PJe+nuVt9v2chXQw4Ix/AHNFjWTEzCQSGiRtllK9z3P3eBcguiHOPQdXmx7Jn3rX4uymMeg3e3o1SYVcYM1PrJNl+2WNFlgfv3R+QRvJ6+Jct/04hj03y4Mf3GQqFdtGk5Y0+mUt9XiZe34Ur+imhlBKDorNUAYsoD77g5XFCm/H8kVfZBxbIAc3pWW3IqavHss9jcI5MHjKcA58FTy5V3M6wDiShPVYJn6P6KY8u5V6GhhVbM3w7aXI1ZtyD3v7lQArkHzUOBw6k45+DUwSBvBksQY1rLeUbUWv8xZkMzoLDADN2uMe4cahKjUVPykl/+nHj+FMp65yD3Ecicq4yePZ15kMjmlt5dTABpIZ2h0+JEEfQ74F/yYrUsT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VgnmluId5iBh0AIy0Qf7ZX548YQwQSPuI6LxIQF9ipskNntqcN/IEtIIZv?=
 =?iso-8859-1?Q?gANq4AtjHdA4AL+2gInVuuDCBhCCJJYI217yL4hr6ApHoS4Hh3TLGNoaHV?=
 =?iso-8859-1?Q?mhiNCXMx2A/XYNR8lMUcw7PJocbQAU6bdYkVgv/rH1I6PAcGoJGCw55Kc5?=
 =?iso-8859-1?Q?+iicdtHCyk8UBfqsmwmg3r+MTe9omXVuZYvQ7VsFnQUyp8j3M60LF8og17?=
 =?iso-8859-1?Q?y4HwyAzxlweKpqBJsv+a4jSlPaiEUGWoAMuGV1KJz0ws4uNcwSGwqktyQx?=
 =?iso-8859-1?Q?dy9BTcqjt82NPPbRXjtsrDxGIm5QTIEkpIB2CLbRau/0OKjvhqbLn15JJF?=
 =?iso-8859-1?Q?TW3jV46vlmXCl3n0lBX+J9xQiIkIjAslwcNce3w0Gf2dq9dlHfBS9SEEoV?=
 =?iso-8859-1?Q?yp6CkL+kDXj5qGCcuMTRYsZIdU/dtcKwLUNwRhvxZAlmDCRIEdDZA6219N?=
 =?iso-8859-1?Q?LTYualABD880GQhTvPZEmoJZfbdsZqnMPiEuPkIpXYVNocjftGly++sTrq?=
 =?iso-8859-1?Q?2ArqoxQ72q1LoBPwfCU/Q66Mmb2oDnDr1ic3kOHu+sfCqobi5rrBbLyUS4?=
 =?iso-8859-1?Q?0mWIDFDEzlIpSe8coZU7CblxkaZimJj8+zqBWbKiGEG6LVZnAUTZkYFERT?=
 =?iso-8859-1?Q?GoxSpUQGhUhuhTWAiZPWw6ATZRVRxuCcF1GIr719R9HBeaz6QVTnC6CFXY?=
 =?iso-8859-1?Q?BZcwzg8594bxwCzhkhM8n3zP+1NMO9SYJghfLkQJW7JPZowZUelB2W8o73?=
 =?iso-8859-1?Q?EdsaisTnxkEUyVEMfjAmrXJMjaeVPR/eNiKpEZ3uq3IouYQ2BWyy9Ww3BL?=
 =?iso-8859-1?Q?lR6Xtglucs6AEaS+syQcke2wUBC9l/4K2G9RjiRI2ymU/1gVsViKsSDEcK?=
 =?iso-8859-1?Q?v/nrSJk4Gl4s5krxgeq4XcCKZVr65QSpl+inxZVJmf+vbOzdZDhDRHobzN?=
 =?iso-8859-1?Q?RPIQ3sz9auguaukaamwOqNSPhh0OOhD5SqG4m2IFcLLuLufSp1FfdCbEwI?=
 =?iso-8859-1?Q?JAj9A8NxNd8y1laAGC9eQlvEvFAhAuW9piGqQE8C5K6+ZdoQdt+XMJofPT?=
 =?iso-8859-1?Q?TGyCulN+3cNpE7toFN/lpyo6hBqD0zn6TLMTFdAUDQdx4iyOP9UmBoIpgh?=
 =?iso-8859-1?Q?w253YJOKPf2DYYXUyElWWtFySaQgzwXCRMcTXi8qB609qa3UkoYGBjicp0?=
 =?iso-8859-1?Q?m3Ngd7oeXv+ACycAfDyWUrnBV435PwGxELXS5ZUwtuaL5J9hIOXdYdCtMD?=
 =?iso-8859-1?Q?pJ7j3WKRr6ynidhBc+UjILrjzt0NNA7cwKvTigyIEsmQ2+hucJC5eXhJ2C?=
 =?iso-8859-1?Q?hpCeASb/o7OyFMJf8sw2VCn9/4/9GZbEFyYya4nq7rcT9kRcdeJCMz8K/2?=
 =?iso-8859-1?Q?XD716pp1jFW5kHXnpFvgPA7ocjxug/GDDbj+9BOzgIK9yOFVuC2Uuxot+D?=
 =?iso-8859-1?Q?XYWFs+g6gG8Du4W09tvcgklzSsBeMvQ/xMHaZsCvYYtMONjADoeHwjJ6zl?=
 =?iso-8859-1?Q?CieAJCu+0lLD7vjpkwzY24/9QKLFe2wN1f27erzh9wsijA9UfQiJxdIG0y?=
 =?iso-8859-1?Q?cS8/VO6I/JdRtdWkgaA8W04YYZ8bTz9FYkjjQBtq+IP42EJZq1yKrNt9oI?=
 =?iso-8859-1?Q?58RT4RhDeF8pTvNCL2Q/5e4R5M4EaS9q2YbEeEBhtT2JO7z1F5NLS3Iq2i?=
 =?iso-8859-1?Q?6kIyCq7BXXPDoPYF5tLi6pUb+xITppQku0Xxsjjs2XfTsB5I7S0iwsEiIQ?=
 =?iso-8859-1?Q?Mh0X559BsEf+6MASMSKpt9bqTZPiN416pltt/Yd7dRr+lBpcCn1o6NVe/r?=
 =?iso-8859-1?Q?ftArxH2qLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bd5645-b634-4ca9-a097-08de78efa467
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:38.3499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8yzMopSf8qB5IAEmxKIGeGcChbahVIx9BGotnas1by78se9kgAbu6OgroRO/pBFt/A36pvoykhejTR9wmuDcdnqHEYCZVdIyFooRZJ4GrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

