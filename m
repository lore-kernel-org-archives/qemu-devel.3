Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D44C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCO7-0004lj-Hn; Tue, 09 Apr 2024 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCO0-0004kN-5q
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:23:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCNy-0008NC-GQ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:23:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e2e09fc27so7993243a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712672621; x=1713277421; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rj3/AP/rDLvz01m+TgvRqlzcpOHqKqiKCGwLrICtLmI=;
 b=iPc0bpulT/uV2+IKH30PBuBDCGFDBvVc96ovACCM2yGIywJrF3zPfTIZSeQk8EDLf7
 Ud1m3ul6VlCtUaeSQkrhOc47YG1B9W+e0/7/+lp+/kK/V4qrqY40E8F2zc4L8tv2gxJv
 79GgLiSa3NggO/kwQ/NO4W6eqrDbKcMW8TjGGNwzQ1htRiAHbq6AM1KTiI6cQG91JSD1
 MXr3vqGGoXFn2Uimq+5HYrP2S1v2OMswfwGa+I9zKhizCgQ8pXrdsgLqyLh+7IvZ9rqG
 rb0F/nXADmwEh0E+VQoR3PcHGbdG9OVehjTRHmLuFADKPAyC+5FzSuQUk9uumRubIn+L
 COSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712672621; x=1713277421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rj3/AP/rDLvz01m+TgvRqlzcpOHqKqiKCGwLrICtLmI=;
 b=X/0aMfHFQFzFb2QBwMRDYFNkPaQdZ4hfZbdQVRnpuquvvPH0lYd7bjPSoPY1Q1U1uW
 j0ZJCstqRNux4MCpK/Fvx0gUH/kyp0eiw2EMOkTY6KSjjCX1qVQ0t//8T7Sqlj2zJbZL
 IeteHOYLsLoLY0cn1agfMQgXq95vZVmXQT2+rB9G+5HT0OlWo7giRDcMAO+ZZUUJkhk9
 lpuD+BqCfhtZLL32phEG0TE5I/0vNR3ulb6RWJfb1hHwrCy7tOepKXR72HRi/E7Uy1cy
 squRRRnLW/Hg0yRlHSYlq3KNA0EfRGuGJCUdHzgXa2VvaC65uroGmoM02hB+TWj9Zuc/
 SQsg==
X-Gm-Message-State: AOJu0YxcUHjscA+jGjNO806VZsIqpVf2qpI5LOdphh+/Z3j/J0LNYS4V
 5mkvwy7MwpnQLjLgyLmund+hD8DEKt7nNkoq4aJjlH7g1OdK4EScBlh6zJsGxM5uyGP2EOcnh8b
 S0jMz3Ve7YRo+ZJwEWeLYuMTSv2Oou8lEn530t2EO/wOsl8k2
X-Google-Smtp-Source: AGHT+IGP7pJFs2V0uYWTgE/Mp3pYoPEcZSbF63nTJWREXqkJNoE2tXw5LGGT57WJvWoSn8BxFu1LAkBRWfPGm8MuwJs=
X-Received: by 2002:a05:6402:4001:b0:568:d6a2:716 with SMTP id
 d1-20020a056402400100b00568d6a20716mr3192605eda.7.1712672620775; Tue, 09 Apr
 2024 07:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240327102448.61877-1-kraxel@redhat.com>
 <20240327102448.61877-2-kraxel@redhat.com>
In-Reply-To: <20240327102448.61877-2-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 15:23:29 +0100
Message-ID: <CAFEAcA_4SJFozGAprmMy4AM8Lvp9M2+aZjz3zwNaA2bdkuHKSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] edk2: get version + date from git submodule
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Wed, 27 Mar 2024 at 10:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Turned out hard-coding version and date in the Makefile wasn't a bright
> idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
> from git instead.  Store in edk2-version, so this can be committed to
> the repo and is present in tarballs too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  roms/Makefile | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index edc234a0e886..783a5cab4f4c 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -52,6 +52,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
>  #
>  EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
>
> +-include edk2-version
> +
>  default help:
>         @echo "nothing is build by default"
>         @echo "available build targets:"
> @@ -147,10 +149,19 @@ skiboot:
>         $(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
>         cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
>
> -efi:
> +edk2-version: edk2
> +       if test -e edk2/.git; then \
> +               echo "EDK2_STABLE = $$(cd edk2; git describe --tags --match 'edk2-stable*')" > $@; \
> +               echo "EDK2_DATE = $$(cd edk2; git log -1 --pretty='format:%cd' --date='format:%m/%d/%Y')" >> $@; \
> +       else \
> +               touch $@; \
> +       fi
> +
> +efi: edk2-version

Do we actually need this dependency, by the way? I think Make
will rebuild edk2-version regardless because it's included
(and it would be too late to rebuild it as merely a dependency
of 'efi' here).

>         $(PYTHON) edk2-build.py --config edk2-build.config \
> -               --version-override "edk2-stable202302-for-qemu" \
> -               --release-date "03/01/2023"
> +               --version-override "$(EDK2_STABLE)-for-qemu" \
> +               --release-date "$(EDK2_DATE)" \
> +               --silent --no-logs
>         rm -f ../pc-bios/edk2-*.fd.bz2
>         bzip2 --verbose ../pc-bios/edk2-*.fd
>
> --
> 2.44.0

-- PMM

