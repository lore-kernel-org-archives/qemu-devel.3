Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4DCC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 02:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1H8X-0000R0-Qg; Sun, 28 Apr 2024 22:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1H8W-0000QX-5F; Sun, 28 Apr 2024 22:53:00 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1H8U-0006g2-Nu; Sun, 28 Apr 2024 22:52:59 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7f04901d456so575961241.0; 
 Sun, 28 Apr 2024 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714359177; x=1714963977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWLhC2I3eB516k7TFIaN0g9mrOyGwGsAoC+dvPA7Yic=;
 b=lPCSWekM9mj6qNwM8RyDOXgcxwFFiJ3L+DyeVZrtDOPb3T0rIPl8jzUEpcBTaikz5T
 cfXvzyjDYnR/vztpVSLd21SZTFa6SI5shza4d6iVdOx9kA5yuWQHdAwP+/2ij9lnD6dz
 5JAAQApr/HuBqTOxm6En+KZPhsyUuQXuNQdueU4a5PmuWQUGbtXxcuk+EgudJUNzjKwE
 r4pzxAJQErCT7OwiGbqJIL5Rn0fNTqdiDpjqZ6RyotHRqPgc2oJjEaF8TiZavXHwGgoP
 +pWvvuyxJmqpqkq0/gqayySgfpw1TYVTYUnA8djh3sMiPBc7itvf8pzqtFC6ynRmBz2q
 l64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714359177; x=1714963977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWLhC2I3eB516k7TFIaN0g9mrOyGwGsAoC+dvPA7Yic=;
 b=qq31FOg6lguYZiYPihixAt9tnItYyPdpz1R5COMVoANfP1X8nklBab87xQLz8XJZPE
 TanP+aIwk9vO0lH/6yciYGrXBAwQC1w95OtGyUgJJNq02fP48yWdhYdPzzgacOTOO7EA
 JSvqv4lyfiygrZKSMIFAqNHVDuJTfCEgG8uVJpqKjNo+bNGnPTYv1lo/t/lOgJBxdyMV
 MhhRcrVEYw9UCrWRS+g5rMCGeTEKF6FoRn1OVYMrZTBlTTUrmPMvuICxYdNusBS8b8EQ
 Mqo88tLhGURQf1MYnD2bpKQXoNYzjO87AsBWB2hgLFYoK/UKjg98zjmG3qiSTfTPaifN
 AV3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsoeX5SGcxs9qlvudCESlslMlha7vESYCRmao9+npvWWhfIMPmOpgrDwmIl3GJYvXRDhKWRq7SCZWzPg+biJ6PQ66bk5vFjzTPjA+tMJtoFurrTu356ewwB7PLMg==
X-Gm-Message-State: AOJu0YwhnjYBU/TYfID6vItCqtJMPsCAqitMCv9vJgfzSQNRYJ2kzbFp
 mdXFeR4E6y0FE/8ZRQl+1Loq6DTHFYlYHEZlZrDapyE0kV0UKq3AbGKlwVAi2ay5jbz7SOIp9PA
 nokkDTS45x5K/4sS0xWrhVNkunwACn6m/
X-Google-Smtp-Source: AGHT+IFVSJjYVdy+tPZYU5VHaxAjTCUSqIYtjY3YbT/6cdG66kvJcdwiKIJ78cswJ6yn9tRjeBVVIz16EEkkuqXEynU=
X-Received: by 2002:a05:6122:8d1:b0:4d3:3f2b:dc63 with SMTP id
 17-20020a05612208d100b004d33f2bdc63mr6935207vkg.5.1714359177397; Sun, 28 Apr
 2024 19:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240422135840.1959967-1-cleger@rivosinc.com>
In-Reply-To: <20240422135840.1959967-1-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 12:52:31 +1000
Message-ID: <CAKmqyKNOusH57DGjrGuWE1qm1exaZH9i8L3dHosrNsgzCkLgpA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: change RISCV_EXCP_SEMIHOST exception number
 to 63
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Mon, Apr 22, 2024 at 11:59=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> The current semihost exception number (16) is a reserved number (range
> [16-17]). The upcoming double trap specification uses that number for
> the double trap exception. Since the privileged spec (Table 22) defines
> ranges for custom uses change the semihosting exception number to 63
> which belongs to the range [48-63] in order to avoid any future
> collisions with reserved exception.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

>
> ---
>  target/riscv/cpu_bits.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index fc2068ee4d..74318a925c 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -670,11 +670,11 @@ typedef enum RISCVException {
>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> -    RISCV_EXCP_SEMIHOST =3D 0x10,
>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
>      RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT =3D 0x15,
>      RISCV_EXCP_VIRT_INSTRUCTION_FAULT =3D 0x16,
>      RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT =3D 0x17,
> +    RISCV_EXCP_SEMIHOST =3D 0x3f,
>  } RISCVException;
>
>  #define RISCV_EXCP_INT_FLAG                0x80000000
> --
> 2.43.0
>
>

