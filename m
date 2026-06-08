Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC826CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6P-0006cv-08; Mon, 08 Jun 2026 13:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6L-0006Wa-Nh; Mon, 08 Jun 2026 13:49:30 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6J-00074F-WF; Mon, 08 Jun 2026 13:49:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTkzu06Mc+LwmVqV4+SY91TM5Zor+/aGnt6Cbo3EhzBVsGtk72lh2GLzUZ65dwiX4MjY4pDGSUq3vpltL7xBcoBkHfT9pP2Z21LCpEspr2y+3xFOAMYYgp8UZh7QP6njmgG2EylqXkBSlH5kfbiQOBbRQkqQB9q0n6/7IIY+oz9W/x2C1Vup6uWW7Da4TKgRTlmAZnUFeuxmRueOIfN0Wm1NUhnrBCbQVjadTqwlwfedBjuQjJaQ8fgcARTchitX5MQdGheqNYmaW5FuJlHoRG8v32ocdvpaSg5NfbPyHJNQDvZki5WNvA+gZ/1kBl4Zrbhcb4OPDOrRAds2qlywyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MtDtCD47ZPEekMvemzEuGyG56mJaPca41zNRQtRZTY=;
 b=EpHZre9a3JNrlsYNYpJaP4SCGHdEFuaDCRtmqqCSG4xxU0iKzRhXPEKM0ka3MD0/1WMini0XW4IP3xgCmyXTkVFOPfAGwQ1mFpf0Wuxdf5mIE6BZI7nml9GHQpV7Ir14B6ilZwBAUd3+q0ZiP7HhMhPYwfawlii11OwJmoS6WRqeaRNbXQyCe8m3sICTUm4V0CsEiVsgFZ9CZF5IxVMN+Y0M1zMfeiZWjLM8JbQuoh5QEqaPAh7P7SyDWbLkB6bLsW+QIiwMIsIKi1WFwmYoaY9u9B0Fgo6rFxTCzKcE10sJ7M/6JlQ6Vs1k7b5Sx5UudHzTb3NH49AYvGrtxh8pNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MtDtCD47ZPEekMvemzEuGyG56mJaPca41zNRQtRZTY=;
 b=M6dBkO5znjAcyexEzME7g2v7EKPqzAkXMTv8duPIrdXMclXcnLBq5kJ7lyYPIUMC/4brPIIBrjZwnEbxVRVKBYis679UrLSXIrVMEJbVPhm+JUS4aapJyeZQ+5smX00/i/DFvx5WdcwCWUbddBz7WYR71jQz3NopYEjomW+yjelGcgrLOZUK6pzG7Sge/mgKlLNX1Fl24Vl2EcRAOP6D2T/VOg5bBlF7WIoRDN39SP44lIaAodslM2GTAGb2qrw31gQNcnWSz5E9Ey8Vhkn4SH6znNOda+81zwbFSoC5tiz9SWH9tOUJR14UFO93mNOqA5UC652CfCSTu8DRr6Uijg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:18 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:18 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v6 3/9] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Mon,  8 Jun 2026 10:48:54 -0700
