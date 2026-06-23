Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCCCCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc84E-00057T-Gz; Tue, 23 Jun 2026 16:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc84C-00056t-J3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:49:56 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wc84A-0006UQ-5O
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 16:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJBA+uR+b/U0lfXdXDiJIhBo0zTHYdFeTP6qCuYJh9Vl817dN6PfezL2XffnF881nKpzJypkZo5gvUoJQMfWdHPonAcROe/iElnq3CRw1Ok191+2xiBE174sJJfkliIx8SY05a5NCtDlI286UgzfnBo2iROZ+aIL2go23WZCqLVsMTWKZunF427rt0z/n6wuYWGqSHTr1ky9LHDkFSR6+BkM+kjwSjFeMAHGSp4iLyT9nF9brZ/c4kOfR1YwYb3f7KcRM2DeZW0prT6F1DrMdxbTRf3YrFPZqQ0pTVqeXeNwtiJqtn1gwkdrQbHP3f1KtmLvBD8HQCR5DO0Frg/b0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsW+C+d3VjxHPKKBB45H2zerwO1GO0oco8TnEcRFEok=;
 b=JrV2qhGu+AgunUBeonNoF9ctJ8BGz8THJAjuxfBrX4Pek6xI7b3j/zUG9TkofLoZggdGvvXScmC1vt76KcKYIHQ1a7ZISNJCG0sfPX3Z7Tr41XIPO/TBPKbN22CJUe+c9YqazT2XP97ryq7a0YPjxmIGMxp3/7iajXY5jyGaUQ47LJvgp9Fu5Iqg/AU1VYaAMF8Ce4dvV4AXQi1hP0qbYUyfv6dOXUiUJPHkwO+R7liWb9Dol41Q5hZajaI9Pb4hPoY4b8XSkqL+oifyp/vekSCcnKtf7/DWlSUB1hRfdZm9jZDsCeSrOKdl6rT220JCvxU1QuR7KHgWmFVi3MlOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsW+C+d3VjxHPKKBB45H2zerwO1GO0oco8TnEcRFEok=;
 b=dqGc6z1po8eFwWCq+RR/j70Z5xmgMh7pusn6FeVIc6fLMEjYE/zBci2poMyAv7MmJBhJKbtH4+UfOzWjQhEj5ylYuCb0RuXOCrseW2IIp3wK1B3qACmH1JsXhS6eg13xkIKVs2z8QmOueZhLk/9jNhEZcwDkhlqrF0OPyCValp6fkKKvrcy51NJL9PFT8DIfgyb0RW7zowsVSk7e3DzQhcnV0/WNd02K6Tkxi1W0Q2mXeez6JcvtHzJ1lGQnM6g9Fl7rp27vZ30QrpCK3GxuxdN1rg8yDCw1DMDFizcKluu1AUMm7LyQxRw955c164Vvq1Z1hek0LUuyOYU9MRH9KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 20:49:47 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0159.012; Tue, 23 Jun 2026
 20:49:47 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 1/2] iommufd: Introduce handler for device ATS support
