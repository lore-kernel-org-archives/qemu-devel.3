Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109C60A2607
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F+wehGec;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZjizHgQT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVWc-0003kD-Mk; Mon, 09 Nov 2026 14:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVV9-0002qq-2j
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:58:02 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVV7-000458-2k
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:57:58 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH5aZ846193
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3mBnMvkc6qJ0FXSo2oKvdR0NsEgLmyr67LRlWdgtklE=; b=F+wehGecGzR1g9sK
 3K182bCSBY6l9Uyt5zQSNB38XJBuZm5W5F4715IrvUhHKOvU33UGEHUCGWcnO8iw
 2zF4fhlpBYl5rlKsT7nvXvPVFMjhegC+8sEAH5BjjKaKKDc9r9FlxpzqthkQzONk
 CMwCzU6tORvthMvLq0jQWTZbJQtru04xoANsWU6VS7UErj2dl6cquVUsZ5CGGUdb
 f0Jc9WFlh12qJCkuWzFyhpN6lsqVR9D58VO3tvJOwePsgFsc5kDKXrQkwr4Znnv6
 lGinjDtxdOTqlDIA5D2KNOTmFT/BfgKAizI67dWeagfVz/lOnLEdDzmtWqo3B0x2
 V8++/Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapa1hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:57:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eb05c8241so24855446d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254275; x=1794859075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3mBnMvkc6qJ0FXSo2oKvdR0NsEgLmyr67LRlWdgtklE=;
 b=ZjizHgQTcm2ykAgpMzf7DCrfGBfD4/3y/B86dPZ8Z48TgBUrEFXJDa3EKFSxhZ1cdE
 sA06ZEvKYS00fKVQVv/vZjFVal+8csEwROFzXLSCo7GZpG/x4bpG+bWmSoNHbKuHAnM9
 NVR78+l6nLY6pf1woo/RDfpptJZztbwliVb9G+8+pBA+cQZkSQ6m6RU5mTN7T8Ixtfy2
 awrVcNXj5vLVQibXi4lW6DaJyoEGbqHWjQCz85OTeTY5u07ZvJdDC87lVr3T/p7aExG9
 hVt2iXHrefue8492ePeO8lA72eiRECepY/j+/yJYuEd4dXGif38+JFGZj56VTiiEXfZr
 vT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254275; x=1794859075;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3mBnMvkc6qJ0FXSo2oKvdR0NsEgLmyr67LRlWdgtklE=;
 b=YE1NgrfwYT7+FGpVK+rHVSBDKQB9edpxLTV8aw95lEn2/J+n1tJjGGcnshL/95gac/
 L6jSaghfyY/F6IveAUaX3UyLuyZGOQPZ5Ytx9r6GUJbla2diZOXkKKexeTH4WLAdu2s5
 /C8rO5XI0d91rg4Opt+HBCdZnkAiIZH3B355KU17hlzxoxwU+iuRqUu/KsSRdZKu9im5
 hKL1kiCqc1wj9RIoaFESZUHnZpnop1zwowpUX6MNYCCa0t1ES1wmhoeovVIyXMYSXHfa
 8HfSQWNXPd/vY6+fR1vLEHW/tXoL8d+vfuegAlF9bVtVPUs5f8t2/igMC9SB3MpbBx/D
 nezw==
X-Forwarded-Encrypted: i=1;
 AL+hErGbm0Xiby1O4+aMMDhpB7prfdi+0OGvIbp+LblTschRQShdmNJFpqcVfxBxDAjS5wszDOUSG9OLvxZO@nongnu.org
X-Gm-Message-State: APuU4Z+1eHFvpfSbUoi5Q0qKRlCE25QjNzsYvHSvComWW5OmWr1QZt1o
 Z3OsJIIaNKjg851eRt3l3kzCedEtkpPun8M+7sbpEeTBVrqMkXLd+U+ED2HcjXmsJwxsO1AxNm0
 jgqFNPNSAhEPnk7s4A7fw9MXdAUku6iQ0o5HoJfRdpyYRCi6U64PMwicsSw==
X-Gm-Gg: AYBFou0XPCzBDufx3bzPvJIrFouWHhnHKHJ23rwfZyqBBfXozQYtjI7toxDYefoValu
 joWsKT1t+4xOmAcvRdHEfw1F958htOxrylhkheurzWD71TK1NGiOeaWAHhGRwZ6rpYXQOMZc3OB
 rQMqkPqIeem1hkdgrZlu9Gd4LZ7jex55+1jGpS3V2iQU9pmphDpZiA7HRl+tJZCvrRc3SlPPPKv
 NGX9IuYF6B07zg9kNxhX7qjBkm5g7pwkkPYOvOOGo4PdvwUZyuUiwR5nsTLJUR9RR9Uo/WjECr4
 e18PqejznpA/RSFtEApFEoHkzSEeI/kGyGXqoWdrWUN0R0dZnP2nclPo1zs96nJpFFZ67Ko1h5w
 7dyyYaI3c+YytNpO71PRZ6Ok/+e52WeA8S0andqD9YLH7THxjcOjZuVRPAhXSTHZWAqCWicdXET
 dmqP4pw6UB
