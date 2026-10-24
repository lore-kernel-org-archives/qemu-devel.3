Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A1606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dkRUoWNM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKRPV-0003Eq-Tt; Fri, 23 Oct 2026 22:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRPV-0003Eb-07
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:23:05 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRPT-0003BH-3V
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:23:04 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5bfa7c09c9eso1068016e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792808581; cv=none;
 d=google.com; s=arc-20260327;
 b=gGeGwLEWCCBP7QjdqIyRLG8mQjCjzKMs0nQ/u4h0IWV17UMJZ2D6N4v+GDgOOcXbNO
 +mj6AV0S9bTfy3Ezua/j1zlkKblkJC83BFZKlAUE3gPRt7NA5BHshlFBD7kue8g1hJuN
 44m27mYtJWd2Roc0u1b5ti6V6CSIA4/+NcBWY6xytv/ojxlnxFZW1Tj4jC0mXi3tCM6u
 wmh/OFhGduiZJu42PDwqnN3/WPbgR76VHPRsNJjGMt62KcN1UiLcPouvZEvR/CWif80k
 h4mTKk3isuLZq5YDh1eK9d7BclkqWsK7km7/jKJ6ygIWi/xTV4VY+IRNNcaZYDTew5rr
 JuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pTgO82Z9Aep1bt9wYLtCorTwmxxnNduGrBzDNbkdhUw=;
 fh=Y8CfaNWEK+2fUP0xR6pN6KSEUrZ7bhMz+9jexTuMuZM=;
 b=K9I4+oy/G9ZhhARCptKT/ERQR5KEW/ac7s3f6BgDyPqdmG+UMmaq70UswIrCxbEHFP
 nw+5wZ1jwOgLr2kRffZyTQgKFmijAPibdvDBQ3EDjIg0szhNgytV6xpfzZiKi/QEJzg9
 IPSZXErZMszKNK/HF6Cp5HK0E6Ab2HGpYnsJ0hOL4+Qo5d83eJyema95P6UMcL5dTjDa
 j9QU2BhFYorwDSsdGQhjfn47cochI76G9RUWwhJcs3CFajTqRRvQDRzXyPsc7oD9tW9W
 gqDd3elNo7Y9Txxk/7ekVtoT+0NEGpOV1FW8zB9uu9Z4h8efFeUtQY4dVJHfDrds1n+O
 FeUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792808581; x=1793413381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pTgO82Z9Aep1bt9wYLtCorTwmxxnNduGrBzDNbkdhUw=;
 b=dkRUoWNMICoPlUpcLlovM2aHpHZ/7XlsitA8klR1ZMvaURaRmITo3ylILATYPxYIYu
 eMJJHA0F8JRj5+Y3d5LxNMB/7YdN29TD3fgnUMF6Qw/erWm8sxlD1jfKgMzNLrh7jGRh
 c16E9QW0tvwmo9Y0s/0HvE7tbdkOtEOgGBw3cKwuBbbfFr81VWci6z4G2UDNIrEUKbFZ
 SKNG9zmwpglXBUoXs4XsRqwvKslFgL2YU1eOyO73BzyUMVHphrL6eS2CrWO7/keXIqxl
 hqrdv5Bqo0TbqxZiCmwwwlkNv/eeuL3Qknl9VgvKqZxUhGRLOsiTgmDIijGwdE0GdXNW
 CvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792808581; x=1793413381;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pTgO82Z9Aep1bt9wYLtCorTwmxxnNduGrBzDNbkdhUw=;
 b=KT2r8RvcSoXEgPJRAJkWv+ekci+CsmKuIKfgdtHl10W66v6lo9zAwfyKLDFvfvVWj6
 VGYbW6IU33YtyCW8l6/QNI1KVlJWMuK4OYDDUKTf66rrHQu0/s5r22p8wD8olaE8mJ8A
 4VkWLMF/SRIbbmJvCDwUfmFcOcHSsLsqJD/iHz7UK10FFW5jCkWMLlLpzC37Y57VW7JW
 BiymO9Co6NV/PFNV/jDDgvNm1qJ/EJdCIOAqnNuTnk79dHhZB+Co0uogB6TuseswICFG
 MaJdmOdu4RdIK2AAtZLFFD+aM/qLqkziwcwvevrORirUsBiMlfcAhNtTLmcdP/sfSK0f
 yD/g==
