Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C25C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8bT-0003JO-7m; Mon, 18 Mar 2024 04:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm8bR-0003CQ-LJ; Mon, 18 Mar 2024 04:44:17 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rm8bQ-0007vn-AT; Mon, 18 Mar 2024 04:44:17 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4d44216ea59so373551e0c.2; 
 Mon, 18 Mar 2024 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710751455; x=1711356255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlElwaSPfRuuT6AJDa4GTajTBYA8PyweepVGj1l4roI=;
 b=OuvubLh2pdQs/60XAJCOIuGdtcGFT5kSOrCYxauWWgSPlevKVXlzTikEMP8WmLzrrg
 LI57XwckESlw0Pne0CBTV5aJ3M3QcXeqZXelYvwSKR3D/JILzcEj5knu5Su542ETXgzN
 CBIWml0UQxvzTJmJm2fXgYUmdU7XDFT0I9nVBM/VRb5/eX4X1E3Zr6/U1MsZ8l/BTXUy
 EKcJj1yfReRpdqAkOpYb4rfUNZfKW8lwfBgRkEJ2REia9zUyyoBeEte63BPYK6QdBPvc
 afFJx/Qj7tne9kVc2ox9AJ7z3GVqRj5f4ESxxOFzAJ9O3hdpSR/TKAQKHOaPHPBwEmgd
 gcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710751455; x=1711356255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlElwaSPfRuuT6AJDa4GTajTBYA8PyweepVGj1l4roI=;
 b=uKbcYaBzOSycoYq6I6eJz7VBtuSBl/CdpO9m5eQ7hFc58hxTXwdGPeiDxzdsZf+ECD
 UJ866jyW/2ce4z3LxEC6HXHzS6Q6BV0B/+3Ai1kAbXLSnoPdinI0rHKC3LRGMeDzRwJQ
 +kJDnaurC+q+yy/8ISOTvuIYZ1fIcZaGjY7O+f47pKHp/A2XnfKOeVVgPz+/EqZmGeir
 ++4xnhqVviwpBS54Va/aVpiiTDS8yMHnIdpeiW6kvtUhTphwQMnsl4u2DtRQPDjgu5nb
 mZjrwDSQZUC1OOcQ+Ik5bCWhWOtvCVaMy3dkBoDAjyhG9gEdBhLhRk4bINLdLSJnwwMa
 ykuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPz41/JREIRTKMIag2h/NyQAUeIe3GAxiXQDp8SKVI2ExpTYpyd1A/d4r9kjllSshmboLb4PauaMNH3OFS0bXMVK7Ycs=
X-Gm-Message-State: AOJu0Yz9G9U44tLf/+gnx4Rt0NOCSFurHBhWGs1UKuu9Fa9z6FaLuae4
 THB3OSAKgduZ/UZ11FTsnH6HV672VoLrlq7Nv+7esXlliP8M+jQH8PIdgqjOSwxpQ0TwEVtbYDA
 F4wSzWesj4FLP2VfR6xxBlaH2Pvw=
X-Google-Smtp-Source: AGHT+IEawU1TDTIgZjBEfzTTsWTI9bQOBR0WEPnL55irEfdCSSxOYY9MEAk3yR7IlrKGIe5vaBfm620r63kaq32Irtk=
X-Received: by 2002:a05:6122:1792:b0:4d3:1ef2:c97d with SMTP id
 o18-20020a056122179200b004d31ef2c97dmr10084522vkf.2.1710751454921; Mon, 18
 Mar 2024 01:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-4-dbarboza@ventanamicro.com>
In-Reply-To: <20240314175704.478276-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Mar 2024 18:43:48 +1000
Message-ID: <CAKmqyKMXuVxMbAVF+aP1vKS5bUsVT8AGqq6unVnw0rEZgW9sTA@mail.gmail.com>
Subject: Re: [PATCH for 9.0 v15 03/10] target/riscv/vector_helper.c: fix
 'vmvr_v' memcpy endianess
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, max.chou@sifive.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Fri, Mar 15, 2024 at 3:58=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> vmvr_v isn't handling the case where the host might be big endian and
> the bytes to be copied aren't sequential.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index ca79571ae2..34ac4aa808 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5075,9 +5075,17 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVS=
tate *env, uint32_t desc)
>      uint32_t startb =3D env->vstart * sewb;
>      uint32_t i =3D startb;
>
> +    if (HOST_BIG_ENDIAN && i % 8 !=3D 0) {
> +        uint32_t j =3D ROUND_UP(i, 8);
> +        memcpy((uint8_t *)vd + H1(j - 1),
> +               (uint8_t *)vs2 + H1(j - 1),
> +               j - i);
> +        i =3D j;
> +    }
> +
>      memcpy((uint8_t *)vd + H1(i),
>             (uint8_t *)vs2 + H1(i),
> -           maxsz - startb);
> +           maxsz - i);
>
>      env->vstart =3D 0;
>  }
> --
> 2.44.0
>
>

