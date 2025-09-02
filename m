Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0EDCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utVBn-0000Yn-Oe; Tue, 02 Sep 2025 13:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1utVBc-0000UW-Kh
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:52:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1utVBY-0002ob-AU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:52:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqCLa010163
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 17:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MQQITzu+SmTy2msogTUYPvi5
 ItpgAPJEx+UJU5UFZHE=; b=kT0/scHHdIYehDHD3HCkM649a/dqp5elyniVcymP
 tG/GBETqmkNYh69pXz2oGDfreC1EXbOTdyzoVKAeS4gt/43qqfunzzcDUWSEmoOL
 FKbQrrDNxFDxImuSmqV3OjBd7cQKJBfQciqOaXSbtSmhSDDaOLFTPKZDnlfB0bRG
 9ZfFC3NF3nLQBGmOR+pBxmBfMpg/P3NYRnNb17wbeU0+rDgGGZCKFxjxV/82MQYj
 2I+iYpfKnSaBT3X4o3hNFXzGJo0gkzyw+GTED+Cnk+pXJnsOWnfcXRGOqdmFvvfz
 H8vo8xlkLq811s7RdmHJft3QQxAFpkRC/sS562pGqfkY2w==
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0egwra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 17:52:44 +0000 (GMT)
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e96e02b1c8dso6863486276.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 10:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756835563; x=1757440363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MQQITzu+SmTy2msogTUYPvi5ItpgAPJEx+UJU5UFZHE=;
 b=i8QftbzScuqVuB/P85X9vxVoEjlbNRvnkj0tZ0OXu4gR/goXtawrrCVsOT7nYnLY4s
 tz0U9ioc0sOQYHJBU+6RlZ4wVnvpRxoRFl57Jf3scxXncu3oIQlX6DX4EGUgi6QDe6a9
 0/2shAfHB+U9j/Cppo2wMoBewC1gPYx4W9Md3wKGM1zP+aTZ4e/OOCl0TyhQOqHfWXSR
 8WHfLYqlSaOgMvQTP8OpjCZ/anDitQ5mYpb3CZNcBizlLHsXXYI1F55ygM6CFL/llaRU
 /zV7olfPzE2DNJfxivqD5UiSqJWbDLDAavF/Lj0Kcx01sB0wshRafYGVzZ1dh0MBJx1b
 XmKw==
X-Gm-Message-State: AOJu0YxV2LvlySaD9Z7OuWI0AQEdoxB5ayNGXCFR3gECXy1zBZPPCe04
 1GNsi6oaH4YPehbVCLdfu0MV+8Bum8La1Od3vEJ/2miyhGLFbGJDjkzWY+URIxzrL+97fFMYA2U
 LUDD9In/mP4Dbxw5UCdoROZNEQvpHcYohH6N8BnN8BY8XC8GsRfFmKLQKM+Za0htlRpmiCNTots
 Zy/zAzO5DHxLwMgv5Sa5xxY3K5WD1t1Cdw
X-Gm-Gg: ASbGnct4ovSGaX8ShPk+R31vdiEsf/BwYXIPJlTooUeveSVzSJr8k0ZQnWTfoO8TeYc
 0a3vtY3jT9Hhv8fS1cdXLc4IZWRr/cI5JouuE7Igrn/VpASKM3XXRb6Qx8FR+ie7hqcUNPeF+5I
 1MsbbGLv68XbXJOUhr52M92A==
X-Received: by 2002:a05:6902:154a:b0:e96:fa6b:878c with SMTP id
 3f1490d57ef6-e98a5759c87mr10711997276.11.1756835563202; 
 Tue, 02 Sep 2025 10:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYXF7M3YoX9aW/R/RpdnzmrHwY0wH8kViMbKDfg8Wx1aMkGWp+u7mnIJr8x1f8fok7b6pu+A9iTd8yPlxc9So=
X-Received: by 2002:a05:6902:154a:b0:e96:fa6b:878c with SMTP id
 3f1490d57ef6-e98a5759c87mr10711978276.11.1756835562714; Tue, 02 Sep 2025
 10:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250826185052.511223-1-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA_R4tZTtP875VJM3_o_fTL=oo05GcCXO479eq3VNgDpLA@mail.gmail.com>
