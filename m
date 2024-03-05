Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F00BC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 15:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhX6Q-0002ED-Vw; Tue, 05 Mar 2024 10:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhX60-00021z-23
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:52:49 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhX5x-0007fF-8x
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 10:52:47 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d18931a94so3429324f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 07:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709653962; x=1710258762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oIFScl+zvY7P2YoZvUqNDE3f/+V8eMmCiywJsrolFCw=;
 b=WXo1UN6XOM0e9ovxTppa1LwhdgSAsSPob3cip52AlvhjZTcvniXyfCFYpeGS84dY9W
 TEhwxZ4wM+UaIasREkAqGVGVIGA0CMhVoYRMcczBvsrIj2YVIM1I6Y/u6tdfkuLh6d22
 WZFpV0x3Y/FaqFQd01tKL75VrI2DoP0j7UCK5gSMZbW3QYochrN9kEnwU9X6dDBLlbSJ
 9zAKYEmgLIQ1OBx14CKzngG5jElIa5JsP7Af18jiYLrvGAMJa6TEZkFBGsjdfp7q94Tb
 EPMqKEJkk6l9j3X/yQjncSwk/n+xEJBhIJgEWxRxVeyXMggpDAQ6AaKcPDbw80GWrIbe
 28WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709653962; x=1710258762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oIFScl+zvY7P2YoZvUqNDE3f/+V8eMmCiywJsrolFCw=;
 b=JIBsbKurm/x2bjNxV8iM0v16Gslvt5rGvyKGjVaSUJKiP4buQ4v/G2k5S2xSBNPFtr
 qoSZOCjRwU3AHN45do3GziJXzOCusqixHBe4W9TiHEy5QCVWkrq2i7yL/X//HYRhSDHg
 EHX/G9VaTOiMgsI6WQJ6Df99Rp5QZ9cVGJUMzGcVKIpXdpTAo6W/3NjmS8CEFtNGZg+3
 mLpjG/dj44G9OvPdLMdgPitY2iBCzNKToRl4/ta6kdjz7ioiS8YXvyiIlZiCMCsGXRkj
 G//HuWzx16+fgLPwit3DJDOkewnC0k6+ghhJThLCk5Abq21u/Alr7IaL9UGhDYhM02sb
 nqig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWnkB0Qefc6+2bQKuZtf4JDB9YqemUw+FpIeAj+eJ/GscmdhY80hhNhbdNN6bcnsRy5fDoAIAmZgBULH33m+huvkku7sE=
X-Gm-Message-State: AOJu0YyOugFx/0UG7wT+z8iyzhp3pw/5KbmRZ56MbEQ6WeoCzm5OJAeT
 X3Yodbr6661rEH7o0W/QaElLO8MVm5Z04/Xvm/hNXqH3hrPEI3b8LG4OKoNFMtQ=
X-Google-Smtp-Source: AGHT+IH4v0ZWENAqOPz4OTfnsLqlPObdD4gMXBuBURAV5RoCSQv8uA6dq3Dd3b6vD6AYT2r+gLH0pw==
X-Received: by 2002:a5d:49ca:0:b0:33e:4750:2250 with SMTP id
 t10-20020a5d49ca000000b0033e47502250mr2304633wrs.62.1709653962430; 
 Tue, 05 Mar 2024 07:52:42 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 j3-20020adff003000000b0033e01e397d6sm15208015wro.54.2024.03.05.07.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 07:52:41 -0800 (PST)
Message-ID: <51be958b-8795-4d53-9a80-9bf4cdb9cf22@linaro.org>
Date: Tue, 5 Mar 2024 16:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/i386/pc: Avoid one use of the current_machine
 global
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20240303185332.1408-1-shentey@gmail.com>
 <20240303185332.1408-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240303185332.1408-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 3/3/24 19:53, Bernhard Beschow wrote:
> The RTC can be accessed through the X86 machine instance, so rather than passing
> the RTC it's possible to pass the machine state instead. This avoids
> pc_boot_set() from having to access the current_machine global.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


