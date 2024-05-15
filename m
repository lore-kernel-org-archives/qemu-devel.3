Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283AEC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7DOw-0003EO-Lv; Wed, 15 May 2024 08:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7DOv-0003EB-AE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:06:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7DOt-0006AR-Kk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:06:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4200ee47de7so29675525e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715774786; x=1716379586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K95aiPgCk2C6UT6ffAv19FEMj0kmi/+dOCovWYsLKe4=;
 b=lexcDodCs1l+ueB/NAxXXcUEX18YUCbT/yBjhuzB8Swj+yHIc/4Udazgcg8qUhNF/k
 FbnlTvlUVryQz4GlxSQsXIADU41zD61fCXgMs0oNTqRZBskViIiYtzV4bVZaIhNv5OqF
 8AEZD+F5omrVT9ktb4kygmov36+CU41+mrCTXKnLdM0bQOccVtUi97vyMdX3wOWbGSND
 8t0EoNDUaVaA9x9Zj2yL+L7JAdvyttw4HvL7vkOviQjPOxLiGaiDmD4YThzqJZu2vVk0
 RWiyKk81w8zRsCo24ZsBoZYi2PnAQIVgoVBVx+m7p2CM0PK/F6EvETEKzMHRE+jr7uGm
 tm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715774786; x=1716379586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K95aiPgCk2C6UT6ffAv19FEMj0kmi/+dOCovWYsLKe4=;
 b=IzXrUVFWlmH1pXmF/kt5LHRq9bMDgnaapBNhKwv43TDpW4biRhhOiIf2k9Sq3sRl01
 ITrmR1KMdEvlAG4OLAN4ozWcUC3MxgWx823VzkF/YqxQkFkYgVYCnngg+CtZHEYnpchJ
 73ZGL5vQNcLzIm9rHu/Th9c3iiKBjEuomprH+dTEes3JmLQMFMZXi6UIO53NQDG1chRQ
 GWc05Ca+sIb0vbYdds1E3tDQjexhNyLsZfx1WKqkludjlnTbhzq3OputTOV4TsM7+xIX
 tDDSXsHnWg9ii0j5HR7rYyM8X53ci03+ipLpAWIIu0bx1i3zTVpr3n38I6F6dNXyQCVL
 4Eag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+4uufy3F1uclgRDNo3/4m/nLeuoXQS63sHaFEwPsF3dz5xGnAQlbDNgbbS3tyHUQI2RhcV75TR5M537HCf2KNryyJ7mY=
X-Gm-Message-State: AOJu0YzDe65VU9JR/+1Ia2m4diX+XX9KWxjgAlGkJ826+63uznHSVPX9
 3G80ZoGBKX4cmFxDgz8/hJP1DzneGPRxgkrC05sOLQR8mQ9puIGyTK9o8r5cBBg=
X-Google-Smtp-Source: AGHT+IEdtri/3D4iJ2TiKg0nKm4+9NvbFCUHTcS5DuOfdLqYqAoFYHUhj+MP3LKhD3M+lQb4qLDJSQ==
X-Received: by 2002:a05:600c:4f12:b0:420:18e9:86d5 with SMTP id
 5b1f17b1804b1-42018e98859mr55370575e9.10.1715774785963; 
 Wed, 15 May 2024 05:06:25 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fa90e93absm255118225e9.9.2024.05.15.05.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:06:25 -0700 (PDT)
Message-ID: <c2110b90-945b-40bc-bad8-eebb5f9a68ef@linaro.org>
Date: Wed, 15 May 2024 14:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk-egl.c: fix build break
To: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20240515115005.3553790-1-anushree.mathur@linux.vnet.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515115005.3553790-1-anushree.mathur@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Anushree,

On 15/5/24 13:50, Anushree Mathur wrote:
> Qemu build is failing due to an unused variable.
> Removing it to fix the build break.
> 
> Signed-off-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> ---
>   ui/gtk-egl.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 0473f689c9..3177992b91 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -70,7 +70,6 @@ void gd_egl_draw(VirtualConsole *vc)
>       QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>   #endif
>       int ww, wh, ws;
> -    int fence_fd;
>   
>       if (!vc->gfx.gls) {
>           return;

Well, it is used few lines later when CONFIG_GBM
is defined ;)

Cédric sent a complete patch:
https://lore.kernel.org/qemu-devel/20240515100520.574383-1-clg@redhat.com/

