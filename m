Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED5FC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPln-0003qA-HR; Mon, 27 Jan 2025 09:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPlm-0003ia-2Z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:07:18 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPlk-00010n-N1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:07:17 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3c9ec344efso5967101276.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986835; x=1738591635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uora7f7BTfYvMegFw8XG2TVR2DRXRe8oGNu2WeQsM9A=;
 b=ZCInhUBFDwgG5vRZsIk5o971ZF6NfD8gT3vEjy7Ddumhcmv5vipiNxrup8gePioF3p
 76Ihi1BQPThYX+dNzzHk53k8GncONNUjIdE2cr18Vyft46o6RNS5eiV/e5TAMA+cyLdP
 NU2VxOc1mTKnZjGQUtme/0XTIT1vYU8NJuov3kbgXt9casrE0JBB08XpBHtruBRZC2FO
 bxldN4BaKM+obdKoQMRolJLxDL2awycG4HX8tHaB/k+ZhNSkqXUFcHw2hQNkGiphnRgj
 njNtSua0O7aLsZ8tZUpMz/3QQ9XtE8uLWT4BDbyvWb/YxOKoQmTZn/2G3yomV2dYQLWE
 fZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986835; x=1738591635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uora7f7BTfYvMegFw8XG2TVR2DRXRe8oGNu2WeQsM9A=;
 b=VSBh0kJhtrlCJURyTVB0e65zo7LEW4wBN5KLhmHv8vvDYUORNzV64o8uhVDL+7V0O6
 GxbLAuDZ3iyN5Jjz44IClcO3953D8MAkI/U5rtSTSz9qZG6HN3O7L5j+Xb7Vjcp9xCAY
 /Z0jz3IrKB4puR5fDJL97idfJ9dB0onzC/LYYAuigtm6Y8m1SFeO91NOs3mV2KrMP2Zn
 DaW0CBFB7ULnRR9Cm4WVvkZyDMrKvmWkVKbEe3tbNdxTFBWidgI5lLSRD49xZwMtFIjL
 P5I2tOoB6hBU4XzXcBuOmUGbsQdkTTis1Cy7GAAGqmEFDJ6iP0LIOIYAm9QgBLnQiCfD
 2b9g==
X-Gm-Message-State: AOJu0Yz0T9vP0uJaddZLZS5bE+6uN4eVzLKkrUWOI/TGA3SGAFZ5S3nh
 dCabfeWBpoeJWo1bZtHFXJ3mjBZJirXvcDEj7nXGzZASYGkI8BConvm2bwLEN/f6MoHd27+5FCG
 L15SnqhxuWftCuU3KqXvHmeAATrcJOQ+DSigypwmPixmaA7GN
X-Gm-Gg: ASbGncvYkPOCq+qY+y8qeacxOKtmfQBM1aF4TYDGtKlvEry+DcepqKnBvwRjPdU5RUk
 a3ghmVGB7VAh+9yt6y58oSlET4x+WfrWKmEndRO11H6PFBTW0viPQGCkDZsx57lw=
X-Google-Smtp-Source: AGHT+IHV1f83ixfGDp6VUV+sHx+1mYlBLO27TF5YbwKaWqU2UbW9CnfXmJ2lsMHuek9cdmYxR+HgfOWawWdrLhH4U1E=
X-Received: by 2002:a05:6902:2202:b0:e57:f5b5:dbd9 with SMTP id
 3f1490d57ef6-e57f5b5dcecmr23019716276.47.1737986835499; Mon, 27 Jan 2025
 06:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-6-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:07:04 +0000
X-Gm-Features: AWEUYZlAkEWhV99FqBXUNgk3QJJI9YQRuVkWrrLl80b3Y4VYBg34FGOwfi-lWek
Message-ID: <CAFEAcA9CqK0BM5C+GTJ_f57uNStHVrTfKk=6W4KdsNh7AiiscQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] hw/arm/stellaris: Use DEVCAP macro to access
 DeviceCapability registers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Add definitions (DCx_periph) for the DeviceCapability bits,
> replace direct bitmask checks with the DEV_CAP() macro,
> which use the extract/deposit API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

