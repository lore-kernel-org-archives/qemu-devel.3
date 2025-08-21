Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC66CA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 21:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upCyt-0004zb-T8; Thu, 21 Aug 2025 17:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1upCyp-0004zC-Ag
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 17:37:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1upCyk-0006Jv-89
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 17:37:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9rS6027506
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 21:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nN4hZfahsQpOmSKl25kFrVwz
 Vn/oYWsqJ4hBVou17l0=; b=awljNtUXOIN3gkhjsdf0A7fx+MU9C1/vlcN31HPC
 9JqReFoYaNiGogtMzwuyyT26K5gq1p2UKm/7ZV5DPNMvC51WO7tbCTdzp/A9RFqx
 xrNQD0wa9mGGHnJ9XpyBmaDb9Wd1h/x2VS1fEROtyhE17FZF+cXRWD5nS9GwrxsT
 HZWxJSc3r6jHWw6/mFfsOxpPD9Mw9lVZ6x3Q86V2xuFts9E4J7Db4rCAGKTc3sKQ
 Hcm8E4ov8B+kWCdOtceJAEy+26eNfe7Y0n+aroadwcOXB+4vzd/6ONs7HvGKTcq5
 KYvchGwGXC8OMChChRaoX4A7ZnVExL5HNboCOR1K4vUQJw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528xwpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 21:37:45 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71d603c7e05so22373297b3.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 14:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755812265; x=1756417065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nN4hZfahsQpOmSKl25kFrVwzVn/oYWsqJ4hBVou17l0=;
 b=Qw9axB8EIXCIIu8rdM2rXB6AbWKXVXPmT1IVARNuMg+WKdxvfIGvJih85wiOBV8owj
 612Kp7dVGxwsKAK5BEoXvt5/JJKr6o7xc6/Umdm2DJcWZN5VBZpl8WeUch7YjtslbC5X
 5l4DPZDgFiQwo4w7Giq/M89IzFzd2nybtDiaX13SS6vPQLfYstQkJVvgW7MjjJzt1AlH
 r3xUQOhbb6zET6FGIiK8HWzAxUj8qXRiVC6GsHSZN0Jb2oGTGJBSqmiNOeGt6J+2WhLL
 PWmhYHSvu3iGF++TRrdpcJjmaAd10k7ShrGWZLE3qH7nPv6Rm34AkPVUU7tfXUqVwr9n
 VxRQ==
X-Gm-Message-State: AOJu0Yw+ONvEfPqDDEzo4zCMv6bFmV27wxLinjFfSL0Ems7J2SppyhF+
 4nG0zyjE5Fkv+GQm7dR5CZ3mUE1dQb28HK29ouCSmTGPJwdLluotZ5Ddm1UWLIy8ynMzu9x+bxv
 1XcL0oMrHKBuQlZ5SFWPUfbe2MCegmNftU4zWwM4bNOm3nyAPh2aw/vsVW8kyc+gsKt4YJ5rWGQ
 uaaLDi4WJd1IulMXugOJ9zZcDof/foRWG+
X-Gm-Gg: ASbGncuKNyRYRZ2XfSXsh7f+vJDc12sslDh7L1oGyivIAhmYzSTtjmt3q89HY5I6IC3
 ESB4yAAgBqtuOeUoxy3ZsizbciOSCdOBQagbwrhsM6/BFdeizwS8CKsBvRH/3gR0i6HYv99i6KY
 MLiFr85stsTvTeH/ZsFZuq5g==
X-Received: by 2002:a05:690c:7281:b0:70e:142d:9c6e with SMTP id
 00721157ae682-71fdc3cce2amr7311667b3.32.1755812265018; 
 Thu, 21 Aug 2025 14:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRVNevmC+ALFFmCT7keWlAGq8saSnB0xbwyeSlQtpoIEXMkrFH8GQUEmrq4njuuSf6GOmoSjwZjBqmEpSXJUw=
X-Received: by 2002:a05:690c:7281:b0:70e:142d:9c6e with SMTP id
 00721157ae682-71fdc3cce2amr7311487b3.32.1755812264495; Thu, 21 Aug 2025
 14:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-4-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9wQ8qh3Ah+QNNXY6u8ut6ZMVqaxFTvDDhvEGYrazFPsA@mail.gmail.com>
In-Reply-To: <CAFEAcA9wQ8qh3Ah+QNNXY6u8ut6ZMVqaxFTvDDhvEGYrazFPsA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 17:37:32 -0400
X-Gm-Features: Ac12FXw7fBJeieE33sweJweuAAJHYYdIsMw7XUQPm19rABSgthLGm1GeZVCWbjU
Message-ID: <CAEWVDmuAkDuss-vB35dOPP-zSOZTEK4WJGfvqLQdHNG-63h51Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] target/arm: Added support for SME register
 exposure to
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000515cca063ce6e62f"
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a791a9 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=YFUzINo2eA8ZkCG2kdAA:9 a=QEXdDO2ut3YA:10 a=HjjZBBvkAAAA:8
 a=DXZ8xA8blhKRNg8T7WgA:9 a=vTWwjHaQI2JXcwem:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: B4eCd2Wt0GD4m51q0ESYd42pNTmolFqM
