Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F0CC6B25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGr3C-0006jl-60; Wed, 14 Oct 2026 00:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2i-0006Zs-6j; Wed, 14 Oct 2026 00:56:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGr2g-0008Iu-Pz; Wed, 14 Oct 2026 00:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuWdP2wvcm9HejHmW5x4w6RNg2yaFv6ZFf1/2//tx3BIMuB6ek38HISVLuoh8mQ6+3SCBIwY8wlG0YOIM7tCc+xUrfH25tc/K8DYXrvb/BnDqzrTAqvTPoCL9tX1/AWE+VFvWj0LGSM/KPKnWuSJE6rmF9fuEAdbM/GhrAJWkEXzGuYXGNo8Puv7BTZvrhhSe7Kt4qThifvz7Jk0wBL0cwP62mf1q8jelOzG95Tg4WUGV2uhd5a55RHEXag0OVwLnaaPBH72u33oNPL7Djy1P1lwDAIyBTavNnNhOXxEbGDvMUCoWa5dEgVfwNjkyyLtjIK74m1pKRBhNWXGDlSJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcT2OKzwtOZDlBK4wqXH7URnD869CTKb9O68kQbwqzE=;
 b=M/p9n23zySVfjFcGS2GhARYB7oMHrN4clNvOhZhSdMkc+Jcl8NCESlEItIR1NIUt4j+/+IU5xy4YkE2/RYaxGWYrq5jde2T3l3Zxjf23OO0JEHcl6W7ffz0+6a0NDpDA8MLI6q+aHcze/5nm8kpfpyIfoKoP6LiD/RP44Xeh1+RXoO6GKba3h6HJfpaxviGQgKMhWTzTo9gL5kBko4upqYszFcD/fre9kvpSFjeEO6YI9e3GNyLFFmi0W8UxR4Kf5i572byeHU0uF895VzFfbP1JY8uTRZeosViNsegZSes59hAkDJN8A7g+i2h6fdbFIgGO5b5TPeiOZHhXyI88fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcT2OKzwtOZDlBK4wqXH7URnD869CTKb9O68kQbwqzE=;
 b=hzuW0Y5tYvB9aMlkZ4DDJDrenLSur9uSOfetljbtnbkzePZM8Mry7+g9Kc11WQ29lv4yXVAaRmRifbsqXdKDz4IccplMsWx5dNiI8utTPw8gLKUabXWl0VFMxuTvVjcB1LKCJs3N6sHl2F0DFVzlfzqqFGRewEA54jh0a6H52wbO2Qlq8H3FfsXW17/H3+dADzqOdlH3Pp6vIsTazNdUKot7dBWavlhjWiqJFg6j6fpYjVezCxhHnl1ipoavDD5lQ9ZRhe65/gigl5/2f9KhoToHeOwdk9GllzIZipzpB2cEvckjIioTivu0auMhGV4A3uPDA0bUERgnNEukRsUrag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by JH0PR02MB7213.apcprd02.prod.outlook.com (2603:1096:990:67::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 04:56:32 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 04:56:32 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 03/10] hw/arm: fsl-imx6ul: Map early firmware register
 placeholders
