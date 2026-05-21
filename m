Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63BDCD5BB5
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3r6-0000TK-MH; Thu, 21 May 2026 09:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wQ3qq-0000KL-4y
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:54:16 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wQ3qn-0007Wm-Qq
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:54:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/gHmVRheO8yPN7QWMvR6xIpCMSSsFq2SsW0nck/hvmhQVCLAdjHXWGYI1sjeZ/e1drAjDA1p02A8v/oN7+WKtjzYYgjXkyk22fCkcsLJ6oSUnEYRACt+mIVKyPXaEg7vvaQAf7tcTPYx1MoTc0yapCn0GeOWd4+rgDTePzbJsy9i2j5NbVjz8BVK46kBybnNyy9tp/aH7y1eK9uHIT/q+zSD0fxclKRnqg+27g8f67+ZCgv0Q1HszFZZF/Po0SWLeJPW+yqdFvTPF7LQdOqcI6bI9MWiOguZzJOBF0alUbw3CffSpr/nzxhGCbdp4SCkvV2OiTnSZfJ1u08mOuFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcJfj6fqqcl2ILB+ltPHm/tGRL9gWDeMCZYBSL7XbJg=;
 b=FJTjlURnXdZJog7c4/BajayncXAkzar9tIHQBh185bHDHfnfdqKExnynbrAMpSlK2+7/FfLv2dU+0arSl+DjBb8qN1s1q/GnoWWy5NZ9Gx7sji0AOr8cOE3z9dmUkJ4gOh8eXAt/Ulr/A19O+6o958mJo8ZUxdtHV3nCCt0Q3/0NVJNg/mpe/mEe0/H3/gly9/NwYTJMoDcBf63RDe59Imp72+MeHNxQfxyiBPqQrbMhU8qMnic9qREP/1TpkI43dCVbRPfwTiYd28AYPcO15bctIyD05vl+2mAYZgU8IXNKSdpTSS7p1Jzz/pjMd4Fc0ng5vrFJv0GMEN1C5tUcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcJfj6fqqcl2ILB+ltPHm/tGRL9gWDeMCZYBSL7XbJg=;
 b=nhq10ZbLKHVOY97kvh9uF30Av9V35+SlcjfbFQukZSvQgxAATUoX0qwTqn34mLwGNp8m+zcgLbjS5tyWyLrcjnNDM7Bz8u2cwa0iLLo4ZpdJeZjTX/AI4W5LgosAo8w6x/5nv85GsNOesJsii+5a1eKpXVdd3RQwRGMBodA9AkUU+4E1EJ4iWzLrSSV3YSkZoXEOhtgS55uZMN8Yxu2UcyqFmELh7jAWRVF1y1Nqu4NoLwG7SNZCFKlLWLLa+nHOb8KLTp3alhb2UobcvQURdyj09iBtkY9E+sSxW2vvDza8EVi4c/NNOXS8+HBJ/quvql9cUZAWqsU9tmJUPxpcHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 13:53:59 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Thu, 21 May 2026
 13:53:59 +0000
