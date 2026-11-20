Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE0606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dNUjingl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQEd-0003CT-Dm; Fri, 20 Nov 2026 10:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUQEb-0003By-8B
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:09:05 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUQEZ-00059P-BC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:09:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso5367175e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795187341; x=1795792141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pyrl78n7bHsVMKlsaLuGRoC+y4O6xpU/t0dLHZZBseo=;
 b=dNUjinglbGAMUzjOKEebub3nrT3/XhcbS8XcWd+sUia6mAupKAyTL6d+RukkUPczlO
 H4CRCL0cNm7F8g5xBrrkW0kPDvuGwMv8mYIJERG8At7ZFcxvvaSNTrqJh40I58VUtbxd
 aVeZqyqWASKEDOjytzRuXyRsOf8CEhZBxBsU8iD+zSn0/nHIT+sxd33vTyCYRTOZUzh8
 BTnWCYJRACj6jjNt/QTenMQ9EIXO2FNEZFZ5HsGCKdM8pqG5fmH6lTXqrAQMtxVF7HP7
 3r1R6At9bWy/bfkU7sUqTEf7dynLjy8YZzdMBJ2PmB2YiFMnAwT8zXHtSH9h6pxVaDls
 EuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187341; x=1795792141;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pyrl78n7bHsVMKlsaLuGRoC+y4O6xpU/t0dLHZZBseo=;
 b=Bn/eM1abyhL69/HjhOlA3mu0GcT3n1zttKN+U1oPmZDW/kabJ6XU2qItfnCLd9SoVm
 Pn3cZ1i7x0Ht+oE8/UvjK6q3emJ6kd8UuQk0qwl1qpm2a5pHqFKXYPxXNmTkQ8jiM4A+
 1gFnTzPG761NqV/xdqgMfq2k/d4W7dKitBhST2cwwxp/SrQRcfKx6feUf+HDnY4d+dqR
 ExvbpDUF7NAHZY3VBo2y5+oD+C5Kzzj5jmJQlxxPL/QkgWEib9SASm9dGFxO6s4xE9qn
 LsFkhURvjgTYA4NWnGmpVv2UBMCbveUj5siQx/mSCwO4QQ7rWdW546Q/eXbYm4ijQs5w
 F81w==
X-Gm-Message-State: APuU4Z9KVtccrw3H9VCDmMmdeSd3duVJcp6ZUo9+Q6TuPdb51t+e1sq1
 hlX6h2sM/AbyLu0/J1Unm1CaUOlMLeg2+CUezJgEGLMMlGfBIme9c5g6WNS34xlh3TI=
X-Gm-Gg: AYBFou2R/JSOrVVQUM5viUZi2n/0KTLXDuU+KOb4EK4I2D1q5XsGx2Ef4+LGVn9Z0BO
 ISUj+xUvivmdzrR22fbMZEk3DTqcUBoCQ85qLgsMq83NCryYkAqoYhvMLcCDMHBobJBTnprbGoB
 eEfyPTEpqGr4hxSNJETfxTMXtb01pz/qoy82o5QdAGS9yBkU36dp0esRlDwAOZxzKARSkeW4CaX
 CX/BWLylHcnOjQwOxZmLwpZZZ0ng+hDKdrTQ2wYujKTXfv8ZJThDnWvQ7M8UkQAtxhkt4A0cSUh
 +01rVbPhk35FoOOnu5+pR4wsOANVxb7vxOi6l7pRx3GztIoHtDV8vofnDcE2cC27aIn/LjhNuPU
 C9f5z2PrU0d1WC1dD5MEzzCz51vE3b+UckBHrogMn62PQobcaOVwbBWaajC02UX4qUsrtf5OxNR
 1LxqvRz1H1k2qClKUOcR6C6rvGKzlTGdCHVZ5QqPvKlfDVH7R9R3z/ES/p//kqq8b3lkqojhseD
 IanPhqI6i8B/EeDar3yVAIJEVf4XNQrIipWL2ENyOWQEuCF1gV/FUU2KqV496Sv9BQPcGS3yKmm
 kOy4hqbLzpPsoARHMyYAVg6qRFqG
X-Received: by 2002:a05:600c:4515:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb88813b27mr80286765e9.12.1795187341324; 
 Fri, 20 Nov 2026 07:09:01 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm107978155e9.6.2026.11.20.07.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:09:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 868325F7FE;
 Fri, 20 Nov 2026 15:08:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nagendran Jairam <nagendranjairam52@gmail.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  philmd@linaro.org,
 daan.j.demeyer@gmail.com,  peter.maydell@linaro.org,  Alistair
 <alistair@alistair23.me>
Subject: Re: [PATCH v3] hw/core/loader.c: Add Extended Tektronix HEX file
 support
In-Reply-To: <CAEAkEp7jbv=uZS61Yd6V-zfNr6cp-MjgHBStC08ft3qROfE2bA@mail.gmail.com>
 (Nagendran Jairam's message of "Fri, 20 Nov 2026 19:39:50 +0530")
References: <20261112184949.1042-1-nagendranjairam52@gmail.com>
 <87ik1r673b.fsf@draig.linaro.org>
 <CAEAkEp7jbv=uZS61Yd6V-zfNr6cp-MjgHBStC08ft3qROfE2bA@mail.gmail.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 20 Nov 2026 15:08:59 +0000
Message-ID: <87cxrz5ylw.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nagendran Jairam <nagendranjairam52@gmail.com> writes:

> On Fri, Nov 20, 2026, 17:35 Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>  Nagendran K <nagendranjairam52@gmail.com> writes:
>
>  > Add support for loading Extended Tektronix HEX files through the
>  > generic loader.
>  >
>  > The loader parses Extended Tektronix records, validates their
>  > checksums, and loads the data at the addresses specified in the file.
>  >
>  > This allows Extended Tektronix files to be loaded directly without
>  > manual conversion to another supported format.
>  >
>  > Tested by loading an Extended Tektronix file containing a simple UART
>  > application on the RealView EB machine. The application executed
>  > successfully and produced the expected UART output.
>  >
>  > Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
>
>  Ok before you send another version you should consider:
>
>    - split whitespace and comment updates into their own patches
>    - include a test case for the loader to show its use
>    - verify the whole series applies and builds cleanly on upstream's mas=
ter branch
>
>  And the cover letter for the series should also include what changes
>  you've made between each iteration. You can also include a summary of
>  updates under the --- in the commit messages.
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro
>
>    Ok sure, but where do I upload cover letter and testcase means the bar=
emetal build through which I tested or just overall summary
> of how did I test?

The cover letter is part of a multi-patch series, there is tooling you
can use to help prepare a series:

  https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting=
-your-patches

For the testcase you can either publish a binary asset somewhere and
write a functional test:

  https://www.qemu.org/docs/master/devel/testing/functional.html

Or work out how to build one of the tcg tests and package it up as a hex
file and add a run to test it.

>      Nagendran=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

