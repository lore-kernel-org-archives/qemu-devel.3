Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D532CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYLY-0007Ly-O5; Mon, 11 Aug 2025 15:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYLJ-0007L9-PF
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:38:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYLA-00041r-4b
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:38:00 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BFVDIa019150
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fFInseKVwrN0ZDCXejyzHhXR
 g1JiTv2xtczVxZS2QZs=; b=R5GFVIVrnHbUuDxFGngN5M2IoXOAKllwrswL1+mQ
 CrnvC4fzIFzQyjXSqxuzB3GLNi990pdq5BFjdyFHpQzrMkrQ1IZtex5jIbf8uKfa
 cWg6FBPdcDQjPfkv5llnN6oZIw8LF/5ugBwslhwSfTv2acIeBybXjglAf2QXpfuc
 PmC35xcVUR04QWM8O9r5w2OInMjZR82xMngr9wCWnS7ux4YEZW/A2GyIsJO+h6dO
 iZsAR03j46xrhl4vnFwkoEKm8agY9CIhF6DrALeImN1TUZR8BwxSoYOz9HYS+Exk
 e70hlWdoXNr2iH0G6bM8Iz8yw+v242C6EGRQNUb3P7cjUA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduwm4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:46 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71bd2c86292so72732907b3.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941065; x=1755545865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFInseKVwrN0ZDCXejyzHhXRg1JiTv2xtczVxZS2QZs=;
 b=TIZp/nrtjhUJUr6PrRoszSQHufCnUu4sH9VNfO3LuhcAFkFex08WsOjxSUBQkJtx/Z
 X0LDuz5CvEUsDO/RSjKGkVASAJ7h9F+O9Rx0dIUIGRn9sEPmZDBphnA9O6kih2bhDHar
 KRlcPOrOWwoT+tk+Ovm4d86zFDQX1PTjvSvJdDo8QDzqHv6Lootx8qVGBXgBWDKCLmYW
 zPPCa/DUzJWUXgdgBsWqXOwF9+TWlcRn23iCgOEJVU3V3fYyvWYlymN+Pd8jIeh62xm0
 Qg7rrd8cM9+weqQURvzurhlAXt5T0lCtwYiFQ9zQSk1Ac6hkl6KfPj1Q0UpwMuG/ngdr
 lRPQ==
X-Gm-Message-State: AOJu0YyL+0NkP9DfKDuFci2NL+Z6TwVoSuMAqA0h88VDlEdZ2GL2ndZN
 gPr8Hve2vPHtADYbTSfZP7raC6v1sf2/0vtAyAE8LsupsWUZjQpgIGn70J/mP+IaM4HP5q2tPw7
 s13uLuBw+rBfL7wOzTmttDa1q7TpBzGShxrJLCnAsohOorVpOqRyXuq4iFI6DW18oIdfRQ7mMm/
 8KN77RxmUvj2ORtKwaiT2lAhWgpO0pzJN71lFSnCLYhak=
X-Gm-Gg: ASbGncuar6H1cFMR4rRXpmaoiCwSY4k1XRBFKIfhbb+ttaZ54/qaV3SUYEJZGYvw0W+
 iCy1zDxLEUGFZVPFaobafSuHsBn6nEUNBKVGbWplg6T3fltASqvjLA+08aWb2Wue/o9aOJSgY9I
 qQ0JoKvx+XRBj7MgzPr3edVsQ=
X-Received: by 2002:a05:690c:2609:b0:71b:f6b4:da91 with SMTP id
 00721157ae682-71c42a4421dmr13719927b3.24.1754941065114; 
 Mon, 11 Aug 2025 12:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjna40Uam+TR9IfB6x/A7lpHhTKr2gxWiHlkuapaCUpmzbFE2joEB9xC390h3989r9gWbQPIHUJ9GzGQhCZB0=
