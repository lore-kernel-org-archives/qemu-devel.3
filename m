Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F09DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 03:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rykJF-0003tJ-7K; Sun, 21 Apr 2024 23:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rykJC-0003sc-O9; Sun, 21 Apr 2024 23:25:34 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rykJB-0004v6-34; Sun, 21 Apr 2024 23:25:34 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7eb9cb7b657so1123185241.1; 
 Sun, 21 Apr 2024 20:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713756331; x=1714361131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8MlDnEAxy0uzLrI6vXb30mtL08CR66ZwVYe9VsH2FA=;
 b=JSD9q1rcfnLxUnvWNED65k+czB2i3cZAaEVDbw/twuYonWZAO39BjFU/BoAReadKtd
 P2LzH394bMXW4eEDUik6IOwoeza2XoZ1x6mfh8TCmmOlwdeWWwg90Pb7ASONW81S9CZ/
 NJXG68cyz8CatppgUiv9WYe6gaVQVPqvaJJaJ93XKSX2Iip/tS4sVqTkZqBd8IvXwUhk
 YI77XCuP6e5H6cE5Sq98qSaXHh8V9UfkowvbjlD0eZ7MwRV1xK0SlOgnORMxWapjGr20
 gUOyhdQ4CgFKGFg3OKcnqE6BaN9KlYLL8QbhOE8Cvj6Ysj/2SQAOTgPy2h/xWR/FiQFT
 8wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713756331; x=1714361131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8MlDnEAxy0uzLrI6vXb30mtL08CR66ZwVYe9VsH2FA=;
 b=SUh4uxmgBqS+Yw0iFGcF52zD2VXXvbs6HdS6Q5+0A0YOGbkn9DAvdQX2z9gy88Bbaa
 ycRu/uPmgs8/BccKWRcHQSjQ4PEieA1QGde8c5rXT+qcI73nug5h1YcFq2kZ/2FJvdQ2
 enS13bEMOC+m0kkKYdOVzw2WNjHP6Y3VSjZ9koVKlI9dlhcHMjzcZlHwBO59U6Rub7/P
 3QLI0sCfeMVhPUbegMe40yRrodO2FUCxkIQaKu7Bbx+GClb+eFgPuYMY955tDFIuiNOM
 /CIUtaiA86Iyh5UVyntjdbhu/6bD2iNtuwyGM27x3L2jm2E6RM8sP3tLMCJPdgxb23ZL
 WIxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM/oHe5V+Q/tJBe7b7utrFEo36aqF9D9jc8Ex8hHd5a3uBcdoqUlNuBvTzWRUULoXHP7TYBONIVqvMv3psRO9qFiY8584=
X-Gm-Message-State: AOJu0YxGWeCjgCguUzqrAy64aIoXWi2t+KI2Zimc77hROVseQF5usdKV
 8fand8xWAPNyR4Ekle8uH861mE3aDqUNOnurRGiaP6JqqaIATeQzJAdAshL+zN6pG7B+Wu+8pba
 DqrTcvKeFMe5g13HwRqSN6Des9JY=
X-Google-Smtp-Source: AGHT+IGYI0LRHsnLNXY6WCOnu92rfU/3TOla7ulV0bXPfC//vvox0PS9AIRrQcANvhA/KOMkhLDV6kB76frwOAmtrbQ=
X-Received: by 2002:a67:fa51:0:b0:47b:b6df:45f5 with SMTP id
 j17-20020a67fa51000000b0047bb6df45f5mr9725554vsq.6.1713756329372; Sun, 21 Apr
 2024 20:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240418133916.1442471-1-cleger@rivosinc.com>
 <20240418133916.1442471-2-cleger@rivosinc.com>
In-Reply-To: <20240418133916.1442471-2-cleger@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Apr 2024 13:25:03 +1000
Message-ID: <CAKmqyKOcYwAgEnV-gyUYu19dLCKx94-rMoaE5m-8FB0fq7AL+g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] target/riscv: change RISCV_EXCP_SEMIHOST
 exception number
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Thu, Apr 18, 2024 at 11:40=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> The double trap specification defines the double trap exception number
> to be 16 which is actually used by the internal semihosting one. Change
> it to some other value.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index fc2068ee4d..9ade72ff31 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -670,7 +670,7 @@ typedef enum RISCVException {
>      RISCV_EXCP_INST_PAGE_FAULT =3D 0xc, /* since: priv-1.10.0 */
>      RISCV_EXCP_LOAD_PAGE_FAULT =3D 0xd, /* since: priv-1.10.0 */
>      RISCV_EXCP_STORE_PAGE_FAULT =3D 0xf, /* since: priv-1.10.0 */
> -    RISCV_EXCP_SEMIHOST =3D 0x10,
> +    RISCV_EXCP_SEMIHOST =3D 0x11,
>      RISCV_EXCP_INST_GUEST_PAGE_FAULT =3D 0x14,
>      RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT =3D 0x15,
>      RISCV_EXCP_VIRT_INSTRUCTION_FAULT =3D 0x16,
> --
> 2.43.0
>
>