Message-ID: <3a1d0bc7-7656-43f4-b763-5114d9dc57a0@nvidia.com>
Date: Thu, 21 May 2026 16:53:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Make switchover-ack re-usable and add VFIO precopy
 REINIT feature
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <agzDdH5vClAqwjAs@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <agzDdH5vClAqwjAs@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b26e96-1f17-4feb-8101-08deb7406851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: z2ZQ4elVtM1RX0xbiMyjGsdx62/b9J0u40Ggvxovp7B3U0FHuh//NibxHORvNXP7eKYk97pXiPhdMOfDP7Aq6/udSnAwUo86YQfvqQBluQ8nm9ncCGpcO+tCppjMQYPoloC8NnnjNtcCvgPoCCBGu/YOlGVpgDFwxLHaG9Ea/n6lvXVcTw/2o+McVuLRSxVIdXVk649a/jBSnZVMIG5kBGMCtyI4aKS4udCggIvVv/JJ1j4/3yEmQeRIR6fFX3z8dBPz8UZitVYn4eUS7K5EVe7QKThH/2ACLWbl7pEDe5lsCHszRRV/gCv2pu935fk8bpHV4FDGuylVvUc3qDaXn1Up1CLq1i91gKMP3f8erm0nUoCXNb7pyfhnQOC4cFKe0AeK38h8080Ag4otfXVaBBjnIqNtJ8773QcPkX74zH0L3gR8Sd9FbPKHDV7JrS8qSkmyw/tLOHpeRV2xzvR94t1+fb0m8DUP0IF3Nbw9b9zT7t/npWGkq8sbZL5GPsOAIaSaB7p5PFe6ISGvJ0RSRfxyIaMRgBli3wFdj+/sZHu0+6B8wS+ZwgJuUg+Yb4C7cmexN6/3Xsm/IwwSLiCxi2aVLI8eFGr1znifawuT+vEVfJxzxusNPPYLRuHUTA6cChdhwjRyBlHanI23sVqTPa/PSv8sAel02/tU9jTYOWZtBoVvGGfcCpyq3BbgPJVLTqCNX8Wz5wfdyCawKLBXOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXJJWm14UnNOeVA5M0srQ2Qvd3BaeXpFZzNuM05PUks0ZmNnaVlsQWFBRVhQ?=
 =?utf-8?B?ZjZZTlhXYWhNMCs0WDcvaFg4NVhtZ0k0b2VHQ3B4K1JMYVlvWFNEdHNCQ1Y1?=
 =?utf-8?B?YUM0M2VUdU1tZTIvWVJkK3ZMMHorRk4ya1EwamlLdFl1aWd2RmRDRy9MalZj?=
 =?utf-8?B?SHRiNWc1RUZnTnFSOU1nWkdkRk9VZE96RFgxL3haVDdpU0hrTDI0V1ZDbFo3?=
 =?utf-8?B?MTRBbnJIWHlsSFY5SWFoQzIzaXRWdERMZE4zdzAxcEF2R3N5N2lzWEFLOG9Q?=
 =?utf-8?B?LzBWaFlud0dobzBxaEFpL2I1Tll4amlxVElPRFIvSGhVUGxmMGN1Y09rc0p6?=
 =?utf-8?B?S01EaTdMelZLYXJ5aTYvdURhSDFvZzR4WEtZaVRaWHdhRVNMOW5GeEJZKzd2?=
 =?utf-8?B?V25uQ3dYc2FSSi9LVTA0NWdUYnplSjBmdUdHNnM1SzlpWFEzeEJrYjBwbFVi?=
 =?utf-8?B?MGh6eVZ3dm5CM1dZb0prL29QQVJza2ZMbGdmU1JHS3BvZTBmRTYya2NZWXJG?=
 =?utf-8?B?alhvMW15OTdNaHV5c2p4VlR5a0Ftb2F0OUVlQjJ4dlQwbVRxWnhMSjFnU2t1?=
 =?utf-8?B?TnplaS9zY0NYT0UyMHhtUVRjYkdST0tUaUdkYlNqTUlFb3Q1bGp3T0MyOWdN?=
 =?utf-8?B?WnRzbm5YcjRXNklvblhnekY4aHR4aEF3aXhCRVlhWDBTL01RUEljYXJzOVB0?=
 =?utf-8?B?QVJ2bDl6MzVvZ3dwTXF1SC95dWFOUGFtdmhTRksvR1ZvNlZ6cFdjaDhtZXFQ?=
 =?utf-8?B?YXdMMGpkcTZJa1d1dkZGaXVpa0FtYUl3WGFEZG03cy9LK09SMEppNDQrbzNH?=
 =?utf-8?B?bU45TmY0Q2RkbXZMZlNLZTZFYTFNTUhYOFJhYnlFb3pyUzkrTUdCUnVLMUtw?=
 =?utf-8?B?M3RzMUZUMk8wUm5NdldUcDEzVzVIUE02aUI5VUNTb0NHWFZMTXBtdHJpWXpQ?=
 =?utf-8?B?MHBYQnlUL3VDYjRxNnZJdGpMUng4RjdSaHJRLy92alpFQnVwdlJJOXBoc0RG?=
 =?utf-8?B?eDcvdVdKNFhpSUp0MWl6N1Uwc0UvcG1nOUQ5YzB4NUozc29NTkZEd3BZQzJD?=
 =?utf-8?B?eUJxTWJIT0wzVGZkbkd0VVkvMXVZWVJDRDFnRHBFUUk1OWhpZWJBSEJ6U3Q2?=
 =?utf-8?B?aVZ3cGRNKy80NTYveEVSL2ZDd25aaWpsTk1MVStxbjU4eTlkYVJYUkdmcDBj?=
 =?utf-8?B?TC8zMjJMUUJLaDBMenVSWmFSelJqM0tNMXFtSnc5V1c3QjJRMVhUck43UXkv?=
 =?utf-8?B?Snh0MGs3MzQ2cXQvdGVDblZVS2VFRFluL1NFMUJwYWRMSk5ESWZQcW1MM0JR?=
 =?utf-8?B?S2hBMlhSSFBtVW1EZ0hrQXF2QVFaYVlpRXNwYXR5TmdoODFiM3lpVTFMajVR?=
 =?utf-8?B?Z2dnTDdlcmJhOGlQWE9VSXpWSDBBWEx6aC9LMlJibG1QRDRDbGFMZGUzNnJU?=
 =?utf-8?B?c1ZDVWZJc0E0Zk5WVTcwdFFHYW5rMXFsalhyc3hKLytNcHFlelZDQi9sQ1pu?=
 =?utf-8?B?OG9GMEEvK2hZTERwbzYvYTFpZ0pLUmVBSDVHdUZEdXo4WW55QWE5azFlYU5T?=
 =?utf-8?B?WTdYcXlVRFh2QXV2SStKajh4N0Z5WDF1Q00vNm82N1paOFdDaUpLdHJ2aTdx?=
 =?utf-8?B?dnNyMlFua1VmSWhZS0dpSHRRT3ZMRnJPMHVudnVpeCtuVkd4eHJ5NVRHbC9t?=
 =?utf-8?B?UDNkMCtSR3pVNGFEbzRCQTdXNDN5ZUZxbVpTVklFd0tyWktCYk9NbzMrR09K?=
 =?utf-8?B?d2s0THFacXk0MVhXVWk2SXl6MXZqQ2tUWWdPaGRvdjFJNXlHaUxHY3RncDFh?=
 =?utf-8?B?YmI2QUY1QXRRRUo1RlFRWkRHRHd1eEplZUY1djFnV3FxK09rbUxmbXgvbWR2?=
 =?utf-8?B?UzVXejhvQlRUVnZITjdXeCtTMkNrTEZvbERPa01YRjlaYk8ycW0xZHZ2ZDFH?=
 =?utf-8?B?SlV1NFRWRlAyWVI1SkpBcng0VTNaOFhNVkNBV1hPalA5aDZhM3BPZ0ZWV0dl?=
 =?utf-8?B?TnI1bGVxSTNjZ3ZEcW1VcWZ4TXcvcm5BOXdhNXI4VThsaU9iK0VzeVd3UUp5?=
 =?utf-8?B?R3I0Zy9UdGowaWhWZWdJYStoMEtFa2RKVlltTWdKRWlHemhhRElsUnlOSUFy?=
 =?utf-8?B?aysvVEFNTEQzTU11VmR6a3VPVUpIUGpHbElCRHhLMFc1OUxTQy9GZUhOVTE3?=
 =?utf-8?B?Ym5Sak4vcFV2K1JEcXp5bHdjZkdhVEI1dGlZNllpbG53VlE0S01HNEs3NkF4?=
 =?utf-8?B?WDUwQ0h1VnUvbGJZajVDYUwyNnA4bkJYOHl6cWNndnZzSnlUVUJLSzlTNlg3?=
 =?utf-8?B?VEliamNyQkNMUW9MSWZPRHA2UndZUDZaUmVXaEJVcGxzeHlBOVJEQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b26e96-1f17-4feb-8101-08deb7406851
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 13:53:59.1007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxdXdI9JwpCLvMEbeIGckWEmTC+6gcOVQkb7BNGGBWX4ER7QPxT596arehbiF5NRVWukVqXrBaLOTLROhBazig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 5/19/2026 11:09 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, May 05, 2026 at 11:14:09AM +0300, Avihai Horon wrote:
>> Performance tests were done by migrating a single VM with:
>> * 8 GB RAM
>> * 4 mlx5 VFIO devices:
>>    - One device with 1GB of device data (stopcopy data) that runs
>>      workload during precopy so VFIO_PRECOPY_INFO_REINIT is exercised
>>      (generate new initial_bytes chunks during precopy).
> Could you elaborate a bit more on what workload is executed, and how that
> will affect REINIT reportings (e.g. is only one REINIT generated, or it
> keeps generating)?

