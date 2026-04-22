Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90BBFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeQm-0000TM-AQ; Wed, 22 Apr 2026 16:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQh-0000Qo-KW; Wed, 22 Apr 2026 16:44:15 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQc-0006xi-2N; Wed, 22 Apr 2026 16:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgiJ6sBqPfvI807ne9JwBNa1ymZQN1DYzh8ExCdV1v5GQY5ByMj7To24U7Hzb7BJmtd3vMhHHL1Gfork4gh3nKSQkexjVhm8foQrEGPn5IFM87tAXAuny0wzRYRAH4N/cwdu4YYGZv2olxlU2I2yW3RJrdUdEshw2T1S2U8j7D+c4t8SKXg+yu+ufHv4dFFF7/vpxxDQNsRpYPp/MlvYkPJZ3EtBR34nGLj1X9uuMGVFeuHV7Ndd1kbBDZbsamJ6XDrf0ixHVGpK35BFEaA41acANnZ61dwPnR10JYzw8TsEc6jXztCX2KaXEmkX1bys1w2f7Q1ov6dZ5r5AZDPcuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OwSurik4J4X9c9HXqS7hHFNdlb3HuQJULq3X5TmB2g=;
 b=KKtG0gv6UmAqvfrER1Zsh51sOfRNDMS0nwOmfKqSnZ0kKl8xzJEBSoGyGJpXZhcFjc25X1lL0IEeWbxM3spnujZDeZPKo+WlZ5L2KURl3S0gaaHSwfPI27Txbbbbz+nlbFEPIUCzfhDTT6Bm5ZDtngIvXyhQvi5cBrQfpPBe6wHoR0QZsKT209iWMyeUSX8OtgM4skeCD6HLvJBe9mRpDb3kvxGlDrOjn8I1gnv7zyDAI7S7jL+yVOjT65XCKb+8ri3hK5evnqX5iDoSQBmiL4+ezwZVqUKH42z4VvfaT9AH9lyDnrKRMJft4t3YJ4xdlPKj41b0dyFRNireyppXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OwSurik4J4X9c9HXqS7hHFNdlb3HuQJULq3X5TmB2g=;
 b=a8Rjobwx+tc9kzZzl34I+CTo02KcjW/W2wTza0ZLS3M44E8qXXGAchtf/DnN2zirUHUdpmxhg7KYpfpTciHAp3VWEGWzlJ8PTPJC1I9AnIwohTGvVsDOpK78npaohoykTU+fyWZQOfZCk5DZQwxoHlPrquQWyRgSXkOFwnVbHC7WFhYJH+kq3Z2G9Ochyi1J2mgJHu7H7Oc3vv5GujsyQM/uqGhJAA/X2ZSdNgZ9odhoSftC11X6dWEMvhWy7KmpRkXF2bxhHFWALVgAtSahHcekC+bNYwbxrvvXjtFmncyXF3043UOJd4YbGDm4TXGbT1M3oBvsJI6/3Xn/Nth7aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:43:48 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:43:47 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 1/7] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
