Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8288CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtaD-0000FW-VN; Fri, 15 May 2026 10:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNta0-0000Ao-5W
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:31:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtZx-0003HC-Vm
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:31:55 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so8166170f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855512; cv=none;
 d=google.com; s=arc-20240605;
 b=Q/Foc/SsTVl09ZrcnXxGdMxdCwmF+cxcTjknHIw+U3xzbaEw3s8nDOMWAFo7qsuAD9
 l1qIwSIojMM1dkPyJgz5EVkqcrmOStb5oXRtXxz/eH/iWDbNHKqH//NSPXMc87B6cpc+
 Ec8C+LbgeRRAhkN9JjXUR585JLh016rIeuopRtSmWio5wdDUT+a+nUUl1fa+A0Dh1nXK
 wrM5ClcaCsN8iQtlYm9VvX8+QYwX6BdBO1ZF3HBJDOFzykOHQLdM2oXp7iATWrnoeJ6/
 kZvdlAX1s47sIACn9g9uA4CWmjEzpKtr9tjVI8y62B7OEprL7PPL/bdJmPkRc24ncCIr
 4V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DF5qZalcfRa3geINGkCf2OMKt/clHmchD1zgEGnlxC0=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=F19Fmj8umaJ/pwB0tFoa56wh2jkl1XL8YxTkRoHIeGjZzGgyQmgWH7MvUsnkNuKxmF
 WNxkg74J7ZEALbAd6V5z2NP1knEmt/43H6oMrNlpk6U/74BeuFY80e1GWxi+izxNNGWM
 4UcRTQwIBQ7IWA4JaauPn9uULSEAnh20gp7yBjDak6p2a1E6w+w8MMXVYTzhTq119kLi
 XRaYpAN+MV51ivxqMrlyHCq6sk1794E1S2FkJjaQxBDzxh6dyo2anVR0CCW6ngk721Iu
 umbX+dnaobsttRC+8fNxfEPeNq8MtAw2L/cHb78c1VJgq6wKebz0z/Kms/i8GMWlhKC5
 rO5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855512; x=1779460312; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DF5qZalcfRa3geINGkCf2OMKt/clHmchD1zgEGnlxC0=;
 b=I3p6M7Fu/OLieb9vU6V/JuAbdXxUPiBm6MPiX28Tx+lNGLKjGFQpQqHI/Vo7rxVyzM
 hlSAImOyCFXrXTjRph/konWpGmNeRGmfhMUCHjuJcOK3qhAoxW6X9PLCE0L3Dk5wgD0P
 11OAyfOF8BioE4emAXHMvMaV8Bk5i4DChicWu7ffbBYrUAaK/nzP2QlX0qm4UyHVm8l1
 /JOgwwvEUsAVy+lp6p4RXJziITnXbDB0c4l8dz+aJl/WpF5FQibONBO/6GPpLsMPd2Z3
 uoi13BrPtckD67S3UpZb3oYsPEu8dryVwdDDJ7fWhWejh/OABh2j3a3UIje1mc+wbnEx
 mF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855512; x=1779460312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DF5qZalcfRa3geINGkCf2OMKt/clHmchD1zgEGnlxC0=;
 b=Z8nlB3bzDggDIeyvJeCdQI0D5rPkOIPMniVB6du4FKPWK0sNpUkrBDK0flmqpiuSef
 ZG8LLjkYLe2i83FpHrVrRL30d2RftUqs+DTdIpbUTBP3bhqtXfAQ+jSQlVNWRXJYy3A4
 IeiFZqUeGx7EMbU1k+n54CKtRxQcI+n+hL4oCg+X0IwdmxyBcT1x9+bd7H64zrNHzyQM
 sR3Za3klCGL64CrJsDOdzejyxtuP519roY0swyxdJZycEeXwEP9fQtQwTGAuLYXEmkCf
 udjUwpnIEZNG1NKG8NLbDH7ivexJN0gACFTEkr6JUuU/ZuY2KeWKaFN5oz/5OrQGJe9v
 j2dw==
