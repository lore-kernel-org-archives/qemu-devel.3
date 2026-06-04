Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293BCCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV54Z-00074L-0T; Thu, 04 Jun 2026 06:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV54X-000746-BA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:13:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV54V-00037S-FJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:13:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UaT41132273
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 10:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xm03tST9fzT9MyJQpSMYrjwQGbFrj0REQ+IKEH8HfhI=; b=dq2B6BySvsUV/W1A
 QwqhyrBGV0v2wbTdOGHpisqf+63u5JeM8ATMfQhXZ6Ax0+hn8h2P0vCUOu8a4868
 QNWvirqpBemeW1zQtPJr2pmLAiYDAef0/QK7OM3CqhuBRs/tTGLCtp7DxxzY+fNA
 cmHkRIV5W8IOHfDPN/CEPy/clnXCNHMYiBlmyq+xaKzVOKMphbhAeN1yrWv8XBy3
 5KCrwXkz5s4zsHuI6coYo7rUOHOsPUJ7TvlbYCgsyDgfKlBBP9EEkvV68FRpuQ4M
 J7Z/Zkf6w8cLOYU+o4k8T2EsIkOwf4U0I1XL07hQb/KiY1h5OAtzxeXL3T0ExqbC
 mq4jNw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsgcnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 10:13:06 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-59bdafdbcbaso362510e0c.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780567986; x=1781172786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xm03tST9fzT9MyJQpSMYrjwQGbFrj0REQ+IKEH8HfhI=;
 b=AD65PamrRkA1N+0VFMclItgzOuFtiRfTGyactai10ED44ik1EGa1acJSRofn/vW/f7
 z/Sb9fw9eUySl0NUIwdXLt6NbGiR1lidx0vIl6wRepTJpSjjBdtCrTpwASAP0Ro+JFX6
 RulZhg4g/qGeD/Q/pUbYngg2d5jki3nYv94fAFfvfFFlurvs8t3wAPVQB7MbDAoVseox
 5rxGGwLOQT9Q0NQh2KYxoyWNzC97y7F+wwi9m6Cy7i2sQ2RevmrnA1hiZNgSigWyedjT
 nay8F/689DIy3iN+/BbLQnHjL7w1qtC62SQxiaEg5ZWLiSDBtmlX1ucZJkO+YwEbCPhV
 gZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780567986; x=1781172786;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xm03tST9fzT9MyJQpSMYrjwQGbFrj0REQ+IKEH8HfhI=;
 b=CykDVdt+1no4q1h2p5QftWK6nDnpHP1Gng68VuhpXu98wZ/gUSKla56WIhlS7vJX+L
 hhsgs1Pa9eQJYmAo3oS4NVvolZ0zM9GdFUHryzBpz1Mmk+UwW4bMaj6s9RTSKmq6wKeq
 ol1ymyw/3hDm/AAaxi8Q6zmH63xKcdWxCmmDNqgQYAww5OZcdQuqHHbdLvPCmIpK97jc
 4wvQ4WFG2dho/3lgXfn3lsMwGGAvHQVgvXgmVmTWmdaOT35x1GiWFxBEXT3B6mN/iVz2
 s3m8EstJXQnde8nHKSD/OnhetOhXWaLnsbAfg1hrvIkXmdHV0qzJMPxZulbR8wIcLyZ8
 xOEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZgPLwTcqaBhD6n9bmX5PAtBbyvGTh7uCmMEWGqsU/6E9acpJYsxDwn+BVFcAvmNMuEtf4NsOGS4Of@nongnu.org
X-Gm-Message-State: AOJu0YzPJnao9fAt1aBTWoUpIwWs9IWtrQpUj2MbNqUymptqmHX1Gyyv
 v0NbhrWe+hsoes906+jzGONs/O08Vj0N8VftHo2babrwnLCxkaZAeV/9HjYTYQLNgyQoxwYTweN
 WQsQqD5LdE75LHe3H/9ssqbIO2Rs07zRWQCckR4OSR6Btla4UkxA1LrWnug==
