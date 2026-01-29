Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C316D3569F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 05:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlKJt-0005xT-0Z; Thu, 29 Jan 2026 00:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vlKJj-0005uC-OO
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 00:11:43 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vlKJi-0007iQ-32
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 00:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMG9VOiIAnad5+kKPgj7nggK1jZRbI+R48Im6ic0GWvGUwIEr3sPuxyzEO22vQkhcYoBlR+R0uZdNSes6rn44irhRGYL+5rcS+2q3yEyytHUvbgLTs8MnQAO+7FVJotleyg0inuc6e5HUBSquH2TvlgStMLTGEvkUWxu4KJqBMsewBUaY7N/LWzpIwKapCn4NfplTRmtiHgf0knodHAwXrYeGs5WI6TS+IRMwTUuuGmRAyTgPpZH3JQ3X+VC12pZHc5WAbLhrWzrG2gInVqS5ezeBqpdPtY4V6vmm5G38bd926HraZMBGnDKzVfbd/hJ0I4Xjq70yjtZW+kOJvIhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewqyg+ihR9dlJa387vczLYwEaMvl2njUEr8zzHFAg4I=;
 b=T3LNWW+nokjERjOs6kq0k5qMD/TxMGtvNAeh8K7W5ODCtY6vJLtnHNt3B+LkqzK+W4CH2oN/dkK28YwgAvBtpQSYCpoyqCrkbOIJ0+SQ+yvRFDBEx0p6cgQmYVMp4JpOpPv2Mhg6cSHGQg5nlF1E3Uwfqiuo18+JDR1ZbhNBZKk9K00nY/JoyHzGaUxgjfusi40op1skv7P8of7UMpK57v4dNw46RB2HuEc8lYU3X5ZVEQHB2WmGGJmxQ65OuDjF5IZDNQc/xu3RNobKoXGhFi55wTx6ek9ytHu5aRY054fNJJhzV3DZTZkb1QIx2SbmYcyS6PWVgRwEA/W3Igdnpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewqyg+ihR9dlJa387vczLYwEaMvl2njUEr8zzHFAg4I=;
 b=bdgl8eg8OQb5lsRsjFgy3kRmSaEjP1gIN7fxrmpdZZiaRChpjoqRkKH9zEA8GmGCuCP9jkM/daiJuyzqKGqy2VL+9yHdPaHd8seNG+JI4OTnRXi7jcvYtdKA0SuMBVnIL89fpR7e/ZKGbz5z3zpQcbs52T1zrz/N5w5fnlYY6pHSBgi5w5qvc/e+fJx+F2h8Cti2xyb3eA9jxjO+zZSQLoUHOVS3fZ8WVN4GeZNrpVpbN8u8F5yQZgjaSQE285v5cvda2biiH1g2ZUeMvlCQRhu1TotLZOTIXBC5Fyva+NhaW8jq6W7iG8qzbbWudCZxoK6nbmdnTPXbDK+2VcNFrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 05:11:35 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Thu, 29 Jan 2026
 05:11:35 +0000
