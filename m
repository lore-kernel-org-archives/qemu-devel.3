Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74CBCD8CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 17:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJbN8-0007Ge-Qx; Thu, 13 Nov 2025 12:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vJbN5-0007B4-1M; Thu, 13 Nov 2025 12:44:35 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vJbN2-0001H5-Tj; Thu, 13 Nov 2025 12:44:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TE7XuuGFgP+54FwjHwQ6QaHGPpLqrYER6gxaAGuWBQpkNsYyhsn0Ij8S/XwFbAgDK5y7RaFzr33LEdy5cRCM74C9Vbtviw8CXYTHUSVmpzJXVmPKEcLOBCUtGcAINYJIXDc7QM+u7J3qcVv+xrAB8CdAAHY0b2ZxaaLHz0WJrj0zD+5K/uncJirrKkPgnbahGbnKPDV/FYEXeJ/IJkyz2Pxe9P5vsyk8rwBnE5YcPQcAPXpd6tX995ZEV7cnitSZZLO6KXJc4xtt47fHNtqesGfxk8125qyDLiBKazT3yx+bb1BY1kKp5/SfStazuH4hZnENnaXyBpdjoE9+YJDqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdMaH6r1yWCp7czzP5OdlukJ55vq79dDze0d+Bcysj0=;
 b=D+31tkfkN2u0lv0Q5EdHm9E9x/wNhi0qRwSp9s2P7pEiha70kvDr/XOI1tnM0fSOWWSo56v65PUmdO1NTPZglzkvSjYKwa/e52hZ1M9e8Qof9NrCDygpk/quKTpvXrvoIE6B0fWUr3Jw1xMN+yuPC4hNBWDQLCGwXs2ZndcEHCWjnISK3fTfUrXMcg4wY/QAuzh0IRRJwO8o5XNPFh2SfHRyt6eBkMkvP0gWhV2/YAjIG8dT5/L1sxQNibLHC9TWjOLhni2bbBLooaOZSu1qiR/QEar/VSJvzs3aBAnJcLGghL3orwcND6nXAMuZQCgYMKzcnMr/9+gTvhQNG5eHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdMaH6r1yWCp7czzP5OdlukJ55vq79dDze0d+Bcysj0=;
 b=HguvGk8uskOCtAIIuQMgn7kiG8TaVD0wG4cdpaA20C0MBP4HCUdSoUqMyIpKXTOjsBaJOhsEdpYn9erOxVZvtxCbFmrsyPZnqLwetE/oQV6Ht1iGwU6P0AjplbQAMWp42M6C+gYgWlTjF3oD4x/cLQAlqxH0YBAVMaQYYgf63ihWHIPv/B07rxMBn6Z+wgNrDTsCYKmmj9FvGWZmbRyc9H+TPezwuBeuZeIV8yrMvlpzxPudE7t7//58j5egnvDDlA3kVxh8doKswDpTtNq3PtGDOe8OZdIi42hL/POCli+KTpVcwPvuf4rHAR9Xj34rNAgSlh32Y74lJbWD4Tg8NA==
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 17:44:24 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::9a) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 17:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 17:44:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 09:44:08 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 09:44:07 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 09:44:06 -0800
Date: Thu, 13 Nov 2025 09:44:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: Zhangfei Gao <zhangfei.gao@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, "Krishnakant
 Jaju" <kjaju@nvidia.com>
