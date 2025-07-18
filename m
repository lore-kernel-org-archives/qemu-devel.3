Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBA0C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 14:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucm9h-0003Dm-5n; Fri, 18 Jul 2025 10:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ucm78-0008UL-Bh
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:31:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ucm72-00066e-5t
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 10:31:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8ffs2030884;
 Fri, 18 Jul 2025 14:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0CQeg+gVJChPnWDN4ByPu4DdGj4NS/NREkrdc3Yhc3M=; b=
 TotH2AMne7fdgwHFUAYfz4XSRmtGAlAAxUOkshaIpKJimuQq9fmihkoiG0QxXiJT
 eJFhgUvrmNFPSXRUiXmMMCA0El+Jh1WWga0SJqexoGFh6sV3As6okAfOi5IIb8sq
 ppv8S/cvCg6aHBU/hsKdNCbU3ZK3KgB9hYLPBslSSoORNL9DhObjAsliREW8MYhU
 eJuaIstZFa5lbJdBGEG5q7sRgHOi5TZ8ge5KMJJBhIsfh9oki3Lb+/yxJNULUqgl
 QbExkzRSCKZY9w/VoBLuwbKIoOUptJqERrF9OTRx7q5z1iuRtFDrBevt5NSuFgBf
 4cbl+P9dYZs5RxRXb2oA3w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b571x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jul 2025 14:30:51 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56IDDnhE011670; Fri, 18 Jul 2025 14:30:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5e61aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jul 2025 14:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW4NCVC83CAql+C1Y9xFPzq5v9uIv9z1YGQ8iCfKXytONNsOp/axcnGk1+sv1MHhbibG4/7Fb0SNKQaIegN3kK/uq4PhT4rA/1Y2KaRVuSaqEp+M3tnGlabC2YZzc0IMWxVoch+OhQlyTuy/Ll2C5T+paVZ2M1QGzfabIVWbP14MyxA7sskriMESeoephXupIqrlwodhIqzdGVRWUkUXTOZd4w8C0O4wThaCmWh/zqDN7zmPcK1AK1gAzqmhEMgV5e+vGRbnXMR0sD5HODJjUSUpWWDyPKuEoJaQSHjL0car2hhC8t2mAFmNxJW/1NBbsTeRoYvicr6YsK6n54rrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CQeg+gVJChPnWDN4ByPu4DdGj4NS/NREkrdc3Yhc3M=;
 b=t3HEVW3SBVrhbckvZ1SFdwGwGtSxGJpVbaljxNVxEjlPr7b2pAYHMIKNsEyUOUKSgW/ZA8VCeYv8LQP0nIaWwwQQobAzbDenHULujdqQkMrkOWL8POgp8u9ODnY6Pi2mkG77AjsgnCMGP2xR7yHPOSowh01PbX2p1GRVm6ZNeMOtL8r3BhhMPfTGSl6UKryW/uxGcQXJtSwXOv7ap3Zw87/iqPbykPCT6IhFAP2LWmloXIhJC8XJTxjiTH5PTN2XJokF5wmZ1l/6AKgPRx9RAMN6we+sCfxjN+VOzbFBI5/6dqxGuVMxf5mK0lpECB1RA+k5Fo3MHzfYhOh6qjXO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CQeg+gVJChPnWDN4ByPu4DdGj4NS/NREkrdc3Yhc3M=;
 b=0TRs8yNeXcCKgPa8ggh7EEYB8i00Ar1pbOw3F4+P+1ZFP0AcCcPYVuQaZFdzjVgOKLPlqOE/cMXMl3pQwlChQk6c2uqcrNvfY0r1qrUHJqq71P0GBeguefwRVebKqktcreFsUmZlSd50QZXNkjucDxs8I3Y/C2X2MC88KB4ToQE=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 14:30:47 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 14:30:47 +0000
