Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F79E67A70
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 06:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxJQ4-0004w5-MU; Tue, 03 Mar 2026 01:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJQ0-0004v7-Al; Tue, 03 Mar 2026 01:39:44 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxJPy-0005qP-QD; Tue, 03 Mar 2026 01:39:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBJ1Nq+44v+fLY3kMUvnRJsVNd4JNvZp54jXQXsooznF+2DAlR6Vf8Be8GdUlxlWv2yHWRZ7sspPG9KRpvGxG4k+8S9jPk0M5lsSY2wl3pO2olRw3VNkJppVyGIEpDeXQQJVDN3uXtDO6P4Kr/Ud77++jwJyD3spiFjK5o9e9H6n4EHPq9xB4+Yhw+7kLszdQyesd2YiUs0+XHRb0GKhbWxT/vy2QhPLeDbffK1HE0S5SWDR4d1ugDjVcfZzWhFaDNKkSwun66hk0fwAE2dmZKibzbF4XI7xhUtVoX/WPEe8FKWR/HrlP9y8aeNVeiMQ0ZDF6aqe8VYVSeSD8VXmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycYRALu1JH6hsy+4RlhIofVAvgmnbgCvNWCI8voFiuA=;
 b=QsgbOhASEuCv8sVZccIQbuIsebfngyXmTaG5eW8kuY1abpQ0UXTSh2jTxlPlFGnA8/fDnoOJgmBxq9Nm1inboQDC8PizZqTyelj7IgwMI4PK3jXyo5oLXc2eXEsamoonwI87CA+naor4MmaUvAHKm9omPgxc60rPosRJ4zdg7y+EPRER7dVdBxCsJCKSIUR8bBKIh75KsBkxqv2SrmtlDTY1/fCJoTctWmvNIdulgV+BOgTXOHgfuAPvbnF4wZrvHdBYI0KqZF6IkKjYfkubGCHiFxK1y8FW6a/BoPD5joBB3KYr/+M2reVpkoAL1Qbsrx/u7cGlQw0ySJ5rhr+6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycYRALu1JH6hsy+4RlhIofVAvgmnbgCvNWCI8voFiuA=;
 b=J6Et7qkmH0SpHP0L/egI445iX5/A3QVgFgRzDCBNYOg3GlI9sVq+vBRaW31u5xwmocm7mLjqwnVKKln/y295D8TA/HVm31Z1Qzu/90c83BMPHpMuxDd3A5EZeI0TuHfjFcPK6nBqmHZ2Ov3FVjIIJIvkWNcjqUnyFi+Olu0pQVEPPnzcp5G9D7UnEXT+UxRtc9jchuB2u46Eh88X2YgT+7cDI69x8dbMD5DaWlY7Vc21QMbvX9xbuUTR5Yn+0e3ic7joYbSTX8K5XIOk/oBlaOuihrU48RmWd0zMwuuiMheetIBIJrkj6mCqVSB/VkU53Gw85JS7JviV870VPUFBkg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:39:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:39:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v2 01/10] tests/functional/arm/test_aspeed_ast1030: Update
 test ASPEED Zephyr SDK v03.06
Thread-Topic: [PATCH v2 01/10] tests/functional/arm/test_aspeed_ast1030:
 Update test ASPEED Zephyr SDK v03.06
