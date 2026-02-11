Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE080E9E302
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9vC-0000Gu-2c; Wed, 11 Feb 2026 08:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vq9v9-0000GJ-FC
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:06:19 -0500
Received: from mail-westus2azon11010031.outbound.protection.outlook.com
 ([52.101.46.31] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vq9v7-0000jz-Pg
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 08:06:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C39fyvNaoSqLoikjI2titiQF3iQ3lVLb0Y74mQQya/X2/RNEV9tckuU/osy4u+n99ELJNYCTwYlZIV6gRhglWRTuo+S2FsT9z53pPcIyTveuvnOnvzYfKzhfidJ9SkPlmyjOaUM9WKeaa2QTMwQnygdG5+tqCsDOzBGTEfkuWjozAKq5Z++AylpePZSW+WAeF701adPFbTNvTAwnC9tOBaXuT4h7+J1FdEidBIAM0ZxTDbwTXCo2YuVTcd51oms6anwVpuple48GTa3Vqa5jwF1lmGx3nnylserhjdTfQgZxiMm6BLdLTZHxUBWrZN4+6ZtRZrdYU2epqNSwZHzANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1IUhznMQq9bM+612tWZPqe4tQTVKJ0Jg/lQDLO0Qvw=;
 b=P6Yfu+ZH8HfAu7AOqoB0T6iP+XeUYIZjmDauRvvr8uBfpWzUxBOgT0fmfWODg+1T2QadRuRoJaDHx1O3mG2t+x827Qh/A6wXjuQclvofRaK/DE0QDsJPmYaMDE1a+RdD9nckuS0smd3+QzLdNZiOlLFNMaDwWQ5BlvQjC9EPZ6vQ/Dq9EGqdDgFoiKPDJ9enU40OzYc80GuSuE/J+CyLBI5CJdAJV4bATHknFYdzh2hNbyzbJGEkrjqM0SPe7Fb58oQrzW7h42e0J2NbJTiywKh8w9dyDvmQjqVUvLWXMLKLHo3cKIttbEU1nJ0gNQnYRtTX4VxAY/MkjCfNsdpYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1IUhznMQq9bM+612tWZPqe4tQTVKJ0Jg/lQDLO0Qvw=;
 b=rgPb1ugu5qjNMqhEezLoK6ANjwmzxomFXal66qbkUzQp6dAd6rA27fEse2Oyn3QzhbsCRUeNSEeZSWI86eNsfiaprHJPqJEmAqU3nzvuPeMbF55dkdP/AnJBuFjOuNO+AwNhpj2YIfhhb6cvqMnu0zBHhiLpCZsC4nfwEfjSBezgkPgqNWhKfuDVZ5kRCDqx4FcQHy9rPBxPYauk+L0QOxvX71hXd3IyOaEwAMX8usHmx12QBIqQ/29AQU/WImrqppSgJ3XeNax3G2hilIRA1EV+Di17knraYXWAkAKId6nR4lyulAYdSRyLCWs610nKsy4drCFAxHEJUVf68h/geg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:01:07 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 13:01:07 +0000
Message-ID: <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
Date: Wed, 11 Feb 2026 15:01:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
From: Avihai Horon <avihaih@nvidia.com>
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
Content-Language: en-US
In-Reply-To: <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::17) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e56d680-aa6b-4bde-bbab-08de696d9ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm9zV3RCT28zem41ZXgyVFdiM2Zja25DaEdMQis3QURLL25aWHVRWlpYUnJN?=
 =?utf-8?B?ZXM5bW5MZmJQd0toMmNXK1F2eXk3ckhWTk9LUVhZS0dzZTBSWCtDb0R5anlh?=
 =?utf-8?B?ZlRmT3UvaTRzUHhYQWFudzNQNmxHUkFJYzc5RUlJdExrbUo4MVVtaW1HVEx5?=
 =?utf-8?B?bUM1SkdhUXpZVlliR0dTdGs4SHQvUFdoWU9GTjMxaS9LQ1RLMklKRCs3Um11?=
 =?utf-8?B?MXgyeTVSYVBEYnpwb2d6ak4rTEFsVHFwTDExUFQyVVoyeitVdnlEUlV1WFcv?=
 =?utf-8?B?V21EdEZucm1OY0hjRWFJdUMzVXdVbXRIeTBIVHphOVpiL2RkY2JBSXFTOWE1?=
 =?utf-8?B?U1dBUW91M0k0WG1LYkk3WU9mMU9GYlNET2xsVm45WHM0K1VRcmlYMU1mRVZK?=
 =?utf-8?B?WmVYa3lLbkYyVmp2S3c5U2R4akx4NjJpVDRVZ1FGUGFOV21DTUtRbU1HUzhQ?=
 =?utf-8?B?VjVLMi83MnVlMXI0QlZxN2NGMSt4cXZvazJRdzFOWnhZTU45WmN6NUU4Z0RZ?=
 =?utf-8?B?WEJJcHdUWnB3aXd1ditwQm9yejd3M0VJdWdOWlpKclRwMkpJNG5DUDQ0NFFH?=
 =?utf-8?B?TXAxMWpEMmwyUi9PYTFMc0txS21Hc282Um9BK0tNK0dBQW9QM2FuZkpRWXEw?=
 =?utf-8?B?bnZTQlhTYnFyemVvNmxLMnFGeTNmMkQ5V0F6NGhBK3I2VjNMaXlPSHVPbFhM?=
 =?utf-8?B?M2d1by9SZHZCWE5ycHE5QWhHekFacEgvWVc4WmVEUkNqWWdKRGZuQnNncFh3?=
 =?utf-8?B?SjN1ZVpXdExZakJPNk1qckhKWWJ2cnBoTlBlU3VVaWEyWE9uL0R6N3dnT3NW?=
 =?utf-8?B?YjB1emR0MjNmTXNwRVpUNGNocXVDWTh6NE1EcERjQjFsM1VKbWVWMUtuYTQ2?=
 =?utf-8?B?WDU4TlR2Y1JuZjJRTWViTHdEU0lmWEh6U1dackNtVkhFWExkUVhtVDQ2VnJx?=
 =?utf-8?B?eWQzaWRWSDZJOWs5c0YzVDBZUGhHRldSRFQyVmd5NjdOd1NZQjYzSUFQTk1I?=
 =?utf-8?B?K2hPSHFnUC9jOEhOYU5vekRSSmpmT1QrQVdSWUNOaXNIbllTdzQ5c25xYjgy?=
 =?utf-8?B?RWdqUnN3T1F2cDcraTJIdkVKVUtFRGxWUlpNU0IwYkhGdDJNV3A5VkNtQmhn?=
 =?utf-8?B?akZnNURmYndRWVU4NDZua1Jsc3Boei91U0E4Nkpuek8wYncyV2dPdzdKdmtJ?=
 =?utf-8?B?SEFQUnFlcVlxNzQzOGVKKzRURTU1NEZkRVNkMjBLV01vY2x5L1NnbGh6SXEz?=
 =?utf-8?B?VGtNZ01oYURoenhOajBVQURvTjN5UXRPcUFMeVV3TVN0S1FwejNQTDlHVEZL?=
 =?utf-8?B?Nlc4QU4wbWpCZTBWZWhXUUJPVVgzL09PV0ttK1A4ZGtLbWp2bi9hemlvcnhN?=
 =?utf-8?B?d1ZHNTZYRmVDOUdLYTR0NXB0NHJoUitVeGo4SkxxNFNrRFFIN2xKQmJiR0dB?=
 =?utf-8?B?MDlCYlNSREpQRzRqaXhZOUk5QXd4TGZ1eEhOVDdVUWJHTHpwYmdtdS9MQzhR?=
 =?utf-8?B?OWlFRjBLS0lrcjBzZHIwbFdJd3RiVWN4eDRZWUFpdlllNUsyRk1wYzZwMVEv?=
 =?utf-8?B?d3RsZVpWbk9rekprcnpwUHdEVS9qOFlFQzRHZExXMmhJTlJJenNScHltcGlH?=
 =?utf-8?B?bm51eXZrYndoNUplWVVmQWVmUlYyUUtucldveFR4TDkwdnVNS3BKTUhVZGRZ?=
 =?utf-8?B?WEtaYS9ZS3BFc1E4TWRNSDVoOHFsU2FRMGRlRDEwNFByQ1dlQ1krRXB3L1pY?=
 =?utf-8?B?cnJmTDUwcVhsUGxpVXpTL1kwTG9tSlk5TnBRTGM4VW5ZdjRWZmNYcDVXT2pF?=
 =?utf-8?B?V0orYnVRYXdmRWpaVldYdUhOOGQ3Sy81SHZ6a0hZbVJOS29EalgxYlpFQVd0?=
 =?utf-8?B?cy9PVHNWcHEyMkg2b0FHeGQ2d1diUzEzalN1NVorS2ptWHZlY3VOT0NYVlQx?=
 =?utf-8?B?UGpKTWx6ZGhGTFNBcVYxSE9vdEZGV1Z4MkJwUnhoRTYzK1pqR2xyTUxjWW1m?=
 =?utf-8?B?TVpubkRPMzdrb0ZqcG1rcWNrckxOdk10ZWxzZS91SFZaWEtDTWpUQWplRzdV?=
 =?utf-8?B?SG5WWDFER05OQSt1M3h4RU5xQ0JmcllVTmM5OUYzVUdDYTErMUhKM0NEVU9V?=
 =?utf-8?Q?PZcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVhtYzVOSHRSZE93UGRSbE1vZ2JZOGFpWElNVmNKMGlvbWlEQ2FvY0RSLy9J?=
 =?utf-8?B?TEl3Wm1TTGJqa1VUZ1B4MmE5aEpKZXcvSm0vcTh6MlR4THViaXBpUkJZb2Iz?=
 =?utf-8?B?bS83aWJkY25YVjh2WlRFcVcvRjB6QUxBRFlsbWp0eTFGTVViY3UzVVgyc1lq?=
 =?utf-8?B?YWE5UjFOL3ZlVXQrRkJwNTc0QU1kTGdxd2VYelRiQW03OUcxSmcvVGJyS1pV?=
 =?utf-8?B?VTZwTWhOaXdseTZCcjQvWVlJL0NyNUVqUDFVNkl1c08vdE9ydXNtc0lod0Zh?=
 =?utf-8?B?RDRFNXc5OXNSVW9SdThDZjhGMGVCUFBIaDRrOWNHQlN5STQyakxyODZ5NFYr?=
 =?utf-8?B?bFNoT2xpUUEySDVsT2oxVHdBUGdKVEh5WEx4TDdvN0RkNHJNSUVsU0RZYjZO?=
 =?utf-8?B?cVZEWnhmY0dBeEdFb2ZZNjRQdGttVkNoT2x0Z2tJdy9POEJaNWZLaFduSk5V?=
 =?utf-8?B?UHd5QmpwbFMzYkRNUEM5cFRPVWhKR0lvRXFpcUliMmJaTlBRM3Fhbkt6VERn?=
 =?utf-8?B?YlhGVUlLN01nQXlOaVJkM0IyMXN6Y1dXWU5OdklkVk1JQlQzaHQ3UmJGWTZu?=
 =?utf-8?B?cFk4RGxWTGRZS2xzMlNlajE1YVJzdFNFVkFkZHRiL2xKd2xjRk1oZjQrSEM3?=
 =?utf-8?B?V1JOM2cwWmxTSS9SM0JTL2kvQSs4ZDh3bVYyK2NjZEl3VU81SnJKdzJqQ2ZG?=
 =?utf-8?B?akh2SmdUWWk1SWV6QmZkS1hGczM4cEFKWjVvM0JqU3A5dkhQMkh5WFY3OXhr?=
 =?utf-8?B?ZE1KczAyaEhBRkZrWDdEMzFWMUtGSXVrRUt4TGp5Qm84NmRjYy9vdnNuOEE5?=
 =?utf-8?B?QjJ2UFROelR0MjdvMkJCNXdteXA1aGxrZlN0WUdoUTdmRVRCMzRPYmM1NXho?=
 =?utf-8?B?bkxDdjhtU1p2MEN3ZTZkTFJSek1HcUNsSWdYdDhoc0pOaEdLRWdnRGRkMDdz?=
 =?utf-8?B?L3VGSWluTVRLY0RjSkdXbGltNmxuS3crWnZFclI0WHlkek9KeXZacWFNR3ov?=
 =?utf-8?B?dVVSZE1mMzdQK1FMc3Q3NXVrekZQdEYzMTJ6dCtCSEY0VG52Q1F3N2ozd2cz?=
 =?utf-8?B?dzNHS1UwUHlHeDBFTGlGbGRmTjBHK0FwUmpWY29oNEMrMnRzRmV6Z0xOSHJV?=
 =?utf-8?B?UjJRQmwydGNCN3gwT3NYL2pqYnlIUFJpM2VvVmFRTlF2MW00eU1lR1J5T1lZ?=
 =?utf-8?B?MXVGRTNYTTFtL3pmRUxrL2krTlY4ZjZ0VHZ6ZHRYK0NyU3lQUGNobFBTaEhx?=
 =?utf-8?B?ZHg5Qi9tV3NnazZGMCt0ditSREJLYXkyN0VBWE4rVThaNS9YWkprNGZ5MnBh?=
 =?utf-8?B?VVR1VVJUZEcxMFdkTDhGc3NCUkJFK3lJWTdiN1hGT1pQU3pvYS83WTFqVXB3?=
 =?utf-8?B?ZnEwOXNSU3NlN3B4dzdTb1ExWk9zVE8xNDU4SmVRUndMY0hRQ0g0WnQ3UjhC?=
 =?utf-8?B?Vlk0dS9PNGpEbXVhL0syaURvMnJ3YmZHdWZ4K2pCS25wTDM2Y09kUjZvcVgy?=
 =?utf-8?B?UHlFb0JJM0drakVLNkRIbFFleDZLMnUzVWpBR1ZtMEdZd0ZESmVydGdrU1Jp?=
 =?utf-8?B?TkVURjQrbHY4WmV1blVaTUxLK3pXblVabDNudU0vU0lkUkNCMmk2YW4wdElB?=
 =?utf-8?B?ek5QSjA5eEdNcUFLL3ZmamVzUUoxNEd3c0phR3FtSG9qN3Y3d3ladTlGdGY0?=
 =?utf-8?B?SkNacjlWaGNoQXZ1NExnWU1oUURyai80VDd3bThPM000Umd4N253UTBTYk1m?=
 =?utf-8?B?RzEvUXF1aEtPZlBNQS83SXV2L0hSZFNTaFZTendGUk9KWjN5V1hPNUkzeWdx?=
 =?utf-8?B?ZXg4Tm04amlQTExBYkR6UWg3eXNoem8xcFhWaFZ2L3hzU0taWFhhdjl0dW1N?=
 =?utf-8?B?QzFub1pDY0VVWVU2ZWYzajdNbitxU0dmYkx3L1hHT0JVZ05lN1hlWDd3SEVw?=
 =?utf-8?B?NkdxdVduTXhWOTJoNnJCbVJyMHJwckR1ZkcyMUwxOTI4cEJTSStKQjJHRi9z?=
 =?utf-8?B?WWdpQm8yV0NRTm4xYzQxODFGdEV3bHRpUmJVY2llenErR3FqZTlicUZSL0xN?=
 =?utf-8?B?c2dudnBEWWZnekoxVG1zY1ViOG5MdEpKcTcwTlJoSllGTC9takdOaks0ODZo?=
 =?utf-8?B?dmFjU2FNeFU2dDhrYk1WbTJ2eVBBelFrMlZxVTBzczZ2Slo1NFZEam05cHZH?=
 =?utf-8?B?eERSZkZaSHlWQVJONmlIVFF5L01qUEdhQXJuUHd6TWl4U0lQYkhuV0RXQVVW?=
 =?utf-8?B?UmxtTWJSc0hyNnlDa2JBbW9LVmVaRVFsNVZEVFRWVEtrSzI3S2JIdVlFb1Qz?=
 =?utf-8?B?OEE0WldYTFdCTUlpYTNVY3FDYVhzaW1pU095Mit5OVFkUzhmMzRXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e56d680-aa6b-4bde-bbab-08de696d9ed5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:01:07.3460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjBFQDezkVY6p0lgc1ikHFBD2oBjHZTt2XqVBtPvyyRfrCmPC11Un+L9B54vi2C7iZOmvFTmbA9/25PEceRV7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
Received-SPF: permerror client-ip=52.101.46.31;
 envelope-from=avihaih@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 2/3/2026 7:25 PM, Avihai Horon wrote:
>
> On 2/3/2026 7:02 PM, Peter Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, Feb 03, 2026 at 05:48:11PM +0100, Cédric Le Goater wrote:
>>> Peter, Fabiano,
>>>
>>> Do you think it would be interesting to send VFIO migration events
>>> by default ?
>> No objection here.
>>
>> IIUC it's a matter of why it got introduced with default off in the 
>> middle
>> of 2024?  If it's about compatibility of any old mgmt which may be
>> surprised by these events, then we want to know if they're ready, and 
>> then
>> if we need a compat field for it in older machine types (or enable it 
>> even
>> with old machines).
>
> I disabled it by default back then because it was only needed for the 
> use case I mentioned here (specifically, it wasn't needed by libvirt).
>
> I guess you can either leave it as is or enable it by default, it 
> won't matter.
>
> Thanks.
>
Hi Cedric,

Are we good here?

Thanks.


