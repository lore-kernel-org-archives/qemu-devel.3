Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB225C5DF6E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wveM6-00023w-MP; Sun, 16 Aug 2026 13:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wveM4-00023E-D6
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:09:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wveM2-0003pk-Rw
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:09:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlr333611549
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 17:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P471K91sSjLLshmItQyYGmAoYtVybZk/mKncMzbt4Sc=; b=C4EOZBfrTjS5+E1y
 +EMJ+gh20gvqwtWSOzpwu21AlS+ZtnF+gp06j75Z+l5kgYWTjmPFmK1rxbN/IsUa
 fmVFuOGPSPI+fvXIyL2Z/23aDBDH66/7n2EGwbexE4cI4lu5zTrzzxySFelpM7ic
 mpPTKdP0eXsGyHbaogXpOClx+R4RUINBrs1cY1GKXrXjWXmTk7XC/uEMeh9viRIG
 pnoUdgqrgZ4mHKhz+XwZpCcsi4hdrscbdYLwUG81gn5hTSjtMVu10IjFKx/l7Bee
 RWtN/u29pWg30Wn3oJuHdezpCrtrREVRSmgxL+uKywBiQbEGkS/lbfnnEZ/aZoTu
 YZfJvg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfuuaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 17:09:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d827597fbso40319031cf.0
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786900134; x=1787504934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P471K91sSjLLshmItQyYGmAoYtVybZk/mKncMzbt4Sc=;
 b=YfD2LharAJwQhzimbWRMNj8WeQKeqy4BNCrbfSiOMrQb078mwWftdCAbEWXYPVbsO1
 vTj4DpJ0EkjGae/t21eQSdCD28a0Ev8WXQP0H6cGDTuuxG2x5peHrNXgAK0XOqsTyeJB
 VUNsnNvhOj579P1hAKA7QRLxGKUTvPJg7QuKdtFjAJP5AaTVDOzTwVtfntLLeFUesCW1
 sOdhk/qFFRzCY9EkZvBlfrhBjdRHT6UbJ9JKyV5x85YlzmWiBjvRV0xqScwF619IAKim
 0s8r22U+kGntayUPbdTlO9nE4J3Blo1qrlwsaCk0714/cVFSNxPiyTCQu454cJIX7VGF
 w5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786900134; x=1787504934;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P471K91sSjLLshmItQyYGmAoYtVybZk/mKncMzbt4Sc=;
 b=eCpdjZMzW/HLKbQWIE/iN44bHJArcaJpFvx3SA4U/ng+uw211vN+n0rfkkErUVEggE
 WeclgpXd83zN3v5AQPhMi8uIB1po+7Ptb6U4yIVCwOwzsK6+W8q4Mbaa+rzB/rjzBJrY
 gYdF0lAFQFYzhTRq2WPHoAV1KaYvJtr2vR+y+yEeRLkWZYPGy9HmoMsubiCAB7Ybc/9Z
 yZJE0S8XbicllP8Zr1Cc5WhvAtxRmzuejLs1hH+DOqfozuIRxZ8XjHFazEeR7w9j0D7o
 vhUuaX6wkosBUpbmUQHOwbVr8IDjjjrLX5bHcNsqp1dVPzZMvcMkqjZN6r2J75yvxCuU
 2nSg==
X-Gm-Message-State: AOJu0Yw4FA3cwuB1sjFjSWOPTcCmEedQfr5btJVRGH4VccBJCJ+03/cK
 0dihgIPFXJDplGVdTpnUlPjNC6rrWExurYSuncHqMiFc5loMR6mL2YwSIknT9C24sUtSyGa5yAY
 oRECAVvxaNOqvYUhN+yQhZe3o+0sDLGiixPQIJIhrghSMZiZKvyahFiD47BqKcChnJTlA
X-Gm-Gg: AR+sD13aysfMQWeKX/vTks8yh5uj1MUuDUu1lJlpBlFJeNWAHb6nzXNr5RaqKlk4Yxt
 zz3L+OKXWUU9LR+gSa5fuThSOQ8HsYS4IlwF+TcBX7Y9z9AvRwLKiy8GxbihyFrf4eo2wOcu2HN
 6CFRp9FDrVLqoD4a3r7H9NJj1SGg904yCVpAVZ1RNSPs9MTMH/cTaFL0jpk9WBfG8tW/HRuad5d
 ZPHFwINm648p8E/XOn6JhJ+hC0xnZe7z/RMt1r+3bGLMtjTzILQjzp1jc2PXQlsIBXE1mgzhXG/
 NkaM6ZqPzFqb8ixfbEKVkbajG5rcpx5+NkqPVWkJIqwT0e8cQvjqJ27oBGmdAX2RlFZaur9+tdB
 9h0YihksXTalBaH4pfsYJnLw=
X-Received: by 2002:a05:622a:c6:b0:51c:1e2f:1281 with SMTP id
 d75a77b69052e-52d854f1871mr212658311cf.42.1786900134157; 
 Sun, 16 Aug 2026 10:08:54 -0700 (PDT)
