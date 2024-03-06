Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0221C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhisq-0004oQ-H3; Tue, 05 Mar 2024 23:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhiso-0004o8-Fe; Tue, 05 Mar 2024 23:27:58 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhisn-0000O3-0B; Tue, 05 Mar 2024 23:27:58 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4d36196a7f7so1158532e0c.2; 
 Tue, 05 Mar 2024 20:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709699274; x=1710304074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXVq4tRnLWMHtGLTpCQRpvrFFW2YlrbpZOnhzL1zuzI=;
 b=gInhlFPJeiOKFPgfUIHfY1faUhzi/h10i/CmR9/ALJOJNDmfAC+sIg0Ig/0J3oKDLK
 MJD+N20NfL7ezJbh745WoWr7NqODAj+gK6RxSto+eHI1R5pW0b7F+ufaVmjWGmiWJH2a
 BOJbjw560+swWBsM7vk1ZhEE4KlUKqR2goYImhiHDfSEJA57J8wnCUrgfqTFF001xvwn
 Dp/+J63BfBjRqW+Crieg07sTZkdEDovhIaKX8rnRudGSBdYdVIMcxck0XNpRC2JBESp9
 RNYLZe7VeAPr5jrX5fE25P/0wmQbYHpxraNKKlgJ/NxQUn6OWcFbaHovO7JybTQB75vV
 rq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709699274; x=1710304074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXVq4tRnLWMHtGLTpCQRpvrFFW2YlrbpZOnhzL1zuzI=;
 b=alkxu+DIsf1S795hhJqIuxuUCu+zMbL7HZpKvGkDArFPEi6Cz+3jOC7h3WvhUCP7YF
 KhZDUriJaT8LOXMbbqbdlptHqk5pPW7e+My6HMh7hqpNV/uAh+7E6aL/pPbKzyug/rUz
 3GkeDrgeie2gnamnJmJ75X1eGAp5qWQzhtsOZzrQDCEPwfjWLGnQnRXJiF0B5S6+c4EI
 pBHstp6BDZEGZBOOa0xN2ZctHYHroZ01AZZ9McXRJhpbTRC+sFWaceP3ffJY3Osou0Jg
 I47Q6Hz8Ov+vtcW0Jf/+dQFcLaUAIBd1/9HaIu5MlZNKG2GdkE0OcqO7fsVUAyjlxd1C
 Dp6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlywjSI/zIu53SCrSK4Kb/GKkkyROAhQtqXS+QG6g0l0LSo/zQWqvKB6IHYP46/Fb7HlAY6ggM1V6374f3xJC+84vTSflHU5ItBltRhrGdqBXTf6QN2Mi2KIiSsSo=
X-Gm-Message-State: AOJu0YzbwPHKYrZOyzIqHtIzGaDGkNTxLNBvDhvJMlt4EoI8gdfBlaNf
 nqLlUh753Torcsry+XQ7+FcAS9r7O/ZfEkoV4tc/dbeIEanWF4qGE2dtGkZ9S0YhuVn6p63ZRQo
 +X1TtuubMa8AKroVpHwMUn0nYtPw=
X-Google-Smtp-Source: AGHT+IHQCRPo2SSnTcnAPGwo0WvBiyYmz6APZXDYCcvrjAYEC+1DpAeumiRA2yPOVDtw65zIZOdTYKC2Q2afFppU1t4=
X-Received: by 2002:a05:6122:4e8c:b0:4c0:9ec7:b324 with SMTP id
 gf12-20020a0561224e8c00b004c09ec7b324mr3552094vkb.0.1709699274361; Tue, 05
 Mar 2024 20:27:54 -0800 (PST)
MIME-Version: 1.0
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
 <20240128175035.812352-7-mjt@tls.msk.ru> <87ttlnehb1.fsf@linux-m68k.org>
In-Reply-To: <87ttlnehb1.fsf@linux-m68k.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 14:27:28 +1000
Message-ID: <CAKmqyKMGODCT3BetDRL_1MLuEKcBhQjUBgZ99eMQvN-Aeo+CAg@mail.gmail.com>
Subject: Re: [Stable-8.2.1 61/71] linux-user/riscv: Adjust vdso signal frame
 cfa offsets
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Vineet Gupta <vineetg@rivosinc.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Mar 3, 2024 at 8:34=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>
> On Jan 28 2024, Michael Tokarev wrote:
>
> > From: Richard Henderson <richard.henderson@linaro.org>
> >
> > A typo in sizeof_reg put the registers at the wrong offset.
> >
> > Simplify the expressions to use positive addresses from the
> > start of uc_mcontext instead of negative addresses from the
> > end of uc_mcontext.
>
> This breaks the testsuite of libunwind.  The test Gtest-resume-sig and
> all dependent tests hang.  Reverting this commit fixes them.

Do you have any more details? It seems strange that this commit is
breaking something as it looks to be correct

Alistair

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
>

