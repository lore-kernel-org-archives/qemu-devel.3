Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1D3CF65DD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK7y-0002QC-5F; Mon, 26 Jan 2026 05:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6i-0007Vt-Qd; Mon, 26 Jan 2026 05:46:12 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK6g-0005au-FS; Mon, 26 Jan 2026 05:46:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIe6sW/imBUF1Y6t8PXmRXgf+IQleZpn3pqtCLqC8+0Ke9zsg6k9+KiL2UmQUy9gzDqtbFkn54y5Oe4Esk18hoDubz1B4wo7svsww/TCvPkgeK/vjlSL2gyikjOBKfRCDXdH0uKM7eNh/6DYdDXtWdFDNEAMtSzHV6RmJfbkd1TFfkJE13M779pIyF/Lm0p/rTVC91goH6BT4/tcfSPb570GEkzy1T+2yVimI4sTdoCJa4pefim0aKioh+K6XSyPM+0CsPA2crLOoaMyxE3YnKbu/7ZIZtZ2Haz8oXNDRasUzDWf1j9nOZx++O9CcWiiuQ4LcEtHa307D+2x3kqs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xavTP8KHrX32K5bg362PtYMS5/8g4n7c16CAaxYEi3I=;
 b=aAGSDjSAKgZUbVO6eNW/DItinUUiJLrhnlwebP+bEp9X5mSaJIfIuL6hEiBsUqeo0ZDb0WUngkBNOHK+gBW/CjpQeZ/aSf2kAnc2ipyUCYAObJjP7vLAVF17Al/qTpfJEIfjLrAgXdpkIZevCierqNdiuFqRtG6xATXgku2WhNG0ibiU/RvoHTK2Uf9Qp02FjBhE1CJcJcDwSHqnvz5cU+DvXn24bu6crK2acYw29/rB2fAbB4V80ACicXzGTGHKLIIzj2zQ9YTzIDClArrYpBa4R9KUuUqtGDzRacGBnlJFldRA5xvjE/V1F5MfNEExTWS0kH984n2hxXAdXAfNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xavTP8KHrX32K5bg362PtYMS5/8g4n7c16CAaxYEi3I=;
 b=fvRZMPDGxcmY/sUExnWv3ULBUcVN+EJg/l1+DV7xXa/q/eEgKB3F7i7XCFv/ot0RkiretpX5giyFDNNiFH2nS4uOdUTo15bvpgPGrdDepl/aNSVm0OO/xJYNdly4avSUfxHuISPukv34wwUlbLEy2QzPR2iVfD6Yg6pJFQuF5jhs+pnOu4hTSp0a50fjTsRHJoA5Zxe9U10RxMB4Cu+YHDOOtaqv6z6Vio18khxHkQE2CPBk8kMsqKEv5oQICniOe0OUcUrNqoJWze+tVOpRYdmBg+k83lbGkzgFosRYsvQJcbhA2Bw+bpZV3BtLAqQK2b3qU9k76vYuYMAmsA7piA==
Received: from MN2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:208:236::11)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:45:59 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::98) by MN2PR05CA0042.outlook.office365.com
 (2603:10b6:208:236::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 10:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 10:45:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:43 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:45:38 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 15/37] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