X-Gm-Gg: Acq92OEDhQGn/fxoTdQyMdUfviTvP9GhXYbh46DtAcCtwd0DIOOz6HcckgKQMJ1A//c
 1KPDhLoiyYYdrN5spbwkPxQgBxLy+3I98jZjmZlY9tMCFdAGvUOU7jk0JC3u73YjvbiDaWjouH6
 UY2sVdWnB7AdqlEtG/Z6USBklwfSen5YlU3fVb6LH6R5FkAb+HGr81/xPYuIXWtnkya9sZuB27j
 K3HyhI8WcS5scNFQRe2O0JibG7bD/jNQXMgTRp3fTsIJrh84dgFasvGL6/cgVNxGypxGoBrxuG4
 uqPX8+p94qLQMKi98CXQQsJh3gQv5GmT5SM5mlbTxRY4VRWQWOCH5CXQ+Qdu/fPScbXfJVvwgFc
 jrpE36LBrAcJNhlFiDwRiuI35/Jk5A10LNLtD1ZfWHD5GwSnO9Pw9579OT5nnmPNl9B6i
X-Received: by 2002:a05:6102:4411:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-6ec2a219b09mr3968677137.2.1780567983046; 
 Thu, 04 Jun 2026 03:13:03 -0700 (PDT)
X-Received: by 2002:a05:6102:4411:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-6ec2a219b09mr3968671137.2.1780567982640; 
 Thu, 04 Jun 2026 03:13:02 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb649b5513sm4534555137.8.2026.06.04.03.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 03:13:01 -0700 (PDT)
