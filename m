Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9F606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=csuZ8nKS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVcGu-0005iR-Ur; Mon, 23 Nov 2026 17:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGH-0005XI-8O; Mon, 23 Nov 2026 17:11:45 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xVcGE-0007D7-Me; Mon, 23 Nov 2026 17:11:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFhQt4MQCwJu/dWSh7sU+/OpIg+8RkmxCFcSFToQXVnlk07+yETqq16oOV8waFtaQzYRcc2IdCdqxrqftkGwC8o/aw3KQkNm2Sj38xCDNVuYL1m/B7UFnDIIswcT9A/WcRr//MnMw8w467wWqN9Y2oiQDaVfM/EFo1iZbdbLavfJrr9tQYurbS4ZqZO0OBfrGu+sPp+P1y2TJRDjvENG5VcWuEMfWeEtD5IAvvgfgiAKpAPFfsfApklgQiydF7vzaoVb5exvmvA7qr30G3dEJcX/nAfZcOyuN34wjgiHjaQpRb9c+tb4/aroYKs+1LiukZLfqYAMyXln3MmtQ9bLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w7NEejVNWRkMgnBQEfmJFsGVz0NzWcNioe4DzXx/eg=;
 b=OtM7FUI30o0yW6ioCiPKlbG4MMKTW4AZvu9+XaZYmBHXeuhmwLsjT8osZVZsDXZrgwme17dwbzHK2nvuF/yDG+Lw+SkC1uzo838vzD1dn3SAZqZzK1nxl4zJl7ikMsniOzeD8S02rfziXabuUnfCBcNr02tSMu95VC9znyVeGCUQs8jb1UYtgOiG0y0NPtTAA53CiKQ3h6ruoso9Wf8wfv7GuvLBZROPs5FbujEJSLy28MHcrWe9GMEUuAV4rj+lk01VrC4kAplntVwhX6HDJ65wXH9pd0kCAPpFd2P8orGMOelKyAJNy4n4nc5kyv/XtPz9jNkOvIHjt/7hWyPwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w7NEejVNWRkMgnBQEfmJFsGVz0NzWcNioe4DzXx/eg=;
 b=csuZ8nKSc1Rtxl3OLM0OIXwkdJNT6yhgumXiMu0pvWW8l6fP1ZclwmI5iHDnrrw/FSPB95vXq7Z+deaFSv0uZxzkvQIWESAbhsUWWSFDIV97SqbLb9O6qOB2da+QyQrjTWBwQxSJ3TETDyp1Mt7hPOjMFVdQlNYs3u94dAylsIGUoaAfGB0aKRuiEAHmaF2BofOJ1VnRK3fYjUcvFYPvBYMQAwJCSk485GNAEl2W0l/WMlluANum+pkm9qJBOjf1Za4rWW4C1N0RU2X/avim5fkNoM0B0ILFwib7BJd4bZqfdJ98GLU99FLM57pHWDaahMfo7y29JyLWzVA8OdbtDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY5PR12MB6551.namprd12.prod.outlook.com
 (2603:10b6:930:41::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:11:25 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 22:11:25 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel@redhat.com, devel@edk2.groups.io, alwilliamson@nvidia.com,
 jgg@nvidia.com, skolothumtho@nvidia.com, ardb@kernel.org,
 kraxel@redhat.com, clg@redhat.com, tdave@nvidia.com
Subject: [PATCH v3 3/5] hw/pci: describe fixed BARs with an Enhanced
 Allocation capability
Date: Mon, 23 Nov 2026 16:11:03 -0600
Message-Id: <20261123221105.37029-4-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123221105.37029-1-tdave@nvidia.com>
References: <20261123221105.37029-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0153.namprd04.prod.outlook.com
 (2603:10b6:806:125::8) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 41995282-3cca-407d-13a6-08df49aeb70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261022113327099003|261026121527099003|261026140227099003|10067099003|11063799006|260925021911599003|261102123227099003|260925022911599003|261022105027099003|56012099006|260925021311599003|261028144727099003|261021123027099003|261022075727099003|261021121427099003|5023799004|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: utYCHJSD+WGZDg8sa68Z601h0upMUHw7E3NFyLfR+VxmDrfBcDLnxAIj1qJ3vYXAaJiYKREVOklaexXxbQ88VLBakcyB2FAxVMlRHELyD8dk8d1SLaVJuCxqTmXWMQqCZIZZ96vwdCpqHBmVJKwdhmUdlMhkAzpbWb6Oz0wqpxoQcUUb5cDztYvywvi8O/JznI7KxbOZLEzGZsD7aArONgInhRfQ65y75lCzvTmK2SkLrVIcTvSS72/nzPacMGxAYNJgHcz9ics9fwBqfV/OrAhuS34CVnglVIuC1T0ZrCMiSyWqWGfk+KkKjBXLGC4rfkefV1XfceKFhoJ3z2aoHKWxMxyRLgAs6+ixsp2KeCUrX0HPy9Z1yHeVDC0CVVXOQJhexwdchM8rNyBZX/VrH8/enPDvCom6mUcbQoh8BVrP73ZYFC7gJgHEqxSX9d868eI/itt31q2toNzHAMDasep9yEyWSDnJoDkUSUZkXoRmLwfrpTS/d/bMYLwDUyB8Y+hv0ayJox3ujZtILBrZlocYR4xDWAUvlbAEdOpLjfFbPmojH9XWwf5X+3v37UJCEAcBJ0dNOiDkzIyulbULuAsecEhnDbn/bNtYSr3HYfcXzvR+1EpeTjdjd4tRr0PJ4OKGR8s+7CuqD3cSbRYatnOSkLC6utItPz150widRBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261022113327099003)(261026121527099003)(261026140227099003)(10067099003)(11063799006)(260925021911599003)(261102123227099003)(260925022911599003)(261022105027099003)(56012099006)(260925021311599003)(261028144727099003)(261021123027099003)(261022075727099003)(261021121427099003)(5023799004)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3grTmpUT2VxMDlnaVg4cGh2YlUwanpiYVZZUjNjY2JsQjQ2TDk0YXliQ0hL?=
 =?utf-8?B?ODZ4QXozdG5FamMyczVlaHJUbjhwSVZhUUlFU0xqVFJQcTVtYXREdGIvRlFx?=
 =?utf-8?B?VmlPM3RUWmNrMkpCVXlJVExBVkJIRE5ZTHdXYkEzcWRvQ0NBVmRYY3N2WlhK?=
 =?utf-8?B?aHpBZVA1REtIQytWRk5GQTh5Ykd4RjE0Q05JMjBlajVGY3ZSbW5HMk54c0Nq?=
 =?utf-8?B?c1VmOWpJc3cxT3hYTkJvYUlLOEw5WmhFNmRNM3pvY2puaWtRbEwvdUN0bVRG?=
 =?utf-8?B?QXlBOHJMMkxkWXpOWHl6L2E1QzJxMC9oT3piWWErNUgwNlJwUFlVT1hWWkth?=
 =?utf-8?B?QjZ3WmdQdUxBdUtKTnNjZ2EvdFo0UksxQU54QXBGOTF6NHpMWlhJSWpDY3hU?=
 =?utf-8?B?b0hpbjZ3ejVTWDM3ZER0aUhuWmQ2SHU3bmhTd242azVCL2VLenFSaEs3N1JB?=
 =?utf-8?B?ak52MEdxek84SkJpZ0RTVXpRSTZyWENuT1czVjRrdnl0aE9iaEZQSFFTamt3?=
 =?utf-8?B?UVRXSU1XZEhWc29hSnNra2E0b0ZPS1RGemowb05pRXZpbHdSV1BUcEs5bDlh?=
 =?utf-8?B?dGRrdmwvVzNKMndPTmY4VGdhTnl4MzNuZEZmNnN0alg0akw4UlVYelBFTXJq?=
 =?utf-8?B?Nm03Nlo0Qk94OHR5ekx3SUR3bkJZVzg4dUlpb1VnUy9STnpVZDgzTExIN1Nt?=
 =?utf-8?B?d0RNSi83eitQMTF1N1FBa3lwRTFLVVhzNWtDY2pPeXgvaEJUdDY2TTZDMHE5?=
 =?utf-8?B?S1FVL25tMS80VEZFbDBobnF2OFFqQ1cycEJweUtucjlYNU93Nm1OL3lnQlpQ?=
 =?utf-8?B?c1E0dW9ZQnRGdmN6R2o2UU5PNnNvaVoxN1hIbm81Q0k1ZUFWMEI5TTZPTTFY?=
 =?utf-8?B?UFhhdWJubzdSeGlZeWFPNmgzSnVaYXJBQ1dHVkhBcUxFOWhJVmxxaEdUbW1h?=
 =?utf-8?B?aStJd3F5bGlWQXNvRHc0emV1dWpZNkY5dTNsSXM0a0hsMXRGNFkzSnJOWkRs?=
 =?utf-8?B?ZGxVRUt4RWN1ckJxYlZ1dXczcHNYN2RvNWtheUVyckQya0FkN3MyNHdrNmI2?=
 =?utf-8?B?ZU9qNFJERWlVRUtLREIrL2dLUjg3cHE2M3VzRVRETHpVYitSVFdscnkzWE9N?=
 =?utf-8?B?eEJEKzI5cUk2eTU1UnJtZVcwMjB0WWxQaE0zeFJFbmxSR3E0N3MvS1VJYXZ1?=
 =?utf-8?B?UkFTcXorVGUySTNmU0RqNUR1TmFhbFpLOUp4MERmQWVVVkpWaG53VS84T2s3?=
 =?utf-8?B?d0RSQ0JRZUU3eTd2U0xwRXRrTmQzNlY4V1FYOGxmUG1DeW1Ic0MrZHV0YW8z?=
 =?utf-8?B?ZVM2cS96VXZyLzcvSlJ4SFpVWitSa0pkdTFVdjk1ZU1ySjJoNHlIbnltN3Iz?=
 =?utf-8?B?UU9GQWRNbW5OZEVWcEpOSVUxQXY1bFNZWU93N1RHVkQ4dUNKQmJ1WWtxUGpU?=
 =?utf-8?B?WFh1dUxnZXF0eFN2dzVxNE55K0FLODVUUnF4eTFzclVNaG1zdXhMQ1ZhOEJE?=
 =?utf-8?B?cUtYcGhQZ2xvdHQzOEUvUjRDT2lBMzV0bmh6d0g0VnRBUWVKRFB1ZXdmNmsw?=
 =?utf-8?B?UUVMcmdzMmU3a2VVNkRiTTJXQzJwMXQ4Mkl3ZFBRUUpwSWlJNWk4MWxMNmdF?=
 =?utf-8?B?MXdHemR0bml2SFlsUTJtZzd5WGNSQUVlZXlqb2tGMnZqN2NUd2thQkQrbU9z?=
 =?utf-8?B?S0lQWk0zclV2TkF5aVdGV0d4WWhUOU1VN1hFYWEweEd0bEZSdVN1OUJnZHZP?=
 =?utf-8?B?Z1YvcE1tOHE1OGVncUNEUE1OeDQ0MVkzL2pHbWlDcHAreVNBTHpqNitZQ2c1?=
 =?utf-8?B?bmxJM3lyWnBIOGE3TVp6aHBsd1ppTDV0Qlh5ZFVSK0cyMEE0YVpRQ210Zll0?=
 =?utf-8?B?T1h0U2Fwam1NbGNuck9jRkpkQ01rY2dPbDRrOWNkTWtsQmlIbzJIc2VRNkMz?=
 =?utf-8?B?WkUzZGZEM1B3TnJOZ2RDOFB0WmZZVjVLWnREbWdHM04rZHBRMlBIN3BwejBu?=
 =?utf-8?B?cTdWYmhPNEhtVkQ5azFCQ1FGNXdJNnRtNUwrYSt4UkkrZk4ya3ZRT3haTmZ3?=
 =?utf-8?B?c2JVelM0VXh5cnJVTFJyakJjbWcwQnh0cEJqWU94OG9aS041K0laTVZOQkR5?=
 =?utf-8?B?S0IyZFhZVjhEVEo5eEd2MlB0RUZPM1dwbFR3TllteEkwOVc1NUM4ekxLRXVN?=
 =?utf-8?B?SkdWc3RzNy9oSkRjTTNDQ2UzblhxNitqbXozS0RIclZtTi9IdDRFYjFSR0c3?=
 =?utf-8?B?SzZCRjhkVVl3REZTSmhDa0lZa05tTEhxK2N1Skd2dVFXZFMvdStsSU44Z3ZZ?=
 =?utf-8?Q?XoxXY5Z/ZyAcaRsDCl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41995282-3cca-407d-13a6-08df49aeb70c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:11:25.5156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq4yNVvcYaoKNdKqdHQPkCOlKxWRXWbP0HozrAVnjdc+prDmFK1wEY7fCVedI1EVqAc8IybJ4YJHbdgXM9WkVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
