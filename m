Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D7AEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsvZ-0002o8-Pe; Tue, 10 Sep 2024 00:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snsvY-0002iP-Jg; Tue, 10 Sep 2024 00:56:32 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snsvX-0003J8-0V; Tue, 10 Sep 2024 00:56:32 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-502b6e2a0acso97427e0c.2; 
 Mon, 09 Sep 2024 21:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725944189; x=1726548989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkEX51JC5qtxs/FUCGRzIPUgWawCG2Thy/Z6rkaUflg=;
 b=DjwvE5KL5YhNylo9sGEShJZu/gZ58H20Yxwt3BAawY2kTZhKhMa5cynZMPO4XCjxLR
 /AR9d6Mir4xwLiMmeLAYN1Fa8Ff1SmrYnAgodnhk0j+TqrK1G/bJffrPU075KGsJYs0Y
 WpyCE1rblAanTCoHCDg2pxgP7CuCvjgnsls6hHUQAXZ0XXg6P1Zyr4kEFWE5OcxbcdyZ
 Zp8xBnW8eyUPC2h7OeTwsh6Mb8IqiXcw9bZDHFEBQ9DzNFplOYU2FZgCxd3Mr3FdMSus
 MJLpGhSF8Zvzy+45fZiYn5oagjd9LfFzpmJKxxmAFoCih/w0Y0QWKHWe/pBQkNa0pnDw
 +l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725944189; x=1726548989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkEX51JC5qtxs/FUCGRzIPUgWawCG2Thy/Z6rkaUflg=;
 b=WsDxEX042O+RSKGkPFYpknao9E6EVC0h7J/ntQGbyOlGhAboqQFIrDWeSPAOHWkuua
 T614wl7CTERBm/WWA0IcDMP6GIiJI8Ds8FdD0tMAnJUEVlUqHj2A4SWxhYLq1frxi6zz
 n+OFgA9FOq/voePt7qcj/gzVUWF+YcduH7oujn/E/Sq6qfzcVpwFWLjjn67etfIEnKn/
 YJg/Z5vdf9leK9ROC6bs7QIKkxV26ZQYSBx/IsDwCgiuSYbh9983CsfTW/9/Hxwcyyru
 zRCeNy0JeCIHpTetpp/iQliJxOIvNR8j9tIbEJiFtqBs7dDy+Qgm1ozCSrBUxz/B1ws1
 F7Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTitbqX7qK/S1z46cSME0axo5flMrjlZzM8zlPeeULNWtjcyMO77wmk0v+2LVQYkzfjd2gCMzVtNKh@nongnu.org
X-Gm-Message-State: AOJu0YxlMxl6KSZGOMVQU0l1QxkSQUPllZQPO4+0eeOSMx14dhS1XD6n
 rGI0RvdW7DHI4vT2MQz3Ry8GXlCnslodnpXvn+KyzFE8q38PpqpnfUOBaagCESwWF0SXYFPafOF
 NnHtJx4zalJ3kL/aAC2oICPnSFAw=
X-Google-Smtp-Source: AGHT+IHZGjRO4dgdgd4UQarY3MUR13Lgk1PbMjSUTInI8z71Veqm2IhAA34bvPq31ChmLI87Mx/pgQanfophcvEYgK8=
X-Received: by 2002:a05:6122:4d1a:b0:502:b3a9:f40b with SMTP id
 71dfb90a1353d-502b3a9f4ffmr13450711e0c.7.1725944189309; Mon, 09 Sep 2024
 21:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240906094858.718105-1-thuth@redhat.com>
In-Reply-To: <20240906094858.718105-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Sep 2024 14:56:03 +1000
Message-ID: <CAKmqyKN0a9Q4YauUa8wSsY=ErKCc+EE6zbsix+SvikBXwKO+rQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