Message-ID: <f223b956-e6db-45bb-99f1-97d1861d1c1f@oracle.com>
Date: Fri, 18 Jul 2025 10:30:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
To: Vasant Hegde <vasant.hegde@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sairaj Kodilkar <sarunkod@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
 <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
 <20250716092916-mutt-send-email-mst@kernel.org>
 <9570378b-0084-4acc-bb87-7ba4c454ddc6@amd.com>
 <20250717020716-mutt-send-email-mst@kernel.org>
 <4413c937-5bc2-4cd0-ba25-617e757a07fb@oracle.com>
 <273eae46-57d0-43db-8b67-f628f729b978@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <273eae46-57d0-43db-8b67-f628f729b978@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::33) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA0PR10MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdce309-f7c5-4b44-dbcc-08ddc607afc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVE5UDVIMXBTcEFlQWQ0Qlo5aUZ0NHZLZEUvZlJ6Q093VkF3Nko3dk90eGcx?=
 =?utf-8?B?SU14dDJTSXFEbDh6ejFDUTdtaUhHVW1SSHptUnRxWHpMVlhxbUtXV2prdDlE?=
 =?utf-8?B?Yytxa1BUTG5GcitRajdWN1RXMEpCUWhQdDFCZUxXUXhVdTJTSzdzdDIvKzRl?=
 =?utf-8?B?OWhUclJ2Z3ZLWjBBZDdpOEVOUUNIVUp0d1Vwd0lDNlBJYzhvWU90T0I3ampq?=
 =?utf-8?B?VTFiWkpNclUwdk9POW9kNXlieHVrbVdwVWEvdzJjVk0wSjM3aGNpU25YZjBF?=
 =?utf-8?B?OTBlT1hFblVpWXpLZmFKZWZxVE1WZDRkUzJ1ZGRoMS9YbGcwcWhRRTdYQW9O?=
 =?utf-8?B?cURULzgwVGRxclkrUHBVY3RYakZManJYNklyWW9PQkZORnlIS25uSnFCTGhz?=
 =?utf-8?B?TG1UcldTYjZZMzlGMGZnZjFQa3Q0M3lLWncwVmIvSjNTQTJuUmhTZWFXTmRM?=
 =?utf-8?B?M2hnMWQ5WmJxWXVoK1VZOU5QT2NGdjZyM3VEdUQ5UWNkVDlWOURGZkJHNHhn?=
 =?utf-8?B?US80Y1NLSlNsaFdkQ1RZQ3gzUHJrNC9NSmxMc0JXVnpnbUwyRWwvSlprajFn?=
 =?utf-8?B?NEE2cG5rNzhwYWYvWTZhKy9aQ0l1YTFlVVVuUzVKTVhJcFhBUmRNK3QvRTZa?=
 =?utf-8?B?K2loNGFGTWt3Y29tTExaeGZhbnFjandmKy9IS1lCdWdCQkFxMHcxN2ZSaUVr?=
 =?utf-8?B?OGI3R05wcVU5cHNaMkZOalIyWFAxZVJTVENoT0JnWlJYNitnNTVVYUN2dXBz?=
 =?utf-8?B?TDUzaGZDaDZxc2ZZNDhUZ3BuTDBma1Q5RWpGWEJ6ckZVMEdaWDYwVnZVRElo?=
 =?utf-8?B?R0luaEY3bzlzU1pRWCtXcCswak83T3hUaGNnbW5EUXFYQ0VMT2w1N3ZjNEVZ?=
 =?utf-8?B?eVhwd2taVSt5WXNHZ0NNeFdhRXVkQTEwYUtKRng0NjRYazQrN1ltRVkzVmhh?=
 =?utf-8?B?OHlIVGFLS21jSk9YNG1SdzFjYjRHdkE1N0czVlBpV1BreTV3WENta0x2ZmJG?=
 =?utf-8?B?ckM2amxaTEF4b1QwVXlxdGx2WHN3RS9mdk9VbldZTmdKQ0c2UFVaZVAxeWIx?=
 =?utf-8?B?MjVBeHR2SlBzU0VzZENkVStnT2JOVWZhNlNLc3VaWSsxaVN1RUkyaFhPWjJI?=
 =?utf-8?B?MDNWVEhwc05nOEp3Wit3WmVxZ25Ma3lKY2RSUklaMzlob0V6T1B2bnRRendE?=
 =?utf-8?B?RkpyT21oVzJXdVV2QXRIQTFteHZYZk5YRW91Tm5xdFhid3FwTlZDWXFSVXJq?=
 =?utf-8?B?K3U4N2JKazVnNmI5YWptUlN3QUJyUXJXV2Qvd21FM2xrRExRZWhzQjFodW9B?=
 =?utf-8?B?ZkFURWNSazdsZThOTFVaWTRtRzBObXhLaXBuVGJYMC9TSjRxNWUwNHUzMnYx?=
 =?utf-8?B?OE82TG5GNzRBakpxbVRQZ1g5anAxbFBQN0lqUzN3WWp4TGRtNFRDQ3g2YVZ4?=
 =?utf-8?B?QVNReWo1L3BMRitUUGo0MGZSQTRXR1oxQUtwdnN5ZVFIemlPLzVmRlAvVWxl?=
 =?utf-8?B?UGQ4R2taTURXaGJiVFNYKzd6NWt0VDRmYUZBbzlFeDZzVDlOMkpJOWREZXlV?=
 =?utf-8?B?LzZqdVFKS0dGS0dORlV3WFVBSEV4UXh0K2RDbWd5a3FYeGtoN3RrMjNnTGtF?=
 =?utf-8?B?d0lucVAvL2xpV1dIUk5LaDlSL1JQR0Rrcy9vNW9jajljSDFJYVdjKzFGcjU5?=
 =?utf-8?B?ODlqT29iYUhDZ3NyRDFLdVJhN0NZQzNCN1pFQTF0TzNDdWNHY2toYktWZFZW?=
 =?utf-8?B?SjhlZnVPM05UbXAvTjNERVVxMjJkVmJVZ0VNZnlCUmxzWFBIcExsQ3BMOS9i?=
 =?utf-8?B?Q3N2NmZKRWROZmxkNytFVWhWT2tMV3haZWYwZHE1WnBhRW9KTFVnRHBTY2N1?=
 =?utf-8?B?WjF4M3YxU2pSMktBMHlCVExmSFU4T0pnemZML3VRMXVpS2JQcDI2MXIzRTY2?=
 =?utf-8?Q?IRq+1T3QD20=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25UV2ZnNGtwTDk1NldlWGE0T2ZmUCtOM1JIakNtWWFhbFo2REJwOGNlQlZQ?=
 =?utf-8?B?UGc4Q05FRkNmeDN5S3dTRFhReEJCcE1BTjFZSk90clRCaDlpcXpxWU5QYUtX?=
 =?utf-8?B?NEMySlJRTmh5Z2htSk1kNXFyOHRGNWxRVEVmSGZScjV6MnRWeUU3UlZNWWJ5?=
 =?utf-8?B?WXhLdytMUmYreUZjRm9oWm9GLzYzamtHMFZJZUpBejJsTTVId3FUaXkxcG1m?=
 =?utf-8?B?UVVkYnhsRHRMTWl1enhxRm8wQ3E3dEMvODB2NjNsY0NDM2ZWbDlrVC9Oem5L?=
 =?utf-8?B?RTZVbVBzdU0wemZWQmdhY2hVUVl0YktXRUJUdkpTOEEvQ0tTRUNTU2d0Rmds?=
 =?utf-8?B?Q2Q5TTlSQ0swb0QxRzhESUl5Z2lNMEtKTFZ6TUhhQ2NsTSthNVF4QjNKQnZZ?=
 =?utf-8?B?eHNaUUlORmx6dFZkU0lCU3JQWGFuT3U3S1V1ZTRLWWFyUjNvb1Y3bk9PUCtr?=
 =?utf-8?B?UkxYd1ZpWlN4cDJLZExLdjlYVWYrRmUrazVXVmMxdWxqaVRhdC9hV2lrTnlr?=
 =?utf-8?B?d3pGMUVpcFEvSHN6VjJVbkltanZDeTVCVHRYMzVwN1k3SXlXdjkzK1d4c1g2?=
 =?utf-8?B?aXBWWjg0aWRTMytUTTdvdjROUnVOVnRMNWZYMGlXVFNRcVZQRXBLcEZWcG43?=
 =?utf-8?B?V2cyd1ZGMlRpTUZBaFpMUmhrUTZ3eTNoeUZOcGdqTi9qMW9aOEh0WGI4bXBI?=
 =?utf-8?B?dDBMOERLOGFQaFYyeGE0YlpQTFNyTnZyalcvd1dQdlNvd20vU2JQdlVDN0VP?=
 =?utf-8?B?T1paczVTRFd6TGxZckN1emwzR1JxOExjYjJzdnNUdDZITTNxRkcycm8rRDdH?=
 =?utf-8?B?eTh4a281dFc1UWV3ZFpaQlpUTzBseUQ0bW0vaEJvbWpCSldIMGRQUnFQSHYx?=
 =?utf-8?B?YnNWRlhnVUU3NmpFZ05KbmFTamsxbGg3TU00Tml6VytFcWJvTUFjYnZhVC9B?=
 =?utf-8?B?MGF2c1hRL05OMEw2a2ZlU3VPN0thMEFKb1BVNE9kc3ZsMmNOMEdjN0hRNFB6?=
 =?utf-8?B?RGNnTzJLaGRjV2s5Yk9WUFNCSUhFeG4zRTRyaXFxL01WdmV5akFTUTNReU5D?=
 =?utf-8?B?RkJqMkJTM2tHLzhWRExESUFpQTUwQlBNd3FHLzI1WHZ6M0pWVXRBU0craCtE?=
 =?utf-8?B?T3NYV1VCNjBjcXpzSzlsV3BmdDhQVDhINzJLVHRucHZkSDVOaUtWVnZCSG1E?=
 =?utf-8?B?L2lSekZDeS9jV1d2NU1OMVlxaEZLODQzWXR5NXErU3luYTR3bDA1U2dmSHNn?=
 =?utf-8?B?bnRmRTZnTjk0U3ZYU2pZem80QkxMR1Nhc1pwcnhSdkxoU3FidDI0cTFsU1h2?=
 =?utf-8?B?ZGQzL2c4cldKU1VSaW4vVnMrWjlWeGY2dS9EYUZ0YTBoOTN6WTB1Z2F6WXVS?=
 =?utf-8?B?eWNuNU1JZ2Y2QmlKTFdUMmIwMml0eU9kclNCeTNGeE9Cb1N6OEdzalk3UjhD?=
 =?utf-8?B?Z3l2OGNWZDJUVzBxU0tjbHdWeXYrcjFrKzY3WjRYd211QUM3c0VsdSs4VCtQ?=
 =?utf-8?B?Um0rR1B0ajN3NG02RFY5WmVYOTY5QThWa1I5U1hXODNZWnZSN3VSdUlORXBk?=
 =?utf-8?B?d3pMWlhLMDBhOFZ2WXZneEF1V2tFRW02K0hYNUlBM1pwZGxRZUx5a2hkUjlH?=
 =?utf-8?B?RXU3Zlg1dEs0emd4Nit3MVlnRVltZXJycnFscDI3ZE11a3c4ekxIMmRndFJr?=
 =?utf-8?B?UWFDcGdBd1Q4Q0hpclBkZXpmZkFGWlFJZU53b2ZLMHZVSm0wL3RHdTlsVFp1?=
 =?utf-8?B?UFlHTDVRdURWNTZyQVhwS1FJdTUxOVB4RmFYS0hLMFBjYm95dXlwemtiM0hn?=
 =?utf-8?B?RWdBVytPLzg5c3lYWitVUjE0MmhHbGFaaHNsYzh1YUtOY21lVnIycEVvejFJ?=
 =?utf-8?B?a0c3UENjNTF1VFdrZGpJRU5oV1YzZk1oNXRJd3JGMnRxYmYwTE5HdlpmbU5o?=
 =?utf-8?B?bVYvYzNweVRFNTdSUEcreDY5L0RQWDl1dHFNbE9QdndFTHdOWWZEU2wwR2lx?=
 =?utf-8?B?RC81NlU5eXZiY09PVHlhTkpIUkRVMjhEMExIUW01YUd2QW1sdDdjYXFGcTlt?=
 =?utf-8?B?b1ZrUXFiRFlGK3hEYWVSWUVrSEl6emtyTGlEMHQ3TlloblJYVlk0R2h6RWpT?=
 =?utf-8?B?aE1paHFUbk4rYTZvR09jRVQvL1pVOG14QTNJMlJSM3JJL1NTc3BVMXdOWi8v?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VIPqaR2ACoMAO4LDxhIe4SSg5myJAaM2TOv1M302ojQxuXXST+HFluEhu6qFLw0d7h9LrJSdSpLPXWPar+eIga1Jcf2lmYLxnwn1CbX0z8njbQJQurpi+4vZ+ASJprIyo2wfxo97fZH/r+viobIk+NmZWHSSfirrDPislbhTIXxjt0qIG4zHEb9NGYPJy0Y1hZ+c9RzDSxf6Fy3LP/MKEkhhHvE1Vhldq944+I0+7BvBkTHcLU1Y80FdqHmqtKBw1WaAUseS1c9tiFjVKonpVM5XYp3C/s2UfQYPTm8uioRgXrkTrwjaTfpAwpKyXwT+XRgborRhi+SLX+GwMSk/HLgbuBY/C8iY96KGhRKe9irJ1u8BPtjr3+ZAY2YKFyssbMVffVZ1aWz660LEanXXldQPO+TSPIstQZw5yM5PzGXR7V4e55eR4PxZ98BdXWMf/V1Wf9GcmARyfbGHwtJoKfWB5qv0pytCgBnJ8mywbynuZDGKc8nqDoeuPqA/XHcRdHySYJsGl04CYSIPOMLVoUvc6nEnEM+sJvI1WUnoGj3LebEQWfm1O2Lz0HK43osEBuny77wW0F6zA6dvkPG5Em4cGIv6imKqLXgKAKngZ98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdce309-f7c5-4b44-dbcc-08ddc607afc4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:30:47.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WG5ENzdiTFRPpLQRcTsGM0+nkaNyNLCYusTqKubQXH4TU/y/FKamAn4lLxp9fZc0foXA7niXAjV/C4LGGcEEZ7VscSILBb02V+Dwti4ZkIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDExMSBTYWx0ZWRfX2OgH+731S7Iq
 QOh972VJ+wrDcyMOsKFH5AB5GaeFIELEqEvmyytoZ8RBy3PDgBWI0lxtMgfIMyERM5ifZGHkUyi
 MNz49LYgk+K5wr4fWwnuq5wsFTI2r/I/OgAJEXk1iYp1yii3kZQTHqhrgVksb+kFMENMcwPgSZX
 MYOEHvFjPtSQrZH3fCo77wE2qQvS2Uswk1s+OKR05we2MYXWt2fz49YDS04W6qHhlTahrDkPRUs
 o9Tf+lXeDgv6mdrDldRXQPwfwWcruWB3jPLF/Varibko90Ur6RDaTwazOJ1ufqgO1Ama0WaE6Ks
 YBiJrcdP4wtsIKg6I/boBjTP9agmU9w/8FnJ0yrj9LXUcqxqspHSecDHZ88s+A/HmNa9d0dIGvc
 6xD5I6T5AbPNxZ500xcemgdQ3nu/4GhNcNwuBhJzhchfRCzE1YaVAZg7cewtD2a4EGqtERmz
