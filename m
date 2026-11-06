Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF67606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/zThzhv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNrm-0006EQ-SJ; Fri, 06 Nov 2026 12:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPNrj-0006E9-28
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:36:39 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPNrf-0005GC-SJ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:36:38 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b4a13789b0so1242269a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:36:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793986594; cv=none;
 d=google.com; s=arc-20260327;
 b=qdmX8i+ODseRtOQNP1/FtYvU3wklXryLZ5nrU/xfJKtrzgCKMyZk68h1tfzJtBSlGz
 QdOBQvubO2/EicvI6knGM0u7Yyvnhe8Up8xazkCMGFpGHjL6O/g37H1pU5X5h3EYbEms
 WtBnGu0vz13jnbQWf1i0MvyX+XwYrpaYyfBDniPNFRAWqEZ1Hw6IbsQuhhme8RshWrAQ
 +CGHwWc/1Y3bdzN1R4yJve+UxLLosrLg0k80f1X2zh/8hLUHteXVUMirV9HP6Uh/pRQ9
 Zt0ZiY86G3xY58OyvrUFyYjzOmT7p4UkX+PqtsbAQBWAFlaZ15eh7xFH3T0VSlFQfYbh
 07HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=AHWHS7iXViyeYaND6RidD3ZzNURHAJ1Z9nTkxXYjggw=;
 fh=PeSTUXKF+tqzwTWvp6LJea/nfGVyw87p+eab1c9SUIs=;
 b=q4F4zzZQPir99Uli6vPemOV7OlCPeJLBO1c1cyKDrDwCIwi7wbWZnbS/pZv+YrbH46
 qzVn1QMWZtT349avpw2SBYcV9ZwP7snM7m8t3iNx7FmJF1Yg41PfjVyoXjVCCWOc5yLg
 I98mdBc9UJ5OT8mYzSWZr7bbt5RFpdTdJyTubVZJrXs+aOLX4+UowXZp06bp8bA9EmRc
 HfLUvoPervK7+r8rgggByOBuyXTROLYTCzDHhjfC4Rbnm4DvEdctELHpQ6XhzS6zvdsc
 FI0bp+G66fHPBxtvTMA5KtvI+CZr10UvYArZn4AIpThnwBH/Xqtwo/brCRKKmRarIecw
 5nDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793986594; x=1794591394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AHWHS7iXViyeYaND6RidD3ZzNURHAJ1Z9nTkxXYjggw=;
 b=D/zThzhvD2HZXiZdFnaR6OaozY4nbA/flPJ2rvw8/CobJxdOjSJgKccWLZWqPNZobx
 xJaYZ/S/vtOnJBFfexU9D7oRETd+DqOq0A2iHzVhDAPKl8mkLtilDqEixqqg8NkcCjEN
 xyTvD7yCWV575xw4SdTpQWXVfZQeSzEu9pcJoxh1IJMh/BfMtgeywjfe+8ArItzDaTUd
 dtJrVS+pkjSmM345Nx8W2dyKAINeDOvDi9+I/NTDKWO/KWxqgos5ihf+GzDzz4h6YYoR
 gufz3Jo18DrL9YceYDswduG5IoeeioOIMlKfc2AMnPrex98uBO89D0Nr6/CsnSXFFsGz
 ORyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793986594; x=1794591394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AHWHS7iXViyeYaND6RidD3ZzNURHAJ1Z9nTkxXYjggw=;
 b=Km3nVJc3iDArIVhak/8W9cH33+2nwe7PBeFWmRD4Tg/PVG524yKEb45Y/fIj6afXo/
 lz8X5j7M+3EptiH924Ha4kd/XyzBwuhqbOMQuioYnjMuotTKv0SzYupv2e9AncwFCSFI
 uMH/Hz3v3ZaNTPPnu4N8YuD0g96/SsZHAv1TzTArr45BhVY2/eYwYwQQKrsFLufb2FMh
 HEpfsRdHAXHklK0+/IKk4hcbD6AXA67TlSos08jpqzNIOkJ+xksN5lrsLbjNXTt/v501
 cOAxtHBcYjHFa0nk/JreQdzv9lzxuWK9CtwQbfCe86dWBUwl7Mxn5RX8U+UV7zzj54Nx
 00jQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMFQgi6T5argRb3puHka6CI6juD/GxxaaB8EPZQ0IUw48UAkdchOp2rDJMrM1Ke4t9hC2VmLdpXg3O@nongnu.org
X-Gm-Message-State: APuU4Z9IOOcP8aKAyp/t6j2abfdxFoIBHnyiH2+PD9kbfKkPsCBv2Vp1
 LxySkmu1Qcof0gGbEGQ6z/S48n5Hqju68MEWTKLlHFpa8VOK4r3Pqlwt0ggG2G32/A9Nubz18Xd
 bWzoo4ZFRlLxLXBOBA7Vzf2pEfOQH/yQ=
X-Gm-Gg: AYBFou0gtgoxOMStH0PDjq+ogATqJWm9fOas9Wa35rmueCSpOc5VZn7QVUXO3MFhuIL
 MFfzM5k2qxzPTdUzXKeXvYz8+LgkUhlmawlewLKGxL3Pw8Y9tXswLI1wsWvd4nWCrB3BI3e/JQD
 Lf2xeTVGa/UEdZ5m4E3laoC4LzWEnGq+UEqIhufPxK9yXmx1lj7rnqin1RiK9Qe6ToMqi44BgOw
 BIM6dVBVGNV3fbcW8JvVlEIQUWUmPCkMezPFQDp28QQhxGhXsUFOFvpKljvupnRZH0dIFqMw45N
 3bKizIXXahFh3nOz5PFKOkLnzJwhQdULrZm4f2hu3m6S8bAilRNATE6gG8Z2grX8uHgJcf3wuX3
 LS0V2DQgC742M9mN7kU5oj/d+lEnAfXQy5IbX
