Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7F8C25B78
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 00:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEenp-0005O4-1V; Tue, 04 Jun 2024 20:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEenn-0005Nq-C7; Tue, 04 Jun 2024 20:46:55 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEenl-0000Kl-S5; Tue, 04 Jun 2024 20:46:55 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4eb236e27adso739410e0c.2; 
 Tue, 04 Jun 2024 17:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717548412; x=1718153212; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEgFU9uSykQB+7rAJWlbo6pxtOhSMzlZQkmbPM4VwGE=;
 b=f8OdBLYJC15XM9YZ/EewSgKjIbCqKepW0yDUGoOfjf9ZWGtfl84jmPKJWjMpo8pNQL
 RIzPEmpM3uA/jB9I2E2D/BBSTN6eyY5mT8YFLnNH0hnnxU818m4rdG6FEiw0LHHt2PKC
 PTPZBxHfAXpbmrzokhSF3C2w8GfToHcWM0cgPqLwhcksCA6Nl/40aEzQ56L/NaFmimzd
 kBOJGhk+TPTQy3sK0bm9qrddRSeUCOJouRGzrmkG4zQztffbl1ahjJcJLNu2bOGRM05j
 v0B9x9QRnzRuOtZ2wB8a0p+Mr8wHCaKri6Ykdrwrim2kXH+RSWWB7xBUdXuQA5KINmBD
 vvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717548412; x=1718153212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEgFU9uSykQB+7rAJWlbo6pxtOhSMzlZQkmbPM4VwGE=;
 b=tVBheCoAh2ibt5rgyLxsfNSxQUNb5/hyYTKJbgw8uRJzvn+CIFqgi1l/wA3NSL+zu+
 vWxblZbyt+N2wtgo/h/o2l0bU1P3acoRoyZUSZHsEw+6K3jYFE0eyBi+K1nwKKHGaTJN
 sacAqQqDNX4jmC7Zr6JSe2vNG+HE6UwwDFyjLPKg5xBRzRjpoihHecWf6LOgaw0LQIpz
 80+9vWB1Ke6rxEJxPBxjkE0Esv/31MN9aqjw6630IRnB3Dv77jgqBoWGPmhIjcb7qXZR
 J/31POaHw6ANm/NSH0gYS0DAc4zM/Bzhciq4p8KeOOvsoyZmP7kmIFnlxK/1lfF+1qjc
 22ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Ij4daJObv0ZWEtn/l078JONH3NikDNYvAwOaFvd53p9Q18uwHTb5cNxQZkTsEihY6ts1HMTPQLl94CnypyngI38iOhw=
X-Gm-Message-State: AOJu0YxtaoUt70nuHQqpRzUad/DWsXGvwdnfmkKWFw3rX7a4r4H4yZT9
 Ztv/205CVU0WSsgYC24MMJkEWC6vX8s6sxDpnv+2+G6i88DhH7SzRzFmatq0tTmr4NdXO09fAqR
 mIxvmHHNA8UmEcmtgHVF453qTUgk=
X-Google-Smtp-Source: AGHT+IHMQPHym9z6gSiCfQ0As44hWq888uYSIVv3GS+1YIJ31iiQBGQPGciIEy809htUDZijqW4QcTZn2dhH6Y2VdA4=
X-Received: by 2002:a05:6122:12f0:b0:4eb:1456:34d3 with SMTP id
 71dfb90a1353d-4eb3a4e689dmr1283133e0c.15.1717548411787; Tue, 04 Jun 2024
 17:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
 <20240529160950.132754-2-rkanwal@rivosinc.com>
In-Reply-To: <20240529160950.132754-2-rkanwal@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 10:46:25 +1000
Message-ID: <CAKmqyKN5zY=O7A9QhNWKsdE3HoEnQW_SdkmO1+OhscKYx1TR5w@mail.gmail.com>
Subject: Re: [PATCH 1/6] target/riscv: Remove obsolete sfence.vm instruction
To: Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com, 
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Thu, May 30, 2024 at 2:12=E2=80=AFAM Rajnesh Kanwal <rkanwal@rivosinc.co=
m> wrote:
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn32.decode                     | 1 -
>  target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index f22df04cfd..9cb1a1b4ec 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -112,7 +112,6 @@ sret        0001000    00010 00000 000 00000 1110011
>  mret        0011000    00010 00000 000 00000 1110011
>  wfi         0001000    00101 00000 000 00000 1110011
>  sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
> -sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
>
>  # *** RV32I Base Instruction Set ***
>  lui      ....................       ..... 0110111 @u
> diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/risc=
v/insn_trans/trans_privileged.c.inc
> index bc5263a4e0..4eccdddeaa 100644
> --- a/target/riscv/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/insn_trans/trans_privileged.c.inc
> @@ -127,8 +127,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_s=
fence_vma *a)
>  #endif
>      return false;
>  }
> -
> -static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
> -{
> -    return false;
> -}
> --
> 2.34.1
>
>

