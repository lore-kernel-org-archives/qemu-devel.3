Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8659DC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjMI-0002oX-6y; Tue, 05 Mar 2024 23:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhjMG-0002oI-Sx; Tue, 05 Mar 2024 23:58:24 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhjMF-0002of-7z; Tue, 05 Mar 2024 23:58:24 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4cb26623dc1so560485e0c.2; 
 Tue, 05 Mar 2024 20:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709701100; x=1710305900; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41HrMy30v1IUXtbxZKNSp568/6VVI2dUQ4+0SauBPAE=;
 b=bg9rZKpfCkOhd9O0cYy7YXoxy5qhxMIIvM1s78Juh4kWBk6da1TYTALdi/CI2kMeE2
 WTi2yqhygxWqxjIicOY30Iplok0f69hKEe0+M79cO3AIRV8We1aHxHaqH05E1sejY/zR
 Hf28mApUUFNoSfLbmWvmvo9T+zujR4/AvCxhP9AfEZqNhFlBU5JZfnF1riR0yKwhAd1w
 rxSL9U1J+GLTaBQvBF/6PQSyWG99zqhxrIcmrQfGcQvvvRJGgRJRhQAauylB1LE0EjwJ
 GKpAlc1vl7QNj95Bi2iqmlGnlLfvUgvN3WftEmFAuqXlp2Yk64FXvUcTS06jyA/h8PBH
 CgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709701100; x=1710305900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41HrMy30v1IUXtbxZKNSp568/6VVI2dUQ4+0SauBPAE=;
 b=NnmT78VkoR7WeQiWYph2smkT+Vb+FCfvvN0w1qIMaYWEb5sas4zx7g5oRb+svQlJv3
 cuBHT+/wUpDe0QTy9sNXf5M5hGEjJtf31T/AMdwBN4ecv0XeP3GYBBULHZS8reWpvcWP
 tq7HpQvBF8tfh8UsUlkc11WoDMMtN/3O5MeUUVtWzsvzrUV14LbBo6C5i1rwS1+anmB3
 FCSLxq6hHvllm9nRPHzhMA9zmqesMbEv/hGw7DSyD8JoWkPWmYUBcHL0KVNQsykE8Oi/
 p8Jg6rnccevNXtD+kUqfWLOJSbn6LT0nYRzogmhhBsnSxdCr09SSH7H8y63kGYcFD0Ap
 lk/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ2cNey5HUGr/QksMG9pJwHL3tyj/eKCMi0O9DX3gchb2vJ9xUKWeDPqvfgs93s1Em7TsUw0R3xlzJiRCZqjKBWesusT0=
X-Gm-Message-State: AOJu0YwmjOltCCKXwpZKYjqeOe5rddRTenMdhLfUieEbFwp85jFH/4bh
 95v4uFSaKny1Q3LMWsh9gGwsJc7veyO2Xel2EaltenH4RTO48RNYcHSKg31yy36mD3lBNYmTvWz
 v49wKm2XKH0qH1pvHvSK7L+fABFQ=
X-Google-Smtp-Source: AGHT+IGJsTeNeTuAtk1l2u+g7+WmsE29NO/mOMNeCoOkEWIgbcy3vMsBBlD23Ja4SVwQFRGI+VsbnHoyGXDDQ5OGaUc=
X-Received: by 2002:a1f:fcc1:0:b0:4c7:e255:728b with SMTP id
 a184-20020a1ffcc1000000b004c7e255728bmr3392874vki.12.1709701100611; Tue, 05
 Mar 2024 20:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 14:57:54 +1000
Message-ID: <CAKmqyKMQ9wQ2yeQ=kiwriM-8WXpB-oBaYcXcfjc3LZWfM+YVFw@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Fri, Feb 2, 2024 at 9:42=E2=80=AFPM Vadim Shakirov
<vadim.shakirov@syntacore.com> wrote:
>
> mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bi=
t
> by privileged spec
>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.h     |  8 ++++----
>  target/riscv/machine.c | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5138187727..cf1867a6e2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -271,7 +271,7 @@ struct CPUArchState {
>      target_ulong hstatus;
>      target_ulong hedeleg;
>      uint64_t hideleg;
> -    target_ulong hcounteren;
> +    uint32_t hcounteren;
>      target_ulong htval;
>      target_ulong htinst;
>      target_ulong hgatp;
> @@ -334,10 +334,10 @@ struct CPUArchState {
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
> index 72fe2374dc..a4d47ec17e 100644
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
>      .fields =3D (const VMStateField[]) {
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
>      .fields =3D (const VMStateField[]) {
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

