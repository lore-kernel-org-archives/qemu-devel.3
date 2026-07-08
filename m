Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D75C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSe-0004Gs-Mp; Wed, 08 Jul 2026 05:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSa-0004FR-Li; Wed, 08 Jul 2026 05:20:52 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSZ-0000QA-5j; Wed, 08 Jul 2026 05:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qExuCmACgn3cC6f7ltnAf+iXjdGEcIuajvvsdmf1vqlXu6uRI1wilQMebFt3As+WiVQ63PhTc0M9W2XReZ7E8mpmEhnbY7PtDBKB8RqILyaEhrMSUx5Y3FSgfz3LnoY6nCh1r/CRKy/PLrhlGkl8+gJvI12tsKOvnapcYHikJbpdD7eCtXQV60sRvtW/lSn6AO6P2PEZDAFUGxzCAo+nVUkvs0vJHQBfJapiR6Jf16MyfZqiwZpgzPtJbQ3ZOe8jeqnIxA7NyW2+iUROas8IGliC6DDwfEC76NwMuT5qzN6lCDnCNsr1J8sZYkhhDPY2auK6aeQcks4F7CevTYkodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msQd2CzFFqEBzv3IIijmkCMn8dCGGxptTdAm55rfmEc=;
 b=YLeaZLktLkcHv16zF8/hO7l9ZnhcP0HxBsBTjI9PJtlzgdydVhL9jloEOpnI/kieXfZD6O1WLuHQIwvbbUnnGZ5WzYZFFfQEFHV6U6MEVbOIhHdGoIXBqQI3uGEqkwPwRYLnEO8F3c+0WboH8UvbJgShFlkRfu6a1PLvGkNpY8melZREvGyQ/P0rmsmwDilAY8sJQN1Q9JfTJ8nqeP8daBizOtVI0A5cAfFFyV1lgbTTzHAV1v75ncrteC2DokWREWnNoTfabTyo40PnlmxDrRAzDH1LZszNx5khnN/iQi6+sLCkSObWk6ZlkCcBBiwAFBP0YI1PyGZ5p4o0GOuoYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msQd2CzFFqEBzv3IIijmkCMn8dCGGxptTdAm55rfmEc=;
 b=rqOYaHePouQehhnTxtsUtxYMkRV5i9WGyaRJ99aHiwf+DPr8ggC3i+VfLjcCemKCCZtpmE1hNgUtq5UUPEdHKz69VMHPDrVr45yxcJRt0iQLIaoQ6w+z4XThg5EOPnPOJvmo/sbR+fioAepwjTc69xoVpxjVkTUjWUTE8dpcS7vIdCTeZswfWjmC45AtaJy+xbxy4Jje5iikQgg4jdo6i6OCO7IJUHc5Bp5pmNbTmpRtLEmUqi7bUyXL/4FvicDFhD5LddmPMBp2mxaIzk3Wo223y7xuViwMuE3kIeAlH5apF1h/jiXJ6hqxArJ30Xu61aFy0zEeGJM5nkdxDjA/mQ==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:39 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 10/10] docs: Add support vbootrom and update Manual boot
 for ast2700fc
Thread-Topic: [PATCH v5 10/10] docs: Add support vbootrom and update Manual
 boot for ast2700fc
