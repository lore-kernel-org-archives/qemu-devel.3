Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64C8E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVs5p-00059x-CK; Thu, 09 Jan 2025 07:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tVs5n-00059f-JY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:56:55 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tVs5l-0000My-PV
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:56:55 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so883942e87.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736427411; x=1737032211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duI05vNLrTzsx9lFTkLYGQIiyCuW0VDmSocvGwPA5Ao=;
 b=DCag3TNeGoKhWFLfit9ziL1AsVuSn4IRYAvluuh/g7BmJLSNvQI+2C2aul1hozeBoc
 kMl4tpWpMWsqzuTVpp0NdFamFlZh/GzyHM3rzlJnrMIdwCoKjCFzYWD0Ozr2f/9Oq9Wa
 b4FxwqIzK5cPv7ollM7NVgPNucw6sd7ajt6URNDiU4y616xG6PGzst3ujONqTU1eXjnT
 id8BrQkikVpIbsUIJqqoJQEsmNU0yl7zVYShXcrdK5bTABy2mCw2FiXsHlXBZsh9/xIV
 7o7pHTObZnWjR/DKn4WbeROxkga0HCzLykhdNJ5Ur8znzmJ6xXojCbLy7rJhIgeVqgiZ
 TpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736427411; x=1737032211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duI05vNLrTzsx9lFTkLYGQIiyCuW0VDmSocvGwPA5Ao=;
 b=LfUpMKNkexdRI9KAxxUY9K8+cYOjY7QyEqqqsd6DgWpjqoBh84vLuGXA0taHb8W79j
 eOnFHq7NbAph8TcKc5eO75QkyxuaBLXfAeXot3iQY/3oRXnaxNI0gcKInrCwmAM7vWlI
 VocIo/+Xe6t5irQM5QNny4dDyl/tA23Ks3p+hdfT+eGfBh7MQYFXQmmuvi9B2N7Bu/QQ
 xO+3fyWu1mFWUV5TaUZOzcnDe3a3x826mFGbuV34MbyH4QIqFr0G+yZV4+oHIqwn4M35
 nWbDqKT9Vknb4lAaXDqXvezFpFhpQJ+iemLDgERXCkXaU2XEs52u1Op/TTPakXs7eiCb
 DM0g==
X-Gm-Message-State: AOJu0YzCN1j6e2F3LjZJlkVUbeJgzzqp/6gO20OC5AgQ+5J981peOQ3k
 N/edO2oPdpnzbtrp/oXkvJ+F2vorfHawYVqFXEgg1ErQ4h6GIDiIPlC4Pp/G/4NCTOjfkGvzGz0
 pxFljQqokZFCdzm5hcrdrByuhQKU=
X-Gm-Gg: ASbGncsFjo+cya6k2Azyc93IX2GPOGKVhKYKOJ2LxCHKcjvmCAiSrBPD55oTAnbrjFO
 OjiQTctb3WUU8bZD5ijFLysrt9uyHy6Zo3lY78YfNnhKWkeF5i9SP13NKp06HHisAm8DRERAv
X-Google-Smtp-Source: AGHT+IEOgZmILdQu9VRgNeYuf2l8hNzM13MGl+uCDRk/khOFkne9czxvDgEMOM84bF6jn835Pp0mMQaSeyOFplJOjOA=
X-Received: by 2002:a05:6512:3dac:b0:53e:39b7:54a3 with SMTP id
 2adb3069b0e04-54284549e68mr1803467e87.24.1736427410979; Thu, 09 Jan 2025
 04:56:50 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
 <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
 <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
 <CAMxuvaxzd41bRxa4=zNMdpe420W-w_GAmOjYJsYTMs1+jqdMdw@mail.gmail.com>
In-Reply-To: <CAMxuvaxzd41bRxa4=zNMdpe420W-w_GAmOjYJsYTMs1+jqdMdw@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 9 Jan 2025 13:56:40 +0100
X-Gm-Features: AbW1kvbHeWFZTMdoht2ZD50FDv6GOXOUaYzWlJngRgWDmAF43URdhpsv3kw1LDY
Message-ID: <CACZ9PQW-RJHvkDzBO1T9YDAPX_6zcEuK3kQAEukybBL0PZEB5g@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Bonzini, Paolo" <pbonzini@redhat.com>, 
 "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x134.google.com
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

