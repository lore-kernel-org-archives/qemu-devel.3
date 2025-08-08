Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AAFC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNYK-0007tw-UR; Fri, 08 Aug 2025 09:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ukNYI-0007ob-4v
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:54:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ukNYE-0002zh-M0
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:54:33 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786pSQA003563
 for <qemu-devel@nongnu.org>; Fri, 8 Aug 2025 13:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=H9wWSqX/luoqrKFofvXteEVM
 3UM+iAmfbFnx7+Nfv+4=; b=AcRhVaT8aeabnnayjjDb/8WcC9KCX+aHfDOzQqWf
 O/DIrE8dqTfuqIl9I4WfvILP0NyRh8w2hT3co+TuQSgFwGCeaikz84nsUrYzWigu
 Xw/WU0toV6y18U4JaZ98BUbR1m8kf9zrgeviY9hIYTZBf5sMNq7/aOd/wScQxwxt
 Tt72vicJhgjAUNdhPUvg4nftW2CefJOKMVIRp6Mj31YBxZ8JeKuQSOVcdaVZfcY6
 9m9DHGcJ78SPBA0FGJnrBGabcK1MAO8Xk8QOxAW1fxgVQrR2U5LX9FTsxdkwzx0y
 M3aOTZvTKoTPnyUUvNl79qyBCzvhfL5zZi+EHCUiUL4WQw==
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw02deq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:54:27 +0000 (GMT)
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e8e28e1d66cso2436206276.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 06:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661266; x=1755266066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H9wWSqX/luoqrKFofvXteEVM3UM+iAmfbFnx7+Nfv+4=;
 b=XKfPWMqEqR19vY+1Q0M+h59OPEOS8B8c09qgd3bYPY4RC2g/8tl6g1r28zvbW3VEer
 DCRVXJJPbfx/KnsNBhSjypLD/2rMxsTs/kHLCQ2S4AGVb31UQuBaY+riEv6h/T5nPhMi
 sBqzFNdlHyb0zV+WPj32ciwn71NvU2XA3bdcotM72ymtH/7jvF8B5c7xumQcKmVOijfi
 bE9cxmMXmQ1kZbYbyuRq18vGrU+JrKYOD4nS+B//OXRssMc/5w2my29KopLl3ubcWwb/
 rMzU/EDF5THSyWftWMgce+GBQwaD97fNYlSuC+pRbsB+TeuXrrwoQDuVgZXSUpoDnZSY
 NUTQ==
X-Gm-Message-State: AOJu0YxRIkfzVTfS/6JVle8XVMJ5QRhyOee8EgCRmznTXYYVL/Q8fVor
 t8ahfgxfv7UE/0262cFt68Fx+0e7c5pi9gY8LAPMReOQxcIZTrbyEaJ5NrJy7T2Y5nE6Am2B/6v
 aLJZI3BxYb2t555wubegcTfuexGa53XJJOH+4iCKY/+fQA/M20mf9gg6oLFMnDkTTlB0nU8aGLi
 TRzy/UH3CSUJkKBEUa4FY6EqroUOlCe9W0
X-Gm-Gg: ASbGncut6xaFirIM8dULafUvCncPeoJ/jrdp2w9NTuIJuTvE1GF+mjIOG1byPIMK1xg
 ZkAueBnaLw4dcQu5ML/nE6jV9nf5ug9Cj9Q7cXHeYTG2x3PINhfO6LnrByEZ9zu/ta4b7ip6pTj
 PNcIimlBOnh96BskIJi9Ov/A8=
X-Received: by 2002:a05:6902:4a02:b0:e8e:2535:5cb with SMTP id
 3f1490d57ef6-e904b65835dmr3159115276.35.1754661266272; 
 Fri, 08 Aug 2025 06:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsL+mBUKiQGNVU1MqzEIjR0w1NowRdd59zdF+TooPIBToAezYE3OVaPcHYXsqT7NnlLjGJHDEjXWGR1hYpoc0=
X-Received: by 2002:a05:6902:4a02:b0:e8e:2535:5cb with SMTP id
 3f1490d57ef6-e904b65835dmr3159093276.35.1754661265806; Fri, 08 Aug 2025
 06:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-3-vacha.bhavsar@oss.qualcomm.com>
 <87zfcf5cco.fsf@draig.linaro.org>
