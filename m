Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1386E83EE5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX8v-0005yt-C3; Wed, 04 Feb 2026 02:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZS-0004jo-Ix; Wed, 04 Feb 2026 01:41:02 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZQ-0004HR-In; Wed, 04 Feb 2026 01:41:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sygRe86t4tGrFdGFethHQa5pzJt4ta/DyY8xMSRc4IgVAvcF2/eA/MJeVp7FzaB1WRSBwirzeNaIOQJ19zUuAZMABnIMkikVBWwPB54CYXJ22pn+iAajp8puCdZ+xKDg283Wf2vTW0/XCY4VU0MWVeGfGFt4T+DMDHg/NBzmEg3OY87LIFzYuTj3higY4tlvY+lERiinI88j4kX9bT97yQxd7YNpCB1iJWwgU2BPvuQxeaOozqy0miwnKSSuWpbXON5Cdc5Ed4kHSdwf4eTmfnD08tIVjP9e+9PvNdYmqRE3d0Oo1I/IXmPFd0/Uaaij3yx1fPQ7QH+IFRFk+99RIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIuwCK1HXHZx95Mi1wIQN3VIKpB5MlSRl9HQFO6wVyo=;
 b=vfMWDilitA5TF+oHIzwY9Cbvpd9MwiQ7N35QCcvvwTYmZZ2jas7Q4FEwn96kAvPosMpkw9u61xSarx4f94QiNEYO5aRQRFBFKqORQFF9SR5O8IMfoN108vF99BaLN0PKRaD++JUFKB2hjP8UHSmrN9K0ioz1VQmakF601kZlpky76ccFPl+Lm5HIS6yemkCSbMGqieZLetczM6LQRhlVCx3Nl/Zvqn5YfkrlgdA7PfBOiAoBpiSo2QFVlAoNXZbTNkhSZpYPWRTSnhavj82gE6tSSr0H+lvkNyUk7Sylkxun51n9PpuCb5D5lePhjBrBEN584VnKaPn+HS5PZt3wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIuwCK1HXHZx95Mi1wIQN3VIKpB5MlSRl9HQFO6wVyo=;
 b=AEkJDIE46xLN5LK/Lc9pvu+Q4ReSqrumyecCCBQKe3NTQlnhpSsY1IvO7zGMsbI2Tpz3JI5JBWT2h1Af6MQJtpvLVYFZa5+Ykh+hpV64goylxgA85sT25Bj051xgALzjWFXhScXwwrg8dDYOsA/d85UxEBivYEaQQoruS3M5+t3bZNByWsZ9ORFTy5dyQGLEDO08rO5HiJLQstDpa+FK9/0RnjC8yEJVE5yutt7/LQ0d7WkQm4jiFiF0a+ZTAQQHn+xjmI49eu6dLRCdvBFbD9zs/jI5GXlMww1A6tvVpNxDKIx29C8QNSQ+elCIEk0NppED5WOWwi6L9wBJpkioMQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5901.apcprd06.prod.outlook.com (2603:1096:301:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 4 Feb
 2026 06:40:46 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:46 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v6 21/22] tests/functional/aarch64: Parameterize PCIe2
 initialization in AST2700
Thread-Topic: [PATCH v6 21/22] tests/functional/aarch64: Parameterize PCIe2
 initialization in AST2700
