Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D4C4453D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmj6D-0005MH-Bn; Wed, 22 Jul 2026 22:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5t-0005C1-5s; Wed, 22 Jul 2026 22:23:32 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wmj5r-0002ZT-75; Wed, 22 Jul 2026 22:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4ZhW5IdyShy5t/G8SHm9o/b5du0Ph14pn/Jz7tQokWMFBZqpt2+nxaDK65XqoM3Jf1/dWmzEjQm8t9ijzMc0F+buvEvnguwN5LbgKNXkcscjouE9hjut2drGO7beW54Y2dUN+VfJD77mGr4BsfO2L7XPlTtrIRIAQX22bE5vKWf6mE21BJ6uchXoWtg0AhRZUahRPcL0eTNH0tPuFYP1+/zYEs4J9qGCudWgHtjuN01grxHoPitQ45c/y6/TissCmIV6HusLRzI/pLTkY8o8lJNjWnzx+R5fcDrFfCxmfSVrTPvx336TkXoPYPBu9b58YVJ7Gt3OpKxVGBeg13Wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue8cRlCmEIubx6A63gTI5KnhP321qga/u4Os9lllgOM=;
 b=ffnxX5L1YW8ETx0GT1+fZubjN3VxtkKNsxHU+kodWkhdEPeCjhYv25p09KSU3RyVxgyClLDIE5MOFfi76gnFrGV1hBca6+2JW/Xb6PRlxptmwYtJSXj16ikTPih30Q3pWapXkNrcZGzzLyRF4BiOIo59yz162pPbuBqDb2HpJcFAEn3LFaKlmdujTfWNykhBFl1toiTbScmnYuHOXr0NaH6FszDAUzv6YhnMaeqnXHwlfZSVvtGR0QAr6ULWdgc5JdNUR4LprHlrLAlUGuiEJeaR+vTIcZfqsit6QCSfPFZ2f1iyjaa1vO7GQpVubaKdfnIIZX18uq80UzjvLoVYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue8cRlCmEIubx6A63gTI5KnhP321qga/u4Os9lllgOM=;
 b=lmYqL2ScdnoKo93K4KFVHx2+02a25EZCNQ8KNdcEPQyzPGf/3HDqQMQN3xqo8MCJa5gP+je1dxD9yocT2RTZdEfz5+o8rTVWPRbpHwkyCfSgXk97dQiRWTXl19ENCxW72Yg1mEkyuxRnhqUAGkP+c1RFIlAx2lelYV3W4wQ7ewBqoskBi1jCcpGjQaK93sb9UfVSPRDHyTqeSZK0hCpa79iiTXX3B3P0aOg/X3xQhSm6HDh7hQussQip2QyFR8ZwhjJ7yazbfwrtEhc2H/xYJrW91HSvjWGil9QW0RTJYvBpYFwuJnHZEJjUNKhZJYGnCAafNhJGkBuRf633zj7Wzw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KL1PR06MB7034.apcprd06.prod.outlook.com (2603:1096:820:11e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:23:14 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:23:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 11/11] docs: Add support vbootrom and update Manual boot
 for ast2700fc
Thread-Topic: [PATCH v6 11/11] docs: Add support vbootrom and update Manual
 boot for ast2700fc
