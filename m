Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA6DC282C6
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 14:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tokcS-0008NK-2T; Sun, 02 Mar 2025 09:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokcP-0008Mo-A0
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:48:37 -0500
Received: from mail-bn7nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2009::609]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokcL-0003ue-QI
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDayV1bRlgG0cENqld/5RE0gGx3ybDdYzzRpSrAzUd+1ImnG1wXrIA4IsWckb/UQyt8aeNqSIhP2oN5gx1tsALUdp7pba9ee+00Drmy+GpAVx4YPAgKnqAmYOXUzkAWDA6ztzA0q0/QbYOF7WXaPfFU6XWIaRB9A/Wk+lp3tRUuQB5l5v+BBjgPw6S2l90svqcvPgGmvjFDqnmcuQuxkgJVfp8WNoJO0gaGfmPClrWBFws1NYYG9V9+/DqYBSdN7wMk0jed2eAvWIkoDtdN4bAYsyCgasC4Esp5Ynz04Fspx4L7/aYN1crA3iNA8QLKuZ+D8qdyUdONaey9UKN+yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzLD/HkA/a8D+opUluNsnJmLTSTZm/14KHKSu7FL/dc=;
 b=OuhJ6fP5KR3KC5HeVeT5eSeP9AlwQ3vnSzCBcZ3mgFBsnajtyUZaqGJkN9eVex+y11yINp/oy2XKjDXpHOXLmVliVTGYSb8lKDiSvnDuNPqKctZu5k4gwpVoaT15WIN9iQLpxZCHOjdrgg5SO6tRkt1T18C1L2utcqX9dKcdHRCLE4kt2N99ELnzyzb+EZlHfDppTF8hDiqGW3TXoK4Isaux/Xz9OwYWoNVgIT8JIcjeYuGCFoDx5Hudwpn6pCQkxmEjrMGH2OXvbykWfGvDIu7lN9HZcpkWb6QIp99DxXkLHeB9JO819vX22PGL1aBQfTwtO00nkz1OYeY4TQPrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzLD/HkA/a8D+opUluNsnJmLTSTZm/14KHKSu7FL/dc=;
 b=kBMz1ZPsOaRS1AzqtW5CmxtYPUCf3RtwkpoL3+CzJgM+Z0TypHyr+q1d5blGekkMxITmReWpBtufSV3uzWSz7f7D247L+gEJpZPJWmrxssDLS9HOSvxib+ijn8ELvVFxRPsNt1Gf7Y5jFncdn/YD2+fG2580bgX/SdTuC3VVYws2ORvQhnMBAHMEHEMKlBLFsh2q/kvDLwKa4F9G2eUgcm3NS4X9ZgrvoicDDzR9euhcdHyfv87hf2VY92JKEYoYBoddB7EC7j8/UflPlcevFiuNa7lpwFNQJXyIFaPaGaeBGCFQHE791Yest1jXojT8bt9HpNiDJ+T+m5QULkF+nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Sun, 2 Mar
 2025 14:48:29 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:48:28 +0000
