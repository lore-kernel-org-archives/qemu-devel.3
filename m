Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED136C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 06:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEN2K-0000RE-2K; Mon, 12 May 2025 02:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEN2I-0000R3-Iq
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:53:14 -0400
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uEN2G-0004XG-N6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 02:53:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKsFm4YUyqHKWI3P4ph+EGUh/xuBmCkB5+8U706/PtYgSOL7gRwGqtnkXWD1A2xPUOQxlCV1UjFsSO5kp6QHeMM7/6B1jXJqdu88yf2xr3K1T0SsMt+atNsX44uOT5lkFFZfCDRdgGPojdbvGJnJclBUvpUtZtUUaGWQQcNMimcTwmC0NlvNo8BgpLaTMzru3oNNQeYQ8bbgDmYq6zxm8n4IWljoZ5EPhDyIH/AM9KqRkz/0mWhSJ81OVHWzROoC/7E5xg9wIMisI52HphcOO6GtCyJd85/4t5hUuje34oqP9LM4PStS720D+KjqqDWcAC9RseQrxddPqLbToYxy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKSQ91BI7XD4GbbvXmE/cqy3exZz0acztiyN/md3+ic=;
 b=TeUEqEuelwTHwCecxP4tLHMyPoVKGi7x8Y2yYo7B/oVwpe4cF8WSYzddgwLSz3bCrZ4iMCwaQuD64kZer/d5eIacDtxYNuw02RQo0htu+gixwgMF6TdG9yRRRv5ogi1+yas9C/AH1/0vF8GUCy1S12WXpGnTl+05AQ6nARFsZgnmE8EwXh9DevSxdM8V3qdIqUgAJukRgIEQQa3tW8uMGWQ9H1lqVbb1YKAAn6BYqBzhaQniwEK1oYnL5ASxjyrMyFPMUeo52Or7baiv8HUUGn7vVtDrr+TXtV6X56/IuJsiSs13u+xVzMnQqNdSIsMKYUNbpwUPX1NsOZFzgYaL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKSQ91BI7XD4GbbvXmE/cqy3exZz0acztiyN/md3+ic=;
 b=0CbRKCJVXf0GNQjDAPZw3hvFoq8/jAiC7H640mio0y952aMvjkCD7DqRHGv+S0NW/M9H7K7T11hfW2+rO50lFlFUagovQ9EOygml475dtyXNnRJd6OcwVhbeEql9Jcdrfq2fzNln2m1B3mMm+Eeomc8lMP9Iwtvv8zwf1tIH2WI=
