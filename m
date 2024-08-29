Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCD4C71150
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjSgo-0003oz-M1; Wed, 28 Aug 2024 20:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSgm-0003UJ-Af; Wed, 28 Aug 2024 20:07:00 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjSgk-0004Ql-O1; Wed, 28 Aug 2024 20:07:00 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-842f1dd60deso43152241.2; 
 Wed, 28 Aug 2024 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724890009; x=1725494809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfOzJ4b1vkp1rGgHlub9zukf+UyUDIjqj527MomhKKI=;
 b=BIZmFmHElS8kVeKyVvcQmp1uafb8cT94KQwmwLNK2UNyNErNoC0Izl3K6FLF/2P8Ds
 X3729tPeuOSr3KOp+AnWlgIX+cyqvK1vRHB1adZN6VXCU77xZvx2QLv0S8HuGqYnDZaB
 VxT+FtcyYjWtRU1rypBtxM2jIaNEpU2OaAy9GFLTEPNuSHH6NMAEJSJwfsrbANSmWDwf
 TLSVf5+2IQa3GMh90t9kTLfn1VBSOVryfPyjGM4/jOCRT+4Ml00aaxFKnG2Chfop/cvs
 Xe5r0KY4+0IP9Ku9VYN6H11dpCzYj30CBZKAZb4o3ry2EVa+CjFCe+TrsWQWl/679lpu
 LGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724890009; x=1725494809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfOzJ4b1vkp1rGgHlub9zukf+UyUDIjqj527MomhKKI=;
 b=VCLZflFC9VAvCZP0062ALOaRHXCVzJRAqSjo+i8L7KDzrn7MmzZl7uomtX5SXvikfw
 KBIUM0e8AkZH0qT5v0Mt9ntJ2pcCiDclAySl3gEqzb9Uk7Hu8eRlSxwFZJUc1O0/13XX
 Nkim6zZdoF/qrb3S7u23sNc5LyC1Ga4BJX4PGLiz+IKmffcYFhasrlgsJ4Pdsu7FhEF5
 En4qyMy9t90Gp82zVkhUlnnraeh0/sbfzRp/neqyVmQQ6cfG0AnqwLNzBHYAzDWpf+4V
 7cOGp0EnFRqxEdcviMCn9VTBEcB00eU3ypdePrxv7IgvKvSYeb493PJUxXva2gEuoTfE
 WyeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9koOmJXvw7qv9H9C9ykvJJ7/ubUid4qiKoSVezeI0IsCWwAiq8jXTzOHpkG6S2/hh9rmsc7NxGsZU@nongnu.org
X-Gm-Message-State: AOJu0YzPTDSU2RFF5IBmpQy43aCNk0Gl9dN5BOz8TI9oj4TKyx9fDRVm
 ZuQYwerFal9AwcA7VmPDgNQZhnk33goRyqT18aq3LRYQoT/vfebmRKvHx1ByJYmpEeTTxS6cAXC
 NDTslau0Rb4UwKJmHZ+6AeeRzOeM=
X-Google-Smtp-Source: AGHT+IEluCazLREo2/Sp9GPpg/T+6AFhqRCSw8eAvBs7XnlVqQFjFIev3CH/06JxrYU1BN3Spf5Lz6VwRF+s4gAiXUo=
X-Received: by 2002:a05:6122:20a3:b0:4f5:26ac:e4a with SMTP id
 71dfb90a1353d-4fffe44ffe6mr1289855e0c.12.1724890008987; Wed, 28 Aug 2024
 17:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240828174739.714313-1-debug@rivosinc.com>
 <20240828174739.714313-21-debug@rivosinc.com>
In-Reply-To: <20240828174739.714313-21-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 29 Aug 2024 10:06:23 +1000
Message-ID: <CAKmqyKPFYDkjbQ9A6pVsNqxOxQpXFmoH_ihfCNc1useKEZ3P6Q@mail.gmail.com>
Subject: Re: [PATCH v11 20/20] target/riscv: Expose zicfiss extension as a cpu
 property
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 jim.shu@sifive.com, andy.chiu@sifive.com, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Thu, Aug 29, 2024 at 3:52=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c5ebcefeb5..2592465e24 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1485,6 +1485,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
>      MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>      MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
> +    MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
>      MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>      MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
>      MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
> --
> 2.44.0
>
>

