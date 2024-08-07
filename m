Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 04:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbY0q-0003F1-ED; Wed, 07 Aug 2024 00:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbY0n-0003Dy-C4; Wed, 07 Aug 2024 00:10:57 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbY0l-0006Ut-Fo; Wed, 07 Aug 2024 00:10:56 -0400
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-821b8d887b8so441684241.2; 
 Tue, 06 Aug 2024 21:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723003853; x=1723608653; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ox3w2uK/YJg2/dqXJs0LwfMVT9mLwv0GKWoRf10GeKc=;
 b=JyF0pRct/WNAC5lxH7JUJWpICZUZEXViTamXEpksBq3VVJwEx9cvNu6WGfO55F2+LU
 vPfh7YCHO7rI40zWITQ6j+PUMZZLLqIKOKIsjZKjW/gHjEF7/9RF0WntuyQ4r489liiO
 ndvR8IoziWRrwt+510pIQorZzmdsmmRtnOF0ekYx2Rtr1hDFfNDdgeQZcEbgEOU+iaVj
 aokkAonugNEOxG1bR/J744tFXP/0EwN74nP1rKyuS8f+nQ0jtrwiB65Y9fKj1mVGCoid
 oGoO6tynNvOSFgdr4hCGSXB3RpBP860Jqxp3hd7JvSEbq+rCQSuw/3rXUWi4xJja6a6j
 V8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723003853; x=1723608653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ox3w2uK/YJg2/dqXJs0LwfMVT9mLwv0GKWoRf10GeKc=;
 b=OytKOrNw1jpDAHb2nCe633PXdbtcxQpqvjQ9Rk4Mxr2XWSY/4hM1A04DM0virDDnUY
 A+9N1HFh7vLnrpebj7mkOIQ+JyhXlF2u14l39tWRUf8RoruG4oZ9eKrlyFBISIGzfGgt
 HsZXpaf3/6J+ej4xZBUh23h7ixNSYOZjyxvL2y04gKSJmPdMlhU9hiX0V1K3WBRqAoIj
 arWPM4w/c2jo0sRZseAgI3McF523Vj/T0zUqXv6bamb1p73PFhyNPAh4AtQhFBPinmg2
 p4ZnczlB+mbtkCrOhGrHYK6gjkPp98PLWfzk8+bvHg2AbzK8br8PFCWUkkbABWVFO4dH
 mWEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYuEcqJa0eyV4TN99Mp1/MbNwlsvVgtGnuuRNyvtdaaygi5yBgDzlYdcv6NKyvcLlekhPD0lzXjSwv7FWhKBlRN/DrzxI=
X-Gm-Message-State: AOJu0Yx8JmCJWtFP5ueR3aFejusLp9Cn2DvPpULAUeGxxF0T5gesvCaq
 Lkf2viR85Nm/ZmV0P3KxPpiWTENxfW1UY1r0VRtKyjsEp/Cw4lVIxRBrK81vVjBC3hiz3h54r/Q
 h9Sw/yxz5RadyYwH5yIpzYuNnXWM=
X-Google-Smtp-Source: AGHT+IF2uvm8JzlgVP+Qn2USVP4hxNYGnUANDjzeqvfRYDV7h8Gr0gjV3l3t92v1eY06J82SCtXIimVd1Gdi5KMTh8M=
X-Received: by 2002:a05:6102:38ca:b0:492:9f6a:e980 with SMTP id
 ada2fe7eead31-4945bf3276dmr16269498137.27.1723003853536; Tue, 06 Aug 2024
 21:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240805043336.72548-1-alistair.francis@wdc.com>
 <20240805043336.72548-2-alistair.francis@wdc.com>
 <9da48ab0-d88e-4d80-aca6-79dfa083bb9b@linaro.org>
In-Reply-To: <9da48ab0-d88e-4d80-aca6-79dfa083bb9b@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 7 Aug 2024 14:10:27 +1000
Message-ID: <CAKmqyKPpw9zVTAzQHNCcNeoV11yCaz9NMEJ+w2TitqK_vEtR0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] include: bitops: Add mask extract64/deposit64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dbarboza@ventanamicro.com,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 zhiwei_liu@linux.alibaba.com, 
 Alistair Francis <alistair.francis@wdc.com>, atishp@rivosinc.com,
 bmeng.cn@gmail.com, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Tue, Aug 6, 2024 at 5:32=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/5/24 14:33, Alistair Francis wrote:
> > Based on the RISC-V get_field() and set_field() macros add
> > mask_extract64() and mask_deposit64() bitop functions. These can extrac
> > and deposit values into fields using a bit field mask directly instead
> > of a length and shift.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   include/qemu/bitops.h | 35 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> >
> > diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> > index 2c0a2fe751..dd26f4a6b5 100644
> > --- a/include/qemu/bitops.h
> > +++ b/include/qemu/bitops.h
> > @@ -409,6 +409,22 @@ static inline uint64_t extract64(uint64_t value, i=
nt start, int length)
> >       return (value >> start) & (~0ULL >> (64 - length));
> >   }
> >
> > +/**
> > + * mask_extract64:
> > + * @value: the value to extract the bit field from
> > + * @mask: the mask bit field to extract
> > + *
> > + * Extract from the 64 bit input @value the bit mask specified by the
> > + * @mask parameter, and return it. The value returned is shifted
> > + * so that only the bit field is returned.
> > + *
> > + * Returns: the value of the bit field extracted from the input value.
> > + */
> > +static inline uint64_t mask_extract64(uint64_t value, uint64_t mask)
> > +{
> > +    return (value & mask) / (mask & ~(mask << 1));
> > +}
>
> Adding these miss the point of using "standard" qemu operations.

My thinking is that if they are added then they become standard :)

At least then they are included in core code and easier for people to
understand.

>
> But if we were going to add this, avoid the division.
>
>   (value & mask) >> ctz64(mask)

Good point

Alistair

>
> I presume the original formulation is so that the macro can be used in th=
e context of a
> compile-time constant.
>
>
> r~

