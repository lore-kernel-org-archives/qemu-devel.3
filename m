Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEC606A336
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UmVWQ40m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRSdu-0002Jp-Kg; Thu, 12 Nov 2026 06:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRSds-0002JD-Tp
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:06:56 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRSdr-0006h9-9u
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:06:56 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67c08c7adadso3542591d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 03:06:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794481614; cv=none;
 d=google.com; s=arc-20260327;
 b=D/9vWfOuAN8jb8JT3FOpTGwH5W8bW/FgsF3wGpwKMJUIEffOcTw5tD2vVKL+fCRtoV
 lQcoUmbmb9aB5Tun8azS+dM/8jfSwaunvvkJ4W44EbccD4D7ivR+38TOKultpMJa+ABV
 im9HAp3Z6HzA9Oau9dbty1WBhwTvludYUbhsKMT3BfKhxns8vXD8E3j0JqrVWpqUK82f
 a7f70hTWzQzcqzVdRGGe0GNture7P/7yj0PK26O8SYe5+gHqZygdkyRMuxzkS2pzSDWj
 eU9+Qi9+cWvF8Q/pvCb3CGnN1uOb5V9O1VA+3lqiY5zACM0BX0Oi15Dt0rAU7fEq5a/L
 6WQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yt7H4vSAKUoDyWtpqj39gt9BaKt31J1dKI5b2Gmc2ko=;
 fh=gm+gnLgiyhnP+fRg5/9CG12x5J3QHFV9NI1UDrEKAIM=;
 b=lJmNOo6DUrEZ55WVseQSpC86wMJg7cDNkNY6uqOOm0FHR0s28TGwc8O3gQaDsd5MVj
 Pm9VzJeH7XZkI1KicK0O6p/YESb21CkK7c0J7Pb6R/n7cJfZA64hYUFQDCUPkBAZ5efk
 8PZ9YSOBQtIMWhU5Hk7TRqE7RgqlaOCcxxN+zzoH2rQ2dWngFwfkgVdf9MwV1LlMeLgG
 Z8t3ofXFNzrnzwOa4YVNuymSihlg3wdbvghW6ee68YPWXaki+a4J/fqkly+bahezN16p
 R1ETG7XxoBMxTevoXkB47uYete7d93XsuTKDIPXfM7PR/WF5n8DUYDrFe8+9PFKO26P6
 WgWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794481614; x=1795086414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yt7H4vSAKUoDyWtpqj39gt9BaKt31J1dKI5b2Gmc2ko=;
 b=UmVWQ40mhxGPMdmgBGikinSVAeyfK5FsnFq4y0maLJj/Ddv/ekhs4REA3qtdd+n25J
 DkPtU9Cdo6SWxnS2CtF9ma7Snc0YlcLwK/PAVFJx33/mB8ubKQH+J3vAHqMe1dYM4Swl
 9OMCj2WMv4vjcSqavzol4Weyb7EivW+BhCyABR6h8SMh/dSOOaQNOvXyqWM9Rg04AWgp
 +5peBr7rZhEWnc/foH0N6SRgIaDNwTNmvX3q4feRVjslB5XItQ8/sMch0GOXIYCChfsa
 R2woD4AfmjTYNN2XWsaTGMtkg3UoKuCWLM1m+zbll6qeod6+gB4XWoSPBJd7zwq2mTA6
 ZTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794481614; x=1795086414;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yt7H4vSAKUoDyWtpqj39gt9BaKt31J1dKI5b2Gmc2ko=;
 b=enPQ1caFASyUZ7D5xiiWyc3UTBeA2V82zalYcTtHMkdiqT3FqbkaGTiopHy1m6Z3K8
 hngOuP9chE9BQzzReDHCW/XlDZrFbV3lokeNN0jkFGEC2S8Vf4PGKxXdbfOMzhna8T/U
 7Z0YXjuoXtQSUKbd53wrW09QkoGK8bfDAjQttkDwMxzMOlvLxNcJ5stwegtZMiO8y0+m
 XRgskEVwhJtSfjB8rmYyfLSsqMNaS7gBDyApSvGdU5lXdxxb72tH9+7kVD4EysDaGT+w
 fd09yaEWrUXyBuH2nlJi7hzP7yXTeqn9QMWspcU4YAHvrpFPFiGmGk1k+g3lGmf4fvF8
 umIg==
X-Gm-Message-State: APuU4Z9KujOHIdCXLPFzf30hIyZsbn3MwP/w+eoMf8PP2aRZQWp8QzfJ
 ewBasjVKKh3Ut1O1W8SXUuH5jc21OtSQJZqVFiKamSDn/31ljCRqz1YpFhZDx0xtqWpyCL1xebl
 1F8RbBAz4xdoLlg1mJkk+bINoT7OeqzvFGorDUQGapA==