Message-ID: <20260608174900.2227340-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f27c0b-2e51-4980-0129-08dec5864388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 31WIdS8QO+UNoky2Hv/+ThiaIfEN7y9INbv1tHD/zmICit+7ulh9r+LsciSqwEc3bMS4J0273Mq/Alh+V4uITkjDbRZKLMqWyrmhn+U5dHeFRMq4/n5m7xq06GB4dCNjrrqo+ZfGVTmpVyLIJbrS4fETZQu0NzP2w0P1tEI+jCn9K+ZcUc3vPyOwnAgchcTLkoaISgO3iELf8I9HV1+EUhdowZXEjsYk8OzPm3T78WsdaI8vhP+QxBAGAJm1Y0f+dw9ldwmAcaRRIevgmqErAp/a33Ve4y6XVgEEDPHfwCDm4RUbWaXaT7yQVAflSZ2t8fm+e+6AhILQNTHDdT786l4lLjLRGVY6T4egBq9NkWdzHwdI9b1h6UWQeqfGJBwzkgMi521NQ1KyUOl5w865FchnjcdPzjcwWVqzfqAtya6KhlibcHdycyJpCxmYVqvZ6PQ4SZZ7ZD5rxXv7aIDi4mWMWgWO76EL297CIOlvpmFZ2RUKb+zcoFHCJZboYRPTJNB7AhTXVS6N0BHX1cyoMOofmLL2kfK3Y/yNL+Su8JpBk621BW10QRqg6hMioPbWqu7ZgHg0DR7zJzmvni8BVqUhO8NpEKL4vjrQDMcm7mr7oUthaoEp/MUU5kP3she0aI4FnYOXGs7XADoyPS0PMAQhHGxw0EBRrVcoemnbnMK0Y0+9q3KPG2ImAf+D4y1+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q8MlJZ8eKG7WC0A6O/2eG6K87nE2AZ/OqMqNN6Ncy9VVI0cgLS5YjXDMJqGC?=
 =?us-ascii?Q?VSYiPOOIAgQr54je2jiPq4BjOIpXKO5Uu8fktgklWG+xU2pdnaqOCyVo6rpG?=
 =?us-ascii?Q?wxSROes6S4//sT/TZi5KNiJ7v74ncQcQBOOWA+dVw2ce5XSzfS5pfYXNBuiN?=
 =?us-ascii?Q?uySX1UHKrl9J7bSYtQm5+kcMq+Ek+g32l4TFQ5Ig85cBTbsf7kIRlkoeN57a?=
 =?us-ascii?Q?eYhJuBGgRXkjzwbNeGPxzt97HM8vn7NCFPzbid5lj08EbeumJh6N/zf/jsrj?=
 =?us-ascii?Q?a/HtqiXt08RFo6/XlK6+t3my1Oz6h7WF4D9ovOXFVWO7RcWk44Ojvlut12OT?=
 =?us-ascii?Q?x/D2vXWlMqnPPpH2nItRynL3t+QL9m1foajk7TTh0KtX09n6ysfHv9qCQNGp?=
 =?us-ascii?Q?MVQTYziHQxi6af1IoxQWT77wR1gvmDEaVglYJ5wDGkCKTRQBsgWUofEXwDD9?=
 =?us-ascii?Q?Qnj6SqvtMjBligCAqY0v+MeSSK1QhDvJjhw2hQ9NZ3qeDr/KDDdtnRs4Mygj?=
 =?us-ascii?Q?8TcQ5AnOQH5Gq+DE7Ii+7FTVXfG6H2Qinl/TF6PbnUvPn03CZBJIS7L89urr?=
 =?us-ascii?Q?fQsAz1koFwIw3DDO/Jd2Tve/HPGo7XGnxzO2Z6xsPZJyU/8KmzDpMf9ChKvy?=
 =?us-ascii?Q?j8y/BSZCZMgbeURJnMaJnRkiuEQ5c2Ibn7yOaIVmcr+VXM3n9JyFjwviqjEs?=
 =?us-ascii?Q?7F1Rai4yGm1ay693cOm3zaE6NsPagAJyzVM/EahAI5DFhdpk0y6PJouTej6p?=
 =?us-ascii?Q?RY6aMVZFTFrocA1m9DdQgnWB5iSYHoCIpl4aeKZLGwms3++uUtkjXPx246QZ?=
 =?us-ascii?Q?UiUNiQAHaQ0ZKr1FRQEayfpD6Oaazkvm3t7aqly+X0ZGaPvUNYrZioDJXwjw?=
 =?us-ascii?Q?YLNiQsVVaGqwsT9q1VBZu6GTI3bR9VCdJK1fc0wyzo1oQt4cQuaFQCnAqXm0?=
 =?us-ascii?Q?j5wdd/TlKeV13GXsylrzZ+15VYzlVXkR/d1W8gpDhJ9q+wC8fEv7yFmIvXXR?=
 =?us-ascii?Q?8r6+v8pp+J7XhlHUFiGbEiTkgkjo+YmgIqFUVi/nrwpiTNqL91eP5hSW0VlA?=
 =?us-ascii?Q?QryjtiO/TUTAjmyegzrhIuvAtZzxEy+Qk3XbFOHjdzkbd/GZpHu9izpMKfhD?=
 =?us-ascii?Q?IGaP+uS33zBlsBRmE10mBkT6N+Bj7UU2n16+yKuRZ3NGvqRkZNQ0XgK7Du2S?=
 =?us-ascii?Q?nDCIQQhhtKmGkVx4WoaAcTvWJ6ysSLsH9GYoXDm1hx5hbPTf+KzxUKX5NaCJ?=
 =?us-ascii?Q?R3XeFbJhgx6h8QHNBtnhMtu8Pa+WZeAvT83NHEVc1Cl8NLgUQSLbMAbtmdTg?=
 =?us-ascii?Q?8KB23g2Kpcrw1JKoN77Tr/qkIYiTyH2QZabM6XJW8tq1lF4Quh7frKP+zOO7?=
 =?us-ascii?Q?KzBzCBsi0O/5eU03nH0t4/9pC1CZla1i1jD16PJMetIbaJMYLUhbKvt9MKzq?=
 =?us-ascii?Q?P8p21HaPPCpyWsXLStXKZkZ3w3+o177GMn8gyq53aA+/V3XAwvLatoBJD5Bp?=
 =?us-ascii?Q?MkM2GbxLKStaMYdnpGabdbeKPnHTj7HAr21ItSr7K0XVzNbDA9OpymFFVRSz?=
 =?us-ascii?Q?5mvtXYL9dEYIwhGTopW4TTV+oRbXYCOlr9THJp9uoYL0kW9lppQLlmO9fjOk?=
 =?us-ascii?Q?3h61o6OdNlm/dX3QsX9w2X0qQYinAxlHi0Se23MiRsKya/bsnvX3q50yK3td?=
 =?us-ascii?Q?pNycnZfYFf9e+IGXnHShJM00nw39g1PGlRxkiJUrziSNNnesaLb+p94pIcue?=
 =?us-ascii?Q?BjAiHo2GIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f27c0b-2e51-4980-0129-08dec5864388
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:18.3450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZxGwdRUcAtfpXxkc5NIKt9SgMDsTGUdQWzd2Kknh8KMmdXWh6DbOA5lIpdoWQDA/ofCvaB34vEakN85iZQR6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

