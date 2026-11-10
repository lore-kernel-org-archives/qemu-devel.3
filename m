Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5E606B518
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PDrdNFe3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b6MfZSPl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQaoA-0000qt-Rk; Mon, 09 Nov 2026 20:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQao8-0000pf-Az
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 20:37:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQao6-0005lx-AR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 20:37:56 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA0j1jx1850069
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 01:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HMBvv4/GXesdt4ZfqowYEL/V/66J7mk1egoYh0fHzeY=; b=PDrdNFe382fEHsf8
 gogGsVRu6LtMBwbaahllrk324O4UigvRb3NybSs0gaxLuzOFZrSRq4TlEcgsu5t7
 OczEu3nt+1SGuv/mhur4mkI2N0HmnfZwsxEM60TMGF7dHRR1OmfHfUAsiB2kXAN/
 wDeTXi1OQSYdy1xmG5z8jG+npeCqaFhA38T60f5H0ZFWUGb7NW4/d0YBYusQ1PnE
 bQDRnsaPuUF2n0LD3lDBbI6ablHdDNCekzJWriYXUL+Hg82LWCdi0LHmzNdnBbtg
 sPW+fn3xT35UYJEbTqFd8Ai2TkvRZL1taipIrn2JjC/1ubBjMh7ofqAvLd+Pynge
 7bELEQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5u0an-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 01:37:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-536778a8137so29740741cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794274670; x=1794879470; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HMBvv4/GXesdt4ZfqowYEL/V/66J7mk1egoYh0fHzeY=;
 b=b6MfZSPl/63/bGCvE/lm43xdTcf5h2BsV6nTVmF5hglSoa9IAzTA+Nf9boRxMmhJUY
 kwNgxfwPA4Zwhr8zYCfYi5q1KTFqjUJXNShT5eJcLUNWyVWp/pKY5hjs9A5TQzpp6g7G
 xy2duce6/+6EkHsMMKcT419zMfxu43/Y2oQjNiQ/uZJuLRTYt8TbDQWQsQnpKq6oaiom
 cGkI/hMKsiPL/h6N0/O9h0gMpQQi/SaCusqbfHDye6V6cf9azSB9ph34Oh75hXWo7rDH
 1tBsg6r+IBODRoPxgk4sc/dod3YwlIqJ3OAgl8oRSudidPDqM4F8Y/Sx5cq07my9RUgp
 9fOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794274670; x=1794879470;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HMBvv4/GXesdt4ZfqowYEL/V/66J7mk1egoYh0fHzeY=;
 b=eUcNgCeglSHSVmNfb6xNA3eZ2WDmgcSOTk4E9UhE7HScm9kPxr63HTDNahdUiYTo5W
 Q1mpZgrhrkLlQBoSLka2brxxl+Z58FmYeNE64nhn/aJ/6nLNjw8OnhRZWnu9J6Ja8Bg4
 7kPbzUQUX9hMBsFoVtD7/wtCfbp38Dw7w2ZepcsQ7zXC6JBYwg03Nd452gy6tp2QzWHU
 G+jj7ylIDnmcFthWk8L8qeIFqV+y9A56IgXYJtuVnUYZtbfjqGS6zPxuuY4Xc4LJhDTb
 RYgbgxbKbv+W20zBV7fQPOJ4MpnTfdb1BsfamUDYg+y8E/LKT86C8SSFpnQeqtbsguI8
 U3Vg==
X-Forwarded-Encrypted: i=1;
 AL+hErFUinCb4IoiUtrU4tQTFdFW2ZjexbieuMijMkOI3pudELxfG4Jw3kHGtmGrxXFB9zGSsMv5O/b4OoeY@nongnu.org
X-Gm-Message-State: APuU4Z+FqOc7Hzpt789CE/AGANDoHFMlAj/n6pRUf60AyjvzsYvOpCli
 IOztHNRaqkcTEjfZNCShn5aaVJBYtnAntmgWPetie8pBlsLHcsnL4NIjzpx+v49mnskaTGSyDxk
 KXujDW5JQhOdaIutan0CUXeVcDKrj7mb9ThJiNg9rAuNsiGY1pf2mpYsNuA==
X-Gm-Gg: AYBFou0Jvt2KooRsVoYCp9HdiMklZDOIkHKHuwZ7D32iV5t5GQh9Aw32qd0A7yvJmk+
 +KmB33HsnaDOlUXxI9EqFnlOJ+cCndrYPzjZp1HdHCoyDqNfTaHK3xWWAg9G4VePezzn8nzi83C
 RNpOjd55bbsvuVIaU3Qnct8d9pd7Ffx1XNJCMcGLlO59JnXp/f/Wad1FF+AfqA2Xv0ZWDHrw+HV
 8AmwiU7gFIIxKZc3ZRLteiqBfaRa2TnZLjoZ0SElBGE7Pc2axe9m/gkxB53EVqXzKQr2+rwPg5t
 HfqDbpR/6L/eO8qSDVugrKxBQTbzNDDkzcOtiyNMcOGeNzdd4/tBfhL2pTwGd8/SY/Gydmfl0Ah
 aQ2iprS2UuVpUeWTTGHOuiNI2rb+lvi9SfFXgeJQlEEq/9ego0zSwGVsmcyImvEmyIMT0NmC9hv
 wdSq8j8GnuXL0MB1KH1+p8AEqe37CwAZFZpC+osXmTJO9SVpw14kY=