Basically, I create and destroy RDMA resources (MRs, QPs, CQs, etc.) on 
the VFIO device in a loop for several iterations.
This generates several REINITs.

>
> Can I understand it in this way: without REINIT, device is forced to put
> those data into stopcopy size; then with REINIT, some stopcopy size is
> essentially moved back to precopy phase?

Almost:
Without REINIT, the device is forced to put this data in precopy 
dirty_bytes.
With REINIT, this data can be put in precopy init_bytes (and do the 
switchover-ack dance again).

Thanks.

>>    - The other 3 devices are idle.
>>
>> In this setup, VFIO_PRECOPY_INFO_REINIT reduced total migration downtime by
>> about 43%, and downtime attributed to the busy VFIO device by about 67%:
>>
>> With VFIO_PRECOPY_INFO_REINIT:
>>    1335ms total (~520ms from the VFIO device running the workload).
>>
>> Without VFIO_PRECOPY_INFO_REINIT:
>>    2352ms total (~1600ms from the VFIO device running the workload).
>>
>> Functional tests covered the main code paths and combinations, including
>> legacy and new switchover-ack across versions, for example:
>> * Migration between QEMU 11.0 (old binary) and 11.1 (new binary).
>> * Migration between two 11.1 binaries with different machine versions.
>> * Migration when the VFIO device has no VFIO_PRECOPY_INFO_REINIT.
>> * Migration when the VFIO device has no VFIO precopy support.
>>
>> === Patch Breakdown ===
>>
>> * Patches 1-2: Update Linux headers
>> * Patches 3-8,14: Migration cleanups and the new switchover-ack mechanism
>> * Patches 9-13: VFIO cleanups and VFIO_PRECOPY_INFO_REINIT
>>
>> Thanks.
>>
>> [1] https://lore.kernel.org/all/20260317161753.18964-1-yishaih@nvidia.com/
>> [2] https://lore.kernel.org/qemu-devel/20260421202110.306051-1-peterx@redhat.com/
>>
>> Avihai Horon (14):
>>    scripts/update-linux-headers: Add typelimits.h
>>    linux-headers: Update to Linux v7.1-rc1
>>    migration: Propagate errors in migration_completion_precopy()
>>    migration: Log the approver in qemu_loadvm_approve_switchover()
>>    migration: Replace switchover_ack_needed SaveVMHandler
>>    migration: Rename switchover-ack code to legacy
>>    migration: Make switchover-ack re-usable
>>    migration: Check switchover-ack during switchover phase
>>    vfio/migration: Re-query precopy size before sending
>>      VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>>    vfio/migration: Add Error ** parameter to vfio_migration_init()
>>    vfio/migration: Add new switchover-ack mechanism
>>    vfio/migration: Implement VFIO_PRECOPY_INFO_REINIT feature
>>    vfio/migration: Check VFIO_PRECOPY_INFO_REINIT during switchover
>>    migration: Enable new switchover-ack
>>
>>   docs/devel/migration/vfio.rst                 |   4 +-
>>   hw/vfio/vfio-migration-internal.h             |   2 +
>>   include/migration/client-options.h            |   1 +
>>   include/migration/misc.h                      |   2 +
>>   include/migration/register.h                  |  21 +-
>>   include/standard-headers/drm/drm_fourcc.h     |  28 +-
>>   include/standard-headers/linux/const.h        |  18 +
>>   include/standard-headers/linux/ethtool.h      |  28 +-
>>   .../linux/input-event-codes.h                 |  13 +
>>   include/standard-headers/linux/pci_regs.h     |  71 ++-
>>   include/standard-headers/linux/typelimits.h   |   8 +
>>   include/standard-headers/linux/virtio_ring.h  |   3 +-
>>   include/standard-headers/linux/virtio_rtc.h   | 237 ++++++++++
>>   include/standard-headers/linux/vmclock-abi.h  |  20 +
>>   linux-headers/asm-arm64/kvm.h                 |   1 +
>>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>>   linux-headers/asm-generic/unistd.h            |   5 +-
>>   linux-headers/asm-loongarch/kvm.h             |   5 +
>>   linux-headers/asm-loongarch/kvm_para.h        |   1 +
>>   linux-headers/asm-loongarch/unistd_64.h       |   2 +
>>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>>   linux-headers/asm-riscv/kvm.h                 |  11 +-
>>   linux-headers/asm-riscv/ptrace.h              |  37 ++
>>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>>   linux-headers/asm-s390/unistd_32.h            | 446 ------------------
>>   linux-headers/asm-s390/unistd_64.h            |   1 +
>>   linux-headers/asm-x86/kvm.h                   |  21 +-
>>   linux-headers/asm-x86/unistd_32.h             |   1 +
>>   linux-headers/asm-x86/unistd_64.h             |   1 +
>>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>>   linux-headers/linux/const.h                   |  18 +
>>   linux-headers/linux/iommufd.h                 |  48 ++
>>   linux-headers/linux/kvm.h                     |  46 +-
>>   linux-headers/linux/mshv.h                    |   4 +-
>>   linux-headers/linux/psp-sev.h                 |   2 +-
>>   linux-headers/linux/stddef.h                  |   4 +
>>   linux-headers/linux/vduse.h                   |  85 +++-
>>   linux-headers/linux/vfio.h                    |  30 +-
>>   migration/migration.h                         |  17 +-
>>   migration/savevm.h                            |   4 +-
>>   hw/core/machine.c                             |   4 +-
>>   hw/vfio/migration.c                           | 195 +++++++-
>>   migration/migration.c                         |  65 ++-
>>   migration/options.c                           |   9 +
>>   migration/savevm.c                            | 146 ++++--
>>   hw/vfio/trace-events                          |   5 +-
>>   migration/trace-events                        |   8 +-
>>   scripts/update-linux-headers.sh               |   2 +
>>   53 files changed, 1109 insertions(+), 580 deletions(-)
>>   create mode 100644 include/standard-headers/linux/typelimits.h
>>   create mode 100644 include/standard-headers/linux/virtio_rtc.h
>>   delete mode 100644 linux-headers/asm-s390/unistd_32.h
>>
>> --
>> 2.40.1
>>
> --
> Peter Xu
>

