Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A771DC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 22:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPHj-0004pA-9k; Sun, 09 Mar 2025 18:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPHf-0004os-Sf; Sun, 09 Mar 2025 18:38:13 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trPHe-0007yY-5d; Sun, 09 Mar 2025 18:38:11 -0400
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-86911fd168dso1323627241.1; 
 Sun, 09 Mar 2025 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741559888; x=1742164688; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qLrfYDNSbARUiWYEnQ3bHAIPyDx6gJAPhXca1L9mGy0=;
 b=IEbZhKEXyU5SyNLHPJYS9b2cPGnBG2Pymson87x1zVkkF9vZRqMDiiXnXOQlebZ3Qo
 nCDnuxpHTd35WyaCAg3jWiL0Hs8huj5Xa7hZP5YWK6PoyjrTBNxPBwjVckXgKbj9gDnT
 /ZjN988mJPl/1FGQQzY8VjhGJz1GfEYBed6fTf0zdai/zwpcsoF9riGuGxwrxsechxcj
 Njtgtm4+/rIDfM7MNvqJEgJTSMiOfTm9DEfm4KGCbDfr2YEkVZpXqru3SH7BPWqldqyE
 VFoouaaKKg6THJW13Bv5+ufJ1BYflBojjbK0YLS3MF3ICnZ5F4O9X7Go5QY1Oj0dKMiE
 jBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741559888; x=1742164688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLrfYDNSbARUiWYEnQ3bHAIPyDx6gJAPhXca1L9mGy0=;
 b=Y5zvwraY20+h4G0Nl0oasFEk4sjNtE69LceOSuYb8A4Smv4btlW+TSHuHwLwjO5QX4
 Eceeck9OEjTjXdx3JnvuWPwcL6j52RFLgcZrWRSIIs6zkP+Z9P5Yt8yIF7bttHmfNaY1
 2qS/vLl0v3YnIXj+aVGpA+nh1o5yUmApjd/jISOkcNAfaewQyDqTrzw3x0TcGB22VJ/9
 gxVdgeDIFtyEi4CXPgRH6zEDvSNvPJUcVGEOVbSlAETvUZb5iUn3irDUqIy2EKc807ME
 ZoecJzTLUGGHR8HbD0+GA6326AqTC5cxk6iT2yNI9pm41MSoXwZKshhXTdE8WHeCM7GW
 s88w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx6d6ETdyggA+dv8/W/S6B2jUEdCP5iPKxaiDDR+mJPlx1clTcXcGOkcnooHyehlg058eqGS2UWLES@nongnu.org
X-Gm-Message-State: AOJu0Yxm0ZXXRUCrgwvkpUcP4Cvs+dJEvOR2K2NxAcBH7mM8YaWaMhQC
 UJLVSkw7CyAjDCNanmwPSHM0xTvjMGTijL2RnqMBdBzy1gAfWWv2i+dpKiaEn+W+0gn75vbPjfa
 slNRSVhkUCspcs7ywg5qgozp9mIY=
X-Gm-Gg: ASbGncsV+v5C0w36dTHYKT7X73AXN1j+bAc6sC0+aOkWi+gPrpOGUZKxhjJzmuNSGNU
 bnD8KOw1DzwZ70ZlRkg11UttsWrAZgfcUzazfmI5UZUG8HGSfR1joUjLEZ+gYrzaWtFg2MCoeHW
 VlMc+IsnrSSNWTuFA8KNQdK7oSPB0tnNiloL5DnRqtWKRLYvpxYknSlO8=
X-Google-Smtp-Source: AGHT+IEaEVNn79NWhewx7J3mmd5xZFGfu76vuwPyrgmxkd40Um4Ffius0Ck9vkZRaGgxAe0uTLoWAr3Ty0Ji861vLUI=
X-Received: by 2002:a05:6102:2b97:b0:4c3:9b0:9e6b with SMTP id
 ada2fe7eead31-4c30a5aa37amr7786107137.10.1741559887725; Sun, 09 Mar 2025
 15:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250307124602.1905754-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Mar 2025 08:37:41 +1000
X-Gm-Features: AQ5f1JrOqFCVrghNUeIYtHaSVjBf93rWH53Clukl3U3gcl7KcVYPXXFHEwwbQVw
Message-ID: <CAKmqyKPzHB9OypwxNjXKwETVnq+-8NPoFk2JWweu1UmMhYKOag@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: fix OVERFLOW_BEFORE_WIDEN in
 rmw_sctrdepth()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92d;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92d.google.com
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

On Fri, Mar 7, 2025 at 10:47=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity found the following issue:
>
>   >>>     CID 1593156:  Integer handling issues  (OVERFLOW_BEFORE_WIDEN)
>   >>>     Potentially overflowing expression "0x10 << depth" with type
>   "int" (32 bits, signed) is evaluated using 32-bit arithmetic, and then
>   used in a context that expects an expression of type "uint64_t" (64
>   bits, unsigned).
>   4299             depth =3D 16 << depth;
>
> Fix it by forcing the expression to be 64 bits wide by using '16ULL'.
>
> Resolves: Coverity CID 1593156
> Fixes: c48bd18eae ("target/riscv: Add support for Control Transfer Record=
s extension CSRs.")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0ebcca4597..e832ff3ca9 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -4296,7 +4296,7 @@ static RISCVException rmw_sctrdepth(CPURISCVState *=
env, int csrno,
>          }
>
>          /* Update sctrstatus.WRPTR with a legal value */
> -        depth =3D 16 << depth;
> +        depth =3D 16ULL << depth;
>          env->sctrstatus =3D
>              env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
>      }
> --
> 2.48.1
>
>

