Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB219606A9B9
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NnRp+05R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMu4v-0004ZA-Rh; Fri, 30 Oct 2026 17:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMu4u-0004Yd-D8; Fri, 30 Oct 2026 17:24:00 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMu4s-0000Hp-Hq; Fri, 30 Oct 2026 17:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aq5X9MtPXvQb+Ef4D/p1uhDpuAroRjY6r/h0za2OzoIWverM73EDNeAZpcsDtbjq3gkswnrcImpHJAxn5dI9duijWptzqcOvECScW8n2u5eqH7WBWCSl34Tpx5sWulmveImRRVmJyFz0BwAzdE5mPK2c6CtQlEQwIHedTMEqRG4M8S0n+O+qnI1fFv3a19dRwXgH6OgdH0TI08jt2Q8R+6WRe0fGhih4PD+foPPE3YCqZ6ckNKqkb6AlDiVKHVqxacbkki+z0S1BaBv/1EHjNR/eLeoX8rrbLTjU28qAqvN4RVrpu4bSmO+gkVpullhvz5L0KY4RbJ3MTCf62jf3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMX4YyBObTGF0oprBWo213QF299f9ofhAWswg/vI40I=;
 b=dnbjNGmqtysJ/9EBj6ugDlOnZXafv2/k9nxuZIzNAMz+f5Zx9HctM7G0ZnpoencOEBwO90WwQLZWMMRB4wjvi0QXdcHhFlWtWHS7cuVuriyaWUyURel0Q6sh2/ua9gsSj2GuX1jVghwC9Dvio8VZwFAs4txo3aTLYXoiXQwnvQU5n2H8BlPOha92X1B5BREA1b9puWsiHU4Y+9jJyUqf579Tq4oxtzTbHOkULl2EYjIGvgNcbCkmMGNB/KT7huGcaptINAUlXJOjOaVEWMUYzaQD8sZwLHDNf8Dg+ftRNzcPS7VziSwnelGQIB6Q+upyCSB7z4W3ggOYP1yNYPJS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMX4YyBObTGF0oprBWo213QF299f9ofhAWswg/vI40I=;
 b=NnRp+05Rzdm3qKBXZNmA6ST87I8FM/2yPTYqJ2tBzgvzS0/v9vpfc37h4Nb9bEONESB2RiuHP0yPPZmLRKhl5WVwsnxY2PeKl5HdJuE9uFCDE/dQs+BJ/CV52F/fXe3+Jvh0d/2kFdUYW0PRuENfsxeXgoFom1hmmUHE3JilNrNg2R3J933+6XuWZyV6xBziiV2G8FC84SkqjyDJExFI3dkQzOm9sKPY2EGqIsGB4z+RJkxdxAzUQORJoLxT4CvaoprUrQHpaPuzniPpEULwfMYXvDxfGVLyyH3Se2o/TN7htJ4yhKiZTWgiqqi5zwvEtAR0FNcJipdDUyxmeDFNdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by DS7PR12MB5816.namprd12.prod.outlook.com
 (2603:10b6:8:78::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:22:08 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:22:08 +0000
Message-ID: <b2a027e8-f710-4a62-b3f8-4c8c945d1b49@nvidia.com>
Date: Fri, 30 Oct 2026 16:22:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/arm/virt: add highmem-mmio-base property
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alwilliamson@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-6-tdave@nvidia.com>
 <SJ0PR12MB861457018E7FB359517B200BAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB861457018E7FB359517B200BAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|DS7PR12MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 67724315-0716-4435-3631-08df36cbdab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: FzsvUuJjKSt5jndfmQNCQLifkTwbOKZl20O1P3efNBjw4FboMNo0xZ7Ax3Wn8fz/1OWiPiCjr18zRXfxMl0cLkd99g97nHampzVSA8eOIsaGN8/xKbhkoISQ4r6lfEWJymhWHzVnoBdamMn/junNeqVB1ADsKoTuao6+KhDPFcDdGRmm73kXTvJG83Kui6TYzidbBmPUxFfneaSFPhbzJgjCsSW3BnWgBKHNRWBWXgoqrUBnFbOa1J+iWTjgOqbeQWWDE8j1Ki/uHrlkcgAA4TJi7vhjlMBV5DZGtZaVwVfzWuD+/s2/NUeX8sO67K9qO8kLrks30eqZj3kWGW6go8HgcPWhJ0OqMDP8yUjn4LFICE/v7XF45B4k/7G3eRYuGATSQpQ7/9AymrkACVfljOfgLhz5ABoJWDxpIKbvtmJHD5uXJJ1ewtZR+EpBZzCQExSqKrLycCj7FfRaLzuyTRdw979shJKB8UhQmd2Gktk/COjkJMy38BaUZkYchdGDtHOhqwVf4jQt+276iukZAn+Si01L0XYm7MNpbsKh33B0u5ipSVm0lnbFBvcmpX0uvlfSnvLrtGuFYJiH/xRcdR2ttADRdpwBOY6j1Uyt4QXAUsiZW0V69TzCaq/VEsbyd76/bz4hb2fsf8EU8ykufyoFzTBb29vALnNLH78EUZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRuN1FUY1RqeWpPNkR4amhUa1E0T0VZdUFIaXhNdGRjNmt5V1hkaEhkUS9n?=
 =?utf-8?B?YnhOL1FzZU56cGxrQk1pZUE5ZkROZHRwczc2Z0VESDhRelI1cVVIcEFOZ2pz?=
 =?utf-8?B?NnJIdkxOSzFSYUpybDNnc29tMnVKL3B2YVFKN0Q0aklKQnVIM2RhNnJNL2FU?=
 =?utf-8?B?dWpGM3hkSTZRQ2l1ZDRvV2I1djkrbVVhM0RsTy9OTjZOZFRhaXhVTXp2eVJT?=
 =?utf-8?B?YldsbEFsU2JYTVNINVRZa2lVN2JtSDdLb3RQWk9KZ041QUZuTG1JL2ZlZnl4?=
 =?utf-8?B?VVBYaTFaWnVrWERqbEV3ZnJaV29tQS9oUVBzeHkwcXlxSDFKRFpkZG52R2ov?=
 =?utf-8?B?ME5Oam5zcGVjWllMeE8rQVJ2bERFY2Jya1VWbXNGVlRBN2I4YjJFNm5pWnFq?=
 =?utf-8?B?cmNGTmh5RVY0RlpIOFB3RXl1eEhkWDhISmx1OFhpTXkwbWJKSXQ5S2lqWjl4?=
 =?utf-8?B?cDd2RUVhRC80MUJyWlM5Zmw4Y21WM2lVWE0wdEE2cHFiSjRhY1ozaEpONTN3?=
 =?utf-8?B?U3F1ekttQkd2QjR1OHM1eDNZOGVXQk5pUkQvTnNqeFFQOHlTMHJnUVVjR0tJ?=
 =?utf-8?B?aXdybklkcUNWallkQUV2Z3hWZGdaRnlGZzR0dDRHeTdCWURhak5FSVp1ZTQ2?=
 =?utf-8?B?Q3cxdG9rN05EMEN0UGNvZTQwTU81TlpZc0Y2SDdvU0dmQUEwTHdXQUp5eC9w?=
 =?utf-8?B?amVXRXhFQzFCM2pvTWl6SzlkeEs3bnNuSWtzeXNDTEtVZ2h6N0RJblBFY3g5?=
 =?utf-8?B?aHl6eGlCQVlQamx1a0xZbTBpQklTMXdzSW9SOG5YbDNkbVNCOVFORUcrZVNT?=
 =?utf-8?B?ZnJNdnJGenlWdW03TEE1NVd4b3FRSE1ZSkJOOTVrbkVIM0FHcWpUWUVTaSth?=
 =?utf-8?B?WFNidUpKc0ttanVLVXBHODcyWkh0QnM0SXltekhjbFRiTFAwc2JZNUNnQSs0?=
 =?utf-8?B?eERUME0vVnY5dDQxVFdoenZBNml6STFRdjY1cEdMUzdYbTUxTGRCUDhjVnRK?=
 =?utf-8?B?aFlhbGp4ZTBhczM3bStzRDc4WWFvdSttRHVPc0plSUx6SDZxcjRNQ1ZVZjR4?=
 =?utf-8?B?V29HY1kzTjFUN09Zclp5cktXVHRZYUladXQxdVV6NUt5WWMvSzV0NFVkTmRP?=
 =?utf-8?B?T0JqVlZwaVZxZGl1M05YcFR4dW5kdEwwd0kwZHNENmR5VGRqYTFrVGVWZXRR?=
 =?utf-8?B?aFp6T1ArUGhMZVh6Rngyblh6RUI4UktUcVh4a3ZtdlVkV3FSV3RKSjQzbWtE?=
 =?utf-8?B?aS9IalNhU1lxeEFnZURNY1ZlK3IvMFhHMlIrN2kyZUJJS0piQ3BTZkNoMm5F?=
 =?utf-8?B?K2ZwdERkNGkzZUdFSVlIOTN1U3U2S2hKMFAvQW9aa2pncGxaMFRGcER3OUZi?=
 =?utf-8?B?ejFHazkwbmlTVlpJVHdVNFZDTU9kUjlVMUdPazNkeXNtWWdxSTNiSW1YWkFT?=
 =?utf-8?B?RFpXNlA0S1cwZlF4cis1VWdBWFRYWWFXUGFraS9FOVc2Y2lsbVJTd2pIampk?=
 =?utf-8?B?NUVIczVGT01KOXRORWdYbkdidTJ3bHpTK3dDS1VqRURyY2lZNU1wWDVHcFB5?=
 =?utf-8?B?VkNPRkNBdlRVWlp3S3NzVXgwU29abEFQdVZSNU9iVmd5V1hiNyt6SDFaTHFi?=
 =?utf-8?B?UG1ZRDBIRkVhOTBYSFBPeUJwY3QzS1F4OXg4ZFFSdzdQM3R0ajN5QkxvL3NK?=
 =?utf-8?B?U2w3bzZTa3Z0QmJYSVlNTWwzcmlKSXNhdExObXJNdUJMM3lkZVZDbDZYV0VU?=
 =?utf-8?B?NU51dWVYSUVFODN0ZGQvT1BnYnpTVnJSNEUydnlCQTBjS3FpazhsdmtHamkv?=
 =?utf-8?B?SzdHa1g0QlJNcEpWd1pxWEgyMVAyM3cvbS82VmZpdEJ6NnBsM1ZiSDgzSnJ6?=
 =?utf-8?B?cHd0Uk0rTFhCem1XYU1Bd2FzeGYrNHovT1hZMEwvMFQ1Q3ZFell0c2FCQ0Nv?=
 =?utf-8?B?dEdkUG85WDBmSm1DRnU5KzNVei96VktDTUJmbko1cTM3VVp0Y3RKOElnVGFJ?=
 =?utf-8?B?RkRuTDRxcmNyQmpPN3JQY00rcmdFUGZQb3JHWDNCTElrR1VMZ1kwVWltSmxM?=
 =?utf-8?B?dXZKbHdUdm5kMHhJUlhKTEhBZEp4TzE5TDBsbkFBU1RHbjU1cHVBK0lRNTdp?=
 =?utf-8?B?ZlRHaXhvb3JuV24vZUI1blc1bkdjVkwydCtmcnQrZlJpTWxqazVGNm9udHFa?=
 =?utf-8?B?Q0RTTmJzWGxTSmZaU0pDYTl6Tk1WeXVIa0xzMEZCNGRXSitLRjFrVkNsKzdr?=
 =?utf-8?B?aXExOTVEb1hXUVpLQVBYUkloN3FCdEdpU3hJZStLb1hTOE5Hb2dQeSt5c1Ro?=
 =?utf-8?B?MTFORzF1T0VMWjUvdGgxUzVhVjdPNG5selhTZGQ3WHJKeDErMTNGQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67724315-0716-4435-3631-08df36cbdab7
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:22:08.6873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKtmoeHPsgV2M4dsp+NAZ0rhRfuW1EH0g+G8xEvoJJzP+bb9+L3BYuR413wEgx1guMQynaQD75FLSsgZfBApYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5816
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=tdave@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 11:27 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tushar Dave <tdave@nvidia.com>
>> Sent: 16 September 2026 19:56
>> To: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
>> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
>> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: [PATCH 5/5] hw/arm/virt: add highmem-mmio-base property
>>
>> Add a highmem-mmio-base property to override the base of the virt
>> machine's high PCIe MMIO window, alongside the existing
>> highmem-mmio-size:
>>
>>   -machine virt,highmem-mmio-base=<addr>,highmem-mmio-size=<size>
>>
>> Some PCI devices require MMIO resources to be placed within a
>> specific address range that cannot be satisfied by the default
>> placement. The configured base is validated to be non-zero, aligned
>> to highmem-mmio-size, non-overlapping with the existing high memory
>> layout, and within the configured physical address space.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/arm/virt.c | 62
>> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index c5db663858..3a554dd26c 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2513,9 +2513,34 @@ static void
>> virt_set_high_memmap(VirtMachineState *vms,
>>
>>      for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap);
>> i++) {
>>          region_enabled = virt_get_high_memmap_enabled(vms, i);
>> -        region_base = ROUND_UP(base, extended_memmap[i].size);
>>          region_size = extended_memmap[i].size;
>>
>> +        if (i == VIRT_HIGH_PCIE_MMIO && extended_memmap[i].base) {
>> +            region_base = extended_memmap[i].base;
>> +
>> +            if (region_base < base) {
>> +                error_report("highmem-mmio-base 0x%"PRIx64" overlaps prior "
>> +                             "high memory layout (must be >= 0x%"PRIx64")",
>> +                             region_base, base);
>> +                exit(1);
>> +            }
>> +            if (region_base % region_size != 0) {
>> +                error_report("highmem-mmio-base 0x%"PRIx64" must be "
>> +                             "aligned to highmem-mmio-size 0x%"PRIx64,
>> +                             region_base, region_size);
>> +                exit(1);
>> +            }
>> +            if (region_base + region_size > BIT_ULL(pa_bits)) {
> 
> region_base + region_size can overflow and bypass this check.

Good catch. I will amend this in V2 with overflow check.

> 
>> +                error_report("highmem-mmio-base + highmem-mmio-size "
>> +                             "[0x%"PRIx64", 0x%"PRIx64") exceeds %d-bit PA "
>> +                             "space", region_base,
>> +                             region_base + region_size, pa_bits);
>> +                exit(1);
>> +            }
>> +        } else {
>> +            region_base = ROUND_UP(base, region_size);
>> +        }
>> +
>>          vms->memmap[i].base = region_base;
>>          vms->memmap[i].size = region_size;
>>
>> @@ -3416,6 +3441,33 @@ static void virt_set_highmem_mmio_size(Object
>> *obj, Visitor *v,
>>      extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
>>  }
>>
>> +static void virt_get_highmem_mmio_base(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    uint64_t base = extended_memmap[VIRT_HIGH_PCIE_MMIO].base;
>> +
>> +    visit_type_size(v, name, &base, errp);
>> +}
>> +
>> +static void virt_set_highmem_mmio_base(Object *obj, Visitor *v,
>> +                                       const char *name, void *opaque,
>> +                                       Error **errp)
>> +{
>> +    uint64_t base;
>> +
>> +    if (!visit_type_size(v, name, &base, errp)) {
>> +        return;
>> +    }
>> +
>> +    if (base == 0) {
>> +        error_setg(errp, "highmem-mmio-base cannot be 0");
>> +        return;
>> +    }
>> +
>> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].base = base;
>> +}
>> +
>>  static char *virt_get_msi(Object *obj, Error **errp)
>>  {
>>      VirtMachineState *vms = VIRT_MACHINE(obj);
>> @@ -4286,6 +4338,14 @@ static void virt_machine_class_init(ObjectClass
>> *oc, const void *data)
>>                                            "Set the high memory region size "
>>                                            "for PCI MMIO");
>>
>> +    object_class_property_add(oc, "highmem-mmio-base", "size",
>> +                                   virt_get_highmem_mmio_base,
>> +                                   virt_set_highmem_mmio_base,
>> +                                   NULL, NULL);
>> +    object_class_property_set_description(oc, "highmem-mmio-base",
>> +                                          "Set the high memory region base "
>> +                                          "for PCI MMIO");
>> +
> 
> Add this to docs/system/arm/virt.rst as well.

Sure thing.

Thanks.
-Tushar

> 
> Thanks,
> Shameer


