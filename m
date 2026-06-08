Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC9DCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe9P-0003hx-5m; Mon, 08 Jun 2026 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe9G-0003ee-3s; Mon, 08 Jun 2026 13:52:30 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe9C-00085Z-I5; Mon, 08 Jun 2026 13:52:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGVTxSh3xLBOKXV1mLUeuKXtP1HGkfojOYfbR5JNfgeZmqvDhXxBfRPp9FcABXdz6tNwRzOdKshFVz7F6cb99LUlUEEPTiGF1FOlgD306l4G67Izh5Z5Li/eSeNF4WiRZdMybmz5nGdIBw+BWFiO+MoOD7ZKDog4V416HZdI0WnRMbVekWzLJhBnpxD29cQHWc0FwkUOD+pef0/on6mvpv8P/Y6sxPO2BMB/AfYpHws27DZQ/ghljs9sNKaIk361e7I9A9dfFlKDCpAc75ODs3bBIBySIpoz1EvCg4SPwM/GA1hD8W2tNXgD76nqMlQq3G/8TtM42mIQWyhskX1wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wloRYHjPP5uMPTVp59Q9NgQtZsVTQFkSDLlat5NyX4s=;
 b=pz20Nbr8LtPtlY3wLHpQhX3AlG+3/Scg/MDwrsgOZTxU0GcaUKdnGEH/N7jeHveR3RyE9KZxsJsOK+cSjUaANfAKhd2s4GUmgIe5kaU7R7TikeUB6YY25yVaHZa6TTg5AX7+OC4DqBL5GRKpjQWPQyLLQ10RftTbPb6Uko9lGHFqw0r/IkBLtLApcXloWW7I6t9XiIYhxS4xHtzy3yW2SSKwrq25AT0EHVEZK7DcKNHL3Tw30DKcPfDz5kVKKIGgkLdsi+adxP09bQ5y9TJcC7BqpOLtTx8X/IDyDZqQeS8xTEhfBW4dXDjNyu+eyUn5wpf2mAU3rwQ+XmJzFMO8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wloRYHjPP5uMPTVp59Q9NgQtZsVTQFkSDLlat5NyX4s=;
 b=l6Z1d7WHqUUf8OE5YKWfdsvHoyoMT2vIfe4B0gB4AaPmqN6deroFBSZeosblZCwLM3Fi/E7Gu2GXtZTuWBwdyvltOYuh9ApHLEAG89RHoVb3Qu5oxqZc3hiS4qpLr39FWgPiKu8yVEt4OHKUbmshhllyeyUp9gbgaUZwOm3nmONxTg4vyOogWRSl6sr42vZuiSprRr7IutyadSzZ0uipAuKvdDTodOJ+OFS5wMPLX8edVZKaLGBoKSkbqz8NSI0I+MBU4WwjCbmIe8QPiFWhYzK9r/QU5t54GY6CVvGlu0U8hapy3bYgFw+ocIQGxEu006QsLSc3YTqhzksMEatZeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 17:52:18 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:52:18 +0000
