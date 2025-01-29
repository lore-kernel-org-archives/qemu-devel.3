Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C215C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwwD-0007Eg-3v; Tue, 28 Jan 2025 20:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwwA-0007EQ-Gc; Tue, 28 Jan 2025 20:32:15 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcww8-0002MI-UO; Tue, 28 Jan 2025 20:32:14 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-518ae5060d4so1883855e0c.0; 
 Tue, 28 Jan 2025 17:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738114331; x=1738719131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDd66CP6UFkg12Zal74nSBqi1oirSeJQfa2FBkIje1w=;
 b=e4dN32r1iBwl90z3GIoJ7XzZ0/o6qwRm7YDmAcqz6T+VQo60Tgpnn1nCAB2ZRq2gBF
 t7Sp6wunKmvCu2mZawSxVWzrhYDkAZGnYYrkwZBTAV+OJJbeWSzdA2fr/tsS4gGHW+4t
 cj+3UVOG4eTbAWg13B1EzUUW/dJqJ/QGyE5dvlXmCFbBTJzzIfq+dd7zzeSbQdR64kWH
 6VNGmgmz5c7DcpPdy8jwkpgekgszTCkSI6WjGcbkcKCyfUGM5MEtO3QRUaFn2ABsEXwo
 QKl4O3d3Av1tYad9tkEHQCyI9nhp5xy2iUuAVx52Z1lxAHQEZBVVB2rMeV0Bv/xg0AD7
 HF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114331; x=1738719131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDd66CP6UFkg12Zal74nSBqi1oirSeJQfa2FBkIje1w=;
 b=SbuTxk3OtBSJLXZTm/lIXC06aaJdmEZMnoLPu5IAuEGhLGX5eh5kK7XPZaxhdJs8RK
 W0FDsgSZvG5g5BFBRhOXxm37JpNeC+KpCjTJ45F2jPDOd4WaCYhyuCfQy9BmKucenv+c
 dtHHY6PAosrCvUpLNjgVCS+3SkJOMk+ptTAvgNvoBX3PlI76IIbcsYEXapRCZKpt/Qw9
 Q521E6LIPXMulBewY6ENSDZ/4HnBb20cLnO61SlqLHuwlzFlSEoFSmFY+Oiu/uilAgHt
 rOuwkqr6CzSSQaVO+oOREG6N4w9p6L/9tkAPdBEMMBcJFj7BqwFSyO8yS1VpMK/x9DN8
 wVew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNtTrL9UsyMS26UW8nzQ52z4edm2t/R8krEjlIXybmgbB7EujXTAWikD8fk77NuUdvdnyMB1d9fLZK@nongnu.org
X-Gm-Message-State: AOJu0Yw0CH2ffNVlcjrjWOr12wGmzNfWdlt8GyG2ob9xUYTIuH0iehP4
 q9F1NQAHtaHhgUSI+o2BFZc4XhFtj1WYWd00fWl9zCv8HznrrZyVWrJDwltzaHWaChh1j/kRueV
 uNSCHgG15pXSEkNZW+oMuQtH5vrA=
X-Gm-Gg: ASbGncuP2nDgrllVpGk0C8yqedu7FBxXGPF2jHbc1Cb23kk0fdsS7TZ4EsWc+3giilG
 2nS13r7qaXMrMw04m1iP8Y1GmFmlriB9pfNL++OXclcnhmZI/gNbiKDrSvlvnxmEvDQ1wfq620E
 fRNbV0+p+3vwXnwDhvaXrPRKYniA==
X-Google-Smtp-Source: AGHT+IF2oi95A+RGaTwsbi8a9Ny9RndMWYbs4BbcJ7FJH5jhJQCmta7TI/HQ4BjeapvNQA3MIPQI2Ay/NHMW1pMFduk=
X-Received: by 2002:a05:6122:1c87:b0:517:4fca:86e2 with SMTP id
 71dfb90a1353d-51e9e55009dmr1646575e0c.10.1738114331500; Tue, 28 Jan 2025
 17:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20250124090539.2506448-1-max.chou@sifive.com>
In-Reply-To: <20250124090539.2506448-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:31:45 +1000
X-Gm-Features: AWEUYZl0FHbAzWllC-f8KHh0C2dNzt5v_z_jma9NJFdufcvSwA4LGRNaj5bs38Q
Message-ID: <CAKmqyKP9R7p0YVEmjj4QSvz46JSXZEut9NRnUjTxQw-PJHujug@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: rvv: Fix incorrect vlen comparison in
 prop_vlen_set
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Fri, Jan 24, 2025 at 7:06=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> In prop_vlen_set function, there is an incorrect comparison between
> vlen(bit) and vlenb(byte).
> This will cause unexpected error when user applies the `vlen=3D1024` cpu
> option with a vendor predefined cpu type that the default vlen is
> 1024(vlenb=3D128).
>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3d4bd157d2c..2f53acbab59 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2034,6 +2034,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
>                           void *opaque, Error **errp)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(obj);
> +    uint16_t cpu_vlen =3D cpu->cfg.vlenb << 3;
>      uint16_t value;
>
>      if (!visit_type_uint16(v, name, &value, errp)) {
> @@ -2045,10 +2046,10 @@ static void prop_vlen_set(Object *obj, Visitor *v=
, const char *name,
>          return;
>      }
>
> -    if (value !=3D cpu->cfg.vlenb && riscv_cpu_is_vendor(obj)) {
> +    if (value !=3D cpu_vlen && riscv_cpu_is_vendor(obj)) {
>          cpu_set_prop_err(cpu, name, errp);
>          error_append_hint(errp, "Current '%s' val: %u\n",
> -                          name, cpu->cfg.vlenb << 3);
> +                          name, cpu_vlen);
>          return;
>      }
>
> --
> 2.34.1
>
>

