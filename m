Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9DBC19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 14:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tokVv-0005tQ-A2; Sun, 02 Mar 2025 09:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokVt-0005sr-D8
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:41:53 -0500
Received: from mail-bn8nam04on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2408::60a]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokVq-0003VK-Kw
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh5wXm0bYkSkfEEBg9XngeHBvJetcsFcYBvFi6hWJBRTItZqLXL8Ip+YtTzJkgvUjsozsuMHjjUwh/ie2LNVt3+fKe5sc/hKqrKW/Q0U79WJarxUdhVvlZFgnqODoTbyLozA0XjHEHBKYH6iT2n6uhphc8qWpSYXyLiUnapljKs/ddf2RTOTqcRvhltK1+uHb+HE4N8o3ISz+AppgQBV3ySJ+V/4/lg/wui36APhJ1xkaw1wVvAeFcsTe9V4oRDCP0GxrzNVLXQruKNtSxgYiHerh5V7f4bKI2OIz0QY+eb5pbFWiUifotAg5MEXGST2gHVJ2WC3t6BrI2sP5ZMQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQdndLZ81qh6q4RvwQk2PyZsRvdn9FnnzD8uZp4r8JQ=;
 b=a1vnBEMSqMIupAn2w303SyqEUoCdN8xFJqiH/DstT9tCceuWaVU2NvKwddTgjduy20C4Hp34w2C/Dzlfdd1zIDVQgGNkIqK7YEp4gjQx5I4oE2jvqkL8VOJsTXYaflBtryFeOz0jNt0JnwcZVGdmdGe+re722viQhMtMixZBubQ7x/z0LB0BbvoWzqsLCFpTEZcYvUh5D8SjnWtwHUmyjGIfsw2utHwl5xXHabHXJqL50h7L2/10XiA1PKgCHQMWLVJ8WFKMDBE2maiz7cF7lck5Va1PUqOGw7FOVu6E6rXBS+FvDq5RWlG3k/ccsLN7LtC5KNGarBq+wPKhooD2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQdndLZ81qh6q4RvwQk2PyZsRvdn9FnnzD8uZp4r8JQ=;
 b=f+3BHpRdPn01aZ4yGbwuVgd6pB/F+luj4Z4aTNZh6DVaSvYYoitegy2O+H3fnUjfhQZq6/5FhWIQrexYaYFhvNXdJLZpKQWXbJh3BpRUCBgKvgEVDiavPSZ8sDAyzW16dmsgIOjv7lcWhaaX86rkZ3a4xaFWvZcKgehMwQiBNhohCCQKrJZSsnjdDtrntg18Xv4Wa0jjDM7d/brTc7hM6FrWYMyJp+oNhlgEQF3IQokQBOotrLu3AmYMN5i/mB/21l0P+XhbpEppRpY5KF1bHztu6JH5dbFfKUybS1ov/90KBu/xy7gSzPZK/y/h2NaYmcjj2VQlAJwHKkC5oefyYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Sun, 2 Mar
 2025 14:41:45 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:41:44 +0000
