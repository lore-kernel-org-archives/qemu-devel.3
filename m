Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FECCA5FED
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xD39R-0007J4-ND; Sat, 03 Oct 2026 13:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD395-0007Dx-UL; Sat, 03 Oct 2026 13:03:35 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xD394-0007CD-Dm; Sat, 03 Oct 2026 13:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bitjI61aVs12c01XSneul5rn3bP1hEezmBhp2Y1m5fe9dF5Z08ug5t5L36p6H+Qr5Sw0ebJA6DpYk89jGOIMVg71PF8hB82g4VSfK66T8Gvvcsw9BqIRYGKiS22A3hfBZISCxVlW0lOi/KU1FfIbU/xZiISG4pAXzC74ScMCzb2lH2XADE38NCyQLXlVT9p/gy7puQvb3z/dJwzTvWp+g+gzbwVUyjib8zYotRT5KsMUkgt45fZ9CntEO3mqKBRg9jK3HizWfzdn3PNOgtB8/GRMkUrVODTnj+GP9Hxd+JSCY5EGeA42LKYXN5cdN6Eq5bt1e3vEkblEoJcOpI41Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hhOHNF8s1j0wBEy9KtYWf3zljl5jCJgep7xo1JP62w=;
 b=P+Fu42g3uqZGjB6D2k9Ednbvnuoqb74Vf5mrNCIbgamGLpXXhR91YRoCcXZCetZ5/2oQxAFF8AqxBWfJHBVJuNy1/02phJITjwIsjCHcLKPN7dKTB7nX7EPDC32sVhIImbWpkZOTL8iRv2Cb8fEAKPJjiGcre1DwRmcJLbGL/tq7aqqB+WZjSMRt36GsA0QvNH+r0UndRTSDbzllQiP5sXZ3lNp4t3lRJT4MmeWASLpuuJSrZX1GMf1kRZFtMKnJ11oekWJD2QvplQ/mkiJ07qBioiH2LwUgdoX3U2FmyiQiXUS5Li9TBuZ4fmb5/bStxcWH7nV7K0a0+bUQvgDRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hhOHNF8s1j0wBEy9KtYWf3zljl5jCJgep7xo1JP62w=;
 b=A9rQ7rE8eyC8vysrm0DYbO4JHU/1DmtMEVxquztC6mgjEl3R1FsQuYH6x8gJbbOB+RAud2mTn8mR1deDugyGuCcCbex9juYQo8YYMXSe747eMOaT/PSBdlQ+//Im8C++EY5frfAZg5XeXTd54fEAmBTj/IH0iCpOYDYaX3zZix5uDXKCM9uaQJmuK26e1b6RqvskcUArYoqs8SOHQZokiFKEtrbKJRcoa+ED+s2t87Z4hc/qXWYHxDRz2d875bVH6ALh3JffT1iNZPkKd6fDVdAbVPio5BosmvJZyxDV8O5cR1W+nMFN/ZMH5WZMZEdjisu4S8y9iE/UDd/r485stQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TYZPR02MB5788.apcprd02.prod.outlook.com (2603:1096:400:1d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sat, 3 Oct
 2026 17:03:26 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 17:03:26 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 12/27] hw/sd: cadence: Add 64-bit system bus property
