Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46BDC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rneU3-0006vA-RX; Fri, 22 Mar 2024 08:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneU0-0006tH-PO
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:58:52 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneTz-0004XU-6m
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:58:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bc5a3aeb9so2697969a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711112329; x=1711717129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w9UPMwS8yPyJJafAwL1ptFG2gaG7sFAo9wR9goYDGWU=;
 b=mRRtgY0pN4i6YcHgkz8tGF/imC1IeF2AXjvRsLII8pr7jtWG6aoUCdhTLIZJSfuDLM
 NN2Xp87ilA7pZwEIYMvTUhVim1LeZD2Tm/afthGRKCJV2DwZ9h5qLN9avUxXyYqWEv+o
 hVWphpfJ6HP4U01GYuRdiptdUqtcgLthnLarUXzBk4PNAdwlFCCjbrBMuO7MhF3yJbr2
 HOHPBf1YZZxRhQrsyAaziDK6SiB7V4MNWQ3pFLi0oyMFq5ieNTAWYb6d5oY84bhuu5MG
 2GjpLOrFRzrciaA5hrx/jogAortYIWoHX0ZmV89lLZViZbQt5l13KCDmxE/OhUZGJmgQ
 Z3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711112329; x=1711717129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9UPMwS8yPyJJafAwL1ptFG2gaG7sFAo9wR9goYDGWU=;
 b=eTyyLpgBjXjmvR5MxN0DNARz73c/Ono5rjM3L89hxbImUQiF2Zj/A+VnQHf59qesKh
 f5bGnzBT8rQ0x1UblhAEMw+YBnucRG6jR3aWiZ70txsZhqNAjJL+WaDmyANEoC1GmkPF
 D4uWs2q3CAM8FOYFxTPbY6aapK96HBjMhZEsDbnUB/04cVOm4hmvNdq4K2Pb5rp5D901
 Au/Hb/MyfSo094cCes2mrQ6oS5BBNVhKu5tdkf2LU46vUJ60Hn6IHdu3ZdfBo0xTtCTJ
 ICu30fStc2AaZQr9V8lOG6+DLI+Kjwou5BuLQxyMcwD4JD/Ei3Xnv5GZYNj6A6sqimlJ
 fh/w==
X-Gm-Message-State: AOJu0YxYvE2Kw7iB9AeF872VKh3nnXzENVL1DSk2E5VZ5vXGJbC9m207
 7xGAAxf3ABPqpl/OlNBHgKDbF/iveFsAU/qew/JqlnKIwJ0GvfbaRPDIAWCi2MkA+ZDaFR3EutZ
 4jqGZCY4HWJpBlvIQ3cZUsfHtXuqK6YuGxFjZ/g==
X-Google-Smtp-Source: AGHT+IGpouGjtuuW3+3kx2fy2ZAv8gMrr0qhgLhYaEmekbZhWjaMxb7dVlwjW1Qag4tVTd041pPfc+h4Vo4Ytj/PJ6E=
X-Received: by 2002:aa7:c488:0:b0:56b:defb:3b59 with SMTP id
 m8-20020aa7c488000000b0056bdefb3b59mr1508397edq.19.1711112329074; Fri, 22 Mar
 2024 05:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
In-Reply-To: <20240322085319.1758843-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:58:38 +0000
Message-ID: <CAFEAcA-gg5r3DzHfz-W7oMUpdNHv2q19caikYU+80znnHvUzFQ@mail.gmail.com>
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 22 Mar 2024 at 09:01, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit fea445e8fe9acea4f775a832815ee22bdf2b0222:
>
>   Merge tag 'pull-maintainer-final-for-real-this-time-200324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-21 10:31:56 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240322
>
> for you to fetch changes up to 385e575cd5ab2436c123e4b7f8c9b383a64c0dbe:
>
>   target/riscv/kvm: fix timebase-frequency when using KVM acceleration (2024-03-22 15:41:01 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.0
>
> * Do not enable all named features by default
> * A range of Vector fixes
> * Update APLIC IDC after claiming iforce register
> * Remove the dependency of Zvfbfmin to Zfbfmin
> * Fix mode in riscv_tlb_fill
> * Fix timebase-frequency when using KVM acceleration
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