Message-ID: <98e82956-f235-4f13-9933-d7250761dc72@nvidia.com>
Date: Mon, 8 Jun 2026 10:52:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260605001712.1823737-1-nathanc@nvidia.com>
 <c17dc055-405a-42ab-b028-b12ed8feefea@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <c17dc055-405a-42ab-b028-b12ed8feefea@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a369a70-17a1-4b73-1165-08dec586ae95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|11063799006|3023799007|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LSH9pkSQh7ORFje+m2X5z276Pcmi1v8vI6O2GWctBGz/XHnSJJdHWtYIbVLndixkr+DJ2/tsuuc6HDUaR/8KPDmu5wE4mSAh8+irUqJrmVCJsG7Ez2oAOWlNYGmxOi8CJEKbRAB669yMQIEyVJvik4MDj2rv1oykkES4TyqlbKX5qD+sMZv2U9zej4P0P8rBWt9aAZkV/4wkYBROWDDwcHYV0asXaTJ6t3eqFbzQ6zywDR1PfcJNfOWXpDTFUoQPwAshvoHxdUVeGoT/4R3MtGBtgow5od+/eoYvS8lJrgJKpHdsNNC2RpQZ52v2cI06pz61PqA/Gs27gkTRNe7gADoig1p7a1BoMjRrfmFym6bnvI9IU1SD0i+Qh3BcZx4yTAzWRKevCWpiMt2u//wzQOlAcdqanRVFzlGOKW+CY0Ps+ZkKqrkUtkH4boFRI5sOeQ8F0Gh+iXFFJ0Ob0EzxDNd0bXPvo2f7lAfeXg5Q4NUcwMFItAI5ZOt4wxi1Qff2dcaJJDCsq8MAvHyFB8OJTMs7IkDR5r0X5a5wtuUV7Y4cFBq3LMPCRopjiRlz3OaD6BlgSxL3FME033ljY0MRaLr1qk0AlSpqKW1Wl/hW8UOzVMo1mXWkq9dH/QBrshSxejkSPZxCQN0JNTwUw9HC5J5XiHo0ZR7oT7FMXj/fIXEStljx5SFn9vaeOvZlmsJ3X8c3DoJYMRcp5US52o/Qkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVjL3dxbE9UcVpDbVFIb0cwNU8yRElwa3I1V2taMTdhOENZbGhVTThRT3l4?=
 =?utf-8?B?SFBWR0tRK3FHWU9McTNjTDJmaEY3U1VSKzVBMExJUXYvZXltQUdIYVZjSjNv?=
 =?utf-8?B?UlBHdDBOcCtFMXpwdUVFaUdyWmdId290WmRoZUJOL2NMd2xoS3A1eURuMlpm?=
 =?utf-8?B?Mmc4WkFaeVg0WlBraTdURzl5b0RBaFQ3WWlTK0ZTaDdhQ1ZFRk4zZUJDdFdG?=
 =?utf-8?B?VERuaGZJTlpKOHF5VWJCTmRVTFF6OWhmclRpdXZIbjREb0NjK21rYnl0SmJi?=
 =?utf-8?B?NXRzU0VIREhUWjJFWlBXNG9GanVoYjVzUU1rSDk1d1ZxbnhHNU8xRllSdmty?=
 =?utf-8?B?OUdwWGM2SHBHN25tUThVL3lTT2pVd2wzRGNxaXF3Tnk3Q0VkL3Rnc05jZUV4?=
 =?utf-8?B?N2tQcU96WmVKcnJOeXJHNjRsWEVlT0ZaZUZoSWdDa1ZhL3dLUzJIR3dlK2pn?=
 =?utf-8?B?bVZlaEdDZmlmS1VndVFzK0FNNUNoelQ4Vjd0S1lYWlNkVFo1RFYrejltU0h1?=
 =?utf-8?B?UHBBamhNTjJCd2JjdWJnN0VLVVJWbCtEbG5hYkJGanplZGRBZ3E2VExXOXQz?=
 =?utf-8?B?M0VBUWwzTG1EdzRuVHhrcVlPellYZW0xVE9MM01lUVdYbXpFWEcvMGNmczcx?=
 =?utf-8?B?Z01lNnZIaE5kMDZBNEpKN3ZjT2dtSEdJa3ozN1hTeXk5eEtsMWwveUJTOEpI?=
 =?utf-8?B?S1lEdFNPRXF0YVJtNUtSVUFWRk1UZnBlMm15dUtwbkFrNU80KzhvbTdIU0NY?=
 =?utf-8?B?NUNsa0hPUEx2ZmhoV05RYVU3bFduWXBxYUc3aUFLTFZVN2RJSDNXKzBXbHkz?=
 =?utf-8?B?bHFpUGQrY1FPYVFPK3dMRzNpQkRWMTJ1NWxwTzNkRWJWbVhQZm5PMVdSZEFj?=
 =?utf-8?B?ajZHdSt3d0RRV1hzcWQ5S05PTWZHWWVqU3NJOTZGT3J5eWlEVC9aZk8yNnRt?=
 =?utf-8?B?N1pDTm5Qc3UzYXBYYU5sbjQ0TDdsOERKdFF2MmRHY2Fpd0VXeDZ4ZzNwWmZI?=
 =?utf-8?B?TndHOTFTcFZtVXV5ZE1ZVE1kVlU3WFFVZkUwY2NxSjl1QXlhRlBtdnp1UkJJ?=
 =?utf-8?B?T2ZZa0FDNjEvUWNvMzdJMzJKQ2lxcG9VWFJQTU1IOHd0OU5ZV2FkS3VNWlI2?=
 =?utf-8?B?dmxGaG81amtURGpJbFFMdlBYR3NwQ0RmNGhkQUZLQUVSSS9hUUNWRWJxSFBr?=
 =?utf-8?B?NENMRjgvQWNrT3ExN2F2d0Fyd2Y3cENxUVlnYlh3VWw1L2V1aWduVmFNbFFD?=
 =?utf-8?B?YnJmNnMreHBhMXJ6dUUzMlo1T1lUbFAzOG1rc0RBOXVvMlRuYkQvRjFPK3Y4?=
 =?utf-8?B?eERyMzNYenFRTTQxM2prL0JPTEZYTnIxUFNYYnFpM1NrUElNNTFJVm9JUStJ?=
 =?utf-8?B?bmF2TlVZcHRNbHZJM3VNbEhuRlBzZDVZbmlPT0JNcng4ZGJqYTdGQWhKUFdE?=
 =?utf-8?B?cDBjV1M1cmJWTlIyVzlXNUNnZ2pkQ3Rwck9JeG5vS0RGcjZERDFFYzE1RjAx?=
 =?utf-8?B?eUt6YlBjK3NRdmdsWndBVkFwNVhPQXcwRkpsWHhRUjNXajhqU1NMUkN6Zzgx?=
 =?utf-8?B?aGo0UUY0bzF6WGs1dVFCK0hRaWJBSVloYVlBNHJmd3RTY0JCWk0zdlV0cUhp?=
 =?utf-8?B?TWwydElHU0c1aFkreUNSUnlxYmFyUDJKUDFqb283b1BDSlJMcmpOQ2lkWjV6?=
 =?utf-8?B?clk4QzlVdXZ4cXRraUJVUko2ZW14cW9MN3VDQndwU0ZBdU9UNUJ4QzV5SEh4?=
 =?utf-8?B?cWtRRnkvVFIxRzBaVHQ3aVdGL2lhRjlDSVpzeWg2cTA5eTAvcU5ybjlzNzgv?=
 =?utf-8?B?YVB1TFdPclI0a2dUbkQyN3Jlai9idTUyWklJV3VOWHBLZXQ0TnpaYjhHWFd5?=
 =?utf-8?B?bWlDM1BwMWdMcDZHeDh0RXhQMzZUc3Z4UjJzTldtUkdSeEpJVlVuRUpZcElS?=
 =?utf-8?B?RXA3YmYvNnZGQWJ0TTNNUmhQVmpLYktreWhuajZBM1JpSlpZNnF4b1A5c0wy?=
 =?utf-8?B?OUNHaEFNNThJUEp3S21SUVhpWkwxTXU0bkhBTHM4ZDBnbXF2QmFLL1loNExH?=
 =?utf-8?B?SzNIblR0WmVzd2tYUXlsVkZPSlFpbjArVVFvWklZb3YrK0ZldGRSd3M0RGhM?=
 =?utf-8?B?NksrcW04MVFkcWc5Qk84ajBScFZSaWh1aGJHMUZURUl6U09BVjZ2OWhuNXRE?=
 =?utf-8?B?dFVlVHVsK21lSVdWM2pra0FtTlN5SUFmYjhDZWxaYkJUUVJtQ005K3QrNUwz?=
 =?utf-8?B?VHhJK0xvOVJiV3V4VnBXNXdueSs0OVBUNW9IS0VKdTNtMmlWYkVMRk1NaWdx?=
 =?utf-8?B?Z3dUWENJK2JvenptcXBJVWJ5cDNSSFg2VTJrOXJJeEZMOGpWOWR2UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a369a70-17a1-4b73-1165-08dec586ae95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:52:17.9927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRwwvIr+BVKGoUW275ReT/aVeO31rZt05UDXJmniI93QVdu9FoFQbRTQMhecrPKgxl6/ZXfsz5o271uV683thw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nathanc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Hi Eric,

