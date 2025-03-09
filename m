Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21991C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPxR-0005mj-0z; Sun, 09 Mar 2025 19:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1trPxI-0005m9-Nq
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:21:12 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1trPxD-0007WP-7j
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:21:12 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5449801a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1741562462; x=1742167262;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dkybY9rPwcuwaJyhRKGheT34o+oeghuxuPPeSQErNL8=;
 b=Bm3JsjJs62u196yKxntuDzQrCGpQL8c/EdLpVucthWFjVjMOZt/LTuaR9kHLcRTsmF
 sL0/JRuV2Ly3TBF/x7IvWaEBx63p4/tmqlf8CWNRo0m7vjwTJqbnIwATKY4dYcGyD+EP
 qbNoS1pX6l1KgRSTPbpFkGyEp49cqCooDW73LElAZW0cdoHRUOcIMH2gqUvjW9A5iRH+
 Uv4RREY2TmvYeB2JXS6+0hKGlL6E6EbPjJCcRDvixHULHPejZqQ4CATb5QTKj+wQpwPr
 UsmeLQwpsH4AXaGI/gcrESxMVHkIEjYOKhhufuMUvjyujW+uvYqNmBMUFvM+ya22IW+a
 JRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741562462; x=1742167262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkybY9rPwcuwaJyhRKGheT34o+oeghuxuPPeSQErNL8=;
 b=cXghDoo8oIzbzxbDW4Gnomtkg8IdqHts1GgQkngMvfYZcaswpLFkWCp1pLoXD8TvgM
 BgjKF741PajQ4K7kxFnOyNr4HxCZU+qTP8qSadBm3BSUMDvFNA4PNYHHOMRiXJTBykkz
 7DzW4rVPiTx015knUaqYlZHOKJqqCEYT4K8g+QMtb/oiwhm/eyvNEXxVR/2gwLJ9tCw0
 CIRFRR+/hivaFJzQ6DoG4n4WbdVIDYJecZ/BIAyjFwPmwv/Tqg+7xN+wCMNLQ5XFMj26
 Z0xmXpygbOg6Fuiu75TL0cBVbE2l4ITH1kPoRxqQDr5BVkOuCd0w8EZDgXVUTtFYgilF
 VYDg==
X-Gm-Message-State: AOJu0YztasTMIp/FI2tUNuMTMzftNyPwOG5uho2r0qXzXQxXjci5edp7
 cciZIOTgopxonXPPiFvrwRcI0qYsKxsr9vmb6vJerPjjdcXs6Q5p6Pr86aHwJJmV/gX5NgeV82l
 Sp4GhhB51k2kul9WAvYkJ7mp7aeU3tw4wObgQovjtueXhj/sOpqE=
X-Gm-Gg: ASbGnctMXnS3NZvMaTYy/iYdWnNGfolGjm/6lKWfFeVEt7IlXkeQedB25eswP1duZks
 NVxrr1AhErK180IbFlALlk3zL3xTPPr4eulG4u5sZCLmt6IrgXvr06lcHyHTTkgkdbVNrdQSwT+
 bRscnw72wxas6OmNmo4hyoZbMVBw==
X-Google-Smtp-Source: AGHT+IEgdqXGvecDd32bsjMC2NLXoZCCiz/3Tk6x4+0ZjGZXm00XbKebTFNff7D5VYwhYpi0vMK/xQ65Eu2yUxCWfFk=
X-Received: by 2002:a17:90b:3ec2:b0:2fa:228d:5af2 with SMTP id
 98e67ed59e1d1-2ff7ce9b7d0mr19109221a91.15.1741562462607; Sun, 09 Mar 2025
 16:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250307130951.4816-1-philmd@linaro.org>
 <20250307130951.4816-3-philmd@linaro.org>
In-Reply-To: <20250307130951.4816-3-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 9 Mar 2025 17:20:51 -0600
X-Gm-Features: AQ5f1Jo6bUjUELjdFVxptOGt1krIMHXeRYiGwRgTzPHrVTJwZAKMfZqYvDCJeQU
Message-ID: <CANCZdfpOnuvfW1V88kUC0Tqi8cQe-G7e_CD942jAd5yhsdh-VQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] bsd-user: Propagate alignment argument to
 mmap_find_vma()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Riku Voipio <riku.voipio@iki.fi>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000f037d7062ff11b90"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000f037d7062ff11b90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 6:10=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Propagate the alignment to mmap_find_vma(), effectively
> embedding mmap_find_vma_aligned() within mmap_find_vma().
>
> Since we ignore the alignment in do_bsd_shmat(), leave a
> FIXME comment.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  bsd-user/bsd-mem.h |  2 +-
>  bsd-user/qemu.h    |  2 +-
>  bsd-user/mmap.c    | 10 ++--------
>  3 files changed, 4 insertions(+), 10 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000f037d7062ff11b90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 6:10=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Propagate the alignment to mmap_find_vma=
(), effectively<br>
embedding mmap_find_vma_aligned() within mmap_find_vma().<br>
<br>
Since we ignore the alignment in do_bsd_shmat(), leave a<br>
FIXME comment.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h |=C2=A0 2 +-<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0bsd-user/mmap.c=C2=A0 =C2=A0 | 10 ++--------<br>
=C2=A03 files changed, 4 insertions(+), 10 deletions(-)<br></blockquote><di=
v><br></div><div>Reviewed-by: Warner=C2=A0Losh &lt;<a href=3D"mailto:imp@bs=
dimp.com">imp@bsdimp.com</a>&gt;</div></div></div>

--000000000000f037d7062ff11b90--

