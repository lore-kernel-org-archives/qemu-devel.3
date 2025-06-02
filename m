Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B09EC5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLy24-0000uI-Dx; Mon, 02 Jun 2025 01:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy1i-0000Ya-AT; Mon, 02 Jun 2025 01:48:07 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy1f-00079W-Q4; Mon, 02 Jun 2025 01:48:02 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c5ba363f1aso559166085a.0; 
 Sun, 01 Jun 2025 22:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843276; x=1749448076; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG0M/d5lGeso/6DJV8efcIfN29HBXUxwXNQJFtIUrag=;
 b=FVF18xTx+C9XPOYWOT57v2T2kOkIthvqcN7rrzGpqek9hlRP+H5q2c2ZBVhPQ8VOaj
 ZmrZYvaOyEsIj8qHPtZS4jVwQ1AJcoNDr91yM9bLTlprvwbHQvZsB/tVr34D5XoFM9De
 ywhko5tGM9nZ0cfVMbS2ekJffvoKLt3EkvVUczb2Gn3fVjoK6A0Gw37lHNoCXPXcUdiX
 jxNYS4Skg8g5sjKGc+gNuK/iXoU+T3dLOuIQEntDECovEWi42egkjJfQgiQJIvDlVLRJ
 jgZ2A2FzLOLVrkzZDwYLZgL54SvqPpF4wNLf7km3Mc6exXki7mMSKEsLt7CFi6rR2bEm
 MCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843276; x=1749448076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG0M/d5lGeso/6DJV8efcIfN29HBXUxwXNQJFtIUrag=;
 b=H7swZpJ5ZyWoQ+3oQpBdD+vqgHU6DD6yGQJOOlvMIOaqrHkng3aEmXWqBdvllcRhyu
 KglM9eDsrQT6Fa9Jx5VNsLQHWcAarBS0+IePZex3sD63h6HCzCkFdW7PO/vDeV883Qrs
 4aJqisQqb7/BE7NBUfxdndfJHK397M+MjKkpzYzuUS9TDcnSuYUAuLQzz6uDlkSbSNzA
 uTPbUkz+JlmJyH/nvfgM6yebuUSTATVXwUbo9y6iOnVMvNc1oGjyNuklcZLRLQQlHkcg
 F7NximJExQA8fi/qHY7gZ7aBFYYkP2QiG3P3llh45jeZEU0xcwN0Wj/VJ0WK2OYheQqS
 37/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKw/KIsDjTcUsA8zwY8dOXYOMh5VfLFOpFBeduFisEd0VlaJ7r7JJwuWyYO7A06DQXMt08LLgy7e1Z@nongnu.org
X-Gm-Message-State: AOJu0Yy6vRz3GRx/HK2eGacu4mL8EDfAfWhUdsGqh5/BsKL6HU4banb8
 uGQ54jivmuCfkZrkuc2pxRGf7LBeAekshHdKRqEKS7mR/wd/sBXFzOVHvijjBpXII12yhwnwvLd
 QjvqjMgdIDIt85AksqdWUr/EZ/JvlE0wCZg==
X-Gm-Gg: ASbGnctuPDouqPPy3sR1/SwcM64LKY5CCgd1i7fs6xQBzqGplkqnqPrD1avb7J9r1N8
 seA0lMqcWOkIJqNJ2wRT+GIRxMKbi6ShDWpynUKIqMW3AeNDOs8W6uzz8zaLK1kb3PYWM4zjwy9
 b6Cs1SN38FUHf28yOe1RvqSO9UEzaxJOojl4rffVi8lCGU53XYBrkEH0HsAbUyrp38CIpvAcgDi
 A==
X-Google-Smtp-Source: AGHT+IExRxPCtmFx6OVQ7wCC4edrqy6cN/7l9+osjos9ktnIy6YqB7JwrvxadcMLGLXaiCUBE8jr5olV0wM04+GEk5o=
X-Received: by 2002:a05:6122:caa:b0:530:5fe5:7ea4 with SMTP id
 71dfb90a1353d-53084d9dbcfmr7992114e0c.11.1748838648524; Sun, 01 Jun 2025
 21:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
 <20250529202315.1684198-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250529202315.1684198-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 14:30:22 +1000
X-Gm-Features: AX0GCFs3LLORPMCIEwmfqBaxHwzAlI6uAvYDSpIWEDv71VyN7Z_4kFj_u8Zcnkc
Message-ID: <CAKmqyKMtuqguqe814e6UwyOhEXXXLapAZzbuD+mP2eQoF6tjvQ@mail.gmail.com>
Subject: Re: [qemu PATCH 1/3] target/riscv/cpu.c: add 'sdtrig' in riscv,isa
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x736.google.com
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

On Fri, May 30, 2025 at 6:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We have support for sdtrig for awhile but we are not advertising it. It
> is enabled by default via the 'debug' flag. Use the same flag to also
> advertise sdtrig.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fe21e0fb44..9d6fae72b2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
> +    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
>      ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> --
> 2.49.0
>
>

