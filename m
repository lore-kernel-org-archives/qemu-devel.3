Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EAFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVr9G-0001Fh-KB; Thu, 09 Jan 2025 06:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVr9E-0001Ev-Oy
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:56:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVr9D-0002aL-80
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:56:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so9151005e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736423781; x=1737028581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O9VXFn6cDlg2KNMj4juv3MUjuu4wI/ay9QGJ5CBzEV8=;
 b=Ny8U9f7GGH31KEhtQs1br/F3NZHOfTsg1regJGFhczY+yvlpNThsyA/YTiHSCwrGQj
 bzplQVXN/noVAoBMdRAhX8/RHy8XJ2la03U+R9fhUHdwa6Ag+X22MRRZ5UUCwz4sXhMu
 xzstghwxddnVSGyD5wIlNRUL5FMc9EZu7jKHySHXS6bFW1JxJ31QnxAd3eBodXICIvSm
 tJFNXzR7vO1mhuEQh4iJa6C0zHDLi+ZJp3tcyLRqLcdK90x8y0+EEkjsQwt7Bt2K1yz1
 DvdrTuPismexjL8R+YgPIzNuif8rX772qJaRlCMEiPJZ4/fYHUTakz6iODLNI+ff63z+
 6n+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736423781; x=1737028581;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9VXFn6cDlg2KNMj4juv3MUjuu4wI/ay9QGJ5CBzEV8=;
 b=ZskRqOgJ4fo9NTO32y+/TLuxQP9kj5pbyqavyJv09q4e+9HgP9xZJ2Hi3W/L/Mi7w8
 lWsOTwzDnmHeQ1d3kCf9MZKLf7QcGRJcfYJ/tkppT0d5LXE91BGg4HkmUXjJw9pXCs+e
 IU6kSEm/dm5Ey/CpsxDyviVsZZ79orYE0vXr2S84veX06nhPBNuiJ7emKB2dEVxidvdq
 SnhX1pOaYlCi6m2MZKfOwf1KBMkDz/DrEnby2i25eEgKv2+zZdiklqgQr2NKP8gxl6HR
 Lj32fGh4+E0aWttBq/sfOJUUPwiXnOa2/5wtlYhwTHu/Lg1DWapP75+ACIwEsJc3N4/1
 HlyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD9jV4xI+Sbkirzpn+J8nO0Cx3a+CTbCs2pIqncOkHpZLh3oT/HS8YHiBEbmNhitAyx5AzMz11xqCO@nongnu.org
X-Gm-Message-State: AOJu0Yya9Viqtked9HgP8ZUt7a5fUnkcy6yspRy/+Fo42Q9eFnbWDWw3
 c303oHMlpYIFkWt0eskxd/6gmxCn09SKZ3M2DbvKEOgRrgAZGAuL13Evd5Nj+jg=
X-Gm-Gg: ASbGncuHDem2YF9F6hTi2cfb5IOk8OwLdTeEO6cr+EjaNXqNXxONoODPwrXd+remnW3
 g1rOT+yzYajJy5u3fddibJSHDaSFKr0ZG1C6Yxgw7gjutLorIHGLg98RTajEyQ9fy1UuqTNlFiy
 Bk/crOBs4PDfXiFHfKMfPXrvmh9v2Gh9aEOxGujSUlvp+Tk6o4tOIYj1n3c5Jc+XpirC7BCs/a2
 6vpxEUtj3gZyNpO5zVspk2o0rXCPPu67WlluoysWyfZMY2k8xSLWC8CdcOI1O0O4zHkiwDfRB/H
 V4C9m6si3iF5qWP+pgbzveTW
X-Google-Smtp-Source: AGHT+IEZhgZfjLXTc2gBId8FRi+pRJAPvWZrGJ/KLSDwsfiH3lZocTi5+22wBybPWZ16rzBgboIweg==
X-Received: by 2002:a05:600c:4586:b0:434:f817:4492 with SMTP id
 5b1f17b1804b1-436e26f47f9mr66556085e9.31.1736423781255; 
 Thu, 09 Jan 2025 03:56:21 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da66e6sm53380935e9.4.2025.01.09.03.56.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:56:20 -0800 (PST)
Message-ID: <258e62c4-9e7f-432c-ace2-a5c459d8e016@linaro.org>
Date: Thu, 9 Jan 2025 12:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-13-shentey@gmail.com>
 <696c9a80-7311-4a95-ab3c-f85bc0b38e6e@linaro.org>
Content-Language: en-US
In-Reply-To: <696c9a80-7311-4a95-ab3c-f85bc0b38e6e@linaro.org>
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

On 9/1/25 12:43, Philippe Mathieu-Daudé wrote:
> On 8/1/25 10:25, Bernhard Beschow wrote:
>> Also print the MMIO address when tracing. This allows to 
>> distinguishing the
>> many instances a typical i.MX SoC has.

I'm not a fan of using peripheral address access, because it
can change i.e. when a vCPU is accessing it from secure or
non-secure mode.

I'd rather use an 'id', a 'name' or even the QOM (canonical?)
path.

Maybe we should directly cache that as Device::qom_path, so
all devices can use it for tracing, and we don't need to set
an id/name property when creating the device...

>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>>   hw/i2c/imx_i2c.c    | 21 +++++----------------
>>   hw/i2c/trace-events |  5 +++++
>>   2 files changed, 10 insertions(+), 16 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


