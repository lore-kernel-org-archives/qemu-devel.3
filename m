Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C933CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNVdG-0002ZK-Ox; Thu, 14 May 2026 08:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wNVdE-0002Z0-NX
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:57:40 -0400
Received: from mail-westus3azon11011032.outbound.protection.outlook.com
 ([40.107.208.32] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wNVdB-0003dG-Hv
 for qemu-devel@nongnu.org; Thu, 14 May 2026 08:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifFWdaF0jPkMGJrLQya53yaXq39ngb/cd+MdJDAERCq6/Ory3s3PGSvl/FLayUKBbzrnuSylXchJ5rE9z/36fvirn3iE7Iyg9vDU4rjlxi4m7nTkxSc/MWStErbAok7dm6BI56oaa6l0strPj1ts7TIuj6w4O/as34/JVPYtoReUBxVbiEtbFlIcd1oqWnbiHgTAUtg0rPhDVemCNxlqutMtDWbNP47v2J8OpcYgmFSSzMXzla9Pp7ecTQDxnt3+BhbyrZCVxhNzvJbJZtk1PYWi2/wKxujY3DNznQrTYqN1DqgNGZWyt5/MlYSjDe1VzKIHfOuhOmTvhh++meJFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKleFYZ2ASbebyV90Grzl/yIN0vL6j76cShxaoRoHR0=;
 b=SotSlskU2Ljka/VeRRgA2L82kB8BLdLH3RvyGGjoo8JxwnKt/8nar11Qjil+nvma3rnPi0gIuz9Rkzhc9m2t71dDt601Nl+NHXnXr9/0JJ0WxRmfVKg3hdKt0xEOesCGwI5HN0VxGUXS+IZNaVD7E75ejo94yurHKZd764u3zZLbTPGyoqNRpnU0jVxlmQVJ1pNC2BwvzIooLYsNl9P4kzwGawFTuqONjs8AxjVY3k7sFYK5FThLyIX1/p37aLchMHkDg+I7tRp0dia4ZUzLCzJq9rOJiDdS8Jpg8cNeFBhOvJwG80umt0t6hrY6YN73YyF+a/TXsa32dtpke9IYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKleFYZ2ASbebyV90Grzl/yIN0vL6j76cShxaoRoHR0=;
 b=nVxdWIwJ3yLl0z8a+e9sLC4UN3KgZ+n0NH0CZxrE5WvNkLBjYdtI2sA2dztdS498Z9GpQW6q4rWJFDBNSKFYjmV2WN2dIkCujaFVs8G8Rc3G5y4+D7gRXPZCcsToZrsED11PQFU1DwC99vuKiO7FMFbiBzo/tTfbaoAIUt1ARevOhQJAiZ643P5mQe7pLUadiu9K54JK/hxMMyKtpYb5jwXBxN+2IF7nlgjAHD3FuJyTnswc+dCBqvoKEhaeyHMKCGP/msnqaw/hud97YhZuYRszxEyRyMXocsmBiSUyO15WAA0Pm0OAGYk4ndO+xHtqNLxsRWTXaBbHYDkRnIx8fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Thu, 14 May
 2026 12:52:25 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Thu, 14 May 2026
 12:52:25 +0000
Message-ID: <4cbb3e52-9b4e-477e-bb0e-0588036fa06d@nvidia.com>
Date: Thu, 14 May 2026 15:52:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Detect and report overflow in migration
 size queries
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>
References: <20260513094522.346314-1-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260513094522.346314-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::6) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d89a0d4-bcab-447f-ba8d-08deb1b7a588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Ox2ipRV84L1ER4w9scY1kZcBRF2bpppmNaPxmlmu5Ebqoah3891x2J1s50+gow2r0gPjbFvTJ4JP/Tf2oTN90B7wTRxcoK1vEwdhZyt/Wkmc15gOPsOP1KIcX2589t/WAyTm/321diAEKMDNR0N9J1maaJdbPje2XvtPhbPGHIa+D6cWGlPcpLMC4slZlAvqVj5OvCAgx8LAXJ9zJKw0n7qyCcr4//U4F+Ny+lOmGUDmdyd/1XNamTyuWacm6UqSB6bJjjBom6sLEI37Iig+6q2P6gLCB04l3rkO7Lr1+D5hfcAh3aRNHA9hUN43MZu772kSV+sezw8paoCi+I8QF0OJFylhpzboCMHy4pdLd+mW+PiSYSX0JKOKtqs4yEgdMgtF/u5ivgzY6+qvAjNuGDEGLRBrI+7tAD6FXvWWng9gcVVfcyLpyH1vDQMnLVwuVlDLzpxMGk18blBjtqrC6R6wpAg0ZS7Tn+wGyUUi6aJr5ujcpjrvxG92BqBBjBzPRf5KjXiH4DS23b3rEhkZKdQn0mf/c3GLznB0RVHoXQ5PuhUgg8P8a4Cp2RluYwbssBCrPguZxfE1Wv/Oycc8brdrlQ3jVpnfLV9nZDtfghrIP9fW01Ytj3GQdIBJhSRux7/gJ9eDeyGn76ikvyK0rywK+QcnJ1JyLiQzUzEbWPLUtZbfFNLq7WDWrJ+JtvrM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBhR1FsbHhoNUtSSkVHc0RGb2szMlRBenpLSERkY2E2cDJCcnEvZndFd204?=
 =?utf-8?B?bTkyZnZWVWRHZDlPSVlDb1hwZjRBZWowS25OSWJKMjdnenFHOUhxVTlkNklX?=
 =?utf-8?B?UC9ncE1NZzd5TnpNOVI5YXAvYm9SdzJwblN3MXhkWTk3ODJYUVJMUW93TTJj?=
 =?utf-8?B?Y3BsUTlRenZ2UndkUDZtZGZMQ1lweGRzRFZ4dkVLSFE0QmVCU0F5dFZMN2RB?=
 =?utf-8?B?OGFaQjlPdzVtQ1hsaUplVXdMWmh4Z1NONmJ4bW9Vb3Y3OWpSdlJtcTIwbjh2?=
 =?utf-8?B?VjAzN0tvUHpPNW5HQVl3WXRlR3Y2SHUrVDhyclhZVDNHWE5hdmxUdXRWbHZu?=
 =?utf-8?B?S2RFUjY0L2pWbHZjT2dFdGtmSXQxREorTTk1ZG85M3lYbVoreXdSVllGa1Zz?=
 =?utf-8?B?L2txSVlaT09tMnpRRXNKZldLUDVQSFZvQUtnQ2FaL0xvTUx1Ull1Q2JlNG9k?=
 =?utf-8?B?VWV6QmdwUk5TdGJGazE1alBHaXVVb241NzhIUWt3d2tJemVYalJsb3VVVkJH?=
 =?utf-8?B?UzVubHNVTW9YNE5qS0ZYenNMdEZodU12c0VDZjU2RlZpNDEwRlMrNXY0bWZJ?=
 =?utf-8?B?VzcrSXpLY0txNEdPeklyN1ZaV21hbVhjWUVpdEIzWkFibUN4am5ITllhc3BY?=
 =?utf-8?B?bjl3TkhwUGhURHhFdVllUmd2eGxkTnM5OUM1RVNCbUpUeERTQy8zLzRIV1pr?=
 =?utf-8?B?RWMxQithTzJtZGZvOFN1RGZEZkdrRDQyVEhLSjByZ0ZCU2djQzJxSXozdG42?=
 =?utf-8?B?UllaTWdCNkM2MHJIeDZkcGRpVmI2V0NnWHNBMXZpMjBFTkVLek55V0wvTG1w?=
 =?utf-8?B?M3lJUTZ2RkxYMjd1YlNHSzVIZ2p2UlYzUFFtc0k3OGhVSU9kMHNUUnd1RUdn?=
 =?utf-8?B?bUc3ekg5NCtPMVZGQzJ2MFNtaVFVaUQ3NEZ1QlYrcHpZNWxXY3U4aEVUOFgv?=
 =?utf-8?B?a2N0ci9KTTN2WUFabDlyMEtpcVI3S3czdnZhZ041THh3VnRRU0ViOEQ1Mnp2?=
 =?utf-8?B?akx5WXJrV0FmZGFCb0JZT0dlNXZHUmU2akE0dkV0bEJLRFp2WEozY1FmY0xG?=
 =?utf-8?B?R2VYazlTb3VLaXYzdzdlNm16NGJoU2NzSk8vVVQ3NVlHanhaWTBoQ1RoZWZ0?=
 =?utf-8?B?TXRyd1BheW1FdmZCcmkxd3lDS2ozK1pDaUpTTTVEZUhkVFVQL20yYW43T1Fw?=
 =?utf-8?B?bllyWHVWOUI4aWpVNWNpaldiN3d4ZVViSi8vb1p4MFZOd2RiTnYzbWNYNkg1?=
 =?utf-8?B?eGoyRktKTk5vTnhadW5NRnlEWkVvWHp4RHpaaEJydURwWmpudTNrVnhEQThz?=
 =?utf-8?B?ZERPMlQzZGhwSHpQbDVtU2EwaTZ4UDU2ZlZTVkIzRWVmMjZzY24zOEExaXg4?=
 =?utf-8?B?dGNhNVJoMGZPM3ZNbWZYMHQ1alNhM3IwWlJESWpOMHBSNlJ1b2NwVmE4YW1D?=
 =?utf-8?B?UFlNK0puRm5CRmx2SE1LOWJpZ2ZHa2NLOVlPUk1PbUVYVkJuZUU1bmQwSHpG?=
 =?utf-8?B?UmpNVU13TDBDY1Y4ZlA0THF1VzRBVGY3U1RwVGFMbWJJOTFjR0JDMlhyYno4?=
 =?utf-8?B?S0EyclNaQW1VZ1dnOUxXWnI3VkpzUnJPR0xvWTRJY1JOcVYrRVJxYm5wMEpy?=
 =?utf-8?B?Vm1TeG9QSTRlaWluYzhqaGx2MkM1d0FwdWdtbWxuSXFwWFlsQTJXR29mRUVH?=
 =?utf-8?B?YTZLRW1tU1NHbWxJcllKRzlNUEptbkQ1SUFuOUlJc2I2bGoyTzBCQkVMaExm?=
 =?utf-8?B?bi92Qk00Q3NFYnlSbmszRGpZeElEUndXakNLUEhNU2ZYM3hVOHRBdFFUZzQr?=
 =?utf-8?B?UDNCS2tEd1J6Y3U2a29wMmFGV1kyUGk3NEJPSDE5dEJpN0ZEQWxQbWFGdngx?=
 =?utf-8?B?QmhRQzJ1RytnV1Ftb0FDeHExYytPVTFRMHJNbllXejFkRHJrWjBmeFZjUTU3?=
 =?utf-8?B?ZHNaUGYzU09aV2dEVjRpTEFWWDJjY2FML1ltS2hyWHhQQ2pWeWZGaHdYK2R3?=
 =?utf-8?B?bkhnMDdyZmNpcktkZVM2ejN6dGJQN2pOWktTcmF3N3p1b1QyZ1B1d1BOUHlP?=
 =?utf-8?B?Q2I5ZDVBQjE0SWVLd0ZCNU1TUnhJT0h5T3NOend2Vmgwazd5VkY5M2pacUhF?=
 =?utf-8?B?a1BsNm40dUJ4ODUzeFM0SWhzWDNOcHE4MEMwRG5oNGZ0bDVUVlY4NmFJaFhu?=
 =?utf-8?B?c1lmYWw2MDR0THRQTExDTW5GZjZUa1doRWU2c0EwOW1CNFF5eStQZ1RhZVNm?=
 =?utf-8?B?ZVU3U2pyQ2NWSVhoTTdCOE8xRFZ4N1JDaTM0L0lzcktGRmdHTXR6QXF2RTIw?=
 =?utf-8?B?Mk1wK3hEMkt4M1Z6MlJDSWxjUEFKZE1McHFyNzA4Q2NPdHQ4blA0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d89a0d4-bcab-447f-ba8d-08deb1b7a588
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 12:52:24.9580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eme2kpm42Cca6MMumqxBEJSNr8XK7OXos6UF66jw5Mo07eMz/w8BFuAdJGta7EPG7G4sz35y0Hg31lBnmyGvSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
Received-SPF: permerror client-ip=40.107.208.32;
 envelope-from=avihaih@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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