Date: Wed, 22 Apr 2026 13:43:29 -0700
Message-ID: <20260422204335.23116-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0124.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::9) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 763a3704-28ec-4cb4-5a79-08dea0afd9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: eH1G/FwZavdsecDB0SG90U/WFnXpN78jNwAEepQ5BGDD9IF8i9Zvb3VUQeVzjnqd4+wTSn4shttdu+7SXKGM2FVYrzY52VMsZiZQKKxg6vKClOrZ1wgaAO5XTHf0AooHBjnZ/iAv+HaLtVMaZGaNB2dNQSy+kg5fgLS4LQDS8IVfTGajoJAClkCRuT23Vu2/LT5r+C0sI9ugbxHBgE/Iep+S/2xIy7AwrYpFUxAK+WQXnI5Vt4/YEQVwD3BWgxchkaDHa8qR0KedBRHTf7bU069XZV8I/PkTls1/T1znpoh+sm9O2bs63yIMkYl/+YgRZvfjNIiPNM5TFYSJW0dmew60qqsnhZg7K7lIEfA+cWIeA83W8v6/zv3DzDSgIo1WiUMEcaLH96BDR0wl6tCXOFzm2ZOrntBWmhU9KoN7olgD0md3mF6LBx/X+RNnlNwna+P+u1V3BpL8zJdsIyjWrTtB6rW/1XUu3IAtmajJ8e24O1JH6F8p/ZPKBg1plyiG1+xlRvUyx9JxePsTxt6d+w2/8y5p2iJJYhmM/WCPQF7HdQSlouJ3k9XKxALifjbzJv50nUCap/Q1X8xwJKGr83/XVyekmBnEu3qx0dSmSv5zyKYQpS4xMoKHz5SMezCCbD6/Mbrln+IVlWvJaiVjjJPTENUwSM/MFCeZmemkE8sqi819kC7Rf3rWG7bMFzEU9XdYY2HXPKfh/BFZn0sKtNKmi0LohxCFBYp3/2EmboY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bIl59XKDZLGEiANqItVdLrWN8Hg8SBkCDJZn9jUX50sG/zv0eI1qNO8PdZHi?=
 =?us-ascii?Q?y2Zoz4CgmLatzHtrK4rBNDI6dnG8PWAY1otUlHmHxQhpv9i0CvWljVZmK1m2?=
 =?us-ascii?Q?Vg/KsiDZAVm0q3h+LV/VlzSV60m5f1LGdhlPgOcThVa+V2EbVYK1s45bKkxn?=
 =?us-ascii?Q?2FHUto5RvkytbPo539lyNBDO5BSrqRsDG5jZCjPAqM5+D19vdq8dU1NpdPkY?=
 =?us-ascii?Q?NhkQyfj3425BCIAJDobf+FeD6Xe+GDv671UcJqGuYLD1dY9lAd83On4dJcEo?=
 =?us-ascii?Q?F0OCzwbGEQpOHtSEjD9qOKCobrVnOQRxR4JuJ9kPTJGhPIJYwV9fkcFaP6x/?=
 =?us-ascii?Q?FhCJPnofSi3orvDibxiazzXZcwtA2omzn4YcVvOpHvI60DgRIVRKkqYr/F3Y?=
 =?us-ascii?Q?DVft8JfX2VLHQQtdc+8jMRDlKu3M2+shgMuYRV8v16yOWU1hZx34eSxIY1WA?=
 =?us-ascii?Q?p82yz+oLKAcZzrBIcfHQTEHIx5e4NmTvjsRCYYRUydXDUHJn8Npaifc67wO+?=
 =?us-ascii?Q?O08khtfCm4qDp+KpWpsWvIfZnUVOy0bybH51NcN43QUxwJyaODwz8bk9hrXb?=
 =?us-ascii?Q?jWp/8WkT3DFqUyXhBQOrRvusS9jD5gb8wOn1eX7QJlgy6OkKE0xyvgSZbopu?=
 =?us-ascii?Q?qhISfnCk0B3jglV/IuiE0h2tpmaWAjLR1iRm/OzJOtnfQIe3e5uAUPfu8uQv?=
 =?us-ascii?Q?k+42fPPqv6BRCKOSbqGg3wL9pLhZPAnH4SFxwo2iIjZ0zeWTqeA098hx53Sb?=
 =?us-ascii?Q?640KL12dmE6LSZEYiypATY1Q+NTIvQyxncGb1OI7pDr7ahfCV9rzDVJgWuUr?=
 =?us-ascii?Q?aNQy+N+DVq6vTOL+31kos+l2xfGZ9PZxMv3wdn/A1BX/HR1glHZ0akW1lstS?=
 =?us-ascii?Q?WAnGV0NBtfJSU+txMOR+NzwsHubh8TTQMXuV64cjMcDGavD6pZOwvt+kF1pz?=
 =?us-ascii?Q?/OEGbRWw1A5GlkkB0vEwnG8zuZLgxBh53x1gMxafsnyxlG2hjII6YxyovDV8?=
 =?us-ascii?Q?tRwdD4hvHoJkAQHLUTz1m4oAT+i2vsyimLbRxMhyA5nac829GzmHyy02Z5uL?=
 =?us-ascii?Q?AdVOHpG2yLGfY5aKEbiHeUO6DttuQjL0tTGyERIMuimAF6CvL8FbkKf6HD1b?=
 =?us-ascii?Q?+3djQYuelkYmRUKDJUsn2UdO79K3pzPZhmn9ld2tggE7UJHfX3mGYEV6H2ZH?=
 =?us-ascii?Q?Xjejdv96RLwp2Ax5AXTP+xEIlHPs+ccJDtpvBlkePSjASG+wdMDjvCiPbfl5?=
 =?us-ascii?Q?ZdZSMQIkHNaznFZ4aCWYIB6Y2W8p6dYbIjnpPLJCQJ1BiCsqQf6MjpdWBFM0?=
 =?us-ascii?Q?SBa0brVSnff30HwIN0hqox1LH+wXR3v5ZSCsPRwAYrQhK+yx5WpKCTBzFsiq?=
 =?us-ascii?Q?8KsxHkEJQoEL3OC8z7jLMaf8qk/m+G294WdMr7GiAdphAxASaubd25dvqq5c?=
 =?us-ascii?Q?UKKhmnMl8w+eUtqzrDBRZ84qzXz42fJcOCs9U5MnhuBtmogwn3K/GXiKvSZI?=
 =?us-ascii?Q?lPTRXc9ZxETFzykcQbtxq/eBlosbTuzUCNMcwqNSUf3tsupDHpS5yNVoAaET?=
 =?us-ascii?Q?efkjcEiMS4qGfZ348DKEmOOcVbgi1ERmI/ZNqslZMDnk/r4nSzATxinFSo7R?=
 =?us-ascii?Q?hBYKyWI3mSRE85LeRFdO8dEAjYhKmqkbl5UB02ojbyoh4mjvHvfieKgYRGWr?=
 =?us-ascii?Q?W8nWqFdlZVOvW7MD8CreKXDJ0sVpE7T9RamXFwB3FVK4OGjE44MiYGE3amdJ?=
 =?us-ascii?Q?CHEVZaayxQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763a3704-28ec-4cb4-5a79-08dea0afd9ed
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:47.0112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xN2+ZtGSrnFErqISG1bKxKoUQObLcTb1UuM1KLxClRpANXj0vSjKQt79hL0+wtg65ts6sC+RpBCdj5EbW7y28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 43 +++++++++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h   |  2 ++
 include/hw/arm/smmuv3.h |  2 ++
 3 files changed, 47 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 65c2f44880..8b3bbf3ef6 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -18,6 +18,7 @@
 
 #include "smmuv3-internal.h"
 #include "smmuv3-accel.h"
