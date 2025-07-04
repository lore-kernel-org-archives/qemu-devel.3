Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0057CC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 00:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXTzt-0005wN-0V; Thu, 03 Jul 2025 20:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTzn-0005tD-3p
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 20:09:39 -0400
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTzk-0000DK-Dn
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 20:09:37 -0400
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4e9a1090360so92249137.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751587773; x=1752192573; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LfY6aSTJFcCzP9CKT4O3e9dufuSBRwllzrG+7OjZQE=;
 b=dynPbIW/2RZY+gg/0IZYEuoyiMNMPW7WRx/s+Nn0goffM2YSPXnkHZLGvkMZpWbdTB
 3j1FiX4SqNZtnEI398jeDC0HazozAxilWZITO6HYPp1nzQXxndftlntH16Be2zxZNS9v
 boWMHLcdgfB4RgS5III8dmdDBH49WK5GXdhhgRmRitMP4WiNI0ZroYR3IilNh3FyNS0J
 qnCMS224EW4q7L0C5sR2vodd1+HNxk5QQinRUQRjTtmNHFAbjTZmQ1QhldaTH7Uh9m9q
 q3fktD4ooGYFddFgDLyc1quuDWiQGoFSM+gkTj4P2lRi/mz43k9y/6tQ45WLJqWEqIgI
 oMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751587773; x=1752192573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LfY6aSTJFcCzP9CKT4O3e9dufuSBRwllzrG+7OjZQE=;
 b=dinYbaPirJGae4LEVUL0y4v53c8yS8cwh35OyT9ubDg4U+s/oNrjzY6xBvLLa5k/DU
 2YQydnpLZ1ME22JzOS0hNAaL4F2MwKOUREwdZut1S73mj+NTU3WczZL5JZpxBdGropE4
 fmP9gy0Nc79M7zvhIsdCb1y1IHbwsRSkF2bjhpFydDoF0wtdZR9hVQ5R/VvBnV1uv6PV
 24b33STV+6n82whdnq1tJIrIG2L8zjNus8yBXtsTa8kY7SEHK4tvyU3Mqkpc1QZLiWsL
 z7aLGZVqq57MuyavJEDoGuZX1R/dt8Yh1xm4GnEztsJfrquJOwbpWh4R0WWkapoV2q/S
 Y01g==
X-Gm-Message-State: AOJu0YwxN5cP/im0Bpiq7xbjqzmmZRLeIJCYgFg+3bxrB+Cn8W8kaUrE
 bNS2hQ5izjByd2JM1toMksmH7IzYiwRPKuyEiPB1NlaHRjwLNC5mMvDzYxEtGm5G+qWx9YCHE+/
 DTgP0s/uNnHKxySycqFHQFXF+rgaQkU/XjQ==
X-Gm-Gg: ASbGncv4CPXJQCRWF0nnw3tYjUP130Zl59MKTfLq7f0w7UqA+THiF/EFAqKUEIiaEFO
 9v/JjhgaBm1LCOLu5pxnqyY6VjYulvbBRA8P1QWGR1QeocTcuboubDn4LcIznjXbLabSpxM2w4M
 u2Q9Vhfq/wtEd+Ob1Nb6iVMTt4377B/HkJhAs6RvVh8spoDhUrTIa85qfuMwx0UL7OaIvI63PLQ
 w==
X-Google-Smtp-Source: AGHT+IFtJeNiHTJZnWBXIoKIC81NZ2IoIME35xVTRB5JQdu/I9wV/SwMbOTBHTqFtg9Zt6CAgisbdcXL1bFnjXOYV2w=
X-Received: by 2002:a05:6102:38d0:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-4f2f193a5cfmr128654137.12.1751587773441; Thu, 03 Jul 2025
 17:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <175014178352.19565.9471325854234944512-0@git.sr.ht>
In-Reply-To: <175014178352.19565.9471325854234944512-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 10:09:07 +1000
X-Gm-Features: Ac12FXygLT8_stt8S2rxLn4y4X-3NxtyozSYc2gXDBJSy0I0ioLdBE9yQE1SYd4
Message-ID: <CAKmqyKOM8xqmqPYTOFQm7HiUQiBGRpKzWX=NjPX2b9=KEfi8LA@mail.gmail.com>
Subject: Re: [PATCH qemu v9 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
To: "~liuxu" <liuxu@nucleisys.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Tue, Jun 17, 2025 at 4:29=E2=80=AFPM ~liuxu <liuxu@git.sr.ht> wrote:
>
> Thanks for Alistair's correction on the V8 version.
>
> Now Zclsd has been disabled for the "max" CPU as C and F are already
> enabled.
>
> lxx (1):
>   target/riscv: Add Zilsd and Zclsd extension support

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                        |   4 +
>  target/riscv/cpu_cfg_fields.h.inc         |   2 +
>  target/riscv/insn16.decode                |   8 ++
>  target/riscv/insn32.decode                |  12 ++-
>  target/riscv/insn_trans/trans_zilsd.c.inc | 112 ++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c                |  32 +++++++
>  target/riscv/translate.c                  |   1 +
>  7 files changed, 169 insertions(+), 2 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_zilsd.c.inc
>
> --
> 2.45.3

