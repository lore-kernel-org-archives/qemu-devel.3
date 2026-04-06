Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA834EF4ECC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9i6a-0004fZ-FW; Mon, 06 Apr 2026 07:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9i6Y-0004fG-Nr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:26:54 -0400
Received: from mail-westcentralusazon11013025.outbound.protection.outlook.com
 ([40.93.201.25] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1w9i6W-0006GZ-Q7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqMPNCFZ7R5vvJb/WRJQf1lOaPVqgwMNxnV7uzWcduNPNH9kR0Id+WCyIDNtKbv9pOAkw7RpeAlJB25t6ButlCTc/Dbch/WWQFjOZtaL9y/CZd6WdEOnOq8Qwrg+/BDpXzUDGiOX9u8OdlMFOfMZPIe2jAfTzrBdZ9vxvXRVtO48/0bV8U2u299pYQB6px1GyYm4nxnsvwuSsAo0bAQ14c3SL7EhFwN7pmflJQuNrTpt1SH1+YtqkRMdwA9EFtzz5ffQnplrzIJ3DNzESM/82vKb5QOFvNWYD85dLPd/X+BusD9IR/yriec7SThQs54IqMZrfTDF+YivtK3q9KEZPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfJo0070RaeYT3v63WeJIJMpzUgRj+WSAdvyEW1LwUA=;
 b=CU1UHTbHovDJTyzJ79rrSXPXetlgtgBQOFNxxNm0rDW37mrXY17AbqEKGVpvmCNOK3WJZGV8F4XKMOeTWvRYxAy+FZexkkebM28VIOQ7IYGOQJln2avrui1EHhydEMeo3MLWLut5ENa5tWuw7OrE1xDzc5W9wZKWMuW9SLMoGSDjGhTtQciD9fW7mIGrOkE33TgGu+6s+DKkFNm9k/jPyS0vhcLeIvX5h/GdimYNEOMZ9oGApQSOgFSDfQ+Rai+RISHKsk4fJpSAOidVHh2L/c3iL+rT9NnPRgINSA06HOaI6OFgi9JzLltesix31qG/c51D0ZF9PBE3cCHSUPAg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfJo0070RaeYT3v63WeJIJMpzUgRj+WSAdvyEW1LwUA=;
 b=f0eqUZx3kz2HP5TMhbjtfgpZFM8fAlOLzO+uCfCydkx8xJ+zoYmpUn8JQ+lznnf6j9jmKzIhO621Def5fhvAT0v0lzzedAHq8oCwJm32TLiyYY3uXeJznaiaM9n/oJiWDvrVmoFGNNFp4K1G4tDe9QCP1cv5v8n4QWzuTeDHSZZ9hCthbUr1RFektNqYxN7nb0v1v6RhhO/H/u0XS7V7lEv1IxrvB934rGegKMP60PQqmvV3LnC+lwbsaDcZZtCxXr2Iok8zjGa7EGNvWtWcRYuiWweF4HTlOfDFquYwx8p23D2XSB20ryGXBBNKhxkKcM0SRmGlgMd1KfS37aVmOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 11:21:45 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 11:21:45 +0000
Message-ID: <dc9e5884-c532-43e6-813d-e302a3cd970b@nvidia.com>
Date: Mon, 6 Apr 2026 14:21:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/12] vfio/migration: Throttle vfio_save_block() on
 data size to read
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson
 <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-4-peterx@redhat.com>
 <d075580a-ad4f-4047-b012-e5d9e4d6bc80@nvidia.com> <ac2B3VF8CSu3ytEE@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ac2B3VF8CSu3ytEE@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d105aa-f5cb-46ca-e344-08de93ceaf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qKttmPjvBgz+Xi9w3c0qxNsTjW/HZ40/ZUVkWEjydmWQhZq9v0BpJD6vjRxSxIBQaxF9/OcPMdwE623e8I+9J56haGy2XLXs+VOBqPwoP6UoYBs7YnAmTZ63E9ytikmqqj+Tb/juDEGPmwPsB8WzGhKujGXKPheypYLCLizkhiFZprmE6qgAkN7ZyQSsAvLSjz8y06coKERKfeFiybh76x46PK9zXYsxv2jhfTAMam8mjuywS7Y2ePLXWwvmqv+3vlXqbGXIryd/1NL4sF/z8j8nlz8GChurTMCbPUb1lyx+gaJetmCwu3VFadllKmta1zrkWYHZCywBu9x5DPPVnCMwzvnQz8x6JxWYwE/Oy7uXHxgvjqaASHpyz5xKvkYbOq4yNwHLqNt3yc5qvuOwBMSSMdOMGlHqwNQz8UMExcuVMYTuO/lophO0+K/0aYUZiyaPbV0K7dPjlgKApXS5tR589tVPzvRklg2SUbsAkCAKLIARwSbMkQPANNYghbjYvFjGEjcKU5VWnlYd+KY9fOKp/nLR+BXkInSAD/wNnPXr1CJs1NiwnFEa45/YBDVTNI/bT98Noc4pzlbuUz1pYS+EWoYuYfQMexgVj3HSK56vYRMXo7QMSexAlmXgagCajQcCo1pHpUDyJaHJMz2asxh4YNWmklM55mkeheMsDTflV2eoxU+GvhDxnO4GNYGDVFWJJlckyud/71TRZ7Sx3JT80mS7VVRfl+lJ+feYrzM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW1XbXkxc1hQNSs1Q1FzWFk5eHJWMDFMNG5XbUdxK1BydHpRaHVQeGxWOVZO?=
 =?utf-8?B?eC9TWitOYkVRb0l1RmxKMWd6ZmhDVGZVOTVML0FUOTI1VVg3dDRaWUNURTJX?=
 =?utf-8?B?eXN4OHJsUG5FTWRPOHRGYzNqcGFUSnJwZThnOTBybVlZQnZ4b040NmE1SzRo?=
 =?utf-8?B?MDdGaUYvNmw4aG9NTXROUzZIK3ZlQUdkVFNKV1lYYU9yV0ZROVUzUUdTV0U2?=
 =?utf-8?B?RHdubXRaaUVWV1MybFNTblBHaHBJTHpkelhwbXJFNDNnL3o1R21haHlCcUZU?=
 =?utf-8?B?MDB0bmxlVjdPemVrTnZ1NFBNZlZldVhrVDV0MjlLOVBGODJ2dUxGZzlaRVBu?=
 =?utf-8?B?MHd0blBmYURKUmhEL1JqSVMvcDJMVWtIdEdHeWF3UndmRGE5bFc0bzBsMXRO?=
 =?utf-8?B?bTgrVWVOQ0ZENzVjWFNVQ1Q3YzBsQ0xUY1YrUVNBZjF2bnRYQ1k2ajhDUkRG?=
 =?utf-8?B?cmI0SEZjcnVMQThCWWdoalZ0YW1FWndJdytMMmtGUmVxUEdiTVRadlJZOGlB?=
 =?utf-8?B?RkpnZDFqajh5V29PQStsdHJjeWZKTFJESitLM1J3K0ZvenM0WW94K3ozNHM2?=
 =?utf-8?B?dFpGbTdmeE90U1FJNlJmcVkyUk9PMUtRazBrNFVXcjRMZjhLdnJLVnpPdDRP?=
 =?utf-8?B?ZmNiaGt4TVVTRzcxb3BudFdlblFYSnE4cUc5Wm9ENGRjTFI1aTRCbGxYWm9P?=
 =?utf-8?B?bTNtSDVQRUdUVXBVQy9ob1VRbXMvZFk5K21JK1JndUhUSHkxQlpEODlNcUcx?=
 =?utf-8?B?bzB4LzcvREVKeUlkSjFLcTkydG16R0J2ZVFhSnJNbmVBeUY4YVhocy8vMmlX?=
 =?utf-8?B?SDJWYm5mcVhYZEhkZ1JTSXZNVS91ODRhVmluZlpzOWRSM0ZkQlVFUnhaM2pR?=
 =?utf-8?B?dzRGKzJmVVN5K1Q1RHg3NzZSdXhUL3BTNXUrTUI3L2xBZmJHV3FZZnNYUE51?=
 =?utf-8?B?TVhjSlpiem9VU1hHZFM1WEVDTmJLQVBYcERTY2FabEMzaWtoNHN5a2Q1YkhY?=
 =?utf-8?B?UUdBMlBlN0J4U2tmSHYwLzZvTmVYOXZnbVkzbXZYZGJYRHJrL2poL0p4OUpL?=
 =?utf-8?B?dXRIbExNQ1FqRHRUeUFsOFVhc2M2Yit4ZTUrOGxNbk9ieXZndHYzR1BNS1Bk?=
 =?utf-8?B?K3ZLSDcvQ0lONDBGV1ByYU9INmFsUWx5eTVnek1BUS9TK1VNNVhWSytJaFNC?=
 =?utf-8?B?RHdQeVJsYkUzNHlRb1FYNkMrTm9mWlk5b0Y2bktHTThGM2dsR1M2YTF3akEr?=
 =?utf-8?B?RFpEU3kwNTVwTVM2bzJ1dFQxZlJxMnVNRHZ4TWlyU2FJZFZTWjY4NlFra2Qy?=
 =?utf-8?B?aDZBald3L2FVN1M2Vlh4b09ScFZ0enhja003Zm01enNuREVNLzZxL3Z6ei9Y?=
 =?utf-8?B?bk9GT05RUmlJNDZ3YjZYNk84eGs1a05CcGdtYXR2MXRPN2JSU1JQZmJWeEhH?=
 =?utf-8?B?UTlWR3Y4NUxQNlBCMHlFVUhTK1ZlU1ZqUHhOMWIzMTRncW5ycUVSTmhkTDh3?=
 =?utf-8?B?d09WaTNRYUZRUFFiUC9EY08rM0NGeXFnY090cCtqMmJBMW1WUXBVbS9hVFMv?=
 =?utf-8?B?YUVMUDhMV2FTcXM4bXZuc3RWWkx2NlNKOVEyNWpNdFNuSWdkUjUrL3NWNS91?=
 =?utf-8?B?Syt5cGk1b3RYa0FZUmhHQjdEUFAyUjNSOXhpcmxvTEdnUXFMM2NpZ0ZQdGtu?=
 =?utf-8?B?UURBY0Njc3RLTTRhdlQzMW9LUkhMbEZzV284Z05wbmlWTDI3WWJsaUsrbWhK?=
 =?utf-8?B?ek1pQ2g4dVc4aEFRRmc2ZHZRYnFhR1p2T1RiS1FwcE5zNHVIOFM4M00xNEcz?=
 =?utf-8?B?Rm1iQWs1dHFLRDlMYzhQczVEaVp6RFo4N1hYU2UxYVJJeU9DdnpyRDg0d1dV?=
 =?utf-8?B?R2hUR0kzWDFjQ2ViNGFoNDZnaGhBQm5TWlQwZ3l3WEFzcGNGWnJwR1V5L0E4?=
 =?utf-8?B?aW5pTFRtQ3NHUG5UVU5OMFFsc1VtZXA5aUJpUEcvOUFzZXJBSEpOaUpxRGJs?=
 =?utf-8?B?N1ZhWFRqc0hlWU1iZFJQZ1Bnb0VmM29qVzNBTlFXNUN6YnVnSmV5M1o2YlNN?=
 =?utf-8?B?VTlka0wwTDNqS2NGWDdSeFR2QUdzcUFnK2xUb3BSTHRWMmM3YjJpZU4rL1ZD?=
 =?utf-8?B?SWg2alVvL2tlTTdPNENaSTlJaWJiblFPb2sxa0dNSm9QY1dkaFN2TWkrSWt4?=
 =?utf-8?B?elBYQjY1Ujd3TDhscUNaMFJXRVhYT1pGTTh4bTlUVVdSVGxndHNUSnlKNU5Z?=
 =?utf-8?B?VzJva1dDMlFUSmZsMHFHYVRic1ltT2hmUmJCYlR1V0xHa3o5TmZoREt3VVBU?=
 =?utf-8?B?MU1mYlVPMGRHYTRHUUZwYkZ2V2loanFaV09MUDlGNXo3V2ZsSWQvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d105aa-f5cb-46ca-e344-08de93ceaf98
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 11:21:45.4969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xkkJMYKJryLthDgDtsjt+565asHPB3EiCfSyTvbXSeW0ojw3VT7IcRueo6HfahRPkhtjeo4bntefvf5sRvN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
Received-SPF: permerror client-ip=40.93.201.25;
 envelope-from=avihaih@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 4/1/2026 11:36 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Mar 25, 2026 at 04:10:14PM +0200, Avihai Horon wrote:
