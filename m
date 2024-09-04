Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1476CD37B5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 00:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sldoS-0004Er-2a; Tue, 03 Sep 2024 20:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldoR-0004Ba-2S; Tue, 03 Sep 2024 20:23:55 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldoL-0007yP-EC; Tue, 03 Sep 2024 20:23:54 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-846c452898cso104451241.1; 
 Tue, 03 Sep 2024 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725409428; x=1726014228; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgu7zx+zN2nRfcKOqsCjlDsuiQO21wq4ZbmXrNvDF/s=;
 b=LvReIAq8gaGKJjZXVOO8Qe/G7x84Pga1YLX6AXVvSRazTOikoGDZWCqe5niCn8NgMl
 ilhGbcbHGymSSVx7n49kKUsrMpMPE9viTaGFlrDY+NDjwkL34bruzNny4w4AcliJUVSz
 cwXgYsoFo3xbT3UFkhMEpLK291onMUUcQ2Mb+Bf83fVUfAwTOLQ3Yj2Hs8fvHy7X4/h4
 4Q7zZ60hTUb6LI5qlPkd1Ggqo3IFBC4xbTedDr00qMffWjaC7DsJSORWpwcyfv6iEY/r
 6fnXgTA9bRnWGg9cafAAEzaMU8prfvNCaBBhULvnpci8jv2W7mQst/1W+EvuSrWcI1cf
 B+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725409428; x=1726014228;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgu7zx+zN2nRfcKOqsCjlDsuiQO21wq4ZbmXrNvDF/s=;
 b=R9uP2qQC/9kMxOja92036JozSo7nYTnGQdxBZvdJM6nBXfaQO/yrOlzRZ14WY1/GF6
 ypqMFW/XY1n3klBgFjfXccd70ynSlK4tPo94L3Oq9kjLHl13smcr/NYik2Auy3SbdmkR
 xQBwuP7nPMmLmacR9VigO91kmiu8I6ZP5AJ0/xFX9CDelNO20xgys1oxcyX2nYsOqs14
 LXTDS157/5nJSABDCT76K88LJWJh68iIBABWiFolYJfSLk9zcdAdJEY2TqIW1gE6PJeP
 tSezLb74VHF4yoa6KX6xons+8cIx2D4pgu1HLywTYcmSdp9QCcEVpxj1BVI4OnQGDtKE
 pFyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAKHsS2jz5rgoVaYkagWj2+VQbtwTNWlGqgVgRy3gf7nWjR4wzA5TWp6WTOQdsdbUTgCrgCahgLpLj@nongnu.org
X-Gm-Message-State: AOJu0Yzi/mNY+o5fBTvNT66ZfodpyMyOMTgEnemauwEtz3ix5IGac4cQ
 ftj34vfR0JAEma8VK+dZaLjzqZZ6uvXG/WG4iTe1IkN7WEduTKmKDTtwY0HkHM//cnA5uwdwgaW
 VU/sR6WixMQFKJi46fNly1vUc5dA=
X-Google-Smtp-Source: AGHT+IGWt02HsXhhqeqzcZKOw7HImYwOJ0Eu85eKTYu3DyTkgh3Or1MaYNGo8eofzPfXsl5dW9evy63w4fI5CDeD/Bc=
X-Received: by 2002:a05:6102:160c:b0:497:6ae3:e541 with SMTP id
 ada2fe7eead31-49bba74fa45mr176217137.14.1725409427777; Tue, 03 Sep 2024
 17:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240902103433.18424-1-m.klauchek@syntacore.com>
In-Reply-To: <20240902103433.18424-1-m.klauchek@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Sep 2024 10:23:21 +1000
Message-ID: <CAKmqyKM4tkmpr_H9zd2-=LnFaLrLSLWoSjFDXeO3kQx3w+E8YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv/cpu.c: Add 'fcsr' register to QEMU log
 as a part of F extension
To: Maria Klauchek <m.klauchek@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Mon, Sep 2, 2024 at 11:38=E2=80=AFPM Maria Klauchek <m.klauchek@syntacor=
e.com> wrote:
>
> FCSR is a part of F extension. Print it to log if FPU option is enabled.
>
> Signed-off-by: Maria Klauchek <m.klauchek@syntacore.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..6ff6096777 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -839,6 +839,12 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE =
*f, int flags)
>          }
>      }
>      if (flags & CPU_DUMP_FPU) {
> +        target_ulong val =3D 0;
> +        RISCVException res =3D riscv_csrrw_debug(env, CSR_FCSR, &val, 0,=
 0);
> +        if (res =3D=3D RISCV_EXCP_NONE) {
> +            qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> +                    csr_ops[CSR_FCSR].name, val);
> +        }
>          for (i =3D 0; i < 32; i++) {
>              qemu_fprintf(f, " %-8s %016" PRIx64,
>                           riscv_fpr_regnames[i], env->fpr[i]);
> --
> 2.25.1
>
>

