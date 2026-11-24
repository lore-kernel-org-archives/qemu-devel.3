Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF1606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=BGk1iZys
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVjUr-0003sW-Sg; Tue, 24 Nov 2026 00:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUm-0003qo-BM; Tue, 24 Nov 2026 00:55:12 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xVjUH-00010V-7g; Tue, 24 Nov 2026 00:55:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKNbuPvJekhIIUsfpFkIkypIK5I0qjrTlMAOM/MpzX/XuyIYwrWo9AXcaQUHWTmFrobC9sXLgWtytxZ5AzaftkT6KKBZcIXZ9n5jrqcdh+AS0zurztoET3XkxV1UINBtBAwscekuPqS3k84YktG4WlPvZJRW+6TQp+X59UaWcE7LS+rM9oPLk7HQVzQu5rDDBn78hI/zsCRCfeLc1BjbXa2jcJ4gv8U+HJhU5816ZGtZqiV5alGdcj9JuzNYFpL9Z/k3pignwWCylmHJcKAPkr36+tFcD+0/s4Wcx/JvrQUuo7TrkOz3IgSCk5ZcJAzbKydYKeTbbNmpWXA5akkyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avviC1efFBHVt2rS/qz8yVn+X+rZ5TaQYdFvSyiqI9o=;
 b=KtG5E1mR65q3hm4O50QanENIOaKxhOl7HWdPwCvu2QdSvI2rFOupWdF1PQR7IYTA20rPwsIyHZWhoZM41sI8Ce0VSPZv4bMjB/o994z1CQVp2tJOCuIPTh7KJl5lhwsn681nIiBwWFf/Wp/rLcXIRopbAEqxblkXat9UU5GOF5iLf0BwVDo+vR/RfnW/a3tSXzFyADpCBgC95DY41BBjMMPiEnBSyzFmwwJczETEUnub8CG6aZVm1bLAqLOahScY3Mg99OD1ha77yW3EpXrjNH7m4eWLgItn3NXL9q4DEytxQpqx1QdK9oxf2osEj9vwF3jH1kHDvskNPBUGNrH5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avviC1efFBHVt2rS/qz8yVn+X+rZ5TaQYdFvSyiqI9o=;
 b=BGk1iZys8DsXVosoboO8dqaw64JBMtHyRmoXnzikzjbkvaL2i82y920zw3kN7eVRCl2oEqtgspsYsULLuA3pFKRR3U8DDEvb96d75/ALI6ZCSf9pKcKE6ksqcVaCeGj/iocUm7d8DEl7TjUfEvSCjZgg0jBO21DcRVC7ESfw5iV4btn/DQnOq9BHxIdaiu5SAmQ4O0OtFwTllDJPpXtPAQsM00Nf/sWo7POAe46wI/hTgvkw80r1QA2LjQWIeS0MGETX/I/mUp2QHKI5L0KOmWwtR1cxJnOkC9Ggor4djcca+WI5NuO+16A8vToWLIZdPvGFUm6lT5SpN7BaIfHjBQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8060.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 05:51:55 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 05:51:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