X-Received: by 2002:a05:622a:488:b0:536:55d2:c41e with SMTP id
 d75a77b69052e-555289d5a0amr17855481cf.40.1794274670314; 
 Mon, 09 Nov 2026 17:37:50 -0800 (PST)
X-Received: by 2002:a05:622a:488:b0:536:55d2:c41e with SMTP id
 d75a77b69052e-555289d5a0amr17855261cf.40.1794274669571; 
 Mon, 09 Nov 2026 17:37:49 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef052653bsm9331356d6.36.2026.11.09.17.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 17:37:48 -0800 (PST)
Message-ID: <1606044c-ee92-4cd3-84b6-25201a0c05b0@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 19:37:46 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/hexagon: serialize TLB invalidation and
 IMASK access
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com
References: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
 <20261109232142.4081792-3-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261109232142.4081792-3-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwNiBTYWx0ZWRfX0mOuO8Nzxgqk
 IXVALa24HsCPIfrkyP8BOjZiFPuZIdYFoQ1HtEGYxWngRtM4rC5ZjFjmEFgSpzVGL/CwW/NQapD
 /gZwqA7BCkfmJAX2o/+YAO2c/0DM8Is=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwNiBTYWx0ZWRfX7NE/PCRVhhQ6
 Hm7tMkmo2r43kXd81Lklybe9TFP1swtCA1Wf2tqpNHmFh29UTSPv2C7LwUblLyeVTXm9s2WrYCQ
 TIXX9DMyheA3yK4Zk/sRI4NZ9HfkHoVHRV1Gr9iLf6CUGPmYiZ2W5qYfqMCeqtFhwZOLU1CAs+g
 wB5q8rM6ncoQNJTmkFXBXwdrGaPYUsxMfS76LYHbNoHCfZiWx1zxHcvXr4nmjZOvfv6SwhM2oXd
 BR2xplw7kgoBVQc9vj5l+bdiiVyniJSVHLlsZJkF1idDnYtfiz39yZNGpRw/abPXQfiu3VYS2ai
 uV8thAQgWLnvHzNYJTFD3nJd9ZLZgs4kPQiovne2cpSmX2r1hQadVnNrdRvbbraCtS+jqLCJCtT
 MSRWFR4gEOro+5COFRSapQHHH58DJN3qX61jB711C7d7w5tNtRfTI9wbJZBBev/J7tVi7VGjUpc
 T1XGvcZGCDUQOZfz27Q==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af2756f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=jFO4u2iLn5EmdbOGf-YA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: X9h_eustOvSNVXdEKJquXcX-buL5lvWU
