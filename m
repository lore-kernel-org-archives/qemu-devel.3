Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441DBE8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaB37-0007g2-7a; Mon, 29 Dec 2025 06:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB35-0007fq-Ip
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:04:27 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaB33-0003DR-RL
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 06:04:27 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b7ffa5d1b80so1135030066b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 03:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767006264; x=1767611064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXwawnmp4nBE/Ru+wI3DJQ1CWQS+qWsqn4VLj9jjCnY=;
 b=iUk5nvTWcdIvs13krV8LGtxg5VsbpMbCeTpztkxKwQB6GReo3BQDAbWy9OIm6Qd0v5
 B2xEYBV2SLjOufto30Sqprrwzcb7yOwAv1djDowK9dMf+tLJb7VBvnpfUdV4YvpDnS0B
 PQYYcOdWvtwz1RpHdKR6acAT7OHf2ZpiqcCQkGJD+a4Ol0T6PlaChyrhVFJaiVWhxECx
 VmZfbp15V1PZSWZUbIzMFUacsjmIAwO/jkFB0DSEecUraQkIIzOVxdJtFuefBSEtLlst
 KlxE5IT7b79jSFocYN7EBI1y0qNJXqfFVc95bcPaO20eISzxYre9wDViz6o0wEwloExv
 6mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767006264; x=1767611064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zXwawnmp4nBE/Ru+wI3DJQ1CWQS+qWsqn4VLj9jjCnY=;
 b=IhzeHiFv79MVHnqWiKv27+JojVzXoW/QZYS6vivVAR/xJgR58YllMX2JxyqJI4kHEH
 50lpHSsh91ixJ5aXeABh9kxxhkPDeuyCOlYgTL+xbJ02Nm70mD9p/9f8rGbIl35Ou/qM
 BgVFCEo3wLRZtdBPctdPJ61F5W6DTXHX6yLAsSzYXIhWwCdBuge4YU/nQlvZc5Eqbo3f
 N1aVcQ+QE0WkVKjC4MgJcvrw6fucwJOL4y6yMNYBWYi8qrNP+gKG9JtEIStR5hlgkl5x
 onzbv1b7Kjbhiy15B7NmSv7T0+9ixjqN15Ikl6MOlA/K/b6U+7xYthDuAnIllnGzLwlu
 AZkA==
X-Gm-Message-State: AOJu0Yxz+ZocYDDi4KcqrF7vwVL6LjK5ksPZPF+ZKyythgr9HSlb28XI
 TzrY75Btxp6RJYcKPGODTBuDtQzFqC26pnU8aC/2XRksZn3PtOyj7H+aB7LSOXsRXvg3+nIv0ir
 SNhbPiewjIheUwNhkrGUgjn5NTef59J5IX1Ht5NJXDQ==
X-Gm-Gg: AY/fxX4o9kouKy8aQuW6DxWKi4E1Sr6ygZqCpQoXRTK3qeYdxmti6/BdPb6ao8hC5nq
 XqSJ5639Ju5bj6no78X7uPDlcIKW154Sp3gtF4XJQY7eUzwEE45ESy5Xe5iZ1m1xGvFSCAEHVdd
 g18Ox8jGq4jYJM1kLhxqOpGpXX93geO/Uv5DBPkZBKiO13woK7AuywNkjw/dXYe4UPe8tUv7zTI
 Vb8aB0HMI5bT0QLwRSqxZDCnmkqFpQBBRIv9uxUkYFpvjE6GXggmAugx4UvupRR8AYrpmo85NbI
 gRbhq31mDzRtA6URoCTWzglyci0PdCDIlcUESRc=
X-Google-Smtp-Source: AGHT+IEwJJq7kBp4gYgYA9c+30flCa3tEWYDqrfvQq50/rY8VDZJV6xQEXlRJhk2D+jT1DorC6fVzS4uGxMhtNssZ6I=
X-Received: by 2002:a17:907:268c:b0:b76:339b:d681 with SMTP id
 a640c23a62f3a-b803695c31cmr2983236066b.0.1767006263809; Mon, 29 Dec 2025
 03:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20251224162036.90404-1-philmd@linaro.org>
 <20251224162036.90404-4-philmd@linaro.org>
In-Reply-To: <20251224162036.90404-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 13:03:56 +0200
X-Gm-Features: AQt7F2rghdt1_EtmPLi1K1Qd6l57HBo0YnCi5U1IRXG-w5pubXXTLSg756HMS3Y
Message-ID: <CAAjaMXbre_ntCh6sT8RjGFT+SAC3zV5XgZPr_t3oOT0VXP6cSA@mail.gmail.com>
Subject: Re: [PATCH 3/8] target/s390x: Replace gdb_get_regl() ->
 gdb_get_reg64()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Dec 24, 2025 at 6:21=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> We only build s390x targets as 64-bit:
