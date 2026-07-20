Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC816C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlq3C-0002Iu-UV; Mon, 20 Jul 2026 11:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wlq31-0002FE-H7
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:36:51 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wlq2z-0002ks-2A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 11:36:50 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso7966916a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784561807; cv=none;
 d=google.com; s=arc-20260327;
 b=Zd9r7uCiYO9C073AP0DPWbR4Mx8pIHzTG2owhOIyZpY2Awe5wqo9D4zONvb3cMWhuh
 i5atM7s7FPNDa+N/WLBPMHIDfUrHQy/b9iYAe1R4bGccAPYDn+2EyiYMPtk6xYV9aCZv
 ZlPv0uJCRFV0Id3OA8O5WMjiORHBgE5ICuQDV7GAvUgGshXpFrCr3P1zbyAco43K7uq7
 YPD5GqYmHzdMKZNyWO96a4lTYjh+0Rsw9FKo5EPb8PrnSoBBoKLnxjUm08QcHiwEIJTC
 a/3W7aklaDRuAJ2Djr9UIwqrnlBE2Gie+U23MTfnG8vuLPZeKq9NHpGjHW8dluwM6+Am
 O16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7nNmMMIzBT4LmNsOiO6ifxwI98l+m1IlOZC8ousl4tg=;
 fh=qvswdB/KlbL20ZFuhSZlPzooxHJ/+ZgLrLv7+6O59m4=;
 b=NWqRy0zKBC37u44+f408uvE3u/sagNo1MkYqYPnCcCqwEXgiK73qlVH5O0V4FBLV1/
 hkwpVgB103hhNCNkHxdlvvHsZaJnafm1Lc4UOwI+L9DN2sRNHsP0+lIQyNo45/fqv2yG
 IaQ2kj36ypR8KB5EPNjCJwAS72wokFSrEVDPoc+0OwJ49HzHfAx+r8ZrsNVxcce+wxVp
 ZEaAZa8KbU+ikRYS9S6ZebAnjxIxz2elyNRLIPLuGiKFu6DYlUeoWEYPJj6hTmx1T8xP
 Voc7XGZG9qmJq6veOWuGf5UVXDGctGlr7vae+6yKPSmgm4PawFVaw+yJyOH+FdJHIB9v
 kGQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784561807; x=1785166607; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7nNmMMIzBT4LmNsOiO6ifxwI98l+m1IlOZC8ousl4tg=;
 b=ATNwu3gamZKt1gJSVvNPaFcICRHy+2ffBZkbKrvkeuXtEb4kEDL7U37PzBO6Wv0KMP
 u6fBqOym+MV7j19KrpGwS+dq0/py7VeFIgQWGE6tmj8XFjwDUbf5Fkm7vZ5AVuYJG9YX
 S2RprOu4BknAvaI5ZDLi0Z+qWxT3IiMhz7cQI6ypc2eeMBImirYoFdj09ZzM4VW9XvJ+
 4gEnCp8bjM/bWnCgxWwUjiLdr2LKZ/IVUy6PDMIeIKp2IQQroZaYkULhVIbxL+Gp0jis
 VqXyXAsY7W4tW76pzqkRhKtz/WIRnw267fkoU/iN29HjDLH236FwG9JKg5ooynMrBFBP
 AfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784561807; x=1785166607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7nNmMMIzBT4LmNsOiO6ifxwI98l+m1IlOZC8ousl4tg=;
 b=Fm4hqlNjSUrrCKfHJe3rSh9u4orXquq7t8iBEI5j4k5lx0DsGpVGX1TYh7uqIkgOJM
 d5Gtw96IqmH4q+S+Ufy7PAKsxrlGx5px6ZBLShcj1Q9NCRwtm+zc5aCT6IPJDEHUxhmd
 Huvaf8M0Y2Iu5th0xRk/6XR9FplWBrY1g4Coz7cbNVT6eezVH3pqwRbHzTyF7QHekK7+
 S+8U5VkmmKhrvcwjZrYsYu1c0itfmbSsrCFKVHRIIN6qlMN25zlGiFeoFZiIL9iUyY8K
 GKwnukmokb36dj3fDuSTpzTyOwjOLB1C9n+TL01IkersVa5ubL/BZJWsa0NlBFHTBe7o
 azZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKaTusjsDbepDNHqLJLZmhamNPNA3PTbpGqvfwRCp/UOd67z3dcBVPPvhv3cKlGv7xXvwVMjtSBw1z@nongnu.org
X-Gm-Message-State: AOJu0YxgSyOavGus4k8dK1V66t71AApcYvSDS81tmQ5L/kuYoGhm6/t7
 ULhUr+YS8ZvlAglRjK01Woo5wXlgzjGLBsIDdX5HcSJHXPzdPsYrqGXSoKW+RygrMg0a/s4Zl0W
 y8Gk184f3bl3e5MBy1j8AmmN8hhNmzkk=
