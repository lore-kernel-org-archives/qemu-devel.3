Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826F7CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLKyV-0003vU-9D; Fri, 08 May 2026 09:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLKyQ-0003uz-Ok
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:10:35 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wLKyJ-0005eC-Vc
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:10:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBugbM31HLEB43dJNk0IZuzw0n+7HHdgQTVav/eU54VRf1mLyIzSjblw/kC5WmF2he2MEUKntP17AYma5wzlVi9IiV+QQ87gVnv9HSe/AQ6fnjVrDI2+92wqjM7ORagwKavWMwGLJSlOvespNG2DwbPwoyuYFLAcKEYdnbT7MPttayMoCbSYQlSQ/M6SwHbIvQroNWiPaeMlBHOdQddCmQK66wrHhTWP9kLUeWwOv8dhRaoj83jXRxExYVAo0WNyKpEer97HptOkcfnKCniAm3v7h4YhdQd8tEQT2NKJeJjjxUsIAbi88x4ayfi0BItNye56o8brNtGMPocVURQDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuXmxnsTyniaM9AdWR51B1gSa6vyXR5qJamA6pUKfBc=;
 b=Q0ZzZKZEljJojtMUtiyw/5bFCtQvIzvgtO4VoorOPXwW1lRaWKSf+1fqrZoPKACgYFAoKUrpUlK07NBm3RzfyfvY58bRQFPbGRcq6PJZ0ic7jVLIKogPGLaSRb1OEUlUxWd55Q++ubpVJ9Dh5okBrk0w4JZvx/AxCq+WFFK3nlVStPFcGm/K4vK1Y+ToK9YD+CqC48MosmFs+12FrX+zFOh5dcWF9UoLp7JYmxe3DTfw+OIxxp2vBJoIpTZBWeul/mELm21ZsWd7mIUWacRMepVcBb4A8ZVNg5xnT4oXl08sOewJ4DPcb7dHaGPzcU3bVAfTERkzId3WR4FaZ38REQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuXmxnsTyniaM9AdWR51B1gSa6vyXR5qJamA6pUKfBc=;
 b=JduoruN+gBZRyLO3kWDCRSRH5lkj2mNZ1u/Vqz9qSd7JdbM85aJOgkLfzRk1N8DISZXiOkQbeDt3NRb4XwueFGktsRieZeFwW4a3ZRSERUINouckPAUrH+RGRDVRtr3enHinZyP1wwcoDID5kSCElhzyqo7xvkhWZZj+V8kjitzDa6TJJGWaNUHA+WZEHIqCYy+XVSXDdn6YEBCn8qzWqlzonBI/c6GFuqRUMUb3EAbxD1+7e3wIuj5JbXjIYL5wc6WeiMu5i5rqfEnxwB72PA3cJ1CV8R301dptkDcTLMduPBOSfR1LICVZlu+OSKuj3+4WkY0h6gh6rM2nUDI45g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 13:10:13 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Fri, 8 May 2026
 13:10:13 +0000
