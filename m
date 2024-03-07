Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AABC5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 00:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri1m2-00065m-IQ; Wed, 06 Mar 2024 19:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri1lz-00065J-SV; Wed, 06 Mar 2024 19:38:11 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri1ly-0000cd-5f; Wed, 06 Mar 2024 19:38:11 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4d346e4242fso91575e0c.3; 
 Wed, 06 Mar 2024 16:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709771888; x=1710376688; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b82yz/PWPSbIk7u3wkU2gko4HUYl4EFp7HRPSeZD6A=;
 b=OIR5xWsoTuJGaVM7HAQ/uIoe/JU/qMHjbPXXTR09uaL+595YdWXGztPyTXx6qXstQq
 Jit5y3KyYEUm80tRzGJs8McnCgJeVEx2bts4n9MM1IvILMYWuHBab+Z931qd3obWzzqi
 jt0LzFB/YdMgYHG4k/amBxuAhMC4bIW4dEQ58FSLncePDtvooo1q352nf7+nHv8OxJbC
 jfxfzDv/gr2wVkIkJyjgdmI5PAPTjq1aF3DpWHzzyi4XBmF1p+CeSf8YkYmyw3ph6jkI
 SAsyspl2LYgRrrarC/r/osAVdgrL+Ah/A+yln90yuBlfA1shuQ90hgx47aiPAl1Eljpg
 xR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709771888; x=1710376688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+b82yz/PWPSbIk7u3wkU2gko4HUYl4EFp7HRPSeZD6A=;
 b=ZeZ5SdGyDVSbOv1E2QwH3onw+WCgRCyWX3gL1Wj1nH46pI5S7/+sl5Tnr5wQAfGKNC
 MJG2uLx3RVufIJguZyvo3rS5nSeaxzeLDcedtN9Y1S7nltJCPJGWNYsG2IEIRdEqseFq
 XYjQjySvFEYeJNwNoyOUVAY8m4XBT80+bcsDUxk/WhDVuzjsq6Fpjp0vCHxWPty2rT80
 VDhSoYumtwNiNbFyjNUgnnbkadM7apI4PqGqAibypY+UhsVbxoOJnuU/kzLh5QhyAxww
 uHJPE2CKNyRtbl14gMmXNjlYKOjADONTX01aKziq/ZafrvAtAiRgDACRjrUD5hyh8MmQ
 fOJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8uiCEu3pUG3mrDn7oDkBLZeUFLhSmCG7BUoknSyZR/081bfYRjeeUm+DDqxtlDuegNpkhUSk+89OLPTMCEhS7LCiST+Q=
X-Gm-Message-State: AOJu0YxiAxKjheDjguriGDnd6tullluf0S3lQUG4yn8LGW9jfTLA8AGi
 LE4/3MoiZdppYXA/Ra3peerZHCp+Rf0okrUNqBolrovDCf1p1DUHszoZXLKGLjD3kfF5xViYYwr
 c/QnMtaow5MMP8QGX90Z/jD+4gp8=
X-Google-Smtp-Source: AGHT+IH2aDg2820AIFDOyTMgNXdzbbDVhB8RQRqlcpZS6kPPV6JDedjzjsqohqOgxEylcaMLHcbmpdHzPl/VFyjHzbA=
X-Received: by 2002:a05:6122:2a50:b0:4cb:2930:7477 with SMTP id
 fx16-20020a0561222a5000b004cb29307477mr7450172vkb.3.1709771888119; Wed, 06
 Mar 2024 16:38:08 -0800 (PST)
MIME-Version: 1.0
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240306171932.549549-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 10:37:42 +1000
Message-ID: <CAKmqyKM9CdC_6R9z4+QhCVS2JUY6hX0h4+ZEAsLsgttgrA0cTg@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] riscv: set vstart_eq_zero on mark_vs_dirty
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Thu, Mar 7, 2024 at 3:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This version is rebased on top of alistair/riscv-to-apply.next, fixing
> onflicts with the Ztso changes in ldst_us_trans().
>
> No other changes made. All patches acked.
>
> v6 link: https://lore.kernel.org/qemu-riscv/20240221213140.365232-1-dbarb=
oza@ventanamicro.com/
>
> Daniel Henrique Barboza (8):
>   trans_rvv.c.inc: mark_vs_dirty() before loads and stores
>   trans_rvv.c.inc: remove 'is_store' bool from load/store fns
>   target/riscv: remove 'over' brconds from vector trans
>   target/riscv/translate.c: remove 'cpu_vstart' global
>   target/riscv: remove 'cpu_vl' global
>   target/riscv/vector_helper.c: set vstart =3D 0 in GEN_VEXT_VSLIDEUP_VX(=
)
>   trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>   target/riscv/vector_helper.c: optimize loops in ldst helpers
>
> Ivan Klokov (1):
>   target/riscv: Clear vstart_qe_zero flag

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvbf16.c.inc |  18 +-
>  target/riscv/insn_trans/trans_rvv.c.inc    | 283 ++++++---------------
>  target/riscv/insn_trans/trans_rvvk.c.inc   |  30 +--
>  target/riscv/translate.c                   |  11 +-
>  target/riscv/vector_helper.c               |   7 +-
>  5 files changed, 99 insertions(+), 250 deletions(-)
>
> --
> 2.43.2
>
>

