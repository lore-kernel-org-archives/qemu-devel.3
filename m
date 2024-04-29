Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HW8-000799-GX; Sun, 28 Apr 2024 23:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HW6-00076F-EM; Sun, 28 Apr 2024 23:17:22 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1HVu-0002kB-PJ; Sun, 28 Apr 2024 23:17:22 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7efa7296beeso1068481241.3; 
 Sun, 28 Apr 2024 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714360624; x=1714965424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhixbkRjFCSkFAjX1DDJzZXc6rLVdQVHsbvPH6Vbi0E=;
 b=kOnxMEor/F1jA/x2MuF/hQiFHjDspRwjgd5DOtufgD0SLMp3lzFCfQHewXlC5+YFTb
 IHDpFOrPNICjPjnclJ6CfnVIUzVylDrCr6QBB1C7EhQCjFH1ghg8q7v4mpRqKbmyb9aA
 mVgTCnvNd4Iiu8pNbr1/ZUi+LVaYguJ2c4ByHThsMxSJkn2ERa+g0e+JrFEAjKOh7VzS
 azJDzwedTTgiqxtBEF0o/W57FyYJQUZiaR2r+M8fFE+U5APlCmDeEJMVXZJg32LDPK4x
 ewfi/kAyJ7OYBGyAN5qwpUGveCKgJSKHiG/OK1v/NCpwCFCidQHXM4meSu1p7G3CXCnd
 G61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714360624; x=1714965424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhixbkRjFCSkFAjX1DDJzZXc6rLVdQVHsbvPH6Vbi0E=;
 b=MoabYpvw9BoT7c5GqoPDUG4wjRpxe4xqXGIeISDiXU9dupLhHdbDyAGdRGk8Vr5eG9
 GKP/Q7j0LtQ2O3KmNbSph4MVEtQIAkU0tXqJOelJlkxkYvqPJbywGU2HEi5m/C5zSeS5
 4xriYMtTtH30krIySvjWCmtrNFa526+8rhYKict/UBEaTUk4IxBnjfHLDghd7E3fV5JJ
 VoPrIKRImu3v2GE+UxKhVKv2dFbJcXJ8brNWSzasRv5CC3rvBpNWx1tat5Km7Se5lRmR
 vbf8i+gP8zMpSV3RgEhLv+gg15GkpaNdqHpKdIhhCTW51or3uRZyzCy9DrnI35FMfIW8
 +J2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXondh6o4OZA2+qzL7jAHrtGMEVmYMkvQ66CPLRebevQ29e2rinkirF0EGTmBm6y+E3YdfwQv7noyayWFyDA/6sX8k7K74=
X-Gm-Message-State: AOJu0YyQ4zrIhSaInteo25vTi/FHfZfa/XaJ8UyTrL+Jril/v/Xixo/L
 QLOA32/OMjhaDsCYilVc7tQM99+GiKGZOKro9x/6BbYRy/iQ9Sc1v03x+puOE3mZXmBQk3PTDrF
 wBVu65vtCfHRs5OxJbW6SiljD5lI=
X-Google-Smtp-Source: AGHT+IHQd1VTpP7pWxn2ZRbBvWz9uLHwyN7gyi8k8YYsUh2qJSKdGhq/JrvbzJxycKSksmjef+QkrnnLAumyLdAdGFw=
X-Received: by 2002:a05:6122:459d:b0:4c8:e834:6cf2 with SMTP id
 de29-20020a056122459d00b004c8e8346cf2mr8832150vkb.3.1714360624171; Sun, 28
 Apr 2024 20:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:16:38 +1000
Message-ID: <CAKmqyKNjNfCcLQUzOxKOxswC4m7vZ1n1nVPgEuRaZVZJqt+ynA@mail.gmail.com>
Subject: Re: [PATCH for-9.1 v3 0/2] target/riscv: set tval in breakpoints
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Apr 17, 2024 at 9:05=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This new version has a change suggested by Richard in v2. No other
> changes made.
>
> Changes from v2:
> - patch 2:
>   - use tcg_constant_tl() instead of loading a temp and doing a
>     movi_tl()
> - v2 link: https://lore.kernel.org/qemu-riscv/20240416194132.1843699-1-db=
arboza@ventanamicro.com/
>
>
> Daniel Henrique Barboza (2):
>   target/riscv/debug: set tval=3Dpc in breakpoint exceptions
>   trans_privileged.c.inc: set (m|s)tval on ebreak breakpoint

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_helper.c                      | 1 +
>  target/riscv/debug.c                           | 3 +++
>  target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
>  3 files changed, 6 insertions(+)
>
> --
> 2.44.0
>
>