Message-ID: <5f487cb8-df3f-4692-bb1b-ff3360338429@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 07:12:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/25] target/riscv/debug: Fix icount trigger
 privilege check
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-5-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: M2ENTe6Dckk-NeL7TVlFbr7GWQi-MTKH
X-Proofpoint-ORIG-GUID: M2ENTe6Dckk-NeL7TVlFbr7GWQi-MTKH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5OCBTYWx0ZWRfX5TnRkYQqIZ8L
 Q+Rj6ITkIpqIDoAFAlzGaBrHIGC24wHavUrfLemDlPbL47L1+2hbUicUwD0iLMAQ01llITschp5
 Cvo64CaDcyltKNjxBuEEBvTiABnot5JWi67a4OZkeFkYlVvYSXajkXbQGuQtT8FDeChjXXl6EEU
 JiAiS4PFgIDH7RbIvW/vt1BxYRHx+tq36KNEQTF+EQ5H+IbQ9/tEEFQcs54aJeOx2msDXraniKB
 3molBBjJKJu/4WePWKY41vVm8kS3S1SV1agsJ7B0QnaZPBkouMApB8nHFvgvIZ/mPLNupUVcsOH
 P9fdOokgFV7PSxtEq5hriocjGoEVjwFdQAZhuPk/r8YprTApFtdKc1gv3O8wQy8Rknzr9lDsaov
 KrFSu51S0ZZ8B0v+gC0cCZyS3ci9RatE4Dy/eE8buz7iPuYbq9HVQmLfebGadDpyB3mbkk1Plvf
 oCBFrVONAR1lrdC0FiA==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a214fb2 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yd05MXNDD4I3yKd55G4A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040098
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> The check_itrigger_priv() did not check privilege bits properly. Move
> all priv checks into functions and have the icount check follow the same
> form as the others.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c | 82 ++++++++++++++++++++------------------------
>   1 file changed, 37 insertions(+), 45 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index c92bd9860e..2effbb49af 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -306,48 +306,50 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
>    * Check the privilege level of specific trigger matches CPU's current privilege
>    * level.
>    */
> +static bool type2_priv_match(CPURISCVState *env, target_ulong tdata1)
> +{
> +    /* type 2 trigger cannot be fired in VU/VS mode */
> +    if (env->virt_enabled) {
> +        return false;
> +    }
> +    /* check U/S/M bit against current privilege level */
> +    return (((tdata1 >> 3) & 0b1011) & BIT(env->priv));
> +}
> +
> +static bool type6_priv_match(CPURISCVState *env, target_ulong tdata1)
> +{
> +    if (env->virt_enabled) {
> +        /* check VU/VS bit against current privilege level */
> +        return (((tdata1 >> 23) & 0b11) & BIT(env->priv));
> +    } else {
> +        /* check U/S/M bit against current privilege level */
> +        return (((tdata1 >> 3) & 0b1011) & BIT(env->priv));
> +    }
> +}
> +
> +static bool icount_priv_match(CPURISCVState *env, target_ulong tdata1)
> +{
> +    if (env->virt_enabled) {
> +        /* check VU/VS bit against current privilege level */
> +        return (((tdata1 >> 25) & 0b11) & BIT(env->priv));
> +    } else {
> +        /* check U/S/M bit against current privilege level */
> +        return (((tdata1 >> 6) & 0b1011) & BIT(env->priv));
> +    }
> +}
> +
>   static bool trigger_priv_match(CPURISCVState *env, trigger_type_t type,
>                                  int trigger_index)
>   {
> -    target_ulong ctrl = env->tdata1[trigger_index];
> +    target_ulong tdata1 = env->tdata1[trigger_index];
>   
>       switch (type) {
>       case TRIGGER_TYPE_AD_MATCH:
> -        /* type 2 trigger cannot be fired in VU/VS mode */
> -        if (env->virt_enabled) {
> -            return false;
> -        }
> -        /* check U/S/M bit against current privilege level */
> -        if ((ctrl >> 3) & BIT(env->priv)) {
> -            return true;
> -        }
> -        break;
> +        return type2_priv_match(env, tdata1);
>       case TRIGGER_TYPE_AD_MATCH6:
> -        if (env->virt_enabled) {
> -            /* check VU/VS bit against current privilege level */
> -            if ((ctrl >> 23) & BIT(env->priv)) {
> -                return true;
> -            }
> -        } else {
> -            /* check U/S/M bit against current privilege level */
> -            if ((ctrl >> 3) & BIT(env->priv)) {
> -                return true;
> -            }
> -        }
> -        break;
> +        return type6_priv_match(env, tdata1);
>       case TRIGGER_TYPE_INST_CNT:
> -        if (env->virt_enabled) {
> -            /* check VU/VS bit against current privilege level */
> -            if ((ctrl >> 25) & BIT(env->priv)) {
> -                return true;
> -            }
> -        } else {
> -            /* check U/S/M bit against current privilege level */
> -            if ((ctrl >> 6) & BIT(env->priv)) {
> -                return true;
> -            }
> -        }
> -        break;
> +        return icount_priv_match(env, tdata1);
>       case TRIGGER_TYPE_INT:
>       case TRIGGER_TYPE_EXCP:
>       case TRIGGER_TYPE_EXT_SRC:
> @@ -665,17 +667,7 @@ itrigger_set_count(CPURISCVState *env, int index, int value)
>   
>   static bool check_itrigger_priv(CPURISCVState *env, int index)
>   {
> -    target_ulong tdata1 = env->tdata1[index];
> -    if (env->virt_enabled) {
> -        /* check VU/VS bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_VS) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_VU) == env->priv);
> -    } else {
> -        /* check U/S/M bit against current privilege level */
> -        return (get_field(tdata1, ITRIGGER_M) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_S) == env->priv) ||
> -               (get_field(tdata1, ITRIGGER_U) == env->priv);
> -    }
> +    return icount_priv_match(env, index);
>   }
>   
>   bool riscv_itrigger_enabled(CPURISCVState *env)


