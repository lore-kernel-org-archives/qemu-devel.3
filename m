Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D923FC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpAgI-0001bA-3P; Wed, 29 Jul 2026 16:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wpAfw-0001aM-EW
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:14:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wpAfu-0005Ox-Fd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:14:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TKBJfj3102497
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 20:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zAxDFwsg1NLs5qtOz6xvAhk5ZcRMVjG7vF7M9dhlU9Y=; b=iXrle4QL+XTFaHYa
 NaWRY72KmgnBp41tjXP/fxyp0Hwp6Sky2BX1S5cRrvEmJJFg1BUUX+6RHoUqSynJ
 X4cSMSCGIScGauXpI6LdJRz2+R7Zlmwxwhsn7Yh5Litmz87RdADRXQAFDpfrxtrG
 AMEwLxo3RPE0wXBnz2ctHFW0Sv6Bet9dmcanWAupEersS7YMT1GwYzo5rrsW+7pS
 LXlCrGFAeUfZjB728lbB4okltQjFTO74YLEftl08SrxOCRn8xUFO6f+6SoYRYT/C
 xHKGv4cXA1DZqu3gr/lUwWWxRJxZjZ5MNvgGcSeCaWn6s2TlPs6zt99ZjVnmUGEi
 LeYMVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqrb100gh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 20:14:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92ec91dc265so131771485a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785356075; x=1785960875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zAxDFwsg1NLs5qtOz6xvAhk5ZcRMVjG7vF7M9dhlU9Y=;
 b=PzVbXSjMUOYQGFqZZIr58jfRpFJ/XHA1MuxBq5LZXhWNLePT7B/7dcCMGWAjmv74Wm
 XwTn/oteRwuajYSbmf92dTHGkJno4t3caDfdV7r+lTPRUU4O6e4bbsThZYauFqA7IcNh
 eexbsPONms6KLw9L2aO1p3cHKz3G4c+/A7ggWHiAMI369zzo/n8KNiG2LjGt8ey82KnT
 QAFd5lAK4tK1/BZ3Au5xFjSIMoC1IdjAM+YXhfLk2GJ10ORTv7kswQoc376wtsbPP20t
 AgozadrPGQvfKL7PSdZg8kIqef2145zntzbCOXrD6yvj0+6+2nbM9OUQKQoxoxufOi0U
 h2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785356075; x=1785960875;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zAxDFwsg1NLs5qtOz6xvAhk5ZcRMVjG7vF7M9dhlU9Y=;
 b=U4LBD3WEtdDi0y5iAsj2+HtIQoCfCVbG3KNPRdI4UH5xlOqYZEfu1NlNOJ38qsy122
 cP8En/HPq6AivTmbnfNXBt3uy/srrkzFW810JGPp17eyfz7/Ywp4OBF7YGZQGg56Fxoa
 Ji/v/g2WLSWKeKPqDGALM1v9mFXLJXXYhnhKrzho4vvtlVK899wZ2FpycVYqtdb1/doY
 I5wmsUu5966pHqZZYu0EyZ98aWDKcquJhZnzaKIsWJDAudXUct4d8J+ojfdWYMW4eLxa
 kz4H5AnLcY/Tk8XjL7I3eLGM4DwEjYQQH5G1qwTxgrrsUXxXcxbi/nZUXqGEgOgXkzvf
 aNew==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDOsbysbbuoQtF0/09nSA322nI19N+hj/i2VpJe0V4xcT6Am+/lTucv1cHTRuDX/GUOQYAv0jLQaId@nongnu.org
X-Gm-Message-State: AOJu0YxAt4tQvDq4EjPP26RkIswo3jtCoeX7UFL6NcxRhFa7CaBcLfRx
 BSYXbc62gpkGsinSqrJpoKt6fDP2CqJqUax5TqDg9Wfv2cMjT9usjw5XHcO08m5Mx72EJ4Es+sx
 A74jlCmG4dBQiSzvZctHVH/IPkr2wF2NFnkZIECPyWpUP2h1tpGqXND8JKQ==