In-Reply-To: <CAFEAcA_R4tZTtP875VJM3_o_fTL=oo05GcCXO479eq3VNgDpLA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 13:52:32 -0400
X-Gm-Features: Ac12FXyiOQmiadBxOf0hodI9rjM2GPs4BJ9FLFQndV25GdrfIGZN4B0EVQmlK_8
Message-ID: <CAEWVDmskFQWRH-vxTYbRgdDPSYPpUhXnP4yZ6bxv-gNf0LSQ-w@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] target/arm: Added support for SME register
 exposure to GDB
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a50d0c063dd52710"
X-Proofpoint-GUID: Pwl3kMklcBH3kLyHiXxCACjJviWF-LaH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX5d4cpER3cc3y
 YrKjDx3FAzIw+Ua4OhSBk7QhbQ3cE2IlIh4hgS5/qVPW4ThOEOPlTV+rJjVxdzRKSma8eWr1T/A
 nXLCr6aWCSwfifD/2Wax+PDpuNps8WGzGa4N2aul6OZDMdoAtRwKwHJZ7ZE5dvjzgwekQcogC1S
 RsCFMTIZRIr3qyqFF6EVylJ34WifmxDwwwLL2wfT0uvpAGeB2WIE0HNNuZCYPE8JeAp43JBasDE
 LCLjCI6hHpXEQvUyUWgmunU8odHIM7xnyPY6AWLbLwprRsz6UtO5ZqZYHE42JOObJE+3TzIKIOU
 KtYDjkd2IKaIFXONJj6oU+LTTL/ii6VJXSSCM/HeOo08QEOkrdHyTPLmnm4NqW+RJOVQOw/ZtHU
 /Rk1+vP/
X-Proofpoint-ORIG-GUID: Pwl3kMklcBH3kLyHiXxCACjJviWF-LaH
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b72eec cx=c_pps
 a=5rZgxjGdQ1phXw1xqkF1vg==:117 a=yJojWOMRYYMA:10 a=CCpqsmhAAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Dg_AUq5y-LNeIlJFgOoA:9 a=QEXdDO2ut3YA:10
 a=v2fgoWfUfwoA:10 a=HjjZBBvkAAAA:8 a=PsgF5xkfgFGdeFutLAIA:9
 a=tXgjE3hzoRJbHQGY:21 a=lqcHg5cX4UMA:10 a=FvMT9AR2qkiEEVpopuB7:22
 a=ul9cdbp4aOFLsgKbc677:22 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

--000000000000a50d0c063dd52710
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Regarding the definition of ZA as a 'vector of bytes' in the gdb
documentation, the choice that we have made in representing it
as a vector of vectors of bytes is based on the xml retrieved by
the native gdb client when run on a host with SME capabilities.

Is it sufficient to document this discrepancy in the commit message?

Thanks,
Vacha



