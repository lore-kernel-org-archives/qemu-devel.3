Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB254C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJaY-00083k-QW; Tue, 04 Feb 2025 09:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJaW-000838-Lq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:07:40 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfJaV-0001y4-3O
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:07:40 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so5506360276.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738678057; x=1739282857; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JE0Wn+b0huPhD/K1pOO9dOg9txDWdNlboMoweuj7wMA=;
 b=v5FR1m/L2U9ALI4YEqW82iluF4omViF6UEMF3rX1yeX1b6gwtwtfHPOVZU0DXJMH9c
 1+MQHOL3CwkpIwp6UJX97sMnIC69TxJBzFowbrRwAsNTCi1CC7OXuJD1u8f0NeSZzkSC
 6xQF2CibV6rFgTC3xFRWDh90KKHveKesTLTHFfZPmswo3IQGyVYZpEnjxBFaJ873O/W0
 sgvqDmo26zfUE5JhKV9ETx+r3PxNxIflWOEKhWRRlUFs51eY5LTHCGMd8Pt/R6n2S/na
 aTExBVPR74S8xTGkouAUE8+2DN37wKIoeyCu1uRZbwjPgV7JBabPZjy5I2BHvOvEMhZp
 foBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738678057; x=1739282857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JE0Wn+b0huPhD/K1pOO9dOg9txDWdNlboMoweuj7wMA=;
 b=FH0+prsEWWZN+JAfZr52o6GVN0xla6S3Gn0PnJMtvfuF+4azG6YxrmlNIFqqYb6TT5
 gggv0PBIRAExmhI7f1muTVGsgYlQMDcWmcCqsCOCKNqVwEsytVChEo+pnzYAWcnnpG6u
 96IjvXZZVDTyOVE1Y7OtjoBafeMBbg0QMigNJfJXJ1A1t0WL02iagKZmVP3/A+KoLLx9
 sWGxlI+cz2RTlrsGXM/NiLdZMLelhDsDuTQh5zopTznukp1KWsEi19ihfA+6JGW9/tiU
 MhEDtmN+etGK4pPMrFkBh/2jFzEkZVJp14/gWotWzkxnFndu+zjOzCAYmFXPjZkjm9cD
 adxA==
X-Gm-Message-State: AOJu0YxRvNCgUBKYdbOJIURpEdV/fHRmSfzx+pXjBRiJlRDO7CKyHaDY
 +hd0Ft2HjI/QfBAUQr7fP/kPayhTTMJl4tK38BOs14BHuGDAGnxirICRYdiM10hFllKLVCQ2Gwy
 UFzIlJhrH65GfqNctzXMRdIdy46en7ZTSEZgOEWLZaP1ZuyRD
X-Gm-Gg: ASbGncvJgMsmlS5A6ZcBOi50Uqo3e7/BaGXnY9LBzlF5p4qfW4AQW+JAadKUDFTGq5I
 VUTcVt9BJBbT1lrcMiVZSe4dKFODGm43B9PGSnu8N72uCLMjkVzF7L9hi0i8zCPgFnfXVr/jDUA
 ==
X-Google-Smtp-Source: AGHT+IGDjn8Yv0qQP4h98xNeaA4EcH1PTZIfIebIf3jIcW+vpQ3I/zWx6cmcKEQVaZT2bBAO/YXvHXulwmJY0stS44M=
X-Received: by 2002:a05:6902:10c5:b0:e57:d3c8:554b with SMTP id
 3f1490d57ef6-e58a4b04b29mr17947254276.22.1738678057462; Tue, 04 Feb 2025
 06:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20250130182441.40480-1-philmd@linaro.org>
 <20250130182441.40480-5-philmd@linaro.org>
In-Reply-To: <20250130182441.40480-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 14:07:24 +0000
X-Gm-Features: AWEUYZmvWhE2HyoYtu28_vp3DDTXE0z5RtFAFhMScPZGifWSlleIvq0uzHPBgHI
Message-ID: <CAFEAcA-Q2djC-64tw=0Xu7bX6Uew8zB2nBA+fdKm3jFEkYERwQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 30 Jan 2025 at 18:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We already have a definition to distinct GIC internal
> IRQs versus external ones, use it. No logical changes.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/xilinx_zynq.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

