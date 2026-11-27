Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED361606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KLAE3amD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtVc-0002iZ-G8; Fri, 27 Nov 2026 05:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWtVY-0002iJ-O3
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:48:48 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWtVX-0005xW-3o
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:48:48 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67db89857abso8223975d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 02:48:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795776526; cv=none;
 d=google.com; s=arc-20260327;
 b=Ciq71z3D/Bn7BXGuitXmYuT+BGUHgz342rF6nggYnggf42u3i0+sbvEHKeKKUP9rfh
 ufgpTUNfRGzWEtNtrzceUKqNZCkzF8UHeR6b1cmRQklQIjj+WIBJJanOSQ36nQnkpy1D
 aOVitKIXnHBUehNwL80eO92MaEoAaO6r+nBiy+dA3lG0KxKh7CrMoErBr2Ev/6nltMI3
 c3dablrj1jsqePUMs2RSSGkRlnuchi3begO/y7kkDZ2rwD1W7JVBM6uvc21OSJy+unEv
 4zoiuQNqq6cs8zHEvQlxfI060PWjzxOiEr+MQsJDkX+B0I3+x2wfxd25VLKLDI2x9l8H
 LT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Dk3SxzXZVqwTqYpDQngFKV/7E1nrns4o/Rs+HjhxFGM=;
 fh=weJmw+UXUb2pZ/d5ZH4MxPfIFIKr4z7wAFsSR8vaWGY=;
 b=TxXD2EyKk5iyVIHE1ti66eiFw0louopndmSd/2A0TTO3IEP+H7t75sNhi+UkiXlCR1
 hE+SMpYELnCPm70Z+j6WN2upelkPoM8j1JAVeLF4vbekD325bN2q1yYPUO+l3eRUGEc6
 MleDReVyij5js1fAiqYujV6Vqk1dloLBXeTQOaRqcKN4zsyTv4YOVC/7jpaWIMBbB3Sf
 ymw2bvXCL/q44nS/LzErhbjmWKgUCKGPm+vQMAKmlpx+6D/ip4w0CClbw6pGYXGYzVri
 p4U96KaK/4Gbz0mL6xV+mPpRXKuPsicwjcPLkomxo+jT3ZtIxak8AuVD/aGW0jCIzRYn
 bZ3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795776526; x=1796381326; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Dk3SxzXZVqwTqYpDQngFKV/7E1nrns4o/Rs+HjhxFGM=;
 b=KLAE3amD4TCNACNQMBopnskeC/5Rk2+XLhs7eRKhdiH7LZZz0retMEFwHGT5kOw+r5
 YrhlAebNq9ptv1dBzSa9GMhC0rpQohUchGyc8txk7XLiCP5MRYniUJgbRvBJlq9csryw
 WQ7wlwGpDVQO/Ujp09L7z4RGUWbUE5/AlBrn1mkQHWW7Qf7MMr/vJI4DpTIZO3RMU6Q3
 EFtQidqcutTwRSgOEqVosv5WAzi6FHPBqZOELjT/fnak6ndQVMRTaDWVcP7K7lMyl/V1
 S9BayEpKgja4UQsqpZUTwti90sRbEYSPCUdCatQ4PwnGRtUa1ffN6b17gDrWMYfAu/yL
 LAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795776526; x=1796381326;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dk3SxzXZVqwTqYpDQngFKV/7E1nrns4o/Rs+HjhxFGM=;
 b=B2MT8UKLum7SZbJTyuDGkSUwiANvV3zQ5zbu7vAjnJoSVY5C/E+z1Hfr6lX28VLoxX
 XSGHe2bfDmH7l2Zmgm46oe8MaeZsIoyxYFFogtUfkab4Z8867IxRkAt1JgG8sR3x2izl
 FzVCzVQzDT2dsYT9es+KpsIkOsSxPgVR0g4pD7Zg5VLpdJgxZhF1ru2CjlsVs5cG8Qg+
 jFJsHiKCkv/XkeSBD5c3nO1q/VOu5B7mkCvKslFYHIp22z2Ka5DJh5Sr1ntRiKw8XKOS
 4lqYGlJl75W+bYYboKBewSsZrlvVHBxEzhIr2v/FVXMa+vTOG0WSVAUlPUYJBUifqJ+l
 7iHw==
