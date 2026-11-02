Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96C606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A7159ig0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNwX0-0004sj-LO; Mon, 02 Nov 2026 13:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwWz-0004sA-Fl; Mon, 02 Nov 2026 13:13:17 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xNwWx-0003Yr-LH; Mon, 02 Nov 2026 13:13:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+Ie+nYA61OndrrSlzRyqst7FW/PSdqxLBBcmfnIm0x0xIjsVPYmAPecvrJtkt39cMm70ZsgyE25S/CNQj2ubbMjF7MkT/Kf1SwtnWCgc47lZzWpPyOlRIy2mTpjEZuf6XbACmCXN62RDocfP7OZE3ocBBr5njR+hrgxojd7sQHvIM1Wb0zy+CTuahmlEZcESImhwV2jEW5+bd7p8W489XmFtfEU11JiIzud0llSaV5O8t5mfgbzckB4YAqDQ8veHMpwCVOhIod3d6DdyQG3OHExJ0tZEp7smslaEI7HgdrhSHKDPb6QKXIypaOyVf6bvdhCSynoTsicyCZMPf20sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeiQmhkMoH7ycEGOuCk2VLtswxGQw/HGPDstG3BE+Io=;
 b=dikNeV3BcfBd+3c63jhEh0wuP1M6j4yaFF89Yg+4hrrVFUYB87fJPXcbKXVTfvVn44KbYfKMuyxnO6xyh/oFQQQ+6jHvi54u7aYhw/dWsADGvJQS3vfw/InFevyynGd6yROHtafntS0jeoOFNKhwBcO1TAIrCvw7hzxZ10x33sXpM05RG9yriCxy0scbcAW9Mt58FB9xqONPTX5umd670ZJJdKW6tzo17/KvOOAJeP+jRYi1jWukM22lml+Ydm6YeqTfFfpbRuc6f0Zb22IqafV0IUG+z1Z2o+70s5futW5JVq901vR6I32Y1vpH2IwXgz4MnJsYgFdxrG+y570mBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeiQmhkMoH7ycEGOuCk2VLtswxGQw/HGPDstG3BE+Io=;
 b=A7159ig07Oj8ydrjNPvLuzq5nn87HxlVWMHtmi+JcWuTNo39+luj/wlEAEqoQklUnK3/ORqa29Dch7CIIVPMm9K1BX1+CgczbOMLjyfwfcnoRMsaAl4JO2ZluhhWB8Zsu9WzDvWo84Ty426ZtsURWbedXiALNn6XjPIvHJrtcLiKCG710l1Fww779oVJOMUflQkcRYPd3NvnfdaGrLzjVO8nL8mMkvFzHkVvacydKkzaOqpGM3+bm1WYntLz8TdLNv0N7VqMHLC0/c2SEa8jdbFyi3kZc+WQZ4bbqMfY61YnYrU4C6rjlwnqQGZ5UIoHEfz8ovjKexJITgLr8GPcrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by BL1PR12MB5993.namprd12.prod.outlook.com
 (2603:10b6:208:399::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 18:13:05 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 18:13:05 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, tdave@nvidia.com
Subject: [PATCH v2 4/5] hw/arm/virt: export fixed BAR metadata via fw_cfg
Date: Mon,  2 Nov 2026 12:12:40 -0600
Message-Id: <20261102181241.3077981-5-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102181241.3077981-1-tdave@nvidia.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:610:77::6) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7a9ece-4975-4c91-5557-08df390cefa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261009223027099003|261021121427099003|261022075727099003|261026121527099003|10067099003|22082099003|18002099003|261102123227099003|6133799003|261102130727099003;
X-Microsoft-Antispam-Message-Info: WV8iBx5IkuEB5Ml1dJK96U1IOHb2c6qN78TnBnBFb+ExLVRE3eLh5jIfeQbsBeHY4CdZO6qh8vhbq58ftxAoTODKqPeypUwDt242aOV5iS5tYCz5BSyzYKZ9+4QxuN2Z63eU4ll3LbByYpvlbJjW4wg5HNBQ92NegMaI5krJbtsYCOoLKOGa+C/VFdZ3o4LY2KBPlvW2DvomMgkdQkMgrKAky0x5WLVEGIjh048qxhrUG+AQZNwzsyv9wwXE66gPUaX2YAfSrljdh5uAl8Y8Isd18N+mQ59n6gMwKXlMscEVBuc9h9wgIz3TnXbYASvI0iMaBq13SAO14ZgFdaPqVRujvl6T1NtRzk9uzIQKyx44KAC7EiWOICmSLrjKdjxyTTdwr1m8oZmcdBvvzlVPvOHcpJRgvpCG+rtm8XHOPR6xeR6ktPeN6mhGq3JDdn8YiK7Vv1ZcM2rxBpoMBIMi9fzbaub3/pxsy1mcrEIq8DHDWW3RlHSq24bEY1zr9KUWUvHN+bgnevqXVMZHFtOMqF/ICRW2/WEN4H0Ebaeb6yQpUtsFDWgMvwsyX0t7pRewOOvH5EJ7iytGyDUNLguHoc3dwq0hzm4dAuNBQzvPCUHJDLMToQxUy/cYMKaf6pjTRBuEsJU6Jg4ECC+5jTJSDHtc7Xg5i0Do0UHAulvP6rU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022075727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sPPZLGNMwaCOUMYhXXmRGxeEpYU7dJHoPc6DebMbeALPoSe41EVwiSnctAmG?=
 =?us-ascii?Q?QWp/1IkU4olwwUtHeS4Rvy/BpeskzDTNUDwgW2icTJ6OazvZmVz1m4PzffXK?=
 =?us-ascii?Q?a4oT7AqBzpjF8/LNuP+e3g1XOFOukRRj58yL/UqF73EgJGUJolU7fC+c5cxR?=
 =?us-ascii?Q?lxZpuJp7PYsiiMKLHBk6ssVjLyXGXnrQmNs8a9qtJkEgzOBKkISooew7RDxz?=
 =?us-ascii?Q?nJ59pZoNDz2oT2j9Y9DCSZdki5a6VA3U5NM0ZGwTJ1zkNo8NHR/2OjgFDTWj?=
 =?us-ascii?Q?gNboWfoMqvClePUp8ANPNg4Yd/JenXtK5ZD1OGYSRxXXIztS3N/jNPo3VmMI?=
 =?us-ascii?Q?AT/Pj+m4PPGvPfkWrYrysQ0Y8Ja616m5mgLcCN9ft/CExG6OccZ484KcnIrC?=
 =?us-ascii?Q?sWxX4Il6Sgrce8nzD6e/Gug1rf47F7uYA7SzNZf4qX/1ChAJL2b3B0v83ovX?=
 =?us-ascii?Q?jINj3Dd/Bu3ZOcTsbrF7Cd8DXGMFgbsidIcI1r7wzBVbMNowYxaiuJIxNLRD?=
 =?us-ascii?Q?ov1vg6ff6vYvbiccqlE3aYRV9JjxcAAGUafa4jQSQ4DCecUTrH+AdQpYyAJG?=
 =?us-ascii?Q?HTZKohaZ69plIUgtnzIpvZLhcEGt+6xRmsQXR3TiSWffPVQa1+9XmQWcL9oo?=
 =?us-ascii?Q?agQYXv3gBAGIC7QEx5uVxgxV6ayEnWjYpF3oTa/qp2Rp3aofDeSXuh2yduCN?=
 =?us-ascii?Q?eyCNkrHO5zQLuGZEm6oTZ2zjzmyzkie8GjbpO6wPXvDTgDkDaQZMxpur/EmC?=
 =?us-ascii?Q?hl3T3XHj0GLFp9Jys1vKjwmNz++8R6lNVyCVwY9Ju+FTat01wFPSVnfAUya0?=
 =?us-ascii?Q?lcVgBpIlav+dV7y1DnfFfOSWQSBMBC08cjbJLir4afO5Oe1cWDrNk2n+0WeC?=
 =?us-ascii?Q?YNMayks6b5lMOcp/kfRT+OqneGak+GbUHnmL20QKQ878juhvrop6wR+Mopmk?=
 =?us-ascii?Q?/0MobkLExUaAFbK7YzT9UZm8/4Mpb6xqrMEXBkR5FnW5mze2x/OvPnVugvUt?=
 =?us-ascii?Q?UXORiUcjLGunSgECmY0bKgxB4CCE5DdQRuXqppSXCOm7iHET4OqeEMWORHC6?=
 =?us-ascii?Q?7Ujj/+gHhWHL+5n/4L0edsskKIO/TBIqbjPtCYE7FVJGDE1CqI8onJdT9GBK?=
 =?us-ascii?Q?aoM44SM9cvppQEaJibVy/xYSUjLS3Jt9yo0E8xc8gReiSRv80G4hqeWHil/Q?=
 =?us-ascii?Q?yFtvkdKn4+lUBO5rjIffyV3peq7DyjdgHn9o3PHydzfCdSFDxPjgQiGJ2yVF?=
 =?us-ascii?Q?k1f6AcccDn971rXbEoe92CPQ5s1JqO1nIjJ6ZSLZwjZtqs2420ANrXFHPLUa?=
 =?us-ascii?Q?pzIC60MKAQRGjDK7rMYIGcc2jz+VaIBn0ZiEXeXMLbkTO7EsOOpoSwV1huTz?=
 =?us-ascii?Q?bzlCWI7u0StVumYBDPdK5/JeFzSwCCKzItSzA9ZOVRa2qRW2B8D/Kx6XRyi8?=
 =?us-ascii?Q?FXg0Kwvj3GyeSablTuWP4Xkt1Wnm2QsROpbq52aPGmBefzk1rFYPtJpYpywV?=
 =?us-ascii?Q?rcghaXV7dQDb/KIXyVR6enxtHqdXptkOANIPmjdIr5YuTZ7YiIL6zEZTnoZb?=
 =?us-ascii?Q?cGCXZznp+L5E57geaJVoWmeIxjTgjMBn8AJBmbEDc8G0ukugmycwqfZX5Fio?=
 =?us-ascii?Q?lS/L5h3e8HexYp5oguu3etdI9W67tLGSIaI5kzNeCtZY0jDKU65aeFWkv4Jw?=
 =?us-ascii?Q?KOHBi2c3Zq6W3rs/+1qN10Knja7OQGyWuR01Eszk0rE7aoXJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7a9ece-4975-4c91-5557-08df390cefa1
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 18:13:03.3198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YQELaaWrj2n+8mg2ABgPcSzzUzCUOZsTyyXSALNEnBKgeJ+464xFBn1yfJN4+8r7WmGaJwu6AaIGSGGY9ESPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
Received-SPF: pass client-ip=2a01:111:f403:c10d::1;
 envelope-from=tdave@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export fixed BAR metadata through the "etc/fixed-bars" fw_cfg file
