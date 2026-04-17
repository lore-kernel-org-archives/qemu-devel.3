Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7416F8E499
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZtb-0002fY-5l; Thu, 16 Apr 2026 23:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtS-0002Xb-U5; Thu, 16 Apr 2026 23:29:24 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZtR-0005tG-4u; Thu, 16 Apr 2026 23:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjwsCcXzB/2OCIysahf+QQbbH5zqNL12m6+6cBJKGtthN9u8/ypXXk1WixMJ3uyRvaeYksMKXGOA5+cJ/2d8N/iS5mDBPlukpVsZIIeH+381cZEpqLKJDi20m84MRP1k2YhYLvbGGpYOmhsRWwPRLbtdZdJNoGpC8eFp0YCnAH0/3Su2a9T/wj02OBqpiOsszY0u+0lNFTYHKu8Wud90pIa+278nH2ccbKtCpUEmAReXx0UjjJqBh7HLmHVfnapyoVD7QBS43zgpzevjXsoOVGbBV/AQeyhKfL/LkMW1/lr24cszQsZ1IzIeqzGW67pTzQrYNz/vfr7+D0fKhAthgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eGrAplOW9/dRSu2NIlOoUmykCOwhi6A1wzM2wISqP4=;
 b=MXmLe86oAYERKByHt/UgqLruhMfju7zPWdF6BRANU9whUzUewIvmM3TuaB/j92rcirBjPYewd85KihBBY6VH0mjJ13pk43y6O4nhoeGhtqNgYVcma5gEbvk9Kkz8KUfaJLw/zi0to+5U6gDyP0yIBAbBi4MeNz379JRqe/HiAaSyLzojxUCaOy/VErDZ49ctsKVjuukmvk9ECu8AeWR91aN3IBNedxDqdQckGpW37GOL2PPgZu0WzkIRiBououN50kpESZIrNwuL7VCQk5UakW8o7WaAz1NhcM/ueWpQjTkXRzw92aAiTihcdrHwWDUsG8ilHEDIb13/me/XfVhD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eGrAplOW9/dRSu2NIlOoUmykCOwhi6A1wzM2wISqP4=;
 b=N+gPUlwZWThLeOJsw3tj9VJ4YJxVcHP01kBpU/FfFkjSSH58TbYwj13PhgmMdYHiQYRO7qp0SHDGsrW6isWnvuuE+j95AOAtJxE+nkp6JafIemFp/Zp0dWfQR1LvmSRWMpMqzgNofSo/O9Q0v4Z/ljymQumcei5kbihUoQ238HDY0wsCzL97lOMPYfaG298OyVCwHaxM98/7B6d5Epm6jSm3bPjo/ZY1/kDf6vAz8yUppS7Q4BQj19vLtdYBOxEkaCXaVLEBmjX7xO2fC2hbynrbDiy1KTXAo/vViSpjcIv0utSgxK1giC8wbYYJzjJDtlAYC0hGCAz4Ke+8jLNxVw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8076.apcprd06.prod.outlook.com (2603:1096:d10:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:29:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:29:04 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 20/21] tests/functional/aarch64/test_aspeed_ast2700fc: Boot
 SSP/TSP via PSP and load binaries from DRAM
Thread-Topic: [PATCH v4 20/21] tests/functional/aarch64/test_aspeed_ast2700fc:
 Boot SSP/TSP via PSP and load binaries from DRAM
