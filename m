Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A047BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hrf-0000kK-Ie; Sun, 28 Apr 2024 23:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hrd-0000ja-MH; Sun, 28 Apr 2024 23:39:37 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hrb-0006Gl-Vk; Sun, 28 Apr 2024 23:39:37 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4daab3cf090so1965195e0c.0; 
 Sun, 28 Apr 2024 20:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714361971; x=1714966771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiezn1jCpbisAe/o98fHOK3sIsw3VHybbGzkgvfY9dA=;
 b=eegAamrpRRJbPHq/fV5MEtkfmRugh6cx61+DF5rqu9m5BbIxdxxUVfun8lHJjZj9mM
 hg5W46U7tTxnTmMNrRisnL2VU3YlUmbcGbwYePa/EewQQRUHd/wLx6wFNrSQwPIzmFsH
 +QJ6WQnNyxlS56PwvV+mKj0o638Dl7vzfRZMd74w/AfCqfrEcscJgDZDzGlegoBJBZn/
 uW2Fi8a1ejdESGBF/o0DoMfrW3tJNYlDdfq8KkvfkVfaCsVtHd4by+TuPJsGuD3IJy3v
 6b9you/zyEXbSHiVtPBpB9nQ1TLWyBY2J9BnGkGt9AKuL32d5jeR2Ru8KEasGNKqmZec
 LzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361971; x=1714966771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiezn1jCpbisAe/o98fHOK3sIsw3VHybbGzkgvfY9dA=;
 b=QOEsla23jXu7X6xbL0iBmDwq55iUPdvm2swB0bfhQh0BXdXdArql9OMnk2rnJBE5sC
 cxMJBa1ZcW8OmfEtoGOQf/ZKr6Tr5G92zBnpW3JBbhbm5V5ASrxzc8vX1JbE+DBkjfZu
 gE8L3UYvrl7qVFSqasFY7GWQxYrLwfFVFYwMaV1OzVuG6d0c7ghRm+C7Rr9olLCvTZyn
 r5G1GQFWipPR8i+aNGiFD1LBVTLrBQoat6d0Xca3+gFv26vtKNX5nuQlf+y+6xPM2vHf
 PJX62GRfzz7v/8O2Ser+6n64162ihof8WiXrJLuXMqoCmTbruiAHZdKzRNZyaoZtVjKj
 6tpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDAA9rlyFSZPGQQSh2C46+HDhj3YELKSH9rmRUVnPPrc2Np21r+YUrMYpMWGcgDWddX8MIgaNaQqHBHjkvXxoNYVeN9dc=
X-Gm-Message-State: AOJu0Yx/herqv3ruOsbPCccrcURta2AjsY1I7S75IPlg5+/z0hCLa9zI
 eA8V6VR7B+w9wAOeWuRdph60S+zvcYYaPTgZOmZ/zDJZAgs26z4TH6JvndBeInYtaomd6CjLUXd
 kXgh1KBJd/IkclYwj6F7Odb/MAPw=
X-Google-Smtp-Source: AGHT+IHPfYyqVQeA4vyjpCx7KH3ymXEhlnYki7sEQrXrI0fybc7FRYTkwlOwSxjk2vUDOZe9rn6fx+FMLcSfoqIC8DU=
X-Received: by 2002:a05:6122:2011:b0:4d4:34b2:9a89 with SMTP id
 l17-20020a056122201100b004d434b29a89mr10673640vkd.8.1714361970667; Sun, 28
 Apr 2024 20:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
In-Reply-To: <20240325021654.6594-1-eric.huang@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:39:04 +1000
Message-ID: <CAKmqyKPJqU=dOsXX=kOPnbJtbOHw63_V_XXkfMFc+26Uh+1MYg@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: Fix the element agnostic function problem
To: Huang Tao <eric.huang@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com, palmer@dabbelt.com, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Mon, Mar 25, 2024 at 12:18=E2=80=AFPM Huang Tao <eric.huang@linux.alibab=
a.com> wrote:
>
> In RVV and vcrypto instructions, the masked and tail elements are set to =
1s
> using vext_set_elems_1s function if the vma/vta bit is set. It is the ele=
ment
> agnostic policy.
>
> However, this function can't deal the big endian situation. This patch fi=
xes
> the problem by adding handling of such case.
>
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v3:
> - use "if (HOST_BIG_ENDIAN)" instead of "#if HOST_BIG_ENDIAN"
>
> Changes in v2:
> - Keep the api of vext_set_elems_1s
> - Reduce the number of patches.
> ---
>  target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_intern=
als.c
> index 12f5964fbb..36635a1138 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnosti=
c, uint32_t cnt,
>      if (tot - cnt =3D=3D 0) {
>          return ;
>      }
> +
> +    if (HOST_BIG_ENDIAN) {
> +        /*
> +         * Deal the situation when the elements are insdie
> +         * only one uint64 block including setting the
> +         * masked-off element.
> +         */
> +        if (((tot - 1) ^ cnt) < 8) {
> +            memset(base + H1(tot - 1), -1, tot - cnt);
> +            return;
> +        }
> +        /*
> +         * Otherwise, at least cross two uint64_t blocks.
> +         * Set first unaligned block.
> +         */
> +        if (cnt % 8 !=3D 0) {
> +            uint32_t j =3D ROUND_UP(cnt, 8);
> +            memset(base + H1(j - 1), -1, j - cnt);
> +            cnt =3D j;
> +        }
> +        /* Set other 64bit aligend blocks */
> +    }
>      memset(base + cnt, -1, tot - cnt);
>  }
>
> --
> 2.41.0
>
>