In-Reply-To: <87zfcf5cco.fsf@draig.linaro.org>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 09:54:12 -0400
X-Gm-Features: Ac12FXxyEelhQb8WBU7bYLFr0wHaf2SArySnUNLZ2fy5MMXeU4H2DFVjw1GqeI4
Message-ID: <CAEWVDmstkUnsLbj-h2g9p5ajUSuc9UZXngqFOj-xgoJO2PsWiw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: Added support for SME register
 exposure to GDB
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007329cd063bdae9ac"
X-Proofpoint-GUID: qmRHaFEUhd-k1HmoWOWG9JfZe8mInji8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX5mEOSrS35XRn
 Yi8gHbXQEKgDVnLSqC4zpByCUeFI82jZn2Mknnf/413vFfrHSa7NPfVbANCxa2w9uhtvKvNd06K
 anIRUWyOW/1RaIZH7lx9eY1mwBkqGf5apDzNyJVTVNdUa/5/aLAqixHlX1vjnXrE+SZLZZgEH+y
 HmD3dRZMW/U5aJXbvRBewKrqsGmGrbWRe0wQVkWioObvB81YhVSbwInQOWnlL2FmZbw47Bw33i0
 4AlsyoO3qWL/wHsdY424NB7G0sx/2ZzppkL/xglfV04w1C0lQifd9Jq/ZKb9u9+6rwuzTNLjWqc
 Cy1KF/FHGsRsDsyOgWRFu2PDS/JLmmpguWOjTCEahCuXK8jJq3rwI7R5CExjNg03sw9/phix4+h
 U+iNrrGT
X-Proofpoint-ORIG-GUID: qmRHaFEUhd-k1HmoWOWG9JfZe8mInji8
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=68960193 cx=c_pps
 a=5rZgxjGdQ1phXw1xqkF1vg==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=QvEvhmk7fBozSgZ7fXIA:9 a=QEXdDO2ut3YA:10 a=HjjZBBvkAAAA:8
 a=i978kb17l3nJUjtsbvUA:9 a=yYcQb6dw__GsTWMl:21 a=lqcHg5cX4UMA:10
 a=FvMT9AR2qkiEEVpopuB7:22 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007329cd063bdae9ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,



I've built a testcase for this similar to the one you suggested. This test

checks both reading and writing the za register via $za and via the tiles

and tiles slices that gdb produces (i.e., za0hb0). However, these tiles and

slices are generated from the gdb side, they're not made available by any

of the changes that I have implemented. But this feature of gdb's kicks in

when using gdb14.1 or newer. Due to this, the testcase works correctly when

used with gdb14.1 and above, and fails on any gdb version older than that

as the tiles/slices are not made available by gdb.



I was wondering if there is any way to set a requirement on this testcase

which specifies it needs to be run with minimum of gdb version 14.1

which has the functionality to break down the ZA storage into tiles and

slices?





Thanks,

Vacha