X-Proofpoint-ORIG-GUID: B4eCd2Wt0GD4m51q0ESYd42pNTmolFqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4gC7AjxtARd0
 A7XdWTXQ8LISP/tb8IQkXG7tZAWgFkTueE0VIQLer+lMIkvRKytdXfP9Ub1R1IBl9o5soZxF+Yt
 41LJYKPSWIXT7gK/yUkmE9wY98mfGs+o6SRxzXxvdvfyOyGSTYA29qlZBEIjcW5JLHxXSQRYSlo
 bN9O38tlgTjUcfB6bcSU93S5z6iEC5uLJfd1iR1I5Tv012oQnFjUtqxx5VXgp8faZ7aptC2gASK
 J9OxnYBCUC0/sxZV+2shBA2/PvgILhrarKu0+jRxsJNLb7LQoPtUJJ/5OH2pYtYkKak9eVVp1eh
 A9OXuHbw2aWCov6kycWoVmCS7EQBihy8k2oTqppFn9sxbvn/LL4USMh2d7nsvcMdbHmal6l+XIQ
 ZBbbLTjQH0IflUaXmRloKbWq24MqCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000515cca063ce6e62f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Regarding having the SME check inside the "if we have SVE" check, we were
looking the the
Arm ARM, specifically the following excerpt from section A1.4:

The architecture provides the following:

- A general-purpose register file.
- A SIMD&FP register file.
- If FEAT_SVE or FEAT_SME is implemented, an SVE scalable vector register
file and an
SVE scalable predicate register file.
- if FEAT_SME is implemented, the scalable ZA storage.

Based on this, we were considering the following update to the change in
gdbstub64.c and
we wanted to get your input.

if (isar_feature_aa64_sve(&cpu->isar) || isar_feature_aa64_sme(&cpu->isar))
{
            GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs,
cs->gdb_num_regs);
            gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
                                     aarch64_gdb_set_sve_reg, feature, 0);
} else {
            gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
                                     aarch64_gdb_set_fpu_reg,

 gdb_find_static_feature("aarch64-fpu.xml"),
                                     0);
}

if (isar_feature_aa64_sme(&cpu->isar)) {
              GDBFeature *sme_feature =3D arm_gen_dynamic_smereg_feature(cs=
,
                    cs->gdb_num_regs);
              gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
                    aarch64_gdb_set_sme_reg, sme_feature, 0);
}

Thanks,
Vacha