Message-ID: <f462d899-7cba-4673-b8bf-f6a3b25d25b3@nvidia.com>
Date: Sun, 2 Mar 2025 16:48:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 31/36] vfio/migration: Add x-migration-multifd-transfer
 VFIO property
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <8f38087567dfc898fb0f1688be0689dd1dacfa22.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <8f38087567dfc898fb0f1688be0689dd1dacfa22.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed4d8d0-6f2a-4d8f-c38c-08dd59994b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0Y0Und0NU05ZWdNaTYvZm1KMEdNOWN2TVk1d0xhbEx3NmdPd2pJYnFkSnRW?=
 =?utf-8?B?Yk9ZT2piRWxXNmU1NzgvWGl2d2dDajNsNzUzSm9VNWpIV2xpVEV1R3JIdkJ0?=
 =?utf-8?B?cXBVVW9Xc0U0bjhLZmFsZ3hSWmxOcXEyOHZ0bUZtLzNFdXUwdEYzRlY5SUl1?=
 =?utf-8?B?OWtrcTlIYmZmME1ha0I2clRKcnZQTUMwWE55aUJ5a0M3cU9KdkNFZEppWWlt?=
 =?utf-8?B?ZlJLb3BrR3hEdlp6cHQwM0V5c1ZheG14OTNCY0NCNVloMWxOanJ4dUZDOFhM?=
 =?utf-8?B?ZUxHNjFFWHlLWEJwYldaQ1d5WEFRcFJsODFCQ1FxVWorSlplZVRhTDN6K29y?=
 =?utf-8?B?WlhVUTNzODY2RUdLT09FL2FraVJYV1lhNDQ3S3ZKSFFkdnlydmNBQTRZUEVq?=
 =?utf-8?B?OXJmRjU0ZGxjaVp3cHpvak51ckpmYWFEK3NCQWZFV2NHYjh5NC9MUHREbVZY?=
 =?utf-8?B?eEJUTGViSm5WbXpqbFRyS0NtVnBQR0tXMVpjU1h0ZFY4NjVOOGMzYmdYdm5r?=
 =?utf-8?B?eTVDZzFJSXhEMDlpOEJVUmtEZkhnZVBQeWI2VDhsTDhHZFJiUVQ1dkV3Zzg5?=
 =?utf-8?B?c3JWTjN6aG02c0NMdWFCTVMxL3VHT3lmYVowNnpzQ2pEZE1UNCtndTVTUXFp?=
 =?utf-8?B?TXQ4OEcwbUFwaGRlaSt4SWFGVURYbzRkRjZQdXdmbzAzblcyZ3FIT1BjblRM?=
 =?utf-8?B?N3ZoOWMwOS9UN29sd0NGMnQ1anRCYzVZZm84eHVGaDRNeDVRTDk4eFUxaGxG?=
 =?utf-8?B?b0RSOEFqQmcvOVZpN2thb3NNRDBxTDJTWEw4WG1tZlBzNlRkSzZGazNzdkow?=
 =?utf-8?B?VkZCT04zVk1LTXJvWjdaUVM4WEs3VCt5L3ZpdDJiRVlGN1RUa0FPOXhOVkR1?=
 =?utf-8?B?T2tOc0d5SHZwd3YyazdRZ0VmU1IwVzBkdFpaSnBnVHpkOU11WmtLMzR0YXFZ?=
 =?utf-8?B?T1F1bXYzWTlvUGtXT00vOEFSNUpxNXdZMDBGb2VxcFpXa01NbWIyVzBYc1Vx?=
 =?utf-8?B?UVQyT1BaZ2lpK2t0YkZqUFhsL0ZjU1Q3ZU9ZMitPMzNPQzFKT3ZCaS95Rzd2?=
 =?utf-8?B?TGJvVlljY3dUZm9iVkcrUXVJeUt0TDEwTklUWE9JU1N6elRWblhCejR1RWVJ?=
 =?utf-8?B?dGVnUHVuWk9iRnltcWhtZjdYamo2M1BjZTdiZng0WTZ2VVZGc2RLTlcwZTRw?=
 =?utf-8?B?OGVqd0Q2Y2dZb0V5d3BGYmhtWTRIRTF0MmRqUTAxMXY0SXhvV1ZXMGttSjVX?=
 =?utf-8?B?MWVwZ2hZbEs4NnY5T2cvNWdhQlIvci9uZkNlam1hbGtreVNCRW01N0RtYUdK?=
 =?utf-8?B?N2U2NStLL1JPMXN0bDlnelVXMGdtVEwwb2NmaGhpNUJoSHJ3L0ZWRDZWUHhJ?=
 =?utf-8?B?Z0hVeE5kRkt2d1VDZXdIazVQZ1lHaEltZGF4d1lQZ1NicHdRT0lndFc1K0tt?=
 =?utf-8?B?akM4Q3U1dXdmQ2p0U0NWZFNCRCt3NDNGREI3YjdBeWxkS1ZDR3N0UXAxcXBt?=
 =?utf-8?B?MWV5WlhZcHpwbDl6dGhjTXhjRUVCOWw0STdEYVJzRUpKa0pxRTZMWkZWYkFh?=
 =?utf-8?B?Ryt1Q1AzeXU2QTlIazNDc1htWENxY1J4YnNMRXZnNWdJdkhGNDl1VzFJYXM5?=
 =?utf-8?B?VGI5UGVDRXR6cHNtT3VRUEpIdm5mSVE5NWhvT3NoWVkwSzcxTW1VZmI1VFVu?=
 =?utf-8?B?NkthaTlJZ25NMU5HZXV5QlA1Um9sRkVkWXVlNHk4RjJtaStjTmZGTDhzVEhn?=
 =?utf-8?B?Sy8yM2tYQjZZcHBncVdiRXRYV3R1YUFVYmdYNzhidUN0WkpPakp4L3hoc1R4?=
 =?utf-8?B?dEpYK1orNXRTQTdqVmV4b2oxU01QYUgyWGFKSGtiL2dHZmJ2YVcyMEV4UzFC?=
 =?utf-8?Q?OJJje9NvAKKF8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hHa2FFZFJnek9yTGNoSSs1TlJ6ZG5sMmRHVHpHMTFMbDRST1ZMd0hVVzN4?=
 =?utf-8?B?bXNoK3FtWHFOaTJJenNuUzh4R21tSjJHYmlPdDNoQVNDNDdReC9rR2hUZHh3?=
 =?utf-8?B?RjJKTlZBaHFFT2NQY0pubW5TdlRYdEhHeFBmSDgxMFlubFRna1ZEa2pUV2VS?=
 =?utf-8?B?bEpZaG1aQkRXNkpFRGhCRXFpd1NNMnBrZmJBQWQ3OUx3ZFBXWlkxcnhNaWVm?=
 =?utf-8?B?dDNLYjVacGtXTWtTalFEN3VndHN5bUM2eUhvYmVUL0NEcUh2ZFhibi9MWkRv?=
 =?utf-8?B?QXdZbFVlSUxWYnZ6dU5TTktpWjhMcVBsd0l2bWNtK3VENXZ3QUxjVE9qTzgy?=
 =?utf-8?B?WElSU0Jta3E2ZEVMd3RFcWlGNG9GbVhhUmg1eWw2VUxzQmNSSWRaUUxjQ0Zs?=
 =?utf-8?B?a21laDVya1pldERzZUF6OWlnRUlhZUhxRXBTcFZKRHllcFgvSVFEeGlvQzcx?=
 =?utf-8?B?VnpWV0tmNTNlN1FwK3JHV0lUM0JYdDR5dUtENkRlZFVHRVFDUXNhcXhVYklH?=
 =?utf-8?B?SnZxR1ltenF3R3RCZThZWkkxUG56U1UxbmZPQlRYWXc5UmIvaVQxTDFkb29s?=
 =?utf-8?B?ekswd1ZkVWZ5aXgrNk1NRkc0allnek11L2Z0UDU2V3VXVVhYQ0JHMjY4NVdR?=
 =?utf-8?B?WjlucFhFY1Bjbk9wdGIyemVrZEF5bHhMQnRtVTNnUE4zLzVMRmk5S1J1QlJV?=
 =?utf-8?B?VEdiUFl4eCtiSFlpQjNnVk5qY0tGeVZCUTF5TTR3b2JRMjYwZTJXWXJBRGVD?=
 =?utf-8?B?eVRaa0VFTk5yZXZvSkIyVHd3TFFkN09UUGxIcFRZOUxSREFPZVZCczVhZXRE?=
 =?utf-8?B?MDQyVVYyZGdRS2tRRitIRGdYcGIvVXJncjY3T2U0UXZxTUpOWUpBeGhjVnQ3?=
 =?utf-8?B?OE5Gd0RFVnVnaTBpM29UL2sxRTVVTDNCdnRTUkJ3cWVhTnlSb01iMlkrNWY4?=
 =?utf-8?B?ejByYzB3NnBOdk5US2tBOUI3R1VGRkNTRW03cS9XdXBCbXVidnZqbmZMQ09n?=
 =?utf-8?B?cVRQcDJtc2VuTjJlTCtuS2c0TFdDanVwc3c1V1NTb01EQmNUMHpuTFlGZVB0?=
 =?utf-8?B?ZGRkeTVFYS8rS0Y2LytneXp0eVF0dThjc0lMZitUSnVRKzJXM3pibUpIbDBX?=
 =?utf-8?B?V0VmQlJLS2ErVkFJR2hoWkhVdkpMUjJqNlVEZ241TFBuOXdBcGpUUTFGNnhY?=
 =?utf-8?B?RExBK2FEZ0ErUGNWSlVEMlNZZW9sM3NreWdSLzV0Q3ZQZWExdkRHL2U4dlNN?=
 =?utf-8?B?cExWT2Y4SWM3cDhWdFVWS2VJM292aXF4SituUVJzRElGLzBOTStQaUZjU21y?=
 =?utf-8?B?UDVFWXoxMEd5RlBFN0JoYnZBSVU4TDZNM09SNmFhWWhTOFVGSDR1eTVWc0sv?=
 =?utf-8?B?N3lyMmNyVTNaNkFGRk9Wdjg1MGU4ZGVxWUE4aURzK2p3VVBxR2xLMm9mVVNB?=
 =?utf-8?B?TjMwNStWOFpJZ3ptbmpMTGpMbFlxa3daMThuQ3I4dXBXWEdwZnp6Y3JmZG12?=
 =?utf-8?B?bUx4Z3hwMGZZVEh3ZDlpemJ3UmcwU1ExNkpsdVVLYTFzN2poOGt0ZnVMOFg5?=
 =?utf-8?B?ZlFkaHEyTTF3ZU1IVkM2Z2xxWFA3SVNQQ0gxTGk2aEs5SVhsRmUxYkdSalEr?=
 =?utf-8?B?UXpsVjc0OGRqYkh0VnZxd0RGTWNnemM0cmZBNllYZEx0NURRWHNNckV3U1Ez?=
 =?utf-8?B?bU91UEl5NEU0NjhLeDlTVCs0dHUzdzh2dERyKys0alZHdjlPNnRsaWpOSTNG?=
 =?utf-8?B?blJlcXM4MDd6ZE9RalUweTRLL05XS3pVSUNGUkdEWXJ6VzVxaUgrdTFoT2xl?=
 =?utf-8?B?VzRDLzdyNnpYTkVUNXRKR1FGbFhTekJNYmJxYi9yMDViMEx2RXk1Y3NBYlND?=
 =?utf-8?B?VjV4all0c3lUSUlnRTd3QWZ4NURJM3ovSTZ3NkNsYVUxQlptYkxyR21na2Ex?=
 =?utf-8?B?T2ZYNDVOamJvN0FDUWw3MlNETFBDZnlQd3F2Zk1GYXNMUU5TdWlHR1pxV0x4?=
 =?utf-8?B?azhVVjFYanRkcEt4T1VyREloQVJYcnF2dldUREYxdnNDeGNRZXhyb2tQRXMw?=
 =?utf-8?B?cytQTG1HUVZ5akZsdEhXYnlnd0EzQmZRTkc4eHhEbFI2K2pZYzR3T2d1Q2ZB?=
 =?utf-8?Q?82y1kGcONMbTlA0UdVxmL6JFY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed4d8d0-6f2a-4d8f-c38c-08dd59994b41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:48:28.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EPBQb1y78/f42xK9LOH1CKj6j6zzCSP6WpIgJKDM/+69ua7z0zdkFLbrd1393HpBEYaLxsP02boQFk9LbAqYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