Received-SPF: pass client-ip=2a01:111:f403:c105::7;
 envelope-from=tdave@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Give a device that has fixed-bar-N properties an Enhanced Allocation
(EA) capability with one entry for each fixed memory BAR. The entry holds
the guest address and the size of the BAR. Firmware and the guest read the
address from the entry instead of assigning one, the BAR register of such
a BAR is hardwired to zero, and the BAR decodes at its EA base, so the
guest cannot move it.

vfio-pci adds the capability itself, after it has built the capability
chain of the host device, since the capability has to fit into it. vfio
gives each host capability all of the space up to the next one, so the
last capability owns the rest of the standard configuration space. If it
is a vendor-specific capability, its length is known and the unused tail
is given back for the EA capability.

Add fixed_bars_check(), which validates the fixed-bar-N configuration of
all devices against the PCIe MMIO apertures of a machine, for the machine
to call once its devices are realized.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/pci/pci-fixed-bar-validate.c |  29 ++++++
 hw/pci/pci.c                    | 150 +++++++++++++++++++++++++++++++-
 hw/vfio/pci.c                   |  58 +++++++++++-
 include/hw/pci/pci-fixed-bar.h  |  28 ++++++
 include/hw/pci/pci.h            |   2 +
 5 files changed, 263 insertions(+), 4 deletions(-)
 create mode 100644 include/hw/pci/pci-fixed-bar.h