Thread-Index: AQHcqth/eZQhRV7b40eJT1y3uOF84g==
Date: Tue, 3 Mar 2026 06:39:33 +0000
Message-ID: <20260303063930.2878300-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 6c4d061d-1a55-4e4a-f71d-08de78efa1a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: MKnnGF2W6RBjMYIpJkRYqFQJ7I5mlGJQIOtX/xhd4uwgt3wkG7dMpKofBjIOiDYAK/0j4xXexKMuA2m7lGmUfsj7a5KpSMeAN+O8yrGh4gd3mnqT4pkXmXPBYA/V7SIrCgjEd1B9wlqwj7Udgn9/PcdMgA9mFg83cx4771oPhWUHf3h+ZJXW74k8WWneUD1dRJsiR8fgSa+yjduPcJwgptnYyfiDtZ8h3pbQvDYG9MKUvb3JiE2WBjO6zyTmzirWM45q9lrkfVI7aVM4Kw0W/JRyxO6cEkCSPMn5EKFsnkikDpW2O6K0BqtbZ4JXm4w/VN4uBRKT3EkLL8TNvXSqe26XbFCPxeh0OhCoBI0xubNaAdWWP3Bf+IfH824tPhuDInzMqk/kJqKgPBLVIHXsg5HDyLva6Dp3nOzOXeBCzYt5Kq09KiZkXgO2wlLxHk3CLWxP2gwohYfzU+JCY5qoHgRYiuPwlH0F9ad/mMxze2W03XXCaAA7+S9cXRc/BN5DmV4tqVhsvM6SmUXAP3EkXgaNwcgdDVwjvtZ4YQJMmhxYH5EwE+xJFFEUiuPcB5EMig8BMu6aG1kYE99yTJg1AXXUzwAXPesr6N7E7v2eUEDyUvZJ8McDcHW4E5wTYb/P3CIcvhAf9ZfbXHlDfl1eottLP7yRJj1j1TDFgYZETDGOMEndplM6zxZb8kHtRoz2zOVN0aH2JyH3dqVeRwTCxrGNWA1pep5kq0tWoKT+NhgRyLcRHF4Ekeh6CQkNZvzo5nDf3Sp6wp4cboQX2rf4eisL7OFYPthv4IK2/zh0Gyc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hkx5M60LwSxSY485qCqwRi8MwcHcxbVH++J3lXqTzkoaV+V9i0GQe04yp+?=
 =?iso-8859-1?Q?RLP5b0+TidI5UCYZRtfDGFU7sbVInBSdynjRA9ql3bhL6ffwvlUXb0BW0K?=
 =?iso-8859-1?Q?wmEgCt3af4AahATBx0KYywh9s3uud2gmISgxwJ8PPdUUBd/AU1PdufqhTi?=
 =?iso-8859-1?Q?ezkqIptbMLmPuSCu1gxHIVPdCamFM3jt6Oi2DhrKiIk8mO3A2C7ixXRf6J?=
 =?iso-8859-1?Q?SkjP8ztL+RT6hOJLuEpza0a+4QM7yX3VzPZsYi/GBcBOZp59gOYeFHscPs?=
 =?iso-8859-1?Q?QqPI288WT8jUlIaF1CzXxgIADNcUuCx201qFaj2FrL6rby1iTkdQV2SJqA?=
 =?iso-8859-1?Q?Nt3BTIuGPG28Ei8IasM8hbrgTKCQK5HyLUJU0ImythPbaRTgwaaj7jj3ZI?=
 =?iso-8859-1?Q?Ifh+ZC0j0LohVryK25uKgg5KQHmh8BCjaa5Ohx9gMGK2LRRRYdwJxqcm+2?=
 =?iso-8859-1?Q?N0JX6OPvR99TPMrR4RqtWlzHADuY7SmFp8p7ULFp9dJ/4xafOMLBwHqd46?=
 =?iso-8859-1?Q?PYNvoeLJUb7R9w1Y0Lv8O64BXipPz22EFqhq4nOxTj6tEkxU2ZtzbQD7zf?=
 =?iso-8859-1?Q?YRc+DIZAl6vIVabU8Q6eVUywfwTzoQ9wmBR3feRTmH7ZBFBt+CgDrDydoJ?=
 =?iso-8859-1?Q?MABSxac9Ge851ycy2LYPxbZ8OIofXmJHx+n+fQ5PfPVFW4vflp8iwPifwx?=
 =?iso-8859-1?Q?iSR1lroFExrOvAw3P3Mt+p1ZPFmUIpoGgwnxmH4X5PP9Ta866UCE3n/9y/?=
 =?iso-8859-1?Q?hnHha+ZV7Hz7AH85qnweZpioGbSb2RSkwh/pbHV2QINvPIXitLGXpQHcms?=
 =?iso-8859-1?Q?84nAmYJWwYq584npL+F/418xDuUh4iw3nvPvDhAW4E3smkOr6X5LzSm706?=
 =?iso-8859-1?Q?326bM/pit5coveEn134StuUuxrJdWV5//vm9ior1iwkIlz5ZVxzm1Kn9zK?=
 =?iso-8859-1?Q?UGVSNOB2KTv/orcoBUKEHJBI0D8Ip9LzYRjnWxvl33tYF566A3IjchPvOy?=
 =?iso-8859-1?Q?CTiXKK5KD8O2oXqWUlBXOlBRRRjdCoGO42zJPc+5aRvXFlQMOiMIfZW4iJ?=
 =?iso-8859-1?Q?zWvGWruz4AOAiMPIg+dYATz98m4T2nU+8enc64UY5fbKIG4LUy2ky0AMdb?=
 =?iso-8859-1?Q?jzX63eTGmJEA3APoSWrAFVWFAFTbclxGwrLUwGc1SezSEMDP59JPVXKDIH?=
 =?iso-8859-1?Q?4wNOQIXyAY6pXZngaSk3AlTdEKy7jy1iHCLeMlFUWYHMEJvn1vOUq0A4O3?=
 =?iso-8859-1?Q?UjixWTkIB7YdLxAN2tqGEvtNJkcwnEJs7NPzHLjKVL8tTpHefUgxYfKyk2?=
 =?iso-8859-1?Q?RefZcYxs3snA64wh4+d2Tw0HgJhsT6pKcaqDRaBt2+oocBkcrKY2h9iEXm?=
 =?iso-8859-1?Q?BYcM/LNbE4fgMz9w/dOwxFUOsK4qsvj+TnCNy/dyG94um/VoXA+xZ+KN5j?=
 =?iso-8859-1?Q?gYMeaR1wdDhfnAw8qF0zyORrWeY0zcIuiTFzJEQAdm0fiUxbiRByk3H/sS?=
 =?iso-8859-1?Q?4fvG9Fk3CZSqAeEcu2p8nevdOi0gPUGG/kpcPwliEznMfjLoLQvUj1RBqG?=
 =?iso-8859-1?Q?TtsGOrPVAgrYxo6D2hlQCQLFhZTFvP8DN2Qn97BHqYp0L12fvQuJkQxkMV?=
 =?iso-8859-1?Q?AvK+KVRd/j6TAuiq7j4eS5axSljx4pw24FASphZKv0rebCzOSYF+zCV37k?=
 =?iso-8859-1?Q?bo5dwgwBSo0YgJjBzLW6FHQSqRU8L0XZ7ihpZP8r1c0vmz0Ywfj088tMfa?=
 =?iso-8859-1?Q?PeBSsso947IHpNpFyN3jNyTFvp4yFZfmmtNESEZjdz2T5TBlQ3Mjo22BLt?=
 =?iso-8859-1?Q?sdGhesgo6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4d061d-1a55-4e4a-f71d-08de78efa1a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 06:39:33.6896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKtPHjTMvHu8nb2OKBmNGFssup8O9u84X/O2nb0SejMBa9gWWbJ2onUdhgvB3rGHjRHvqeTmFkj1Zhy8S5ps3PJNnRej0tSsRjo4b1U1DEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
 tests/functional/arm/test_aspeed_ast1030.py | 12 ++++++------=0A=
 1 file changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast1030.py b/tests/functional=
