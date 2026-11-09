Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8274606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRS4f5Mr;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MmnUuwEJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVqh-0007IB-Uc; Mon, 09 Nov 2026 15:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVqg-0007He-63
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:14 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVqe-000676-8J
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:13 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH4h21525214
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5NbQTpoJKmCh85xflC6UTM75sx0fWIGoUkUN7KtVroA=; b=XRS4f5MrbpCjRsr5
 rt7bTwCBndkKXG3rj+DjuODU1hmrWVCEPIkf7gPBORaTAtm6Y8X96Z9HKHq0OKUD
 r+Tw3mkLaVLEwqFsvg2D64lu+o75beZpcHmOjlLpKtPD5bTODj7WNOXIJt6tbFVo
 SulJ4ZpAwICLsZ59nWOh0Yfh0jCkE7qi+HMmBzeEVTs5BtQpNrkvzcucRdOGlPQZ
 YBJqBEmhurXYC09i1NTPrH+fjNsmseRrqMAEkEbUsWKkKac5cUAAjVXYp6gpX2Af
 xukOVRI1NarVrq3KUHX7u/lTSzy9o/ox5QdpV3dSUJZabiSV9uApH7fhUlRP8/ET
 l5p8sQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx81bwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:20:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337b591609so19054721cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255609; x=1794860409; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5NbQTpoJKmCh85xflC6UTM75sx0fWIGoUkUN7KtVroA=;
 b=MmnUuwEJP4l5kT21Qxpk/LPWVvhfGWHJdQMv/oeKjeutk+8gdiub2vmlVuj54NXr5q
 /khs3VeoVy/JBei4ltPeLYX/h2/MK1/pEh02bQgB0laT7rt29TraCfe8vwPu+ekfHEpU
 AuJlDADyHEEwGDcDAwI9AhugyScSUQZixM80aj88h3ergCRpQlN0GFR9u0ncfK2TVJaS
 GWGha2o942vpnK5+6ZLV6iDYmy51zpEyTy7DlIgMhoQc3CM6E4x3hNEeM16edIooO1Tk
 Yq5brbb6l02d2dRfn/Ky+gMkmyY9IH2O34eKJWhMflHTrQnx3yjlItK8/6qwSepdcr1M
 pNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255609; x=1794860409;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5NbQTpoJKmCh85xflC6UTM75sx0fWIGoUkUN7KtVroA=;
 b=Z1aFMZ50ExemDIKz4IEoL5IJqPsA9jgjT5JU3a0TvGiVpTKlSiDy1JswtA5iIgNON4
 EDObTUSKwMrOOrlzMN0jnHMzxbQLEQA7/UoL8vaF2L8Xg4F2xVDvtW3I61ie2U+IekXE
 DLguCNQYwiJ8xYxpxw30IXdz6+DW/bqsKVnqHP+tRb+EvJv/0EUAO1ozhVWrZ7KsX0M8
 gEKmCfGZsKgubG7MX5IZLD1B8yvFA26V1d052o+jrknD+q7+RMCZrwuVqnzEqV/7wv74
 iWJMZO/iByYmuQewVDkrDwpPqu2Kg2TKtC7dCBTMQ3ffC5Oc27DED84Wk6ingR+VWYka
 2s0Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGrfuYqct/wo7Zt1bcALhW2xtNkgqqXHgmabtWqLW95f0hOFq4moVW4sCKg+W9y7dyvHwEZppNgPh1Q@nongnu.org
X-Gm-Message-State: APuU4Z80n/R5tRT6/G1YXbYzPXCtlJ9/s3EMydi0USeQAi1tFAKU/6Sj
 Zp0UlkUFwETI5KA6beFOMizUW3dKdcwBeEDjJsWBq7swPq73t0Ry4z9i34v3OCRmbwtmYLSCoKH
 fLk3f2XMo6bYy7ZYPcr11I2Q8TlHhng7GE4gvYZD2Fn7BRwModlNsb9Pm3w==
X-Gm-Gg: AYBFou1mMesl2oOX79T7q3ApK1fpPcJK46QBGahg6yS7W4NW+AM8EBVF+hLxL/+Bxca
 h9rRIkneVYkwrCp6bHwVF7N81Z/gSyjw0Aky0hToeRFNATu152QsWgJb+lBaBrE0XMRpjGKTarQ
 qCBAGSNJzPdjrLZ9LLHObY41OOAyJsrDB8eAYsP1E2ndXyvsONycF0H4h2KhI4rtQmBNqn4d+dW
 XcBlwJCtW8f3CIEb3KzLvLzPWej0RLvpilVJcN3l/CM+qGoao/rt7xQcbr+VZMR2sH8+rxQ0BXz
 mGM4pbH0buFPLSiNGU646D6e0gC//MCsJoB5jaIJ9KzufM3s6m6QxvAcyAuW+9FVtHtJwQGyPYt
 /hO3uZnRTkH6wKYhtlTCSow/EPuNcWW/duKKLr0NU919s/F6X6IcDJ4r6IYyd7WePlwP+L32Ot4
 xL6gQuBa1x