Hi,

On Tue, Jan 7, 2025 at 3:57=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi

[cut]

> > > But next attempt to write will loop over the same backend again, whic=
h
> > > will see the "same" write multiple times.
> >
> > This case is handled by checking the difference between counters
> > `d->be_written[i]` and `d->be_min_written`. The idea is that device, wh=
ich
> > already "swallowed" some portion of data, will be skipped from writing =
to it,
> > until it catches up with the stream.
>
> ok, I see. This looks fragile though, I/one will need to do a more
> thorough review.

Yes, please, a thorough review would be great. I'm really keen to improve
what needs to be improved and hopefully finish this.

Do you want me to resend this as v7 to make patchew to grab this series
for further review?

>
> >
> > Please take a look into the `char_mux_be_test()` test case, where the
> > EAGAIN scenario is tested. The line test-char.c:716 explicitly shows th=
e
> > repeat of the write procedure after EAGAIN was received.
> >
> > >
> > > > +        } else if (r < 0) {
> > > > +            /*
> > > > +             * Ignore all other errors and pretend the entire buff=
er is
> > > > +             * written to avoid this chardev being watched. This d=
evice
> > > > +             * becomes disabled until the following write succeeds=
, but
> > > > +             * writing continues to others.
> > > > +             */
> > > > +            r =3D len;
> > > > +        }
> > > > +        d->be_written[i] +=3D r;
> > > > +        ret =3D MIN(r, ret);
> > > > +    }
> > > > +    d->be_min_written +=3D ret;
> > > > +
> > > > +    return ret;
> > > > +}
> > >
> > > I am not sure what is the correct way to handle write here. This
> > > mux-be behaviour is different from mux-fe, since it handles all
> > > backend I/Os, and does not select one... it's more of a "mixer",
> > > right, Is this wanted?
> >
> > Right. The intention is to have both consoles simultaneously
> > working, for example having char-based tio (over a socket chardev)
> > and image-based vnc (over a vc chardev):
> >
> >     -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 =
\
> >     -chardev vc,id=3Dvc0 \
> >
> > and both are connected to the same frontend device.
> >
> > I agree with you on the "mixer" naming concern, this did not come to
> > my mind. As far as I understand the logic of `mux-fe`, it just doesn't =
seem
> > possible to have both frontends running at the same time, because they
> > will both generate output, at least that's the case for virtual console=
s:
> > imagine you have two virtual console frontends working at the same time
> > and one backend. Any command you enter from a backend causes the two
> > separate frontends to output completely different data.
> >
> > On the other hand, several backend devices can easily be simultaneously
> > attached to one frontend, the analogy is simple: several monitors, seve=
ral
> > keyboards, etc work perfectly fine with a single PC. At least this is h=
ow
> > I see this, please correct me if I'm wrong.
>
> Whether we talk about multiplexing front-end or back-end, the issues
> are similar. In general, mixing input will create issues. Teeing
> output is less problematic, except to handle the buffering...

I understand your concerns. What exact issues do you have in mind?
Are these issues related to the input buffer handling, so technical issues?
Or issues with usability?

>
> >
> > Do you think we need to artificially introduce multiplexing logic to be=
 fully
> > compliant with multiplexer naming? It's not hard to do, repeating
> > `mux_proc_byte()` from `mux-fe`. In my use-case, I'll still need to dis=
able
> > multiplexing in favor of 'mixing', for example with the 'mixer=3Don' op=
tion,
> > i.e. '-chardev mux-be,mixer=3Don,...`. Or do you think it should be som=
e
> > completely different beast, something like mixer chardev?
>
> I think it would be saner to have the muxer be selectors: only work
> with one selected be or fe. Otherwise, we can run into various issues.

In multiplexing (not mixing) for the use-case that I am describing, there i=
s one
serious drawback: as soon as you switch the "focus" to another input device
(for example from vnc to socket chardev), you will not be able to switch ba=
ck
from the same input console - the input now works on another device. This l=
ooks
strange and does not add convenience to the final user. Perhaps, for a case
other than console, this would be reasonable, but for console input -
I would like
to keep the mixer option: the front-end receives input from both back-ends.

> I hope some qemu maintainers can comment too.

Do I need to add someone else in CC to gain more feedback?

--
Roman

