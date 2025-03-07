Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49238C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqY79-0003G5-KS; Fri, 07 Mar 2025 08:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqY71-0003F9-Da
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:51:40 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqY6z-0001Az-Rm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 08:51:39 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e60b81c29c5so2765325276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741355496; x=1741960296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eD5w6l4c5lpj/4HmBagOipDldkIESHyYYMywjYDaQgs=;
 b=b6uXGnv6qCmliwf6iK7xhj+WzYUiSOyXWIHBAjNhCJeT2W5TSKW6VbGLGJXOgjL6bu
 OOIEqqfph44cCKQ5stnL8L8Y9u0fKkpnyCJcQ1wrqOwno+AoYFIrKHGPvx4IZdeeKBz2
 fm5sqWJUklITzxchnRn+46aOLzCajE3MfhOru/yXoJjFli1TPEXjak7OwQYnQQJIjTNV
 D1EsKj4TICS7X4J3tEWxoZ2C1vJqGJO+cFcgiwo3sorn6O9Bew/6dr4hinOdN0FHhjEY
 kjFjFbI005CpSvmMjkUp3JdPBj9JM0YGHJW8F/wM6Mx9aK8JRhmEwRl6JO+fD5N++UjC
 qyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355496; x=1741960296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eD5w6l4c5lpj/4HmBagOipDldkIESHyYYMywjYDaQgs=;
 b=nw9pLNYnj+QFQDUTTZ7n9kUwgxoCbaZljn+ZbOt1dXNoZoG13RFxU/ef4hMPf0UsGD
 2FPBXHSUZ8VipJMLvbp+r6nqfrUOfV/QYnymQA4f1OKholtTaAmp9f/Nhk1FSCz6NPqU
 m1sRkHDszoVFSAKIJ42Qc4+bJiaCWqA2KhtUWx15r/4ln0KUN7ij/dF2HPgBts0tY8g/
 XVaxabmj37PwJo+peakkPtRjxdwp0qtd6KUukfLERarbNPgp+8PmlH+xLHYWGvIwZNXu
 uSzEblmi5EgWHYoRqljQDANClEQxeUCL+iORV1ls0X/jPJtBiT6UtHQVd9TvnFbWzRcu
 DwcA==
X-Gm-Message-State: AOJu0YxN7hloRkyo5eIntwRAFOC/6Zv5zOs36YKtUhJqYFd46cd16klf
 bCXzT/gJZ1qI7s1kvHoneTkrMmzQhSxKc5Yoxc8hBXM/xNObnFph22ZC36R2ACYcwHGR6uDMiou
 cMXuGU2kABbHx6z9l2vQ2+jARIBIEzghfyYa1/ut/0f7qZtag
X-Gm-Gg: ASbGnctV/zkSnG7jV6HxgmMD4C2EDHrX0rwZ4HlGKOYExuiobeX+O5h9ypqWhTjc6Sc
 JeHzSOi5Nw6eSz5f8RY41qR8vl4EW2fnFo7ocmTzL8L8VWNsZr0/fQxlNXhsA6ysdZPFv947Ufm
 WyvRIHwpFwFeFPs/NTGHUTrvzkt5k=
X-Google-Smtp-Source: AGHT+IGjVI8005UQ8S8GIA6kOaUEwys0DCsuFneQbd72lBN8y3PZ5WrYamKl1NeBBIEKWmYJYy3j1wET4DN0y5fd3Og=
X-Received: by 2002:a05:6902:2007:b0:e60:915b:188 with SMTP id
 3f1490d57ef6-e6347b8a6d5mr9496357276.18.1741355496131; Fri, 07 Mar 2025
 05:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
In-Reply-To: <20250218212103.2024039-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 13:51:24 +0000
X-Gm-Features: AQ5f1JoxPgPk7xUupPX5zxj8ygVC2kU-QcCdq7GihYsjVKgSRt-mekUFi1Za6-k
Message-ID: <CAFEAcA8xiFx9n=FMG-mbwMBQpGvxVcDFafZDn6ohHNVwt9-f+w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Renesas RX target fixes (v2)
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Tue, 18 Feb 2025 at 21:22, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> With feedback from Peter Maydell and Richard Henderson, I've updated
> this series to address two concerns:
>
>  1. The hardware model is now responsible for guiding the CPU reset
>     process.
>
>  2. Loading the reset vector from memory is now delayed until cpu_reset
>     is finished to ensure memory_dispatch is initialized.
>
> First, there are two critical flaws in the emulation. These are
> needed for this model to work correctly:
>
>  1. The exception vector base is 0xffffff80 not 0xffffffc0. This
>     prevents exceptions from working at all.
>
>  2. Many tcg helpers inappropriately used TCG_CALL_NO_WG even though
>     they modified virtual registers stored in global memory. This
>     causes these operations to fail unless one-insn-per-tb was enabled.
>
> The third patch changes how the cpu is reset so that it is driven by
> the hw code instead of the target code. Now the cpu is reset each time
> qemu is reset and the initial PC value is either set from the loaded
> kernel or from the reset vector. This should look a lot more like how
> other models manage this process.
>
> The final patch adds the ability to load an ELF file rather than
> a binary memory image. It's purely a new feature and not required for
> this model to be usable; without this, it's fairly easy to use
> the loader device; that just requires the loaded image to include the
> exception vectors with the correct reset vector value.
>
> Keith Packard (4):
>   target/rx: Set exception vector base to 0xffffff80
>   target/rx: Remove TCG_CALL_NO_WG from helpers which write env
>   hw/rx: Reset the CPU at qemu reset time
>   rx: Support loading of ELF files too

Apologies for having taken nearly a month to get to this series.
I had review comments on patches 3 and 4, but patches 1 and 2
are good to go and so I've taken them inte target-arm.next.

-- PMM