Date: Sun,  4 Oct 2026 01:02:02 +0800
Message-ID: <20261003170232.2450916-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261003170232.2450916-1-bin.meng@processmission.com>
References: <20261003170232.2450916-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0100.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::14) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TYZPR02MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9578d0-a603-47ce-295e-08df21703d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BieLYzOA9EQQmPT7A7YTe765sC0OoihXVlcGjO/NsQWH3rjbGo5eQvSmBdNA4cB4gpOLZXNHkN0k+4uSi2XUTNP2DgV/rOKUirBPFYKggbesY33YRopK2aDotRqlr7nx5RixU/FRM7rpOVKRR/frlqfUB46eQ44TFDHChz6m4QU894XY1bqCnzYzHXXKoyMv4cQOqlrnEyWMdAhvkmrdOjXpEgc5Uu/jO9LZw11y51nQ+LRiqIEttDtzu0UpKMQQRyLHu0O1PrLw7DV0xYBd8xe/OoW+L18vWe22DE/25nwnYaZHlYB+v3p/brXvV9lI4J9s0DodzohXv+o3yuePLcLPB9Wr8OImrp07tCGXvrsxoH5QFWzfB6St4T7Fy9kqw6KwUz6KAVLbtpFHHfAKcKg9LJEbpax5ORDzU51Ov1WZvhUBm00j8MOzrg6qSnJY4euKyCkOpyJbDBjqrVrQ5NeBdy6uL1DMwCnKlGXcTfsUe40SnRSaxR/uhtKLMbFKoWh0Jbxvu8pN0/TUjbGL4lDxKSRcT4CtMA1WbE5r0x5d17LR7Uw1ZLTIJeBdBDTZS1fPfN+Hn0ASeCTxVun/21r9hX90UlX6Y87JftIfNoFpTcjCrUtC5jQ79aymToGt7l8MkkmwHrefzgPNi03A94gUhsph0lDD7n4qsLH6uPM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vdGxRg02aKgiID6CBf6Rs2F0ORLLwHIa8AzPO+l8Lg0hvQi9/FShJ2p30wxQ?=
 =?us-ascii?Q?Ehkdq5OdEAR879X+k24HHErEjVd4uT7rP+8Z1vXD/FeA6nLW6RybcaTlWCPy?=
 =?us-ascii?Q?zJwb4w1MLZAsmSk1YtFGCjbFgsUDaVa8H2p1bAGqOhLmvbm59sndalUj2BAk?=
 =?us-ascii?Q?LoUz0tW+Hspl5jYndWf7ktF5MBCcrKtSpoTXdpqpDFmnwhVCzeufEK911nQP?=
 =?us-ascii?Q?fD43Y4sfc1dFlahsajsDvUb4OODu+4qQaFX14qjHD24EOWYVtwsPNTxf4U3M?=
 =?us-ascii?Q?I4kbvvYFrSp8LiRJukhrDIRcuDPgVycE3Dnn/qAjuWuK4VXUvbRdbWnRMrXh?=
 =?us-ascii?Q?CglAiInoL2cfGTO9BAvSfBtGcTwyS//knvdCVA+3508a9cwJRW2MUmc2Iwy3?=
 =?us-ascii?Q?z6LPJiZ+BAoDOPzo/vOZYVISrkWo0wkzYCznDxlQMoNKMtk6D7fJ27onO5pu?=
 =?us-ascii?Q?M8qHrd/+Qtkykuvhf0hl0aqa3Qz0kobL9aSMACneB9VGHTER2OW43XvG6aCV?=
 =?us-ascii?Q?1Z2SqUI08rEGCia7Pvs8WEn3PjzKyF5EJtkEOuVUvewBfzE697vJcHRczw3d?=
 =?us-ascii?Q?5MMSltzhFr8I+3wDGcZldedeRGPaU3q1DhwagdeLu2ew3A6pGRSc1Fabffzh?=
 =?us-ascii?Q?re+jvzi3PAL+5We71neEX+OgN7QoVF0XsZkCem9u32dAJ9m+d42mr5wadjfW?=
 =?us-ascii?Q?BUjRlFxP//NrgWNDywYnKtGPGK7eni6tV+1eqOI7PcFLHt9sugZDCD9m6W15?=
 =?us-ascii?Q?nvizhbn7W2bmoOLfxuz7zJ7vi5Gk1pPJQRBvBgA0dVF57QLd/tAumuvg76CK?=
 =?us-ascii?Q?Y9Cq7KMjROHnBjAFg45R8DJF7HMrbBl9RvvRJ2lnN4JZOkkY6A7ui+0/ktr/?=
 =?us-ascii?Q?Zw57Ud7buh1SSFo3JnQCZNQbE2+r9+zLBvbcoZ9TnBitxYYEd74N//sp+Ea2?=
 =?us-ascii?Q?DqgejbPYoHsj6O21AGSm3GnZusbk0fhiDMun9OFTzh4Gv2U9j39+SjSUcihP?=
 =?us-ascii?Q?i5heZBr0DMW2h0anWG3ZiZ9YSZkrmLYNup6OEMA78k9U/lvUju/i6Kwi+HqN?=
 =?us-ascii?Q?C8ZwQoz4fXYfjGnxXXeZcCFO6S6GalCJdBHUp6VT3az2miLubrd9rWx7Dicm?=
 =?us-ascii?Q?i19gbUwtd2OSggQRZT8RfqJNfy8vHLtsn5PdNfWEq5Uie3n3OH7FkEP81GKR?=
 =?us-ascii?Q?q3bxu+lCn3GpdLKi9yVpy13fz7xBv9qbflvGD5yL1DUkFealj/CsLi0Qj1H9?=
 =?us-ascii?Q?J8+MhwIssq4HFpee3og/JNC8a2ibbkk51v8QcK1Y9w/6oOwPOJWNOKsit3wQ?=
 =?us-ascii?Q?dv9z4SiF6yYHCWcJtYOV0SAkJ4UKAaum5dbxB1Jkl0BlnF9kaEWn9x3KNRyq?=
 =?us-ascii?Q?CokbRjWieWv2uj62mjDLchfpQfITQN8YXMfW3OkS6BA1HoPOTjKUwDIO5cPh?=
 =?us-ascii?Q?+FGfn0WcEE6+GzQML5Y50m1B4D3SFSt6KNOGNbDIijCgs8J22CK8pAi05r7o?=
 =?us-ascii?Q?1U5buIffQEsNteuKVjX3gHhSsh4AQw5rQtVI3Qdvv0ijiZgzT++FSqwZaICJ?=
 =?us-ascii?Q?Zkwo21pROEBHBqbKG7LxCBQm6SxfuIlmtspYNndLNBFN1uqrygt0YnIPZ/+e?=
 =?us-ascii?Q?st7AcLkrVmMqof+3ucYNr660CfXl6pDGUa5qZJhV/cEsPUqlHpI6KWLvUtL5?=
 =?us-ascii?Q?lsq0gR/API49cYzdR7ZfljRa6fIj7cVD9qvfAZR/hm1FrJVKtBm3pb5/aCuJ?=
 =?us-ascii?Q?OXWi+dYjP5DH7M8GkI8gY4/G3+7buww=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9578d0-a603-47ce-295e-08df21703d8d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 17:03:26.4045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhkoHbHHO6fHEpX2keTqXadzAjm2hHu7g0QT6uZuzziOfnfqQT50SiAM/t6AOnKYzU1+RW9JiR7ArHTF+KP/013R8i0K1ZUBT0AerCnPm+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5788
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cadence SDHCI integrations can differ in whether they provide a 64-bit
system bus. Advertising the capability unconditionally could make a
guest select unsupported ADMA descriptors.

