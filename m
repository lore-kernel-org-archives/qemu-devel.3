Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9C1E7317E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 01:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5e7-0003Uu-18; Mon, 02 Feb 2026 20:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dt-0003N7-E9; Mon, 02 Feb 2026 20:55:50 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5dr-0007tD-S1; Mon, 02 Feb 2026 20:55:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOgLvRxax7zTJeDudfowvi48HlCf0ALa6yel0y60Z8zGgfLF4k1D3AvBOantyc0FVq/78lP/h8sLWpc0tHUSzTgPWOfzQao/2tgvvYg27cyYc5B5YF28IjsFBzeH3ZrLxuenmbTDqxv0MtoypuqkBFL5/NAAvlOrR9KS2MiwjEBzHXEHyKbQvK/osNOnpfhztP6KVqF7r5uTXH1sMskj4Z1GntDF7tJFiVdRdbqPLSSxQRY/2h21uN4odKB9FvtnwIzkhsa96FzRe1AIH2WvACAtmX47UcU48Zv82D+9hUbh+/3mJ/w2I0MSHQxocXW21bnMpZ+NpiPyjeEq8NmoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGWRDTltkXsN+M0pX4AJoRv6aIWvwRqPcnRKufhhjn0=;
 b=BVphLN92r2AitDvOUJInU1XpF7PWLjtn302KK4IZg1oj7dH3hegbjtshyvki3rlRtLU7dUDnNekGgJvv4Za5/AwIDzfFncJ47NIwkNca69cs0ixItins+lgeKh19GrSREUTDW1Tlx2UDcolJpbE1nrq9xi46CU2uvexHEdfCPm+lIu2UN33bmn0uginKaABEC0edzx7hloa3Mt6L7jv5k57ZWPP/DTGU+BUmrmyZSm2i9APIcqDJiJHPDkWCSBk5q+I/928YwgwN4KAKX4mjVBhrPYT7P9azOtCIeW9vIe1XSXbqreAbYJrBVRmBABxrw0rOkmWidnlZI1hz1IkGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGWRDTltkXsN+M0pX4AJoRv6aIWvwRqPcnRKufhhjn0=;
 b=Bt2YOBIuxGsqgFSb5PzihCNjBPdh/S5zTiARVGbPz8nvkM7h2WjRJAb+b7SP6T4XNnS99KVFnOHl5gvAntxdijQUBYVuJ0sLw+8mOrN76ICpeRQmr2wKM70ypFFI6yjkCWzqCEyRL28ok4v6yv5SLvTIcbbmpGvsW0gDCN3ItqNcz7yVLhk64ebc6aSht/jKRnGcNtQVWM8htT2RCd0Q1C4T5u5q3Gt0g+fqSeW8EmfS/+tbsF2J4H5RyH7HMyBVsMrbJLD2RaJ/aHGvf8hNpWXQSynBo88jrZH6YO8MNH8Bo0tYRzduAv+JUnLH+6aaIKp9diIqUAb9WKenC4mLIA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB8040.apcprd06.prod.outlook.com (2603:1096:101:2d9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 01:55:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 01:55:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 5/8] tests/functional/aarch64/test_aspeed_ast2700: Enable
 PCIe2 DTS status for AST2700 tests
Thread-Topic: [PATCH v2 5/8] tests/functional/aarch64/test_aspeed_ast2700:
 Enable PCIe2 DTS status for AST2700 tests
