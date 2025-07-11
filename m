Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A43C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 18:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaIj9-0002vd-9v; Fri, 11 Jul 2025 14:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uaIj7-0002qd-FF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 14:44:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uaIj4-0002Rr-St
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 14:44:05 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAoBdh016258
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 18:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kO/M2EPNN687nXeKYCi49erZ
 16mvnzZVsqVeFWAR9tI=; b=fXlYLb05Yf/MsgxmZQdFnYvCefromaCBlqGtk/Jc
 AvU5xNOdEfBpMzJDT0DWl3tEQWtSkzs+fpfQSH8n0RB4TPCqZpdi++D2929vPWMV
 0QhIscIhXa8rNqFDlwVgXYAyaefsMQA5mm4TQyBm/l4Nt+hMfRWdxD+sBv8w+Bsv
 OdYgQNoqElQ+mGk04YplhnwU7KWhcfJyD9zgxdrFQDu+2W0kq+he8esKqHBx1QyU
 6W8X8Jj0UM+Gkp04XF9Y40LTqc/joFk0woMYfk86HEYgH3Il4Od5AaGLSSEXH8gI
 KQ++TfWQ9h2B4szQqDUCkM1yPTdiUmfTdF+ECXvNNcT1jw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u5wmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 18:43:57 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-710ee127c79so37598077b3.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 11:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752259436; x=1752864236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kO/M2EPNN687nXeKYCi49erZ16mvnzZVsqVeFWAR9tI=;
 b=aQYc5WXe3oK/6K8mWd9DHgdOjF8KSSsfNXGOVWs7VAb6/FUAP8fx7+AzWhouWB+6SY
 hmIUqrVYO9I0GAwbRIVNvI0H4SY2pi3Mzh4ie0Fn4vvVfNm4hWJa1K1PI525mP5ENu14
 ts8zLLWhe+4i0nbuokUpoC7Kvhms+Za9HxRIw0cT/Hd0b/40ssnalAefTE3u86dR7QzP
 VLlmAB8XjK7MhxzX5LbzO/0apbPdz7rb85jmTu6gnPywqrc75bW+yAeZu5OsMmaj/HFa
 oKH7u7e4ErZm3bFqTOFHaf8v7WxogIfShBiuv7G4qS/Rj759xtQQEyCQZHqoaUZKytQ/
 8/Zw==
X-Gm-Message-State: AOJu0YxKejlSaa1VUGvHm1HhlB6Auo74w4K0FjFq3U/B6oeWTq4IOELP
 e5r+DQExJfR8XdtW/Nma3vOfJ5z3jxH/Jpm07f+VucaTg8WoKMuvulqlj9PFxax4zrsxa+FnbIO
 Q9dgle68Pzk+2T5/BIxCmnb7msJXOTqLfbzoHDp9Uae65c6Z3mPrzRNcj2ptMTQB2F6XJOhIl9q
 Q/ZuSAoOA/XbxJWZVsyLkUZQ/WROeXHJ++2/CvScV/c1c=
X-Gm-Gg: ASbGncsThC42m1+G0MRqt3beSpgQ0ElM8c/oTF+wKXstBGfrSgif6innJkU9dAVWY3Q
 y01zT6RCTkdjZ1l6vTqCDK+u1p6srxdejYEeTbv2AO0wBrX222BSLIOMYs3XjXJBkYEbiabpeqi
 7Cu/cdKrG8DY4Slgn/X2B7Sw==
X-Received: by 2002:a05:690c:6982:b0:70c:aa00:e0ec with SMTP id
 00721157ae682-717d5e93e7dmr74141447b3.21.1752259436196; 
 Fri, 11 Jul 2025 11:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgs3O3EPVK/7bUD9Ntpt6rfBlM7zgJV0Jis56/uWe6FHeQTQWGtjHX4kyUmtcV+RQyzGToi555OAUEPYowHUs=
X-Received: by 2002:a05:690c:6982:b0:70c:aa00:e0ec with SMTP id
 00721157ae682-717d5e93e7dmr74141047b3.21.1752259435729; Fri, 11 Jul 2025
 11:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250708221438.347643-1-vacha.bhavsar@oss.qualcomm.com>
