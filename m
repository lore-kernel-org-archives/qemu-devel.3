Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881D606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y6tz6CHq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YxbkV9qR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVai-0007TJ-14; Mon, 09 Nov 2026 15:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVae-0007SY-BU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:03:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVab-0004Zw-US
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:03:40 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH4nf1525206
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2SrnK4am5Za4V+BOowWdedgGoTOIB4or41rmNFLcF6I=; b=Y6tz6CHqXjuBip0E
 0U4lHKCP5ZilUP4GzeWnALqkBXHgXEue3TiLG6QdESXW/gnr1Vrqjo0oebECQeDf
 7iOAwvNFFWYRTKVnkCl6IhUDw1lGNSwS3Ye/T86przwU/bak1BHhGtsXlQWvFK9M
 F+WgX6unYoIEZjDNpYtY9xxAcSluntXk0QhZylBhawp7igKLvaL/4u+zK0ZrhvLJ
 XGEsV+94agXwrvsA1p8Jz/3etl06LsSNXFyCgbCGNSUvbkwJGu4NFZpHMO+WCAFh
 NEQ5SWFHCWw5L0eN7mXGXgm2fOT8PZIj63TrB42ls1FuUvAlyyc8RwEriJS+jJio
 DGJ1gA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81a32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:03:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5338ff2cf14so25895561cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254615; x=1794859415; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2SrnK4am5Za4V+BOowWdedgGoTOIB4or41rmNFLcF6I=;
 b=YxbkV9qRVSiW5YZcAphAwt2a5mlH9DWlvZbCoc+LHS7BEgMZ9DhpFrseJQpJxxVo0r
 7rYGBgexg9gvIIryw3pexRUPMrzEeSM9c8iE5LBO1peH1NFRRagB/nS8vvQT2ToUXAYH
 KXJp1vkBK2nScv2buTiEpMrqgItcKq+0opKnxVuVHoEIMmTOE2HYwgemlqkph3MY8Lu2
 1jiKpf8SqCZZZH4WJLG5FN0D7lqmGgNGZS4EWy4+Y72n2HARuFU9kZrD86ytju72u7Xn
 OM1pUx08BFvKQUPJWCYI3ICYmPV4AYMg7QRouWXsAkiOiTeF7ZePQxj8qCRc42OzlrqH
 B+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254615; x=1794859415;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2SrnK4am5Za4V+BOowWdedgGoTOIB4or41rmNFLcF6I=;
 b=uiZX7kUW5r3hsjpnIpNEyzNDWjqbV01xTD9DhrjUJoNyNq7e1ycKVGHeZiCWpot7/5
 7jLJq6sjnJ3ISupztRmH9YI4LKZvmXmkgK1aB/udJcZw5S4FUOS9n3IevaWS6Bd7h5eh
 5S13f/Lac0jZURseuvW33/Qv8fQpQBStDxzM4oLSD0lMuTxcBIww5YZ/SxPwXZTEgiJV
 hb7o8TonagaqGJPrRUKjOVGNBTJ1qz1ordiNrIGuQAMrYK0RaJS3zOyCmXYzbDR4v6L2
 otZNh4Fua7ThaRPyUkaDrkgUoSxBoOZiaf74IcRmIqpVEVqdJI4kidZrWvk1y+QwPQ4M
 KEqA==
X-Forwarded-Encrypted: i=1;
 AL+hErGoacg3DHAzlTCBuB9N7J6yYoaR4/3zA50WGNnsi1xjevlpVTu9AgsgDdizvhX/HOMgbwBczUqOdgAV@nongnu.org
X-Gm-Message-State: APuU4Z+xRiGW6nrBgrhrH3XEqWVyizZJdFT/xrdca6qjDsXuMwYL73H+
 uLEEwvOCh8jeEIexZgQmuGtiV+uhHsPPHvPbDqT/lYk9yIRBmxsov/SOmf20nSfPQwAvzRgioYD
 UWjbs+s9B7FW5PPdOLi8+QharrtvhYUewid9GREQEsTZDfZUKcBZ7Ya+74A==
X-Gm-Gg: AYBFou1lI9Rq7lYHO5qLR5yR0bAhYQnjnCUI/1/SkjQMKpdd486abLf+5Tm6QvWJ1qO
 D4cKAMDeK0NpXT/Gbb6sH5qijM0PgBzLsJ65gV4UfTfHqda8rkq6sW4i+0haoIa/cmSamLdiaCi
 LSWqDDqQVr5tAusOX+pLLNT0j3ToGb36hcZm7Ehl0e1kOUfqVcrlauDRpgjwZTIrsUCRwqPNLeU
 c56WgfkwlUa+0vDlyScczpzrxnl3kS/IskJ5YuDRcr/Ss1RlExC/Af4OJfLTMT8mktRsh0gY+2a
 GdP6XZ/lQ2rT3/Gl5QwXAjG/ZWewG8sDl+xXXgflqOdrRMAgfU/VC3PCvj0c5WbIBRATVh7qKeb
 KISxUoipoLEopJ+fiv9s6oiQdtAzOc67RtN7kTQDDXJ+baTgJt21rcMX+S4INcDk7aLz73IWQ7E
 bq/jCBdMNm
