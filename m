Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B82CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 19:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEXrV-0002Yr-1N; Thu, 30 Oct 2025 14:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vEXrN-0002Xp-To
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vEXrF-0008U7-KJ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 14:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761850723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZJTHrulz/Y8xy/Wt+NPAp6SLBx85QyQsM/vhZTgRDE=;
 b=NO9wSWvYGQZYX5+xqUZlw07isCleHl8bHeCmohfGXqOXIKHPSs7Itgoret8d4adUNqyb95
 EkIEW8/OTrz8HrHICtfSWejb32akdOCXAAvJeJjlv+bL+/PBcr5bRSq/7P7CptoylyuLag
 OsC8GuqMAV6kaQxr13te6/uZYsm3KeY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-RU7NbIpbOI68e0U-ApcbYw-1; Thu, 30 Oct 2025 14:58:42 -0400
X-MC-Unique: RU7NbIpbOI68e0U-ApcbYw-1
X-Mimecast-MFC-AGG-ID: RU7NbIpbOI68e0U-ApcbYw_1761850721
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-782c219f163so23138437b3.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 11:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761850721; x=1762455521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZJTHrulz/Y8xy/Wt+NPAp6SLBx85QyQsM/vhZTgRDE=;
 b=gty4jkz+2B2ULrTEWig9dnWYVpchwDIMz9/NIt2LoPT6e5edWjNMABsflHC+/1knbJ
 0aRk9+WluMj1OplsN41msOltUsLflXZ84qptBKO9ywOKDjF/1UjqXbGlDXIlMyv4zpUR
 YTQRtZyKbw/V6v4bxrTd3xtiHJRjONjxIMzx7Qh41BkpIJeNr9tkY2bwyYczCxIQj/2A
 jsVjWQy1B56dt/I0FZy27QFiNUCbia1IzBz0l418iiSqx/TDOfqFgo6W0L0eYIH8aMiZ
 +3zs8nrxRkEX/n69UZTnkXUaj01hehIE5+Rp+A4aL+erMSi0vKNqHKi34ESUZcWRG5wO
 77Og==
X-Gm-Message-State: AOJu0YySLieDwer7yFmy+jFiKLZt5ZDMU6jxcUbZ2OppDWo7zsbZHbgM
 nfAncdG1qr4MQNr3YwjlFRFkYQHc+ScrteVAdzB8Jh+Mvs/sE4ki/X+Hl7piQQVlIgJmgJmPhgl
 P9qT8li61OX8/+PRJWAzk6M95fC544/2uBYpJa0YhlvrsX0g5QUWCJhh/TeEa9AiATj/xslDWxF
 idx1H63ag1cYCk7mbI7Da8ZvN2G0mH01k=
X-Gm-Gg: ASbGncvQTPCFcrXsZuhEycon1ojJN4jRcOydqHfp4+QptMpDkdS/qZXbLk/g35ssVR5
 yNvWJFn4gqbKp8H0VSSsKl6Jg0bm5fa1tcMvx8ozl/RpXIt/txkrgXmG3S0r5ATcBvHx2kmFHgB
 LCLRvb/8+9lqpdm5BSINE0CuHPjCjGQmb/JbHClEaGF+RA/DFVheQQG9nNwdqAxb8545TU2tf7w
 LO5xO+5P5gqtCQ=
X-Received: by 2002:a05:690c:fd6:b0:784:8a26:b74 with SMTP id
 00721157ae682-786482301cbmr6434367b3.0.1761850721434; 
 Thu, 30 Oct 2025 11:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWNfdzhdpv9U+DnuxMU3U7qejQkucdHKrJ70Ema7Xw4A+ua96jcROa7vD3CSTnKdWSqL81sbf4MSITXX7EZqU=
X-Received: by 2002:a05:690c:fd6:b0:784:8a26:b74 with SMTP id
 00721157ae682-786482301cbmr6434077b3.0.1761850721031; Thu, 30 Oct 2025
 11:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-7-jsnow@redhat.com>
 <652efa4c-8ee8-4fb0-bf89-09adfb53df2e@redhat.com>
