Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51049CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXAgR-0005vS-35; Wed, 10 Jun 2026 00:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXAgM-0005uT-VS; Wed, 10 Jun 2026 00:36:51 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wXAgL-0000KP-E5; Wed, 10 Jun 2026 00:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsBrczk7CGh5sqrYRX/nTHtjMfXxaOP5NTKfdK8ZtYmoNP627GR5AL3vkex5dcxDXFkYcUy0IzHhVIswlVqNILaI6YRvNZ9AJQbCeI5wPlJae0alF59M8myLrk6ljeu6/JS4aVEL3Cjzhlw37KPuFoY0pQw3NgWQDZuvNj330W7RAtVJW9Kq6XDpcx1cyLI7yS86KycSh61qJGBAIfcTu8H+dWiGkO1y7xm+VvYhatKlz4cAy6iG2hQYqaSlTzQYXPmQFDsj/FFOmItPHo4rlE5Ns6X6cDKb/mxXJVj5SLD7ZGph7FYEAXJjm7SEa8atWd87PUVPBdrTf6GUAc5cEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHN7Qjtet30UKTGQ5WM62CZXgtNFkR9uJvhnhDwUPQg=;
 b=X+mUwRjO5bcQ6rVBh8vjmVLZ9yjvZf1esnBbZFRGmSmH7p1LLjkS7PD7nF4lyfSPBYQps4+hyt2pvnNzGHcccxwONyRV+S9np497MJgt6UCWpzh3OAP6N3pRN2bqFxjDIrw8/VM6UUYYaZybcvHPiN/Z5jqbcDDxkH3tBtxjymTsL+iFE/RWdYwNv5QgOn1H05Hco0UxQbVqb+LvnA2Qh6uZgFE85fabDQ5qaz+Ej4GG0XArUu4UK7/wx8tqG4oUQo4WasDwGcLbuKDZLrNpyOx9MGaU0aA2SPZkd4yLGE9KNQJLVFnQ9XNY15royEo7mRJb1JbcR6EB9TlCwFeDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHN7Qjtet30UKTGQ5WM62CZXgtNFkR9uJvhnhDwUPQg=;
 b=IVxOY9I86mTJmMyRrt6Db+RyuNgWVPhbOvolFZgO5mNt4eVNsT0OlBJoFsTZyvkg0z9REYf/NX0rKkvx/TZHxXv3Jn3z+G99ed/SCfF/9d408DCMZS0IcRKu7a14aCjPxH0vOIkTy5GnP72Yvhfxt0mUsBtFoEn/N4/VTlNDeDznvAjukJGJgRM5Ky3ZyaSlYifLb1BP42f8p0PDuS6arKES4FO/b8C9ZOqcdlTvJuobKVIsyFt9kgaI08LzxkNMMVv9HlFwpvcpk8bg+fPyNFAQO+Rc4XfjhUolkelFSwjJ22jcxb6MjDx6K08H0kEx2tQHP9cOOmhF13RtHOOX3w==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by OSNPR04MB9288.apcprd04.prod.outlook.com (2603:1096:604:471::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 04:36:39 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 04:36:39 +0000
Message-ID: <SE3PR04MB8922447B869F2D090EEEA830F31A2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 10 Jun 2026 12:36:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for
 KVM
To: Qingwei Hu <qingwei.hu@bytedance.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20260604120017.398890-1-qingwei.hu@bytedance.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260604120017.398890-1-qingwei.hu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0017.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::9)
 To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <820dcdd9-a025-42df-a64e-578615edaefa@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|OSNPR04MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: a68118df-ffc2-4d75-00e9-08dec6a9dc4e
