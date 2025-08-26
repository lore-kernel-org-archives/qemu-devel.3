Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C603CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 18:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqymb-0001LN-UA; Tue, 26 Aug 2025 14:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqyma-0001IS-1g
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:52:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1uqymO-000191-Rg
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 14:52:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QC1eoJ020705
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=85/pXZ0yJ2qwVaoSY5LUAd4y
 7GWHz0rnttOkP0YTZO4=; b=N834HX4rDOjMUra/ZGdm7A0i9dW3MI5w28EdoCpc
 pnCTZEuG4DspVWEoOvKnvc4/i3sokPg4YXlV3kDGBrFDjWr+0t/MeIuJ66NXX9Ve
 vFfcD0i3+raXn0TYEFGd9YTqsYuLCprRJRDbg0+GFeeOcu+DCCL2VnHufxL58v0X
 8D+7PiHXQ4nckvBlMMcRAGGVZKZSfdhdy4/0XXAyUk/b0CAHL9MnUyLHGMsuzdDN
 B0lQTMXQjN+TUFebwLddswFVVXv+QgmY8ljxqLGpDb8ioJkepIpPAurnAOL9bCV9
 dkSPN1MWepP+Nbu+VfkldTC527H5bnm/u45mSoZF5Jr7iQ==
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x8a3x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:52:19 +0000 (GMT)
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e95387b64f3so4186550276.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 11:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756234338; x=1756839138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=85/pXZ0yJ2qwVaoSY5LUAd4y7GWHz0rnttOkP0YTZO4=;
 b=EupXAg4IT2oVAFjw/evXkD2fITKJIpt5x3vawkr2GEN4XDF7J6njE4mJgfDJ5z5l9N
 BwZ0yNP09e+uNf55MeWEhcm2Q1SC7cBSFTx5+XCq5kykd7GKfeql+ivAZTHYDxx9oGgA
 FpoS4+RfkLtKQXMcf/n23KhKQFFdLm2Vt/qvxUdOWfjcmYffqjDO6ebmw3qGXW14dtMa
 vP4DcDSZuYAb+6Ef2KC+4430WgV+HdeL4bybg1xG9BRKzkn60G0yyxMIUPM6cAq6znqG
 uzYOhECffbnVwvm1dYW4eP2EuHrfhLvUZrVB/RGkAvy5+27coLWR1VIJTDlAmnOak9oc
 B6KQ==
X-Gm-Message-State: AOJu0YzNV7BiChYZqr0dWKv/bfMi7+P+Y+w8kkK1bSaS2eKW35EXXLHl
 dYAmGS3vL00oRQudITIK+zzLdNIZDRhobw8Cs1XI/KMR5dQfZohgUE485j939adUNufezWOke0K
 5x08UlIbhE8a9CgI3CF+udNguKeIHKANJkVSricG1X+jkMt9RWIV7q6QNeQ1kJas8kRz3+r4LaB
 8X/u52l4QbG9BxqReXXlgcSQZRHNa3aCXBDbAw2zCszhWbWA==
X-Gm-Gg: ASbGncs/3fimKKnjJ9TfrknJ2J0qTw+L9upU9M2xvGh1Dla5VU7A5OJrTuWFeEHBA86
 h04DHvYxm9wBo6Mfji/9g7BrjM7uTQsNMloHhsxUK6SvW9blVU81xFiyRQzXOrxYNIukqTnBVXQ
 25R7oao41Q0evZfoTNgdV0nyY=
X-Received: by 2002:a05:6902:5415:b0:e93:486f:b35e with SMTP id
 3f1490d57ef6-e951c3eabc8mr17969828276.44.1756234338316; 
 Tue, 26 Aug 2025 11:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZQYetQyTe6eNzQ6CPrF+RXWfP/d06IUWrGCBuZEt+Cy6b2/dZ4bRET5y+KFXcQdgMa1MqycyLmTrtljLGXB4=
