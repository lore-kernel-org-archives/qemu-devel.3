Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D9FC54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgCY-0004XR-48; Tue, 05 Mar 2024 20:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgCU-0004X1-7f; Tue, 05 Mar 2024 20:36:06 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgCS-00052P-Q0; Tue, 05 Mar 2024 20:36:05 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so3435137241.1; 
 Tue, 05 Mar 2024 17:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709688963; x=1710293763; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2pGG4seocb3FPWxQugyJjdavtNuZb0jLZIY0fjwnOI=;
 b=C0Fs2Px+gYc9ILG6Ibgf9uN3tW2OJtdn+bnB0kWIcHFiE1EoiN7GQFmKJ8XtXJVGQV
 yYN8b1XY1LQCK1kL9ICtq+1B/koby1eBDGlvhO7ORBEGmXBQUhDqSvSyjTtJl1GAr154
 O/Q2Mv9C66jEibZ5VXk3FIqpx9kFkU+1YZJCQBjxhmpJpQJcUB9OSJwA0aySnXalJlow
 MbXQjmrwe7tvisC8Gkvoc7opoF2FH5E1wnRjPN/RXilVniJir3VZBUEdG3WiWwEiDXT3
 sTkbAtnHWW3Od6n8210R5Foig5rpIVmS9+cVHPfTswYUC9P7qZniaQuHf0wpbV8ZzNIE
 aoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709688963; x=1710293763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2pGG4seocb3FPWxQugyJjdavtNuZb0jLZIY0fjwnOI=;
 b=b5r/vLAGgAokKaypXdqtPIecC3LV6Yw/qT7w+yzmYzUk5V2JML6MqwB06muiBsiYAh
 5G419L2tbtiipPAGpIjogGvQavB2osooe/XMwRDlpali3SaCnjIXIro12LGa8IiHdFug
 DnJ5SOpoqRvJNOBe7VnEA3y+E/vCxZC/FOTPxcwcmRxY2FxxIAxEVOHO6oD73ryxRUqv
 szAozYfzq25XjGNGQ68HfRxPbaPvTS0NPHbZ0fic/L1eotabVPhzZctv1qnzgx9CKZlm
 7JHBrpTHgOWPgWC90KAy9Ggm2jUKd3YsR2KhEH00zy7OEVv/EPV65umNuGtux7uDPVlr
 mo0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcViwEUUfd/mqHPMQhBSfymcrKi0A2+EydpdsQnqGkVSqiCTp4DMvKsLK3V8l9/sG7KfZI6i+0Ct9me8MmVEWiB3+rumg=
X-Gm-Message-State: AOJu0YypwYVrKulSEkoppF5SZZlf/tWN1mZVR8eFGlJvgbjZbWRYRyA1
 jx0MYkE2JljkdmL/7somhOvr0uX4JI/Eu/WOrIonYj2XBwxLQE5i2KXY52fglALMhiKndK/zFK+
 1bpHmR9UgXCs3Gw5UlJjHsYJ+FIo=
X-Google-Smtp-Source: AGHT+IEJkRsbtcC9+TlPFlsCvgMnFZTKFzSBg9BZGllnLu9v8UjKx/vWPlZyuQ3utXK4kjqr1Rbol0paq+aW4mN7c0k=
X-Received: by 2002:a05:6122:d8d:b0:4d3:4aad:37f6 with SMTP id
 bc13-20020a0561220d8d00b004d34aad37f6mr3642331vkb.0.1709688962464; Tue, 05
 Mar 2024 17:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-7-dbarboza@ventanamicro.com>
In-Reply-To: <20240221213140.365232-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:35:36 +1000
Message-ID: <CAKmqyKPxVABAQEL=0ZdKtWnMh4EZLSCdLNCumVsONXUTAS_Qdw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] target/riscv/vector_helper.c: set vstart = 0 in
 GEN_VEXT_VSLIDEUP_VX()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org, max.chou@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Thu, Feb 22, 2024 at 7:34=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> The helper isn't setting env->vstart =3D 0 after its execution, as it is
> expected from every vector instruction that completes successfully.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/vector_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 84cec73eb2..cc7290a1bb 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -4782,6 +4782,7 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong =
s1, void *vs2,         \
>          }                                                               =
  \
>          *((ETYPE *)vd + H(i)) =3D *((ETYPE *)vs2 + H(i - offset));      =
    \
>      }                                                                   =
  \
> +    env->vstart =3D 0;                                                  =
    \
>      /* set tail elements to 1s */                                       =
  \
>      vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);            =
  \
>  }
> --
> 2.43.2
>
>

