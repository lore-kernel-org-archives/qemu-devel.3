Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9850C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 10:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCG16-0003yr-Bh; Tue, 06 May 2025 06:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCG13-0003yB-ME
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:59:13 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCG12-0006TY-68
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:59:13 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so972699466b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746529150; x=1747133950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lhg+n7bB+d/Vvk7494T9j6vRZkBwbUAoC3ZP82GOO2g=;
 b=WfZlCrPnfp+3x8mcM5Dqldo3tGmAAXJuA2tHgoAwOuTBYrPAlV0eQ6hY70HvX/hT0m
 aJYD9jLNhSuAg+z0TrfHHgunyeXURDTDcWZO+y2ZL+1Y7CTQd7JLdGjTzlI4xxKwv8NR
 lnbKErU/KN+EMZScPXzB24AfkQg1dxh0PJmTJQUPv1TkD3eOneuwoS6Xdv4c5VwBBGHr
 /dxizplFnlVSSew4omAIAxC0FHHjqeR//wHyOgb3kAgVYCXIgIP2RAQDsrFXKPGhKoud
 kZ3h2epCfSFz/4NKeZ3+AkkG67V2Bq8xHDeMKvAbtKc3d538brdyq2/yro7a+adjr00X
 2AWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746529150; x=1747133950;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lhg+n7bB+d/Vvk7494T9j6vRZkBwbUAoC3ZP82GOO2g=;
 b=aVKFNhrJrokw562SDGVK95qMo2g1tyHSJ+7Axod20ll21iRy6qkL+mF2pe52oiJdy2
 f/jflHUH2ztDs9XoSlNZJGN9yZWfkvDIqEKRa1WN2brsiY5XTfTRPZv4IiKCIGCE8Qjj
 tpZlAkIY3luZAMDcnIPFafCS0ZIhG89ycWI+UmsgdlpzVJ/FrOrY92GFR1CmA+MOh2sa
 mZokxLeIYefpNY3nfx4YrfdfrKmyQSd1JSf8MF5Uc2qpBiWPX30No+s4hBr+PDfm8Utm
 +Mf0vg8Bm93rnEmujKdN5v0H2Ml2xPr88EEyk5wHAYrJeJyyXzhT4C56iaNwnGCnbcNM
 FzkA==
X-Gm-Message-State: AOJu0YwvrQI09r3rGZcVn1SP38th5ZcEH2LIXXM7hImUgYPkB2zZ4rRi
 CgQZTMWMxFK0sX2xDhlxAvAYr+ykeHS+x0Gzpt6mIium80whHMBui4+fSdEdkJxofWWG6RmXEOX
 k9kc=
X-Gm-Gg: ASbGncs9svRtVheRMqUNi0Qts3ZaejoWK4CuXTPiWYnguxMl6Hkzjvtg+RgD+NL5I5C
 m5ZNdJYhMoRI90qbZvbTtJ+uSZYeOAukxOWuhAsyGwFJxfATIQiCDLBahYPT+F3z+8FMS0tXMl5
 MPUMqQst0c7H82ef5emo3QlwgzJCV32o4WVHnVfItbHAxKhxi1C/BdtTFQnVIBI/mqfUhUPg+wJ
 pc8OHIv2JnaZ1x2d4Aduxo9AvS9HtBRpGMFC5Y8c3gJdF6BKo7hBOUYK5H33MWfSxv5NC0oe0pV
 8x2dfS7Uv+inb1BKpkdPI4bMz05aRWxBq237CH2jmEc=
X-Google-Smtp-Source: AGHT+IF5aZXZRE/YbBhDRrKTX3lbKzMPVH0wr67npjOrW+KQpbLWlbePSs87btk0KXnI3AE8lnzq4A==
X-Received: by 2002:a17:907:1c14:b0:ace:d994:3cc3 with SMTP id
 a640c23a62f3a-ad1d3597dd9mr258497966b.51.1746529150518; 
 Tue, 06 May 2025 03:59:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891a15d5sm679661266b.44.2025.05.06.03.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 03:59:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 322295F8BD;
 Tue,  6 May 2025 11:59:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] ui/gtk-gl-area: Remove extra draw call in refresh
In-Reply-To: <20250214170813.2234754-1-dongwon.kim@intel.com> (dongwon kim's
 message of "Fri, 14 Feb 2025 09:08:13 -0800")
References: <20250206225304.1739418-1-dongwon.kim@intel.com>
 <20250214170813.2234754-1-dongwon.kim@intel.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Tue, 06 May 2025 11:59:09 +0100
Message-ID: <87selingxu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

dongwon.kim@intel.com writes:

> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
> which causes some guest display corruption when gtk-gl-area
> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
> simulataneous accesses on the guest frame buffer by host compositor
> and the guest.
>

btw in future keep v2 etc bellow the --- so the tooling can prune it
when applying.

> v2: Added "Fixes" tag

Queued to virtio-gpu/next, thanks.

>
> Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk-gl-area.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 2c9a0db425..9f7dc697f2 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -129,7 +129,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>=20=20
>      if (vc->gfx.guest_fb.dmabuf &&
>          qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
> -        gd_gl_area_draw(vc);
>          return;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

