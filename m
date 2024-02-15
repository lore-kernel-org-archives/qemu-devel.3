Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219AFC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raSkg-0000VG-0p; Wed, 14 Feb 2024 22:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSke-0000Uz-4j; Wed, 14 Feb 2024 22:49:32 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSkc-0006Mm-MO; Wed, 14 Feb 2024 22:49:31 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4c03b2ac77aso156720e0c.3; 
 Wed, 14 Feb 2024 19:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707968968; x=1708573768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTP9V07a3lDXWBNdOGbSze+MBHTTKrjU7ZinfKLbtrQ=;
 b=b/rfg8cVAJm71S5w7vNbn3HL54P1fo93nDsnTdPMJFw2L0+PzWsb9H92AV8tg1C+Kq
 2oSoE+cCgGtdHQH7x7YwhguAXEAajxfWICDD5XMZVkMbUPLDzucEu+mrq5kjQ6GJQLy2
 uXoxiLKPGqmUd1CHSbSOHLZjOXtlYY2UetJHoeTQLgc8D63Ay7/CAAIVh+p5WI8ay0u6
 Ga30aU9w3ztv2M7eFA1kE7d1tgaAuu1gYBHg2rgSmr8xOE8c5APQvNlvpXtSbjRVr4da
 8y1YmLTXQm3fItmGwOcJ+jBw6p50no0pf3r7CQWlav2Yi85iqcI/nCnMX9GBl1CpFigK
 0o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707968968; x=1708573768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MTP9V07a3lDXWBNdOGbSze+MBHTTKrjU7ZinfKLbtrQ=;
 b=v44NxCZwjpeYqUGp22whw6tGYP5EwBrbSdBN5WrWc4YtQsr8RbYSf8ICowLbQreNyv
 d3J484Lf0NFDLp2VDv6flRJR6PbA5ywNdxmVqlFU6KEnUtIF9mAu69EBe8GgRDlPa3Gi
 udHN3DkQ1FeNzM00rtr2NjnFI28EywIHH3D/IvpCj5G7kd4zv6w3gQowu6yMcpHIeNDz
 N7VpPcP7wJB1xvuy6Gj7NCvrMuLS0bCPh+uhuU9EMbemfs0RvbfJBgO6OhUgAOEhWJf9
 xpf468D1m+vjf8AlOxoU3CQ5BseY7YxnMYYarM1OuIP91sQU10FWmOOsNeaZJ2nDzcR4
 Tj4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdD3OHx9O0DXVHSvn/MobUghJ9uyoC2hvwRQOGa6NTM6gy80u721QZy3zNbxy6ruWG0Rj3A21SuRjtWMjMUqv3Su5IsrA=
X-Gm-Message-State: AOJu0YwljCyUuANmNv4+9EmI7UPFfHjkhlBMVUrbV3MydVoU3xZij4wX
 +w9M1200KehBVzGW90LXoYNUcN+kZ+UnOy2DIcIVPUWEsW5R5Ot5zh75VBIPmUvYgQYGRrvv2XA
 DtZCd9VEIhxtBaOXch1ZsCjE5PSo=
X-Google-Smtp-Source: AGHT+IGnAjH+hfhEsXt0CGKItMfryyc5g3haeJeIARZaMiOirY5sJoe7D4mMAg/y9aud/n42D2q3gyLwKq2VlPrqUYI=
X-Received: by 2002:a1f:4907:0:b0:4c0:3ea1:a4a0 with SMTP id
 w7-20020a1f4907000000b004c03ea1a4a0mr290516vka.16.1707968967635; Wed, 14 Feb
 2024 19:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20240126133101.61344-8-ajones@ventanamicro.com>
 <20240126133101.61344-9-ajones@ventanamicro.com>
In-Reply-To: <20240126133101.61344-9-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 13:49:01 +1000
Message-ID: <CAKmqyKPhZ0WDbdAobUbH34bWoFEW_miSN8yzR2QhFCY1HoJVAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] target/riscv/tcg: set 'mmu' with 'satp' in
 cpu_set_profile()
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Sat, Jan 27, 2024 at 12:18=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>
> Recent changes in options handling removed the 'mmu' default the bare
> CPUs had, meaning that we must enable 'mmu' by hand when using the
> rva22s64 profile CPU.
>
> Given that this profile is setting a satp mode, it already implies that
> we need a 'mmu'. Enable the 'mmu' in this case.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index da437975b429..88f92d1c7d2c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1107,6 +1107,7 @@ static void cpu_set_profile(Object *obj, Visitor *v=
, const char *name,
>
>  #ifndef CONFIG_USER_ONLY
>      if (profile->satp_mode !=3D RISCV_PROFILE_ATTR_UNUSED) {
> +        object_property_set_bool(obj, "mmu", true, NULL);
>          const char *satp_prop =3D satp_mode_str(profile->satp_mode,
>                                                riscv_cpu_is_32bit(cpu));
>          object_property_set_bool(obj, satp_prop, profile->enabled, NULL)=
;
> --
> 2.43.0
>
>

