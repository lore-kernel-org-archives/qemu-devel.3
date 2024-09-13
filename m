Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8EEFA3741
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 10:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp3gL-0002iF-99; Fri, 13 Sep 2024 06:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp3gE-0002hN-V0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:37:35 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp3gB-0004UZ-JL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 06:37:33 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f754d4a6e4so23581101fa.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 03:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726223849; x=1726828649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8FJfjsGdDoDrsfIpgpvNTYlIuFf/4xOhIM1cqpYOE6s=;
 b=k59D0GbZOm/Ax4jJjMkd3Eph28NGM/af3Ek287SmA3/qbF4FL21y/Y4K4MTPjB+fJr
 FWFX8LtwcJNPyi8eg0Rr3HVW4WoTa97PiF8uHI8TX+wFL48ogFfTHn/MffjpX0HMIJ/q
 KqSLCCd6PTBDDSGXpAHIGnerVQfozHZ8I3fyZjQ2rNPLph/ttB5RPy02FdTGK7XrRab6
 FSCoujZD0DjRd6DFPwB0U4Gi1ufYNORYF2GbyMk8p0DRhxKMgZ4JdwRWc6+OL/8D+dLg
 mNmUTXaTpf4aUU3a8jQpmXts8p2FZHsAgJSbiuyQSfkFoGhoo4bjn+3cV9y18PZ8hmql
 rDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726223849; x=1726828649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8FJfjsGdDoDrsfIpgpvNTYlIuFf/4xOhIM1cqpYOE6s=;
 b=ub8Bhv0/dyph6CoIc23gchcPS7PB0ah/vN1SsrzlumduIxK7CaiSheeaAdEaR46YR/
 +EQkyn8Y3jpzrSnBxJPB3MM6+2Gl7NSRFKmHEfxEmezQWmheTCucsu5CmeswskTr9q4w
 LOQFYfR9Azq14p7x/ERD232/Co8L5MpnJspi+dlyD1mX4B5TQQC7/+2et83bISocLssm
 YmfPe5E/7s+SaBoqJhFPuLupVxxaGcCqedUCSzKbqG7E8iHIxS4IuyC2loImIrbGgWxK
 ABxn7HZxQmMbVQvEh/OKATU5c0kmIIaPBs1CJelsCt6Jv7Q+QQCqGzw3Q3+17U9d/OZC
 4rPQ==
X-Gm-Message-State: AOJu0YzBWZOQQiZHdRn01WOkFqHlBETWS+vtli4+Svl3DZK2xMLrLirW
 4F8y2tFgQOZfUeeMNHM4Q3LESEjjW3BcpATR+OWBzX51CB3OGZAOsYDMtXb8b4gq8CMdmzOv/Y6
 NmjpdeJHB12WoJIlTLS0XjJ/rdxJNmZsTB3KBEg==
X-Google-Smtp-Source: AGHT+IHYe96KDEDcvgMWeFlgOaQHooD1urXfnda8YpHX9FDVXdyrCl3uf+XGdeGVZccMegFGLVDslZm7kQb/qJE56kQ=
X-Received: by 2002:a2e:be28:0:b0:2f4:402:2a77 with SMTP id
 38308e7fff4ca-2f787f4f40amr29334531fa.45.1726223849209; Fri, 13 Sep 2024
 03:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 11:37:18 +0100
Message-ID: <CAFEAcA_W5bTcCmeAx+dB4+djcUHzjRH4GfBobaHot5VjE+x05g@mail.gmail.com>
Subject: Re: [PULL 00/47] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Thu, 12 Sept 2024 at 06:30, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit a4eb31c678400472de0b4915b9154a7c20d8332f:
>
>   Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/stsquad/qemu into staging (2024-09-11 13:17:29 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240912-1
>
> for you to fetch changes up to 90d5d3c1115399d8e27621efd69dfa74a35a4932:
>
>   hw/intc: riscv-imsic: Fix interrupt state updates. (2024-09-12 15:05:10 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.2
>
> * Add a property to set vl to ceil(AVL/2)
> * Enable numamem testing for RISC-V
> * Consider MISA bit choice in implied rule
> * Fix the za64rs priv spec requirements
> * Enable Bit Manip for OpenTitan Ibex CPU
> * Fix the group bit setting of AIA with KVM
> * Stop timer with infinite timecmp
> * Add 'fcsr' register to QEMU log as a part of F extension
> * Fix riscv64 build on musl libc
> * Add preliminary textra trigger CSR functions
> * RISC-V IOMMU support
> * RISC-V bsd-user support
> * Respect firmware ELF entry point
> * Add Svvptc extension support
> * Fix masking of rv32 physical address
> * Fix linking problem with semihosting disabled
> * Fix IMSIC interrupt state updates

Hi; this fails to build on FreeBSD:

https://gitlab.com/qemu-project/qemu/-/jobs/7817823771

In file included from ../bsd-user/elfload.c:31:
In file included from ../bsd-user/freebsd/target_os_stack.h:24:
../bsd-user/riscv/target_arch_sigtramp.h:32:33: error: initializer
element is not a compile-time constant
32 | /*2*/ const_le32(0x00050513 + (sigf_uc << 20)), /*addi a0,a0,sigf_uc*/
   |                  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~
/tmp/cirrus-ci-build/include/qemu/bswap.h:168:26: note: expanded from
macro 'const_le32'
168 | # define const_le32(_x) (_x)
    |                          ^~


and

In file included from ../bsd-user/main.c:53:
../bsd-user/riscv/target_arch_cpu.h:126:13: error: call to undeclared
function 'force_sig_fault'; ISO C99 and later do not support implicit
function declarations [-Werror,-Wimplicit-function-declaration]
126 | force_sig_fault(signo, code, env->pc);
    | ^
../bsd-user/riscv/target_arch_cpu.h:129:9: error: call to undeclared
function 'process_pending_signals'; ISO C99 and later do not support
implicit function declarations
[-Werror,-Wimplicit-function-declaration]
129 | process_pending_signals(env);
    | ^
../bsd-user/main.c:608:5: error: call to undeclared function
'signal_init'; ISO C99 and later do not support implicit function
declarations [-Werror,-Wimplicit-function-declaration]
608 | signal_init();
    | ^
3 errors generated.

thanks
-- PMM