Thread-Index: AQHdGko3HQEl0NK78UaxGmKQp9BrIw==
Date: Thu, 23 Jul 2026 02:23:14 +0000
Message-ID: <20260723022300.4174471-12-jamin_lin@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KL1PR06MB7034:EE_
x-ms-office365-filtering-correlation-id: 4aa87517-9c2b-4e9c-97f8-08dee86159b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: ePmnxUr/dBk17h3MwkUFQqwZT62VJDAvE6QhJ916se+p4hE0+Qacd3pU8pUVJQajAlj7NRWJsogvgn8VSzSChPcE7NFV6+sNg7oV5buW5X+p2r2Zbyspw1miTDrpgkeyzGhwlGRxXQzfPNV9kv1xtTFJgTpSWu22QOZPAVPd17wHUupZ2Zf0nMdi6gUN10AJ6CQiVNjp1nk7zfClmZvNCwm1vov/GzFwL68Fb1kjRiIM4r+LVEnrupaUOphzH2cgaNFYq2VCi5VuAtH7Tf9iu92XzLNASk+nIFhFwYKmTD3rEXMwjmBruPRZnVe9CziCrXn7VvqzssNolkeP60vJzRz3zId/SJf9T2XyubxC4y2KLCf3F6bQQNiVUchEPtnard19y/4WDLdqjHqd6I5iROgmnv63zax8m6MVmwLC1Rx08/l0VdxpYIcKOKn3cz4xiVgRIYD3Ymv+TIWxbNPMCUFVnaglQomvS5Bx3VywM6vzbY8hFh/kTRBkqVQUYBrOvdLLeyZ7ua9m6+1klb2+ByjMon9OvGrHWi6YDT/JZ1CRzdFpZgTCr8rSgLxorpNPHII67BKYM2+b+B7BjSO0dc8z5KqrkICn/Fo2hMLqmL7/jKSEKKmNS33jXERnYFDOyv5PY4qhOY592eCorzdWjFbMW/bJiLjhOkqcHT5Uu1iqJGCBrroaXt7fmS3LxkYpGPpjAZqXBQf4XMzmKAsQHtGfoQ4HhdYgv5ELkJDZqL3XZq1i2pfycFGMP8eMar9Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0JIt/y8yEE8QKS0Cu4+C8LusV2Y4k8FU7H/aC1kJmGq0jvQhyyppL4mSZh?=
 =?iso-8859-1?Q?Uh2jjgnr5ZihImRuIloE5Nxcmbt55ChA0Ey9/5AaMGNw40nw9+Wvhtrq08?=
 =?iso-8859-1?Q?ksNDdLIa+t33in7Gp2KAK6MVeFXMXLZ2qaVHEuDcklpMm6xYFWoGe864Mj?=
 =?iso-8859-1?Q?rOLtNWovFtikMQ+rFx4bLOF86LsA/JKEN7YtRq37WcTwQrUQCPXEfJ927Z?=
 =?iso-8859-1?Q?NPXg6PyacwgW5KjmNJrcItwt/Y8vXt0gk/FumofG691zt+RIfPFcB5wh+V?=
 =?iso-8859-1?Q?9pF6GS5hmG/TheXRCyfEuGEJbqj4JEYFk6HFHavrNE662/qJnenY338x93?=
 =?iso-8859-1?Q?QSkP9iDkG7yxnaOlVreBwc2eA7AfWmw7cYCfdiWVhqb89hCcw1/wBrtRbw?=
 =?iso-8859-1?Q?si+hoeQgi907NlcQOLLELhpapi5fC373b1H9T8rbiH8WXjkNrEPFwf8mmK?=
 =?iso-8859-1?Q?HKvqc0Zp+EAwMOUrp6LWlpRyi82TiJgV0UTigdXcN+qMwgTHKGGi4GJr8G?=
 =?iso-8859-1?Q?LU+hKYXU7O2hfOAoYogea6KreI4WDQyDQ+knLW86/3/F3OQyC2yBhu8KQa?=
 =?iso-8859-1?Q?xdrF0LYfrg0mD6HbIY1oQNli/nJUMVurzlU6pA3FA85Sdoo0/Me2OMuF/R?=
 =?iso-8859-1?Q?IiwdkgiYCDuINSfQUyOYxTf1A5/XFOCv06abmaE4BcnX7zoCfBnFSJ3ywN?=
 =?iso-8859-1?Q?4z5VptAQVoxiWmwk7x8ZOX9ZAEv2pIpxOLIYswJZKoCGS42haLqJr96o+2?=
 =?iso-8859-1?Q?0/deIWXMrsdgdoU56YuKtQr25Drf/QVN6eazUX3XygIXLeJl1C0YZwQ6N4?=
 =?iso-8859-1?Q?W6YAiwUqEvkMZngDQivbGJ1N6TftF1taWeAHYicqlEPw8/inp7mjhrCtAb?=
 =?iso-8859-1?Q?pDtFipTJpzr3lt5mNeApb5GtsWuCobM/ZbMQ4uw6FT+/7gFNvij/yiua5m?=
 =?iso-8859-1?Q?u+YULEEO+jMryG81iYYC8rWgNijK1WWrlhzYPuDCDXSJAuvhzpqdaP5Iqp?=
 =?iso-8859-1?Q?77VbFTL9cExs38obtDkb94iA8kTAjPSJb4jGrgKdmzRujuPgHt1UW1g/oI?=
 =?iso-8859-1?Q?mRkw9rhvojqOJkY/JwNL/eJtKkZ82d2Ux6YO7yHQUruKqZLaXHQeeMQ1lN?=
 =?iso-8859-1?Q?v1jmeMy7zBRijeC24KhTxSBJJNn8jPVHlhEBe2l0ioFUTE6Qfdap+Durya?=
 =?iso-8859-1?Q?tlGpyrhTiTdWy3crdLmTkoJ2MjGca8o7ruWr6SZb7av38Wc8asy1NdKeWr?=
 =?iso-8859-1?Q?nTG5i1bfEbUwWo9HwWn9MUtgrA+Mb6OoV5Lzz4H4YIF2TYLrZwTbkYF43v?=
 =?iso-8859-1?Q?g7LO6YZWBydBGAx5YAUm4TzFR6sLF0KN1WRXbuY7nzMnZWRaBW+zFT+Htr?=
 =?iso-8859-1?Q?yPr4ebyCc1TYY6En7xTsmFZdHFn6pFGiIieF29VpZui2Nc64NjoHBxhzwj?=
 =?iso-8859-1?Q?ihAtw9U9x7zqsRl4PqnPjQZIpKMPXPnKWeTn5rzQHqhbHvAkPVv14vwtob?=
 =?iso-8859-1?Q?eXDfre6gzjSdY0EmyoCKMdwnrzO7N19M0/S9TxJ+D3amlpQbe1iCK0iqXs?=
 =?iso-8859-1?Q?ymrC/AZcO6kLz8JhHaXqO18xl3feb6sAUn9ZTmHxqZjGnhvv/nrspcxbBB?=
 =?iso-8859-1?Q?36Ws5sv9CO3ZsHX1uKv2Xpft1awzpPl26TFsuyd6Uy8dTNup1NDhzH7U/J?=
 =?iso-8859-1?Q?spB7VA/jI7KNoam2Wha8bs6IOv9ThSLlkG3Bg2eD98vPtEUc7ozJjBtoij?=
 =?iso-8859-1?Q?lyL4BR50CMeenm/LvSegkVd05qNxV1hQrXnNmzS/2MFTT8/dQUfQWEzYOg?=
 =?iso-8859-1?Q?qBad75qCoQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Az1KphGSTLn+NR22U4RnZWlT396zet4F8VQZHEWxNeAiNg6d1SAdGglLsIiXQnjvmsS6Llty+95Z9GdSt6jRTVtrVI+5n63/4OHCUqZiuNRh0ruFJaFfvvtxvn5X/+DAwU0PSimD03rIX5EqTOcQ1WwcBg/1Gp5oiKVFZTG0y6lvFLXO0gw4gNOtjd1pY9gCJmAvQJ14PfsHqavxRnYRX/EzH2SXJ9fiYrS8oRZai0vL8v4wglHAsH3Rd6wXsBEFEq88HVQuejRYR5n+uspkEfTIPwfEbvDjBxIwNwyJrpJnd1KkN6iRj1DFl/2EA+GnWOQzqimVm47VMDCXyaNwWg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa87517-9c2b-4e9c-97f8-08dee86159b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 02:23:14.7701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7iF6xCsh8giK3j33G1Fo3FgOQiOeW6yvNxnDkOMtHRoCPI/ax4YklLlMZOQ7UzuE0v31Hnv0dJZoHps5Il3ADHYbRI8rPad+sTbTjJfVUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7034
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 42 +++++++++++++++++++++++++++++++-------=0A=
 1 file changed, 35 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 2d51ceeb84..b6dd757f6e 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -386,18 +386,25 @@ Booting the ast2700fc machine=0A=
 AST2700 features four Cortex-A35 primary processors and two Cortex-M4 copr=
