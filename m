Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3762C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOSa-0004FA-Dz; Wed, 08 Jul 2026 05:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSX-0004Dh-E0; Wed, 08 Jul 2026 05:20:49 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1whOSV-0000NV-R0; Wed, 08 Jul 2026 05:20:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWeMO8WWgDzVNFdcimmdNoNJeD3SF/deNfpk2qFYK2dyqaJxdyd1hX9GmxV3NAhYqZDs9BKmRa3WH3C/+NXmqNp5MDxcpw89nGKl7TOIe09IiKLJWSj3/k7AGjeYqgPzCcR0CtFKdCxZqfkPf+bbH0G7LsfeieYxTiJBslWuTuIVHBMcf08EP44r9yINc/642HwpZ9I8DlIATcWFunqbNSvBD1OqMcW6feO5DhIlKr72etR6jHNqSKf+zoezv++GC+qD7m0O0yY4Mc5zbPdFaT3TVICd68u4s0erUHr7DnO0atvTcsWjFyM2cYBuEDWHPZcupzhmxy6PDCLHw3P89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZwnLz7yBVuZA2Gc2gtHZID4nj/sqQx37C2TQXrQUyA=;
 b=PpF8WeHwAKQirxAhJfmyTO/+37mJ/WDDU/OFwAXK5mMOMi84kgk296uZijm17Gw2Sm8iaPFgLhWcHujlmh2UH3cSEwY/R+B5Otd7d1p5bS6nHGPvBrSCCXaNJAPbwfhha3ucSJ9fwfnQcSZnppLuK7HwCVa1fthJXg4HzN/UR5qRAhp3EvhWd6RDhKaIORMQ6rH+QBZFI4fSHLa0vxQl3KInse9fwuy+g84ZGcMGHMIGtm6IY30PWreBYKakYsQyR018yKtwFkcne00l/IFQJODyVAQ736tHOzvgHsD0iGoFgvP28Mg3RSoxT2klawTG9pcRpP6lv0eEy9E4yvgilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZwnLz7yBVuZA2Gc2gtHZID4nj/sqQx37C2TQXrQUyA=;
 b=DucdtCJGOW/8TJ3+pn7ofl5C5om73ea2HHDwNyR8ZgVicHJ+ZP4zC30lSVwOTM0VTE536PBgdSAewNV2Cf0CjHjnQVW2P9JUB37wU8YWviJvkd/Z49rTjnJtNwa0EBJ/YtC1CVAtpGna5+Dv/lrrjooKr737AIokL8yjO+LL42ROOmrqKakg8e353hnZlYvriWkszTs822iPVhxl/q1M6gMoVf8C8rpBytg1dE0EMg7mnrtGidyGOTeuOom92hPbiezqqsNeKiNTPCzo5ZBL3PWcgmlcDNUwtiGZCWw4wkPcmy9G9bX54C19IT70dUENB9eJlIVWKpCMj7Bhy+ItEw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 09:20:36 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 09:20:36 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v5 08/10] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Thread-Topic: [PATCH v5 08/10] hw/misc/aspeed_scu: Add SCU support for TSP
 SDRAM remap