X-Proofpoint-GUID: X9h_eustOvSNVXdEKJquXcX-buL5lvWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/9/2026 5:21 PM, Marco Liebel wrote:
> Hold the shared TLB mutex during ASID invalidation so it cannot
> overwrite a concurrent entry replacement.
>
> Route local IMASK reads and writes through BQL-protected helpers
> to serialize them with cross-thread interrupt assignment. Apply
> the pre-V81 writable-bit mask under the same lock.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   hw/hexagon/hexagon_tlb.c   |  1 +
>   target/hexagon/genptr.c    | 17 +++++++++--------
>   target/hexagon/op_helper.c |  4 ++++
>   target/hexagon/translate.c | 16 ++++++++++++----
>   4 files changed, 26 insertions(+), 12 deletions(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
> index 3e72026d62a..07406cea35e 100644
> --- a/hw/hexagon/hexagon_tlb.c
> +++ b/hw/hexagon/hexagon_tlb.c
> @@ -325,6 +325,7 @@ uint32_t hexagon_tlb_invalidate_asid(HexagonTLBState *tlb, uint32_t asid)
>   {
>       uint32_t invalidated = 0;
>   
> +    QEMU_LOCK_GUARD(&tlb->lock);
>       for (uint32_t i = 0; i < tlb->num_entries; i++) {
>           uint64_t entry = tlb->entries[i];
>   
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index addb5d23d90..52615628e3f 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -302,13 +302,11 @@ static void gen_log_sreg_write(DisasContext *ctx, int rnum, TCGv_i32 val)
>       if (rnum == HEX_SREG_MODECTL || rnum == HEX_SREG_SYSCFG) {
>           translator_io_start(&ctx->base);
>       }
> -    if (rnum == HEX_SREG_IMASK &&
> -        ctx->hex_def->hex_version < HEX_VER_V81) {
> -        reg_mask = 0xffff0000;
> -    }
> -
>       if (reg_mask != IMMUTABLE) {
> -        if (rnum < HEX_SREG_GLB_START) {
> +        if (rnum == HEX_SREG_IMASK) {
> +            /* Commit through a helper to serialize with iassignw/setimask. */
> +            tcg_gen_mov_i32(ctx->t_sreg_new_value[rnum], val);
> +        } else if (rnum < HEX_SREG_GLB_START) {
>               gen_masked_reg_write(val, hex_t_sreg[rnum], reg_mask);
>               if (ctx->need_commit || rnum == HEX_SREG_SSR ||
>                   rnum == HEX_SREG_CCR) {
> @@ -343,7 +341,8 @@ static void gen_read_sreg(DisasContext *ctx, TCGv_i32 dst, int reg_num)
>           reg_num == HEX_SREG_PCYCLELO || reg_num == HEX_SREG_PCYCLEHI) {
>           translator_io_start(&ctx->base);
>       }
> -    if (reg_num >= HEX_SREG_GLB_START || reg_num == HEX_SREG_BADVA) {
> +    if (reg_num >= HEX_SREG_GLB_START || reg_num == HEX_SREG_BADVA ||
> +        reg_num == HEX_SREG_IMASK) {
>           gen_helper_sreg_read(dst, tcg_env, tcg_constant_i32(reg_num));
>       } else {
>           tcg_gen_mov_i32(dst, hex_t_sreg[reg_num]);
> @@ -356,7 +355,9 @@ static void gen_read_sreg_pair(DisasContext *ctx, TCGv_i64 dst, int reg_num)
>       if (reg_num == HEX_SREG_TIMERLO || reg_num == HEX_SREG_PCYCLELO) {
>           translator_io_start(&ctx->base);
>       }
> -    if (reg_num < HEX_SREG_GLB_START) {
> +    if (reg_num == HEX_SREG_IMASK) {
> +        gen_helper_sreg_read_pair(dst, tcg_env, tcg_constant_i32(reg_num));
> +    } else if (reg_num < HEX_SREG_GLB_START) {
>           if (reg_num + 1 == HEX_SREG_BADVA) {
>               TCGv_i32 badva = tcg_temp_new_i32();
>               gen_helper_sreg_read(badva, tcg_env,
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index 0a16778e5e2..71b27ef07f1 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1994,6 +1994,10 @@ void HELPER(sreg_write_masked)(CPUHexagonState *env, uint32_t reg, uint32_t val)
>   {
>       BQL_LOCK_GUARD();
>       if (reg < HEX_SREG_GLB_START) {
> +        if (reg == HEX_SREG_IMASK &&
> +            env_archcpu(env)->cfg.hex_def->hex_version < HEX_VER_V81) {
> +            val = deposit32(env->t_sreg[reg], 0, 16, val);
> +        }
>           env->t_sreg[reg] = val;
>       } else {
>           HexagonCPU *cpu = env_archcpu(env);
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 8ab28d40d34..ec1d79e31f6 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -804,8 +804,13 @@ static void gen_start_packet(DisasContext *ctx)
>           int reg_num = ctx->sreg_log[i];
>           if (reg_num < HEX_SREG_GLB_START) {
>               ctx->t_sreg_new_value[reg_num] = tcg_temp_new();
> -            tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
> -                          hex_t_sreg[reg_num]);
> +            if (reg_num == HEX_SREG_IMASK) {
> +                gen_helper_sreg_read(ctx->t_sreg_new_value[reg_num], tcg_env,
> +                                     tcg_constant_i32(reg_num));
> +            } else {
> +                tcg_gen_mov_tl(ctx->t_sreg_new_value[reg_num],
> +                              hex_t_sreg[reg_num]);
> +            }
>           }
>       }
>       for (i = 0; i < NUM_GREGS; i++) {
> @@ -1071,8 +1076,11 @@ static void gen_sreg_writes(DisasContext *ctx)
>                                     old_reg);
>               /* A CCR write can change context, so end the TB. */
>               ctx->base.is_jmp = DISAS_NORETURN;
> +        } else if (reg_num == HEX_SREG_IMASK) {
> +            gen_helper_sreg_write_masked(tcg_env, tcg_constant_i32(reg_num),
> +                                         ctx->t_sreg_new_value[reg_num]);
> +            gen_helper_pending_interrupt(tcg_env);
>           } else if ((reg_num == HEX_SREG_STID) ||
> -                    (reg_num == HEX_SREG_IMASK) ||
>                      (reg_num == HEX_SREG_IPENDAD) ||
>                      (reg_num == HEX_SREG_IPEND) ||
>                      (reg_num == HEX_SREG_IAD)) {
> @@ -1715,7 +1723,7 @@ void hexagon_translate_init(void)
>                   hexagon_gregnames[i]);
>       }
>       for (i = 0; i < NUM_SREGS; i++) {
> -        if (i < HEX_SREG_GLB_START) {
> +        if (i < HEX_SREG_GLB_START && i != HEX_SREG_IMASK) {
>               hex_t_sreg[i] = tcg_global_mem_new_i32(tcg_env,
>                   offsetof(CPUHexagonState, t_sreg[i]),
>                   hexagon_sregnames[i]);