Add a bus64bit property to the Cadence model and keep it disabled by
default. When enabled, expose the corresponding capability through the
generic SDHCI child.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

(no changes since v2)

Changes in v2:
- Make 64-bit system bus support a device property

 include/hw/sd/cadence_sdhci.h |  1 +
 hw/sd/cadence_sdhci.c         | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/sd/cadence_sdhci.h b/include/hw/sd/cadence_sdhci.h
index cd8288b7d8..553fa73842 100644
--- a/include/hw/sd/cadence_sdhci.h
+++ b/include/hw/sd/cadence_sdhci.h
@@ -34,6 +34,7 @@ typedef struct CadenceSDHCIState {
     MemoryRegion container;
     MemoryRegion iomem;
     BusState *bus;
+    bool bus64bit;
 
     uint32_t regs[CADENCE_SDHCI_NUM_REGS];
 
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index 8476baf67f..875823a50d 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -25,6 +25,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/sd/cadence_sdhci.h"
 #include "sdhci-internal.h"
 
@@ -147,6 +148,11 @@ static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
                           s, TYPE_CADENCE_SDHCI, CADENCE_SDHCI_REG_SIZE);
     memory_region_add_subregion(&s->container, 0, &s->iomem);
 
+    if (s->bus64bit) {
+        object_property_set_uint(OBJECT(&s->sdhci), "capareg",
+                                 SDHC_CAPAB_REG_DEFAULT |
+                                 R_SDHC_CAPAB_BUS64BIT_MASK, &error_abort);
+    }
     sysbus_realize(sbd_sdhci, errp);
     memory_region_add_subregion(&s->container, CADENCE_SDHCI_SRS_BASE,
                                 sysbus_mmio_get_region(sbd_sdhci, 0));
@@ -165,6 +171,10 @@ static const VMStateDescription vmstate_cadence_sdhci = {
     },
 };
 
+static const Property cadence_sdhci_properties[] = {
+    DEFINE_PROP_BOOL("bus64bit", CadenceSDHCIState, bus64bit, false),
+};
+
 static void cadence_sdhci_class_init(ObjectClass *classp, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(classp);
@@ -172,6 +182,7 @@ static void cadence_sdhci_class_init(ObjectClass *classp, const void *data)
     dc->desc = "Cadence SD/SDIO/eMMC Host Controller (SD4HC)";
     dc->realize = cadence_sdhci_realize;
     device_class_set_legacy_reset(dc, cadence_sdhci_reset);
+    device_class_set_props(dc, cadence_sdhci_properties);
     dc->vmsd = &vmstate_cadence_sdhci;
 }
 
-- 
2.53.0