>> Hi Peter,
> Avihai,
>
>> Thanks for sending this series.
> Thanks for taking a look.
>
>> On 3/20/2026 1:12 AM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> During precopy phase, VFIO maintains two counters for init/dirty data
>>> tracking for query estimations.
>>>
>>> VFIO fetches data during precopy by reading from the VFIO fd, after
>>> fetching it'll deduct the read size.
>>>
>>> Here since the fd's size can dynamically change, I think it means VFIO may
>>> read more than what it "thought" were there for fetching.
>>>
>>> I highly suspect it's also relevant to a weird case in the function of
>>> vfio_update_estimated_pending_data(), where when VFIO reads 0 from the FD
>>> it will _reset_ the two counters, instead of asserting both of them being
>>> zeros, which looks pretty hackish.
>>>
>>> Just guarantee it from userspace level that VFIO won't read more than what
>>> it expects for now.
>> The VFIO_MIG_GET_PRECOPY_INFO ioctl returns an estimation of the data size
>> currently available for reading. So, even if the ioctl returns X bytes, it
>> may be that there are more than X bytes to read or less than X bytes.
>> The code was written in a flexible way to handle such discrepancies.
>>
>> Because we are dealing with an estimation, I don't think we can assert that
>> the counters are zero, and I don't think reading only up to the cached size
>> gives us any benefit:
>> If the estimation is lower than actual available data, we are just deferring
>> sending of the remaining data to a later stage.
> Since we'll introduce cached size, having the read() only happen with the
> size reported still makes sense to me.
>
> We're not deferring to later that much, when dirty data reaches zero, we'll
> re-sync with everything including VFIO's VFIO_MIG_GET_PRECOPY_INFO.  So
> it's just splitting one last-phase read() into two smaller read()s.  To me,
> it sounds still OK if with that we can make sure the counter won't overflow.

