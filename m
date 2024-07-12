Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F80C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCFz-0001ge-PO; Fri, 12 Jul 2024 05:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCFs-0001Mg-OL
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:07:53 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCFr-0000OU-0c
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:07:52 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-59559ea9cfdso2191670a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1720775269; x=1721380069; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70fpKTV7vrS7+zVA9+1Xo3Gc7LA6ZjoXNJVfSTaG14w=;
 b=PJH1E1wxDgruoAAuqSrWM4VK9kZk9bP4du/rpU+JEbu2JmZHSHrUJhKTtrkFaNhfqW
 KagXBUC/LzMFSwJm1J6VGyQVq8E5q+bzTIAfw5P6S7PQdrRhUpu1GR4tMeiGQbmgkOpy
 fdgrzvb2P2XdTehdtxEoFe8jerPYBg59Pzmbn4wSif7hsMoqmLIDLslnHCiMrNlikDDG
 w6hpqIWmTaZkRHi176XwsPxtNbmBbaP3DD6itr/i0UHBwkQ5js36zUtLHGFXkUkCl6kH
 UAHM4y8WpT3J6oCSIIKq6aBbPYg+GjBHFvtzifMyOIqpp8Itbgy9tuFlHMeeDUUg2En5
 W02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775269; x=1721380069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70fpKTV7vrS7+zVA9+1Xo3Gc7LA6ZjoXNJVfSTaG14w=;
 b=BInf85SHZ6TVbKr1kh3nBx8ITEdc51aGvXHoYId3O0XOUZrhiw1gMkHhQrnuyYcTg2
 lZ20NNUDVJOJfgbGqbTbTpd5zj1fZZII27+DqrCSvQ8KCK+bydynq/4J8U369vxSqK8s
 tzPSnCGSkHkZKrqowyxNskJoyFefUeAmwEnlbm8CTkM1B2uIa5cQSUvELWToD4pw4lst
 FEYsAR3uUi1LtJUMRSBaRrZhvr1Wp45IVwWsxWlr4iJcPYkMzGqIWwx/TcRD6LttpkL1
 c5B7H0NlaI7Wfk1cRgYmTHJQ8z+BjcqMSh7bTNmfNqSpEamWn46Qm9vRFvN2fSA2soo6
 B2eg==
X-Gm-Message-State: AOJu0YyErqyfnq0vD1RNYgotV2vZ+JxFVW+ikocH1zy8y/1+uMvXfuRA
 uBd2ylBAZ7dZy/hi4PAwdEFPWRytoCRooYqAZnX7YLJmv9C6F/IsVTPatRipqB0VrzJaLaKm8xy
 le+UOw2R4eiK5s4R1h6rzFHzAHLhEZgHfdh0O7A==
X-Google-Smtp-Source: AGHT+IHFxMvDe6KG5yuo6sWl+uSRc+qlgvDkoP3O3VeEnRHKhclqJDkhKbSdNubsEfNL9BBX/PTg4DBPKJs4TCypQJU=
X-Received: by 2002:a05:6402:33d5:b0:57d:3ea:3862 with SMTP id
 4fb4d7f45d1cf-594bc7c9133mr6840141a12.27.1720775269506; Fri, 12 Jul 2024
 02:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
 <20240709113652.1239-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240709113652.1239-4-zhiwei_liu@linux.alibaba.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 12 Jul 2024 17:07:38 +0800
Message-ID: <CALw707qQ9NqZfQj7xLy0X9HnSfc8uQmUAF66ibKBP_6qW-AqWA@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] target/riscv: Add zcmop extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, Deepak Gupta <debug@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jul 9, 2024 at 7:40=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> Zcmop defines eight 16-bit MOP instructions named C.MOP.n, where n is
> an odd integer between 1 and 15, inclusive. C.MOP.n is encoded in
> the reserved encoding space corresponding to C.LUI xn, 0.
>
> Unlike the MOPs defined in the Zimop extension, the C.MOP.n instructions
> are defined to not write any register.
>
> In current implementation, C.MOP.n only has an check function, without an=
y
> other more behavior.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  target/riscv/cpu.c                          |  2 ++
>  target/riscv/cpu_cfg.h                      |  1 +
>  target/riscv/insn16.decode                  |  1 +
>  target/riscv/insn_trans/trans_rvzcmop.c.inc | 29 +++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                  |  5 ++++
>  target/riscv/translate.c                    |  1 +
>  6 files changed, 39 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzcmop.c.inc
>

Reviewed-by: Jim Shu <jim.shu@sifive.com>

