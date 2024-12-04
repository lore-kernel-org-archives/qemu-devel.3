Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D466E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgOc-0006oL-RJ; Tue, 03 Dec 2024 22:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgOa-0006o3-39; Tue, 03 Dec 2024 22:49:49 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgOY-000514-Kt; Tue, 03 Dec 2024 22:49:47 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4af173cd0e5so2015030137.1; 
 Tue, 03 Dec 2024 19:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733284185; x=1733888985; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro1YTfU+1s6I2NYI6E9syeDwVIyOo446grleOEQTVXM=;
 b=Jl7R+JqePp3tp4IUhQgpFFl/FJE93P4joEmMn9srwFBfcYMgMoRFCrEHAzliXp7XSO
 GdJyUpw6x0T0crxcqGblLdvgMIQYJBILzI92AY7340VQcS8NA+qws5KeZrF7d38iYgX1
 k+yBZkNHublNxzZctM5Uv/uMbmkQh0WMqmNKdaAN43nOo/HfemFnz/F146xIqtq2jKYk
 5hJgfGVGQHECoaRQDolghxO7BvtOm2gK14LxKyhh7ViFWa2FBoonIuJjvC+vITi+BlzQ
 Wipkt88XrS+wojFro+H5gXiUaYqgWjrdrkyTV5yQEldF/JZAi8/7VLHy/J+NVhEQqJGw
 sRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733284185; x=1733888985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ro1YTfU+1s6I2NYI6E9syeDwVIyOo446grleOEQTVXM=;
 b=fKh/qRJ4bazay8OhZAp6C4yhVreIoVhtG4jVodmlQhh7/NYF2SBSeRFJYqhTckOHiX
 7/3JbBCqgA8dzqxUg8zYf+g15fQytT9OsbDk0RtB/gaLkERf3EtB7GoizT+ev2nTV/QG
 VUV9vMt778MTcnhDzpQNRR5CejAG7Y6m6q0/Koj0PuS8QsDMiBzvney8iwtjcg6FCsOW
 gHylfI2tUBHOV9ECFKNugDZntriDaX1yMlGL5Hiqwlo5RGPxM2KpbvwOgCLCLzHILaRB
 UKRzx3rAWvvZeePFNQ8PuPVr1zQ9kHZF6PHfGUPzGF8PLLuPiIxIK51FFJ+Iz6sGj0S8
 Jq1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFny2GvBgEWmtzfhxspDVMP0K2+vcWgXaO/ruy3cgm+yBXO7kZDYng6kfsb63mMi8t79/vBRYwgGVV@nongnu.org
X-Gm-Message-State: AOJu0YyypihSN8+vJo6PFvXmz3bsAjnclQfOXFkL3UJPrQIrmdfYYjAd
 dbStGjTd8FWcQ9ZypgviVjJAfH8zFgd7rSqrBOgSI2yMm0JW61AxWW9oUaXrHEg9G3Ftmf25V7W
 wtbbOesygNJ5mr7SXuPYirfloc5t/QGk3
X-Gm-Gg: ASbGncu+lss8QM71XSFSBgVeQKgh62rhAXYy79AX80F2M+MXJSubpDJPDnYr9vZ7JjS
 Nc1M7K1zWnVg2udV2Z5K/cS4dx3Fz3Or+
X-Google-Smtp-Source: AGHT+IGyVe7uZI7e4J57HpHnSTc3YQ1c/pz2OWW6Vh6hvLDu1TTP5sISvbk6+0dcOzlQ/biUSrzM2T2b/6Nie6J2To4=
X-Received: by 2002:a05:6102:a53:b0:4af:5950:29bf with SMTP id
 ada2fe7eead31-4af9716285emr6966092137.1.1733284185239; Tue, 03 Dec 2024
 19:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-5-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:49:19 +0900
Message-ID: <CAKmqyKMw7evaYyhdNHpXXBZ2X6aiqbbjkkxs9S1KPuV0Z3rvjg@mail.gmail.com>
Subject: Re: [PATCH for-10.0 4/9] target/riscv: add shvstvala
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shvstvala is defined in RVA22 as:
>
> "vstval must be written in all cases described above for stval."
>
> By "cases describe above" the doc refer to the description of sstvala:
>
> "stval must be written with the faulting virtual address for load,
> store, and instruction page-fault, access-fault, and misaligned
> exceptions, and for breakpoint exceptions other than those caused by
> execution of the EBREAK or C.EBREAK instructions. For
> virtual-instruction and illegal-instruction exceptions, stval must be
> written with the faulting instruction."
>
> We already have sstvala, and our vstval follows the same rules as stval,
> so we can claim to support shvstvala too.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 6bfb1b1530..11a0d2d04a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> --
> 2.47.0
>
>

