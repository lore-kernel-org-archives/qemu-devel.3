Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D85C47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rePqd-0005ZU-Px; Sun, 25 Feb 2024 20:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rePqc-0005Z2-4T; Sun, 25 Feb 2024 20:32:02 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rePqa-0006Fh-H4; Sun, 25 Feb 2024 20:32:01 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d2940ad0e1so1498544241.1; 
 Sun, 25 Feb 2024 17:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708911119; x=1709515919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuhulZ098j46FJRAUKtfGkrxhBO31kfywrGzVhEGLmU=;
 b=D6M6+RmJfasNOUKpEbPVhbl14wyOEUEcE6pfq0S7fG/16Aw3MDt4mR/tM53l4lvZ83
 nes/1kBOvF3tRZVe2dz20WIx8mOSFXmfrcHSVuAFA62Z6jZDjkz0NbsqajwnQFwT8JJV
 sOFaOVPbBl0DdI5l/uyNg6oytCZghYo9zCPB6ld5Z9bLyxa8XEqTxSjNC7IeMNIEs/Z3
 U2VcHdiXDtOx3W1z2/E/bJvnLDaIvPuozbGo+h1cH5Q/T6WTFAU1pqR5A1TK8Avj/pjM
 +d3bzwy4FmXw94knoU0QPCi6bvPApATcr6FG2GJu26PqmYQv45tutuOIqsqiZObmoVo7
 qZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708911119; x=1709515919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuhulZ098j46FJRAUKtfGkrxhBO31kfywrGzVhEGLmU=;
 b=wfemQlCj+FmJtbHpoe56d+szYDjJ5juA/kHhRQQ2ZbaU+QpUlcxKBsAOd5qlkxGjzw
 UrFfYAiX8/PoLxrqsp4sP7iNd3/tJDkFN5EaxIFoXvIoRw29KOPpBKbdklOaBXfslK94
 yEUVOTQYNOffLqHy4fiV8cMRRgc9KPxzwYbXzwUobiQDKIlxDdl3g428GyQndGHl2xB8
 cBW0LV4ETK8kozK66nxVVb//Pb3zUdVL2AtrYFpokDW4amTaorvEwxS3uOZaDHYy7pFy
 nwdAuz7Zgq6Fs5lqegYqB98ewzT4GVuvr6OzpKBTUkwOWX0WjVSMDRRMJKORGni/mj24
 jkgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ykeqLnzX9pFcmXOKFOLTpKoL/rxDP6IS/NYq6G7BXhhjcJbRDP4me97clVklr9/Jbxc0ANc/BT0ZVgS0tgfbsHMHjTU=
X-Gm-Message-State: AOJu0YzVXhZwMX9QYjvehaoGzsPHnhmBpr5jP5mK5zJdfg0UI0GH6V+4
 ahPKHDMETFIdl3GdV3gU8gQOXVwa+oqGYsWSxeVi3oOR4oVJQfRJGC935TIY+Kix4oZO8J8XbaQ
 J81b7c+7hcr4smLE1DR38ZiX2CF4=
X-Google-Smtp-Source: AGHT+IFfyQJr6/rHWvNS9HMtg2+d27GItti4FCapaDCA53WHAEVUb9sMmtZQ6y73u2Q7urdZmEXWpZDJPS8iMJERjbI=
X-Received: by 2002:a05:6102:31b5:b0:471:aec1:4300 with SMTP id
 d21-20020a05610231b500b00471aec14300mr2354293vsh.11.1708911119148; Sun, 25
 Feb 2024 17:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20240207122256.902627-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240207122256.902627-1-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Feb 2024 11:31:33 +1000
Message-ID: <CAKmqyKPbvZ1wQmd-3_VtUx7wAR1PPwRVV4=gca2V=3fk0Xua9Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: Add Ztso extension
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

On Wed, Feb 7, 2024 at 10:24=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> The first patch of this series picks up an earlier v2 Ztso patch from Pal=
mer,
> which can be found here:
>   https://patchwork.kernel.org/project/qemu-devel/patch/20220917072635.11=
616-1-palmer@rivosinc.com/
> This patch did not apply cleanly but the necessary changes were trivial.
> There was a request to extend the commit message, which is part of the
> posted patch of this series.  As this patch was reviewed a year ago,
> I believe it could be merged.
>
> The second patch simply exposes Ztso via hwprobe.
>
> Relevant in this context might be also, that Richard's patch to improve
> TCG's memory barrier selection depending on host and guest memory orderin=
g
> landed in June 2023:
>   https://lore.kernel.org/all/a313b36b-dcc1-f812-ccbd-afed1cbd523b@linaro=
.org/T/
>
> The first patch was already sent as part of an RFC series for Ssdtso:
>   https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02962.html
> Since I don't want to keep this patch until the ratification of Ssdtso,
> I would like to get this merged independent of Ssdtso.
>
> This series is based on today's riscv-to-apply.next with my other series
> that adds the new hwprobe keys
> (https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg01293.html).
>
> This series can also be found here:
>   https://github.com/cmuellner/qemu/tree/ztso
>
> Christoph M=C3=BCllner (1):
>   linux-user/riscv: Add Ztso extension to hwprobe
>
> Palmer Dabbelt (1):
>   RISC-V: Add support for Ztso

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  linux-user/syscall.c                    |  3 +++
>  target/riscv/cpu.c                      |  2 ++
>  target/riscv/cpu_cfg.h                  |  1 +
>  target/riscv/insn_trans/trans_rva.c.inc | 11 ++++++++---
>  target/riscv/insn_trans/trans_rvi.c.inc | 16 ++++++++++++++--
>  target/riscv/insn_trans/trans_rvv.c.inc | 20 ++++++++++++++++++++
>  target/riscv/translate.c                |  3 +++
>  7 files changed, 51 insertions(+), 5 deletions(-)
>
> --
> 2.43.0
>
>

