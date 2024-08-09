Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE872C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLjP-00053I-8E; Fri, 09 Aug 2024 05:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLjM-0004oa-Gf
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:16:17 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1scLjJ-0006i5-BY
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:16:15 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so30004871fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723194971; x=1723799771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kqlCEH87/NeUA8Q2MvkoHSXaVgPPuUPGNbx4rpR5vdo=;
 b=lcvzrzxT2HV5gGI1vVVQZpmbLueLuPzDfWygOWV0rcl9RGSS94MIULnOhTVPFLthXk
 qi7/B6ly5GWQq1ALkPbz1eHwX0GB8F1kltNyeXSKN8OQpOT4erQiTxMZcCvPEd5CYKwQ
 w0A955a9KUN/YhAN+lbCwZTn1oHpV2DQdKDdsRjMXqu99g63WEektHFvnouKXZlungmD
 vJZMtS4O5QuLCDMjiDtunTv2CNSwygqgmjNjnhMJJBjrEKPkBLrIDMub4lnDYhLA0BW0
 XMu1WxJF2Rnf1zhNd+VIsaX/QjzdIg1vhaeZOiCPIUqeMjaT6VQPJTEFZTh7QRnMHQ1k
 dQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194971; x=1723799771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqlCEH87/NeUA8Q2MvkoHSXaVgPPuUPGNbx4rpR5vdo=;
 b=dcLuExYwV7RncZPgtTNArkLP25i3RmANaiW+rCZR0HqPl6qG0YQfjND/QWefNBWtOK
 4/k0J4aymrsrZwru6pZIdKWNLYC/IVtbx6nhahWFWZfsxR/I5mh4vVS3XZBbmkW20dHb
 R2nci/mx+YUkMciyG0vIopYZkzq5h0fRCeajNeYOVdS3fCAhk2HOnyc+lipbQKovSwk2
 w4GCCI2I9XVDRjHiajr5v4GMHWbDoEpSJIA9CpW3fH6sfis9efusYphvFiaxLn10YRz3
 sEUGAuzyVFJPIUOELddUjPMKys5zC1uj/5kLMtCjZEyjMbAQOq47KsHI6dsrl6q+NQLi
 6G7A==
X-Gm-Message-State: AOJu0YylT7UbCLwNpRXZ4aB/kb3KXVB1pfpjh/LBKA6nmfNYY+9R+3w1
 bbeBF3ftRn3js80F61cuV4x20ZFX1KTxtNRXr3URsrpk2f++BtmOXm1dMIRPNTo=
X-Google-Smtp-Source: AGHT+IEfH2eovvRFU5CfEkRKTHh4N0jgDr3YFgxddGpeI8aunBdmUJLML3WlDzh6RlRlORh87etDGA==
X-Received: by 2002:a2e:be90:0:b0:2ef:2ba5:d214 with SMTP id
 38308e7fff4ca-2f1a6c4d1cemr9983341fa.4.1723194970510; 
 Fri, 09 Aug 2024 02:16:10 -0700 (PDT)
Received: from [192.168.178.175] (41.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.41]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4290598e970sm116998785e9.24.2024.08.09.02.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 02:16:10 -0700 (PDT)
Message-ID: <e7c65f33-2438-4c9b-89f9-b1749868e11e@linaro.org>
Date: Fri, 9 Aug 2024 11:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: Correct virgl_renderer_resource_get_info()
 error check
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Helge Konetzka <hk@zapateado.de>,
 Ganapathi Kamath <hgkamath@hotmail.com>
References: <20240129073921.446869-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129073921.446869-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

Hi Dmitry,

On 29/1/24 08:39, Dmitry Osipenko wrote:
> virgl_renderer_resource_get_info() returns errno and not -1 on error.

So basically we were ignoring all errors...

Could some errors just be safely ignored? Because apparently
this patch now gives troubles, see:
https://gitlab.com/qemu-project/qemu/-/issues/2490
Can you help us there?

Regards,

Phil.

> Correct the return-value check.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> v2: - Fixed similar incorrect error-checking in vhost-user-gpu
>      - Added r-b from Marc
> 
>   contrib/vhost-user-gpu/virgl.c | 6 +++---
>   hw/display/virtio-gpu-virgl.c  | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
> index d1ccdf7d0668..51da0e3667f9 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -327,7 +327,7 @@ virgl_get_resource_info_modifiers(uint32_t resource_id,
>   #ifdef VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION
>       struct virgl_renderer_resource_info_ext info_ext;
>       ret = virgl_renderer_resource_get_info_ext(resource_id, &info_ext);
> -    if (ret < 0) {
> +    if (ret) {
>           return ret;
>       }
>   
> @@ -335,7 +335,7 @@ virgl_get_resource_info_modifiers(uint32_t resource_id,
>       *modifiers = info_ext.modifiers;
>   #else
>       ret = virgl_renderer_resource_get_info(resource_id, info);
> -    if (ret < 0) {
> +    if (ret) {
>           return ret;
>       }
>   
> @@ -372,7 +372,7 @@ virgl_cmd_set_scanout(VuGpu *g,
>           uint64_t modifiers = 0;
>           ret = virgl_get_resource_info_modifiers(ss.resource_id, &info,
>                                                   &modifiers);
> -        if (ret == -1) {
> +        if (ret) {
>               g_critical("%s: illegal resource specified %d\n",
>                          __func__, ss.resource_id);
>               cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 8bb7a2c21fe7..9f34d0e6619c 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -181,7 +181,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
>           memset(&info, 0, sizeof(info));
>           ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
>   #endif
> -        if (ret == -1) {
> +        if (ret) {
>               qemu_log_mask(LOG_GUEST_ERROR,
>                             "%s: illegal resource specified %d\n",
>                             __func__, ss.resource_id);


