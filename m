Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A99CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc84G-00057z-W5; Tue, 23 Jun 2026 16:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc84E-00057e-L0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:49:58 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc84C-0006UQ-RJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpWYsyp6/N4NAkv4cHmJht3GKXwoZDaMFNXXkk5IkjrocIg4L+/BFD2cZ/pteAWvJNdigYlHRlBuJNtxhYRr5YmnOvP6yFhmL5EZnsySFY47+SzTH9/ansIzzsvYHjVKmKcKe0LI7NTM6npMGmr39YbfpmSPu1Yfhmq/E+593Kdpur38lwlu0lV9sw7dFcKMV793F33AGyCJjtPZhk9k9YGzy3vRy0A8W/U2UEHbXzkmzYS/2mXE7UU6mIQASgGmIcAprtoQ/hDRM5R0XQJooqLK8Iz2JNtmUJO688r2xU5bSX2B4JGn14jv19k0HKDwcJyzZvxtMHik48kK4wXIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjec6Zn69Um7n+lJ0P2BveEg/Li5UPG0D5M/hUL4cqI=;
 b=LsMqFNTT09xOT8/vdB4O330zz08f3Dmf9tPicHmhBu36ZuuPkTJY/+1t4qeGXXkd0B8ocJqyvvRACFfB5tirnuGjtiW5Z2J7K903HhBgB3mCNmNmgjf4qQTnkcd/0+mgNV/Jl7YNTNruF7G3o+7N7NXuZ36teFW+iNcXRMRGLaGQaIegqAJELluFsTiP4F2kVmpNQ6c+nz2SVeIlNUwZDNcL+0joDA66cOleQ1r9XJkiCKu3GyUcc1B5mzBmcNq2PNky+iIMRX/O2okOZglz/KlPr+j2wtwC5Tgh82lXelUWIlHuqHk044alfq5z271gTksDbns6aH1T/XAfPnONTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjec6Zn69Um7n+lJ0P2BveEg/Li5UPG0D5M/hUL4cqI=;
 b=MFr0VdV3C35sM8OKgvCCRtVslpTMAZ4WZ97zZadmvaojn24nz9klMsB5Nho+Ej5bsHLT4FAPebFMc1PqmJahquPBN7PWYVl1tPkGnPtYomswhayGQuNguy9J9kfecl6tnmW1iInFqYaqtjNgjJ6JyQ7HWzJCzLkmmIZ0M0tORmtK51XD3REZJ/NVHEej7cKgqT9+YjsxNilBZbw7F10RKsNJLIYzH/57uWtAv6hpxH3Xg4wdeVAVFOgihnWuQEFvg3mNHXjuOy95z1e/I5k4/cduzSdy2z6z4qH9jvtDolhYIIl8cm1swmnFMaiZijrVfHC9ctcJbJRrEqtIo9arZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 20:49:50 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 20:49:49 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 2/2] vfio/pci: Add ats property
