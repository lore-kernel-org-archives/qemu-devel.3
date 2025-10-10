Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C58CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75e6-00043F-Ev; Fri, 10 Oct 2025 01:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v75e2-00041z-9r
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:26:23 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v75dp-0002At-If
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAF6vcRPSZ+3ZEMuPTKb3blphQzuJpqdHRUesMZOoyb/l3uo1/adLf79KgLFsGgwObb97gvjSSRTFqLcVYkpYr9TDWIL74rFlBtxtlhNWdQ2xSgHrjXqpt/sCKLN/NvJ5lXX0qdKFTGJeYFvKXx4e4YvTzwafYQu2BC41oH2V+Aswf+f/bhBv/VbY4+pz57kD31yuYQFA7Qq6Zgpt/b0DD3tfOf4n1s+6n9rwXIbJPjJ8wGHeTyRvmvBX1xGYGo2Acgx4jVtZIoObTxofBGIq6KGrpMMzQcJ1yBVXkWZlcVVRJHC8IcLa05pqgbG3oYp6LrdKtJaBqDrFf+D7+sppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPXS1FBT3egR5XIrNoRP/xt5ImWSWsEFtdt++5/YSQA=;
 b=Il7Env/RMUtYHo45pgLF5L+iV56BBqOX4GhAy3BKUCi3+9iOcza1dA6q4TCyGo0Kks1JoTwG0bTwTelhPIdG0Iz1al9AD4iQKJI0Ya4xaxyCCLNJ4AF38WtRiBr5hZq3WEleI1EIB9ojVMz5TQrLXttgtSakXfcXyz0d2+E6Av0FNprwNwBdDQuvVK3Dyq4lMIYEneMZumJ3AVxUq7sLdSKbuvdvhZCFenex+8nVJSTJ+rg8Z6Xt7DCiQa6cGCwYIKA8cRJ4cuTQkwzY30LK31LuJcc4x15pWiJaSPEztJXZBfbw+6WnDDnoc0LCz8VlSRkL8EHMFR4CA86EodS+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPXS1FBT3egR5XIrNoRP/xt5ImWSWsEFtdt++5/YSQA=;
 b=YwtcqFmActbRIhfDkcuUI4BTUdJay0dZL+iS+deqHhbmGzJyxAkmBqwxNnMfnitMZ/zahV3csKsKR0L3OrT3mpuf5+sRqc/w0xF+4qi1mRAlP/KgcsgmeumnjmKShZ7foEii4Lls8tyhspVRePR6y954nbpjuy8V5rDVVmmSIXk=