From: Nathan Chen <nathanc@nvidia.com>

Introduce smmuv3_accel_auto_finalise() to resolve properties that are
set to 'auto' for accelerated SMMUv3. This helper function allows
properties such as ats, ril, ssidsize, and oas support to be resolved
from host IOMMU capabilities via IOMMU_GET_HW_INFO.

The later commits in this series set the auto_mode flag to true when
an accel SMMUv3 property value is explicitly set to 'auto', or if the
property value is not set and defaults to auto mode.

Setting these property values to 'auto' requires at least one
cold-plugged device to retrieve and finalise these properties. If the
auto_mode flag is true, register a machine_init_done notifier to
verify this requirement and fail boot if it is not met.

Hot-plugged devices into an accel SMMUv3-associated bus will re-use
the resolved host values from the initial cold-plug.

Subsequent patches will make use of this helper to resolve 'auto' to
what is reported by host IOMMU capabilities.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   |  2 ++
 include/hw/arm/smmuv3.h |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 862be814a0..fa0a97cece 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "system/system.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -35,11 +36,33 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s,
+                                       struct iommu_hw_info_arm_smmuv3 *info)
+{
+    SMMUv3AccelState *accel = s->s_accel;
+
+    /*
+     * Return if 'auto' was not set for any accel SMMUv3 property, or
+     * if property values were already resolved from a previous call
+     * to this function (e.g. if this function was called again after
+     * VM boot during device hot plug). We do not accept new property
+     * values in this case where auto_finalised == true, and we re-use
+     * the values determined from the initial cold plug.
+     */
+    if (!accel->auto_mode || accel->auto_finalised) {
+        return;
+    }
+
+    accel->auto_finalised = true;
+}
+
 static bool
 smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                                  struct iommu_hw_info_arm_smmuv3 *info,
                                  Error **errp)
 {
+    smmuv3_accel_auto_finalise(s, info);
+
     /* QEMU SMMUv3 supports both linear and 2-level stream tables */
     if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
                 FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
@@ -918,6 +941,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
+{
+    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (accel->auto_mode && !accel->auto_finalised) {
+        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
+                     "at least one cold-plugged VFIO device");
+        exit(1);
+    }
+}
+
 bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -925,5 +960,11 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->s_accel->auto_mode) {
+        s->machine_done.notify = smmuv3_accel_machine_done;
+        qemu_add_machine_init_done_notifier(&s->machine_done);
+    }
+
     return true;
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 407940616c..87fecb5c68 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -25,6 +25,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 82f18eb090..85be3d7467 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -22,6 +22,7 @@
 #include "hw/arm/smmu-common.h"
 #include "qom/object.h"
 #include "qapi/qapi-types-misc-arm.h"
+#include "qemu/notify.h"
 
 #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
 
@@ -74,6 +75,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+
+    Notifier machine_done;
 };
 
 typedef enum {
-- 
2.43.0


