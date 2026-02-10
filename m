Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236ECEB26EA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprQ8-0006Vc-AI; Tue, 10 Feb 2026 12:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vprQ6-0006VA-56; Tue, 10 Feb 2026 12:21:02 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vprQ1-0002cK-Rl; Tue, 10 Feb 2026 12:21:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tgqvx0nrJurUdHIZY93wcREUcn1DcNHFmaid0wael4NJhrDJ5nW1UbhFKAk/P0NEqqvmlRCeHkJAqHSWpEF+FK3Bu0tv4B88j6OZKBzljfCBSAO9x+GmMw/X1Kz44TjD4z9X2dRG+KGqcbRkgABmbktSHTiYnp3nDEiTp6mZVxJbeR9wTis48IhCikXeWKPFjd0w9PHOuW5n33ld1bI8qmWuZR9B4VIqcktb5hrnlZUAD8fjd5jh/f/p2Zs3mPgBCbByI+D2yndZeMJ/dwh5DeeZf8Yw6IdifIWIUH8F7JYKe4muBuHHHymdsBvDvjzg/eR/dPPxFQjl5KXMWXcX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unhlI6lK9+vvZBh/NC2DaEMnf7HHNLETOkXyk40lv28=;
 b=qNPzLffw35k84goYxy2KqXf+xy2q+2werrHv0kifH2iK/pIjrEHy1xlA2pWlI2UU+iOsMMTDEwxTq1ou5A3+khWfg4tzXNoi4xvAH9YrHA/qer4Kn5vByccd+gV4qn5YsEpQ3fZ4u3kBUP+MbY20gt/0IifcGANtCcxGzRaVGEgNfMDTiFAjNQB82iHHVhMoyHyiCnl/Fd+RzGXTXpLb52V9MIlKDLbydQNTRc9ZXe/GRU3E3WjU/30sI9Vd4lS1dbfNDLIEdchENkC1CdYVUAWZvtCebMtBHdIxaW4X0FW2QVOpHD3qpn73eXyaY776qFY0m5CzXXxpQI5Kma03MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unhlI6lK9+vvZBh/NC2DaEMnf7HHNLETOkXyk40lv28=;
 b=UXCNBvk/MJHQP7A6PTywsztk/fafptVOehw+PPNqZyVataO5oYMYxsOYjo6hz+ua5bCKYPkLQzIOzbBHt/nmoUdRov+9Ju4vnMpRQI8cE44+01rdckQ4JP9idC721OlUXoBssI0w3wiKyyJoDCAgwnye/zq8GNZRPvI4BE4/0pIGQ7nkf2bX/eblip4YYvUF9/W9UHapLOMLi94EMbUcC+RDAB9817DzizC6KUHeJGxbDn1A99GNFjhHq5eSKHQIDegn89Of26lvAZ97hnHvJNsqK0Uc8JLCe2iolxGiaYe4/NAunwvsFIrzCv8ZVKWrQrTLV5bgbPkIHEjeBWwgZw==