Date: Tue, 23 Jun 2026 13:49:42 -0700
Message-ID: <20260623204943.989903-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623204943.989903-1-nathanc@nvidia.com>
References: <20260623204943.989903-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: f6dfb4a5-de45-41fb-709b-08ded168f797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5u9qH/DSMBzkd1gL3I5TKCB8b7UjYTzB79j9As4yFdJiQz7BixxkC/p5Qq7gbY+3yd/Ar8s5NvSOdoDeLwhbkPUdWpagSKVjK3a0v4Afho4o0ghxx5u+AJggBFE5I4uR+Iw+OXolZbW1uwb7zvcsa0h5uUk5HSHG5lMN+aBWHCxZ+m449mOqS8+ynFMAvmPm2AE935AlKg740rO2RTZFGZFGqDfI/+oAGgNe0xw9uBLdMKyqW5wqSdD0uoq1VTaYn3UkptWJeJr0uC8GszC+aNiyFCuXPuTaDl/LOsUL9ezkzYanS/fkUi9q4sSb9DRH4NvgPC2n4lCHFga7VHyfGgnLDe8icgQwPO7U7Lpsn67EiAAVOMaw+5rxpkZHSNLz2Oz70ypVmlZfCbOuX6/bLKk7zlopg8LWgPoJWY+DqMVHejlYKcAX+k8HVr/7YSzVbzq7hnVq3clSwLEuriEYZTBq5oPfKb+nEzpl23bp+bRi922TE9U1S43AMpbjEosa2/ZEwI8DTz6xIupjNEByoVIESKOav71fLMFi1imSTwvfwDwx5JUxIL4hYWO7ViwHVHzYoHJvhMmuyarb33/vYpOa7V8g3TC/W2Fq8ZwRm3SWYflfgq54TmACjy25+0VfnpiGZ+EhCMxU+LXm2DCk6/42C3zvR3L/Yd+sRCLf6NQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfBa0gUiE22uGiyATE7FMHpzMm1iXFocOntYitMSxDv34PkBB3MaSm8jRnTh?=
 =?us-ascii?Q?DIIa01nQqom79d8/b12EpN/wK9eXoWeUWpbZe8qRxKQ2+mKjAQd/eLvmk160?=
 =?us-ascii?Q?xoE2QukTOZSvNcLvaY6KUW22an5UGqcGNlRSx2ZkOYG8lEa650Z6EkxeUjQ4?=
 =?us-ascii?Q?z9zP0SfRD4MYrJSVEJIMEDomWpAFq+HK2l3q09rkuTfHThrHjCwXaabtkjvt?=
 =?us-ascii?Q?f/MXcEqVMfvVK4TFh0zqY/YfZ/DxuX2hrMCSEuIi1xOBdRWo8zhHG0HX5Ybk?=
 =?us-ascii?Q?MJZtwRMJyH8qWTBUL1TtAhMQjcG0YLTe/ldGUQZyBguo7x1LCP0Smk9wRodP?=
 =?us-ascii?Q?1EfZmwmxKUHLaXgsn0u0KwvXLoJcytbW57GVgTM38oOH0grHa6w6PR3f9m+a?=
 =?us-ascii?Q?Uk+xbG2sdPHbKmOKB1bmM0u4Mx/3r5hr4FdPRC14IYhQ9cwtAqpeHNMoTFIN?=
 =?us-ascii?Q?RR6T58c+4IDf0DaMpbepMzPM/mcIH18rTkfm2iNUOHa7z/mxwiKlHmJIvoby?=
 =?us-ascii?Q?QDEyaXvyraH7wh7OdLir2eptCOXgUg72MMotU1EHSjY5QTnuJgdVy+VLlY9n?=
 =?us-ascii?Q?0J170sKsaEB/3ujpXbHSMu2A0pNZjNRurHEL5ZGNLYpzTFDQnTlHsRjTs68A?=
 =?us-ascii?Q?FUzxvTku5910F4ZosMS3nnBV86d8XYr8qTC2RUF/ilplBs4wetGKQcjL4s6c?=
 =?us-ascii?Q?P/ZTSUdR83+OmQ0y015j5pLSRWMblwcv44kNvSglzhtoYi0mEUaDSQbsfRBm?=
 =?us-ascii?Q?bKUi3JJRVxOWGE5ICvbcBnj1grFVVvqf2JJkKLprsXG2q99HExAcBR0IdJ9t?=
 =?us-ascii?Q?k8W3Nh8N37wDp8Th5evA4v+Y+tdMu10fft/Uk5MhV+1JTIWkyfXbFyYxC3H6?=
 =?us-ascii?Q?lXHrPlFrghUrpjqyxxs1nqRufrljdzHOq+9WfmIcmwmQ5hAWlFQPLbIp9QuD?=
 =?us-ascii?Q?gI0RrciX9oU1KkE1jwcSj1nNIRYGkyLnApaaxdl4432ta8efgDbZ9kjtCH0s?=
 =?us-ascii?Q?URHwGcyQbej7F5uzbh+O3qImTKMFKZL0zVPj6gw9SP/4dMCocCC/Ls5GJkSN?=
 =?us-ascii?Q?wXC/0qigbERUFgnE8EIcO6ygr5X9KwNzuIwOz3ytSdpaqVjUv7n8iQsjXQB4?=
 =?us-ascii?Q?XHnTqzY2649kIOqifIoBKW3e4cenbFRY2tekSqx1Otz8SqS6AtG9i3j5qHpJ?=
 =?us-ascii?Q?EIXHTNLHVGUGtyHyfRqqLSgRxmn3wE72LuLnFnSSQhyfb67Wa7mGTkbKZOhV?=
 =?us-ascii?Q?AQVrAUu9EkoDJMVsKq8BmE2XVLt8u1mlL89UFiZoot66IesJo+vSj8s7bG+1?=
 =?us-ascii?Q?YJoWSsqCup5oIUd6pvvNaL0zE1XHxs1Z3xkmhLNd1j/O5Xx/9kDbkGzEQ0RV?=
 =?us-ascii?Q?qUh9hrpllTQXyo3aZrkMEnti5kxWZskc6P8d5kUTDMks5I5ayFc5eS8mcrhR?=
 =?us-ascii?Q?Nan+eFn1lGIIQcepsgsFDntNdHY+5Z+SQU1I0/EMTBB1OaW1aEtXVKKljNLq?=
 =?us-ascii?Q?WQVcvIPh3GBR20lw3DkIclohfvdjd89DFqxlk5ajq0sXwFyDjj3bCkRZrB6k?=
 =?us-ascii?Q?k/QPpMppCkjRB7X0+Xa/pkORjqMXi25RPJUo5OEI6i55kbnp9IbdjiJpM0UR?=
 =?us-ascii?Q?HJEz6nlZqW7wpEI66mDvMeAKln5vJkx8+8SNBkgoiJpdzP8Klafqq7sTJuJk?=
 =?us-ascii?Q?3jyOiw6Xzkj6snM4UCT4xIdCwPr0rMaFo5lFe8Oqx8CLOujGeE3CXFYyBomT?=
 =?us-ascii?Q?IEd/u8J9pQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dfb4a5-de45-41fb-709b-08ded168f797
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:49:49.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVn11jQsb2rFXFftUytteUF6/ZFLbWsvWxuW1a4OkeX5axtvqRRxpwTJ3ygPrF3HGL8tFXrWoYRjpH73spKlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795
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

Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
extended capability in config space but we should not expose it (ats=off,
or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
the capability so the guest does not see it.

If ATS is explicitly requested but not supported by the kernel, fail
device realize.

This aligns with the kernel's per-device effective ATS reporting and allows
vfio-pci to mask ATS when the host kernel reports ATS as unsupported.

Emit a warning when ats=on is requested but the physical device does not
advertise ATS, since ATS cannot be exposed to the guest in this case.

Emit a warning when ats=auto, ats cap is present on the physical device,
but kernel reports ATS as unsupported.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/pci.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..f2934f2d84 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -188,6 +188,7 @@ struct VFIOPCIDevice {
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
     uint16_t vpasid_cap_offset;
+    OnOffAuto ats;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
     VFIOPCICPR cpr;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..fbec41f0f5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2546,10 +2546,53 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
+/*
+ * Determine whether ATS capability should be advertised for @vdev, based on
+ * whether it was enabled on the command line and whether it is supported
+ * according to the kernel.
+ *
+ * Store whether ATS capability should be advertised in @ats_needed.
+ *
+ * Returns false only when ats=on is explicitly requested but the kernel
+ * reports it is not supported. Returns true in all other cases.
+ */
+static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
+                                                 bool *ats_needed, Error **errp)
+{
+    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
+    HostIOMMUDeviceClass *hiodc;
+    bool ats_supported;
+    *ats_needed = false;
+
+    if (vdev->ats == ON_OFF_AUTO_OFF) {
+        return true;
+    }
+
+    *ats_needed = true;
+    if (!hiod) {
+        return true;
+    }
+    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    if (!hiodc || !hiodc->support_ats) {
+        return true;
+    }
+
+    ats_supported = hiodc->support_ats(hiod);
+    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
+        error_setg(errp, "vfio-pci: ATS requested but not supported by kernel");
+        *ats_needed = false;
+        return false;
+    }
+
+    *ats_needed = ats_supported;
+    return true;
+}
+
+static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     bool pasid_cap_added = false;
+    bool ats_cap_present = false;
     Error *err = NULL;
     uint32_t header;
     uint16_t cap_id, next, size;
