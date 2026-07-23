Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F35C531D1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvD3-00049T-3b; Thu, 23 Jul 2026 11:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCz-00047h-7K; Thu, 23 Jul 2026 11:19:37 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wmvCx-00081v-QQ; Thu, 23 Jul 2026 11:19:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQF/jnFftOLX5myDNnAxNnv8g/htQ9aczqI4w/gwoF6o7XdvqxWgtxFdcTBFXkhrZmm95qYwWp0dJUSXTk1etErnX/vf9xFbkJjoXEZou8LCvX9Mt5fC277Cv5c/68BoC3wY+ef1Zb2L2dNAfGSr/4WsEDcwwnZv4AzYVxOVM0Yg66KMXbETt4CMKPZMcXUkykwdhe5oEZgbOtoGzsetMPd7rk5SZbglNrhjY2ZH3CsRsOpIFV6+cHw2vkMdPdxO4rJ0+RqnnnUd2174TpIU1PX8kgrXziMbekRD6IoEkrL9cDMAd/y1geRYGkTQb7F9R2/PGyte68c9erGk5Cm8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi+ymX8a/nEd1kUWNr/bVGQvOEbR6BoOGmKV3BT4I90=;
 b=q1fBoyQpL9d4K2XOvZDL7jEbXLiqFyFSwKsv1m3RBnOjJFu4JWKk3y54ogQXTGckv6xsxdWRCZ35TtqapqSriHkz4ucSIgjPO9kldHegfKtYvidf75jyDm1z6QWdVIP2PrJkhlFVS/mHDEzrCHAwOB2RvwpVBM2T5IsLict1v9BnPBjHljwoDDoUQj5X2Lwh/2ygkooCrTpeK9uwnppIRG/Uda0yXoLrmdCNqN22OyIlx6IOZfbZ1uk+5nhTGxtMEOM6f/y+Pg8xly2CbJLi0MqlKsnpQKUVpkZNwgTPBGgguVsyvhNoI/VlFkwROfA6BhiprMb5tkKtEqr0iWRMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi+ymX8a/nEd1kUWNr/bVGQvOEbR6BoOGmKV3BT4I90=;
 b=GIOdl+ppq2aL0wpf79XJC6poIWBzPY+ybTePE16hv9IlMjFyC76SUg+ZaLNEuRG37uUgsTIlnSFo5dqbttbVrZk23JyQb7nElS00CYoXKpieVSi5byZqcghfj7AAU5oNzQmfHzgghb46pdfBDVbouPqvmAvwJcPkkcn+KDxlAyQxuwsqla0JGlVUcztC71scvKrCKAFEAbo7esWP7GQkrSP+OvPuek/7qoGK7l4b7irwYvlnyg4Li6rshViJcG5KCwUSl7zjPSLCHEN3neiwUgHr5+P2QOd38tZPJfpYTqOHAp6oZhYKdypCIx8fDOYWv2VPrQWs5naPubuSGxJRBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KL1PR02MB6215.apcprd02.prod.outlook.com (2603:1096:820:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:19:23 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:19:23 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: [PATCH 07/26] hw/sd: sdhci: Migrate the Host Control 2 register
Date: Thu, 23 Jul 2026 23:18:34 +0800
Message-Id: <20260723151853.2143177-8-bin.meng@processmission.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723151853.2143177-1-bin.meng@processmission.com>
References: <20260723151853.2143177-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU0P306CA0037.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::8) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KL1PR02MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 7095e64e-9084-4d43-305f-08dee8cdc6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|23010399003|1800799024|376014|366016|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: M++NMPtufe8ey2gKzStYz6MHzKB2kLwyZ3YuOimN2IFEkkulhqY4mj/dC4AA9ICpY+CXOMAFCG9YjNI8qUZlqhdf/Qgcfz45rkY33zSXQz/sZlYB1vUPgJ4+tmxFOATzrbPfGyrBq0BVQsQ+ryL6LQPf0kUBxwajmbiRHi7afwe6+MJKJj//5l8durPL1E+SE6MSjs+oTtIhpFm1uFyCq9OS8upJlJqkiW1GwEvQF06jckqPVxLAQwZyxtf8i4UbRSCAaPDOmJYbtF07OqazUlAdXuReKNpAgxRKuWvUEq1O20r3ViIBUJqg6U+zkWMzsEfuLVj/7/gAwZ72zaxg5+20YA3kDHWWq4S6fsqx3Xs1P6uB+OPL6aFZ91sVxXPz1OqMjfgVo2+pDBIpLE9hHcxJFjwFJSqIHk0F4oVXqi+DFBg/4M7ffqURa1M7mqFmFjF3ELcyV4EPM1340+5+eLaJlC+vi+OTeKXYxhtrbKV9Td8eswLCxYmv+LOVKGD/l/3RBMkJhJHCiqWXLWq/PN2nnaPzKU6K7fqVbxKO41p+5YZs1kpyPPYiKrvHueOMWrh4cOXpcBQ0SGwb6ufDhJ7LhPdorSUbYEKGc5ZBfxms64clOPXCCaqg5FFCYkkUT1tM0e02g73VngM5FHQT0JjYZwH57W4yXos+1n3b9EY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6xUwJwVPEm3ewicA6/3pRLFN30Aogkt1phYl72wODwRMGiIOVRyds/R6xAYJ?=
 =?us-ascii?Q?0iB8QZSIZnrcMDi6UdyaB6psSeStf52MCzAQdprI3TNuudCHjILHsWgU6+/g?=
 =?us-ascii?Q?n2FsVzapwQJLTIAcflHOBM59eVuCJWNU3gfFrXQKpWUB6zC5HmjfluPsjNd2?=
 =?us-ascii?Q?pxnylMRe5KEy6Gdg5qvbb+Ec2IFiimTwIQTd0EriwmGtfYpZdsnNcvvUX7an?=
 =?us-ascii?Q?kldBroyvyvDIzKN4Ve/7z8BkTc119irvTbD+I/aU0yWFxBqQhRPifOF4kw+Q?=
 =?us-ascii?Q?+09U1DHB4FMULOxlJ7e/ucRmXnZSMsUDRlYUNq4N4QHjKAE8pXxF5JwCooa7?=
 =?us-ascii?Q?t6zpMRU0YYbX4Sl0YMpIzNkvfMhTxv8NH2mB7Hla4dLtMWzoXs0g+utGSDNf?=
 =?us-ascii?Q?NxRpRxXDo66uyW3TbWhe0f7N+/I2yifU7YxmEzdiOI2ZBVQTZepllOSCWCwn?=
 =?us-ascii?Q?QV9lIcPipV+pooYqQ2S4Yni2joXK2YcVObw8weBGRbFM9sRjyP9/Dx0/H7W4?=
 =?us-ascii?Q?AyF2uB9ghxodOOzqWQdTm+qmOoibQaXbKCrQg5c7dQ7ewYZfJ62JPyhsjsSt?=
 =?us-ascii?Q?/9w9cAvIhyGD/ELEuRHz9lUJcSKxlDSiyy4sGGkYYwwXaqtrq+98LEYhAjtk?=
 =?us-ascii?Q?A8wxrFmP2WwZWmVs1QXVduZwulb+Fsx8677lFi6FzlqLMF0qwRY1Hvhw/2C+?=
 =?us-ascii?Q?7Qac4hb5pUQIhZRQIQB6X+UM1jeVnXN87Cr4YIHXyBuqGrPNj74skv3f2PXc?=
 =?us-ascii?Q?z+a3nXbVbZYPeI984ybHaCsDnUizSaQuMW41iiIsaFiilRCON4Ad2+7NkucO?=
 =?us-ascii?Q?FVyoFsFoUBRmZaRbaz6XVvUjNSeswoKYX5HbrOQ+DYawNFYRI7Z82FGYTiAk?=
 =?us-ascii?Q?D3PnhcEgkDesrnXBV/+bCYsO95zSltP2PnCujUrrlC7F1AMawK+EWijpow5c?=
 =?us-ascii?Q?sitAndUrSU/9qG+EezIQreO+mAkfCJJkKeIWi0qZYsZ+JIW0O3Ju3K8rmXxP?=
 =?us-ascii?Q?SfWRzxKDIjanRO80hvSgp7mPBirTin9QJxLkyC8m3Yji8kGaz/pZrJEWYVjj?=
 =?us-ascii?Q?F0bT6vhSaCKUcIn7/GYOBZ322dBZ/+MMeMGppQtzVCGXUYLQgBQZp97aF6Tr?=
 =?us-ascii?Q?m1URng0kB9Iux8lCKvuVx4LZ9mm2UK7PbR6rEJstVmCffSL8fXRbC7eOdDXC?=
 =?us-ascii?Q?0Dp6klP7vBoI/bjAUrXsG+FjjKMZrBfYlAV3mVBo04CLVM5riFXpf3KBlD0C?=
 =?us-ascii?Q?QjJ3uWrdVJAWPpbT7IyTOlUbelFrdyOUbMqQuSr4B0ZAzmEWOtKjujQU3GPY?=
 =?us-ascii?Q?+wl+JxwKkY2aJFVYl3P7+9h1mQIBZpAHW/owEQXACTOLQVjbUoLkbvX3/OoS?=
 =?us-ascii?Q?LzPXyM9iOt7vy+TBDHgroFbqgClMQ9R8yw0zgs7qp6+f4CsGGFFcIsyzz0Ch?=
 =?us-ascii?Q?fp4KEPcavL+2Le8YKaZG2DIURvlZrUVPmCkqluex/TcAItPr7tQnVjjFc/zg?=
 =?us-ascii?Q?Uwip37aXCSgYLzm44KnZpNhEWnSg3tYaFGlDsla27TguDWlNysrPscd+KsbT?=
 =?us-ascii?Q?eo4v/624NTYhbLopOPG95bSBgkg8qAxxRA/ysqt7VRgM53AiBds7tQI+Urw0?=
 =?us-ascii?Q?AeRMfTukUwilvSZukK3U2keFhS2+YZgdPQI3Z2id9CNeUJ0fFSloH+2LeDNt?=
 =?us-ascii?Q?E9TmmJvHgEfV3FCuUw/oCd5KNEiyf7xkDKbp9LFyztDNx3mgdijW8GkkyEHe?=
 =?us-ascii?Q?blOigzTa6RE4LBHFPZd3uq+oaMyO2Uw=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7095e64e-9084-4d43-305f-08dee8cdc6bb
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:19:23.4080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tra8yEh4ldpkLet6rEXToB0FSsb2G3k6Xrh4I5WGav8jWDynl3/jb2UlZQOIl07zvcvWTaDJEPv5RqfMSzaC+GEStuYiq3olT46m1aYKMGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6215
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
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