Thread-Index: AQHclLAvh7PaIeBX3ke5p3pMkOOHkQ==
Date: Tue, 3 Feb 2026 01:55:34 +0000
Message-ID: <TYPPR06MB8206E427D92025CB3A2D47A2FC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB8040:EE_
x-ms-office365-filtering-correlation-id: d561038a-a32d-47d1-dee6-08de62c75206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?KB2XHp/nKxoJAxwCfNAMaB1gOPGJHIX7AQz0UOz+sORibcW9uCLDeEDld1j4?=
 =?us-ascii?Q?fZ73Hf3SUQV+6bD8Q95m/2owWqhXpsTkCB94OYOyJ880HkVyAh3BN02ZOkXJ?=
 =?us-ascii?Q?wRo+cfo9uy5GT2vl3zizV6ZBBdj4rbBk3AUtJAnYXT6WP7BYpXuRNL+43tSe?=
 =?us-ascii?Q?1TzhYjE12c06Rit8lLhhya8yYLAFKASl4sY0YGIO79fs3vDHZRbFAXBtfjX6?=
 =?us-ascii?Q?mvXHJXkN1IkxWGSTrLLrko7Ez7lIA6ArM2EqspMVWsLtOncDC3csgvTheYhN?=
 =?us-ascii?Q?evHM31gR09l4omRepFuC2hSgJlaA8pPu7ik+dDghdEf03zwi/4SyzghwkheY?=
 =?us-ascii?Q?02TIE31DDNVVIjsjyCC+RdJWhW9d+KI7oXGl18LgwlkWA1Q1Y7ilWr/yx4gq?=
 =?us-ascii?Q?PWrFdXE921EqLCRAtN4e5RoyOUQmV7CHFJqs/A7VSiY3y3Q30IJlQBPgEGmv?=
 =?us-ascii?Q?0li5y0XxNpr4AisfqdxBR2kVFByiYiMjdDCwnkryul4/Rm9IyBmeoOhKp2n5?=
 =?us-ascii?Q?CPQfK13giYYLUMJsiPcqt8xfx585Eaw2avkg55o2X1U/H+peDnfu58+J6MaP?=
 =?us-ascii?Q?sPJyap87/vAaEhoOxyXS+qb5cI95QW75EcxlNyurY8hoi/b7veCM8MKsvjcT?=
 =?us-ascii?Q?hp2XeYmIN7ure1mQWRlLh2QWSR+Alt7NU14+3wUwSRvdZM/wcIynhMNt059/?=
 =?us-ascii?Q?Yqje7QPGrirjvLZQT+j2KcQ0oHjCeEtKhwvxaIE/5sKks1ZgP0oW0NSLp/bs?=
 =?us-ascii?Q?+vlfcHPoKGNV+vt61b8/uvtYQjRpakjs58M4BR371ggvuTSD0KWu5kbN5MkG?=
 =?us-ascii?Q?7kQ9qGO5UEZOCSthCefPcdHbhjNuC9rLjsJqG6cI0+pc3Cy0EdEBFr1ZRxFV?=
 =?us-ascii?Q?bcopppzpiC8BVvVv1a3FgLrB+bgC4IDayyWPp5/PXW9q8n77/a9qopC96zOS?=
 =?us-ascii?Q?w5BowluUewjYQmOtOmRe5hU1dufowkweN1/6m0snlJSQTlDA4zSNj2G2huLg?=
 =?us-ascii?Q?LWUskG39M2KQsmzzBheMq+676puI3kK1h7lb1Q8BjR7ftTIfB8znPfdB4keS?=
 =?us-ascii?Q?he9FNyxtIkJgVfoXCDnbLkIzoEHw64um6ibboSpXVzTSuhOtygkxd7EesPJk?=
 =?us-ascii?Q?ifYr2mvGsqD6SmWKrmPOzbwzeclJdX5X/lXVJVOM3kX4Vl4XHOpcLSY5sz7R?=
 =?us-ascii?Q?SeaPoF6LfupInRBGIO8x1s9pnwLzsqPij8sMQKW6cIanUR3bSxMI3diucKPP?=
 =?us-ascii?Q?hebvt5vNVYe8ynMqhJ9qkgvmhLtyH0txr0prvIeEpHF4u1OcIvyxIP74MYMv?=
 =?us-ascii?Q?dAGMMxHyMDa7SGqfGLw2qvuoxvBu09ruq8CVpsR5sScszIP36nj7FTv9Bnhx?=
 =?us-ascii?Q?3TtAJYyBL1hDUh/UPl1SF2hhJlpsaTVt1gMhev+DFJLTBFTNSGVcEnMp48Kl?=
 =?us-ascii?Q?klleHrFmQSM+Z5Muy5aBWVygBi0I4GZ2yBpU3ERjS3TVNUSHK0PvwCY/87Md?=
 =?us-ascii?Q?MSa0DfOr91gvWeCWhulZX9T0F9QtburRDJlix5dae+cqL3ff750R0Ra6FD3j?=
 =?us-ascii?Q?iGDBeG6K4Co/0iCbBqXKtywcQHBFNzjlib5MpRGRRW8s6qBZnN4Qy2vRNa6l?=
 =?us-ascii?Q?bOIh4hMthKtH7ozow557yFY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2K0nTwxbLFiFa9pXkiG8NK7V/g8uvBhyeYB4/R+gSy+FMoe3hNzCbuS28v3/?=
 =?us-ascii?Q?wdzYajEiQmk9IipS3SywRNiPdhPJA+LCYOTppbEdrIxSjeQi6Ipltrc3jYTt?=
 =?us-ascii?Q?pdkqpWWedAvsWuDbwMesugosj5C32oK3xnN32kHYU9lCoZf1UvKH2exgPhnq?=
 =?us-ascii?Q?7UaF3s1j+VlGcNhDMWZUM4rBcSgBL+WPVSbxgC2tGWZxC+o5WBHu08D0j/Gi?=
 =?us-ascii?Q?N7KcPJOVJHH2Rjf/aLI9/Bl/USxXKs8WB+zOWC/XZNv6f71VbgIdtQMMWyOE?=
 =?us-ascii?Q?/U6IE2cbVH5gIh6zwtsrhjz/5TRM3xvw95TOfN6oCtA8ADK+tFw5qGL7LFFD?=
 =?us-ascii?Q?8RxX26eMvoB9AHiFgvV/2HJLxm3BitKm4efXU4tJsawc6rU85rtNquMd6PVD?=
 =?us-ascii?Q?OGhcRtxZBSPvTigA5Ap++MniVv0wTkkv2nZZPJrjz7b9IH/3q1MlMHJjNqra?=
 =?us-ascii?Q?9j58/kY8RXGNEQgJpeabgngntJV2b4GPNUPfKLEWfYSkAyQeBYKMj40hnETB?=
 =?us-ascii?Q?FZe6ynwuHuTQ68eFQkyPYXQ3ol7Q5RGT3NQjadDqqR6Krx+IqKWURjXBZ7JV?=
 =?us-ascii?Q?uEObgGA0d2JWVJYRsVX0kBDasLZt2jgbi2lzjTDlRgZEbBOxbfZoHc2PHrMw?=
 =?us-ascii?Q?Y+yhRArZh9Vn1tACWIyoxJaS8ILQyrpT+gHEtaq6BSz28xS0ADmocHiCfsA+?=
 =?us-ascii?Q?zE7PkN5IA5oC7YQEGhh1PR1YvpiVvjOxQMJ8rJK0M3Hkvf1nGzzdY5EE84vd?=
 =?us-ascii?Q?KcaKqG0AB851bvFQ9gevhSzO6ZwhoY2KCsf3lX+ynJivTE+IpOWoEFdA40Eq?=
 =?us-ascii?Q?S87s1l+SxEZvvl4fvugJLgD1Q0FRnYugiA7trEYWXFpwoayI3WJ/Joa2SzT9?=
 =?us-ascii?Q?dxX2gah6gJJ7n+rbGaWc+iNvOf3QFpe8gk66lSFHG1dZtHqzNJoW776ReqX3?=
 =?us-ascii?Q?+1TiGlGuva8KIUeGR4RUkUadT63hIoHIte3+P5JLlO+VC9kUdy/8DrrjsGfn?=
 =?us-ascii?Q?vh84UsKbW9xGZ6YV4y67CnXsdvZ97Cd1hDdzFh/6cOYXGr8DK1OXA8JwnKEn?=
 =?us-ascii?Q?otCirw0r0xxa/Bjcaut0d5ZxWjACXPwTT/dArdffa1oa9/lubo1yhseDvZEJ?=
 =?us-ascii?Q?Dl0T4LCc9/XDypOiEi9hjR3OpJZMFb7V0eA+GJ4Boa8eL+WcVQphzpOP3BUp?=
 =?us-ascii?Q?XnDY5MLJXRV9AnPd8kH4tBT3ANRTLTOzBCxAhY14NrmKAGutsCdYoJBqC96P?=
 =?us-ascii?Q?dSLHjs0vM5jjwzLhddZ5d7iT10Cp8ju3ZpTcL5lOcC+Qn8rFSm76q/pkF/BW?=
 =?us-ascii?Q?ZXknXwLYAN/wYdzB8UT0kjlRuSl0l3TVa048LBR+f2hCXUNEEpkBTlRy1+6G?=
 =?us-ascii?Q?qkTbPE3CDjky9yPU6NIAwMBfotIpStrnd1u2XWZtRzTzykmKriPObWf4XfLE?=
 =?us-ascii?Q?xaIa+9i5hO0xHzaeZvoPw/TwSyEAuv1l01yzpK7bUn5yX3zcQoVWNwv7yp6f?=
 =?us-ascii?Q?8ljj7lH2wJYD3+gU6LPYKikwk/tZKuIp+ZUoTIqtQUjNz6tOjkviOL1dFbP+?=
 =?us-ascii?Q?XvJ+n8d5GrkSSLtRqYOAYAJ8qeOrOo11cG4D1QwvkLc1uuVNVzODMsPdGibd?=
 =?us-ascii?Q?G/q4o6rf5xqDBihnh+4jgjaCuGemr9ddXrtTYch64JobEGStmg4rD8cAYrdm?=
 =?us-ascii?Q?0qALu2HKmEZG1jMElqqwS+/n5MSvGspPXqXOMD9nKPDCJzvP8TwYa1JbCT0X?=
 =?us-ascii?Q?i42nOJq2xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d561038a-a32d-47d1-dee6-08de62c75206
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 01:55:34.7304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R42OYASrlfM3k2sJm5qMwhvykYy2hWA4gHOK200UtI3PF+K7tmOYBv3uc7V5uHKsBKPbsyxPfpb7g2qmfYaaccvapzEPyqAn+ZDsZT6VkS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8040
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

