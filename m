Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E86DC3DA63
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 08:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXGAq-0000pU-6E; Fri, 26 Jul 2024 04:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sXGAm-0000om-F8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 04:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sXGAj-0001JI-HH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 04:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721981966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O2Z5DEYOnaJ3MdLFNPFWVnbP9uiLPsh9LAOmjimmjU=;
 b=TDavt7mv6ckMCvJZ2YFLpCS715W8L7YHpfhaXxhPdM5OyqGoKqEvoPfXUQJfutnkYG+65T
 RlgQE/9sNfAlKUtx3UvpBheifNIZphwq5S9apQTzaEAwUt1ihPWne6xntUZxbryfoUkDJy
 ETw4o/WKwq/9+mr7cCsKLXjy8L/DJtA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-6FrBfoc3PY2w9HeWm1nraw-1; Fri, 26 Jul 2024 04:19:23 -0400
X-MC-Unique: 6FrBfoc3PY2w9HeWm1nraw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef205d48ebso8999681fa.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 01:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721981961; x=1722586761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4O2Z5DEYOnaJ3MdLFNPFWVnbP9uiLPsh9LAOmjimmjU=;
 b=n7t/hparp86GmbOaS+SB43vsIQCfaiQ/E9L19F0/2bIrdAU4LPBDdmSu6AjEK5qEsY
 qJiG+/SVCEF5WLv0M8ixW9hv9g0nX3bBgNrqGhaSjSShA5B8YjnqLcxF+/ojsHZHdk0B
 d88xx37DTPfoLk11fV9jshDNcUofgWFu2ZM898gw1eAAIWlf0ZRiVpDAuODB/nx24Kcw
 +rrdf/6B6WJKucu86U45ceyHkQVqqG8eKCxtiRjalzPjwX0M+Ip8GQHPeoXXw5Gt17+L
 SkMYuMqH8Y+KukS5wIGRWSnNw335aUbCEsHywY+GfddZiYXDUUxZpo3dB4NAVnBtNS28
 iF0Q==
X-Gm-Message-State: AOJu0Yyis3yfjyQY02GEpSEVm9OO81jO8tlGnqVLqLl3BBZVi6tsh6mQ
 lOiDXZNgDNdIsFO8xu6Dj9+Tf/IFgSb6IBz482NQ4nkJ31zgGHp2HiW5N61qNen4K6FLXqT0am3
 isJEv/Tbe47by9SxoW4x/5OIiJbdyOPNDvtvTMmaa75uBnyZ1R9zUfxTynm21hhCGxucVKiSCM6
 t25+JOHDx7DSuwo7qxidVtlbL5IcY=
X-Received: by 2002:a2e:8704:0:b0:2ef:18a2:9deb with SMTP id
 38308e7fff4ca-2f03db7ff70mr28043671fa.16.1721981961643; 
 Fri, 26 Jul 2024 01:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWijSiiw+YFqUXYKYEl3LBykhLth+hZ/M2Tn8m3QsvIs2fkJ5HGM3QyZZfGfKT59k+aCNCoZV0DHMYukAUBzk=
X-Received: by 2002:a2e:8704:0:b0:2ef:18a2:9deb with SMTP id
 38308e7fff4ca-2f03db7ff70mr28043381fa.16.1721981961271; Fri, 26 Jul 2024
 01:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
 <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
 <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
 <h7zb4.aog50x8tfxkp@linaro.org>
In-Reply-To: <h7zb4.aog50x8tfxkp@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jul 2024 10:19:09 +0200
Message-ID: <CABgObfbJjcwXcJ-=c7yfXQX=xLnqqVsvDqibrFgiLPm4C_uC6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 9:26=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, 25 Jul 2024 18:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >On Thu, Jul 25, 2024 at 4:48=E2=80=AFPM Manos Pitsidianakis
> ><manos.pitsidianakis@linaro.org> wrote:
> >> > pl011_receive (called by qemu_chr_fe_accept_input) creates a mutable
> >> > reference that *overlaps* the lifetime of the outer reference create=
d
> >> > by pl011_read. This is undefined behavior. You're effectively writin=
g:
> >>
> >> There is no overlap there, sorry. Once qemu_chr_fe_accept_input
> >> returns, any references it created do not exist anymore.
> >
> >read     |-------------|
> >receive      |-----|
> >
> >That's the overlap. Maybe you're thinking that the outer &mut "goes to
> >sleep" and is reborn when qemu_chr_fe_accept_input() returns, but
> >there's no such thing in the language.
>
> There's no overlap, because the read scope is not live while receive is
> active. References are linear types, when you give `&mut sth` as an
> argument to a function call, you can model it in your mind as "giving
> the mutual reference to the function call" and "receiving it back" when
> it returns.

There is no such thing as "being active", the only exception being
when you create an &mut from *the same* &mut.

To clarify further: in principle, if you have code like this in pl011_read(=
):

  self.a =3D 42;
  qemu_chr_accept_input(self.chardev);
  return self.a

The compiler can optimize the second "self.a" to 42. The optimization
is incorrect if pl011_receive() overwrites "self.a". But that's not a
problem with the optimization, it's a problem with what
pl011_receive() does.

In other words, the *mere existence* of a &mut in an outer scope makes
it invalid to create *another* &mut pointing to the same memory in an
inner scope.

As I said, I don't see the point in discussing this more, and I'm not
going to unless you provide a clear pointer to documentation that
states the opposite.

Paolo

> There'd be an overlap if qemu_chr_fe_accept_input got two mutual
> references of the same memory location, such as calling foo(&mut self,
> &mut self) with foo being `fn foo(a: &mut T, b: &mut T)`.


