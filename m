Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPee-0005qI-9h; Fri, 09 May 2025 11:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDPed-0005pz-Bt
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:28:51 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uDPeT-0008Kk-Nf
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:28:44 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e7297c3ce7aso1899240276.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746804515; x=1747409315; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fm+ll4+BV5oVu4s3b2y9Tr8jYcVIflrqUCDYZvDl7K4=;
 b=sJqZ9h/4xfByWcy9qTF6ArQqq6GBMXnz+J+psgAZJiOZMVjUN9f9HKIYZjiHGhGR6+
 l9rcLGPfNwUrgteFLEK5TFN85zhFzAu29Cimq+Ml/8zDFIN3mw6Hn24ie4XbB7j+aTIv
 GONc42rQKlbcmZ1vDv25RT04KAvL5hiiGRYmmIX4pGrKemVXdbwu4rENSa6UVWHKkGWo
 04fwL285MF2WzTYnflRKVIUcijwbcKw9Y7dAqdzAd6aStBaVv0vACxx3r0AIzAe6febh
 or/28gkOHQYe7d/abLbPkiLzc+BozFOwy0XiK/6z3bqujpETtiH3UQx6o95wJQNvvRD0
 xe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804515; x=1747409315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fm+ll4+BV5oVu4s3b2y9Tr8jYcVIflrqUCDYZvDl7K4=;
 b=gD+Yu06kOJWa4be6gGdXcuE4Tx0LZqUSFkNP5aju6x1HgD2z7Kf1D5S+1Ao9/ievH/
 crKgCi6Z45EpVNP6uHZg4AgYTdoFEGmzIaWW94fSEj0bpTvEGyE5WxxZhM0SRkCdqZSE
 rW6Th+POE/4wMl8ZUDs12h6jA1iA2d+6nl1icikQcdMGg+jH+jI+lGuyb8ooFdFDOP8W
 qDmacaIn9Clx9LlBUr3eMFFMCccH87NKcsiEpqFAltdJuyXCETtlrXMYWqkqzOhz7UYT
 4Vtay62ggt3fY3/SZFw+jDNfdRyisO/dFRiTcmwwATCNirHpIKDCfGaB8GxXNEh6esoO
 z9uw==
X-Gm-Message-State: AOJu0YxZir+BvTWNvEbtx22XZgnM64lVzvfyGJFrRV8p3H1jCZ28aks6
 6dD4DVjy8MDRUMeITI6OtGvSv/JQ6VUQkpzVyVTPoXjpiWF89X+ESpsEF0W7w35cOcIssgFSMl6
 wyHV9TauK6BnkD7QIiNfD5AADVhqeYuLATSs15Q==
X-Gm-Gg: ASbGnct7kYpQiiKGu6f+r1E73E6RR2JWFV/MGqJjkIQ1ouytu/AOd9CEfl3kEmYQXs1
 tHF8JdDdmRPDBEUSSj+TmDeWah1+2bcO+8vbMHlASRy4t+Nvsz54C1KjIftmmKEKqUtIIMPlx7O
 ZBDAttb61pb4dRdM21WcR1xIo=
X-Google-Smtp-Source: AGHT+IENDeYY9LBNvez25bPsLlT8ghYueLU0289NgzWNF4aZ7khnipyWn4o+ih6GSWfhAKK7XFPyLFyyVL0g7PneVOM=
X-Received: by 2002:a05:6902:2008:b0:e78:f073:b378 with SMTP id
 3f1490d57ef6-e78fdd90486mr4946072276.43.1746804515542; Fri, 09 May 2025
 08:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250509152201.19085-1-gustavo.romero@linaro.org>
In-Reply-To: <20250509152201.19085-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 May 2025 16:28:11 +0100
X-Gm-Features: ATxdqUGglpZndWYFS-wY94E5MDXRisbnNbKOoJOLAxrY6etxDsaL5hHrNrRI2oE
Message-ID: <CAFEAcA9p5GY2eQkLi41h_m-r2-g=T6eE8vGsza3933rejeB72A@mail.gmail.com>
Subject: Re: [PATCH] docs/devel/testing/functional: Fix typo
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 9 May 2025 at 16:22, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Fix the duplication of the word 'run'.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  docs/devel/testing/functional.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index 8030cb4299..9e56dd1b11 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -274,7 +274,7 @@ speed mode in the meson.build file, while the "quick" speed mode is
>  fine for functional tests that can be run without downloading files.
>  ``make check`` then only runs the quick functional tests along with
>  the other quick tests from the other test suites. If you choose to
> -run only run ``make check-functional``, the "thorough" tests will be
> +run only ``make check-functional``, the "thorough" tests will be
>  executed, too. And to run all functional tests along with the others,
>  you can use something like::

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

