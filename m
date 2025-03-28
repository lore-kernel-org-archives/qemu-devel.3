Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333D1C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 05:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty2Va-0000o2-MT; Fri, 28 Mar 2025 01:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty2VS-0000nT-1n; Fri, 28 Mar 2025 01:43:52 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty2VP-0005A9-06; Fri, 28 Mar 2025 01:43:49 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-52410fb2afeso1654674e0c.3; 
 Thu, 27 Mar 2025 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743140625; x=1743745425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StvYwY/2LWm1fNI2KlFz/UUHL1WSy/Z8HGp70HtoWyU=;
 b=EfwcmVOF3ZANJDTjnhtFeyTe7GV1NmB0zHH2C+R8b9QymUP2j5hRorZIn3pxVFHF3N
 P+tF2oFV9T94gLvVce+e7PZ1IFccxePRfpD8vglP0Qnn+BmxISA1ZCXIuIOb6gw40Uk1
 iKtWkRGf3BoS5sJ0Q01Og5JJT/5zSAS5iE7mHE/toqja2sXDr2vOqxzW2U11cRJoRJ30
 NU8ZoOB2gGq8MPJDD4My5PnHH+lG5VkiywSMsHsJbuTEH66E3UVLbLnenen2sPR9ZArI
 vY1VX8y56P8IemFx/WCnY2rvz05CgJmmevAYpSi33tn9xsVGQLOid0FhiNBBvYa0LEYl
 6iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743140625; x=1743745425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StvYwY/2LWm1fNI2KlFz/UUHL1WSy/Z8HGp70HtoWyU=;
 b=KCacWlBrvvFsvzxLpXAAw5R6H2sO0tiApyd/bfA7lvRPF0ftiph0VhO8Ww6GTjuVhz
 j28e/P9588sIKe34e3oWriQkBTtWHmEp+ygLnbuYRSAottv55sMasRkfMK0/HvXklZhw
 UOEFjMWPovJ+2+ENuMCyFT0lptUN3Rj4XJmljxSZksufa/FO7xptk5wRPVVuUHT5v2iB
 C/6nYGxk+4P8iuEPMBmmLShAElcJ5Q2AApyzOd9FMUvnejj1ZfczmVgtgIJ2e6e3ke00
 BQDjChd2JshkjLWzJIUGpu353oica16yhvn/1U5cWLj0O675FgWvLVh6ywHknbiRi3Av
 cCpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj7PsAI/mFgxn2ffHuMFQ6or9F93pmtX9GC4wARsPHyBOpAfjkEsNpc36C1oo5UHF8obtveIdxmiUP@nongnu.org
X-Gm-Message-State: AOJu0Yyp3y1bVXpi+NPUtrZdChnMmyknLvrPygdjqM9J6BUabk9lGBEy
 QpqDxRRjUKx9n12E7yeAm8yA7FhymMfBXRpYLW64P6psVWpKLk6o7mnqVV4ieKNKFgb5JrMyTA4
 jttdyuVdrPVIyl8d0Lgm4oRxnZgIRjg==
X-Gm-Gg: ASbGnct/gqthR6hD9uxvQyei8pk6zTZMJDSEmdknrYwEjOQEG+wU53yRQ9Y8Zfv458P
 qdlf7562SuTjJt3mN33XUsKt0mTZpe/uuDnBZvOlrQonu6MiQOFZ7udjpkJu4UIwLJJKfJ5YMlo
 2BAom0H7ZyAeSqPRXjL8vdCp0imCT/AcccQC/4g0Q9jq5GJG+zK42ZcrO+
X-Google-Smtp-Source: AGHT+IEz5TIZO5FJc+dnCwia8VIm7oGnit4e3REtU6pk3NytoAKVfJcmBdWReBZPLD17fbt28iuy8Ti0E+ed/QHFcT0=
X-Received: by 2002:a05:6122:8c03:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-52600ad8495mr5269734e0c.10.1743140625195; Thu, 27 Mar 2025
 22:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250327152052.707657-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250327152052.707657-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Mar 2025 15:43:19 +1000
X-Gm-Features: AQ5f1JqzHituek92vOMHfo3TSNogh-9uZUD_IaJSPPecwrBYCVGnoPqTIhD6igQ
Message-ID: <CAKmqyKN-ATz-Lm=nC3NEOebRkzk6yco=pp-LUy0BYuPE+gpwOw@mail.gmail.com>
Subject: Re: [PATCH for-10.0] Revert "target/riscv/kvm: add missing KVM CSRs"
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Fri, Mar 28, 2025 at 1:22=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This commit breaks KVM boot on older kernels, like reported in [1], due
> to senvcfg not being available in them.
>
> There's also another problem related to scounteren. Using a recent
> enough guest buildroot, 'ping' will be build with rdtime support. In
> this case, doing a ping in a KVM guest while exposing scounteren will
> result in an error. The root cause relates to how KVM handles
> scounteren, but QEMU can work around it by initializing scounteren with
> the host value during init().
>
> Fixing these issues in a non-rushed-bandaid manner results in an amount
> of design changes that I don't feel comfortable pushing during code
> freeze, so for 10.0 we'll remove the CSRs and re-introduce them in 10.1
> with the adequate support.
>
> This reverts commit 4db19d5b21e058e6eb3474b6be470d1184afaa9e.
>
> [1] https://lore.kernel.org/qemu-riscv/CABJz62OfUDHYkQ0T3rGHStQprf1c7_E0q=
BLbLKhfv=3D+jb0SYAw@mail.gmail.com/
>
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 4ffeeaa1c9..0f4997a918 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -624,8 +624,6 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *e=
nv)
>      env->stval =3D 0;
>      env->mip =3D 0;
>      env->satp =3D 0;
> -    env->scounteren =3D 0;
> -    env->senvcfg =3D 0;
>  }
>
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
> @@ -641,8 +639,6 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> -    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
> -    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
>
>      return 0;
>  }
> @@ -660,8 +656,6 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> -    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
> -    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
>
>      return 0;
>  }
> --
> 2.48.1
>
>

