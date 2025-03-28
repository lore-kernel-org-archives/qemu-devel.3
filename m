Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F76C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 04:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty1ig-0000m2-Fq; Fri, 28 Mar 2025 00:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty1id-0000lp-FJ; Fri, 28 Mar 2025 00:53:23 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ty1ib-0007Zm-R6; Fri, 28 Mar 2025 00:53:23 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-523de5611a3so840790e0c.1; 
 Thu, 27 Mar 2025 21:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743137599; x=1743742399; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEe3dfa3nTtAlmftqN2HENYJ9hzxZsKKdkJFR9UILak=;
 b=em7/NkoW0gZL43S3bEI+AmMX8ZIp/NLrtmU7qGFVMUGNL/lKIJD/kpC7dw/YteaB1o
 +15bv5sC+bxNd2f6v0pl7NzQ1IZS+NWowC3+1XDCvDEGRermcLQhY2otE/VKvfHD0EDP
 sKj2RT4JiwoKAm9G369vGPfOtXof8FBxxbrLNyBzisImlPta7YpgiQ4pNWEPHL4cL2ut
 kyOvTY013JRrh0yhnLYLhMXSvUj12S7H6gPJslPz2oe01yyyOCDQX4YT68nh9n2+MSZD
 eVyE/Fl8wouQCjCOEBIXkY3az9JsFdCD9E/uvdLuQ4AUigD2Il9YzF/d6usH5O+HITqd
 zBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743137599; x=1743742399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lEe3dfa3nTtAlmftqN2HENYJ9hzxZsKKdkJFR9UILak=;
 b=WYjvaM0L7BEGMl3YM1dTRkLVPmFTK+S1EKMbTcf+Mb8fMBoaD2at37fyFfCXqPpmSp
 HvmZKuPS7Ir1jYMJ+V/pmn68ggSXOWvO4KtznHMcX56HrJCmbkOHEBzS7aYuDGW6KJmW
 bAgyttT95eT2DfyA285GaPFjgBZGueriea7vbLiE5kZBfQgKroTx2RLLFH7REJb9iN4v
 JhoULA/mkqxG1bSOJPLEJvbMimXntaoMFcT47S2vgRijCm1D8l02axWG/DEQ6+Ykbb0d
 YoKgPHrHP4F6E/h+L3z16uAb8jdMjbghpCPm1/cqCCB5hqQm+6wjD51NILKSR5mYZMu0
 4oeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+JO6xJW2QoEG25sKkIyw7RkWEGnWim5tbP8jZ1f01Xl1rqz/AaSruYBl/oIYmLOuHuMErnEUmbpiq@nongnu.org
X-Gm-Message-State: AOJu0Ywu4j43ShzECR85RgcxBJmgP3zlGOgkPP/IUo46t9RsBAqR3wIY
 KeThyRFFHxSH6S4CCWo5uS3aBiF7Cq1CgWPtD8VtdHZO9RoLwD1Lwns6sf2m1FPQiI2SI8dqocc
 G11JqmYrlWivgjUP8JiziPDIcx4pNHA==
X-Gm-Gg: ASbGncuiBivo9Z+HgiFfW0vnbH05gGgOOu0yEP9dmQisCXbAOfMRy5EyPJ+y+oB9Lyi
 ZV5pLEmqLaAVrEqp01VNmo1zp4C1QNc4hwMwnetOTdCtCUbM0qIuc47Hkq92P1qFsiz5vqyR+dA
 +vZeDJuQPZLqa2vkCHv45NEsKlt6AFotjXRGYB+M/AP0COJW6Qk+315AXT
X-Google-Smtp-Source: AGHT+IFoi2oYAkI5E/qwgaZ2y6SdDFiDz/RSF2QRPfl/ZxsHQShiUCAedkJZYTW+NH9ZlIGyCSk+vxD0aPZyG9wvAUk=
X-Received: by 2002:a05:6102:149b:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4c586f1e376mr7647663137.2.1743137599144; Thu, 27 Mar 2025
 21:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250327152052.707657-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250327152052.707657-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Mar 2025 14:52:52 +1000
X-Gm-Features: AQ5f1Jpc7CcO1E774T-xcR_EkuZWJPRu-3mAI59lSRzfWKM6oCpEOQmyGfJSlvY
Message-ID: <CAKmqyKOVzNRvDT0L9T7aDHdPH_f5or47kx2csfU5bzmG9Jp=ZQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0] Revert "target/riscv/kvm: add missing KVM CSRs"
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