X-Gm-Message-State: AOJu0YznasR/eh/ijgaSAjk+bunfZuwHGCANB+x9Sqo04Jzi+6AB/aBx
 dkT0yJOXfV1Oz1CGLKYdzM9d2B9BpEIAV18uNJGYVNu2kldHA1h/czrjpl2MP2f2NNuq/4TTR33
 R5eXbyuqhQNbvlU+j1IzUSoQJ/pxls5IFNFvlTFKg1A==
X-Gm-Gg: Acq92OEz7SK+BgfPKm9egujaM8+l9wTEwll9piMocSxrCvZR63kzORv7qbRW9E2v36E
 Ev9V5jJJRdsw1bqQiGsX7e3qkp3qRXmZ3WAo8yim+az4PXAN8EFKiYZBUzDGBHeK37MppC4akfb
 sVAQwo+KnSfo5YKpdtC98npVqkeCh3FNDAu5RS4Kx/mnB7rzpa3S7Y/4rR9nvL3/txU+WpPm1if
 geo2AoUPtAJkd8asABfOSBqjtD96YHy3SiJ10TWz3lKHcg39+aJxjseg9GDgdTuTuH5Y3TQGgiT
 ivb0ONgDzLChCE7w3vYdIvus88Uyv8Uv74JeFPJMl/iDQPaKNw==
X-Received: by 2002:a05:6000:1447:b0:45d:3a93:d9cf with SMTP id
 ffacd0b85a97d-45e5c5872afmr5946782f8f.25.1778855512277; Fri, 15 May 2026
 07:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-21-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-21-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:31:25 +0300
X-Gm-Features: AVHnY4K5j0D1WNFNtj3H3DRpbF-RNOYsLTUFY6_wBXFIZrceV3ybyiupuK_RINU
Message-ID: <CAAjaMXbncb7CON1KofLanOMQdWi3NK3xj=CdfieqV4sazZPkGQ@mail.gmail.com>
Subject: Re: [PATCH v6 20/20] target/arm: Build cpu-max.c once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 15, 2026 at 5:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Call TargetInfo::target_aarch64() at runtime, allowing to
> remove the target-specific TARGET_AARCH64 definition and
> build cpu-max.c once as common object.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/cpu-max.c   | 8 ++------
>  target/arm/meson.build | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
> index 8cf8edc6535..d38bdfcf811 100644
> --- a/target/arm/cpu-max.c
> +++ b/target/arm/cpu-max.c
> @@ -8,6 +8,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/target-info.h"
>  #include "system/hw_accel.h"
>  #include "system/kvm.h"
>  #include "system/qtest.h"
> @@ -190,12 +191,7 @@ void aa32_max_features(ARMCPU *cpu)
>  static void cpu_max_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> -
> -#ifdef TARGET_AARCH64
> -    const bool aarch64_enabled =3D true;
> -#else
> -    const bool aarch64_enabled =3D false;
> -#endif /* !TARGET_AARCH64 */
> +    const bool aarch64_enabled =3D target_aarch64();
>
>      if (hwaccel_enabled()) {
>          assert(aarch64_enabled);
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 3e02941d0d5..9408131d178 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -9,7 +9,6 @@ arm_user_ss =3D ss.source_set()
>  arm_common_system_ss.add(files('gdbstub.c'))
>  arm_user_ss.add(files('gdbstub.c'))
>
> -arm_ss.add(files('cpu-max.c'))
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>    'cpu64.c',
>  ))
> @@ -20,6 +19,7 @@ arm_common_ss.add(files(
>  arm_common_user_system_ss.add(files(
>    'cpregs-gcs.c',
>    'cpregs-pmu.c',
> +  'cpu-max.c',
>    'debug_helper.c',
>    'helper.c',
>    'vfp_fpscr.c',
> --
> 2.53.0
>

