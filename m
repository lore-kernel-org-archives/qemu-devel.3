Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A168ECA9ED8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mf-0001q9-GJ; Mon, 12 Oct 2026 02:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mY-0001nC-7L; Mon, 12 Oct 2026 02:45:10 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mW-0006Ms-Pv; Mon, 12 Oct 2026 02:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qV8pmDVTvjTT7EsNDjxbpCzZU/tr3sTxNTQ/3/rqMYmqt99pgKv9ep7+374lQAfHjEm0LEEn4fjKnk7vKgc5Vru/mAdV6ARFNfSdkN/IMjFI8edBsYkPu+O3VJU5QSVOwPdjo251Tw8gLZlRe0Pg1076q5UPpFGvcw3w7ADtJ64cYU7Cw1II6rjy1NSeWJZv17IONigRhPQEPOfJp66z+gZM/mP5Vyh1emCsZej7EpirpsrBCF3YaqvdHgrWSvANO69X0klU1EQjgrCgel24GzR5VQJnVg3ohrnpYCuFSuFx7HhXc3oVOn0KBW9+0AWWwTvbvWBkN+nVEr6XzweGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GEa/hv9cl0/UrYqvk+TgYVNGaN91P5fS5TLFNnTi8o=;
 b=doqPcpXsYotnzyARHrWJT2RfDkLTplnS5Eh1aHanbfDPiMLklvAlWL7LIgPuK3cH8BZNxuTI9WpmjaFOLoma0psysPcqUlrh5B5dLDGcDQm/BoZVbgQBQBdqMXWIduKY4d+j+r3k5g20JiWpI5MrXytwoHoOgkRlegAjFMw2xIncayko/eMnPzPHJE3gUnD6vJrjFGrTtr8S1PXRV49cHKvdw4rrQh54tNqcMij7C3y9Y8wiugz1wiV+M9h2PZbjUwJzU40Zrn6/DwUxmi22iH0q6OQpjTPc9I/Cd0IB8WVfnJfalAafYJxVLAVHIFpdOOS4CkTEJRS6D7pkGMAO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GEa/hv9cl0/UrYqvk+TgYVNGaN91P5fS5TLFNnTi8o=;
 b=St7ZRiAcs0ebe1fVLxJuhPzFPjFYSBtocKnZ6lRppa/PtUQ1GM6lWIsg+CYZfOjTGA/n1+kp3ssfLxlGFxm5b/ULWvD57PyhDHraFjqqCvp98/LJm4tcWCHg9xQL4C/m/ksdPpLbb2inc+LES08fiaSigLhIjxLvd4MRiY4FQHJLSv4zJd9bPhIBG3wG53jeVOBrKWCcNYYIwIXnvErKOkFk9892eiGkCWtltkNP2zYCEC3Y/5gYwQuBmGDCIIJuATDRgQ/H7di3y114MydVIgf/RzKlHAnH1v4CyuncQrBVjgCQi7rKYqOUflSQGLgxFXHsShKNy3p29yOLcrMU/Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:54 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/12] hw/arm/aspeed: Remove unused unimplemented device
 fields
Thread-Topic: [PATCH v2 07/12] hw/arm/aspeed: Remove unused unimplemented
 device fields
