Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D63C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 02:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri3VI-0008CJ-Gq; Wed, 06 Mar 2024 21:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri3VH-0008C7-7t; Wed, 06 Mar 2024 21:29:03 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ri3VF-0004CM-MT; Wed, 06 Mar 2024 21:29:03 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7db797c5c93so212414241.0; 
 Wed, 06 Mar 2024 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709778540; x=1710383340; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kqf87SnXFSxj6vNXUakzL6zBZi8561tP3M4csvcxwYg=;
 b=X+ggh/xVJwaQGAXGlMz+2EfEv+i9kcqpuvkdj5bPz/Qveo8F8QB+58UF1adDY5kRbx
 Py68WPYGbDHP4lhFF2fw05l95PhKbsWrvxb0jmRNVuk4aWFQBMIYrNgewo9uaap1gNqJ
 T6TiIjCpIVgK8BO95bdQ1Ga0z/c8gsPvnD7bX9IyLWS4pxUFabxaYfJcO/WbiNFIdOeP
 FMUx2U/ooabd2OJR6qBr+M1bNYDBIOlx0gvj13dCtCfxsZMtLKKaXFmYxrITu9uKx8GU
 HfqECzbc6ydCwuzxNpKB0MGfv3fDCLWagNO4z0gEDUgZdujJRDpI25iBXrfR1ZqkTf/F
 hQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709778540; x=1710383340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kqf87SnXFSxj6vNXUakzL6zBZi8561tP3M4csvcxwYg=;
 b=qWpokO02wn5/FrUKv0bOsCAs+OA2MeIaJOBXNxrdm3WhV2lIxLRFKxZ+LCEFyWAeJC
 GefmysAZeo6x9C65n2Af5nrapo92UtU/qpamgPwL+19pS3EE2DACiZL2q536Gv/5ZAnJ
 YDdtbYtzBoBOXWmoqsXxLbRR+ds8+QROPYaZBhNOjS4aFOLOgdhriO24LbiiYxTpBHBg
 Ihnc3m1XvxgeN1nq96owqLrL8J/FMyvaMWciuKgJFK4AfFzENQZNgS7WSJV16pYVESIx
 FgZB1e1TS/M5G7zxRMDT1PTfToWcoltj1gr9LdLn6eyhKxC+Yc/bdwFLoC/TcBaHB62k
 bBMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULQX4Q+KqGhbrLET3hIkXAeLs6M13OsURQ32v4r0VH8kYzXJFeRkYih/jrMVqPZk+PdpcWJOKvSkro8xqhAZBJUXnJPw03fF9GbdYC/SqnZFNLElqUSAMv7SMVCg==
X-Gm-Message-State: AOJu0YwS4yZlELQAB9eF1qlar3cZSTpFcy0jbIyG0SOn2tEdt4VgLUOZ
 6GFjKklLJnfU7SMzshLXEyeUL3Oa52Hy4Qcyd9FgyHP/rxdYd079OhEt51JGl/ROxY1JCpDQ4rr
 Y3evKs4iUUZIo7cFnZxG0PJJ9fpo=
X-Google-Smtp-Source: AGHT+IHaOArQZCigyGk/n8kiqqgdi9EBg4KjK5iXqQqe4/n/afIKypQc//2/hg7+LUDjW8y4wi73GQbiNOFyXifKc4c=
X-Received: by 2002:a1f:fe07:0:b0:4ca:80c5:752e with SMTP id
 l7-20020a1ffe07000000b004ca80c5752emr6417274vki.5.1709778540146; Wed, 06 Mar
 2024 18:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20240306095722.463296-1-apatel@ventanamicro.com>
In-Reply-To: <20240306095722.463296-1-apatel@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 Mar 2024 12:28:34 +1000
Message-ID: <CAKmqyKObdjo_YVLJBzq1T_ktiW2YRMUhT47+E=3wkusnW=WCmQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V APLIC fixes
To: Anup Patel <apatel@ventanamicro.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Atish Patra <atishp@atishpatra.org>, 
 Anup Patel <anup@brainfault.org>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92f.google.com
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

On Wed, Mar 6, 2024 at 7:57=E2=80=AFPM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> Few fixes for RISC-V APLIC discovered during Linux AIA patch reviews.
>
> These patches can also be found in the apatel_aplic_fixes_v1 branch at:
> https://github.com/avpatel/qemu.git
>
> Anup Patel (2):
>   hw/intc/riscv_aplic: Fix setipnum_le write emulation for APLIC
>     MSI-mode
>   hw/intc/riscv_aplic: Fix in_clrip[x] read emulation

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aplic.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>
>

