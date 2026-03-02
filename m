Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447CCD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzEp-0000Mu-EG; Mon, 02 Mar 2026 04:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEl-0000Kt-RT; Mon, 02 Mar 2026 04:06:48 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vwzEj-0005XC-NC; Mon, 02 Mar 2026 04:06:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ1rqiIrq9WSAxclCnqsNETfVlg3g+E2HzQ3PUBDyXsUustmS/xC33W/0TmMThYxZgyV6oPjuxD1sqj7+VaDCnAFrV2Byd0tnoLNH4mKwVyBi0D2sec8i3o1XimE8tPn7SsldAAPtYXJ6pMG+4de+AV3XAkvQkNP6RqzVW4FohnMSopGwTPsYBLWu9sKEcKhMDaqH52xTTDqVcLykjUOIFWWAkMrfDbmnN0coyi1Nh5GM+6DqtR3fUkoaRd54fLfP/e1SNNztFB5uGwzH6ZfMB1vLEQ4WpdLO1a9fX2WqmUIg1do0Q+cqMW4oCG+I/34MZ+yzLFEdOtuAN3yUZYacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5R8c5l4tGSYd8JDGr7SW49obQ35y2ZyZ0B4QsopG/A=;
 b=s805fRx3mLJdwdwrqSpeEFTmq6QEsJbIgMP+vvrQeAS52QHFPmRaDfK4obSWDEAwHRG/b6mX51ATcQCXBM/nndKrWFbgGeVnjdxZZ7OYb/iYFITv3lIRa8CVVYy8pjTkscV0Vwo3Dxu/f/vnbyy03tUGgapCnY5QykA/iD6aaBtVMw82QsH0PAwkrEqL9szdF5nz4VQWT/L9uTWJar7Cc3E4gBCtmPmNES+vpErm8+ZqtbIxDlT2fKGudqpFNu7SEWGzbwNRv+k6ZiI8Y7xuFtYbCbtDlFiftBGrDeDIl7jgpLNHjLqx6TVug7E8OGs+VI65afMCnFcAmr3g78JfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5R8c5l4tGSYd8JDGr7SW49obQ35y2ZyZ0B4QsopG/A=;
 b=dg6epqFRHHpdhwcpeu62kyZh2e0R3czN3imo5soArI6elim8ZXQfxLAlyg8mRUtMI7pnwfb93A9HBN2z6d1dAhiUnggyrb8RMnW2PyQjt7tdsyP1mbuyGblvtDeRRz7qXG6Hd92ca8VH4kKF1TVUgMLKW9odUq/NRYcctWO1KnpzMiroWhvW7Gdv70UxB8HI3AWuy7xHmEDyzzKSzuqyRr9GWjaW7nsQEgQMNtEu1tNHqsmqMDVBvZVSqibzvP3CF4ex8giM8LBYthC0VNmh+OIkgsJ64/KXYOdDG82rKnox5Ov6KCUFGETIZ9JUeY/SxG+vQH0mrpAhjLDGQC8mlA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6134.apcprd06.prod.outlook.com (2603:1096:820:d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 09:06:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 09:06:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 05/10] tests/functional/arm/test_aspeed_ast2600_sdk: Update
 test ASPEED OpenBMC SDK v11.01
Thread-Topic: [PATCH v1 05/10] tests/functional/arm/test_aspeed_ast2600_sdk:
 Update test ASPEED OpenBMC SDK v11.01