Thread-Index: AQHdWhUwhy7gpj1VfkKqRmQEFdqdaw==
Date: Mon, 12 Oct 2026 06:44:53 +0000
Message-ID: <20261012064445.2571633-8-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 1bdaa970-516a-403a-eed5-08df282c529c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|260925021311599003|260925022911599003|260925021911599003|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: cG7W7uLJTLJ05OBRt7PI2rMPAMOLrcegtBa4YRpf8Yqzrq4ijziNvxcJ4dvszhBnPd6qQJRTdKVtepcZrQHckZ3g2UxrWbZdPqyGEmOzrU/XUbt9aFSTAN0VeWWk7hrL8EE9+aHgU0yv6VCOX+WtUNFvu11JLprWyk02cYfw/h036Hc2MbxiN4w3dnSm54+2yRXrVN0ltbQbwb4lqulSmfPjloNEGZZWoBH0ug2i+9OfLGauOXrlnQgxQsgTQdkAxNhWbyU7I80KXk5XjM/bgq+FokTjZe8O4LHzBt2HxuimCG2GvccXR/S8hiaGmXiTsWGvCBUE+47dPGFTl4FO+gvD8HG6jtDSBk8gviDL3/ulaPHr8F/NUNXLkxRIMSUBpUJQ5B2hikYhY1WDmm9jTE5tUg6nZH7FFXbdsRXRrfyA9jrSAYhbr/GGciqTV7hQ+soxPc91wyCMrQqgXXPr7ySdjVxrmEOgf+U12JCJ2IskhhlV5eC3mVNN9EHBZC3UMdspOVK+RyZZ42BhBnSZvYM8aoUQUl5BtnCdnAC+AyUYuPgYBysMr+guIwdc+dLIFXrEYlqf1mCOcGxse3J7h0K7J2uXMl+6VVFW04vvGZhWRl3owHPsxESCw6vazJW6vSqX3byl/rppkM+6AlkKQqWbhtsD0PsZWkaFUiXcRBNqPIkbhyfg0fRwBGNpZw+yi7uWLbfQW3K9RN5GCxLXp1l5UlCf7P93QNKxdMPjTxdl1WjwVuSNChvFa5TAvV3M
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?16qQ5BhHhm3hqL5zSfRLF6U8fgQEOla8l0UYVvPu2WWTyI6Ca3ahWVomn2?=
 =?iso-8859-1?Q?84S7j9LGJD08cSxaU9AoYAK/SAnB+ZHtPAoV7yWTat/XBL9sbWEf3O0oo3?=
 =?iso-8859-1?Q?qIkoRBzK5JpidjWP++NjAQGS+Mw2h6nlyw6rg/5v+OJF05WjtehWMMJSy9?=
 =?iso-8859-1?Q?480IC2Njh/HCpGePbsK1RuiKoOUoz0DbQ+0YJJY5wfWjRfqi4VKhE3nulW?=
 =?iso-8859-1?Q?XFkwl5NV9J5oOtJmiauubyAvFE0FaJFwWSSGaSHSf/FcTjF9acAVlPW79E?=
 =?iso-8859-1?Q?JHK0SflFjNc+fsc0jY1mT/PNcKiY+Cdh87eDMVhpuK5GJLIrETpQb6/DsH?=
 =?iso-8859-1?Q?qj337coQdaoc50Ec5w4JIYMB4HbFlG4VLTMcdYq/FZ9sQNugXXGwwIboJq?=
 =?iso-8859-1?Q?PjSabSfwlSLJbKC95PPJcuMvsNmB6LiY/97giRrdQcWZ7/VxUQMr5285bx?=
 =?iso-8859-1?Q?wg7SnfSFt4duZ/Pek4B3a7cgbD8NvjGXVbHTgM6rz1lLM8eZtAuSlFjgTy?=
 =?iso-8859-1?Q?1IyEDuAy2Bdfl/Ol9tH+rz3YDBA+3CWnLFosc6l2LGI8pelvo4j7lXqd+9?=
 =?iso-8859-1?Q?PPNdKNMZmCq5M8TeGVBq4KEP4nnGB6zfe7FFZ5yqRAm8eTTB8RXR4pa9bt?=
 =?iso-8859-1?Q?lundslRrhVuq3REB2HWXsAfwpLXIxPPCa2ucEYfQs6C0iI2zX3Idc+YmXw?=
 =?iso-8859-1?Q?YPMfQpQ3jQi4+diCmI/19IdQ1fJKb2uXL1Vr9drl1uygU5NUzROkc7XmJk?=
 =?iso-8859-1?Q?onyhQyMUHZmy5G0FLhONeepQclqT741GPvV4yDA6BGMOlCvvl3+fQdOBuS?=
 =?iso-8859-1?Q?o913QArDqd7aVftobg3J+bTCj1N1qlszh2OVT7ADq6hakxcAMcFx1caSq0?=
 =?iso-8859-1?Q?JQgNrp9ZzRHsvUnh2MOe0yD0AUXVpBEGsKsuII4quCfn1DxzlyINX9OxJW?=
 =?iso-8859-1?Q?uuwU/CLTpEiUPa9sylml4lMH8l56oxO5U9TroTy9iiWiDkhdlPR/qtauGM?=
 =?iso-8859-1?Q?nQjljlHPtKFjrXrGlbmJiDO9/En9I50NhDKgJ0gIKdIEhP1oBdu6Zn0T0o?=
 =?iso-8859-1?Q?lXImWVJQafmygOjvDKC4CMWHTB50fibJaE1G+9pLtGtX1hIW8YeM7Yq/Bg?=
 =?iso-8859-1?Q?RbUgtDczbeoeCjSVruLTvTwl3SzzVxPIeiniigatbFmlsT2TxEpZ/EtOXQ?=
 =?iso-8859-1?Q?Buh72qkl359t/R/WpVobxgclc1j+56wONgLq/hEzWb2qWE7gWF15FqKyHR?=
 =?iso-8859-1?Q?VR5xY6s8ryQyluIivq/Oh99q9CG0FPux2eufTHHMueb9snhmnY9NZsq7lp?=
 =?iso-8859-1?Q?vzU6wzxPAHjgPeOFDC1EtEPO6cNrkqBn1htXwj22RKNnodfk+ML1SPT/ye?=
 =?iso-8859-1?Q?Si7D7qTmvB+2YWJwVjWFr7Cbgk0ziLpZFQRr3DvszxKJBNsYhgQMJnVmTy?=
 =?iso-8859-1?Q?uJ9ZKyZ3GSW+vgjzxFr7pKFhXMwme+JjA5VmmDYw4l2/LvsjXqyQNU4tSt?=
 =?iso-8859-1?Q?iBsRsylNw46XsVGQIPcdi/9ItYDckmvBoquPQdFzxgx3HrYbu7xxiHVTGC?=
 =?iso-8859-1?Q?MfCaJ+HX6WQ9IvEae4W5QwI08TicpQfsFC6iBOBHGX024NdWlxxs7MiKGG?=
 =?iso-8859-1?Q?ZAYLVCm8qqjPiJCgMAtVbMD0OPLPmJtkmQtqT9hxkGwY1lwupc1xgngcKs?=
 =?iso-8859-1?Q?cd1cliFztGo0sEO7rnqjhW4iFESYCkvNQsnf4oPV+i77Pd5JEmBhKm0OFW?=
 =?iso-8859-1?Q?LPkvmJaK7THjDvSJ0w1czBh2pMdwqbZEam0epM4XgVB0K49nldGHBSbjJj?=
 =?iso-8859-1?Q?hU1Z2bZZwQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e0OZK6OOG2oy7LUs1v6AaqjkK6VMMzs4IfcfGPYUKztkbJi7QNmCUIvVlH7/tWU4/tfDPOelkPu4N22quuvNf9bChnQduJOI7y5q5/gfMDNDr7TWbVgXXh8Dzri1s8y2UrE3zXDZnvAogmaOkh0SZkhpfswl8wWHNSaTgpkYRg84NDFPAhu2wH/zawQSQ2QvCQ3IcZrcerKbBO05jzhWUyxUXZgg5p02T9pwOUe4n5WgamGhb6a2D2kam50GotLL034vCIrzuY4BKkX9VqPbzAYLmeeWNns0TCxRQpDx6ANxLn1Fe6fM4hQUOpULo3RvAd37gaDB2UlpJKp9ymyRpw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdaa970-516a-403a-eed5-08df282c529c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:53.9311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvO94IjMxUx3eQ3hCk2Zc5O2HFEnwckvNb494tkxR6YsNGxkE817tqOkytOjLt8ImNjBIysDJ/cMzVsZ3OW+AZgB7dnCVbM3sZgLNegDBcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

