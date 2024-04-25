Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50DEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztBZ-00086V-La; Thu, 25 Apr 2024 03:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rztBO-00082m-9M
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:06:15 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rztBM-0004so-JN
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:06:14 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dd6a7ae2dcso8460761fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 00:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714028770; x=1714633570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ya5Bsnwx0mCTDAjct6O3yvTJBKsJG7q/j0wFCdUMmU0=;
 b=mgJUl+CtV988Ydhp6jd4LUiBcfFCApkB0JeUJhOyx1E3BfSLeV9glyfvXCJsF6hZ4T
 o0yBAe/5J9zRfKMoX6hgmrn59BGfEydNzRUvx6nu+PrxhPcROm8GBmRJZAdxwXKg3vdV
 p7GPdwvzA9+JVlrbIFagsGWpf8XKFmcB7sLv+YnK5R2yFlrtwWz9bV+VpH8MfIFVBo/z
 ZJsvLN5urjInYx3bpsv27I38/QHbQ8z9bxYskYEGMK04NCS8vRyke7H2+jpEBYleQGc1
 viOOBEwV/Ap/A85vq58OFj5qNd5CGJ2XMN2DhmbA8ER3gX/r910BJ+NGGgsq26/zmVpk
 VL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714028770; x=1714633570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ya5Bsnwx0mCTDAjct6O3yvTJBKsJG7q/j0wFCdUMmU0=;
 b=IgitAoh8IQNYCPALgAFSri2olZgVGpTtaIP2lTc/OYWtz/ubacLPAwWOxdt/cckBCg
 bwgV4qS1pcSAwwmq/kVit+VhS3Ja7pbBwXgSy33vu9PTWFMmQ9qqFuhoKFAEIXxF/rgO
 GXsvuwtmm5KPdY7YZea8xenBgrbPGNjZNcADOJj32oHVeW8zBypcKQdS6kOBjv9b6hxD
 snZrSj4llakYf/n64ZObQT6O7pVscoNRLTT+l3PkT613rFExaWyvo8v+u+HClXTqfCC9
 /md765P65PDx7Z0i+yT9iURUFb0yXcq0G4FO/R3OHrCcavacYvS1KlHw6VbKrNwWduWv
 mVjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjE6rqADwfIb0+5JczYd0vMIiZz0L9ePZxFixEmNrb1oay7PRXMLo2LML/5clPTft3WepXqgZS/gF8X/Z8dUjw+m7xD7c=
X-Gm-Message-State: AOJu0YxorHNIOZVAZLjqIvqNlseQsRbQvC9b7lvywO5JLLrDsZ1hDS64
 RZKpboP/2enHDFazWV2GYcmQCqc6xjDe+Pdxqvi8AqImqUBsujy8JHdSQfN2YZhVyFcnxIkHqZV
 m
X-Google-Smtp-Source: AGHT+IH6oNG4RVzYfuxI/edKrgwDwIczXHreQDUVi9YwjuUb8LzxqjRqsmKBPr8TQ4Tgu5DtbDTEow==
X-Received: by 2002:a2e:7d11:0:b0:2d8:6a04:3bcd with SMTP id
 y17-20020a2e7d11000000b002d86a043bcdmr3812084ljc.3.1714028770565; 
 Thu, 25 Apr 2024 00:06:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a170906c28c00b00a58be31e9f2sm39513ejz.192.2024.04.25.00.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 00:06:10 -0700 (PDT)
Message-ID: <7bfad576-38d3-4101-b599-bd0b6ee639af@linaro.org>
Date: Thu, 25 Apr 2024 09:06:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/i386/pc_sysfw: Remove unused parameter from
 pc_isa_bios_init()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
 <20240422200625.2768-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422200625.2768-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 22/4/24 22:06, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_sysfw.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