Date: Tue, 23 Jun 2026 13:49:41 -0700
Message-ID: <20260623204943.989903-2-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623204943.989903-1-nathanc@nvidia.com>
References: <20260623204943.989903-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 595814b3-f148-4eaf-c56a-08ded168f679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EdI31dOkbNPhsIZ6NJCg2dYmt0Ma8gxR6oR+xYGOFGbSazEpBzUBwyPc+1lQoQggpkMVEfLbHjcoEpWpBSZUwHu9gNwbVRyqfFcj3pUixANF2jXDP5AuLaqFmbIWYp+oOg0VRScEa2WhP/6MC2COQ4JrPSCVrJ6lS/G/F6cJJbLZmzZ7Tj/KJejxj1G8uyVJQQNWlkf/qN0m9UuYjCx8D/5kgGyodWO036NR5aiIthmjmOZonQNAFm4Uqv+kHiK5HdQ8kfNcZc9VNApNVJ3KRfYcK17y1JWRzROhWS7FtlsWCCVCZxuuMVtayE+Nz0uIZ5QpiqeuPOKga29E98O5ev22vgO1QATtHo+d7UGiMNJ1BVT7/WYCCWP3OSWUfsHmmxltXIddHgtUUJOKSpt1M5No2UghmFNcC4IY9wWogReJimrWrMj5foSlg2b9rGvT/NcmvcHhFotxqVLB8rZlbl1+/RmMsfZhGl7hahGx/ko7zRAUzZx++b/z1S7Yx1UgafJ2jD+Cm3kzDI3HpnC5YRd4cf9/zuc5LEHcXaZ/MZmxDG1Ecj7NAZH7+2YMF0Xvbt79uGkOIbGe/l0nFxncj8gTq7XshMxDd8n5Ux8NG6dD4C5qQxalpjIiiVaqLYKxTePFBAijYAQEtitm6WnXqEUr2X3wuLNAFedTSOSyA+s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjVlQitrV3pCQ2FnUUs1c291V0NkOXdaWEdiVmk1TnNGd0NFWUYvWTJrdEEz?=
 =?utf-8?B?QzZEL09QLytzbUlIeVFwWTkzYkVGblRERmRJMGVUOVRHSkNEblNuMytYV1M4?=
 =?utf-8?B?SmtOUng5UzhmcWR1cks4Zk8yWFh3ZHhDb1lKaE5RQUNmTUhrVlQ1em5iOHRa?=
 =?utf-8?B?UTJVdDlCWGFJWHNFbXFsQWJHdThuQVJnczNDVkJCSld1WGhDMWVudmQrNGU2?=
 =?utf-8?B?K0Y0N1dSL2VFTXZXWWVLMDlGN1MvNUR6c0J5L1FhR1NJaVYzN0lSNlpIQmt3?=
 =?utf-8?B?Q0t2aVFOS21GelRzazVNNFNlS0h1UWZrQXo3QTVEczVocy9XamNQK05FOEda?=
 =?utf-8?B?NW5KT2dPK21aRGFrOWtQUHJVZEFDd2xwWHZCKys2c0Y2TVQ1dUZEeG1VMWd6?=
 =?utf-8?B?Tk0yTU1QSVVoZ1BmUXllM0l1L0dOa2Rjb2ZrWG5oTWZ2REk2NWNWMGtVUStL?=
 =?utf-8?B?c1dURURLZmxUTGR5ZmVKN1VMbU9SYWRlamN6cEFwNi9xZlZML3FWZEdybXFv?=
 =?utf-8?B?L2czU1RkbUdrbXVPMCtmZWMxbFMyV2Y4OGNxaXo2bThZeWJXUnBpRUw4MDdO?=
 =?utf-8?B?V0MxcWh6WmJkTVhqZzZXZHRLUTY5alJJdGpldkRhN1J1b1hrd2ZqRXl3dGEv?=
 =?utf-8?B?QlhNRUVBSElpRXdNVEhrRGszZXdBSzJKVjcwQjA4QWhtd0xxYnozQ1dBTE94?=
 =?utf-8?B?bXZubEN1b3JkWlRSVGlIOXB6anp0YU12MHd2V0o3cTVUNDJONllyaGlMeVFs?=
 =?utf-8?B?YW9veHUzeHZ3NVMvbnlrdVVyMEhJaDdacVZ4Ymx5b3IxcXZVVTRuRjViRzJv?=
 =?utf-8?B?ZXBjcVlnbjVYN25mcEdSZ1Z1VWlYdW9oemdmMUpoYWhPV1pVV3VGRWU3dlJk?=
 =?utf-8?B?NTZJcGhnWjh4YmdJUE5VQ0s1Yi9aRGNkejF4QmwwK1BJR2lNcEtzZWtDZmNC?=
 =?utf-8?B?WWZyV25hTWo0K0EyL29lSG5oeEFWOFNpaDJrc1dMLzM1ZlBKeHhTYzl2N2Y1?=
 =?utf-8?B?U1AwQm1YSzBBUVEyWnhDRXFsUTZDajhTcGliK0JmMjg1UFh0a294aGpUNFdI?=
 =?utf-8?B?dzI0QmVtM0RmdHdub0pwR01LSHZvQjR1Q3JIemc5SmpsR3JIcFJOMDRwR3dY?=
 =?utf-8?B?TVN0b0lIbTd1d28xa05yVjVhK3F4dGFTSHd6c1FuVGpnbjhEamF0bVdUMjE5?=
 =?utf-8?B?SG85VmZrQk1yd1BNRGdQUmJRV2RKTUw0MVpPV05zZ0FUVFovUU02MlJlYUJ1?=
 =?utf-8?B?RmxGeTRPS1B0TlRXNys4ZWh4VE9HZU5jYXpXYXkzaFQwMmVaZXBoVDdJVXIr?=
 =?utf-8?B?eXZ6cklzZEwvdG02N3ozZmpkZVFuQTEwZG8zT0tob3B4MkgzTnlIMmZ2TUl2?=
 =?utf-8?B?M1paWHdPVlNXWlBrSjVsYUJnaG1BMG84SUYzTngvdWdlaHJSK2pDQjFvcENO?=
 =?utf-8?B?ZWRwSzVIT0pYZGhHd2lORFJYWTJiRDM2R0s3dFVuQ2VjMXJjcURqRFRoazV3?=
 =?utf-8?B?aDVGWnNXaGNnZjl2SE9NaUlEZ0dpMEJ2RGwwaWtaQXBPVnlXai9RWkxnZkxl?=
 =?utf-8?B?SUFYZUNuRU5UeFpxTWhISUxZSGdoZTdpb2ExL3h3dndURjRzWVVmTTA3eWFG?=
 =?utf-8?B?NlZDUEZocjFITHd3NGQ1YXRtVm04dWI0cEpyS2RPSW16UDAwY0FJUTIxVXZZ?=
 =?utf-8?B?ZkcyQ3RiZVhpT0xWanZJVHZ4MFNLcmR5c1Q5UmFmd29lZGxRaW9wLzZJT1pm?=
 =?utf-8?B?S2RobTM3R29rMHdEQ3lDaGIrTEdsK3NYNjh1ZWJTRlBUWE53bFFTZ1J0NnVP?=
 =?utf-8?B?Sk83c2tVa1ppVmxFaThSZzlSR1U0azJwa1Z6S2ZkTkdFMDhUZUtnZC96L2Nl?=
 =?utf-8?B?OXhtVE8zY2orRVMyM1hpQ2pSOWpOdkpGa0pObWxsemdpRUl1WjVBOFFXbjJG?=
 =?utf-8?B?SE5ZVHpVRXVzNnlFNkhnY2pNUTNCUTN4MmRHRS9TQkJqOEVzSXd3UEwwUHRF?=
 =?utf-8?B?TkVkNHpOYUJuRlFxQ2wyR0M5Wk5hN2d6ZUVDZG9qNE9KZnpEUnBYSVZpQzJW?=
 =?utf-8?B?WnRLalErbGRPUXVXVFU2WEhwVEorNXMyNGNjQ1RkamxvMmNzcnlLWjkrdTZo?=
 =?utf-8?B?djhNSUdwQ01OT3NCcXIybVhhdVhsT0RrK2YxdW10cmx3UWVKRW9uWWVVdWFr?=
 =?utf-8?B?Z1ptN0Z0NWxXQXhzNklmdGxpcVFKbmR1eVNZanR0cVVITjF1alVPSW5iYU90?=
 =?utf-8?B?Q3NHeWd4TmVVL0UrTDNQN2ZiZTVYdHFzNzdnODZLUU1BNURzWUdpV2VQRzd6?=
 =?utf-8?B?UFA0aTB6VDRlUFNJRUF6eEpsSncwandQVGxQRFRRbzI4NVA0MWFoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595814b3-f148-4eaf-c56a-08ded168f679
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:49:47.6145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nm1OzbDp8EFc7FLze/T6/r2n1jJO0vjeknZSSH0JH5I40MTh05xU84iVh0aXzjdVBr9+MCs5Q95M6TB6E5x63A==
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

