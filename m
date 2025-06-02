Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E3DC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyWf-0004YQ-8y; Mon, 02 Jun 2025 02:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uLy3n-0001qr-3v
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:50:21 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com
 ([40.107.93.72] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uLy3j-0007bG-JJ
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 01:50:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXVPFt+XZIFvR9+JSGF1WEWqWO6PkxwZsTJxVzPwcGHDMStdNKKpM9ljQNt2qYQH4T1VVCzJKCQBxrS/IXOm9N99T4bKBMZkIpHKSj6XcHWr9vbwHoXRRHRBbbbn+l8S/yuTj66uvZ574bFt58hdDpM5vdql4Gph4dhVo+2n2XUU/6myiIDLtk9Hk1AtXcdvIiCrfqQHvR1bk9dFDMAOoDcXOxDg4Ew71ydBDLSQ/l8cSnGvCj0Mxedpvc5QfTKNEPPTejEoxrK4YCVz4HKbqL+IQDetwwb2hUc09/9vz263rD5RIvtpG3NJf0RLKPmfl0oPJ+KQY9eTDFLDRuQ0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v8T7s56vLzPtHTezPawk4XG8PnEeN1F/4qRV4lPU/Q=;
 b=uqAFNQjsNiYVsi624K0GG3P0yZsqoDGttjv0PJjgJ4Z4VL+Qvy/jrZ+ul9FX8Qmo40GT6ORIw5qTMq/UDa0EpPuXvn3Or0s1Ln500EyqtSjP0Nhw7I86FSCpzMwLZSxllNqZQGDJTURbAjBvYyyO5O6ztXZU7xHIzlDLDABr1rU0iimIqAWLI1MpYOK5SEgTYQautrqbebybbUepCQvfUOyCeXZEhMpzY6Rt0lpDo8aZNyDpc/xJ2k2Y4YK8uZZdKiGq894pugmlVggHV5RQZzq23HxsO5sxMBcExOXTvb7kDm6ThPi3pmY789E9pEtj1rVkjHa4wSUOFfx+RE31gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v8T7s56vLzPtHTezPawk4XG8PnEeN1F/4qRV4lPU/Q=;
 b=NcOxqUrDaW95LJCyRhrjfhiib3PfDIFR3bBeC/yGI4we0ItqDrNdB/oLFLRG8W64RUlPJCsCvBETOeQNl+rDkAvdMYQV12WWJ/O1fuZeph2g9Q7tO5O8+dVV2R7xG55wgu9wPa3Tt+BQNsHh3rCBH4HJ9/j1M4/FQS8v8YLPpeI=
Received: from DS7PR06CA0048.namprd06.prod.outlook.com (2603:10b6:8:54::24) by
 IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Mon, 2 Jun 2025 04:50:03 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::c7) by DS7PR06CA0048.outlook.office365.com
 (2603:10b6:8:54::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 2 Jun 2025 04:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 04:50:03 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Jun
 2025 23:49:58 -0500
Message-ID: <50263023-40f5-40f1-9b1e-b044e1b58c35@amd.com>
Date: Mon, 2 Jun 2025 10:19:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <peterx@redhat.com>,
 <david@redhat.com>, <philmd@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250530074128-mutt-send-email-mst@kernel.org>
 <9942f812-496d-4f9e-ba92-abe6bd6ef9db@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <9942f812-496d-4f9e-ba92-abe6bd6ef9db@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a43faf6-4821-4b4b-ad1c-08dda190f04d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1JZL0o4N1o1T05iZEJxdEZWbCtvS0RFdm55LzhNZjk0ZWc4bHRJM3JqNFc1?=
 =?utf-8?B?QXhSNGI3MFBWOTVqRksrK3Urc213SStCZ0ZQRjd6S0x4UDgyOW9peEtKVWlz?=
 =?utf-8?B?YlVOK2V2ZDVTYXdyZW1RT1MxK1NjUXdsM1ZkUVJCS203SW5jVVEvSERMTWtm?=
 =?utf-8?B?aklyUVpEeGVYRVVQaEpsWCtrVFZkdEdCSEM3R0tMMmhOaWFmTFgxbFRZS245?=
 =?utf-8?B?UERzM25TTTlEY0NpdlJ2aDhTN0RxZFA2VDhENU9RNWFJek5zWjJVNnB6MDFH?=
 =?utf-8?B?bnZxZDJUYVpER3RDNSs1Nk1sZmt6TUNnZFVGM3pIWVBNdER5Rk04b2oxejJw?=
 =?utf-8?B?eW5WWit1a2RKRnJCcTRqVys3YjB0UG84eGVjRUxMSEQvS0t0RGxHMUh1V1FI?=
 =?utf-8?B?ME85d0p4RU1LcDZLMU5keXVlV2xjZDUxVW9NSlE5cGk4UVR0U3ltNFRLM0lU?=
 =?utf-8?B?eENEb1pYVEIrRElvOVZZZDllWTVXYmdna1N6NHdwTkNkVEVzREdNNGN4UG1l?=
 =?utf-8?B?cWVyR0EwM05CUzFjZFlKN1I4eW12T2V5enVJVGhTNStNcFAyM2xuS2lSRXZr?=
 =?utf-8?B?OTVYeGFSN0UwekNLanFzWVdNN3NlSytjV2dlQmhYbkRZL1hFdWh3em1SSG9n?=
 =?utf-8?B?RWE0eW9QZmhIdWFVZm5lUmhPUmUxUG1PZUlNSUhlRnBTMUxMV2ozZWFjd2JU?=
 =?utf-8?B?MXlaODNaL2J4SE1PZnFCdGhpS1NIYUxGdUVxNnc3b2RiSGthMzlCQ3IrYmVQ?=
 =?utf-8?B?emszeGlVSnZOWUpHU3YrR2tKWEpwdTg1d3VEM1dTMTlEU3R5UHAwMHRPMGk0?=
 =?utf-8?B?cC9mcFpVNUp4U0Eza2h5VjAzc1d0eUgveUVKUUM0N200VlB2ZmtiRVQ3ZGZR?=
 =?utf-8?B?VHBDcXRzTStNQ045VFJRSVdEZkNzUmc0d3R3OUJaN3VTMUhpZjg0VXZGckU1?=
 =?utf-8?B?WlFLYk1TbkNZWmdzOHU2YUFLTnN3cGtLUzF3TnBucmc3TzcxRVlLT2krcFV6?=
 =?utf-8?B?Ym5ramJUcWlPZXR2SFIwc3k5S3lQOWpHbHNoQ1hqMHQrUUNTU1ZOYXRSYWZl?=
 =?utf-8?B?cG94YXptaTA3c25KNUl0aHhCNnA1QXN0eGJjTUErNUN4aGMyUGVtV25FN3BP?=
 =?utf-8?B?UUpmMWUwMVNOTytLdGEreGQrRWdpcWlqdU9hRVhhZHhxRlBid1BmL2JHcjJK?=
 =?utf-8?B?Tm1GSEZpL3BOeWM4aTFEanpXcENFMys5czB6aU84aVg5N0RjcDg5UXpPN0Rz?=
 =?utf-8?B?NVd3cFc4aGN3WVlpZjZudzVhQU4zTEpTaFJqQlhCODJWbGxUdWpaM3g2V3Bz?=
 =?utf-8?B?R0JiNzRwT2FKWjhTSlFOQ09GOWU3cWVYdkI2eXNVTStuaE00OHRLemYzREFV?=
 =?utf-8?B?bzEyRElUN204T1pIU2xyL1VJMWVlWGRRWmZOeVAxeEc4dE9tMHg5MllZV3hE?=
 =?utf-8?B?ZmZCR0ZxWTQvWm96d2FMdXZ6WkMzc1lISDNWaGIweFM0eWNmR3BHSWVUY3lu?=
 =?utf-8?B?YUxRRDJJUHdQbUVxOXBsOXcrcGNXSXduZkZ0Wm10OHp3TUUyWkU2UkM5YUN3?=
 =?utf-8?B?eHZZUDBPRzJkM2Vub1ZkZFkzdmFwQ05yT0R6WGc2Q0ltVC82N2tyNlA5bWdO?=
 =?utf-8?B?Uk0zb1oydnF5cmJSQXpsWU1rSUZVWW5wOGU0ZG1EaVJnY1ZVYUUwaDFwUW4z?=
 =?utf-8?B?UkdwdVNMUXNSdzlwSjJZNGl4RTFkZWQrVDNuQzd0L1lmbnIybGZTdFJPYmJk?=
 =?utf-8?B?cTRuZ1dFK0ZmODM3L1BEZmRyWHY5bmNSVWt6TjR5dk1GQktxTmJoeFAzWmgw?=
 =?utf-8?B?bVdEc0hkU2JOY1VvWDlJUGdiYzliM0lnZmZBMk1za0szU3pzMFhZazZ2cEdE?=
 =?utf-8?B?eE9EZEI0eUdzNzRtY3ZNQnk3cytKcU5jSVVueFZvMGZpbEdTUk5XZVczWWVG?=
 =?utf-8?B?NnAxci9QTnRKUjBON3V4eHFXdll1V1ZZaENidi9uODR4MkJ0Tk9kTFBFdXB4?=
 =?utf-8?B?ejVZYzhsMCtMSkJoSS9TK3lvQXFNclFNUWZRYXhoNi8wOWRqZWNabDdYemdM?=
 =?utf-8?Q?ujBGSQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:50:03.4657 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a43faf6-4821-4b4b-ad1c-08dda190f04d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
Received-SPF: permerror client-ip=40.107.93.72;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> Sairaj: Are you passing a full NVME device to the guest (i.e. a PF)? I 
> ask because the BDF in '-device vfio-pci,host=0000:44:00.0' doesn't look 
> like a typical VF...
> 
Hey Alejandro,

I am passing full NVME device to the guest (not just VF).

Thanks
Sairaj


