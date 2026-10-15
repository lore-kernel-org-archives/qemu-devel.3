Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDF0CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 05:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHETQ-0002MD-Cc; Thu, 15 Oct 2026 01:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESk-0001th-LZ; Thu, 15 Oct 2026 01:57:10 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESh-0003FP-RA; Thu, 15 Oct 2026 01:57:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKjYbx1V8TFExzXCm/v6ZlVtDbLwINvM2FdMiBKJENImqtjQQrEI7oCfwxBRTbU2whEJgdJK4lnqTAd1k5ZatrSKIpZ1yPs4Lgh6EhmYFXzHYn0IP2nXYZcnCwdGUHl/V7q5S/Vk6APQpSfDqtpyJmiL8aiGe5UZ8uhPtVHYL1T91u15Nfw/5CABXqTp8YnhgPFcLv6yPCEco6xl2sIfJtQw44DG8wh69T1Y06+WkCp2i6UwUtcRNStdI2Ov0ZBoeNK/8PGGUO/55xUSN6qFU1ZiIGkVa9XqR2Sj2Ascnlshm/OVGdZMvwxZkWiRPNiKWqOv09WA/YlxdadcVrmiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpGGxj6UJ4T85sjdzVf/5i3XssTI8f46hoqviwKev5U=;
 b=vT8oJHJjdsoJDymXeAySluoMd3eU64ebqtWtDh1Y+B3AoAiBDTj20TUjLK/6tKMDa34KheFv77r+cjgRM5byHDFJL2Tb6ClKEqVs67G8DBS6IfQeELhPYqvjwnJESF/Dvj5DetV2ho1eAbWE2IVlcCl9rvF+PpvtzK/K9Mo9pLvp0/bhAbQsjJACDopVf8OCncfS+q4PiaM+3G8RilwMLz96IjqGIrD1Xafy2e4Qlkau89qXEDHbOUKT2rlKy8Rt9+m8/J+lRX6uv+yA3c+EaoXHBkYLTmpC1Kym/qsWdJKax5CDTwYCYzT5vo5yoeX7IW7Ueao9Gd7/QuSEf9vs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpGGxj6UJ4T85sjdzVf/5i3XssTI8f46hoqviwKev5U=;
 b=aqh6JnlGbnsGb77paRKiEArHJ6+u4PHbuADYZDy46yGNj1P1D54Q2thhBr+Umx40QKY7GUijC0gPV/GpXSOXHo9WKmJy5HNPjiQu+/zhzUvZGR58zB9BEA9BJhOY8QLmUA0mJnsriRAP0h+DGN5ExhXXlRhWSEJKWxZNURxIZ2h59zmAAM1+x0td/iHp7u5KyCHCGF9+fcsGgw8i1MYQ9enS8WFnezLlmYnpiL1cg+bzF7A0TvaR/op0Vh4af6O3TFuNO0hMD8qiIzYs8/FsxSMW/eYxc/cEVcr4u9iqHU4pJedkadM0+6PzkWtEotkqtkBQjN+0Vhch724B8uoBKQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI4PR06MB8777.apcprd06.prod.outlook.com (2603:1096:4:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:57:04 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:57:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 13/14] tests/qtest/aspeed_smc: Add AST1040 SMC tests
