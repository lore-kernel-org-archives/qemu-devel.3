Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E3EC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYKv-0005hZ-7F; Thu, 15 Feb 2024 04:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYKt-0005gU-TD; Thu, 15 Feb 2024 04:47:19 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYKs-0008Pq-HR; Thu, 15 Feb 2024 04:47:19 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-46d34c22594so74463137.3; 
 Thu, 15 Feb 2024 01:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990437; x=1708595237; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14LY43UpU5IgoVar+Ol1tU6Xk/NUgxgiRVQSr/1p1ok=;
 b=cO+6PoMO3lHZ1mtQE4ysDiDP8KOXez27seKIvpPykBG6yuiOPplP68rWbTQBEgj1xn
 5FGWaBNI+csIBJz52AtBBuAr6TFxCFu425wnIY18abd43bDXESOlh+u8MHa/s8H8i0VZ
 dOJymClGSXsq5AwHgh2GNAACMR9NOFVhV5yLVHK33MU4n6UpCOmf3u+cpaM1uVXZ11F4
 IVLtY6yFPL0b+L4/GQ1ibX+kxa/+A4d30DykkaM7cgyrQX1dWbxLF0D0ik/cepkWTXxN
 rH0HyWgSVZqP0VGwzwHca14zQFvvdx6DijfD5y+HGTlHGT0e6LxoPaAC0BOL30ypJGDe
 vwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990437; x=1708595237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14LY43UpU5IgoVar+Ol1tU6Xk/NUgxgiRVQSr/1p1ok=;
 b=h88zwY50BB5s9yIebMNrq1baSCxB+V++05LhA11CGexNyTxbBLlkJ/RuwQOtYkW6Zw
 eCQrk+ghOrRsA1pDNmzyD65njkbHSeQ+vYxyKjND4j/ATzNMJMUIh3qIeTrxmOMmiQct
 9SrYaCKTQExHPmqc1nNkqR63h0MO7MsGiCW22q9mmEiuBgzJEuGBUpcTe+0OoprSJNgj
 Hcb4+g5OR8zVHkrMKfrgxtRPIDW9Ryz/nSaUFYmp44HmayTveaWBsTn8/jHv0mWW/cZr
 CQxAwMcRWk0fPz8Y16MR/mN3GlDNb9tCPh5EloOYwq8rWZ/cjhFzQxKojzGMuKLb4aoE
 VYaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg9pm88UZyuJesuwyHyuVsi76LT0ELHYSKGqHoOAENvMn3/UBPqif2w04a1NH7nKHtTHdd76AUY+rNItQ5KqMME5Ndrgw=
X-Gm-Message-State: AOJu0Yw7tiOaW+/rUk/6DppWOTsXe5oXXxJsVd/DCh7b4WIHyLzrwvQ+
 B4YWQyLncYSM4ETO1fOi5+ZXqs6Q66PdPl40OpWIN3Sjt+XlyjVXfX5suqJghWwuKG8Wex9OS7S
 Td/Zz6JBidS/iuhJrqo6mFCNbDrg=
X-Google-Smtp-Source: AGHT+IFZCY0CU3iNpx8xPjRpU389+d45AmnbPzV4Zjq3wrNIlQbJ/KY9m2ngh3acZlkdFOlZH3ZWov8Klyj3DvHxPV0=
X-Received: by 2002:a05:6102:54a4:b0:46d:6beb:36f with SMTP id
 bk36-20020a05610254a400b0046d6beb036fmr1192350vsb.5.1707990436119; Thu, 15
 Feb 2024 01:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20240212171156.47293-1-irina.ryapolova@syntacore.com>
 <20240212171156.47293-2-irina.ryapolova@syntacore.com>
In-Reply-To: <20240212171156.47293-2-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:46:50 +1000
Message-ID: <CAKmqyKMXuykxif+ezzVkxjFA6m5vECj9088GjFPiyRvCQqtT0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/csr: Added the ability to delegate LCOFI
 to VS
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Vadim Shakirov <vadim.shakirov@syntacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Tue, Feb 13, 2024 at 3:13=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> From: Vadim Shakirov <vadim.shakirov@syntacore.com>
>
> In the AIA specification in the paragraph "Virtual interrupts for VS leve=
l"
> it is indicated for interrupts 13-63: if the bit in hideleg is enabled,
> then the corresponding vsip and vsie bits are aliases to sip and sie

@Atish Patra in case you know something I don't

>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0c21145eaf..51b1099e10 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1136,7 +1136,7 @@ static RISCVException write_stimecmph(CPURISCVState=
 *env, int csrno,
>  static const uint64_t delegable_ints =3D
>      S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
>  static const uint64_t vs_delegable_ints =3D
> -    (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
> +    VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
>  static const uint64_t all_ints =3D M_MODE_INTERRUPTS | S_MODE_INTERRUPTS=
 |
>                                       HS_MODE_INTERRUPTS | LOCAL_INTERRUP=
TS;
>  #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
> --
> 2.25.1
>
>

