Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648B8C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tplD8-0001lK-1E; Wed, 05 Mar 2025 04:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tplD6-0001l7-80
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:38:40 -0500
Received: from mail-bn1nam02on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2407::611]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tplD3-0003hk-Dk
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 04:38:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVpIl3uUdqyPF5bVBlmXwoSHjgB2hfSg1wbuMZ0EBT7RO2YWIDdI8X11Xk727h27meHv+08es+RYy15bsSywnKNX9NfKYV68ztzdw4ZZqLSeSLIWRgfqoFKegYeFXxCLXTW14wIm7DYNB6e7RNhuypuMPsRuI/Gk3mdRBhAsl+nk8cOjnq/yjOzXXSEV724urjd9AhXfuXIBIm6z//SZXz7L5/SirUCCj4PFWqlVOl+/iTvyhk1NgGPYHUFAH593wCGEn+KWyMVr4QCqZmnqz8z/bs2bX3b+inSDDz5dWzxqc+oZvdmsj8gVYps2XY44jxnFq/VcVyx8wUbtJiF1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heROzsls7caSfK+BqvcywVE48mtjV0gi1MSs3GQv7bg=;
 b=ktC3mokI7mbOF+1ezHcUH0Q+adHGWXNHFDRVrMCyzzCojdZAL2SmIAY2zWiHhSM39+WIGJzXFvlvwGnCpBq8XksissuznJqxX8N/0BLolU4xTs3gUqHOGWFRiuVCifojEhjcanLvyRI/64Hl7Qw0BvFBXZZwvvawGrEWPMAfRvGEzWleYLLnpqH7F1IgXgvJFBoqLnzh2iknPwKYHPlENF0PUInw2YBFx562AeoyVqRk3sbyPIcxuJGykC6GJmbBfPcgbWz+tQIZcLHVOi69thGrrLVzmGeYTqyn0xrnuCAbSD6M2BnAL05eYiTo0Q7f1ddnwqKKJ+DMeYbrqtIn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heROzsls7caSfK+BqvcywVE48mtjV0gi1MSs3GQv7bg=;
 b=XFT+dtrJNcyoxGvjSB9IwiQghYg6NviufHi49UchHh6zE6Tu/N4jAdzAhj0hOIo7gFzyNQvtOWKEYgnmD8cy1SO9Zbf77xP7nGKxAuQbrO/HCzzTAxQIUvrAenoVdR8K69IJYeX6F+XdjDDNQ2+Wq2ALjgYiVgWPDvfnf0vOqIIcQw8Xcdyga6hr5XeSNiU/B5ZFHKatDm61rOJEVFo8kR/93hJnXZ0upwUhhipa7qIEHL0z3A6uX2Q9Oi6RyI5RRntF5UjQE7/AWbh5P+OAZnZ+z5PItiLdl/bnedUArpqwet6T2fkVWIXZZvPqIwvlIMYVht4dilC5IgJYdD2EMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 09:38:32 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%6]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 09:38:32 +0000