X-Proofpoint-GUID: 6fVQtpSiJuQmVJLIZQvEhLMGIKbEMzOn
X-Proofpoint-ORIG-GUID: 6fVQtpSiJuQmVJLIZQvEhLMGIKbEMzOn
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=687a5a9b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=VNo3wiPjB74DXDgs9DMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12062
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/18/25 9:28 AM, Vasant Hegde wrote:
> Alejandro, Sairaj,
> 
> 
> On 7/17/2025 7:18 PM, Alejandro Jimenez wrote:
>>
>>
>> On 7/17/25 2:07 AM, Michael S. Tsirkin wrote:
>>> On Thu, Jul 17, 2025 at 11:17:05AM +0530, Sairaj Kodilkar wrote:
>>>>
>>>>
>>>> On 7/16/2025 6:59 PM, Michael S. Tsirkin wrote:
>>>>> On Wed, Jul 16, 2025 at 06:26:37PM +0530, Sairaj Kodilkar wrote:
>>>>>>
> 
> 
> .../...
> 
>>>>
>>>> Hey Michael,
>>>>
>>>> Sorry, I should have mentioned which series I am talking about,
>>>> https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-\
>>>> alejandro.j.jimenez@oracle.com/
>>>
>>>
>>> Alejandro said he will send v3 of this.
>>>
>>
>> Yes, I am working on this task, and expect to send the new revision soon. The
>> pending issue I am working to address (failures on reboot when guest boots with
>> forcedac=1) also requires a change in the VFIO host kernel driver, but I will
>> send the QEMU patches as soon as that portion is ready.
> 
> Sure. May be for now keep that as known issue and move on ? we can fix it later.
>

That would help. I am spending time on the forcedac issue, trying to 
rule out all the reasons I can think of. But I am reaching a point in 
the investigation where I'd need to ask for advice from the community, 
and having the code merged would simplify things.

So I'll try a few more ideas and if I still can't figure out the issue 
I'll send v3 with an acknowledgment of the limitation, if that is a 
viable approach for others too.


> Other thought (Again it can be separate patch/series)
> 
> Ankit's kernel side fix to support different host page table level is queued for
> next merge window. How about reducing MAX host page table level support from
> current 6 level to 4 level? I think this should help to improve performance
> little bit as well.
> 
> 

Yes, I have considered that option as the "fallback" path, since it is 
an architecturally valid restriction that should solve this problem too. 
My v3 wip branch already includes support for the HATDis portion 
(patches from Joao Martins), and I was planning to add the HATS support 
in future series.

Thank you,
Alejandro

> [1]
> https://lore.kernel.org/linux-iommu/8109b208f87b80e400c2abd24a2e44fcbc0763a5.1749016436.git.Ankit.Soni@amd.com/
> 
> 
> -Vasant


