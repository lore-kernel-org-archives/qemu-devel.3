Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EBBCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBXxb-0002IZ-JD; Tue, 29 Sep 2026 09:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBXxa-0002IB-35
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:33:30 -0400
Received: from mail-northeuropeazon11020080.outbound.protection.outlook.com
 ([52.101.84.80] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBXxX-0004D1-Hj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 09:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+2Cq9dk4+1+ZkCmjwOEDRfKJ1Hk9c43oZkTKuRS8I2/oQckCYRVMzXLADadeamg/qmTc06zTUBx7AQwk4UrkGBmJ6z+C+M3PFeQVqsmgeDddSuXjjnxwzE0bRu2LCJTqXUkPCknEuyybitlyKyLF+F21CTtz9CfzaQronzX/HnHreQbKS6+VtPgxC6rpaQv6cQbZnXFakX2Dqac1tgas1bUtfNsmQwe8st5KPJFnBbpLAoEinIVVMAUVRkiFJHSrcz1WtJVfY/maP93/voM9gIj/8/+gDhFn+gkmKAt5KhaBokyWdNU8cS8cjmbEUHn7OfS4KHynMF1zabCItK3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJFeFoIWhQJWv3VjJIQL6IyV4gdYFucc6Oxo0vKkkVA=;
 b=W66kHEtAJ22J8+x6MVAW6Y5MTl//ImyCtI+IqdoPxyZpQlwYWPMbOAGmvn8aO2Yfp8KVcjmCkafydWx229NW76vtxKq0yS+AJoi4BYODIW9BFThnkhwaLsifJyKRPIM6xEKKMW6aaMUEHci4PPbH0nqav/3t1yS4B6y/TkLIPJ66kH3dgOHKkjlgEJkY5sS0LtYKgAVKJiDtR/18CEe7pIWcoHCZPhVYROiQgoy/l0CqzyocfhEBr/0bD4wcwEt4hWZ94yDJGjEwpcbiFn5LSY5VVuM2tjTQceQlAJXlvqIfUq7F7PXXZijN5TDo2jVsJBIFXAJQjSpCNvY1CipnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJFeFoIWhQJWv3VjJIQL6IyV4gdYFucc6Oxo0vKkkVA=;
 b=K6cOW/4hrooaKpbpMnsuzp3+zan0DTrJMtb+ajK7xXQG4SlDbYaV9izdl1GaqtMmlAE+0PCnLQxMMZ99cEWWHPSWfK8j83nTBkid5QUjAsJYs267nOQ/xO9f0q56u+OkYQiQUjCUO9ru/uB4A9kd5ebx1YBVf775eEJ7FOagI29ICxmExOmlpW3xsyr4EFiQlavULCpq8H4WBmcYb/MhqwX0Xxm8q1vLvWN8fgsyUjrn5kSRmor6fUbwVoHC+jvAEbup+kwp93R6JoI5NGapELjVpUQ6SOhztGAG+Lwe8mU3ROHWb5cM0+pRj3VieJEem8RfIkxyQoWvGHP2bAinmw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DU0PR08MB8280.eurprd08.prod.outlook.com
 (2603:10a6:10:40c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Tue, 29 Sep
 2026 13:28:21 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 13:28:20 +0000
Message-ID: <b4b8545c-18f4-47bf-9182-a326f8a9136e@virtuozzo.com>
Date: Tue, 29 Sep 2026 16:28:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/16] migration/cpr: forbid saving duplicate CprFds
 into hash table
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru,
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, mst@redhat.com,
 clg@redhat.com, den@openvz.org, sgarzare@redhat.com
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-1-6ef9ef033c35@virtuozzo.com>
 <arp4-P14_JP_-ABU@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <arp4-P14_JP_-ABU@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DU0PR08MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6d56ad-37c1-4b89-b3dd-08df1e2d8786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|5023799004|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vA2YLX5fGc2fk1FDDs/bPQZajGwHOmEE8JgwzJlqj1u/JRyH90TK/YiIvteJsM7TP1iW4/acmPGlfPmHVOXh63vjsCxNaVOzO2w2ILbmWsiWdp0djsF2m5rzSyVhHTNwV3tqlSPV05rYwfn7C74EI2NNUTWi9rXB8tx455MWWbQONm3ocDp5ATseJOV/CfmmBefYyiygiRZKnGtFQpdwCP7RLPm+ucmBUWrCz4pNYqY2rEvUNdC4IzLf+kwNictN2nntqMjtIfg/RAioyNXbvuBB1l2hDSMjH52HNoYmEAMcgjYBxJMUGuy7ZMf2YDnGZc+OfuIWESBE4KqEk6poNgrE4WRm0mypTEjy8STk+w9Zx4kIqNHKdI6vHiT7XuFoAhnfsOcsxtXxiHNFWDZrlaRCFFzF0d/0hmzyBcee7gSOdHPOhE62Og/ayUOETGEZamOLaCvjk6hSYnGmqRsqIN+l6FIRk0jhu5rzhD0s5H7jIfFVmJ2S4ZlymOK2jvXr768o5aa/mdJgnAQ1ndxMJ5Gmp3T/6wwoGxuYs7/8g+g7dLDmO4439q/coLciTV//QFssSVkXRKQWkmq88IGbAB5fCJaeQcYv/LihTmTFDNpzBYbjDNmWIk0fDM5hNbpn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(5023799004)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUlOdXJkaFlQMXNYVTdDd1ZKVlpqbFhLRVE3M0RuQUJhUzdweEY2UmxIbktu?=
 =?utf-8?B?cS82dHoyUU55cDZmMlhWTFdwRGxEbDdpS0tUNFpOUzVqSk9UbDlOdEVjWEM1?=
 =?utf-8?B?a0d0RmdvWDZjM0F1a3FkbkZiUnRNRlJJdnVtdmhJNVJUMHlQc2MrVzR0M3Z4?=
 =?utf-8?B?cVBsR3RDSElaNk9tV0dnbzBVL3FWZU5vWUcrQVlyRm51UDg0MnM2Vi9aQ3No?=
 =?utf-8?B?aVFZRWZQeE5XNUF3MjVheTFXZEc5YmtiMU1Fd2ZmSE5CUDRWQzdidmJmSUtD?=
 =?utf-8?B?aEZvMUQvNkowQVRWY1Fva1ByNUhPZjdieDA2d28vQzlJVFUxN2pYM2tIeXpE?=
 =?utf-8?B?RTFkV2s4S2VpVDJ2eGdPMkZ6bzhTZkVoN3QvVUF6UHVtSHFkVitMc3dOWUhE?=
 =?utf-8?B?M3FPcVJHaTZyV0hXRUplRUswSE5MeHoxS29xSVE5V29WcnJOVFdFQXQ3b0dB?=
 =?utf-8?B?YlppTEhhVnkzTGp1R3RvMUVRcHZzNnNlUk92aU1qenU4MjRZK1NKS3ZrdDZr?=
 =?utf-8?B?L3ZGdU9GT3pJUzVHbHNWam91OENFUlVqRmFRcm9kVVZzRGRrMy9PNFNiMjRK?=
 =?utf-8?B?c2NiLzI1ODdna3RtY1JoSzZISWFvYkZlVFNyUUZ3ckFJbEFzQ3hRMzkzYkhD?=
 =?utf-8?B?VEg3VFVoUVhtM2ZaSFVudVZFVHc3N1hTekE4WlRtdnhRS3l5NGZuYXJaMUYz?=
 =?utf-8?B?a1NrTDlLU0dZQ0lRTmJWbFJaaWQyang4MmtjSUdkQnNHSFFiMEcwNWM1OXFC?=
 =?utf-8?B?UnpMQ0R1Z3N3eFFSZytWUE1nMWZ4OU0yTktLU0dLdzBNM01iNVVtMDBjU3ZW?=
 =?utf-8?B?WGdqa3oyMnNOTmF4RCt3cXU1bldRYS9memhVVzVvUnJBdFNBK25IRjZBcFFN?=
 =?utf-8?B?Smt2eEh5T0ZkZWI0clFWQjAvbHNFN3d6Y3hIU2prWjJadmhlQUpXcmlkSkZ1?=
 =?utf-8?B?MzJjL3JheitOak5PTUNrcUZUVERSa21helR5SlA3WnIwNWt0YWRpRTQraURG?=
 =?utf-8?B?Wlo3RjVMU3c2bG5YaXVINXZSdWNKTVhPUVZSbmpxaVVkTllaNXdLaDE1NVF6?=
 =?utf-8?B?aTdnclphQmxzVmRMaEh2WEdxOWhmNDBNSW9sM3pTNFZkUzk1ZmtOalpBWXdq?=
 =?utf-8?B?emlQRDNyd3owa0t4UVpjc1lDWEsrT2tMNFhQUThHUHBUcmhYYzk0NjY3NUo5?=
 =?utf-8?B?T0QzQlZxTHVaK3RVdEJKQ0lqK3F4Skx0bVR5U2J2S21TTGw0NXZFQjNRM2RD?=
 =?utf-8?B?RDhZZjhVUjNlMW14WUlEUGpXcVNDa3RYZFdxd0RKS0MwMjZGaThGZkNpZlRy?=
 =?utf-8?B?NEE1SzlTSFo1NEFJUHFrdVgybDFQQklzZ0NLaHJabWp4MytFSDZDZHc2N09j?=
 =?utf-8?B?b0Vlb2VwT3VDTGQrSzZlME5EekltM1d4ckQ2SmxEaDdnY0l1WHRkQ1luYWF1?=
 =?utf-8?B?a3BCNG1RVE8vbU84RWlNVE5BeWxuT1BFWHNxakQ3TDVFZFR6SVEwN0JXRUY0?=
 =?utf-8?B?NERST2wzNS9FTVVXUkt5QjlPMFZSQmU1Q3h6bnJKNUUyMU15aDZ0cmFpY09n?=
 =?utf-8?B?R0FHQjk0bUludFdsYThRa29HNk5UbFphOGU1N0lGd3Y1aG9UN2ZUYmlneHpE?=
 =?utf-8?B?TGxqdWF3UFVYZVE4dWZuL3hxaUxFZU5rKzAwS1ZxOFBmNzM2WE9QWjFQUnZv?=
 =?utf-8?B?aTl6V2pzZ2ZUeTdZSWtGMllQdkJhOVNxampFREhYU1VJbFRxUmVZdjJnVFpI?=
 =?utf-8?B?SHc2WVArdzdjNnhZUEtCOW0yUEZSb0pCYnFpTklxMitZUXVSd2s2SHJ4MHpQ?=
 =?utf-8?B?cFhvNXpLdlk4WDBUYjljaXJBM1VyR3lESlIwMDNkVysveCtUZkRvVE1saW83?=
 =?utf-8?B?cDlZQ1FHZlk0eDgrdmMvRE9ZcjE1RUNKMTJ6NVlUOXhjMVFBYzhwTkxhTUcz?=
 =?utf-8?B?bWNxTERQYWZhbzBLOTNSeG9kcllwaE43TTNwZ3VXQTRHOXVwMnhpTUJldVhm?=
 =?utf-8?B?dkxid1BsZEJLMDFyeVBIcCtZWjF3QmJCYXVzNzg0QmVLZ3dBTVRtVGVyL0dv?=
 =?utf-8?B?dGNRS2lRYVJjQ3I0ODZsZ3Bka1U5MHVJRDZyNDluRmw4eDNHV2tIeHlHQWhk?=
 =?utf-8?B?NE5ESE1jUVlhWkg4Y0pLWHZoVXk4dzI3Ti9YVnlpY3ZUR1dDZ3Q3c1BIc2I0?=
 =?utf-8?B?MXJRN0N5UUVQWHJTM2RRd2VoL1dST25vUGNldnJTQ2sxMXlGeGdrQmZBTnYr?=
 =?utf-8?B?L0pjV2pTNER6Z256T0lQTUJYc3ZvbEdlc2VHQmwwazFGck1MaEp1WVhad01M?=
 =?utf-8?B?aGgxQW41b2Z4ZWNqTVhjLzRCaW85NEtHdGJKYnYvMnQ4TVkyVGdkaTFlcEx3?=
 =?utf-8?Q?T8lV7P3FL2ttHsLY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6d56ad-37c1-4b89-b3dd-08df1e2d8786
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:28:20.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tU7k4bS7s9VvunogExUwjlQLLJ0fAaq+BOX/PuYr/KKOeyVTpJoa/lWnxsfnsSfMSpfoZYGae2RPHKeNp4XfBLPDG0yO79gWCZjUUyhvAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8280
Received-SPF: pass client-ip=52.101.84.80;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/28/26 5:26 PM, Peter Xu wrote:
> On Fri, Sep 18, 2026 at 04:46:52PM +0300, Andrey Drobyshev wrote:
>> In its current form, the mechanism for saving CPR FDs into hash table
>> has flaws.
>>
>> The CPR fd hash table uses the same CprFd for both key and value, and
>> is created with a key destroy function.  Inserting a second element
>> with the same (name, id) key leads to a use after free.  According to
>> GLib docs [1], g_hash_table_insert() keeps the old key, replaces the
>> value with the new element, and destroys the new key.  Thus when
>> inserting 2 CprFd elements fd1 and fd2 with equal keys we get:
>>
>>   g_hash_table_insert(table, fd1, fd1);  /* table has fd1 -> fd1 */
>>   g_hash_table_insert(table, fd2, fd2);  /* table has fd1 -> fd2, fd2 freed */
>>
>> Any subsequent cpr_find_fd() for that key then returns freed memory.
>>
>> This is reachable whenever two CPR-aware objects register fds under the
>> same name, and it happens long before an actual CPR, since cpr_save_fd()
>> is typically called from .realize(), i.e. at boot time.
>>
>> Apart from the UAF itself, when the user decides to perform CPR migration,
>> on CPR target we'd get corrupted FD from the hash table and fail somewhere
>> in .realize() for affected devices.
>>
>> As a solution, let's altogether prohibit adding CprFds with duplicate
>> keys.  Since FDs are being registered for a subsequent CPR right at the
>> startup in .realize(), that'll allow us to error out and exit QEMU (or
>> fail a device hotplug op) gracefully instead of delaying potential
>> problems for later.  To do so, let's make cpr_save_fd() return 'bool'
>> instead of 'void' and provide an 'errp' argument to it.  That way caller
>> becomes responsible for checking the return value and propagating the
>> error.
>>
>> Also update all the callers to use the adjusted interface to keep things
>> compilable and bisectable.
>>
>> [1] https://docs.gtk.org/glib/type_func.HashTable.insert.html
>>
>> Fixes: a181df93bb3 ("migration/cpr: use hashtable for cpr fds")
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  backends/hostmem-memfd.c   |  5 ++++-
>>  backends/hostmem-shm.c     |  5 ++++-
>>  backends/iommufd.c         |  4 +++-
>>  hw/vfio/container-legacy.c | 17 +++++++++-----
>>  hw/vfio/cpr-legacy.c       | 10 +++++----
>>  hw/vfio/cpr.c              |  6 ++---
>>  hw/vfio/pci.c              |  5 ++++-
>>  include/hw/vfio/vfio-cpr.h |  6 ++---
>>  include/migration/cpr.h    |  2 +-
>>  migration/cpr.c            | 55 ++++++++++++++++++++++++++++++----------------
>>  system/physmem.c           |  5 +++--
>>  11 files changed, 78 insertions(+), 42 deletions(-)
>>
>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
>> index e21c5a3f2e2..a95a4368a9e 100644
>> --- a/backends/hostmem-memfd.c
>> +++ b/backends/hostmem-memfd.c
>> @@ -54,7 +54,10 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>      if (fd == -1) {
>>          return false;
>>      }
>> -    cpr_save_fd(name, 0, fd);
>> +    if (!cpr_save_fd(name, 0, fd, errp)) {
>> +        close(fd);
>> +        return false;
>> +    }
>>  
>>  have_fd:
>>      backend->aligned = true;
>> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
>> index 806e2670e03..2fa7b823a62 100644
>> --- a/backends/hostmem-shm.c
>> +++ b/backends/hostmem-shm.c
>> @@ -48,7 +48,10 @@ shm_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>      if (fd < 0) {
>>          return false;
>>      }
>> -    cpr_save_fd(backend_name, 0, fd);
>> +    if (!cpr_save_fd(backend_name, 0, fd, errp)) {
>> +        close(fd);
>> +        return false;
>> +    }
>>  
>>  have_fd:
>>      /* Let's do the same as memory-backend-ram,share=on would do. */
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 15f2a513501..45fd2e44c7f 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -85,7 +85,9 @@ static void iommufd_backend_complete(UserCreatable *uc, Error **errp)
>>          if (cpr_is_incoming()) {
>>              be->fd = cpr_find_fd(name, 0);
>>          } else {
>> -            cpr_save_fd(name, 0, be->fd);
>> +            if (!cpr_save_fd(name, 0, be->fd, errp)) {
>> +                return;
>> +            }
>>          }
>>      } else if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>>          error_setg(errp, "/dev/iommu does not exist"
>> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
>> index 7ac7b372145..1d2c8356189 100644
>> --- a/hw/vfio/container-legacy.c
>> +++ b/hw/vfio/container-legacy.c
>> @@ -844,16 +844,21 @@ static void vfio_group_put(VFIOGroup *group)
>>  static bool vfio_device_get(VFIOGroup *group, const char *name,
>>                              VFIODevice *vbasedev, Error **errp)
>>  {
>> +    ERRP_GUARD();
>>      g_autofree struct vfio_device_info *info = NULL;
>>      int fd;
>>  
>> -    fd = vfio_cpr_group_get_device_fd(group->fd, name);
>> +    fd = vfio_cpr_group_get_device_fd(group->fd, name, errp);
>>      if (fd < 0) {
>> -        error_setg_errno(errp, errno, "error getting device from group %d",
>> -                         group->groupid);
>> -        error_append_hint(errp,
>> -                      "Verify all devices in group %d are bound to vfio-<bus> "
>> -                      "or pci-stub and not already in use\n", group->groupid);
>> +        if (!*errp) {
> 
> IIUC this implies something not done right.  If we add errp into
> vfio_cpr_group_get_device_fd(), then when fd<0 (failure case), we should
> set *errp always.  Maybe this should be moved into it?

Agreed.  I'll just move error handling into
vfio_cpr_group_get_device_fd().  Should look cleaner.


>> +            error_setg_errno(errp, errno,
>> +                             "error getting device from group %d",
>> +                             group->groupid);
>> +            error_append_hint(errp,
>> +                              "Verify all devices in group %d are bound to "
>> +                              "vfio-<bus> or pci-stub and not already in use\n",
>> +                              group->groupid);
>> +        }
>>          return false;
>>      }
>>  
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index 2d40d8baeaf..14a06a1fa59 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -254,15 +254,16 @@ bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
>>                                                  &vrdl->listener) == 0;
>>  }
>>  
>> -int vfio_cpr_group_get_device_fd(int d, const char *name)
>> +int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp)
>>  {
>>      const int id = 0;
>>      int fd = cpr_find_fd(name, id);
>>  
>>      if (fd < 0) {
>>          fd = ioctl(d, VFIO_GROUP_GET_DEVICE_FD, name);
>> -        if (fd >= 0) {
>> -            cpr_save_fd(name, id, fd);
>> +        if (fd >= 0 && !cpr_save_fd(name, id, fd, errp)) {
> 
> IMHO it's slightly error prone to do oneliner like this, this might be
> relevant to the above !*errp question.

Ditto.
>> +            close(fd);
>> +            fd = -1;
>>          }
>>      }
>>      return fd;
>> @@ -291,6 +292,7 @@ bool vfio_cpr_container_match(VFIOLegacyContainer *container, VFIOGroup *group,
>>       */
>>      cpr_delete_fd("vfio_container_for_group", group->groupid);
>>      close(fd);
>> -    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd,
>> +                &error_abort);
>>      return true;
>>  }
>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> index ffa4f8e099d..6e1659dcddc 100644
>> --- a/hw/vfio/cpr.c
>> +++ b/hw/vfio/cpr.c
>> @@ -32,11 +32,11 @@ int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>  #define STRDUP_VECTOR_FD_NAME(vdev, name)   \
>>      g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
>>  
>> -void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> -                             int fd)
>> +bool vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
>> +                             int fd, Error **errp)
>>  {
>>      g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
>> -    cpr_save_fd(fdname, nr, fd);
>> +    return cpr_save_fd(fdname, nr, fd, errp);
>>  }
>>  
>>  int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 428ab2f0698..ad13f2306f1 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -76,7 +76,10 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>>      }
>>  
>>      fd = event_notifier_get_fd(e);
>> -    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
>> +    if (!vfio_cpr_save_vector_fd(vdev, name, nr, fd, errp)) {
>> +        event_notifier_cleanup(e);
>> +        return false;
>> +    }
>>      return true;
>>  }
>>  
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index ecabe0c747d..e57766e7e2b 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -60,7 +60,7 @@ void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>>  void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>>  void vfio_cpr_load_device(struct VFIODevice *vbasedev);
>>  
>> -int vfio_cpr_group_get_device_fd(int d, const char *name);
>> +int vfio_cpr_group_get_device_fd(int d, const char *name, Error **errp);
>>  
>>  bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
>>                                struct VFIOGroup *group, int fd);
>> @@ -71,8 +71,8 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
>>  bool vfio_cpr_ram_discard_replay_populated(
>>      struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
>>  
>> -void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> -                             int nr, int fd);
>> +bool vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> +                             int nr, int fd, Error **errp);
>>  int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>>                              int nr);
>>  void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 56fb67e6b4d..3ad084d5bab 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -28,7 +28,7 @@ typedef struct CprState {
>>  
>>  extern CprState cpr_state;
>>  
>> -void cpr_save_fd(const char *name, int id, int fd);
>> +bool cpr_save_fd(const char *name, int id, int fd, Error **errp);
>>  void cpr_delete_fd(const char *name, int id);
>>  int cpr_find_fd(const char *name, int id);
>>  void cpr_resave_fd(const char *name, int id, int fd);
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index bca43e9bf35..aeb9ad12392 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -82,10 +82,27 @@ static GHashTable *get_cpr_fds_hash(void)
>>      return cpr_fds_hash;
>>  }
>>  
>> +static CprFd *find_fd(const char *name, int id)
>> +{
>> +    CprFd key = {
>> +        .name = (char *)name,
>> +        .id = id,
>> +    };
>> +
>> +    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
>> +}
>> +
>>  static void cpr_fd_hash_insert(CprFd *elem)
>>  {
>> -    /* Use the same CprFd as key and value. */
>> -    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
>> +    GHashTable *hash = get_cpr_fds_hash();
>> +
>> +    /*
>> +     * The same CprFd is used as key and value, and the table owns the key.
>> +     * Inserting a duplicate would destroy the new element while keeping it
>> +     * as the value, so a duplicate key is a bug in the caller.
> 
> IIUC this comment is slightly misleading.  It almost says "the caller can't
> do this because the impl of the API does that", but logically the caller
> shouldn't care about the internal impl..

It's not the implementation we care about, but the documented behaviour.
 And the docs say the key_destroy_func will be called on duplicated
keys, if provided.  The "bug" on the caller's side here is that caller
doesn't take it into account, yet providing same object for both key and
value.

> There're two relevant issues, IMHO:
> 
> (1) the memory crash described in this patch, solid, needs fixing one way
>     or another
> 
> (2) if there's real use case of injecting the same (name, id) fd twice, or
>     should we forbid it?
> 
> For (1), fixing it like this patch would work, but then the comment is
> wrong here, and it means we already said YES to (2), hence (1) relies on
> (2).
> 
> But I do see the existance of cpr_resave_fd().  I confess I don't know why
> it existed and didn't check.  That looks exactly like sometimes we can save
> the same fd twice, if the 1st one is fd=-1.  Any quick answer?

AFAICT the sole purpose of cpr_resave_fd() is to be called from
different sites with the same (name, id, fd), to make sure the key is
registered in the table.  What it does:

  - no entry - save it into hash table;
  - same FD already there - do nothing, table isn't updated;
  - different FD present - abort as an internal error.

That means there's no case of injecting the same (name, id) twice into
the hash table.  That is actually consistent with our patch here.

I'd leave the code as-is and only reword the comment, if that's fine
with you.

Thanks,
Andrey