X-MS-Exchange-SLBlob-MailProps: laRBL560oLSPhlJ95/U7v6W/AahuugGa00XHAA32DaAL1zL5od4SzuQ2FT8+cqJL2dUCBBGVEHd2DC5RuFJdXTb44Ir1iOtlKKQPowSINI7NrCLKGS+PbVWJ8UHYAdib+JSC9IM4GEtvXHKLpwqDqZXYXzgVjvmkm3bbM7PX4n/TIQ6zIn93wo6EkKA+7ObTVRb4//1JDGofYuOpzXL8tCrIpe9LEAm/23POicRi/0lCA6dBGKWANh8nTsyfhY7lxN3tW8W4S0fR+dCeE/+UdtKfCuQWfM3wTv7KepoUQW3eSqAI0dDnNIIWMdgFyzEqzhwip/f+CD+JyyrWXAvu14dBUc/o7eyD4RU3SVShTyHwwuFNy+dvnjjYpgUjeIJuIqwK/bWzHYRUnT92/P+USW82/y+sxfpdtOiXJhHMJh6Tgqa+kibD27juZvhNCCxRzUkeADGerLi6GgmoA7Hu8s+X6UDvensL6jPaSJiVdgv0X+eTZjiMRVd9sYHRVu6NHvTNTSE3nZwoHDeOIVEzqDT9ZmHn2fpwsSpRelKBJitsHy/YCRvTG9i/zMYI1rV0WV475jnRb3zwg7Gb6LMByx2RPbkRXoGpUq6ZxtFtYzHSY4lk3ZOktCZsgzlGO3amO4ary2lg14ZyXRDV7aHW7EnRaHqqhbZkIaSohRxqqcSdJo7vGFR4pk8fUUVXLbU08/bhBcorpDMTCE/bs+BPCdAoooJtMUOOCwF4dBAyJxL/C8uAvpnHlb8C2iv7zTvGW2gP/qUSfy/gRNG7wYTyT2Z9alPFmlW3
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|7042599007|5072599009|8060799015|23021999003|45011099003|19110799012|6090799003|15080799012|51005399006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHI1WmtZZTdyRWdUSEhMOEYvSUF4dGx1Umo0cS9EbTZpWlh4QmNpZTdhaFdK?=
 =?utf-8?B?VlM5ajdCaHp5UkphUDZ0c3ZEUVBleThCYUY2OFQ0czN3UFNTeUJwbnZDdFB2?=
 =?utf-8?B?REhPL3NxM1prSXNibXhvcVhIdDBlS2xtNHYxYkJjVU5saG9tL05nWHlRazZ5?=
 =?utf-8?B?UWRUbnVZQVhQMXJ0dmZLbUVQdHJNTEdZeGI1bXA3emxMbzYrbmV0VHFXTFoz?=
 =?utf-8?B?VStGVzFINnFzZUVnOTg5YWt5L2tTRmlyTWU3VTRRdFFxeW1XcVRkSWZBbXNX?=
 =?utf-8?B?b2dnRVR0TkNsYnRVOEp1eUZvRGROVnd2a08wZ2gxUmNnTk02anNBdVBJZUZl?=
 =?utf-8?B?aFBERTRqNEtBTVE3djlOaEptNnhCcDFnZ05HRzBjdm5RQWwyQWpSOW41U003?=
 =?utf-8?B?UUxkdEtLQXg1clI3RGtoZ1NVNVBlNWwyR29Wc3JiNk43eDcxampXcUZKWEFD?=
 =?utf-8?B?aGgvM3d2NFlRRzRkaGROS1pTaDhCWHJuaGozUzZ1V2M3OWQwSVJkdnpKMXNM?=
 =?utf-8?B?QjZaS0ZseXZFb3VCSlE5UEg5U0NjRFZuSGZ3RzU4UEF3N3J5MXFsMk00Wmlk?=
 =?utf-8?B?RjVTMytlM2NRbTBJek5HMDhvVnRseGp5RzhnSmVZcGJIbE5EWk9iV0JrN1dH?=
 =?utf-8?B?NkJIdG9UUmFITmRRZ0hyYS9JL2dDZWRjckc1M0luNW85M2ZZMjlmV05zUXUr?=
 =?utf-8?B?em4xeDVhODVZWHMxWklDQjlyTXJRYUlkTTR2blF2MTBqSTRSM3phTnVvalZE?=
 =?utf-8?B?Z0tSNTZkM3F4Mlp3a2Q4VmxRMjhaMHFvTENvWE5yK3Rpa2FQZGtMbWlydkhV?=
 =?utf-8?B?ZkFjSUhtVGdzQzg5T0pYOVZJRDFObHZKWHNnWmdldVVla0g5UG10VlJUMENW?=
 =?utf-8?B?UE5nMkU5YU1vY3RkU2kyTmIvK3hORnVrMHU5elFzQkx0NWNTMHh3aEx0THpq?=
 =?utf-8?B?MGYvT20wYTNSKzlyVHBqOVR1WW5FazVGNHYxKzVaS0dlT2hFS1lPSDQrS2s3?=
 =?utf-8?B?K3ZhVktVbGJmS2xleTBER25Qc2hrMXMrRC80MHV1bnZlbDZQd3g4bGFTODF1?=
 =?utf-8?B?VnFlZ25Mb29YNmNOb2RHcHBUOXNKaC9McVBFd1VVMDR3WmRqT2ROVHBmRmh0?=
 =?utf-8?B?blpqMk5QQSt4NmN4aFF3bjVoaGRJcTA0M2d5L2pDK0hCZjhlalRJR1JWblF0?=
 =?utf-8?B?TUVPSnFabTBhTVhSMFRBN250Vll1dC9RSGFZb3k5aDk4dVNRR3ZBTnNyQmQ5?=
 =?utf-8?B?b0JCZ3pRL0MrY0JBY1V5SWh4U0pxUVNkM2UrUUo2UHhLdWRkSHNUeWpnNUlp?=
 =?utf-8?Q?hhGWCaALB3NmzcbAmoUXljo12baTZX8HCt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?andDUnh3MnJzTk9wWG9uclRlRy9QYmczY0tQci94NG00NXdDZWRoRlV0Q1Fy?=
 =?utf-8?B?ZHZRSkdrRzZHSEVSRml5amQ0MjlWcUlMM0UrajRZWnY3amdxdTBzcHB2dDh1?=
 =?utf-8?B?NURwVitFZUdRUTBSNU8rMVdobWluSk81VzlXNHFLWmtTdTdwS0Rlakdwa1NH?=
 =?utf-8?B?S2RDSDR1TFVIODA0SWpJMGlQMXdPSVdJbW1SMXNoeUdndFMyQmdmWmlwMitX?=
 =?utf-8?B?S05WMGRlbVdqdng1emtDOEM2MStPWWkwM1pSc2NQVWJuUFdHNkxPSXJ3UlFo?=
 =?utf-8?B?aDF6MDBHaVhzNlRUcGl6NHZwS21qS3RqbzFHaitrOC9OODNCSFA2dXZYV0JC?=
 =?utf-8?B?eGprUS9TOHBmZnBrUkNPbEg2NUsydmlvOEVLekVndS9BbVZ2akRXY3BzNjdt?=
 =?utf-8?B?QzB0WTY0cUhsek1oQkdRQTVqeVVzMldvVnR5V1d0eFlwVXhjYllkR1NpMVlq?=
 =?utf-8?B?N2xiQVFDNzFjTWtPWXkrMUI5NXdENXQyZmsrMEsvVS9BZXFmUnNNM2cvQ05h?=
 =?utf-8?B?UFpBdFRUNXE0TGh0bi9aQUJ6eStoNlpmczFjMlArN2FaZEtDZCt0ZXFnVjFO?=
 =?utf-8?B?VDBoYWZxU1dJTmJjZkVGQVZnNXZuaHJXUmV2YWIyWFlxSmN3TWtYaTdBN0dJ?=
 =?utf-8?B?N1UzcTAwQVNGbnlxcGZKVnkxeE5zZ3FEQVBWVDlocDBrK2JBMG14NDloQlZ6?=
 =?utf-8?B?OXVORWFEZFdTaW5hTFBWeERVQVlqTzBFK3VIcmVQS0QvUG1Hc0xDekxvVzkw?=
 =?utf-8?B?MG41aERiVExCczlOT2R1ZW82K2tWMytxR0lTUmxSdVBwbUdpS0hGcHZUV2dU?=
 =?utf-8?B?blRodm9NVzkxcHRuSDI1VWhDcENNT0xGREt0dVhMTDlGNDkzNnREblhrNjJt?=
 =?utf-8?B?d0FLTDhUSG0yTlgySmx3eWErUHJzN3pmZk0vRU54OUJ4NmhqSDJlcXBsLzYr?=
 =?utf-8?B?SlFjNlBXREkvMGhKUkM3c2llUUNCRjZWazRUNHRrUlhlMFNxeTJSTDdUQ2VG?=
 =?utf-8?B?TE1UaXU3UmN6K1h3OU9yMVZuZEVzTXBOanNUYWorZzNDWmFoWTVseGQ2NkVN?=
 =?utf-8?B?TXk3WlVYVzJPeVEvSzV4Vmc4bytTSWVrRnhaV3ZzTURYeTV5Ui9JUWx3ajlP?=
 =?utf-8?B?alN5bTNZVjF0N0tBZGtyZTR5Z0dqN1RsY3dSczY1dG5aTkZrcjBZb2Jodi9w?=
 =?utf-8?B?S2pJdHNkeGF5ZExrUkllNVZVUlBJTlNuTUNIbkZzaTJuOGE1enRPZFRiLzRE?=
 =?utf-8?B?aS9VSkNGOWRLbWxpOEh4OFRmcVlqMVN3ZDhDbVNTaDdId1FnZXZKQ0Y5am9o?=
 =?utf-8?B?YjUyNFRLQUNveVpUTmVBVkttUE1yVUVqOVZCdFFCb3dpMVQyVDJVY3d2cHdQ?=
 =?utf-8?B?WUtoZGdpdU9FMThHYzlvOE9vZFJITVMxVjlHL1V2Z0RwS2p2QjVHM0VRdFEy?=
 =?utf-8?B?S2EyMkRzSTNKd3JkbzZRakxMSmdWTi8xMG5ZNnR0M0RXK3JEaGFLYitkN3lD?=
 =?utf-8?B?cG1SMzJXT1I4bi9CcCs2aFJwMVZYZlN5MkY1K0JldFBTZHcyaEZCRXpqdEl1?=
 =?utf-8?B?NWFGN21mWmpmdVFRNGpLTHJtTGJCNnViTDErWnhEZGdMWEJsRnFNTEUvN2hI?=
 =?utf-8?B?UU56M2JHQUdyZzRLSGhHV0xvbkIrU1dkajhkdy8xMHVRZGd0U1FUbGJSbWg3?=
 =?utf-8?B?a2FuVzFhTW03SWk2S09sNHpJc1dIallrUHlwdWZBY2dQWjFmd0VjU3NpTkdO?=
 =?utf-8?B?a2tLTUs1dVpXelcrd3RLaHRueno3ZzNmMWtpbjZkWmlhcHRidVBsQW9CMUFr?=
 =?utf-8?B?dVY3Z3RRWFJzeHNYN3E4MTBTMDBMUU93NERBSEdxOFRZeGRpZUNPRlh3Q0Vx?=
 =?utf-8?Q?Lb9z41f/G4Sys?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a68118df-ffc2-4d75-00e9-08dec6a9dc4e
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 04:36:38.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR04MB9288
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 6/4/2026 8:00 PM, Qingwei Hu wrote:
> Each RISC-V MADT RINTC entry contains an External Interrupt Controller
> ID field. On the virt machine without AIA, this field identifies the
> S-mode PLIC context associated with the hart.
>
> TCG virt has both M-mode and S-mode PLIC contexts, so the S-mode context
> ID is odd and 2 * local_cpu_id + 1 is correct. KVM virt exposes only
> S-mode PLIC contexts, and those contexts are numbered contiguously from
> 0. Reporting the TCG context ID for KVM makes the guest enable a
> different PLIC context from the one used by QEMU.
>
> With ACPI enabled, this can leave PCI INTx interrupts pending in QEMU
> while the guest-programmed PLIC context remains disabled. A virtio-blk
> root disk can then stall during boot because its first interrupt is never
> delivered.
>
> Use local_cpu_id for KVM and keep the existing odd S-mode context ID for
> TCG.
>
> Fixes: d641da6ed43 ("hw/riscv/virt-acpi-build.c: Add PLIC in MADT")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/virt-acpi-build.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70e..6b06d9aa87 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -100,6 +100,8 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
>           build_append_int_noprefix(entry,
>                                     ACPI_BUILD_INTC_ID(
>                                         arch_ids->cpus[uid].props.node_id,
> +                                      kvm_enabled() ?
> +                                      local_cpu_id :
>                                         2 * local_cpu_id + 1),
>                                     4);
>       } else {

