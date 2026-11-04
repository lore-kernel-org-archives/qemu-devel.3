Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D26606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=cEUTEX3U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeMC-0001cp-B6; Wed, 04 Nov 2026 12:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL9-0001Aj-U3; Wed, 04 Nov 2026 12:00:01 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeL7-0002UX-KE; Wed, 04 Nov 2026 11:59:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkeR4Fhu0uVQicRZ2C6tQxtRot1XD+iXWvKI6XC8e7K7LFETLaMjxHIKX8Mc8jaD0BEFNlb2gT1tZHOexYurHpbOqX5Yl4pOoWHzLplzMCjVP24807G00OwiQgUK9XSUT1d4D790XMZPoaFzz2AmfAcC5UNspyqKGfOrh83rEhP1hoJzTPvxSM4tOSKf+vzI6WGm/4mlXbi6A56a920eGnnepNYofoilw82HbNwyeF19O9NXS01muQNqdYBib1Knmzg77qFRhBc1QuwhtAZZk/6pfkiBssFbucqRXE7DGEt+LdlWnNvwqJlBWe4CBHcud+HjaOE/AeQOCdH0EalH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lyTcfo/oSYlzO2K3DuQHP99bRaWHj+oP+PsUvG+yMU=;
 b=pE/01CjI4Wf+9RO2ae+kJChwL9nuYcJ+z9PbJgnFg8DpXUWLevMDFz2MEwwiM8C/JIY2VkYvgEkXAnnnu+bMS0c9Hf71ebJnhTrXw+faxTkjvIbLWutoCegsI7FtUv7YjmEtS1WfhNS3DbP28RNo8vCjzlr2OE6xWpRBNR69cBpt4zlC8i6O+4/X8y+APJh1Wta/TOhlJkNZ53haRttuaw/hnuLYtgihi25LmyBkeQSCM053BwgD5g8/qVT4voXScRP1ACK3VdL9bk2IcHGfAOzwTfCGTAJdBoJq8RSrcfTMBkFjS0ehz9z9UtVzKkFLI+M3PKhFPpIoDVK/L8hAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lyTcfo/oSYlzO2K3DuQHP99bRaWHj+oP+PsUvG+yMU=;
 b=cEUTEX3UwmDPRHLg72Zi7CXFwbDJ4hQoFLQpT7FmpG4nnAYP5U+Ax9EJEILISl+pRVpYF0qu/4XACey27uis5+gGvm2R3t7YwJA6t+OlY7PTfD/QmTBtzTTpfCCmnYAu+Ju2rz+f4TvEfUKJxOIw4XDbpEKnqAmii3tzEkyKVXgg+6NUae8dSs0Qb5yUSoasGZLxr1G4S0N2dtbH325ZjHIdXxdh+18nERvPc3VmArD2MciB/nnf8w2HYkkOgXSRjTEtTNSK9PjGNyeDTQJPcdEwVjgffukw/tP72jzye2rGRLaIKJDYgyns7T6WE5qLg3gAjXTbI6aLvBIppNzDEQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KL1PR02MB6976.apcprd02.prod.outlook.com (2603:1096:820:104::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:50 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v5 03/10] hw/arm: fsl-imx6ul: Map early firmware register
 placeholders
