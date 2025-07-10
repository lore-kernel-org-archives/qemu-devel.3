Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D802FC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpa7-0008LN-PO; Thu, 10 Jul 2025 07:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpa0-0007MH-Gg
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:36:44 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpZm-0006S0-LK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:36:42 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8600c87293so617443276.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752147388; x=1752752188; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qzbciKx2o4pSpRKiGFVWhMcg7GWpf3ibvN0tChYL/+g=;
 b=gmxfgf/UVd9pAZSIFEwKatbhGhcXRVIX+O2oFk40t0cEb5B11cHfFwub8AcE+OYur3
 rdqudgpQmNG3fD7QuHUnoF6DvGsnKUiipd9VvXdXmNt/V7wUn2mJrS5RYIE9trGJHCko
 fBsjbL2jmvG9lrHELH7Tjs3F/Opwg84dNNjCLmfN5fVpMNY9ZOo54PGOhr0ouiqz42KH
 pcr72qzk1+53+tsFMov/J6mhyB1EfmHBc9QiIKKfFDxnbJ1mEStNUulimoi5O+KHvjKA
 yHgokoOc+QebyYZhnN5hv5x7JnZr5ELb/kRwTfK3ExWAvwVJnHb1W5v94SGtUttNNipX
 JqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752147388; x=1752752188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzbciKx2o4pSpRKiGFVWhMcg7GWpf3ibvN0tChYL/+g=;
 b=BGeqvoYI1vvgrMrgOZHOmPUO14HGUNjGy+hxhdwM3cfqEYaVv11YTaeB4f+Wfp2QPe
 XacQGPhOdPVQdmNKglHzcm1Xsg/Th5fDvQJyRBFs/26DGzyOwLGsAdDr6dJwxOaPaL5Y
 kRhwNORPRIYTsDvi0JUKeLnbi+vqexB7FjJ55sESkluKrQKuxIOufGZgMWa80Ija4hIW
 4mzspvgGPRvEG1M52tAwaKqrrSWTZE3RLYKgjfiu5uqL9Hu3VnDfH6HRtoOMSx1xs1LM
 W/W8R1/RaB4CNzqFcIm8Wu8dQBKw7Is0kGpW+xSdasqSHzIKzWpNM5YzpffjrFcdDDEl
 hcAg==
X-Gm-Message-State: AOJu0YwL3KM9BHL/6NkN9cE3d432A2zK2P2xj10kNmct5R/VlIM6L+0k
 YIMzpTei9tnRzonBICAmx1jzwNt/2zeeQOsRHkLkAy0a7g7RgK00tUdZtiVVks4aMCKlxkKbrK/
 LUn30f7BpTp30ENVzdWz89xW8OGpcOg7L7ajUCjAjAu7gRL6NYS6k
X-Gm-Gg: ASbGncsIMXrdjAO8KW2HjhT0DOMYeU6hDU7DPHB0+RBJHBsDWpfwfumzzbjugoGmCi3
 GlyWQMJqbvdr8gLEMYXWW5FAnSeuA57TJBWEzjILNlMlIYq/ZyrpicYQGaGIdWZ52YYvrefghVm
 ZeNb8WSDUI6FLvLEpL7FAksbVwFXl13WMxuPc+gm8nwwsm
X-Google-Smtp-Source: AGHT+IEgrqvbP9cFXTn+ZVm7vVqci8geJatcY37crpJc+968FoSbAwLktjruTVDDFFAkkg7vuT2LvrVD1mVb8y6x7gk=
X-Received: by 2002:a05:690c:fcf:b0:70f:6ec6:62b3 with SMTP id
 00721157ae682-717b19e2c1cmr98387247b3.26.1752147387690; Thu, 10 Jul 2025
 04:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250710113123.1109461-1-peter.maydell@linaro.org>
In-Reply-To: <20250710113123.1109461-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 12:36:15 +0100
X-Gm-Features: Ac12FXzRxlaZgiHwZ-tLAOQm1jzGpN0qZeZbrigulrmJLAiyxwe0VJYX5jeIIkY
Message-ID: <CAFEAcA9zJAeYbtQkWC8Za0DGEukdKAcZpnM6vPiAQ358Ue_k6g@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Implement fchmodat2 syscall
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 10 Jul 2025 at 12:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The fchmodat2 syscall is new from Linux 6.6; it is like the
> existing fchmodat syscall except that it takes a flags parameter.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: don't bother with trying to fall back to libc fchmodat();
> add missing braces for if()

I forgot to put 'v2' in the subject, but this is indeed version 2 :-)

> ---
>  linux-user/syscall.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index fc37028597c..e1b1476936c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -790,6 +790,10 @@ safe_syscall6(ssize_t, copy_file_range, int, infd, loff_t *, pinoff,
>                int, outfd, loff_t *, poutoff, size_t, length,
>                unsigned int, flags)
>  #endif
> +#if defined(TARGET_NR_fchmodat2) && defined(__NR_fchmodat2)
> +safe_syscall4(int, fchmodat2, int, dfd, const char *, filename,
> +              unsigned short, mode, unsigned int, flags)
> +#endif
>
>  /* We do ioctl like this rather than via safe_syscall3 to preserve the
>   * "third argument might be integer or pointer or not present" behaviour of
> @@ -10713,6 +10717,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>          ret = get_errno(fchmodat(arg1, p, arg3, 0));
>          unlock_user(p, arg2, 0);
>          return ret;
> +#endif
> +#if defined(TARGET_NR_fchmodat2) && defined(__NR_fchmodat2)
> +    case TARGET_NR_fchmodat2:
> +        if (!(p = lock_user_string(arg2))) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret = get_errno(safe_fchmodat2(arg1, p, arg3, arg4));
> +        unlock_user(p, arg2, 0);
> +        return ret;
>  #endif
>      case TARGET_NR_getpriority:
>          /* Note that negative values are valid for getpriority, so we must
> --
> 2.43.0
>

