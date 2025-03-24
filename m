Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852EBC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 16:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twkt2-0006s6-QW; Mon, 24 Mar 2025 12:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1twkt1-0006rl-3P
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:42:51 -0400
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1twksy-0000hB-H8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 12:42:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwUMfEpnUrmXL+PokOI0Y1CwDtuNweXYAQAvCZRWy4phrRSmOtT2WVR2V05qvhe9UVwJtq5gjNf0BbY++ovrD9WCtw7+pC856HnnK3xCnyIdflYo90IHFPPaO5RliKXAjyHG+vUzPYLoTXNlNI9yMtRVBJ2pCv4Fs/V6M2FV33pSR3TdY3kSRhLi3aiyzEwgUaqPOWTT0cH2x156hpH8yiYBWGCNtN0elTuiOsyJIS36odS7290qToteGhBSc7TLAOdPz1LI3TsOvdjKXYtlpNmE2bG2Ii/TaHkn/qndVrQl/9RHG2iwGrHRjc+OKSihi5QWRCoq8Oj3tWOcDA/c3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YPOGngfbZbSUojr1y/GYDK39790yp/ZWS7YSd5BaCA=;
 b=OkqksWiNiW58cROvLuHqCxPX9HYB1XTlEtlQqwR5g2D24hoH04EeBnqJiqSnb6LZkYJx7Ps8s7PROl3nPxqb5R78M2GZt3iMpNGSZV2hu7GAPnnipsotVcWanKO8Hy4Z3nZEwCLwm8MvAoK4/qVUIMZqhZIf4B3azKICy6HZDclRFM3TKER7hsF03Exsvdf7+higyW4iL8IJuG/gdIU3nUAIqWAlobe/mHgpsUuoYj30PA3sl0XqIpING2RxinqUvgU3kMSQLAmvP86n1njFmHFozU2+QqH5tmIZGICqtI0PcR2fsT4KpOMkhUcoSEqBCWTGyYYgLs238TkpXmfUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YPOGngfbZbSUojr1y/GYDK39790yp/ZWS7YSd5BaCA=;
 b=VGmpDfdhMmvKx52QwLXbB81jdoBgWXNhuu8meOJm2APYc4BALRwIB4/muEImy1En3KY1VEWevFztCHX1eARy9jKD4NQQ8n0o0qc1Z4DnRTCF5f4C+3BaL2TxeJ8CWpSeYDfMqoGBM2nDv+l+cJLXuJPfSCX77M4IfTN0iofMh3pvZhoKgOPhNLe3cyyWuTub2Dl5ywF1LKfDeYoIbwn4mrFndN25HfjzYCIvZhURwWugW18DsahY2Ts3it8asCS6lYIOswPmvKKlCiR5MRpKVCTUNLe9Kvet7v5zJz0ao5Go3RStGznj3f6Gec4OkTxfy6OEkYKYfA9TlkunhVIKbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:42:42 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:42:41 +0000