X-Received: by 2002:a05:622a:c6:b0:51c:1e2f:1281 with SMTP id
 d75a77b69052e-52d854f1871mr212657691cf.42.1786900133685; 
 Sun, 16 Aug 2026 10:08:53 -0700 (PDT)
Received: from [10.111.141.238] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm96599925e9.3.2026.08.16.10.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 10:08:52 -0700 (PDT)
Message-ID: <0f89046e-6889-42a4-a967-0bfaaab869db@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 19:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] target/riscv: Add Zihintpause support
To: qemu-devel@nongnu.org, "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Cc: Dao Lu <daolu@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Heiko Stuebner <heiko@sntech.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20220725034728.2620750-1-daolu@rivosinc.com>
 <20220725034728.2620750-2-daolu@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20220725034728.2620750-2-daolu@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDEzOCBTYWx0ZWRfX0C7c4aK0hoU7
 sfUEMSeDAIeIlIClXoN+N6CYxPdHzGIgSCbStjBkEYURH9xAobyyjloKsTL7oNczsLA2IQHgprh
 wux/Mtb3XN/vCMG3NX6FlSpChEJ2Pp8=
X-Proofpoint-ORIG-GUID: dhTHB_1Y4ujKhjFrYneIlBIr8LwnuUXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDEzOCBTYWx0ZWRfX7skjTtqa06sl
 SzXdgN43BHUeUyP/zfwbsiW8pYQ1er+QHkNym9Yr+cSavFPS5q85arnzgZPy3wjzVrDTWipys12
 u6BElMcDWbZp74LHnjOmV+bzTy6RmeTqLUS4LLiyXC/1gFtxna7gDKrWzWdbMBoDUwVRr7+petK
 YQOJQVx944UTrPVuI0P/QPuY5Ud7eoUb3h/06TqT4YikwDoBNs7y5x7z9TvvdmzH2tkA6FmXV/t
 mEv/+n5Ky+QtZnMRC1TVosmvdGcgLIXJCjIo2ygpTpC5VfBIrrKOJEk1uMX2OaxKDsWsPkNK3Rn
 EttsHdqE/T27xQnoQS8bqc+UEgVufLaNzoPdEA4lMohQe+nXVhQrAqZNF4CnDAoLzQtIJehjfgt
 o0gTt1ON7m0PLlpGLfw6jyuRSHZqconm176HGfhADJ0rk/ekP3pK7JFo7lniiPYRPoQTWKe3LkF
 WOzI1yO8FRsxwnFnShA==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a81eeac cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=JF9118EUAAAA:8 a=h0uksLzaAAAA:8 a=mHwnvXAwzdtxKzu_xlgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=xVlTc564ipvMDusKsbsT:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: dhTHB_1Y4ujKhjFrYneIlBIr8LwnuUXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

(now committed as 4696f0ab5c436ed53567ce6baec67c921d9b70ae)

On 2022-07-25 5:47, Dao Lu wrote:
> Added support for RISC-V PAUSE instruction from Zihintpause extension,
> enabled by default.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Dao Lu <daolu@rivosinc.com>
> ---
>   target/riscv/cpu.c                      |  2 ++
>   target/riscv/cpu.h                      |  1 +
>   target/riscv/insn32.decode              |  7 ++++++-
>   target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++++
>   4 files changed, 25 insertions(+), 1 deletion(-)


> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
> index ca8e3d1ea1..c49dbec0eb 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -792,6 +792,22 @@ static bool trans_srad(DisasContext *ctx, arg_srad *a)
>       return gen_shift(ctx, a, EXT_SIGN, tcg_gen_sar_tl, NULL);
>   }
>   
> +static bool trans_pause(DisasContext *ctx, arg_pause *a)
> +{
> +    if (!ctx->cfg_ptr->ext_zihintpause) {
> +        return false;
> +    }
> +
> +    /*
> +     * PAUSE is a no-op in QEMU,
> +     * end the TB and return to main loop
> +     */
> +    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
> +    tcg_gen_exit_tb(NULL, 0);

Looking at this because I'm auditing the overall exception scheduling.

This is a clever way to quickly return the inner vcpu dispatch loop,
but doing so we can not reach the outter loop to yield to another vcpu,
so I wonder if we shouldn't use EXCP_YIELD here. The problem has be
unnoticed because most of us use MTTCG (the default) where EXCP_YIELD
is irrelevant, but I expect this to be problematic on single threaded
round robin TCG (although not reproduced). I noticed that when working
on the hybrid accelerator project -- which is not merged yet -- where
we use MTTCG and EXCP_YIELD is returned by hw accelerators. I'm happy
using this simpler helper, but since this is a big logical change and
I'm not familiar with RISCV I'm am not certain:

   +void helper_pause(CPURISCVState *env)
   +{
   +    CPUState *cs = env_cpu(env);
   +
   +    cs->exception_index = EXCP_YIELD;
   +    cpu_loop_exit(cs);
   +}

> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    return true;
> +}
>   
>   static bool trans_fence(DisasContext *ctx, arg_fence *a)
>   {