On Mon, Aug 4, 2025 at 11:35=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
>
> > The QEMU GDB stub does not expose the ZA storage SME register to GDB vi=
a
> > the remote serial protocol, which can be a useful functionality to debu=
g
> SME
> > code. To provide this functionality in Aarch64 target, this patch
> registers the
> > SME register set with the GDB stub. To do so, this patch implements the
> > aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> > specify how to get and set the SME registers, and the
> > arm_gen_dynamic_smereg_feature() function to generate the target
> > description in XML format to indicate the target architecture supports
> SME.
> > Finally, this patch includes a dyn_smereg_feature structure to hold thi=
s
> > GDB XML description of the SME registers for each CPU.
> >
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > ---
> > Changes since v3:
> > - added changes to aarch64_gdb_set_sme_reg() to address the concerns
> > brought up in review regarding endianness
> >
> >  target/arm/cpu.h       |   1 +
> >  target/arm/gdbstub.c   |   6 ++
> >  target/arm/gdbstub64.c | 122 +++++++++++++++++++++++++++++++++++++++++
> >  target/arm/internals.h |   3 +
> >  4 files changed, 132 insertions(+)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index dc9b6dce4c..8bd66d7049 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -933,6 +933,7 @@ struct ArchCPU {
> >
> >      DynamicGDBFeatureInfo dyn_sysreg_feature;
> >      DynamicGDBFeatureInfo dyn_svereg_feature;
> > +    DynamicGDBFeatureInfo dyn_smereg_feature;
> >      DynamicGDBFeatureInfo dyn_m_systemreg_feature;
> >      DynamicGDBFeatureInfo dyn_m_secextreg_feature;
> >
> > diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> > index ce4497ad7c..9c942c77cc 100644
> > --- a/target/arm/gdbstub.c
> > +++ b/target/arm/gdbstub.c
> > @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU
> *cpu)
> >              GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs,
> cs->gdb_num_regs);
> >              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
> >                                       aarch64_gdb_set_sve_reg, feature,
> 0);
> > +            if (isar_feature_aa64_sme(&cpu->isar)) {
> > +                GDBFeature *sme_feature =3D
> arm_gen_dynamic_smereg_feature(cs,
> > +                                             cs->gdb_num_regs);
> > +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> > +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
> > +            }
> >          } else {
> >              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
> >                                       aarch64_gdb_set_fpu_reg,
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 64ee9b3b56..3d86980bc9 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t
> *buf, int reg)
> >      return 0;
> >  }
> >
> > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    CPUARMState *env =3D &cpu->env;
> > +
> > +    switch (reg) {
> > +    /* Svg register */
> > +    case 0:
> > +    {
> > +        int vq =3D 0;
> > +        if (FIELD_EX64(env->svcr, SVCR, SM)) {
> > +            vq =3D sve_vqm1_for_el_sm(env, arm_current_el(env),
> > +                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
> > +        }
> > +        /* svg =3D vector granules (2 * vector quardwords) in streamin=
g
> mode */
> > +        return gdb_get_reg64(buf, vq * 2);
> > +    }
> > +    case 1:
> > +        return gdb_get_reg64(buf, env->svcr);
> > +    case 2:
> > +    {
> > +        int len =3D 0;
> > +        int vq =3D cpu->sme_max_vq;
> > +        int svl =3D vq * 16;
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (int q =3D 0; q < vq; q++) {
> > +                len +=3D gdb_get_reg128(buf,
> > +                           env->za_state.za[i].d[q * 2 + 1],
> > +                           env->za_state.za[i].d[q * 2]);
> > +            }
> > +        }
> > +        return len;
> > +    }
> > +    default:
> > +        /* gdbstub asked for something out of range */
> > +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d",
> __func__, reg);
> > +        break;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    CPUARMState *env =3D &cpu->env;
> > +
> > +    switch (reg) {
> > +    case 0:
> > +    {
> > +        /* cannot set svg via gdbstub */
> > +        return 8;
> > +    }
> > +    case 1:
> > +        aarch64_set_svcr(env, ldq_le_p(buf),
> > +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> > +        return 8;
> > +    case 2:
> > +        int len =3D 0;
> > +        int vq =3D cpu->sme_max_vq;
> > +        int svl =3D vq * 16;
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (int q =3D 0; q < vq; q++) {
> > +                if (target_big_endian()){
> > +                    env->za_state.za[i].d[q * 2 + 1] =3D ldq_p(buf);
> > +                    buf +=3D 8;
> > +                    env->za_state.za[i].d[q * 2] =3D ldq_p(buf);
> > +                } else{
> > +                    env->za_state.za[i].d[q * 2] =3D ldq_p(buf);
> > +                    buf +=3D 8;
> > +                    env->za_state.za[i].d[q * 2 + 1] =3D ldq_p(buf);
> > +                }
> > +                buf +=3D 8;
> > +                len +=3D 16;
> > +            }
> > +        }
> > +        return len;
> > +    default:
> > +        /* gdbstub asked for something out of range */
> > +        break;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
> >  {
> >      ARMCPU *cpu =3D ARM_CPU(cs);
> > @@ -392,6 +477,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUStat=
e
> *cs, int base_reg)
> >      return &cpu->dyn_svereg_feature.desc;
> >  }
> >
> > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    int vq =3D cpu->sme_max_vq;
> > +    int svl =3D vq * 16;
> > +    GDBFeatureBuilder builder;
> > +    int reg =3D 0;
> > +
> > +    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.desc,
> > +        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
> > +
> > +
> > +    /* Create the sme_bv vector type. */
> > +    gdb_feature_builder_append_tag(&builder,
> > +        "<vector id=3D\"sme_bv\" type=3D\"uint8\" count=3D\"%d\"/>",
> > +        svl);
> > +
> > +    /* Create the sme_bvv vector type. */
> > +    gdb_feature_builder_append_tag(
> > +        &builder, "<vector id=3D\"sme_bvv\" type=3D\"sme_bv\"
> count=3D\"%d\"/>",
> > +        svl);
> > +
> > +    /* Define the svg, svcr, and za registers. */
> > +
> > +    /* fpscr & status registers */
> > +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
> > +        "int", NULL);
> > +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
> > +        "int", NULL);
> > +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg+=
+,
> > +        "sme_bvv", NULL);
> > +
> > +    gdb_feature_builder_end(&builder);
> > +
> > +    return &cpu->dyn_smereg_feature.desc;
> > +}
> > +
> >  #ifdef CONFIG_USER_ONLY
> >  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg=
)
> >  {
> > diff --git a/target/arm/internals.h b/target/arm/internals.h
> > index c4765e4489..760e1c6490 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -1808,8 +1808,11 @@ static inline uint64_t
> pmu_counter_mask(CPUARMState *env)
> >  }
> >
> >  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg=
);
> > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_reg=
);
> >  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
> >  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
> > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);
> > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
> >  int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
> >  int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
> >  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
>
> It would also be nice to add a test for this, see
> tests/tcg/aarch64/gdbstub/test-sve.py
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--0000000000007329cd063bdae9ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>Hi,</p><p>=C2=A0</p><p>I&#39;ve built =
a testcase for this similar to the one you suggested. This test=C2=A0</p><p=
>checks both reading and writing the za register via $za and via the tiles<=
/p><p>and tiles slices that gdb produces (i.e., za0hb0). However, these til=
es and=C2=A0</p><p>slices are generated from the gdb side, they&#39;re not =
made available=C2=A0by any</p><p>of the changes that I have implemented. Bu=
t this feature of gdb&#39;s kicks in</p><p>when using gdb14.1 or newer. Due=
 to this, the testcase works correctly when</p><p>used with gdb14.1 and abo=