diff --git a/hw/pci/pci-fixed-bar-validate.c b/hw/pci/pci-fixed-bar-validate.c
index 774f363572..c4026c7c1a 100644
--- a/hw/pci/pci-fixed-bar-validate.c
+++ b/hw/pci/pci-fixed-bar-validate.c
@@ -17,6 +17,7 @@
 #include "qemu/units.h"
 #include "pci-internal.h"
 #include "pci-fixed-bar-validate.h"
+#include "hw/pci/pci-fixed-bar.h"
 
 /*
  * Claimed BAR ranges — detect inter-device and inter-hierarchy overlaps
@@ -374,3 +375,31 @@ bool fixed_bars_validate(FixedBarsInfo *info, Error **errp)
     scan_all_host_bridges(info, errp);
     return !*errp;
 }
+
+bool fixed_bars_check(uint64_t mmio32_base, uint64_t mmio32_size,
+                      uint64_t mmio64_base, uint64_t mmio64_size,
+                      Error **errp)
+{
+    FixedBarsInfo info;
+
+    if (!mmio32_size) {
+        error_setg(errp, "fixed-bar: zero-size 32-bit PCIe MMIO aperture");
+        return false;
+    }
+    if (mmio32_size - 1 > UINT64_MAX - mmio32_base ||
+        (mmio64_size && mmio64_size - 1 > UINT64_MAX - mmio64_base)) {
+        error_setg(errp, "fixed-bar: PCIe MMIO aperture base+size overflows "
+                   "(32-bit base=0x%"PRIx64" size=0x%"PRIx64", "
+                   "64-bit base=0x%"PRIx64" size=0x%"PRIx64")",
+                   mmio32_base, mmio32_size, mmio64_base, mmio64_size);
+        return false;
+    }
+
+    info.mmio32_base = mmio32_base;
+    info.mmio32_limit = mmio32_base + mmio32_size - 1;
+    /* An absent 64-bit aperture is an empty window, no BAR fits in it. */
+    info.mmio64_base = mmio64_size ? mmio64_base : 1;
+    info.mmio64_limit = mmio64_size ? mmio64_base + mmio64_size - 1 : 0;
+
+    return fixed_bars_validate(&info, errp) && info.any_fixed;
+}
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8e6a3778ec..e19dce2b53 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -242,7 +242,7 @@ static void pci_bus_unrealize(BusState *qbus)
     vmstate_unregister(NULL, &vmstate_pcibus, bus);
 }
 
