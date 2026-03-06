Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2490BF0181D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyS46-0000CH-Jm; Fri, 06 Mar 2026 05:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyS45-0000C0-3z
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:05:49 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vyS43-0000g2-0r
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:05:48 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso3971091f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 02:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772791545; cv=none;
 d=google.com; s=arc-20240605;
 b=Yygfz7tOcNfhJSQvaCW1jbM9fuTDJJTrMl+hbCRsraERkrGfpVhoShbQ0mUwyVdf0C
 gEudkjlmS8hIIBqUBf2fRwS3YEuXIbCth2/0heycGk0WSG+Hxvu1S2A9Y2ZUO6xNhK2H
 ZUVSpJ8ZcLnNJlZdhK5hrt2NbNJ3Fta/EtN69KgjY6tvw/d0fYffzL4u9gm//o8V7XqL
 KBgf62C4f/huqtejurYi+qxUuYr5yYRplnh8P51vK+Q9a8df0DYzaMxaO80NSFBEA2Mo
 fMrMBCtgCteiOCGh5TltL3+g+ohYFDe+XzwqMsR/DmwARnTzTNN6wXl2VF0vVMOfibXK
 GWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y9cmIiav0lTVosXZVFnVmxoIqiPCkVWR5JYdyodWTZk=;
 fh=pwbqm79EF4bnzcNJxti/08VsKIG75t/tIteUZN/fgpw=;
 b=a8gJ5SxV61qhZd8x3bAz/IuF6ktwXML5rk8zakQ+z7u/e84CPHKEJ0Zx6b8Q1VXNWM
 AFbYIVaKsIo9nGtYKaK08FzPkDSCjCi8EhgbxvuNC2QNvcZlrTvpl8A4Rj9V+Gn7b8W2
 NM8mfxekoWSjvPycfJK1/uVjzAvmER4AXdcejE7Pt7y+Ito+kyuYTVlbxWw5mWYsaOO0
 YhHB5+4r0t+HXgo5CFKrs6QBsDTobTPAzGWOTnMJyE2/LEmQTVR9N3wEMrPwZz51alR3
 vi+r2MoeIEcBB0pNpN38nyhK0rMqqkXVnOmSZTBbFSKCSEUrN9jkO9XysRJYSIhwy95m
 kCTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772791545; x=1773396345; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9cmIiav0lTVosXZVFnVmxoIqiPCkVWR5JYdyodWTZk=;
 b=z0kwF5Pp7dBdqvkoYmd0D3wKWmvYEM5AMLbFRkTiyvlHahc1c0vd6W9tsH/3c5lQL1
 lGCGEEq+LSn68z7YfxaP7aolBpClqMvbFkwI/ATWWtDLHEFhn3r74lpzU3S4czGZ228Q
 hip7nZaiXYfTuNSQCcCm7ZgMgN7RAETHzXH1w6IFgkhs1b+FZ+hSjA9LNlDYxfwEjN16
 37J8DHqhw2xzIyeQALzbKji8hgmjt35lZ/JbaOiAgxc8UfKlGy3QlfUhOPXhZe+a4RON
 qjXLFO6x6K1O/A570L4cVZnm7ktCKXoKvgyswccfgk1sHZlLtYLlXMFzDIqk//ppDsnh
 PczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772791545; x=1773396345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y9cmIiav0lTVosXZVFnVmxoIqiPCkVWR5JYdyodWTZk=;
 b=jLsMBDB8tHi6W1P+g8GYw5+p2Cy3Z1RZC2og0/okiTGqwo4Om5ZYW2K7e8+XN0GZIs
 14H00Rt3EC/Hy3Wznelk16UbAhESH6kngu6XDUuDemu0OWEjxciZq2P9kC1V9oxdewvc
 UAw6UJ+InWxnHH34eKzn5trnhhKaJvf16H+3trrfO5/IUCOfzv8kGGvJ736zyH2SdZ1K
 mlsqnd9X+fDVU9cPiEmtslv1VLHMO4bo1MYt0E32LYa82xa+hDoWSMx96ZiasG9w4Myj
 /zhn1axDv9thNCWZ0JeS98qiEGvJ2qAt4XOjj9uADOGXoId0k5RR/iXzggW84Neq3jIh
 B7lw==