and set pci_fixed_bar_supported to allow the fixed-bar-N properties
on the virt machine.

Fixed BAR placement requires the guest to preserve the PCI resource
configuration established by firmware, preventing the fixed BAR
addresses from being reassigned during guest boot. ACPI provides
this through the PCI boot configuration preservation mechanism
(_DSM function 5).

Reject fixed BAR configuration if firmware is not loaded or ACPI
is disabled, since PCI boot configuration preservation cannot
otherwise be guaranteed.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3ab3ad8c3b..4bacb57770 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,6 +94,7 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "hw/pci/pci-fixed-bar.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -2435,6 +2436,23 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
+    if (fixed_bars_write_blob(vms->fw_cfg,
+                              vms->memmap[VIRT_PCIE_MMIO].base,
+                              vms->memmap[VIRT_PCIE_MMIO].size,
+                              vms->memmap[VIRT_HIGH_PCIE_MMIO].base,
+                              vms->highmem_mmio ?
+                              vms->memmap[VIRT_HIGH_PCIE_MMIO].size : 0,
+                              &error_fatal)) {
+        if (!(vms->bootinfo.firmware_loaded && virt_is_acpi_enabled(vms))) {
+            error_report("fixed-bar: fixed BAR placement requires firmware "
+                         "and ACPI to preserve the PCI boot configuration, "
+                         "otherwise these BAR assignments could be "
+                         "reassigned later with no protection");
+            exit(1);
+        }
+        vms->pci_preserve_config = true;
+    }
+
     if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
@@ -4192,6 +4210,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
+    mc->pci_fixed_bar_supported = true;
     mc->smp_props.clusters_supported = true;
 
     /* Supported caches */
-- 
2.34.1


