Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A6D16274
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Lp7-0008RE-Im; Mon, 14 Oct 2024 10:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Lp6-0008QE-5t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:13:24 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Lp3-0008Vc-EO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:13:23 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb443746b8so9084531fa.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728915199; x=1729519999; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xXmSgTGYgRf5Dym0uGpx9/sxLBe/1RPz2vmziLfPS10=;
 b=lrFA262L8AX/ByerTH274zhBLmyZgXi9QChjbmVoAqxorkKulz6Zog00EFbwVuyjUG
 m5Ys4GnwAknKNF4PS3ehvPiHg1HHBcXUuAl+brxqOVYVOIy9+rtFtntRFCWJSpZW3bj5
 CAU5XPfO0CR/E6bQ2jkDsFf7wVhvV7SBS90mNIeYCrfe4nVTkK7ypVut7Jy9rwGZjulw
 JKgj7VHQ3LwWnjyutZloit3VwLsTTHElrmSyzVemJGJMiuwd3eTe5Okfi6x1AzSsPaan
 oq+GYFIC5zHCWW1zX/0HTjwtQiBinjHidvTpbjOldeEQ2Hz35CmEwnF00baafi+hCMPt
 FNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728915199; x=1729519999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXmSgTGYgRf5Dym0uGpx9/sxLBe/1RPz2vmziLfPS10=;
 b=ERD4KwDFBHEepA9UVXO4/zy5nQ+6bd3Z/C+QrKM7h95w6ETF9aHKZQPOzu+K25F7oV
 /48IPxRKCapsy8okAsROeW1H86ziE3Hj5mLkhu9TPxampofmb+wNi77zroGyGGfwK2zY
 mIg15q1JhKdbSKlzdP85CL/ZnYSaBkVNmunrRbeSB9sApbFqxURehcT5mlz/CEOCWe7A
 hFUemkEFkrFAaMUEiXxbpdGZwUSRxOvpW+Tck80iknDABqEuxbAUO2emwHEoS/MSvI4p
 G5ZxXCZ7igmLJCxlAST3nlExQBqmdG0X5Vz0A+LACopRjov7eU6oKYGF5/yMcdEwRYAN
 lpJg==
X-Gm-Message-State: AOJu0YxR6CNllJA4n+SbdiqbPaS/g+p11clAZh+xvDnZIIevXg4AwlJ5
 54vCZGJD0GsJRQl/hiUijfTjBUHWWNNLIszaAamenS+8QBlZfKiyPSyPw/GKTV24I6FtEvkWWD0
 glMVaEn4cpuktE7Vw8lMctLgHXQf2VjXNnUR7V48lZ09To2ut
X-Google-Smtp-Source: AGHT+IGco2HCQDdGKJrhH0APnZ7bTJ5uzeSAEcXCTmh/6rmx43ikfgQRekCRHuGV+0njZu3iYaBQv5ZzGr3P6PnGCxM=
X-Received: by 2002:a05:651c:198d:b0:2fa:e658:27a1 with SMTP id
 38308e7fff4ca-2fb326f6a0cmr45977531fa.5.1728915199328; Mon, 14 Oct 2024
 07:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728232526.git.balaton@eik.bme.hu>
 <59dd3361ca8ede93122e87752c7d66a304b05c0f.1728232526.git.balaton@eik.bme.hu>
In-Reply-To: <59dd3361ca8ede93122e87752c7d66a304b05c0f.1728232526.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 15:13:07 +0100
Message-ID: <CAFEAcA9sbAdDufXC1kVfHHcEg=DAHgB2dTSi2u4snppGG=KajA@mail.gmail.com>
Subject: Re: [PATCH 1/2] log: Add separate debug option for logging invalid
 memory accesses
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Sun, 6 Oct 2024 at 17:50, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Currently -d guest_errors enables logging of different invalid actions
> by the guest such as misusing hardware, accessing missing features or
> invalid memory areas. The memory access logging can be quite verbose
> which obscures the other messages enabled by this debug switch so
> separate it by adding a new -d memaccess option to make it possible to
> control it independently of other guest error logs.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  include/qemu/log.h | 1 +
>  system/memory.c    | 6 +++---
>  system/physmem.c   | 2 +-
>  util/log.c         | 2 ++
>  4 files changed, 7 insertions(+), 4 deletions(-)

It seems reasonable to me to separate out "log invalid
memory accesses", yes.

> diff --git a/util/log.c b/util/log.c
> index 6219819855..1aa7396277 100644
> --- a/util/log.c
> +++ b/util/log.c
> @@ -503,6 +503,8 @@ const QEMULogItem qemu_log_items[] = {
>        "open a separate log file per thread; filename must contain '%d'" },
>      { CPU_LOG_TB_VPU, "vpu",
>        "include VPU registers in the 'cpu' logging" },
> +    { LOG_MEM_ACCESS, "memaccess",
> +      "log invalid memory accesses" },
>      { 0, NULL, NULL },

As a naming thing, these are logging specifically invalid
memory accesses, not all accesses, so we should have
both the user-facing name and the LOG_ constant be
named appropriately. Perhaps
  LOG_INV_MEM_ACCESS, "invalid_mem_accesses" ?

thanks
-- PMM

