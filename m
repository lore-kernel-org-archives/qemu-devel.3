Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B50C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 06:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6lCq-0008GQ-U3; Tue, 14 May 2024 02:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lCR-0008Az-Vk; Tue, 14 May 2024 01:59:46 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6lCP-0007EE-MA; Tue, 14 May 2024 01:59:43 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4df214fdc37so2661201e0c.0; 
 Mon, 13 May 2024 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715666380; x=1716271180; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzQTeadMyBSlV0uZ4/V8qE9bHEUA1dtv/ZVwMkGdFGo=;
 b=SabxXDbdRvK1z77hZJ++EhQawcc9HZCEe3aaqYdbWGHkrBc4J3V+iwW2H/CgvIjMDu
 26oP7hAj5XIm5Ds/W2+ZmZMIoKlvFEqNkvnRxOBNk5Bwa0nGmUsm5bnF8u4wIGztRu/i
 aH5E89Caizp5X9be2Zm91EbfPM1WdBxYJIWiIJQ+UFog8+0dnfMZC/w6P8jCYB2LyomK
 ivFU8iQYg9p2+wPEpM5bqLCBwW8WXdM2qNxj3m11h9szHr7RtEx70V75zSLiZdh7Zpcm
 V0Kf8MBbmSlG8zvIdA4HlkavPNr9db7gGVB21zRzHzs2ZQxupckAa8pg2XEeHN9HO+qw
 DArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715666380; x=1716271180;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzQTeadMyBSlV0uZ4/V8qE9bHEUA1dtv/ZVwMkGdFGo=;
 b=lM3TkawXGBx9zUvvY0KCiicoVbvNbyApK3atbZhQs3N1Jnz9iM7wKkZmUGneKslFDD
 QBKlODFlXS5jNKs0vrYxRlZ2NzDyAf9D4h6f7bK8SvQkvq9uMwEKOTDVDaJaFwJatB/U
 SXEWPTlllUWROUE4edosabc9YKavuDXWEizC2zwDbRZeOdWPpnpzLfonAwJ5rUs6ZYzL
 yWr2gHqO6+iH04bIfkGAVeSou8AzDJZsyNY+3N1PfHMlA/oKRY/JucAE60t8pUXw/3uf
 5lpPC0pZQ32+h1CtYH0aoNOjtUVku99ZqLXqfE6zCRcXiiGjf0u7cEqakgeIyhKQPWl5
 GXiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpNOS632L7+UeaBu5pjCN1Ru25aGLmL2OGf6dfjia9bbANfbek4KfFgxZt9THDp9MB8aAjpNuP6qF3GU/wLoRNtQgcVss6L1tWInv9UX/SBXDBXgte36Qbx1kug==
X-Gm-Message-State: AOJu0Yw5C/UJ+A4g5v7iT9HgydLFKpfjZpWnMtzkY9oPTHtHrwwjOAT/
 i7fHUmZybIKumJ80gooatzsD8SjSiMMGXqhVh424Ow6Q4ioiRN0GXd14KWyQ9KS6JIMTLShUolV
 MMId40Krc/w8Ne/9OxWf7AbRDs2E=
X-Google-Smtp-Source: AGHT+IFQfoRoJRS5JFURn7TQhTUYlZAgvw3/apQvES9WOKkGsT+W/WnRDx5eEMCVDJ0yclKSJTc/4c57ZcWcsKbs7zE=
X-Received: by 2002:a05:6122:368e:b0:4d4:34b2:9a89 with SMTP id
 71dfb90a1353d-4df8838f6a5mr9800622e0c.8.1715666380402; Mon, 13 May 2024
 22:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <ca275792-36c9-4ccd-b7b2-24d9fd837b24@ventanamicro.com>
 <20240503103052.6819-1-alexei.filippov@syntacore.com>
In-Reply-To: <20240503103052.6819-1-alexei.filippov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 15:59:14 +1000
Message-ID: <CAKmqyKMhSUJForn4eNN2surqjdvJQ9+kXomv+BYTX0G8FXCRVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: do not set mtval2 for non guest-page
 faults
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, palmer@dabbelt.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Fri, May 3, 2024 at 8:32=E2=80=AFPM Alexei Filippov
<alexei.filippov@syntacore.com> wrote:
>
> Previous patch fixed the PMP priority in raise_mmu_exception() but we're =
still
> setting mtval2 incorrectly. In riscv_cpu_tlb_fill(), after pmp check in 2=
 stage
> translation part, mtval2 will be set in case of successes 2 stage transla=
tion but
> failed pmp check.
>
> In this case we gonna set mtval2 via env->guest_phys_fault_addr in contex=
t of
> riscv_cpu_tlb_fill(), as this was a guest-page-fault, but it didn't and m=
tval2
> should be zero, according to RISCV privileged spec sect. 9.4.4: When a gu=
est
> page-fault is taken into M-mode, mtval2 is written with either zero or gu=
est
> physical address that faulted, shifted by 2 bits. *For other traps, mtval=
2
> is set to zero...*
>
> Signed-off-by: Alexei Filippov <alexei.filippov@syntacore.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes since v1:
>                 -Added Reviewed-by tag.
>  target/riscv/cpu_helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e3a7797d00..484edad900 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1375,17 +1375,17 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addre=
ss, int size,
>                                __func__, pa, ret, prot_pmp, tlb_size);
>
>                  prot &=3D prot_pmp;
> -            }
> -
> -            if (ret !=3D TRANSLATE_SUCCESS) {
> +            } else {
>                  /*
>                   * Guest physical address translation failed, this is a =
HS
>                   * level exception
>                   */
>                  first_stage_error =3D false;
> -                env->guest_phys_fault_addr =3D (im_address |
> -                                              (address &
> -                                               (TARGET_PAGE_SIZE - 1))) =
>> 2;
> +                if (ret !=3D TRANSLATE_PMP_FAIL) {
> +                    env->guest_phys_fault_addr =3D (im_address |
> +                                                  (address &
> +                                                   (TARGET_PAGE_SIZE - 1=
))) >> 2;
> +                }
>              }
>          }
>      } else {
> --
> 2.34.1
>
>

