Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E08CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NhL-0002e6-9P; Wed, 08 Oct 2025 02:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6NhG-0002dp-Aq
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:30:46 -0400
Received: from mail-westcentralusazon11010024.outbound.protection.outlook.com
 ([40.93.198.24] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6NhD-0003zV-DR
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko2/a9rVSBIn1x7szPecVhHw5Y7yEz1E4JIWRg9UvN6G/sVwfw/Z8tZ7JB3ie3y2y1r2unuhNJJ3zCn3P4u2wmBJt5beKwhXAdi3wUt00amKCLV9IMZNISEZE9yQpoL6CwPEDHSiHycSstML5ZZuNCu9zMvwQYWzkSCLzZpyMvo0R1Z3COPxg0OfE+p4vDPG/HrbicOIPNOm5g+5uDkA1N2gAt6mIwOYJltBtT9TLmvz8dezKPMX472fkJpLlO+HLmZaDxL8r2Gv4kWhFTCv7RI1wDjUZHcwR0kdD9GqmYEXydgRkkZyisHVoqvRvMF6SkuPk3IZPo21ixVzLoCMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJLAC8PzOfXRy/ZD8HteAXYlLgCkexjD55My/QsGhn0=;
 b=E/UAUyVoXkxs/CDFMRlU5wlG7uKT0f+r6MHSu3VOdWPhWJVfLsKzYm3WNv8J8dQytbPU3nKfoiMAgVFkhF5oYOnwVmdYs5YH4C0/RPPnFlXri86fnFInj45oSfceBYeClTRD10Fo2ao10JnsAhMwAg5jBNj0PEeLLjcCSBwo2zyjVneXJKsvFgEUGIkQxbVVrMeNQTHSo0P6R0bRJAXAkrzn/DrHB+U4KfhHwzohuu2+aGmUw6TgQqM/TU0xgryq8c9zwPkojAuFsccQPZxJa6LesoletGhBZ0ZiWW3JJ5s3aS1GvDdRgeKkp43g0vaMrwzYd39PqPJZY7XX5Pf3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJLAC8PzOfXRy/ZD8HteAXYlLgCkexjD55My/QsGhn0=;
 b=ckdZheyzABHZszCZwIAU+QJ202jpZODNsD411w9HFbCHun+p1F6fQFd+RrSvtIVwdjh7X5ZI4aLBoFvtSlyvPNy0RUcNs5sVcvTVtQjt7pv0DezW8ARxntPXmZn/Ipf8INxIissJx0N5xAM9n1+BrcHpOTHfwW60kJrQaBczQYA=
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Wed, 8 Oct
 2025 06:25:27 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::af) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 06:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 06:25:27 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Oct
 2025 23:25:21 -0700
Message-ID: <83764060-0cab-4c9e-90b7-034a30debebb@amd.com>
Date: Wed, 8 Oct 2025 11:55:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update entry for AMD-Vi Emulation
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 <qemu-devel@nongnu.org>, <mst@redhat.com>, <clg@redhat.com>
CC: <philmd@linaro.org>, <clement.mathieu--drif@eviden.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
 <joao.m.martins@oracle.com>, <boris.ostrovsky@oracle.com>