ve, and fails on any gdb version older than that</p><p>as the tiles/slices =
are not made available by gdb.</p><p>=C2=A0</p><p>I was wondering if there =
is any way to set a requirement=C2=A0on this testcase</p><p>which specifies=
 it needs to be run with minimum of gdb version 14.1</p><p>which has the fu=
nctionality to break down the ZA storage=C2=A0into tiles and=C2=A0</p><p>sl=
ices?</p><p>=C2=A0</p><p>=C2=A0</p><p>Thanks,</p><p>Vacha</p></div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 4,=
 2025 at 11:35=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.benne=
e@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Vacha Bhavsar &lt;<a =
href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vacha.bhav=
sar@oss.qualcomm.com</a>&gt; writes:<br>
<br>
&gt; The QEMU GDB stub does not expose the ZA storage SME register to GDB v=
ia<br>
&gt; the remote serial protocol, which can be a useful functionality to deb=
ug SME<br>
&gt; code. To provide this functionality in Aarch64 target, this patch regi=
sters the<br>
&gt; SME register set with the GDB stub. To do so, this patch implements th=
e<br>
&gt; aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to<b=
r>
&gt; specify how to get and set the SME registers, and the<br>
&gt; arm_gen_dynamic_smereg_feature() function to generate the target<br>
&gt; description in XML format to indicate the target architecture supports=
 SME.<br>