X-Received: by 2002:a05:622a:2b43:b0:532:9bb3:13b6 with SMTP id
 d75a77b69052e-55527335d58mr7803331cf.22.1794255607860; 
 Mon, 09 Nov 2026 12:20:07 -0800 (PST)
X-Received: by 2002:a05:622a:2b43:b0:532:9bb3:13b6 with SMTP id
 d75a77b69052e-55527335d58mr7802991cf.22.1794255607251; 
 Mon, 09 Nov 2026 12:20:07 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af612dfsm5858101cf.8.2026.11.09.12.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:20:06 -0800 (PST)
Message-ID: <06ceecae-260c-4041-bae0-60b916cb121a@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:20:03 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/38] target/riscv: rvv: Implement Zvfqwdota8f
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
 <20261104194155.679241-18-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-18-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af22afa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=wIGbg98yotuRc1TVPKUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: 58TfqBOhXOvyRa5dsXCX9CFy84RYeXIa
X-Proofpoint-ORIG-GUID: 58TfqBOhXOvyRa5dsXCX9CFy84RYeXIa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX5jwWNWXrpNKR
 1zuKTbbRDakJk+o00zXC3RxNmXW9SYdDDxtKcfGVt943+VdJKp9qp9iC1B+4z6ZGChHG/aGoo+E
 fxUndY5JTl5oGlV4VjY4ais1fg9Hn6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX3lUCqKd9uOhr
 monTISaOskS2AT46NvlHQXQ7B5wRWQsZPce6KDmWIAFLX3WeBprJ3FvQDveVHSr17ke2p41ybp1
 +3S5C8p/9K6hSsqjjbOYNh2x8stYDAzGjfUEWSDXwfUZOMpOi5hT7gOAAYsHXSvCovGiuYW0d6w
 mDBiMu+Ed2cCOKtuzdo0CqtR7t0+I+fX0/C7KCQ4ODOH3Mp6eF2NS2iJY/g51l5kkYNA4iluCAA
 ZoLl3EK3Ukhzw/KfbEEIfISo4cku5LNJ+DLt+BP1pKZxS10jzbRFb0FNidiwTEpjR72gHGlD33C
 zU3JLe1bKuu8/VOXJq1Ejhj3mnAY6ux3pSkqiTMgvWjQWI1FzjMg5qJyEofiBCnW8FI6wOe/n9k
 GXFKe6WxmOcWVSTBmyBLLCcn8HU4dMhG0dSfoW29m7Oc6/zzE9KAgH/NgASJCJU96rt+Rc92XZ0
 h3GCRkg1Epu7Bk9g5AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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