Message-ID: <900d065a-aab9-4efd-be69-7aec2ccb0560@nvidia.com>
Date: Fri, 8 May 2026 16:10:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] vfio/migration: Re-query precopy size before
 sending VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-10-avihaih@nvidia.com>
 <d76a2215-d06a-4ab0-9031-2e81f08690d9@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <d76a2215-d06a-4ab0-9031-2e81f08690d9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 97219e3c-3b7a-4bf5-de63-08dead0323bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I7MVKHMOkKVl0C1ir8aFmVaF3jogHqt8QSyTx7ir+/H1Mz5LMla4jawvIK3or4J5DoVgRYMQVuJCDSUqqvRPLdLVMdcCbL4NfX2iD7t3av+bCuOlN5jJOXVunEvQdqi2im1/CZNpeNfQ+P4uRA2HhRV0oz3xZJUqCJV/bvOHX442yXO8YCewmnFX6DLnYfGPN0KRbcXudQt36PUX1Jc/oEI9EG0ejn3i8TYLDXKug/naT02wz2gu/GXZGmt+FW81/r6om6FPpYDxYSi59vbEWA9hROaROGu+fwadnK4lc2QA+8X0+QBEiVMIAI+MxjlwkcYyrKUXXH99wV4GmVGtPOY39fhGliqp9gJ308nWebjaMeMs2/ptXl0/RgfbCKfvmXWVK1iCYHRf+CbcMW8WI7RGYyWdQVr1nFD6nrI/ygCZ5kyTVT7SZV8IPzuGbTjhlL/u0oYGlTeT81Mk2F0juKDghqXN43mINqaa798VZ2Cyk2p3D8VcmXCG2eADicB0Lc4atVfD9oh6U5X489UobbQtVWKGTTSRaScp6jnQ9fsYfzFmRqAb2cfwq0VgXvtHqiny3nPhlUHxzkeWrXM1rjtN/q96vfSTU7gg3hkwlXXwXlzSC9qXWgu0sXyKrXNFC5TxVYBObiKEEMFhE+LIG25kRQY+dwoGgjmtvwQHUHZlNmv+/5uXC1cNeLSbfCR9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNCTHFXcFlzOUdtVGZLZm1qVHoyQWFnZS8vOWpKRHFCblpTcWNtblJxZ3B0?=
 =?utf-8?B?WHlCQnZpWDJ1SmpYcGMvOFJjQndpQUszWTFzOHJES0FhcUFQd0lsUnh3dnox?=
 =?utf-8?B?THlYQjRyaWtGQzBzOW1KWGZuWDZ3SDZPR1kxamluZmZtVVlOa0IrdFVXdWtx?=
 =?utf-8?B?a21kV2ZnVFIva3RTSFBVcmR0bktUSmJWRW43cmZRei9FUlU4S1VFcHpSQnpi?=
 =?utf-8?B?QlZCZlRXV2lsdDFkVi8wUC9YWWg5eXQvTjVXanNTa0JVZEZ3UWNFaHJsajFV?=
 =?utf-8?B?bXhKL1pGU0VaSlpqVjR3eWNDMkdZRE1KOHU0anlJMldJZGswQk1HVGlrOXVz?=
 =?utf-8?B?SkVsWll5MkJaTEtEVFdiUllxTTZNZEhvYTV0Nm5yOENCRFB3QXMwSEx2ZGJo?=
 =?utf-8?B?VkkzTks3MXovc1FmaGNmOExhTGFNVlZtSmpNNzdzWHltcndmcFVpd3E1UmFi?=
 =?utf-8?B?MWJqNEI3ejZMd2pJSHRGUlhaajZhT2JtN0xQeXd3QUc4UmNrZE82cThKY25P?=
 =?utf-8?B?R1g2b1ZFNm5SN1NUMjRqVGxWZ3Npb2ZWcUpzYms2UDdKdXBIZS9mRVVSVXJD?=
 =?utf-8?B?dVNJSEl2cS94bHlHQUpmK1ZFbmZuWitaS0hXMlhqMzBxWlNMcXl1NE5wRlJS?=
 =?utf-8?B?QTZMa2ZJUm5oaitaaS9JWGs4R29ZUFZUeDYxd3YrRGVpczNIc0V6eHBMUlhC?=
 =?utf-8?B?b2J1RlBCcDZzY0N1MHlkMUs1TFBhZE1RUDhrbVBsUS9icEdMbUs0ZEdLTG9l?=
 =?utf-8?B?RzdGNElkMnJFU0lYNURnQU9xaFo1V20vU0VUYk9WR3VmbnFKcUVrYVdwN3pq?=
 =?utf-8?B?WGdYWXZnNng1cTZOakNhVHFGT2ZVUDkrWGNaUWljQVVSUlZkbG5SOVZLM2V3?=
 =?utf-8?B?REZTa2g5MUhBczBQYlpZTEVyd3RtamdwdmgvK2xmNVFoVklXVU5wTGtMb2Q4?=
 =?utf-8?B?Mm5GV1ppTmFNVTE2bWxoaGdCWWxPOGVOdy9SL2psZ045Yk41QmZDVHdlY2Zz?=
 =?utf-8?B?VzdTYzZmYytjQnhKRGgxOUVzNUVzV0hEQkMrRUwyek5NcUlkcUMrRGFIVkUv?=
 =?utf-8?B?NGw5L0lZai9Da25tQkNlZFZ0MHl5YUhvQ2tSOG9DNEZkcmZzeXdXOFZTaTZR?=
 =?utf-8?B?WUR2SmFMNGJBb1l0OWpkVllZSGNUczk0ZUd0S3VJR1BUbWdkcGxuREFHTU5U?=
 =?utf-8?B?bHdWYmhKTWdRdUQyQ3ZYYmljbmlCMGNpVUVlUUVvVGg4VEwrdTVCbXpIa3Bm?=
 =?utf-8?B?ZzhCUm9hZTlNN2FmR2pZNkZ0dFhNZUI1UUMraytNMnZnK1RrYlRRVFhoRlo1?=
 =?utf-8?B?RHAwaE8xeEhqY0lHbE8xM2pEOG4ySFpJVXhLT0t5MExRQ0ZZT1pRNXd6UWtk?=
 =?utf-8?B?aE41eWM3Z25GQmpBdWJ4dTRWSStSU2s2VDJOek9paFgwSGZkaUN5b3Q0ZzBF?=
 =?utf-8?B?UnFxNXVVeWtiY1NzMExRakVaWGd3WWZDVUpWZnVGYUY0OS9xeU5WYjBXNDFM?=
 =?utf-8?B?UEMydmJkS1VQQm04SXVkT0o1REVQNk45azhtdm03MzVEMzYvdTZjS01lYnp2?=
 =?utf-8?B?VGhLYWp0SWJCUWxsN2VQK2cyaDBybW9HVy9NSHdXOTF1RDdLbk9PT241OFNC?=
 =?utf-8?B?b2JOUGhaZjRycWludHJ1YkQ4bm03SFJtV0FUR1hhaDNGMXE0Z0ZLUkxaV2JB?=
 =?utf-8?B?VnZPbU9Jd241VFhYM0RWcVAvZUVSMm1nS2l1M3ZFVFcvU3ZvdXdkcVVNOTRm?=
 =?utf-8?B?RklwWHVvZDl5WkJHRFRUSXJtY3loVFBDNFFUYWZ4d0dIQVVjemgvc1B0bVJB?=
 =?utf-8?B?b0cvTjM0dk0vRGFwRWE3TDRDQ01KcGlWdG02R2UrRjl2KytPakc1YlM4WFhE?=
 =?utf-8?B?TGdGTEJMcjJ6ZHVWQ3dYN1NPNUZHVFVQOXNncjltUkdLb3VuWGUya2NqZktl?=
 =?utf-8?B?Mkd5VkdCSEgxNUIxK2hXRklQOU43MTBCQ0FlbUI3T2JRUitjN2c0Vno1bEkz?=
 =?utf-8?B?OVo3TEtlVWZHdzRISjFxR3J1ajJtVW9yN09vSjgyQ3Nyc0xmdEdUVmRzcFNQ?=
 =?utf-8?B?eFl6V3BVam0vUVRaaDZsR0tHeG5EdnBkL3JuS0tUNmhiWFg3TFVpNWFGQVpu?=
 =?utf-8?B?dmVhbVpacnhoQ0ZpYk1PVW54T2U2MEFOanhCMTdncDN2NFMrOXNuamgxV3A4?=
 =?utf-8?B?UldpbDZlaU1NeHBXeDZGMXd0Z2l0eFFIWXczdnlidWRDeW85VkNPejJxbWs1?=
 =?utf-8?B?NG5nbjRQMEZnR01iTFB2Z1FTdHh6dXdjYWhaWERoWk1Bc2JmMStKb09Jb2pZ?=
 =?utf-8?B?aGVBM1Y5Wnh3Q3J6eEtaODYycnJkUWFFQnJIZ04xK2gyV3FQVVZUZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97219e3c-3b7a-4bf5-de63-08dead0323bd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:10:13.2267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVwTldoVLIJyHAgkrwtEqAUavGcm6Yb7KbKeGhxUUdIgKGeuSu4hMH3o5wXNvKdH+elvhOV4lLr0GnmhTHjGtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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


