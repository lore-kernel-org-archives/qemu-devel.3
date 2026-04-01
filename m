Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1F7D2ED0A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vq4-0005T0-Vu; Wed, 01 Apr 2026 09:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vq1-0005Q5-8N
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:42:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vpz-0000JW-41
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:42:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so12554565e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775050946; x=1775655746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbRu5zO21BTUc6FlfLxAv4Ejf8JxgHOZ7Kmbw3wxjYQ=;
 b=pRpRXy9jtFz0h5I52bhUHu051uUvhvtpQ9qxphfIMDmkr1z7aw4EoZF8A/qbuIYNt8
 OeBZXQ18Q6sRX3m72ClHHjONxfxsfVuEP4NeNa7zplpCmIkVcoPF8Vj8iVpJT+WXJsiJ
 0tS5ChnpwKxb/iBTF24vexr+AG+QWCPq/TAYFzTvLRQtVFXkWNZvV1FxBpdtVoYx6IRD
 q7ngnYGXT5IcVP0h6NzyJh7HVUTM8u+xy+zFuBeyQ4bbcWCn1GITyg1cx+NXFb3QXefp
 yKZ2QVnivgtq1e29D966NhTkgPMZJGjYQrw8FAnN3hy9pkceLG98UGpDSs2tDOy0rkff
 MGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775050946; x=1775655746;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nbRu5zO21BTUc6FlfLxAv4Ejf8JxgHOZ7Kmbw3wxjYQ=;
 b=hCsA6TvYao9L2BjnE45UUPGv8ZhK8Z2jaGF49cJbjuK19mIGjStqtRLNzqhIn+fQZ2
 vOtmAW9oS8H9x8qJ2GBaVTPGtaiE/2SeAFTQFpA0a95RfMvOp1T61vgDZd/L787gWut6
 wArSpmp6jzUjB7+Z5ME7knqKjTG46A+ASfi8rOAaOEMY1lQXcED3pp7myD21NDkNx0fK
 d6K9rhBr8TdTmFP7wugzvMmE2HqVgPUQTCe+9b0KQzsZWM0GMB6aFAPuDg4E7+Ue4Cdx
 dM+mb406J1OHEFKj6dSYwQ26mLMX0wu2ITGVOI/JAz2g3f1k3kHxzP5fkeKRtCT94kNz
 xAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRfQAgo2V8JFQiO8Rsn+vruV4L+DwWtMNTV+K+4ShJWR7OG9KdseiobElTeClofUajhyChXQnQNDnl@nongnu.org
X-Gm-Message-State: AOJu0YwTdVonGYX4Ng3C9OZMe4dfFZH+SXfW5ukNZ7UOOMp9zMM0kMHP
 h4IbWcRf562+pb7NKd3OoGeE47NBGxpJi5gEr7PCGcDzztu5qDfI9NTwQ3muWT7wrcA=
X-Gm-Gg: ATEYQzw9ckCfGouyfjqogX+YVKJ7QVnFAlS2FzpWKhy5YzrY6xOijWwDj7DQCn9xWH+
 p9er5TsWXA5NFz+YFI1FbWVKDlBrwFFVo6YS0swyHooXKydODrecGLwE/wrA7wu8fiUQJ+ThbkP
 LxBye7RAjgH+1DovpQHuBivaOaicuDbNG+77jEgA9eZPBfJsIhyXWEw/ytmBeBsXuJNtOprRhBq
 +XQgD1bb57oBRM4QRMj5UI4+1Kqou3LXRcE+h3ND/Dq6H6fylM5/Q3GPsC0awTXVzfPoQv8lkgy
 WNHtQ5CHJyZqdsHXmDucv1wf+O3DcTlajcTEX0VUs3FHiX7GT+TiBBSr8VgFIxG3SnlRphiK278
 5RVsbWzyFBeAzXKYHxm1cEtS8rL7kTFeW/Oj62+JwfFz5sYIx98GGLD7ijZ6puZTxe5RrzkdpuR
 CNOHTPdxYHD0d4Yzr71JaA4Z2n0z2b45XGw7b/v0aNPl1lWbF3rckI491PoggvydwXhA==
X-Received: by 2002:a05:600c:6211:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-4888356611bmr62211595e9.2.1775050945666; 
 Wed, 01 Apr 2026 06:42:25 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8f4b77sm42263035e9.33.2026.04.01.06.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:42:24 -0700 (PDT)
Message-ID: <11c2ae40-bc4f-420f-9f4a-dd7dabd9531c@linaro.org>
Date: Wed, 1 Apr 2026 15:42:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/60] ui/console-vc: extract vt100_input() from
 vc_chr_write()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-28-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-28-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> Move the VT100 input processing logic out of vc_chr_write() into a new
> vt100_input() function that operates on QemuVT100 directly, rather than
> going through the Chardev/VCChardev layers. This continues the effort
> to decouple the VT100 emulation from the chardev backend, making the
> VT100 layer self-contained and reusable.
> 
> vc_chr_write() becomes a thin wrapper that extracts the QemuVT100 from
> the chardev and delegates to vt100_input().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 87881c072ee..3ef492c2d4c 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -1058,29 +1058,35 @@ static void vt100_putchar(QemuVT100 *vt, int ch)
>   DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
>                            TYPE_CHARDEV_VC)
>   
> -static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len)

Maybe use size_t len for the new method, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   {
> -    VCChardev *drv = VC_CHARDEV(chr);
> -    QemuTextConsole *s = drv->console;
>       int i;
>   
> -    s->vt.update_x0 = s->vt.width * FONT_WIDTH;
> -    s->vt.update_y0 = s->vt.height * FONT_HEIGHT;
> -    s->vt.update_x1 = 0;
> -    s->vt.update_y1 = 0;
> -    vt100_show_cursor(&s->vt, 0);
> +    vt->update_x0 = vt->width * FONT_WIDTH;
> +    vt->update_y0 = vt->height * FONT_HEIGHT;
> +    vt->update_x1 = 0;
> +    vt->update_y1 = 0;
> +    vt100_show_cursor(vt, 0);
>       for(i = 0; i < len; i++) {
> -        vt100_putchar(&s->vt, buf[i]);
> +        vt100_putchar(vt, buf[i]);
>       }
> -    vt100_show_cursor(&s->vt, 1);
> -    if (s->vt.update_x0 < s->vt.update_x1) {
> -        vt100_image_update(&s->vt, s->vt.update_x0, s->vt.update_y0,
> -                           s->vt.update_x1 - s->vt.update_x0,
> -                           s->vt.update_y1 - s->vt.update_y0);
> +    vt100_show_cursor(vt, 1);
> +    if (vt->update_x0 < vt->update_x1) {
> +        vt100_image_update(vt, vt->update_x0, vt->update_y0,
> +                           vt->update_x1 - vt->update_x0,
> +                           vt->update_y1 - vt->update_y0);
>       }
>       return len;
>   }
>   
> +static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +{
> +    VCChardev *drv = VC_CHARDEV(chr);
> +    QemuTextConsole *s = drv->console;
> +
> +    return vt100_input(&s->vt, buf, len);
> +}