ocessors.=0A=
 **ast2700-evb** machine focuses on emulating the four Cortex-A35 primary p=
rocessors,=0A=
 **ast2700fc** machine extends **ast2700-evb** by adding support for the tw=
o Cortex-M4 coprocessors.=0A=
+There are two methods to boot the ast2700fc machine.=0A=
+=0A=
+Manual boot using ``-device loader``:=0A=
+=0A=
+In this approach, users manually load firmware and assign entry points via=
 QEMU loader devices.=0A=
+By default, the PSP begins execution at address ``0x430000000``, the load =
address of the bl31=0A=
+firmware. The SSP and TSP start in the powered-off state and must be expli=
citly enabled by the=0A=
+PSP through writes to SCU registers.=0A=
 =0A=
 Steps to boot the AST2700fc machine:=0A=
 =0A=
-1. Ensure you have the following AST2700A1 binaries available in a directo=
ry=0A=
+1. Ensure you have the following AST2700 binaries available in a directory=
=0A=
 =0A=
- * u-boot-nodtb.bin=0A=
- * u-boot.dtb=0A=
+ * u-boot.bin=0A=
  * bl31.bin=0A=
  * optee/tee-raw.bin=0A=
  * image-bmc=0A=
- * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)=0A=
- * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)=0A=
+ * zephyr-aspeed-ssp.bin (for SSP firmware, CPU 5)=0A=
+ * zephyr-aspeed-tsp.bin (for TSP firmware, CPU 6)=0A=
 =0A=
 2. Execute the following command to start ``ast2700fc`` machine:=0A=
 =0A=
