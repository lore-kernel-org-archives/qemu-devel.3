Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1C2CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN1vr-00040W-7z; Wed, 13 May 2026 01:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN1vh-0003zC-6U; Wed, 13 May 2026 01:14:45 -0400
Received: from mail-japanwestazolkn190120001.outbound.protection.outlook.com
 ([2a01:111:f403:d406::1] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wN1vc-0002uc-JW; Wed, 13 May 2026 01:14:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUWMy4P9DdG/lbeOh5Eyi8gUmKzqJ4JQRq2P9xzDGzFVDCuuB8AQoy5yk0T9ufkY7DO/lmyVobyKzlk9BvynURMHMZJ0zU2W6lbknCT/+MgBTBqtjHIeRp3QI5Srrwm78yMy2j4eb1AUl40hZHgmjZpJuB8cZJx4U4xV7fpMQnSOekZ4gWMDI0HXnnt8M+xMPhlpex7nKVd2z0OlABWy0WajB1VksrOZmpQp7ZkOXxH570VPNQC1BlofdTn5dJbi+S7kOtg1x3hluuwJtYGUCtxMfLt1w4HIg8J0D5dV38vo8s3qaA5CkaFb0UDj+29PXbFPpMM8GKztTZH1wl681w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJBiSHDbkSz9VpTAZStCzq077BzlVQ2/Twnn3ZlUrGo=;
 b=flSDr/nQehgcaV42ny1HvDQtGtMH21brgzyZ62JqTuTh00yZnLZeHwSNo8w9jXAQLDU5Fb55kV4r+pAjZR1ZKdmW3sv7nG/D0fDZMrnpFtvJPzuSuALvQBD8kcG+n7BWU4c0cW2y8tlDlpBUyGlLCXeFcHgCg591ovvg3q6KnYi3R39Cf0SD75FvUGHl6Ps1qb3MtBprcsaGchOU5SpK11866asenHLEgPZgs5hSob/Sxn7CoaVKIDBMC+F/SlQoFCe4DYJOb+I2zCoj8Y+XW2G9y4E9yHisgRMEhgR+zWITv06nVc/L32yPKDAlaQGP9H7ZgiLdcaumpqgMuwn8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJBiSHDbkSz9VpTAZStCzq077BzlVQ2/Twnn3ZlUrGo=;
 b=LGCbLph1h2twLPLQarUwkL8jfd0CKpo03yD+AK4Td92Ai+6Y+PMfEInU9yFahorJebO1HWnSX/0FpSjQ0DgMgwu1KgKxELyWZTs1z3kbYez/94uXMLl2lA5s2JL42r+U5X6ayuNIZr98a9nT7Qi9dwzer8hFomA2qAHb4YmF5K/fn+qJScIYLsItMT05oI5qZsB06QPh2sj5iOyGFmqgfY/9celETuCI+JD4539t/wmUMErXhepA8nZfdj9cO6uQ5WBjuo45ephuGFlzGgrfts7LzmK4XNP8W3ZF9uJSbZkON8nGpblHM3dt7AH+8LY6tKu8lqTXDJd8h48JhysKtA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TY1PPFF9A0A2B69.apcprd04.prod.outlook.com (2603:1096:408::ab2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 13 May
 2026 05:14:33 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 05:14:33 +0000
Message-ID: <SE3PR04MB89229C58099F49F2B13DEDCCF3062@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 13 May 2026 13:14:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] target/riscv: Fix smrnmi isa alphabetical order
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
 <20260511124705.28161-6-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260511124705.28161-6-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <6868b844-b379-4921-a31f-fb62406cc5c5@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TY1PPFF9A0A2B69:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc48f48-afa3-48ce-3d87-08deb0ae844c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|45011099003|51005399006|23021999003|6090799003|19110799012|15080799012|8060799015|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE0vUWt3V3UzQnVFSTNDVXpZSXFsOXdMb09FWThTcmxzeDB0WmVaQno1cm0r?=
 =?utf-8?B?NGd3bTB4M1lKWXJ2TG5FS0lPc09nM1BLckRoSGswSWtXN241dHhGYW9KaWM0?=
 =?utf-8?B?cGwyN2dONzY2WjFGaGdvLzBYcE55aDVFRTc1eEtjdDF3YTNtZ3ZDVWpUNUtr?=
 =?utf-8?B?Q3c3dkUyUUtTOUg4Q0YxcXFRdm41bTUwbmFuVzRMN0IrSFdXQUJPRkZva2Fs?=
 =?utf-8?B?SGFhRk5NY0ZCVmJjZUtRVXFjQnU0cHY3Mlp5VVJRSTk2aEtQditnVTVsTUFX?=
 =?utf-8?B?L2MzbDRrTVBEdGVOU3ZhelNiWE5qZFRwVmtsRStRSThteHZEbjRxSmphK09P?=
 =?utf-8?B?MXFaNVMwRWtPVWFQTzlXUFJZNU5YSGxvU0lRRG1HcENMT0VSelR1WmMzMXAv?=
 =?utf-8?B?U0VEejlKcVFsem1IODFicUl5TmQxczVvbWlSYy91V2doRThya1Z0MXpGcmRq?=
 =?utf-8?B?eG9rWElMUzFBN04xcGdqRWVGeXBBRWxFWXVTVkoyV2N5YWtkdmROQ1B4Wm96?=
 =?utf-8?B?UUNadzFjN21jdVQ5Q2s1ajVGd3VyOGNod2FCKzVnRzUxdmpQNmdDVWliNUwv?=
 =?utf-8?B?bHp5MVVWWUEvK0pQcXYvS202TC92dVg3MTF3ZTZCUDhSVmlDWlowOEtPLzRq?=
 =?utf-8?B?Y0l1R3hOekdnMllXUjRTZUxITk53UmxwaTZkS2VrNjc3Mnc4Z1NoQ00wMmNm?=
 =?utf-8?B?YTJTWWlNZ3h5UTN5NWZTY016VHhqUDJYQjROWElJSXllaDF5aTBBMFM0aFAz?=
 =?utf-8?B?VEQreWNTbjdjUmV6M2pRTVNOVWtaYVhJTVMzM3pFWDV3aVpyU01EMW51cGxN?=
 =?utf-8?B?N0paK0VMQ29FTlZvSHRJNWI3eE5hbVVxNWtuV2ZVSlprTElEbmR3K0xQK1RE?=
 =?utf-8?B?cEZGU0ZSYTM3N1JRMElUNzRZRUxLS2VHOWl2N3JMSWdDRm1YK3NWWlJITGE2?=
 =?utf-8?B?OGlhSWRUeG5lbTlSRXdZanVDZzd4eStQUDU3L29HWjloOU5XTHM4N1U0c3ox?=
 =?utf-8?B?SUlXSzhwSzBkcDVmenA1SXZTejc2eGJWdmhkVUlBY2NIb1ZYMlExcnZZT0VH?=
 =?utf-8?B?WUtYMXhpbTdWZ1RGbG9admxkTWpiaUpzQm94YlBvZ0lDckRMTklhdXpOdXRx?=
 =?utf-8?B?Zmw0Ry9RN3hpaVZxc1ZIbVhOREQyZDJTSXlIaUcxdjV6dXR1a2UxcGFPSExG?=
 =?utf-8?B?REpNK3dNVUphWE5HM0g0VWFzQjNyMlBZUDNEQVlab1FiTlFMYkhwY21hOHR5?=
 =?utf-8?B?L0c3K2d4VkxOUm1vdDQyL25KYjQ4a2locnZ2cWtzSFRIWUVmZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWd3dDRpQkY4U0ZBdDBFWUxMSXExZldLb0k3Q2JnTmZGNHNGNGFhV0VMRlg5?=
 =?utf-8?B?eWtHc0hKeUdINmdLeFBoRGY3WFE2WU9mcTNSMmlHVVU0S2huSmlidXVZcldZ?=
 =?utf-8?B?ZDFyU0VMSDFiOVVzVnVDcnhiT3d6WFA0QzdRUU4zUTNtMStOSGUzZFIwYnRi?=
 =?utf-8?B?cnJhc2hONjl6R3l3eDhpazRwK3BIcTlJeWh1dmxtZDRJK0xzMnA2Ui84a2hP?=
 =?utf-8?B?VEpVV29uUHBKL2JydmxybkNyRy9rUXpLY0Z2bmVFQ08zMVRJNVVRdmxwMDV2?=
 =?utf-8?B?eXdkdDBOaE45ZHlVZ3NMcUpwT1JwblZxQWdaMk9OVXo4RmRoRWQrajdGM2hm?=
 =?utf-8?B?ZXJSN3YvK25LS05ia05ldko0ZHdseUFrY20xYjFNNW0raHBEWW9uVTN5aFRt?=
 =?utf-8?B?OXVZUDdZMG9Kc2tQSTVmWi95VmpkcFBXTnJyeHRMTHFMYlQra3pxYmpqVlR6?=
 =?utf-8?B?QzlQZElKeUxkUUVGQ2h6a015dGxDOFpFWUMzaGFOSjBGN1dDcWJFMGFLWDhL?=
 =?utf-8?B?V3ZuRzFmbjNtNUdZRE1tRG8zOE9vVUNJbkp6cERzbnFjb0NvcFAzanJvbnZO?=
 =?utf-8?B?Mm5QTEZhamRKWjJaY3J0U2djVWxKWjB1bXFINGRraUdoK2xRQWF1T1p0L1kw?=
 =?utf-8?B?UWdEOXV0aHBFZ3kyVFI4Vm5wZ042b2lHUi9uSHZWSXZvWGpRcFpiQXlMZ09n?=
 =?utf-8?B?VFRmdStlNUt3ZTBPQVNhZHZMM2FuRi9YZGd2UlBkMDRWbmJPQU5DRFh3aGly?=
 =?utf-8?B?NUE1bVg0WEViUTJGcVgrTmhmYk8ra3Fwa1c1blZYOUhIc28xZGFmRWFYNDdV?=
 =?utf-8?B?eUR4Y3RDd05SM3Z5SWsvWWRvWEgxYXp6eWNTYXVXY1YxbWhaK0xUUFY3elAz?=
 =?utf-8?B?cnNRcHkwaVZ2QmFTN2xSUE9MaFQvenp3L1pINVQ2aktjRjJ6SmF1TFpFd08x?=
 =?utf-8?B?UUhxZ3YrTVYwZ3FyT3dXZTk3UHhrVGRhN1RuSkdiYkl4QWJLYUoySG85cGxy?=
 =?utf-8?B?aWNLdTMwWFhYQ3g0QnV0d2JEdWdDNk45enpHbklPL01SdUZpWWFlR2s3QjFr?=
 =?utf-8?B?RVZ5ZGIrVXFhTEhZNDZzSkNZZUhOdUVHenhlRkltYWFRQ09mZTVQYkZvNXh6?=
 =?utf-8?B?Tm90V2s2b3doaE52VmNyOXRWK0QxQzg3YWJmME1TendzV1VoODErcjBzaE40?=
 =?utf-8?B?azU0Sm5JRitjKzA0dTJyK2E5M0dOaXJTaUxtN3BVaWNmek9ISXVYU3g5UnlB?=
 =?utf-8?B?bFBXdVQ0NDZxNlZyZmJKZlBQckdxSHpLRnIyeEdNUUdCK3o3c0FWbmdER3JV?=
 =?utf-8?B?OTZHVGRONXF4WXp1Z0RqVngwbWNlNDFwWDNoQUFQc3FKNkZtODdQT1BEaXZj?=
 =?utf-8?B?dXByMWhUNVRKdTlycEZrMFhBU2xWVlRGZlZRQ245elhRT2RGN3RyL29RZXFh?=
 =?utf-8?B?dUI3aE1UdHdoVFEyZlRCTm4yb2hkUi94cnRpcElydEVRbUpYZjVRTTlkNldN?=
 =?utf-8?B?YVdPYjNjRG11N0U3MC9ZWW9OV2F6VlpOOUtFeUpPeDNZRkhJUnJaVHBzc1Qr?=
 =?utf-8?B?eUx2bGl1T0gxVU0yWVlJMjB4d29PZHVRWFQ1dkZIR1FuVmlHOGpaa2JYR1FL?=
 =?utf-8?B?dDYweVB4OHlZZVVsVmYrUkw1aU14T0YzeDRhUXcxb0JGTzZYSzlzd3JGRDRX?=
 =?utf-8?B?Q0xLSG9xb3h6ZjFxSGc4YTI1NjdiK1FONkFMeXFSUFd2Zm9YOE1zaGcyTzls?=
 =?utf-8?B?RVBkVFhsTkdwU2NnaHhQQ0pSQTFQVE13aUwyYmszb1BxcVd5Wkczbkc2ekQy?=
 =?utf-8?B?bjRsNWZTQUI4TW9ld3JhaFBvNnEvZWZYL25Ib292SVgyWnlRWHFCMDFuKy9q?=
 =?utf-8?Q?AR1zEnISMBkER?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc48f48-afa3-48ce-3d87-08deb0ae844c
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:14:32.8798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFF9A0A2B69
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


On 5/11/2026 8:47 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a13727c0d4..dd54c2fa1e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -225,9 +225,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(smdbltrp, PRIV_VERSION_1_13_0, ext_smdbltrp),
>       ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
>       ISA_EXT_DATA_ENTRY(smpmpmt, PRIV_VERSION_1_12_0, ext_smpmpmt),
> -    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>       ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
>       ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
> +    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
>       ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>       ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>       ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),