Thread-Index: AQHclaExWAelYSu9r0izjMULaB9BDQ==
Date: Wed, 4 Feb 2026 06:40:46 +0000
Message-ID: <20260204064016.3515639-22-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5901:EE_
x-ms-office365-filtering-correlation-id: 5ba3ad20-4e53-4c78-44ca-08de63b853b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7142099003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cEJRM+T3mSv6f6sxFJF4m9DyDCiERQt3K55pFBEmfWCuiaUjxPf03ZWE33?=
 =?iso-8859-1?Q?rgK7iK6jDCqrIrOCfP9ZmeE0zzG5QPFp/g7iPU/szqTZsNFpcaVYtGTNfJ?=
 =?iso-8859-1?Q?jydtOLWmHqIlQHB9Yz75uyUv7f9SDD6tnT3TPvOQaU+Eju1elpMHYk5pN8?=
 =?iso-8859-1?Q?Bjk2Hr+JYypP9U9djqHtX6g5yJpH98ehMKSG30jNY4i04AHo5aoTx7kgaR?=
 =?iso-8859-1?Q?AAYgi26Ch1ZFayCGdk0RL9lu2pqjBxIxEx5svvQMvyxXjy1vFd0SLjK8tJ?=
 =?iso-8859-1?Q?YzP+n3CdOwWusIBOtVDnQ9CtjtU+7XqvO+db31S7Tpw9mANBWmEK2eHjAF?=
 =?iso-8859-1?Q?bKOr2LW6TjJ/nFcy0Ctasrmy2AZfi+ENI9xY2QXxRrUBYA8HA3bUCFCO9L?=
 =?iso-8859-1?Q?E428kafYwSm6/o1fat+vJEI72Gk45aSjqkI0PQANZkIApbSw4FHnpsqey+?=
 =?iso-8859-1?Q?Zh8DKtzoDs8xbE8IG38v/mQ7yxhQ82EQVg5jcFCoxfO+pjMicvG9tszFp1?=
 =?iso-8859-1?Q?rq7DBc+CEdFqYXcu+3McxGv1fEsmNSebDpCultgh9DJPSoWblHN7vt7lf4?=
 =?iso-8859-1?Q?V/vc6lMdPdPUf6NyWvMnzXtePMRrFhKbNrZF68MIBxgBsNdMxAe34hx4o5?=
 =?iso-8859-1?Q?rFJLuW8tXs+5HqRwjQjsnz2iHlv+gdWl4dTLTTl5TIe+wKveydZrhx+vnJ?=
 =?iso-8859-1?Q?UjNqLGZIaHoWCGBw5gNlmIl4SbSXfgGSn6ml+dhmSdZQYO6rjhqqmHCIUR?=
 =?iso-8859-1?Q?IKSsPFtst6AzAzxiPYXvFm3kMisatBxnkcKDmsYZV7bPUGRnqWbBthvQhb?=
 =?iso-8859-1?Q?QSBpRiyASgArgcEnJfoDkfjCcxi2qYtaZyGIqWYhbMXnmgyWLnEEmnj0BO?=
 =?iso-8859-1?Q?IAZd2sC/NpoFkvCs5cstbEyiYRw+Dsr/FgYy2vhxpeao4YTNTzBKD0ltCz?=
 =?iso-8859-1?Q?qLF8+V2l9ctHwXHm+HvAEXz4AKQ1IjJCrdvqGyWeVmVgpMi6lobzZJ4lOJ?=
 =?iso-8859-1?Q?JbdxAj5rjCcaLGgJPud0o6udhIPjbp3gpBWYg8JqiQ9bDuOnxmVKjKXgpv?=
 =?iso-8859-1?Q?+8CL22TFI9CerPDPBMWWm1mXo8CeEcTUE1y8r+hdPcJtbCstPc3pwEqkHk?=
 =?iso-8859-1?Q?u6OfS+EgPvwzFF/y6or2SBT3Wr4gP/eDkxMN71QPPwhlHE28S2x86BjFoy?=
 =?iso-8859-1?Q?X0DmZeHj7ZnE037HhzzMB7Bg+hr5YWnBA3zzW5b/FkmXBxaAsJPq5QZmvM?=
 =?iso-8859-1?Q?rTf3LPwgwBvon1kTLYwaDvLQx9a4gOGf8+eZBR9qIzOXRF6wQC+p0OudW0?=
 =?iso-8859-1?Q?IAJO9zYqlryU6qZGNCtjDOgCqgu3Q2TEDEBuD8w0yCkZ1Rulzfp/y0jQAt?=
 =?iso-8859-1?Q?7HU+Kn9A5/r1JBxQ2gVY0GqCybjNtJ5hyCFOzb8k35pJoIqxeR4z1zzpV/?=
 =?iso-8859-1?Q?K0PVffSkO9hp2CZOgYnst4UXhroLiCFXROFi5Jzdho20hHQYzybna/nuGW?=
 =?iso-8859-1?Q?2MgmVy3bADrc3rESRfE5d7evlKYgM6zZDSmCw3aBaS8t9z/b22CKzdShkY?=
 =?iso-8859-1?Q?pM1CTa4eGWWXXSNonsLWzYxqkahIo9QRoXYIQkbNgk15E2lQk2rrJNQR24?=
 =?iso-8859-1?Q?1QZWG14qB9ns/PKkxXW8YN2Dob7leeOpRV9/DvDadaOp/Bpt8AarDnRH25?=
 =?iso-8859-1?Q?TE+D3t4XhHUZTVBPRGU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7142099003); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IfbmXSNjBxfBKqcFcAcTquDRqRBoo2ILvlRII+SzWBJBVvzvoJFfGz2hk/?=
 =?iso-8859-1?Q?a3Ah5E+PlRnQ5sk6foUb/SpjDt/PHpWJMVWU3tx20D7YSkMHrShmCqnBFZ?=
 =?iso-8859-1?Q?iMuS5JVwIZKzv0L+SrV3ZfPu6SH5CvdGAOzUrPKChKbH2VKKcZxbN5UsaD?=
 =?iso-8859-1?Q?8kF1nu7jG3hvJLShIh8Ju7tI2f9dvAsOcNhbYvpU1EMCKaqajPxceZdEX7?=
 =?iso-8859-1?Q?OfVumi5JNseM+LysJBNN3e2eT/UpsGls4LvL+VB0HWQXeG5RGiaL5cNvRO?=
 =?iso-8859-1?Q?dO1WAsCGcd2XPpeubZJmA15ucWjtf7gYN2kh1MIfykkpe2Gc+Vl/c8Dc/e?=
 =?iso-8859-1?Q?YET/UKOjdAmoteQyG6N7/IneHyNqvz+6Jn6p4Wp2EiQOC6ppzfynzN7QhG?=
 =?iso-8859-1?Q?9YMaC1HdgO0XynMZ8gq0kLs4PxIqmh4eVMjzbNO6lzrSOMkSXf+qJyQtXI?=
 =?iso-8859-1?Q?VDtR7Cbm2H8DCzjLO/LnyAQJAFjkrIJ3OdhDuySJZik4SlHwyag2iSMkH6?=
 =?iso-8859-1?Q?g90O1R0JM8Ld/HyHO7gR8w1q0zPDOyFeKZ0H8/h1zR/lXbGx94AujE2SjR?=
 =?iso-8859-1?Q?Y6cdb3ju8GsGWUZ/RixZEzS0O4ae2XqQw+3MJpZAk24GnTUDl5fjCcWxhb?=
 =?iso-8859-1?Q?OcYTIxPogYH2xFMP8JFIARIzfUrlaDVL0qv72ANr5/5IwePSREusJjx9KF?=
 =?iso-8859-1?Q?G9GNp02dpLLc+Xu2IdAEH7PH+0aKorzC0ggA0l9Wwax3YG/QYcO/XovJnc?=
 =?iso-8859-1?Q?zYnmT+bXRBHzVGxH+Z993tzqztQ5pmUOuaQ+n6q2LSHgWDFyHRRL0n6cC8?=
 =?iso-8859-1?Q?7FL3c+Bul0+/XrzBr8PcutmECWe31h0qy8mhorc1YZvD72Q1Le/jaxv5xm?=
 =?iso-8859-1?Q?fXeW8952fC35xN6K17HsBkI1xYxQAcstukAvENuqa+M5p5AhwUIuKCefNW?=
 =?iso-8859-1?Q?kk9IwvKhbyGcN9kv/F6xjFOHtawdAWuINNzv2oqymH0IynLA5Hu6/MGCJN?=
 =?iso-8859-1?Q?X3x4NIGxyCjv38nAyBg4Qyo4/WtTUJ+1bqiTwHKfkH9wkdw1y6AgE9vCe4?=
 =?iso-8859-1?Q?tBDtRdjVKOQj6Dvsd40gM7egpWzmSPOX10InLMSmq2rNykiMkste6AcOMz?=
 =?iso-8859-1?Q?I/RKah3NEmMqAD6aq0x71ETdaCKqEe72A2EqqFjlDDVgzrddQWCwLA+uez?=
 =?iso-8859-1?Q?1PAI6aryaDILMqDl+Icw5gLb+ljbHy2yykIcJRix5fcm8AfhT+Y6oRn2ws?=
 =?iso-8859-1?Q?jego3BRdsFM3GVX6jL9nUGNe0cSbnTWNfqOnU2jYeq4BEFbQqq0oSg00HY?=
 =?iso-8859-1?Q?5fWoSocKhACdZw3UUKnz7q0ra1aKB6eEutAYF44f+EteU60Mv1W4jsn5sL?=
 =?iso-8859-1?Q?lKTUjQq9IZ7CFav5HWX7xFybwJ+Q9UVxHh81eAwUEKYaaez+DtwxY1s/X/?=
 =?iso-8859-1?Q?RcnRBqZGVDZNgwtx5wWPtDzzdgX2o3GSD0C3GN1zBxXoNZRfjsJDnJAf29?=
 =?iso-8859-1?Q?4C+ICvWCxfeHfWYK2Bbnl/SqEeBpRkZlZQIg7Pb5wXMkc2wSqe/dKU5E5c?=
 =?iso-8859-1?Q?fpjebT1GPip+T8rjmkPxAn44LVdocLrVrv53hdoR1h9xhVBQkbpW4JzCEd?=
 =?iso-8859-1?Q?DUUB0wUBHL/zr8IrFazBjypV3R+jBs6j7OaEgBtyfLIYAjrvhCgVAlou06?=
 =?iso-8859-1?Q?RKHIEKzI4R+Kc+Mh/aCtyDGwDc8N30FOAkrVbIOGBk/uluwA5r2WtnSQXT?=
 =?iso-8859-1?Q?AP1T2G+biU+Xxjoo+JpcpFQfXM0ycN6wBAWZXUTYvSfkwYLbCzG7+zKG9X?=
 =?iso-8859-1?Q?E+IYkq8Dtw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba3ad20-4e53-4c78-44ca-08de63b853b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:46.2673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OcgUrz9eGWYr9Z9AXRgMXLe+vVJUIJp1m4j0xW4fMTJcnYBGy8n3nQTqddAANAkWre0DuW6Wx17FivQBr1ZYAtuaAWVGw7bYJkqUtTEkL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5901
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:22 -0500
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

