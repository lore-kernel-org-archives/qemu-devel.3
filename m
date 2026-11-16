Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D03B606A33B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Gxzhy1Xf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSzxy-0003Zy-SM; Mon, 16 Nov 2026 11:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSzxw-0003Z0-C7
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:54:00 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSzxt-0007mP-Cp
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:53:59 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso665348366b.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:53:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794848035; cv=none;
 d=google.com; s=arc-20260327;
 b=WB5/XbYqMKDNdYAwYVGtJ2q+WCHg26qIER+jH3o4nAc0CS9NAI3aOSohCx78Puy2Du
 fvoVUvSEfgIj+sUPgl7gJvrw5PSuofi12NB/oOGGlIi0P8Z96wcAUroUFTvpwBDrSV4H
 MonHKoOlmA/v+4UZVpuD1p14akWDqJCxr/7i1Q25jA0bJfG1N+GMO/mGeYNq6cPr7M29
 mC/sFP+aGM+9OYdcm7UxNfdVkdFdZRCfvwNTVPp4iZwkth5jtc5zENwZL3GllleAfoPS
 xBxnQkRuB0IZPu2K2+qNatvElQWZzjX1F/DIFJaEzJog+wxXQmbnqCFH+3+dA8AKkwP2
 7dYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FT+E1Vp3Esd1Hzvo9Hu0R33v6gMoSATWy3aSdvgNj88=;
 fh=Y5g34DU/Nro91LVJ/wrzb2avUos3oDr3dpJ9v/8fCeY=;
 b=U0YejnMjZx9b9B1NSK9TEB6Z1cSf4rZu3X0CqILKaGAtmRn9ikWNxOrhRSNgStEb9Y
 shpegVvcpQRTy8vUYqpPszqjs7QpNOhIFp1gCBI5hTfybqKPT0TBb31t+kkw3neRVg6O
 VE/OJm8skxiM6/RIZXfz1tJyvb73emZBL3VIkE/dH9T1Hgl1D+j6rhp3/Ki/gC3EyrwP
 mtkHYen+b9nRvtc4VLrV6i48c5fbAufqF+gA3Bu+RBpHKQj6DDEhs9xB9Y7PIk227Neg
 ucPupM6K8zlk3qDPEuyqWVpTBklRCMezfPbZ1+HZRTR4KmSB1MjkRtQSLae11x5HTFYC
 SAwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794848035; x=1795452835; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FT+E1Vp3Esd1Hzvo9Hu0R33v6gMoSATWy3aSdvgNj88=;
 b=Gxzhy1XfH3EScoqRfM+HMTI6Q4QyCi4uSrc4W5JbJEQCfE9uVy6tfkelrxhDaqmizi
 g9sph7/Ud2n7Ukxba2jjkNb25Hy4tgvv607dIf6tCgTJScDOqj/1M5xpCCRoh76NHXVU
 diVsNdgkyII+ErWJr3jF+7LTbAFDMRYgwMpEl+655Urv3+O/uj4gmTIoTT4ZUoiykKkk
 s2wrQurgwB07ffiF9aBtDxty4ouVgbMFqYrEF7aAMhxYoAn2ISL4I3OB8wKs6Vk2HVvJ
 bg+5LkLB800eZ9tNIdRaCcvhpRKziNA7RwcVWtsA4/FhxAVjImaFUdlk+cKwzAti2tQj
 GKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794848035; x=1795452835;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FT+E1Vp3Esd1Hzvo9Hu0R33v6gMoSATWy3aSdvgNj88=;
 b=sWxCDMFt+lBJwIkY8s6I4+upM5AusbwCk++vhFVMV5TmzBSZ3rh34IhFrGVi3WwnH7
 Bze8ClYW6AZkpsuszTTM6ZRH8NwCIIVLZkCwyHawRdnVqmPx2woq3kZAqFnSwUE1OZtO
 MFiGu8t6iIoU1MfV9f0HV5p55FjCJJ8Kb3yk5VTmQlhFl1rZejWgqXn/sMmvirwCTgrd
 ipmUSUlBvSCmIjTMkeyclOHk5cWNyzH8YYBPA9UmiZJqpsEjGMfO2SXP2DrNDTlmJYen
 Kef79C/g7VNVeRytJEntEwKtndNLWAbI94niFS/CAOp26NswC5TXLwjGgKK1wzVC24Ol
 Yarg==
X-Forwarded-Encrypted: i=1;
 AL+hErHCn96V2glNsKLq1YjGWx6sai8eIZ7kXnJjkl5YRYsVFZ5bLso3adGGYt7U1VQk+O9h9dRe9eVzecM7@nongnu.org
X-Gm-Message-State: APuU4Z9Ukz2MHu3aoRAPN7b48E1E9DrSrPYja2Xg8G5BBYEL2jmHNdOL
 JdxnFimZmCbIVt93SJWv7Eh9MpJIEWTMX7nDw8DWKYff36BWnjde7hnwg4u1hDpR9kYPY6Kbqvt
 x5X2w1cvutQnCBA3VV/59S+EYEqkSzJh0GJ+9VLJW1g==