Thread-Topic: [PATCH v7 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHde9fpzrU/GsehrUaAdkQgtLPCXw==
Date: Tue, 24 Nov 2026 05:51:55 +0000
Message-ID: <20261124055150.1328856-5-jamin_lin@aspeedtech.com>
References: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261124055150.1328856-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8060:EE_
x-ms-publictraffictype: Email
client-request-id: 94da663f-33a4-4991-bd83-62ce4bf31f1c
request-id: ca9e9e58-391d-41f1-832a-08df49ef0bc5
x-ms-office365-filtering-correlation-id: ca9e9e58-391d-41f1-832a-08df49ef0bc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|261102123227099003|38070700021|10067099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: tY5Gk3k7j+t3uWGzNmbsHFmJLeSfr/SBggjMRoFbJGV4HXzmmz29/NtvqBsoxtE7zSpQR2WARWSOWnI1nIZJytrFjl8s2EIm81cS1+HrZSpdaZXxRv615u4PFQPvYIM+KztsE8i5e0kBl2DfE7aD5V+P6B7o04myMWHvJtezdgHYohvUqsCSoTsTQQHGawecZTHCaLJxTNyis+zsv8ue/dqqMbrIhPqKLa1FFgij6CbV6kss+knDukY+DHN3Irha/JnoPhOe2b20ZMoXQsilI5cYm/D9lYXTYMCbfryme9umajVBeEluzYwwLI5A5IvRr6AOpUP03xJRLMn7Ai8KX6cj9tkP+8CYBzuENGpPzm/q1QIus0dlIp4M5h6EwmbURYgFxkMOMkBBqEuDZeoz4kNdxIqV8nHqAO4MuDwwwsDc1AySQmvJlkb+pS9QApHq3oLJxqPIFSFr1ul2Q8FTI4gAAQ8Z3mebioQ44UUJwKiHWjxiLc5HONCdW3ralIVBjHq26G6mCajfhZy1/V5qmhwQJozMpKpSYFK+atRuNHjBK0xGpVNt/DOFIayG+BXPwNogqklwXLLVdBdOAG+VvSdwEmkcS63+63dBspS2LTk5WTUNEHKllYodfqoIYw34sDpT3I/iCHFb86oo4MOC20K5RxCrMCdzffa6IcOlhj5utmXLdmvY+AeD/SnVl3ZrUtB7daXeMnefNyInLQ65X1RNvImi6b3zzmniysaEFeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261102123227099003)(38070700021)(10067099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vd9i/Bu7kijx1Yh+mA8/7LU8OLO4CzETV3BZ4s5uygpBuoRdorDH+wo4lv?=
 =?iso-8859-1?Q?8vsmO67s1pOeqBOrQWU22X1y2uLWZ3dPsZtdD7WlJH5MNfP+2p1YyI4VdE?=
 =?iso-8859-1?Q?I8QPtIS3rO2Q003JVQGlNerDsD4B2TsaL9Jz8DqybAaNYRM8T/Wa0CTCKr?=
 =?iso-8859-1?Q?dWrI1m1DYfhrAZJb9AAnXPGL1iGUVtc5pAx68eRB7EULH3jHDwPB2N3XNP?=
 =?iso-8859-1?Q?xzHvcpq8Me6ydIfc31A7lQCN4AT6gFf8VOm+WKUmNZub2pw5MzGiy2NF4+?=
 =?iso-8859-1?Q?0sx1Mh7i9PPowi8XnQwtLJ1tdy+TuT6OI/a3bJh9neOCAgiqwCLBquaLEB?=
 =?iso-8859-1?Q?mmdr11hzVtIe8PP8vkXp/OwMeL6lMRUz5DWDTkZqJooL2zholV1HIBleaL?=
 =?iso-8859-1?Q?X5lFaWk60o1XQmP0UI2o0dgpaIDK1C+CBpW/f8q5xcTcusn0BtEMO8OvHh?=
 =?iso-8859-1?Q?pkb4t7tYXOsF4pr8aP6TRIWQI7P34LSDiyf9mgEUg1dIguCdWbeZ13shZM?=
 =?iso-8859-1?Q?QCycRCRCX407gC+qdm+TUOhVWRI5gJ5zkPZAdd/J5o5pVY1u6Dd5bLU3HR?=
 =?iso-8859-1?Q?pg46pOGbYWt2uXWeyVvW+LpEgWx6xq/fiLymybyju7STJXUE/T3+kJOP5F?=
 =?iso-8859-1?Q?sXBAHKI7L/sks7j6vlIi/rOaNkIYtpTN+KuGn6BtQYF78qQFYnxIaBDcZL?=
 =?iso-8859-1?Q?dGWVjSyjIEZECsUCNW1TBn+xG91C05EdbnOt7m2PQh101tC6ys7BFgHrOg?=
 =?iso-8859-1?Q?z1ej97plDlL3NQEnj8WQbZWHOwRnLG5ap4PUTKG0ivdmBjMhk9u6DrcYUC?=
 =?iso-8859-1?Q?4O4HHiqwpS3f1dlLjhg6EhhDWIh5l8DLWBDMCNOd25zsFsAOaYCPrURj2z?=
 =?iso-8859-1?Q?ByXsqCjZObSouw9ZCFRoWsjBbw4oYD7GsWFUIlGlRHdNkoBNUIzk8Q+PX8?=
 =?iso-8859-1?Q?n7UFkMzS2Fd8MwL24pr/E8E+i7RNf5R9NlQhuYahspeTKFiyDwH5H3hnH0?=
 =?iso-8859-1?Q?qwQj5SB1YBJ9Eoy6f0Kwb5jOowhGM96iXghcpYDVt51edSWrfrTaVyI+08?=
 =?iso-8859-1?Q?RhdochpqaZlQIC3ifYTOOgqUM7GQKMNC/tFc9OMo90eEZ482JBWxuCMLbQ?=
 =?iso-8859-1?Q?LAVlT4WxYGYXd2q61BKCYE0ZMy1TaA83epmlnPGTcxd3DxsF0P8VW6ygH3?=
 =?iso-8859-1?Q?3r9BG/TifsDwduVBpYfzpBnKhjtW2tc1JD228XkA3zkyiyigI2+/NlUIE5?=
 =?iso-8859-1?Q?oh+TwqXujrZ1rxSSjKxtsGMyx4a9wiFLnQan/ZdAT9Zf6PdHJXrvYjrwDs?=
 =?iso-8859-1?Q?BcZhmpP5SHDz/0WfnqipMuz9psgyV4tIca4inQj9nVUBi/OY9/gN4BdTgy?=
 =?iso-8859-1?Q?DkSkQc1urBdfnLd6dLL9rpAIhbLG2OmOPzUnO3Z7EQOurPKDCXBeFUz7pU?=
 =?iso-8859-1?Q?eSWS8lCFsb2t6K/PbueILDwiREGgbO9bC52yu052I3SiUTTf7qLL5otg7x?=
 =?iso-8859-1?Q?5D2ROmN3fV2wWzAWIZoBSMUdRHTxaNYQ4K9gkOgaqgrTTaMU67QXRpHYuV?=
 =?iso-8859-1?Q?hPNOpfNoeSKG3GM5kYamjWpzYzlttkd2BRju8s6xLBd4g+1kE2wgftZo+z?=
 =?iso-8859-1?Q?oUj/oinlJj1YbrYPNh1RFxSZOr4Lec7OA5ETeXAz2s/KjNHAK5rxpw7LLP?=
 =?iso-8859-1?Q?g1dX0QwAgNmC2wiw/WdYTDAMS/nCKYTOLNaP28qPSnWUUYQpOWWHN7+a8v?=
 =?iso-8859-1?Q?MgzQOrKoA0RkZEpFfkLylEwjvGe9lrFAAihrVVzDausVQkVt68infNaUcI?=
 =?iso-8859-1?Q?Z/BtNmRNyg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9e9e58-391d-41f1-832a-08df49ef0bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 05:51:55.3255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxfmI9v5aqNqgcshnCSAjAfdRR64rqoekjkDCTrfMy5X04oxQQMb+RSjCw1SgEsTU/SpLMjj+noPIDcjvb6KOOjsiwyqXZkRzsRTGR2WbQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8060
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds two MemoryRegion aliases to support PSP access to=0A=
SSP SDRAM through shared memory remapping.=0A=
=0A=
The SSP exposes two DRAM aliases:=0A=
  - remap1 maps PSP DRAM at 0x400000000 to SSP SDRAM offset 0x5880000=0A=
  - remap2 maps PSP DRAM at 0x42C000000 to SSP SDRAM offset 0x0=0A=
=0A=
These mappings follow the default SCU register configuration used by=0A=
the ASPEED SDK firmware, which defines the memory window mapping=0A=
between PSP and the SSP.=0A=
=0A=
The alias MemoryRegions belong to the SSP coprocessor state itself=0A=
(Aspeed27x0CoprocessorState), since that is what they represent; the=0A=
SCU only holds pointers to them (ssp_remap[0]/ssp_remap[1]) so its=0A=
control registers can reposition/resize the aliases at runtime. The=0A=
pointers are exposed as the SCU's "ssp-remap0"/"ssp-remap1" link=0A=
properties and are wired up by the board once the SSP is realized, so=0A=
the SSP does not need to reach into the shared SCU.=0A=
=0A=
The SSP cpu_index is only known once the SSP's armv7m core is=0A=
realized, so the board also sets it in the SCU at that point. Its=0A=
"not wired up" default of -1 is set in the SCU's instance_init().=0A=
=0A=
Since the default is no longer set in realize(), the AST2700 SCU's=0A=
realize handler only forwards to aspeed_scu_realize(). Drop it and=0A=
inherit realize from the parent class, like the other SCU models.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Tested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h |  2 ++=0A=
 include/hw/misc/aspeed_scu.h        |  3 +++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  9 +++++++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 24 ++++++++++++++++++++++++=0A=
 hw/misc/aspeed_scu.c                | 15 ++++++++++++---=0A=
 5 files changed, 50 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index b0d72f9163..2939ac1b1c 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -54,6 +54,8 @@ struct Aspeed27x0CoprocessorState {=0A=
     MemoryRegion scu_alias;=0A=
     MemoryRegion scuio_alias;=0A=
     MemoryRegion fmc_alias;=0A=
+    MemoryRegion dram_remap[2];=0A=
+    MemoryRegion *dram;=0A=
     Aspeed2700SCUState *scu;=0A=
     AspeedSCUState *scuio;=0A=
     AspeedSMCState *fmc;=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index a7014e43f2..d4a5fa43d0 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -44,6 +44,9 @@ struct AspeedSCUState {=0A=
 =0A=
 struct Aspeed2700SCUState {=0A=
     AspeedSCUState parent_obj;=0A=
+=0A=
+    MemoryRegion *ssp_remap[2];=0A=
+    int ssp_cpuid;=0A=
 };=0A=
 =0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 73362b60d2..2ad1ad39f3 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -153,6 +153,8 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspee=
dSoCState *psp,=0A=
                             &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "dram",=0A=
+                             OBJECT(psp->dram_mr), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&s->ca35.scu), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scuio",=0A=
@@ -163,6 +165,13 @@ static bool ast2700fc_ssp_init(Ast2700FCState *s, Aspe=
edSoCState *psp,=0A=
         return false;=0A=
     }=0A=
 =0A=
+    /* The remap aliases and cpu_index only exist once the SSP is realized=
. */=0A=
+    object_property_set_link(OBJECT(&s->ca35.scu), "ssp-remap0",=0A=
+                             OBJECT(&s->ssp.dram_remap[0]), &error_abort);=
=0A=
+    object_property_set_link(OBJECT(&s->ca35.scu), "ssp-remap1",=0A=
+                             OBJECT(&s->ssp.dram_remap[1]), &error_abort);=
=0A=
+    s->ca35.scu.ssp_cpuid =3D CPU(s->ssp.armv7m.cpu)->cpu_index;=0A=
+=0A=
     return true;=0A=
 }=0A=
 =0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 8d333ef3c1..db296ad9dc 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -181,6 +181,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
         return;=0A=
     }=0A=
 =0A=
