Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC2CD35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rpA-0000Gr-7H; Wed, 01 Apr 2026 05:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rp8-0000EC-UJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:25:18 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rp7-0005eI-Hf
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:25:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887fd35e60so9148905e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035516; x=1775640316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KmJAGmJZQJXN/dK7EStEa0/BjTklqiJWfHoYtci1C80=;
 b=pDIEMJyvGHSvul+qoZsvGgb/DYBMOVX1yiuDmXEw05DBAR8SZDPjmN5BZOgPcWItj2
 t9flohQDj1wegnezV6E5j3HxeyOIDYi4YhpIpL3Tl2nBbc/lWOY1soasgN/C0n5UQu9k
 k6QOL9TuDkwf+7ocx1CDJo9XKPRnjb5sWEOVtM4+oa0Ne//0QdZdHEHXl4GkxNEH8Rdu
 i57BMswWgIRVxU+Q8jn6TUxPRJHY+IYlZlJsjdRqxpBljy7ZtdWxcaKj0EcDj79ZmgkT
 290iiXmiunVqZwwaxZ9pasfaAlDHiA31hKRdEmGmOqYw9zsSgjGiJjdsgwC03oB+qDlR
 DRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035516; x=1775640316;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KmJAGmJZQJXN/dK7EStEa0/BjTklqiJWfHoYtci1C80=;
 b=kbm3ejp1FF30q6MHM5+QMz/lKr/pQZkRKRMBfxVPyCfHFe+Xwt9JM+Jn7mZQC5hWBW
 rcmfPlYQUYT+8tr0iH633/c/YRAism4spWptE7TrHojG81/PpLDCJd5wqpJzeePVwyBY
 gkp2cEGWbmLdNMz9mXidTObsLTKSum5Fd/jBn1mVjT/Xm4wg0+G2rANcSI2KWSze8CKr
 9CDATV/a881322W2/4KXbMKV627I9UHkYJc40sXauAvG4UCn6BsY9+gZ9jh23+XjBadU
 OayvfCAJPee9wVguDJxTvIDi4aXeNBpWGkGLizszDb6HlLV7uJKLijKJwJJkeTn/3mgi
 gTTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTowSKsdHNa6blqpx2FWdXwhgmcJ2oN1RszSBX7a9rSpzTY9r1kQvuBcDpLR6xAjfpiMOvz0nmiNhS@nongnu.org
X-Gm-Message-State: AOJu0YzlOkRZBtJZEKgCodDKlMiuSYYLAQrXHOIiQGg/4APKu2t/4bxJ
 2Eih0RQ6FftxcmGUE/qE7CfE+6H5quF27LSbEutAYZhZgtCO5kcE+B8t0NYFEWjYSPT1ENNoVjP
 4GYbX6JQ=
X-Gm-Gg: ATEYQzyGEO3CzgW2RBJfEf4UzRmYaOEizAFafRieOGxRO/UcJUjWO59S/4A8uXdI3if
 +vWosltcjdB6sqEbQ+AeyxO2fBGUYYvWerFU3D76Fu2raIKWlI+MFlzMfCmm8u6AIjBPPixtiR8
 qITOBTfGcQjgiTJd3bm82LehjvpQh/tGjYLnnR6MdIv673OeSEsJSHdIx+z0ZqxqLyoT9LI4AEA
 8Zuwg8JkbU4VyvgBC7DYpdWeoAot2cLeJjlaL3lnpleEQPJhTA2/kNmfihie6OTzM7bbCWvWPux
 uzISyz9jKIyVrCOH+Kajp0qsNhBV0GCLGZ7Ex3QgXjlrHLgrObpwJKPqbTTcidwSAmpkaDxDET4
 7pfl5WIUDFbZbD1G8vkyhXVgooNv2SGJ7bPX7mRhw6/FEUNhAR4zs5wxL4MZmCO6V68/goXEhPg
 /2k++kP3GWkZWRmHCVjCG5EcHtpDRQSnbrNY7hCbuFl96R+7TWPO2jhpACUvmk2tbvog==
X-Received: by 2002:a05:600c:17d8:b0:488:882e:3bcc with SMTP id
 5b1f17b1804b1-488882e3ca9mr6525365e9.8.1775035515653; 
 Wed, 01 Apr 2026 02:25:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80a616sm170648405e9.2.2026.04.01.02.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:25:14 -0700 (PDT)
Message-ID: <7be3cd50-5194-4f3b-9e9a-42e770812ff6@linaro.org>
Date: Wed, 1 Apr 2026 11:25:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/60] ui/console-vc: move vc_put_lf() to VT100 layer as
 vt100_put_lf()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-25-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-25-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/3/26 09:50, Marc-André Lureau wrote:
> Decouple the line-feed handling from VCChardev by operating on
> QemuVT100 directly. The function no longer needs the chardev or
> console pointers — callers pass &s->vt instead. This continues the
> effort to make the VT100 terminal emulation self-contained.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 65 ++++++++++++++++++++++++++++-----------------------------
>   1 file changed, 32 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