Date: Wed, 14 Oct 2026 12:55:53 +0800
Message-ID: <20261014045605.399684-4-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
References: <20261014045605.399684-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|JH0PR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b00db2-868e-4bb5-b8f6-08df29af8411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|22082099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: g2MGdXNFwutYTfjZcOI9Q5v2dcI3ohtuEbd36hrbruY6Y3AUswJd4O3iYlYTdAmDKtVIUrZckuyp+jxu3OiFvBrbxeJ6zGY3rqWOyW0iKHdqSBuyidhTsafcdS6CS0JHxk2rONWM4RJWhVbfseXjMTTyBVoBABoQWsCIY4PjMYKJYOwapopWsKT4HuWyM+bm0VXHsT+9yYwOG+ZAqOrcJKX/5f1B75uPaBJ8L3HrKZHewDLIbZ9ut38pOkNbYUyJ8i3suqG+AE9/NSEdhoIUCE9Osmv5GWuaYEVGnLwp8WOGxlSpbylyWC3JU0pPD+cfz9ATVMl4+inU5w7yxen+to+LGMpJ5L5nmefEnMobg6T/iqIpt6VZZDMJvwL2tZJlb03MksMEdP6+LUplU/+TByHTECDFH0ilsDXtQJkXhak1BC0MX/7JaJiXmTMcCtPz+n89BLoof1Bp3gyT3Gt5kMOxZ2ujON7B/gh+L0dkoI+PVL6NluO/cdnxozBdVmIH3G5m5iITCb5jT01/uTQgyuz7Pair9gDb5dmWyS8CUnTsYSxgvXPNh0xFD7KKfD8XXQkMhQeRctJtlGAHT33xSqKUjfbDajptv90braDQm4x+AVilg4OBhQwct85ewHEy/TaA9kxFEpG7Ey+qRCw2qVxauxlQcMkjrd9v0Ybgygo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5gauMDMVKm+hzxotidbUuT3n41vJDAU+k82bxXtQq3chNLOwAVyP8GYvDd+u?=
 =?us-ascii?Q?2HzJzpyyD9EUlHVYe+9Vf58e6ggel9uy/SCd1BIEsp75QohWL8m4BzWt8V56?=
 =?us-ascii?Q?+W26cu1A1zjR5nXGi94NROsZN6CsbCh+7owUwLGjQxzxpSKY9IxmkyfV3wz3?=
 =?us-ascii?Q?Y09+ehP1lT3GUduosBSFXF8SuH0NOWBqSkfXr4vZr0gXKNRvD2lCPm3rHq/M?=
 =?us-ascii?Q?W3SQrbTQgrxsTPYm4mZjmbYkQ0Y0jJvvIxfpPCmLXwQW4npcrwSlmGaA+0m1?=
 =?us-ascii?Q?pdyahbsR1nfH9PNa2TfZ08apOJaABTjWzjuUmgz/yfQMNaZORQGcGphIodlI?=
 =?us-ascii?Q?h0M2yNAKh/TaPzXuZA1ux1wtu1judv1jpQBA9Er5kBevBkbw2cXkXezgFdXd?=
 =?us-ascii?Q?IOaea/XXm2Nf1NAzNYEjUp/HgLAhVd1a85LsYScE62P0cFSF2L2QkF7RcoFw?=
 =?us-ascii?Q?efu4kvQKW9OTab/IDLGrvxGnlKq8vfhbl2RDdm4CzIgNbhrsWAMEX7JHDRWk?=
 =?us-ascii?Q?F3zq8BE3koolobY5K78D/oQz23xoDehlaVoYh1POjQSE2bb/uxrL34mtQhd9?=
 =?us-ascii?Q?kTbhshGCmJtu8fw+IceDcpzz1gevpeel3s4aB1dEcN8HPwQZ3HfRZLpL5bxE?=
 =?us-ascii?Q?wOVBi9OJN4zeurhuyLiMqRWhAhC4TFPBrcWY7AyKwRf3Zq8ZHOcmJatnU/P+?=
 =?us-ascii?Q?FYaLsIO7qG6OgCarR3ErmFUOod9XGhoWbjhEuBoAWxkZIkzJW3CCil7w1kjI?=
 =?us-ascii?Q?z6uRpCnrtbcsR6NHkoiRAHoGT3UtN4rshLq7ywT4OxzUsxwVbW7gyw6kPfR+?=
 =?us-ascii?Q?R0UhTrARt9y2ipVpmFMt1bHuRTrspsJ91aJxpF0kWtTpbKXVym7UmalJsK2R?=
 =?us-ascii?Q?bDsnETziAVL4vNU4dblBCRX7FIOTijrFIVxqKn7MAVDKjdBaPM90fm2ya3wI?=
 =?us-ascii?Q?Ez0M4i9UVBbOaMG2NZakJONP/XMCdgdxdbhOuLWgaOCMCyLKuX2wKGgCtQpx?=
 =?us-ascii?Q?/CErufWLpnLJmkht0aux/PTco2DAmyRvaWHSpFSvyO1lJGf3ywvwjaer3L70?=
 =?us-ascii?Q?GFCz/uXslKTjs2Jh7oBRefelXp91iYbsuHB9F9DQZqEhtMLQSSwfCI24QA5Y?=
 =?us-ascii?Q?WqOiU0C9tbyRzV23JJUOBzgq2fJx/KijKfzaiWkGyePDUxvTyLIq1iy7lwau?=
 =?us-ascii?Q?13860ZH8eIUGbY90byUyMGqV3YSP/q4eG7XqLmNqVpxp4uUYZ3J5EOjMWKVD?=
 =?us-ascii?Q?S9lzP2AbYz16urv1eZp7WzRJcXbNvG9TEmlf4Lgl171I+7GyO3yo3Y8ieMD8?=
 =?us-ascii?Q?TCWBVFTmETeld3fZkupJBHa3qe4eBvkrHksgmHPGS4D7HWcE/d+ATmKSaHVT?=
 =?us-ascii?Q?HUthbjrLKccMaqp/7QqxhyJmQobqwK/PSW2wZn6EerCHtUJxjx5eYPs8FO9p?=
 =?us-ascii?Q?HY2YjzgZMVDKUKejQK6WEJbH3Ti/mZnU0OeWubjrgUbzcThbbPeTOyGrfl6/?=
 =?us-ascii?Q?QAjZgZtCPmbx1/RfGMEHw6Nqc9yw/Vqh2f4oVKy94SUSDe64Kteq/uBiTEAn?=
 =?us-ascii?Q?67cu5aMNNA0zCrczXJnBT8/gWjR1YbtIs4VNZWo/5UD3Rf6CApmLXBW1D0sS?=
 =?us-ascii?Q?AV2fSBbc6kcaFyrDpZC5KM3MlrLo6WAl1rk2IeOu4pRCnK4po+IjjQIaeko1?=
 =?us-ascii?Q?TcFnP1lO+1fGmR1cuHkMwjQubodU6QWiK9/r+Pzlm8lrfqvoeKkjIKytVqA6?=
 =?us-ascii?Q?XLozXZ2i+vi2YImnEcNLsh6BO6jYDDE=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b00db2-868e-4bb5-b8f6-08df29af8411
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:56:32.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTqKZ/u70e+jyKGEvyyWYgtbsUkvstAV4QlxWaXNIVUQagqiooAn+UwmrlwBjVytKY3z8cc7cEcy7qPICj54i7tEY5KhJkneo+Rl8DyhyUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7213
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
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
index 1863558a0d..92f8e4b4b2 100644
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


