Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB88FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzlc-0007FO-PX; Thu, 25 Jul 2024 10:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWzlZ-0007D0-4e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:48:25 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWzlX-0008Fm-BT
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:48:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc3447fso1203571a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721918901; x=1722523701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmJX42L9SJseN6ehRN6HqiclsKdbasrMvCTaZYYDmXA=;
 b=k5iD5LmDD3czPQ1PWgb3nEFiepfod8EmO3JIs4MwuTbPGj/YazLH4HmlR9Z1sThTPz
 WzPXbtMebl8YXCVP0ckk+uqPXBKZO0/PfYp8K23Ijhyduxepqn+kweAzQ0rUlydUgR00
 vh/XzoAtlIn/HdAms0Clj1pPiAeTFJFX/GNpG5Q+eWI8mEwDtYM+rZU1dZhYdC+XUsNS
 PaVp6hBdCrhgwH9h3R7qjLM7ICLyrHAlOwZu5Ev1y28Ol6/vSaRti45wLq65a9vc7CpM
 lOxnDLk4F/jUBM3xXQMAlfOSuNFgDew7v6sDj6CClYBKDyn19B1UiQ4V4iUmaChyqTND
 RZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721918901; x=1722523701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmJX42L9SJseN6ehRN6HqiclsKdbasrMvCTaZYYDmXA=;
 b=uU0RXfZn5QtRVkHafSx0M4NW4fQG3ca7pL8vN0zjeMasP7kB5HhrhxofXIDrHDpJmc
 0YUH9WtYV5ukRmyARAomjBXQuSLsv2Vhus/VJimL3jBiYWs5+zYBWid2UpbjlqX8fbo1
 8ewuYOnDbSSuV/T+WLSHrDKhx4djdwaGjyhND1ls6ivOUOOh2VgPJFqZaZsIpy/Uipo5
 f+G9PWsjaJ2OrJfsVlVitYfjTGsyJSSRyM7hsiclxSFut6bykVme9GG0HHY+2QDoIhJu
 VATA4wZyFltsE3IsBQGodF+TMG4zsJ2aj9eMO+syd726mTdK3c+1BzgGmEYffFXR8vHA
 nMKA==
X-Gm-Message-State: AOJu0YzozTO5EixuRmVQ0dV9Y+ZaLHE9KM6eSnVqqwS0jWyyDoVbypH+
 1jCoVSW21zi3ytRwQR4lKB/anmpwtKIM2eopUqFqyv7zb1hm/2Um7ym5hS/lskQaLzGpHjE2MI0
 6OUuudBLVygxlY93NSC2DqQlHqKEmdZfKlJv3cQ==
X-Google-Smtp-Source: AGHT+IH12O2fGUGfvfJey9EzK+i07ZJJPPGatVdONGdBQ5dULpptM00St8NmP6aykCs4pFiOBq9aAbYgTtLG9IP6eV4=
X-Received: by 2002:a50:bae7:0:b0:5a7:464a:ac4 with SMTP id
 4fb4d7f45d1cf-5ac64cc8673mr1681795a12.30.1721918900810; Thu, 25 Jul 2024
 07:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
In-Reply-To: <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 25 Jul 2024 17:48:04 +0300
Message-ID: <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Paolo Bonzini <pbonzini@redhat.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 25 Jul 2024 at 14:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Thu, Jul 25, 2024 at 12:14=E2=80=AFPM Manos Pitsidianakis
> <manos.pitsidianakis@linaro.org> wrote:
> > >Unfortunately that's a *mut, not a &mut. A &mut must be unique, so the=
 cast
> > >in pl011_read() is undefined behavior.
> >
> > Actually it's:
> >
> >   unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
> >
> > And you can ensure there's no disjoint borrowing by making a wrapper
> > function that mutably borrows self, e.g.
> >
> > fn accept_input(&mut self) {
> >   unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
> > }
> >
> > This is not undefined behavior, since the cast in pl011_read creates a
> > mutable reference that does not outlive the same call to pl011_read.
>
> pl011_receive (called by qemu_chr_fe_accept_input) creates a mutable
> reference that *overlaps* the lifetime of the outer reference created
> by pl011_read. This is undefined behavior. You're effectively writing:

There is no overlap there, sorry. Once qemu_chr_fe_accept_input
returns, any references it created do not exist anymore.

