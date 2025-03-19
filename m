Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45336C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuuOE-0005SQ-RF; Wed, 19 Mar 2025 10:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tuuOB-0005M8-8X
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:27:23 -0400
Received: from mail-bn7nam10on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60a]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tuuO8-0003e5-8B
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4DNgM+mbOOOeCsx6jmYbcnXY8zAqJpeLF2B9vcvwZ4ELSQ/4QiAXW58ESfoxqSIcb+b4nDmQh1KzqX2ucr3bQuQHYtLJy37IDXf5JvYcPUdMtNbxWH87SGNz4DW5q+QWR3Gebzyfa5ht4weP5FLKk7Dt56WUCTZoIiH/eTv12XddpiG/KBwS+4imlXQ3GGe1Xhtj8ra6teiI7wLZ+2bIVyE66h43iLbOib4FRw2HtcgI7R3DKVnSlaZ8HtrHjtu5JDUVgD4yiMJS4qlAdB554Q30F64BnoJ7W3CSFB3e1VoSybXXxqLdNB88ownhUN6OpWxWYuMatwy9Uf6umBLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pTLBSCcVi0LyGMbxX6xl16C8HFHDJQkbWWK9Aliln4=;
 b=J3IdoPxNoJwdXy3SeD+AexbZUVI/w092ayqWF73+h8xgoukSI9EkiLwPCSK0QqUEnMKisoqS8aO6pzBDbMbCExp8g6i4mIfHFVTJMtIvWCxdL48ZH1hpZpWpySUdEMUAMXHR5Abq4QDdR13NHs18bn4wZyLTzFN6C0kXYf48otgWg+gNFJwwi4kWcPD/nfr8IzUP29fNjENudoGdQAMiiEw2Z9VRz7+N+/60p8SVEsjMMn+rMYV6LOL28GMA5nAPAm1xp/DeaKMcfNQA9yL83ERHToZ47TS3K/5Rkt8qu/8Jic7Prk2k1w7N/ZAuFjbYldtON0ECY1Pm2Fcp554GEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pTLBSCcVi0LyGMbxX6xl16C8HFHDJQkbWWK9Aliln4=;
 b=s8QFXksYD8RTwWHG4Vh4KZkTpdDMpy1abX8J1HP/fa7qQUYcWGVHxzxgF+mU+4Pwcb+k9bl5PhVduOE/vQyo6ce8vSJ1Dv9TIR1why3vtDX0y1lxLCPSlTx3gkoIv73DF6+LGZ32r1uoZg06lFmZar8FMi2w+Mjyg1eoZLaVQwTEyJwv2S2d8J5uHj7urOSnFF98fHYc5hgz/r7iEF4FfpyOuZkKqUxdpPsYDW/t1jvvnyuth8kfOLkDXnaRFAn4RTaBXZbBah/ZZQwFPhX2DRaCQZlzv7hvmjeLPORPrU1o+p8ltmgMzbCy6kkdaqWhmcw0EGL9vtnzABxfgyizWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:27:14 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:27:14 +0000
