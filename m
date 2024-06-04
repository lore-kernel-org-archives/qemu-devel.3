Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65DDC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKyM-0001BS-1V; Mon, 03 Jun 2024 23:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKyK-0001Ay-9k; Mon, 03 Jun 2024 23:36:28 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEKyE-0000GT-SG; Mon, 03 Jun 2024 23:36:27 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-80acfd81899so1383748241.1; 
 Mon, 03 Jun 2024 20:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717472181; x=1718076981; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zK7d8lrbqpLLcnaE4mD0Hd27GLT/1ymJeLeR22esD2Y=;
 b=d+81stWHInPdA76TxpPtfLrzE89CGQVnqs+fLRUeWVcpdjWEtTHw3OMJ4LHdyNtS/2
 PCKT+VGnhHSU5xJHMRS5YlZHwO9u5a4WHVP40azZp9no48yD5P6AUgMGoZqyWnWADNkR
 9PRfvj5wpzMjDXLtdKZoluZKi9ZWeN400pWbSuMIjEC2rmyyGhtwGHnmorxgN2kap60s
 q4R7oDUdrZsLJ1GPLRiz1wQRFrTwCox7QjNTtGNfLzqLeZsNOJU34NAwl1kh8QMZ6QjP
 MB3QUZCvHgAPnnbvCrra5MddHESW0HK3UBbyjaaE0uQpkG9GlZpodV0+/S+GJMKEQ5s+
 CxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717472181; x=1718076981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zK7d8lrbqpLLcnaE4mD0Hd27GLT/1ymJeLeR22esD2Y=;
 b=Xrb5ALT9T4duIDwyMe0wQCb6Y784ACk48cn5OiqOIHV8TLuo4XZB1Ex78djGIAIiTG
 W7uT6ecUZwmnWHDLrsZ+1+IsiE1eUmT5y2j5LZ1r5cBGCvcjPhRgmomuYVGbl+uSjKOn
 u3XKZy5HlilzFzSRZxdGNp4qAOcRfUTIoJG9+HomPNxfmx7cfTtrWfQFPn8CqJkh3bff
 T7woxMhL3yuLwCcT2l00O7XqiH8Plx0Szxuy28gXEu9XJX6ghCcV/cl25LPcdy2qP9Hy
 S3niOf/sG0jyn/XGQ5L/AlTxi51RPTpE2zbC5OURfw1QQ6otpkmWrdqa1QEtDGtOZ0WI
 41Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiEiIY9OMo4/9jGMePL30Agf3m7/cb/rXKYm8CPhD55OxBaFP0BZXo4w5oS0xgQ7N0EYgpXa7GtCw6CY9zpT8IOgmSvE9L+EW9bqb5RG/fXAkk6AjQrdQa7fhVoQ==
X-Gm-Message-State: AOJu0YwWpZpLeWHVnOK/AsAYrecgcDo8Poj8rmKg4bCaPKfUhYHQFspb
 Nql76WnPGZG/Z+8PU3LFzVqlIkOvg2BCXRrdfQdPIcRqxkzGc6H9oMIgrjszv/3aA8balhBrSAx
 VNaYPE8xUJi1g4UvlLYwOEd86JwNTwREx
X-Google-Smtp-Source: AGHT+IEBLjlOIZAI20VDNnU7DZXnvpz7l+vEyADjhdKvHVY9AroRKPqyuFVhRezVJ+csZYj22KtDdbkdyGK/3Zu0tl4=
X-Received: by 2002:a05:6102:80f:b0:48b:8f15:ec93 with SMTP id
 ada2fe7eead31-48bc21cc3bbmr10319959137.18.1717472181423; Mon, 03 Jun 2024
 20:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
 <20240528130349.20193-1-jerry.zhangjian@sifive.com>
In-Reply-To: <20240528130349.20193-1-jerry.zhangjian@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 13:35:55 +1000
Message-ID: <CAKmqyKMEMGPjPMR-RJh+ohNtB7r69Y=2zy0_HGmUJ9HNhre-yg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: zvbb implies zvkb
To: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, frank.chang@sifive.com, 
 max.chou@sifive.com, paul.walmsley@sifive.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
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

On Tue, May 28, 2024 at 11:05=E2=80=AFPM Jerry Zhang Jian
<jerry.zhangjian@sifive.com> wrote:
>
> - According to RISC-V crypto spec, Zvkb extension is a proper subset of t=
he Zvbb extension.
>
> - Reference: https://github.com/riscv/riscv-crypto/blob/1769c2609bf453563=
2e0c0fd715778f212bb272e/doc/vector/riscv-crypto-vector-zvkb.adoc?plain=3D1#=
L10
>
> Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>

When sending a new version can you please include all previous tags
(unless there are major changes)

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..f1a1306ab2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -658,6 +658,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
>      }
>
> +    if (cpu->cfg.ext_zvbb) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
> +    }
> +
>      /*
>       * In principle Zve*x would also suffice here, were they supported
>       * in qemu
> --
> 2.44.0
>
>