In-Reply-To: <652efa4c-8ee8-4fb0-bf89-09adfb53df2e@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Oct 2025 14:58:30 -0400
X-Gm-Features: AWmQ_bmJboVL1gNB-NAVauqVkmZJGQkUhDoCwJCWwmdoGPZe4ow0NeB95ht1dvo
Message-ID: <CAFn=p-amC0xC9v1wnR+6heHOgu+-igeZeWmgKcuPjnPrVS=gPg@mail.gmail.com>
Subject: Re: [PATCH RFC 06/10] python/mkvenv: add "tests" dependency group
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 4:40=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 28/10/2025 23.03, John Snow wrote:
> > This group is intended for packages required to run "make check"
> > successfully. Once qemu.qmp is fully divorced from the source tree, thi=
s
> > will primarily mean the qemu.qmp package. It specifically excludes
> > packages only needed to run the functional tests, which are not invoked
> > by default for "make check".
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   pythondeps.toml | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 3d6907af799..70e83320855 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -31,6 +31,9 @@ meson =3D { accepted =3D ">=3D1.9.0", installed =3D "=
1.9.0", canary =3D "meson" }
> >   sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "6.2.1", canary =
=3D "sphinx-build" }
> >   sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.2.2" =
}
> >
> > +[tests]
> > +qemu_qmp =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> > +
> >   [functests]
> >   qemu_qmp =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> >   pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
>
> Hmm, "tests" is a string that is very hard to grep for, since it's used a=
ll
> over the place. Could we maybe continue to call this section "testdeps" o=
r
> something else that is more unique?

Sure, you got it. I think I did name it that at one point and then
said "Well, these are all deps, that's kind of redundant", but
greppability is a reasonable thing.

checktests?

>
> Also, could the qemu_qmp be removed from the [functests] section now? As
> long as the python/qemu/qmp folder has not been removed yet, it should no=
t
> be necessary - and as soon as it has been removed, the generic venv from
> "[tests]" should be in place, shouldn't it?

Sure, that's one way.

Pattern #1: each dependency group should contain everything it needs
to run the tests/functionality associated with that dependency group
Pattern #2: each dependency group should specify only the unique
packages associated with that functionality

#1: dep groups are self-contained and easy to invoke, but dep groups
could theoretically drift with conflicting package versions.
#2: package deps are factored out and can't conflict, but those
modifying the build system may need to remember that they need
multiple dependency groups for certain classes of test.

I went with #1; if we go to #2, it just means that functests need to
have a dependency on both tests/functests groups. That's fine too.
Which is better? I don't really actually have enough insight to have a
preference on this one. RFC?

On the subject of "make check-venv": I wasn't able to figure out how
to really specify the deps for functests yet, I am still kind of
hammering away at it like a child with a squeaky toy hammer... "make
check" will invoke (some) iotests; the deps I added to meson in this
series will adequately detect and cover this when you run this
high-level target. However, "make check" will also run some of the
func+quick tests, and I *didn't* specify the dependency there, and if
you run make check with -j#, those tests can actually fail. (Well,
once the in-tree library is removed, that is.)

Ideally I want to get rid of "make check-venv" entirely and use only
meson targets that add dependency groups on demand, so I need to
figure out the right places to inject these dependencies in the build
system, and I've been having trouble figuring that out.

>
> So maybe you could merge this patch with the previous one, simplifying th=
e
> change here to something like this:
>
> diff --git a/pythondeps.toml b/pythondeps.toml
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -33,4 +33,6 @@ sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installe=
d =3D "1.2.2" }
>
>   [testdeps]
>   qemu_qmp =3D { accepted =3D ">=3D0.0.5", installed =3D "0.0.5" }
> +
> +[functests]
>   pygdbmi =3D { accepted =3D ">=3D0.11.0.0", installed =3D "0.11.0.0" }
>
> ?

If after my waffling above you still think that's the right way to go,
I'm happy to do it. I just need to figure out how to axe the
check-venv target, too, I think.

>
>   Thomas
>


