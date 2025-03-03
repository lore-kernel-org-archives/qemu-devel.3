Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878C8C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 03:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1towl2-0004s6-DM; Sun, 02 Mar 2025 22:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1towkz-0004oo-VZ; Sun, 02 Mar 2025 22:46:18 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1towky-00019L-Ci; Sun, 02 Mar 2025 22:46:17 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-86112ab1ad4so1590997241.1; 
 Sun, 02 Mar 2025 19:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740973574; x=1741578374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEAXt9L3I4OOaQ0DHWIa7RPZyHKscU9SZ48KICxMklc=;
 b=BNhhUsq+MpJUlPhRCai9LuGP3OsLbvOr25Oi1JnP8YW1FA7jkZ1fAzzN29ixWG6HJs
 nbjl600dbSH9rnAJUBy9tF5MZ0i4XgY+idw+L/Dv6YnXomtXTQpj4UzsnesIxt20ZTS7
 7se6Gibz5m8D5cDaJYDVcq5CTn8XvymMPHAoLBiKQUFxNy/9FCtRPFBPmWufL0BGllb7
 K/MjDHRgvaAhQDk2PES8R0OhBpD5EkPnUtNSYGEiuBntvNXgoYRWIJDWpK7QGTv1sKo6
 Erqa7PabwmWeNMXvCzau53EfiYZnz9iKJbk3PHYOshUomI/WrfbVe1df7MvzDG4oGrFU
 znug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740973574; x=1741578374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEAXt9L3I4OOaQ0DHWIa7RPZyHKscU9SZ48KICxMklc=;
 b=ACAGseMEvPfJKMeKe6Yz1LqYnssZMNtFg9fQ+M5bW4vHvgmq6BekkQwwx6rjp2NPzc
 zKcIZmvx1Ou2LSDVQlhETYL02Dob+kg8krZnNqqWN/v7CdjQdJmm9TfZSNS5blNH4y7E
 vzVe8ujDE/CDTwQStdsatXUJZjixBoR3HZpyvHDfHAIzx+nwaGSR/NiSDaXtMvkoKDwZ
 W0AuD/LzWKR8eV+Xw5TRAe3QFzGvRlJJWKv7jBF0sVZhSGm6w+1yfjXpcFhFHBrTWs0E
 XiGXu5FQkk9nrgwBk94NAyFsaezwVvy/ZYIlM2UZCz67EbZzX+UbHWH5Ry0grsRiPZl1
 OIHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW29Tl1FTOOsJzxnAmct9l852Pq43Ie0eWMfd9LK5AP4WWY1Pg0t6r7Y2g/ZTdRyXeqJ82gigo23JmB@nongnu.org
X-Gm-Message-State: AOJu0YyLGBntQ65tcvAfuIinAZLJwHYEz6Wbhjcog1680hj/6FnJq7Pj
 xTxMqJPqiwqUWg4d9nv3hNu3AjKia0v7DzpaFU/UdzafV6l+tnWY/8KTsfUhTjgpPi0IPeXPvS1
 4a26G80/e0woY9lL7AeQ54az5p2o=
X-Gm-Gg: ASbGncvptIpTmUEQd99aL8IyxatJ0HbuX6iW4m0KfrUVyu1G0eC5ES2fxegWcFBx9Un
 5MMhg9Mu80+/kLWf90IDQHj36jrU+OfCFB64le5YqnbsxpeX2WjXUpUeNOisXJX3GEs+eatc0bY
 CPCeZTbbGrMvCJ8IUmBrx0sKEW9of5t6kT3kUI9+QrdZZxNfA44Us68hrk
X-Google-Smtp-Source: AGHT+IEdyisjyNxcj16lhreUSuI6PLSY1Fye3CN8YwO465hr56BemCNCEWGZoMzrLE21+G6o2V3ohWYPz7gOcswtLEk=
X-Received: by 2002:a05:6102:c15:b0:4bb:ce42:40e3 with SMTP id
 ada2fe7eead31-4c044eda1b8mr7887178137.17.1740973574616; Sun, 02 Mar 2025
 19:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
 <20250224123120.1644186-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250224123120.1644186-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 13:45:48 +1000
X-Gm-Features: AQ5f1JpCtG-tuBXkHOnglOluZv2id_codiMMvG43x74tIczeFc-8JbwQDP-yYxg
Message-ID: <CAKmqyKPtYNnSZjsVR3v+mB-dQXYxRSRtVntsG6JkgP+HObYv=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv/kvm: add kvm_riscv_reset_regs_csr()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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
> We're setting reset vals for KVM csrs during kvm_riscv_reset_vcpu(), but
> in no particular order and missing some of them (like env->mstatus).
>
> Create a helper to do that, unclogging reset_vcpu(), and initialize
> env->mstatus as well. Keep the regs in the same order they appear in
> struct kvm_riscv_csr from the KVM UAPI, similar to what
> kvm_riscv_(get|put)_regs_csr are doing. This will make a bit easier to
> add new KVM CSRs and to verify which values we're writing back to KVM
> during vcpu reset.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 19bb87515b..cabc34b6a2 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -608,6 +608,19 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>      return ret;
>  }
>
> +static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
> +{
> +    env->mstatus =3D 0;
> +    env->mie =3D 0;
> +    env->stvec =3D 0;
> +    env->sscratch =3D 0;
> +    env->sepc =3D 0;
> +    env->scause =3D 0;
> +    env->stval =3D 0;
> +    env->mip =3D 0;
> +    env->satp =3D 0;
> +}
> +
>  static int kvm_riscv_get_regs_csr(CPUState *cs)
>  {
>      CPURISCVState *env =3D &RISCV_CPU(cs)->env;
> @@ -1612,14 +1625,8 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      env->pc =3D cpu->env.kernel_addr;
>      env->gpr[10] =3D kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
>      env->gpr[11] =3D cpu->env.fdt_addr;          /* a1 */
> -    env->satp =3D 0;
> -    env->mie =3D 0;
> -    env->stvec =3D 0;
> -    env->sscratch =3D 0;
> -    env->sepc =3D 0;
> -    env->scause =3D 0;
> -    env->stval =3D 0;
> -    env->mip =3D 0;
> +
> +    kvm_riscv_reset_regs_csr(env);
>  }
>
>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
> --
> 2.48.1
>
>

