Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72419CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGf0-0004lI-Cy; Wed, 13 May 2026 16:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGet-0004jc-OH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:58:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNGep-00028G-LQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:58:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DFdqtu1242893
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sCYTS6cUIMiBOFV//CV+Y5hZm5gupErP232c5aZgNB0=; b=UFlocagEzaCbJa8v
 cta0NXXQLjtU8pUQ67pfsj5rZcXt2A3Hvkc7IpjAM+8POfynqwb+2aFrr53WfWxj
 8C0giJE6KlgDZ6vQ0a47pwofUB3nLn3af08bKqaEvAAAXCOp2pwvHRCaQd6U68NP
 IOPnXklXoGgJ9Bw9i/Jm17XfoITi/Aa/3gdbwWEnPh9bQkv97Y7JeoR2tkLjo0U6
 kCa81KPl2n9/hxHPs2M+axWvohalAQfvHj5X/h0wkcuXnJpLK3Ac2/bTGnco93Rl
 RdsZgkl/oomVZK4FGMr3tXZuh4VfGOh0hoyKJr/N/qM8OwOgFvo6N6trUjAV10PQ
 SAGdpw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4tsad1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 20:58:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b3fe2f190bso207835846d6.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778705896; x=1779310696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sCYTS6cUIMiBOFV//CV+Y5hZm5gupErP232c5aZgNB0=;
 b=ScMPo4ER2v7REA3UiTUQc/LSz9pGhQF300hq2sdMGi/o3x27kLrkjqBd/jrV2lNh2C
 d6JMPszUEZRxekqwg4tvaIkS6uN6Z24DD0kwQQx6ly6KMcmCqr+ThzmMxz0nDfc99iUo
 ov9FwdkButCSjiHqFxD0rklVcqjQlulb2I3vTMC0eX39fL/R+3yWvOrFeX0dT73i9ukC
 PbdcdjPPMcn2bFCDCzrywnFxwdgDoiPpbQvMClfS+kYlBTxvoU4StUUbo2/AFIq6IAG5
 s017o/oPQ3dJNABQEMYaaOkh8ztV6n0tOlGb86MiKYQAofwvdLXfqKiR95LaaCEBfSHD
 2RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705896; x=1779310696;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sCYTS6cUIMiBOFV//CV+Y5hZm5gupErP232c5aZgNB0=;
 b=SAsTA8ezfm701rc+SC3u++2G8kqwvWJgnGMq3Je26yC8LWDPYt6RZBe6+BCAwP1NB9
 H9Ue7dx/F44WAYESLRK5/iSwWQB1B4HZjMnRH3MFLYZQeyklW4of3mChZ1PljiDIeXlc
 yj1Uq9C9NRBnSZ1S6zs5Bkq1EDhLJ0PfSTIi/eZ5JQ8/uL50/e7pDs5/CfpGB5yZ8sMD
 08g5UYtjhe+hjkzYxGHj3YWvkc0YspW4GAtW+0W8pAITfqmMtM64kx80usFaAwhlEoIb
 noxDcxGSQYrxRYS08HFFwFdHYCi0Yw/W+kaLzmz6QFD625IHHfLHizrCjRBwCSrisLXN
 UyMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ulZxudVpDg9C5vAOjX4WDOvM4ZZMOjCxoxsShlr0/W6K0/TCwbA3GvCflWaEZq7ytBFpLoHpI50BE@nongnu.org
X-Gm-Message-State: AOJu0YzHFEtcttai+cgdR8lnYWhrhLeIv+fkcc4jPcQzuYDGw9/DWssg
 ZYiztfxEM6IBCOBI8kxxqcjFc4J1rhENhsHkjB+FrVGNSP1fwj0S1iTs8hpbmDtABtCQIcm/NI7
 cjV6um5zo8zPMYh33r8O+6TcoKwiNwXtwBurMrRwZjWbMEWpzENIEZlzFCg==
X-Gm-Gg: Acq92OFLa7HN9s7xB2ZiiNaf3CXmvUEeGZIApv25KyAD5S6C+sy7wHs4J+7ad+XZMXt
 Eef+xlPUJ2aad99DBamuqBdOnqFRWYHnSpZj5LvnKmxJh0MhGfQY8gn8LDUMXBmJ62HoV2ty5oU
 80Tc+AARlb8M8iMmXMzbn0nunDu4O2F+3mOWAcmZ2Qsb3vJOEtSgry7fWudIh6NT8hH8a+2O6FA
 Bjtkeun9yyJAduEf+IVNCbbW4SP2MbwgTUboHZzLFk+1QKgqnChY+oZznK7N+n9n8FTCmxS8+3N
 zBVREGlwBvG4PFKfSeLurcMz3WaK/+J0fDUNDYgyKLigpBWqdRcA9YVY1yUMXI25s0W7ul2NwiF
 0Uh5zf4MdrLg1339q2NLXMe7rl94X07hV3xEmeECp2tHNq0w4WWA5+PqdGjU=