&gt; Finally, this patch includes a dyn_smereg_feature structure to hold th=
is<br>
&gt; GDB XML description of the SME registers for each CPU.<br>
&gt;<br>
&gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.q=
ualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes since v3:<br>
&gt; - added changes to aarch64_gdb_set_sme_reg() to address the concerns <=
br>
&gt; brought up in review regarding endianness<br>
&gt;<br>
&gt;=C2=A0 target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 target/arm/gdbstub.c=C2=A0 =C2=A0|=C2=A0 =C2=A06 ++<br>
&gt;=C2=A0 target/arm/gdbstub64.c | 122 +++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 target/arm/internals.h |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 4 files changed, 132 insertions(+)<br>
&gt;<br>
&gt; diff --git a/target/arm/cpu.h b/target/arm/cpu.h<br>
&gt; index dc9b6dce4c..8bd66d7049 100644<br>
&gt; --- a/target/arm/cpu.h<br>
&gt; +++ b/target/arm/cpu.h<br>
&gt; @@ -933,6 +933,7 @@ struct ArchCPU {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_sysreg_feature;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_svereg_feature;<br>
&gt; +=C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_smereg_feature;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_m_systemreg_feature;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_m_secextreg_feature;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c<br>
&gt; index ce4497ad7c..9c942c77cc 100644<br>
&gt; --- a/target/arm/gdbstub.c<br>
&gt; +++ b/target/arm/gdbstub.c<br>
&gt; @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_features(ARMCP=
U *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeature *feature =
=3D arm_gen_dynamic_svereg_feature(cs, cs-&gt;gdb_num_regs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocess=
or(cs, aarch64_gdb_get_sve_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aarch6=
4_gdb_set_sve_reg, feature, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isar_feature_aa64_sme(&=
amp;cpu-&gt;isar)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeature *s=
me_feature =3D arm_gen_dynamic_smereg_feature(cs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0cs-&gt;gdb_num_regs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_=
coprocessor(cs, aarch64_gdb_get_sme_reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 aarch64_gdb_set_sme_reg, sme_feature, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocess=
or(cs, aarch64_gdb_get_fpu_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aarch6=
4_gdb_set_fpu_reg,<br>
&gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
&gt; index 64ee9b3b56..3d86980bc9 100644<br>
&gt; --- a/target/arm/gdbstub64.c<br>
&gt; +++ b/target/arm/gdbstub64.c<br>
&gt; @@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t=
 *buf, int reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 /* Svg register */<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FIELD_EX64(env-&gt;svcr, SVCR, SM)) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D sve_vqm1_for_el_sm(e=
nv, arm_current_el(env),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0FIELD_EX64(env-&gt;svcr, SVCR, SM)) + 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* svg =3D vector granules (2 * vector qu=
ardwords) in streaming mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, vq * 2);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, env-&gt;svcr);<=
br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int q =3D 0; q &lt; vq=
; q++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_=
get_reg128(buf,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;<a href=3D"http://za_state.za" rel=3D"n=
oreferrer" target=3D"_blank">za_state.za</a>[i].d[q * 2 + 1],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;<a href=3D"http://za_state.za" rel=3D"n=
oreferrer" target=3D"_blank">za_state.za</a>[i].d[q * 2]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something out of ran=
ge */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot;%s: out of=
 range register %d&quot;, __func__, reg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cannot set svg via gdbstub */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_set_svcr(env, ldq_le_p(buf),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_SVCR_SM_MASK | R_SVCR_ZA_=
MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int q =3D 0; q &lt; vq=
; q++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_bi=
g_endian()){<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank=
">za_state.za</a>[i].d[q * 2 + 1] =3D ldq_p(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 buf +=3D 8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank=
">za_state.za</a>[i].d[q * 2] =3D ldq_p(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank=
">za_state.za</a>[i].d[q * 2] =3D ldq_p(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 buf +=3D 8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank=
">za_state.za</a>[i].d[q * 2 + 1] =3D ldq_p(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf +=3D 8;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D 16;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something out of ran=
ge */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int=
 reg)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; @@ -392,6 +477,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUSta=
te *cs, int base_reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return &amp;cpu-&gt;dyn_svereg_feature.desc;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;<br>
&gt; +=C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt; +=C2=A0 =C2=A0 GDBFeatureBuilder builder;<br>
&gt; +=C2=A0 =C2=A0 int reg =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_init(&amp;builder, &amp;cpu-&gt;dyn=
_smereg_feature.desc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;org.gnu.gdb.aarch64.sme&quot;, &quo=
t;sme-registers.xml&quot;, base_reg);<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Create the sme_bv vector type. */<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_tag(&amp;builder,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;vector id=3D\&quot;sme_bv\&quot=
; type=3D\&quot;uint8\&quot; count=3D\&quot;%d\&quot;/&gt;&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 svl);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Create the sme_bvv vector type. */<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_tag(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;builder, &quot;&lt;vector id=3D\&quo=
t;sme_bvv\&quot; type=3D\&quot;sme_bv\&quot; count=3D\&quot;%d\&quot;/&gt;&=
quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 svl);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Define the svg, svcr, and za registers. */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* fpscr &amp; status registers */<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;svg&=
quot;, 64, reg++,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;svcr=
&quot;, 64, reg++,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;za&q=
uot;, svl * svl * 8, reg++,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sme_bvv&quot;, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_end(&amp;builder);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return &amp;cpu-&gt;dyn_smereg_feature.desc;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 #ifdef CONFIG_USER_ONLY<br>
&gt;=C2=A0 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, i=
nt reg)<br>
&gt;=C2=A0 {<br>
&gt; diff --git a/target/arm/internals.h b/target/arm/internals.h<br>
&gt; index c4765e4489..760e1c6490 100644<br>
&gt; --- a/target/arm/internals.h<br>
&gt; +++ b/target/arm/internals.h<br>
&gt; @@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_mask(CPUARMS=
tate *env)<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int ba=
se_reg);<br>
&gt; +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int base_re=
g);<br>
&gt;=C2=A0 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int r=
eg);<br>
&gt;=C2=A0 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)=
;<br>
&gt; +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg);<=
br>
&gt; +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);<br>
&gt;=C2=A0 int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int r=
eg);<br>
&gt;=C2=A0 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)=
;<br>
&gt;=C2=A0 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int=
 reg);<br>
<br>
It would also be nice to add a test for this, see tests/tcg/aarch64/gdbstub=
/test-sve.py<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>
</div>

--0000000000007329cd063bdae9ac--