On 5/7/2026 11:24 AM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai
>
> On 5/5/26 10:14, Avihai Horon wrote:
>> When precopy initial_bytes reaches zero VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>> flag is sent to the destination to indicate that initial data has been
>> sent, so destination can indicate back to source when it finished
>> loading it.
>>
>> To get a more accurate estimation of initial_bytes, re-query precopy
>> size before sending the flag. Extract the flag sending logic from
>> vfio_save_iterate() to a new helper for clarity.
>
> I would prefer to separate the changes, so a patch for this new routine,
> and then :
>
>>
>> This may prevent premature sending of VFIO_MIG_FLAG_DEV_INIT_DATA_SENT
>> flag if, for example, the previously queried initial_bytes was lower
>> than actually is. Additionally, it prevents sending the flag if
>> vfio_query_precopy_size() failed.
>
Of course, will do.

Thanks.

>
>
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   hw/vfio/migration.c  | 37 ++++++++++++++++++++++++++++++++-----
>>   hw/vfio/trace-events |  1 +
>>   2 files changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 2911583ee1..243624b5fe 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -456,6 +456,37 @@ static void 
>> vfio_update_estimated_pending_data(VFIOMigration *migration,
>>                                            data_size);
>>   }
>>
>> +/* Returns true if the init data flag was sent, false otherwise */
>> +static bool vfio_send_init_data_flag(QEMUFile *f, VFIOMigration 
>> *migration)
>> +{
>> +    VFIODevice *vbasedev = migration->vbasedev;
>> +    int ret;
>> +
>> +    if (!migrate_switchover_ack()) {
>> +        return false;
>> +    }
>> +
>> +    if (migration->precopy_init_size || migration->initial_data_sent) {
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * precopy_init_size holds an estimation of the initial data 
>> size, re-query
>> +     * precopy size to ensure it's really zero before sending init 
>> data flag.
>> +     * Don't send the flag if query fails.
>> +     */
>> +    ret = vfio_query_precopy_size(migration);
>> +    if (ret || migration->precopy_init_size) {
>> +        return false;
>> +    }
>> +
>> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>> +    migration->initial_data_sent = true;
>> +    trace_vfio_send_init_data_flag(vbasedev->name);
>> +
>> +    return true;
>> +}
>> +
>>   static bool vfio_precopy_supported(VFIODevice *vbasedev)
>>   {
>>       VFIOMigration *migration = vbasedev->migration;
>> @@ -664,11 +695,7 @@ static int vfio_save_iterate(QEMUFile *f, void 
>> *opaque)
>>
>>       vfio_update_estimated_pending_data(migration, data_size);
>>
>> -    if (migrate_switchover_ack() && !migration->precopy_init_size &&
>> -        !migration->initial_data_sent) {
>> -        qemu_put_be64(f, VFIO_MIG_FLAG_DEV_INIT_DATA_SENT);
>> -        migration->initial_data_sent = true;
>> -    } else {
>> +    if (!vfio_send_init_data_flag(f, migration)) {
>>           qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>       }
>>
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index ab27ff5ea2..e91858354c 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -176,6 +176,7 @@ vfio_save_iterate(const char *name, uint64_t 
>> precopy_init_size, uint64_t precopy
>>   vfio_save_iterate_start(const char *name) " (%s)"
>>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) 
>> data buffer size %"PRIu64
>>   vfio_state_pending(const char *name, uint64_t stopcopy_size, 
>> uint64_t precopy_init_size, uint64_t precopy_dirty_size, bool exact) 
>> " (%s) stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy 
>> dirty size %"PRIu64 " exact %d"
>> +vfio_send_init_data_flag(const char *name) " (%s)"
>>   vfio_vmstate_change(const char *name, int running, const char 
>> *reason, const char *dev_state) " (%s) running %d reason %s device 
>> state %s"
>>   vfio_vmstate_change_prepare(const char *name, int running, const 
>> char *reason, const char *dev_state) " (%s) running %d reason %s 
>> device state %s"
>>
>

