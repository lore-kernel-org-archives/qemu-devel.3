Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653A2C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 16:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWIrr-000796-3H; Sat, 03 Feb 2024 11:27:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWIrp-00078M-L5
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 11:27:45 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWIro-0000vS-1d
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 11:27:45 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d08d34ce3dso12174561fa.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 08:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706977662; x=1707582462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=igktEIcdzcOQ0K3z5G+npxLXxC+A0Qpgutzvlm5cyPA=;
 b=XmkQmx3idsY7mF/x/BNnE5iBQ42j3bEkdZ74Go7lSijB4SeoeTpS/m4Obe9qlglMiT
 W/QQhOb1Y1D5MfXuElhh7tDvPUW4PdHArDRToYSaU30ejMFiiuXlq1Q7CTBvcokAxUyA
 Cg7XeetELXr9lBjzYjkkzbrCSivm33FtNW9WDZe2YihHgu417gWSIv+MJH9cC3JWvhVZ
 HTKqlLSH0eu48O5GyM/+rsZ/Uqa3FsSRpnfydFSiS5d3CBS0DUkNxYsB5bzlkZ9nTq8T
 036Iax2IU3Dugl78ll34P3CoV6ClRTd4zJmqfYvPK0bBsnyauplGiwKN2ydGsGWvU4L+
 skGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706977662; x=1707582462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igktEIcdzcOQ0K3z5G+npxLXxC+A0Qpgutzvlm5cyPA=;
 b=wrPLgLE5GGKfyWeNOyHoWJuf0CxRMhe2S9tFOZieyWsksnvUQ47U6NmbIA2z8aVkGX
 TNuGfwK179ZLwhuTYw4pI8oL3rTCLqMsILRjkkuTyyBGwxzewAcs9yGU6V1pTTlzxr/t
 QOVWOzVlNT9xGo9Et1EFMu1XIsA3r0GJttsgDb1WSzVnsz/hl3/AiNNv5bgi3vYMY++v
 al/icRNgskImp9vYaAkQmFfpYhHufoDYvV0poI6DwFCd0RBm8SE9ILzy03N7/oYd+LD/
 7pSyd1W6dfmARLqzaccW3tNSLtKWOGuYJPlgmQx8uwwFTJNWciKcanqLjlRSWX5rjeXo
 KaaA==
X-Gm-Message-State: AOJu0Ywsmm0TPtXJSdQImlyyxRPRgx35jMOY1GLf2VyRvoxfoaqxHST0
 MdNaq6x8yzVPnh47uwxOw6OaJ6TMIL4Y2Kaf0l8WjjC7XSul/n3MhQsyuybIvqVaRGzsn573ZpR
 ibOL5kpN8vZEcnU0001jqIET8RQiLo4GKXTbD/Q==
X-Google-Smtp-Source: AGHT+IFbwIub9qAkWBUeKRZfjs7mbU3TCv1AXegTA6jVIvXS791VIG2PwP/N0jyOcYhfAuqcG6/IKo8mDgDwMTBriBc=
X-Received: by 2002:a2e:7d08:0:b0:2d0:8f08:6a5f with SMTP id
 y8-20020a2e7d08000000b002d08f086a5fmr2225506ljc.32.1706977662297; Sat, 03 Feb
 2024 08:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20240203070654.982407-1-richard.henderson@linaro.org>
In-Reply-To: <20240203070654.982407-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Feb 2024 16:27:31 +0000
Message-ID: <CAFEAcA96dKHRS714Vc-qg4OwsBW1uO4REvM2_cAbiD47bQsp=g@mail.gmail.com>
Subject: Re: [PULL v2 00/58] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Sat, 3 Feb 2024 at 07:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Rebase and resolve target/loongarch conflicts.
>     Include linux-user/aarch64 vdso fix.
>
> r~
>
> The following changes since commit 29b008927ef6e3fbb70e6607b25d3fcae26a5190:
>
>   Merge tag 'pull-nic-config-2-20240202' of git://git.infradead.org/users/dwmw2/qemu into staging (2024-02-02 16:47:36 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240202-2
>
> for you to fetch changes up to 6400be014f80e4c2c246eb8be709ea3a96428233:
>
>   linux-user/aarch64: Add padding before __kernel_rt_sigreturn (2024-02-03 16:46:10 +1000)
>
> ----------------------------------------------------------------
> tests/tcg: Fix multiarch/gdbstub/prot-none.py
> hw/core: Convert cpu_mmu_index to a CPUClass hook
> tcg/loongarch64: Set vector registers call clobbered
> target/sparc: floating-point cleanup
> linux-user/aarch64: Add padding before __kernel_rt_sigreturn
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

