Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0884DC531FA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvlb-0001r5-1G; Thu, 23 Jul 2026 11:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmvlZ-0001qe-Ce
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:55:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wmvlX-0006Me-CJ
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:55:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso4821875e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784822117; x=1785426917; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t/qjs/kcjsjlUlS+e6zYNe6oYvf2TVcaugfO6w/WhZ8=;
 b=F+Z334E4eHKqnBHvijYkuZn5tqLs3E+rVTNB3CPO2K8EaDBDjx/NNl7x3XIlCtj+dJ
 2oEwYv6odFb8pKUQ3V8ZcjaUJ/SZ5ZcBAI1OYkgBnHKTUiRyU6lIN9opDngiAYElu3ad
 r45JtL0ZqOc0Y0Def1j5f1LPK0KyVhLRkf/UZUwij3FXfdRrHwY6xxa4LDmOdk1HvjtB
 ZzSiEvqMPoq4MDbHyiw/NR42qKjjZuvx/7w00ecrh26UiblOWLYEmsWHyckJP+IFqxUt
 aAvycnmJF5xA4WJCvweQgPh4HYxlimJqV1dn60ElI4gEM0v3FPVnoaCPLnoQKXZHUAJG
 zJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822117; x=1785426917;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t/qjs/kcjsjlUlS+e6zYNe6oYvf2TVcaugfO6w/WhZ8=;
 b=nQAi48WrcFjHHel0QI5gZZ0ZQ6bE5BGtsM3m+RWtGaY9Q37Wpgj8uHCyLSOdShkx+x
 +byknjhWhQ04bLdGEQ3QgTRC5U9ZNFrSY8csB/O4qNG3M5t7XE0yvVSsKKRuvMMEf4K0
 2iUPgaErdwNEYKIGWpu0WEBvmHkd67msHDOw44xtjxcCzEvJhIL/BCb+B4MLqM7dqyW0
 g969tGmvCTu5RRJd6vgx+nnuo18BDActV8CBltCItjiTJx23KU5bEBw6V3YSqaSWtJpp
 2hzjyg6OgnSM7uYIIoc/N03oRUgM6Sdx4UcZGLF4yz882VGp+cX+qnxC5skjcHAm63gs
 yrig==
X-Gm-Message-State: AOJu0Yx/bzlegGHlDMY1CBoO+iNvzJnGVl9MNKAQf7Ux0huQyj3obb3R
 Ao4REXlG57bow0XYCeCRsYm85jPQaaEqmNDL4nW8ZM4TYgy1Z60YenCY07Fq4B1ioJw=
X-Gm-Gg: AR+sD11JtJh72NBRmt8nZTUXejPJ/X8Raw2x7qUMbhoVr1ZGC7hQ4eEoCtbl6ptiaWQ
 3WEmHMgovYH1qHy9VAVzsMy6Ave47+4G/gEd5ISWCXIiBvgWXEn3sc/fsYvKS41XLayy5zTPHxm
 xuTTqpMOCjeF4H7FsbpHjLKMElqQRC0Z3BQKqACTZ1hskUkORqO9aM21wOC92+3JbVCIu5nF8WD
 M1/HukdYWo+9H3LOwA1uecsLyap2F/Frii8et4EcfxeoKaZuKPz0i8G58lhCnBV5pY0Ug4woSDI
 DkpImlPCuQVbVjLK5F+IrLBucF1QwUdCv6TYnE9XY5zwC7k5SETCjr/lNPPQWKN83PF33JBZi7R
 9KKjdE36uls0a1qLj4bWGgwGycsMxREax7pBn1KckbdXTQW/678UHmJtxyICw53K+zxm5APlW1w
 DL/w==
X-Received: by 2002:a05:600c:3b0e:b0:495:7a23:1eee with SMTP id
 5b1f17b1804b1-4957a231fc7mr5893545e9.12.1784822116613; 
 Thu, 23 Jul 2026 08:55:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c53052sm16369110f8f.18.2026.07.23.08.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:55:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97AB75F7C2;
 Thu, 23 Jul 2026 16:55:14 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
