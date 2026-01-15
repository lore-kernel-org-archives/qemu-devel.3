Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389DCD44C66
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 15:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgP9c-0003A6-Fh; Thu, 15 Jan 2026 10:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgP9W-00037w-Qw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:20:51 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgP9T-0006EZ-Ce
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 10:20:50 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4327778df7fso610100f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 07:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768490441; x=1769095241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHz8uydIJ11f4d1TL5XFVuuKnv1AGL6eLtNdjhM5s7I=;
 b=KXuBuEfepXU1PY/5Pwzu23FYUsKYUKgTOvhDL8MqDD7MG2TeyFFzuTM3ryxwjJ1w6a
 m+PD5K2pWZZqkcWIFJgOp49URrRP8OowqWs7hzaoCauHnt0aE8Aj14xAvI//pj8W0eMD
 5juU9JoosSaxgM1WKrSObBpBnksZ8SDpG8kMUPDWtezJUNCgxq//+vjYJloN4ohcD+yu
 rQ8nkCG3JVb2CVxDTKL1+9i0HLopkkgWVD+L9POysh0m8cbvLZbboB/WQzt7zVAZyG4W
 wn3m761O+6xviKTWyRSxnQchnTWYbZXougr+yj8Ey1ZYSEOcOROIcf085Lq3+LIN5jDy
 CcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768490441; x=1769095241;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHz8uydIJ11f4d1TL5XFVuuKnv1AGL6eLtNdjhM5s7I=;
 b=jRdTunZrx67kCr1dwvbt+7LCeF4ZO1evkn1BYHSZ+3DWXTE7HENTRhnav7e9Uiu3K9
 EcizHhyc3BOBh0BsznHY6P6plMrqj1tKQgdRdIHS1ad9R573jsBH6TM2btlTKlD53w82
 rYyjgFZYGOJjlc8lJUwVvbzif+yJilCstjgQnFDwnhQTK1vrQmLVCIPMZQ6F8bDD2WhR
 RPrLC7UrTyTjouXmBsCcDfN8yu8x3/nhp/fQuaS3HQxgKMyKwomuWBzK2mACvRZDvjj3
 qecUF6WmK8mpRq4YH3clrhWpFk/EDmNRETB5fqYELv4wWaS6FMQ0fEf3H7s4Fdeen2hn
 aePg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX25cEuxzKo+mbJDNs2qR7IazPMkfssOavCBPzHQEjJc+piJfgUDsUbtAjZNEpr0FgorVxGY/grTZpe@nongnu.org
X-Gm-Message-State: AOJu0YzuYncfjbZEmzYGsWbxhoFG8/k+DcurhKJwGTOpgNvHJdy9lpGn
 HasjH/bS5nn7/uK0ZtqkngnaZztdyoL2trRqiwWwo/8D6aWTSOukAnqiGS9hRgEpDBs=
X-Gm-Gg: AY/fxX4RgGtPqsSxWudYS5lAWoDGFURAgihl7PSiS/cCsto6szvOF8c8Is6xIBetc40
 roqzdo8P57YzUlJlhiTX5olQBENo0gKedD7hn6/cSHa4u1RcLgADU03/3OQQPeGOKGeOLJRE1z9
 87lKMk/HCF3muv9AyTol4heWqreRMMfc1z1/WGvRoJWBAFtvmTC3ZmhIlL4OAOOmOwhsxZWlzVd
 TcEKgPuxB9v9shNfB+Z0s90/beXv3y1fnrlLjau6AkDXVS7jxVOcmSir2ZjNNZWLyqIIkySWbRZ
 Q9HXdXbU/jiD6wsaRoKw5UBq/fLoMPUQXK9Cj3dmDsTxJUDdn//pee4ycnfePg1OZSKx565JLNJ
 6JWYKHbsdgf0aJbcdOYnsa3axGVruvZPOPnyH7+XpnOA2dtrHQpgVtFJjbp6g//UUndS6j0Y750
 XJ7H1nf2xAYyc=
