Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A43CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 01:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnjO-0005d7-0k; Tue, 13 Oct 2026 21:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjM-0005cZ-EB; Tue, 13 Oct 2026 21:24:32 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xGnjK-0006ql-UE; Tue, 13 Oct 2026 21:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhdTRmIuczFN1VMsgQgVCnWb+9L55Eo5oedxvAzZmBkhleVYjzZhgWoo5RgklGhixqODQ9xB219g9m/3GUWFsxDU96gOAA5MnH68KAtKOmPxVL5T/tSNr0K6qHrJuAX3Z6rw/bxUFhabs4nq2f0BwJHANaZeq6B1V+CD40miTztUNbbvL/pegjg6tNrP5Khl6KPf6lMzTNWmAgW6xIY+JtRf3ZsPr3kKHgCaoTtO5V7uCwtqgVc9WHmcX3/jb5lfZPQcL80ZUokptMb3bGaT7RKF5+tGzA34AsLOZBrZbXjOVRYKYMzpUwekxbvZRiLJYjPGasyl5HL7MmXqgQSMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTTGmqL+1eGmem9ALqeNh6jTnCf1Tx1cEq/r7iHhCcA=;
 b=HQjFv2olzx6MMeeVeGyJzWrY4gUo+FbdtJp0lbiqwc6fM6cyj3aqRC7uceHmAIGcNZePeFrkENk/Qb4hHXlEMGWeK+Ob2SICaFlDG+jQD2ZermmHVDj+bWcO2qNkDq8jXcKlu8h2OgcdNrN+Z+weWmp/oSpdpb0MgtQ9SdHhhAkjts2MrREIZal3JtvWp36gjFVETB2U8Y6Gl+7iBY9AMr/Sx0Vj2ygmFcbI6fPq8E89VzAZ+/uOGuqMUR2N370vGeG+9YY5RF8u//he29GEzhn6fA57NndY9q0vjQwFULFPf7CZVoLh5SdeqI6L+6ZOcfdjtOEbtmSvD0aVgR8I/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTTGmqL+1eGmem9ALqeNh6jTnCf1Tx1cEq/r7iHhCcA=;
 b=OVYWAn0aw+zh9RFU2z8/zHuLPCdolmxRFkn6/prE8dR9JNbFvDKcPO6J/PvschkICna9dxg9svIq0aaKZZ9oBStCW13Mt6nInvbeELglVpjy9V+1hWPjX9NEP7UNUOCGWk7SpVzb+CR8Kk4hnFZQUMhgMeM8UOgy9WKUzK35pXkRp8sE3N2ZolNb+z8D1oQubiyVjcojMJo53gCXuOIrJqTczbZN4sOpNtVm/K3zJER5mhStMOoGxxaPw87lQvrnFDgHMK8qntAW27qJmwOlvIn2rnoJ6CcjKIgiF2LP9SkZPqD/IHFxUgtdm5H3SaZWgTQhtmWYXMxIIbsySW/65Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6214.apcprd02.prod.outlook.com (2603:1096:820:9e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 01:24:18 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 01:24:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v4 12/27] hw/sd: cadence: Add 64-bit system bus property