Message-ID: <ebc4cf50-ee81-44ff-b153-819329e24906@nvidia.com>
Date: Mon, 24 Mar 2025 18:42:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Open code vfio_migration_set_error()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Prasad Pandit <pjp@fedoraproject.org>
References: <20250324123315.637827-1-clg@redhat.com>
 <cb21eec3-0489-4413-971b-40954e64f72e@nvidia.com>
 <1a0e20d3-98f8-499c-8b5d-198fadbafb74@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <1a0e20d3-98f8-499c-8b5d-198fadbafb74@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 77016f60-7e74-43dd-3875-08dd6af2e531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cC9Qamt2SzZNNWJJdVlaK25KdWtwd2ZXalp0d1RKb0paZlFMNUNaS1BuTkF0?=
 =?utf-8?B?eURpYUQwdXk4RmFRazNYWmtMd2NkVGY3NzhuNGIvZEJub1lSWVFyNWRSVnQ0?=
 =?utf-8?B?TTdlNTBPenpOeXN5WUhaK3RDWmdZZU1XOGYyYmNwQzBDMEtLRUZ2Vk1RbmZX?=
 =?utf-8?B?eEJHd3Z4NVhTV3NQZlE5dmtTaGxXSjZ4Wmk3R3I3YmV0STd0eXZlczFycWNj?=
 =?utf-8?B?T2gwNmxtTXlCZGJVS2ltd0JxMzB4UXFSSzBoRjI4UXVuSUhKVHQ1dkFuRktG?=
 =?utf-8?B?OThMNlVmUDRiZGEwT1NWRFdVa2k4S3hSYUtneFpyUlJ6NktpVFYzWFV0TjJX?=
 =?utf-8?B?YWhBdVVSZ0NjZGh6blYxQlVIN1dic21zQ2ZWaHAzRDJzeDVFRlV1U1lmaXo0?=
 =?utf-8?B?Y0x5WUtscEd5L0c1M3YrQ0NiSTY3eWNCdmpvSnB6dk0rMTk0ZXlpanNSYzJS?=
 =?utf-8?B?YnRVUHJvRHY5MFFMU3VOcHFHRnNiVngrVHBEV0xCenVpSkg5czBSQ2tOaHl0?=
 =?utf-8?B?UCtjN2xWN1dhWHRUV2NjVzdORGhoSEJxS3BSbG43ZmlQNDU2NlRCRk00a1Br?=
 =?utf-8?B?Y2x4NSt4WUJKeGs4dHcxUnJWY3dVbFNkS0dMVm9HbStNeEIvVDNwSmJOZkt6?=
 =?utf-8?B?SFNYTUIzdm9oUU1oNkprSW0yS3ZJTldnYjd3UUMrbUFHbTZzTENmN1pud0xh?=
 =?utf-8?B?ZHB5TFMvQnZNaVRNaEpxZFFwclAvcHVvOWpSY2VZRnFwdjRlZUpnaURNdHdm?=
 =?utf-8?B?cThZdXhxQjkxeEZQQlhmV3Bpc1NrYjYrcFUyc0VwakV6eDRwYzYrTGhIM3hM?=
 =?utf-8?B?SmJLeUhaVG5iMXZwanpLZkFGYVVHeWQ5NU5oZTAxVnJhSk1xcE93cExRRWpZ?=
 =?utf-8?B?OWdoNHdmNmFaWFo3SEhLZ09hUzJkMlgrSCtYQmhzQ2hxWlRKUE04NWFtN3Ra?=
 =?utf-8?B?NFJCeFBCS1RNVjVMNWNlbXVKalo5UWI1MzdrdDUrdGVoYmR2cEU2OXA5aUx4?=
 =?utf-8?B?SnM5K1Z3K3ZUalFtZlJkcXZtMFZQR3gxOTFEaWZ2aDYvZzdhdDZmbHJ5bFc3?=
 =?utf-8?B?SUhsenVCZTJZdCt0ODZoNGFxQ0xOc1VDTUovZWFnakEzSnlLRHVJTHhmYlJD?=
 =?utf-8?B?ZHZadWJ2bUJPbm5JWUJiczhYNWNURlBQRFZGZGoyT0Y3TG1tZlNXclo4Zkdw?=
 =?utf-8?B?MnZsdE9qdkRxVlUrV1M5WGtudDBrOW1yVldBZS9KaWp1aU1ydXhTdkp1cjhN?=
 =?utf-8?B?bUF1d05wTExEL1FtZE5GbWNwMUxPZUhMdThaYWZIeFh3WFFhWnkzY01jQk5E?=
 =?utf-8?B?UTRsRm5HblNyc0FtaHo2dzlXc3B5SzF3R3FxL084Tmh0VlI1OFY0YlVMeVJ0?=
 =?utf-8?B?WW5FdFJGRmVkZE5UKytPdGdlb0dUREdKdVF0dC9PQjlsVEorT2JtMk1URDNT?=
 =?utf-8?B?bmh2OUVyN3ZMZDNOSDlUZEZaMFJvQ1hBVDVKM2tzcE4rcFk4L1pvN1E2WUNG?=
 =?utf-8?B?ZGdaTXhpR0tPTEwzVFpYUXBweTNXMGpmZ2IwWWdQVVEvU05pRkNqSEF6SWJC?=
 =?utf-8?B?OThZSjQzamoxbU8vYVVYSEM2c3A3VzVrYmRxbVRSL3k1TG1qWGVLODVDcnF3?=
 =?utf-8?B?ZGJiL3dudHZqc2sxZVJVdkxsRmJnMmgrQXN6OXJxV3hkb0lkRDRMSTE4UmpM?=
 =?utf-8?B?anBEL0R3VXZ3VlBIc3FOZmZONGswdXA0TU1iazh2VG9Ub2FZZk5CRDBvd0Y4?=
 =?utf-8?B?Tk1SK3VTbmNwdDZlWUFnT3lFTG5wcDIvRWpLOENsOHpvV2lPZ1l5Y3QydEY0?=
 =?utf-8?B?dlhGbnZsM1h2YnBjbXNaL3lPb05jZnhXMTUwcnRUOWdJTXFiR0hNSzJpQ3Y1?=
 =?utf-8?Q?7g6I1VO8YDR1i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWdzZ3FTZWRmNVk2KzVRdmpkMzV0ekZ5UG0vZlJHTVRRSXRtQVJyRXRHTVZr?=
 =?utf-8?B?RGNqUWQ3U1NWVHpON2Z4bXB5ei96Z1NVbFBSbkN5c2dWNG5oYTZEYWl0dUN0?=
 =?utf-8?B?QlUvU2dZY3hCSUYrVkovQWQ3amQwaURtaHp0NU83QjNtbkxVbXR2N0ozUng0?=
 =?utf-8?B?Njh3VjVldXoya3QzVjFsLzI2aUN5S2R1ZnFWV1NPNDdJL2ZWVWJKeUhZRm5U?=
 =?utf-8?B?ZG16MjNvQnVrTkg2N1dMRW4zUW1IYzJ3cnlLdStibVJ0WDZPRVFRK0EvQlkw?=
 =?utf-8?B?MTdwU09pei9BdmNpYmdhK1ZxaStvclh5cmcyOElNdDRhWndIdmlNTEJ5eEgw?=
 =?utf-8?B?WkdwTUhDN2d0cnYzUU9jMS91TkdhYUhjVHJkVDU3Z0tiaGRXSGRBbngxQ0xv?=
 =?utf-8?B?WkJ3bVNyNXEyRUNkVlNvbFNXSHk1RnJRS2R3OWlUUjhibkNaZC9oa3NNSW83?=
 =?utf-8?B?ckhxSHZKY3B2MkR3b3BMeHQ4MmtJM2hWU3kvN3ZtM3JENmxiTzBET0h5SnpQ?=
 =?utf-8?B?S1hLRFZEVEZwZjZtcVpFVzR5YWdsaWp4WEpHZHo4a29jcGI2L005MHZvclBx?=
 =?utf-8?B?dlBwaVM0eVdDaWdtMDVpYkU1VEVhNXhuK3NtWWh5VEhPVlRrQUhnZDFzTlF6?=
 =?utf-8?B?ZytrL0oyTWh3MXdNQy9PVTdMbWwyWFlxeTdZRGhNeG9xRTBrUnQxVi80N2kx?=
 =?utf-8?B?ZGpzK0dMakZEbUlYamdrWFJBS0FHVGJQUGQyTWh1bWdFSlArRnYxYW55RTdZ?=
 =?utf-8?B?OWVYWjBDZ3N5L054Smg2ZjI3aVB2OEcyYXpLUmNKUTc3OTcrM250djVjdGVC?=
 =?utf-8?B?UGp2RmV2TnFvQW9GeTdBTXFIaGZueG5nc0hwTjEvOFpLcTBwSWF6S09KeGVW?=
 =?utf-8?B?NjlPMVNFdkpFVldXcVBEamFpTkZyWjM0ODdFcGNnR2FCKzQvaW44ZjNkYjRh?=
 =?utf-8?B?ZUp2a3hXSFFMTkpoSkR4Z2N6VS9PRmJIZE5pSWdZUzRaNC9ValRzWkFkakFz?=
 =?utf-8?B?RFBaZzN1QmVFM1NsWVRHVXFhVTNPNU1sT0llNElOcEpqU2xyenYzUzRVUWZv?=
 =?utf-8?B?TXd1akZQOStIcm9VQWFYN0NMZXl2eTNGRFhvd2pvQ0hCeGszVHphSEZOTkhT?=
 =?utf-8?B?QjFyZmVrWU9lQzFNd0tWQnBWTnJTR0RMVlBGeVk2Y1Zxc1A3dnFEVUdWbVlL?=
 =?utf-8?B?NFd2MmVsU1FZS3ptQ0RwTXltRS9XY2FrVmdNNUJFbEdhbWtiYnp1bTJoSTlo?=
 =?utf-8?B?ZVJKeERSeFJSYW9mUGhrSGRYTWVudHhUNWdmUzZiNW9INzVQQXR0TmRxeUpx?=
 =?utf-8?B?Y1dLam1ab3BrejFZWk5lUFZTRlI1V3lyWUZRaUp5K2g5TGUrM1R0clh4N2V2?=
 =?utf-8?B?NzJvQmFONm12NTJpQmh1TG8xRmIrR0pSTTRvUUZvOUdXRENzdHI5Nm16SjRR?=
 =?utf-8?B?TXplSkNtNk9uRnhrNjhrN2tGTkhPQU14YTlUM1hDMzFSWStCZTgwZWJ3ZUUy?=
 =?utf-8?B?M3lJQ1FaTWlDVTM5c1BnWGYyLzFDeFg3QTR3WWRmckFPblZPZVBjQzNYS0Jv?=
 =?utf-8?B?WkgvV2RrSTJydDBpTXdXK3daK1FsWVRBd1ozZngwQm9FWi9SUFpBR1VpME5H?=
 =?utf-8?B?aUx6ZGd0WEVtWENRRkgrTWV1VSs0emYxKzBYNE1GU2N4ckgzWHM1OU9JZkt3?=
 =?utf-8?B?c3hSMFNiNEEvaHFjTG1UcWo5a2VMVGcraDcxN1Fjc2FYVlM1bmZneWZJQVhr?=
 =?utf-8?B?NzlCdzlFYThIM0tsOVovNzhLNXF1ditwbzFUWDRCeEZuM2tFRVB4MDBlRnQ1?=
 =?utf-8?B?bXhKYlNJaG9HRFIwM0ZlWGpwMEYxYmtUQ0l4YWhxdGZVVVRlR0xhWUcvVzhu?=
 =?utf-8?B?WkZPYThpeEZrUTArVWlhekRKSk1Ca0pWOVd4UzVqZjBzMUFPRDdyTHNxenFh?=
 =?utf-8?B?ZkdvMUc1ZmMxdjh0amduUzFOL1BsQXZ5bHFmaFQzVmZLbjVmaGhhZzJ0T3du?=
 =?utf-8?B?d0VMcTFLWnd3ZFRYOUMyVUVTZFE1YitaUWNybDVzaUtVVWxQc0dvREE4dWpL?=
 =?utf-8?B?T3RLSENBendzbEZ1YnlWWU1TbUJWOU93d0xQRUY0NVMxN2VqVU9CZDhTWDYz?=
 =?utf-8?Q?lPklZylgq+OFJzn2Elc52YO+3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77016f60-7e74-43dd-3875-08dd6af2e531
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:42:41.8508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuMCevUEkIr25UkqEL024HeaRLTtR3bB9fv63xSc1pFg+NpAx1jLTmKsJQirNiJuPIDRXnTAEJFgYjbK2oOI5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
Received-SPF: permerror client-ip=2a01:111:f403:200a::61a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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


