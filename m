Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BCCCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 18:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rucdO-000439-CZ; Wed, 10 Apr 2024 14:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rucd8-00042x-I9
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:25:07 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rucd6-00083S-0e
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:25:06 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso27799671fa.0
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712773502; x=1713378302; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtfhThZ0th78vARbmOfXyTsGQ+DhZXMYW+vNjWniFAA=;
 b=mA3cQcAruLVDAartDSUyTKOvmOeguRqFv2vts0655yQwCd3Bl6A61AooLWQnJ8yfje
 JSqmO9O1rwT8CbtAk1QpezB2JZGk281kvicRrxueuOJyP7gU7GpgXmPAiSKl+E2xktLw
 GVdyb50+kW2R+QEoW2Y0yFVGUPRhBzopJxEBN8dEgaftmp0EzgkHRRHFUX9B7MaRacAA
 iwb+e4foe/i5EQ/DoyiFDNx2A+48ixnlF/ACEls9eymK9HDRRE98sBzMt6QuTd4CssOg
 kHexcvl+VlsYTsfBScRfZu9UVziMpfjB7pGBVetXbIl3pzQZwMAkY5dtRwxqiAv2Dt2O
 R+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712773502; x=1713378302;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtfhThZ0th78vARbmOfXyTsGQ+DhZXMYW+vNjWniFAA=;
 b=enuQ0mNW55kov3HjNxAxDBVRqYAB2Mf9N8s2nGCM1lkHrRi0nsGY41X4U/dwtD8As9
 OfUDkoPFNuZnsHts3jAfApU7mXvd5FAFSFhkG9Q1Kn1YWtb+XxIBFPT/Ax1nkRMlhmbN
 CfPOsdJS41kiWxQ7IO2QvDuQx04U9mm6lA2w5BU8E5tKsWY+LpTlj+RjQQkfQJmjyUm1
 KqLoMhXFQwKgQ8idCp+6HAudS++5Sjgn4KdnwVoxYsnYQstZMCKF9ao4WvtsJxiahanL
 8bH80+LrY0k7pk8now0femo8dvqWYAnUX5oSSt4RMI4Wx1l7lqu5qmXFktngwmSU+wt2
 I8yQ==
X-Gm-Message-State: AOJu0Yy1aP3Dg+/mkUxeVwdKDiP5V4EjP4okeD6rY39SX8gJ0jA1aBGx
 lxqbnUZHE4FOM6JXv32lK7UsL5hQbjNmb5ERrl7XD8RfukKmlXODTiaSnnPWBF37gwWTfklzd6t
 N2YtiY8W6pCWy+2JCXAo7IPLWAo9uDS4oZ5n3gA==
X-Google-Smtp-Source: AGHT+IHeUasC0vEep1VVjwVbNccnd8cm777lgmMbk/GCiG50WaLvbFatsPOvrw7GfkAhoUnSRk6yvX3bX4VH9sg4uuI=
X-Received: by 2002:a05:651c:502:b0:2d4:6aba:f19f with SMTP id
 o2-20020a05651c050200b002d46abaf19fmr3370012ljp.32.1712773501859; Wed, 10 Apr
 2024 11:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240410180819.92332-1-philmd@linaro.org>
In-Reply-To: <20240410180819.92332-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2024 19:24:50 +0100
Message-ID: <CAFEAcA_cR4ZXJX00TiMBa48WjHZ8qjTY9OF4i0wpfyEKGp0nYA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/applesmc: Simplify DeviceReset handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Wed, 10 Apr 2024 at 19:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Have applesmc_find_key() return a const pointer.
> Since the returned buffers are not modified in
> applesmc_io_data_write(), it is pointless to
> delete and re-add the keys in the DeviceReset
> handler. Add them once in DeviceRealize, and
> discard them in the DeviceUnrealize handler.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> As discussed in
> https://lore.kernel.org/qemu-devel/6fbcf565-f12c-4196-b6c8-559843c7a78c@l=
inaro.org/

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