Date: Mon, 26 Jan 2026 10:43:12 +0000
Message-ID: <20260126104342.253965-16-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 077236c9-6e77-4e81-d7ee-08de5cc81771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sDsyt6U7/jeTJWszPh3qWa/Ro47HOBXY8vMnnT5ZCVKLi2XgKXpCNRYIKnn1?=
 =?us-ascii?Q?rSjh7oFLov6/3EczNy+zYkrDw5yVwG3zopX0Zw/tgQUt+A0HI/9/CQgd+1Dy?=
 =?us-ascii?Q?QkE/RXfrmTe59fH3Sn1jxrOsqTgXZywNH+Xgxpsea+5CXuYkXhjTr4wGEblS?=
 =?us-ascii?Q?DfD3jTNqJsTJPyhh3QFlnFITLuC/gRi85ew1N9CDyTnGCMOvmSFGndYvpo5K?=
 =?us-ascii?Q?O1fF+lC6aPf7VnNqPCy4dgqoTuf6C4G93CE7dsKjI+c7Z9UXgf2JmDOpgF2t?=
 =?us-ascii?Q?r0z7Y0vHfoyPKt3sAMhscGhYbrTdZeTpvl/QKMbpNKTYucWabHloz3adtPyF?=
 =?us-ascii?Q?pTXMhr4/729GGkzWttZ5Rs5u1IvUoj2haGFg6GhuXQgn9XWXPzx50E+grI32?=
 =?us-ascii?Q?EJLPYSjTxFVyxFyCA9SVV3M4JoiarG9/VeX1bBkKVSnFFmqxO7Cx8SkQBK13?=
 =?us-ascii?Q?BpkLjuWYw8YAKMKDjTauFUmbQ+dj211vjKx+oqtdn4YT0fJaVkwpEpWcP7eJ?=
 =?us-ascii?Q?leHxWxu3eVliWOsrBrEbU3kWRKvM2YK6qp00FgAHyDTEVaDUMBIS8yMYD2u2?=
 =?us-ascii?Q?2Bo9vBdDs1WVwAozJffShogQgKEavX3FipJCxV4nlpioMTa5sujdTkWzMg9X?=
 =?us-ascii?Q?k91S0oMXtFFS2EAUyk9DpQIShTb/NedZq6PcbarLYQaVzdmLNVMHhtlM07Hh?=
 =?us-ascii?Q?IcpgFqfU4atadY8A0yf6ndXPuAJGpnAjxm3m+38L3P5gm/UW50qQoqBemBi/?=
 =?us-ascii?Q?1hgNEtlfIilAMSFORG9PVveoFqrUPbqUtwY9vz96NMX1DB9/v4yxpKdzIDxz?=
 =?us-ascii?Q?NvrumPOJpfu7aVwemMTjUFrfHEKFCIWiMIF2sHZ6T4ycL16YZTkWPORgZwQU?=
 =?us-ascii?Q?5tm9t96VBzy/s30aCzphpeY/BzQFQ6O/7mFuia1eozGDZSvkc+kqr9bSfyOa?=
 =?us-ascii?Q?v706OBN5Jqedv93AtUE14BNS9vmAkVEp7vWbQ6GOsDF1pzhfFYlcLh6pRAVK?=
 =?us-ascii?Q?lJhlaxjzKUgxJqH9NG81WrJSyikGdIM+HARLC/6lIiHEjXp2UdEzvoWC5BTc?=
 =?us-ascii?Q?ERdgjp04DxpVMQYIc9agYJoxmm0rAoG9cDdeuwVLg2UX0mkqGm7KGckMFRx4?=
 =?us-ascii?Q?2EUfGdNUi1MgSd+9RbeX0jV3SMq9layWo1xW5WXKjT8OA3h5MstiyCWz0fMV?=
 =?us-ascii?Q?hy4cRYTV7pWSCnXoR4Nul2I9qFRXqi7G8DbVW3bpG7WkJsnoTAuqvqXA3r/5?=
 =?us-ascii?Q?rT61AMu4PkElYQMuwMuVYmF5uFMNvbCKL9/GtHr7Njeh6tcjk+RuOqu/r0LQ?=
 =?us-ascii?Q?AoiHlwnlpUqRVhJxuEuzyPy5fL8vRzmTGGFd1oLMUsy4j7471kYncZeh7Zsl?=
 =?us-ascii?Q?vEvzLxlLdmka6SjssAE7jM7Gec9T80+7jF7BYY/lfannDlrn37KOzImgJjV4?=
 =?us-ascii?Q?Thuhzd/s3IHwNbTR5x3KkPAOCsWC4ZgsDN0nenL80DawR8QbXJS2yVkJfQ2W?=
 =?us-ascii?Q?42KNWEPOnm84eSX0Duv2Huc/uq5Q6tG9XmypPVuep5VkwtLQ/I/XpwWqk181?=
 =?us-ascii?Q?sYXZZzyji+DKFhrYgUX8N/4s1C+g+1kQ2YimZLB5p2NnIZsAzrv+GSD07m3D?=
 =?us-ascii?Q?rCFHBkLmEr501bQAh05/BOf6huR1eH/sp87HaX4+0jmgI8qnjv6DME7aZHNG?=
 =?us-ascii?Q?7ylq4g=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:45:58.7876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077236c9-6e77-4e81-d7ee-08de5cc81771
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On guest reboot or on GBPA update, attach a nested HWPT based on the
GPBA.ABORT bit which either aborts all incoming transactions or bypasses
them.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 36 ++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h |  9 +++++++++
 hw/arm/smmuv3.c       |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 877b7e0e17..c125974d12 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -499,6 +499,42 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
     .unset_iommu_device = smmuv3_accel_unset_iommu_device,
 };
 
+/* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+    SMMUv3AccelDevice *accel_dev;
+    Error *local_err = NULL;
+    bool all_ok = true;
+    uint32_t hwpt_id;
+
+    if (!accel || !accel->viommu) {
+        return true;
+    }
+
+    hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
+    QLIST_FOREACH(accel_dev, &accel->device_list, next) {
+        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
+                                                   &local_err)) {
+            error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
+                              "idev devid %u", hwpt_id, accel_dev->idev->devid);
+            error_report_err(local_err);
+            local_err = NULL;
+            all_ok = false;
+        }
+    }
+    if (!all_ok) {
+        error_setg(errp, "Failed to attach all GBPA based HWPTs properly");
+    }
+    return all_ok;
+}
+
+void smmuv3_accel_reset(SMMUv3State *s)
+{
+     /* Attach a HWPT based on GBPA reset value */
+     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
+}
+
 static void smmuv3_accel_as_init(SMMUv3State *s)
 {
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 4e20b646dc..c7ed4dce3a 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -46,6 +46,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
                               Error **errp);
 bool smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
                                     Error **errp);
+bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
+void smmuv3_accel_reset(SMMUv3State *s);
 #else
 static inline void smmuv3_accel_init(SMMUv3State *s)
 {
@@ -62,6 +64,13 @@ smmuv3_accel_install_ste_range(SMMUv3State *s, SMMUSIDRange *range,
 {
     return true;
 }
+static inline bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
+{
+    return true;
+}
+static inline void smmuv3_accel_reset(SMMUv3State *s)
+{
+}
 #endif
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7e29284267..7a32afd800 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1600,6 +1600,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
         if (data & R_GBPA_UPDATE_MASK) {
             /* Ignore update bit as write is synchronous. */
             s->gbpa = data & ~R_GBPA_UPDATE_MASK;
+            smmuv3_accel_attach_gbpa_hwpt(s, &local_err);
         }
         break;
     case A_STRTAB_BASE: /* 64b */
@@ -1887,6 +1888,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
     }
 
     smmuv3_init_regs(s);
+    smmuv3_accel_reset(s);
 }
 
 static void smmu_realize(DeviceState *d, Error **errp)
-- 
2.43.0


