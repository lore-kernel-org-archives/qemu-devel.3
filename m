Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDABE606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=pNKrPyc7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtTt-000562-Ny; Tue, 27 Oct 2026 22:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSn-0004SM-LU; Tue, 27 Oct 2026 22:32:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSl-00082z-K8; Tue, 27 Oct 2026 22:32:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSmztUT0X7r3DAac7iavMxddNDbC93rPfXmGr/RXkuPv7lT+Z8QAngKIOCg6sy2wTfbZv064IjWFqOwz5HsQUfE8INC6/CLnvAez5Tt5siZVR4hXjOdXDY+pqFZWbm7TzDgxEcDqDuuir5xYfiD5B5gWrkc29Cn6AEhSsefbXnqb54ciU8UWm/6mADHOwRfR1GopLxcbNwhKHwST9fr/gpZI+AXuLbvI09qQI7ommiAiFpJdIxzcvKHGOmXugfcL7LBm7PMvhCENpN71o3k6bNSAz6Jbn7p3dyBAVswTZ8byFEfUgMHKTrQYMTKTGgV1xcsuSuUICbbHS1O+1MO1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpGGxj6UJ4T85sjdzVf/5i3XssTI8f46hoqviwKev5U=;
 b=edWRiG789jF0W9ONDz9ubR5Lk1PlmKCg2im1v5i1xc8uBgSPYB6YFMeptEVBeCaernrawfVaOQIUUrM1zO1FqHcJA4xQyAQBH9PhAkKDhYf91wLKmFctrTPKZ1RBtSw0qzQKzdRgJ1PYfOUejWRI4DWCwJAxHZAXU+lFrgtiIGHv0TlvHLvZbtcN/mTuKUF9cnVQyXCJyO/+aPs4El59pA1brBXRQb7SGzY8l8qEKD+CEcUqhILVl3CnMOBTuxMTtrmtAnsH887DgRa+I7TScRklUCYa/uarKj6BKKpxLJuYImiFky+kVLl8oIKgrIMfcFBUvvrFDK00XBo917mwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpGGxj6UJ4T85sjdzVf/5i3XssTI8f46hoqviwKev5U=;
 b=pNKrPyc700Xxq/q4e404TUAPIWYXrumenG+cP9wdVHX01u90ljwejVKUI6PoXTJTvwnDcnWiDeo/2GI1K3qUpjCKuxVISL7PVaQOkyxjSgm2OtZ/e57+I1Byk8Dv3kDfggn2OR4Z8VDrZ0RgBXT4iPqw4ixi9lxZow4+BbDEYgqABtOfpTflqGLce/pgjJUQY5J1CQUZ46mYKxT3BJlZbw77meTaT2EWjrRdVOUnbD9Eak2IjI/P+feeARKbDBI6RWZmdFUAr1ZqFUaoTjlrEX4FLpMlxZ5rpTkgAIgWQHo6uj2waJoAbr44INVZuMZPFymXiUl9Jf5QtXOvnWZFIQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY8PR06MB9103.apcprd06.prod.outlook.com (2603:1096:405:3ac::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:32:07 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:32:07 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 12/13] tests/qtest/aspeed_smc: Add AST1040 SMC tests