/arm/test_aspeed_ast1030.py=0A=
index 0defa7c38e..03fee55b5f 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast1030.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast1030.py=0A=
@@ -12,17 +12,17 @@=0A=
 =0A=
 class AST1030Machine(AspeedTest):=0A=
 =0A=
-    ASSET_ZEPHYR_3_05 =3D Asset(=0A=
+    ASSET_ZEPHYR_3_06 =3D Asset(=0A=
         ('https://github.com/AspeedTech-BMC'=0A=
-         '/zephyr/releases/download/v00.03.05/ast1030-evb-demo.zip'),=0A=
-         '057528d343490b1fbb5a721e91084b4f04fec60dc114bd65e724554f9c217f4b=
')=0A=
+         '/zephyr/releases/download/v00.03.06/ast1030-evb-demo.zip'),=0A=
+         '056f37fcd9f165308cedca3a08f2bed37ed40c0a1402c4fa515613b80a369f38=
')=0A=
 =0A=
-    def test_arm_ast1030_zephyros_3_05(self):=0A=
+    def test_arm_ast1030_zephyros_3_06(self):=0A=
         self.set_machine('ast1030-evb')=0A=
 =0A=
         kernel_name =3D "ast1030-evb-demo/zephyr.elf"=0A=
         kernel_file =3D self.archive_extract(=0A=
-            self.ASSET_ZEPHYR_3_05, member=3Dkernel_name)=0A=
+            self.ASSET_ZEPHYR_3_06, member=3Dkernel_name)=0A=
 =0A=
         self.vm.set_console()=0A=
         self.vm.add_args('-kernel', kernel_file, '-nographic')=0A=
@@ -72,7 +72,7 @@ def test_arm_ast1030_otp_blockdev_device(self):=0A=
         self.vm.set_machine("ast1030-evb")=0A=
 =0A=
         kernel_name =3D "ast1030-evb-demo/zephyr.elf"=0A=
-        kernel_file =3D self.archive_extract(self.ASSET_ZEPHYR_3_05,=0A=
+        kernel_file =3D self.archive_extract(self.ASSET_ZEPHYR_3_06,=0A=
                                            member=3Dkernel_name)=0A=
         otp_img =3D self.generate_otpmem_image()=0A=
 =0A=
-- =0A=
2.43.0=0A=