-static bool pci_dev_has_fixed_bar(PCIDevice *pci_dev)
+bool pci_dev_has_fixed_bar(PCIDevice *pci_dev)
 {
     int i;
 
@@ -294,6 +294,133 @@ static void pci_check_fixed_bars(PCIDevice *pci_dev, Error **errp)
     }
 }
 
+static uint8_t pci_find_space(PCIDevice *pdev, uint8_t size);
+
+/* Place @val in the bit field of an EA dword selected by @mask. */
+static uint32_t pci_ea_field(uint32_t mask, uint32_t val)
+{
+    return (val << ctz32(mask)) & mask;
+}
+
+/*
+ * The upper halves of Base and MaxOffset of a 64-bit EA entry follow
+ * MaxOffset, pci_regs.h has no definitions for them.
+ */
+#define PCI_EA_BASE_UPPER        (PCI_EA_MAX_OFFSET + sizeof(uint32_t))
+#define PCI_EA_MAX_OFFSET_UPPER  (PCI_EA_BASE_UPPER + sizeof(uint32_t))
+
+/*
+ * Dwords in an EA entry, which ends with MaxOffset, or with the upper half
+ * of MaxOffset for a 64-bit BAR.
+ */
+static unsigned pci_ea_entry_dwords(bool is64)
+{
+    return ((is64 ? PCI_EA_MAX_OFFSET_UPPER : PCI_EA_MAX_OFFSET) +
+            sizeof(uint32_t)) / sizeof(uint32_t);
+}
+
+/*
+ * Describe the fixed-bar-N addresses of a device with an Enhanced Allocation
+ * (EA) capability. Firmware and the guest read the address of each fixed BAR
+ * from the capability instead of assigning one, and the BAR register of such
+ * a BAR is hardwired to zero.
+ *
+ * Returns the offset of the capability, 0 if the device has no fixed BAR to
+ * describe, or -1 on error.
+ */
+int pci_add_fixed_bar_ea_cap(PCIDevice *d, uint8_t *cap_size, Error **errp)
+{
+    int i, n = 0, pos;
+    unsigned total = PCI_EA_FIRST_ENT;
+    uint8_t size, *p;
+
+    /*
+     * A BAR that does not exist or is not a memory BAR is reported by
+     * pci_check_fixed_bars(), skip it here.
+     */
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        if (d->fixed_bar_addr[i] != PCI_BAR_UNMAPPED &&
+            d->io_regions[i].size &&
+            !(d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            n++;
+            total += pci_ea_entry_dwords(d->io_regions[i].type &
+                                         PCI_BASE_ADDRESS_MEM_TYPE_64) *
+                     sizeof(uint32_t);
+        }
+    }
+    if (!n) {
+        return 0;
+    }
+
+    size = total;
+    pos = pci_find_space(d, size);
+    if (!pos) {
+        error_setg(errp, "fixed-bar: no room in the configuration space of "
+                   "%s for an Enhanced Allocation capability", d->name);
+        return -1;
+    }
+    pos = pci_add_capability(d, PCI_CAP_ID_EA, pos, size, errp);
+    if (pos < 0) {
+        return -1;
+    }
+
+    pci_set_word(d->config + pos + PCI_EA_NUM_ENT, n);
+    p = d->config + pos + PCI_EA_FIRST_ENT;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        PCIIORegion *r = &d->io_regions[i];
+        uint64_t base, max;
+        uint32_t hdr;
+        bool is64 = r->type & PCI_BASE_ADDRESS_MEM_TYPE_64;
+
+        if (d->fixed_bar_addr[i] == PCI_BAR_UNMAPPED || !r->size ||
+            (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
+            continue;
+        }
+
+        base = d->fixed_bar_addr[i];
+        max = r->size - 1;
+        /*
+         * Entry header: BEI = BAR number, primary properties = memory
+         * (prefetchable or not), secondary properties unused, enabled.
+         * A 64-bit BAR has an entry of four dwords after the header, Base and
+         * MaxOffset each with an upper dword. A 32-bit BAR has two dwords.
+         * Bit 1 of the low dword of Base and MaxOffset marks a 64-bit field,
+         * so it is set only for a 64-bit BAR. The entry size field is the
+         * number of dwords after the header.
+         */
+        hdr = pci_ea_field(PCI_EA_ES, pci_ea_entry_dwords(is64) - 1) |
+              pci_ea_field(PCI_EA_BEI, PCI_EA_BEI_BAR0 + i) |
+              pci_ea_field(PCI_EA_PP, r->type & PCI_BASE_ADDRESS_MEM_PREFETCH ?
+                           PCI_EA_P_MEM_PREFETCH : PCI_EA_P_MEM) |
+              pci_ea_field(PCI_EA_SP, PCI_EA_P_UNAVAILABLE) |
+              PCI_EA_ENABLE;
+        pci_set_long(p, hdr);
+        pci_set_long(p + PCI_EA_BASE,
+                     (base & PCI_EA_FIELD_MASK) | (is64 ? PCI_EA_IS_64 : 0));
+        pci_set_long(p + PCI_EA_MAX_OFFSET,
+                     (max & PCI_EA_FIELD_MASK) | (is64 ? PCI_EA_IS_64 : 0));
+        if (is64) {
+            pci_set_long(p + PCI_EA_BASE_UPPER, base >> 32);
+            pci_set_long(p + PCI_EA_MAX_OFFSET_UPPER, max >> 32);
+        }
+        p += pci_ea_entry_dwords(is64) * sizeof(uint32_t);
+
+        /* The BAR register is hardwired to zero for an EA BAR. */
+        pci_set_long(d->config + pci_bar(d, i), 0);
+        pci_set_long(d->wmask + pci_bar(d, i), 0);
+        if (is64) {
+            pci_set_long(d->config + pci_bar(d, i + 1), 0);
+            pci_set_long(d->wmask + pci_bar(d, i + 1), 0);
+        }
+    }
+
+    if (cap_size) {
+        *cap_size = size;
+    }
+    return pos;
+}
+
 static int pcibus_num(PCIBus *bus)
 {
     if (pci_bus_is_root(bus)) {
@@ -616,6 +743,7 @@ static uint8_t pci_pm_update(PCIDevice *d, uint32_t addr, int l, uint8_t old)
 
 static void pci_reset_regions(PCIDevice *dev)
 {
+    uint8_t type;
     int r;
     if (pci_is_vf(dev)) {
         return;
@@ -627,11 +755,15 @@ static void pci_reset_regions(PCIDevice *dev)
             continue;
         }
 
+        /* A fixed BAR is described by EA, all bits of its BAR are 0. */
+        type = (r < PCI_ROM_SLOT &&
+                dev->fixed_bar_addr[r] != PCI_BAR_UNMAPPED) ? 0 : region->type;
+
         if (!(region->type & PCI_BASE_ADDRESS_SPACE_IO) &&
             region->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-            pci_set_quad(dev->config + pci_bar(dev, r), region->type);
+            pci_set_quad(dev->config + pci_bar(dev, r), type);
         } else {
-            pci_set_long(dev->config + pci_bar(dev, r), region->type);
+            pci_set_long(dev->config + pci_bar(dev, r), type);
         }
     }
 }
@@ -1776,6 +1908,10 @@ pcibus_t pci_bar_address(PCIDevice *d,
     if (!(cmd & PCI_COMMAND_MEMORY)) {
         return PCI_BAR_UNMAPPED;
     }
+    if (reg < PCI_ROM_SLOT && d->fixed_bar_addr[reg] != PCI_BAR_UNMAPPED) {
+        /* A fixed BAR decodes at its EA base, not at the BAR register. */
+        return d->fixed_bar_addr[reg];
+    }
     new_addr = pci_config_get_bar_addr(d, reg, type, size);
     /* the ROM slot has a specific enable bit */
     if (reg == PCI_ROM_SLOT && !(new_addr & PCI_ROM_ADDRESS_ENABLE)) {
@@ -2479,6 +2615,14 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
+    /* vfio-pci adds the EA capability itself, to fit its capability chain */
+    if (!pci_find_capability(pci_dev, PCI_CAP_ID_EA) &&
+        pci_add_fixed_bar_ea_cap(pci_dev, NULL, &local_err) < 0) {
+        error_propagate(errp, local_err);
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     pci_add_option_rom(pci_dev, is_default_rom, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9607866077..5497fb229e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2759,6 +2759,58 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev, bool ats_needed)
     g_free(config);
 }
 
+static bool vfio_add_fixed_bar_ea_cap(VFIOPCIDevice *vdev, Error **errp)
+{
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint8_t size = 0, last = 0, tmp;
+    int pos;
+
+    if (!pci_dev_has_fixed_bar(pdev)) {
+        return true;
+    }
+
+    /* The device already has an EA capability, we cannot add ours. */
+    if (pci_find_capability(pdev, PCI_CAP_ID_EA)) {
+        error_setg(errp, "%s already has an Enhanced Allocation capability, "
+                   "fixed-bar-N cannot be used", vdev->vbasedev.name);
+        return false;
+    }
+
+    /*
+     * vfio gives each capability all the space up to the next one, so the
+     * last capability owns the rest of the standard config space. If it is
+     * a vendor-specific capability its real length is known, give the
+     * unused tail back.
+     */
+    for (tmp = pdev->config[PCI_CAPABILITY_LIST]; tmp;
+         tmp = pdev->config[tmp + PCI_CAP_LIST_NEXT]) {
+        if (tmp > last) {
+            last = tmp;
+        }
+    }
+    if (last && pdev->config[last + PCI_CAP_LIST_ID] == PCI_CAP_ID_VNDR) {
+        uint8_t len = pdev->config[last + PCI_CAP_FLAGS];
+
+        /* The length comes from the host device, use it only if sane. */
+        if (len > PCI_CAP_FLAGS && last + len <= PCI_CONFIG_SPACE_SIZE) {
+            memset(pdev->used + last + len, 0,
+                   PCI_CONFIG_SPACE_SIZE - last - len);
+        }
+    }
+
+    pos = pci_add_fixed_bar_ea_cap(pdev, &size, errp);
+    if (pos < 0) {
+        return false;
+    }
+    if (pos) {
+        /* Emulate the whole capability, including its next pointer. */
+        memset(vdev->emulated_config_bits + pos, 0xff, size);
+        /* The new capability is the head of the chain, so is the list. */
+        vdev->emulated_config_bits[PCI_CAPABILITY_LIST] = 0xff;
+    }
+    return true;
+}
+
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
@@ -2766,13 +2818,17 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
-        return true; /* Nothing to add */
+        return vfio_add_fixed_bar_ea_cap(vdev, errp);
     }
 
     if (!vfio_add_std_cap(vdev, pdev->config[PCI_CAPABILITY_LIST], errp)) {
         return false;
     }
 
+    if (!vfio_add_fixed_bar_ea_cap(vdev, errp)) {
+        return false;
+    }
+
     if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, errp)) {
         return false;
     }
