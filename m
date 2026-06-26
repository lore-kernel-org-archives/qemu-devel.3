Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81A3C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBRb-0001n3-OO; Fri, 26 Jun 2026 14:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBRU-0001mX-Os
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:38:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linisha232@gmail.com>)
 id 1wdBRS-0001FY-Ok
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:38:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4926bd21aa1so9117875e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782499097; cv=none;
 d=google.com; s=arc-20260327;
 b=SaRsYcw2oOnf62Wiojx/NSd2utI1EQF6tv0N+vLvevBAg3PrekBMogMRlFhwCy8BrI
 +pgZRM84y6cEgjblWeSJWbwRzpW2QauxBdhWIyNzW7LGhVrRui1wS8iUSpJHjy0I4JBa
 BGfpZnf5n2S5Zwvh+sFSmToGnJ4jysR4C8g+KK43mG8UKbJoFLZ5pB2byFaTTH6Hmle5
 qAyWwHK5hFUUxgKO76ECPL8izs8hKvCC8QCGEDtAL2MDV4256tn7zqrAxX1k3aP3T5HH
 iMTc3F5eZdRYtqVxFd3rIhpu56TlEJtOZ+zKvBlf0gc4h7HfI2+k3GwO+0G5mmST+4Gz
 QgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0kkMFEw2tc57F4mWfViw6GxTJrqKLQ4jom9Zf4XbZxI=;
 fh=nlczIDWfQvmPi8GB7YVOQoSqcRHpLanVSZxoCjOw8ZI=;
 b=gFmI2t5wkXvHeVoW/O3kf7t6o46CANc8p6khWeoMlUDe81/eFH8iL/2y9rI9PdOElo
 z9bUsVh8ac7ThYFWfsUX7Sd3/Gw92yTwgHWyNV3z/ULilrUsVfG3dz6t5VGHFRhP/P0N
 XvRhx2Vah8MSSK3PB+u8NefUrGBVjytIYy5VfMWEDzzQ4Cbn8S/l8vvR0b/qri5b2Xcm
 ixmKlRFzNyr7s+H7QvyaBQ9AZUEDfzDbczn0xqS1ZCZi/BgBwMNQIMd5GTTB7hAGcDVL
 CGSvGF8q+bpnUe8Ics8EqjVTNT1J5gAgYZjXCG+/uZM3zJHG2qcjtEYFBFyScWNn8wTy
 cqQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782499097; x=1783103897; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kkMFEw2tc57F4mWfViw6GxTJrqKLQ4jom9Zf4XbZxI=;
 b=euyWiATuDEiCwgzswe8IBj2ZnqgKAJKlGal7d4jDGcg5nu0otYQN62FvyQwhFzL5QJ
 QJNoyaYu6ygY3hzatoApDRYoL9C+99GMK5xz+m+uNNXvtcshL0xr8iIaeNo15ECFLz/s
 ZfuB8PQxUJ/CNVCanYkrW+WFS779ZcAOMIcvjMPAmX62DQikQyDPc6TgUUDkW+hJ4X+d
 yt20ghaitXINpTBgHAZT1aDr/LmsBp6t9JKNTJFo5WWA2LFLnt1KAAPWedOM6VNCNy/u
 xnkdeKZOFJmyAsPldjnVd4HHRcNq1jFgYyiX2m4cOJ1YXxXQ3eHhox0LRDjd8mEuEX8i
 AeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499097; x=1783103897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0kkMFEw2tc57F4mWfViw6GxTJrqKLQ4jom9Zf4XbZxI=;
 b=deIovgDS8Zk2/yyY0JWP7xIk1zXfaKUy1YhJJisx8V09i8Ao9MxzK3rcjondUc4dDB
 TetOSWz2eXoWKYzEdqCoYOLXn7Lt00jmeCwY9JgtWc1JjIomaEjcnQo8h4lUvi2/og6g
 4ZlqhSa9cAoAYPP5rNfdgr+a3m1BMUC+WpsdcHEaIVX5X7kBcn1kYHu8aLsaKE92s+EM
 RC/h8jW2lnSaE8na0wfi7b9atYEAVlkEuHu0QXaIKVHBQiO4wHrwoDVHe6eNZxcwj0S6
 jtQgxSzHGIZepxlxoD7TRTaYKQo/60o24CY9KW++ltng1zsjvC51kzu2ewSWw6iE8Owq
 IVYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8T+v1dXDWcnTVZ9y8BNaBlj2CSr3C4J9/KsRM7pFEeoMqGRoKYSb28n4acfVfVXRpYD3L5VygB/jX4@nongnu.org
X-Gm-Message-State: AOJu0YwyyftRBU3Pz4qR/d1k4cSId8u/CgsA5hNIr5xjR4syFAmd3sf7
 PHLiRVzXQv3CtGQ7c1xCAVYbgiexk5PzA7OUN5ZtuXWhqByrpLiOEScNbSRw0hK/G+STe9/O3Aa
 KmrLJG0Apn4E0sZjcLpCCN5xA2voKsAY=
X-Gm-Gg: AfdE7cmiaEMQEpbLzCuCeVmLqYPTEn2uwNNnIinqsKeUA9SAYc05mCFvO4laYp1STZC
 1CQb1gHUc6gle1WE1hpj2HuscWh+qWLCZ8+wZLimXdy6exwiC9xVHmi/CqtJ2gd8Qa7e2U1u1n0
 DFWja7C4blpQWVRSqgksKomnP4gZhAplUqpX5G3GkoEfpYxLCHGicyI6ClDP0m+UYngXtqESn81
 EGF+H0Tv3x8NTp2i4O9c1Z2mfZJsxh+vxdCT+QwxxhptshPubhN47m9//8R0f703ud0AvEwwbg=