@@ -2635,7 +2678,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
          */
         case PCI_EXT_CAP_ID_PASID:
             pasid_cap_added = true;
-            /* fallthrough */
+            pcie_add_capability(pdev, cap_id, cap_ver, next, size);
+            break;
+        case PCI_EXT_CAP_ID_ATS:
+            ats_cap_present = true;
+            /*
+             * If ATS is requested and supported according to the kernel, add
+             * the ATS capability. If not supported according to the kernel or
+             * disabled on the qemu command line, omit the ATS cap.
+             */
+            if (ats_needed) {
+                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
+            }
+            break;
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
@@ -2646,6 +2701,16 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
         error_report_err(err);
     }
 
+    if (vdev->ats == ON_OFF_AUTO_ON && !ats_cap_present) {
+        warn_report("vfio-pci: ats=on requested, but host device has no "
+                    "ATS extended capability");
+    }
+
+    if (vdev->ats == ON_OFF_AUTO_AUTO && ats_cap_present && !ats_needed) {
+        warn_report("vfio-pci: host kernel reports ATS unsupported; "
+                    "ATS capability will be masked");
+    }
+
     /* Cleanup chain head ID if necessary */
     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
@@ -2657,6 +2722,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
+    bool ats_needed = false;
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
@@ -2667,7 +2733,11 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    vfio_add_ext_cap(vdev);
+    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
+        return false;
+    }
+
+    vfio_add_ext_cap(vdev, ats_needed);
     return true;
 }
 
@@ -3815,6 +3885,7 @@ static const Property vfio_pci_properties[] = {
     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check, true),
     DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
                        vpasid_cap_offset, 0),
+    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, ON_OFF_AUTO_AUTO),
 };
 
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
@@ -3966,13 +4037,22 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "destination when doing live "
                                           "migration of device state via "
                                           "multifd channels");
-   object_class_property_set_description(klass, /* 11.0 */
+    object_class_property_set_description(klass, /* 11.0 */
                                           "x-vpasid-cap-offset",
                                           "PCIe extended configuration space offset at which to place a "
                                           "synthetic PASID extended capability when PASID is enabled via "
                                           "a vIOMMU. A value of 0 (default) places the capability at the "
                                           "end of the extended configuration space. The offset must be "
                                           "4-byte aligned and within the PCIe extended configuration space");
+    object_class_property_set_description(klass, /* 11.1 */
+                                          "ats",
+                                          "Control guest visibility of the ATS PCIe extended capability. "
+                                          "Valid values are on, off, and auto (default). "
+                                          "'off' always masks ATS. "
+                                          "'on' requires ATS support for the device and fails realize if the "
+                                          "host kernel reports ATS as unavailable for this device. "
+                                          "'auto' masks ATS only when the host kernel reports "
+                                          "ATS as unavailable");
 }
 
 static const TypeInfo vfio_pci_info = {
-- 
2.43.0


