Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1831E909AE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsMJb-0001kv-2M; Tue, 17 Feb 2026 09:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vsMJT-0001kH-Ac
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:44:31 -0500
Received: from mail-northcentralusazon11012010.outbound.protection.outlook.com
 ([40.107.200.10] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vsMJR-0001PT-FP
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:44:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSivSy+wMhCy56XOiXlwWKP10TlkhOyf0H6mR8O11cKNu7Q8y2nelsYXJ5J55MBq5Na3ClLKM10Shr1cE0ed8k+TiwTywXfoj/Lt/guljZmYBYg7l0262E6paYWS4KoluennIAJvPapdlxiQ70F3Iuh+UfNekTS9DxCaSR0xRFbpBFzH4t5rFK1ZDJ4krRjXG3sLEZ8Fpz1r143lIS+KG0pF8j71Ws+RlOXj0LMtVT9bmNAjqlSV/rzW69N+cfXSrfiqRF4EFEd7VOdJaV7BEscHcSiYuZ9+ggshgP+RD8YH2VA086E2HLXkULrzdDdJWX4TudwTTFOOR1xYPhh0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFnMuis653hREOcroMVrCpKsJV8aGx0AFBT6nCUyrWE=;
 b=oYYWocFf86TrqH89lkOwP2PGhgrEZhQdMtjR9CGdf1MhHAHBWlXi8dy9+FjtMOtyHCdB+3VbwoqN8xuro+TgJJSQQyCzsag1LdD1OPeOX2IPKcpycw4OHf72WIr9rU5EEuIhJF2jbiXnmtkQ4GjnYrrJAoEY8l/vMBq+6Z4zKqqW+CK2Emr73keU8BcU5ZC8b6vJqt2LO6JgL7VmjnLpYbiANjg7p0A6OfBq65zRpw0YBpb4oI0oehSrEtfJJ+Bus2Hn4SrTePdJyfJEJbm4OVafmSraHosXbNHv5W89rAkSsm6MyU7n6gn7SZuNxdlLgqM/x0Z2s+5Wo/LNHf8ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFnMuis653hREOcroMVrCpKsJV8aGx0AFBT6nCUyrWE=;
 b=AVp2d1JbtSGsgRCGzkHdlYsqg7xaF9Fi2gsVxexuwjvZ32e2UbSb0l2NtFhxP+RuND6Z8NNeNDmffldZge0x+YWgd34uVSeIuOK/2x0kG48QdTeIvjPUWuya4LQvpfs5n7jnRkjBNb9subdpviBM+otaSJ/uQYciWWT80LXzg0DQzgXF3MLl3xMyJp97VJdenJLlRFYWlkEw0Jdxs6ZmUqi5WFQM3YD/9d5nBQG15vRg509Gf5/wlSGI0M15W9oON0JSHBgPPtBnnK8SuUyZk2S6QbKVPKkB/qnCT0nnzWUQslOspuDjuajFf1t29Cxy9nGMKG25mwflCtSPdtmhzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 14:39:23 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 14:39:22 +0000
Message-ID: <d6bbd36e-7843-46f1-8994-6877877893e7@nvidia.com>
Date: Tue, 17 Feb 2026 16:39:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
 <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com> <aYIqDAdld4a41VDy@x1.local>
 <87cadb65-af45-4bb3-8090-8301a1e67103@nvidia.com>
 <a0dbd63d-30b9-4c83-851d-abaf50d4c9fc@nvidia.com>
 <aa18ad15-580e-483d-8e29-20c7e6ebb6fc@redhat.com>
 <1260f024-b22a-439b-a70a-ef5429162b3e@nvidia.com>
 <57489f93-0439-402d-b9d5-a9d2a0a30a25@redhat.com>
 <28ce755d-c562-404d-a096-09b5f32f0945@nvidia.com>
 <7701d5d2-bf51-4c2a-bf4a-e371264d5874@redhat.com>
 <68820edc-9527-4c8f-8651-64ea75db8380@nvidia.com>
 <93a65840-73ff-4587-9321-09cda8654f1b@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <93a65840-73ff-4587-9321-09cda8654f1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 377378a8-8c83-44b6-d0dd-08de6e325766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2tiMkxIOHordDdwb202ZDdqSTZwV3pLM3JQSFJKcFZiVUtOMC9Ic3h4SERY?=
 =?utf-8?B?VkowWDZBZGxLUEFVaHlOWEZYdXU1Wmt5dkZzZ2wyZWYzQk0zUGtaQXBHbER4?=
 =?utf-8?B?U2xWdjRyaUZtS2twU3BVeGdwZGEvZkE3RE1RSDluc29lRm1tZnNscXRtZlhw?=
 =?utf-8?B?VndkY2tjODZmTTdQSjM1TEVSbGxadmNqbUtGNG15Q1VjNytuUlg5L21BbXp5?=
 =?utf-8?B?UG4xN1VsOURMQXRQaHZXTXA4TG8xTGNBYTVXTU5mVGFkdnRqNDkyZDhOTC84?=
 =?utf-8?B?Z3BPN05qUWNFT2kvRk8ydE40bDZoNVlVZWRUeXNDbmFEb1ZsZUhmUUZLNzhs?=
 =?utf-8?B?UkpNNjF5TzE2WUpNRURzbWE2S0lhM0FrT2xRRkJINEY3ZURxWGxpNG1wK3B2?=
 =?utf-8?B?UlJQZHZiOWFXYmxPQXFqa2tMcU93OEljSTFkaUJMTm9RWFlSVTlSYW1vZUlY?=
 =?utf-8?B?ZWIrRFovWnJsOG5XeVRXaERSTHNDTGdDVWwwajhLd21iVzExSzgvK2dKanlS?=
 =?utf-8?B?RlZiMkN4WmJnR2ZVdG9kVXFVc1dkelhoa0lBTWQ0MCtDY200c0ZXbFB4MnJD?=
 =?utf-8?B?Z3k4MTIvMlQrWmFIdkpVZFZkaDhVYXdtcjhsaDcrREt3TVZkZUtkZ1kxcERx?=
 =?utf-8?B?NGR5Ykp2V3AvTnZBem9CWmNCZU9TQklVRFI4UVhaM1hwNnRkYmJUZ2NHb014?=
 =?utf-8?B?MzNUaEM3UW9GdndMSW9BbkZ0WTMydTZvNWdmWEhDSTVKRmVWdmVoZzJpQVpX?=
 =?utf-8?B?amZOZHFIUE9uNFJDYTRVMllOMit4UmxNcGdkYUg3bm1vNDZ0RkdZTis4VEEy?=
 =?utf-8?B?WFQ3SURvVTMxTDFZaUR0SWl0RU5Db2o4MlpiLzEyc3BjOGhnWjlvN2ZPSm5l?=
 =?utf-8?B?clJTREp2bzlJNWIwbHRaaFhmemRRZkh2Tk5TakhNMDloUU5rWWdxOUo1ZUZr?=
 =?utf-8?B?WVIzK2JDdVM4ZmdvL3BKaTdCK29DRWVUNEMrTkxOemVqS0ZuWXUxMEZWZjFu?=
 =?utf-8?B?dy9USFRoQkNKRStOM2RHRjRYbTB0Ung2QktodC9RdDE4MzNmWFROZTRTcmw0?=
 =?utf-8?B?UHc5MHFQdHA0cU1YL3FtWlhUaHJuSVJiWmNCMHNKZHltdEtlK1NlaDB1a3Z2?=
 =?utf-8?B?UVdGSDhzajVneGJ1c2VDL1JrWDhXaDROTzlaL0hOSWo1aXdhaG1XcXE3M3Zv?=
 =?utf-8?B?ejluNG9PN21sMFk0alNta3NJaUNPd0ZaZHczaXVuM3dieXgvZ3ZyamRMTE4y?=
 =?utf-8?B?Y1pzS256V3NHajlDYTdjekhNT1JQVUN3VUZKbDV3WHRLdklEK1cwTXNXRGhi?=
 =?utf-8?B?ODBKRllTY0IzcGZ5M0VNand5WSszSDc1blplMlBaREN6bk5kQ1B0MW5tei9S?=
 =?utf-8?B?dWMzZ0dvOTU1ajFSUkoxZ2ErOEZGUHJ6aUpxRHJkNE5jODlySldWd1RYTXZF?=
 =?utf-8?B?bWgrVG44Q0pVcFBvTFBnL3pXVmlOZklNcGNPWStrd21FRWh0L1dtNWh1THZ1?=
 =?utf-8?B?Um1WZ3AxTW1JRkFYOGVDUzB1U1RsdzhEVXIwQmFDZlRYeFFaSVFjZVpNTjM3?=
 =?utf-8?B?OFBlRk45Q1l3emlKRHZ1OEtCd1g4bXFjSkZtTVlLWExZTTVWcEdvSWNBT3o5?=
 =?utf-8?B?eUdaOEZqekQvcXEvUzRBRWZGL1JxMGVTTEsxQytmVkZyOWpHWk4xc0p5Qk5B?=
 =?utf-8?B?R1J6aUJPZnpXRy80aUZjbHJNZHJUQXZ2bFd1TmV2MHhBVXc4Qy8vRTBOZUhq?=
 =?utf-8?B?bHNMZ0k5QkZHVTU0MnAzTnF2VzM5TGs5N29OSVgxQUUwdmY2SEhsT2NxaHNj?=
 =?utf-8?B?UWlhcEM3UFZlZ3dROHBMME1rcnArU1Rsa3N4azUvZUtCNUZoamo0MHlmaitU?=
 =?utf-8?B?amNJa3haM3pMSVd3dEo4WlhZNzZncVFpZVR6K2xiWGI5TWdmYzQ2aTFLVzRl?=
 =?utf-8?B?bVd6anR6SExON2syZ3JwWlZUdVRyYnhBb1ZvVEhReU45TEdYSEpGYlZPRjl5?=
 =?utf-8?B?NGJnK1B0b00yZndLa1BKMU8vVDN4OVlEUEllVWVpVmNlelNsVWIrOEJlVDlY?=
 =?utf-8?B?NnIya3p3Tk43bEVET0xYQXNEZnpiU2lHMlRnWjl2Q2E1cnJQaTBLQytWSHBz?=
 =?utf-8?Q?gcLo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elo5Q2p2L3hGU29jdXZKMmxQYlIxWG4wVVNyLzlNdEV5OHVXWFpreUZqMzBq?=
 =?utf-8?B?d3d6T0ZoWXBQOWI0NVJFYmI0R1BwR1JCbUVlMGJPOUE4SWNFWmtaYlV5dm80?=
 =?utf-8?B?dEY2aTV0Q01ldzFnM2xsc0dQUXN6eWlTcEFZOTJCM2M4UG95WkdYWFR2Yi94?=
 =?utf-8?B?bEp1T0FzSEZ6TDlzSHJLVVNQMEtEWEhNZ3JZWVNOalZBUCt1WEUxbzEvUzZK?=
 =?utf-8?B?RXJVOXhwT0xzM0ZZWVZWZWcrMWp0ZkZZV3lCYk9SMGs5K0pSZmhtRTA3aHBN?=
 =?utf-8?B?ZkRPZHIxSkNrcjZLTDRqSCtTZm5jYW1iNm9KaDlGUFBSeWVpS2wrUGl2ejN2?=
 =?utf-8?B?T3BDMVFuOUFMYkFPUzdPekZxZFdERFg1Yld2UE1FMU5OSkZ2Q2lCamY4UEJL?=
 =?utf-8?B?RTRiUVlieTNwZHZLWmREdVJpeUJzTFlHTVRwRTNBNU5CVEVKb0k5ZkROa1pN?=
 =?utf-8?B?U0FHWHFWQmhIZ0lEZzZYbEVDTUtKOExzVC9uZzE0dUUzbUdKVmV0NFFIVmtu?=
 =?utf-8?B?VmhPbkpKazdyL2VaUElKcnJKSlhIRlJSSUJSTWsyd1d2dSsreUdYaXdzRHUy?=
 =?utf-8?B?UE5aUnBLanhTYzdqaUtPR1pjQkVzRzQ3YXkwTjNNcGN2anhMdloxSWFEdFcy?=
 =?utf-8?B?SmQva3pOcVBqVjR5Z3dSSDh4bzljcGNVUGhWMVZZRkczZEFMSjdCQU5acVA4?=
 =?utf-8?B?K2Z6VEk4SzFHcVRkWW9ZS3hCQWZKcVM2TXJBNGw2emJFREhDcXBpT0xBNEU1?=
 =?utf-8?B?MmtQd2szVUtUd1BjMEZRbkR6bDlSMm5SN2MvQVp5UXQ2MDVSblRxejJnVEM5?=
 =?utf-8?B?MlhxYzBRYjVmYXZKcnNkVGxBU0R4d3FSbzNWYXNoTGMybjhwMXEySEY5ZTh0?=
 =?utf-8?B?c0tYUHdDNWwrNWNwaEoveEx5VU9lOTJkNGJLYzhnclB4WWFMV0pZUm1RaFJu?=
 =?utf-8?B?Y0YreGZRcnZVbmNaL21xWnVVem5YbHJtZmlyTGluaHFQSGJVUVJvYTRWc0lS?=
 =?utf-8?B?MTBBWXgvQ3o4NnErOWxCU3Q4VHdpQkZjbjVHNHVJQm9jc2ZiLzhlMDBodjZa?=
 =?utf-8?B?N0t0YXhhOHZvUktYcyt5Ry96Wkk1MUdKL2NvRTVGd1dTaytmRzM5VkwxZGF2?=
 =?utf-8?B?emxCUE9ESU1Hb0tzUHB4cVlEN3hXeW5IbHBVelVTM3lsYkpEQWRYZ1BZQzRn?=
 =?utf-8?B?dXhWRnc0dDdybkNQbUk3MlNNWmFTOTBsdXVQRlUzTnRWSnFKYTY5UjRiTnFp?=
 =?utf-8?B?R0xNdHcvaUlJZEVNYW1BNkl3YWYyYTdRaXFDdWFtTXl4U1FST0NYVVpUN1Ey?=
 =?utf-8?B?dW5hMXJFZHdCOUN2NldHdnVvaDhIYUlVVjFOajNsdWlTenlDaExhOWtkRHFa?=
 =?utf-8?B?NnNOa1BRR1FBQVdraUxkSklHZVAwMmo1UEpwREI5NVRUM3dqTWtJRXpsWXo1?=
 =?utf-8?B?OTJsRUczaDR2SitKNlg3MDRBUk8wVmgzeENSQ0RTdjNWMkJySVhqc3RsK2Zr?=
 =?utf-8?B?Qm1DdU5qQWpkTzBoekJXRk5oV1JieUJqY0c0ckp3emVmM284VWhieEJHWits?=
 =?utf-8?B?UUV0M1FWbVFHZGh2V3l4SzgvdUhsUkNoNUR0S2QwSTBsQlNHWmg2VFJNdzBU?=
 =?utf-8?B?Z2gwRDZOdnFEMEV3NkFLRjJHcmFIajc4MlpMS2VOV0Z5Z0p4MFZDTTk1OVRL?=
 =?utf-8?B?TlJYN1p3UFFoNUx0WXY0V3FzU01sY3pGTTlkNlhqZ1hrdjQ0RThjUTdsTHpF?=
 =?utf-8?B?NThXWmNXR2w2N2dpZGpQUnRQcFNFNHowTWdPSHFhZzRFMUlsckx1aGY0VUNH?=
 =?utf-8?B?Tm9SbGtRbzBTZzFhZWc4Szh2L2JrRThjUDkyVWhQbXJYVFJCTzdDNE9jeXAx?=
 =?utf-8?B?NUdBcWxiTTcvTGhOQmJvN25GU3RDUzgwKzQzd1Roc0d4dVhESDlqdGRuam1O?=
 =?utf-8?B?eFI3TWd2MmtLREt6WmMwUzRlcXJIak4yVkNvMXIya1h1alBhbitKM3J0SUl6?=
 =?utf-8?B?YUpMSzMyRUc1WldSeTFOUnZoa3Z1MWtuVHl5YVY0bVB3YWRlemlnUzIvSWlT?=
 =?utf-8?B?emlxL2k5T05sUXFuQS9jNytjcThqWmlZNEZIYi9abEtJVjdEK2VsZ0tsa1hD?=
 =?utf-8?B?RnRVeXU0bUJKcXRWOE5vcTV6Wlh4d05sYjhvSDRzTkxXemx6Y216cmJFTHgy?=
 =?utf-8?B?M1JhS3JpMDl3UTdoRDNkWEdJTThId1FJTm1jVzYyck1LZk1pdmlXUFZzWjQ5?=
 =?utf-8?B?RDJjS0o1VHQydE85L1FxZEFpUjJUQjdrQ2RkdVVQVTdKcEYwbkJnZ0kvRUI0?=
 =?utf-8?B?NDJPdW1iKzg5RSsrV092UERXbzRPeUJOZFR3VGR3RHQwT0ZJdFU0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377378a8-8c83-44b6-d0dd-08de6e325766
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:39:22.9339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5CPStCKa4ihyf+Sp7kRII8hQWuI2ChHrf0qVoJy/5HWMhpB8D0kg+tYbCh/yESdO7ZaQz77wCrPNnlsHYaCfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Received-SPF: permerror client-ip=40.107.200.10;
 envelope-from=avihaih@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


On 2/17/2026 4:04 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/17/26 14:05, Avihai Horon wrote:
>>
>> On 2/16/2026 7:40 PM, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 2/16/26 14:25, Avihai Horon wrote:
>>>>
>>>> On 2/16/2026 2:22 PM, Cédric Le Goater wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> Peter, Avihai,
>>>>>
>>>>>>> As for enabling the VFIO migration events by default, I guess we
>>>>>>> all agree it could be done. We simply need a stakeholder to change
>>>>>>> the default behavior.
>>>>>>
>>>>>> Ack.
>>>>>
>>>>>
>>>>> There could be value for the sysmgmt layers to receive a VFIO
>>>>> migration event reporting progress. For example, an event could
>>>>> be sent from vfio_save_iterate() including relevant size metrics
>>>>> to indicate progress (or not).
>>>>>
>>>>> Any opinions ?
>>>>
>>>> Amm, I am not sure an event is the right way to report VFIO stats, 
>>>> as it's not some change that mgmt needs to be notified about promptly.
>>>>
>>>> Mgmt layer can query migration stats when needed using the QMP 
>>>> 'query-migrate' command that returns, among other info, a VfioStats 
>>>> struct with the total amount of VFIO devices data transferred. If 
>>>> needed, this can be extended with more info about remaining data 
>>>> size, etc.
>>>>
>>>> Makes sense?
>>> so you would opt to extend migration_populate_vfio_info() with more
>>> info on the VFIO devices. Fine. mgmt should poll then. My knowledge
>>> on these layers is limited.
>>>
>>> The extra info would be "precopy initial" and "precopy dirty" sizes
>>> I suppose. Per device (more complex) or overall ?
>>
>> I think per device would be more helpful.
>
> Yeah I think too.
>
>> Extending migration_populate_vfio_info() could be a nice add, but
>> I am not sure how is this related to this patch I sent?
>
> I was just extending the discussion, thinking aloud. Sorry for the
> confusion.

Ah, I see.

>
> This patch is in vfio-next. I am waiting for Ankit to respin its
> series and I will send a PR.

Ack.

>
>> Or we're discussing this because you initially thought that this
>> could be a reason to enable vfio events by default?
>
> It could be a reason but it really depends on how the sysmgmt layer
> wants to consume the info.
>
> Users have been requesting more fine-grained VFIO information to
> improve the migration flow. Leveraging VfioStats seems to be the
> safest approach for that today.

I see.
Agree, VfioStats seems like the right place.

Thanks.