X-Gm-Message-State: AOJu0YyTNIrG0QmURX0JDw1r59+GjLkLUTRhpHPYGKMtpb5ahLY5BDON
 8IUdCm1nnb7xWN4+JS2mt+xl+IHYlZeeKk3a64ME4j4JJPRfdrJoIddDz4lFxfeafPgtB0G8iaR
 HswN7QBkd4oWhXkHqSq74fGwKCY1fpNAGfPXNPRnASA==
X-Gm-Gg: ATEYQzzH49beN+vw9Wc7ccla8GNC33KOclAotav+15JvPe0YJHRwiuCjdbd4/N1pDCw
 qJh5HvLu5RY3DHMj6O+aRC2Ud7HeGJiYyyORyPbGS+nwNAviSAZVp6nEs1NX7OR1qrJj70hQQ5e
 kJYZmNtRhjUw4922TsQvwiG2L48IAk8+R1PmhjhRk+7mcyHC0Du2osl0oahaYaOU+opBlchk0o1
 yMiByffshdn82uOH/8JbNntdV+TPFcaCgZwJxrpT2hFrijGLalUG/ORSEfmya0oHEucVeQbv2o2
 coV2T8W6Yh+z0pErvsEmNt5ObhO/izQOTg3Y8MYi8R9g6AboqdKZ0kdKOLFt
X-Received: by 2002:a5d:64e7:0:b0:439:af81:1b21 with SMTP id
 ffacd0b85a97d-439da118cbamr2366751f8f.0.1772791544847; Fri, 06 Mar 2026
 02:05:44 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
 <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
In-Reply-To: <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 6 Mar 2026 12:05:18 +0200
X-Gm-Features: AaiRm536Q_aGo6OGdgP-oT4uxmy2_Dtdp06xEch5Wt5a3l6A-uEQW60cWAviB3Q
Message-ID: <CAAjaMXbq9A1NCO4jnF4aSL0XM2pzHsPsPyWfmqSCg_+2ZQpEHA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

On Fri, Mar 6, 2026 at 11:48=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 6 Mar 2026 at 09:31, Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> >
> > On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > > Mohamed points out that this breaks the build when compiling
> > > with GCC (which I hadn't noticed because I happen to do my testing
> > > of target-arm with clang on Linux these days):
> >
> > Oops. same here, I was using clang.
>
> > > typedef uint8_t hv_sme_zt0_uchar64_t;
> > >
> > > Could somebody confirm that that works OK on the relevant macos
> > > configurations ?
> >
> > I think this works. Do you want me to send a new revision?
>
> If you can test it for the macos configs I can just make the change
> locally. I have:

Tested it with gcc on linux and on macos, thanks.

> +/*
> + * The system version of this type declares it with
> + *    __attribute__((ext_vector_type(64)))
> + * However, that is clang specific and not supported by GCC.
> + * Since these headers are only here for the case where the system
> + * headers do not provide these types (including both older macos
> + * and non-macos hosts), we don't need to make the type match
> + * exactly, so we declare it as a plain uint8_t.
> + */
> +typedef uint8_t hv_sme_zt0_uchar64_t;


>
> While you're retesting, could you also look at / test patches
> 17 and 18 in Mohamed's series
> https://lore.kernel.org/qemu-devel/20260306083113.74177-18-mohamed@unpred=
ictable.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d
>
> ?
>
> They look to me like bugfixes that we should be squashing/including
> in the "enable SME2 for hvf" handling.

Had a quick look, 17 seems to be nested-virt specific so not a bugfix
if nested-virt was not already supported in the first place, right?

As for 18: I'm not sure why this is needed (I'm not that familiar with
HVF API) and there's no commit message to explain. @Mohamed Mediouni
can you help?

>
> thanks
> -- PMM

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

