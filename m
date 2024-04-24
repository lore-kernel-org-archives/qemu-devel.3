Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5C9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 00:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzQH5-00087Q-Kh; Tue, 23 Apr 2024 20:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rzQH2-000872-Ma; Tue, 23 Apr 2024 20:14:08 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rzQH0-0004xC-W1; Tue, 23 Apr 2024 20:14:08 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7eb89aa9176so1876119241.3; 
 Tue, 23 Apr 2024 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713917641; x=1714522441; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bqux2F1GZ9uFOQ6wr08fmB0cKm4rga5TZUBfcEt/pTM=;
 b=OIxaxR044qPP3MBC5b10sl2Znyi35142kFbgUR64I98kPcr98TWig9xSEsArUZ5gcN
 jO2CYR6+fyGK6Kva5BVa608YVqiEAY2BuvA2ERBdopUSjuAWR+/BaqDa2OI6OPQXAVyW
 0msLd+PfoMZZLFDauvwAREoxi9IWHbRvcWgu8Nk5eOwDLN80YA9+gWGEjQ7mvC+8FeTl
 3sg4xWhuqhqFDNEJ5H1elQ2pEtXSWYm3rI2kFMFYHFuqLmlD5zu8fNrRTsDwvtFy25R5
 0j1w1CEnH8C3HAPEUN/KIczJC+ylRRjU1gvkuEXpInyXyhTkx58TXQm9x3xHgWSfrtYu
 VjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713917641; x=1714522441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bqux2F1GZ9uFOQ6wr08fmB0cKm4rga5TZUBfcEt/pTM=;
 b=ERJ9WgKlFAL68e/4W6r2n1+pfICsw6JkhmXYIoOzNSwJQupASaNtx0H0wRqwqDq77T
 m9+olo5xPg0IX00CoOZSghzw9EoZcES9ktKhqDkbWAMQAy8jnJxuC+TK5t4tFzShoIaQ
 thIz3V50bwdoM5SwEQ7mq4G+GxbnctpgtrLN2KK+qSFCIVadvY8lJcqk0ZznhYnWez0v
 DSVK6LBLjsXsRKbIxUhBmddNBOd4onSaFKt2XIV3vZgAiJtoQAd86M9PEWasDrS0f4MF
 hG+lIl9L774eJ1shobZ4KnaWInPnHcFhEYWqHxpsrtSiDkZOYB7LpW+xuDW81M35fRub
 EtqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSz7TmxUoUGxRbVd3sRdKo0XZrPODHiMj5XNDKvvfuyJ8yAQDMO4pcZm/kUF9YcaRmafZrZnWeH1stabfXUxLzWnM/QG0=
X-Gm-Message-State: AOJu0Yy/gVo8D8l9eTmQ90nLhFPMQJPWGSsBRCgQVjaNaNSiqknUAn1T
 3ieKXHI/eOsn6K5aiV9Xvvk+WCwsUNdnkrcXPxo7T4Pvfsw7bCPIU+jIUQg6r+zBJkQ7WR2b7sn
 7fWM9YD/Zwfee6mP9yMoAjeqfwtVcA/V+VOg=
X-Google-Smtp-Source: AGHT+IGMYdKNzgEndLXYzaR9CjeGefEYs3SAXBgzbawvIEdyZ6B8UTsDCYa45izD1Q1jsO7sf/O3L6+QPc4kxr3pdVY=
X-Received: by 2002:a05:6102:26c9:b0:47b:d34f:a4ca with SMTP id
 m9-20020a05610226c900b0047bd34fa4camr1342382vss.30.1713917640817; Tue, 23 Apr
 2024 17:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240422134605.534207-2-ajones@ventanamicro.com>
In-Reply-To: <20240422134605.534207-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 24 Apr 2024 10:13:34 +1000
Message-ID: <CAKmqyKNX=gnWgTBDp60W_iZk3aEfcNbvfhB+N6ZoWvkQdwxgkg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: Fix exposure of Zkr
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 kvm-riscv@lists.infradead.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
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

On Mon, Apr 22, 2024 at 11:47=E2=80=AFPM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> The Zkr extension may only be exposed to KVM guests if the VMM
> implements the SEED CSR. Use the same implementation as TCG.
>
> Without this patch, running with a KVM which does not forward the
> SEED CSR access to QEMU will result in an ILL exception being
> injected into the guest (this results in Linux guests crashing on
> boot). And, when running with a KVM which does forward the access,
> QEMU will crash, since QEMU doesn't know what to do with the exit.
>
> Fixes: 3108e2f1c69d ("target/riscv/kvm: update KVM exts to Linux 6.8")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.h         |  3 +++
>  target/riscv/csr.c         | 18 ++++++++++++++----
>  target/riscv/kvm/kvm-cpu.c | 25 +++++++++++++++++++++++++
>  3 files changed, 42 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 3b1a02b9449a..52fb8c15d08f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -821,6 +821,9 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operation=
s *ops);
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask);
> +
>  uint8_t satp_mode_max_from_map(uint32_t map);
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 726096444fae..829d8346ed4e 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4267,10 +4267,8 @@ static RISCVException write_upmbase(CPURISCVState =
*env, int csrno,
>  #endif
>
>  /* Crypto Extension */
> -static RISCVException rmw_seed(CPURISCVState *env, int csrno,
> -                               target_ulong *ret_value,
> -                               target_ulong new_value,
> -                               target_ulong write_mask)
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask)
>  {
>      uint16_t random_v;
>      Error *random_e =3D NULL;
> @@ -4294,6 +4292,18 @@ static RISCVException rmw_seed(CPURISCVState *env,=
 int csrno,
>          rval =3D random_v | SEED_OPST_ES16;
>      }
>
> +    return rval;
> +}
> +
> +static RISCVException rmw_seed(CPURISCVState *env, int csrno,
> +                               target_ulong *ret_value,
> +                               target_ulong new_value,
> +                               target_ulong write_mask)
> +{
> +    target_ulong rval;
> +
> +    rval =3D riscv_new_csr_seed(new_value, write_mask);
> +
>      if (ret_value) {
>          *ret_value =3D rval;
>      }
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6a6c6cae80f1..50bdbd24a878 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1418,6 +1418,28 @@ static int kvm_riscv_handle_sbi(CPUState *cs, stru=
ct kvm_run *run)
>      return ret;
>  }
>
> +static int kvm_riscv_handle_csr(CPUState *cs, struct kvm_run *run)
> +{
> +    target_ulong csr_num =3D run->riscv_csr.csr_num;
> +    target_ulong new_value =3D run->riscv_csr.new_value;
> +    target_ulong write_mask =3D run->riscv_csr.write_mask;
> +    int ret =3D 0;
> +
> +    switch (csr_num) {
> +    case CSR_SEED:
> +        run->riscv_csr.ret_value =3D riscv_new_csr_seed(new_value, write=
_mask);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: un-handled CSR EXIT for CSR %lx\n",
> +                      __func__, csr_num);
> +        ret =3D -1;
> +        break;
> +    }
> +
> +    return ret;
> +}
> +
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  {
>      int ret =3D 0;
> @@ -1425,6 +1447,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_r=
un *run)
>      case KVM_EXIT_RISCV_SBI:
>          ret =3D kvm_riscv_handle_sbi(cs, run);
>          break;
> +    case KVM_EXIT_RISCV_CSR:
> +        ret =3D kvm_riscv_handle_csr(cs, run);
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                        __func__, run->exit_reason);
> --
> 2.44.0
>
>

