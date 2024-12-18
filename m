Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9473BE77184
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 00:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNi1L-0004iG-Ki; Tue, 17 Dec 2024 19:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNi1K-0004hv-55; Tue, 17 Dec 2024 19:34:34 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tNi1I-0003UX-EA; Tue, 17 Dec 2024 19:34:33 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-518957b0533so1776205e0c.1; 
 Tue, 17 Dec 2024 16:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734482070; x=1735086870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TMzGlMsrCcGkpwFbvE9gmCB4lso8C6CsP/b+1xGL7c=;
 b=Tq+hUfinERbGYTo5BTal16n5S59EbjDL/MjhdnzTGc4H/te9dtn/iJ+JAFmZxXkolL
 M+4Pti4zLxMzexvyIhHaqNB8SKgP3uFXyVE9+90tvxG460xYo1OUX0IW6CUzivRjE39U
 f5/+yjutrbSecgzkJe8EUVnU38z0xOWCBxE/ZUeO7qUexLS5RXfTbxqwPN52acJXaCP/
 QyPCkn0LY+9nr0dER3Pe50cj0igs4koOB5CRl7fFiETdTOVmo5edLrXjqMOIpLrjnTac
 0SZC6qbCJGKSprTL3u85klhmmMm0cqh7gQPpnsuod0f13GBNSd1vPcXSA4y1iHiUsfen
 xUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734482070; x=1735086870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1TMzGlMsrCcGkpwFbvE9gmCB4lso8C6CsP/b+1xGL7c=;
 b=XNpTjQ1FOraj0bhy6tDR6N1UZ7yWgpkeFGzvAbMEPv6Y32h2ZojamoxuwhlKUDsU1D
 1kHDRtyrBtyozT9u56byysy05oOd26i9R0HMDPLR4bOCIJLsWIAV5JAqABBS897DkFDS
 ns9hWX32zfNHHNvNCT1nOHIz6j+0GEowiaxw1gZGwDZYBMSPLF/tLkV3yTbhRdaLDNaJ
 1Odu7cSizUtQkHhL4ptXaEoopjTkGli9qLSzH+7DjA2W+daiAsw2wDy/sKmlHP0WD5wm
 OB95gmBa3/Kqy1TJWyXQcz4NGovCaNO3rb1IB1P2lnBU+jfxzDjkfTcsStSLX/hVQq96
 ZxKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqlL7n8eGYaIQXw+jRHm9gog0/N/axvvqinnsIIyf78Yb0bhMJQN5+5+1dKpGXK+b0F2N6GJKYfmlN@nongnu.org
X-Gm-Message-State: AOJu0YysOtpwI0xowB2+6i4V8Jzt7mvxZ18W669wiSPQMwEuQbzXpwTl
 48TtQBfSgmTJzl1iz07vU7VkkSAghlGjo4KBZKybh0VT/xN1oXuq+AD60ZaBHU1CZPhj/7f+pdK
 kSmQ9f8qUMmRJEHfjs+lYeLIcMKc=
X-Gm-Gg: ASbGnctv5pvI204Za1oVhgDNRFtR0+Z1c56GJ0l7r9B4f5bTbHjdgEceHaWUr553hZK
 lmjZzOC0y9bDG8Et8ZwERSnyCaejVLsPeFaBrqXdZtPT3oHNH7DDcPTkkq40JfwKhweq6
X-Google-Smtp-Source: AGHT+IHRPsNA2Q+eKi2IKKn9epMpXLbn+rOHugv+/7LP06xafaJ8vX0L6DovroeE6G1L8eEMCvaWbHvLMVZeMKfXFnU=
X-Received: by 2002:a05:6122:4693:b0:517:4d53:4272 with SMTP id
 71dfb90a1353d-51a36d65533mr1170069e0c.7.1734482069806; Tue, 17 Dec 2024
 16:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-4-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Dec 2024 10:34:03 +1000
Message-ID: <CAKmqyKMiFAduuiQDuo2Zcs0FXHG3e+VT2BsB5cE1rQjL2+5FFg@mail.gmail.com>
Subject: Re: [PATCH for-10.0 3/9] target/riscv: add shcounterenw
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Thu, Nov 14, 2024 at 3:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shcounterenw is defined in RVA22 as:
>
> "For any hpmcounter that is not read-only zero, the corresponding bit in
> hcounteren must be writable."
>
> This is always true in TCG so let's claim support for it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This seems to break `make check`, specifically the
`qtest-riscv64/bios-tables-test` test

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4ad91722a0..6bfb1b1530 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> --
> 2.47.0
>
>

