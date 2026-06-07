Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62ABCD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 15:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWFSW-0004CS-HG; Sun, 07 Jun 2026 11:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWFSU-0004C9-1v
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 11:30:42 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWFSS-0003AG-CO
 for qemu-devel@nongnu.org; Sun, 07 Jun 2026 11:30:41 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c85c9e8b7e4so1376292a12.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2026 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780846237; x=1781451037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+4qe24JvwktL0AP2A5Hhl4KJyxE2D3nZddLhrAAvn2M=;
 b=yNGQnjqQYw9ZQETtu2xUQlaDYBP4RHWKK6U+qyo0LnHpCHK2m9SUrfv6Mrm63RuSGu
 jgQM3QUSFyBHENjxUCXeBadRh4LZXmQsxNqTJCQmp41OyhezFq2MrjeIY+HYf9xoJ3Vh
 X0o3sJoOdbFPHbDSvOuMIWYSo2bXVLNas/UwjsaH/D1SQmbF490EqKeFGrofHWAbB2ua
 z9AB/PAh9DDj4Quhoh5bQr9swS/1KCUP8pGTErwtVBBhuwnl5HVxD0uIjXWBXG7ALLiW
 aM9MxZIKf0DBGtD4G0CYxq8pcOOsyGgiOEYjGcxWH5d8dJOUnVzxum602SpZTcaOF1fZ
 HHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780846237; x=1781451037;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4qe24JvwktL0AP2A5Hhl4KJyxE2D3nZddLhrAAvn2M=;
 b=RQ/RgECTablK+INs13d0CGvVt6Swx8CErBx5g4CBZV9NOtsCKv0qYLTh53ROD3Uxd4
 Dp/AsPQsq7o4jFRNqLWYX6T6N5kmZ73G9bNAT+Dw78ybb05rgllFeAvEerUd1NHcU4Yj
 C0GLLH+kankleNxwr9y9z2mJ+vcA9wxp2e0gKEOlzD9coGNESNMP2mHbWuueRGePy/p0
 +yVQiIjcDrxrKU470njqbEU4mKgqkS6ifOaJdAf0bX450J49pKGSKWm+TL7/wp6XvkBY
 lg9jaHPMcUP2mCQHYtD8hIa+WaUTBvJqD4c1WJ5Ue7EY+AiNeRSWpk+tVwCHF5rfVtmO
 l35A==
X-Gm-Message-State: AOJu0Yxgc5Tq8Sp8M4mBCkw/Xkp8tSRLeYGnc8P9KFLeK4nHVc8ZkQoN
 7fZmbsso3uOWghdFe5IZelAzzy4sTF/APqQkJYfK7bLy/u6D4+cu3Re0mduxxqjJJQMNrhxXH1V
 oxc1svyQ=
X-Gm-Gg: Acq92OE8oO7Ah5QZlD5CoqlQv5v8ZtV4/wZY5D8hxO9GHKsxXE1tTqbV3Bf3K4qBard
 VqibDVKNkZDdNhcsSL4M92pMOTmNbzm/SlZ1nkHARASyWOoI0MsiXTT7bUkibQVTxxYPnzQK7I6
 SFx5OfuRbOsQHPr80Jtgpyqxv7Mze8vbUTLBeFs1yfa7ew3dK3q8i51syc83aYtGWcbTzVNiqKG
 jR9/K/kiB47K5EUHsGAA1buTn5P1btLTvNxvN+ZkuYvgN4vQ84VYonZfctmw/dJkT6uDa+lrvBr
 1LtuGHYdiQy8Sm899tQG/Z4VnQ0dCp7RkrFk671RjxKUDwDEyIc33g/1FXEJ/yUdLFvXA0gxLej
 +plFX260Idw0DuuU9BbldOYiSrNS0HG2/Hjng7OeGbgjma7xUG4Z+d+2Mc/OmOMjzYMrcvg5QJh
 u0Ltz80dIY4g0EAzpW6plIJdmCIV0hj5pevw4L6eEKKznB3nw=
X-Received: by 2002:a05:6a00:4098:b0:842:40f8:74d0 with SMTP id
 d2e1a72fcca58-842b0e2f5fcmr12214806b3a.6.1780846237136; 
 Sun, 07 Jun 2026 08:30:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842824a2600sm16073216b3a.27.2026.06.07.08.30.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 08:30:36 -0700 (PDT)
Message-ID: <9a596b99-6cd1-4f10-ab6d-d30f25c6d50c@linaro.org>
Date: Sun, 7 Jun 2026 08:30:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] linux-user/alpha: add coredump support
To: qemu-devel@nongnu.org
References: <20260607140356.10702-1-deller@kernel.org>
 <20260607140356.10702-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260607140356.10702-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 6/7/26 07:03, Helge Deller wrote:
> From: Matt Turner <mattst88@gmail.com>
> 
> Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
> mirroring the kernel's elf_gregset_t (ELF_NGREG = 66): r0-r31
> [0..31], f0-f31 [32..63], pc [64], unique [65].  Implement
> elf_core_copy_regs() in elfload.c to populate the gregset from
> CPUAlphaState.
> 
> Without this, bprm->core_dump is NULL for Alpha targets.  When a
> guest signal goes unhandled, dump_core_and_abort() skips the core
> write and falls through to die_with_signal(), which re-raises the
> signal to the host.  The host kernel then writes an x86-64 core file
> for the qemu-alpha process instead of an Alpha guest core.
> 
> v2: Store thread unique field, same as in Linux kernel. Added by Helge &
> suggested by Richard.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/alpha/elfload.c    | 12 ++++++++++++
>   linux-user/alpha/target_elf.h | 13 +++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
> index 1e44475c47..d2aed15ce5 100644
> --- a/linux-user/alpha/elfload.c
> +++ b/linux-user/alpha/elfload.c
> @@ -3,8 +3,20 @@
>   #include "qemu/osdep.h"
>   #include "qemu.h"
>   #include "loader.h"
> +#include "target_elf.h"
>   
>   
> +void elf_core_copy_regs(target_elf_gregset_t *r, const CPUAlphaState *env)
> +{
> +    int i;
> +
> +    for (i = 0; i < 31; i++) {
> +        r->regs[i] = tswap64(env->ir[i]);
> +    }
> +    r->pc = tswap64(env->pc);
> +    r->unique = env->unique;

Swap required.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

