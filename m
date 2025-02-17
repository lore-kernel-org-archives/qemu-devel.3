Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A652CC021A6
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 05:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjtNG-0005zT-Kz; Mon, 17 Feb 2025 00:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtNC-0005zK-Am
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 00:08:50 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjtNA-00068l-M7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 00:08:50 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4bbdf3081acso2622952137.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 21:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739768927; x=1740373727; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbdJAzPRRJfVSoISKGDG0D/SJNoUvNMPCjl9nb/D/zI=;
 b=AnMr4VqWZxJVYdX94aFeL7iVFFwqKN66Vrp4OUFszGzBhqX9SkX1zDWcpJqufnf4wj
 WOCNHKrOtZahiV/1aDK47Nk/Tj8mD3GxcmSrUWpF8KO6ujcH5YUFAxAjtZ3DEHswVxI4
 hZ6G8BXlVOtIIwMIB4eys3G2yLuNyi9XHceDm3kyTUyF0RR9dIWLrFx0nsvb8hggmR7c
 TZr9qTYCp6ex/RBBMPTfP8Q2S3sIQ286XEfD32sqDTmlMIb3YsumAe7HAoTs0JjjP1rn
 PyU6FtmyCJbJZLmigz3kLjLIBka6oA9VooA+bGD6bunlK3j1GMdj61MTUGLuUvb63QeX
 Sx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739768927; x=1740373727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbdJAzPRRJfVSoISKGDG0D/SJNoUvNMPCjl9nb/D/zI=;
 b=wgkAAlrCTVvb/enFqKSXIXX+pPp1GC2yochiaAw9jpeWsea0ktA14hYXWdDFYLYUKq
 hPgLzAhphr9GeCfXhhwZ4P5ul3CK7G7opWG7q1E3Fpq3Xd3+9qyF0pq0tBrw+/eSrNVm
 YikNZ/WWg/Q6/hbQAUm7Qmmm8XyIyrV5lASUGIABVYPGk+uFBGXdfObFRlTrmOaAcMsJ
 NjXLXy5MynMGN35Gb5aRn1Za9wWJ92ioH7Qf3U0XF+bnZTurNiM3SGJc0Tq7B2EvUDML
 8yr+mclCUhYOZtqutKoqZUFuPKy/Dn79yRe7fz7qaMoXDggeg2l0mD8KFzlA5pndwQRk
 kJcA==
X-Gm-Message-State: AOJu0YwMpBAb0KY2pmLbLWriR71pQEgbzqoeU/dtdFIVIrJM3hrS5r60
 shPz+yTLe7+hJKiDeWglM0djuV81Du6SbGoM5BLkIJsUWYfUVf8/rvcRVCu2YQwsbd8Ce+aH5Bp
 srlsH6wXz2TXBgfK/FzglkYPKidU=
X-Gm-Gg: ASbGnctuwsfjCWo89dnegCDAfxpcFoX0a/bWfB0SPE/ZwhIVx41t6t9xVirW3Fi5jOR
 YFJZJCe6VppPwgCZCbPQetoF/6V2fGqVJMCEFQUkc5+UTQ7iQOddIXRM6ox8zLZfbjHfSABcu01
 BEG6apsCDTuGEITGlKefenW3aP0w==
X-Google-Smtp-Source: AGHT+IF6n0P0gbL9umXNE9Av3ya7B1G8+ysYT7UIPn1qjhzOarvD4ZwgadcQQWOc2DbUR1FDhdQQQaxfdGRodFQVy1E=
X-Received: by 2002:a05:6102:419e:b0:4bb:9b46:3f92 with SMTP id
 ada2fe7eead31-4bd3fc8b8b7mr3954022137.1.1739768927473; Sun, 16 Feb 2025
 21:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20250212213249.45574-1-philmd@linaro.org>
 <20250212213249.45574-7-philmd@linaro.org>
In-Reply-To: <20250212213249.45574-7-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Feb 2025 15:08:21 +1000
X-Gm-Features: AWEUYZmqoFQ_U9w9_sBoMQtEx300UL-maxpbS__68vo0FOUeI_8sLYFn8WXS-qM
Message-ID: <CAKmqyKMBZ_d_DmfRayfjGiOnVbZ_Tb7rMZzT2CXomp-+vt4rfw@mail.gmail.com>
Subject: Re: [PATCH v3 06/19] target/riscv: Declare RISCVCPUClass::misa_mxl_max
 as RISCVMXL
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Thu, Feb 13, 2025 at 7:37=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  target/riscv/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 97713681cbe..fbe5548cf5a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -529,7 +529,7 @@ struct RISCVCPUClass {
>
>      DeviceRealize parent_realize;
>      ResettablePhases parent_phases;
> -    uint32_t misa_mxl_max;  /* max mxl for this cpu */
> +    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
>  };
>
>  static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2c..f3ad7f88f0e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2955,7 +2955,7 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
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
> 2.47.1
>
>

