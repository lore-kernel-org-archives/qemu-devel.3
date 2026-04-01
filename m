Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B1CD35162
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7roe-0007vX-0T; Wed, 01 Apr 2026 05:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rob-0007nb-Ng
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:24:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7roX-0005NK-7k
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:24:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso21627325e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775035479; x=1775640279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pfgNLiQ4n5EyW3BsOAiev/5CM+KYpoTZpeQAzpesDIU=;
 b=AQOUjhJNboEbT44ohY6LkP0WhI9pIPG9LAeQC7IXInMGauTZCWKvqGPkisagcc86fY
 hYY1wExGWgpu9evO8DarvJdnLtx1ZaFJTRMcW/4IIRJaUo8lizT5BtX+I7t8itag5oqT
 ZgeKrgljq2FN/PqrFG+bDGzTCRiiuJhnPChXpeBGr8NPYoj1MIugltddyOYhEVvLx691
 9bi8JwzKE/XGP+nN/s/5t7VLoRlh1u/R6ffalQ6/IC7WsuVXXXjBJc96UYe/XBZY8nTO
 BlhtO7x8TUbXFe+KrvvP2ETF/QAcrZ4OH5TYOr0ynlJuWdxCH9j6E03rLSgDWz65jZ6Z
 LRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035479; x=1775640279;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pfgNLiQ4n5EyW3BsOAiev/5CM+KYpoTZpeQAzpesDIU=;
 b=ieoHHPMikGrm1asMbVuNdgm7S28xdlXZFJLrtR2xucq9z6T3JnvBderMNpx71nSt1C
 3vE6lT2V2QewRQoSjNSwErVmJpw8T889+8PqS9OV+m/pEKfE8qAxbVaFTXPs46W3CyUb
 K4v+dCydOfC1YFnP6jm1rmFMPwnJ0qZWbu1dkgtdhojh29//54Tc375sgZr+ImTnYNLk
 WYmTvJ/cWTdAml5gD64c4QqPUwIIBpLlmrkicAObauPcnFCU43jUWDdpsS8mV2NuU9hX
 ieBWLcC5L1Inc4P0dmLGIFQPUXEyQM5pN0Wx5dJL8IucD58NdGuPZ8fALaBFzyTLHRj+
 l1Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGPkcHPwytJ/YNTdyh0Ub+r+GtfWMOi18VEKfOBWSaSUAYfsv99nfCipraxNydKbUmkvGglY+1K6Li@nongnu.org
X-Gm-Message-State: AOJu0Yw46Xda90Ne6UrkaYl2rWpLwo9rA0vrsW4CBl7+G9Vu5x7IhDsi
 2aGaHSrKqCDlWUh1wN4RrX824JqfAVcyBf9LjW2gU27EJEdCY6tf5yrBPPQ79zQxs4A=
X-Gm-Gg: ATEYQzzd/gBsP3TADTi1Z/0f88Cdpi0PNogX5v4SLeLfyZ6/9V/XNBoF/gTtVKFUAfh
 JQYZwyiBFGWfi8dtVEzIEYpUkhcxbqXkhFFc62kpOZWX2UpTfZa4yFU0xA8aApDs85nF/ukkCo/
 R8wO5P1hhto9A+jHMFSrjJCF4upLaW4mGrqI43Fhwa6zXTLN7gQLUancddd7tyVjwn2pJAj3bFn
 nspodis0ux4/tWNEqkwzn0FKvVbxGUSu3tqXI9huAuu6I+DdJ96PW4P5moDMWTGZ8oL3twVFHhM
 MIYgtZJtAYvn6PFaEz+Q9VSjTmWxKHaz2etJhCF2UnF011lCbNjdDTzAoaHy3xVtz/3A7zn5OD/
 NCu4G73oEw+4Rle6ROOMzDjbWOWaNaPSQ/gKzXT3nLq3WYFkWxjyPwUjI6krKP/xzSwhzVK3htp
 7SFn/Hahfh9XP7Li/rmGO7/Pc+MCu0LWh9qpBwdBfeGf7+QQj/Ug1Crg7JDDy5VxQDGw==
X-Received: by 2002:a05:600c:8184:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48883590481mr44653905e9.19.1775035479041; 
 Wed, 01 Apr 2026 02:24:39 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e829c43sm93864385e9.5.2026.04.01.02.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:24:38 -0700 (PDT)
Message-ID: <3aff4c92-75e0-4203-af04-34c35a35d8c4@linaro.org>
Date: Wed, 1 Apr 2026 11:24:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/60] ui/console-vc: introduce QemuVT100
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-15-48eb1dcf7b76@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317-qemu-vnc-v1-15-48eb1dcf7b76@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
> Start moving VT100 emulation specific code in a different structure.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console-vc.c | 381 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 192 insertions(+), 189 deletions(-)


> @@ -232,23 +235,23 @@ static void console_refresh(QemuTextConsole *s)
>       int x, y, y1;
Having looked at the following patches, I'd use this pattern here (in
various functions of this patch) to minimize the review code churn in
the following ones when you pass QemuVT100 *vt by argument:

         QemuVT100 *vt = &s->vt;

>       assert(surface);
> -    s->text_x[0] = 0;
> -    s->text_y[0] = 0;
> -    s->text_x[1] = s->width - 1;
> -    s->text_y[1] = s->height - 1;
> -    s->cursor_invalidate = 1;
> +    s->vt.text_x[0] = 0;
> +    s->vt.text_y[0] = 0;
> +    s->vt.text_x[1] = s->vt.width - 1;
> +    s->vt.text_y[1] = s->vt.height - 1;
> +    s->vt.cursor_invalidate = 1;