X-Gm-Message-State: APuU4Z8BnBKOXN3xiAlsOHGTEx7znJWaB0ZCv9jqX15tX3yWkqlw44Zl
 T3RYzjN9SoXayqybGAVcYALYKr8gNI48pQhM3YKIcnjxpM1ckfuy8gRyjSxM0jImJyUSVrlTeZ9
 hrymptDDKfVIpEdgkf+Y+XQV/BXc3CFg8ZaPkkJ1XLw==
X-Gm-Gg: AZFdTZcHNthxRgFlzdLeBrsj3bV+3E/ufOqB93Exe802296Y3H8FGDBIKECOAOkMrhK
 X1J96pe9xJaZHf88uskPtI7rY9/b0U3FoyvJJyUlFXpsJ8NNj3vbeNVgVI/NI5VMBOvY8EpDfP8
 wv07ZTSRUdegjYyAUNqiMEXD/9KURGb9GK2pUK4Np8t0mtbzVWThNp4pTCOjN3I0GL3X7Xx0ObQ
 9IltTDToEM+0WuaY39lGoyKrO0jg7dfbGWVlhhqoU1je8Ku97RmgvRETDUbtws3Ny4uN1K1elSa
 VWIBfjreGGl1jlFCkVsMUnDuoeJCzz4gviFfDElCPxRQPin1/D+5zG26lTnd8sjsJaodtQoYm3/
 +zMhc2PHhaPDmyd8BWg7sog52QHLhZstUKL6/fV46IFiXv5gfKsg1adPU9hx0PBjMoS3qJdQHl3
 NDsk2DTo9OtNv+vcQHh3u/R7oWP69r5KT6XJo8i9bVfQ==
X-Received: by 2002:a05:690e:4401:b0:67d:b299:df5e with SMTP id
 956f58d0204a3-67df44c26bfmr4029444d50.108.1795776525591; Fri, 27 Nov 2026
 02:48:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261127103507.382826-1-laurent@vivier.eu>
 <20261127103507.382826-2-laurent@vivier.eu>
In-Reply-To: <20261127103507.382826-2-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 10:48:33 +0000
X-Gm-Features: Aa3M54q65U1PMxhdwMUD6GV8WGj9md7N8P4lIjU3-rgPLPV8X2OvbiJGfA8h9gs
Message-ID: <CAFEAcA8nLz3wjnuXiyxQ784Hpyvj5mAqBZzk2CXBh55G=GnkqQ@mail.gmail.com>
Subject: Re: [PULL 1/1] hw/char/goldfish_tty: Fix signed data length
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 at 10:36, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The guest-controlled data_len register is uint32_t, but was copied into
> a signed int. A value of 0xffffffff consequently became -1, allowing the
> DMA transfer size to exceed the 128-byte stack buffer.
>
> Use an unsigned length variable so that each transfer remains bounded by
> GOLFISH_TTY_BUFFER_SIZE.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4245
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Message-ID: <20260827174403.610834-1-laurent@vivier.eu>
> ---
>  hw/char/goldfish_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
> index 8e1e9228c78b..f64527f50a02 100644
> --- a/hw/char/goldfish_tty.c
> +++ b/hw/char/goldfish_tty.c
> @@ -71,7 +71,7 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32_t cmd)
>  {
>      uint32_t to_copy;
>      uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
> -    int len;
> +    unsigned int len;
>      uint64_t ptr;

uint32_t would be preferable (matching the type of s->data_len and
to_copy and the 'max' argument to fifo8_pop_bufptr()).

But either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