>
>   $ git grep BIT configs/targets/s390x-*
>   configs/targets/s390x-linux-user.mak:6:TARGET_LONG_BITS=3D64
>   configs/targets/s390x-softmmu.mak:5:TARGET_LONG_BITS=3D64
>
> Therefore gdb_get_regl() expands to gdb_get_reg64(). Use
> the latter which is more explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/s390x/gdbstub.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
> index 6bca376f2b6..d1f02ea5ce4 100644
> --- a/target/s390x/gdbstub.c
> +++ b/target/s390x/gdbstub.c
> @@ -34,11 +34,11 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>
>      switch (n) {
>      case S390_PSWM_REGNUM:
> -        return gdb_get_regl(mem_buf, s390_cpu_get_psw_mask(env));
> +        return gdb_get_reg64(mem_buf, s390_cpu_get_psw_mask(env));
>      case S390_PSWA_REGNUM:
> -        return gdb_get_regl(mem_buf, env->psw.addr);
> +        return gdb_get_reg64(mem_buf, env->psw.addr);
>      case S390_R0_REGNUM ... S390_R15_REGNUM:
> -        return gdb_get_regl(mem_buf, env->regs[n - S390_R0_REGNUM]);
> +        return gdb_get_reg64(mem_buf, env->regs[n - S390_R0_REGNUM]);
>      }
>      return 0;
>  }
> @@ -190,7 +190,7 @@ static int cpu_read_c_reg(CPUState *cs, GByteArray *b=
uf, int n)
>
>      switch (n) {
>      case S390_C0_REGNUM ... S390_C15_REGNUM:
> -        return gdb_get_regl(buf, env->cregs[n]);
> +        return gdb_get_reg64(buf, env->cregs[n]);
>      default:
>          return 0;
>      }
> @@ -227,13 +227,13 @@ static int cpu_read_virt_reg(CPUState *cs, GByteArr=
ay *mem_buf, int n)
>
>      switch (n) {
>      case S390_VIRT_CKC_REGNUM:
> -        return gdb_get_regl(mem_buf, env->ckc);
> +        return gdb_get_reg64(mem_buf, env->ckc);
>      case S390_VIRT_CPUTM_REGNUM:
> -        return gdb_get_regl(mem_buf, env->cputm);
> +        return gdb_get_reg64(mem_buf, env->cputm);
>      case S390_VIRT_BEA_REGNUM:
> -        return gdb_get_regl(mem_buf, env->gbea);
> +        return gdb_get_reg64(mem_buf, env->gbea);
>      case S390_VIRT_PREFIX_REGNUM:
> -        return gdb_get_regl(mem_buf, env->psa);
> +        return gdb_get_reg64(mem_buf, env->psa);
>      default:
>          return 0;
>      }
> @@ -279,13 +279,13 @@ static int cpu_read_virt_kvm_reg(CPUState *cs, GByt=
eArray *mem_buf, int n)
>
>      switch (n) {
>      case S390_VIRT_KVM_PP_REGNUM:
> -        return gdb_get_regl(mem_buf, env->pp);
> +        return gdb_get_reg64(mem_buf, env->pp);
>      case S390_VIRT_KVM_PFT_REGNUM:
> -        return gdb_get_regl(mem_buf, env->pfault_token);
> +        return gdb_get_reg64(mem_buf, env->pfault_token);
>      case S390_VIRT_KVM_PFS_REGNUM:
> -        return gdb_get_regl(mem_buf, env->pfault_select);
> +        return gdb_get_reg64(mem_buf, env->pfault_select);
>      case S390_VIRT_KVM_PFC_REGNUM:
> -        return gdb_get_regl(mem_buf, env->pfault_compare);
> +        return gdb_get_reg64(mem_buf, env->pfault_compare);
>      default:
>          return 0;
>      }
> @@ -330,7 +330,7 @@ static int cpu_read_gs_reg(CPUState *cs, GByteArray *=
buf, int n)
>      S390CPU *cpu =3D S390_CPU(cs);
>      CPUS390XState *env =3D &cpu->env;
>
> -    return gdb_get_regl(buf, env->gscb[n]);
> +    return gdb_get_reg64(buf, env->gscb[n]);
>  }
>
>  static int cpu_write_gs_reg(CPUState *cs, uint8_t *mem_buf, int n)
> --
> 2.52.0
>

