Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE97606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KDD2kfni
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRqsX-0006iO-GS; Fri, 13 Nov 2026 07:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRqsU-0006i3-Vx
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:59:39 -0500
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRqsT-000167-6v
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 07:59:38 -0500
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-3704d30b84fso1210704eec.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 04:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794574775; cv=none;
 d=google.com; s=arc-20260327;
 b=VQ0dSuKAnN3zABND9jCmEHhn1oOrqJQwsyRZMicD2OZXCvkfnukx7fJRUL6Q/zUVb7
 Syqk7cH7P8TWthJPGjghhP8WUSNjy0QoQgv+dg69dYJhE+nq2HD4U/YUfP78Tk6vI1Uq
 UWtpRvGPo1AAWYbZ6IAqmRAt7mqzRQLL2CxfRaszlXfgP1VdoyIvVH0pyXf9gMJnQn1+
 X07Z43hMHC8hjaEUOkJ1rut0rzDUV4ckB9TG1N2l74vOv9prOj6tL/gD9FtgxxmCs/xJ
 HKWJg+jPp1QR11vo4k5Y2S7AUreN7CnFwmr601gD6XzN7bj3s/6xPI32HXDZLCQVOFsq
 3OUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IP+lNnPOVq65Ye+UpE4s/vw0RXm0XaHrEl0eg3nzOic=;
 fh=XgV4NwlJdv5QgomRnRvHEs3kXfQOA9/51zRCfgB3T2U=;
 b=gDUARZtxHdVO6X2t3r1DBxNjYtYUvdvtP0DEb8UHKh8SOYAhp/PGzpgOgfJOOoNoBV
 aRDN4IGc3Bd0zBAB8RsZ4viwu1mGLO4ckCdHxyKAbktgIIG5hDIJTms3wedgrmBI1HxA
 nQtpmbOfnQughk1RVEyEpx4xFZnDBtfL6JSUYv28HL0eMHQO7Rrbd6aBdtv+KauLcnAd
 1bxaLBzdNAOxG28F1G14ylGCh3rlNO7OkwxYYgHwQOMp4wHJEJTqJzWSXT4Lmtc4F5AV
 C7dIMgZFPEIs1R8IQFeGGBx77xvm2cSBeKmDpPaPmtf8R9T69cRS11qvR+5ohcTR8bz3
 eyUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794574775; x=1795179575; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IP+lNnPOVq65Ye+UpE4s/vw0RXm0XaHrEl0eg3nzOic=;
 b=KDD2kfniiLjb4MD9jwky38jUecAfARLYkyNdzNmf0j+60ZQ6TMXeIy4xLQZkTMW4qX
 rBcYZHVUlBc5zN2UFJdU4pSeg24DMfCMRPLVcSDJ35cWREdYh1yBctQO1yDam0OJIckb
 01GmT9COGX+S8J37I6tUk3PZdk9gXl3HsVNsDeiaHqoNF89R+Ai5q/V45VRSdvcXfTUE
 r+dYD6QHOgvFO4yHwyMqD4caLTXDKqvK1rrbRcryoQtzIbaF2IrAGG+5BjpP3soiafuf
 37Cu7G8K3niMWCvdSG8J8xTtlgxuum7yj3Z+J5PJuSfM+DvHkmzgbKmCQIgIbeByGufo
 BBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794574775; x=1795179575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IP+lNnPOVq65Ye+UpE4s/vw0RXm0XaHrEl0eg3nzOic=;
 b=iDnmjXaSHxnnxquvG0PQ+vStr77YNXnqCX3301i4k1L4kj7bYw57sxlKOJhPXLTPkR
 n8oJM6gYj9nesJF3afWthbm6L5/qYARsWtTnhkcW7O1o2pLycmRZBKybSZk31TCwk1O1
 a+FUkd1pGz8bATN84m7uFfNlTXE9wvMALnia2izoWoOo3WrHWGsDR0nbEjdbxZkFBwaO
 YHU00pOpRNTNpF1FZqhjSplL3OPyzXDabyF30gB/ycnVIZwsw9v8FyLQdyDWP3jv6EUV
 fAjve+B0JOYbqsG8AzBtOCE7vOfeiENWlpj1EBv9dvqXYhoozmuIODgNumM5Zs9k869p
 pyAg==
X-Gm-Message-State: APuU4Z9OG4kSWLSGvHAe3y7tz6z2+uKZiNSY55XZMK4Kwggr/MasbP+W
 3v8HSEIHYHhx5Mjdsxl9quS6j6Q3a/uoFGHgDQGYQJ2F5OmhYC5sKtZsO49vf9SicRHbSgzVzIl
 7eoa8LCiX9hEOaAkRUr3GkfnFz27Zwlk5UEzDx1L+sg==
X-Gm-Gg: AYBFou0yCXZpJ0LNcltlLJYcH+O6zEurOzRAJIEGSyn4Uzkqi+RZluNyC0OjWsZ3nZM
 67z/FcyMwa59PUFpU5QIRduIul0Gf4nX1N19qawK0OrkWE7hPnuLuzYX62DUUtz1TNeinaccGcJ
 r5LQBYjdcJpiO6afIGpwgbGduspihf+/ZiaDDDM7BwAgG3wRVCfRz0Xilf3YUcFTLyvq9Ho74yg
 YELixwKWSv4PXEk6deRph7zHEMIzpSJheVO8dLLzC3ehV2ohb+DS9baszVZ7IdJBLF3ONqJCL/J
 AmPT7zr9WT2sNTMBH44miaSKQyU7RstWF+1KjwOKkzqFHccYzoyuQjc8dwWf7GB5/VeRpcj390o
 GDhRLrpIHmUrjzBpmtRLTVwo9OU/J2xMzKCiP
