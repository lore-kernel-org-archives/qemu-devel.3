Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD81606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gnWiEo+9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRo44-0008Ay-SF; Fri, 13 Nov 2026 04:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRo42-00087W-Lm
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:59:22 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRo41-0006Y5-1u
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:59:22 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67be5d0e9cbso422210d50.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794563960; cv=none;
 d=google.com; s=arc-20260327;
 b=K+E1GVqYjCuWIdPeYMbOv+OfwPGa6R/RRcnEIHwMtH7wszXiRrHETS6EtGMGrTRK/I
 YkBj1CNm5NXnTLlbSEnVqX3hGkTBrYqfbE+KP1liDn1GkIzeQ1G8POaERDZ29stmFhjW
 IEeWWXRVYQMr5G535TOIaVJelEJd2mFLq8/lazCgwykMuPk7CiPKyK9j3aL5v60uL1n5
 CcafT1tr1955gP5PaVrGLlBEXz7O8Wwpkzv6HrRrd11FItJQbgYqqCr4tLT4mgARz3SM
 6BRTpU00AV33qM77v9Exkl5C/g3UHViZVsUdtqA2xhjjJxIijUfLRhLeDG2ahmuPwrTP
 oVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A1R15BPCVezEKVROSd3Pf3UKuo0v/8TGSZKaMOdpKWA=;
 fh=9DZ0E7eVOcBqava0Ok6ru6aqk+sy3EGyqcawUxrIeog=;
 b=PyrdCqZeU5LPLn6/A2VXBjs/XZNguI/C7AbyC6ssJssWAQNtT3PTg0FM8ADE4W2Vej
 GF6h2fhbRyC2gJIqsHkYYLUFborBmnlaBPpVXEl7uN3V1CchOHHSNie2zNGSnvaYBimZ
 neBf2qraigSMUHDBG4YtQ54yWLqVB2xubcPl6tzkK6b/HLCFiiuMYA606AbafBj813pL
 Ir+BMpYAQHxTbCOpmh91PfvO+ubBQBDRxIrI8ogOhApvLNn/eHV+CHqZjCKBesk1nyB0
 QBJhYNW1vbTWZwgFICEcr6gWl1fLhlQ/5/IVZvwB3Ku0/5nrkNpbKA9Pnl5+LeAmwyBN
 ElGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794563960; x=1795168760; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A1R15BPCVezEKVROSd3Pf3UKuo0v/8TGSZKaMOdpKWA=;
 b=gnWiEo+9jAHepCsYEMssX0VMq7YwzXu5DxlIdULcnaUx4QziqTWxRd4rlCiSDgQVsp
 9k3alUgs53bce9rE6HhtV6nWYCk2mL3d04kjfN2BPvAAma9cVKpcbsaQZpEDH26Fv+Nd
 elhGb6R/W5mTRoZQQj1pITV2Qailj92jp4g2dJlaw9dj+mWQIRjSBJVSXNu99jVGMO5I
 9NsT2AP5YQlxa3omrsbNbnSTxyTZSSpOwtXhjsxcDB2uygmhawrCu8/M1ft2pYmDly23
 c44XZcY2CFYl33qa136Q6UCCH3JYrhYLNbvtIsJj+64TZbngHMzhTfwtycK54c+Sqrjf
 HWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794563960; x=1795168760;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A1R15BPCVezEKVROSd3Pf3UKuo0v/8TGSZKaMOdpKWA=;
 b=jrX9H+Eh9KJKyd4DNyrtW98CNLGo3xhb7MaF6q1PqqLTrZzFJuv81ZaUcUcdsx6Hyz
 EjD9LEC3duCkEyPRhD4+lFeM/cNBrpN/7bKhbC84gi1fOqbL6fPyyRgvR/iQySCjFrfz
 UvNTb3vEz/qRbEXlZEKDy6FpnkKlLu/6V4pjBsSjOomJ13lqeZpl/AMv0JEq0DxhxEFe
 1481Eumyo42OOMnDjXHU4blru9mzTwq9wto24hXo6RuDAV4+uqk/UAro1gDLEfhh1H+9
 F+7c/nrNSD47OE3QzDzpE30KOZOvZS91CqyWCSlxo9Y8TinYCBWBvLRtakwQH6EK+FnR
 EA5A==