X-Gm-Message-State: AFq9FYJ/Y6OrQucmvUzrxnHeM4CxxEFjJzHRRW7aj5XjasxWu961F1q3
 U6zbzwspvsPVO6DXd+Xqn6GZTUYxTZjctI6KhJi4yZp1H2u97EeWRHnrhvypyYFX7YN3GQA3ybQ
 RABajR3NNQixMbvZouB8yPsnFjw4BRLY=
X-Gm-Gg: AYBFou111OwySQfVEWdATdWECczvKcQ708/8degYEOKohok8w101pDJrLZVuETORr/z
 YC12RzhtJIEaLdPBNIb5fjQ1Yv96tmZlaA8x3Xp0gMd10GT2ECrPRY1/6Xv/WrcxT7dBI3WNudT
 r+/aryNzZeeiFN8C2iYHKcTkjfZA51y0L1b4SPEdB7KaWr7qVDOt7ai4D8BcBi2LcT8CKL4woDe
 wbKZsmiFkwscxlUtioAdWoZh4y9C9+7ubqXxSBkqFlvgQqOWwqHDsQQ2nh6NklH11WTAqsgooxq
 zQsur2q98URwJR8iu7/3DVRZKConkZ2pB+mpIwKHXdPpvrimJeUp5WSlcjCMMZ+pYPhofl2vR6r
 dc/6aUyXAySG5ErYNCXEK2nG+y3LPIrIJmD4WTq4jKqVHbIezNMhpBk//1aBPua8m0JXhoLvjRl
 p8rARX4w3TJGMI9lDd7JWCbarBjToIJlC+0EAEOyKWE++Nm/i7Bguk
X-Received: by 2002:a05:6512:33d6:b0:5bf:b479:463b with SMTP id
 2adb3069b0e04-5bfb71e4435mr271792e87.42.1792808580505; Fri, 23 Oct 2026
 19:23:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
 <d97c3770-f02a-4d37-bbd1-ef464ad3d8f4@oss.qualcomm.com>
In-Reply-To: <d97c3770-f02a-4d37-bbd1-ef464ad3d8f4@oss.qualcomm.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 23 Oct 2026 22:22:47 -0400
X-Gm-Features: AclHuK8WAwX49mZdGqw-B3L1QHgoiQXtnR_Yj7TBL1UVaCf7JpkVqGZOASUAf_M
Message-ID: <CAEdQ38HGz2P6fmDGrkaHLFnqY4XPdq8fsU=N8XjZW+0T5cotAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/alpha: FPCR exception status fixes for
 IEEE-mode code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 11:38=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 17/10/26 02:58, Matt Turner wrote:
> > Two fixes for the exception status that qemu-alpha reports to code
> > built with gcc -mieee.  I found both running glibc's math tests under
> > linux-user.
> >
> > Patch 1 fixes 471d493047, which was meant to record masked exceptions
> > in the FPCR but had no effect for insns with software completion.
> > Without it FE_INEXACT is never set for -mieee code.
> >
> > Patch 2 makes underflow match the hardware for a result that rounds up
> > to the smallest normal number.  Alpha raises no underflow there and
> > softfloat does.
> >
> > Patch 1 does not depend on patch 2.
> >
> > Tested with linux-user only; system mode is untested.
> >
> > glibc's math tests (make check subdirs=3Dmath), run under linux-user:
> >
> >              PASS  FAIL  XFAIL
> >    master    1400   110      1
> >    series    1510     0      1
> >
> > Nearly all of the failures on master are 'Exception "Inexact" not
> > set'.  The XFAIL is test-float32x-float64-div.  On master it fails for
> > missing inexact; with the series it fails only the four
> > div_{upward,downward}_double cases that glibc expects to fail on
> > Alpha.
> >
> > The tcg-alpha-linux-user suite has six failures (float_convs,
> > float_convd, float_madds and a plugin variant of each).  They fail the
> > same way on master.
>
> We need the float_* tests fixed to get this series merged, re-generate?

Thanks. Fixed in v3.

