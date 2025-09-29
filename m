Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAE6CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v31hE-0002iY-2I; Sun, 28 Sep 2025 20:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31h9-0002iB-TU
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:24:47 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v31gv-0004Ak-DF
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:24:47 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-62fa99bcfcdso7483506a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759105462; x=1759710262; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0PKdVb7dD3GoNt2SJn3gMoSqWUs/dv8Br1Qvpa3/P8=;
 b=afUxizvsV9um+D0mTVIJ89tlD5EEgxKRC7DaBsdc/7xexSbT/+BP37zi7ftaqTduCo
 jDjKF4ysQEq/SYJVl4sdLNKYuCSaj00mE091BTsfTG6nJd7i2+OE7li8CE8GqlhGdtHk
 RzZFDXq+bdwez2JhWW/GXf4wPqCl6DPiVKuzwlb8k1008rpvVJC4ipQ4Gcag4j4q+TyL
 whJ/pkvW5bYN3S7HJeWYoCLYU/ExJXBqUgnWD8p1tdCme3cqqs+Bx4OgJSgBiizX6lBv
 wbaPbdohgm5o+Gaz71tsPOoGiHQ93s3R8vcufCEPx60HKbXDThZ0mlIR1t/Q8dyA88Pj
 IwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759105462; x=1759710262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0PKdVb7dD3GoNt2SJn3gMoSqWUs/dv8Br1Qvpa3/P8=;
 b=QWQVI5QhCx2Cpr+u6SVG38TIYdBb2v2VdHps/6tCB0l7lIFucdEOypQOs3ErX6DZKZ
 bcuxtQrh5W2OQyOMYpbpfFqZOzQeqI/+lPjo30othYBzR17dO5NCFzBttzApOuix6Mo+
 vJoZgZz9K1tdfe0ZR7FjcJsgjfFVZFnwrw4q5Qj7GdM549x4RUvORb1wkbPYMjJxEl+U
 ey4yM1aLAbdYUyD7257bro8sRIcXwswwm/Z59rh1oQdaak3uxXcjC08Pt5BJ1Zfv7hIO
 U8Ft4GllF3W+SgV4wSb9+7hqw5/n1yl8wUz0hiCd7Lg6B04WrMSXJcsOaSQQEjr4fY6v
 gQaw==
X-Gm-Message-State: AOJu0Ywt4ybUceX6OZu0NbJX53wHxacB0GCDe8oV0oI8A4rBLby4619V
 FO5tqmOgkcm99NgDllT9AL7eFLHimubJVDw/aHzOs9IL/cOOyA/2dxX40s0drK4MHmCc19Qxfv2
 Zb0GftB2jt1/FkCR9k83xqIzoZBEDGeQ=
X-Gm-Gg: ASbGncvxb3YsmmKfvqFYW95Um4fEXWhtyUkI0BHNwfPfnPKh7U+QzH3371bzh0z5z8m
 I94DWOiIpdlvZgwhUpKXjamIqzl/nRgRX/RRpWW3E+sOY/6B7p/am6Q8Jmuyr9FF4wc8yj/DTcq
 Zzhcorv+Vd9td6yd2Qo8DdUDFmvemextmisKfutAfmdg/SDXPkXeI5pico/beZR9EHu/ztL148t
 xqJZwPxSk+ZFZFJVSd9dwDYc5ZeK1eqJ0Dt+Id3YR3vL5Sp
X-Google-Smtp-Source: AGHT+IGr6rpV3HVru5GCXCUkeQ3hAq/MRG/AivzYegdtBzBg6TEXPfTxtAag62iIOqs4jlrKf6FtkncZ6lJun4cQ9FI=
X-Received: by 2002:a17:907:608c:b0:b3c:4ebc:85dc with SMTP id
 a640c23a62f3a-b3c4ecbd1b1mr417961766b.11.1759105461784; Sun, 28 Sep 2025
 17:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250827203617.79947-1-stove@rivosinc.com>
In-Reply-To: <20250827203617.79947-1-stove@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:23:54 +1000
X-Gm-Features: AS18NWA10AlcIPmft_-qAeb3W0Ra0lAsR6M08W6cTkfSuIDShIM-N6HZndkKRNs
Message-ID: <CAKmqyKPXL+TcaccFKt-w2ZwQfuo24fiEEYvUDb8cmxwpNeAHtw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: use riscv_csrr in riscv_csr_read
To: stove <stove@rivosinc.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Aug 28, 2025 at 6:37=E2=80=AFAM stove <stove@rivosinc.com> wrote:
>
> Commit 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC
> writes a read-only CSR") changed the behavior of riscv_csrrw, which
> would formerly be treated as read-only if the write mask were set to 0.
>
> Fixes an exception being raised when accessing read-only vector CSRs
> like vtype.
>
> Fixes: 38c83e8d3a33 ("target/riscv: raise an exception when CSRRS/CSRRC w=
rites a read-only CSR")
>
> Signed-off-by: stove <stove@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..dca8edff6d 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -873,7 +873,7 @@ static inline void riscv_csr_write(CPURISCVState *env=
, int csrno,
>  static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
>  {
>      target_ulong val =3D 0;
> -    riscv_csrrw(env, csrno, &val, 0, 0, 0);
> +    riscv_csrr(env, csrno, &val);
>      return val;
>  }
>
> --
> 2.50.1
>
>

