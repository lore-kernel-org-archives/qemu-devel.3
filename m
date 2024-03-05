Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D1AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUqg-0003Sg-18; Tue, 05 Mar 2024 08:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUqd-0003S7-St
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:28:47 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUqc-00017i-3F
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:28:47 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so10042998a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645324; x=1710250124; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Xe6exx90pvEc3LSbvhPAoz0w7ulU3MxN74Lo0j7dUc=;
 b=Wc4c6NSRzRxO7fmUvkCBcsb+Nwlw8V+Jjzgn027qIzLeqHnNaFfX6uw3XDj9PduNCr
 Ysts6DYs+VAUICln3lbce/gX6ymW0MpTPiB1SnbT+PjtAbuXKkJyxsoNv9L/FOJW7h/d
 Gdfq+YJn1f/bbmHhBgFTlIwGD+IHjgqc0wGQaD0r0B+IvixJLDy70L1nqG3SDY98b1V6
 7p8CdGfrRf1T5eEq3vGIfM//Xjy0lGYdAz7PKLvRbWGr5C+QWn+A4/ij+ZDFt42I+E1d
 Wmfc9d4NbkPEXBsyrTUZspSt3T5ioHyJg/MCJ9c9Is02oYPZFeq6/5JPYlSh98v+UzuY
 dmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645324; x=1710250124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Xe6exx90pvEc3LSbvhPAoz0w7ulU3MxN74Lo0j7dUc=;
 b=OEeQXx/sfRz8F/LwVcwbyd1tZVTKbn65i9Vd7/OTiL0oSlQoo085Di4NPdC2Rln/HB
 yYDo5Ozcv7b1yegvfx+rqtpDkfMpEKQJ4dn+sLnpoiKZhc06+objpQ4rdUuToXkV70Tm
 R7krESX2fRKV26b+OV2+35NJvJvEZi/eCO5bshw5lmsXn4XTfPQblhqsLfVCL9RpsfKx
 WcFAMoDlSFhUaKPIWkpVyfO97SJalAPyu5Tsz+GMm79d+vjx3lsKEJ0V281vQ9RDuFO6
 TrwE2D8XDe+jqrDm+MtGwlJn+hTF6jNX4mJ9+TnLGUcpxGTEU7QzAZCZ8Te0oqwpsH7s
 Qp4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVExAugy6iG1eb5QCr+Tv57bEwHDVVLxJZOT1pA66N+N2sjNq3RphuqqrjPoR29JDGddQXRTztrsGWgg1uVuzrdUTn6Ig8=
X-Gm-Message-State: AOJu0YwmfJe0NjSwn5trxuP/UygFRibAjgwJWOctry9Vee3bbN+Qn1ji
 zbn0mmS3X+FPIBrvWCHcFoatfi3A1lPk1IqbGGabD7auEbTfRIwrgKTS7LWIeMVjkit2x/FVB0R
 D6WO2nvNuEdCPGg0Zm1eXnU39JgEQdDZMf63kPA==
X-Google-Smtp-Source: AGHT+IGuPIMI/tDpVE7qppPA+DZTMRjehZc5eP1YB+u8rNMGbH21rGTnf8aeZa8tcZnQTEouDfMoeohgNea8yoh1JU0=
X-Received: by 2002:a50:c8cd:0:b0:566:fb8d:ed8f with SMTP id
 k13-20020a50c8cd000000b00566fb8ded8fmr2637643edh.14.1709645324371; Tue, 05
 Mar 2024 05:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-4-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-4-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:28:33 +0000
Message-ID: <CAFEAcA8HdgZuOf67yjAVZJ0e-ZazOShh=ji4W5CuFyfrRMqNCw@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] contrib/elf2dmp: Conform to the error reporting
 pattern
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> include/qapi/error.h says:
> > We recommend
> > * bool-valued functions return true on success / false on failure,
> > ...
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/addrspace.h |   6 +--
>  contrib/elf2dmp/download.h  |   2 +-
>  contrib/elf2dmp/pdb.h       |   2 +-
>  contrib/elf2dmp/qemu_elf.h  |   2 +-
>  contrib/elf2dmp/addrspace.c |  12 ++---
>  contrib/elf2dmp/download.c  |  10 ++--
>  contrib/elf2dmp/main.c      | 114 +++++++++++++++++++++-----------------------
>  contrib/elf2dmp/pdb.c       |  50 +++++++++----------
>  contrib/elf2dmp/qemu_elf.c  |  32 ++++++-------
>  9 files changed, 112 insertions(+), 118 deletions(-)

This is a bit big to review easily. Converting one function
(or a small set of closely related functions) at once would
make for an easier to review split.


> diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
> index 902dc04ffa5c..ec8d33ba1e4b 100644
> --- a/contrib/elf2dmp/download.c
> +++ b/contrib/elf2dmp/download.c
> @@ -9,14 +9,14 @@
>  #include <curl/curl.h>
>  #include "download.h"
>
> -int download_url(const char *name, const char *url)
> +bool download_url(const char *name, const char *url)
>  {
> -    int err = 1;
> +    bool success = false;
>      FILE *file;
>      CURL *curl = curl_easy_init();
>
>      if (!curl) {
> -        return 1;
> +        return success;

Why not just "return false" ? "return success" makes it look
like a success-path, not a failure-path.

>      }
>
>      file = fopen(name, "wb");
> @@ -33,11 +33,11 @@ int download_url(const char *name, const char *url)
>          unlink(name);
>          fclose(file);
>      } else {
> -        err = fclose(file);
> +        success = !fclose(file);
>      }
>
>  out_curl:
>      curl_easy_cleanup(curl);
>
> -    return err;
> +    return success;
>  }

> @@ -186,13 +186,13 @@ static void win_context_init_from_qemu_cpu_state(WinContext64 *ctx,
>   * Finds paging-structure hierarchy base,
>   * if previously set doesn't give access to kernel structures
>   */
> -static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
> +static bool fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>  {
>      /*
>       * Firstly, test previously set DTB.
>       */
>      if (va_space_resolve(vs, SharedUserData)) {
> -        return 0;
> +        return true;
>      }
>
>      /*
> @@ -206,7 +206,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
>              va_space_set_dtb(vs, s->cr[3]);
>              printf("DTB 0x%016"PRIx64" has been found from CPU #%zu"
>                      " as system task CR3\n", vs->dtb, i);
> -            return !(va_space_resolve(vs, SharedUserData));
> +            return !!(va_space_resolve(vs, SharedUserData));

If the function returns bool type, we don't need the !! idiom
to coerce the value to bool.

>          }
>      }
>

thanks
-- PMM

