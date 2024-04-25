Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75413C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 07:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rztCU-0000pv-3B; Thu, 25 Apr 2024 03:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rztCO-0000lQ-G9
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:07:16 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rztCM-00053U-CM
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 03:07:15 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so575730a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714028832; x=1714633632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUZPhDjV+s0Yb2fXh7odflqQaoLZRSMDf9G/rtsOYwc=;
 b=zKBfjS2x8/13mbNlDQLW61wAIsp3a5U6iwhGAt6kno9BD3PGV9fC1QyHUG3gdg9QDD
 VRqYuEvkSIe5/URJmL+f4a6NMROTvuGPxoiW1TYHUPfF7YU+7HNtGb+HDVX67TP3pnuj
 vpEek8lPWPnaJnh72cKJ8h21u4UhhuMqaoDJDioknppJvh35JFvI7njORG6yaw9zJhmm
 9EcDAey8SN7LoVOO+J+r/3YgxEYecmr+IG9kDTr42+j6TuOWiaE/KThLtjv2UYNY7T9f
 MfuSW4UXVahVmLEpWFqaFqYLzU0AdCwcSIOf61fEdOjNlec2pqKRrtVtpcY0FaQFRqSn
 SHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714028832; x=1714633632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rUZPhDjV+s0Yb2fXh7odflqQaoLZRSMDf9G/rtsOYwc=;
 b=HB9a3aj1P2dP+EAI1CIDApbAy/4zT6K4uSde943rgJU749Pg1zp/QqHib2UxrPXbTc
 yDfZz79EXgj+rbIh/yBL97AR+4NNyNt4NXTZKQZApgFViXvoO1TS/lXZC/Wv05aXEjXw
 kwqBoVYO9TGWbrnuPL2NwnIw+uyvxAYhPkutVplMkg8D83XkUwepnTvcsTSLjdb2ROVF
 kiP8AhxJRgR1Xn9bjJOHMAoy5AuN9a+KielwJ9Xo9WN1L7bLqQ7UILLYZ4lo4PXIwm9Z
 DDkvt654wVtiDZSOnF44SS1KCHEDlWQ9VoRbd6OOEEqkMVu3/NLAGjv7D3f+sak8SMM7
 08Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUpBoYGu9YPm/rUF+bCk8AAkvcfygXGj2vv0XX1JHkVgXkC3tU1fJGF0H+RNBaPy3F6ond6H68LxqgpbSbFoqlRYGDeX4=
X-Gm-Message-State: AOJu0Yw8tIErCjvyWmRTDAqPztoybPQebWkl6AK8f2GYcgT/piNKhUQP
 tCQ20FcvYJwXqSIabBv/O3t0Sf6Ie5+UO4UgdHHVgHTqOnpKy0XSpREHyP35qMY=
X-Google-Smtp-Source: AGHT+IFE2vv2ND/88hrnLanI6ObvyZRETa+qdGlm8JmZLOzflbR+es5s1iORx6/NcmwJtldDTlwg6A==
X-Received: by 2002:a50:8ac1:0:b0:570:388:ee0b with SMTP id
 k1-20020a508ac1000000b005700388ee0bmr2967932edk.42.1714028832538; 
 Thu, 25 Apr 2024 00:07:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a50cbcb000000b0057030326144sm8652117edi.47.2024.04.25.00.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 00:07:12 -0700 (PDT)
Message-ID: <06b24f76-8cfe-4f4d-8746-f153e71d87a3@linaro.org>
Date: Thu, 25 Apr 2024 09:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/i386/x86: Eliminate two if statements in
 x86_bios_rom_init()
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
 <20240422200625.2768-4-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240422200625.2768-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
> Given that memory_region_set_readonly() is a no-op when the readonlyness is
> already as requested it is possible to simplify the pattern
> 
>    if (condition) {
>      foo(true);
>    }
> 
> to
> 
>    foo(condition);
> 
> which is shorter and allows to see the invariant of the code more easily.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/x86.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


