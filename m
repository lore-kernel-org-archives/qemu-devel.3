Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AD5C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ray8e-0002h9-NE; Fri, 16 Feb 2024 08:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ray8Y-0002fu-Gk
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:20:19 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ray8V-0003st-VQ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:20:18 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5610cc8cc1aso2172651a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708089606; x=1708694406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHSkNjRYaRD78hXDuKc5JRGHV6XWvjaISU3qWggoygI=;
 b=ggjDy3ukaA9021pP/5CKMA/CAk8Hav78q+N5jzplOTJt+90+EDDNVfoOK8v2afQBRM
 JZMCOND2B0Dohp31wQAES3GEhCCj28bG2iT71au53CIVZVAfebYzUxdc0a/SEL6woC4t
 1rawdIlwxY6vZKNP5Z5OOscUTanPVZdlRtaRs6NjawyKeqFfeE9rb9SiXHSiMhRqYrZu
 A9N7AEg8oExzZ0bKmoxAuK8QAUtfjLd4bX1DKyde2j5lbOms1zVN1j0VNAPC0Ajeq8/3
 5gCN9Pzl72OlR6JrvoPcxExAHwvgNHdN6AsdUCy4+ahOXQrfBmzQvkyGhNM4ToFpweL9
 M62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089606; x=1708694406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHSkNjRYaRD78hXDuKc5JRGHV6XWvjaISU3qWggoygI=;
 b=eRx2ulLEl5RzKhSncQjT9ExueH7CJAdqitBCXhw8Hlea4NJmk/n3MND5hlOFO80rVD
 Ac87SPY0dAPK724NDtG3A7QZegHjDnALya3P4XOQOj75w7dhIoQ3P22cBtS0lZv4x8nG
 WLdlAbYBO0+2suj9rrdt5G5W8UEWfdxRD+VZcKYL2ntEzcyxjRrFQSA0UJRlIUylT7pN
 vj+rBy5uy+6mp2GswJpDbtw8d6T16MDOkCGRDEfTY2dscUZOZky/7JvnPEwEhiZOk8V9
 87B3/dP1lBnAYILcpYXupRmIzyjKVtO4/av41MvENBA3OPe4aNLtR8zQn1hiKPI/WLw/
 1Tgw==
X-Gm-Message-State: AOJu0Yz1N9KU4yV+pbpztjbd4tNnjbktumht9XuIX0JjU4eemkUyAgbC
 C6FdiyrwLhgF11AWy2er4FdzAmKKK8mstf+t51Bk4YV3MgXjSz+5jv6a5+i7nuUi9TX+07Wf2Ot
 ANevTkSL4B324Folnt2FAf8eGq0parMqp8BqbHw==
X-Google-Smtp-Source: AGHT+IFFyiIA210X95nzcc/G0MjXz1oxm5fFBAxjn+x1R2gL9Kt0ALCz0XPC5I9MmbSpovasHYbjC11sE4wPjgKQvm8=
X-Received: by 2002:a05:6402:148d:b0:561:dd88:efde with SMTP id
 e13-20020a056402148d00b00561dd88efdemr3587024edv.27.1708089606082; Fri, 16
 Feb 2024 05:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20240215155009.2422335-1-peter.maydell@linaro.org>
 <87y1bk4pfz.fsf@draig.linaro.org>
In-Reply-To: <87y1bk4pfz.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2024 13:19:54 +0000
Message-ID: <CAFEAcA-7S7QOBzDBS0UmWDxK=2AWuX1QFZ-TCfvCOOhJpL-wng@mail.gmail.com>
Subject: Re: [PATCH] .gitlab-ci/windows.yml: Don't install libusb or spice
 packages on 32-bit
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 16 Feb 2024 at 11:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > When msys2 updated their libusb packages to libusb 1.0.27, they
> > dropped support for building them for mingw32, leaving only mingw64
> > packages.  This broke our CI job, as the 'pacman' package install now
> > fails with:
> >
> > error: target not found: mingw-w64-i686-libusb
> > error: target not found: mingw-w64-i686-usbredir
> >
> > (both these binary packages are from the libusb source package).
> >
> > Similarly, spice is now 64-bit only:
> > error: target not found: mingw-w64-i686-spice
> >
> > Fix this by dropping these packages from the list we install for our
> > msys2-32bit build.  We do this with a simple mechanism for the
> > msys2-64bit and msys2-32bit jobs to specify a list of extra packages
> > to install on top of the common ones we install for both jobs.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2160
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Queued to testing/next, thanks.

I'm just testing a merge where I've applied this directly to
get our CI back to green, so you don't need to take it via
your tree.

thanks
-- PMM