Thread-Index: AQHczhpXKjvlRNe1AkiQn2IskqTfIQ==
Date: Fri, 17 Apr 2026 03:29:04 +0000
Message-ID: <20260417032837.2664122-21-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8076:EE_
x-ms-office365-filtering-correlation-id: 628ac554-6d6e-4590-50e0-08de9c317a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: XrfMYBuhpz2J2wEdl0uX2+cMaWl+e2ZtZN3gYuMv7E5jDoDqCTNVHhfQMb0+l3S1D9h2yxY111TX+eBWXT7riVZXdePOe9A5TwY9qqMpYGXLOHwK7dBtZIGpgxsxYASonv9dpalEBZfFIvQWbtbfyf80L/N3SdfVlB72lxy7frIJhwEs+LrSb6Wk+eUJAx81eoBKl/Uy4H68obdLgSlBQ0/CLqWejoWYXbwaA3idEZaoYhuZeVg6O43G6sni2XNzSL5qqPPIT2w1EU60ik6+WlEhcE82j1LLxeHUptj6B+fUr8CnHyZbvAzqE0GOI/DyQzKYI5wkjX0zL5z1J2rFfD2EwqFOJYvTOk81Evo1b9ItG0nlWR0by8XEnECS/zrv2/yLqpoQ+FR7ThNsGJQXGpVh3y22sJ0yY+igZvmhJdGSmIUjx0SEQ5y7kU6x0et0LOU3r5Z0XWn72sO5ICIGxR21dcdvo/p2fdDT4BDDkENyGJzO23OTyPFXB4j0ZksSgPl368cxlS16ha8JRg2l0jrFqk3co83ZSIC53q3/ylFmvyakn80wje9XkF2V0tzx2C9naoyxtHSVlj2UCQ03sGu6mkZvwWcI0eYRP43IAmCUAfDf8wYagwLkE7EWPpV/VP0l+NAMW+RBlVemxQS15H+xrLhVHPBqRjy3zAheZgimHVdEfhieQWeLboEn+ek52rL2NUhhXXdefCfc7agSpTv93K3qMfPMUOoOj3D74Ut6shLf3mjbjgnL7jj7EwgPZobV5fMwHae5M6gzJbctGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lTDj6LEKPM3EGzQXs5T8qH90hRW+eU7hAql/PDEPEEMD0oNo79nxB7ylGR?=
 =?iso-8859-1?Q?9er5uhV39kPv9xdBieQur2iZYdcW+2G8Fe7On1l/ZfhVhdv52U/kuoznb8?=
 =?iso-8859-1?Q?e/3DFEtZxXjMe9hTq3SE7kDC1MfsNO7e5HlKFpiB7lxGw6Zo/+2fB6MpEN?=
 =?iso-8859-1?Q?Enbr+XIc729mb7/DGsaXO3kCZp0HkmJNC+667zu6wTQUhHgMchqG+3hqVD?=
 =?iso-8859-1?Q?TO1W8/xv91BZD6eRY0eL4tKn6X8NXGXcMdJH20R+R3an3tF2Sy6zjO7CW6?=
 =?iso-8859-1?Q?ZqkpvCXgpfQspb5JyylO5OQUZskHD3D+Am4kAwATT+cLw3RTbhmFCaiuDb?=
 =?iso-8859-1?Q?cUlGu5w3ZR/8XMEWSW5t3bzyY4ND5CipAF6v53fPMToQySKD2Dqs1Hvc8l?=
 =?iso-8859-1?Q?F+NnP/JGptnIeRplRvXcTUZe7PplqzanI/KlQfYgBlu1DX7+XJa+vAOv/M?=
 =?iso-8859-1?Q?x4U5+jBOjmqqMiMHz4/EFcp6CBOGX8pqALJ6ZlaSktVq4f9fv9bvbhfVWC?=
 =?iso-8859-1?Q?2yrjJuqHCB0Ajxz6WcOO0QnpXGW6EPni7fEmlmMYrqV+ewi+vnFnMTCcE2?=
 =?iso-8859-1?Q?1WMo929X4tym+YgRg6T1fXLAaptHJ/pP5vWZqB8aXhnmhVFzU+8KOGpQ7Y?=
 =?iso-8859-1?Q?LoO7vo9Yd6bKzzwBh563rUln4e2cmaAoJ6VTar2v08GgvMAD5PRALsI5ei?=
 =?iso-8859-1?Q?NfT/mwaDxuPjYML0oNHI47vwmOKpScrjgQQmIqfPnpCFR7JQRLB6mR2zoI?=
 =?iso-8859-1?Q?gqKoQn7T2l0foI5qljek77Xv2zlTq3yLgM6LgpGm/eMHeR/6hmbdzgsItr?=
 =?iso-8859-1?Q?CfifVTROgc1s5jandlxXHZLUxA5nmDoNgS26gWT3zEn2C6PvxHdmNSvyDy?=
 =?iso-8859-1?Q?qHncx1zpHcupuK6lBXNEFBWIomwiTrCj0ChZvJD5KYubeWlY0ZsVHpTAaP?=
 =?iso-8859-1?Q?xgPlyczN3wWjLSITcINdUcWg+TVSs6YpCfo30p5uiDPxMllvpo4qVOv2ZP?=
 =?iso-8859-1?Q?HUiotBevXsYOAswh5ehlkv66JZTFsEqZ80u9HlZVWPgUO9kXYfYqOOytoG?=
 =?iso-8859-1?Q?rbNBzHdNlsfUp3+10ZjYyiArqm/7488quuzKA9l3ADRqSTaKQsgBsdevDx?=
 =?iso-8859-1?Q?QtQI5+WGmUha6/MqSXrky2CtLFKcnT8QY2vb7xc22FE66HT2eP19aWp9q2?=
 =?iso-8859-1?Q?ECuaz+e52XeTGn0ho0q5eSKsrG03HZKRoNzpt/I6qIOItChUtQRU14Um5X?=
 =?iso-8859-1?Q?HjiXgTxNm/Yt6SAuVZ8obqCeTMm4aFInZFOZJVuLKwtFTdX5YAF6doB80t?=
 =?iso-8859-1?Q?YudXU/ATpMLTN7BTZUaQ5s9+B2rjhXKvubNd/u9/MdJ6u4CP74gnwrtyvi?=
 =?iso-8859-1?Q?ayQXRnIzGmGNeCLv8YKxvh4E55jirlTp6zm0dkWXyYv579x3bTgP2rby0h?=
 =?iso-8859-1?Q?dViRF468INAUyvlAeewm1STe4OBszxeejLhA3Wwca6EH807+FXZQ7rWzr7?=
 =?iso-8859-1?Q?m2VJKpm8TXWpqlx9ThWN4LP9iFH5/4h/joFuh11IyBpAEOU6kvx+jXHGKz?=
 =?iso-8859-1?Q?0atStd1uy47SJwIaCtERWMaa1/Q1JoT1Oy6bNZw4D8fejiKtwP+nH7nB5n?=
 =?iso-8859-1?Q?gA7xwxWLP9BRPAqdj/X+WscxAfO+vx4t+PGawav4Ps4c8cGJeo2VuK16yF?=
 =?iso-8859-1?Q?viQYqLLzch7/xkRaTtE1n319li11veCkC7Szs+YbZsoLONQT3/HYTbuMkB?=
 =?iso-8859-1?Q?a4eY5h1Tu/n/IifTqD8OG/oPg2zMDhvwdxuSovqs+lXUpKpno4/s0IqKyW?=
 =?iso-8859-1?Q?HMhXTx44Xg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k9d5rrQj7lSklKdJZ3l4kSvs/FKsjNoBex6NrTIF0rjM5N6UCeHimH/7Jh611xqj7W7CUtowThaY89gDsCpkemlhd7IJNoWjpEvCTa/VDmu821FkqKiSotAFCKtM1SvYuOFd7Zed8LE+IFCbLxyMNZYTCqkr3Pnu89+Rqw2ficwLGnpS3rLHYMQfuDxkCl11QnuvW7d1BNYQohPwFfDeR8WisN1/Ahw+L0zUiF+cT4xVRmXsaeCXNKT88dMS/QSmYw6hkt/zUoW8qcd/3+4zFu93m4oRyooE22Pt3c8c2pPGhAgsbtk5eaBKUh5s/zY2hnCMSlavAAjHPL2z+/2rKA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628ac554-6d6e-4590-50e0-08de9c317a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:29:04.8505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlWHGT2nUPaamVbC8UCMFtF2IHiLJtLOeufJJlTuTwv19h0NWfwUhTC61Kr/lxQNmFgNlCYnMtOyQmcTtIG/Pe6Ks7U7VmFMrv0BtwywUXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8076
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