X-Received: by 2002:a05:600c:e548:20b0:490:b4e5:ce7e with SMTP id
 5b1f17b1804b1-49266883322mr87008535e9.25.1782499096633; Fri, 26 Jun 2026
 11:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <20260625192121.1887-1-linisha232@gmail.com>
 <aj5P0n03aKv93uci@redhat.com>
 <9d695c7f-bb02-44bd-8e1c-f8bdbf3bbbf7@oss.qualcomm.com>
 <CAGKMO+VCZ_3cPWx000N_+REsEK+gQg8RCWJcx7YEchUcy20V-Q@mail.gmail.com>
 <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
In-Reply-To: <c0292d61-3915-416f-a6e1-d8498dcd42e9@oss.qualcomm.com>
From: linisha <linisha232@gmail.com>
Date: Sat, 27 Jun 2026 00:08:04 +0530
X-Gm-Features: AVVi8Cc07EemioNuVyO0QV5xNfjTB5wySt0NeQ6IdMuyeYv4DFxrB_-FeAGsD1Q
Message-ID: <CAGKMO+XpdeOQwqqp6sq+q2gbGBkH-inBU0B49buohQ6OWhOxUA@mail.gmail.com>
Subject: Re: [PATCH v2] docs/system: add general note about architecture and
 machine differences
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=linisha232@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Pierrick,

You're right =E2=80=94 my tree was outdated. I just ran git pull and now
scripts/get_maintainer.pl -f docs/ does show you as maintainer for
General Documentation. Sorry for the miss; I'll make sure to pull and
re-check maintainers before sending future versions.

Best regards,
Linisha

On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 6/26/2026 10:44 AM, linisha wrote:
> > Hi Daniel, Pierrick,
> >
> > Thank you, Daniel, for the Reviewed-by tag and the wrapping feedback.
> >
> > Pierrick =E2=80=94 I didn't intentionally remove anyone. I used
> > scripts/get_maintainer.pl -f docs/ which returned Peter Maydell,
> > Philippe Mathieu-Daud=C3=A9, Richard Henderson, Alex Benn=C3=A9e, and C=
=C3=A9dric Le
> > Goater, and I picked CCs from that list along with people who
> > responded to v1. You weren't in the script's output, so I didn't know
> > to include you. Apologies for the miss =E2=80=94 I'll CC you on any fut=
ure v3.
> >
>
> Thanks for your answer.
>
> Just to dig this further, is your tree up to date?
>
> When running it on my side (from upstream/master), I get:
> $ scripts/get_maintainer.pl -f docs/
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> (maintainer:General
> Documenta...)
> qemu-devel@nongnu.org (open list:All patches CC here)
>
> > Daniel =E2=80=94 I'll send a v3 with the commit message body properly
> > line-wrapped to 76 characters. Let me know if there are other changes
> > you'd like at the same time.
> >
> > Best regards, Linisha
> >
> > On Fri, Jun 26, 2026 at 9:09=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 6/26/2026 3:09 AM, Daniel P. Berrang=C3=A9 wrote:
> >>> CC Pierrick as docs maintainer.
> >>>
> >>
> >> Thanks Daniel.
> >>
> >> I wonder how I was not in original recipients for this patch.
> >> @Linisha: did you explicitly set list of recipients, or remove some pe=
ople?
> >>
> >>> On Fri, Jun 26, 2026 at 12:51:19AM +0530, Linisha wrote:
> >>>> Add a note near the start of the introduction explaining that QEMU o=
ptions, properties, and command lines may differ between target architectur=
es and machine types. This helps prevent confusion when examples shown for =
one architecture do not work for another, such as the pflash0/pflash1 optio=
ns visible in -machine help on some machines but not others.
> >>>
> >>> Please ensure commit messages are line wrapped.
> >>>
> >>>>
> >>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >>>>
> >>>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> >>>> Signed-off-by: Linisha <linisha232@gmail.com>
> >>>> ---
> >>>>
> >>>> v2: Take a different approach based on review feedback from Daniel
> >>>>     Berrang=C3=A9 and Peter Maydell. Instead of incorrectly claiming
> >>>>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
> >>>>     machines too), add a general note near the start of the introduc=
tion
> >>>>     about how options, properties, and command lines may differ betw=
een
> >>>>     target architectures and machine types.
> >>>>
> >>>>
> >>>>  docs/system/introduction.rst | 9 +++++++++
> >>>>  1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/docs/system/introduction.rst b/docs/system/introduction=
.rst
> >>>> index bec7291e47..8d9ef61d26 100644
> >>>> --- a/docs/system/introduction.rst
> >>>> +++ b/docs/system/introduction.rst
> >>>> @@ -1,6 +1,15 @@
> >>>>  Introduction
> >>>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> +.. note::
> >>>> +   QEMU supports many different target CPU architectures and many
> >>>> +   different machine types for each architecture. Options, properti=
es,
> >>>> +   and command lines that work for one architecture or machine type
> >>>> +   will not necessarily work on another. The examples shown in this
> >>>> +   manual are specific to the architecture and machine type being
> >>>> +   demonstrated. When in doubt, consult the documentation for your
> >>>> +   specific target architecture and machine type.
> >>>> +
> >>>
> >>> Not convinced many people will read this, but I gues it doesn't
> >>> hurt.
> >>>
> >>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >>>
> >>>
> >>>>  .. _Accelerators:
> >>>>
> >>>>  Virtualisation Accelerators
> >>>> --
> >>>> 2.47.0.windows.1
> >>>>
> >>>
> >>> With regards,
> >>> Daniel
> >>
>