PCIe2 is disabled by default starting from SDK v10.00.=0A=
=0A=
Add a helper function to stop U-Boot autoboot and update the device=0A=
tree at runtime, setting the PCIe2 node status to "okay" before=0A=
booting Linux. This allows the AST2700 functional test to verify=0A=
the PCIe2 root complex behavior correctly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../functional/aarch64/test_aspeed_ast2700.py  | 18 ++++++++++++++++--=0A=
 .../aarch64/test_aspeed_ast2700fc.py           | 18 ++++++++++++++++--=0A=
 2 files changed, 32 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index 0ced1a2502..1f1b5749f4 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -9,7 +9,7 @@=0A=
 import os=0A=
 =0A=
 from qemu_test import QemuSystemTest, Asset=0A=
-from qemu_test import wait_for_console_pattern=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
 from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 =0A=
@@ -37,9 +37,23 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'done')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
+    def enable_ast2700_pcie2(self):=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'cp 100420000 403000000 900000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'bootm start 403000000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
+        exec_command(self, 'bootm go')=0A=
+=0A=
     def verify_openbmc_boot_start(self):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')=
=0A=
+        self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Linux version ')=0A=
 =0A=
     def verify_openbmc_boot_and_login(self, name):=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index 8dbc8f234f..a1d8046f58 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -9,7 +9,7 @@=0A=
 import os=0A=
 =0A=
 from qemu_test import QemuSystemTest, Asset=0A=
-from qemu_test import wait_for_console_pattern=0A=
+from qemu_test import wait_for_console_pattern, exec_command=0A=
 from qemu_test import exec_command_and_wait_for_pattern=0A=
 =0A=
 =0A=
@@ -27,9 +27,23 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
+    def enable_ast2700_pcie2(self):=0A=
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
+        exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'cp 100420000 403000000 900000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'bootm start 403000000', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=3D>')=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
+        exec_command(self, 'bootm go')=0A=
+=0A=
     def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
-        wait_for_console_pattern(self, '## Loading kernel from FIT Image')=
=0A=
+        self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
         wait_for_console_pattern(self, f'{name} login:')=0A=
-- =0A=
2.43.0=0A=