X-Received: by 2002:a05:690c:2609:b0:71b:f6b4:da91 with SMTP id
 00721157ae682-71c42a4421dmr13719427b3.24.1754941064450; Mon, 11 Aug 2025
 12:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-3-vacha.bhavsar@oss.qualcomm.com>
 <87zfcf5cco.fsf@draig.linaro.org>
 <CAEWVDmstkUnsLbj-h2g9p5ajUSuc9UZXngqFOj-xgoJO2PsWiw@mail.gmail.com>
 <87cy92jnme.fsf@draig.linaro.org>
In-Reply-To: <87cy92jnme.fsf@draig.linaro.org>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 15:37:32 -0400
X-Gm-Features: Ac12FXy2U9rEbtDrOzs1n4ry3vJvI6oDWZ7QBq-0GdFNhAJ6DBcNLc8Bw3MeduI
Message-ID: <CAEWVDmuYDnTOoO_jxGLP1Pcn1Y=yt4sMKZW0k4Q0um23nkAx+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: Added support for SME register
 exposure to GDB
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000bfab7c063c1c0ed1"
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689a468a cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=viWAkiRhnmop7DU0UF8A:9 a=QEXdDO2ut3YA:10 a=HjjZBBvkAAAA:8
 a=OBNpZ60H1LquFmVUWoAA:9 a=f0zjvqEhnHDGmYL_:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
X-Proofpoint-ORIG-GUID: oqc5CxBcNcY7OroVU3M3CuXcEQzxlACg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX6VnDZD+X+FjW
 A3lxLBEIFVlq/7e+bYpG6PVogi1bld+EYpwTqepF7mvcCVhHAIbI3cO5WlmV04DCkogSoQzpgzs
 f1Dxj7mVa4U7SCRerU2spH/0JlkacqyTC9QxftrZde3rYOzZKn5sOMVBSC1YKrTtZE0JyUdb+Sf
 VQKD/8YBntXviiyi63RioMS93UjWgdr4s8A/GbTTzuL6AGvd45udnWtOOaL8Aus9MuUrM+GMTL3
 yr6s3ONxQDEpm9oubozt0LXOaVVNcUDC438o3PGsBTDYSbdsFA1uJhDhu9ZS6xupUA66wwGtF8b
 A6UyJoHTLGSw6AsXSYwH4GdXzcTZ7jQtSLHGBGeE4UdzXGWib0XxzepZXUZZDlbtm4mXh4mMj0X
 lweYNlA/
X-Proofpoint-GUID: oqc5CxBcNcY7OroVU3M3CuXcEQzxlACg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025
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

--000000000000bfab7c063c1c0ed1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, thank you!

