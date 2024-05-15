Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2BBC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 10:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BaA-0004BG-Dn; Wed, 15 May 2024 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7Ba8-0004Ai-CA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:09:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7Ba6-0004Ne-NU
 for qemu-devel@nongnu.org; Wed, 15 May 2024 06:09:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so43110355e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715767793; x=1716372593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RPSFbpZvkiMgEwfoKrZcpLLhzNdkW/EqITiBOXtY4nk=;
 b=ds2VD/WtbhVLuzNrTwGrDPD+t8k0BfD334A6ytirMJHo+VgETpNsFDXf9y8PlvvIFd
 /PQ6OV2ysOWsdWcY2apTVmJZ8hTVMomfhp2o5sfxm+Op+Vp8jlbtvbAC9IIcE//2Irk8
 l39qB4+/f7FI9KlhcxOGHWsWIZ3YuTle9jFkjo/TYYgr5JQBBDWo+mWgWcXOmBw1qswU
 IFjtoaiBOiZhrR52Z0ZbkTJfc12l6Z1ydxfgp1h+Z5fVc0HfXKdhi3zcc9Erw1feWP+y
 OqeWBv/q5ywjc5eB5yLGBPpQZb8s6NiiZUrsJGHYfTom34oHTkyhbFj7IrOUlQWhkG0W
 1+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715767793; x=1716372593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RPSFbpZvkiMgEwfoKrZcpLLhzNdkW/EqITiBOXtY4nk=;
 b=e3JLT9OZZpwWMcxQ6l9E3pIdwkdBnyjfbilZVxjDPfR8FvhE2n/BLQKrU+BY86gk1u
 tTOX8/LmBo52ETn7u1Wl8iQ5aSQm1CjI30Yyi17pcak3bZ4r9NPr++8ZI/CORlb1idEM
 KKLUxpBTi7MNc8oskxMDqWKpB4lbOjFJ3KmIMhhhNaKHM+nT59nXqyyRfGEozCZQzFMr
 QhXRQDdjNAuLj53Y3lFcL+caEdwPGK0STcgnaMkfdUFWtYH/Nju8YF2JCjnyJSIUc9bO
 KSLtkQNIgSO13z83M0TcgAfOcl+xpJHNl1fj+dP9f5ciDGEGRjPrxQlhBCaPAMSlaBzl
 rv0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ4IAW7+eBvPqsz4bYsM8InEg6Ms4+q/7bRWBSqBm/Bdi/IypBnOHzfN/TFR13W0pvkz5GeHzJ95PCeBX03Toa8JXe2cQ=
X-Gm-Message-State: AOJu0Yyw9/XlgdoEtVuzhNqft1bmr89dCyeQfDGIQJNA2ksluzn60UkH
 qI6+H3K3i5mEwtRS4Vzc/0gDi7GdXzkA6FB/2JFT96X4M8xVOnUFk1/N9xhMH30=
X-Google-Smtp-Source: AGHT+IHxzTCYosHyzbcHKZLAJLmdjmjH22DRb772heDWFyY1uY/KAaJNO/buE8cZDaobh7mLV77+Pg==
X-Received: by 2002:a05:600c:3104:b0:41b:ed36:e055 with SMTP id
 5b1f17b1804b1-41feaa300a1mr153052595e9.7.1715767792776; 
 Wed, 15 May 2024 03:09:52 -0700 (PDT)
Received: from [10.91.1.102] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b8a781asm15930467f8f.60.2024.05.15.03.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 03:09:52 -0700 (PDT)
Message-ID: <92f4625c-0a74-4dbe-8555-f069dcff7dfe@linaro.org>
Date: Wed, 15 May 2024 12:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/console: Only declare variable fence_fd when
 CONFIG_GBM is defined
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240515100520.574383-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515100520.574383-1-clg@redhat.com>
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

On 15/5/24 12:05, Cédric Le Goater wrote:
> This to avoid a build breakage :
> 
> ../ui/gtk-egl.c: In function ‘gd_egl_draw’:
> ../ui/gtk-egl.c:73:9: error: unused variable ‘fence_fd’ [-Werror=unused-variable]
>     73 |     int fence_fd;
>        |         ^~~~~~~~
> 
> Fixes: fa6426805b12 ("ui/console: Use qemu_dmabuf_set_..() helpers instead")
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   ui/gtk-egl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 0473f689c915f8b2303cd9d11bc7d8336c2a85ba..9831c10e1bd58f76d8f803ad0a72d983adc3f490 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -68,9 +68,9 @@ void gd_egl_draw(VirtualConsole *vc)
>       GdkWindow *window;
>   #ifdef CONFIG_GBM
>       QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
> +    int fence_fd;
>   #endif
>       int ww, wh, ws;
> -    int fence_fd;
>   
>       if (!vc->gfx.gls) {
>           return;

Thanks for the quick fix (unfortunately this case isn't
covered on CI).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