X-Received: by 2002:a05:6902:5415:b0:e93:486f:b35e with SMTP id
 3f1490d57ef6-e951c3eabc8mr17969793276.44.1756234337693; Tue, 26 Aug 2025
 11:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250811193654.4012878-1-vacha.bhavsar@oss.qualcomm.com>
 <20250811193654.4012878-4-vacha.bhavsar@oss.qualcomm.com>
 <CAFEAcA9wQ8qh3Ah+QNNXY6u8ut6ZMVqaxFTvDDhvEGYrazFPsA@mail.gmail.com>
 <CAEWVDmuAkDuss-vB35dOPP-zSOZTEK4WJGfvqLQdHNG-63h51Q@mail.gmail.com>
 <CAFEAcA_BV1ThJ_2L5pDd8WQhSPKd2WKbW1eb1Owrr4YswOg9Bg@mail.gmail.com>
In-Reply-To: <CAFEAcA_BV1ThJ_2L5pDd8WQhSPKd2WKbW1eb1Owrr4YswOg9Bg@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:52:06 -0400
X-Gm-Features: Ac12FXwOshq15iM9M3taex3Ush5om9-aRFkwby-1GZWKH2j3VbZhBrvXtVMAuLQ
Message-ID: <CAEWVDms-Ttx_P6WePjsxRt-=rAmr2aLVFOZEhC4mitdypWMcxg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] target/arm: Added support for SME register
 exposure to
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d7436a063d492b53"
X-Proofpoint-ORIG-GUID: zMaLMzVC3K1r0uI5OzSc4HTsCZlOAR3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX4Vxi14V7Ki0G
 /011Oa9n/XIl2WwlqAz8QNAFV2aY/e3jjXhdSc6a9E4TLsFvvX8jRbGbL1KE8+Xk1jKopD+iDap
 nCpI1TUx0eS03ETq7H2QH3XsyxgzmHyZe1kfGw1AMWMmyr0nkqUXvG9o3IqytgOETiWPTwHOPes
 cIrQMUox7mXBwU5qy3GRCNwtnSt2/hNdKlvqgKOIIPjyrADCdGCjxRphHX23MftMpHriy/mk8yX
 q0CftNmfuM68xxmH/ivpo9iBNzDkLalxVjkdtTJ2Eqx7cA/Qq2dRoJ24nCJ3ZrL1OGcItIUEUsi
 rKW5J0DbrW/xB5ghaXiYjmAdWXlmYkPq40WmvlmKVMvkXLvDgcoQC25pxh4cLS945xMTOHQttwc
 MWHDZ3Sg
X-Proofpoint-GUID: zMaLMzVC3K1r0uI5OzSc4HTsCZlOAR3w
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ae0263 cx=c_pps
 a=5rZgxjGdQ1phXw1xqkF1vg==:117 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=MnRh-OebXABTEl0PWvMA:9 a=QEXdDO2ut3YA:10
 a=1bpXJGBOwjeF4DSuyk4A:9 a=Aa2kB7t5TC07PRbR:21 a=lqcHg5cX4UMA:10
 a=FvMT9AR2qkiEEVpopuB7:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000d7436a063d492b53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I have sent a new version of this patch series addressing
these comments.

Looking forward to your feedback.

Thanks,
Vacha