On Mon, Aug 11, 2025 at 3:58=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
>
> > Hi,
> >
> >
> >
> > I've built a testcase for this similar to the one you suggested. This
> test
> >
> > checks both reading and writing the za register via $za and via the til=
es
> >
> > and tiles slices that gdb produces (i.e., za0hb0). However, these tiles
> and
> >
> > slices are generated from the gdb side, they're not made available by a=
ny
> >
> > of the changes that I have implemented. But this feature of gdb's kicks
> in
> >
> > when using gdb14.1 or newer. Due to this, the testcase works correctly
> when
> >
> > used with gdb14.1 and above, and fails on any gdb version older than th=
at
> >
> > as the tiles/slices are not made available by gdb.
> >
> >
> >
> > I was wondering if there is any way to set a requirement on this testca=
se
> >
> > which specifies it needs to be run with minimum of gdb version 14.1
> >
> > which has the functionality to break down the ZA storage into tiles and
> >
> > slices?
>
> We have tests in configure to probe the gdbversion, e.g:
>
>   if test "${gdb_arches#*aarch64}" !=3D "$gdb_arches" && version_ge
> $gdb_version 15.1; then
>       echo "GDB_HAS_MTE=3Dy" >> $config_target_mak
>   fi
>
> which can then wrap the test in the Makefile, e.g.:
>
>   ifeq ($(GDB_HAS_MTE),y)
>   run-gdbstub-mte: mte-8
>           $(call run-test, $@, $(GDB_SCRIPT) \
>                   --gdb $(GDB) \
>                   --qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
>                   --bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
>                   -- --mode=3Duser, \
>           gdbstub MTE support)
>
>   EXTRA_RUNS +=3D run-gdbstub-mte
>   endif
>
>
> >
> >
> >
> >
> >
> > Thanks,
> >
> > Vacha
> >
> > On Mon, Aug 4, 2025 at 11:35=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> >  Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
> >
> >  > The QEMU GDB stub does not expose the ZA storage SME register to GDB
> via
> >  > the remote serial protocol, which can be a useful functionality to
> debug SME
> >  > code. To provide this functionality in Aarch64 target, this patch
> registers the
> >  > SME register set with the GDB stub. To do so, this patch implements
> the
> >  > aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() functions to
> >  > specify how to get and set the SME registers, and the
> >  > arm_gen_dynamic_smereg_feature() function to generate the target
> >  > description in XML format to indicate the target architecture
> supports SME.
> >  > Finally, this patch includes a dyn_smereg_feature structure to hold
> this
> >  > GDB XML description of the SME registers for each CPU.
> >  >
> >  > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> >  > ---
> >  > Changes since v3:
> >  > - added changes to aarch64_gdb_set_sme_reg() to address the concerns
> >  > brought up in review regarding endianness
> >  >
> >  >  target/arm/cpu.h       |   1 +
> >  >  target/arm/gdbstub.c   |   6 ++
> >  >  target/arm/gdbstub64.c | 122
> +++++++++++++++++++++++++++++++++++++++++
> >  >  target/arm/internals.h |   3 +
> >  >  4 files changed, 132 insertions(+)
> >  >
> >  > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> >  > index dc9b6dce4c..8bd66d7049 100644
> >  > --- a/target/arm/cpu.h
> >  > +++ b/target/arm/cpu.h
> >  > @@ -933,6 +933,7 @@ struct ArchCPU {
> >  >
> >  >      DynamicGDBFeatureInfo dyn_sysreg_feature;
> >  >      DynamicGDBFeatureInfo dyn_svereg_feature;
> >  > +    DynamicGDBFeatureInfo dyn_smereg_feature;
> >  >      DynamicGDBFeatureInfo dyn_m_systemreg_feature;
> >  >      DynamicGDBFeatureInfo dyn_m_secextreg_feature;
> >  >
> >  > diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> >  > index ce4497ad7c..9c942c77cc 100644
> >  > --- a/target/arm/gdbstub.c
> >  > +++ b/target/arm/gdbstub.c
> >  > @@ -531,6 +531,12 @@ void
> arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
> >  >              GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(=
cs,
> cs->gdb_num_regs);
> >  >              gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
> >  >                                       aarch64_gdb_set_sve_reg,
> feature, 0);
> >  > +            if (isar_feature_aa64_sme(&cpu->isar)) {
> >  > +                GDBFeature *sme_feature =3D
> arm_gen_dynamic_smereg_feature(cs,
> >  > +                                             cs->gdb_num_regs);
> >  > +                gdb_register_coprocessor(cs, aarch64_gdb_get_sme_re=
g,
> >  > +                    aarch64_gdb_set_sme_reg, sme_feature, 0);
> >  > +            }
> >  >          } else {
> >  >              gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
> >  >                                       aarch64_gdb_set_fpu_reg,
> >  > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> >  > index 64ee9b3b56..3d86980bc9 100644
> >  > --- a/target/arm/gdbstub64.c
> >  > +++ b/target/arm/gdbstub64.c
> >  > @@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *cs,
> uint8_t *buf, int reg)
> >  >      return 0;
> >  >  }
> >  >
> >  > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> >  > +{
> >  > +    ARMCPU *cpu =3D ARM_CPU(cs);
> >  > +    CPUARMState *env =3D &cpu->env;
> >  > +
> >  > +    switch (reg) {
> >  > +    /* Svg register */
> >  > +    case 0:
> >  > +    {
> >  > +        int vq =3D 0;
> >  > +        if (FIELD_EX64(env->svcr, SVCR, SM)) {
> >  > +            vq =3D sve_vqm1_for_el_sm(env, arm_current_el(env),
> >  > +                     FIELD_EX64(env->svcr, SVCR, SM)) + 1;
> >  > +        }
> >  > +        /* svg =3D vector granules (2 * vector quardwords) in
> streaming mode */
> >  > +        return gdb_get_reg64(buf, vq * 2);
> >  > +    }
> >  > +    case 1:
> >  > +        return gdb_get_reg64(buf, env->svcr);
> >  > +    case 2:
> >  > +    {
> >  > +        int len =3D 0;
> >  > +        int vq =3D cpu->sme_max_vq;
> >  > +        int svl =3D vq * 16;
> >  > +        for (int i =3D 0; i < svl; i++) {
> >  > +            for (int q =3D 0; q < vq; q++) {
> >  > +                len +=3D gdb_get_reg128(buf,
> >  > +                           env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[=
q * 2 + 1],
> >  > +                           env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[=
q * 2]);
> >  > +            }
> >  > +        }
> >  > +        return len;
> >  > +    }
> >  > +    default:
> >  > +        /* gdbstub asked for something out of range */
> >  > +        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d",
> __func__, reg);
> >  > +        break;
> >  > +    }
> >  > +
> >  > +    return 0;
> >  > +}
> >  > +
> >  > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg)
> >  > +{
> >  > +    ARMCPU *cpu =3D ARM_CPU(cs);
> >  > +    CPUARMState *env =3D &cpu->env;
> >  > +
> >  > +    switch (reg) {
> >  > +    case 0:
> >  > +    {
> >  > +        /* cannot set svg via gdbstub */
> >  > +        return 8;
> >  > +    }
> >  > +    case 1:
> >  > +        aarch64_set_svcr(env, ldq_le_p(buf),
> >  > +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> >  > +        return 8;
> >  > +    case 2:
> >  > +        int len =3D 0;
> >  > +        int vq =3D cpu->sme_max_vq;
> >  > +        int svl =3D vq * 16;
> >  > +        for (int i =3D 0; i < svl; i++) {
> >  > +            for (int q =3D 0; q < vq; q++) {
> >  > +                if (target_big_endian()){
> >  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2 +=
 1] =3D ldq_p(buf);
> >  > +                    buf +=3D 8;
> >  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2] =
=3D ldq_p(buf);
> >  > +                } else{
> >  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2] =
=3D ldq_p(buf);
> >  > +                    buf +=3D 8;
> >  > +                    env->za_state.za=E2=9A=A0=EF=B8=8F[i].d[q * 2 +=
 1] =3D ldq_p(buf);
> >  > +                }
> >  > +                buf +=3D 8;
> >  > +                len +=3D 16;
> >  > +            }
> >  > +        }
> >  > +        return len;
> >  > +    default:
> >  > +        /* gdbstub asked for something out of range */
> >  > +        break;
> >  > +    }
> >  > +
> >  > +    return 0;
> >  > +}
> >  > +
> >  >  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int re=
g)
> >  >  {
> >  >      ARMCPU *cpu =3D ARM_CPU(cs);
> >  > @@ -392,6 +477,43 @@ GDBFeature
> *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
> >  >      return &cpu->dyn_svereg_feature.desc;
> >  >  }
> >  >
> >  > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int
> base_reg)
> >  > +{
> >  > +    ARMCPU *cpu =3D ARM_CPU(cs);
> >  > +    int vq =3D cpu->sme_max_vq;
> >  > +    int svl =3D vq * 16;
> >  > +    GDBFeatureBuilder builder;
> >  > +    int reg =3D 0;
> >  > +
> >  > +    gdb_feature_builder_init(&builder, &cpu->dyn_smereg_feature.des=
c,
> >  > +        "org.gnu.gdb.aarch64.sme", "sme-registers.xml", base_reg);
> >  > +
> >  > +
> >  > +    /* Create the sme_bv vector type. */
> >  > +    gdb_feature_builder_append_tag(&builder,
> >  > +        "<vector id=3D\"sme_bv\" type=3D\"uint8\" count=3D\"%d\"/>"=
,
> >  > +        svl);
> >  > +
> >  > +    /* Create the sme_bvv vector type. */
> >  > +    gdb_feature_builder_append_tag(
> >  > +        &builder, "<vector id=3D\"sme_bvv\" type=3D\"sme_bv\"
> count=3D\"%d\"/>",
> >  > +        svl);
> >  > +
> >  > +    /* Define the svg, svcr, and za registers. */
> >  > +
> >  > +    /* fpscr & status registers */
> >  > +    gdb_feature_builder_append_reg(&builder, "svg", 64, reg++,
> >  > +        "int", NULL);
> >  > +    gdb_feature_builder_append_reg(&builder, "svcr", 64, reg++,
> >  > +        "int", NULL);
> >  > +    gdb_feature_builder_append_reg(&builder, "za", svl * svl * 8,
> reg++,
> >  > +        "sme_bvv", NULL);
> >  > +
> >  > +    gdb_feature_builder_end(&builder);
> >  > +
> >  > +    return &cpu->dyn_smereg_feature.desc;
> >  > +}
> >  > +
> >  >  #ifdef CONFIG_USER_ONLY
> >  >  int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int
> reg)
> >  >  {
> >  > diff --git a/target/arm/internals.h b/target/arm/internals.h
> >  > index c4765e4489..760e1c6490 100644
> >  > --- a/target/arm/internals.h
> >  > +++ b/target/arm/internals.h
> >  > @@ -1808,8 +1808,11 @@ static inline uint64_t
> pmu_counter_mask(CPUARMState *env)
> >  >  }
> >  >
> >  >  GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int
> base_reg);
> >  > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, int
> base_reg);
> >  >  int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)=
;
> >  >  int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
> >  > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)=
;
> >  > +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, int reg);
> >  >  int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg)=
;
> >  >  int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
> >  >  int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int
> reg);
> >
> >  It would also be nice to add a test for this, see
> tests/tcg/aarch64/gdbstub/test-sve.py
> >
> >  --
> >  Alex Benn=C3=A9e
> >  Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000bfab7c063c1c0ed1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Got it, thank you!</div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 11, 20=
25 at 3:58=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@li=
naro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Vacha Bhavsar &lt;<a href=3D"mailto:vacha.=
bhavsar@oss.qualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com<=
/a>&gt; writes:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;<br>
&gt; I&#39;ve built a testcase for this similar to the one you suggested. T=
his test <br>
&gt;<br>
&gt; checks both reading and writing the za register via $za and via the ti=
les<br>
&gt;<br>
&gt; and tiles slices that gdb produces (i.e., za0hb0). However, these tile=
s and <br>
&gt;<br>
&gt; slices are generated from the gdb side, they&#39;re not made available=
 by any<br>