Message-ID: <bdf89ec6-95e0-4256-9944-5a94b3c88d22@nvidia.com>
Date: Sun, 2 Mar 2025 16:41:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <608c869621ffe1688e08af98a373c33376487d53.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <608c869621ffe1688e08af98a373c33376487d53.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 1296ec89-197b-46c8-4810-08dd59985a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjdCSXJLcnA2WThoeWhybVVtaDI4eDJSbTBTRkdrMjg5MlBWRE9ma1BISUt1?=
 =?utf-8?B?SXR0OHd0SzV2aURkNGxWT3VFVFFNWDczcWM5QjNxL3U3NVNLS1BaR2x3ZXlP?=
 =?utf-8?B?dHpxQ2ZHMzEyTWV1N0pVUDkxQTJER2JHWHJkZGplN2pMYkhOSmVkdHBzNmpS?=
 =?utf-8?B?WnA4OEEvYXNTOWptdmFLN2QvVmR4U2U2NlFJWDVRMzJ4WFl3eDdRSHozRXE1?=
 =?utf-8?B?cFcrU2JUUkEzZlREUVdqYU9idERveFIrL1RyVVpKQ2RDd210UGN2SGplTm8v?=
 =?utf-8?B?WXozbjhGNG5DVXRKd2x0eVVYOUZGODJVL0ZQSGZ6SnNCV3BmZklTWnJIV2ZP?=
 =?utf-8?B?Q09oM1BRVVF3V0Q2UVE0QU1nbTJRTmF2MFFHcGR2dHhTUG1KM2czZkpHcU9J?=
 =?utf-8?B?TW1tVzl6STI0ZmpvZzRsU2hUODZ6U3g4RTBLR1ZUVjNzOXBPWFhwaUt2R2xz?=
 =?utf-8?B?Rnd5czY2a3NZamdCMzN6U2lTT1l3Ujdjc1A4TnhMUENjYk54MUlWby9oSUtE?=
 =?utf-8?B?clQzQVJHZURjV1NaZCtnMXpqK0paMEg2WVcvUzZ6bFJWWDFRRFJJNUtLM0pP?=
 =?utf-8?B?MmhXV3hicFB4MFRUWkJacStUcHpVc3g2d3c3WTRPL1c1R2ZERnJtMVVMTERq?=
 =?utf-8?B?S0d1dVlXak8wWTduNUU1NElab3RYMm1HdFZPVkUvVDZwZFVPdUhjbGdTWHZs?=
 =?utf-8?B?Z3hyY0VGbWdMWVRXOUEwWkYzejFxUEhra1pjRFE2V3VJajZJZ1hOSmsrdnQ0?=
 =?utf-8?B?MXllM2xPUDU0MG82d2J2bHhIN1ZpQzJ2bkQzRTFnQmtVaXNPa29zbVhpS0I1?=
 =?utf-8?B?MmE3bWFHUTVxaFdSMDFyUEovRE5SQ1BWZ3c3dGdmZEZaYmNBYk5VT04xVnF3?=
 =?utf-8?B?VTllanFGVUVqUFJRTWxva1F4QXJQSXg2OXMxV2pvc3hRRXYwVmxCdkx3Y01n?=
 =?utf-8?B?K3BaWGlqeHJtK0dkTUtsWXZhRHlQN0N2dk1iMUhUR2VjVlpYenFIMFA3N0I5?=
 =?utf-8?B?L1JoYytpZXZ0V1pZQk1ucDhLaGEwV3NUYlZsZVlmVHRTV0R2eCs1eXlJc1Vs?=
 =?utf-8?B?c2NLM0Zmc2kvOHRzM0w2NjNEenM2OUhzT01yVHRTRENram02eFZtMWJUTTdV?=
 =?utf-8?B?THJ2ZFhYR2VSN0ZOMUlHbVVLU0VYc2ZrVzBCVkFNWS9IL1p0MkRPMkxHcUow?=
 =?utf-8?B?NHpYclpFQzRHbFE5Rmk4NWdzdHFsd2YyUzIyZElZSURTZkx2ZDNMRytRNDJq?=
 =?utf-8?B?enNoWDhrYWp1NkZrYkgvdTNmWFhkdkxFWEtwcUhmbEpIOWpJVndkVU0wMVlK?=
 =?utf-8?B?ZWkzUVVYd0FHVjM2eHZzTmZlUVhXbndhSEloNVcrL3hwLzU1cEZtcG5VSXda?=
 =?utf-8?B?WVRYK0RuVFpZcmxwdjNsbWlVdDl2ZUhjbVM3aHM2RFh3cUZsWXBxTmw2WDds?=
 =?utf-8?B?d2IyUUZlejQraU0yWHRscUFQSzl2S2xkZk1tNG0rTFNDaXRYRGM1bmF2MDZz?=
 =?utf-8?B?Z0Y2MDZ0ZmRZUFU1MEdhdC9WUGVoZ3JneU9QZ0VWeitvOG1tditjSFBCbGF5?=
 =?utf-8?B?VThDYXNaRUJCY1BoY0t4SmVaa0ZDQUdDc1grNlllQ0RpSnBQRWN2T0lYSFJI?=
 =?utf-8?B?UnJnWE1rdzFXVFkvVE5qMXVOYjRCN1VxTmhTUnpFTm1JcWFsZGFoZ3R5VjYw?=
 =?utf-8?B?WWVOT2ZxRFFwSVA0RHZTMkJvRFNIQW9EV1EzZ3JJODVhZVJrZkZaYWFoNloz?=
 =?utf-8?B?dWI2RklRYjk3V0FPRlpKLzNLYk5CNnV1TEFTSE0wS1NWdWl5Z0xxcS9DOVhS?=
 =?utf-8?B?cWFEd2hweVdKQWd6U0FkYTBFM3ExeVV0WGRJSzhOUWp3NkZsOU1saDdaR3dp?=
 =?utf-8?Q?O5o78Z2/4H0xY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bko4RUFrVlY4alNUU1o4UmR3WWF5YllZZWxoeittVFJ2bk5ESEtndWJxTW1J?=
 =?utf-8?B?RUhTdE5oYi9rVEhha3IxL0I5amlldUF3MWJQbTA5WFFDdnh4eENYMEx3MGhh?=
 =?utf-8?B?V2ZTakhrQkZRZGNGSlR2cFpLaWMrQmlwUEhzUHI4cExWemdsKzZOZjJhL3Rh?=
 =?utf-8?B?SkZ2ZGh6Q1k0ZHo2d2JJQ0NKK08rNTc0cm52ZjBqMmhhLzZ6UDh1bXMwbzkz?=
 =?utf-8?B?RlVNWjBWcS9aa3RoOHBiWTB1M3dEMGRCVm5GZG1PTFhuZDF5NFRQY2I5WHo5?=
 =?utf-8?B?aXV5ZW1sdW93dTJSMk5hc3RqWkdjZkRJNWxRZ2RUN29nQzkwOGtvL0ExYWs5?=
 =?utf-8?B?Q0hxSTV3MnF4Vng2Z0NYaVBRd2lrNkpaYVRLOW9ON0tiY21qMWgrbGpaQnAw?=
 =?utf-8?B?ZWU2cXp5b1JNZnQ2amQrakVLSmxVL0Y0R3c5VUNIcHIxQ0pWb1o4M2lUUk1E?=
 =?utf-8?B?OUdMcVp6c3hFQjhTbmpwNThabFUrRHJDZit4OHVPWExobkJucmN6M3Rla01T?=
 =?utf-8?B?VHQ4bWdRV2N1ZGc0K1dGbllGMFFkekNBZlJ2aUc4N1VVOHpobDF1VHlBdWwv?=
 =?utf-8?B?UU5zMjBjVWxZeEQ3aTFyNU9JNkxDQ1dQUFBxYVF1NlJPVHh1UXRRU2FrSEMz?=
 =?utf-8?B?ZjNQUGpQOFc2OHM0eEg0TXczSTRYQUVDNnF3ZXFBZDhvOXB3TmdQWlJCWUox?=
 =?utf-8?B?Um9DU04zQTBRdi9JU3pUd2I5SDIxbGdNTXA1SHB6V0pHOXlWK2hRckE5VTlV?=
 =?utf-8?B?a2FQODExK2lsVmQ0RlFDc0J5enFUeFhFL0FSZEU2VWRvZU9LWHlwbmdFc2Mx?=
 =?utf-8?B?UEpBekRoTFllN0pHZVVQZlI5V3VqUXVRWllUZzBnalpNNzNzcHNQbWE3M29P?=
 =?utf-8?B?VktyRkk0SlBoYm9URGNicnYrN2dobXRlQlVGbWNBalAzT0dITDVhUDlmVURX?=
 =?utf-8?B?bzRZZ1JBMVRJS1REa2NNZkdBdGlDUUN3d2xLNWd6NmZkbzlVbzVtbUdjamRy?=
 =?utf-8?B?RGM0Y3B0NmRwSG5GZTI3cEREcitRRU45Y3QxSythdTNOQ3dENzNoVmdxUzhE?=
 =?utf-8?B?S1RpUDUyUVZqdDNITyt5b1NKUGhYaERZK3lxSTR1NXh5aTFDNm1Oam0zSzR0?=
 =?utf-8?B?elhkM1B0T1g1WlNuWmtDRFB4c0NoRnFiS3k1MzRnZXRaNldVdExvR3RsenBC?=
 =?utf-8?B?Yzl4N2V6YXdnL1FjZ3FLNHRZQ3ZqbTltZ2tHd0Via1R1djl2V2ZRNkQzQU9z?=
 =?utf-8?B?RXhUQjhLVGxTRmdVb3pOTHEwZ0hHK3VIY0MzSU5SSnAwSnY2eTRXa3BSbjh6?=
 =?utf-8?B?N3N5T0p1THhjUDF3Ym9Ud3ppZEtPSE5qbGs5MG5rM1FiZEQ3VlZDQlo5eWhM?=
 =?utf-8?B?TWNQbkxQQkd4b0tBSklvQnVVeFpkMFoxbm5qSTB0WENHNFNjaXhUTE9odURn?=
 =?utf-8?B?WWdMWm5IaVdkWFVUbnkxeHI1MHV2eDBjVUZWOVQxbUo3aGlQSWdGNXIxQzd3?=
 =?utf-8?B?R3N6akczZ1dsS0FiV094MmFXbkxkbGhURUJqSnRJY0ZtRS9WN3FsdFpvaDF3?=
 =?utf-8?B?azlNY0FsenI2N2tmSFFTdXQwdG9QTEI1cnEyUWtwMkhBSGlIZDRSNDJIUnlZ?=
 =?utf-8?B?U0ZoQ2ROYU1GeVlObC9raTFrNHBaYXN5czVWZXY5c2hKOVVGQjRYdkZuNFBs?=
 =?utf-8?B?SjNkTXdFWXE1bW5NSWNlNFA1eG8vdi9VOGpvKy8zSVpWSFpKWWVsR0RNUk9Q?=
 =?utf-8?B?VkxLY05VWkpzVTVabGV0SEZTVjhCYVlnRWM4K04zdndrR0pEUmhUL0FzMmM4?=
 =?utf-8?B?Z2xwSXlWVXpTSVBKdnJlOFQ1U1ZMUzduSUZxa3RLTzQ5R0xWNkd6VXVrTTkz?=
 =?utf-8?B?ZGJpUHkzbXhRYXVrS3pKUWNOc1JDR2ZNTWtnM1BuQVJpR2ZRd3VmWmNOYXhL?=
 =?utf-8?B?endISHpXNUYvcWgxd0VNcEdWdVNGemtSNm5NaW9KZ2ViajFoWXpJWTFGTmUr?=
 =?utf-8?B?blJ0S0YwZG9VbWtaMndIQnlveVJvWDA2NjRjQXdMVTBSekVxeERoOHp0QjFO?=
 =?utf-8?B?N3NJZC9lc0ZJS0I1czRwRkRlTUkxMXFSeFhkUFh0SGcxWHlaVmxvb3dOZG1X?=
 =?utf-8?Q?ATvGyMeNpRkl9AXnmzdjzdrfz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1296ec89-197b-46c8-4810-08dd59985a96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:41:44.8395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DAnVWu5X5EiZiihOK+HxLDLjDypFP7DoXBdj6VNpgYmHG2u7weJKa4kM5vBG9UPcL8jgbDnszC6ay2hXDw2dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959
