Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC741F013E6
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w249m-00063l-33; Mon, 16 Mar 2026 05:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1w249g-00063N-4t; Mon, 16 Mar 2026 05:22:32 -0400
Received: from mail-japaneastazolkn190120002.outbound.protection.outlook.com
 ([2a01:111:f403:d405::2] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1w249Z-0001UL-Ez; Mon, 16 Mar 2026 05:22:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs7Z4Ws94kBAOA3hltm/+Dpw3qnzx/nLFMnB1TGay5W3RK4wZsB8FoohZeXI7HX8g7JQUqAuTZdFKZV4xDJqMzxzXtRErAzNXSHN7/4Sr38pgVHEYy5RQMvqdT34akEK3xtRa5YzzOjOKc1EJZAsE//rnkLODWVkrOy6xwUZ5hSxHXBuRFv7bkeo1bntG4r/ppqhnAHRQ9wIUdx4Ik8AlNpbgUWReUQY38uV8V+U3XSni4NUBgs/bnOBOg5erjwa6GikqxaoK8xYXMO2fa5TfP13JMH/niH+i92GvEHici1PsP2Zmq20GS+1uPZAlC9Xn7FrbAtW0jydvQ0dUo8bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lsf2S0fyBYByhy+9bKwyT2g2ZXt3KdmZbr5QdKSIh4s=;
 b=wljZH1Qz56xRKilNQzBUmBQxfBwMf64K/18XGOWMluYIY26u+RKKjFzNTDI7mmotq8kdNQgHh9ulGZhy8wVQMtube5JPRsXeXJWMws8H2CbIDQ5JpA3mQXG3nIeVeI1fAZHzZjquVJguhXkOS0rMzX6NxCrxvpD3ZAsE7pi4ZAGlhu1ahmh9NtV+/0m0achJMAff784FFbXkwX5mAqawu2Bftr3//HUWZAd2LpMjyJgnHQtzB6xPcY2OkJRUzjQ8Ck2PyvZpZMKmOCZt/8fYOmkbVRJYJNVDAWAcsLAazQn21NYpFs+H556YjUneVQgRFH/IhK7X+EpWO+/fgMNGyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lsf2S0fyBYByhy+9bKwyT2g2ZXt3KdmZbr5QdKSIh4s=;
 b=r2SfnfqjPJi2kWJ8OM9FaTEng7VJ4sZNLLOsMfBDZfgfEhXGUm2R7nF1tictV4FsZwkKX0FMjErXEiencXBv+88vnKFnWXFm05pJwRSuI4/B8zPYbIxLmHticl/fppFMqCPgSoDIDNhY3iJF54gUE6D4DId6WUdGjcdbddECj0t3Xc1VTjTtyH0GK7ryQOf8XRSMnyRwQmfIqfiN6SikKlcAWwUO6hJn5SFUkubn3MePz65IqIiQ9hKhhwwdp5nnM0q62wBh7yXKzbi19x823SFGHqxKLxwN0A1QtY/ajiJih/mZd0sve4L+maN/WidZb6TtlCEdn1pK8Zvse91iAA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by JH0PR04MB7227.apcprd04.prod.outlook.com (2603:1096:990:36::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:22:17 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 09:22:17 +0000
Message-ID: <SE3PR04MB892294DFBF077078C65ED116F340A@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 16 Mar 2026 17:22:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] target/riscv: rvv: Introduce reset_ill_vtype to
 reset illegal vtype CSR
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-5-max.chou@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260306071105.3328365-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <53b26f98-8cfa-446a-8a99-79c6cf55fdab@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|JH0PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a6c211-24d5-4dbb-766d-08de833d844b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|41001999006|15080799012|23021999003|21061999006|51005399006|5072599009|6090799003|461199028|7042599007|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW4rMXl4d0lWREpxTHNwUktBL0Rob3VDa3UwdkxTdGhLc0ZGVGJLVk53cEFt?=
 =?utf-8?B?dVZvODk3a1lDMVNVN1NUaVB6MW5iaEVPY0UzaG9tNlUvQlZxNTJMSzR5a1FH?=
 =?utf-8?B?MDBVUHhDSXRNdlBTOThyTTE2V2ZpNzd0bUJUbGFJbHMxbjhKQzBOSzIwT2E5?=
 =?utf-8?B?V0pNVFYrbHI4dEtJdUJIQnNCRkhNYmQwNXlJRk5ZaTNvbkt1b2RTK2gwL2RJ?=
 =?utf-8?B?QVBvV2QxbmZHQmp0R2cvdXpSc043ZmVoQkhMYndHc3RuYUV5cy9HcjlXblRa?=
 =?utf-8?B?bXFDL0tHSWwxUCtLNXFIeW1ZalM4Vkg1dXc4SnRpNjAxSWpOYTFZMkQ1WUVS?=
 =?utf-8?B?QVVkUWxiektNVUkxd3R6aWh5TDNSL3lOUGp6aTF6Rk9NSE9ZQXEwKzUvTnBC?=
 =?utf-8?B?Q1k5MkNSdWtCNnhCSEFxVmVZZ0N1OTJSWVlndjJ4VkxuWlB3eXdPUllaOHdi?=
 =?utf-8?B?S3VpWmlJcG1HTitaQ1c1czZZZjJoWGo0a3M2MzJ6MWJLeWpWZUJHNW9mWjFJ?=
 =?utf-8?B?aXFGdjZDQ3RQeGw2anZyM042MUhXZzFHTS9KbUY4c0x3YmoxejVzaUdwSnRV?=
 =?utf-8?B?TmJDWVlIRktOZUtYc0NzOWtTb3VSQUpjNFNBMTh5eUtBdjNMU3ZyVHhCNkRS?=
 =?utf-8?B?NkNNTUFBQ2cxTFZPK2FlYllROGRRUzBkRW5RNVlFN0dlOXdIY3pvdU43TmNR?=
 =?utf-8?B?dVlMK3laRk1meUdaUllOTlJqZlgzcXpSN20yN2RmR3U3TWlKNnBwSjJEZTVm?=
 =?utf-8?B?cEpXRTg4WFo5eTIvcTNOL2Zna3RHZEpiamlCYUtVeU1MQWo5d1B5ZFFuYlJ1?=
 =?utf-8?B?OG5sVmFKRWlWL1VqT2ZvVzBNZUpicGVzcUUwSXJFWFF2Rm5ZeVk2V01DZHhI?=
 =?utf-8?B?SjJGUkFtaWtKSTlmZkRQa3R6bVNXNlBEZk40ODRaWjR3TStwU21NU21vdHhP?=
 =?utf-8?B?OWdwb09WdjI2NWwrUU5PelBJRTJYbEg3ZlVtdGJUb2RYUWx2N04zVk10M1B0?=
 =?utf-8?B?dkFNT2RFTjUvVFIyME1VdWZ2UDJucldmQVhmYUtOb05HLzNzUnpGUmpqOEpJ?=
 =?utf-8?B?S3VVdk0rWGRQc3pRcVdlOXZwOUVnYWc0Tk4wUlVERWd1QjVtSlJVNUVydFFS?=
 =?utf-8?B?K0UwdmRpT0x2Z1N0eDNleUl2bmY0NmRSRXRBYkJNaUhkaXNBK2J2NWRLVzk5?=
 =?utf-8?B?UU1NK3h4ZkRUdnlERXAvZ1ZjK2YxMUN1L00vWTk1MWdLdjE5Nlg1aFhFcFV6?=
 =?utf-8?B?bHQzT1FtUlU4eTF3dE1KRUEvWkh6ODlmUll0K09mcm5Ha0NCYXgzKzBZMEZB?=
 =?utf-8?B?Wm43K3Q4Tk04cmNSWmtodFFaV05zelkyRmJZcm5obVJPMEhoMnRCRXNPUlZ2?=
 =?utf-8?B?VGh4TTIyRVlQaUE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3BYaEhqRjRWL2xpSmhQTFhtM3dGenZUcS91MDErV0dKMDBTakU2QzhISzF5?=
 =?utf-8?B?WnlWUEJ5TU5VOTBEVFFRYVM5WkMwN2MvaEZlU3FMenhHd3ZrNm9zdUVlSTQ0?=
 =?utf-8?B?aDcwQmQ0R1RUZmtMTHl5bSsraGdySi82WmZvak5Kd29QcVdwN0xLV28rc01Z?=
 =?utf-8?B?YkVPU2RJZEl6WXp3WjA1a3BZNHFKeHBWUkVHNkVublJ4MEJ2OXJ5dktHekZP?=
 =?utf-8?B?NjNFamZNemdGT0xXTGNKa2Ixb2xJaFd4MEpPNy9zcEt0SWo4UlhTbitpK1Fa?=
 =?utf-8?B?Yi96NzROZFFzSTR5NC82OFhRZHhNTjVxY3dTRmxnRUhxNlhjcWhNVUY2OU81?=
 =?utf-8?B?VmdEWnBERlJOellCVFFwOUJEZEV4T3dyd3BrdjBuWlo3eWFCbUdZQTBNYWcx?=
 =?utf-8?B?ZFVjNkJUMnhnSFpVRm5WN0hIMFpMQ0FWdjczSnRDcmlwMVJRRU5aaVg1MEZm?=
 =?utf-8?B?eHFRd3RRSDQ2Y09iNjNWQ01wQ1pOd2NIbmZmWitkQlovTzUwd1RkMDRWWXFs?=
 =?utf-8?B?QTBDT3p5R3V1dmIwdG9pSEN3K0RUblJUU28zNU5SZmVtSUJjYWNkWkRNM3VD?=
 =?utf-8?B?dDJtYWV5cDVVdTdwSkVCWEcvSUFkUjBNZGZ1MWNTWCt1VzBwbUNzTUJLRUpn?=
 =?utf-8?B?Vlg3MC9jUmp6ZTRNaHdwY1VtWi8yWVZJcnlUNDVHczJDMjVBa08vYTJnZWVV?=
 =?utf-8?B?ODVZU1JZNk1aWkNBZ3FMcXh4SU0xTHNkWFdta1IrUENxbTVjUXk3VDFLVzU5?=
 =?utf-8?B?bERRaTE2cXhDcC9Cb3FQa0JRR1FITlVmd283RDNGa1hQeDEyS3dOcUc4REJT?=
 =?utf-8?B?dlFCTUNWRHc3cllDTWh0RkRlb1lBVWZ2RVBROVJabHJObXpHT0E0TDdXQ3hH?=
 =?utf-8?B?VWJhdHRQVWgxWWEwY2lkVWdYdHlXT281M2tlUzhCd2M4K3FBcE5FN3QySnhE?=
 =?utf-8?B?cTlKSkVubisrZit4OXpVa2QrakhUemVzdEJQd3o2WklYM3lrQkZJK2Zrb0Y2?=
 =?utf-8?B?dWtiWlN5djF5YzBoRVFvZ3FzUWR3M2RFQjZoZVVhdWpST0hXSUV4cWZOa2lZ?=
 =?utf-8?B?aWV1N0czSTlWU3F4QzJvWTl0ZWdRWGxuZkwxRXQvSWUzeGU5RW9KeStyZnB5?=
 =?utf-8?B?MFlFdUVCS29hUTRrMjUxZ1JpUUxtK05ramlpMnZKYmR3M2tVaUVuK2VFUExX?=
 =?utf-8?B?Uk9wc3JoOHo2eXRTOXpWdTl3SHdLTXdMOVo4Z1lHMGVkT01INHkzaEZHZHpL?=
 =?utf-8?B?a0JVcE1TTzcwMXRXTHJ5TVp1YjFWVlRIWnNSTEZPTlQrZ0c4bHI0TnhEbW4v?=
 =?utf-8?B?TTdLcTR5RXQ0ai9NUWdIQjBvVXEza1BRZUNWMUplajQ1UzhmT3orczg2M0J2?=
 =?utf-8?B?RE1PdHNuTXBiL25SNHdYTHVBSHRKVE95ditaUlQyUzBPWTFkQVdHeWFScnNP?=
 =?utf-8?B?dXdrQm1DeUhMOGVHMFhlMXlpdmlmQ0d0WFhRbkVjUjVLa3FoeHJ1b1lBSjFs?=
 =?utf-8?B?RW0yTUhSV1M5ekdETVhpVXcrRWJGQm1wWmI0SThpVE1pNS9EazI3NVlxcUVR?=
 =?utf-8?B?MkF0bzE1VTVjTFlYRkliUTBSZEhaa1JOZitkSTFhanovT2xPTFp6Yk1FU0g0?=
 =?utf-8?B?UzdsR2FWa2VWYjA3OGdwT3NucWlWdHREejVQTDJ1NUxkY1VHdkFEU0gzRUJX?=
 =?utf-8?B?MUZhOXB1SVZCKzJXdDlUR3lBa3ZvSlJqUVovT0VTeTBMMHQrRWlvOFBKb29O?=
 =?utf-8?B?cjZVeUU2ZzE5andkR3RBcndUSWk2eVpxT25RL1RmWDh1Y0JCQW9jb0xpTmdM?=
 =?utf-8?B?VFRZejdhbjZlQzVrUzdFT2ZXZCtSQU5sYmEzckdVYStSY2RFQjZ2dzdJZ21C?=
 =?utf-8?Q?71Ty/ocNIPex9?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a6c211-24d5-4dbb-766d-08de833d844b
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:22:17.2705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7227
Received-SPF: pass client-ip=2a01:111:f403:d405::2;
 envelope-from=nutty.liu@hotmail.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/6/2026 3:10 PM, Max Chou wrote:
> Replace the same vill reset flow by reset_ill_vtype function.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   target/riscv/vector_helper.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 7575e24084..b7105627ed 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -49,6 +49,15 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       return reserved;
>   }
>   
> +static inline void reset_ill_vtype(CPURISCVState *env)
> +{
> +    /* only set vill bit. */
> +    env->vill = 1;
> +    env->vtype = 0;
> +    env->vl = 0;
> +    env->vstart = 0;
> +}
> +
>   target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>                               target_ulong s2, target_ulong x0)
>   {
> @@ -93,11 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       }
>   
>       if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> +        reset_ill_vtype(env);
>           return 0;
>       }
>   
> @@ -113,11 +118,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>       }
>   
>       if (cpu->cfg.rvv_vsetvl_x0_vill && x0 && (env->vl != vl)) {
> -        /* only set vill bit. */
> -        env->vill = 1;
> -        env->vtype = 0;
> -        env->vl = 0;
> -        env->vstart = 0;
> +        reset_ill_vtype(env);
>           return 0;
>       }
>   

