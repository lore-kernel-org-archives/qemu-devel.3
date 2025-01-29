Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23938C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwW8-0006Kp-Ac; Tue, 28 Jan 2025 20:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwW6-0006KC-Qb; Tue, 28 Jan 2025 20:05:18 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwW5-0005uS-9a; Tue, 28 Jan 2025 20:05:18 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-85bc7d126b2so2842423241.1; 
 Tue, 28 Jan 2025 17:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738112715; x=1738717515; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWjPYn55C2+fkdad5womY7nkq8+qoDutzXQw4gGhr4k=;
 b=egRbA1xiqeeJYjtESwHwaOqc01GkhcUxlJTgRJmlNmOHwhXGtIhv3l7N25NXKl+bsy
 UhEAfIRzczdkFhWtu8tF1GmC0oeBj5GlUWx8x9SGBFwrr2sFJfsKyiOkVfI22yPhiIo1
 y3gi7Ca01HdW296kqDQE+1A+Hoxf3grwis/5lQuaaKpd73abIz9Sk23iru8nSW8LD4Y3
 /8fJWoCV1EhLooA0s0k4663w6qF8Ez9r6xN2VpLWxi3DUfOGGHe6Ci3RwldevLpwPg1Z
 o1+gAkCwApaiyjf0vRaI19NtjmZsD+/poA8z6BA6Qp56PgiPQU73cbuyjwvaR5DjPFhQ
 b1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738112715; x=1738717515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWjPYn55C2+fkdad5womY7nkq8+qoDutzXQw4gGhr4k=;
 b=UTRHQzCM+GU/93qxq9kx43qr8u8QA0KeaMudYjOmlun90iG8kuynqWhR5ztaI4kLh7
 ZJzsgWnfC2yPBX3CXitggsID3W37ko+18lz1gHALWvpvPbGEKugKbMz72EC2830ql2Mi
 +J4GlfkNiTTXaoQwIOIZrHhsqsTWDCiSALssdBjZN61nvF97FkQ0nt/AWTCY6nWYLvS7
 +sMyOfVU6olHaMKXLuDez1rzSYGdAc1e1d10Jvhwd6U6Nc9+N6XpPIIpGEMtLkcqOuQX
 E8GfD9OzH3cRaIzBHI7qSGQwN5++Rh9jSrFXqn0cfjC4wxjhWRliX/arkrQJfCGWsQil
 uR9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhYWbQ7XeB0lDq3aF9F307RlQbqu3paV4r5M+ttLiq2I/kRoCODl1iz64gaO8t4G8NqfCri5hhq1Lg@nongnu.org
X-Gm-Message-State: AOJu0YyqYqi+gjLNIG5zJcmnj08mZ35SGi3UUJURHvTtYpHgtF2gsoaR
 OGJx32w0V9LIVqCbTTeMJsDaUS7NM7RtpNnjJRo82Em59diLk2cRgAwM/xCW5D7L2Gn+zZJVxYb
 rUUa9ZAqLDpodO7IlzNXI/8LyHWM=
X-Gm-Gg: ASbGncvnero9qHG5v60yzzYYTMSMRVgVmljPDCdEsbPEd6ZQuagdy8z9O4ICR7aQ3o4
 zLV5YE8lAIx4p7nT++rEMa/F3CwqTk43vztUj2IeN+yUjdWAnxAtxhyli1DwEFLFc6k7AdZVuKd
 l2jn6Y2H/R1a3S01yVpUgQv31/Sg==
X-Google-Smtp-Source: AGHT+IFr5+ABJL4g1vHof1xe6rdmmmbnMNettoA5kx+M8FL5n5QN7GsItKdpWOy4P5AXGvFX0pzs8JvBp1fOkkR8HCE=
X-Received: by 2002:a05:6122:348a:b0:51e:20de:f9f2 with SMTP id
 71dfb90a1353d-51e9e3f6a45mr1893118e0c.6.1738112715655; Tue, 28 Jan 2025
 17:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:04:49 +1000
X-Gm-Features: AWEUYZk4wBghpvU2yL5wJweoUu2t3nsmZMSc5DMDJiAlw83jkcmL-Lvew8ACNVM
Message-ID: <CAKmqyKPq1eqGpzZJLK2EsgFyDO4Q1w3jEFcvnu5Tuy7Cb81k4w@mail.gmail.com>
Subject: Re: [PATCH 0/5] target/riscv: Coverity fixes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Wed, Jan 22, 2025 at 4:49=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> This series contains Coverity fixes for issues found in the latest
> RISC-V pull made yesterday.
>
> Coverity CIDs being resolved: 1590355, 1590356, 1590357, 1590358 and
> 1590359.
>
> Patches based on master.
>
>
> Daniel Henrique Barboza (5):
>   target/riscv/csr.c: fix deadcode in rmw_xireg()
>   target/riscv/csr.c: fix 'ret' deadcode in rmw_xireg()
>   target/riscv/csr.c: fix deadcode in rmw_xiregi()
>   target/riscv/csr.c: fix deadcode in aia_smode32()
>   target/riscv/cpu_helper.c: fix bad_shift in riscv_cpu_interrupt()

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_helper.c |  4 +++-
>  target/riscv/csr.c        | 24 +++---------------------
>  2 files changed, 6 insertions(+), 22 deletions(-)
>
> --
> 2.47.1
>
>

