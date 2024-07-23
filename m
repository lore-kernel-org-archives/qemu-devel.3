Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C959C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6Xv-0007zp-S5; Mon, 22 Jul 2024 23:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sW6Xv-0007yu-0r; Mon, 22 Jul 2024 23:50:39 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sW6Xt-00052e-Af; Mon, 22 Jul 2024 23:50:38 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-492a01bce97so593640137.2; 
 Mon, 22 Jul 2024 20:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721706636; x=1722311436; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TY2F/ZSPeN36+ezoauhtgQTbsqUJjegQlVcrfaa/MO8=;
 b=j+e07wPak01AuylhXJ6dzaZ2SvGxrV6ecvtUBwdqe6Jw1cjpTXYLlgFjL62/lBxpee
 mYGO4l4PEx4CfrCo6JKwNGQ2tFCt1KG+uMiyG7y7f6I1RgLopHehCumBJwaT8f+Y125f
 6GHIxxkqPVlQ1DUKX/kZSwYbYWk4O22KI/wKL+S78gPKWED2UCie1Hhjix2WKHyvRnl4
 TQPIb6mXj9OUUKSwtp932xJMZCciDZXPp6SlaOqv0khfxlKBTPemboQlzGu8E1WVWNqi
 1t5eOx+IXvO13pm8nY3r6RKP1jTNVWLcaJYttvfTk/WEHsjjfxgfyU/eOqMIWxwnyANk
 ac9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721706636; x=1722311436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TY2F/ZSPeN36+ezoauhtgQTbsqUJjegQlVcrfaa/MO8=;
 b=h0LQ0LsUBUOAPNM3Co70SbRUH+cViDXgC1wOVx+/hp+Fki1WGOVeoRK2LifMCzN4Vy
 MBJPvm8OrIUiCL8z2+9H9ggRmn4p10zZvQcMQKEn3kILEvMr6nys+uDsE5iKYzWTNgMj
 t1e91SdO2qJleqam7RxOLpcEkPBH7A0Ckb11V5fVszSlf+1uO2QW73OdkkqlmyZuhPcg
 FcKQw0L3ZXfWFoUlBQ+072TyWz+NaQWhxuZZSIOASI+vN/2QEOyFlqtSNGrBR4cC0Rk5
 YVkmlE/NwQK1IQuG1NpbGlf8be3kw52rpw4hkbDR90NsMG8DQa4k9vYpvuaB8xD2ogdM
 4cbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjlN0IlwWwo1MndxMkqp2pUzxGresfqrzSg/9PHfp39+vkJS2+pcEcn4S7IEcOOy7GZbOiFuDcMe9WCsUliByIT+gk2+E2yLM+19VjvJHMsffOvqhAwMPN7J7Ifw==
X-Gm-Message-State: AOJu0YzD2Gc/cYnM1uw8Y5wMZoNwn/MyF4xXFyug+6fCFZ981OPnH23p
 uyOWETccixcCRxXka387+t423bIj9mLyWZazJV819CqNzJtFWHqp/qe9g7tkmsUhRQbOiORuYhQ
 8S1oZv0qZWH0lIv//u8nRcZiHO+c=
X-Google-Smtp-Source: AGHT+IFCaiS2yHfSMWcY4cyP1I0Pap3bS+CpXzIxClXyKsSEny5RTI+tn1iDILFlYNS6/RoPZ+we7TP2CF5p9X4vj48=
X-Received: by 2002:a05:6102:3c8b:b0:493:b4e1:634a with SMTP id
 ada2fe7eead31-493b4e16bbemr1318452137.8.1721706635845; Mon, 22 Jul 2024
 20:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240723013012.1443-1-zhiwei_liu@linux.alibaba.com>
 <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
In-Reply-To: <dea63117-cabd-4669-bffd-e8c0cb8d9147@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jul 2024 13:50:09 +1000
Message-ID: <CAKmqyKPAeXbRpFYFsypmw8GqOcysNEy=C+XBysz6X9veRLbr+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Remove redundant insn length check for
 zama16b
To: Richard Henderson <richard.henderson@linaro.org>
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Tue, Jul 23, 2024 at 12:13=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/23/24 11:30, LIU Zhiwei wrote:
> > Both trans_fld/fsd/flw/fsw and gen_load/store will never be a
> > translation function for compressed instructions, thus we can
> > remove instruction length check for them.
> >
> > Suggested-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>
> That is both false (trans_fld is used from trans_c_fld), and not the take=
away you should
> have gotten (the operation of "fld" should not depend on the encoding).
>
> Perhaps FLD/FSD should depend on the ISA (RV32 vs RV64), but perhaps not.=
  I cannot tell
> because I don't see a specification for Zama16b in

It doesn't seem to depend on the ISA xlen.

The whole spec is just a simple one liner. Apparently that is an extension

https://github.com/riscv/riscv-profiles/blob/1fe6f65f130c219c761142e74742d2=
409c173c40/src/rva23-profile.adoc?plain=3D1#L176

Alistair

>
>    https://wiki.riscv.org/display/HOME/RISC-V+Specification+Status
>
>
> r~
>