On Tue, Aug 19, 2025 at 5:05=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Mon, 11 Aug 2025 at 20:37, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
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
> > index ce4497ad7c..4371a367a0 100644
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
> > +                    cs->gdb_num_regs);
> > +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> > +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
> > +            }
>
> It's possible to have SME without SVE, so this should not be
> inside the "if we have SVE" check.
>
> >          } else {
> >              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
> >                                       aarch64_gdb_set_fpu_reg,
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 08e2858539..047b1f8133 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -249,6 +249,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t
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
>
> We should comment what all the cases here are; the usual ploce to
> put such a comment is either on the same line as the case, or else
> on the line immediately after the case if the comment would be
> too long to put on the same line.
>
> The capitalization here is odd, too: the register is either "SVG" or "svg=
".
>
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
>
> You don't need braces here, because there are no local variables
> in this arm of the switch statement.
>
> > +    case 1:
> > +        aarch64_set_svcr(env, ldq_le_p(buf),
> > +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> > +        return 8;
> > +    case 2:
> > +        int len =3D 0;
> > +        int vq =3D cpu->sme_max_vq;
> > +        int svl =3D vq * 16;
>
> But you do need braces here, because there are local variables.
> This is (a) because our coding style requires that declarations
> go at the top of a block and (b) because clang will complain:
>
> ../../target/arm/gdbstub64.c:310:9: error: label followed by a
> declaration is a C23 extension [-Werror,-Wc23-extensions]
>   310 |         int len =3D 0;
>       |         ^
>
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (int q =3D 0; q < vq; q++) {
> > +                if (target_big_endian()){
>
> Missing space before the {
>
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
> > @@ -413,6 +498,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUStat=
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
> > index 1b3d0244fd..41e05066b9 100644
> > --- a/target/arm/internals.h
> > +++ b/target/arm/internals.h
> > @@ -1802,8 +1802,11 @@ static inline uint64_t
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
> > --
>
> thanks
> -- PMM
>

--000000000000515cca063ce6e62f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Regarding having the SME=C2=A0check=
 inside the &quot;if we have SVE&quot; check, we were looking the the=C2=A0=
</div><div>Arm ARM, specifically the following excerpt from section A1.4:<b=
r><br>The architecture provides the following:</div><div><br></div><div>- A=
 general-purpose register file.</div><div>- A SIMD&amp;FP register file.</d=
iv><div>- If FEAT_SVE or FEAT_SME is implemented, an SVE scalable vector re=
gister file and an=C2=A0</div><div>SVE scalable predicate register file.</d=
iv><div>- if FEAT_SME is implemented, the scalable ZA storage.</div><div><b=
r></div><div>Based on this, we were considering the following update to the=
 change in gdbstub64.c and=C2=A0</div><div>we wanted to get your input.<br>=
<br>if (isar_feature_aa64_sve(&amp;cpu-&gt;isar) || isar_feature_aa64_sme(&=
amp;cpu-&gt;isar)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeatur=
e *feature =3D arm_gen_dynamic_svereg_feature(cs, cs-&gt;gdb_num_regs);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocessor(cs, aarc=
h64_gdb_get_sve_reg,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0aarch64_gdb_set_sve_reg, feature, 0);</div><div>} else {<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocessor(cs, aarch64=
_gdb_get_fpu_reg,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0aarch64_gdb_set_fpu_reg,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0gdb_find_static_feature(&quot;aarch64-fpu.xml&quot;),<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br>}<br><br>=
if (isar_feature_aa64_sme(&amp;cpu-&gt;isar)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 GDBFeature *sme_feature =3D arm_gen_dynamic_s=
mereg_feature(cs,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 cs-&gt;gdb_num_regs);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0=C2=A0 gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
aarch64_gdb_set_sme_reg, sme_feature, 0);<br>}</div><div><br></div><div>Tha=
nks,</div><div>Vacha<br><br><br></div></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 19,=
 2025 at 5:05=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Mon, 11 Aug 2025 at 20:37, Vacha Bha=
vsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
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
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_sysreg_feature;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_svereg_feature;<br>
&gt; +=C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_smereg_feature;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_m_systemreg_feature;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_m_secextreg_feature;<br>
&gt;<br>
&gt; diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c<br>
&gt; index ce4497ad7c..4371a367a0 100644<br>
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
 cs-&gt;gdb_num_regs);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_=
coprocessor(cs, aarch64_gdb_get_sme_reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 aarch64_gdb_set_sme_reg, sme_feature, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
It&#39;s possible to have SME without SVE, so this should not be<br>
inside the &quot;if we have SVE&quot; check.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocess=
or(cs, aarch64_gdb_get_fpu_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aarch6=
4_gdb_set_fpu_reg,<br>
&gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
&gt; index 08e2858539..047b1f8133 100644<br>
&gt; --- a/target/arm/gdbstub64.c<br>
&gt; +++ b/target/arm/gdbstub64.c<br>
&gt; @@ -249,6 +249,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t=
 *buf, int reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 /* Svg register */<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
<br>
We should comment what all the cases here are; the usual ploce to<br>
put such a comment is either on the same line as the case, or else<br>
on the line immediately after the case if the comment would be<br>
too long to put on the same line.<br>
<br>
The capitalization here is odd, too: the register is either &quot;SVG&quot;=
 or &quot;svg&quot;.<br>
<br>
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
<br>
You don&#39;t need braces here, because there are no local variables<br>
in this arm of the switch statement.<br>
<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_set_svcr(env, ldq_le_p(buf),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_SVCR_SM_MASK | R_SVCR_ZA_=
MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
<br>
But you do need braces here, because there are local variables.<br>
This is (a) because our coding style requires that declarations<br>
go at the top of a block and (b) because clang will complain:<br>
<br>
../../target/arm/gdbstub64.c:310:9: error: label followed by a<br>
declaration is a C23 extension [-Werror,-Wc23-extensions]<br>
=C2=A0 310 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int len =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int q =3D 0; q &lt; vq=
; q++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_bi=
g_endian()){<br>
<br>
Missing space before the {<br>
<br>
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
&gt; @@ -413,6 +498,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUSta=
te *cs, int base_reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return &amp;cpu-&gt;dyn_svereg_feature.desc;<br>
&gt;=C2=A0 }<br>
&gt;<br>
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
&gt; index 1b3d0244fd..41e05066b9 100644<br>
&gt; --- a/target/arm/internals.h<br>
&gt; +++ b/target/arm/internals.h<br>
&gt; @@ -1802,8 +1802,11 @@ static inline uint64_t pmu_counter_mask(CPUARMS=
tate *env)<br>
&gt;=C2=A0 }<br>
&gt;<br>
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
&gt; --<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000515cca063ce6e62f--

