Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA339C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 23:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdeL0-0003lQ-Su; Thu, 30 Jan 2025 18:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeKu-0003kc-Br; Thu, 30 Jan 2025 18:52:41 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeKr-0000Yg-Hg; Thu, 30 Jan 2025 18:52:39 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5189105c5f5so874740e0c.0; 
 Thu, 30 Jan 2025 15:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738281156; x=1738885956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPXY8arDHJLDr+pdRcwL+tD8v7nZYWGYRrbL6l6QYvw=;
 b=JlRkQIDjYW3h8Jd9QNkji7A2DzVg71ckN8Cp7Dbwpmr0tAYGNliMe0Cj0dBLxYPSgd
 irCYdQbO/JDytMFOOR/Yfr43XHweCtNQL/Y2eZYeUzZJGBOCBXRo75s2SlrrF9PNHjwg
 TrBhBDuwWzii9EPhU8vw7ZSut9ok7HQd9RLY3LSL+hqyN3DXS79NEEvYRvtnfzOmHrPh
 WWgCZWMtsYJtwZsIxb513jXhOu1lk9u3oqZysRouvf9eJDx4MyWtiHQMqGHMjy6fkoE9
 D0t0xFq90qmOCT7AQvJLa/zTwZNrigvY5mSZyO2NmIBXyhbpeiHYP1c2WHeunbQcnYCW
 eTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738281156; x=1738885956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPXY8arDHJLDr+pdRcwL+tD8v7nZYWGYRrbL6l6QYvw=;
 b=DHFp+ZfNrEFh1QhJQsoSFmtILMpiL+G732dZM/pk2VA3GAfZIwZkJU4Lo32NquT90p
 WHaRhkc3p0JcN+4P5asQicWvzRSI98C9b7lCEZiH+jtFIeCN/vF9I64fEi+nAylqYEhB
 EvwgQHuRFsum9hFhfLL3QrMO5sEZeCqHc8zWAIztj6EEdvZdEDdLZ9UnCP/0lkU95zDS
 TPZeSjynz4sA9TNg+3NzNaYUt5IHjh8XcxF1iD6zE2H01aRv5mY9I5Ww5a5oYO0VP323
 oLrcX2vB/9KlEaIKYmpmoWHscZIAV75kiD4VJ1pVfGchL58G7fxJupGRdVqwathUtQMb
 P+3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBA6HI/chfzA+w1YwJaUfch9J5wkfAlgc26NXogiC8tZHpYPY7x/t2Z2aONYE4KgTVIniRakANcunf@nongnu.org
X-Gm-Message-State: AOJu0YwvHhlpK02h2ghfE+ZgYuURa9aM3tihPAb+r1M4p3wHLaxaqnR3
 L8Pwu1qua/V3PqifCJE5T9+lQh83BxYPUUUi2ScCrKBHi2HuWlieIoIVj71ZQr3ZtLW0D/Dmhzo
 g5wcdPPm5DbPjbMB9dJnMbDkjX4g=
X-Gm-Gg: ASbGncuueemyUq/pxzkVvEXvsbiavsyPGV0/AnwA4b8fvOYkkLbkVqgMKxfhGzJNQqd
 uVxx2ABIqnlwr7lU+9GrnJ4+4srTtZuTjoCwbemrlsN8uaI5t3mnuuw3S9IRQ+KdX/v7ScjLl21
 77SppCgRk60ZcxOx9f9xIm8KbxDm4=
X-Google-Smtp-Source: AGHT+IHCkAavOwKRMcWpWaOc+Pbwd4IwLOjzfXkz9cLIu644NrYLlf8UMttK6o2FWoI1XSDuAzRKB4++ykagR0Ddu7I=
X-Received: by 2002:a05:6122:4089:b0:518:a287:56e3 with SMTP id
 71dfb90a1353d-51e9e4df5e1mr9732557e0c.7.1738281156141; Thu, 30 Jan 2025
 15:52:36 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
 <20250115184316.2344583-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 09:52:10 +1000
X-Gm-Features: AWEUYZnNdY1bxehgXEhrHM0qwuPI1Fs4mhBIpljUs-8LUQJJOW-EPVIDvFg8sh8
Message-ID: <CAKmqyKMWm+OqL1k_1QsA37P0eUXLvyr9Q0+q8ngK52hbeZK_Gw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] target/riscv: use RVB in RVA22U64
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Thu, Jan 16, 2025 at 4:45=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From the time we added RVA22U64 until now the spec didn't declare 'RVB'
> as a dependency, using zba/zbb/zbs instead. Since then the RVA22 spec
> [1] added the following in the 'RVA22U64 Mandatory Extensions' section:
>
> "B Bit-manipulation instructions
>
> Note: The B extension comprises the Zba, Zbb, and Zbs extensions. At the
> time of RVA22U64's ratification, the B extension had not yet been
> defined, and so RVA22U64 explicitly mandated Zba, Zbb, and Zbs instead.
> Mandating B is equivalent."
>
> It is also equivalent to QEMU (see riscv_cpu_validate_b() in
> target/riscv/tcg/tcg-cpu.c).
>
> Finally, RVA23U64 [2] directly mentions RVB as a mandatory extension,
> not citing zba/zbb/zbs.
>
> To make it clear that RVA23U64 will extend RVA22U64 (i.e. RVA22 is a
> parent of RVA23), use RVB in RVA22U64 as well.
>
> (bios-tables-test change: RVB added to riscv,isa)
>
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#6=
1-rva22u64-profile
> [2] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.a=
doc#rva23u64-profile
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                |   2 +-
>  tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b187ef2e4b..6fb4d5f374 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2351,7 +2351,7 @@ static const PropertyInfo prop_marchid =3D {
>  static RISCVCPUProfile RVA22U64 =3D {
>      .parent =3D NULL,
>      .name =3D "rva22u64",
> -    .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVU,
> +    .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
>      .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
>      .satp_mode =3D RISCV_PROFILE_ATTR_UNUSED,
>      .ext_offsets =3D {
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/=
virt/RHCT
> index b14ec15e553200760a63aad65586913d31ea2edc..13c8025b868051485be5ba629=
74a22971a07bc6a 100644
> GIT binary patch
> delta 53
> zcmeBUp1{l%<l!7LfsuiM@#{n`13^7TMg~>JqB1j+%-qDZl;ot1UQ&#clNpsc(ij;S
> I3K$s}0ARKZK>z>%
>
> delta 52
> zcmbQh+{ern<l!9B$H>6Im@tvcKtP9)kwJyAsLaeHGdD3UC3&N_6yxMHMkS6EMh1pF
> HMg|4|IwT82
>
> --
> 2.47.1
>
>