&gt;<br>
&gt; of the changes that I have implemented. But this feature of gdb&#39;s =
kicks in<br>
&gt;<br>
&gt; when using gdb14.1 or newer. Due to this, the testcase works correctly=
 when<br>
&gt;<br>
&gt; used with gdb14.1 and above, and fails on any gdb version older than t=
hat<br>
&gt;<br>
&gt; as the tiles/slices are not made available by gdb.<br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;<br>
&gt; I was wondering if there is any way to set a requirement on this testc=
ase<br>
&gt;<br>
&gt; which specifies it needs to be run with minimum of gdb version 14.1<br=
>
&gt;<br>
&gt; which has the functionality to break down the ZA storage into tiles an=
d <br>
&gt;<br>
&gt; slices?<br>
<br>
We have tests in configure to probe the gdbversion, e.g:<br>
<br>
=C2=A0 if test &quot;${gdb_arches#*aarch64}&quot; !=3D &quot;$gdb_arches&qu=
ot; &amp;&amp; version_ge $gdb_version 15.1; then<br>
=C2=A0 =C2=A0 =C2=A0 echo &quot;GDB_HAS_MTE=3Dy&quot; &gt;&gt; $config_targ=
et_mak<br>
=C2=A0 fi<br>
<br>
which can then wrap the test in the Makefile, e.g.:<br>
<br>
=C2=A0 ifeq ($(GDB_HAS_MTE),y)<br>
=C2=A0 run-gdbstub-mte: mte-8<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(call run-test, $@, $(GDB_SCRIPT) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --gdb $(GDB)=
 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --qemu $(QEM=
U) --qargs &quot;$(QEMU_OPTS)&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --bin $&lt; =
--test $(AARCH64_SRC)/gdbstub/test-mte.py \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -- --mode=3D=
user, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdbstub MTE support)<br>
<br>
=C2=A0 EXTRA_RUNS +=3D run-gdbstub-mte<br>
=C2=A0 endif<br>
<br>
<br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Vacha<br>
&gt;<br>
&gt; On Mon, Aug 4, 2025 at 11:35=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.c=
om" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt; writes:<br>
&gt;<br>
&gt;=C2=A0 &gt; The QEMU GDB stub does not expose the ZA storage SME regist=
er to GDB via<br>
&gt;=C2=A0 &gt; the remote serial protocol, which can be a useful functiona=
lity to debug SME<br>
&gt;=C2=A0 &gt; code. To provide this functionality in Aarch64 target, this=
 patch registers the<br>
&gt;=C2=A0 &gt; SME register set with the GDB stub. To do so, this patch im=
plements the<br>
&gt;=C2=A0 &gt; aarch64_gdb_get_sme_reg() and aarch64_gdb_set_sme_reg() fun=
ctions to<br>
&gt;=C2=A0 &gt; specify how to get and set the SME registers, and the<br>
&gt;=C2=A0 &gt; arm_gen_dynamic_smereg_feature() function to generate the t=
arget<br>
&gt;=C2=A0 &gt; description in XML format to indicate the target architectu=
re supports SME.<br>
&gt;=C2=A0 &gt; Finally, this patch includes a dyn_smereg_feature structure=
 to hold this<br>
&gt;=C2=A0 &gt; GDB XML description of the SME registers for each CPU.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bh=
avsar@oss.qualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a=
>&gt;<br>
&gt;=C2=A0 &gt; ---<br>
&gt;=C2=A0 &gt; Changes since v3:<br>
&gt;=C2=A0 &gt; - added changes to aarch64_gdb_set_sme_reg() to address the=
 concerns <br>
&gt;=C2=A0 &gt; brought up in review regarding endianness<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
&gt;=C2=A0 &gt;=C2=A0 target/arm/gdbstub.c=C2=A0 =C2=A0|=C2=A0 =C2=A06 ++<b=
r>
&gt;=C2=A0 &gt;=C2=A0 target/arm/gdbstub64.c | 122 ++++++++++++++++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 &gt;=C2=A0 target/arm/internals.h |=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 &gt;=C2=A0 4 files changed, 132 insertions(+)<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; diff --git a/target/arm/cpu.h b/target/arm/cpu.h<br>
&gt;=C2=A0 &gt; index dc9b6dce4c..8bd66d7049 100644<br>
&gt;=C2=A0 &gt; --- a/target/arm/cpu.h<br>
&gt;=C2=A0 &gt; +++ b/target/arm/cpu.h<br>
&gt;=C2=A0 &gt; @@ -933,6 +933,7 @@ struct ArchCPU {<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_sysreg_featur=
e;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_svereg_featur=
e;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_smereg_feature;<br=
>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_m_systemreg_f=
eature;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 DynamicGDBFeatureInfo dyn_m_secextreg_f=
eature;<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt; diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c<br=
>
&gt;=C2=A0 &gt; index ce4497ad7c..9c942c77cc 100644<br>
&gt;=C2=A0 &gt; --- a/target/arm/gdbstub.c<br>
&gt;=C2=A0 &gt; +++ b/target/arm/gdbstub.c<br>
&gt;=C2=A0 &gt; @@ -531,6 +531,12 @@ void arm_cpu_register_gdb_regs_for_fea=
tures(ARMCPU *cpu)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GDBFeature =
*feature =3D arm_gen_dynamic_svereg_feature(cs, cs-&gt;gdb_num_regs);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_registe=
r_coprocessor(cs, aarch64_gdb_get_sve_reg,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0aarch64_gdb_set_sve_reg, feature, 0);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (isar_feature=
_aa64_sme(&amp;cpu-&gt;isar)) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GD=
BFeature *sme_feature =3D arm_gen_dynamic_smereg_feature(cs,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;gdb_num_regs);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gd=
b_register_coprocessor(cs, aarch64_gdb_get_sme_reg,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 aarch64_gdb_set_sme_reg, sme_feature, 0);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_registe=
r_coprocessor(cs, aarch64_gdb_get_fpu_reg,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0aarch64_gdb_set_fpu_reg,<br>
&gt;=C2=A0 &gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.=
c<br>
&gt;=C2=A0 &gt; index 64ee9b3b56..3d86980bc9 100644<br>
&gt;=C2=A0 &gt; --- a/target/arm/gdbstub64.c<br>
&gt;=C2=A0 &gt; +++ b/target/arm/gdbstub64.c<br>
&gt;=C2=A0 &gt; @@ -228,6 +228,91 @@ int aarch64_gdb_set_sve_reg(CPUState *=
cs, uint8_t *buf, int reg)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt; +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf,=
 int reg)<br>
&gt;=C2=A0 &gt; +{<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 /* Svg register */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 case 0:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D 0;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FIELD_EX64(env-&gt;svcr, S=
VCR, SM)) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D sve_vqm1_=
for_el_sm(env, arm_current_el(env),<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0FIELD_EX64(env-&gt;svcr, SVCR, SM)) + 1;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* svg =3D vector granules (2 =
* vector quardwords) in streaming mode */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, vq *=
 2);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 case 1:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, env-=
&gt;svcr);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 case 2:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;=
<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; =
i++) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int q =3D 0=
; q &lt; vq; q++) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le=
n +=3D gdb_get_reg128(buf,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;<a href=3D"http://za_state=
.za" rel=3D"noreferrer" target=3D"_blank">za_state.za</a>=E2=9A=A0=EF=B8=8F=
[i].d[q * 2 + 1],<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;<a href=3D"http://za_state=
.za" rel=3D"noreferrer" target=3D"_blank">za_state.za</a>=E2=9A=A0=EF=B8=8F=
[i].d[q * 2]);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something=
 out of range */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_UNIMP, &quot=
