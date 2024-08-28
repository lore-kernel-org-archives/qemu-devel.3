Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34299C54743
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 00:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj6Ba-0004gz-8r; Tue, 27 Aug 2024 20:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj6BV-0004NU-8G; Tue, 27 Aug 2024 20:05:14 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sj6BT-00064L-9V; Tue, 27 Aug 2024 20:05:12 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-498d053f116so1936935137.3; 
 Tue, 27 Aug 2024 17:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724803509; x=1725408309; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bxLuwfGbpBVCloDdi2L53TLOYX0hjtvuGPV+y+IZkM=;
 b=OrZaHqAPDwwuULFw1uJsWfnPENr3CDFOnJgsIkfbl3Bvz0r4Lhd+tE6oyvnxSVRoBZ
 jH2YI68kv8yzB8PLoPAaYDujB66Qh2RmK5JbXQ6zrajGkqzOO+/tN/okSg4wTt8Gp+Ps
 5BdWkyYbA07odzx43pzj6Rc8+hGaUPsNuCxPhH3ndh9jjLw9wIV7k+zoTcffNsI3Q2HR
 dnsA1x2H+1G2DyvTOX4/kdTzRT+i6D3cy+2WbcKgnIBmN+SyqwW/Y0YrxPxhxV9elSMp
 Oij/r6aBmNkDGPMRfDT7Q8SLVNYvtz/g176mTEKEK2AXRLIkXAltd4v75szY20k9b1Cw
 UIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724803509; x=1725408309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bxLuwfGbpBVCloDdi2L53TLOYX0hjtvuGPV+y+IZkM=;
 b=fnQtiA0N6Aw7wYheBzip2+S2sblQJ75iBr0hRl2WsB62bKBabsPFMXu5QG7zU2K4Cw
 KQ1ar1PlFMkKzgC793CO0rXCN2tplX3+Kq8JmMThPdsBjjc1eHmZDMR8KoChLqcba77w
 QgPjT2fbEuXS34hHHXIgi8RzOlqdEkfjO7JqMlLuP9LzyPFcYQbtYIqpjwbT16k/Q5vO
 p4CwT4O8r+OM6okspK1gDbM9p67qpyT1tgGZ/WcAxeIBm2drWNSzhKOeEpCQ2cbMpid1
 Mfa8DdXHMjDtXv1l4Sx1GvBGtgs3hXTryZyhvNsMRyQdxg0dkI+9vdOHEojvLF0e3i9d
 kHuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe8i8GwCELMm8SIjyEYlAXfa7Ocy2VGM3C6CwrEMJ/rPD9bnyQ6cQY5cvMFlFNFT2qZGo9NseVdPa9@nongnu.org
X-Gm-Message-State: AOJu0Yyhc2c72bRH5gs1JjNJ2jvo5zG3cQp1W5lvgK46qjPMGFHC4WF/
 U7gObwHk69hek7akRw1vpwcMRS0lzF4augNZZ1Z5MaZmJfJa3Zprysr0G5nSLV3ooBFISUAaIVf
 5vO7Xtd5TUp+/JjUyw/jf9ZO5J5mDfPJk
X-Google-Smtp-Source: AGHT+IEkr319L2DHLFl/E2E/49TlPHoHrB/5VClAWKuldx+tCYQYSe3Tv0K8+qOzk79S8LOJ/5aXrAU6IXMaBPm+hxU=
X-Received: by 2002:a05:6102:3a14:b0:48f:42c8:e0a9 with SMTP id
 ada2fe7eead31-49a4f072108mr372337137.26.1724803509142; Tue, 27 Aug 2024
 17:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240827231906.553327-1-debug@rivosinc.com>
 <20240827231906.553327-2-debug@rivosinc.com>
In-Reply-To: <20240827231906.553327-2-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Aug 2024 10:04:43 +1000
Message-ID: <CAKmqyKNPHkUW3-ykSY4wnxrS+MXhF+vo_tMT7yxXa0yyUt0pEQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/21] target/riscv: expose *envcfg csr and priv to
 qemu-user as well
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Aug 28, 2024 at 9:21=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Execution environment config CSR controlling user env and current
> privilege state shouldn't be limited to qemu-system only. *envcfg
> CSRs control enabling of features in next lesser mode. In some cases
> bits *envcfg CSR can be lit up by kernel as part of kernel policy or
> software (user app) can choose to opt-in by issuing a system call
> (e.g. prctl). In case of qemu-user, it should be no different because
> qemu is providing underlying execution environment facility and thus
> either should provide some default value in *envcfg CSRs or react to
> system calls (prctls) initiated from application.
>
> `henvcfg` has been left for qemu-system only because it is not expected
> that someone will use qemu-user where application is expected to have
> hypervisor underneath which is controlling its execution environment. If
> such a need arises then `henvcfg` could be exposed as well.
>
> Relevant discussion:
> https://lore.kernel.org/all/CAKmqyKOTVWPFep2msTQVdUmJErkH+bqCcKEQ4hAnyDFP=
dWKe0Q@mail.gmail.com/
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 87742047ce..270a2a031c 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -226,8 +226,12 @@ struct CPUArchState {
>      uint32_t elf_flags;
>  #endif
>
> -#ifndef CONFIG_USER_ONLY
>      target_ulong priv;
> +    /* CSRs for execution environment configuration */
> +    uint64_t menvcfg;
> +    target_ulong senvcfg;
> +
> +#ifndef CONFIG_USER_ONLY
>      /* This contains QEMU specific information about the virt state. */
>      bool virt_enabled;
>      target_ulong geilen;
> @@ -429,12 +433,9 @@ struct CPUArchState {
>      target_ulong upmmask;
>      target_ulong upmbase;
>
> -    /* CSRs for execution environment configuration */
> -    uint64_t menvcfg;
>      uint64_t mstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t hstateen[SMSTATEEN_MAX_COUNT];
>      uint64_t sstateen[SMSTATEEN_MAX_COUNT];
> -    target_ulong senvcfg;
>      uint64_t henvcfg;
>  #endif
>      target_ulong cur_pmmask;
> --
> 2.44.0
>
>

