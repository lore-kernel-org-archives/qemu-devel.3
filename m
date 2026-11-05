Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA927606D810
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FpaQnohU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOua4-00013D-QQ; Thu, 05 Nov 2026 05:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOuZz-00012k-Pr
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:20:25 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOuZx-0003Yu-Qf
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:20:23 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b335eeb340so1402797b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 02:20:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793874020; cv=none;
 d=google.com; s=arc-20260327;
 b=dlpdK80H4tJ4Lggm2nq84roDoGOl5/XNEvYH+TfdcPQC1ezcbGK0y4FH8QvLvrvibD
 /JYvgJsZxdfe4d+kzeHBe3ryWGl7nfxudfEmfS5CYe6hW0B6lQhbQ8Uw2rsprJ++vg8A
 6cK96ZxwT+feOT0dlDjJPryY2KHJ++K0ySEj/fa1zkqLoNNlmkm6dX93avvJUHFdJVfI
 YnQOIACOdPtXE8xMLzyYUxekssjFy9FLOstOJj3QXjCQFWHn06IjMe6cwA/v7FT8ku7D
 NNprTOnQwqgpcOZDyNqAQ7XFjCtvfzDqqymS54wWKN68n+Ue3bEbDdwBo3ED1OLTTK+v
 LeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jF8U3JcGmua40V48ZCI6ITSLEMNDiudmmQ/FmNdPEqc=;
 fh=BzHdNsOPPcCl4XPvJYOKFKNG0gFGObKY1vm0AULjzRo=;
 b=qr4DXi/4ctl382WPNdYwXJNHXxN8GE0xBb3gNqTs9Fi8cANhvSK8y3HFRd7Va7PUyk
 xpHlc9KfMjewNsWANjd4FclnWpJIj8F/I4J86kr1d5Z2iJsMOWYbRkpoYRnlhtMAKLpy
 2n9OoRe9hygCgWZA170L14gFgQZoyxwXLZrqzCOyU/PDEMcWNSjjkI5YSZiyX5Vvz0qD
 Fzen6y9L5BNFsAZtqsv4++UVqdk6oUq8sArOkz5btqlBH1oGPCNlrIVI9AJzRWpGVk+p
 ziCVq5qo34kT3Wyn+s+pflFoUKN1u07RIo/mQsxZiA51vOML8E/OPoaZ57dXj5DsOxTK
 Z4ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793874020; x=1794478820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jF8U3JcGmua40V48ZCI6ITSLEMNDiudmmQ/FmNdPEqc=;
 b=FpaQnohUf9CjZCikjPLqA18iSfCrb9WWRG3i4xc+bJrUo2VPFldCMGPt0yLfzJBDQz
 CO0GY1+ZcZrsNyqqrm7hLo8kQb8DcHdcAoQfEdQGP4ophbRKY+Iy+mbWw3wGkDE1Zpno
 XnBX50vBv036FORNBuXABdlTr/a9Xbl42NZqWH0UG3wPAeYgnfFc5ccZFxjUVXGQytMr
 HMq5Rhi1H1D0NDCuNIINSyODEKAMX6s9c6A224DhETScQ/LyEYDMU4x/Zo7SV7dB4xag
 Q+yjDMtT1OWYCf70o7D61BO2JWaBt1iKLppsFp18oHv3VAsHx6CJcS3NMr46k2p8u9MZ
 Vb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793874020; x=1794478820;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jF8U3JcGmua40V48ZCI6ITSLEMNDiudmmQ/FmNdPEqc=;
 b=U6c54X7tz3B1UZcGB/U0iq6kczKCQYtuzlU7eByiyoFdNNGBrrmgNf63VazzQxoyN1
 GtUtSICppnpGQKkY6x8kdRtkec/4PC9VlxoPJcTJQZxzSfdLp94dVGbojVD00cmeXXBk
 40IYPNb9I5HwJl+72zUluB6EXxEOxijQbICvvZWBE9Az8g7szr24c0W1P+gjpyagikJZ
 lsFIaMA8IGBxBgWAt0pybyw5OzEThNJixEcz5eDHlrpWJXtsevrhfNivWewRm98b3PLn
 YUeuXbMMChv8VxApd47lBHlmlgh59AbSjQHSGpiKkCFm4QrY/JPWEjQzwqifc4gqKpz8
 dASA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaX99oTX31eBCdm2o1wEI13lecBhfQwDhw+Hnng8OhILKbShE6XF1NzSGciGwRo3gsImh2n/RyTibD@nongnu.org