On Tue, Sep 2, 2025 at 6:45=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Tue, 26 Aug 2025 at 19:50, Vacha Bhavsar
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
> > Changes since v5:
> > - added code to handle the case when we have SME without SVE
> > - added comments to indicate th cases in aarch64_gdb_get/set_sme_reg
> > - added/removed braces where necessary
> > - corrected capitalization in comments
> > ---
> >  target/arm/cpu.h       |   1 +
> >  target/arm/gdbstub.c   |   9 ++-
> >  target/arm/gdbstub64.c | 121 +++++++++++++++++++++++++++++++++++++++++
> >  target/arm/internals.h |   3 +
> >  4 files changed, 133 insertions(+), 1 deletion(-)
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
> > index ce4497ad7c..110258ec18 100644
> > --- a/target/arm/gdbstub.c
> > +++ b/target/arm/gdbstub.c
> > @@ -527,7 +527,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU
> *cpu)
> >           * registers so we don't need to include both.
> >           */
> >  #ifdef TARGET_AARCH64
> > -        if (isar_feature_aa64_sve(&cpu->isar)) {
> > +        if (isar_feature_aa64_sve(&cpu->isar) ||
> isar_feature_aa64_sme(&cpu->isar)) {
> >              GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs,
> cs->gdb_num_regs);
> >              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
> >                                       aarch64_gdb_set_sve_reg, feature,
> 0);
> > @@ -537,6 +537,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU
> *cpu)
> >
>  gdb_find_static_feature("aarch64-fpu.xml"),
> >                                       0);
> >          }
> > +
> > +        if (isar_feature_aa64_sme(&cpu->isar)) {
> > +            GDBFeature *sme_feature =3D arm_gen_dynamic_smereg_feature=
(cs,
> > +                cs->gdb_num_regs);
>
> Your indent here and below for function calls on multiple
> lines is wrong -- follow the way the existing code does it,
> where the second line lines up with the first argument
> after the '('.  (We sometimes make an exception where the wrapping
> would look terrible, but this is the usual approach.)
>
> > +            gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> > +                aarch64_gdb_set_sme_reg, sme_feature, 0);
> > +        }
> >          /*
> >           * Note that we report pauth information via the feature name
> >           * org.gnu.gdb.aarch64.pauth_v2, not org.gnu.gdb.aarch64.pauth=
.
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 08e2858539..d3fd94b93d 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -249,6 +249,90 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t
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
> > +    case 0: /* svg register */
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
> > +    case 1: /* svcr register */
> > +        return gdb_get_reg64(buf, env->svcr);
> > +    case 2: /* za register */
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
> > +    case 0: /* svg register */
> > +        /* cannot set svg via gdbstub */
> > +        return 8;
> > +    case 1: /* svcr register */
> > +        aarch64_set_svcr(env, ldq_le_p(buf),
> > +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> > +        return 8;
> > +    case 2: /* za register */
> > +    {
> > +        int len =3D 0;
> > +        int vq =3D cpu->sme_max_vq;
> > +        int svl =3D vq * 16;
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (int q =3D 0; q < vq; q++) {
> > +                if (target_big_endian()) {
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
> > +    }
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
> > @@ -413,6 +497,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUStat=
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
>
>
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/AArch64-Features.h=
tml#AArch64-Features
>
> says ZA should be a vector of bytes, not a vector of a vector of bytes.
> Is it wrong ?
>
> > +
> > +    /* Define the svg, svcr, and za registers. */
> > +
> > +    /* fpscr & status registers */
>
> This comment seems to be wrong and can be deleted.
>
> > +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
> > +        "int", NULL);
> > +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
> > +        "int", NULL);
> > +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8, reg+=
+,
> > +        "sme_bvv", NULL);
>
> We will also want to have support for the org.gnu.gdb.aarch64.sme2
> feature (which has the ZT0 register), but we can add that as
> a separate patch later.
>
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
>
> thanks
> -- PMM
>

--000000000000a50d0c063dd52710
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Regarding the definition of ZA as a=
 &#39;vector of bytes&#39; in the gdb</div><div>documentation, the choice t=
hat we have made in representing it</div><div>as a vector of vectors of byt=
es is based on the xml retrieved by=C2=A0</div><div>the native gdb client w=
hen run on a host with SME capabilities.</div><div><br></div><div>Is it suf=
ficient to document this discrepancy in the commit message?</div><div><br><=
/div><div>Thanks,</div><div>Vacha</div><div><br></div><div><br></div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Sep 2, 2025 at 6:45=E2=80=AFAM Peter Maydell &lt;<a=
 href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, 2=
6 Aug 2025 at 19:50, Vacha Bhavsar<br>
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
&gt; Changes since v5:<br>
&gt; - added code to handle the case when we have SME without SVE<br>
&gt; - added comments to indicate th cases in aarch64_gdb_get/set_sme_reg<b=
r>
&gt; - added/removed braces where necessary<br>
&gt; - corrected capitalization in comments<br>
&gt; ---<br>
&gt;=C2=A0 target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 target/arm/gdbstub.c=C2=A0 =C2=A0|=C2=A0 =C2=A09 ++-<br>
&gt;=C2=A0 target/arm/gdbstub64.c | 121 +++++++++++++++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 target/arm/internals.h |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 4 files changed, 133 insertions(+), 1 deletion(-)<br>
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
&gt; index ce4497ad7c..110258ec18 100644<br>
&gt; --- a/target/arm/gdbstub.c<br>
&gt; +++ b/target/arm/gdbstub.c<br>
&gt; @@ -527,7 +527,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU=
 *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* registers so we don&#39;t ne=
