Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A104ED232D1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 02:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve2h1-0007Zi-M4; Thu, 08 Jan 2026 21:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ve2gt-0007ZE-0r
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:57:32 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ve2gr-0000v0-5u
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:57:30 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64c893f3a94so4059492a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 18:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767927447; x=1768532247; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7mvmI6H1ea5qLvK1euOE0Qt4XLXyivoLBaeShqxJCw=;
 b=fly7SQ1gOBrqixpyDlq6XVGw5hlMWMMIm1xrJT0LTIsZQlotLenreDj2KporDX45Eq
 aNH8KtTsLNIgudHiOvZAF8HaVV5QhCD4sN9sfQt53Mjd89eVE7Kpd7yqJzSLcsTlx2vq
 tIuGBWD1TtwKd1Q/xgnIlZnv0+QGaOKOvqI+aDUSLocyj4oAJmhD4s0Z7rGNAT/VdyuX
 FrrNuVxSKVKHU04reFl4MDClyed1Tk+kZ3Cf8hjlFsazCcCuB1iYS4L6vVzveM+N/Wud
 J2uaxrB8JKePy+G3XGk3SPHZZncj06G9JdCHzWR9ovNx9w3aoV7U3ps/odKgo2lPtea8
 eQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767927447; x=1768532247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X7mvmI6H1ea5qLvK1euOE0Qt4XLXyivoLBaeShqxJCw=;
 b=kG5EObJGsoLTdmio9ubzycKRSa14mFI7DDrnKVtoBip1EnKuXQXcpsMrn0AKApd/3Y
 ex/A+zL6r4HJQiOVYCfQ7AgCdXfuCFar9IwPv2vfZcQVDtttZmGveDPIEznhIj/P9Z1V
 HnpCG42OHpHIzh2CY6tI/5SBpXyVloPleVHoilJgiE2O7MkvixgSdRa5kNMTG1flz7hv
 M+XRYfT/9SSbrq6y6lojUqBU14OjYVZyksmEP9smQSOVzDyJokcbAJpghoJB7wZV2r3S
 6bxWIatwropI/6qpg1xC98/M2IaVeboz70jQ7RpWY1BVgWGSzBPLBqNcv7mo/eyuxSMd
 TlPA==
X-Gm-Message-State: AOJu0Yyl5GRr/JXW+9enHtv2CLNraQjdzTrKifska8Bni5akkcGMHrGL
 MgPigVpQhNO0TY64Nxz7lIeayKIK9LxbzZVx+3QyCBhHp8MCQz6DXfsOmVpFH72tqC+STMgkc8L
 4djJiQnUp+FpjhQF0mIYi2T0gd5Q6CNY=
X-Gm-Gg: AY/fxX5ZDP7r1B+8rqUKFsMIyNuZ3w3ZJqjR4WEq+eE6LtudI5KCXbtQHxjtwtPLRrR
 WD9G6HyxQgU+9/L2GQObWr3CrAQjMnsom5DgwzJb8r5x6r5INNFFCNEWZAN3OzHbNjpUesoJXoT
 TG2zT6v8IRo+TozjrqJcFFBZCX6nvB+RIwBGmQyVUltR0mtxrQ5vWWojBj971PM6Zje3QkI5G3T
 8dVESfRLljXgVT+6EPbQW7xZSnZzOO9e4r6IMaD8izxG5e5zZ5nh6OE7UpmN5ZoIBI8BEw=
X-Google-Smtp-Source: AGHT+IFbu6y8Q02NoslK82UEd14wn5IslypM2xV1BU5LNFtDArErYXYwhZOkH1gua3bQ65oljy8663PF9mS6cUA9LOs=
X-Received: by 2002:a17:906:3187:b0:b73:37aa:87c0 with SMTP id
 a640c23a62f3a-b8429b129cfmr813472166b.23.1767927446779; Thu, 08 Jan 2026
 18:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20251229103859.98777-1-zhangckid@gmail.com>
 <87bjj48g1c.fsf@pond.sub.org>
In-Reply-To: <87bjj48g1c.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 9 Jan 2026 10:56:49 +0800
X-Gm-Features: AQt7F2pFvhiwgTaO_WZP2lHW3b7wuz-OHV3prwc0pKY7pEGPu5VPB1y3YC2tr3U
Message-ID: <CAK3tnv+--WTJ-8jmgaPsUQz4DwoPH2_Z+QgTuzee4TjD1JW5dA@mail.gmail.com>
Subject: Re: [PATCH 1/3] qapi/misc: Fix missed query-iothreads items
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52c.google.com
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

On Thu, Jan 8, 2026 at 8:06=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > As the struct IOThreadInfo definition:
> > { 'struct': 'IOThreadInfo',
> >   'data': {'id': 'str',
> >            'thread-id': 'int',
> >            'poll-max-ns': 'int',
> >            'poll-grow': 'int',
> >            'poll-shrink': 'int',
> >            'aio-max-batch': 'int' } }
>
> Suggest:
>
>   The example is incomplete: it misses members @poll-max-ns, @poll-grow,
>   @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
>   (monitor: add poll-* properties into query-iothreads result) and
>   commit 1793ad0247c (iothread: add aio-max-batch parameter).
>
>   Cc: qemu-stable@nongnu.org

Nice description! I will rewrite the commit log next version.

>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  qapi/misc.json | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 28c641fe2f..6153ed3d04 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -117,11 +117,19 @@
> >  #     <- { "return": [
> >  #              {
> >  #                 "id":"iothread0",
> > -#                 "thread-id":3134
> > +#                 "thread-id":3134,
> > +#                 'poll-max-ns':0,
>
> Double quotes, please.
>
> The default value appears to be 32768.  Maybe show that?

Good catch, will fix it next version.


>
> > +#                 "poll-grow":0,
> > +#                 "poll-shrink":0,
> > +#                 "aio-max-batch":0
> >  #              },
> >  #              {
> >  #                 "id":"iothread1",
> > -#                 "thread-id":3135
> > +#                 "thread-id":3135,
> > +#                 'poll-max-ns':0,
>
> Likewise.

Yes.

Thanks
Chen

>
> > +#                 "poll-grow":0,
> > +#                 "poll-shrink":0,
> > +#                 "aio-max-batch":0
> >  #              }
> >  #           ]
> >  #        }
>