Thread-Index: AQHdDrsIGfwfDmEl1EKSoooTz47ekA==
Date: Wed, 8 Jul 2026 09:20:36 +0000
Message-ID: <20260708092023.3826159-9-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: be61f71d-104c-431d-0c5f-08dedcd22b80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|38070700021|6133799003|56012099006|921020;
x-microsoft-antispam-message-info: 8Uzy4CFXAfbJpqoy+BOe306LtJuO6DsfLgYkEeoNl0HGxkgXyA0ucWxoY2Nz1OICQ826+Szrn3asO2HozKnEg1WPeTW/1Clg7m/iNUnyXWy+lXnaH/AuLAHRC4qEMJwy/DN+iJj7hjb4DuuX+PCilyeOHPXOHkW6UwI4AwP3koppmLf/wyTudFYcEAdviR5X8G5XGjiSG96aAtpTE7mNcMp7lzHzfdwId4btkoPNg0uVS2bvNx7NTB3Mwe5YxGcwqG9j1diQa8yzZAFtCukpuQ6M96J4M10UqAGpPi95O1YszSJtcic2Ux1EwfHpdOwiYEOpNlTrimmTx9Ry1nEs9ThdVHxXDQqy0zCntR5E6VIX9gyqM97olmTnZJ6Z3WZy0DtlfFlG+E2lBFE5dvs3J/Ybe8vNrvX4QYM3xiTNJDJ1CJSlzqJafxszsPeTtPTd58pkvZ10RpiOML5MZjfo41PEQDemM2wZa8rTJAJt+fG24YA2uF6UPZJpjzEi73zjbJWRfrYw9Ggpg1UsQ7x0FpZuZ8CDrqESEQWX11GK1TITde8DYaboWOB5/bJIWRQqvyw/IGby5gPBE246FvGroyTAkIVdhm2VVAHMtUad2jwAFBs9aOR2BqhxTHxJX6jLpdAzyVAuvHQynVPQmegyUzBcVJ9i0TvnfdNcGyEcdVgdydq78UV4Uo38m9WC57oH2lpf8wjPCy0qU7k4tPvpmbOj4gfK2IYDo9SX9zaNG9k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(6133799003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ROLlf1ds+YVvmzvv1hEhkc6T6ynVZG2mJDyqDk4oghMdvzeUmJ/CmCYS/w?=
 =?iso-8859-1?Q?qrUl1rwINCs3qmS7lm+FhDVo/y5QR821+u7aVFFyIqnarC7XMY6h82OV07?=
 =?iso-8859-1?Q?eCK9J2730j8nBvCkv7VzfBvx2hrpGrBZdBXQCkhjSzDFlwNQw1pV89RUlp?=
 =?iso-8859-1?Q?9d6UyXvl7HueO0/JkRUG50gE8CzgXFVdPYFUYA9XLIEBxLfgCa7gqYImD2?=
 =?iso-8859-1?Q?DXpzP+ZXvJbG5ugK7mzvgqoMHQ15KsqtRornBvHHBMCxIseizTyRSlf31X?=
 =?iso-8859-1?Q?EQzjHQI1Q8CaPpiJWBKc8OBUn/fYETjDLE5LZ/X2hme/TULULv1iSItb21?=
 =?iso-8859-1?Q?nFcDBxJx/QGe0ulJqcze/RF9Jfb8Zfj+cJmRc7LmetxKDHldP7P2qzhrxz?=
 =?iso-8859-1?Q?0HyG4Q8dqHRIx1T61iSbYztj6G18pzAIkbilcgdEx9MDWdOtSX5tDsCn51?=
 =?iso-8859-1?Q?LC2R8mMsAVTOhH/msMvGR2C9GWOa3u/9W7MQlh1uGiNSH28+hX7PISLZYi?=
 =?iso-8859-1?Q?WCxzBCSoiR3E5dlvesWLzNo+FNLZsBuiHsMveenW0OhVyLlM8/Z476VUa9?=
 =?iso-8859-1?Q?19heMhiUhyZGH+nkjsAjWxU9S2s/JKHKDjm+/X3b21qt/xTEQp3VH2Qu2H?=
 =?iso-8859-1?Q?GG+FqsXSFAENSAIAwS1hFSJtGNhQ5FREoRiVYaA9icM1mDdKTEMGbJ+Pfz?=
 =?iso-8859-1?Q?r1c+QAgrA0g0bmYUdb7Lna5N9IcZiyv/+gXlXgZZGeMYbR89Es2hGpwqwN?=
 =?iso-8859-1?Q?+tkfcrCn+87ejVOfvVEpCJJFuNXGnTwL/ZYiPdVxBHrKBA4preE4QO1Kkf?=
 =?iso-8859-1?Q?5tsJN78OExiJZ+7g5Caiw29A7HDuYTKTYzlCYNcaWLa6ttsSSDr8wqhp9T?=
 =?iso-8859-1?Q?LvaJMixWz1FXE6VUOLIA/h1DzskrHlYoaScqknCtFZoLUk0YVkQ9a+cU+/?=
 =?iso-8859-1?Q?SeGpFnCTfimWX0RLybOFULgNRNB9PDnewNxIxyWBkSlh9kF2kVWPOsEZvs?=
 =?iso-8859-1?Q?e5ggCmP37xX/bUKYUCYacyeLwZBjLe0mQMv5pTV1fqwsYkSCNapF3f7Kl4?=
 =?iso-8859-1?Q?IF1cH+k3a7eeYEaG+wZiYZC8e9B2lg3FX0g+dvIE7BigVYWP6+Ota0BEnO?=
 =?iso-8859-1?Q?VBNv8QSxo+ceu/bu4MCBn1IFWwo0um2jKmNHpftvf+d7fgjbZJ80YPIz2E?=
 =?iso-8859-1?Q?NZKaWQNA4L07xQ9vELrj9VAlkpG0nBkXiWVtnI3L3eZDDLzu7BRmdZdr89?=
 =?iso-8859-1?Q?wCJIDNAB7o7fJPQpF/PnpE6Yy9ONOcAthFl4nLkkIliSyzwmB0tj3bUT/F?=
 =?iso-8859-1?Q?c+eTO2AdvQx6kck89uw2+B4i1KDkoj3RPwJfylH+eSghIecW+SuANEQ+R6?=
 =?iso-8859-1?Q?GEqkTYjVxDbxBucmRB09FC5HuGV6fE635VGKHU70mtT4ry5b0AQ2nVWKDN?=
 =?iso-8859-1?Q?v/VOT3TnG4iEBP4qBdCDXOGEs6Uq0hiDiQgMh59MOmOYmTfyhKFjZ7SANp?=
 =?iso-8859-1?Q?m8LepMIqSrnzYS1SoIPddaRWRHOC6Jw2TnH/5DSCUQttMgnMTaYl3qtCbO?=
 =?iso-8859-1?Q?YK1/pL5gMUyVGWzsm4r2LrX1EDmpvor5C8EJo3P61p+CJCAwWlRo2bcWoW?=
 =?iso-8859-1?Q?5sg0RV0ZRG1LluTDm/wmxsStw1PTsnovIWn71RpAL6m4smDrmiaG27hyxm?=
 =?iso-8859-1?Q?oe3/2oMqX78YIZMkQRNtj/WMI2+/QhXj8I0QHO2PSn0XsgFS9e7a4Nazbr?=
 =?iso-8859-1?Q?75RTZr3xqcKzV55P6iZxCYsGD7i/z/0XaX7lMNXJVl7p4pdtUbBdldjBGv?=
 =?iso-8859-1?Q?OQY5Mtz8NA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N1+NBymbNEYgULDZBb89i0vatPAuWyftr2EZs4rLuvHX0u3f3W95gLhZYs/bleWpFsNLVdm0POxa1Yxlp1Xkh8JUQo3IqwFGCKNjSJzcDFkJPoB8YgiMSaMw3OKLAgpVbvwUK2TsGdwhnaaHvhFzH9CBbXrxG1J8sAaQeF/pCdp084t7h+oIuImgBPFaJi5NB+DQhhcovK2svr87NdNjAWfRgT09YoV4vtf2jdnT7ZW01nfKK9MCkNEBULRljOAXHa/+AwtmgG0R3peQqbspNmneljVnQYwlFzxeDQkYXqZUA2NaacUiRaeI5kBdhvE8+2E7iEJN8XquthsbvcgeMw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be61f71d-104c-431d-0c5f-08dedcd22b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:20:36.3918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k901egkfnwLApYiQtJF+tXa7YgGiG5HVPJtQEALelAuWjdIRB64i82fPz2/FRasgWqBbU2RD/KGRwsw5/PtEG768SxgHYz6yLtdiZCuExeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

This commit adds SCU register support for TSP SDRAM remap control and runti=
me=0A=
activation. Unlike SSP, the TSP does not support configurable target addres=
s remapping=0A=
through SCU registers. It only supports setting the PSP DRAM base and size,=
 which=0A=
are then aliased into the TSP-visible SDRAM window.=0A=
=0A=
coprocessor_sdram_remap[2]: maps PSP DRAM offset 0x42E000000 (size: 32MB) t=
o TSP SDRAM=0A=
      offset 0x0=0A=
=0A=
The SCU registers AST2700_SCU_TSP_CTRL_1 and=0A=
AST2700_SCU_TSP_REMAP_SIZE_2 allow runtime reconfiguration of the DRAM base=
 (alias offset)=0A=
and mapping size.=0A=
=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
|               PSP DRAM                   |         |        TSP SDRAM    =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
| 0x42E0_0000_0 (SCU_168 << 4)             |         | 0x0000_0000         =
       |=0A=
|   remap base                             |------>  |  - fixed target addr=
       |=0A=
|   size: 32MB    (SCU_194)                |         |                     =
       |=0A=
|------------------------------------------|         |---------------------=
-------|=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 29 +++++++++++++++++++++++++++++=0A=
 1 file changed, 29 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 6eeb1b12e1..5c3f563dd5 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -161,6 +161,8 @@=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
 #define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)=0A=
 #define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)=0A=
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)=0A=
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
@@ -1012,6 +1014,27 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         memory_region_set_size(mr, data);=0A=
         memory_region_transaction_commit();=0A=
         break;=0A=
