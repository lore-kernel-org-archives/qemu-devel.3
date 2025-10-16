Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD5CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9NWM-0005z8-0h; Thu, 16 Oct 2025 08:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9NW9-0005y4-LS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:55:42 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9NW3-0004lj-5Y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:55:39 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63d8788b18dso709444d50.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760619329; x=1761224129; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xBEIvCyk3GZj0eOmWoMJSX+FFguE1PmIGXCb9NyO1E=;
 b=ZByewBKh5ujVkwFkjVMO4wQ8UGAzAJnHv8+aJW1CBdAj4QVINRYqZPAcb5JtUam89l
 vDOIHnqg81A8DVOYEjMlvyr4puloPsupmoKDCQMCHZ3qUwr64TOFelCBJnKwPXlyCClA
 WacT4qILbnBJXZAwGWalIsHnGnafVleM0FIeM+DdOyXcMZtVFUz3Dn9w+GmQezvAtgxn
 aWJcujJrcI7XPLbZ7VXYWHuCJrtdh3F8JFcYkz24c9fFSiA3sx+POM/QmxDWzlC1xu3v
 p+/lu9Y5p7gQXh0U0YbhDPfSAMMUTA6fuJk5VHq6vcMttgoBxn6EJN4jAnmiAdZOxi/g
 YtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760619329; x=1761224129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xBEIvCyk3GZj0eOmWoMJSX+FFguE1PmIGXCb9NyO1E=;
 b=RDNFo3D7IBw6yQa0u7WAsk54yxlzR9+gpCBo2gU+J95ADAwzfAMjBvRI0l/K9JvMlU
 +G0iveEpdF70f/PxQOMm0V6lp3LhtphupjboQGO3h11D7GE6T0B1YcRbsVzx4LjTUxNg
 2HJxQ4ytNqVwEApoHbnF8mES0i/Psa0DI3Rt6kOUm1MO42VUTr3OfHWmLNv5MsFMxhD/
 P8o82aITfDxw2wq+IYKTiW5x7E3Pwma+Dp+6MZop/yoqS3k1361U5vp60o6pmJUgTVjc
 SsJkdQ3uMiYGku+4BATwL8T5GmfTAlCRK7n4Ld3Kby5p1DcHH4GF+1R9yY9i23FU4en5
 /FfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2NFutDq7rrAe0wcBxuMzu4QOx5HSzVeVQFF2OT7vHPbSwt2lcOr3p8uArRYHvNpGHCHz8LRi5Fo1G@nongnu.org
X-Gm-Message-State: AOJu0YzAoQko6eD9AjpQJXCbYa9SFW7YGFT1WDUp97wcrfAjzHBTOrSj
 JwNgAKbnr6H70T9kIe3ZLBQm2eEGZGxbXybKBNvVyUC7fHexX9k2TO0G0JYzaIP2COHGcca1OLr
 42NmsGbBUlkG3BGrNUCEBfXDGrXiyG/eWuqPLPcVbqA==
X-Gm-Gg: ASbGncsiJMbIKP71EX84EF0HDNA9b1lVcOyqYKzltYP+8R8mnY37meIxwtazEUtw/Vs
 35ilZYAbf3TI5T//nbChH78FL7KrDXLPYyzHDYw7R6aCjbuZDir3IjW42EyqMPRpI2Iv7ZrR+6L
 MwMN8+Kh9sWB7AdfaNefQDfue1KD6wvCBH29MD4MjoyOS4BXoLPiAUGJTy50k8Y0fr/Os/oDHcD
 RCkgIQn7kBRQML6nto71QPHoTZJakc005xldKuHTBnUoDyP67Ben7axXYTieb3MLGn2/qDn6edD
X-Google-Smtp-Source: AGHT+IGILGAZwiQFmfDHPPBc+wVrwQtzcSf6MYr+ABTZ8O80om9ar1ewipD0TNJ3G8+uroIvte/GwqHZwjIKvGrpyh4=
X-Received: by 2002:a53:acd8:0:10b0:633:ac51:9823 with SMTP id
 956f58d0204a3-63e160e3c31mr126093d50.2.1760619328940; Thu, 16 Oct 2025
 05:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <298bd904-1ee9-439e-8220-7a24e0952861@siemens.com>
In-Reply-To: <298bd904-1ee9-439e-8220-7a24e0952861@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 13:55:16 +0100
X-Gm-Features: AS18NWD4aOByI_dh-CHmKvrnJ2m8cYBva9DR-XDlxjKClGdkyJK5GkhUf2LjEaA
Message-ID: <CAFEAcA-hHR7GB1QFevx5AhKzvLJecAQbD=Kyw6+RtOgXNdrkmg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/openrisc/openrisc_sim: Avoid buffer overflow build
 error
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 16 Oct 2025 at 13:48, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Resolves this build breakage (which is actually a false-positive)
>
> ../hw/openrisc/openrisc_sim.c: In function =E2=80=98openrisc_sim_init=E2=
=80=99:
> ../hw/openrisc/openrisc_sim.c:284:45: error: =E2=80=98__builtin___snprint=
f_chk=E2=80=99 output may be truncated before the last format character [-W=
error=3Dformat-truncation=3D]
>      snprintf(alias, sizeof(alias), "serial%d", uart_idx);
>                                              ^
> In file included from /usr/include/stdio.h:964:0,
>                  from /data/qemu/include/qemu/osdep.h:114,
>                  from ../hw/openrisc/openrisc_sim.c:21:
> /usr/include/bits/stdio2.h:54:10: note: =E2=80=98__builtin___snprintf_chk=
=E2=80=99 output between 8 and 9 bytes into a destination of size 8
>    return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __glibc_objsize (__s), __fmt,
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         __va_arg_pack ());
>         ~~~~~~~~~~~~~~~~~
>
> by using a modern, more robust allocation pattern.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

