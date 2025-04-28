Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72895C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9X4S-0006eP-Et; Mon, 28 Apr 2025 18:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X4N-0006YF-RZ; Mon, 28 Apr 2025 18:35:23 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9X4K-0001fc-E3; Mon, 28 Apr 2025 18:35:22 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-523de538206so2216877e0c.2; 
 Mon, 28 Apr 2025 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745879712; x=1746484512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5acXFgtf4OuG1uzSnTgV3Hlyvxr23Go+fC6UAmRLEMw=;
 b=lmV1H2NwXi9gNYEA5oOXjfePjQ24tjvkZdYK5XO4QkoWFv9lDVMU7SfCGuCuhL1OIR
 sMeNLmVSQTLMyIl6Na5lWRImIKl4ALfhQPzjljv0aHFGON0g3sUJX45QjTrp8wNgxYN8
 onNh0H9ipeia8GC5m1f2HJsCD5ttQCWuMpPPKTITBGA9MT8GI33NfTo7aw7h6ydCl1a4
 zGA1CwUknrfZDdqHrYQucE9q+aOrTLZkxcmcnzz/gl5a/HvmGKWuCWTsxlSXzbRO6YkS
 6ut/ZDyu6GfCf0tULhUutQQgjA7Qi78W7g0bwx0czBSojRdXsLfBQiYv4G/9eybxkJm2
 tf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745879712; x=1746484512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5acXFgtf4OuG1uzSnTgV3Hlyvxr23Go+fC6UAmRLEMw=;
 b=rfSjmqWLj5bS3eHqwRCpxYaGkBu5zp/dQI6gP2okpqnaU2GumdTe6tUg+5YgmFOvdf
 GoPeiMDSqER4OvjQxhzEEJOG9CvUtss5UokhYDe4E/YZWb3ymrcKgsMkPXWEXicEOlN0
 tPJoNTAkYQiOy1T6vJ334UIJaEGIqS6rwDSll93XExgLgjKFsIxD9C0O+iUVNXeUYFX2
 eRpQzcs9Dg6CwnB95ujrujwiP+2pPKiWoeo6F1WwtW+YwwUyLGkLtWf6Ty3ST1OWjbKI
 VfZYH2J03glBuzJkdw7pZt/1fp/HofkHPhZWPtb/FoYo/pLyHRhJHcZDzff/A71vLDFY
 8ygg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxtV3wEmkcUzVMHG5PdGtN01YWErHdflJ07dZhGOsZgYChtKo3kpefUdarJrqDBWO4A5PcZerl2XF@nongnu.org
X-Gm-Message-State: AOJu0YxSMqTnSHVkeXea/jUoSpSulVxPAC1++fFSI8Yty8uNpRSy9jvt
 vttCwXFKk5kaaLcAbXReMgl2Li/RehyRPvvA2mHHAynVN/x3U/ngc/rF7pMfpW2sejoeam5XL+o
 Z5khpK3HF9w9cMJ/wDaMD6QcllOM=
X-Gm-Gg: ASbGncvTL1JyeR1DDnpKvhBg4YOzcMgLqYvjG/ip2+UJUtUdRqwibaRTVsGLkXfxH3Q
 3lq0GsR1url9+NqB6hsEVWSgM/5dd86a4y00apbXp7v/SMwr3AzsYTo4rBcjkfiD58LXJIc0IbH
 q3ksgS63mL21Kb+IRmpWFqdi2a8mcuMYL5RXvYFqPIs/enVpElbLYS
X-Google-Smtp-Source: AGHT+IG6s2x6R7YafHykmojhVjbE7cQaYPSs+XV1nLCWY6JbvSwBnygJ8BsBZFqvK/tgp9Qi0JfuGDXU9dYjuh/0GKk=
X-Received: by 2002:a05:6122:6594:b0:528:bd71:8a8e with SMTP id
 71dfb90a1353d-52a9702836fmr7670438e0c.5.1745879712335; Mon, 28 Apr 2025
 15:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-4-richard.henderson@linaro.org>
In-Reply-To: <20250425152311.804338-4-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Apr 2025 08:34:46 +1000
X-Gm-Features: ATxdqUEy93YJyM190vJGcqME2YiFmLUU2OVGwDJkMFgehM_eYZ9nTmU7uSNAahU
Message-ID: <CAKmqyKOJt4hiChLk7t4R5S4YHJ-QgXspoBaS1bWV6unCJDjvBw@mail.gmail.com>
Subject: Re: [PATCH 3/7] target/riscv: Pass ra to riscv_csrrw_do128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Sat, Apr 26, 2025 at 1:24=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index e9c2f95b6e..d62d1aaaee 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5588,7 +5588,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int =
csrno,
>  static RISCVException riscv_csrrw_do128(CPURISCVState *env, int csrno,
>                                          Int128 *ret_value,
>                                          Int128 new_value,
> -                                        Int128 write_mask)
> +                                        Int128 write_mask, uintptr_t ra)
>  {
>      RISCVException ret;
>      Int128 old_value;
> @@ -5610,7 +5610,7 @@ static RISCVException riscv_csrrw_do128(CPURISCVSta=
te *env, int csrno,
>              }
>          } else if (csr_ops[csrno].write) {
>              /* avoids having to write wrappers for all registers */
> -            ret =3D csr_ops[csrno].write(env, csrno, int128_getlo(new_va=
lue), 0);
> +            ret =3D csr_ops[csrno].write(env, csrno, int128_getlo(new_va=
lue), ra);
>              if (ret !=3D RISCV_EXCP_NONE) {
>                  return ret;
>              }
> @@ -5637,7 +5637,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, =
int csrno,
>
>      if (csr_ops[csrno].read128) {
>          return riscv_csrrw_do128(env, csrno, ret_value,
> -                                 int128_zero(), int128_zero());
> +                                 int128_zero(), int128_zero(), 0);
>      }
>
>      /*
> @@ -5667,7 +5667,8 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env,=
 int csrno,
>      }
>
>      if (csr_ops[csrno].read128) {
> -        return riscv_csrrw_do128(env, csrno, ret_value, new_value, write=
_mask);
> +        return riscv_csrrw_do128(env, csrno, ret_value,
> +                                 new_value, write_mask, 0);
>      }
>
>      /*
> --
> 2.43.0
>
>