SSP and TSP now boot in a powered-off state by default. Enabling them requi=
res=0A=
the PSP (Cortex-A35) to explicitly set SCU control registers at runtime. Th=
is=0A=
behavior aligns with real hardware.=0A=
=0A=
Update the AST2700 FC functional test to reflect this behavior by enabling=
=0A=
SSP and TSP from the U-Boot shell before booting OpenBMC. The test now=0A=
programs the required SCU registers, saves the environment, and boots the=
=0A=
system so that SSP and TSP are powered on when the PSP starts.=0A=
=0A=
Additionally, switch SSP and TSP loading from ELF-based CPU loaders to=0A=
binary images loaded into PSP DRAM at fixed addresses, and remove the use=
=0A=
of snapshot mode.=0A=
=0A=
Changes include:=0A=
- Add enable_ast2700_ssp_tsp() to configure SCU registers via U-Boot=0A=
- Remove snapshot option from QEMU command line=0A=
- Load SSP binary at DRAM address 0x42C000000=0A=
- Load TSP binary at DRAM address 0x42E000000=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 .../aarch64/test_aspeed_ast2700fc.py          | 29 ++++++++++---------=0A=
 1 file changed, 16 insertions(+), 13 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index df889134ed..c0204ceb6c 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -23,7 +23,7 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.vm.add_args('-drive', 'file=3D' + image + ',if=3Dmtd,format=
=3Draw',=0A=
-                         '-net', 'nic', '-net', 'user', '-snapshot')=0A=
+                         '-net', 'nic', '-net', 'user')=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
@@ -31,6 +31,12 @@ def disable_kernel_crypto_selftest(self):=0A=
          exec_command_and_wait_for_pattern(self,=0A=
             'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
 =0A=
+    def enable_ast2700_ssp_tsp(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'setenv bootcmd "mw 12c02204 40000000; mw 12c02120 1; '=0A=
+            'mw 12c02224 00000200; mw 12c02160 1; run bootspi"', '=3D>')=
=0A=
+        exec_command_and_wait_for_pattern(self, 'saveenv', 'OK')=0A=
+=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -48,6 +54,7 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
         self.disable_kernel_crypto_selftest()=0A=
+        self.enable_ast2700_ssp_tsp()=0A=
         self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
@@ -55,16 +62,6 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')=0A=
         exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~=
#')=0A=
 =0A=
-    def load_ast2700fc_coprocessor(self, name):=0A=
-        load_elf_list =3D {=0A=
-            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),=0A=
-            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')=0A=
-        }=0A=
-=0A=
-        for cpu_num, key in enumerate(load_elf_list, start=3D4):=0A=
-            file =3D load_elf_list[key]=0A=
-            self.vm.add_args('-device',=0A=
-                             f'loader,file=3D{file},cpu-num=3D{cpu_num}')=
=0A=
 =0A=
     ASSET_SDK_V1101_AST2700 =3D Asset(=0A=
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v=
11.01/ast2700-default-image.tar.gz',=0A=
@@ -123,6 +120,14 @@ def start_ast2700fc_test(self, name):=0A=
                 'addr': '0x400000000',=0A=
                 'file': self.scratch_file(name, 'u-boot.bin')=0A=
             },=0A=
+            {=0A=
+                'addr': '0x42C000000',=0A=
+                'file': self.scratch_file(name, 'zephyr-aspeed-ssp.bin')=
=0A=
+            },=0A=
+            {=0A=
+                'addr': '0x42E000000',=0A=
+                'file': self.scratch_file(name, 'zephyr-aspeed-tsp.bin')=
=0A=
+            },=0A=
             {=0A=
                 'addr': '0x430000000',=0A=
                 'file': self.scratch_file(name, 'bl31.bin')=0A=
@@ -143,13 +148,11 @@ def start_ast2700fc_test(self, name):=0A=
             self.vm.add_args('-device',=0A=
                              f'loader,addr=3D0x430000000,cpu-num=3D{i}')=
=0A=
 =0A=
-        self.load_ast2700fc_coprocessor(name)=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
     def start_ast2700fc_test_vbootrom(self, name):=0A=
         self.vm.add_args('-bios', 'ast27x0_bootrom.bin')=0A=
-        self.load_ast2700fc_coprocessor(name)=0A=
         self.do_test_aarch64_aspeed_sdk_start(=0A=
                 self.scratch_file(name, 'image-bmc'))=0A=
 =0A=
-- =0A=
2.43.0=0A=

