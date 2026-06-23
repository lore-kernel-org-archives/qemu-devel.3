Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A228CDB46B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 02:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbqzZ-0004im-QJ; Mon, 22 Jun 2026 22:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wbqzY-0004id-Lb
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:36:00 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wbqzW-0006Q5-Rz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 22:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btIf5UXQA7ekL7AYF5dPtMQ3HuwLGdGnf0ZRYeRP3SjyZTPc4YWzW3nYwABSe49uMuqMaUFXdZkR9gXleWWysoqXYTL/P/OJ0P1XndOTQ2NbOhaZkoBEF3csQs36DMVveSlRUfwkCBDGGRth9gbii7WqI1n7uLULXl9+9LW6j6FoBI8osqU3KVkAZTvOdA/oewr2fUzm+aK1ifC74kRlrEbk+TOWl/FBVo3fOXzle0fnwpfqVm84CUIiZXqcx48YTmWDLhI4ehhAHTp5IGbHDepSsSW2JllLQEeu3nJSuGY/w7rjs/eYIGZITNXONfNv1cETA2ESZ7EcISnmnXCO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gjga6QmphBXLMyzCC+sRKcNxY6dR6n/JbVbtx7thgAw=;
 b=qJm1RjLVIeXiQtzoT9NCbBKofV0Qop6wXaPPbbZOnpEYFKiqQ2cT4Zve3ZTfxgH+7RU+FfxhX5pvj/K/NkWlethUOuYd47qNwwUl9vJB9aIyqybf5TT4pb7Z55yMAUdTFZOIefP96CvsBuhWd7DUTQFqKLU59SiPxvqsDSe7ij/n6aQatTEiaP4fMOgFwBKRSOe8SXNkyGGdEqxue3GSivyc3tXnNyOqxG7EGS7mYjjjnnF7M7EyYV7d12ehmpf3NjFvw532G+XVtm5lNU76G9aTjCHi0oKOIdaL8E096ZInKb0/frkamy0B/utgtQUC2wbVTtCWOIYSCo0yela+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjga6QmphBXLMyzCC+sRKcNxY6dR6n/JbVbtx7thgAw=;
 b=FgkU/Aua+/66F3gK+D8OVgc05XlAdB/TEtNYRtRuoFAGFGVLk3P8p0K/z6F9njSa0LEId4uhWSjvMyF1GyLCpyTDbwmSwT+GOZD+9jfEVHLjG9MrNxCe9NcCqydTC0034PCksxPW7gcKtVDD6cimY6JHA4I6CkUFgeI4wMZrqOpy8U+i95M7jvHU3AJObtBN2RohLIUOY1BOQ58AY0VFeURzp+k+Gwf+ZUuDXTNHE/YTGA1Mn2WzdrcakNDrWlesQb21sszHAHZRpCHrlRN0J1s9zDMuyjBdpp2B/yDJ4xrWcbFLjpCAYt1UQxOTWBcnaSvbWediO9Bbft/JgSu+JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 02:35:53 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:35:53 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 2/2] vfio/pci: Add ats property
