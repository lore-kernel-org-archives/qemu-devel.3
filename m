Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C94D24468
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 03:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6aD-0000Qr-Pt; Thu, 10 Oct 2024 23:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6a6-0000Pq-90; Thu, 10 Oct 2024 23:44:46 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6a2-000578-WC; Thu, 10 Oct 2024 23:44:45 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4a3b97cfbf8so593239137.1; 
 Thu, 10 Oct 2024 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728618281; x=1729223081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D6UpdcoB1J1sw62k36lM31MuN8KCwbpelyq2vvuYFY=;
 b=DNoSuv+t4BUchgJ/VE6V+SfRSCRfeyzNl4Vo2exBdjefTMhfXyMQcnxn/E//gAVR/y
 Ec+/kkJu9srRKEpWARpaZsdv52Gnnro6Ray/zZljHVkbcfJC1bW4blkFO410+Y+lV9vP
 KsFvF52eMWXTPJo/5Kv/vsGqLfZySFh1JaE6osWFG3uN4RUUAca3ZymcalOC+iBfAckk
 FaZNB6lKE7pYIZYa2VuU/HDqjl/LsSEmiCXrECd9vYdz25ikTCusfHya3UiO5ilYYVB6
 Ch+HWEnvioHY6KakrbMPWTVvglAWI4s0hq/rBmpMUW4z3BP/pfV6J2JhWIs5UWl+V0pH
 YaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728618281; x=1729223081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8D6UpdcoB1J1sw62k36lM31MuN8KCwbpelyq2vvuYFY=;
 b=g5J4fSjnKO7uDcMFKd2gjNwnSpetFMaRqpk2t3yFA4SJPY5RYAs5DKmlR//n+vVqNk
 s1QWaw5Y9nbSb+irXjw45tU84Lbe1o93qaeI1kAlpH9Cx8IuGr/5gjUH8C7Are0vQJ2Y
 9dqlg/MeqRClSno1OVX1rfe2K8bhgDzOkJNv6dBcHJ5cR+zALrNOtCH6kSjzAf4EPNZA
 2Bs784v/1+KEaUBU1V309s/713Ykhi7oMIuxFGmZtbEYVdGyGxxOL6lqAWLX+b/JgjxJ
 iY6cjAClQhCAcODwZQFmtYrT7aVOQf5HriPSOkgq33CXSk2a/5z538dGBR364Pjvnv+g
 p0Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSLBOiOVOx/MOqBNgqsxWGzJO6FXIZ9+XGp/KJH72ZltyqEnQYpDVExzaRW6knGLMePo2awX7nXyrB@nongnu.org
X-Gm-Message-State: AOJu0Yzqn6t+ynwo+MVoqa3bYgIs4w/W2PspCuGe/eQDC5DMUr2n833g
 9isw4YUGJ2ADVT6vLDaEPl6wVqPT8qnhYpi5HqPWLHbvu8We7XIrlSCllDCm0bWP/nSma97YeBU
 hGin9vN7YsTKiCRu9AYHqPgXCDEQ=
X-Google-Smtp-Source: AGHT+IGXrPZN+JsxiMmkPsgx0Biy8z8GRtNxpIyehBXmfWA1M/FZpQUDOrK2ekenEAKzlhw9ya+PgDQvj8zbGbdWwLg=
X-Received: by 2002:a05:6102:290e:b0:4a3:f9e8:2fb9 with SMTP id
 ada2fe7eead31-4a465aed161mr876007137.24.1728618281248; Thu, 10 Oct 2024
 20:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
 <20241007033400.50163-2-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241007033400.50163-2-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:44:15 +1000
Message-ID: <CAKmqyKPkRXUWj1+0EmsWW2RFApX_F0qkd47X8sbMKqhJ9pKiEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] target/riscv: Fix sstatus read and write
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Mon, Oct 7, 2024 at 1:35=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Sstatus is SXLEN bits in length and always has the layout determined by
> the SXL configuration, regardless of the current XLEN.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Fixes: b550f89457 (target/riscv: Compute mstatus.sd on demand)
> Fixes: f310df58bd (target/riscv: Enable uxl field write)

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index ea3560342c..b33cc1ec23 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2893,7 +2893,7 @@ static RISCVException read_sstatus_i128(CPURISCVSta=
te *env, int csrno,
>  {
>      uint64_t mask =3D sstatus_v1_10_mask;
>      uint64_t sstatus =3D env->mstatus & mask;
> -    if (env->xl !=3D MXL_RV32 || env->debugger) {
> +    if (riscv_cpu_sxl(env) !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
>
> @@ -2905,11 +2905,10 @@ static RISCVException read_sstatus(CPURISCVState =
*env, int csrno,
>                                     target_ulong *val)
>  {
>      target_ulong mask =3D (sstatus_v1_10_mask);
> -    if (env->xl !=3D MXL_RV32 || env->debugger) {
> +    if (riscv_cpu_sxl(env) !=3D MXL_RV32 || env->debugger) {
>          mask |=3D SSTATUS64_UXL;
>      }
> -    /* TODO: Use SXL not MXL. */
> -    *val =3D add_status_sd(riscv_cpu_mxl(env), env->mstatus & mask);
> +    *val =3D add_status_sd(riscv_cpu_sxl(env), env->mstatus & mask);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -2918,7 +2917,7 @@ static RISCVException write_sstatus(CPURISCVState *=
env, int csrno,
>  {
>      target_ulong mask =3D (sstatus_v1_10_mask);
>
> -    if (env->xl !=3D MXL_RV32 || env->debugger) {
> +    if (riscv_cpu_sxl(env) !=3D MXL_RV32 || env->debugger) {
>          if ((val & SSTATUS64_UXL) !=3D 0) {
>              mask |=3D SSTATUS64_UXL;
>          }
> --
> 2.43.0
>
>

