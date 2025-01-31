Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0B4C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 00:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdeZy-0007UK-Lt; Thu, 30 Jan 2025 19:08:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeZt-0007RV-Er; Thu, 30 Jan 2025 19:08:09 -0500
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdeZr-0006cP-CJ; Thu, 30 Jan 2025 19:08:08 -0500
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4affd0fb6adso494677137.1; 
 Thu, 30 Jan 2025 16:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738282085; x=1738886885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LUPlNqt2N056oai/nYIjp2lhBqK3OXWN/sazR/0kB8=;
 b=ZJajGROYHC/Gx99m+2W++jocjhD2gAt2xUsxdZXvdqS7ok2/jV+PPoZctjKrGLrGTH
 Ag2xgrapFPZebxkX0DuVTIPt4O36x7/P2hw4Kx7/kQ/wDdLhpzfNPF4fRJq8TNyZfjM/
 Nk18CYMgzMbA+C4jhjNtPOnERrOAc3k5EZuaA2MOl97Sr3vW0wJdYxW+nVz3BXtPZV0G
 vkA0BPhA28eOE5ASp74oCIkQZbwWj6ypgaJDJa0XWeMqAr87RWKnXv0MMjy7yaol9lo/
 n5/x4TQ2XtwC7NORrIJh+sLS8hySjsLYTAyeVHup7xRU7LLX4vZx7GKy9bI9AvJhF9sZ
 +SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738282085; x=1738886885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LUPlNqt2N056oai/nYIjp2lhBqK3OXWN/sazR/0kB8=;
 b=qheBkJ3RY0BEsoS7e/JcCAjUpQG7qMIstMiuclxRHHsX9uFtSvlBZc/Fy5N6tXm5Pr
 V9o+zlpxlYqmjNANlAvPp1jKyeEQAhlKrnO3rERziznx0keIn6OFD4oHwKNlVArYdx5A
 3S8s58aN81pPdwO+G495PZQGk0qi3/EpDLHZyFdRIMgKRuEZ77kfzHLXAiEyRV8xgo4k
 GQF2x3eghi8H72udEou9A8NRcpDJnGNCMQPYUptSfi9g0r7eKGzbbicVAB5nMUrw+SQX
 sN+oHdQbGx98IIhYTp2VOYl65Tc5klEbNO3Eh5BwGBAzeVXsg8Fq2grnS90NMRUFNEyA
 oMCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCJROBBODCCsTCCUMf8bDT2D1YMHUghXUEiq2T2UdxOM9q2Dp9SFWTg3U8v751hplMaU14HJhEJWJ/@nongnu.org
X-Gm-Message-State: AOJu0Yyo0BVs49cBo6fm8sK5Yi7NofL7qRQkp8/Vtb0doga04kJklUQv
 f4RaO8r1qoxmhgbKMub5j6bbGSRVlHP5BwEn8OUzqIjpCW2K0kxNavRKwr1pWVSvBpDbQAPKk+O
 3Q0z/xp4qCasNwPsPyMCjCqJD/MiBKA==
X-Gm-Gg: ASbGnct94oUnNF4TGMtZaVOJ0j4m/vHU67KgO/xdlMf2a6mr6HFp5Fphw0DC4ghD5hF
 GqiNjLUjUPh9T2zl8ERveb2csZWa5l4Op8qbp3cjsPT/pMJrRbnxTcNGGs+9QKYN3Xrk0Mg5nc+
 XcqqIho37tD8TZjjsGwqF++9WW7vU=
X-Google-Smtp-Source: AGHT+IHSDGng+uCuhkJ8rjWFtNqjs+GBCLFwRBPDDT2cxS2+kj0rbzwNkzVbQr7oUltMlT6P4Me1oy1koyHxx+faMFk=
X-Received: by 2002:a05:6102:3e83:b0:4b6:8d8b:82c6 with SMTP id
 ada2fe7eead31-4b9a4fa8656mr8788109137.15.1738282083626; Thu, 30 Jan 2025
 16:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
 <20250115184316.2344583-5-dbarboza@ventanamicro.com>
In-Reply-To: <20250115184316.2344583-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 10:07:37 +1000
X-Gm-Features: AWEUYZkV6uq806Hbv06YhEFGk3eDZ2jrXdcRnwykym5UqkE23D4PpIjgT86yKRY
Message-ID: <CAKmqyKNjUC7A+PbQ2Ga89My2bMMUmEkP1yW2Q69XEBC-_32uCw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] target/riscv: change priv_ver check in
 validate_profile()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e35;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe35.google.com
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
> The S profiles do a priv_ver check during validation to see if the
> running priv_ver is compatible with it. This check is done by comparing
> if the running priv_ver is equal to the priv_ver the profile specifies.
>
> There is an universe where we added RVA23S64 support based on both
> RVA23U64 and RVA22S64 and this error is being thrown:
>
> qemu-system-riscv64: warning: Profile rva22s64 requires
>     priv spec v1.12.0, but priv ver v1.13.0 was set
>
> We're enabling RVA22S64 (priv_ver 1.12) as a dependency of RVA23S64
> (priv_ver 1.13) and complaining to users about what we did ourselves.
>
> There's no drawback in allowing a profile to run in an env that has a
> priv_ver newer than it's required by it. So, like Hiro Nakamura saves
> the future by changing the past, change the priv_ver check now to allow
> profiles to run in a newer priv_ver. This universe will have one less
> warning to deal with.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c060b65fbc..de2a8c3f35 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -746,7 +746,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
>  #endif
>
>      if (profile->priv_spec !=3D RISCV_PROFILE_ATTR_UNUSED &&
> -        profile->priv_spec !=3D env->priv_ver) {
> +        profile->priv_spec > env->priv_ver) {
>          profile_impl =3D false;
>
>          if (send_warn) {
> --
> 2.47.1
>
>

