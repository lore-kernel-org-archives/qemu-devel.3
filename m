Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4227CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjoqs-0006BX-32; Thu, 29 Aug 2024 19:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjoqq-000645-1Q; Thu, 29 Aug 2024 19:46:52 -0400
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjoqo-0004eT-FQ; Thu, 29 Aug 2024 19:46:51 -0400
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-8430670f247so350958241.0; 
 Thu, 29 Aug 2024 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975209; x=1725580009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YzhvPajGjsKerUyziCDusDULFqTyAakcHBnOHoj3dI=;
 b=FIGhweSVb6pfVstQjJ+ND2bxchUVZiOAUkPqzmvmIAnI9Orys1qVtWl43dU7G1qG2r
 9cjFB+Xs35C/ErwCscnOcQyy0clVZkYtUn2OKo2Kg6SOiJPPv7dW9cfueCBFUVNkg+xY
 V/Fwu/XSblQYhgn9eRi1UavreFcH9kJlYLLDxPRYpnsUB4Bm+WSExcvu/Sj+E8PQVC/w
 XAWseDK7U9/jV5oBwtAD9LKRXJQYjqp6/Uc/cZCRSzKOcENLQhqlrzggjQBnYUD5kvUd
 dRtBqWdQqVFMiP1w7lTbLXwHp7q4YWQRWYtQTPV0hQjJC4bETIw4DJ3L1loOrGmhOX6a
 4eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975209; x=1725580009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YzhvPajGjsKerUyziCDusDULFqTyAakcHBnOHoj3dI=;
 b=ZS2Okrls+YlQZWcJL12bEtA/KM59k2FfjlzFu7Jy7DXW8DYcmb7CHYxH+b0DNaqzEm
 Q0WOZAtGriSdROxPSSaVxlcVdGB/3pVe/rOIP1+3GuivupNLMaCE+klGZ18XEichLXgD
 uponwSBs2ThgF5QfJ8zYka8ySQlnNIxTq7x7OPn9wxuAsTvJyKgGPXoan0qPL+ILW1zR
 zZ6qq01AGQZMDVDThEYC7wGvqbbs16Tg/lbVLIbCinbIPwF29s4kWhAzFQgZt/czQIWr
 XkxDl93p5exebGebLyWt3cs2aMRXyUE/4Od6aJc5tzctw46xbe470aOnV6LxSXnx++UP
 RFQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtOnQJ/Gsp6dUUE0zH25X1xlMsvI5hj3KQM25pfG9S6SSZ1Flf85KRExbiQ5J7vBfs+EU3SYwMJfhU@nongnu.org
X-Gm-Message-State: AOJu0YwVVdEcZ2vdqkvlb0h4Z7/1TbWEBAfzYoEjXEOSuyB4iCUvurSH
 CIysP3K41fzJjYGPS8PVXkzvaKUSWE8FMIuQKTEcDbxLieCZbQrHIgzBV9JVD5eCAvvKM/O7K6N
 P/bxdGvIQmXOaCJjSR837upixJxM=
X-Google-Smtp-Source: AGHT+IG+2iEotchdvSQmQMiFs6RRS+s5o/yhiiSgnLZPBRDPmfm3sFg+0XBTSE9OQpPF79PoQrLi6AgYLf6M660QSuA=
X-Received: by 2002:a05:6102:5492:b0:493:c95b:4c15 with SMTP id
 ada2fe7eead31-49a5afcd492mr5913635137.0.1724975208890; Thu, 29 Aug 2024
 16:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240829084002.1805006-2-ajones@ventanamicro.com>
In-Reply-To: <20240829084002.1805006-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:46:22 +1000
Message-ID: <CAKmqyKNb4T1NFv1NxQgHoeT0Ou=cwXU2guKaH0W3MhQH1z0DYg@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Stop timer with infinite timecmp
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Anup Patel <apatel@ventanamicro.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, atishp@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Thu, Aug 29, 2024 at 6:40=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> While the spec doesn't state it, setting timecmp to UINT64_MAX is
> another way to stop a timer, as it's considered setting the next
> timer event to occur at infinity. And, even if the time CSR does
> eventually reach UINT64_MAX, the very next tick will bring it back to
> zero, once again less than timecmp. For this reason
> riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
> previously set timecmp has not yet expired, then setting timecmp to
> UINT64_MAX to disable / stop it would not work, as the special case
> left the previous QEMU timer active, which would then still deliver
> an interrupt at that previous timecmp time. Ensure the stopped timer
> will not still deliver an interrupt by also deleting the QEMU timer
> in the UINT64_MAX special case.
>
> Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when t=
imecmp =3D=3D UINT64_MAX")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/time_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 8d245bed3ae3..bc0d9a0c4c35 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMU=
Timer *timer,
>       * equals UINT64_MAX.
>       */
>      if (timecmp =3D=3D UINT64_MAX) {
> +        timer_del(timer);
>          return;
>      }
>
> --
> 2.45.2
>
>

