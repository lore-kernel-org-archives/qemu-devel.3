Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DF8C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 06:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcel1-00089w-Sn; Tue, 28 Jan 2025 01:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcekz-00089W-L9; Tue, 28 Jan 2025 01:07:29 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tceky-0000Xe-7M; Tue, 28 Jan 2025 01:07:29 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4afdfd3124dso1361195137.2; 
 Mon, 27 Jan 2025 22:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738044446; x=1738649246; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JLOM9yNigSIhn3umV/qEMOjUB2vhbHjIdZMCdFsO8E=;
 b=QSn+F7MJOxX3QzML56hiWjfpqpW4w1aDBIegqh9tzQq1bQU5vSA/CvDMBpxbx30FGK
 gdcMDIQjXmBRjLnNUzCCl9DHfyJBIvltQFup//8HT5PhYVePDHfRqLRrjZfIcn0GL1D1
 IbC8hFSFplsa+4Nxwg4jKtfhthryKIvCiT2AGdHZpxHPOwtTRITV/3dOpq4FTy91RcAF
 K4+HUD+Z9wC/fpQY2eAi6cqarQfKS4MVXH5gWgop4mDP4cEaC8OxOJZYRMjpK4ZIJ6wi
 AEsYGeuhVI3H+Nf69jlPc6PNgCCe2ULQPw/3RjqF2WV3CCLrAWkwTZRL5hj7NVM9e/DT
 ENFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738044446; x=1738649246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JLOM9yNigSIhn3umV/qEMOjUB2vhbHjIdZMCdFsO8E=;
 b=MEM2i5TTh76bmZWRHHj+jf4zlmbYOzUWm5QvEOoR3p+qmZPZtTK/Jd9G1wAiB8XrYp
 EVgNDp+4UiL8YesgAJmbdX8DEOrvn7o8wAy+JS7ij4sY8QVQ/IZOId0P5C30ZMB2ZN+Z
 Vd9X7UJ6xEXLcsqyBu0uqDHCGQqnqTB1zW3+VOjN9zhzYKakIAlzcs47GtwUeTsLYZn8
 xX7VnvJmTbD0tC+A+XlJ14NLsF2ACpwUdA5W7tCATlBrgZaE9/bnbnxlyF3D8crquS+j
 6jGxvr8JqakIoREezOUpzDIw62eNdxCdUtwlrQTgVhssMqxnTnT/z0Qh+Z59uYGNZV7y
 LQuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbLxPTCbdCzE/hXfKGIK22z8Rtlw42kqjwETPZKGpE6+5OOmY6gafXCzZ0ris/Px1qbRc67LNaG9SB@nongnu.org
X-Gm-Message-State: AOJu0Yyl3VyyPiZwu2qme0CmJGCYwf9xsQbgLCx2JNbz7shBAkLFzkTP
 xqFH5UEYiA7m2ItNgIxMlxQRZbKSgCmOfPbwB97LRunEcjlTXYJTfcHjid+HVz1E7SOh7XjxwFz
 S1VFCrFHNSpnm75XbK1Oo/ymKPR8=
X-Gm-Gg: ASbGnctgsC1uj4Vo3eDpOPhBsADENHuQmLQTfodlspFfQlQ5HS8Y5R7tqbp0JK6QG6j
 U/ZIH7mGHI7I6tL8NUfTrXpdn3Wl7J7ZOj1NVfPKnYYjN1/gQGdnDHWeQutwBLStlH9n9ja8P/W
 aQRcmUnXvj1TYmc/QXq4UqkvJgbQ==
X-Google-Smtp-Source: AGHT+IGwNPM7UGDLxNOsxJjEiSqQeMgiUprUsFuyFZqd7/JiQ+svQNZAXY/BYz+eRz4d2fJWKmlrpfxeNEtgr1EgVuo=
X-Received: by 2002:a05:6102:26d0:b0:4b2:cca8:88d0 with SMTP id
 ada2fe7eead31-4b690b8780amr35393484137.1.1738044446626; Mon, 27 Jan 2025
 22:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20250128060546.1374394-1-alistair.francis@wdc.com>
In-Reply-To: <20250128060546.1374394-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jan 2025 16:07:00 +1000
X-Gm-Features: AWEUYZmjkJkY01fLiho-nhURR7i9CMBIe0uYFqIxRHzCkv5KfpIbSJemAb0irUg
Message-ID: <CAKmqyKOWY-im1Kt_mCN5+o8c9Fanqrt4_+j6DyEi6h6zN1u0ZQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Bin Meng from RISC-V maintainers
To: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, philmd@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jan 28, 2025 at 4:05=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Bin Meng has been a long time contributor and maintainer for QEMU RISC-V
> and has been very beneficial to the RISC-V ecosystem.
>
> Unfortunately his email has started to bounce so this patch is removing
> them from MAINTAINERS. If in the future Bin Meng wants to return we will
> happily re-add them.
>
> Note that I'm not removing Bin Meng as a "SD (Secure Card)" maintainer.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

+ bmeng.cn@gmail.com to keep you in the loop

Alistair