ed to include both.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #ifdef TARGET_AARCH64<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isar_feature_aa64_sve(&amp;cpu-&gt;is=
ar)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isar_feature_aa64_sve(&amp;cpu-&gt;is=
ar) || isar_feature_aa64_sme(&amp;cpu-&gt;isar)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeature *feature =
=3D arm_gen_dynamic_svereg_feature(cs, cs-&gt;gdb_num_regs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocess=
or(cs, aarch64_gdb_get_sve_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aarch6=
4_gdb_set_sve_reg, feature, 0);<br>
&gt; @@ -537,6 +537,13 @@ void arm_cpu_register_gdb_regs_for_features(ARMCP=
U *cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_fi=
nd_static_feature(&quot;aarch64-fpu.xml&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isar_feature_aa64_sme(&amp;cpu-&gt;is=
ar)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeature *sme_feature =3D=
 arm_gen_dynamic_smereg_feature(cs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;gdb_nu=
m_regs);<br>
<br>
Your indent here and below for function calls on multiple<br>
lines is wrong -- follow the way the existing code does it,<br>
where the second line lines up with the first argument<br>
after the &#39;(&#39;.=C2=A0 (We sometimes make an exception where the wrap=
ping<br>
would look terrible, but this is the usual approach.)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_register_coprocessor(cs=
, aarch64_gdb_get_sme_reg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_gdb_s=
et_sme_reg, sme_feature, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Note that we report pauth in=
formation via the feature name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* org.gnu.gdb.aarch64.pauth_v2=
, not org.gnu.gdb.aarch64.pauth.<br>
&gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
&gt; index 08e2858539..d3fd94b93d 100644<br>
&gt; --- a/target/arm/gdbstub64.c<br>
&gt; +++ b/target/arm/gdbstub64.c<br>
&gt; @@ -249,6 +249,90 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t=
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
&gt; +=C2=A0 =C2=A0 case 0: /* svg register */<br>
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
&gt; +=C2=A0 =C2=A0 case 1: /* svcr register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, env-&gt;svcr);<=
br>
&gt; +=C2=A0 =C2=A0 case 2: /* za register */<br>
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
&gt; +=C2=A0 =C2=A0 case 0: /* svg register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cannot set svg via gdbstub */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 case 1: /* svcr register */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_set_svcr(env, ldq_le_p(buf),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_SVCR_SM_MASK | R_SVCR_ZA_=
MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 case 2: /* za register */<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int q =3D 0; q &lt; vq=
; q++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_bi=
g_endian()) {<br>
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
&gt; +=C2=A0 =C2=A0 }<br>
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
&gt; @@ -413,6 +497,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUSta=
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
<br>
<a href=3D"https://sourceware.org/gdb/current/onlinedocs/gdb.html/AArch64-F=
eatures.html#AArch64-Features" rel=3D"noreferrer" target=3D"_blank">https:/=
/sourceware.org/gdb/current/onlinedocs/gdb.html/AArch64-Features.html#AArch=
64-Features</a><br>
<br>
says ZA should be a vector of bytes, not a vector of a vector of bytes.<br>
Is it wrong ?<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Define the svg, svcr, and za registers. */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* fpscr &amp; status registers */<br>
<br>
This comment seems to be wrong and can be deleted.<br>
<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;svg&=
quot;, 64, reg++,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;svcr=
&quot;, 64, reg++,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder, &quot;za&q=
uot;, svl * svl * 8, reg++,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sme_bvv&quot;, NULL);<br>
<br>
We will also want to have support for the org.gnu.gdb.aarch64.sme2<br>
feature (which has the ZT0 register), but we can add that as<br>
a separate patch later.<br>
<br>
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
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000a50d0c063dd52710--