Received-SPF: softfail client-ip=2a01:111:f403:2408::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Implement the multifd device state transfer via additional per-device
> thread inside save_live_complete_precopy_thread handler.
>
> Switch between doing the data transfer in the new handler and doing it
> in the old save_state handler depending on the
> x-migration-multifd-transfer device property value.

x-migration-multifd-transfer is not yet introduced. Maybe rephrase to:

... depending if VFIO multifd transfer is enabled or not.

>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 139 ++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h   |   5 ++
>   hw/vfio/migration.c           |  26 +++++--
>   hw/vfio/trace-events          |   2 +
>   include/hw/vfio/vfio-common.h |   8 ++
>   5 files changed, 174 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 7200f6f1c2a2..0cfa9d31732a 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -476,6 +476,145 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp)
>       return true;
>   }
>
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    assert(vfio_multifd_transfer_enabled(vbasedev));
> +
> +    /*
> +     * Emit dummy NOP data on the main migration channel since the actual
> +     * device state transfer is done via multifd channels.
> +     */
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +}
> +
> +static bool
> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
> +                                               char *idstr,
> +                                               uint32_t instance_id,
> +                                               uint32_t idx,
> +                                               Error **errp)
> +{
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    g_autoptr(QEMUFile) f = NULL;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    size_t packet_len;
> +
> +    bioc = qio_channel_buffer_new(0);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
> +
> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
> +
> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
> +        return false;
> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        error_setg(errp, "save config state flush failed: %d", ret);

Let's add vbasedev->name to the error message so we know which device 
caused the error.

> +        return false;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        error_setg(errp, "multifd config data queuing failed");

Ditto.

> +        return false;
> +    }
> +
> +    vfio_add_bytes_transferred(packet_len);
> +
> +    return true;
> +}
> +
> +/*
> + * This thread is spawned by the migration core directly via
> + * .save_live_complete_precopy_thread SaveVMHandler.
> + *
> + * It exits after either:
> + * * completing saving the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by
> + *   multifd_device_state_save_thread_should_exit() returning true.
> + */
> +bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                       Error **errp)
> +{
> +    VFIODevice *vbasedev = d->handler_opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    bool ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> +        return true;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
> +                                                  d->idstr, d->instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    if (vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                 VFIO_DEVICE_STATE_STOP, errp)) {
> +        ret = false;
> +        goto ret_finish;
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (multifd_device_state_save_thread_should_exit()) {
> +            error_setg(errp, "operation cancelled");

Same comment as in patch #27:

IIUC, if multifd_device_state_save_thread_should_exit() returns true, it 
means that some other code part already failed and set migration error, no?
If so, shouldn't we return true here? After all, 
vfio_save_complete_precopy_thread didn't really fail, it just got signal 
to terminate itself

> +            ret = false;
> +            goto ret_finish;
> +        }
> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            error_setg(errp, "reading state buffer %" PRIu32 " failed: %d",
> +                       idx, errno);

Let's add vbasedev->name to the error message so we know which device 
caused the error.

> +            ret = false;
> +            goto ret_finish;
> +        } else if (data_size == 0) {
> +            break;
> +        }
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(d->idstr, d->instance_id,
> +                                        (char *)packet, packet_size)) {
> +            error_setg(errp, "multifd data queuing failed");

Ditto.

Thanks.

> +            ret = false;
> +            goto ret_finish;
> +        }
> +
> +        vfio_add_bytes_transferred(packet_size);
> +    }
> +
> +    ret = vfio_save_complete_precopy_thread_config_state(vbasedev,
> +                                                         d->idstr,
> +                                                         d->instance_id,
> +                                                         idx, errp);
> +
> +ret_finish:
> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index 09cbb437d9d1..79780d7b5392 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -25,6 +25,11 @@ bool vfio_multifd_transfer_setup(VFIODevice *vbasedev, Error **errp);
>   bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>                               Error **errp);
>
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
> +
> +bool vfio_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                       Error **errp);
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev);
>
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b962309f7c27..69dcf2dac2fa 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -120,10 +120,10 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>       vfio_migration_send_event(vbasedev);
>   }
>
> -static int vfio_migration_set_state(VFIODevice *vbasedev,
> -                                    enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state,
> -                                    Error **errp)
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -238,8 +238,7 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> -                                         Error **errp)
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
>       int ret;
> @@ -453,6 +452,10 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>       int ret;
>
> +    if (!vfio_multifd_transfer_setup(vbasedev, errp)) {
> +        return -EINVAL;
> +    }
> +
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>
>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
> @@ -631,6 +634,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return 0;
> +    }
> +
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -662,6 +670,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>       Error *local_err = NULL;
>       int ret;
>
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -819,6 +832,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_complete_precopy_thread = vfio_save_complete_precopy_thread,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 418b378ebd29..039979bdd98f 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -168,6 +168,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_complete_precopy_start(const char *name) " (%s)"
> +vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
> +vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ce2bdea8a2c2..ba851917f9fc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,14 @@ void vfio_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>
> +#ifdef CONFIG_LINUX
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp);
> +#endif
> +
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
>   int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>
>   #ifdef CONFIG_LINUX

