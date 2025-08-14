Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AE7CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 16:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umaiZ-0004D1-U1; Thu, 14 Aug 2025 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtatulea@nvidia.com>)
 id 1umaiO-0003xS-Bt
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:22:11 -0400
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com
 ([40.107.94.85] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtatulea@nvidia.com>)
 id 1umaiI-0000CL-Oq
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 12:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTA5o4t3hyIelpFh9xhoJLwccD3WLJwyyIVuifpgCcQRHuEoBrV/5MwuV62lL+XWjHsToZEC2LDPUVvpZtbIWj8lDM9qRGonpuwfSqcqeDH0ssKSLkWCv4E3vA/bmaIIlA/J6CYxKLq6Opz8IgZl5XHBtF0zRaw0eNWznRU22LdSSDbmexwkcv9Ys9ZUiG7PJ24MihEqlWWvSm5OaBc6C+mTQOeJN+4cRzhaWkwhI+tn+WfwD1SaPtzk29LUWoNhCK6fCZQpImAMU6t+XJl6Q03G+uPT/TiuOCDXRUpbMAUMf4UnfBDN/sm8wwL34Lar9T0AdS8YFzTVt2WSwhRQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/92XAWFYOsefSSnPvwjRv/kvOKH4xOXITKS2ZyURZOU=;
 b=d4nd4Wag8CkQk9ZNFdmaC7IzoNbcXVoaqPpYt2rcJC5/RMkQ0Orgc0V9LYTPZw2p9BJNB/ZdRBWQ3sMAqwtSsKRkOjJtl9H3AKdiF/EdGZULn0DhjXGthCN9p4y15Rs6G3y6H+c8kp4oTksNLMrKjbJ2C5ZHg23T98KM8c69K0HejCitbEcbknHgjI3rZ1i7Bo3POP2g8yewST1DH4O5AfInTrKfs6RGfURQ4GzljC2aWnbxiq0f8bLSEOtSNo2SWmGQ7Xh1KbegcKYm1LK7Ls/Fc9btbYnYePC6ki/7VS3+AFO92spE/3yEq5D6BINp/b8LVS/9evmDhaOZGc8+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/92XAWFYOsefSSnPvwjRv/kvOKH4xOXITKS2ZyURZOU=;
 b=lIrD8AllleQBPgyE/8grWhVy7yuX7MMRmnAb0AVcVD0cedITl8VngxYIljCBYqZXbTUEmeu+0/Vs+eBeZ1ahvDZC015FA9eNXj0HDkzb5BzcgUj8TDNgtDC7bCkU95+MfFtVVEOMwttASPOC119uDdrZlpvw9PPigHk+IXcqpgTEfDNluXIAja+KOZtwYYrht8tQ941vkIV+Fg1Vzn+Srb5Cleb+3rkF7zHLwCdR3pxiX1Wqv4xd/zIJHj09E+Q31qqQDMUMPInodIvclQTIBtTQLG9Y2OBqS8Ur34tiUuWpHYw35D6XZOxjz/cwtPibk8iNA33xDFICSOlSrKyQsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 16:16:49 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:16:48 +0000
Date: Thu, 14 Aug 2025 16:16:42 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Eugenio Perez Martin <eperezma@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, 
 mst@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <awhvyibbimg2aqfrgo5u6mskbypw7yloc33hinzphkbobei4oi@vouvhdksatm6>