X-Gm-Gg: AR+sD13fsh43xp7EnYTiWRJVloqKdB1I/XVeuPcZOvLEnF7INbiX+vtXNqlpCcDHswb
 BxqRwCFR7ticXlxix1zSsZO9LHCnps8jUkkjXELHt87QOqXhAKjoJbtdzvd5B2P9NCkLah05Hmw
 hlfuUaojTSdSY1VNsDS0TBn69skRFeiC7Gn+81GVgtYBKtXT/GzMgBChH84sMdNCCezjqPEOHYg
 KWQywDoL+A0EDjZT0UOfSgmnCB4Fcg7pdtbsasec2vF01USLBpKAYOGmKHGKjA0COlWJ3bAdEux
 Jr2Qfe5YbqIaJ4KYJsTos3jAj13jIRODcNS4sDxENV6nPIMywRKbBPCdldsJ2us1cOF4UJFpVB8
 VJmGSWGiU3Jn8KHpj1/HmplFhgr456hLsPX0ifg==
X-Received: by 2002:a05:620a:1a07:b0:92e:675e:8ef0 with SMTP id
 af79cd13be357-93483f05b66mr39314585a.68.1785356074233; 
 Wed, 29 Jul 2026 13:14:34 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:92e:675e:8ef0 with SMTP id
 af79cd13be357-93483f05b66mr39307185a.68.1785356073355; 
 Wed, 29 Jul 2026 13:14:33 -0700 (PDT)
Received: from [192.168.68.104] ([191.202.238.134])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933d3264577sm245369985a.17.2026.07.29.13.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 13:14:32 -0700 (PDT)
Message-ID: <989b0d86-312c-4c81-94b3-5528a34af5b7@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 17:14:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: allow menvcfg/henvcfg LPE and SSE bits
 on RV32
To: A-Shehab <ahshehab24@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, debug@rivosinc.com
References: <20260726080537.13913-1-ahshehab24@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260726080537.13913-1-ahshehab24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1NCBTYWx0ZWRfXzUXdLFAoLUSL
 doeWFV7z9wKBA4NIEdxHyOeqLkAjYj+eYSN14AxG+xCq87F+s4WoKG6Gx2ttBPu7OmCwtLSsjC6
 CjCU57WrZsJzWzOjU6DQjME5TKyyMdk=