Thread-Topic: [PATCH v2 12/13] tests/qtest/aspeed_smc: Add AST1040 SMC tests
Thread-Index: AQHdZoSG+8pgnb0LRkqhEzjjcy7+1Q==
Date: Wed, 28 Oct 2026 02:32:07 +0000
Message-ID: <20261028023154.48395-13-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY8PR06MB9103:EE_
x-ms-office365-filtering-correlation-id: 535039d1-e343-4edf-788c-08df349ba95a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|921020|38070700021|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: FAD8OZH6b253sJAeo7lnI5lmIrcDtfkSim9ouZq2tU3cQzfiWBsjx+xq2xU6XNObWuEaSooKP2RQtaf8wrXz9sff3R/h0pMTfc9/IX1CyajhCHn9PvfbipEquQCiFvj0HZv65s0KyzGa2Xwa4eddPgDGQtWkusjGcP1mGcn+eHQeyT8AtBerzAyqYPCM1L3VNNcP7U9fyHCJcUh57wTww21F7kYpF4WczzylEU9VzR4RO6mxQ0vVA1N0IzAOqZYaQDSIAXWJRBaNRAfjBSXEdne5L7GDJFFjB4+1YLA0tfMDpFau1qAVmd6VD1Q7KmKY7MmOVYZcLkOy+bfx8mqb257AgX2UfYJZ1pfc24gpWT3bQ6nTjujvtH0B2c0vhhxexk/2z8mY5DQVUBq5gzailhl/UaQN8idzjGSxcPE6654oPYQuay/uZD4+2PwzqBmCkoKYwpF1fV9O3LlMtbl5x0vHMtdhj92w6+Z4nMnK+7U7na2HeYqs+GgoZJ2K5ODrbSJQ7Vvnxd/G7SRLNmD5GnHueqfWVSx/jbP6dQKRaqGGHGUc7wTch6iWDX0y5JSoYMar87ORe/M1BuPRi6/4SHBQiib9o2Vt4X16htqDu/zuSCacNe+aI2k5zfqDxnKJh4sbTrPZnBfsVVB6bUMvOecyTwWoy12lvRznHuMEjUwtAeX2oQQWZTMsYGHbIOPjeg+dG52M09Ao3MOjgTpU1rgQ/ovRKORAoY7yycNDLOeNW1pPoVIgHzfQoFI15tyS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ynvxhrQUSZ7YSn7uqcdPLwMTaw2SYIT5CAQ0Wz0RW07zB6lK98txlsWzeE?=
 =?iso-8859-1?Q?nmJU+ypom59zzEMI/5AZelOChnHeezevuWoPAp0waw13Ezw5woeCSzmHKu?=
 =?iso-8859-1?Q?RZrTIWSGH9zeso/TV70d57H2QqrrR8303yChts8sTY3BKz+kCqUgSDndo2?=
 =?iso-8859-1?Q?8dGce67Fj5hhjKLShjCOnpaoG3vspKeHy3yRgatAhcfQYS04oH9/e0c1zS?=
 =?iso-8859-1?Q?rlOxm71gsOlcNowSGqcooz/UIKT1f3oXdK2UY+NLgCvfmx6aUNcF+55C+B?=
 =?iso-8859-1?Q?DuhiZ0H1LnBy6VLpuH6MtPlMlWT7jCzCcfeblj/FdboaYDqSmL4rYtA6Fq?=
 =?iso-8859-1?Q?8aFV+HmLZKjQnZbSchxjwupbvRGhHMj+g7VgHexx8rbsc+bjK9dVCuEk3p?=
 =?iso-8859-1?Q?I5qFBF11WciqaePmLmcinMUjWiQkoI0Z0moVsh3idjX4/I+7L1c5zW1Oa7?=
 =?iso-8859-1?Q?D3B1NzBCYoUsQC1dXhDEbD315woZ/nGJs9L+moFkmGddU2DWC8N6k2XM6u?=
 =?iso-8859-1?Q?58rrDn+VaF6Sn8Vqkl1Knoz4jccnCHYmGCYKUbTyt8vyvZgBPSVTz4FBJi?=
 =?iso-8859-1?Q?+xbVVbGQAixKVdCU9sLpXcpR/qZ0J/At0jpcvr1evW0it6EZnZokXw/ywa?=
 =?iso-8859-1?Q?o0HLW2Zox2JUFMFZWRD+USp/lRM614XfKIgA7a056xywevUEjEkkYsdpSU?=
 =?iso-8859-1?Q?ZY23ULhEwwQ2h7/NGJRANFxlc/GxGvYdyVskNmlO8flqWT42QxQm55ZO5V?=
 =?iso-8859-1?Q?83crp3d2c3GgfcUM6gR7ms5R+9EjxwBrH+vqCcO0A9XticYtGdfkPjRl2y?=
 =?iso-8859-1?Q?5AgZXvQ7EXuGU+GgJOZgyznG4D8Ssk0p2oFq87XJn2/OAUuina3vU6scJa?=
 =?iso-8859-1?Q?y11Zjtm21ETw2QaIbduHIFxykmAsHaaHwTg4hOEjhc4n0N3PcVwVB9ptzC?=
 =?iso-8859-1?Q?s3vRLtxxQvbhaIbqpguVTcwzqlgroSPMSFd2ehthcwZmGLgsu+1fFl9puW?=
 =?iso-8859-1?Q?uxLmea3cFYLy2qm9bz4uidcMLy1qVI5aM5hE/QOanT9+k7yf1+f7gYm4cQ?=
 =?iso-8859-1?Q?DmxkuzWXrLeZ5hrb91v0mu4xzMqd65PF2LtG/jsXjiOHEx4DRUA20s+zkd?=
 =?iso-8859-1?Q?Qz0Lpv4hHoIl1XeZqwBUrqVg1axrmreWGDK9wkIBnb52y/Le0BUw1gcyNO?=
 =?iso-8859-1?Q?fwV+M4LnB0ZmKW0JKUs7Uz2T7cCJx8AM2AXzDJgD7Bcwb9j6DKW6Mb7rkm?=
 =?iso-8859-1?Q?7eP1ELKdq6GU9WCwkC1IHqO1guZePu2dSK+lmc/QOoqZq70iQmUSw1hC0x?=
 =?iso-8859-1?Q?QKdtAliqT/mASpWJ4BKHZhlZXJ38LC4jfDRiQ24FFuLjPf6pCO8FMlERlH?=
 =?iso-8859-1?Q?sNoYGgHvuvCjJHJdJhcnqihOMjldsTVH4R+J7450W1QfG6jxJKJ88+Tw7N?=
 =?iso-8859-1?Q?9MG0fzZsWOEV9rJsYsztpZ4oSZxdZ6n99SLThY1vDmy7QMBkjJHduUukDy?=
 =?iso-8859-1?Q?RgdM9dRBnH4gEwmwD88GPkgISRZQuS0cj7SGh0ehZbDCmZl5O/2rKPHGnc?=
 =?iso-8859-1?Q?OxAa3V/9uBdDwxU1tBh3OmnnYgIcbTXAdKkPK6gP8Hi5io7T9oPh1sXmLh?=
 =?iso-8859-1?Q?eEc97zXsUXdyZbKtCBPaCjrQOUpz+mlN+DGp5IuUfapp2I3PnYRw3OKp+W?=
 =?iso-8859-1?Q?AvE8DI2Eyn1aTgLPPRS6nczIXrp2jdZIO09tcZrlaGPSvM4ls94Tvflt0b?=
 =?iso-8859-1?Q?7XRwensWEjedaR2yCf6pHz/TAlpeVNHyjtNDYrzupOaPdmkXY5Rw0BgMke?=
 =?iso-8859-1?Q?ieyB6cU78w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535039d1-e343-4edf-788c-08df349ba95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:32:07.5524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5EMphGxbNRRsXoZdurIMc9JytsJfHN1ceM10CJ4pL7X17ictHVc34zM6UydE4TMVpOxIiux+lOjlXoX3etgFtTLtnaqiRmHBkbrvBJ5GPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR06MB9103
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SMC qtests for the AST1040 EVB using a 4 MiB W25Q33PW flash=0A=
connected to FMC CS0.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed_smc-test.c | 61 +++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 61 insertions(+)=0A=
=0A=
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c=
=0A=
index 59c96bd68a..34010e283f 100644=0A=
--- a/tests/qtest/aspeed_smc-test.c=0A=
+++ b/tests/qtest/aspeed_smc-test.c=0A=
@@ -240,12 +240,69 @@ static void test_ast1030_evb(AspeedSMCTestData *data)=
=0A=
                         data, aspeed_smc_test_write_page_qor);=0A=
 }=0A=
 =0A=