X-Received: by 2002:a5d:5d87:0:b0:432:84f9:8c04 with SMTP id
 ffacd0b85a97d-4342c501694mr8869202f8f.24.1768490440982; 
 Thu, 15 Jan 2026 07:20:40 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af64a778sm6442691f8f.3.2026.01.15.07.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 07:20:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DDBF5F88E;
 Thu, 15 Jan 2026 15:20:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 2/4] target/arm: Correctly honour HCR.TID3 for v7A cores
In-Reply-To: <CAFEAcA-YDPYQ7mny_zFjgjWc4W8K18kUVuBgFbQ25sNpsM4Vvw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 12 Jan 2026 18:51:36 +0000")
References: <20251231170858.254594-1-peter.maydell@linaro.org>
 <20251231170858.254594-3-peter.maydell@linaro.org>
 <87zf6ww9fg.fsf@draig.linaro.org>
 <CAFEAcA-YDPYQ7mny_zFjgjWc4W8K18kUVuBgFbQ25sNpsM4Vvw@mail.gmail.com>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 15:20:39 +0000
Message-ID: <87a4yej41k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 2 Jan 2026 at 11:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > The HCR.TID3 bit defines that we should trap to the hypervisor for
>> > reads to a collection of ID registers. Different architecture versions
>> > have defined this differently:
>> >
>> >  * v7A has a set of ID regs that definitely must trap:
>> >     - ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3},
>> >       ID_ISAR{0,1,2,3,4,5}, MVFR{0,1}
>> >    and somewhat vaguely says that "there is no requirement"
>> >    to trap for registers that are reserved in the ID reg space
>> >    (i.e. which RAZ and might be used for new ID regs in future)
>> >  * v8A adds to this list:
>> >     - ID_PFR2 and MVFR2 must trap
>> >     - ID_MMFR4, ID_MMFR5, ID_ISAR6, ID_DFR1 and reserved registers
>> >       in the ID reg space must trap if FEAT_FGT is implemented,
>> >       and it is IMPDEF if they trap if FEAT_FGT is not implemented
>> >
>> > In QEMU we seem to have attempted to implement this distinction
>> > (taking the "we do trap" IMPDEF choice if no FEAT_FGT), with
>> > access_aa64_tid3() always trapping on TID3 and access_aa32_tid3()
>> > trapping only if ARM_FEATURE_V8 is set.  However, we didn't apply
>> > these to the right set of registers: we use access_aa32_tid3() on all
>> > the 32-bit ID registers *except* ID_PFR2, ID_DFR1, ID_MMFR5 and the
>> > RES0 space, which means that for a v7 CPU we don't trap on a lot of
>> > registers that we should trap on, and we do trap on various things
>> > that the v7A Arm ARM says there is "no requirement" to trap on.
>> >
>> > Straighten this out by naming the access functions more clearly for
>> > their purpose, and documenting this: access_v7_tid3() is only for the
>> > fixed set of ID registers that v7A traps on HCR.TID3, and
>> > access_tid3() is for any others, including the reserved encoding
>> > spaces and any new registers we add in future.
>>
>> I'm confused by the naming - especially as searching the Arm doc site
>> with the Armv7-A filter didn't show up an HCR register (although it does
>> show up in the PDF).
>
> Not sure why it wouldn't show up -- this is the main hypervisor
> trap configuration register, and it's always been HCR for AArch32
> and HCR_EL2 for AArch64.
>
>> I guess what you are saying is these registers trap from v7a onwards?
>> v8/v9 don't change the trapping on this subset of registers.
>
> I tried to lay this out in the commit message, but basically what
> we have is that this trap bit is trapping a set of the ID registers.
> In v7A it was specified to trap the ID registers that were defined
> at that time, but not the encodings that were reserved in the
> ID register space. (As ID register space, 'reserved' means RAZ,
> not UNDEF as it would elsewhere in the system register space.)
> In v8A some new ID registers were defined in what was previously
> the reserved space, and so v8A says that TID3 must trap those also
> (and that it IMPDEF is allowed to trap the rest of the reserved space).
> Finally, FEAT_FGT fixes up the unhelpful IMPDEF variability by mandating
> trapping on the whole space, reserved or not.
>
> (Before v7A HCR didn't exist at all and these ID registers never
> trap anywhere: since HCR.TID3 in our implementation will always
> be 0 on CPUs without EL2, we don't need to special case "doesn't
> actually have Hyp mode" in the access functions.)
>
>> > -static CPAccessResult access_aa64_tid3(CPUARMState *env, const ARMCPR=
egInfo *ri,
>> > -                                       bool isread)
>> > +static CPAccessResult access_v7_tid3(CPUARMState *env, const ARMCPReg=
Info *ri,
>> > +                                     bool isread)
>> >  {
>> > +    /*
>> > +     * Trap on TID3 always. This should be used only for the fixed se=
t of
>> > +     * registers which are defined to trap on HCR.TID3 in v7A, which =
is:
>> > +     *   ID_PFR{0,1}, ID_DFR0, ID_AFR0, ID_MMFR{0,1,2,3}, ID_ISAR{0,1=
,2,3,4,5}
>> > +     * (MVFR0 and MVFR1 also trap in v7A, but this is not handled via
>> > +     * this accessfn but in check_hcr_el2_trap.)
>> > +     * Any other registers in the TID3 trap space should use access_t=
id3(),
>> > +     * so that they trap on v8 and above, but not on v7.
>> > +     */
>> >      if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3=
)) {
>> >          return CP_ACCESS_TRAP_EL2;
>> >      }
>> > @@ -5845,11 +5854,18 @@ static CPAccessResult access_aa64_tid3(CPUARMS=
tate *env, const ARMCPRegInfo *ri,
>> >      return CP_ACCESS_OK;
>> >  }
>> >
>> > -static CPAccessResult access_aa32_tid3(CPUARMState *env, const ARMCPR=
egInfo *ri,
>> > -                                       bool isread)
>> > +static CPAccessResult access_tid3(CPUARMState *env, const ARMCPRegInf=
o *ri,
>> > +                                  bool isread)
>> >  {
>> > +    /*
>> > +     * Trap on TID3, if we implement at least v8. For v8 and above
>> > +     * the ID register space is at least IMPDEF permitted to trap,
>> > +     * and must trap if FEAT_FGT is implemented. We choose to trap
>> > +     * always. Use this function for any new registers that should
>> > +     * trap on TID3.
>> > +     */
>> >      if (arm_feature(env, ARM_FEATURE_V8)) {
>> > -        return access_aa64_tid3(env, ri, isread);
>> > +        return access_v7_tid3(env, ri, isread);
>>
>> This seems even more incongruous - we test for v8 but use the v7 helper.
>
> We have two different things we want to do:
>
> (1) always trap if TID3 is set
> (2) trap if we are v8 or better and TID3 is set
>
> We want to use function 1 for the set of ID registers that
> existed back in v7A -- these are the ones that trap for any
> implementation.
> We want function 2 for the ID registers that were only defined
> in v8A, and for the reserved-ID-register space. These must not
> trap on v7A, and either must or are IMPDEF-permitted to trap
> on v8A and later.
>
> I have tried to pick function names that make sense for "what
> is this doing", and for "if somebody adds a new register here,
> make the function they want be the one with a name that seems
> most inviting, so they pick the right one, not the wrong one".
> So I have access_v7_tid3 for ID registers defined in
> v7, and access_tid3 for the rest, including any new ones.
> This seemed to me better than picking a function name that
> describes the internal implementation of functions 1 and 2,
> on the basis that people are a lot more likely to need to
> use the functions than look inside them.
>
> If you have suggested names that you think make more sense,
> I'm open to them -- since I started by knowing the behaviour
> to me the names I ended up with seem more "obvious" to me than
> they would to somebody else, and it's the "somebody else" that
> I'm trying to help with the naming...

I think I follow now. My only real suggestion would be to make the name
_v7a to be distinct from the v7m profile. Although HCR.TID3 seems to
exist for v7r as well.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Separately, the implementation of function (2) in this patch
> is "if ARM_FEATURE_V8 is set, call function (1) to do the test-TID3,
> otherwise return ACCESS_OK to indicate don't-trap". (Inherited
> from the existing implementation choice.)
>
> Given that function (1) is only a simple test of
> "((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID3))"
> we could alternatively open-code that check in function (2)
> if you think that would be clearer.
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