Introduce a support_ats() handler that returns whether ATS is supported
for a device associated with a host IOMMU device, checking if the
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.

Implement this handler in a new function for iommufd.

Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 include/system/host_iommu_device.h | 9 +++++++++
 backends/iommufd.c                 | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index f000301583..2cb5365340 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -133,6 +133,15 @@ struct HostIOMMUDeviceClass {
      * Returns: true on success, false on failure.
      */
     bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo *pasid_info);
+    /**
+     *  @support_ats: Returns true if ATS can be used by the device,
+     *  false if the host IOMMU reports it is unavailable.
+     *
+     *  @hiod: handle to the host IOMMU device
+     *
+     *  Returns: true if ATS is supported, false otherwise
+     */
+    bool (*support_ats)(HostIOMMUDevice *hiod);
 };
 
 /*
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 09624cd652..4b40aaebe6 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -638,6 +638,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     }
 }
 
+static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
+}
+
 static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
                                         PasidInfo *pasid_info)
 {
@@ -660,6 +667,7 @@ static void hiod_iommufd_class_init(ObjectClass *oc, const void *data)
 
     hiodc->get_cap = hiod_iommufd_get_cap;
     hiodc->get_pasid_info = hiod_iommufd_get_pasid_info;
+    hiodc->support_ats = hiod_iommufd_support_ats;
 };
 
 static const TypeInfo types[] = {
-- 
2.43.0


