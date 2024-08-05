Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F7FC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 02:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1san3Y-000095-Ma; Sun, 04 Aug 2024 22:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1san3W-00005r-QW; Sun, 04 Aug 2024 22:02:38 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1san3U-0006Wc-Vb; Sun, 04 Aug 2024 22:02:38 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-81f91171316so2314400241.0; 
 Sun, 04 Aug 2024 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722823355; x=1723428155; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccByNy4ZNQOkFVgwR2+BgxfWgoio8TRjQ0mQej5BZCQ=;
 b=nWmfNJMs6YFT8w5xTaZshTs4DNGLly747S5WF2f5zcaVdHh9qGz0lgXLRtD00SsRt2
 hvA2JiV4DS3ouHZxLtQafW6SO3Y7Nadm2vZL+xz8Cjlu/XfbOKoCm5zqNDycJQ7l/avo
 n8CENyJO/OTAX1Tpb+6qNJzLxqIda4Xw9hh1PjWHkA1oAZ0txr+ssUNT4nQuW/OsSICv
 qBJXaS4DgDXjTVfRVrhaIHj0siO8WPif5MY9e61vszQgbfm3kFbrg/hSpDGmVVG8HktH
 TOWK2WtYR6BFfLUAY+NJGavkW9tZk/GSmfqGal9HCuloAJg1xglC8KzFRLRTChq29GCK
 D42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722823355; x=1723428155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ccByNy4ZNQOkFVgwR2+BgxfWgoio8TRjQ0mQej5BZCQ=;
 b=Dyb3mL9izyHdlWM8Oa2G29bdtpVDXuKMnCIaqFXYOM4QJJga6E1prRcjn0BOGoyY8a
 luy0pkp3QxP5/GsT3GO1oAUKeoV9L3wFGeJyB6CU2aSHWCr/Wf/Ru3QMRKwEbPb+ocxY
 W48BWuYEivIZiEP6xYkhBwqbfn4RQepYxczh5lHJ7UHVDs8hkNwBgVL01Oj51H0DSwcr
 ZOiB0B9G9ytjcloF0YZbsR6Gnf09QEtCSKHIf9p0ANDBx5RRw4NL/bXk7yHvZJxkmrt8
 M3j7WUSXWgRcs3IGcerF5er9yu5X+278vDI9nR5wasaGUfXoXXrG15ec9I6NjvCuitYT
 FWzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+lzlyTZ7mZvBo/RVOywXXLGCp+5zw/yxjmhkyZZnMsVyEuIU9eYlDWDGGtCj99WJ2VfMN6Q17SbbDAgX7+1/yZr4Y8Qo=
X-Gm-Message-State: AOJu0YykUgxM3WRweo1XsaimyFg+BhNChPaluQJKftbSh5b8BW+/R19b
 0bv2rwIpBgzUGrmSbm4kVpFYqjLCdPHIzibp/VwGUZOHhKP6gSSF97BjQxJLx2tLackDm5rsnrD
 DrTOylrUP//cn0BmQNVEvx6OD64U=
X-Google-Smtp-Source: AGHT+IGg9dmTwQ9D6yeRHRe4C/u+HcKc1e00Z8KtRvAlq9mc0rYNUEEczV6Q71iqUsPONYf+ZnqqmuXH9GVDn8+cWtc=
X-Received: by 2002:a05:6102:32c3:b0:492:98bf:75ef with SMTP id
 ada2fe7eead31-4945cdd0773mr7301804137.8.1722823355152; Sun, 04 Aug 2024
 19:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
In-Reply-To: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2024 12:02:09 +1000
Message-ID: <CAKmqyKMrtT-BJ3t+kVrB0sOqs7StKPD2gWnHJzK6nJj8_+2OVQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add asserts for out-of-bound access
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Wed, Jul 24, 2024 at 6:33=E2=80=AFPM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Coverity complained about the possible out-of-bounds access with
> counter_virt/counter_virt_prev because these two arrays are
> accessed with privilege mode. However, these two arrays are accessed
> only when virt is enabled. Thus, the privilege mode can't be M mode.
>
> Add the asserts anyways to detect any wrong usage of these arrays
> in the future.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> The lore discussion can be found here
> https://lore.kernel.org/all/CAHBxVyGQHBobpf71o4Qp51iQGXKBh0Ajup=3De_a95xd=
LF=3D=3DV_WQ@mail.gmail.com/
> ---
>  target/riscv/pmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 3cc0b3648cad..e05ab067d2f2 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -204,6 +204,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVStat=
e *env,
>      }
>
>      if (env->virt_enabled) {
> +        g_assert(env->priv <=3D PRV_S);
>          counter_arr =3D env->pmu_fixed_ctrs[1].counter_virt;
>          snapshot_prev =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
>      } else {
> @@ -212,6 +213,7 @@ static void riscv_pmu_icount_update_priv(CPURISCVStat=
e *env,
>      }
>
>      if (new_virt) {
> +        g_assert(newpriv <=3D PRV_S);
>          snapshot_new =3D env->pmu_fixed_ctrs[1].counter_virt_prev;
>      } else {
>          snapshot_new =3D env->pmu_fixed_ctrs[1].counter_prev;
> @@ -242,6 +244,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState=
 *env,
>      }
>
>      if (env->virt_enabled) {
> +        g_assert(env->priv <=3D PRV_S);
>          counter_arr =3D env->pmu_fixed_ctrs[0].counter_virt;
>          snapshot_prev =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
>      } else {
> @@ -250,6 +253,7 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState=
 *env,
>      }
>
>      if (new_virt) {
> +        g_assert(newpriv <=3D PRV_S);
>          snapshot_new =3D env->pmu_fixed_ctrs[0].counter_virt_prev;
>      } else {
>          snapshot_new =3D env->pmu_fixed_ctrs[0].counter_prev;
>
> ---
> base-commit: daff9f7f7a457f78ce455e6abf19c2a37dfe7630
> change-id: 20240723-fixes-439b929bfbc8
> --
> Regards,
> Atish patra
>
>

