Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C0C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgOc-0005Xd-Eb; Mon, 23 Jun 2025 08:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgOS-0005XA-Lt
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:35:26 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgOO-0003G7-J7
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:35:23 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-708d90aa8f9so39253277b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750682117; x=1751286917; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u2mmfFNl/UQ68NaMBWRz9gwPfiOmuFf9IQYOYvc6hmQ=;
 b=OUAz3Me8EiSTkine16MsMBs4f77+MIZr6EQA4Pg7rB6msWW4UJmUmdCb9EY5mRB20C
 V53CJN3vzPuojv9ncXynb5Iw1/ZxOFJhmY6wtDgDpWwztbNfkZ6Ifqog0ks0GDhtojRf
 NWFm1cccoKSUXLhmMGGUFhDu6xZTIqj+rhBwZY4cON+HBVOx6wJa1ktleYean+JP3yA8
 /MXkwPCjii5asoMr5rJeiKkCQoEK49oLLybVyD6V02/hJIscni6wL/mq62J2ikuPetJm
 yJhIprArI16cwwRjIPlOt3guEGQCp1p13+M1p2wJEugUgdyZzApfthY3YB9j57SPi4Rx
 Nkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750682117; x=1751286917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u2mmfFNl/UQ68NaMBWRz9gwPfiOmuFf9IQYOYvc6hmQ=;
 b=g22uuAH+pdV6v21VYAKezbEu8r1AAHOW8Zc9OoVhtoIVjQbjsDESxLELB3FmCtw0ne
 GSs/D+KiS8RA94yZd7KDRSSPlspnz2z6Wg7EH5UFgCSOdQNTXWd7uYZxNPy7wgn+MxAw
 hJ4mFsnh3bSa3Xi1b5MZ86cFWUJ6ss4ZKjpYUOuIpMOOragZVeQ10uUpUsCBgZ0h3ATv
 T3nkFBL9jDy1+5YvaVWnIwLXY48iC1CVwatNxz5qsJxFsBf51OfWR0YA2dyUzg84H16e
 NsarnuY/4TDO42J0ATVimWq5mqfM1qT4FUva2z4LMjI5ZXjXk4KzgnMxVPmz62z52IiT
 pxpA==
X-Gm-Message-State: AOJu0YzwdvDKqJbVKHnQnt8PXE4Ekb7xaYpXaoiTgt0yKswlzLp9zqng
 FWpVJejt0WPsYmQVgImYPa1kOAcktqtakufadckxRMRqHPDAAyxJsINZ6r3l5uYla/OGYNHN2Ad
 zzi/7ummkgnOg7nEfXm7mvUvfdEq3bzbZxqVX2AoOqa7mqsbGwv7V
X-Gm-Gg: ASbGnculS9BxVERc+YVmgNnjBulGGBDYV4e0h9MtCvCrROZTes3sbnqYzxGl/h4cLrQ
 +S8XvAeEEM2G3IqnE93YxdGyWaVEHw+GRROzyeFEV7r1QvWaNkKUTSNpNzLk2q7hRLsWGMmUvxO
 +awOv43T8hmJ+9pocsQxSGg7d2N9bT6yYnE0Fb9hQFfYPh
X-Google-Smtp-Source: AGHT+IFE/hyX1aFmz4B7yFbqwwg1cR8nZB+SJpweDGbzDuFDEL5iswy016dmWXdPkTEuN/TzDZR9HsXPSzq34VnbbCQ=
X-Received: by 2002:a05:690c:5506:10b0:712:c295:d034 with SMTP id
 00721157ae682-712c63ed327mr142025237b3.11.1750682117334; Mon, 23 Jun 2025
 05:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-22-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 13:35:05 +0100
X-Gm-Features: AX0GCFtXZM9hmle2vULdp8epiwPjqUdyO-dxuKh8YHvt5i3RRgV_x2LbTpvpmsU
Message-ID: <CAFEAcA9t41riPXPCec0ZfwrU1QCuvVDvGfYiYOpPMrsLNamdHQ@mail.gmail.com>
Subject: Re: [PATCH v2 021/101] target/arm: Split get_tile_rowcol argument
 tile_index
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Decode tile number and index offset beforehand and separately.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 17 +++++--------
>  target/arm/tcg/sme.decode      | 46 +++++++++++++++++++++++-----------
>  2 files changed, 38 insertions(+), 25 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