In-Reply-To: <20250708221438.347643-1-vacha.bhavsar@oss.qualcomm.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:43:44 -0400
X-Gm-Features: Ac12FXzQyRGBKbL5VAtIfgb1nnNpOe_CJEEQdpYHczGODhWectMsMGr-q9iGDiE
Message-ID: <CAEWVDmuwZxg_asdYVOaxu8j85wcFb_OG2y6zTdeKxgsGv0tq0w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Added support for SME register exposure to GDB
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000038a5700639abb1c5"
X-Proofpoint-ORIG-GUID: w5xWNO6T1zYzo5gGcQFqpmnanS22jhfO
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=68715b6d cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=8LDteDWnL1_M1gbwMHoA:9 a=QEXdDO2ut3YA:10 a=HjjZBBvkAAAA:8
 a=0EoHf_88JRsSL5bwKDUA:9 a=DWVyRmzKyUFD71-A:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzOCBTYWx0ZWRfX4Ci8tkVo+EGY
 i3HQDkbIa2xYcKCH7R9BU/HHWdhf6p8H+O+JgaN1e4NzQgiI4NXs5tkBu6GFxqPCt9jE2FXLsaZ
 coyiBqwnkIf9jCcVpoPOoJn0RPSPVvMqeOMBZytevV2BNjzC7X1zPSHNWy14SlC5sGMHbZR9bC3
 d5zD0B+SSWCY0ToLlf935ptXKxK3CBI3q0S7DO8AVv0N3ExUaMuFb7Lw13YJuj77CJfY/7cGujI
 24dBKXRJ0s+Ml+x9XIyPK6ntwScGQZEWT1LTstVBN2k3DSaH6I8tKLtPoni98hU3AolVsFbfNZr
 IQLo8ICh4ll7xlxH6DKKIgQYjXCgNs/uxq2LI/Bmv0ZhpZqe+6munjOdxbmBGouAcx2K4kC2tLv
 YAWbU5a1qh6ZkheMQBbWWktUlZFA8J1icE4nHc1Tbe5y5q7E/I8AJ6sOQwCU14iusWBdLj4O
X-Proofpoint-GUID: w5xWNO6T1zYzo5gGcQFqpmnanS22jhfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000038a5700639abb1c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ richard.henderson@linaro.org

Hi Richard,


I'm an intern working with Joel Jones and he mentioned you've worked quite
a bit on SME on QEMU. We were wondering if you could take a look at this
patch as the deadline for the soft freeze is fast approaching and we'd like
it to make it to the next release.



Thanks,

Vacha

On Tue, Jul 8, 2025 at 6:14=E2=80=AFPM Vacha Bhavsar <vacha.bhavsar@oss.qua=
lcomm.com>
wrote:

