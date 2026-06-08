Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75097CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWb23-0000kh-Bn; Mon, 08 Jun 2026 10:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWb21-0000kT-AB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:32:49 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wWb1z-0007jB-Kv
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xcvd0yGTgoLHHCKcNm2LGEgkjJ+obHxIECACvFPrSr61x/cp5vwzhHpL1KbLnzExS9ZJ5g4OWGfW8abNc3/jOKrnAPEnwbl4F62pieprYjtWySMZo0SrQzFlnJpjJASmxZw4LrMvLNPknBMWBeNTMCJS4NxoMTZ/Buej7O7MQUFil5ucYKOM02b4neaE9tXvL+SfCDhwvtXzTc9zp2Yf/DaJNnjJzz9/1KmLJ4wvYU/i6tkMb4ikjkb97S/Jya0fasu13OzBRCo9QD2zFkFnR6A7jSFMW8kPxvNWDdbhv8mJt4BcvAmN2Ua2OWyrEEnFsDdkUS1P4asxdBrAuTz3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwY5jHOL/IJGxve1e12izbtAOkbxoCP6i6SVOHeF8dw=;
 b=efFamzhNP0znOGYet/mGNwIdZ3LGS/4yXpVpaJNdrHGrTVLFzlQhgpPRwDKEnzXnKl5am+c+ZFYtEvIkMKWzaB+a+vfwIJprsUkdIUG6YAWRiOSkXDvP53S1I+5wfA3bjBt3dXPcx+NFlSQApLChY/Ucb0NsWRhbZcqYrf5QMDSEDzcKrcAjGnrgiEWTxRSsIe3pbXHKme3nsBZYqC5qSuYMUHKiNhewZ+XQ9NqoGOqGDdAOJ7PRFkNTNBVuZqpHSoXe1/dnGAPMo87BPWcCpdgE5CNfh2h7dgMJaFZDdQNa6VKc1I4+UXorrpmFrTX45LM3hwxuAKWbW+DKj7W97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwY5jHOL/IJGxve1e12izbtAOkbxoCP6i6SVOHeF8dw=;
 b=ULC9GIq/992Q2pxPz1WMJ/h5mJUdfFsuRKdqTcq03L6cSSWZqAGLyJiaUzQiA7qt/tx3AataHUNJcBgfYtW49zkNGkMoc2qnxE08O7BadUfXqbb2vRnH3FuDGo1ci148t9puYvL36Tg/lg+VSa50o0K/+fNt/dT/Js5ArwS4yryrTDzq5SvhzMzAedy3Uj3uUBc83K3zH98JaSHUdLPYKbbcuopfbDO95fdaqP002Ao+aMLxsyBKOe3nJ3oIqzc2EmYciTfHou/kAkaBUxnpzwPKGBfGtKq1G2mNE+Xqe63E7mChtNm6LNIXvt738QK8ZIVg+TCvIAXG08FliFznlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 14:32:37 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 14:32:37 +0000