X-Gm-Gg: AYBFou2GTN+BSvsAu7W1sZhUUSk9mLZ9g1CDETLcWKM4g+DOATIIAahwZHAIVXHMvhf
 OCn+jWfjEIUOdjmeVEGRGxYCWXb6WrFZpkZtlmgRBGHWGWGoIySWO3n3TL5EkrKzfzr2ga7ZtcU
 2JdnsgC5h6g4te+YCUUtRnF1pjciFcT/UpI4tmQMR92nuoutRufkNKBfZXfVPq8/tVWu17Cfa15
 iEUXJVg0Yx7TTx1Mexwf4dWORajFUiBPyuc5mLGWYywcd8KGaiPEXqpMtc14M72Iwmvyu1X9DzU
 rFpdqmFwIDKJY/eUBa9DmoTQKgZqRFBJoX3sPUAW2+wewiNSRe5yo8tTh2Ef1YWnidS+hnzRmMR
 WxrtvN8xqZcJuXXgjcdDy5pLRMScPLso4+1e/DvgQLC3poldCb4yz7Sb9XOcVHpcZ15pMBAF1uH
 CRsq6CDzmthb6TMK6kdd4HEQ==
X-Received: by 2002:a05:690e:13c6:b0:67d:83c7:ddd2 with SMTP id
 956f58d0204a3-67d83c7e1e8mr166692d50.37.1794481613758; Thu, 12 Nov 2026
 03:06:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023180539.1574134-1-alex.bennee@linaro.org>
 <20261023180539.1574134-4-alex.bennee@linaro.org>
In-Reply-To: <20261023180539.1574134-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Nov 2026 11:06:41 +0000
X-Gm-Features: AclHuK-fn5TN3gddW9Qns_fRswlaFGJy9ePBEvV_kmnGD0Pmc0aTLIBCQr9LMto
Message-ID: <CAFEAcA-i6SP=Z96DKvckc-BT0eDXqKUOjdk4ccKUeORB9o=-hw@mail.gmail.com>
Subject: Re: [PULL 03/19] .dir-locals: include QEMU code in PYTHONPATH
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Fri, 23 Oct 2026 at 19:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When editing python code the linters tools have a hard time with our
> imports as they can't be found. To ease this we can expand a
> PYTHONPATH in .dir-locals so at least Emacs users can have less
> warnings in their editor.
>
> I still get complaints from python-mypy about missing library stubs
> that mean it can't do proper type analysis though.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-ID: <20261019192704.3220373-4-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> diff --git a/.dir-locals.el b/.dir-locals.el
> index 3ac0cfc6f0d..51871619422 100644
> --- a/.dir-locals.el
> +++ b/.dir-locals.el
> @@ -1,2 +1,8 @@
>  ((c-mode . ((c-file-style . "stroustrup")
> -           (indent-tabs-mode . nil))))
> +           (indent-tabs-mode . nil)))
> + (python-mode .
> +              ((eval . (when-let* ((root (locate-dominating-file default=
-directory ".dir-locals.el")))
> +                         (setq-local process-environment (copy-sequence =
process-environment))
> +                         (setenv "PYTHONPATH"
> +                                 (concat (expand-file-name "python" root=
) ":"
> +                                         (expand-file-name "tests/functi=
onal" root))))))))

With this change, emacs now complains and prompts for input every
time I open a Python file inside the QEMU source tree:

=3D=3D=3Dbegin=3D=3D=3D
The local variables list in /home/pm215/qemu/
or .dir-locals.el contains values that may not be safe (*).

Do you want to apply it?  You can type
y  -- to apply the local variables list.
n  -- to ignore the local variables list.
!  -- to apply the local variables list, and permanently mark these
      values (*) as safe (in the future, they will be set automatically.)
i  -- to ignore the local variables list, and permanently mark these
      values (*) as ignored

  * eval : (when-let* ((root (locate-dominating-file default-directory
".dir-locals.el"))) (setq-local process-environment (copy-sequence
process-environment)) (setenv "PYTHONPATH" (concat (expand-file-name
"python" root) ":" (expand-file-name "tests/functional" root))))
=3D=3D=3Dendit=3D=3D=3D

The commit messages says "so Emacs users can have less warnings"
but from my POV this is "more warnings" (and previously I didn't
notice any warnings at all).

I think emacs is correct to warn about files and configs that
try to automatically update PYTHONPATH, so I would favour reverting
this commit.

thanks
-- PMM

