Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D96C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 16:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tomBU-0000wY-NA; Sun, 02 Mar 2025 11:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tomBS-0000vb-32
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 11:28:54 -0500
Received: from mail-co1nam11on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2416::60c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tomBQ-0004tZ-0n
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 11:28:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5EFJgo3SMx5yVDwY+PVSkJ+0/H4GazMHhuPeAJv2acqegblCRdOjsJm40K2rQUYGvUj6GYlC0LidY8FMVMilGpnxm912IwtAzuUzj7v9S6OP0lsy4dtRDVqlMckO0tVZgHKM0mjba7/CNAQSeaKfUt4wlY4WmMD5OeyY5VCaMDJMnSOYyEqwutHSuM99h//1WrgWn+ZQh0Od+tZr1osok/h8CTaypXnZkeC2KhYGBEHTiuj0/otiQmV8LuelfFEl75ryUB8B5xwsvCBCrUyrhv2xkTxS6lY1mO6iqLlYrY80htUeOhL5Gd4D7yYEln023fBgfcG1OlcAcAgvC618A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF097eAFdxPY3aA1ppHihJV0+UsYJVGi7YyMHV0skNQ=;
 b=Sr+FPbFT/mkHQ7htGQ6kvixJ5tYDO0rcUpDCMGcVfI3FpWMxIdJcCcFf1F8xzGhCMHADSzGefhjiISYc5lUSOLkopeH+HYr+NEb67Rb7oYX4SC9v4jXO1vc17/XxCohxk5/7K2mDFhjPGmU6uKJlG0azh8e5DUe9GLzVatNY7jvcXCuyuZMIkUfCImBenC4WOu1z5Xt2lAl1NeASQF5YqKC7817TsywLs4NrIjYUkbSd1bLk1Rp/4uPLJCMb/JNVboBr09d5PyiQU0oTqFGWCgpteeW3m1kjVZzA8WWRdvx/U8hI+pQTcNlfMzqhOfY2K6CQzVzdEjW3o8ECyABVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF097eAFdxPY3aA1ppHihJV0+UsYJVGi7YyMHV0skNQ=;
 b=nV3fi58LMTqm+vdqi6jx739Ri2MAvDf2mts6r8z05NGhN6YPL5UC8ImZrCeiZrBFOLNAg16vcaWd/BxbcCpLZO1QMI2MHmq/2/Rd0jD77Wv+3wQg0V83iaA+3mn6rIeuZLJL2l5gwXNkqj6/Bx3EqNh+M1qhegskOt0OLmjhRiquXpMlIivDTB+qTSylS0qgVxsLfsFWRrzJEfa03rWpXCgV2W7Q+drmI701oTWdHzG4ejp9OvkFUmAzvLsJx6gb0ignwMvTSiByrIWXpAtH3RNopOKCMhatCnUfigodUBzdYz9Z9XiB1uL5ywOpnHgDHizGIBvKrxkmip+cvrueeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Sun, 2 Mar
 2025 16:28:44 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 16:28:43 +0000
