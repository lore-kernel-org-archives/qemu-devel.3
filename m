Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F31EC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTpM-00032R-UQ; Tue, 05 Mar 2024 07:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhTp4-0002hF-SU
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:23:11 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rhTp2-0004s4-Sx
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:23:06 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5a122beaa1dso1456771eaf.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709641383; x=1710246183; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P1Hp3aVhZu41CzG07NVq6h+Umi1KGV531MOFl2BEN8o=;
 b=UMlMSCT+EuFN5oL5eNOHSwkfQ2/xZPy5Bphi3NYABzIOlqF57YPfaYdkyk3QY0UG9Q
 jSa8BODSxZQJtbDVU+Qug8k8pxU1MiZtKOi4/CG770012EHjFrC9F9EmCTEZGIufnUaA
 fHF82d+QyjVa+6R5CeM67V/OtP2t8nQeIysunWm4wih4rzz/WlLwNf5IOhNu0qVzMhWT
 Jti6TcnsZp0ATgLurymWrSyFmLo6ZZQeM1zMkJVQRqzBF2BBkgcLzqF09d9SNEyKwNRl
 yglChLHzmwB0QexgbyQtAkN1vDPhLjhLj6qmALRs3+d91MP04iQ7R/Ms5DjqFwtS2z5M
 jP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641383; x=1710246183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P1Hp3aVhZu41CzG07NVq6h+Umi1KGV531MOFl2BEN8o=;
 b=wvt32JpsBH4p6qkvgV0qnqzspCiah/Qssxo+cuuJ1EsvoYgIC4Q9GyobswFuGbImK9
 dlEjpmXXsKM5cAAcgJEXG3tlrHUNmdadMVGBMe1V1D/TBG+M5unxQu+jSWj/oeJ6ttc2
 U/dci8vPasYMTg2sFcgM0ye00oNb1XUZ6Nv8PqaU0STbgPhFOFtQVsGq0o1JlkNQU3t5
 gvqxqxSGR+pKsyWARNDn5cfrCAhqYSa8SnVTZC60k/HHsPlF0zlgDSBEJeGp1ItN96d7
 pFG98GQwWRXzcoQ3eQvVUnoudc9V9XukqPT6+WMOAR74I7QRhmzEFP35DInNJ7PQ4IZQ
 HQFA==
X-Gm-Message-State: AOJu0YyFaFE06b7+f/qMJzfU/Gs2CA5Fotk7OaClDkm5kysf6k0jBjlq
 9L6ks3+cFjxTkWY5ymy7z7y/4m5JltJJaH/nfjqg62S+f6ol9+ZUaRTGWrfrDQaf7KLOorZpj8r
 9WtPDEy00IGD0tCcDTJcku5DDZmA=
X-Google-Smtp-Source: AGHT+IH0V4OHWUlG43VoOCpvigX7uOo9aWZZ8KhYlmI+JvScn6PMmWA8it9aVryX5Kj6fS45Lwd+hJ06n6TNB2u0ngY=
X-Received: by 2002:a05:6820:61d:b0:5a1:27ad:9b9d with SMTP id
 e29-20020a056820061d00b005a127ad9b9dmr1793685oow.1.1709641383464; Tue, 05 Mar
 2024 04:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20240304185149.1475336-1-mjt@tls.msk.ru>
In-Reply-To: <20240304185149.1475336-1-mjt@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Mar 2024 07:22:51 -0500
Message-ID: <CAJSP0QXFWxepTZpv5ojcf-h_LbFxL8DRibcGG6hqQRLyEA366Q@mail.gmail.com>
Subject: Re: [PATCH] make-release: switch to .xz format by default
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Michael Roth <Michael.Roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 13:52, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> For a long time, we provide two compression formats in the
> download area, .bz2 and .xz.  There's absolutely no reason
> to provide two in parallel, .xz compresses better, and all
> the links we use points to .xz.  Downstream distributions
> mostly use .xz too.
>
> For the release maintenance providing two formats is definitely
> extra burden too.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  scripts/make-release | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/scripts/make-release b/scripts/make-release
> index 9c570b87f4..6e0433de24 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -47,5 +47,5 @@ meson subprojects download $SUBPROJECTS
>          CryptoPkg/Library/OpensslLib/openssl \
>          MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
>  popd
> -tar --exclude=.git -cjf ${destination}.tar.bz2 ${destination}
> +tar --exclude=.git -cJf ${destination}.tar.xz ${destination}
>  rm -rf ${destination}
> --
> 2.39.2
>
>

