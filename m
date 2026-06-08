Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B13CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYqn-00053T-3v; Mon, 08 Jun 2026 08:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWYqb-00053K-Ir
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:12:53 -0400
Received: from mail-westus3azon11010043.outbound.protection.outlook.com
 ([52.101.201.43] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWYqX-0003lG-SH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 08:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSzdv9MQVGpXnoH2Cc/PUTxgdbHPr1K8LdwjV/xz83TAzCpED/W46+nPAnIg7ZXnD5GtbZ+MtonA34uHnGWScIXSgkHP1p5R5ZnZfwcYUMdumCQeGmxeYJy1ujzJe1QGcWA1Q1jY8zl7k3qmj2R9Yl1Y/BRs4HGIKIraiNmA4wSRQ5/lrwxrxNRrmw7txMePWSQIZRt6Zl7GKqOzWL/gN7jZpMwrxsFQs/v+w4sp+9l06wHcRWG4wSzy6BXPEdZzv2nsKsEcNX+A7NbbkVbPycQpMooaLaw6DUOms1w4BzwDP0JlxROvdXxpH9KbEim3JJbbl64LqoluvxgbsBl4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9jsfUBKSH4fHLce5tlrivuQ9FJab75xgz8YSFDS+Xo=;
 b=byj/82LLoCpjdrlrz4S/Xl9299UcRK4pITvvML+V6pEUaTLid2/G8SefY5BOPQ3gHJol5CnMz8LZ1cqyyNfUqJ8Zikzomf7+ZgZPd5tJORqMK+RMjyQldG2TIXbFaPGWwbaRbQpgRIqNXAVrMdlg2b5iW3mcGjhG4jCdRlGKKjpokLDes8PWe4BpLHpUceiPcbIJ+UdLFyzesNI/z5v0/o86Qo0iSFs1S0xnuLZkiJBp7pHFACj49Hz2BqeaYpOg2FxOqH8A1Kre6kJ24N7TjhAB2PnqbkEfuUNDDIOs46ZY+8gOSSIXVBZ9RhZSdp4AgamPOOcLjJcUC2RdgIELJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9jsfUBKSH4fHLce5tlrivuQ9FJab75xgz8YSFDS+Xo=;
 b=qi9RcW4TX/1gKXzQpb9HvW8SjNRYU1N9WxVBwS1KurnwjfUWEt691Sx6zZyktQb0xdqDzFYzg6NDYDZNd1LjgqTXZyw5pcnWrcrxas18MwGUF6rc9AElc2EjvYEukqkJeDeNyuJc1+uI4KwM2c7A816OnA9DMyrpYX4DMxrKPa79Ah/7CVT2e//1Vv5RP2+ycclSkK7WQsbn9KHYCO9WwK6hD00kvgBBpPhyz8TYSuFSyb5hIW8Osh6QjNn1YlMRS8eRlCEzaNbgEqiyp3hUjiHfOsz0M4vwb7OMnkWJ5mBxZ9/rCB6zIHGPWccY5hsd8D7jEpJi5c2q/HgnftS0NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Mon, 8 Jun 2026
 12:07:38 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 12:07:38 +0000
Message-ID: <f27b2f9d-b72b-4fab-acc7-b560d29c95af@nvidia.com>
Date: Mon, 8 Jun 2026 15:07:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] migration: Run final save_query_pending at
 switchover
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, Gavin Shan <gshan@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-3-avihaih@nvidia.com> <aiCJHa-lT9Ycf6jq@x1.local>
 <aiCWynDFLoxtcctK@x1.local> <722fb01a-988b-4b21-9cca-aca1de2858db@nvidia.com>
 <aiGzVgatc_0Df21z@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aiGzVgatc_0Df21z@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a588e28-8404-4f23-9345-08dec55688c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|11063799006|6133799003|5023799004|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qxds+ZQLhJz3lmBHsyrU6i7mVJp+1Jq+uHzCu3XOSPR8JKS3Wl5LQqgUVVQ9QWl/OyVDn080d7N1tRCeKQnIXjgE13RCxGqBCBFX9+UVXqjozLMilu7lpTrnZUUgX/9AXViFzQC5eOeRNR4/YZQVHRf/G/qsuxRM8VaFzC3OEwNPKRNR6F4DMxp5AvW8Shhq7sTatq8b9SNN4Or+fj8EafInTYLiVD9CqewQSSMsiouu6813YNZ5oUfzU8g+ZsXVuWIgJPK9S4xsYLxrLtwm/lUh6t4KmztyaPvrKCCPxL74kgVIPi1OY58ITXH0BU5dKg8CZhvtW8GuTniW6tHoaMCWwnSoipcwFii99ia2ID8tcwYCW5ck8KIy99Ee4vdpGX9VKHwbTBe9H/rxn6uY1zILo0dvk6AaB0igS3wA4Atv04dU5llfL2Loh9AGRY5MdAqGlvpxhZ1yByl/MsPBKELEHO8VvHhwAEYYfCjjszHpYtPXoJCfmRvniV/nCMSfDLjrA/DI4VlkcDA5ieEJBStJmdCr9enrYxlN1wF1bGv1hk9v4X3/BSuHbUfrtgYvgOjJ47p+Dd/RV7vhRowgB7IFPDe2sEMS4pBQbrLSlzV7OneEf8lwXkZdN6rygfECwUbkr/R1/eQE9cZ0d9bPCsP70xhcZsh9ZFRgFPTmX+beaXyFwHXbJyFhHRb8zjka
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(11063799006)(6133799003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N28veFZkVDlSL2xldkZwQlREZ2d6K3NxU0VFbVJEcFlGd2ZRT05IUU00S2xM?=
 =?utf-8?B?KzJJTXhCZFVFb2xNUHdad3UzalJFTkNwbWp1S1h4UkxqRWIrOEgxejBNVUZa?=
 =?utf-8?B?VE9iWjY2ZE1ZMjBlWWJqaFFsZ2FjOVlRNnp0cTNveWNjbzNSTk5WU2ZQeUxG?=
 =?utf-8?B?Z1ZybldNbGlwT0ZDZDEraVdHdS9mOXJwOVFDNFExeHVHQ2RQRWU3eStaUUVV?=
 =?utf-8?B?NWJQU1dhOENlZ2I1WmZ1alNUZ2JSRkVKVllGRjNPaUhiUDZhZVh4TkRYMlZv?=
 =?utf-8?B?c3JUL3NabGYvV2tGOFM5c0F4UEwxZm9LdnVxR2Urd1pmbEtWMzFWc1hlaEFr?=
 =?utf-8?B?eklHNW5mZ2xXaTZ3dTl2dFg2ZHFSdmkycWtkNmNiK1ZsSjdTQy9vSWJQamVQ?=
 =?utf-8?B?cU9EdUlwUVhpL1I1aHlqTEFJRTMvaEo1akt0OUsvZHpYNkw4VjJ0V3hDYVcw?=
 =?utf-8?B?emZ3RTdKKzJ2VzZKcnY5Z0VVdmV5MzNDVmJwVjR1UDFBcHFIZFJSdmZtZTdM?=
 =?utf-8?B?YVRZZ2dpRUlER0d0ZVdGOVpLUEg1dmlQMWtRYVQxcXBFOXAxMWwwdXYxeTBw?=
 =?utf-8?B?eGdIcU9BRUh5TE5xd2U1RjVvcVpFV0RSV1JZY1pDRitOeDV4QTJJV2J6dUhU?=
 =?utf-8?B?U3RaL0hTMitDNTF0bm5yTWhGd0QxUjcrRDlKcW5wMk03QVR4dTRGSnZVbTdF?=
 =?utf-8?B?QTEyVHJ0K0JLNEtoempnRWhYUVhUaHU4NkhBMXZyMTRaOTVETGRZRk53U0Fj?=
 =?utf-8?B?MlZFMGdIcTZKM2tFOE41a1UzTjZwOFd6ZXlVTFNqVnVlODlnNUJtcVVQUlFl?=
 =?utf-8?B?SEI1Y0lOWGxIQ21NMUtQU0crZSttWlRPVCtIZVZzNVBJcXpZUWs5bi9vR2FT?=
 =?utf-8?B?QTltSDY3eXFQUmxKeWpqd3ZOTWQ4cmt2YVV1WndtZGZKdGhJNjIyV2VQbTlN?=
 =?utf-8?B?YnhNRnU5Wi9wWnJGd3ZvNHcvNTBmakNxOVE2L2duZzR2dFBTQ0JLZ3UvNXBU?=
 =?utf-8?B?YndJKzRMSnBBUUo0dEJGazllYnFpeEUzb1lVWDNiczVuMmpFVkVhWGxmU0E2?=
 =?utf-8?B?RENsV0JubVVra0Ria0hRMU1BT0ZMRittYW5LT0pPY1V5ZDhhTDFCaWNlQnQy?=
 =?utf-8?B?SGRlTVU5V1pPZkZiS1RMY2pDbWJnaFZvZXpsZHZaRERid0ZOZjFOSEdGazlV?=
 =?utf-8?B?RFZQRHRBK1I0eU1uOXJhVUgwMld1RFJOZkR5bUZzNHpBUVhrb0RYS0wybndm?=
 =?utf-8?B?QXhyWXBjMlBHNkF6NlVJSHlINThheEY5SlNRR0p2US9jT1Vra3c2bnk0b1lE?=
 =?utf-8?B?VDdMZ0RLQUk5RkQ4S25zS1RjNktrSzBSQ1BMVlp1dzQvdE1UTnVIZWlFSERN?=
 =?utf-8?B?WUZERUxIclQ3eC8zQVVsazR3cXZQb1dQRjNQWi9WVmt4SnNJUzVBckpMN0Rx?=
 =?utf-8?B?MWU2RjlXbFNUdURiQ2lqZnl6N1dqbTVpMVU0dnJqNDA3SWZ2U284S3diWXNN?=
 =?utf-8?B?aThIUWhYTTlYY0lVdWphTm11WEw4VWF4UFBIaUJmandPaC9ubnFuVmdLU1ky?=
 =?utf-8?B?K2dic3I4dURsUzJlcS9BTnAxeUkrM2R5OGQ5UnBMT0VjbjkvV1NtbTRONTRN?=
 =?utf-8?B?QkNyYTRjdG9VUnB5WXRsd3BXSE8rK2ZzYzVJOG1hN05hYWxkMHA4T1BsR01S?=
 =?utf-8?B?Z1JUWG9hM0FYU0lqQzJGT0wwS3k5eHhBZnZxN2lkdStkZmJsNE9MTUZIUUxR?=
 =?utf-8?B?UDl2UFJuYUtNVkM2SzgyV3hMdi9talBuNUwyU2lZbzBtUnBhclFxSUU2VDBM?=
 =?utf-8?B?THdMWWQ1WXJxRkFtQ2VxRlUwTlJVT2IzN0VYaEFETzd4bkhhSFJId2VCS1Fp?=
 =?utf-8?B?TGo5NWd5eHpCWHdIbUU3RlNCVGxJZDJKM1NldEZsVDZOMHBhMHpURFJldkVO?=
 =?utf-8?B?VFpCS3hVbitTMG01TitGNGx4b0xCR1YzY2pKNzlLaTdGZDZFaURydVJzLzhs?=
 =?utf-8?B?OEQ4SHR3dTVlemY5T1RWYnFXQkI3dWV3bHE1cUJTTjFINXNsT1FkUVErUmNZ?=
 =?utf-8?B?N2ozK081TXBhZUJsM0hZWXBibEVpQlJNUE0xZlpUK3l6WkhwaEl0UGRVZU1o?=
 =?utf-8?B?VjRFenNFYkZHYVAzbWJBRzR5QmFpaWRxZ0pjdFVlMEFwRlhMVlgrYWVsdDJ6?=
 =?utf-8?B?VzZONmVZMGlPSGhkR3VCd0M4NVUxaVlFZkJQcGpnUCs2bWJLSjU5MWl1RWFw?=
 =?utf-8?B?VktLUXZJaGRwUjk3cElBbEhXODdGcXR2NGhOYVdMVUgyMFJFaXBBUGd5WFBF?=
 =?utf-8?B?Zk9MbnRGZzFOQWc5ZGlTVGgzZzZ4QzBVS1hKbS81L1JPNnd6YXN5dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a588e28-8404-4f23-9345-08dec55688c2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 12:07:38.7884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzq6F0dJ5b5x/yTT6kdBsCfHGfA3uukF0w/VCYJh/5U/ED0CEb0/5p+GwxooxKIVFg1Q/RBKoF1ezmG3X5wBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Received-SPF: permerror client-ip=52.101.201.43;
 envelope-from=avihaih@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/4/2026 8:18 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Jun 04, 2026 at 06:29:01PM +0300, Avihai Horon wrote:
>> On 6/4/2026 12:04 AM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Wed, Jun 03, 2026 at 04:05:49PM -0400, Peter Xu wrote:
>>>> On Tue, Jun 02, 2026 at 12:26:10PM +0300, Avihai Horon wrote:
>>>>> Before switchover, the source needs one last exact pending query so
>>>>> modules can flush dirty state. This is currently done ad hoc in modules
>>>>> handlers. For example, RAM syncs its dirty bitmap in its save_complete
>>>>> handler.
>>>>>
>>>>> This should be a general concept relevant for any module, so extract it
>>>>> to migration core instead by running a final save_query_pending before
>>>>> switchover.
>>>>>
>>>>> The final query requires special handling by modules (e.g., it's called
>>>>> with BQL locked, during VM stop), so extend save_query_pending
>>>>> SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
>>>>> flag so migration modules can tell the last pending query during
>>>>> switchover from periodic iteration queries.
>>>>>
>>>>> Not all modules need the final query; skip it for those who don't need.
>>>>>
>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>> ---
>>>>>    include/migration/register.h   | 41 ++++++++++++++++++----------------
>>>>>    migration/savevm.h             |  3 ++-
>>>>>    hw/s390x/s390-stattrib.c       |  9 ++++++--
>>>>>    hw/vfio/migration.c            |  6 ++++-
>>>>>    migration/block-dirty-bitmap.c |  6 ++++-
>>>>>    migration/migration.c          |  7 ++++--
>>>>>    migration/ram.c                | 37 ++++++++++++++++++------------
>>>>>    migration/savevm.c             | 27 +++++++++++++++++-----
>>>>>    migration/trace-events         |  2 +-
>>>>>    9 files changed, 91 insertions(+), 47 deletions(-)
>>>>>
>>>>> diff --git a/include/migration/register.h b/include/migration/register.h
>>>>> index 5e5e0ee432..6f632123f1 100644
>>>>> --- a/include/migration/register.h
>>>>> +++ b/include/migration/register.h
>>>>> @@ -171,6 +171,28 @@ typedef struct SaveVMHandlers {
>>>>>         */
>>>>>        bool (*is_active_iterate)(void *opaque);
>>>>>
>>>>> +    /**
>>>>> +     * @save_query_pending
>>>>> +     *
>>>>> +     * This estimates the remaining data to transfer on the source side.
>>>>> +     *
>>>>> +     * When @exact is true, a module must report accurate results.  When
>>>>> +     * @exact is false, a module may report estimates.
>>>>> +     *
>>>>> +     * It's highly recommended that modules implement a faster version of
>>>>> +     * the query path (for example, by proper caching on the counters) if
>>>>> +     * an accurate query will be time-consuming.
>>>>> +     *
>>>>> +     * @opaque: data pointer passed to register_savevm_live()
>>>>> +     * @pending: pointer to a MigPendingData struct
>>>>> +     * @exact: set to true for an accurate (slow) query
>>>>> +     * @final: set to true for the final query during switchover. When final is
>>>>> +     * true, the query is called with BQL locked. Otherwise, it's called with
>>>>> +     * BQL unlocked.
>>>>> +     */
>>>>> +    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>>>>> +                               bool exact, bool final);
>>>>> +
>>>>>        /* This runs outside the BQL in the migration case, and
>>>>>         * within the lock in the savevm case.  The callback had better only
>>>>>         * use data that is local to the migration thread or protected
>>>>> @@ -210,25 +232,6 @@ typedef struct SaveVMHandlers {
>>>>>         */
>>>>>        bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
>>>>>
>>>>> -    /**
>>>>> -     * @save_query_pending
>>>>> -     *
>>>>> -     * This estimates the remaining data to transfer on the source side.
>>>>> -     *
>>>>> -     * When @exact is true, a module must report accurate results.  When
>>>>> -     * @exact is false, a module may report estimates.
>>>>> -     *
>>>>> -     * It's highly recommended that modules implement a faster version of
>>>>> -     * the query path (for example, by proper caching on the counters) if
>>>>> -     * an accurate query will be time-consuming.
>>>>> -     *
>>>>> -     * @opaque: data pointer passed to register_savevm_live()
>>>>> -     * @pending: pointer to a MigPendingData struct
>>>>> -     * @exact: set to true for an accurate (slow) query
>>>>> -     */
>>>>> -    void (*save_query_pending)(void *opaque, MigPendingData *pending,
>>>>> -                               bool exact);
>>>>> -
>>>>>        /**
>>>>>         * @load_state
>>>>>         *
>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>>> index 96fdf96d4e..10b3d78a5f 100644
>>>>> --- a/migration/savevm.h
>>>>> +++ b/migration/savevm.h
>>>>> @@ -45,7 +45,8 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>>>>>    void qemu_savevm_state_cleanup(void);
>>>>>    void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>>>>>    int qemu_savevm_state_complete_precopy(MigrationState *s);
>>>>> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>>>>> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact);
>>>>> +void qemu_savevm_query_pending_final(MigPendingData *pending);
>>>>>    int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>>>>>    bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
>>>>>    void qemu_savevm_state_end(QEMUFile *f);
>>>>> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
>>>>> index c334714b31..aed0c6844d 100644
>>>>> --- a/hw/s390x/s390-stattrib.c
>>>>> +++ b/hw/s390x/s390-stattrib.c
>>>>> @@ -190,12 +190,17 @@ static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>>    }
>>>>>
>>>>>    static void cmma_state_pending(void *opaque, MigPendingData *pending,
>>>>> -                               bool exact)
>>>>> +                               bool exact, bool final)
>>>>>    {
>>>>>        S390StAttribState *sas = S390_STATTRIB(opaque);
>>>>>        S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>>>>> -    long long res = sac->get_dirtycount(sas);
>>>>> +    long long res;
>>>>>
>>>>> +    if (final) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    res = sac->get_dirtycount(sas);
>>>>>        if (res >= 0) {
>>>>>            pending->precopy_bytes += res;
>>>>>        }
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index fb12b9717f..95072d6664 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -622,12 +622,16 @@ static void vfio_state_pending_sync(VFIODevice *vbasedev)
>>>>>    }
>>>>>
>>>>>    static void vfio_state_pending(void *opaque, MigPendingData *pending,
>>>>> -                               bool exact)
>>>>> +                               bool exact, bool final)
>>>>>    {
>>>>>        VFIODevice *vbasedev = opaque;
>>>>>        VFIOMigration *migration = vbasedev->migration;
>>>>>        uint64_t precopy_size, stopcopy_size;
>>>>>
>>>>> +    if (final) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>        if (exact) {
>>>>>            vfio_state_pending_sync(vbasedev);
>>>>>        }
>>>>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
>>>>> index 7ef3759e53..66ed91de03 100644
>>>>> --- a/migration/block-dirty-bitmap.c
>>>>> +++ b/migration/block-dirty-bitmap.c
>>>>> @@ -767,12 +767,16 @@ static int dirty_bitmap_save_complete(QEMUFile *f, void *opaque)
>>>>>    }
>>>>>
>>>>>    static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
>>>>> -                                       bool exact)
>>>>> +                                       bool exact, bool final)
>>>>>    {
>>>>>        DBMSaveState *s = &((DBMState *)opaque)->save;
>>>>>        SaveBitmapState *dbms;
>>>>>        uint64_t pending = 0;
>>>>>
>>>>> +    if (final) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>        bql_lock();
>>>>>
>>>>>        QSIMPLEQ_FOREACH(dbms, &s->dbms_list, entry) {
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index 7488a94206..df8ed3a9fd 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -2787,12 +2787,15 @@ static bool migration_switchover_prepare(MigrationState *s)
>>>>>    static bool migration_switchover_start(MigrationState *s, Error **errp)
>>>>>    {
>>>>>        ERRP_GUARD();
>>>>> +    MigPendingData pending = {};
>>>>>
>>>>>        if (!migration_switchover_prepare(s)) {
>>>>>            error_setg(errp, "Switchover is interrupted");
>>>>>            return false;
>>>>>        }
>>>>>
>>>>> +    qemu_savevm_query_pending_final(&pending);
>>>> Not needed for postcopy, we can move it to migration_completion_precopy().
>> While currently not needed (because VFIO isn't compatible with postcopy),
>> AFAIU, generally it is needed because we have here a switchover similar to
>> precopy case -- the switchover decision and VM stop at stopcopy_start() are
>> not atomic, so theoretically a device may want to request an ACK in this
>> gap.
>>
>> But that's all theoretical and not necessary currently.
> True, then it makes more sense to keep it here.  You can enhance the
> comment below with VFIO implications for the future DMA faults when it's
> ready.
>
>>> A better idea is.. we can drop migration_bitmap_sync() in
>>> ram_postcopy_send_discard_bitmap() too, then we can keep this one.
>>>
>>> But then, let's properly document this, both for precopy and postcopy
>>> cases.  One example:
>>>
>>>       /*
>>>        * The final query to the whole system on dirty data to make sure we
>>>        * collect the latest status of the VM.  For precopy, source QEMU will
>>>        * dump all the dirty data during switchover.  For postcopy, this will
>>>        * properly update all the dirty bitmaps to finally generate the
>>>        * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
>>>        */
>> The last dirty sync is done a bit differently for postcopy case:
>>    postcopy_start()
>>      ram_postcopy_send_discard_bitmap()
>>        migration_bitmap_sync(rs, false);
>>
>> 1. The last_stage parameter of migration_bitmap_sync() is false (shouldn't
>> it be true here as well?).
> Yes, I think it should.
>
> The only thing uses that last_stage so far should be ARM64 where some dirty
> data can be generated to bitmap not ring (only matters when dirty ring
> enabled).  In that case AFAIU we need that too for a postcopy switchover.

Ack.

>
>> 2. It calls migration_bitmap_sync and not migration_bitmap_sync_precopy,
>> i.e., without precopy_notify calls.
> This is another thing I feel like got overlooked in the free page hint
> feature.  The only notifiers registered is that balloon device, logically I
> think we need these notifiers in postcopy too to make sure we properly stop
> the free page hints seeing BEFORE_BITMAP_SYNC, then don't start it
> (vm_running=false) in AFTER_BITMAP_SYNC:
>
> virtio_balloon_free_page_hint_notify():
>
>      case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
>          virtio_balloon_free_page_stop(dev);
>          break;
>      case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
>          if (vdev->vm_running) {
>              virtio_balloon_free_page_start(dev);
>              break;
>          }

Actually, looking more closely in the code, I see that it's not used if 
postcopy is enabled [1].
So calling the precopy notifiers in postcopy switchover is basically a 
no-op.

Then it seems fine to call migration_bitmap_sync_precopy from postcopy 
switchover flow.

[1] See commit fd51e54fa102 ("virtio-balloon: don't start free page 
hinting if postcopy is possible")

>> If we need to keep the above differences for postcopy then I guess we'd need
>> to introduce different final query flow for it. It may be cumbersome.
>> Do you think we should do this extra effort to support it, or, as you
>> suggested, we can drop the final switchover ack check for postcopy for now?
> IMHO you can add a small patch for replacing the postcopy sync first with
> migration_bitmap_sync_precopy(last_stage=true), copy Gavin and Wei in that
> patch only:
>
> Gavin Shan <gshan@redhat.com>
> Wei Wang <wei.w.wang@intel.com>
>
> Then this patch can be on top.

Sure, will do.

>
> I'll loop both of them in while replying, to see if we can collect early
> comments.
>
>>>> I'd also appreciate a short comment explaining why the final query is
>>>> needed.
>>>>
>>>>> +
>>>>>        /* Inactivate disks except in COLO */
>>>>>        if (!migrate_colo()) {
>>>>>            /*
>>>>> @@ -3285,7 +3288,7 @@ static void migration_iteration_go_next(MigPendingData *pending)
>>>>>        /*
>>>>>         * Do a slow sync first before boosting the iteration count.
>>>>>         */
>>>>> -    qemu_savevm_query_pending(pending, true);
>>>>> +    qemu_savevm_query_pending_iter(pending, true);
>>>>>
>>>>>        /*
>>>>>         * Update the dirty information for the whole system for this
>>>>> @@ -3336,7 +3339,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>>>>>        bool complete_ready;
>>>>>
>>>>>        /* Fast path - get the estimated amount of pending data */
>>>>> -    qemu_savevm_query_pending(&pending, false);
>>>>> +    qemu_savevm_query_pending_iter(&pending, false);
>>>>>
>>>>>        if (in_postcopy) {
>>>>>            /*
>>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>>> index fc38ffbf8a..4e3f442593 100644
>>>>> --- a/migration/ram.c
>>>>> +++ b/migration/ram.c
>>>>> @@ -3376,10 +3376,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>>>>        rs->last_stage = !migration_in_colo_state();
>>>>>
>>>>>        WITH_RCU_READ_LOCK_GUARD() {
>>>>> -        if (!migration_in_postcopy()) {
>>>>> -            migration_bitmap_sync_precopy(true);
>>>>> -        }
>>>>> -
>>>>>            ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>>>>>            if (ret < 0) {
>>>>>                qemu_file_set_error(f, ret);
>>>>> @@ -3442,25 +3438,38 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>>>>        return qemu_fflush(f);
>>>>>    }
>>>>>
>>>>> -static void ram_state_pending(void *opaque, MigPendingData *pending,
>>>>> -                              bool exact)
>>>>> +static void ram_state_pending_sync(bool exact, bool final)
>>>>>    {
>>>>> -    RAMState **temp = opaque;
>>>>> -    RAMState *rs = *temp;
>>>>> -    uint64_t remaining_size;
>>>>> -
>>>>>        /*
>>>>>         * Sync is not needed either with: (1) a fast query, or (2) after
>>>>>         * postcopy has started (no new dirty will generate anymore).
>>>>>         */
>>>>> -    if (exact && !migration_in_postcopy()) {
>>>>> +    if (!exact || migration_in_postcopy()) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    /* Final pending query is called with BQL locked */
>>>>> +    if (!final) {
>>>>>            bql_lock();
>>>>> -        WITH_RCU_READ_LOCK_GUARD() {
>>>>> -            migration_bitmap_sync_precopy(false);
>>>>> -        }
>>>>> +    }
>>>>> +
>>>>> +    WITH_RCU_READ_LOCK_GUARD() {
>>>>> +        migration_bitmap_sync_precopy(final);
>>>>> +    }
>>>>> +
>>>>> +    if (!final) {
>>>>>            bql_unlock();
>>>>>        }
>>>>> +}
>>>>> +
>>>>> +static void ram_state_pending(void *opaque, MigPendingData *pending,
>>>>> +                              bool exact, bool final)
>>>>> +{
>>>>> +    RAMState **temp = opaque;
>>>>> +    RAMState *rs = *temp;
>>>>> +    uint64_t remaining_size;
>>>>>
>>>>> +    ram_state_pending_sync(exact, final);
>>>>>        remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
>>>>>
>>>>>        if (migrate_postcopy_ram()) {
>>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>>> index 23adaf9dd9..22cb6a15c6 100644
>>>>> --- a/migration/savevm.c
>>>>> +++ b/migration/savevm.c
>>>>> @@ -1795,7 +1795,8 @@ int qemu_savevm_state_complete_precopy(MigrationState *s)
>>>>>        return qemu_fflush(f);
>>>>>    }
>>>>>
>>>>> -void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>>>> +static void qemu_savevm_query_pending(MigPendingData *pending, bool exact,
>>>>> +                                      bool final)
>>>>>    {
>>>>>        SaveStateEntry *se;
>>>>>
>>>>> @@ -1808,7 +1809,7 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>>>>            if (!qemu_savevm_state_active(se)) {
>>>>>                continue;
>>>>>            }
>>>>> -        se->ops->save_query_pending(se->opaque, pending, exact);
>>>>> +        se->ops->save_query_pending(se->opaque, pending, exact, final);
>>>>>        }
>>>>>
>>>>>        pending->total_bytes = pending->precopy_bytes +
>>>>> @@ -1817,16 +1818,30 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
>>>>>        /*
>>>>>         * Update system remaining dirty bytes whenever QEMU queries.  It will
>>>>>         * make the value to be not as accurate, but should still be pretty
>>>>> -     * close to reality when this got invoked frequently while iterating.
>>>>> +     * close to reality when this got invoked frequently while iterating.  Don't
>>>>> +     * update in final query as some modules may skip it if not needed.
>>>> IMHO this specialty isn't needed.  We can just make all modules report and
>>>> making sure we don't deadlock on bql.  AFAIU, CMMA never takes BQL, while
>>>> dirty-bitmap should conditionally take it now.
>> I didn't want to add unnecessary work for the critical downtime path, i.e.,
>> unnecessary exact queries.
> If there's any real slow sync, then likely it needs to happen.. because of
> the same reason why RAM do the sync, to make sure the data is latest in
> QEMU migration core (say, bitmaps).  If it's a fast sync then it doesn't
> matter.

Yes, but what I meant is that currently cmma and block dirty bitmaps 
don't issue a final slow sync during switchover, only RAM does.

But it does seem harmless to add this final sync for them.

>
> query_pending() so far should achieve both functions: (1) synchronize dirty
> info with whatever remote modules like KVM, enforced when exact=true, (2)
> report.
>
> VFIO is just special because VFIO dirty info accuracy never rely on
> query_pending or whatever it collects, so it's purely a way to estimate for
> size of dirty, hence (2) only.
>
>> I am not familiar with the other devices, but if you think it's negligible
>> for them then we can drop this specialty (in VFIO I'd still like to skip the
>> stopcopy size query; using the cached value is good enough IMHO).
> Yes VFIO is fine but it'll be good to comment.  Let's try to drop them, I
> want to avoid below "if (!final)" if possible.

Alright, will change that.

Thanks.

>
> Thanks,
>
>> Thanks.
>>
>>>>>         */
>>>>> -    mig_stats.dirty_bytes_total = pending->total_bytes;
>>>>> -
>>>>> -    trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
>>>>> +    if (!final) {
>>>>> +        mig_stats.dirty_bytes_total = pending->total_bytes;
>>>>> +    }
> [a]
>
>>>> Then we remove this too which is counter-intuitive..
>>>>
>>>> The rest looks all reasonable.
>>>>
>>>> Thanks,
>>>>
>>>>> +    trace_qemu_savevm_query_pending(exact, final, pending->precopy_bytes,
>>>>>                                        pending->stopcopy_bytes,
>>>>>                                        pending->postcopy_bytes,
>>>>>                                        pending->total_bytes);
>>>>>    }
>>>>>
>>>>> +void qemu_savevm_query_pending_iter(MigPendingData *pending, bool exact)
>>>>> +{
>>>>> +    qemu_savevm_query_pending(pending, exact, false);
>>>>> +}
>>>>> +
>>>>> +void qemu_savevm_query_pending_final(MigPendingData *pending)
>>>>> +{
>>>>> +    g_assert(bql_locked());
>>>>> +
>>>>> +    qemu_savevm_query_pending(pending, true, true);
>>>>> +}
>>>>> +
>>>>>    void qemu_savevm_state_cleanup(void)
>>>>>    {
>>>>>        SaveStateEntry *se;
>>>>> diff --git a/migration/trace-events b/migration/trace-events
>>>>> index de99d976ab..1c9212d3e2 100644
>>>>> --- a/migration/trace-events
>>>>> +++ b/migration/trace-events
>>>>> @@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
>>>>>    qemu_loadvm_state_post_main(int ret) "%d"
>>>>>    qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
>>>>>    qemu_savevm_send_packaged(void) ""
>>>>> -qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>>>>> +qemu_savevm_query_pending(bool exact, bool final, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, final=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
>>>>>    loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
>>>>>    loadvm_state_setup(void) ""
>>>>>    loadvm_state_cleanup(void) ""
>>>>> --
>>>>> 2.40.1
>>>>>
>>>> --
>>>> Peter Xu
>>> --
>>> Peter Xu
>>>
> --
> Peter Xu
>