Message-ID: <8c5920ce-45b6-4436-a019-222643f573ea@nvidia.com>
Date: Thu, 29 Jan 2026 07:11:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com> <aXoiAsGCWRv1nwW-@x1.local>
 <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com> <aXo3mcseNxP9bJ15@x1.local>
 <591f4e36-11a8-4310-a74a-6166698d7b23@nvidia.com> <aXpJpwLvHTAXfpon@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aXpJpwLvHTAXfpon@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0028.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b9501d-a7b8-47bd-ed3d-08de5ef4df98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ui8wZ2JpNHhRWlBSSU03cmlhVVlQajdUb0I1ZDhRVHlTVEYyRW1OcWtFSkZz?=
 =?utf-8?B?TzRjaURBeUhPeXBRd1Y5WUVmcGxVNUJ6bU03S1hiRFFweGJtTmVOTVVoWW9q?=
 =?utf-8?B?dEIxL1VBS3Z4MTBZbXpQaUlxalUvWmhVcTdEWDQ4QkFSUzhDYkgzWnhQeExC?=
 =?utf-8?B?VmJlemFIZjM5K0VkSXdERVhVZkdXVUErVlcwa0J4bzdZRTNGZ29xcVhaU1Zi?=
 =?utf-8?B?T2JyUGgrWTBYbmpqL012OW8rYlVoZnJza2RuZGg5eUNzY1QrOUZrRVhHZlow?=
 =?utf-8?B?UDVndlY2VzV1NmlwUnV6TG10Z3ZiWG1yMmV5TmlIM2ZRL1VwSlJOSXZ1UThi?=
 =?utf-8?B?QVBhRG03NkRCYkllRXFORmRnRGZ2VkxFZXcwTzNnbUprV1FlS0s4VzdKMzE2?=
 =?utf-8?B?a0o0bWJqaG54RFVkemF6N1VGbjF2dU0ybm5YYW96d0tUTnhtYmlXMWd4dXFM?=
 =?utf-8?B?L29UeVZ6bEZpNkpPMzhrTnpiSnRSZmtua29kaEdlV215eXMzeFJXOFlCOW5r?=
 =?utf-8?B?WHExTDd0ZHNXcmZBbTkvVkplTVIxVEhPcldzN3Ezdlgwb05OZy91TlpMc0RY?=
 =?utf-8?B?bVNaakZhK2FhaTh6L2E0MkdqeXloTHdvQU1Fa1BPdXZuZnpBYlBaL29wc3Zu?=
 =?utf-8?B?eG1BQURlMlM3SVVxRC9GZXArNmF5Zm8vdnBndm1nQjBnVDRoNjZwalZUVmNZ?=
 =?utf-8?B?eTFXL00yUDh4bUhOL2FsYkR2eU1YdG9HR2E5SFJDTnppVTQrcndjbzFtNGtJ?=
 =?utf-8?B?cXRTdTJYK1JjV1VwUnR3T0l2MVQ1RGJsdXIyYWh4VzhpRyt5OHlzTjdMbHRS?=
 =?utf-8?B?a3R4eWhReEk5My9tM1dML3NMRTB2UFdoWjZpK1VxQ2VHczJOUVN1UkpJRFJs?=
 =?utf-8?B?VTczNUc4U3lxOXNSN2N6ekQ2eXZ3eHZSVFZCdmJPcWR4VjlhVTZoOUltNUxU?=
 =?utf-8?B?UWVhUXZKNnJ6OHRYV1V5eDZqaTR6YjVRMmxOM2JLc0xtRURlMi8xQ1IzejVR?=
 =?utf-8?B?a3A2NEE4ZHVoYUZjNzFCVlo1dFN2RTFPN2Z2U21MeTZBSk5xdjZTRWlzc1V0?=
 =?utf-8?B?ODEzZWp1cmNoSUx4bVRta0tIcjlnbkdpVG1xcC9mU3lOczFncTRkVFN3SXI5?=
 =?utf-8?B?MERpSmxhL0JuMEZvZ09xMDUwRmJjWnVLM2V2OC9uT3hoWUF3Uk4xNk4xbHdv?=
 =?utf-8?B?Wmppc1BZeVNodi9ybnJ6Y016MmF1YVNrOVVUR3J0UjYzYVQxMHRSTGRwdnJn?=
 =?utf-8?B?aFF6RVBuR1FQOHByMzRZVVVFYjM1OTFXS0U0Q2FjYWp1TEJDcVVHb2Y0b3RL?=
 =?utf-8?B?a3NNRzlkSHVGWHpTaFV6WWhIMWpvUmYvWitDTDcvRHZYWStrdWZrUDZVNkFv?=
 =?utf-8?B?OTlSdUZrYTBtTFpzWjFlanVQWXNQeXhxYUhnUThXeTFRa3N0MDJqQ1RxWlRQ?=
 =?utf-8?B?Y0FzT09zdno0eklmM3ZSeXMyQnFReEVocHJaT1RDVkNKdndpL2ZVNDBQclBn?=
 =?utf-8?B?REp6TTY1ajhrTHlnVDFxOW1jdzg3ajl5MDV1eUNlRUFjMTI3UWRhQXplTC94?=
 =?utf-8?B?QjI1dDJXOTR6elJoR3l4ZGtPL2tqVllSOEgvTkpxWUxqNW9acTY3cVBqR2pR?=
 =?utf-8?B?RkM2YmtJVFNsT2ZpTW5tSmkwK3VhUEMyNi8yN3EyK2N1VDN5a2pFYlhIanps?=
 =?utf-8?B?K28zT2IxMUthMTZ1Q0RXUVNWQnAzMklGb0F6S3FHeERBV1JjdGkwdHUxYnQ5?=
 =?utf-8?B?UGh0aktPc0Ftc05YYlpFVlcxMm5LVTlrN01wMWh6bG9EUm43ZThkcm4wY0RW?=
 =?utf-8?B?NnNsZnIrNVIrQmxUT1B3Qlh3NDV0cVlTNkdvVFZ5QzJOM2FCbFdtNFVtSmtt?=
 =?utf-8?B?dFZnUTlWSFNyUnRnaWVTK01IeHc4U21uc2pvdG1uWjBCK3RwMEtxOW16aUF3?=
 =?utf-8?B?TE5CQmt1WHJBcHRER2VLRllaMG5Hb09XVlVxaGRyQUs1WXl0NzJSdTFXR0Vo?=
 =?utf-8?B?RVphZGcxYm83a3JQWndGNFFWR2E3MUNwUy9PbWVEWU84M3dwUDhOTU1YOC9s?=
 =?utf-8?B?NDhucHJtbkNXNU9RZUNJYjdOZVVBUDE0R2JVWkp5VmNHVUpaVnJ4bzNwRDAy?=
 =?utf-8?Q?92DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJacFhKVVFnNWxoWExyY0ViZ2hNWjdWSkxZY09tclBSMU1GOWdocmtTUy93?=
 =?utf-8?B?THdwNU1OL3hRMC8xTHJncWtLYnNJRFRvTG1PVzdMcG94TFdiSkZwNEZpUSts?=
 =?utf-8?B?Q0lzdnZDby9QR3BSZ0dwMHgvU0hRQmszcUxVN0tDclIrQy9NcUN5R0x1djRV?=
 =?utf-8?B?S2Z4blpqelBHaUtvaUVGdU5YQitML3RHUnVacysvbnhLeHcwRnk1YzRXaXk4?=
 =?utf-8?B?dUt0S3BJUEJnOVE5WUJRSVlNNzVSeWJ3N1lXV1hnVGRvU2h0Ym1mRm5oWng3?=
 =?utf-8?B?TlJFV056RTZkMGVRdHBFcHcyaW13WDVwSStHdmFCTGc4WVlzR0pnU1plb21l?=
 =?utf-8?B?RWxyUU1GZjhhYm1TTDRWc0ZpcUVrNVE3OXZLUG1hM0E3UUFkemRKSTVCbWMr?=
 =?utf-8?B?UjhCUnV3TkVtaml3SzBOM2s4Z1FhMSt6enNiWXZwc0o4dDYrNnJnLzVUdFZ3?=
 =?utf-8?B?OTZCMHJSaHZFMjRUVGNRbG5Cc2IyQWd2Wmp2d25tU1E4dXFpN29RWVN0RkVH?=
 =?utf-8?B?ME9EOS92TXRaeUtWNjJSc0hycktJaUhTQzA0N0dCQTN0b3dodlZjdU5JVVRo?=
 =?utf-8?B?R3Y2cVdjeVczNWxJcTQ0dERaNmdFdzlTTGMrQjZwbjdiY3RJNFN5U21OZDJz?=
 =?utf-8?B?cnJwWXFNTy9RNjU1U2JaRU5hS0V1RkFJUS9yWjQvdFRZRWkwSU81MHF6Q2Z1?=
 =?utf-8?B?cFE3aEtrZThNUW9IVTRJU3lMd1dBQTJUNWlBNHVZQWxwbXEzTEQvc3dDY3lQ?=
 =?utf-8?B?RlY4V1ZpSnJ4eG5iQ0d1VksycE90ZmZTalZoNHVNbXJJZGd0ZzhNYTB5UVpu?=
 =?utf-8?B?WFBjSm1ZVnVzelE3ZTVkODVzSTQyMktpRkdxMnI0K2xRRHovUWxqb1ZlaUh0?=
 =?utf-8?B?c3FxdXh2OVRzZXBjL1BiS1VHb3ZTdks1djlBQm5ubkYrQ2dMYUV4ZGZRSiti?=
 =?utf-8?B?Y3dUbFgxa09RUWdDSnJoUmdXWUdaS3ZvTVNqSjltbEtpdGoxSGRCdU1menJj?=
 =?utf-8?B?TmhweHd5SDJzd3JUcitXM0NPemZ6SVBoTjJXUmdueUV5WCtzQXZUWEIwNHhs?=
 =?utf-8?B?Slp1NU5nZTI0WUhYZXN0cjYxS2cyaXYwNHpVRXpLb3B5V09nT2VRb24yUTZJ?=
 =?utf-8?B?bXB3ZUlZNzFGMlRTQzB4SGU4RVAzWTUvN0RzSWJLOG9zc0NmR3R4YkYvcnJu?=
 =?utf-8?B?MUxZMDFSRUpEZ3lERWpTOFh3UjMrcU92bnRyMFFyOEsxejd3WFYrcGdWNTBq?=
 =?utf-8?B?bVNYUERuaU8zOTlhUGk4UUczTGQ0VytMVGxDUU55aGIvUkZmNU1PcGNFWEEv?=
 =?utf-8?B?VHBZaDY3TVE0OS9DTS9GRjdBMGhHTFhIaHB0TzU2bndWSStTbGtQSWxKSDlT?=
 =?utf-8?B?eU9yTUJ0N0U1cE1acFhxYXFwVkhyVi83RFFlb0lUU1BFY0F5WkN6N1FBL2tY?=
 =?utf-8?B?NnFRQXN3VmNGZ3hIdFE3SlZJdEZ1a0lyTzRvaC9ZTWY2YmNPTi9iMGRMditH?=
 =?utf-8?B?NzBWZkdrOXJHeGpYVDJRNzR6Y1VJTUticE0zUDRGd2pNb3lEdTRZdm1lb0N6?=
 =?utf-8?B?VFNkUTV4ZHhZNDlISlhwTU1wNW1ON0tuTkgwTzdiY05tNm9lSWNPY1pBSU5h?=
 =?utf-8?B?NzQ4MzJoRXM3TUc5eVlGZ0hHUjBjOE5MeXhITDZLU0NIZDBvTGRKNUpDN2ZS?=
 =?utf-8?B?U1ZpNlVEcUZwWDVrd3RvMG8yanovVzRsSWR0NGpBUWR0OE5qakFkK25mWjc5?=
 =?utf-8?B?UWxpOUovVmRYOE1yc2pSZHJ1S1BsU0g3VmlueVg5V2NLL3BCbDBaOG1WVCto?=
 =?utf-8?B?LzB2SFBxOE1IcmREb3grNkdLdklkNVRIckZGSWFFVDRKM1lSKy8ySmt3aksx?=
 =?utf-8?B?cXdLU2w5enAvSExEMUZZK1QzN0VON0FsOEVIRXFGTlhlQnQyQjY5NXBpR2xB?=
 =?utf-8?B?ZUlEckFmT1BOK1k3MFNZUHNPQjN4WjZ2NVNvV3hmNXg2TGNDZ0hxdEVPN29Z?=
 =?utf-8?B?U3JyYk90Vlk5RGZvYWV6ZUdmbjN1U2p6S2kxcE1EeVBkZUQvYlhQQmFIck5X?=
 =?utf-8?B?SmtWclNqUWgyemdnOC8zTks1NmFXL3VTTTdEQWxUTFY5NStXeFpNSjlqcFBk?=
 =?utf-8?B?Sjl6RVU4Vm5kUm8zdy9sN1ZtUWdoWEt0aWxWN3JJRmlYaDRaUVl5RzBoR3ZT?=
 =?utf-8?B?V0FWWXdoMi9CbEFlOHZ2akNNUitZeENjYnJVcWh2cTl2aFo4R28vWjNGUVVG?=
 =?utf-8?B?WFBMa3JEcVIvbkVwbFY2bFE5aGpDZGRCcEVSbTd6TFJNUTZWd2FKdDNnMzd6?=
 =?utf-8?B?Y1MwUE56Qms5RkE0UEdaTWFkeWFGTVlUSTkydkhLdEJsTnRVUWxaUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b9501d-a7b8-47bd-ed3d-08de5ef4df98
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:11:35.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2w1a7nareXmk5IoQRIvGtbW0FWcV7SbIPmE1a9ksFNZNuOMBnM8ow13aQKl0nfiqopjc5okJw1GpUp+rJvR2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=avihaih@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 1/28/2026 7:38 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jan 28, 2026 at 07:13:43PM +0200, Avihai Horon wrote:
>> In our case we only use the PRE_COPY_P2P prepare event. The prepare events
>> for the other states are ignored.
>> For re-enabling the timeout mechanism we indeed use the "regular" (not
>> prepare) events.
>>
>> However, this new event can be used by anyone for any purpose, so I didn't
>> want to limit it only for my use case.
> I see your point.
>
> Said that, in this specific case, my worry is nobody will consume the rest
> events, and then after a few years nobody can even tell why it ever
> existed. Then QEMU needs to emits some never-used events forever, worrying
> about breaking anyone, even if in reality they're always ignored.
>
> Personally I think it makes more sense to add one explicit message as you
> explicitly need.  Then, that message can be as generic as possible on its
> own.  But I'll leave that to you and VFIO maintainers to decide.

So you suggest adding the prepare event only for the PRE_COPY_P2P state 
(which is used in my use case)?

Cedric, any opinion from your side?

Thanks.

>
>>> I do not know VFIO state machine well, also not familiar with this specific
>>> problem.  So please treat them as pure questions. Anyway, it'll be always
>>> nice to attach some more information into the commit log IMHO.
>> Sure.
>> As I said earlier, I didn't want to tie this new event to my specific use
>> case, but rather wanted to describe the general problem it can solve.
>> But if that helps, I can add some more details in the commit message in next
>> version.
> That'll always be very helpful, thank you!
>
> --
> Peter Xu
>

