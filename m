Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFB3C624D7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1lJ5-0003m2-00; Wed, 02 Sep 2026 09:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x1lIz-0003ld-Le
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:47:11 -0400
Received: from mail-southcentralusazon11012021.outbound.protection.outlook.com
 ([40.93.195.21] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x1lIx-0001q0-B0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0n7o6pCuHnW3gkbXdNOt4H1BfWiiRhwQl7c0r9tjr2hJicilIkKAzdVxHJZN1l+A8jx4FxzIUpUotQyZ3TPFrhlgs12XePhiIs77M/vlredfwDu7+QCr6E9SH2uRYdiy+0Vr9DxVbsvJNrWCE7JISDIAsJOwn29HEpUhTZsmeOB52jEwkVDXgQq4M07CyKd23/A+qzkETwV+8MUhf1vNVyHZkFh2kcQ0ENSHxmcxmb9Zn141TH6iq0ziBbfhKGQFifNqaMiq3RHBy3f6YfT8dtqQaQcRVynTEI6Nm4A6C2Ni1GP5OoAjbxkFg6li+G0ZFOjB0UfeR/3Plz6M1zbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0K1KAez6D6pRdGqJL+834NU8po1tSn2OKo7wOt0doI=;
 b=n2ysrw0KKpFSmP4yDObO/VrlmgSdFISUt0rT8+gjLJ6nz1Ph5hu169k8VuAu/0MmcIMXFMbKr3RupHwVz7byq1GKvvQBAYMYWOF4i1CtMrvxYmBDc/26QTIVrJdQ293Q2yXdiGeIBb7Cx1msal3AVNX2s3KdxhupZhFtY/hV7pH3KMeTWIeCsLHnZVQy30rsYfBTB5YV7w5lxkuxVEuEBkucbOsVZY1LOVRY/ZcBPada5Vr9a3Ev7wcPkSAxoYVyRl3Dkst74sMENIByh7HMRQfMjRgJOtWdkV3OGlQ3J5nVX2dxoC9K/XMJ/b0F4Z29YAyZ4h4ng41nmmrgsqygBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0K1KAez6D6pRdGqJL+834NU8po1tSn2OKo7wOt0doI=;
 b=XIdmk2lgMR8LFy2coNdufnNNdaBpVimc+JokCYCRlVnNlggs5G2xN4mXz2r8zIe5bFw1vuG3qxMep1LWMpVF/ZW2aJ+aR3SQyUgqRq67uCrkmNlkunNQOKQgozITdq2XzPE2YOvt9C/L7D+zF0XaMsJBOdp69gR/JfXN4A+ccf4=
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:41:53 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::2f) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:41:53 +0000
Received: from [192.168.1.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:41:10 -0500
Message-ID: <c899544c-4617-40b7-be80-b232e19dce6d@amd.com>
Date: Wed, 2 Sep 2026 19:11:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Ani Sinha <anisinha@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
 <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
 <14e2f520-e5fb-48a8-9fb5-9b8c451d2aea@amd.com>
 <73ade3bf-9c80-4aa3-852a-a7643f184ca8@oracle.com>
 <d77edd98-7bdb-42e4-86cc-ea3e5e9454a6@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <d77edd98-7bdb-42e4-86cc-ea3e5e9454a6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0598e1-8a21-40b3-7a38-08df08f7f2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EY3XQCEHr0YiPS6jRIhgSYvaAI/shTyG6yDYhEYsxmDgFVHXz1f4Cbbwl9nBxd66RZYVCIfQhyxF95IWzR7Chfb5UkIFRf/BJy2Dh6lR5+Z+QJj1Yui/NsgUw4QEsWjmylYfDBwE5Mv85RCSEfI6odD2uq1AJ4XBSAKsHBpGfXtU+4yTU4eDWU6KJZ76Cj7LJguzrLEvMOKfb3D4kkPQ6h2UDFotHhRx1kozzOqdtUdIF95GfXsfr2tEQ3j1V5CPqbeqe5roMChZif0eanCqgt+aXhA+HxdQPHo9BKOjOLijiOdLoiSLETrHgb7dtnJq4R+wTICsS8c5clpo+h0rrqg0y95Gb7tOH+kWNLEjkf1dHRwIQUp3OjQSjV0FVFyfFAry9p66jDItG663JVUCZkuhBFyg0zBDzRnvFpulJOr8Pg3lYf26L6XQr16k44gq2lfnsY6j9egJzfn9tQcYIu+VeJEUDEwMdud0Jf1P6a1UIcgGPfP1KM45pxfjyZDidC0RtdxvBydh8pq67X1qe46NypxQWUoRkGbsgZQ5Tx2IV0vE4DQkpeUsgKvgZ4OZjZEyCE0dIQJewTKAos3JSuUL8+19w8QdxG14p/kK3Jc1JHF30ovaI2nFJRH4fhaMK6yLoW7DMF0wDCHJJmbrnQu7EnaQyPeL5oI33xXTObyHytw7DD2KXiZ8Kco5GTY4NqKBdhfNnYR75ZncmNqvQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7nnXL6fMVub6IPtYrD6yzte9WkTxqlO8OLgGd00y7eQST6FaMo4+mfjuKJYnN+J9A1aFVkwDfLHS5NRpURY0d2vBefYr4pcu+lSHzfXwr+pqiaq4u7rWbv/fmKlDfAPtRUQO1wpGawo/dS/PEFh13M/cul2Rk28mrEwNSeeLW2TtpoFwj8jQenzelAzXvu+Qks+KFROhU3o7nJ7q8L+gZHS1ayzx45vo6639kT9rfgxb/rFQYyGhKOOSOkIw/3SxJszBLKUhND8Et2jbqDQDMRod/6D3Kb1mt/aUd03rfNzQo5MyzJmU62B1IRwcb0lz71O9XkE3ZPoYUoj1aavq8W0AoEyc7mvsZ2auTQFpH9ZvpwFkywa9kPixEZ1Nu37eqqSYt3jW0LKwb2/CYZG6OOid7jwTHzv73hHH+R8+CiIYhv4A2cXDawbOSBGpLXa9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:41:53.0120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0598e1-8a21-40b3-7a38-08df08f7f2ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
Received-SPF: permerror client-ip=40.93.195.21; envelope-from=Sairaj.K@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On 8/31/2026 4:10 PM, Sairaj Kodilkar wrote:
> [  238.666837] pci 0000:02:00.0: EDR: Failed to install notify handler
> [  238.675198] BUG: unable to handle page fault for address: 0000000000080060
> [  238.677682] #PF: supervisor read access in kernel mode
> [  238.679330] #PF: error_code(0x0000) - not-present page
> [  238.680976] PGD 0 P4D 0
> [  238.681846] Oops: Oops: 0000 [#1] SMP NOPTI
> [  238.683206] CPU: 0 UID: 0 PID: 1436 Comm: tee Tainted: G        W           7.1.0-rc1-qemu #2 PREEMPT(lazy)
> [  238.686328] Tainted: [W]=WARN
> [  238.687326] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [  238.690864] RIP: 0010:amd_iommu_probe_device+0x53/0x470
> [  238.692598] Code: b0 0f 84 6d 01 00 00 31 f6 e8 e9 d2 ff ff 85 c0 0f 88 45 01 00 00 4c 89 e7 0f b7 d8 e8 96 d6 ff ff 48 85 c0 0f 84 31 01 00 00 <48> 8b 40 60 0f b7 40 1a 39 c3 0f 8f 21 01 00 00 4c 89 e7 e8 6
> [  238.697728] RSP: 0018:ffffd317452ab948 EFLAGS: 00010206
> [  238.698706] RAX: 0000000000080000 RBX: 0000000000000200 RCX: 0000000000000000
> [  238.700044] RDX: ffff8e374195f000 RSI: 0000000000000200 RDI: ffff8e376ff580d0
> [  238.701369] RBP: ffffd317452ab970 R08: 0000000000080000 R09: ffff8e375156e380
> [  238.702693] R10: ffff8e37707264b8 R11: ffffffffb0f28a20 R12: ffff8e376ff580d0
> [  238.704033] R13: ffff8e376ff580d0 R14: 00000000ffffffff R15: ffff8e3740d0f5d8
> [  238.705358] FS:  00007f2d02060540(0000) GS:ffff8e37ff749000(0000) knlGS:0000000000000000
> [  238.706843] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  238.707918] CR2: 0000000000080060 CR3: 0000000101d00004 CR4: 0000000000770ef0
> [  238.709285] PKRU: 55555554
> [  238.709828] Call Trace:
> [  238.710314]  <TASK>
> [  238.710742]  iommu_init_device+0xbf/0x330
> [  238.711518]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  238.712450]  iommu_probe_device+0x70/0xb0
> [  238.713214]  iommu_bus_notifier+0x2c/0x80
> [  238.713984]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  238.714889]  notifier_call_chain+0x66/0xf0
> [  238.715673]  blocking_notifier_call_chain+0x47/0x70
> [  238.716632]  bus_notify+0x3b/0x50
> [  238.717295]  device_add+0x631/0x870
> [  238.717982]  pci_device_add+0x303/0x720
> [  238.718735]  pci_scan_single_device+0xad/0xd0
> [  238.719571]  pci_scan_slot+0x97/0x230
> [  238.720279]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  238.721186]  pci_scan_child_bus_extend+0x3b/0x2f0
> [  238.722082]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  238.722987]  pci_scan_bridge_extend+0x447/0x4f0
> [  238.723847]  pci_scan_child_bus_extend+0x106/0x2f0
> [  238.724795]  pci_rescan_bus+0x1b/0x40
> [  238.725499]  dev_rescan_store+0x70/0x90
> [  238.726252]  dev_attr_store+0x1b/0x30
> [  238.726963]  sysfs_kf_write+0x76/0x90
> [  238.727677]  kernfs_fop_write_iter+0x145/0x1d0
> [  238.728530]  vfs_write+0x307/0x420
> [  238.729401]  ksys_write+0x6d/0xe0
> [  238.730223]  __x64_sys_write+0x1d/0x30
> [  238.731116]  x64_sys_call+0x1704/0x21c0
> [  238.732018]  do_syscall_64+0xa3/0x7c0
> [  238.732907]  ? irqentry_exit+0x42/0x5a0
> [  238.733815]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  238.734877]  ? do_syscall_64+0x58/0x7c0
> [  238.735768]  ? exc_page_fault+0x98/0x1c0
> [  238.736709]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  238.737825] RIP: 0033:0x7f2d01b10104
> [  238.738673] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 e1 08 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 5
> [  238.742405] RSP: 002b:00007ffd09b75168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [  238.743966] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f2d01b10104
> [  238.745478] RDX: 0000000000000002 RSI: 00007ffd09b75250 RDI: 0000000000000003
> [  238.746962] RBP: 00007ffd09b75250 R08: 0000000000000002 R09: 00007f2d02060540
> [  238.748466] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000555ec468b280
> [  238.749943] R13: 0000000000000002 R14: 00007f2d01de7760 R15: 0000000000000002
> [  238.751418]  </TASK>
> [  238.752010] Modules linked in:
> [  238.752772] CR2: 0000000000080060
> [  238.753571] ---[ end trace 0000000000000000 ]---
> [  238.754628] RIP: 0010:amd_iommu_probe_device+0x53/0x470
> [  238.755772] Code: b0 0f 84 6d 01 00 00 31 f6 e8 e9 d2 ff ff 85 c0 0f 88 45 01 00 00 4c 89 e7 0f b7 d8 e8 96 d6 ff ff 48 85 c0 0f 84 31 01 00 00 <48> 8b 40 60 0f b7 40 1a 39 c3 0f 8f 21 01 00 00 4c 89 e7 e8 6
> [  238.759542] RSP: 0018:ffffd317452ab948 EFLAGS: 00010206
> [  238.760706] RAX: 0000000000080000 RBX: 0000000000000200 RCX: 0000000000000000
> [  238.762210] RDX: ffff8e374195f000 RSI: 0000000000000200 RDI: ffff8e376ff580d0
> [  238.763708] RBP: ffffd317452ab970 R08: 0000000000080000 R09: ffff8e375156e380
> [  238.765248] R10: ffff8e37707264b8 R11: ffffffffb0f28a20 R12: ffff8e376ff580d0
> [  238.766761] R13: ffff8e376ff580d0 R14: 00000000ffffffff R15: ffff8e3740d0f5d8
> [  238.768279] FS:  00007f2d02060540(0000) GS:ffff8e37ff749000(0000) knlGS:0000000000000000
> [  238.769959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  238.771227] CR2: 0000000000080060 CR3: 0000000101d00004 CR4: 0000000000770ef0
> [  238.772767] PKRU: 55555554
> [  238.773488] note: tee[1436] exited with irqs disabled

Hi Alejandro,

Seems like upstream doesnt have this issue anymore
This patch fixed it: 07d0f496fe7ec5abe3bee7e38be709521567bb33

Thanks
Sairaj


