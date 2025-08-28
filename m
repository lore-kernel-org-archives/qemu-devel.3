Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78709C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJF-00009q-Lw; Thu, 28 Aug 2025 13:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdsb-00038b-Lp
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:45:33 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdsU-0001K1-IE
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:45:33 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d6059643eso7460997b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392323; x=1756997123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mc/hMFom7BMyGk1wZwWJqZpnOesFIdQggK87IOyk7c0=;
 b=fmdtZrTNjt9iJc2v7TWHM+AvzuAvs3JJAQ9BAAxEa8cd4ll1nB/Iz0oCBvMwBA2s0U
 5nCuL6J1yvGQwERN6toeOUSgLW21/x/Gb+GqJUTJEAnOSS9bX/9ADzuVGYMYW24e8ull
 oh5DZdLGvKdIk5nT+gOPvEVN5MmGrcZI+05pfAo7suRUcKv+945SoW68G4wpow82rrEV
 T/ztd2rrCxuQqupB1f1QY23MD7o2N5tGMlHhFcN5eky8z85LeP2qW7zsBiclgxmvxW1n
 STzwlARslGxep4IU25T2qsgHglkGAXGvMSlHlbGC8VRXZVMn8YCfkgpB2B4DEVsKCeaS
 xkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392323; x=1756997123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mc/hMFom7BMyGk1wZwWJqZpnOesFIdQggK87IOyk7c0=;
 b=CS/K/CUN8pFMBquE+qAUGFuriEBiTyWxaUtDRgRwKXEqWvFske7epiXTfYo4ONG8gV
 Iu3EpkXLxo7gJBWzjfD9MwQcLdTs52UlDjy2x91Fixc6pvugdz+xUwf92GbT791Zh8uM
 K3H65I0OGxMtI3n3KCWhzCcBNnQ4Y4JOEPHjhgI5bkrv6TKP/fWvrXfzymnHjZrGqk/8
 vV8pKcQuCCxAM8udlicIZ4POSyo6MIixeQHj85zxVTn+FZkTkTD9AsDXh2scDMkSFDpl
 XqTCw/iBRu9PVzieWTYnUNdVG7nRvS7ozCgNu6zTCnjWN/aXnhKpMX+J+ROlDig6+zQ1
 aL7A==
X-Gm-Message-State: AOJu0Yz51/EJzQGgb5mfcH0Z6gicZdND3es5uLXsWNokTFcFd131uLnt
 5oFyx5dEsZ1mnKuKTwcRuLF6WB6SKKibHmfOOnSv2hOygmWxrKrd8nLaKmHH36LnWQpkHZwrFmp
 GqODx1Xojvx6I3xMCFVv0WalGQRh2bgWGPwf7Is/hP47Kqmim6fcq
X-Gm-Gg: ASbGncvWdtA+te+wRzrQ4eOIdgF4O7snhBmAVOB2pvN6dr3KGxeW2B5FmkMgvc7KQll
 HVCYoUByWuSiO7nypyMtrW7scixUrsyyz33TdJE7DMDd4hRJDVOEg/zT6Nf23Qlx8Mdz7+WUIAg
 l+4USfJAbNOuuDSgEG4cPSVYz4dsa89bqvRRfiBL3r33awheUF6NEqyEnbOwO1uJUKjLVFauNGf
 bLb7Yhx
X-Google-Smtp-Source: AGHT+IFN6nw+QnRxQ4wXp4EIA6ig3zcOUoLTb86HNjpElA8Ad6MI8aRoDRKJPBspxUAwWG1ZOCraoJq3FKSPqYegIg0=
X-Received: by 2002:a05:690c:f04:b0:71f:9e46:8394 with SMTP id
 00721157ae682-71fdc2f1ae2mr265960837b3.14.1756392323007; Thu, 28 Aug 2025
 07:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-33-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:45:10 +0100
X-Gm-Features: Ac12FXzeFcKhS7MaXikBhHojV9bhLV_UmxFDYQS8N_t8MeGc22NB7V4GN-UFuyw
Message-ID: <CAFEAcA-ezKH_nHvpe_UBzsjUyqRhXwyipe437D_YwX_wn9ERQQ@mail.gmail.com>
Subject: Re: [PATCH v3 32/87] linux-user/x86_64: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove the target_pt_regs structure from target_syscall.h.
> Add target_user_regs_struct to target_ptrace.h, which matches
> what is actually used on x86_64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