Received: from BYAPR07CA0097.namprd07.prod.outlook.com (2603:10b6:a03:12b::38)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:53:07 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::e9) by BYAPR07CA0097.outlook.office365.com
 (2603:10b6:a03:12b::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 06:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 06:53:07 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 01:53:01 -0500
Message-ID: <c9104f1a-1e9e-4a4c-b7e6-e6fb78f6a818@amd.com>
Date: Mon, 12 May 2025 12:22:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] amd_iommu: Toggle memory regions based on
 address translation mode
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-16-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250502021605.1795985-16-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: a04fc61f-4bc9-4a1f-4212-08dd9121a6ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkRtK2wrOGdac2VEWHlVYlp0d1I0T3B1cURlaUpMekNKS1E0bVpza3NVd0Zk?=
 =?utf-8?B?dUlzY3FvZlVHTzVoUGY0QmhaRWRMNWJIWkJUekpiYmYzbm5KU0lhcnFITFR4?=
 =?utf-8?B?SGhxYVlQU1NVOUxiZ0lOYnZWR212RHNDMUgvWmE5bk9tS2FCUlpGWG9nL1JD?=
 =?utf-8?B?bmJXMy81Vk5OSVczREJtdlZ5N2ltK1gzS0dKSkF5cG10WFUxQTZaUjJ4TTNE?=
 =?utf-8?B?bVorUk1nKzRxd2pVTWhXK0h1eDFNZDlpK3lxTGlZUVhkdzZ5aUlXZlY3ZmpD?=
 =?utf-8?B?VUJJL01LaTlmZEpQeWM1Wm45VUVCVzBYQTNzNmNtS3lUaDBRR0ZqaVF2YkJD?=
 =?utf-8?B?Nytvb0NUNWlUcTNYWGJaQnpaNVlQaUUrOURHR3B4a3lRWThXZkxwQUxqRDd6?=
 =?utf-8?B?VDdjOXUvY0h5NGwzaWpGTUt0WCtyc2dwbDhOcEhBdUF3S0hOZnBwbjhHYXdy?=
 =?utf-8?B?T1RkeDVHZzBwczh0Ky9aUEZPVXpnSWJtUU8ycTZzRW54SEJJbWNOalpuU1pz?=
 =?utf-8?B?Mm50aXdEWXdZejFubHVjYlg1MzFIQkNMcjNlRHROVUNnRE0yeHpYcXZnQVcr?=
 =?utf-8?B?TzFmYk92YVhDREF0ckF0ckRnWWozazdQL1ZPc1JkeHVNU3JmRmJ6elN4aSs5?=
 =?utf-8?B?RjdLaEUrbXBncmFVSDQ3L280N1l1TC9TUjBMbnB4L2xNaVBNeE1MVzRybEFQ?=
 =?utf-8?B?L0RTQUJINkZjNkl2cUIvT1NtRjhwU0xteXRSK0d1KzF1RklqYXQzb0hBdFZv?=
 =?utf-8?B?S2VtWTd4TFNhWE1hMFFOT3g0Nzc3TGF2a2d2aGJxT0ZnOGlGQk5OMys0WElI?=
 =?utf-8?B?akdTYVIwYmEwSVh2eVIzQWdzdkkvRGFYZ3dvbVJvNWgvaTdYVlpMT05MTWJs?=
 =?utf-8?B?SFpnT2JtMHZic2p5OHlTRUhGekR3Zk1mRUJQdnZaL1FPSnNJb1Y4cFF1aVkz?=
 =?utf-8?B?MGRXRTc4UXdaR0tJNFpWSXBHWXFpVE1jS1B3TDh2UkUzU0lwS2J6N0NtQzV5?=
 =?utf-8?B?aFRkQ2wxMGcvRVdMYWl4VWU1Z3Z4UDJCR2MxanA1NlVOT2RUYWFscHBTOUd4?=
 =?utf-8?B?ODlGNlpNUVhRQkJKVStuY09YQ25mUjVYYVRtbFZ5NDQwL0loOWJMaGxIMnNv?=
 =?utf-8?B?bVlCQTIzK0pOOWZOSy84MVluOFU2T1pnNmNQQURCSnkxMktGc3JCazNVaXEw?=
 =?utf-8?B?bnE2ZkR4ZHdSQjA2M2k0OElzdVdDY0luTk0wMGpDN1hPZ0xvL1QycE1MRUJy?=
 =?utf-8?B?bFJYVG5JeDMvUi9BOHZ0bkNaNWh3bzBvRmJUcllmc0I3SE8vcWlCKys2MGlz?=
 =?utf-8?B?T0gxYVZheG15d3hwK2t1K093RWE0T1VBRXJvR2tyUUNxNE1rZ1g5YjErdmZu?=
 =?utf-8?B?WnZCVkhUMWNPN01Td3hoTlpjN0toa1lrL243c3JzazJrT1ZYQ1h3OXlkY1NX?=
 =?utf-8?B?YXV6YlUvSmkrQS9Dc1k3eGRXbk93TE43aVlNOFJPTlB0MnZlbGxKaFVMQk50?=
 =?utf-8?B?MEhMcVVtN0JpbzRxNXJkUi82KzZLYVlWTi9mL0U3YWI0ZXpRMTBHdlg2Qm1q?=
 =?utf-8?B?aWdzcWJzTU0zT1VvR3VjMVQ3Z2xWRnFOeHVWZDBUT1NqdldWVlVqWDRhZ1J6?=
 =?utf-8?B?UmZ6Tk80MGRPOUN5REJuM3RpcEFleTJaZG5LZXQwQXhXUVJWOFhEWUE4Ui9L?=
 =?utf-8?B?MzNYZkpkVUFTL0lEU3lsMkZhTGsyRFVUdENLSjl6d0dhWTU0bldnbXN4NEls?=
 =?utf-8?B?ZzY5Uy9qeXJ3M2l5RCtZQ1lGTUIvNWM3T3Y5UWFUdmNNZWtmV0h1MHYyTTJY?=
 =?utf-8?B?Vm81UDVzQ3JldUsxbE1ZZUYyYlhYTncwa0NweXA2WXdXb3FZbFpFMUlNU1JF?=
 =?utf-8?B?ZXZUcTYrSVYvcmxvUWNWYjlIM3l0TGp0ajdkdFc0NEJyU2J2ZHBlTDBNU2ts?=
 =?utf-8?B?YXR2TERENVQ3aFRPenJqMHpkdW43VWhVTXlyK0kwSWJsd2E5b293Q01EUEh3?=
 =?utf-8?B?cnU3UlhNQkthVlhDZkpqMjFnSlc3S0ZuL0JsM1R5aUtQaFEwK0NEUlVoMUxM?=
 =?utf-8?Q?vif8GY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:53:07.3943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04fc61f-4bc9-4a1f-4212-08dd9121a6ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612
Received-SPF: permerror client-ip=2a01:111:f403:2417::62b;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
> Enable the appropriate memory region for an address space depending on the
> address translation mode selected for it. This is currently based on a
> generic x86 IOMMMU property, and only done during the address space

s/IOMMMU/IOMMU

> initialization. Extract the code into a helper and toggle the regions based
> on whether the specific address space is using address translation (via the
> newly introduced addr_translation field). Later, region activation will also
> be controlled by availability of DMA remapping capability (via dma-remap
> property to be introduced in follow up changes).
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Regards
Sairaj Kodilkar