X-Received: by 2002:a05:6214:4697:b0:8c6:1e19:80a4 with SMTP id
 6a1803df08f44-8c7bc91b0d7mr71052336d6.26.1778705896303; 
 Wed, 13 May 2026 13:58:16 -0700 (PDT)
X-Received: by 2002:a05:6214:4697:b0:8c6:1e19:80a4 with SMTP id
 6a1803df08f44-8c7bc91b0d7mr71052116d6.26.1778705895884; 
 Wed, 13 May 2026 13:58:15 -0700 (PDT)
Received: from [192.168.68.105] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90bb82a7asm5895496d6.37.2026.05.13.13.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 13:58:15 -0700 (PDT)
Message-ID: <d2af8082-576c-4601-8021-5ae186a4e25a@oss.qualcomm.com>
Date: Wed, 13 May 2026 17:58:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/riscv: clear mseccfg on reset for all dependent
 extensions
To: Zishun Yi <vulab@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512052240.330815-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260512052240.330815-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a04e5e9 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=-DdblKx1g_8m8Nr2_H8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwNyBTYWx0ZWRfXwTLxFkyLsrNI
 NQ+tQ4iV/9YmiiYUfvKlzajU2y/jztyUvSBBg2Qrci53uiI8hFFZKKH9xccorkKQKNWc0oBnc8b
 QKM7SB9DJOPGlYPWfwsRz13otDL7Hi/tnp/PCLK8/x52ELrN56P6UbRf0wbhJdlHZdd3ltLQPrS
 ROXV4ZZf58mQbOiHZFP8bNBs4I6PxwDqGWyFmN4osKpUA9WbG7U0rOwy3zfYV/JuUUF8yXin0V2
 SxpojnRl51v24Ib3wbuCMjcf88lBw/fYLwxgCxq9jrkzIk++rA+oDx4x4g2UzCJY1V5q3F0OxHa
 oinP9WuY2YxFWJUGF703H/Iy2wg3jwUw8y/l+SDEKlZWKSM6qIE6ApAIW5HYQPgTR4Ts6YkQ1OP
 M5NbvslMtzKRBnJYEftT30xYrw3AmEw4AoenB1jaZmO1H8BjiytDeC78l69ZAmxNgy0iP/LGZg9
 QBxwyxNYt+tBmpVwayQ==
X-Proofpoint-ORIG-GUID: B44E6o66s0W_-HtARa6mMux31bIolVRN
X-Proofpoint-GUID: B44E6o66s0W_-HtARa6mMux31bIolVRN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/12/2026 2:22 AM, Zishun Yi wrote:
> Currently, the `mseccfg` CSR is only cleared to 0 during reset if the
> `ext_smepmp` is enabled. However, this register is now shared by
> several other extensions such as `zkr`, `smmpm`, and `zicfilp`.
> 
> Fix by clearing `mseccfg` if any dependent extension is present, and
> adjusting the relevant comments.
> 
> This vulnerability was discovered and reported by SpecHunter, an
> AI-driven architecture specification analysis tool.
> 
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-svvptc/pr-134/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ce15a17c37de..3cabfeb1fa7a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -756,10 +756,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>   
>       /*
>        * Clear mseccfg and unlock all the PMP entries upon reset.
> -     * This is allowed as per the priv and smepmp specifications
> -     * and is needed to clear stale entries across reboots.
> +     * This is required as per the priv, smepmp, and other security
> +     * extension specifications that share this CSR, and is needed
> +     * to clear stale entries across reboots.
>        */
> -    if (riscv_cpu_cfg(env)->ext_smepmp) {
> +    if (riscv_cpu_cfg(env)->ext_smepmp ||
> +        riscv_cpu_cfg(env)->ext_zkr ||
> +        riscv_cpu_cfg(env)->ext_smmpm ||
> +        riscv_cpu_cfg(env)->ext_zicfilp) {
>           env->mseccfg = 0;
>       }
>   


