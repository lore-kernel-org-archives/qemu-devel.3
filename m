Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1677C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFb8-0003NF-1G; Thu, 07 Mar 2024 10:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riFb6-0003MO-3s
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:23:52 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riFb1-0003fy-6X
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:23:51 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56682b85220so1417313a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709825025; x=1710429825; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4kNPQimB748iBTllE96491bYxjiS/h4X3C2D8CliT8A=;
 b=O2LGOk9zTbZBjHGU//Y6hG7V3AjzK3IIx6h++GnJTfQQeDzZCGybmMggn/79MvQAYA
 LmgcjiWH8gmVUxcRAWIvuM5yuU4R/w5j0MWHni2FmDVSD+pKm/rq5W4jEtEQeOCtoygb
 uvtZ6A6qry2tGU+k2K85pSgscSb1b8uPHMKb0qsRKF2Jxe8TooG4X5UuMhsUloQ60+Mx
 BNi6/nwo9jkYID5WKAo1HX1m2wMYuGeQKg4oP86JADk8bKYLSi37YGXY6Sli0Gm3LDK/
 KSYyelwvKkOZ5XkH8OqtHGkPjZA1EHdaSSsh3r/PCIAqQGMWypf2cd03lnL1PLzAyxSH
 XbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709825025; x=1710429825;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4kNPQimB748iBTllE96491bYxjiS/h4X3C2D8CliT8A=;
 b=AF8HIQkp1cBWIOLlcGa5CuWOwBm13kpujU2uDp/1obkzOD9E2hHCXWTZRn4uJSfcCc
 B+mlMB6BWTqpPO0/917S+B6f3IUZ8NbwrxEK+x2l1i5/h+Vhts5fuH92yfLfCqgR7+7e
 /3Wc1WnP2SF1UQWl118AwRxpEI4Z/kddRrh+USA3qPeAgErcCKPtqHpUhwwgI5+Yh4JU
 GJPl4deHdsoz69EYgRXVMzfhD/5TOgy68PtwSHt/EGayez8jEIOGTHKwYugZOrSAwFou
 R5L9bNQG5cs5M5lpZdeKizfHFtJSExQUqN2gAddkhBE2NQxYtJn2TGX9Za067Str9Y9X
 5j2Q==
X-Gm-Message-State: AOJu0YwWdfcGowiAiYoaJNFbKArd7CDkI8ew290zZbgffdnFpgX6X0mh
 OU2E0mbphMyO/S5mq+gj9OI1kUJt4lFW1gyZosFyJLtXQnhlbxW456HN6FW7FkAvuLuozQgkRvj
 CRU+vj+PF9qOMoQiZx9DEUul4fFPkMNW7hfGm1d5TW2GZh3qt
X-Google-Smtp-Source: AGHT+IHCaeFcWGxGgMM4SYDnp9nVDWzcAM/s4IicNV1flCGDx/eTwuBJgsMadE4CQqfhrPyK1by73Z4bC1cdyshCdnk=
X-Received: by 2002:a50:8d52:0:b0:568:1c64:277c with SMTP id
 t18-20020a508d52000000b005681c64277cmr92224edt.15.1709825024719; Thu, 07 Mar
 2024 07:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20240307145207.247913-1-gaosong@loongson.cn>
In-Reply-To: <20240307145207.247913-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 15:23:33 +0000
Message-ID: <CAFEAcA9g7yTRYLp3xE6p-Zh_RYpxn4MacbzRRi5UNFzKgP9QFw@mail.gmail.com>
Subject: Re: [PULL 00/17] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 7 Mar 2024 at 14:52, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240307
>
> for you to fetch changes up to 4dc2edfd6f8abfc38f0ba110502790aa5051b1b5:
>
>   hw/loongarch: Add cells missing from rtc node (2024-03-07 21:58:00 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240307
>
> ----------------------------------------------------------------
> Song Gao (17):
>       hw/loongarch: Move boot fucntions to boot.c
>       hw/loongarch: Add load initrd
>       hw/loongarch: Add slave cpu boot_code
>       hw/loongarch: Add init_cmdline
>       hw/loongarch: Init efi_system_table
>       hw/loongarch: Init efi_boot_memmap table
>       hw/loongarch: Init efi_initrd table
>       hw/loongarch: Init efi_fdt table
>       hw/loongarch: Fix fdt memory node wrong 'reg'
>       hw/loongarch: fdt adds cpu interrupt controller node
>       hw/loongarch: fdt adds Extend I/O Interrupt Controller
>       hw/loongarch: fdt adds pch_pic Controller
>       hw/loongarch: fdt adds pch_msi Controller
>       hw/loongarch: fdt adds pcie irq_map node
>       hw/loongarch: fdt remove unused irqchip node
>       hw/loongarch: Add cells missing from uart node
>       hw/loongarch: Add cells missing from rtc node

Hi; this failed to build on openbsd:

In file included from ../src/target/loongarch/cpu.c:109:
In file included from
/home/qemu/qemu-test.JIZtaO/src/include/hw/loongarch/virt.h:16:
/home/qemu/qemu-test.JIZtaO/src/include/hw/loongarch/boot.h:69:14:
error: expected member name or ';' after declaration specifiers
    uint64_t stderr;
    ~~~~~~~~ ^
/usr/include/stdio.h:199:17: note: expanded from macro 'stderr'
#define stderr  (&__sF[2])
                 ^
In file included from ../src/target/loongarch/cpu.c:109:
In file included from
/home/qemu/qemu-test.JIZtaO/src/include/hw/loongarch/virt.h:16:
/home/qemu/qemu-test.JIZtaO/src/include/hw/loongarch/boot.h:69:14:
error: expected ')'
/usr/include/stdio.h:199:17: note: expanded from macro 'stderr'
#define stderr  (&__sF[2])
                 ^
/home/qemu/qemu-test.JIZtaO/src/include/hw/loongarch/boot.h:69:14:
note: to match this '('
/usr/include/stdio.h:199:16: note: expanded from macro 'stderr'
#define stderr  (&__sF[2])
                ^

You can't name a struct field "stderr" -- it can clash with how
the host OS chooses to implement its stdio.h.

thanks
-- PMM

