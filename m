Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5633FE6FE4C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 13:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smvZR-0001tf-PI; Sat, 07 Sep 2024 09:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smvZQ-0001sB-Sw
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 09:33:44 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smvZP-0004J8-6P
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 09:33:44 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f3eabcd293so33439551fa.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725716020; x=1726320820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WKe16QE24W+UCLCHr9tZ5xCVWKX6T3uhPk6K6l7AHac=;
 b=s6SCeATnNwBZO9ZaNyqa1lGUOMndYY7USydocC4MaroYGb0ZXTr+8RcjAaKCq62HrM
 YvdJFe/yU8kvvbYq4JtI4epOVC9yZrcW8gBXBAhL5Uiz7tgWp5X4WnBeZA6UCcJdOeP/
 U2PCfi3HXUPNz6ocLft0na16NmNNXEnqe3knC138WfZb5Jy7bP8GiVoAqel+gosyfSiJ
 bZzxVcKT2cNZsMhFxIOcQuSZhK8guFfr+88oEDfH/fuciMmjEFZFYBzlZuRYTdy9FWK6
 ezKPeaEPkxfBI11ZBn62bI8eJt/Blz+gpbzhz+PGPwiN6VqkMzjyYIJxY12E2Hp7Lwti
 1CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725716020; x=1726320820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKe16QE24W+UCLCHr9tZ5xCVWKX6T3uhPk6K6l7AHac=;
 b=vzFJ8Il0B59u56PYQ9T3/YBD6RCtSBhOvdJxU31rcAkT/tG8KhaYjIT5yqdDRP+2w7
 5pnwEAfgQ/1HZGRCxTskf8ewcRcA8TNLq00MY9jhM9YmMUy9/lGNb1ZsW3FqeiiWhnMV
 ZBA0pQdGLu0JJIrfezj4/8j4HP8EwfxbXv0Pb4mPbuDoQYYYPt1pO0CnY05OTK7cTGji
 OyOrQ2kKjod/IG9NgXUUWFre/nC/7LXUGiYY8VW4jYvWKiU2REXGokggDvHPvsaSYY26
 0A29pWxW7zdnPYPBXrEBrJYBjSY4n9QfUHomyakuiXTu1G2iPG5xvewkArGuqtMsO7nx
 Lxcw==
X-Gm-Message-State: AOJu0YxPJ4/tftNoXCcc2Y7syhKAhCIriG/FgZ4jEK/8iz4OEXBeeOn+
 bfOjp1gRlt/wRN0boz8w9gj6HLam0zpRKw4OnQDtkC2IDdL/zmCwA1OSVJOsZKRd5IkSGi4BA/W
 C4/tNYj4MCf57IfPKEQTXko3/ESnzCjQjQ8NEUw==
X-Google-Smtp-Source: AGHT+IFXJpiPAgjji3s8tPLsqTrW3KRo8MJMMfV2PoWAwTmMzJRJnegMex7+dEy0rhpOqKYuTuCsH+FolWU1kyUTjaI=
X-Received: by 2002:a05:651c:20c:b0:2f3:ee44:c6de with SMTP id
 38308e7fff4ca-2f751f2b7ebmr33913441fa.27.1725716019639; Sat, 07 Sep 2024
 06:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240907065918.376217-1-mjt@tls.msk.ru>
In-Reply-To: <20240907065918.376217-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Sep 2024 14:33:28 +0100
Message-ID: <CAFEAcA9b=du71rY9dA3VpJwbxiv2rYuvyuBmmKAJCetFvhhf+Q@mail.gmail.com>
Subject: Re: [PATCH trivial] linux-user/syscall.c: replace function pointer
 with a helper macro for fcntl/flock case
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Sat, 7 Sept 2024 at 08:00, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> There's a slight difference in fcntl locking handling on arm and others:
> arm has 2 variants of struct flock argument handling, with and without eabi.
> For this reason, we currently take address of the conversion function into
> a variable, and for arm without eabi case, assign a different conversion
> function to this pointer.  All functions are declared as inline, - and for
> an inline function, it is not clear how one can have an address of it at
> all.

There's no problem with this. "inline" is just a hint to the compiler
to say "this is probably better inlined where you can". For the case
where we take the address of a function, that's a case where it can't
be inlined. But other places where the function is called directly can be
inlined without problems. For functions where are only ever used via
function pointers, the "inline" annotation is a bit pointless and we could
remove it; arguably for other cases we could also remove it and let
the compiler make the call about inline vs not. As it happens the kernel
is not inclined to inline these functions even if we ask for it, probably
because they're too big for that to be a good idea.

> Instead of using a function pointer, use a macro, defined differently for
> arm (with arithmetic if based on eabi presence) and for all other targets
> (using regular argument conversion function directly).
>
> While at it, replace tabs with spaces in nearby code.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  linux-user/syscall.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d418e2864a..786623d395 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6880,9 +6880,6 @@ static inline abi_long copy_to_user_flock(abi_ulong target_flock_addr,
>      return 0;
>  }
>
> -typedef abi_long from_flock64_fn(struct flock *fl, abi_ulong target_addr);
> -typedef abi_long to_flock64_fn(abi_ulong target_addr, const struct flock *fl);
> -
>  #if defined(TARGET_ARM) && TARGET_ABI_BITS == 32
>  struct target_oabi_flock64 {
>      abi_short l_type;
> @@ -12402,14 +12399,19 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>      {
>          int cmd;
>          struct flock fl;
> -        from_flock64_fn *copyfrom = copy_from_user_flock64;
> -        to_flock64_fn *copyto = copy_to_user_flock64;
>
>  #ifdef TARGET_ARM
> -        if (!cpu_env->eabi) {
> -            copyfrom = copy_from_user_oabi_flock64;
> -            copyto = copy_to_user_oabi_flock64;
> -        }
> +# define copyfrom(fl, arg) \
> +           (cpu_env->eabi ? \
> +             copy_from_user_flock64(fl, arg) : \
> +             copy_from_user_oabi_flock64(fl, arg))
> +# define copyto(arg, fl) \
> +           (cpu_env->eabi ? \
> +             copy_to_user_flock64(arg, fl) : \
> +             copy_to_user_oabi_flock64(arg, fl))
> +#else
> +# define copyfrom copy_from_user_flock64
> +# define copyto copy_to_user_flock64
>  #endif

This seems to me to be less readable than the current code.
Unless there's a specific performance issue with what we have
(which seems unlikely for flock), I would prefer not to
macroify things like this.

Looking at the generated code, for the non-arm cases the
compiler is smart enough to turn the call into a direct
call to copy_from_user_flock64 already.

>          cmd = target_to_host_fcntl_cmd(arg2);
> @@ -12427,7 +12429,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>              if (ret == 0) {
>                  ret = copyto(arg3, &fl);
>              }
> -           break;
> +            break;
>
>          case TARGET_F_SETLK64:
>          case TARGET_F_SETLKW64:
> @@ -12436,10 +12438,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>                  break;
>              }
>              ret = get_errno(safe_fcntl(arg1, cmd, &fl));
> -           break;
> +            break;
>          default:
>              ret = do_fcntl(arg1, arg2, arg3);
>              break;
> +#undef copyfrom
> +#undef copyto
>          }
>          return ret;
>      }

thanks
-- PMM