> The QEMU GDB stub does not expose the ZA storage SME register to GDB via
> the remote serial protocol, which can be a useful functionality to debug
> SME
> code. To provide this functionality in Aarch64 target, this patch
> registers the
> SME register set with the GDB stub. To do so, this patch implements the
> aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> specify how to get and set the SME registers, and the
> arm_gen_dynamic_smereg_feature() function to generate the target
> description in XML format to indicate the target architecture supports SM=
E.
> Finally, this patch includes a dyn_smereg_feature structure to hold this
> GDB XML description of the SME registers for each CPU.
>
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> ---
>  target/arm/cpu.h       |   1 +
>  target/arm/gdbstub.c   |   6 +++
>  target/arm/gdbstub64.c | 119 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/internals.h |   3 ++
>  4 files changed, 129 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index c8cf0ab417..c37ea7dcd2 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -933,6 +933,7 @@ struct ArchCPU {
>
>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>      DynamicGDBFeatureInfo dyn_svereg_feature;
> +    DynamicGDBFeatureInfo dyn_smereg_feature;
>      DynamicGDBFeatureInfo dyn_m_systemreg_feature;
>      DynamicGDBFeatureInfo dyn_m_secextreg_feature;
>
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index ce4497ad7c..9c942c77cc 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU
> *cpu)
>              GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs,
> cs->gdb_num_regs);
>              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
>                                       aarch64_gdb_set_sve_reg, feature, 0=
);
> +            if (isar_feature_aa64_sme(&cpu->isar)) {
> +                GDBFeature *sme_feature =3D
> arm_gen_dynamic_smereg_feature(cs,
> +                                             cs->gdb_num_regs);
> +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
> +            }
>          } else {
>              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
>                                       aarch64_gdb_set_fpu_reg,
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 64ee9b3b56..e2fc874b38 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -228,6 +228,88 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t
> *buf, int reg)
>      return 0;
>  }
>
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +    bool streaming_mode =3D ((env->svcr & 0x01) !=3D 0);
> +
> +    switch (reg) {
> +    /* Svg register */
> +    case 0:
> +    {
> +        int vq;
> +        if (streaming_mode) {
> +            vq =3D sve_vqm1_for_el_sm(env, arm_current_el(env),
> +                     streaming_mode) + 1;
> +        } else {
> +            vq =3D 0;
> +        }
> +        /* svg =3D vector granules (2 * vector quardwords) in streaming
> mode */
> +        return gdb_get_reg64(buf, vq * 2);
> +    }
> +    case 1:
> +        return gdb_get_reg64(buf, env->svcr);
> +    case 2:
> +    {
> +        int q;
> +        int len =3D 0;
> +        int vq =3D cpu->sve_max_vq;
> +        int svl =3D vq * 16;
> +        for (int i =3D 0; i < svl; i++) {
> +            for (q =3D 0; q < vq; q++) {
> +                len +=3D gdb_get_reg128(buf,
> +                           env->za_state.za[i].d[q * 2 + 1],
> +                           env->za_state.za[i].d[q * 2]);
> +            }
> +        }
> +        return len;
> +    }
> +    default:
> +        /* gdbstub asked for something out our range */
> +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d",
> __func__, reg);
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    CPUARMState *env =3D &cpu->env;
> +
> +    /* The first 32 registers are the zregs */
> +    switch (reg) {
> +    /* The first 32 registers are the zregs */
> +    case 0:
> +    {
> +        /* cannot set svg via gdbstub */
> +        return 0;
> +    }
> +    case 1:
> +        env->svcr =3D *buf & 0x03;
> +        return 8;
> +    case 2:
> +        int vq, len =3D 0;
> +        int svl =3D cpu->sve_max_vq * 16;
> +        uint64_t *p =3D (uint64_t *) buf;
> +        for (int i =3D 0; i < svl; i++) {
> +            for (vq =3D 0; vq < cpu->sve_max_vq; vq++) {
> +                env->za_state.za[i].d[vq * 2 + 1] =3D *p++;
> +                env->za_state.za[i].d[vq * 2] =3D *p++;
> +                len +=3D 16;
> +            }
> +        }
> +        return len;
> +    default:
> +        /* gdbstub asked for something out our range */
> +        break;
> +    }
> +
> +    return 0;
> +}
> +
>  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
>  {
>      ARMCPU *cpu =3D ARM_CPU(cs);
> @@ -392,6 +474,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState
> *cs, int base_reg)
>      return &cpu->dyn_svereg_feature.desc;
>  }
>
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    int vq =3D cpu->sve_max_vq;
> +    int svl =3D vq * 16;
> +    GDBFeatureBuilder builder;
> +    int reg =3D 0;
> +
> +    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
> +        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
> +
> +
> +    /* Create the sme_bv vector type. */
> +    gdb_feature_builder_append_tag(&builder,
> +        "<vector id=3D\"sme_bv\" type=3D\"uint8\" count=3D\"%d\"/>",
> +        svl);
> +
> +    /* Create the sme_bvv vector type. */
> +    gdb_feature_builder_append_tag(
> +        &builder, "<vector id=3D\"sme_bvv\" type=3D\"sme_bv\" count=3D\"=
%d\"/>",
> +        svl);
> +
> +    /* Define the svg, svcr, and za registers. */
> +
> +    /* fpscr & status registers */
> +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
> +        "int", NULL);
> +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
> +        "int", NULL);
> +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg++,
> +        "sme_bvv", NULL);
> +
> +    gdb_feature_builder_end(&builder);
> +
> +    return &cpu->dyn_smereg_feature.desc;
> +}
> +
>  #ifdef CONFIG_USER_ONLY
>  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
>  {
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 21a8d67edd..af090b9b8e 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_mask(CPUARMStat=
e
> *env)
>  }
>
>  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
> +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);
>  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
> +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
> +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
>  int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
>  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
> --
> 2.34.1
>
>

--00000000000038a5700639abb1c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0">+</a>
<a aria-label=3D"Link richard.henderson@linaro.org" id=3D"gmail-menur13ic" =
href=3D"mailto:richard.henderson@linaro.org" rel=3D"noreferrer noopener" ta=
rget=3D"_blank" class=3D"gmail-fui-Link gmail-___1q1shib gmail-f2hkw1w gmai=
l-f3rmtva gmail-f1ewtqcl gmail-fyind8e gmail-f1k6fduh gmail-f1w7gpdv gmail-=
fk6fouc gmail-fjoy568 gmail-figsok6 gmail-f1s184ao gmail-f1mk8lai gmail-fnb=
mjn9 gmail-f1o700av gmail-f13mvf36 gmail-f1cmlufx gmail-f9n3di6 gmail-f1ids=
18y gmail-f1tx3yz7 gmail-f1deo86v gmail-f1eh06m1 gmail-f1iescvh gmail-fhgqx=
19 gmail-f1olyrje gmail-f1p93eir gmail-f1nev41a gmail-f1h8hb77 gmail-f1lqvz=
6u gmail-f10aw75t gmail-fsle3fq gmail-f17ae5zn" title=3D"mailto:richard.hen=
derson@linaro.org"><span style=3D"background-color:rgb(229,241,143)">rich</=
span>ard.<span style=3D"background-color:rgb(229,241,143)">henderson</span>=
@linaro.org</a><br><div><br></div><div>Hi Richard, <br><br><br>I&#39;m an i=
ntern working with Joel Jones and he mentioned you&#39;ve worked quite a bi=
t on SME on QEMU. We were wondering if you could take a look at this patch =
as the deadline for the soft freeze is fast approaching and we&#39;d like i=
t to make it to the next release.<br><br><br><br>Thanks,<br><br>Vacha</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Tue, Jul 8, 2025 at 6:14=E2=80=AFPM Vacha Bhavsar =
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com">vacha.bhavsar@oss.qua=
lcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">The QEMU GDB stub does not expose the ZA storage SME register to=
 GDB via<br>
