Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48562CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untcF-0007HM-Mb; Mon, 18 Aug 2025 02:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1untcD-0007Gv-Ed
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:45:09 -0400
Received: from mail-bn7nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60b]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1untcA-0001ky-Ek
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:45:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR1GonPJr7wPRWYtztb8L6N6U+ZBj799XoCGQkfExxUtN94i2XAbe0piyveFOiJktbJOpwa+ArYThD7MmtADqpBCGqqj6lM3I/+gW0L8fc6YgGzZsi2PiGVJFc3lDwh8Kp1Q7NgRrAr5+eXqHji0lKpXnVtYWOAeIYSGLoP9KkPy6fRQPyxRIcZAOwXdbojETtgcCWXVHsfq0vwiKfWbnfM/mE+6f0FqfISN586LZ73Fb6rh9Qp2c83XdTzezix04DPiDPptgun3970uOFZj4xSGRAqp+EX6WNR9IMc/h8uZZr9thDpA75fo+K8Y7nG3+PNoxWPX6xDnSz1TOiOC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1UL2gFtrvQRpSu/G22m3rUAI3KvdTuiNbl5X+ubFIc=;
 b=dqaue1nq01m7OQP3vTlJhbvNlBeGONcPN+m3DZ5CyrA5JWNxxX2MiiA0RZsICuvEiZr1tj9vC4EVm6ODAoLYbVXVYxYuwkbjiXDXeoMNdFbgAQ3RG/DGY62Cr7sOVgCU0rapvVB8qAJ/Iuvwe8wGIIU5FUiIdvNOHWXUCVkZy17iQ7RVmN2scbP+0NBiAUHJwQaHnoXbcnH/UPqjAvMPMS5ga6T3GhBakNQkdGqUfru+faKw/93DlNufks5lJ4TO048jFee1VJU7fSu+I1s96kgbwPZenQmk4cjnYJLep5vOksOBmis9aQGUqhMjnnza32bOp+mdF5ay24e+E4YG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1UL2gFtrvQRpSu/G22m3rUAI3KvdTuiNbl5X+ubFIc=;
 b=t9mu+E4sLjdauqDh6FHJq0UA1Zn919QUFJmRz4kQ6uqzYcPLvwLrWcsa+q8WNRQF4GS2E2JQPJ/KTVoujACMSY7U/1Mtgc0duKZIvcCYGyvtN83Y2Pp858B2FRhn4fV/rly0r59+5ymhvE8I8BZFeywU94Z/8OtRvrh6o8BT2nCPXDrcXRe2jPNcvUHNqAB+nOgbiPsW9EcHrsYApP02Ki8VMn7YrlaEYT8B0SjamsSkR530ODEvcnvATGK2+bg/M5dLl9Pln6IBPsyOzce3kvkO1hyQaPmdPIm4L4v8R0cHg9jj3ilRbWpQU3bqcvsVuZGW7cWiSk5SlUR0fy3LXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 06:44:59 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:44:59 +0000