+static void test_ast1040_evb(AspeedSMCTestData *data)=0A=
+{=0A=
+    int ret;=0A=
+    int fd;=0A=
+=0A=
+    fd =3D g_file_open_tmp("qtest.m25p80.w25q33pw.XXXXXX",=0A=
+                         &data->tmp_path, NULL);=0A=
+    g_assert(fd >=3D 0);=0A=
+    ret =3D ftruncate(fd, 4 * 1024 * 1024);=0A=
+    g_assert(ret =3D=3D 0);=0A=
+    close(fd);=0A=
+=0A=
+    data->s =3D qtest_initf("-machine ast1040-evb "=0A=
+                          "-device w25q33pw,bus=3Dssi.0,cs=3D0x0,drive=3Df=
mc0 "=0A=
+                          "-blockdev node-name=3Dfmc0,driver=3Dfile,filena=
me=3D%s",=0A=
+                          data->tmp_path);=0A=
+=0A=
+    /* fmc cs0 with w25q33pw flash */=0A=
+    data->flash_base =3D 0x80000000;=0A=
+    data->spi_base =3D 0x74000000;=0A=
+    data->jedec_id =3D 0xef6016;=0A=
+    data->cs =3D 0;=0A=
+    data->node =3D "/machine/soc/fmc/ssi.0/child[0]";=0A=
+    /* beyond 512KB */=0A=
+    data->page_addr =3D 0x800 * FLASH_PAGE_SIZE;=0A=
+=0A=
+    qtest_add_data_func("/ast1040/smc/read_jedec",=0A=
+                        data, aspeed_smc_test_read_jedec);=0A=
+    qtest_add_data_func("/ast1040/smc/erase_sector",=0A=
+                        data, aspeed_smc_test_erase_sector);=0A=
+    qtest_add_data_func("/ast1040/smc/erase_all",=0A=
+                        data, aspeed_smc_test_erase_all);=0A=
+    qtest_add_data_func("/ast1040/smc/write_page",=0A=
+                        data, aspeed_smc_test_write_page);=0A=
+    qtest_add_data_func("/ast1040/smc/read_page_mem",=0A=
+                        data, aspeed_smc_test_read_page_mem);=0A=
+    qtest_add_data_func("/ast1040/smc/write_page_mem",=0A=
+                        data, aspeed_smc_test_write_page_mem);=0A=
+    qtest_add_data_func("/ast1040/smc/read_status_reg",=0A=
+                        data, aspeed_smc_test_read_status_reg);=0A=
+    qtest_add_data_func("/ast1040/smc/write_page_qpi",=0A=
+                        data, aspeed_smc_test_write_page_qpi);=0A=
+    qtest_add_data_func("/ast1040/smc/read_page_mem_fast_read",=0A=
+                        data, aspeed_smc_test_read_page_mem_fast_read);=0A=
+    qtest_add_data_func("/ast1040/smc/write_page_fast_read",=0A=
+                        data, aspeed_smc_test_write_page_fast_read);=0A=
+    qtest_add_data_func("/ast1040/smc/read_page_mem_dor",=0A=
+                        data, aspeed_smc_test_read_page_mem_dor);=0A=
+    qtest_add_data_func("/ast1040/smc/write_page_dor",=0A=
+                        data, aspeed_smc_test_write_page_dor);=0A=
+    qtest_add_data_func("/ast1040/smc/read_page_mem_qor",=0A=
+                        data, aspeed_smc_test_read_page_mem_qor);=0A=
+    qtest_add_data_func("/ast1040/smc/write_page_qor",=0A=
+                        data, aspeed_smc_test_write_page_qor);=0A=
+}=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
     AspeedSMCTestData palmetto_data;=0A=
     AspeedSMCTestData ast2500_evb_data;=0A=
     AspeedSMCTestData ast2600_evb_data;=0A=
     AspeedSMCTestData ast1030_evb_data;=0A=
