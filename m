Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D202DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRcO-0005Ya-7A; Mon, 14 Jul 2025 18:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubQ8k-0003wF-Kw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:51:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ubQ8i-0002Xw-7H
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 16:51:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGSHC9011566
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 20:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nIo6Ez9MDmdng9k6EtMZRgfs
 jG7XH380hTUP5ClFNxc=; b=Y0E+C5v4K0eFv+3vaWPshe2rCkRAlJI8v7HVZPSC
 ysqIPYFR3Fuy64inEcFqOZQrYvdcvc9vff9gQy7F0DCYy2RZxFefc3MvsK2TJOvf
 gCrBWq1Y4vV8DyWwfY3tpx3dp4i+4b4/oK3IrRLywjbWDJks9XWqHycUByQViPPI
 PG8lLYHLVDfhfz+PfzxdUsBWqzYk6cGdkhFxDsXjr8Jj4orF/+dxQ3bcchZ7bKFE
 AOJ0HV0sNawiwxesWwCX8I9kk2CgBoO7ASaYdsYZEyb0O2391LEO5i6GOvtDsZpE
 oHAe86TFsKnCMnFWJ+3+F54BEdIZOop4a/plv0D3tM2MPA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dygmg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 20:51:05 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-70e72e81fafso67055527b3.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752526264; x=1753131064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nIo6Ez9MDmdng9k6EtMZRgfsjG7XH380hTUP5ClFNxc=;
 b=XV/wQHvNDrtRiZ6bjGdswr/OJCg5aWjjATK3Lbj17DeMV0bfKFo0RyxsyE4eZmcZb1
 i3wdspRz5UgW2tC3Uj3FoL4fv9zi/7JGldNfowDczuhzuE1IA3g7mDN/bWf9MDf0xAa2
 9WyknIAR3VVp4jAueHZpCwn6w1r+7YRz/8VO5b6jUR6AWcbyFTigbfjWT9p+vVHSRcUL
 tmfCY6comonp5kDkeIIvY1GDrCeR0RIci13K0/Yh+M8zjW0EjOSZ+T5I2MsQH6mMq2ND
 uScfspw7N7bay5ykVzOd4qTur1cOytZDS9A2jq6QPHWQ68um8yA0h/x/aUqpXcyB9k7I
 Z2UQ==
X-Gm-Message-State: AOJu0Ywly5k614Q6q7PYh267BQu6kA2tCRe6C6I5UHAU6d6NLgQhbwo2
 XeHdPjBRXRfr4+mqI/wGjUrj6e9MmIj0PJWPnUwZubgrN41UdCLkqb7UkY/lxHYpYAhZMap3mWs
 l1YUFx6L4rfTxAH/Tjqu4uy/3YX7M7qU89QpjqXZQGs/aOEyr+9OqQ3NrIzitZwFul5owgzea66
 keiWa1veVKYF7mLBj/tzh8oOtIV/bHQ3Z7
X-Gm-Gg: ASbGncsiVOy64GCySJH/Ireio6VqYtiAI/mr5wLtdniNOmoCPwLVavlP7Jphi+xHGTZ
 0VlHelvrkL7LF5K6ykRknjwZng33sPBvWUj8lK7HobO66HMwZOLM/Hrh/+vDlYw5fLKfOTJCTpw
 xwmGQ5AqY6rl+u3gYic3+E9A==
X-Received: by 2002:a05:690c:6e0c:b0:712:c55c:4e5e with SMTP id
 00721157ae682-717d7a0e9d6mr201694707b3.18.1752526264453; 
 Mon, 14 Jul 2025 13:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6kh6ItOLVkNq/HwiVZy7iIJnwRLK8i0PeWz1vmtVSpkc0s8UF5aMyU5xeE+/tYXFg65nZlSbMhUNCNreFgtc=
X-Received: by 2002:a05:690c:6e0c:b0:712:c55c:4e5e with SMTP id
 00721157ae682-717d7a0e9d6mr201694417b3.18.1752526263937; Mon, 14 Jul 2025
 13:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250714174330.913636-1-vacha.bhavsar@oss.qualcomm.com>
 <a38e4185-71e6-4edf-99c6-c4c1f85066d0@linaro.org>
