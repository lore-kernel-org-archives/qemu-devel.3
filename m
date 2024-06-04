Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00301C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENtB-00015C-TH; Tue, 04 Jun 2024 02:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sENt9-000149-Hv; Tue, 04 Jun 2024 02:43:19 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sENt7-00079O-L2; Tue, 04 Jun 2024 02:43:19 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-80aca0fbcffso220711241.1; 
 Mon, 03 Jun 2024 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717483396; x=1718088196; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3ql2cT4nN5lj0/lXbbPlUzDIUcijp2aoILioVyJGN0=;
 b=idNQMLfBrSYcEen9BoUe+w5/OW9CjJfsFPu9D4pBF5zAFHhgpMlueLGndz6tFuVLPn
 vcCU+aPX+uBgx3bNgD+KJFCLp8JkD2Qzcg/9gz8a3p/idSKJuELxrGJF/AsOqFprMoIR
 f8jHtL7KnFhgNTOSnRK4/R/Q7NDdJXHXHkRLKhtSuDZMj856u5Qy6A/TJePNZeHHLfxJ
 LR0cA5OTFa5FHpJQPt/89QaEOD9rqz4GmfooMmV8C9zr5evFfPrWppuCrmakHlqr5iTo
 Rtxx4J5cst4xXkqBAdSOYahDs9CknfxLtCRUQ8h3nsV4WE1Me78BqYi/7m65TG+GwS8P
 7Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483396; x=1718088196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3ql2cT4nN5lj0/lXbbPlUzDIUcijp2aoILioVyJGN0=;
 b=CelAuZklZCFYPxtB1il89crLVRNWuFkmtGkB9gsSAFcKDFBUts5nzo0ZqVyF0ha/lt
 80DBY0tQ8MmuAtebSN8w1Ci35xZllaeFpeVnJ3kP0ndWEu2cdZUWCAjDaSuvC4VkY3g7
 J7KoEuQ81VYFBel7mSHjGI9uuTMTH1fVhrO/8zYLCqhpw1+/peHdYIvjXBQEAmugmicm
 a8HiaFHILqzn0j6VDQYa/C4hNzVgCnLDiKJI4VufzpVidC0A8DqrJ3qlWoE4GuCPWTRA
 xB6VbFgLX+0EZRguEvM/u230+xsXyCXBdPG3Adtm02MCzA/t03kdlRW90o4dWNEyF5NM
 8QGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOrlZyljflMMsIina949kk1aJaNGAtTrkX49nhp23NOfqB7rieJwvumxhB4wn8rJhuEbOYPFdLS8efWuj14KNIofPZuEY=
X-Gm-Message-State: AOJu0YxFGlj2fEf6BXtpX+0CQn+bQcPaZUu0r0Unul4sKHZrzjPP9Vox
 JEWflb5mhnuKcOeuP5EMidCR5ho5nbDzoRFLwWcSKHJwkjGKJ0EiCgE7GqWPbQrT4rkr6MEoUY4
 0NY/JzNko4XaowUyMgIn2x16NOC8=
X-Google-Smtp-Source: AGHT+IFioAP5C37fR4cW9FHBWcCCXZ08FWzJLTVRzMO0cGWjCqp0cCRuhJUJhieKnlP7EUHi5UZWM36wwNVDAZWbx8E=
X-Received: by 2002:a67:e355:0:b0:48b:ad6a:c7c6 with SMTP id
 ada2fe7eead31-48bc231d445mr9764622137.24.1717483395876; Mon, 03 Jun 2024
 23:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240604041445.244768-1-alvinga@andestech.com>
In-Reply-To: <20240604041445.244768-1-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 4 Jun 2024 16:42:48 +1000
Message-ID: <CAKmqyKOTqvzkukT+864qbbs8qY9td7LsqNaXE=bUjra740SKOw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] RISC-V: Modularize common match conditions for
 trigger
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Tue, Jun 4, 2024 at 2:42=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu.o=
rg> wrote:
>
> According to RISC-V Debug specification ratified version 0.13 [1]
> (also applied to version 1.0 [2] but it has not been ratified yet), the
> enabled privilege levels of the trigger is common match conditions for
> all the types of the trigger.
>
> This series modularize the code for checking the privilege levels of
> type 2/3/6 triggers by implementing functions trigger_common_match()
> and trigger_priv_match().
>
> Additional match conditions, such as CSR tcontrol and textra, can be
> further implemented into trigger_common_match() in the future.
>
> [1]: https://github.com/riscv/riscv-debug-spec/releases/tag/task_group_vo=
te
> [2]: https://github.com/riscv/riscv-debug-spec/releases/tag/1.0.0-rc1-asc=
iidoc
>
> Changes from v4:
> - Rebasing on riscv-to-apply.next
>
> Changes from v3:
> - Change this series to target Debug Spec. version 0.13
>
> Changes from v2:
> - Explicitly mention the targeting version of RISC-V Debug Spec.
>
> Changes from v1:
> - Fix typo
> - Add commit description for changing behavior of looping the triggers
>   when we check type 2 triggers.
>
> Alvin Chang (4):
>   target/riscv: Add functions for common matching conditions of trigger
>   target/riscv: Apply modularized matching conditions for breakpoint
>   target/riscv: Apply modularized matching conditions for watchpoint
>   target/riscv: Apply modularized matching conditions for icount trigger

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/debug.c | 129 ++++++++++++++++++++++++++++---------------
>  1 file changed, 85 insertions(+), 44 deletions(-)
>
> --
> 2.34.1
>
>