X-Gm-Message-State: APuU4Z+y5zTKTvjjM2+O1IDiyIcrMPkyR8FZt4g6YCRbzTCVcSbUChC4
 HPk1nOiedyA2SuSe9zeMUPjSA5suze2GZzOWX4HMNJXIrECT4iPmhC3LbFKslB8P3kNxRwFcq0S
 2q4WPcYsJolFZYJAJZCU80bwO9MZT6x+6fcoOyHeBLA==
X-Gm-Gg: AYBFou2H4RKvjcnS/Z1BFxUEU/I2am0vudSFK/0cOZ8SFyPvy7xtKrYhw1OtY7egENA
 EiijbtYBbzzDajxJMeY7oxio8DEpIu/52P5h8P+cGjPOiMoKT+SVK27dPxeLr0hdOS6PAS9RX+H
 CUAcF1uJqkIZL8cqJ240h7GUqpM4HfrdPD/ztrIsfJ2Jh7W7CTU2a0l33Y8fAcsdZ4za1Don1jd
 twh8F7IcTO7X5L7jVa64PhEWVkYWebPiWnsxJPORkTiR30wyx5jJBlK0KpaEh0eLiqDHvPOCCy2
 IBpxEh5I27PfM71fVsZ5Rs7vNg+h+0SPUfgSYfMDOMXCTKTHraCEdOKmsYBwKXaPEOU+eyjwz/W
 yI+JXwUyS61sZ0R7sVhiFwZZT48moBU5EdEtOuQJP8M1ewVUn32FXeDxd2+fWEaeqDAK9Cc8gtP
 mNmq+w7/UYFVxUal9MOCTG
X-Received: by 2002:a05:690c:3481:b0:8b0:d9ff:4f4d with SMTP id
 00721157ae682-8b2b65aebd4mr115874567b3.10.1793874019932; Thu, 05 Nov 2026
 02:20:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103110805.2010679-1-peter.maydell@linaro.org>
 <87o6c685ph.fsf@draig.linaro.org> <auxNqQU1SePuiQuq@redhat.com>
In-Reply-To: <auxNqQU1SePuiQuq@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 10:20:07 +0000
X-Gm-Features: AclHuK-q39QpoHJ-Yl3uCDnBQw7Axk435dAS28ydCI0aGxmdZd3xB0OxWub_dbg
Message-ID: <CAFEAcA-PXjPiCqE1qUkt4QFHwTYpATMAm-C-a641kdOMaPgcEQ@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/testing: iotests check script should be run
 via 'run'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 09:34, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Tue, Nov 03, 2026 at 12:22:50PM +0000, Alex Benn=C3=A9e wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > The iotests section of the testing documentation suggests directly
> > > running the "./check" script.  However if you do this then the
> > > script complains:
> > >
> > > WARNING: iotests is being run from outside of the configure-time pyth=
on virtual environment
> > > [...]
> > > Please use the meson run script:
> > >         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
> > >
> > > Update the documentation to match this.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >  docs/devel/testing/main.rst | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rs=
t
> > > index b0ca37fe2ba..e26b8af0c79 100644
> > > --- a/docs/devel/testing/main.rst
> > > +++ b/docs/devel/testing/main.rst
> > > @@ -272,8 +272,12 @@ scripts.  The testing success criteria is golden=
 output comparison, and the
> > >  test files are named with numbers.
> > >
> > >  To run iotests, make sure QEMU is built successfully, then switch to=
 the
> > > -``tests/qemu-iotests`` directory under the build directory, and run =
``./check``
> > > -with desired arguments from there.
> > > +``tests/qemu-iotests`` directory under the build directory, and run
> > > +the ``check`` script via the ``run`` wrapper which sets up the envir=
onment:
> > > +
> > > +.. code::
> > > +
> > > +   ../../run ./check [args]
> > >
> >
> > This is possibly a personal preference thing but is there actually a
> > reason for cwd to be tests/qemu-iotests or should we frame it as:
> >
> >   $BLD/run tests/qemu-iotests/check
> >
> > which is how the functional tests are listed?
>
> For the sake of docs it is probably a good idea to be run consistent
> and illustrate use of 'run' from the root of the build  dir ie
>
>   ./run tests/qemu-iotests/check

Agreed if it works for all cases. Does it? I assumed the existing docs
were saying that it should be run from the qemu-iotests subdirectory
for a reason.

-- PMM