Subject: Re: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Message-ID: <aRYY5eBnlw46nt2f@Asurada-Nvidia>
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
 <20251105154657.37386-5-skolothumtho@nvidia.com>
 <CABQgh9HzB9yCD_rYjGFX5ZC7RX2e2iVu_FZPU2Vm-kuf3jfm+w@mail.gmail.com>
 <CH3PR12MB75481A1E302DD0C6F5FC195EABCDA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB75481A1E302DD0C6F5FC195EABCDA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8731279d-4c82-4ca2-e1e2-08de22dc48ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVg2dUNUZ3BvQW9lWXZ1d1dSdGtLWkJYWW5ZL3JocjlmS2FLTDF5eHd5Y2xF?=
 =?utf-8?B?QzZXSzBTbERlU0Nta2YrbG9YYUhWZWhIcllnbExpYlNSbURyZDhJaWFZQUdH?=
 =?utf-8?B?SnNTYVRlSiszM3ovdVpzR0NjeWlPeUJJeDRLd2tFWEg0ZjFyb2p2aU5RN0hy?=
 =?utf-8?B?ZFJ6ME51Y0pjOGxKWW5XcVdHTlNIUkhkbVl4RHd0THMxTFNWbWtscTI1WTli?=
 =?utf-8?B?dHo2cEJxN0N4VDNpQnU0ZnpmY0ZRNDltZkVITlN6dnlqaXc4Y0dTdjFBUmRv?=
 =?utf-8?B?WnpwRDQxenZrM1E4V0Y0N1ZxWjI1L0VrdU1PWWpZdk03UGpkeTZieFFMNXEz?=
 =?utf-8?B?ZjRLcllkTHVGYjcxSU5LcFNSOHV5bHg4TU53ZEplbU5EelRZTjlXQW9xWndy?=
 =?utf-8?B?c1RnaDgrTkpKdzhTdHJoV1UreVk3VmpoVktkSmptWTJ4eld4aHIzR2FHOVJ5?=
 =?utf-8?B?R1VJVC83ZkpDSEZiSElYS21xejM0cWZwci8xMGMrUGROaXdMRndvWld3V0lT?=
 =?utf-8?B?aW82Y2x1VG9tSUdYVGRGbmk3WkpLaUp4Mmtkdk0rUmlpSFkzUzN5QmVHZzB4?=
 =?utf-8?B?eng3eVpkL3VYalRtL3dPeDh1bW9JUW1mbnU2aWRCVXlRZkxZbGRGYTNwb1ZD?=
 =?utf-8?B?TzNMdEhuNlFseUVwdFUydW9aS1J1aElYQm56UjhQWGhRQ2pVajd1SnhkQTFS?=
 =?utf-8?B?Y0tBb0dqalI3TTExMDAyRnFTNlZ6dTJUWnkyak5JVXk5QnkyZHI0TDgydFg3?=
 =?utf-8?B?RmVYQjluTUo2V3UrR1FHVUY5MmtMOFVwdzdZMERxak5BUlZMVEFyQi9wS2U2?=
 =?utf-8?B?bGtZaWcra09SMGp0cUNWbkNDOVJPYi9URVNjeXdsV3J1M3M1OU1LdHhoU0d6?=
 =?utf-8?B?T2REY2M3VlRZSUVIS21uRyt6cnFzLzBRaitlZWxzT0lNQW01R2hIby9FTmpU?=
 =?utf-8?B?bFI1VWhkMmtqN05yeWxQYk40dlV6L2NCKzFDRzhLQkErTmZlQ3kwZGZhdWNl?=
 =?utf-8?B?VUlBdVhXcVkwUFBjL3JXRTBYSFJTMFBjZlZHQlZEZDBSUGdMNlg0Z3YvOEdJ?=
 =?utf-8?B?dElLRWY1WE53bG9tZCs1MDBUZmJSTTdFcWpyejhpUk1JanpuVkJHZXp1cGgv?=
 =?utf-8?B?MzBIbDZNNTRPRC8zZ1VweVpITEluSzdMa1pVcFNaaHNZWXBXajQ5ejQ2OVJV?=
 =?utf-8?B?K1hYNG52NjVEeUZ4eDcwL0lDM3VLMjlvbUdLbHpzZy9EYndmYVl3ZE92RkN5?=
 =?utf-8?B?eUlJdWdhOGRQWWVQZ2k3NktBS2ZRZkFJZGZHNkxPTjJZQktLS3VUNHh6Rk11?=
 =?utf-8?B?dmxBeDh1QVlSblpWNzJsZm1iRWNwRFQ2alUybzMxVU1rR25pRWZoQ1RiUDdK?=
 =?utf-8?B?Q1FYUlV2dkQwNFVQRU9sUlVVdFFkY1FGcU5UTjJ4Z2d4SXNYSFl0UlVRdkpm?=
 =?utf-8?B?dWF6K0Nxb2hrRmFnTXVuNHlGak1UZVF1eERrZ3RLR0ExZ2xPUWM5V1MraFZQ?=
 =?utf-8?B?RTE0RDROdUttcFBpQWd5NTQzRUUrYzN2WmMrRFBjQTYvTWlNdm00RlE2Rllq?=
 =?utf-8?B?YjBPVXRvSHNydXMyTDkwb0gxVnhtNXR6R3hpYytlOXZlTFhVNzlGaGtGTHBV?=
 =?utf-8?B?QVhpQUZsVUJkVCtDOHREWFpiUnkybzE1K05CVVBjOVVnRUlscDdWcXBicks3?=
 =?utf-8?B?QktTR2hIa0M1NU9RWFhsQWxwc3g2aHlaUDAzZEE4UmV4TnZWcElIUDdBWUY3?=
 =?utf-8?B?UTFvMUpLczNYUTZQa1JaRjIwR3ZHZ2sydkVqQ3dJM3RqU1dmbGsrcWgyenYv?=
 =?utf-8?B?YXlLMmppNTI5djNLWG1EOHFnRlR3ZThBTFBhcVpBWmFIZDR6RjU0RjREZDg3?=
 =?utf-8?B?SW9sRVd0NEpkenNmTytnaUVvL1l2SGNreTQvK2pOSkRRNHF5SXl3UGkxckI1?=
 =?utf-8?B?dDI1VXRUanJlNmhTdHNMNTRMU21wVG9iOTlvZ1U2Z2xiRGNvbCtYN0M0OEdZ?=
 =?utf-8?B?UlNQNEFOMU1xWkNCblFFV05kOG5JZmhXWVVYNmJ2N25tNWc5b1prQ1dNT1VD?=
 =?utf-8?B?aU40UWxGcXBpc3F6Z3ZpUS9ZSEphZFVJNDBzK1c0cmtwK3hFZ3VPRGpXNDlj?=
 =?utf-8?Q?Go0g=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:44:24.3140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8731279d-4c82-4ca2-e1e2-08de22dc48ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nicolinc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 13, 2025 at 05:07:50AM -0800, Shameer Kolothum wrote:
