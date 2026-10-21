Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D28606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=niWQIl6m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJf0j-0000bV-If; Wed, 21 Oct 2026 18:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJf0h-0000bF-B3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:42:15 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJf0f-0002Rh-L1
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:42:15 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso1924495a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792622532; cv=none;
 d=google.com; s=arc-20260327;
 b=VoP1nNjjofAOGubaZFZaPTgSGaUHddCDKrCPAyTMJfboUAeTYkqS1PVbny75HMj/XB
 Ev0flEsd2cL2HkCN5mVZhtHLVnoM7MoXF/BiYZO53x8+PMUn5vE8ApNtPUB3K7pQG48N
 z/7j6JtrMFierEMyzoQy2eROLIDb0py7MXDRHJbQ1GHCDtis9/8fOUY3ZcmXRWXqQkB6
 9wdwMHo/eN9AlFUghQ2WlYJzaKeQYP5MvZ6Y+AB46aZrWkQ0DS+/3rEl67Rv9J1KPhAT
 qncPmM8VnGxPOliAE54ZOFYFr1J002Mm63q5ycMydo96PkKD48F9N+iEu6S3UZcrSrH1
 fxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Q6j+GlQCjoSgPggS+iPVGh4jnsHs4DjT1Idf/sSP07c=;
 fh=8H62a63nbPyENZDqgrXug6R7l7UVEnrjvEENi5W5aPc=;
 b=ivquvg7jB2SwQgcQds7YiI8Nvo7ft4u4IwZQw147sl2GzhiXHnB3UfU3eMlsSJP01j
 c1VsGlvN+ZsEUxsn+VN9TCWTm0OWulL0FzmFO3F7SOrTVVeS/HQGf85u1EikGinUr7GE
 o25Y8RetbVO0jCWgcmPjd4jrOvnUHBLKyKxWlGtEMPmLAkDtA5xTVZPEbZYurei+zlqv
 EiUmzs2ivKxmnGRFkcdW4IDD32MqcvlIMLnwZk3Ps5+paifk5jhROK5UQTmeWDKWAD4E
 3sedr2AofVTwQyjxge8FOAvgNERMB9Z5JQikgGfj9WtaQ8oNMAsHPVwNcu3rZFVMjQgy
 5nFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792622532; x=1793227332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Q6j+GlQCjoSgPggS+iPVGh4jnsHs4DjT1Idf/sSP07c=;
 b=niWQIl6mh+3SdFj2q4tBj1CO0hf467zsu4xxxl2lbgz85HAeOEZy4D7hzYycdKRQVV
 hT0DTD0TFNMPZ8Oh9dNJyEc3EWX5W2Ak6pWt9OM7IxT1Sewd8pzyln0f4N2OaUHtgfPa
 AqrbCWco04Sc0YfhznlBIEvHt+ZMeOvPKK5k8SkAU8E3oq5OMijw8Cn5LBBojw2iug3A
 aBFcC59tGXwIIXMLA43HfDphh0sdkOL/U0bKhU9GdnkF3d+Q/k0aRl33IXaMmGSpzg36
 7obOrdDGlMtfMLd+gmei/H8Ky6Mff8b4/1BgsEbTIkC84w/y5dZQVUaTFvONTrzg46hv
 pPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792622532; x=1793227332;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q6j+GlQCjoSgPggS+iPVGh4jnsHs4DjT1Idf/sSP07c=;
 b=QtTKFQrmM0zuMuWWg2FTUI9v+w69xYk8YUThgxuOMyebZAC8O7SHvEYNDgLgt+9nVk
 FhyfiCgp26b5F1Q2G9gPP4m1G6RI/JILgtkpEgkcVrfcK3t5vhJoq45uuCg4pecPFNc2
 EE69FmOktWt/fH47La5c/GTyUJWGhxE6ym7AVGEcTXAyC/GTTRa0cL4CjyNMe4FAgkKp
 0yetGiSUzv+JZmIrl1/Z3JDvLno2qZZBCZVPB5ROQ8+1PrIIDhYAM8V1zxsSx77XMNOd
 +HUnZ1TNgxfotATRkFFf6Xx5uUtMjqtoUE0rz/TkY/143d66pPePwfQfccsYHsPKAAw8
 zOrQ==
X-Gm-Message-State: AFq9FYKpImHNNvfGvZhqvUQSxqZ8/Y6K42PfjG3Mkk29PpbnhNWqDaVa
 lTcb/UTNwgmdAscsCbgInv9+c7jKL5V4Td98/8igRmmmLFhKSAlWl3vD52BtzydLqB/HeZrMuNP
 TP64H10NYOE7urDKJGp7jCt98M5sxBkw=
