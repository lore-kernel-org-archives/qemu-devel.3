Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DBCC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 03:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1towm4-0005lT-FQ; Sun, 02 Mar 2025 22:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1towm2-0005lB-Lp; Sun, 02 Mar 2025 22:47:22 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1towm0-0001Lf-OV; Sun, 02 Mar 2025 22:47:21 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5238b366e2aso670205e0c.2; 
 Sun, 02 Mar 2025 19:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740973639; x=1741578439; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnc45QwpSiCOIZucKqCSWUjL1Y/kGJU2Ns9Qg4GV0wc=;
 b=Ov673oGFpwgaqTXmegHXoSvmgqCBjlgFJJDju2VZmpjxYcrIhVwvSMLVbSmc4kBrDE
 Elb4ve7i+AVhFuQpvk3/jz6me67I6fUjMQyoaqBCDQP2kIaiBc9kjbGpO8FmarEK0Uxs
 6FgXoEKcSvttJZdS/i2CoPe3paS5YGGFYs5Yy/an9fnlATJoh3RAZ7TEjzmJqr/F+rC+
 I90evGrkGyy9fw0YUaZwmcHpcNVNn9BrL6wkU3lsjumoQ7aVP95lnX7OJdMAVu9YHRhd
 F0GFugpb95aREMAvWWT8HJGi4aTAOQy/7Yh49XkKp3064+K5nUj3QMu7JYaU2L3u0EPK
 C3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740973639; x=1741578439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnc45QwpSiCOIZucKqCSWUjL1Y/kGJU2Ns9Qg4GV0wc=;
 b=hQ60S1TJ5L+HqUd3c6B6ELm+rAPVZWYfCFIOtd2yjAXtCj+dILSYwOILRWewKdtFPl
 +xGUTaeaPNiM3UqNDPFVq6y5OoEwr1hM5wgO6vJ6AtJIoVgde5D7CK0x6QLC2HlKnn37
 qa8eYTrZgBmyz2Z7yz9fcy3MCNvfSPkIUtO2x5mpjdxgV9Vfnt+wgEi5z9EEoJEU1SNO
 pYwGQaiRt0OCSXRle7xnmjOsT8VrwRE0UCRcUSGR+nGlZWIoOyljMkxPdaH7wtgY1ZqC
 hITj3AJWBK1Mz6QNXUOEmvby0WAwe2+50oaN+9UBCkNUxYx01t0AJMguYyGyIZjIUj7V
 8LfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2MlDu0o7TDPoOcSG8HA1NkIk4ncfgamUkCLCpNJo6CkKTZO8zhKcmmt7kPLSi27u6CjUdR5Je/vYy@nongnu.org
X-Gm-Message-State: AOJu0YyOF22fwgaJ6qFxPR6la1NnA1qoAaFFir5dcS0ZJ/nE/VnbFaVy
 0M7KfD57l7omaE/WaIWVNbC4IN6i3DXo5vBooi4PaQT1gTar7Q3RlFjnaqq057Pixjm616LLVyG
 VIL5gteiYX2aZY2LmbkCJapYGPFI=
X-Gm-Gg: ASbGncvCOgvhyFjgQcp4YCY3U1wh4UDPW9Y9hDRCTuxbe5FVRH0s24DYbLQWssqSRwZ
 /zey4aOiPp6ECD/4ZVIIhEdLWwcK/Li+nys1nWTBBONx5JG8vvSiG4svG32jSfKxPTzvxb/bClh
 vaq7rCnI+FL3cLQGy2HWdK0rSKPUn5+RgcPI5R2Irk0ATck+fQLVKJky/1
X-Google-Smtp-Source: AGHT+IGzgPOdt2ru7FPUmv16YDJtbfQY0WKOq1pMzzxmg+mjsE16QxDZWndGW04+d8ATeGzJ+X6vRm7XnvGgy1vQYlQ=
X-Received: by 2002:a05:6102:5789:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4c044d5c5edmr7758875137.19.1740973639285; Sun, 02 Mar 2025
 19:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
 <20250224123120.1644186-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250224123120.1644186-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 13:46:53 +1000
X-Gm-Features: AQ5f1JrZnkb0KHxLx7c22nSdCTwkqu_MqOTIlEnUp81mRAjDxIQcPfurQoYLetU
Message-ID: <CAKmqyKNmpRA8kphbWnA-AqTSUSGf+koSbCmuk6VgZEWde2NFBw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv/kvm: add missing KVM CSRs
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Mon, Feb 24, 2025 at 10:32=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're missing scounteren and senvcfg CSRs, both already present in the
> KVM UAPI.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index cabc34b6a2..e8c31a32d4 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -619,6 +619,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *e=
nv)
>      env->stval =3D 0;
>      env->mip =3D 0;
>      env->satp =3D 0;
> +    env->scounteren =3D 0;
> +    env->senvcfg =3D 0;
>  }
>
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
> @@ -634,6 +636,8 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
>      KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
> +    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
>
>      return 0;
>  }
> @@ -651,6 +655,8 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
>      KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
>      KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
>      KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
> +    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
> +    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
>
>      return 0;
>  }
> --
> 2.48.1
>
>