Received: from CY5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:930:1c::32)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 17:20:49 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::d0) by CY5PR10CA0018.outlook.office365.com
 (2603:10b6:930:1c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 17:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 17:20:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 09:20:18 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 09:20:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 09:20:16 -0800
Date: Tue, 10 Feb 2026 09:20:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Message-ID: <aYtozzSV4UYOjJcK@Asurada-Nvidia>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: bffd7d76-c3a4-44db-2bb6-08de68c8bc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPhXiXxCusiC+waKC4odxhxDB4WvZqBxdInpbYH+bmlKFD1+r2FilheDlApK?=
 =?us-ascii?Q?ABVLsp7McqjHMyL7kcJYIcGLOgfd1E4K9H41B6SLnH6TVWx1OJTMjD4xjWtc?=
 =?us-ascii?Q?cIwa+RLXyYtYWJaXH4Fs+SntR+S5eabaM3GI0WytjP7UoeeKSNM/WNsIkhl/?=
 =?us-ascii?Q?6Nci4vUbzMC9S2707xO6+a4PQHAs/7sqHR+6DF7S/iLpx2tuBrrjMi18n6vk?=
 =?us-ascii?Q?faxd1Sh7FoQg8LRMZui0JHLqOlIQzXu1xZL5/ujJ2X8hl7SCJJap2y5/zH97?=
 =?us-ascii?Q?DV+rmO79R7Auxlxx+GTQFU0NF6boG3QEwgQ+0THY2Qqnjch9mjO/ZRdvfLbR?=
 =?us-ascii?Q?55gjZt3e0WcsXr+Etn9ZYKDN2JHWiNKd+A3ERnS1eh0YYlzL612ftKdS8lKZ?=
 =?us-ascii?Q?0J6+UqtICvi5T/4LvMTUEIp2lxRKQtsp3WpcvYQ7qD17+Ub3GZcB72PD5R1c?=
 =?us-ascii?Q?DhijJ0cvoLVKlSQnnR4RpQP3R3QYRkKKgwx6OJAMiAPijQmEICa2qOZ3LJz+?=
 =?us-ascii?Q?wgiNkzPOKA8OI7DmyCcyWKtC8obEHJsEDLa4g5Z0edEPWLH+hi/InFRpEEGJ?=
 =?us-ascii?Q?7CZ4IoiQwW6JJVYZ6DE4q8dNGz8SeMb49iGNeovWBv0Rxihq+hAuRFmeQiik?=
 =?us-ascii?Q?VJG37HYvWH+qAgvdpih+zH18hjDRicrnbWuOaaBNDErqkURrYJE0mcIrW3Mf?=
 =?us-ascii?Q?4T0uEDG4UWepuuS7EqSZXeET7C55BTihSHtIOubjzjHe6UGeLFL2uDg95ac3?=
 =?us-ascii?Q?uXKbV2csWJ8QRtT8POypsizhoU8gFfL0q5iJGsMUit2gZ3eMbqYTOTAE/RLd?=
 =?us-ascii?Q?aqy0OZuw0JM40eizdGvWX8KTA4YohIgcVD0WU3L/y/G5iqiDuztNqT4tJEs7?=
 =?us-ascii?Q?nhnzjis+OUjdyaMVh4VNPG7eZDdzdpfmYauW/Hgxwu7GCoWXfEXpKNhNCP93?=
 =?us-ascii?Q?zPbSDscMvDadiLLX3Sks1b7Z0eUxH3UeiI7VKkzT/OO3dJpbnoA5tYdn9zdK?=
 =?us-ascii?Q?YiS0HdGop7gWL6kXqKwYrsQbM6c9FIggHUnjbRl8lmTXsqTRX448ZifCycr+?=
 =?us-ascii?Q?HKGIKiAUMCvPGuRYNNkMI4zIpjhsot1ROQNDEicjYoaqjXBJKvfqlcJ7m2d4?=
 =?us-ascii?Q?DC1ZdA1/1LXKKU4UIknCTfJMYpThLTjc/uRenK8XQNNG2ktj+czpSLhMy2bO?=
 =?us-ascii?Q?dI2jq9DPKe6NEckKCPWmcb7vJmWgSYB7KTmSWfEZradenSEPMnb5SUB6WMYS?=
 =?us-ascii?Q?TwB2R7D1sF1hkecH0J6dz4Bco5a8GV5BuzARt7BWLloKiLBFE5boqE6SjxSf?=
 =?us-ascii?Q?L5N+aoUqy2tLDQpH3Y3C/GqllRO6tjYaBpowy/a8GcZQGMf7xypc0sWbP61E?=
 =?us-ascii?Q?hxtkcSJZ6y0amfEFnevk7reydMl5ZHlysmyeeIhZ1131xlU/arcmOZCsQS9a?=
 =?us-ascii?Q?hsK8U3kUVuG9pkefa9E0Zk87ws3rma7QM5577VZv3L/FtvX09agExPv82uA8?=
 =?us-ascii?Q?zVltntwM3Uwrbb7vJFEe4rZ0zrqgoP9vMRN2JiDxjG6vm+tR8x8lhVGYtdfp?=
 =?us-ascii?Q?fQJgu7j92Q1gmH6iFPKjlEI4K9h/DcgfZ6HKlpuK7gnSz4zwnaL+cQkTIcf9?=
 =?us-ascii?Q?41jQxAjn6PC1k7l+Lazd7bqyAqENXNb15wRD6Mslrp2O8XbjfeHQhE8IZKmQ?=
 =?us-ascii?Q?PlV1GQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B44wQm4i4H97u9yREfm0rIZi9F+WKP3rqhn9IfzlTJonuMOCBc9LLLgnqAh4p0tW/SzPY2T8Ur7uyQtUD7WOl9BLksSOIaw+QIrVy2A22ouEipBgVtdkiM4aO9xLLxHf+CnFd3lpYHY9xSW/VU0q7wk/82//j+8ry6UFTrjgPh7Qm0qSJiC1yON1GXroHXUn3K4amZISkyDiia3S6yVNxUGL84LFZMKlbNgByisFqHCscfiweRrIF2bBAhQ3Babb9MzK9gIvy54O+pwtZLH5i3wsTOebL1va+WdfnQXZpr3u+d8FRpPvE2gPGIxBYryX+Q10mqFbhFMyHsD4zjz5avYjzicFTggrQoam8ivsl3RSfKD5qHVD+R4mJqYJOElJwBwl7vNVQ7Ay9454HO0C3Svs417N1ZDcaJdwlDacqDrpdICKfo+v9CMPoNTXX4Be
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:20:49.2388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bffd7d76-c3a4-44db-2bb6-08de68c8bc37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nicolinc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

On Tue, Feb 10, 2026 at 12:46:01AM -0800, Shameer Kolothum Thodi wrote:
> > On Fri, Feb 06, 2026 at 02:48:04PM +0000, Shameer Kolothum wrote:
> > > CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that
> > enables
> > > virtualization of multiple command queues (VCMDQs).
> > 
> > Let's mention "NVIDIA", noting it's a non-standard extension.
> 
> The idea of this ops based callback is to make it more generic and not
> NVIDIA specific to start with. This leaves room in case ARM introduces
> a standardised version of something similar in the future, or if another
> vendor provides a similar extension.

That might be a different naming which we have no idea about yet :-/

> > > +    void (*reset)(SMMUv3State *s);
> > > +} SMMUv3AccelCmdqvOps;
> > 
> > Overall, an ops structure feels unnecessary to me. Maybe init and
> > reset are somewhat plausible. But nobody else would reuse this ops
> > structure that is exclusive to Tegra241CMDQV?
> 
> That's true for now, as there is only one implementation today. If this
> abstraction feels over engineered at this stage, we can simplify or defer
> it (and fall back to calling the tegra241-specific functions directly, as in
> the RFC) and revisit once there is a clearer need.
> 
> I'm open to suggestions, and let's wait to hear from others as well.

Well, I'll vote for adding that when someday there is second CMDQV.
There are only a couple of CMDQ-V functions required to export for
SMMUv3 code to call at this moment, which isn't so bad.

Having and naming a structure exclusively for NVIDIA CMDQ-V doesn't
make a lot of sense to me. And if we really want an abstraction ops
maybe "secondary_cmdq" in the kernel driver could be a good choice?

Nicolin

