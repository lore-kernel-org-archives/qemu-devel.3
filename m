Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38DBD35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7reL-0001FZ-Ig; Wed, 01 Apr 2026 05:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7reF-0001BW-2O
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:14:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7reD-00040o-2e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:14:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfd1f9fd1so2120759f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775034838; x=1775639638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H31Beqz54bTM5dTgbmC+SrYQ1LQgWpgJJpXNb1ZTy88=;
 b=P/JWrmh8Xev0JftBR/5Zw8eNbxMPctN21EbQOrZoXw9x2x0l5uG3zG7RwFYn6g6ytZ
 ROzDzsnqmQvNek6I5P3F72SZZat7zFGMIK00bXZNVDrTUWWTceH/mNsOyPBTw0BdciPJ
 +SGWB4tBwok0oobgl51xqMyALKG/Mu8QU/TLgYE93lq+oY1sCn0B4mV8EtTwqE/b13op
 CyhfWQiDIyR4vWXx1Kc8ftzPxQlp+l+oGON1sDqBFy7QUSYEDMc8mQyvYdQ7gwLh4Eib
 bg0KME0LTZgXWK4zpErLEulE1BlzxvabnCKFseP5twnpNGmn+4mB12AaBD1R3g6WKDXC
 WBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775034838; x=1775639638;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H31Beqz54bTM5dTgbmC+SrYQ1LQgWpgJJpXNb1ZTy88=;
 b=nzrlg+GTmuw5v2fcOlcUVdblz5ZrDbUmtShG0VeLYKAR4SQgdBSUww1jFAQ7IPt/jU
 71b988u+L5prLNo67PVmqSERzicP6Ycc1XRgxyt0fA9UOzE0ArKR1qMQgczTeSl6JQbS
 N6mU1WIe96PAROKrn5MWQeSrkLRuiY2aYxslkt0NzQmv+1GT5l5DR2fJ7VT1zvntH6Zj
 V9WdFxRp7o3c9pDnxbMaOe+fUx3kz7jdEsX4MgwtWzSDWSzLbcNALh/bDCl7LLU8SOb4
 rYe8nQWuy7Y82RrBh9TVQsmEfofeZQFpqpFcHc1KjPfsIdfi6WZwnn8Qkth+KCT9RJgX
 GYLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU19P2dNVTwNkh/Omy6Krh7CSB8RCGsww5d0xXiA7C1U4fnZ7Mkx6Lv2I6Hq8FlE+W4seCsmL/pqv/M@nongnu.org
X-Gm-Message-State: AOJu0YzJHJ2i9XwefXt9smdapmOI2DaWCYlTWmiSNG7J688iCTXfuFoi
 +d3uQPiXkJJ3StWSyM23iTEG8kqOgjwF88RdrR5nUrd4qOYbcORq3EtNP7B44cJFHUE=
X-Gm-Gg: ATEYQzwW7GDwOaivj/WlCIYswrXHMqBYjaKilGOCjUS1hn4gbhcmUodAAJuY7GjCs+S
 lrIIZc85tmvGUZJ2qSaqlHjTl1nb7Dg45k03zoAj6JekB2lQVFbXhiIdPda59aGES/Z2DeksWgP
 cg5UwpDnsmYdh6QGxR9nYw7y+bWB6IAN0y4beBXyg4LYDlhOKsaslmERyPOncTUaPPWgzqqNf3J
 GPeHqaTIIldfuEymdlGtvvkPcQdGzNvyIiKijo8lUPMYYDME0fMqfYJD1SqftFEfUdo119e7MRU
 +XNNUcc90L/eUXp0H8FN1aH9kS/waE407R7wR9wCvp8TnA/v/IFppgfl0UAmVPO6WWifTHNXLtI
 6zl7Nu1HSE8SKL56rnXrzy++jUrZ5PE5IxmTk9QTZyA6tsNn1wXYF/m8ux7eYBgYU6wawXuxyY+
 mcrvUDJ3WnuJPznvy69ltMsRd21Il2ZiF11WqIeDA8Kvv273QVrPD7GxYf6l+sz1hhLO0ozFhqw
 yE6
X-Received: by 2002:a05:6000:40ce:b0:43b:3cdc:9429 with SMTP id
 ffacd0b85a97d-43d15047f05mr5275701f8f.1.1775034838193; 
 Wed, 01 Apr 2026 02:13:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf257b72dsm34681635f8f.34.2026.04.01.02.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:13:57 -0700 (PDT)
Message-ID: <5a4bc203-2932-4ecd-9d12-c28f3234d1f0@linaro.org>
Date: Wed, 1 Apr 2026 11:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/60] ui/console-vc: decouple VT100 display updates via
 function pointer
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-20-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-20-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
> Replace direct dpy_gfx_update() calls from the VT100 emulation code
> with an indirect call through a new image_update function pointer in
> QemuVT100. This decouples the VT100 terminal emulation from the
> QEMU display layer, allowing different backends to provide their own
> image update implementation.
> 
> The QemuVT100 typedef is changed to a forward-declared struct so the
> function pointer signature can reference QemuVT100 itself.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index 56e2527c7a2..8a18659036f 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -48,8 +48,11 @@ enum TTYState {
>       TTY_STATE_OSC,
>   };
>   
> -typedef struct QemuVT100 {
> +typedef struct QemuVT100 QemuVT100;

Squash to patch 15 (Introduce QemuVT100 structure)?

> +
> +struct QemuVT100 {
>       pixman_image_t *image;
> +    void (*image_update)(QemuVT100 *vt, int x, int y, int width, int height);
>   
>       int width;
>       int height;
> @@ -66,7 +69,7 @@ typedef struct QemuVT100 {
>       int update_y0;
>       int update_x1;
>       int update_y1;
> -} QemuVT100;
> +};
>   
>   typedef struct QemuTextConsole {
>       QemuConsole parent;
> @@ -224,6 +227,11 @@ static void vt100_show_cursor(QemuVT100 *vt, int show)
>       }
>   }
>   
> +static void vt100_image_update(QemuVT100 *vt, int x, int y, int width, int height)
> +{

assert?

> +    vt->image_update(vt, x, y, width, height);
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


