Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1DDC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UYx-000240-HM; Mon, 28 Apr 2025 15:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u9UYv-00022Q-B4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:54:45 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u9UYt-00055J-Ez
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:54:45 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso8403440a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745870081; x=1746474881; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fNsssxanrh3jvU/AEQbNK8rS/k/AXf/vyKGi6cIEUY0=;
 b=TXC1AYlimxUiew5U++mXwP9/kMv5RvWTyrVtYdfx4E0LaQhGUtmr2NUGSujEhL+bcG
 GzC15NEL/4SxAW5glMgaWWeHvMCpF3iBjIqnZSadxDfk1mJ2cUmhoxwlRL0Mb3wg1sHB
 q3wdTJM4XRoUA3b7WmA3HgNtV4zGFNTDK0yykvBR/3l7ILp/XnPvxzaAyF/qGTRUQVbF
 YuoAelCrxvxwXj1wfSI49ihHyAc4l3axPJ/nbnj6Sg5zCThQX4guDLNwEHGfEExTvEPd
 A6HygCftgVKeZIqQ6btDkdubLqCQJQ4+B/9GQMSomphjNf6ZNTwCpruX0D16e7ESDMGG
 +JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745870081; x=1746474881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNsssxanrh3jvU/AEQbNK8rS/k/AXf/vyKGi6cIEUY0=;
 b=CaWBtBR0wwvFWF3UoU33fez1HkdXReU7Lj1TmR8NEUjnUIItTVWhOdTPMvbTv4Q8iK
 CQwfT8yEAJCGlzfvs34uQfZCVnWNcC5dvco8Vd6Bvmm9uEAbwiyun0g2BjENSOrS9xvb
 Hd6BjvopJk3NIU0gAquBOumzqV0ZglcWFu93/GvWTvtXri0n5H+hH6MTjhYoGHDaq4dC
 nXv/OZMrrzp8EIDZ+e6yCqXC2Im1K509RfnHiKIH0enVhdm1iaCquvz4OOWVM8yw6b+P
 XUnIxcUh+vg3XrQ58hx5VXyLyA1cPNYh1u675pcxthYUrvc3sY2+mNcpP+3bIINIrTQv
 K5tA==
X-Gm-Message-State: AOJu0YyFreVldSs1lRxb1ZLBk0/Ro6k2NPuzLByD0Yw6iJOWWgX1YCsO
 +UtftJH1yZ461Pft+23i+q9JuU+IDOENnY/nYlY9pZlvGKy4WrZh6BWMg89mJ+vSTgsGsLsQW7e
 Z12a/z/Kr/fVTw2N6XEzikqdwbCU=
X-Gm-Gg: ASbGnctSpsIusjABpEZrucEWqDJ8ranbR1I50GDJtW1h8aZKPNfVzlU0Z+ynr6nSAeN
 ElzHNPIi+mlDjLaYTwhZRkYX5lls3pfBpU/iv3GTcQbxoB6W8GuC+gLngHxZQbSVk9v0s5I/mli
 sSQdBB0G+YIa1dC00CXOWo
X-Google-Smtp-Source: AGHT+IHYMIBwEL83N316N4KF1cWC0vIQJ1d05ki+JX0enqP99eKLD5lgRPh82yY3mqEGFy1Z4J3OiOnfohuyWW74pMw=
X-Received: by 2002:a05:6402:4409:b0:5ed:61c8:adcf with SMTP id
 4fb4d7f45d1cf-5f83b0d3c3amr165649a12.15.1745870081183; Mon, 28 Apr 2025
 12:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <CAJSP0QUXuAUxMLOz5Zw1zwk0zwBRwuFM=qCufwf0TLr+w1YXvQ@mail.gmail.com>
 <1718b3de-9187-4fd0-87e7-ffe91393caf8@linaro.org>
In-Reply-To: <1718b3de-9187-4fd0-87e7-ffe91393caf8@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 28 Apr 2025 15:54:28 -0400
X-Gm-Features: ATxdqUH5DJB-HZBy7QILOhsyrrQueNTGvegH0J-iDAMv1YJhdyGXt2enJadV2GM
Message-ID: <CAJSP0QUKmWY0b9xxX5k-8iV=P4QC4EXdHdzF41LrA0AmRcse3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, 
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com, 
 philmd@linaro.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Mon, Apr 28, 2025 at 3:25=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi Stefan,
>
> On 4/28/25 11:14 AM, Stefan Hajnoczi wrote:
> > On Thu, Apr 24, 2025 at 2:35=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >> Feedback
> >> =3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> The goal of this series is to be spark a conversation around following=
 topics:
> >>
> >> - Would you be open to such an approach? (expose all code, and restric=
t commands
> >>    registered at runtime only for specific targets)
> >>
> >> - Are there unexpected consequences for libvirt or other consumers to =
expose
> >>    more definitions than what we have now?
> >>
> >> - Would you recommend another approach instead? I experimented with ha=
ving per
> >>    target generated files, but we still need to expose quite a lot in =
headers, so
> >>    my opinion is that it's much more complicated for zero benefit. As =
well, the
> >>    code size impact is more than negligible, so the simpler, the bette=
r.
> >
> > Do you anticipate that Linux distributions will change how they
> > package QEMU? For example, should they ship a single qemu-all package
> > in addition to or as a replacement for the typical model today where
> > qemu-system-aarch64, qemu-system-x86_64, etc are shipped as separate
> > packages?
> >
>
> Different distributions will have different opinions.
> In case we decide one day (which is *not* short term future) to replace
> existing binaries with a single one, it's probably a discussion that
> will happen.
>
> My personal "anticipation" is that if we unify all targets in a single
> binary (which is not happening tomorrow), distributions can always
> create a qemu-system-common package, and depend on it for all targets.
> Thus, every qemu-system-X will simply include the expected symlink (or
> wrapper script, or whatever) to the single binary.
> Or they can recompile the single binary for every subpackage they want
> in case they want to absolutely reduce the code size for a single
> target, even though the sum of binaries will be infinitely bigger than
> using the single one.
> In any case, it's not something that will happen soon, except if
> everyone in the community becomes convinced of the advantage of building
> QEMU as a single binary, instead of per target binaries.
>
> Even if this never converges, there are still benefits left for what is
> done right now:
> - Faster multi targets build: less compilation units =3D=3D less time.
> - Smaller multi targets build footprint: seems relevant as disk space on
> GitLab CI is a recurrent complaint.
> - Clarification of code: I hope C developers are objectively (i.e. not
> personal preference) convinced that less ifdef soup is better.
>
> > It would be nice to hear from packager maintainers in this discussion
> > so that there is a consensus between developers and package
> > maintainers.
> >
>
> Sure.
>
> Maybe there is a misunderstanding, but at this point, we are not trying
> to invent anything new. We are just looking for a way to build QAPI
> generated code only once, so it's possible to link together object files
> coming from two different targets.
>
> My mistake was to not mention introspection in the cover letter, but
> thanks to Markus and Daniel, I understood the consequences of that, and
> my position is to keep the current schema and serialization methods
> *exactly* as they are, so consumers don't see any change. The only place
> where we need to do changes are scripts/qapi and qapi/.

Okay, if this is just about QAPI for now then it's definitely too
early to discuss packaging.

I'm still curious which specific use cases you have in mind?

Stefan

