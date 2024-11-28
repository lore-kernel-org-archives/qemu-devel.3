Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521B0D690F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGce2-00080O-Fb; Thu, 28 Nov 2024 06:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGce0-000804-PW
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:25:12 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGcdy-0006XR-CQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:25:12 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so845890a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732793107; x=1733397907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Id04DDYQrbVcxK7yxXmFJWG9GzF9KP9d9fAiWOrDvhU=;
 b=cRAdCbAaPhKaffKPoo2cjR/EQ/wy43Ty9xh8Stoa7eHDiWYlnMyXQPfQLt5PPVNQc8
 +UMP2WIYINUxBWvQedpBKp9JXJhSVPe85n9YD7AQ5IIIjmOqNyRbiYs+wbSMQ1Ho3VGh
 RBkJLKoN3m5ewrLsnitRv7NBC6R4VpxSLC/m+4WVMm3w5JkSB1zJg/gc8KktjZxAoN2A
 Z7zVqTZbQ2/L9Sjh5un4v6u6Qrvl9ClawCHneXQOz+dk2U5Ufo2xXfVG/EtpU96K+DsT
 xNbl72SqVG1Haft4/wfzC/6vAw/Srp2SOQ4iW3RlvT04iDBHG3a1N6AeL0wxb1vSXRX7
 KS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732793107; x=1733397907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Id04DDYQrbVcxK7yxXmFJWG9GzF9KP9d9fAiWOrDvhU=;
 b=LqS8p8eusQDSJrX9h79IPVJKhdqAVA02Uun17OWi6jOlzpuM/M1S+jXzo4ZQQB00/g
 /VkxSFK4y2+yBwPPgyg3V9GK+Rp7h4eNDe82qsyw2O3tcsbTE9b8t8YuZYE54goNrM3I
 vVwymh+7x1ts3i/5fUpLnaBpNBXqJXUQ8PmMbdHoncbULNBQF6HVapsb7jnhZssBTWOe
 +n9cv5pIEhbmCNolddiFOs7xN2PttwxiOJwYYxtAZ1o2SwFeL/5DOYuSTYDJ03rty9Xl
 sqzMYloBkKEwoyz3SiI69ARU5IIfhO1YJsvlU+a4lkzKU66zxDaXHFDlqCLQz/BxriE1
 ZuBg==
X-Gm-Message-State: AOJu0YwDKQx281LuvfWacaXtfdPW37kKU031mE4ztvA/iUR61AwznzA6
 dmUdNXQ1MuYHClFkVdTS6sm54zzt0MjKoo1GZZQrE3561fNQaU171DYNskxbhjIlssdKSUJh4Zf
 6jZXepWNa65zJbS5CpmA4OePNenTbFqm3TddYhQ==
X-Gm-Gg: ASbGncuV8qmzJ3eEhwwxYUzUav1aq+YcCF3LvhhIKtgLla7nFPXRO7tMTg4k861sj/z
 dJg5Mw+jIEwlFmmNB+dRAD5AQ2x284EBn
X-Google-Smtp-Source: AGHT+IGVn+KpOZeyWvqlk02CB7utVocyssM19dgUeM7t5G3zEp1kcmi5UoMCPA1RXbOreMigPrVS/J7gWR+nkfGtTvg=
X-Received: by 2002:a05:6402:510a:b0:5cf:b860:349f with SMTP id
 4fb4d7f45d1cf-5d080b82344mr5807517a12.1.1732793107400; Thu, 28 Nov 2024
 03:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20241128103831.3452572-1-peter.maydell@linaro.org>
 <2355b5f7-ea66-443b-9cab-24bbe1a18849@ventanamicro.com>
In-Reply-To: <2355b5f7-ea66-443b-9cab-24bbe1a18849@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2024 11:24:56 +0000
Message-ID: <CAFEAcA8vVnMSmEmyR5=x=A91PF2guBbht+aXMOitz4pP+hWNcQ@mail.gmail.com>
Subject: Re: [PATCH for-9.2] target/riscv: Avoid bad shift in
 riscv_cpu_do_interrupt()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org
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

On Thu, 28 Nov 2024 at 11:20, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 11/28/24 7:38 AM, Peter Maydell wrote:
> > In riscv_cpu_do_interrupt() we use the 'cause' value we got out of
> > cs->exception as a shift value.  However this value can be larger
> > than 31, which means that "1 << cause" is undefined behaviour,
> > because we do the shift on an 'int' type.
> >
> > This causes the undefined behaviour sanitizer to complain
> > on one of the check-tcg tests:
> >
> > $ UBSAN_OPTIONS=print_stacktrace=1:abort_on_error=1:halt_on_error=1 ./build/clang/qemu-system-riscv64 -M virt -semihosting -display none -device loader,file=build/clang/tests/tcg/riscv64-softmmu/issue1060
> > ../../target/riscv/cpu_helper.c:1805:38: runtime error: shift exponent 63 is too large for 32-bit type 'int'
> >      #0 0x55f2dc026703 in riscv_cpu_do_interrupt /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../target/riscv/cpu_helper.c:1805:38
> >      #1 0x55f2dc3d170e in cpu_handle_exception /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../accel/tcg/cpu-exec.c:752:9
> >
> > In this case cause is RISCV_EXCP_SEMIHOST, which is 0x3f.
> >
> > Use 1ULL instead to ensure that the shift is in range.
>
>
>
> I believe we can add:
>
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")
>
>
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks. Probably also reasonable to Cc: qemu-stable@nongnu.org,
which I forgot.

-- PMM