+    if (!a->dram) {=0A=
+        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR=0A=
+                   ": 'dram' link is not set");=0A=
+        return;=0A=
+    }=0A=
+=0A=
     /* AST27X0 SSP Core */=0A=
     armv7m =3D DEVICE(&a->armv7m);=0A=
     qdev_prop_set_uint32(armv7m, "num-irq", 256);=0A=
@@ -229,6 +235,22 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCUIO],=
=0A=
                                 &a->scuio_alias);=0A=
 =0A=
+    /*=0A=
+     * DRAM remap aliases used by PSP to access SSP SDRAM:=0A=
+     * - remap[0] maps PSP DRAM at 0x400000000 (size: 0x1A77E000) to=0A=
+     *   SSP SDRAM offset 0x5880000=0A=
+     * - remap[1] maps PSP DRAM at 0x42C000000 (size: 0x05880000) to=0A=
+     *   SSP SDRAM offset 0x0=0A=
+     */=0A=
+    memory_region_init_alias(&a->dram_remap[0], OBJECT(a), "ssp.dram.remap=
1",=0A=
+                             a->dram, 0, 0x1a77e000);=0A=
+    memory_region_init_alias(&a->dram_remap[1], OBJECT(a), "ssp.dram.remap=
2",=0A=
+                             a->dram, 0x2c000000, 0x05880000);=0A=
+    memory_region_add_subregion(&s->sdram, 0, &a->dram_remap[1]);=0A=
+    memory_region_add_subregion(&s->sdram,=0A=
+                                memory_region_size(&a->dram_remap[1]),=0A=
+                                &a->dram_remap[0]);=0A=
+=0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
         return;=0A=
