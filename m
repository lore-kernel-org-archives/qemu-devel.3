Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14823606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=V0MijFMH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaJr-0003ee-1i; Tue, 27 Oct 2026 02:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLaJl-0003a8-H5; Tue, 27 Oct 2026 02:05:54 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xLaJj-0006ZP-7B; Tue, 27 Oct 2026 02:05:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/O0oqZRD1xvPathT7qMxSSbsy4xfbOAT0Sx8X/o1ZjiPT82kxpK6mb78oslT6klpWxExV5zvNp/eeZGfOvP9TJv0KePuVi5y8LQiVW+V6ulzmZ94Mr+E7wZRJouIdSzapOPA+ZwCEikTlXOyX3Ea12Kxieo1elKegn8IAXrDbWu6yQWIQ3xkOJ9sIfj5bquZV3OHYceKreFZN4y3AumZgiSmBcunu487Qho5A1e08glDuFtCFwSlZ7olPCD2KgLA6cXigWvVy5yr/CTIh46fUd258NfwGcz8WrL/8T6ja7d3mSpLxm0d8yHwo+1bhTi9eHI8pmqAjhUvmuQ2cPtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+gp1089R4DteG31Cd92HSwv4zf9wxw9goE/6vIyn28=;
 b=jK2P4JfiweM1naeYpTIu/OxfMKCvMLq4yCQtkpA7vu04xFxBvCH3FTZzdI4tUwZ/eUIo3oYI7dlC6JqxPHoa5vzHysh+bzf0UAiHfa2RgzgteEcrnSFayQTY6KbrFYI0h/yQiZlMLpFNX8HHdTE+3SX2ITQfe+cSbJ+b1irCYR4eQ4II1u9A0g0Mi17FrIsqkr41qX6FvmBTxaqpdEsalDeCGWIOLsf0SMgLtlYFmoosJkHElC6CVCD1Lc7Fpj+6aWpvz50pkIM8T2krDv2I2zng6Ip1dboZ6o1bfffizUrnpxVlEln7QLvqs3hUuKWx63eUnYmLsmm59piXV7K25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+gp1089R4DteG31Cd92HSwv4zf9wxw9goE/6vIyn28=;
 b=V0MijFMH41wkXdGO891KEck3Fiz+5F5Fiy9XQJCVtm/yzhl7o6fccK7METoR/iade6CmnVKfeAVyTgSa6AohAGij+PPMPu3VLQxxjdxLy3ExYuQezqz8HiFB5yGUbJeFNtCky9WiDWlW9ZRfabm4J2E3ftDvJ6SKBxVE+abuMT1ZDE6IGn7SiWAIwIPjWWrACTi3ukBc4HWvXTjKR4kftO3fNPf6C1IcEVEL0RzF3ScHtjM4rI3W3q6zMomhNTRlC7BsaLIHRq7pE33/LepFarCSH6bBq3OIo4oU/ZOcLhvlvzgEgXNQQa8VM8qhvPH0OAcAdLWKziE+n8kr7M5Ixg==
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com (2603:1096:405:40::7)
 by SI6PR04MB8307.apcprd04.prod.outlook.com (2603:1096:4:23b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:05:42 +0000
Received: from TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230]) by TYZPR04MB7491.apcprd04.prod.outlook.com
 ([fe80::a450:2576:3b21:6230%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:05:42 +0000
Message-ID: <TYZPR04MB74913D9F1DDD9D1A45F1BB3EF3602@TYZPR04MB7491.apcprd04.prod.outlook.com>
Date: Tue, 27 Oct 2026 14:05:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] hw/intc/riscv_aplic: Add in-kernel aplic save and
 restore function
To: Wang Yechao <wang.yechao255@zte.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Xuemei Liu <liu.xuemei1@zte.com.cn>
References: <20261023021237.486091-1-wang.yechao255@zte.com.cn>
 <20261023021237.486091-3-wang.yechao255@zte.com.cn>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261023021237.486091-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To TYZPR04MB7491.apcprd04.prod.outlook.com
 (2603:1096:405:40::7)
X-Microsoft-Original-Message-ID: <f1643370-19c1-4dbc-acd2-92d496d95d1c@hotmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB7491:EE_|SI6PR04MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: fb22a66d-5738-4b80-cdd5-08df33f05535
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWTq462A1ci1xfPBdi3ebdlvjNcS0rjulL3xUSeQPWKInJbEoRvTixMPpfRaCJwQSO6bRdzB/mKcqppua5jtDsLr/JLixT9+9YsuveJzM72pOxWK2Nx3fd+1AY7UgYxz0r0ayxz0TaKEN++ERVQOVWci5SOq84RRnfpjOpXlA4BmGYDrv+N50VcVMyd0JqQJJF9qJ4aTEsCQhxjO31zMy4rjK8y3NRCXPo9WHT8wFLJ9OzCpLjy2rHSuxL4y1PZBZNCgrM9eS/14X9UVMKEbk0vwT8fVWpPXMHmfc2q5Aw6z8i5Ollg0dH/1RobzWMvx5VKx/u8Zk38tSIUZ1xy+PHM2m9D5Ii+jOwScTq43g8hew/Di/oTxtkkFAun4Q3vZAl6q7JRGR/oNA2JpA/fhZnT4bYNvD7xb5AjyDxQxpqiFRQZ4EHLaY/DNkDBNZnR7yGQgvM81iLOwKdFBgg2arK4HDeQuKrph0z03p8QOMP85/jZbeeRJDNYC97NQMw6JobrhJVzsNnQqjSuKqjihj/uWSZRsHQk7kiN1VFKXIQpzM93EPiOtRCnhhN0eiWGyun2Ec2wLHibsLX5V++YroLPoXy3OIjToTKFiaPEBezZvK9jPppbv1R8r9JZ+YzCeAvsZ92/8+BP6nmcT8IV3Pmv0Pwj2uqLnWqcAaX6uY3L48SrUVeOBvNaFBiCfAwY263B+rwpzT96Ull3NL8g7XyrEKuECoddD3xs0wJNRAg/kVxwLZXRoA0VTGkoA3ZwRJXFWtWJAAnmoUgsEuQE2RI15p471I4/R7U=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19101099003|55001999006|19110799012|41001999006|25010399006|4140399003|8060799015|22091999003|24121999003|6090799003|51005399006|23021999003|5072599009|15080799012|40105399003|12091999003|11031999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzhXcW9SNnU4SVNFSU5SY0FZWkxhVnBmcnh4azA3akhUTXlGb3o0WXhvbWFF?=
 =?utf-8?B?bXRxcmZZUlNFYXBUaUJmZk9sY2dzYkdjUWV1N3F2Z0xnR0h6UHNMcWpPNFFQ?=
 =?utf-8?B?NjloMjU4blRSOVlDUEE3blJ4OG9QbmY3bEtXeUNnMW9WTkttT3lQZkNnSFRQ?=
 =?utf-8?B?MEY2YVpJbExvOVNIRWUxNFV5WVllMWgzMmpHVWVnenBpOGxOK0lxQi9WTW8y?=
 =?utf-8?B?bWlaK0s1ak1vakxyYjFXQ2RNTk5YN0x6Mi9leTBtOVgvS2hBeWxlbjZ4VmJk?=
 =?utf-8?B?NUY4UzR0dVBKd3hUT2R4cU1rYm1oclpyQmw4V2wzUmNWV3h0WlRsb2FubXVE?=
 =?utf-8?B?VFJxSVhGSnlXQmhIMWtQQkxNaGsvQ1N2SW5PcTI5R2h0eFV2emo2RWZndFRl?=
 =?utf-8?B?SEtoS2FhcDJVWlp3cE9hcFZmZkwzZFdiWE5tTlYxZ2p5YXFISWFML1hvRWs5?=
 =?utf-8?B?OGlmeDRWbWg2djk2RWp5UWR1UEpwdTJCUVY5WktObzBzS2xJZUMzSjJFdFY0?=
 =?utf-8?B?TVVTK2NwZkdlR3ViL0FzOTZHS1EzTzdiWW1iejhuaEVrWmlldUk4eU5hUU9E?=
 =?utf-8?B?SEp6bHFReHVhbE1Wd2NsNmhLeno0ZkhHZUUzL1FNZXFHUGRTSStIWnd5bXk3?=
 =?utf-8?B?MWFyWWN5cDBUS2JEMEEydGc4dTJxcGNhUnI5SkJHcndzTE1NOENaNlR4dUh6?=
 =?utf-8?B?WHFVREVUbXFCNVRGZDNlckNHUlN2MU5VUFFwMlAzRzcvYmw0cGdEOUpLZDFE?=
 =?utf-8?B?N2paYS9RQm9FandJL2VoSWo2dFgwNFMwdC9MYmFBcHk5NElKUnlOallpNVhN?=
 =?utf-8?B?Z0pTc05LbmFDUnMzaDFybEczbmwxVEdudzJid09nMWV1NjFvWmk5dmlEc3Zu?=
 =?utf-8?B?SDFkQUZCUzJHMUJsUVR0bWZ6eUZmUHQvTG5rTXhIWmV0MWdaNFVUbHBwOXF1?=
 =?utf-8?B?NWRuTG80YWUzYXg3Zmh4d0UxeGtEVTJKN0h0S3NKOXowMG1pNGZLMlZXWVhH?=
 =?utf-8?B?UUlrb1VqNFU1cFhMRGlkVW1LcStZV3g0VUorc0I2ODFKS3BBRmoyUlFyM0JI?=
 =?utf-8?B?SjlSMDJRV3NWV2QzK25iZUF3WHRqcUxZSExlblB3R0xXMWNuSS9qUURZSmZF?=
 =?utf-8?B?RU9SRVA1OGJ6UWs3b2RrN0Z1U2JrUjBTMnRTbmlJSW5rK0xwU2dpNHRzVFdQ?=
 =?utf-8?B?ZmZYbWVpZ0JKOGFobW0xbUFYMk1tK1JhT290RS9PRU1CenlNODcrckZmcWhw?=
 =?utf-8?B?Ym9kQlcvT0oySTRkTGNtWElnQlBDOG1NbFM3dTB4dDFleEh3OHorSU9PWGhW?=
 =?utf-8?B?aHpEWWxBTTAwd0x2NFpGWnRFRktKRTdCamdWOWNwQVM0MDFwNllVMEJXRitP?=
 =?utf-8?B?NWJMU0R5VXFOZDljc08rNER3Z25neTY5cEFvRVhvaUhRTkhEaDVZbkpUeEls?=
 =?utf-8?B?NDFxcGFOYVFPQlBqV2dQL0xqMWRJRFRMT0d4U1UzaHVheVlmWE9kVitOM0RQ?=
 =?utf-8?B?S2pjMkpUMWtJcktWZU9qSVA4Mk1ISWNORXlLN3BUSlhOQ1o4K1hOaFJ4NWUw?=
 =?utf-8?B?eGRoUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWJ5R1VpWjRsNkVRTE5ueWZXWDBlMU1aYVNsQmU5akc5ZTB4MmtpM0RUdmti?=
 =?utf-8?B?VE5YaU1qRSs2MW9pdythcmMxMG9ZUno3K2dVeDJPZlltalBLTk1tcmQyT2Fu?=
 =?utf-8?B?TUVVN0hDT0hla2lELysrd1dwMEkzNXVCWkcySjlsa3hCeWFoNFVNV2FXN28r?=
 =?utf-8?B?V1VXZUxYOWFBZlFrRjFPNXZtWXZwb1E4SUluR0dQbTVlWko3MGxpeTBCbTRo?=
 =?utf-8?B?TS9sVTJiT0haNXNpRnVxMEZnN0ttRldxWVJ6TGpOYmMxVWw5bjIrL09pOFp5?=
 =?utf-8?B?VEQ2WjFLcU9ZRkhpWkNIWDAwbjE4a24zNU4yRG5tSzJOL1VWd3ZEM1JIVEUv?=
 =?utf-8?B?ZmdROEJJZ3orVUpqa2hQRWQydHJpN1JmUVJueFMxMHN1UWtwK0k1TVdtL1NY?=
 =?utf-8?B?WGJrYXBxcmZWMzV2dmRaMS9zSlJxbElnWEpBQ3Z0Vkc4QlRxYjBJMmlFWjR5?=
 =?utf-8?B?ZkhpVWF5Zk1PQjhZeFlqVFl5ZEpsTFVRSG9tUm9JeG5XVFJ1bEZlYjd1ZUxJ?=
 =?utf-8?B?WFh2d2ZNNDhOVWZrdi9idmhyUmVBMTNZUWE1OWZqU3BXR25sYmxmUDEwMzlp?=
 =?utf-8?B?SjJYeGN6K3N1V1lkRkYvYWlHTjYwdHlWdGV4UldHQUowQ1ZEQ1hkZzluQ2x0?=
 =?utf-8?B?UHlJUEZuMkRMQnE4M3RZay80b2NnWFZlbmlsTXM3RkhZb2JtS1ArV3BUck5w?=
 =?utf-8?B?Q1dMVCtWRVF1VTZkd1hUS3IyR0E1dXRHaC9lSFhqdTdoRUpQMDNWdVJhRmV3?=
 =?utf-8?B?NGI0MFpQTXBNZ2hXSmRKMEtGUlVmNTREb0lBRlRjNktBZzZqZHg5M3FtUFhN?=
 =?utf-8?B?TW5EYXlrU3NENXQwVm9taStidk54M1BKQVdLSHBhQjI4NVZiZEw4NUhRRHE4?=
 =?utf-8?B?cUkxSjdBanJJTndwRklFRkNpa1ArUU9kSmhBdTRnS2Z5ME5uWUpYTDQyMlVZ?=
 =?utf-8?B?Tm9FUVFPMlQwWVlCSTFGc25MSVRTdVFvSXRmWllhQWU3NnNiK1BIQ1NuOEJG?=
 =?utf-8?B?eS82ajNqbDBaRk1TOUdGNndKb3ZTTUNIb1IyYUxHL0lhZi93UE5aUitES3Fq?=
 =?utf-8?B?Tmd2Y2FNaElOdFNyRGtWQnJldC9hTVJ5bGhKMzQ1R1FTcFFsMVNmRU90RDVV?=
 =?utf-8?B?eE54NnI1MVFYZFlPY1o1aWRLZDVXYkN2WUFUS1lLTGkrVDNFWDVKaXpiTVR2?=
 =?utf-8?B?akM1eDNDS0s4THNyR0EyN1A2ckVlM01NejdndGltZzUzSklKcitMc3NCYy9k?=
 =?utf-8?B?b3JxeVF0Y2gvbno3dnJIQkFRRE4rWVU3V3psQUFhb3hPckZTS29GajluVmVN?=
 =?utf-8?B?RGIrWEdiZXpEeE9TTGN6cHNmaDdiODIzYTk0QnU3eU9JUExBcjluZWwyNEk1?=
 =?utf-8?B?NU1LUzBsTnhsZnlvRU4rcTltdUpTeWhkYmE5STlKRm8xczZRT3Z0N3FiWWh6?=
 =?utf-8?B?L2JMZ2ZMeWlEcEo1Nms2TUp4SkRINDlDczZTRmhoa1BrVlQ3VjZpVHRnSHFE?=
 =?utf-8?B?L3BNampROEtDQjJCNjdSV2ovWUNyZEVHaHpocnM1bkJlbzQ2c1NHNTBoTUcr?=
 =?utf-8?B?ckE0MzJRSk9ZNk5ibmMyNVVmYkwvQk5YZTJIcWZwNzhENlJYdkxIMjJXYkpr?=
 =?utf-8?B?dEJRdHgxWUQ4cmxLVmNBeUJLbVowbnYybWpWaGM2SXo1Q0k4YjZpSDF5SmFU?=
 =?utf-8?B?bzdIbDRxeGh4clNkMjZudXlDbmErVEVDdzliYUFuZDAvRnlsOHpYSjEwbzVS?=
 =?utf-8?B?elRIbWtMdExHcTI0dVZRZEVrTUxFdzRaSUdaclJnTUpvdjE1OWFYaVNHT2Za?=
 =?utf-8?B?eWQvaFlOdlJYdXVNelZLcGpYUnpvUVRLMEJhaVd4bEtUYytrTDZ2ek14RXF6?=
 =?utf-8?Q?zo83U4ROoPYhV?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb22a66d-5738-4b80-cdd5-08df33f05535
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB7491.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 06:05:42.7523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8307
Received-SPF: pass client-ip=2a01:111:f403:d406::1;
 envelope-from=nutty.liu@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/23/2026 10:12 AM, Wang Yechao wrote:
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Add save and restore function if riscv_use_emulated_aplic return
> false, it is to get and set APLIC irqchip state from KVM kernel.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/intc/riscv_aplic.c         | 201 +++++++++++++++++++++++++++++-----
>   include/hw/intc/riscv_aplic.h |   4 +
>   2 files changed, 179 insertions(+), 26 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 03a0852b8b..a3d209ca23 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -979,9 +979,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           }
>   
>           aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
> -        aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
>           aplic->state = g_new0(uint32_t, aplic->num_irqs);
> -        aplic->target = g_new0(uint32_t, aplic->num_irqs);
>           aplic->idelivery = g_new0(uint32_t, aplic->num_harts);
>           aplic->iforce = g_new0(uint32_t, aplic->num_harts);
>           aplic->ithreshold = g_new0(uint32_t, aplic->num_harts);
> @@ -993,8 +991,16 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
>           if (kvm_enabled()) {
>               aplic->kvm_splitmode = true;
>           }
> +    } else {
> +        aplic->nr_words = BITS_TO_U32S(aplic->num_irqs);
> +        aplic->setip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->clrip = g_new0(uint32_t, aplic->nr_words);
> +        aplic->setie = g_new0(uint32_t, aplic->nr_words);
>       }
>   
> +    aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
> +    aplic->target = g_new0(uint32_t, aplic->num_irqs);
> +
>       /*
>        * Only root APLICs have hardware IRQ lines. All non-root APLICs
>        * have IRQ lines delegated by their parent APLIC.
> @@ -1020,47 +1026,190 @@ static const Property riscv_aplic_properties[] = {
>       DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>   };
>   
> -static bool riscv_aplic_state_needed(void *opaque)
> +static bool riscv_emulated_aplic_state_needed(void *opaque)
>   {
>       RISCVAPLICState *aplic = opaque;
>   
>       return riscv_use_emulated_aplic(aplic->msimode);
>   }
>   
> +static const VMStateDescription vmstate_emulated_aplic_state = {
> +    .name = "riscv_aplic/emulated_aplic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = riscv_emulated_aplic_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +                              num_irqs, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> +        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +#ifdef CONFIG_KVM
> +static bool kvm_riscv_aplic_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    return !riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
> +static int kvm_riscv_aplic_state_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIP_BASE + i * 4,
> +                                 aplic->setip + i, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_CLRIP_BASE + i * 4,
> +                                 aplic->clrip + i, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIE_BASE + i * 4,
> +                                 aplic->setie + i, false);
> +    }
> +
> +    return 0;
> +}
> +
> +static int kvm_riscv_aplic_state_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    for (uint32_t i = 0; i < aplic->nr_words; i++) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIP_BASE + i * 4,
> +                                 aplic->setip + i, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_CLRIP_BASE + i * 4,
> +                                 aplic->clrip + i, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                 APLIC_SETIE_BASE + i * 4,
> +                                 aplic->setie + i, true);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_kvm_aplic_state = {
> +    .name = "riscv_aplic/kvm_aplic_state",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = kvm_riscv_aplic_state_needed,
> +    .pre_save = kvm_riscv_aplic_state_pre_save,
> +    .post_load = kvm_riscv_aplic_state_post_load,
> +    .fields = (const VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, false);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic = opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMAINCFG,
> +                                 &aplic->domaincfg, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENMSI,
> +                                 &aplic->genmsi, true);
> +
> +        for (uint32_t i = 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +#else
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    return 0;
> +}
> +#endif
> +
>   static const VMStateDescription vmstate_riscv_aplic = {
>       .name = "riscv_aplic",
> -    .version_id = 3,
> -    .minimum_version_id = 3,
> -    .needed = riscv_aplic_state_needed,
> +    .version_id = 4,
> +    .minimum_version_id = 4,
> +    .pre_save = riscv_aplic_pre_save,
> +    .post_load = riscv_aplic_post_load,
>       .fields = (const VMStateField[]) {
>               VMSTATE_UINT32(domaincfg, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>               VMSTATE_UINT32(genmsi, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> -            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
> -                                  num_irqs, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
>               VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
>                                     num_irqs, 0,
>                                     vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
>               VMSTATE_END_OF_LIST()
> -        }
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_emulated_aplic_state,
> +#ifdef CONFIG_KVM
> +        &vmstate_kvm_aplic_state,
> +#endif
> +        NULL
> +    }
>   };
>   
>   static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
> index 62d2b33ade..de0fed4748 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -53,6 +53,9 @@ struct RISCVAPLICState {
>       uint32_t *idelivery;
>       uint32_t *iforce;
>       uint32_t *ithreshold;
> +    uint32_t *setip;
> +    uint32_t *clrip;
> +    uint32_t *setie;
>   
>       /* topology */
>   #define QEMU_APLIC_MAX_CHILDREN        16
> @@ -66,6 +69,7 @@ struct RISCVAPLICState {
>       uint32_t num_harts;
>       uint32_t iprio_mask;
>       uint32_t num_irqs;
> +    uint32_t nr_words;
>       bool msimode;
>       bool mmode;
>   

