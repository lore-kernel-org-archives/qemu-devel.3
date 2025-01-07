Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A9FE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVB1u-000657-7s; Tue, 07 Jan 2025 09:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tVB1s-00064Z-Q9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tVB1r-0008Ry-7J
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736261876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xiQhvhjrQBNA/E0QEuolqzecvTJnukAQDxbHcUUrLs=;
 b=gujNES/EhN3Ipj2Gqmo35m/Z07EnykIm4UfOhuOM5KLhyqfLuzeLd1tHF3FdAzKdXMOlVk
 GkOEejcYZnqU0F/2ovTxtZXHPPCldTRzyAMBrAwvxb0LT+y9BTZjK1mMKzdbE3CAiEsPLR
 m0RXKJuY5ayrzoNBKi+EKUP9UJAtCQ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-DP1MZvWbObKkZtBUzYfEHA-1; Tue, 07 Jan 2025 09:57:55 -0500
X-MC-Unique: DP1MZvWbObKkZtBUzYfEHA-1
X-Mimecast-MFC-AGG-ID: DP1MZvWbObKkZtBUzYfEHA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4679becb47eso99087241cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 06:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736261875; x=1736866675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xiQhvhjrQBNA/E0QEuolqzecvTJnukAQDxbHcUUrLs=;
 b=oK+9RPyMGj+6ZkRQJX6M+KWyjFMkrJm6fOqx5fOADZE/XtaJxFSC1CQPppUzoEWUkB
 gdMnzSo3jgPCv6nOFPtVmobr3za5wZP9BDUoFwngcCzZiI9nQrZpbAi4w+5qDmi4B2uG
 cKw8O/sk+7JpX0GoRHw0FiTVzySVM1Kil6VMvCIPbkXwdlCqS43bXzvoPlVDb0GbVq03
 BEQSBG6uV08bVb9ILVCEFFiLEpG+DtfmZQ1TjRFOpWKtThezNv5FkSVV1zmYOPyi/9ie
 TYqrJIKSS9igzc7T5G0q0KDPbWlkbvurVr9pxJRUIbgKfPMl3dyhQBpWpbh6jaGgEO2Q
 H4zA==
X-Gm-Message-State: AOJu0Yzom+KtxfA6iHi0yhF1vndQk/MvbokjPsOovmNvqEmeOchssg5C
 WICeAQZACqdLzXpes46e1Ll+cYl/mlt9639Iz4lL19xl0SV//scDM5MzL34aXQsydj4g7RmutLB
 Adx4eUuXe2IIitFfD2xEnIx3WFnIDkzg7Mq9b8t89M1enHE2sESjEHZx/64IHIbIHf4XDHjPO/9
 bUpbPq59dSwwSGoTzexnGcH+7j5UI=
X-Gm-Gg: ASbGncv1SLxIbehx5ujqFu4DdXpxVWwCdknDPnKsUbfp/Mvd+3E4TfCmqNjj7cpyjwQ
 kXbyKN968V1xUbFCQUG5hMAS+6DPrE3fm1jNi
X-Received: by 2002:a05:622a:1a8d:b0:466:a032:dbbb with SMTP id
 d75a77b69052e-46a4a8b5da7mr1050274691cf.1.1736261874571; 
 Tue, 07 Jan 2025 06:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqSoLM2L9UvxZ4JyCx/DDMdT4KsC9w6Xrg5OwW9tEZpAh9eDGArZ8IttimxCSEh2y41GD/dSUxrhEerZuRG1M=
X-Received: by 2002:a05:622a:1a8d:b0:466:a032:dbbb with SMTP id
 d75a77b69052e-46a4a8b5da7mr1050274451cf.1.1736261874282; Tue, 07 Jan 2025
 06:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
 <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
 <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
In-Reply-To: <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Jan 2025 18:57:43 +0400
Message-ID: <CAMxuvaxzd41bRxa4=zNMdpe420W-w_GAmOjYJsYTMs1+jqdMdw@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: qemu-devel@nongnu.org, "Bonzini, Paolo" <pbonzini@redhat.com>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi

On Thu, Jan 2, 2025 at 2:22=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com> =
wrote:
>
> Hi,
>
> First of all Happy New Year :)
>
> On Mon, Dec 30, 2024 at 12:41=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>
> [cut]
>
> > > +
> > > +    for (i =3D 0; i < d->be_cnt; i++) {
> > > +        written =3D d->be_written[i] - d->be_min_written;
> > > +        if (written) {
> > > +            /* Written in the previous call so take into account */
> > > +            ret =3D MIN(written, ret);
> > > +            continue;
> > > +        }
> > > +        r =3D qemu_chr_fe_write(&d->backends[i], buf, len);
> > > +        if (r < 0 && errno =3D=3D EAGAIN) {
> > > +            /*
> > > +             * Fail immediately if write would block. Expect to be c=
alled
> > > +             * soon on watch wake up.
> > > +             */
> > > +            d->be_eagain_ind =3D i;
> > > +            return r;
> >
> > But next attempt to write will loop over the same backend again, which
> > will see the "same" write multiple times.
>
> This case is handled by checking the difference between counters
> `d->be_written[i]` and `d->be_min_written`. The idea is that device, whic=
h
> already "swallowed" some portion of data, will be skipped from writing to=
 it,
> until it catches up with the stream.

ok, I see. This looks fragile though, I/one will need to do a more
thorough review.

>
> Please take a look into the `char_mux_be_test()` test case, where the
> EAGAIN scenario is tested. The line test-char.c:716 explicitly shows the
> repeat of the write procedure after EAGAIN was received.
>
> >
> > > +        } else if (r < 0) {
> > > +            /*
> > > +             * Ignore all other errors and pretend the entire buffer=
 is
> > > +             * written to avoid this chardev being watched. This dev=
ice
> > > +             * becomes disabled until the following write succeeds, =
but
> > > +             * writing continues to others.
> > > +             */
> > > +            r =3D len;
> > > +        }
> > > +        d->be_written[i] +=3D r;
> > > +        ret =3D MIN(r, ret);
> > > +    }
> > > +    d->be_min_written +=3D ret;
> > > +
> > > +    return ret;
> > > +}
> >
> > I am not sure what is the correct way to handle write here. This
> > mux-be behaviour is different from mux-fe, since it handles all
> > backend I/Os, and does not select one... it's more of a "mixer",
> > right, Is this wanted?
>
> Right. The intention is to have both consoles simultaneously
> working, for example having char-based tio (over a socket chardev)
> and image-based vnc (over a vc chardev):
>
>     -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
>     -chardev vc,id=3Dvc0 \
>
> and both are connected to the same frontend device.
>
> I agree with you on the "mixer" naming concern, this did not come to
> my mind. As far as I understand the logic of `mux-fe`, it just doesn't se=
em
> possible to have both frontends running at the same time, because they
> will both generate output, at least that's the case for virtual consoles:
> imagine you have two virtual console frontends working at the same time
> and one backend. Any command you enter from a backend causes the two
> separate frontends to output completely different data.
>
> On the other hand, several backend devices can easily be simultaneously
> attached to one frontend, the analogy is simple: several monitors, severa=
l
> keyboards, etc work perfectly fine with a single PC. At least this is how
> I see this, please correct me if I'm wrong.

Whether we talk about multiplexing front-end or back-end, the issues
are similar. In general, mixing input will create issues. Teeing
output is less problematic, except to handle the buffering...

>
> Do you think we need to artificially introduce multiplexing logic to be f=
ully
> compliant with multiplexer naming? It's not hard to do, repeating
> `mux_proc_byte()` from `mux-fe`. In my use-case, I'll still need to disab=
le
> multiplexing in favor of 'mixing', for example with the 'mixer=3Don' opti=
on,
> i.e. '-chardev mux-be,mixer=3Don,...`. Or do you think it should be some
> completely different beast, something like mixer chardev?

I think it would be saner to have the muxer be selectors: only work
with one selected be or fe. Otherwise, we can run into various issues.

I hope some qemu maintainers can comment too.