On 24/03/2025 17:25, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/24/25 16:14, Avihai Horon wrote:
>>
>> On 24/03/2025 14:33, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> VFIO uses migration_file_set_error() in a couple of places where an
>>> 'Error **' parameter is not provided. In MemoryListener handlers :
>>>
>>>    vfio_listener_region_add

Nit: migration_file_set_error() is not used in vfio_listener_region_add.

>>>    vfio_listener_log_global_stop
>>>    vfio_listener_log_sync
>>>
>>> and in callback routines for IOMMU notifiers :
>>>
>>>    vfio_iommu_map_notify
>>>    vfio_iommu_map_dirty_notify
>>>
>>> Hopefully, one day, we will be able to extend these callbacks with an
>>> 'Error **' parameter and avoid setting the global migration error.
>>> Until then, it seems sensible to clearly identify the use cases, which
>>> are limited, and open code vfio_migration_set_error(). One other
>>> benefit is an improved error reporting when migration is running.
>>>
>>> While at it, slightly modify error reporting to only report errors
>>> when migration is not active and not always as is currently done.
>>>
>>> Cc: Prasad Pandit <pjp@fedoraproject.org>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>   hw/vfio/common.c | 60 
>>> +++++++++++++++++++++++++++++-------------------
>>>   1 file changed, 36 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 
>>> 1a0d9290f88c9774a98f65087a36b86922b21a73..a591ce5b97ff41cdc8249e9eeafc8dc347d45fac 
>>> 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -149,13 +149,6 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
>>>       return vbasedev->bcontainer->space->as != &address_space_memory;
>>>   }
>>>
>>> -static void vfio_set_migration_error(int ret)
>>> -{
>>> -    if (migration_is_running()) {
>>> -        migration_file_set_error(ret, NULL);
>>> -    }
>>> -}
>>
>> Wouldn't it be better to extend vfio_set_migration_error() to take 
>> also Error* instead of duplicating code?
>> We can rename it to vfio_set_error() if it's not solely related to 
>> vfio migration anymore.
>
> IMO, the vfio_set_migration_error() wrapper shadows the use of the
> migration routines and their context. I prefer to be explicit about
> it, open the code and work on removal. It is possible to add an
> 'Error **' parameter to log_global_stop handlers and to the IOMMU
> notifiers. It just takes time.