> > On Wed, 5 Nov 2025 at 23:49, Shameer Kolothum
> > <skolothumtho@nvidia.com> wrote:
> > >
> > > Install an event handler on the vEVENTQ fd to read and propagate host
> > > generated vIOMMU events to the guest.
> > >
> > > The handler runs in QEMU’s main loop, using a non-blocking fd registered
> > > via qemu_set_fd_handler().
> > >
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > 
> > Still don't understand how to use this vevent.
> > Is it to replace the fault queue (IOMMU_FAULT_QUEUE_ALLOC)?
> 
> No. IIUC, IOMMU_FAULT_QUEUE_ALLOC is to handle I/O page faults
> for any HWPT capable of handling page faults/response. The QEMU
> SMMUv3 still don't support page fault handling.
> 
> The VEVENTQ, on the other hand, provides a way to report any
> other s1 events to Guest.
> 
> See how events are reported in  arm_smmu_handle_event():
> 
> if (event->stall)
>     ret = iommu_report_device_fault(master->dev, &fault_evt); //Page faults
> else if (master->vmaster && !event->s2)
>     ret = arm_vmaster_report_event(master->vmaster, evt); //This series handles this case.
> else
>     ret = -EOPNOTSUPP; 

Yes. We can say that FAULT_QUEUE is exclusively for PRI while the
vEVENTQ is for other types of HW events (or IRQs) related to the
guest stage-1. They can be used together.

> > And only find read, no write, only receive events but no response
> > (from guest kernel)?
> 
> Yes. And I am not sure what the long term plan is. We can still use
> IOMMU_FAULT_QUEUE_ALLOC for page fault handling or extend this 
> VEVENTQ  to have write() support for responses
> 
> To me, from an implementation perspective, both this FAULT and
> VEVENTQ look almost similar.
> 
> @Nicolin, any idea what's plan for page fault handling?

No. I think PRI should be done via FAULT_QUEUE.

> > By the way, can we use vevent in user space application? not in qemu
> > environment.
> 
> I didn't get that. Qemu is userspace. Or you meant just to receive any events
> from host SMMUv3 in user spacel? 

If user space application follows the iommufd uAPI like QEMU does,
it can. I am not sure about the use case though.

Nicolin