Received-SPF: softfail client-ip=2a01:111:f403:2009::609;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This property allows configuring at runtime whether to transfer the

IIUC, in this patch it's not configurable at runtime, so let's drop "at 
runtime".

> particular device state via multifd channels when live migrating that
> device.
>
> It defaults to AUTO, which means that VFIO device state transfer via
> multifd channels is attempted in configurations that otherwise support it.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 17 ++++++++++++++++-
>   hw/vfio/pci.c                 |  3 +++
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 0cfa9d31732a..18a5ff964a37 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -460,11 +460,26 @@ bool vfio_multifd_transfer_supported(void)
>
>   bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev)
>   {
> -    return false;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    return migration->multifd_transfer;
>   }
>
>   bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>   {
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    /*
> +     * Make a copy of this setting at the start in case it is changed
> +     * mid-migration.
> +     */
> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
> +    } else {
> +        migration->multifd_transfer =
> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
> +    }

Making a copy of this value is only relevant for the next patch where 
it's turned mutable, so let's move this code to patch #32.

Thanks.

> +
>       if (vfio_multifd_transfer_enabled(vbasedev) &&
>           !vfio_multifd_transfer_supported()) {
>           error_setg(errp,
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 89d900e9cf0c..184ff882f9d1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3377,6 +3377,9 @@ static const Property vfio_pci_dev_properties[] = {
>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("x-migration-multifd-transfer", VFIOPCIDevice,
> +                            vbasedev.migration_multifd_transfer,
> +                            ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ba851917f9fc..3006931accf6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -91,6 +91,7 @@ typedef struct VFIOMigration {
>       uint64_t mig_flags;
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
> +    bool multifd_transfer;
>       VFIOMultifd *multifd;
>       bool initial_data_sent;
>
> @@ -153,6 +154,7 @@ typedef struct VFIODevice {
>       bool no_mmap;
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
> +    OnOffAuto migration_multifd_transfer;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;

