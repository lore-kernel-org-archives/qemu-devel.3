Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B2910F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GWa-0005dD-R6; Fri, 27 Mar 2026 19:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GWW-0005cz-MP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:23:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GWU-0006ZW-W4
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:23:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-486fe655187so30947765e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653805; x=1775258605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W2/gOOKoMrQUy+L9lJpCpmUT/jIZgAqDu7oe8h12NpE=;
 b=MB0HqaUXFiRytV1D5pcne12OuKUgLeUAh+sD4wWdCqyDOI32AM56ToEDQXPYh80DXf
 wTKd4hFIGo/KX5uYYID53eafkZK4VBH6GolC7aEty6o4BQ7P9naX6IWztAy0qZ6R0b2W
 FEurxnoqduNQkOIKjjjCOe79ExNCi4zEz9OShzY9PrbYjI/ks9Ed5XEF9EGvuT/FrNKV
 IVk1zTAucMo+qLFgGx2UTfR2vUCjj3Vxvo0vDCumYZLlk9bEx6Tk2hVb4yO9yE1w50OY
 AkTtL/zfHOEcvKY3pDyMEohykaCgjByophUin27G6ncNdkuuCXeiqkh62PrF1RDAZVyk
 9bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653805; x=1775258605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W2/gOOKoMrQUy+L9lJpCpmUT/jIZgAqDu7oe8h12NpE=;
 b=hdUlP5Q63dObyxe1kvuYN+QBBB3pvNWfbOtUKv+A6QW4hO/mchsf4YJXAbTmZ2Z3yS
 VvGpvZIDN2ZnDGMR/lpAvP624lXAxJUw7X5ZKQB4W5SmaizTirnwjVvsa5P4UdE0hYEW
 xWOkFR4xb348kkaVgug3UaNU3l6KuYiWhMOtMrYtqDQgSqPx79lugwFcrKmSLWq0hnND
 NhwEqPAhCclUe/ioIGlXErKhV8jgDJ0/aonmBg3QkvOv6Fvw5MqnwDUde8RcGoFORreA
 lrpAuBrlNOam4/gnpq3AuEC4yKNKmYelaNQkEIYxMoxiz3wCAbTH0F6LngApdb5UFz36
 qYlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8DvSRIarjs1K+AWQqKoDqxoiIOe5wDxSWhctRbWLUlPo/fg/MbNxcm3QlXUK4Bw/XlCtzGycoPGWn@nongnu.org
X-Gm-Message-State: AOJu0YwacsPqH9FsOOAWaiMOWafxLUNxS87AmEOgF8w2d2D/tj0elbGZ
 5QZ2/TQahZ6RtzdV5/8/f4GSMrcFcXSfDaPThm9c2DGX0PBXdLiZC3LwZRDGYbPBp9E=
X-Gm-Gg: ATEYQzwsg/BiP1OD7Uqj8sVNhtV0LJf9wFwX1oUJsv+THpucT6nsfcUQRVt3xsZ1EBV
 YHNMJW5/UdyJUlNmo5xQulwRpiI8z75JfB4Y5q9D8DmQKNb/LYJQtHpx7vpr2Om1r97a8XfRt1N
 k6Ln9Zzt7xMTamPcHCZ7qNisFYmLaCxEbc5T4tx27ynYa3sK3Ne3bphIIJveLUGWYUTWZwecr4J
 tkdTXcr6RCndIHcbPerJYgQnF4Wx8PokiU+5aS2oKbECEgpjJo7qdoNSQRmmQShxusOilIEiXrc
 Fq18wh8WTveP0Xe8/vSbXgnAEiu1jamjYE6XxMB4TGOdlksKKjwR/2hbtNEMDw9K46yAF8LC8QQ
 SqdAjxN5fsEGyQyFRAHMujVI9EPATN+yDp3nTEP97CwU4VSVsajjskuqb6AlFdYNMLSicQ4A2ya
 Nn94F2AKO6FSMrpKj3wWfbyIIOQMk3B7XWC/xlLjHALNnr2QliI0WOW0e5czh8Ew==
X-Received: by 2002:a05:600c:a12:b0:485:3b50:fe54 with SMTP id
 5b1f17b1804b1-48727d631bamr75483275e9.11.1774653804870; 
 Fri, 27 Mar 2026 16:23:24 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872719627esm29378535e9.33.2026.03.27.16.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:23:24 -0700 (PDT)
Message-ID: <bd65303b-6817-4abd-808b-94430e69b1cb@linaro.org>
Date: Sat, 28 Mar 2026 00:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] ncr710: reuse ncr710_clear_pending_irq in
 ncr10_do_command
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20260327212547.460420-1-pbonzini@redhat.com>
 <20260327212547.460420-10-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327212547.460420-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 27/3/26 22:25, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/scsi/ncr53c710.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

