Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F0FD38FE6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 16:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg3ms-0002zp-FV; Wed, 14 Jan 2026 11:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vg3ma-0002x2-MV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:31:51 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vg3mX-00060Y-Ka
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 11:31:43 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so13092777a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768408299; x=1769013099; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8thB7cskZuQZdeXXLxFgEm+jJHnmu7v9Y6K0XzaSxQk=;
 b=K6FuHoNaY9gJI7EsfMs08hIMdEzcJ1h4O0dJfIMNiAh22eymg/62arAXYAUn00JJJU
 NfYJv++xayNncvxI5t5JVEme5y7ZaMEO/c7Zo/0tnEILHbX4T/COb9SAG6dwPwo1kLS2
 +LKVDMfKByciA7HQO9+PPui97aBKh4XBmiCO22pxvgebeP2p60oafp5i+cNSlpt2ecSI
 afrNI86VZUytxgMG7x3tCtgUbOt0O4HpVFfgU9moiXiB/jtZV3TP0omk+WdyMtg2wDco
 acEyURsuP2uoo8uw2QJY9RK45tgAdO7/IthQqZtdMn10YrnysdM12/smHYhANwQw+CZV
 Xqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768408299; x=1769013099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8thB7cskZuQZdeXXLxFgEm+jJHnmu7v9Y6K0XzaSxQk=;
 b=IjFpuy4JBTbpAsr8LRJZUObnhWanSqoDqlvMS6q99Q1XQLTRQIxVFkqLzWySvez7aW
 yzp8YewrOtLKIKkUM2kz/S5SZD8pG8vqznlNv1AaxOyYaTiOMPlxwSI1SyKJIIY+YAo6
 vkTJ361weyqMltdxrWwMC7JZwgsBWBsggBzlhob+i9Q9CfqK1KIta9B/gTBDtGHQcZV0
 CjGfdh1cSXX5yft2d5ZbD/gvBe+msO4aEbK5NDQEH6ixvSWuo9A23v1sFbL2tzYgh8q0
 N7hedrbBatkfBjfi30q7XGES/g03vi0y4tNRDXhgGngeOvhdd9CwkMra1F8E7f5+53/5
 hOFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWZ4vgV+/osJB0GK+VmNBwke0HJZ6X60iIukI7xbehrji+yeG76c0AnkAEFeiTlOoVFnRMF182YW6l@nongnu.org
X-Gm-Message-State: AOJu0YzriFJnvErp0+H/3r6ONFNBMhC5HkRRJvuCQDVUb9d0VzI1FA4b
 M4uJ0qHPX4jaUQN2l86Xx8pz7D8teSvAuWDYqesDAYQrRa5uh29t5MuRKUvRRIdr51Gne7P0di2
 ZbhhXnuOf+AAXAXkLd7h+5WalZubL+mc=
X-Gm-Gg: AY/fxX5x5ev7h8SAgo3dBvxC/zqbTVu5LzOMs8wsl3GXLX2oQErdgIkTsyEj8Vv2u6f
 o4PM4YP9mQ579vcXbQGrPt/96Bv8Y9mxYWqGF+yqXrcIJ+jagCyR8u/l1jn7h8JHabf6fhk32ck
 kfGWHwe3dGDurh4XDFzjB3uarJmRG+PyM2emoyPr6J76b4IGxKWzNJAxDF6qQEu1xrTyKlAZ3X2
 pi7NV/ZIjI/GPXhqXMFxMWnvNoBsm4SdCZb+XgOP1lfu2gxdy60KFwRqIVSzpiHAQcaNg==
X-Received: by 2002:a05:6402:2682:b0:64d:1762:9be3 with SMTP id
 4fb4d7f45d1cf-653ee15e493mr2254008a12.8.1768408298532; Wed, 14 Jan 2026
 08:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20260114092358.22961-1-thuth@redhat.com>
 <1945c9e4-b970-413e-a754-5b1b500b5758@redhat.com>
 <c3f2f68c-9797-4a62-b1c2-3f2cd6333953@redhat.com>
In-Reply-To: <c3f2f68c-9797-4a62-b1c2-3f2cd6333953@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Jan 2026 11:31:26 -0500
X-Gm-Features: AZwV_QhIbHSonbNBXNir-G3P5D-6qxaVP7zOMGge3xeC4w6iFDRmgQljen-cMuk
Message-ID: <CAJSP0QUrm0c8+Fbwkg=8Jc_e7dc-giQ1QAYBjSNd9xnW3jbOdg@mail.gmail.com>
Subject: Re: [PATCH] tests/tracetool: Honor the Python interpreter that
 "configure" detected
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

On Wed, Jan 14, 2026 at 4:52=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 14/01/2026 10.29, Paolo Bonzini wrote:
> > On 1/14/26 10:23, Thomas Huth wrote:
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> The tracetool tests currently fail if the host installation does not
> >> have a "python3" binary (and you compiled QEMU by selecting a differen=
t
> >> one during the "configure" step). This happens because tracetool-test.=
py
> >> executes scripts/tracetool.py directly, so that this script is run via
> >> its shebang line.
> >> To fix the issue, pass the right Python interpreter to tracetool-test.=
py
> >> via the PYTHON environment variable and use that to run the tracetool.=
py
> >> script.
> >>
> >> -    args =3D [tracetool, f"--format=3D{fmt}", f"--backends=3D{backend=
}", "--
> >> group=3Dtestsuite"]
> >> +    python =3D os.environ.get("PYTHON", "python3")
> >> +    args =3D [python, tracetool, f"--format=3D{fmt}", f"--backends=3D=
{backend}",
> >> +            "--group=3Dtestsuite"]
> >>       if fmt.find("stap") !=3D -1:
> >>           args +=3D ["--binary=3Dqemu", "--probe-prefix=3Dqemu"]
> >
> > What about just
> >
> > diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracet=
ool-
> > test.py
> > index 30006a99190..efc518a6b1e 100755
> > --- a/tests/tracetool/tracetool-test.py
> > +++ b/tests/tracetool/tracetool-test.py
> > @@ -36,7 +36,7 @@ def test_tracetool_one(tracetool, backend, fmt, src_d=
ir,
> > build_dir):
> >       actual_file =3D Path(build_dir, rel_filename)
> >       expect_file =3D Path(src_dir, rel_filename)
> >
> > -    args =3D [tracetool, f"--format=3D{fmt}", f"--backends=3D{backend}=
", "--
> > group=3Dtestsuite"]
> > +    args =3D [sys.executable, tracetool, f"--format=3D{fmt}", f"--
> > backends=3D{backend}", "--group=3Dtestsuite"]
> >
> >       if fmt.find("stap") !=3D -1:
> >           args +=3D ["--binary=3Dqemu", "--probe-prefix=3Dqemu"]
> >
> > (only the second half of the commit message needs changing).
> >
> > Even if you keep using PYTHON, which makes sense, I would change the
> > default to sys.executable.
>
> Fine for me, too! ... Stefan, do you have any preferences?

I like the minimal patch with just sys.executable and no PYTHON
environment variable.

Thanks,
Stefan

