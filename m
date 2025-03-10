Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A8C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfTM-0003hG-9O; Mon, 10 Mar 2025 11:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trfTK-0003gl-U0
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:55:18 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1trfTJ-0005tO-5C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:55:18 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso3756788276.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741622116; x=1742226916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/NSY+rUXY0q58M4sDKdo94Ve4cJf7H1/rBbzXCUQAs=;
 b=ImF0ttW68+GXh2YSoJY9FetJk0/QXkXJ5rJ2ELCPF8/+Bu8OZyrx7AMJLR0xt07MmH
 EuESnpX5iH24kgo7niR4U+YiprNZgaG9OD7oox3+NITD562wqvdMXd4baXsWZe61jylA
 Lq5dwt9zQkv0q/YAuh615rL+fJy5jBTOhdCjcowjoSnvgmsgJpwt8ADwxUFbjB0M1zhh
 wuveq4fsR+7xYYkLOc0qwf7FZK5C/uxtT/oKSz7shoXFWDBwF3zldBAtQVtMmgo9ogFC
 0hSUfD02TYOlhdDlBe0o6A2F+/ksceVILXu+eBebly5Qe1hYLKeuhgHpeutUr+w+dBCH
 Wljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741622116; x=1742226916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/NSY+rUXY0q58M4sDKdo94Ve4cJf7H1/rBbzXCUQAs=;
 b=adfFuyPqzkzKXbv6SBJ2oh9WJfljWoe49x4D5XAg/CrauaNmn2oZ1FK8VeTo7YUWoq
 +DgKst0M2JvNnAXUc+rIZPZRkqFo7ceXcK5tMKwb+HCH3jAtEtaQXkbkasUAtJtbEyf5
 oNdDIi9RYuZrRI/x8G7IaJO7JfEClZkGRzLLTmt+zgbt4YnQ31t+jB0J8q2799gOQMKP
 YwwFgXfT+4Ds/PVpwd0U+glFvQftBPrALOq1jx7y1V4cAfZUAE7lVODajg1KfALCFLS5
 xcnugjDGDR3fhT3U5Fl3I4d1DBT5RY1Iu1JFI0HWveeFeYB7BgyTeco/3N++C8znXPga
 Z63g==
X-Gm-Message-State: AOJu0YywIPX8P8/628iCm9eZVeGUDyg9boTHDuTyqmPM5EJNrDS09ASr
 kftTi18u51MMlvY7L5W2ZFdW6iN8s+wEDuPxSUZsBhtvw2wcwEcuGT4MiPucYqpn/kxVqGM6MAy
 A/vF4sxEtdQnnyPE5tSAk8WRPH3Tljtq1cGXOMg==
X-Gm-Gg: ASbGncu9ZTjlwHvd7DwwRJVrhezLudQijU97HzgLwSTCHOJdd74qNGGdyfRjsNAzdku
 1SCiX/FIxXkJd6IVwct4alJfp6n1cZQNvmF2VJdzq471wJERrUDXMBhw5Crlx3NxKPZycY1nqb9
 hi91NW6mO9QUTQQepk54QlTDuSgyE=
X-Google-Smtp-Source: AGHT+IF5J3E6A2IhFuYu+OzhMTpV2560KGpTznQSHAyO1a3MiGFlx4qSAASuYfw3+tpUJVaeLQA6VzGLdjLLvdFiahs=
X-Received: by 2002:a05:6902:228f:b0:e60:9b80:1f82 with SMTP id
 3f1490d57ef6-e635c101689mr18641583276.8.1741622115558; Mon, 10 Mar 2025
 08:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <f5ee7468950a4c3abbd3b05b7753d15c@ti.com>
In-Reply-To: <f5ee7468950a4c3abbd3b05b7753d15c@ti.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Mar 2025 15:55:03 +0000
X-Gm-Features: AQ5f1JrxTBIMLsRTdaTTTt9yEVXJ8kpRXYKOgdm27-Ts1Ii_NM2s-7cQ7HECQas
Message-ID: <CAFEAcA9taLRqGL+OT5NDMw68T8rJ7iargQsgRQi-=5jbDFBpzw@mail.gmail.com>
Subject: Re: [qemu-riscv] Error mapping file: Invalid argument
To: "Chu, Benson" <b-chu1@ti.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Mon, 10 Mar 2025 at 15:27, Chu, Benson <b-chu1@ti.com> wrote:
> I am working on a linker for the RISC-V target, and I was trying
> to use qemu-riscv32 to test my linker.

> However, I have noticed that qemu-riscv32 has some restrictions
> about how the program can be laid out in memory, and getting my
> linker to place the program in a way that qemu-riscv32 will
> accept is very annoying.
>
> By my understanding, for each segment to be loaded, offset into
> the ELF file must match the offset into a target page, which
> seems to be 4KiB.
>
> I noticed that GNU ld and LLVM=E2=80=99s lld both follow this placement
> by default. Is there some ABI that=E2=80=99s being conformed to for this?
> Is there any documentation describing why placement needs to be
> done this way?

I think that is part of the standard SysV ELF ABI, usually
described as the p_offset and p_vaddr having to be
"congruent modulo the page size". The underlying reason is
that you want to be able to mmap() the pages of the executable
file directly into RAM and have them be at the right alignment
and offset.

thanks
-- PMM

