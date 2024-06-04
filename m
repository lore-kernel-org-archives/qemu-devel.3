Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA80CC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEI4s-0002N6-Td; Mon, 03 Jun 2024 20:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI4n-0002Mk-A4; Mon, 03 Jun 2024 20:30:57 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEI4l-0003g2-H4; Mon, 03 Jun 2024 20:30:56 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4eb02c0c851so1535781e0c.0; 
 Mon, 03 Jun 2024 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717461054; x=1718065854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6VFLo7QK93O4DyvtWEzd63UAnTIpPgFf5wl+jFB00E=;
 b=KP3YsVO45PuS41e6fRT3ZsogRfM8llEJnxag1VSKOsBIUuQap0GBAWHNiJacK21Zkj
 G7+STb4m9COMoL9JXx3DoQmZ+wbtv3dQArMkHFntMZgeVKcRxr9NRVLOZoHXGrmTFxWg
 q13jNGSxyosh/6q0d+SokDBPt9C/r/gioZqS3fvHnzFdg/LNcZ90/F7rHABLKUPqdpQD
 kPiTg8G3yyTT+s6K2MFz0CwPNYwcpt7ytWaA84nZ+zGjnjHFBTWrZhXfC8wFR1DRfLkm
 3YmbbZQ8NPpKpK9ukQf3GY6nCJQxqz2jPHpsICzw8FsKPI68FHHxUtoLu+tCJ65qWUjY
 DoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717461054; x=1718065854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6VFLo7QK93O4DyvtWEzd63UAnTIpPgFf5wl+jFB00E=;
 b=ndztw8y04UxhKNsHmaziKGuyg5ljnAxJ/SncT8nNR98Y18C9psBTZgmczXNui664BC
 9YDjIdXV34IZeBF0aJCG8mrKqKVnS0yga3FRczL3ynmQXZOqW6R6wvRpEPCguYkKRxKR
 ffQqKaycElWOpWxramSqDkRJSvUgoTQniOLFeVTeACYgF+4nRbt1td0G/A6kUz0fr/f9
 e71vukVNkXTa5tzytO/ODeVD/vmgKn4lMk0Z4myq8/paRKKG5o/4LNI1EWl1/BkFsGrT
 y6pCHOzBuWA+aTR79qOHQBCtBl8s9Ts5E6YHC+XrhKl/g7pT5GyqGffuX7bUtv5/2RA6
 icLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4scse9vLOr4TdTuKWbDo1K120hLHDkbzgEZ34f/T8Qrk9k8O04KVPQ+QRDfBfzjR3IyvJF8k5ewp0IWfBpadpw1tpsIU=
X-Gm-Message-State: AOJu0Yzn0En7GvvaOm7n/gBP9wVtqLlew+ZtJOn0g/HCPF2vumC36Nfm
 LJ+zuBnX2t3NXj7+HZ8E7cYdwpgto0vb/K7oc10KkLUX93eF8edbd+pg4/wgz9NWh8s5aT9NYpR
 r47BEfRQqWnK3D4y5IhKSxx0ajfc=
X-Google-Smtp-Source: AGHT+IHXoFjVScHl2Ipu1jF2y4cCHt1G1Aa+kfJ/5WD7cSta18DYJ+BrJdZ8GxYlUROx61E81MWbsm+pfZr62NEffiQ=
X-Received: by 2002:a05:6122:e6f:b0:4e4:ed90:27cc with SMTP id
 71dfb90a1353d-4eb02d7cb9dmr8227476e0c.2.1717461053803; Mon, 03 Jun 2024
 17:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240515080605.2675399-1-fea.wang@sifive.com>
 <20240515080605.2675399-2-fea.wang@sifive.com>
In-Reply-To: <20240515080605.2675399-2-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 10:30:27 +1000
Message-ID: <CAKmqyKPKqt03UbMYyssX8kqAqkMM6hE+OTbDkhPxaffs8+FxUw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/5] target/riscv: Reuse the conversion function
 of priv_spec
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Jim Shu <jim.shu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Wed, May 15, 2024 at 6:03=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> From: Jim Shu <jim.shu@sifive.com>
>
> Public the conversion function of priv_spec in cpu.h, so that tcg-cpu.c
> could also use it.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         |  2 +-
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 13 ++++---------
>  3 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2946ac298a..6dd3d7f4a3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1786,7 +1786,7 @@ static int priv_spec_from_str(const char *priv_spec=
_str)
>      return priv_version;
>  }
>
> -static const char *priv_spec_to_str(int priv_version)
> +const char *priv_spec_to_str(int priv_version)
>  {
>      switch (priv_version) {
>      case PRIV_VERSION_1_10_0:
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 1501868008..140eb43fcb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -833,4 +833,5 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit);
>  /* Implemented in th_csr.c */
>  void th_register_custom_csrs(RISCVCPU *cpu);
>
> +const char *priv_spec_to_str(int priv_version);
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f59b5d7f2d..fa186093fb 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -76,16 +76,11 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, u=
int32_t bit,
>
>  static const char *cpu_priv_ver_to_str(int priv_ver)
>  {
> -    switch (priv_ver) {
> -    case PRIV_VERSION_1_10_0:
> -        return "v1.10.0";
> -    case PRIV_VERSION_1_11_0:
> -        return "v1.11.0";
> -    case PRIV_VERSION_1_12_0:
> -        return "v1.12.0";
> -    }
> +    const char *priv_spec_str =3D priv_spec_to_str(priv_ver);
>
> -    g_assert_not_reached();
> +    g_assert(priv_spec_str);
> +
> +    return priv_spec_str;
>  }
>
>  static void riscv_cpu_synchronize_from_tb(CPUState *cs,
> --
> 2.34.1
>
>

