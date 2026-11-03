Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EE606A334
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GifPI9FL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEWp-0000Zc-3o; Tue, 03 Nov 2026 08:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOEWm-0000Ua-Sx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:26:16 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOEWl-00055D-C3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:26:16 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0dba37a7fso37647687b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 05:26:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793712374; cv=none;
 d=google.com; s=arc-20260327;
 b=PpF717FlfjRCiBJ5EfDEVzIgFFdJh1qS7myR3gnA5TWUECdr43QUTbmVTzVBP6uAvz
 aZUAu0HsXVwU8V2u2agL4u3pYLQ1710g7gdnCqrcqd5qH/a2/FJdbRUSb+Tor96iufuM
 HTwYa/4dJ9bpu2GQkPE+7m03djZqlWMnsMgABxtTc1hVBwj0LIIiJAYmSanK9iF/Bi9z
 9D9tJRt2EBQbpr/thzv4fbQnV9ZRSn0OtwRPcoCyVIG4nlk6gAColT9zOTegu61T9eDV
 UmRlnSenZGc98grIPJH4JNwB2jBY3G2Qf6lfvTmx7w69e1ubu8bkVzh2niWbqmHg+nKS
 BRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JVnoZwgv9L9mQYgzJZjNKHhD3rwmn3o1YY15OVIyPm0=;
 fh=PEivQ4iEXg3RLrkzPB6Yr/5Fl0Rqcqg4Fp+Tu67eXy8=;
 b=e9PItbAW67gMcZWqM/2m8AKkevyDVHbtx+bmBqGJXCFHKbqJ0XSkLT9LzaEp8Yaaoq
 Sq+WWA+dbC4VOUYdiyS149Mpa+rRryiTdduLut1swVhPSL2uHZs4mWd9xaf/vUNHu7JL
 trczOAJGHhWZb9bqTEQZZPDNCVPGGexuOQTdN6ytyhy7Qzp1tvhHXub37Chit0JEfQRP
 mZmLgk41rrGEuBXzvuDlvzyj+fIQJkOZVKEOaeuobPwONe/Yr/9BnKyvpvBXtS2bBzWH
 ohD7tuezw0n2Oe4WqdhesTsm4/99cYl4LU+ewjNA4ZJMs+VeHkskXNIv2t1y8OnUou8h
 /Xag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793712374; x=1794317174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JVnoZwgv9L9mQYgzJZjNKHhD3rwmn3o1YY15OVIyPm0=;
 b=GifPI9FLqwbeI99Fy2zKNoqK0MzES00bH4rbsHCMM0VOIJyxnm8t47EW05YgKvI8xQ
 6p6Xwkw+f6VxWSD6knzY7YF70cZZRUm19UOxmZlp4VoX6ut0CcQpyiBAoy4uza6dhso3
 4oh2z+t8AtsPbaAFgaanM9uy0M9W3SZ7dNcou8opEjAO7P6rmUOSTQrXTDQXRpgpfXYK
 jGjMVF/Lis9mDGK62TC7J3KURwA3smZYuztHmmqYb4LwzZtll6T6+kApHW+kJZk63Avs
 T2gi57cAw0tAXPZ/tDva9bY1I53Fm9szXvhPuahWxu254mPvEzTs/b0czVOFBScdqMxf
 vtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712374; x=1794317174;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JVnoZwgv9L9mQYgzJZjNKHhD3rwmn3o1YY15OVIyPm0=;
 b=K+dQMSTm1px70lwiHn5vcxTJA0QkNuZjzG5VUPr8hS8tS18ra4LoAOTNCpz50k543u
 +NJb1+xBD3WoEev8q2ruV2kn3Z714sRh6iBs8mdjMY1YM8ZHqc0mAdrIvXYOp4ivYXq/
 Yz5NloRb5JAEsMsFYPYl++06uQxXivOmD8fAHy7oIzIqPYympE/TFAx1L+VZH0xK3QPJ
 HJIeqHo/gKDMvPtivHaMqw3Txvrrt0bfcIwVAiCNg1nAd5RMS4Vdt2YAH0L2oWWp+I4o
 g5acd8lXfoquXF4riIoB5l4L1I/9uhimSSTrnrbQjIB275RrgpHnC8wK3N/KJn84CIyl
 tyNg==
