Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ABCC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzxU-0005lM-KU; Wed, 05 Mar 2025 20:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzxR-0005ks-Sm
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:23:30 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzxQ-0005zZ-34
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:23:29 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5236fe026c7so59609e0c.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741224207; x=1741829007; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJALTU45RRm48psp2fF9HAKE4CL+zga6CBYBb3/pPb0=;
 b=Q3127TvMiy9VkJMk0QzLMqrA1C5LwK4X6ohuKshclS+ZHNGZClPEaGjmsA7pKEMd69
 KQ378WP6Qpq7JWTsbce1DuWfI9JEl4zvWxn7034z/A4PlmLw492c/cm2y5CTgL3MzBDb
 rh4tdglq/Q+PUn5r6pnl7mYzaWvRsdkgDPsaH/vu1BaM4QPuqehAGayAfihb2zdg3VVa
 7MKDc42yjd2/cgi7y/AjLRu8titg5PkHjhejZ23wLdJTGV4B+/RhVA6A2tSxSQ8sEmMP
 r4r8+nnCJt4oBFz6ZPd5AyGI0cMU0nO05R/May3KWHDBqG0SHEGA6MgUjGzC2+iVb3jh
 6MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741224207; x=1741829007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJALTU45RRm48psp2fF9HAKE4CL+zga6CBYBb3/pPb0=;
 b=tRFQ/eWDJkpgytttQpidmHofvihR/XJkY1y+3m4QAOHrPKG9gECbqDvhu7UcBYnPaD
 6hqW9r+S2pSltHDkF6NoUN6H6PaoOr4DyUEHBBhxqJiXgLexupUOp8wcXNMdIQSDzv3/
 Dl5zTI14duCt2OxnzLNAIxoazcFOw9pjx4Dx9HWgkKH95I10hB1hu3OrS8PAMyAHVDi3
 fbYlSxrJAgPm5hRAY8n6KPcwU59oVjfpiwBEaFiD9qApXxh/y+0tEbwCPsCmAtoK2+ok
 IuugNz+N/wZH5MfzOsKTFt/59vot360dgLe8dvHBFa3vkXK0/ccJBeo1AdYAVyt+emHP
 HoXA==
X-Gm-Message-State: AOJu0Yy4FA+KFpYSw4SlTrUTR0LScH56Hq3wtckmIrD/dgns6IvanjuR
 U90djUgjJIWm8KzvgLpc11CqsPLfdon+/qwaO5jkV9BGQPCoCYgIalzcyLlrnezjIvlAsriQIpR
 2J2LpQQ94h37VnkbdWrHMdUWTy/E=
X-Gm-Gg: ASbGncuPMNopKppeFF23D7F05XXUIsOr3dJ+wgMMlh0EYZ8LONSwRU91vPLybUS7K3P
 gDBx8BCcnz3LBSg4hRV4bSZGcwYQGN34qQbjLpeUBk6mWQCKKGGoUOtJ3C9jYsu0jvD/0ccKl7T
 /nJfsA0Xm4bSA8HPzsRrR5NkAh3w3lubj9ZSqohNdcJY7bzADg8khQGd2S
X-Google-Smtp-Source: AGHT+IFmHuMkarRBPw4730Z5D17TxxQMyHlvaI9Y4zwb4T89HnGocCIHIyOKGjPLWmtFDOgCVu7JqJjCo2NJjlmrBkg=
X-Received: by 2002:a05:6122:4b0c:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-523c62a8fd6mr3223916e0c.8.1741224207016; Wed, 05 Mar 2025
 17:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-4-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-4-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 11:23:01 +1000
X-Gm-Features: AQ5f1JrKq1vOZ9frtnu660ow4CzlQgb5IuXu3Jd2ZbLGn7wVyjwlFzsz2f7HZV0
Message-ID: <CAKmqyKMgMOKduscWLL9AUC_-UDNVP_PzbN9=q21TUPSJdLHPjg@mail.gmail.com>
Subject: Re: [PATCH 3/7] target/riscv: assert argument to
 set_satp_mode_max_supported is valid
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, Feb 19, 2025 at 2:58=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Check that the argument to set_satp_mode_max_supported is valid for
> the MXL value of the CPU.  It would be a bug in the CPU definition
> if it weren't.
>
> In fact, there is such a bug in riscv_bare_cpu_init(): not just
> SV32 is not a valid VM mode for 64-bit CPUs, SV64 is not a
> valid VM mode at all, not yet at least.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cca24b9f1fc..7950b6447f8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -442,6 +442,8 @@ static void set_satp_mode_max_supported(RISCVCPU *cpu=
,
>              cpu->cfg.satp_mode.supported |=3D (1 << i);
>          }
>      }
> +
> +    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
>  }
>
>  /* Set the satp mode to the max supported */
> @@ -1502,7 +1504,9 @@ static void riscv_bare_cpu_init(Object *obj)
>       * satp_mode manually (see set_satp_mode_default()).
>       */
>  #ifndef CONFIG_USER_ONLY
> -    set_satp_mode_max_supported(cpu, VM_1_10_SV64);
> +    set_satp_mode_max_supported(RISCV_CPU(obj),
> +        riscv_cpu_mxl(&RISCV_CPU(obj)->env) =3D=3D MXL_RV32 ?
> +        VM_1_10_SV32 : VM_1_10_SV57);
>  #endif
>  }
>
> --
> 2.48.1
>
>

