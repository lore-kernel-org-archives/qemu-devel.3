Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AD7D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 11:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAz0-0004dr-EA; Mon, 29 Dec 2025 06:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAyE-0004Yj-R3
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:59:40 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAyD-0002VQ-CM
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:59:26 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7277324054so1423968066b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005963; x=1767610763; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJ9Z1V667r2eGY9ja6y9vrkh+RvwenSEmzfBvtN0/xw=;
 b=NuU6AXLMLtGOB5dtWPgXyEcMiC4svh5fTjRBDRVEoFnhl3rTbiROS7vN/qXNRY61xX
 QxOVemS4lC9urXjz1tLvaNyYrulJrkxUORcTc03jrZT408XU6Cea9aw3MMAQ8M43jPiW
 c75Q0Wygep24hWESmalNVqt3Dcl1xRm4We7tphu7znW/7lz3wRIh6aI5cRFJplC9D3ob
 dmbeWlu0f7n7f2xExk2BUnNaHIYwfoQAH13y22kE5m/GMAXb973YCUaRrH4s4NIoakGU
 T3usFZZRQ+0zcdzbhm4eQYwdUmwJxGxi1aYjiM3fmpLoW+xvTxcbhpbNv3Ccvb+QytRz
 Ldng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005963; x=1767610763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJ9Z1V667r2eGY9ja6y9vrkh+RvwenSEmzfBvtN0/xw=;
 b=g8XaMWBf23f4QT0kGl3e0m8byAzzSquMq3Xmqp0Y+tQZY7UTyJ9VlqQJrFdKtCRSRN
 ED8NP9s0lvh7VW0RPSlmMZnFLk+Sd0qpa++D34+xU7Ei2Bf4mAr0ZkQcka3aQ3n2wEHh
 K4dZcGgC3WTQQ7VqGISfXC6gk9fM0Zgt1lR8WTWNQMn+eF9vOHqfeP4AF/6VB2tBmfcb
 7O2rwL4/L9aEqvO7C9eZL7TQruhZ0IB+ciur3BZ6qoZeGJyGJ6id6ZzQV1kLrmE6U5lC
 Tko8k5B8BpdNcERIJJRCdxzN48aOHkCXswWy6ZbrOb3S3M5fXGLQmFDzhpwoQzAofea/
 Smew==
X-Gm-Message-State: AOJu0Yy7KZA9zDlXaglQ6FrthpZtYE75sqFuauYveXpuIKTycUiq5/bo
 bASIEB9TFsyf7ok8C+hwOviLKz9bpR3Yehru09uRmUMFB6l39XHEDJN5Y4uyHZBr6sezPJL2RXy
 qPXcP8CveB9DRjYfxVAhXCIsuMQxTBpwg1BOjuIfYCQ==
X-Gm-Gg: AY/fxX6hfE9bsf3YGSVhFoOwaBiJLWTedMWcpNp37WMYfGc4e6+aPYBauoU066oHtOl
 e9u2eWZT+qzuK9HrlND36ortqpweGGqxhqCBGHnSxpTCrpSQZ24ztWFeJ+5N8iP61NqE+Io5d9t
 fSIEAHKOXAXMQwqd+kmdhFv9BH4FTRCQMH8ZWx1oYKftxu3Zck19L9XVscM4y/q0uNp2aTzNOa9
 OljTHh4oYZJOgyyP0yGqZzpbhFMSSqy+8mrBef2+4jfyISCKcRwyFxvzqlp478hO0W42+aMZ3Ug
 9pMrQwfbUICNpJ7/BjNWccZeEvvzcwrRe4zhF6M=
X-Google-Smtp-Source: AGHT+IHo7Xh8bptEZWTwGRFPo/7bAmICuFN57MdHz3SP7rwF2WcRJuKTZrSjcH4G5oTbECGsXh+mCYh/vGuPwjwVwds=
X-Received: by 2002:a17:907:868e:b0:b76:4c8f:2cd8 with SMTP id
 a640c23a62f3a-b8037233e75mr3021031466b.55.1767005963475; Mon, 29 Dec 2025
 02:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20251224160942.89386-1-philmd@linaro.org>
 <20251224160942.89386-5-philmd@linaro.org>
In-Reply-To: <20251224160942.89386-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:58:56 +0200
X-Gm-Features: AQt7F2oqKHQNGEDTrMfKsYvtNnFMy-78vqB6hH6KoCCXko-vj8aM1u2uStAhTWY
Message-ID: <CAAjaMXYgRVNZ=jqWhSefUoER7fE4TgX8-0bQwtOo94bAwya8GA@mail.gmail.com>
Subject: Re: [PATCH 4/4] configs/targets: Forbid HPPA to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

On Wed, Dec 24, 2025 at 6:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> All HPPA-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  configs/targets/hppa-linux-user.mak | 1 +
>  configs/targets/hppa-softmmu.mak    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-l=
inux-user.mak
> index 59190f63358..a0c7398d599 100644
> --- a/configs/targets/hppa-linux-user.mak
> +++ b/configs/targets/hppa-linux-user.mak
> @@ -5,3 +5,4 @@ TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_BIG_ENDIAN=3Dy
>  # Compromise to ease maintenance vs system mode
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-soft=
mmu.mak
> index ea331107a08..003f9f46dcc 100644
> --- a/configs/targets/hppa-softmmu.mak
> +++ b/configs/targets/hppa-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dhppa
>  TARGET_BIG_ENDIAN=3Dy
>  TARGET_LONG_BITS=3D64
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

