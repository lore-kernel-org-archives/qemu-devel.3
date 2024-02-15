Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDC6C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 04:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raTfE-0008UD-Gl; Wed, 14 Feb 2024 23:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTfC-0008TN-OE; Wed, 14 Feb 2024 23:47:58 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raTf9-00059I-Ij; Wed, 14 Feb 2024 23:47:58 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d5c2502ea2so186913241.1; 
 Wed, 14 Feb 2024 20:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707972474; x=1708577274; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65XFCqhYqoLJKgev2xxUvzFwmKlhLQa7AfYmZ38fUqg=;
 b=Mz/SiRpe4if23pZ17pFskzgNFtKJipiCTQTbu9kVnLm0S+xypPSvrszXWV1fm5T+ib
 V9tNF5WG1xn6t+q1qbQtYIGe+kuLrZVpgdsjZDOKgbh3bE+rkydsKbbvZPy5CI2vDbx+
 mDWdFvBZaW9liz0yEemQf2HqOvHbQFyFA2Zgd+JoZuZOiSq0o00aF69uGH5sXaqiLuYk
 RJPIMS0vS9A5uzH3B/TGO0/6fvE8Mm17UbA98ZkhNmSPAe+k3n21r+7JbzXMTpnUPa4R
 bVoynhHr/qazZr3SjJod+zDNFLS0dN2x9Vxs9Olw7laPZq1urN0sSLVdC1mhAarvBZEx
 4Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707972474; x=1708577274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65XFCqhYqoLJKgev2xxUvzFwmKlhLQa7AfYmZ38fUqg=;
 b=hQ24EeXLnpSwqHQ/SvMOHChk4Q8KOFQPzugcegHzqa2nErOiSZztLyyVq+acMGaPT3
 J8ZXfVlW8WBLBRBKJ57jB8r9vbuvC69Udb/ZE8ZAhoWwl/T/iDcumLtlcWgBBR+Bc6zz
 ViQy89bCPe6Y/rnNP3ozkV1ZJgmXgIZhv57pEA0xhHIEi6A+mlODyNRWXxY8UrK7Auoa
 ntapFgCcUXwx53N1V3yqHfc+ieKqKmrCBzzfqtLHI9RswtcRIPvhWe++ntw0h4nCVoaS
 1DPftZrAWyfUTMXXEIPCulEjv5O1969KOxo0gCvfs8KS7I6j/q0PvCbLmIYrvASUYCgf
 Z3uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI8MRK1UGscOlz3kXzf5NYWz/j2jRSYcP6N3TgfXWYK3+fGFuzUzoJiRm70BrrYEPRU5TDUyHa+z3ns2CnJsFJKsvOqlID/VUMVHTPyglKXomycCm7kUa08oYJzQ==
X-Gm-Message-State: AOJu0YypXjVEJc5h+mdnWR5aEzFMIhOLRsgH3E9TjewLeLanjL30MOpt
 /0TFlh51sqYf7T9EffOu4wIelkFY+rfbXAcF5shL3orA0WcisnsgHZYvuOQtWAP9qeoM+jqaR7Q
 JdaGZRFVWr9KYYdJ2JwO8FzcdchuxOGBq
X-Google-Smtp-Source: AGHT+IFsYbfgP49FXCkdnQpnQBgDbmn0uGqtDbmnSfU3fZKTKsxM+qYP75KdIY1Xn09QwAKsUolHghVM5T49U615czY=
X-Received: by 2002:a1f:e401:0:b0:4c0:3c09:6f34 with SMTP id
 b1-20020a1fe401000000b004c03c096f34mr530079vkh.2.1707972474139; Wed, 14 Feb
 2024 20:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20240206154042.514698-1-alexghiti@rivosinc.com>
In-Reply-To: <20240206154042.514698-1-alexghiti@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 14:47:28 +1000
Message-ID: <CAKmqyKOkEgaKDsEeffm8i=3Rw6pesUGT+pFcuZT8Gvk5YZ=gHQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw: riscv: Allow large kernels to boot by moving the
 initrd further away in RAM
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
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

On Wed, Feb 7, 2024 at 1:42=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Currently, the initrd is placed at 128MB, which overlaps with the kernel
> when it is large (for example syzbot kernels are). From the kernel side,
> there is no reason we could not push the initrd further away in memory
> to accommodate large kernels, so move the initrd at 512MB when possible.
>
> The ideal solution would have been to place the initrd based on the
> kernel size but we actually can't since the bss size is not known when
> the image is loaded by load_image_targphys_as() and the initrd would
> then overlap with this section.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes in v2:
> - Fix typos in commit log (Daniel) and title
> - Added to the commit log why using the kernel size does not work
>   (Daniel)
>
>  hw/riscv/boot.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 0ffca05189..9a367af2fa 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *machine=
, uint64_t kernel_entry)
>       * kernel is uncompressed it will not clobber the initrd. However
>       * on boards without much RAM we must ensure that we still leave
>       * enough room for a decent sized initrd, and on boards with large
> -     * amounts of RAM we must avoid the initrd being so far up in RAM
> -     * that it is outside lowmem and inaccessible to the kernel.
> -     * So for boards with less  than 256MB of RAM we put the initrd
> -     * halfway into RAM, and for boards with 256MB of RAM or more we put
> -     * the initrd at 128MB.
> +     * amounts of RAM, we put the initrd at 512MB to allow large kernels
> +     * to boot.
> +     * So for boards with less than 1GB of RAM we put the initrd
> +     * halfway into RAM, and for boards with 1GB of RAM or more we put
> +     * the initrd at 512MB.
>       */
> -    start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
> +    start =3D kernel_entry + MIN(mem_size / 2, 512 * MiB);
>
>      size =3D load_ramdisk(filename, start, mem_size - start);
>      if (size =3D=3D -1) {
> --
> 2.39.2
>
>