X-Received: by 2002:a05:620a:6496:b0:945:d852:1618 with SMTP id
 af79cd13be357-9479f3eda61mr73629385a.70.1794254274718; 
 Mon, 09 Nov 2026 11:57:54 -0800 (PST)
X-Received: by 2002:a05:620a:6496:b0:945:d852:1618 with SMTP id
 af79cd13be357-9479f3eda61mr73626285a.70.1794254274196; 
 Mon, 09 Nov 2026 11:57:54 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm51904185a.10.2026.11.09.11.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:57:53 -0800 (PST)
Message-ID: <a7a79b0f-a747-432e-84d2-3d59b2e734b9@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:57:50 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/38] target/riscv: rvv: Implement Zvqwdota8i
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
 <20261104194155.679241-7-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-7-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX0COlHs74agod
 YOX+oqhRdywRwNXh3IOSQyP1oonvSIjWW8Qx38WqjZ5ufYw3YZjMT+pshXu419h8xQRVUpxOYZH
 GeQ95xxcxNtODpNF/qaKYNA67zN1UUoR1RV8UKPxdjPkPEPei7S1FSCrChpNwDv7+vjaVv0q0dF
 q9cUOAsL/0zaR8SYHMOPRbJZPP30aHfNJtosmDEkftigBNrc5t0E0EpqigI13dqbyTanof5HIMh
 et0/QU+E9KwxYZXFW6WgVlz08Ug0xntC563IvuAz4sG70h1kv8+gizJLhu37qiywuZvlcPZivo/
 JQvGtv6IqYBA7N3VJo6+uAyqj3TGr+ZzSEy0KWSrVhRLCpjinFobMSgxn/oxmSbojTGwtzv/MyW
 VC0D6xM+FULJr+M+9AxYgEaZN6ICisK+oc9Ww21Wg7ZUoUh8KwnDr72zKKkUAAgpyJzwVQTosqR
 YnvYJFiXrafkm/owuLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX85Q25d2YQKRe
 Xvw/H//XvBbPno63KvJLj+AdHcOwBiNKNkJ1z4FOdy9cnbaKNy82d0bYWmZKrS/yhCwmXBNKSiQ
 mk8E7ZQOm162Q6l415Z7PMglHODItHg=
