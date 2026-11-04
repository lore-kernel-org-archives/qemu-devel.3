Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD39606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=WVHJXhDI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOeMW-0001rF-Uh; Wed, 04 Nov 2026 12:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLC-0001Bl-KH; Wed, 04 Nov 2026 12:00:05 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xOeLA-0002VM-GW; Wed, 04 Nov 2026 12:00:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcrToIwbB8odv+/D5dzB8epGlg6OBhqlSz7e1A991DUNBJacfY4Ce+uIfmXIyVO4JfhlPWsLB9UzawHNPnaLTRs3qhBG+IKvjcPkjgma3qI6xI9RICopZ/3IOAZiWUGPxFVhsqNMfnLwZuPADjgFM3PhGuufXZwwO2E9d1wqdbey/QIlk51uFHExAVfxQgCZ5cfYhmx+/pr4LhkfAQqrmmIMM2CKS0gofMFciGbEg3H3D7AXHYjzgndL4lmn2mBW5O7ECB68vfZ9qLaVByBzdj6/52hOCLVU7iPmNfX/QPkopMWxdSG2L+20tAALvy3j99BMDX8vgf1W3HVbXLxmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUFSpxchpbxAUvTUmxhkU+S8GqYiT2GVWXPYAk7YJbc=;
 b=ptQqeJfZ+om6LdB8TJdSiFH77Yyntwl/It9tcVLW/1vvLRRG4JeKLK8YefCC0p93eNrnJKUAbTR6IRvBgZuBPhCvhoaCAhdqKTIVIrwnMaOYY093vVi27u3QK5M//lGr2+vCcpNHWrJtoRiq3VPezWYAQPg1ZFFKWQ9VXkDOlTKIm4cPxj9tv4PcX5f/1cUnk1iVkb/u7dDHD0uNad0yrNSzK+xKpOEz6QCQVzEJ33yrrTt+nJrRHUr5RJN2Cea7VWaxouWWgJvVipX/nEvcC3A+4qFVNPdhYpzfC11ZtDXy1bVaxCK8BEPd6w6lJoqjoMPdlgqiWKRQAYFJedHNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUFSpxchpbxAUvTUmxhkU+S8GqYiT2GVWXPYAk7YJbc=;
 b=WVHJXhDIA9L6Zpx1Ng6K5eBo914r8GRBa2q/6cjc0HmXPeUWYrTsc6ad9sfW5J4eLqchxnD9P32pSZUGMQ4oWdN1bzz2KDYTlRmK+w1Xiujjhu2Iwr5EL+EutEOWvABdD/4+raIpiFnBtQRIsTKNL+fOlBKBv5ZRRw+ej/D6W4tXQshjYQNjDTHTMBeYS3Q1KPvunjl6/OesM4ESDaJs2HwLI1cilRWpkEvSFG3i6pLN4XxAlYVNAFfHyvo5m0C+zkfBdWoCqjfA/hKJOXZWqXgIJ1Kkzt++zWAMLujXlLAGeW/28XBf5L99zlCGbPlhSzCypQ+mix1Kfy4IO03YQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUYPR02MB9618.apcprd02.prod.outlook.com (2603:1096:d10:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:59:54 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:59:53 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-block@nongnu.org
Subject: [PATCH v5 06/10] hw/sd: sdhci: Honor i.MX uSDHC vendor clock gates
Date: Thu,  5 Nov 2026 00:59:18 +0800
Message-ID: <20261104165927.678833-7-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUYPR02MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de4d105-6437-4ae5-66ca-08df3a950b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|10067099003|18002099003|22082099003|3023799007|261022075727099003|261102123227099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|56012099006|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: WvPG3pMvKdy2kYGL2zmtM1z8plXsyxSy0F13/B3zrXErd9mSwx3mk7PQ10iPwrXS3uO/iI8VWC1778fFupV3gQl4imLaDV/NsShOPKBP8D+NvWxc92dirkUDb8ba39EP5QPiyaDonAM6OGU+Vlbx01DHG1Q4Mu6bk+CrBkobhkHZpUnktP6ItXBzvQYpffzW+StXsJfL/CoaJHqbfZ6SOgnSZVHusb04o9knPmGpiinrbOpYU3JyCdeDWRseHR4XiI7atl9OjYKtSVrlQUNnI6zDevHYT70ora5QVE3oVUlkzcrnMMZY178Z+0WufAb/niIJN32gjcwJy0hlw1UPz56/bB7cqD7oigfSwhK0NF/9sCW/B8soM6+AjfWaZtAENv0I5a31lkVJkteDMyH6CgBb0MmhVhUDgK1JHOotJZolOMckCkDG768XE57GiqzeekswsFmP3OuVWPRsZtYd36tYYz+5bIQAqhpqxlBPu2ZgmfCVypwophGv3xrQJBiEl+O+4saisBrIYDjE5KKqBqhZs49wkow1WdwyOnMD/ExYF0A4JBrtZzJKa/MycMEQq22ls61NXqseusTR5f0mt1anehcbFTAvcJyodZkE3ZD3mzm18hStnHyubw/MDZOQwoFpNp6Du4q3dP5U4y9vxNdfL5EXvvehFY5CPWq8nO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261022075727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(261028144727099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYfVcgMoy7JVEO6wrncMjdP/IR3Zjba4DULuvePA1BMS/D/suREt0Bt2Kvps?=
 =?us-ascii?Q?FGX+HZUiPn2Xren997czi3khYokaVMvogb6lLvyMFZFRJ6g2Iz2rEwRztTle?=
 =?us-ascii?Q?FgxLAPcHXbpWHIWmj6R+zk/vlnIofbYz7zGnfAobhjOStdkfvOm+c0mtyll6?=
 =?us-ascii?Q?P9iiJNhmvp26OVyWP1uSH1Liy0YGVqL+9H8zM6d3u0+XIMvLCdyP+ATeref0?=
 =?us-ascii?Q?S5tvSNvjN+GgXFwJJlxartAk+6+iQ/LPHaN6o74/+/owEiDQWKN+DcsvtYsb?=
 =?us-ascii?Q?qshN94VbAdZvSlziXHKIamqnSG7fEqcYmmSUTOeQ0LlxUsI2bTuJZYpUdY1f?=
 =?us-ascii?Q?3f/q+brBfrKDJHnFVa30JBxtcCj1MR45MokpTMovTD+jqfjWqTNG6NjNCVm4?=
 =?us-ascii?Q?sEofl0+pCUQuk4zy+V4rqeMt+GAYFUqIH27FbFbG8o75M8SLjDWNcYg7jhCj?=
 =?us-ascii?Q?w2oKmdPXhBTgBXeO+4uS66TNsd9QSl3oVcpISqXlr236OJFaKMp12mcSNH5c?=
 =?us-ascii?Q?c37DID62qHJGZc2PrWDzVqJWlxIHb/r0Zn43ouEuD9bi6nwFftpg1C53c41V?=
 =?us-ascii?Q?a81TcWFNlPvYbsvBrgJzfTL+cRNyQOXdiNiGqsl6bEx6feVGmkKarPfX/NbW?=
 =?us-ascii?Q?7jkuOLHt2m1RG1/7DCaUHL7mkNQVdDznw5PnmfH3LlaN8ykLzo8iEUkgDwzk?=
 =?us-ascii?Q?m7ppSgLMJjq1bWuyvEqJD4cu2ON2G9U3mupfc8kVwelcmSADimhPYZ3+vs+q?=
 =?us-ascii?Q?C0YdPcFIe5b6Eu0krVUJ5IClzFHspAKKOttYZqDfkqfPY2zWONbxzNc3Au8E?=
 =?us-ascii?Q?WBR2j4+wFWV0Lmc2KbDKD0gDi1M+chHSsX4FUvNnzediQZEXUnygKdivGODC?=
 =?us-ascii?Q?6ssGBCvlHV5TKhjrAscEeVPyoTxYNNIgvyfV4J43GgiE/0cm1V89gCgzzXay?=
 =?us-ascii?Q?yKjBnHXpCSxP5HFFo5ygy8dRWBJMzTkCbiD/90PLIRQhJiLBtgD+8eO1/l8q?=
 =?us-ascii?Q?jv9MUgTfVNGHvWdx8VlYJoGZ4uJyTxl2c3ZXUDUOh7dhnHDy+aNx/nzZJ5Db?=
 =?us-ascii?Q?eVx1eLb57wrCBIpg/9wWNtd+FeUWoeFs34sNKmNry4AkZwLkfqSdERs4X1Mj?=
 =?us-ascii?Q?9XlvVKapY66m5X9bQF+Vz8GwcqQYlT2+JO+zIx7XJU2U/YXlkCHp7ABZEKS1?=
 =?us-ascii?Q?RsXLdm+5gsvVjg9o6J/DYTrwfetONbMl765+ns4I0AC8roBcOlpZNeIpOcAB?=
 =?us-ascii?Q?1ShfF5uP6BJBzgl/uc4yjZlDvWHSAB9iiLMtFYXelrv2Kdfr2WrBhoUuyIiI?=
 =?us-ascii?Q?qROvjuNWzzvyEHlRFiUD+a/n8BCqDbOUTOjFuZU7Hzh5P7U6Oo/vgXJIBvj9?=
 =?us-ascii?Q?ekMZOS+wQWc6KbmEJRdNT+R4qtcal/kznmml4Ut3Pz5SlZRMdujkhvnnA7W2?=
 =?us-ascii?Q?2+jFNu7W7A3pCYla/r9hYyKtYBJ/hfTmjoKMQ+yjlel3+lkjeavIhqK1uKzw?=
 =?us-ascii?Q?Z4rVRA3jsNHz71NoN+972vOkZx21YFen+vv2faQQ139QWWWVIXmAWiac8njJ?=
 =?us-ascii?Q?BWdqxERF/fU457C16k02/h3RZpYcBMT3sJoe5HN9WjTi5v2czNUavbleLCIF?=
 =?us-ascii?Q?Lsm/lQ0O8vuMBg9YSQrHbvdLNpT01J4Mcrpx6IQ94QlKVvBttOVGUZD9U3VW?=
 =?us-ascii?Q?tXT9+P8spJ7f1e39EBp9YmveLNWKuc/AwpscotnPNM99oa0/iVqj79asixOZ?=
 =?us-ascii?Q?ez7bFqZohTHvsBdSrbrCGNJ0gZn345g=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de4d105-6437-4ae5-66ca-08df3a950b67
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:59:52.6680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40Tfo2/MDLhf5zawANs8M3SiHhnpYgfeuO5NYiDh04zZgp/cHeoPtZLANqnOuCZQRaWvXS4MhU0L7KRXwmC/WuIU/XdnJXy7788D6HVKA9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR02MB9618
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

U-Boot enables i.MX uSDHC clocks through VEND_SPEC, so checking only
the standard SDHCI clock-control bits drops commands and prevents
firmware from loading its kernel from the SD card.

Present vendor gates to the common clock check during uSDHC command
writes, then restore the guest clock register. Retain the standard
clock path used by Linux without adding vendor quirks to generic code.
Report SDSTB and handle partial vendor accesses in uSDHC MMIO handlers.

Reference: IMX6ULRM (Rev.2), sections 56.8.10, 56.8.12 and 56.8.26
https://www.nxp.com/webapp/Download?colCode=IMX6ULRM

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

Changes in v5:
- Use a const SDHCIState pointer in usdhc_vendor_clocks_on()
- Drop the unnecessary QOM cast in usdhc_read()
- Consolidate uSDHC write dispatch in a switch on word offsets
- Preserve partial accesses and exact MIX_CTRL offset matching

Changes in v3:
- Translate vendor gates in uSDHC MMIO instead of a generic quirk
- Preserve the standard clock path used by direct Linux boot
- Handle partial vendor accesses and report SDSTB in uSDHC reads
- Migrate the vendor register in an optional subsection

 hw/sd/sdhci.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 83 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 0c5b0ed984..df921b85e8 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1604,6 +1604,24 @@ static const VMStateDescription sdhci_hostctl2_vmstate = {
     },
 };
 
+static bool sdhci_vendor_spec_vmstate_needed(void *opaque)
+{
+    SDHCIState *s = opaque;
+
+    return s->vendor_spec;
+}
+
+static const VMStateDescription sdhci_vendor_spec_vmstate = {
+    .name = "sdhci/vendor-spec",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdhci_vendor_spec_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(vendor_spec, SDHCIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
 {
     SDHCIState *s = opaque;
@@ -1623,6 +1641,7 @@ static int sdhci_pre_load(void *opaque)
     SDHCIState *s = opaque;
 
     s->hostctl2 = 0;
+    s->vendor_spec = 0;
     s->sdma_boundary_paused = false;
     return 0;
 }
@@ -1698,6 +1717,7 @@ const VMStateDescription sdhci_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sdhci_hostctl2_vmstate,
+        &sdhci_vendor_spec_vmstate,
         &sdhci_pending_insert_vmstate,
         &sdhci_sdma_boundary_paused_vmstate,
         NULL
@@ -1801,6 +1821,10 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 
 #define ESDHC_VENDOR_SPEC               0xc0
 #define ESDHC_FRC_SDCLK_ON              (1 << 8)
+#define ESDHC_VENDOR_IPGEN              (1 << 11)
+#define ESDHC_VENDOR_HCKEN              (1 << 12)
+#define ESDHC_VENDOR_PEREN              (1 << 13)
+#define ESDHC_VENDOR_CKEN               (1 << 14)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -2051,14 +2075,67 @@ static void fsl_esdhc_le_init(Object *obj)
     qdev_prop_set_uint8(dev, "sd-spec-version", 2);
 }
 
+static bool usdhc_vendor_clocks_on(const SDHCIState *s)
+{
+    uint16_t clocks = ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN |
+                      ESDHC_VENDOR_PEREN | ESDHC_VENDOR_CKEN;
+
+    return (s->vendor_spec & clocks) == clocks;
+}
+
+static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    SDHCIState *s = opaque;
+    uint32_t value;
+
+    switch (offset & ~3) {
+    case SDHC_PRNSTS:
+        value = esdhc_read(opaque, SDHC_PRNSTS, 4);
+        if ((s->vendor_spec & (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN)) ==
+            (ESDHC_VENDOR_IPGEN | ESDHC_VENDOR_HCKEN)) {
+            value |= ESDHC_PRNSTS_SDSTB;
+        }
+        break;
+    case ESDHC_VENDOR_SPEC:
+        value = s->vendor_spec;
+        break;
+    default:
+        return esdhc_read(opaque, offset, size);
+    }
+    return extract32(value, (offset & 3) * 8, size * 8);
+}
+
 static void
 usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint32_t value = (uint32_t)val;
 
-    switch (offset) {
+    switch (offset & ~3) {
+    case SDHC_TRNMOD: {
+        uint16_t clkcon = s->clkcon;
+
+        /* Present vendor clocks to the common command check */
+        if (usdhc_vendor_clocks_on(s)) {
+            s->clkcon |= SDHC_CLOCK_CHK_MASK;
+        }
+        if (offset == SDHC_TRNMOD && size == 4) {
+            val |= s->trnmod;
+        }
+        sdhci_write(opaque, offset, val, size);
+        s->clkcon = clkcon;
+        break;
+    }
+
+    case SDHC_CLKCON:
+        esdhc_write(opaque, offset, val, size);
+        break;
+
     case ESDHC_MIX_CTRL:
+        if (offset != ESDHC_MIX_CTRL) {
+            esdhc_write(opaque, offset, val, size);
+            break;
+        }
         /*
          * So, when SD/MMC stack in Linux tries to write to "Transfer
          * Mode Register", uSDHC i.MX quirk code will translate it
@@ -2076,16 +2153,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         s->trnmod = value & UINT16_MAX;
         break;
 
-    case SDHC_TRNMOD:
-        /*
-         * Similar to above, but this time a write to "Command
-         * Register" will be translated into a 4-byte write to
-         * "Transfer Mode register" where lower 16-bit of value would
-         * be set to zero. So what we do is fill those bits with
-         * cached value from s->trnmod and let the SDHCI
-         * infrastructure handle the rest
-         */
-        sdhci_write(opaque, offset, val | s->trnmod, size);
+    case ESDHC_VENDOR_SPEC:
+        value = deposit32(s->vendor_spec, (offset & 3) * 8,
+                          size * 8, value);
+        esdhc_write(opaque, ESDHC_VENDOR_SPEC, value, 4);
         break;
 
     default:
@@ -2095,7 +2166,7 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps usdhc_mmio_ops = {
-    .read = esdhc_read,
+    .read = usdhc_read,
     .write = usdhc_write,
     .valid = {
         .min_access_size = 1,
-- 
2.53.0