X-Received: by 2002:a05:7300:e0a8:b0:36d:2704:6adf with SMTP id
 5a478bee46e88-37966c48b6emr2179414eec.11.1794574775174; Fri, 13 Nov 2026
 04:59:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113004452.3027978-1-alex.bennee@linaro.org>
 <CAFEAcA9YSmdh+FR8VEfxZcn3nn7tb96M_2d6Axtf+_-Uk4ekEQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9YSmdh+FR8VEfxZcn3nn7tb96M_2d6Axtf+_-Uk4ekEQ@mail.gmail.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Fri, 13 Nov 2026 05:59:24 -0700
X-Gm-Features: AclHuK8ndd-btkS4QXUVmhjVsjoX3p56uvAXiRYqr1PkPaNPQKKSX6HlX7gh_yw
Message-ID: <CAHDbmO2RzYGJ5UDeGEHHTRGmgvXknu7eQ+By57AYuPaY8uvbrw@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert ".dir-locals: include QEMU code in PYTHONPATH"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ff5bc4066027ffec"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=alex.bennee@linaro.org; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ff5bc4066027ffec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Are you happy to take via your tree or do you want a PR from me?

Alex Benn=C3=A9e
Emulation and Virtualisation Tech Lead @ Linaro

On Fri, 13 Nov 2026, 02:06 Peter Maydell, <peter.maydell@linaro.org> wrote:

> On Fri, 13 Nov 2026 at 00:45, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> > Unfortunately this relied on trusting the source tree via the
> > safe-local-variable-directories otherwise users keep being prompted
> > that ".dir-locals.el contains values that may not be safe".
> >
> > An alternative is for the user to add something like this to their
> > local emacs config:
> >
> >   (defun my-return-source-if-in-qemu-tree()
> >     "Return the root of source when in QEMU code."
> >     (when-let ((src (expand-file-name (locate-dominating-file
> default-directory ".git"))))
> >       (if (file-exists-p (concat src "/qemu-options.hx"))
> >           src)))
> >
> >   (defun my-set-qemu-python-path()
> >     "Set local python environment for QEMU."
> >     (when-let ((root (my-return-source-if-in-qemu-tree)))
> >       (setq-local process-environment (copy-sequence
> process-environment))
> >       (setenv "PYTHONPATH" (concat (expand-file-name "python" root) ":"
> >                                    (expand-file-name "tests/functional"
> root)))))
> >
> >   (use-package python
> >     :hook ((python-mode python-ts-mode) . my-set-qemu-python-path))
> >
> > This reverts commit 3112269be3ac92343a5f0e5d9eae919edd176a35.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>

--000000000000ff5bc4066027ffec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Are you happy to take via your tree or do you want a=
 PR from me?</div><div><br></div><div data-smartmail=3D"gmail_signature"><d=
iv dir=3D"ltr">Alex Benn=C3=A9e<br>Emulation and Virtualisation Tech Lead @=
 Linaro</div></div></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 13 Nov 2026, 02:06 Peter M=
aydell, &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Fri, 13 Nov=
 2026 at 00:45, Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.o=
rg" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt; wro=
te:<br>
&gt;<br>
&gt; Unfortunately this relied on trusting the source tree via the<br>
&gt; safe-local-variable-directories otherwise users keep being prompted<br=
>
&gt; that &quot;.dir-locals.el contains values that may not be safe&quot;.<=
br>
&gt;<br>
&gt; An alternative is for the user to add something like this to their<br>
&gt; local emacs config:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0(defun my-return-source-if-in-qemu-tree()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Return the root of source when in QEMU code.&=
quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0(when-let ((src (expand-file-name (locate-dominatin=
g-file default-directory &quot;.git&quot;))))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(if (file-exists-p (concat src &quot;/qemu-o=
ptions.hx&quot;))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src)))<br>
&gt;<br>
&gt;=C2=A0 =C2=A0(defun my-set-qemu-python-path()<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Set local python environment for QEMU.&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0(when-let ((root (my-return-source-if-in-qemu-tree)=
))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(setq-local process-environment (copy-sequen=
ce process-environment))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(setenv &quot;PYTHONPATH&quot; (concat (expa=
nd-file-name &quot;python&quot; root) &quot;:&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (expand-file-name &=
quot;tests/functional&quot; root)))))<br>
&gt;<br>
&gt;=C2=A0 =C2=A0(use-package python<br>
&gt;=C2=A0 =C2=A0 =C2=A0:hook ((python-mode python-ts-mode) . my-set-qemu-p=
ython-path))<br>
&gt;<br>
&gt; This reverts commit 3112269be3ac92343a5f0e5d9eae919edd176a35.<br>
&gt;<br>
&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;=
<br>
&gt; ---<br>
<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000ff5bc4066027ffec--