Thread-Topic: [PATCH v1 13/14] tests/qtest/aspeed_smc: Add AST1040 SMC tests
Thread-Index: AQHdXGn94/jrF8J+p0idz1OAIC2Zbw==
Date: Thu, 15 Oct 2026 05:56:58 +0000
Message-ID: <20261015055642.106204-14-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI4PR06MB8777:EE_
x-ms-office365-filtering-correlation-id: e1bb3c3c-3b2b-4780-a571-08df2a812318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|56012099006|261009223027099003|921020|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: iLyXrp0RNeMSqTZ+Y2C4jVscucltpT3EMhxMiA4lsLFnMjO7YMrPwsQ3fsVgVpwGO9vAIbmoC/3PjxAsnxOk0AxvWTdwAKVJ+YTRVXZxANWGV+VQZRwnEvr0j9xJcdvjgupzWLvkv0oa7naS6/SKmvtUqlEw9Eek0mVzU9VOMbL4IQqm3jX4cVU7T50t7gmngHqP9EFAij5d7hrfAZ6xox7I7/N8GNkyHQ43gLXayVUtqfa47ILSfHB+tDeor+39lHZlo1ggT6NOnrQxLnMixaVctvd+FnIr0cz215IVLId6/rEMRO3GybDjsjcQreI6/Z0yL8CX7hx2I1uEwdtcK9Fe1zJKWsMFDQghCzNT64ZbksTpus70alg6n0TLL5Fd/m41fnJED+XFqDONnVHxVrAX54yAbwJhH8kSF6jFbR+pA5n25m5c2Ql7gF1w/dFC0Lo04E4VJuOBYMeBpdMyAHK27uhtMT+5kJgswsfweKC1aq8Hc3c0N1G3VOhvdQVN4NXnlfSAYFEKLGXCsUjnJC4BvuwsC4Gp7zTEdMcgoDiNuZGAw3MgvQv+LONNJmDUQc4+/kI5Q68kB29MUh5513FSVSm7RZAsVgOf1SYe2OoBO2y20WjE7dDi9M0ZyU+JuB61LVrevXKhqbfaI+yRHiWOScb400XDo4PuVTH/bkVK/pciuUYO+BH5/RYhpG4z5CAQIUPiLJI1LUh54EocRThDh4EUg8YUrzf4hMeBVTGx9Ds3YzgUPf8b9uF9hx9y
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(261009223027099003)(921020)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nCBVFNaZ+6W07aoQFfpxiZVNch7sn1TQW3rDQKIAEvd7vQB1d4uU6tjMzZ?=
 =?iso-8859-1?Q?LMfjabqhvoqs7iy2H2Snknu/hyP3uYm2412/TEot8zIi+V3IeTr8rTYC3Z?=
 =?iso-8859-1?Q?sDXegwFdpQ6b/0dNkWh8R2KGOhO3Zd4fCDtyI83sLu33rBu3Z2O7wq3LXG?=
 =?iso-8859-1?Q?hgBCcE79WDB/9OiFOeRlYSCJCbHugDm0DpyRGnMg6JbxhHDvVQm9Zm97w/?=
 =?iso-8859-1?Q?GrpkfIevWXyYejGsU6mAq8Eh2Ok2dVbMdcIsdjIpCWvTjIHFgI1tLn85up?=
 =?iso-8859-1?Q?Lpd7kBn4lEv5Q3j5rDNohKfTdFnn+O21v8WP4938/3uwFQ7TmaNgEyav22?=
 =?iso-8859-1?Q?hQd9+zg33ne/ko4YIA9fL+gkhrsQY6VUvYNH1CpSr8edKpoSljHpsfTQl+?=
 =?iso-8859-1?Q?W49UUi7mwRaNrBT4bnenuCjAScSJJpUMBZqxTM6yRFF7HFOHGvj+43AQAH?=
 =?iso-8859-1?Q?4fk7dLvPC32IylWUTNw2HIt70IgdQn1Eh4vg3nG/VTnJCBDQCMuOfOuxD/?=
 =?iso-8859-1?Q?nBLyCqwAJV5BEuSF2+lVr9KrScIfPvwy9yZb34gIU5tCifnvcdEh27N97V?=
 =?iso-8859-1?Q?WYarzS6c5T3MUkYQWhaZceMDyuFyQY+ceEsr9FV6ntnNGRgiVC3BIZ4tBK?=
 =?iso-8859-1?Q?4T6RYVahfgNxZXvGpoAIQrrbRaQyY3ceWeMGbt79OWQc17QlGk24prCr7x?=
 =?iso-8859-1?Q?wfuDc4Hnsrc3Mq0Dj3gDv/SoF6Sf0SgCrd64dWsSQnktlMw0irC2giCY8k?=
 =?iso-8859-1?Q?84XOcGiXYjffJO6EyOLdE5YJYCmEXu4oZ/oRGmJJxhHx6tbkX2tweagQZ2?=
 =?iso-8859-1?Q?wSCR7Tf6cfcv+2sENvGHYCJs0rc845g/sAxwIf40RYYxKkCY18lW7kDm/V?=
 =?iso-8859-1?Q?U9anJA7Z/vaqwr6mAsUD8VlnfNpK/IkK9KENO4DJiuGDNkuMk+NWXkmTr+?=
 =?iso-8859-1?Q?NJMUSGvIEhGP4xScfWeWA1qH3xtBmO+sMskVx2RHmnKeZnqGldEBx7/3C7?=
 =?iso-8859-1?Q?S3gKimqY8aWDx9e8hhtpBuZZpijXqEYbrdXyqP0nA9IxMQ0tWcCLV4FLGq?=
 =?iso-8859-1?Q?F2s0p/ijTkbHhR0BX0WZzNZus9XnitjAr4QSttkYRrwyffu4eYGq95AiUy?=
 =?iso-8859-1?Q?lbtL8+CPfXW8nA5fPwf3mQt68s59b03jBWDU/56mAtsxssXNucO6EVq9yY?=
 =?iso-8859-1?Q?EoQqvbhLiKvpPS1FvKZf0dlwwZILs1YEXkmxB7yGdFOrTZO6slEDNqCl9O?=
 =?iso-8859-1?Q?ASdplWxeCJkbQGttKjmdL8uch0gKJC6MaYF6OrgNot5aDYdSxNDYLQMcQV?=
 =?iso-8859-1?Q?KL3O2+NhY1eOys0O6+AUSDypp0dj0W3UpSs45Do/nlMmsL9rrGZCpvQ5ff?=
 =?iso-8859-1?Q?4eA0Z/zfEm4URd+ByfO8Q8kLtBPAtAk3TzND1SORvTRcvj3zb39NLE9Lq0?=
 =?iso-8859-1?Q?DwZt1dEDkfDg6qKAs4T0HWd8DcEvPpx9zOoIcKBUX+63FqB+lrk++CjJ0F?=
 =?iso-8859-1?Q?elDE5nvGZBnLxKsz7FKqKfwgkhc7883hDedHeiutCB3MlDNdUczoa399QZ?=
 =?iso-8859-1?Q?7ZduawQ4sfuTh+XiSOLPN6D3fpNF1mJj/pUhf6Y/790f1S07mDygZik5b+?=
 =?iso-8859-1?Q?Dy0FyIrChI04cEwi/87rvtiS1+KpjHeKZsWURuYry8eexpYwYL3Pcmh2i4?=
 =?iso-8859-1?Q?D5IXfwiyXrm2SSqtg6fBnzYbYJ4ZlVJNQs3VlrrCqbZnTz0XFLw1aUKLMd?=
 =?iso-8859-1?Q?AR1PDVvwigBZfWh6z/mREzTPmaSI92D/vgxM/QLzKMjP+cY2C+vOBs3yhw?=
 =?iso-8859-1?Q?6e1l2vEGlg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: glQw0uk0g0t2JJjllBSepPLlh9uXX7eCN7vaKOmMt8htOCVrIV/UAoGp+tkISiu0nsIgOyyX2ULoHDFchJfe+588E9JWPwIep2Q9YWz0+YalIN5nit6QL/HRlCB1/AoyAQa0kgTUd1jRm6LMCU29TcdU4KzKgK6uAqS8XFt3UpE5lv//ii9zV+C+tFBT8jNP9ggVUw5QygmpCow78SQkXPcl/DD9qM/rzEHaNM4Ye+4Vjlhy06VgbSDggv1hKybgKZoHW0Ps7p0At6BGNY6UA/5wGBDf6IN99X+/ebFIkLYy4OjKVSnOwY29p4A5oYVVZ1OhDjptOTYd8fDcTcoZ/w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bb3c3c-3b2b-4780-a571-08df2a812318
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:58.1313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udMwlCBrtBv/Cs8b7jyWOQmOHMxmH8nXJ53eGbTbeE9LPVQkMjtw0S8PNSkea1/dp56MI5bMOxZ02rzgnU2pICxm5jKm4hccqKPtXPXBbgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8777
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

