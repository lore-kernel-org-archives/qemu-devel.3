Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A3CC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 02:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq19P-0005Ex-CE; Wed, 05 Mar 2025 21:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq19O-0005El-BE
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:39:54 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq19M-0005Pu-PR
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:39:54 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-523b8881d31so66154e0c.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 18:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741228790; x=1741833590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPZe2O/uqV7crHUiO6yoIPy0qp2y8U5V4k92aSEWksU=;
 b=PF/9ULZo5dkFHSal2gLHND6/SJOQ69s639S1vLf6xuvgYEQutB2N2/QFvC//xInE9z
 D10SVbIpILYdGXAW34bcqHj0LJCFwObBvIVBZTT8zuKQehna4TiMpowePAfB9lSJXWuA
 LSHYAQtmEXGMoKaLQUkcCNqQE2f7xThfBLKMHSaofh28QygD1En5qSbAsbaSML6lG/i8
 oZB6O4g0TO+j2laJfudZruZhP/Qmqd6Nv7XemZgrXpaqpaAMQcPop9v8FEmz1Ijl8rP6
 b6mOfGk41SjORrOEgUjd4bmTcGAKhHKRcg4cOFr+lQqnZDXsYA1skFscZswLcBT9Fdw3
 +Kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741228790; x=1741833590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPZe2O/uqV7crHUiO6yoIPy0qp2y8U5V4k92aSEWksU=;
 b=rQW/ijWJOC7YBNBgrNjxjNwX2aoif+KA8fZyRa/8Wdo7DiR2+wEdT704nvuB0KbbTr
 RJlB9XinEqoLDuG/PNy84raMJLgJOepMkKrnRjGtzwqKGBRRIcqVAKPBNDQlJ4HwJxko
 KoL9MectthwSQIZFwuE6Hvr4YxOt+DMjGBkikPqYOsp4wKM6enJy3dxuhyVruRnZr2xy
 OQzqTC68xuw5+mrYf4pvCvxJwPfwUFxekIAW3/Y0lmO4U+2uvNWjG3U0WPGbLh5Jc5Bo
 Ee9QW7xA+eDWQSkJXL3sI8qtIP7pOmChIthm7n/yz8gMHHdMxj2VD1kSrKPdPN3NWEGG
 c1Pg==
X-Gm-Message-State: AOJu0YyeDqlAEHOnx+g62zevGNHpXg8TFml2a72kH7kXr2yOZf0VwXHO
 JldEAHESXEx0yZ4gDetBjDAIe3kWyPshIBKx2DFtaTM/ZdpBbV2EcGHw/ysuD2XJatOhyGdKtVo
 HXPtVQMwFS4XnGlQZS5B8tm3rmw4=
X-Gm-Gg: ASbGncu4jZMn3XjvxZj2wWS42+wmqJ3xWO33nd4kM7lu+HxGhbGbdSPW48SNYBX0nKp
 NcCdIqLuARBT7yA+824E3ua09/exOfJoWpco41JBPpTvOT4YvmpErVEihQOww2CGsjbxzdnYhY9
 DaSkL2HcyVJoGSP3CBjiK+ekKBDxHSUKtv00litz8ENqGh4XZh23ijp3WT
X-Google-Smtp-Source: AGHT+IFqo90e3zku3YUE63o1pMHlK9oZSehN4flrVZ/FYsaegfvcMaAz5mIA7UK9hmH5xQgKZ1Hm9uYS5YNeM9r+9hA=
X-Received: by 2002:a05:6122:3208:b0:520:6773:e5bf with SMTP id
 71dfb90a1353d-523c611e608mr3283304e0c.1.1741228789890; Wed, 05 Mar 2025
 18:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-7-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-7-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 12:39:23 +1000