On 5/13/2026 12:45 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> VFIO migration ioctls (VFIO_DEVICE_FEATURE_MIG_DATA_SIZE and
> VFIO_MIG_GET_PRECOPY_INFO) return device-estimated migration sizes as
> uint64_t values. A misbehaving kernel driver could return values that
> are unreasonably large, which would corrupt the size accounting used
> to decide migration convergence.
>
> This misbehavior occurred a few times when testing migration of a VM
> with an assigned NVIDIA vGPU and an MLX5 VF. In some of the save
> iterations, the reported precopy and stopcopy sizes were unreasonably
> large (close to UINT64_MAX):
>
>    vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073708667040 precopy dirty size 0
>    vfio_save_iterate   (4fbce62c-8ce2-4cc9-b429-41635bc94f24) precopy initial size 18446744073707618464 precopy dirty size 0
>    vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 18446744073708503040 precopy initial size 18446744073707618464 precopy dirty size 0
>    vfio_state_pending  (4fbce62c-8ce2-4cc9-b429-41635bc94f24) stopcopy size 0 precopy initial size 18446744073707618464 precopy dirty size 0
>    vfio_state_pending  (0000:b1:01.0) stopcopy size 18446744073709543408 precopy initial size 0 precopy dirty size 1008
>
> This had the effect of corrupting migration convergence, as reported
> by the HMP migrate command:
>
>    (qemu) info migrate
>    Status:                 active
>    Time (ms):              total=21140, setup=86, exp_down=152455434886355
>    Remaining:              16 EiB
>    RAM info:
>      Throughput (Mbps):    967.98
>      Sizes:                pagesize=4 KiB, total=4 GiB
>      Transfers:            transferred=2.29 GiB, remain=4.7 MiB
>        Channels:           precopy=1.91 GiB, multifd=0 B, postcopy=0 B, vfio=387 MiB
>        Page Types:         normal=499427, zero=559708
>      Page Rates (pps):     transfer=0, dirty=1892
>      Others:               dirty_syncs=3
>
> Add a helper to detect values that exceed INT64_MAX, which is far
> beyond any realistic device state size, and report them with an error
> message. Return -ERANGE from the query functions so callers can abort
> the migration rather than proceeding with corrupted estimates.
> However, the callers don't yet check the return value to actually stop
> the migration.
>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/migration.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Can you tell if it was the vGPU or the mlx5 device who reported the 
overflowed value? Or both?
Are we sure the driver is buggy? E.g., do you see the overflowed values 
also in trace_vfio_query_precopy_size and 
trace_vfio_query_stop_copy_size (where we just queried the values and 
didn't touch them yet)?

Thanks.

>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 150e28656e97c5e8198541e5b6dfc4ed4102d143..fb12b9717f773fdde657911517de9d74c1eb3931 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -320,6 +320,18 @@ static void vfio_migration_cleanup(VFIODevice *vbasedev)
>       migration->data_fd = -1;
>   }
>
> +static bool vfio_migration_check_overflow(VFIODevice *vbasedev, uint64_t size,
> +                                          const char *name)
> +{
> +    if (size > INT64_MAX) {
> +        error_report("%s: Estimated %s size overflow: 0x%"PRIx64,
> +                     vbasedev->name, name, size);
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>   static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>   {
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -329,7 +341,7 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>       struct vfio_device_feature_mig_data_size *mig_data_size =
>           (struct vfio_device_feature_mig_data_size *)feature->data;
>       VFIOMigration *migration = vbasedev->migration;
> -    int ret;
> +    int ret = 0;
>
>       feature->argsz = sizeof(buf);
>       feature->flags =
> @@ -347,7 +359,10 @@ static int vfio_query_stop_copy_size(VFIODevice *vbasedev)
>                            vbasedev->name, ret);
>       } else {
>           migration->stopcopy_size = mig_data_size->stop_copy_length;
> -        ret = 0;
> +        if (vfio_migration_check_overflow(vbasedev, migration->stopcopy_size,
> +                                          "stop copy size")) {
> +            ret = -ERANGE;
> +        }
>       }
>
>       trace_vfio_query_stop_copy_size(vbasedev->name,
> @@ -361,7 +376,7 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>       struct vfio_precopy_info precopy = {
>           .argsz = sizeof(precopy),
>       };
> -    int ret;
> +    int ret = 0;
>
>       if (ioctl(migration->data_fd, VFIO_MIG_GET_PRECOPY_INFO, &precopy)) {
>           migration->precopy_init_size = 0;
> @@ -370,9 +385,18 @@ static int vfio_query_precopy_size(VFIOMigration *migration)
>           warn_report_once("VFIO device %s ioctl(VFIO_MIG_GET_PRECOPY_INFO) "
>                            "failed (%d)", migration->vbasedev->name, ret);
>       } else {
> +        bool overflow;
> +
>           migration->precopy_init_size = precopy.initial_bytes;
>           migration->precopy_dirty_size = precopy.dirty_bytes;
> -        ret = 0;
> +
> +        overflow  = vfio_migration_check_overflow(migration->vbasedev,
> +                         migration->precopy_init_size,  "precopy init size");
> +        overflow |= vfio_migration_check_overflow(migration->vbasedev,
> +                         migration->precopy_dirty_size, "precopy dirty size");
> +        if (overflow) {
> +            ret = -ERANGE;
> +        }
>       }
>
>       trace_vfio_query_precopy_size(migration->vbasedev->name,
> --
> 2.54.0
>

