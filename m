Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA3DCD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 03:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snVRP-0006CU-1B; Sun, 08 Sep 2024 23:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snVRJ-0006BI-G4; Sun, 08 Sep 2024 23:51:45 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snVRF-0002sC-7c; Sun, 08 Sep 2024 23:51:45 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-846bc787b3dso1120004241.2; 
 Sun, 08 Sep 2024 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725853898; x=1726458698; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abUmh1cb6LfNs6LKJnqLJS08eWgphPpsDew9XEqrAo0=;
 b=hBckH2NrNIgER1bx6041xFworAtEV/D82lFvnf287hTugESXMvazt5VRZerkjC/DJo
 wuS3UkAwvIp2r8+9HHq7qQUfs8TaO5CQzEycKgoMCBlQOK86n7HPLtKh+xTeP3NI+1b8
 7wNT/kDGHH+0Kg4lcrfIJTSczQe+ZjsElkzAMjgs7fNaaGvD4FBAXr0OE5DK5LtM+Wum
 AxhgYZnshY1R4qVXuZllT7AtF5ZfV4zUGSQvcs2cDGWEz4Xo4NJYAX+AiY0m9AgkvIpe
 7mVXg0fpsx6EqmZKXCrf9gPa63p7rWff07ldN+Jlmj1nHCrpXE59QaLV9GQKbrAuypVj
 rRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725853898; x=1726458698;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abUmh1cb6LfNs6LKJnqLJS08eWgphPpsDew9XEqrAo0=;
 b=b+8HDe3aHqnFDGVjQ+2JDP+UJMrGe35NcTQHFRdUqD+xAc4tY5JNun5TzqqczgDHJR
 sbk15H23NBgBxNYYJV7fHymBMf4KsY2N8PIL4/bpB4KgL3mWxQHBmMlDURgWjQ+FTN+e
 NfuWfTVojpc7utm73RP4h6Y2rvFWerDV+JecdEnoutUfCqR/WVMYgk1AcyQRDR2io9Rt
 RlR/vGJBlv8I9gCXxSxe0mA3YMLnc73ZUQRST3muLEtknlSNt8uHgX2gmXt/oiInOeTU
 NkIGz8ZpuRb4Ld5292Jw3yx26I5MKQFIGCKN8mMsjot9LcSOVDuMTKcZaV7B2f4V0Gpw
 xCwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA40fIp2SK9hMhb5habutknTIU4EsUZ3Htjd7oSUpFQdEwZoR5EHWSVeKnUNHYhJZk+8Iy3RLC8Y3T@nongnu.org
X-Gm-Message-State: AOJu0YywVQ6BQBQqco23kMerUMrF7BPLNmnbSsmQK0m5CC+jrzr6GmkL
 /NmznT+UxUQ3KIhQ8SpNBox8NepSCO1kHjZmn3QltmtsLclKWp2UpWAw7/kB2gBAPUGtmlq5iSa
 GUqwticn3WJe+LGJPNVTsXmN+MM8=
X-Google-Smtp-Source: AGHT+IG9FG4lF7EFBnXMCido4/kaW1zJihmcfocFVl7q0hmTRVet1X8HtyzDklxm2G1fMd0BDwK24+oUU7OgNGpyZXw=
X-Received: by 2002:a05:6102:f14:b0:493:b916:aaa6 with SMTP id
 ada2fe7eead31-49bde2e68f8mr10262161137.24.1725853897990; Sun, 08 Sep 2024
 20:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240906094858.718105-1-thuth@redhat.com>
In-Reply-To: <20240906094858.718105-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 13:51:12 +1000
Message-ID: <CAKmqyKPKfhLa9=0K=_u++wvgHg7FM93YxM=fT+BYqyEU=oK6mQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/cpu_helper: Fix linking problem with
 semihosting disabled
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Fri, Sep 6, 2024 at 7:50=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> If QEMU has been configured with "--without-default-devices", the build
> is currently failing with:
>
>  /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o:
>   in function `riscv_cpu_do_interrupt':
>  .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined
>   reference to `do_common_semihosting'
>
> We always want semihosting to be enabled if TCG is available, so change
> the "imply" statements in the Kconfig file to "select", and make sure to
> avoid calling into do_common_semihosting() if TCG is not available.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  v2: Use "select" in the Kconfig file, and "CONFIG_TCG" in the #ifdef
>
>  target/riscv/cpu_helper.c | 2 ++
>  target/riscv/Kconfig      | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 395a1d9140..dc147181a3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1674,10 +1674,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
>          switch (cause) {
> +#ifdef CONFIG_TCG
>          case RISCV_EXCP_SEMIHOST:
>              do_common_semihosting(cs);
>              env->pc +=3D 4;
>              return;
> +#endif
>          case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
>          case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
>          case RISCV_EXCP_LOAD_ADDR_MIS:
> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
> index c332616d36..11bc09b414 100644
> --- a/target/riscv/Kconfig
> +++ b/target/riscv/Kconfig
> @@ -1,9 +1,9 @@
>  config RISCV32
>      bool
> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
> +    select ARM_COMPATIBLE_SEMIHOSTING if TCG
>      select DEVICE_TREE # needed by boot.c
>
>  config RISCV64
>      bool
> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
> +    select ARM_COMPATIBLE_SEMIHOSTING if TCG
>      select DEVICE_TREE # needed by boot.c
> --
> 2.46.0
>
>