;%s: out of range register %d&quot;, __func__, reg);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 &gt; +}<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, in=
t reg)<br>
&gt;=C2=A0 &gt; +{<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 case 0:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* cannot set svg via gdbstub =
*/<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 case 1:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_set_svcr(env, ldq_le_p=
(buf),<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_SVCR_SM_MASK |=
 R_SVCR_ZA_MASK);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 case 2:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;=
<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; =
i++) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int q =3D 0=
; q &lt; vq; q++) {<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if=
 (target_big_endian()){<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" tar=
get=3D"_blank">za_state.za</a>=E2=9A=A0=EF=B8=8F[i].d[q * 2 + 1] =3D ldq_p(=
buf);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 buf +=3D 8;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" tar=
get=3D"_blank">za_state.za</a>=E2=9A=A0=EF=B8=8F[i].d[q * 2] =3D ldq_p(buf)=
;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } =
else{<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" tar=
get=3D"_blank">za_state.za</a>=E2=9A=A0=EF=B8=8F[i].d[q * 2] =3D ldq_p(buf)=
;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 buf +=3D 8;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;<a href=3D"http://za_state.za" rel=3D"noreferrer" tar=
get=3D"_blank">za_state.za</a>=E2=9A=A0=EF=B8=8F[i].d[q * 2 + 1] =3D ldq_p(=
buf);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<=
br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bu=
f +=3D 8;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 le=
n +=3D 16;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 default:<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* gdbstub asked for something=
 out of range */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 &gt; +}<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArra=
y *buf, int reg)<br>
&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt;=C2=A0 &gt; @@ -392,6 +477,43 @@ GDBFeature *arm_gen_dynamic_svereg_fea=
ture(CPUState *cs, int base_reg)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 return &amp;cpu-&gt;dyn_svereg_feature.=
desc;<br>
&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt; +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, i=
nt base_reg)<br>
&gt;=C2=A0 &gt; +{<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 int vq =3D cpu-&gt;sme_max_vq;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 GDBFeatureBuilder builder;<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 int reg =3D 0;<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_init(&amp;builder, &amp;=
cpu-&gt;dyn_smereg_feature.desc,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;org.gnu.gdb.aarch64.sme&=
quot;, &quot;sme-registers.xml&quot;, base_reg);<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 /* Create the sme_bv vector type. */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_tag(&amp;builder,=
<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&lt;vector id=3D\&quot;s=
me_bv\&quot; type=3D\&quot;uint8\&quot; count=3D\&quot;%d\&quot;/&gt;&quot;=
,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 svl);<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 /* Create the sme_bvv vector type. */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_tag(<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;builder, &quot;&lt;vector=
 id=3D\&quot;sme_bvv\&quot; type=3D\&quot;sme_bv\&quot; count=3D\&quot;%d\&=
quot;/&gt;&quot;,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 svl);<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 /* Define the svg, svcr, and za registers. *=
/<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 /* fpscr &amp; status registers */<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder,=
 &quot;svg&quot;, 64, reg++,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder,=
 &quot;svcr&quot;, 64, reg++,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;int&quot;, NULL);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_append_reg(&amp;builder,=
 &quot;za&quot;, svl * svl * 8, reg++,<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;sme_bvv&quot;, NULL);<br=
