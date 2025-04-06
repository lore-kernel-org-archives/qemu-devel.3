Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52355C3601E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 23:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ZUM-0001ud-GK; Sun, 06 Apr 2025 19:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZUC-0001so-Ep; Sun, 06 Apr 2025 19:33:09 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZU9-0003yA-Id; Sun, 06 Apr 2025 19:33:07 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86fea8329cdso3522161241.1; 
 Sun, 06 Apr 2025 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743982383; x=1744587183; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEHpk+uwUJKXYrPGSL2apLgeD0u+rgmq8Nrxew6SfVM=;
 b=MPeoz/e89X02Lp3V7YfdT8jDa9+URUSKNs9k0QkxUxojI3IBt6LazmJA+duCeEmR3s
 7YKMT38yzcEJRYgcT+tidjhyZV+aNKBRDrqFxvfYfiIrm3wAsxIFQm3KBxVIsRAYwIbB
 rcR8zHGtihBlqgbwCups+3TmN+VsQNY8UAs7FnpglxeuSrFLXh0FKeOmZMkkzw3X0ozB
 BlgyZQlgeUbUp1z66rF5aymySd42DXMZiEy6pTXtoVdSjU1Szhn2Q1RIfhDyKjVKK5mJ
 OTgRUdO5YgT06y5o32ueUJziT9svy8BcRa56L6fY+yNJ8v++0nNG546YYGd1+48FUEz1
 BEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743982383; x=1744587183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xEHpk+uwUJKXYrPGSL2apLgeD0u+rgmq8Nrxew6SfVM=;
 b=dp9i6A0n2YvfC5HynKADsk6IFHrlIKU29ZPn9u1KSjHZEDJ9lgxhR8+TbkC1ys4xdm
 S+TCDVtqUrgbSrDaoJQmpeGw5COjyoY2LNe3I92vVKCGHn5pS9u20gS7/dDC+kjQsTeE
 Hs/Q2odgtwwcflwNKIQGXkv5xrswoQHp88Vtd7pQTa0XZJV59h3wmuULOdKzslAjbScd
 GKy+XtfLSXzvOO/NNnSiqEZTfrtED83sC0JPC9ivp0fGH2/l56PIDPS8bAPybtC4VNYz
 OftOo0JI2DZm2IK4ReHcDxTWTOY51mRKQpS2VbTbqUbCPBBkxe6GelwgUki1V6ZdOEaL
 cE3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdHEvN5vVR3SKxND3M6DBqb0UL1u9I3V8bL84U1mTHUmujaWgZkHXEBKApb/PAW8LErar1Ns6mJrfM@nongnu.org
X-Gm-Message-State: AOJu0YzZ9J9rks17eJrC8igLsgO7ynZO3N5pOzDu/Cj8iZ9Q9TSeS/vp
 Z1aQSt5Xl5XZPAYQcb9jqpj1S+gaUdHfu9kqG7O6lvZrdFNHyL46LigSV4YgW0m9IvEgK/Gc/+s
 ZkF9ObMssfh2S9EDHrKHoTEvgrIM=
X-Gm-Gg: ASbGncs3oRFsD1imOF8Gr5Cga5bgZ9bXw4oJg+dQJzZvAgV5qw6ujUAQwh7o0/J6dQr
 gF43VXDVDp7mD4EDuQ9L9YBSoAv5GUCvFbW5qN+2el1D7qA7GZyL0fKkIztwe2fbXi1TkqldwPc
 QKtYZ5EeYSCKyBc/9UDtP1KQMdGDwjuYUpYeSA421sb0fndVj5n0XkdRpd
X-Google-Smtp-Source: AGHT+IHJiARim7fINCtwBz9h8txsxLL+q3WRAPZEFzKCidpYp1PyfVbUvHQRadmGbEKB634W0cOpGVeY/TIzoysyNDc=
X-Received: by 2002:a05:6102:5719:b0:4bb:9b46:3f71 with SMTP id
 ada2fe7eead31-4c863687728mr4408705137.8.1743982383482; Sun, 06 Apr 2025
 16:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250404122858.241598-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250404122858.241598-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Apr 2025 09:32:37 +1000
X-Gm-Features: ATxdqUHbqIJL5xEvbODzO9mtx81KNc3ze_GThkmw4kO4AO-_nm98CsdLsvO3NXI
Message-ID: <CAKmqyKNMk1bEEPXsj-bQ76mE5T0k9DU0MF2dmTTuWb3rvfekzA@mail.gmail.com>
Subject: Re: [PATCH for-10.0] docs: deprecate RISC-V default machine option
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Fri, Apr 4, 2025 at 10:30=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> made it default for qemu-system-riscv32/64. It was the first RISC-V
> machine added in QEMU so setting it as default was sensible.
>
> Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
> default machine is not intuitive. For example, [1] is a bug that was
> opened with the 'virt' board in mind, but given that the user didn't
> pass a '-machine' option, the user was using 'spike' without knowing.
>
> Being explicit in the command line is desirable when we have a handful
> of boards available, so deprecate the default machine setting from
> RISC-V.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  docs/about/deprecated.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 76291fdfd6..0f41a99c67 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -304,6 +304,23 @@ online to check that this board did not completely b=
itrot yet). It is
>  recommended to use another MIPS machine for future MIPS code development
>  instead.
>
> +RISC-V default machine option (since 10.0)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +RISC-V defines ``spike`` as the default machine if no machine option is
> +given in the command line.  This happens because ``spike`` is the first
> +RISC-V machine implemented in QEMU and setting it as default was
> +convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
> +and having ``spike`` as a default is no longer justified.  This default
> +will also promote situations where users think they're running ``virt``
> +(the most used RISC-V machine type in 10.0) when in fact they're
> +running ``spike``.
> +
> +Removing the default machine option forces users to always set the machi=
ne
> +they want to use and avoids confusion.  Existing users of the ``spike``
> +machine must ensure that they're setting the ``spike`` machine in the
> +command line (``-M spike``).
> +
>
>  Backend options
>  ---------------
> --
> 2.49.0
>
>

