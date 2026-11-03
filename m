Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D7606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SWTtYH5B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xODXX-0007Ee-Id; Tue, 03 Nov 2026 07:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xODXU-0007EF-OR
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:22:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xODXS-0004Mv-TK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 07:22:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so43768245e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793708572; x=1794313372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2jfT0trGrLaDeGb3GmHTIycW+kNG9Ca6G0F2no+yhTU=;
 b=SWTtYH5BRfP+VBcCGqkvHqpPd+bp21T8gxEmEU5Lv0lDO3DaPkw3UNcDjAsgLF5s7h
 R3GgSjUQb7dH9VXgd/d7CqFek5DuEv4+nXjut1m36F9h+cFdDlyo8UPB3xd6j0KjUMWk
 o4pH2gUAgx77zDxNPIeH/1vqJYWK+lJmnZZQHFKWk8V08N7ZcoVDT9yLd6zk2SHLQAvp
 lXGqxi5PmrzZFd7kcZFFqXFJunVL/x1Fm+maW3skiGjNu/TNjUKANJjN2OcI22IJFnK9
 ZM3hVhDcQ4QowHi0Hc6WRTZdl5Vrl1KfcZIf0Fe/D8hAKsBRjtyhFIGKA8ombOZDlkzf
 Ed/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708572; x=1794313372;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2jfT0trGrLaDeGb3GmHTIycW+kNG9Ca6G0F2no+yhTU=;
 b=t6kNehw5yACQ4SY2h+1TyYrxcslVHLNnj0qRoBcgs0v7P+4Y1rxZNlOwKt7SgC1qqu
 q9oRqpBSvD+rQQZ8uCrh6WiS6belqDImbs2303yKZCOakBo2GTm8xd5ctLMDEzZFLoqT
 0ClLlF+/Vo2tNE7qWCAjULPylvrS3dn6wPwghVWeTQky9mGV8aj21QZkAQ9+0KjAGf6c
 LkKjyasQkt2uIzNwoMCgMO0NOMROyagc9gDj2fLEaFLjVlQ4/UyFS02r/roZnz+H5n22
 FOHvRaFjsoU4Zyy9rHM3caVhUpt89l6WLpKBR+QWRz7H+okvW4EcWo6xTQZvcIsZUJeS
 BYWQ==
X-Gm-Message-State: APuU4Z/T2NsDjHV/T5bvPKJYcRcAsT3DNLiYT04Gf062QHsW2AIsvNyl
 KX7bk86oe0Bk55V18ogtrinDqhz7LY7xIuo+oyprDph5bmmIjELvGjEqcLrAT3wJjX8=
X-Gm-Gg: AYBFou19WPHEMTjq6d7VBnVhSXHd74ChqetkoZe6KV4IPbHdi6lvlMmNAeIc+rseJA2
 HWNo1EjokGjTusSyv8SziAUSr3QnHDKKvWWlXXGS+MO+fScidCFF9pVfbFCGnkfEg9zvvkH2a8/
 d9Jd1ky7PEKdH5mjQmYd8hZ9TjQPRApZTcWqew54HweGrg0mOJRoChTi3rPb2JHPjMJ+J1+jfUm
 /Bgxs462q1v8lihibG3M9THCZ2X9BxNJZKZMJD+Msb57rubDFbs2Tk31iGhMizcaTIjofXmU6mg
 0q8kq8zGPI5yCuVCg6e9zH2mZo3q3jMHnim/nz7H4yzTwe0LgPdM5YW4K88F1t20wOMGx8lW5J8
 gGw48nD4oG3gy2XEpxe/RmLnkHQabaVXxrMS9+KQs3k5YUGsnAzKwTZjJl9KlYUpJ7IhHzBLN3k
 om+E7l/9iD8NHnfx/KQIlTZ3/7u+5nKBYrjGi75vV8jylVaQEcoSHkzeHIv/qncp4oZ+/rgEiq1
 YMmBMb7lcFSZmR9oKOOd3pDy1WkPLchaUwKjNXV7cAHxHdao7rYptxdZE5y5+a3Ofk1qUYQZa9r
 TOVY2hNfhrflkMx3GTNfp5UEdxe13A==
X-Received: by 2002:a05:600c:3556:b0:4a1:c6fd:4db0 with SMTP id
 5b1f17b1804b1-4ac187a80b4mr320464035e9.19.1793708572103; 
 Tue, 03 Nov 2026 04:22:52 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9fafe08sm83594265e9.3.2026.11.03.04.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:22:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 74D545F89B;
 Tue, 03 Nov 2026 12:22:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs/devel/testing: iotests check script should be run
 via 'run'
In-Reply-To: <20261103110805.2010679-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 3 Nov 2026 11:08:05 +0000")
References: <20261103110805.2010679-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Tue, 03 Nov 2026 12:22:50 +0000
Message-ID: <87o6c685ph.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The iotests section of the testing documentation suggests directly
> running the "./check" script.  However if you do this then the
> script complains:
>
> WARNING: iotests is being run from outside of the configure-time python v=
irtual environment
> [...]
> Please use the meson run script:
>         /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check
>
> Update the documentation to match this.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/testing/main.rst | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index b0ca37fe2ba..e26b8af0c79 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -272,8 +272,12 @@ scripts.  The testing success criteria is golden out=
put comparison, and the
>  test files are named with numbers.
>=20=20
>  To run iotests, make sure QEMU is built successfully, then switch to the
> -``tests/qemu-iotests`` directory under the build directory, and run ``./=
check``
> -with desired arguments from there.
> +``tests/qemu-iotests`` directory under the build directory, and run
> +the ``check`` script via the ``run`` wrapper which sets up the environme=
nt:
> +
> +.. code::
> +
> +   ../../run ./check [args]
>

This is possibly a personal preference thing but is there actually a
reason for cwd to be tests/qemu-iotests or should we frame it as:

  $BLD/run tests/qemu-iotests/check

which is how the functional tests are listed?


>  By default, "raw" format and "file" protocol is used; all tests will be
>  executed, except the unsupported ones. You can override the format and p=
rotocol
> @@ -282,16 +286,16 @@ with arguments:
>  .. code::
>=20=20
>    # test with qcow2 format
> -  ./check -qcow2
> +  ../../run ./check -qcow2
>    # or test a different protocol
> -  ./check -nbd
> +  ../../run ./check -nbd
>=20=20
>  It's also possible to list test numbers explicitly:
>=20=20
>  .. code::
>=20=20
>    # run selected cases with qcow2 format
> -  ./check -qcow2 001 030 153
> +  ../../run ./check -qcow2 001 030 153
>=20=20
>  Cache mode can be selected with the "-c" option, which may help reveal b=
ugs
>  that are specific to certain cache mode.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