Thread-Index: AQHcqiPdY9uEdVOg+UeMDhjoBlunHA==
Date: Mon, 2 Mar 2026 09:06:32 +0000
Message-ID: <20260302090624.987922-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 42d62218-d03c-4208-70da-08de783afff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: UdHxW8vNBePet3Tq4mZFqDZIaqIA3+zY68EUhQphHa64Au/q5ypm2p41TqpfJmnUEH3uDW8HvkSqOGKcPRvK11AV2DKiS5J8wIL7CzGCkPt61nbQhYg1XSLmxsrChvIPXEjkWDngL2RUpqY26NHQTmz1Q6M6fmUnhKrrzf7ADz3tAtiaZOwsPgQms0sQ/k6dyk6SNVEQFimliPMwFGFSCXKOKdtsEPJAhLEtTVDUGAOV/rDlbG0Jzz56yMJRnx4e3tNdiVh+ZWtio75RJMqUNkq3Cgl/BcO/g/aw1ATF6NPaK8mlHx3/MjjO8E3nP9aLLZC1XHo576BlgvsGImgRYfXuL9MrKK26Us5kX78oVxd050kHxHJoE43OOefd0Afcl1mO+fqBvSints+3FexOoTWjYYrsv8VyQ1ipuz0ufDcqQbIi++B117AHVc42jkEgl6WbDLf3OdWAuObmzR6Y7+ChBvmLdVqx0lAAv/0jdbQSf0NWhYKZgFt4tG4AZNNFKoWLHZFViKKnTE1N17uypCHiP1PiWCUxbIyRWdaJDJXFiar/5FyK/IU8pN8lZZbPL7HPz9jMO58xqfNcZChPXR0Du87CR8Ihrv4vrIPBpf2o2XiYzWhyM8yfCZPUhSkwz4yE41phTplbh0CKSB2i7Q7su2zuLVcmDwz0jo6C7vFrVQYAZF900S+D+jJoScSOxArKMmP2rno0ZfVCXIvDkM19SeJ6v99jdN7JdUh9u5AHMVx87bF8kP9ChqPdF/Mz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hpZnTYsS7XNkeXyQBLGO4TO5iPsTW68O/uQgddCxHg5P1yG367apQ30ru3?=
 =?iso-8859-1?Q?YJAnwVxQgwE6hI3K26eGnjiPck/U0qTGm0hR7P2NH7Qv4pzEA/ePvZ+xNX?=
 =?iso-8859-1?Q?JGZc1IXAiT3Bf6SzFZIF+V9LNqbor+J2jB0iDUuxyzV7vPCAerkBLFkNmE?=
 =?iso-8859-1?Q?W0qXK/fC0d8f7GMt0ypSSuvaG+CPeJPFTsb1QQPzq4DCQp5WjeyVEUS0lC?=
 =?iso-8859-1?Q?haeW5dqZsa/9Q7bYR7zQEvLZQV5gFdI4A2mIXnIZlDdqD6vURlntZ/v/1t?=
 =?iso-8859-1?Q?G2VKglvWyagfIdbCa7JUlxZ6s0ZcXJ1oEzYwCvBS7xTp6cZ3xbPMlC4Dld?=
 =?iso-8859-1?Q?91Rg0aitnTyVLvupObbHE02AyXENql3fMSRhyQkwaOXHChf/RiIW8p8znl?=
 =?iso-8859-1?Q?yZo2XM1Uofsl/7LZSfzKqoAwbrYAFM8tjOvMmK3W7HgCxwCz7KA2fg/13q?=
 =?iso-8859-1?Q?m24vmc4Lec1ejK9zj/DCXlEZk/Ir5XAq4cZrMeW6lYQRKgCnAI1WdZp3/W?=
 =?iso-8859-1?Q?L5n10EkmDDuKqZyfWvc4SEBAiy0x/6WtljJEOa5kAQK4adrMd2vdcjRv+Y?=
 =?iso-8859-1?Q?kjgnis0MITy7RIpqJGKrWUftQvIllROmOLmD6mi2J8U+CT30iQP1HfiO6Q?=
 =?iso-8859-1?Q?50EM/QmmesQr2xvhor6yzxehqYkc+YxMaqiswyhGGsxMkxup58YHa7n9C/?=
 =?iso-8859-1?Q?ZOrnBcIsUWZyrbmWF/ooNJ4TVxVRopYu00IZ/+Yx64fZHPpdptJnLBYuKe?=
 =?iso-8859-1?Q?95W8A8r9uc8bYuKzKcHdGoLL61r9V0DecVfNSihg7gYARfNLi8q85dRmvH?=
 =?iso-8859-1?Q?+ncYeqtix5+xQU0GJpRB3HTriyHSozqNq7amLTbkOyov7gROJiqNUb7p2M?=
 =?iso-8859-1?Q?7SrPXwv3lyFIX6BTRJeA8QXqOl3HVayEDgTewnS9i6oXpkABLYjTjWi0ca?=
 =?iso-8859-1?Q?LrFHlaSLYbVz1hPgaVY0uu3sEPGvdPxiQAsYFNv1DWqkaKdS1MvUt7dLhG?=
 =?iso-8859-1?Q?HYRp7uMswtOwa9QiUbLwnYS1dlcTq/xKDp4fPwJcooFVuaya5YLN9cHKrP?=
 =?iso-8859-1?Q?LK2Gzjpm1OLbRVOLBgtWbDozs4NGH6UINoqYnZIKlvuBCHqoEZMZbS9xuR?=
 =?iso-8859-1?Q?qpK2vXFbGBy27WgFQWUaVMLWx/LJ8kbtfsacgSNkyCjO/xeCA0VlTBnysz?=
 =?iso-8859-1?Q?NMZ8T6eBA5f9jFZt3G6SjszD6H6jPcIKVNcZs0AtanHYoy73zaG5XO83Sv?=
 =?iso-8859-1?Q?P3QzNeelG/oyVMDT4NHHRnq1zcXLkoaSJ3yOwOsRBcwav8G/NowDZI6YfF?=
 =?iso-8859-1?Q?TskeiojB359cfCcfC+4lqlttiB3N6UFxqUTN7D5LMS66jbvZAshmUmUUn5?=
 =?iso-8859-1?Q?pFRm/ZT+8b1G24ZMMMFT1v7y4gJytFP2uOhEZNEoOhFHoMS9QF9+xvIWXy?=
 =?iso-8859-1?Q?AHocRbK7BDma8q/pdRGpDogziNqmRKrU6k1JXsU45jFVzD/JPr1xm2zkhX?=
 =?iso-8859-1?Q?fwnDzSI/MyEim7v1pYq1mwPlH68sO/H0E7yob3ozrkHDDOkzIxV59PrxkN?=
 =?iso-8859-1?Q?hhhjLBglEnwcnplEHjPvgPWLwj5i/vI/5bb85KZaHkZMeSJxNhNl8K4Iun?=
 =?iso-8859-1?Q?LaJLP9OWAbWWUrVdN5A6EqbUgyBV0TTgGU1u7+wjRnxRilRlSJchE2UPdH?=
 =?iso-8859-1?Q?6Sydz3/Cac1vbj+75krCMDMzOx+ozqfiTssMKMsyvx/b7WS8eC7TvAfS6w?=
 =?iso-8859-1?Q?p2TQTSc1I5HVIORbtq8INms0Lau8zjaL7ZRuUW0SlrjabUihh6bC3pVxav?=
 =?iso-8859-1?Q?toLWYTvp/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d62218-d03c-4208-70da-08de783afff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:06:32.5399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcouzHhOMzC27EJ9Bhygv7GzO3kekLV59TFQQT8NGw7KCGBe2kSjon6mYMKm6AjfK2eQIhMUCKLGYXUNFKQQiM8mQiswNzLZ5nVwjneOwfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6134
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
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index 46b9f7058c..d787e90d10 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -14,9 +14,9 @@=0A=
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
     def do_ast2600_pcie_test(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
@@ -44,7 +44,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
 =0A=
-        self.archive_extract(self.ASSET_SDK_V1100_AST2600)=0A=
+        self.archive_extract(self.ASSET_SDK_V1101_AST2600)=0A=
 =0A=
         self.vm.add_args('-device',=0A=
             'tmp105,bus=3Daspeed.i2c.bus.5,address=3D0x4d,id=3Dtmp-test')=
=0A=
@@ -55,7 +55,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.vm.add_args('-device',=0A=
             'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
-            self.scratch_file("ast2600-default", "image-bmc"))=0A=
+            self.scratch_file("ast2600-default-image", "image-bmc"))=0A=
 =0A=
         self.wait_for_console_pattern('ast2600-default login:')=0A=
 =0A=
-- =0A=
2.43.0=0A=