+#include "system/system.h"
 
 /*
  * The root region aliases the global system memory, and shared_as_sysmem
@@ -35,11 +36,32 @@ static int smmuv3_oas_bits(uint32_t oas)
     return map[oas];
 }
 
+static void smmuv3_accel_auto_finalise(SMMUv3State *s,
+                                       struct iommu_hw_info_arm_smmuv3 *info) {
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
@@ -917,6 +939,22 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+static void smmuv3_machine_done(Notifier *notifier, void *data)
+{
+    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!s->accel) {
+        return;
+    }
+
+    if (accel->auto_mode && !accel->auto_finalised) {
+        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
+                     "at least one cold-plugged VFIO device");
+        exit(1);
+    }
+}
+
 void smmuv3_accel_init(SMMUv3State *s)
 {
     SMMUState *bs = ARM_SMMU(s);
@@ -924,4 +962,9 @@ void smmuv3_accel_init(SMMUv3State *s)
     s->s_accel = g_new0(SMMUv3AccelState, 1);
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
+
+    if (s->s_accel->auto_mode) {
+        s->machine_done.notify = smmuv3_machine_done;
+        qemu_add_machine_init_done_notifier(&s->machine_done);
+    }
 }
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index dba6c71de5..3c1cd55714 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
     uint32_t bypass_hwpt_id;
     uint32_t abort_hwpt_id;
     QLIST_HEAD(, SMMUv3AccelDevice) device_list;
+    bool auto_mode;
+    bool auto_finalised;
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 82f18eb090..fe0493c1aa 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -74,6 +74,8 @@ struct SMMUv3State {
     OnOffAuto ats;
     OasMode oas;
     SsidSizeMode ssidsize;
+
+    Notifier machine_done;
 };
 
 typedef enum {
-- 
2.43.0


