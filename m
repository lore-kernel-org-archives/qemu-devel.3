Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A4DC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnW4D-0000jw-H5; Thu, 21 Mar 2024 23:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnW4B-0000jk-SV; Thu, 21 Mar 2024 23:59:39 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnW4A-000352-6y; Thu, 21 Mar 2024 23:59:39 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4d458be7fb6so654979e0c.3; 
 Thu, 21 Mar 2024 20:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711079975; x=1711684775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rg6e6TmyBzyCz42mV9qKTytx/ZgpxKm4Caqn+Ho49xg=;
 b=LtKY0aacY5mzz7oH7QpxS83bxdzN6XO1Eq9cO6nPFiIkrGwyTVzCRU1JSMImaaafpK
 gmwepMojPznMhg0slsTgjcHxa2oLDXYlHgtY7vQCRE0K2PCGHKGGBhRfcIMfXIdXl43B
 VJ9ppFOot4HsGqsyiJr3Esj+LRillRsXN/3+Mp857Y/J4AP3PCl2TSE97fGAsphkoI3n
 HErxwvZk1xAXrYoCUGxLr8gjZzSvGHNs7f0kA5WL2uymP0duZ6CvBql3tzyXxU45jnN3
 d58NUSv01Z69eFpmnssN+9l1BNl+9tIjgtswknD/5IG/mjKS8EVmVn4EVeEZ1P537iv6
 Uu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711079975; x=1711684775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rg6e6TmyBzyCz42mV9qKTytx/ZgpxKm4Caqn+Ho49xg=;
 b=XLA6VCOy4MnOcF3g7+GiDdmsxA0Iy/+gt4ELpBgwaxIHCncjlcXl+V5XKCb+3Dx+LI
 FVV/z81zvK7xv+YylAzwVcz6v0r+joGKSeiNgqh8r8k98nlyhbX3E4oOll8CJPSsjp4H
 6qEYQNmdWcIiLGAo//KxrRzE2pVUb4P6Ke1eEOBxSmFHZBEapai/74TUfRwfnsZGxYps
 wrIuKzl0UON7BFTzSppPzuogWikAGOI92Cpv6oCZsWkUm6xG07dEG12GWIbc9XJK/MfS
 XroAA2e1llHtlc4uYrPNC7SrXAeH8clhWyTIlGNjqk3flOAf4FJDPAxkUEZtCPG7AI37
 o9JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwyQ6gnBUOALMRmz45DZlgcaYvHblaCIA45AyEntH9SdYNSTywUm9T4KxK5JbCZd9h3TxMGRqfauuIGsyhhyLjEWVqJ8o=
X-Gm-Message-State: AOJu0YzVvRtn89cH/jnUsGKjSn8qLc3iNePd3kLEVhYtRVaZebwMWclk
 ww2tjeHyqysMwSLdK/ooCQ17Y4Wsqw2x6eeirXscIQUHSNhJJN3UyGATRvpSkbBaQ8M1MroSta9
 ul5RPC041brkl8+jes7yd4Y0JlmI=
X-Google-Smtp-Source: AGHT+IGGFTnnE+LnCM5r0dhvg6pQScz5smAU65oUJ5CxfCEx/VbdjogWQz2ztc955d2nKKD/V+Hhkmhd5vCcAIxFHMs=
X-Received: by 2002:a05:6122:992:b0:4d3:1ef2:c97d with SMTP id
 g18-20020a056122099200b004d31ef2c97dmr1498610vkd.2.1711079975212; Thu, 21 Mar
 2024 20:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240320093221.220854-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240320093221.220854-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 13:59:09 +1000
Message-ID: <CAKmqyKMDu7UTMhHOxs2=5qjRkcgWson+iQoUDhG+23xAtQF3rQ@mail.gmail.com>
Subject: Re: [PATCH for-9.0] target/riscv/debug: set tval=pc in breakpoint
 exceptions
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Joseph Chan <jchan@ventanamicro.com>
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

On Wed, Mar 20, 2024 at 7:33=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We're not setting (s/m)tval when triggering breakpoints of type 2
> (mcontrol) and 6 (mcontrol6). According to the debug spec section
> 5.7.12, "Match Control Type 6":
>
> "The Privileged Spec says that breakpoint exceptions that occur on
> instruction fetches, loads, or stores update the tval CSR with either
> zero or the faulting virtual address. The faulting virtual address for
> an mcontrol6 trigger with action =3D 0 is the address being accessed and
> which caused that trigger to fire."

Setting zero is valid though. I agree it's probably worth setting a
value, but I don't think we need this for 9.0

Alistair

>
> A similar text is also found in the Debug spec section 5.7.11 w.r.t.
> mcontrol.
>
> Given that we always use action =3D 0, save the faulting address for the
> mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
> used as as scratch area for traps with address information. 'tval' is
> then set during riscv_cpu_do_interrupt().
>
> Reported-by: Joseph Chan <jchan@ventanamicro.com>
> Fixes: b5f6379d13 ("target/riscv: debug: Implement debug related TCGCPUOp=
s")
> Fixes: c472c142a7 ("target/riscv: debug: Add initial support of type 6 tr=
igger")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu_helper.c | 1 +
>  target/riscv/debug.c      | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index ce7322011d..492ca63b1a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1717,6 +1717,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              tval =3D env->bins;
>              break;
>          case RISCV_EXCP_BREAKPOINT:
> +            tval =3D env->badaddr;
>              if (cs->watchpoint_hit) {
>                  tval =3D cs->watchpoint_hit->hitaddr;
>                  cs->watchpoint_hit =3D NULL;
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index e30d99cc2f..b110370ea6 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  if ((ctrl & TYPE2_EXEC) && (bp->pc =3D=3D pc)) {
>                      /* check U/S/M bit against current privilege level *=
/
>                      if ((ctrl >> 3) & BIT(env->priv)) {
> +                        env->badaddr =3D pc;
>                          return true;
>                      }
>                  }
> @@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                      if (env->virt_enabled) {
>                          /* check VU/VS bit against current privilege lev=
el */
>                          if ((ctrl >> 23) & BIT(env->priv)) {
> +                            env->badaddr =3D pc;
>                              return true;
>                          }
>                      } else {
>                          /* check U/S/M bit against current privilege lev=
el */
>                          if ((ctrl >> 3) & BIT(env->priv)) {
> +                            env->badaddr =3D pc;
>                              return true;
>                          }
>                      }
> --
> 2.44.0
>
>