Message-ID: <26407356-2b38-4d05-8043-7687b28ea2d7@nvidia.com>
Date: Sun, 2 Mar 2025 18:28:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <719b309bb7bc13542d14e6ce0026cb9bb67e9f31.1739994627.git.maciej.szmigiero@oracle.com>
 <d7a7c7ee-5529-4091-a241-6cdde9943a25@nvidia.com>
 <15742ad0-a5d6-4d1d-82f6-b3bdbc53746f@maciej.szmigiero.name>
 <605f8813-f57c-439d-8bd0-93c286464f8d@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <605f8813-f57c-439d-8bd0-93c286464f8d@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN0PR12MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0c24ad-b350-44a8-943f-08dd59a74c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkoveUcrdEo4a2k0eWxuRy9IZXZsWnVnc0d0c2tGZ0RNTjZVT1BzRzIxWTVV?=
 =?utf-8?B?ZXFNZndieFhaem1rUklQRXVGMUdDMnNubkxyQ1FPUENBTStBbEJRL0FrT0JN?=
 =?utf-8?B?dURaLzhWMDlIMVJ0MC92OVFOOG1jcUpGMms2L0QvcStiemllY0U1QVBTWUtB?=
 =?utf-8?B?bk05Q3k0QlJzYzdwZVVyL2tyWUY5QWR0OXR6cnVwK0UyV1BtOExsa0orQUlN?=
 =?utf-8?B?aXNSdGF3TXBEdklFVU1CZEFLY3RxS2k1NThZT1Q5cS9DSWRnTHBCalczbmNF?=
 =?utf-8?B?ZVVyeDZQVk9lRlpURE1wTnpZbENmYWJjQnhPb083emo3aHlQekdQRlFIQVBN?=
 =?utf-8?B?V2FCMHZxbEgvWnJYYzJ3OXRMZldFUmx0NFBvYkU4dlN1dUN0bDlyRnhXQUhs?=
 =?utf-8?B?RlRxYWlKb1VYdFh1YjlkbFpESVVDSW80VTdGYmEyZ2hUZ3E1djVGUGprWjJ5?=
 =?utf-8?B?R3JIbUZhMGd2Q0w0UWFSRFVsWkZTMVlvTVYyc0tLUDJvQnowT1lYdGppcjZF?=
 =?utf-8?B?TVBFZjhZbG1CeVV0cVZiMlU3QWJ5TFVmckxqZHBzSXVxcVJBMWpoMEVqeEFw?=
 =?utf-8?B?VGNQM21IdGFQdC85ZGNKQkM5Mk9EZnk1WlFoMXcvc2RhcmNQWk5Bekt2T1N1?=
 =?utf-8?B?K3BvL3cwNUR1ZmR6TEE4MStPTEttQlZHVnFvTktHZ1BQQjk1cGtLSUZTVm9T?=
 =?utf-8?B?TzdaQ2oydGZRRStHWnlnUzhCZ0JkMmt2REhEUTVreWdMejNUSSsyLzhlQ3Nk?=
 =?utf-8?B?Z0w0dFh2WXFIQ0lKQnlkZm1XN01kc2dlRWlCOWVSTzVoODBCQStuRE9JeUQ3?=
 =?utf-8?B?UlErcUlqV2hMd2V5dTBCWm16NGlOS2JrODY0b0R0dmpSN2l1S3EzbE5ZdVN2?=
 =?utf-8?B?cExSUU1CQUp0OE56ZEQvMXlJVXpBT0hVM2V5a1g5MUs3SENWUForL2prVU9G?=
 =?utf-8?B?ZEJFMmNzTU9zWHI1U3FBdEpKY25HcTdqeU1uakxiVU1JWnUwOVRqN3EzNkU2?=
 =?utf-8?B?TXJQWEFTbGtqSmdlN0Z6cVh1WFdIZDlkMmo4NkxIdFJNMldzTXFaZ1RWU2ZW?=
 =?utf-8?B?OWhkTSs1K0xYeFlkeC95bFAzT1hqSGhMRWlMaHhUcmNyRzhuK3JiTVpvZmxq?=
 =?utf-8?B?dGJYNDMreW40UFZUUVh0aW5WR2R5aXVjd1NxWG9talMyeCs5RGgydVlkWmtP?=
 =?utf-8?B?M0dEekVpaDBLUmxKQU5CTllkQmlubERyMUhKbzlUWVV1V05aMDZWZnFkTGJN?=
 =?utf-8?B?MXJFNlgxZFNKV3lVNU93c0hTYkVwSElWKzIzWm04ZEIvUHRvY2QrMWVMUXRh?=
 =?utf-8?B?TVZqK0dhcEZ5eVdtN0kvdjhBTmZETEtpUEMxMm1TbjdVa29LOWhDSjBKY2tu?=
 =?utf-8?B?MzR2blpBTTZXd0pDNTRKS3RlbVFKK3FBR2V5Vjd5UHVYLzR3cHZZcnIrSzV0?=
 =?utf-8?B?QTlmQUJHQlVTSmxoNnMvcSt6RjYxTkV6WEpDTldKWlk5UzkzNTRVUllkRzVz?=
 =?utf-8?B?eGNZZHVKOStTYkg5RURwRU1FeVBsWmlHVUhsL2dEcnd1NFhVTWRXV1ZsZDYy?=
 =?utf-8?B?ZzRjSXJOdCtsZVBIUU5lWFR2VzBkcTVrZEtUZUhSK0R0OHB6blZ5VjlVOFIx?=
 =?utf-8?B?RFRBZEtrbU5VdzV5Z3NsVWFPdW1Ddmw5Y3dEMDdOUS9oUUNqVDFMVTdaQytC?=
 =?utf-8?B?WWozaElYZU92RkdLenl0T1NHbHVwYVdubHhiWjZ4UGdZY0hhU20yakt3SnpD?=
 =?utf-8?B?R080dCswSXFxVWlaTm9PNUhXa3hhMHhzcnJpdVFKdXpUVEhPeTdPUE5pVjRl?=
 =?utf-8?B?NWQ4aTJJVU55Zlh3VHdlM1Z0VjlPOU9vNTdjbHk5RndBcEp4Ti9yWVVJbm1S?=
 =?utf-8?Q?KdrgK8rTfdmlJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUd6cDErMkNqLzladDFGV011aVhXTzg3cWU2RHZZUjhuNWJQUFRzL1BYLzVx?=
 =?utf-8?B?Z213Y3FYbmZtL0xVNzNXNDlFUFNEczNKbGU0dVFjdWM2OGFqTllGVk1FdFNk?=
 =?utf-8?B?V2lPODB4eHNCQVRCM3JSdnNLNlE2aHptNGJhTExMTTAybkMrdTBGQ3RSUm9o?=
 =?utf-8?B?RWtTMEd5Y3NiK3QzRG1FM0dZWFJvL2plcDBUdDNUcXFsdG01bXpKRFppbmRS?=
 =?utf-8?B?L0Urdlh5bExZOXBaN3FYcmtIRTJxcnlGaXl0RC9JNnVUQ3pQRVVDVWpaU2N0?=
 =?utf-8?B?YjJ1alpQRmxudC9sVUc1aDdkN0JKOHBxb0hJSnQ0b3J1SFVkYW9BK3RoNmlr?=
 =?utf-8?B?ODF5Y3NnSXQ3RTVQdDcvVlhkSjRjMVJJMGltYVowcDg3L1hiNmxMem9KYjVi?=
 =?utf-8?B?VUtudVhOV2xTdk04ZVh4VXl1WC9sanliOFQ5UWpJUTl3YlJBdS9IVCsvV0NF?=
 =?utf-8?B?TituQ0o0R3VpTEE3ZkY0VXp2M3ZUS3pkTU0vR3JHN1NSWEVKc0FuSVY5cTkv?=
 =?utf-8?B?aEZyN2tYMTRKUkJ0d0ZHKy9oSUV2M0VmQW82ekZiSm8zWnYya2VCMWJDdTlE?=
 =?utf-8?B?MktyRFZUbk1jN2hHYXc3blRqZkJqYUxWT1VkcU16UUs2bC84NlBzTEtKaGVq?=
 =?utf-8?B?Zkw1TXhlZjI4VjVCVkc0RTZlK1RTRFM0L3hTejhKWTYweEV5RlNpTFlCSUkz?=
 =?utf-8?B?R25oamxCTzFhT1J5WG5NLytIRXNMVDdhMXI1d2R3NFc2ZGNpcXVCVXFkSXRm?=
 =?utf-8?B?UXM2KzZ6RFdtcDZqY2d0M3JDcEVRbU9Kc1dCV3hnUmhpakZyNHNPWFMwU1Nq?=
 =?utf-8?B?WXBUVEJpVlI3OEtjbEo2cmRFczYwOU1OUkVMeEQxemVCSW4wdW5zOExvbE9h?=
 =?utf-8?B?UnpjQS8xMG9WZE16K2RvbjdqRjFINjNITENCWkt3dmZvQ1FzejBQTHcxNGVk?=
 =?utf-8?B?Y3lrVTRYb29Yb2U1L0x6bzdhcFJsZFBUT3ZKTWd4VW5KaThGTFJZbU90TkVh?=
 =?utf-8?B?WGFySnAra0ZRUWE3T1MxRGd5YmJiMkNZOWtRcUpLUTEwWERCaW1xN1hPVVg5?=
 =?utf-8?B?VFdVdGNKU200ZkJJNzB2T0ZRajVGUWk3bjM2cldiSzhhQSsxbHJPRktmcEJ3?=
 =?utf-8?B?d2lueStNZlRNeDJIRTlSRDZGRHRvaWRjK2x3eEhQa0hRTHRtYzhDVnBNK1Jj?=
 =?utf-8?B?SVIvakRCeHRhL0V5dGJRaEZxeWFsVXZDRlE3SFprWjQ3cXVLWitpVDB4TXpW?=
 =?utf-8?B?RlJNQTN0QnJaeWcyd0dWUzhFVFVhRHlIa3ZCOTRMR2tpVlBCM2xYTi9Wa2N3?=
 =?utf-8?B?bmd6dGNmb2VHaGhFU0lnRHFKQzllTWV1dHdKRnZXL2pWeFZvN3dMTnMvU2hV?=
 =?utf-8?B?VGZuclp0MXZUckRPQ1M3aGhyK3hvTjlYdU9FQUZTWWYyemZQZEdOaUlLRnFD?=
 =?utf-8?B?cGZ1elhYYk9IRWdub0NyV0wrQ2hhQjFOQWl6Y0dnVVE0bnB4dVN1WUZZcmFr?=
 =?utf-8?B?MElJSnNUTUlXeUJCMGpqaVdmZzZud203Z1FNZ2VzK24yWWRNUjZqK3dEOFBt?=
 =?utf-8?B?aHZ6aUhTRGNBdzhUVXgyZHVqYWNOVWN5RjNMTng2T3RnWWU1S21WTlFqL05o?=
 =?utf-8?B?QlNtYnkxZTdwRVBFdzFqT20raWtubGt2R1Y4REFnMVNqeENmREYvRzd3T0VH?=
 =?utf-8?B?d0dlYkcxTnAxTnZvaHZVem9qUGRqSjI3Z2FCcFpycSs5QmliczhsUkd2V2px?=
 =?utf-8?B?b0NLNWN0TzRIT0RXVDlFVWJwMWZtclZ0Z2tjRy92Ri85QlhtV3BDSnZDTnVv?=
 =?utf-8?B?ekl4Yk9xOWxybi9QeVdYSTBuRld3cHpaN25CcDRNQzZjZ3M4NEJ1QVZWeS9S?=
 =?utf-8?B?SmI2aEI0QW0vQ1I1dlYzN0NrNzFNZ0toNGk5TjZQQmREMk52UDdaZy8zemJz?=
 =?utf-8?B?bVR0d0pNTDI2M2dXTGRiQ1ZEUCt2TU1VUHd4blA2SWNlMlIxcVJSdEVmRkxP?=
 =?utf-8?B?RThMVHFxOFlzVlBPaWxBY1RZRkRGQ1ovYVhic2ZOYWhtajAxL3RqOWtWZGZW?=
 =?utf-8?B?TFNmVGVRNzdGeG1yQ052VFpwVk9PTzFPMEVHWW1ScVpFVng0K0lDYWszTHNa?=
 =?utf-8?Q?hL5Jicof5E9yg/qToX06b/J3H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0c24ad-b350-44a8-943f-08dd59a74c96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 16:28:43.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/QjHJPN7FnIAJ1AU2KwlrI58xEGWNu9e26QL7aWm7GpvxDMTguu/76jSE58loso8l5txOh9/Z7k33gjgTilEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