X-Gm-Message-State: APuU4Z/QikiyGlL+ma5UWS7XXxwbhqjz1xHVQb3z7aJfQdO9HdotAbWE
 1X23BVFc71OcgOxsIxu18CSohPXgZ6Th5EMwpc6ECNUJQXRxgjX75e7oTISjsXXXcV0KuB5OzZs
 qNUKdzutYpGn4Nb5bxOhu5DmnR8fUkypk1NV00rUEqA==
X-Gm-Gg: AYBFou2xm6wt0TtztiViivWQ4T8ILI9ZGYhyVE4z8AaHbc/2VIpgM+wdEgNA26WJeOW
 lz3OPLA1UydcYAyP6gMXi1ppu2kxdUb93/UH0oCAzRaFf1VvMGIJrMkp+PaNUfOrDMHkeYtfwDq
 x6rmQ/asdT9UT2vCk0VcYK+0ymKfufJnyUY/qakrIYmuUe/t42VwobRrx4bYLGDmQJccCbHgwNm
 gQk34a7Sh41uvAdVWmyIjghf3q2+5Wh5TKvEjYvsog09bKZVM3KPDjq7/Qg9jQ3nL98+VpWgoCO
 9Yyqbm2LpE6RTB8xiK+XzcDMlZ0A2xBzxi/6mx0//hKTot+MhjGy3b93LvNbuKj3+bIsafvYVSt
 q6jGMXm/nLQNDqdYMnzFPKk5G6U7k6xTUmg85sevFLCyYL1Au8cn8JzGs0P+H0BKujz7VahLESp
 TzFI6O+AaZNlIzQMGM6Wom
X-Received: by 2002:a05:690c:ec5:b0:8b3:392:dc1c with SMTP id
 00721157ae682-8b30392e155mr3687737b3.36.1793712373512; Tue, 03 Nov 2026
 05:26:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103110805.2010679-1-peter.maydell@linaro.org>
 <87o6c685ph.fsf@draig.linaro.org>
In-Reply-To: <87o6c685ph.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2026 13:26:02 +0000
X-Gm-Features: AclHuK_AU4e2w3ahD0-LZXGjMTEUOdu-A3PB_9zqTdHnkkr_m2iHoCj_5XVpWn8
Message-ID: <CAFEAcA-mnDsf5M1ybHwrXEt-HNBMfhFDwc47MTmp8qxiaEQ25g@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/testing: iotests check script should be run
 via 'run'
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 3 Nov 2026 at 12:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The iotests section of the testing documentation suggests directly
> > running the "./check" script.  However if you do this then the
> > script complains:
> >
> > WARNING: iotests is being run from outside of the configure-time python=
 virtual environment
> > [...]
> > Please use the meson run script:
> >         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
> >
> > Update the documentation to match this.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  docs/devel/testing/main.rst | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> > index b0ca37fe2ba..e26b8af0c79 100644
> > --- a/docs/devel/testing/main.rst
> > +++ b/docs/devel/testing/main.rst
> > @@ -272,8 +272,12 @@ scripts.  The testing success criteria is golden o=
utput comparison, and the
> >  test files are named with numbers.
> >
> >  To run iotests, make sure QEMU is built successfully, then switch to t=
he
> > -``tests/qemu-iotests`` directory under the build directory, and run ``=
./check``
> > -with desired arguments from there.
> > +``tests/qemu-iotests`` directory under the build directory, and run
> > +the ``check`` script via the ``run`` wrapper which sets up the environ=
ment:
> > +
> > +.. code::
> > +
> > +   ../../run ./check [args]
> >
>
> This is possibly a personal preference thing but is there actually a
> reason for cwd to be tests/qemu-iotests or should we frame it as:
>
>   $BLD/run tests/qemu-iotests/check
>
> which is how the functional tests are listed?

No idea; I'm just assuming the docs have a reason for telling
you to do that, and not changing it.

-- PMM

