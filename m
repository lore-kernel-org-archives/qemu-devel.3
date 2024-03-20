Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F18CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqBd-00020f-Dg; Wed, 20 Mar 2024 03:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmqBa-0001zn-C9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:16:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmqBM-0000Nc-6i
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:16:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-414618e6820so15549345e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710918967; x=1711523767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=etOEZgJbxNy6BpwJ08+aVQlxpXozs6yKhUiMuGswoSs=;
 b=YDER/GLdbKxFaNxAhEbQ96QEdzHsDiOLIjazs/NAqjnbAU/iN1yxBs7JBcCUzb+11O
 pyGn73eMDJ/olqc9rtktsqXtx6e8js4f5HZarMp+zyx89BsGodR+XwZ9WnT/KL7ljUQL
 1i1H+EuRYPAu7puxIrh0Jw9hvPlwDBgWTbC93RgI2SlFNa85LPyGFLjf3p8nk4z74MTK
 oXmZqz/ZmdlNftQO10YrC6LZDlAt1lA6Bs/0KfYiyWig0Sa5s1RG9jtJQUdhbUF7Xbc3
 7Yt9zna4DZrbq7CFOo/ehES9xNlYS9C/9yKi5xAbuvgHMnxy7jeSb0k/zoOXN1U5I7ff
 h4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710918967; x=1711523767;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etOEZgJbxNy6BpwJ08+aVQlxpXozs6yKhUiMuGswoSs=;
 b=bX80FSdX6CaNe6EBZBDj+WVdTko4rga0O1woD0sIeuGzesz20EI6Yb6rGBjAneYwCg
 rSuAuVVE0lo1GzioOfediuINxTbzqU3oHTdiwO4Iup26qmexYBZqtCUmsJOaWfFXItMa
 cjYpXuburROkgGTKA/B37UcETkny0Qw8RWhir5lMfTVq5j7ixf16P6I6hcNsj4iNHLLm
 2A9x6qwJNYmIqpO/T5E0yDPfayId1TKh6pGgQR+pViFdQDGzTmQu63FIAP3EJBsiaXsF
 GxSpztfaSIMBH3A+tSHwGHGH9a2iyH/RoHqUa27ggbdO3PF8EERKrjTbDemGbZNHKTYx
 zN+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP4wTEUcce3KLdyrZxzUJOXSGvMGrGzp1bkRY8ZxxdEvkkJHM1muthefAN3llhdmAwCWC2GbpXVpMhtKzvK1EjqgYi8vA=
X-Gm-Message-State: AOJu0YzND8NPTXYqzETD8sGRoQdCB86jhFenPa6P0iAn+royN8rUd87X
 QUtsBC/uc+B/nuBE8xRJd2dcpNWqZaJ5nLfKvolT+eFhACcacXeKUdhgZmXk5pPFax+cLn9z6bM
 g
X-Google-Smtp-Source: AGHT+IHPnYSXWAPLPM6w9dipaR0s8LCdSOFudNjg1iZROwr5eAl1v1rJDusUOnBlTRyHO1u9EngCSQ==
X-Received: by 2002:a05:600c:3ba7:b0:414:3713:e9a2 with SMTP id
 n39-20020a05600c3ba700b004143713e9a2mr4047453wms.3.1710918966891; 
 Wed, 20 Mar 2024 00:16:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 jh2-20020a05600ca08200b00413e63bb140sm1220747wmb.41.2024.03.20.00.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 00:16:06 -0700 (PDT)
Message-ID: <26ce98f5-9145-411d-9cb3-8bbe0e452610@linaro.org>
Date: Wed, 20 Mar 2024 08:16:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/console: initialize QemuDmaBuf from ui/console.
Content-Language: en-US
To: dongwon.kim@intel.com, qemu-devel@nongnu.org
References: <20240320034229.3347130-1-dongwon.kim@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240320034229.3347130-1-dongwon.kim@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Dongwon,

On 20/3/24 04:42, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> It is safer to create, initialize, and access all the parameters
> in QemuDmaBuf from a central location, ui/console, instead of
> hw/virtio-gpu or hw/vfio modules.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>   hw/display/virtio-gpu-udmabuf.c | 27 +++++++---------
>   hw/vfio/display.c               | 35 ++++++++++++---------
>   include/hw/vfio/vfio-common.h   |  2 +-
>   include/hw/virtio/virtio-gpu.h  |  2 +-
>   include/ui/console.h            | 10 ++++++
>   ui/console.c                    | 55 +++++++++++++++++++++++++++++++++
>   6 files changed, 98 insertions(+), 33 deletions(-)


> diff --git a/include/ui/console.h b/include/ui/console.h
> index a4a49ffc64..0b823efb2e 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -279,6 +279,7 @@ typedef struct DisplayChangeListenerOps {
>       /* optional */
>       void (*dpy_gl_cursor_position)(DisplayChangeListener *dcl,
>                                      uint32_t pos_x, uint32_t pos_y);
> +
>       /* optional */
>       void (*dpy_gl_release_dmabuf)(DisplayChangeListener *dcl,
>                                     QemuDmaBuf *dmabuf);
> @@ -358,6 +359,15 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
>                             bool have_hot, uint32_t hot_x, uint32_t hot_y);
>   void dpy_gl_cursor_position(QemuConsole *con,
>                               uint32_t pos_x, uint32_t pos_y);
> +QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
> +                                 uint32_t stride, uint32_t x,
> +                                 uint32_t y, uint32_t backing_width,
> +                                 uint32_t backing_height, uint32_t fourcc,
> +                                 uint32_t modifier, uint32_t dmabuf_fd,
> +                                 bool allow_fences);

In order to ease review, can we split this patch, introducing getters,
then adding the create method as final patch?

Also consider enabling scripts/git.orderfile.

Regards,

Phil.

> +uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
> +int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
>   void dpy_gl_release_dmabuf(QemuConsole *con,
>                              QemuDmaBuf *dmabuf);
>   void dpy_gl_update(QemuConsole *con,