In-Reply-To: <a38e4185-71e6-4edf-99c6-c4c1f85066d0@linaro.org>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 16:50:53 -0400
X-Gm-Features: Ac12FXyXIHT500WhPC7rLG27dpTkFmaJZxmlD793maJCR3poJFCsNvSd66CYJxk
Message-ID: <CAEWVDmvPVc1A+z6o_AwLsS8zaMsnTO1qxSYFESf0yuoe3R2vKg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Added support for SME register exposure to
 GDB
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006bfe510639e9d131"
X-Proofpoint-ORIG-GUID: vmLNA1Hm6XIUK2vl8-WD1b39C6wzObue
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=68756db9 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8
 a=Nvkyb4XKfDslDQzV8p0A:9 a=QEXdDO2ut3YA:10 a=HjjZBBvkAAAA:8
 a=55cpyvLwM56_CnIXs54A:9 a=vzHnaPgXQvQ0fdxY:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22 a=yryXaR-spxf4diMYRkVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE0MCBTYWx0ZWRfX8YIIInVHffcE
 eKNY9GfbyrhpR+cNw5/ruy0FxW/DoSAGKqWVLEZ8iyHelc0Xwt45iFvAFLRjCYWPXBp7hby4H/S
 S++1D6ydLyDRUFAaDafod3fakaXTn73Mh1SppBlJmff0R1MOt62I53nh2lGnjMahq1KOXMtf0q7
 1UMC21qJaCwo7WnkP22xU0fhA+yztawcMNJWd4WVQ5uNHegExBejvB5msJJ1QED6Vx7JsTlskY7
 jUTXBi+vgv0jlf9cd4z/LDTo+AbO3v0WY4B0qeP2AiB64uATk0M/sTEHyL7eDrIAmYkhKCr5r8q
 2ft3ggOf0bAlXbG0wdnr788hs00LAZ0jAljjx8ijwhY/+FP/1/ha0TKXz9flY5wyUo/ro1a39Qy
 YW8viCt4VdTNHuFMnyIWd490Qw3t0LupeKekCZLgAS2KEWgrgJB2Ocpxz/fXyQR8FnPf1SA1
X-Proofpoint-GUID: vmLNA1Hm6XIUK2vl8-WD1b39C6wzObue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000006bfe510639e9d131
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

Thank you for the feedback! I have sent an updated version your way with
the suggested changes!

Thanks,
Vacha