+    case AST2700_SCU_TSP_CTRL_1:=0A=
+        mr =3D &a->dram_remap_alias[2];=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x7fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(mr,=0A=
+                                       ((uint64_t) data << 4) & 0x3fffffff=
f);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
+    case AST2700_SCU_TSP_REMAP_SIZE_2:=0A=
+        mr =3D &a->dram_remap_alias[2];=0A=
+        if (a->tsp_cpuid < 0 || mr =3D=3D NULL) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x3fffffff;=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_size(mr, data);=0A=
+        memory_region_transaction_commit();=0A=
+        break;=0A=
     case AST2700_SCU_SYS_RST_CTRL_1:=0A=
         if (a->ssp_cpuid < 0) {=0A=
             return;=0A=
@@ -1091,6 +1114,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_SCU_SSP_REMAP_ADDR_2]  =3D 0x00000000,=0A=
     [AST2700_SCU_SSP_REMAP_SIZE_2]  =3D 0x05880000,=0A=
     [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_1]        =3D 0x42E00000,=0A=
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  =3D 0x02000000,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
     [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
@@ -1134,6 +1159,10 @@ static void aspeed_ast2700_scu_reset_hold(Object *ob=
j, ResetType type)=0A=
 =0A=
     if (a->tsp_cpuid > 0) {=0A=
         arm_set_cpu_off(a->tsp_cpuid);=0A=
+        memory_region_transaction_begin();=0A=
+        memory_region_set_alias_offset(&a->dram_remap_alias[2], 0x2e000000=
);=0A=
+        memory_region_set_size(&a->dram_remap_alias[2], 32 * MiB);=0A=
+        memory_region_transaction_commit();=0A=
     }=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

