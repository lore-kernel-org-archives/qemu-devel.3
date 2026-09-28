Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55966CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAbY-0007VA-EW; Mon, 28 Sep 2026 08:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xBAbS-0007Uk-Me; Mon, 28 Sep 2026 08:37:06 -0400
Received: from mail-japaneastazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d405::3] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1xBAbP-0001Qn-3w; Mon, 28 Sep 2026 08:37:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKa55jyK9e/EqwIVja5JuLpuVOdJXktSKWFN7QspD/bKckCp5sUMiXQFLjWcmIxkONnZaKO+/+cD1cjhWu/lnxv63aGbw8zfNZtF9CLYx9mHJklw3NK+FxNunpLXuhbOtCbDCtF1xXDHiLoHxQPgjrhC3rdVMq3abUKXUiybO7mz0Nnmn61ehsBsAflij2u1Mdh4qJElcuyx+9ys4zsK4YUAVoCX2/RKbrJcGodj8uJgu+ZP0C511arpDJDl735cBCULO2dXRSxKZaav2T7NLFbQ4UbxoRo3mhtqPmm6Cm1Rjc5GXTxpAjZUIwD3G9r3yBv4m9j1I24cIKtviGMoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hxFpRwRvIkMohLU1te4dJ9W9dtCDwuA6Xcox7Kg+mE=;
 b=Vgedmh0Qd5Vy2I9Dt+phmm8XUwQ3Sz1OFlB5mdzkN7b1H/4xjoxCv3Yef1oI1QiAtp7RIXdKLWEqOGSy2dOgXDTwZw++h5AopTZFL/8FX5KUklx8ZHGX6DeTlg+cbBpewtHiBioSNkSyLsH6f9ZagqW7FrFAxgN4BlEreYdfVJjr7MitunRoXjvdI4sshMyC9E6vWK2dNTG84TdVgWwjzH1TMAsK5qPR0zxVubVJUVyFV5jXxmqCXobHs9pr4hBYJ7hUWWk5ac99CRzEVEqbXR6xzFEAzx4fNCqD2aMnhHp7k6cx5q0qgkxTSMO2fR0jWY4sB6sycxtudVVvkrnzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hxFpRwRvIkMohLU1te4dJ9W9dtCDwuA6Xcox7Kg+mE=;
 b=l5zeNhRq7Jyp+uGhBJAVZpEJtZfEaAPnwZ5Kx+GzmvZhD5dVPCRd2RmUez4mhRKzmEiNOawFc+ofOfeBz54YD/Aon62P35UlQHZ+TSO1Q6/Y5n+MDBFuaT/s0CJ7pCM4qUWVH5vhQ6GTLiiGCgSsyC95rWt9Z+baQADU6UIRbC4e11EbgSpkVjxa7h1mHeQ6SzUow/zPvJ7Frh0u5AktbLoQb2Bx2pEuBOtZPrEchQ3bTV8DUvXagDfyLcw5MQ1P2AhCt60gMGPXWQNqn9iLaNXuJ6rX3PPNaYrkzQEKM2KAG7ZNB6gzBLg6D7TMC2r3i4XrLS1fXTYxh+2BKld87A==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SI4PR04MB9355.apcprd04.prod.outlook.com (2603:1096:4:29b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 12:36:56 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:36:56 +0000
Message-ID: <SE3PR04MB89227B8BA71911FD9DAC95FDF38D2@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 28 Sep 2026 20:36:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] target/riscv: add sdext single-step support
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260909144841.1766921-1-daniel.barboza@oss.qualcomm.com>
 <20260909144841.1766921-6-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260909144841.1766921-6-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0009.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::19) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <43b05938-34dc-48c5-b9bf-a7fe7a025194@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SI4PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 3918fff7-d97b-4341-eebd-08df1d5d2ec8
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|15080799012|41001999006|55001999006|19101099003|5072599009|2604032031799003|23021999003|22091999003|24121999003|25010399006|8060799015|19110799012|4140399003|51005399006|440099028|4302099013|3412199025|1602099012|40105399003|2607281247196008|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em95YXZXcW1rNHFEZTJ4MlQwTHl1NWJUNWlLUTQxNHFlemErVXFPcDJwZHVE?=
 =?utf-8?B?ODQ4Z0M3aTBsZEFIRGtqS1NhTEN4dTVKQTl1ek84R3RvTEJLcVQxYUhyT3Uw?=
 =?utf-8?B?YWFYYmVaNkJjV2ovbFhzK0Z3YzRFQ0lHM1V6QkFKWVAxUHZweU1sTWYwNFU1?=
 =?utf-8?B?RmE2Q29FdlNSVXVjRWFmbytueThjODJKTDBGenVzNElna3FPbUNDTlhKZFdr?=
 =?utf-8?B?K1dXMjMxMG1Ka3hkQUpacVFCL2tjd3lncVNWRGEyYlpSRTJhT0lLZkNWM0x5?=
 =?utf-8?B?M3kxR2NHSUJ2bFprZW9vcFNCcmU3NlJKSHlUTWZCYVhHbDRoTWRITHFLdWxw?=
 =?utf-8?B?cUN6NGs0aFFjeW1ldVR5R3JxT3dndU05VXpOMDYzVzJlbndrVUp1aXBCaEZh?=
 =?utf-8?B?Uk5pblVvQVdQWjBGUUppbXd6TDdxcmREd08wbUJaMWNhK1lrQm5Jd3FLQjRX?=
 =?utf-8?B?VGdXUHR5ZmZjaDY3ODIvZmJ6M1l6NGRSZmFJd3R1S1ZmVkMyZ2RlRzdQMDFq?=
 =?utf-8?B?SlphMmdET3BXQ01RUE9mZFNVTDFWN3lKTzQ4ZlAya0h4ZzdTSFh3THZaZVlz?=
 =?utf-8?B?ZmlCc1JSTzZOQWZrTmlwZVMwQ2dBcTNjNXBrdmhMSmRuMTZqQVp2NXBhZERX?=
 =?utf-8?B?S0RyeWM1dFhKaktTOGdLb1JiY3RkVTlkZEFJWTRjZ3dQZkVXR0liY3J0Z0x1?=
 =?utf-8?B?MUhKYSt0dHJvSEI5VmhETzI3VWdrRzRCUnM4UjBjb0RUNDRDT2p4Qy9wRVQw?=
 =?utf-8?B?aDBXL3gzaGRLZGEyV2NVdXVXdlA0dWFEcUVGVmRwbERKaHRLR0piWUFOdGdu?=
 =?utf-8?B?ZXBGSzJ2TkZHUTUweGtCRVA5Z3huUFJGVStaQnVod1pqYmVZVyt4VWhhS0lU?=
 =?utf-8?B?TlhwdUFnWEVVYndMaFZtdVZVb0pMUC9zcXpOdFdESkRXbm5FczdhcVNxTk9I?=
 =?utf-8?B?RDdrQmJZbmhLMnppa3h5ZVZ2a1h3QzBwRG1MOTMvaXB5Nk1DZlBJR3JOTzky?=
 =?utf-8?B?V0trOW9ZdG5YTkdCNi9oa2J4UEthTjRST0RJOTBFMVNINTFLUlpKNEJiYlMw?=
 =?utf-8?B?UXlRVHRJOUhseTgzWmF5YWdMTnhMMGthYVpySkhyVWtlVTlER0QwS0l5ei9x?=
 =?utf-8?B?cHNpL0lnZlh0ZXQ3clpPa3BxM3RibUVOeDNmb2JkOFpoVm1hWUhwQXFWalAy?=
 =?utf-8?B?eU10c2s1VXljM1dvbG5KcjNtR214NzVzbFVCUFlHTlhUaW1EWnhoRnVLRVNn?=
 =?utf-8?B?aWN1U3lmTDZ1RVYzNlRQZ2s3Y2ttUUYvbUZrT2JOUVBZc0pTOFpTK2ZLWThn?=
 =?utf-8?B?NEFuUlptbzRkSHhWNDdNR1J4MmdXOEg1RmhsUjdBN0twY3QwSkJhenRleXBy?=
 =?utf-8?B?ZFRpWDdxS2hMNzdUSWNqRnk0ZFBsbUlTOUphclFzMFlVYmNhNVdpcVhLV2F1?=
 =?utf-8?B?ZVpQOHNnemo5dkFwaFcrM0VGUWRwRWl6QmZOdlRCSUpSbHgvMW45VTNXdjBH?=
 =?utf-8?B?U1ZRMDlyVXB5dHlYc0hvQlRUNVZ0bmNRQ0RTRGFNVkU4TWFXUFBZdXo2MFhG?=
 =?utf-8?Q?WFF2WHVNoMIK90HIPXOkMM9sa1ofsVF675c0c9zD+K964e?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05nd1ZkaURZWFU5b1NMOUZYMFNiMHdFUFVMRmZoVFVVampUeHJ5NSsrUWJ0?=
 =?utf-8?B?TXhQcFkwWm94NTNUa0E1d1ppS2laclJpNTRkSVZaczNCbkVKV0NNS3NZNVVQ?=
 =?utf-8?B?VkFNd2J2NlI4THNHTWFnUkNXalhpZWRHeDBtVjEzMnRxUFE5N0hpcXpaWVpq?=
 =?utf-8?B?d1I1KzY2MkM0VmkyQURQUXBZWm1iMXJYakdaVW9PTnQ1TTNUOVRnellURllU?=
 =?utf-8?B?MkNtazU2UnhjMEI5Z2VGNWo1NC8rOGV4QzNVQVVBbVc1dHFRRllOdFVCamc1?=
 =?utf-8?B?eDFQbUZ4QkFYOExXZzNuaHplYXQ5dmltZjM1WEQ3TDltbEFiV3A4WWZGWnBt?=
 =?utf-8?B?Mkl0eXpwQUZhT0UrZWdkTzliSHVqYURNd2xyakdKb2hMZ3EzbXJUVmdObTRI?=
 =?utf-8?B?WExOaGJ1TnQyRmprNlBoSGJtTU95ZU4wNGI0N0NuN3d0ZDQyOU5iQTlTTG0z?=
 =?utf-8?B?blVTWXVDUjFrVGM1cjgzVzZ0YU9IbG9OVUJnUzM3Z1o4QXNiOXhjUC90VnF6?=
 =?utf-8?B?L3c3UnBLa0Y3Q001ZHRxTFdTc0JhUkNIYVNSQ1E5V3BQcGZRSjk0K29VVUxC?=
 =?utf-8?B?T2ZnUmV1Q0ZyM3cxdXJ2WnlHY2lOK1puc3dLV25INGJCcU12cTBtVjRwc2ZY?=
 =?utf-8?B?Q1FQdU9aRytoNW9kNVRsZnJPVlFRam1jSXFPMk5DZTlGWlUydmEvaHNZNlpG?=
 =?utf-8?B?L1hLTFN0akF0dnVReHFaRTFMS2gvakVsNm54WWtqbWIwVGNqV3p1YnhNNldh?=
 =?utf-8?B?d2UvS1Q3Tnp2NW5Sa3NaQnVrMDBOaUp5WEcwNmhQcG9od0ZFS1lQZ3FqWlNV?=
 =?utf-8?B?UmNFM1lhZnloNzI2UEMrcEdhRDBaT2xWcVNhbnlzOG55c1M1VjY0SjZyQXRs?=
 =?utf-8?B?QnJHS1l6bysxMmxtTUM0R1FVeEpDb3ZGU0h6M2ZPY0FCUCtTN3pVa1ZDenBt?=
 =?utf-8?B?TWZnV0hhN1Y0SmlUc05leUZJZERvcjlDT1dYN2NBdFYrVi9jSHJHNzNGSVpw?=
 =?utf-8?B?cFhvUjVxNjdPWTJveFB2M2xEbllRN05PRGRJRzBzMzZ2eW4vZmRDL3l6a2ky?=
 =?utf-8?B?dDJUQzdvd1RDT0dHZlcvQVZtNlh4RDBwa1FUdGt3c1hYTDdNZlBjVVJVeDQw?=
 =?utf-8?B?M0lBL1lYL2IvK1RmUE5Tdy9hOEVuZ1JnK1lTcVczamNIb1A4aEVSandmTGcw?=
 =?utf-8?B?TnQ4WEo1VkpoeG9pbVVDc1NrTzM4aXpmblVBNHBQN04wOXJXQlNZNkNLSWlu?=
 =?utf-8?B?L0lBKzFTVm1TNmpNWDAySXB3RHpuK2lTNFp5Q1ZMZ09LakxJUzZJSUZvWHVx?=
 =?utf-8?B?STQ3L0pMOGhXQmdvSkxEeDVkUVRWdXFNUkl6MmVWUHBZZDMvbmNlc3BYQVh2?=
 =?utf-8?B?SjcrNzA3V0ZUSmlPeHhteHZyc0NUdXZGOWFGOGNIbGFtdkJ0MWhLWjJSMnRi?=
 =?utf-8?B?Zi9NenNoMTI1QmpFNjJrUkwrZEJKM3NnRXZCV1NzYlZTZWUyTXFOTUcvYngv?=
 =?utf-8?B?eFI1dEVKTnI0T08yL2JPR01zb0JMY2lZWDkvU2t2VmU3NXFadHVnOU1PUkdU?=
 =?utf-8?B?bjNUeFBGWmk3Y0tVcEVQS3ltaVFaWWF2Nks0RmV2UWxHbTgxVHI0a0JEcXU2?=
 =?utf-8?B?UUJqZGJzdnNweGNJSTdyZU9SMGhselI4WTBQaVZOcEtERlJzREdWYnhvNVJa?=
 =?utf-8?B?d05KaFdHc1dyQlZqOWFRZWVDSlIwd044QVo5TFFHQTU1ZXZ4eXkvbTEvRGx5?=
 =?utf-8?B?TC9FbkxiWVlpb2MzKzh1M0ZWMDgxWW9qRkY0K0dodUtBTkZIcWo4ZlFzUHcw?=
 =?utf-8?B?eG1QMlRiQUFLZmZYRVRCWGNoRVNNeXJYS3Fibys3eUZ4NWxnNXQ5KzRXaDVT?=
 =?utf-8?Q?X0lbCImFM2Cze?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3918fff7-d97b-4341-eebd-08df1d5d2ec8
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:36:56.6586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR04MB9355
Received-SPF: pass client-ip=2a01:111:f403:d405::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/9/2026 10:48 PM, Daniel Henrique Barboza wrote:
> From: Chao Liu <chao.liu.zevorn@gmail.com>
>
> RISC-V Debug Specification:
> https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
>
> Use a TB flag when dcsr.step is set (and we are not in Debug Mode).
> When the flag is on, build 1-insn TBs and do not chain to the next TB.
> Add a TB-exit helper that enters Debug Mode with cause=step and sets
> dpc to the next pc, then stops with EXCP_DEBUG.
>
> If dcsr.stepie is 0, do not take interrupts while stepping. Treat WFI
> as a nop so the hart does not sleep during a step.
>
> PS: This patch references Max Chou's handling of ext_tb_flags.
> https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   include/exec/translation-block.h |  4 ++--
>   target/riscv/cpu.h               |  2 ++
>   target/riscv/helper.h            |  1 +
>   target/riscv/tcg/cpu_helper.c    |  6 ++++++
>   target/riscv/tcg/op_helper.c     | 20 ++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c       |  5 +++++
>   target/riscv/tcg/translate.c     | 15 +++++++++++++--
>   7 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
> index 40cc699031..ee15608c89 100644
> --- a/include/exec/translation-block.h
> +++ b/include/exec/translation-block.h
> @@ -64,8 +64,8 @@ struct TranslationBlock {
>        * x86: the original user, the Code Segment virtual base,
>        * arm: an extension of tb->flags,
>        * s390x: instruction data for EXECUTE,
> -     * sparc: the next pc of the instruction queue (for delay slots).
> -     * riscv: an extension of tb->flags,
> +     * sparc: the next pc of the instruction queue (for delay slots),
> +     * riscv: an extension of tb->flags.
>        */
>       uint64_t cs_base;
>   
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 82eb61a18c..db49ad7682 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -755,6 +755,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
>   FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
>   FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
>   FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
> +/* sdext single-step needs a TB flag to build 1-insn TBs */
> +FIELD(EXT_TB_FLAGS, SDEXT_STEP, 34, 1)
>   
>   #ifdef TARGET_RISCV32
>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 0d9ae15e3e..5193440e1c 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -142,6 +142,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
>   DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
>   /* Native Debug */
>   DEF_HELPER_1(itrigger_match, void, env)
> +DEF_HELPER_1(sdext_step, void, env)
>   DEF_HELPER_2(sdext_ebreak, void, env, tl)
>   #endif
>   
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index e6d948991c..a7344b1be2 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -500,6 +500,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>       if (interrupt_request & mask) {
>           RISCVCPU *cpu = RISCV_CPU(cs);
>           CPURISCVState *env = &cpu->env;
> +
> +        if (cpu->cfg.ext_sdext && !env->debug_mode &&
> +            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
> +            return false;
> +        }
> +
>           int interruptno = riscv_cpu_local_irq_pending(env);
>           if (interruptno >= 0) {
>               cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index 5db4f6aacd..489aac28e7 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -489,6 +489,22 @@ target_ulong helper_dret(CPURISCVState *env)
>   #endif
>   }
>   
> +void helper_sdext_step(CPURISCVState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    CPUState *cs = env_cpu(env);
> +
> +    if (!riscv_cpu_cfg(env)->ext_sdext || env->debug_mode ||
> +        !(env->dcsr & DCSR_STEP)) {
> +        return;
> +    }
> +
> +    riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
> +    cs->exception_index = EXCP_DEBUG;
> +    cpu_loop_exit_restore(cs, GETPC());
> +#endif
> +}
> +
>   void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
>   {
>       CPUState *cs = env_cpu(env);
> @@ -621,6 +637,10 @@ void helper_wfi(CPURISCVState *env)
>                  (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
>           riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
>       } else {
> +        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
> +            (env->dcsr & DCSR_STEP)) {
> +            return;
> +        }
>           cs->halted = 1;
>           cs->exception_index = EXCP_HLT;
>           cpu_loop_exit(cs);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 959a1e89c8..16d26cee5c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -196,6 +196,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>       ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
>       ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, BIG_ENDIAN,
>                              mo_endian_env(env) == MO_BE);
> +#ifndef CONFIG_USER_ONLY
> +    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
> +        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
> +    }
> +#endif
>   
>       return (TCGTBCPUState){
>           .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index 9684dbe752..1a38d6aeb5 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -112,6 +112,8 @@ typedef struct DisasContext {
>       bool ztso;
>       /* Use icount trigger for native debug */
>       bool itrigger;
> +    /* Enter Debug Mode after next instruction (sdext single-step). */
> +    bool sdext_step;
>       /* FRM is known to contain a valid value. */
>       bool frm_valid;
>       bool insn_start_updated;
> @@ -286,6 +288,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
>       if (ctx->itrigger) {
>           gen_helper_itrigger_match(tcg_env);
>       }
> +    if (ctx->sdext_step) {
> +        gen_helper_sdext_step(tcg_env);
> +    }
>   #endif
>       tcg_gen_lookup_and_goto_ptr();
>   }
> @@ -296,6 +301,9 @@ static void exit_tb(DisasContext *ctx)
>       if (ctx->itrigger) {
>           gen_helper_itrigger_match(tcg_env);
>       }
> +    if (ctx->sdext_step) {
> +        gen_helper_sdext_step(tcg_env);
> +    }
>   #endif
>       tcg_gen_exit_tb(NULL, 0);
>   }
> @@ -309,7 +317,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
>         * Under itrigger, instruction executes one by one like singlestep,
>         * direct block chain benefits will be small.
>         */
> -    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
> +    if (translator_use_goto_tb(&ctx->base, dest) &&
> +        !ctx->itrigger && !ctx->sdext_step) {
>           /*
>            * For pcrel, the pc must always be up-to-date on entry to
>            * the linked TB, so that it can use simple additions for all
> @@ -1350,6 +1359,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
>       ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
>       ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
> +    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
>       ctx->decoders = cpu->decoders;
> @@ -1402,7 +1412,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>   
>       /* Only the first insn within a TB is allowed to cross a page boundary. */
>       if (ctx->base.is_jmp == DISAS_NEXT) {
> -        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
> +        if (ctx->itrigger || ctx->sdext_step ||
> +            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
>               ctx->base.is_jmp = DISAS_TOO_MANY;
>           } else {
>               unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;