On Mon, Jul 14, 2025 at 3:41=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/14/25 11:43, Vacha Bhavsar wrote:
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 64ee9b3b56..c39d636caa 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -228,6 +228,87 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t
> *buf, int reg)
> >       return 0;
> >   }
> >
> > +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    CPUARMState *env =3D &cpu->env;
> > +    bool streaming_mode =3D ((env->svcr & 0x01) !=3D 0);
>
> env->svcr & R_SVCR_SM_MASK, although perhaps
>
> > +
> > +    switch (reg) {
> > +    /* Svg register */
> > +    case 0:
> > +    {
> > +        int vq;
> > +        if (streaming_mode) {
> > +            vq =3D sve_vqm1_for_el_sm(env, arm_current_el(env),
> > +                     streaming_mode) + 1;
> > +        } else {
> > +            vq =3D 0;
> > +        }
> > +        /* svg =3D vector granules (2 * vector quardwords) in streamin=
g
> mode */
> > +        return gdb_get_reg64(buf, vq * 2);
>
>      int vq =3D 0;
>      if (FIELD_EX64(env->svcr, SVCR, SM)) {
>          vq =3D ...
>      }
>
> is clearer.
>
>
> > +    }
> > +    case 1:
> > +        return gdb_get_reg64(buf, env->svcr);
> > +    case 2:
> > +    {
> > +        int q;
> > +        int len =3D 0;
> > +        int vq =3D cpu->sve_max_vq;
>
> sme_max_vq.
>
> > +        int svl =3D vq * 16;
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (q =3D 0; q < vq; q++) {
>
> for (int q =3D 0
>
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
> > +        return 0;
> > +    }
>
> I think you return 8 anyway to ignore.
>
> > +    case 1:
> > +        aarch64_set_svcr(env, *(uint64_t *)buf,
>
> ldq_le_p(buf)
>
> > +            R_SVCR_SM_MASK | R_SVCR_ZA_MASK);
> > +        return 8;
> > +    case 2:
> > +        int vq, len =3D 0;
> > +        int svl =3D cpu->sve_max_vq * 16;
>
> sme_max_vq.
>
> > +        uint64_t *p =3D (uint64_t *) buf;
> > +        for (int i =3D 0; i < svl; i++) {
> > +            for (vq =3D 0; vq < cpu->sve_max_vq; vq++) {
>
> Mirror the q/vq loop from above.
>
> > +                env->za_state.za[i].d[vq * 2 + 1] =3D *p++;
> > +                env->za_state.za[i].d[vq * 2] =3D *p++;
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
> >   int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
> >   {
> >       ARMCPU *cpu =3D ARM_CPU(cs);
> > @@ -392,6 +473,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUStat=
e
> *cs, int base_reg)
> >       return &cpu->dyn_svereg_feature.desc;
> >   }
> >
> > +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg)
> > +{
> > +    ARMCPU *cpu =3D ARM_CPU(cs);
> > +    int vq =3D cpu->sve_max_vq;
>
> sme_max_vq.
>
>
> r~
>

--0000000000006bfe510639e9d131
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<br><br>Thank you for the feedback! I have sent=
 an updated version your way with the suggested changes!<br><br>Thanks,<br>=
Vacha</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">On Mon, Jul 14, 2025 at 3:41=E2=80=AFPM Richard =
Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.hende=
rson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On 7/14/25 11:43, Vacha Bhavsar wrote:<br>
&gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
&gt; index 64ee9b3b56..c39d636caa 100644<br>
&gt; --- a/target/arm/gdbstub64.c<br>
&gt; +++ b/target/arm/gdbstub64.c<br>
&gt; @@ -228,6 +228,87 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t=
 *buf, int reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +int aarch64_gdb_get_sme_reg(CPUState *cs, GByteArray *buf, int reg)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 CPUARMState *env =3D &amp;cpu-&gt;env;<br>
&gt; +=C2=A0 =C2=A0 bool streaming_mode =3D ((env-&gt;svcr &amp; 0x01) !=3D=
 0);<br>
<br>
env-&gt;svcr &amp; R_SVCR_SM_MASK, although perhaps<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (reg) {<br>
&gt; +=C2=A0 =C2=A0 /* Svg register */<br>
&gt; +=C2=A0 =C2=A0 case 0:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (streaming_mode) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D sve_vqm1_for_el_sm(e=
nv, arm_current_el(env),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0streaming_mode) + 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* svg =3D vector granules (2 * vector qu=
ardwords) in streaming mode */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, vq * 2);<br>
<br>
=C2=A0 =C2=A0 =C2=A0int vq =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0if (FIELD_EX64(env-&gt;svcr, SVCR, SM)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vq =3D ...<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
is clearer.<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(buf, env-&gt;svcr);<=
br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int q;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq =3D cpu-&gt;sve_max_vq;<br>
<br>
sme_max_vq.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D vq * 16;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (q =3D 0; q &lt; vq; q+=
+) {<br>
<br>
for (int q =3D 0<br>
<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I think you return 8 anyway to ignore.<br>
<br>
&gt; +=C2=A0 =C2=A0 case 1:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_set_svcr(env, *(uint64_t *)buf,<b=
r>
<br>
ldq_le_p(buf)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 R_SVCR_SM_MASK | R_SVCR_ZA_=
MASK);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 8;<br>
&gt; +=C2=A0 =C2=A0 case 2:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int vq, len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int svl =3D cpu-&gt;sve_max_vq * 16;<br>
<br>
sme_max_vq.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *p =3D (uint64_t *) buf;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (int i =3D 0; i &lt; svl; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (vq =3D 0; vq &lt; cpu-=
&gt;sve_max_vq; vq++) {<br>
<br>
Mirror the q/vq loop from above.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;<a hr=
ef=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank">za_state.za<=
/a>[i].d[vq * 2 + 1] =3D *p++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;<a hr=
ef=3D"http://za_state.za" rel=3D"noreferrer" target=3D"_blank">za_state.za<=
/a>[i].d[vq * 2] =3D *p++;<br>
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
&gt;=C2=A0 =C2=A0int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *bu=
f, int reg)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; @@ -392,6 +473,43 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUSta=
te *cs, int base_reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return &amp;cpu-&gt;dyn_svereg_feature.desc;=
<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +GDBFeature *arm_gen_dynamic_smereg_feature(CPUState *cs, int base_reg=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ARMCPU *cpu =3D ARM_CPU(cs);<br>
&gt; +=C2=A0 =C2=A0 int vq =3D cpu-&gt;sve_max_vq;<br>
<br>
sme_max_vq.<br>
<br>
<br>
r~<br>
</blockquote></div>

--0000000000006bfe510639e9d131--