X-Gm-Features: AQ5f1JpQsbIwImBWbgvn5Eq9CUwV8lZDIz5Ea_TTY-tDnCyuthdc0JhuG1ZAT_o
Message-ID: <CAKmqyKMnKfT39fPs84-5fj7d88oMmKVjezqg4Dc0M68qkYLw_Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/riscv: remove supported from RISCVSATPMap
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Wed, Feb 19, 2025 at 2:59=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> "supported" can be computed on the fly based on the max_satp_mode.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h |  4 +---
>  target/riscv/cpu.c     | 34 ++++++++++++++++++++++++----------
>  2 files changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 28d8de978fa..1d7fff8decd 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -29,11 +29,9 @@
>   *
>   * init is a 16-bit bitmap used to make sure the user selected a correct
>   * configuration as per the specification.
> - *
> - * supported is a 16-bit bitmap used to reflect the hw capabilities.
>   */
>  typedef struct {
> -    uint16_t map, init, supported;
> +    uint16_t map, init;
>  } RISCVSATPMap;
>
>  struct RISCVCPUConfig {
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ce71ee95a52..86a048b62c5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -437,14 +437,27 @@ static void set_satp_mode_max_supported(RISCVCPU *c=
pu,
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
>
> -    for (int i =3D 0; i <=3D satp_mode; ++i) {
> -        if (valid_vm[i]) {
> -            cpu->cfg.satp_mode.supported |=3D (1 << i);
> -        }
> +    assert(valid_vm[satp_mode]);
> +    cpu->cfg.max_satp_mode =3D satp_mode;
> +}
> +
> +static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
> +{
> +    bool rv32 =3D riscv_cpu_is_32bit(cpu);
> +    const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> +    int satp_mode =3D cpu->cfg.max_satp_mode;
> +
> +    if (satp_mode =3D=3D -1) {
> +        return false;
>      }
>
> -    assert(cpu->cfg.satp_mode.supported & (1 << satp_mode));
> -    cpu->cfg.max_satp_mode =3D satp_mode;
> +    *supported =3D 0;
> +    for (int i =3D 0; i <=3D satp_mode; ++i) {
> +        if (valid_vm[i]) {
> +            *supported |=3D (1 << i);
> +        }
> +    }
> +    return true;
>  }
>
>  /* Set the satp mode to the max supported */
> @@ -1176,9 +1189,10 @@ static void riscv_cpu_disas_set_info(CPUState *s, =
disassemble_info *info)
>  static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
>  {
>      bool rv32 =3D riscv_cpu_is_32bit(cpu);
> +    uint16_t supported;
>      uint8_t satp_mode_map_max;
>
> -    if (cpu->cfg.max_satp_mode =3D=3D -1) {
> +    if (!get_satp_mode_supported(cpu, &supported)) {
>          /* The CPU wants the hypervisor to decide which satp mode to all=
ow */
>          return;
>      }
> @@ -1195,9 +1209,9 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>               */
>              for (int i =3D 1; i < 16; ++i) {
>                  if ((cpu->cfg.satp_mode.init & (1 << i)) &&
> -                    (cpu->cfg.satp_mode.supported & (1 << i))) {
> +                    supported & (1 << i)) {
>                      for (int j =3D i - 1; j >=3D 0; --j) {
> -                        if (cpu->cfg.satp_mode.supported & (1 << j)) {
> +                        if (supported & (1 << j)) {
>                              cpu->cfg.max_satp_mode =3D j;
>                              return;
>                          }
> @@ -1226,7 +1240,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>          for (int i =3D satp_mode_map_max - 1; i >=3D 0; --i) {
>              if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
>                  (cpu->cfg.satp_mode.init & (1 << i)) &&
> -                (cpu->cfg.satp_mode.supported & (1 << i))) {
> +                (supported & (1 << i))) {
>                  error_setg(errp, "cannot disable %s satp mode if %s "
>                             "is enabled", satp_mode_str(i, false),
>                             satp_mode_str(satp_mode_map_max, false));
> --
> 2.48.1
>
>