@@ -407,6 +414,8 @@ Steps to boot the AST2700fc machine:=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700fc \=0A=
        -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42C000000,file=3D${IMGDIR}/z=
ephyr-aspeed-ssp.bin \=0A=
+       -device loader,force-raw=3Don,addr=3D0x42E000000,file=3D${IMGDIR}/z=
ephyr-aspeed-tsp.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
@@ -414,12 +423,31 @@ Steps to boot the AST2700fc machine:=0A=
        -device loader,cpu-num=3D2,addr=3D0x430000000 \=0A=
        -device loader,cpu-num=3D3,addr=3D0x430000000 \=0A=
        -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
-       -device loader,file=3D${IMGDIR}/zephyr-aspeed-ssp.elf,cpu-num=3D4 \=
=0A=
-       -device loader,file=3D${IMGDIR}/zephyr-aspeed-tsp.elf,cpu-num=3D5 \=
=0A=
        -serial pty -serial pty -serial pty \=0A=
        -snapshot \=0A=
        -S -nographic=0A=
 =0A=
+Boot using a virtual boot ROM (-bios):=0A=
+=0A=
+In this method, the virtual boot ROM (vbootrom) handles the full initializ=
ation sequence.=0A=
+It starts the PSP, which then enables the SSP and TSP by programming the a=
ppropriate SCU=0A=
+registers, following the hardware behavior.=0A=
+=0A=
+Execute the following command to start ``ast2700fc`` machine:=0A=
+=0A=
+.. code-block:: bash=0A=
+=0A=
+  IMGDIR=3Dast2700-default=0A=
+=0A=
+  $ qemu-system-aarch64 -M ast2700fc \=0A=
+      -bios ast27x0_bootrom.bin \=0A=
+      -drive file=3D${IMGDIR}/image-bmc,if=3Dmtd,format=3Draw \=0A=
+      -serial pty -serial pty -serial pty \=0A=
+      -snapshot \=0A=
+      -S -nographic=0A=
+=0A=
+Serial Console Redirection:=0A=
+=0A=
 After launching QEMU, serial devices will be automatically redirected.=0A=
 Example output:=0A=
 =0A=
-- =0A=
2.43.0=0A=