Message-ID: <98ec2c87-f35d-428a-8ed5-2f4f9a2ac9d9@nvidia.com>
Date: Mon, 18 Aug 2025 09:44:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] VFIO migration will not be aborted in a corner scenario
To: Kunkun Jiang <jiangkunkun@huawei.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>
References: <6f64724d-7869-1283-bb75-193c7fba5576@huawei.com>
 <f6c1cff4-a0ca-436a-b8d7-3d19ce49e848@redhat.com>
 <506cab2c-35aa-4c68-ba94-b26ba1b315bc@nvidia.com>
 <a737f734-e899-d544-19c1-08a93e3c50ea@huawei.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <a737f734-e899-d544-19c1-08a93e3c50ea@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 983adec1-f15e-48a6-c975-08ddde22c043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEVLUVJzbXlydE5nUW9oNWxWaHR1OTcrcTlaWlB2OWdMKzlPVUp3RmJMSWVN?=
 =?utf-8?B?VEZUUHBLbXkvQ2g1OUZFT3ZYRWxCT3h1SUg1UHlVa29Wb0FjajZnTHNPdGhs?=
 =?utf-8?B?SjIxV2VLemJnZnhacktYZXk4LzF1dGtDSm9CZ0l0Q3k3eFVndkxEWE14QlEw?=
 =?utf-8?B?QXUyOEZEOVFmUnYzemlnVUdHL041T2NOQWdTaUYwVkNQdTRzYlRmZ1ByTm9v?=
 =?utf-8?B?ZnhOUjVaRThodXBnUHVFVmxpSGxWOGV1YW5UMHRQVytITGJqV3hXdDd5alJm?=
 =?utf-8?B?VzhyTVJEaU14bCtGRWd1TTg2SzBMSkh3VVFwZ3lGZndQN3ZZOEJ3NEFUS1k0?=
 =?utf-8?B?T284L3Z4UFNieTFETGJOcnZweDRIVTF3MDc1WGRzVlducngxL2FXYXU2dW14?=
 =?utf-8?B?VDJVTUsxUGY4Umw5bWhFdFREOTltV2VDT3c0amlvU1RLTExEcHpmd08ydUJy?=
 =?utf-8?B?eHNzRnIwTFNwWngvaHZLRG1acFVnUUYxb2FlbGI4Rm5JVElhdTJhUXgvdDFJ?=
 =?utf-8?B?dGVNNFVCUWJMT2w2a0VSR0pqS0VOOEJmM1VibVptazBpdTNGTS82UEF0RWpP?=
 =?utf-8?B?WVRDTTh5VTFpRTVWWWQ3bUJ0ZStDOHdlcURsN1BQR0Q2Wi9WREsrb2greXIr?=
 =?utf-8?B?bTNsMlVmTTViVkl5V3BWeXNDUitrbURzdklKaTZpSFo2NHgxSWRhZkduL3NI?=
 =?utf-8?B?NjdKSFFJZWV6bVlvQTFhbDVyYjlVaUhTMk1zYzRWTkJ0TWVTZXduUnltdE5V?=
 =?utf-8?B?L0NScUVlanRMRVcreTFLRXRTZW0vamU1cDVxV2lkZGx0RGdLcjFHTXZzNzdP?=
 =?utf-8?B?WTRKczVLTWVySWdtZzdMSHdEWERrTWNFQTArVVl3Z3BHQTZBRXI1YTJ0c3E5?=
 =?utf-8?B?bldFUEFWT0ZyZjF5NVo0ME9TVXlpdXlCM2V0dzMwcjNKeWxobXFDTDhsdmFZ?=
 =?utf-8?B?TlVKRTJ5MFRsc29kZnZCenpncDFWTmEyc2FqZERJWDlEbys0WklTUWFnaG9v?=
 =?utf-8?B?OUNVay9BdXhRY0p2aXY5ZStHeFl5Lys2Z2VEQUNJMDNCUFFIUEhpWldtKzZT?=
 =?utf-8?B?YkxqUTREeVk1cVMxekN6Y3NxZUtpUTZSL1JhaEFsS0hiVGVNM0NJY2NqSExN?=
 =?utf-8?B?NGtFYWQ2WDBmVXpXdVpjVWF5T0I1OUF0QW9nWEc2T1BLWTBxV2Zvc2JMRXhX?=
 =?utf-8?B?cXNhSHNyWkJITEtnZ1BTK3Byb1BrZnpYblFhKzVHVmtYUS9XZDAxT0FBZWZx?=
 =?utf-8?B?elp2YkRRbUJUV1Yyd0QzZlRWTU1OU3N1bTZydWRZbnI1ck10ZHRoZXpoZ21D?=
 =?utf-8?B?QnFnUWVJNmJlcGNlM090Um1SU0k5YlVxZGtoZjRTZDU0T3ZLNStlRU5IaEhj?=
 =?utf-8?B?akxNNkZXVEdiWktOaW53MnZUQy9qai9NZjRLMENzVG1LUm9iYXRFUWNPWUZW?=
 =?utf-8?B?UTZYaUJyeHFrMFU5ejlIMVVCajRBazRZcnpmRlJXY2oxR2lBOU1wQ3hBazdD?=
 =?utf-8?B?UjN1UDNRUHVRYXltUEZPblhtZWVqUU9FOG1JYmd4c0ZwRWp5YnVnTEdRbE9Q?=
 =?utf-8?B?c0Z4YnI5VjZseVc4ODBHSzFFVmJ3UWxtaVk2cWVMWWphSENyQXY0QVhJanQv?=
 =?utf-8?B?Qmp0T3RjRVZlZ1Y0bUpEUk1iZ0lrMEZ3aEpmTFdDU0svSEo3TEcybkRLWjRN?=
 =?utf-8?B?RDdIeXdvdEJzMVpsK1g4eXR6alF6WG1RUlRoLzQ4b2xKc29sUzFsUFIzYTFJ?=
 =?utf-8?B?bnZLTjJjVXF6VC80K3pPVnRJWXB0T2wrY3FNYmNpV3dDc2QwUk1vQVBLVmtn?=
 =?utf-8?Q?4D/Rm0PJ3gSf4TnjLC3kc/WJzv3Csf5s8Nx7Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdYRHBlOFJ0cXk1S3pOV0ZJKzhReS9QOUovZWxzQmZxbzdaU2R0M0U1b3cz?=
 =?utf-8?B?akhZSEd3cUNHYkIrZzM3a3EvYU5ycXJ2K1l1Y2ZjODRoVVJodHVBLzRXV2RX?=
 =?utf-8?B?V2xRTm9KY0wweW53TmxPS3R3ZjlQcUtndndOK0M0cnUyZnBUMmJxanIrWkdp?=
 =?utf-8?B?azl6K3dSaDc1U3Z6cnJXUlh1MElZTW91Q0d3dkM5VmErSm1nTnlRa2x3WEg1?=
 =?utf-8?B?VVhuZC9wTDU5bk9yT3c0TVh5bDVSN0EzYnBvWnpZdFdJQ0VoRWZ1aFppeHgr?=
 =?utf-8?B?aEE2NXhKQUh5Z3MrMlFKc2MxUnQ0dHZldXI4NXFqZm1Cb2NwREhsZmgxbEFM?=
 =?utf-8?B?ZDRBN1ZIT1BzcnlmOG1FVzljVlBLSW0vSlZYOVFFRTZVWGtuSDRnUmlzWWJJ?=
 =?utf-8?B?bkhKR2JTcWdWR2EyUjBHSHE2ZGJmOFFZSk9TbnpSeVNZWi8zOEtHNHpTc1hJ?=
 =?utf-8?B?b2IraFd2VVdDYmVOVGVEQnJacVZPbUV2VlByVkxtZDJ2UVJ4bmpPWU9uSTZE?=
 =?utf-8?B?RWRUTWVsMDhTTnpZUzA4S0RtKzZKT2RTMG9wUkYrK1pGMEtOTHNQcTBMQWhL?=
 =?utf-8?B?VytQbTN4OWZRTC81Q1FHc1dRTFNZZTNmZWNLQmxWWWwydjlRUjlUWGhwd3BP?=
 =?utf-8?B?MTNQQkxpbHZ3Y0hONzZORlhFZCtVMVpBVFpYaHZDSFZXdmpQMVpQQmE1WmtH?=
 =?utf-8?B?cDd2QmFBZjRjT252cHdqVC9LN1lwSWlCZ0ZWV2cydUtyMWZ4ckMxMjNyc2pv?=
 =?utf-8?B?OUJ0QkVRYkt3QUx4SytEY0VGakpBbHBYWTVRYURJWWhhbnRZV3hOQmt5TnA0?=
 =?utf-8?B?SGhiYU1vZHVIaUxOREtKOVZMT1NmU0JTTzN1SHowK1Z1ekZhMk5IeWM0cmZS?=
 =?utf-8?B?UVlnTFVyNFJmdW5GTkRiT1A2NjRLV1NqaTg3VWJXOFRjSU01bFhNcXpmb2hh?=
 =?utf-8?B?c1JsUnJlNHErMmpIS0VsK1lGRHd2TmdJcG5SUDRhREZqMnlkeE55STR6Ti96?=
 =?utf-8?B?bkd0Y0hRbTNyZkUwVDEvaW9oa3hyOUUzNURkbkFNMWZHS2ljSnZRbG9oYWFT?=
 =?utf-8?B?cnBtTGNPSU04djNTY3JWN0tpdEp3VDc0b0lFVWJNYkw3SWRnb1d6anhEeTJI?=
 =?utf-8?B?by9hOEs2OGJlelhuWitHZGg0VlhjOGNUcUQ4SDFxMDRQY0NQZEVUQnU1NWpw?=
 =?utf-8?B?TVVyNkhEZ2VkNlV5STE0YlJ0K0JQdHJ2WXF3ZHcrN1BOUHViTUNlWlZsK1Q3?=
 =?utf-8?B?bjdubkF5cndLVGttZjQ2ODY0cm0rYThabzV4WU5ZS1g5UHN0YjI2MGxxYlB3?=
 =?utf-8?B?akFMTitYZW1SeVl6MW5pMFUxaGpvNlVuK0VPekY3SkNMbUFKSHBTdzhwZFhm?=
 =?utf-8?B?SC8xcExFaDBiSnVvcGlWK3JNMUFmMzEvR0tDV0d0bzNTZGF1aUlIV2tKMkxT?=
 =?utf-8?B?TUdoeVc5UHBGbEFEbHdSODhEL0FtaktHcmJwVHVDd25rSFZJSXBzT1RHZEEv?=
 =?utf-8?B?eWJ2a3NqbVpXS1JMM3JOcWJ4K1JzZmFOdmdZbi9qbTlPMUFwV1lleUU3Wmx4?=
 =?utf-8?B?OE9iVitWMEZ5TTdmY3VRSDNlbVhCM3RkU2xORXZYais5bGZmZzBpN25pL3Er?=
 =?utf-8?B?YXFKNXppZ3RtK3VoaVVDU2xLMjRuV2hoN0RmbW9JTVBtMDVKQWxKRS96YitV?=
 =?utf-8?B?YS9HL21YVEVNMVlkcm9oZU1wY0c3eENWQit3KzczeUNrOUFZOUN2Z0lqU2ll?=
 =?utf-8?B?RzJWdmVvRmwvbklYbG1xWExvQkN2TW02UzludExtVitkK2l2a3dMMlB3N2h6?=
 =?utf-8?B?NXhqeC9pTzNUM1BUVEFPQkMyUFphbDN3N3BtZ3JuTUNFaTBTM3h1VVVPNVZs?=
 =?utf-8?B?TWQxb0t1ZXZicGo2WnUvSjczSzVDOUhuZk8reVZBUFpuZDRpamJvaDZwMFlO?=
 =?utf-8?B?TEF4YVB3cDdiejQwR1VWR2pVcmt2MzY2RVYwV1A2UVZnVlVXM1VoU2R0dFN0?=
 =?utf-8?B?RGFHVjZPWlpsZFNLQlJ1ZTVJQW5DR0RTeng0RzNDYThpTDR6RWQ2UXp3WjB0?=
 =?utf-8?B?cWd5a1VkV053TU01T2dzS1ZpVVBNNUowZTZJNXc0VHBZR29nSXRjWENiUk5C?=
 =?utf-8?Q?iNoXnIjLY95lrYCdmK0D59Qr6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983adec1-f15e-48a6-c975-08ddde22c043
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 06:44:59.5526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePAAU7XonKx2tonPi0U0MjZiyJs1Lk+FDKgFf9D+/uh9riy3PMvKPDzvYr99YMyTnjYClIAaLV1Qp0SdVf02QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
Received-SPF: permerror client-ip=2a01:111:f403:2009::60b;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1.376, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 13/08/2025 15:18, Kunkun Jiang wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Avihai,
>
> On 2025/8/12 22:08, Avihai Horon wrote:
>>
>> On 11/08/2025 19:34, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello,
>>>
>>> + Avihai
>>>
>>> On 8/11/25 18:02, Kunkun Jiang wrote:
>>>> Hi all,
>>>>
>>>> While testing VFIO migration, I encountered an corner scenario case:
>>>> VFIO migration will not be aborted when the vfio device of dst-vm
>>>> fails to transition from RESUMING to RUNNING state in
>>>> vfio_vmstate_change.
>>>>
>>>> I saw the comments in the vfio_vmstate_change but I don't understand
>>>> why no action is taken for this situation.
>>>
>>> There is error handling in vfio_vmstate_change() :
>>>
>>>         /*
>>>          * Migration should be aborted in this case, but
>>> vm_state_notify()
>>>          * currently does not support reporting failures.
>>>          */
>>>         migration_file_set_error(ret, local_err);
>>
>> Hmm, I think this only sets the error on src. On dst we don't have
>> MigrationState->to_dst_file, so we end up just reporting the erro > 
>> But even if we did set it, no one is checking if there is a migration
>> error after vm_start() is called in process_incoming_migration_bh().
> Yes, that's what I mean.
>>
>>>
>>>> Allowing the live migration process to continue could cause
>>>> unrecoverable damage to the VM.
>>
>> What do you mean by unrecoverable damage to the VM?
>> If RESUMING->RUNNING transition fails, would a VFIO reset recover the
>> device and allow the VM to continue operation with damage limited only
>> to the VFIO device?
> I didn't express myself clearly, let me explain again.
> In my test, I ran a task inside the VM that was using this vfio device.
> In this corner scenario, the task is aborted immediately and the VM is
> still running normally. I mean it is unacceptable that the task is
> aborted directly.

