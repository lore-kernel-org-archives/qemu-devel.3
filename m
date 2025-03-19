Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DF6C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwRj-0005yO-Fy; Wed, 19 Mar 2025 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwRg-0005oB-Q6
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:39:08 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwRe-0007Br-DE
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:39:08 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c3bf231660so71572285a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742402345; x=1743007145; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pOlVG3QVuWvTYgxjVrtWxOjNs/Z/NX2fcq5F1+B1IEs=;
 b=h+df8Qx06/0DZL1hYzTE+pY6OWHCEIOh47uoLzEzSv+4M9CvxCISxyX96OlZTjct9G
 KbQ574t7bN+t/6zWJkIfdMMIws/bTHEu9SZ+d8RySKVivEcIOl+6BLO51odRkFCNpfch
 wvr+JNKB8fI45vv3u2+JDA+3SACpQLJKaHLkxIAaiJGnXV5bx1Z7fm6kMNwRtwNEs1ex
 RNbSuqac5aGrEranN/Wyq28OmymuFnUmMLHJNvf6ieNPAHpNTDsaXVoJjeMChTPLGA/J
 yDoEahI0XutC6niKO03MzyhJsPv85+AbDMhfSvNm+ccpodCK5Fp1i73d7D9GF8lqpm0O
 zimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402345; x=1743007145;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOlVG3QVuWvTYgxjVrtWxOjNs/Z/NX2fcq5F1+B1IEs=;
 b=ny1rYSu2x4vcuxal61R+92Z7Isd5q69uXMn9zvAFC22A/eTVHSfHlqJEFwJn4dOr+E
 PKFdLBt6IAqjTxvDhrHvjdQsrRhyy4HEwlSBrMaYl/GBLu4uI2PA4v++EZbrTZlLwF5H
 B9YB5BUcx0PCh6Ssw2gQqprxDrehb5xP306kCR1rO2UgheNYhrcv9JJcwpYKybJFt87m
 s4kwFA2CZt310V32+fLffT3hgLwd4hQPdAzONZkxON5x+MZTS9ovC7i2FKtrHcCkTINB
 5SuUHCWU6oo9H2J5yTfmx2XzQUgG9duAURqkX9ILWdJscBUpTMOxjK5pnfrEYJTUgWBF
 PZ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc85eimK/VgKfLQOiF5WWSxQeeJbJztdhsJjo1mwrySA54IgBJzISLkpPbzxfdHFYdwgOZbsqMlJTv@nongnu.org
X-Gm-Message-State: AOJu0YxJnXRIBTsJXgPYKvV+9fKZRqhuEXyqLbz40ZBFhItWgA9B24X/
 JjhvALlaBKySiH76yp9uMrUoel33A8eW1GB3AagzksxoJ2KHYgTc
X-Gm-Gg: ASbGncslhTvla+fclwwBFYCvw2qrvC7a+wqBfYn12FmYadw8rkVTY1d+Dz85fAco2AQ
 Ow+naxGVqi1bgUg5Ws93kn/5btvc16K0bCR4+KFwJEtt3SHuQ+19AxS8XwJEjInRUjp89xYuLLj
 15v8Kj66YidZOwGK3m+o+7UDJBshYl9qIl49INj19qfkgkG0Q3O7JiPYXD9z7k2SRb1BmhyCK5E
 5ABb2HjMAL0m/kjz3DvlcHsB0BhKMEkgm3U+N2pgOWOXnU9icAqK4ymzu4ejVvnOujhmz+cSvy5
 w1doXsHwCxjiX3vtukKEnvVcglsm9H16m9KynL2yoenH1XgaW+WkSmylMgHOIw==
X-Google-Smtp-Source: AGHT+IHatgoVrq15aWGkHCCD9YojcxroLuOd+7uWEPokjVCNBnhJpd8VX+V0ItQoiBKMkflafwvAGw==
X-Received: by 2002:a05:620a:19a5:b0:7c5:674c:eec9 with SMTP id
 af79cd13be357-7c5a83ca85bmr355055185a.28.1742402345010; 
 Wed, 19 Mar 2025 09:39:05 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c518d9sm877398685a.24.2025.03.19.09.39.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:39:04 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
 "'Sid Manning'" <sidneym@quicinc.com>, <qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>, <ale@rev.ng>,
 <anjo@rev.ng>, "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>,
 <alex.bennee@linaro.org>,
 "'Mark Burton \(QUIC\)'" <quic_mburton@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-6-brian.cain@oss.qualcomm.com>
 <017101db9763$41ae4ca0$c50ae5e0$@gmail.com>
 <IA0PR02MB94862E1C5171AC300C64DA1CBEDE2@IA0PR02MB9486.namprd02.prod.outlook.com>
 <026201db9839$f4bb6040$de3220c0$@gmail.com>
 <2712e0cb-72a3-4c39-82a4-4b5f6d4914b0@oss.qualcomm.com>
