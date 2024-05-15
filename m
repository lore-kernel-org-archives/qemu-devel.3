Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F93C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Dts-0007vK-S3; Wed, 15 May 2024 08:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7Dtq-0007un-R2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:38:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7Dtn-00055f-TH
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:38:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42017f8de7aso21137245e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715776701; x=1716381501; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U9FFaBDAm2ZZ5EyJTs1NDqmySAYq+tpcxHHxGvNG69Y=;
 b=d2uWouX6wQl7RnYpw+q6UHuTrmg0cRrDIY6rOm/71K5nofBmajNFWRWbao0czsyPWy
 msQbRM5AcogMMHfJkOgGy64fozr28FQcyKrr5tiIrvnGOfeZMPHk0tVEWJx7kE8E2UnP
 jia/L1cEr4292C8xxtvHd12xIL9xAiG4r+Moez1E1XWopCWNP/zeSAFQDdIqVFwuCy2w
 L7vOqdEwTwQ4NBW9lx/z796G5sSDq/5MmDTH4npul1clXheMi4ro8Vyw8gsM6j726tOo
 p/8t1/5jqln2/C34504N7q0bweMn2Y4zWth4NmuCq4oqFQXifOFf8nqOAk/uCvm1pGAp
 owIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776701; x=1716381501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9FFaBDAm2ZZ5EyJTs1NDqmySAYq+tpcxHHxGvNG69Y=;
 b=XaL8k0BruadjiXgaNgP7wR6MC4DYyFgQT4ToQpW/RLuonIkfaTIClOQMmrw6TESzmR
 uRc8drpttgb/ytf2AEqoWUHQTAQhkWCIIpVtVLs9DbnUDvb6DA3U7LQyslnC3J8bS423
 qjZ8AbgdShvlIgsJ+oJ6+v+W5B/eJ4BKQ2IAFTuSnnQb9D2+pBFhL+nG9B4dsoP1rGVl
 eAFFS4g3dxvEQ0xtxD+twIOjF2ABLEQ2MBBEoCZQUYv7JVaVnjr5FMLdlt9ukfCVYUI1
 w9eehDvoYP+fJH1O+Y/tiHxdFMBooqNLcuUKFTiNEyXh5dBUFrApsQjvxyZg7BEBoUhP
 0IAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwWnM5J/iyeJaBFqKmjxAZECGqbprDiW3arIPVHSVhCP1MD+xmxH7lUhADdLbJvflyrL6EcS1+wPJM3qzOu8LcjRo00Zw=
X-Gm-Message-State: AOJu0YwF2xFIiFE9f5XVwOcAp/koliktTBAKpFsEJ/rgDhq7hbDn59g6
 EemKayDUod22aoEfP8aeodO2P3zEtpMdo6hXgL9tUDIqDuctozHzOx7883kUyKk=
X-Google-Smtp-Source: AGHT+IHRVOV1Ea5SAyJKgGqNZEAdkd+j4KHWmv5q9K+82+qp9h4TViI3qtHR4eCwMmSBWtsrGchbfQ==
X-Received: by 2002:a05:600c:5605:b0:41c:7ac7:17f5 with SMTP id
 5b1f17b1804b1-41feab42b76mr115136765e9.24.1715776700909; 
 Wed, 15 May 2024 05:38:20 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce9431sm226556275e9.28.2024.05.15.05.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:38:20 -0700 (PDT)
Message-ID: <0a86ac2c-3635-4bb8-b86e-5fbf93676751@linaro.org>
Date: Wed, 15 May 2024 14:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/11] ui/console: Use qemu_dmabuf_get_..() helpers instead
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
 <20240514131725.931234-6-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240514131725.931234-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/14/24 15:17, marcandre.lureau@redhat.com wrote:
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -70,6 +70,7 @@ void gd_egl_draw(VirtualConsole *vc)
>       QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>   #endif
>       int ww, wh, ws;
> +    int fence_fd;
>   
>       if (!vc->gfx.gls) {
>           return;
> @@ -83,7 +84,7 @@ void gd_egl_draw(VirtualConsole *vc)
>       if (vc->gfx.scanout_mode) {
>   #ifdef CONFIG_GBM
>           if (dmabuf) {
> -            if (!dmabuf->draw_submitted) {
> +            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
>                   return;
>               } else {
>                   dmabuf->draw_submitted = false;
> @@ -99,8 +100,9 @@ void gd_egl_draw(VirtualConsole *vc)
>   #ifdef CONFIG_GBM
>           if (dmabuf) {
>               egl_dmabuf_create_fence(dmabuf);
> -            if (dmabuf->fence_fd >= 0) {
> -                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
> +            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
> +            if (fence_fd >= 0) {
> +                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
>                   return;
>               }
>               graphic_hw_gl_block(vc->gfx.dcl.con, false);

If !CONFIG_GBM, this causes

../src/ui/gtk-egl.c: In function ‘gd_egl_draw’:
../src/ui/gtk-egl.c:73:9: error: unused variable ‘fence_fd’ [-Werror=unused-variable]
    73 |     int fence_fd;
       |         ^~~~~~~~
cc1: all warnings being treated as errors

There is no reason to have the declaration at the top, rather than here in this block.



r~

