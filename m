Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E65EC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 14:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtMw-0005V2-3P; Tue, 13 Feb 2024 09:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZtMv-0005Ur-08
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 09:02:41 -0500
Received: from mail-dm6nam12on2045.outbound.protection.outlook.com
 ([40.107.243.45] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rZtMs-000119-IB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 09:02:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5fIJstCRJvseRdtXU97AASsMNhgmboNr6/RVY8JVmfat9VyGagbNK8+WWFYNXysxbv05xMwgm/4KWVUHg1qECQ5gHeCvlWx5NNvkOBnXBSNqj4qm53jMEuuF54iof+5joSUaF5JLHSdpwS+Vvykpkrd556NPWBkySjcSRnRGtFXehvKEMx4py2A24eLGnrZgySWKGDPwuiwN2iii+uftbH7bZOufZ3swQKYNC5YT7Otg1Qc2xNA48sJe6VcZeden/HNCyrhDUtyx3pIENX/P84DM7ySPnhgzTcAxJD2l4uCBXgJ8FwiUiRuWm73dLstW+HqkSGU/z7/D1Uhremf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbE814slMNUEqAWmRhw3shv5OFdCwPD0+greH7LN3LA=;
 b=Ut0rRPrdiLpLm7L90cUtSI4ep8pDrk2qfSaIFC9CXTXBaTIqbwEYdlNTU/vJP84+eDxIJyRlStjEGQ3GK1FSymUXIWD7pkmWn7qACyf2b+anzrs+iU19pZePHCBi46e6dSZ19Tr9ZCheLtd2XysyFKIj/poZQyW1uGWKetQcHFZHzt7jSbs+gkv+RDtw3E/WqGxFZ3KmUyFXtEzmQf1e4LNwekJ3b2Sycjgu4ZLLaQmoA+gPnC4sXrKzCILdYBa96ojKZl9HZk4RtUgJyZuIhzvX2Ur2dtlZLOvoU9pI881g69IbMtIPAvAVappzBxwfc4LSVcwMqhFs00UaL4rMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbE814slMNUEqAWmRhw3shv5OFdCwPD0+greH7LN3LA=;
 b=qVpZh/hnVjplzqb3VDT5FV8KJuXXWtMITxLJI7MoOgkeZkxtZTj0ExSmCxDw/R2ilTubUwBcLs6wl3M8lGggk/hsqzTXTluPUuCUY2EUp6u4OVNzlZTmzrYTi1nmIW32p8FIIKLcjCmhlU4b8DBzmxFGEOUwfJ6wilq8o35SSLqMEF9qQgMXqGj45dVHeBm+u5g1MunIowV+lU4/Brvbt9p2p1wIW06kk/p0yJBcuyxVqb3ePbBDpvZ1Z8qn+5gmei3te3qp+TjFkHlBDhuspCtzrc9pMvPKcM83X5qWHqT42rAw7sAeb7jah1yDiRNeNfR+qiFLlzfjC9rpDaYGDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Tue, 13 Feb
 2024 13:57:32 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 13:57:32 +0000
Message-ID: <c4fce432-4b26-4de7-9570-a13faade3db2@nvidia.com>
Date: Tue, 13 Feb 2024 15:57:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] vfio: Use new Error** argument in vfio_save_setup()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-9-clg@redhat.com>
 <589c8a79-4266-41c9-a019-ce1d55d7fab9@nvidia.com>
 <01f3e1e5-75e0-474f-91fc-27d20a4c96ed@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <01f3e1e5-75e0-474f-91fc-27d20a4c96ed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d38268c-018a-42da-1a47-08dc2c9bb987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDCwhCR2hZAaYuvwAJ9sUX+1udANa9QpKDg+aJkSmbEo/EY7nSLVRflFbzBH4PwPWLy7Fbak9UCxIjFE0X8L27GoE8VrG1wCrrjKg/1uY1OxH6gWLAQjxfNSCDJlWNYx6nxFofq71GBlZu9ZlqOJQWqb7G4aH2uKPKo259lG+sdaFGhfflj/nKRAy8uw4hVR9NWi5z+lHTXHDgkGIjFgWv7QB7ySCy3/zMJmYRTPIB3T+8Ytn7TNvL13WUk79Z1aB+haU24NGkKkgR/vBZ4rZBloJY86Od3z5qYnyFfqsoHpCJUiJEo/QgNuM1oR+uRsz6ZDp3QLQH1mf0UhMX5iePqDHSmwhpXi1QjqGPpgJKBNOZ6ohpPD5jZm34ltCQw+of5vh9h3xSFK6ydEE8Q+3NStiI4ZEH4JRwTrT10ZnLV6mF5wydqUjGUAGKLhBjN4RipAUvpHsjw07VKf57OuQKYlt1Z/43A6KNVgrLJHNC+Uh975dLsNPIq5qX4iqk0VGUTXs52ZlDDf+qumSBPtjlKOV7r+64v9awRfqOmrOknycSss3Kukzo0v6PtApdes
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(8936002)(4326008)(36756003)(8676002)(66556008)(54906003)(66476007)(66946007)(316002)(5660300002)(2906002)(66574015)(6666004)(6506007)(38100700002)(26005)(6512007)(53546011)(2616005)(83380400001)(6486002)(86362001)(478600001)(31696002)(31686004)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGtpQjAxU21XelNlQXN6WGdVK2xndzZNTmRsNGFPemhzRjRVTjZCQWlaMFJp?=
 =?utf-8?B?dWdJTXdNTFlrYW9BN3NlQTE1VG1pL2FjY3lERkdWY2VJQVFZT1o0Zm9qYzRn?=
 =?utf-8?B?VXJ6VE84YVp3dmZBaUFRUTJUZWlhbEdHL2JKS3IzWExycU1hRGtsZld4S1Yz?=
 =?utf-8?B?ZFVpRlkxTjR6b1VzNmkrb2R4TlY0TUo2Z3RnUnNqT01sNDlrWjk3Z2ZvbTZK?=
 =?utf-8?B?Wnkyd201bXo3R3VVV2oxZ2xpQktyeUJVcjJTSkpVK2ZNenVpZmRycWtRTldV?=
 =?utf-8?B?ZU8vUTM3R2dpUTNFeHVOSkhtYktxeXQrS05MRVJ3cDZwS01qcjhqV0NvVWpy?=
 =?utf-8?B?K3o5OTBrd0ttMGE2V1VQNkROU0VlNG5wTDN5WW5TNXNEUm1GYU9qK01QcG5V?=
 =?utf-8?B?ZEVGR3Jma29ub0tncVhBT1IrR0xWcVFuMmkwRkxxTEdFQzB1alJoSHFTdmRG?=
 =?utf-8?B?N0JsbnQyVktJbGRyWUFpQzJ3THpqaHhwbitXcy9JS0JMRDJTWUQrMVgvZzJq?=
 =?utf-8?B?ZHV5Z0loVWxWMzFXOFdQK3VEVTUxTkkrVkdwbXRMSm82WXFTQ0xGY2lVYjdB?=
 =?utf-8?B?RWZqckhuU09nU3JEK0FCdUxpOGpYeitqQXNXbSttZnZsanFoR0RFM3hycDlJ?=
 =?utf-8?B?Rk5OckxKbG1aTzhXalJxNlF4MThlMWFGM3YvM0F6d2lwZE9HaTJSS1JJdVkv?=
 =?utf-8?B?MlM2eTI2Mmd6SVNKWGQ2T09kNllJNVphMlp4aEg5blFDc1UwR2g1eTVJZjg5?=
 =?utf-8?B?VnVKUzgyYUptL3IzeVdGa0NKYjd5VFdMdGNiWS9vb0J2ZzBNR1B3UE9vMldU?=
 =?utf-8?B?SERjbkhLSFVhNEVuY042YlNPeTRhcnpsOWd6dmgzb044RmNNcXNZdVliaVU2?=
 =?utf-8?B?aVRVRy9ac2xaci9rOG1TSVBIMGtlaDJSRE5zWWZBemNUbzRkVDduTUVKUXZO?=
 =?utf-8?B?ajQ4UjNBNi9YNlh0N21wVFZKK1VZcWR6dDkwZzFhcGxLU25QL2ZGZ1lSckJr?=
 =?utf-8?B?MVdQcmRmeU9rYXVBZVRzV09MOFJMdGJ5RDVnZ3JFZFlEOGpYQlhQbEJvclZW?=
 =?utf-8?B?YmRKS3pPWlJpQ2xvc1B1a1Z1L2VLUjZSOHZ2QUVtYzFMcTBTdUlBVGFDUW5T?=
 =?utf-8?B?TjhNTGN0bDVoRElSeUhqMkFscFFPZHhzcnZZcy9zblJkTWJiYTd4TEFSN3gy?=
 =?utf-8?B?eGhxZ0k1alc3bmQxVHArd3ZQQzJnSlBNbE5NNHE1cnlLSSs0WEMrYmpMUHRl?=
 =?utf-8?B?WjVoTUZTU1RnTmRvK0RFVTlVajB3N1pTS2VWbW1RZGdmSFRFYzg1M1h0T29p?=
 =?utf-8?B?d3pEY0Fuc0JWaVZtcHdoNlBmNjdCWGVnd1FZMDE4OHZWY0FRU0ZpdmlySG03?=
 =?utf-8?B?NFg2OXR4UnBjNkpaQ1grWFFJTHdzSzQ0Zm9GMXF5YUc2aEVuTHkrZlBXNUJ4?=
 =?utf-8?B?eHFyZnAzZGlLdllKeDY3SjhMWG11djF2cTlOUDdXNWpMSUE0UE0reisxKzVj?=
 =?utf-8?B?Y3Fab0hmYnN1bmkvd0NEbllpd3hWMGZmSFFnUTRWTk55cjJ4Y3Vmc2poN2U0?=
 =?utf-8?B?eDRFM0VCeTNJOVN6R1FLRk5kVWwzY3RZaVk0M2lpUzJpWUJNNmJmeEFuU0JC?=
 =?utf-8?B?NUEzMkhuZE14L29zWWlZendsN2Q2YlBsb240YTJYbVhCQktWMjNrMjVwN3RQ?=
 =?utf-8?B?T0lGUjVMVFQyWHN5bDNVYTNETDZhTXNld3h5SDZka28xTVpiZFFxYlR2eE5a?=
 =?utf-8?B?Q0pGeEZxQzNTUW91dnErL1NCK0lHOFBFM0thcHJEWWF3aW1RZ21mY0d1Yi9s?=
 =?utf-8?B?VnFjaGc4NW92WktVZnJnSFFoSVV5NTJYSk51TG9NT213eCtMUVprYzhacUpl?=
 =?utf-8?B?NEMwUWVFZkpwa2JxLzRYOFZCcnA5SjQxVmtGTUZ6QytTN3B0TjN1ZjlZc3ZN?=
 =?utf-8?B?WE5MenBkTXZmU0NVYXNmRUg3NVlzSnVpMWJQOFA2U1ZPc1UraEJYQ0crYTFp?=
 =?utf-8?B?TExIc0k1bk52ejVsdlM4bkh1QktqTWVReW9Lb24veHc0Y3prQXZRUmt6UzVz?=
 =?utf-8?B?TzRlZnhtbEtMMGlWSW1NdEhNNHNFdFAwRUZKaURwMlJUVHl1akJlWmg0aDVv?=
 =?utf-8?Q?BIb80vRCO6b2zPh2HA/MoUk6Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d38268c-018a-42da-1a47-08dc2c9bb987
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 13:57:32.6087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyGIohijPNqCSHxikfehe6zt0NUgUVAgz2EDU74RkhgSX0mlYMMP3hnApIt70h1Wo8wu4TlXqwJGcunKikS+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
Received-SPF: softfail client-ip=40.107.243.45;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 12/02/2024 19:54, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/12/24 10:17, Avihai Horon wrote:
>> Hi Cedric,
>>
>> On 07/02/2024 15:33, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Add an Error** argument to vfio_migration_set_state() and adjust
>>> callers, including vfio_save_setup(). The error will be propagated up
>>> to qemu_savevm_state_setup() where the save_setup() handler is
>>> executed.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/migration.c | 62 
>>> +++++++++++++++++++++++++++++----------------
>>>   1 file changed, 40 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 
>>> 2dfbe671f6f45aa530c7341177bb532d8292cecd..2e0a79967cc97f44d9be5575c3cfe18c9f349dab 
>>> 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -84,7 +84,8 @@ static const char *mig_state_to_str(enum 
>>> vfio_device_mig_state state)
>>>
>>>   static int vfio_migration_set_state(VFIODevice *vbasedev,
>>>                                       enum vfio_device_mig_state 
>>> new_state,
>>> -                                    enum vfio_device_mig_state 
>>> recover_state)
>>> +                                    enum vfio_device_mig_state 
>>> recover_state,
>>> +                                    Error **errp)
>>>   {
>>>       VFIOMigration *migration = vbasedev->migration;
>>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>>> @@ -104,15 +105,15 @@ static int vfio_migration_set_state(VFIODevice 
>>> *vbasedev,
>>>           ret = -errno;
>>>
>>>           if (recover_state == VFIO_DEVICE_STATE_ERROR) {
>>> -            error_report("%s: Failed setting device state to %s, 
>>> err: %s. "
>>> -                         "Recover state is ERROR. Resetting device",
>>> -                         vbasedev->name, mig_state_to_str(new_state),
>>> -                         strerror(errno));
>>> +            error_setg(errp, "%s: Failed setting device state to 
>>> %s, err: %s. "
>>> +                       "Recover state is ERROR. Resetting device",
>>> +                       vbasedev->name, mig_state_to_str(new_state),
>>> +                       strerror(errno));
>>>
>>>               goto reset_device;
>>>           }
>>>
>>> -        error_report(
>>> +        error_setg(errp,
>>>               "%s: Failed setting device state to %s, err: %s. 
>>> Setting device in recover state %s",
>>>                        vbasedev->name, mig_state_to_str(new_state),
>>>                        strerror(errno), 
>>> mig_state_to_str(recover_state));
>>> @@ -120,7 +121,7 @@ static int vfio_migration_set_state(VFIODevice 
>>> *vbasedev,
>>>           mig_state->device_state = recover_state;
>>>           if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
>>>               ret = -errno;
>>> -            error_report(
>>> +            error_setg(errp,
>>>                   "%s: Failed setting device in recover state, err: 
>>> %s. Resetting device",
>>>                            vbasedev->name, strerror(errno));
>>
>> I think here we will assert because errp is already set.
>>
>> Adding an error_append() API would be useful here I guess.
>
> yes.
>
>> Otherwise, we need to move the first error_setg() below, to before we 
>> return from a successful recover state change, and construct the 
>> error message differently (e.g., provide a full error message for the 
>> recover state fail case containing also the first error).
>>
>> Do you have other ideas?
>
> Errors for :
>
>     if (ioctl(vbasedev->fd, VFIO_DEVICE_RESET)) {
>
> should be treated as the others with and error_append() and not
> hw_error(). This needs a rework before any new changes.
>
> I also wonder why we have twice :
>
>     migration->device_state = recover_state;

Not sure where you see we have it twice.

One time we set "mig_state->device_state = recover_state;" for the ioctl.
And another time we set "migration->device_state = recover_state;" in 
case of successful ioctl, to update the device state in migration struct.

>
> It looks redundant. The ioctl VFIO_DEVICE_FEATURE should leave the
> state unmodified.
>
> Thanks,
>
> C.
>
>