X-Gm-Gg: AfdE7cmj+P4bEuChn3szk1o7v4KFyvyO1RWUFiNfbvhPrqrpZtPmZ9+bMvH+Dfmf5pk
 +GqPtCT5fgos/QXWwvd2iEfFjkei0oFHNnZueVtTW286AzTOE8J+u5a1XZjymnbGKREGBx3cI+R
 LLXkcUU+xRVdmqPgTVNlWYctxOjR5sTT1sf9h8du65JRGEyIpELba4cRFVOCGyfEjF8/hM1DbQq
 8C+Hyw57VwP9qcnrT79i/w5lW4jKzMX75pOwNwdx17E5p5xlMISIbOZiuogDa/tk53aBX5j9I+S
 6IktyzRmexpdQYTzDXdWA1rqebpaCO8=
X-Received: by 2002:a05:6402:a4e4:b0:69a:3652:9d33 with SMTP id
 4fb4d7f45d1cf-69e38d7a165mr5712126a12.19.1784561806849; Mon, 20 Jul 2026
 08:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
 <CAFEAcA-X7h0hQ4FaTaVoEUKTJvxfaK8GcihR=+RzxOTBf3X_mw@mail.gmail.com>
In-Reply-To: <CAFEAcA-X7h0hQ4FaTaVoEUKTJvxfaK8GcihR=+RzxOTBf3X_mw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 20 Jul 2026 11:36:32 -0400
X-Gm-Features: AUfX_mw6jmway8HJq8Rfz3af5VMPXJR_yVzJvseWEos7PpyqDF3WAn_Mz1mxhl8
Message-ID: <CAJSP0QUkmT4vDPY0cHYFJNaeo57ZsNwxd8nYvAXtuHY8StPeYA@mail.gmail.com>
Subject: Re: macOS builds broken in CI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 20, 2026 at 5:38=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 25 Jun 2026 at 20:15, Mohamed Mediouni <mohamed@unpredictable.fr>=
 wrote:
> >
> >
> >
> > > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.fr=
> wrote:
> > >
> > >
> > >
> > >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> > >>
> > >> Hi Alex,
> > >> tests/tcg/multiarch/system/Makefile.softmmu-target's
> > >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners.=
 5
> > >> days ago it still passed, but now rerunning the pipeline on the same
> > >> commit ID fails:
> > >>
> > >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipeline=
s/2615134022
> > >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/2629=
704018
> > >>
> > >> I've tried many CI runs with different pull requests applied on top =
of
> > >> qemu.git/master and they fail in the same way. Maybe it's an
> > >> environmental thing with the macOS runners?
> > >>
> > >> It's unclear where the SIGKILL (Error 137) comes from. Could it be a=
n
> > >> out-of-memory condition on macOS runners?
> > >
> > > Hi,
> > >
> > > SIGKILL is the known symptom for failure during signature verificatio=
n
> > > by AMFI.
> > >
> > > Now that we don=E2=80=99t have separate -unsigned binaries anymore bu=
t relying
> > > on in-place ad-hoc (w/o certificate) signing with entitlements we mig=
ht
> > > have issues linked to that.
> > >
> > > In the past file modification had issues with verification tied to th=
e
> > > inode and the workaround being a reboot or a cat binary > new_binary;
> > > chmod +x new_binary so that the old (now out of sync) signing state i=
s lost
> > >
> > This is highlighted in the software update context in: https://develope=
r.apple.com/documentation/security/updating-mac-software
> >
> > > This code is incorrect because it modifies the command-line tool=E2=
=80=99s executable file in place. macOS caches information about the code=
=E2=80=99s signature in the kernel. It doesn=E2=80=99t flush that cache whe=
n you modify the file=E2=80=99s contents. Modifying the file in place yield=
s a mismatch between the file=E2=80=99s contents and the in-kernel cache, w=
hich can cause a hard-to-reproduce code-signing crash the next time you run=
 the tool.
> > > While this example uses a command-line tool to demonstrate the issue,=
 updating any file that contains signed code might trigger this code-signin=
g crash. That includes executables, frameworks, dynamic libraries, and bund=
les.
> > > To update a file that contains signed code without risking this crash=
, write the updated code to a temporary file and replace the existing file =
with that temporary one:
>
> I was just looking at this again today, but looking at our
> scripts/entitlement.sh, when meson.build calls the script SRC
> will be qemu-system-foo-unsigned and DST will be
> qemu-system-foo, and we take the in_place case and do:
>
>   cp -pPf "$SRC" "$DST.tmp"
>   SRC=3D"$DST.tmp"
>
> to copy the -unsigned binary to a .tmp file. Then we
> run codesign on that .tmp file, and finally
>
>   mv -f "$SRC" "$DST"
>
> to rename the signed binary to its final name.
>
> So that looks to me like we're following the rules for
> not signing executables in place to me...

Hmm...then the next step could be reproducing the job failure locally
on a Mac where it can be debugged or bisected.

Please let me know if you need help on the GitLab CI side. Mac runners
are available to open source projects, so you might not be able to
test in a personal fork
(https://docs.gitlab.com/ci/runners/hosted_runners/macos/). Peter, I
think you have the same GitLab permissions as I do, so you could
probably run experiments without my help.

Stefan