X-Received: by 2002:a05:6402:1ed1:b0:6b5:8297:f44e with SMTP id
 4fb4d7f45d1cf-6b5977a476emr2694179a12.5.1793986593661; Fri, 06 Nov 2026
 09:36:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
 <20261106155858.3779237-2-peter.maydell@linaro.org>
 <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
 <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
 <8b2c47e7-589a-4e5f-b46d-11cf336e9a1c@oss.qualcomm.com>
In-Reply-To: <8b2c47e7-589a-4e5f-b46d-11cf336e9a1c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 01:36:19 +0800
X-Gm-Features: AclHuK-msJmjUcpi85lbJw3mB9LNmU4hRZbXgC6Ug6F23aKaNY7JxJ5zDhhiObQ
Message-ID: <CAE2XoE_G286LmaBCh4R+C2_-f=d7EDgPkZ2zzx9E6U2_SRWriA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh
 directly in meson.build"
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 1:27=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/6/2026 9:06 AM, Peter Maydell wrote:
> > On Fri, 6 Nov 2026 at 16:59, Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 11/6/2026 7:58 AM, Peter Maydell wrote:
> >>> This reverts commit ab78ac76f44a1241e76fd32d248df62d83f1ea58.
> >>>
> >>> The change to create the version header in meson.build loses
> >>> the dependency needed for the header file to be built when
> >>> it doesn't exist. This means that:
> >>>
> >>>  * if you delete the build/qemu-version.h file, an incremental
> >>>    rebuild fails, rather than recreating it
> >>
> >> That's not what I observe. From current master, file is correctly
> >> recreated. Do you still observe a problem with a clean build folder?
> >
> > Yes.
> >
> > $ git log --oneline -1
> > f71afb409a8 Merge tag 'pull-loongarch-20261105' of
> > https://github.com/bibo-mao/qemu into staging
> > $ rm -rf build/arm && mkdir build/arm && (cd build/arm &&
> > '../../configure'
> > '--target-list=3Darm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-lin=
ux-user,aarch64_be-linux-user'
> > '--cc=3Dccache gcc' '--with-pkgversion=3Dpm215' '--enable-debug'
> > '--enable-docs') && make -C build/arm -j20
> > [...]
> > $ make -C build/arm -j20
> > make: Entering directory '/home/pm215/qemu/build/arm'
> > [1/35] Generating tests/include/QAPI test (include) with a custom comma=
nd
> > make: Leaving directory '/home/pm215/qemu/build/arm'
> > $ make -C build/arm -j20
> > make: Entering directory '/home/pm215/qemu/build/arm'
> > [1/27] Compiling C object qga/qemu-ga.p/main.c.o
> > FAILED: qga/qemu-ga.p/main.c.o
> > /usr/bin/ccache gcc -m64 -Iqga/qemu-ga.p -Iqga -I../../qga -I. -Iqapi
> > -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0
> > -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=3Dauto
> > -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 -g -mcx16 -msse2
> > -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> > -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=3Dzero
> > -fzero-call-used-regs=3Dused-gpr -fstack-protector-strong -Wempty-body
> > -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=3D2
> > -Wformat-security -Wformat-y2k -Wignored-qualifiers
> > -Wimplicit-fallthrough=3D2 -Winit-self -Wmissing-format-attribute
> > -Wmissing-prototypes -Wnested-externs -Wold-style-declaration
> > -Wold-style-definition -Wredundant-decls -Wshadow=3Dlocal
> > -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings
> > -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
> > -isystem /home/pm215/qemu/linux-headers -isystem linux-headers -iquote
> > . -iquote /home/pm215/qemu -iquote /home/pm215/qemu/include -iquote
> > /home/pm215/qemu/host/include/x86_64 -iquote
> > /home/pm215/qemu/host/include/generic -iquote
> > /home/pm215/qemu/tcg/x86_64 -pthread -fPIE -MD -MQ
> > qga/qemu-ga.p/main.c.o -MF qga/qemu-ga.p/main.c.o.d -o
> > qga/qemu-ga.p/main.c.o -c ../../qga/main.c
> > In file included from ../../qga/main.c:33:
> > /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> > qemu-version.h: No such file or directory
> >    11 | #include "qemu-version.h"
> >       |          ^~~~~~~~~~~~~~~~
> > compilation terminated.
> > [etc]
> >
> > I have run into this problem about a dozen times this week with
> > different build trees and different git branches, and it is very
> > annoying.
> >
> >> The problem seems to be crossing this commit, which we can't do anythi=
ng
> >> about since it's there.
> >
> > Yeah, it's going to be a broken git bisect for that part of
> > history, which is unavoidable. But the current state of git
> > is (a) broken and (b) not clearly what we actually want, per
> > the other thread.
> >
> > -- PMM
>
> I see, the missing bit I didn't use is '--with-pkgversion=3Dpm215'.
> Without it, it works fine.
>
> Any reason you use it for dev builds?
>
> Seems to be something related to releases, which probably won't use
> incremental builds.

Oh, I am using it in daily work, and indeed I like these changes(not
reverting it is better for me) :)

I am using rsync to cause it to build remotely, so that I have no .git fold=
er.

>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

