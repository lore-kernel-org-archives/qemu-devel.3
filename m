Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81431C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raSfi-000714-R9; Wed, 14 Feb 2024 22:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSfh-0006zW-9p; Wed, 14 Feb 2024 22:44:25 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSff-00054U-R7; Wed, 14 Feb 2024 22:44:25 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-4c03beb85f4so136312e0c.3; 
 Wed, 14 Feb 2024 19:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707968662; x=1708573462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xg45U+LGB/3Z91KOOKjGOKytTJWOljhWEztTKfhaMWQ=;
 b=KnhZOX+6e7gGwPEbMvWrA6XnBG3SPmOpuSwMQiKCMg7jJWDFWn/ic7NGDN+gUq+/uP
 Ni+fLFfNMl0iI4x9bTA44n6zc5JwklJYWDjmj+cQrBag/Y4dAgIjof4/dOfcqgtfjwUj
 E9UnPJzgA1CYFaQqoLNvzOmk9o8khaScA725Y/iFXKY15JZyR76K3yByTxUlYR5tIcmr
 A4wE28DpmdzIRYX+5q4cCwUsCmdTh2PCRDF2shma4x5W7Vit+MezAUkWfIw4/zHKXv7P
 WOiUmNOULE+uNukAo8t/YFxLbmFDEpMe5ivVdKEM8nygZXKbslHt2XM4LX6RWnl7usui
 Mm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707968662; x=1708573462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xg45U+LGB/3Z91KOOKjGOKytTJWOljhWEztTKfhaMWQ=;
 b=FdMW8pGdEcCpPM4XXLI6iVCww32x3sIvR4aIsnSeeuZ578DeI/81S84Mv/wMxrvW/L
 SbIAAncrCHgA/F6anwEH2B0nwp5QpHD39yVOBGokCXkYKPLl1wE2fwox81+MpBjF0xCQ
 QOCgpEAgczOT/WkWQ9nLbSx8xYlCCULkYRvYdGCDY10KlEjyeRqyU6m8tqszvam0e4H0
 kwmicVrCR/uAxgLS0PI9M9fOEQGnz2Jyo79v2VjrIWhpGaWcWkXyYFDcpW7u0orksStT
 DNgXfdTXBn0U3REjeV5oNljW/oEFdapiRLJR19wSQmV3TqgS/M/mooyL2f+z5GmalWEf
 /jyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUli0fmHFIIX7YHwhtFnK5BweysLjWm0Q2eY+kDZbpK+WFciBhWQbrfmhiWxUs7puWy96l1C/S2WNDgUrNJRPyBZxZro8E=
X-Gm-Message-State: AOJu0YyxqOy6aMd+aG2xnrqawMx+XfLbXHcWE3bmj5ynVUldXVglpz+G
 ERaeyVeNrMWgJg1OHdNrrSY6Zlm1iO9H5FMbmm7Oj/eyS1kVK/8isb6ij+qSYITY+2fpy8pK40J
 gb1aLu305Vu+O4wtDWiSjycWdafE=
X-Google-Smtp-Source: AGHT+IHow7+H5AKYpRNy/Gjnqj7UqYbammXezmkE7A9/5EEoluQdFhHJDBTjDcQysJ05riRi+huNr/U38ZTTsctGQTw=
X-Received: by 2002:a1f:dd02:0:b0:4c0:1937:d29d with SMTP id
 u2-20020a1fdd02000000b004c01937d29dmr516374vkg.6.1707968662269; Wed, 14 Feb
 2024 19:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
In-Reply-To: <20240109145923.37893-1-irina.ryapolova@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 13:43:56 +1000
Message-ID: <CAKmqyKMpdk0p7g_MYANKNy_O5kTqO1j-cwqtxGq4Fftkdpta=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/riscv: FIX xATP_MODE validation
To: Irina Ryapolova <irina.ryapolova@syntacore.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
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

On Wed, Jan 10, 2024 at 1:00=E2=80=AFAM Irina Ryapolova
<irina.ryapolova@syntacore.com> wrote:
>
> The SATP register is an SXLEN-bit read/write WARL register. It means that=
 CSR fields are only defined
> for a subset of bit encodings, but allow any value to be written while gu=
aranteeing to return a legal
> value whenever read (See riscv-privileged-20211203, SATP CSR).
>
> For example on rv64 we are trying to write to SATP CSR val =3D 0x10000000=
00000000 (SATP_MODE =3D 1 - Reserved for standard use)
> and after that we are trying to read SATP_CSR. We read from the SATP CSR =
value =3D 0x1000000000000000, which is not a correct
> operation (return illegal value).
>
> Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes for v2:
>   -used satp_mode.map instead of satp_mode.supported
> Changes for v3:
>   -patch formatting corrected
> ---
>  target/riscv/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index fde7ce1a53..735fb27be7 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1278,8 +1278,8 @@ static RISCVException read_mstatus(CPURISCVState *e=
nv, int csrno,
>
>  static bool validate_vm(CPURISCVState *env, target_ulong vm)
>  {
> -    return (vm & 0xf) <=3D
> -           satp_mode_max_from_map(riscv_cpu_cfg(env)->satp_mode.map);
> +    uint64_t mode_supported =3D riscv_cpu_cfg(env)->satp_mode.map;
> +    return get_field(mode_supported, (1 << vm));
>  }
>
>  static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mp=
p,
> --
> 2.25.1
>
>

