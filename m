Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58911CAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxzpz-0008JH-31; Sun, 14 Sep 2025 23:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzpw-0008IK-Ao
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:25:04 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxzpj-0006hz-E8
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 23:25:03 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b00a9989633so712029266b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 20:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757906684; x=1758511484; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgCskFXuUsUjbjjHf89rRVbnS1RbwW/emE2kv+a/jR8=;
 b=HqFbfti6JlVf97MOlCCD1KmsMWHrfnihHobjIrs5AALEoboo/iV8rSk3GGl4LWrnl+
 7WCycvm/lmEttvRlWM3eZ6oIrF0r7NtuobdKdmS5Z9EPKLIZqz8JNjGO6JU7nBzVExaH
 FvU+q47If0hOPR1njWjRrb63wPf3XV/r/ZciUaChlmePMLBiprtFoKucWk78pBBthPEm
 M8zMWP7KKNs2QahAU0EG9muo0nDEPF+CZRpwXXvFQEsJzfC3KsGJG/8U5YmY3cvDxl4z
 4CFFTXEFFdG4lk2k0LkBQIEiTIRIyBhWRSn8pCXNpzsR+2v8dFqr7P2YP6un6cwaKEEP
 nzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757906684; x=1758511484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgCskFXuUsUjbjjHf89rRVbnS1RbwW/emE2kv+a/jR8=;
 b=tXKHOK8vaU6CD23PQDi8QMsdNzy0aaMfa79hQtlVDdAC3oOJQRDcuAn1oF8mUw8Tna
 bilInX6X9K3dBevwAIiaGsxbxjaU2OGBxu0lOwLssqxwkor3aQ7EWvj5QI8bbW1XkW2q
 mz/DWsGcnAZymTRA97HCb1bTd00WQf36eSRDWzMfz6Zk+cQ/AJoGdB125DlA5MJZzD/M
 MGfqeneWKZScNwEA+Ecc2Bf6d679/s+CdcTGWOnLru6PRb1U/scLULWvJdXJS9VQJxiy
 Uv9Lm5ojLyjVdnk9iN94D5tuQhBb1MCKdT8FkcGneZQkWXSkmi2gVYMx7FgvpTDxD2nC
 IMuw==
X-Gm-Message-State: AOJu0Yz0DvGvZxQHCZ7CxSRAanmfTiYrVYPOoG7uGwUw0V3fFh8+cDux
 sXuj1TELakEJFplxpOrLmzImWxmGMb/wSAgYw/9hxGshsyaV7807TEkf1v7RWsKXFXV4r+dpPOo
 VztSNohs2svtkIdsE24kjnwLaG/apkdZnaw==
X-Gm-Gg: ASbGncvPDh1grSK4FQcKCOwyzvYWOnJwbx5UUsFIrZhz2irBN9LxRbF+Ckud5Pf9mK0
 bebxTcejDMmSS8TQKO73JnsIG8EV8j3d1+3fCGIfGFDcLC5kJdw6RRUQhQb4KDOkNxNBq0Il+t9
 bWbdVyKuWsYx3VfX2uwzbeKut60S9pnbnbgAYOvFyroNX0OKfBlG79xCVIyUDK2mTtJJ2Tt99/a
 RNSKCq7a+t40230wMdhXMVUzJ+j8CAsvd/RxL2l41nYcjpe
X-Google-Smtp-Source: AGHT+IEKvrnaEqgza7PqoB5amQsHRkhpOZATzkHFU+n1AlNc4hNqcEbkt0XdzXcthuW08mLV6ralF11zJRk0pTZ0zp8=
X-Received: by 2002:a17:907:74e:b0:b04:6546:3475 with SMTP id
 a640c23a62f3a-b07c22b2136mr1298716166b.6.1757906684192; Sun, 14 Sep 2025
 20:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250723094213.2975268-1-dbarboza@ventanamicro.com>
 <20250723094213.2975268-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250723094213.2975268-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 13:24:17 +1000
X-Gm-Features: Ac12FXw0UJN9dMKdDlNnDyFddzgomQDaqWghFDGwHaLuP6-gT94mpVUbq35sr5U
Message-ID: <CAKmqyKP_iM0GAM4cZFQsTcvMvi3DjCS6h7_60EPSBnh-UQsb7A@mail.gmail.com>
Subject: Re: [PATCH for-10.1 1/1] roms/opensbi: Update to v1.7
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 7:43=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
> version 1.7.
>
> It has been almost an year since we last updated OpenSBI (at the time,
> up to v1.5.1) and we're missing a lot of good stuff from both v1.6 and
> v1.7, including SBI 3.0 and RPMI 1.0.
>
> The changelog is too large and tedious to post in the commit msg so I
> encourage referring to [1] and [2] to see the new features we're adding
> into the QEMU roms.
>
> [1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.6
> [2] https://github.com/riscv-software-src/opensbi/releases/tag/v1.7
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268752 byt=
es
>  .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 273048 byt=
es
>  roms/opensbi                                  |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv32-generic-fw_dynamic.bin
> index b2e740010b..02be3a72a8 100644
> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/ope=
nsbi-riscv64-generic-fw_dynamic.bin
> index 018b4731a7..cce35c65c2 100644
> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bi=
os/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/roms/opensbi b/roms/opensbi
> index 43cace6c36..a32a910691 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
> +Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
> --
> 2.50.1
>
>