On Fri, Aug 22, 2025 at 8:27=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 21 Aug 2025 at 22:37, Vacha Bhavsar
> <vacha.bhavsar@oss.qualcomm.com> wrote:
> >
> > Hi,
> >
> > Regarding having the SME check inside the "if we have SVE" check, we
> were looking the the
> > Arm ARM, specifically the following excerpt from section A1.4:
> >
> > The architecture provides the following:
> >
> > - A general-purpose register file.
> > - A SIMD&FP register file.
> > - If FEAT_SVE or FEAT_SME is implemented, an SVE scalable vector
> register file and an
> > SVE scalable predicate register file.
> > - if FEAT_SME is implemented, the scalable ZA storage.
> >
> > Based on this, we were considering the following update to the change i=
n
> gdbstub64.c and
> > we wanted to get your input.
> >
> > if (isar_feature_aa64_sve(&cpu->isar) ||
> isar_feature_aa64_sme(&cpu->isar)) {
> >             GDBFeature *feature =3D arm_gen_dynamic_svereg_feature(cs,
> cs->gdb_num_regs);
> >             gdb_register_coprocessor(cs, aarch64_gdb_get_sve_reg,
> >                                      aarch64_gdb_set_sve_reg, feature,
> 0);
> > } else {
> >             gdb_register_coprocessor(cs, aarch64_gdb_get_fpu_reg,
> >                                      aarch64_gdb_set_fpu_reg,
> >
> gdb_find_static_feature("aarch64-fpu.xml"),
> >                                      0);
> > }
> >
> > if (isar_feature_aa64_sme(&cpu->isar)) {
> >               GDBFeature *sme_feature =3D
> arm_gen_dynamic_smereg_feature(cs,
> >                     cs->gdb_num_regs);
> >               gdb_register_coprocessor(cs, aarch64_gdb_get_sme_reg,
> >                     aarch64_gdb_set_sme_reg, sme_feature, 0);
> > }
>
> Yes, I think that will be right.
>
> thanks
> -- PMM
>

--000000000000d7436a063d492b53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I have sent a new version of this patch series =
addressing<br>these comments. <br><br>Looking forward to your feedback.<br>=
<br>Thanks,<br>Vacha</div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 22, 2025 at 8:27=E2=
=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">pete=
r.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Thu, 21 Aug 2025 at 22:37, Vacha Bhavsar<br>
&lt;<a href=3D"mailto:vacha.bhavsar@oss.qualcomm.com" target=3D"_blank">vac=
ha.bhavsar@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Regarding having the SME check inside the &quot;if we have SVE&quot; c=
heck, we were looking the the<br>
&gt; Arm ARM, specifically the following excerpt from section A1.4:<br>
&gt;<br>
&gt; The architecture provides the following:<br>
&gt;<br>
&gt; - A general-purpose register file.<br>
&gt; - A SIMD&amp;FP register file.<br>
&gt; - If FEAT_SVE or FEAT_SME is implemented, an SVE scalable vector regis=
ter file and an<br>
&gt; SVE scalable predicate register file.<br>
&gt; - if FEAT_SME is implemented, the scalable ZA storage.<br>
&gt;<br>
&gt; Based on this, we were considering the following update to the change =
in gdbstub64.c and<br>
&gt; we wanted to get your input.<br>
&gt;<br>
&gt; if (isar_feature_aa64_sve(&amp;cpu-&gt;isar) || isar_feature_aa64_sme(=
&amp;cpu-&gt;isar)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GDBFeature *feature =3D=
 arm_gen_dynamic_svereg_feature(cs, cs-&gt;gdb_num_regs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_register_coprocesso=
r(cs, aarch64_gdb_get_sve_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_gdb_=
set_sve_reg, feature, 0);<br>
&gt; } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_register_coprocesso=
r(cs, aarch64_gdb_get_fpu_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aarch64_gdb_=
set_fpu_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb_find_sta=
tic_feature(&quot;aarch64-fpu.xml&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0);<br>
&gt; }<br>
&gt;<br>
&gt; if (isar_feature_aa64_sme(&amp;cpu-&gt;isar)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GDBFeature *sme_=
feature =3D arm_gen_dynamic_smereg_feature(cs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0cs-&gt;gdb_num_regs);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gdb_register_cop=
rocessor(cs, aarch64_gdb_get_sme_reg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0aarch64_gdb_set_sme_reg, sme_feature, 0);<br>
&gt; }<br>
<br>
Yes, I think that will be right.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000d7436a063d492b53--

