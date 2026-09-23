Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734D9C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kqo-0003OZ-1i; Wed, 23 Sep 2026 07:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9Kq8-00039R-UE
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:08:47 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9Kq4-0005rW-Vj
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:08:40 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a67fa7a64eso1282678a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790161714; x=1790766514; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u+wfn8gdeVfGYzojMxuEodLvtUbWCKuF8VPyzgSffFo=;
 b=PB0JeJPszPguYqDR+8rcW11M9gp4uKRaOtFxxzRUlntA8fNS/+2kNgjUM2FqAIQPEY
 er6hmxtHw6tGMoNDhEsTToCCW5ZO6S+aZTVn+nPPmKy5XrSysmkbLRUXZD5JTlGoQsWR
 rprN8RjmpcBzk1ZbBtUAHuXb/jc2a/RZ3if+c8piCdQG6VgOkUYEI2XgSy4kyGizZdJJ
 BdgEcg/LYPBhGN08nrLeEfE9Oji4lIZ2jF7ionTFnD1IZjxJAGnupyxQi7bvuEJski90
 jKmBG9hyBaAUF3mKj1ztKsjV0mh359co71tcD/j+h8yizRgIUDnTtfa38K842Ut9aUG2
 Dydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790161714; x=1790766514;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u+wfn8gdeVfGYzojMxuEodLvtUbWCKuF8VPyzgSffFo=;
 b=O2nZUiG78FMcRpeyBSUqTIQP+/d/6N2s6BevoW7XKI/mVY/44YLHLfCmAvo7xA/X+o
 KudIx84u+M7n+iyYMkGvs0ox63YOXFcjgjJgYFryBmkcvzKq7w/lV91O9dyZgAUJZxPY
 qBXP6om+oumlQq8dxLSCujvI5nWc8u3vV4lTeCoDSnz/BfpI2k/4Xn9DYpwak/qS8Tbm
 Jty7qw6bsqf133TPL6ON3gxv9c+Gk+e+zk3n7nMluRmBiGDfMtb1WoTR9Yymg8luNer8
 //qD0uAIAypIXEIFGvrRoIt08dBAQbSc8aZrpIq/dEiXGWgL8FJH4JMp/V/OkleW9e9I
 XscA==
X-Gm-Message-State: AFuF++m/Lr8fPP0hKTgAVCTSWmip+wQHKBb9kKhPte9RQ5T2kn6+uzhl
 lkZ88aeF1Qp5Is9LA7sj1Z+QzJam0crVGaFv5znSs6qiJltVXTT34WytecUYa+D2ptvCzx6KtfC
 eqv844UU=
X-Gm-Gg: AYBFou1qJQEWnH6Sv9/ipVpg3QD3DfbmMbcSTJJBhNeeEc4ALygt1Xj+yiyVejPvAmS
 nGCz50rTdnDYEuPOiOAmkbm4Tz9PwP3WNpiGqSyaaEbyqTkhIuIUluzK7Hg+5qvmGK/rgWN4kpe
 pcxi4lZaBsNs7n/ZahfitY/2+GphBvKJ8cymbo3qP2u+Eh9ypV4c9o8TRWrP0WDjiFpop79oy1V
 z4JaszN/QEe4D3VgTW1juaHiTNDcnNsbVObnfXreB5N29TGh7OkL/KpO807iaRR14HfQRziH8MV
 qSUeZ1fnVBFTjg+UnY3UzW6NgG86iDheFwcIf0KytOajxei+r35EKNNfEbET9ajHTJDrbVGEFb1
 HPOxBatNI3m/fsGJwM8c13TbYy9zwDLVqWfbpxTkPDO2/XUQwqAE4NIxGk3DGm1oI1h9Ycv4GRS
 kPYnZ5iDWWEKappY3j4msPYhqXKgFymF7M2fjBBzRC1h5BdUtAh6SujJmVoK3CINixfSsx4Zi8
X-Received: by 2002:a17:907:96a4:b0:c29:c079:676d with SMTP id
 a640c23a62f3a-c2aadc97a84mr176078566b.3.1790161714063; 
 Wed, 23 Sep 2026 04:08:34 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:805c:5b2c:d225:9d51])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae5c6022sm94701366b.14.2026.09.23.04.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 04:08:33 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:08:31 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH v2 2/2] tests/tcg/i386/system: Add regression test for
 translator_ld wraparound
Message-ID: <arOzL0MIXNa2pVG_@linaro.org>
References: <20260916235158.294901-1-richard.henderson@linaro.org>
 <20260916235158.294901-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916235158.294901-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 16, 2026 at 01:51:58PM -1000, Richard Henderson wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Add a test case that reaches an instruction straddling the end of the 32-bit
> address space (0xfffffffe).
> 
> The top page (0xfffff000) is SeaBIOS ROM, so the cross-boundary byte is
> the ROM's own 0x00 (add r/m8, r8) at 0xffffffff, whose modrm is fetched
> from [0x0]. A short exit stub is placed there.  The case runs on
> qemu-system-i386 since the bug is 32-bit only.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Message-ID: <20260709020529.126652-3-cui.tao@linux.dev>
> [rth: Simplify and convert to meson test harness]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/i386/system/meson.build  |  4 ++++
>  tests/tcg/i386/system/wraparound.S | 35 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 tests/tcg/i386/system/wraparound.S
> 
> diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
> index d3f73997c7f..c08563d0ab5 100644
> --- a/tests/tcg/i386/system/meson.build
> +++ b/tests/tcg/i386/system/meson.build
> @@ -34,6 +34,10 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
>    endforeach
>  endforeach
>  
> +tests += {
> +  'wraparound.S': { 'cflags': cflags, 'qemu_args': ['-m', '4G'] + qemu_def_args }
> +}
> +
>  if 'qemu-system-i386' in emulators
>    tcg_tests += {
>      'i386-softmmu': {
> diff --git a/tests/tcg/i386/system/wraparound.S b/tests/tcg/i386/system/wraparound.S
> new file mode 100644
> index 00000000000..9c77b3a8468
> --- /dev/null
> +++ b/tests/tcg/i386/system/wraparound.S
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Regression test for the translator_ld crash when an instruction
> + * straddles the end of the 32-bit address space (i386).
> + */
> +
> +        .code32
> +        .section .text
> +
> +main:
> +        /*
> +         * The top page (0xfffff000) is SeaBIOS ROM and cannot be written.
> +         * Its byte at 0xffffffff (0x00 = "add r/m8, r8") already crosses the
> +         * page boundary into page1 at 0x0, which is exactly the case
> +         * translator_ld must handle without aborting.  Reaching 0xfffffffe
> +         * runs the ROM's cld, then that add; the add's modrm is fetched from
> +         * [0x0], which is RAM, so build a short exit stub there:
> +         *
> +         *   [0x0] c0                 modrm -> "add al, al" (reg; EIP -> 1)
> +         *   [0x1] c3                 ret
> +         *
> +         * Note: this relies on the SeaBIOS byte at 0xffffffff being 0x00
> +         * (add r/m8, r8); if that ever changes, the stub below must move.
> +         *
> +         * Note that eax = 0 before and after the stub, so this becomes
> +         * the exit code of the test.
> +         */
> +        xor     %eax, %eax
> +        movw    $0xc3c0, (%eax)
> +        movl    $0xfffffffe, %ecx
> +        jmp     *%ecx
> +
> +        .globl  main
> +        .type   main, @function
> +        .size   main, . - main
> -- 
> 2.53.0

Nice test case!

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