>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 gdb_feature_builder_end(&amp;builder);<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 return &amp;cpu-&gt;dyn_smereg_feature.desc;=
<br>
&gt;=C2=A0 &gt; +}<br>
&gt;=C2=A0 &gt; +<br>
&gt;=C2=A0 &gt;=C2=A0 #ifdef CONFIG_USER_ONLY<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteAr=
ray *buf, int reg)<br>
&gt;=C2=A0 &gt;=C2=A0 {<br>
&gt;=C2=A0 &gt; diff --git a/target/arm/internals.h b/target/arm/internals.=
h<br>
&gt;=C2=A0 &gt; index c4765e4489..760e1c6490 100644<br>
&gt;=C2=A0 &gt; --- a/target/arm/internals.h<br>
&gt;=C2=A0 &gt; +++ b/target/arm/internals.h<br>
&gt;=C2=A0 &gt; @@ -1808,8 +1808,11 @@ static inline uint64_t pmu_counter_m=
ask(CPUARMState *env)<br>
&gt;=C2=A0 &gt;=C2=A0 }<br>
&gt;=C2=A0 &gt;=C2=A0 <br>
&gt;=C2=A0 &gt;=C2=A0 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *=
cpu, int base_reg);<br>
&gt;=C2=A0 &gt; +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cpu, =
int base_reg);<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray =
*buf, int reg);<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *bu=
f, int reg);<br>
&gt;=C2=A0 &gt; +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf,=
 int reg);<br>
&gt;=C2=A0 &gt; +int aarch64_gdb_set_sme_reg(CPUState *cs, uint8_t *buf, in=
t reg);<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray =
*buf, int reg);<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *bu=
f, int reg);<br>
&gt;=C2=A0 &gt;=C2=A0 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArra=
y *buf, int reg);<br>
&gt;<br>
&gt;=C2=A0 It would also be nice to add a test for this, see tests/tcg/aarc=
h64/gdbstub/test-sve.py<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000bfab7c063c1c0ed1--

