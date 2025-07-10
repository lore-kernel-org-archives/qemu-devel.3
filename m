Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02282C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 13:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqtG-0000ZI-Bn; Thu, 10 Jul 2025 09:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqss-0000Qn-Iy
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:00:19 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZqsp-00078R-SI
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:00:17 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e8600a33792so638688276.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752152414; x=1752757214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxAFF0yvbVfGO2JIzksby9ITrfFeKz4bVcDVuanXSLI=;
 b=jpdlvftMVgbXpXR+ygOrh0/j6Xcof13kvaYzPJkzcKHJDQ68z8q8fQDsVUZwZ4g4qS
 FppGN0mVhxvxuYTmCOTRwFNMc2h2ZA0VRJAg3i7y6uXKke+cmBwVYJeg+e89HVOgeZQY
 9ykajdkLsEm7+tE9GInvlSe07LZ7VtJSPq1EfYs1kMBtA+45xXvB/qEyczs3nWI+ySLh
 GwdwOu9j6Wf86Eo9/ZwhhudY9qJHQQ6sEDiQP+iNkGsyi6jUWKGrEetFh17lzQeiMA4Z
 IazyNxdEMAcA5klkSzXi+MUrixd1m9oxudboqZeQtAHU4TzDOt775HnBUJzy8df3t+1T
 dqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752152414; x=1752757214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxAFF0yvbVfGO2JIzksby9ITrfFeKz4bVcDVuanXSLI=;
 b=W9UiY1YKuwr6FkXEMHBR+SG6Zuw/0+JFL1XgESNN6+h4JrhvBIoogitNhdo7F4IQOT
 KBIekosXoQVsg9uvxO2ijCcE9ebLGsKGCa+PtK1TiZzVwxHXaN6C9tBE9LXsEKQbVQT3
 PGYadMPWg0F+L7Si1ZkGHVaD0TFRY2sihCaPZuY/rnV3hzftgHkVh9c7Mahh75el6WKj
 ayMjKmvwRIRYqzVjPi+2n+B70oylSzap7d4tLDvA0B2KyE8fWCwP58xZziBv+gcP0LZM
 p/JRwl2T+T0iCOG7t8oeTzwLyU57l5KVvdpfhMCvYhMriB6stffgclAE1SKAbPyG/C7o
 Foyw==
X-Gm-Message-State: AOJu0YxmHKcBSWJg+2yA/Ykte2lxguDfqBZCq8zlk/R57NKgBLe49ZrI
 BUESwfI/sktwLXal3pOxbsBtgmvMyr1aogpcNsbkwg5E+9cIqHFDEzjKvbaRp0ZDxlrJ5Ip0jWW
 P5fQD5gk1/IrRW/z9d8CJliNSqgrkYYzjcuV4ZmiIrw==
X-Gm-Gg: ASbGncusmh6I4FaXgaBIGVaPuubxbMsBAHPM/Q9dRC06iw11c3eYoNeCZo+BbbmvDLN
 tf+TDiDB4m2zkcjYQp6G6zooIb9YnyIM2q46x3Z1voeRgx+NNpLWsBWGtW0jVwvCseEvsa/3dcF
 wR4WNxSvVGU4VTUt0k91bzJR1q+ogioByUIkF6v22DMpvU
X-Google-Smtp-Source: AGHT+IGt6PPrJ86QEux19ZodO/tKcNYIUkAOCP6yKjPyVGdvk3a3QBcr7lq8I8bNXBvYex+l60iv4gUX9DkbT3LFVA0=
X-Received: by 2002:a05:690c:887:b0:70e:2ba2:659d with SMTP id
 00721157ae682-717c4745f4amr35080877b3.23.1752152412472; Thu, 10 Jul 2025
 06:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-20-berrange@redhat.com>
 <CAFEAcA9jxiazMKEyoPQQdqRBKydgkbKQobtLPyszSHT1M-LHGA@mail.gmail.com>
 <aG-4WAG8HZWNHGhY@redhat.com>
In-Reply-To: <aG-4WAG8HZWNHGhY@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 14:00:00 +0100
X-Gm-Features: Ac12FXx1NDpc1wPRo-HkE0vw-upAQRCi6HfNJCNmNTN-Dgv6yz-oLRigPsg8Tno
Message-ID: <CAFEAcA_oo6+k7eZ5M2X+TgaSwMZqeVNJwona2ge-9-B469kwcQ@mail.gmail.com>
Subject: Re: [PULL 19/23] util/qemu-sockets: Refactor success and failure
 paths in inet_listen_saddr()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 10 Jul 2025 at 13:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jul 10, 2025 at 01:17:40PM +0100, Peter Maydell wrote:
> > On Thu, 22 May 2025 at 11:33, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > >
> > > To get a listening socket, we need to first create a socket, try bind=
ing
> > > it to a certain port, and lastly starting listening to it. Each of th=
ese
> > > operations can fail due to various reasons, one of them being that th=
e
> > > requested address/port is already in use. In such case, the function
> > > tries the same process with a new port number.
> > >
> > > This patch refactors the port number loop, so the success path is no
> > > longer buried inside the 'if' statements in the middle of the loop. N=
ow,
> > > the success path is not nested and ends at the end of the iteration
> > > after successful socket creation, binding, and listening. In case any=
 of
> > > the operations fails, it either continues to the next iteration (and =
the
> > > next port) or jumps out of the loop to handle the error and exits the
> > > function.
> > >
> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > ---
> > >  util/qemu-sockets.c | 51 ++++++++++++++++++++++++-------------------=
--
> > >  1 file changed, 27 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > > index 4a878e0527..329fdbfd97 100644
> > > --- a/util/qemu-sockets.c
> > > +++ b/util/qemu-sockets.c
> >
> >
> > Hi; Coverity complains about this code (CID 1610306):
> >
> > > @@ -303,11 +303,20 @@ static int inet_listen_saddr(InetSocketAddress =
*saddr,
> > >          port_min =3D inet_getport(e);
> > >          port_max =3D saddr->has_to ? saddr->to + port_offset : port_=
min;
> > >          for (p =3D port_min; p <=3D port_max; p++) {
> > > +            if (slisten >=3D 0) {
> > > +                /*
> > > +                 * We have a socket we tried with the previous port.=
 It cannot
> > > +                 * be rebound, we need to close it and create a new =
one.
> > > +                 */
> > > +                close(slisten);
> > > +                slisten =3D -1;
> >
> > Here we set slisten to -1 ...
> >
> > > +            }
> > >              inet_setport(e, p);
> >
> > ...but then two lines later we unconditionally set slisten to
> > something else, so the -1 assignment is overwritten without being
> > used.
> >
> > >              slisten =3D create_fast_reuse_socket(e);
> >
> > What was the intention here ?
>
> The overwriting is correct and intentional - it is best practice
> to never leave a variable initialized to an FD number that is now
> invalid. IMHO that best practice applies, even if we are going
> to re-initialize the variable a short while later, because this
> mitigates risk from later code refactoring.
>
> TL;DR: coverity is correctly identifying a redundant assignment,
> but the assignment is none the less justified.

OK; I will mark this as a false-positive.

-- PMM

