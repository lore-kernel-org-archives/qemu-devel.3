Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB114C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmskj-0004Au-8R; Thu, 23 Jul 2026 08:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmskh-00043s-C7
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:42:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmske-0000Yn-Ma
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:42:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N8qvbJ3789377
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wnOrB86813Czpqi53VsusJmjdd4gfMw6y7MX17Po0Ao=; b=Z/nCo5BSDsjPgIWH
 4J+mWtlvCY+hJL6EQ/LNLXlPPkoMw56v1RrSdM+fWzIKYwk0kGQ+jE9RUJKwbQ1j
 nFwNzE4QrnMscXH8qLxdqjdbSKV3fN11lYojfYNzVAH4UgsQLoZUmnEZrEv4PNoh
 um6Iu14ru8w6j5cntdZAAV7QG9GbodtjZEq+gmR7j1tG8TR2Ypt6xQBJb8ooXEgV
 0LpPZbrWTW7CFqQuSPsLETLuq1t9GofVhD1AvsJblrTx0GKjbM7xdHQXnyxbIQNQ
 XSKaFb6S6sI9BpvuXQz05Ah8JUS/M6EA3YXyRzpZTqDxyXlIqSyzD+iQ47d5AlPA
 fsHDMA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk7b52ump-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:42:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso12887556d6.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 05:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784810530; x=1785415330; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wnOrB86813Czpqi53VsusJmjdd4gfMw6y7MX17Po0Ao=;
 b=Lwa3m/9rMKxqK9LRZXmS/YYbTghO49ZW64dTcgakWQUeFN9ZuUcfUMTJJ/Ov06NPLD
 jsTTYFbwsMnMgfXZ231LYMfyjuM/ws4EF3knz7oreJobGQayl9ZOsXBqY2QqksN3kjfv
 f0QiPWMCHFo4c3SXdha0OLsuGFyFBldT/o8Xpxx8M2EN3Sicg2RBOWM9YlUNE1JBkZXh
 2Zc0bme1igwPSkdPcqx/CTc0+7Zd9wFmCYYXZWqU8BeRbh3EPGKW7yJezd8yLlJ6X89G
 pCq4GMIFCYJwsXKMkbqvjDDkYh9OI+vHXrn8c9BPGfUEJCMuuXOseuO8NWvDCeUDQAqq
 DH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810530; x=1785415330;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wnOrB86813Czpqi53VsusJmjdd4gfMw6y7MX17Po0Ao=;
 b=C2lJa+M21ehT2fYbJgY+CAn01tKBDKbuS/ouAgRpQtCg2cYsNah4hwwEuTQlHNeSF+
 9pkUVQAlCSRKf6HMrJ00jceaZW6EOr0UCrqSDv+voOu3iNx7zXyUu6U42PqmFwC4gOuM
 NO7S/PZLQcjHTrOTyw5GoFZiokU+PxtKDYhz94p/9P+iT+KgvxPikz5uoqrRDeZiZn6x
 B60DwTbcQJvR4JT7uFf3U7Ec0lUvmMIga+LzfyaIDfxUqS9qQG3YvT0QjQRXhkfJKlDl
 CpGr49soty7n5J6/KTwXTqJKdWz/7MbzuddVLt7Sno4pDq8uJVxMpTYB6TkhFChKAHvL
 LI5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2r9DgEsP48RByTLT/8KBc6/wlyGFxKc9ykDjN3y8RtSj0hDi0SMj7zWCl3EIVCG2E9bbv0wRszJRI@nongnu.org
X-Gm-Message-State: AOJu0Yx1Wy323+yOH8j8sxq1MUyidqLUvmvfuxKlB3B0CiaviO8W5puE
 Ib43XDve+fiV+6DUUhaVx2uYtYMp+II/BjypJk8BFbaOja8x4aXz6jmRBK80lE/4eZNxEmw1kIi
 A72Ww4MXu7GzonVJZ3qhZjnqMg2ZLJWQd21158TrCplFRvS7m3tVo+R5dLQ==
