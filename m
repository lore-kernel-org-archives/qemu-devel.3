Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A0FC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPbN-0001E4-JN; Mon, 27 Jan 2025 08:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPbM-0001Dh-AD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:56:32 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPbK-0007ey-NM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:56:32 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e460717039fso5997342276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986189; x=1738590989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRH6o7Q7ce+oPjw2GOlNv7BlCxO+HqsAqT4RlPl2sgE=;
 b=efLFSkpTspAyD+YaU9sg+oRP0mGQK3O+zwvTbQ5FNLCWeZUhBJC9Q7/2zC/fx8ZSlm
 YEyEOh7cWPBxfYtIUrvMuCo35gvSFpqKDd5HME41Ht3vfTYRAZil7hzpaDd2ro/UAdWu
 dCMxoR0AhNKs01+T0qnQeGpGd02jbQu8aytjhiwyGxoSnUdKG/ulEqb7/xe3ptBhc85k
 Kn/nU1c27aFY10PQ/oN2hzJmRbJvdKeD7HQn0Vnfb9fKhHI4P1H6eTE5CUyPAaiueVsZ
 pD+0Qf3CnHJr8W1+Cmp01bvhbxS6rN8Xu59UdGPLAnQ+OD6ZK8Z2oD1tKNlx2pBsqj/a
 t1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986189; x=1738590989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRH6o7Q7ce+oPjw2GOlNv7BlCxO+HqsAqT4RlPl2sgE=;
 b=D/daNFkdxiRoipLmLVpfB14l94EnshfiQwwIHrftYvPL3GFpvTJAP8g8vQkMbjdlF0
 qwyGUS2792CnkdujmQ4vZb6rYl0sgqwBSp1U811qCfSLNBq1ANAJMvHFYoDrY/YhgaAs
 557T9HG3fUbw7rHgY8NQyE0B04kaBx8QN5TUeIVvTwGmL/FbevnO+1tQhkUiIWYDdxrx
 b9JlhjowRHRsWSz/ob7p7KUseGejLA0TIlEs0TD8Zb8t/oadUOBeIumc4O+v5RA/GOPS
 6tR41gb/vMApp8lFqt3mLqXzieaXuhA7xi7qrL8GkTIe9uxfaPiFv7P8gPL0Iou/fiAg
 aG4A==
X-Gm-Message-State: AOJu0YwPfqDnT9asr0YIKdVNjCLcCP4JTAJj5d2qCzHwE2MHn+NHRFuu
 gQtPYqgflbrYkj9XhMrHq6Ob9eQ02YTnBSRf+YcilasU2P+QGlpVcQ92XN79HxbLXfUiXQ2VDQD
 dslvrf51S7q4Y31zZq60+UMmNCeaBpuWWm3Z+oVKXya7jTmgd
X-Gm-Gg: ASbGnctvKBlZa3zPYqHytX0GCTMonSWll6aShHPkHsk1of4jJBGW8d9j8kKS77F9Hkd
 lOUWauuMXBEX4X0QxGJDKYAI/zvnXo4aFOdm+qHaICIeGNsf5CdwrK7qKlGtNqB8=
X-Google-Smtp-Source: AGHT+IEzhd0xHhVvphcYeU9KdUyqblBbfJVcPR1ZMZpf4R6xjxHIpTm9XL1rBJm9b/NUsyZPcN8LA8oZvgeerBbDWwo=
X-Received: by 2002:a05:6902:161b:b0:e54:6daf:c6ec with SMTP id
 3f1490d57ef6-e57b13dfdc6mr29077113276.42.1737986189213; Mon, 27 Jan 2025
 05:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-2-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:56:17 +0000
X-Gm-Features: AWEUYZmSwUbM13OlC65E2eu_iLi82AtDDSBK7Wat799w5mSkusIz-L59MzbmY0A
Message-ID: <CAFEAcA_JkY9yh+tgthdX-6SKTLJREvgc1FE48jU_JXLfLDvSoA@mail.gmail.com>
Subject: Re: [PATCH 1/9] hw/arm/stellaris: Link each board schematic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Board schematic is useful to corroborate GPIOs/IRQs wiring.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index 1bba96df14e..9b414ff9069 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -1379,6 +1379,10 @@ static void lm3s6965evb_init(MachineState *machine=
)
>      stellaris_init(machine, &stellaris_boards[1]);
>  }
>
> +/*
> + * Stellaris LM3S811 Evaluation Board Schematics:
> + * http://www.ti.com/lit/ug/symlink/spmu030.pdf
> + */
>  static void lm3s811evb_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -1395,6 +1399,10 @@ static const TypeInfo lm3s811evb_type =3D {
>      .class_init =3D lm3s811evb_class_init,
>  };
>
> +/*
> + * Stellaris: LM3S6965 Evaluation Board Schematics:
> + * http://www.ti.com/lit/ug/symlink/spmu029.pdf
> + */

I think we should prefer https:// (I checked, and both work);
otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