X-Received: by 2002:a05:622a:1247:b0:533:91bb:b81e with SMTP id
 d75a77b69052e-55529994891mr6869681cf.31.1794254615463; 
 Mon, 09 Nov 2026 12:03:35 -0800 (PST)
X-Received: by 2002:a05:622a:1247:b0:533:91bb:b81e with SMTP id
 d75a77b69052e-55529994891mr6869151cf.31.1794254614975; 
 Mon, 09 Nov 2026 12:03:34 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550c22264asm5445881cf.28.2026.11.09.12.03.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:03:34 -0800 (PST)
Message-ID: <8cbb1f8e-cad0-48e9-987b-fb99245a71b7@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:03:31 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/38] target/riscv: rvv: Implement Zvqwdota16i
 instructions
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-11-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-11-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af22718 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=yvJmoxbNle3XhS5rPNIA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: LXK1iJCtXr_YicMueknmlIEhp37BOyVZ
X-Proofpoint-ORIG-GUID: LXK1iJCtXr_YicMueknmlIEhp37BOyVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfXzbbgkijL7OBZ
 hpLJHGsHRtGFLBHDZz+ZcYLkJdt6NU/Ppra/Wvshp5oflQthzG3TONwafdmKiWH34miJTSGPjsC
 QS2E6B9D2nbjrDpY7LXGi4hOY8hjdBg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX9gRT3pdVcBx+
 BR9D66AbeBF+X5P8TxugjRE+I2KmuqSyVNhTM8nZjM4Mwwjajc5uZ2ocNF1sRpt6g3LUkwoaq13
 RtezjDKG6alf8Z/AqGq2EWZQa8td5rCKQpbuesTz/f5ItyM9/HV6MIl9SDa7oAjBVRdRVdHJEyt
 g39ZSmKZXqWxyYmGw7vZdv5i25DA6Njtg7AFvEWxcL9LXXcjHF8RP9+9XoGrJXrNjruwiAZky/Q
 Voej47tF5nXPdYoyImbowvMHZd0yzCDwaB+43/7r02JI0ddgqP9fOvdAIli01ModjvToq+zpSgm
 McInCQE06fEcuwAKphkecWeYstzAplXfEUTmqYyjUMyeamu9OryECB1WVY63T/LgFUoYNK1QklN
 vatnXVffFYNX9Ql47py5GviHIrcaZ1n8r90dlqc8865TV5c//Z+nJo2kTW1D/h3HlonL6fIqDXl
 NMmPbCj5+ECsd8CcjMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Extend existing vqwdota* instructions to support both SEW=8
> (Zvqwdota8i) and SEW=16 (Zvqwdota16i).
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                       | 4 +++-
>   target/riscv/insn32.decode                  | 2 +-
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 5 +++--
>   target/riscv/tcg/vector_helper.c            | 2 ++
>   4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 767b04658b4..23d3e9b3c43 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1387,9 +1387,11 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>   /* Zalrsc SC write probe */
>   DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>   
> -/* Zvqwdota8i - 8-bit Integer Dot Product */
> +/* Zvqwdota8i/Zvqwdota16i - 8/16-bit Integer Dot Product */
>   DEF_HELPER_6(vqwdotau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vqwdotau_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>   
>   /* SiFive Custom int8 Matrix-Multiply */
>   DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cc7d639ab73..b8a5d0567b1 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1098,6 +1098,6 @@ vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
>   vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>   vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
>   
> -# *** Zvqwdota8i 8-bit Integer Dot-Product Extension ***
> +# *** Zvqwdota8i/Zvqwdota16i Integer Dot-Product Extension ***
>   vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
>   vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index befdbf273e5..fcff472a2ea 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4149,7 +4149,8 @@ static bool vext_zvdota_base_check(DisasContext *s, arg_rmrr * a)
>   static bool vext_vqwdota_check(DisasContext *s, arg_rmrr *a)
>   {
>       return vext_zvdota_base_check(s, a) &&
> -           (s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8);
> +           ((s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8) ||
> +            (s->cfg_ptr->ext_zvqwdota16i && s->sew == MO_16));
>   }
>   
>   typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> @@ -4159,7 +4160,7 @@ typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
>   static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>   {                                                                       \
>       static gen_helper_zvdota_int * const fns[2] = {                     \
> -        gen_helper_##NAME##_b, NULL,                                    \
> +        gen_helper_##NAME##_b, gen_helper_##NAME##_h,                   \
>       };                                                                  \
>       if (CHECK(s, a)) {                                                  \
>           TCGv_ptr dest, src1, src2, mask;                                \
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 6d79fb5d299..57a381098f6 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6021,3 +6021,5 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
>   
>   GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
>   GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)
> +GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_h, 64, 16, uint16_t, H8, H2)
> +GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_h, 64, 16, int16_t, H8, H2)