Date: Thu,  5 Nov 2026 00:59:15 +0800
Message-ID: <20261104165927.678833-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104165927.678833-1-bin.meng@processmission.com>
References: <20261104165927.678833-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KL1PR02MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: b213a3c0-51eb-468e-d5c8-08df3a9508de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261026121527099003|261028144727099003|261026140227099003|261009223027099003|261102123227099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YlYWdthBQlQReRZlFx32IK7jXAeQufer5oix4Y22XjMWka/ilBGH6bVCU1iQCPAgtdo7PGu3xnaHgFvr2HPkvJGdy5Kj1XFGFi/9ut8qlhVUHY+BAvro+zV0WmYTdBZ/S/Hmk5f0Pb3eC5j8BfG9zumGlezWsJQAihFOKDEJVA5Y7AOnOqCTHgDlere7fXt/DGy0B5MY5+AuiLd/seDLkbPgUoTVT6ihVcAu1DGE0RqPi1SFs8J+8NreR1QZn8LYNrEohqPMwCayXdnA5O8VpdacHiRY8a5R22yrbwxeDYJiolGTI62JZB5nmqZBcJx3vPemlwCDwvSSZ8U5fqvmlpeRAgA7omiEBasTgVFOjkeaEoNnYg7IdSnDeIRhrdYHiiaVx53/gpEeE7DoZ5O39XUsEbBKQyZE4MAGb9kGyn21R/ubgHt1dzYMx71QZOMqt4UGrT7xzYdZc7lf3YT6FRyUBU9bXVUUxJkLuFfXshw9EVDHwV5J8TPpp5ZQsag/0pHho3oj5U9GEpls/BmWikEQxFVQ2MrBSJw2cCdANWfHJ1u6g7WX5jfRergj46KLuKMRDUgnXXEvIArJecMAcuFq7OWGnDBdFiFKQ6csHB1oGiPP+Bry70bQgC6cNfqmr2gQDG0ieXJXtC7XwFnE9LitLaq8l0Z37jYC7xCY8V4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026121527099003)(261028144727099003)(261026140227099003)(261009223027099003)(261102123227099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZqEFbyGp8+1wnGFTZxZiBrK7AIGHdho1IlMgMxY2uZj8lRBQoQGGI3TxHGc?=
 =?us-ascii?Q?wk9ELxlHgfFMwrGKbbNeN38u0skqyOXfSnfjRSxBJQ1yUsiF+ivTr3/UHOTL?=
 =?us-ascii?Q?WvyBT0fJSDl3Y4XL8AgNux7DrImW+9fb03rIqk3/EpVDNFoz7/KtaeZhZaOv?=
 =?us-ascii?Q?JbWEHjWQ2WNombLYr0Q8PjK/h0kmbiUZe/8ht8Iuf6FrEC5ikbMkhIl+hf5r?=
 =?us-ascii?Q?j+1ActiY87O6MqCqFAA1jhIMV1rff3G1yLrqlZUsBv6SB/ifyt4uWVb2iJ4K?=
 =?us-ascii?Q?Gii2ZnsWDT3l1N9zqbQdngpZ6kYCiq4fFPH0TgspHIrNKRZtC26rrQAuG26I?=
 =?us-ascii?Q?hScoYtvV8MfHJwF6VLFhPneNuPkzbMwjE/MTtOmaE7KYib5TfurLtGbuqNIe?=
 =?us-ascii?Q?g1Awjq1PzWZH8GR27KQTOTLxw6bNTo/8Fzghp/rv6aZBKRAefNlU75h0aBfC?=
 =?us-ascii?Q?SV7KEUdifrxVejM62PeBtD2KWkBkWd7infmgD0+B2ayrqm8OaUOGn6Szf7Jg?=
 =?us-ascii?Q?7M0bLIb42UfQTBr8cnU9SBVQV5sRKJ7VVxhzM61h/lpReiLb8H7TLddUjzCS?=
 =?us-ascii?Q?maO87KaALLa4lKmj1fGOziY0+fVWljTAVB8Aqr/An+7mirXBRco3sun5yl+k?=
 =?us-ascii?Q?EfsKp4xLnZVhiTr1YpW2fl51+r6Dx5mW4eT3xcNPofBLPI92Akha875Lt61N?=
 =?us-ascii?Q?fz7cgyKyuMLtDyLVPEuBpbVWVmdHdTkpdyz499pCEeh/WXt/ohDxs6liLYcg?=
 =?us-ascii?Q?e+6XCyh2amJx7DYnDA7/skEsC/bMG0nHJIftcd7idD87gTsbcEB0qwVm+Qqi?=
 =?us-ascii?Q?RRaalR0+yB1SKFfLJ0W2UsaGClph9qCImuntocBd8hc9vosWuG6MdnnVxS2Q?=
 =?us-ascii?Q?1JdDnnTxZldtUI5Z62g4Wv41DiE50N+gqSEIQ4NCzwBf3aRVxsaHY4IHY6SA?=
 =?us-ascii?Q?YR6HvVETTtS+GQ0PZVOKeciMtVJLleKJqQfWJgULVRdHuOf6VeoeksBRFGa6?=
 =?us-ascii?Q?6SeoC3tb3hF/K2aRx3pznA1XEGYq0b4JOulnV8ecrESf5NHpUsubOZTboh7N?=
 =?us-ascii?Q?0YiyySHjdxijJWI3FIzkJuk+m8JudLF1D6vz/gYYIpgNBHZ7sAm4QkTWzhvX?=
 =?us-ascii?Q?GbtMk2nuECri5WMcvn9cOL/DsTYZTVCCoROrfjszZup7jUM4wtp0mcLa+NZN?=
 =?us-ascii?Q?jNRwH/LxMTLQZM9Q1P0wv6mvfuaZxCbvxQAcabduo74EdCiygmUaOi9eZ2WD?=
 =?us-ascii?Q?kPzKcb7ho+0wdY+xo+Qtahgxire9iUqH2RKYEbDp+1QiUm1FhjBL4XCWTbdm?=
 =?us-ascii?Q?28968XI7C2okoWupenYA4nGI6k88cDwtbcqrONgp0o3aUiIOy265dFbK8/JL?=
 =?us-ascii?Q?FlwlZi6DiZhqB/J8nkvDsWx0JQERBUG9HT6xiy2/hraX+2Kw/N3BwekxFBYp?=
 =?us-ascii?Q?Q8jy8hOPiWicmo1GTzERXIokKRBgXZ6O/4zTQ5w2OoBSw0/1OmkJGINBJRrH?=
 =?us-ascii?Q?opoq7DE4UCRGlTK96HpKfsBa/sPUKIHpiUCdhMdF3z717HX+YK2pswt+P0p/?=
 =?us-ascii?Q?gpeuo5yPjUJPGRjM0+3Kc7NOVKvcHjY9Ttfg0Jlh5bfGV/CVfdvrQlvVjD8a?=
 =?us-ascii?Q?ZQkPdmXL0gvthC7GFw5YaV30nse3Qe6WJQKcssxRV6bN9q/XoFyujs4xcmhV?=
 =?us-ascii?Q?otJ0Llftyvj/cM+GDGhxMTE20y9L0rFo33Kptgmtn8JkoQcHWEG7/GjsByrA?=
 =?us-ascii?Q?SpFzAESiBvEMuJ0TiH5On69YZw0XXLU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b213a3c0-51eb-468e-d5c8-08df3a9508de
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:48.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw7JlYWLl06zRGgYi1IfOzjLvfqxs0lhrUrUP+oMVXbDElrEtotIwKoaZa8Te3yWpL18qegcL0GeLqbD4Prjzi+5myWjTdAtjkyCg63oaOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6976
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=bin.meng@processmission.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot configures the AIPS bus access controls and the i.MX6UL SNVS
low-power registers before its console is available. Its timer setup
also enables the system counter through the control window on AIPS2.

These blocks are not modeled yet. Map unimplemented regions at their
documented addresses so early firmware accesses complete without
falling through to unmapped memory.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/arm/fsl-imx6ul.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index f72121e23d..c7f7e12341 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -201,6 +201,21 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("a7mpcore-dap", FSL_IMX6UL_A7MPCORE_DAP_ADDR,
                                 FSL_IMX6UL_A7MPCORE_DAP_SIZE);
 
+    /* AIPS bus configuration */
+    create_unimplemented_device("aips1-config", FSL_IMX6UL_AIPS1_CFG_ADDR,
+                                FSL_IMX6UL_AIPS1_CFG_SIZE);
+    create_unimplemented_device("aips2-config", FSL_IMX6UL_AIPS2_CFG_ADDR,
+                                FSL_IMX6UL_AIPS2_CFG_SIZE);
+
+    /* SNVS low-power general-purpose registers */
+    create_unimplemented_device("snvs-lp", FSL_IMX6UL_SNVS_LP_ADDR,
+                                FSL_IMX6UL_SNVS_LP_SIZE);
+
+    /* System counter control */
+    create_unimplemented_device("sys-counter-control",
+                                FSL_IMX6UL_SYS_CNT_CTRL_ADDR,
+                                FSL_IMX6UL_SYS_CNT_CTRL_SIZE);
+
     /*
      * MMDC
      */
-- 
2.53.0


