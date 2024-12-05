Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B2E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJBya-0003Hg-H5; Thu, 05 Dec 2024 08:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJBwU-0001Im-5J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:55 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJBwQ-0005NW-8o
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:53 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d0d71d7f00so1371388a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733405434; x=1734010234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LEt1F95l1Us7KBU4t29rC1lul+MBHa5FhSRLBrdDVsQ=;
 b=NCWznTURl88cnctDUWie5UdXP2gj3rgfDsaRg+tFwScVKIcP4l0Zxp45ExgORPGjUY
 jSmidKJ2ekDbFpXAbLxv5X00Q4H5XFJdp518KHpW67uR5++6AVVnPlWug4dFgVzhOOiX
 iXfoASWU40Fmdx1W20f9kReDWHiNjMicmGBTnKelcWsaj4KBNLFzRmlrYYMt0DQf/X1C
 9kMj97f4ZpdhryzdjTJNPxPMo6zYGZintiOPQ+QFRw5+ZMBPBohrhaffPk36/2kSIQXs
 fyX4hXaEkIkZw/rcB2rltdxLt/54RiaUEjvvirIxlYS4MvTzSbjFCr0SU5i1Thb2Z33p
 TzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405434; x=1734010234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LEt1F95l1Us7KBU4t29rC1lul+MBHa5FhSRLBrdDVsQ=;
 b=G1h6Eqq1XdyhbSHgEUMGjaVE4AABq9eWyNNGTTaaRzXJwUh5F+yfVwRI3gqiNWvqoB
 2b9vonI5r3SgHGRtWybh9fBz0Sin4evJFHyy0TiNF615wEibXy0UliWGGILbjppUfrgx
 eG6NCwR+0LyEvjH0Cm/KjcZvToo7BRgv2fcg3tZ1QxRO4aRAD8i0/wpRaSd5ebFKZfOO
 HsklX0GjBUSfer6ZY0DWq14SMGfUaH7vVeO+bJHFEDC3X4ydc17xfIYozMdmXlYpFm9G
 RiuYoFvsQg2Nfc7XOzDf4KkPH47k2f8OJH1yr9Ldw4yDPgaXgECZgcc3qsUa1EdrRaTi
 DJFw==
X-Gm-Message-State: AOJu0YzopjtT2AjeQqpbNkqpZZQIir6f6L9AXPk+djmzBUI5F/iEcDVF
 3rRORz9JF3to11U0PlEcWuN2anZxQLPuE0OlyTtRosmhZdoS+TgruTRLtpZNfe5BdLy/djTTzwC
 zsq4oRUEl5B6HqDGS5G7s7Hs4AsJsrhWqc8sFjAh5iAl9lQ+y
X-Gm-Gg: ASbGncuNufbCcFl38t7uPG3DSBx/yrcqt6t8tlNhXpDsEuoRyc74LZ87tpWhCbutGF3
 F/Pmw67lIsM8QUWsr113qgwjVLDd0lgcZ
X-Google-Smtp-Source: AGHT+IGchkZZKVKuPE6R1HvGw5rqazaTU9Or/iJ0r7Bu+G9CuIXqRcbRISlNLgHaZRXJOOAmjiX1iNqZP7iAOeLlIJc=
X-Received: by 2002:a05:6402:3229:b0:5d2:8f70:75f6 with SMTP id
 4fb4d7f45d1cf-5d28f707781mr1308800a12.30.1733405434152; Thu, 05 Dec 2024
 05:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-3-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 13:30:23 +0000
Message-ID: <CAFEAcA85h3uw1Z40LSKYAJ2FXqifLw2BzYD95krcGYU=PKJVQA@mail.gmail.com>
Subject: Re: [PATCH 02/11] softfloat: Inline pickNaNMulAdd
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 3 Dec 2024 at 20:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Inline pickNaNMulAdd into its only caller.  This makes
> one assert redundant with the immediately preceding IF.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-parts.c.inc      | 35 +++++++++++++++++++++-
>  fpu/softfloat-specialize.c.inc | 54 ----------------------------------
>  2 files changed, 34 insertions(+), 55 deletions(-)

> -/*----------------------------------------------------------------------------
> -| Select which NaN to propagate for a three-input operation.
> -| For the moment we assume that no CPU needs the 'larger significand'
> -| information.
> -| Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
> -*----------------------------------------------------------------------------*/
> -static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
> -                         bool infzero, bool have_snan, float_status *status)
> -{
> -    FloatClass cls[3] = { a_cls, b_cls, c_cls };
> -    Float3NaNPropRule rule = status->float_3nan_prop_rule;
> -    int which;
> -
> -    /*
> -     * We guarantee not to require the target to tell us how to
> -     * pick a NaN if we're always returning the default NaN.
> -     * But if we're not in default-NaN mode then the target must
> -     * specify.
> -     */

This comment has got lost in the refactoring. Since it's
documenting a guarantee we make to the target, I think
it's worth retaining.

thanks
-- PMM

