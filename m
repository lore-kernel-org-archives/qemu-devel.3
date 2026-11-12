Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D7606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qdWOQzXS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYz0-00058i-Hp; Thu, 12 Nov 2026 12:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRYyw-00057x-Pm
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:53:06 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRYyo-00022b-9h
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:53:06 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-677bc4704cbso80243d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:52:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794505975; cv=none;
 d=google.com; s=arc-20260327;
 b=FridcCuihOhawKBHG9PrQsrQyt4AZbV30OknRhC6h8WBeJko6EGpfX5XPB0PDtX/kj
 920Iqdm9GV7PtNUwaGy2MdFsAuc3VTZp4F2DMEI+qfr5K7pBK/wHj97Jf/yMS4OnxanG
 wVmMR+/4vTJyOCe9gkg7Lp4i5SiY/dfR11GCSxZcPhPxGcg33kTecUQTS9ta+gcmRqsv
 MKmS986HaLIAS87Y7R85OttOjvqD8Q8CnXtL68n+mgmO6/vvAF1hF9DC27RI4YYd3Dtr
 TCboNez4M9Hjqk+qwM0I+lOdKhNZOZE3WilIkY9Pt2tKVuKlmeX6tNbYQ/HajOcpZjX2
 V0mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nf3vkWIV+wN9RY+bURM8lpfIXEmMBBIniBP8AXgOyTA=;
 fh=w3US15iX+NoJPbQobzeZ6/B7cq8ZLBG6SzB0JMRDU4Q=;
 b=BPb5hhSbyju6VQ+0/iUxiZrX7IcOaMkwuMc4i+2Q5zPc9Bs8ZFM6OhUK2R/zZ/MDCQ
 H0vOjlwxP9WTB+ABUVspNivdK/1f+Z0eCNYapIoAcXl3ODxFEx3uZVdg9iNdMFj6FUz7
 uC0yASwfv/DRgienWqRB47/1aJOZx4lmrZr3WbZoxr/5ossvm377b1y4D0OjBZuki+QE
 29DOCcogExPXKM2WzO0wpa6hY1D5N+BFmaloZk+Xpl4W/diUBuKOhTXZnFyNr2/1qAG7
 c3bBMWWGsxOoIYyETZ/A3b4A2gSkqo1s/FZXUFQJ/0WJiamlbu5RZP964K8f5dgg7nxP
 WcTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794505975; x=1795110775; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nf3vkWIV+wN9RY+bURM8lpfIXEmMBBIniBP8AXgOyTA=;
 b=qdWOQzXS4mLpzBqpWliJjOChSiatbP1LPmcG/sAdp7DlcORu7I0zc9yicYuPDC/cKY
 fzY6UyWBBVtGDBtnLpsx+d08DMSdVsSXa0V4Zxwv5SZCRILQ03DgxyCWtt9ss7Et0nEu
 +XetLFFz2XsbL9pd7MUHIl1qhG4QLy5DbP/vfpJUreqkbzvu8agtiwz70bNyI5GdUzD2
 aby5y02iqUMDS7tWuYeMrjfH3chGXbE/LwtPlLAow0BrfFAHdN/Af9tZzcfsXhEdCcOQ
 cqT6NopCzBVuuoY4DCHsvib2/yPpiF7R5PTITeIj3CmX+3p6lRu1sjSiej81R7QOkOGE
 2VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505975; x=1795110775;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nf3vkWIV+wN9RY+bURM8lpfIXEmMBBIniBP8AXgOyTA=;
 b=rQi7hT/gfx9dpR6TRtBp7CAeATplYzdviQPXDWDcZ0k2RI0amvS6ieWlSj/1UVbNxi
 nhtBdipGnA6Ei0T8czRoY6SOPDktKxP2TuRnwC8ySGdMvhup4bo6zxgkVfCQ5+NeCOSX
 jA4H+qddCdDPpQr4M88irm0PeMJExAwTHufo8gbFlUtxxWUqdEQbq5H4gNSbYYaBO2FR
 iwdrB3Y42a9KnyP8CyLnTAlE5FDNYi4cPYEUHH7sD/KWD00rvBckdw03jCY7T6Vs2SQx
 IdN22kDRMMK4nH4HUsB659uPlZpotDUF915D/zjmYYkzMORxUGkbWBtk4YhH8KUK6ljh
 EENQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFyo4rVHlvsAyZL0AxDUaKx3EP38vMIEfMZgeU/IqXVxsdLEl7QwOWD9BChTcJo5OgAVLNtkFiT4Sh3@nongnu.org