In-Reply-To: <2712e0cb-72a3-4c39-82a4-4b5f6d4914b0@oss.qualcomm.com>
Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
Date: Wed, 19 Mar 2025 11:39:02 -0500
Message-ID: <02ae01db98ed$6d15add0$47410970$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQH/in6LAfNOq9wCQ290DAHwX4r+AkaHTwOysb9PYA==
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Tuesday, March 18, 2025 6:47 PM
> To: ltaylorsimpson@gmail.com; 'Sid Manning' <sidneym@quicinc.com>;
> qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org; 'Matheus =
Bernardino
> (QUIC)' <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; 'Marco
> Liebel (QUIC)' <quic_mliebel@quicinc.com>; alex.bennee@linaro.org; =
'Mark
> Burton (QUIC)' <quic_mburton@quicinc.com>; 'Brian Cain'
> <bcain@quicinc.com>
> Subject: Re: [PATCH 05/39] target/hexagon: Implement modify SSR
>=20
>=20
> On 3/18/2025 2:14 PM, ltaylorsimpson@gmail.com wrote:
> >
> >> -----Original Message-----
> >> From: Sid Manning <sidneym@quicinc.com>
> >> Sent: Tuesday, March 18, 2025 1:34 PM
> >> To: ltaylorsimpson@gmail.com; 'Brian Cain'
> >> <brian.cain@oss.qualcomm.com>; qemu-devel@nongnu.org
> >> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus
> >> Bernardino
> >> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng; Marco
> >> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org;
> >> Mark Burton (QUIC) <quic_mburton@quicinc.com>; Brian Cain
> >> <bcain@quicinc.com>
> >> Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> >>> Sent: Monday, March 17, 2025 12:37 PM
> >>> To: 'Brian Cain' <brian.cain@oss.qualcomm.com>; qemu-
> >> devel@nongnu.org
> >>> Cc: richard.henderson@linaro.org; philmd@linaro.org; Matheus
> >>> Bernardino
> >>> (QUIC) <quic_mathbern@quicinc.com>; ale@rev.ng; anjo@rev.ng;
> Marco
> >>> Liebel (QUIC) <quic_mliebel@quicinc.com>; alex.bennee@linaro.org;
> >>> Mark Burton (QUIC) <quic_mburton@quicinc.com>; Sid Manning
> >>> <sidneym@quicinc.com>; Brian Cain <bcain@quicinc.com>
> >>> Subject: RE: [PATCH 05/39] target/hexagon: Implement modify SSR
> >>>
> >>>> -----Original Message-----
> >>>> From: Brian Cain <brian.cain@oss.qualcomm.com>
> >>>> Sent: Friday, February 28, 2025 11:28 PM
> >>>> To: qemu-devel@nongnu.org
> >>>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> >>>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng;
> >>> anjo@rev.ng;
> >>>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> >>>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> >>> sidneym@quicinc.com;
> >>>> Brian Cain <bcain@quicinc.com>
> >>>> Subject: [PATCH 05/39] target/hexagon: Implement modify SSR
> >>>>
> >>>> From: Brian Cain <bcain@quicinc.com>
> >>>>
> >>>> The per-vCPU System Status Register controls many modal behaviors
> >>>> of the system architecture.  When the SSR is updated, we trigger
> >>>> the necessary effects for interrupts, privilege/MMU, and HVX
> >>>> context
> >>> mapping.
> >>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> >>>> ---
> >>> What does SSR_XE indicate?
> >> [Sid Manning]
> >> If SSR:XE isn't set this thread doesn't have the coproc enabled so
> >> discard additional checking.  Any coproc insn issued when ssr:xe is =
0
> >> will trigger a, "Illegal execution of coprocessor instruction." =
error.
> >
> >
> >>>> +    if (old_XA !=3D new_XA) {
> >>>> +        int old_unit =3D parse_context_idx(env, old_XA);
> >>>> +        int new_unit =3D parse_context_idx(env, new_XA);
> >>> Check that old_unit !=3D new_unit.  Per the table above, different =
XA
> >>> values can point to the same unit.  For example, if
> >>> cpu->hvx_contexts is 2, the
> >> XA=3D0
> >>> and XA=3D2 both point to context 0.
> >>>
> >>>> +
> >>>> +        /* Ownership exchange */
> >>>> +        memcpy(VRegs[old_unit], env->VRegs, sizeof(env->VRegs));
> >>>> +        memcpy(QRegs[old_unit], env->QRegs, sizeof(env->QRegs));
> >>>> +        memcpy(env->VRegs, VRegs[new_unit], sizeof(env->VRegs));
> >>>> +        memcpy(env->QRegs, QRegs[new_unit], sizeof(env->QRegs));
> >>> What does the hardware do?  Does it clear the context, or is that
> >>> the OS'es job?
> >> Nothing would keep a single htid from taking hvx unit 0, doing some =
hvx-
> ops
> >> , swapping to hvx unit 1 doing some more hvx-ops and so on.   We =
are
> doing
> >> this because each thread has a private copy of the hvx register
> >> state.  Since HVX units and threads are independent if one thread
> >> changes its ownership from HVX context 0 to HVX context 1 we have =
to
> >> do this copy.  Instead of memcpy should create a new object that
> >> represents the HVX units available and change env->VRegs/QRegs to
> point to the one currently owned.
> >>
> >> Refactoring this will be an improvement.
> >>
> >>
> >>> If the hardware leaves the context alone, the above should be
> >>> 1) Copy env->{VQ}Regs to old_unit
> >>> 2) Copy new_unit to env->{VQ}Regs
> >>>
> >>> Should you check SSR_EX before doing these copies?
> >>>
> >>> Do you need to do anything when SSR_EX changes?
> >> I think you mean SSR:XE before doing the copies.  I think we have =
to
> >> do the copy here regardless of ssr:xe since a thread could swap
> >> ownership, update ssr:xa, without explicitly having ssr:xe set.
> >> Maybe the OS disables SSR:XE while changing hvx unit ownership?
> > Correct.  I meant SSR:XE.
> >
> > Some refactoring is in order but need to understand the HW behavior =
more
> specifically.
> > - What will the HW do if more than one thread claims ownership of =
the
> same HVX context?
> > - What happens if a thread claims ownership without setting SSR:XE =
and
> then sets SSR:XE later?
> > - What about this example?
> >      1) Thread 0 claims context 1 and sets SSR:XE
> >      2) Thread 0 does some HVX computation
> >      3) Thread 0 is done with HVX for now so clears SSR:XE
> >      4) Thread 1 claims context 1 and sets SSR:XE, does some work, =
then
> clears SSR:XE
> >      5) Thread 0 wants to do more HVX, so it sets SSR:XE (still
> > pointing to HVX context 1)
> >
> > We should keep the copies for the contexts and local copies inside
> CPUHexagonState.  This makes TCG generation easier as well as having
> common code between system mode and linux-user mode.
>=20
> Good point that linux-user will need their own exclusive HVX context. =
But it
> doesn't sound right to me to have CPU state store both the system =
contexts
> *and* a local context for system emulation.  Our current design under
> review is better than that IMO.  Once we have some experience modeling
> the system registers as an independent QEMU Object, I think we'll be =
better
> prepared to model the HVX contexts similarly.  Ideally we can remap =
these
> via something along the lines of "object_property_set_link()" when the
> contexts change, without requiring any copies.  And ideally the =
existing TCG
> should work as-is, despite the remappable register files.
>=20
> "What happens when ... " - multiple threads picking the same context =
is
> almost certainly explicitly or implicitly undefined architectural =
behavior, so
> whatever QEMU does should be appropriate.  However, we'll talk to the
> architecture team and get a definitive answer.

I caution against putting a level of indirection into CPUHexagonState =
for the HVX registers.  The HVX TCG implementation relies on an offset =
from the start of CPUHexagonState to identify the operands.  This would =
be a very significant rewrite if it's even possible.  I don't know if =
TCG's gvec code generation can handle random pointers or a level of =
indirection.

If the behavior is undefined, we can avoid the copies.  Then we just =
need some bookkeeping to check if multiple threads try to claim the same =
context (if that behavior is defined).  If copies are needed, we could =
keep the  hardware contexts as shared a shared resource.  Another =
alternative would be to track the current owner of a context and copy =
from the previous owner's {VQ}Regs to the new owners {VQ}Regs.

Thanks,
Taylor