X-Gm-Gg: AYBFou02SanmjCrJ84xv37wwtNSgkEQlIsN64OCkY9AqwM3Lus7SQg7CEChAjO3N1s8
 pikbM39NChVAJiLsqEymS3/uLKohEJkLZRr+kjC2OSsY5yyyaazmQ/gW2UaGGSZtaa9gYWDhA05
 rMqp1YCi+43kWAbo78a4bBACqXR6FoKgpfwUfdR+8Fe5FVk/4uY49yENLDdtRo80cFo+Q4GRGpq
 NKMh85bv+MzOpF17I4XZWYz03LNtHMwrQdGdJZM9V584mMFO6JUhrHElW7Ym3vZ7RGbcm3PZ5Oj
 Csq1YZYPBzQIji2Y8SiQ3KNsWgZRjQZJeJ+XCZfJEXox44jPbe18sb+04CicKlrip3Eu8/YKFe/
 Iuu/IORnGf+BAPWQWqyUpUxGjOj7HrnqJcOG8kNk2qu7GEL1Uc+NWnd7MF+z6akkEvHwDlJrKaQ
 kF46SF6b2xbaXre04AIslu
X-Received: by 2002:a17:907:3e11:b0:c2d:bf61:24d1 with SMTP id
 a640c23a62f3a-c5096199b77mr1022110666b.1.1794848035161; Mon, 16 Nov 2026
 08:53:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
 <9b64d3d9-736d-4878-80d7-4caa75eee778@linaro.org>
 <CAFEAcA8La+8TqFY0yCxRsXY2Ad9MA5Uu-sVEbysExZPkUXVawg@mail.gmail.com>
 <ccfcea11-ada8-4753-a71f-f59ed1bcb067@oss.qualcomm.com>
 <CAFEAcA9FE_dTUo5s2g7DMw9-ZhbjBUOfF0RJxdT7gMwm-rYuGQ@mail.gmail.com>
 <558f35d3-5a10-4652-8af4-4a88f382ca3d@oss.qualcomm.com>
In-Reply-To: <558f35d3-5a10-4652-8af4-4a88f382ca3d@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 16:53:41 +0000
X-Gm-Features: AclHuK9q24K3FKH_3KXHIk_yRqiPKQ5lWqYWByzl4UcmlwuWl7WvzEyDrzaqkK4
Message-ID: <CAFEAcA_gBzv7URWJNjXwjUbKOJuRQ=bd1NS9enpU_AW_tCZzvg@mail.gmail.com>
Subject: Re: [PATCH-for-12.0 v2 00/12] linux-user/aarch64: Support both
 endianness at runtime
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 devel@lists.libvirt.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 16:31, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/16/2026 2:00 AM, Peter Maydell wrote:
> > On Mon, 16 Nov 2026 at 08:53, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> On 13/11/26 19:55, Peter Maydell wrote:
> >>> As a more general question, is this something we would want
> >>> for architectures where both endiannesses are relevant (e.g.
> >>> mips, ppc64)? At the moment we consistently for all targets
> >>> handle big vs little endian as "it's a separate target with
> >>> its own executable". That's convenient because you can at
> >>> compile time hardwire in things like variations in struct
> >>> layout between the two. We could switch to doing that kind
> >>> of thing at runtime, but what is the benefit we're aiming
> >>> for by doing that?
> >>
> >> I did the other conversions (Microblaze, Xtensa, PPC, MIPS, SH4)
> >> and wanted to test the water first where this would get more attention=
,
> >> with the series involving less changes.
> >>
> >> My motivation is MIPS where we currently have 6 binaries and I'd like
> >> to add binaries to cover more ABIs without having a combinatory
> >> explosion and have 18 linux-user MIPS binaries. With this approach I
> >> reduced the current MIPS set to 3 binaries and add 2 more, ending with
> >> 5 covering more ABIs instead of currently 6.
> >>
> >> In order to get there I need the few core changes introduced in this
> >> series, which affect all user binaries. I have the idea ARM users are
> >> the first ones interested by no performance change thus is where
> >> I started the benchmark to prove this approach have no impact in emula=
tion.
> >>
> >> The TargetInfo structure change (one initializer LTO-protected and
> >> all accessors via read-only exposed structure) is also what Richard
> >> was very keen to have (page size support planned) instead of the
> >> current approach.
> >>
> >> I'm thus returning the question as: why would we not want to do this?
> >
> > Mostly because what we have today works, and the idea of "the
> > target ABI is known at compile-time" is quite deeply embedded in the
> > way the linux-user code is written (both in terms of ifdefs and
> > also C types being defined appropriately for one specific ABI).
> >
>
> The last part is what we had for system mode, and precisely what we have
> been able to eliminate while working on the single-binary.

Yes, but it's taken a lot of work to get to that point. For
system mode we had some clear reasons why that work was
necessary and worthwhile. For user-mode it's less clear to me.
Keeping the zoo of MIPS ABIs under control seems the most
promising reason.

For aarch64 in particular I would prefer to deprecate-and-drop
big-endian support (probably starting with the deprecation for
12.0, rather than pushing it into 11.2), since the kernel just
did that in 7.4.

thanks
-- PMM

