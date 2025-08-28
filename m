Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADFFCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgGc-00040W-Do; Thu, 28 Aug 2025 13:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureH4-0006AF-Mv
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:10:51 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureH0-0005Kj-Cp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:10:49 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71d603a269cso7685787b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756393843; x=1756998643; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sQK3mnn7pBQpcDfw0AGuQzsNWoTfZhgB1Skf8gC6LqY=;
 b=G9QbSx9I23HcbODDXqTwAYd1eCEdnFilTMNMPo10l+8/eTKXNf/nCey3sxl3geDcux
 IRlJN/p7/uRXodQg8cdQkvjwkU5pr0EwicNh2I/zxirmLcaAt7X3fdmcOeewceo5wKtO
 HmirldxAi6TvbSHUNa9ElvoaFM8o5ciiSOiJNAhM+bKOZke7G04w7yYne2nU25qVk95d
 LsY9a3YtKH7RdcKzj81DVSITSlVLLFS2CqbxU1XyYeAHnyHrtw7JBGO3SLvRBsoa/YEj
 oYzFP+HxVvsifke7uk9itXuCb52i0S86ZzD6uMhZTssoPk95/hCQ9Fs2Q3KNFVnVhkSr
 YkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393843; x=1756998643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sQK3mnn7pBQpcDfw0AGuQzsNWoTfZhgB1Skf8gC6LqY=;
 b=ATBIixmM3t+vTbwfC0hWJDk00ZpPn/1ctwKXTP/hqUAn5Yb3PDFFCIds1BpORG54A+
 tb/JNCLzLBlMYK8IPRF2fXjodcW4QWNKyCIl7DASxziJtjQ7ylLRwa33jNInU3AFmXFf
 m+Oudrl3+sw806fcflQILcyzA2xhIHJMLZttTz0wzc+/wj2BfgW2GbfsgZYxr6W7+l9P
 ok3ck8xw3ms4J4afD03lhsL/lbEpMiuNj450p2z9OLkBHWfVR1osNHJ6iZjfEGmLvGDL
 L/gNVA2dV0w9tvEI7V+hUYHB9h5Wdmr7i/G/8IG+zOqQftYMVudt5ZYNy2qgfSa+ULyc
 E5fg==
X-Gm-Message-State: AOJu0Yzpdsp5MkF3qwjhLrtM6s+varD75rdxC+rwl1g9utbTXXDcdcA7
 ITaVeQZgijj7lhnkZAGvn5lLOHwEybIwbVt4VqPQCt0qCws6c1ymTJ7XiqVXU/g+xox7fAVKahN
 wczmUkoHAuXwh8S0aIBiEtqj9gVWn8syqpWTH36rQ0Q==
X-Gm-Gg: ASbGncte56aPjniae1Jlu5+4mtKVoyr7ajFYUi8d9H0pkUnTalh05/5oJgrKR/3Fr+M
 HgLMKNLxUG2xCj1Sku1uPuj66rX+70swsSHt9JeuPy95su9gIEN2wLqh2ChLBUsSd2bx2aBQhqu
 UdpzvWlUgiKveR1SVYy+58Q7Jgebe+pMJ4MHa0MsnI9xtLJxKRVIm2WG4ZApHMxgn2egy9V+U9I
 nGwoXai
X-Google-Smtp-Source: AGHT+IFbHZ5H1Vr8zLMpt/TRrIPn56pHYrNTpjtKROZeOvVxCxg2kkINo7Ec8zMvDXQ1eLgUGF/l/voI453Xw/7fcSw=
X-Received: by 2002:a05:690c:fcc:b0:720:b6a:ff2d with SMTP id
 00721157ae682-7200b6b83cfmr185210097b3.14.1756393842645; Thu, 28 Aug 2025
 08:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-52-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:10:31 +0100
X-Gm-Features: Ac12FXxGvuempjnClys839j3IA-GKMQlSo18KbmJ_oTeJOhzFnnjCOatAPwMBOY
Message-ID: <CAFEAcA8p_8nELWFhiO9GsSqq7q+7gMCYgBnKmH42ziLjTnXfMw@mail.gmail.com>
Subject: Re: [PATCH v3 51/87] linux-user/s390x: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 28 Aug 2025 at 13:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move target_psw_t to target_ptrace.h.
> Remove the target_pt_regs; add target_s390x_reg to target_ptrace.h,
> which matches what is actually used.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/s390x/target_ptrace.h  | 18 ++++++++++++++++++
>  linux-user/s390x/target_syscall.h | 22 ----------------------
>  linux-user/s390x/signal.c         |  1 +
>  3 files changed, 19 insertions(+), 22 deletions(-)
>  create mode 100644 linux-user/s390x/target_ptrace.h
>
> diff --git a/linux-user/s390x/target_ptrace.h b/linux-user/s390x/target_ptrace.h
> new file mode 100644
> index 0000000000..a5ceb75a74
> --- /dev/null
> +++ b/linux-user/s390x/target_ptrace.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef S390X_TARGET_PTRACE_H
> +#define S390X_TARGET_PTRACE_H
> +
> +typedef struct {
> +    abi_ulong mask;
> +    abi_ulong addr;
> +} target_psw_t;
> +
> +struct target_s390_regs {
> +    target_psw_t psw;
> +    abi_ulong gprs[16];
> +    abi_uint acrs[16];
> +    abi_ulong orig_gpr2;
> +};
> +
> +#endif /* S390X_TARGET_PTRACE_H */
> diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
> index 4018988a25..f01f9a0baa 100644
> --- a/linux-user/s390x/target_syscall.h
> +++ b/linux-user/s390x/target_syscall.h
> @@ -1,28 +1,6 @@
>  #ifndef S390X_TARGET_SYSCALL_H
>  #define S390X_TARGET_SYSCALL_H
>
> -/* this typedef defines how a Program Status Word looks like */
> -typedef struct {
> -    abi_ulong mask;
> -    abi_ulong addr;
> -} __attribute__ ((aligned(8))) target_psw_t;

You might mention in the commit message that abi_ulong
already has an aligned attribute which for s390 will be 8,
so it's OK to drop the attribute on the struct here.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

