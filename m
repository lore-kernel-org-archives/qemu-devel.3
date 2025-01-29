Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95A8C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwcV-0007bJ-SA; Tue, 28 Jan 2025 20:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwcU-0007ap-4E; Tue, 28 Jan 2025 20:11:54 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwcS-00075y-LZ; Tue, 28 Jan 2025 20:11:53 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5187f0b893dso2029738e0c.3; 
 Tue, 28 Jan 2025 17:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738113111; x=1738717911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfzIBpiOP921J9whQs9LXBrgumMwFEAqWmhvUi7zBak=;
 b=BGHbzOVwlBygWSbsBIytr6vKb4q/G3RpRkQv84R0vxGTWs3Jgpj/d0fq2Qjyt5Rvfo
 e5qP8BYEBHm7pNcUCXKbRGv33DqfWCHzlXBws2rnkwbAJk6eS3ufOv5alkSLkEsx2six
 4DeKnCYeMGR7vT0zIHOCvVE/pYQzrijgctf9RQW/544hBg3O8Sa62Irzpernp1mzK3wh
 2TdFMJedJ0kn+vowKwE7i5gFvWPoeitHNcG2/bIGjbUeOvEGE09RHuNNOC1Ljbg30Rlf
 gaH8dIuNQBs17PQwtkP0nVFQ40jPlCrx62l15GZywwR1Pm+qDxmGXWdwpmkfR5A1mSTo
 nyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738113111; x=1738717911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfzIBpiOP921J9whQs9LXBrgumMwFEAqWmhvUi7zBak=;
 b=Uz0PFA+BMEAu6KBf+GbVel0NBec/+OfQhWgqH6xfIOgga7spFA6O6ICP57tmdubff0
 NR/8l3UYkxs7daat7WpTwAunjdB9FbDlaaODGIkV+rliKl0OpVVXq70u2/c9ZRssMebr
 hsVFrlI7HVgfQomi/iN7LXb0F9CZ20CQ/R2ZHWNUW1qIaGCuZEjYSMAPc+EdwSNq0eUy
 ZaNUQmc8R0DqG3mVarplfU7OymcTIeRGicONOsP4m2YTM56bN6TIdeEyTUXmrtBNOQX5
 UVJBcfkgQhvFCzvPUKTDzU+wddFO3rQSRssUnvyIQCEHX7vl+4YbMKKwQdPMjo6AcNA4
 6njg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9fyjp2VORxP5+gZHidnHyfz/PZCGx4swEQKj+THx061D0hzvJozKrhITPH6QgSdydPbaS9+LUysvt@nongnu.org
X-Gm-Message-State: AOJu0YzMwJLzJqm2A22tVKMMrmV5QIHV4e69fkWQ0XaoSUliIBDfcyhD
 wXBCYdn7mKI+TtQ8pT590hV/eHczKbyMdHxQo2DrqkwbVs3Lh+jMKB8K2in2cIxttx+RbKvJ+me
 qqejLGcPd30M6IBlujYBoSFs5c6g=
X-Gm-Gg: ASbGncv7mRRGFMQilEgC9r3K2KVNb8v/mbupTUZkB9SdtfRgKHKVkWqed07kwzidxeh
 9S5y2S59DHiUoAjZs88S53EOp73+zZzXgVUx/eLenzQD6BTJrz+uCmCu3SDIBU2stN08/z5lKBa
 J+UvncbshvVepttP2myqHH4TarlQ==
X-Google-Smtp-Source: AGHT+IFz0nFqhPlaYgixpMgb90iK2sDHqdVnysjjoCOF6jZj6fh0myRcX6RsruH2UW0MVeDqyjJAOE6MZos6OSFQ/Bg=
X-Received: by 2002:a05:6102:3f56:b0:4b2:5d63:a0f3 with SMTP id
 ada2fe7eead31-4b9a4f9543cmr1243780137.15.1738113110700; Tue, 28 Jan 2025
 17:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250114190001.1650942-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:11:24 +1000
X-Gm-Features: AWEUYZnQwbJNyBeq9-11zs_vpaCvAyE6ehQ_6rmJAAbBpjrctV3e_UUUevrZWnU
Message-ID: <CAKmqyKPqGjJSrGWk-mpKSn8V_Nf9ripuRr0epH_bJq+BDtNP6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/riscv: add ssu64xl
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Wed, Jan 15, 2025 at 5:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> ssu64xl is defined in RVA22 as:
>
> "sstatus.UXL must be capable of holding the value 2 (i.e., UXLEN=3D64 mus=
t
> be supported)."
>
> This is always true in TCG and it's mandatory for RVA23, so claim
> support for it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                |   1 +
>  tests/data/acpi/riscv64/virt/RHCT | Bin 390 -> 398 bytes
>  2 files changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2..b187ef2e4b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -213,6 +213,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/=
virt/RHCT
> index 695022d56c4ac16607d4c622955ad339fbbfe997..b14ec15e553200760a63aad65=
586913d31ea2edc 100644
> GIT binary patch
> delta 48
> zcmZo;?qlW(@^B96V`N}pOqj@Jz^cQ@$e^;(o|BQSxYW#~B4@H2qXkC_BLhPoBLf2f
> D`wIz-
>
> delta 41
> wcmeBUZe!*O@^B7mV`N}poG_8gfK`Q&kwIpoJtyPj07f&87)Az$G)4vn0JA^`U;qFB
>
> --
> 2.47.1
>
>