X-Gm-Gg: AYBFou2XFeuJmtB7Aq79RAT4tHwOngqv8wisz1CTlZ+q0E9Nk8XLTvAhtGMaNo0/OkL
 IxkmTwneoMrXzarOWIX6DchEbv77WtL5utPf9SSn9OO4GIXYzLolLhpsoGHcizBPuFisg5F3UqR
 rzPv9jsPziF49H/XByTr9Qr1QxnpCnuguXeSPIA1tZFOj0bG3jctlO69uF1Wy3YuQFSAy4R/x8j
 0+r2EVtxdsc8OcpNAQTj4nT1Hl0bPVU8PBg6QfGFEMrzVgZhkd1MvoTpDC6CYe1qoYrXfVyl7lZ
 wNTFrA7lYSWwf7wharQZ4L0fVjI1nTsrXOqt9UuQgpSHIr22Dhk5a4PQeSurlKwAaJkUAhRS5R0
 8GAJXG29YImB8QTRAFYUHKzwIb8BTrYKQHnAU
X-Received: by 2002:a05:6402:1942:b0:6af:a566:6f13 with SMTP id
 4fb4d7f45d1cf-6b408efd01cmr2400343a12.44.1792622531840; Wed, 21 Oct 2026
 15:42:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
 <20261021181244.867840-2-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_78JWfKfs+5ek=6E50gjGpeRsoVe1meu=gi7FunKcjAw@mail.gmail.com>
 <e5c61cec-24eb-49a5-b9df-81cf4072635d@oss.qualcomm.com>
In-Reply-To: <e5c61cec-24eb-49a5-b9df-81cf4072635d@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 22 Oct 2026 06:41:58 +0800
X-Gm-Features: AclHuK_b4u1-oLMfmM5HFO3YGjZpHRA_ahp3Y1pN_CgYYp31p6fGj2gaihK9OjU
Message-ID: <CAE2XoE-=z5NMAJ3+raj6G7tY2Mmv0=K3w5i8jPjvMmxo6eS-WQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/21] target-info: add target_heterogeneous
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x533.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 6:02=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/21/2026 2:53 PM, Yonggang Luo wrote:
> > On Thu, Oct 22, 2026 at 2:14=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> For now, this function strictly returns false. We'll turn it to true
> >> once heterogeneous emulation in supported. Meanwhile, we can use this =
to
> >> add various checks and asserts over the codebase as reminders about wh=
at
> >> we'll need to modify.
> >>
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Reviewed-by: Anton Johansson <anjo@rev.ng>
> >> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> >> ---
> >>  include/qemu/target-info.h | 8 ++++++++
> >>  target-info.c              | 6 ++++++
> >>  2 files changed, 14 insertions(+)
> >>
> >> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> >> index 862097c6c63..923c00c917c 100644
> >> --- a/include/qemu/target-info.h
> >> +++ b/include/qemu/target-info.h
> >> @@ -42,6 +42,14 @@ const char *target_cpu_type(void);
> >>   */
> >>  bool target_big_endian(void);
> >>
> >> +/**
> >> + * target_heterogeneous:
> >> + *
> >> + * Returns true if current binary has support for running several tar=
get
> >> + * architectures at once (heterogeneous emulation).
> >> + */
> >> +bool target_heterogeneous(void);
> >> +
> >>  /**
> >>   * target_base_arm:
> >>   *
> >> diff --git a/target-info.c b/target-info.c
> >> index 254530d8ea5..b8a4a7ebf7a 100644
> >> --- a/target-info.c
> >> +++ b/target-info.c
> >> @@ -42,6 +42,12 @@ bool target_big_endian(void)
> >>      return target_endian_mode() =3D=3D ENDIAN_MODE_BIG;
> >>  }
> >>
> >> +bool target_heterogeneous(void)
> >> +{
> >> +    /* For now, we only run a single target at a time */
> >> +    return false;
> >> +}
> >
> > How about place this in stubs/target_heterogeneous.c
> > So when do multi-target tests, we can override it with
> >
> > bool target_heterogeneous(void)
> > {
> >     /* For now, we only run a single target at a time */
> >     return true;
> > }
> >
>
> At the moment, even though multiple targets might be supported for the
> same binary, we still run only a single one at a time (same in
> single-binary), so this function will return false until this changes.
>
> Why would we want to override it today?

Just for less changes in future, this does not mean this patch is not valid=
,
at least it gives an API that I can use later.

I did something similar to get the single-binary qemu-system working.
And I named it as target_combined_binary(), I think they can act the
same function.

https://lore.kernel.org/qemu-devel/20261014094224.1976-2-luoyonggang@gmail.=
com/

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

