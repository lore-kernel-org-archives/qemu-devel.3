Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90109C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wemLx-000250-0j; Wed, 01 Jul 2026 00:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wemLp-0001xM-QD; Wed, 01 Jul 2026 00:15:08 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wemLn-0007qb-V8; Wed, 01 Jul 2026 00:15:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd08cfsr0vadcRIDA5F+z3uuI/zYb0tYmutL2Oqmsa0LJrRobHRgn4UHfhjVFd6sP1w768y8O/a9HRQ8MXXjIEtCRjbOfDnDK16njJJQ+RY5a8Tmg6VHZlhP9zOaOLWaADwN4h51Fnx40lKmUP9ub+HRFxTPSrhHPyvXUEKIP5a75WmEYODvgm4elIAqZ5OlhpNjfgj6Vx8vka2gNshfVFNnS0lCEj1YRZ+S2xD1ikGoFP5hHBUJA1FmXM2rF2rbgkTuv2BO+fw8pS7h/vluVLmYZIH0uT/fSrjxjleE1t/o+MKWsHCzYUt4dCKbg23pENqyAPa/I+mdtATDsBNwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldm1KDBf5v41eA1z6RujK166ms6OAHZNcFrDfC0O1rM=;
 b=sw9xbsVz4J0jOQBltXSDCLPYCWEWRUx1ZOVVIxDW879TjdpPmecqOFAyhXmnWvMsR7/uadi8yeVzn4BcXJTUdWo6Fhdbj5BIQkrb5xfdfpSxH0cw9jO0D5t8OxsfMF+z9CAAvkhaNJ7eT1JJTUo7EurdtDt4+mxXoC+nUNNVkjNLZq/9lSRFPU2EisLNuCFA0f9BdE04mxwoY/fm3hRjXFkh6ez7KJNjzmn1JD9qSUn0HAwKluIoFa8TV3qHtZoZJRuy/2Sdri4HvESrosDdglge/1qORJAP15j/VzYasVqvFuzhztIRR4ontiZOgrEA55shoYRBGz3GZGgMV0fmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ldm1KDBf5v41eA1z6RujK166ms6OAHZNcFrDfC0O1rM=;
 b=RmBnrP9d0F25DA5Qyxd+eiA+b1Dh7lujq2BSWhBpN3VLUrgHNG8uvH2K8f5iVaWVf3GoKa9wu5AN9rTO1BEb/BnWwYDWyusqJYmEcJUeQRj8/7WHUw0JpKolfr7pf7DoMlptbtDvgJlMoV935jjK9Z0yzQvl0rByLz0CtgmtotVFgvn6U2jWq96PwXCwiohEmeOvxWV9TQ2TSyh7iq7Qp7L5Vsi6v1KUQ0KBgcA5JNuI38EFtkiew7qpP1SJNZsEEh2PcLslWSRWDBAUz0NDOxUkhiu42wNYnpP+0qSbsG8UvVgY4NwT0hYIOzH+LugIHbwbrVxIi+gKI/dmXHeqeQ==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by PUZPR04MB6650.apcprd04.prod.outlook.com (2603:1096:301:11c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:14:56 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:14:56 +0000
Message-ID: <SE3PR04MB89225EB40A26B834C7420868F3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 1 Jul 2026 12:14:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: always fault with SADE=0 and A=0
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260630211044.82894-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4PR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::14) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <5e8a495b-b1a7-49b7-b3d6-9bde94e63608@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|PUZPR04MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 590e51c1-3ca1-4391-c4ea-08ded7274f12
X-MS-Exchange-SLBlob-MailProps: 8U9+OAG/EBKkI8GgeR43xRMrZ/+qH0EFHkHJjsqZQflYzL8gzDvG4SQ1kgZzjj3zK09de+1IT7a16I6SM3yoslD9TiyUHfyyJo19IYYk8nCRs7BxGOtk03GtJoHt9RCjVPwCvyRpzcSD+4l1TSRNDur0cJ5N4qVpkU2+iOiP7bKeN9f0HZD6QUOV2G9jYvSj04ARgqoZMuVx5pvzrY/BLM0icrx4WZzslUHQ3tazoZbh6RupBtroLfwuS1Iq4lr7CppWm+mfED84Cijj46CDY87LNCvPQmJdAQVAf6R+/MMUss3OlmPNZLNyAbd6zEX4XTpPeza5Cykg3Nt5rbkTTe7gogdqGcxHw2K2UPQiPq6ZMQVCKI/xQaOc5UAGx4DBiOFT1aNkOKd+JOFUoL6W1F0qwErnvbxClMFDhg9hBQPMPmVMrAYUQOmtK45SIT8wMBfeALrEvMOUTPlR5Kn3YT0tR9mGysVHipbV9M4xvYZ4l5oGN3cAY/RNMXcrxObn5vQPyW63Ov5Ps65zoEmYe6fzARYLxu3kJBRreqDhNVA0L5ftQ3IpjnBrM/nI1PX0plNbC6PxVIYSZNfVptzPRfjap/XmoLkSMGxFeh+m05HA287h6+wY57oA/7TEpC8NC/EmzCGxQzlgEW7loMF/mgOL5zdCBTG1OMVWKrufgquC9WcYOolR34it41C8JVpnsYsOBe4BtWO2nE84C4oImuyuMLMdbwmWITFfRaIepl29seieJDGJYDrURZN8d55KHdCuLgJnvUpXDU3rXVTe2i7/Ph4fNgl/4ltArHDCW28XZcYSfIbXRO4COcrYcD9AoEv5AjiAOvySv6E7tNfE2A==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|20031999006|55001999006|39105399006|6090799003|15080799012|23021999003|19101099003|5072599009|24071999003|19110799012|4140399003|8060799015|25010399006|12121999013|22091999003|24121999003|10035399007|440099028|4302099013|3412199025|26121999007|1602099012|40105399003|35041999009;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajZSNHF2WmRwSWU0ZmFrRSszbmJNNk93blNMaHorS2dYTGtiSVdjV04rUjFs?=
 =?utf-8?B?QW5hNGsya2s1Q05Fa1BqOC81ZER5T2x4UWVHZEpvQko3dkhRYjFZQVQ1a2Ix?=
 =?utf-8?B?V2VLVmVvcjFpMnkxU0RvY1pGYkdHaXF3R1JvK3JLclNzWmRlY25zKzNCbFRQ?=
 =?utf-8?B?bk02NklBUmNvUy9LVXZLRHYvemQ3NXZuR20rWnM0dFdKTHlidlVSOGNWNWcy?=
 =?utf-8?B?SHFSSEp4N0hTZUcydW9wY2lzQjdNN1VJeHVhS0JBcEhrb2pqMCszM0RuQ294?=
 =?utf-8?B?ZHB3Y1VySitZeWNZbXVzSzkzZXUwWWQ4MXlDMHB2NEFVYlBUSUJ0R2NHZmdN?=
 =?utf-8?B?L21ueGkvUnBuUHNmT2JoSkZvcjFpOFFrdDl3bUwvVXlIN2twTHAwVzhjY2VQ?=
 =?utf-8?B?QzI4cGZTdG00bzhoUEQ5cklBeitFTXo3WEM2cEJsbC9MdmY0akNzaDZiU0pM?=
 =?utf-8?B?QXNhUmVQL2dENi9nYnl6SnExSGtTdWZmNUZYeEZhU3pLUFltUXJTdXhwcmxJ?=
 =?utf-8?B?NG9NK3dxTkc2Wi9pSUFYNERBOEhZdXRVZ0cxMldhcWN0eDNBSkt3THMyM2Q2?=
 =?utf-8?B?WFo4OFkyRmNhbm9iU2srVExmRDZ5NnpsLzQrd2JUYUZ3bkZTZ0FLUzBSd0lm?=
 =?utf-8?B?aWhWbURIZ1pzY01NWHRoYllmRVh5UXZJN200TnRUUnpZTnY0dWFHT1ZqNXhH?=
 =?utf-8?B?cmlDQThpQlI4dmZMUXJWK1c1RFBPeFF0WG04OXYxZHVXNTR0SnNxMk1oSFFD?=
 =?utf-8?B?QWRyV2poM1NiTkJnenV3cmdUWHJ3QXZnTFpGaHgzWUVmZHVndUV5QkJDdG9U?=
 =?utf-8?B?am1FdmhYOExmU0JGQVM4aExuT2htSk5Ray9YK3RrelhuOTRCeGc1L0RHci9q?=
 =?utf-8?B?Z0FJaVRBR0hxbHJYWW1uMldQSS8rejBnc04wRHp5QVIrU3FDNWZSb3RQM3Ar?=
 =?utf-8?B?aDYrU2hlNmo5MU1RbG9neEdyMTU0cjA0THpDeXN5RksyTzRGLytDRWVFNUFq?=
 =?utf-8?B?WVNPWmJLV25yUUEzTEh4SndIL2RTR3F2dVBMTWZXVjNyckFIUFpIT292dmpC?=
 =?utf-8?B?TW9FaFdZUmQ0YmpiWUorU3ArNzVBZ3NGcEdrckJ2YmRmV2VxU0pQWXUxYy9S?=
 =?utf-8?B?WHJVM0hKTnRiOVN5Vis0QmRmSXRsM0VOUU9ScjhGb2FQNFFhQjhCeWF1ZDBT?=
 =?utf-8?B?eHdZSU9PbWgxV2pYQXQxQW9SRWVZVEtLeFFWczlhM2JPR1NTNy9XTE5PZ0RN?=
 =?utf-8?B?STExZFJ3NDM4Mi9xcjdEMXVieUV0MnRodlN6K0xPM2grUzFSclF6UFJRUmEx?=
 =?utf-8?B?a01uWVRqeXU2VHFWbXBpVVBtb1BsK3RPbWsxMzZHamJxaVQ0a292eEViTDlp?=
 =?utf-8?B?OFVPekdsRE9jWXZqTDROSlZuUjZwVTFjVGt3TEhxNC9XWWVLN2d0MDFHVmJX?=
 =?utf-8?B?WjVudklhRXBDUXYxNE85bnZFR3NvdzNLdEJoa1BwS2dQK0xUMGk2NE4zbitm?=
 =?utf-8?B?ays1cVVGVlJQdTBBL0hva3hKQS8yN1hPVkdGM2RZd1NPZmsxNy9DbHRQUHVB?=
 =?utf-8?B?UCtzVDcyNXZ5OW9OdTRIY0dPWCtVTzRaYTY5TDYxRTNxeTY1bkVRbjZpcnZ1?=
 =?utf-8?B?LzhzaHplQy9heUs4WFNBaGxndWN3RDdFZjRjM3B6aXZYa1dmTWRJalAySTM2?=
 =?utf-8?B?RDFwQXdmSnlCdHpLSnM2TGF4dEdkUUFtM2hTWTNHT2oxVW1rK3RkZUVRZTYy?=
 =?utf-8?Q?kIHf6CLi1GhOp7H6+KOiu6sXCRU0d84RKDPMQAP?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9zbkZ1QmZydXhyN3hCMWthaGtnTFFNWWI1L1VDYktZUjhFNmZoMkNZZ1pD?=
 =?utf-8?B?dlYySXp2WmV6WGxEQ0Q0cmJlSzV4WEx5dzc4Y2w1VVVtR1ZMQUdrckxkbXIr?=
 =?utf-8?B?WEdycmJzMTVZS2dOUXAxVC9UQU83cVhER05BQmUxbENYcHcrZ0F6dHJhRFIw?=
 =?utf-8?B?enVuYVVycE1idVBGNWtab2ZncWt6T3dLZ2lwNFBKWUZYdUZaVzNIcHBXY3pP?=
 =?utf-8?B?M3NlVXRlaFhhODBCMlFnRGQxR0lkeWtSV1pHNCtnbGxIT2VGTjlVMjNyRStT?=
 =?utf-8?B?U3g4VnNFUWtkRkZzVU55MStKclhkMWNuZEFzU3h4RG9TRDVNNnJlSTR4Z1R1?=
 =?utf-8?B?TThTck5taDY1UzYxYWpENkxYeDhuMEhCVi9qRzIzMWFpS2NVOXFqRko5Qmtu?=
 =?utf-8?B?WU9ldUdSaG4rRmhZVGZyS3RnNytIem1ucXN4M3gzZGhMVVhNcHdTdHIwbVVx?=
 =?utf-8?B?V3dWMHJrZmlnSGxnMmI3Y1EzcUhKbytCY0ZYbjlwcXlsRkhEbnRXUS9nZWJq?=
 =?utf-8?B?MjNTdUZWVnFudXhqbFpjcldiVG45dVgzeU1ZZjRTTkFIRmxya1RrTVJtVTAr?=
 =?utf-8?B?eWF4RUVUWUpZcEF1aHZuRWNoang2YTJDRkRxUGxyOVl0SC9jUEJ3SnA3bTFt?=
 =?utf-8?B?aWNmSHBjajFyRTQzYldkRlRpU0JvRlRXNGtPb1U5dFFlbkM1cUtnTmlFT1Zx?=
 =?utf-8?B?VHMrdUNlanNodk5xZWxaanBpd3NVdno4NDdrYlUyK0ZjY2lVNnhZUEVDZURD?=
 =?utf-8?B?WUx3R3M1Zk1VeDh2ZkhQTWdDTEdrWlF6UVN4RHZOZVFjWG5kS1dtTlNlR0Zj?=
 =?utf-8?B?cXFHREpYODVPZXNMeEdERG5ZVUhUUThLKzVGcTVTRGd0cG80WFJQQUo2MHdS?=
 =?utf-8?B?aktpTGxKZUZQaWJyQ0tFOGwwK0kvQWo2aS9wakpPa0orZlNEQTlONVRYVElI?=
 =?utf-8?B?QSt1VVQyUEhHUGo3N2E1ZGNBeE8wM0RvSTVpUlNzb3Q1TWdkUHZqdEJRcDZF?=
 =?utf-8?B?UER0UWFLUThNQkRSYUNIUEpwSm1XMCszTFhWZFU4bkNSemtNUHhhTzg4U0x4?=
 =?utf-8?B?Q2lhWmR2cy82bm1uTlhLcVJoVmh0TDBGKzNMWkZxNlNyQzJVMVRpbVFZbTVD?=
 =?utf-8?B?N2FZQThtMDFQaGY5d1BwTHZaS0QrYXlCMkVhSENGZ1EwL2drSFdpMVhkdEFB?=
 =?utf-8?B?S0pHeC93NTJQTDF0b0VPMzhYV3c1ZHpxSjdDOXRlbEN2TitPZmZQb3ZqMkpm?=
 =?utf-8?B?N0E3RDJFT0YzK1k3WVk1cXcyUXc4ektkdlZ5cjRybTBoZ05rMHpQeHhFQjRZ?=
 =?utf-8?B?Q2lBSDhCL0JzcEE1QzJMTFRNOFE4ZS8rY2JWZ211akRIdXZJOS9DalI0cC9l?=
 =?utf-8?B?amloNXN0N1hiaDJ0L3BFNzF3RW5uOFU5R0tnbUxhWUNuWDN6TkFNQ3UrRTZR?=
 =?utf-8?B?aEhzUmlmQzZobWxvRUZkYk8zUGVyS1pXS29BcGZjeHhPS1N4U3NyYWlDaHZw?=
 =?utf-8?B?TGJGc1VKcVJZd2NpcHBMZ1ZkWUVudVJoaW9EZW9yWFF0QjU4OVNwc1ZpVlJ5?=
 =?utf-8?B?WDN0YXdQaE13eG13Z3pqY3J6WkYzQU9VajRTVExValVhUXpRanBIZ0laWjZl?=
 =?utf-8?B?dHRnejFRYnAzbmRrWXBrNWc2bEZzMnNhd3ZSbUQwaEZNb1dldEJOOWtqeG13?=
 =?utf-8?B?dklReHdlM2tCdVRpOGJrVndNbEc4aVFMQ0NvUnNRd2NhSkdrazFZMlpQZDUy?=
 =?utf-8?B?VFBJYnNSRFhrc1dBSllZUTZWUFFvaWk3QlVyZWc2UCttaHljcCtWVFlHV0Y1?=
 =?utf-8?B?ckdsMmV1Yk1zWEt3MUVhb2taZyt4dUExU25rbmI2RzBabmhCUTgzcmI2RzF0?=
 =?utf-8?Q?wFwwg6ugYZdPE?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 590e51c1-3ca1-4391-c4ea-08ded7274f12
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:14:56.8331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6650
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 7/1/2026 5:10 AM, Daniel Henrique Barboza wrote:
> riscv-iommu spec: "If SADE is 1, the IOMMU updates A and D bits in
> first-stage PTEs atomically. If SADE is 0, the IOMMU causes a
> page-fault corresponding to the original access type if the
> A bit is 0 or if the memory access is a store and the D bit is 0.".
>
> Note that SADE=0 and A=0 will always cause a fault regardless of the
> original access type.  Right now we're faulting in this case just for
> reads.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3551
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/riscv-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..70eede3f14 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -480,7 +480,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>               break;                /* Read access check failed */
>           } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
>               break;                /* Write access check failed */
> -        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
> +        } else if (!ade && !(pte & PTE_A)) {
>               break;                /* Access bit not set */
>           } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>               break;                /* Dirty bit not set */

