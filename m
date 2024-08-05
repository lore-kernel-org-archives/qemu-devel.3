Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C31C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 23:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb7FE-0004Y8-4O; Mon, 05 Aug 2024 19:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7FC-0004TZ-Vv; Mon, 05 Aug 2024 19:36:03 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb7F2-0002Fx-OR; Mon, 05 Aug 2024 19:35:54 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4928989e272so70083137.2; 
 Mon, 05 Aug 2024 16:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722900951; x=1723505751; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uw4csCZKo0Irivc1VoFyWmCXAXveMzT4tgkHTvKy88I=;
 b=ZPLh9yKwJJ/rcdn5CLBGVx+lObOv5XNfgDAEuZ9zYaD933NJ+Rw2DZhTHpMU6uh72/
 Ch1k9kGyEcHQ+cZnOcPDPIPMZrqVRxTbWMqfQdY8Qf6rT8qfnFalVCDbjlahHc50zSqJ
 NLLKo82I+JeLAQla2r0WZhFdVEyPLZcMbjUrZSrq/FqFG3Zh+YHrMmqqhoBK8tgY3/Mr
 oJ700UYxv4tvIyzFfQLbMpVptjVavrM/u6SZMN3x8gD+aZUeuCajF+Y4HVFn5Oo8hcSL
 efab5fIM/xpIDl81jhkZzkCClwuxlhV113TKV6xa7exl6+kWsGEw5bS3x4ct+ZT6Dwsj
 HEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722900951; x=1723505751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uw4csCZKo0Irivc1VoFyWmCXAXveMzT4tgkHTvKy88I=;
 b=k6gSC9Bssq4F5o5xbeXRIGuHElzs+JuHjgYtTa533Bh4VeNLxQ3QjcYQ5AZtCobW9U
 ESB36/L8aD6MHipAdevs6S0oajNALcvdA+fWkI/HHBBbd5U341WhDxw3SYJAVVFCWBVo
 1yFr4VqRLSPcxltF0aU723asDmuZyUbnN3Zpb8YYsX/VdtV99J+rbOah1bN0R35nf2/y
 ZUA++ciwNonr2qjwbY8O4cdcCdnb6y1CRaLL43fazWQQG8/2DmJcUIjhykb85cKQs5ij
 bn26fer7Yek6NjcFJPQDHulDOotUyxf7ordSQpyM1GrJCVmbozW/6+kebURGRQWWh0cH
 rGQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxxum7hOlGVTLziSASc+FS/iQTvMzLLusBR0RFShXj9IXOMO8EJ+HLrODfZyVhNXDPw4VSIK4ypzaVeaXUVpskAbK2uow=
X-Gm-Message-State: AOJu0YyG4bW2G34DUy0Q2Z55b2aRC07u1QKGg6M2imdiOr3eCM/mF4bP
 xlGRbwJ6PdrTO9wo4h2prrfm8DYDHDLInZOlHQMFXb2HpsTLZYrKDgMc3qHD8mTGydmvkNTPLSO
 kMpo9xgqksU2PhkXZIt2HvWQJTSM=
X-Google-Smtp-Source: AGHT+IE6IQNab4+LdvDil9FmyUSimZANYn/eG4GZqWC0s4F8AymZP6GN1871zPPmAazABj4IiL27OPMZ6ufKEpaJTGw=
X-Received: by 2002:a05:6102:c4d:b0:492:a8ed:e32f with SMTP id
 ada2fe7eead31-4945beafef3mr15175611137.21.1722900950751; Mon, 05 Aug 2024
 16:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240805120259.1705016-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240805120259.1705016-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 09:35:24 +1000
Message-ID: <CAKmqyKNOAuRzOMimjnxhr7sxq8htv7Otv69Kzpz7HCXJ8yrTzQ@mail.gmail.com>
Subject: Re: [PATCH for-9.1 0/1] roms/opensbi: update to v1.5.1
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Mon, Aug 5, 2024 at 10:04=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> OpenSBI v1.5.1, a bug fix release launched shortly after v1.5, contains
> several bug fixes that we ended up missing in our refresh to v1.5 a
> couple of weeks ago.
>
> It's a purely bug fix update from what we already have in v1.5, so I
> believe we're justified into doing this update during the bug fix
> freeze.
>
> Alistair, the patch was created with --no-binary as you suggested in the
> last OpenSBI update I sent. Please fetch both binaries from:
>
> https://gitlab.com/danielhb/qemu/-/commits/opensbi1.5.1
>
>
> Daniel Henrique Barboza (1):
>   roms/opensbi: Update to v1.5.1

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268312 byt=
es
>  .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 272504 byt=
es
>  roms/opensbi                                  |   2 +-
>  3 files changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.45.2
>
>

