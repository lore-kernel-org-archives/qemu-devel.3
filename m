Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0F9C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinJ3-0002YW-VU; Mon, 26 Aug 2024 23:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinJ1-0002OX-Jz; Mon, 26 Aug 2024 23:55:43 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sinJ0-0004gV-2z; Mon, 26 Aug 2024 23:55:43 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84686812614so493314241.0; 
 Mon, 26 Aug 2024 20:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724730940; x=1725335740; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1SNd4nsyWr8Pv/32CN6ndditvNTTWpjTjkiuXkAwAk=;
 b=bjFXVxO00hUlXZiFCURFrQh5ZFjF9DAt6Wne7/zfEW4QyXAKsrxM5PsF7VRLsKp/Ec
 7DzAKNh51f6GPgMbcpFpoz8269tMR99GMIBhIlJ9mY/5U0Vp8j1m5iZLEZjI63hDFoSd
 oKy5oXYvlE2C6jWqYMqY1W5Jr7T0wj1AVh+EWJTy4Dx+d2dl8YwwHdizG/jf7tVPH9uW
 XH5gX7+xb8N8uENexK3acrP0yAqFvde0OwFjWS3uKFSFrNNwNwOmNdR0OD0bIcdsanzd
 MhwIf+GqWzDUxdCpytThGUMzMufnAQyL83X8tS9taE54uTSF8ewveN/EnEDMwaAIdR1d
 BXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730940; x=1725335740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1SNd4nsyWr8Pv/32CN6ndditvNTTWpjTjkiuXkAwAk=;
 b=lAEstosqXwHZU2aJsPX65Ej1bdBsznL6m4rnKM8cIiaJr9byPe/89Vh8sisO1nKeGJ
 ofIDGtDmNXZbEI56jHahIjXBauF5uF/dhPY6eH5QpMvE44KAQYpF1QDGvKEsaXTYRdfI
 135ZWUX4gVybPXR3GIdSWqk7Z48+JB6RNnmtA67qXpvbOiw4d+JQSdEhUKdU8B/VlfPg
 SBHWGbmKe5V/bxVE2lMpOlG2aPWd5SsS2MyucN1yMrlHbqlMSguZ8aTkxtLzIsfWF7lw
 IppEHozwuCe2PaQi0FQNpFCTvvj5ThMAWda+ry0qZXvotgEeFbNjbT3znCp06qgYZ7xD
 kQNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqyuMERdFc9/uiRW6QxcqmByDn1f50VQ/8jyFxNQ3geJUFxmR3uNqd0dxKRtXlORaqPcyNYM1+pD0s@nongnu.org
X-Gm-Message-State: AOJu0YxsyRCAEjZBmaAXEkkJyJNTJcrQ6fM1xGO5jba3M6b0iyRUUPBy
 DbRpaGjO6PaE75Xv0DgL0cxcBt/Rz3zvZWIAp/OSAWHpR38fWahBh/TurQhsAFdAAR0uYtvTHHO
 yh2abmJWU2QFH1dLiPICcvEimK6o=
X-Google-Smtp-Source: AGHT+IHIMqhHLqg6ASQVi5Giee2b2sxGTYWe+vZvml9XR9gfu8IJHLR3QY+Xe5zkgNFQqUMpCk0uJ8J9Ie8HERg0Ae8=
X-Received: by 2002:a05:6102:358a:b0:492:98bf:75ef with SMTP id
 ada2fe7eead31-49a3bc4b4c9mr1471193137.8.1724730939860; Mon, 26 Aug 2024
 20:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-5-debug@rivosinc.com>
In-Reply-To: <20240826152949.294506-5-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Aug 2024 13:55:13 +1000
Message-ID: <CAKmqyKOCJRm1YSpXQ9pthF4Vom--UnXyMxe=4ZbBu4hT0fB-UQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/17] target/riscv: additional code information for sw
 check
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, 
 andy.chiu@sifive.com, richard.henderson@linaro.org, kito.cheng@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Tue, Aug 27, 2024 at 1:32=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> sw check exception support was recently added. This patch further augment=
s
> sw check exception by providing support for additional code which is
> provided in *tval. Adds `sw_check_code` field in cpuarchstate. Whenever
> sw check exception is raised *tval gets the value deposited in
> `sw_check_code`.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 2 ++
>  target/riscv/cpu_helper.c | 3 +++
>  target/riscv/csr.c        | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7be0fa30f7..11c6513a90 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -224,6 +224,8 @@ struct CPUArchState {
>
>      /* elp state for zicfilp extension */
>      bool      elp;
> +    /* sw check code for sw check exception */
> +    target_ulong sw_check_code;
>  #ifdef CONFIG_USER_ONLY
>      uint32_t elf_flags;
>      bool ufcfien;
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 12484ca7d2..121fef1be6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1761,6 +1761,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                  cs->watchpoint_hit =3D NULL;
>              }
>              break;
> +        case RISCV_EXCP_SW_CHECK:
> +            tval =3D env->sw_check_code;
> +            break;
>          default:
>              break;
>          }
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5771a14848..a5a969a377 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1179,6 +1179,7 @@ static const uint64_t all_ints =3D M_MODE_INTERRUPT=
S | S_MODE_INTERRUPTS |
>                           (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
>                           (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
>                           (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
> +                         (1ULL << (RISCV_EXCP_SW_CHECK)) | \
>                           (1ULL << (RISCV_EXCP_INST_GUEST_PAGE_FAULT)) | =
\
>                           (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) =
| \
>                           (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) |=
 \
> --
> 2.44.0
>
>

