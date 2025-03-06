Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6C0C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 00:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzNw-0003KD-UR; Wed, 05 Mar 2025 19:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzNm-0003Ji-L1
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:46:38 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzNk-0002PD-7T
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 19:46:37 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51f22008544so37673e0c.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 16:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741221994; x=1741826794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLgtt0jj/ZeWbafRoDg3HnCPHK0fs2Ncp9ULEmiYjKo=;
 b=UJ9EZn1v6+30SyEAU8Nb7vH+mJsev2lk1CkIH3RWh0v1AY6jsuXT3y1qpaNT6SBZGy
 1lGv1bhXlFlIWL3uHa3tZxe+0PhwtHWIlxYJ3DtevJdOTKhVggx9vQPWGMqw3APRsndJ
 2ZqWFhb3sOPXPR+5dbRKDv2Hu6z+OY/lgYu1iBu5efF1b3c1Bs6JC19pP3Wiz/sp6sjc
 iXeimR4QzondQJYhh2IokkJVFJrLc0IVCiQjUH0DdJCShU92hYdXrSddAvu40Xwhc6OK
 BkANJZH7mqFlt827FgRDBAbbdQ/K/51+MhsZ3ZDDpOpmbFjc0+/PIYe1LV2nRTOMJs9k
 xcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741221994; x=1741826794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLgtt0jj/ZeWbafRoDg3HnCPHK0fs2Ncp9ULEmiYjKo=;
 b=RAZhc9H3v+MyD24OSNmJA5wIc2/jdFYQU/tCHaCaabVR0CZdNVmTcQtQfGBHyhOsDL
 KOMnIQHq+C+DIcDcoKfzBZwH7Ufgn9v34wLxYCe2AiW4zA7CghG1dMftH2Vv2ftsrveZ
 j9juQJJ/Nz9bRUZDnPV/ENBKJrN2xv+B/l8MV+VHDUWJ47dJooSeYlAueoDv7+TRCzAH
 U6zu43pxpcsjKfHhRGiTZ1EkjPJYXaYfg64UuqUsU86E5kVMH8AjoHnFzj8FeufgNOnt
 ZqcOogqopIa4R4+uoDUyqaI0snXVe1QlulUzjEkyKtLMGSxc+uCPfchM474QpsfJDcQI
 ws3Q==
X-Gm-Message-State: AOJu0YwPYTUBv2qAYfaYrdM5LK6oiRrqqzqCGoJITDqLVQoT/BBeXlRK
 nGPvoIJXp0e6JeirFDHJh9cZBZKZjI7YO5sBjVhcjfjHTkA12T7Goz79gCRj6DYnjtoQsuG+CSH
 +qh65fy9NLzHlReypGYfwcKs2nYI=
X-Gm-Gg: ASbGncu3BgG2W71diaW3W43j/BUhYstpFWlHrfgXMZs2ZOXB450sz6oGTZbCc6NXOSp
 sGDx76K3IYM4Y4slsd3+6UNKslaceBASDnZa/qBZniTOzdnJgQmMN+MFb8G6+MrmVjSw+47/Cff
 eQKLYMS5T8q7xjNu4OiM/+R0iiinLpHI+DjVsxh0VFforhY9XklazlA0ED
X-Google-Smtp-Source: AGHT+IFKU6iEHicQBeoyphWUOTV4gjxt0708lkELKfOTxyrXI0SsI/vAzRBbk8nvQQeZ9ghRIKgdcxQDoIAZkJEvBVo=
X-Received: by 2002:a05:6122:4890:b0:523:7316:7f31 with SMTP id
 71dfb90a1353d-523c617d351mr3639074e0c.5.1741221994609; Wed, 05 Mar 2025
 16:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <20250228102747.867770-2-pbonzini@redhat.com>
In-Reply-To: <20250228102747.867770-2-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 10:46:08 +1000
X-Gm-Features: AQ5f1JoHSUT38YBZL4A-E9umRyocUQ21TuLe30afjnWslBEmkf25UC4u3fHcQy4
Message-ID: <CAKmqyKNjoaKEEVYd8NJ293L-AFbNofrhczqExb_cNrQ0MVpEOw@mail.gmail.com>
Subject: Re: [PATCH 01/22] target/riscv: Declare RISCVCPUClass::misa_mxl_max
 as RISCVMXL
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Feb 28, 2025 at 8:31=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Link: https://lore.kernel.org/r/20250212213249.45574-7-philmd@linaro.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  target/riscv/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index df7a05e7d15..3041a4be5c9 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -543,7 +543,7 @@ struct RISCVCPUClass {
>
>      DeviceRealize parent_realize;
>      ResettablePhases parent_phases;
> -    uint32_t misa_mxl_max;  /* max mxl for this cpu */
> +    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
>  };
>
>  static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 244e44ce410..85dc2fe3bec 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2961,7 +2961,7 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
id *data)
>  {
>      RISCVCPUClass *mcc =3D RISCV_CPU_CLASS(c);
>
> -    mcc->misa_mxl_max =3D (uint32_t)(uintptr_t)data;
> +    mcc->misa_mxl_max =3D (RISCVMXL)(uintptr_t)data;
>      riscv_cpu_validate_misa_mxl(mcc);
>  }
>
> --
> 2.48.1
>
>