+    AspeedSMCTestData ast1040_evb_data;=0A=
     int ret;=0A=
 =0A=
     g_test_init(&argc, &argv, NULL);=0A=
@@ -254,20 +311,24 @@ int main(int argc, char **argv)=0A=
     test_ast2500_evb(&ast2500_evb_data);=0A=
     test_ast2600_evb(&ast2600_evb_data);=0A=
     test_ast1030_evb(&ast1030_evb_data);=0A=
+    test_ast1040_evb(&ast1040_evb_data);=0A=
     ret =3D g_test_run();=0A=
 =0A=
     qtest_quit(palmetto_data.s);=0A=
     qtest_quit(ast2500_evb_data.s);=0A=
     qtest_quit(ast2600_evb_data.s);=0A=
     qtest_quit(ast1030_evb_data.s);=0A=
+    qtest_quit(ast1040_evb_data.s);=0A=
     unlink(palmetto_data.tmp_path);=0A=
     unlink(ast2500_evb_data.tmp_path);=0A=
     unlink(ast2600_evb_data.tmp_path);=0A=
     unlink(ast1030_evb_data.tmp_path);=0A=
+    unlink(ast1040_evb_data.tmp_path);=0A=
     g_free(palmetto_data.tmp_path);=0A=
     g_free(ast2500_evb_data.tmp_path);=0A=
     g_free(ast2600_evb_data.tmp_path);=0A=
     g_free(ast1030_evb_data.tmp_path);=0A=
+    g_free(ast1040_evb_data.tmp_path);=0A=
 =0A=
     return ret;=0A=
 }=0A=
-- =0A=
2.53.0=0A=