Message-ID: <124df56c-a293-4bbe-ad73-a4bb46a43f6a@nvidia.com>
Date: Wed, 5 Mar 2025 11:38:23 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00/36=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
 <1d46d84d-aafd-4a6d-b982-ba930e1a532d@nvidia.com>
 <7039fe71-3b41-4aaa-968e-d3e09998e72d@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <7039fe71-3b41-4aaa-968e-d3e09998e72d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0469.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::6) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f035f94-2f6e-427d-3aae-08dd5bc97e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXNucENENUFmaTNSbTFhTW9pQmZVNHV0VEZuNHh4ZitKSmxLTDduUHdTQy81?=
 =?utf-8?B?NkZMVGJxVmkwK2ZMcDBoTXJHaWlLazhRUGkxdU1NL0JxdEc3VVRZc0Z0N0tG?=
 =?utf-8?B?RlN5V2I4YkZZWnJiWm0zUzU1V3MvMVRVcStZQS9iZlNtTnBYMktHYloyWHhK?=
 =?utf-8?B?RTV4Y0tPSU9jNUp0UjlTUHZxYjV2RUVicW5VUmVja2lCRzVTM0NSZVhWaU16?=
 =?utf-8?B?YUh1N0dwTVNqZUtzd1l3Und2TFpxb0w5cFJoUzFpUGRMUmFCRWcwSExBK2Rk?=
 =?utf-8?B?QUhZSk12em1wWEQyMGVvb25Yc3V3VGh2SmJpSXRnLzJ4OE1ZRFdZU245dEM0?=
 =?utf-8?B?UUhCUFg1YU0veVlUai8vbFhPRHFteHliQ0dOcmNBeExjbkIvaHpqUkRDTHla?=
 =?utf-8?B?S0gwaWRTc2JuMHk0TTRKejBGMGJ6aC9jNDFWa2N2cTNremFrL1FIQ1NlVlVr?=
 =?utf-8?B?VWNJYUc1S0tMTU8yMG5JODZyVU1pNElqM0pTaEcvTWNFb0lZUjZ6V1RJRG1J?=
 =?utf-8?B?SnhUdzZ0alpQZm1mb24rYXNmTHRsUWlxMlVocWY2NDBWN2hUc29mdWFKSHA2?=
 =?utf-8?B?aWRqNzlyYjcvelp4N3ZLNG9MUkh4cHFZQzlZb3cxUlpHZ3dmYllnK01IY1Er?=
 =?utf-8?B?VmZaOHB5V3hnUUhtVktsNHYwUlFveDE5R291VzhQT1piR2svVWZRZ1lubUFp?=
 =?utf-8?B?UUVJY1I2Nk8rTWJJdG13UlZzeGN3UmJhaEV4RE52Wk9HeUoybXNGRG9xbUpN?=
 =?utf-8?B?eCtZZUNBamc0U3hFcUhtRFRiY1BMekM2U0tud3RrUTM4Y25aWTJBZ01zNVhO?=
 =?utf-8?B?cldqTWtSMU53bTgzUEdwc0R0dDJ3KzdneWU5ZWxuRkREaTFIZ0ZNZXYwUXY3?=
 =?utf-8?B?N3l0Q3RMY3ZxakxveURaOWE5MUlqSis2SjZwMUFDS2ltcDkyUFZwSi8vcHpZ?=
 =?utf-8?B?RlZYUjVGdzhyRStLaEhBYURLL0tWZDVYaEZheDJuRE95VTlWVjZySDFFVDU1?=
 =?utf-8?B?Um10bnhsc1RiTXVadzA5U0JzcVpzdkJEeWMzaTkrSG16aXZ4RjhUKzdVZ1ZX?=
 =?utf-8?B?Z0ltOVBZTzVDN24wVkF4aG93dnF5U0FncHdmd21oRWdsVDM4RGV3M29YUEV1?=
 =?utf-8?B?cWVqN0RMeExwTi8wMHJBVlUwN1pMQVpvWHVGYkhDa3I3ZDJMbHdnL05uR1NH?=
 =?utf-8?B?U3lyUW41YncvTTM5SzJTVzFSR0NSMkJ0ZDBod0hEMDFueFR1K1E0ZisrWURR?=
 =?utf-8?B?M0cwUGliRzl1UFFWeElQU1M5bW9DUzR3OXJ1N1BlNDJkYXlDMFVuODR6S2Vx?=
 =?utf-8?B?WG1ZT0I4YjlQTVFNR0E5SlBKeEdUejJxa0ViaTlicG5XWUs3Mmw2WUs3bVJX?=
 =?utf-8?B?YjZTYWpaQkxxVFNwV3V4RGl5eDM0N09iUXZCTkVxV2ZQaUN4S2hucXB2bEE0?=
 =?utf-8?B?Q1Q5eE9TS3hjVDlobDZwZ3B1RTFqU3ZOWC8wSjFLVm1xNG1pTE9INVhycGN1?=
 =?utf-8?B?NEZidWV0Z2VQdWZ4UkMyV3FhN21JYmFtRXNOV0N4cGFYanNCTGVoc2pRV1hj?=
 =?utf-8?B?aTZBdHRKWUQxWGgvUWk5ZytLcTJJZ2hwRk0xQ2UydnFqV2JMOWcyUjNzNjFC?=
 =?utf-8?B?a01BZWRMeXRvclEzekhHU2JwcU9SdDAxaXdVRHV2N3lOY0Vzb1lHVmVOTEdM?=
 =?utf-8?B?Y21xQy9nUy9xeE0vUm54aDdmeWFiVlJXOEE2RjZ6WGFRbm0wU3VvRGhHbjRs?=
 =?utf-8?B?T2l0b01nKzBWSjBKUFhmamROVHFzT1BPNjdPMG80Wlh5Rit6YWlNa3NpYUJu?=
 =?utf-8?B?UGM3bWhHNDdCMllkem12YWFQeTRFU0JsZVUwOXVnalZUeEJzcnJYQWpVVk90?=
 =?utf-8?Q?JXmLXtZ5zY+BH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZobkpJYU92Q2h3M0NvdUttWFBES1J2MzZEQ2dVajFWYTVGMGNrNis2MnZO?=
 =?utf-8?B?QjY2RmR4ZTdGRHk4SUtQV0xEVE5pckhvS0hkZ0x2cEIydWJ1b3ozTmcwNVJS?=
 =?utf-8?B?Q21CRlpSSkZjaHgwMHN4RnQwTWlWTjVHU3Bqd2d5VFVwaVhRL1FITFlxOUxD?=
 =?utf-8?B?M3dSanRycGdtaW11WUZMR1BUZ0NicHpMaDZVT24xVU5naStvZlVFd0lQL1By?=
 =?utf-8?B?OXZOY0l2Y3RINU9MdDNBbzhqaHNWZTBoNjlod0lST3luK25xRFBhM2N3OVBB?=
 =?utf-8?B?MDVNZU51WHhUd1IxaWhJc09WQUZlT25TK0pxNU1DSUxxdnFsSnZWSUFicElD?=
 =?utf-8?B?WCtrYXUwNU1MQjY2alNhQmx5K3lKSmRZQkplcHM4azZhZS96L1FjeXV1N3pR?=
 =?utf-8?B?M1ZUS0p4YXQ4THVtRk1Td3F5Z3RmV1ZDUWZlZjRzdk9iNS9RTTRhZ2RoWHFZ?=
 =?utf-8?B?T1RuWUlySmlWQkhBT3d4N1dtbnVyM2JuNUNSTnAraWdXR3RvVWNxVXhxbk1y?=
 =?utf-8?B?aHh2VUcybVhmeWxrYU4vUm1LbkFNcElFTzVVWmN6bnorNmNaRmVEK0t4cUNJ?=
 =?utf-8?B?UGs0ZGFKaFBJSE1Id29HR0xZRnNLR1pqaXNqZW1IbDBsL0txOWR0RUVlZys5?=
 =?utf-8?B?eHdBd3Rab3FoNWdCR205MEtESy8yU09rTUxib1FFV0xlekQzTVdQamtUYTRi?=
 =?utf-8?B?TXhyajhoK09WRlQzcWdnQk8zKzNKaWFIUDJyWHFlTzkwNHM0TkxCakgzM01C?=
 =?utf-8?B?YlJ4MVJwd2cxdWtTU3FmN2pZdnRVOW0rL1ArL1N2NWRGakRuSUNQRjB0SGNF?=
 =?utf-8?B?aG1TL0R2NUN6U204eEc4TE56dk5rUGRENFM4cVZwL1dTeTUyeUZqQTkzZDJv?=
 =?utf-8?B?K2Vqc29QOXFOWnFqY3lId0xGTi9tWURGbDlONUdYK1FFZDJyK3ZraGhHb3ls?=
 =?utf-8?B?U2FxNkJPWXl6NTQzaG1ldWNJRzJZbUZZT0k4MlVCU0E1aTF6TURBMjFwMnow?=
 =?utf-8?B?L1dmTXRNUGFvSFJGN3l0b2l5ZXNMMWIraGR3SE9vNjJLZ0pESmJCbkExZDVo?=
 =?utf-8?B?VVZPUm41M1ZlcGIxbTFROTdKemxIWWZCYmVFRktGZHg1NkRFWVFURTk4cGpu?=
 =?utf-8?B?cGl3REhVd01ZT0ZGWGhIZS84QmU5U2d3bU5scmtOTHNPY0lpZEo4WU1TY2M5?=
 =?utf-8?B?THBaenAvRFRHd245VEVUTFhKQWxMYURZdzVLTFNnY1F1OGlOME5iUWNOZWho?=
 =?utf-8?B?MWYyTDlwQnVoUTErVXRuWGVGV2NaUkF6MlRaQlptN1Z0OGhCc2dXSzl2N3RF?=
 =?utf-8?B?S3pQNHNUOWpOZ0N6M2hvcWV0cThRU3V0S055MEZ3ZGlIUHBhUFpHd2tzeVZO?=
 =?utf-8?B?MnNZTEFVY2p3RDJmeGJZU3BMSFFpbjd2a09FOTJoVElHYzZTQ283RVJGclJT?=
 =?utf-8?B?UURYaVg4MlBBekx4RkNPTFNpUDBWV3lLVHBwd1I2cUZLaW93RjJ6R2QySjBS?=
 =?utf-8?B?NGRuMWxqZEpnU09STkllbTBxaFcwV0c2QU1HR3pHRnpFM1RHdkhlOFhab0E2?=
 =?utf-8?B?WUpsTWY1aEtxR3Q2Y3dQNDJxZk9idEJLK3Vrc1VLNkdjUU9BS3hJdFhkeTF1?=
 =?utf-8?B?eVB6TTEvVHIzaUVJbEp1YXJsR2grdFB3SExOQlFRbFM5cGFzUlR0MzF1bHgy?=
 =?utf-8?B?Q3VTNEtOemdQakhzeVBndThsMEpvMTRma1ZhakpIOW93WUhOWks4RkhlMHIr?=
 =?utf-8?B?RW01NVp5d05OR0FwdmpvVWhXd2VWZnN6TnhVRVdEYUtYR2h5THBQY20wSUNr?=
 =?utf-8?B?WlFYY044QnllMWFqMDlMOGMxVHYycXp1Ukc4TzlZRTRsVHBtbDFBN2swMTBx?=
 =?utf-8?B?aHQ2aERCUVJMSHR4T1pWa0g1dXV2SnVPL0tJNk52Q1BRRzJ5VTc3b2x2ZDZp?=
 =?utf-8?B?QkVldG1rK1BuN3p6Rkw5dDBLeHlEdGNZUDNWOE5SMFJEeHBlRmw0Zm5jMW8r?=
 =?utf-8?B?d1JzUHAxSWRBTXNJcGtwSTk5MkJWWVVOTVNOcnV6SEFhM0ZUdUFWcGQ1NXBG?=
 =?utf-8?B?S0lYNjc0T2VNRXloZUh2K1IwT2V2TG84SExBTFRMRDI0ck9TZXVoQWFlSnQv?=
 =?utf-8?Q?iceP3WQ5CGXmN+YlXrUcwcMUH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f035f94-2f6e-427d-3aae-08dd5bc97e10
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 09:38:32.0618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4eLhZLrUmmhLwr9fkiZNG8Vcne064ewrbXgi6q9UUyT8NM+OI+ujZU9BhMVi9n8AwTHrhQVweJofzoydZtwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
Received-SPF: softfail client-ip=2a01:111:f403:2407::611;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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


