Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4ADC54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 03:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfWih-0003Q4-St; Wed, 28 Feb 2024 22:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rfWig-0003Os-9r; Wed, 28 Feb 2024 22:04:26 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rfWie-0007mq-4h; Wed, 28 Feb 2024 22:04:25 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dcc7f4717fso4673665ad.0; 
 Wed, 28 Feb 2024 19:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709175862; x=1709780662; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVJmrM3UVdJnTK2hnM/hyWTpawMJjSRsnIXoSYfI/TQ=;
 b=VY/kk6p07frQhmERO5qCptzatg/wg7YeI4KmwBTll/bzYKQ4aecA4xEWPB86LeRFNT
 0zxw0HAE79gtahthedR9wpK6hg+m0yb3XRQEkJoQLIw1VzDN/DRvH5caI6RVwZEBktE2
 UjkhA9lsRRtWq43xtyUoLMW9J7o3CAXo/WgiFSyzN+TtRM1RmQd7g3YNsmnrWzs3WjyK
 f3lLGDCL4sjNJnqTGnv6Ax0fgOPr06uAlOkLV9tJBraR45L/0q8ZUsUq0uzybwmQAqPs
 AU5NqX8N2hcE+/TsvPVdJ5Ljhm4UG4pVAmCOUHtZWqugG/lz4yeLi+BNl/wbFzgchkK9
 qh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709175862; x=1709780662;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nVJmrM3UVdJnTK2hnM/hyWTpawMJjSRsnIXoSYfI/TQ=;
 b=iFwsevFT3HQ53j/cx1yGsfweohyy3DmLo52RNO/oPvLBTIg6XKY4UBRdhhjLRBDdX6
 RLS0jThO4wY1HwAYxCk+63oj//QB/ixAJ4NmhLKKgWRFt7bvJ8AIKHBNLSBANzYSx5nt
 AdnuZUswIzM7iFYpF6Ivhfc020OUYg1giqAn9bnQ9Zc6SjSqMYSM3htYDKaO0MCVgJxn
 FhhOBaesBSqJpseXmDuCCEJrdo8wEvWpx0V28NMdFD1RuEkjjmPSF+Wezoz8muxCHD9G
 Eqzs24EDvWE3UC+dFRX4o38XdpOn76jU+0ONEpfgy1q4/6WBpKuJOgixP2YZlBMX7a82
 JZNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd6PxeJikFxPXJX22qCpFvK77HH+GMgs35inshXGOXyWLzatgotfGsRYo8bqrXmqTbz1P6gyL33WIhu2opyawDjY3f
X-Gm-Message-State: AOJu0Yxa7jNB8nj9uizNGB5fZ2JSS3pBpj68Uk97SQaAjxKEFibv2sq9
 7na/4kQnRANenC7v58u0zNOJTj/ZsjSXHmv/yrtqNdTfYMa18jgP
X-Google-Smtp-Source: AGHT+IEiYImtOHtjGSK9M/oS2o036pGmQRhiuut1Pf/D8DgrhTejwAK/9Ky+4KN5ictrYABball+Qw==
X-Received: by 2002:a17:902:e546:b0:1db:be98:e9a with SMTP id
 n6-20020a170902e54600b001dbbe980e9amr1157821plf.26.1709175861571; 
 Wed, 28 Feb 2024 19:04:21 -0800 (PST)
Received: from localhost (220-235-220-130.tpgi.com.au. [220.235.220.130])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170902650600b001dbb0348733sm194094plk.67.2024.02.28.19.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 19:04:20 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 13:04:16 +1000
Message-Id: <CZH89WQ98O1R.2TJ4GB7EWZ1Q8@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v7 02/10] target/ppc: Readability improvements in
 exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.15.2
References: <cover.1709045654.git.balaton@eik.bme.hu>
 <a06f6259d7a37aa88145fb13e4bce153ff763f86.1709045654.git.balaton@eik.bme.hu>
 <CAFEAcA_6R2wLaLOoOBQ0-Z_QydAEgxANmNPdKaAF=iiroFEhmA@mail.gmail.com>
 <ab46d0f9-19cc-bb34-2a8e-0c4d3d8592ea@eik.bme.hu>
 <7ad2aec9-1631-6350-869f-f5f97ae97096@eik.bme.hu>
In-Reply-To: <7ad2aec9-1631-6350-869f-f5f97ae97096@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Feb 28, 2024 at 6:24 AM AEST, BALATON Zoltan wrote:
> On Tue, 27 Feb 2024, BALATON Zoltan wrote:
> > On Tue, 27 Feb 2024, Peter Maydell wrote:
> >> On Tue, 27 Feb 2024 at 15:10, BALATON Zoltan <balaton@eik.bme.hu> wrot=
e:
> >>>=20
> >>> Improve readability by shortening some long comments, removing
> >>> comments that state the obvious and dropping some empty lines so they
> >>> don't distract when reading the code.
> >>>=20
> >>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> >>=20
> >>=20
> >>> -    /*
> >>> -     * new interrupt handler msr preserves existing ME unless
> >>> -     * explicitly overridden.
> >>> -     */
> >>> +    /* new interrupt handler msr preserves ME unless explicitly over=
riden=20
> >>> */
> >>=20
> >> Minor typo introduced here: should be "overridden".
> >>
> >>>      new_msr =3D env->msr & (((target_ulong)1 << MSR_ME));
> >>=20
> >>> @@ -575,16 +558,10 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, i=
nt=20
> >>> excp)
> >>>      /* new srr1 value excluding must-be-zero bits */
> >>>      msr =3D env->msr & ~0x783f0000ULL;
> >>>=20
> >>> -    /*
> >>> -     * new interrupt handler msr preserves existing ME unless
> >>> -     * explicitly overridden
> >>> -     */
> >>> +    /* new interrupt handler msr preserves ME unless explicitly over=
riden=20
> >>> */
> >>=20
> >> Ditto, and similarly for other instances later in the patch.
> >
> > Huh, sorry, don't know how I've lost that letter. It also seems that th=
e last=20
> > patch gone missing from the series somehow so if it does not turn up, I=
 can=20
> > resend it with these fixed.
>
> As the last patch did not turn up I've resent just that to complete this=
=20
> v7 series. Do I need to send v8 or if these typos are the only change=20
> needed maybe they could be fixed up during merge.

I should be okay to do it.

Thanks,
Nick