the remote serial protocol, which can be a useful functionality to debug SM=
E<br>
code. To provide this functionality in Aarch64 target, this patch registers=
 the<br>
SME register set with the GDB stub. To do so, this patch implements the<br>
aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to<br>
specify how to get and set the SME registers, and the<br>
arm_gen_dynamic_smereg_feature() function to generate the target<br>
description in XML format to indicate the target architecture supports SME.=
<br>
Finally, this patch includes a dyn_smereg_feature structure to hold this<br=
>
GDB XML description of the SME registers for each CPU.<br>
<br>
Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.qualco=
mm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0target/arm/gdbstub.c=C2=A0 =C2=A0|=C2=A0 =C2=A06 +++<br>
=C2=A0target/arm/gdbstub64.c | 119 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0target/arm/internals.h |=C2=A0 =C2=A03 ++<br>
=C2=A04 files changed, 129 insertions(+)<br>
<br>
diff --git a/target/arm/cpu.h b/target/arm/cpu.h<br>
index c8cf0ab417..c37ea7dcd2 100644<br>
--- a/target/arm/cpu.h<br>
+++ b/target/arm/cpu.h<br>
@@ -933,6 +933,7 @@ struct ArchCPU {<br>
<br>
=C2=A0 =C2=A0 =C2=A0DynamicGDBFeatureInfo dyn_sysreg_feature;<br>
=C2=A0 =C2=A0 =C2=A0DynamicGDBFeatureInfo dyn_svereg_feature;<br>
+=C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_smereg_feature;<br>
=C2=A0 =C2=A0 =C2=A0DynamicGDBFeatureInfo dyn_m_systemreg_feature;<br>
=C2=A0 =C2=A0 =C2=A0DynamicGDBFeatureInfo dyn_m_secextreg_feature;<br>
<br>
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c<br>
index ce4497ad7c..9c942c77cc 100644<br>
--- a/target/arm/gdbstub.c<br>
+++ b/target/arm/gdbstub.c<br>
@@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cp=
u)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GDBFeature *feature =3D arm=
_gen_dynamic_svereg_feature(cs, cs-&gt;gdb_num_regs);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_register_coprocessor(cs=
, aarch64_gdb_get_sve_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_gdb_set=
_sve_reg, feature, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isar_feature_aa64_sme(&amp;c=
pu-&gt;isar)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeature *sme_fe=
ature =3D arm_gen_dynamic_smereg_feature(cs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cs-&gt;gdb_num_regs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_copro=
cessor(cs, aarch64_gdb_get_sme_reg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aarc=
h64_gdb_set_sme_reg, sme_feature, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_register_coprocessor(cs=
, aarch64_gdb_get_fpu_reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_gdb_set=
_fpu_reg,<br>
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
index 64ee9b3b56..e2fc874b38 100644<br>
--- a/target/arm/gdbstub64.c<br>
+++ b/target/arm/gdbstub64.c<br>
@@ -228,6 +228,88 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf=
, int reg)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)<br>
+{<br>
+=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
+=C2=A0 =C2=A0 bool streaming_mode =3D ((env-&gt;svcr &amp; 0x01) !=3D 0);<=
br>
+<br>
+=C2=A0 =C2=A0 switch (reg) {<br>
+=C2=A0 =C2=A0 /* Svg register */<br>
+=C2=A0 =C2=A0 case 0:<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (streaming_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D sve_vqm1_for_el_sm(env, a=
rm_current_el(env),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0streaming_mode) + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* svg =3D vector granules (2 * vector quardwo=
rds) in streaming mode */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, vq * 2);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, env-&gt;svcr);<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int q;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sve_max_vq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (q =3D 0; q &lt; vq; q++) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_r=
eg128(buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;<a href=3D"http://za_state.za" rel=3D"noref=
errer" target=3D"_blank">za_state.za</a>[i].d[q * 2 + 1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;<a href=3D"http://za_state.za" rel=3D"noref=
errer" target=3D"_blank">za_state.za</a>[i].d[q * 2]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something out our range *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: out of rang=
e register %d&quot;, __func__, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)<br>
+{<br>
+=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
+=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 /* The first 32 registers are the zregs */<br>
+=C2=A0 =C2=A0 switch (reg) {<br>
+=C2=A0 =C2=A0 /* The first 32 registers are the zregs */<br>
+=C2=A0 =C2=A0 case 0:<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cannot set svg via gdbstub */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;svcr =3D *buf &amp; 0x03;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
+=C2=A0 =C2=A0 case 2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq, len =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D cpu-&gt;sve_max_vq * 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *p =3D (uint64_t *) buf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (vq =3D 0; vq &lt; cpu-&gt;s=
ve_max_vq; vq++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;<a href=3D=
"http://za_state.za" rel=3D"noreferrer" target=3D"_blank">za_state.za</a>[i=
].d[vq * 2 + 1] =3D *p++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;<a href=3D=
"http://za_state.za" rel=3D"noreferrer" target=3D"_blank">za_state.za</a>[i=
].d[vq * 2] =3D *p++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something out our range *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
=C2=A0int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(cs);<br>
@@ -392,6 +474,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *c=
s, int base_reg)<br>
=C2=A0 =C2=A0 =C2=A0return &amp;cpu-&gt;dyn_svereg_feature.desc;<br>
=C2=A0}<br>
<br>
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)<br>
+{<br>
+=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
+=C2=A0 =C2=A0 int vq =3D cpu-&gt;sve_max_vq;<br>
+=C2=A0 =C2=A0 int svl =3D vq * 16;<br>
+=C2=A0 =C2=A0 GDBFeatureBuilder builder;<br>
+=C2=A0 =C2=A0 int reg =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 gdb_feature_builder_init(&amp;builder, &amp;cpu-&gt;dyn_smer=
eg_feature.desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;org.gnu.gdb.aarch64.sme&quot;, &quot;sme=
-registers.xml&quot;, base_reg);<br>
+<br>
+<br>
+=C2=A0 =C2=A0 /* Create the sme_bv vector type. */<br>
+=C2=A0 =C2=A0 gdb_feature_builder_append_tag(&amp;builder,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;vector id=3D\&quot;sme_bv\&quot; typ=
e=3D\&quot;uint8\&quot; count=3D\&quot;%d\&quot;/&gt;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 svl);<br>
+<br>
+=C2=A0 =C2=A0 /* Create the sme_bvv vector type. */<br>
+=C2=A0 =C2=A0 gdb_feature_builder_append_tag(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;builder, &quot;&lt;vector id=3D\&quot;sme=
_bvv\&quot; type=3D\&quot;sme_bv\&quot; count=3D\&quot;%d\&quot;/&gt;&quot;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 svl);<br>
+<br>
+=C2=A0 =C2=A0 /* Define the svg, svcr, and za registers. */<br>
+<br>
+=C2=A0 =C2=A0 /* fpscr &amp; status registers */<br>
+=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;svg&quot;=
, 64, reg++,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
+=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;svcr&quot=
;, 64, reg++,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
+=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;za&quot;,=
 svl * svl * 8, reg++,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sme_bvv&quot;, NULL);<br>
+<br>
+=C2=A0 =C2=A0 gdb_feature_builder_end(&amp;builder);<br>
+<br>
+=C2=A0 =C2=A0 return &amp;cpu-&gt;dyn_smereg_feature.desc;<br>
+}<br>
+<br>
=C2=A0#ifdef CONFIG_USER_ONLY<br>
=C2=A0int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int re=
g)<br>
=C2=A0{<br>
diff --git a/target/arm/internals.h b/target/arm/internals.h<br>
index 21a8d67edd..af090b9b8e 100644<br>
--- a/target/arm/internals.h<br>
+++ b/target/arm/internals.h<br>
@@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_mask(CPUARMState =
*env)<br>
=C2=A0}<br>
<br>
=C2=A0GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_re=
g);<br>
+GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg);<b=
r>
=C2=A0int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);<=
br>
=C2=A0int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);<br>
+int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);<br>
+int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);<br>
=C2=A0int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);<=
br>
=C2=A0int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);<br>
=C2=A0int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)=
;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--00000000000038a5700639abb1c5--