Message-ID: <6fb5efb1-5e61-4ac3-9cc0-d4ff40cd5f07@nvidia.com>
Date: Wed, 19 Mar 2025 16:27:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 26/32] vfio: Rename vfio-common.h to vfio-device.h
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-27-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250318095415.670319-27-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0510.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: ccfeaf69-dc89-4207-4cf4-08dd66f224d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WktmN2pYdklhd05hQjM4cTVXb2txcldWb1Z4WnRhTXp1VFJGRHE2a09hcHk4?=
 =?utf-8?B?SUZxYzVGMmxjUS93M2VNM250MDJ6cmFHYklZOUJEVGJTTHdGdit3dE83ZHpr?=
 =?utf-8?B?QkFndkYwSlN5KzV5TXYyb05id3VsNDBvM1M0eXJXTkRXVmxyMHZRaExGLzN0?=
 =?utf-8?B?cUZtRWFhWTErVTVibkNHKzlleXpaYnc5a0tyVVphU0lPNzBXUS9UeGtsWWdj?=
 =?utf-8?B?TE5QZ3VHc2VObUFYVVZXdHJOTGRtanhNUUZhcEpoRkt0Zzg2eDlLTkEzdVVw?=
 =?utf-8?B?N0ZyemQzWUNNSGNrRjBWNlgrdlc1SUpPbWlwY2V0SkpZTjkrZUdmMThmaEx0?=
 =?utf-8?B?MU9wbEZkci84R2FQMEVDekRSNVRic0svZ2JGczAzVHBQMzFMbmdEWTlSK1RB?=
 =?utf-8?B?a2t5Y1Bud0hKMjVDd0cyL2FrR3dNN2luTWJ1Zm5iazBETWhleGJjWXM0RXcv?=
 =?utf-8?B?MGZ6YUJYL3dEOC9oYlJOb3lXWFVEVUYvSHZKYlBHVjFQRHdSSUNvemExd3NX?=
 =?utf-8?B?TGpoSzNIWlFSak1oZC8vbk0wQStadklvUEJWVEpuSmRZU0hwNmVFVGJYMmhF?=
 =?utf-8?B?NmV0TWVMM2tKR3dqeklDNlVCOFFoUy9Qak56SnZBaTM0RUtYd2FYVGY5TzlB?=
 =?utf-8?B?NVkweWRta1plTnN5ZytITE5oMEhqTGhEMStOcUg3bHdFaTFpQ1U4Nm54QTZQ?=
 =?utf-8?B?Zzl2cmk2ZXVLWmxRYTNiTzBUTUxaeVBzQk9ldFBEYnlWTXVoUkRYMEFhZU9y?=
 =?utf-8?B?bWlYTnpxNFozTENpdFAwRVBPMERtVVpIV1lXY0hYenpBbXN5bkxYckJUbjdy?=
 =?utf-8?B?cW8rSzVJUk83QXo1dk5EZVdISjlEdjdqaExvbTZGZDZkMGZ3cThzczBjTEpQ?=
 =?utf-8?B?anRHbCtpUE10SWxVWjdDNE9oSU1mOTRwQU9FcVVnWVRTQ1l1NDNlZDl3Zkpx?=
 =?utf-8?B?bEc2Vjl5Qi9YWWxyNE96S25ubWRWQUtrZloySlhtR0MzdStTdTcxcllET2sz?=
 =?utf-8?B?K2lqcHBUNDVDc1h2NnFjNFVQdVdNaVhoelJEd1RLSTloWUZ1a0FXbGk4d0Fl?=
 =?utf-8?B?bDB2dGxIY0VSV08ySEhGSUVoVk5JbG9XQ0pIdVFsQ2c4L2xFdkh4dlVXWktG?=
 =?utf-8?B?dk9NRCtZWStHRC9na0szUXcwQUM3MXl0OEF6VDdpMUNFNnBRVW92ME03ODFo?=
 =?utf-8?B?dFpoQXlRdDB3dkthTWJhU215Q2RTYk9DaXI3RFp5aFFwUjFDS1NWVGJyMjF0?=
 =?utf-8?B?TDRYUmNUQjdnZmxSS2MxMDNZTmtBRHpXcmp6dkMwV1NEUEtiQ3MxWXlXSjV4?=
 =?utf-8?B?UStjRG9Nd0p0UWdTTFlEM0Z5M0d6U1Yxa2szck5Md2ZOcFBBM3BFZittOGV5?=
 =?utf-8?B?aTRLb09ud2h1OTh5bk03UnhHamtxVGh0bStoZ0YzOHJXYjF0VjFXK3ZUSytX?=
 =?utf-8?B?cFpCaUF0Nndsd0U2NjlVeFUzVDFLa09sMldmdHJQd3VSSWZZYkczdURra3hK?=
 =?utf-8?B?K1NiWjBVR0prM2pFZDVqTlVnVG9ncC90TkF1UGlFSUR6bmFNMUJWY1JkS21K?=
 =?utf-8?B?eE9TTjZmSndJWTRBRlZiam80b29hcXBrYUJhU1pqNnVvbkdSamlRWjBBMmRh?=
 =?utf-8?B?N3JiaVdZNTBscFNjb0tERGIySy90azBNM0pscmdvTDU4cHNrTDMvalN1TTV5?=
 =?utf-8?B?S2Nuc0hydW0zKzh1ekhxYWhSajBHMU9qekNCQW1YNDV3dy9qaW4xcFh5MGdv?=
 =?utf-8?B?My83OGVoN1dVTHF1MkhTUXlZdmtsVENJN3JIUlFHeGdUZnAzejdqRWZCanBK?=
 =?utf-8?B?TjNSc3MzbzV2NGF0bjRSUDd6NTJJOXV5Y2RBNFhvOHp2RW82T0V4dlhRU254?=
 =?utf-8?Q?ByjBK+Yf4P3mG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJUeElEUjNhak5xN2ZlZUdWNFQrbHRGZmtzd01TeUwzWE0yM2JlVWN1Q2tK?=
 =?utf-8?B?eWJUaVp5WmROTjNCSnNYVU5KeDFIc1FLRG1RK2tmT3d0aUtsWXVnYk1nTGNW?=
 =?utf-8?B?OGhVcGhBalJUZ3k0eGVvekk5dHQ3cEhpdE5GbUdlR3kzbVRpV0Ztc2VwQ3NK?=
 =?utf-8?B?RmxvUWxxYlJ1eUJYUFBtR0p2Rmo5dDZ4cVJCYWxsVCt5bWg2dGRWYWlvYnph?=
 =?utf-8?B?K3FSL1R3NnhYU2pJUk5SU2F2cDBGaE80WXhXQnI3RTd0M2tTcEVnR2J3bmR4?=
 =?utf-8?B?T3djOUJ0RG1VaVljYXNjY0h0N2hteXVnU1pBL2ZXTTJCdUFNVW16anhUejRN?=
 =?utf-8?B?VGpZOXVvd0dwaGJUQSswd2lJdFNuSlhJaUdyRVkxQ1dIUmFic21HSTk5QlNz?=
 =?utf-8?B?UXpOR2xBS0J1SkdEb0NFTHBsMVhBbzRPK1JIWnYzNjdoVlZlNUtFSzdIVFkz?=
 =?utf-8?B?cWVBSzZpUVhRN2I5STRpMWZkN1pJSUxEN0ZBdTZwREFXRVZWeU5INlhtKyt0?=
 =?utf-8?B?cjRuaEJYSXlpaGYyOEYwMElhenovblFvUGRnZHJWQnpZcmtOc1FFbHlENzhx?=
 =?utf-8?B?dzJUdG5Ea2JCSUFna2t3b0c3ck5YTWF0L3ZlQXRuSXNaQ1JyKy9jckdHSHlC?=
 =?utf-8?B?ZTZwY0hMNG9WK3ZVQldnY2c4M1FKeWMrNyszSE11Mnhva2V3TjBIU2VRdUFN?=
 =?utf-8?B?OFNBdnJhd3VWaGJwcVhEWm1NOG8zazhUSy9yaWtzajRrcHpwMWxmNWFjbzZv?=
 =?utf-8?B?RlRIb0phSkpra3dCUWRHTkFSZXZhNUo1LytLZ1FyVEFZYlN6SzRsb0t6bjRj?=
 =?utf-8?B?VGhGMjJOQ3hRZTRBVm80dmhYZlpUaXdKWnhJczI2NXVJLy85Q1hPU0dINU9l?=
 =?utf-8?B?aVJDL2JyOGdNV2NrdEpJdzduYjh4K1p6cVBsRWY5RzA4UTA1ZGszbUVTekta?=
 =?utf-8?B?N1piZGxsM3BMRnRTWnRpS1Bvdk9kUHJjMWpPREpFeER0STdFNUdERDBDdnNB?=
 =?utf-8?B?bDhzaWdVMEY3TVpyMGJpMnBhblA4WGNRdmhMdlBRSWs5dkVvT2V6YnhLYXlH?=
 =?utf-8?B?dThQWlMvOUM2dDV2WExLTTRGOVZ4blMrUGpTOS93elZaeHRFcjhsMjd6NnRX?=
 =?utf-8?B?QTdQTlg1N1o4R1YwSlVsRlRnTXE0dGcrcGIyNkJMekFlWjlDdmovNGhieWh1?=
 =?utf-8?B?R3pQOCt4S2x5SmRMeHlSU3gvaVdldnkxUDYzcFU4U0pMekFaRHVmWjRJK1J2?=
 =?utf-8?B?bWV4ZmdidUk0RXVpNFpBcURzUXVERHRBSk9MeDBocy9nTE5mVXVZUEJGK2xy?=
 =?utf-8?B?MDVBNVpNUTdUWWdrd1czempydk4wNTIvNnh4SHdnaklnQ3BXSWVzNGhuT0dy?=
 =?utf-8?B?eGp6Y0xZM3ZXb1d6MDdaU21JSDh5SU9FMWl3Y2hjZm5kSG8xMlNaQmozMXNh?=
 =?utf-8?B?V3pVMkVEd0JCaHhlK1EvV3BaWEsvNnJUcXB1SFdHMTliRlZ0cktORmk3SVZ6?=
 =?utf-8?B?S3dOdHpZc0l4RzltNktPQXg1K3VicFFYWWsxcGZVMXk5elgyWG03ak5LZVJv?=
 =?utf-8?B?RVQySHFRTFhvQXM3eGZUb01HeC9CZHRWTjd4MGt0VlJkM3NCK1FZeEZ6ek1m?=
 =?utf-8?B?RCtJL0RtZVhtUmJ5UVNVNEp3QnB5YUNUS1UrcHJKK1pkOE0wTlRpNlNjYm52?=
 =?utf-8?B?WjR1UUc2K1BORkdvSkRyNUNITFBKeHMzT0dUczNLYUVpVnpOUWlSL1RtU0Ry?=
 =?utf-8?B?amdaZnArblZFaGZaKzZHMVhyRnNGdlNtT002dXJVYmRyekt5NTQyVFVqdFI5?=
 =?utf-8?B?K05JVXpVb1FKbFVEdWFuWEEvR0gwWU1meE5wVmZkaEFXeXR5ODJrREJzckdR?=
 =?utf-8?B?TnFvR0RLeW9yL2NkK3hrUlZKTERoelB1ZUVSOWd6UVNOYVB4MktaeDd3Y3Ft?=
 =?utf-8?B?Y1J4N01rcmQzbUFNbG1IaXJ2bng2R2toRTFuUllFVENubFhFMnRaUVRYYjFk?=
 =?utf-8?B?YUVBbUxZcGxNNlN5aXR3WVp0V1RvM0ZqZkVTeEd4NTVESnJTRU9qQmZKdlFB?=
 =?utf-8?B?d1d1TFNiSDc5MDlXOHRyOUw0cXVTWjlJeWNuUHZsa21UeWtBSW5Xd3dYM2dv?=
 =?utf-8?Q?hlgvMYefigukalktHUO39Si0P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfeaf69-dc89-4207-4cf4-08dd66f224d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:27:14.4697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL9T5YAjRK/JXMInpd1bL0CEPjUoFimu4rQABihSdP8O0IUYRJmui3zf9QXuBcXB0URL7fUb+RgLNmKZ6qzXyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