I see, fair enough.

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

>
> Thanks,
>
> C.
>
>>
>> Thanks.
>>
>>> -
>>>   bool vfio_device_state_is_running(VFIODevice *vbasedev)
>>>   {
>>>       VFIOMigration *migration = vbasedev->migration;
>>> @@ -291,9 +284,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier 
>>> *n, IOMMUTLBEntry *iotlb)
>>>                                   iova, iova + iotlb->addr_mask);
>>>
>>>       if (iotlb->target_as != &address_space_memory) {
>>> -        error_report("Wrong target AS \"%s\", only system memory is 
>>> allowed",
>>> -                     iotlb->target_as->name ? 
>>> iotlb->target_as->name : "none");
>>> -        vfio_set_migration_error(-EINVAL);
>>> +        error_setg(&local_err,
>>> +                   "Wrong target AS \"%s\", only system memory is 
>>> allowed",
>>> +                   iotlb->target_as->name ? iotlb->target_as->name 
>>> : "none");
>>> +        if (migration_is_running()) {
>>> +            migration_file_set_error(-EINVAL, local_err);
>>> +        } else {
>>> +            error_report_err(local_err);
>>> +        }
>>>           return;
>>>       }
>>>
>>> @@ -326,11 +324,16 @@ static void 
>>> vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>           ret = vfio_container_dma_unmap(bcontainer, iova,
>>>                                          iotlb->addr_mask + 1, iotlb);
>>>           if (ret) {
>>> -            error_report("vfio_container_dma_unmap(%p, 
>>> 0x%"HWADDR_PRIx", "
>>> -                         "0x%"HWADDR_PRIx") = %d (%s)",
>>> -                         bcontainer, iova,
>>> -                         iotlb->addr_mask + 1, ret, strerror(-ret));
>>> -            vfio_set_migration_error(ret);
>>> +            error_setg(&local_err,
>>> +                       "vfio_container_dma_unmap(%p, 
>>> 0x%"HWADDR_PRIx", "
>>> +                       "0x%"HWADDR_PRIx") = %d (%s)",
>>> +                       bcontainer, iova,
>>> +                       iotlb->addr_mask + 1, ret, strerror(-ret));
>>> +            if (migration_is_running()) {
>>> +                migration_file_set_error(ret, local_err);
>>> +            } else {
>>> +                error_report_err(local_err);
>>> +            }
>>>           }
>>>       }
>>>   out:
>>> @@ -1112,8 +1115,11 @@ static void 
>>> vfio_listener_log_global_stop(MemoryListener *listener)
>>>       if (ret) {
>>>           error_prepend(&local_err,
>>>                         "vfio: Could not stop dirty page tracking - ");
>>> -        error_report_err(local_err);
>>> -        vfio_set_migration_error(ret);
>>> +        if (migration_is_running()) {
>>> +            migration_file_set_error(ret, local_err);
>>> +        } else {
>>> +            error_report_err(local_err);
>>> +        }
>>>       }
>>>   }
>>>
>>> @@ -1229,14 +1235,14 @@ static void 
>>> vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>>>
>>>       if (iotlb->target_as != &address_space_memory) {
>>> -        error_report("Wrong target AS \"%s\", only system memory is 
>>> allowed",
>>> -                     iotlb->target_as->name ? 
>>> iotlb->target_as->name : "none");
>>> +        error_setg(&local_err,
>>> +                   "Wrong target AS \"%s\", only system memory is 
>>> allowed",
>>> +                   iotlb->target_as->name ? iotlb->target_as->name 
>>> : "none");
>>>           goto out;
>>>       }
>>>
>>>       rcu_read_lock();
>>>       if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, 
>>> &local_err)) {
>>> -        error_report_err(local_err);
>>>           goto out_unlock;
>>>       }
>>>
>>> @@ -1247,7 +1253,6 @@ static void 
>>> vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>>                         "vfio_iommu_map_dirty_notify(%p, 
>>> 0x%"HWADDR_PRIx", "
>>>                         "0x%"HWADDR_PRIx") failed - ", bcontainer, 
>>> iova,
>>>                         iotlb->addr_mask + 1);
>>> -        error_report_err(local_err);
>>>       }
>>>
>>>   out_unlock:
>>> @@ -1255,7 +1260,11 @@ out_unlock:
>>>
>>>   out:
>>>       if (ret) {
>>> -        vfio_set_migration_error(ret);
>>> +        if (migration_is_running()) {
>>> +            migration_file_set_error(ret, local_err);
>>> +        } else {
>>> +            error_report_err(local_err);
>>> +        }
>>>       }
>>>   }
>>>
>>> @@ -1388,8 +1397,11 @@ static void 
>>> vfio_listener_log_sync(MemoryListener *listener,
>>>       if (vfio_log_sync_needed(bcontainer)) {
>>>           ret = vfio_sync_dirty_bitmap(bcontainer, section, 
>>> &local_err);
>>>           if (ret) {
>>> -            error_report_err(local_err);
>>> -            vfio_set_migration_error(ret);
>>> +            if (migration_is_running()) {
>>> +                migration_file_set_error(ret, local_err);
>>> +            } else {
>>> +                error_report_err(local_err);
>>> +            }
>>>           }
>>>       }
>>>   }
>>> -- 
>>> 2.49.0
>>>
>>>
>>
>