X-Authority-Analysis: v=2.4 cv=a7AAM0SF c=1 sm=1 tr=0 ts=6a6a5f2b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=krItrnN2KmZux9Htc+7Wjw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=iEunc7SmayLcI2BJZTUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 4GHzolPwn_jFtu1INOsnGrOq5bQ_vcRC
X-Proofpoint-ORIG-GUID: 4GHzolPwn_jFtu1INOsnGrOq5bQ_vcRC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1NCBTYWx0ZWRfX5+4inIDiQhto
 Um7bKR7UL899cP4RCt01FVYnILtAuDAcyemmam2g/Ulnk1Vbje8O30Gq+qgaCQFSU7uigKD9cQ8
 03SEHn3IiaJK/x9SdNzn2L7kzYF3vZp83aUVblSnjsS1eDW0HY4BRhGpQ+Wy7IzWEHCEgtR614c
 pnvPh9VA6Kkf64sgDmNcOBHuFHT+Of5XwZwmGRQdqn90l14DCXGROXa7dZyDZo81LBQJfIVPQPU
 gpsOkG7tdNFIVy+B91tqwnS/fSXxVJ2LG8cSQxgAYk2kOVmx7i/HfgHFQZ6B0Bp2jaOB6ZdG2oM
 8WskBXrad/mqV2egMaf1kBMf75XlpNtoVkq+kw+EazAuM4GZhUtSxn/ZfiM2qlK16cIXzrsIsQG
 ha2/RyEIaSkWRy/6GMYCPrlEtv5IU4tmqjiXh2tZePIrh29n/oQ4/VMWyTIv471T6xuLw1jsuXS
 dTw+7qxmKLbuz3smmpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290154
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/26/2026 5:05 AM, A-Shehab wrote:
> The Zicfilp landing-pad enable (LPE, bit 2) and Zicfiss shadow-stack
> enable (SSE, bit 3) controls live in the low 32 bits of menvcfg and
> henvcfg, and the CFI specification defines them for both RV32 and RV64.
> 
> QEMU only adds MENVCFG_LPE/MENVCFG_SSE (and the henvcfg equivalents) to
> the writable mask inside the "riscv_cpu_mxl(env) == MXL_RV64" block, so
> on RV32 these bits are silently dropped and the features cannot be
> enabled. This is inconsistent with write_senvcfg(), which already
> handles SENVCFG_LPE/SENVCFG_SSE regardless of MXLEN.
> 
> Hoist the LPE/SSE mask handling out of the RV64-only block in
> write_menvcfg() and write_henvcfg() so the bits become writable on RV32
> as well. The upper-half writers (write_menvcfgh/write_henvcfgh) are
> unaffected because these bits reside in the low 32 bits.
> 
> Reproducible on qemu-system-riscv32 -cpu rv32,zicfilp=true,zicfiss=true:
> an M-mode write of menvcfg.{LPE,SSE} reads back as zero, while the same
> program on rv64 keeps the bits set.
> 
> Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
> Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls for zicfiss")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4045
> Signed-off-by: A-Shehab <ahshehab24@gmail.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> v2: Rebase on current master; the file moved from target/riscv/csr.c to
>      target/riscv/tcg/csr.c (noted by Daniel Henrique Barboza). No
>      functional change.
> 
> v1: https://lore.kernel.org/qemu-devel/20260719111749.23777-1-ahshehab24@gmail.com/
> 
>   target/riscv/tcg/csr.c | 45 +++++++++++++++++++++++++-----------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..0182e4c408 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -3216,6 +3216,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                       MENVCFG_CBZE;
>       bool stce_changed = false;
>   
> +    /*
> +     * menvcfg.LPE (Zicfilp) and menvcfg.SSE (Zicfiss) reside in the low
> +     * 32 bits and are defined for both RV32 and RV64, so they must be
> +     * writable regardless of MXLEN.
> +     */
> +    if (cfg->ext_zicfilp) {
> +        mask |= MENVCFG_LPE;
> +    }
> +
> +    if (cfg->ext_zicfiss) {
> +        mask |= MENVCFG_SSE;
> +    }
> +
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
>                   (cfg->ext_sstc ? MENVCFG_STCE : 0) |
> @@ -3223,14 +3236,6 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
>                   (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
>                   (cfg->ext_ssdbltrp ? MENVCFG_DTE : 0);
>   
> -        if (env_archcpu(env)->cfg.ext_zicfilp) {
> -            mask |= MENVCFG_LPE;
> -        }
> -
> -        if (env_archcpu(env)->cfg.ext_zicfiss) {
> -            mask |= MENVCFG_SSE;
> -        }
> -
>           /* Update PMM field only if the value is valid according to Zjpm v1.0 */
>           if (env_archcpu(env)->cfg.ext_smnpm &&
>               get_field(val, MENVCFG_PMM) != PMM_FIELD_RESERVED) {
> @@ -3378,20 +3383,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
>           return ret;
>       }
>   
> +    /*
> +     * henvcfg.LPE (Zicfilp) and henvcfg.SSE (Zicfiss) reside in the low
> +     * 32 bits and are defined for both RV32 and RV64, so they must be
> +     * writable regardless of MXLEN.
> +     */
> +    if (cfg->ext_zicfilp) {
> +        mask |= HENVCFG_LPE;
> +    }
> +
> +    /* H can light up SSE for VS only if HS had it from menvcfg */
> +    if (cfg->ext_zicfiss && get_field(env->menvcfg, MENVCFG_SSE)) {
> +        mask |= HENVCFG_SSE;
> +    }
> +
>       if (riscv_cpu_mxl(env) == MXL_RV64) {
>           mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE |
>                                   HENVCFG_DTE);
>   
> -        if (env_archcpu(env)->cfg.ext_zicfilp) {
> -            mask |= HENVCFG_LPE;
> -        }
> -
> -        /* H can light up SSE for VS only if HS had it from menvcfg */
> -        if (env_archcpu(env)->cfg.ext_zicfiss &&
> -            get_field(env->menvcfg, MENVCFG_SSE)) {
> -            mask |= HENVCFG_SSE;
> -        }
> -
>           /* Update PMM field only if the value is valid according to Zjpm v1.0 */
>           if (env_archcpu(env)->cfg.ext_ssnpm &&
>               get_field(val, HENVCFG_PMM) != PMM_FIELD_RESERVED) {