Date: Wed, 14 Oct 2026 09:22:52 +0800
Message-ID: <20261014012323.322790-13-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014012323.322790-1-bin.meng@processmission.com>
References: <20261014012323.322790-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0005.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::12) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3e06cd-4465-41c2-218b-08df2991ddd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4mNc/AQP6ysnCp6RlH6BYav4uNDg3vRal+oVr8PldRIGzXop/Y/B2chBHRGZLgU0++5oqWhKCOUTyrfvC2n8vjURg2yCxpCjTRVHMt8dTSpFDgCgC1UpeuhO1bz5oXRArc0IiXYfoGw/WUXhlkQAwpWIQG3IrLGAcRsuJ882n+/eASM98qdhWZ650smZaOp8LtTWtcPUcZXRpT7nMYzhbVORzMSxnmy5nXfEBc277MLVoWnEo2AeA0++D7IL4BAx7YGQ22w+5exhkid4PxuazN9wWMQadxHn4WILdnl2YajF+jxoTXw4Z6zGM0O0w9ShhCYPMpFkVmNiu6eHjAmR1atVQDLB7AZeTE7Gd/6UG88qzP5N31k81fbBxUJws7hLBaWa29Bi5s+3RIubuRslnJr1507WpvBa+96n66u9xFS8FAkBoMbJjNIpFE70dVhLdVRMcJe5iMw0NJ1crG994nhlkAA82Ysw86vkF31N7hP5x3Q9tYB+lEQEnxjB7ULNYiqCSF1uByGyWi8uT/qc+Q75bkJIAWGNj10xAnRUklm+MB/QaC/XUafOTgnZ2b2udCxE+EKp+DM4uwnGZDWkO1H6L+QbPeXDM5mDUpIF1Iq8NLRTJEhtAwvckS+RT4o5Yv3qKvUr9erC1UlqjF4xpnUCvEUGU2muHcJ/18vGqfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9iHtGvMJTwnB753k7X1+37YD/rjLPJ5yxkeQzoNSZR4aefrhQnYgdcPFPokR?=
 =?us-ascii?Q?OIvg4Dx75D5iVijxFHGYFUeuzlhpXzv78swX6raeJ5ucluKWcV8625eLrKiy?=
 =?us-ascii?Q?sqkb58ivAnnjLAuOT0yTFI6pFSaVA3bcE+J20PuylRIhz4bAsRqj1BtbJqki?=
 =?us-ascii?Q?Pr51lXAPLMUTEPi3o8KRFWzXHDW0Ka/JVpckR4wX7nyrWlE1eQ1sejvI1Iks?=
 =?us-ascii?Q?EVC0Mk5rcWvCsLPQ+rvmcQXM8stfHidxGCv+KG6x/AisL137K4lFftTp4sQh?=
 =?us-ascii?Q?IH2kka07J61Yxbr9AD1Y2IG/e6EVLQVZlWkjTWU+uAOLwi6qGb3OStJdLs4Q?=
 =?us-ascii?Q?0hRP8iXca0VPXHf217vL0R5LFb4pjoz4q1gkAlhMh2ixtjnMx+b99E/HyIAt?=
 =?us-ascii?Q?TemuNxsG6BFVJJe4j6117d2DUUIxdEbRE+IV+ANk0dumC0U4M9C/wvClMvOb?=
 =?us-ascii?Q?xucgO2LVsHvkt6n/JtBqdu5UMRMswJug/V+qecJID9bTWCPWHMphTzo7noDx?=
 =?us-ascii?Q?z89DUD/4gyZHB583XpSeuWJhae94bC22AQA0jCXcdFgNI1gII5HwdkdC9Fe0?=
 =?us-ascii?Q?EQM2SmsQGJrFgt7TnjeQanKaONDhwDrKlNyAeZ3cZQoHwI1EEPeCQoG5JtcC?=
 =?us-ascii?Q?F/9+j3dLL+CTTbFUDXhoYLqKWydUKR/EJ1E+ewc01OjvAfRREn5ac63a+8ce?=
 =?us-ascii?Q?nFq9Nq00l/rPszBU6oRibkr3mQcfYR0Ok3j8a9fME6tAV3yZeEg48TChsVff?=
 =?us-ascii?Q?x6UewPb45icKXxAuAOjmSLI5KkOvtkadSWSWNAgUoIILefOiK3qVdpekaEaW?=
 =?us-ascii?Q?onX56ByS5kYB8t9jjgILnducEBunnFTDd5+rr5zkaktYRzANJpCZBVZWvSyP?=
 =?us-ascii?Q?cxeDeZ38ApBI7KhpgD8WliHM4MrcuFeAnLNHlbgBq+djPi2vPV/mNI3SBycj?=
 =?us-ascii?Q?oRgE+LQf7TkoGPo2lEUpiDqLGmZ+eIP+LWekSgEvKK1KlfZPkxaD9R+nss5/?=
 =?us-ascii?Q?YIY0d6FC/GbCFk6ujWx9bVFa4Nho74rQZPMlde9XtklwIX/DUqzKSzyKLWzc?=
 =?us-ascii?Q?6UWIqIcaawnFoSsG1aDfNClmxKcg4sFaOE2du/41B+iwztCMfpV5n+Eym3XS?=
 =?us-ascii?Q?d4i1LYoZ07hPlc7BXmZUPEtiQkcwFSOD5KazW31WB1jfPxU/PIIeMCNvnPCw?=
 =?us-ascii?Q?VVUsLbm6lKFpKdqbJv3S09WfSIFU9j/a/5g53VO9UiuwU+Tio5c3BtFU3kG1?=
 =?us-ascii?Q?HW2QkVWoWAiJVfSd7qyJPnZMEtsSy3FvMyxy3XhW/M00lwKOXVjCAyK4JW3s?=
 =?us-ascii?Q?ud9lomvMSSWZzm09a/MwELEnPSXcaKvAVHgg2KSszIAEyoNRY6U2ETKJIhq8?=
 =?us-ascii?Q?PRq3FSStVH3Qpk03ToKqfDbgqwW6ufNfdOQzWRX5ZgC2zbxGG+v6PG4GALoA?=
 =?us-ascii?Q?YQgyq5ym78UcnmSH/1lxNYLjL1VNko4JzUGXFrYUQ3eJ43f8utUHq4hMS3as?=
 =?us-ascii?Q?7B10u2AptGmDqlpyi3FkWosEteoXQj/W5cMFj3f/LN4iiIKWxIWmNyAVksgH?=
 =?us-ascii?Q?ubdHLQUGj/sRA93BCyDRrD8SwM64vw4pfEtmCxdOG/bDsIwUhngNvzj6YSLq?=
 =?us-ascii?Q?CVLvJkdNMSe4smrRfUhaRigm9ywp6QyImHouHraMR3FXT4uKoeCnDCTsgnH8?=
 =?us-ascii?Q?d7W8tGW+sgyEoI2WUfK8D8Up+44bVkDiNuBds5a2jIY9Y7b35eDI9ZDWiaxQ?=
 =?us-ascii?Q?3VNYGhCcyPdOQcnIII+KDyibRmyL6Pc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3e06cd-4465-41c2-218b-08df2991ddd9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 01:24:18.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8DTIqbcBGPE30zqHTai+l9eKMijdOO/Z7PpOf9lJGBns/jN725xcRYMwBScfOIsrz2p5oyD0di3D8okQbjUdzZThgQZqDZlXIzh1PjPBLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6214
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

Cadence SDHCI integrations can differ in whether they provide a 64-bit
system bus. Advertising the capability unconditionally could make a
guest select unsupported ADMA descriptors.

Add a bus64bit property to the Cadence model and keep it disabled by
default. When enabled, expose the corresponding capability through the
generic SDHCI child.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

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