All Aspeed SoCs now use the unimp_devs table and=0A=
create_unimplemented_devices() for their unimplemented devices. Remove=0A=
the old fields in AspeedSoCState and the ASPEED_JTAG_NUM define, which=0A=
are not used anymore.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 10 ----------=0A=
 1 file changed, 10 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index 8426134223..4ef1014ad0 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -59,7 +59,6 @@=0A=
 #define ASPEED_CPUS_NUM  4=0A=
 #define ASPEED_MACS_NUM  4=0A=
 #define ASPEED_UARTS_NUM 13=0A=
-#define ASPEED_JTAG_NUM  2=0A=
 #define ASPEED_PCIE_NUM  3=0A=
 #define ASPEED_INTC_NUM  2=0A=
 #define ASPEED_IOEXP_NUM 2=0A=
@@ -110,15 +109,6 @@ struct AspeedSoCState {=0A=
     AspeedPECIState peci;=0A=
     SerialMM uart[ASPEED_UARTS_NUM];=0A=
     Clock *sysclk;=0A=
-    UnimplementedDeviceState iomem;=0A=
-    UnimplementedDeviceState iomem0;=0A=
-    UnimplementedDeviceState iomem1;=0A=
-    UnimplementedDeviceState video;=0A=
-    UnimplementedDeviceState emmc_boot_controller;=0A=
-    UnimplementedDeviceState dpmcu;=0A=
-    UnimplementedDeviceState espi;=0A=
-    UnimplementedDeviceState udc;=0A=
-    UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];=0A=
     AspeedAPB2OPBState fsi[2];=0A=
     AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];=0A=
     AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];=0A=
-- =0A=
2.53.0=0A=