@@ -298,6 +320,8 @@ static const Property aspeed_27x0_coprocessor_propertie=
s[] =3D {=0A=
                      TYPE_ASPEED_SCU, AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("fmc", Aspeed27x0CoprocessorState, fmc, TYPE_ASPEED_S=
MC,=0A=
                      AspeedSMCState *),=0A=
+    DEFINE_PROP_LINK("dram", Aspeed27x0CoprocessorState, dram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index df26dd0ef4..1568b74964 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -947,9 +947,18 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj,=
 ResetType type)=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
 }=0A=
 =0A=
-static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
+static void aspeed_2700_scu_instance_init(Object *obj)=0A=
 {=0A=
-    aspeed_scu_realize(dev, errp);=0A=
+    Aspeed2700SCUState *a =3D ASPEED_2700_SCU(obj);=0A=
+=0A=
+    a->ssp_cpuid =3D -1;=0A=
+=0A=
+    object_property_add_link(obj, "ssp-remap0", TYPE_MEMORY_REGION,=0A=
+                             (Object **)&a->ssp_remap[0],=0A=
+                             object_property_allow_set_link, 0);=0A=
+    object_property_add_link(obj, "ssp-remap1", TYPE_MEMORY_REGION,=0A=
+                             (Object **)&a->ssp_remap[1],=0A=
+                             object_property_allow_set_link, 0);=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
@@ -959,7 +968,6 @@ static void aspeed_2700_scu_class_init(ObjectClass *kla=
ss, const void *data)=0A=
     AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
-    dc->realize =3D aspeed_2700_scu_realize;=0A=
     rc->phases.hold =3D aspeed_ast2700_scu_reset_hold;=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
@@ -1196,6 +1204,7 @@ static const TypeInfo aspeed_scu_types[] =3D {=0A=
         .name =3D TYPE_ASPEED_2700_SCU,=0A=
         .parent =3D TYPE_ASPEED_SCU,=0A=
         .instance_size =3D sizeof(Aspeed2700SCUState),=0A=
+        .instance_init =3D aspeed_2700_scu_instance_init,=0A=
         .class_init =3D aspeed_2700_scu_class_init,=0A=
     },=0A=
     {=0A=
-- =0A=
2.53.0=0A=