In-Reply-To: <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Mon, 20 Jul 2026 10:53:12 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
 <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Thu, 23 Jul 2026 16:55:14 +0100
Message-ID: <87se59r999.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 7/20/2026 6:14 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> Those options were useful a few years ago, before containers were
>>> available as an alternative for missing cross compilers. Simplify the
>>> workflow by removing those options and maintaining only the container
>>> based approach.
>>
>
> I was expecting some discussion around this patch, and to start it when
> the comment comes. Question is "Should we provide this feature or not?".
> I totally agree with you that we need to support other configurations we
> have in our CI, like MacOS and compilers from homebrew.
>
> However, instead of implementing this by keeping --cross-* options, I
> would be more keen to turn 'cc' into a list, instead of fixed choice.
>
> For instance, instead of:
> # tests/tcg/aarch64/meson.build
>   tcg_tests +=3D {
>     'aarch64-linux-user': {
>       'cc': 'aarch64-linux-gnu-gcc',
>     ...
>
> We could have:
>   tcg_tests +=3D {
>     'aarch64-linux-user': {
>       'cc': ['aarch64-linux-gnu-gcc', 'some_other_variant-gcc'],
>     ...

The trouble is this will lead to quite a long list as every distro has
its own naming ABI. While Debian covers most things its not everything.

> I think it's a saner choice, because one problem with --cross-* is that
> it allows people and maintainers to have their "own" setup, that are not
> documented anywhere. By forcing compilers to be added to dockerfiles and
> paths to be explicit in arch files, we make sure the same CI is
> reproducible for everyone.

I agree the ideal is everything is dockerised for CI but there are times
its not practical:

  - working with very new features on bleeding edge compilers
  - binary only toolchains for the more niche architectures
  - unable to run any containers
  - running the test inside containers (this is why
    debian-all-test-cross has qemu-minimal pre-reqs)

> A good example of that is xtensaeb, which was not in docker container
> file because it could be set with cross-cc-xtensaeb.

I suspect it was more because its a niche of a niche of a
under-maintained port and it just hadn't been gotten round to.

>
>> I'm confused here - I thought we wanted to keep local cross compilers
>> and provide containers as the fallback. Otherwise it will be very
>> difficult to test against newer compilers without having to rebuild the
>> containers.
>>
>
> That's exactly the point. By making it hard, you force by design things
> to be reproductible by anyone and documented. In this case, by forcing
> the people who wants a newer compiler to provide a dockerfile patch for i=
t.
>
> Another example is the aarch64 test with have require a bleeding gcc-16.
> It's not even installable via debian repositories at the moment, it
> means the test is just always skipped in CI. So basically, it's not
> testing anything out of the original developer's machine who has the
> "right" setup. In this case, the right fix is not rely on latest gcc,
> but add manual the needed opcode so it works on any version (see patch
> included in current series).

Hand coding the opcode will work for now, but eventually the gcc's will
be updated and we can generate from gcc. It's easier to extend tests
will inline assembly than hand encoding ops.

> For those reasons, I'm really much more in favor to provide a default
> that works out of the box, instead of "it works on my machine with a
> custom configure option".

I agree the default should be working out of the box but I still think
this is removing developer flexibility which will result in an up-front
barrier to getting tests in meaning they are just as likely not to get
written than the developer going through the process of working out how
to package the compiler.

>
> What do you think?
>
>> Currently the MacOS build relies on local compilers built via brew.
>>
>
> Let me know which compiler is used on MacOS for cross compiling every
> arch, and I can add those to next version, so it can work out of the
> box.

 Cross compilers=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20
    aarch64                         : aarch64-elf-gcc
    i386                            : i686-elf-gcc=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20
    x86_64                          : x86_64-elf-gcc=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20

but brew also packages:

  arm-none-eabi-gcc
  riscv64-elf-gcc
  m68k-elf-gcc

The arm one isn't being picked up at the moment, I need to debug that.
The other two aren't yet useful until we have system mode tcg tests for
those guests.

>
> Regards,
> Pierrick

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

