Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5109FCCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfH1-0004Ro-6p; Thu, 30 Oct 2025 22:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfGy-0004RM-OZ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:53:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfGn-0003Xx-8L
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:53:52 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63e0cec110eso3124701a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879217; x=1762484017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ln4kv2Ve8U60gg48kP+9DoZUXu6plwITpMfR9zvr2ZI=;
 b=byZipzV0saWdj88PqgEd7ppxdBT3sNFY8qCTV17e9jjRHRwSw7MaiNw3LWILFpcvay
 UeCRlGgLR5Ms9FJ82rX52VjXiQGhilIkl9pwS+nhjEBtJ5091CbX66hUH9XMsyO1Ta8k
 T/M4VaWwFRqNyDBeJiZIk/z9DrDkBKr5Yp4rziL9NTAOlPzqnSNi/5aYLodv3QY1l2zq
 c+c1U8L4Q+ylXEjvQLAzDSvK6rmbshlM02dfYi2U2+s5lBhVM0PWk0XIb/32t6St4WH3
 Y/oVoQmcBXEA7gmP0HLd5eS5LG9Z7bk4KWUdFR55Lo95AdPY1HjcLdSDOeKdkF3bEkRE
 GNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879217; x=1762484017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ln4kv2Ve8U60gg48kP+9DoZUXu6plwITpMfR9zvr2ZI=;
 b=kt46f2M4MyCZOQlD3CrOG6PxnhGA8eIN/BFlirTabg/SBVEfuxuCboz70tGji7kgFD
 347RBsZUiiPF+c3O6fNkolPF9fz0Nxmzb2UTDC4TTd/3z1XlybpNrSB7hhodyswb/ZJn
 ZbdIhjUxDuCHQorvdToJ8TMM9ZFHIPi+6VsGqXtLBE66PdmC6J+cYR1QvGnC2VLx9fOM
 ATh08Wnc+v9qVTAjg2u1Ev4uwwu24NUFhaH5ONXLz+hDkO2Rn29gse4KxBtkw4nlMat0
 egLRS0CG/zULGZemjq0e3DRpSS1Dy75Uy1nSnWh/GRDLbwZIbM9a9//c/uHptNJht3WA
 KCFw==
X-Gm-Message-State: AOJu0YxbS/XwSVACYORbgvBAo1BbN7Ki2UY/iZk0kiMtEvqf3Il79Q5E
 28pBrL2/u8ttNwA29SdfsJyxPdkYUrb+DxXxyY/VzPsjC0Jgssg5roAYAFG1QsFC8wy/fP3Oqav
 RPEyQpoLdA0ElATnvjPd9hccfAv7zwHg=
X-Gm-Gg: ASbGncsLOnTXV4AIPGIa+hqQ69j2RPuUX8EB505Tco8X8CSp9DAAG0JJ4zKAvAhMnn8
 NRlaeZUlNv37BiVdjTlyTKC2IGRznG0nemMBVixVcf0H2rTxWh2gSeUqDREgMZIaMyMQkqr8UBD
 o8TTt5YeaVunaK/Tm/04TOUWsyCajzPOCKJKYA9cnPk1pNCHgbldsUE4YKah4pU/ctdvvFN/h5n
 WlIkpkjd5Wvf/Nd7CTlmj2XuXLwn53CPxT2Uz7TdauSJkovhDtwILdAbWbymZBfwvdYkp6qsMWK
 buywzlfhwd1Viul9lpWEhiKHpw==
X-Google-Smtp-Source: AGHT+IGQ+M+aJtsa13W9YCnCVW5sk26dn5TVoNWFyv4d8Ljiqzmt1CyuVjSk3+SyOi2ilZDzup+JDBZYGo3sa2De9ys=
X-Received: by 2002:a05:6402:42c2:b0:63b:ef0e:dfca with SMTP id
 4fb4d7f45d1cf-64076f6605dmr1310080a12.4.1761879216532; Thu, 30 Oct 2025
 19:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-27-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-27-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:53:10 +1000
X-Gm-Features: AWmQ_bmlISCJyOXzUbLWQEnd0TEphlfnTIhBh2Wq3hTtvMmQrdJIg8gYdjI2GC4
Message-ID: <CAKmqyKN=mhU28qBu7Vr_6TOfTOYbsAR0KZCueH3fJEnEhs=7iQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/33] target/riscv: Replace target_ulong in
 riscv_cpu_get_trap_name()
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 28, 2025 at 4:24=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> Fix cause argument to 64 bit to match env->mcause.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  target/riscv/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4c6b977ce2..c2be30795a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -601,7 +601,7 @@ extern const char * const riscv_int_regnamesh[];
>  extern const char * const riscv_fpr_regnames[];
>  extern const char * const riscv_rvv_regnames[];
>
> -const char *riscv_cpu_get_trap_name(target_ulong cause, bool async);
> +const char *riscv_cpu_get_trap_name(uint64_t cause, bool async);
>  int riscv_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, DumpState *s);
>  int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 353b927dd5..3378c40dbf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -348,7 +348,7 @@ static const char * const riscv_intr_names[] =3D {
>      "reserved"
>  };
>
> -const char *riscv_cpu_get_trap_name(target_ulong cause, bool async)
> +const char *riscv_cpu_get_trap_name(uint64_t cause, bool async)
>  {
>      if (async) {
>          return (cause < ARRAY_SIZE(riscv_intr_names)) ?
> --
> 2.51.0
>
>