Received-SPF: softfail client-ip=2a01:111:f403:2416::60c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 02/03/2025 16:59, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 2.03.2025 15:54, Maciej S. Szmigiero wrote:
>> On 2.03.2025 15:53, Avihai Horon wrote:
>>>
>>> On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Allow capping the maximum count of in-flight VFIO device state buffers
>>>> queued at the destination, otherwise a malicious QEMU source could
>>>> theoretically cause the target QEMU to allocate unlimited amounts 
>>>> of memory
>>>> for buffers-in-flight.
>>>
>>> I still think it's better to limit the number of bytes rather than 
>>> number of buffers:
>>> 1. To the average user the number of buffers doesn't really mean 
>>> anything. They have to open the code and see what is the size of a 
>>> single buffer and then choose their value.
>>> 2. Currently VFIO migration buffer size is 1MB. If later it's 
>>> changed to 2MB for example, users will have to adjust their 
>>> configuration accordingly. With number of bytes, the configuration 
>>> remains the same no matter what is the VFIO migration buffer size.
>>
>> Sorry Avihai, but we're a little more than week from code freeze
>> so it's really not a time for more than cosmetic changes.
>
> And if you really, really want to have queued buffers size limit
> that's something could be added later as additional
> x-migration-max-queued-buffers-size or something property
> since these limits aren't exclusive.
>
Sure, I agree.
It's not urgent nor mandatory for now, I just wanted to express my 
opinion :)

Thanks.

> Thanks,
> Maciej
>

