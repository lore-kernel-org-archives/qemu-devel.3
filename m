Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482F8C48286
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 03:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVkGc-0006OE-QA; Thu, 01 Feb 2024 22:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVkGb-0006NK-5G; Thu, 01 Feb 2024 22:31:01 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rVkGZ-0002hJ-H0; Thu, 01 Feb 2024 22:31:00 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-46b3ff62223so1809474137.0; 
 Thu, 01 Feb 2024 19:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706844658; x=1707449458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kv8aZN1E1Pf8j1v4hQe5XNaY8kWkU2ATIKXRwzJjAeE=;
 b=cx6exJ98/7Ny7TgozdmhTVMZvFgUo1/+ww0CWUSZdE2mkpgYTumUfJcSnnm4fhyP+L
 dCGTwJfxNvlZ004SWiLmJqgCClDQpLt9sZA2KI5TK+/5ag8DXZURENLRSaaS2P6sT0ni
 ssx7q+YKiaOL1RgHQqkaQxIvLq9Zim8g72XDfWf73S2b2RxPtZDCfK4aBhRUo34Ub/uV
 boaGnxVgsZfV2Vytrs+/7bnUu6zdtHmm1CxbwxcL+/Tx86LJTM65JWexOzoOSeH95bUp
 VzJrX6FOZNY3yVIw5mJEZVixq2YOy/+32ZMjxhCljNTmsDBGo/vzO8c7GInVY/wqW7i0
 kOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706844658; x=1707449458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kv8aZN1E1Pf8j1v4hQe5XNaY8kWkU2ATIKXRwzJjAeE=;
 b=eCC2ctoDiTd/CHC736/aUSb7qOSiUjU7drg60EJotKL5YGpfMKf+/FOaZR5Ic8pM5r
 4qXKTBamTm6TxgSdAkGrOhHw0eXu24mriqBMS7JfvrHQvyTXaGzxloOQ/aSCur1cHZkI
 eNQZcmsce+wSKHqh2AGQfUJdxIeNTg/qMr9kBhUv4pffhUOHzLW4xzjkTaLo7oNjHTtI
 5GLJdJguFSopHaxVsKu9DgzNNyeeYdMvwcH+h/My7CMuczw6gi4wf5i+IsUes/P+PHLc
 GnyyuHpQRK6u3nM47K3A8PKanh+DMxmYZkVkIm9oJMfzsejPZLZgYQzZI1nZXl+PGX2S
 vKjg==
X-Gm-Message-State: AOJu0Yz9hIyacXtS1QMsCYPs6gvf6H6ylUYmwuNTSW5JprppZBJFkw1P
 sJpBDICAoADFgYNs3dEHUU24YK2Di7PFW2lNNN7UhpTbz0KG5Qz4j2JWJy8H4LDtsa3JOXKpm6v
 bTo5QgdkBt7T0d4Dx8iJq3sFEX8U=
X-Google-Smtp-Source: AGHT+IGci1zNbWqgB+Xjrc8QoCfy0jMWMP7QFIx0Eghp8TL/CRbe/QALKApOyfS0jR8CKtmEGV1j9RTf7BqCU0nVUMo=
X-Received: by 2002:a67:e2d7:0:b0:46b:68fd:fa43 with SMTP id
 i23-20020a67e2d7000000b0046b68fdfa43mr751227vsm.4.1706844658099; Thu, 01 Feb
 2024 19:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20240131123624.230982-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20240131123624.230982-1-vadim.shakirov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 2 Feb 2024 13:30:31 +1000
Message-ID: <CAKmqyKPc6K50usZFBgfPqCxTEUibzTmApWWuB=9t_7nN3_Wi2g@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Wed, Jan 31, 2024 at 10:37=E2=80=AFPM Vadim Shakirov
<vadim.shakirov@syntacore.com> wrote:
>
> mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bi=
t
> by privileged spec
>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

> ---
>  target/riscv/cpu.h     |  8 ++++----
>  target/riscv/machine.c | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5b0824ef8f..88efd8a6f9 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -254,7 +254,7 @@ struct CPUArchState {
>      target_ulong hstatus;
>      target_ulong hedeleg;
>      uint64_t hideleg;
> -    target_ulong hcounteren;
> +    uint32_t hcounteren;
>      target_ulong htval;
>      target_ulong htinst;
>      target_ulong hgatp;
> @@ -317,10 +317,10 @@ struct CPUArchState {
>       */
>      bool two_stage_indirect_lookup;
>
> -    target_ulong scounteren;
> -    target_ulong mcounteren;
> +    uint32_t scounteren;
> +    uint32_t mcounteren;
>
> -    target_ulong mcountinhibit;
> +    uint32_t mcountinhibit;
>
>      /* PMU counter state */
>      PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index fdde243e04..f129032b0d 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -79,14 +79,14 @@ static bool hyper_needed(void *opaque)
>
>  static const VMStateDescription vmstate_hyper =3D {
>      .name =3D "cpu/hyper",
> -    .version_id =3D 3,
> -    .minimum_version_id =3D 3,
> +    .version_id =3D 4,
> +    .minimum_version_id =3D 4,
>      .needed =3D hyper_needed,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINTTL(env.hstatus, RISCVCPU),
>          VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
>          VMSTATE_UINT64(env.hideleg, RISCVCPU),
> -        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.hcounteren, RISCVCPU),
>          VMSTATE_UINTTL(env.htval, RISCVCPU),
>          VMSTATE_UINTTL(env.htinst, RISCVCPU),
>          VMSTATE_UINTTL(env.hgatp, RISCVCPU),
> @@ -354,8 +354,8 @@ static const VMStateDescription vmstate_jvt =3D {
>
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 9,
> -    .minimum_version_id =3D 9,
> +    .version_id =3D 10,
> +    .minimum_version_id =3D 10,
>      .post_load =3D riscv_cpu_post_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -398,9 +398,9 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINTTL(env.mtval, RISCVCPU),
>          VMSTATE_UINTTL(env.miselect, RISCVCPU),
>          VMSTATE_UINTTL(env.siselect, RISCVCPU),
> -        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
> +        VMSTATE_UINT32(env.scounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>          VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS=
, 0,
>                               vmstate_pmu_ctr_state, PMUCTRState),
>          VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVE=
NTS),
> --
> 2.34.1
>
>