X-Gm-Gg: AR+sD125Epi6nVm79V1hdB28WgvomtWuc0f329Cy/KWpQMcpMQw4LV8N2l5DwrWjnse
 DCrROkmso5TXsrqL3xDZSEOWCGm+aBpjFqJxm6Y3RdVDkEfnvH/RbHU7m5Jvv3UuDrfjCbeaN0V
 0f2r5Q2f2FWJuzoBb4GWdNpumv2zDQUw2LWzsz4utgBrtC/oazQMetwzDcKWTk9dtWTHE+Y7xd4
 +xRo7sdS6pOwClxATUv/QbxrDCpf71vK9/UNBzsXcOcbp7Q2W/ie/NaWNuyrbE4IX5+Fa3qVD/o
 Db5U4p5BHhdteKnbGiW+LSioSYRIgHtMiAb6Zk75oAVZdmvq4RbS+1J+AHRRmsSVm2VX1Q3Gjy4
 uANKLajxUoAIf4B8giHpOgVM0HPL0piatjXhdKQ==
X-Received: by 2002:ac8:58d2:0:b0:51c:167d:b328 with SMTP id
 d75a77b69052e-5283deef102mr23719681cf.40.1784810529514; 
 Thu, 23 Jul 2026 05:42:09 -0700 (PDT)
X-Received: by 2002:ac8:58d2:0:b0:51c:167d:b328 with SMTP id
 d75a77b69052e-5283deef102mr23719361cf.40.1784810529010; 
 Thu, 23 Jul 2026 05:42:09 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527d3b4149bsm33424371cf.28.2026.07.23.05.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 05:42:08 -0700 (PDT)
Message-ID: <926f8a64-a8a8-43be-835d-362682faa477@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 09:42:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: allow menvcfg/henvcfg LPE and SSE bits on
 RV32
To: A-Shehab <ahshehab24@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, debug@rivosinc.com
References: <20260719111749.23777-1-ahshehab24@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260719111749.23777-1-ahshehab24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfX6EqIwL116kLw
 ckI05tPwgLOA7BW/NfzDuOl5uEpJm2ehuMt790xEyUkHrZcKzXYwEcaxZyfqwX4exrnWUTynrds
 PUuXln43DGI7H2xA7Fq/4FxwgHa+W58DPKWbTPREr5qSYKCTJyKLBoJzfg9y26qSaQbXsJMZkJa
 7lpcF8fG8QGGvUtjUvzcDaWtigZE5tRK//2Mt7j3OOi4vaDmV2llzeMzT88EhDleA8uH2ktZIgu
 KZhUNXxVfq+VTl1LrfV4wobUxe2PVw7EWwiH9Zgynfgopdc0ZPxup4kV/8rJDJnYb2V15KHPGPV
 ovd+jxTvc/9YUeK46rUf8PU6ty741flKHinpFWppVuQ+l6yQ7nMjC8nxA9e6uBYy3J4oL1Yi2QZ
 0cDO9C8TK1llijcUyTzn28KnH7voWxMQUimNP2GfFjvpy5lekGrsmYiAMcYry26QcvndcnUnJO3
 XC3GSFPiSBhxReFphPQ==
X-Proofpoint-GUID: G4eude3JgXMTL1wHdxQtCsq9e5H4mHTj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEyNSBTYWx0ZWRfXyxWsXuyzh50d
 lkiUt5qGWUW5glTCOqFhbFBOaS1PPgWlk5TxZ0Ct0ymzu4PlM2RmzFD7DXQvwvrwp9B/huzMuhX
 k7pytDoDMyQAhq7ppba5tz8QncF0IS4=
X-Authority-Analysis: v=2.4 cv=btx8wkai c=1 sm=1 tr=0 ts=6a620c22 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=Tqcxryd4_fsETz_ZCVYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: G4eude3JgXMTL1wHdxQtCsq9e5H4mHTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230125
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 7/19/2026 8:17 AM, A-Shehab wrote:
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

Patch LGTM but it doesn't apply in current master.  We changed the file location in the
last PR (it's now on target/riscv/tcg/csr.c).


I fixed the conflict and applied it.  Code LGTM. Please re-send it on top of current master
to be merged.


Cheers,
Daniel


>   target/riscv/csr.c | 45 +++++++++++++++++++++++++++------------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index dd9726fcf4..58828a269a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3211,6 +3211,19 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
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
> @@ -3218,14 +3231,6 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
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
> @@ -3373,20 +3378,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
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