References: <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: b98d2b39-931e-44d1-341a-08dddb4df88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDhnQlJ1VGRxQTlkb2FaTGlQVlpVdjZuR2xRZDFNejBmZDlDR3BacUxSenNK?=
 =?utf-8?B?NHIydjlMYmVQMURlblk4ckNOd2NsM2NWOXJIMTgxT1IwZlZBNWxhT0N4cFUv?=
 =?utf-8?B?K3FDSWR6Z0dseURoRXE3bDgxRDN1TlN5UHV5RWdsQ00yRWg3dm5yUFRFRDNE?=
 =?utf-8?B?enlmUUUrTGJvZzJUcHc0OGRBcVdFakhmL0d0bklHT0xOREtacXF0enZicXFm?=
 =?utf-8?B?Rm4zQ285aXhMZUNpTzFMQ09lWVRDRVdORW90Mit2RHIvcFhxWjEyVFo1M2RX?=
 =?utf-8?B?ZGhJQWMzeVMva0NJc3M0S0RnYjdlelBOQU9ZOFU1WEdMTDY1YnU2b0Q3M2dj?=
 =?utf-8?B?cE1mVDgybVNkUDgwMGNWbmNOMW1SekxBZmFnN0NweFEzbmk2YzIyVTljMDh0?=
 =?utf-8?B?SzMwUjRZd0RweUFtcCtiWFUzU3JLRjBvSnN4L3ZyZkNaWGNPc3VvV0p3VDhR?=
 =?utf-8?B?bWhnbGNhRXBwWGhXK3phN0UvRXlJa3pIMzVoTkdZOTB3alBQMHF4d1pBK1Ey?=
 =?utf-8?B?R0E3ZjkzUGpqZzNwQTBiL0tWTER3MXlVODVOU0Q3NHAxc2RDNk9NSS8yaHBI?=
 =?utf-8?B?cUJRcFhiME9WM1hYYjFjNTVONTcyMmsrRFhwMzFSemg2Mm5UcHloOVBkb2pT?=
 =?utf-8?B?N3BueGc3cS94bzl3SEFkMlBWRFIyRlh2N3l0aStOMytGT2RwNEYwZHp0MjRH?=
 =?utf-8?B?b2IrNHVhcElKVEpLWTJjOUpoa2RIMm9vMG1pR3hVc2M3WmNOWWV5VUV1T0JE?=
 =?utf-8?B?b0orZTF0M3dldTNRWkU5bWtWcnAxK2xRaCtKRnVvWnZyZmVyQnVvMTJFdlIz?=
 =?utf-8?B?YWhXNHEyUWtacGcwWHF2eHBERTZIcTVaWG14b1hNS0NsLzdYM0JFWi84OXpF?=
 =?utf-8?B?TEc4RFdIeStHOWEyMy9nWTFSaXF1VFZQc1ZXdi8waXpCR0o5aW1JWWQzcVh6?=
 =?utf-8?B?d3p3ZlRYaFcrcms0UzhBdFVCZmZzNFN1NEp3N1daR2ZhRUFlTGpXck5wdFFa?=
 =?utf-8?B?MllENWcvNG53ZEJxdVRUYWo3czRLODQvd2k0L05FdlZEaXBmbjJEN21sb1Zi?=
 =?utf-8?B?c01wSnFyU09PMTZlUm5YcDZHYWNvdXV2WWRWSWZQclNSMFpXZ0dWTDdDbll3?=
 =?utf-8?B?OTlYUnZKa1FvU0NGOGl5YUkrQ25LY3pud0tuVktpUGxzb3ExWkJTL3JqNnNO?=
 =?utf-8?B?U2h1eWtZelZIYUZyM0hScXRkZXBzb3llNjF2SXlacitZK2lhRHdKZjFNeEdy?=
 =?utf-8?B?K0dsckJKZXFRUzNUYmRpU1lDWDZKWUk1STJNTmp6Rm1odmRCalhSUUhqc21o?=
 =?utf-8?B?eml1TnFCMVBhdCt1T0UwUUNVT3laVmNUZ0JyZ0ZoNUxZYnB3NUFnYzFVODBN?=
 =?utf-8?B?dkUwejFsbkc2NTIwWVV6RStETGxOSlUvM1E4MnVpeUc1aG4vSkJIcENRRjhv?=
 =?utf-8?B?WkVFUlRaemp5aHB6VkJHeTdsS1VjV0JpQ1pObW92NGw1ZmNsWU1MbXl2NHBn?=
 =?utf-8?B?UVpXN1YwdE40MmxNblBKVS9kZzRaOEYrTlduenMvRUpid1V6d1NjNWFzbUtX?=
 =?utf-8?B?dnNxd3R2Zmhvd25VRUJYaTljekJQK2paRjlhQ3V5dWxkaWIwQ29KMzhRbnJQ?=
 =?utf-8?B?OGprcHVTL25TREp3TlNYbE5rNDR4UW14amhyMmtraWpYM3IrRXRyRmlFSUNo?=
 =?utf-8?B?dGJ2NVFya3pnZFRQS01rZTdMYTAxMTVlaWlIMXRoRVZURWNkSnBkRFBseEM3?=
 =?utf-8?B?YzNKVmh3RlJpbi9SRU5pdEhQdDd2RFV6L0JGV04xZlFaN2o4RFpFZnNreFBj?=
 =?utf-8?B?YkY3b2RYaGxKNHFYZ25ZMTRzZm5IM3JrK3hvcDhRN1lzTDNJZEZLYnVYRFpX?=
 =?utf-8?B?cnJ3Y3dXSFlDekJHbUpPMHRZRjBGR25Bbzk2eWExbHExVXl4cDlKTVdQa0tO?=
 =?utf-8?Q?h7w+0Apduno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9031.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xPa1BRYTZnL082ZS95QzkxVjVFOGZKMW5qVVkrWVFHbXc3a2lMNTlsdVdT?=
 =?utf-8?B?UGZKdlU5SGNTMDFvSXNDMDBnT3hFS0Q2bmxQWTF1U2puNGJlRCtmeWx3QTVV?=
 =?utf-8?B?NVZJYkdEVXRYT1RtZ0VYRkowRmFxSlc1Slc3S3ZNZVR2US83N3BkQVNLRFZx?=
 =?utf-8?B?TG1ERjczbERsNEptSlgwTlJhaGpzRkhtUFIvbnpqTmhqQWZlVVVLTTA0V0VB?=
 =?utf-8?B?ZU1HR0JnK0NJRGY0V1E4d0FVODJndUJQdFlGL3dHeEplMkRvbTJ5SUdRcnJG?=
 =?utf-8?B?c0ZRdk1yMDlUazdnajFZZFVKZ2xNSysrdWRMYlhRemNDS2JEUk4yR2FzYkM0?=
 =?utf-8?B?QnU5QjJBOGRDb2poTXpFNzh5K1ZUNnZqcHM2S3Zrc1NTd2lpSnJMSmhHUzBu?=
 =?utf-8?B?TTdnVlkrRlBhbVkrQVhxanp5NDNUMW44SG43QU5KeE15OTZ2ZUt5UlRQelNN?=
 =?utf-8?B?bkdBQUlrbG9kcHlnbjJ6ck9qaGZFekE2Nk1DYzMyZVN1Nk9MeDRETDBNc1hk?=
 =?utf-8?B?bGRWSFE2YmFiVEdkTUpFSDF5cWJBenkrbUl1R1ZFYm1NeGpPbVdMUnhUemhv?=
 =?utf-8?B?UGw5MjA4MXNzV2VzYksrYlp2THZMYVNtT1I0Q3lCcUJtV1JnODRxeTMzQjRu?=
 =?utf-8?B?VU0vT2dGYXMvM1RiT3UyamtjY0dUUm8wdHZtdzR0dFo2alZHNEozMlA5NE1x?=
 =?utf-8?B?SkVlL3JrMkZZR2pGbVJTL2tEMTBXeUVVRHBnMFdWM0tJOTM2b1ozdFJMbVZm?=
 =?utf-8?B?RUFJVVJZWXc2ekdyZHNRR3dFRnVXWFFySUt2MG42dm5MSGJlNFczTkdSOEFJ?=
 =?utf-8?B?dEZ5UUVUNVk4TVB6dzRUVENra09rc1N0OTMvVjZCWmJVaEJvd29EbVE0RUti?=
 =?utf-8?B?VWpFckFvMTNERmRSemhpTjZvZkFQbzJldnRNdjE5NTBMemR1bm9xWFp4OG8z?=
 =?utf-8?B?RDF1RWhUcnpHdlNnemxOSndYdzNDR25BbzFLK1V3eDhxa2JjVDU4eGgyaWRL?=
 =?utf-8?B?RG9FM3dRbE9STldybjc1UGlXL3kwZXdSMTB4MG9Fd04vamZnbG15eHdVZXNw?=
 =?utf-8?B?bzdKV2xDYjZjOCtMS0c5QVJlaTVmSnFlOEx1WmhQQmlWUDJvL1JRM3hwV3FO?=
 =?utf-8?B?Z01zZk8ydGdIajByOWl5NWpBU1cyT2YyZTlTd2JtaC8rYTZHQ0o1YmsyM3Ny?=
 =?utf-8?B?RHlmVnRxWURIUkVXcGR5c3k4QWtkRExKRjFRc0Y1K1lUbTFwWFgxZjlNVitE?=
 =?utf-8?B?MWhaODgvdUg3bHRHZ3MxZkNMQ0N0Z1NyMkRjTUw5bzFVaysybWpzZy9NeGZ4?=
 =?utf-8?B?MW1abDhzay9VVGF4cncvSGpsZmNtQkIwUkR3dmpxZ0JabVRKU1hUc2hCTzlV?=
 =?utf-8?B?T3BRM05jNzBEaU1Ld2U3dmRxTFlYdFNRTnhabHhsQUxHNkZ6QkIvMmJTS3ox?=
 =?utf-8?B?cGozZU9BUVNWQWVySWR4SHY5SGoxalk4SFJZYm5RcFJHSUkrSXBBMHBVUE5K?=
 =?utf-8?B?cW5wb0NPK1lNcnp3Y0xjSndaNWJqOEZ2cjhaM3Z0SkhyTnpwZUZDdG9aemcx?=
 =?utf-8?B?Qi9oNEpGS1d5WVJ4VGZQQlU0UFdGWkp4UFc0c0pHd0lTQzhRM0gyS0R2bjFZ?=
 =?utf-8?B?cUtpVGhjNlhiMzdyR3FxVmo2MGtTZGZPb3Nzb3ZUL3JROXFwdmo2WE5IYlRy?=
 =?utf-8?B?QVAvMVVIa0tQZUxCSVVNT1NWcWxWaU96UFh6QmdHVjlxcjBybERFRC95UDh0?=
 =?utf-8?B?L2RJRmFVdDMycExjNFRTQ3RFSVZHU0I5SjVFN3NPV2xEbFdncHF3V0crVEY2?=
 =?utf-8?B?bitoMnRvTmlQS21UTzZ2M0I3RjZlOHhGTlNud25iRkhCT21uMHV1UTB2TGlG?=
 =?utf-8?B?dlE0b1Y4dDdpenc0STN6Q2NwdWpsS0pGU0hpWlRPeTU5VWhTbm4rRWtDZG5H?=
 =?utf-8?B?UnRqK0p1dTlKT04vUElsUmFhU1RzK0Y3MHBJSkNEZXNLUTFLYm1vZWp4NVZu?=
 =?utf-8?B?MFpKSmdDYnM5ak1WZGd5N1MxaFFBQ2hHdElaeVpnamNPMXNpRTVNOXJiSTBP?=
 =?utf-8?B?R0krclhBSis0MW5LcElHRkUyMVRYNGVNZ3F2VEFUemdFdkg2bHNxU3cvdUxH?=
 =?utf-8?Q?osrDWnscvI0raMPi0leyu6m2k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98d2b39-931e-44d1-341a-08dddb4df88c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:16:48.8781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CR5KfoAx/5kAkAzzPYN/yuOd9+m7uuRuLZpjflc7fX0+XbZUHHU7NxSToavrnMHE9qSLaFd+zA8TEP17ChFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
