Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ED0E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIL8-0002Kv-J4; Thu, 02 Jan 2025 05:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tTIL6-0002Kd-TS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:22:04 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tTIL5-0003wt-53
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:22:04 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5401b7f7141so10167386e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735813321; x=1736418121; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0k/1pxnCKWWtumjQniYI9+UBLsLwY+5PAWCHylsQ54E=;
 b=Wzkwjq3fbqa505In4QxmxDzmN3zKRBe21OC5wpzQKHdcmA5AY7XBaMzfJZZ/4UQOOK
 Y8HtTDcAtLyVJsGZs09QWovld+EOlvOAE6qUROqHAD+mM+h6vNhaCwE4bWMo0jKHLEZp
 PtqLseGiLNgmWKNYS3xQw9XYh1cu5VkVSSPNl8z/Z3Xz6OqqT226qgzTsBgrVIhKfR1y
 jH6YVHHqsd2oBuXwOjhrrhfMgK1ye7ib8QBvD7zHy3zY0BKUHzfClHkz30QiFxsiliWR
 +fvFSPxFT3f9zTF1En647NxtoDRpVwMgE9nSYxJv87fTPzLI6zeyDtCRUq011N6+tEb4
 y1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735813321; x=1736418121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0k/1pxnCKWWtumjQniYI9+UBLsLwY+5PAWCHylsQ54E=;
 b=oYvNAoXwM/OTbbWtaqN/Gx/B9a+D4q5s1C29ZCrYx4EJvYme8joXYWgWhTpzQMAHfe
 QL92T1jIlnwUqqicKu+xiQMyb3P4nCxeW5xFP4TDGP6f3InCmlrNw4a7f9evx3MaFerq
 vhJKUYCvn+YneW92wGnmzNCeVr6GVlAWiQJDQyeg9Gly4xtjdlXENgD8nfV5yvB90AZL
 MwUtrLQl8ZwQ+4oSrVACh82fE7Rq902TSQ2978htSEMSxGu3YDLHo2dCG2VquDTapQzb
 bMuwqnbjENghEVXXrgg8KyXlNTkQBLtpkbL3A1H6NITNrUEVV0CppGWlaI01RA2IqTjk
 9VJA==
X-Gm-Message-State: AOJu0YzlzTf9D/GMec1rw+0C/gYrvvIS6rO0/P0nSIy4kKbFb+8wQeZi
 IZuFSIQGjtEYXLicrnwRwCPITXI5wGHJznkae9Jmt3EdpYwxGizBUt35Q0fuRyPR8jRy686Pll4
 XFne404f2kgiHI/LnvkhrGjUwRD0WRAYQ
X-Gm-Gg: ASbGncuKDZvNIje9suvBjEZUhKX+jNPRmO+L2hExEaLqpRn3zlNFJGuQIJNvvQKw+mb
 EZy1WqKrHoPUYxiXW4PILQJ7FnFp7gRgZUqtUiA==
X-Google-Smtp-Source: AGHT+IHh461JhzzFtVYzmBd2FGCZEmKLpp9JnCg+rk+kGPOt5LwC6spQPgLLBLaLlwpX0SmbiGFilKkG0tpACiZVvMQ=
X-Received: by 2002:a05:6512:1591:b0:53e:3ac2:9bfa with SMTP id
 2adb3069b0e04-54229533ac9mr12216678e87.23.1735813320531; Thu, 02 Jan 2025
 02:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
 <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
In-Reply-To: <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Thu, 2 Jan 2025 11:21:49 +0100
Message-ID: <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12b.google.com
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

First of all Happy New Year :)

On Mon, Dec 30, 2024 at 12:41=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:

[cut]

> > +
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        written =3D d->be_written[i] - d->be_min_written;
> > +        if (written) {
> > +            /* Written in the previous call so take into account */
> > +            ret =3D MIN(written, ret);
> > +            continue;
> > +        }
> > +        r =3D qemu_chr_fe_write(&d->backends[i], buf, len);
> > +        if (r < 0 && errno =3D=3D EAGAIN) {
> > +            /*
> > +             * Fail immediately if write would block. Expect to be cal=
led
> > +             * soon on watch wake up.
> > +             */
> > +            d->be_eagain_ind =3D i;
> > +            return r;
>
> But next attempt to write will loop over the same backend again, which
> will see the "same" write multiple times.

This case is handled by checking the difference between counters
`d->be_written[i]` and `d->be_min_written`. The idea is that device, which
already "swallowed" some portion of data, will be skipped from writing to i=
t,
until it catches up with the stream.

Please take a look into the `char_mux_be_test()` test case, where the
EAGAIN scenario is tested. The line test-char.c:716 explicitly shows the
repeat of the write procedure after EAGAIN was received.

>
> > +        } else if (r < 0) {
> > +            /*
> > +             * Ignore all other errors and pretend the entire buffer i=
s
> > +             * written to avoid this chardev being watched. This devic=
e
> > +             * becomes disabled until the following write succeeds, bu=
t
> > +             * writing continues to others.
> > +             */
> > +            r =3D len;
> > +        }
> > +        d->be_written[i] +=3D r;
> > +        ret =3D MIN(r, ret);
> > +    }
> > +    d->be_min_written +=3D ret;
> > +
> > +    return ret;
> > +}
>
> I am not sure what is the correct way to handle write here. This
> mux-be behaviour is different from mux-fe, since it handles all
> backend I/Os, and does not select one... it's more of a "mixer",
> right, Is this wanted?

Right. The intention is to have both consoles simultaneously
working, for example having char-based tio (over a socket chardev)
and image-based vnc (over a vc chardev):

    -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
    -chardev vc,id=3Dvc0 \

and both are connected to the same frontend device.

I agree with you on the "mixer" naming concern, this did not come to
my mind. As far as I understand the logic of `mux-fe`, it just doesn't seem
possible to have both frontends running at the same time, because they
will both generate output, at least that's the case for virtual consoles:
imagine you have two virtual console frontends working at the same time
and one backend. Any command you enter from a backend causes the two
separate frontends to output completely different data.

On the other hand, several backend devices can easily be simultaneously
attached to one frontend, the analogy is simple: several monitors, several
keyboards, etc work perfectly fine with a single PC. At least this is how
I see this, please correct me if I'm wrong.

Do you think we need to artificially introduce multiplexing logic to be ful=
ly
compliant with multiplexer naming? It's not hard to do, repeating
`mux_proc_byte()` from `mux-fe`. In my use-case, I'll still need to disable
multiplexing in favor of 'mixing', for example with the 'mixer=3Don' option=
,
i.e. '-chardev mux-be,mixer=3Don,...`. Or do you think it should be some
completely different beast, something like mixer chardev?

--
Roman