X-Proofpoint-ORIG-GUID: lYXfSw1cpxMhJGsjSOqn_qfcYTk4GllX
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af225c3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=I9KghG3TAxjRfXow3JYA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: lYXfSw1cpxMhJGsjSOqn_qfcYTk4GllX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090078
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Implement the vqwdotau.vv and vqwdotas.vv instructions from the
> Zvqwdota8i extension. These instructions compute a dot product between
> two 8-bit integer vectors, accumulating into a 32-bit scalar in vd[0].
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/helper.h                       |  4 ++
>   target/riscv/insn32.decode                  |  4 ++
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 63 +++++++++++++++++++++
>   target/riscv/tcg/vector_helper.c            | 49 ++++++++++++++++
>   4 files changed, 120 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1cffcad580c..767b04658b4 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1387,6 +1387,10 @@ DEF_HELPER_1(ssamoswap_disabled, void, env)
>   /* Zalrsc SC write probe */
>   DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
>   
> +/* Zvqwdota8i - 8-bit Integer Dot Product */
> +DEF_HELPER_6(vqwdotau_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vqwdotas_vv_b, void, ptr, ptr, ptr, ptr, env, i32)
> +
>   /* SiFive Custom int8 Matrix-Multiply */
>   DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 795badc8a7d..cc7d639ab73 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1097,3 +1097,7 @@ vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
>   vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
>   vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
>   vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
> +
> +# *** Zvqwdota8i 8-bit Integer Dot-Product Extension ***
> +vqwdotau_vv  100110 . ..... ..... 000 ..... 1110111 @r_vm
> +vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 7e1295f33e7..befdbf273e5 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4132,7 +4132,70 @@ static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
>       return false;                                                       \
>   }
>   
> +/* Zvqwdota8i 8-bit Integer Dot-Product Extension */
> +static bool vext_zvdota_base_check(DisasContext *s, arg_rmrr * a)
> +{
> +    return require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           s->vstart_eq_zero &&
> +           require_align(a->rs1, s->lmul) &&
> +           require_align(a->rs2, s->lmul) &&
> +           require_vm(a->vm, a->rd) &&
> +           require_noover(a->rd, 0, a->rs1, s->lmul) &&
> +           require_noover(a->rd, 0, a->rs2, s->lmul) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm);
> +}
> +
> +static bool vext_vqwdota_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return vext_zvdota_base_check(s, a) &&
> +           (s->cfg_ptr->ext_zvqwdota8i && s->sew == MO_8);
> +}
> +
> +typedef void gen_helper_zvdota_int(TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_ptr,
> +                                   TCGv_env, TCGv_i32);
> +
> +#define GEN_ZVDOTA_INT_TRANS(NAME, CHECK)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    static gen_helper_zvdota_int * const fns[2] = {                     \
> +        gen_helper_##NAME##_b, NULL,                                    \
> +    };                                                                  \
> +    if (CHECK(s, a)) {                                                  \
> +        TCGv_ptr dest, src1, src2, mask;                                \
> +        TCGv_i32 desc;                                                  \
> +        uint32_t data = 0;                                              \
> +                                                                        \
> +        data = FIELD_DP32(data, VDATA, VM, a->vm);                      \
> +        data = FIELD_DP32(data, VDATA, LMUL, s->lmul);                  \
> +        data = FIELD_DP32(data, VDATA, VTA, s->vta);                    \
> +        data = FIELD_DP32(data, VDATA, VTA_ALL_1S, s->cfg_vta_all_1s);  \
> +                                                                        \
> +        dest = tcg_temp_new_ptr();                                      \
> +        mask = tcg_temp_new_ptr();                                      \
> +        src1 = tcg_temp_new_ptr();                                      \
> +        src2 = tcg_temp_new_ptr();                                      \
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,            \
> +                                          s->cfg_ptr->vlenb, data));    \
> +                                                                        \
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, a->rd));            \
> +        tcg_gen_addi_ptr(src1, tcg_env, vreg_ofs(s, a->rs1));           \
> +        tcg_gen_addi_ptr(src2, tcg_env, vreg_ofs(s, a->rs2));           \
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));                \
> +                                                                        \
> +        fns[s->sew](dest, mask, src1, src2, tcg_env, desc);             \
> +                                                                        \
> +        finalize_rvv_inst(s);                                           \
> +                                                                        \
> +        return true;                                                    \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
>   GEN_ABD_OPIVV_WIDEN_TRANS(vwabda_vv, vwabd_vv_check)
>   GEN_ABD_OPIVX_WIDEN_TRANS(vwabda_vx, vwabd_vx_check)
>   GEN_ABD_OPIVV_WIDEN_TRANS(vwabdau_vv, vwabd_vv_check)
>   GEN_ABD_OPIVX_WIDEN_TRANS(vwabdau_vx, vwabd_vx_check)
> +
> +GEN_ZVDOTA_INT_TRANS(vqwdotau_vv, vext_vqwdota_check)
> +GEN_ZVDOTA_INT_TRANS(vqwdotas_vv, vext_vqwdota_check)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 4ba0a89f4b5..6abcf522648 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -5970,3 +5970,52 @@ GEN_VEXT_VV(vwabdau_vv_b, 2)
>   GEN_VEXT_VV(vwabdau_vv_h, 4)
>   GEN_VEXT_VX(vwabdau_vx_b, 2)
>   GEN_VEXT_VX(vwabdau_vx_h, 4)
> +
> +/*
> + * Zvqwdota8i: 8-bit Integer Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVDOTA_INT(NAME, WD, W1, T2, HD, HS)            \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
> +                  CPURISCVState *env, uint32_t desc)             \
> +{                                                                \
> +    uint32_t vm = vext_vm(desc);                                 \
> +    uint32_t vl = env->vl;                                       \
> +    uint32_t vta = vext_vta(desc);                               \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                 \
> +    uint16_t vlenb = riscv_cpu_cfg(env)->vlenb;                  \
> +    uint32_t total_elems = vlenb >> ctzl(sizeof(uint##WD##_t));  \
> +    uint8_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);      \
> +    uint32_t i;                                                  \
> +    uint##WD##_t acc, dot_result, a;                             \
> +                                                                 \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                            \
> +                                                                 \
> +    acc = *((uint##WD##_t *)vd + HD(0));                         \
> +    dot_result = 0;                                              \
> +                                                                 \
> +    for (i = 0; i < vl; i++) {                                   \
> +        if (!vm && !vext_elem_mask(v0, i)) {                     \
> +            continue;                                            \
> +        }                                                        \
> +                                                                 \
> +        uint##WD##_t b = *((T2 *)vs2 + HS(i));                   \
> +        if (altfmt) {                                            \
> +            a = *((int##W1##_t *)vs1 + HS(i));                   \
> +        } else {                                                 \
> +            a = *((uint##W1##_t *)vs1 + HS(i));                  \
> +        }                                                        \
> +        dot_result += (a * b);                                   \
> +    }                                                            \
> +                                                                 \
> +    *((uint##WD##_t *)vd + HD(0)) = acc + dot_result;            \
> +                                                                 \
> +    env->vstart = 0;                                             \
> +                                                                 \
> +    if (vta_all_1s) {                                            \
> +        vext_set_elems_1s(vd, vta, sizeof(int##WD##_t),          \
> +                          total_elems * sizeof(int##WD##_t));    \
> +    }                                                            \
> +}
> +
> +GEN_VEXT_ZVDOTA_INT(vqwdotau_vv_b, 32, 8, uint8_t, H4, H1)
> +GEN_VEXT_ZVDOTA_INT(vqwdotas_vv_b, 32, 8, int8_t, H4, H1)