diff --git a/include/hw/pci/pci-fixed-bar.h b/include/hw/pci/pci-fixed-bar.h
new file mode 100644
index 0000000000..55441e329f
--- /dev/null
+++ b/include/hw/pci/pci-fixed-bar.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ * Check the fixed BAR configuration of a machine.
+ *
+ * Written by Tushar Dave
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCI_FIXED_BAR_H
+#define HW_PCI_FIXED_BAR_H
+
+#include "qapi/error.h"
+
+/**
+ * fixed_bars_check: validate the fixed-bar-N configuration of all devices
+ * @mmio32_base, @mmio32_size: the 32-bit PCIe MMIO aperture
+ * @mmio64_base, @mmio64_size: the 64-bit PCIe MMIO aperture, size 0 if absent
+ * @errp: set on a validation failure
+ *
+ * Returns true if at least one device has a fixed BAR and the configuration
+ * is valid, false if no device has one or on failure (@errp is set).
+ */
+bool fixed_bars_check(uint64_t mmio32_base, uint64_t mmio32_size,
+                      uint64_t mmio64_base, uint64_t mmio64_size,
+                      Error **errp);
+
+#endif /* HW_PCI_FIXED_BAR_H */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 359331102f..cf05f78abc 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -259,6 +259,8 @@ void pci_register_vga(PCIDevice *pci_dev, MemoryRegion *mem,
 void pci_unregister_vga(PCIDevice *pci_dev);
 pcibus_t pci_get_bar_addr(PCIDevice *pci_dev, int region_num);
 
+bool pci_dev_has_fixed_bar(PCIDevice *pci_dev);
+int pci_add_fixed_bar_ea_cap(PCIDevice *d, uint8_t *cap_size, Error **errp);
 int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
                        uint8_t offset, uint8_t size,
                        Error **errp);
-- 
2.34.1


