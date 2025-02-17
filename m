Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F62C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 00:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjpDr-0000Gj-CJ; Sun, 16 Feb 2025 19:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjpDp-0000Ga-QS
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 19:42:53 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tjpDo-0005Pf-71
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 19:42:53 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-52099627b5aso1380403e0c.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 16:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739752971; x=1740357771; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vT55sVX5ZLx6CH/Mf+QtMFKYunWnY36uNJALCzmguLA=;
 b=nrvwvDU6arGJ/tLUkUzWQMrZxj6BbvPY2Jr222ViDl4nWhw2HFMz8uADBkdKXKD65K
 puWMhxiKy+AVIJIUnP08fNPa5q2+RUqU/NPEa7Ku/PXkV7ujD6YPuayEMfNxq3Q61/kO
 Rk4waEv1tSpgSbximqASZKt+tUjAPQ4VdZAD1y2Wh2AJfdvXNCKTGIzO0MkWbY/5pqnj
 SdurbKwjTcoN1cul88wU9Rd88+2WRZ6xK8K1hs9aY8UYXjWr7uzVmZrXDxgqBxsfOsvt
 51/xo9GhJzkQl05bYX4oWFxaMxDC/89r0K2EB7Ua8EAcDUnKHV5AStfAKADs9W0UcUDk
 WrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739752971; x=1740357771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vT55sVX5ZLx6CH/Mf+QtMFKYunWnY36uNJALCzmguLA=;
 b=rABT8IrdWa+2dS/MrFUWJmB8tgv6uH+tMCebl8yXIJuip+3f8iEtUyxtmWoBxaA7ym
 42B8TYlv5ArICb02cL7+0La/TtbtoSBkiR3IKUK5/3bP2D6y2Ut0NJ2OlZ4+oxfBRaqO
 y5JdgMJV/wqSW2B3Y2xIYXfEPY9seSv8pDYYkASR0XhF3IL/2Lp1gvkDCWAKZB5/DcNB
 HSF90SZIVH5aMq1rMFkTEDNtWBpD6u+eJMXgT9lbElTJ6dOzE4B+iCuYJBR+Iwgm9A6X
 u4z5VLcFUskblF+z4O4lhmg6lmosTbVVyLyKGMzGz52XEoihtV1F7jMLkmddiyEMb0cO
 Nhtw==
X-Gm-Message-State: AOJu0YxmI9CNSesBl8eMLhv/K7GMFh+G2bRV1OHap9tp8+zJ23tkOWVj
 UcEbY074ZyIRcXOtBsuMm029qB07FyzckpEilHkJ1XaefGrWSy8CfZ37TrtZpwNwsZjORcDV9sh
 I6GH6NfKN6jsjVBjWF2/dkdoSSYw=
X-Gm-Gg: ASbGncu4uNzfz9S01QRUL3LjGT8ImG3ik9yvZS2MdSHo6dtuXs78l+plYrRFb5kOLaf
 ecYIqYx9ZC6WCA8xgiIjbc6YH0YeIps3tEqyk3XhPXtnl0dYofshfbYylks4O6jL09y22gFx8Kw
 Oiib+YGSB2ucwi+8Sgpqbcgr60BQ==
X-Google-Smtp-Source: AGHT+IEAhzK8jRV5H+JubGpCdxnc7lpFW3ovJzAHiAgpsn+W8cjumyFuXDtTL5AVx+tUgisSzD21Rhxej9WIs1W+oi8=
X-Received: by 2002:ac5:c85b:0:b0:520:abfc:4f10 with SMTP id
 71dfb90a1353d-520abfc5121mr1330210e0c.3.1739752970692; Sun, 16 Feb 2025
 16:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20250216024709.2624325-1-richard.henderson@linaro.org>
 <20250216024709.2624325-3-richard.henderson@linaro.org>
In-Reply-To: <20250216024709.2624325-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Feb 2025 10:42:24 +1000
X-Gm-Features: AWEUYZm2SAUwn3gbXh6ePJMFe6mo7P_joz8tOM7gDFiYmpntRv7ktdMjlCAE7jk
Message-ID: <CAKmqyKNsKAtMY6VFnTFZN7kkH31x-r3HXrNYxTXQTHrNnnDFGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tcg: Remove TCG_TARGET_HAS_{br, set}cond2 from riscv
 and loongarch64
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Sun, Feb 16, 2025 at 12:49=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These defines never should have been added as they were
> never used.  Only 32-bit hosts may have these opcodes and
> they have them unconditionally.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/loongarch64/tcg-target-has.h | 2 --
>  tcg/riscv/tcg-target-has.h       | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-targe=
t-has.h
> index ac88522eef..188b00799f 100644
> --- a/tcg/loongarch64/tcg-target-has.h
> +++ b/tcg/loongarch64/tcg-target-has.h
> @@ -37,8 +37,6 @@
>  #define TCG_TARGET_HAS_clz_i32          1
>  #define TCG_TARGET_HAS_ctz_i32          1
>  #define TCG_TARGET_HAS_ctpop_i32        0
> -#define TCG_TARGET_HAS_brcond2          0
> -#define TCG_TARGET_HAS_setcond2         0
>  #define TCG_TARGET_HAS_qemu_st8_i32     0
>
>  /* 64-bit operations */
> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index f35f9b31f5..98081084f2 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -37,8 +37,6 @@
>  #define TCG_TARGET_HAS_clz_i32          (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_ctz_i32          (cpuinfo & CPUINFO_ZBB)
>  #define TCG_TARGET_HAS_ctpop_i32        (cpuinfo & CPUINFO_ZBB)
> -#define TCG_TARGET_HAS_brcond2          1
> -#define TCG_TARGET_HAS_setcond2         1
>  #define TCG_TARGET_HAS_qemu_st8_i32     0
>
>  #define TCG_TARGET_HAS_negsetcond_i64   1
> --
> 2.43.0
>
>

