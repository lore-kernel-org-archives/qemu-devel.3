Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9602CCCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 03:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEgGj-0002NT-Gz; Thu, 30 Oct 2025 23:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEgGd-0002NA-Oi
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:57:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEgGY-00045X-Qe
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 23:57:34 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63e0abe71a1so3658302a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 20:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761883043; x=1762487843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zy3s0O+9VQSfO5YWBSuQfekLg7QXQLE9qEziOWGD6B4=;
 b=UMw9UBm2Kq3TrcOarM+2Ey2upx9L8WeQej5Qpze1Nb7Nrwp1J1YvE2k7Hr7vobcKBh
 utxqo7UtFGTE0rElUxfgsUa9dhuMtHV9pMDAH4KUyP0bEEykxLQhGr9qCWkF0h25DGVx
 Gt4/CyyiegOP9TqD2n7Jo1ddNiGUgFWzjaugD8RLNIMTmWvqYaQ3uv5f6cbaqb8vBVcG
 PRPRMC4ulpXSF4cL/vsHwjXqFE9ExlGBqSXYmNVJ3OY/9wsUX5xeE/ORt1QKSjrVosgS
 glROyMrV2QXI7hNEvzcmrb9JgrpjV2gaVASK/budKjptWjyRg4SM/hMYhkIx+D+scNs6
 u1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761883043; x=1762487843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zy3s0O+9VQSfO5YWBSuQfekLg7QXQLE9qEziOWGD6B4=;
 b=ND8lwvFninU1YYfGqTR6g5bqr38r23N6vwIRdrqeiWPiFKz5CyuS/C5p4XC4+4TKbR
 yG3eEkTzvKRcmMOu6dLdN9nqLanlhBIWJACF0znWN5P/RvneSJ7qtjeCjuig3YMDcWJn
 jKe4vzD1U4Yw+ROY7W3o4bbTMEb5UYhBWXGcXVkFWiJ1ErMWsL8Iv7tb52YH1cn9ZU/E
 ygesy483Y2eotgiXu9ZHgtWfK53HXzo4kXXwbCOguxfD5DUh2Fb7xvxm8YweGeaFJMgv
 xhvajmlTXLCpouISIOsYjSL2XFpWpgV2WpqxHDJDlPV41fwE3SRsH/OXv+f3MdaOei9U
 KAzw==
X-Gm-Message-State: AOJu0Yy1j+CIt8hWdnaorscN4CbFnmrMXUXm7kRIV2jQIMy34lkreU+R
 Ffy5bwjM88IZ0uu3cMUAJI7DibrwRO/voYFbwFkGA7Z53LjXXB78SlOUa8Ha7BTjVeqap0DgXKj
 bTEK+QMKRQwV1uJmX5miKqymhF15IMEQ77w==
X-Gm-Gg: ASbGncu4nOskxUQ2BN71sbWu7JpBhh652WVBi8zb+1W2lqnkXXE4SPwP/4K8O5oUp0c
 0+oPXvk93pKPM3oUvZpWQhPTARhX2kjwOFrIff7pPVpmmGyeM3m3WeiZmS56iBRDVv7J5fowlef
 Xid6EY7sOxHNXc8iJp7Q2Yu0KFgPkqHlMbNIv+3EGeaxqZ0jv1eej59ZsVsB+fmsRPKFXSaqlb4
 wA8PVc9D6rDRXpxrux22VIt1p7nwGCKtABCvPzf5pcQp5HXIiQll1TE4mLRSyQ/NcP4Uuu5/c/I
 E/20ibSC0Nc3nKnAETqj2YN6Qw==
X-Google-Smtp-Source: AGHT+IGFrcOlp5nJJ7lpcyP3/SjKtSZlH0KHMLVVq1N6vmtcQ1eRa7A4Xr7aBnEI9wUCsU7qCVCZ9p5q35vrKEVoRUY=
X-Received: by 2002:a05:6402:2711:b0:63c:33f8:f05e with SMTP id
 4fb4d7f45d1cf-64077018349mr1384557a12.22.1761883043203; Thu, 30 Oct 2025
 20:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251028084622.1177574-1-dbarboza@ventanamicro.com>
In-Reply-To: <20251028084622.1177574-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 13:56:56 +1000
X-Gm-Features: AWmQ_bmdy5wh079yPhyjyG68W8N8RdQR_osSpNc9bvrVbPLm4VxdJfuUKrGAdCc
Message-ID: <CAKmqyKNjW0ME9DuY=ADWa_WGs9Ak7NFjpAMCqbYfs6Ap1xtLRA@mail.gmail.com>
Subject: Re: [PATCH] docs/specs/riscv-aia.rst: add 'riscv-aia' accel prop info
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, Oct 28, 2025 at 6:48=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Add a small section talking about the 'riscv-aia' KVM setting we
> implement and how it affects the provisioning of the IMSIC s-mode
> in-kernel controller.
>
> While we're at it, fix the formatting of the AIA bullet list.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  docs/specs/riscv-aia.rst | 43 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/docs/specs/riscv-aia.rst b/docs/specs/riscv-aia.rst
> index 8097e2f897..f3c6ab7fcb 100644
> --- a/docs/specs/riscv-aia.rst
> +++ b/docs/specs/riscv-aia.rst
> @@ -8,10 +8,8 @@ RISC-V machine for TCG and KVM accelerators.
>
>  The support consists of two main modes:
>
> -- "aia=3Daplic": adds one or more APLIC (Advanced Platform Level Interru=
pt Controller)
> -  devices
> -- "aia=3Daplic-imsic": adds one or more APLIC device and an IMSIC (Incom=
ing MSI
> -   Controller) device for each CPU
> +- *aia=3Daplic*: adds one or more APLIC (Advanced Platform Level Interru=
pt Controller) devices
> +- *aia=3Daplic-imsic*: adds one or more APLIC device and an IMSIC (Incom=
ing MSI Controller) device for each CPU
>
>  From an user standpoint, these modes will behave the same regardless of =
the accelerator
>  used.  From a developer standpoint the accelerator settings will change =
what it being
> @@ -81,3 +79,40 @@ we will emulate in userspace:
>       - n/a
>       - emul
>       - in-kernel
> +
> +
> +KVM accel option 'riscv-aia'
> +----------------------------
> +
> +The KVM accelerator property 'riscv-aia' interacts with the "aia=3Daplic=
-imsic"
> +to determine how the host KVM module will provide the in-kernel IMSIC s-=
mode
> +controller.  The 'kernel-irqchip' setting has no impact in 'riscv-aia' g=
iven
> +that any available 'kernel-irqchip' setting will always have an in-kerne=
l
> +IMSIC s-mode.  'riscv-aia' has no impact in APLIC m-mode/s-mode and
> +IMSIC m-mode settings.
> +
> +
> +.. list-table:: How 'riscv-aia' changes in-kernel IMSIC s-mode provision=
ing
> +   :widths: 25 25 25 25
> +   :header-rows: 1
> +
> +   * - Accel
> +     - KVM riscv-aia
> +     - AIA type
> +     - IMSIC s-mode
> +   * - kvm
> +     - none
> +     - aplic-imsic
> +     - in-kernel, default to 'auto'
> +   * - kvm
> +     - auto
> +     - aplic-imsic
> +     - in-kernel, hwaccel if available, emul otherwise
> +   * - kvm
> +     - hwaccel
> +     - aplic-imsic
> +     - in-kernel, use IMSIC controller from guest hardware
> +   * - kvm
> +     - emul
> +     - aplic-imsic
> +     - in-kernel, IMSIC is emulated by KVM
> --
> 2.51.0
>
>