The current AST2700 functional test forces PCIe2 enablement by manually=0A=
manipulating U-Boot env and FDT via the console. This sequence=0A=
interferes with test cases that rely on the default boot flow of the=0A=
image.=0A=
=0A=
Introduce a 'enable_pcie' parameter (defaulting to True) to both=0A=
'verify_openbmc_boot_start' and 'verify_openbmc_boot_and_login' methods.=0A=
This allow test cases to toggle the PCIe2 initialization sequence based=0A=
on their specific requirements without breaking standard boot tests.=0A=
=0A=
Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700.py | 9 +++++----=0A=
 1 file changed, 5 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functi=
onal/aarch64/test_aspeed_ast2700.py=0A=
index d7eeab9c23..cb1aafeb99 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py=0A=
@@ -65,13 +65,14 @@ def enable_ast2700_pcie2(self):=0A=
             'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=3D>')=
=0A=
         exec_command(self, 'bootm go')=0A=
 =0A=
-    def verify_openbmc_boot_start(self):=0A=
+    def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
-        self.enable_ast2700_pcie2()=0A=
+        if enable_pcie:=0A=
+            self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Linux version ')=0A=
 =0A=
-    def verify_openbmc_boot_and_login(self, name):=0A=
-        self.verify_openbmc_boot_start()=0A=
+    def verify_openbmc_boot_and_login(self, name, enable_pcie=3DTrue):=0A=
+        self.verify_openbmc_boot_start(enable_pcie)=0A=
 =0A=
         wait_for_console_pattern(self, f'{name} login:')=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
-- =0A=
2.43.0=0A=