Received-SPF: permerror client-ip=2a01:111:f403:2009::60a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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


On 18/03/2025 11:54, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> "hw/vfio/vfio-common.h" has been emptied of most of its declarations
> by the previous changes and the only declarations left are related to
> VFIODevice. Rename it to "hw/vfio/vfio-device.h" and make the
> necessary adjustments.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/migration-multifd.h                      | 2 +-
>   hw/vfio/pci.h                                    | 2 +-
>   include/hw/s390x/vfio-ccw.h                      | 2 +-
>   include/hw/vfio/{vfio-common.h => vfio-device.h} | 0
>   include/hw/vfio/vfio-platform.h                  | 2 +-
>   backends/iommufd.c                               | 2 +-
>   hw/vfio/ap.c                                     | 2 +-
>   hw/vfio/ccw.c                                    | 2 +-
>   hw/vfio/container-base.c                         | 2 +-
>   hw/vfio/container.c                              | 2 +-
>   hw/vfio/cpr.c                                    | 2 +-
>   hw/vfio/device.c                                 | 2 +-
>   hw/vfio/dirty-tracking.c                         | 2 +-
>   hw/vfio/helpers.c                                | 2 +-
>   hw/vfio/iommufd.c                                | 2 +-
>   hw/vfio/migration-multifd.c                      | 2 +-
>   hw/vfio/migration.c                              | 2 +-
>   hw/vfio/region.c                                 | 4 ++--
>   18 files changed, 18 insertions(+), 18 deletions(-)
>   rename include/hw/vfio/{vfio-common.h => vfio-device.h} (100%)
>
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index a664051eb8ae03bc41cb7f9362ace840f41066ff..0bab63211d30cef04c50e50b3ea57840915ffc2a 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -12,7 +12,7 @@
>   #ifndef HW_VFIO_MIGRATION_MULTIFD_H
>   #define HW_VFIO_MIGRATION_MULTIFD_H
>
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>
>   bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp);
>   void vfio_multifd_cleanup(VFIODevice *vbasedev);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c84bba81487136d205ca30049c812d00e832c377..d33237c275551897164878705d44e7881c372ab0 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -14,7 +14,7 @@
>
>   #include "exec/memory.h"
>   #include "hw/pci/pci_device.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/queue.h"
>   #include "qemu/timer.h"
> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
> index 4209d27657c1fbde44c160445396bcab3f3fd2b0..1e0922dca11e6caada08c2aae82bd3462ace35f5 100644
> --- a/include/hw/s390x/vfio-ccw.h
> +++ b/include/hw/s390x/vfio-ccw.h
> @@ -14,7 +14,7 @@
>   #ifndef HW_VFIO_CCW_H
>   #define HW_VFIO_CCW_H
>
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "hw/s390x/s390-ccw.h"
>   #include "hw/s390x/ccw-device.h"
>   #include "qom/object.h"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-device.h
> similarity index 100%
> rename from include/hw/vfio/vfio-common.h
> rename to include/hw/vfio/vfio-device.h
> diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
> index 3191545717da51abc41d10cd3646cd047b4a676c..256d8500b70a2e985e975b0895e3cfca435ed8ed 100644
> --- a/include/hw/vfio/vfio-platform.h
> +++ b/include/hw/vfio/vfio-platform.h
> @@ -17,7 +17,7 @@
>   #define HW_VFIO_VFIO_PLATFORM_H
>
>   #include "hw/sysbus.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/queue.h"
>   #include "qom/object.h"
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index d57da44755be3d7fdba74f7dbecfe6d1c89921ba..9587e4d99b131e88674326a5196cfd2079560430 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -18,7 +18,7 @@
>   #include "qemu/error-report.h"
>   #include "monitor/monitor.h"
>   #include "trace.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include <sys/ioctl.h>
>   #include <linux/iommufd.h>
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index c7ab4ff57ada0ed0e5a76f52b5a05c86ca4fe0b4..4fdb74e33c427595a9b0a4d28b2b5a70df951e4e 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -15,7 +15,7 @@
>   #include <linux/vfio.h>
>   #include <sys/ioctl.h>
>   #include "qapi/error.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "system/iommufd.h"
>   #include "hw/s390x/ap-device.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index e5e0d9e3e7ed124f242b3eda345bc973e418a64c..a40169bc85e51406822247f5b3ef6da1f7f92881 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -21,7 +21,7 @@
>   #include <sys/ioctl.h>
>
>   #include "qapi/error.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "system/iommufd.h"
>   #include "hw/s390x/s390-ccw.h"
>   #include "hw/s390x/vfio-ccw.h"
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 83e83ab9e67de8b004dfaf0067e4c466a6c88451..ace9de18103e8c1ed9f7a51adbf16c36be01bd7c 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -15,7 +15,7 @@
>   #include "qemu/error-report.h"
>   #include "system/reset.h"
>   #include "hw/vfio/vfio-container-base.h"
> -#include "hw/vfio/vfio-common.h" /* for vfio_device_list */
> +#include "hw/vfio/vfio-device.h" /* for vfio_device_list */
>   #include "trace.h"
>
>   static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index e88dfe12edd6dee469c06ee2e46ab9c8b5019ae7..e300d2d90f2fbde329609b7c63245c523766fb60 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -22,7 +22,7 @@
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
>
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
>   #include "exec/ram_addr.h"
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index e1bba1726402f41ee394f25b6e613d27f44b2a2c..43b99680f6d7db27c4d7e518520aef5ade2ebcf4 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -6,7 +6,7 @@
>    */
>
>   #include "qemu/osdep.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "migration/misc.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index e6a1bbcda2297f9e6272fff9b1c228b6772457ce..0d443b53d23d392729cef84e419d3e089fe64298 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -22,7 +22,7 @@
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
>   #include "hw/hw.h"
>   #include "trace.h"
> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
> index 447e09ed84993e3fbe1ed9b27a8269a9f0f46339..143cc5cf62b0165565e91f8a2ca166026f16b1eb 100644
> --- a/hw/vfio/dirty-tracking.c
> +++ b/hw/vfio/dirty-tracking.c
> @@ -22,7 +22,7 @@
>   #include <sys/ioctl.h>
>   #include <linux/vfio.h>
>
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
>   #include "exec/memory.h"
>   #include "exec/ram_addr.h"
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index e99d312a9f5c7462644ea3d0de2e9de38979f851..b7907aab80f8adb308ebae60baa20c911d9393d7 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -23,7 +23,7 @@
>   #include <sys/ioctl.h>
>
>   #include "system/kvm.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "hw/hw.h"
>   #include "qapi/error.h"
>   #include "helpers.h"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9335a17920b32dc2bf9cb4eeb2b8f57382f14ac8..7f354d86cd14270a70dc990860ad5b69f0310719 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -15,7 +15,7 @@
>   #include <linux/vfio.h>
>   #include <linux/iommufd.h>
>
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "qemu/error-report.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 285f9a9a18dd8f0847ac5ac3fdaa304779a2d0db..1ba703e595db99f3786bfc1a2edeb0e061f9e01b 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -10,7 +10,7 @@
>    */
>
>   #include "qemu/osdep.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
>   #include "qapi/error.h"
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 6fd825e435bde96d1008ec03dfaba25db3b616fc..338fafb83f41460e0c244dcc27524198322eec67 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -16,7 +16,7 @@
>   #include <sys/ioctl.h>
>
>   #include "system/runstate.h"
> -#include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
>   #include "migration/savevm.h"
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 87bf5e046a432dfedf3be3c1c7e8f33e006da004..ade4466eb622248b5aa50f9df7e5c683bfa78a11 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -22,8 +22,8 @@
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>
> -#include "hw/vfio/vfio-common.h"
> -#include "hw/vfio/pci.h"
> +#include "hw/vfio/vfio-region.h"

Doesn't the above belong to patch #10?

Thanks.

> +#include "hw/vfio/vfio-device.h"
>   #include "hw/hw.h"
>   #include "trace.h"
>   #include "qapi/error.h"
> --
> 2.48.1
>