The counter doesn't overflow today as well (thanks to the MIN calculation).

>
>> If the estimation is higher than actual available data, we may still read()
>> zero when the cached values are not zero.
>>
>> I think we should keep the code as is.
>>
>> Does that make sense?
> I can understand what got reported in VFIO_MIG_GET_PRECOPY_INFO may not be
> the total size of dirty data, but what the userapp can read.  That part is
> fine.
>
> Now, do you mean the size reported could shrink as well?

Yes.

>    Could you explain
> why, and when, dirtied data size can shrink?

First of all, the sizes of VFIO_MIG_GET_PRECOPY_INFO are defined as an 
estimation, so anything can be reported there.

But specifically for mlx5, VFIO_MIG_GET_PRECOPY_INFO includes two steps 
- query and save: first, the driver queries the device for the 
*expected* amount of data (that's the returned init/dirty sizes) and 
then the driver async-ly saves the data.
The query returns the *expected* amount of data, but the actual data 
returned in the save may be smaller.

Regarding VFIO_DEVICE_FEATURE_MIG_DATA_SIZE , I don't have a concrete 
example of data "shrink".
But I can think of a device that all its data is precopy-able and 
VFIO_DEVICE_FEATURE_MIG_DATA_SIZE may return X data remaining while 
actual data is smaller than X, simply because the uAPI defines that it's 
an estimate.

What I am trying to say is that VFIO_MIG_GET_PRECOPY_INFO and 
VFIO_DEVICE_FEATURE_MIG_DATA_SIZE sizes are estimates which are good 
enough for telling QEMU how much data is remaining, but shouldn't be 
used to make precise calculations on how much to read(). At least I 
don't see the benefit from it.

Thanks.


