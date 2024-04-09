Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCDC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBFc-0007RK-V3; Tue, 09 Apr 2024 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBFa-0007Qm-7E
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:10:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBFY-0003Ta-FB
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:10:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34339f01cd2so4199792f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712668255; x=1713273055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4Nxs9MMLY9GubrjsqvRCZSSNoPAbmWLaA+XlQagn/U=;
 b=HZMSng0Rh/ueH4F401TF2aD4RSy8GoOp5TD/y510jyl4SreqOyKv+AqNkX1VBuDaRN
 KS2qsDQzBIR4jtLkweTt7t5N96ExhjHioQqKqy/etXdgLGPRuVoCcb6CLnrQ9DYHsR1Z
 5KOIsS0vmNsKnICnGH/17bIrDOVPsklFnlBSUyqom86VGNcfcc5nrozhYOU1LtLhnkGG
 b1a4aIYYrfJ5C+KmY9N58BIkwC1o36B9ng2QchykEcm9RdNRv0VBrJrmFyWMCwkFWTLK
 Jcsj1GJXFBbTXPEq2wDutRubrFlJiF3AzTcWMXAmYu+uS1wujDeHJUk5QLvd5eTR4npZ
 CKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712668255; x=1713273055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4Nxs9MMLY9GubrjsqvRCZSSNoPAbmWLaA+XlQagn/U=;
 b=nbg9vLOcSJc9GOytNXJAv5uDUMWizTlZzzC5FgppVW0On+kkQgPrF+5v/ySTGa8Rd+
 X7PIeIPRuwOHHfAO3w66p0dHCBP78F4DAqRzs5hJnl/tkEw2ptJ0auOdZk8cBhdzNM/q
 TAquc4kbYVQMUyxdLSFo5iOSkTI/C8AbnYPXB1bEh1I9tUIiPwl/Sa9lsdDaMVXCH4A2
 BP15S46zN53A+C91eAUlQNbgEJqRHjabIceT/W9jyEhy7RK3NhbVLD1JQHJl00orRLxQ
 x/pDNiBqL+JGwuObkFjkB4Te2mxk3G5qMdP6gf1wKNiin44KbvpUepTkVHIBV5EDY6PI
 8HIA==
X-Gm-Message-State: AOJu0YwT4Cm5zJWgcXMV2nCyYLGCcllassZlT1vfz/Nz8hxo/3p70D/8
 hvb9fM5YAFogH4ZYpu5oZ5ZFh9KH9z5itpw5IzvmFIJNpHUTSBekBPbWaMCP8ljQeo7riVxf+2z
 fECw0JdPl6Qp0n9shdOJEyCn4dcjTcc++iK04Vz07hnyLPhzv
X-Google-Smtp-Source: AGHT+IGdboeP3nS0ZNDCCyi4kYunzpr0HmnyfhLMnW7GnpbksV0t3luQcPIyTXOQofmSo1y7c1tCmQdoUk3sXkI4jFs=
X-Received: by 2002:a5d:5047:0:b0:341:d8a9:5b7d with SMTP id
 h7-20020a5d5047000000b00341d8a95b7dmr7619384wrt.28.1712668254585; Tue, 09 Apr
 2024 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144440.1069662-1-kraxel@redhat.com>
In-Reply-To: <20240325144440.1069662-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:10:42 +0100
Message-ID: <CAFEAcA8eX=-6yXCZ2+X6niJPcgzkzXfHT9F6LpbfqV4b9VRW6w@mail.gmail.com>
Subject: Re: [PATCH] edk2: get version + date from git submodule
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

On Mon, 25 Mar 2024 at 14:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Turned out hard-coding version and date in the Makefile wasn't a bright
> idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
> from git instead.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  roms/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index edc234a0e886..534eba17ebd0 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -51,6 +51,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
>  # efi ia32, efi x64) into a single rom binary.
>  #
>  EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
> +EDK2_STABLE = $(shell cd edk2; git describe --tags --match 'edk2-stable*')
> +EDK2_DATE = $(shell cd edk2; git show --pretty='format:%cd' --date='format:%m/%d/%Y'| head -1)
>
>  default help:
>         @echo "nothing is build by default"
> @@ -149,8 +151,9 @@ skiboot:
>
>  efi:
>         $(PYTHON) edk2-build.py --config edk2-build.config \
> -               --version-override "edk2-stable202302-for-qemu" \
> -               --release-date "03/01/2023"
> +               --version-override "$(EDK2_STABLE)-for-qemu" \
> +               --release-date "$(EDK2_DATE)" \
> +               --silent --no-logs
>         rm -f ../pc-bios/edk2-*.fd.bz2
>         bzip2 --verbose ../pc-bios/edk2-*.fd

Hi -- I've just noticed that we never made this change to
automate the date/version for EDK2 ROMs, but we also never
updated the version by hand. So at the moment we ship an
EDK2 blob that wrongly claims to be an older version.
See this bug report by a user:

https://gitlab.com/qemu-project/qemu/-/issues/2233

Is it possible to fix this for 9.0?

thanks
-- PMM