Ah I understand.

>>
>>>> In this case, can we directly exit the dst-vm? Through the
>>>> return-path mechanism, the src-vm can continue to run.
>>>>
>>>> Looking forward to your reply.
>>>
>> The straightforward solution, as you suggested, is to exit dst upon
>> error in RESUMING->RUNNING transition and notify about it to src through
>> the return-path.
>> However, I am not sure if failing the migration after vm_start() on dst
>> is a bit late (as we start vCPUs and do migration_block_activate, etc.).
> I think vCPUs have not started yet. vCPUs will be started only after the
> all callbacks of vm_state_notify are executed.

Yes, in that case need to refactor vm_prepare_start/vm_state_notify to 
handle errors. May be a bit involved, need to further look into that.

Thanks.

> If there are any problems with my analysis, please point them out.
>>
>> But I can think of another way to solve this, hopefully simpler.
>> According to VFIO migration uAPI [1]:
>>   * RESUMING -> STOP
>>   *   Leaving RESUMING terminates a data transfer session and 
>> indicates the
>>   *   device should complete processing of the data delivered by
>> write(). The
>>   *   kernel migration driver should complete the incorporation of data
>> written
>>   *   to the data transfer FD into the device internal state and perform
>>   *   final validity and consistency checking of the new device state.
>> If the
>>   *   user provided data is found to be incomplete, inconsistent, or
>> otherwise
>>   *   invalid, the migration driver must fail the SET_STATE ioctl and
>>   *   optionally go to the ERROR state as described below.
>>
>> So, IIUC, we can add an explicit RESUMING->STOP transition [2] after the
>> device config is loaded (which is the last data the device is expected
>> to receive).
>> If this transition fails, it means something was wrong with migration,
>> and we can send src an error msg via return-path (and not continue to
>> vm_start()).
>>
>> Maybe this approach is less complicated than the first one, and it will
>> also work if src VM was paused prior migration.
>> I already tested some POC and it seems to be working (at least with an
>> artificial error i injected in RESUMING->STOP transition).
>> Kunkun, can you apply the following diff [3] and check if this solves
>> the issue?
> Ok, I'll try it.
>>
>> And in general, what do you think? Should we go with this approach or do
>> you have other ideas?
> My current approach is rather crude. As I said above, I think vcpu has
> not started yet, so I changed it like this.
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4c06e3db93..70ccb706c6 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -878,7 +878,7 @@ static void vfio_vmstate_change_prepare(void
> *opaque, bool running,
>  static void vfio_vmstate_change(void *opaque, bool running, RunState
> state)
>  {
>      VFIODevice *vbasedev = opaque;
> -    enum vfio_device_mig_state new_state;
> +    enum vfio_device_mig_state new_state, pre_state;
>      Error *local_err = NULL;
>      int ret;
>
> @@ -899,6 +899,10 @@ static void vfio_vmstate_change(void *opaque, bool
> running, RunState state)
>           * currently does not support reporting failures.
>           */
>          migration_file_set_error(ret, local_err);
> +
> +        if (pre_state == VFIO_DEVICE_STATE_RESUMING) {
> +            exit(EXIT_FAILURE);
> +        }
>      }
>>
>> Thanks.
>>
>> [1]
>> https://elixir.bootlin.com/linux/v6.16/source/include/uapi/linux/vfio.h#L1099 
>>
>>
>> [2] Today RESUMING->STOP is done implicitly by the VFIO driver as part
>> of RESUMING->RUNNING transition.
>> [3]
>>
>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>> index e4785031a7..66f8461f02 100644
>> --- a/hw/vfio/migration-multifd.c
>> +++ b/hw/vfio/migration-multifd.c
>> @@ -267,6 +267,12 @@ static bool
>> vfio_load_bufs_thread_load_config(VFIODevice *vbasedev,
>>       ret = vfio_load_device_config_state(f_in, vbasedev);
>>       bql_unlock();
>>
>> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP,
>> +                                   VFIO_DEVICE_STATE_ERROR, errp);
>> +    if (ret) {
>> +        return false;
>> +    }
>> +
>>       if (ret < 0) {
>>           error_setg(errp, "%s: vfio_load_device_config_state() failed:
>> %d",
>>                      vbasedev->name, ret);
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 4c06e3db93..a707d17a5b 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -737,6 +737,8 @@ static int vfio_load_state(QEMUFile *f, void
>> *opaque, int version_id)
>>           switch (data) {
>>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>>           {
>> +            Error *local_err = NULL;
>> +
>>               if (vfio_multifd_transfer_enabled(vbasedev)) {
>>                   error_report("%s: got DEV_CONFIG_STATE in main
>> migration "
>>                                "channel but doing multifd transfer",
>> @@ -744,7 +746,19 @@ static int vfio_load_state(QEMUFile *f, void
>> *opaque, int version_id)
>>                   return -EINVAL;
>>               }
>>
>> -            return vfio_load_device_config_state(f, opaque);
>> +            ret = vfio_load_device_config_state(f, opaque);
>> +            if (ret) {
>> +                return ret;
>> +            }
>> +
>> +            ret = vfio_migration_set_state_or_reset(
>> +                vbasedev, VFIO_DEVICE_STATE_STOP, &local_err);
>> +            if (ret) {
>> +                error_report_err(local_err);
>> +                return ret;
>> +            }
>> +
>> +            return 0;
>>           }
>>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
>>           {
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 10c216d25d..fd498c864d 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -91,6 +91,7 @@ enum mig_rp_message_type {
>>       MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>>       MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to
>> resume */
>>       MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do 
>> switchover */
>> +    MIG_RP_MSG_ERROR, /* Tell source that destination encountered an
>> error */
>>
>>       MIG_RP_MSG_MAX
>>   };
>> @@ -884,6 +885,11 @@ process_incoming_migration_co(void *opaque)
>>       ret = qemu_loadvm_state(mis->from_src_file);
>>       mis->loadvm_co = NULL;
>>
>> +    if (ret) {
>> +        migrate_send_rp_error(mis);
>> +        error_report("SENT RP ERROR");
>> +    }
>> +
>> trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
>>
>>       ps = postcopy_state_get();
>> @@ -1126,6 +1132,11 @@ bool migration_has_all_channels(void)
>>       return true;
>>   }
>> +int migrate_send_rp_error(MigrationIncomingState *mis)
>> +{
>> +    return migrate_send_rp_message(mis, MIG_RP_MSG_ERROR, 0, NULL);
>> +}
>> +
>>   int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
>>   {
>>       return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0,
>> NULL);
>> @@ -2614,6 +2625,10 @@ static void *source_return_path_thread(void 
>> *opaque)
>> trace_source_return_path_thread_switchover_acked();
>>               break;
>>
>> +        case MIG_RP_MSG_ERROR:
>> +            error_setg(&err, "DST indicated error");
>> +            goto out;
>> +
>>           default:
>>               break;
>>           }
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 01329bf824..f11ff7a199 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -553,6 +553,7 @@ void
>> migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>>                                    char *block_name);
>>   void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t
>> value);
>>   int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
>> +int migrate_send_rp_error(MigrationIncomingState *mis);
>>
>>   void dirty_bitmap_mig_before_vm_start(void);
>>   void dirty_bitmap_mig_cancel_outgoing(void);
>>
>>> I suggest you open an issue on :
>>>
>>> https://gitlab.com/qemu-project/qemu/-/issues/
>>>
>>> with a detailed description of your environment :
>>>
>>>   Host HW, Host OS, QEMU version, QEMU command line, Guest OS, etc.
>>>
>>> A template is provided when a new issue is created.
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>
>> .