X-Gm-Message-State: APuU4Z9fqjGwGr3lOPR7ad/EqFagEhUB7flKo2TReHi8dHWjhkxbb080
 ZHLNL7Bf2DIRzdXD+aB6BMLQAykm4xQGevOvCzq8Vhk+kHcPUTHIJ/RU11/PFaRdwXZjPIO1URg
 xlRC+k6/wewnM8rOcRDNgK6wYAipZITV0tWC8YvhaAA==
X-Gm-Gg: AYBFou0MknmTpXwVQGIKyM2MlcCP6/rfYhWj9mRXQWMAc/R2lmBaVXLCoO2KLeiLDUu
 lOogJVlzUW5ZNTbexb+GEKC9yvyCDPhY6egNIxZAukc+yiEwLMXsWeviP1NBst1Pr3pqwi1z40v
 8MGGXmkdL5dPtN/M7VPe8qqb2N8jdfS3QLhEQ37iWhY6J0uwoxGXOilih8yIihvw8wgwQVnOkyg
 VpUsBVzReXEvJ6fKIlMG5Q/jz2O0tZupV/aP6TYkV0p3pA78aVD4xMVWzSu0K7YExS4Npj/Iyj4
 nu+nPNmI6x/2EYBU5kzT0o5rHrn8EQzqJmKPXGiNVH9sA0oBGNw7+WYqwceP0kCT7KtjT8yU+9+
 lOI7x873CM87YPFOz85PlQZrpuCHN5N4mgz0S0OzJYBm1Rc+JijUTlo61Z3hlEaehgEs2X2NK0w
 I6ywmQ+WCAG5ZpWBieJfEo
X-Received: by 2002:a05:690e:1697:b0:679:af57:d199 with SMTP id
 956f58d0204a3-67d89681ae0mr84366d50.57.1794505975077; Thu, 12 Nov 2026
 09:52:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
 <20261023180539.1574134-4-alex.bennee@linaro.org>
 <CAFEAcA-i6SP=Z96DKvckc-BT0eDXqKUOjdk4ccKUeORB9o=-hw@mail.gmail.com>
 <87cxsaqm1r.fsf@pond.sub.org> <87tslmarws.fsf@draig.linaro.org>
In-Reply-To: <87tslmarws.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 17:52:43 +0000
X-Gm-Features: AclHuK9JZwPzn3s40b-nsmSjb09EVfrowPFYDn4M5LWhbiV3EIQoCDcu_siCdP8
Message-ID: <CAFEAcA8OOMbrPqhDJ3=K3m5fnfqAQg+Eio46=krPk+PkaLAXeQ@mail.gmail.com>
Subject: Re: [PULL 03/19] .dir-locals: include QEMU code in PYTHONPATH
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 17:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On Fri, 23 Oct 2026 at 19:06, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> >>>
> >>> When editing python code the linters tools have a hard time with our
> >>> imports as they can't be found. To ease this we can expand a
> >>> PYTHONPATH in .dir-locals so at least Emacs users can have less
> >>> warnings in their editor.
> >>>
> >>> I still get complaints from python-mypy about missing library stubs
> >>> that mean it can't do proper type analysis though.

> >> With this change, emacs now complains and prompts for input every
> >> time I open a Python file inside the QEMU source tree:
> >>
> >> =3D=3D=3Dbegin=3D=3D=3D
> >> The local variables list in /home/pm215/qemu/
> >> or .dir-locals.el contains values that may not be safe (*).
> >>
> >> Do you want to apply it?  You can type
> >> y  -- to apply the local variables list.
> >> n  -- to ignore the local variables list.
> >> !  -- to apply the local variables list, and permanently mark these
> >>       values (*) as safe (in the future, they will be set
> >> automatically.)
>
> It should mark them as safe for this particular directory, not generally
> for setting PYTHONPATH.
>
> >> i  -- to ignore the local variables list, and permanently mark these
> >>       values (*) as ignored
> >>
> >>   * eval : (when-let* ((root (locate-dominating-file default-directory
> >> ".dir-locals.el"))) (setq-local process-environment (copy-sequence
> >> process-environment)) (setenv "PYTHONPATH" (concat (expand-file-name
> >> "python" root) ":" (expand-file-name "tests/functional" root))))
> >> =3D=3D=3Dendit=3D=3D=3D
> >>
> >> The commit messages says "so Emacs users can have less warnings"
> >> but from my POV this is "more warnings" (and previously I didn't
> >> notice any warnings at all).
> >
> > Same here.
> >
> > What exactly was the problem this patch tried to solve?
>
> It ensures the python lsp's don't complain about invalid imports because
> they don't have visibility of the PYTHONPATH set by ./run

That's a bit unfortunate, but I think it's a lot less bad
than emacs complaining every single time you open a python file.

-- PMM