Message-ID: <4d953317-1446-40db-8e21-b92001967bec@nvidia.com>
Date: Mon, 8 Jun 2026 17:32:30 +0300
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
 <aiGzVgatc_0Df21z@x1.local> <f27b2f9d-b72b-4fab-acc7-b560d29c95af@nvidia.com>
 <aibNja4cvhmgaioj@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aibNja4cvhmgaioj@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::19) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: c84c921d-9648-4cf5-ec48-08dec56ac975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pfPTn11/Ba6qIyJRGN1EbeVH+qmxJD4d1gUNp5WE16kwZDBMYJ6dnSWd2a4P0p9jWjkrIJJF4ugHKh4YHt/NV9jHlQLVbmmAn86sqGjEVPhSPbX8JPRSMwf+Qvsql9pqoOwue9VfMumibpKVQEe/jjnGSuSmtwIcEPhZXAMTAhknPg572v1gTEmnl8gWU11UPI8p3qFx0nniRpeZ+iMBreLW5oMRWIwSR6HrA0fPf43NQV7z7ObwtRBVYgd5ZP991JU9Ng66D+gfu929LNjn7DloBCCDzPZOyusyeIya6/4+BKzjDApQo2A2wFgVQrw+cntFFQ1yxtXobYm6j3NGeFiA6gxmFBTTBg9TLxiWb1pjaYAUsG5D+wFYy8YaUkD/HUUNXyWGnYlf2hBkodQkYvvhvvB6IiYZj+yd7+q/i5R8nLHElWsT+L4N2HPi7nJ3QO/2w1dBiBVJzgX3bAMnkHdlvv3Xm3DNjIr8yjlV/VjhRmSV4Y2VRNc5vSwXiFD84E23dTNcZilABHDWgTAxeZcvY2TW3eUNvkagBQHQJc6Y3JXumEcdU3iIwvw6xrGkKKtx3BfvgpQjnjpiBhon0csZ4MGcyI/imqMWtS/L/D+k4H0NncSTY5CmUgFyhSgHEz5LdWJcNNAN9TQDlggF+HkTlYbSQjqTfpyoZi3zvvsKe6Xl7q/eSoyMTHyaCqFs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJlWit4QlFSOGZ3Mm52bVl3V0V5MnJERHhSdyszNTlMeUk3NjdpUzdJTXND?=
 =?utf-8?B?SGxPYjdmSHQ3aWMycXhkOW9IRGwxdGtOeERuN1RzdlY5OU1CNTlidzlwVmFJ?=
 =?utf-8?B?Sy9RUmJjdUFnNmZDTitiTHdpTDVRN3pSV0wzN3BDckNPbGltaGhMRVdJTDZn?=
 =?utf-8?B?d05STWhkdTAxOUozMjYzeEpCSWZKNEdFRXMrcVZNVkJwa3RwN3FkTnBudUdN?=
 =?utf-8?B?eWpaaUdaaGZpSGkwc1ZXQ3RoZ0RKbXQ5TVYrRUtrSDhGUk82YnpGNTJZRWxQ?=
 =?utf-8?B?TkVxRWNCdHJJczhQZHhJVUhkTzZRMWpWU3pvb3Y1Q2dFZXJtNU9oK1Y1WVFY?=
 =?utf-8?B?elBieVBFelpXZlpaTjJ2RE9mSFNKTUl5TEQ2TlN0d1ROblRCemFoUUVBL2U1?=
 =?utf-8?B?UzJsZkpSeEtyWlBzSkFiV0tTY2JHVEFRY281MmFtQ3N5ZUljZ0dnTkVLM252?=
 =?utf-8?B?QzVKV2V2NzBHRWFSZE9ZRHlyeXlRdVhSY1pxcnduQVBkNXA4Qm0wbUxvZUJ5?=
 =?utf-8?B?K2pmekJYZW1mK3poMlZjOEd2NGp4dEtILzQxVk1oa1hncmNlNDBwZk9VSkhm?=
 =?utf-8?B?cmxUS0JzZnVVQzR4RXNmU29kaVdRTWUxdmMxa3BQckM3RHJxR01EeHRmeUpa?=
 =?utf-8?B?Q2hzeGRWeHNJTjNQUTlVOUxxeXU5MTEybktwN3l0SzV2UjBmWUk1SEg4MUEv?=
 =?utf-8?B?czVxdEJWSVNsdkxzdStYYU94UWhxN2FBbE95aFVYRjBnZkxXZ3RmbE5xMURL?=
 =?utf-8?B?b09NTU8vT2FIVmVrd3pybVUwUldHWmVaNUZLa2l2UkdnZDA1U0Y5REd4YTBt?=
 =?utf-8?B?UUNpS3ZzVGtpcTVRTTNjd05GalVSb2t6eTlHZVhMWVF6cWxPNHlsOGp2MU1V?=
 =?utf-8?B?cC9FeWJVdGJUYjhFc2tWM3pNSThWMnJPOE53N0xxVHZtdVVOcHY1Vk9EWVU0?=
 =?utf-8?B?QitTU2ZGc1BlQnMrcjVzakNPNkRSTFQyckwrSThUSzlxUDd5V0laY1NtWExX?=
 =?utf-8?B?TXYySzEwYmZNUDFHaGQ0bC91Q2VjeDJXOXhsalorV2c2M3RZMVhPaE4rdkNa?=
 =?utf-8?B?bmMyNHB5Nm5yVXpWM0FNZGtOc29JVVlBVThoUkRkUUFrU2NHTFFEMkxaMjJV?=
 =?utf-8?B?ZzZDLzNKWVMwc0MzSlpOL3NzMTNMdG9nVjdLcGV0ME95YlFUZVZjZ1FCS1ps?=
 =?utf-8?B?OTVSR0Y4WEh3WE0xa0JHSHZKRFdyRHJTWmxNZmkvWS9MQ3pMSDVCeXhmNDAw?=
 =?utf-8?B?S3ZIUVIrSE9wNDJFZ1EzMmVGdDVmVlFzZ2Vid2NPaVp4OWdSOU5HcmJ2Vmkw?=
 =?utf-8?B?R3hRTHNJMHJyS0FlKzhkNDVOS1JodmtCSFZ4aS82MWFuWDVsVmhkL3BnT3Qr?=
 =?utf-8?B?Qndpbi9ORW1PdHY0RXl2VStDZkx6WDhyQkVKNThIck9DcHBkLzdJazZBMmpT?=
 =?utf-8?B?MHVrVkpoQmsvblVuUW1KelB2OVBBVmJFWDJIMzZXRG9ic1VQbUVZZlV2QVcw?=
 =?utf-8?B?Z0JKSDlmNlBVaGJJdTZUR2UvZG5yL0tQeDNXdzBtQ2g0OXpBUVBNK1d5eFc2?=
 =?utf-8?B?bkVPSU12R0dmc1g5RWl5TmY3WDNJbC95aWx1L2lBRXkxbVlJU3ovVW1uSDJp?=
 =?utf-8?B?WmViMnArN0R1d0VpbGZWUmlqL24xWVdGZ1JnVGdHQUExbTFPSkRWOGRUVUp6?=
 =?utf-8?B?NlBqdU5uTmtJUW9Xdm9DVytQK1IxM1dkTld1eFZLN3hpbzFTQ1NQTnZwQnBC?=
 =?utf-8?B?NW1qU1lBZVlSemxqTm1RbG84STR2LzZJcE5jYmkvK2IyNEwreHFHbDNSYTJz?=
 =?utf-8?B?UHU0ZURBTmluaUZkTWdzTFJQUVppUWoxeE5HUTkydDlhWnp6UW5WK0pqL3Zr?=
 =?utf-8?B?RFhWaDF4VnBkSU9FekttL2dibElTQUNPRWdBTzZNUmtqNzQ3ODV5SDBTVnBY?=
 =?utf-8?B?Y1NXL3dXcnpQWjdJRnNtUVdJbGYzZWpCa3phdktjb2libGpCU3hZa25Ua2dS?=
 =?utf-8?B?QWZ1RGZhalFHSVNyU1lPN1p6V0NlVGFJelQ1WE9kcEZQRGJ0M1FIRkdwZzJ3?=
 =?utf-8?B?WWhLaWxGbkZPR0F2cFR4N3NNYzJ4N0tZQnptOUkyMWlNM1pmcDdKTEhjTklD?=
 =?utf-8?B?OFROUmJXT3BCUlp3SmN6TmpXNHZDZkI1ZUxOQUI5UWoyM0c3N3R1ajFveis5?=
 =?utf-8?B?MkFvSi9lejNabnJNblB1SmJnUzNsL3ZTYnZIcnc5T1pzUitjY0ZhUytia2ts?=
 =?utf-8?B?MjZ3VWl6a3FYNjBaNnF5QjgvZklvQVJwMm5RUWhSeGJFK2RxTnUvcFBmUDZx?=
 =?utf-8?B?WjQybWR5d3Z6M3dQcG9QcDRTMGw2THZVNWc2WmhsY3BJUktDaVNUUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84c921d-9648-4cf5-ec48-08dec56ac975
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 14:32:37.3289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS/aBhDJQF2MeCCkY3qERNdFXwJ2wFne3gMDWttXveXrMF8dvGwFiEgzVGrruh6VY6yy/StI8MRzkHngHQ4MZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=avihaih@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 6/8/2026 5:11 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Jun 08, 2026 at 03:07:32PM +0300, Avihai Horon wrote:
>>>> 2. It calls migration_bitmap_sync and not migration_bitmap_sync_precopy,
>>>> i.e., without precopy_notify calls.
>>> This is another thing I feel like got overlooked in the free page hint
>>> feature.  The only notifiers registered is that balloon device, logically I
>>> think we need these notifiers in postcopy too to make sure we properly stop
>>> the free page hints seeing BEFORE_BITMAP_SYNC, then don't start it
>>> (vm_running=false) in AFTER_BITMAP_SYNC:
>>>
>>> virtio_balloon_free_page_hint_notify():
>>>
>>>       case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
>>>           virtio_balloon_free_page_stop(dev);
>>>           break;
>>>       case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
>>>           if (vdev->vm_running) {
>>>               virtio_balloon_free_page_start(dev);
>>>               break;
>>>           }
>> Actually, looking more closely in the code, I see that it's not used if
>> postcopy is enabled [1].
>> So calling the precopy notifiers in postcopy switchover is basically a
>> no-op.
>>
>> Then it seems fine to call migration_bitmap_sync_precopy from postcopy
>> switchover flow.
>>
>> [1] See commit fd51e54fa102 ("virtio-balloon: don't start free page hinting
>> if postcopy is possible")
> Yes, thanks for the pointer.  So it relies on the DONE event rather than
> stop() to really stop the reporting.. good to know it was already bypassed
> for postcopy, I definitely forgot that change.  For now, we can add another
> trivial comment if we want.  So what we really need is final=true for
> postcopy.
>
>  From a notifier semantics POV, IIUC it's also correct to notify here in
> postcopy_start(), because at this stage it is still precopy.  Source QEMU
> will move to postcopy stage (starting from POSTCOPY_DEVICE state) only if
> postcopy_start() succeeded.  So a precopy notifier, no matter the analysis
> of balloon use case, should theoretically apply here as well.

Agreed.

Thanks.