Thread-Index: AQHdDrsKmYnInvGb/UeYQpuHqfYF7A==
Date: Wed, 8 Jul 2026 09:20:39 +0000
Message-ID: <20260708092023.3826159-11-jamin_lin@aspeedtech.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: 2e7e5236-ed90-47b5-94cc-08dedcd22d38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|3023799007|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: m2HGqyewVSzPG8gIyHu1YR6Nh+OHW/ECL+9xN3psi+bOLRmxUcEV25XWJeyNVth0Z2A7VYE8XTD1FeDfcDgRVBTtryorRYXqQlZw/Wt32W5vkL9GCKh49N9+E5OaswmzRWvHvF37ZaAWvGhjaCiwRpRKUJYtKGnFeIH3HiJ/kgBmuvbl+OHE6n5a7//xOtwE48EaatfOAQ4vTufn+oCJTIY+sHwo/i5PLYHno9eNKNAAsc++k+aEhaiCFULJjNa8n689tAQJ6VgDrCXwhznmmnh24FHJtVJWyMBhx83QdD27mnDkHa3v29LPHJ4oCPppRjI612ctL5AToB0XiSTSMOvQm6+mzzthQ9KNlq7MsZ5BNO+172141EnwkYl0DTG0J9AeP8Itfs7VFGPXd6Yf554p8qFzS4OfTgP8eF4G97B/ABLmzyXtMB4u2WO1hschJE4mjK5xjYXnUWkR3Wryr2IkFazedC35ZbOQUB82nTTANZan//nR2vPvHV6MfQTBevpy1ZBNrTXbQbj4Y3irLLzn2M+eCSnEGYM+C60SKr8FLprrCiyNkTyHf2FB9ZIMqlacSIUFSufs5Qw7bCRApSH+9PAwW4/smcrjqrFVgW1ovdNExNMqhtmY/rXIBC3phR2hDt9RG8CvTgwACHKmNDsY9OLXQGK5nWaAjcYtbRYQLdUznVmLH4Xv3lIEZesc2AOYs513eXG6lf6uT9dxZucr4lIH28W1g3Zz8Tg4nczicIE735o/BdmKzIU9TzMk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(3023799007)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bu6jwUHu8wnSPSxmVTdq3EMgxwclYiR+OsjhIi574iAFC65Q4Zyd1Yk54x?=
 =?iso-8859-1?Q?rUAHpWPkR1IPkRGETQNS4COaSBcRNRneXUCC/ycvc7YP3a4/FZz90AFdWs?=
 =?iso-8859-1?Q?zvGh74dSw3rM2CbfmYyxGAEd8xGj87QumBIfOZVmDlgW9PnGu0aWjBNEQ8?=
 =?iso-8859-1?Q?qkqjTy7pn0Ir7Sgid4bODrUXBn5o7NqmxmL5TPdddU4vCu+g9Sa2FqKOo8?=
 =?iso-8859-1?Q?m0FC3pMWIeu3FNFYkWNa09Ui1YhBLTpTetnPHW0KEtDqq+ERXzZpKO3Q8W?=
 =?iso-8859-1?Q?poI2JAEqYS/Um8vS38SgUyQ0sczs6GprrMDgS5yvXy6UKS0aMjgCOPNxG6?=
 =?iso-8859-1?Q?7/yd7hLw6597ileLN4jX+1I2WLzpqA2AHfTroVYmmeKkgt5dMr4LExb2K6?=
 =?iso-8859-1?Q?eIhMa84dLKDBai3l/9S48dis6MLL2nWXJwRx1b8n7FQaIqRfam8p/lkIpx?=
 =?iso-8859-1?Q?4yAmk+07n4YwqyWLGP1BaDH+lTcPHtseLc1NTFDDC7kn8uG4Gm/ZV7x9a6?=
 =?iso-8859-1?Q?0eX4uuPVpZPeYAhvASh80oKfY42AdCsESNIA0V/VX4/MKx4t4p211+kz9n?=
 =?iso-8859-1?Q?fYk9vtDW0yozcllXEAwXg9Xw6e+nMsCYjPVlNy+7a1nVlZPp7IW40jimDm?=
 =?iso-8859-1?Q?VforyrnpjeU8RSj/pr1WfTRXVSQBhO+87qb/9RBNG0l3jeIUQydaHqXhsK?=
 =?iso-8859-1?Q?x1sJeQuaJ9CIiP5BBhnF9+rJQQgA09NmrzJLAbS907Izq5xgUKitfsxEBU?=
 =?iso-8859-1?Q?qWQTjPD0LQqQ6OK/J0ge2wqQABccR7SW8dyUIesBxUFyrkLPwCzAHfQvC2?=
 =?iso-8859-1?Q?KO+jM/sCP2r9oJ/qAKL1Cc7DWjikpw8oFdXk6LCe44nCKRyxIat/4qp5eV?=
 =?iso-8859-1?Q?keDobPriyijhM6sCJFr1pa/4o18iB9A/boU/CCFTvzs2lO0Z7eW/1nbe0D?=
 =?iso-8859-1?Q?P1RPAp+uzKJK6Vpjj2Gi6lXoWZ98DCacoiX1qiEKY2Pc0IBCQgjsnXfOqR?=
 =?iso-8859-1?Q?swDQOK/TDlwg6UN0cGEljs/GprBZN/4beELy1snlG7MAwHEK/3LaYmZpjh?=
 =?iso-8859-1?Q?xe+0sQ41WnMOUPkfRxsjhjTwp3OEc2zoMIr2r0Sr4hrR+NvZWlhlbue67U?=
 =?iso-8859-1?Q?s482xVIMIGOcRvStDI8TOYjg6/qA7gTwyg+LRZXZ2I0FiMdjpw5HtTjcXz?=
 =?iso-8859-1?Q?DxMv6XAQwS4rrMpPAJYOUcwXmWt2k8wJIt53m3CGXDprbLCmUl3Jx1b2Jb?=
 =?iso-8859-1?Q?xG5yCcWiBkLujmD0+/a86WOEepDncwWq650sz3hED/KCLnDN5t8RPqgZKz?=
 =?iso-8859-1?Q?jK9OlqWAAgM8Z+l9XRZexExKAMa1RCAVKwiQC4OQNwJn1OiCgEK4vAb3eA?=
 =?iso-8859-1?Q?oaITj+zv2pOMZIXDUOzrV2vNFDvlCSq5q3nvySBiurrd9fma0W8+Uepr2b?=
 =?iso-8859-1?Q?ip7gcEYFeuMK+/P1AN4+bQa2ecMe8wRw6h1r2oGIg6bm09ZhydwZG8mxaq?=
 =?iso-8859-1?Q?JwfzbSn5lw91MvKQ4FNHZAeonIPgRQsr2SfZ5IzP0fv/pJ/jmtUvxoaG9J?=
 =?iso-8859-1?Q?RhEQq8vYm6TT1uPeFSTTl+SPSKiKYKyuSBDEiitJcBf3XDKLy8vA2qNRlI?=
 =?iso-8859-1?Q?byZ3Fa7hLHh4mjQSpRZfS21OqQrVk/WF0R0WJWG/GcxsoxCJ141xf6p8cY?=
 =?iso-8859-1?Q?OPkCbMsAO8TW//Sct6FNOHc4Qj+3BcE64nuBYUbPAqYasaxgpsU6SS74K7?=
 =?iso-8859-1?Q?nDu1sOuVxdQRBtmp5Uhkv8RY6uWUveJjNF3louLYsFjcknJteKaNBKl1US?=
 =?iso-8859-1?Q?cLRJYxcUcg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hl1+RCGWPl2hqYvpaxyNSFWioOSRrBAWSFLBdyiShi3cxiYHJF9lJxnh0Elve342g62lkr/HL4zVg5Cwfe4WXiy1k5qnmrhbXM317h0BT6qCtRzo/xdbUlhpGrRe+sGT5L1ThAp3Ojpx3sHcCN474c+Rd4947hUPGeijJyF+ZZNEMWH+gjPlTfl05wjyrBUFPrujXvAR/2Eg3CwSbVBIb7v35yHuBWJqjgamwXxNAsBj1htZw+KOpBADByydnJrv5Iy31+7b0CU/6msklVdhW9+TERO22ed/UnIYuO/okXernDLxOTAxxq6yBkeVe8rYOo5jBM7CaVGMqkNmKBVFkg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7e5236-ed90-47b5-94cc-08dedcd22d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:39.2483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+FHVm3lcvzme1b7SHlhKs7GMeeKHhR4O1hSLTlzkHN+ORTt8pI8xGum71UnVC+/Wg+X1a3yYOHBv03/zhEQfw+eHjdxRxAY8u5R57Fe1VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