On 6/8/2026 2:57 AM, Eric Auger wrote:
> Hi Nathan,
> 
> On 6/5/26 2:17 AM, Nathan Chen wrote:
>> Hi,
>>
>> This is a follow-up to the series [0] that introduces support for
>> resolving 'auto' for arm-smmuv3 accelerated mode's ATS, RIL, SSIDSIZE,
>> and OAS feature properties based on host IOMMU capabilities. This is
>> dependent on the series [1] for changing these property types to accept
>> 'auto' values.
>>
>> Accelerated SMMUv3 Address Translation Services support is derived from
>> IDR0, Range Invalidation support is derived from IDR3, Substream ID
>> size is derived from IDR1, and output address space is derived from
>> IDR5.
>>
>> The default values are set to 'auto' for all properties. If accel=off
>> and the values are set to 'auto' or are omitted and resolve to 'auto',
>> the default property values defined in smmuv3_init_id_regs() for OAS
>> and RIL will remain unchanged, while SSIDSIZE and ATS values will
>> remain initialized at 0.
>>
>> A complete branch can be found here:
>> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v5
> I am afraid this requires a rebase on top of laterly landed
> 
> https://lore.kernel.org/all/20260601215410.517009-15-stefanb@linux.ibm.com/

Thanks for the heads up, I have sent a v6 rebased on top of this.

Nathan

