Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C46606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZvW/XH3P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOk3N-00015h-PS; Wed, 04 Nov 2026 18:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xOk3M-00015B-1k; Wed, 04 Nov 2026 18:06:00 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xOk3K-0004cs-EF; Wed, 04 Nov 2026 18:05:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kz7nLHUWHwFH5+Kt4lg5OnmVZhHDVepToDaqmnn7MlO/wAX/1HFO5yFH3/FSdb8QDGBXkMqEb//y/9FjpCYg+Bhlf8fymHH5B0Ma49WHHXB1gTOpofOh4pSXOZcQkmpOYKvx8tjhn4K1qOYIZMKSTbmI53TUQFffrFt0PpJV5eZMOtQRSnG94h7WIoYNwehD2k4oMGflDgdGEqsZj9ER1kOqw2ggOorCWvrmQU1CzT0bJCf5X7HN3JbM5mAmuY04VlRXO+1ciGFpgth2mYBj5Zmo1xdZTCSnPDDmUFyxNTTKmpMX8Fiq0Xi3sD+b5Dl7uYE5c0I9wJAu9sP7jojhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D+uq06nk1mTuc8nq3aScwft0mcD5sUqvVK0nOBx3WM=;
 b=sUrddQ11IYyPTJ/vcYZVYYaaUZEK8jE61mcsXk9uqPz+4z7yxtZQ1mY//S635OIhmWPBEGHVKpak/XZN0l6mZKOGbIpbesQ5tziiBOGhKOBTPBoQPmg0Lwu23LZYTW1IFTiKxB8v6esOFHqA7CNRFNZGsBEqMoAGBsW7GNeqmL9bW249tQ4dgbjdUVjwh3pAF3sontC8AUTrtb2Ss/7sfHkC55Kc8zoAc6ztodNz63DsebT3xZrlAt9XHI5jZq7FhZbdw5DHw1SXh3w8bKIy8GY7sdEDzdtaxbx2bwaFox1YtnnR7wfRxKGkqLvGFPN78j9hr2cViuz+9SWC+kbeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D+uq06nk1mTuc8nq3aScwft0mcD5sUqvVK0nOBx3WM=;
 b=ZvW/XH3Ps6zMQo5gIIO1rzPPS9kbBDIAf3cQV4Avmv6b+/yAJS94mb9JOKEukZkDjsJXqZ+rbmS7VJTmugZwKQ+FhIcfEewfMMfBau3ReO/iPj04Mm5Fa6Mpa3rTSAF7QmexrEDGgd8vIEuHq0jJbFrz6/hm43IP7vQxdlXrDBxuGXBD9gHNdN+J7J+0aD/5YI61oatVrOohV4p3yA1gXi3ZB7Gb+fNd5OBuoScTZXAcADGVh1YaRnR782LLenF//N+bgoCf9sope8AEO20WYHxmHT65H/JcS7L7u1yl+H5Le24qu91hJCB5PGWo5sL5KQeoGcB9YQXzhMH1CzY5dQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY5PR12MB6574.namprd12.prod.outlook.com
 (2603:10b6:930:42::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 23:05:31 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 23:05:31 +0000
Message-ID: <15e92633-d826-4ad3-8fe8-fb82585b0d4c@nvidia.com>
Date: Wed, 4 Nov 2026 17:05:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hw/pci: add fixed BAR fw_cfg blob export
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, alwilliamson@nvidia.com,
 Jason Gunthorpe <jgg@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20261102181241.3077981-1-tdave@nvidia.com>
 <20261102181241.3077981-4-tdave@nvidia.com>
 <f46e21c2-a0f3-460a-a7a3-eabf19b7d9cb@app.fastmail.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <f46e21c2-a0f3-460a-a7a3-eabf19b7d9cb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY5PR12MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: dff6debe-9713-4d52-e543-08df3ac81fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|6133799003|10067099003|18002099003|261102123227099003|22082099003|261102130727099003|56012099006|11063799006|261021121427099003|4143699003|261022075727099003|261026121527099003|261026140227099003|261009223027099003|261028144727099003|261022105027099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: Em1zWGNS2YHNXgC9QE2fEUXejbVTjDGxk8Of4Xq//QGrwXxdVTXfzARDOOLGIRSsXeN0cna1mlVA+cPhKwFxiZALdG9L94pfUCdiNvMCWINlIdx36MTRi6NKsd/CXtQwIi7BZpUPh/SQ6m2C/2VzVf3BlyREObRnXih5lTWUqy9bQXQwbg9jhYE7rL6wfpbavYOmTr+G/PmRGz8I2cot1xQJqp/7rDYQj9iqDTOYqWzKSO7UC+UIna+/iRG3OJocRFcmn736ieWxvv/5wvjdV6Uf/mOjLajYEGX98SXw1045hUp4imtb1BvGapmYXqiut5p5baSKhpyBUdhQaIUXr6JSj2jeBoSXOhgOjvpI8WWjsyVNrySe6kNvyXh64ynWKMpTLRc/ZJXcgEK0FuvM0wDlXF4lZyHNLcMY+zO3fCXeNO3tRHzZMSvhegrT/HZir3285KkfygTWy3CnR0P97R1pV/UCOxehCvWYjfhU+A7dN3N7nIHeYyf8Di4UO9ujEuX6dY0ZLm3zSVwZDB9OWG1zk3l23uPk5JJdLx2WB5tJpTLD0Nmwt9wEqhUWENxou9JoPQPGNnv/El9JCbzMTAst635gGp2/AyowqunFIMGa2RaCXd9QVjflvXbkTmjoAk6MR/CKftFoKXQkFSl3G61jDAFsF20EPoxW3ARdQy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(261102130727099003)(56012099006)(11063799006)(261021121427099003)(4143699003)(261022075727099003)(261026121527099003)(261026140227099003)(261009223027099003)(261028144727099003)(261022105027099003)(260925021911599003)(260925022911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3R4a2c5czFLUStLTmhZd2tIY2JPTlk2SnZKWWcyR1dNRE96TkozaXlFN2Ri?=
 =?utf-8?B?TVJ0V0U3Z3R2dktRdmZwbUNkeTNxRllQamtCOHY4MVhRMkZwSVpUbkl5KzU0?=
 =?utf-8?B?VU05Q0RaanV0bUF6WXJQNWd5VVoxVWVRakxUY2FJRWErTEJvK2MyVzdDdXdV?=
 =?utf-8?B?TWt2Z1BwL2t3NU80OU5ITi8yYVk2SWFUdXJjUFZHYklJeENzKy9xU1FVUDdK?=
 =?utf-8?B?MTg3QU9pVDc1elRrUFVFTnA3cCsxa3hySDRXb1ZiVnprcVMvOHpITlNibE1h?=
 =?utf-8?B?NmJ5bTYzaEFGU2U2K1ZMYmhObzFZQkVJTExKODhZNnBJNDY4Y05IeXFlWG9y?=
 =?utf-8?B?SVBGeXFLazF1RFJ0dU5WcUdzd1FVNy9BTElKM250QVZJSzVXeXdJRXgvYnIr?=
 =?utf-8?B?bElNc2VnVXVBcm5vVVA3K2RTa3FqWE1BZjNjRU5zQmpLMHJJUGFraW1vcWh2?=
 =?utf-8?B?ZVNnSUNISTRkZVZKR3NYbXNEcHFiSTRwZDVqN3J2WlZicklBUHRXVkczbWNt?=
 =?utf-8?B?eGY3WWNPT3RaQk16S0hxL0tjcktOM0dXeGxBVDRZZ1BkRGJkclVIQkQwRHln?=
 =?utf-8?B?c21uYzU1dGVLZzA1aHJYbHNNT09oSTByWC9wMmdHcHEvL2hma1BVY3FWdm44?=
 =?utf-8?B?NFBLVnBjaVFCbHIxdi9kbElsMUhVbWZMMTBZUDdqT1NPUm1XSXVxMWVTRFJF?=
 =?utf-8?B?ZEZQMnVodFNFWllPR1JsVTBpOXdxYTZnV3N5OWpTK01Ka25BQ1BuRUw0ZTRW?=
 =?utf-8?B?TGRiZHhlWXRqT2N5bXN5MlRCMUZBYUI0YVdKOWpha2YwYldIWU5pV3ltUlJU?=
 =?utf-8?B?ZS9IU3B0bS9EU0wvRDB1MTduZktFOWx5dkhodnUvVExxVGkyZ1lzcmpGMW8w?=
 =?utf-8?B?T2FxS1NEc2NQUEZPdVlXT0hvZENJcUlJZHF6dXhFNWxjTURIaUVzK2lVOGZV?=
 =?utf-8?B?bkZWYXBYOGdoc29vcFdJcUJDd2s5Q2RObGEyTC9MOENVaEE3SE1Ic0R5SFgr?=
 =?utf-8?B?cGFYU2ROeGpEVzVURWpsVUpudXVRV3NpNHJjRzhiNHBSU2xLc2l0ZitEKzdI?=
 =?utf-8?B?MzBGZ25NV0dsYVIzQno5amdvTlZ2N0c1bS9MREFYc2lhQ3Zjakp0eG9uc2Iy?=
 =?utf-8?B?aFZCelV2aXNrektKVXFXR0xkNjhNZ1h4K0xrWUxpUWJudTRjOG5mczM0b0V4?=
 =?utf-8?B?K0VxTHo2UTBNdXpZV1Q5MzFkS2o3c3pIWEZydS8zN1ZWZFdhNEw4Sk9saDBo?=
 =?utf-8?B?eGJDNytuK2hxVW5WdFY5TTVGQTBGSUh1N3AyR0tNMy9zcE9MT2x4dEh1OUVw?=
 =?utf-8?B?Qk1wWnpKWDhKQ3FZd1FhSVkyL05zSFA4UXRkSVNiSExYcER0U1JNeVBmTHZ0?=
 =?utf-8?B?bDFIdElXN2VTdllEWmJrOGE3RG1Bd0NuZ0Y4N3lHMnRWTVRRYWMvenlHbHor?=
 =?utf-8?B?VzRjV2lnTGJrRWlLejFiQmtnOWhIZ1lGNUlMRU04aWdMQmtBZlpOcmFPejcr?=
 =?utf-8?B?S2l0MjNiVFk4RzdXRDEveXZ3cjJiSU1Yc2ZXY3g5SkxYZEF2RHZUYkNSN2dx?=
 =?utf-8?B?MldUQmp6UFRPRlZCSjZCOGpkVWs1MExTaEVUTmNpaFFNV2tKNG84T2dob1Jy?=
 =?utf-8?B?azBEVnIrQ210ZnNrcklwK2swQllqOUFTaFF4YWRkRFFudkpkeURUY3hsRC9Q?=
 =?utf-8?B?SFJoazJBNWVPTFk3RGRKNEh1ZSswQ2tRNEI3SXhBRmRpMks1cERCbnhnZjhC?=
 =?utf-8?B?Q0ZsYlJYMGFPeFEzV0ZoMVVIS3BmODk1RXl0anNsUkJSS3NqM0xReWxaU1di?=
 =?utf-8?B?eGwyVXk3ajA0VlMvZnd2d05xSm5sMDFmMXF4ejVTWTZkT1dZSFpYSTRxdGZs?=
 =?utf-8?B?d2dyQzRkeXhKNGE2M3FwVU52VEFFWXpYSjFzeXNEc1ZMUnoxVCswYnRaWHlB?=
 =?utf-8?B?OUtRMUJLNHc5T1JkNkphSVk0TEFrZXpINThzZ1FJWUpTMkppUEYyU1FWRE1p?=
 =?utf-8?B?c3RpTmcxTkJTWHFDbVdhNVNMcVEvRUh3bDd5YUZWVys5c3FuS3A2VENwdFlq?=
 =?utf-8?B?ZVVRK0JDazNPNDFHYzRzdGh2eFdxaDh6YnpGam1jQU53b2tPMTJiY2Y3U0k4?=
 =?utf-8?B?Q0I4V2ZtM3FqUk5ZcjU5blFxSjNoeldSTk5pYnBIMERCZ1NIbzR3VkFVbENo?=
 =?utf-8?B?K2V2OHlRK2lBTHJkVllrZjFRa0xxLy8ycHg5NHErcSt3ZjU2VkljMFM3STdl?=
 =?utf-8?B?aDFESURJSkZ5MW9EWlBqMjRTTkJRNGJoaFNDRTJtV1NBaTBqeFAvenZWTUhi?=
 =?utf-8?Q?hB9tVvlAGBBLncv9qB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff6debe-9713-4d52-e543-08df3ac81fcc
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 23:05:31.2479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZGszRvxinP4+nCLIgmQrcEIpVDx5n0wIYRc8MCGpj8/oHUKvlltikHwhMpst6vzWiYFv3Mkc45MuVRI65HBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
Received-SPF: pass client-ip=2a01:111:f403:c111::9;
 envelope-from=tdave@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 3:59 AM, Ard Biesheuvel wrote:
> 
> 
> On Mon, 2 Nov 2026, at 19:12, Tushar Dave wrote:
>> Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
>> device and BAR information into the "etc/fixed-bars" fw_cfg file.
>>
>> The blob contains an entry for every PCI function with memory BARs.
>> Each entry carries the device's vendor and device ID, whether it
>> has a fixed BAR configuration, and its firmware device path. Fixed
>> BAR entries also include the configured BAR address, size, and type
>> information for each BAR.
>>
>> Document the format in docs/specs/pci-fixed-bars.rst.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  docs/specs/index.rst           |   1 +
>>  docs/specs/pci-fixed-bars.rst  |  75 ++++++++
>>  hw/pci/meson.build             |   1 +
>>  hw/pci/pci-fixed-bar-blob.c    | 308 +++++++++++++++++++++++++++++++++
>>  include/hw/pci/pci-fixed-bar.h |  63 +++++++
>>  5 files changed, 448 insertions(+)
>>  create mode 100644 docs/specs/pci-fixed-bars.rst
>>  create mode 100644 hw/pci/pci-fixed-bar-blob.c
>>  create mode 100644 include/hw/pci/pci-fixed-bar.h
>>
> ...
>> diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
>> new file mode 100644
>> index 0000000000..dc94debfad
>> --- /dev/null
>> +++ b/hw/pci/pci-fixed-bar-blob.c
> ...
>> +/*
>> + * EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL's CheckDevice interface
>> + * (UEFI PI Spec 1.2 Vol 5) only passes VendorId/DeviceId/RevisionId/
>> + * SubsystemVendorId/SubsystemDeviceId, no BDF — so in EDK2 we can't
>> + * match a blob entry to a specific device directly using BDF. To work
>> + * around that, we prepare the blob entries in the same order PciBusDxe
>> + * discovers devices, so matching by VID:DID inherently works.
> 
> This sounds rather fragile.
> 
> Could you elaborate on what order this is, and why it is reasonable to
> rely on that approach being stable?


PciBusDxe discovers devices using the conventional PCI enumeration
order: devices and functions in ascending order on each bus, visiting
a bridge's secondary bus immediately after discovering the bridge
(depth-first), and root bridges one after another. CheckDevice() is
called for every function discovered, including bridges. QEMU exports
the entries in the same order. For each VendorId/DeviceId pair,
IncompatiblePciDeviceSupportDxe maintains a counter, and each
CheckDevice() call for a matching device consumes the next
corresponding entry from the blob. Accordingly, the blob contains an
entry for every function with a memory BAR, whether fixed or not, to
keep the matching simple and in sync.

I think relying on this order is reasonable because it is determined
by the PCI topology configured on the QEMU command line. Since devices
with fixed BARs cannot be hot-plugged, they are always present at
boot, and the resulting discovery order remains stable across boots
of a given VM.

-Tushar