Received: from SJ0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:33a::10)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 05:25:53 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::50) by SJ0PR03CA0005.outlook.office365.com
 (2603:10b6:a03:33a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Fri,
 10 Oct 2025 05:25:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 05:25:52 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 22:25:48 -0700
Message-ID: <29d20903-e255-4398-90f3-5e04391a46fb@amd.com>
Date: Fri, 10 Oct 2025 10:55:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Cleanups and fixes (PART 2)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Alejandro
 Jimenez" <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>,
 <santosh.shukla@amd.com>, <aik@amd.com>
References: <20251008164324.21553-1-sarunkod@amd.com>
 <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
 <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3410d14c-868a-46e1-29cc-08de07bd7af6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVRLcDV5UGlDVzkxUm9VNXdwYTYxUjZCT3R1SmlTVFEvM2dTSmtITG5uT1NZ?=
 =?utf-8?B?VHc3NUdxNDhDNGhMWXphNW00MkdMTW1JNjhzWEd5R2hSUkFXaHJ4K0ZxM3BL?=
 =?utf-8?B?MnU0czY0S0xJZm5Ka20wYnB3N2VEMXdDNllKVFlmRnpVNk9MeXFSeWFRVmY0?=
 =?utf-8?B?dkdRN2phQlBxZEJ0dlF4Tzl4aHdXbkROTytyYkJUNDAzeFNGR2J0SGZtWk9I?=
 =?utf-8?B?cTZRKzlQOUtaOTRiNkhCWW5kRWtuV1AwNUhIWnZ4YnZSbEpCdmNlU0dqUm95?=
 =?utf-8?B?MGI1RXdSVWNSc2U5ckxjT3RyNWlRenl6NXhpRkIxeEJUQy9hdE1JcHppQjNE?=
 =?utf-8?B?c0tLUWNubUV3dmMrdzczb2Z2czdnaDRISzhiaUtEd1I5ZCtqaFJXNXVtb2dE?=
 =?utf-8?B?bVk2bUVvVTU5WHdMM0pwc3J5UlRkUC96SUJZb3RlYnRMR3U2K2tEVDhwRHpU?=
 =?utf-8?B?TWkwaExYaDBibUlMUDRtWVVBUVdZWkEwdWY4bVl1SytGMWF6TUhWZ01qWHVx?=
 =?utf-8?B?Zm1PUWRHcDlNL016OVVGeU1sTHBvcmxOZTVGd2VTYUVQTGRIN3Naa2FMOU14?=
 =?utf-8?B?RnU1RC9mekxjTWkxUlJEMEo0Qk56RE9abm1zMk8xNnhyU0dDMWJKZVc3dCts?=
 =?utf-8?B?TWpCR0FaM3F3enNSSFlWRmJkUXhHckg4aDBNZEVpZVlBUTdYYWc1cHRKdnhM?=
 =?utf-8?B?MFo4YWJJdmdsVzN3VGU3VlZQbTZ6OGZoaXM1ejhMVG80WVR4SDZ1K1NrR3Vp?=
 =?utf-8?B?TmNQVEticHpUdFE3S2NNQzJhUklTQVIvOEhaZXU0WUM3eXBQQW1KeFVTLy9U?=
 =?utf-8?B?ZHFsSVZCTDdTV3FERUV4UHc0d0NQZGk2UTcrcFhwUGY5ZWZrcmFaSmFoTWdo?=
 =?utf-8?B?SUlicTNYRjhjTVdRZlR0anA2bzJRRmtCNW1BMzhJMkZ5MmVxQmY5Nk5vMEpq?=
 =?utf-8?B?QThtbVVMUUxsdEJTYnN0R2VkK0VDV3N0aEYrVTMzZEtnQ0t6ZTk0QXBXUHV5?=
 =?utf-8?B?eG0vaVhaS2RBbkRIb1paSG9VbUpaNjh1OGs5MFpXdUtRVGF5SXBCaHJJejFn?=
 =?utf-8?B?bTBSN2JWUUFQZDBCVWdoRUsrdW5DeTBwS0lvM1pSdC8xWExCZUIycjFHdm5t?=
 =?utf-8?B?VTB0RmdEc1YrdjhBZWZWaTAyYTZFYmZTYUdjMWc0bWt6Vm1TaTc1TzNla1A4?=
 =?utf-8?B?L2VLR244emJFbjloY1ZtUGtUbnAzR21Ja0VPUi9kWGpjZXpzY2UzS1R3VGRD?=
 =?utf-8?B?QlhPcWdGWXFMSjJ1ZzhqVGJVV1UxZEZSbnRITVYvQUZUZ0FGdTVmUW5XTmRx?=
 =?utf-8?B?Y3Y3T0dkUWNXczFFSGxOK0lRcG9KTUxrL2hTc251dzFacTBvTU5PbFQvT2pY?=
 =?utf-8?B?SnR1TFNNSXA1aWtZbm9NTWQvOHpvMkQwL0xzTE1ORHQvWG9DSGNIQStFVndt?=
 =?utf-8?B?c1M4RXEvV3lBdzJMeVNFVXZVbXNwOXpPYnFIRUxRMXoyNmRrM1ZJNTBmK042?=
 =?utf-8?B?clJ6YkZkb1ZyWlNYOTlFdmU2Ry8xUWFkR1VJVENXVHhqbkJEblF0dklqcERr?=
 =?utf-8?B?SzF3aUtpUHl3RlVZcU5HVFRBbVBiVGVrdGY4SStabkpqaDRzOHBiVUtMMlA0?=
 =?utf-8?B?UXhVS0piWE9VMUZENVNLMzNGOURPMjQrMmc2ZG41YXg4cmZ1M1R6RDREeWdX?=
 =?utf-8?B?Zkg1RlBWTHdVYzB2YmpUM2ZkQStoWTQ1R2c4aE1idlY0amRhYnU5Y0JrRURi?=
 =?utf-8?B?ODFqTGk1cXpldm1qNXY1ZlFidy8vbUtVRkxsbGlLV09nUjd5N0ZVRVdoYVlS?=
 =?utf-8?B?dXFYUWY4Nk52bEJ2QnhnOEpObW5NSkIvVE1MSVROa3FkVmdGZVVneWZhNVNP?=
 =?utf-8?B?L2pXWWtkLzR0dkVhUDBsdm9JY09XTDlVK01teXlQclFRaXMya2JreWMvYU5N?=
 =?utf-8?B?cG1sTy9pUzM2Y21yaDkza1hPTWpaSTJvNk9sSjVGSmpUSnJkSWorUzNxQS93?=
 =?utf-8?B?dWZUck5mNjhvdk9XUTRSWGlxczlxUFNBV3h6Rzd4Lzk4Z3ZZWlMwOFRkWUxm?=
 =?utf-8?B?M0dvalpDWThZbDJsOHAxMHp2NDQ4ODlCd0VYd2tKVXFzUHVwZW1yVUMvYTNY?=
 =?utf-8?Q?vg+M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 05:25:52.5100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3410d14c-868a-46e1-29cc-08de07bd7af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, KHOP_HELO_FCRDNS=0.399,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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



On 10/10/2025 7:49 AM, Philippe Mathieu-Daudé wrote:
> Hi Alejandro,
>
> On 10/10/25 03:33, Alejandro Jimenez wrote:
>
>> I know the commit log is not consistent so far, but going forward I 
>> propose we adopt the shorter prefix "amd_iommu: " for commit 
>> summaries. There is no ambiguity (only one arch has amd_iommu), so 
>> the full path is not required (i.e. avoid 'hw/i386/amd_iommu: '). 
>> Shorter boilerplate leaves more space for relevant details, and helps 
>> people like me who struggle to comply with character limits :).
>
> What about "hw/amd_iommu:" to keep 'hw' in subject?
I also prefer "amd_iommu". But I'll wait for alejandro's reply before 
posting V2.