> Implements the Zvfqwdota8f OCP FP8 dot-product instructions:
> - vfqwdota.vv: vs2 is E4M3, vs1 format selected by altfmt (0=E4M3, 1=E5M2)
> - vfqwdota.alt.vv: vs2 is E5M2, vs1 format selected by altfmt (0=E4M3, 1=E5M2)
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/helper.h                       |  5 ++
>   target/riscv/insn32.decode                  |  4 ++
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 47 ++++++++++++++++
>   target/riscv/tcg/vector_helper.c            | 62 +++++++++++++++++++++
>   4 files changed, 118 insertions(+)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 918ff21b3e2..48c64f45748 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -1395,6 +1395,11 @@ DEF_HELPER_6(vqwdotas_vv_h, void, ptr, ptr, ptr, ptr, env, i32)
>   
>   /* Zvfwdota16bf - BF16 Dot Product */
>   DEF_HELPER_6(vfwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +
> +/* Zvfqwdota8f - OCP FP8 Dot Product */
> +DEF_HELPER_6(vfqwdota_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_6(vfqwdota_alt_vv, void, ptr, ptr, ptr, ptr, env, i32)
> +
>   /* SiFive Custom int8 Matrix-Multiply */
>   DEF_HELPER_5(sf_vqmaccu_4x8x4, void, ptr, ptr, ptr, env, i32)
>   DEF_HELPER_5(sf_vqmacc_4x8x4, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index d800ad99451..def5785f8e2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -1104,3 +1104,7 @@ vqwdotas_vv  100111 . ..... ..... 000 ..... 1110111 @r_vm
>   
>   # *** Zvfwdota16bf BF16 Dot-Product Extension ***
>   vfwdota_vv  100100 . ..... ..... 001 ..... 1110111 @r_vm
> +
> +# *** Zvfqwdota8f OCP FP8 Dot-Product Extension ***
> +vfqwdota_vv     100110 . ..... ..... 001 ..... 1110111 @r_vm
> +vfqwdota_alt_vv 100111 . ..... ..... 001 ..... 1110111 @r_vm
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index c50f863ea0b..6eb22494838 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -4242,3 +4242,50 @@ static bool trans_vfwdota_vv(DisasContext *s, arg_rmrr * a)
>       }
>       return false;
>   }
> +
> +/* Zvfqwdota8f OCP FP8 Dot-Product Extension */
> +static bool vext_vfqwdota_check(DisasContext *s, arg_rmrr *a)
> +{
> +    return s->mstatus_fs != EXT_STATUS_DISABLED &&
> +           vext_zvdota_base_check(s, a) &&
> +           (s->cfg_ptr->ext_zvfqwdota8f && s->sew == MO_8);
> +}
> +
> +#define GEN_ZVDOTA_FP8_TRANS(NAME, CHECK)                               \
> +static bool trans_##NAME(DisasContext *s, arg_rmrr *a)                  \
> +{                                                                       \
> +    if (CHECK(s, a)) {                                                  \
> +        TCGv_ptr dest, src1, src2, mask;                                \
> +        TCGv_i32 desc;                                                  \
> +        uint32_t data = 0;                                              \
> +                                                                        \
> +        gen_set_rm(s, RISCV_FRM_DYN);                                   \
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
> +        gen_helper_##NAME(dest, mask, src1, src2, tcg_env, desc);       \
> +                                                                        \
> +        finalize_rvv_inst(s);                                           \
> +                                                                        \
> +        return true;                                                    \
> +    }                                                                   \
> +    return false;                                                       \
> +}
> +
> +GEN_ZVDOTA_FP8_TRANS(vfqwdota_vv, vext_vfqwdota_check)
> +GEN_ZVDOTA_FP8_TRANS(vfqwdota_alt_vv, vext_vfqwdota_check)
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index a4c52ed296a..5cb44326200 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -6075,3 +6075,65 @@ void HELPER(vfwdota_vv)(void *vd, void *v0, void *vs1, void *vs2,
>           vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);
>       }
>   }
> +
> +/*
> + * Zvfqwdota8f: OCP FP8 Dot Product with Accumulation
> + */
> +#define GEN_VEXT_ZVDOTA_FP8(NAME, TYPE_VS2)                              \
> +void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,              \
> +                  CPURISCVState *env, uint32_t desc)                     \
> +{                                                                        \
> +    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(uint8_t)));        \
> +    uint32_t vm = vext_vm(desc);                                         \
> +    uint32_t vl = env->vl;                                               \
> +    uint32_t vta = vext_vta(desc);                                       \
> +    uint32_t vta_all_1s = vext_vta_all_1s(desc);                         \
> +    uint32_t total_elems = riscv_cpu_cfg(env)->vlenb >> 2;               \
> +    uint32_t altfmt = FIELD_EX64(env->vtype, VTYPE, ALTFMT);             \
> +    uint32_t i;                                                          \
> +    uint8_t *a_vec, *b_vec;                                              \
> +    uint32_t dot_result, acc;                                            \
> +                                                                         \
> +    VSTART_CHECK_EARLY_EXIT(env, vl);                                    \
> +                                                                         \
> +    a_vec = g_new0(uint8_t, vlmax);                                      \
> +    b_vec = g_new0(uint8_t, vlmax);                                      \

Same comment I made in an earlier patch about using g_autofree on these arrays.

With this changed:


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


> +                                                                         \
> +    for (i = 0; i < vl; i++) {                                           \
> +        if (!vm && !vext_elem_mask(v0, i)) {                             \
> +            continue;                                                    \
> +        }                                                                \
> +        a_vec[i] = *((uint8_t *)vs2 + H1(i));                            \
> +        b_vec[i] = *((uint8_t *)vs1 + H1(i));                            \
> +    }                                                                    \
> +                                                                         \
> +    FloatExceptionFlags pre_fflag =                                      \
> +        get_float_exception_flags(&env->fp_status);                      \
> +    FloatSNaNRule pre_snan_rule = get_snan_rule(&env->fp_status);        \
> +    set_snan_rule(float_snan_never, &env->fp_status);                    \
> +    if (altfmt == 0) {                                                   \
> +        dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e4m3(          \
> +            a_vec, b_vec, vlmax, &env->fp_status);                       \
> +    } else {                                                             \
> +        dot_result = rvbna_dot_float8_##TYPE_VS2##_float8_e5m2(          \
> +            a_vec, b_vec, vlmax, &env->fp_status);                       \
> +    }                                                                    \
> +    set_snan_rule(pre_snan_rule, &env->fp_status);                       \
> +                                                                         \
> +    acc = *((uint32_t *)vd + H4(0));                                     \
> +    *((uint32_t *)vd + H4(0)) = rvbna_final_f32_add(dot_result, acc,     \
> +                                                    &env->fp_status);    \
> +    riscv_cpu_check_fflags(env, pre_fflag);                              \
> +                                                                         \
> +    g_free(a_vec);                                                       \
> +    g_free(b_vec);                                                       \
> +                                                                         \
> +    env->vstart = 0;                                                     \
> +                                                                         \
> +    if (vta_all_1s) {                                                    \
> +        vext_set_elems_1s(vd, vta, 1 * 4, total_elems * 4);              \
> +    }                                                                    \
> +}
> +
> +GEN_VEXT_ZVDOTA_FP8(vfqwdota_vv, e4m3)
> +GEN_VEXT_ZVDOTA_FP8(vfqwdota_alt_vv, e5m2)