Date: Mon, 22 Jun 2026 19:35:40 -0700
Message-ID: <20260623023540.836825-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623023540.836825-1-nathanc@nvidia.com>
References: <20260623023540.836825-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 85832561-2645-4ee3-e6d8-08ded0d025a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QpaHOxXiO4E7TCCV3bsR+5M0Ji3sZ4d27YNdu5z9Azo0MPGVnafIGVgFp4PiKpFwuAwMq7kIRZ6JECMzk37J2Suj3X1fUhmtRZ4x9LfQfvvqPR9IvbE9krCgJPwiVB2rBr31qZAW47AQoKZHfHBEraFQQRp/wxlj6Zk7JjYN1c+hMpdFbCU7xA/9CCykqQr2odgq3xre1llG41QV0prAd1PHltha04L7a4jYLnvcBrBbVvmeDJA9ZoJVKy4c6tmFToXhSixsJznoj6eJvJLvdQ4zDox81Jx6YT1YSldkb1Q8KdexmMB8ZNHUo/H8iBJk09bL849+qMmTJCZAi6hC5JrXeQ16BsVCx4ZOoSXgnq+eEk4blw8MutrPEYNxUFJUTNjwRvTGjahG327ETUpwOl+5aWEATfjZHRWOydMqwZ0yAB4kS+Q/d7qZ8/yEtUXk4jtJ3IKZcAVHqP7jTM0MuA59fOFzf81pCiDSXoYsYZYzlQHvgbB8Sv7xDUxvkUjHfec0sP8o6HOidkve76iQE03am/pvGGnET4afgoFSt2qwwT2NcTQ37tRlV3mrEb6aGhOqHjbwWcmUHLYheKKxaxodEGZY5bJlYzW0Ic4AfZ4Fmf/a8NKCEIneRcTeAYCVkdaWtLAAu5dw+OakCRjleEVkoeigFBWeari8hBCLhns=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xCECwzoWAa2EM8Kfx+YjC6F+5AVvaYRHBtxqXED81hxPeab1sc9G7gWcA2s+?=
 =?us-ascii?Q?sQKHdrLHGncQAGtTUGEsp6hx9EaTvEgDLWOU5BMgZ9IOUXkAMMJI3uNnMDjU?=
 =?us-ascii?Q?Gjuazt9nTgi16t2sDjSRYXPpFOIVYjOFY3o8pNVJOaTD1fq524jgbFQMHmle?=
 =?us-ascii?Q?JSFCxZM5WZBr6eif96gNosXOcfOc5jR06ay6w3fa0aLOEEVqu45FDPVrtur8?=
 =?us-ascii?Q?9ItyFHf2dXV7kpfG7PBzhot33spVlp156sdDOaOORTv9QjPtp9A7j/t6IepB?=
 =?us-ascii?Q?AgQjzghMdj6ma/b/Hj1E1ovNrmBr/oNpwwyA22akxe8j9n5hkb+26I+d1rCF?=
 =?us-ascii?Q?kf9pFGqsBfYSzJB1lvp4tmodIqTH9fcHJiNaAlZn1tf49j63+3M9bj6pwBfN?=
 =?us-ascii?Q?mnVaMDGAy+H75Vd6oK9DQ8gEoaCUgHo0Zze+jK1D1v4MHXNK1FDePRmvRw0j?=
 =?us-ascii?Q?CTD3stz84/BZe/quPtGLj98+3uhCtpQ/XCNPa7Hu0cKahQ9H41OeGdMEOojq?=
 =?us-ascii?Q?l4jSC18eX8qOh43rPl5KMeFaLwTlMfd3/Pm3a9NRpshGbJ1gC/0sfPK34a4u?=
 =?us-ascii?Q?xLZh9dkbY6b4UgRsZl6XgBsOcbuEbbdKp4kqdZkC3TIt4l76hDrTz+CVy8/C?=
 =?us-ascii?Q?F4/dLA+bMmoI+cvTydAMLJcJIo/G4XIFet7CG72X7z/nxVJycxpaTOLAwUNR?=
 =?us-ascii?Q?Owd1Bq91iMKKl3wZpf9JJPMBYekdxGDFro0h4iPEk5vqP9zrupAXviyrjh0/?=
 =?us-ascii?Q?g4yZCW80233D6UWoiooBbCihcrErwzFH6QSTJAtRcPqVe1LUp6ZVBuOoY9Hm?=
 =?us-ascii?Q?0Me189jloo1JmDhLUzOkaNkk3aJ6Vnf4cKcf4/0DQU5v3tL1Gj9w+MV1vmGe?=
 =?us-ascii?Q?+hjMSJsTQ1HgdBT3OpQ0K2WX6HYcPQ3u8f9qih9hf1nJEBHFvFRCwzIS0kOY?=
 =?us-ascii?Q?j3tZpy0QPUOPPxpQ/2/+v5602JtXClvP17Zf/VdRpz/iSAS7Ac1XW35KIVn/?=
 =?us-ascii?Q?k/i1ZuzCNij34hvFaGbwnKQzr6IJzWwtQ/7wXZGpiemEVvhbF9W0xFFKEcAO?=
 =?us-ascii?Q?NqPRhl92t+ubtX64SuAM/0wSFce6BjYuheLIoPIFZXIZVOB8iFQi1k+9TdJa?=
 =?us-ascii?Q?BqBhHgnVtyq9OAhJwIUBhax2MyNA7bFhiIXYZgRNbRXUiun0hQ//D/xNMmMr?=
 =?us-ascii?Q?yZDQJF2uVwl6YzTZbzSnzvjIomyczGdPSrZOsPAwAcL1HEGfskbG/MWEwyE1?=
 =?us-ascii?Q?U6U0Z+gj9W3YpTJo5IrCqmgu2elZ3A9jEDdjLfdRDxTe6H/ZW1AFr25pdwUM?=
 =?us-ascii?Q?RktTQEL+KgJoGQyHYqSa8h0j343nUFfJz9rjKqGav01F8fM86WMtLGwS7XLN?=
 =?us-ascii?Q?bG6cS6WVJLkkbzNcJZX4OGKCG8FaSUrpFrT/DrUnmXsTtS8hSXNK9hTqjJim?=
 =?us-ascii?Q?3DZYheOK5iD4uwrgl2RyBK+jH3H1Md4fjEZTAIGUiDwqsll2Qesk7h50+mFW?=
 =?us-ascii?Q?ItXID8WaxUNxvOHpjgviDys4DeHMAumZfVthiXuYvmHCJrsza/MCKdDPY7Vj?=
 =?us-ascii?Q?fpxF3X2L/eKWcCRrbzNk5bmGXpyNHEL/nI3ug2UFNZb8B7Doo7O++cQ9JY2z?=
 =?us-ascii?Q?LvNapdF3xXunyAoFwcNPdQV/H+f/2yn1UKU10Y1ykf8BZap16DaXZxpVeL51?=
 =?us-ascii?Q?g2Y2cP6WJBwgGL3b9Yw+7A360p/UHOntBqFReeOhJ7hlYmKEdbzs7c7rGnVt?=
 =?us-ascii?Q?nLL71sM78Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85832561-2645-4ee3-e6d8-08ded0d025a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:35:53.7542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8EqksdjWpJOsiw00qrCHUipKD+2cODJxWXjzEaCi1vJxCq9NLSsHOP8gxyJrmVuEbDiEsj6IRH/d9SZm/Cksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 9c06b25e63..c0436b4c04 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2546,10 +2546,58 @@ static bool vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
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
+    if (vdev->ats == ON_OFF_AUTO_AUTO && !ats_supported) {
+        warn_report("vfio-pci: host kernel reports ATS unsupported; "
+                    "ATS capability will be masked");
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
@@ -2635,7 +2683,19 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
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
@@ -2646,6 +2706,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
         error_report_err(err);
     }
 
+    if (ats_needed && !ats_cap_present) {
+        warn_report("vfio-pci: ats=on requested, but host device has no "
+                    "ATS extended capability");
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