On 05/03/2025 11:35, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/5/25 10:33, Avihai Horon wrote:
>>
>> On 05/03/2025 11:29, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello,
>>>
>>> On 3/4/25 23:03, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> This is an updated v6 patch series of the v5 series located here:
>>>> https://lore.kernel.org/qemu-devel/cover.1739994627.git.maciej.szmigiero@oracle.com/ 
>>>>
>>>>
>>>> What this patch set is about?
>>>> Current live migration device state transfer is done via the main 
>>>> (single)
>>>> migration channel, which reduces performance and severally impacts the
>>>> migration downtime for VMs having large device state that needs to be
>>>> transferred during the switchover phase.
>>>>
>>>> Example devices that have such large switchover phase device state 
>>>> are some
>>>> types of VFIO SmartNICs and GPUs.
>>>>
>>>> This patch set allows parallelizing this transfer by using multifd 
>>>> channels
>>>> for it.
>>>> It also introduces new load and save threads per VFIO device for 
>>>> decoupling
>>>> these operations from the main migration thread.
>>>> These threads run on newly introduced generic (non-AIO) thread pools,
>>>> instantiated by the core migration core.
>>>
>>> I think we are ready to apply 1-33. Avihai, please take a look !
>>
>> Sure, will try to do it by EOW.
>
> Thanks,
>
>> When were you planning to apply?
>
> before EOW :)

Hehe, OK will go over it today/tomorrow.

Thanks.