The Host Control 2 register has been part of SDHCIState since its
initial implementation, but it was omitted from sdhci_vmstate.
Migration therefore resets the register to zero and can change tuning,
voltage, or DMA behavior.

Migrate nonzero values in an optional subsection. Clear the register
before loading so older streams retain the reset default without
changing the main stream version.

Fixes: ea55a221bfc0 ("sdhci: implement the Host Control 2 register (tuning sequence)")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 hw/sd/sdhci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 55a4abdd72..749de85476 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1470,6 +1470,24 @@ void sdhci_common_unrealize(SDHCIState *s)
     s->fifo_buffer = NULL;
 }
 
+static bool sdhci_hostctl2_vmstate_needed(void *opaque)
+{
+    SDHCIState *s = opaque;
+
+    return s->hostctl2;
+}
+
+static const VMStateDescription sdhci_hostctl2_vmstate = {
+    .name = "sdhci/hostctl2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdhci_hostctl2_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(hostctl2, SDHCIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
 {
     SDHCIState *s = opaque;
@@ -1488,6 +1506,7 @@ static int sdhci_pre_load(void *opaque)
 {
     SDHCIState *s = opaque;
 
+    s->hostctl2 = 0;
     s->sdma_boundary_paused = false;
     return 0;
 }
@@ -1562,6 +1581,7 @@ const VMStateDescription sdhci_vmstate = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
+        &sdhci_hostctl2_vmstate,
         &sdhci_pending_insert_vmstate,
         &sdhci_sdma_boundary_paused_vmstate,
         NULL
-- 
2.34.1