References: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: 560b2720-ca66-4163-adba-08de06337909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU8wNXRObi95VXVodkZJTjBldDhMQURGVFlEWWFVU0xVQ1BtNjY1RnYzTVR2?=
 =?utf-8?B?SGRIOStCdDBOK2lMSTZGd0ZCM3VPU3VkbWFwcHZRMFc4OWlDT2VTUlhIR2lp?=
 =?utf-8?B?b0pqYWs3NStnbFd4bjFMQUVlQzFscVlHTWMzSHY4cFFiUEFNRDBJaDRaWjRF?=
 =?utf-8?B?N2wzaXlydTg3MXlKOERQdEFraFRwWTFjRmRCYkcxZDlJTmMxVUNFSklteDRh?=
 =?utf-8?B?OXV1dWM2ODVNbXhiN3JtNUtRekpjNTcxanRjMEljejBGKzB1K3RhR3lJOXNi?=
 =?utf-8?B?UU81VitDTXl0NlBGYm94QnM4Y0g1NWwwclVhTFlyNHBGSEdRRFQxY3JoRW84?=
 =?utf-8?B?bVBOVTBvZjBnSy80WGozWitXdFA3N21JemhlT3JBalgwUkZvNFU1QzYxMjRS?=
 =?utf-8?B?ZCthQVBuaS9UVGpMOVJMRnJIaFR0ZS9yOHE1UnMrZXhubWNaOTlkOHZiT2NG?=
 =?utf-8?B?cWhhdTZGaHZJY1h2dHhKYVdrUkZpaU52QSthOTJWRlJHN1NOcFJ3c0s0dkYx?=
 =?utf-8?B?bFZuNWJWTzNkbHR3Zk1yTTJGUTE4Uk9wVS9ub2h6eWdHdkMzeDVteFhSb2Ry?=
 =?utf-8?B?VDlRUFQ0cTJIZUltZlFSbUhuNHFDT2l5NURjSnlqWWd3TldtOWFNTStGbmZY?=
 =?utf-8?B?RWFSZlZLeU94Rk5RSWtFS0hBMmdhdE9zTTNxQXhBTFZuYUtrM3o0K28zbDFF?=
 =?utf-8?B?a2xRb0RCcUk3ZlhqQms2R25PS0lqNUUrSVZRT3FvUU5scFR5VWl4UnlHUGVj?=
 =?utf-8?B?dWhGL3EvUVhLdWRLdUl0cEdGcmpXVnBpV3NMeEZ3ZVlqZUhCK0dnaHY0UVlD?=
 =?utf-8?B?bGFQbzZ4QjFWVUVxSGZLa2R1Mk15cExRZzZ1eDVadHhMNlowemNSZEVUNGNr?=
 =?utf-8?B?VjlpTndSZnY4QTZxWDM1MHI3TG5ySUJJOGhnak0vTVdRU3JhaGdONWtNbkY3?=
 =?utf-8?B?M0VyTWJxZVdod3pjc1JaaUovNmZMNE91c3J5NDlHbFExMGsyejZBOU1jd21P?=
 =?utf-8?B?WDRRQWFBS1B5Q0VHb05rVE5mYVRUMzZMSEg3MnlHMXIwRVRBS3c2QTZIaVA5?=
 =?utf-8?B?ZkoyZlF2NVBraFNvanROcEo3U2F2dlhOMmF5L21ucHd5VWhzVWMvbTFWOUM1?=
 =?utf-8?B?OWVkMmVwRHBvVTd2SW5BK3htcUN1VGpRREZPUnVldkduWTZzMHJzYUFjaWdD?=
 =?utf-8?B?YWRyY2R0RERweXdmL3N3L29WRG1tL2dJTHdxeXhPT3FUamlnVDZ6c1NKelZF?=
 =?utf-8?B?ZDRUL3IvM0tBVzRLQ3pYWmY4ak9qR1dBL0NuL1FQaHdUUGNUdHZOUjZvSXJy?=
 =?utf-8?B?dlNOTEVMdTJYb2JGeTZycGdaVlNhYzZmK01rUW9HdkxXYWNSWHorMXdCd09X?=
 =?utf-8?B?Z2g5Z25HNkQvNlJHcXVjUW5OTE5QNmZ0WFd2YjFtN3pmNnBwR3Y2alpnNXNI?=
 =?utf-8?B?clo5R1BsM2tTdXY2SWFxZmhJTjVHMXhybFJuZGlGREV4UTg1NzN4QTNuK1VF?=
 =?utf-8?B?SXFvRlJmSGtRS3RNUkVrc3NBbXMweDdvTkNwME9RMmxwWGtPak82c09tWktj?=
 =?utf-8?B?aHhLdnAweUYxbUJjV09nRW1qcVNHdWVnY1RVd0dpYmRpVnlwN1RIb0htU1h3?=
 =?utf-8?B?eWpJc1Jsdk1VaVl2cmFUT0VURFZlNmlxQkVWd1JPb1VNY0F5bVRSS1hlbEhE?=
 =?utf-8?B?VG5GWHBwVlFQVWxoWC9xYkc0YmthdVhIeGdEZGZkdjlkTSsrSmErNXp0NGlG?=
 =?utf-8?B?RVQxTU82N3MrRlNZWFhOdEt1MW5EMnlzN1ppMnVSalpORUVsQjVKMHlxTXo2?=
 =?utf-8?B?M2VFQzB1KzBlRFczb3ltdGozbGx1bjJLNG1EK3MwYngxRUNrV2c1WHNnOTh4?=
 =?utf-8?B?TFdNU1ZiaDBpT0gzYUVIeWQyWnd1RVU5ZUpDbDF0cFlZK1pwUHNiV2FDN2Qw?=
 =?utf-8?B?Qzc4MHJERW5CL0pYdzYvazhWTjlleU1QTlVrT3laM2pramllZm42Y2lIeGpn?=
 =?utf-8?B?Y1Q5ZHB0RExtSXB0QTU0Vm96Y0lRL3ptRUVCR1QxTURueExpTHVvZXFURXB0?=
 =?utf-8?B?a0tGTVJSNVZWb0J3Q0ZlbGFWQXBwV2o5RzlBeUIvdmNuZFRhS29saVBzWjlH?=
 =?utf-8?Q?XIfg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 06:25:27.6426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560b2720-ca66-4163-adba-08de06337909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
Received-SPF: permerror client-ip=40.93.198.24;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/7/2025 11:59 PM, Alejandro Jimenez wrote:
> Add myself as maintainer and Sairaj Kodilkar as reviewer.
>
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>   MAINTAINERS | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 75e1fa5c307ea..08de896ca942a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3891,8 +3891,10 @@ F: tests/functional/x86_64/test_intel_iommu.py
>   F: tests/qtest/intel-iommu-test.c
>   
>   AMD-Vi Emulation
> -S: Orphan
> -F: hw/i386/amd_iommu.?
> +M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> +R: Sairaj Kodilkar <sarunkod@amd.com>
> +S: Supported
> +F: hw/i386/amd_iommu*
>   
>   OpenSBI Firmware
>   L: qemu-riscv@nongnu.org
Acked-by: Sairaj Kodilkar <sarunkod@amd.com>


