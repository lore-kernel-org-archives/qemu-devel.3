Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5DFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNUDZ-0007Ra-Cd; Tue, 17 Dec 2024 04:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNUDW-0007RE-RR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:50:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNUDU-0007V5-Ba
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:50:14 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH1ugvt015901;
 Tue, 17 Dec 2024 09:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=l3bI+ldiFTNCCNjOCaq3cSvuMSe9mV+z+4b8tOazGkM=; b=
 ApSSjCjlWTEdOXoPeErQt2x0LGesoTzRlH6eOX6wGtBL/sbF6AaO4keV5O8nYUkm
 pWT90tkuSQ3GexAvKTn1ekljpz4UKtI+dogeACHf7FQLhebCnh5JZcO/zHMkyFPr
 g0jiExehWid+BFy79ATE0dazTF5645XtUL1x9mBpnXT9Ectv3a76j0XJP4Ghv9Hu
 Y8Pcey2dzYndScudCifMwEMQJbANea9FNmD5OWOqlqW0Mxu3k6zkkrggWeLmUxxZ
 EcgiyTyePl6xBweECpjVjPVPYGkxhVNYA7CQV6ax3+yNAP6Ud/kqTJPRgJqHI7tH
 ke+7WajWweu8jsv8VpfrtQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cnnhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 09:50:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BH8jvED011752; Tue, 17 Dec 2024 09:50:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f85b0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 09:50:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp07Fu4NuFopXTiI330MxXhjmMNGrM5ytcYSBgYZM0De31HtqupdV2rJtNOZbA+b6C08Lo76NEmQpUfbBl/YxhDanpOwdOxkAEld0+cQ9wSIqDzcBvpuyKDjZsfhs+MWDll8WSoUI9ybKrK1VSTkiDJ1pb0iKbBwwFU0e8oiD9LuydSE9fi/Cuh3mjRkrlmkpVHTb8UIq2kBupjfxb3XWuBE4pSHzCypB4/xxSjVG7SXnWYrYpIgoW0ZEC7rVM7y/cBOTojxTFGn2Wh4M83Olf3xoZIqNYWeBLHRV7aTpL+CZEVaQdhIBSxUfQMcRDr5kXYL+SeU4Nk4L1AR57RhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3bI+ldiFTNCCNjOCaq3cSvuMSe9mV+z+4b8tOazGkM=;
 b=s/JZ2G1KYqvpA4my140dEg82t7Qi+6UglyiwYAp+cYeT97VuyuX/p4gbNAhGuUE9FVaf8R16arL9gVjMySgCPeQmp6MeSZtrvZF9UKA1te+58JRYdrm5lFawEdOBzwqbI/R6t83n06c7KxZyTNh7KtfAWB7OBl1mNOumzYObGURdU4UCsnLloDnfU/qMIl2mH/M7zACKipBgBEMSpalHh8MMNCmLm4jz6ErBqfiB9vKdZrJ8XIayZjgH4knozpy0e/swCJUPE0TTDWxy9qloQFPK3BZAuHKlCD9R5O58gNfNaHIlKAj0BtggkUZWrdyInSWM5gxFQSyk5g/pWk687Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3bI+ldiFTNCCNjOCaq3cSvuMSe9mV+z+4b8tOazGkM=;
 b=LKuo7Q0TNafd+uYz/cThT9N8hGftoGxYg6Kr5bBhCo4nZLs99NcH0TTnrAmvOOEyWs5dejXVZx/YpA1Ccz951R5TMVELa+Hxvl2NXJBF42KkYHiyGTaWSc8x1m2/wL8rSbkW0NgSbngl3quU2zYdzaJcD1YkYCl8fYZWmqKPLgk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MN0PR10MB5958.namprd10.prod.outlook.com (2603:10b6:208:3ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 09:50:05 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:50:05 +0000
Message-ID: <07a5b5f0-7d26-4358-8603-6a723785a35e@oracle.com>
Date: Tue, 17 Dec 2024 09:49:57 +0000
Subject: Re: [PATCH 3/9] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-4-avihaih@nvidia.com>
 <14070e26-ef99-4a6c-b3ba-ef910270856d@oracle.com>
 <63082412-a42f-42b9-88f5-8e40a8f28c8b@nvidia.com>
 <4741b80f-cdf6-4e43-8bae-f3604e858200@oracle.com>
 <91f82153-280b-4782-bbe9-736494c41c44@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <91f82153-280b-4782-bbe9-736494c41c44@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0499.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MN0PR10MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b44e01-d28e-444f-df2a-08dd1e802ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVBnaWphSzE0T2RsWStDcnJrR0lhM2pwaXZFSmxXMDJ1QWlHemQ1YWdWTWFn?=
 =?utf-8?B?N2U4bFpYSVEySWxsVmtaakZwUHdoZ2lkYU1XOHBTeE9vYXFndC9SLzZXMVp1?=
 =?utf-8?B?dUxhc2RGM1VLWUtoVU0vb21yU0tBNWgrTk1RR2YzUWlnNncreFk0UTFkQXBn?=
 =?utf-8?B?YXNEYjNlenJrQnFwK2JXaHBPOUJhQnpVVDJ5VnZaSDlQek4zUEdiOTFsRWZm?=
 =?utf-8?B?OSs0c3RvSC9wb2w0R2Z6clNtUU9QQTl4MllSVFd1VjRoWENxbElDeC80Z1RW?=
 =?utf-8?B?RHdvSlBrdHRwQzFORXo2ejRCU2x4b3ZPMVpURnJjem9jamtkeUpQMjhoMWtD?=
 =?utf-8?B?RXF4NnErS25XK1BzZ1NXdjB6M0JiTTZrSGF6cGl3Rk1xaGhlM00wcnJqYTl1?=
 =?utf-8?B?WWNtS3BPOS8vWGJUc1MxZk52Tk1FYXBhNDY0a04weXg3czNQdnluR1o0TlFm?=
 =?utf-8?B?THk2WVBzbVVTOW5CK0o3b3ZZdHoyekx1SUlpY3lNeVJDUzNYazV1ZlpmZWdN?=
 =?utf-8?B?d0NQUGx2ZGFKSEdUZEFjY1Q1SHQzaXVnNU1VZnlTQ0MyRy9VbVFnM0UxY0FC?=
 =?utf-8?B?QWluTDFoZllYcDFmNzgwWGlVeVV6UGJnT0RUZjNtNzFaRm5naHE2TFhCOXlw?=
 =?utf-8?B?QThLcXBweFEweEVjNjl5WGZUMjJ0Mnowb3JZamU3N2Q1bTlSTmFoNlZWUWgx?=
 =?utf-8?B?NjJIQmFXaG9ONWgrNWlTSXpnUlJ4REVQNjlVNEtHdllFY3pEZ28yUUxraVdn?=
 =?utf-8?B?YVhWWWwrWGQ4RERuZU1CNEpUNldyVVMyNG9LRCtYZ0dWeVhyYTNsVlZaMU5l?=
 =?utf-8?B?b0xWZ2lSdDZZbVZOTUlzR2NaRmxOMkVxTUxpcEdRWEplenRKbUUyS3FTV3lw?=
 =?utf-8?B?d3MwaUdCZVh1TUd6LytjM2tkOTZlQUV2ZVdldmo5aWhHQ3NpNmpENGpqVWVM?=
 =?utf-8?B?b2xWa1ZDNVRNdEFhTmljbWgwZXZXSms1dThLU0FZdGQzc05MS0dodytLc0h2?=
 =?utf-8?B?UkdTa2QzR0UvSXV0Ync0SkZZdkJxaU1UdDkxRVBxTHQyOTRXVWdMd3Q1cFMr?=
 =?utf-8?B?cnkwUkZqNDBkSTJLc0pJeEY0aWVGRXVlMm1wY2RHZjluR2pqbTd3aERibkZL?=
 =?utf-8?B?ZEZNbUR1YVcva2ZGVWlibFk1Mk1FaEpUR0tFWTNZM1V6RWZ4Y1JTZjFNaGR6?=
 =?utf-8?B?RUU1U2JqSC9NUklJVjhKUWhUT2Z6ZE1VckhZbkpBMW9VRVk5SW1TNGZpdWN6?=
 =?utf-8?B?cGphR0VmeG5KSjZYY0pkbGUvMGJlSEFudDV5TzViTEhuWk1KOHFLU2xwalM5?=
 =?utf-8?B?UkVYSmlIcW9Fb2lKZDZyN2g3VHJMRlc2NXFvR1c5c0Z5eEN6a09zc09mbUdH?=
 =?utf-8?B?cnFVOGtWRkMvaFozMjNOL3V6QTA5V243YzB6UDZWN2xGenhRVDNkSCszbWxW?=
 =?utf-8?B?dFVsVVExLzFVTG83dVByL3JaSnZ2YXM4dWNzYm51eGpMK1FjMkNxcWJKSUkv?=
 =?utf-8?B?eS9DcnI2UG1ERi9SSkwvYmQ1UWxsZEthWDNlNWh1dEU1cEdWU3BKK3RJVnkx?=
 =?utf-8?B?UzVEdEcvV1RSTGNvWDhqb0VXZllidjJ4Mk9Zc1hUeWJWY01saXg1T1poN2Z6?=
 =?utf-8?B?VWRDNTJ1WTdNN2d1QnlLcmZjRWxwSkcxb1V6T3ZkZlVtcUk2aVg0TTVJdTZF?=
 =?utf-8?B?Nk4rMGJBNUlkLzdxMzd5YVhFRzN3MktMMVI3c0l4cTNkRGNqV3NBOGltWkc0?=
 =?utf-8?B?ZjE2cFBPNi93cHFodDdHV3JjN3BGWFFoOG02elozOERkbkI4MGJXRHRnVkFt?=
 =?utf-8?B?VHBnUkJRNThlYkRLaXVHbmJRYnFSYzJIYUxvN3g4ZFREeUI4cXBpZy9kMjBl?=
 =?utf-8?Q?9iFopuDoMou7i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxHdUptcGVJR2E0TEM5M2gxOXo2alpYMFVsb2VPNzVQWWlOUk5mVG5OZXpO?=
 =?utf-8?B?SmtxWXdDbGovTUx1TkhONkRtV016ZVZrMWl5R08wcnlMRXliQWlHN2hHcy8y?=
 =?utf-8?B?OERnZXZXOG9iZGJLUERZUlIrVW5kWUREMWFLV2FncW5ic1Vid0hVa2RsOHJG?=
 =?utf-8?B?bVBVWFplZStjWUwrc2NwcUQ5ZDZ2MGxOVGFGdEZqdmFoV1ZJUWcxMXRVbFIr?=
 =?utf-8?B?dkVaYmNOQnQ2aGlGYndRbi9jdndoK3JBRUZ1SXU5TVNza29KaFY3c1c3QlJ2?=
 =?utf-8?B?ZFJDcHRzWWp6Qm5HYWNBMllwMkROYXZVaUZFTjEyMGswOTVDUmdqekFYd3Ns?=
 =?utf-8?B?Nnl2ZWZucld6K2MrR2Z3b0l4QllGSmZkc2prNDhmMnNmTmNkWEZMRkdUVlVM?=
 =?utf-8?B?WHREcngvZHp0ajMzQm9KOW51SWJ0MU1Ddjl2eTlsR0RZYjZjU1pvbmFLU2dC?=
 =?utf-8?B?UG9ka2xhbkQrNjZaaDZHSnM3SjE5NGQ0dUxCTytxV3pXVGtoSUs4SXVRakVh?=
 =?utf-8?B?RjJvSGFFMGQ0bXVPb1RSTTl0MVpWM0srRDY2K1pBL0g2QTBGMlVqL3dNZzZm?=
 =?utf-8?B?QjNUOUl4UXBmaUMvMnl1WUMvV2JwMENzZW44bzlMYUw3VnZ1M3VMRGZjR2lx?=
 =?utf-8?B?UWtTR1pmNGI0a0lQSFlOSzNRa3NManNmMmVPamdBcGF0aGN4M1BtOGJqR1ZR?=
 =?utf-8?B?RHBkZ0tZQ2x3VFhrbDRCazl0dVpBQk9oaU5LNG4yREZFL3NTNS96dGpLeFJl?=
 =?utf-8?B?enJsZ2FybjgwYlpmNVZnbTlqbG1wWXI3NVhEeWpMN1VLamJhMzlSeVZRWEw4?=
 =?utf-8?B?a0oxYkJwUG80V2tEU0pNNHNzb01CWVYwU1BENnNtVDhMYUwzMXF5K1dWUlNX?=
 =?utf-8?B?aUpOenRzSFl2WlNvOER5YkZEVXo4MmcxdFYzOU82Sytydi96NnhXU3RPYmFO?=
 =?utf-8?B?bnh4MDdhbHJEb1M1YkYxMmJpQ1JLdmlrNzNkbmhVMFlwMTRzWUV2QUM5Zkl3?=
 =?utf-8?B?WXcxZzEyZTlzZUZYZFJ1Q1lvdlkzVytoUmMrTlZYYWdhdU1UdU5URU5vcjFV?=
 =?utf-8?B?Z2ZJMjdiYkhTT0hydS9LZzY5eUdnMGU0bGZQUXlraG5PSzJPZURrWTFhN1hO?=
 =?utf-8?B?djJJSUUzRUFWcmtlMGRIeG03dGdzYlE0SytkWi9FU2dQMTFvcTRDeUNFejVF?=
 =?utf-8?B?RzJFQXVLM2tycVhWNGdJS3V0cGxIYnI3Um85RmwzcGtQWmZJQlVPb3ZweE1s?=
 =?utf-8?B?T2F6WExmSzhvUGRmcVlrcWs2ZEw3dmthYytOZUVYanA1UkswSkJKR1RnM1oz?=
 =?utf-8?B?SkNlb0w3a3dkbnJjYjZVaWpSd0VLaFpUV0oxdDk2YkpsNlJhYUhlQUVhWEtX?=
 =?utf-8?B?ZUJYVWJBV21laDF1aE1VVVo2WEIvN0REOVBjL3NieU5aTEZtMDRveUtFblFC?=
 =?utf-8?B?OFI5QjRzaWdHeHMxcDdTNmhNaDNNbmRnaDRwZE1ydE5uaHNkOVlONWNybmM5?=
 =?utf-8?B?dUo2c3BMa2p4U3MwR3g2Nm9rMXlLRnA3MmpvbjArS3J5UlNkalc4dTFSZDNj?=
 =?utf-8?B?V3FMMENrK1Q3OEVuZWhZTW02eG9kMGVGQjlpN05oUzNVS2cwWmZ3L2FiWFFi?=
 =?utf-8?B?d1QxNDU1aXl4U0RmUXZhaDJKd0NLOENBcGtneElmRjNWVTNzTC9SdU93dUx0?=
 =?utf-8?B?RHBhcVE3V1pUT205MEE3T3A5aWJEVEVUOG85aTFkcjBCeitRZFJIYWNDbE54?=
 =?utf-8?B?bDkwVWJrc3EzQXFhSW5hVjJ0OFFEdVdWUDY2ZlVNa3hQTE10dkVSMWVadlE1?=
 =?utf-8?B?QTR3NVlVMU5JMVlvcDhSVEI1UFJLaE9QZmJHWHZOOUFqVWpIUWdyRmphZURk?=
 =?utf-8?B?OWxON01jVVBkQ1U3MzVZTEp5Wmk0blVPTXVpQ0VKd2NLQ2c5RWhRdjhIMjlp?=
 =?utf-8?B?M2hJWGtRZEh6ZlE2dTVVM1A0RmRaMWlLRFRUZFUraFpwSWxHSTRsQjhqeU9J?=
 =?utf-8?B?ZEt4UTlETzMxbzNFbFJHc3Z2U1ZkYit3bnpyTm40emM5bVpEV1ZOZFRFSTd2?=
 =?utf-8?B?SWdCbExtOVBmcXFYZFlneHI5QVgyK1gvVkJrbElmL29jV1JIUnZ3eTU1YU5L?=
 =?utf-8?B?Q0JGeVZrdVhpRFB3QTMzbGx5b3ZNQmlsM3R2YTZ0dm5MVzFkRFh6MndiOHM4?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iWn1OtMc2J7W7zrHIlo9LsL19TTxzUaA3+fttyeUIQSCndhihX7ItXDaq81TtGlEB4f4lorkJp9GfVibTyWtFVlkhOL+mfu7R+9eLPuUL0WBnbwX+qSYezD4at19blb9Dk73QQgKuAqPqC+KUhqnvaxvH0NSJCqcfOp5kpOlkg4mTW8OHOOAufhQKe5OP760vMARLq9m8lmWKCyLpW0c/nYfzkr3BWl2s0oM08S2o9nsuHEky5h4s08d6c+uI15fPKeesgL1b8jQFPZr2Pt9qyRmmMDG5HsmxLWmKIUHz1q2Jt0TdrmhJnMSWtwOC0RyQmgT3pjb+RqJNIZGyCnWiDdo51oFvErAHre7Y0J0NczDPEI1VweIH+onpa7QfNyHD4IKcN7c7i/8xm+9BULT9zpP/j2GTmuhWf5XPwu60VVbXBF7S1emtKQFpqvPtXTNy7jbccRD4XTHGi4CV4NCpC7kN8Yr6nIHQ8Wjz/auSBdi5hTLkZX3daBXH351SaMMqsaudUUuzxy7sHiGMZ0u29gsD4KhzXhFua4Lr9vjgD/Dq7HUWoduJ6grlWY39tHr7iZe36+RilUjXb6A/w1zsGBPpOYR0z8muYsSMiHCgMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b44e01-d28e-444f-df2a-08dd1e802ef5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:50:05.1728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFi0oLdmbBCO5K6crpAowmLefK0KffXvG1Ypjo2kWF5r18e15voTR/k6/5flWY26ToqJ02+aKB+OjM7vbDTogJMebNYSzNP4ZL13Dk7OCV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_05,2024-12-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170080
X-Proofpoint-GUID: I6hnTpiACVkkJbJ-10S_Hfqr4jNTwAzO
X-Proofpoint-ORIG-GUID: I6hnTpiACVkkJbJ-10S_Hfqr4jNTwAzO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/12/2024 09:38, Avihai Horon wrote:
>>>>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>>>>>    {
>>>>> -    VFIODevice *vbasedev;
>>>>> -
>>>>> -    if (!migration_is_active()) {
>>>>> +    if (!migration_is_running()) {
>>>>>            return false;
>>>>>        }
>>>>>
>>>>> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>>>> -        VFIOMigration *migration = vbasedev->migration;
>>>>> -
>>>>> -        if (!migration) {
>>>>> -            return false;
>>>>> -        }
>>>>> -
>>>>> -        if (vfio_device_state_is_running(vbasedev) ||
>>>>> -            vfio_device_state_is_precopy(vbasedev)) {
>>>>> -            continue;
>>>>> -        } else {
>>>>> -            return false;
>>>>> -        }
>>>> Functionally the change implies that even if non-migratable VFIO devices behind
>>>> IOMMUs with dirty tracking would still sync DMA bitmap. I think this is OK
>>>> as it
>>>> increases the coverage for calc-dirty-rate (provided my comment in an earlier
>>>> patch) such that if you try to get a dirty rate included the IOMMU
>>>> invalidations
>>>> marking the bits accordingly.
>>> We still have the "if (!migration_is_running())" check above, so non-migratable
>>> VFIO devices won't sync.
>>> But that's a valid point for when we'll allow VFIO log syncs for clac-dirty-
>>> rate.
>>>
>> It's the other way around :) This change helps calc-dirty-rate because you can
>> use it and still account for DMA unmap based dirties.
>>
>> migration_is_running just stops logs if migration is not running. And that
>> doesn't care about VFIO migation support.
>>
>> But if migration is running, whether the device supports migration or not...
> 
> If the device doesn't support migration then migration can't run, no?

/facepalm yes :D

We still have migration blockers

> But anyway, as we talked in the other thread, I can untie this from migration
> and then, as you said above, it may also dirty sync for non-migratable devices
> which will make calc-dirty-rate more accurate.
> 

Yeap