X-Gm-Message-State: APuU4Z/PMi23amomt5ToH79XcQ53kuCt/vS/mMobmZCGrRaZJd0IwbNM
 zMfRN4lWpaX6cDonELsCnFteE1ZkeoE0dIQm/Gq5XLOJacf14BSt5ocFW7dK6z42u07vkNkLiBj
 TTnIOZCMlQzfusyfG2KwFaQOJCVd/E0CwRXSUF+nw8w==
X-Gm-Gg: AYBFou1JN74aB8cjPldY8+NnmfTChP6de6ayc6WacDGG4hv4y/Iy1zkL88rqXJLeKNI
 f/DcBCYV5uK+ym3mxel+RzaZCCFheE1DzdM7ZkoyQNxTuwwFeHyCKOda4ZmEglBlZPF4OsZHlWr
 98DP7EDpv++6pYZmKatrFow31KlEQysOsVqutrzEpVgev6HRBsPNlkdpNegM7bpE1zZnZosfaEK
 tzNe4uki1ksIR0cMlnId4ckLGJYiIJtgSxPil0JsIKF4kPoaU66iUVtcBLnkDUvBirUpblfjd8U
 5fbAaRNAQjqRXr/lzh+9srRjr71pZQB2R21LEfAjvMjhlctfZABk1mSraj1mq14byRrIf2VDYOt
 q9PktyzMJzdWQc/Weg1GM7KyOBmpH+1r7mMOvzDoSUIRhuEP/+xDQghHtJIl2mFWQ9VMeUqrFsD
 apyhH8BkE+MYRGvtu3rYuL
X-Received: by 2002:a53:ac8e:0:b0:675:617e:6c2b with SMTP id
 956f58d0204a3-67d896b224cmr995829d50.77.1794563959602; Fri, 13 Nov 2026
 01:59:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109142319.73878-1-philmd@oss.qualcomm.com>
 <f24b1be2-d114-4760-a7a5-e292951661e7@oss.qualcomm.com>
In-Reply-To: <f24b1be2-d114-4760-a7a5-e292951661e7@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 09:59:07 +0000
X-Gm-Features: AclHuK9cy4bEn0EetVO-IzdNownmghV9yBrnWzcMthw8JnN-B6YMpTRHcUJHOLs
Message-ID: <CAFEAcA8ub6f9D+yBnhqOG+7jTD7uz0k_8FPnRd=H7zTvWgPo1Q@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Kick the other vCPUs on SEV under TCG
 round-robin
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Lorand Marton <lorandmarton.dev@gmail.com>, 
 Ashish Anand <ashish.a6@samsung.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 07:28, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 9/11/26 15:23, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > In round-robin (single-thread) TCG, all vCPUs share one
> > host thread, so qemu_cpu_is_self() is true for every vCPU.
> >
> > The SEV helper used it to skip the kick of the issuing vCPU,
> > and so skipped it for every other vCPU too: a vCPU sleeping
> > in WFE is only woken when the RR kick timer fires.
> >
> > Compare against the issuing vCPU instead.
> >
> > Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > ---
> >   target/arm/tcg/op_helper.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> > index 6a673e5ae6e8..173dd0e5151a 100644
> > --- a/target/arm/tcg/op_helper.c
> > +++ b/target/arm/tcg/op_helper.c
> > @@ -470,11 +470,11 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
> >
> >   void HELPER(sev)(CPUARMState *env)
> >   {
> > -    CPUState *cs =3D env_cpu(env);
> > +    CPUState *self =3D env_cpu(env), *cs;
>
> While rebasing I noticed I did that 1 week before latest ARM PR
> and this conflicts with c5ec1bfad103 ("target/arm: don't pass env
> to the sev helper"), then I noticed the previous 8def1f30d5d4
> ("target/arm: hold bql when SEV sets the event_register") which is
> a distinct fix. This patch is still needed but need this to be
> squashed now:
>
>     -    CPUState *self =3D env_cpu(env), *cs;
>     +    CPUState *self =3D current_cpu, *cs;
>
> Or even simpler, check @current_cpu in place (no @self local var).

Generally speaking, I think we should avoid use of current_cpu
where we can -- it's an "action at a distance" global variable.
If this function needs the CPU pointer for the current CPU then
we should revert c5ec1bfad103 so that we pass the env pointer
to the helper function again.

thanks
-- PMM