Received-SPF: permerror client-ip=40.107.94.85;
 envelope-from=dtatulea@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 14, 2025 at 11:28:24AM +0200, Eugenio Perez Martin wrote:
> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
> > > On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> > > > > This effort was started to reduce the guest visible downtime by
> > > > > virtio-net/vhost-net/vhost-vDPA during live migration, especially
> > > > > vhost-vDPA.
> > > > >
> > > > > The downtime contributed by vhost-vDPA, for example, is not from having to
> > > > > migrate a lot of state but rather expensive backend control-plane latency
> > > > > like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
> > > > > settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
> > > > > dominates its downtime.
> > > > >
> > > > > In other words, by migrating the state of virtio-net early (before the
> > > > > stop-and-copy phase), we can also start staging backend configurations,
> > > > > which is the main contributor of downtime when migrating a vhost-vDPA
> > > > > device.
> > > > >
> > > > > I apologize if this series gives the impression that we're migrating a lot
> > > > > of data here. It's more along the lines of moving control-plane latency out
> > > > > of the stop-and-copy phase.
> > > >
> > > > I see, thanks.
> > > >
> > > > Please add these into the cover letter of the next post.  IMHO it's
> > > > extremely important information to explain the real goal of this work.  I
> > > > bet it is not expected for most people when reading the current cover
> > > > letter.
> > > >
> > > > Then it could have nothing to do with iterative phase, am I right?
> > > >
> > > > What are the data needed for the dest QEMU to start staging backend
> > > > configurations to the HWs underneath?  Does dest QEMU already have them in
> > > > the cmdlines?
> > > >
> > > > Asking this because I want to know whether it can be done completely
> > > > without src QEMU at all, e.g. when dest QEMU starts.
> > > >
> > > > If src QEMU's data is still needed, please also first consider providing
> > > > such facility using an "early VMSD" if it is ever possible: feel free to
> > > > refer to commit 3b95a71b22827d26178.
> > > >
> > >
> > > While it works for this series, it does not allow to resend the state
> > > when the src device changes. For example, if the number of virtqueues
> > > is modified.
> >
> > Some explanation on "how sync number of vqueues helps downtime" would help.
> > Not "it might preheat things", but exactly why, and how that differs when
> > it's pure software, and when hardware will be involved.
> >
> 
> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
> about ~200ms:
> https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/
> 
> Adding Dragos here in case he can provide more details. Maybe the
> numbers have changed though.
For kernel mlx5_vdpa it can be even more on larger systems (256 GB VM
with 32 VQs):
https://lore.kernel.org/virtualization/20240830105838.2666587-2-dtatulea@nvidia.com/

As pointed in the above link, configuring VQs can amount to a lot of
time whem many VQs are used (32 in our example). So having them
pre-configured during migration would be a worthwhile optimization.

Thanks,
Dragos

